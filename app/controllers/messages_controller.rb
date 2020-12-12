class MessagesController < ApplicationController
  def index
    @message = Message.new
    @room = Room.find(params[:room_id])
    @message = @room.message.includes(:user)
  end

  def create
    @room = Room.find(params[:room_id])
    @message = @room.message.new(message_params)
    if @message.save
      redirect_to room_message_path(@room)
    else
      @message = @room.messages.includes(:user)
      render :index
    end
  end

  private

  def message_params
    params.require(:message).permit(:content).merge(user_id: current_user.id)
  end
end

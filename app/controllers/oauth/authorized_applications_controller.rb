# frozen_string_literal: true

class Oauth::AuthorizedApplicationsController < Doorkeeper::AuthorizedApplicationsController
  skip_before_action :authenticate_resource_owner!

  before_action :store_current_location
  before_action :authenticate_resource_owner!

  include Localized

  def destroy
    Web::PushSubscription.unsubscribe_for(params[:id], current_resource_owner)
    super
  end

  private

  def store_current_location
    store_location_for(:user, request.url)
  end
end

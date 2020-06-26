# Versioned Dependency Component for Google OR Framework

require 'fileutils'
require 'java_buildpack/component/versioned_dependency_component'
require 'java_buildpack/framework'
require 'java_buildpack/util/qualify_path'

module JavaBuildpack
  module Framework

    # Encapsulates the functionality for enabling zero-touch AppDynamics support.
    class GoogleORFramework < JavaBuildpack::Component::VersionedDependencyComponent

      def initialize(context)
        super(context)
        @logger = JavaBuildpack::Logging::LoggerFactory.instance.get_logger GoogleORFramework
      end

      # (see JavaBuildpack::Component::BaseComponent#compile)
      def compile
        #download_tar(false, @droplet.sandbox, 'Google OR Framework')
        download_tar
        @droplet.copy_resources
      end

      # (see JavaBuildpack::Component::BaseComponent#release)
      def release
      @droplet.environment_variables
          .add_environment_variable('LD_LIBRARY_PATH',
                                    "$LD_LIBRARY_PATH:#{qualify_path(lib, @droplet.root)}")
          .add_environment_variable('GOOGLE_OR_HOME', @droplet.sandbox)
      end

      def lib
        @droplet.sandbox + 'lib'
      end

      def supports?
        return true
      end

    end
  end
end


#/bin/bash
# This script works with Wazuh on opensearch
# Supports RedHat and Debian families
# Compatible with systemd
# Copied from stable branch v4.3 and modified
# Tested on raw echo version, no commands were run
# TODO:
#   - uninstall/cleanup per service
set -eu

echo "Welcome to wazuh-purge script for Wazuh v4.3"
echo "Would you like to just uninstall Wazuh server packages (remove packages and stop, disable services) or do a total cleanup (clean up all wazuh component files)?"
echo "Choose from options below:"
echo "- uninstall"
echo "- cleanup"
read cleanup_type

case $cleanup_type in

  uninstall)
    # Remove dashboard
    echo -e "\e[36;5;82mDisabling wazuh-dashboard service...\e[0m"
    systemctl stop wazuh-dashboard
    systemctl disable wazuh-dashboard
    systemctl daemon-reload
    echo -e "\e[36;5;82mRemoving wazuh-dashboard...\e[0m"
    if $(which yum 2>/dev/null >/dev/null); then
        yum remove wazuh-dashboard -y
    else
        apt-get remove wazuh-dashboard -y
    fi
    echo -e "\e[38;5;82mRemoved wazuh-dashboard.\e[0m"
    
    # Remove server
    echo -e "\e[36;5;82mDisabling wazuh-manager service...\e[0m"
    systemctl stop wazuh-manager
    systemctl disable wazuh-manager
    systemctl daemon-reload
    echo -e "\e[36;5;82mRemoving wazuh-manager...\e[0m"
    if $(which yum 2>/dev/null >/dev/null); then
        yum remove wazuh-manager -y
    else
        apt-get remove wazuh-manager -y
    fi
    echo -e "\e[38;5;82mRemoved wazuh-manager.\e[0m"
    
    # Remove filebeat
    echo -e "\e[36;5;82mDisabling filebeat service...\e[0m"
    systemctl stop filebeat
    systemctl disable filebeat
    systemctl daemon-reload
    echo -e "\e[36;5;82mRemoving filebeat...\e[0m"
    if $(which yum 2>/dev/null >/dev/null); then
        yum remove filebeat -y
    else
       apt-get remove filebeat -y
    fi
    echo -e "\e[38;5;82mRemoved filebeat.\e[0m"
    
    # Remove indexer
    echo -e "\e[36;5;82mDisabling wazuh-indexer service...\e[0m"
    systemctl stop wazuh-indexer
    systemctl disable wazuh-indexer
    systemctl daemon-reload
    echo -e "\e[36;5;82mRemoving wazuh-indexer...\e[0m"
    if $(which yum 2>/dev/null >/dev/null); then
        yum remove wazuh-indexer -y
    else
        apt-get remove wazuh-indexer -y
    fi
    echo -e "\e[38;5;82mRemoved wazuh-indexer.\e[0m"
    echo -e "\e[38;5;82mAll wazuh server components removed successfully.\e[0m"
    ;;

  cleanup)
    # Remove dashboard
    echo -e "\e[36;5;82mDisabling wazuh-dashboard service...\e[0m"
    systemctl stop wazuh-dashboard
    systemctl disable wazuh-dashboard
    systemctl daemon-reload
    echo -e "\e[36;5;82mRemoving wazuh-dashboard and files...\e[0m"
    if $(which yum 2>/dev/null >/dev/null); then
        yum remove wazuh-dashboard -y
        rm -rf /var/lib/wazuh-dashboard/
        rm -rf /usr/share/wazuh-dashboard/
        rm -rf /etc/wazuh-dashboard/
    else
        apt-get remove --purge wazuh-dashboard -y
    fi
    echo -e "\e[38;5;82mRemoved wazuh-dashboard.\e[0m"
    
    # Remove server
    echo -e "\e[36;5;82mDisabling wazuh-manager service...\e[0m"
    systemctl stop wazuh-manager
    systemctl disable wazuh-manager
    systemctl daemon-reload
    echo -e "\e[36;5;82mRemoving wazuh-manager and files...\e[0m"
    if $(which yum 2>/dev/null >/dev/null); then
        yum remove wazuh-manager -y
        rm -rf /var/ossec/
    else
        apt-get remove --purge wazuh-manager -y
    fi
    echo -e "\e[38;5;82mRemoved wazuh-manager.\e[0m"
    
    # Remove filebeat
    echo -e "\e[36;5;82mDisabling filebeat service...\e[0m"
    systemctl stop filebeat
    systemctl disable filebeat
    systemctl daemon-reload
    echo -e "\e[36;5;82mRemoving filebeat and files...\e[0m"
    if $(which yum 2>/dev/null >/dev/null); then
        yum remove filebeat -y
        rm -rf /var/lib/filebeat/
        rm -rf /usr/share/filebeat/
        rm -rf /etc/filebeat/
    else
        apt-get remove --purge filebeat -y
    fi
    echo -e "\e[38;5;82mRemoved filebeat.\e[0m"
    
    # Remove indexer
    echo -e "\e[36;5;82mDisabling wazuh-indexer service...\e[0m"
    systemctl stop wazuh-indexer
    systemctl disable wazuh-indexer
    systemctl daemon-reload
    echo -e "\e[36;5;82mRemoving wazuh-indexer and files...\e[0m"
    if $(which yum 2>/dev/null >/dev/null); then
        yum remove wazuh-indexer -y
        rm -rf /var/lib/wazuh-indexer/
        rm -rf /usr/share/wazuh-indexer/
        rm -rf /etc/wazuh-indexer/
    else
        apt-get remove --purge wazuh-indexer -y
    fi
    echo -e "\e[38;5;82mRemoved wazuh-indexer.\e[0m"
    echo -e "\e[38;5;82mAll wazuh server components removed successfully.\e[0m"
    ;;

  *)
    echo -e "Unknown option, please choose \e[38;5;82muninstall\e[0m or \e[38;5;82mcleanup\e[0m."
    ;;
esac

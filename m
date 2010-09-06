From: "J. Bakshi" <joydeep@infoservices.in>
Subject: git over http configuration problem
Date: Mon, 6 Sep 2010 12:01:44 +0530
Message-ID: <20100906120144.19b2923c@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 06 08:31:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsVFE-0002l1-JT
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 08:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752564Ab0IFGbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 02:31:51 -0400
Received: from static.206.87.46.78.clients.your-server.de ([78.46.87.206]:44175
	"EHLO Kolkata.infoservices.in" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752471Ab0IFGbv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 02:31:51 -0400
Received: from debian (unknown [122.176.30.116])
	by Kolkata.infoservices.in (Postfix) with ESMTPSA id 40C0966A974
	for <git@vger.kernel.org>; Mon,  6 Sep 2010 08:31:47 +0200 (CEST)
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155536>


Hello,

I am a newbie in git technology, please bear with me. I am interested to implement git over http along with gitweb.

At first I have already created a demo git repository in the server , After restating apache I can see gitweb at http://192.168.1.1/gitweb 
Here is the apache related configuration

```````````````
Alias /gitweb /var/gitdir/
RewriteEngine On
RewriteRule ^gitweb$ gitweb/ [R]
SetEnv GITWEB_CONFIG /etc/gitweb.conf

<Directory "/var/gitdir/">
AllowOverride AuthConfig
Options +ExecCGI +Indexes
Order allow,deny
Allow from all
DirectoryIndex gitweb.cgi
SetEnv GITWEB_CONFIG "/etc/gitweb.conf"
AddHandler cgi-script .cgi
</Directory>
``````````````````````````

webdav is successfully running in this server for some other project. I have setup webdav for git like

`````````
<IfModule mod_dav_svn.c>
<Location /myproject.git>
Dav on
AuthType Basic
AuthName "My repo with git"
AuthUserFile /home/svn/PASSWORD
<Limitexcept GET HEAD PROPFIND OPTIONS REPORT>
Require valid-user
</Limitexcept>
</Location>
</IfModule>
```````````````

Now testing with cadaver

`````````````````
cadaver https://192.168.1.1/gitweb/test.git

Authentication required for Write access requires a password on server `192.168.1.1':
Username: svnadmin
Password:
Could not open collection:
404 Not Found

``````````````````````

I think there are some configuration problem which can't find the correct location/path. Could anyone kindly enlighten me, actually where the problem is ? Here is /etc/gitweb.conf

````````````````````````
$feature{'blame'}{'default'} = [undef];
$feature{'pickaxe'}{'default'} = [undef];
$feature{'search'}{'default'} = [undef];
$feature{'grep'}{'default'} = 1;
$feature{'snapshot'}{'default'} = ['tgz', 'gzip', 'zip'];
$feature{'snapshot'}{'override'} = 1;

# path to git projects (<project>.git)
$projectroot = "/home/git";

# directory to use for temp files
$git_temp = "/tmp";

$projects_list = $projectroot;
$export_ok = "";
$strict_export = "true";

$site_name = "The Average Geek's Git Repo";
$fallback_encoding = 'utf-8';
@stylesheets = ("gitweb.css");
$projects_list_description_width = 50;
``````````````````````````````````

Thanks for your time

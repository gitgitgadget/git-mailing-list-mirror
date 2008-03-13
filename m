From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Documentation: help: explain 'man.viewer' multiple values
Date: Thu, 13 Mar 2008 06:48:46 +0100
Message-ID: <20080313064846.b6b54c11.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Pascal Obry <pascal@obry.net>,
	Xavier Maillard <xma@gnu.org>,
	=?UTF-8?Q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97?=
	 =?UTF-8?Q?=E3=81=AA=E3=81=AA=E3=81=93?=
X-From: git-owner@vger.kernel.org Thu Mar 13 06:43:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZgEK-0000Jc-4c
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 06:43:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbYCMFnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 01:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbYCMFnI
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 01:43:08 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:53620 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751369AbYCMFnH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 01:43:07 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 44B891AB2B0;
	Thu, 13 Mar 2008 06:43:05 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 8FAC01AB2BE;
	Thu, 13 Mar 2008 06:43:04 +0100 (CET)
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77037>

Also add titles to paragraphs under "CONFIGURATION VARIABLES".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config.txt   |    2 +-
 Documentation/git-help.txt |   29 ++++++++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f64b269..c72c2e6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -749,7 +749,7 @@ log.showroot::
 	normally hide the root commit will now show it. True by default.
 
 man.viewer::
-	Specify the program that will be used to display help in the
+	Specify the programs that may be used to display help in the
 	'man' format. See linkgit:git-help[1].
 
 merge.summary::
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 73a51ae..89f6d25 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -43,7 +43,7 @@ OPTIONS
 +
 By default the 'man' program will be used to display the manual page,
 but the 'man.viewer' configuration variable may be used to choose
-another display program (see below).
+other display programs (see below).
 
 -w|--web::
 	Display manual page for the command in the 'web' (HTML)
@@ -58,6 +58,9 @@ linkgit:git-web--browse[1] for more information about this.
 CONFIGURATION VARIABLES
 -----------------------
 
+help.format
+~~~~~~~~~~~
+
 If no command line option is passed, the 'help.format' configuration
 variable will be checked. The following values are supported for this
 variable; they make 'git-help' behave as their corresponding command
@@ -67,11 +70,17 @@ line option:
 * "info" corresponds to '-i|--info',
 * "web" or "html" correspond to '-w|--web'.
 
+help.browser, web.browser and browser.<tool>.path
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
 The 'help.browser', 'web.browser' and 'browser.<tool>.path' will also
 be checked if the 'web' format is chosen (either by command line
 option or configuration variable). See '-w|--web' in the OPTIONS
 section above and linkgit:git-web--browse[1].
 
+man.viewer
+~~~~~~~~~~
+
 The 'man.viewer' config variable will be checked if the 'man' format
 is chosen. Only the following values are currently supported:
 
@@ -80,6 +89,24 @@ is chosen. Only the following values are currently supported:
 (this only works starting with emacsclient versions 22),
 * "konqueror": use a man KIO slave in konqueror.
 
+Multiple values may be given to this configuration variable. Their
+corresponding programs will be tried in the order listed in the
+configuration file.
+
+For example the following configuration:
+
+[man]
+	viewer = konqueror
+	viewer = woman
+
+will try to use konqueror first. But this may fail (for example if
+DISPLAY is not set) and in that case emacs' woman mode will be tried.
+
+If everythings fails the 'man' program will be tried anyway.
+
+Note about git config --global
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
 Note that all these configuration variables should probably be set
 using the '--global' flag, for example like this:
 
-- 
1.5.4.3.395.g492b.dirty

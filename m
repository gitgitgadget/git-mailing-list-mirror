From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [GIT GUI PATCH] git-gui: open console when using --trace on windows
Date: Fri, 23 Mar 2012 18:46:27 +0100
Message-ID: <242ca34168d568a493306f673e98b9019cee9c23.1332524700.git.hvoigt@hvoigt.net>
Cc: git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Mar 23 18:46:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB8ZP-0002sX-SV
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 18:46:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757337Ab2CWRqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 13:46:30 -0400
Received: from darksea.de ([83.133.111.250]:33268 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756597Ab2CWRqa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 13:46:30 -0400
Received: (qmail 14424 invoked from network); 23 Mar 2012 18:46:28 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 23 Mar 2012 18:46:28 +0100
X-Mailer: git-send-email 1.7.10.rc1.28.g242ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193780>

When starting a gui program on windows stdout, stderr and stdin are not
connected to the cmd console. As a workaround tk has a console window.
Lets open this when the --trace commandline option has been given.
This is helpful for debugging.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 git-gui/git-gui.sh |    1 +
 1 file changed, 1 insertion(+)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index ba4e5c1..7dddc7d 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -154,6 +154,7 @@ set _trace [lsearch -exact $argv --trace]
 if {$_trace >= 0} {
 	set argv [lreplace $argv $_trace $_trace]
 	set _trace 1
+	if {[tk windowingsystem] eq "win32"} { console show }
 } else {
 	set _trace 0
 }
-- 
1.7.10.rc1.28.g242ca

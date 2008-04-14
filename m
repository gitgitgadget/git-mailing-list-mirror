From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] gitk: Makefile/install: force permissions when installing
	files and dirs
Date: Mon, 14 Apr 2008 08:27:09 +0000
Message-ID: <20080414082709.14951.qmail@abeaeea100406a.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Apr 14 10:28:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlK2h-0005lf-6p
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 10:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755642AbYDNI1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 04:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755466AbYDNI1N
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 04:27:13 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:51210 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755601AbYDNI1N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 04:27:13 -0400
Received: (qmail 14952 invoked by uid 1000); 14 Apr 2008 08:27:09 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79491>

The msg-files msgs/*.msg used to be installed with mode 755 although
they're not executables.  With this commit, files are forced to be
installed with mode 644, directories and executables with mode 755.
---
 Makefile |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index f90dfab..e1b6045 100644
--- a/Makefile
+++ b/Makefile
@@ -40,9 +40,9 @@ endif
 all:: gitk-wish $(ALL_MSGFILES)
 
 install:: all
-	$(INSTALL) gitk-wish '$(DESTDIR_SQ)$(bindir_SQ)'/gitk
-	$(INSTALL) -d '$(DESTDIR_SQ)$(msgsdir_SQ)'
-	$(foreach p,$(ALL_MSGFILES), $(INSTALL) $p '$(DESTDIR_SQ)$(msgsdir_SQ)' &&) true
+	$(INSTALL) -m 755 gitk-wish '$(DESTDIR_SQ)$(bindir_SQ)'/gitk
+	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(msgsdir_SQ)'
+	$(foreach p,$(ALL_MSGFILES), $(INSTALL) -m 644 $p '$(DESTDIR_SQ)$(msgsdir_SQ)' &&) true
 
 uninstall::
 	$(foreach p,$(ALL_MSGFILES), $(RM) '$(DESTDIR_SQ)$(msgsdir_SQ)'/$(notdir $p) &&) true
-- 
1.5.5

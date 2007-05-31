From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Make the installation target of git-gui a little less chatty
Date: Fri, 1 Jun 2007 00:25:27 +0200
Message-ID: <20070531222527.GB12204@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jun 01 00:25:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Htt5L-0004N9-7Y
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 00:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753218AbXEaWZa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 18:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753275AbXEaWZa
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 18:25:30 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:46817 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218AbXEaWZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 18:25:29 -0400
Received: from tigra.home (Fac85.f.strato-dslnet.de [195.4.172.133])
	by post.webmailer.de (klopstock mo50) (RZmta 6.8)
	with ESMTP id B05597j4VJUCV0 ; Fri, 1 Jun 2007 00:25:28 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id EE663277BD;
	Fri,  1 Jun 2007 00:25:27 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id C89B4BE86; Fri,  1 Jun 2007 00:25:27 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzzcFzytn4=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48823>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

The patch is hand-tuned to start in git-gui, so that it can be applied
in git-gui repo.

 Makefile |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 3de0de1..1eafbf8 100644
--- a/Makefile
+++ b/Makefile
@@ -2,6 +2,10 @@ all::
 
 # Define V=1 to have a more verbose compile.
 #
+QUIET =
+ifndef V
+    QUIET = @
+endif
 
 GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -109,12 +113,13 @@ GIT-GUI-VARS: .FORCE-GIT-GUI-VARS
 all:: $(ALL_PROGRAMS) lib/tclIndex
 
 install: all
-	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(gitexecdir_SQ)'
-	$(INSTALL) git-gui '$(DESTDIR_SQ)$(gitexecdir_SQ)'
-	$(foreach p,$(GITGUI_BUILT_INS), rm -f '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' && ln '$(DESTDIR_SQ)$(gitexecdir_SQ)/git-gui' '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' ;)
-	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(libdir_SQ)'
-	$(INSTALL) -m644 lib/tclIndex '$(DESTDIR_SQ)$(libdir_SQ)'
-	$(foreach p,$(ALL_LIBFILES), $(INSTALL) -m644 $p '$(DESTDIR_SQ)$(libdir_SQ)' ;)
+	@echo installing git-gui
+	$(QUIET)$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(gitexecdir_SQ)'
+	$(QUIET)$(INSTALL) git-gui '$(DESTDIR_SQ)$(gitexecdir_SQ)'
+	$(QUIET)$(foreach p,$(GITGUI_BUILT_INS), rm -f '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' && ln '$(DESTDIR_SQ)$(gitexecdir_SQ)/git-gui' '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' ;)
+	$(QUIET)$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(libdir_SQ)'
+	$(QUIET)$(INSTALL) -m644 lib/tclIndex '$(DESTDIR_SQ)$(libdir_SQ)'
+	$(QUIET)$(foreach p,$(ALL_LIBFILES), $(INSTALL) -m644 $p '$(DESTDIR_SQ)$(libdir_SQ)' ;)
 
 dist-version:
 	@mkdir -p $(TARDIR)
-- 
1.5.2.162.gbaa1f

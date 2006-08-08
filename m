From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] autoconf: clean temporary file mak.append
Date: Tue, 08 Aug 2006 13:43:24 -0700
Message-ID: <7vk65juff7.fsf@assigned-by-dhcp.cox.net>
References: <200608081834.09271.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 08 22:43:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAYQD-0004PP-Ph
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 22:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbWHHUn1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Aug 2006 16:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030267AbWHHUn1
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 16:43:27 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:59837 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1030202AbWHHUn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Aug 2006 16:43:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060808204326.DLDE27846.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 8 Aug 2006 16:43:26 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200608081834.09271.jnareb@gmail.com> (Jakub Narebski's message
	of "Tue, 8 Aug 2006 18:34:08 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25088>

When configure is interrupted in the middle it leaves
config.mak.append behind.  Add it to .gitignore and make sure
$(MAKE) clean removes it.

Also earlier .gitignore listed config.mak.in which is a tracked
file.  Fix it.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 * on top of today's 5 series from you.

 .gitignore |    2 +-
 Makefile   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitignore b/.gitignore
index fb0fa3f..6e973b3 100644
--- a/.gitignore
+++ b/.gitignore
@@ -140,7 +140,7 @@ config.mak
 autom4te.cache
 config.log
 config.status
-config.mak.in
 config.mak.autogen
+config.mak.append
 configure
 git-blame
diff --git a/Makefile b/Makefile
index d8cc835..d4297c2 100644
--- a/Makefile
+++ b/Makefile
@@ -793,7 +793,7 @@ clean:
 	rm -f $(ALL_PROGRAMS) $(BUILT_INS) git$X
 	rm -f *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags
 	rm -rf autom4te.cache
-	rm -f config.log config.mak.autogen configure config.status config.cache
+	rm -f configure config.log config.mak.autogen config.mak.append config.status config.cache
 	rm -rf $(GIT_TARNAME) .doc-tmp-dir
 	rm -f $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
 	rm -f $(htmldocs).tar.gz $(manpages).tar.gz
-- 
1.4.2.rc3.g45c5

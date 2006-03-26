From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Remove dependency on a file named "-lz"
Date: Mon, 27 Mar 2006 01:14:52 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0603270114200.17135@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Mar 27 01:15:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNeRo-0002r8-CR
	for gcvg-git@gmane.org; Mon, 27 Mar 2006 01:15:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWCZXO5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 18:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbWCZXO5
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 18:14:57 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:24255 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932185AbWCZXO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Mar 2006 18:14:56 -0500
Received: from virusscan.mail (mail03.mail [172.25.1.102])
	by mailrelay.mail (Postfix) with ESMTP id 854AD1392;
	Mon, 27 Mar 2006 01:14:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 78D3AAE8;
	Mon, 27 Mar 2006 01:14:53 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 50FB613ED;
	Mon, 27 Mar 2006 01:14:53 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18067>


By changing the dependency "$(LIB_H)" to "$(LIBS)", at least one version
of make thought that a file named "-lz" would be needed.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 Makefile |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

5a8333baa1845924348b958208bee59831d4e04e
diff --git a/Makefile b/Makefile
index a8cb0af..055d155 100644
--- a/Makefile
+++ b/Makefile
@@ -214,8 +214,8 @@
 	fetch-clone.o revision.o pager.o \
 	$(DIFF_OBJS)
 
-LIBS = $(LIB_FILE) $(XDIFF_LIB)
-LIBS += -lz
+GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
+LIBS = $(GITLIBS) -lz
 
 #
 # Platform specific tweaks
@@ -554,7 +554,7 @@
 		-DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"' $*.c
 
 $(LIB_OBJS): $(LIB_H)
-$(patsubst git-%$X,%.o,$(PROGRAMS)): $(LIBS)
+$(patsubst git-%$X,%.o,$(PROGRAMS)): $(GITLIBS)
 $(DIFF_OBJS): diffcore.h
 
 $(LIB_FILE): $(LIB_OBJS)
-- 
1.2.0.gd95e-dirty

From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Clean up Makefile
Date: Wed, 13 Apr 2005 17:55:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504131752410.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0504131556510.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 23:53:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLpmb-0007Bt-NJ
	for gcvg-git@gmane.org; Wed, 13 Apr 2005 23:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVDMVzk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Apr 2005 17:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVDMVzk
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Apr 2005 17:55:40 -0400
Received: from iabervon.org ([66.92.72.58]:26885 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261159AbVDMVz2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2005 17:55:28 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DLppr-0000l9-00; Wed, 13 Apr 2005 17:55:47 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <Pine.LNX.4.21.0504131556510.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Use a pattern rule for building executables, and a list of common objects
(which could be made into a library).

Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>

Index: Makefile
===================================================================
--- 833bb44b8e49daf0424f44cf300748da17945859/Makefile  (mode:100644 sha1:929aa49a3dbe683ad52094099797bc636a7949a6)
+++ 783978eb212c1402ba2612bb32626e93af78b72d/Makefile  (mode:100644 sha1:2b626ec05b2e29016d26b5cb7b4f82ec5c4e79d6)
@@ -20,6 +20,8 @@
 	gitmerge.sh gitpull.sh gitrm.sh gittag.sh gittrack.sh gitexport.sh \
 	gitapply.sh
 
+COMMON=	read-cache.o
+
 GEN_SCRIPT= gitversion.sh
 
 VERSION= VERSION
@@ -31,46 +33,8 @@
 
 LIBS= -lssl -lz
 
-init-db: init-db.o
-
-update-cache: update-cache.o read-cache.o
-	$(CC) $(CFLAGS) -o update-cache update-cache.o read-cache.o $(LIBS)
-
-show-diff: show-diff.o read-cache.o
-	$(CC) $(CFLAGS) -o show-diff show-diff.o read-cache.o $(LIBS)
-
-write-tree: write-tree.o read-cache.o
-	$(CC) $(CFLAGS) -o write-tree write-tree.o read-cache.o $(LIBS)
-
-read-tree: read-tree.o read-cache.o
-	$(CC) $(CFLAGS) -o read-tree read-tree.o read-cache.o $(LIBS)
-
-commit-tree: commit-tree.o read-cache.o
-	$(CC) $(CFLAGS) -o commit-tree commit-tree.o read-cache.o $(LIBS)
-
-cat-file: cat-file.o read-cache.o
-	$(CC) $(CFLAGS) -o cat-file cat-file.o read-cache.o $(LIBS)
-
-ls-tree: ls-tree.o read-cache.o
-	$(CC) $(CFLAGS) -o ls-tree ls-tree.o read-cache.o $(LIBS)
-
-checkout-cache: checkout-cache.o read-cache.o
-	$(CC) $(CFLAGS) -o checkout-cache checkout-cache.o read-cache.o $(LIBS)
-
-diff-tree: diff-tree.o read-cache.o
-	$(CC) $(CFLAGS) -o diff-tree diff-tree.o read-cache.o $(LIBS)
-
-fsck-cache: fsck-cache.o read-cache.o
-	$(CC) $(CFLAGS) -o fsck-cache fsck-cache.o read-cache.o $(LIBS)
-
-rev-tree: rev-tree.o read-cache.o
-	$(CC) $(CFLAGS) -o rev-tree rev-tree.o read-cache.o $(LIBS)
-
-show-files: show-files.o read-cache.o
-	$(CC) $(CFLAGS) -o show-files show-files.o read-cache.o $(LIBS)
-
-check-files: check-files.o read-cache.o
-	$(CC) $(CFLAGS) -o check-files check-files.o read-cache.o $(LIBS)
+$(PROG):%: %.o $(COMMON)
+	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
 
 read-cache.o: cache.h
 show-diff.o: cache.h

--	-Daniel
*This .sig left intentionally blank*


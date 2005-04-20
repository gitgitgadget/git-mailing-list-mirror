From: Andre Noll <maan@systemlinux.org>
Subject: simplify Makefile
Date: Wed, 20 Apr 2005 14:19:03 +0200
Message-ID: <20050420121903.GA8664@skl-net.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Apr 20 14:23:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOEE5-00019o-05
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 14:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVDTM0w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 08:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbVDTM0w
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 08:26:52 -0400
Received: from m18s25.vlinux.de ([83.151.29.59]:64677 "EHLO m18s25.vlinux.de")
	by vger.kernel.org with ESMTP id S261399AbVDTM0s (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 08:26:48 -0400
Received: from maan by m18s25.vlinux.de with local (Exim 3.35 #1 (Debian))
	id 1DOEAZ-0003Ti-00
	for <git@vger.kernel.org>; Wed, 20 Apr 2005 14:19:03 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Use a generic rule for executables that depend only on the corresponding
.o and on $(LIB_FILE).

Signed-Off-By: Andre Noll <maan@systemlinux.org>
---

Makefile |   49 ++-----------------------------------------------
 1 files changed, 2 insertions(+), 47 deletions(-)

Makefile: cd299f850679b2456e360d3aa6a2d529855ba7a5
--- a/Makefile
+++ b/Makefile
@@ -34,62 +34,17 @@ LIBS= $(LIB_FILE) -lssl -lz
 
 init-db: init-db.o
 
-update-cache: update-cache.o $(LIB_FILE)
-	$(CC) $(CFLAGS) -o update-cache update-cache.o $(LIBS)
-
-show-diff: show-diff.o $(LIB_FILE)
-	$(CC) $(CFLAGS) -o show-diff show-diff.o $(LIBS)
-
-write-tree: write-tree.o $(LIB_FILE)
-	$(CC) $(CFLAGS) -o write-tree write-tree.o $(LIBS)
-
-read-tree: read-tree.o $(LIB_FILE)
-	$(CC) $(CFLAGS) -o read-tree read-tree.o $(LIBS)
-
-commit-tree: commit-tree.o $(LIB_FILE)
-	$(CC) $(CFLAGS) -o commit-tree commit-tree.o $(LIBS)
-
-cat-file: cat-file.o $(LIB_FILE)
-	$(CC) $(CFLAGS) -o cat-file cat-file.o $(LIBS)
-
 fsck-cache: fsck-cache.o $(LIB_FILE) object.o commit.o tree.o blob.o
 	$(CC) $(CFLAGS) -o fsck-cache fsck-cache.o $(LIBS)
 
-checkout-cache: checkout-cache.o $(LIB_FILE)
-	$(CC) $(CFLAGS) -o checkout-cache checkout-cache.o $(LIBS)
-
-diff-tree: diff-tree.o $(LIB_FILE)
-	$(CC) $(CFLAGS) -o diff-tree diff-tree.o $(LIBS)
-
 rev-tree: rev-tree.o $(LIB_FILE) object.o commit.o tree.o blob.o
 	$(CC) $(CFLAGS) -o rev-tree rev-tree.o $(LIBS)
 
-show-files: show-files.o $(LIB_FILE)
-	$(CC) $(CFLAGS) -o show-files show-files.o $(LIBS)
-
-check-files: check-files.o $(LIB_FILE)
-	$(CC) $(CFLAGS) -o check-files check-files.o $(LIBS)
-
-ls-tree: ls-tree.o $(LIB_FILE)
-	$(CC) $(CFLAGS) -o ls-tree ls-tree.o $(LIBS)
-
 merge-base: merge-base.o $(LIB_FILE) object.o commit.o tree.o blob.o
 	$(CC) $(CFLAGS) -o merge-base merge-base.o $(LIBS)
 
-merge-cache: merge-cache.o $(LIB_FILE)
-	$(CC) $(CFLAGS) -o merge-cache merge-cache.o $(LIBS)
-
-unpack-file: unpack-file.o $(LIB_FILE)
-	$(CC) $(CFLAGS) -o unpack-file unpack-file.o $(LIBS)
-
-git-export: git-export.o $(LIB_FILE)
-	$(CC) $(CFLAGS) -o git-export git-export.o $(LIBS)
-
-diff-cache: diff-cache.o $(LIB_FILE)
-	$(CC) $(CFLAGS) -o diff-cache diff-cache.o $(LIBS)
-
-convert-cache: convert-cache.o $(LIB_FILE)
-	$(CC) $(CFLAGS) -o convert-cache convert-cache.o $(LIBS)
+%: %.o $(LIB_FILE)
+	$(CC) $(CFLAGS) -o $@ $< $(LIBS)
 
 blob.o: $(LIB_H)
 cat-file.o: $(LIB_H)

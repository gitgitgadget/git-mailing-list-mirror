X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Adapt to fuse in kernel 2.6.17
Date: Sun, 12 Nov 2006 19:45:19 +0100
Message-ID: <20061112184519.8713.7707.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 12 Nov 2006 18:45:50 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Virus-Scanned: amavisd-new at localhost.localdomain
User-Agent: StGIT/0.11
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31269>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjKKq-00037i-R0 for gcvg-git@gmane.org; Sun, 12 Nov
 2006 19:45:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752629AbWKLSph (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 12 Nov 2006
 13:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752636AbWKLSph
 (ORCPT <rfc822;git-outgoing>); Sun, 12 Nov 2006 13:45:37 -0500
Received: from [83.140.172.130] ([83.140.172.130]:46122 "EHLO
 torino.dewire.com") by vger.kernel.org with ESMTP id S1752629AbWKLSpg (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2006 13:45:36 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id 0C95B802806 for <git@vger.kernel.org>; Sun, 12 Nov
 2006 19:42:07 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 06519-05 for
 <git@vger.kernel.org>; Sun, 12 Nov 2006 19:42:06 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.2]) by torino.dewire.com
 (Postfix) with ESMTP id A9584802803 for <git@vger.kernel.org>; Sun, 12 Nov
 2006 19:42:04 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1]) by
 lathund.dewire.com (Postfix) with ESMTP id 4546028FC9 for
 <git@vger.kernel.org>; Sun, 12 Nov 2006 19:47:12 +0100 (CET)
Received: from lathund.dewire.com ([127.0.0.1]) by localhost
 (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025) with LMTP id
 7iIfzAPp30S8 for <git@vger.kernel.org>; Sun, 12 Nov 2006 19:47:09 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1]) by
 lathund.dewire.com (Postfix) with ESMTP id A8DE628BC8 for
 <git@vger.kernel.org>; Sun, 12 Nov 2006 19:47:09 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

From: Robin Rosenberg <robin.rosenberg@dewire.com>


---

 Makefile   |    2 +-
 api-fuse.c |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 8668a03..e80661f 100644
--- a/Makefile
+++ b/Makefile
@@ -5,7 +5,7 @@ GITCFLAGS = '-DSHA1_HEADER=<openssl/sha.
 GITLDFLAGS = $(GITDIR)/libgit.a -lcrypto -lz
 
 # What flags are required to build against FUSE
-FUSECFLAGS = '-DFUSE_HEADER="/usr/src/linux-2.6.14.4/include/linux/fuse.h"'
+FUSECFLAGS = '-DFUSE_HEADER="/usr/src/linux-2.6.17-5mdv/include/linux/fuse.h"'
 
 OBJS = gitobj.o api-fuse.o gnode.o topdir.o util.o tagdir.o autotree.o \
        gitdir.o main.o worktree.o openfile.o gitworker.o rbtree.o pcbuf.o \
diff --git a/api-fuse.c b/api-fuse.c
index aba5088..28c5da0 100644
--- a/api-fuse.c
+++ b/api-fuse.c
@@ -146,7 +146,7 @@ struct fuse_out {
 		struct fuse_write_out write;
 		struct fuse_statfs_out statfs;
 		struct fuse_getxattr_out getxattr;
-		struct fuse_init_in_out init;
+		struct fuse_init_in init;
 		char read[0];
 	} arg;
 };
@@ -307,7 +307,7 @@ struct fuse_in {
 			struct fuse_getxattr_in chdr;
 			char name[0];
 		} getxattr;
-		struct fuse_init_in_out init;
+		struct fuse_init_in init;
 		/*
 		 * lookup, unlink, rmdir, and removexattr just take a
 		 * string; no per-command header.  symlink takes two
@@ -980,7 +980,7 @@ enum service_result api_service_poll(voi
 {
 	union {
 		struct fuse_in f;
-		unsigned char storage[FUSE_MAX_IN];
+		unsigned char storage[FUSE_MIN_READ_BUFFER];
 	} in;
 	int rv = read(fuse_fd, in.storage, sizeof(in.storage));

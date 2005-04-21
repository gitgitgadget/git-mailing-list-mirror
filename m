From: Brad Roberts <braddr@gameboy2.puremagic.com>
Subject: [PATCH 14/19] move cache_header out of the public view
Date: Thu, 21 Apr 2005 11:38:05 -0700
Message-ID: <200504211838.j3LIc56p027751@gameboy2.puremagic.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 20:35:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOgVR-0008GU-4M
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 20:34:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbVDUSiu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 14:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVDUSiu
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 14:38:50 -0400
Received: from bellevue.puremagic.com ([209.189.198.108]:63368 "EHLO
	bellevue.puremagic.com") by vger.kernel.org with ESMTP
	id S261679AbVDUSiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 14:38:16 -0400
Received: from gameboy2.puremagic.com (root@gameboy2.puremagic.com [209.189.198.109])
	by bellevue.puremagic.com (8.13.3/8.13.3/Debian-6) with ESMTP id j3LIc3XT028124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:38:03 -0700
Received: from gameboy2.puremagic.com (braddr@localhost [127.0.0.1])
	by gameboy2.puremagic.com (8.13.3/8.13.3/Debian-3) with ESMTP id j3LIc599027757
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:38:05 -0700
Received: (from braddr@localhost)
	by gameboy2.puremagic.com (8.13.3/8.13.3/Submit) id j3LIc56p027751
	for git@vger.kernel.org; Thu, 21 Apr 2005 11:38:05 -0700
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

tree a2c82ce3512904f82f78d87d86709a471f67ef9f
parent ff3667537379d5b0680e8c4f9a14d82dc9835430
author Brad Roberts <braddr@puremagic.com> 1114083477 -0700
committer Brad Roberts <braddr@gameboy2.puremagic.com> 1114083477 -0700

[PATCH] move cache_header out of the public view

Signed-off-by: Brad Roberts <braddr@puremagic.com>
---

 cache.h      |   15 ---------------
 read-cache.c |   11 +++++++++++
 2 files changed, 11 insertions(+), 15 deletions(-)

Index: cache.h
===================================================================
--- ff3667537379d5b0680e8c4f9a14d82dc9835430:1/cache.h  (mode:100644 sha1:b29bb0ca5e7be15c0b423101f5cf381ee68f139e)
+++ b7d4fa53d4ee449b4b9b4f3c9dd40d6c99db4bc1:1/cache.h  (mode:100644 sha1:74d6c4d25c564e08eadc04aaef31a711d0645a43)
@@ -17,21 +17,6 @@
 #include <zlib.h>
 
 /*
- * Basic data structures for the directory cache
- *
- * NOTE NOTE NOTE! This is all in the native CPU byte format. It's
- * not even trying to be portable. It's trying to be efficient. It's
- * just a cache, after all.
- */
-
-#define CACHE_SIGNATURE 0x44495243	/* "DIRC" */
-struct cache_header {
-	unsigned int hdr_signature;
-	unsigned int hdr_version;
-	unsigned int hdr_entries;
-};
-
-/*
  * The "cache_time" is just the low 32 bits of the
  * time. It doesn't matter if it overflows - we only
  * check it for equality in the 32 bits we save.
Index: read-cache.c
===================================================================
--- ff3667537379d5b0680e8c4f9a14d82dc9835430:1/read-cache.c  (mode:100644 sha1:0e972a80fa19eb77fd547fb579354af784be3ac4)
+++ b7d4fa53d4ee449b4b9b4f3c9dd40d6c99db4bc1:1/read-cache.c  (mode:100644 sha1:b16a72dc4e4525a7df060b3a43722217db7869c2)
@@ -6,6 +6,17 @@
 #include <stdarg.h>
 #include "cache.h"
 
+/*
+ * Basic data structures for the directory cache
+ */
+
+#define CACHE_SIGNATURE 0x44495243	/* "DIRC" */
+struct cache_header {
+	unsigned int hdr_signature;
+	unsigned int hdr_version;
+	unsigned int hdr_entries;
+};
+
 static struct cache_entry **active_cache = NULL;
 static unsigned int active_nr = 0, active_alloc = 0;
 


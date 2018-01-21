Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_12_24,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 246311F576
	for <e@80x24.org>; Sun, 21 Jan 2018 23:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751102AbeAUXOV (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Jan 2018 18:14:21 -0500
Received: from mail-wr0-f180.google.com ([209.85.128.180]:42815 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750939AbeAUXOU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Jan 2018 18:14:20 -0500
Received: by mail-wr0-f180.google.com with SMTP id e41so6699966wre.9
        for <git@vger.kernel.org>; Sun, 21 Jan 2018 15:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Pf+ykWEGB+FttA0q185H9oMny9c2+AtyC6s6TSo0rqs=;
        b=pCpA85q4+e4aZzNh0unnvbvUAzaxKNYSRKmf66TepLIV/29lIL6Kh9eC+ljjAojfNZ
         cQln6gyyjHEW7M3f2NtJzc6NWfS/xBwLEdja1pwSlzqygvo60YICz08eLf7Ml/coYoVW
         1J29e9WIIJCaNBvQbTgRoGiHA1Pyvb3ymTUPLaz3EZ1DnQtnZVFXEPl48zUe3sohgZY2
         7ulg7pyl8wqjLxevLmJTWUT55SVj3jeVcXWzsyrcL+lb/vkIioxiPa0zoCANPED8xWrT
         Jo+A1mM78rGg6yvutNw8L93oi5O0goUMQDkwzQi0xCqUlNAVJ1su0MFp/nbIxsD1WK7y
         zvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Pf+ykWEGB+FttA0q185H9oMny9c2+AtyC6s6TSo0rqs=;
        b=l6HxSDdy9V8GJtdKGyLiuN9jCHyukpnoA5Y7Om12wowzHLke6WEx1bVRCV2KzL9ikM
         CeAek9zVdiseoXv6f2HejK/NBat9LK7XMwMAToFbLZ2gIOuhYh35Xz16cMhuP4ukwyL4
         T2vKN5pmcr9DVSn3KKBtYodV14Chn9reaBwMOUi9LFWwMdQJHZEg5jtczfVxhwlyyAfy
         2SSkQRqzLUZpGaYyrtygTnF2SNCmbfi8V9h2mE0C+OrJ0hLLysNv2m7rhfqXb0TRIPHL
         5yR0xceceW+xZgGJejtpcb7Pz7N3GaphQTEB1oOmTukl7LZOEPZkvLvb8UqEdYKIZ1hx
         mn7Q==
X-Gm-Message-State: AKwxytf8D2+/ST2lFmvhiPaFEQQYbkuN6BDDvh100b/8LEkmalGX0ql/
        iU+MUaqWElnS3WMWIFxj3F0x3A==
X-Google-Smtp-Source: AH8x226lCGxcB0w8R+FdIfjnw6DYvqWwoddA0aPwi06AzmURF15ABV5bgfz1xnMTb9E2vmsTmu1HLQ==
X-Received: by 10.223.171.194 with SMTP id s60mr4748830wrc.250.1516576459117;
        Sun, 21 Jan 2018 15:14:19 -0800 (PST)
Received: from localhost.localdomain ([88.98.209.66])
        by smtp.gmail.com with ESMTPSA id s206sm5114587wme.4.2018.01.21.15.14.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 21 Jan 2018 15:14:18 -0800 (PST)
From:   Gargi Sharma <gs051095@gmail.com>
To:     git@vger.kernel.org
Cc:     Gargi Sharma <gs051095@gmail.com>
Subject: [PATCH v5] mru: Replace mru.[ch] with list.h implementation
Date:   Sat, 20 Jan 2018 20:26:04 -0500
Message-Id: <1516497964-6041-1-git-send-email-gs051095@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the custom calls to mru.[ch] with calls to list.h. This patch is
the final step in removing the mru API completely and inlining the logic.
This patch leads to significant code reduction and the mru API hence, is
not a useful abstraction anymore.

Signed-off-by: Gargi Sharma <gs051095@gmail.com>
---
The commit has been built on top of ot/mru-on-list branch.

Changes in v5:
	- Remove list_move_to_front() as it is redundant.
Changes in v4:
        - Fixing minor style issues.
Changes in v3:
        - Make the commit message more descriptive.
        - Remove braces after if statement.
Changes in v2:
        - Add a move to front function to the list API.
        - Remove memory leak.
        - Remove redundant remove operations on the list.

A future improvement could be removing/changing the
type of nect pointer or dropping it entirely. See discussion
here:
https://public-inbox.org/git/CAOCi2DGYQr4jFf5ObY2buyhNJeaAPQKF8tbojn2W0b18Eo+Wgw@mail.gmail.com/
---
 Makefile               |  1 -
 builtin/pack-objects.c |  9 ++++-----
 cache.h                |  8 ++++----
 mru.c                  | 27 ---------------------------
 mru.h                  | 40 ----------------------------------------
 packfile.c             | 15 +++++++--------
 sha1_file.c            |  1 -
 7 files changed, 15 insertions(+), 86 deletions(-)
 delete mode 100644 mru.c
 delete mode 100644 mru.h

diff --git a/Makefile b/Makefile
index ed4ca43..4a79ec5 100644
--- a/Makefile
+++ b/Makefile
@@ -814,7 +814,6 @@ LIB_OBJS += merge.o
 LIB_OBJS += merge-blobs.o
 LIB_OBJS += merge-recursive.o
 LIB_OBJS += mergesort.o
-LIB_OBJS += mru.o
 LIB_OBJS += name-hash.o
 LIB_OBJS += notes.o
 LIB_OBJS += notes-cache.o
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ba81234..6a0b8e8 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -24,7 +24,7 @@
 #include "reachable.h"
 #include "sha1-array.h"
 #include "argv-array.h"
-#include "mru.h"
+#include "list.h"
 #include "packfile.h"
 
 static const char *pack_usage[] = {
@@ -1012,9 +1012,8 @@ static int want_object_in_pack(const unsigned char *sha1,
 			return want;
 	}
 
-	list_for_each(pos, &packed_git_mru.list) {
-		struct mru *entry = list_entry(pos, struct mru, list);
-		struct packed_git *p = entry->item;
+	list_for_each(pos, &packed_git_mru) {
+		struct packed_git *p = list_entry(pos, struct packed_git, mru);
 		off_t offset;
 
 		if (p == *found_pack)
@@ -1031,7 +1030,7 @@ static int want_object_in_pack(const unsigned char *sha1,
 			}
 			want = want_found_object(exclude, p);
 			if (!exclude && want > 0)
-				mru_mark(&packed_git_mru, entry);
+				list_move(&p->mru, &packed_git_mru);
 			if (want != -1)
 				return want;
 		}
diff --git a/cache.h b/cache.h
index 49b083e..cc09e3b 100644
--- a/cache.h
+++ b/cache.h
@@ -4,7 +4,7 @@
 #include "git-compat-util.h"
 #include "strbuf.h"
 #include "hashmap.h"
-#include "mru.h"
+#include "list.h"
 #include "advice.h"
 #include "gettext.h"
 #include "convert.h"
@@ -1566,6 +1566,7 @@ struct pack_window {
 
 extern struct packed_git {
 	struct packed_git *next;
+	struct list_head mru;
 	struct pack_window *windows;
 	off_t pack_size;
 	const void *index_data;
@@ -1587,10 +1588,9 @@ extern struct packed_git {
 } *packed_git;
 
 /*
- * A most-recently-used ordered version of the packed_git list, which can
- * be iterated instead of packed_git (and marked via mru_mark).
+ * A most-recently-used ordered version of the packed_git list.
  */
-extern struct mru packed_git_mru;
+extern struct list_head packed_git_mru;
 
 struct pack_entry {
 	off_t offset;
diff --git a/mru.c b/mru.c
deleted file mode 100644
index 8f3f34c..0000000
--- a/mru.c
+++ /dev/null
@@ -1,27 +0,0 @@
-#include "cache.h"
-#include "mru.h"
-
-void mru_append(struct mru *head, void *item)
-{
-	struct mru *cur = xmalloc(sizeof(*cur));
-	cur->item = item;
-	list_add_tail(&cur->list, &head->list);
-}
-
-void mru_mark(struct mru *head, struct mru *entry)
-{
-	/* To mark means to put at the front of the list. */
-	list_del(&entry->list);
-	list_add(&entry->list, &head->list);
-}
-
-void mru_clear(struct mru *head)
-{
-	struct list_head *pos;
-	struct list_head *tmp;
-
-	list_for_each_safe(pos, tmp, &head->list) {
-		free(list_entry(pos, struct mru, list));
-	}
-	INIT_LIST_HEAD(&head->list);
-}
diff --git a/mru.h b/mru.h
deleted file mode 100644
index 80a589e..0000000
--- a/mru.h
+++ /dev/null
@@ -1,40 +0,0 @@
-#ifndef MRU_H
-#define MRU_H
-
-#include "list.h"
-
-/**
- * A simple most-recently-used cache, backed by a doubly-linked list.
- *
- * Usage is roughly:
- *
- *   // Create a list.  Zero-initialization is required.
- *   static struct mru cache;
- *   INIT_LIST_HEAD(&cache.list);
- *
- *   // Add new item to the end of the list.
- *   void *item;
- *   ...
- *   mru_append(&cache, item);
- *
- *   // Mark an item as used, moving it to the front of the list.
- *   mru_mark(&cache, item);
- *
- *   // Reset the list to empty, cleaning up all resources.
- *   mru_clear(&cache);
- *
- * Note that you SHOULD NOT call mru_mark() and then continue traversing the
- * list; it reorders the marked item to the front of the list, and therefore
- * you will begin traversing the whole list again.
- */
-
-struct mru {
-	struct list_head list;
-	void *item;
-};
-
-void mru_append(struct mru *head, void *item);
-void mru_mark(struct mru *head, struct mru *entry);
-void mru_clear(struct mru *head);
-
-#endif /* MRU_H */
diff --git a/packfile.c b/packfile.c
index 502d915..2388efc 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1,5 +1,5 @@
 #include "cache.h"
-#include "mru.h"
+#include "list.h"
 #include "pack.h"
 #include "dir.h"
 #include "mergesort.h"
@@ -40,7 +40,7 @@ static unsigned int pack_max_fds;
 static size_t peak_pack_mapped;
 static size_t pack_mapped;
 struct packed_git *packed_git;
-struct mru packed_git_mru = {{&packed_git_mru.list, &packed_git_mru.list}};
+LIST_HEAD(packed_git_mru);
 
 #define SZ_FMT PRIuMAX
 static inline uintmax_t sz_fmt(size_t s) { return s; }
@@ -859,9 +859,8 @@ static void prepare_packed_git_mru(void)
 {
 	struct packed_git *p;
 
-	mru_clear(&packed_git_mru);
 	for (p = packed_git; p; p = p->next)
-		mru_append(&packed_git_mru, p);
+		list_add_tail(&p->mru, &packed_git_mru);
 }
 
 static int prepare_packed_git_run_once = 0;
@@ -1830,10 +1829,10 @@ int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
 	if (!packed_git)
 		return 0;
 
-	list_for_each(pos, &packed_git_mru.list) {
-		struct mru *p = list_entry(pos, struct mru, list);
-		if (fill_pack_entry(sha1, e, p->item)) {
-			mru_mark(&packed_git_mru, p);
+	list_for_each(pos, &packed_git_mru) {
+		struct packed_git *p = list_entry(pos, struct packed_git, mru);
+		if (fill_pack_entry(sha1, e, p)) {
+			list_move(&p->mru, &packed_git_mru);
 			return 1;
 		}
 	}
diff --git a/sha1_file.c b/sha1_file.c
index 5a20148..e664f2d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -24,7 +24,6 @@
 #include "bulk-checkin.h"
 #include "streaming.h"
 #include "dir.h"
-#include "mru.h"
 #include "list.h"
 #include "mergesort.h"
 #include "quote.h"
-- 
2.7.4


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF0FE1F404
	for <e@80x24.org>; Fri, 19 Jan 2018 23:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755132AbeASXgl (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 18:36:41 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37149 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752184AbeASXgj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 18:36:39 -0500
Received: by mail-wr0-f195.google.com with SMTP id f11so2965982wre.4
        for <git@vger.kernel.org>; Fri, 19 Jan 2018 15:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+vw8g9qPcHh+Yfj7YZLxSsS7P3Gl1Pjzh+cH6Zva++g=;
        b=tzAwyGg/94d6ZVHG6z9ACHPs1cvv6u9QNcLm9BX55V1XiquVYvwh1XNSlPvfn3e45S
         RFcOMQCsQAIhALF9vPkzkku+PzCFItwxMhNpY958WoGFKodB7VfZD2WtbDwn39tSxVqg
         pWdmZAd0sb9es8XNoEF1mGa26LZm5XXVTjpNoGLCQ47GcgJklzqoyFw8Rhi7y/xD3Syy
         ahlU3DZC0A0kZiAD17uf3HzpHuu7y/HcWOz4Xtw9iDjCvM+fLEb7p13WV3XyIKYf4LI+
         oHkCUaW+rdq4RZTNQoP0jwIGeu4HaEkEnGXYMBrmOWwPvnXrdPuYUdcJ1gY5KgBCcKZt
         Ldxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+vw8g9qPcHh+Yfj7YZLxSsS7P3Gl1Pjzh+cH6Zva++g=;
        b=UAIwyauF8rXCocJwZHx2LJV4gnMLKvsnZHIt0Qp2n3F+ZS0OQtMeQ1t8Bj1ML3hkLZ
         OAIWm4mGQyLH/TfqMDonIjlJBbhSqWYavICjtuIApSF0SoHjfr7SY7SWEOVehUtBBeTi
         KsiqT/Bph4vHomCBdCn1xbCdqvPp8Y5aIh/2WlxJqqshf7SbQsyw2wGBvkbTvsnnJNoU
         anWPkBQOJHQ0j3JcEasZOz+UXRF27+VTx7dUs+dChFcPmJ3nK6YRkyfxSgnRynHVbWGF
         cGWIjXzWJpfaQXrNV5/mMfAUOijiPZ80b42xzq00A2tfxsgLgkrA2f/J3jcSxwCIaVUw
         3mng==
X-Gm-Message-State: AKwxytd04GLdutsbRA/I+hZM2cjxbOPv8Uq9qX9Um8qQ3CUQfw60Szzo
        5yxj8csDscaQ5IEdx2xSzl4ifg==
X-Google-Smtp-Source: AH8x227v0OJWUJN/oF4aVBmQqaO7cDbORAp1zNe5y9CaIs2vryIK9YO9OTR153qlYBEXGCNt6J/A+A==
X-Received: by 10.223.196.211 with SMTP id o19mr82545wrf.201.1516404997991;
        Fri, 19 Jan 2018 15:36:37 -0800 (PST)
Received: from localhost.localdomain ([88.98.209.66])
        by smtp.gmail.com with ESMTPSA id 32sm8522575wrm.14.2018.01.19.15.36.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Jan 2018 15:36:37 -0800 (PST)
From:   Gargi Sharma <gs051095@gmail.com>
To:     git@vger.kernel.org
Cc:     Gargi Sharma <gs051095@gmail.com>
Subject: [PATCH v3] mru: Replace mru.[ch] with list.h implementation
Date:   Fri, 19 Jan 2018 18:36:27 -0500
Message-Id: <1516404987-3420-1-git-send-email-gs051095@gmail.com>
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
Changes in v3:
	- Make the commit message more descriptive.
	- Remove braces after if statement.
Changes in v2:
        - Add a move to front function to the list API.
        - Remove memory leak.
        - Remove redundant remove operations on the list.

The commit has been built on top of ot/mru-on-list branch.

A future improvement could be removing/changing the
type of nect pointer or dropping it entirely. See discussion
here:
https://public-inbox.org/git/CAOCi2DGYQr4jFf5ObY2buyhNJeaAPQKF8tbojn2W0b18Eo+Wgw@mail.gmail.com/
---
 Makefile               |  1 -
 builtin/pack-objects.c |  9 ++++-----
 cache.h                |  9 +++++----
 list.h                 |  7 +++++++
 mru.c                  | 27 ---------------------------
 mru.h                  | 40 ----------------------------------------
 packfile.c             | 18 +++++++++---------
 sha1_file.c            |  1 -
 8 files changed, 25 insertions(+), 87 deletions(-)
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
index ba81234..188ba3e 100644
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
+				list_move_to_front(&p->mru, &packed_git_mru);
 			if (want != -1)
 				return want;
 		}
diff --git a/cache.h b/cache.h
index 49b083e..1a275ae 100644
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
@@ -1587,10 +1588,10 @@ extern struct packed_git {
 } *packed_git;
 
 /*
- * A most-recently-used ordered version of the packed_git list, which can
- * be iterated instead of packed_git (and marked via mru_mark).
+ * A most-recently-used ordered version of the packed_git list.
  */
-extern struct mru packed_git_mru;
+extern struct list_head packed_git_mru;
+
 
 struct pack_entry {
 	off_t offset;
diff --git a/list.h b/list.h
index eb60119..5129b0a 100644
--- a/list.h
+++ b/list.h
@@ -93,6 +93,13 @@ static inline void list_move(struct list_head *elem, struct list_head *head)
 	list_add(elem, head);
 }
 
+/* Move to the front of the list. */
+static inline void list_move_to_front(struct list_head *elem, struct list_head *head)
+{
+	list_del(elem);
+	list_add(elem, head);
+}
+
 /* Replace an old entry. */
 static inline void list_replace(struct list_head *old, struct list_head *newp)
 {
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
index 502d915..0a25cf2 100644
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
@@ -859,9 +859,9 @@ static void prepare_packed_git_mru(void)
 {
 	struct packed_git *p;
 
-	mru_clear(&packed_git_mru);
-	for (p = packed_git; p; p = p->next)
-		mru_append(&packed_git_mru, p);
+	for (p = packed_git; p; p = p->next) {
+		list_add_tail(&p->mru, &packed_git_mru);
+	}
 }
 
 static int prepare_packed_git_run_once = 0;
@@ -1830,10 +1830,10 @@ int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
 	if (!packed_git)
 		return 0;
 
-	list_for_each(pos, &packed_git_mru.list) {
-		struct mru *p = list_entry(pos, struct mru, list);
-		if (fill_pack_entry(sha1, e, p->item)) {
-			mru_mark(&packed_git_mru, p);
+	list_for_each(pos, &packed_git_mru) {
+		struct packed_git *p = list_entry(pos, struct packed_git, mru);
+		if (fill_pack_entry(sha1, e, p)) {
+			list_move_to_front(&p->mru, &packed_git_mru);
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


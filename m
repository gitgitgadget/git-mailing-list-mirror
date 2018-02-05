Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90ABD1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752039AbeBFADV (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:03:21 -0500
Received: from mail-pl0-f52.google.com ([209.85.160.52]:42414 "EHLO
        mail-pl0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbeBFADT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:03:19 -0500
Received: by mail-pl0-f52.google.com with SMTP id 11so91462plc.9
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9ZlA2q9JxNv10AFn74s5qh7OfzNJ1fSYzx75cE5udGs=;
        b=j435CjmgBZtCu5Uvie2C8yv35eLiIwFlTdHzseWz9MAklXO7ioxa0m4Zssz8VBrqTi
         dczAYbdttdJ/Z6sY04u3Pc+WUugPzFjC7aSWDJJ/GKje0ivpxQ7lo8UO7znK+8hhi3aH
         AHaPNF5CUk0TAGs9dNMs4UkJXDu3xX1aMwBE6l4uQnol7Fiuqc92IY2kMm8qhDRKxFUD
         /aOS9cDV2WDBvH1CSTrfbiy2LwYDgDM/g4nzgZAiYUOyiXqe6A0WbqR9e/GVsB+tNrnU
         w+BbN3DAMjrba2Jt6mes2ptcXpMbRV78E0haxNbhRohD6Fr/lrllfS6v+o8+sC+aOCgS
         yGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9ZlA2q9JxNv10AFn74s5qh7OfzNJ1fSYzx75cE5udGs=;
        b=BmbxWYYPFIwxIahXGoQf8hBI7ElWrkVy0ffETWY/5kOxxuTqrpdt1Vuou8vTATevSW
         wJKFCnzx8N5Yq/zVDrh1fShDn9lj5dEl88WezeVMhaxCYvoKeI8Bff/l0N/l5gos+8o8
         M8JEWGG7VfXvEiVRDsf6U0MWowOly2YUgMO8u+T8NndjL8dCwey4VIraZa0cngzbCluB
         LsRKVdWx+KSBYyKfpYlHzooR9QSGfk/dsq9h96Ut1YSe6RV9vrsfDv+BS3vU7Dnedvnh
         12zXlCTvVYH+lytj9jUenPd2jYrmz3Gts0cejupzlRKGvd0Gpz/pMEQDRooqIiypK5Dp
         5MsA==
X-Gm-Message-State: APf1xPDm+8pI5wOhWEUCmcocFJyMQHzhQhMS9qBMeR5ekhbLgGt4F3ls
        Ui5YknpGGYa+hj6vtC8Fr769ztUW+BA=
X-Google-Smtp-Source: AH8x224fJlG/StlYig6nlfKYJRw+27y2E+OxN8WCBWVNESj2S1LI7Ratd3oq1Isc5fUDWn9526SF6A==
X-Received: by 2002:a17:902:8a89:: with SMTP id p9-v6mr475373plo.397.1517875398229;
        Mon, 05 Feb 2018 16:03:18 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id c185sm19199117pfb.146.2018.02.05.16.03.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:03:17 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 045/194] object-store: move object access functions to object-store.h
Date:   Mon,  5 Feb 2018 15:55:06 -0800
Message-Id: <20180205235735.216710-25-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This should make these functions easier to find and cache.h less
overwhelming to read.

In particular, this moves:
- read_sha1_file
- sha1_object_info
- write_sha1_file
- sha1_object_info

As a result, most of the codebase needs to #include object-store.h.
In this patch the #include is only added to files that would fail to
compile otherwise.  It would be better to #include wherever
identifiers from the header are used.  That can happen later when we
have better tooling for it.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 apply.c                  |   1 +
 archive-tar.c            |   1 +
 archive-zip.c            |   1 +
 archive.c                |   1 +
 blame.c                  |   1 +
 builtin/checkout.c       |   1 +
 builtin/clone.c          |   1 +
 builtin/commit-tree.c    |   1 +
 builtin/difftool.c       |   1 +
 builtin/fast-export.c    |   1 +
 builtin/fetch.c          |   1 +
 builtin/fmt-merge-msg.c  |   1 +
 builtin/hash-object.c    |   1 +
 builtin/log.c            |   1 +
 builtin/ls-tree.c        |   1 +
 builtin/merge-tree.c     |   1 +
 builtin/mktag.c          |   1 +
 builtin/mktree.c         |   1 +
 builtin/notes.c          |   1 +
 builtin/reflog.c         |   1 +
 builtin/remote.c         |   1 +
 builtin/replace.c        |   1 +
 builtin/rev-list.c       |   1 +
 builtin/show-ref.c       |   1 +
 builtin/tag.c            |   1 +
 builtin/unpack-file.c    |   1 +
 builtin/unpack-objects.c |   1 +
 builtin/verify-commit.c  |   1 +
 bundle.c                 |   1 +
 cache-tree.c             |   1 +
 cache.h                  | 102 ------------------------------------------
 combine-diff.c           |   1 +
 commit.c                 |   1 +
 convert.c                |   1 +
 diff.c                   |   1 +
 diffcore-rename.c        |   1 +
 dir.c                    |   1 +
 entry.c                  |   1 +
 fsck.c                   |   1 +
 grep.c                   |   1 +
 log-tree.c               |   1 +
 mailmap.c                |   1 +
 match-trees.c            |   1 +
 merge-blobs.c            |   1 +
 merge-recursive.c        |   1 +
 notes-cache.c            |   1 +
 notes-merge.c            |   1 +
 notes.c                  |   1 +
 object-store.h           | 112 ++++++++++++++++++++++++++++++++++++++++++++++-
 object.c                 |   1 +
 pack-bitmap-write.c      |   1 +
 packfile.h               |   3 ++
 read-cache.c             |   1 +
 ref-filter.c             |   1 +
 refs.c                   |   1 +
 remote-testsvn.c         |   1 +
 remote.c                 |   1 +
 rerere.c                 |   1 +
 revision.c               |   1 +
 send-pack.c              |   1 +
 sequencer.c              |   1 +
 shallow.c                |   1 +
 tag.c                    |   1 +
 tree-walk.c              |   1 +
 tree.c                   |   1 +
 upload-pack.c            |   1 +
 walker.c                 |   1 +
 xdiff-interface.c        |   1 +
 68 files changed, 178 insertions(+), 104 deletions(-)

diff --git a/apply.c b/apply.c
index 321a9fa68d..de4440cd2a 100644
--- a/apply.c
+++ b/apply.c
@@ -9,6 +9,7 @@
 
 #include "cache.h"
 #include "config.h"
+#include "object-store.h"
 #include "blob.h"
 #include "delta.h"
 #include "diff.h"
diff --git a/archive-tar.c b/archive-tar.c
index c6ed96ee74..909347c108 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -5,6 +5,7 @@
 #include "config.h"
 #include "tar.h"
 #include "archive.h"
+#include "object-store.h"
 #include "streaming.h"
 #include "run-command.h"
 
diff --git a/archive-zip.c b/archive-zip.c
index e8913e5a26..233fed3a61 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -6,6 +6,7 @@
 #include "archive.h"
 #include "streaming.h"
 #include "utf8.h"
+#include "object-store.h"
 #include "userdiff.h"
 #include "xdiff-interface.h"
 
diff --git a/archive.c b/archive.c
index 0b7b62af0c..9b47041a6c 100644
--- a/archive.c
+++ b/archive.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "config.h"
 #include "refs.h"
+#include "object-store.h"
 #include "commit.h"
 #include "tree-walk.h"
 #include "attr.h"
diff --git a/blame.c b/blame.c
index 2893f3c103..61f0f6bb40 100644
--- a/blame.c
+++ b/blame.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "refs.h"
+#include "object-store.h"
 #include "cache-tree.h"
 #include "mergesort.h"
 #include "diff.h"
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 8bdc927d3f..c7271ed43f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -4,6 +4,7 @@
 #include "lockfile.h"
 #include "parse-options.h"
 #include "refs.h"
+#include "object-store.h"
 #include "commit.h"
 #include "tree.h"
 #include "tree-walk.h"
diff --git a/builtin/clone.c b/builtin/clone.c
index 27463c8fc5..ecd71b9444 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -15,6 +15,7 @@
 #include "parse-options.h"
 #include "fetch-pack.h"
 #include "refs.h"
+#include "object-store.h"
 #include "tree.h"
 #include "tree-walk.h"
 #include "unpack-trees.h"
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 2177251e24..a54fb362ce 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -5,6 +5,7 @@
  */
 #include "cache.h"
 #include "config.h"
+#include "object-store.h"
 #include "commit.h"
 #include "tree.h"
 #include "builtin.h"
diff --git a/builtin/difftool.c b/builtin/difftool.c
index bcc79d1888..d62094060d 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -20,6 +20,7 @@
 #include "argv-array.h"
 #include "strbuf.h"
 #include "lockfile.h"
+#include "object-store.h"
 #include "dir.h"
 
 static char *diff_gui_tool;
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 796d0cd66c..f76b7bda79 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -7,6 +7,7 @@
 #include "cache.h"
 #include "config.h"
 #include "refs.h"
+#include "object-store.h"
 #include "commit.h"
 #include "object.h"
 #include "tag.h"
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7bbcd26faf..9b7202953b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -5,6 +5,7 @@
 #include "config.h"
 #include "repository.h"
 #include "refs.h"
+#include "object-store.h"
 #include "commit.h"
 #include "builtin.h"
 #include "string-list.h"
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 8e8a15ea4a..9dd5c85831 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "config.h"
 #include "refs.h"
+#include "object-store.h"
 #include "commit.h"
 #include "diff.h"
 #include "revision.h"
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index c532ff9320..956a798110 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -6,6 +6,7 @@
  */
 #include "builtin.h"
 #include "config.h"
+#include "object-store.h"
 #include "blob.h"
 #include "quote.h"
 #include "parse-options.h"
diff --git a/builtin/log.c b/builtin/log.c
index 14fdf39165..de723fffc6 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -7,6 +7,7 @@
 #include "cache.h"
 #include "config.h"
 #include "refs.h"
+#include "object-store.h"
 #include "color.h"
 #include "commit.h"
 #include "diff.h"
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index ef965408e8..78fcced566 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -5,6 +5,7 @@
  */
 #include "cache.h"
 #include "config.h"
+#include "object-store.h"
 #include "blob.h"
 #include "tree.h"
 #include "commit.h"
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index d01ddecf66..ba51ad55a8 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "tree-walk.h"
 #include "xdiff-interface.h"
+#include "object-store.h"
 #include "blob.h"
 #include "exec_cmd.h"
 #include "merge-blobs.h"
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 031b750f06..04eadc7b24 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "tag.h"
+#include "object-store.h"
 
 /*
  * A signature file has a very simple fixed format: four lines
diff --git a/builtin/mktree.c b/builtin/mktree.c
index da0fd8cd70..0f66946618 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -7,6 +7,7 @@
 #include "quote.h"
 #include "tree.h"
 #include "parse-options.h"
+#include "object-store.h"
 
 static struct treeent {
 	unsigned mode;
diff --git a/builtin/notes.c b/builtin/notes.c
index 7c81761645..1bd3994caa 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -11,6 +11,7 @@
 #include "config.h"
 #include "builtin.h"
 #include "notes.h"
+#include "object-store.h"
 #include "blob.h"
 #include "pretty.h"
 #include "refs.h"
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 2233725315..4b525c4448 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "config.h"
 #include "lockfile.h"
+#include "object-store.h"
 #include "commit.h"
 #include "refs.h"
 #include "dir.h"
diff --git a/builtin/remote.c b/builtin/remote.c
index d95bf904c3..7bd81bac6a 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -7,6 +7,7 @@
 #include "strbuf.h"
 #include "run-command.h"
 #include "refs.h"
+#include "object-store.h"
 #include "argv-array.h"
 
 static const char * const builtin_remote_usage[] = {
diff --git a/builtin/replace.c b/builtin/replace.c
index 10078ae371..ccde160228 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -14,6 +14,7 @@
 #include "refs.h"
 #include "parse-options.h"
 #include "run-command.h"
+#include "object-store.h"
 #include "tag.h"
 
 static const char * const git_replace_usage[] = {
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index d5345b6a2e..969efde30c 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -6,6 +6,7 @@
 #include "list-objects.h"
 #include "list-objects-filter.h"
 #include "list-objects-filter-options.h"
+#include "object-store.h"
 #include "pack.h"
 #include "pack-bitmap.h"
 #include "builtin.h"
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 41e5e71cad..8f5827af62 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "cache.h"
 #include "refs.h"
+#include "object-store.h"
 #include "object.h"
 #include "tag.h"
 #include "string-list.h"
diff --git a/builtin/tag.c b/builtin/tag.c
index a7e6a5b0f2..7ed3506fff 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -10,6 +10,7 @@
 #include "config.h"
 #include "builtin.h"
 #include "refs.h"
+#include "object-store.h"
 #include "tag.h"
 #include "run-command.h"
 #include "parse-options.h"
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index 32e0155577..b28e056c74 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "config.h"
+#include "object-store.h"
 
 static char *create_temp_file(struct object_id *oid)
 {
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 62ea264c46..6d03ea2670 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "cache.h"
 #include "config.h"
+#include "object-store.h"
 #include "object.h"
 #include "delta.h"
 #include "pack.h"
diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index ba38ac9b15..29f5e5507c 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -8,6 +8,7 @@
 #include "cache.h"
 #include "config.h"
 #include "builtin.h"
+#include "object-store.h"
 #include "commit.h"
 #include "run-command.h"
 #include <signal.h>
diff --git a/bundle.c b/bundle.c
index 93290962c9..d9376b7c77 100644
--- a/bundle.c
+++ b/bundle.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "lockfile.h"
 #include "bundle.h"
+#include "object-store.h"
 #include "object.h"
 #include "commit.h"
 #include "diff.h"
diff --git a/cache-tree.c b/cache-tree.c
index e03e72c34a..2a98b15b92 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -3,6 +3,7 @@
 #include "tree.h"
 #include "tree-walk.h"
 #include "cache-tree.h"
+#include "object-store.h"
 
 #ifndef DEBUG
 #define DEBUG 0
diff --git a/cache.h b/cache.h
index c66e59733d..22404de92b 100644
--- a/cache.h
+++ b/cache.h
@@ -1201,40 +1201,6 @@ extern char *xdg_config_home(const char *filename);
  */
 extern char *xdg_cache_home(const char *filename);
 
-extern void *read_sha1_file_extended(const unsigned char *sha1,
-				     enum object_type *type,
-				     unsigned long *size, int lookup_replace);
-static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size)
-{
-	return read_sha1_file_extended(sha1, type, size, 1);
-}
-
-/*
- * This internal function is only declared here for the benefit of
- * lookup_replace_object().  Please do not call it directly.
- */
-extern const unsigned char *do_lookup_replace_object(const unsigned char *sha1);
-
-/*
- * If object sha1 should be replaced, return the replacement object's
- * name (replaced recursively, if necessary).  The return value is
- * either sha1 or a pointer to a permanently-allocated value.  When
- * object replacement is suppressed, always return sha1.
- */
-static inline const unsigned char *lookup_replace_object(const unsigned char *sha1)
-{
-	if (!check_replace_refs)
-		return sha1;
-	return do_lookup_replace_object(sha1);
-}
-
-/* Read and unpack a sha1 file into memory, write memory to a sha1 file */
-extern int sha1_object_info(const unsigned char *, unsigned long *);
-extern int hash_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1);
-extern int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
-extern int hash_sha1_file_literally(const void *buf, unsigned long len, const char *type, struct object_id *oid, unsigned flags);
-extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
-extern int force_object_loose(const unsigned char *sha1, time_t mtime);
 extern int git_open_cloexec(const char *name, int flags);
 #define git_open(name) git_open_cloexec(name, O_RDONLY)
 extern int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
@@ -1244,23 +1210,6 @@ extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned l
 
 extern int finalize_object_file(const char *tmpfile, const char *filename);
 
-/*
- * Convenience for sha1_object_info_extended() with a NULL struct
- * object_info. OBJECT_INFO_SKIP_CACHED is automatically set; pass
- * nonzero flags to also set other flags.
- */
-extern int has_sha1_file_with_flags(const unsigned char *sha1, int flags);
-static inline int has_sha1_file(const unsigned char *sha1)
-{
-	return has_sha1_file_with_flags(sha1, 0);
-}
-
-/* Same as the above, except for struct object_id. */
-extern int has_object_file(const struct object_id *oid);
-extern int has_object_file_with_flags(const struct object_id *oid, int flags);
-
-extern void assert_sha1_type(const unsigned char *sha1, enum object_type expect);
-
 /* Helper to check and "touch" a file */
 extern int check_and_freshen_file(const char *fn, int freshen);
 
@@ -1566,57 +1515,6 @@ extern int odb_pack_keep(const char *name);
  */
 #define FOR_EACH_OBJECT_LOCAL_ONLY 0x1
 
-struct object_info {
-	/* Request */
-	enum object_type *typep;
-	unsigned long *sizep;
-	off_t *disk_sizep;
-	unsigned char *delta_base_sha1;
-	struct strbuf *typename;
-	void **contentp;
-
-	/* Response */
-	enum {
-		OI_CACHED,
-		OI_LOOSE,
-		OI_PACKED,
-		OI_DBCACHED
-	} whence;
-	union {
-		/*
-		 * struct {
-		 * 	... Nothing to expose in this case
-		 * } cached;
-		 * struct {
-		 * 	... Nothing to expose in this case
-		 * } loose;
-		 */
-		struct {
-			struct packed_git *pack;
-			off_t offset;
-			unsigned int is_delta;
-		} packed;
-	} u;
-};
-
-/*
- * Initializer for a "struct object_info" that wants no items. You may
- * also memset() the memory to all-zeroes.
- */
-#define OBJECT_INFO_INIT {NULL}
-
-/* Invoke lookup_replace_object() on the given hash */
-#define OBJECT_INFO_LOOKUP_REPLACE 1
-/* Allow reading from a loose object file of unknown/bogus type */
-#define OBJECT_INFO_ALLOW_UNKNOWN_TYPE 2
-/* Do not check cached storage */
-#define OBJECT_INFO_SKIP_CACHED 4
-/* Do not retry packed storage after checking packed and loose storage */
-#define OBJECT_INFO_QUICK 8
-#define sha1_object_info_extended(r, s, oi, f) \
-		sha1_object_info_extended_##r(s, oi, f)
-extern int sha1_object_info_extended_the_repository(const unsigned char *, struct object_info *, unsigned flags);
-
 /* Dumb servers support */
 extern int update_server_info(int);
 
diff --git a/combine-diff.c b/combine-diff.c
index 2505de119a..f45ab6f57c 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "object-store.h"
 #include "commit.h"
 #include "blob.h"
 #include "diff.h"
diff --git a/commit.c b/commit.c
index cab8d4455b..b60906d3f9 100644
--- a/commit.c
+++ b/commit.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "tag.h"
 #include "commit.h"
+#include "object-store.h"
 #include "pkt-line.h"
 #include "utf8.h"
 #include "diff.h"
diff --git a/convert.c b/convert.c
index 1a41a48e15..a090ed805f 100644
--- a/convert.c
+++ b/convert.c
@@ -1,6 +1,7 @@
 #define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "config.h"
+#include "object-store.h"
 #include "attr.h"
 #include "run-command.h"
 #include "quote.h"
diff --git a/diff.c b/diff.c
index fb22b19f09..e89c7d9919 100644
--- a/diff.c
+++ b/diff.c
@@ -13,6 +13,7 @@
 #include "attr.h"
 #include "run-command.h"
 #include "utf8.h"
+#include "object-store.h"
 #include "userdiff.h"
 #include "submodule-config.h"
 #include "submodule.h"
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 245e999fe5..266b9ff03f 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -4,6 +4,7 @@
 #include "cache.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "object-store.h"
 #include "hashmap.h"
 #include "progress.h"
 
diff --git a/dir.c b/dir.c
index 7c4b45e30e..4a7981abc4 100644
--- a/dir.c
+++ b/dir.c
@@ -11,6 +11,7 @@
 #include "cache.h"
 #include "config.h"
 #include "dir.h"
+#include "object-store.h"
 #include "attr.h"
 #include "refs.h"
 #include "wildmatch.h"
diff --git a/entry.c b/entry.c
index 30211447ac..02aa09bc83 100644
--- a/entry.c
+++ b/entry.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "blob.h"
+#include "object-store.h"
 #include "dir.h"
 #include "streaming.h"
 #include "submodule.h"
diff --git a/fsck.c b/fsck.c
index 032699e9ac..d106714bf5 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "object-store.h"
 #include "object.h"
 #include "blob.h"
 #include "tree.h"
diff --git a/grep.c b/grep.c
index 3d7cd0e96f..6bccd7c7ea 100644
--- a/grep.c
+++ b/grep.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "config.h"
 #include "grep.h"
+#include "object-store.h"
 #include "userdiff.h"
 #include "xdiff-interface.h"
 #include "diff.h"
diff --git a/log-tree.c b/log-tree.c
index fca29d4799..b2fff6b5f6 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "config.h"
 #include "diff.h"
+#include "object-store.h"
 #include "commit.h"
 #include "tag.h"
 #include "graph.h"
diff --git a/mailmap.c b/mailmap.c
index cb921b4db6..6afa9cc56d 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "string-list.h"
 #include "mailmap.h"
+#include "object-store.h"
 
 #define DEBUG_MAILMAP 0
 #if DEBUG_MAILMAP
diff --git a/match-trees.c b/match-trees.c
index 396b7338df..bdfdfcaaab 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "tree.h"
 #include "tree-walk.h"
+#include "object-store.h"
 
 static int score_missing(unsigned mode, const char *path)
 {
diff --git a/merge-blobs.c b/merge-blobs.c
index 9b6eac22e4..f5e71bcd9b 100644
--- a/merge-blobs.c
+++ b/merge-blobs.c
@@ -4,6 +4,7 @@
 #include "ll-merge.h"
 #include "blob.h"
 #include "merge-blobs.h"
+#include "object-store.h"
 
 static int fill_mmfile_blob(mmfile_t *f, struct blob *obj)
 {
diff --git a/merge-recursive.c b/merge-recursive.c
index 0fc580d8ca..620e4f653c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -8,6 +8,7 @@
 #include "advice.h"
 #include "lockfile.h"
 #include "cache-tree.h"
+#include "object-store.h"
 #include "commit.h"
 #include "blob.h"
 #include "builtin.h"
diff --git a/notes-cache.c b/notes-cache.c
index 17ee8602b3..ee513e87a9 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "notes-cache.h"
+#include "object-store.h"
 #include "commit.h"
 #include "refs.h"
 
diff --git a/notes-merge.c b/notes-merge.c
index 0f6573cb17..1053c65e83 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "commit.h"
 #include "refs.h"
+#include "object-store.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "xdiff-interface.h"
diff --git a/notes.c b/notes.c
index c7f21fae44..b1478a8dca 100644
--- a/notes.c
+++ b/notes.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "config.h"
 #include "notes.h"
+#include "object-store.h"
 #include "blob.h"
 #include "tree.h"
 #include "utf8.h"
diff --git a/object-store.h b/object-store.h
index 3475e22021..31628c49dc 100644
--- a/object-store.h
+++ b/object-store.h
@@ -1,11 +1,17 @@
 #ifndef OBJECT_STORE_H
 #define OBJECT_STORE_H
 
-#include "cache.h"
+#include "strbuf.h"
 #include "mru.h"
 #include "replace-object.h"
 #include "alternates.h"
-#include "packfile.h"
+
+/* in packfile.h */
+struct pack_window;
+
+/* in cache.h */
+enum object_type;
+extern int check_replace_refs;
 
 struct object_store {
 	struct packed_git *packed_git;
@@ -67,6 +73,108 @@ struct packed_git {
 	char pack_name[FLEX_ARRAY]; /* more */
 };
 
+extern void *read_sha1_file_extended(const unsigned char *sha1,
+				     enum object_type *type,
+				     unsigned long *size, int lookup_replace);
+static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size)
+{
+	return read_sha1_file_extended(sha1, type, size, 1);
+}
+
+/*
+ * This internal function is only declared here for the benefit of
+ * lookup_replace_object().  Please do not call it directly.
+ */
+extern const unsigned char *do_lookup_replace_object(const unsigned char *sha1);
+
+/*
+ * If object sha1 should be replaced, return the replacement object's
+ * name (replaced recursively, if necessary).  The return value is
+ * either sha1 or a pointer to a permanently-allocated value.  When
+ * object replacement is suppressed, always return sha1.
+ */
+static inline const unsigned char *lookup_replace_object(const unsigned char *sha1)
+{
+	if (!check_replace_refs)
+		return sha1;
+	return do_lookup_replace_object(sha1);
+}
+
+/* Read and unpack a sha1 file into memory, write memory to a sha1 file */
+extern int sha1_object_info(const unsigned char *, unsigned long *);
+extern int hash_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1);
+extern int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
+extern int hash_sha1_file_literally(const void *buf, unsigned long len, const char *type, struct object_id *oid, unsigned flags);
+extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
+extern int force_object_loose(const unsigned char *sha1, time_t mtime);
 extern void *map_sha1_file(struct repository *r, const unsigned char *sha1, unsigned long *size);
 
+/*
+ * Convenience for sha1_object_info_extended() with a NULL struct
+ * object_info. OBJECT_INFO_SKIP_CACHED is automatically set; pass
+ * nonzero flags to also set other flags.
+ */
+extern int has_sha1_file_with_flags(const unsigned char *sha1, int flags);
+static inline int has_sha1_file(const unsigned char *sha1)
+{
+	return has_sha1_file_with_flags(sha1, 0);
+}
+
+/* Same as the above, except for struct object_id. */
+extern int has_object_file(const struct object_id *oid);
+extern int has_object_file_with_flags(const struct object_id *oid, int flags);
+
+extern void assert_sha1_type(const unsigned char *sha1, enum object_type expect);
+
+struct object_info {
+	/* Request */
+	enum object_type *typep;
+	unsigned long *sizep;
+	off_t *disk_sizep;
+	unsigned char *delta_base_sha1;
+	struct strbuf *typename;
+	void **contentp;
+
+	/* Response */
+	enum {
+		OI_CACHED,
+		OI_LOOSE,
+		OI_PACKED,
+		OI_DBCACHED
+	} whence;
+	union {
+		/*
+		 * struct {
+		 * 	... Nothing to expose in this case
+		 * } cached;
+		 * struct {
+		 * 	... Nothing to expose in this case
+		 * } loose;
+		 */
+		struct {
+			struct packed_git *pack;
+			off_t offset;
+			unsigned int is_delta;
+		} packed;
+	} u;
+};
+
+/*
+ * Initializer for a "struct object_info" that wants no items. You may
+ * also memset() the memory to all-zeroes.
+ */
+#define OBJECT_INFO_INIT {NULL}
+
+/* Invoke lookup_replace_object() on the given hash */
+#define OBJECT_INFO_LOOKUP_REPLACE 1
+/* Allow reading from a loose object file of unknown/bogus type */
+#define OBJECT_INFO_ALLOW_UNKNOWN_TYPE 2
+/* Do not check cached storage */
+#define OBJECT_INFO_SKIP_CACHED 4
+/* Do not retry packed storage after checking packed and loose storage */
+#define OBJECT_INFO_QUICK 8
+#define sha1_object_info_extended(r, s, oi, f) \
+		sha1_object_info_extended_##r(s, oi, f)
+extern int sha1_object_info_extended_the_repository(const unsigned char *, struct object_info *, unsigned flags);
+
 #endif /* OBJECT_STORE_H */
diff --git a/object.c b/object.c
index b9a4a0e501..4d2ae6851c 100644
--- a/object.c
+++ b/object.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "object.h"
+#include "object-store.h"
 #include "blob.h"
 #include "tree.h"
 #include "commit.h"
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index a8df5ce2ab..6a656104af 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "object-store.h"
 #include "commit.h"
 #include "tag.h"
 #include "diff.h"
diff --git a/packfile.h b/packfile.h
index 1163fc7bb4..0c314eea93 100644
--- a/packfile.h
+++ b/packfile.h
@@ -5,6 +5,9 @@
 enum object_type;
 struct object_info;
 
+/* in object-store.h */
+struct packed_git;
+
 struct pack_window {
 	struct pack_window *next;
 	unsigned char *base;
diff --git a/read-cache.c b/read-cache.c
index 2eb81a66b9..45cad9272a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -11,6 +11,7 @@
 #include "cache-tree.h"
 #include "refs.h"
 #include "dir.h"
+#include "object-store.h"
 #include "tree.h"
 #include "commit.h"
 #include "blob.h"
diff --git a/ref-filter.c b/ref-filter.c
index 3f9161707e..0a106b888d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -3,6 +3,7 @@
 #include "parse-options.h"
 #include "refs.h"
 #include "wildmatch.h"
+#include "object-store.h"
 #include "commit.h"
 #include "remote.h"
 #include "color.h"
diff --git a/refs.c b/refs.c
index 20ba82b434..968d33ac11 100644
--- a/refs.c
+++ b/refs.c
@@ -9,6 +9,7 @@
 #include "iterator.h"
 #include "refs.h"
 #include "refs/refs-internal.h"
+#include "object-store.h"
 #include "object.h"
 #include "tag.h"
 #include "submodule.h"
diff --git a/remote-testsvn.c b/remote-testsvn.c
index bcebb4c789..387d4ae935 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "refs.h"
 #include "remote.h"
+#include "object-store.h"
 #include "strbuf.h"
 #include "url.h"
 #include "exec_cmd.h"
diff --git a/remote.c b/remote.c
index 4e93753e19..5112f370c3 100644
--- a/remote.c
+++ b/remote.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "remote.h"
 #include "refs.h"
+#include "object-store.h"
 #include "commit.h"
 #include "diff.h"
 #include "revision.h"
diff --git a/rerere.c b/rerere.c
index 1ce440f4bb..ab64d3f48e 100644
--- a/rerere.c
+++ b/rerere.c
@@ -9,6 +9,7 @@
 #include "ll-merge.h"
 #include "attr.h"
 #include "pathspec.h"
+#include "object-store.h"
 #include "sha1-lookup.h"
 
 #define RESOLVED 0
diff --git a/revision.c b/revision.c
index 72f2b4572e..9ede92c09e 100644
--- a/revision.c
+++ b/revision.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "object-store.h"
 #include "tag.h"
 #include "blob.h"
 #include "tree.h"
diff --git a/send-pack.c b/send-pack.c
index 2112d3b27a..c2856dcfd5 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "commit.h"
 #include "refs.h"
+#include "object-store.h"
 #include "pkt-line.h"
 #include "sideband.h"
 #include "run-command.h"
diff --git a/sequencer.c b/sequencer.c
index 4d3f60594c..234addd4e7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3,6 +3,7 @@
 #include "lockfile.h"
 #include "sequencer.h"
 #include "dir.h"
+#include "object-store.h"
 #include "object.h"
 #include "commit.h"
 #include "tag.h"
diff --git a/shallow.c b/shallow.c
index df4d44ea7a..c2f81a5a5a 100644
--- a/shallow.c
+++ b/shallow.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "tempfile.h"
 #include "lockfile.h"
+#include "object-store.h"
 #include "commit.h"
 #include "tag.h"
 #include "pkt-line.h"
diff --git a/tag.c b/tag.c
index fcbe012f7a..30798abf1f 100644
--- a/tag.c
+++ b/tag.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "tag.h"
+#include "object-store.h"
 #include "commit.h"
 #include "tree.h"
 #include "blob.h"
diff --git a/tree-walk.c b/tree-walk.c
index 63a87ed666..8bd56eddd5 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -2,6 +2,7 @@
 #include "tree-walk.h"
 #include "unpack-trees.h"
 #include "dir.h"
+#include "object-store.h"
 #include "tree.h"
 #include "pathspec.h"
 
diff --git a/tree.c b/tree.c
index b224115e0f..653339db03 100644
--- a/tree.c
+++ b/tree.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "cache-tree.h"
 #include "tree.h"
+#include "object-store.h"
 #include "blob.h"
 #include "commit.h"
 #include "tag.h"
diff --git a/upload-pack.c b/upload-pack.c
index d5de18127c..6db85ecdc4 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -3,6 +3,7 @@
 #include "refs.h"
 #include "pkt-line.h"
 #include "sideband.h"
+#include "object-store.h"
 #include "tag.h"
 #include "object.h"
 #include "commit.h"
diff --git a/walker.c b/walker.c
index 5d4d3733f7..49b6a96e6e 100644
--- a/walker.c
+++ b/walker.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "walker.h"
+#include "object-store.h"
 #include "commit.h"
 #include "tree.h"
 #include "tree-walk.h"
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 770e1f7f81..a2d0e05edd 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "config.h"
+#include "object-store.h"
 #include "xdiff-interface.h"
 #include "xdiff/xtypes.h"
 #include "xdiff/xdiffi.h"
-- 
2.15.1.433.g936d1b9894.dirty


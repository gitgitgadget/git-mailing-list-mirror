Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C24801FBB5
	for <e@80x24.org>; Tue,  6 Feb 2018 00:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752038AbeBFACx (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:02:53 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36645 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbeBFACv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:02:51 -0500
Received: by mail-pg0-f67.google.com with SMTP id x25so133844pge.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4JvtJcM6jhftzX2h+HmnHslqjAlq0yfgNwmLWFtFEHc=;
        b=G9BDHhY6fJB3F6y+QkOveupwHl52Ki5HH4FmZt+zyhtP12V/MpD4vmoh5KIeh0OXv8
         6yavlnEakp15VKE+/3KKEWXGyXNWqhEHmu6sN4qCFd0Yxl5n9M0TkTM86bXNoiD/3BZi
         tqs6iJ+/MjqOp8Lr9jgzde+vWKRoAJHMDPgkDhM8v2gZOvmkY3XKqzMbEotx33Vx6aXh
         QrfP8INYNTWQqm6ws3b3DD15F+LR3QKtPZHAHxlOCOyNJUzPduS7Q9f9UMuvOc8gDnXq
         gzHGJFa1O8f8NiQfBut/K+WoKUfyFqteZja4AdnU8LA3Aj32cg6mTNmjuH6M2+sxPoJd
         od8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4JvtJcM6jhftzX2h+HmnHslqjAlq0yfgNwmLWFtFEHc=;
        b=uBLMp7HXWF/TuDuif5HhQ6fdWEi+YApViT+zIhGK7qfHpSPBMF64+ixh8dsQ6MsFlF
         K0KLxjcH+H8/X8qjiwkpwb6FshznwB3k2q+nY8lZXvfAGrCbvS6E5ymLsbHvwo2IIG25
         UMXrnsqBUAaRtpAQZGGcwalVPf/YTzdwxwxj/Lg58ne59Hwdhy5rdV+70DK/Ox/M2/QY
         k5lj3W7OUDmhGE6kdZHQh5hnPMx1BMPiEaGDBj/lQ0K4BLTfVVSR9wIuyl3cTrOlp4HO
         zFArZcgxzvHpE/wxpo/aNRzCqRkfzqn+JOKceV6pXI7Hw3BSXFtICoEU2OuDpkhBbhNr
         CZ0w==
X-Gm-Message-State: APf1xPAYqljjd7nOX46y4Nu43b6lS+nGrgAonHWLzwIhCH4yABqY2Mni
        r3O9lxk5/kru/1owaCcb0x7h10cWSVg=
X-Google-Smtp-Source: AH8x227fC6NqqtEtFlqVIWC1bkFFmD0S2XEFOcoTb98z/gJQSgxGwmptHwIf/SpOaownzmw1LuU4eA==
X-Received: by 10.98.64.132 with SMTP id f4mr129927pfd.232.1517875370626;
        Mon, 05 Feb 2018 16:02:50 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id v22sm19789656pfa.158.2018.02.05.16.02.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:02:49 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 043/194] object-store: move loose object functions to new loose-object.h
Date:   Mon,  5 Feb 2018 15:55:04 -0800
Message-Id: <20180205235735.216710-23-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

This should make these functions easier to find and cache.h less
overwhelming to read.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/cat-file.c      |  1 +
 builtin/count-objects.c |  1 +
 builtin/fsck.c          |  1 +
 builtin/pack-objects.c  |  1 +
 builtin/prune-packed.c  |  1 +
 builtin/prune.c         |  1 +
 cache.h                 | 75 ++--------------------------------------
 http-walker.c           |  1 +
 http.c                  |  1 +
 loose-object.h          | 91 +++++++++++++++++++++++++++++++++++++++++++++++++
 object-store.h          |  7 ----
 reachable.c             |  1 +
 sha1_file.c             |  1 +
 sha1_name.c             |  1 +
 14 files changed, 105 insertions(+), 79 deletions(-)
 create mode 100644 loose-object.h

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 9d18efeb7c..fdc70aa419 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -9,6 +9,7 @@
 #include "diff.h"
 #include "parse-options.h"
 #include "userdiff.h"
+#include "loose-object.h"
 #include "streaming.h"
 #include "tree-walk.h"
 #include "sha1-array.h"
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 805803fedd..34f2bfa44e 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -10,6 +10,7 @@
 #include "repository.h"
 #include "alternates.h"
 #include "object-store.h"
+#include "loose-object.h"
 #include "builtin.h"
 #include "parse-options.h"
 #include "quote.h"
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 571aa51579..920cc50923 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -4,6 +4,7 @@
 #include "config.h"
 #include "alternates.h"
 #include "object-store.h"
+#include "loose-object.h"
 #include "commit.h"
 #include "tree.h"
 #include "blob.h"
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d42df2a2b9..b998e139d1 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3,6 +3,7 @@
 #include "repository.h"
 #include "config.h"
 #include "object-store.h"
+#include "loose-object.h"
 #include "attr.h"
 #include "object.h"
 #include "blob.h"
diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
index 419238171d..2da1573359 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "progress.h"
 #include "parse-options.h"
+#include "loose-object.h"
 #include "packfile.h"
 
 static const char * const prune_packed_usage[] = {
diff --git a/builtin/prune.c b/builtin/prune.c
index d2fdae680a..52091f299e 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -3,6 +3,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "builtin.h"
+#include "loose-object.h"
 #include "reachable.h"
 #include "parse-options.h"
 #include "progress.h"
diff --git a/cache.h b/cache.h
index b002c9a96d..7be9a8ad27 100644
--- a/cache.h
+++ b/cache.h
@@ -1244,19 +1244,6 @@ extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned l
 
 extern int finalize_object_file(const char *tmpfile, const char *filename);
 
-/*
- * Open the loose object at path, check its sha1, and return the contents,
- * type, and size. If the object is a blob, then "contents" may return NULL,
- * to allow streaming of large blobs.
- *
- * Returns 0 on success, negative on error (details may be written to stderr).
- */
-int read_loose_object(const char *path,
-		      const unsigned char *expected_sha1,
-		      enum object_type *type,
-		      unsigned long *size,
-		      void **contents);
-
 /*
  * Convenience for sha1_object_info_extended() with a NULL struct
  * object_info. OBJECT_INFO_SKIP_CACHED is automatically set; pass
@@ -1272,13 +1259,6 @@ static inline int has_sha1_file(const unsigned char *sha1)
 extern int has_object_file(const struct object_id *oid);
 extern int has_object_file_with_flags(const struct object_id *oid, int flags);
 
-/*
- * Return true iff an alternate object database has a loose object
- * with the specified name.  This function does not respect replace
- * references.
- */
-extern int has_loose_object_nonlocal(const unsigned char *sha1);
-
 extern void assert_sha1_type(const unsigned char *sha1, enum object_type expect);
 
 /* Helper to check and "touch" a file */
@@ -1595,60 +1575,11 @@ extern int odb_mkstemp(struct strbuf *template, const char *pattern);
 extern int odb_pack_keep(const char *name);
 
 /*
- * Iterate over the files in the loose-object parts of the object
- * directory "path", triggering the following callbacks:
- *
- *  - loose_object is called for each loose object we find.
- *
- *  - loose_cruft is called for any files that do not appear to be
- *    loose objects. Note that we only look in the loose object
- *    directories "objects/[0-9a-f]{2}/", so we will not report
- *    "objects/foobar" as cruft.
- *
- *  - loose_subdir is called for each top-level hashed subdirectory
- *    of the object directory (e.g., "$OBJDIR/f0"). It is called
- *    after the objects in the directory are processed.
- *
- * Any callback that is NULL will be ignored. Callbacks returning non-zero
- * will end the iteration.
- *
- * In the "buf" variant, "path" is a strbuf which will also be used as a
- * scratch buffer, but restored to its original contents before
- * the function returns.
- */
-typedef int each_loose_object_fn(const struct object_id *oid,
-				 const char *path,
-				 void *data);
-typedef int each_loose_cruft_fn(const char *basename,
-				const char *path,
-				void *data);
-typedef int each_loose_subdir_fn(unsigned int nr,
-				 const char *path,
-				 void *data);
-int for_each_file_in_obj_subdir(unsigned int subdir_nr,
-				struct strbuf *path,
-				each_loose_object_fn obj_cb,
-				each_loose_cruft_fn cruft_cb,
-				each_loose_subdir_fn subdir_cb,
-				void *data);
-int for_each_loose_file_in_objdir(const char *path,
-				  each_loose_object_fn obj_cb,
-				  each_loose_cruft_fn cruft_cb,
-				  each_loose_subdir_fn subdir_cb,
-				  void *data);
-int for_each_loose_file_in_objdir_buf(struct strbuf *path,
-				      each_loose_object_fn obj_cb,
-				      each_loose_cruft_fn cruft_cb,
-				      each_loose_subdir_fn subdir_cb,
-				      void *data);
-
-/*
- * Iterate over loose objects in both the local
- * repository and any alternates repositories (unless the
- * LOCAL_ONLY flag is set).
+ * Flag for for_each_packed_object and for_each_loose_object to only iterate
+ * over objects in the local repository, and not any alternates (see
+ * alternates.h).
  */
 #define FOR_EACH_OBJECT_LOCAL_ONLY 0x1
-extern int for_each_loose_object(each_loose_object_fn, void *, unsigned flags);
 
 struct object_info {
 	/* Request */
diff --git a/http-walker.c b/http-walker.c
index 96873bdfed..34594165b1 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -6,6 +6,7 @@
 #include "list.h"
 #include "transport.h"
 #include "object-store.h"
+#include "loose-object.h"
 #include "packfile.h"
 
 struct alt_base {
diff --git a/http.c b/http.c
index ad57476635..e04eca601b 100644
--- a/http.c
+++ b/http.c
@@ -3,6 +3,7 @@
 #include "repository.h"
 #include "config.h"
 #include "object-store.h"
+#include "loose-object.h"
 #include "pack.h"
 #include "sideband.h"
 #include "run-command.h"
diff --git a/loose-object.h b/loose-object.h
new file mode 100644
index 0000000000..7d721ae4f0
--- /dev/null
+++ b/loose-object.h
@@ -0,0 +1,91 @@
+#ifndef LOOSE_OBJECT_H
+#define LOOSE_OBJECT_H
+
+#include "cache.h"
+#include "strbuf.h"
+#include "repository.h"
+
+/*
+ * Open the loose object at path, check its sha1, and return the contents,
+ * type, and size. If the object is a blob, then "contents" may return NULL,
+ * to allow streaming of large blobs.
+ *
+ * Returns 0 on success, negative on error (details may be written to stderr).
+ */
+int read_loose_object(const char *path,
+		      const unsigned char *expected_sha1,
+		      enum object_type *type,
+		      unsigned long *size,
+		      void **contents);
+
+/*
+ * Return true iff an alternate object database has a loose object
+ * with the specified name.  This function does not respect replace
+ * references.
+ */
+extern int has_loose_object_nonlocal(const unsigned char *sha1);
+
+/*
+ * Iterate over the files in the loose-object parts of the object
+ * directory "path", triggering the following callbacks:
+ *
+ *  - loose_object is called for each loose object we find.
+ *
+ *  - loose_cruft is called for any files that do not appear to be
+ *    loose objects. Note that we only look in the loose object
+ *    directories "objects/[0-9a-f]{2}/", so we will not report
+ *    "objects/foobar" as cruft.
+ *
+ *  - loose_subdir is called for each top-level hashed subdirectory
+ *    of the object directory (e.g., "$OBJDIR/f0"). It is called
+ *    after the objects in the directory are processed.
+ *
+ * Any callback that is NULL will be ignored. Callbacks returning non-zero
+ * will end the iteration.
+ *
+ * In the "buf" variant, "path" is a strbuf which will also be used as a
+ * scratch buffer, but restored to its original contents before
+ * the function returns.
+ */
+typedef int each_loose_object_fn(const struct object_id *oid,
+				 const char *path,
+				 void *data);
+typedef int each_loose_cruft_fn(const char *basename,
+				const char *path,
+				void *data);
+typedef int each_loose_subdir_fn(unsigned int nr,
+				 const char *path,
+				 void *data);
+int for_each_file_in_obj_subdir(unsigned int subdir_nr,
+				struct strbuf *path,
+				each_loose_object_fn obj_cb,
+				each_loose_cruft_fn cruft_cb,
+				each_loose_subdir_fn subdir_cb,
+				void *data);
+int for_each_loose_file_in_objdir(const char *path,
+				  each_loose_object_fn obj_cb,
+				  each_loose_cruft_fn cruft_cb,
+				  each_loose_subdir_fn subdir_cb,
+				  void *data);
+int for_each_loose_file_in_objdir_buf(struct strbuf *path,
+				      each_loose_object_fn obj_cb,
+				      each_loose_cruft_fn cruft_cb,
+				      each_loose_subdir_fn subdir_cb,
+				      void *data);
+
+/*
+ * Iterate over loose objects in both the local
+ * repository and any alternates repositories (unless the
+ * FOR_EACH_OBJECT_LOCAL_ONLY flag, defined in cache.h, is set).
+ */
+extern int for_each_loose_object(each_loose_object_fn, void *, unsigned flags);
+
+/*
+ * Return the name of the file in a repository's local object database
+ * that would be used to store a loose object with the specified sha1.
+ * The return value is a pointer to a statically allocated buffer that
+ * is overwritten each time the function is called.
+ */
+extern const char *sha1_file_name(struct repository *r, const unsigned char *sha1);
+
+#endif
diff --git a/object-store.h b/object-store.h
index 967dd8af26..7a372baa79 100644
--- a/object-store.h
+++ b/object-store.h
@@ -66,13 +66,6 @@ struct packed_git {
 	char pack_name[FLEX_ARRAY]; /* more */
 };
 
-/*
- * Return the name of the file in a repository's local object database
- * that would be used to store a loose object with the specified sha1.
- * The return value is a pointer to a statically allocated buffer that
- * is overwritten each time the function is called.
- */
-extern const char *sha1_file_name(struct repository *r, const unsigned char *sha1);
 extern void *map_sha1_file(struct repository *r, const unsigned char *sha1, unsigned long *size);
 
 #endif /* OBJECT_STORE_H */
diff --git a/reachable.c b/reachable.c
index 59ed16ba76..ac5224b9a5 100644
--- a/reachable.c
+++ b/reachable.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "refs.h"
 #include "object-store.h"
+#include "loose-object.h"
 #include "tag.h"
 #include "commit.h"
 #include "blob.h"
diff --git a/sha1_file.c b/sha1_file.c
index 84501d66e9..2584465e9c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -25,6 +25,7 @@
 #include "bulk-checkin.h"
 #include "repository.h"
 #include "object-store.h"
+#include "loose-object.h"
 #include "streaming.h"
 #include "path.h"
 #include "dir.h"
diff --git a/sha1_name.c b/sha1_name.c
index 363f7e1d4d..03ce2ff7f2 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "config.h"
 #include "alternates.h"
+#include "loose-object.h"
 #include "tag.h"
 #include "commit.h"
 #include "tree.h"
-- 
2.15.1.433.g936d1b9894.dirty


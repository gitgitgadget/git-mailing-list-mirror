Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FF2C636D7
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 08:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbjBWIGH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 03:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbjBWIFm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 03:05:42 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0815474E7
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 00:05:32 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id bo30so9352637wrb.0
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 00:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ylvBtxPelarqP9YBgjDVKOIx6WVg+C4F49t/eHOfTE=;
        b=lMo2kXG2FHLUScqM69wejA4wTQ7IECkhSFud6qBlldPb18jOP9H3SdXm8Uq8dB+NdL
         2fdU9tqohDVelLWAulEq8yW+sYLUk7bgS+4Z2OIiJto/ehVgu84idTe1ywR9WZs6UnxZ
         uhn3IY5OLh+/Xf7hwUT2zzJbpoWsSovK4rZ8SsvUsHay8spdzttcql6Zmqgc9w9Igr3s
         hkiACz21gEKibTkPfx0AzvlsaYVocGgRfMFFShSAyZWpnWg6owOtcatxgFekgTwskis0
         IDWx5fQ7JysEVLs+Zq4qADeueNgOCOowgpdQdYVLk4Ujhgapj5SzxHDSYYVFt4Ss0g9K
         ZbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ylvBtxPelarqP9YBgjDVKOIx6WVg+C4F49t/eHOfTE=;
        b=HAeP3jCSny1ESw+a0wgrozVwIpAx9xapn2N8k5kJqAhXSR/raXcisNrWP1bQe2CVrf
         ByNNQ0swWlPBLVjrguhwBq8cEzrC0Kx9gX7+ap46BFFrvn5GdEFjuo2XjDV1Xa47QANG
         UWSWvbxxjyJ5xlmjAosr8Ohl1HhAVsuBzgDETzmNpFY1i1WwLwM7qaYMW3b220OpcBq5
         5OxLU8K1w5hMcVk8Dwc2HjfVbBuUoaq7RqvepKXZUPPvgOiR/x9+4rxlV59fmP3oCOxH
         w5Fhi+MukgK4CDo9cRh7DCcxjJPxX9U12gcx1AXo3hYpqf61TlF8lP4nqs+/xGhK8S5P
         8ocA==
X-Gm-Message-State: AO0yUKXqGVu7CYHstB/KMnOAqf7ZtfpvbheFQPL03X5wgeuYrKvhsWZR
        qizQxiHWXmLYgaBEhXoQ80xdxuN01Rs=
X-Google-Smtp-Source: AK7set8gUsrj5dffn0NNmVEoLPmvuxETCLPiWH1GbGfXiSigQqzVXn8LRkpYcBGJrqEeyEW6YYqDiA==
X-Received: by 2002:a5d:58d9:0:b0:2c5:5fb0:b215 with SMTP id o25-20020a5d58d9000000b002c55fb0b215mr9556866wrf.30.1677139530956;
        Thu, 23 Feb 2023 00:05:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6-20020adfe546000000b002425be3c9e2sm9030326wrm.60.2023.02.23.00.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 00:05:30 -0800 (PST)
Message-Id: <1357f18db5601cf4fc68a56a2e846d2aed6ad6b6.1677139522.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Feb 2023 08:05:15 +0000
Subject: [PATCH 10/16] object.h: stop depending on cache.h; make cache.h
 depend on object.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Emily Shaffer <nasamuffin@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Things should be able to depend on object.h without pulling in all of
cache.h.  Move an enum to allow this.

Note that a couple files previously depended on things brought in
through cache.h indirectly (revision.h -> commit.h -> object.h ->
cache.h).  As such, this change requires making existing dependencies
more explicit in two files.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 alloc.c                          |  2 +-
 blame.h                          |  1 -
 blob.c                           |  2 +-
 cache-tree.h                     |  1 -
 cache.h                          | 21 +--------------------
 diff-merges.c                    |  1 +
 diff.h                           |  2 +-
 diffcore-delta.c                 |  2 +-
 fsck.h                           |  1 +
 help.c                           |  1 +
 list-objects-filter-options.h    |  3 ++-
 negotiator/noop.c                |  2 +-
 object.h                         | 22 +++++++++++++++++++++-
 shallow.h                        |  2 ++
 t/helper/test-bloom.c            |  2 +-
 t/helper/test-example-decorate.c |  2 +-
 worktree.h                       |  1 -
 17 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/alloc.c b/alloc.c
index 27f697e4c87..2886aa93543 100644
--- a/alloc.c
+++ b/alloc.c
@@ -8,7 +8,7 @@
  * up with maximal alignment because it doesn't know what the object alignment
  * for the new allocation is.
  */
-#include "cache.h"
+#include "git-compat-util.h"
 #include "object.h"
 #include "blob.h"
 #include "tree.h"
diff --git a/blame.h b/blame.h
index 38bde535b3d..b60d1d81e30 100644
--- a/blame.h
+++ b/blame.h
@@ -1,7 +1,6 @@
 #ifndef BLAME_H
 #define BLAME_H
 
-#include "cache.h"
 #include "commit.h"
 #include "xdiff-interface.h"
 #include "revision.h"
diff --git a/blob.c b/blob.c
index 8f83523b0cd..888e28a5594 100644
--- a/blob.c
+++ b/blob.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "blob.h"
 #include "repository.h"
 #include "alloc.h"
diff --git a/cache-tree.h b/cache-tree.h
index bd97caa07b0..faae88be63c 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -1,7 +1,6 @@
 #ifndef CACHE_TREE_H
 #define CACHE_TREE_H
 
-#include "cache.h"
 #include "tree.h"
 #include "tree-walk.h"
 
diff --git a/cache.h b/cache.h
index 63ffd197a2a..af15701b063 100644
--- a/cache.h
+++ b/cache.h
@@ -15,6 +15,7 @@
 #include "hash.h"
 #include "hex.h"
 #include "path.h"
+#include "object.h"
 #include "oid-array.h"
 #include "repository.h"
 #include "mem-pool.h"
@@ -454,26 +455,6 @@ void prefetch_cache_entries(const struct index_state *istate,
 extern struct index_state the_index;
 #endif
 
-#define TYPE_BITS 3
-
-/*
- * Values in this enum (except those outside the 3 bit range) are part
- * of pack file format. See gitformat-pack(5) for more information.
- */
-enum object_type {
-	OBJ_BAD = -1,
-	OBJ_NONE = 0,
-	OBJ_COMMIT = 1,
-	OBJ_TREE = 2,
-	OBJ_BLOB = 3,
-	OBJ_TAG = 4,
-	/* 5 for future expansion */
-	OBJ_OFS_DELTA = 6,
-	OBJ_REF_DELTA = 7,
-	OBJ_ANY,
-	OBJ_MAX
-};
-
 static inline enum object_type object_type(unsigned int mode)
 {
 	return S_ISDIR(mode) ? OBJ_TREE :
diff --git a/diff-merges.c b/diff-merges.c
index faa7bc73a34..ec97616db1d 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "diff-merges.h"
 
+#include "gettext.h"
 #include "revision.h"
 
 typedef void (*diff_merges_setup_func_t)(struct rev_info *);
diff --git a/diff.h b/diff.h
index 41eb2c3d428..b90036f5294 100644
--- a/diff.h
+++ b/diff.h
@@ -8,6 +8,7 @@
 #include "pathspec.h"
 #include "object.h"
 #include "oidset.h"
+#include "strbuf.h"
 
 /**
  * The diff API is for programs that compare two sets of files (e.g. two trees,
@@ -71,7 +72,6 @@ struct oid_array;
 struct option;
 struct repository;
 struct rev_info;
-struct strbuf;
 struct userdiff_driver;
 
 typedef int (*pathchange_fn_t)(struct diff_options *options,
diff --git a/diffcore-delta.c b/diffcore-delta.c
index 18d8f766d70..c30b56e983b 100644
--- a/diffcore-delta.c
+++ b/diffcore-delta.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "diff.h"
 #include "diffcore.h"
 
diff --git a/fsck.h b/fsck.h
index 668330880ef..e17730e9da9 100644
--- a/fsck.h
+++ b/fsck.h
@@ -1,6 +1,7 @@
 #ifndef GIT_FSCK_H
 #define GIT_FSCK_H
 
+#include "object.h"
 #include "oidset.h"
 
 enum fsck_msg_type {
diff --git a/help.c b/help.c
index 5f84a50b948..216777d2bf4 100644
--- a/help.c
+++ b/help.c
@@ -5,6 +5,7 @@
 #include "exec-cmd.h"
 #include "run-command.h"
 #include "levenshtein.h"
+#include "gettext.h"
 #include "help.h"
 #include "command-list.h"
 #include "string-list.h"
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index 1fe393f4473..ef03b45132e 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -1,9 +1,10 @@
 #ifndef LIST_OBJECTS_FILTER_OPTIONS_H
 #define LIST_OBJECTS_FILTER_OPTIONS_H
 
-#include "cache.h"
+#include "object.h"
 #include "parse-options.h"
 #include "string-list.h"
+#include "strbuf.h"
 
 /*
  * The list of defined filters for list-objects.
diff --git a/negotiator/noop.c b/negotiator/noop.c
index 60569b83501..7b729376867 100644
--- a/negotiator/noop.c
+++ b/negotiator/noop.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "noop.h"
 #include "../commit.h"
 #include "../fetch-negotiator.h"
diff --git a/object.h b/object.h
index 31ebe114585..fc45b158da0 100644
--- a/object.h
+++ b/object.h
@@ -1,7 +1,7 @@
 #ifndef OBJECT_H
 #define OBJECT_H
 
-#include "cache.h"
+#include "hash.h"
 
 struct buffer_slab;
 
@@ -81,6 +81,26 @@ struct object_array {
  */
 #define FLAG_BITS  28
 
+#define TYPE_BITS 3
+
+/*
+ * Values in this enum (except those outside the 3 bit range) are part
+ * of pack file format. See gitformat-pack(5) for more information.
+ */
+enum object_type {
+	OBJ_BAD = -1,
+	OBJ_NONE = 0,
+	OBJ_COMMIT = 1,
+	OBJ_TREE = 2,
+	OBJ_BLOB = 3,
+	OBJ_TAG = 4,
+	/* 5 for future expansion */
+	OBJ_OFS_DELTA = 6,
+	OBJ_REF_DELTA = 7,
+	OBJ_ANY,
+	OBJ_MAX
+};
+
 /*
  * The object type is stored in 3 bits.
  */
diff --git a/shallow.h b/shallow.h
index aba6ff58294..e9ca7e4bc80 100644
--- a/shallow.h
+++ b/shallow.h
@@ -6,6 +6,8 @@
 #include "repository.h"
 #include "strbuf.h"
 
+struct oid_array;
+
 void set_alternate_shallow_file(struct repository *r, const char *path, int override);
 int register_shallow(struct repository *r, const struct object_id *oid);
 int unregister_shallow(const struct object_id *oid);
diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index 6c900ca6684..010ea5148e4 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -1,4 +1,4 @@
-#include "git-compat-util.h"
+#include "cache.h"
 #include "bloom.h"
 #include "test-tool.h"
 #include "commit.h"
diff --git a/t/helper/test-example-decorate.c b/t/helper/test-example-decorate.c
index b9d1200eb98..7c7fc8efc13 100644
--- a/t/helper/test-example-decorate.c
+++ b/t/helper/test-example-decorate.c
@@ -1,5 +1,5 @@
 #include "test-tool.h"
-#include "cache.h"
+#include "git-compat-util.h"
 #include "object.h"
 #include "decorate.h"
 
diff --git a/worktree.h b/worktree.h
index 9dcea6fc8c1..2baeca2a8a6 100644
--- a/worktree.h
+++ b/worktree.h
@@ -1,7 +1,6 @@
 #ifndef WORKTREE_H
 #define WORKTREE_H
 
-#include "cache.h"
 #include "refs.h"
 
 struct strbuf;
-- 
gitgitgadget


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C3DC77B71
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 03:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjDPDDo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 23:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjDPDDe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 23:03:34 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD4D2718
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:31 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l31-20020a05600c1d1f00b003f1718d89b2so283354wms.0
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681614209; x=1684206209;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0HmzcHwed6ewbtQEwqHWQI6W3WAuOMs2WQXW3DKngU=;
        b=Yj4AbOYaDMfFffJCBpePz85m9j7WUk460ontdonA6l1a+a8ejRnYkngjtUDGnDX3Rg
         DxSerE/ghZF2BWybh5wS9n9YpcK/+j5xYy6CmJxqXylDfgWxNYNqKjOpQg2gZ6jHytr+
         PfuZ8bpYid12MuT3+2rOAm25OegxvOR2zUaQaniHUq/Xo0uqrZRovnuoaOT77JiSwtAJ
         qeYGtcmu0W1iT7JR8/lnKm1jcyy/uG67Wgjh5lnAnz3q9a+AZe/D3azgJB59RFoQyZU6
         nUVkMK8jr+Y6uzat0hUzxq04SwONYqNW+14fXk5dAVvtM9gb3kaR7/XJViCxHhXl8EMc
         RHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681614209; x=1684206209;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0HmzcHwed6ewbtQEwqHWQI6W3WAuOMs2WQXW3DKngU=;
        b=luwEhTf66hwgeNH6DNwe2jdsd7+OdOGoIEdNp9fXCbCbP1xR6K8uq9Dou+9K3kFBZC
         wO2N3+mP/CnC0m0PUbPiSaW8cW4mT5wrGy/pgZC5/OPyGu0zflgda0q7iG3RgMG9MsI2
         HtULjIs1bgZzadFdlzQmgb2VOtN1F77ZKGRc+AXneDP9PXIdAg6PCgQZ2CFAKPvGn3Xj
         1zoB2oE7UavDAYxWBoUO2UhBxb3GZVk2Lydu9/XxeHsgVfU5F14NdrLkke+VQT8nlphX
         05IUq4P8zBnsR5XQdQVTI9W6ys20LTZIgpelVzNRpAxSmnZeXspxzGsrNoUlDAPpk9us
         38LA==
X-Gm-Message-State: AAQBX9fV9bGqw5EiCQVYHQwmW/JMwAqAqafbwK+iicllzDqheVzHBHUN
        +zi/D7TTyouMD6BjZXZp4a+C6AH8gjY=
X-Google-Smtp-Source: AKy350bLaAnFAb4mSpZuVXKOisNQCfnMWtFWy8c58B2c1+sdwGyJRbN0pgBJIiO5TVDr4sRq23bpRg==
X-Received: by 2002:a05:600c:2208:b0:3ee:93c8:4a6f with SMTP id z8-20020a05600c220800b003ee93c84a6fmr7848147wml.32.1681614209547;
        Sat, 15 Apr 2023 20:03:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k16-20020adff290000000b002f53fa16239sm6991220wro.103.2023.04.15.20.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 20:03:29 -0700 (PDT)
Message-Id: <9f9a3561295de9f9af33b574d7e1d5d752ed76cf.1681614206.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 16 Apr 2023 03:03:04 +0000
Subject: [PATCH 02/23] symlinks.h: move declarations for symlinks.c functions
 from cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 apply.c                |  1 +
 builtin/checkout.c     |  1 +
 builtin/update-index.c |  1 +
 cache.h                | 22 ----------------------
 compat/mingw.c         |  1 +
 diff-lib.c             |  1 +
 dir.c                  |  1 +
 entry.c                |  1 +
 merge-recursive.c      |  1 +
 parallel-checkout.c    |  1 +
 pathspec.c             |  1 +
 preload-index.c        |  1 +
 read-cache.c           |  1 +
 run-command.c          |  1 +
 symlinks.c             |  3 ++-
 symlinks.h             | 28 ++++++++++++++++++++++++++++
 unpack-trees.c         |  1 +
 17 files changed, 44 insertions(+), 23 deletions(-)
 create mode 100644 symlinks.h

diff --git a/apply.c b/apply.c
index 2868cef5ddd..efe2dcb0e62 100644
--- a/apply.c
+++ b/apply.c
@@ -30,6 +30,7 @@
 #include "apply.h"
 #include "entry.h"
 #include "setup.h"
+#include "symlinks.h"
 #include "wrapper.h"
 
 struct gitdiff_data {
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 6f5d82ed3d3..715eeb5048f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -28,6 +28,7 @@
 #include "setup.h"
 #include "submodule.h"
 #include "submodule-config.h"
+#include "symlinks.h"
 #include "trace2.h"
 #include "tree.h"
 #include "tree-walk.h"
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 33b00cef151..58bbc80db77 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -23,6 +23,7 @@
 #include "dir.h"
 #include "setup.h"
 #include "split-index.h"
+#include "symlinks.h"
 #include "fsmonitor.h"
 #include "write-or-die.h"
 
diff --git a/cache.h b/cache.h
index 2f21704da9e..e225964b3ea 100644
--- a/cache.h
+++ b/cache.h
@@ -614,28 +614,6 @@ int df_name_compare(const char *name1, size_t len1, int mode1,
 int name_compare(const char *name1, size_t len1, const char *name2, size_t len2);
 int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2);
 
-struct cache_def {
-	struct strbuf path;
-	int flags;
-	int track_flags;
-	int prefix_len_stat_func;
-};
-#define CACHE_DEF_INIT { \
-	.path = STRBUF_INIT, \
-}
-static inline void cache_def_clear(struct cache_def *cache)
-{
-	strbuf_release(&cache->path);
-}
-
-int has_symlink_leading_path(const char *name, int len);
-int threaded_has_symlink_leading_path(struct cache_def *, const char *, int);
-int check_leading_path(const char *name, int len, int warn_on_lstat_err);
-int has_dirs_only_path(const char *name, int len, int prefix_len);
-void invalidate_lstat_cache(void);
-void schedule_dir_for_removal(const char *name, int len);
-void remove_scheduled_dirs(void);
-
 struct pack_window {
 	struct pack_window *next;
 	unsigned char *base;
diff --git a/compat/mingw.c b/compat/mingw.c
index abbc3faf32f..d06cdc6254f 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -13,6 +13,7 @@
 #include "../config.h"
 #include "../environment.h"
 #include "../trace2.h"
+#include "../symlinks.h"
 #include "../wrapper.h"
 #include "dir.h"
 #include "gettext.h"
diff --git a/diff-lib.c b/diff-lib.c
index d292405a262..60e979dc1bd 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -14,6 +14,7 @@
 #include "unpack-trees.h"
 #include "refs.h"
 #include "submodule.h"
+#include "symlinks.h"
 #include "trace.h"
 #include "dir.h"
 #include "fsmonitor.h"
diff --git a/dir.c b/dir.c
index aa840995c40..ed262fa6e43 100644
--- a/dir.c
+++ b/dir.c
@@ -25,6 +25,7 @@
 #include "fsmonitor.h"
 #include "setup.h"
 #include "submodule-config.h"
+#include "symlinks.h"
 #include "trace2.h"
 #include "wrapper.h"
 
diff --git a/entry.c b/entry.c
index d89e61fa641..91a540bd29f 100644
--- a/entry.c
+++ b/entry.c
@@ -7,6 +7,7 @@
 #include "hex.h"
 #include "streaming.h"
 #include "submodule.h"
+#include "symlinks.h"
 #include "progress.h"
 #include "fsmonitor.h"
 #include "entry.h"
diff --git a/merge-recursive.c b/merge-recursive.c
index 9875bdb11cb..d4d2ab05b2e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -30,6 +30,7 @@
 #include "string-list.h"
 #include "submodule-config.h"
 #include "submodule.h"
+#include "symlinks.h"
 #include "tag.h"
 #include "tree-walk.h"
 #include "unpack-trees.h"
diff --git a/parallel-checkout.c b/parallel-checkout.c
index 50fd7fe31ef..7f0569cc930 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -10,6 +10,7 @@
 #include "run-command.h"
 #include "sigchain.h"
 #include "streaming.h"
+#include "symlinks.h"
 #include "thread-utils.h"
 #include "trace2.h"
 #include "wrapper.h"
diff --git a/pathspec.c b/pathspec.c
index 6972d515f0c..ec335a214e2 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -8,6 +8,7 @@
 #include "attr.h"
 #include "setup.h"
 #include "strvec.h"
+#include "symlinks.h"
 #include "quote.h"
 
 /*
diff --git a/preload-index.c b/preload-index.c
index 4abf9c983b2..7a26b08c213 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -11,6 +11,7 @@
 #include "progress.h"
 #include "thread-utils.h"
 #include "repository.h"
+#include "symlinks.h"
 #include "trace2.h"
 
 /*
diff --git a/read-cache.c b/read-cache.c
index f225bf44cd0..206c003e558 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -30,6 +30,7 @@
 #include "trace2.h"
 #include "varint.h"
 #include "split-index.h"
+#include "symlinks.h"
 #include "utf8.h"
 #include "fsmonitor.h"
 #include "thread-utils.h"
diff --git a/run-command.c b/run-command.c
index e64bb08a5bf..d4247d5fcc6 100644
--- a/run-command.c
+++ b/run-command.c
@@ -5,6 +5,7 @@
 #include "gettext.h"
 #include "sigchain.h"
 #include "strvec.h"
+#include "symlinks.h"
 #include "thread-utils.h"
 #include "strbuf.h"
 #include "string-list.h"
diff --git a/symlinks.c b/symlinks.c
index 27ecc93693b..b29e340c2da 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -1,6 +1,7 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "gettext.h"
 #include "setup.h"
+#include "symlinks.h"
 
 static int threaded_check_leading_path(struct cache_def *cache, const char *name,
 				       int len, int warn_on_lstat_err);
diff --git a/symlinks.h b/symlinks.h
new file mode 100644
index 00000000000..7ae3d5b8569
--- /dev/null
+++ b/symlinks.h
@@ -0,0 +1,28 @@
+#ifndef SYMLINKS_H
+#define SYMLINKS_H
+
+#include "strbuf.h"
+
+struct cache_def {
+	struct strbuf path;
+	int flags;
+	int track_flags;
+	int prefix_len_stat_func;
+};
+#define CACHE_DEF_INIT { \
+	.path = STRBUF_INIT, \
+}
+static inline void cache_def_clear(struct cache_def *cache)
+{
+	strbuf_release(&cache->path);
+}
+
+int has_symlink_leading_path(const char *name, int len);
+int threaded_has_symlink_leading_path(struct cache_def *, const char *, int);
+int check_leading_path(const char *name, int len, int warn_on_lstat_err);
+int has_dirs_only_path(const char *name, int len, int prefix_len);
+void invalidate_lstat_cache(void);
+void schedule_dir_for_removal(const char *name, int len);
+void remove_scheduled_dirs(void);
+
+#endif /* SYMLINKS_H */
diff --git a/unpack-trees.c b/unpack-trees.c
index c6de2ca5a7e..e8a5295e737 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -18,6 +18,7 @@
 #include "sparse-index.h"
 #include "submodule.h"
 #include "submodule-config.h"
+#include "symlinks.h"
 #include "trace2.h"
 #include "fsmonitor.h"
 #include "object-store.h"
-- 
gitgitgadget


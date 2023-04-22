Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF387C7618E
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 20:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjDVURm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 16:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjDVURk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 16:17:40 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0C81BF0
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:38 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-2f917585b26so2723977f8f.0
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682194657; x=1684786657;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRbXvIUTiK9IA6w/UEdG2n6tqOzY+Y9znfe+E5mXp/A=;
        b=od374OpPcQ2LpeU8kQtEXzudkjHQftQ9RUdli9+CtxHTo8BKdzoQC0wMLBN2RyFoMg
         1gFdzC1qmJ+mFHrt5mU6Eck050RaUsk2L2+c+MpbT4w1umQUw0qHf9JINTWanvYbpIjE
         SkMdWhK6L2mCxXTRkcTMJO1tPxkap7Yim/y9uMoCv5YbaBdngjLukVOZeLQGuVKY/MHK
         sCZ5E9Lqqt+GFIclPIMg7R9ipcJvbDpY8ZctBVcfznsbPOELcVCW5oR6aLXQ1c1VOhnY
         w/cgz4sZhuBSq9Zi1gvxfBXXhog7m9z5OfUjX8V0emJEPQhApnrv3yC+29K5EjcMt53w
         MjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682194657; x=1684786657;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRbXvIUTiK9IA6w/UEdG2n6tqOzY+Y9znfe+E5mXp/A=;
        b=W/okRfbFlWJGyCu8FnC8/+oFDHkKaXTruqZIGUrmOACK8QM7aAB7ReGXm/n5Qc1XM9
         Xwn4MHnNBi2p6xlJ8jmYC0bt5P5Ujb0bpXS6bl4H4KHx9dosKc64WsZomVlYfepI3IiP
         Hs6PDdwUC8u/xPH+1aQCZOwYxmq8bu51TJRpy/KZJMPkUwLfqCaBwnp3fVQR9h5GvcM9
         uT//Vt1sZbsOqIj6gR9YWzTADWt+06Ebxx8eYMh2cqdnDGpLRpNm8bOOvRDK1YsGJNaz
         H+rn4PwSbFLD4m2xW4TNv0u8ftHeMkVKKfzxDlI5EPYVweKKlq0QDXpFdDhE7XZTfeXE
         poJA==
X-Gm-Message-State: AAQBX9ejhvHrJ+F+ktf9etsev87wTJpZikpWycZnPGtTz8ZvJsgGz7vy
        y/SQaK9tpH7AUycULcePOSjvO0QnbTE=
X-Google-Smtp-Source: AKy350alDSyzOnv1Ez6tcjcGVEwf3p0UV84rEIlER08NUK9Vz/trBD9paCtnZEse7+5KWJHlJ6lIRA==
X-Received: by 2002:a5d:6b04:0:b0:2f6:121a:c1d0 with SMTP id v4-20020a5d6b04000000b002f6121ac1d0mr6535507wrw.19.1682194656466;
        Sat, 22 Apr 2023 13:17:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m10-20020a5d56ca000000b002c54c9bd71fsm7197733wrw.93.2023.04.22.13.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 13:17:35 -0700 (PDT)
Message-Id: <4a1f197e1e09e0941ce4a3b658cd199df52eeee5.1682194651.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
        <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Apr 2023 20:17:09 +0000
Subject: [PATCH v2 02/22] symlinks.h: move declarations for symlinks.c
 functions from cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
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
index 71e2fe74c4f..ffec289dc5d 100644
--- a/cache.h
+++ b/cache.h
@@ -593,28 +593,6 @@ int df_name_compare(const char *name1, size_t len1, int mode1,
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


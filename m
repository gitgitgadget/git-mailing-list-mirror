Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E58C77B7D
	for <git@archiver.kernel.org>; Sun,  7 May 2023 03:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjEGDrf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 23:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjEGDrH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 23:47:07 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01250191D4
        for <git@vger.kernel.org>; Sat,  6 May 2023 20:46:06 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f315735514so135932605e9.1
        for <git@vger.kernel.org>; Sat, 06 May 2023 20:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683431166; x=1686023166;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hoiqaguwhnODUg14KydfB9G/f8pgwlbBJIn58whY6a8=;
        b=CedR68m9mzFB34eLuS8Z4+8VkQe5pE2BhKDa0mtgK8lPnHcT+EkD/pl8m3gxnqDllJ
         Pkfo+ojYs4zGSjFWSmeNP8sTJ95ZPqLORpkCwgoviXwmyOToXtJ+ljWdYnrsfQSEXYWO
         wXlkNefGDwabLxxE7xKvaIEM/lPryRKCmcR3Cftv1L0qI0A0zt8qk+zGNnDgDGd8Jlo5
         RPK9jTBOwvTIp4rvQQmm6fZ6RW4ctv+bWlGCvNupwWSkTnlHEGd8Oj3peME7GdeR9abz
         FYp0F2Wa0OiI4ueXsUoYDtWayeXBSi+NmVwQelOv9kGrdnpSJvA/3pE262yjvn7i/PcY
         C3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683431166; x=1686023166;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hoiqaguwhnODUg14KydfB9G/f8pgwlbBJIn58whY6a8=;
        b=HGKRRdLwHdjC44syHVbATxcU4w3avr8SltWzGiOHK0VhxJVnUM+/Gg0tLXjikRV/LT
         uQONRXvDcCsQUDwBKmkeCuwZQ+Tc5ruy2YiH5QAWs4fzloq7j/lDanNh1MQV69jWmCxx
         Vk4jai1xfRHWgF6ihlC3nSAELhIgHvVFRsDD54hH5hrXqVSzP7M8CVtyXwz/wmzaexHD
         UKpm2wpbwRL5h/eGpfcqRa307vtRku4bjJZKEOtJeQ1/u94pUJtndLTnFqDZnZtNFhEK
         o1VS91dtgiR0VTuyltDhFEDTfnWcrWNS879hfncd87gYTo8JJCmKYuUcjjlnCbeWy2I8
         5N2Q==
X-Gm-Message-State: AC+VfDxx1mbQzx/nC4Qg+wmtQtYh1Yo9H1k9x9sUrKrsocPfwqRsOWqX
        Ds4jawOvNrL9frJ/OVtEmwOZfhYqwHc=
X-Google-Smtp-Source: ACHHUZ4JTlddVKrmSqOWRMpXy2iTnTn+/Ip0Y73zB1kU5XmpsN7BhuuzjZPRKUr9ivvVLsX607LYhg==
X-Received: by 2002:a5d:61d1:0:b0:306:2be3:6d40 with SMTP id q17-20020a5d61d1000000b003062be36d40mr7147939wrv.35.1683431165266;
        Sat, 06 May 2023 20:46:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m9-20020a05600c3b0900b003f1978bbcd6sm1980694wms.3.2023.05.06.20.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 20:46:05 -0700 (PDT)
Message-Id: <986a056e5805e4b4e140b3c290824703c1c5ee77.1683431151.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 07 May 2023 03:45:40 +0000
Subject: [PATCH 15/24] read-cache*.h: move declarations for read-cache.c
 functions from cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

For the functions defined in read-cache.c, move their declarations from
cache.h to a new header, read-cache-ll.h.  Also move some related inline
functions from cache.h to read-cache.h.  The purpose of the
read-cache-ll.h/read-cache.h split is that about 70% of the sites don't
need the inline functions and the extra headers they include.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 add-interactive.c                    |   1 +
 add-patch.c                          |   1 +
 apply.c                              |   1 +
 attr.c                               |   1 +
 blame.c                              |   1 +
 builtin/add.c                        |   1 +
 builtin/checkout--worker.c           |   1 +
 builtin/checkout-index.c             |   1 +
 builtin/checkout.c                   |   1 +
 builtin/clean.c                      |   1 +
 builtin/commit.c                     |   1 +
 builtin/describe.c                   |   1 +
 builtin/diff-tree.c                  |   1 +
 builtin/diff.c                       |   1 +
 builtin/difftool.c                   |   1 +
 builtin/fsck.c                       |   1 +
 builtin/grep.c                       |   1 +
 builtin/ls-files.c                   |   1 +
 builtin/merge-index.c                |   1 +
 builtin/mv.c                         |   1 +
 builtin/pull.c                       |   1 +
 builtin/rev-parse.c                  |   1 +
 builtin/rm.c                         |   1 +
 builtin/stash.c                      |   1 +
 builtin/submodule--helper.c          |   1 +
 builtin/update-index.c               |   1 +
 builtin/worktree.c                   |   1 +
 cache-tree.c                         |   1 +
 cache.h                              | 520 ---------------------------
 compat/precompose_utf8.c             |   1 +
 compat/sha1-chunked.c                |   1 +
 config.c                             |   1 +
 convert.c                            |   1 +
 diff-lib.c                           |   1 +
 diff.c                               |   1 +
 diffcore-break.c                     |   3 +-
 environment.h                        |   3 +-
 fsmonitor.h                          |   2 +
 git.c                                |   1 +
 hash-lookup.c                        |   1 +
 merge-ort-wrappers.c                 |   1 +
 merge-ort.c                          |   1 +
 name-hash.c                          |   2 +
 object-name.c                        |   1 +
 oidmap.h                             |   1 +
 parallel-checkout.c                  |   1 +
 pathspec.c                           |   1 +
 preload-index.c                      |   1 +
 read-cache-ll.h                      | 481 +++++++++++++++++++++++++
 read-cache.c                         |   1 +
 read-cache.h                         |  45 +++
 repository.c                         |   1 +
 rerere.c                             |   1 +
 resolve-undo.c                       |   1 +
 revision.c                           |   1 +
 split-index.c                        |   1 +
 submodule.c                          |   1 +
 t/helper/test-cache-tree.c           |   1 +
 t/helper/test-dump-cache-tree.c      |   1 +
 t/helper/test-dump-fsmonitor.c       |   1 +
 t/helper/test-dump-split-index.c     |   1 +
 t/helper/test-dump-untracked-cache.c |   1 +
 t/helper/test-fast-rebase.c          |   1 +
 t/helper/test-fsmonitor-client.c     |   1 +
 t/helper/test-hash-speed.c           |   1 +
 t/helper/test-index-version.c        |   1 +
 t/helper/test-lazy-init-name-hash.c  |   1 +
 t/helper/test-path-utils.c           |   1 +
 t/helper/test-read-cache.c           |   1 +
 t/helper/test-scrap-cache-tree.c     |   1 +
 t/helper/test-sha1.c                 |   1 +
 t/helper/test-sha256.c               |   1 +
 t/helper/test-strcmp-offset.c        |   1 +
 t/helper/test-write-cache.c          |   1 +
 unpack-trees.c                       |   1 +
 unpack-trees.h                       |   2 +-
 wt-status.c                          |   1 +
 77 files changed, 603 insertions(+), 524 deletions(-)
 create mode 100644 read-cache-ll.h
 create mode 100644 read-cache.h

diff --git a/add-interactive.c b/add-interactive.c
index 99f7dc3b0d1..a9671e33491 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -6,6 +6,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "preload-index.h"
+#include "read-cache-ll.h"
 #include "revision.h"
 #include "refs.h"
 #include "string-list.h"
diff --git a/add-patch.c b/add-patch.c
index 8d770d203ff..7d4d298286d 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -6,6 +6,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "object-name.h"
+#include "read-cache-ll.h"
 #include "strbuf.h"
 #include "run-command.h"
 #include "strvec.h"
diff --git a/apply.c b/apply.c
index 3da33bb88fd..f056c8f3bb9 100644
--- a/apply.c
+++ b/apply.c
@@ -28,6 +28,7 @@
 #include "object-file.h"
 #include "parse-options.h"
 #include "quote.h"
+#include "read-cache.h"
 #include "rerere.h"
 #include "apply.h"
 #include "entry.h"
diff --git a/attr.c b/attr.c
index ddf2b0cbc2e..57c813d8e77 100644
--- a/attr.c
+++ b/attr.c
@@ -16,6 +16,7 @@
 #include "gettext.h"
 #include "utf8.h"
 #include "quote.h"
+#include "read-cache-ll.h"
 #include "revision.h"
 #include "object-store.h"
 #include "setup.h"
diff --git a/blame.c b/blame.c
index 58dd58b6c97..a29ae7c14b2 100644
--- a/blame.c
+++ b/blame.c
@@ -8,6 +8,7 @@
 #include "diffcore.h"
 #include "gettext.h"
 #include "hex.h"
+#include "read-cache.h"
 #include "setup.h"
 #include "tag.h"
 #include "trace2.h"
diff --git a/builtin/add.c b/builtin/add.c
index 8397be4f8de..9fe6b6ce290 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -20,6 +20,7 @@
 #include "preload-index.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "read-cache.h"
 #include "revision.h"
 #include "bulk-checkin.h"
 #include "strvec.h"
diff --git a/builtin/checkout--worker.c b/builtin/checkout--worker.c
index 2120dd1d300..c655dc4b136 100644
--- a/builtin/checkout--worker.c
+++ b/builtin/checkout--worker.c
@@ -6,6 +6,7 @@
 #include "parallel-checkout.h"
 #include "parse-options.h"
 #include "pkt-line.h"
+#include "read-cache-ll.h"
 
 static void packet_to_pc_item(const char *buffer, int len,
 			      struct parallel_checkout_item *pc_item)
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index b1cd8bef264..f62f13f2b53 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -16,6 +16,7 @@
 #include "parse-options.h"
 #include "entry.h"
 #include "parallel-checkout.h"
+#include "read-cache-ll.h"
 #include "setup.h"
 #include "sparse-index.h"
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2d72a742d9d..09b84156492 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -21,6 +21,7 @@
 #include "object-store.h"
 #include "parse-options.h"
 #include "preload-index.h"
+#include "read-cache.h"
 #include "refs.h"
 #include "remote.h"
 #include "resolve-undo.h"
diff --git a/builtin/clean.c b/builtin/clean.c
index 78852d28cec..49c7af45b03 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -14,6 +14,7 @@
 #include "dir.h"
 #include "gettext.h"
 #include "parse-options.h"
+#include "read-cache-ll.h"
 #include "repository.h"
 #include "setup.h"
 #include "string-list.h"
diff --git a/builtin/commit.c b/builtin/commit.c
index fa769045c88..5be05c9d9e1 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -31,6 +31,7 @@
 #include "object-name.h"
 #include "parse-options.h"
 #include "preload-index.h"
+#include "read-cache.h"
 #include "string-list.h"
 #include "rerere.h"
 #include "unpack-trees.h"
diff --git a/builtin/describe.c b/builtin/describe.c
index 55b4baaa223..f1be7c36948 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -13,6 +13,7 @@
 #include "exec-cmd.h"
 #include "object-name.h"
 #include "parse-options.h"
+#include "read-cache-ll.h"
 #include "revision.h"
 #include "diff.h"
 #include "hashmap.h"
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 0b02c62b85e..5a1e5d6df7c 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -8,6 +8,7 @@
 #include "log-tree.h"
 #include "builtin.h"
 #include "submodule.h"
+#include "read-cache-ll.h"
 #include "repository.h"
 #include "tree.h"
 
diff --git a/builtin/diff.c b/builtin/diff.c
index 967550739a6..a9ce701ff97 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -17,6 +17,7 @@
 #include "diff-merges.h"
 #include "diffcore.h"
 #include "preload-index.h"
+#include "read-cache-ll.h"
 #include "revision.h"
 #include "log-tree.h"
 #include "builtin.h"
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 2c27a59e04a..88809976c53 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -23,6 +23,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "parse-options.h"
+#include "read-cache-ll.h"
 #include "sparse-index.h"
 #include "strvec.h"
 #include "strbuf.h"
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 7134596d218..e8c5fbca58f 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -22,6 +22,7 @@
 #include "object-file.h"
 #include "object-name.h"
 #include "object-store.h"
+#include "read-cache-ll.h"
 #include "replace-object.h"
 #include "resolve-undo.h"
 #include "run-command.h"
diff --git a/builtin/grep.c b/builtin/grep.c
index b86c754defb..0d567575890 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -31,6 +31,7 @@
 #include "object-store.h"
 #include "packfile.h"
 #include "pager.h"
+#include "read-cache-ll.h"
 #include "write-or-die.h"
 
 static const char *grep_prefix;
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 45b3b0ce5d8..d8c1c62bcb0 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -21,6 +21,7 @@
 #include "resolve-undo.h"
 #include "string-list.h"
 #include "pathspec.h"
+#include "read-cache.h"
 #include "run-command.h"
 #include "setup.h"
 #include "sparse-index.h"
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index d16e8aa414b..270d5f644ac 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -1,6 +1,7 @@
 #define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "hex.h"
+#include "read-cache-ll.h"
 #include "repository.h"
 #include "run-command.h"
 #include "sparse-index.h"
diff --git a/builtin/mv.c b/builtin/mv.c
index e058b574654..ae462bd7d41 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -19,6 +19,7 @@
 #include "cache-tree.h"
 #include "string-list.h"
 #include "parse-options.h"
+#include "read-cache-ll.h"
 #include "repository.h"
 #include "setup.h"
 #include "submodule.h"
diff --git a/builtin/pull.c b/builtin/pull.c
index f9ddc94ba9a..8aeb5abc7fb 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -20,6 +20,7 @@
 #include "oid-array.h"
 #include "remote.h"
 #include "dir.h"
+#include "read-cache-ll.h"
 #include "rebase.h"
 #include "refs.h"
 #include "refspec.h"
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 852e49e3403..ad93e5fad88 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -18,6 +18,7 @@
 #include "object-name.h"
 #include "parse-options.h"
 #include "diff.h"
+#include "read-cache-ll.h"
 #include "revision.h"
 #include "setup.h"
 #include "split-index.h"
diff --git a/builtin/rm.c b/builtin/rm.c
index 377a0f66ad8..463eeabceaa 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -16,6 +16,7 @@
 #include "tree-walk.h"
 #include "object-name.h"
 #include "parse-options.h"
+#include "read-cache.h"
 #include "repository.h"
 #include "string-list.h"
 #include "setup.h"
diff --git a/builtin/stash.c b/builtin/stash.c
index 06527ee8471..d3d5bb95e26 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -18,6 +18,7 @@
 #include "dir.h"
 #include "entry.h"
 #include "preload-index.h"
+#include "read-cache.h"
 #include "rerere.h"
 #include "revision.h"
 #include "setup.h"
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 597e780a93a..86324b829a7 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -13,6 +13,7 @@
 #include "pathspec.h"
 #include "preload-index.h"
 #include "dir.h"
+#include "read-cache.h"
 #include "setup.h"
 #include "sparse-index.h"
 #include "submodule.h"
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 47dc9b626ef..484a307df50 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -22,6 +22,7 @@
 #include "parse-options.h"
 #include "pathspec.h"
 #include "dir.h"
+#include "read-cache.h"
 #include "repository.h"
 #include "setup.h"
 #include "sparse-index.h"
diff --git a/builtin/worktree.c b/builtin/worktree.c
index f3180463be2..3c3d97ad5b0 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -13,6 +13,7 @@
 #include "parse-options.h"
 #include "strvec.h"
 #include "branch.h"
+#include "read-cache-ll.h"
 #include "refs.h"
 #include "repository.h"
 #include "run-command.h"
diff --git a/cache-tree.c b/cache-tree.c
index ebfe649b330..153217b47ff 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -9,6 +9,7 @@
 #include "bulk-checkin.h"
 #include "object-file.h"
 #include "object-store.h"
+#include "read-cache-ll.h"
 #include "replace-object.h"
 #include "promisor-remote.h"
 #include "sparse-index.h"
diff --git a/cache.h b/cache.h
index 11882897741..9b4e8d16874 100644
--- a/cache.h
+++ b/cache.h
@@ -2,525 +2,5 @@
 #define CACHE_H
 
 #include "git-compat-util.h"
-#include "strbuf.h"
-#include "hashmap.h"
-#include "pathspec.h"
-#include "object.h"
-#include "statinfo.h"
-
-/*
- * Basic data structures for the directory cache
- */
-
-#define CACHE_SIGNATURE 0x44495243	/* "DIRC" */
-struct cache_header {
-	uint32_t hdr_signature;
-	uint32_t hdr_version;
-	uint32_t hdr_entries;
-};
-
-#define INDEX_FORMAT_LB 2
-#define INDEX_FORMAT_UB 4
-
-struct cache_entry {
-	struct hashmap_entry ent;
-	struct stat_data ce_stat_data;
-	unsigned int ce_mode;
-	unsigned int ce_flags;
-	unsigned int mem_pool_allocated;
-	unsigned int ce_namelen;
-	unsigned int index;	/* for link extension */
-	struct object_id oid;
-	char name[FLEX_ARRAY]; /* more */
-};
-
-#define CE_STAGEMASK (0x3000)
-#define CE_EXTENDED  (0x4000)
-#define CE_VALID     (0x8000)
-#define CE_STAGESHIFT 12
-
-/*
- * Range 0xFFFF0FFF in ce_flags is divided into
- * two parts: in-memory flags and on-disk ones.
- * Flags in CE_EXTENDED_FLAGS will get saved on-disk
- * if you want to save a new flag, add it in
- * CE_EXTENDED_FLAGS
- *
- * In-memory only flags
- */
-#define CE_UPDATE            (1 << 16)
-#define CE_REMOVE            (1 << 17)
-#define CE_UPTODATE          (1 << 18)
-#define CE_ADDED             (1 << 19)
-
-#define CE_HASHED            (1 << 20)
-#define CE_FSMONITOR_VALID   (1 << 21)
-#define CE_WT_REMOVE         (1 << 22) /* remove in work directory */
-#define CE_CONFLICTED        (1 << 23)
-
-#define CE_UNPACKED          (1 << 24)
-#define CE_NEW_SKIP_WORKTREE (1 << 25)
-
-/* used to temporarily mark paths matched by pathspecs */
-#define CE_MATCHED           (1 << 26)
-
-#define CE_UPDATE_IN_BASE    (1 << 27)
-#define CE_STRIP_NAME        (1 << 28)
-
-/*
- * Extended on-disk flags
- */
-#define CE_INTENT_TO_ADD     (1 << 29)
-#define CE_SKIP_WORKTREE     (1 << 30)
-/* CE_EXTENDED2 is for future extension */
-#define CE_EXTENDED2         (1U << 31)
-
-#define CE_EXTENDED_FLAGS (CE_INTENT_TO_ADD | CE_SKIP_WORKTREE)
-
-/*
- * Safeguard to avoid saving wrong flags:
- *  - CE_EXTENDED2 won't get saved until its semantic is known
- *  - Bits in 0x0000FFFF have been saved in ce_flags already
- *  - Bits in 0x003F0000 are currently in-memory flags
- */
-#if CE_EXTENDED_FLAGS & 0x803FFFFF
-#error "CE_EXTENDED_FLAGS out of range"
-#endif
-
-/* Forward structure decls */
-struct pathspec;
-struct tree;
-
-/*
- * Copy the sha1 and stat state of a cache entry from one to
- * another. But we never change the name, or the hash state!
- */
-static inline void copy_cache_entry(struct cache_entry *dst,
-				    const struct cache_entry *src)
-{
-	unsigned int state = dst->ce_flags & CE_HASHED;
-	int mem_pool_allocated = dst->mem_pool_allocated;
-
-	/* Don't copy hash chain and name */
-	memcpy(&dst->ce_stat_data, &src->ce_stat_data,
-			offsetof(struct cache_entry, name) -
-			offsetof(struct cache_entry, ce_stat_data));
-
-	/* Restore the hash state */
-	dst->ce_flags = (dst->ce_flags & ~CE_HASHED) | state;
-
-	/* Restore the mem_pool_allocated flag */
-	dst->mem_pool_allocated = mem_pool_allocated;
-}
-
-static inline unsigned create_ce_flags(unsigned stage)
-{
-	return (stage << CE_STAGESHIFT);
-}
-
-#define ce_namelen(ce) ((ce)->ce_namelen)
-#define ce_size(ce) cache_entry_size(ce_namelen(ce))
-#define ce_stage(ce) ((CE_STAGEMASK & (ce)->ce_flags) >> CE_STAGESHIFT)
-#define ce_uptodate(ce) ((ce)->ce_flags & CE_UPTODATE)
-#define ce_skip_worktree(ce) ((ce)->ce_flags & CE_SKIP_WORKTREE)
-#define ce_mark_uptodate(ce) ((ce)->ce_flags |= CE_UPTODATE)
-#define ce_intent_to_add(ce) ((ce)->ce_flags & CE_INTENT_TO_ADD)
-
-static inline unsigned int ce_mode_from_stat(const struct cache_entry *ce,
-					     unsigned int mode)
-{
-	extern int trust_executable_bit, has_symlinks;
-	if (!has_symlinks && S_ISREG(mode) &&
-	    ce && S_ISLNK(ce->ce_mode))
-		return ce->ce_mode;
-	if (!trust_executable_bit && S_ISREG(mode)) {
-		if (ce && S_ISREG(ce->ce_mode))
-			return ce->ce_mode;
-		return create_ce_mode(0666);
-	}
-	return create_ce_mode(mode);
-}
-static inline int ce_to_dtype(const struct cache_entry *ce)
-{
-	unsigned ce_mode = ntohl(ce->ce_mode);
-	if (S_ISREG(ce_mode))
-		return DT_REG;
-	else if (S_ISDIR(ce_mode) || S_ISGITLINK(ce_mode))
-		return DT_DIR;
-	else if (S_ISLNK(ce_mode))
-		return DT_LNK;
-	else
-		return DT_UNKNOWN;
-}
-
-static inline int ce_path_match(struct index_state *istate,
-				const struct cache_entry *ce,
-				const struct pathspec *pathspec,
-				char *seen)
-{
-	return match_pathspec(istate, pathspec, ce->name, ce_namelen(ce), 0, seen,
-			      S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode));
-}
-
-#define cache_entry_size(len) (offsetof(struct cache_entry,name) + (len) + 1)
-
-#define SOMETHING_CHANGED	(1 << 0) /* unclassified changes go here */
-#define CE_ENTRY_CHANGED	(1 << 1)
-#define CE_ENTRY_REMOVED	(1 << 2)
-#define CE_ENTRY_ADDED		(1 << 3)
-#define RESOLVE_UNDO_CHANGED	(1 << 4)
-#define CACHE_TREE_CHANGED	(1 << 5)
-#define SPLIT_INDEX_ORDERED	(1 << 6)
-#define UNTRACKED_CHANGED	(1 << 7)
-#define FSMONITOR_CHANGED	(1 << 8)
-
-struct split_index;
-struct untracked_cache;
-struct progress;
-struct pattern_list;
-
-enum sparse_index_mode {
-	/*
-	 * There are no sparse directories in the index at all.
-	 *
-	 * Repositories that don't use cone-mode sparse-checkout will
-	 * always have their indexes in this mode.
-	 */
-	INDEX_EXPANDED = 0,
-
-	/*
-	 * The index has already been collapsed to sparse directories
-	 * whereever possible.
-	 */
-	INDEX_COLLAPSED,
-
-	/*
-	 * The sparse directories that exist are outside the
-	 * sparse-checkout boundary, but it is possible that some file
-	 * entries could collapse to sparse directory entries.
-	 */
-	INDEX_PARTIALLY_SPARSE,
-};
-
-struct index_state {
-	struct cache_entry **cache;
-	unsigned int version;
-	unsigned int cache_nr, cache_alloc, cache_changed;
-	struct string_list *resolve_undo;
-	struct cache_tree *cache_tree;
-	struct split_index *split_index;
-	struct cache_time timestamp;
-	unsigned name_hash_initialized : 1,
-		 initialized : 1,
-		 drop_cache_tree : 1,
-		 updated_workdir : 1,
-		 updated_skipworktree : 1,
-		 fsmonitor_has_run_once : 1;
-	enum sparse_index_mode sparse_index;
-	struct hashmap name_hash;
-	struct hashmap dir_hash;
-	struct object_id oid;
-	struct untracked_cache *untracked;
-	char *fsmonitor_last_update;
-	struct ewah_bitmap *fsmonitor_dirty;
-	struct mem_pool *ce_mem_pool;
-	struct progress *progress;
-	struct repository *repo;
-	struct pattern_list *sparse_checkout_patterns;
-};
-
-/**
- * A "struct index_state istate" must be initialized with
- * INDEX_STATE_INIT or the corresponding index_state_init().
- *
- * If the variable won't be used again, use release_index() to free()
- * its resources. If it needs to be used again use discard_index(),
- * which does the same thing, but will use use index_state_init() at
- * the end. The discard_index() will use its own "istate->repo" as the
- * "r" argument to index_state_init() in that case.
- */
-#define INDEX_STATE_INIT(r) { \
-	.repo = (r), \
-}
-void index_state_init(struct index_state *istate, struct repository *r);
-void release_index(struct index_state *istate);
-
-/* Cache entry creation and cleanup */
-
-/*
- * Create cache_entry intended for use in the specified index. Caller
- * is responsible for discarding the cache_entry with
- * `discard_cache_entry`.
- */
-struct cache_entry *make_cache_entry(struct index_state *istate,
-				     unsigned int mode,
-				     const struct object_id *oid,
-				     const char *path,
-				     int stage,
-				     unsigned int refresh_options);
-
-struct cache_entry *make_empty_cache_entry(struct index_state *istate,
-					   size_t name_len);
-
-/*
- * Create a cache_entry that is not intended to be added to an index. If
- * `ce_mem_pool` is not NULL, the entry is allocated within the given memory
- * pool. Caller is responsible for discarding "loose" entries with
- * `discard_cache_entry()` and the memory pool with
- * `mem_pool_discard(ce_mem_pool, should_validate_cache_entries())`.
- */
-struct cache_entry *make_transient_cache_entry(unsigned int mode,
-					       const struct object_id *oid,
-					       const char *path,
-					       int stage,
-					       struct mem_pool *ce_mem_pool);
-
-struct cache_entry *make_empty_transient_cache_entry(size_t len,
-						     struct mem_pool *ce_mem_pool);
-
-/*
- * Discard cache entry.
- */
-void discard_cache_entry(struct cache_entry *ce);
-
-/*
- * Check configuration if we should perform extra validation on cache
- * entries.
- */
-int should_validate_cache_entries(void);
-
-/*
- * Duplicate a cache_entry. Allocate memory for the new entry from a
- * memory_pool. Takes into account cache_entry fields that are meant
- * for managing the underlying memory allocation of the cache_entry.
- */
-struct cache_entry *dup_cache_entry(const struct cache_entry *ce, struct index_state *istate);
-
-/*
- * Validate the cache entries in the index.  This is an internal
- * consistency check that the cache_entry structs are allocated from
- * the expected memory pool.
- */
-void validate_cache_entries(const struct index_state *istate);
-
-/*
- * Bulk prefetch all missing cache entries that are not GITLINKs and that match
- * the given predicate. This function should only be called if
- * repo_has_promisor_remote() returns true.
- */
-typedef int (*must_prefetch_predicate)(const struct cache_entry *);
-void prefetch_cache_entries(const struct index_state *istate,
-			    must_prefetch_predicate must_prefetch);
-
-/* Initialize and use the cache information */
-struct lock_file;
-int do_read_index(struct index_state *istate, const char *path,
-		  int must_exist); /* for testting only! */
-int read_index_from(struct index_state *, const char *path,
-		    const char *gitdir);
-int is_index_unborn(struct index_state *);
-
-/* For use with `write_locked_index()`. */
-#define COMMIT_LOCK		(1 << 0)
-#define SKIP_IF_UNCHANGED	(1 << 1)
-
-/*
- * Write the index while holding an already-taken lock. Close the lock,
- * and if `COMMIT_LOCK` is given, commit it.
- *
- * Unless a split index is in use, write the index into the lockfile.
- *
- * With a split index, write the shared index to a temporary file,
- * adjust its permissions and rename it into place, then write the
- * split index to the lockfile. If the temporary file for the shared
- * index cannot be created, fall back to the behavior described in
- * the previous paragraph.
- *
- * With `COMMIT_LOCK`, the lock is always committed or rolled back.
- * Without it, the lock is closed, but neither committed nor rolled
- * back.
- *
- * If `SKIP_IF_UNCHANGED` is given and the index is unchanged, nothing
- * is written (and the lock is rolled back if `COMMIT_LOCK` is given).
- */
-int write_locked_index(struct index_state *, struct lock_file *lock, unsigned flags);
-
-void discard_index(struct index_state *);
-void move_index_extensions(struct index_state *dst, struct index_state *src);
-int unmerged_index(const struct index_state *);
-
-/**
- * Returns 1 if istate differs from tree, 0 otherwise.  If tree is NULL,
- * compares istate to HEAD.  If tree is NULL and on an unborn branch,
- * returns 1 if there are entries in istate, 0 otherwise.  If an strbuf is
- * provided, the space-separated list of files that differ will be appended
- * to it.
- */
-int repo_index_has_changes(struct repository *repo,
-			   struct tree *tree,
-			   struct strbuf *sb);
-
-int verify_path(const char *path, unsigned mode);
-int strcmp_offset(const char *s1, const char *s2, size_t *first_change);
-
-/*
- * Searches for an entry defined by name and namelen in the given index.
- * If the return value is positive (including 0) it is the position of an
- * exact match. If the return value is negative, the negated value minus 1
- * is the position where the entry would be inserted.
- * Example: The current index consists of these files and its stages:
- *
- *   b#0, d#0, f#1, f#3
- *
- * index_name_pos(&index, "a", 1) -> -1
- * index_name_pos(&index, "b", 1) ->  0
- * index_name_pos(&index, "c", 1) -> -2
- * index_name_pos(&index, "d", 1) ->  1
- * index_name_pos(&index, "e", 1) -> -3
- * index_name_pos(&index, "f", 1) -> -3
- * index_name_pos(&index, "g", 1) -> -5
- */
-int index_name_pos(struct index_state *, const char *name, int namelen);
-
-/*
- * Like index_name_pos, returns the position of an entry of the given name in
- * the index if one exists, otherwise returns a negative value where the negated
- * value minus 1 is the position where the index entry would be inserted. Unlike
- * index_name_pos, however, a sparse index is not expanded to find an entry
- * inside a sparse directory.
- */
-int index_name_pos_sparse(struct index_state *, const char *name, int namelen);
-
-/*
- * Determines whether an entry with the given name exists within the
- * given index. The return value is 1 if an exact match is found, otherwise
- * it is 0. Note that, unlike index_name_pos, this function does not expand
- * the index if it is sparse. If an item exists within the full index but it
- * is contained within a sparse directory (and not in the sparse index), 0 is
- * returned.
- */
-int index_entry_exists(struct index_state *, const char *name, int namelen);
-
-/*
- * Some functions return the negative complement of an insert position when a
- * precise match was not found but a position was found where the entry would
- * need to be inserted. This helper protects that logic from any integer
- * underflow.
- */
-static inline int index_pos_to_insert_pos(uintmax_t pos)
-{
-	if (pos > INT_MAX)
-		die("overflow: -1 - %"PRIuMAX, pos);
-	return -1 - (int)pos;
-}
-
-#define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
-#define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
-#define ADD_CACHE_SKIP_DFCHECK 4	/* Ok to skip DF conflict checks */
-#define ADD_CACHE_JUST_APPEND 8		/* Append only */
-#define ADD_CACHE_NEW_ONLY 16		/* Do not replace existing ones */
-#define ADD_CACHE_KEEP_CACHE_TREE 32	/* Do not invalidate cache-tree */
-#define ADD_CACHE_RENORMALIZE 64        /* Pass along HASH_RENORMALIZE */
-int add_index_entry(struct index_state *, struct cache_entry *ce, int option);
-void rename_index_entry_at(struct index_state *, int pos, const char *new_name);
-
-/* Remove entry, return true if there are more entries to go. */
-int remove_index_entry_at(struct index_state *, int pos);
-
-void remove_marked_cache_entries(struct index_state *istate, int invalidate);
-int remove_file_from_index(struct index_state *, const char *path);
-#define ADD_CACHE_VERBOSE 1
-#define ADD_CACHE_PRETEND 2
-#define ADD_CACHE_IGNORE_ERRORS	4
-#define ADD_CACHE_IGNORE_REMOVAL 8
-#define ADD_CACHE_INTENT 16
-/*
- * These two are used to add the contents of the file at path
- * to the index, marking the working tree up-to-date by storing
- * the cached stat info in the resulting cache entry.  A caller
- * that has already run lstat(2) on the path can call
- * add_to_index(), and all others can call add_file_to_index();
- * the latter will do necessary lstat(2) internally before
- * calling the former.
- */
-int add_to_index(struct index_state *, const char *path, struct stat *, int flags);
-int add_file_to_index(struct index_state *, const char *path, int flags);
-
-int chmod_index_entry(struct index_state *, struct cache_entry *ce, char flip);
-int ce_same_name(const struct cache_entry *a, const struct cache_entry *b);
-void set_object_name_for_intent_to_add_entry(struct cache_entry *ce);
-int index_name_is_other(struct index_state *, const char *, int);
-void *read_blob_data_from_index(struct index_state *, const char *, unsigned long *);
-
-/* do stat comparison even if CE_VALID is true */
-#define CE_MATCH_IGNORE_VALID		01
-/* do not check the contents but report dirty on racily-clean entries */
-#define CE_MATCH_RACY_IS_DIRTY		02
-/* do stat comparison even if CE_SKIP_WORKTREE is true */
-#define CE_MATCH_IGNORE_SKIP_WORKTREE	04
-/* ignore non-existent files during stat update  */
-#define CE_MATCH_IGNORE_MISSING		0x08
-/* enable stat refresh */
-#define CE_MATCH_REFRESH		0x10
-/* don't refresh_fsmonitor state or do stat comparison even if CE_FSMONITOR_VALID is true */
-#define CE_MATCH_IGNORE_FSMONITOR 0X20
-int is_racy_timestamp(const struct index_state *istate,
-		      const struct cache_entry *ce);
-int has_racy_timestamp(struct index_state *istate);
-int ie_match_stat(struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
-int ie_modified(struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
-
-int match_stat_data_racy(const struct index_state *istate,
-			 const struct stat_data *sd, struct stat *st);
-
-void fill_stat_cache_info(struct index_state *istate, struct cache_entry *ce, struct stat *st);
-
-#define REFRESH_REALLY                   (1 << 0) /* ignore_valid */
-#define REFRESH_UNMERGED                 (1 << 1) /* allow unmerged */
-#define REFRESH_QUIET                    (1 << 2) /* be quiet about it */
-#define REFRESH_IGNORE_MISSING           (1 << 3) /* ignore non-existent */
-#define REFRESH_IGNORE_SUBMODULES        (1 << 4) /* ignore submodules */
-#define REFRESH_IN_PORCELAIN             (1 << 5) /* user friendly output, not "needs update" */
-#define REFRESH_PROGRESS                 (1 << 6) /* show progress bar if stderr is tty */
-#define REFRESH_IGNORE_SKIP_WORKTREE     (1 << 7) /* ignore skip_worktree entries */
-int refresh_index(struct index_state *, unsigned int flags, const struct pathspec *pathspec, char *seen, const char *header_msg);
-/*
- * Refresh the index and write it to disk.
- *
- * 'refresh_flags' is passed directly to 'refresh_index()', while
- * 'COMMIT_LOCK | write_flags' is passed to 'write_locked_index()', so
- * the lockfile is always either committed or rolled back.
- *
- * If 'gentle' is passed, errors locking the index are ignored.
- *
- * Return 1 if refreshing the index returns an error, -1 if writing
- * the index to disk fails, 0 on success.
- *
- * Note that if refreshing the index returns an error, we still write
- * out the index (unless locking fails).
- */
-int repo_refresh_and_write_index(struct repository*, unsigned int refresh_flags, unsigned int write_flags, int gentle, const struct pathspec *, char *seen, const char *header_msg);
-
-struct cache_entry *refresh_cache_entry(struct index_state *, struct cache_entry *, unsigned int);
-
-void set_alternate_index_output(const char *);
-
-extern int verify_index_checksum;
-extern int verify_ce_order;
-
-int cmp_cache_name_compare(const void *a_, const void *b_);
-
-/* add */
-/*
- * return 0 if success, 1 - if addition of a file failed and
- * ADD_FILES_IGNORE_ERRORS was specified in flags
- */
-int add_files_to_cache(struct repository *repo, const char *prefix,
-		       const struct pathspec *pathspec, int include_sparse,
-		       int flags);
-
-/* ls-files */
-void overlay_tree_on_index(struct index_state *istate,
-			   const char *tree_name, const char *prefix);
 
 #endif /* CACHE_H */
diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index a4d11376ba5..fb08475bc64 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -10,6 +10,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "path.h"
+#include "strbuf.h"
 #include "utf8.h"
 #include "precompose_utf8.h"
 
diff --git a/compat/sha1-chunked.c b/compat/sha1-chunked.c
index 6adfcfd5405..56729d92dcf 100644
--- a/compat/sha1-chunked.c
+++ b/compat/sha1-chunked.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "hash-ll.h"
 
 int git_SHA1_Update_Chunked(platform_SHA_CTX *c, const void *data, size_t len)
 {
diff --git a/config.c b/config.c
index b79baf83e35..06e6cc6f1ec 100644
--- a/config.c
+++ b/config.c
@@ -33,6 +33,7 @@
 #include "replace-object.h"
 #include "refs.h"
 #include "setup.h"
+#include "strvec.h"
 #include "trace2.h"
 #include "worktree.h"
 #include "ws.h"
diff --git a/convert.c b/convert.c
index 7cf7bd0c883..236d5e3dc25 100644
--- a/convert.c
+++ b/convert.c
@@ -9,6 +9,7 @@
 #include "attr.h"
 #include "run-command.h"
 #include "quote.h"
+#include "read-cache-ll.h"
 #include "sigchain.h"
 #include "pkt-line.h"
 #include "sub-process.h"
diff --git a/diff-lib.c b/diff-lib.c
index 60e979dc1bd..36cd66ea237 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -9,6 +9,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "object-name.h"
+#include "read-cache.h"
 #include "revision.h"
 #include "cache-tree.h"
 #include "unpack-trees.h"
diff --git a/diff.c b/diff.c
index 07f140b425f..61b4dc61e1e 100644
--- a/diff.c
+++ b/diff.c
@@ -39,6 +39,7 @@
 #include "dir.h"
 #include "object-file.h"
 #include "object-name.h"
+#include "read-cache-ll.h"
 #include "setup.h"
 #include "strmap.h"
 #include "ws.h"
diff --git a/diffcore-break.c b/diffcore-break.c
index 5462420bbbe..4909dc088e6 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -1,9 +1,10 @@
 /*
  * Copyright (C) 2005 Junio C Hamano
  */
-#include "cache.h"
+#include "git-compat-util.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "object.h"
 #include "promisor-remote.h"
 
 static int should_break(struct repository *r,
diff --git a/environment.h b/environment.h
index a63f0c6a24f..6eca4712e1e 100644
--- a/environment.h
+++ b/environment.h
@@ -1,9 +1,8 @@
 #ifndef ENVIRONMENT_H
 #define ENVIRONMENT_H
 
-#include "strvec.h"
-
 struct repository;
+struct strvec;
 
 /*
  * The character that begins a commented line in user-editable file
diff --git a/fsmonitor.h b/fsmonitor.h
index c67e0ebc09b..8b7a521552a 100644
--- a/fsmonitor.h
+++ b/fsmonitor.h
@@ -4,6 +4,8 @@
 #include "cache.h"
 #include "dir.h"
 #include "fsmonitor-settings.h"
+#include "object.h"
+#include "read-cache-ll.h"
 #include "trace.h"
 
 extern struct trace_key trace_fsmonitor;
diff --git a/git.c b/git.c
index 45899be8265..a1a538fc52e 100644
--- a/git.c
+++ b/git.c
@@ -5,6 +5,7 @@
 #include "gettext.h"
 #include "help.h"
 #include "pager.h"
+#include "read-cache-ll.h"
 #include "run-command.h"
 #include "alias.h"
 #include "replace-object.h"
diff --git a/hash-lookup.c b/hash-lookup.c
index bb54dfde9c7..8fec8939fd3 100644
--- a/hash-lookup.c
+++ b/hash-lookup.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "hash.h"
 #include "hash-lookup.h"
+#include "read-cache-ll.h"
 
 static uint32_t take2(const struct object_id *oid, size_t ofs)
 {
diff --git a/merge-ort-wrappers.c b/merge-ort-wrappers.c
index a5507533009..a0bedcb63bb 100644
--- a/merge-ort-wrappers.c
+++ b/merge-ort-wrappers.c
@@ -3,6 +3,7 @@
 #include "hash.h"
 #include "merge-ort.h"
 #include "merge-ort-wrappers.h"
+#include "read-cache-ll.h"
 #include "tree.h"
 
 #include "commit.h"
diff --git a/merge-ort.c b/merge-ort.c
index 4bff685e456..5512f40d321 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -37,6 +37,7 @@
 #include "object-store.h"
 #include "oid-array.h"
 #include "promisor-remote.h"
+#include "read-cache-ll.h"
 #include "revision.h"
 #include "sparse-index.h"
 #include "strmap.h"
diff --git a/name-hash.c b/name-hash.c
index 52ce47ea394..f2f3564cb20 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -9,6 +9,8 @@
 #include "environment.h"
 #include "gettext.h"
 #include "name-hash.h"
+#include "object.h"
+#include "read-cache-ll.h"
 #include "thread-utils.h"
 #include "trace.h"
 #include "trace2.h"
diff --git a/object-name.c b/object-name.c
index 6fc3fa595b8..1eefeef746e 100644
--- a/object-name.c
+++ b/object-name.c
@@ -18,6 +18,7 @@
 #include "packfile.h"
 #include "pretty.h"
 #include "object-store.h"
+#include "read-cache-ll.h"
 #include "repository.h"
 #include "setup.h"
 #include "submodule.h"
diff --git a/oidmap.h b/oidmap.h
index c1642927fa6..05c673eb7c1 100644
--- a/oidmap.h
+++ b/oidmap.h
@@ -1,6 +1,7 @@
 #ifndef OIDMAP_H
 #define OIDMAP_H
 
+#include "hash-ll.h"
 #include "hashmap.h"
 
 /*
diff --git a/parallel-checkout.c b/parallel-checkout.c
index 69d569f3525..2b1439c0c5f 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -8,6 +8,7 @@
 #include "parallel-checkout.h"
 #include "pkt-line.h"
 #include "progress.h"
+#include "read-cache-ll.h"
 #include "run-command.h"
 #include "sigchain.h"
 #include "streaming.h"
diff --git a/pathspec.c b/pathspec.c
index 1e57b6c667d..47d172fe414 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -6,6 +6,7 @@
 #include "gettext.h"
 #include "pathspec.h"
 #include "attr.h"
+#include "read-cache.h"
 #include "repository.h"
 #include "setup.h"
 #include "strvec.h"
diff --git a/preload-index.c b/preload-index.c
index c26739debf8..d037a951efa 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -10,6 +10,7 @@
 #include "config.h"
 #include "preload-index.h"
 #include "progress.h"
+#include "read-cache.h"
 #include "thread-utils.h"
 #include "repository.h"
 #include "symlinks.h"
diff --git a/read-cache-ll.h b/read-cache-ll.h
new file mode 100644
index 00000000000..9a1a7edc5a2
--- /dev/null
+++ b/read-cache-ll.h
@@ -0,0 +1,481 @@
+#ifndef READ_CACHE_LL_H
+#define READ_CACHE_LL_H
+
+#include "hash-ll.h"
+#include "hashmap.h"
+#include "statinfo.h"
+
+/*
+ * Basic data structures for the directory cache
+ */
+
+#define CACHE_SIGNATURE 0x44495243	/* "DIRC" */
+struct cache_header {
+	uint32_t hdr_signature;
+	uint32_t hdr_version;
+	uint32_t hdr_entries;
+};
+
+#define INDEX_FORMAT_LB 2
+#define INDEX_FORMAT_UB 4
+
+struct cache_entry {
+	struct hashmap_entry ent;
+	struct stat_data ce_stat_data;
+	unsigned int ce_mode;
+	unsigned int ce_flags;
+	unsigned int mem_pool_allocated;
+	unsigned int ce_namelen;
+	unsigned int index;	/* for link extension */
+	struct object_id oid;
+	char name[FLEX_ARRAY]; /* more */
+};
+
+#define CE_STAGEMASK (0x3000)
+#define CE_EXTENDED  (0x4000)
+#define CE_VALID     (0x8000)
+#define CE_STAGESHIFT 12
+
+/*
+ * Range 0xFFFF0FFF in ce_flags is divided into
+ * two parts: in-memory flags and on-disk ones.
+ * Flags in CE_EXTENDED_FLAGS will get saved on-disk
+ * if you want to save a new flag, add it in
+ * CE_EXTENDED_FLAGS
+ *
+ * In-memory only flags
+ */
+#define CE_UPDATE            (1 << 16)
+#define CE_REMOVE            (1 << 17)
+#define CE_UPTODATE          (1 << 18)
+#define CE_ADDED             (1 << 19)
+
+#define CE_HASHED            (1 << 20)
+#define CE_FSMONITOR_VALID   (1 << 21)
+#define CE_WT_REMOVE         (1 << 22) /* remove in work directory */
+#define CE_CONFLICTED        (1 << 23)
+
+#define CE_UNPACKED          (1 << 24)
+#define CE_NEW_SKIP_WORKTREE (1 << 25)
+
+/* used to temporarily mark paths matched by pathspecs */
+#define CE_MATCHED           (1 << 26)
+
+#define CE_UPDATE_IN_BASE    (1 << 27)
+#define CE_STRIP_NAME        (1 << 28)
+
+/*
+ * Extended on-disk flags
+ */
+#define CE_INTENT_TO_ADD     (1 << 29)
+#define CE_SKIP_WORKTREE     (1 << 30)
+/* CE_EXTENDED2 is for future extension */
+#define CE_EXTENDED2         (1U << 31)
+
+#define CE_EXTENDED_FLAGS (CE_INTENT_TO_ADD | CE_SKIP_WORKTREE)
+
+/*
+ * Safeguard to avoid saving wrong flags:
+ *  - CE_EXTENDED2 won't get saved until its semantic is known
+ *  - Bits in 0x0000FFFF have been saved in ce_flags already
+ *  - Bits in 0x003F0000 are currently in-memory flags
+ */
+#if CE_EXTENDED_FLAGS & 0x803FFFFF
+#error "CE_EXTENDED_FLAGS out of range"
+#endif
+
+/* Forward structure decls */
+struct pathspec;
+struct tree;
+
+/*
+ * Copy the sha1 and stat state of a cache entry from one to
+ * another. But we never change the name, or the hash state!
+ */
+static inline void copy_cache_entry(struct cache_entry *dst,
+				    const struct cache_entry *src)
+{
+	unsigned int state = dst->ce_flags & CE_HASHED;
+	int mem_pool_allocated = dst->mem_pool_allocated;
+
+	/* Don't copy hash chain and name */
+	memcpy(&dst->ce_stat_data, &src->ce_stat_data,
+			offsetof(struct cache_entry, name) -
+			offsetof(struct cache_entry, ce_stat_data));
+
+	/* Restore the hash state */
+	dst->ce_flags = (dst->ce_flags & ~CE_HASHED) | state;
+
+	/* Restore the mem_pool_allocated flag */
+	dst->mem_pool_allocated = mem_pool_allocated;
+}
+
+static inline unsigned create_ce_flags(unsigned stage)
+{
+	return (stage << CE_STAGESHIFT);
+}
+
+#define ce_namelen(ce) ((ce)->ce_namelen)
+#define ce_size(ce) cache_entry_size(ce_namelen(ce))
+#define ce_stage(ce) ((CE_STAGEMASK & (ce)->ce_flags) >> CE_STAGESHIFT)
+#define ce_uptodate(ce) ((ce)->ce_flags & CE_UPTODATE)
+#define ce_skip_worktree(ce) ((ce)->ce_flags & CE_SKIP_WORKTREE)
+#define ce_mark_uptodate(ce) ((ce)->ce_flags |= CE_UPTODATE)
+#define ce_intent_to_add(ce) ((ce)->ce_flags & CE_INTENT_TO_ADD)
+
+#define cache_entry_size(len) (offsetof(struct cache_entry,name) + (len) + 1)
+
+#define SOMETHING_CHANGED	(1 << 0) /* unclassified changes go here */
+#define CE_ENTRY_CHANGED	(1 << 1)
+#define CE_ENTRY_REMOVED	(1 << 2)
+#define CE_ENTRY_ADDED		(1 << 3)
+#define RESOLVE_UNDO_CHANGED	(1 << 4)
+#define CACHE_TREE_CHANGED	(1 << 5)
+#define SPLIT_INDEX_ORDERED	(1 << 6)
+#define UNTRACKED_CHANGED	(1 << 7)
+#define FSMONITOR_CHANGED	(1 << 8)
+
+struct split_index;
+struct untracked_cache;
+struct progress;
+struct pattern_list;
+
+enum sparse_index_mode {
+	/*
+	 * There are no sparse directories in the index at all.
+	 *
+	 * Repositories that don't use cone-mode sparse-checkout will
+	 * always have their indexes in this mode.
+	 */
+	INDEX_EXPANDED = 0,
+
+	/*
+	 * The index has already been collapsed to sparse directories
+	 * whereever possible.
+	 */
+	INDEX_COLLAPSED,
+
+	/*
+	 * The sparse directories that exist are outside the
+	 * sparse-checkout boundary, but it is possible that some file
+	 * entries could collapse to sparse directory entries.
+	 */
+	INDEX_PARTIALLY_SPARSE,
+};
+
+struct index_state {
+	struct cache_entry **cache;
+	unsigned int version;
+	unsigned int cache_nr, cache_alloc, cache_changed;
+	struct string_list *resolve_undo;
+	struct cache_tree *cache_tree;
+	struct split_index *split_index;
+	struct cache_time timestamp;
+	unsigned name_hash_initialized : 1,
+		 initialized : 1,
+		 drop_cache_tree : 1,
+		 updated_workdir : 1,
+		 updated_skipworktree : 1,
+		 fsmonitor_has_run_once : 1;
+	enum sparse_index_mode sparse_index;
+	struct hashmap name_hash;
+	struct hashmap dir_hash;
+	struct object_id oid;
+	struct untracked_cache *untracked;
+	char *fsmonitor_last_update;
+	struct ewah_bitmap *fsmonitor_dirty;
+	struct mem_pool *ce_mem_pool;
+	struct progress *progress;
+	struct repository *repo;
+	struct pattern_list *sparse_checkout_patterns;
+};
+
+/**
+ * A "struct index_state istate" must be initialized with
+ * INDEX_STATE_INIT or the corresponding index_state_init().
+ *
+ * If the variable won't be used again, use release_index() to free()
+ * its resources. If it needs to be used again use discard_index(),
+ * which does the same thing, but will use use index_state_init() at
+ * the end. The discard_index() will use its own "istate->repo" as the
+ * "r" argument to index_state_init() in that case.
+ */
+#define INDEX_STATE_INIT(r) { \
+	.repo = (r), \
+}
+void index_state_init(struct index_state *istate, struct repository *r);
+void release_index(struct index_state *istate);
+
+/* Cache entry creation and cleanup */
+
+/*
+ * Create cache_entry intended for use in the specified index. Caller
+ * is responsible for discarding the cache_entry with
+ * `discard_cache_entry`.
+ */
+struct cache_entry *make_cache_entry(struct index_state *istate,
+				     unsigned int mode,
+				     const struct object_id *oid,
+				     const char *path,
+				     int stage,
+				     unsigned int refresh_options);
+
+struct cache_entry *make_empty_cache_entry(struct index_state *istate,
+					   size_t name_len);
+
+/*
+ * Create a cache_entry that is not intended to be added to an index. If
+ * `ce_mem_pool` is not NULL, the entry is allocated within the given memory
+ * pool. Caller is responsible for discarding "loose" entries with
+ * `discard_cache_entry()` and the memory pool with
+ * `mem_pool_discard(ce_mem_pool, should_validate_cache_entries())`.
+ */
+struct cache_entry *make_transient_cache_entry(unsigned int mode,
+					       const struct object_id *oid,
+					       const char *path,
+					       int stage,
+					       struct mem_pool *ce_mem_pool);
+
+struct cache_entry *make_empty_transient_cache_entry(size_t len,
+						     struct mem_pool *ce_mem_pool);
+
+/*
+ * Discard cache entry.
+ */
+void discard_cache_entry(struct cache_entry *ce);
+
+/*
+ * Check configuration if we should perform extra validation on cache
+ * entries.
+ */
+int should_validate_cache_entries(void);
+
+/*
+ * Duplicate a cache_entry. Allocate memory for the new entry from a
+ * memory_pool. Takes into account cache_entry fields that are meant
+ * for managing the underlying memory allocation of the cache_entry.
+ */
+struct cache_entry *dup_cache_entry(const struct cache_entry *ce, struct index_state *istate);
+
+/*
+ * Validate the cache entries in the index.  This is an internal
+ * consistency check that the cache_entry structs are allocated from
+ * the expected memory pool.
+ */
+void validate_cache_entries(const struct index_state *istate);
+
+/*
+ * Bulk prefetch all missing cache entries that are not GITLINKs and that match
+ * the given predicate. This function should only be called if
+ * repo_has_promisor_remote() returns true.
+ */
+typedef int (*must_prefetch_predicate)(const struct cache_entry *);
+void prefetch_cache_entries(const struct index_state *istate,
+			    must_prefetch_predicate must_prefetch);
+
+/* Initialize and use the cache information */
+struct lock_file;
+int do_read_index(struct index_state *istate, const char *path,
+		  int must_exist); /* for testting only! */
+int read_index_from(struct index_state *, const char *path,
+		    const char *gitdir);
+int is_index_unborn(struct index_state *);
+
+/* For use with `write_locked_index()`. */
+#define COMMIT_LOCK		(1 << 0)
+#define SKIP_IF_UNCHANGED	(1 << 1)
+
+/*
+ * Write the index while holding an already-taken lock. Close the lock,
+ * and if `COMMIT_LOCK` is given, commit it.
+ *
+ * Unless a split index is in use, write the index into the lockfile.
+ *
+ * With a split index, write the shared index to a temporary file,
+ * adjust its permissions and rename it into place, then write the
+ * split index to the lockfile. If the temporary file for the shared
+ * index cannot be created, fall back to the behavior described in
+ * the previous paragraph.
+ *
+ * With `COMMIT_LOCK`, the lock is always committed or rolled back.
+ * Without it, the lock is closed, but neither committed nor rolled
+ * back.
+ *
+ * If `SKIP_IF_UNCHANGED` is given and the index is unchanged, nothing
+ * is written (and the lock is rolled back if `COMMIT_LOCK` is given).
+ */
+int write_locked_index(struct index_state *, struct lock_file *lock, unsigned flags);
+
+void discard_index(struct index_state *);
+void move_index_extensions(struct index_state *dst, struct index_state *src);
+int unmerged_index(const struct index_state *);
+
+/**
+ * Returns 1 if istate differs from tree, 0 otherwise.  If tree is NULL,
+ * compares istate to HEAD.  If tree is NULL and on an unborn branch,
+ * returns 1 if there are entries in istate, 0 otherwise.  If an strbuf is
+ * provided, the space-separated list of files that differ will be appended
+ * to it.
+ */
+int repo_index_has_changes(struct repository *repo,
+			   struct tree *tree,
+			   struct strbuf *sb);
+
+int verify_path(const char *path, unsigned mode);
+int strcmp_offset(const char *s1, const char *s2, size_t *first_change);
+
+/*
+ * Searches for an entry defined by name and namelen in the given index.
+ * If the return value is positive (including 0) it is the position of an
+ * exact match. If the return value is negative, the negated value minus 1
+ * is the position where the entry would be inserted.
+ * Example: The current index consists of these files and its stages:
+ *
+ *   b#0, d#0, f#1, f#3
+ *
+ * index_name_pos(&index, "a", 1) -> -1
+ * index_name_pos(&index, "b", 1) ->  0
+ * index_name_pos(&index, "c", 1) -> -2
+ * index_name_pos(&index, "d", 1) ->  1
+ * index_name_pos(&index, "e", 1) -> -3
+ * index_name_pos(&index, "f", 1) -> -3
+ * index_name_pos(&index, "g", 1) -> -5
+ */
+int index_name_pos(struct index_state *, const char *name, int namelen);
+
+/*
+ * Like index_name_pos, returns the position of an entry of the given name in
+ * the index if one exists, otherwise returns a negative value where the negated
+ * value minus 1 is the position where the index entry would be inserted. Unlike
+ * index_name_pos, however, a sparse index is not expanded to find an entry
+ * inside a sparse directory.
+ */
+int index_name_pos_sparse(struct index_state *, const char *name, int namelen);
+
+/*
+ * Determines whether an entry with the given name exists within the
+ * given index. The return value is 1 if an exact match is found, otherwise
+ * it is 0. Note that, unlike index_name_pos, this function does not expand
+ * the index if it is sparse. If an item exists within the full index but it
+ * is contained within a sparse directory (and not in the sparse index), 0 is
+ * returned.
+ */
+int index_entry_exists(struct index_state *, const char *name, int namelen);
+
+/*
+ * Some functions return the negative complement of an insert position when a
+ * precise match was not found but a position was found where the entry would
+ * need to be inserted. This helper protects that logic from any integer
+ * underflow.
+ */
+static inline int index_pos_to_insert_pos(uintmax_t pos)
+{
+	if (pos > INT_MAX)
+		die("overflow: -1 - %"PRIuMAX, pos);
+	return -1 - (int)pos;
+}
+
+#define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
+#define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
+#define ADD_CACHE_SKIP_DFCHECK 4	/* Ok to skip DF conflict checks */
+#define ADD_CACHE_JUST_APPEND 8		/* Append only */
+#define ADD_CACHE_NEW_ONLY 16		/* Do not replace existing ones */
+#define ADD_CACHE_KEEP_CACHE_TREE 32	/* Do not invalidate cache-tree */
+#define ADD_CACHE_RENORMALIZE 64        /* Pass along HASH_RENORMALIZE */
+int add_index_entry(struct index_state *, struct cache_entry *ce, int option);
+void rename_index_entry_at(struct index_state *, int pos, const char *new_name);
+
+/* Remove entry, return true if there are more entries to go. */
+int remove_index_entry_at(struct index_state *, int pos);
+
+void remove_marked_cache_entries(struct index_state *istate, int invalidate);
+int remove_file_from_index(struct index_state *, const char *path);
+#define ADD_CACHE_VERBOSE 1
+#define ADD_CACHE_PRETEND 2
+#define ADD_CACHE_IGNORE_ERRORS	4
+#define ADD_CACHE_IGNORE_REMOVAL 8
+#define ADD_CACHE_INTENT 16
+/*
+ * These two are used to add the contents of the file at path
+ * to the index, marking the working tree up-to-date by storing
+ * the cached stat info in the resulting cache entry.  A caller
+ * that has already run lstat(2) on the path can call
+ * add_to_index(), and all others can call add_file_to_index();
+ * the latter will do necessary lstat(2) internally before
+ * calling the former.
+ */
+int add_to_index(struct index_state *, const char *path, struct stat *, int flags);
+int add_file_to_index(struct index_state *, const char *path, int flags);
+
+int chmod_index_entry(struct index_state *, struct cache_entry *ce, char flip);
+int ce_same_name(const struct cache_entry *a, const struct cache_entry *b);
+void set_object_name_for_intent_to_add_entry(struct cache_entry *ce);
+int index_name_is_other(struct index_state *, const char *, int);
+void *read_blob_data_from_index(struct index_state *, const char *, unsigned long *);
+
+/* do stat comparison even if CE_VALID is true */
+#define CE_MATCH_IGNORE_VALID		01
+/* do not check the contents but report dirty on racily-clean entries */
+#define CE_MATCH_RACY_IS_DIRTY		02
+/* do stat comparison even if CE_SKIP_WORKTREE is true */
+#define CE_MATCH_IGNORE_SKIP_WORKTREE	04
+/* ignore non-existent files during stat update  */
+#define CE_MATCH_IGNORE_MISSING		0x08
+/* enable stat refresh */
+#define CE_MATCH_REFRESH		0x10
+/* don't refresh_fsmonitor state or do stat comparison even if CE_FSMONITOR_VALID is true */
+#define CE_MATCH_IGNORE_FSMONITOR 0X20
+int is_racy_timestamp(const struct index_state *istate,
+		      const struct cache_entry *ce);
+int has_racy_timestamp(struct index_state *istate);
+int ie_match_stat(struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
+int ie_modified(struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
+
+int match_stat_data_racy(const struct index_state *istate,
+			 const struct stat_data *sd, struct stat *st);
+
+void fill_stat_cache_info(struct index_state *istate, struct cache_entry *ce, struct stat *st);
+
+#define REFRESH_REALLY                   (1 << 0) /* ignore_valid */
+#define REFRESH_UNMERGED                 (1 << 1) /* allow unmerged */
+#define REFRESH_QUIET                    (1 << 2) /* be quiet about it */
+#define REFRESH_IGNORE_MISSING           (1 << 3) /* ignore non-existent */
+#define REFRESH_IGNORE_SUBMODULES        (1 << 4) /* ignore submodules */
+#define REFRESH_IN_PORCELAIN             (1 << 5) /* user friendly output, not "needs update" */
+#define REFRESH_PROGRESS                 (1 << 6) /* show progress bar if stderr is tty */
+#define REFRESH_IGNORE_SKIP_WORKTREE     (1 << 7) /* ignore skip_worktree entries */
+int refresh_index(struct index_state *, unsigned int flags, const struct pathspec *pathspec, char *seen, const char *header_msg);
+/*
+ * Refresh the index and write it to disk.
+ *
+ * 'refresh_flags' is passed directly to 'refresh_index()', while
+ * 'COMMIT_LOCK | write_flags' is passed to 'write_locked_index()', so
+ * the lockfile is always either committed or rolled back.
+ *
+ * If 'gentle' is passed, errors locking the index are ignored.
+ *
+ * Return 1 if refreshing the index returns an error, -1 if writing
+ * the index to disk fails, 0 on success.
+ *
+ * Note that if refreshing the index returns an error, we still write
+ * out the index (unless locking fails).
+ */
+int repo_refresh_and_write_index(struct repository*, unsigned int refresh_flags, unsigned int write_flags, int gentle, const struct pathspec *, char *seen, const char *header_msg);
+
+struct cache_entry *refresh_cache_entry(struct index_state *, struct cache_entry *, unsigned int);
+
+void set_alternate_index_output(const char *);
+
+extern int verify_index_checksum;
+extern int verify_ce_order;
+
+int cmp_cache_name_compare(const void *a_, const void *b_);
+
+int add_files_to_cache(struct repository *repo, const char *prefix,
+		       const struct pathspec *pathspec, int include_sparse,
+		       int flags);
+
+void overlay_tree_on_index(struct index_state *istate,
+			   const char *tree_name, const char *prefix);
+
+#endif /* READ_CACHE_LL_H */
diff --git a/read-cache.c b/read-cache.c
index 3fad839fb6f..42f27b06642 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -28,6 +28,7 @@
 #include "name-hash.h"
 #include "object-name.h"
 #include "preload-index.h"
+#include "read-cache.h"
 #include "resolve-undo.h"
 #include "revision.h"
 #include "run-command.h"
diff --git a/read-cache.h b/read-cache.h
new file mode 100644
index 00000000000..043da1f1aae
--- /dev/null
+++ b/read-cache.h
@@ -0,0 +1,45 @@
+#ifndef READ_CACHE_H
+#define READ_CACHE_H
+
+#include "read-cache-ll.h"
+#include "object.h"
+#include "pathspec.h"
+
+static inline unsigned int ce_mode_from_stat(const struct cache_entry *ce,
+					     unsigned int mode)
+{
+	extern int trust_executable_bit, has_symlinks;
+	if (!has_symlinks && S_ISREG(mode) &&
+	    ce && S_ISLNK(ce->ce_mode))
+		return ce->ce_mode;
+	if (!trust_executable_bit && S_ISREG(mode)) {
+		if (ce && S_ISREG(ce->ce_mode))
+			return ce->ce_mode;
+		return create_ce_mode(0666);
+	}
+	return create_ce_mode(mode);
+}
+
+static inline int ce_to_dtype(const struct cache_entry *ce)
+{
+	unsigned ce_mode = ntohl(ce->ce_mode);
+	if (S_ISREG(ce_mode))
+		return DT_REG;
+	else if (S_ISDIR(ce_mode) || S_ISGITLINK(ce_mode))
+		return DT_DIR;
+	else if (S_ISLNK(ce_mode))
+		return DT_LNK;
+	else
+		return DT_UNKNOWN;
+}
+
+static inline int ce_path_match(struct index_state *istate,
+				const struct cache_entry *ce,
+				const struct pathspec *pathspec,
+				char *seen)
+{
+	return match_pathspec(istate, pathspec, ce->name, ce_namelen(ce), 0, seen,
+			      S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode));
+}
+
+#endif /* READ_CACHE_H */
diff --git a/repository.c b/repository.c
index c53e480e326..ebad755c2cc 100644
--- a/repository.c
+++ b/repository.c
@@ -10,6 +10,7 @@
 #include "config.h"
 #include "object.h"
 #include "lockfile.h"
+#include "read-cache-ll.h"
 #include "remote.h"
 #include "setup.h"
 #include "submodule-config.h"
diff --git a/rerere.c b/rerere.c
index e968d413d65..3bc9aedc286 100644
--- a/rerere.c
+++ b/rerere.c
@@ -7,6 +7,7 @@
 #include "hex.h"
 #include "lockfile.h"
 #include "string-list.h"
+#include "read-cache-ll.h"
 #include "rerere.h"
 #include "xdiff-interface.h"
 #include "dir.h"
diff --git a/resolve-undo.c b/resolve-undo.c
index 7ec09e89d4f..59598877841 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "dir.h"
 #include "hash.h"
+#include "read-cache.h"
 #include "resolve-undo.h"
 #include "sparse-index.h"
 #include "string-list.h"
diff --git a/revision.c b/revision.c
index 88b2f42daa6..8d37ec9f495 100644
--- a/revision.c
+++ b/revision.c
@@ -31,6 +31,7 @@
 #include "bisect.h"
 #include "packfile.h"
 #include "worktree.h"
+#include "read-cache.h"
 #include "setup.h"
 #include "sparse-index.h"
 #include "strvec.h"
diff --git a/split-index.c b/split-index.c
index 40e54760b35..0a8d3903d6f 100644
--- a/split-index.c
+++ b/split-index.c
@@ -3,6 +3,7 @@
 #include "gettext.h"
 #include "hash.h"
 #include "mem-pool.h"
+#include "read-cache-ll.h"
 #include "split-index.h"
 #include "strbuf.h"
 #include "ewah/ewok.h"
diff --git a/submodule.c b/submodule.c
index 2e78f513496..e09722d6be3 100644
--- a/submodule.c
+++ b/submodule.c
@@ -28,6 +28,7 @@
 #include "object-name.h"
 #include "object-store.h"
 #include "commit-reach.h"
+#include "read-cache-ll.h"
 #include "setup.h"
 #include "shallow.h"
 #include "trace2.h"
diff --git a/t/helper/test-cache-tree.c b/t/helper/test-cache-tree.c
index 9507b356e22..9d64422b3cc 100644
--- a/t/helper/test-cache-tree.c
+++ b/t/helper/test-cache-tree.c
@@ -6,6 +6,7 @@
 #include "tree.h"
 #include "cache-tree.h"
 #include "parse-options.h"
+#include "read-cache-ll.h"
 #include "repository.h"
 #include "setup.h"
 
diff --git a/t/helper/test-dump-cache-tree.c b/t/helper/test-dump-cache-tree.c
index f22f7bd84a9..78aa11bb194 100644
--- a/t/helper/test-dump-cache-tree.c
+++ b/t/helper/test-dump-cache-tree.c
@@ -5,6 +5,7 @@
 #include "hex.h"
 #include "tree.h"
 #include "cache-tree.h"
+#include "read-cache-ll.h"
 #include "repository.h"
 #include "setup.h"
 
diff --git a/t/helper/test-dump-fsmonitor.c b/t/helper/test-dump-fsmonitor.c
index 9a098a25cba..e4357d65ec5 100644
--- a/t/helper/test-dump-fsmonitor.c
+++ b/t/helper/test-dump-fsmonitor.c
@@ -1,5 +1,6 @@
 #include "test-tool.h"
 #include "cache.h"
+#include "read-cache-ll.h"
 #include "repository.h"
 #include "setup.h"
 
diff --git a/t/helper/test-dump-split-index.c b/t/helper/test-dump-split-index.c
index 63fde9157c4..59a24a842b4 100644
--- a/t/helper/test-dump-split-index.c
+++ b/t/helper/test-dump-split-index.c
@@ -2,6 +2,7 @@
 #include "test-tool.h"
 #include "cache.h"
 #include "hex.h"
+#include "read-cache-ll.h"
 #include "repository.h"
 #include "setup.h"
 #include "split-index.h"
diff --git a/t/helper/test-dump-untracked-cache.c b/t/helper/test-dump-untracked-cache.c
index df70be549fd..a1cbafd64f3 100644
--- a/t/helper/test-dump-untracked-cache.c
+++ b/t/helper/test-dump-untracked-cache.c
@@ -3,6 +3,7 @@
 #include "cache.h"
 #include "dir.h"
 #include "hex.h"
+#include "read-cache-ll.h"
 #include "repository.h"
 #include "setup.h"
 
diff --git a/t/helper/test-fast-rebase.c b/t/helper/test-fast-rebase.c
index d1d63feaa9e..cbcf2419f9b 100644
--- a/t/helper/test-fast-rebase.c
+++ b/t/helper/test-fast-rebase.c
@@ -21,6 +21,7 @@
 #include "lockfile.h"
 #include "merge-ort.h"
 #include "object-name.h"
+#include "read-cache-ll.h"
 #include "refs.h"
 #include "revision.h"
 #include "sequencer.h"
diff --git a/t/helper/test-fsmonitor-client.c b/t/helper/test-fsmonitor-client.c
index 9f18c685b7f..386f4cdaee5 100644
--- a/t/helper/test-fsmonitor-client.c
+++ b/t/helper/test-fsmonitor-client.c
@@ -7,6 +7,7 @@
 #include "cache.h"
 #include "parse-options.h"
 #include "fsmonitor-ipc.h"
+#include "read-cache-ll.h"
 #include "repository.h"
 #include "setup.h"
 #include "thread-utils.h"
diff --git a/t/helper/test-hash-speed.c b/t/helper/test-hash-speed.c
index f40d9ad0c2d..c1e82d5d028 100644
--- a/t/helper/test-hash-speed.c
+++ b/t/helper/test-hash-speed.c
@@ -1,5 +1,6 @@
 #include "test-tool.h"
 #include "cache.h"
+#include "hash-ll.h"
 
 #define NUM_SECONDS 3
 
diff --git a/t/helper/test-index-version.c b/t/helper/test-index-version.c
index a06c45c1f84..b3cbaf6d2a8 100644
--- a/t/helper/test-index-version.c
+++ b/t/helper/test-index-version.c
@@ -1,5 +1,6 @@
 #include "test-tool.h"
 #include "cache.h"
+#include "read-cache-ll.h"
 
 int cmd__index_version(int argc UNUSED, const char **argv UNUSED)
 {
diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper/test-lazy-init-name-hash.c
index 6944b7e825f..8eb327b3b93 100644
--- a/t/helper/test-lazy-init-name-hash.c
+++ b/t/helper/test-lazy-init-name-hash.c
@@ -4,6 +4,7 @@
 #include "environment.h"
 #include "name-hash.h"
 #include "parse-options.h"
+#include "read-cache-ll.h"
 #include "repository.h"
 #include "setup.h"
 #include "trace.h"
diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index 2ef53d5f7a2..90e4d29a06f 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -3,6 +3,7 @@
 #include "abspath.h"
 #include "environment.h"
 #include "path.h"
+#include "read-cache-ll.h"
 #include "setup.h"
 #include "string-list.h"
 #include "trace.h"
diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index c1ae2763954..0d548814e08 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -2,6 +2,7 @@
 #include "test-tool.h"
 #include "cache.h"
 #include "config.h"
+#include "read-cache-ll.h"
 #include "repository.h"
 #include "setup.h"
 #include "wrapper.h"
diff --git a/t/helper/test-scrap-cache-tree.c b/t/helper/test-scrap-cache-tree.c
index 6e17f50d225..7b7e2384043 100644
--- a/t/helper/test-scrap-cache-tree.c
+++ b/t/helper/test-scrap-cache-tree.c
@@ -2,6 +2,7 @@
 #include "test-tool.h"
 #include "cache.h"
 #include "lockfile.h"
+#include "read-cache-ll.h"
 #include "repository.h"
 #include "setup.h"
 #include "tree.h"
diff --git a/t/helper/test-sha1.c b/t/helper/test-sha1.c
index 71fe5c61455..dc6fb17f2a7 100644
--- a/t/helper/test-sha1.c
+++ b/t/helper/test-sha1.c
@@ -1,5 +1,6 @@
 #include "test-tool.h"
 #include "cache.h"
+#include "hash-ll.h"
 
 int cmd__sha1(int ac, const char **av)
 {
diff --git a/t/helper/test-sha256.c b/t/helper/test-sha256.c
index 0ac6a99d5f2..f50f64f1f22 100644
--- a/t/helper/test-sha256.c
+++ b/t/helper/test-sha256.c
@@ -1,5 +1,6 @@
 #include "test-tool.h"
 #include "cache.h"
+#include "hash-ll.h"
 
 int cmd__sha256(int ac, const char **av)
 {
diff --git a/t/helper/test-strcmp-offset.c b/t/helper/test-strcmp-offset.c
index 96b9a5b5291..d3f39207f14 100644
--- a/t/helper/test-strcmp-offset.c
+++ b/t/helper/test-strcmp-offset.c
@@ -1,5 +1,6 @@
 #include "test-tool.h"
 #include "cache.h"
+#include "read-cache-ll.h"
 
 int cmd__strcmp_offset(int argc UNUSED, const char **argv)
 {
diff --git a/t/helper/test-write-cache.c b/t/helper/test-write-cache.c
index eace08072d7..d27125eeacf 100644
--- a/t/helper/test-write-cache.c
+++ b/t/helper/test-write-cache.c
@@ -2,6 +2,7 @@
 #include "test-tool.h"
 #include "cache.h"
 #include "lockfile.h"
+#include "read-cache-ll.h"
 #include "repository.h"
 #include "setup.h"
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 078c53f7a13..fdcc46e474f 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -15,6 +15,7 @@
 #include "progress.h"
 #include "refs.h"
 #include "attr.h"
+#include "read-cache.h"
 #include "split-index.h"
 #include "sparse-index.h"
 #include "submodule.h"
diff --git a/unpack-trees.h b/unpack-trees.h
index 30622aeebff..9b827c307f6 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -1,8 +1,8 @@
 #ifndef UNPACK_TREES_H
 #define UNPACK_TREES_H
 
-#include "cache.h"
 #include "convert.h"
+#include "read-cache-ll.h"
 #include "strvec.h"
 #include "string-list.h"
 #include "tree-walk.h"
diff --git a/wt-status.c b/wt-status.c
index 068b76ef6d9..847b63c906e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -18,6 +18,7 @@
 #include "refs.h"
 #include "submodule.h"
 #include "column.h"
+#include "read-cache.h"
 #include "setup.h"
 #include "strbuf.h"
 #include "trace.h"
-- 
gitgitgadget


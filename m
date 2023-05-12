Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B219C77B75
	for <git@archiver.kernel.org>; Fri, 12 May 2023 07:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240010AbjELHFm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 03:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240089AbjELHFD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 03:05:03 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBE2E737
        for <git@vger.kernel.org>; Fri, 12 May 2023 00:04:54 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3078a3f3b5fso6680743f8f.0
        for <git@vger.kernel.org>; Fri, 12 May 2023 00:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683875093; x=1686467093;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvjvueh4i/VFzVbG1a5farWuuxDO9BQrH1hBX0Gy1FA=;
        b=rYFBldcghtng4VaWI1PNnH/bIs+9EN+qxfUW8Q4TF/z4G1JF/sv1cQdsO17HUDVei3
         5fwUJhL3F1coY5TVqWEF9s8TOoNET4Ue/4ywvtvFUzUwt6HOiuSJKM1zlPvjH67ZP7Ju
         5Gk99ZljZGplq3Llfugu1Q8mHnUyh8kMTtvxtMUjV9NsNL5Toy9nmnvBYPUiA39qNOOc
         A01DyHf1vU0BnIGUhFMURz5aF8rYPBkpRS22IMVpRhJPmFep8ZyrbPeRjQ+K46jeHf3Z
         LB0GORvhNNoJ8pGccb/jQvoxbJG0R4khxKDXDqts4nouQ0cYC7EpKAnQQtlzo/NnY2al
         KMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683875093; x=1686467093;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvjvueh4i/VFzVbG1a5farWuuxDO9BQrH1hBX0Gy1FA=;
        b=FFHUSXp7GBvf6xD5yDwOQK28z/inPIuP91Ml0bdyzXzNwKVhu9ajxPD2Kvf379Rgw0
         cP4HUIjl4uyvebH/ARrDq8O6r5BK83KbQ6Ka00iI/uIY57EJr3xpoFzp2V2DjjcYvNFd
         9G2dhfNMwsdNjS4IB5AGiL4Oo/IppeGMGuZg0C+flRgUVaW8/3j2qqvDhMntwdwf+ioL
         A/E/LXaZMY0Ir+HzNnKy23Tf7G7x/KxpCfS445p4EfNJrXbQC3snBsKjBgENkAVMcVun
         QA5wdq5Lix/rSaUNRHw4ccfSm7/Fdwe2raBP/EcPNLs2nW+Wk4T1Sf3b/LpGAQsGQ3em
         uLRg==
X-Gm-Message-State: AC+VfDz5z9IFiBJZpe5RJLbHff4JD6jGJHL3D7HAXKTXxtl8lY/IfyMi
        lMrkQ10+kQg8zsnWM9sLBS9lqoYATgw=
X-Google-Smtp-Source: ACHHUZ6UErCXa68JfpvRrEVVUuJROyVTA/0R/NU5sM9yTDvkns2ryAKdWxAoRKo2/1D4Vr9mJ+1JUA==
X-Received: by 2002:a05:6000:1372:b0:307:7ae6:fe98 with SMTP id q18-20020a056000137200b003077ae6fe98mr16753916wrz.22.1683875092782;
        Fri, 12 May 2023 00:04:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n7-20020a5d6607000000b00307d20546e6sm2583948wru.27.2023.05.12.00.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 00:04:52 -0700 (PDT)
Message-Id: <a438cfbb0953f2281e1b96a14b9afb73d2c377bd.1683875072.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
        <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 May 2023 07:04:21 +0000
Subject: [PATCH v2 20/27] diff.h: remove unnecessary include of oidset.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This also made it clear that several .c files depended upon various
things that oidset included, but had omitted the direct #include for
those headers.  Add those now.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 add-interactive.c                | 2 ++
 add-patch.c                      | 1 +
 blame.h                          | 1 +
 builtin/add.c                    | 1 +
 builtin/diff-files.c             | 1 +
 builtin/diff-index.c             | 1 +
 builtin/merge-ours.c             | 1 +
 builtin/patch-id.c               | 1 +
 builtin/range-diff.c             | 1 +
 builtin/reflog.c                 | 1 +
 builtin/reset.c                  | 1 +
 builtin/rev-parse.c              | 1 +
 builtin/revert.c                 | 1 +
 builtin/shortlog.c               | 1 +
 builtin/stash.c                  | 1 +
 diff-lib.c                       | 2 ++
 diff.h                           | 4 +++-
 diffcore-break.c                 | 1 +
 diffcore-pickaxe.c               | 1 +
 line-log.c                       | 1 +
 merge.c                          | 2 ++
 patch-ids.c                      | 1 +
 pretty.c                         | 1 +
 range-diff.c                     | 1 +
 reflog-walk.c                    | 1 +
 t/helper/test-fast-rebase.c      | 1 +
 t/helper/test-revision-walking.c | 1 +
 transport-helper.c               | 1 +
 tree-diff.c                      | 1 +
 wt-status.c                      | 1 +
 30 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/add-interactive.c b/add-interactive.c
index 40f88c02051..add9a1ad436 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -4,9 +4,11 @@
 #include "config.h"
 #include "diffcore.h"
 #include "gettext.h"
+#include "hash.h"
 #include "hex.h"
 #include "preload-index.h"
 #include "read-cache-ll.h"
+#include "repository.h"
 #include "revision.h"
 #include "refs.h"
 #include "string-list.h"
diff --git a/add-patch.c b/add-patch.c
index 875b96e2274..53e32482959 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -7,6 +7,7 @@
 #include "gettext.h"
 #include "object-name.h"
 #include "read-cache-ll.h"
+#include "repository.h"
 #include "strbuf.h"
 #include "run-command.h"
 #include "strvec.h"
diff --git a/blame.h b/blame.h
index b60d1d81e30..31ddc85f19e 100644
--- a/blame.h
+++ b/blame.h
@@ -2,6 +2,7 @@
 #define BLAME_H
 
 #include "commit.h"
+#include "oidset.h"
 #include "xdiff-interface.h"
 #include "revision.h"
 #include "prio-queue.h"
diff --git a/builtin/add.c b/builtin/add.c
index 43183114487..e3ca3e4edbe 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -21,6 +21,7 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "read-cache.h"
+#include "repository.h"
 #include "revision.h"
 #include "bulk-checkin.h"
 #include "strvec.h"
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index b7036aa7c2b..07f6dff844c 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -9,6 +9,7 @@
 #include "diff-merges.h"
 #include "commit.h"
 #include "preload-index.h"
+#include "repository.h"
 #include "revision.h"
 #include "submodule.h"
 
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 1ab8f8b6dc5..a8b2c0a4b96 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -4,6 +4,7 @@
 #include "diff-merges.h"
 #include "commit.h"
 #include "preload-index.h"
+#include "repository.h"
 #include "revision.h"
 #include "setup.h"
 #include "submodule.h"
diff --git a/builtin/merge-ours.c b/builtin/merge-ours.c
index c2e519301e9..932924e5d0e 100644
--- a/builtin/merge-ours.c
+++ b/builtin/merge-ours.c
@@ -10,6 +10,7 @@
 #include "git-compat-util.h"
 #include "builtin.h"
 #include "diff.h"
+#include "repository.h"
 
 static const char builtin_merge_ours_usage[] =
 	"git merge-ours <base>... -- HEAD <remote>...";
diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 27952f1a6fd..b7118b290b1 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "diff.h"
 #include "gettext.h"
+#include "hash.h"
 #include "hex.h"
 #include "parse-options.h"
 
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index 8610390d7c5..e455a4795cc 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -4,6 +4,7 @@
 #include "parse-options.h"
 #include "range-diff.h"
 #include "config.h"
+#include "repository.h"
 #include "revision.h"
 
 static const char * const builtin_range_diff_usage[] = {
diff --git a/builtin/reflog.c b/builtin/reflog.c
index a1fa0c855f4..fc217748808 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
+#include "repository.h"
 #include "revision.h"
 #include "reachable.h"
 #include "worktree.h"
diff --git a/builtin/reset.c b/builtin/reset.c
index f947c449d14..dad2117c974 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -13,6 +13,7 @@
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
+#include "hash.h"
 #include "hex.h"
 #include "lockfile.h"
 #include "tag.h"
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 6eb5965bee4..4a219ea93bb 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -11,6 +11,7 @@
 #include "commit.h"
 #include "environment.h"
 #include "gettext.h"
+#include "hash.h"
 #include "hex.h"
 #include "refs.h"
 #include "quote.h"
diff --git a/builtin/revert.c b/builtin/revert.c
index 0240ec8593b..f6f07d9b539 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -5,6 +5,7 @@
 #include "parse-options.h"
 #include "diff.h"
 #include "gettext.h"
+#include "repository.h"
 #include "revision.h"
 #include "rerere.h"
 #include "dir.h"
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 99be9dc417d..1307ed2b88a 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -5,6 +5,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "string-list.h"
+#include "repository.h"
 #include "revision.h"
 #include "utf8.h"
 #include "mailmap.h"
diff --git a/builtin/stash.c b/builtin/stash.c
index d3d5bb95e26..84e83e0627f 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -4,6 +4,7 @@
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
+#include "hash.h"
 #include "hex.h"
 #include "object-name.h"
 #include "parse-options.h"
diff --git a/diff-lib.c b/diff-lib.c
index f3aa7f93c78..cad18099aba 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -7,6 +7,7 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "gettext.h"
+#include "hash.h"
 #include "hex.h"
 #include "object-name.h"
 #include "read-cache.h"
@@ -14,6 +15,7 @@
 #include "cache-tree.h"
 #include "unpack-trees.h"
 #include "refs.h"
+#include "repository.h"
 #include "submodule.h"
 #include "symlinks.h"
 #include "trace.h"
diff --git a/diff.h b/diff.h
index 29a9cd217c2..c2e0e63609f 100644
--- a/diff.h
+++ b/diff.h
@@ -4,10 +4,12 @@
 #ifndef DIFF_H
 #define DIFF_H
 
+#include "hash-ll.h"
 #include "pathspec.h"
-#include "oidset.h"
 #include "strbuf.h"
 
+struct oidset;
+
 /**
  * The diff API is for programs that compare two sets of files (e.g. two trees,
  * one tree and the index) and present the found difference in various ways.
diff --git a/diffcore-break.c b/diffcore-break.c
index 4909dc088e6..f57ece2757d 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -4,6 +4,7 @@
 #include "git-compat-util.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "hash.h"
 #include "object.h"
 #include "promisor-remote.h"
 
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 13c98a7b5e7..b195fa4eb3c 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -7,6 +7,7 @@
 #include "diffcore.h"
 #include "xdiff-interface.h"
 #include "kwset.h"
+#include "oidset.h"
 #include "pretty.h"
 #include "quote.h"
 
diff --git a/line-log.c b/line-log.c
index 6a7ac312a43..2eff914bf36 100644
--- a/line-log.c
+++ b/line-log.c
@@ -8,6 +8,7 @@
 #include "diff.h"
 #include "commit.h"
 #include "decorate.h"
+#include "repository.h"
 #include "revision.h"
 #include "xdiff-interface.h"
 #include "strbuf.h"
diff --git a/merge.c b/merge.c
index 83bcba6943e..b60925459c2 100644
--- a/merge.c
+++ b/merge.c
@@ -2,10 +2,12 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "gettext.h"
+#include "hash.h"
 #include "hex.h"
 #include "lockfile.h"
 #include "merge.h"
 #include "commit.h"
+#include "repository.h"
 #include "run-command.h"
 #include "resolve-undo.h"
 #include "tree.h"
diff --git a/patch-ids.c b/patch-ids.c
index 19af7bee984..c3e1a0dd216 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "diff.h"
 #include "commit.h"
+#include "hash.h"
 #include "hash-lookup.h"
 #include "hex.h"
 #include "patch-ids.h"
diff --git a/pretty.c b/pretty.c
index 0bb938021ba..2cf2cbbd038 100644
--- a/pretty.c
+++ b/pretty.c
@@ -4,6 +4,7 @@
 #include "commit.h"
 #include "environment.h"
 #include "gettext.h"
+#include "hash.h"
 #include "hex.h"
 #include "utf8.h"
 #include "diff.h"
diff --git a/range-diff.c b/range-diff.c
index 6a704e6f471..2e86063491e 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -13,6 +13,7 @@
 #include "commit.h"
 #include "pager.h"
 #include "pretty.h"
+#include "repository.h"
 #include "userdiff.h"
 #include "apply.h"
 #include "revision.h"
diff --git a/reflog-walk.c b/reflog-walk.c
index 4ba1a10c82c..d337e64431f 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -3,6 +3,7 @@
 #include "commit.h"
 #include "refs.h"
 #include "diff.h"
+#include "repository.h"
 #include "revision.h"
 #include "string-list.h"
 #include "reflog-walk.h"
diff --git a/t/helper/test-fast-rebase.c b/t/helper/test-fast-rebase.c
index 62c5b5d704b..cac20a72b3f 100644
--- a/t/helper/test-fast-rebase.c
+++ b/t/helper/test-fast-rebase.c
@@ -16,6 +16,7 @@
 #include "commit.h"
 #include "environment.h"
 #include "gettext.h"
+#include "hash.h"
 #include "hex.h"
 #include "lockfile.h"
 #include "merge-ort.h"
diff --git a/t/helper/test-revision-walking.c b/t/helper/test-revision-walking.c
index 0c62b9de185..f346951bc28 100644
--- a/t/helper/test-revision-walking.c
+++ b/t/helper/test-revision-walking.c
@@ -11,6 +11,7 @@
 #include "test-tool.h"
 #include "commit.h"
 #include "diff.h"
+#include "repository.h"
 #include "revision.h"
 #include "setup.h"
 
diff --git a/transport-helper.c b/transport-helper.c
index 6b816940dc6..5c0bc6a896e 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -8,6 +8,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "object-name.h"
+#include "repository.h"
 #include "revision.h"
 #include "remote.h"
 #include "string-list.h"
diff --git a/tree-diff.c b/tree-diff.c
index 20bb15f38d9..966946848ae 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -4,6 +4,7 @@
 #include "git-compat-util.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "hash.h"
 #include "tree.h"
 #include "tree-walk.h"
 
diff --git a/wt-status.c b/wt-status.c
index 7ada6b305f6..bcd0ef80441 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -7,6 +7,7 @@
 #include "diff.h"
 #include "environment.h"
 #include "gettext.h"
+#include "hash.h"
 #include "hex.h"
 #include "object-name.h"
 #include "path.h"
-- 
gitgitgadget


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A62CC7EE25
	for <git@archiver.kernel.org>; Fri, 12 May 2023 07:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240130AbjELHFU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 03:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240090AbjELHEs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 03:04:48 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441067A84
        for <git@vger.kernel.org>; Fri, 12 May 2023 00:04:47 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-306f2b42a86so6282989f8f.3
        for <git@vger.kernel.org>; Fri, 12 May 2023 00:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683875085; x=1686467085;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XH+16sMx+RbV9GvYAzMzrOb5IHu2U5QC3zjANAUk960=;
        b=cjLu6bKT3E8a+f7hwAabxcJrwO9dLIl09fTHT6V2JXJHRiKgp4FkSnxp3VoVuIcMx6
         lovtzANBkPwGsE8eGPuHeSbYDTexThANypQ1sQOXYP02jWu+mF8VXC+AQh5uzz6jWC7J
         RYaoJ0u/G5IZhXPj4OauwRzwq8ULJJRRBhaEaNzom4e4u2cunWagEzariGuvhGj+dWD2
         IxHDgSh40c/lU8/iA71ySMPub+4iyduXtsv2eQ5x5j22SR+clJW86p3QM2F9Vs62W4qr
         nHL6ntzjB3iDsmwuSHbtZmd2Dk3atNSJudGcmxwVe7fepttcGi2pginWTnm2j9s4Fdnm
         XNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683875085; x=1686467085;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XH+16sMx+RbV9GvYAzMzrOb5IHu2U5QC3zjANAUk960=;
        b=WCOS6uwzwDex6Ze/0vm5GFkiOy7yr3O648h5Za85k7PFPfacV20M/zahbRnyTsRHLN
         goi24ehH4kURaFbL9OavE5gbr2jKzDPBITLxVJpMZMaj27sEAp9NMFyBU55lsnPaDyEk
         H3Ykum8v8fd/7tLxtEU7iX7y631H9WOEx7dMdJwDcTVbG+qLTMy66LaXXaYMXsd7dDa9
         DanupGAu5rqOKZCcVGCZY1RjSjEhK5/AXPb/Kv4/i/hqXqcerk+LmWiVJB3tYeqQVRPN
         q9PD3eMvDzkh09cz0COVUMHK9RKHTSnOvDjufbcm9zd9fF0+YhycjaDtmBkWdpDaN9EF
         8nxQ==
X-Gm-Message-State: AC+VfDyaa1eQ9cOguQgric6JVDskESC8JjSpgGvD+d7aXqMT/gKCO5oX
        8SKSwB5OtHsHeq5AVduy8UjSv4zORZM=
X-Google-Smtp-Source: ACHHUZ7/Vapht0+jQROMnXZQ5kZ41dsCcKFPWQoAZIkyZPuTkq8TRT/gCzS5KQFj09Z3wSAKhxz6vQ==
X-Received: by 2002:adf:e511:0:b0:304:6715:8728 with SMTP id j17-20020adfe511000000b0030467158728mr19355714wrm.18.1683875085431;
        Fri, 12 May 2023 00:04:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z18-20020a1c4c12000000b003f188f608b9sm27611876wmf.8.2023.05.12.00.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 00:04:45 -0700 (PDT)
Message-Id: <f46aa5e73a1a06b1287b068a020a34aaf4b2b160.1683875070.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
        <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 May 2023 07:04:12 +0000
Subject: [PATCH v2 11/27] sparse-index.h: move declarations for sparse-index.c
 from cache.h
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

Note in particular that this reverses the decision made in 118a2e8bde0
("cache: move ensure_full_index() to cache.h", 2021-04-01).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/checkout-index.c    | 1 +
 builtin/commit.c            | 1 +
 builtin/difftool.c          | 1 +
 builtin/fsck.c              | 1 +
 builtin/ls-files.c          | 1 +
 builtin/merge-index.c       | 1 +
 builtin/read-tree.c         | 1 +
 builtin/reset.c             | 1 +
 builtin/rm.c                | 1 +
 builtin/stash.c             | 1 +
 builtin/submodule--helper.c | 1 +
 builtin/update-index.c      | 1 +
 cache.h                     | 2 --
 dir.c                       | 1 +
 entry.c                     | 1 +
 merge-ort.c                 | 1 +
 merge-recursive.c           | 1 +
 resolve-undo.c              | 1 +
 revision.c                  | 1 +
 sequencer.c                 | 1 +
 sparse-index.h              | 2 ++
 21 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 9375a05539f..b1cd8bef264 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -17,6 +17,7 @@
 #include "entry.h"
 #include "parallel-checkout.h"
 #include "setup.h"
+#include "sparse-index.h"
 
 #define CHECKOUT_ALL 4
 static int nul_term_line;
diff --git a/builtin/commit.c b/builtin/commit.c
index bd634ee6ad1..02e2ef3e307 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -38,6 +38,7 @@
 #include "gpg-interface.h"
 #include "column.h"
 #include "sequencer.h"
+#include "sparse-index.h"
 #include "mailmap.h"
 #include "help.h"
 #include "commit-reach.h"
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 0049342f5c0..2c27a59e04a 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -23,6 +23,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "parse-options.h"
+#include "sparse-index.h"
 #include "strvec.h"
 #include "strbuf.h"
 #include "lockfile.h"
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 2cd461b84c1..7134596d218 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -25,6 +25,7 @@
 #include "replace-object.h"
 #include "resolve-undo.h"
 #include "run-command.h"
+#include "sparse-index.h"
 #include "worktree.h"
 #include "pack-revindex.h"
 
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 069b28bd484..45b3b0ce5d8 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -23,6 +23,7 @@
 #include "pathspec.h"
 #include "run-command.h"
 #include "setup.h"
+#include "sparse-index.h"
 #include "submodule.h"
 #include "submodule-config.h"
 
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index ab16e70f23d..d16e8aa414b 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -3,6 +3,7 @@
 #include "hex.h"
 #include "repository.h"
 #include "run-command.h"
+#include "sparse-index.h"
 
 static const char *pgm;
 static int one_shot, quiet;
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 440f19b1b87..bd1ce1d963f 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -22,6 +22,7 @@
 #include "repository.h"
 #include "resolve-undo.h"
 #include "setup.h"
+#include "sparse-index.h"
 #include "submodule.h"
 #include "submodule-config.h"
 
diff --git a/builtin/reset.c b/builtin/reset.c
index f99f32d5802..3dc41ac3327 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -29,6 +29,7 @@
 #include "unpack-trees.h"
 #include "cache-tree.h"
 #include "setup.h"
+#include "sparse-index.h"
 #include "submodule.h"
 #include "submodule-config.h"
 #include "trace.h"
diff --git a/builtin/rm.c b/builtin/rm.c
index b4589c824c0..377a0f66ad8 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -19,6 +19,7 @@
 #include "repository.h"
 #include "string-list.h"
 #include "setup.h"
+#include "sparse-index.h"
 #include "submodule.h"
 #include "pathspec.h"
 
diff --git a/builtin/stash.c b/builtin/stash.c
index a7e17ffe384..8856ac6d5c7 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -20,6 +20,7 @@
 #include "rerere.h"
 #include "revision.h"
 #include "setup.h"
+#include "sparse-index.h"
 #include "log-tree.h"
 #include "diffcore.h"
 #include "exec-cmd.h"
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6bf8d666ce9..c58cfbfd6d3 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -13,6 +13,7 @@
 #include "pathspec.h"
 #include "dir.h"
 #include "setup.h"
+#include "sparse-index.h"
 #include "submodule.h"
 #include "submodule-config.h"
 #include "string-list.h"
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 5fab9ad2ec4..47dc9b626ef 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -24,6 +24,7 @@
 #include "dir.h"
 #include "repository.h"
 #include "setup.h"
+#include "sparse-index.h"
 #include "split-index.h"
 #include "symlinks.h"
 #include "fsmonitor.h"
diff --git a/cache.h b/cache.h
index 316904da392..79daaa166b1 100644
--- a/cache.h
+++ b/cache.h
@@ -327,8 +327,6 @@ int read_index_from(struct index_state *, const char *path,
 		    const char *gitdir);
 int is_index_unborn(struct index_state *);
 
-void ensure_full_index(struct index_state *istate);
-
 /* For use with `write_locked_index()`. */
 #define COMMIT_LOCK		(1 << 0)
 #define SKIP_IF_UNCHANGED	(1 << 1)
diff --git a/dir.c b/dir.c
index 029aab36fe8..1e84b1e1f28 100644
--- a/dir.c
+++ b/dir.c
@@ -25,6 +25,7 @@
 #include "ewah/ewok.h"
 #include "fsmonitor.h"
 #include "setup.h"
+#include "sparse-index.h"
 #include "submodule-config.h"
 #include "symlinks.h"
 #include "trace2.h"
diff --git a/entry.c b/entry.c
index 7791cc999cc..53d00386748 100644
--- a/entry.c
+++ b/entry.c
@@ -6,6 +6,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "name-hash.h"
+#include "sparse-index.h"
 #include "streaming.h"
 #include "submodule.h"
 #include "symlinks.h"
diff --git a/merge-ort.c b/merge-ort.c
index 65837db77f0..4bff685e456 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -38,6 +38,7 @@
 #include "oid-array.h"
 #include "promisor-remote.h"
 #include "revision.h"
+#include "sparse-index.h"
 #include "strmap.h"
 #include "submodule-config.h"
 #include "submodule.h"
diff --git a/merge-recursive.c b/merge-recursive.c
index b341ba4f38d..0e16e7a06df 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -29,6 +29,7 @@
 #include "object-store.h"
 #include "repository.h"
 #include "revision.h"
+#include "sparse-index.h"
 #include "string-list.h"
 #include "submodule-config.h"
 #include "submodule.h"
diff --git a/resolve-undo.c b/resolve-undo.c
index 70a6db526d2..7ec09e89d4f 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -2,6 +2,7 @@
 #include "dir.h"
 #include "hash.h"
 #include "resolve-undo.h"
+#include "sparse-index.h"
 #include "string-list.h"
 
 /* The only error case is to run out of memory in string-list */
diff --git a/revision.c b/revision.c
index b33cc1d106a..88b2f42daa6 100644
--- a/revision.c
+++ b/revision.c
@@ -32,6 +32,7 @@
 #include "packfile.h"
 #include "worktree.h"
 #include "setup.h"
+#include "sparse-index.h"
 #include "strvec.h"
 #include "trace2.h"
 #include "commit-reach.h"
diff --git a/sequencer.c b/sequencer.c
index ff18f7f4203..cae9c75a54e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -28,6 +28,7 @@
 #include "merge-ort.h"
 #include "merge-ort-wrappers.h"
 #include "refs.h"
+#include "sparse-index.h"
 #include "strvec.h"
 #include "quote.h"
 #include "trailer.h"
diff --git a/sparse-index.h b/sparse-index.h
index 59a92d819ec..a16f3e67d75 100644
--- a/sparse-index.h
+++ b/sparse-index.h
@@ -37,4 +37,6 @@ struct pattern_list;
  */
 void expand_index(struct index_state *istate, struct pattern_list *pl);
 
+void ensure_full_index(struct index_state *istate);
+
 #endif
-- 
gitgitgadget


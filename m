Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CB0C77B75
	for <git@archiver.kernel.org>; Fri, 12 May 2023 07:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240141AbjELHF1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 03:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240095AbjELHEu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 03:04:50 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB487EF5
        for <git@vger.kernel.org>; Fri, 12 May 2023 00:04:48 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3063208beedso9091978f8f.1
        for <git@vger.kernel.org>; Fri, 12 May 2023 00:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683875087; x=1686467087;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siTYCzcFqM4BrwbGK2xSh1viUfSy9pAhhIrOWJ60wqY=;
        b=F99vzLsTUmr3s4xw0q6tdvXSybtDfOy2Yf7nWAzr6xkPAQ/bTqavTdmzz1JFlu/Sje
         qwzsVZ9X5W8Ay6Utd3iHBP0t+uWGfMVQFwZDzolz2owdTO63phFmPoRimPi5rjZU43jT
         DGL6XBn/V4OnCSl/jdjhrWmPJu2Tq8M8sZzidUz0J8Q7rGfNvweuGqr36yAwQWaWvGvD
         z37J+u1/qGumXwuJkdnAuRi8Y7n1TwtFQGB/0VpAOX1D9eH9EmnWgNXI4TcjX4cAXfPq
         c8rG1j6pHwTtZD14l4fL8tDP8kcd3uAbYVCMwICId+HlCjVOBe47nBMnEe6ER8jaPJjV
         yUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683875087; x=1686467087;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=siTYCzcFqM4BrwbGK2xSh1viUfSy9pAhhIrOWJ60wqY=;
        b=RIaEeEU6eLx1EoZXvRsJU+9kv9BwbxONiKjPqBy++EmlWyOFobww7nSojqc+n2KWka
         oN6ZzyDq/RZr55UjeQ+JVEt2753isjdCBqP0nDME+Bv0Y5yaPnksa4Q5ATUunHLhA9/W
         9WAcTEcndvUs3VyjB4cK6W0C4DHxIZFOr3cQ6BPRB9UhAc3ydhQSg6V4MgOiuv6nj64A
         weIhsL0Wxdmsk3j4I4ScFXraYZXoD2mcR4Eic2ckYAVvmfTTN9DADII2ZYmZnMU/ocdO
         YDjx4ISlp+n5TdcpBdWAE7SZ22ZY7CRBtZzT9a+K7vhiSj5H00K5DlWPs6YLKt/AkKiu
         Eqog==
X-Gm-Message-State: AC+VfDzx0GbHh8JVpJJIpkTHnNYjRCCpE3CzuSmg6kF5b89foSrTJRr+
        JEoOMzRQiCaqJ48rsft4eoSt2PTRm4E=
X-Google-Smtp-Source: ACHHUZ5OBnDcUjn/pRuwMdW9nQRKT8r7EO7WRY8Fjhj6wz0sf8KcnzSPJmW6/FVK/jSAOel4/h28Fw==
X-Received: by 2002:a5d:4810:0:b0:2fa:ce3:9a0 with SMTP id l16-20020a5d4810000000b002fa0ce309a0mr17303051wrq.36.1683875086183;
        Fri, 12 May 2023 00:04:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a6-20020a056000050600b003079c402762sm13162903wrf.19.2023.05.12.00.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 00:04:45 -0700 (PDT)
Message-Id: <b16c4d3429e3f6562c8ab7f1371b32ef88f7acec.1683875070.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
        <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 May 2023 07:04:13 +0000
Subject: [PATCH v2 12/27] preload-index.h: move declarations for
 preload-index.c from elsewhere
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

We already have a preload-index.c file; move the declarations for the
functions in that file into a new preload-index.h.  These were
previously split between cache.h and repository.h.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 add-interactive.c           |  1 +
 builtin/add.c               |  1 +
 builtin/am.c                |  1 +
 builtin/checkout.c          |  1 +
 builtin/commit.c            |  1 +
 builtin/diff-files.c        |  1 +
 builtin/diff-index.c        |  1 +
 builtin/diff.c              |  1 +
 builtin/stash.c             |  1 +
 builtin/submodule--helper.c |  1 +
 cache.h                     |  3 ---
 preload-index.c             |  1 +
 preload-index.h             | 15 +++++++++++++++
 read-cache.c                |  1 +
 repository.h                |  3 ---
 15 files changed, 27 insertions(+), 6 deletions(-)
 create mode 100644 preload-index.h

diff --git a/add-interactive.c b/add-interactive.c
index de877ca0525..99f7dc3b0d1 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -5,6 +5,7 @@
 #include "diffcore.h"
 #include "gettext.h"
 #include "hex.h"
+#include "preload-index.h"
 #include "revision.h"
 #include "refs.h"
 #include "string-list.h"
diff --git a/builtin/add.c b/builtin/add.c
index 36ddbb159bf..8397be4f8de 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -17,6 +17,7 @@
 #include "cache-tree.h"
 #include "run-command.h"
 #include "parse-options.h"
+#include "preload-index.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "revision.h"
diff --git a/builtin/am.c b/builtin/am.c
index 5c83f2e003f..0d8f46f8d5a 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -29,6 +29,7 @@
 #include "unpack-trees.h"
 #include "branch.h"
 #include "object-name.h"
+#include "preload-index.h"
 #include "sequencer.h"
 #include "revision.h"
 #include "merge-recursive.h"
diff --git a/builtin/checkout.c b/builtin/checkout.c
index d6765c9dbd9..2d72a742d9d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -20,6 +20,7 @@
 #include "object-name.h"
 #include "object-store.h"
 #include "parse-options.h"
+#include "preload-index.h"
 #include "refs.h"
 #include "remote.h"
 #include "resolve-undo.h"
diff --git a/builtin/commit.c b/builtin/commit.c
index 02e2ef3e307..fa769045c88 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -30,6 +30,7 @@
 #include "utf8.h"
 #include "object-name.h"
 #include "parse-options.h"
+#include "preload-index.h"
 #include "string-list.h"
 #include "rerere.h"
 #include "unpack-trees.h"
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index dc991f753bb..2e6b59a8bb3 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -8,6 +8,7 @@
 #include "diff.h"
 #include "diff-merges.h"
 #include "commit.h"
+#include "preload-index.h"
 #include "revision.h"
 #include "builtin.h"
 #include "submodule.h"
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index b9a19bb7d38..9b98db2e77e 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -3,6 +3,7 @@
 #include "diff.h"
 #include "diff-merges.h"
 #include "commit.h"
+#include "preload-index.h"
 #include "revision.h"
 #include "builtin.h"
 #include "setup.h"
diff --git a/builtin/diff.c b/builtin/diff.c
index 7b64659fe79..967550739a6 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -16,6 +16,7 @@
 #include "diff.h"
 #include "diff-merges.h"
 #include "diffcore.h"
+#include "preload-index.h"
 #include "revision.h"
 #include "log-tree.h"
 #include "builtin.h"
diff --git a/builtin/stash.c b/builtin/stash.c
index 8856ac6d5c7..06527ee8471 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -17,6 +17,7 @@
 #include "run-command.h"
 #include "dir.h"
 #include "entry.h"
+#include "preload-index.h"
 #include "rerere.h"
 #include "revision.h"
 #include "setup.h"
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c58cfbfd6d3..597e780a93a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -11,6 +11,7 @@
 #include "parse-options.h"
 #include "quote.h"
 #include "pathspec.h"
+#include "preload-index.h"
 #include "dir.h"
 #include "setup.h"
 #include "sparse-index.h"
diff --git a/cache.h b/cache.h
index 79daaa166b1..b79802a4639 100644
--- a/cache.h
+++ b/cache.h
@@ -318,9 +318,6 @@ extern struct index_state the_index;
 
 /* Initialize and use the cache information */
 struct lock_file;
-void preload_index(struct index_state *index,
-		   const struct pathspec *pathspec,
-		   unsigned int refresh_flags);
 int do_read_index(struct index_state *istate, const char *path,
 		  int must_exist); /* for testting only! */
 int read_index_from(struct index_state *, const char *path,
diff --git a/preload-index.c b/preload-index.c
index 7a26b08c213..c26739debf8 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -8,6 +8,7 @@
 #include "fsmonitor.h"
 #include "gettext.h"
 #include "config.h"
+#include "preload-index.h"
 #include "progress.h"
 #include "thread-utils.h"
 #include "repository.h"
diff --git a/preload-index.h b/preload-index.h
new file mode 100644
index 00000000000..251b1ed88e9
--- /dev/null
+++ b/preload-index.h
@@ -0,0 +1,15 @@
+#ifndef PRELOAD_INDEX_H
+#define PRELOAD_INDEX_H
+
+struct index_state;
+struct pathspec;
+struct repository;
+
+void preload_index(struct index_state *index,
+		   const struct pathspec *pathspec,
+		   unsigned int refresh_flags);
+int repo_read_index_preload(struct repository *,
+			    const struct pathspec *pathspec,
+			    unsigned refresh_flags);
+
+#endif /* PRELOAD_INDEX_H */
diff --git a/read-cache.c b/read-cache.c
index e1016ae0317..3fad839fb6f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -27,6 +27,7 @@
 #include "mem-pool.h"
 #include "name-hash.h"
 #include "object-name.h"
+#include "preload-index.h"
 #include "resolve-undo.h"
 #include "revision.h"
 #include "run-command.h"
diff --git a/repository.h b/repository.h
index 1a13ff28677..f81228bcfb5 100644
--- a/repository.h
+++ b/repository.h
@@ -220,9 +220,6 @@ int repo_hold_locked_index(struct repository *repo,
 			   struct lock_file *lf,
 			   int flags);
 
-int repo_read_index_preload(struct repository *,
-			    const struct pathspec *pathspec,
-			    unsigned refresh_flags);
 int repo_read_index_unmerged(struct repository *);
 /*
  * Opportunistically update the index but do not complain if we can't.
-- 
gitgitgadget


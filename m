Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFDAC77B7C
	for <git@archiver.kernel.org>; Sun,  7 May 2023 03:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjEGDqb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 23:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjEGDqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 23:46:09 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99754237
        for <git@vger.kernel.org>; Sat,  6 May 2023 20:46:03 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f195b164c4so21393605e9.1
        for <git@vger.kernel.org>; Sat, 06 May 2023 20:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683431162; x=1686023162;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siTYCzcFqM4BrwbGK2xSh1viUfSy9pAhhIrOWJ60wqY=;
        b=nPn7EhbtQVR93mdPUU/tM+x5e7yl+eBMGW+lGXYrVOaH/MidKYXU6DuPyPYEekshuV
         s3Bu0heb/Yu2MWsJZdcwSSo1gGN7zO4pAXtg112Q/vVXT92BZGY238fHkWn/pXYtvT18
         i5B9UoOlg1K3OoPhU4pP5YNrR16jByT3TttNWG1LgBkb+sVQz44WD6a2Rn8yJYzfUTo1
         VcN2VI3+9R02mkjWabdkVed3VRlerH9+R7f3oFDWzTecB+g8aSwNwSDkZp7AGAu+UrxF
         wFeqkMdtnwrbo1FieyjN+e+2uq6NEiUL0sfdaxbjo/W3LlnakI8FNC07qhERX6GFsD70
         HTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683431162; x=1686023162;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=siTYCzcFqM4BrwbGK2xSh1viUfSy9pAhhIrOWJ60wqY=;
        b=YGswaoe5rmq2V+GSuFO8pijxwCatLBNiIqV4KGwUmufKqV8wbGamQ+vXyRa3TQXxLU
         wqQfcAcAfRLdppqRVrJ7R196Xg1UwNgudsZo+SD2wlUTLGW15fv2gkCC2j82TG7KrF82
         Qw5wugY3syrrOhU7osrG5sk0etmO4Ut5ZLrkU7RjHTAAaeuBWZKIQAuvRqgvY3GjUKxY
         VctpP0yk0iv2nBNNDErH52wksMmHZ9pV5bCjdL+YC4jCh+breUiDiDgGQtzkSX5j0ucQ
         OghaPMqE5WZhx7Q58QNlDqi8N04U7K3GljSwHWJmWTAN2ygfJEfgBHdSebIUzw+kaG5y
         hGGA==
X-Gm-Message-State: AC+VfDy0edclEZHW7M2ltr18WC6SmcNEqpuiAFXO0k27S4bFia85nkn9
        H/u7P6rqnpanrucSlLxhYeXzxWcfu74=
X-Google-Smtp-Source: ACHHUZ4XXPmjLUOHxrvNxJUHj6Nika9WJ/peXr3LKYyctfVKqdSf6IX4KzLO1NYi0zuE2a6a+uHVTQ==
X-Received: by 2002:adf:e4c8:0:b0:304:8888:87ad with SMTP id v8-20020adfe4c8000000b00304888887admr4652752wrm.12.1683431162114;
        Sat, 06 May 2023 20:46:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p1-20020a5d4581000000b0030639a86f9dsm6925570wrq.51.2023.05.06.20.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 20:46:01 -0700 (PDT)
Message-Id: <c39e4bdbfaf44da192b8590020916d534a118e74.1683431151.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 07 May 2023 03:45:36 +0000
Subject: [PATCH 11/24] preload-index.h: move declarations for preload-index.c
 from elsewhere
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


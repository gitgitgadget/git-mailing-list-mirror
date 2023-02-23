Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19542C636D7
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 08:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbjBWIGM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 03:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbjBWIFq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 03:05:46 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBBF497DA
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 00:05:34 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id bo30so9352705wrb.0
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 00:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcas6uDeEQ3KKCbaXhL2sBiojmDEyxQdnL5NNqIrEDA=;
        b=PK1FgIieQOg6VNRklmZwFtYokeIz/fCeV2bm9Or60HX+2ggW+YkXLIDTLqMdzPpKDM
         Ttrw/AllHG97d5NFZTbg55WcPZ3Qra4/U5V+10gxrJ0HRE/onzSA7NyqrvDU1I/cLYHv
         dG/0WvXh+lb93ZRW0NzaZ4Kpfq652GPp4gB6IeF4PG4zF3l2Ek4/lhUZyPTS9u5hkG0z
         G15obyeoci/FrepinP9HqpnGInRIYPeS0uu7xKHi7zq1mV1OgHSD5qvD45DvuGbkvuqU
         Xf0K4mu2joIWDX4yamwBWkswzKTspaOpk7Xiy7XEFcs3Tmy5BSh1yhjJJavZom5Qazo0
         ueaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xcas6uDeEQ3KKCbaXhL2sBiojmDEyxQdnL5NNqIrEDA=;
        b=xMtYkfWdYIRdPkQL8dZyl72oTdne1C2imobHMx0lNzIqLf/fgRfgRc7vQ2B5NwiWQx
         FrU45f+02fwO/zHoNSSsGkReS7p7ZvI5H7ifoEXczFfCsBxRphH+NpoctMharG0QTa0b
         svprEBk20HIBDDMM5Vma6TosbQrtGo8IsRYrMmTuQqiVUfYhlZ7HouuRKMTO2cHGBzSS
         z+s+PKQRHt0Y+1DYltn3FQBZIj++5WuJqc1ZR5dniZGqnDRn+EzENwg30qKHsN6LMHgx
         b8ExR7SVI2RobY2iR0DJdSqrKD0WaLG8gp/Twg/FORboPGRAKmyKXzaKZajF8icmMJC+
         F8rg==
X-Gm-Message-State: AO0yUKWwwwePuL63NvJkr4bvH9gjTDOrCkDF98OFzeP4sLsyYJN8wW+9
        FxTAM/cxEu4M7qsBmSaqvTjBdbKevV8=
X-Google-Smtp-Source: AK7set/4nLr9HbeU+S4khdN/0QOSE/fgD5eccwppOcrslrRoJf9SyiSDYPOXWJHi4Q5PEkEuSXBoGA==
X-Received: by 2002:adf:e58f:0:b0:2c5:a07e:4bb6 with SMTP id l15-20020adfe58f000000b002c5a07e4bb6mr9082730wrm.33.1677139533103;
        Thu, 23 Feb 2023 00:05:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x13-20020a5d6b4d000000b002c6e8af1037sm12361449wrw.104.2023.02.23.00.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 00:05:32 -0800 (PST)
Message-Id: <1abea7621eeef18ee08868373ad498d1dcc73231.1677139522.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Feb 2023 08:05:18 +0000
Subject: [PATCH 13/16] replace-object.h: move read_replace_refs declaration
 from cache.h to here
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

Adjust several files to be more explicit about their dependency on
replace-objects to accommodate this change.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/cat-file.c       | 1 +
 builtin/commit-graph.c   | 1 +
 builtin/fsck.c           | 1 +
 builtin/index-pack.c     | 1 +
 builtin/pack-objects.c   | 1 +
 builtin/prune.c          | 1 +
 builtin/replace.c        | 1 +
 builtin/unpack-objects.c | 1 +
 builtin/upload-pack.c    | 1 +
 cache.h                  | 8 --------
 config.c                 | 1 +
 environment.c            | 1 +
 git.c                    | 1 +
 log-tree.c               | 1 +
 replace-object.h         | 9 ++++++++-
 15 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index fe1b5bab05b..8349eecfa4a 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -17,6 +17,7 @@
 #include "oid-array.h"
 #include "packfile.h"
 #include "object-store.h"
+#include "replace-object.h"
 #include "promisor-remote.h"
 #include "mailmap.h"
 
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 93704f95a9d..2a7d6ba4dda 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -7,6 +7,7 @@
 #include "commit-graph.h"
 #include "object-store.h"
 #include "progress.h"
+#include "replace-object.h"
 #include "tag.h"
 
 #define BUILTIN_COMMIT_GRAPH_VERIFY_USAGE \
diff --git a/builtin/fsck.c b/builtin/fsck.c
index d207bd909b4..fc6b848a41a 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -19,6 +19,7 @@
 #include "decorate.h"
 #include "packfile.h"
 #include "object-store.h"
+#include "replace-object.h"
 #include "resolve-undo.h"
 #include "run-command.h"
 #include "worktree.h"
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 7e4b69f9a3e..febd756bc06 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -15,6 +15,7 @@
 #include "thread-utils.h"
 #include "packfile.h"
 #include "object-store.h"
+#include "replace-object.h"
 #include "promisor-remote.h"
 
 static const char index_pack_usage[] =
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 72c33fd739a..aa724974030 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -31,6 +31,7 @@
 #include "list.h"
 #include "packfile.h"
 #include "object-store.h"
+#include "replace-object.h"
 #include "dir.h"
 #include "midx.h"
 #include "trace2.h"
diff --git a/builtin/prune.c b/builtin/prune.c
index 27192201086..d0add18ac03 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -7,6 +7,7 @@
 #include "parse-options.h"
 #include "progress.h"
 #include "prune-packed.h"
+#include "replace-object.h"
 #include "object-store.h"
 #include "shallow.h"
 
diff --git a/builtin/replace.c b/builtin/replace.c
index a29e911d309..95f7a1f96d5 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -15,6 +15,7 @@
 #include "parse-options.h"
 #include "run-command.h"
 #include "object-store.h"
+#include "replace-object.h"
 #include "repository.h"
 #include "tag.h"
 
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 43789b8ef29..1557d2bbe1b 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -8,6 +8,7 @@
 #include "pack.h"
 #include "blob.h"
 #include "commit.h"
+#include "replace-object.h"
 #include "tag.h"
 #include "tree.h"
 #include "tree-walk.h"
diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
index 25b69da2bf2..7a3c68720f1 100644
--- a/builtin/upload-pack.c
+++ b/builtin/upload-pack.c
@@ -4,6 +4,7 @@
 #include "pkt-line.h"
 #include "parse-options.h"
 #include "protocol.h"
+#include "replace-object.h"
 #include "upload-pack.h"
 #include "serve.h"
 
diff --git a/cache.h b/cache.h
index 774d8c6bdfd..7172fbce7ac 100644
--- a/cache.h
+++ b/cache.h
@@ -887,14 +887,6 @@ void set_shared_repository(int value);
 int get_shared_repository(void);
 void reset_shared_repository(void);
 
-/*
- * Do replace refs need to be checked this run?  This variable is
- * initialized to true unless --no-replace-object is used or
- * $GIT_NO_REPLACE_OBJECTS is set, but is set to false by some
- * commands that do not want replace references to be active.
- */
-extern int read_replace_refs;
-
 /*
  * These values are used to help identify parts of a repository to fsync.
  * FSYNC_COMPONENT_NONE identifies data that will not be a persistent part of the
diff --git a/config.c b/config.c
index d3ab9417a45..d0aff55fa66 100644
--- a/config.c
+++ b/config.c
@@ -23,6 +23,7 @@
 #include "utf8.h"
 #include "dir.h"
 #include "color.h"
+#include "replace-object.h"
 #include "refs.h"
 #include "worktree.h"
 
diff --git a/environment.c b/environment.c
index 1ee3686fd8a..89d89110e41 100644
--- a/environment.c
+++ b/environment.c
@@ -17,6 +17,7 @@
 #include "commit.h"
 #include "strvec.h"
 #include "object-store.h"
+#include "replace-object.h"
 #include "tmp-objdir.h"
 #include "chdir-notify.h"
 #include "shallow.h"
diff --git a/git.c b/git.c
index 96b0a2837dc..389f46887e6 100644
--- a/git.c
+++ b/git.c
@@ -4,6 +4,7 @@
 #include "help.h"
 #include "run-command.h"
 #include "alias.h"
+#include "replace-object.h"
 #include "shallow.h"
 
 #define RUN_SETUP		(1<<0)
diff --git a/log-tree.c b/log-tree.c
index 1dd5fcbf7be..b1344bd0080 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -12,6 +12,7 @@
 #include "merge-ort.h"
 #include "reflog-walk.h"
 #include "refs.h"
+#include "replace-object.h"
 #include "string-list.h"
 #include "color.h"
 #include "gpg-interface.h"
diff --git a/replace-object.h b/replace-object.h
index 3c92ae94610..500482b02b3 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -1,11 +1,18 @@
 #ifndef REPLACE_OBJECT_H
 #define REPLACE_OBJECT_H
 
-#include "cache.h"
 #include "oidmap.h"
 #include "repository.h"
 #include "object-store.h"
 
+/*
+ * Do replace refs need to be checked this run?  This variable is
+ * initialized to true unless --no-replace-object is used or
+ * $GIT_NO_REPLACE_OBJECTS is set, but is set to false by some
+ * commands that do not want replace references to be active.
+ */
+extern int read_replace_refs;
+
 struct replace_object {
 	struct oidmap_entry original;
 	struct object_id replacement;
-- 
gitgitgadget


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EE7C678D5
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 00:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjBXAKU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 19:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjBXAKA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 19:10:00 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB282FCCD
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 16:09:53 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id r7so12165165wrz.6
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 16:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0zLeEp1uFK+VIIA7ZOUbuDLTStK4YGoCS8zeyeoGf0=;
        b=iiJgQgLJxoUGldfYzUH41XG7qUSnPzrBJAvsGH3q00BXLq86RibqJj8WIYRLZHpCwy
         YBGHzmxi5PFad95kO6Kgu+KnrxgSkgnd/JTbvgdJymQceaL+dXIcssOZbLTTNsUqVyei
         2VnNpeGCQTyUadC8llBjcj8/OBQX68KSmN6ogq4WY19ms04c37eZ4j2nm9xMwWKpz/0x
         PEV3Kts3cp3Pbu6PGsaVwNz5ws6lpMjncqAu/VsG0/u+dQO9ZPtWdSlVjA7/4PFo2pfm
         zM6uWNDm0rjfCVkAhkwm1FQEmJU9S+mIDy4DbBy8zcrehqZ+iZtnaQ8glcNHHA5j3rTC
         p2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0zLeEp1uFK+VIIA7ZOUbuDLTStK4YGoCS8zeyeoGf0=;
        b=g6GEKsXRd7AJg5Hplt9p25joIQgjKX02DE1Ir5zM1AVMfoLgj1WbaW/2y9eDtkolMU
         ndvor52jDCohVAp0hA7RgH7syOvhvHky15rgmi8LuDBt477eJcT5QcP3DtC03Dsbxvaq
         vIpEDBpHqeyo1fJg5oetHt7wfHVnM9K6ZCupQ9vvk5KWnXnsQVEDvcOiMHHSPTj/i38f
         LrsJyE5doBKCiASJxRaOYmD0WcSsSB5d4Q+CsVVhTaqFiPImKQEnXhqWE0cPW/zDXVGU
         JufioWA+6GieIto8zGQ4HluuvfTlRcH9pB0Qfc47O1r2uHxLDdSd17KNZjuWzZrVuvay
         0LUQ==
X-Gm-Message-State: AO0yUKVRcDMz9t9yKciG8NaXxE11ePuTQdvMiTLkyBLz8KvjAwQ5dfNk
        nNZ5UIQkb/cdwIG4yHsu/Bd7uD9cv1M=
X-Google-Smtp-Source: AK7set+fMVRwidMZNd0K38czWBopDxhtkKlW5lTQTsFpsR8gwF6Td+ml6+nOSwKz6oxiMqT5c33eug==
X-Received: by 2002:a05:6000:1f83:b0:2c5:642f:1550 with SMTP id bw3-20020a0560001f8300b002c5642f1550mr9961282wrb.15.1677197391485;
        Thu, 23 Feb 2023 16:09:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p20-20020a05600c359400b003daf7721bb3sm901704wmq.12.2023.02.23.16.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 16:09:51 -0800 (PST)
Message-Id: <c4f86b77e71622ec8a76b6d8eabf45b3d81e4892.1677197378.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1485.v2.git.1677197376.gitgitgadget@gmail.com>
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
        <pull.1485.v2.git.1677197376.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Feb 2023 00:09:33 +0000
Subject: [PATCH v2 14/17] replace-object.h: move read_replace_refs declaration
 from cache.h to here
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Emily Shaffer <nasamuffin@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
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
index 88c5ea8b267..b7a73acb074 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -18,6 +18,7 @@
 #include "oid-array.h"
 #include "packfile.h"
 #include "object-store.h"
+#include "replace-object.h"
 #include "promisor-remote.h"
 #include "mailmap.h"
 
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 6dc83dc51b3..d3be7f3b318 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -8,6 +8,7 @@
 #include "commit-graph.h"
 #include "object-store.h"
 #include "progress.h"
+#include "replace-object.h"
 #include "tag.h"
 
 #define BUILTIN_COMMIT_GRAPH_VERIFY_USAGE \
diff --git a/builtin/fsck.c b/builtin/fsck.c
index af0fab660dc..134b0bd18cd 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -20,6 +20,7 @@
 #include "decorate.h"
 #include "packfile.h"
 #include "object-store.h"
+#include "replace-object.h"
 #include "resolve-undo.h"
 #include "run-command.h"
 #include "worktree.h"
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 21c0e109dd2..b451755f405 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -16,6 +16,7 @@
 #include "thread-utils.h"
 #include "packfile.h"
 #include "object-store.h"
+#include "replace-object.h"
 #include "promisor-remote.h"
 
 static const char index_pack_usage[] =
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 2b5e85988c9..2e73284f107 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -32,6 +32,7 @@
 #include "list.h"
 #include "packfile.h"
 #include "object-store.h"
+#include "replace-object.h"
 #include "dir.h"
 #include "midx.h"
 #include "trace2.h"
diff --git a/builtin/prune.c b/builtin/prune.c
index db767b7a8fa..f2ed45ccf03 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -8,6 +8,7 @@
 #include "parse-options.h"
 #include "progress.h"
 #include "prune-packed.h"
+#include "replace-object.h"
 #include "object-store.h"
 #include "shallow.h"
 
diff --git a/builtin/replace.c b/builtin/replace.c
index cdcb39f737c..71d8e949e35 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -16,6 +16,7 @@
 #include "parse-options.h"
 #include "run-command.h"
 #include "object-store.h"
+#include "replace-object.h"
 #include "repository.h"
 #include "tag.h"
 
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index e125b121883..1908dcfcffb 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -9,6 +9,7 @@
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
index fdb3125f00d..0221bc6d5c9 100644
--- a/cache.h
+++ b/cache.h
@@ -886,14 +886,6 @@ void set_shared_repository(int value);
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
index ee3dfb6b659..043e0df685b 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -13,6 +13,7 @@
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


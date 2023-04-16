Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FACAC77B71
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 03:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjDPDEo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 23:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjDPDEN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 23:04:13 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A82B3AAE
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:42 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o9-20020a05600c510900b003f17012276fso509182wms.4
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681614220; x=1684206220;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Para9K873EeJhpyq7CI7rxs9jB2w3YqWXnEBSZEC70=;
        b=fBpStCjmOORu4w5LzFtRfZLv6BsehACCzRckai4dceECPNlhHAumoqnZV6JBygDVGK
         V1wKhpj5uQ59xGPXkxdooH7m4ikbJa5lh684wkvlyf7To+jKIdkqvhFX8Rzuq0A/aUpH
         vHwRFD8WvwmHXWdRs1wQYIxRFUgugvroVBMilZAOaze3DtcqmThVej5QF5pyav+gxywI
         9LTr9tXTcp8UwlJAzoyvrnjxYfnr8hIuqmK8FXqK8x1jCcj9dLMopIaPsvR2HUv+5FDs
         zmXYhwjQYnTvQynnLZ3KyuIBkHoTYAm9ro4Kasm9OcROSaIBhhy92CyWcgrsiXCAVLgT
         CBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681614220; x=1684206220;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Para9K873EeJhpyq7CI7rxs9jB2w3YqWXnEBSZEC70=;
        b=i5pKwYAfFPCBe2PO0wkYcgvpsMZhMtdsLYKaJRMNooCemV0Bi1+wk/KtURP5wka90C
         6LW/8qqVVjdqLdvfBgGSSLhsWGvUYFH4bVeT5o+QbX2Z4E2c8BjoLRkgp/lBbCOUtdIL
         2WkiSH0JmfMnScRM8h2099/NnqMtBO/CLtwckcjIIPUyIqHZaFoS0LuDuxZjQ/gjWXXO
         SzLd4Gdpg7N0vFiiiCa9DSwqCjHHNC4ax6/eNpdgxp+EYM6yBsgznxPq9cCBHE1QUUUm
         x0/m9ywF8Kry2XRYVOlL9LGJpPM+4k0uG90v087AIukcAyr0IM5xhFz7ClYi/pf5TynS
         VWWw==
X-Gm-Message-State: AAQBX9cvCDDyW1IwyNtCLqP8fEniBLCAcGMqndqM8HqPNW+TkZmeA7Rt
        l3bZECHjCHqjh0jF1YRTD6gowlCsaQM=
X-Google-Smtp-Source: AKy350bDM8pTraGZpErCvo5iRlJ4GRbxDA7YDQl2Mh8E19H7GYiqc3h80LBQNGrkgc5UaQQwiapXPA==
X-Received: by 2002:a05:600c:2152:b0:3f1:6581:1acc with SMTP id v18-20020a05600c215200b003f165811accmr3073983wml.38.1681614220661;
        Sat, 15 Apr 2023 20:03:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g15-20020a05600c4ecf00b003edc4788fa0sm11961956wmq.2.2023.04.15.20.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 20:03:40 -0700 (PDT)
Message-Id: <c6d585736610120baf20be804238bd38a5f690d4.1681614206.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 16 Apr 2023 03:03:22 +0000
Subject: [PATCH 20/23] commit.h: reduce unnecessary includes
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
 add-interactive.c    |  1 +
 archive.c            |  2 ++
 bloom.c              |  1 +
 builtin/diff-tree.c  |  1 +
 builtin/diff.c       |  1 +
 builtin/gc.c         |  1 +
 builtin/log.c        |  1 +
 builtin/merge-tree.c |  1 +
 combine-diff.c       |  1 +
 commit-graph.c       |  1 +
 commit.c             |  1 +
 commit.h             | 11 ++++-------
 dir.c                |  1 +
 fetch-pack.c         |  1 +
 fsck.c               |  1 +
 gpg-interface.c      |  1 +
 grep.c               |  1 +
 http-push.c          |  1 +
 log-tree.c           |  1 +
 merge-ort-wrappers.c |  1 +
 merge.c              |  1 +
 notes-cache.c        |  1 +
 notes-utils.c        |  1 +
 object-name.c        |  1 +
 pack-bitmap-write.c  |  1 +
 parse-options-cb.c   |  1 +
 parse-options.c      |  1 +
 read-cache.c         |  1 +
 ref-filter.c         |  1 +
 reflog.c             |  1 +
 refs/debug.c         |  1 +
 refspec.c            |  1 +
 revision.h           |  1 +
 send-pack.c          |  1 +
 wt-status.c          |  1 +
 35 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 757a9929d41..de877ca0525 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -12,6 +12,7 @@
 #include "dir.h"
 #include "run-command.h"
 #include "prompt.h"
+#include "tree.h"
 
 static void init_color(struct repository *r, struct add_i_state *s,
 		       const char *section_and_slot, char *dst,
diff --git a/archive.c b/archive.c
index ab8966d73a5..6226e16b25e 100644
--- a/archive.c
+++ b/archive.c
@@ -6,10 +6,12 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
+#include "pretty.h"
 #include "setup.h"
 #include "refs.h"
 #include "object-store.h"
 #include "commit.h"
+#include "tree.h"
 #include "tree-walk.h"
 #include "attr.h"
 #include "archive.h"
diff --git a/bloom.c b/bloom.c
index d0730525da5..aef6b5fea2d 100644
--- a/bloom.c
+++ b/bloom.c
@@ -6,6 +6,7 @@
 #include "hashmap.h"
 #include "commit-graph.h"
 #include "commit.h"
+#include "commit-slab.h"
 
 define_commit_slab(bloom_filter_slab, struct bloom_filter);
 
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 385c2d0230c..0b02c62b85e 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -9,6 +9,7 @@
 #include "builtin.h"
 #include "submodule.h"
 #include "repository.h"
+#include "tree.h"
 
 static struct rev_info log_tree_opt;
 
diff --git a/builtin/diff.c b/builtin/diff.c
index 8f386535d61..457dee14457 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -22,6 +22,7 @@
 #include "setup.h"
 #include "submodule.h"
 #include "oid-array.h"
+#include "tree.h"
 
 #define DIFF_NO_INDEX_EXPLICIT 1
 #define DIFF_NO_INDEX_IMPLICIT 2
diff --git a/builtin/gc.c b/builtin/gc.c
index b95154fba16..d11712b1444 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -12,6 +12,7 @@
 
 #include "builtin.h"
 #include "abspath.h"
+#include "date.h"
 #include "environment.h"
 #include "hex.h"
 #include "repository.h"
diff --git a/builtin/log.c b/builtin/log.c
index 95de51921f8..137b84b31ef 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -44,6 +44,7 @@
 #include "commit-reach.h"
 #include "range-diff.h"
 #include "tmp-objdir.h"
+#include "tree.h"
 #include "write-or-die.h"
 
 #define MAIL_DEFAULT_WRAP 72
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 6b9f006ec19..aa8040c2a6a 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -16,6 +16,7 @@
 #include "exec-cmd.h"
 #include "merge-blobs.h"
 #include "quote.h"
+#include "tree.h"
 
 static int line_termination = '\n';
 
diff --git a/combine-diff.c b/combine-diff.c
index f8d61965776..1e3cd7fb170 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -13,6 +13,7 @@
 #include "xdiff/xmacros.h"
 #include "log-tree.h"
 #include "refs.h"
+#include "tree.h"
 #include "userdiff.h"
 #include "oid-array.h"
 #include "revision.h"
diff --git a/commit-graph.c b/commit-graph.c
index 0c4f2266445..6f612f368ba 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -23,6 +23,7 @@
 #include "shallow.h"
 #include "json-writer.h"
 #include "trace2.h"
+#include "tree.h"
 #include "chunk-format.h"
 #include "wrapper.h"
 
diff --git a/commit.c b/commit.c
index 878b4473e4c..10676165a1d 100644
--- a/commit.c
+++ b/commit.c
@@ -26,6 +26,7 @@
 #include "run-command.h"
 #include "setup.h"
 #include "shallow.h"
+#include "tree.h"
 #include "hook.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
diff --git a/commit.h b/commit.h
index 69b2f376e9d..28928833c54 100644
--- a/commit.h
+++ b/commit.h
@@ -2,13 +2,10 @@
 #define COMMIT_H
 
 #include "object.h"
-#include "tree.h"
-#include "strbuf.h"
-#include "decorate.h"
-#include "gpg-interface.h"
-#include "string-list.h"
-#include "pretty.h"
-#include "commit-slab.h"
+
+struct signature_check;
+struct strbuf;
+struct tree;
 
 #define COMMIT_NOT_FROM_GRAPH 0xFFFFFFFF
 #define GENERATION_NUMBER_INFINITY ((1ULL << 63) - 1)
diff --git a/dir.c b/dir.c
index ed262fa6e43..a7469df3ac7 100644
--- a/dir.c
+++ b/dir.c
@@ -27,6 +27,7 @@
 #include "submodule-config.h"
 #include "symlinks.h"
 #include "trace2.h"
+#include "tree.h"
 #include "wrapper.h"
 
 /*
diff --git a/fetch-pack.c b/fetch-pack.c
index 677102465a1..a9745bd9faf 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -2,6 +2,7 @@
 #include "alloc.h"
 #include "repository.h"
 #include "config.h"
+#include "date.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/fsck.c b/fsck.c
index adbe8bf59e7..3261ef9ec28 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "alloc.h"
+#include "date.h"
 #include "hex.h"
 #include "object-store.h"
 #include "repository.h"
diff --git a/gpg-interface.c b/gpg-interface.c
index 8615dcd4b4b..49d72c2066b 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "commit.h"
 #include "config.h"
+#include "date.h"
 #include "gettext.h"
 #include "run-command.h"
 #include "strbuf.h"
diff --git a/grep.c b/grep.c
index d144b374894..e620e375b1d 100644
--- a/grep.c
+++ b/grep.c
@@ -4,6 +4,7 @@
 #include "grep.h"
 #include "hex.h"
 #include "object-store.h"
+#include "pretty.h"
 #include "userdiff.h"
 #include "xdiff-interface.h"
 #include "diff.h"
diff --git a/http-push.c b/http-push.c
index 637a4e91f7a..3f184986362 100644
--- a/http-push.c
+++ b/http-push.c
@@ -15,6 +15,7 @@
 #include "setup.h"
 #include "sigchain.h"
 #include "strvec.h"
+#include "tree.h"
 #include "packfile.h"
 #include "object-store.h"
 #include "commit-reach.h"
diff --git a/log-tree.c b/log-tree.c
index b5cf3d8439c..8861900b592 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -24,6 +24,7 @@
 #include "help.h"
 #include "range-diff.h"
 #include "strmap.h"
+#include "tree.h"
 #include "write-or-die.h"
 
 static struct decoration name_decoration = { "object names" };
diff --git a/merge-ort-wrappers.c b/merge-ort-wrappers.c
index 2d1e8aa7ee7..ad2bb676e13 100644
--- a/merge-ort-wrappers.c
+++ b/merge-ort-wrappers.c
@@ -3,6 +3,7 @@
 #include "merge-ort.h"
 #include "merge-ort-wrappers.h"
 #include "repository.h"
+#include "tree.h"
 
 #include "commit.h"
 
diff --git a/merge.c b/merge.c
index da7fa652c27..10aaec3a6c1 100644
--- a/merge.c
+++ b/merge.c
@@ -7,6 +7,7 @@
 #include "commit.h"
 #include "run-command.h"
 #include "resolve-undo.h"
+#include "tree.h"
 #include "tree-walk.h"
 #include "unpack-trees.h"
 #include "dir.h"
diff --git a/notes-cache.c b/notes-cache.c
index fbcdfd0dfe5..14288caf98f 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "notes-cache.h"
 #include "object-store.h"
+#include "pretty.h"
 #include "repository.h"
 #include "commit.h"
 #include "refs.h"
diff --git a/notes-utils.c b/notes-utils.c
index cb88171b7bb..4a793eb347f 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -6,6 +6,7 @@
 #include "refs.h"
 #include "notes-utils.h"
 #include "repository.h"
+#include "strbuf.h"
 
 void create_notes_commit(struct repository *r,
 			 struct notes_tree *t,
diff --git a/object-name.c b/object-name.c
index 3cd5b327293..5ccbe854b60 100644
--- a/object-name.c
+++ b/object-name.c
@@ -15,6 +15,7 @@
 #include "dir.h"
 #include "oid-array.h"
 #include "packfile.h"
+#include "pretty.h"
 #include "object-store.h"
 #include "repository.h"
 #include "setup.h"
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index faf67c94d37..3d3fd380654 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -18,6 +18,7 @@
 #include "commit-reach.h"
 #include "prio-queue.h"
 #include "trace2.h"
+#include "tree.h"
 
 struct bitmapped_commit {
 	struct commit *commit;
diff --git a/parse-options-cb.c b/parse-options-cb.c
index 26a4c7d08a9..be81158f861 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -3,6 +3,7 @@
 #include "branch.h"
 #include "commit.h"
 #include "color.h"
+#include "date.h"
 #include "environment.h"
 #include "gettext.h"
 #include "object-name.h"
diff --git a/parse-options.c b/parse-options.c
index b6803647d0e..f8a155ee13b 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -5,6 +5,7 @@
 #include "commit.h"
 #include "color.h"
 #include "gettext.h"
+#include "strbuf.h"
 #include "utf8.h"
 
 static int disallow_abbreviated_options;
diff --git a/read-cache.c b/read-cache.c
index b3e2917ddc9..d64d93bc364 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -6,6 +6,7 @@
 #include "cache.h"
 #include "alloc.h"
 #include "config.h"
+#include "date.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "hex.h"
diff --git a/ref-filter.c b/ref-filter.c
index 594e66ad361..84eee904ba3 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2,6 +2,7 @@
 #include "alloc.h"
 #include "environment.h"
 #include "gettext.h"
+#include "gpg-interface.h"
 #include "hex.h"
 #include "parse-options.h"
 #include "refs.h"
diff --git a/reflog.c b/reflog.c
index 9c094430884..57dc7c0d051 100644
--- a/reflog.c
+++ b/reflog.c
@@ -4,6 +4,7 @@
 #include "reflog.h"
 #include "refs.h"
 #include "revision.h"
+#include "tree.h"
 #include "worktree.h"
 
 /* Remember to update object flag allocation in object.h */
diff --git a/refs/debug.c b/refs/debug.c
index adc34c836fc..6f11e6de46c 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "hex.h"
 #include "refs-internal.h"
+#include "string-list.h"
 #include "trace.h"
 
 static struct trace_key trace_refs = TRACE_KEY_INIT(REFS);
diff --git a/refspec.c b/refspec.c
index 68020ee84c6..2ddea205d10 100644
--- a/refspec.c
+++ b/refspec.c
@@ -6,6 +6,7 @@
 #include "refs.h"
 #include "refspec.h"
 #include "repository.h"
+#include "strbuf.h"
 
 static struct refspec_item s_tag_refspec = {
 	.force = 0,
diff --git a/revision.h b/revision.h
index 742700504a7..6630bb2eae2 100644
--- a/revision.h
+++ b/revision.h
@@ -8,6 +8,7 @@
 #include "pretty.h"
 #include "diff.h"
 #include "commit-slab-decl.h"
+#include "decorate.h"
 #include "ident.h"
 #include "list-objects-filter-options.h"
 
diff --git a/send-pack.c b/send-pack.c
index 351037b07bc..e68da24cc52 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "config.h"
 #include "commit.h"
+#include "date.h"
 #include "gettext.h"
 #include "hex.h"
 #include "refs.h"
diff --git a/wt-status.c b/wt-status.c
index 97b9c1c0359..068b76ef6d9 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -22,6 +22,7 @@
 #include "strbuf.h"
 #include "trace.h"
 #include "trace2.h"
+#include "tree.h"
 #include "utf8.h"
 #include "worktree.h"
 #include "lockfile.h"
-- 
gitgitgadget


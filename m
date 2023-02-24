Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853F4C61DA4
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 00:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjBXAKY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 19:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjBXAKA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 19:10:00 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2CD1CF7D
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 16:09:49 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id bt28so5664608wrb.8
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 16:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26HEs082WRfvhiJBRDGp6nqymSNMKFyAoWJVRYFdNIk=;
        b=mlc7/B+QkCjhTrqWFsK1WGPnjR7+rO+5H10cci/OMFxO3lkL7ptW7wLCk8nvP/Q1FA
         YYfVge03g6x/SKTv3GrkU7E9NoImOGhHVUjZeO4Y9KLGrv/Iao0R2eSjpuV3i/E5Bk2S
         7wV1CuqqVkMamp5G90mCD54CDMf8v/VJp1cnGMr96Ruiw/97abhsLzibrk0s0WpE+6LF
         RqfS/uAj77nLHmfMHpMP3Hdu9ZUHCmXEHVHoPmyREPPkHj0e+YF3mLilEJ1HSJ77v2OT
         WZHwmyXvTx1EBWCJTy6r0hagarqRpefWwesX2Nes322OExFcMytMziLQs+Dj3i5uqI6u
         trTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=26HEs082WRfvhiJBRDGp6nqymSNMKFyAoWJVRYFdNIk=;
        b=UyiolR5aRDZAjSuZ2SNq/8J0ERLek3vwP48yKXD1ZIpAXqYK2gchKPh0JuHgTIi72X
         NPOFGRuRfZG4BBqx6/e36s97+LaRsqYDxnxHBbsCFA/KBmW0t1nEK+eM+qjAVZbI4vPn
         yBv0fAsX/t9ZVBAfzImdBYDC/5qwSIBYFwfuXLdNbKv7WBRjpUx83sG6syZEK/zSQcTf
         ym49yIRQ54j2Yl8wVZ8lcZmgAugxN9UlUMoJLnqB8SpLKd7oUxxI2kA++SclbhV4uyEz
         IwSvIQV+Tk8vIxbyh9n4XUTIGKo88+RI1Nblrq4c17YBax1dAqELcZaz8P3q/pO1epYm
         cpDw==
X-Gm-Message-State: AO0yUKXOpeK04KzOu5DmCdo+bF33ld063EVmPCXNFCyHq41haQo94bXq
        N+hvBJObyzxJY6raIQFbVY4Tha5sA50=
X-Google-Smtp-Source: AK7set+3Y3lHW46X+8pTftp67Jt133fX4WaSBjQeyujtZilQJ64cpJP5Ok87J6NFVURpJ63/jVNYxw==
X-Received: by 2002:a5d:5253:0:b0:2c5:594b:10d6 with SMTP id k19-20020a5d5253000000b002c5594b10d6mr9654136wrc.29.1677197387256;
        Thu, 23 Feb 2023 16:09:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q15-20020a05600000cf00b002c559843748sm12606416wrx.10.2023.02.23.16.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 16:09:46 -0800 (PST)
Message-Id: <c23dd309ce3c391754c36c497c0a6a66cb38a032.1677197377.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1485.v2.git.1677197376.gitgitgadget@gmail.com>
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
        <pull.1485.v2.git.1677197376.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Feb 2023 00:09:27 +0000
Subject: [PATCH v2 08/17] cache.h: remove dependence on hex.h; make other
 files include it explicitly
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

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 add-interactive.c                    | 1 +
 apply.c                              | 1 +
 archive-tar.c                        | 1 +
 archive-zip.c                        | 1 +
 archive.c                            | 1 +
 bisect.c                             | 1 +
 blame.c                              | 1 +
 branch.c                             | 1 +
 builtin/am.c                         | 1 +
 builtin/bisect.c                     | 1 +
 builtin/blame.c                      | 1 +
 builtin/cat-file.c                   | 1 +
 builtin/checkout.c                   | 1 +
 builtin/clone.c                      | 1 +
 builtin/commit-graph.c               | 1 +
 builtin/commit-tree.c                | 1 +
 builtin/describe.c                   | 1 +
 builtin/diff-tree.c                  | 1 +
 builtin/difftool.c                   | 1 +
 builtin/fast-export.c                | 1 +
 builtin/fast-import.c                | 1 +
 builtin/fetch-pack.c                 | 1 +
 builtin/fetch.c                      | 1 +
 builtin/fsck.c                       | 1 +
 builtin/gc.c                         | 1 +
 builtin/grep.c                       | 1 +
 builtin/hash-object.c                | 1 +
 builtin/index-pack.c                 | 1 +
 builtin/log.c                        | 1 +
 builtin/ls-remote.c                  | 1 +
 builtin/ls-tree.c                    | 1 +
 builtin/merge-base.c                 | 1 +
 builtin/merge-index.c                | 1 +
 builtin/merge-tree.c                 | 1 +
 builtin/merge.c                      | 1 +
 builtin/mktag.c                      | 1 +
 builtin/mktree.c                     | 1 +
 builtin/name-rev.c                   | 1 +
 builtin/notes.c                      | 1 +
 builtin/pack-objects.c               | 1 +
 builtin/pack-redundant.c             | 1 +
 builtin/patch-id.c                   | 1 +
 builtin/prune.c                      | 1 +
 builtin/pull.c                       | 1 +
 builtin/read-tree.c                  | 1 +
 builtin/rebase.c                     | 1 +
 builtin/receive-pack.c               | 1 +
 builtin/repack.c                     | 1 +
 builtin/replace.c                    | 1 +
 builtin/reset.c                      | 1 +
 builtin/rev-list.c                   | 1 +
 builtin/rev-parse.c                  | 1 +
 builtin/send-pack.c                  | 1 +
 builtin/show-branch.c                | 1 +
 builtin/show-index.c                 | 1 +
 builtin/show-ref.c                   | 1 +
 builtin/stash.c                      | 1 +
 builtin/submodule--helper.c          | 1 +
 builtin/tag.c                        | 1 +
 builtin/unpack-file.c                | 1 +
 builtin/unpack-objects.c             | 1 +
 builtin/update-index.c               | 1 +
 builtin/worktree.c                   | 1 +
 builtin/write-tree.c                 | 1 +
 bulk-checkin.c                       | 1 +
 bundle.c                             | 1 +
 cache-tree.c                         | 1 +
 cache.h                              | 1 -
 color.c                              | 1 +
 combine-diff.c                       | 1 +
 commit-graph.c                       | 1 +
 commit-reach.c                       | 1 +
 commit.c                             | 1 +
 compat/fsmonitor/fsm-ipc-darwin.c    | 1 +
 connect.c                            | 1 +
 connected.c                          | 1 +
 convert.c                            | 1 +
 delta-islands.c                      | 1 +
 diagnose.c                           | 1 +
 diff-lib.c                           | 1 +
 diff.c                               | 1 +
 entry.c                              | 1 +
 fetch-pack.c                         | 1 +
 fmt-merge-msg.c                      | 1 +
 fsck.c                               | 1 +
 grep.c                               | 1 +
 http-backend.c                       | 1 +
 http-fetch.c                         | 1 +
 http-push.c                          | 1 +
 http-walker.c                        | 1 +
 http.c                               | 1 +
 line-log.c                           | 1 +
 list-objects-filter.c                | 1 +
 list-objects.c                       | 1 +
 log-tree.c                           | 1 +
 ls-refs.c                            | 1 +
 match-trees.c                        | 1 +
 merge-ort.c                          | 1 +
 merge-recursive.c                    | 1 +
 merge.c                              | 1 +
 midx.c                               | 1 +
 negotiator/skipping.c                | 1 +
 notes-merge.c                        | 1 +
 notes.c                              | 1 +
 object-file.c                        | 1 +
 object-name.c                        | 1 +
 object.c                             | 1 +
 pack-bitmap-write.c                  | 1 +
 pack-bitmap.c                        | 1 +
 pack-check.c                         | 1 +
 pack-write.c                         | 1 +
 packfile.c                           | 1 +
 parallel-checkout.c                  | 1 +
 patch-ids.c                          | 1 +
 path.c                               | 1 +
 pkt-line.c                           | 1 +
 pretty.c                             | 1 +
 promisor-remote.c                    | 1 +
 protocol-caps.c                      | 1 +
 reachable.c                          | 1 +
 read-cache.c                         | 1 +
 ref-filter.c                         | 1 +
 refs.c                               | 1 +
 refs/debug.c                         | 1 +
 refs/files-backend.c                 | 1 +
 refs/packed-backend.c                | 1 +
 refspec.c                            | 1 +
 remote-curl.c                        | 1 +
 remote.c                             | 1 +
 replace-object.c                     | 1 +
 rerere.c                             | 1 +
 reset.c                              | 1 +
 revision.c                           | 1 +
 send-pack.c                          | 1 +
 sequencer.c                          | 1 +
 server-info.c                        | 1 +
 sha1dc_git.c                         | 1 +
 shallow.c                            | 1 +
 strbuf.c                             | 1 +
 strvec.c                             | 1 +
 submodule-config.c                   | 1 +
 submodule.c                          | 1 +
 t/helper/test-bloom.c                | 1 +
 t/helper/test-cache-tree.c           | 1 +
 t/helper/test-dump-cache-tree.c      | 1 +
 t/helper/test-dump-split-index.c     | 1 +
 t/helper/test-dump-untracked-cache.c | 1 +
 t/helper/test-fast-rebase.c          | 1 +
 t/helper/test-hash.c                 | 1 +
 t/helper/test-match-trees.c          | 1 +
 t/helper/test-oid-array.c            | 1 +
 t/helper/test-oidmap.c               | 1 +
 t/helper/test-oidtree.c              | 1 +
 t/helper/test-pack-mtimes.c          | 1 +
 t/helper/test-partial-clone.c        | 1 +
 t/helper/test-proc-receive.c         | 1 +
 t/helper/test-reach.c                | 1 +
 t/helper/test-read-midx.c            | 1 +
 t/helper/test-ref-store.c            | 1 +
 t/helper/test-repository.c           | 1 +
 tag.c                                | 1 +
 trace2/tr2_sid.c                     | 1 +
 transport-helper.c                   | 1 +
 transport.c                          | 1 +
 tree-walk.c                          | 1 +
 tree.c                               | 1 +
 unpack-trees.c                       | 1 +
 upload-pack.c                        | 1 +
 url.c                                | 1 +
 urlmatch.c                           | 1 +
 walker.c                             | 1 +
 wt-status.c                          | 1 +
 xdiff-interface.c                    | 1 +
 173 files changed, 172 insertions(+), 1 deletion(-)

diff --git a/add-interactive.c b/add-interactive.c
index 00a0f6f96f3..ae25ec50bce 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -3,6 +3,7 @@
 #include "color.h"
 #include "config.h"
 #include "diffcore.h"
+#include "hex.h"
 #include "revision.h"
 #include "refs.h"
 #include "string-list.h"
diff --git a/apply.c b/apply.c
index 7f12ebf04c5..8776ab939ad 100644
--- a/apply.c
+++ b/apply.c
@@ -15,6 +15,7 @@
 #include "delta.h"
 #include "diff.h"
 #include "dir.h"
+#include "hex.h"
 #include "xdiff-interface.h"
 #include "ll-merge.h"
 #include "lockfile.h"
diff --git a/archive-tar.c b/archive-tar.c
index 9406f03e804..ee27fa0b39b 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -4,6 +4,7 @@
 #include "git-compat-util.h"
 #include "alloc.h"
 #include "config.h"
+#include "hex.h"
 #include "tar.h"
 #include "archive.h"
 #include "object-store.h"
diff --git a/archive-zip.c b/archive-zip.c
index 0456f1ebf15..c5d1f72eb80 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -4,6 +4,7 @@
 #include "cache.h"
 #include "config.h"
 #include "archive.h"
+#include "hex.h"
 #include "streaming.h"
 #include "utf8.h"
 #include "object-store.h"
diff --git a/archive.c b/archive.c
index 35719e5e367..c7869ae906f 100644
--- a/archive.c
+++ b/archive.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "alloc.h"
 #include "config.h"
+#include "hex.h"
 #include "refs.h"
 #include "object-store.h"
 #include "commit.h"
diff --git a/bisect.c b/bisect.c
index ef5ee5a6436..1409150c5c3 100644
--- a/bisect.c
+++ b/bisect.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "commit.h"
 #include "diff.h"
+#include "hex.h"
 #include "revision.h"
 #include "refs.h"
 #include "list-objects.h"
diff --git a/blame.c b/blame.c
index 8bfeaa1c63a..e45d8a3bf92 100644
--- a/blame.c
+++ b/blame.c
@@ -5,6 +5,7 @@
 #include "mergesort.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "hex.h"
 #include "tag.h"
 #include "blame.h"
 #include "alloc.h"
diff --git a/branch.c b/branch.c
index e5614b53b36..5aaf073dce1 100644
--- a/branch.c
+++ b/branch.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "config.h"
 #include "branch.h"
+#include "hex.h"
 #include "refs.h"
 #include "refspec.h"
 #include "remote.h"
diff --git a/builtin/am.c b/builtin/am.c
index e0848ddadfe..3b5ea50cc56 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -8,6 +8,7 @@
 #include "config.h"
 #include "builtin.h"
 #include "exec-cmd.h"
+#include "hex.h"
 #include "parse-options.h"
 #include "dir.h"
 #include "run-command.h"
diff --git a/builtin/bisect.c b/builtin/bisect.c
index 73017402671..e8ee4a4dc8d 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "hex.h"
 #include "parse-options.h"
 #include "bisect.h"
 #include "refs.h"
diff --git a/builtin/blame.c b/builtin/blame.c
index 4d1609c9ac0..fdd9f0c0fc7 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -10,6 +10,7 @@
 #include "config.h"
 #include "color.h"
 #include "builtin.h"
+#include "hex.h"
 #include "repository.h"
 #include "commit.h"
 #include "diff.h"
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 5b8be7cb63b..3040016e27a 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -9,6 +9,7 @@
 #include "config.h"
 #include "builtin.h"
 #include "diff.h"
+#include "hex.h"
 #include "parse-options.h"
 #include "userdiff.h"
 #include "streaming.h"
diff --git a/builtin/checkout.c b/builtin/checkout.c
index a5155cf55c1..21a4335abb0 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -9,6 +9,7 @@
 #include "config.h"
 #include "diff.h"
 #include "dir.h"
+#include "hex.h"
 #include "hook.h"
 #include "ll-merge.h"
 #include "lockfile.h"
diff --git a/builtin/clone.c b/builtin/clone.c
index 65b5b7db6de..462c286274c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -11,6 +11,7 @@
 #define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "config.h"
+#include "hex.h"
 #include "lockfile.h"
 #include "parse-options.h"
 #include "fetch-pack.h"
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 93704f95a9d..6dc83dc51b3 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "config.h"
 #include "dir.h"
+#include "hex.h"
 #include "lockfile.h"
 #include "parse-options.h"
 #include "repository.h"
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index cc8d584be2f..fefeed5d4bd 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -5,6 +5,7 @@
  */
 #include "cache.h"
 #include "config.h"
+#include "hex.h"
 #include "object-store.h"
 #include "repository.h"
 #include "commit.h"
diff --git a/builtin/describe.c b/builtin/describe.c
index eea1e330c00..5b5930f5c8c 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -1,6 +1,7 @@
 #define USE_THE_INDEX_VARIABLE
 #include "cache.h"
 #include "config.h"
+#include "hex.h"
 #include "lockfile.h"
 #include "commit.h"
 #include "tag.h"
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 25b853b85ca..a393efa4f08 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -3,6 +3,7 @@
 #include "config.h"
 #include "diff.h"
 #include "commit.h"
+#include "hex.h"
 #include "log-tree.h"
 #include "builtin.h"
 #include "submodule.h"
diff --git a/builtin/difftool.c b/builtin/difftool.c
index dbbfb19f192..01681d0fb88 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -17,6 +17,7 @@
 #include "builtin.h"
 #include "run-command.h"
 #include "exec-cmd.h"
+#include "hex.h"
 #include "parse-options.h"
 #include "strvec.h"
 #include "strbuf.h"
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 39a890fc005..78493c6d2bf 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -6,6 +6,7 @@
 #include "builtin.h"
 #include "cache.h"
 #include "config.h"
+#include "hex.h"
 #include "refs.h"
 #include "refspec.h"
 #include "object-store.h"
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 7134683ab93..160e2eedb77 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "hex.h"
 #include "repository.h"
 #include "config.h"
 #include "lockfile.h"
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 113f22c09dd..702c9a3397e 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "alloc.h"
+#include "hex.h"
 #include "pkt-line.h"
 #include "fetch-pack.h"
 #include "remote.h"
diff --git a/builtin/fetch.c b/builtin/fetch.c
index a21ce89312d..a77099ba885 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -3,6 +3,7 @@
  */
 #include "cache.h"
 #include "config.h"
+#include "hex.h"
 #include "repository.h"
 #include "refs.h"
 #include "refspec.h"
diff --git a/builtin/fsck.c b/builtin/fsck.c
index d207bd909b4..af0fab660dc 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -1,6 +1,7 @@
 #define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "cache.h"
+#include "hex.h"
 #include "repository.h"
 #include "config.h"
 #include "commit.h"
diff --git a/builtin/gc.c b/builtin/gc.c
index 02455fdcd73..67c7fe8a6ea 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -11,6 +11,7 @@
  */
 
 #include "builtin.h"
+#include "hex.h"
 #include "repository.h"
 #include "config.h"
 #include "tempfile.h"
diff --git a/builtin/grep.c b/builtin/grep.c
index a08e5841ddb..c590fcb19dd 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -5,6 +5,7 @@
  */
 #include "cache.h"
 #include "alloc.h"
+#include "hex.h"
 #include "repository.h"
 #include "config.h"
 #include "blob.h"
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 44db83f07fd..1848768b97c 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -6,6 +6,7 @@
  */
 #include "builtin.h"
 #include "config.h"
+#include "hex.h"
 #include "object-store.h"
 #include "blob.h"
 #include "quote.h"
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 7e4b69f9a3e..21c0e109dd2 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -2,6 +2,7 @@
 #include "alloc.h"
 #include "config.h"
 #include "delta.h"
+#include "hex.h"
 #include "pack.h"
 #include "csum-file.h"
 #include "blob.h"
diff --git a/builtin/log.c b/builtin/log.c
index 85540963d95..99489bcb644 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -7,6 +7,7 @@
 #include "git-compat-util.h"
 #include "alloc.h"
 #include "config.h"
+#include "hex.h"
 #include "refs.h"
 #include "object-store.h"
 #include "color.h"
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 65161773489..2dfbd8ed9b9 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "hex.h"
 #include "transport.h"
 #include "ref-filter.h"
 #include "remote.h"
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 8cc8c995df9..64d8e54318c 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -5,6 +5,7 @@
  */
 #include "cache.h"
 #include "config.h"
+#include "hex.h"
 #include "object-store.h"
 #include "blob.h"
 #include "tree.h"
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 6f3941f2a49..be8f3b221c9 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "config.h"
 #include "commit.h"
+#include "hex.h"
 #include "refs.h"
 #include "diff.h"
 #include "revision.h"
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 452f833ac46..c875f5d37ee 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -1,5 +1,6 @@
 #define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
+#include "hex.h"
 #include "run-command.h"
 
 static const char *pgm;
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 828dc81c426..e7825181648 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -3,6 +3,7 @@
 #include "tree-walk.h"
 #include "xdiff-interface.h"
 #include "help.h"
+#include "hex.h"
 #include "commit.h"
 #include "commit-reach.h"
 #include "merge-ort.h"
diff --git a/builtin/merge.c b/builtin/merge.c
index 716a23f880d..7347b738e50 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -10,6 +10,7 @@
 #include "cache.h"
 #include "alloc.h"
 #include "config.h"
+#include "hex.h"
 #include "parse-options.h"
 #include "builtin.h"
 #include "lockfile.h"
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 5d22909122d..42c2457c705 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "hex.h"
 #include "parse-options.h"
 #include "tag.h"
 #include "replace-object.h"
diff --git a/builtin/mktree.c b/builtin/mktree.c
index ec721ffb947..848c7b47476 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -5,6 +5,7 @@
  */
 #include "builtin.h"
 #include "alloc.h"
+#include "hex.h"
 #include "quote.h"
 #include "tree.h"
 #include "parse-options.h"
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 29752e7afe6..723ba616a88 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "alloc.h"
+#include "hex.h"
 #include "repository.h"
 #include "config.h"
 #include "commit.h"
diff --git a/builtin/notes.c b/builtin/notes.c
index 80d9dfd25ca..bba4c2e39f8 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -10,6 +10,7 @@
 #include "cache.h"
 #include "config.h"
 #include "builtin.h"
+#include "hex.h"
 #include "notes.h"
 #include "object-store.h"
 #include "repository.h"
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 72c33fd739a..2b5e85988c9 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "alloc.h"
+#include "hex.h"
 #include "repository.h"
 #include "config.h"
 #include "attr.h"
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index ecd49ca268f..82115c5808c 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -7,6 +7,7 @@
 */
 
 #include "builtin.h"
+#include "hex.h"
 #include "repository.h"
 #include "packfile.h"
 #include "object-store.h"
diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index f840fbf1c7e..338b15cd7b0 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -2,6 +2,7 @@
 #include "builtin.h"
 #include "config.h"
 #include "diff.h"
+#include "hex.h"
 #include "parse-options.h"
 
 static void flush_current_id(int patchlen, struct object_id *id, struct object_id *result)
diff --git a/builtin/prune.c b/builtin/prune.c
index 27192201086..db767b7a8fa 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "commit.h"
 #include "diff.h"
+#include "hex.h"
 #include "revision.h"
 #include "builtin.h"
 #include "reachable.h"
diff --git a/builtin/pull.c b/builtin/pull.c
index 1ab4de0005d..963a47f0b82 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -9,6 +9,7 @@
 #include "cache.h"
 #include "config.h"
 #include "builtin.h"
+#include "hex.h"
 #include "parse-options.h"
 #include "exec-cmd.h"
 #include "run-command.h"
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 3ce75417833..018fa9cde2f 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -7,6 +7,7 @@
 #define USE_THE_INDEX_VARIABLE
 #include "cache.h"
 #include "config.h"
+#include "hex.h"
 #include "lockfile.h"
 #include "object.h"
 #include "tree.h"
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 6635f10d529..ef8ce2f72cd 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -6,6 +6,7 @@
 
 #define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
+#include "hex.h"
 #include "run-command.h"
 #include "exec-cmd.h"
 #include "strvec.h"
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index cd5c7a28eff..3d2b4c8b4fc 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "repository.h"
 #include "config.h"
+#include "hex.h"
 #include "lockfile.h"
 #include "pack.h"
 #include "refs.h"
diff --git a/builtin/repack.c b/builtin/repack.c
index 545b368168f..966430a465f 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -2,6 +2,7 @@
 #include "alloc.h"
 #include "config.h"
 #include "dir.h"
+#include "hex.h"
 #include "parse-options.h"
 #include "run-command.h"
 #include "sigchain.h"
diff --git a/builtin/replace.c b/builtin/replace.c
index a29e911d309..cdcb39f737c 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -11,6 +11,7 @@
 #include "cache.h"
 #include "config.h"
 #include "builtin.h"
+#include "hex.h"
 #include "refs.h"
 #include "parse-options.h"
 #include "run-command.h"
diff --git a/builtin/reset.c b/builtin/reset.c
index 0697fa89de2..58f567afd3e 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -10,6 +10,7 @@
 #define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "config.h"
+#include "hex.h"
 #include "lockfile.h"
 #include "tag.h"
 #include "object.h"
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index d42db0b0cc9..e4c9b747625 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "commit.h"
 #include "diff.h"
+#include "hex.h"
 #include "revision.h"
 #include "list-objects.h"
 #include "list-objects-filter.h"
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index fd4f59ff2b9..e1fa9c6348c 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -8,6 +8,7 @@
 #include "alloc.h"
 #include "config.h"
 #include "commit.h"
+#include "hex.h"
 #include "refs.h"
 #include "quote.h"
 #include "builtin.h"
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 4c5d125fa0a..127ced435dc 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "config.h"
 #include "commit.h"
+#include "hex.h"
 #include "refs.h"
 #include "pkt-line.h"
 #include "sideband.h"
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 358ac3e519a..8342b68aef7 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "config.h"
+#include "hex.h"
 #include "pretty.h"
 #include "refs.h"
 #include "builtin.h"
diff --git a/builtin/show-index.c b/builtin/show-index.c
index 0e0b9fb95bc..98ec40ddf46 100644
--- a/builtin/show-index.c
+++ b/builtin/show-index.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "hex.h"
 #include "pack.h"
 #include "parse-options.h"
 
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 3af6a53ee97..1f28d7fe4b9 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "cache.h"
 #include "config.h"
+#include "hex.h"
 #include "refs.h"
 #include "object-store.h"
 #include "object.h"
diff --git a/builtin/stash.c b/builtin/stash.c
index 3a4f9fd566d..6a12fed2713 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1,6 +1,7 @@
 #define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "config.h"
+#include "hex.h"
 #include "parse-options.h"
 #include "refs.h"
 #include "lockfile.h"
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 9edc785d8d2..2bbabbb28e3 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1,6 +1,7 @@
 #define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "alloc.h"
+#include "hex.h"
 #include "repository.h"
 #include "cache.h"
 #include "config.h"
diff --git a/builtin/tag.c b/builtin/tag.c
index d428c45dc8d..be094882d0f 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -9,6 +9,7 @@
 #include "cache.h"
 #include "config.h"
 #include "builtin.h"
+#include "hex.h"
 #include "refs.h"
 #include "object-store.h"
 #include "tag.h"
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index 88de32b7d7e..e9b105a5397 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "config.h"
+#include "hex.h"
 #include "object-store.h"
 
 static char *create_temp_file(struct object_id *oid)
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 43789b8ef29..e125b121883 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "bulk-checkin.h"
 #include "config.h"
+#include "hex.h"
 #include "object-store.h"
 #include "object.h"
 #include "delta.h"
diff --git a/builtin/update-index.c b/builtin/update-index.c
index bf38885d546..11dc1352716 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -7,6 +7,7 @@
 #include "cache.h"
 #include "bulk-checkin.h"
 #include "config.h"
+#include "hex.h"
 #include "lockfile.h"
 #include "quote.h"
 #include "cache-tree.h"
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 254283aa6f5..80d05e246d8 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -3,6 +3,7 @@
 #include "config.h"
 #include "builtin.h"
 #include "dir.h"
+#include "hex.h"
 #include "parse-options.h"
 #include "strvec.h"
 #include "branch.h"
diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index 078010315f0..7ad0d059453 100644
--- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -7,6 +7,7 @@
 #include "builtin.h"
 #include "cache.h"
 #include "config.h"
+#include "hex.h"
 #include "tree.h"
 #include "cache-tree.h"
 #include "parse-options.h"
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 62ed104c7e6..d64cd5c52d0 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -4,6 +4,7 @@
 #include "git-compat-util.h"
 #include "alloc.h"
 #include "bulk-checkin.h"
+#include "hex.h"
 #include "lockfile.h"
 #include "repository.h"
 #include "csum-file.h"
diff --git a/bundle.c b/bundle.c
index 6ab6cd7378d..99d7de97f6c 100644
--- a/bundle.c
+++ b/bundle.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "lockfile.h"
 #include "bundle.h"
+#include "hex.h"
 #include "object-store.h"
 #include "repository.h"
 #include "object.h"
diff --git a/cache-tree.c b/cache-tree.c
index 256f98c3c33..9d46ecef091 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "alloc.h"
+#include "hex.h"
 #include "lockfile.h"
 #include "tree.h"
 #include "tree-walk.h"
diff --git a/cache.h b/cache.h
index d0619ce2e63..0c631e75b55 100644
--- a/cache.h
+++ b/cache.h
@@ -13,7 +13,6 @@
 #include "string-list.h"
 #include "pack-revindex.h"
 #include "hash.h"
-#include "hex.h"
 #include "path.h"
 #include "oid-array.h"
 #include "repository.h"
diff --git a/color.c b/color.c
index f05d8a81d72..6b577ce0a75 100644
--- a/color.c
+++ b/color.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "config.h"
 #include "color.h"
+#include "hex.h"
 
 static int git_use_color_default = GIT_COLOR_AUTO;
 int color_stdout_is_tty = -1;
diff --git a/combine-diff.c b/combine-diff.c
index 1a39b5dde09..91051dc3258 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -4,6 +4,7 @@
 #include "blob.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "hex.h"
 #include "quote.h"
 #include "xdiff-interface.h"
 #include "xdiff/xmacros.h"
diff --git a/commit-graph.c b/commit-graph.c
index c11b59f28b3..5e6098ff356 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "config.h"
+#include "hex.h"
 #include "lockfile.h"
 #include "pack.h"
 #include "packfile.h"
diff --git a/commit-reach.c b/commit-reach.c
index 1f0ddc5c883..5ba822a7200 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -3,6 +3,7 @@
 #include "commit.h"
 #include "commit-graph.h"
 #include "decorate.h"
+#include "hex.h"
 #include "prio-queue.h"
 #include "tree.h"
 #include "ref-filter.h"
diff --git a/commit.c b/commit.c
index e433c33bb01..cb683a6df5d 100644
--- a/commit.c
+++ b/commit.c
@@ -2,6 +2,7 @@
 #include "tag.h"
 #include "commit.h"
 #include "commit-graph.h"
+#include "hex.h"
 #include "repository.h"
 #include "object-store.h"
 #include "pkt-line.h"
diff --git a/compat/fsmonitor/fsm-ipc-darwin.c b/compat/fsmonitor/fsm-ipc-darwin.c
index d67b0ee50d3..eb25123fa12 100644
--- a/compat/fsmonitor/fsm-ipc-darwin.c
+++ b/compat/fsmonitor/fsm-ipc-darwin.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "config.h"
+#include "hex.h"
 #include "strbuf.h"
 #include "fsmonitor.h"
 #include "fsmonitor-ipc.h"
diff --git a/connect.c b/connect.c
index 63e59641c0d..134069574a2 100644
--- a/connect.c
+++ b/connect.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "cache.h"
 #include "config.h"
+#include "hex.h"
 #include "pkt-line.h"
 #include "quote.h"
 #include "refs.h"
diff --git a/connected.c b/connected.c
index b90fd61790c..39cb1e1074d 100644
--- a/connected.c
+++ b/connected.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "hex.h"
 #include "object-store.h"
 #include "run-command.h"
 #include "sigchain.h"
diff --git a/convert.c b/convert.c
index a54d1690c08..349c7e4af15 100644
--- a/convert.c
+++ b/convert.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "config.h"
+#include "hex.h"
 #include "object-store.h"
 #include "attr.h"
 #include "run-command.h"
diff --git a/delta-islands.c b/delta-islands.c
index 1cfdc2cc040..c3785135fb9 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -4,6 +4,7 @@
 #include "object.h"
 #include "blob.h"
 #include "commit.h"
+#include "hex.h"
 #include "tag.h"
 #include "tree.h"
 #include "delta.h"
diff --git a/diagnose.c b/diagnose.c
index 8f265698966..4a8ee4e5cff 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -4,6 +4,7 @@
 #include "archive.h"
 #include "dir.h"
 #include "help.h"
+#include "hex.h"
 #include "strvec.h"
 #include "object-store.h"
 #include "packfile.h"
diff --git a/diff-lib.c b/diff-lib.c
index dec040c366c..70b3578b907 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -6,6 +6,7 @@
 #include "commit.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "hex.h"
 #include "revision.h"
 #include "cache-tree.h"
 #include "unpack-trees.h"
diff --git a/diff.c b/diff.c
index 3c3565995d9..ec911bdf18c 100644
--- a/diff.c
+++ b/diff.c
@@ -9,6 +9,7 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "delta.h"
+#include "hex.h"
 #include "xdiff-interface.h"
 #include "color.h"
 #include "attr.h"
diff --git a/entry.c b/entry.c
index 971ab268714..c97cfa833bb 100644
--- a/entry.c
+++ b/entry.c
@@ -2,6 +2,7 @@
 #include "blob.h"
 #include "object-store.h"
 #include "dir.h"
+#include "hex.h"
 #include "streaming.h"
 #include "submodule.h"
 #include "progress.h"
diff --git a/fetch-pack.c b/fetch-pack.c
index 271e2a6fbd6..95a992bcd43 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -2,6 +2,7 @@
 #include "alloc.h"
 #include "repository.h"
 #include "config.h"
+#include "hex.h"
 #include "lockfile.h"
 #include "refs.h"
 #include "pkt-line.h"
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index d4d6fd3d9d9..9609eb3cef1 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -5,6 +5,7 @@
 #include "object-store.h"
 #include "diff.h"
 #include "diff-merges.h"
+#include "hex.h"
 #include "revision.h"
 #include "tag.h"
 #include "string-list.h"
diff --git a/fsck.c b/fsck.c
index 20e1aac39a9..871c0a9a252 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "alloc.h"
+#include "hex.h"
 #include "object-store.h"
 #include "repository.h"
 #include "object.h"
diff --git a/grep.c b/grep.c
index cee44a78d04..68e9328dfd4 100644
--- a/grep.c
+++ b/grep.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "config.h"
 #include "grep.h"
+#include "hex.h"
 #include "object-store.h"
 #include "userdiff.h"
 #include "xdiff-interface.h"
diff --git a/http-backend.c b/http-backend.c
index d756d120dc9..45290031e00 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "alloc.h"
 #include "config.h"
+#include "hex.h"
 #include "repository.h"
 #include "refs.h"
 #include "pkt-line.h"
diff --git a/http-fetch.c b/http-fetch.c
index 258fec20682..8db35b9767d 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "config.h"
 #include "exec-cmd.h"
+#include "hex.h"
 #include "http.h"
 #include "walker.h"
 #include "strvec.h"
diff --git a/http-push.c b/http-push.c
index 7f71316456c..88aa045ecba 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "hex.h"
 #include "repository.h"
 #include "commit.h"
 #include "tag.h"
diff --git a/http-walker.c b/http-walker.c
index b8f0f98ae14..c3e902c40e6 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "repository.h"
 #include "commit.h"
+#include "hex.h"
 #include "walker.h"
 #include "http.h"
 #include "list.h"
diff --git a/http.c b/http.c
index c4b6ddef287..86b0745af90 100644
--- a/http.c
+++ b/http.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "git-curl-compat.h"
+#include "hex.h"
 #include "http.h"
 #include "config.h"
 #include "pack.h"
diff --git a/line-log.c b/line-log.c
index 4956eae748e..1bf89c9acc1 100644
--- a/line-log.c
+++ b/line-log.c
@@ -2,6 +2,7 @@
 #include "alloc.h"
 #include "line-range.h"
 #include "cache.h"
+#include "hex.h"
 #include "tag.h"
 #include "blob.h"
 #include "tree.h"
diff --git a/list-objects-filter.c b/list-objects-filter.c
index e40ea9b0a8f..5d7b3316608 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "alloc.h"
 #include "dir.h"
+#include "hex.h"
 #include "tag.h"
 #include "commit.h"
 #include "tree.h"
diff --git a/list-objects.c b/list-objects.c
index 7528fe1db2c..ab5745bbfe4 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "tag.h"
 #include "commit.h"
+#include "hex.h"
 #include "tree.h"
 #include "blob.h"
 #include "diff.h"
diff --git a/log-tree.c b/log-tree.c
index 1dd5fcbf7be..ee3dfb6b659 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -2,6 +2,7 @@
 #include "commit-reach.h"
 #include "config.h"
 #include "diff.h"
+#include "hex.h"
 #include "object-store.h"
 #include "repository.h"
 #include "tmp-objdir.h"
diff --git a/ls-refs.c b/ls-refs.c
index 697d4beb8de..f4c6b9b7621 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "hex.h"
 #include "repository.h"
 #include "refs.h"
 #include "remote.h"
diff --git a/match-trees.c b/match-trees.c
index 49398e599fe..c38dcbac7c6 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "hex.h"
 #include "tree.h"
 #include "tree-walk.h"
 #include "object-store.h"
diff --git a/merge-ort.c b/merge-ort.c
index d1611ca400a..4c5be8ed910 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -26,6 +26,7 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "dir.h"
+#include "hex.h"
 #include "entry.h"
 #include "ll-merge.h"
 #include "object-store.h"
diff --git a/merge-recursive.c b/merge-recursive.c
index ae469f8cc81..ee144676b76 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -18,6 +18,7 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "dir.h"
+#include "hex.h"
 #include "ll-merge.h"
 #include "lockfile.h"
 #include "object-store.h"
diff --git a/merge.c b/merge.c
index 445b4f19aa8..2c8b8456842 100644
--- a/merge.c
+++ b/merge.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "hex.h"
 #include "lockfile.h"
 #include "commit.h"
 #include "run-command.h"
diff --git a/midx.c b/midx.c
index 84d7a53d66d..24799bef511 100644
--- a/midx.c
+++ b/midx.c
@@ -3,6 +3,7 @@
 #include "config.h"
 #include "csum-file.h"
 #include "dir.h"
+#include "hex.h"
 #include "lockfile.h"
 #include "packfile.h"
 #include "object-store.h"
diff --git a/negotiator/skipping.c b/negotiator/skipping.c
index 0f5ac48e876..28f8769bd40 100644
--- a/negotiator/skipping.c
+++ b/negotiator/skipping.c
@@ -2,6 +2,7 @@
 #include "skipping.h"
 #include "../commit.h"
 #include "../fetch-negotiator.h"
+#include "../hex.h"
 #include "../prio-queue.h"
 #include "../refs.h"
 #include "../tag.h"
diff --git a/notes-merge.c b/notes-merge.c
index b4cc594a790..5b1a9ff13f7 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -5,6 +5,7 @@
 #include "repository.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "hex.h"
 #include "xdiff-interface.h"
 #include "ll-merge.h"
 #include "dir.h"
diff --git a/notes.c b/notes.c
index f2805d51bb1..c9e4b8b4a55 100644
--- a/notes.c
+++ b/notes.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "config.h"
+#include "hex.h"
 #include "notes.h"
 #include "object-store.h"
 #include "blob.h"
diff --git a/object-file.c b/object-file.c
index 18d65220d70..43a39dd8d31 100644
--- a/object-file.c
+++ b/object-file.c
@@ -9,6 +9,7 @@
 #include "git-compat-util.h"
 #include "alloc.h"
 #include "config.h"
+#include "hex.h"
 #include "string-list.h"
 #include "lockfile.h"
 #include "delta.h"
diff --git a/object-name.c b/object-name.c
index 2dd1a0f56e1..97bb94d226c 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "config.h"
+#include "hex.h"
 #include "tag.h"
 #include "commit.h"
 #include "tree.h"
diff --git a/object.c b/object.c
index 344087de4de..609fed1b73d 100644
--- a/object.c
+++ b/object.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "hex.h"
 #include "object.h"
 #include "replace-object.h"
 #include "object-store.h"
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 155939e77b2..891d9d2772e 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "alloc.h"
+#include "hex.h"
 #include "object-store.h"
 #include "commit.h"
 #include "tag.h"
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 5a978341200..a321d6fae83 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "alloc.h"
 #include "commit.h"
+#include "hex.h"
 #include "strbuf.h"
 #include "tag.h"
 #include "diff.h"
diff --git a/pack-check.c b/pack-check.c
index bfb593ba726..7ed594d6679 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "hex.h"
 #include "repository.h"
 #include "pack.h"
 #include "pack-revindex.h"
diff --git a/pack-write.c b/pack-write.c
index 33637297487..041e573bc16 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "hex.h"
 #include "pack.h"
 #include "csum-file.h"
 #include "remote.h"
diff --git a/packfile.c b/packfile.c
index 3e3063de445..4088735a7da 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "alloc.h"
+#include "hex.h"
 #include "list.h"
 #include "pack.h"
 #include "repository.h"
diff --git a/parallel-checkout.c b/parallel-checkout.c
index decdc8d8a1e..2455aa356db 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -2,6 +2,7 @@
 #include "alloc.h"
 #include "config.h"
 #include "entry.h"
+#include "hex.h"
 #include "parallel-checkout.h"
 #include "pkt-line.h"
 #include "progress.h"
diff --git a/patch-ids.c b/patch-ids.c
index 31534466266..a4473a88fa2 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -2,6 +2,7 @@
 #include "diff.h"
 #include "commit.h"
 #include "hash-lookup.h"
+#include "hex.h"
 #include "patch-ids.h"
 
 static int patch_id_defined(struct commit *commit)
diff --git a/path.c b/path.c
index 492e17ad121..97561c3b14d 100644
--- a/path.c
+++ b/path.c
@@ -2,6 +2,7 @@
  * Utilities for paths and pathnames
  */
 #include "cache.h"
+#include "hex.h"
 #include "repository.h"
 #include "strbuf.h"
 #include "string-list.h"
diff --git a/pkt-line.c b/pkt-line.c
index ce4e73b6833..1ea7f8600ec 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "pkt-line.h"
+#include "hex.h"
 #include "run-command.h"
 
 char packet_buffer[LARGE_PACKET_MAX];
diff --git a/pretty.c b/pretty.c
index b6080844498..2401e3ed36b 100644
--- a/pretty.c
+++ b/pretty.c
@@ -2,6 +2,7 @@
 #include "alloc.h"
 #include "config.h"
 #include "commit.h"
+#include "hex.h"
 #include "utf8.h"
 #include "diff.h"
 #include "revision.h"
diff --git a/promisor-remote.c b/promisor-remote.c
index faa7612941c..1db566982ec 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "hex.h"
 #include "object-store.h"
 #include "promisor-remote.h"
 #include "config.h"
diff --git a/protocol-caps.c b/protocol-caps.c
index bbde91810ac..f9bc2a8b90b 100644
--- a/protocol-caps.c
+++ b/protocol-caps.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "protocol-caps.h"
 #include "gettext.h"
+#include "hex.h"
 #include "pkt-line.h"
 #include "strvec.h"
 #include "hash.h"
diff --git a/reachable.c b/reachable.c
index aba63ebeb3b..be9d40923de 100644
--- a/reachable.c
+++ b/reachable.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "hex.h"
 #include "refs.h"
 #include "tag.h"
 #include "commit.h"
diff --git a/read-cache.c b/read-cache.c
index 3cc8e312dce..1bcf6732718 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -8,6 +8,7 @@
 #include "config.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "hex.h"
 #include "tempfile.h"
 #include "lockfile.h"
 #include "cache-tree.h"
diff --git a/ref-filter.c b/ref-filter.c
index c8230a08589..d8627185089 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "alloc.h"
+#include "hex.h"
 #include "parse-options.h"
 #include "refs.h"
 #include "wildmatch.h"
diff --git a/refs.c b/refs.c
index f90f953551b..f22adf6d45a 100644
--- a/refs.c
+++ b/refs.c
@@ -6,6 +6,7 @@
 #include "alloc.h"
 #include "config.h"
 #include "hashmap.h"
+#include "hex.h"
 #include "lockfile.h"
 #include "iterator.h"
 #include "refs.h"
diff --git a/refs/debug.c b/refs/debug.c
index ff7766bc636..adc34c836fc 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -1,4 +1,5 @@
 #include "git-compat-util.h"
+#include "hex.h"
 #include "refs-internal.h"
 #include "trace.h"
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index b89954355de..6f257c70054 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1,5 +1,6 @@
 #include "../cache.h"
 #include "../config.h"
+#include "../hex.h"
 #include "../refs.h"
 #include "refs-internal.h"
 #include "ref-cache.h"
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 186dcafcd00..b665d0f7d9b 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1,6 +1,7 @@
 #include "../git-compat-util.h"
 #include "../alloc.h"
 #include "../config.h"
+#include "../hex.h"
 #include "../refs.h"
 #include "refs-internal.h"
 #include "packed-backend.h"
diff --git a/refspec.c b/refspec.c
index ec336ec5e9c..28d90911aa5 100644
--- a/refspec.c
+++ b/refspec.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "alloc.h"
+#include "hex.h"
 #include "strvec.h"
 #include "refs.h"
 #include "refspec.h"
diff --git a/remote-curl.c b/remote-curl.c
index 380ef3fccfb..ed7e3a043ac 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "alloc.h"
 #include "config.h"
+#include "hex.h"
 #include "remote.h"
 #include "connect.h"
 #include "strbuf.h"
diff --git a/remote.c b/remote.c
index daade49a6f6..b04e5da3383 100644
--- a/remote.c
+++ b/remote.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "alloc.h"
 #include "config.h"
+#include "hex.h"
 #include "remote.h"
 #include "urlmatch.h"
 #include "refs.h"
diff --git a/replace-object.c b/replace-object.c
index 320be2522d8..0cf056c4fbf 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "hex.h"
 #include "oidmap.h"
 #include "object-store.h"
 #include "replace-object.h"
diff --git a/rerere.c b/rerere.c
index d4bcb908531..a67abaab077 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "alloc.h"
 #include "config.h"
+#include "hex.h"
 #include "lockfile.h"
 #include "string-list.h"
 #include "rerere.h"
diff --git a/reset.c b/reset.c
index 5ded23611f3..58b3829ff73 100644
--- a/reset.c
+++ b/reset.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "cache-tree.h"
+#include "hex.h"
 #include "lockfile.h"
 #include "refs.h"
 #include "reset.h"
diff --git a/revision.c b/revision.c
index b8f925f088c..e356bc4aae7 100644
--- a/revision.c
+++ b/revision.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "alloc.h"
 #include "config.h"
+#include "hex.h"
 #include "object-store.h"
 #include "tag.h"
 #include "blob.h"
diff --git a/send-pack.c b/send-pack.c
index f2e19838c9c..954104673f3 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "config.h"
 #include "commit.h"
+#include "hex.h"
 #include "refs.h"
 #include "object-store.h"
 #include "pkt-line.h"
diff --git a/sequencer.c b/sequencer.c
index fcf8740ce1c..af1e07fe765 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "alloc.h"
 #include "config.h"
+#include "hex.h"
 #include "lockfile.h"
 #include "dir.h"
 #include "object-store.h"
diff --git a/server-info.c b/server-info.c
index f07daa16f36..40436892023 100644
--- a/server-info.c
+++ b/server-info.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "alloc.h"
 #include "dir.h"
+#include "hex.h"
 #include "repository.h"
 #include "refs.h"
 #include "object.h"
diff --git a/sha1dc_git.c b/sha1dc_git.c
index 5c300e812e0..72709606fdf 100644
--- a/sha1dc_git.c
+++ b/sha1dc_git.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "hex.h"
 
 #ifdef DC_SHA1_EXTERNAL
 /*
diff --git a/shallow.c b/shallow.c
index 7dc73fb8989..1cbb05ba0e4 100644
--- a/shallow.c
+++ b/shallow.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "alloc.h"
+#include "hex.h"
 #include "repository.h"
 #include "tempfile.h"
 #include "lockfile.h"
diff --git a/strbuf.c b/strbuf.c
index bc4c2c09e60..1c57ac6574f 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "alloc.h"
+#include "hex.h"
 #include "refs.h"
 #include "string-list.h"
 #include "utf8.h"
diff --git a/strvec.c b/strvec.c
index 94d504e3805..17d54b6c3bc 100644
--- a/strvec.c
+++ b/strvec.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "strvec.h"
 #include "alloc.h"
+#include "hex.h"
 #include "strbuf.h"
 
 const char *empty_strvec[] = { NULL };
diff --git a/submodule-config.c b/submodule-config.c
index bb7c35fc317..89a7bf0a93d 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "alloc.h"
 #include "dir.h"
+#include "hex.h"
 #include "repository.h"
 #include "config.h"
 #include "submodule-config.h"
diff --git a/submodule.c b/submodule.c
index 340ffad1c29..9d89299772e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -7,6 +7,7 @@
 #include "dir.h"
 #include "diff.h"
 #include "commit.h"
+#include "hex.h"
 #include "revision.h"
 #include "run-command.h"
 #include "diffcore.h"
diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index 6c900ca6684..787fd524557 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "bloom.h"
+#include "hex.h"
 #include "test-tool.h"
 #include "commit.h"
 
diff --git a/t/helper/test-cache-tree.c b/t/helper/test-cache-tree.c
index 9159a173015..615e648e555 100644
--- a/t/helper/test-cache-tree.c
+++ b/t/helper/test-cache-tree.c
@@ -1,6 +1,7 @@
 #define USE_THE_INDEX_VARIABLE
 #include "test-tool.h"
 #include "cache.h"
+#include "hex.h"
 #include "tree.h"
 #include "cache-tree.h"
 #include "parse-options.h"
diff --git a/t/helper/test-dump-cache-tree.c b/t/helper/test-dump-cache-tree.c
index 454f17b1a0c..92dfc1aa8c4 100644
--- a/t/helper/test-dump-cache-tree.c
+++ b/t/helper/test-dump-cache-tree.c
@@ -1,6 +1,7 @@
 #define USE_THE_INDEX_VARIABLE
 #include "test-tool.h"
 #include "cache.h"
+#include "hex.h"
 #include "tree.h"
 #include "cache-tree.h"
 
diff --git a/t/helper/test-dump-split-index.c b/t/helper/test-dump-split-index.c
index 0ea97b84072..813d0a38fae 100644
--- a/t/helper/test-dump-split-index.c
+++ b/t/helper/test-dump-split-index.c
@@ -1,6 +1,7 @@
 #define USE_THE_INDEX_VARIABLE
 #include "test-tool.h"
 #include "cache.h"
+#include "hex.h"
 #include "split-index.h"
 #include "ewah/ewok.h"
 
diff --git a/t/helper/test-dump-untracked-cache.c b/t/helper/test-dump-untracked-cache.c
index 6d53683f13b..af953fabe87 100644
--- a/t/helper/test-dump-untracked-cache.c
+++ b/t/helper/test-dump-untracked-cache.c
@@ -2,6 +2,7 @@
 #include "test-tool.h"
 #include "cache.h"
 #include "dir.h"
+#include "hex.h"
 
 static int compare_untracked(const void *a_, const void *b_)
 {
diff --git a/t/helper/test-fast-rebase.c b/t/helper/test-fast-rebase.c
index efc82dd80c5..b1edb92a032 100644
--- a/t/helper/test-fast-rebase.c
+++ b/t/helper/test-fast-rebase.c
@@ -15,6 +15,7 @@
 
 #include "cache-tree.h"
 #include "commit.h"
+#include "hex.h"
 #include "lockfile.h"
 #include "merge-ort.h"
 #include "refs.h"
diff --git a/t/helper/test-hash.c b/t/helper/test-hash.c
index 5860dab0ffa..016248106a7 100644
--- a/t/helper/test-hash.c
+++ b/t/helper/test-hash.c
@@ -1,5 +1,6 @@
 #include "test-tool.h"
 #include "cache.h"
+#include "hex.h"
 
 int cmd_hash_impl(int ac, const char **av, int algo)
 {
diff --git a/t/helper/test-match-trees.c b/t/helper/test-match-trees.c
index 4079fdee067..04bc2563f3e 100644
--- a/t/helper/test-match-trees.c
+++ b/t/helper/test-match-trees.c
@@ -1,5 +1,6 @@
 #include "test-tool.h"
 #include "cache.h"
+#include "hex.h"
 #include "tree.h"
 
 int cmd__match_trees(int ac, const char **av)
diff --git a/t/helper/test-oid-array.c b/t/helper/test-oid-array.c
index d1324d086a2..0906993ad59 100644
--- a/t/helper/test-oid-array.c
+++ b/t/helper/test-oid-array.c
@@ -1,5 +1,6 @@
 #include "test-tool.h"
 #include "cache.h"
+#include "hex.h"
 #include "oid-array.h"
 
 static int print_oid(const struct object_id *oid, void *data)
diff --git a/t/helper/test-oidmap.c b/t/helper/test-oidmap.c
index 0acf99931ee..883d40efd45 100644
--- a/t/helper/test-oidmap.c
+++ b/t/helper/test-oidmap.c
@@ -1,5 +1,6 @@
 #include "test-tool.h"
 #include "cache.h"
+#include "hex.h"
 #include "oidmap.h"
 #include "strbuf.h"
 
diff --git a/t/helper/test-oidtree.c b/t/helper/test-oidtree.c
index d48a409f4e4..0b82431a70f 100644
--- a/t/helper/test-oidtree.c
+++ b/t/helper/test-oidtree.c
@@ -1,5 +1,6 @@
 #include "test-tool.h"
 #include "cache.h"
+#include "hex.h"
 #include "oidtree.h"
 
 static enum cb_next print_oid(const struct object_id *oid, void *data)
diff --git a/t/helper/test-pack-mtimes.c b/t/helper/test-pack-mtimes.c
index f7b79daf4c0..f68b3761b68 100644
--- a/t/helper/test-pack-mtimes.c
+++ b/t/helper/test-pack-mtimes.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "test-tool.h"
+#include "hex.h"
 #include "strbuf.h"
 #include "object-store.h"
 #include "packfile.h"
diff --git a/t/helper/test-partial-clone.c b/t/helper/test-partial-clone.c
index 3f102cfddd3..da17fd37eb1 100644
--- a/t/helper/test-partial-clone.c
+++ b/t/helper/test-partial-clone.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "hex.h"
 #include "test-tool.h"
 #include "repository.h"
 #include "object-store.h"
diff --git a/t/helper/test-proc-receive.c b/t/helper/test-proc-receive.c
index a4b305f4947..7e12d4f9aa2 100644
--- a/t/helper/test-proc-receive.c
+++ b/t/helper/test-proc-receive.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "connect.h"
+#include "hex.h"
 #include "parse-options.h"
 #include "pkt-line.h"
 #include "sigchain.h"
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 883d8e20a8e..de8f26639d4 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -3,6 +3,7 @@
 #include "commit.h"
 #include "commit-reach.h"
 #include "config.h"
+#include "hex.h"
 #include "parse-options.h"
 #include "ref-filter.h"
 #include "string-list.h"
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 27072ba94d7..0a883cdf26b 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -1,5 +1,6 @@
 #include "test-tool.h"
 #include "cache.h"
+#include "hex.h"
 #include "midx.h"
 #include "repository.h"
 #include "object-store.h"
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index ae8a5648daf..1745b088b7c 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -1,5 +1,6 @@
 #include "test-tool.h"
 #include "cache.h"
+#include "hex.h"
 #include "refs.h"
 #include "worktree.h"
 #include "object-store.h"
diff --git a/t/helper/test-repository.c b/t/helper/test-repository.c
index 56f0e3c1bef..10a6dfc2160 100644
--- a/t/helper/test-repository.c
+++ b/t/helper/test-repository.c
@@ -3,6 +3,7 @@
 #include "commit-graph.h"
 #include "commit.h"
 #include "config.h"
+#include "hex.h"
 #include "object-store.h"
 #include "object.h"
 #include "repository.h"
diff --git a/tag.c b/tag.c
index dfbcd7fcc24..18b718cca66 100644
--- a/tag.c
+++ b/tag.c
@@ -6,6 +6,7 @@
 #include "blob.h"
 #include "alloc.h"
 #include "gpg-interface.h"
+#include "hex.h"
 #include "packfile.h"
 
 const char *tag_type = "tag";
diff --git a/trace2/tr2_sid.c b/trace2/tr2_sid.c
index dc6e75ef131..5f1ce6f85cf 100644
--- a/trace2/tr2_sid.c
+++ b/trace2/tr2_sid.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "hex.h"
 #include "trace2/tr2_tbuf.h"
 #include "trace2/tr2_sid.h"
 
diff --git a/transport-helper.c b/transport-helper.c
index 3ea7c2bb5ad..82ac63e2609 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -4,6 +4,7 @@
 #include "run-command.h"
 #include "commit.h"
 #include "diff.h"
+#include "hex.h"
 #include "revision.h"
 #include "remote.h"
 #include "string-list.h"
diff --git a/transport.c b/transport.c
index ac9e06a6cea..906dbad5a08 100644
--- a/transport.c
+++ b/transport.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "alloc.h"
 #include "config.h"
+#include "hex.h"
 #include "transport.h"
 #include "hook.h"
 #include "pkt-line.h"
diff --git a/tree-walk.c b/tree-walk.c
index d22f3fe5b05..0e2f5ceb71d 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -2,6 +2,7 @@
 #include "tree-walk.h"
 #include "alloc.h"
 #include "dir.h"
+#include "hex.h"
 #include "object-store.h"
 #include "tree.h"
 #include "pathspec.h"
diff --git a/tree.c b/tree.c
index 410e3b477e5..76a6534f678 100644
--- a/tree.c
+++ b/tree.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "cache-tree.h"
+#include "hex.h"
 #include "tree.h"
 #include "object-store.h"
 #include "blob.h"
diff --git a/unpack-trees.c b/unpack-trees.c
index 3d05e45a279..9c1f2a14b45 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -3,6 +3,7 @@
 #include "repository.h"
 #include "config.h"
 #include "dir.h"
+#include "hex.h"
 #include "tree.h"
 #include "tree-walk.h"
 #include "cache-tree.h"
diff --git a/upload-pack.c b/upload-pack.c
index 551f22ffa5d..fa4bb61e4f1 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "config.h"
+#include "hex.h"
 #include "refs.h"
 #include "pkt-line.h"
 #include "sideband.h"
diff --git a/url.c b/url.c
index e04bd60b6be..bf318c05205 100644
--- a/url.c
+++ b/url.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "hex.h"
 #include "url.h"
 
 int is_urlschemechar(int first_flag, int ch)
diff --git a/urlmatch.c b/urlmatch.c
index 620a648efc5..2965cbe774f 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "hex.h"
 #include "urlmatch.h"
 
 #define URL_ALPHA "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
diff --git a/walker.c b/walker.c
index 99d0e0eae04..c0469363789 100644
--- a/walker.c
+++ b/walker.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "hex.h"
 #include "walker.h"
 #include "repository.h"
 #include "object-store.h"
diff --git a/wt-status.c b/wt-status.c
index 3162241a570..90525bd26fd 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -4,6 +4,7 @@
 #include "dir.h"
 #include "commit.h"
 #include "diff.h"
+#include "hex.h"
 #include "revision.h"
 #include "diffcore.h"
 #include "quote.h"
diff --git a/xdiff-interface.c b/xdiff-interface.c
index e87950de32e..5baf6ceb947 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "config.h"
+#include "hex.h"
 #include "object-store.h"
 #include "xdiff-interface.h"
 #include "xdiff/xtypes.h"
-- 
gitgitgadget


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C14C77B70
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 03:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjDPDEe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 23:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjDPDEF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 23:04:05 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526C430D5
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:38 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id k36-20020a05600c1ca400b003f0a7c483feso4537879wms.4
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681614217; x=1684206217;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6NNGlJEe2TotaQHd0hl2bQCb+Ey6Zeu8Wp96LrX8oQ=;
        b=lGaTUMHPTvxwoXFUbElMPKklBJ9mlfoiMl9mox/cSauUzpgsTN6AF6iWotm6qGMsq1
         VNO0TFqRU8US9YqCRj4NQulN0C3gJay338aBnU5cxUoYka++RS95N7Ce+56QtuYTsx2E
         34UrcO33xc/lc4qutkcdZZYr7OAL8f0ovxjY5N6iO+T4d7c7ghCRlITl+mFBLNHGjvnJ
         m4XzlQtbb0h+5ISSSfuJyDqvGsycpIrJtR28aL3qbjE1nvUAKy1yM+R0eqTEr/Efwe9/
         hJS6TIscpAc9HHSRC1uc4e48Dc5TxaFfn4w5/f2VtfPNjJT/Ac0FOr7hCNez8sloFCsD
         Oavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681614217; x=1684206217;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f6NNGlJEe2TotaQHd0hl2bQCb+Ey6Zeu8Wp96LrX8oQ=;
        b=g2ulfxyJQvklObh0wTfwcXL/oHfY/ocTqnRWKJnUcdLsk47S+h3Q2ChaI7DdVO04tT
         bBJN9kgf3qHVQxcNnZrGx44lkpfh54dghnE7uG25T4yMuNQCZTxAY01IX5/o1kl3NNK4
         nzMWxHMe4oJxaQAVgqm4Ao6lKys03Gz26T/xRRnd0ie6rPeMVGdCRUHBE77Ia+CZBctG
         9eAvED3nBSl4QZYFJ9AW6Eds9i0RJb9N+w/pVmZQP2vgJGjZBoO28ktJIwGt26YF1rW2
         pChIIxV/ZwO4QysB1jzyxSIICmtT/FntEI5mZNUHuKxZ4WIQC0LlE5MTlL7LkLy35RMY
         VrdQ==
X-Gm-Message-State: AAQBX9dEnUz8m1hdl1RBTW4ljsznrUAF1pgB7TL8R/NO7TmVjDRtin79
        9uOaTZXnQObEfdu8R0Q5s0uqeMghnRQ=
X-Google-Smtp-Source: AKy350ZO4ekd8AHmCwR5/q6MI4TtHYtAtGa5Cp+tyXbH4JdIo2byM4K013yUaCmBGSFlSF0YuTyKQg==
X-Received: by 2002:a05:600c:249:b0:3f0:a1df:ada9 with SMTP id 9-20020a05600c024900b003f0a1dfada9mr7367009wmj.39.1681614217295;
        Sat, 15 Apr 2023 20:03:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c028700b003f09a9503b5sm8075443wmk.23.2023.04.15.20.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 20:03:36 -0700 (PDT)
Message-Id: <1c6989ae456c86850761b079384f1505735e317a.1681614206.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 16 Apr 2023 03:03:16 +0000
Subject: [PATCH 14/23] hash.h, repository.h: reverse the order of these
 dependencies
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

Previously, hash.h depended upon and included repository.h, due to
the definition and use of the_hash_algo (defined as
the_repository->hash_algo).  Move this #define, and the associated
inline functions that depend upon it, from hash.h to repository.h.
Due to that movement, reverse the dependencies so repository.h includes
hash.h.

This allows hash.h and object.h to be fairly small, minimal headers.  It
also exposes a lot of hidden dependencies on both path.h (which was
brought in by repository.h) and repository.h (which was previously
implicitly brought in by object.h).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 alloc.c                                      |  1 +
 branch.c                                     |  1 +
 builtin/apply.c                              |  1 +
 builtin/archive.c                            |  1 +
 builtin/bundle.c                             |  1 +
 builtin/check-attr.c                         |  1 +
 builtin/check-ignore.c                       |  1 +
 builtin/checkout-index.c                     |  1 +
 builtin/clean.c                              |  1 +
 builtin/config.c                             |  1 +
 builtin/credential-cache.c                   |  1 +
 builtin/credential-store.c                   |  1 +
 builtin/for-each-repo.c                      |  2 +
 builtin/help.c                               |  1 +
 builtin/init-db.c                            |  1 +
 builtin/merge-index.c                        |  1 +
 builtin/merge-recursive.c                    |  1 +
 builtin/mv.c                                 |  1 +
 builtin/push.c                               |  1 +
 builtin/read-tree.c                          |  1 +
 builtin/rerere.c                             |  1 +
 builtin/rm.c                                 |  1 +
 builtin/show-branch.c                        |  1 +
 builtin/show-index.c                         |  1 +
 builtin/update-index.c                       |  1 +
 builtin/update-ref.c                         |  1 +
 builtin/upload-archive.c                     |  1 +
 builtin/worktree.c                           |  1 +
 checkout.c                                   |  1 +
 chunk-format.c                               |  1 +
 common-main.c                                |  1 +
 compat/fsmonitor/fsm-ipc-darwin.c            |  1 +
 compat/fsmonitor/fsm-ipc-win32.c             |  1 +
 compat/precompose_utf8.c                     |  1 +
 compat/win32/trace2_win32_process_info.c     |  1 +
 copy.c                                       |  1 +
 csum-file.c                                  |  1 +
 daemon.c                                     |  1 +
 editor.c                                     |  1 +
 exec-cmd.c                                   |  1 +
 fsmonitor-ipc.c                              |  1 +
 gpg-interface.c                              |  1 +
 hash-lookup.c                                |  1 +
 hash.h                                       | 97 --------------------
 hex.c                                        |  1 +
 hook.c                                       |  1 +
 khash.h                                      |  1 +
 merge-ort-wrappers.c                         |  1 +
 negotiator/default.c                         |  1 +
 negotiator/skipping.c                        |  1 +
 object-file.h                                |  2 +
 object.h                                     |  1 +
 oid-array.h                                  |  1 +
 oidmap.c                                     |  1 +
 oidtree.c                                    |  1 +
 parallel-checkout.c                          |  1 +
 pathspec.c                                   |  1 +
 progress.c                                   |  1 +
 rebase-interactive.c                         |  1 +
 refs/files-backend.c                         |  1 +
 refs/packed-backend.c                        |  1 +
 refs/ref-cache.c                             |  1 +
 refs/ref-cache.h                             |  1 +
 refspec.c                                    |  1 +
 repository.h                                 | 96 +++++++++++++++++++
 resolve-undo.c                               |  1 +
 split-index.c                                |  1 +
 strbuf.c                                     |  1 +
 t/helper/test-bloom.c                        |  1 +
 t/helper/test-cache-tree.c                   |  1 +
 t/helper/test-dump-cache-tree.c              |  1 +
 t/helper/test-dump-fsmonitor.c               |  1 +
 t/helper/test-dump-untracked-cache.c         |  1 +
 t/helper/test-example-decorate.c             |  1 +
 t/helper/test-fsmonitor-client.c             |  1 +
 t/helper/test-lazy-init-name-hash.c          |  1 +
 t/helper/test-match-trees.c                  |  1 +
 t/helper/test-oidmap.c                       |  1 +
 t/helper/test-path-utils.c                   |  1 +
 t/helper/test-read-cache.c                   |  1 +
 t/helper/test-scrap-cache-tree.c             |  1 +
 t/helper/test-submodule-config.c             |  1 +
 t/helper/test-submodule-nested-repo-config.c |  1 +
 t/helper/test-submodule.c                    |  1 +
 t/helper/test-trace2.c                       |  1 +
 t/helper/test-write-cache.c                  |  1 +
 trace2.c                                     |  1 +
 trace2/tr2_tgt_event.c                       |  1 +
 trace2/tr2_tgt_normal.c                      |  1 +
 trace2/tr2_tgt_perf.c                        |  1 +
 tree-walk.h                                  |  1 +
 tree.h                                       |  1 +
 wrapper.c                                    |  1 +
 93 files changed, 189 insertions(+), 97 deletions(-)

diff --git a/alloc.c b/alloc.c
index 2886aa93543..377e80f5dda 100644
--- a/alloc.c
+++ b/alloc.c
@@ -13,6 +13,7 @@
 #include "blob.h"
 #include "tree.h"
 #include "commit.h"
+#include "repository.h"
 #include "tag.h"
 #include "alloc.h"
 
diff --git a/branch.c b/branch.c
index 7df982693af..9415ee3f340 100644
--- a/branch.c
+++ b/branch.c
@@ -9,6 +9,7 @@
 #include "refs.h"
 #include "refspec.h"
 #include "remote.h"
+#include "repository.h"
 #include "sequencer.h"
 #include "commit.h"
 #include "worktree.h"
diff --git a/builtin/apply.c b/builtin/apply.c
index fe72c0ec3eb..e3ff02a09e3 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2,6 +2,7 @@
 #include "builtin.h"
 #include "gettext.h"
 #include "parse-options.h"
+#include "repository.h"
 #include "apply.h"
 
 static const char * const apply_usage[] = {
diff --git a/builtin/archive.c b/builtin/archive.c
index d13934f1a80..b0eaa3c14a3 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -9,6 +9,7 @@
 #include "transport.h"
 #include "parse-options.h"
 #include "pkt-line.h"
+#include "repository.h"
 #include "sideband.h"
 
 static void create_output_file(const char *output_file)
diff --git a/builtin/bundle.c b/builtin/bundle.c
index 584d905d965..44113389d7a 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -5,6 +5,7 @@
 #include "strvec.h"
 #include "parse-options.h"
 #include "pkt-line.h"
+#include "repository.h"
 #include "cache.h"
 #include "bundle.h"
 
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 037bf1aaa2a..b2b678847f5 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -7,6 +7,7 @@
 #include "gettext.h"
 #include "object-name.h"
 #include "quote.h"
+#include "repository.h"
 #include "setup.h"
 #include "parse-options.h"
 #include "write-or-die.h"
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 9401dad0070..e4b78782a32 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -7,6 +7,7 @@
 #include "quote.h"
 #include "pathspec.h"
 #include "parse-options.h"
+#include "repository.h"
 #include "submodule.h"
 #include "write-or-die.h"
 
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 7df673e3e70..9375a05539f 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -11,6 +11,7 @@
 #include "gettext.h"
 #include "lockfile.h"
 #include "quote.h"
+#include "repository.h"
 #include "cache-tree.h"
 #include "parse-options.h"
 #include "entry.h"
diff --git a/builtin/clean.c b/builtin/clean.c
index 14c0d555eac..78852d28cec 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -14,6 +14,7 @@
 #include "dir.h"
 #include "gettext.h"
 #include "parse-options.h"
+#include "repository.h"
 #include "setup.h"
 #include "string-list.h"
 #include "quote.h"
diff --git a/builtin/config.c b/builtin/config.c
index 9401f1e5e3b..7efcf2d2159 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -10,6 +10,7 @@
 #include "parse-options.h"
 #include "urlmatch.h"
 #include "quote.h"
+#include "repository.h"
 #include "setup.h"
 #include "worktree.h"
 #include "wrapper.h"
diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
index 508da4c6e4d..204e78ac772 100644
--- a/builtin/credential-cache.c
+++ b/builtin/credential-cache.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "gettext.h"
 #include "parse-options.h"
+#include "repository.h"
 #include "wrapper.h"
 #include "write-or-die.h"
 
diff --git a/builtin/credential-store.c b/builtin/credential-store.c
index 8977604eb9d..30c6ccf56c0 100644
--- a/builtin/credential-store.c
+++ b/builtin/credential-store.c
@@ -3,6 +3,7 @@
 #include "gettext.h"
 #include "lockfile.h"
 #include "credential.h"
+#include "path.h"
 #include "string-list.h"
 #include "parse-options.h"
 #include "write-or-die.h"
diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index 27425c2fc9e..c28b0b3543a 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -3,6 +3,8 @@
 #include "builtin.h"
 #include "gettext.h"
 #include "parse-options.h"
+#include "path.h"
+#include "repository.h"
 #include "run-command.h"
 #include "string-list.h"
 
diff --git a/builtin/help.c b/builtin/help.c
index 128aa83099a..d3cf4af3f6e 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -8,6 +8,7 @@
 #include "gettext.h"
 #include "pager.h"
 #include "parse-options.h"
+#include "path.h"
 #include "run-command.h"
 #include "config-list.h"
 #include "help.h"
diff --git a/builtin/init-db.c b/builtin/init-db.c
index cda6ee75eb5..aef40361052 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -14,6 +14,7 @@
 #include "exec-cmd.h"
 #include "object-file.h"
 #include "parse-options.h"
+#include "path.h"
 #include "setup.h"
 #include "worktree.h"
 #include "wrapper.h"
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index c875f5d37ee..f044382ed8f 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -1,6 +1,7 @@
 #define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "hex.h"
+#include "repository.h"
 #include "run-command.h"
 
 static const char *pgm;
diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index fa1035405c3..eae25c9486e 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -6,6 +6,7 @@
 #include "tag.h"
 #include "merge-recursive.h"
 #include "object-name.h"
+#include "repository.h"
 #include "xdiff-interface.h"
 
 static const char builtin_merge_recursive_usage[] =
diff --git a/builtin/mv.c b/builtin/mv.c
index 32935af48e6..665bd274485 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -18,6 +18,7 @@
 #include "cache-tree.h"
 #include "string-list.h"
 #include "parse-options.h"
+#include "repository.h"
 #include "setup.h"
 #include "submodule.h"
 #include "entry.h"
diff --git a/builtin/push.c b/builtin/push.c
index 7d2b0505aac..4e5780dd50d 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -15,6 +15,7 @@
 #include "transport.h"
 #include "parse-options.h"
 #include "pkt-line.h"
+#include "repository.h"
 #include "submodule.h"
 #include "submodule-config.h"
 #include "send-pack.h"
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index d61cbad96de..440f19b1b87 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -19,6 +19,7 @@
 #include "dir.h"
 #include "builtin.h"
 #include "parse-options.h"
+#include "repository.h"
 #include "resolve-undo.h"
 #include "setup.h"
 #include "submodule.h"
diff --git a/builtin/rerere.c b/builtin/rerere.c
index d4a03707b1a..d4bd52797f4 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -4,6 +4,7 @@
 #include "dir.h"
 #include "gettext.h"
 #include "parse-options.h"
+#include "repository.h"
 #include "string-list.h"
 #include "rerere.h"
 #include "wrapper.h"
diff --git a/builtin/rm.c b/builtin/rm.c
index d36072252e7..ccbce94d07d 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -15,6 +15,7 @@
 #include "tree-walk.h"
 #include "object-name.h"
 #include "parse-options.h"
+#include "repository.h"
 #include "string-list.h"
 #include "setup.h"
 #include "submodule.h"
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 20030b75e39..04167b14060 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -10,6 +10,7 @@
 #include "strvec.h"
 #include "object-name.h"
 #include "parse-options.h"
+#include "repository.h"
 #include "dir.h"
 #include "commit-slab.h"
 #include "date.h"
diff --git a/builtin/show-index.c b/builtin/show-index.c
index d4bbbbcd6ce..6608b5d252e 100644
--- a/builtin/show-index.c
+++ b/builtin/show-index.c
@@ -4,6 +4,7 @@
 #include "hex.h"
 #include "pack.h"
 #include "parse-options.h"
+#include "repository.h"
 
 static const char *const show_index_usage[] = {
 	"git show-index [--object-format=<hash-algorithm>]",
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 58bbc80db77..df36bc0a42d 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -21,6 +21,7 @@
 #include "parse-options.h"
 #include "pathspec.h"
 #include "dir.h"
+#include "repository.h"
 #include "setup.h"
 #include "split-index.h"
 #include "symlinks.h"
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 6ca85420c3b..ef1fcb86718 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -6,6 +6,7 @@
 #include "object-name.h"
 #include "parse-options.h"
 #include "quote.h"
+#include "repository.h"
 #include "strvec.h"
 
 static const char * const git_update_ref_usage[] = {
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 945ee2b4126..5be97ca1af5 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -6,6 +6,7 @@
 #include "archive.h"
 #include "pkt-line.h"
 #include "sideband.h"
+#include "repository.h"
 #include "run-command.h"
 #include "strvec.h"
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 0b411e9deee..5d3ca819e76 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -14,6 +14,7 @@
 #include "strvec.h"
 #include "branch.h"
 #include "refs.h"
+#include "repository.h"
 #include "run-command.h"
 #include "hook.h"
 #include "sigchain.h"
diff --git a/checkout.c b/checkout.c
index 04238b27133..4256e71a7c4 100644
--- a/checkout.c
+++ b/checkout.c
@@ -2,6 +2,7 @@
 #include "object-name.h"
 #include "remote.h"
 #include "refspec.h"
+#include "repository.h"
 #include "checkout.h"
 #include "config.h"
 #include "strbuf.h"
diff --git a/chunk-format.c b/chunk-format.c
index 60a73c1b140..6bd87b7de89 100644
--- a/chunk-format.c
+++ b/chunk-format.c
@@ -3,6 +3,7 @@
 #include "chunk-format.h"
 #include "csum-file.h"
 #include "gettext.h"
+#include "repository.h"
 #include "trace2.h"
 
 /*
diff --git a/common-main.c b/common-main.c
index 601a875e2fb..8ab50fa37a4 100644
--- a/common-main.c
+++ b/common-main.c
@@ -2,6 +2,7 @@
 #include "exec-cmd.h"
 #include "gettext.h"
 #include "attr.h"
+#include "repository.h"
 #include "setup.h"
 #include "strbuf.h"
 #include "trace2.h"
diff --git a/compat/fsmonitor/fsm-ipc-darwin.c b/compat/fsmonitor/fsm-ipc-darwin.c
index eb25123fa12..e62f093cc19 100644
--- a/compat/fsmonitor/fsm-ipc-darwin.c
+++ b/compat/fsmonitor/fsm-ipc-darwin.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "config.h"
 #include "hex.h"
+#include "repository.h"
 #include "strbuf.h"
 #include "fsmonitor.h"
 #include "fsmonitor-ipc.h"
diff --git a/compat/fsmonitor/fsm-ipc-win32.c b/compat/fsmonitor/fsm-ipc-win32.c
index c9536dfb666..8928fa93ce2 100644
--- a/compat/fsmonitor/fsm-ipc-win32.c
+++ b/compat/fsmonitor/fsm-ipc-win32.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "config.h"
 #include "fsmonitor-ipc.h"
+#include "path.h"
 
 const char *fsmonitor_ipc__get_path(struct repository *r) {
 	static char *ret;
diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index 8a9881db077..a4d11376ba5 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -9,6 +9,7 @@
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
+#include "path.h"
 #include "utf8.h"
 #include "precompose_utf8.h"
 
diff --git a/compat/win32/trace2_win32_process_info.c b/compat/win32/trace2_win32_process_info.c
index e3e895c78a2..a4e33768f43 100644
--- a/compat/win32/trace2_win32_process_info.c
+++ b/compat/win32/trace2_win32_process_info.c
@@ -1,5 +1,6 @@
 #include "../../cache.h"
 #include "../../json-writer.h"
+#include "../../repository.h"
 #include "../../trace2.h"
 #include "lazyload.h"
 #include <Psapi.h>
diff --git a/copy.c b/copy.c
index db6b615c188..923d8a6dc61 100644
--- a/copy.c
+++ b/copy.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "copy.h"
+#include "path.h"
 #include "wrapper.h"
 
 int copy_fd(int ifd, int ofd)
diff --git a/csum-file.c b/csum-file.c
index 82ae2973d30..2d14b76c533 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -10,6 +10,7 @@
 #include "git-compat-util.h"
 #include "progress.h"
 #include "csum-file.h"
+#include "repository.h"
 #include "wrapper.h"
 
 static void verify_buffer_or_die(struct hashfile *f,
diff --git a/daemon.c b/daemon.c
index 75c3c064574..f89f99d7ef4 100644
--- a/daemon.c
+++ b/daemon.c
@@ -3,6 +3,7 @@
 #include "alloc.h"
 #include "config.h"
 #include "environment.h"
+#include "path.h"
 #include "pkt-line.h"
 #include "protocol.h"
 #include "run-command.h"
diff --git a/editor.c b/editor.c
index b34e10606d2..38c5dbbb79b 100644
--- a/editor.c
+++ b/editor.c
@@ -6,6 +6,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "pager.h"
+#include "path.h"
 #include "strbuf.h"
 #include "strvec.h"
 #include "run-command.h"
diff --git a/exec-cmd.c b/exec-cmd.c
index 6f618463896..1e34e48c0e4 100644
--- a/exec-cmd.c
+++ b/exec-cmd.c
@@ -3,6 +3,7 @@
 #include "environment.h"
 #include "exec-cmd.h"
 #include "gettext.h"
+#include "path.h"
 #include "quote.h"
 #include "strvec.h"
 #include "trace.h"
diff --git a/fsmonitor-ipc.c b/fsmonitor-ipc.c
index 866828e2992..6a6a89764a6 100644
--- a/fsmonitor-ipc.c
+++ b/fsmonitor-ipc.c
@@ -3,6 +3,7 @@
 #include "gettext.h"
 #include "simple-ipc.h"
 #include "fsmonitor-ipc.h"
+#include "repository.h"
 #include "run-command.h"
 #include "strbuf.h"
 #include "trace2.h"
diff --git a/gpg-interface.c b/gpg-interface.c
index aceeb083367..8615dcd4b4b 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -7,6 +7,7 @@
 #include "dir.h"
 #include "ident.h"
 #include "gpg-interface.h"
+#include "path.h"
 #include "sigchain.h"
 #include "tempfile.h"
 #include "alias.h"
diff --git a/hash-lookup.c b/hash-lookup.c
index b98ed5e11e8..68cf6d03bf3 100644
--- a/hash-lookup.c
+++ b/hash-lookup.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "hash-lookup.h"
+#include "repository.h"
 
 static uint32_t take2(const struct object_id *oid, size_t ofs)
 {
diff --git a/hash.h b/hash.h
index d39f73618cb..ed963816289 100644
--- a/hash.h
+++ b/hash.h
@@ -1,8 +1,6 @@
 #ifndef HASH_H
 #define HASH_H
 
-#include "repository.h"
-
 #if defined(SHA1_APPLE)
 #include <CommonCrypto/CommonDigest.h>
 #elif defined(SHA1_OPENSSL)
@@ -230,8 +228,6 @@ static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
 	return p - hash_algos;
 }
 
-#define the_hash_algo the_repository->hash_algo
-
 const struct object_id *null_oid(void);
 
 static inline int hashcmp_algop(const unsigned char *sha1, const unsigned char *sha2, const struct git_hash_algo *algop)
@@ -245,21 +241,6 @@ static inline int hashcmp_algop(const unsigned char *sha1, const unsigned char *
 	return memcmp(sha1, sha2, GIT_SHA1_RAWSZ);
 }
 
-static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
-{
-	return hashcmp_algop(sha1, sha2, the_hash_algo);
-}
-
-static inline int oidcmp(const struct object_id *oid1, const struct object_id *oid2)
-{
-	const struct git_hash_algo *algop;
-	if (!oid1->algo)
-		algop = the_hash_algo;
-	else
-		algop = &hash_algos[oid1->algo];
-	return hashcmp_algop(oid1->hash, oid2->hash, algop);
-}
-
 static inline int hasheq_algop(const unsigned char *sha1, const unsigned char *sha2, const struct git_hash_algo *algop)
 {
 	/*
@@ -271,53 +252,12 @@ static inline int hasheq_algop(const unsigned char *sha1, const unsigned char *s
 	return !memcmp(sha1, sha2, GIT_SHA1_RAWSZ);
 }
 
-static inline int hasheq(const unsigned char *sha1, const unsigned char *sha2)
-{
-	return hasheq_algop(sha1, sha2, the_hash_algo);
-}
-
-static inline int oideq(const struct object_id *oid1, const struct object_id *oid2)
-{
-	const struct git_hash_algo *algop;
-	if (!oid1->algo)
-		algop = the_hash_algo;
-	else
-		algop = &hash_algos[oid1->algo];
-	return hasheq_algop(oid1->hash, oid2->hash, algop);
-}
-
-static inline int is_null_oid(const struct object_id *oid)
-{
-	return oideq(oid, null_oid());
-}
-
-static inline void hashcpy(unsigned char *sha_dst, const unsigned char *sha_src)
-{
-	memcpy(sha_dst, sha_src, the_hash_algo->rawsz);
-}
-
 static inline void oidcpy(struct object_id *dst, const struct object_id *src)
 {
 	memcpy(dst->hash, src->hash, GIT_MAX_RAWSZ);
 	dst->algo = src->algo;
 }
 
-/* Like oidcpy() but zero-pads the unused bytes in dst's hash array. */
-static inline void oidcpy_with_padding(struct object_id *dst,
-				       const struct object_id *src)
-{
-	size_t hashsz;
-
-	if (!src->algo)
-		hashsz = the_hash_algo->rawsz;
-	else
-		hashsz = hash_algos[src->algo].rawsz;
-
-	memcpy(dst->hash, src->hash, hashsz);
-	memset(dst->hash + hashsz, 0, GIT_MAX_RAWSZ - hashsz);
-	dst->algo = src->algo;
-}
-
 static inline struct object_id *oiddup(const struct object_id *src)
 {
 	struct object_id *dst = xmalloc(sizeof(struct object_id));
@@ -325,43 +265,6 @@ static inline struct object_id *oiddup(const struct object_id *src)
 	return dst;
 }
 
-static inline void hashclr(unsigned char *hash)
-{
-	memset(hash, 0, the_hash_algo->rawsz);
-}
-
-static inline void oidclr(struct object_id *oid)
-{
-	memset(oid->hash, 0, GIT_MAX_RAWSZ);
-	oid->algo = hash_algo_by_ptr(the_hash_algo);
-}
-
-static inline void oidread(struct object_id *oid, const unsigned char *hash)
-{
-	memcpy(oid->hash, hash, the_hash_algo->rawsz);
-	oid->algo = hash_algo_by_ptr(the_hash_algo);
-}
-
-static inline int is_empty_blob_sha1(const unsigned char *sha1)
-{
-	return hasheq(sha1, the_hash_algo->empty_blob->hash);
-}
-
-static inline int is_empty_blob_oid(const struct object_id *oid)
-{
-	return oideq(oid, the_hash_algo->empty_blob);
-}
-
-static inline int is_empty_tree_sha1(const unsigned char *sha1)
-{
-	return hasheq(sha1, the_hash_algo->empty_tree->hash);
-}
-
-static inline int is_empty_tree_oid(const struct object_id *oid)
-{
-	return oideq(oid, the_hash_algo->empty_tree);
-}
-
 static inline void oid_set_algo(struct object_id *oid, const struct git_hash_algo *algop)
 {
 	oid->algo = hash_algo_by_ptr(algop);
diff --git a/hex.c b/hex.c
index 0a1bddc1284..f6849b51b28 100644
--- a/hex.c
+++ b/hex.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "hex.h"
+#include "repository.h"
 
 const signed char hexval_table[256] = {
 	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 00-07 */
diff --git a/hook.c b/hook.c
index 76e322f5804..3ca5e60895d 100644
--- a/hook.c
+++ b/hook.c
@@ -2,6 +2,7 @@
 #include "advice.h"
 #include "gettext.h"
 #include "hook.h"
+#include "path.h"
 #include "run-command.h"
 #include "config.h"
 #include "strbuf.h"
diff --git a/khash.h b/khash.h
index 85362718c56..edd5b45d000 100644
--- a/khash.h
+++ b/khash.h
@@ -27,6 +27,7 @@
 #define __AC_KHASH_H
 
 #include "hashmap.h"
+#include "repository.h"
 
 #define AC_VERSION_KHASH_H "0.2.8"
 
diff --git a/merge-ort-wrappers.c b/merge-ort-wrappers.c
index c00dfbab1cd..2d1e8aa7ee7 100644
--- a/merge-ort-wrappers.c
+++ b/merge-ort-wrappers.c
@@ -2,6 +2,7 @@
 #include "gettext.h"
 #include "merge-ort.h"
 #include "merge-ort-wrappers.h"
+#include "repository.h"
 
 #include "commit.h"
 
diff --git a/negotiator/default.c b/negotiator/default.c
index f4b78eb47dd..5cb2b1d2046 100644
--- a/negotiator/default.c
+++ b/negotiator/default.c
@@ -4,6 +4,7 @@
 #include "../fetch-negotiator.h"
 #include "../prio-queue.h"
 #include "../refs.h"
+#include "../repository.h"
 #include "../tag.h"
 
 /* Remember to update object flag allocation in object.h */
diff --git a/negotiator/skipping.c b/negotiator/skipping.c
index c7d6ab39bc5..97e7e1ae725 100644
--- a/negotiator/skipping.c
+++ b/negotiator/skipping.c
@@ -5,6 +5,7 @@
 #include "../hex.h"
 #include "../prio-queue.h"
 #include "../refs.h"
+#include "../repository.h"
 #include "../tag.h"
 
 /* Remember to update object flag allocation in object.h */
diff --git a/object-file.h b/object-file.h
index e0cfc3a5db8..d6414610f80 100644
--- a/object-file.h
+++ b/object-file.h
@@ -4,6 +4,8 @@
 #include "git-zlib.h"
 #include "object.h"
 
+struct index_state;
+
 /*
  * Set this to 0 to prevent oid_object_info_extended() from fetching missing
  * blobs. This has a difference only if extensions.partialClone is set.
diff --git a/object.h b/object.h
index 96e52e24fb1..6cd8b49fa66 100644
--- a/object.h
+++ b/object.h
@@ -4,6 +4,7 @@
 #include "hash.h"
 
 struct buffer_slab;
+struct repository;
 
 struct parsed_object_pool {
 	struct object **obj_hash;
diff --git a/oid-array.h b/oid-array.h
index f60f9af6741..8bfe452259b 100644
--- a/oid-array.h
+++ b/oid-array.h
@@ -2,6 +2,7 @@
 #define OID_ARRAY_H
 
 #include "hash.h"
+#include "repository.h"
 
 /**
  * The API provides storage and manipulation of sets of object identifiers.
diff --git a/oidmap.c b/oidmap.c
index 8c1a139c974..d268486f4e8 100644
--- a/oidmap.c
+++ b/oidmap.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "oidmap.h"
+#include "repository.h"
 
 static int oidmap_neq(const void *hashmap_cmp_fn_data UNUSED,
 		      const struct hashmap_entry *e1,
diff --git a/oidtree.c b/oidtree.c
index 7d57b7b19e3..634214673dd 100644
--- a/oidtree.c
+++ b/oidtree.c
@@ -6,6 +6,7 @@
 #include "oidtree.h"
 #include "alloc.h"
 #include "hash.h"
+#include "repository.h"
 
 struct oidtree_iter_data {
 	oidtree_iter fn;
diff --git a/parallel-checkout.c b/parallel-checkout.c
index 7f0569cc930..78cb6e3003a 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -7,6 +7,7 @@
 #include "parallel-checkout.h"
 #include "pkt-line.h"
 #include "progress.h"
+#include "repository.h"
 #include "run-command.h"
 #include "sigchain.h"
 #include "streaming.h"
diff --git a/pathspec.c b/pathspec.c
index ec335a214e2..1e57b6c667d 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -6,6 +6,7 @@
 #include "gettext.h"
 #include "pathspec.h"
 #include "attr.h"
+#include "repository.h"
 #include "setup.h"
 #include "strvec.h"
 #include "symlinks.h"
diff --git a/progress.c b/progress.c
index 72d5e0c73c1..f695798acac 100644
--- a/progress.c
+++ b/progress.c
@@ -12,6 +12,7 @@
 #include "git-compat-util.h"
 #include "pager.h"
 #include "progress.h"
+#include "repository.h"
 #include "strbuf.h"
 #include "trace.h"
 #include "trace2.h"
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 789f4073617..852a3313182 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -5,6 +5,7 @@
 #include "gettext.h"
 #include "sequencer.h"
 #include "rebase-interactive.h"
+#include "repository.h"
 #include "strbuf.h"
 #include "commit-slab.h"
 #include "config.h"
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1128a9af292..212a0c14ea4 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -14,6 +14,7 @@
 #include "../lockfile.h"
 #include "../object.h"
 #include "../object-file.h"
+#include "../repository.h"
 #include "../dir.h"
 #include "../chdir-notify.h"
 #include "../setup.h"
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 2333ed5a1f7..b3a46f9d4dd 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -9,6 +9,7 @@
 #include "../iterator.h"
 #include "../lockfile.h"
 #include "../chdir-notify.h"
+#include "../repository.h"
 #include "../wrapper.h"
 #include "../write-or-die.h"
 
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index dc1ca49c85f..84c3838c743 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -4,6 +4,7 @@
 #include "refs-internal.h"
 #include "ref-cache.h"
 #include "../iterator.h"
+#include "../repository.h"
 
 void add_entry_to_dir(struct ref_dir *dir, struct ref_entry *entry)
 {
diff --git a/refs/ref-cache.h b/refs/ref-cache.h
index cf4ad9070b9..31ebe24f6cf 100644
--- a/refs/ref-cache.h
+++ b/refs/ref-cache.h
@@ -5,6 +5,7 @@
 
 struct ref_dir;
 struct ref_store;
+struct repository;
 
 /*
  * If this ref_cache is filled lazily, this function is used to load
diff --git a/refspec.c b/refspec.c
index 7b5c305514d..68020ee84c6 100644
--- a/refspec.c
+++ b/refspec.c
@@ -5,6 +5,7 @@
 #include "strvec.h"
 #include "refs.h"
 #include "refspec.h"
+#include "repository.h"
 
 static struct refspec_item s_tag_refspec = {
 	.force = 0,
diff --git a/repository.h b/repository.h
index 15a8afc5fb5..9e36868207f 100644
--- a/repository.h
+++ b/repository.h
@@ -1,6 +1,7 @@
 #ifndef REPOSITORY_H
 #define REPOSITORY_H
 
+#include "hash.h"
 #include "path.h"
 
 struct config_set;
@@ -238,4 +239,99 @@ void prepare_repo_settings(struct repository *r);
  */
 int upgrade_repository_format(int target_version);
 
+#define the_hash_algo the_repository->hash_algo
+
+static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
+{
+	return hashcmp_algop(sha1, sha2, the_hash_algo);
+}
+
+static inline int oidcmp(const struct object_id *oid1, const struct object_id *oid2)
+{
+	const struct git_hash_algo *algop;
+	if (!oid1->algo)
+		algop = the_hash_algo;
+	else
+		algop = &hash_algos[oid1->algo];
+	return hashcmp_algop(oid1->hash, oid2->hash, algop);
+}
+
+static inline int hasheq(const unsigned char *sha1, const unsigned char *sha2)
+{
+	return hasheq_algop(sha1, sha2, the_hash_algo);
+}
+
+static inline int oideq(const struct object_id *oid1, const struct object_id *oid2)
+{
+	const struct git_hash_algo *algop;
+	if (!oid1->algo)
+		algop = the_hash_algo;
+	else
+		algop = &hash_algos[oid1->algo];
+	return hasheq_algop(oid1->hash, oid2->hash, algop);
+}
+
+static inline int is_null_oid(const struct object_id *oid)
+{
+	return oideq(oid, null_oid());
+}
+
+static inline void hashcpy(unsigned char *sha_dst, const unsigned char *sha_src)
+{
+	memcpy(sha_dst, sha_src, the_hash_algo->rawsz);
+}
+
+/* Like oidcpy() but zero-pads the unused bytes in dst's hash array. */
+static inline void oidcpy_with_padding(struct object_id *dst,
+				       const struct object_id *src)
+{
+	size_t hashsz;
+
+	if (!src->algo)
+		hashsz = the_hash_algo->rawsz;
+	else
+		hashsz = hash_algos[src->algo].rawsz;
+
+	memcpy(dst->hash, src->hash, hashsz);
+	memset(dst->hash + hashsz, 0, GIT_MAX_RAWSZ - hashsz);
+	dst->algo = src->algo;
+}
+
+static inline void hashclr(unsigned char *hash)
+{
+	memset(hash, 0, the_hash_algo->rawsz);
+}
+
+static inline void oidclr(struct object_id *oid)
+{
+	memset(oid->hash, 0, GIT_MAX_RAWSZ);
+	oid->algo = hash_algo_by_ptr(the_hash_algo);
+}
+
+static inline void oidread(struct object_id *oid, const unsigned char *hash)
+{
+	memcpy(oid->hash, hash, the_hash_algo->rawsz);
+	oid->algo = hash_algo_by_ptr(the_hash_algo);
+}
+
+static inline int is_empty_blob_sha1(const unsigned char *sha1)
+{
+	return hasheq(sha1, the_hash_algo->empty_blob->hash);
+}
+
+static inline int is_empty_blob_oid(const struct object_id *oid)
+{
+	return oideq(oid, the_hash_algo->empty_blob);
+}
+
+static inline int is_empty_tree_sha1(const unsigned char *sha1)
+{
+	return hasheq(sha1, the_hash_algo->empty_tree->hash);
+}
+
+static inline int is_empty_tree_oid(const struct object_id *oid)
+{
+	return oideq(oid, the_hash_algo->empty_tree);
+}
+
 #endif /* REPOSITORY_H */
diff --git a/resolve-undo.c b/resolve-undo.c
index e81096e2d45..7dbd38a2cf9 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "dir.h"
 #include "resolve-undo.h"
+#include "repository.h"
 #include "string-list.h"
 
 /* The only error case is to run out of memory in string-list */
diff --git a/split-index.c b/split-index.c
index 3fc4e91485a..bce6480084e 100644
--- a/split-index.c
+++ b/split-index.c
@@ -2,6 +2,7 @@
 #include "alloc.h"
 #include "gettext.h"
 #include "mem-pool.h"
+#include "repository.h"
 #include "split-index.h"
 #include "strbuf.h"
 #include "ewah/ewok.h"
diff --git a/strbuf.c b/strbuf.c
index 729378ec824..08eec8f1d8b 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -6,6 +6,7 @@
 #include "hex.h"
 #include "object-name.h"
 #include "refs.h"
+#include "repository.h"
 #include "string-list.h"
 #include "utf8.h"
 #include "date.h"
diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index d2b30d644da..aabe31d724b 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -2,6 +2,7 @@
 #include "bloom.h"
 #include "hex.h"
 #include "commit.h"
+#include "repository.h"
 #include "setup.h"
 
 static struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
diff --git a/t/helper/test-cache-tree.c b/t/helper/test-cache-tree.c
index cdaf5046f5a..9507b356e22 100644
--- a/t/helper/test-cache-tree.c
+++ b/t/helper/test-cache-tree.c
@@ -6,6 +6,7 @@
 #include "tree.h"
 #include "cache-tree.h"
 #include "parse-options.h"
+#include "repository.h"
 #include "setup.h"
 
 static char const * const test_cache_tree_usage[] = {
diff --git a/t/helper/test-dump-cache-tree.c b/t/helper/test-dump-cache-tree.c
index 715aabfbae7..df30cc92d24 100644
--- a/t/helper/test-dump-cache-tree.c
+++ b/t/helper/test-dump-cache-tree.c
@@ -4,6 +4,7 @@
 #include "hex.h"
 #include "tree.h"
 #include "cache-tree.h"
+#include "repository.h"
 #include "setup.h"
 
 static void dump_one(struct cache_tree *it, const char *pfx, const char *x)
diff --git a/t/helper/test-dump-fsmonitor.c b/t/helper/test-dump-fsmonitor.c
index 7e9de296db3..6dc49583375 100644
--- a/t/helper/test-dump-fsmonitor.c
+++ b/t/helper/test-dump-fsmonitor.c
@@ -1,5 +1,6 @@
 #include "test-tool.h"
 #include "cache.h"
+#include "repository.h"
 #include "setup.h"
 
 int cmd__dump_fsmonitor(int ac, const char **av)
diff --git a/t/helper/test-dump-untracked-cache.c b/t/helper/test-dump-untracked-cache.c
index 415f55f31da..d1b99d21dcd 100644
--- a/t/helper/test-dump-untracked-cache.c
+++ b/t/helper/test-dump-untracked-cache.c
@@ -3,6 +3,7 @@
 #include "cache.h"
 #include "dir.h"
 #include "hex.h"
+#include "repository.h"
 #include "setup.h"
 
 static int compare_untracked(const void *a_, const void *b_)
diff --git a/t/helper/test-example-decorate.c b/t/helper/test-example-decorate.c
index 7c7fc8efc13..43707486dd4 100644
--- a/t/helper/test-example-decorate.c
+++ b/t/helper/test-example-decorate.c
@@ -2,6 +2,7 @@
 #include "git-compat-util.h"
 #include "object.h"
 #include "decorate.h"
+#include "repository.h"
 
 int cmd__example_decorate(int argc, const char **argv)
 {
diff --git a/t/helper/test-fsmonitor-client.c b/t/helper/test-fsmonitor-client.c
index a37236cd0a6..bb00e1e5d14 100644
--- a/t/helper/test-fsmonitor-client.c
+++ b/t/helper/test-fsmonitor-client.c
@@ -7,6 +7,7 @@
 #include "cache.h"
 #include "parse-options.h"
 #include "fsmonitor-ipc.h"
+#include "repository.h"
 #include "setup.h"
 #include "thread-utils.h"
 #include "trace2.h"
diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper/test-lazy-init-name-hash.c
index f23d983c118..b83a75d19f6 100644
--- a/t/helper/test-lazy-init-name-hash.c
+++ b/t/helper/test-lazy-init-name-hash.c
@@ -3,6 +3,7 @@
 #include "cache.h"
 #include "environment.h"
 #include "parse-options.h"
+#include "repository.h"
 #include "setup.h"
 #include "trace.h"
 
diff --git a/t/helper/test-match-trees.c b/t/helper/test-match-trees.c
index a498fece7a3..3c62e33ccdf 100644
--- a/t/helper/test-match-trees.c
+++ b/t/helper/test-match-trees.c
@@ -3,6 +3,7 @@
 #include "hex.h"
 #include "match-trees.h"
 #include "object-name.h"
+#include "repository.h"
 #include "setup.h"
 #include "tree.h"
 
diff --git a/t/helper/test-oidmap.c b/t/helper/test-oidmap.c
index de6ab77fdaa..bba4099f65f 100644
--- a/t/helper/test-oidmap.c
+++ b/t/helper/test-oidmap.c
@@ -2,6 +2,7 @@
 #include "hex.h"
 #include "object-name.h"
 #include "oidmap.h"
+#include "repository.h"
 #include "setup.h"
 #include "strbuf.h"
 
diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index 6355c9e4b6d..2ef53d5f7a2 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "abspath.h"
 #include "environment.h"
+#include "path.h"
 #include "setup.h"
 #include "string-list.h"
 #include "trace.h"
diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index a4c24d0e421..c1ae2763954 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -2,6 +2,7 @@
 #include "test-tool.h"
 #include "cache.h"
 #include "config.h"
+#include "repository.h"
 #include "setup.h"
 #include "wrapper.h"
 
diff --git a/t/helper/test-scrap-cache-tree.c b/t/helper/test-scrap-cache-tree.c
index 15b7688774c..444a4c02c8d 100644
--- a/t/helper/test-scrap-cache-tree.c
+++ b/t/helper/test-scrap-cache-tree.c
@@ -2,6 +2,7 @@
 #include "test-tool.h"
 #include "cache.h"
 #include "lockfile.h"
+#include "repository.h"
 #include "setup.h"
 #include "tree.h"
 #include "cache-tree.h"
diff --git a/t/helper/test-submodule-config.c b/t/helper/test-submodule-config.c
index c7c7fdbea98..8b1969ea48d 100644
--- a/t/helper/test-submodule-config.c
+++ b/t/helper/test-submodule-config.c
@@ -1,6 +1,7 @@
 #include "test-tool.h"
 #include "config.h"
 #include "object-name.h"
+#include "repository.h"
 #include "setup.h"
 #include "submodule-config.h"
 #include "submodule.h"
diff --git a/t/helper/test-submodule-nested-repo-config.c b/t/helper/test-submodule-nested-repo-config.c
index d31f5e48ab5..ecd40ded995 100644
--- a/t/helper/test-submodule-nested-repo-config.c
+++ b/t/helper/test-submodule-nested-repo-config.c
@@ -1,4 +1,5 @@
 #include "test-tool.h"
+#include "repository.h"
 #include "setup.h"
 #include "submodule-config.h"
 
diff --git a/t/helper/test-submodule.c b/t/helper/test-submodule.c
index 0e34581b209..cad8b0ca681 100644
--- a/t/helper/test-submodule.c
+++ b/t/helper/test-submodule.c
@@ -2,6 +2,7 @@
 #include "test-tool-utils.h"
 #include "parse-options.h"
 #include "remote.h"
+#include "repository.h"
 #include "setup.h"
 #include "submodule-config.h"
 #include "submodule.h"
diff --git a/t/helper/test-trace2.c b/t/helper/test-trace2.c
index a476df6c6cb..ab084d6034e 100644
--- a/t/helper/test-trace2.c
+++ b/t/helper/test-trace2.c
@@ -3,6 +3,7 @@
 #include "run-command.h"
 #include "exec-cmd.h"
 #include "config.h"
+#include "repository.h"
 #include "trace2.h"
 
 typedef int(fn_unit_test)(int argc, const char **argv);
diff --git a/t/helper/test-write-cache.c b/t/helper/test-write-cache.c
index a93417ed3a9..eace08072d7 100644
--- a/t/helper/test-write-cache.c
+++ b/t/helper/test-write-cache.c
@@ -2,6 +2,7 @@
 #include "test-tool.h"
 #include "cache.h"
 #include "lockfile.h"
+#include "repository.h"
 #include "setup.h"
 
 int cmd__write_cache(int argc, const char **argv)
diff --git a/trace2.c b/trace2.c
index 21264df71b7..0efc4e7b958 100644
--- a/trace2.c
+++ b/trace2.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "json-writer.h"
 #include "quote.h"
+#include "repository.h"
 #include "run-command.h"
 #include "sigchain.h"
 #include "thread-utils.h"
diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index 9e7aab6d510..2af53e5d4de 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "config.h"
 #include "json-writer.h"
+#include "repository.h"
 #include "run-command.h"
 #include "version.h"
 #include "trace2/tr2_dst.h"
diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index 8672c2c2d04..1ebfb464d54 100644
--- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "config.h"
+#include "repository.h"
 #include "run-command.h"
 #include "quote.h"
 #include "version.h"
diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index 3f2b2d53118..328e483a05e 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "config.h"
+#include "repository.h"
 #include "run-command.h"
 #include "quote.h"
 #include "version.h"
diff --git a/tree-walk.h b/tree-walk.h
index 25fe27e3529..1a3a1b8d4b1 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -4,6 +4,7 @@
 #include "hash.h"
 
 struct index_state;
+struct repository;
 
 #define MAX_TRAVERSE_TREES 8
 
diff --git a/tree.h b/tree.h
index 6efff003e21..0499ad01aa7 100644
--- a/tree.h
+++ b/tree.h
@@ -3,6 +3,7 @@
 
 #include "object.h"
 
+struct pathspec;
 struct repository;
 struct strbuf;
 
diff --git a/wrapper.c b/wrapper.c
index e80f83498d8..5ab0460de5c 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -5,6 +5,7 @@
 #include "abspath.h"
 #include "config.h"
 #include "gettext.h"
+#include "repository.h"
 #include "strbuf.h"
 #include "trace2.h"
 #include "wrapper.h"
-- 
gitgitgadget


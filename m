Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F98C7618E
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 20:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjDVUSY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 16:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjDVURx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 16:17:53 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1378F26B3
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:46 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f19a7f9424so7030815e9.2
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682194664; x=1684786664;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=popZ6xrYqZgSo+EsmD+9fjLRrrNLD3ldxdFcUo2c4Cw=;
        b=NAewMaxWZ1WdkAqWZhhRTIn4ErZETAtzYa0urQpMe3g0zL/8OobuftkymmwFzZbOD6
         ED17rM3laGRBy6ekAvjvDjlvTiwXZ7qbNuj/4JLjZ4RY0SX7LAEqOweXyiPyGNbxW+Og
         oRp2XOVfLaq6B9LQmrQaDODRtrqbhuFV2E498gxZJ+9GPyz8xIKo346sDPeG09FPoiee
         RO2I1uNYB80tls9ivewS6rqwNs6v0eKC1rYmlKVLk9xxbIQ1aybRqw6uLbwASPpPEppn
         4n8OVK0/pA3ENOWJtTQ5eI8Lu6qjA+e4jHyZB5s53vUhlbLxHyL05VwB6uQo+P2wLaTq
         Xq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682194664; x=1684786664;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=popZ6xrYqZgSo+EsmD+9fjLRrrNLD3ldxdFcUo2c4Cw=;
        b=TZYNwOrpPZNpjd4m4YJT4ropBoiNAIuiYfStrxD2HvEWgpr1W/ieUWM3HtY1MQUP5u
         0xHMPvxEiI717yBmAetEnVJVlsL5sKPxyahwfVdxPNlW3qwtmXezC5Vy0uz4hrhrYkhl
         vN74g07kwMQgAdzYpTlIKTXLSzip3uiyQOD+is3BFuSdt5TpFAxF+u0zwhhVU6IqjhXr
         izuewzjiUKvV+ccKYBuhRCmCq4bYeh+qiSmyXHDE2gcT4zXBmEsUtBGgqPY/UVUHH4XA
         qiCZamyH+JG4J9xZ8LuJ4TwbKn8fN+UvNM6h4clShHBNGJkEUllY0fDVmGuLWz92kQq7
         oy2g==
X-Gm-Message-State: AAQBX9dUKRbSgzlu3UCzodvl3iL71JfHRpIubJV6AC+uLQVx/N/GIRDs
        fxVvzsrHTssGRU+o9kK0wWhovStwnuM=
X-Google-Smtp-Source: AKy350aziLa8KJpn47jNQ2yCVlVJbFrEv7W9MGhOtoRHEKDERhi1MnnjnioMlM8IyWq5CZ2dWK7o7Q==
X-Received: by 2002:a5d:6342:0:b0:2e6:3804:5be with SMTP id b2-20020a5d6342000000b002e6380405bemr6398164wrw.59.1682194663476;
        Sat, 22 Apr 2023 13:17:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p6-20020adfe606000000b002ff1751ec79sm7185207wrm.65.2023.04.22.13.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 13:17:43 -0700 (PDT)
Message-Id: <d95f97f5e90da40b285aa8fd678efcff0ae11033.1682194651.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
        <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Apr 2023 20:17:20 +0000
Subject: [PATCH v2 13/22] hash-ll.h: split out of hash.h to remove dependency
 on repository.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

hash.h depends upon and includes repository.h, due to the definition and
use of the_hash_algo (defined as the_repository->hash_algo).  However,
most headers trying to include hash.h are only interested in the layout
of the structs like object_id.  Move the parts of hash.h that do not
depend upon repository.h into a new file hash-ll.h (the "low level"
parts of hash.h), and adjust other files to use this new header where
the convenience inline functions aren't needed.

This allows hash.h and object.h to be fairly small, minimal headers.  It
also exposes a lot of hidden dependencies on both path.h (which was
brought in by repository.h) and repository.h (which was previously
implicitly brought in by object.h), so also adjust other files to be
more explicit about what they depend upon.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 alloc.c                                      |   1 +
 apply.h                                      |   2 +-
 branch.c                                     |   1 +
 builtin/apply.c                              |   1 +
 builtin/archive.c                            |   1 +
 builtin/bundle.c                             |   1 +
 builtin/check-attr.c                         |   1 +
 builtin/check-ignore.c                       |   1 +
 builtin/checkout-index.c                     |   1 +
 builtin/clean.c                              |   1 +
 builtin/config.c                             |   1 +
 builtin/credential-cache.c                   |   1 +
 builtin/credential-store.c                   |   1 +
 builtin/for-each-repo.c                      |   2 +
 builtin/help.c                               |   1 +
 builtin/init-db.c                            |   1 +
 builtin/merge-index.c                        |   1 +
 builtin/merge-recursive.c                    |   2 +
 builtin/mv.c                                 |   1 +
 builtin/push.c                               |   1 +
 builtin/read-tree.c                          |   1 +
 builtin/rerere.c                             |   1 +
 builtin/rm.c                                 |   2 +
 builtin/show-branch.c                        |   2 +
 builtin/show-index.c                         |   2 +
 builtin/update-index.c                       |   2 +
 builtin/update-ref.c                         |   2 +
 builtin/upload-archive.c                     |   1 +
 builtin/worktree.c                           |   1 +
 checkout.c                                   |   1 +
 checkout.h                                   |   2 +-
 chunk-format.c                               |   1 +
 chunk-format.h                               |   2 +-
 common-main.c                                |   1 +
 compat/fsmonitor/fsm-ipc-darwin.c            |   1 +
 compat/fsmonitor/fsm-ipc-win32.c             |   1 +
 compat/precompose_utf8.c                     |   1 +
 compat/win32/trace2_win32_process_info.c     |   1 +
 convert.h                                    |   2 +-
 copy.c                                       |   1 +
 csum-file.c                                  |   1 +
 csum-file.h                                  |   2 +-
 daemon.c                                     |   1 +
 diffcore.h                                   |   2 +-
 editor.c                                     |   1 +
 exec-cmd.c                                   |   1 +
 fsmonitor-ipc.c                              |   1 +
 gpg-interface.c                              |   1 +
 hash-ll.h                                    | 276 +++++++++++++++++++
 hash-lookup.c                                |   1 +
 hash.h                                       | 273 +-----------------
 hashmap.h                                    |   2 +-
 hex.c                                        |   1 +
 hex.h                                        |   2 +-
 hook.c                                       |   1 +
 khash.h                                      |   1 +
 ls-refs.c                                    |   1 +
 merge-ort-wrappers.c                         |   1 +
 merge-ort.h                                  |   2 +-
 negotiator/default.c                         |   1 +
 negotiator/skipping.c                        |   1 +
 object-file.h                                |   2 +
 object.h                                     |   3 +-
 oidmap.c                                     |   1 +
 oidtree.h                                    |   2 +-
 parallel-checkout.c                          |   1 +
 pathspec.c                                   |   1 +
 progress.c                                   |   1 +
 protocol-caps.c                              |   2 +-
 rebase-interactive.c                         |   1 +
 refs/files-backend.c                         |   1 +
 refs/packed-backend.c                        |   1 +
 refs/ref-cache.c                             |   2 +
 refs/ref-cache.h                             |   3 +-
 refspec.c                                    |   1 +
 reftable/dump.c                              |   2 +-
 reftable/system.h                            |   2 +-
 reset.h                                      |   2 +-
 resolve-undo.c                               |   1 +
 resolve-undo.h                               |   2 +-
 split-index.c                                |   1 +
 split-index.h                                |   2 +-
 strbuf.c                                     |   1 +
 t/helper/test-bloom.c                        |   1 +
 t/helper/test-cache-tree.c                   |   1 +
 t/helper/test-dump-cache-tree.c              |   2 +
 t/helper/test-dump-fsmonitor.c               |   1 +
 t/helper/test-dump-untracked-cache.c         |   1 +
 t/helper/test-example-decorate.c             |   1 +
 t/helper/test-fsmonitor-client.c             |   1 +
 t/helper/test-lazy-init-name-hash.c          |   1 +
 t/helper/test-match-trees.c                  |   1 +
 t/helper/test-oidmap.c                       |   1 +
 t/helper/test-path-utils.c                   |   1 +
 t/helper/test-read-cache.c                   |   1 +
 t/helper/test-scrap-cache-tree.c             |   1 +
 t/helper/test-submodule-config.c             |   2 +
 t/helper/test-submodule-nested-repo-config.c |   1 +
 t/helper/test-submodule.c                    |   1 +
 t/helper/test-trace2.c                       |   1 +
 t/helper/test-write-cache.c                  |   1 +
 trace2.c                                     |   1 +
 trace2/tr2_tgt_event.c                       |   1 +
 trace2/tr2_tgt_normal.c                      |   1 +
 trace2/tr2_tgt_perf.c                        |   1 +
 tree-walk.h                                  |   3 +-
 tree.h                                       |   1 +
 wrapper.c                                    |   1 +
 xdiff-interface.h                            |   2 +-
 109 files changed, 398 insertions(+), 292 deletions(-)
 create mode 100644 hash-ll.h

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
 
diff --git a/apply.h b/apply.h
index b9f18ce87d1..7cd38b1443c 100644
--- a/apply.h
+++ b/apply.h
@@ -1,7 +1,7 @@
 #ifndef APPLY_H
 #define APPLY_H
 
-#include "hash.h"
+#include "hash-ll.h"
 #include "lockfile.h"
 #include "string-list.h"
 #include "strmap.h"
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
index 9401f1e5e3b..ff2fe8ef125 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -9,6 +9,7 @@
 #include "ident.h"
 #include "parse-options.h"
 #include "urlmatch.h"
+#include "path.h"
 #include "quote.h"
 #include "setup.h"
 #include "worktree.h"
diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
index 508da4c6e4d..0ffacfdd83c 100644
--- a/builtin/credential-cache.c
+++ b/builtin/credential-cache.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "gettext.h"
 #include "parse-options.h"
+#include "path.h"
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
index fa1035405c3..90da9d07744 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -3,9 +3,11 @@
 #include "advice.h"
 #include "commit.h"
 #include "gettext.h"
+#include "hash.h"
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
index d36072252e7..b4589c824c0 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -12,9 +12,11 @@
 #include "dir.h"
 #include "cache-tree.h"
 #include "gettext.h"
+#include "hash.h"
 #include "tree-walk.h"
 #include "object-name.h"
 #include "parse-options.h"
+#include "repository.h"
 #include "string-list.h"
 #include "setup.h"
 #include "submodule.h"
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 20030b75e39..7ef4a642c17 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
+#include "hash.h"
 #include "hex.h"
 #include "pretty.h"
 #include "refs.h"
@@ -10,6 +11,7 @@
 #include "strvec.h"
 #include "object-name.h"
 #include "parse-options.h"
+#include "repository.h"
 #include "dir.h"
 #include "commit-slab.h"
 #include "date.h"
diff --git a/builtin/show-index.c b/builtin/show-index.c
index d4bbbbcd6ce..d839e55335d 100644
--- a/builtin/show-index.c
+++ b/builtin/show-index.c
@@ -1,9 +1,11 @@
 #include "builtin.h"
 #include "cache.h"
 #include "gettext.h"
+#include "hash.h"
 #include "hex.h"
 #include "pack.h"
 #include "parse-options.h"
+#include "repository.h"
 
 static const char *const show_index_usage[] = {
 	"git show-index [--object-format=<hash-algorithm>]",
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 58bbc80db77..5fab9ad2ec4 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -9,6 +9,7 @@
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
+#include "hash.h"
 #include "hex.h"
 #include "lockfile.h"
 #include "quote.h"
@@ -21,6 +22,7 @@
 #include "parse-options.h"
 #include "pathspec.h"
 #include "dir.h"
+#include "repository.h"
 #include "setup.h"
 #include "split-index.h"
 #include "symlinks.h"
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 6ca85420c3b..0c59b1c9eff 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -1,11 +1,13 @@
 #include "cache.h"
 #include "config.h"
 #include "gettext.h"
+#include "hash.h"
 #include "refs.h"
 #include "builtin.h"
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
diff --git a/checkout.h b/checkout.h
index 1917f3b3230..3c514a5ab4f 100644
--- a/checkout.h
+++ b/checkout.h
@@ -1,7 +1,7 @@
 #ifndef CHECKOUT_H
 #define CHECKOUT_H
 
-#include "hash.h"
+#include "hash-ll.h"
 
 /*
  * Check if the branch name uniquely matches a branch name on a remote
diff --git a/chunk-format.c b/chunk-format.c
index 60a73c1b140..e7d613c907e 100644
--- a/chunk-format.c
+++ b/chunk-format.c
@@ -3,6 +3,7 @@
 #include "chunk-format.h"
 #include "csum-file.h"
 #include "gettext.h"
+#include "hash.h"
 #include "trace2.h"
 
 /*
diff --git a/chunk-format.h b/chunk-format.h
index 025c38f938e..c7794e84add 100644
--- a/chunk-format.h
+++ b/chunk-format.h
@@ -1,7 +1,7 @@
 #ifndef CHUNK_FORMAT_H
 #define CHUNK_FORMAT_H
 
-#include "hash.h"
+#include "hash-ll.h"
 
 struct hashfile;
 struct chunkfile;
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
diff --git a/convert.h b/convert.h
index 0a6e4086b8f..d925589444b 100644
--- a/convert.h
+++ b/convert.h
@@ -4,7 +4,7 @@
 #ifndef CONVERT_H
 #define CONVERT_H
 
-#include "hash.h"
+#include "hash-ll.h"
 #include "string-list.h"
 
 struct index_state;
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
index 82ae2973d30..daf9b06dfff 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -10,6 +10,7 @@
 #include "git-compat-util.h"
 #include "progress.h"
 #include "csum-file.h"
+#include "hash.h"
 #include "wrapper.h"
 
 static void verify_buffer_or_die(struct hashfile *f,
diff --git a/csum-file.h b/csum-file.h
index 566e05cbd25..bc5bec27acb 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -1,7 +1,7 @@
 #ifndef CSUM_FILE_H
 #define CSUM_FILE_H
 
-#include "hash.h"
+#include "hash-ll.h"
 #include "write-or-die.h"
 
 struct progress;
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
diff --git a/diffcore.h b/diffcore.h
index 1701ed50b9c..5ffe4ec788f 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -4,7 +4,7 @@
 #ifndef DIFFCORE_H
 #define DIFFCORE_H
 
-#include "hash.h"
+#include "hash-ll.h"
 
 struct diff_options;
 struct mem_pool;
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
diff --git a/hash-ll.h b/hash-ll.h
new file mode 100644
index 00000000000..80509251370
--- /dev/null
+++ b/hash-ll.h
@@ -0,0 +1,276 @@
+#ifndef HASH_LL_H
+#define HASH_LL_H
+
+#if defined(SHA1_APPLE)
+#include <CommonCrypto/CommonDigest.h>
+#elif defined(SHA1_OPENSSL)
+#include <openssl/sha.h>
+#elif defined(SHA1_DC)
+#include "sha1dc_git.h"
+#else /* SHA1_BLK */
+#include "block-sha1/sha1.h"
+#endif
+
+#if defined(SHA256_NETTLE)
+#include "sha256/nettle.h"
+#elif defined(SHA256_GCRYPT)
+#define SHA256_NEEDS_CLONE_HELPER
+#include "sha256/gcrypt.h"
+#elif defined(SHA256_OPENSSL)
+#include <openssl/sha.h>
+#else
+#include "sha256/block/sha256.h"
+#endif
+
+#ifndef platform_SHA_CTX
+/*
+ * platform's underlying implementation of SHA-1; could be OpenSSL,
+ * blk_SHA, Apple CommonCrypto, etc...  Note that the relevant
+ * SHA-1 header may have already defined platform_SHA_CTX for our
+ * own implementations like block-sha1, so we list
+ * the default for OpenSSL compatible SHA-1 implementations here.
+ */
+#define platform_SHA_CTX	SHA_CTX
+#define platform_SHA1_Init	SHA1_Init
+#define platform_SHA1_Update	SHA1_Update
+#define platform_SHA1_Final    	SHA1_Final
+#endif
+
+#define git_SHA_CTX		platform_SHA_CTX
+#define git_SHA1_Init		platform_SHA1_Init
+#define git_SHA1_Update		platform_SHA1_Update
+#define git_SHA1_Final		platform_SHA1_Final
+
+#ifndef platform_SHA256_CTX
+#define platform_SHA256_CTX	SHA256_CTX
+#define platform_SHA256_Init	SHA256_Init
+#define platform_SHA256_Update	SHA256_Update
+#define platform_SHA256_Final	SHA256_Final
+#endif
+
+#define git_SHA256_CTX		platform_SHA256_CTX
+#define git_SHA256_Init		platform_SHA256_Init
+#define git_SHA256_Update	platform_SHA256_Update
+#define git_SHA256_Final	platform_SHA256_Final
+
+#ifdef platform_SHA256_Clone
+#define git_SHA256_Clone	platform_SHA256_Clone
+#endif
+
+#ifdef SHA1_MAX_BLOCK_SIZE
+#include "compat/sha1-chunked.h"
+#undef git_SHA1_Update
+#define git_SHA1_Update		git_SHA1_Update_Chunked
+#endif
+
+static inline void git_SHA1_Clone(git_SHA_CTX *dst, const git_SHA_CTX *src)
+{
+	memcpy(dst, src, sizeof(*dst));
+}
+
+#ifndef SHA256_NEEDS_CLONE_HELPER
+static inline void git_SHA256_Clone(git_SHA256_CTX *dst, const git_SHA256_CTX *src)
+{
+	memcpy(dst, src, sizeof(*dst));
+}
+#endif
+
+/*
+ * Note that these constants are suitable for indexing the hash_algos array and
+ * comparing against each other, but are otherwise arbitrary, so they should not
+ * be exposed to the user or serialized to disk.  To know whether a
+ * git_hash_algo struct points to some usable hash function, test the format_id
+ * field for being non-zero.  Use the name field for user-visible situations and
+ * the format_id field for fixed-length fields on disk.
+ */
+/* An unknown hash function. */
+#define GIT_HASH_UNKNOWN 0
+/* SHA-1 */
+#define GIT_HASH_SHA1 1
+/* SHA-256  */
+#define GIT_HASH_SHA256 2
+/* Number of algorithms supported (including unknown). */
+#define GIT_HASH_NALGOS (GIT_HASH_SHA256 + 1)
+
+/* "sha1", big-endian */
+#define GIT_SHA1_FORMAT_ID 0x73686131
+
+/* The length in bytes and in hex digits of an object name (SHA-1 value). */
+#define GIT_SHA1_RAWSZ 20
+#define GIT_SHA1_HEXSZ (2 * GIT_SHA1_RAWSZ)
+/* The block size of SHA-1. */
+#define GIT_SHA1_BLKSZ 64
+
+/* "s256", big-endian */
+#define GIT_SHA256_FORMAT_ID 0x73323536
+
+/* The length in bytes and in hex digits of an object name (SHA-256 value). */
+#define GIT_SHA256_RAWSZ 32
+#define GIT_SHA256_HEXSZ (2 * GIT_SHA256_RAWSZ)
+/* The block size of SHA-256. */
+#define GIT_SHA256_BLKSZ 64
+
+/* The length in byte and in hex digits of the largest possible hash value. */
+#define GIT_MAX_RAWSZ GIT_SHA256_RAWSZ
+#define GIT_MAX_HEXSZ GIT_SHA256_HEXSZ
+/* The largest possible block size for any supported hash. */
+#define GIT_MAX_BLKSZ GIT_SHA256_BLKSZ
+
+struct object_id {
+	unsigned char hash[GIT_MAX_RAWSZ];
+	int algo;	/* XXX requires 4-byte alignment */
+};
+
+#define GET_OID_QUIETLY           01
+#define GET_OID_COMMIT            02
+#define GET_OID_COMMITTISH        04
+#define GET_OID_TREE             010
+#define GET_OID_TREEISH          020
+#define GET_OID_BLOB             040
+#define GET_OID_FOLLOW_SYMLINKS 0100
+#define GET_OID_RECORD_PATH     0200
+#define GET_OID_ONLY_TO_DIE    04000
+#define GET_OID_REQUIRE_PATH  010000
+
+#define GET_OID_DISAMBIGUATORS \
+	(GET_OID_COMMIT | GET_OID_COMMITTISH | \
+	GET_OID_TREE | GET_OID_TREEISH | \
+	GET_OID_BLOB)
+
+enum get_oid_result {
+	FOUND = 0,
+	MISSING_OBJECT = -1, /* The requested object is missing */
+	SHORT_NAME_AMBIGUOUS = -2,
+	/* The following only apply when symlinks are followed */
+	DANGLING_SYMLINK = -4, /*
+				* The initial symlink is there, but
+				* (transitively) points to a missing
+				* in-tree file
+				*/
+	SYMLINK_LOOP = -5,
+	NOT_DIR = -6, /*
+		       * Somewhere along the symlink chain, a path is
+		       * requested which contains a file as a
+		       * non-final element.
+		       */
+};
+
+/* A suitably aligned type for stack allocations of hash contexts. */
+union git_hash_ctx {
+	git_SHA_CTX sha1;
+	git_SHA256_CTX sha256;
+};
+typedef union git_hash_ctx git_hash_ctx;
+
+typedef void (*git_hash_init_fn)(git_hash_ctx *ctx);
+typedef void (*git_hash_clone_fn)(git_hash_ctx *dst, const git_hash_ctx *src);
+typedef void (*git_hash_update_fn)(git_hash_ctx *ctx, const void *in, size_t len);
+typedef void (*git_hash_final_fn)(unsigned char *hash, git_hash_ctx *ctx);
+typedef void (*git_hash_final_oid_fn)(struct object_id *oid, git_hash_ctx *ctx);
+
+struct git_hash_algo {
+	/*
+	 * The name of the algorithm, as appears in the config file and in
+	 * messages.
+	 */
+	const char *name;
+
+	/* A four-byte version identifier, used in pack indices. */
+	uint32_t format_id;
+
+	/* The length of the hash in binary. */
+	size_t rawsz;
+
+	/* The length of the hash in hex characters. */
+	size_t hexsz;
+
+	/* The block size of the hash. */
+	size_t blksz;
+
+	/* The hash initialization function. */
+	git_hash_init_fn init_fn;
+
+	/* The hash context cloning function. */
+	git_hash_clone_fn clone_fn;
+
+	/* The hash update function. */
+	git_hash_update_fn update_fn;
+
+	/* The hash finalization function. */
+	git_hash_final_fn final_fn;
+
+	/* The hash finalization function for object IDs. */
+	git_hash_final_oid_fn final_oid_fn;
+
+	/* The OID of the empty tree. */
+	const struct object_id *empty_tree;
+
+	/* The OID of the empty blob. */
+	const struct object_id *empty_blob;
+
+	/* The all-zeros OID. */
+	const struct object_id *null_oid;
+};
+extern const struct git_hash_algo hash_algos[GIT_HASH_NALGOS];
+
+/*
+ * Return a GIT_HASH_* constant based on the name.  Returns GIT_HASH_UNKNOWN if
+ * the name doesn't match a known algorithm.
+ */
+int hash_algo_by_name(const char *name);
+/* Identical, except based on the format ID. */
+int hash_algo_by_id(uint32_t format_id);
+/* Identical, except based on the length. */
+int hash_algo_by_length(int len);
+/* Identical, except for a pointer to struct git_hash_algo. */
+static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
+{
+	return p - hash_algos;
+}
+
+const struct object_id *null_oid(void);
+
+static inline int hashcmp_algop(const unsigned char *sha1, const unsigned char *sha2, const struct git_hash_algo *algop)
+{
+	/*
+	 * Teach the compiler that there are only two possibilities of hash size
+	 * here, so that it can optimize for this case as much as possible.
+	 */
+	if (algop->rawsz == GIT_MAX_RAWSZ)
+		return memcmp(sha1, sha2, GIT_MAX_RAWSZ);
+	return memcmp(sha1, sha2, GIT_SHA1_RAWSZ);
+}
+
+static inline int hasheq_algop(const unsigned char *sha1, const unsigned char *sha2, const struct git_hash_algo *algop)
+{
+	/*
+	 * We write this here instead of deferring to hashcmp so that the
+	 * compiler can properly inline it and avoid calling memcmp.
+	 */
+	if (algop->rawsz == GIT_MAX_RAWSZ)
+		return !memcmp(sha1, sha2, GIT_MAX_RAWSZ);
+	return !memcmp(sha1, sha2, GIT_SHA1_RAWSZ);
+}
+
+static inline void oidcpy(struct object_id *dst, const struct object_id *src)
+{
+	memcpy(dst->hash, src->hash, GIT_MAX_RAWSZ);
+	dst->algo = src->algo;
+}
+
+static inline struct object_id *oiddup(const struct object_id *src)
+{
+	struct object_id *dst = xmalloc(sizeof(struct object_id));
+	oidcpy(dst, src);
+	return dst;
+}
+
+static inline void oid_set_algo(struct object_id *oid, const struct git_hash_algo *algop)
+{
+	oid->algo = hash_algo_by_ptr(algop);
+}
+
+const char *empty_tree_oid_hex(void);
+const char *empty_blob_oid_hex(void);
+
+#endif
diff --git a/hash-lookup.c b/hash-lookup.c
index b98ed5e11e8..bb54dfde9c7 100644
--- a/hash-lookup.c
+++ b/hash-lookup.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "hash.h"
 #include "hash-lookup.h"
 
 static uint32_t take2(const struct object_id *oid, size_t ofs)
diff --git a/hash.h b/hash.h
index d39f73618cb..615ae0691d0 100644
--- a/hash.h
+++ b/hash.h
@@ -1,250 +1,11 @@
 #ifndef HASH_H
 #define HASH_H
 
+#include "hash-ll.h"
 #include "repository.h"
 
-#if defined(SHA1_APPLE)
-#include <CommonCrypto/CommonDigest.h>
-#elif defined(SHA1_OPENSSL)
-#include <openssl/sha.h>
-#elif defined(SHA1_DC)
-#include "sha1dc_git.h"
-#else /* SHA1_BLK */
-#include "block-sha1/sha1.h"
-#endif
-
-#if defined(SHA256_NETTLE)
-#include "sha256/nettle.h"
-#elif defined(SHA256_GCRYPT)
-#define SHA256_NEEDS_CLONE_HELPER
-#include "sha256/gcrypt.h"
-#elif defined(SHA256_OPENSSL)
-#include <openssl/sha.h>
-#else
-#include "sha256/block/sha256.h"
-#endif
-
-#ifndef platform_SHA_CTX
-/*
- * platform's underlying implementation of SHA-1; could be OpenSSL,
- * blk_SHA, Apple CommonCrypto, etc...  Note that the relevant
- * SHA-1 header may have already defined platform_SHA_CTX for our
- * own implementations like block-sha1, so we list
- * the default for OpenSSL compatible SHA-1 implementations here.
- */
-#define platform_SHA_CTX	SHA_CTX
-#define platform_SHA1_Init	SHA1_Init
-#define platform_SHA1_Update	SHA1_Update
-#define platform_SHA1_Final    	SHA1_Final
-#endif
-
-#define git_SHA_CTX		platform_SHA_CTX
-#define git_SHA1_Init		platform_SHA1_Init
-#define git_SHA1_Update		platform_SHA1_Update
-#define git_SHA1_Final		platform_SHA1_Final
-
-#ifndef platform_SHA256_CTX
-#define platform_SHA256_CTX	SHA256_CTX
-#define platform_SHA256_Init	SHA256_Init
-#define platform_SHA256_Update	SHA256_Update
-#define platform_SHA256_Final	SHA256_Final
-#endif
-
-#define git_SHA256_CTX		platform_SHA256_CTX
-#define git_SHA256_Init		platform_SHA256_Init
-#define git_SHA256_Update	platform_SHA256_Update
-#define git_SHA256_Final	platform_SHA256_Final
-
-#ifdef platform_SHA256_Clone
-#define git_SHA256_Clone	platform_SHA256_Clone
-#endif
-
-#ifdef SHA1_MAX_BLOCK_SIZE
-#include "compat/sha1-chunked.h"
-#undef git_SHA1_Update
-#define git_SHA1_Update		git_SHA1_Update_Chunked
-#endif
-
-static inline void git_SHA1_Clone(git_SHA_CTX *dst, const git_SHA_CTX *src)
-{
-	memcpy(dst, src, sizeof(*dst));
-}
-
-#ifndef SHA256_NEEDS_CLONE_HELPER
-static inline void git_SHA256_Clone(git_SHA256_CTX *dst, const git_SHA256_CTX *src)
-{
-	memcpy(dst, src, sizeof(*dst));
-}
-#endif
-
-/*
- * Note that these constants are suitable for indexing the hash_algos array and
- * comparing against each other, but are otherwise arbitrary, so they should not
- * be exposed to the user or serialized to disk.  To know whether a
- * git_hash_algo struct points to some usable hash function, test the format_id
- * field for being non-zero.  Use the name field for user-visible situations and
- * the format_id field for fixed-length fields on disk.
- */
-/* An unknown hash function. */
-#define GIT_HASH_UNKNOWN 0
-/* SHA-1 */
-#define GIT_HASH_SHA1 1
-/* SHA-256  */
-#define GIT_HASH_SHA256 2
-/* Number of algorithms supported (including unknown). */
-#define GIT_HASH_NALGOS (GIT_HASH_SHA256 + 1)
-
-/* "sha1", big-endian */
-#define GIT_SHA1_FORMAT_ID 0x73686131
-
-/* The length in bytes and in hex digits of an object name (SHA-1 value). */
-#define GIT_SHA1_RAWSZ 20
-#define GIT_SHA1_HEXSZ (2 * GIT_SHA1_RAWSZ)
-/* The block size of SHA-1. */
-#define GIT_SHA1_BLKSZ 64
-
-/* "s256", big-endian */
-#define GIT_SHA256_FORMAT_ID 0x73323536
-
-/* The length in bytes and in hex digits of an object name (SHA-256 value). */
-#define GIT_SHA256_RAWSZ 32
-#define GIT_SHA256_HEXSZ (2 * GIT_SHA256_RAWSZ)
-/* The block size of SHA-256. */
-#define GIT_SHA256_BLKSZ 64
-
-/* The length in byte and in hex digits of the largest possible hash value. */
-#define GIT_MAX_RAWSZ GIT_SHA256_RAWSZ
-#define GIT_MAX_HEXSZ GIT_SHA256_HEXSZ
-/* The largest possible block size for any supported hash. */
-#define GIT_MAX_BLKSZ GIT_SHA256_BLKSZ
-
-struct object_id {
-	unsigned char hash[GIT_MAX_RAWSZ];
-	int algo;	/* XXX requires 4-byte alignment */
-};
-
-#define GET_OID_QUIETLY           01
-#define GET_OID_COMMIT            02
-#define GET_OID_COMMITTISH        04
-#define GET_OID_TREE             010
-#define GET_OID_TREEISH          020
-#define GET_OID_BLOB             040
-#define GET_OID_FOLLOW_SYMLINKS 0100
-#define GET_OID_RECORD_PATH     0200
-#define GET_OID_ONLY_TO_DIE    04000
-#define GET_OID_REQUIRE_PATH  010000
-
-#define GET_OID_DISAMBIGUATORS \
-	(GET_OID_COMMIT | GET_OID_COMMITTISH | \
-	GET_OID_TREE | GET_OID_TREEISH | \
-	GET_OID_BLOB)
-
-enum get_oid_result {
-	FOUND = 0,
-	MISSING_OBJECT = -1, /* The requested object is missing */
-	SHORT_NAME_AMBIGUOUS = -2,
-	/* The following only apply when symlinks are followed */
-	DANGLING_SYMLINK = -4, /*
-				* The initial symlink is there, but
-				* (transitively) points to a missing
-				* in-tree file
-				*/
-	SYMLINK_LOOP = -5,
-	NOT_DIR = -6, /*
-		       * Somewhere along the symlink chain, a path is
-		       * requested which contains a file as a
-		       * non-final element.
-		       */
-};
-
-/* A suitably aligned type for stack allocations of hash contexts. */
-union git_hash_ctx {
-	git_SHA_CTX sha1;
-	git_SHA256_CTX sha256;
-};
-typedef union git_hash_ctx git_hash_ctx;
-
-typedef void (*git_hash_init_fn)(git_hash_ctx *ctx);
-typedef void (*git_hash_clone_fn)(git_hash_ctx *dst, const git_hash_ctx *src);
-typedef void (*git_hash_update_fn)(git_hash_ctx *ctx, const void *in, size_t len);
-typedef void (*git_hash_final_fn)(unsigned char *hash, git_hash_ctx *ctx);
-typedef void (*git_hash_final_oid_fn)(struct object_id *oid, git_hash_ctx *ctx);
-
-struct git_hash_algo {
-	/*
-	 * The name of the algorithm, as appears in the config file and in
-	 * messages.
-	 */
-	const char *name;
-
-	/* A four-byte version identifier, used in pack indices. */
-	uint32_t format_id;
-
-	/* The length of the hash in binary. */
-	size_t rawsz;
-
-	/* The length of the hash in hex characters. */
-	size_t hexsz;
-
-	/* The block size of the hash. */
-	size_t blksz;
-
-	/* The hash initialization function. */
-	git_hash_init_fn init_fn;
-
-	/* The hash context cloning function. */
-	git_hash_clone_fn clone_fn;
-
-	/* The hash update function. */
-	git_hash_update_fn update_fn;
-
-	/* The hash finalization function. */
-	git_hash_final_fn final_fn;
-
-	/* The hash finalization function for object IDs. */
-	git_hash_final_oid_fn final_oid_fn;
-
-	/* The OID of the empty tree. */
-	const struct object_id *empty_tree;
-
-	/* The OID of the empty blob. */
-	const struct object_id *empty_blob;
-
-	/* The all-zeros OID. */
-	const struct object_id *null_oid;
-};
-extern const struct git_hash_algo hash_algos[GIT_HASH_NALGOS];
-
-/*
- * Return a GIT_HASH_* constant based on the name.  Returns GIT_HASH_UNKNOWN if
- * the name doesn't match a known algorithm.
- */
-int hash_algo_by_name(const char *name);
-/* Identical, except based on the format ID. */
-int hash_algo_by_id(uint32_t format_id);
-/* Identical, except based on the length. */
-int hash_algo_by_length(int len);
-/* Identical, except for a pointer to struct git_hash_algo. */
-static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
-{
-	return p - hash_algos;
-}
-
 #define the_hash_algo the_repository->hash_algo
 
-const struct object_id *null_oid(void);
-
-static inline int hashcmp_algop(const unsigned char *sha1, const unsigned char *sha2, const struct git_hash_algo *algop)
-{
-	/*
-	 * Teach the compiler that there are only two possibilities of hash size
-	 * here, so that it can optimize for this case as much as possible.
-	 */
-	if (algop->rawsz == GIT_MAX_RAWSZ)
-		return memcmp(sha1, sha2, GIT_MAX_RAWSZ);
-	return memcmp(sha1, sha2, GIT_SHA1_RAWSZ);
-}
-
 static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
 {
 	return hashcmp_algop(sha1, sha2, the_hash_algo);
@@ -260,17 +21,6 @@ static inline int oidcmp(const struct object_id *oid1, const struct object_id *o
 	return hashcmp_algop(oid1->hash, oid2->hash, algop);
 }
 
-static inline int hasheq_algop(const unsigned char *sha1, const unsigned char *sha2, const struct git_hash_algo *algop)
-{
-	/*
-	 * We write this here instead of deferring to hashcmp so that the
-	 * compiler can properly inline it and avoid calling memcmp.
-	 */
-	if (algop->rawsz == GIT_MAX_RAWSZ)
-		return !memcmp(sha1, sha2, GIT_MAX_RAWSZ);
-	return !memcmp(sha1, sha2, GIT_SHA1_RAWSZ);
-}
-
 static inline int hasheq(const unsigned char *sha1, const unsigned char *sha2)
 {
 	return hasheq_algop(sha1, sha2, the_hash_algo);
@@ -296,12 +46,6 @@ static inline void hashcpy(unsigned char *sha_dst, const unsigned char *sha_src)
 	memcpy(sha_dst, sha_src, the_hash_algo->rawsz);
 }
 
-static inline void oidcpy(struct object_id *dst, const struct object_id *src)
-{
-	memcpy(dst->hash, src->hash, GIT_MAX_RAWSZ);
-	dst->algo = src->algo;
-}
-
 /* Like oidcpy() but zero-pads the unused bytes in dst's hash array. */
 static inline void oidcpy_with_padding(struct object_id *dst,
 				       const struct object_id *src)
@@ -318,13 +62,6 @@ static inline void oidcpy_with_padding(struct object_id *dst,
 	dst->algo = src->algo;
 }
 
-static inline struct object_id *oiddup(const struct object_id *src)
-{
-	struct object_id *dst = xmalloc(sizeof(struct object_id));
-	oidcpy(dst, src);
-	return dst;
-}
-
 static inline void hashclr(unsigned char *hash)
 {
 	memset(hash, 0, the_hash_algo->rawsz);
@@ -362,12 +99,4 @@ static inline int is_empty_tree_oid(const struct object_id *oid)
 	return oideq(oid, the_hash_algo->empty_tree);
 }
 
-static inline void oid_set_algo(struct object_id *oid, const struct git_hash_algo *algop)
-{
-	oid->algo = hash_algo_by_ptr(algop);
-}
-
-const char *empty_tree_oid_hex(void);
-const char *empty_blob_oid_hex(void);
-
 #endif
diff --git a/hashmap.h b/hashmap.h
index 7251687d730..9234b94477b 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -1,7 +1,7 @@
 #ifndef HASHMAP_H
 #define HASHMAP_H
 
-#include "hash.h"
+#include "hash-ll.h"
 
 /*
  * Generic implementation of hash-based key-value mappings.
diff --git a/hex.c b/hex.c
index 0a1bddc1284..7bb440e7940 100644
--- a/hex.c
+++ b/hex.c
@@ -1,4 +1,5 @@
 #include "git-compat-util.h"
+#include "hash.h"
 #include "hex.h"
 
 const signed char hexval_table[256] = {
diff --git a/hex.h b/hex.h
index e2abfc56fae..7df4b3c460e 100644
--- a/hex.h
+++ b/hex.h
@@ -1,7 +1,7 @@
 #ifndef HEX_H
 #define HEX_H
 
-#include "hash.h"
+#include "hash-ll.h"
 
 extern const signed char hexval_table[256];
 static inline unsigned int hexval(unsigned char c)
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
index 85362718c56..56241e6a5c9 100644
--- a/khash.h
+++ b/khash.h
@@ -27,6 +27,7 @@
 #define __AC_KHASH_H
 
 #include "hashmap.h"
+#include "hash.h"
 
 #define AC_VERSION_KHASH_H "0.2.8"
 
diff --git a/ls-refs.c b/ls-refs.c
index b9f3e08ec3d..f385938b64c 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "environment.h"
 #include "gettext.h"
+#include "hash.h"
 #include "hex.h"
 #include "repository.h"
 #include "refs.h"
diff --git a/merge-ort-wrappers.c b/merge-ort-wrappers.c
index c00dfbab1cd..2c47c5a6237 100644
--- a/merge-ort-wrappers.c
+++ b/merge-ort-wrappers.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "gettext.h"
+#include "hash.h"
 #include "merge-ort.h"
 #include "merge-ort-wrappers.h"
 
diff --git a/merge-ort.h b/merge-ort.h
index a994c9a5fcd..ce56ec1a780 100644
--- a/merge-ort.h
+++ b/merge-ort.h
@@ -2,7 +2,7 @@
 #define MERGE_ORT_H
 
 #include "merge-recursive.h"
-#include "hash.h"
+#include "hash-ll.h"
 
 struct commit;
 struct tree;
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
index 96e52e24fb1..5871615feea 100644
--- a/object.h
+++ b/object.h
@@ -1,9 +1,10 @@
 #ifndef OBJECT_H
 #define OBJECT_H
 
-#include "hash.h"
+#include "hash-ll.h"
 
 struct buffer_slab;
+struct repository;
 
 struct parsed_object_pool {
 	struct object **obj_hash;
diff --git a/oidmap.c b/oidmap.c
index 8c1a139c974..8b1bc4dec94 100644
--- a/oidmap.c
+++ b/oidmap.c
@@ -1,4 +1,5 @@
 #include "git-compat-util.h"
+#include "hash.h"
 #include "oidmap.h"
 
 static int oidmap_neq(const void *hashmap_cmp_fn_data UNUSED,
diff --git a/oidtree.h b/oidtree.h
index 77898f510a1..55c83513fdd 100644
--- a/oidtree.h
+++ b/oidtree.h
@@ -2,7 +2,7 @@
 #define OIDTREE_H
 
 #include "cbtree.h"
-#include "hash.h"
+#include "hash-ll.h"
 #include "mem-pool.h"
 
 struct oidtree {
diff --git a/parallel-checkout.c b/parallel-checkout.c
index 7f0569cc930..69d569f3525 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -3,6 +3,7 @@
 #include "config.h"
 #include "entry.h"
 #include "gettext.h"
+#include "hash.h"
 #include "hex.h"
 #include "parallel-checkout.h"
 #include "pkt-line.h"
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
diff --git a/protocol-caps.c b/protocol-caps.c
index 874bc815b4f..3fe0bc61c3f 100644
--- a/protocol-caps.c
+++ b/protocol-caps.c
@@ -4,7 +4,7 @@
 #include "hex.h"
 #include "pkt-line.h"
 #include "strvec.h"
-#include "hash.h"
+#include "hash-ll.h"
 #include "hex.h"
 #include "object.h"
 #include "object-store.h"
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
index 1128a9af292..bca7b851c5a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3,6 +3,7 @@
 #include "../copy.h"
 #include "../environment.h"
 #include "../gettext.h"
+#include "../hash.h"
 #include "../hex.h"
 #include "../refs.h"
 #include "refs-internal.h"
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 2333ed5a1f7..704424f55c0 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -2,6 +2,7 @@
 #include "../alloc.h"
 #include "../config.h"
 #include "../gettext.h"
+#include "../hash.h"
 #include "../hex.h"
 #include "../refs.h"
 #include "refs-internal.h"
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index dc1ca49c85f..2294c4564fb 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -1,6 +1,8 @@
 #include "../git-compat-util.h"
 #include "../alloc.h"
+#include "../hash.h"
 #include "../refs.h"
+#include "../repository.h"
 #include "refs-internal.h"
 #include "ref-cache.h"
 #include "../iterator.h"
diff --git a/refs/ref-cache.h b/refs/ref-cache.h
index cf4ad9070b9..95c76e27c83 100644
--- a/refs/ref-cache.h
+++ b/refs/ref-cache.h
@@ -1,10 +1,11 @@
 #ifndef REFS_REF_CACHE_H
 #define REFS_REF_CACHE_H
 
-#include "hash.h"
+#include "hash-ll.h"
 
 struct ref_dir;
 struct ref_store;
+struct repository;
 
 /*
  * If this ref_cache is filled lazily, this function is used to load
diff --git a/refspec.c b/refspec.c
index 7b5c305514d..31b61d782c7 100644
--- a/refspec.c
+++ b/refspec.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "alloc.h"
 #include "gettext.h"
+#include "hash.h"
 #include "hex.h"
 #include "strvec.h"
 #include "refs.h"
diff --git a/reftable/dump.c b/reftable/dump.c
index 155953d1b82..ce936b4e188 100644
--- a/reftable/dump.c
+++ b/reftable/dump.c
@@ -7,7 +7,7 @@ https://developers.google.com/open-source/licenses/bsd
 */
 
 #include "git-compat-util.h"
-#include "hash.h"
+#include "hash-ll.h"
 
 #include "reftable-blocksource.h"
 #include "reftable-error.h"
diff --git a/reftable/system.h b/reftable/system.h
index 18f9207dfee..6b74a815143 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -13,7 +13,7 @@ https://developers.google.com/open-source/licenses/bsd
 
 #include "git-compat-util.h"
 #include "strbuf.h"
-#include "hash.h" /* hash ID, sizes.*/
+#include "hash-ll.h" /* hash ID, sizes.*/
 #include "dir.h" /* remove_dir_recursively, for tests.*/
 
 int hash_size(uint32_t id);
diff --git a/reset.h b/reset.h
index a28f81829d8..10708d8ddc0 100644
--- a/reset.h
+++ b/reset.h
@@ -1,7 +1,7 @@
 #ifndef RESET_H
 #define RESET_H
 
-#include "hash.h"
+#include "hash-ll.h"
 #include "repository.h"
 
 #define GIT_REFLOG_ACTION_ENVIRONMENT "GIT_REFLOG_ACTION"
diff --git a/resolve-undo.c b/resolve-undo.c
index e81096e2d45..70a6db526d2 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "dir.h"
+#include "hash.h"
 #include "resolve-undo.h"
 #include "string-list.h"
 
diff --git a/resolve-undo.h b/resolve-undo.h
index d1ea9727712..c5deafc92fe 100644
--- a/resolve-undo.h
+++ b/resolve-undo.h
@@ -6,7 +6,7 @@ struct index_state;
 struct pathspec;
 struct string_list;
 
-#include "hash.h"
+#include "hash-ll.h"
 
 struct resolve_undo_info {
 	unsigned int mode[3];
diff --git a/split-index.c b/split-index.c
index 3fc4e91485a..40e54760b35 100644
--- a/split-index.c
+++ b/split-index.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "alloc.h"
 #include "gettext.h"
+#include "hash.h"
 #include "mem-pool.h"
 #include "split-index.h"
 #include "strbuf.h"
diff --git a/split-index.h b/split-index.h
index 1a153f47ba3..15a29cd08c9 100644
--- a/split-index.h
+++ b/split-index.h
@@ -1,7 +1,7 @@
 #ifndef SPLIT_INDEX_H
 #define SPLIT_INDEX_H
 
-#include "hash.h"
+#include "hash-ll.h"
 
 struct index_state;
 struct strbuf;
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
index 715aabfbae7..4caf13c663b 100644
--- a/t/helper/test-dump-cache-tree.c
+++ b/t/helper/test-dump-cache-tree.c
@@ -1,9 +1,11 @@
 #define USE_THE_INDEX_VARIABLE
 #include "test-tool.h"
 #include "cache.h"
+#include "hash.h"
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
index c7c7fdbea98..1bacd35a53e 100644
--- a/t/helper/test-submodule-config.c
+++ b/t/helper/test-submodule-config.c
@@ -1,6 +1,8 @@
 #include "test-tool.h"
 #include "config.h"
+#include "hash.h"
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
index 25fe27e3529..01a9d8eb442 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -1,9 +1,10 @@
 #ifndef TREE_WALK_H
 #define TREE_WALK_H
 
-#include "hash.h"
+#include "hash-ll.h"
 
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
diff --git a/xdiff-interface.h b/xdiff-interface.h
index 3750794afe9..733c364d26c 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -1,7 +1,7 @@
 #ifndef XDIFF_INTERFACE_H
 #define XDIFF_INTERFACE_H
 
-#include "hash.h"
+#include "hash-ll.h"
 #include "xdiff/xdiff.h"
 
 /*
-- 
gitgitgadget


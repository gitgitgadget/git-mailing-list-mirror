Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B12C7EE24
	for <git@archiver.kernel.org>; Tue, 16 May 2023 06:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjEPGfL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 02:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjEPGew (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 02:34:52 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4A12118
        for <git@vger.kernel.org>; Mon, 15 May 2023 23:34:34 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3078cc99232so10332339f8f.3
        for <git@vger.kernel.org>; Mon, 15 May 2023 23:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684218872; x=1686810872;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cyo2ScW3BsWLjfmoy2CMI8t+n9UurcJx+gw22uQjvCw=;
        b=mM0Iu8B4L1CNXglIoN8/jfSrDCl+HRJGQq668uZs/PKSCG7SmLehGbw8JM5jFh9nlB
         opgHvY0HPkAzNkDYbkM4+XkVBWKXDK32HvWUDSBR/mR1Z0AirAWgqSlwgClvafwKF95n
         CwurdhTQE3DGYeOWIUWEPePlcLsmU34N5iH6N0aCkwYnhLl7Gmka5C2GbKxvSAAf8iMo
         DthaM9RLOT5/UrYPaxgvgnR07jDjwAyn+pax3GMBWQUS/bdqXDiYTWP0cSMIv8EyCsxU
         b+zGP9075ZnAc54QU1JL2czpaS7NDqUabnRNyiqaDDYDiasjX0No6pHHaHt3dEP4LWky
         BQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684218872; x=1686810872;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cyo2ScW3BsWLjfmoy2CMI8t+n9UurcJx+gw22uQjvCw=;
        b=hTlg5RrpZFpwCQY3qqFUh8hjPGv1J3/8TmqAlB+iDZURd/rGoJFVUlpPsqYTsQwfW8
         EgwLv22rq9v72vwcRnwf/aJOIsi3JZ7cUj7CWF/HkA5hE2fWKyQSRVKPgwSrxUN6OV1a
         ay88iY6kuoaL0gP8HcR4EtMMZJwE5ZDJjE1GaqoKoa+4PCUDx4zSxIOwNItBTFdrD8oj
         IL1GyNYAvDc2+MGSfy4ZjdvMwJ7/2tPF7QP4U4ZM7BhlpEGDVAa/x30i82C8DBSz9Hz7
         wIZHCQqCPfLEzf1BCRuyh0v8QUi+qNGCUQmuA9ORWjgVOGJf7FiiPBm562Pwu/LkK1HC
         wuqg==
X-Gm-Message-State: AC+VfDwqj+SM+sCUjGl4wx+z3Ns4FbJAvB2P/2ah068NgCeV9GuwSlao
        sWHRMg1G5uhHXNnRNg0HUkxPHioSGGM=
X-Google-Smtp-Source: ACHHUZ67o4sechq6od/LWTKrMHSZa+yb/l2uAlnBbs9/wHMZxbcva3vRuYvx0wHBLDuCMPdTA9HOYQ==
X-Received: by 2002:adf:e492:0:b0:306:2dd6:95d3 with SMTP id i18-20020adfe492000000b003062dd695d3mr33525710wrm.22.1684218872454;
        Mon, 15 May 2023 23:34:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g14-20020a5d46ce000000b00304aba2cfcbsm1453187wrs.7.2023.05.15.23.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 23:34:32 -0700 (PDT)
Message-Id: <3e8ae0229275342c2de2143ea665a52f45e7ab4c.1684218852.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com>
References: <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
        <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 May 2023 06:33:59 +0000
Subject: [PATCH v3 19/28] repository: remove unnecessary include of path.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This also made it clear that several .c files that depended upon path.h
were missing a #include for it; add the missing includes while at it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 apply.c                           | 1 +
 archive.c                         | 1 +
 attr.c                            | 1 +
 bisect.c                          | 1 +
 blame.c                           | 1 +
 branch.c                          | 1 +
 builtin/add.c                     | 1 +
 builtin/am.c                      | 1 +
 builtin/bisect.c                  | 1 +
 builtin/branch.c                  | 1 +
 builtin/checkout.c                | 1 +
 builtin/clean.c                   | 1 +
 builtin/clone.c                   | 1 +
 builtin/commit.c                  | 1 +
 builtin/count-objects.c           | 1 +
 builtin/fast-import.c             | 1 +
 builtin/fetch.c                   | 1 +
 builtin/fsck.c                    | 1 +
 builtin/gc.c                      | 1 +
 builtin/grep.c                    | 1 +
 builtin/ls-files.c                | 1 +
 builtin/ls-tree.c                 | 1 +
 builtin/merge.c                   | 1 +
 builtin/notes.c                   | 1 +
 builtin/prune.c                   | 1 +
 builtin/pull.c                    | 1 +
 builtin/rebase.c                  | 1 +
 builtin/receive-pack.c            | 1 +
 builtin/remote.c                  | 1 +
 builtin/repack.c                  | 1 +
 builtin/replace.c                 | 1 +
 builtin/reset.c                   | 1 +
 builtin/rev-parse.c               | 1 +
 builtin/submodule--helper.c       | 1 +
 builtin/tag.c                     | 1 +
 builtin/upload-archive.c          | 1 +
 builtin/upload-pack.c             | 1 +
 builtin/worktree.c                | 1 +
 commit-graph.c                    | 1 +
 compat/fsmonitor/fsm-ipc-darwin.c | 1 +
 config.c                          | 1 +
 connect.c                         | 1 +
 dir.c                             | 1 +
 environment.c                     | 1 +
 fetch-pack.c                      | 1 +
 fsck.c                            | 1 +
 http-backend.c                    | 1 +
 merge-ort.c                       | 1 +
 merge-recursive.c                 | 1 +
 notes-merge.c                     | 1 +
 object-file.c                     | 1 +
 pack-bitmap-write.c               | 1 +
 pack-write.c                      | 1 +
 read-cache.c                      | 1 +
 refs.c                            | 1 +
 refs/files-backend.c              | 1 +
 remote.c                          | 1 +
 repository.c                      | 1 +
 repository.h                      | 2 --
 rerere.c                          | 1 +
 sequencer.c                       | 1 +
 server-info.c                     | 1 +
 setup.c                           | 1 +
 shallow.c                         | 1 +
 strbuf.c                          | 1 +
 submodule-config.c                | 1 +
 submodule.c                       | 1 +
 t/helper/test-ref-store.c         | 1 +
 tmp-objdir.c                      | 1 +
 worktree.c                        | 1 +
 wt-status.c                       | 1 +
 71 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/apply.c b/apply.c
index e44a5dd7c50..be58dc08d22 100644
--- a/apply.c
+++ b/apply.c
@@ -27,6 +27,7 @@
 #include "object-name.h"
 #include "object-file.h"
 #include "parse-options.h"
+#include "path.h"
 #include "quote.h"
 #include "read-cache.h"
 #include "rerere.h"
diff --git a/archive.c b/archive.c
index 641baad627b..802a34d6b91 100644
--- a/archive.c
+++ b/archive.c
@@ -6,6 +6,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
+#include "path.h"
 #include "pretty.h"
 #include "setup.h"
 #include "refs.h"
diff --git a/attr.c b/attr.c
index 5a32bfadb37..435b51e11ff 100644
--- a/attr.c
+++ b/attr.c
@@ -14,6 +14,7 @@
 #include "attr.h"
 #include "dir.h"
 #include "gettext.h"
+#include "path.h"
 #include "utf8.h"
 #include "quote.h"
 #include "read-cache-ll.h"
diff --git a/bisect.c b/bisect.c
index 8d5f8e58851..9f7cf0be073 100644
--- a/bisect.c
+++ b/bisect.c
@@ -19,6 +19,7 @@
 #include "commit-reach.h"
 #include "object-name.h"
 #include "object-store.h"
+#include "path.h"
 #include "dir.h"
 
 static struct oid_array good_revs;
diff --git a/blame.c b/blame.c
index 15bbf16057a..b74ee70decf 100644
--- a/blame.c
+++ b/blame.c
@@ -8,6 +8,7 @@
 #include "diffcore.h"
 #include "gettext.h"
 #include "hex.h"
+#include "path.h"
 #include "read-cache.h"
 #include "setup.h"
 #include "tag.h"
diff --git a/branch.c b/branch.c
index 9415ee3f340..1c02078e6aa 100644
--- a/branch.c
+++ b/branch.c
@@ -6,6 +6,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "object-name.h"
+#include "path.h"
 #include "refs.h"
 #include "refspec.h"
 #include "remote.h"
diff --git a/builtin/add.c b/builtin/add.c
index 50792c0d495..43183114487 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -16,6 +16,7 @@
 #include "cache-tree.h"
 #include "run-command.h"
 #include "parse-options.h"
+#include "path.h"
 #include "preload-index.h"
 #include "diff.h"
 #include "diffcore.h"
diff --git a/builtin/am.c b/builtin/am.c
index 2f0f2337915..a78daa69714 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -41,6 +41,7 @@
 #include "string-list.h"
 #include "packfile.h"
 #include "pager.h"
+#include "path.h"
 #include "repository.h"
 #include "pretty.h"
 #include "wrapper.h"
diff --git a/builtin/bisect.c b/builtin/bisect.c
index bce0ee6268a..6478df34890 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -11,6 +11,7 @@
 #include "strvec.h"
 #include "run-command.h"
 #include "oid-array.h"
+#include "path.h"
 #include "prompt.h"
 #include "quote.h"
 #include "revision.h"
diff --git a/builtin/branch.c b/builtin/branch.c
index 5e9b0e4ea44..84f13b0cc71 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -18,6 +18,7 @@
 #include "parse-options.h"
 #include "branch.h"
 #include "diff.h"
+#include "path.h"
 #include "revision.h"
 #include "string-list.h"
 #include "column.h"
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 09b84156492..716dcd4cae1 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -20,6 +20,7 @@
 #include "object-name.h"
 #include "object-store.h"
 #include "parse-options.h"
+#include "path.h"
 #include "preload-index.h"
 #include "read-cache.h"
 #include "refs.h"
diff --git a/builtin/clean.c b/builtin/clean.c
index 66b4479356d..1bb6b7965c5 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -13,6 +13,7 @@
 #include "dir.h"
 #include "gettext.h"
 #include "parse-options.h"
+#include "path.h"
 #include "read-cache-ll.h"
 #include "repository.h"
 #include "setup.h"
diff --git a/builtin/clone.c b/builtin/clone.c
index cc34c194f5e..6c5cb33f6a9 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -39,6 +39,7 @@
 #include "setup.h"
 #include "connected.h"
 #include "packfile.h"
+#include "path.h"
 #include "pkt-line.h"
 #include "list-objects-filter-options.h"
 #include "hook.h"
diff --git a/builtin/commit.c b/builtin/commit.c
index 3b90cb748cd..b3ab5e93844 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -29,6 +29,7 @@
 #include "utf8.h"
 #include "object-name.h"
 #include "parse-options.h"
+#include "path.h"
 #include "preload-index.h"
 #include "read-cache.h"
 #include "string-list.h"
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index b9e6b55a9a9..c9f82d0bce9 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -9,6 +9,7 @@
 #include "dir.h"
 #include "environment.h"
 #include "gettext.h"
+#include "path.h"
 #include "repository.h"
 #include "parse-options.h"
 #include "quote.h"
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 67a2260a5eb..5698b92ae7d 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -12,6 +12,7 @@
 #include "commit.h"
 #include "delta.h"
 #include "pack.h"
+#include "path.h"
 #include "refs.h"
 #include "csum-file.h"
 #include "quote.h"
diff --git a/builtin/fetch.c b/builtin/fetch.c
index cbc991086cd..4dbacd8f188 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -28,6 +28,7 @@
 #include "utf8.h"
 #include "packfile.h"
 #include "pager.h"
+#include "path.h"
 #include "pkt-line.h"
 #include "list-objects-filter-options.h"
 #include "commit-reach.h"
diff --git a/builtin/fsck.c b/builtin/fsck.c
index f05617ceb14..d707ca32a61 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -21,6 +21,7 @@
 #include "object-file.h"
 #include "object-name.h"
 #include "object-store.h"
+#include "path.h"
 #include "read-cache-ll.h"
 #include "replace-object.h"
 #include "resolve-undo.h"
diff --git a/builtin/gc.c b/builtin/gc.c
index d6e56e380cf..9ecc2513e9f 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -30,6 +30,7 @@
 #include "object-store.h"
 #include "pack.h"
 #include "pack-objects.h"
+#include "path.h"
 #include "blob.h"
 #include "tree.h"
 #include "promisor-remote.h"
diff --git a/builtin/grep.c b/builtin/grep.c
index 7638d779000..6bc8abcd3e1 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -30,6 +30,7 @@
 #include "object-store.h"
 #include "packfile.h"
 #include "pager.h"
+#include "path.h"
 #include "read-cache-ll.h"
 #include "write-or-die.h"
 
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index a49c43864f7..ab90f821e44 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -19,6 +19,7 @@
 #include "parse-options.h"
 #include "resolve-undo.h"
 #include "string-list.h"
+#include "path.h"
 #include "pathspec.h"
 #include "read-cache.h"
 #include "run-command.h"
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index f4331c640fc..c06858de4bf 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -12,6 +12,7 @@
 #include "blob.h"
 #include "tree.h"
 #include "commit.h"
+#include "path.h"
 #include "quote.h"
 #include "parse-options.h"
 #include "pathspec.h"
diff --git a/builtin/merge.c b/builtin/merge.c
index d7ac108ce94..420e81008ed 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -27,6 +27,7 @@
 #include "refspec.h"
 #include "commit.h"
 #include "diffcore.h"
+#include "path.h"
 #include "revision.h"
 #include "unpack-trees.h"
 #include "cache-tree.h"
diff --git a/builtin/notes.c b/builtin/notes.c
index efdf2451486..0a870d90836 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -15,6 +15,7 @@
 #include "notes.h"
 #include "object-name.h"
 #include "object-store.h"
+#include "path.h"
 #include "repository.h"
 #include "blob.h"
 #include "pretty.h"
diff --git a/builtin/prune.c b/builtin/prune.c
index b3658b5b512..a46c5aa2b5b 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -7,6 +7,7 @@
 #include "revision.h"
 #include "reachable.h"
 #include "parse-options.h"
+#include "path.h"
 #include "progress.h"
 #include "prune-packed.h"
 #include "replace-object.h"
diff --git a/builtin/pull.c b/builtin/pull.c
index d4261804d76..815f6135189 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -19,6 +19,7 @@
 #include "oid-array.h"
 #include "remote.h"
 #include "dir.h"
+#include "path.h"
 #include "read-cache-ll.h"
 #include "rebase.h"
 #include "refs.h"
diff --git a/builtin/rebase.c b/builtin/rebase.c
index ace1d5e8d11..91849f920f7 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -24,6 +24,7 @@
 #include "object-file.h"
 #include "object-name.h"
 #include "parse-options.h"
+#include "path.h"
 #include "commit.h"
 #include "diff.h"
 #include "wt-status.h"
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 1a31a583674..d1718a3ac90 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -31,6 +31,7 @@
 #include "packfile.h"
 #include "object-name.h"
 #include "object-store.h"
+#include "path.h"
 #include "protocol.h"
 #include "commit-reach.h"
 #include "server-info.h"
diff --git a/builtin/remote.c b/builtin/remote.c
index 1e0b137d977..3794f13330d 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "gettext.h"
 #include "parse-options.h"
+#include "path.h"
 #include "transport.h"
 #include "remote.h"
 #include "string-list.h"
diff --git a/builtin/repack.c b/builtin/repack.c
index 0541c3ce157..fe8d5810d48 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -6,6 +6,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "parse-options.h"
+#include "path.h"
 #include "run-command.h"
 #include "server-info.h"
 #include "sigchain.h"
diff --git a/builtin/replace.c b/builtin/replace.c
index e0fbdc98ed3..6b266a66d30 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -16,6 +16,7 @@
 #include "hex.h"
 #include "refs.h"
 #include "parse-options.h"
+#include "path.h"
 #include "run-command.h"
 #include "object-file.h"
 #include "object-name.h"
diff --git a/builtin/reset.c b/builtin/reset.c
index 3dc41ac3327..f947c449d14 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -26,6 +26,7 @@
 #include "branch.h"
 #include "object-name.h"
 #include "parse-options.h"
+#include "path.h"
 #include "unpack-trees.h"
 #include "cache-tree.h"
 #include "setup.h"
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 8d8c870421d..6eb5965bee4 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -16,6 +16,7 @@
 #include "quote.h"
 #include "object-name.h"
 #include "parse-options.h"
+#include "path.h"
 #include "diff.h"
 #include "read-cache-ll.h"
 #include "revision.h"
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 17567d91c88..6acba4ebb30 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -9,6 +9,7 @@
 #include "config.h"
 #include "parse-options.h"
 #include "quote.h"
+#include "path.h"
 #include "pathspec.h"
 #include "preload-index.h"
 #include "dir.h"
diff --git a/builtin/tag.c b/builtin/tag.c
index ce298d08945..87963d2cc0e 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -16,6 +16,7 @@
 #include "refs.h"
 #include "object-name.h"
 #include "object-store.h"
+#include "path.h"
 #include "tag.h"
 #include "run-command.h"
 #include "parse-options.h"
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index d4c7f162ff0..1b09e5e1aa3 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -3,6 +3,7 @@
  */
 #include "builtin.h"
 #include "archive.h"
+#include "path.h"
 #include "pkt-line.h"
 #include "sideband.h"
 #include "repository.h"
diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
index ba5103a9331..b02d479248a 100644
--- a/builtin/upload-pack.c
+++ b/builtin/upload-pack.c
@@ -3,6 +3,7 @@
 #include "gettext.h"
 #include "pkt-line.h"
 #include "parse-options.h"
+#include "path.h"
 #include "protocol.h"
 #include "replace-object.h"
 #include "upload-pack.h"
diff --git a/builtin/worktree.c b/builtin/worktree.c
index b9a84988637..6ba463f6965 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -10,6 +10,7 @@
 #include "object-file.h"
 #include "object-name.h"
 #include "parse-options.h"
+#include "path.h"
 #include "strvec.h"
 #include "branch.h"
 #include "read-cache-ll.h"
diff --git a/commit-graph.c b/commit-graph.c
index 843bdb458d0..25cbd66c33a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -14,6 +14,7 @@
 #include "object-file.h"
 #include "object-store.h"
 #include "oid-array.h"
+#include "path.h"
 #include "alloc.h"
 #include "hashmap.h"
 #include "replace-object.h"
diff --git a/compat/fsmonitor/fsm-ipc-darwin.c b/compat/fsmonitor/fsm-ipc-darwin.c
index 793073aaa72..964bc074db6 100644
--- a/compat/fsmonitor/fsm-ipc-darwin.c
+++ b/compat/fsmonitor/fsm-ipc-darwin.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "gettext.h"
 #include "hex.h"
+#include "path.h"
 #include "repository.h"
 #include "strbuf.h"
 #include "fsmonitor.h"
diff --git a/config.c b/config.c
index 06e6cc6f1ec..666ec73bab1 100644
--- a/config.c
+++ b/config.c
@@ -27,6 +27,7 @@
 #include "object-name.h"
 #include "object-store.h"
 #include "pager.h"
+#include "path.h"
 #include "utf8.h"
 #include "dir.h"
 #include "color.h"
diff --git a/connect.c b/connect.c
index 3a0186280c4..37674f71122 100644
--- a/connect.c
+++ b/connect.c
@@ -12,6 +12,7 @@
 #include "url.h"
 #include "string-list.h"
 #include "oid-array.h"
+#include "path.h"
 #include "transport.h"
 #include "trace2.h"
 #include "strbuf.h"
diff --git a/dir.c b/dir.c
index 1e84b1e1f28..3cf3d428c7b 100644
--- a/dir.c
+++ b/dir.c
@@ -16,6 +16,7 @@
 #include "name-hash.h"
 #include "object-file.h"
 #include "object-store.h"
+#include "path.h"
 #include "attr.h"
 #include "refs.h"
 #include "wildmatch.h"
diff --git a/environment.c b/environment.c
index 0cdd20a1589..56e8742ea66 100644
--- a/environment.c
+++ b/environment.c
@@ -21,6 +21,7 @@
 #include "strvec.h"
 #include "object-file.h"
 #include "object-store.h"
+#include "path.h"
 #include "replace-object.h"
 #include "tmp-objdir.h"
 #include "chdir-notify.h"
diff --git a/fetch-pack.c b/fetch-pack.c
index 0f71054fbae..207548b3e5a 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -25,6 +25,7 @@
 #include "oidset.h"
 #include "packfile.h"
 #include "object-store.h"
+#include "path.h"
 #include "connected.h"
 #include "fetch-negotiator.h"
 #include "fsck.h"
diff --git a/fsck.c b/fsck.c
index 3261ef9ec28..04e729953b2 100644
--- a/fsck.c
+++ b/fsck.c
@@ -3,6 +3,7 @@
 #include "date.h"
 #include "hex.h"
 #include "object-store.h"
+#include "path.h"
 #include "repository.h"
 #include "object.h"
 #include "attr.h"
diff --git a/http-backend.c b/http-backend.c
index ac146d85c54..ddb9549ecbc 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -4,6 +4,7 @@
 #include "environment.h"
 #include "git-zlib.h"
 #include "hex.h"
+#include "path.h"
 #include "repository.h"
 #include "refs.h"
 #include "pkt-line.h"
diff --git a/merge-ort.c b/merge-ort.c
index c2d2ee73eaa..eed71b04389 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -36,6 +36,7 @@
 #include "object-name.h"
 #include "object-store.h"
 #include "oid-array.h"
+#include "path.h"
 #include "promisor-remote.h"
 #include "read-cache-ll.h"
 #include "revision.h"
diff --git a/merge-recursive.c b/merge-recursive.c
index 4bef9b62fa8..527dbbd010a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -27,6 +27,7 @@
 #include "object-file.h"
 #include "object-name.h"
 #include "object-store.h"
+#include "path.h"
 #include "repository.h"
 #include "revision.h"
 #include "sparse-index.h"
diff --git a/notes-merge.c b/notes-merge.c
index 233e49e3195..4b328d852cd 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -6,6 +6,7 @@
 #include "object-file.h"
 #include "object-name.h"
 #include "object-store.h"
+#include "path.h"
 #include "repository.h"
 #include "diff.h"
 #include "diffcore.h"
diff --git a/object-file.c b/object-file.c
index 7c1af5c8db8..8d87720dd53 100644
--- a/object-file.c
+++ b/object-file.c
@@ -39,6 +39,7 @@
 #include "object-file.h"
 #include "object-store.h"
 #include "oidtree.h"
+#include "path.h"
 #include "promisor-remote.h"
 #include "setup.h"
 #include "submodule.h"
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index cdffe2ce47d..623ee2a8197 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -15,6 +15,7 @@
 #include "pack-bitmap.h"
 #include "hash-lookup.h"
 #include "pack-objects.h"
+#include "path.h"
 #include "commit-reach.h"
 #include "prio-queue.h"
 #include "trace2.h"
diff --git a/pack-write.c b/pack-write.c
index 3b3ce89de6e..45681e2d7db 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -10,6 +10,7 @@
 #include "oidmap.h"
 #include "pack-objects.h"
 #include "pack-revindex.h"
+#include "path.h"
 #include "wrapper.h"
 
 void reset_pack_idx_option(struct pack_idx_option *opts)
diff --git a/read-cache.c b/read-cache.c
index edab96765df..86ada403a83 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -27,6 +27,7 @@
 #include "mem-pool.h"
 #include "name-hash.h"
 #include "object-name.h"
+#include "path.h"
 #include "preload-index.h"
 #include "read-cache.h"
 #include "resolve-undo.h"
diff --git a/refs.c b/refs.c
index d2a98e1c21f..3c0c95ac442 100644
--- a/refs.c
+++ b/refs.c
@@ -19,6 +19,7 @@
 #include "object-name.h"
 #include "object-store.h"
 #include "object.h"
+#include "path.h"
 #include "tag.h"
 #include "submodule.h"
 #include "worktree.h"
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 01c08207619..6fa7decec0a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -15,6 +15,7 @@
 #include "../lockfile.h"
 #include "../object.h"
 #include "../object-file.h"
+#include "../path.h"
 #include "../dir.h"
 #include "../chdir-notify.h"
 #include "../setup.h"
diff --git a/remote.c b/remote.c
index 0764fca0db9..8550056db43 100644
--- a/remote.c
+++ b/remote.c
@@ -11,6 +11,7 @@
 #include "refspec.h"
 #include "object-name.h"
 #include "object-store.h"
+#include "path.h"
 #include "commit.h"
 #include "diff.h"
 #include "revision.h"
diff --git a/repository.c b/repository.c
index 67ec56a70c5..87a7a27b665 100644
--- a/repository.c
+++ b/repository.c
@@ -10,6 +10,7 @@
 #include "config.h"
 #include "object.h"
 #include "lockfile.h"
+#include "path.h"
 #include "read-cache-ll.h"
 #include "remote.h"
 #include "setup.h"
diff --git a/repository.h b/repository.h
index 763794880ed..510aa6d9a2f 100644
--- a/repository.h
+++ b/repository.h
@@ -1,8 +1,6 @@
 #ifndef REPOSITORY_H
 #define REPOSITORY_H
 
-#include "path.h"
-
 struct config_set;
 struct fsmonitor_settings;
 struct git_hash_algo;
diff --git a/rerere.c b/rerere.c
index 2fb93a51125..35b9785d573 100644
--- a/rerere.c
+++ b/rerere.c
@@ -14,6 +14,7 @@
 #include "resolve-undo.h"
 #include "ll-merge.h"
 #include "attr.h"
+#include "path.h"
 #include "pathspec.h"
 #include "object-file.h"
 #include "object-store.h"
diff --git a/sequencer.c b/sequencer.c
index 08bd0e81743..eddd38d4bed 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -23,6 +23,7 @@
 #include "utf8.h"
 #include "cache-tree.h"
 #include "diff.h"
+#include "path.h"
 #include "revision.h"
 #include "rerere.h"
 #include "merge.h"
diff --git a/server-info.c b/server-info.c
index 55aa04f00ab..85d17bbb151 100644
--- a/server-info.c
+++ b/server-info.c
@@ -9,6 +9,7 @@
 #include "commit.h"
 #include "tag.h"
 #include "packfile.h"
+#include "path.h"
 #include "object-file.h"
 #include "object-store.h"
 #include "server-info.h"
diff --git a/setup.c b/setup.c
index 1cc1f3b3978..68041c0dc88 100644
--- a/setup.c
+++ b/setup.c
@@ -12,6 +12,7 @@
 #include "setup.h"
 #include "string-list.h"
 #include "chdir-notify.h"
+#include "path.h"
 #include "promisor-remote.h"
 #include "quote.h"
 #include "trace2.h"
diff --git a/shallow.c b/shallow.c
index f1c93e74648..45343e6a78b 100644
--- a/shallow.c
+++ b/shallow.c
@@ -11,6 +11,7 @@
 #include "remote.h"
 #include "refs.h"
 #include "oid-array.h"
+#include "path.h"
 #include "diff.h"
 #include "revision.h"
 #include "commit-slab.h"
diff --git a/strbuf.c b/strbuf.c
index 08eec8f1d8b..d070e007f8a 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -6,6 +6,7 @@
 #include "hex.h"
 #include "object-name.h"
 #include "refs.h"
+#include "path.h"
 #include "repository.h"
 #include "string-list.h"
 #include "utf8.h"
diff --git a/submodule-config.c b/submodule-config.c
index 58dfbde9ae5..c67260a3e11 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -4,6 +4,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
+#include "path.h"
 #include "repository.h"
 #include "config.h"
 #include "submodule-config.h"
diff --git a/submodule.c b/submodule.c
index 20aa8ed0fb8..245300596ff 100644
--- a/submodule.c
+++ b/submodule.c
@@ -20,6 +20,7 @@
 #include "strvec.h"
 #include "blob.h"
 #include "thread-utils.h"
+#include "path.h"
 #include "quote.h"
 #include "remote.h"
 #include "worktree.h"
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 6d8f844e9c7..1b30a6cba8b 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -4,6 +4,7 @@
 #include "setup.h"
 #include "worktree.h"
 #include "object-store.h"
+#include "path.h"
 #include "repository.h"
 
 struct flag_definition {
diff --git a/tmp-objdir.c b/tmp-objdir.c
index c33a554f921..db1f7038dae 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -5,6 +5,7 @@
 #include "dir.h"
 #include "environment.h"
 #include "object-file.h"
+#include "path.h"
 #include "sigchain.h"
 #include "string-list.h"
 #include "strbuf.h"
diff --git a/worktree.c b/worktree.c
index b5ee71c5ebd..f9aa371ca70 100644
--- a/worktree.c
+++ b/worktree.c
@@ -3,6 +3,7 @@
 #include "alloc.h"
 #include "environment.h"
 #include "gettext.h"
+#include "path.h"
 #include "repository.h"
 #include "refs.h"
 #include "setup.h"
diff --git a/wt-status.c b/wt-status.c
index 6ee8567ac2d..7ada6b305f6 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -9,6 +9,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "object-name.h"
+#include "path.h"
 #include "revision.h"
 #include "diffcore.h"
 #include "quote.h"
-- 
gitgitgadget


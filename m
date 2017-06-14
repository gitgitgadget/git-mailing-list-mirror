Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF6E620282
	for <e@80x24.org>; Wed, 14 Jun 2017 18:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752862AbdFNSHz (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 14:07:55 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35135 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752790AbdFNSHu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 14:07:50 -0400
Received: by mail-pf0-f177.google.com with SMTP id l89so3955757pfi.2
        for <git@vger.kernel.org>; Wed, 14 Jun 2017 11:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KDNPMeFTZ/9SJ/JwdkCJzE/LiBMnmswqUelvfegRodk=;
        b=sjeYNvyGM/oqhhv7jbkdnu5eKj7PQwWt/bRq8RYBS0LezyZQT7gmr4/t43732Fyons
         MKA2BQWUK/hhaCRE0xbsiDVoaezNU6DBB0YCz/NFimjAncTFoBJo3Dn1O9+Q0lkiv9qa
         hJtG2utPcW9N991lIgg9vRnqVfpsGxJTZiHDr2oa7E8v2zjaPeD/5BSps/CWkS6OyBYJ
         0vakzAwpaL1ajgj7VJmPRB1rXWY1H9AMomy0cPlygrcO+Csra5h3a8v88d/me1C94s+F
         TmRzPv8kn3Wg7eXAjIL/K2K0ePSGhgwEJa76Nv3cTdXJdlHEYV7YIx4GS72dIARZM8ZC
         o10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KDNPMeFTZ/9SJ/JwdkCJzE/LiBMnmswqUelvfegRodk=;
        b=FuAXg1DN3w5l1VSGVRWUAJVlaStN+545l2T0AWETZExqkjT3lEIfMGcqoYBUJ/6erv
         1h4GFJeuMwuqCRas/SV/3g/UJxmwwJsYh5lrhrOjeMDo7kz3IWcBAeqE5mUsI/V5uKJr
         lhel/nW/g7s3K76A+ClJfw1w/UDP2my4dmMtcnXEM2RzaisBC8XSbdjhpRB8SELSibnJ
         YrMjMRgNVsocSjL+lQrmsmfKlJLGBp9ElVg0Ob24/S7fiN6voaWM9OH6D/FCnyRRzXPj
         BGOWsyWeDBXhEBeGPS5kjGwk0yXcwUEF/9Ir4iWupUTbyvr8D+ILNCrMeCTYSZZSoddg
         V7mw==
X-Gm-Message-State: AKS2vOzIPAF016svjqhD9dWIJVfGQmNN9JOVB/cP9JT4omTUu69x5Jky
        W4ngqoMfL9TgkzQjsWgS2Q==
X-Received: by 10.84.138.1 with SMTP id 1mr1458106plo.188.1497463668645;
        Wed, 14 Jun 2017 11:07:48 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t2sm1001646pfi.76.2017.06.14.11.07.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Jun 2017 11:07:47 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 3/6] config: don't include config.h by default
Date:   Wed, 14 Jun 2017 11:07:36 -0700
Message-Id: <20170614180739.72193-4-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009-goog
In-Reply-To: <20170614180739.72193-1-bmwill@google.com>
References: <20170613210321.152978-1-bmwill@google.com>
 <20170614180739.72193-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stop including config.h by default in cache.h.  Instead only include
config.h in those files which require use of the config system.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 advice.c                         | 1 +
 alias.c                          | 1 +
 apply.c                          | 1 +
 archive-tar.c                    | 1 +
 archive-zip.c                    | 1 +
 archive.c                        | 1 +
 attr.c                           | 1 +
 bisect.c                         | 1 +
 branch.c                         | 1 +
 builtin/add.c                    | 1 +
 builtin/am.c                     | 1 +
 builtin/blame.c                  | 2 ++
 builtin/branch.c                 | 1 +
 builtin/cat-file.c               | 1 +
 builtin/check-attr.c             | 1 +
 builtin/check-ignore.c           | 1 +
 builtin/check-mailmap.c          | 1 +
 builtin/checkout-index.c         | 1 +
 builtin/checkout.c               | 1 +
 builtin/clean.c                  | 1 +
 builtin/clone.c                  | 1 +
 builtin/column.c                 | 1 +
 builtin/commit-tree.c            | 1 +
 builtin/commit.c                 | 1 +
 builtin/config.c                 | 1 +
 builtin/count-objects.c          | 1 +
 builtin/describe.c               | 1 +
 builtin/diff-files.c             | 1 +
 builtin/diff-index.c             | 1 +
 builtin/diff-tree.c              | 1 +
 builtin/diff.c                   | 1 +
 builtin/difftool.c               | 1 +
 builtin/fast-export.c            | 1 +
 builtin/fetch.c                  | 1 +
 builtin/fmt-merge-msg.c          | 1 +
 builtin/for-each-ref.c           | 1 +
 builtin/fsck.c                   | 1 +
 builtin/gc.c                     | 1 +
 builtin/grep.c                   | 1 +
 builtin/hash-object.c            | 1 +
 builtin/help.c                   | 1 +
 builtin/index-pack.c             | 1 +
 builtin/init-db.c                | 1 +
 builtin/log.c                    | 1 +
 builtin/ls-files.c               | 1 +
 builtin/ls-tree.c                | 1 +
 builtin/merge-base.c             | 1 +
 builtin/merge-file.c             | 1 +
 builtin/merge.c                  | 1 +
 builtin/mv.c                     | 1 +
 builtin/name-rev.c               | 1 +
 builtin/notes.c                  | 1 +
 builtin/pack-objects.c           | 1 +
 builtin/patch-id.c               | 1 +
 builtin/pull.c                   | 1 +
 builtin/push.c                   | 1 +
 builtin/read-tree.c              | 1 +
 builtin/rebase--helper.c         | 1 +
 builtin/receive-pack.c           | 1 +
 builtin/reflog.c                 | 1 +
 builtin/remote.c                 | 1 +
 builtin/repack.c                 | 1 +
 builtin/replace.c                | 1 +
 builtin/rerere.c                 | 1 +
 builtin/reset.c                  | 1 +
 builtin/rev-list.c               | 1 +
 builtin/rev-parse.c              | 1 +
 builtin/revert.c                 | 1 +
 builtin/rm.c                     | 1 +
 builtin/send-pack.c              | 1 +
 builtin/shortlog.c               | 1 +
 builtin/show-branch.c            | 1 +
 builtin/stripspace.c             | 1 +
 builtin/submodule--helper.c      | 1 +
 builtin/symbolic-ref.c           | 1 +
 builtin/tag.c                    | 1 +
 builtin/unpack-file.c            | 1 +
 builtin/unpack-objects.c         | 1 +
 builtin/update-index.c           | 1 +
 builtin/update-ref.c             | 1 +
 builtin/update-server-info.c     | 1 +
 builtin/var.c                    | 1 +
 builtin/verify-commit.c          | 1 +
 builtin/verify-pack.c            | 1 +
 builtin/verify-tag.c             | 1 +
 builtin/worktree.c               | 1 +
 builtin/write-tree.c             | 1 +
 cache.h                          | 1 -
 color.c                          | 1 +
 column.c                         | 1 +
 compat/precompose_utf8.c         | 1 +
 config.c                         | 1 +
 connect.c                        | 1 +
 convert.c                        | 1 +
 credential-cache--daemon.c       | 1 +
 credential.c                     | 1 +
 daemon.c                         | 1 +
 diff.c                           | 1 +
 dir.c                            | 1 +
 environment.c                    | 1 +
 fast-import.c                    | 1 +
 fetch-pack.c                     | 1 +
 git.c                            | 1 +
 gpg-interface.c                  | 1 +
 graph.c                          | 1 +
 grep.c                           | 1 +
 help.c                           | 1 +
 http-backend.c                   | 1 +
 http-fetch.c                     | 1 +
 http.c                           | 1 +
 ident.c                          | 1 +
 imap-send.c                      | 1 +
 ll-merge.c                       | 1 +
 log-tree.c                       | 1 +
 mailinfo.c                       | 1 +
 merge-recursive.c                | 1 +
 notes-utils.c                    | 1 +
 notes.c                          | 1 +
 pager.c                          | 1 +
 parse-options.c                  | 1 +
 pathspec.c                       | 1 +
 pretty.c                         | 1 +
 prompt.c                         | 1 +
 read-cache.c                     | 1 +
 refs.c                           | 1 +
 refs/files-backend.c             | 1 +
 remote-curl.c                    | 1 +
 remote.c                         | 1 +
 rerere.c                         | 1 +
 send-pack.c                      | 1 +
 sequencer.c                      | 1 +
 setup.c                          | 1 +
 sha1_file.c                      | 1 +
 sha1_name.c                      | 1 +
 submodule-config.c               | 1 +
 submodule.c                      | 1 +
 t/helper/test-config.c           | 1 +
 t/helper/test-submodule-config.c | 1 +
 trailer.c                        | 1 +
 transport.c                      | 1 +
 unpack-trees.c                   | 1 +
 upload-pack.c                    | 1 +
 userdiff.c                       | 1 +
 versioncmp.c                     | 1 +
 wrapper.c                        | 1 +
 xdiff-interface.c                | 1 +
 146 files changed, 146 insertions(+), 1 deletion(-)

diff --git a/advice.c b/advice.c
index b84ae4960..3fa04fca0 100644
--- a/advice.c
+++ b/advice.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 
 int advice_push_update_rejected = 1;
 int advice_push_non_ff_current = 1;
diff --git a/alias.c b/alias.c
index 5df052ae4..f7bc0f72b 100644
--- a/alias.c
+++ b/alias.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 
 struct config_alias_data
 {
diff --git a/apply.c b/apply.c
index c49cef063..87db9618d 100644
--- a/apply.c
+++ b/apply.c
@@ -8,6 +8,7 @@
  */
 
 #include "cache.h"
+#include "config.h"
 #include "blob.h"
 #include "delta.h"
 #include "diff.h"
diff --git a/archive-tar.c b/archive-tar.c
index 073e60ebd..c6ed96ee7 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -2,6 +2,7 @@
  * Copyright (c) 2005, 2006 Rene Scharfe
  */
 #include "cache.h"
+#include "config.h"
 #include "tar.h"
 #include "archive.h"
 #include "streaming.h"
diff --git a/archive-zip.c b/archive-zip.c
index 27563e9e2..e8913e5a2 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -2,6 +2,7 @@
  * Copyright (c) 2006 Rene Scharfe
  */
 #include "cache.h"
+#include "config.h"
 #include "archive.h"
 #include "streaming.h"
 #include "utf8.h"
diff --git a/archive.c b/archive.c
index b15a922da..60b3035a7 100644
--- a/archive.c
+++ b/archive.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "refs.h"
 #include "commit.h"
 #include "tree-walk.h"
diff --git a/attr.c b/attr.c
index 7e2134471..9f8b02936 100644
--- a/attr.c
+++ b/attr.c
@@ -9,6 +9,7 @@
 
 #define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
+#include "config.h"
 #include "exec_cmd.h"
 #include "attr.h"
 #include "dir.h"
diff --git a/bisect.c b/bisect.c
index c952df692..d8587d11c 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "commit.h"
 #include "diff.h"
 #include "revision.h"
diff --git a/branch.c b/branch.c
index 985316eb7..a8a548ccf 100644
--- a/branch.c
+++ b/branch.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "cache.h"
+#include "config.h"
 #include "branch.h"
 #include "refs.h"
 #include "remote.h"
diff --git a/builtin/add.c b/builtin/add.c
index d9a2491e4..f2415e99f 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2006 Linus Torvalds
  */
 #include "cache.h"
+#include "config.h"
 #include "builtin.h"
 #include "lockfile.h"
 #include "dir.h"
diff --git a/builtin/am.c b/builtin/am.c
index 5ee146bfb..242d70361 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -4,6 +4,7 @@
  * Based on git-am.sh by Junio C Hamano.
  */
 #include "cache.h"
+#include "config.h"
 #include "builtin.h"
 #include "exec_cmd.h"
 #include "parse-options.h"
diff --git a/builtin/blame.c b/builtin/blame.c
index d7a2df3b4..381927920 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -6,6 +6,8 @@
  */
 
 #include "cache.h"
+#include "config.h"
+#include "refs.h"
 #include "builtin.h"
 #include "commit.h"
 #include "diff.h"
diff --git a/builtin/branch.c b/builtin/branch.c
index 83fcda43d..c958e9325 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -6,6 +6,7 @@
  */
 
 #include "cache.h"
+#include "config.h"
 #include "color.h"
 #include "refs.h"
 #include "commit.h"
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 4bffd7a2d..7efbc4019 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -4,6 +4,7 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include "cache.h"
+#include "config.h"
 #include "builtin.h"
 #include "diff.h"
 #include "parse-options.h"
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 4d01ca0c8..91444dc04 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "config.h"
 #include "attr.h"
 #include "quote.h"
 #include "parse-options.h"
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index c7b8c0889..3e280b9c7 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "config.h"
 #include "dir.h"
 #include "quote.h"
 #include "pathspec.h"
diff --git a/builtin/check-mailmap.c b/builtin/check-mailmap.c
index cf0f54f6b..cdce144f3 100644
--- a/builtin/check-mailmap.c
+++ b/builtin/check-mailmap.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "config.h"
 #include "mailmap.h"
 #include "parse-options.h"
 #include "string-list.h"
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 07631d0c9..39c8be05d 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -5,6 +5,7 @@
  *
  */
 #include "builtin.h"
+#include "config.h"
 #include "lockfile.h"
 #include "quote.h"
 #include "cache-tree.h"
diff --git a/builtin/checkout.c b/builtin/checkout.c
index a6b2af39d..45fab5a4d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "config.h"
 #include "lockfile.h"
 #include "parse-options.h"
 #include "refs.h"
diff --git a/builtin/clean.c b/builtin/clean.c
index 142bf668c..ed954134d 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -8,6 +8,7 @@
 
 #include "builtin.h"
 #include "cache.h"
+#include "config.h"
 #include "dir.h"
 #include "parse-options.h"
 #include "string-list.h"
diff --git a/builtin/clone.c b/builtin/clone.c
index 743f16ae2..4922a5496 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -9,6 +9,7 @@
  */
 
 #include "builtin.h"
+#include "config.h"
 #include "lockfile.h"
 #include "parse-options.h"
 #include "fetch-pack.h"
diff --git a/builtin/column.c b/builtin/column.c
index 33314b4d7..0c3223d64 100644
--- a/builtin/column.c
+++ b/builtin/column.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "config.h"
 #include "strbuf.h"
 #include "parse-options.h"
 #include "string-list.h"
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index f39c2b273..a4a923d7c 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -4,6 +4,7 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include "cache.h"
+#include "config.h"
 #include "commit.h"
 #include "tree.h"
 #include "builtin.h"
diff --git a/builtin/commit.c b/builtin/commit.c
index da1ba4c86..805da4915 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -6,6 +6,7 @@
  */
 
 #include "cache.h"
+#include "config.h"
 #include "lockfile.h"
 #include "cache-tree.h"
 #include "color.h"
diff --git a/builtin/config.c b/builtin/config.c
index 7f6c25d4d..753c40a5c 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "config.h"
 #include "color.h"
 #include "parse-options.h"
 #include "urlmatch.h"
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index acb05940f..1d82e61f2 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -5,6 +5,7 @@
  */
 
 #include "cache.h"
+#include "config.h"
 #include "dir.h"
 #include "builtin.h"
 #include "parse-options.h"
diff --git a/builtin/describe.c b/builtin/describe.c
index 893c8789f..70eb14460 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "lockfile.h"
 #include "commit.h"
 #include "tag.h"
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index a572da9d5..965f2fb76 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -4,6 +4,7 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include "cache.h"
+#include "config.h"
 #include "diff.h"
 #include "commit.h"
 #include "revision.h"
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index f084826a2..ad9971f64 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "diff.h"
 #include "commit.h"
 #include "revision.h"
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index e40111204..36c220f93 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "diff.h"
 #include "commit.h"
 #include "log-tree.h"
diff --git a/builtin/diff.c b/builtin/diff.c
index 0c8f86e40..0d59e99ef 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2006 Junio C Hamano
  */
 #include "cache.h"
+#include "config.h"
 #include "lockfile.h"
 #include "color.h"
 #include "commit.h"
diff --git a/builtin/difftool.c b/builtin/difftool.c
index b9a892f26..9199227f6 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -12,6 +12,7 @@
  * Copyright (C) 2016 Johannes Schindelin
  */
 #include "cache.h"
+#include "config.h"
 #include "builtin.h"
 #include "run-command.h"
 #include "exec_cmd.h"
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 24e29ad7e..0dfd980dd 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -5,6 +5,7 @@
  */
 #include "builtin.h"
 #include "cache.h"
+#include "config.h"
 #include "refs.h"
 #include "commit.h"
 #include "object.h"
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 47708451b..65317bd6c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2,6 +2,7 @@
  * "git fetch"
  */
 #include "cache.h"
+#include "config.h"
 #include "refs.h"
 #include "commit.h"
 #include "builtin.h"
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 70137b0b7..10cbb4341 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "config.h"
 #include "refs.h"
 #include "commit.h"
 #include "diff.h"
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index eca365bf8..52be99cba 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "config.h"
 #include "refs.h"
 #include "object.h"
 #include "parse-options.h"
diff --git a/builtin/fsck.c b/builtin/fsck.c
index cb2ba6cd1..90593491e 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "config.h"
 #include "commit.h"
 #include "tree.h"
 #include "blob.h"
diff --git a/builtin/gc.c b/builtin/gc.c
index f484eda43..bd91f136f 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -11,6 +11,7 @@
  */
 
 #include "builtin.h"
+#include "config.h"
 #include "tempfile.h"
 #include "lockfile.h"
 #include "parse-options.h"
diff --git a/builtin/grep.c b/builtin/grep.c
index 7df9c253e..7f720ca6c 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2006 Junio C Hamano
  */
 #include "cache.h"
+#include "config.h"
 #include "blob.h"
 #include "tree.h"
 #include "commit.h"
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index bbeaf20bc..d04baf999 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -5,6 +5,7 @@
  * Copyright (C) Junio C Hamano, 2005
  */
 #include "builtin.h"
+#include "config.h"
 #include "blob.h"
 #include "quote.h"
 #include "parse-options.h"
diff --git a/builtin/help.c b/builtin/help.c
index 49f7a07f8..334a8494a 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -2,6 +2,7 @@
  * Builtin help command
  */
 #include "cache.h"
+#include "config.h"
 #include "builtin.h"
 #include "exec_cmd.h"
 #include "parse-options.h"
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 04b9dcaf0..edc1a91d8 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "config.h"
 #include "delta.h"
 #include "pack.h"
 #include "csum-file.h"
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 8a6acb0ec..47823f9aa 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -4,6 +4,7 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include "cache.h"
+#include "config.h"
 #include "refs.h"
 #include "builtin.h"
 #include "exec_cmd.h"
diff --git a/builtin/log.c b/builtin/log.c
index e89ec941c..01d7213c1 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -5,6 +5,7 @@
  *		 2006 Junio Hamano
  */
 #include "cache.h"
+#include "config.h"
 #include "refs.h"
 #include "color.h"
 #include "commit.h"
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index b376afc31..c4357dc30 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -6,6 +6,7 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include "cache.h"
+#include "config.h"
 #include "quote.h"
 #include "dir.h"
 #include "builtin.h"
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index ee7b293b1..ef965408e 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -4,6 +4,7 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include "cache.h"
+#include "config.h"
 #include "blob.h"
 #include "tree.h"
 #include "commit.h"
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 0c36a70ad..6dbd167d3 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "config.h"
 #include "commit.h"
 #include "refs.h"
 #include "diff.h"
diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 47dde7c39..b08803e61 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "config.h"
 #include "xdiff/xdiff.h"
 #include "xdiff-interface.h"
 #include "parse-options.h"
diff --git a/builtin/merge.c b/builtin/merge.c
index a4a098f40..2512370c1 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -7,6 +7,7 @@
  */
 
 #include "cache.h"
+#include "config.h"
 #include "parse-options.h"
 #include "builtin.h"
 #include "lockfile.h"
diff --git a/builtin/mv.c b/builtin/mv.c
index 61d20037a..dcf6736b5 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2006 Johannes Schindelin
  */
 #include "builtin.h"
+#include "config.h"
 #include "pathspec.h"
 #include "lockfile.h"
 #include "dir.h"
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 7fc7e66e8..e21715f1d 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "config.h"
 #include "commit.h"
 #include "tag.h"
 #include "refs.h"
diff --git a/builtin/notes.c b/builtin/notes.c
index 7196bff0e..8d14f434a 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -8,6 +8,7 @@
  */
 
 #include "cache.h"
+#include "config.h"
 #include "builtin.h"
 #include "notes.h"
 #include "blob.h"
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f672225de..d5e96ed2d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "config.h"
 #include "attr.h"
 #include "object.h"
 #include "blob.h"
diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 81552e02e..970d0d30b 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "config.h"
 
 static void flush_current_id(int patchlen, struct object_id *id, struct object_id *result)
 {
diff --git a/builtin/pull.c b/builtin/pull.c
index da8b60fc8..0c77381da 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -6,6 +6,7 @@
  * Fetch one or more remote refs and merge it/them into the current HEAD.
  */
 #include "cache.h"
+#include "config.h"
 #include "builtin.h"
 #include "parse-options.h"
 #include "exec_cmd.h"
diff --git a/builtin/push.c b/builtin/push.c
index a597759d8..76aa713d2 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -2,6 +2,7 @@
  * "git push"
  */
 #include "cache.h"
+#include "config.h"
 #include "refs.h"
 #include "run-command.h"
 #include "builtin.h"
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 78d319365..6eb2a0e57 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -5,6 +5,7 @@
  */
 
 #include "cache.h"
+#include "config.h"
 #include "lockfile.h"
 #include "object.h"
 #include "tree.h"
diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index ca1ebb2fa..c82b4dce6 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "config.h"
 #include "parse-options.h"
 #include "sequencer.h"
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index b1706a573..71c0c768d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "config.h"
 #include "lockfile.h"
 #include "pack.h"
 #include "refs.h"
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 920c16dac..44cdc2dbd 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "config.h"
 #include "lockfile.h"
 #include "commit.h"
 #include "refs.h"
diff --git a/builtin/remote.c b/builtin/remote.c
index f1a88fe26..6273c0c23 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "config.h"
 #include "parse-options.h"
 #include "transport.h"
 #include "remote.h"
diff --git a/builtin/repack.c b/builtin/repack.c
index 38ba4ef82..f17a68a17 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "config.h"
 #include "dir.h"
 #include "parse-options.h"
 #include "run-command.h"
diff --git a/builtin/replace.c b/builtin/replace.c
index c921bc976..80a15cf35 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -9,6 +9,7 @@
  */
 
 #include "cache.h"
+#include "config.h"
 #include "builtin.h"
 #include "refs.h"
 #include "parse-options.h"
diff --git a/builtin/rerere.c b/builtin/rerere.c
index 1bf72423b..ffb66e290 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "config.h"
 #include "dir.h"
 #include "parse-options.h"
 #include "string-list.h"
diff --git a/builtin/reset.c b/builtin/reset.c
index 430602d10..d0b604103 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -8,6 +8,7 @@
  * Copyright (c) 2005, 2006 Linus Torvalds and Junio C Hamano
  */
 #include "builtin.h"
+#include "config.h"
 #include "lockfile.h"
 #include "tag.h"
 #include "object.h"
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 718c6059c..f8e2b7bf5 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "commit.h"
 #include "diff.h"
 #include "revision.h"
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index efdc14473..c78b7b33d 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -4,6 +4,7 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include "cache.h"
+#include "config.h"
 #include "commit.h"
 #include "refs.h"
 #include "quote.h"
diff --git a/builtin/revert.c b/builtin/revert.c
index 345d9586a..16028b9ea 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "builtin.h"
 #include "parse-options.h"
 #include "diff.h"
diff --git a/builtin/rm.c b/builtin/rm.c
index 7c323d012..824d1de9e 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -4,6 +4,7 @@
  * Copyright (C) Linus Torvalds 2006
  */
 #include "builtin.h"
+#include "config.h"
 #include "lockfile.h"
 #include "dir.h"
 #include "cache-tree.h"
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index b8e2e74fe..633e0c3cd 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "config.h"
 #include "commit.h"
 #include "refs.h"
 #include "pkt-line.h"
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 7cff1839f..43c4799ea 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "config.h"
 #include "commit.h"
 #include "diff.h"
 #include "string-list.h"
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 4a6cc6f49..e4cf1b5bb 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "commit.h"
 #include "refs.h"
 #include "builtin.h"
diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index 1e62a008c..bdf032886 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "config.h"
 #include "parse-options.h"
 #include "strbuf.h"
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 8cc648d85..4dcbfb952 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "config.h"
 #include "parse-options.h"
 #include "quote.h"
 #include "pathspec.h"
diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index 70addef15..df75cb9d4 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "config.h"
 #include "cache.h"
 #include "refs.h"
 #include "parse-options.h"
diff --git a/builtin/tag.c b/builtin/tag.c
index 1f74a56db..01154ea8d 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -7,6 +7,7 @@
  */
 
 #include "cache.h"
+#include "config.h"
 #include "builtin.h"
 #include "refs.h"
 #include "tag.h"
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index 6fc6bcdf7..73f133419 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "config.h"
 
 static char *create_temp_file(unsigned char *sha1)
 {
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 8bc999776..193f8b9d5 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "config.h"
 #include "object.h"
 #include "delta.h"
 #include "pack.h"
diff --git a/builtin/update-index.c b/builtin/update-index.c
index ebfc09faa..0a4c23648 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -4,6 +4,7 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include "cache.h"
+#include "config.h"
 #include "lockfile.h"
 #include "quote.h"
 #include "cache-tree.h"
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 0b2ecf41a..40ccfc193 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "refs.h"
 #include "builtin.h"
 #include "parse-options.h"
diff --git a/builtin/update-server-info.c b/builtin/update-server-info.c
index 6c8cc3edc..873070e51 100644
--- a/builtin/update-server-info.c
+++ b/builtin/update-server-info.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "builtin.h"
 #include "parse-options.h"
 
diff --git a/builtin/var.c b/builtin/var.c
index aedbb53a2..6c6f46b4a 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -4,6 +4,7 @@
  * Copyright (C) Eric Biederman, 2005
  */
 #include "builtin.h"
+#include "config.h"
 
 static const char var_usage[] = "git var (-l | <variable>)";
 
diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index 05b734e6d..ba38ac9b1 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -6,6 +6,7 @@
  * Based on git-verify-tag
  */
 #include "cache.h"
+#include "config.h"
 #include "builtin.h"
 #include "commit.h"
 #include "run-command.h"
diff --git a/builtin/verify-pack.c b/builtin/verify-pack.c
index c94e15693..c2a1a5c50 100644
--- a/builtin/verify-pack.c
+++ b/builtin/verify-pack.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "config.h"
 #include "run-command.h"
 #include "parse-options.h"
 
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 5199553d9..f9a5f7535 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -6,6 +6,7 @@
  * Based on git-verify-tag.sh
  */
 #include "cache.h"
+#include "config.h"
 #include "builtin.h"
 #include "tag.h"
 #include "run-command.h"
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 793306ea5..0c5476ee9 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "builtin.h"
 #include "dir.h"
 #include "parse-options.h"
diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index 084c0df78..bd0a78aa3 100644
--- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -5,6 +5,7 @@
  */
 #include "builtin.h"
 #include "cache.h"
+#include "config.h"
 #include "tree.h"
 #include "cache-tree.h"
 #include "parse-options.h"
diff --git a/cache.h b/cache.h
index ed56f8818..fd45b8c55 100644
--- a/cache.h
+++ b/cache.h
@@ -11,7 +11,6 @@
 #include "string-list.h"
 #include "pack-revindex.h"
 #include "hash.h"
-#include "config.h"
 
 #ifndef platform_SHA_CTX
 /*
diff --git a/color.c b/color.c
index dee61557e..31b6207a0 100644
--- a/color.c
+++ b/color.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "color.h"
 
 static int git_use_color_default = GIT_COLOR_AUTO;
diff --git a/column.c b/column.c
index d55ead18e..ff7bdab1a 100644
--- a/column.c
+++ b/column.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "column.h"
 #include "string-list.h"
 #include "parse-options.h"
diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index 4293b53b1..de61c15d3 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -6,6 +6,7 @@
 #define PRECOMPOSE_UNICODE_C
 
 #include "cache.h"
+#include "config.h"
 #include "utf8.h"
 #include "precompose_utf8.h"
 
diff --git a/config.c b/config.c
index 12c172e29..990f15dc4 100644
--- a/config.c
+++ b/config.c
@@ -6,6 +6,7 @@
  *
  */
 #include "cache.h"
+#include "config.h"
 #include "lockfile.h"
 #include "exec_cmd.h"
 #include "strbuf.h"
diff --git a/connect.c b/connect.c
index c72b1d115..e78d3f43d 100644
--- a/connect.c
+++ b/connect.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "cache.h"
+#include "config.h"
 #include "pkt-line.h"
 #include "quote.h"
 #include "refs.h"
diff --git a/convert.c b/convert.c
index f1e168bc3..5f4a4b1f5 100644
--- a/convert.c
+++ b/convert.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "attr.h"
 #include "run-command.h"
 #include "quote.h"
diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
index f3814cc47..0d5c62509 100644
--- a/credential-cache--daemon.c
+++ b/credential-cache--daemon.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "tempfile.h"
 #include "credential.h"
 #include "unix-socket.h"
diff --git a/credential.c b/credential.c
index aa996669f..67a523353 100644
--- a/credential.c
+++ b/credential.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "credential.h"
 #include "string-list.h"
 #include "run-command.h"
diff --git a/daemon.c b/daemon.c
index ac7181a48..30747075f 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "pkt-line.h"
 #include "run-command.h"
 #include "strbuf.h"
diff --git a/diff.c b/diff.c
index 5275c4b78..3458ec640 100644
--- a/diff.c
+++ b/diff.c
@@ -2,6 +2,7 @@
  * Copyright (C) 2005 Junio C Hamano
  */
 #include "cache.h"
+#include "config.h"
 #include "tempfile.h"
 #include "quote.h"
 #include "diff.h"
diff --git a/dir.c b/dir.c
index 9efcf1eab..d4e4258ea 100644
--- a/dir.c
+++ b/dir.c
@@ -9,6 +9,7 @@
  */
 #define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
+#include "config.h"
 #include "dir.h"
 #include "attr.h"
 #include "refs.h"
diff --git a/environment.c b/environment.c
index aa478e71d..d40b21fb7 100644
--- a/environment.c
+++ b/environment.c
@@ -8,6 +8,7 @@
  * are.
  */
 #include "cache.h"
+#include "config.h"
 #include "refs.h"
 #include "fmt-merge-msg.h"
 #include "commit.h"
diff --git a/fast-import.c b/fast-import.c
index e69d21968..2881d4898 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -154,6 +154,7 @@ Format of STDIN stream:
 
 #include "builtin.h"
 #include "cache.h"
+#include "config.h"
 #include "lockfile.h"
 #include "object.h"
 #include "blob.h"
diff --git a/fetch-pack.c b/fetch-pack.c
index cd86865be..fbbc99c88 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "lockfile.h"
 #include "refs.h"
 #include "pkt-line.h"
diff --git a/git.c b/git.c
index 58ef57029..c03de2c09 100644
--- a/git.c
+++ b/git.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "config.h"
 #include "exec_cmd.h"
 #include "help.h"
 #include "run-command.h"
diff --git a/gpg-interface.c b/gpg-interface.c
index e44cc27da..8ab32df45 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "run-command.h"
 #include "strbuf.h"
 #include "gpg-interface.h"
diff --git a/graph.c b/graph.c
index 8b9049dd2..e7e20650d 100644
--- a/graph.c
+++ b/graph.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "commit.h"
 #include "color.h"
 #include "graph.h"
diff --git a/grep.c b/grep.c
index d03d424e5..62c7cf970 100644
--- a/grep.c
+++ b/grep.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "grep.h"
 #include "userdiff.h"
 #include "xdiff-interface.h"
diff --git a/help.c b/help.c
index b44c55ec2..328ecd339 100644
--- a/help.c
+++ b/help.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "builtin.h"
 #include "exec_cmd.h"
 #include "run-command.h"
diff --git a/http-backend.c b/http-backend.c
index ba5ff1aa2..519025d2c 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "refs.h"
 #include "pkt-line.h"
 #include "object.h"
diff --git a/http-fetch.c b/http-fetch.c
index 3b556d661..8af380050 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "exec_cmd.h"
 #include "http.h"
 #include "walker.h"
diff --git a/http.c b/http.c
index d2e11ec6f..013bb0cc6 100644
--- a/http.c
+++ b/http.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "http.h"
+#include "config.h"
 #include "pack.h"
 #include "sideband.h"
 #include "run-command.h"
diff --git a/ident.c b/ident.c
index bea871c8e..d41fc9119 100644
--- a/ident.c
+++ b/ident.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2005 Linus Torvalds
  */
 #include "cache.h"
+#include "config.h"
 
 static struct strbuf git_default_name = STRBUF_INIT;
 static struct strbuf git_default_email = STRBUF_INIT;
diff --git a/imap-send.c b/imap-send.c
index 857591660..59e9b12d2 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -23,6 +23,7 @@
  */
 
 #include "cache.h"
+#include "config.h"
 #include "credential.h"
 #include "exec_cmd.h"
 #include "run-command.h"
diff --git a/ll-merge.c b/ll-merge.c
index ac0d4a5d7..24ff94e1d 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -5,6 +5,7 @@
  */
 
 #include "cache.h"
+#include "config.h"
 #include "attr.h"
 #include "xdiff-interface.h"
 #include "run-command.h"
diff --git a/log-tree.c b/log-tree.c
index a4ec11c2b..7e1dfd749 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "diff.h"
 #include "commit.h"
 #include "tag.h"
diff --git a/mailinfo.c b/mailinfo.c
index f92cb9f72..f59162453 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "utf8.h"
 #include "strbuf.h"
 #include "mailinfo.h"
diff --git a/merge-recursive.c b/merge-recursive.c
index ae5238d82..c2494f34f 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -4,6 +4,7 @@
  * The thieves were Alex Riesen and Johannes Schindelin, in June/July 2006
  */
 #include "cache.h"
+#include "config.h"
 #include "advice.h"
 #include "lockfile.h"
 #include "cache-tree.h"
diff --git a/notes-utils.c b/notes-utils.c
index 031503d7b..3f6cbdc47 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "commit.h"
 #include "refs.h"
 #include "notes-utils.h"
diff --git a/notes.c b/notes.c
index 542563b28..dbcfef4d7 100644
--- a/notes.c
+++ b/notes.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "notes.h"
 #include "blob.h"
 #include "tree.h"
diff --git a/pager.c b/pager.c
index c113d898a..4dd9e1b26 100644
--- a/pager.c
+++ b/pager.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "run-command.h"
 #include "sigchain.h"
 
diff --git a/parse-options.c b/parse-options.c
index e5ad34a2c..0dd9fc6a0 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "parse-options.h"
 #include "cache.h"
+#include "config.h"
 #include "commit.h"
 #include "color.h"
 #include "utf8.h"
diff --git a/pathspec.c b/pathspec.c
index 828405021..ecc5331c2 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -1,5 +1,6 @@
 #define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
+#include "config.h"
 #include "dir.h"
 #include "pathspec.h"
 #include "attr.h"
diff --git a/pretty.c b/pretty.c
index 09701bd2f..9c9f81b5b 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "commit.h"
 #include "utf8.h"
 #include "diff.h"
diff --git a/prompt.c b/prompt.c
index 75406390c..6d5885d00 100644
--- a/prompt.c
+++ b/prompt.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "run-command.h"
 #include "strbuf.h"
 #include "prompt.h"
diff --git a/read-cache.c b/read-cache.c
index bc156a133..c8c766dab 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -5,6 +5,7 @@
  */
 #define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
+#include "config.h"
 #include "tempfile.h"
 #include "lockfile.h"
 #include "cache-tree.h"
diff --git a/refs.c b/refs.c
index f0685c925..84112c88e 100644
--- a/refs.c
+++ b/refs.c
@@ -3,6 +3,7 @@
  */
 
 #include "cache.h"
+#include "config.h"
 #include "hashmap.h"
 #include "lockfile.h"
 #include "iterator.h"
diff --git a/refs/files-backend.c b/refs/files-backend.c
index d8b3f7314..621a4086c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1,4 +1,5 @@
 #include "../cache.h"
+#include "../config.h"
 #include "../refs.h"
 #include "refs-internal.h"
 #include "ref-cache.h"
diff --git a/remote-curl.c b/remote-curl.c
index ece45993d..0053b0954 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "remote.h"
 #include "strbuf.h"
 #include "walker.h"
diff --git a/remote.c b/remote.c
index 3649d60cd..68d20f650 100644
--- a/remote.c
+++ b/remote.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "remote.h"
 #include "refs.h"
 #include "commit.h"
diff --git a/rerere.c b/rerere.c
index 3bd55caf3..344d6aa81 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "lockfile.h"
 #include "string-list.h"
 #include "rerere.h"
diff --git a/send-pack.c b/send-pack.c
index 78bb34ebe..ed3cee321 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "config.h"
 #include "commit.h"
 #include "refs.h"
 #include "pkt-line.h"
diff --git a/sequencer.c b/sequencer.c
index 924fb1d0c..86b0640d2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "lockfile.h"
 #include "sequencer.h"
 #include "dir.h"
diff --git a/setup.c b/setup.c
index 2435186e4..c6c00463a 100644
--- a/setup.c
+++ b/setup.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "dir.h"
 #include "string-list.h"
 
diff --git a/sha1_file.c b/sha1_file.c
index 59a4ed2ed..44561e0b9 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -7,6 +7,7 @@
  * creation etc.
  */
 #include "cache.h"
+#include "config.h"
 #include "string-list.h"
 #include "lockfile.h"
 #include "delta.h"
diff --git a/sha1_name.c b/sha1_name.c
index e9ffe685d..2875771ff 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "tag.h"
 #include "commit.h"
 #include "tree.h"
diff --git a/submodule-config.c b/submodule-config.c
index 4f58491dd..d8f8d5ea3 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "submodule-config.h"
 #include "submodule.h"
 #include "strbuf.h"
diff --git a/submodule.c b/submodule.c
index bf5a93d16..95328de61 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "submodule-config.h"
 #include "submodule.h"
 #include "dir.h"
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 8e3ed6a76..1a7b8bd3d 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "string-list.h"
 
 /*
diff --git a/t/helper/test-submodule-config.c b/t/helper/test-submodule-config.c
index 2f144d539..c6c57bba0 100644
--- a/t/helper/test-submodule-config.c
+++ b/t/helper/test-submodule-config.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "submodule-config.h"
 #include "submodule.h"
 
diff --git a/trailer.c b/trailer.c
index 11f0b9fb4..751b56c00 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "string-list.h"
 #include "run-command.h"
 #include "commit.h"
diff --git a/transport.c b/transport.c
index 9bfcf870f..b9995306f 100644
--- a/transport.c
+++ b/transport.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "transport.h"
 #include "run-command.h"
 #include "pkt-line.h"
diff --git a/unpack-trees.c b/unpack-trees.c
index d38c37e38..dd535bc84 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1,5 +1,6 @@
 #define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
+#include "config.h"
 #include "dir.h"
 #include "tree.h"
 #include "tree-walk.h"
diff --git a/upload-pack.c b/upload-pack.c
index 5330c02c1..7efff2fbf 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "refs.h"
 #include "pkt-line.h"
 #include "sideband.h"
diff --git a/userdiff.c b/userdiff.c
index 8b732e40b..2c1502f71 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "userdiff.h"
 #include "attr.h"
 
diff --git a/versioncmp.c b/versioncmp.c
index 9f81dc106..069ee94a4 100644
--- a/versioncmp.c
+++ b/versioncmp.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "string-list.h"
 
 /*
diff --git a/wrapper.c b/wrapper.c
index d83741770..487a9f753 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -2,6 +2,7 @@
  * Various trivial helper wrappers around standard functions
  */
 #include "cache.h"
+#include "config.h"
 
 static void do_nothing(size_t size)
 {
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 060038c2d..5ac07d734 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "xdiff-interface.h"
 #include "xdiff/xtypes.h"
 #include "xdiff/xdiffi.h"
-- 
2.13.1.518.g3df882009-goog


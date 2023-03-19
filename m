Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28BCC6FD1F
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 06:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjCSG3l (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 02:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjCSG2e (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 02:28:34 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46FD166FA
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:28:18 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id ay8so5584016wmb.1
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679207297;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ZpBg0BXCt7g2GZAXhYhApCO+P1fx2AWwZ7NOEE7X9Q=;
        b=SCjk0MX7QVoYe8in8JZWOSim2YNuy6CKFCRh0hyY7lPhTJPs8hV0PGt/7t2hZSxxkF
         PzRSNj7mULL6kH8vH/2UFv+MTyPMRR2rM5K5LTPAWr2/E98x6ZLs5AcFDTAoAzZ1pWMn
         R+bUWtHfba7qI4go7vagFgdYRrG/+AMm30jot4kS36yxJq0r4G87CZ9pTI55kYNRz9mi
         Ep9D3tohOlyYx/J9Y39xA1V67mghd6cf5LmrzXOeTKtonyYSAhwvjdkBw3lZ8mEGQdZX
         +dgF9Yep11hwSeRIYFuKt6Op16vvDlJAJMeB2filG2fTQ2SIVlkWo4Gdu+LSsz0pb4I8
         IQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679207297;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ZpBg0BXCt7g2GZAXhYhApCO+P1fx2AWwZ7NOEE7X9Q=;
        b=nIwrv5YSgLQ5TmgNS4YAFPxQD2sAZufa/n6QvSUyM5qtrIfp7HM1oYBV0bAlY4fVPw
         km26BO+EoJvJ3rkIeYuzzfFP0uN/WhAG+ZbwZMdPwvLVoFHLturnOVfAoNPfURgL2QA1
         ki1fLeNqOEyM7Uok8e9sYX2Gsr+81H8sa4uvNEviOXqOXbf3jPN7A91dCxTF5EzUcMvd
         CBnT5Rvcd/e0LVY16JjNNa4VIfPNlNBhcEm3jC9Q1vlDAWLfuJcui4+oTWum0G8URC5n
         VvZDAxaGJwIn2hCkZCrE+5tEj2Wo6pj331NyCrX5b8LuwdzSPDtR7Vt9uX+Veqbs7dp9
         MazQ==
X-Gm-Message-State: AO0yUKXvgSVn2y6E4D+ih8sAaoQXsfonB17i3/i+DkJPmJnc3fL1QbJG
        Thd0YJuWtV7waiS6bOtUz+YzpxgB9U4=
X-Google-Smtp-Source: AK7set+R5/aJHQU/xoz35YreEGsJxnfKdtHPI316lwEfRBZPjEf4fBeBjqgAGRj7Y3CF6rtY5cIoNA==
X-Received: by 2002:a7b:ca41:0:b0:3ea:f75d:4626 with SMTP id m1-20020a7bca41000000b003eaf75d4626mr28992853wml.38.1679207296350;
        Sat, 18 Mar 2023 23:28:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v15-20020a05600c444f00b003edddce5b00sm714345wmn.12.2023.03.18.23.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 23:28:16 -0700 (PDT)
Message-Id: <9722988e53748d093af1816f7987897c2345520f.1679207285.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1493.git.1679207282.gitgitgadget@gmail.com>
References: <pull.1493.git.1679207282.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 19 Mar 2023 06:27:59 +0000
Subject: [PATCH 13/16] setup.h: move declarations for setup.c functions from
 cache.h
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

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 apply.c                                      |   1 +
 archive.c                                    |   1 +
 attr.c                                       |   1 +
 blame.c                                      |   1 +
 builtin/blame.c                              |   1 +
 builtin/bugreport.c                          |   1 +
 builtin/bundle.c                             |   1 +
 builtin/check-attr.c                         |   1 +
 builtin/check-ref-format.c                   |   1 +
 builtin/checkout-index.c                     |   1 +
 builtin/checkout.c                           |   1 +
 builtin/clean.c                              |   1 +
 builtin/clone.c                              |   1 +
 builtin/config.c                             |   1 +
 builtin/describe.c                           |   1 +
 builtin/diff-index.c                         |   1 +
 builtin/diff.c                               |   1 +
 builtin/difftool.c                           |   1 +
 builtin/gc.c                                 |   1 +
 builtin/grep.c                               |   1 +
 builtin/hash-object.c                        |   1 +
 builtin/help.c                               |   1 +
 builtin/index-pack.c                         |   1 +
 builtin/init-db.c                            |   1 +
 builtin/ls-files.c                           |   1 +
 builtin/merge-file.c                         |   1 +
 builtin/mv.c                                 |   1 +
 builtin/read-tree.c                          |   1 +
 builtin/reset.c                              |   1 +
 builtin/rev-parse.c                          |   1 +
 builtin/rm.c                                 |   1 +
 builtin/shortlog.c                           |   1 +
 builtin/sparse-checkout.c                    |   1 +
 builtin/stash.c                              |   1 +
 builtin/stripspace.c                         |   1 +
 builtin/submodule--helper.c                  |   1 +
 builtin/update-index.c                       |   1 +
 cache.h                                      | 163 ------------------
 commit.c                                     |   1 +
 common-main.c                                |   1 +
 config.c                                     |   1 +
 daemon.c                                     |   1 +
 diff.c                                       |   1 +
 dir.c                                        |   1 +
 environment.c                                |   1 +
 git.c                                        |   1 +
 http-fetch.c                                 |   1 +
 http-push.c                                  |   1 +
 imap-send.c                                  |   1 +
 line-log.c                                   |   1 +
 mailmap.c                                    |   1 +
 object-file.c                                |   1 +
 object-name.c                                |   1 +
 path.c                                       |   1 +
 pathspec.c                                   |   1 +
 refs.c                                       |   1 +
 refs/files-backend.c                         |   1 +
 remote-curl.c                                |   1 +
 remote.c                                     |   1 +
 repository.c                                 |   1 +
 revision.c                                   |   1 +
 scalar.c                                     |   1 +
 setup.c                                      |   1 +
 setup.h                                      | 168 +++++++++++++++++++
 submodule.c                                  |   1 +
 symlinks.c                                   |   1 +
 t/helper/test-advise.c                       |   1 +
 t/helper/test-bitmap.c                       |   1 +
 t/helper/test-bloom.c                        |   1 +
 t/helper/test-cache-tree.c                   |   1 +
 t/helper/test-config.c                       |   1 +
 t/helper/test-dump-cache-tree.c              |   2 +-
 t/helper/test-dump-fsmonitor.c               |   1 +
 t/helper/test-dump-split-index.c             |   1 +
 t/helper/test-dump-untracked-cache.c         |   1 +
 t/helper/test-fast-rebase.c                  |   1 +
 t/helper/test-fsmonitor-client.c             |   1 +
 t/helper/test-lazy-init-name-hash.c          |   1 +
 t/helper/test-match-trees.c                  |   1 +
 t/helper/test-oid-array.c                    |   1 +
 t/helper/test-oidmap.c                       |   1 +
 t/helper/test-oidtree.c                      |   1 +
 t/helper/test-pack-mtimes.c                  |   1 +
 t/helper/test-partial-clone.c                |   1 +
 t/helper/test-path-utils.c                   |   1 +
 t/helper/test-proc-receive.c                 |   1 +
 t/helper/test-reach.c                        |   1 +
 t/helper/test-read-cache.c                   |   1 +
 t/helper/test-read-graph.c                   |   1 +
 t/helper/test-read-midx.c                    |   1 +
 t/helper/test-ref-store.c                    |   1 +
 t/helper/test-repository.c                   |   1 +
 t/helper/test-revision-walking.c             |   1 +
 t/helper/test-scrap-cache-tree.c             |   1 +
 t/helper/test-serve-v2.c                     |   1 +
 t/helper/test-submodule-config.c             |   1 +
 t/helper/test-submodule-nested-repo-config.c |   1 +
 t/helper/test-submodule.c                    |   1 +
 t/helper/test-subprocess.c                   |   1 +
 t/helper/test-userdiff.c                     |   1 +
 t/helper/test-write-cache.c                  |   1 +
 trace.c                                      |   1 +
 unpack-trees.c                               |   1 +
 worktree.c                                   |   1 +
 wt-status.c                                  |   1 +
 105 files changed, 271 insertions(+), 164 deletions(-)
 create mode 100644 setup.h

diff --git a/apply.c b/apply.c
index a7c0bccb15c..caa2e0a3bc6 100644
--- a/apply.c
+++ b/apply.c
@@ -27,6 +27,7 @@
 #include "rerere.h"
 #include "apply.h"
 #include "entry.h"
+#include "setup.h"
 #include "wrapper.h"
 
 struct gitdiff_data {
diff --git a/archive.c b/archive.c
index 7aeaaf368f4..cdce5b783a7 100644
--- a/archive.c
+++ b/archive.c
@@ -5,6 +5,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
+#include "setup.h"
 #include "refs.h"
 #include "object-store.h"
 #include "commit.h"
diff --git a/attr.c b/attr.c
index 62127196cb1..2d8aeb8b58c 100644
--- a/attr.c
+++ b/attr.c
@@ -18,6 +18,7 @@
 #include "quote.h"
 #include "revision.h"
 #include "object-store.h"
+#include "setup.h"
 #include "thread-utils.h"
 
 const char git_attr__true[] = "(builtin)true";
diff --git a/blame.c b/blame.c
index b7cd849bb6b..838eb128f01 100644
--- a/blame.c
+++ b/blame.c
@@ -7,6 +7,7 @@
 #include "diffcore.h"
 #include "gettext.h"
 #include "hex.h"
+#include "setup.h"
 #include "tag.h"
 #include "blame.h"
 #include "alloc.h"
diff --git a/builtin/blame.c b/builtin/blame.c
index 9ec82edcbde..fb271bae70e 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -31,6 +31,7 @@
 #include "object-store.h"
 #include "blame.h"
 #include "refs.h"
+#include "setup.h"
 #include "tag.h"
 
 static char blame_usage[] = N_("git blame [<options>] [<rev-opts>] [<rev>] [--] <file>");
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 160590e4ef6..52955e1d389 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -8,6 +8,7 @@
 #include "hook.h"
 #include "hook-list.h"
 #include "diagnose.h"
+#include "setup.h"
 #include "wrapper.h"
 
 static void get_system_info(struct strbuf *sys_info)
diff --git a/builtin/bundle.c b/builtin/bundle.c
index 8ea1232dbce..9e4ae604580 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "abspath.h"
 #include "gettext.h"
+#include "setup.h"
 #include "strvec.h"
 #include "parse-options.h"
 #include "cache.h"
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 5870c4683ab..ec37b8164af 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -6,6 +6,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "quote.h"
+#include "setup.h"
 #include "parse-options.h"
 
 static int all_attrs;
diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index fd0e5f86832..b0263467424 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -5,6 +5,7 @@
 #include "cache.h"
 #include "refs.h"
 #include "builtin.h"
+#include "setup.h"
 #include "strbuf.h"
 
 static const char builtin_check_ref_format_usage[] =
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 828c0363f8a..7df673e3e70 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -15,6 +15,7 @@
 #include "parse-options.h"
 #include "entry.h"
 #include "parallel-checkout.h"
+#include "setup.h"
 
 #define CHECKOUT_ALL 4
 static int nul_term_line;
diff --git a/builtin/checkout.c b/builtin/checkout.c
index e2daad4065c..015011cf84d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -23,6 +23,7 @@
 #include "resolve-undo.h"
 #include "revision.h"
 #include "run-command.h"
+#include "setup.h"
 #include "submodule.h"
 #include "submodule-config.h"
 #include "tree.h"
diff --git a/builtin/clean.c b/builtin/clean.c
index fdcf62c5dfe..14c0d555eac 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -14,6 +14,7 @@
 #include "dir.h"
 #include "gettext.h"
 #include "parse-options.h"
+#include "setup.h"
 #include "string-list.h"
 #include "quote.h"
 #include "column.h"
diff --git a/builtin/clone.c b/builtin/clone.c
index 15dc15408ed..34f46965b95 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -33,6 +33,7 @@
 #include "branch.h"
 #include "remote.h"
 #include "run-command.h"
+#include "setup.h"
 #include "connected.h"
 #include "packfile.h"
 #include "list-objects-filter-options.h"
diff --git a/builtin/config.c b/builtin/config.c
index cf994a216c0..fe79fb60c43 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -9,6 +9,7 @@
 #include "parse-options.h"
 #include "urlmatch.h"
 #include "quote.h"
+#include "setup.h"
 #include "worktree.h"
 #include "wrapper.h"
 
diff --git a/builtin/describe.c b/builtin/describe.c
index 27c6670e934..43b62348bc7 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -15,6 +15,7 @@
 #include "revision.h"
 #include "diff.h"
 #include "hashmap.h"
+#include "setup.h"
 #include "strvec.h"
 #include "run-command.h"
 #include "object-store.h"
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 35dc9b23eef..b9a19bb7d38 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -5,6 +5,7 @@
 #include "commit.h"
 #include "revision.h"
 #include "builtin.h"
+#include "setup.h"
 #include "submodule.h"
 
 static const char diff_cache_usage[] =
diff --git a/builtin/diff.c b/builtin/diff.c
index 20bdb6e6cec..3945683bfe4 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -19,6 +19,7 @@
 #include "revision.h"
 #include "log-tree.h"
 #include "builtin.h"
+#include "setup.h"
 #include "submodule.h"
 #include "oid-array.h"
 
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 3613de6389f..176437d6da3 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -28,6 +28,7 @@
 #include "object-store.h"
 #include "dir.h"
 #include "entry.h"
+#include "setup.h"
 #include "wrapper.h"
 
 static int trust_exit_code;
diff --git a/builtin/gc.c b/builtin/gc.c
index 525c5de5b27..a85f9e3ed3d 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -36,6 +36,7 @@
 #include "exec-cmd.h"
 #include "gettext.h"
 #include "hook.h"
+#include "setup.h"
 #include "wrapper.h"
 
 #define FAILED_RUN "failed to run %s"
diff --git a/builtin/grep.c b/builtin/grep.c
index 3c9c6b38031..b8ebf014f40 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -23,6 +23,7 @@
 #include "quote.h"
 #include "dir.h"
 #include "pathspec.h"
+#include "setup.h"
 #include "submodule.h"
 #include "submodule-config.h"
 #include "object-store.h"
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 7651a7a5f56..a2e160db026 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -14,6 +14,7 @@
 #include "quote.h"
 #include "parse-options.h"
 #include "exec-cmd.h"
+#include "setup.h"
 
 /*
  * This is to create corrupt objects for debugging and as such it
diff --git a/builtin/help.c b/builtin/help.c
index 3fde5c4fd35..87333a02ec4 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -11,6 +11,7 @@
 #include "config-list.h"
 #include "help.h"
 #include "alias.h"
+#include "setup.h"
 
 #ifndef DEFAULT_HELP_FORMAT
 #define DEFAULT_HELP_FORMAT "man"
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index fdce8f88724..823dc5aefb5 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -20,6 +20,7 @@
 #include "object-store.h"
 #include "replace-object.h"
 #include "promisor-remote.h"
+#include "setup.h"
 #include "wrapper.h"
 
 static const char index_pack_usage[] =
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 2ebc9023f56..ba6e0b20fa5 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -12,6 +12,7 @@
 #include "builtin.h"
 #include "exec-cmd.h"
 #include "parse-options.h"
+#include "setup.h"
 #include "worktree.h"
 #include "wrapper.h"
 
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 09deb752ab3..4a8de95ddc4 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -20,6 +20,7 @@
 #include "string-list.h"
 #include "pathspec.h"
 #include "run-command.h"
+#include "setup.h"
 #include "submodule.h"
 #include "submodule-config.h"
 
diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index c0096ee0810..781818d08f5 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -3,6 +3,7 @@
 #include "cache.h"
 #include "config.h"
 #include "gettext.h"
+#include "setup.h"
 #include "xdiff/xdiff.h"
 #include "xdiff-interface.h"
 #include "parse-options.h"
diff --git a/builtin/mv.c b/builtin/mv.c
index c2dd42efbf2..b7c5ffbd8c7 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -16,6 +16,7 @@
 #include "cache-tree.h"
 #include "string-list.h"
 #include "parse-options.h"
+#include "setup.h"
 #include "submodule.h"
 #include "entry.h"
 
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index ec66008d07e..5f24453dcd7 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -19,6 +19,7 @@
 #include "builtin.h"
 #include "parse-options.h"
 #include "resolve-undo.h"
+#include "setup.h"
 #include "submodule.h"
 #include "submodule-config.h"
 
diff --git a/builtin/reset.c b/builtin/reset.c
index 0b62c9651e6..02891e35a84 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -26,6 +26,7 @@
 #include "parse-options.h"
 #include "unpack-trees.h"
 #include "cache-tree.h"
+#include "setup.h"
 #include "submodule.h"
 #include "submodule-config.h"
 #include "dir.h"
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index bba49d56b9f..3a5a2ee5b2d 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -18,6 +18,7 @@
 #include "parse-options.h"
 #include "diff.h"
 #include "revision.h"
+#include "setup.h"
 #include "split-index.h"
 #include "submodule.h"
 #include "commit-reach.h"
diff --git a/builtin/rm.c b/builtin/rm.c
index 5982c3d8122..97775e4c4d0 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -15,6 +15,7 @@
 #include "tree-walk.h"
 #include "parse-options.h"
 #include "string-list.h"
+#include "setup.h"
 #include "submodule.h"
 #include "pathspec.h"
 
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 31f81c25ea2..59d9c440fb5 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -9,6 +9,7 @@
 #include "revision.h"
 #include "utf8.h"
 #include "mailmap.h"
+#include "setup.h"
 #include "shortlog.h"
 #include "parse-options.h"
 #include "trailer.h"
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index f6a120c7c45..512df0f8f54 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -16,6 +16,7 @@
 #include "unpack-trees.h"
 #include "wt-status.h"
 #include "quote.h"
+#include "setup.h"
 #include "sparse-index.h"
 #include "worktree.h"
 
diff --git a/builtin/stash.c b/builtin/stash.c
index 94f81d75d03..30d547fff1f 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -18,6 +18,7 @@
 #include "entry.h"
 #include "rerere.h"
 #include "revision.h"
+#include "setup.h"
 #include "log-tree.h"
 #include "diffcore.h"
 #include "exec-cmd.h"
diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index d8e61459333..53930458ffa 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -3,6 +3,7 @@
 #include "config.h"
 #include "gettext.h"
 #include "parse-options.h"
+#include "setup.h"
 #include "strbuf.h"
 
 static void comment_lines(struct strbuf *buf)
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 2bf2a1a8be5..3cb4a3ce217 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -12,6 +12,7 @@
 #include "quote.h"
 #include "pathspec.h"
 #include "dir.h"
+#include "setup.h"
 #include "submodule.h"
 #include "submodule-config.h"
 #include "string-list.h"
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 4642afaeb77..f97f8d4c9d5 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -20,6 +20,7 @@
 #include "parse-options.h"
 #include "pathspec.h"
 #include "dir.h"
+#include "setup.h"
 #include "split-index.h"
 #include "fsmonitor.h"
 
diff --git a/cache.h b/cache.h
index 720c88f9fd6..bffedd240e7 100644
--- a/cache.h
+++ b/cache.h
@@ -452,67 +452,6 @@ static inline enum object_type object_type(unsigned int mode)
 		OBJ_BLOB;
 }
 
-int is_inside_git_dir(void);
-int is_inside_work_tree(void);
-int get_common_dir_noenv(struct strbuf *sb, const char *gitdir);
-int get_common_dir(struct strbuf *sb, const char *gitdir);
-
-/*
- * Return true if the given path is a git directory; note that this _just_
- * looks at the directory itself. If you want to know whether "foo/.git"
- * is a repository, you must feed that path, not just "foo".
- */
-int is_git_directory(const char *path);
-
-/*
- * Return 1 if the given path is the root of a git repository or
- * submodule, else 0. Will not return 1 for bare repositories with the
- * exception of creating a bare repository in "foo/.git" and calling
- * is_git_repository("foo").
- *
- * If we run into read errors, we err on the side of saying "yes, it is",
- * as we usually consider sub-repos precious, and would prefer to err on the
- * side of not disrupting or deleting them.
- */
-int is_nonbare_repository_dir(struct strbuf *path);
-
-#define READ_GITFILE_ERR_STAT_FAILED 1
-#define READ_GITFILE_ERR_NOT_A_FILE 2
-#define READ_GITFILE_ERR_OPEN_FAILED 3
-#define READ_GITFILE_ERR_READ_FAILED 4
-#define READ_GITFILE_ERR_INVALID_FORMAT 5
-#define READ_GITFILE_ERR_NO_PATH 6
-#define READ_GITFILE_ERR_NOT_A_REPO 7
-#define READ_GITFILE_ERR_TOO_LARGE 8
-void read_gitfile_error_die(int error_code, const char *path, const char *dir);
-const char *read_gitfile_gently(const char *path, int *return_error_code);
-#define read_gitfile(path) read_gitfile_gently((path), NULL)
-const char *resolve_gitdir_gently(const char *suspect, int *return_error_code);
-#define resolve_gitdir(path) resolve_gitdir_gently((path), NULL)
-
-void setup_work_tree(void);
-/*
- * Find the commondir and gitdir of the repository that contains the current
- * working directory, without changing the working directory or other global
- * state. The result is appended to commondir and gitdir.  If the discovered
- * gitdir does not correspond to a worktree, then 'commondir' and 'gitdir' will
- * both have the same result appended to the buffer.  The return value is
- * either 0 upon success and non-zero if no repository was found.
- */
-int discover_git_directory(struct strbuf *commondir,
-			   struct strbuf *gitdir);
-const char *setup_git_directory_gently(int *);
-const char *setup_git_directory(void);
-char *prefix_path(const char *prefix, int len, const char *path);
-char *prefix_path_gently(const char *prefix, int len, int *remaining, const char *path);
-
-int check_filename(const char *prefix, const char *name);
-void verify_filename(const char *prefix,
-		     const char *name,
-		     int diagnose_misspelt_rev);
-void verify_non_filename(const char *prefix, const char *name);
-int path_inside_repo(const char *prefix, const char *path);
-
 #define INIT_DB_QUIET 0x0001
 #define INIT_DB_EXIST_OK 0x0002
 
@@ -521,9 +460,6 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	    const char *initial_branch, unsigned int flags);
 void initialize_repository_version(int hash_algo, int reinit);
 
-void sanitize_stdfds(void);
-int daemonize(void);
-
 /* Initialize and use the cache information */
 struct lock_file;
 void preload_index(struct index_state *index,
@@ -807,79 +743,6 @@ enum fsync_method {
 
 extern enum fsync_method fsync_method;
 
-/*
- * GIT_REPO_VERSION is the version we write by default. The
- * _READ variant is the highest number we know how to
- * handle.
- */
-#define GIT_REPO_VERSION 0
-#define GIT_REPO_VERSION_READ 1
-
-/*
- * You _have_ to initialize a `struct repository_format` using
- * `= REPOSITORY_FORMAT_INIT` before calling `read_repository_format()`.
- */
-struct repository_format {
-	int version;
-	int precious_objects;
-	char *partial_clone; /* value of extensions.partialclone */
-	int worktree_config;
-	int is_bare;
-	int hash_algo;
-	int sparse_index;
-	char *work_tree;
-	struct string_list unknown_extensions;
-	struct string_list v1_only_extensions;
-};
-
-/*
- * Always use this to initialize a `struct repository_format`
- * to a well-defined, default state before calling
- * `read_repository()`.
- */
-#define REPOSITORY_FORMAT_INIT \
-{ \
-	.version = -1, \
-	.is_bare = -1, \
-	.hash_algo = GIT_HASH_SHA1, \
-	.unknown_extensions = STRING_LIST_INIT_DUP, \
-	.v1_only_extensions = STRING_LIST_INIT_DUP, \
-}
-
-/*
- * Read the repository format characteristics from the config file "path" into
- * "format" struct. Returns the numeric version. On error, or if no version is
- * found in the configuration, -1 is returned, format->version is set to -1,
- * and all other fields in the struct are set to the default configuration
- * (REPOSITORY_FORMAT_INIT). Always initialize the struct using
- * REPOSITORY_FORMAT_INIT before calling this function.
- */
-int read_repository_format(struct repository_format *format, const char *path);
-
-/*
- * Free the memory held onto by `format`, but not the struct itself.
- * (No need to use this after `read_repository_format()` fails.)
- */
-void clear_repository_format(struct repository_format *format);
-
-/*
- * Verify that the repository described by repository_format is something we
- * can read. If it is, return 0. Otherwise, return -1, and "err" will describe
- * any errors encountered.
- */
-int verify_repository_format(const struct repository_format *format,
-			     struct strbuf *err);
-
-/*
- * Check the repository format version in the path found in get_git_dir(),
- * and die if it is a version we don't understand. Generally one would
- * set_git_dir() before calling this, and use it only for "are we in a valid
- * repo?".
- *
- * If successful and fmt is not NULL, fill fmt with data.
- */
-void check_repository_format(struct repository_format *fmt);
-
 #define MTIME_CHANGED	0x0001
 #define CTIME_CHANGED	0x0002
 #define OWNER_CHANGED	0x0004
@@ -908,23 +771,6 @@ const char *repo_find_unique_abbrev(struct repository *r, const struct object_id
 int repo_find_unique_abbrev_r(struct repository *r, char *hex, const struct object_id *oid, int len);
 #define find_unique_abbrev_r(hex, oid, len) repo_find_unique_abbrev_r(the_repository, hex, oid, len)
 
-/*
- * NOTE NOTE NOTE!!
- *
- * PERM_UMASK, OLD_PERM_GROUP and OLD_PERM_EVERYBODY enumerations must
- * not be changed. Old repositories have core.sharedrepository written in
- * numeric format, and therefore these values are preserved for compatibility
- * reasons.
- */
-enum sharedrepo {
-	PERM_UMASK          = 0,
-	OLD_PERM_GROUP      = 1,
-	OLD_PERM_EVERYBODY  = 2,
-	PERM_GROUP          = 0660,
-	PERM_EVERYBODY      = 0664
-};
-int git_config_perm(const char *var, const char *value);
-
 /*
  * Create the directory containing the named path, using care to be
  * somewhat safe against races. Return one of the scld_error values to
@@ -1283,15 +1129,6 @@ int ws_blank_line(const char *line, int len);
 void overlay_tree_on_index(struct index_state *istate,
 			   const char *tree_name, const char *prefix);
 
-/* setup.c */
-struct startup_info {
-	int have_repository;
-	const char *prefix;
-	const char *original_cwd;
-};
-extern struct startup_info *startup_info;
-extern const char *tmp_original_cwd;
-
 /* merge.c */
 struct commit_list;
 int try_merge_command(struct repository *r,
diff --git a/commit.c b/commit.c
index f88fc5e1a2c..3868f047f1b 100644
--- a/commit.c
+++ b/commit.c
@@ -23,6 +23,7 @@
 #include "refs.h"
 #include "commit-reach.h"
 #include "run-command.h"
+#include "setup.h"
 #include "shallow.h"
 #include "hook.h"
 
diff --git a/common-main.c b/common-main.c
index 184d1534d2d..b83cb5cf066 100644
--- a/common-main.c
+++ b/common-main.c
@@ -2,6 +2,7 @@
 #include "exec-cmd.h"
 #include "gettext.h"
 #include "attr.h"
+#include "setup.h"
 
 /*
  * Many parts of Git have subprograms communicate via pipe, expect the
diff --git a/config.c b/config.c
index 5b1a5d52052..03a4fcaba5b 100644
--- a/config.c
+++ b/config.c
@@ -27,6 +27,7 @@
 #include "color.h"
 #include "replace-object.h"
 #include "refs.h"
+#include "setup.h"
 #include "worktree.h"
 #include "wrapper.h"
 
diff --git a/daemon.c b/daemon.c
index b56a8f9717d..db8a31a6ea2 100644
--- a/daemon.c
+++ b/daemon.c
@@ -5,6 +5,7 @@
 #include "environment.h"
 #include "pkt-line.h"
 #include "run-command.h"
+#include "setup.h"
 #include "strbuf.h"
 #include "string-list.h"
 #include "wrapper.h"
diff --git a/diff.c b/diff.c
index dcf1a940942..b858e59c5ae 100644
--- a/diff.c
+++ b/diff.c
@@ -33,6 +33,7 @@
 #include "help.h"
 #include "promisor-remote.h"
 #include "dir.h"
+#include "setup.h"
 #include "strmap.h"
 #include "wrapper.h"
 
diff --git a/dir.c b/dir.c
index 06f8aa3c01b..4cc2b1ead47 100644
--- a/dir.c
+++ b/dir.c
@@ -21,6 +21,7 @@
 #include "varint.h"
 #include "ewah/ewok.h"
 #include "fsmonitor.h"
+#include "setup.h"
 #include "submodule-config.h"
 #include "wrapper.h"
 
diff --git a/environment.c b/environment.c
index bf02f3cf487..649d16ac27c 100644
--- a/environment.c
+++ b/environment.c
@@ -22,6 +22,7 @@
 #include "replace-object.h"
 #include "tmp-objdir.h"
 #include "chdir-notify.h"
+#include "setup.h"
 #include "shallow.h"
 #include "wrapper.h"
 
diff --git a/git.c b/git.c
index b24c105e83f..77f920a6f6f 100644
--- a/git.c
+++ b/git.c
@@ -7,6 +7,7 @@
 #include "run-command.h"
 #include "alias.h"
 #include "replace-object.h"
+#include "setup.h"
 #include "shallow.h"
 
 #define RUN_SETUP		(1<<0)
diff --git a/http-fetch.c b/http-fetch.c
index 454933351b2..c874d3402dd 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -5,6 +5,7 @@
 #include "hex.h"
 #include "http.h"
 #include "walker.h"
+#include "setup.h"
 #include "strvec.h"
 #include "urlmatch.h"
 #include "trace2.h"
diff --git a/http-push.c b/http-push.c
index 40373bc4863..e73864b51f5 100644
--- a/http-push.c
+++ b/http-push.c
@@ -12,6 +12,7 @@
 #include "exec-cmd.h"
 #include "remote.h"
 #include "list-objects.h"
+#include "setup.h"
 #include "sigchain.h"
 #include "strvec.h"
 #include "packfile.h"
diff --git a/imap-send.c b/imap-send.c
index aa5b2f252d2..a62424e90a4 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -28,6 +28,7 @@
 #include "gettext.h"
 #include "run-command.h"
 #include "parse-options.h"
+#include "setup.h"
 #include "wrapper.h"
 #if defined(NO_OPENSSL) && !defined(HAVE_OPENSSL_CSPRNG)
 typedef void *SSL;
diff --git a/line-log.c b/line-log.c
index 6e7fc4b2e0b..84c8093c517 100644
--- a/line-log.c
+++ b/line-log.c
@@ -16,6 +16,7 @@
 #include "graph.h"
 #include "userdiff.h"
 #include "line-log.h"
+#include "setup.h"
 #include "strvec.h"
 #include "bloom.h"
 
diff --git a/mailmap.c b/mailmap.c
index 2c6e9b238dd..c24a16eaf48 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -3,6 +3,7 @@
 #include "string-list.h"
 #include "mailmap.h"
 #include "object-store.h"
+#include "setup.h"
 
 #define DEBUG_MAILMAP 0
 #if DEBUG_MAILMAP
diff --git a/object-file.c b/object-file.c
index 3da6cd68861..05fff230f73 100644
--- a/object-file.c
+++ b/object-file.c
@@ -37,6 +37,7 @@
 #include "packfile.h"
 #include "object-store.h"
 #include "promisor-remote.h"
+#include "setup.h"
 #include "submodule.h"
 #include "fsck.h"
 #include "wrapper.h"
diff --git a/object-name.c b/object-name.c
index 3b0ce8ef05a..ce973e01505 100644
--- a/object-name.c
+++ b/object-name.c
@@ -15,6 +15,7 @@
 #include "packfile.h"
 #include "object-store.h"
 #include "repository.h"
+#include "setup.h"
 #include "submodule.h"
 #include "midx.h"
 #include "commit-reach.h"
diff --git a/path.c b/path.c
index 5d5a15c13d6..a1702434979 100644
--- a/path.c
+++ b/path.c
@@ -11,6 +11,7 @@
 #include "string-list.h"
 #include "dir.h"
 #include "worktree.h"
+#include "setup.h"
 #include "submodule-config.h"
 #include "path.h"
 #include "packfile.h"
diff --git a/pathspec.c b/pathspec.c
index 5fb7b5f26c9..6972d515f0c 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -6,6 +6,7 @@
 #include "gettext.h"
 #include "pathspec.h"
 #include "attr.h"
+#include "setup.h"
 #include "strvec.h"
 #include "quote.h"
 
diff --git a/refs.c b/refs.c
index 04520e5a6b8..21b317e8153 100644
--- a/refs.c
+++ b/refs.c
@@ -22,6 +22,7 @@
 #include "worktree.h"
 #include "strvec.h"
 #include "repository.h"
+#include "setup.h"
 #include "sigchain.h"
 #include "date.h"
 #include "commit.h"
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0c3138ede8f..d2b8925ebd0 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -14,6 +14,7 @@
 #include "../object.h"
 #include "../dir.h"
 #include "../chdir-notify.h"
+#include "../setup.h"
 #include "../worktree.h"
 #include "../wrapper.h"
 
diff --git a/remote-curl.c b/remote-curl.c
index eb382a1e35d..260ea200bb0 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -18,6 +18,7 @@
 #include "credential.h"
 #include "oid-array.h"
 #include "send-pack.h"
+#include "setup.h"
 #include "protocol.h"
 #include "quote.h"
 #include "transport.h"
diff --git a/remote.c b/remote.c
index aeca3ff8136..c29e2f52981 100644
--- a/remote.c
+++ b/remote.c
@@ -15,6 +15,7 @@
 #include "revision.h"
 #include "dir.h"
 #include "tag.h"
+#include "setup.h"
 #include "string-list.h"
 #include "strvec.h"
 #include "commit-reach.h"
diff --git a/repository.c b/repository.c
index 4412f633224..f6d9f5db08e 100644
--- a/repository.c
+++ b/repository.c
@@ -11,6 +11,7 @@
 #include "object.h"
 #include "lockfile.h"
 #include "remote.h"
+#include "setup.h"
 #include "submodule-config.h"
 #include "sparse-index.h"
 #include "promisor-remote.h"
diff --git a/revision.c b/revision.c
index 53fdeef0787..f98691a3531 100644
--- a/revision.c
+++ b/revision.c
@@ -29,6 +29,7 @@
 #include "bisect.h"
 #include "packfile.h"
 #include "worktree.h"
+#include "setup.h"
 #include "strvec.h"
 #include "commit-reach.h"
 #include "commit-graph.h"
diff --git a/scalar.c b/scalar.c
index fe61a3ebdd7..27635658c01 100644
--- a/scalar.c
+++ b/scalar.c
@@ -15,6 +15,7 @@
 #include "dir.h"
 #include "packfile.h"
 #include "help.h"
+#include "setup.h"
 
 static void setup_enlistment_directory(int argc, const char **argv,
 				       const char * const *usagestr,
diff --git a/setup.c b/setup.c
index cfdc849a78c..6c5b85e96c1 100644
--- a/setup.c
+++ b/setup.c
@@ -5,6 +5,7 @@
 #include "repository.h"
 #include "config.h"
 #include "dir.h"
+#include "setup.h"
 #include "string-list.h"
 #include "chdir-notify.h"
 #include "promisor-remote.h"
diff --git a/setup.h b/setup.h
new file mode 100644
index 00000000000..4c1ca9d0c94
--- /dev/null
+++ b/setup.h
@@ -0,0 +1,168 @@
+#ifndef SETUP_H
+#define SETUP_H
+
+#include "string-list.h"
+
+int is_inside_git_dir(void);
+int is_inside_work_tree(void);
+int get_common_dir_noenv(struct strbuf *sb, const char *gitdir);
+int get_common_dir(struct strbuf *sb, const char *gitdir);
+
+/*
+ * Return true if the given path is a git directory; note that this _just_
+ * looks at the directory itself. If you want to know whether "foo/.git"
+ * is a repository, you must feed that path, not just "foo".
+ */
+int is_git_directory(const char *path);
+
+/*
+ * Return 1 if the given path is the root of a git repository or
+ * submodule, else 0. Will not return 1 for bare repositories with the
+ * exception of creating a bare repository in "foo/.git" and calling
+ * is_git_repository("foo").
+ *
+ * If we run into read errors, we err on the side of saying "yes, it is",
+ * as we usually consider sub-repos precious, and would prefer to err on the
+ * side of not disrupting or deleting them.
+ */
+int is_nonbare_repository_dir(struct strbuf *path);
+
+#define READ_GITFILE_ERR_STAT_FAILED 1
+#define READ_GITFILE_ERR_NOT_A_FILE 2
+#define READ_GITFILE_ERR_OPEN_FAILED 3
+#define READ_GITFILE_ERR_READ_FAILED 4
+#define READ_GITFILE_ERR_INVALID_FORMAT 5
+#define READ_GITFILE_ERR_NO_PATH 6
+#define READ_GITFILE_ERR_NOT_A_REPO 7
+#define READ_GITFILE_ERR_TOO_LARGE 8
+void read_gitfile_error_die(int error_code, const char *path, const char *dir);
+const char *read_gitfile_gently(const char *path, int *return_error_code);
+#define read_gitfile(path) read_gitfile_gently((path), NULL)
+const char *resolve_gitdir_gently(const char *suspect, int *return_error_code);
+#define resolve_gitdir(path) resolve_gitdir_gently((path), NULL)
+
+void setup_work_tree(void);
+/*
+ * Find the commondir and gitdir of the repository that contains the current
+ * working directory, without changing the working directory or other global
+ * state. The result is appended to commondir and gitdir.  If the discovered
+ * gitdir does not correspond to a worktree, then 'commondir' and 'gitdir' will
+ * both have the same result appended to the buffer.  The return value is
+ * either 0 upon success and non-zero if no repository was found.
+ */
+int discover_git_directory(struct strbuf *commondir,
+			   struct strbuf *gitdir);
+const char *setup_git_directory_gently(int *);
+const char *setup_git_directory(void);
+char *prefix_path(const char *prefix, int len, const char *path);
+char *prefix_path_gently(const char *prefix, int len, int *remaining, const char *path);
+
+int check_filename(const char *prefix, const char *name);
+void verify_filename(const char *prefix,
+		     const char *name,
+		     int diagnose_misspelt_rev);
+void verify_non_filename(const char *prefix, const char *name);
+int path_inside_repo(const char *prefix, const char *path);
+
+void sanitize_stdfds(void);
+int daemonize(void);
+
+/*
+ * GIT_REPO_VERSION is the version we write by default. The
+ * _READ variant is the highest number we know how to
+ * handle.
+ */
+#define GIT_REPO_VERSION 0
+#define GIT_REPO_VERSION_READ 1
+
+/*
+ * You _have_ to initialize a `struct repository_format` using
+ * `= REPOSITORY_FORMAT_INIT` before calling `read_repository_format()`.
+ */
+struct repository_format {
+	int version;
+	int precious_objects;
+	char *partial_clone; /* value of extensions.partialclone */
+	int worktree_config;
+	int is_bare;
+	int hash_algo;
+	int sparse_index;
+	char *work_tree;
+	struct string_list unknown_extensions;
+	struct string_list v1_only_extensions;
+};
+
+/*
+ * Always use this to initialize a `struct repository_format`
+ * to a well-defined, default state before calling
+ * `read_repository()`.
+ */
+#define REPOSITORY_FORMAT_INIT \
+{ \
+	.version = -1, \
+	.is_bare = -1, \
+	.hash_algo = GIT_HASH_SHA1, \
+	.unknown_extensions = STRING_LIST_INIT_DUP, \
+	.v1_only_extensions = STRING_LIST_INIT_DUP, \
+}
+
+/*
+ * Read the repository format characteristics from the config file "path" into
+ * "format" struct. Returns the numeric version. On error, or if no version is
+ * found in the configuration, -1 is returned, format->version is set to -1,
+ * and all other fields in the struct are set to the default configuration
+ * (REPOSITORY_FORMAT_INIT). Always initialize the struct using
+ * REPOSITORY_FORMAT_INIT before calling this function.
+ */
+int read_repository_format(struct repository_format *format, const char *path);
+
+/*
+ * Free the memory held onto by `format`, but not the struct itself.
+ * (No need to use this after `read_repository_format()` fails.)
+ */
+void clear_repository_format(struct repository_format *format);
+
+/*
+ * Verify that the repository described by repository_format is something we
+ * can read. If it is, return 0. Otherwise, return -1, and "err" will describe
+ * any errors encountered.
+ */
+int verify_repository_format(const struct repository_format *format,
+			     struct strbuf *err);
+
+/*
+ * Check the repository format version in the path found in get_git_dir(),
+ * and die if it is a version we don't understand. Generally one would
+ * set_git_dir() before calling this, and use it only for "are we in a valid
+ * repo?".
+ *
+ * If successful and fmt is not NULL, fill fmt with data.
+ */
+void check_repository_format(struct repository_format *fmt);
+
+/*
+ * NOTE NOTE NOTE!!
+ *
+ * PERM_UMASK, OLD_PERM_GROUP and OLD_PERM_EVERYBODY enumerations must
+ * not be changed. Old repositories have core.sharedrepository written in
+ * numeric format, and therefore these values are preserved for compatibility
+ * reasons.
+ */
+enum sharedrepo {
+	PERM_UMASK          = 0,
+	OLD_PERM_GROUP      = 1,
+	OLD_PERM_EVERYBODY  = 2,
+	PERM_GROUP          = 0660,
+	PERM_EVERYBODY      = 0664
+};
+int git_config_perm(const char *var, const char *value);
+
+struct startup_info {
+	int have_repository;
+	const char *prefix;
+	const char *original_cwd;
+};
+extern struct startup_info *startup_info;
+extern const char *tmp_original_cwd;
+
+#endif /* SETUP_H */
diff --git a/submodule.c b/submodule.c
index acf030b95e4..75e0d45cbcb 100644
--- a/submodule.c
+++ b/submodule.c
@@ -26,6 +26,7 @@
 #include "parse-options.h"
 #include "object-store.h"
 #include "commit-reach.h"
+#include "setup.h"
 #include "shallow.h"
 
 static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
diff --git a/symlinks.c b/symlinks.c
index c35c8d4408d..27ecc93693b 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "gettext.h"
+#include "setup.h"
 
 static int threaded_check_leading_path(struct cache_def *cache, const char *name,
 				       int len, int warn_on_lstat_err);
diff --git a/t/helper/test-advise.c b/t/helper/test-advise.c
index cb881139f73..4e6ed30afa1 100644
--- a/t/helper/test-advise.c
+++ b/t/helper/test-advise.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "advice.h"
 #include "config.h"
+#include "setup.h"
 
 int cmd__advise_if_enabled(int argc, const char **argv)
 {
diff --git a/t/helper/test-bitmap.c b/t/helper/test-bitmap.c
index 5bb489882da..af43ee1cb5e 100644
--- a/t/helper/test-bitmap.c
+++ b/t/helper/test-bitmap.c
@@ -1,6 +1,7 @@
 #include "test-tool.h"
 #include "git-compat-util.h"
 #include "pack-bitmap.h"
+#include "setup.h"
 
 static int bitmap_list_commits(void)
 {
diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index 127f134a2a6..e5754b8da62 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -3,6 +3,7 @@
 #include "hex.h"
 #include "test-tool.h"
 #include "commit.h"
+#include "setup.h"
 
 static struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
 
diff --git a/t/helper/test-cache-tree.c b/t/helper/test-cache-tree.c
index 8b7a8fce1ee..cdaf5046f5a 100644
--- a/t/helper/test-cache-tree.c
+++ b/t/helper/test-cache-tree.c
@@ -6,6 +6,7 @@
 #include "tree.h"
 #include "cache-tree.h"
 #include "parse-options.h"
+#include "setup.h"
 
 static char const * const test_cache_tree_usage[] = {
 	N_("test-tool cache-tree <options> (control|prime|update)"),
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 4ba9eb65606..5877188f3ad 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -1,6 +1,7 @@
 #include "test-tool.h"
 #include "cache.h"
 #include "config.h"
+#include "setup.h"
 #include "string-list.h"
 
 /*
diff --git a/t/helper/test-dump-cache-tree.c b/t/helper/test-dump-cache-tree.c
index 92dfc1aa8c4..715aabfbae7 100644
--- a/t/helper/test-dump-cache-tree.c
+++ b/t/helper/test-dump-cache-tree.c
@@ -4,7 +4,7 @@
 #include "hex.h"
 #include "tree.h"
 #include "cache-tree.h"
-
+#include "setup.h"
 
 static void dump_one(struct cache_tree *it, const char *pfx, const char *x)
 {
diff --git a/t/helper/test-dump-fsmonitor.c b/t/helper/test-dump-fsmonitor.c
index 975f0ac8905..7e9de296db3 100644
--- a/t/helper/test-dump-fsmonitor.c
+++ b/t/helper/test-dump-fsmonitor.c
@@ -1,5 +1,6 @@
 #include "test-tool.h"
 #include "cache.h"
+#include "setup.h"
 
 int cmd__dump_fsmonitor(int ac, const char **av)
 {
diff --git a/t/helper/test-dump-split-index.c b/t/helper/test-dump-split-index.c
index 813d0a38fae..289a01c10ac 100644
--- a/t/helper/test-dump-split-index.c
+++ b/t/helper/test-dump-split-index.c
@@ -2,6 +2,7 @@
 #include "test-tool.h"
 #include "cache.h"
 #include "hex.h"
+#include "setup.h"
 #include "split-index.h"
 #include "ewah/ewok.h"
 
diff --git a/t/helper/test-dump-untracked-cache.c b/t/helper/test-dump-untracked-cache.c
index af953fabe87..415f55f31da 100644
--- a/t/helper/test-dump-untracked-cache.c
+++ b/t/helper/test-dump-untracked-cache.c
@@ -3,6 +3,7 @@
 #include "cache.h"
 #include "dir.h"
 #include "hex.h"
+#include "setup.h"
 
 static int compare_untracked(const void *a_, const void *b_)
 {
diff --git a/t/helper/test-fast-rebase.c b/t/helper/test-fast-rebase.c
index 627a6bdc3d0..e402c35a702 100644
--- a/t/helper/test-fast-rebase.c
+++ b/t/helper/test-fast-rebase.c
@@ -23,6 +23,7 @@
 #include "refs.h"
 #include "revision.h"
 #include "sequencer.h"
+#include "setup.h"
 #include "strvec.h"
 #include "tree.h"
 
diff --git a/t/helper/test-fsmonitor-client.c b/t/helper/test-fsmonitor-client.c
index c43fc976b82..a37236cd0a6 100644
--- a/t/helper/test-fsmonitor-client.c
+++ b/t/helper/test-fsmonitor-client.c
@@ -7,6 +7,7 @@
 #include "cache.h"
 #include "parse-options.h"
 #include "fsmonitor-ipc.h"
+#include "setup.h"
 #include "thread-utils.h"
 #include "trace2.h"
 #include "wrapper.h"
diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper/test-lazy-init-name-hash.c
index 2b678a45793..06ce3a47ccf 100644
--- a/t/helper/test-lazy-init-name-hash.c
+++ b/t/helper/test-lazy-init-name-hash.c
@@ -3,6 +3,7 @@
 #include "cache.h"
 #include "environment.h"
 #include "parse-options.h"
+#include "setup.h"
 
 static int single;
 static int multi;
diff --git a/t/helper/test-match-trees.c b/t/helper/test-match-trees.c
index 04bc2563f3e..64705734dfe 100644
--- a/t/helper/test-match-trees.c
+++ b/t/helper/test-match-trees.c
@@ -1,6 +1,7 @@
 #include "test-tool.h"
 #include "cache.h"
 #include "hex.h"
+#include "setup.h"
 #include "tree.h"
 
 int cmd__match_trees(int ac, const char **av)
diff --git a/t/helper/test-oid-array.c b/t/helper/test-oid-array.c
index 0906993ad59..fd6f73ea03b 100644
--- a/t/helper/test-oid-array.c
+++ b/t/helper/test-oid-array.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "hex.h"
 #include "oid-array.h"
+#include "setup.h"
 
 static int print_oid(const struct object_id *oid, void *data)
 {
diff --git a/t/helper/test-oidmap.c b/t/helper/test-oidmap.c
index 883d40efd45..f1b3dbe376b 100644
--- a/t/helper/test-oidmap.c
+++ b/t/helper/test-oidmap.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "hex.h"
 #include "oidmap.h"
+#include "setup.h"
 #include "strbuf.h"
 
 /* key is an oid and value is a name (could be a refname for example) */
diff --git a/t/helper/test-oidtree.c b/t/helper/test-oidtree.c
index 0b82431a70f..edcb7e9f448 100644
--- a/t/helper/test-oidtree.c
+++ b/t/helper/test-oidtree.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "hex.h"
 #include "oidtree.h"
+#include "setup.h"
 
 static enum cb_next print_oid(const struct object_id *oid, void *data)
 {
diff --git a/t/helper/test-pack-mtimes.c b/t/helper/test-pack-mtimes.c
index 0e53dee9e57..75ca1505a37 100644
--- a/t/helper/test-pack-mtimes.c
+++ b/t/helper/test-pack-mtimes.c
@@ -5,6 +5,7 @@
 #include "object-store.h"
 #include "packfile.h"
 #include "pack-mtimes.h"
+#include "setup.h"
 
 static void dump_mtimes(struct packed_git *p)
 {
diff --git a/t/helper/test-partial-clone.c b/t/helper/test-partial-clone.c
index da17fd37eb1..cce496944ac 100644
--- a/t/helper/test-partial-clone.c
+++ b/t/helper/test-partial-clone.c
@@ -3,6 +3,7 @@
 #include "test-tool.h"
 #include "repository.h"
 #include "object-store.h"
+#include "setup.h"
 
 /*
  * Prints the size of the object corresponding to the given hash in a specific
diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index cc266e3ec09..4f5ac2fadce 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "abspath.h"
 #include "environment.h"
+#include "setup.h"
 #include "string-list.h"
 #include "utf8.h"
 
diff --git a/t/helper/test-proc-receive.c b/t/helper/test-proc-receive.c
index 7e12d4f9aa2..7c8de7b562a 100644
--- a/t/helper/test-proc-receive.c
+++ b/t/helper/test-proc-receive.c
@@ -3,6 +3,7 @@
 #include "hex.h"
 #include "parse-options.h"
 #include "pkt-line.h"
+#include "setup.h"
 #include "sigchain.h"
 #include "test-tool.h"
 
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 09c711038ce..91bb2dec1df 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -8,6 +8,7 @@
 #include "hex.h"
 #include "parse-options.h"
 #include "ref-filter.h"
+#include "setup.h"
 #include "string-list.h"
 #include "tag.h"
 
diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index 84818363d5b..a4c24d0e421 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -2,6 +2,7 @@
 #include "test-tool.h"
 #include "cache.h"
 #include "config.h"
+#include "setup.h"
 #include "wrapper.h"
 
 int cmd__read_cache(int argc, const char **argv)
diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 98b73bb8f25..e21b0805f3c 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -4,6 +4,7 @@
 #include "repository.h"
 #include "object-store.h"
 #include "bloom.h"
+#include "setup.h"
 
 int cmd__read_graph(int argc, const char **argv)
 {
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 0a883cdf26b..05c4f2b2625 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -5,6 +5,7 @@
 #include "repository.h"
 #include "object-store.h"
 #include "pack-bitmap.h"
+#include "setup.h"
 
 static int read_midx_file(const char *object_dir, int show_objects)
 {
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 1745b088b7c..8717b95e84f 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "hex.h"
 #include "refs.h"
+#include "setup.h"
 #include "worktree.h"
 #include "object-store.h"
 #include "repository.h"
diff --git a/t/helper/test-repository.c b/t/helper/test-repository.c
index c444775eb0f..6774f6245f0 100644
--- a/t/helper/test-repository.c
+++ b/t/helper/test-repository.c
@@ -8,6 +8,7 @@
 #include "object-store.h"
 #include "object.h"
 #include "repository.h"
+#include "setup.h"
 #include "tree.h"
 
 static void test_parse_commit_in_graph(const char *gitdir, const char *worktree,
diff --git a/t/helper/test-revision-walking.c b/t/helper/test-revision-walking.c
index 4a45d5bac2a..f2df4334063 100644
--- a/t/helper/test-revision-walking.c
+++ b/t/helper/test-revision-walking.c
@@ -13,6 +13,7 @@
 #include "commit.h"
 #include "diff.h"
 #include "revision.h"
+#include "setup.h"
 
 static void print_commit(struct commit *commit)
 {
diff --git a/t/helper/test-scrap-cache-tree.c b/t/helper/test-scrap-cache-tree.c
index a26107ed70a..15b7688774c 100644
--- a/t/helper/test-scrap-cache-tree.c
+++ b/t/helper/test-scrap-cache-tree.c
@@ -2,6 +2,7 @@
 #include "test-tool.h"
 #include "cache.h"
 #include "lockfile.h"
+#include "setup.h"
 #include "tree.h"
 #include "cache-tree.h"
 
diff --git a/t/helper/test-serve-v2.c b/t/helper/test-serve-v2.c
index 497d72058de..7d590ab7227 100644
--- a/t/helper/test-serve-v2.c
+++ b/t/helper/test-serve-v2.c
@@ -3,6 +3,7 @@
 #include "gettext.h"
 #include "parse-options.h"
 #include "serve.h"
+#include "setup.h"
 
 static char const * const serve_usage[] = {
 	N_("test-tool serve-v2 [<options>]"),
diff --git a/t/helper/test-submodule-config.c b/t/helper/test-submodule-config.c
index 22a41c40926..256bfa6e9e1 100644
--- a/t/helper/test-submodule-config.c
+++ b/t/helper/test-submodule-config.c
@@ -1,6 +1,7 @@
 #include "test-tool.h"
 #include "cache.h"
 #include "config.h"
+#include "setup.h"
 #include "submodule-config.h"
 #include "submodule.h"
 
diff --git a/t/helper/test-submodule-nested-repo-config.c b/t/helper/test-submodule-nested-repo-config.c
index a3848a8b668..aaffd422d6e 100644
--- a/t/helper/test-submodule-nested-repo-config.c
+++ b/t/helper/test-submodule-nested-repo-config.c
@@ -1,5 +1,6 @@
 #include "test-tool.h"
 #include "cache.h"
+#include "setup.h"
 #include "submodule-config.h"
 
 static void die_usage(const char **argv, const char *msg)
diff --git a/t/helper/test-submodule.c b/t/helper/test-submodule.c
index e060cc62268..f18ca46dce4 100644
--- a/t/helper/test-submodule.c
+++ b/t/helper/test-submodule.c
@@ -3,6 +3,7 @@
 #include "cache.h"
 #include "parse-options.h"
 #include "remote.h"
+#include "setup.h"
 #include "submodule-config.h"
 #include "submodule.h"
 
diff --git a/t/helper/test-subprocess.c b/t/helper/test-subprocess.c
index ff22f2fa2c5..65a355cc590 100644
--- a/t/helper/test-subprocess.c
+++ b/t/helper/test-subprocess.c
@@ -1,6 +1,7 @@
 #include "test-tool.h"
 #include "cache.h"
 #include "run-command.h"
+#include "setup.h"
 
 int cmd__subprocess(int argc, const char **argv)
 {
diff --git a/t/helper/test-userdiff.c b/t/helper/test-userdiff.c
index a2b56b9cae5..0cd7ee12b7e 100644
--- a/t/helper/test-userdiff.c
+++ b/t/helper/test-userdiff.c
@@ -1,5 +1,6 @@
 #include "test-tool.h"
 #include "cache.h"
+#include "setup.h"
 #include "userdiff.h"
 #include "config.h"
 
diff --git a/t/helper/test-write-cache.c b/t/helper/test-write-cache.c
index 7d45cd61e82..a93417ed3a9 100644
--- a/t/helper/test-write-cache.c
+++ b/t/helper/test-write-cache.c
@@ -2,6 +2,7 @@
 #include "test-tool.h"
 #include "cache.h"
 #include "lockfile.h"
+#include "setup.h"
 
 int cmd__write_cache(int argc, const char **argv)
 {
diff --git a/trace.c b/trace.c
index 9c85b71ec6a..81318a2455d 100644
--- a/trace.c
+++ b/trace.c
@@ -25,6 +25,7 @@
 #include "abspath.h"
 #include "environment.h"
 #include "quote.h"
+#include "setup.h"
 #include "wrapper.h"
 
 struct trace_key trace_default_key = { "GIT_TRACE", 0, 0, 0 };
diff --git a/unpack-trees.c b/unpack-trees.c
index 0ff4bbc6b96..a26fda3493f 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -22,6 +22,7 @@
 #include "promisor-remote.h"
 #include "entry.h"
 #include "parallel-checkout.h"
+#include "setup.h"
 
 /*
  * Error messages expected by scripts out of plumbing commands such as
diff --git a/worktree.c b/worktree.c
index 3861ab639ca..edef9e161dc 100644
--- a/worktree.c
+++ b/worktree.c
@@ -5,6 +5,7 @@
 #include "gettext.h"
 #include "repository.h"
 #include "refs.h"
+#include "setup.h"
 #include "strbuf.h"
 #include "worktree.h"
 #include "dir.h"
diff --git a/wt-status.c b/wt-status.c
index 106e46480a1..16e0df5736f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -16,6 +16,7 @@
 #include "refs.h"
 #include "submodule.h"
 #include "column.h"
+#include "setup.h"
 #include "strbuf.h"
 #include "utf8.h"
 #include "worktree.h"
-- 
gitgitgadget


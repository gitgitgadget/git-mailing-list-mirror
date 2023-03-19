Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CB2C6FD1F
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 06:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjCSG3B (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 02:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCSG2b (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 02:28:31 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E0A1CF47
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:28:17 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t15so7658494wrz.7
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679207295;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yv0ASuG9UAI2BoP68/vkYFqCFMjRn8QKfPLqcAW4fDk=;
        b=oNWtp51XOwtS0vb8d6/Xhee0u11P8VWUY3vKcYBx9nqcsEhG1GAhCcWQexErG0xYpG
         zayutK4am5CTbWnioq86sJNvBS11uPumzyLdO91stODoTsnQjudDr0q2F0jUuzQn/r4b
         a8KZPX4RCrOFSnCIHyv65/Cwx82I32R6urM2ItwQPu9+Mj7L+Cl67/xPiGpPUPqaemqg
         A9efIOk/iX50OamjtMevADRnFHXeygcv7aIn7LO7KAH7epopipFTL4AA37ShR0H/QXf0
         5O43W9OXOCXTBDgZwcQYI5Qi687ObHa/9RYpfzKUBIucRwnsKfKCMstdGUFWCRwBp6TL
         Qvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679207295;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yv0ASuG9UAI2BoP68/vkYFqCFMjRn8QKfPLqcAW4fDk=;
        b=akV6IHeAzTZ1G5OcuSSW8L5/ajhOgnKvnxYC8GtjyDXEzcnWbpoEfEQm7iOF3trioZ
         HtIfdAEHXx5FBoiTIzdIjh7n6iisuobuc0Jv/Vgz2qUZYEXfeLHT+j7w0F95+y/C+/hy
         sHYP5pYfePosc6HUyVS7CwgWUDx1cM0y/Wm32ClOfp3IyES81PYVidCE+GjqkU1SO8D/
         786yYyUQINZLXz/9/QlvO8+4Z79rV/nks6aKkPrX4s+I10Fd/EcvrB3WaoBWF4h8Q+u9
         H1zFp4AwRhFbRkOhcngbw5/kiz+6Pejt4JxWkTu6v/+TwmtFS92U4gVyrSoh92lrXO0E
         bgMw==
X-Gm-Message-State: AO0yUKWv1cn7x/VHHYYuUC16EVc9XzqJn+ad2O0derIa2TKBi/1mHHxK
        GwpJ4Xnr0MmIiUHC2mkNn9ajyHmrO6Q=
X-Google-Smtp-Source: AK7set8mdDUBDYI8ALrtPTQdnAAEyCT3J09f9mST+HvC1E1r5i5f/tDZ4U/g3BU0xLC3kdXPqYmyGw==
X-Received: by 2002:a5d:5349:0:b0:2ce:9f35:59b9 with SMTP id t9-20020a5d5349000000b002ce9f3559b9mr10681765wrv.17.1679207295073;
        Sat, 18 Mar 2023 23:28:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y16-20020a5d4ad0000000b002d51d10a3fasm2591186wrs.55.2023.03.18.23.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 23:28:14 -0700 (PDT)
Message-Id: <fa7449b5b9990b58b524f106d22c68aaf1a09b77.1679207285.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1493.git.1679207282.gitgitgadget@gmail.com>
References: <pull.1493.git.1679207282.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 19 Mar 2023 06:27:57 +0000
Subject: [PATCH 11/16] environment.h: move declarations for environment.c
 functions from cache.h
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
 apply.c                             |   1 +
 archive.c                           |   1 +
 attr.c                              |   1 +
 bisect.c                            |   1 +
 branch.c                            |   1 +
 builtin/am.c                        |   1 +
 builtin/bisect.c                    |   1 +
 builtin/blame.c                     |   1 +
 builtin/cat-file.c                  |   1 +
 builtin/check-attr.c                |   1 +
 builtin/checkout.c                  |   1 +
 builtin/clone.c                     |   1 +
 builtin/commit-graph.c              |   1 +
 builtin/config.c                    |   1 +
 builtin/count-objects.c             |   1 +
 builtin/describe.c                  |   1 +
 builtin/difftool.c                  |   1 +
 builtin/fast-import.c               |   1 +
 builtin/fetch.c                     |   1 +
 builtin/fsmonitor--daemon.c         |   1 +
 builtin/gc.c                        |   1 +
 builtin/index-pack.c                |   1 +
 builtin/init-db.c                   |   1 +
 builtin/log.c                       |   1 +
 builtin/mailinfo.c                  |   1 +
 builtin/multi-pack-index.c          |   1 +
 builtin/mv.c                        |   1 +
 builtin/name-rev.c                  |   1 +
 builtin/pack-objects.c              |   1 +
 builtin/prune.c                     |   1 +
 builtin/push.c                      |   1 +
 builtin/rebase.c                    |   1 +
 builtin/receive-pack.c              |   1 +
 builtin/repack.c                    |   1 +
 builtin/replace.c                   |   1 +
 builtin/reset.c                     |   1 +
 builtin/rev-list.c                  |   1 +
 builtin/rev-parse.c                 |   1 +
 builtin/shortlog.c                  |   1 +
 builtin/show-branch.c               |   1 +
 builtin/sparse-checkout.c           |   1 +
 builtin/stash.c                     |   1 +
 builtin/submodule--helper.c         |   1 +
 builtin/unpack-objects.c            |   1 +
 builtin/update-index.c              |   1 +
 builtin/worktree.c                  |   1 +
 builtin/write-tree.c                |   1 +
 bulk-checkin.c                      |   1 +
 bundle-uri.c                        |   1 +
 bundle.c                            |   1 +
 cache-tree.c                        |   1 +
 cache.h                             | 207 ---------------------------
 combine-diff.c                      |   1 +
 compat/mingw.c                      |   1 +
 compat/precompose_utf8.c            |   1 +
 connect.c                           |   1 +
 daemon.c                            |   1 +
 diff.c                              |   1 +
 dir.c                               |   1 +
 editor.c                            |   1 +
 entry.c                             |   1 +
 environment.h                       | 213 ++++++++++++++++++++++++++++
 exec-cmd.c                          |   1 +
 fetch-pack.c                        |   1 +
 fsmonitor.c                         |   1 +
 gettext.c                           |   1 +
 git.c                               |   1 +
 http-backend.c                      |   1 +
 http-push.c                         |   1 +
 log-tree.c                          |   1 +
 ls-refs.c                           |   1 +
 mailmap.c                           |   1 +
 merge-ort.c                         |   1 +
 merge-recursive.c                   |   1 +
 name-hash.c                         |   1 +
 notes-utils.c                       |   1 +
 notes.c                             |   1 +
 object-file.c                       |   1 +
 object-name.c                       |   1 +
 pack-bitmap-write.c                 |   1 +
 pack-check.c                        |   1 +
 pack-write.c                        |   1 +
 packfile.c                          |   1 +
 parse-options-cb.c                  |   1 +
 path.c                              |   1 +
 pathspec.c                          |   1 +
 preload-index.c                     |   1 +
 pretty.c                            |   1 +
 prompt.c                            |   1 +
 protocol.c                          |   1 +
 prune-packed.c                      |   1 +
 range-diff.c                        |   1 +
 read-cache.c                        |   1 +
 rebase-interactive.c                |   1 +
 ref-filter.c                        |   1 +
 refs.c                              |   1 +
 refs/files-backend.c                |   1 +
 remote-curl.c                       |   1 +
 remote.c                            |   1 +
 revision.c                          |   1 +
 run-command.c                       |   1 +
 server-info.c                       |   1 +
 setup.c                             |   1 +
 sparse-index.c                      |   1 +
 streaming.c                         |   1 +
 submodule-config.c                  |   1 +
 submodule.c                         |   1 +
 t/helper/test-fast-rebase.c         |   1 +
 t/helper/test-lazy-init-name-hash.c |   1 +
 t/helper/test-path-utils.c          |   1 +
 t/helper/test-repository.c          |   1 +
 tag.c                               |   1 +
 tmp-objdir.c                        |   1 +
 trace.c                             |   1 +
 transport-helper.c                  |   1 +
 transport.c                         |   1 +
 unpack-trees.c                      |   1 +
 upload-pack.c                       |   1 +
 worktree.c                          |   1 +
 119 files changed, 330 insertions(+), 207 deletions(-)

diff --git a/apply.c b/apply.c
index 373565a7baf..a7c0bccb15c 100644
--- a/apply.c
+++ b/apply.c
@@ -16,6 +16,7 @@
 #include "delta.h"
 #include "diff.h"
 #include "dir.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "xdiff-interface.h"
diff --git a/archive.c b/archive.c
index c3c45a5ebe9..7aeaaf368f4 100644
--- a/archive.c
+++ b/archive.c
@@ -2,6 +2,7 @@
 #include "abspath.h"
 #include "alloc.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "refs.h"
diff --git a/attr.c b/attr.c
index 48e2d646187..62127196cb1 100644
--- a/attr.c
+++ b/attr.c
@@ -9,6 +9,7 @@
 #include "cache.h"
 #include "alloc.h"
 #include "config.h"
+#include "environment.h"
 #include "exec-cmd.h"
 #include "attr.h"
 #include "dir.h"
diff --git a/bisect.c b/bisect.c
index 5a3a8182d83..8a4be05dc52 100644
--- a/bisect.c
+++ b/bisect.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "commit.h"
 #include "diff.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "revision.h"
diff --git a/branch.c b/branch.c
index fced5342d5d..ebfdc18dce4 100644
--- a/branch.c
+++ b/branch.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "config.h"
 #include "branch.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "refs.h"
diff --git a/builtin/am.c b/builtin/am.c
index 37f82b3eb42..192968ac300 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -8,6 +8,7 @@
 #include "abspath.h"
 #include "config.h"
 #include "builtin.h"
+#include "environment.h"
 #include "exec-cmd.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/builtin/bisect.c b/builtin/bisect.c
index 2db46b04c97..58e6816d8e5 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "parse-options.h"
diff --git a/builtin/blame.c b/builtin/blame.c
index 21f6b523a6d..9ec82edcbde 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -10,6 +10,7 @@
 #include "config.h"
 #include "color.h"
 #include "builtin.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "repository.h"
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 9f1bf8f0e96..365d9234bdb 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -9,6 +9,7 @@
 #include "config.h"
 #include "builtin.h"
 #include "diff.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "ident.h"
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index ad27255e2cb..5870c4683ab 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -3,6 +3,7 @@
 #include "cache.h"
 #include "config.h"
 #include "attr.h"
+#include "environment.h"
 #include "gettext.h"
 #include "quote.h"
 #include "parse-options.h"
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3c7ff60b923..e2daad4065c 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -9,6 +9,7 @@
 #include "config.h"
 #include "diff.h"
 #include "dir.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "hook.h"
diff --git a/builtin/clone.c b/builtin/clone.c
index b94324ea02c..15dc15408ed 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -12,6 +12,7 @@
 #include "builtin.h"
 #include "abspath.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 311e0106810..90114269761 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "config.h"
 #include "dir.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
diff --git a/builtin/config.c b/builtin/config.c
index 1c1e006ff3f..cf994a216c0 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -3,6 +3,7 @@
 #include "alloc.h"
 #include "config.h"
 #include "color.h"
+#include "environment.h"
 #include "gettext.h"
 #include "ident.h"
 #include "parse-options.h"
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 48edc86c240..f3d8f1bcbb0 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -7,6 +7,7 @@
 #include "cache.h"
 #include "config.h"
 #include "dir.h"
+#include "environment.h"
 #include "gettext.h"
 #include "repository.h"
 #include "builtin.h"
diff --git a/builtin/describe.c b/builtin/describe.c
index fcacdf8a693..27c6670e934 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -1,6 +1,7 @@
 #define USE_THE_INDEX_VARIABLE
 #include "cache.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 59465c39f1d..3613de6389f 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -17,6 +17,7 @@
 #include "config.h"
 #include "builtin.h"
 #include "run-command.h"
+#include "environment.h"
 #include "exec-cmd.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 3300b7f30f0..068843a5d21 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "abspath.h"
 #include "cache.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "repository.h"
diff --git a/builtin/fetch.c b/builtin/fetch.c
index c266b6ab4dd..29ec2e7a81f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -4,6 +4,7 @@
 #include "cache.h"
 #include "config.h"
 #include "gettext.h"
+#include "environment.h"
 #include "hex.h"
 #include "repository.h"
 #include "refs.h"
diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 4efb1417344..a280d8bb14f 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -2,6 +2,7 @@
 #include "abspath.h"
 #include "alloc.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "parse-options.h"
 #include "fsmonitor.h"
diff --git a/builtin/gc.c b/builtin/gc.c
index 2107e3d1f2c..525c5de5b27 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -12,6 +12,7 @@
 
 #include "builtin.h"
 #include "abspath.h"
+#include "environment.h"
 #include "hex.h"
 #include "repository.h"
 #include "config.h"
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 2393897cb88..fdce8f88724 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -2,6 +2,7 @@
 #include "alloc.h"
 #include "config.h"
 #include "delta.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "pack.h"
diff --git a/builtin/init-db.c b/builtin/init-db.c
index a5d4f5c8ece..2ebc9023f56 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -6,6 +6,7 @@
 #include "cache.h"
 #include "abspath.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "refs.h"
 #include "builtin.h"
diff --git a/builtin/log.c b/builtin/log.c
index 639d8e90951..b7b6dfbd1d1 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -8,6 +8,7 @@
 #include "abspath.h"
 #include "alloc.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "refs.h"
diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index e14f7c0abce..a032a1c3881 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -5,6 +5,7 @@
 #include "cache.h"
 #include "abspath.h"
 #include "builtin.h"
+#include "environment.h"
 #include "gettext.h"
 #include "utf8.h"
 #include "strbuf.h"
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 579bc2cac0c..1b5083f8b26 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -2,6 +2,7 @@
 #include "abspath.h"
 #include "cache.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "parse-options.h"
 #include "midx.h"
diff --git a/builtin/mv.c b/builtin/mv.c
index 0a49bf21b0f..c2dd42efbf2 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -8,6 +8,7 @@
 #include "abspath.h"
 #include "alloc.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "pathspec.h"
 #include "lockfile.h"
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 6977a5f580b..66f82ef66f4 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "alloc.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "repository.h"
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 8b55a088a7c..9829b952c2b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "alloc.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "repository.h"
diff --git a/builtin/prune.c b/builtin/prune.c
index ff62a0adb8f..5a381fcdf9a 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "commit.h"
 #include "diff.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "revision.h"
diff --git a/builtin/push.c b/builtin/push.c
index 2d76fa68376..fa550b8f80a 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -4,6 +4,7 @@
 #include "cache.h"
 #include "branch.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "refs.h"
 #include "refspec.h"
diff --git a/builtin/rebase.c b/builtin/rebase.c
index d2f8f703d67..9f3135116ed 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -7,6 +7,7 @@
 #define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "run-command.h"
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e954c85ce3d..3e9c5037b19 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2,6 +2,7 @@
 #include "abspath.h"
 #include "repository.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
diff --git a/builtin/repack.c b/builtin/repack.c
index 771ca01527d..ccbd5f55562 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -2,6 +2,7 @@
 #include "alloc.h"
 #include "config.h"
 #include "dir.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "parse-options.h"
diff --git a/builtin/replace.c b/builtin/replace.c
index cf85e590d9f..dc0331defc2 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -11,6 +11,7 @@
 #include "cache.h"
 #include "config.h"
 #include "builtin.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "refs.h"
diff --git a/builtin/reset.c b/builtin/reset.c
index 6487cf694f5..0b62c9651e6 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -10,6 +10,7 @@
 #define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index f2f6a0d3e67..b202647f281 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "commit.h"
 #include "diff.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "revision.h"
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index a4c0878bc91..bba49d56b9f 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -9,6 +9,7 @@
 #include "alloc.h"
 #include "config.h"
 #include "commit.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "refs.h"
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index d8c4379ea16..31f81c25ea2 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -3,6 +3,7 @@
 #include "config.h"
 #include "commit.h"
 #include "diff.h"
+#include "environment.h"
 #include "gettext.h"
 #include "string-list.h"
 #include "revision.h"
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 8d569629726..c4aa0e62f26 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "pretty.h"
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 3976d8e86b8..f6a120c7c45 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "config.h"
 #include "dir.h"
+#include "environment.h"
 #include "gettext.h"
 #include "parse-options.h"
 #include "pathspec.h"
diff --git a/builtin/stash.c b/builtin/stash.c
index 52fa892f7eb..94f81d75d03 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -2,6 +2,7 @@
 #include "builtin.h"
 #include "abspath.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "parse-options.h"
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ff1fd8c87ab..2bf2a1a8be5 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2,6 +2,7 @@
 #include "builtin.h"
 #include "abspath.h"
 #include "alloc.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "repository.h"
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index f7c4b531076..c65ae3b2078 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "bulk-checkin.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "object-store.h"
diff --git a/builtin/update-index.c b/builtin/update-index.c
index ef78b2d28e1..4642afaeb77 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -7,6 +7,7 @@
 #include "cache.h"
 #include "bulk-checkin.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 1533b4ab43c..d9345efdb2b 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -4,6 +4,7 @@
 #include "config.h"
 #include "builtin.h"
 #include "dir.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "parse-options.h"
diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index 7eec4e3cbd1..6085f64d100 100644
--- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -7,6 +7,7 @@
 #include "builtin.h"
 #include "cache.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "tree.h"
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 778ca1e0f4f..eb6d7a2805b 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -4,6 +4,7 @@
 #include "git-compat-util.h"
 #include "alloc.h"
 #include "bulk-checkin.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
diff --git a/bundle-uri.c b/bundle-uri.c
index 2cc7d159bd6..1ff1cf51dad 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "bundle-uri.h"
 #include "bundle.h"
+#include "environment.h"
 #include "gettext.h"
 #include "object-store.h"
 #include "refs.h"
diff --git a/bundle.c b/bundle.c
index f5b3643b17e..efeaf6f7151 100644
--- a/bundle.c
+++ b/bundle.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "lockfile.h"
 #include "bundle.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "object-store.h"
diff --git a/cache-tree.c b/cache-tree.c
index 6f899beb041..231c3eb2ff6 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "alloc.h"
+#include "environment.h"
 #include "hex.h"
 #include "lockfile.h"
 #include "tree.h"
diff --git a/cache.h b/cache.h
index 31c722533f9..720c88f9fd6 100644
--- a/cache.h
+++ b/cache.h
@@ -452,98 +452,10 @@ static inline enum object_type object_type(unsigned int mode)
 		OBJ_BLOB;
 }
 
-/* Double-check local_repo_env below if you add to this list. */
-#define GIT_DIR_ENVIRONMENT "GIT_DIR"
-#define GIT_COMMON_DIR_ENVIRONMENT "GIT_COMMON_DIR"
-#define GIT_NAMESPACE_ENVIRONMENT "GIT_NAMESPACE"
-#define GIT_WORK_TREE_ENVIRONMENT "GIT_WORK_TREE"
-#define GIT_PREFIX_ENVIRONMENT "GIT_PREFIX"
-#define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
-#define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
-#define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
-#define GRAFT_ENVIRONMENT "GIT_GRAFT_FILE"
-#define GIT_SHALLOW_FILE_ENVIRONMENT "GIT_SHALLOW_FILE"
-#define TEMPLATE_DIR_ENVIRONMENT "GIT_TEMPLATE_DIR"
-#define CONFIG_ENVIRONMENT "GIT_CONFIG"
-#define CONFIG_DATA_ENVIRONMENT "GIT_CONFIG_PARAMETERS"
-#define CONFIG_COUNT_ENVIRONMENT "GIT_CONFIG_COUNT"
-#define EXEC_PATH_ENVIRONMENT "GIT_EXEC_PATH"
-#define CEILING_DIRECTORIES_ENVIRONMENT "GIT_CEILING_DIRECTORIES"
-#define NO_REPLACE_OBJECTS_ENVIRONMENT "GIT_NO_REPLACE_OBJECTS"
-#define GIT_REPLACE_REF_BASE_ENVIRONMENT "GIT_REPLACE_REF_BASE"
-#define GITATTRIBUTES_FILE ".gitattributes"
-#define INFOATTRIBUTES_FILE "info/attributes"
-#define ATTRIBUTE_MACRO_PREFIX "[attr]"
-#define GITMODULES_FILE ".gitmodules"
-#define GITMODULES_INDEX ":.gitmodules"
-#define GITMODULES_HEAD "HEAD:.gitmodules"
-#define GIT_NOTES_REF_ENVIRONMENT "GIT_NOTES_REF"
-#define GIT_NOTES_DEFAULT_REF "refs/notes/commits"
-#define GIT_NOTES_DISPLAY_REF_ENVIRONMENT "GIT_NOTES_DISPLAY_REF"
-#define GIT_NOTES_REWRITE_REF_ENVIRONMENT "GIT_NOTES_REWRITE_REF"
-#define GIT_NOTES_REWRITE_MODE_ENVIRONMENT "GIT_NOTES_REWRITE_MODE"
-#define GIT_LITERAL_PATHSPECS_ENVIRONMENT "GIT_LITERAL_PATHSPECS"
-#define GIT_GLOB_PATHSPECS_ENVIRONMENT "GIT_GLOB_PATHSPECS"
-#define GIT_NOGLOB_PATHSPECS_ENVIRONMENT "GIT_NOGLOB_PATHSPECS"
-#define GIT_ICASE_PATHSPECS_ENVIRONMENT "GIT_ICASE_PATHSPECS"
-#define GIT_QUARANTINE_ENVIRONMENT "GIT_QUARANTINE_PATH"
-#define GIT_OPTIONAL_LOCKS_ENVIRONMENT "GIT_OPTIONAL_LOCKS"
-#define GIT_TEXT_DOMAIN_DIR_ENVIRONMENT "GIT_TEXTDOMAINDIR"
-
-/*
- * Environment variable used in handshaking the wire protocol.
- * Contains a colon ':' separated list of keys with optional values
- * 'key[=value]'.  Presence of unknown keys and values must be
- * ignored.
- */
-#define GIT_PROTOCOL_ENVIRONMENT "GIT_PROTOCOL"
-/* HTTP header used to handshake the wire protocol */
-#define GIT_PROTOCOL_HEADER "Git-Protocol"
-
-/*
- * This environment variable is expected to contain a boolean indicating
- * whether we should or should not treat:
- *
- *   GIT_DIR=foo.git git ...
- *
- * as if GIT_WORK_TREE=. was given. It's not expected that users will make use
- * of this, but we use it internally to communicate to sub-processes that we
- * are in a bare repo. If not set, defaults to true.
- */
-#define GIT_IMPLICIT_WORK_TREE_ENVIRONMENT "GIT_IMPLICIT_WORK_TREE"
-
-/*
- * Repository-local GIT_* environment variables; these will be cleared
- * when git spawns a sub-process that runs inside another repository.
- * The array is NULL-terminated, which makes it easy to pass in the "env"
- * parameter of a run-command invocation, or to do a simple walk.
- */
-extern const char * const local_repo_env[];
-
-void setup_git_env(const char *git_dir);
-
-/*
- * Returns true iff we have a configured git repository (either via
- * setup_git_directory, or in the environment via $GIT_DIR).
- */
-int have_git_dir(void);
-
-extern int is_bare_repository_cfg;
-int is_bare_repository(void);
 int is_inside_git_dir(void);
-extern char *git_work_tree_cfg;
 int is_inside_work_tree(void);
-const char *get_git_dir(void);
-const char *get_git_common_dir(void);
-const char *get_object_directory(void);
-char *get_index_file(void);
-char *get_graft_file(struct repository *r);
-void set_git_dir(const char *path, int make_realpath);
 int get_common_dir_noenv(struct strbuf *sb, const char *gitdir);
 int get_common_dir(struct strbuf *sb, const char *gitdir);
-const char *get_git_namespace(void);
-const char *strip_namespace(const char *namespaced_ref);
-const char *get_git_work_tree(void);
 
 /*
  * Return true if the given path is a git directory; note that this _just_
@@ -578,10 +490,6 @@ const char *read_gitfile_gently(const char *path, int *return_error_code);
 const char *resolve_gitdir_gently(const char *suspect, int *return_error_code);
 #define resolve_gitdir(path) resolve_gitdir_gently((path), NULL)
 
-void set_git_work_tree(const char *tree);
-
-#define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
-
 void setup_work_tree(void);
 /*
  * Find the commondir and gitdir of the repository that contains the current
@@ -840,39 +748,7 @@ void set_alternate_index_output(const char *);
 extern int verify_index_checksum;
 extern int verify_ce_order;
 
-/* Environment bits from configuration mechanism */
-extern int trust_executable_bit;
-extern int trust_ctime;
-extern int check_stat;
 extern int quote_path_fully;
-extern int has_symlinks;
-extern int minimum_abbrev, default_abbrev;
-extern int ignore_case;
-extern int assume_unchanged;
-extern int prefer_symlink_refs;
-extern int warn_ambiguous_refs;
-extern int warn_on_object_refname_ambiguity;
-extern char *apply_default_whitespace;
-extern char *apply_default_ignorewhitespace;
-extern const char *git_attributes_file;
-extern const char *git_hooks_path;
-extern int zlib_compression_level;
-extern int pack_compression_level;
-extern size_t packed_git_window_size;
-extern size_t packed_git_limit;
-extern size_t delta_base_cache_limit;
-extern unsigned long big_file_threshold;
-extern unsigned long pack_size_limit_cfg;
-
-/*
- * Accessors for the core.sharedrepository config which lazy-load the value
- * from the config (if not already set). The "reset" function can be
- * used to unset "set" or cached value, meaning that the value will be loaded
- * fresh from the config file on the next call to get_shared_repository().
- */
-void set_shared_repository(int value);
-int get_shared_repository(void);
-void reset_shared_repository(void);
 
 /*
  * These values are used to help identify parts of a repository to fsync.
@@ -930,57 +806,6 @@ enum fsync_method {
 };
 
 extern enum fsync_method fsync_method;
-extern int core_preload_index;
-extern int precomposed_unicode;
-extern int protect_hfs;
-extern int protect_ntfs;
-
-extern int core_apply_sparse_checkout;
-extern int core_sparse_checkout_cone;
-extern int sparse_expect_files_outside_of_patterns;
-
-/*
- * Returns the boolean value of $GIT_OPTIONAL_LOCKS (or the default value).
- */
-int use_optional_locks(void);
-
-enum log_refs_config {
-	LOG_REFS_UNSET = -1,
-	LOG_REFS_NONE = 0,
-	LOG_REFS_NORMAL,
-	LOG_REFS_ALWAYS
-};
-extern enum log_refs_config log_all_ref_updates;
-
-enum rebase_setup_type {
-	AUTOREBASE_NEVER = 0,
-	AUTOREBASE_LOCAL,
-	AUTOREBASE_REMOTE,
-	AUTOREBASE_ALWAYS
-};
-
-enum push_default_type {
-	PUSH_DEFAULT_NOTHING = 0,
-	PUSH_DEFAULT_MATCHING,
-	PUSH_DEFAULT_SIMPLE,
-	PUSH_DEFAULT_UPSTREAM,
-	PUSH_DEFAULT_CURRENT,
-	PUSH_DEFAULT_UNSPECIFIED
-};
-
-extern enum rebase_setup_type autorebase;
-extern enum push_default_type push_default;
-
-enum object_creation_mode {
-	OBJECT_CREATION_USES_HARDLINKS = 0,
-	OBJECT_CREATION_USES_RENAMES = 1
-};
-
-extern enum object_creation_mode object_creation_mode;
-
-extern char *notes_ref_name;
-
-extern int grafts_replace_parents;
 
 /*
  * GIT_REPO_VERSION is the version we write by default. The
@@ -989,8 +814,6 @@ extern int grafts_replace_parents;
  */
 #define GIT_REPO_VERSION 0
 #define GIT_REPO_VERSION_READ 1
-extern int repository_format_precious_objects;
-extern int repository_format_worktree_config;
 
 /*
  * You _have_ to initialize a `struct repository_format` using
@@ -1362,21 +1185,6 @@ struct pack_entry {
 	struct packed_git *p;
 };
 
-/*
- * Create a temporary file rooted in the object database directory, or
- * die on failure. The filename is taken from "pattern", which should have the
- * usual "XXXXXX" trailer, and the resulting filename is written into the
- * "template" buffer. Returns the open descriptor.
- */
-int odb_mkstemp(struct strbuf *temp_filename, const char *pattern);
-
-/*
- * Create a pack .keep file named "name" (which should generally be the output
- * of odb_pack_name). Returns a file descriptor opened for writing, or -1 on
- * error.
- */
-int odb_pack_keep(const char *name);
-
 /*
  * Set this to 0 to prevent oid_object_info_extended() from fetching missing
  * blobs. This has a difference only if extensions.partialClone is set.
@@ -1388,11 +1196,6 @@ extern int fetch_if_missing;
 /* Dumb servers support */
 int update_server_info(int);
 
-const char *get_log_output_encoding(void);
-const char *get_commit_output_encoding(void);
-
-extern const char *git_commit_encoding;
-extern const char *git_log_output_encoding;
 extern const char *git_mailmap_file;
 extern const char *git_mailmap_blob;
 
@@ -1429,10 +1232,6 @@ int decimal_width(uintmax_t);
 int check_pager_config(const char *cmd);
 void prepare_pager_args(struct child_process *, const char *pager);
 
-extern const char *editor_program;
-extern const char *askpass_program;
-extern const char *excludes_file;
-
 /* base85 */
 int decode_85(char *dst, const char *line, int linelen);
 void encode_85(char *buf, const unsigned char *data, int bytes);
@@ -1536,10 +1335,4 @@ void stat_validity_update(struct stat_validity *sv, int fd);
 
 int versioncmp(const char *s1, const char *s2);
 
-/*
- * Should we print an ellipsis after an abbreviated SHA-1 value
- * when doing diff-raw output or indicating a detached HEAD?
- */
-int print_sha1_ellipsis(void);
-
 #endif /* CACHE_H */
diff --git a/combine-diff.c b/combine-diff.c
index 91051dc3258..3758e47c4f4 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -4,6 +4,7 @@
 #include "blob.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "environment.h"
 #include "hex.h"
 #include "quote.h"
 #include "xdiff-interface.h"
diff --git a/compat/mingw.c b/compat/mingw.c
index d48899bf7b4..94c5a1daa40 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -11,6 +11,7 @@
 #include "../alloc.h"
 #include "win32/lazyload.h"
 #include "../config.h"
+#include "../environment.h"
 #include "../wrapper.h"
 #include "dir.h"
 #include "gettext.h"
diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index 56d36cdf22a..8a9881db077 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -7,6 +7,7 @@
 
 #include "cache.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "utf8.h"
 #include "precompose_utf8.h"
diff --git a/connect.c b/connect.c
index 1dab0d79c48..9fe01446bc5 100644
--- a/connect.c
+++ b/connect.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "cache.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "pkt-line.h"
diff --git a/daemon.c b/daemon.c
index e35604e194c..b56a8f9717d 100644
--- a/daemon.c
+++ b/daemon.c
@@ -2,6 +2,7 @@
 #include "abspath.h"
 #include "alloc.h"
 #include "config.h"
+#include "environment.h"
 #include "pkt-line.h"
 #include "run-command.h"
 #include "strbuf.h"
diff --git a/diff.c b/diff.c
index 1b0b24c21c3..dcf1a940942 100644
--- a/diff.c
+++ b/diff.c
@@ -5,6 +5,7 @@
 #include "abspath.h"
 #include "alloc.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "tempfile.h"
 #include "quote.h"
diff --git a/dir.c b/dir.c
index b57c770e68b..06f8aa3c01b 100644
--- a/dir.c
+++ b/dir.c
@@ -10,6 +10,7 @@
 #include "alloc.h"
 #include "config.h"
 #include "dir.h"
+#include "environment.h"
 #include "gettext.h"
 #include "object-store.h"
 #include "attr.h"
diff --git a/editor.c b/editor.c
index 2d3e6be64e4..d632d790660 100644
--- a/editor.c
+++ b/editor.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "abspath.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "strbuf.h"
 #include "strvec.h"
diff --git a/entry.c b/entry.c
index 70212af260b..750c1f6b2f4 100644
--- a/entry.c
+++ b/entry.c
@@ -2,6 +2,7 @@
 #include "blob.h"
 #include "object-store.h"
 #include "dir.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "streaming.h"
diff --git a/environment.h b/environment.h
index a26931556af..a63f0c6a24f 100644
--- a/environment.h
+++ b/environment.h
@@ -3,6 +3,8 @@
 
 #include "strvec.h"
 
+struct repository;
+
 /*
  * The character that begins a commented line in user-editable file
  * that is subject to stripspace.
@@ -16,4 +18,215 @@ extern int auto_comment_line_char;
  */
 const char *getenv_safe(struct strvec *argv, const char *name);
 
+/* Double-check local_repo_env below if you add to this list. */
+#define GIT_DIR_ENVIRONMENT "GIT_DIR"
+#define GIT_COMMON_DIR_ENVIRONMENT "GIT_COMMON_DIR"
+#define GIT_NAMESPACE_ENVIRONMENT "GIT_NAMESPACE"
+#define GIT_WORK_TREE_ENVIRONMENT "GIT_WORK_TREE"
+#define GIT_PREFIX_ENVIRONMENT "GIT_PREFIX"
+#define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
+#define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
+#define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
+#define GRAFT_ENVIRONMENT "GIT_GRAFT_FILE"
+#define GIT_SHALLOW_FILE_ENVIRONMENT "GIT_SHALLOW_FILE"
+#define TEMPLATE_DIR_ENVIRONMENT "GIT_TEMPLATE_DIR"
+#define CONFIG_ENVIRONMENT "GIT_CONFIG"
+#define CONFIG_DATA_ENVIRONMENT "GIT_CONFIG_PARAMETERS"
+#define CONFIG_COUNT_ENVIRONMENT "GIT_CONFIG_COUNT"
+#define EXEC_PATH_ENVIRONMENT "GIT_EXEC_PATH"
+#define CEILING_DIRECTORIES_ENVIRONMENT "GIT_CEILING_DIRECTORIES"
+#define NO_REPLACE_OBJECTS_ENVIRONMENT "GIT_NO_REPLACE_OBJECTS"
+#define GIT_REPLACE_REF_BASE_ENVIRONMENT "GIT_REPLACE_REF_BASE"
+#define GITATTRIBUTES_FILE ".gitattributes"
+#define INFOATTRIBUTES_FILE "info/attributes"
+#define ATTRIBUTE_MACRO_PREFIX "[attr]"
+#define GITMODULES_FILE ".gitmodules"
+#define GITMODULES_INDEX ":.gitmodules"
+#define GITMODULES_HEAD "HEAD:.gitmodules"
+#define GIT_NOTES_REF_ENVIRONMENT "GIT_NOTES_REF"
+#define GIT_NOTES_DEFAULT_REF "refs/notes/commits"
+#define GIT_NOTES_DISPLAY_REF_ENVIRONMENT "GIT_NOTES_DISPLAY_REF"
+#define GIT_NOTES_REWRITE_REF_ENVIRONMENT "GIT_NOTES_REWRITE_REF"
+#define GIT_NOTES_REWRITE_MODE_ENVIRONMENT "GIT_NOTES_REWRITE_MODE"
+#define GIT_LITERAL_PATHSPECS_ENVIRONMENT "GIT_LITERAL_PATHSPECS"
+#define GIT_GLOB_PATHSPECS_ENVIRONMENT "GIT_GLOB_PATHSPECS"
+#define GIT_NOGLOB_PATHSPECS_ENVIRONMENT "GIT_NOGLOB_PATHSPECS"
+#define GIT_ICASE_PATHSPECS_ENVIRONMENT "GIT_ICASE_PATHSPECS"
+#define GIT_QUARANTINE_ENVIRONMENT "GIT_QUARANTINE_PATH"
+#define GIT_OPTIONAL_LOCKS_ENVIRONMENT "GIT_OPTIONAL_LOCKS"
+#define GIT_TEXT_DOMAIN_DIR_ENVIRONMENT "GIT_TEXTDOMAINDIR"
+
+/*
+ * Environment variable used in handshaking the wire protocol.
+ * Contains a colon ':' separated list of keys with optional values
+ * 'key[=value]'.  Presence of unknown keys and values must be
+ * ignored.
+ */
+#define GIT_PROTOCOL_ENVIRONMENT "GIT_PROTOCOL"
+/* HTTP header used to handshake the wire protocol */
+#define GIT_PROTOCOL_HEADER "Git-Protocol"
+
+/*
+ * This environment variable is expected to contain a boolean indicating
+ * whether we should or should not treat:
+ *
+ *   GIT_DIR=foo.git git ...
+ *
+ * as if GIT_WORK_TREE=. was given. It's not expected that users will make use
+ * of this, but we use it internally to communicate to sub-processes that we
+ * are in a bare repo. If not set, defaults to true.
+ */
+#define GIT_IMPLICIT_WORK_TREE_ENVIRONMENT "GIT_IMPLICIT_WORK_TREE"
+
+/*
+ * Repository-local GIT_* environment variables; these will be cleared
+ * when git spawns a sub-process that runs inside another repository.
+ * The array is NULL-terminated, which makes it easy to pass in the "env"
+ * parameter of a run-command invocation, or to do a simple walk.
+ */
+extern const char * const local_repo_env[];
+
+void setup_git_env(const char *git_dir);
+
+/*
+ * Returns true iff we have a configured git repository (either via
+ * setup_git_directory, or in the environment via $GIT_DIR).
+ */
+int have_git_dir(void);
+
+extern int is_bare_repository_cfg;
+int is_bare_repository(void);
+extern char *git_work_tree_cfg;
+const char *get_git_dir(void);
+const char *get_git_common_dir(void);
+const char *get_object_directory(void);
+char *get_index_file(void);
+char *get_graft_file(struct repository *r);
+void set_git_dir(const char *path, int make_realpath);
+const char *get_git_namespace(void);
+const char *strip_namespace(const char *namespaced_ref);
+const char *get_git_work_tree(void);
+void set_git_work_tree(const char *tree);
+
+#define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
+
+/* Environment bits from configuration mechanism */
+extern int trust_executable_bit;
+extern int trust_ctime;
+extern int check_stat;
+extern int has_symlinks;
+extern int minimum_abbrev, default_abbrev;
+extern int ignore_case;
+extern int assume_unchanged;
+extern int prefer_symlink_refs;
+extern int warn_ambiguous_refs;
+extern int warn_on_object_refname_ambiguity;
+extern char *apply_default_whitespace;
+extern char *apply_default_ignorewhitespace;
+extern const char *git_attributes_file;
+extern const char *git_hooks_path;
+extern int zlib_compression_level;
+extern int pack_compression_level;
+extern size_t packed_git_window_size;
+extern size_t packed_git_limit;
+extern size_t delta_base_cache_limit;
+extern unsigned long big_file_threshold;
+extern unsigned long pack_size_limit_cfg;
+
+/*
+ * Accessors for the core.sharedrepository config which lazy-load the value
+ * from the config (if not already set). The "reset" function can be
+ * used to unset "set" or cached value, meaning that the value will be loaded
+ * fresh from the config file on the next call to get_shared_repository().
+ */
+void set_shared_repository(int value);
+int get_shared_repository(void);
+void reset_shared_repository(void);
+
+extern int core_preload_index;
+extern int precomposed_unicode;
+extern int protect_hfs;
+extern int protect_ntfs;
+
+extern int core_apply_sparse_checkout;
+extern int core_sparse_checkout_cone;
+extern int sparse_expect_files_outside_of_patterns;
+
+/*
+ * Returns the boolean value of $GIT_OPTIONAL_LOCKS (or the default value).
+ */
+int use_optional_locks(void);
+
+enum log_refs_config {
+	LOG_REFS_UNSET = -1,
+	LOG_REFS_NONE = 0,
+	LOG_REFS_NORMAL,
+	LOG_REFS_ALWAYS
+};
+extern enum log_refs_config log_all_ref_updates;
+
+enum rebase_setup_type {
+	AUTOREBASE_NEVER = 0,
+	AUTOREBASE_LOCAL,
+	AUTOREBASE_REMOTE,
+	AUTOREBASE_ALWAYS
+};
+
+enum push_default_type {
+	PUSH_DEFAULT_NOTHING = 0,
+	PUSH_DEFAULT_MATCHING,
+	PUSH_DEFAULT_SIMPLE,
+	PUSH_DEFAULT_UPSTREAM,
+	PUSH_DEFAULT_CURRENT,
+	PUSH_DEFAULT_UNSPECIFIED
+};
+
+extern enum rebase_setup_type autorebase;
+extern enum push_default_type push_default;
+
+enum object_creation_mode {
+	OBJECT_CREATION_USES_HARDLINKS = 0,
+	OBJECT_CREATION_USES_RENAMES = 1
+};
+
+extern enum object_creation_mode object_creation_mode;
+
+extern char *notes_ref_name;
+
+extern int grafts_replace_parents;
+
+extern int repository_format_precious_objects;
+extern int repository_format_worktree_config;
+
+/*
+ * Create a temporary file rooted in the object database directory, or
+ * die on failure. The filename is taken from "pattern", which should have the
+ * usual "XXXXXX" trailer, and the resulting filename is written into the
+ * "template" buffer. Returns the open descriptor.
+ */
+int odb_mkstemp(struct strbuf *temp_filename, const char *pattern);
+
+/*
+ * Create a pack .keep file named "name" (which should generally be the output
+ * of odb_pack_name). Returns a file descriptor opened for writing, or -1 on
+ * error.
+ */
+int odb_pack_keep(const char *name);
+
+const char *get_log_output_encoding(void);
+const char *get_commit_output_encoding(void);
+
+extern const char *git_commit_encoding;
+extern const char *git_log_output_encoding;
+
+extern const char *editor_program;
+extern const char *askpass_program;
+extern const char *excludes_file;
+
+/*
+ * Should we print an ellipsis after an abbreviated SHA-1 value
+ * when doing diff-raw output or indicating a detached HEAD?
+ */
+int print_sha1_ellipsis(void);
+
 #endif
diff --git a/exec-cmd.c b/exec-cmd.c
index 042d9247a5b..fae0d4b244a 100644
--- a/exec-cmd.c
+++ b/exec-cmd.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "abspath.h"
+#include "environment.h"
 #include "exec-cmd.h"
 #include "gettext.h"
 #include "quote.h"
diff --git a/fetch-pack.c b/fetch-pack.c
index c1190801405..c453a4168f9 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -2,6 +2,7 @@
 #include "alloc.h"
 #include "repository.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
diff --git a/fsmonitor.c b/fsmonitor.c
index a5b9e75437b..c956a347a27 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "config.h"
 #include "dir.h"
+#include "environment.h"
 #include "ewah/ewok.h"
 #include "fsmonitor.h"
 #include "fsmonitor-ipc.h"
diff --git a/gettext.c b/gettext.c
index 3e7b3baabc6..85d3d3424eb 100644
--- a/gettext.c
+++ b/gettext.c
@@ -4,6 +4,7 @@
 
 #include "cache.h"
 #include "abspath.h"
+#include "environment.h"
 #include "exec-cmd.h"
 #include "gettext.h"
 #include "strbuf.h"
diff --git a/git.c b/git.c
index 22ce4f14b65..b24c105e83f 100644
--- a/git.c
+++ b/git.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "config.h"
+#include "environment.h"
 #include "exec-cmd.h"
 #include "gettext.h"
 #include "help.h"
diff --git a/http-backend.c b/http-backend.c
index 42e6c2596e9..042ccf12e8c 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "alloc.h"
 #include "config.h"
+#include "environment.h"
 #include "hex.h"
 #include "repository.h"
 #include "refs.h"
diff --git a/http-push.c b/http-push.c
index 88aa045ecba..40373bc4863 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "environment.h"
 #include "hex.h"
 #include "repository.h"
 #include "commit.h"
diff --git a/log-tree.c b/log-tree.c
index 3adcb576e4c..e2bf8d6df75 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -2,6 +2,7 @@
 #include "commit-reach.h"
 #include "config.h"
 #include "diff.h"
+#include "environment.h"
 #include "hex.h"
 #include "object-store.h"
 #include "repository.h"
diff --git a/ls-refs.c b/ls-refs.c
index ae38889bf04..12cbb40a198 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "repository.h"
diff --git a/mailmap.c b/mailmap.c
index da2589b0822..2c6e9b238dd 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "environment.h"
 #include "string-list.h"
 #include "mailmap.h"
 #include "object-store.h"
diff --git a/merge-ort.c b/merge-ort.c
index a26cad5f910..f3d7c202f52 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -26,6 +26,7 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "dir.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "entry.h"
diff --git a/merge-recursive.c b/merge-recursive.c
index f918cea4c69..d5f37724911 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -17,6 +17,7 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "dir.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "ll-merge.h"
diff --git a/name-hash.c b/name-hash.c
index bb9eae55aca..2c2861efd1c 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2008 Linus Torvalds
  */
 #include "cache.h"
+#include "environment.h"
 #include "gettext.h"
 #include "thread-utils.h"
 #include "trace2.h"
diff --git a/notes-utils.c b/notes-utils.c
index da08e2e8e5c..8797271faf1 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "config.h"
 #include "commit.h"
+#include "environment.h"
 #include "gettext.h"
 #include "refs.h"
 #include "notes-utils.h"
diff --git a/notes.c b/notes.c
index a7187236e98..9288c1a0705 100644
--- a/notes.c
+++ b/notes.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "config.h"
+#include "environment.h"
 #include "hex.h"
 #include "notes.h"
 #include "object-store.h"
diff --git a/object-file.c b/object-file.c
index bdf68763a50..3da6cd68861 100644
--- a/object-file.c
+++ b/object-file.c
@@ -10,6 +10,7 @@
 #include "abspath.h"
 #include "alloc.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "string-list.h"
diff --git a/object-name.c b/object-name.c
index 2c927bbded3..3b0ce8ef05a 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "tag.h"
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 7dc7f0ba55e..63f16080c9b 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "alloc.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "object-store.h"
diff --git a/pack-check.c b/pack-check.c
index 7ed594d6679..6974e40a958 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "environment.h"
 #include "hex.h"
 #include "repository.h"
 #include "pack.h"
diff --git a/pack-write.c b/pack-write.c
index 87156f89d2b..f1714054951 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "pack.h"
diff --git a/packfile.c b/packfile.c
index 0fe844f2075..cc3b1e242c7 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "alloc.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "list.h"
diff --git a/parse-options-cb.c b/parse-options-cb.c
index fbf4b010195..15d008c3daf 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -4,6 +4,7 @@
 #include "cache.h"
 #include "commit.h"
 #include "color.h"
+#include "environment.h"
 #include "gettext.h"
 #include "string-list.h"
 #include "strvec.h"
diff --git a/path.c b/path.c
index 3976c0d7ace..5d5a15c13d6 100644
--- a/path.c
+++ b/path.c
@@ -3,6 +3,7 @@
  */
 #include "cache.h"
 #include "abspath.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "repository.h"
diff --git a/pathspec.c b/pathspec.c
index 53763e272f5..5fb7b5f26c9 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -2,6 +2,7 @@
 #include "abspath.h"
 #include "config.h"
 #include "dir.h"
+#include "environment.h"
 #include "gettext.h"
 #include "pathspec.h"
 #include "attr.h"
diff --git a/preload-index.c b/preload-index.c
index 4b45e1d6912..52544d004e7 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -4,6 +4,7 @@
 #include "cache.h"
 #include "pathspec.h"
 #include "dir.h"
+#include "environment.h"
 #include "fsmonitor.h"
 #include "gettext.h"
 #include "config.h"
diff --git a/pretty.c b/pretty.c
index 9d7922dcc60..2b6d0f52c9f 100644
--- a/pretty.c
+++ b/pretty.c
@@ -2,6 +2,7 @@
 #include "alloc.h"
 #include "config.h"
 #include "commit.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "utf8.h"
diff --git a/prompt.c b/prompt.c
index 50df17279d1..ba10813b313 100644
--- a/prompt.c
+++ b/prompt.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "config.h"
+#include "environment.h"
 #include "run-command.h"
 #include "strbuf.h"
 #include "prompt.h"
diff --git a/protocol.c b/protocol.c
index c53f7df5be4..bdb32e1eeb6 100644
--- a/protocol.c
+++ b/protocol.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "config.h"
+#include "environment.h"
 #include "protocol.h"
 
 static enum protocol_version parse_protocol_version(const char *value)
diff --git a/prune-packed.c b/prune-packed.c
index cff5ad569c7..5a57072a7ac 100644
--- a/prune-packed.c
+++ b/prune-packed.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "environment.h"
 #include "gettext.h"
 #include "object-store.h"
 #include "packfile.h"
diff --git a/range-diff.c b/range-diff.c
index 1bfc612e274..815fb24c9ce 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "environment.h"
 #include "gettext.h"
 #include "range-diff.h"
 #include "string-list.h"
diff --git a/read-cache.c b/read-cache.c
index 9a8d5fe97ed..34567c1d550 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -18,6 +18,7 @@
 #include "tree.h"
 #include "commit.h"
 #include "blob.h"
+#include "environment.h"
 #include "gettext.h"
 #include "resolve-undo.h"
 #include "run-command.h"
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 7c885c35bfd..a83334dd564 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "commit.h"
+#include "environment.h"
 #include "gettext.h"
 #include "sequencer.h"
 #include "rebase-interactive.h"
diff --git a/ref-filter.c b/ref-filter.c
index 9a830bedef0..1489fbfe4ae 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "alloc.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "parse-options.h"
diff --git a/refs.c b/refs.c
index 385051752f1..04520e5a6b8 100644
--- a/refs.c
+++ b/refs.c
@@ -5,6 +5,7 @@
 #include "cache.h"
 #include "alloc.h"
 #include "config.h"
+#include "environment.h"
 #include "hashmap.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/refs/files-backend.c b/refs/files-backend.c
index eb14d124e3f..0c3138ede8f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1,5 +1,6 @@
 #include "../cache.h"
 #include "../config.h"
+#include "../environment.h"
 #include "../gettext.h"
 #include "../hex.h"
 #include "../refs.h"
diff --git a/remote-curl.c b/remote-curl.c
index 943cd6fe6cd..eb382a1e35d 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "alloc.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "remote.h"
diff --git a/remote.c b/remote.c
index 2bae247a0a4..aeca3ff8136 100644
--- a/remote.c
+++ b/remote.c
@@ -2,6 +2,7 @@
 #include "abspath.h"
 #include "alloc.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "remote.h"
diff --git a/revision.c b/revision.c
index 7423e23327b..53fdeef0787 100644
--- a/revision.c
+++ b/revision.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "alloc.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "object-store.h"
diff --git a/run-command.c b/run-command.c
index 2c8b4cd9bfc..614d48fa9a2 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "run-command.h"
+#include "environment.h"
 #include "exec-cmd.h"
 #include "gettext.h"
 #include "sigchain.h"
diff --git a/server-info.c b/server-info.c
index ae96d784e53..355b6e01a52 100644
--- a/server-info.c
+++ b/server-info.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "alloc.h"
 #include "dir.h"
+#include "environment.h"
 #include "hex.h"
 #include "repository.h"
 #include "refs.h"
diff --git a/setup.c b/setup.c
index 8f385d9f29b..cfdc849a78c 100644
--- a/setup.c
+++ b/setup.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "abspath.h"
+#include "environment.h"
 #include "gettext.h"
 #include "repository.h"
 #include "config.h"
diff --git a/sparse-index.c b/sparse-index.c
index fdae9011b8e..886054729e5 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "alloc.h"
+#include "environment.h"
 #include "gettext.h"
 #include "repository.h"
 #include "sparse-index.h"
diff --git a/streaming.c b/streaming.c
index 6c69f595045..024fd796b7d 100644
--- a/streaming.c
+++ b/streaming.c
@@ -2,6 +2,7 @@
  * Copyright (c) 2011, Google Inc.
  */
 #include "cache.h"
+#include "environment.h"
 #include "streaming.h"
 #include "repository.h"
 #include "object-store.h"
diff --git a/submodule-config.c b/submodule-config.c
index 38663801aa4..28fdfddccfb 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "alloc.h"
 #include "dir.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "repository.h"
diff --git a/submodule.c b/submodule.c
index 13ff333f68c..acf030b95e4 100644
--- a/submodule.c
+++ b/submodule.c
@@ -8,6 +8,7 @@
 #include "dir.h"
 #include "diff.h"
 #include "commit.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "revision.h"
diff --git a/t/helper/test-fast-rebase.c b/t/helper/test-fast-rebase.c
index 68bbc41b330..627a6bdc3d0 100644
--- a/t/helper/test-fast-rebase.c
+++ b/t/helper/test-fast-rebase.c
@@ -15,6 +15,7 @@
 #include "cache.h"
 #include "cache-tree.h"
 #include "commit.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper/test-lazy-init-name-hash.c
index ab86c14c8ba..2b678a45793 100644
--- a/t/helper/test-lazy-init-name-hash.c
+++ b/t/helper/test-lazy-init-name-hash.c
@@ -1,6 +1,7 @@
 #define USE_THE_INDEX_VARIABLE
 #include "test-tool.h"
 #include "cache.h"
+#include "environment.h"
 #include "parse-options.h"
 
 static int single;
diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index d3d00dc34fa..cc266e3ec09 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -1,6 +1,7 @@
 #include "test-tool.h"
 #include "cache.h"
 #include "abspath.h"
+#include "environment.h"
 #include "string-list.h"
 #include "utf8.h"
 
diff --git a/t/helper/test-repository.c b/t/helper/test-repository.c
index 10a6dfc2160..c444775eb0f 100644
--- a/t/helper/test-repository.c
+++ b/t/helper/test-repository.c
@@ -3,6 +3,7 @@
 #include "commit-graph.h"
 #include "commit.h"
 #include "config.h"
+#include "environment.h"
 #include "hex.h"
 #include "object-store.h"
 #include "object.h"
diff --git a/tag.c b/tag.c
index 3408bb9433f..39434231799 100644
--- a/tag.c
+++ b/tag.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "environment.h"
 #include "tag.h"
 #include "object-store.h"
 #include "commit.h"
diff --git a/tmp-objdir.c b/tmp-objdir.c
index fff15cb6b5c..5adad1925d1 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -3,6 +3,7 @@
 #include "abspath.h"
 #include "chdir-notify.h"
 #include "dir.h"
+#include "environment.h"
 #include "sigchain.h"
 #include "string-list.h"
 #include "strbuf.h"
diff --git a/trace.c b/trace.c
index de004f62988..9c85b71ec6a 100644
--- a/trace.c
+++ b/trace.c
@@ -23,6 +23,7 @@
 
 #include "cache.h"
 #include "abspath.h"
+#include "environment.h"
 #include "quote.h"
 #include "wrapper.h"
 
diff --git a/transport-helper.c b/transport-helper.c
index 09048eab484..3313bb74099 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -4,6 +4,7 @@
 #include "run-command.h"
 #include "commit.h"
 #include "diff.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "revision.h"
diff --git a/transport.c b/transport.c
index c6179b801e8..4f06ccbee05 100644
--- a/transport.c
+++ b/transport.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "alloc.h"
 #include "config.h"
+#include "environment.h"
 #include "hex.h"
 #include "transport.h"
 #include "hook.h"
diff --git a/unpack-trees.c b/unpack-trees.c
index 84e0d2e8afe..0ff4bbc6b96 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -3,6 +3,7 @@
 #include "repository.h"
 #include "config.h"
 #include "dir.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "tree.h"
diff --git a/upload-pack.c b/upload-pack.c
index eea9e6a6e8c..1155f795382 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "refs.h"
diff --git a/worktree.c b/worktree.c
index 64c96605e53..3861ab639ca 100644
--- a/worktree.c
+++ b/worktree.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "abspath.h"
 #include "alloc.h"
+#include "environment.h"
 #include "gettext.h"
 #include "repository.h"
 #include "refs.h"
-- 
gitgitgadget


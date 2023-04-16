Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A125C77B70
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 03:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjDPDEc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 23:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjDPDEF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 23:04:05 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1583AAC
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:41 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-2f833bda191so358296f8f.1
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681614219; x=1684206219;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pK12Lt1pX0eW4dJZARMpQPzqEs1xZsYrJB6Jb04eeVk=;
        b=DD/4stqxB4PjBKn8VUipeq7jvlpxFepW0Vwzz3I550BV7vJmfb1XEWEbqvh0kKghpG
         ZNdMaZ9KJx3zdzYZxNGKtzY8pjIWRNEQQubAzV2W2B5TkS38WL/mfh795ADhBKshmUW8
         PhfE2vO13cyfVlDv8LeMiKIEgCVOvyjvX7U3PPI8MUO82gN7sGyz0dtunp0cP5RBTrrz
         jx3zX9IwfkiQxd8cyLbeHjRK0gaGnc525J1iGZx9TKZ7FMiOgya8frhHtRJjpyP41e2s
         V94Kby2gXMyF7tq8aczQquzwQciXa8r1TPGPFZYH0U4vbpGYdliRe0jUteS0Jez67koW
         +Hqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681614219; x=1684206219;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pK12Lt1pX0eW4dJZARMpQPzqEs1xZsYrJB6Jb04eeVk=;
        b=IQC6p2bEjOX7fmWc/GDLBaHW7Iu5lG1Ax90Vec3XkaFb5AVV+tg+iMpIB6B+WwAC9D
         5hovRfcyAHFfShxJgp+ZVAy34opS4xyyf5vF/L7Dstj8mdhHSyIwUnfPTjjSk7AqMEty
         bMdYUcNy/zAPQyEWRrPOHijoyXeX1xChduIGh69m9wd+rF+8zDT7wHcmmV8bXGXD2K19
         dAQuZFFEEG0o9hrFhRrKolUsuGL2EmVEpgvuOxNl6CUmDckBEN1t+41Dw69n4apjSWN1
         UqL7b8c9gDfeHWnBxkxATzzZC37vA9m/Vyt8IIzJL/huh9vQg49e8oHQez420CE3XNLY
         4gCQ==
X-Gm-Message-State: AAQBX9fILPg8sY4JX48RkS+zTtwnxFTHnIcboyaupYRXpduhrA74JsCq
        4PbWj9xBtQEPkN4TyyXejL36MbX9Mlg=
X-Google-Smtp-Source: AKy350YzJpTPU9qi78SkGxSzeC5RCEaII/IgoULJkk+a2JAOKMHDFtjTmJ165bMoYAYDuj+7uteI6g==
X-Received: by 2002:a5d:66ca:0:b0:2f5:296a:61b4 with SMTP id k10-20020a5d66ca000000b002f5296a61b4mr2428232wrw.60.1681614219049;
        Sat, 15 Apr 2023 20:03:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u8-20020a5d6ac8000000b002eaac3a9beesm7031552wrw.8.2023.04.15.20.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 20:03:38 -0700 (PDT)
Message-Id: <1edd8fd72a7e0580caaddf9a5e23502bdbc6ab8d.1681614206.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 16 Apr 2023 03:03:19 +0000
Subject: [PATCH 17/23] treewide: remove cache.h inclusion due to previous
 changes
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
 archive-zip.c                 | 2 +-
 bundle-uri.c                  | 2 +-
 color.c                       | 2 +-
 combine-diff.c                | 2 +-
 common-main.c                 | 2 +-
 config.c                      | 2 +-
 copy.c                        | 2 +-
 credential.c                  | 2 +-
 daemon.c                      | 2 +-
 date.c                        | 2 +-
 diagnose.c                    | 2 +-
 environment.c                 | 2 +-
 ll-merge.c                    | 2 +-
 match-trees.c                 | 2 +-
 midx.c                        | 2 +-
 object-file.c                 | 2 +-
 packfile.c                    | 2 +-
 pkt-line.c                    | 2 +-
 range-diff.c                  | 2 +-
 ref-filter.c                  | 2 +-
 t/helper/test-match-trees.c   | 1 -
 t/helper/test-mergesort.c     | 1 -
 t/helper/test-oid-array.c     | 1 -
 t/helper/test-oidtree.c       | 1 -
 t/helper/test-parse-options.c | 1 -
 t/helper/test-read-midx.c     | 1 -
 t/helper/test-string-list.c   | 1 -
 tree-diff.c                   | 2 +-
 tree-walk.c                   | 2 +-
 tree.c                        | 2 +-
 wrapper.c                     | 3 ++-
 31 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index ef538a90df4..d0d065a312e 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -1,7 +1,7 @@
 /*
  * Copyright (c) 2006 Rene Scharfe
  */
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "archive.h"
 #include "gettext.h"
diff --git a/bundle-uri.c b/bundle-uri.c
index 6d44662ee1f..ec1552bbca2 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "bundle-uri.h"
 #include "bundle.h"
 #include "copy.h"
diff --git a/color.c b/color.c
index f8a25ca807b..83abb11eda0 100644
--- a/color.c
+++ b/color.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "color.h"
 #include "editor.h"
diff --git a/combine-diff.c b/combine-diff.c
index f7e9fb57473..f8d61965776 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "object-store.h"
 #include "commit.h"
 #include "convert.h"
diff --git a/common-main.c b/common-main.c
index 8ab50fa37a4..033778b3c56 100644
--- a/common-main.c
+++ b/common-main.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "exec-cmd.h"
 #include "gettext.h"
 #include "attr.h"
diff --git a/config.c b/config.c
index 97063a0743e..2a9ed27efe5 100644
--- a/config.c
+++ b/config.c
@@ -5,7 +5,7 @@
  * Copyright (C) Johannes Schindelin, 2005
  *
  */
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "advice.h"
 #include "alloc.h"
diff --git a/copy.c b/copy.c
index 923d8a6dc61..882c79cffb0 100644
--- a/copy.c
+++ b/copy.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "copy.h"
 #include "path.h"
 #include "wrapper.h"
diff --git a/credential.c b/credential.c
index 42194efc9e0..a600d0c1ac1 100644
--- a/credential.c
+++ b/credential.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "config.h"
 #include "credential.h"
diff --git a/daemon.c b/daemon.c
index f89f99d7ef4..7139cc201d7 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "alloc.h"
 #include "config.h"
diff --git a/date.c b/date.c
index bc030da012f..a6ca6b318bd 100644
--- a/date.c
+++ b/date.c
@@ -4,7 +4,7 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 
-#include "cache.h"
+#include "git-compat-util.h"
 #include "date.h"
 #include "gettext.h"
 #include "pager.h"
diff --git a/diagnose.c b/diagnose.c
index f9a2496c7ff..58f49f76c7a 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "diagnose.h"
 #include "compat/disk.h"
 #include "archive.h"
diff --git a/environment.c b/environment.c
index 541f0b19acf..28d18eaca8e 100644
--- a/environment.c
+++ b/environment.c
@@ -7,7 +7,7 @@
  * even if you might want to know where the git directory etc
  * are.
  */
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "branch.h"
 #include "convert.h"
diff --git a/ll-merge.c b/ll-merge.c
index 85517e668e3..1993530688e 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2007 Junio C Hamano
  */
 
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "convert.h"
 #include "attr.h"
diff --git a/match-trees.c b/match-trees.c
index 9b78d99507b..6bc8eb76477 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "hex.h"
 #include "match-trees.h"
 #include "tree.h"
diff --git a/midx.c b/midx.c
index 2d0da573281..c7679c3c4f5 100644
--- a/midx.c
+++ b/midx.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "alloc.h"
 #include "config.h"
diff --git a/object-file.c b/object-file.c
index 8163ddbaddd..8e0df7360ae 100644
--- a/object-file.c
+++ b/object-file.c
@@ -6,7 +6,7 @@
  * This handles basic git object files - packing, unpacking,
  * creation etc.
  */
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "alloc.h"
 #include "config.h"
diff --git a/packfile.c b/packfile.c
index 9ae2278c22e..1ee9f65242c 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/pkt-line.c b/pkt-line.c
index 8b5fa788517..62b4208b66e 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "copy.h"
 #include "pkt-line.h"
 #include "gettext.h"
diff --git a/range-diff.c b/range-diff.c
index a1e0cffb9f6..6a704e6f471 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "environment.h"
 #include "gettext.h"
 #include "range-diff.h"
diff --git a/ref-filter.c b/ref-filter.c
index 5387f79be6d..594e66ad361 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/t/helper/test-match-trees.c b/t/helper/test-match-trees.c
index 3c62e33ccdf..a0afc1b4bc8 100644
--- a/t/helper/test-match-trees.c
+++ b/t/helper/test-match-trees.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 #include "hex.h"
 #include "match-trees.h"
 #include "object-name.h"
diff --git a/t/helper/test-mergesort.c b/t/helper/test-mergesort.c
index 3aabae6c1c4..42ccc870516 100644
--- a/t/helper/test-mergesort.c
+++ b/t/helper/test-mergesort.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 #include "mem-pool.h"
 #include "mergesort.h"
 #include "strbuf.h"
diff --git a/t/helper/test-oid-array.c b/t/helper/test-oid-array.c
index ea3bf278984..241e5da3157 100644
--- a/t/helper/test-oid-array.c
+++ b/t/helper/test-oid-array.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 #include "hex.h"
 #include "oid-array.h"
 #include "setup.h"
diff --git a/t/helper/test-oidtree.c b/t/helper/test-oidtree.c
index 796c9811e0f..dc509fb8065 100644
--- a/t/helper/test-oidtree.c
+++ b/t/helper/test-oidtree.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 #include "hex.h"
 #include "oidtree.h"
 #include "setup.h"
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 20a81a1eb21..3003987ec17 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 #include "parse-options.h"
 #include "strbuf.h"
 #include "string-list.h"
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index b32abff7f11..211addaa005 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 #include "hex.h"
 #include "midx.h"
 #include "repository.h"
diff --git a/t/helper/test-string-list.c b/t/helper/test-string-list.c
index 959f27c74c6..042c6ff0059 100644
--- a/t/helper/test-string-list.c
+++ b/t/helper/test-string-list.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 #include "strbuf.h"
 #include "string-list.h"
 
diff --git a/tree-diff.c b/tree-diff.c
index a76e6dae619..9ea2dd7a6c3 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -1,7 +1,7 @@
 /*
  * Helper functions for tree diff generation
  */
-#include "cache.h"
+#include "git-compat-util.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "tree.h"
diff --git a/tree-walk.c b/tree-walk.c
index 2993c48c2f3..d3c48e06df0 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "tree-walk.h"
 #include "alloc.h"
 #include "dir.h"
diff --git a/tree.c b/tree.c
index f242a7ab691..0dd2029a8a2 100644
--- a/tree.c
+++ b/tree.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "cache-tree.h"
 #include "hex.h"
 #include "tree.h"
diff --git a/wrapper.c b/wrapper.c
index 5ab0460de5c..67f5f5dbe19 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -1,10 +1,11 @@
 /*
  * Various trivial helper wrappers around standard functions
  */
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "config.h"
 #include "gettext.h"
+#include "object.h"
 #include "repository.h"
 #include "strbuf.h"
 #include "trace2.h"
-- 
gitgitgadget


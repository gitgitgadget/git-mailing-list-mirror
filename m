Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB10C76196
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 01:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbjDDBXX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 21:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbjDDBXB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 21:23:01 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66853592
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 18:22:46 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l37so18066010wms.2
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 18:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680571365;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysdruvhXVTpvwn2FI3F4NKQWr48GP4fneWBjnyolqZM=;
        b=NKmVnqspmfXUgekM3JA00gtxQnXxFVOpUHSsfAEhUSxQOijO8oKt/KOX4QvX5AAxUC
         TrN8er5MZAciPW8hQ41aFluYIjuzadRIiweTWVE8scg3Utl81AHVT36/unylIfjQ+94D
         0mZMclqcAv+Qf5fqUKCPxG0yP+kaSO2ilBf5mhAqfG5EB1jLkc7ej6/OZOpcMvkB1+Qs
         XzOE4FMZG+U1aK9tjXAN+vBZfLNBg4MtA90UjPFq+ApfKeyi949JNzq+/1CV61R1zsci
         kTR3G0VCeMR1FpQ8IPaiQnuRWB9tihQwIbjQb3GIxBaJzNcJtQYY+JSXf6TF/o0xHuCq
         mEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680571365;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysdruvhXVTpvwn2FI3F4NKQWr48GP4fneWBjnyolqZM=;
        b=R8CkTOlcYYPiiYerzCaYhn3E0U4nuFRMND74W0avSj3+XTe+x/rVaiGQVlmgpe5V97
         5FstZFTVrxpsDYSYb/ATzTE/wdL9pm1m/vd3IOnRU4/JEFgCl7mjxzZ3FzC/w+rDlnA+
         Pwgsymoa/lbJMxaaEZ6AO8rjHoDdQHhtduEjdd2FuKyCAzgfio1I5qRaHFCfiwefOg+G
         gPqJuJ01vUIIRJpDCoevOluX2/SLkILAdC/pxeWNgLRGCbW411Dv5PF3Tjo2zh/O4PSY
         E67iCy5RfkJiU9ocfWFiSD4XLAZC2owKRWM3sR3J0FlCA88xU4rKk8hvWNzShZ7oJ6B4
         Hy7w==
X-Gm-Message-State: AAQBX9crs9LW06UzlSoQkR1A17K6vEEU+Ef87s6JDRT6JqNltMwQAVRJ
        /6LisVoV2IzBnzlHInSjsz5qwvVvLDQ=
X-Google-Smtp-Source: AKy350Yfssbk/MTqFjK9KvG5/CIBVHuca9NqeEMoKOjdTeRw+E1OElvAfhsDOmhMbvpI0oooYHxStA==
X-Received: by 2002:a05:600c:2259:b0:3ed:b4e8:630f with SMTP id a25-20020a05600c225900b003edb4e8630fmr825038wmm.10.1680571365081;
        Mon, 03 Apr 2023 18:22:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l32-20020a05600c1d2000b003f0321c22basm19452818wms.12.2023.04.03.18.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 18:22:44 -0700 (PDT)
Message-Id: <c85f9baed8c7583f6bfd7d4c62c78773d903888e.1680571351.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
        <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Apr 2023 01:22:19 +0000
Subject: [PATCH v2 15/24] treewide: remove cache.h inclusion due to object.h
 changes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 bisect.c              | 2 +-
 bundle.c              | 2 +-
 commit.c              | 2 +-
 delta-islands.c       | 2 +-
 diff-no-index.c       | 2 +-
 fsck.c                | 2 +-
 http-push.c           | 2 +-
 list-objects-filter.c | 2 +-
 list-objects.c        | 2 +-
 log-tree.c            | 2 +-
 pack-bitmap-write.c   | 2 +-
 parse-options-cb.c    | 1 -
 rebase-interactive.c  | 2 +-
 submodule-config.c    | 2 +-
 tag.c                 | 2 +-
 transport.c           | 2 +-
 walker.c              | 2 +-
 17 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/bisect.c b/bisect.c
index e708e8b6aa1..8d5f8e58851 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "commit.h"
 #include "diff.h"
diff --git a/bundle.c b/bundle.c
index 6471489975a..a5505368de5 100644
--- a/bundle.c
+++ b/bundle.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "lockfile.h"
 #include "bundle.h"
 #include "environment.h"
diff --git a/commit.c b/commit.c
index bad31c423a4..878b4473e4c 100644
--- a/commit.c
+++ b/commit.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "tag.h"
 #include "commit.h"
 #include "commit-graph.h"
diff --git a/delta-islands.c b/delta-islands.c
index 40f2ccfb550..c824a5f6a42 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "attr.h"
 #include "object.h"
diff --git a/diff-no-index.c b/diff-no-index.c
index 934a24bee58..4296940f907 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2008 by Junio C Hamano
  */
 
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "color.h"
 #include "commit.h"
diff --git a/fsck.c b/fsck.c
index 8ef1b022346..adbe8bf59e7 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "hex.h"
 #include "object-store.h"
diff --git a/http-push.c b/http-push.c
index a8af6c0f690..637a4e91f7a 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "environment.h"
 #include "hex.h"
 #include "repository.h"
diff --git a/list-objects-filter.c b/list-objects-filter.c
index 8b2a45e507d..5d270ce5987 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "dir.h"
 #include "gettext.h"
diff --git a/list-objects.c b/list-objects.c
index df18d103063..eecca721ac0 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "tag.h"
 #include "commit.h"
 #include "gettext.h"
diff --git a/log-tree.c b/log-tree.c
index f0e885635e0..b5cf3d8439c 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "commit-reach.h"
 #include "config.h"
 #include "diff.h"
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 7f5f489beb0..faf67c94d37 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/parse-options-cb.c b/parse-options-cb.c
index b4df4bcebed..26a4c7d08a9 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -1,7 +1,6 @@
 #include "git-compat-util.h"
 #include "parse-options.h"
 #include "branch.h"
-#include "cache.h"
 #include "commit.h"
 #include "color.h"
 #include "environment.h"
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 48467a7bc4a..6ff12d7be2d 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "commit.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/submodule-config.c b/submodule-config.c
index 252b90aa439..7fc0812b644 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "dir.h"
 #include "environment.h"
diff --git a/tag.c b/tag.c
index b9fc2fc9929..96dbd5b2d55 100644
--- a/tag.c
+++ b/tag.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "environment.h"
 #include "tag.h"
 #include "object-name.h"
diff --git a/transport.c b/transport.c
index 7374cfd1fa9..8d3ad8022a4 100644
--- a/transport.c
+++ b/transport.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "advice.h"
 #include "alloc.h"
 #include "config.h"
diff --git a/walker.c b/walker.c
index cfbd257fdba..24ff7dfdc28 100644
--- a/walker.c
+++ b/walker.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "gettext.h"
 #include "hex.h"
 #include "walker.h"
-- 
gitgitgadget


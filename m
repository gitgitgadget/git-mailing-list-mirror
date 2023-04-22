Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E6DC6FD18
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 20:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjDVUR7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 16:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjDVURq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 16:17:46 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F36211C
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:41 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-2f58125b957so2709782f8f.3
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682194660; x=1684786660;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VKzPjlOVt0ttQYRbSkQR33ViI/ZjrwE7RAdiLHPLZg=;
        b=lOw9N/NN79YriHkibbnUzq5AqeQE8wWurqpysx51YrRM4mOIYdnk1rtsU8HIphqByr
         rq25BjY/e++kwizWpEixzC0Un7iJPORscJBGRIgi9zzinxIwgqUxTtIJIGap2kZKCpx9
         G4QYL0WvzBdd9ka9VsOvSNpTQFWpic0EjW1Op132MX9t3MpEEyMn6G1UYmm3lSPTmfak
         tVoXqQtx5Fyz7TzyhC2QptSd7l6b8vYgBW+djg14mPSp/FktHbnMZEDjfmhbri0xDx2X
         7jRE99uZOjd8Zu744N/luKdk4fTuFltq9IOimmeh/yv0lGQU2ll0j10wdjsulsnR4Cc6
         svww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682194660; x=1684786660;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VKzPjlOVt0ttQYRbSkQR33ViI/ZjrwE7RAdiLHPLZg=;
        b=EpqKgKw7eMXAVaKQ/TJHZd7MRwxD4JI+VvS9Jt6QEN61TF6ANviNy3M/BWC/EuBO6o
         ndoaE6YjVn0CgsxRWgEmgA9di5zk0AO8m9wBE4sr6hjFWEHTpMunFPd0Ksd0dQG3IU4g
         BEl4BoZJv2O/Q2kXCwC42wA2ldGATpOURdxh1HyMGVWlcmjmQUviPF0YTzJcBQRONgXE
         GswJfdcrC9uTiuGr0OdcN+ZRd4CBLAw4nVK2F0paHAHTYK08kysIP09O0l0QXX/wWXhg
         4TPKnzDqwe+YIZwx579YsPXnBVpJZat5OrXARCS0JQPT3hc7B5+if50DJnkKURpFWTCx
         j72w==
X-Gm-Message-State: AAQBX9djfMurt3uedFW3gqHbbjrt6cqQyREKdIIPEggTHw3gNJdqZ4QW
        jBJTth2Y8QUwuzg0H1a3Z0R1K0h+qQ8=
X-Google-Smtp-Source: AKy350Y52Dw/v+fbs/u2GnH1/VBTS90DX2g+G72DKRmO51Hlfpbl8dKXcI+YbP0Yo+gpzbjYNJyoQw==
X-Received: by 2002:adf:ffcf:0:b0:301:8551:446a with SMTP id x15-20020adfffcf000000b003018551446amr6856702wrs.2.1682194659993;
        Sat, 22 Apr 2023 13:17:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j3-20020a5d6183000000b002faaa9a1721sm7194671wru.58.2023.04.22.13.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 13:17:39 -0700 (PDT)
Message-Id: <0a321c41c3f16ef32a7377263eb1c69a9ae0a819.1682194651.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
        <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Apr 2023 20:17:15 +0000
Subject: [PATCH v2 08/22] match-trees.h: move declarations for match-trees.c
 functions from cache.h
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

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 cache.h                     |  4 ----
 match-trees.c               |  1 +
 match-trees.h               | 10 ++++++++++
 merge-ort.c                 |  1 +
 merge-recursive.c           |  1 +
 t/helper/test-match-trees.c |  1 +
 6 files changed, 14 insertions(+), 4 deletions(-)
 create mode 100644 match-trees.h

diff --git a/cache.h b/cache.h
index fde782a96f0..0570f9ad07d 100644
--- a/cache.h
+++ b/cache.h
@@ -603,10 +603,6 @@ int add_files_to_cache(const char *prefix, const struct pathspec *pathspec, int
 /* diff.c */
 extern int diff_auto_refresh_index;
 
-/* match-trees.c */
-void shift_tree(struct repository *, const struct object_id *, const struct object_id *, struct object_id *, int);
-void shift_tree_by(struct repository *, const struct object_id *, const struct object_id *, struct object_id *, const char *);
-
 /*
  * whitespace rules.
  * used by both diff and apply
diff --git a/match-trees.c b/match-trees.c
index 5877fc64a8f..9b78d99507b 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "hex.h"
+#include "match-trees.h"
 #include "tree.h"
 #include "tree-walk.h"
 #include "object-store.h"
diff --git a/match-trees.h b/match-trees.h
new file mode 100644
index 00000000000..e3877acd583
--- /dev/null
+++ b/match-trees.h
@@ -0,0 +1,10 @@
+#ifndef MATCH_TREES_H
+#define MATCH_TREES_H
+
+struct object_id;
+struct repository;
+
+void shift_tree(struct repository *, const struct object_id *, const struct object_id *, struct object_id *, int);
+void shift_tree_by(struct repository *, const struct object_id *, const struct object_id *, struct object_id *, const char *);
+
+#endif /* MATCH_TREES_H */
diff --git a/merge-ort.c b/merge-ort.c
index 2c6a9ed9a41..65837db77f0 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -31,6 +31,7 @@
 #include "hex.h"
 #include "entry.h"
 #include "ll-merge.h"
+#include "match-trees.h"
 #include "mem-pool.h"
 #include "object-name.h"
 #include "object-store.h"
diff --git a/merge-recursive.c b/merge-recursive.c
index d4d2ab05b2e..8e87b6386d9 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -22,6 +22,7 @@
 #include "hex.h"
 #include "ll-merge.h"
 #include "lockfile.h"
+#include "match-trees.h"
 #include "object-file.h"
 #include "object-name.h"
 #include "object-store.h"
diff --git a/t/helper/test-match-trees.c b/t/helper/test-match-trees.c
index 3808e1ac38b..a498fece7a3 100644
--- a/t/helper/test-match-trees.c
+++ b/t/helper/test-match-trees.c
@@ -1,6 +1,7 @@
 #include "test-tool.h"
 #include "cache.h"
 #include "hex.h"
+#include "match-trees.h"
 #include "object-name.h"
 #include "setup.h"
 #include "tree.h"
-- 
gitgitgadget


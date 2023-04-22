Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC081C77B78
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 20:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjDVUS2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 16:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjDVURy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 16:17:54 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8538B270E
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:50 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f09b4a156eso19327275e9.3
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682194670; x=1684786670;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5CU5Bc3XP5YbogCT5M88UNwd1365uiEQvjRGnUczek=;
        b=B2Afx5zqtFPPE2Y1V/RwWagtsAJEDHZhc0+1SNEHkaY+2gQ4GgWPT6nPjPFrmuFMcf
         EgelvqnrnqHcohlzVu3lOHUJ5H10l3kuxFCpjYOUBJnjCoNPCma/MOF0tULabD0VORyn
         BTxSB/rSJyGCO/H3/RACY1wmJNvBvVdI618TKhaf4mSGyQlFhD9bUKC0mWUBKK1DsuaL
         bvmX+Nr5ON3mV7uUyXuldEg2cuHb3tWGrWgc1w90uDJ4NHv9ssnpwxf1rJkrqvW0rD21
         wyIx5EzTboiJ/arZB9Yx21yH94QCAdGZaTjWTy2nAug/PWmIpBRET2HkELkNvdWFjs/R
         v0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682194670; x=1684786670;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5CU5Bc3XP5YbogCT5M88UNwd1365uiEQvjRGnUczek=;
        b=BHzjh2DF1Mq9VOs3oOmmwAJR+U7h8YOC8NCJQSbDAO/wkXOz3YvKUqPeVY6mgVVuLQ
         vvTpvg+gXZNiQXyNMK15dOCv/d83TSNKW9cRRAT7rsEz4GAWIHi95vAHzAuaJ6fvlhXm
         pbSORPx33YtBBY27O3+9gC/s6m0Rce6PdFCeQv5b995MTaNVAVxhGCf62qR3xmQKO9iY
         ZFoO5XbUF3O3evtPzYaFio6OdpdOdXWQGNsunSTi5jGUtLhRZST/EaqUTnaeye31bBpZ
         vGceeLpp6CGKKt6HI2M0hlTbJdAi1KG0vf6qHvmWJToHcLePYC8XAz4uPgOyUv8fgAat
         CYNw==
X-Gm-Message-State: AAQBX9flom/wQyQfW1yvjhsQbvSM/OC6rehiyIC8JiKfYiclbrT9+wWZ
        H3yqYjUeab5k8ZMrhf7Gdfwehfkef7I=
X-Google-Smtp-Source: AKy350YeXi8gdvQrWXW1up7Xp9e+zQ1qRbqU61TKuZUAFryuj6b/AvnxzLgyWeV9U5f7gk1t3dAgVA==
X-Received: by 2002:a05:600c:2212:b0:3f1:72ec:4024 with SMTP id z18-20020a05600c221200b003f172ec4024mr4540193wml.21.1682194669856;
        Sat, 22 Apr 2023 13:17:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c22d500b003f17131952fsm8074556wmg.29.2023.04.22.13.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 13:17:49 -0700 (PDT)
Message-Id: <67d52c6e751fae6e3325178a24eeb5f44afb3f08.1682194652.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
        <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Apr 2023 20:17:29 +0000
Subject: [PATCH v2 22/22] reftable: ensure git-compat-util.h is the first
 (indirect) include
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
 reftable/error.c         | 1 +
 reftable/publicbasics.c  | 2 +-
 reftable/tree.c          | 2 +-
 reftable/tree_test.c     | 1 +
 t/helper/test-reftable.c | 1 +
 5 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/reftable/error.c b/reftable/error.c
index 93941f21457..0d1766735e8 100644
--- a/reftable/error.c
+++ b/reftable/error.c
@@ -6,6 +6,7 @@ license that can be found in the LICENSE file or at
 https://developers.google.com/open-source/licenses/bsd
 */
 
+#include "system.h"
 #include "reftable-error.h"
 
 #include <stdio.h>
diff --git a/reftable/publicbasics.c b/reftable/publicbasics.c
index 0ad7d5c0ff2..bcb82530d6c 100644
--- a/reftable/publicbasics.c
+++ b/reftable/publicbasics.c
@@ -6,10 +6,10 @@ license that can be found in the LICENSE file or at
 https://developers.google.com/open-source/licenses/bsd
 */
 
+#include "system.h"
 #include "reftable-malloc.h"
 
 #include "basics.h"
-#include "system.h"
 
 static void *(*reftable_malloc_ptr)(size_t sz);
 static void *(*reftable_realloc_ptr)(void *, size_t);
diff --git a/reftable/tree.c b/reftable/tree.c
index b8899e060ab..a5bf8809854 100644
--- a/reftable/tree.c
+++ b/reftable/tree.c
@@ -6,10 +6,10 @@ license that can be found in the LICENSE file or at
 https://developers.google.com/open-source/licenses/bsd
 */
 
+#include "system.h"
 #include "tree.h"
 
 #include "basics.h"
-#include "system.h"
 
 struct tree_node *tree_search(void *key, struct tree_node **rootp,
 			      int (*compare)(const void *, const void *),
diff --git a/reftable/tree_test.c b/reftable/tree_test.c
index cbff1255886..ac3a045ad4a 100644
--- a/reftable/tree_test.c
+++ b/reftable/tree_test.c
@@ -6,6 +6,7 @@ license that can be found in the LICENSE file or at
 https://developers.google.com/open-source/licenses/bsd
 */
 
+#include "system.h"
 #include "tree.h"
 
 #include "basics.h"
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 1f0a28cbb64..00237ef0d9e 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -1,3 +1,4 @@
+#include "reftable/system.h"
 #include "reftable/reftable-tests.h"
 #include "test-tool.h"
 
-- 
gitgitgadget

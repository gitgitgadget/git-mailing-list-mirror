Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4A0C77B71
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 03:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjDPDEv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 23:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjDPDEP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 23:04:15 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A253C13
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:43 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id he11-20020a05600c540b00b003ef6d684102so10093094wmb.3
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681614222; x=1684206222;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5CU5Bc3XP5YbogCT5M88UNwd1365uiEQvjRGnUczek=;
        b=WyF7GekcLZlDUSIFu9kmAKdWVShhmGSuji9hUXzoopSNtoP8UHee9qwV+pFsxTKQye
         smpeK2A7C++UcMIh+TIdN5UTQlECzcxnWTwz/XZuXRfqlfw2pd2ldbmSYSzD2IK4SAOz
         OaxiFNIhH/n9n47WFty5t4Ryly8kN/0g0uZRP+1JqdBULo6oNQnhFk4QJPMCtSC7OzIN
         gC2Ut5VYFjcMHr6zCbJx/GS0GV9DzSvLjC1XC9gv0/Wq6yaQrWagCvMDxwu3x/MGFJpY
         Dgc+5ujuph9Wp/RTv5KCUsgBJqoaleX3eF92PGDr4FzHrnFI0XzbfsZlO3pRbm25CQhn
         XsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681614222; x=1684206222;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5CU5Bc3XP5YbogCT5M88UNwd1365uiEQvjRGnUczek=;
        b=LDqodoHY//4nFdEYNb02ac8YSc3rPMptL66eiwiaZpkxgkPyvDN69+1Kd06kOJFUQ6
         P5XgFSoX/m+cBi0SUxhJs9AyZNJsNSDV0KeX/Gn6sEuQIzLim0u6jRPR/+JvZnFz4OUF
         P3Rt5C+UGjEXuN5uJtb7X951neyL8n6bYjEdGVMKRej/bzwDErd4RmOogeWkdctSN1Tk
         Wogc9Vv7nOyHHlPdYdrxAvdZkZIE5YZtEhj33JdazSiPNvxw+pt8pvdkHVctqqu9kjZb
         aw2OuTL+68jabnwXhmofnOzbHPY2ouHmjzaR5mNJJL7MFfLmSvemzsoj99o9VjNjpGy7
         h9Bg==
X-Gm-Message-State: AAQBX9dWFHb0OAdQ+Q3U1y6Rx68XFvN3FDFk3trsvUfyqIr2Ws+n58Qf
        YmoMT5SyNXNjVwaOiApz8/oCmP5B9DM=
X-Google-Smtp-Source: AKy350YZRxWjF7v09evH02gj+qOI3ZWtit3SdvIZbRY90CUZqIcGG1cJfFQI4g8wAP8+L7waLHoWPQ==
X-Received: by 2002:a7b:ca56:0:b0:3ee:6cdf:c357 with SMTP id m22-20020a7bca56000000b003ee6cdfc357mr7362272wml.20.1681614222596;
        Sat, 15 Apr 2023 20:03:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l21-20020a05600c4f1500b003f080b2f9f4sm11791935wmq.27.2023.04.15.20.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 20:03:42 -0700 (PDT)
Message-Id: <f32d4fa3dbffa3879b7127f8910a7b4586bea81c.1681614207.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 16 Apr 2023 03:03:25 +0000
Subject: [PATCH 23/23] reftable: ensure git-compat-util.h is the first
 (indirect) include
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

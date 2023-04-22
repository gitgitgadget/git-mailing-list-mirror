Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F5EC7618E
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 20:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjDVUSM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 16:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjDVURs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 16:17:48 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD512116
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:44 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f18123d9f6so19461065e9.0
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682194662; x=1684786662;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDWtoW7uRNtarKiJCmmSWv4JVqFWGBFgex4Uw8z0ogI=;
        b=XxzsCayQNVfBvlf/mzHlSFNBprIf1FMeu/4oUxYQ7N8DdinkDNdRqHIQ3eBomUmupc
         O4wWLwkPZamvZt/riNxOM97qHusDiEzk4KGpgDtvAzZOD9Y1M/irwYgxoRbj63VifgGt
         YtqRodBO1Gdn0K3PNRLli/q/+Y+QRaj+xW70qrqY78aWNgujHcwl8g8xUgat99Ett16o
         nZKXWGWk176bGU9bao2xwZ5E4EaCOtcUEkxlnSFwNQw3ldd+vMuh9dlxC+NtwCLUByS0
         xTanDaPad7uVq+Wkp4v9M6143mcNrPjggbWfWKErF+0+kHQFfdzYGiQ1caKpzAEKcIYL
         K2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682194662; x=1684786662;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDWtoW7uRNtarKiJCmmSWv4JVqFWGBFgex4Uw8z0ogI=;
        b=idcVjfWQmTQq5bAGcIW4xTi2N85Td5gy0xTarzw/NJe1H9r7muDk3JLeo5ovmhJIKw
         zqq/8qQYK3VjzrhexvMtKwYzbc+B9zplhYsAe7kmR20MgGwS0YnsdarLzak4OU4cABXL
         g+ZvQqCHt32yQd7W8OttkBG7azK7e+znaCVWGMejpFmlWcP1ouz2wgHqUVqdTQbu1Owt
         CKpnJASpTFGn1eh5jl3B9zwc3e0gkpQkKTg0GCYbeK+F2En0shv9p6y3v+9DSk+ZF4kU
         kCzlVXvMDzMSTJ4DbNXHnRsFmFUB4NH+UEKu2o3jJoBJc+hQResknbnLRNgI8vj9cIfl
         3fMg==
X-Gm-Message-State: AAQBX9fsd4yLpma8feIks7ik9SRtTszI4S+J8jBxnaqbr3qLIi+9bAIY
        fpCWjY7u3aRc9KSze/0qXzlfUF4/e7c=
X-Google-Smtp-Source: AKy350blWkF5j+hAMEvSRtt3IkxkWevIlJlRaCiq0gphLvTdP3SRDoUdbplwGqvBm4RYajU/p1GroQ==
X-Received: by 2002:a05:600c:21a:b0:3f1:75b6:8c7 with SMTP id 26-20020a05600c021a00b003f175b608c7mr4485201wmi.37.1682194662794;
        Sat, 22 Apr 2023 13:17:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k24-20020a7bc318000000b003f16fc33fbesm8051430wmj.17.2023.04.22.13.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 13:17:42 -0700 (PDT)
Message-Id: <7b55f82e62ecf761b804432c8d08dffabbb7605f.1682194651.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
        <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Apr 2023 20:17:19 +0000
Subject: [PATCH v2 12/22] tree-diff.c: move S_DIFFTREE_IFXMIN_NEQ define from
 cache.h
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

S_DIFFTREE_IFXMIN_NEQ is *only* used in tree-diff.c, so there is no
point exposing it in cache.h.  Move it to tree-diff.c.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 cache.h     | 15 ---------------
 tree-diff.c | 13 +++++++++++++
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/cache.h b/cache.h
index ad741e70bc2..7a46f300d9b 100644
--- a/cache.h
+++ b/cache.h
@@ -10,21 +10,6 @@
 #include "object.h"
 #include "statinfo.h"
 
-/*
- * Some mode bits are also used internally for computations.
- *
- * They *must* not overlap with any valid modes, and they *must* not be emitted
- * to outside world - i.e. appear on disk or network. In other words, it's just
- * temporary fields, which we internally use, but they have to stay in-house.
- *
- * ( such approach is valid, as standard S_IF* fits into 16 bits, and in Git
- *   codebase mode is `unsigned int` which is assumed to be at least 32 bits )
- */
-
-/* used internally in tree-diff */
-#define S_DIFFTREE_IFXMIN_NEQ	0x80000000
-
-
 /*
  * Basic data structures for the directory cache
  */
diff --git a/tree-diff.c b/tree-diff.c
index 69031d7cbae..a76e6dae619 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -6,6 +6,19 @@
 #include "diffcore.h"
 #include "tree.h"
 
+/*
+ * Some mode bits are also used internally for computations.
+ *
+ * They *must* not overlap with any valid modes, and they *must* not be emitted
+ * to outside world - i.e. appear on disk or network. In other words, it's just
+ * temporary fields, which we internally use, but they have to stay in-house.
+ *
+ * ( such approach is valid, as standard S_IF* fits into 16 bits, and in Git
+ *   codebase mode is `unsigned int` which is assumed to be at least 32 bits )
+ */
+
+#define S_DIFFTREE_IFXMIN_NEQ	0x80000000
+
 /*
  * internal mode marker, saying a tree entry != entry of tp[imin]
  * (see ll_diff_tree_paths for what it means there)
-- 
gitgitgadget


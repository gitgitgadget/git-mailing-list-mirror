Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575A3C77B71
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 03:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjDPDE0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 23:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjDPDDw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 23:03:52 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FD43582
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:38 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-2eff1a664e7so358694f8f.2
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681614216; x=1684206216;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDWtoW7uRNtarKiJCmmSWv4JVqFWGBFgex4Uw8z0ogI=;
        b=pB2V4YHGyM+UXoS4j7SdrnJMoYA9PKWUHASr7FkJDtyfOV2BNSC26BpDNN5Vy1dtaA
         wL5qWbRkz9UpQ19NVjH3mgC6OxW58eMv9lQBXFFqcs3neOHhFIh1WgJs55aaXqnxFM5W
         yrpgLFTLRVbYNWNiduL74OEQRspwwZPA+k1RF8qvySq/DeNNCn3GgoS0GBmOSosse0Yo
         9C+SyZRzsELCezGWvvoxdbymoRi6Xlx8rs+j961gxePocyIa1E82G21ppv79+02i7oqJ
         nKo+MlbBVGFj4WQD3ENQzWa/LTyALenGK59DezJZ2g+SVtXn2HuMRJdIn3acAWOFa2Fj
         hWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681614216; x=1684206216;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDWtoW7uRNtarKiJCmmSWv4JVqFWGBFgex4Uw8z0ogI=;
        b=W3qgVWXBKMvCxFKt2XLaD4PFq2RcIfOjxzhEXfnU0f6RwAe3DCVpkuN4FATe/AH1KX
         Ndex+9ZFhDllOKK3OfbwY669vViayZo4jM0aV1CNYJa/fIB7r+lsoUPXeDAflO+YrQJn
         i/Ax8GY3w4TgyuQdQGg9Mf/DQNjB/szbCHbn3QxIj0UNAQuQ5NuAUCeuLoL4Fy/5TvNo
         YPWL4SNeiNwT+EBqRGQkdkiES8M0YbObVT15RRoDT0MXuTDpYPZ4nje9NdR5gvGAaAbf
         Rb/+RLAZ0dzpxy0SXjUabjXwJ4FEjV2qG28rp5TSjhySO7T0IlDeHsi4WHAFl8dy5ieI
         /0jA==
X-Gm-Message-State: AAQBX9excRNulkbTMpNeFwow4pWwt9z9BDTNfNXMMl2cjx/nTnYWOL7y
        WxhDoagkWbRMpuWR3W0LHplXbXqwzVc=
X-Google-Smtp-Source: AKy350ZUFlA4QOBxsnSsRLqIjZF1V8fD/fw6qXxSm58QVJAjkzpK15uNQwoo7+KutkQX+Ax/PFTMrw==
X-Received: by 2002:a5d:564a:0:b0:2f4:a60f:3cd8 with SMTP id j10-20020a5d564a000000b002f4a60f3cd8mr2876589wrw.49.1681614216544;
        Sat, 15 Apr 2023 20:03:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m4-20020a5d6a04000000b002f0442a2d3asm6998392wru.48.2023.04.15.20.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 20:03:36 -0700 (PDT)
Message-Id: <dec377e17f5821772b2126d61800e3b6d6c912bf.1681614206.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 16 Apr 2023 03:03:15 +0000
Subject: [PATCH 13/23] tree-diff.c: move S_DIFFTREE_IFXMIN_NEQ define from
 cache.h
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


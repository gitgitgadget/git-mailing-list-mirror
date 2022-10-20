Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BAAC4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 20:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiJTUU6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 16:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiJTUUt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 16:20:49 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295D4349B9
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 13:20:48 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id a3so1295742wrt.0
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 13:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+HssYl2LLbJYOQvNh3qEP9sTGLgHERbvBGu9EZ2czU=;
        b=UJNg9E+dDaHsXh6JnDP/SguhYED499AQr2b4y/CtZO/Y+zIsgsMbd8hp/s9vOjG8gU
         KdBN5kT6DC55yK9fdsy0ySI9apRfFeUTSz9Xa0R5ZY/PYc8pUxuakpJlim7lEjOyELaQ
         mPdIN3F2HTeNKeIF791ZGqB5OjBiiibfsY/DxuFXxXdeNGy/axx8jVNebiwKpfWMFKOL
         73elgf1njNFedLpyRGG9VoVaKFB0Wdcg55xKX5Lf0BO20rE5FdPVA3F0rLZ2QjZHvLZV
         EvpvZSKfvXWY2ILJ54Y0RgpBLXXMU0qqhsnnhbULbeuahlwwGGEqgF0vNoK+sUD0EYVE
         9ycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+HssYl2LLbJYOQvNh3qEP9sTGLgHERbvBGu9EZ2czU=;
        b=PFqOTq2S2V/O0i3S7lTq1ZBmgN8i51nVfgCiB/yc/uMJzH5lKXs4UHVrx3zWK08tQS
         l0M4iFbpL2+ZlpXMRpahq1v+D8iuPETSMdEg/mtWO7xFYy4w8rg4Rl5wGjk0e3F4uHYI
         Tygd5LjxpnTXL4gXOnsEZNHh+UvLhpdFoj2f/FMWo5cMZ9sX+y6/W55u02ayjHvGJDq0
         +PIrl/AafJFTvz8rI5ydnfMxrte9dPO/EeE8+zkTT/u4s0Mep+XIHLts7HF27uWzjvoR
         7B0Up5edbbVpeVG7YK2kjLPfsgP7rTXzhGYzsEnWjCMVWXElZA91qecZWZFQmcefgZQw
         3tCg==
X-Gm-Message-State: ACrzQf3LESuHLv5VFeA38Vg8LBA+accELhcootLp21RDKNT96eA/qs6L
        AOuqZQ7Vk1wDxVwUOVRIt2S4YwAsZi0=
X-Google-Smtp-Source: AMsMyM4xccwcFM1EM3LL91TNqr/89DrKtzblTyACJoOzzP/Ohs0IjBWKad84u2MzjXAAc+5DCGTscg==
X-Received: by 2002:a5d:5265:0:b0:235:e1fa:98a2 with SMTP id l5-20020a5d5265000000b00235e1fa98a2mr3460641wrc.73.1666297246468;
        Thu, 20 Oct 2022 13:20:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o16-20020a056000011000b0022e38c93195sm16876181wrx.34.2022.10.20.13.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 13:20:45 -0700 (PDT)
Message-Id: <affd0e24e1d41e85df434539ccd13fb9600abd77.1666297239.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1321.v2.git.git.1666297238.gitgitgadget@gmail.com>
References: <pull.1321.git.git.1661806456.gitgitgadget@gmail.com>
        <pull.1321.v2.git.git.1666297238.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Oct 2022 20:20:35 +0000
Subject: [PATCH v2 4/7] t5617: drop references to remote-tracking branches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

It has included submodule cloning tests without remote-tracking branches
tests since f05da2b48b (clone, submodule: pass partial clone filters to
submodules, 2022-02-04) at least. Rename it accordingly so that we can
put future submodule cloning tests there.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 ...617-clone-submodules-remote.sh => t5617-clone-submodules.sh} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename t/{t5617-clone-submodules-remote.sh => t5617-clone-submodules.sh} (97%)

diff --git a/t/t5617-clone-submodules-remote.sh b/t/t5617-clone-submodules.sh
similarity index 97%
rename from t/t5617-clone-submodules-remote.sh
rename to t/t5617-clone-submodules.sh
index 68843382493..c43a5b26fab 100755
--- a/t/t5617-clone-submodules-remote.sh
+++ b/t/t5617-clone-submodules.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='Test cloning repos with submodules using remote-tracking branches'
+test_description='Test cloning repos with submodules'
 
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
-- 
gitgitgadget


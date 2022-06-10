Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271C0C43334
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 00:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345236AbiFJA0c (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 20:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236283AbiFJA03 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 20:26:29 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E7953729
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 17:26:27 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n185so13160686wmn.4
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 17:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PFQNog4dekWVD0soIGWRjEv+FE5TKkozPtY4iVt7lRw=;
        b=GcgLVwljhq+EA3u0ccmJvsEXAaVrksuWRoSWmiz605hNPzaZ0WcoCBcf27Y9XfZGXz
         lsm6CRZXRfpuOG6LfkQPD7KQ3rz8fzUaJGMeeIWbB5PJP/P0lIS3cHdfJzPFdqIoE+ty
         uoEIwQoNCbv3Xsj413h8U7TF5xUUEliHyypRLL3W+MaS/8MVf99YFOZ7V6IhNyzx/Ku8
         5bKfoNVUj+tU4UzQYAK0lwD/YR+Pg4Lhgfim4h6Px3YAwTgJF39HsfNv/YR5pkVTExBK
         Ercsm5zdeOsVPGqjG0rfGjc60Ser2O0f/r0F3x+ADHRW2CZ0XCC9WhF3aXHPQs1RpGBA
         2/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PFQNog4dekWVD0soIGWRjEv+FE5TKkozPtY4iVt7lRw=;
        b=NkKjEChnqivHalij31646QmofNNdVPASSgHtGji4N76XMHcVAoqKKN7Wr8VIlbOh8p
         66PZPxPArFLlenxPLue0Dmjs66na61HUlJ8/cVLSvjkUssctz+jJ7HJcqlShiNLLoDpJ
         r6UeNz/lgcmS70syMmNCxjQMeCHjXuHVTzSe8k32s0oJuKCxqILRdzNbjOLo1tTW6n6I
         TIpu7/gfbnRb4n058L1mQnnGqzuB/5OS0F/1AHhzj/irnJoC1cZNhwyz/WiiS7rC65Wd
         7mN8tviBXSD8JMv5EGZWT49r7d7NgKsn6GAUvmoogrBclQaAF5myULjIaGWccxnBggmr
         B/lw==
X-Gm-Message-State: AOAM531K3Aagvqnm8oJIcWBiCidIgM2yHlgE+IKBqb76gC0oHyLjwy1P
        /l4DUV2j7u1km4dfu9nja4I/mtaxIe+a0uY6
X-Google-Smtp-Source: ABdhPJxT8TruzkGfilUvxNUUh9aUUpdwxxnukuAGnr6yKac08F4P8s5rwcaz/S7MFg8QrAVVbRTCLA==
X-Received: by 2002:a05:600c:2297:b0:39c:511d:4b6 with SMTP id 23-20020a05600c229700b0039c511d04b6mr5870328wmf.188.1654820785253;
        Thu, 09 Jun 2022 17:26:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u7-20020a05600c19c700b003973b9d0447sm1025508wmq.36.2022.06.09.17.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 17:26:24 -0700 (PDT)
Message-Id: <058d84864120844e70f3a2dc65432d6327d63bea.1654820781.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com>
References: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Jun 2022 00:26:15 +0000
Subject: [PATCH 2/8] submodule update: pass options containing "[no-]"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Atharva Raykar <raykar.ath@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

"git submodule--helper update" understands these options, so append them
to `opts` and remove their intermediate variables.

As a result, we now pass every instance of the option and its "no-"
variant to "git submodule--helper update" instead of only passing the
last instance. As we noted in the previous commit, this is good because
this makes our options parsing consistent.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 git-submodule.sh | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index f4679e0db80..8c46eac22e8 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -296,10 +296,10 @@ cmd_update()
 			update="checkout"
 			;;
 		--recommend-shallow)
-			recommend_shallow="--recommend-shallow"
+			opts="$opts $1"
 			;;
 		--no-recommend-shallow)
-			recommend_shallow="--no-recommend-shallow"
+			opts="$opts $1"
 			;;
 		--depth)
 			case "$2" in '') usage ;; esac
@@ -318,10 +318,10 @@ cmd_update()
 			jobs=$1
 			;;
 		--single-branch)
-			single_branch="--single-branch"
+			opts="$opts $1"
 			;;
 		--no-single-branch)
-			single_branch="--no-single-branch"
+			opts="$opts $1"
 			;;
 		--filter)
 			case "$2" in '') usage ;; esac
@@ -354,8 +354,6 @@ cmd_update()
 		${reference:+"$reference"} \
 		${depth:+"$depth"} \
 		${require_init:+--require-init} \
-		$single_branch \
-		$recommend_shallow \
 		$jobs \
 		$filter \
 		$opts \
-- 
gitgitgadget


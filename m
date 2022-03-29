Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1691CC433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 20:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241144AbiC2UDV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 16:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241125AbiC2UDJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 16:03:09 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0505C1AE61B
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 13:01:26 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id w4so26330242wrg.12
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 13:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qLajjswiiX6/ldQlXRShnGxLPyX6FRm5cSbPF9HVv1I=;
        b=nZrARCFc93Ry+L4D2SAmXfWotji6EgyuNDY767Z8iplz2J2ON8O46tp+ilqphwrPSg
         7wejuu41/sm0J6tGiDgDEY5D175Ty2sZYDi03zp2zW7csjNEQOJNf+zd4Y36oFwI5Yys
         7Q9eGfHNaWSNmGfdvk9fp76oNKfZaeS0oSqEBe/721fy7ok0G75qqhFEKCunzJwBn2WL
         F0erT00R3zjiionMdhYl5ENI5uA/dD978Q5TzAETGB5pPaCqN+Hr0K500/1R0zyoPPs8
         RT1u883XvyWbNfbqsIktrkQkZWstosiy5c2Ejy81isUXTWJcCsqtVL8ctb4CSmlsmoQj
         VQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qLajjswiiX6/ldQlXRShnGxLPyX6FRm5cSbPF9HVv1I=;
        b=MughCP5mTiMJrem+Oyb/KYU8ECGWQrh1BK3FMy2ZuqhuLPGb8XD2SYxw6jQTI3A9E6
         oetrHYGZo0GQu4ABmDDcQT2D2PB8hWrgQxqgqg0HZ6omPHkEaXY1761aqfOi3V3L25b3
         sAGpQWEoWdAK78uTdkpQp98EPBjw7dvl5aMkINvoYws2FlxjXZpeHT73Hqsu5woLuuGM
         OSksH4lnJykuuab/V3LF+yMSuAek9atOwIJB95Q6ADyjyTxe99Mrwm7y6HPOW+573kZb
         1mGKiq3PBbhPDa54lX3jgIQ07JQ2cTX5CH3juLAIrjMLFvrpDzL2TqgLIqJdlum8Ry9g
         K8TA==
X-Gm-Message-State: AOAM530+GUsc2AL6BObih+wuVJLDR9p6x+2LvdYhsyG6AQxjJEXvnwwR
        V9ynwVmm1sEBsnu+srT/Q2b79i0qWk4=
X-Google-Smtp-Source: ABdhPJzEMWadrY8WYrYRwR/2YQqCpyFKgo1aDSx7yB5SoMXVNuDwE+VvnzeTsDqtGfWXseTMA07SfQ==
X-Received: by 2002:a5d:64c8:0:b0:204:ccc:4ba5 with SMTP id f8-20020a5d64c8000000b002040ccc4ba5mr33556335wri.409.1648584084340;
        Tue, 29 Mar 2022 13:01:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b0038c6c8b7fa8sm3064042wms.25.2022.03.29.13.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 13:01:23 -0700 (PDT)
Message-Id: <fb2b472d9ae66bcdcde6a8417486172a47c71258.1648584079.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1190.git.1648584079.gitgitgadget@gmail.com>
References: <pull.1190.git.1648584079.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Mar 2022 20:01:19 +0000
Subject: [PATCH 4/4] branch: remove negative exit code
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Replace an instance of "exit(-1)" with "exit(1)". We don't use negative
exit codes - they are misleading because Unix machines will coerce them
to 8-bit unsigned values, losing the sign.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/branch.c b/branch.c
index 4a8796489c7..eb231b950bb 100644
--- a/branch.c
+++ b/branch.c
@@ -263,7 +263,7 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 		string_list_append(tracking.srcs, orig_ref);
 	if (install_branch_config_multiple_remotes(config_flags, new_ref,
 				tracking.remote, tracking.srcs) < 0)
-		exit(-1);
+		exit(1);
 
 cleanup:
 	string_list_clear(&tracking_srcs, 0);
-- 
gitgitgadget

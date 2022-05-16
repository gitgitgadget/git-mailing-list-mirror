Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C68C433EF
	for <git@archiver.kernel.org>; Mon, 16 May 2022 18:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344605AbiEPSMA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 14:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344603AbiEPSLq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 14:11:46 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12EF377FC
        for <git@vger.kernel.org>; Mon, 16 May 2022 11:11:45 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id k126so9200492wme.2
        for <git@vger.kernel.org>; Mon, 16 May 2022 11:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2IlzxJ7VZLFYW9FoTSMVdEvLGG9ryAdgqq2Dl4y6yJU=;
        b=Ah6c159hgMD1XchGGpVeiutzh3AM7s6ybmiGVB6bFdWhgm1jyCWf7Ax1hvRoYaoxm0
         T33ihuQD/Dloj4slhEPam4Dp+0psNbSn2+MSLr0kRxQwt5eF828TyP45N3bG0uDKfndd
         ERd6AfvyVWnHQXAwrnCUzO+eX9diseCiVHaOhSVYBA2+e3RXKL7E0abetmYaKt3gn/NC
         YoWpGSwg1auhQWrooFhTkEUTaSKgrNV5M0Gum32yun/XInJbpWXg6yCUr/Z8RxYVuLc/
         euUEvuZi8zuoQSAc54q/d8jKcEiJu5F8ILMdEHu1rxhHPww3sbma/6+xipeSgrlT9zXM
         1XRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2IlzxJ7VZLFYW9FoTSMVdEvLGG9ryAdgqq2Dl4y6yJU=;
        b=aNy13QXQlx1z/TQvER99x0tn0Na4MEQWW9Ny2OzIspd0dKuAoeeAS4Vwwy6pTHLBMj
         gsXg1pOSaBFS1oFTtQcqKjrh21DD5dzhWIp1CSE4TkzB3guJVb5w9eH7xPxmDVfok88m
         kcXGh3g+mhJcY0kmaP1+Mc3LQrZPamZ+3i2TRXOyIlyLWTeuK4GPZCF87jBwwGxBwjJF
         pVDQqiIrhJ7I4yNPYU6/DeZwz77b/ObuhJM9By5dy9ZWco1qLHbUKq3vuXH8sDteYOzP
         KFe4jTsYP6uAhDJ785gNxbRvV1lSeZFGs8AGYweR7Cj5tFt9kF2AHgRQTxrHj7ypP49U
         yffA==
X-Gm-Message-State: AOAM530KJBHF60CG3T/IlJgFURv8keFBd1nMky4J4c9Nw8xUElyhW5JR
        S6IqOR3EQ+YBdc5tTXRuF4LPghc3DHY=
X-Google-Smtp-Source: ABdhPJzHWgt0he0o0FZAb8SZttt2lV2B8dF3M/PE0f7MsPE1EdvecGI9cqGenNerMLwPc0vcbaVTrA==
X-Received: by 2002:a05:600c:4f95:b0:394:8919:7557 with SMTP id n21-20020a05600c4f9500b0039489197557mr18502411wmq.166.1652724704086;
        Mon, 16 May 2022 11:11:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b2-20020adfc742000000b0020c5253d90csm10141083wrh.88.2022.05.16.11.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 11:11:43 -0700 (PDT)
Message-Id: <2804326c8bb0f70ca43e68c03789f32ad628cfaa.1652724693.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 May 2022 18:11:32 +0000
Subject: [PATCH 7/8] p2000: add test for 'git sparse-checkout [add|set]'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The sparse-checkout builtin is almost completely integrated with the
sparse index, allowing the sparse-checkout boundary to be modified
without expanding a sparse index to a full one. Add a test to
p2000-sparse-operations.sh that adds a directory to the sparse-checkout
definition, then removes it. Using both operations is important to
ensure that the operation is doing the same work in each repetition as
well as leaving the test repo in a good state for later tests.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/perf/p2000-sparse-operations.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index 382716cfca9..ce5cfac5714 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -110,6 +110,7 @@ test_perf_on_all git add -A
 test_perf_on_all git add .
 test_perf_on_all git commit -a -m A
 test_perf_on_all git checkout -f -
+test_perf_on_all "git sparse-checkout add f2/f3/f1 && git sparse-checkout set $SPARSE_CONE"
 test_perf_on_all git reset
 test_perf_on_all git reset --hard
 test_perf_on_all git reset -- does-not-exist
-- 
gitgitgadget


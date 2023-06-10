Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336DCC7EE43
	for <git@archiver.kernel.org>; Sat, 10 Jun 2023 20:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjFJUVp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jun 2023 16:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjFJUVi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2023 16:21:38 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109E43ABF
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:32 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-30ae901a9ffso2674405f8f.2
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686428490; x=1689020490;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EuEC7ZPeXKOGDsEdiD9s2S26+adBCwfD9y21ZQNkMw=;
        b=rAbbzOQ4at98Walc4ogYwqnl1f8Fw+1Frd+hu5F7/VAYhGMwFjBZFgq6Dn40e+N7JW
         9XXuhSOKVZrLeUaxCPimNTv+59/h36/Hs7pVQDNUP2znr12SXmCDAYbD1PO2tZ8BspCh
         ElwYmQOp3rPQSqv5jj5xS8uDUdjSC8gSci/XfRrLSpkpgQZjKLU9fMsWqYTdd1A/w1uu
         gzkAqZsOrYSBJ0fC4I7cm/GJMBuZyf3cMELUdzDNUdyGi8l4PAVs46Ejz95GWQnD/wEk
         tmjlxHnK2R181iJMH/cQH0iFMTDrIvplWhu2Bvlq+8nLjs0NHrBMJpWLFPLuLgRbeTdz
         gpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686428490; x=1689020490;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8EuEC7ZPeXKOGDsEdiD9s2S26+adBCwfD9y21ZQNkMw=;
        b=RBEBlx9oybAVERlPyc3WdbuQkJez68QsgTkclncWT0vIKdDyFpQ4k6wtikfowV+HaR
         sNx1KzaZBM0yHhCWO7+0lgPf8GYsE9xbAJDkDn7lsYICWywbaTsPeN0v4D+ae5k+V5An
         9f9j1kQwKX3bVyxB3UQ6K8oswi9aqhTvBV3EdqAnvMtJpgJOWYCXpwUr3DUhWs5BcdSM
         JCr/vucdelPxQt3Qe1wF61iw84MRn+ZYMo4lZcg881zoWp9IyARQCA8CBA60L//I0QDl
         aQvYHWlLGUtxo4cLp7IyOZiZYvOYZr9IbKJazZjlMmxO8tbtNezImorEVcQfrGm1qa72
         y5lg==
X-Gm-Message-State: AC+VfDy1lnnekpTpAn4WzdW4SN0HryA2D6ENPCwcMQzLJ3i5+PKSmlgq
        GAKMGSQQkMYuw8KrumfrVeUtGMkMKcc=
X-Google-Smtp-Source: ACHHUZ7K3ium3fDQVTjSLIfb57MbhCmrE8QUmst6s+nN7zCod7BFq0Q2/MMC8wFfF6kDQ9ymnCCbXg==
X-Received: by 2002:adf:f00b:0:b0:2f9:a798:602f with SMTP id j11-20020adff00b000000b002f9a798602fmr1772562wro.48.1686428489888;
        Sat, 10 Jun 2023 13:21:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m6-20020a5d6246000000b0030e52d4c1bcsm7964935wrv.71.2023.06.10.13.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 13:21:29 -0700 (PDT)
Message-Id: <7296a3a8c9da5287cca85c61af342dfc647fb2a8.1686428485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 10 Jun 2023 20:21:05 +0000
Subject: [PATCH 06/25] completion: complete --default-prefix
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4c43d13eef4..6af04932a0a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1750,7 +1750,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--raw --word-diff --word-diff-regex=
 			--dirstat --dirstat= --dirstat-by-file
 			--dirstat-by-file= --cumulative
-			--diff-algorithm=
+			--diff-algorithm= --default-prefix
 			--submodule --submodule= --ignore-submodules
 			--indent-heuristic --no-indent-heuristic
 			--textconv --no-textconv --break-rewrites
-- 
gitgitgadget


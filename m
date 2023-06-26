Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C4EEB64DA
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 16:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjFZQ0I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjFZQZC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 12:25:02 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8FECF
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:24:56 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fa8cd4a1c0so16868275e9.1
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687796694; x=1690388694;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/BSvPlpPQ+gzO2pSRwkDZXAM5xHHZSyB4ue8FP/Dok=;
        b=LZArH9gWSxb39Jwb+2pUtHHg25CI2S9ExItMkMk5o+BnJF1Z8pbAQiWGNSCPhsHDYA
         dpqUpDrgfve1wz5erkb59sRdQwGBhP7no6aI1iq2lICa5syliwWGF1Ms6Zn55cenVCLb
         ZmwBYN/WuSeu386mKmE+chwcjdFZx8hLysrQVR3F2osY+8vcfROr/qEC965SerMrxCwH
         GtoFS7QMePJ2GHlTYmZnfPEdqAfxVuiaXake8utmHv1fR4jhK9laxdCjjqBUuYqThNcV
         XpEfctI7xuP9VcJgIWcGzKfh/xz7K5dFWsDr3JU4VQp65/7OnBSta/GabCkUgKwRnEow
         nnsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796694; x=1690388694;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/BSvPlpPQ+gzO2pSRwkDZXAM5xHHZSyB4ue8FP/Dok=;
        b=Ih4xH5LAFY/WDz7xIu2sbNXc6RFnRvC3tG0JuqI9L98eblxctoWwiNyTASkzXugfEx
         miVIgrBm0X75y5shROxgim4CFyiktTK4SDQZaKvJRHekAPoyxSM3Qrb0Zseu3jprbM2I
         hPjFEF0zqwV/lduwCdvRMJtRfdRs6OY587LGrmtwhg/UY9uUCXnxT9qsgT41MGmlm9wk
         4qqCKHdE4vrscBuCmIsjr/GkwmKfqQykuUOlSVbxBeSNua2r1JPTwt7iM2nKfEnRM2Pi
         qxRRmjK6OlQDRNMd+dGLcAiP/PMeQQR2vlnjIPPV8pG/9BBQd8TCKcV67WwEE8s2Hl+1
         DphQ==
X-Gm-Message-State: AC+VfDz+EkVTdN7FtykO0SX/xtntUjrHwhP0H8QoNx1z2QGQ5cSknjhC
        zkwzlAwwRcpSjQowArmj8adg8OoxuTE=
X-Google-Smtp-Source: ACHHUZ7tv3aaZDCihhvXz3KSlX6LIKoFLUwP0Xnxr2/V5wlK29ZoouPxsGXt+xqZz0GoYd1TIR6FBA==
X-Received: by 2002:a7b:ce18:0:b0:3fa:7eb6:2edb with SMTP id m24-20020a7bce18000000b003fa7eb62edbmr6763989wmc.19.1687796693857;
        Mon, 26 Jun 2023 09:24:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j9-20020a5d4649000000b0030aefa3a957sm7814340wrs.28.2023.06.26.09.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:24:53 -0700 (PDT)
Message-Id: <51024ee2f2c4862d223e10ae4f193b8e0aeb1c60.1687796689.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
References: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
        <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 16:24:28 +0000
Subject: [PATCH v3 04/24] completion: complete --combined-all-paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
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
index b61c54e37f7..58ce64de9e2 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1754,7 +1754,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--submodule --submodule= --ignore-submodules
 			--indent-heuristic --no-indent-heuristic
 			--textconv --no-textconv --break-rewrites
-			--patch --no-patch --cc
+			--patch --no-patch --cc --combined-all-paths
 			--anchored=
 "
 
-- 
gitgitgadget


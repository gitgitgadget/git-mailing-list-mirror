Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDCEC7EE23
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 12:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235766AbjFLMxa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 08:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235689AbjFLMxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 08:53:16 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DEE10FE
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:01 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f60a27c4a2so4754044e87.2
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686574379; x=1689166379;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/BSvPlpPQ+gzO2pSRwkDZXAM5xHHZSyB4ue8FP/Dok=;
        b=Yz6FZCgq9mUVH4k4BNG+B7SN4yhAeQRuAKsX6YBYyGx3t2LUcA97u+qGuZJqqAk/Ve
         PMVnCcFdgTBAUmAY4m+6o3Da5+4TqhCXMmwxvcJINL9g7iTPKgKKARER+WWvlpd1F12E
         QJFFP6LqpxhgVP0+8rUBcJLNOH2zDQkfa3ega3eWtDLHYO+HhSUGg5xkUEhjn+8YDTkG
         sr1GYIKn/3pB7Ua3xClN6g16SF4ZyP9J9UWwFz9m6vcU8y5tfE5Vq7NbAGKr9aNP3nLG
         ABvOre+5CA8Vtl2Ef86LUsCeQNY0s9mVTXjwrfAirO/1wUVMlG2CfU2fqrBSEJOwU/QS
         rBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574379; x=1689166379;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/BSvPlpPQ+gzO2pSRwkDZXAM5xHHZSyB4ue8FP/Dok=;
        b=hu3wKjkR4UuUDCCYO/s4VDu2hD1cCKZz+mjJo0XPIROqLncRC1dRrn1QLdw8xR3JGj
         xrP6l+SXAYVwjWclqUUJDEwiVUofXU3UvrSsiXg1WvqDXzl17IAD7dF+9vtbAueN8Eot
         vu5E+uAHEhun3bY9LbV+1XjpXVQpMstdUY02sZbifjophmp0wDRbOi9bLk5Usf71MnP/
         gNIZvrHbdYrtxnUzknc2Xi893RqXMKcw0AGJa5eHD2G3UxR/67kWKjWDeApR/0ZwtAgZ
         fERY11tZSfdPRHa6xLKEnjRJsL+2UPO/vloFAWNSVGmRC7n7bwengQOSgblNT0jwj9wo
         pj4g==
X-Gm-Message-State: AC+VfDzM/NI1eMh8npyfXc05QUJbrXK0DTtvthV11i0FcgwyzD7DsUF9
        TdYtJ51xt+ybL87iAs9ntC4egJyF1AE=
X-Google-Smtp-Source: ACHHUZ7YLZcgmFbp3E9hFiABjBCNxlTxytAlxB7qEnZw71kpGB/SHljx4qq7gde/UiVqPXsJAwnqTA==
X-Received: by 2002:ac2:5485:0:b0:4ed:b4f9:28c7 with SMTP id t5-20020ac25485000000b004edb4f928c7mr3721904lfk.6.1686574378959;
        Mon, 12 Jun 2023 05:52:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f5-20020adff585000000b0030796e103a1sm12555700wro.5.2023.06.12.05.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 05:52:58 -0700 (PDT)
Message-Id: <51024ee2f2c4862d223e10ae4f193b8e0aeb1c60.1686574374.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
        <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jun 2023 12:52:32 +0000
Subject: [PATCH v2 04/25] completion: complete --combined-all-paths
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


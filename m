Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976F4C7EE2E
	for <git@archiver.kernel.org>; Sat, 10 Jun 2023 20:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjFJUVt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jun 2023 16:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFJUVg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2023 16:21:36 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D483ABA
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:30 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f7f4819256so22113365e9.1
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686428488; x=1689020488;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/BSvPlpPQ+gzO2pSRwkDZXAM5xHHZSyB4ue8FP/Dok=;
        b=d6lQ7kwgHA2ojqW9k3bRqpFdg44AQ/Mk27o3IZgh4eF7KElpJuX+1UGyplr61qCKCL
         gI/dLud7Ls1DokugX+FWy1otmUdPaQf6KY266Cu9V3Ocp6edGrZeOxOTsenkRaWk3CL8
         rL6y3//1AtHoWG+Bn+UtRhuv9uZXeQmsMwcvdTeUD7EVQ9kxGxKNCF/66FRHjfw5+C6d
         iS+XrCFv5ERu3MOaskHxBJ/37NXC8vCeM6+L4Mx/2UHPTZ7A7tR9xpibJazRUk/bfLW+
         EnRQsSHmjtcibBxZEU7QrOdHSCC2h8mCLig8o5XvSrWB58ociRqRNChHDq2GA4ooboLW
         RODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686428488; x=1689020488;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/BSvPlpPQ+gzO2pSRwkDZXAM5xHHZSyB4ue8FP/Dok=;
        b=Zha2kF6FLzOBS8DizuXQNNym7It5vLTwHjkvmTyucHFzYWSBfQKSfpcO6nl1spUZ2m
         Subrc8om0Zr8kQXGWRxS4KH3dB0BO0dp35+t32SFRdE38yXD7W6WWqaH4YXqEcYzyA6X
         vqZv1boxVaYalgKg9iwSe1u4R8JMG3iVA6d34Qn0SEKPJazOLMqK2mW65prMVyfFBg2n
         8I7XPOr6Qgr89etksAnyaeJrKPvs7H0qJquReTzPm9osi2bNwH3vRWFl9vsIcNzNGGNH
         mTAmsktE2CXj+D+x9gNhsHkHkZOAsHhQ2tSX694ZF4B6hpa7hVm7dq4DXlth6oE2rk6S
         NOtw==
X-Gm-Message-State: AC+VfDxDo9/gfZm46JdN+ZP38C+eii9UPzMUZq8eePoJmqjpY7xTrohe
        P/V9d507lA9zk+jSMYYItZtGNiVXX4w=
X-Google-Smtp-Source: ACHHUZ6eYNMpAfLxGMSTux9h21Av9V8mhJmE7oacvRDT2gN87/7p/CZNpNT5gfoFxiRxtANX92xa4w==
X-Received: by 2002:a05:600c:3786:b0:3f7:f45d:5e44 with SMTP id o6-20020a05600c378600b003f7f45d5e44mr3553581wmr.32.1686428488535;
        Sat, 10 Jun 2023 13:21:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 10-20020a05600c22ca00b003f427687ba7sm6516377wmg.41.2023.06.10.13.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 13:21:28 -0700 (PDT)
Message-Id: <51024ee2f2c4862d223e10ae4f193b8e0aeb1c60.1686428485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 10 Jun 2023 20:21:03 +0000
Subject: [PATCH 04/25] completion: complete --combined-all-paths
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


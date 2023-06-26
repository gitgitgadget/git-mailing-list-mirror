Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1A6EB64DA
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 16:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjFZQ0G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjFZQZB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 12:25:01 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F841732
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:24:55 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fa71e253f2so40495835e9.0
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687796693; x=1690388693;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+M0/92IfMNu3+ZNKHyADTtuyGLmFRsLqMO6az5RJJ1Y=;
        b=P8on0iYtjTkBqm8/pVIwVzcTBhCas/pw8AVixhIV5PMmspHS0FrR55+vLZLIWLtOnt
         TskpyLhT4Q2clxUvxcQEzp+YQFp6ewELgilMDZ3MZkyGg+3pZxA6uuMGrPn/MNQlwHp1
         giFGttTjUbgPGx2YRO3gz8+ULoTQW2s4RA87WGM7N1Go4UYFi1smDr1UaNIR8vxETdV7
         H4tCoJBHPZciB2HM9D4Z8X9T6aWWCnT1Sm93C4PKcNjgawmkmcY8GB/eMgKOe0S4+SsZ
         lvq0+sNrdjr/OYZP87mIL808bMWaKJ2q/g2/Z1ttHsv1+RNYVbJuyfDurOSjk7a0AyFd
         P8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796693; x=1690388693;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+M0/92IfMNu3+ZNKHyADTtuyGLmFRsLqMO6az5RJJ1Y=;
        b=BoMC+2GOVe7B09Jnh14LHpdxWT4eJ7j1RK3GlnooCJtS6QMcmd7eQzdN3qW2WaG+pc
         ecmrt2ogHKFCgQBNsGOIhf/bw7/LqbsNbp8WYlnSVhjBgJ1K/zHSsy7tg216wYykr7GJ
         U64fatolEinly0XV3+JQahDtlAfZiJ9O/s5TEONG5MU2NQvx9kUxtHBTzabUmuM6LHrZ
         Pvs/ufLaTohQ8ln6Zjy9PQYvX6IdMQaGS6PRDIGRgMuMTDvg/z1U2WaELjsmLwra+iQ5
         CuH39eADUoR067zHeztb6zX4JYYlnNd0K6CNtCWr8+9gAnl4M+TX1KZFaAF2VFlRrvVZ
         vqnQ==
X-Gm-Message-State: AC+VfDwgnQ3ZqSafIM1JeOCJNTeLxXes4J5IWK0UJyai649ZzQfUIJjS
        WuWHgd0Bbgz/xX/TiTVkMypRFlC/dFY=
X-Google-Smtp-Source: ACHHUZ68ZiXS5X7dI12NAxwWpMAmgRT/ul1nBUOIPr6LYSMe5meVMOma6jXjNLLbk1Wrvtems65ExQ==
X-Received: by 2002:a05:600c:3659:b0:3f7:aee8:c23a with SMTP id y25-20020a05600c365900b003f7aee8c23amr31172675wmq.19.1687796693018;
        Mon, 26 Jun 2023 09:24:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id hn8-20020a05600ca38800b003fa722e8b48sm11189930wmb.32.2023.06.26.09.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:24:52 -0700 (PDT)
Message-Id: <d38823dd116e4579bbbeb96ff7b1eae8116681bb.1687796689.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
References: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
        <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 16:24:27 +0000
Subject: [PATCH v3 03/24] completion: complete --cc
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
index f07b00b9c68..b61c54e37f7 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1754,7 +1754,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--submodule --submodule= --ignore-submodules
 			--indent-heuristic --no-indent-heuristic
 			--textconv --no-textconv --break-rewrites
-			--patch --no-patch
+			--patch --no-patch --cc
 			--anchored=
 "
 
-- 
gitgitgadget


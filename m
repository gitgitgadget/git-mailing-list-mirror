Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE81BC7EE2E
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 12:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbjFLMxn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 08:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235691AbjFLMxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 08:53:16 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2609E1700
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:02 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-30fc50d843aso446143f8f.3
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686574380; x=1689166380;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mkt0tgPGKfg5NkOEOLf6K3kF+oWQxLyWGbxdvLD95AQ=;
        b=sMVcgpTIiWrgsB94AmyYjh117bKoudYXa30UHNHiRZGUV32W9U471aP/qj/yDdqAkq
         tUzV/6xv1UpfBxL5iNIZn1cuzabibppVmkA+gCrSFFADvueeFFnnDiGj7OL+dV4mbOQV
         f9ExwN2fK+qyQDCIxUPykUMSjx7Rgb5N81QRb+S+2OiecMfQXIJcGpqkC/TsYEpv0V5H
         kI1cTqiHexAtElbNmhcKNgKtyGnhn9zh+wKdjHk81x/KN2t3z+QnOsupALWHXPekRd1K
         GLX7j0Vgshs1aw3A9xWMuV6IXTtoPuO/sY/u47qG1F8HadhuL9sbAlaV3mAVFVLOWnBz
         ocKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574380; x=1689166380;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mkt0tgPGKfg5NkOEOLf6K3kF+oWQxLyWGbxdvLD95AQ=;
        b=MzQxyigyOqzcUglCTb5k5H9XK2GPryvEXAqaLmDpLIBa1E2Ovg8Sp7M3A2WA0RgBcF
         RpU40nU05ar6rM9FgqBRMzdDygDxHMOWRQDvi4t1tL2X5oMA+EWaaRHJvMisANEGBV6J
         6aq9BboCaN6lE7eZKnCsC//hDWtk6O01rM4G0c2G62fDQzEUGEE+MiNHC6tw3TokwivA
         1aAuDw8tEacpm/oAATpZ3oYEP4lhgsp54kW9wa6MnuX+p+lqLB5AeP9XNCHFKPfWGQCB
         VRqCK7xoLrxVDOFhH3ZX9HTsllx1GDOV6EPRdwi8t3RKO86oHpESnavaw4WrHHsjHRYa
         KltA==
X-Gm-Message-State: AC+VfDzQaijPld1yUhM0ehWebJ/Zo5jhUxvEeeQRD11EQ8QnvGL3hmHS
        xdGfFMoRdCpxFuTReYGRF+TTBNG+Ycc=
X-Google-Smtp-Source: ACHHUZ5hrNux9ovzDMA9y+a0ng0FBaBGCmTJByJT4+T5k0Sv/F8r62ic3cfJsSPOVqErLm2AHCleJQ==
X-Received: by 2002:adf:de0e:0:b0:30f:b949:f7d1 with SMTP id b14-20020adfde0e000000b0030fb949f7d1mr3344484wrm.63.1686574379900;
        Mon, 12 Jun 2023 05:52:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y3-20020a5d6203000000b003062c0ef959sm12450052wru.69.2023.06.12.05.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 05:52:59 -0700 (PDT)
Message-Id: <63d70d645e25a2e7f9d3dfac7f6b01c3bd27fd7e.1686574374.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
        <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jun 2023 12:52:33 +0000
Subject: [PATCH v2 05/25] completion: complete --compact-summary
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
index 58ce64de9e2..4c43d13eef4 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1755,7 +1755,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--indent-heuristic --no-indent-heuristic
 			--textconv --no-textconv --break-rewrites
 			--patch --no-patch --cc --combined-all-paths
-			--anchored=
+			--anchored= --compact-summary
 "
 
 # Options for diff/difftool
-- 
gitgitgadget


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68A9C43334
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 00:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345740AbiFJA0q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 20:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345563AbiFJA0g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 20:26:36 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DD453E3B
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 17:26:35 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id q15so10021608wmj.2
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 17:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cD/muVBT5qHdmfPGMSd6wZrzp4t9IcPydU/z6WwapO4=;
        b=VIwxPyLMA4IaynO+ABXBTWobYgptseJPcDKRySLXElIYMaSqR3yjg0dq5bsMC7yX9C
         5y+Hounv6/hQ9QiuoV1a1FKD+xO3g1MCQ7Gl0+CAvpO/D8A6NZwsX2/GUwboR/t014Yd
         ya9oQPFUGGB99GaSww0GL3nxllqnfbJ8ZTcDzPC9634UHPTo5TXc2xvs0bZhkPZWGzca
         yeRcREGVIG4NJqR156KRb0hKFjQ4p8AVIE/Qt/OmLRMMO868RY0LmrBKbdW7bbxz5zlI
         K0GJd7JyRJGT652YRBmLME/sarMiDlZdEJV+3LkGc9GuxdTCx0KBqJypEIC/KzbjTPZE
         xYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cD/muVBT5qHdmfPGMSd6wZrzp4t9IcPydU/z6WwapO4=;
        b=nXPjTYlC1Dz0HW4GsW0+XnrLiTWHf7F4QXR4N+6UQaBhWT5Pt2zLU4M0cjei4l2VuS
         IKnaeND00gyH3ocrHj8MdgzznDbuyaE1DNeLdN3266sYvkVQn+8xKz6xmo45Dir4onK3
         jrmdP409EfoSjbfCTzbpEwtZcEQkWqndrikIKMjnCf8RLEzrYhZfC7d0lJ1DP+Ymu268
         O5g1YCVYCHdkaULXlunsyD1ksSd3mEK3m0hE8o4r2kuE+eTmjYdeMaXg/KE6WbCi5w11
         hbS1wcuWDpbwkLGnYwiJ72aWqWL8w+rEvmrxCcQTJTm8BT99oKtX05pPR0e2Wx/nCHxV
         8M2Q==
X-Gm-Message-State: AOAM5320rIz2qwgTpeiOJQvznTC6c4K/9Wtbdvvmnk7IUvPVVunp5wb2
        A7dg+ltBuwH95PsquI1AL5CfLaIGADKro5X0
X-Google-Smtp-Source: ABdhPJy02+nLjWBQKtSwvrGGGqHVivCMCaX7qg36XPbOm5tjoMJOGKCzo++rW7S1raggfVE/7dmteA==
X-Received: by 2002:a05:600c:1e89:b0:39c:5adb:6bf3 with SMTP id be9-20020a05600c1e8900b0039c5adb6bf3mr5705424wmb.91.1654820793282;
        Thu, 09 Jun 2022 17:26:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j3-20020adfea43000000b0020d02262664sm25397914wrn.25.2022.06.09.17.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 17:26:32 -0700 (PDT)
Message-Id: <242d3399dfb4fb533ca6cdca452af2717c316672.1654820781.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com>
References: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Jun 2022 00:26:21 +0000
Subject: [PATCH 8/8] submodule update: remove never-used expansion
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

The `prefix` variable is never set, so this conditional expansion is
always '' (which does nothing).

Signed-off-by: Glen Choo <chooglen@google.com>
---
 git-submodule.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index e9d93e91d21..2a6ffa8ac34 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -238,7 +238,6 @@ cmd_update()
 {
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper update \
 		${wt_prefix:+--prefix "$wt_prefix"} \
-		${prefix:+--recursive-prefix "$prefix"} \
 		"$@"
 }
 
-- 
gitgitgadget

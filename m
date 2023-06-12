Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8C6C7EE23
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 12:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236103AbjFLMxg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 08:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235721AbjFLMxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 08:53:16 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1BD195
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:03 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f730c1253fso31760055e9.1
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686574381; x=1689166381;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=con+oNf6coEKJAsHN/zehDywaFXb8TeuAbNFWjVUlrU=;
        b=Y4l+OWVSAHZLh47vOgNHh2B23CYzdvdL2HeNe2VfNfQgUa9/XlwDf7Z1gKpoPbsBg1
         MDtDEibv4hMgVI5pLq7FXV6ywiP0plKvYxsv6s5mpN1b6jarh5vGcR0ekIj0M1KITe4S
         nNRamwx8Tbdv44G6PgtjFnOxDfRITvFX2mgBEp7+OxCGmYwFWZLrPKzOrIcbfu1T0tOA
         smmppQzQMeJZK8OH7NP8AgPrZs72r1DVmPswlcw3PzEgR1BZZvtZ4pRso0ifNuiBC+sz
         5cPkhlRhJWOl20OnhBhcL5H3RLUXz6vgZzvy3wBOGreGIk3gT1iorPtXQbXqe+fz0hxt
         iS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574382; x=1689166382;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=con+oNf6coEKJAsHN/zehDywaFXb8TeuAbNFWjVUlrU=;
        b=FHktznw7lRysQYqS0pMsFnzkBkmpoWQ/m/6XXtzDjMxB5AFO8LkCKDNds4e9jeFfMa
         9/fIadvIe6EBBJt4H0zDPgtGK8gEnHezAehQQTKgVCGU2L5gjnN2/3kp+qd6tQKUr/yl
         20jUriWHP1QSY3D33KdQQ3F9kees1HWBWmYOBA9Lpt+WAtdmKPpr4CCWPdATe+iDBaL3
         QZP5ypPk5H8JTfe0HJ3vQCcskHx29T1QJa9vLmsGQxSUlu98MeqA6tYotSrafHdF1xnT
         pA+JYVsokq5auZkPIIZGG0ZweImmLW6Mxq4DtKO/WVcUca3tq1CJh4gj6ZVcUmK1WB+2
         WtGA==
X-Gm-Message-State: AC+VfDzDwo7C54+mzSUfXa9fggQVLBH7kK5IMool4WwPQQ5uA7o0EKqT
        +W+GBQp/6QMd9407rMTDRdH770a4+TA=
X-Google-Smtp-Source: ACHHUZ6RQw/AwXgt13EZoweF8hgsvWdVnxERZWyCJcLnQbwaomeUOqbEJBvoTkWUnBRmGowX89D93A==
X-Received: by 2002:a05:600c:24c:b0:3f7:f398:e1d5 with SMTP id 12-20020a05600c024c00b003f7f398e1d5mr6299438wmj.29.1686574381675;
        Mon, 12 Jun 2023 05:53:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z21-20020a1c4c15000000b003f80622bb65sm10400401wmf.12.2023.06.12.05.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 05:53:01 -0700 (PDT)
Message-Id: <1f9b213cee5a4c6325c7fa9528180e46aab7805a.1686574374.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
        <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jun 2023 12:52:35 +0000
Subject: [PATCH v2 07/25] completion: complete --find-copies
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
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6af04932a0a..dd6e12ad8f6 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1740,6 +1740,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--color-moved --color-moved= --no-color-moved
 			--color-moved-ws= --no-color-moved-ws
 			--full-index --binary --abbrev --diff-filter=
+			--find-copies
 			--find-copies-harder --ignore-cr-at-eol
 			--text --ignore-space-at-eol --ignore-space-change
 			--ignore-all-space --ignore-blank-lines --exit-code
-- 
gitgitgadget


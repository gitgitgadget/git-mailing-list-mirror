Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2EEC7EE43
	for <git@archiver.kernel.org>; Sat, 10 Jun 2023 20:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjFJUV6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jun 2023 16:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjFJUVl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2023 16:21:41 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817D935B0
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:35 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-30c2bd52f82so2903950f8f.3
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686428494; x=1689020494;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRxPtMHjcUedxPPl4bnw9YSFm+KCnkrh/mX3WuAVtFk=;
        b=HX2tXEXZJq0ZEEFD5Kgfx1OM0cuM68f2sxMkgd9GjbU19j7ESrV6FPf8ehTX5pP1qM
         gd2ctq7AI3Jx1+qiqlbW2SvuCGssB0jHX3XQ+JTWmLVXkOD50ElkOdJO24K23mSb4rDx
         it/XM/1HPVO37ErKy+RqY2zdqeOgjRO9rr3CNl50FEHpGOVLTYFzpDiOEUtFKo2ykL+0
         xkc4HXzooHi2eMKAF41A/Jf23Y6OzaG3bhszUxWoXRZjhWYFboyLYthA7qhhlyXpwExx
         bpOGotQra+wMLGYafP97FoM7ng+5zkL9KOxxwIY13BuByZlDMkb4l3PW6gqMrDfK/hf2
         JV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686428494; x=1689020494;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRxPtMHjcUedxPPl4bnw9YSFm+KCnkrh/mX3WuAVtFk=;
        b=AnT5UlfueHZqHmYVeE61md9PDfYMrYMFg4jQ3AWY7D9YRMGA//mUAmfOa4NSiJ2h0A
         eh89yk7qGu2Op3iej3F8yDN2MxaVL6df3ZG2yVjXDVJErwASGpQXkVK9ucMqoV6wHrW8
         E/htc9d4NFfFQOxD2S0etxrVSBcWLdFt5ASoHP+JS7m2jbdjTSkhxW9wI51C+CoNN9pj
         Vs7/xiWXuREecTuYqInePbnfL4FnQebE2mUeJIdNfZMT1h2P8LNpjMa6bBl4a9n5cSLe
         2vhIwo+wb8S8zm/ks5S98l/BQ8eDMKFQdQagTIAbXDIQmHyGMM9NhVIIK1lAKL+8vii4
         wZ1Q==
X-Gm-Message-State: AC+VfDzcTS9bvHE2swPkPgyB6wbVNcoVtE/XS8Nm4W2SnNV8wUnofBu5
        iSdcgZJVa/TFRbMWvtnWtzM0Ive6mI0=
X-Google-Smtp-Source: ACHHUZ6A6wD9q7kG5IAMN1MCPlZQO/Va9olUfnMhKfuOIgpjgfK6S2R93LRQeNtj2XOj5W29QTCNKw==
X-Received: by 2002:adf:dd51:0:b0:30f:b694:9b11 with SMTP id u17-20020adfdd51000000b0030fb6949b11mr1310792wrm.14.1686428493735;
        Sat, 10 Jun 2023 13:21:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a8-20020a5d5088000000b0030f9c3219aasm5779912wrt.47.2023.06.10.13.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 13:21:33 -0700 (PDT)
Message-Id: <8bd72945a2ff26c96cecc83abc07299ab51d262d.1686428485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 10 Jun 2023 20:21:10 +0000
Subject: [PATCH 11/25] completion: complete --ignore-matching-lines
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
index 2610a55487b..b4d0643b049 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1756,7 +1756,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--indent-heuristic --no-indent-heuristic
 			--textconv --no-textconv --break-rewrites
 			--patch --no-patch --cc --combined-all-paths
-			--anchored= --compact-summary
+			--anchored= --compact-summary --ignore-matching-lines=
 "
 
 # Options for diff/difftool
-- 
gitgitgadget


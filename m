Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E58C7EE25
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 12:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbjFLMxi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 08:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235764AbjFLMxR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 08:53:17 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD85DE6F
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:05 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f6e1393f13so31845965e9.0
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686574384; x=1689166384;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RknSMSJ6jkl1S2ky9jZa5xqSyZHqjLkO+0dQYVSmL5w=;
        b=UZfDtsHCLYYWJdSUP/15QQ+WKFV0wJO09D2ctFk8+IH0mTUoeBOj98+ny6DE6ZRjPV
         1FPPGGDBoV/Pt1IupGEhI9hDlJpLoc8DDraJXsQ/+mhtsqYCFpCNNk5zS4dG70ENOVw0
         P1wjaG6ig0uXInAQDQVejtaeCBsougXf687qnbrJLcKpXVa0aI9gaS97If+JEPBCDXZ3
         0yoLCDBGWgGagyraIFPA7T4G/IdWhEgcIrnQF8Ht7Irqnm8mbbHx4n9C0j/nMzEZQ4gY
         I7JwlKMubCwtibb88hQkcm1LfNw9AUIqxgDYLLG18mrMj/HpdeA/XHGiAPxohVF8q4h1
         iwUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574384; x=1689166384;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RknSMSJ6jkl1S2ky9jZa5xqSyZHqjLkO+0dQYVSmL5w=;
        b=hj83tgTL8iDbbcAHfwP8OEXWQKxQvJcoNZpPknoO/fnJVQkpZLsuKxVbzz4iH5OoBj
         jZc8zZprM/hL7crUgQ/dm2b/TlBeUw+CT1V3sOsroa2JGrAhcHziDt/UIpPT/DYapiSG
         8FLeCEDghHGzQhm9D5edi/PSEpVOvUTDEwCklYU/p6m9gdJddqpVVjOCAm1lYtYm8UXg
         krKfWVAjSqkBpSRBpYoP8/W2Gl3Rikr8aKvyFo17JuM8U3VwDAAQK4sWwZoPISEkZLe8
         YQyKuOCm5uzOktVNhGqgl4sfUyRZstceYd4r/brxrsJ8xSS95vrRdkXrTxXrOdb3ST3A
         jdWg==
X-Gm-Message-State: AC+VfDzUYpu6DjvO2vwEma7JaOPuxlk+0ynwlnSgDG69RwL9MyjhU1fx
        oLdNqLvS7a0v55lrp1VrLUpWPdcyP1s=
X-Google-Smtp-Source: ACHHUZ7lSzmtNoe2y7qlO1HxRhosLmwkmJEEBLvXRlXMP/WnSCfgh1FTEcKaZnVESLgosOgk2Ec+Ug==
X-Received: by 2002:a05:600c:cf:b0:3f6:41f:5a68 with SMTP id u15-20020a05600c00cf00b003f6041f5a68mr6459601wmm.29.1686574383997;
        Mon, 12 Jun 2023 05:53:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c0b5400b003f4266965fbsm11443423wmr.5.2023.06.12.05.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 05:53:03 -0700 (PDT)
Message-Id: <2503d990e5c7d1fb5bbf06493951204e7c00ea09.1686574374.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
        <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jun 2023 12:52:38 +0000
Subject: [PATCH v2 10/25] completion: complete --function-context
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
index 0fa86dcde6f..2610a55487b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1746,7 +1746,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--ignore-all-space --ignore-blank-lines --exit-code
 			--quiet --ext-diff --no-ext-diff
 			--no-prefix --src-prefix= --dst-prefix=
-			--inter-hunk-context=
+			--inter-hunk-context= --function-context
 			--patience --histogram --minimal
 			--raw --word-diff --word-diff-regex=
 			--dirstat --dirstat= --dirstat-by-file
-- 
gitgitgadget


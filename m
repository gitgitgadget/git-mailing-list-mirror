Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C715C7EE25
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 12:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236098AbjFLMxc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 08:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235723AbjFLMxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 08:53:16 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148A4E4C
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:03 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f730c1253fso31760015e9.1
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686574381; x=1689166381;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EuEC7ZPeXKOGDsEdiD9s2S26+adBCwfD9y21ZQNkMw=;
        b=GLlmgiEZVM/TBvUS02Hax+guf5YcxeN6dMDrz1ghcXAS49j/CQiCMAHPEThaPhysCz
         Aa+72YVJ+b+dRuaV0phXUrNhlfgKlEV7MUw1Z7UWLK10FWijcEnYoofg8yGrmgbo/gfL
         IOJNaM8y0cwkQot9dmY2BrCUeZdQxYl/9MA32sgtn+v1YmROseSxHqYDRXoL/0ongNPd
         /JDz9mix2yMXb1xYs36p8ZqjVJc3iBkvN5YUTbZiseSa9KTMClMXihh6GtRbK5PZbEKi
         73VWAFYzr6VyXYv+e3xjAVIDHaPPugjsrIxp473BZVwLHwpX2nzYmgFERGwFQlaFoZ1h
         PBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574381; x=1689166381;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8EuEC7ZPeXKOGDsEdiD9s2S26+adBCwfD9y21ZQNkMw=;
        b=lXqUd9csTuSFhSrUX25G4IUb1PF0gDk331wXAFhM24bhCQdSQzPVh4ss3KNDIi7kwN
         PjMQbjVrjHtj0gibPVdhXWNwdqKhPc5oPjimL6JHlEmZOUpYj3Bg84bn1N87W2pkeEnV
         3bT8+7yieFHQid0lefgu8lm9dbxms00G6hy6dQHTb3an+Tnzdek9Q3ZRSknCFY19x6D9
         pZ9BODPA079WI+6ARU+p+vw/DI7thkySudkp9nYPPxFiefYYv18VHJ5yWongqS+FUjak
         MZ2sYKWPUsxeAgQiY/rQv7joXj412yLNTETYqYQgdaCMr4y0JwRrIQZnzo7EDszGRFle
         RXvw==
X-Gm-Message-State: AC+VfDz0xpRAumtS6/QuINmSzMYpDhllz+yfLO/14v7mitHKDORYK2+/
        4/nYph2TjdvwfR5qFtGMPgLnz12rZjc=
X-Google-Smtp-Source: ACHHUZ5O4LlHEMW04Z/D89OoU/8sUy6Z8YBXtprkVa8v05c4hwe9BuWOUZL0bdHbSgtLlgqdVlktMw==
X-Received: by 2002:a1c:750a:0:b0:3f6:69f:75cd with SMTP id o10-20020a1c750a000000b003f6069f75cdmr6319862wmc.0.1686574381135;
        Mon, 12 Jun 2023 05:53:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o16-20020a1c7510000000b003f7e6d7f71esm11388373wmc.36.2023.06.12.05.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 05:53:00 -0700 (PDT)
Message-Id: <7296a3a8c9da5287cca85c61af342dfc647fb2a8.1686574374.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
        <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jun 2023 12:52:34 +0000
Subject: [PATCH v2 06/25] completion: complete --default-prefix
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


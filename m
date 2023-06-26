Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E3BEB64DC
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 16:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjFZQZy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbjFZQZB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 12:25:01 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE06126
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:24:54 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f9bece8e19so55569175e9.1
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687796692; x=1690388692;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGhLXXBoQ6UI1vHMOyV7YwVlIGSV+5Rfv8inY3ASxdE=;
        b=mUTm/hIrWlGHWeY8VhWZiYFLn+Qkuxq8qpUPKQ7awlI4u/80fitC9gKHHtPhkY+ejQ
         7KZcV6rz2mXKIjhvUltNy8yucHoYXxJsY3LAsHSNmA552J/dg6mtKi76q3sW8CzQokqj
         6DKC9ZjMb9Vv/nE8UcJr00XSISzGFeDW+yGVsF+h7C7SdcjcLSO7yEWTvXRM/0/mo/xP
         Qnbq7izeQBt+PkZbw6X3Y15O8XT2NEXWE86tT6xmYeYVEqcth2DnJgdp/dpQxNs2x4wl
         AlDYP3UWx3qo+eyCROW5UhZ6uTaacT07QHY5RKvnLVZ9wIOTbuuHLSWwqn42vN/0/1Ga
         utgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796692; x=1690388692;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGhLXXBoQ6UI1vHMOyV7YwVlIGSV+5Rfv8inY3ASxdE=;
        b=HQVtqNrX4S9pBf8JjLyc5Zm06p5EWREwXrgu0KOrKCinMr3yXTUtIb48l5GPzzN7pN
         uLXN6NHR2IBZiaacGiXuKmMyM2lcJyHkp558NlVUI/je4v3DsdEaJ0UTSHxW9WRqert6
         5QwARIS97hFUAq1kGULq9lXmcSSndLya7q72RobqqcQkeHPg3eVDGLQrCO3G80xtvMSY
         W4FJMk3O/HxmNqDD5ThSohFPbWCfwR3eosHWosmvbKBdwtMQ7Vcy0L2RHHj1C1f9UeYD
         018dDts6yCVeTIG6jx8rscY4C0dHUZumUHVr8XZB/R10DK6wfM4UyP6UwyiEkEykOFTr
         A+gg==
X-Gm-Message-State: AC+VfDwJvLamEJouTwG+g/tBzIf6GRkYnndKy621k+C23fObdjYdld/L
        t0FT27YlbWZ0Ed2QMMYn42qWX4dKEI4=
X-Google-Smtp-Source: ACHHUZ5KkPB3+bqkmLniuXVV82oy8bH/puKSMjaU2U0ZxKhwsO57GhzrnKVJ75xVzKvr9rBJzEFZ+w==
X-Received: by 2002:a05:600c:2206:b0:3f9:515:ccfb with SMTP id z6-20020a05600c220600b003f90515ccfbmr31166378wml.12.1687796692249;
        Mon, 26 Jun 2023 09:24:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c6-20020a05600c0ac600b003f9c0a7c6bcsm8257544wmr.0.2023.06.26.09.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:24:52 -0700 (PDT)
Message-Id: <1f3c9e8d417d2c9f16583da7609e8f322059f1f1.1687796689.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
References: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
        <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 16:24:26 +0000
Subject: [PATCH v3 02/24] completion: complete --break-rewrites
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
index 90fe292459b..f07b00b9c68 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1753,7 +1753,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--diff-algorithm=
 			--submodule --submodule= --ignore-submodules
 			--indent-heuristic --no-indent-heuristic
-			--textconv --no-textconv
+			--textconv --no-textconv --break-rewrites
 			--patch --no-patch
 			--anchored=
 "
-- 
gitgitgadget


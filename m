Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B463EB64DC
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 16:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjFZQ0C (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjFZQZD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 12:25:03 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07230E7B
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:24:57 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-312824aa384so3022407f8f.1
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687796696; x=1690388696;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EuEC7ZPeXKOGDsEdiD9s2S26+adBCwfD9y21ZQNkMw=;
        b=SC0a1FzBqpcKfxiieZlHHh6gFJ6L3txrmOTuq6bVW9J/FY2LRIRZrujh1acsENTGgk
         v6XHodrRyy4cFec12HH7pUC1S2ttjEvwW0PJEPTez5kkjoLQXfgVmOx9D0fFzLWAAsds
         RAzcXMf2U3j6uwAh6+yItqAqJQUYpS1h2LtoZ8lwTTK4XYC+ZFoKtCfCbVNAIoMzesJz
         U5JPm/YqxPG0eWBnu/oNXbR1aoKvaMfSHKl+N/0K9cBI4Dls2WvnJeyY72xNYxhHDiG7
         BwW2vYN69HpWIZMQXIsyYQTGKogxDt02iXSD2kn0OydOX5E5sgxTFOoc/Xvlp3nmfAxf
         7rTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796696; x=1690388696;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8EuEC7ZPeXKOGDsEdiD9s2S26+adBCwfD9y21ZQNkMw=;
        b=VJdLGTS5xPUcEGnKySl4gYpH61ljgW0vvqRplo8HzXUysskNu8iFXLiQ1mi9NQJX85
         mwqcYUWBMuV1/PW/PGQM7n0o7/APV8caK5kiq8/zCjIkIMvavKjq54odJvHs8nn+qA/7
         BSs9fRo6sCjlU0hWAkMQxyxnhGsCLyI4uHXh9+8rF9wdaGz4Lu9nNetrpOWCS4So3LBh
         /mqKoyxPdUacNUrYS4PVrhm+7Z8XPialdx73IUZIEa/XgfuJbC7P26g5+MTX59TsLfNJ
         qPocQ69Jcf5RjNxarCj1Zh9SlRnXsxuir5IYuSeWv+vc1eMusjAiT2X7CO/un9ZFryEL
         VEeg==
X-Gm-Message-State: AC+VfDxQehGBg7WO4poC6M2vyoYP0efFtug++wyBKCoA1glctSlX6QgY
        ri4vGfFefK8F6X3L2nTdpWwNVf38WNA=
X-Google-Smtp-Source: ACHHUZ5t7CXaMxo44A+XlOYFaneOGAkDe5p06xJIHSlpYgbD3kAv8x5wlwjr3nHUJ8OcOVJlZyV0wA==
X-Received: by 2002:adf:e408:0:b0:313:ec90:ac25 with SMTP id g8-20020adfe408000000b00313ec90ac25mr3346006wrm.11.1687796695916;
        Mon, 26 Jun 2023 09:24:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600004cf00b0030e52d4c1bcsm7900424wri.71.2023.06.26.09.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:24:55 -0700 (PDT)
Message-Id: <7296a3a8c9da5287cca85c61af342dfc647fb2a8.1687796689.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
References: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
        <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 16:24:30 +0000
Subject: [PATCH v3 06/24] completion: complete --default-prefix
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


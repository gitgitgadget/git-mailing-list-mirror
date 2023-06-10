Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FE5C7EE2E
	for <git@archiver.kernel.org>; Sat, 10 Jun 2023 20:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjFJUVz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jun 2023 16:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbjFJUVk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2023 16:21:40 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294E635B6
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:34 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-30af86a966eso1965173f8f.2
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686428492; x=1689020492;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2WpL2LnEIDybO0wRqkmHT0eENwkULnxZnfbhvEDvYk=;
        b=H/atAWVx1+oVt7VsXtQvFTVy5L+UKCegjrf3+ccGWsUp/6Lj1zra8InUfL5RTDrFgH
         35oGWD6x1PdX63zBXrTJRIsmxNltooUfxLp+xos9Rfc1EzELJfXOeKyhXuVbkKc3r7kG
         nE/5XfEPzGPZpue4VKVhLmpN10v0kivbXW6XPwznkVkbkZx9Z0Di+I9BntWBv4Nd7BJC
         KB1pTTRBzaOygYV9k4HyH2rrp0i/1u7/ewBMuqBmXXISLalBbylNN7T+L2hCgZC6soj5
         7dfwxGmagtCtvuJTpYqM9ygnCRiQfa1Siv5PCO9PBCx+r4zAh7X2tKu0L86RJZDQeGfg
         n7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686428492; x=1689020492;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+2WpL2LnEIDybO0wRqkmHT0eENwkULnxZnfbhvEDvYk=;
        b=ICJaHpfgP2DWOqKODdibWEr0uVJiTSWOfepnMLZu3WaMHe+9CfRsHL82geWy3EPxbT
         0T2dfc5tOomPmwDAdOuGM+BCsD29n1PxkurSJJhRdfCB81shWZrePGMoXnh/nQGsCuaT
         uAaAECzOUPoAQ0LFmvT4KDkyRPXU2FXK7U7xFJ+/sWXODeDTSNX8RUk2o4rN8/qst7Yo
         wy11DZSTeArnZmTbg9J85LFrBBEZWV/uJjVm+lD0SXPoyHo0VEvHxZpWZ7JuM8f0ne8Y
         INL7Pqud/7bAlF3zQ8GkZtAHfZgI4jAFqc18gZHBJ7OMOVJF9nasbH8gTpiNQFn/gnea
         Nsdw==
X-Gm-Message-State: AC+VfDzbgxbDtz7Z8yF+ObPVGi5oQd8j0utFT2p/gIcUPTViPymW7CmP
        rMZkuHsLFQxBWd6W9R47AZt1x/w8nwI=
X-Google-Smtp-Source: ACHHUZ7nbA5y/xHUdLLPkMschNZ0iQWfpZKk0GrJsumH+kHaSxxTxZ64N5ByJ5Tq9O9vaK4bRojIMA==
X-Received: by 2002:a5d:43c6:0:b0:30e:4515:1529 with SMTP id v6-20020a5d43c6000000b0030e45151529mr1199942wrr.37.1686428492346;
        Sat, 10 Jun 2023 13:21:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x19-20020a1c7c13000000b003f7aad8c160sm6544101wmc.11.2023.06.10.13.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 13:21:31 -0700 (PDT)
Message-Id: <053f9e8620aa369f04eff8f1235eb57d15fe8755.1686428485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 10 Jun 2023 20:21:08 +0000
Subject: [PATCH 09/25] completion: complete --find-renames
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
index 392fdbedd9f..0fa86dcde6f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1740,7 +1740,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--color-moved --color-moved= --no-color-moved
 			--color-moved-ws= --no-color-moved-ws
 			--full-index --binary --abbrev --diff-filter=
-			--find-copies --find-object
+			--find-copies --find-object --find-renames
 			--find-copies-harder --ignore-cr-at-eol
 			--text --ignore-space-at-eol --ignore-space-change
 			--ignore-all-space --ignore-blank-lines --exit-code
-- 
gitgitgadget


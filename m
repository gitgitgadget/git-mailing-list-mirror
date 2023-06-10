Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C42DC7EE2E
	for <git@archiver.kernel.org>; Sat, 10 Jun 2023 20:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjFJUVx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jun 2023 16:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbjFJUVj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2023 16:21:39 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773283C1F
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:33 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f6e4554453so21566275e9.3
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686428491; x=1689020491;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztzLL4KgmrtUPgRMDMXzL1umxszvJ1+RIMd9x/Qs+L8=;
        b=i1nTHzU6qo+mhtbvsMinnWW4M1L3qujEs4+Ldaqv9DxA1NpDGlrdPCeWjqoQZmz4b/
         JNtpB2Sfk6tViPEfHt5TP5lQOjbMzH+m2kparCtMuwQqQk48l4yoW0AGaYUiHNwaguWu
         S2tGQR6Zt8B1bnqq4uEuIBrm24Cq1cdbc/su+3KY+CIf4EISSzwHUm4fkbd7BxY2J3EH
         U/qgEDgLq0mfjbO0iWfZVLn6vbR9kCeqh0Dng+DoHHJZoYcoceivNO6fQ3jN30PAXp1v
         IUuGdHer/fCWv6w+eeuOWVY/LdZLAkwt5JmhEcPv9T/gEscnNYqW/gQMXes7ZyYBkokl
         SEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686428491; x=1689020491;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztzLL4KgmrtUPgRMDMXzL1umxszvJ1+RIMd9x/Qs+L8=;
        b=H6OOoMO5dud0F7nCLxpv65BZxpINCvMjjv6FXDIk281XS6HQwT5NOYRLl7dR076mg7
         3RaC2hrYwM0Rg0oK2RkhCPoXHtO6CnUJ23llGzbEpTgRA+Jv/2pbm40m5LMbA7Hsc9po
         lJct/UdMyIQgbjumfiy9+AACBIMXvk0BM3Fzsn/Wv9pBdt/ENhZK8lAQf5dlBDObuD2O
         hDbVT8J9h9p1WAdzw38uXD7/RAJC+41i19t28NxUtF0Kr4rGyzlKnWYvIl17ihz8ZI7W
         uR1nSurT2iY5d31SMWHd1Q/MRxT8mcvbJTJMGaz8icQfHGFEv6U91kCiJKKWCLWV8LlK
         S50A==
X-Gm-Message-State: AC+VfDyM5L0ptTw9scUDXnru9rr4jgy5XkUQWCo1HQq3/GORih5rk/UL
        vgglGd6ML1F6deHSqQE3+c9I0jPvP0g=
X-Google-Smtp-Source: ACHHUZ4ELcwwkVWVd1PFyCj9gEeLiyyu0YJb+zmZGkULQZ8bU59igEQ5lN9sJylxzdSwcpXsZbAaRw==
X-Received: by 2002:a05:600c:b44:b0:3f7:e463:9ab8 with SMTP id k4-20020a05600c0b4400b003f7e4639ab8mr3201252wmr.17.1686428491622;
        Sat, 10 Jun 2023 13:21:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u8-20020adfeb48000000b003062b2c5255sm7903950wrn.40.2023.06.10.13.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 13:21:31 -0700 (PDT)
Message-Id: <53b1c348f822ca32228cdb0f40b03c9ae9ec59c8.1686428485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 10 Jun 2023 20:21:07 +0000
Subject: [PATCH 08/25] completion: complete --find-object
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
index dd6e12ad8f6..392fdbedd9f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1740,7 +1740,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--color-moved --color-moved= --no-color-moved
 			--color-moved-ws= --no-color-moved-ws
 			--full-index --binary --abbrev --diff-filter=
-			--find-copies
+			--find-copies --find-object
 			--find-copies-harder --ignore-cr-at-eol
 			--text --ignore-space-at-eol --ignore-space-change
 			--ignore-all-space --ignore-blank-lines --exit-code
-- 
gitgitgadget


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63988C7EE45
	for <git@archiver.kernel.org>; Sat, 10 Jun 2023 20:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbjFJUVo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jun 2023 16:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjFJUVh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2023 16:21:37 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97543ABD
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:31 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f7f6341bf9so29443245e9.1
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686428489; x=1689020489;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mkt0tgPGKfg5NkOEOLf6K3kF+oWQxLyWGbxdvLD95AQ=;
        b=CJQQ8lKkQZMM/bjNNR3HY42G1dCfOtSK0tDY9bvuERetom/PtH6tHvElGtNwCk3FXf
         zfWPzS00PlO9qB8fAdEHX3XbRQM5aEg2KqVKYqhq8JQ6Ro+hz08iPwEwSPHyAc9bj4pI
         vRPz+spN76eHm3v5K6m+l7jUZ3hRy9FcNW1p4svXX/dR45uG6lVZaneX1CAShiwSMnyk
         BYMIFLUSjFF7Kpwk+LBj+qrRaNhnmuCsimeGZIg/rZX8sJGcfB5oNFSTLPsbpBHO/pUz
         vFB7JsddQyQQCVKeAz5vJ+wpcKsQZvKndtbpzNzANOSpItKpUrDFK1LBbGoOgwOG3JTh
         62Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686428489; x=1689020489;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mkt0tgPGKfg5NkOEOLf6K3kF+oWQxLyWGbxdvLD95AQ=;
        b=LucsTmu2sIEPDLCNbD+4jzIyMwFexKXlnhil5xfqBm6prfhysxHjzLYbYx+pJlUVLh
         hZObeQzBbgBG547TcXffznIgwo7z/wzmGzFgvsxmaAeAm/UAhneT4VeoLYUmMKCpeIYO
         KBBSylOY/ko4gr/qfmG/KthjstlVXeY/5XDLnbMGeQsLkSNeWOJD4M2uSuBjOFb+S3In
         hlwO0j62d99FInWdoOXZ10dOjrNHe5uX6nD4dSnkAxzU6I5w3kkpttTFa01wOHgp6Ad+
         WqsAGq9xC4eVT3mdyJvopGmOrXbdMzt/ZbFdVw2c1nSvZAKTRD4JP1RZbR+dk9aT8oz/
         /eUg==
X-Gm-Message-State: AC+VfDwQF45mDlh5tKSQsrFvMagDjcbimROEH8jD4wuex92Pfuut1KsL
        J5oxaoObZC7XxtteQw5QHhCFezYsUYA=
X-Google-Smtp-Source: ACHHUZ7w4AXIuQ2HWcB63AghwR1oV+I5G3YDIiGAHSCrVl+GicOQ64A2HKvjGJ74wUqdygIXYeBOTQ==
X-Received: by 2002:a05:600c:295:b0:3f6:af2:8471 with SMTP id 21-20020a05600c029500b003f60af28471mr4008199wmk.26.1686428489360;
        Sat, 10 Jun 2023 13:21:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m9-20020a056000008900b0030ae499da59sm7841714wrx.111.2023.06.10.13.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 13:21:29 -0700 (PDT)
Message-Id: <63d70d645e25a2e7f9d3dfac7f6b01c3bd27fd7e.1686428485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 10 Jun 2023 20:21:04 +0000
Subject: [PATCH 05/25] completion: complete --compact-summary
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


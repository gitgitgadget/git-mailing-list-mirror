Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EAAC7EE2E
	for <git@archiver.kernel.org>; Sat, 10 Jun 2023 20:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbjFJUWR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jun 2023 16:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbjFJUVq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2023 16:21:46 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58A93A8D
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:41 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f7f543fe2fso29387565e9.2
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686428500; x=1689020500;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDvxqnfpWYnoIzV5Z9Y90KCQwDVlVuLP1sO5xxzYWXU=;
        b=WMY6ho7sNkJgZO/L83pWm6K+uNOWuHjAgkHmlvnmJR1gmSng1Od7bIuy+4ljtVsqbD
         mW+Nsq68kRs7oiYpXp1wdMn9GM19LDVkoV6z5lyMBhSHsur4TRJRCnzbyczlAVfbf7kT
         4skT5VX7Xhs6D12lwJU8w2CZDRREZfIqV0zoD+DZYK/qQjkh+ZdoBCRiNZiZsj+a4EN1
         QKHCMSoY8Zbp6pwGzG+PefeSHYtmprYb9ApIJIHFz+c6G/Whgq+3zeRmiszjjksgG5n1
         W+S/reRNL3IZbgw3RYAkESWvAHAtdMV7OYU4P6qZB1Gl9FYOqOj+9n9lcq3ueJOU9d0Q
         3QSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686428500; x=1689020500;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TDvxqnfpWYnoIzV5Z9Y90KCQwDVlVuLP1sO5xxzYWXU=;
        b=CgMeu3y5SWPXueEDPPCpw8U5Cpv2WrmSSfkx2L69GSmDPU/sEbw3vHfcfe7xqb9dT0
         9fE3v6BoV0tQW7SlxkPu6LX/hTu38t3BhQhcNJ2KcZm1KGYnAjo8LHsOx1sKXmeXObrg
         11SgCFaYZfAvfc50IM7QwlroLgKf0o9mheqdYuipLPGSZ9Tnw3bc+rrnvIkZPG+GQpnf
         KZkjJTLFN2dzYF+8U5qxnrtbLmySCQgf701y/lrVFULcR3YjxC9ANMQwWYioVV592MxY
         k4YqtPSIA46Z7KszzRT6gZo7V33BdurBQWjQAnQNbLQHORuKsx5sb5yL62+wx3d6W7Zx
         sqdg==
X-Gm-Message-State: AC+VfDw6I+uTeVAW/U02V4WZc0/cy0E8domEsez+wdjHaSNwzkN8aw5K
        q2hy4q1RwU9jzFU5CLNPNsvVpkPoWdM=
X-Google-Smtp-Source: ACHHUZ6tOjq2Hk0QNqKhSsZJ6T+55spl4IEXpEnbXpWMlUHIOSbDNRYD9Ws8Hx/ZUsYNQUtGyT37KA==
X-Received: by 2002:a7b:c84c:0:b0:3f6:76e:604b with SMTP id c12-20020a7bc84c000000b003f6076e604bmr4063879wml.0.1686428500111;
        Sat, 10 Jun 2023 13:21:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l7-20020a7bc447000000b003f7f36896f9sm6487017wmi.42.2023.06.10.13.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 13:21:39 -0700 (PDT)
Message-Id: <19507b1a2109f419ba5c628c32db46f96903e166.1686428485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 10 Jun 2023 20:21:19 +0000
Subject: [PATCH 20/25] completion: complete --unified
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
index c0d2678d320..230d5807860 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1745,7 +1745,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--find-copies-harder --ignore-cr-at-eol
 			--text --ignore-space-at-eol --ignore-space-change
 			--ignore-all-space --ignore-blank-lines --exit-code
-			--quiet --ext-diff --no-ext-diff
+			--quiet --ext-diff --no-ext-diff --unified=
 			--no-prefix --src-prefix= --dst-prefix=
 			--inter-hunk-context= --function-context
 			--patience --histogram --minimal
-- 
gitgitgadget


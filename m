Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0297EC4743E
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 18:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D80D1613EF
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 18:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhFFSun (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Jun 2021 14:50:43 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:42886 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhFFSul (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jun 2021 14:50:41 -0400
Received: by mail-oi1-f172.google.com with SMTP id v142so15348032oie.9
        for <git@vger.kernel.org>; Sun, 06 Jun 2021 11:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2bZWC4LFFLD2JTwh6FRtgEsmYrPY1OFvOXxslG+PJqg=;
        b=JK/wpH0ElwcwnXmuZnvCMqTi1NR4BdE8e8x4SNjpP20x0FtdgkiBRsY3rPyRTsoDMr
         tc5VpNLupPA/Dxx0n+3JqJyfw34DNiwUCwsdMZRZgCtLFK/pxXz9OKz7mobpxLkus3gG
         Fd86SXLmdr2ru2TWTbZl1/kym4LELcchVqwtj3vuWcFvebV2ybwOLJZG+JIrJeettKWM
         BhfhjTKNS0F6A1zoLU7a23tr1wzfJYKEQkXW5MNIVsA1hcy/DYmtmemajXuR8pJHVFfF
         7/7Spd0gK4XDJqEMhYQEzGj3EJw6R4vE7wB4mtNdAiT4PYCDU6dV22HUUJMdUROJnPWT
         srUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2bZWC4LFFLD2JTwh6FRtgEsmYrPY1OFvOXxslG+PJqg=;
        b=suJcoosBFNRpHHh2aOzLDV6SfpM99BfJkfvuzxvrKzLpnH0VtRHbowDD1MGUKP6eXd
         O8xSyuXHLsAshWkomakWw8s8ASMwwZlpJooJ1Sdj8KNGIieancWAO65zZ9jZWSh+q7OX
         3X10dakEDsl5XA/JcE1WTazfl7cMrMVwx650Tu4nhfj/UaopoYtX5mLokBFVK+RUyzYo
         V7/qaaV+FWjidSmYsWWGASxyVcdMRwC74dxvt6tKuSBp8JnRyB3say1GOkB46os1twYT
         dRY7rEuSNpBP66N7Nd6GtE2TEKJGNzMdyTaOKvM7LTD6TEctK2GUjK6oDBszuzGetP3j
         uing==
X-Gm-Message-State: AOAM532ek+Tptj5DcPLkfxRNFoWi5+D4k23ZrEOESUljFLWjPZ0Zkl/z
        ZNxQSxoVaPgTALHm03bp6Xr73q2X2OqhdA==
X-Google-Smtp-Source: ABdhPJwkp3XuarBVcVrXTVHxoiFQq8LITnmzf6AXBfVcJ25wdHLqd9Qb7WxgQraGmGYhP3qta0TXQA==
X-Received: by 2002:aca:650d:: with SMTP id m13mr1002497oim.157.1623005263696;
        Sun, 06 Jun 2021 11:47:43 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id w69sm1795819oia.22.2021.06.06.11.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 11:47:43 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 try2 3/4] completion: bash: fix for multiple dash commands
Date:   Sun,  6 Jun 2021 13:47:25 -0500
Message-Id: <20210606184726.1018460-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1.2.g0532ba4bf6
In-Reply-To: <20210606184726.1018460-1-felipe.contreras@gmail.com>
References: <20210606184726.1018460-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Otherwise commands like 'for-each-ref' are not completed.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 05606609f9..1feb2ee108 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -421,7 +421,7 @@ __gitcomp_builtin ()
 	local incl="${2-}"
 	local excl="${3-}"
 
-	local var=__gitcomp_builtin_"${cmd/-/_}"
+	local var=__gitcomp_builtin_"${cmd//-/_}"
 	local options
 	eval "options=\${$var-}"
 
-- 
2.31.1.2.g0532ba4bf6


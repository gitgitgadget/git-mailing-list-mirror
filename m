Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5D8C4332D
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 00:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4567E64F72
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 00:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbhCPA4t (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 20:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbhCPA4f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 20:56:35 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9705C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 17:56:35 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id t37so10697857pga.11
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 17:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3jFVKojXH4M1DsYGhOnDKWYDJNMqWGYlCNj1eQFij2o=;
        b=OobahH756zeenG0g1TrlG2IAHbu/m0Xw3I60mpooZwNvwHJgjDenR9fMLK0mtjesdJ
         9zDsGglekC1NDJoEDVeaHG3vvUNiUakBZBJ/NnFdipIBswx7tdt07yZBukyNbE4/SY2i
         BJV6ZLnoN+ZhAk4ho6/vDFW11zeZK95EVjGGvFHqtPzxsFDrAtX+Q6ZtCGGY0DlIv8Ip
         UdM434BbF72GyRxXOWNYmNXh/u6XbwVfxwzgWji0yeB2gm7Re5uZyfYR1WjPto7rSVab
         /7Vla9jf66BsaGaTZKHkPxOQnM2FM9udNWCfYU49MJCYbvhd/+s7K+5jvqlvZpETTYcK
         HvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3jFVKojXH4M1DsYGhOnDKWYDJNMqWGYlCNj1eQFij2o=;
        b=NRrdZbDMCRHycm6Pl8uXHeAeJ3tUEcefhr9PzF7glN7YHKGiJmweIfspWLrfkqLhFu
         SrVCI9T9d5htZ3AloNsikmN7SbCRnrPGj91X1QuasQ6ghwc+cr8d05wDACfUo7T2TZ3y
         fHe+kx47NkwJL1BWs1rA6vObRtqlQ9YaCJlP2eez1KZz9vJgKQ6BpfJLnj5je0jTSSTP
         VjzyJJINu8IhAp/KXk2px893SUSkegW623FuE/C8o/xCGnX2vxiDTdjirhu+jZp6EE16
         9Oxgaznd2jCgr2mIU47+nbtn21KZweN1yJktbGIZYkp4cxIxOZPbN6kPfqNyEhG9mHbv
         SQjg==
X-Gm-Message-State: AOAM532tcPJxjIpoo9gveTo+s5RJM77MvPMY8cm1oD+o58Wm2gdpy0hN
        tooi6Egu9RNCArAJWhRIiOr/Cs75+v4=
X-Google-Smtp-Source: ABdhPJywYsX3oufDt9/YlaE0CMJA8ypaI0TzH8wrpcx3W9WPrbgfoyj7f+2MGXdCQQ2siTTHPEUxkg==
X-Received: by 2002:a63:d58:: with SMTP id 24mr1497534pgn.171.1615856195075;
        Mon, 15 Mar 2021 17:56:35 -0700 (PDT)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id h186sm14670312pgc.38.2021.03.15.17.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 17:56:34 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/7] ci/run-static-analysis.sh: make check-builtins
Date:   Mon, 15 Mar 2021 17:56:25 -0700
Message-Id: <8696305c1efcea42a2227f8efaa7e1e73c71d32c.1615856156.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620
In-Reply-To: <cover.1615856156.git.liu.denton@gmail.com>
References: <cover.1615856156.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To ensure that any newly introduced builtins are in git.c command list
and that no duplicate script files exist, run the 'check-builtins'
target as part of static-analysis.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 ci/run-static-analysis.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/run-static-analysis.sh b/ci/run-static-analysis.sh
index 65bcebda41..1ae122fc70 100755
--- a/ci/run-static-analysis.sh
+++ b/ci/run-static-analysis.sh
@@ -26,7 +26,7 @@ then
 	exit 1
 fi
 
-make hdr-check ||
+make hdr-check check-builtins ||
 exit 1
 
 save_good_tree
-- 
2.31.0.rc2.261.g7f71774620


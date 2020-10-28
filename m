Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62598C4363A
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 00:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9608207E8
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 00:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2F2JGKC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390721AbgJ2ARn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 20:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389649AbgJ2AQz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 20:16:55 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9DAC0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 17:16:55 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id u127so1483977oib.6
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 17:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lrts7Ycg5LZkyIZ+7Ws7x99eIq3Wf2zXjxlrT6SjHAo=;
        b=g2F2JGKCNmY/+4UqtSUY8uDhELoNUV82FewyetaJkGT5tiu4a7g7UDkb7qd42WATlx
         5gXczQmefWrkKp1OqpRt+6iEfzi3roB6OaZYGyPxF9qbDplFG+KUh4wHL8d9ggGSOrgj
         gevcGwAPaWuj2fsSYKv1W8Jqm/pVbkyNYN/TmfP6CIA391ZosrfjTCSk4SGDA6teCj2V
         KdrmiXRsqSf0BfsgBI9Tp/D7PEhpol9hWcpVz/cCIaqTSwXT81+fq5MU1rE0PJgrUKP7
         jKx1+vt2gFZAI+Nf+vmMPvD7jdxF1JJCHuUm/Ue+m1rX1KjdO5x08UlFbJWtrU1kPR7K
         31iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lrts7Ycg5LZkyIZ+7Ws7x99eIq3Wf2zXjxlrT6SjHAo=;
        b=TDmHD679S+v1OY3b6ieZWgW/iqgoVOZJEZzq2pGmU8RwTaVT5rE5aPJNSTjg7e94to
         plfcxTubYuqDHGwKkQrmWw5GoxJWL01WN1EqEjO58b4dxQ3XNW2zGbkHDdQ89n6PTM+T
         jjrrN7I7LU1SUnRWVGFRKNdG8bx56EyqhZXHsF62qW53f4lP3ufCs8aKj7A+HV3yVob1
         FOyi+OScNwSmqTzaQE404SelwZ7CUDO6YzihKcH4m/uU8cY12D+hSyUZZNzGECZ4os8O
         6BVcARv70br+P8G+PwWm6ysFz7ziSsjtW2pLimfYU7/qjzsb9a1us5IhbqC22jFQ/Rlg
         zugg==
X-Gm-Message-State: AOAM532bvPfeHVdFM0hvRNZbtpuvWP+Wg8wltd0saZdc5Zu0h5RnKyKg
        8G8QIYWjiBIBA+vdJOdfQHNEMbv4U+HUoeY3
X-Google-Smtp-Source: ABdhPJxuzQgLrgy+1VK+5BHBtAQXrHINaBdlcQm2pfg7uAo2At/LTi//mOTBoEfHSZ5EzCxLVXE4nA==
X-Received: by 2002:aca:5608:: with SMTP id k8mr3463000oib.118.1603850864155;
        Tue, 27 Oct 2020 19:07:44 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id b7sm2150504oic.36.2020.10.27.19.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 19:07:43 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 18/29] completion: zsh: simplify nl_append
Date:   Tue, 27 Oct 2020 20:07:01 -0600
Message-Id: <20201028020712.442623-19-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201028020712.442623-1-felipe.contreras@gmail.com>
References: <20201028020712.442623-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's exactly the same as __gitcomp_nl(), no need to duplicate code.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 234e4278a2..7126c75001 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -119,10 +119,7 @@ __gitcomp_nl ()
 
 __gitcomp_nl_append ()
 {
-	emulate -L zsh
-
-	compset -P '*[=:]'
-	compadd -Q -S "${4- }" -p "${2-}" -- ${(f)1} && _ret=0
+	__gitcomp_nl "$@"
 }
 
 __gitcomp_file_direct ()
-- 
2.29.1


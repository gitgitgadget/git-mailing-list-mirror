Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCD8C4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 20:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1E506108E
	for <git@archiver.kernel.org>; Fri, 28 May 2021 20:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhE1UMJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 16:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhE1UMD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 16:12:03 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C381FC061760
        for <git@vger.kernel.org>; Fri, 28 May 2021 13:10:26 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id s20-20020a4ae9940000b02902072d5df239so1214841ood.2
        for <git@vger.kernel.org>; Fri, 28 May 2021 13:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oVunPFTMfKkZWGEj5e5Bc6uT5hg2dJmu1Igf5ckFvH8=;
        b=pJoPJI9OkipiqhxAtCuHC2yGETXR/970w4P+ibnsqgLO18+M6gFUrpITokLfaNkTon
         +nkrHExFGXHzhKFx+j60PmOoopie6gOborlnap58Kp1r8OpzkP8M1CvIAEtAyviu6iPS
         eg8vZlitJQ9huH6tqtkWJAVka3Jb/ooe7l9xQ2XtXCkA2xd3l7dAER1Wqr2sTvcICfWR
         tW227ph4ShdO3Jir1gj3sLR1F8v0PoTiFqB1hmpGc0/VKJipv5FwU+z9w3Gtq/x5TvXz
         KYFssh4M59TwnR0lijgzJX9FoStLSe+jszWki1e/KtUUhLSGi1Bp3R6NFxQlym+XEStM
         f0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oVunPFTMfKkZWGEj5e5Bc6uT5hg2dJmu1Igf5ckFvH8=;
        b=MRDAcAZ4qxGsV/gFiSKmm8fupXgYOCCtxXqDv043GJQHFIbyULhJhVudfQM49flNxd
         GH/xjS6sFml/SPG2bsDXCvP3xVTiMa0JH1tj3cU/Q9+HsGz/ory0M3Cukqw1ClIRTGvf
         BFpODMyYcJYIdiYu/7pJI+ffMSo1waMJJxEcn8u4kDB1aUkSNi+qfolEHeKugUm16ew+
         FEI+R3iwULo5rGCvyx+Ud5BV8jFM7O8BmszvGl/Gfb3HOSTFaVMubd2qJoz2WGoFjypz
         wXgqlPmovRBwbbkuFPRP+h9lfjgOJlZxSdo0eV4T+rwVcpgoU6aCZctlUwbpSTrbRF5I
         FMUg==
X-Gm-Message-State: AOAM530+ivME0K0AYuncC12b1yUVmrKggE+CkQ0LNcXQQ9Gh3098iKyL
        ejXzDt9jcGgVLyOZL+r+NZh7o5+HjkJHdw==
X-Google-Smtp-Source: ABdhPJyyY1wBgyHOkOhtwoGbIEqyu0/R3HhD+Xo8WBYMUgSP5I0xP6WoQCFC7dC2gH18YPvaPFWIjA==
X-Received: by 2002:a4a:85ca:: with SMTP id u10mr8292830ooh.80.1622232625936;
        Fri, 28 May 2021 13:10:25 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id l19sm1368844otk.65.2021.05.28.13.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 13:10:25 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Mathias Kunter <mathiaskunter@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 06/11] push: merge current and simple
Date:   Fri, 28 May 2021 15:10:09 -0500
Message-Id: <20210528201014.2175179-7-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210528201014.2175179-1-felipe.contreras@gmail.com>
References: <20210528201014.2175179-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`current` is basically the same as `simple` except always assuming we
are in a triangular workflow.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 0961826269..2d6358f776 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -210,13 +210,6 @@ static void setup_push_upstream(struct remote *remote, struct branch *branch,
 	refspec_appendf(&rs, "%s:%s", branch->refname, branch->merge[0]->src);
 }
 
-static void setup_push_current(struct remote *remote, struct branch *branch)
-{
-	if (!branch)
-		die(_(message_detached_head_die), remote->name);
-	refspec_appendf(&rs, "%s:%s", branch->refname, branch->refname);
-}
-
 static void setup_push_simple(struct remote *remote, struct branch *branch, int triangular)
 {
 	if (!branch)
@@ -269,7 +262,7 @@ static void setup_default_push_refspecs(struct remote *remote)
 		break;
 
 	case PUSH_DEFAULT_CURRENT:
-		setup_push_current(remote, branch);
+		setup_push_simple(remote, branch, 1);
 		break;
 
 	case PUSH_DEFAULT_NOTHING:
-- 
2.32.0.rc0


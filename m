Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746B6C433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 17:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 182F4222B9
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 17:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNOpgYvA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732101AbgJOR62 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 13:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732090AbgJOR61 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 13:58:27 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910A5C061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 10:58:27 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id e7so2462155pfn.12
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 10:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mmNXwb8J6XiQFPGN+D3gkqMmM6uCD5goLuOEdfR3pT4=;
        b=nNOpgYvA1hcK99qhGXrt1wMHkclIkhQ8LhMZP8qRf+QWo43bTIM3RWZfMFjphq6VeZ
         ykq9i5g+gOb8SqBgS79VCCVgTPXr4HRc75ltaoqjhpyo/0I0LZEMNGZbI9IgjjAojXsf
         3TAGNrF3CDT1tuQq63t84MnCdohsoeNokladeVhxlFi+xZqfxMxQNTMDFyIIDKN5xv4y
         c7JwqjkNoRjBopTdJ/ykFFYai7/2Y/og5vlu0PvtJgPTkuxC8Cw+FiUHV7Sfun/TzPmW
         tBFqbwuCA0RDLbA5P3cMtE+cyfBx/a0+61YJG9+vLI2v5Kz2yyHE9fuNYOcBDh14qKrq
         OYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mmNXwb8J6XiQFPGN+D3gkqMmM6uCD5goLuOEdfR3pT4=;
        b=nV5O3DnjcFRIKoFgpwKyX8g4GNFNeJIjd7ow6spaCWINjf3AGzTn51wQe6WHFTtRS5
         Fq4vNG0PiwlBgRfCgt3PRDOTP3+WZ0PeVqhkBRaH9yGWkqFgVkYhOmf95ExeBRjTwPAu
         0bMCwudqywsixDTI75UEsZX+pG3UiWltxqr7lxhI3Sukfm0rimmPe+InFeukV7ZugF8/
         ipqDl8SEF16fAFBSWrdnnuHr64LwBPJOpBl0DzB8thHcND+mXFXVgUEr3grBYpz4CpEP
         dnim57DzOb5QH2S95f4BlyL8GeslK5l1cZXs/dPhWYG36VWuFQLnUcEjxP0COMq4yJ/A
         R8cg==
X-Gm-Message-State: AOAM531L1rSRJW90VmCsvxE0h0UGk3Tc5Cgy5JFOAmjvbmq8sViL+SLG
        VdSk6jhXSEKwMuaS1GvrTjAB7G0JocTvys3X
X-Google-Smtp-Source: ABdhPJyEWL4CahRW37wcLQnraUqzBVhcIaj6y4Gpg8p7vxr2g3Cwz56lOUik9ZLP0JkkGLLQmSHQUw==
X-Received: by 2002:aa7:864a:0:b029:158:e6ba:5548 with SMTP id a10-20020aa7864a0000b0290158e6ba5548mr2383782pfo.1.1602784706983;
        Thu, 15 Oct 2020 10:58:26 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:1309:c8:79e1:6677:5d35:9a95])
        by smtp.gmail.com with ESMTPSA id n139sm3945930pfd.167.2020.10.15.10.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 10:58:26 -0700 (PDT)
From:   charvi-077 <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, phillip.wood123@gmail.com,
        sunshine@sunshineco.com, charvi-077 <charvi077@gmail.com>
Subject: [PATCH 4/5][Outreachy] t7201: avoid using cd outside of subshells
Date:   Thu, 15 Oct 2020 23:27:08 +0530
Message-Id: <20201015175709.20121-5-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20201015175709.20121-1-charvi077@gmail.com>
References: <20201015175709.20121-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid using `cd` outside of subshells since, if the test fails, there is no guarantee that the current working directory is the expected one, which may cause subsequent tests to run in the wrong directory.

Signed-off-by: charvi-077 <charvi077@gmail.com>
---
 t/t7201-co.sh | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 74553f991b..5898182fd2 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -339,10 +339,7 @@ test_expect_success 'switch branches while in subdirectory' '
 	git checkout master &&
 
 	mkdir subs &&
-	(
-		cd subs &&
-		git checkout side
-	) &&
+	git -C subs checkout side &&
 	! test -f subs/one &&
 	rm -fr subs
 '
@@ -357,10 +354,7 @@ test_expect_success 'checkout specific path while in subdirectory' '
 
 	git checkout master &&
 	mkdir -p subs &&
-	(
-		cd subs &&
-		git checkout side -- bero
-	) &&
+	git -C subs checkout side -- bero &&
 	test -f subs/bero
 '
 
-- 
2.29.0.rc1


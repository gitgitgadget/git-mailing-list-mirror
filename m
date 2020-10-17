Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658D5C433E7
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 07:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 218EF2072D
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 07:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljF8g+4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437537AbgJQH4M (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 03:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437534AbgJQH4M (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 03:56:12 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF704C0613D3
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 00:56:10 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y1so2454918plp.6
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 00:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IrSQHAG8PqG1zbLYKHzlWEDMNNUxrGjf+XNdVL2DXSc=;
        b=ljF8g+4+nQZnHLwFVSsagFiqyEmxsIesKP9cTvs/9QacaPcfOobp6fLoBe1SNHvE4F
         VtSH7LTpmI3BJV3k8foI0YKm17+imDnmmd5PfBR79+Zh7+E4HmniTEq+YWv1kMTxYjF4
         iL9pB/BCnyo4tLP/TST6nxoMYUeN4k7U5UWJzXxDrVr+4gXnQJqh9xPYi/AyaPaLGPFd
         BKRQDa07wXXQnzoH6QKsJ/8f95kfAgOZxIkGJH0nYHtp0Zivkb3TiT4RKkM7PmKfiT9s
         GTm5TcTERo7nvMXBtmszLMHQysFm8UVULHlNRPybbsKFHlWVdIZAZFF1oETR9ERMA8vx
         BaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IrSQHAG8PqG1zbLYKHzlWEDMNNUxrGjf+XNdVL2DXSc=;
        b=uf3rvewPB1mwkQNdkPwqsDnsv2F1WLOUvVtmg5MdlCO+8DlP8qHZTSG89EihIEvDlg
         Po4dKamnWwQ6TF5kL/am3jE3guljf0MOJMfPasdWawi2zeEmDF8e5kCjZTtouy5UHwey
         4kzT2nwlCGXZSPLb3rt5q8FbZsTl3vS2eQNlCT5oMqotOkPxtW8+bH/KL5XXefenZCvV
         abLYVv5uBLTiod3TFN7o3lFznIevAOKHstf1E/o8egJBB2tmojFaF7uddyuxaDCH7FLo
         dRHWsokwtJjVErEwrT03lAMSENp/jC1SOrLnS9V5H5e13J+wrNngDTKPBqfOcNH4SCOB
         MIlA==
X-Gm-Message-State: AOAM530xTChPjtkSyQzgqVc/pTS94km+P3q0N9KCostusHldFDITwjGi
        ll4vtoYZncPWDusniXb0nUGfXQMQKbOP8A==
X-Google-Smtp-Source: ABdhPJz5/FZDXRuA+0joNifVqWU2fn9XzuPjS3d9XHw1KO/hjS1ppcXpVVOuM8EF6qW8dFBS+UtHlw==
X-Received: by 2002:a17:902:7611:b029:d4:da66:f26c with SMTP id k17-20020a1709027611b02900d4da66f26cmr7894721pll.3.1602921370195;
        Sat, 17 Oct 2020 00:56:10 -0700 (PDT)
Received: from localhost.localdomain ([106.201.2.128])
        by smtp.gmail.com with ESMTPSA id t2sm4994162pji.12.2020.10.17.00.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 00:56:09 -0700 (PDT)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        sunshine@sunshineco.com, Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v2 4/5][Outreachy] t7201: avoid using cd outside of subshells
Date:   Sat, 17 Oct 2020 13:24:54 +0530
Message-Id: <20201017075455.9660-5-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20201017075455.9660-1-charvi077@gmail.com>
References: <20201015175709.20121-1-charvi077@gmail.com>
 <20201017075455.9660-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid using `cd` outside of subshells since, if the test fails, there is no guarantee that the current working directory is the expected one, which may cause subsequent tests to run in the wrong directory.

Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
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


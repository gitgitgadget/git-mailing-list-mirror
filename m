Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56644C56201
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEAE020781
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cfwiw54/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbgKJVWO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 16:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731912AbgKJVWN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 16:22:13 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C282C0613D1
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:22:13 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id t10so241128oon.4
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UkU5z8sfNDXovy2ZdIiqze3JF/d4JAzCtCfhdyoJj/g=;
        b=Cfwiw54/fdNG+4yQ8Zq48UcPkYHtJnshc4DIlLQmzQVgFy72S3+hOLB7U59Jlo4jcH
         2jS7J7Gyf1DKc+W2cxOR9+yDqa7mKW139Hk6h5Brpu7t3I+bw9E1Tj3svBvUfPnkc+5V
         Vve0IPaNxJPJXKXzsSnceCSegnGcehFDMZNwch8RJTkixl83hAE4K8oJQjb4P+xSLRit
         14+C+Fjn1EocbF1LH4g/U2Dgl9SAqV3XCiTIrw47Gx+NgVUGQTZYJyf1sxPE7SXRRZbj
         UvLhaKm1OYA87Qb00H/XoO+UbsOnSh8lk1e1+xeRwUC+ylY7LvLUnSRKniT9JegxQy8u
         oaTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UkU5z8sfNDXovy2ZdIiqze3JF/d4JAzCtCfhdyoJj/g=;
        b=C/0EFexmGAPATMlizoV2fnV5tLY6dVXQOxAr2TL/IQrCNnlwh2Wt1YlLJ7IW5IYmH9
         GqmgClLX6Yv/fED1qOhTYJEbTHmcWIgvbqYRmSCnJdT94CU3jh0RQeBBsxI8SkfvZS/P
         Q7lWzov8oXbt8gLxZgieZ7+SxIKiV37SXRI5UsbMDlaMFyQIIyuoI/UcEM/cqviAvgaG
         3tDFDP0r7XD6UDfkhj7GlLkmyMS4fVXKrMwzNmZ8r1hqWoKSk8T40iGRL9GWMt4TG9Oz
         r9YqwIjdrRDCqWCyaftzMFa9ViGpgT3VsQgeVqhPlqSpkfP345VLybAL556Bv0VnXHbA
         FPIQ==
X-Gm-Message-State: AOAM5325oby6b2oE/A6xPe9Mq5eajEZJEGHFdyEGaB4H1QagQfQIasIf
        9Fo/TVZi3wwmS7X7fXJH2vncVpW6OVWj9g==
X-Google-Smtp-Source: ABdhPJy+9eAiZi1BOCeMHHQpqqZsFMrn+898U3l9uB1qoiu05iSujL7/mJCXmvhP1eUrqHQyTZnJyg==
X-Received: by 2002:a4a:e09a:: with SMTP id w26mr14977174oos.18.1605043332361;
        Tue, 10 Nov 2020 13:22:12 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id l2sm19923otl.67.2020.11.10.13.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:22:11 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 17/26] test: completion: switch __gitcomp_nl prefix test
Date:   Tue, 10 Nov 2020 15:21:27 -0600
Message-Id: <20201110212136.870769-18-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201110212136.870769-1-felipe.contreras@gmail.com>
References: <20201110212136.870769-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By default COMP_WORDBREAKS includes =, so it's not realistic to test for
a prefix that almost never will be there.

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 3ec9ff9308..012dade4a5 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -570,9 +570,9 @@ test_expect_success '__gitcomp_nl - trailing space' '
 '
 
 test_expect_success '__gitcomp_nl - prefix' '
-	test_gitcomp_nl "--fixup=m" "$refs" "--fixup=" "m" <<-EOF
-	--fixup=main Z
-	--fixup=maint Z
+	test_gitcomp_nl "branch.m" "$refs" "branch." "m" <<-EOF
+	branch.main Z
+	branch.maint Z
 	EOF
 '
 
-- 
2.29.2


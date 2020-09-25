Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECEDC4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 17:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8BA4208B6
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 17:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzPjUcct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgIYRD1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 13:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgIYRD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 13:03:26 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179CAC0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 10:03:26 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id k13so3788603pfg.1
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 10:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lNsqDMFnGvUZwq/IKUAAr2ueT9TE0q11LCex7uvkQ3U=;
        b=ZzPjUcctJuicPTHdwCSeN0o2BtCynr3haejYm8qhp6Ipe/KPDcYe8u/9XkVj1XltzQ
         jQUECB6tQNu4UvszE22jHUZdhqcW7RYUMi7fBSQzJP4JmjgFaj/spRdpzvfgCEqYuXHF
         un2WRQN3924lE2ExL1RQmOOHyKFdOMT9eJ9d80NXU3vdHjlvVNsbAgl3Mq7vJl/Q/ptU
         oumK4cQAgG/qeqWy9/WO5j5UxvZiRFHC0LhouDerEt8Ak7oydYVka59Zj0N2bagBmGiU
         t3gccBCD8OSL+bvvI9TrHFuydjXRD/n4u2CK7ZaRQ+7qWKPHqjPAFqONVozD2vxkcRYk
         H9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lNsqDMFnGvUZwq/IKUAAr2ueT9TE0q11LCex7uvkQ3U=;
        b=KsPJtgqJiDBk32rgHj7gWsNjiPcaIhkZgBJJVY8QHrvGSdTB96HV0UYkA3ZIhLWjQS
         gfjJ0DWsrvst2QdjKXROuYKZObDhBUTQjttzif6N71zx7w9s9MR7Htoi91qOkrELnWmJ
         dNEfuP1vMe2RH5OrSoA0f4d5uTVlR+XEeBon6VJjB5QDE37d5eYN2TK/QoB6cWPLH6dm
         XCbsMtZFqcNDEfODejc68SRk0Rj5Tyl6M2MNSPhpH+jXyUpPGaL4T4dPmAu/0Qozica/
         ez6+WlBSGOh7Tu0sAygejcyIzacx4MeLnNH7p1NGI8IpLUmt2gSQuXncV302ZyDdFaNG
         LqWQ==
X-Gm-Message-State: AOAM533RG7n8g0IAE01eBEbb6FiJU+JVDuf1nl3O9EJJd0NObtkpLwOp
        j5zjzYwcHe1P72XcQ5a8MYg1LtKHtBszpA==
X-Google-Smtp-Source: ABdhPJxetq6JPWuo9nAPLujyhai4LOAWDOrdEB83zbDWOoyhZOMtld3UrOF3RVLWS2YWnFwXtbNq2A==
X-Received: by 2002:a63:2063:: with SMTP id r35mr871445pgm.320.1601053405251;
        Fri, 25 Sep 2020 10:03:25 -0700 (PDT)
Received: from localhost.localdomain ([47.9.163.48])
        by smtp.gmail.com with ESMTPSA id k27sm2822467pgm.29.2020.09.25.10.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 10:03:24 -0700 (PDT)
From:   shubham verma <shubhunic@gmail.com>
To:     git@vger.kernel.org
Cc:     Shubham Verma <shubhunic@gmail.com>
Subject: [PATCH 05/11] t7001: remove whitespace after redirect operators
Date:   Fri, 25 Sep 2020 22:32:50 +0530
Message-Id: <20200925170256.11490-6-shubhunic@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200925170256.11490-1-shubhunic@gmail.com>
References: <20200925170256.11490-1-shubhunic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Shubham Verma <shubhunic@gmail.com>

According to Documentation/CodingGuidelines, there should be no
whitespace after redirect operators. So, we should remove these
whitespaces after redirect operators.

Signed-off-by: shubham verma <shubhunic@gmail.com>
---
 t/t7001-mv.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 67585b7d94..7581e4b407 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -156,9 +156,9 @@ test_expect_success "Michael Cassar's test case" '
 	rm -fr .git papers partA &&
 	git init &&
 	mkdir -p papers/unsorted papers/all-papers partA &&
-	echo a > papers/unsorted/Thesis.pdf &&
-	echo b > partA/outline.txt &&
-	echo c > papers/unsorted/_another &&
+	echo a >papers/unsorted/Thesis.pdf &&
+	echo b >partA/outline.txt &&
+	echo c >papers/unsorted/_another &&
 	git add papers partA &&
 	T1=$(git write-tree) &&
 
-- 
2.25.1


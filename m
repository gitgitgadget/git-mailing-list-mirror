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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72205C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 17:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2505F21D42
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 17:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kceSB8VO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbgIYRDY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 13:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgIYRDY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 13:03:24 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE38C0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 10:03:23 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id y14so3091590pgf.12
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 10:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bD6MobUJibAkB8t3H1uIlFYDJVbhdGRbdmiajUhrcDE=;
        b=kceSB8VOPvnISdGxk4Vq68xaCHRR+blDxwuv7X1Je07YUXStXF0uODpanty50sVERC
         Mlu3GSb7VzMjlaZewmR1KE3Nmb+3QpTEpFg5smp5aQ2VgUyd6VCrQ1Xgijh8jRe2WcRs
         g5evrV8G9ZP546tqcSFw53LS7ZZ0kGNn5rskbU+i/qgOw/6otXALDqY+m3hJd07BnFWZ
         KQ6QEMaTjCgJ67SVx2OsyXAQbOgPEDbrICiXB6kbKGCxtLNYAvqwEaoWHhf5bY7Bvllj
         n9+RjUrugY2vAoUUtB4A7jFmAKfFNfJFRGfJNK/bOyPSyUU70Lq0ggINfJGjEcLWRct/
         1hxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bD6MobUJibAkB8t3H1uIlFYDJVbhdGRbdmiajUhrcDE=;
        b=QafKG5LLJvQFKN8zcrkbC1FwcS5Xwy3ZqRAvK3xeyyZb6n7HGayfyJCAK2kZP/Fkut
         GK7qtIqSls/x4ivBRVZzX6CRQ58LXxqXVdY03nOMOF+0h4nWLDA4SUjRkBq2nwxOIfMr
         +6FUYptglVFvTNommxWmzy+bL9MjIpS6Q1C6gzhzgkRw1QQyxIXe3cu5q6bGtEeAdEy3
         IrifkkRAopoJJWHKxYCjOD49JpGCLKzQAL0aj3fwhMYWajL9b55L0nlkDeEfHN4OY+jd
         TxKP3ID4TNYZ14t4Bh/aBMrEoRDCevJ1m5J/xv5aQxbmqh5omSmUbv06piD3jLqQiqpX
         qE4w==
X-Gm-Message-State: AOAM531SbHeFKQtbLVAiSYHdGkLVOwaFjmTtr20WgpyeFIdbhZP2hrhQ
        u2jWmltT3jU0CRcZ2tpAx+dSZJ3PgOYspg==
X-Google-Smtp-Source: ABdhPJzkA9cEw3E7nZ3YuDN3sY01nWlTzjVnhtfO701iyRVxgbniJK3XjsarFVYO138K7uXGsngvCA==
X-Received: by 2002:a63:c64f:: with SMTP id x15mr818775pgg.135.1601053402968;
        Fri, 25 Sep 2020 10:03:22 -0700 (PDT)
Received: from localhost.localdomain ([47.9.163.48])
        by smtp.gmail.com with ESMTPSA id k27sm2822467pgm.29.2020.09.25.10.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 10:03:22 -0700 (PDT)
From:   shubham verma <shubhunic@gmail.com>
To:     git@vger.kernel.org
Cc:     Shubham Verma <shubhunic@gmail.com>
Subject: [PATCH 04/11] t7001: change the style for cd according to subshell
Date:   Fri, 25 Sep 2020 22:32:49 +0530
Message-Id: <20200925170256.11490-5-shubhunic@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200925170256.11490-1-shubhunic@gmail.com>
References: <20200925170256.11490-1-shubhunic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Shubham Verma <shubhunic@gmail.com>

In some tests there is not a proper spaces after opening paranthesis
and before cd. So, Lets change the style for cd according to subshell.

Signed-off-by: shubham verma <shubhunic@gmail.com>
---
 t/t7001-mv.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index f63802442b..67585b7d94 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -503,14 +503,16 @@ test_expect_success 'moving a submodule in nested directories' '
 test_expect_success 'moving nested submodules' '
 	git commit -am "cleanup commit" &&
 	mkdir sub_nested_nested &&
-	(cd sub_nested_nested &&
+	(
+		cd sub_nested_nested &&
 		touch nested_level2 &&
 		git init &&
 		git add . &&
 		git commit -m "nested level 2"
 	) &&
 	mkdir sub_nested &&
-	(cd sub_nested &&
+	(
+		cd sub_nested &&
 		touch nested_level1 &&
 		git init &&
 		git add . &&
-- 
2.25.1


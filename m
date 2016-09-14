Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E6B21FCA9
	for <e@80x24.org>; Wed, 14 Sep 2016 21:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1765246AbcINVHr (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 17:07:47 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34584 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762488AbcINVHp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 17:07:45 -0400
Received: by mail-wm0-f65.google.com with SMTP id g141so4275147wmd.1
        for <git@vger.kernel.org>; Wed, 14 Sep 2016 14:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m62piIKO9PMMxZxEbO0j4vIvKbsfOUj8mHZ4XWic/6s=;
        b=HfoZdSTdFbSpJ5ndmXzrSh6oOgDPzQyZFIu99RaSClrXwBxFb2/EPb/HsnJyPfKpkf
         KObfgTdXNcN8zXjRm1Y3ouL+TZatLqEsmjm36pCPeRtpz6TZXSQK1vqYi9vPIGsanwWL
         HYGw4IUX2flbGYW4GV8/RDnibRBB2naLrlN+DotygAIvLyaQgjdWPr6a683i+HALh5Ev
         DCbUO+CD9scDxNQw+gzNXX/ecWw4miCdbN0+QFf65iGlf4hBMU0apv9YQPkYZn+LN3ja
         0mCaV0ZyaASe70yGTQ/zFgQ8LCMc6k3mO7pW+FM1D5G2IchTEUUz2bwfZful4OPll+gh
         WXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m62piIKO9PMMxZxEbO0j4vIvKbsfOUj8mHZ4XWic/6s=;
        b=jSDGCs1SqIh1WY2pL4EluZCmaalq/3kvy6u0ZVyjxr/C+cSpdASieyQUkIz/pf35K3
         d1jijqYx/EFcMkPcHnrk4sQSPRx6eLNUDQ7K53qvjKP4VyaJRhkAX7rpvpgqbjWqce6g
         wK5A5OfbDeVhZKipKFxr5DGLhhwbmwZPCPcPCjJC3aLi/6SEn0Bc9qdyuWrl3cTuRkd4
         Xl9AHTVJN2wGeXpBea1UYiWyGH7Av1KYYTn5tWvX5jiXkGWdN+qwUA+RldlgtyxgqHB5
         cD4xfjBq7vLFarWoNWxWH451kexHaPJiko6WQOtE9Ibir1UZajj7iah9QNpb6jEjn777
         ssdw==
X-Gm-Message-State: AE9vXwOiV1aIc4CY1R5FEyUD+mSQFYjXQqPvgRgQ65o8twdevi9zR5B2pMVe5sjjYAyfmA==
X-Received: by 10.28.209.142 with SMTP id i136mr5495545wmg.0.1473887264019;
        Wed, 14 Sep 2016 14:07:44 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id f8sm58854wjh.45.2016.09.14.14.07.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Sep 2016 14:07:43 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Jan Keromnes <janx@linux.com>,
        =?UTF-8?q?Ingo=20Br=C3=BCckl?= <ib@wupperonline.de>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 2/4] update-index: add test for chmod flags
Date:   Wed, 14 Sep 2016 22:07:45 +0100
Message-Id: <20160914210747.15485-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.10.0.304.gf2ff484
In-Reply-To: <20160914210747.15485-1-t.gummerer@gmail.com>
References: <20160912210818.26282-1-t.gummerer@gmail.com>
 <20160914210747.15485-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently there is no test checking the expected behaviour when multiple
chmod flags with different arguments are passed.  As argument handling
is not in line with other git commands it's easy to miss and
accidentally change the current behaviour.

While there, fix the argument type of chmod_path, which takes an int,
but had a char passed in.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/update-index.c        |  2 +-
 t/t2107-update-index-basic.sh | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index ba04b19..bbdf0d9 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -419,7 +419,7 @@ static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
 	return 0;
 }
 
-static void chmod_path(int flip, const char *path)
+static void chmod_path(char flip, const char *path)
 {
 	int pos;
 	struct cache_entry *ce;
diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.sh
index dfe02f4..32ac6e0 100755
--- a/t/t2107-update-index-basic.sh
+++ b/t/t2107-update-index-basic.sh
@@ -80,4 +80,17 @@ test_expect_success '.lock files cleaned up' '
 	)
 '
 
+test_expect_success '--chmod=+x and chmod=-x in the same argument list' '
+	>A &&
+	>B &&
+	git add A B &&
+	git update-index --chmod=+x A --chmod=-x B &&
+	cat >expect <<-\EOF &&
+	100755 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	A
+	100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	B
+	EOF
+	git ls-files --stage A B >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.10.0.304.gf2ff484


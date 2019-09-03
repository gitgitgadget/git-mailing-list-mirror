Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAEB81F4BB
	for <e@80x24.org>; Tue,  3 Sep 2019 18:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfICSze (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 14:55:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39528 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfICSzb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 14:55:31 -0400
Received: by mail-pf1-f193.google.com with SMTP id s12so4341519pfe.6
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 11:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kBpBFADxWHLS5gKlvnLUPE1kuS+uZTFoZBTjczUXaec=;
        b=VUmRwdf+8B6LuoPIsDh3ZCYW8d/6hXEsR9oE4xUhPU4mGbZZhrq13f2jscsxNr60PK
         vTnZRSOYXg8KkgCx9/x/+sqzJSFxJ9KuM8BUCaIBPaiOfwRJvHMnBddpl3VKwBl6eIr8
         V36lfa1O1e9lu3tZqJs3q9W/6yktVQeWEqWlzz/AECJPt3jiU0VxJ2VDRveoloK0XjN+
         1r63iBUUEJsJrisGaQ3inUsXvo6WnheTFNkGTZMATOf58SYJmouUbjILQdEegZO/WlFE
         mLRRwwMMUaparzF735JPKMK/9B6tStzfHQ1Y0bBLR5cSVmulGUyVmbJjMyYjOOdLrSmH
         4LaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kBpBFADxWHLS5gKlvnLUPE1kuS+uZTFoZBTjczUXaec=;
        b=M8LAbLlRqJ63pAVPU5Egr4x0RwljxrwbuBC+4J2u6ScXRZvaqkluTxhpGW3uLJpjl4
         0aeDdk4YiyGBbop8U1q5cJsFAPsDiT3VS6DXW1XbTQ8jmRPYAvAfOS1Q9YUly+1+jiPh
         W6xloEzU72w/Vze3K1Pc+wGu8cbERqKOTFdPPSpAQtlyzOQzpNJIeJvO1H7BrRvYIxjz
         0ga4kFf7xLMWKV3taJjGFgRlAAncXbV2SuOtKoi9zGjEGokZ+Eupodl75WIdfaRvEK0+
         fctLar0YAIjehenHeqZouKEHwZF1OVTdro6ryXyISl7v9+aMx6b8g8nNhc+0Lh1pq2a2
         UO3A==
X-Gm-Message-State: APjAAAXfz4J2RaRHPPaZ2pAlS66Wg0JRfXlhLwPutCggKJ0RqmAUo9rg
        5EPfv8iIsrEwOJ0TA97brJuVetqZ
X-Google-Smtp-Source: APXvYqwvskRoII0FDd6tb31sZtjqekuwcVkxuAoG51XoyS7fiUZ/D9mjrRxPEC51yarNSH6uUQPFOQ==
X-Received: by 2002:a65:65c5:: with SMTP id y5mr31153876pgv.342.1567536930781;
        Tue, 03 Sep 2019 11:55:30 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id 136sm21283855pfz.123.2019.09.03.11.55.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Sep 2019 11:55:30 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 1/4] t6006: simplify and optimize empty message test
Date:   Tue,  3 Sep 2019 11:55:21 -0700
Message-Id: <20190903185524.13467-2-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.39.gf92d9de5c3
In-Reply-To: <20190903185524.13467-1-newren@gmail.com>
References: <20190828002210.8862-1-newren@gmail.com>
 <20190903185524.13467-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test t6006.71 ("oneline with empty message") was creating two commits
with simple commit messages, and then running filter-branch to rewrite
the commit messages to be empty.  This test was written this way because
the --allow-empty-message option to git commit did not exist at the
time.  Simplify this test and avoid the need to invoke filter-branch by
just using --allow-empty-message when creating the commit.

Despite only being one piece of the 71st test and there being 73 tests
overall, this small change to just this one test speeds up the overall
execution time of t6006 (as measured by the best of 3 runs of `time
./t6006-rev-list-format.sh`) by about 11% on Linux, 13% on Mac, and
about 15% on Windows.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6006-rev-list-format.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index da113d975b..d30e41c9f7 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -501,9 +501,8 @@ test_expect_success 'reflog identity' '
 '
 
 test_expect_success 'oneline with empty message' '
-	git commit -m "dummy" --allow-empty &&
-	git commit -m "dummy" --allow-empty &&
-	git filter-branch --msg-filter "sed -e s/dummy//" HEAD^^.. &&
+	git commit --allow-empty --allow-empty-message &&
+	git commit --allow-empty --allow-empty-message &&
 	git rev-list --oneline HEAD >test.txt &&
 	test_line_count = 5 test.txt &&
 	git rev-list --oneline --graph HEAD >testg.txt &&
-- 
2.23.0.39.gf92d9de5c3


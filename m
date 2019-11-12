Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C73B31F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 23:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfKLXIW (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 18:08:22 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41620 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfKLXIT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 18:08:19 -0500
Received: by mail-pg1-f194.google.com with SMTP id h4so12848531pgv.8
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 15:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ls80ApMDZ63O9CWY0UmGsH3sLsn6LZZxtpkFdLp4OCI=;
        b=Yy7n4VNmgdMCfx9wcUPW8YytFzjUeXue342JlbwqVb77yWSQGay4kNnW+fi7oL2mhi
         xTtandd9dBvCDpX1OG6uUntZaKvb5Q3mPZB4vLgAFBnMhCBZStavaT1UHxnPoYJhRQKc
         9P+0bMAVAZoGeEHNGKV6SkIfXWA8fbudQsU4uiX08K8RbZt9/mDICdU6ght+36+keGvg
         CO05wqn5bFGpw6tbOfiUGv+XjIW7TaVhe8MYM0m7cr7TxTUcOydq/62PJA2k1Zx3fy09
         TwOTmDnnpfonnaXkQxgWiuwQ48VXm2qVO52QH2/THFAIHwLp5SBOf/KmIZHzUJn6Kthe
         /j3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ls80ApMDZ63O9CWY0UmGsH3sLsn6LZZxtpkFdLp4OCI=;
        b=W6v48xAkDmQSNS6EQpDd/L0dUjMzpS+Jwck0n/hw7BJOUkWaxB8za8F9VnAz3DChg1
         niOClHzoVWMFw7qsmYOj1ZVgSrMZtCPO45MEKZoDrWtbQCcoJYbDyu9pOSxNPfQ0peSq
         bmUh/z/aWZk2It8K75QwnS1tPw09L3zyEJN45HecGcLj/HI8wjWXD9tGIQbsX8QUVQLr
         72IhMlM6qJhxyF2B3mZRlHpW8huDW32GCz77JqLdUjqCeiF112jcxQQwNCAN++vURutl
         DFrRU10r14yTAj6AeQu92pVIqa5cvAK5NuJhhGIxcbfSPXXNPhCrYRS8DBq3SE12RUj1
         4qGQ==
X-Gm-Message-State: APjAAAW3I9AAqd4AgqghW9JHfOU0aEVNrxjHmyDSbDJNG8KWGsBbFzuQ
        yuq3kV/dES8wS0xhelzxHRgEFZq+
X-Google-Smtp-Source: APXvYqyP5WXAs9UY23cdxiutnQGyFVONaXxjyuuezqSKs1d3cIiUDjOCMKbVxJNqHSSg7Ys2zxpepQ==
X-Received: by 2002:aa7:9358:: with SMTP id 24mr472498pfn.195.1573600098968;
        Tue, 12 Nov 2019 15:08:18 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id x10sm38550pfn.36.2019.11.12.15.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 15:08:18 -0800 (PST)
Date:   Tue, 12 Nov 2019 15:08:16 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 14/14] t5520: replace `! git` with `test_must_fail git`
Message-ID: <c605afa53702ba425d2c341b57a69c700fb2d423.1573595985.git.liu.denton@gmail.com>
References: <cover.1573517561.git.liu.denton@gmail.com>
 <cover.1573595985.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573595985.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, if a git command fails in an unexpected way, such as a
segfault, it will be masked and ignored. Replace the ! with
test_must_fail so that only expected failures pass.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index ef3dbc201a..602d996a33 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -537,7 +537,7 @@ test_expect_success 'pull --rebase=i' '
 test_expect_success 'pull.rebase=invalid fails' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase invalid &&
-	! git pull . copy
+	test_must_fail git pull . copy
 '
 
 test_expect_success '--rebase=false create a new merge commit' '
@@ -572,7 +572,7 @@ test_expect_success REBASE_P \
 
 test_expect_success '--rebase=invalid fails' '
 	git reset --hard before-preserve-rebase &&
-	! git pull --rebase=invalid . copy
+	test_must_fail git pull --rebase=invalid . copy
 '
 
 test_expect_success '--rebase overrides pull.rebase=preserve and flattens keep-merge' '
-- 
2.24.0.346.gee0de6d492


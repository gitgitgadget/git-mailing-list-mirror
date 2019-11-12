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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2824A1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 23:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfKLXIF (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 18:08:05 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39577 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbfKLXIF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 18:08:05 -0500
Received: by mail-pl1-f193.google.com with SMTP id o9so174608plk.6
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 15:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DqTcJpSwjBxYceYDc3JkNFMsgUnajxwgta1lYg+KQn0=;
        b=MpHVTgFlfz7B24HSRrH88t57dUUYHZHWhsPMG9BuAePQ5Grra7nXblR8Jhuo8fZ6ZX
         7oxtmCc48FcUw11gWY/jYOpWq7byhw6WPA0E8Eu/NKWDcAZh2Gltp0YtBEeAfjxgzMKl
         4HyFu9cUJx7LbzgJA/6TAT4mnxeZJWzwN4kF4e/LrI6sC1iHwseX69RM+8mZOUbkOdBG
         cyyAhw8oEC8cAFNLzV8alO0QY6gD9yXwJvSODkKin/hPRbdytTTM3pk54p8VYJm7Aktq
         FRRGTx4U83nSX/yTVGz6ySAsHUX952twBjXJAHA62RJZ2rQw5G0U0OAqHZzkhZdBklga
         Shfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DqTcJpSwjBxYceYDc3JkNFMsgUnajxwgta1lYg+KQn0=;
        b=BEVwVAofHK6gyPKYwFzvXQAylCgdjNudLOwCr5kDM6EHIu6t5A/Fw9l91ussAaRdgx
         l3Z69SwR9JMGm4ba78MOHvFOk7b0zsTCZTNHNFfLAZPqTtCwgQHgP+wqmkreXr00TQYQ
         iUJhunmivkUQF060e4rJx5u6NOxD2LavOrYdJWBQr5o+8sDrHT9CfRlbh9MiaVqYVY4U
         68bkHDGsEn+ZjE/to3cevlz0ayy4d602kpgPjWYr3CvaLOqWnqpo3G1kZar0opJVFfWQ
         HlwTKeGfIbyO3JoGrng8IYW2ksue307zsMGL9kKwRldgefqFE2PVUfzJRA2Ia7+A/x+A
         0aDg==
X-Gm-Message-State: APjAAAWt4zg+pAysbyI9oci1ZRsNgJhd2dDmgKZIHrABC/YBmyTPt/P0
        nI5j17m+9SCR2sosY6yraVM6agcB
X-Google-Smtp-Source: APXvYqzz8TSCVS001tvSEG3kMgvFSTQvN9Xp5sCE6F9eaPCd0r1aCiZKJn9/pBNoCcEWyLikDD7vsg==
X-Received: by 2002:a17:902:b181:: with SMTP id s1mr373129plr.62.1573600082543;
        Tue, 12 Nov 2019 15:08:02 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id u8sm59003pga.47.2019.11.12.15.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 15:08:02 -0800 (PST)
Date:   Tue, 12 Nov 2019 15:08:00 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 07/14] t5520: use test_line_count where possible
Message-ID: <8e1c90eb70e4325861d82ae5da9b99a914b28759.1573595985.git.liu.denton@gmail.com>
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

Instead of rolling our own functionality to test the number of lines a
command outputs, use test_line_count() which provides better debugging
information in the case of a failure.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 7bb9031140..0ca4867e96 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -699,7 +699,8 @@ test_expect_success 'git pull --rebase does not reapply old patches' '
 	(
 		cd dst &&
 		test_must_fail git pull --rebase &&
-		test 1 = $(find .git/rebase-apply -name "000*" | wc -l)
+		find .git/rebase-apply -name "000*" >patches &&
+		test_line_count = 1 patches
 	)
 '
 
-- 
2.24.0.346.gee0de6d492


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B99101F453
	for <e@80x24.org>; Fri, 26 Apr 2019 19:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfDZTVN (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 15:21:13 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44732 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfDZTVM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 15:21:12 -0400
Received: by mail-pl1-f193.google.com with SMTP id y12so1995286plk.11
        for <git@vger.kernel.org>; Fri, 26 Apr 2019 12:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+H8POLCQdoLlAi1a7Fm8nOAQ7YE8GMb4TmGGZ6DpMMY=;
        b=Lq+pobLd8V3dtv9tD6wKSOd/oPwGIHWUk2nEcsiCTt39bZJy/9OqfkEFE1NzZNJ9rI
         479UBIUx7xuphkubQCRFec2iXRS1fpJhHnAwgSwCcvaxPkNWYX2LuZwpWoPuzgETdgmF
         oyVNdeknwfy4A7OFInvQdvGKTh7YGbq0JWFcdohQM4ld/I/GjEdg7k5YtU5v3j811iBV
         JkpGxHLa6zT+QZqLp4jt/CRXgOFU0yDhqWiGLJpcKlwfajU1nIa5dAXQQuSCmL6MsvSC
         0zKSzHOuQ3aHp995iOBHnASl8yzhBTlT7osRr+3Wqj57vUFWH7quNlXL8LwNAo+F89HG
         LAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+H8POLCQdoLlAi1a7Fm8nOAQ7YE8GMb4TmGGZ6DpMMY=;
        b=lNxwc8au6DvUDGlpcsmyYlkqXWdoRQXrUuins23js+dxCcmWm2+MyLVKStBJtTn+Ol
         37YUmrDFkWilcdO8LcJRHIRkuydN7lHLCdmAI7Ud0RU9BBp66DVfwu/Lt91UEx9+wKqu
         Q9Xtc6xIscBeUAW6qE2V31ZkB46NF4iRHjZ7Q5Eb5ryRP2DB6iPmEn+ztKjCX71CIgM6
         2ZHXZXr2bM99/Ry3YxspXbrqgnjPW4bGv6lXM5xwnH+8nd3N3IcFQv6C1bXJZmihBfpA
         pDyjgf6XGZE718KN+PMdT+INJzk1r1bWA7GeJ7rWdEeMai0S3XKPpVCp4pD53GRb0Oed
         dHsw==
X-Gm-Message-State: APjAAAXpUhjCCCLN9PhZiDjX9w0qVVLOI/UAZ60hljP2WbDhYampcS9b
        S2ytpi2VuAesqc7tOfygZkGZ28JXnaU=
X-Google-Smtp-Source: APXvYqzbZsVZqWmzzKQ50EzFpS7jTDtJb/cC2Fa8HPiA6DAKLYVtR1O1SofgmHSSmcO6V6UEb0TL7g==
X-Received: by 2002:a17:902:b089:: with SMTP id p9mr47705769plr.185.1556306471077;
        Fri, 26 Apr 2019 12:21:11 -0700 (PDT)
Received: from dev-l ([149.28.199.249])
        by smtp.gmail.com with ESMTPSA id a10sm34088586pfc.21.2019.04.26.12.21.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 12:21:10 -0700 (PDT)
Date:   Fri, 26 Apr 2019 12:21:09 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/3] t2018: demonstrate checkout -b merge base bug
Message-ID: <5e8320cd80415f50a79815b9fcd55c051e45e38b.1556305561.git.liu.denton@gmail.com>
References: <cover.1556226502.git.liu.denton@gmail.com>
 <cover.1556305561.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556305561.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In git-checkout.txt, it states

	As a special case, you may use `"A...B"` as a shortcut for the
	merge base of `A` and `B` if there is exactly one merge base. You can
	leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.

However, there exists a bug where performing

	$ git checkout -b test master...

fails with the message

	fatal: Not a valid object name: 'master...'.

Demonstrate this failure so that it can be corrected later.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t2018-checkout-branch.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index f1c7023e1a..3cd142657a 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -66,6 +66,13 @@ test_expect_success 'checkout -b to a new branch, set to HEAD' '
 	do_checkout branch2
 '
 
+test_expect_failure 'checkout -b to a merge base' '
+	test_when_finished "
+		git checkout branch1 &&
+		test_might_fail git branch -D branch2" &&
+	git checkout -b branch2 branch1...
+'
+
 test_expect_success 'checkout -b to a new branch, set to an explicit ref' '
 	test_when_finished "
 		git checkout branch1 &&
@@ -126,6 +133,12 @@ test_expect_success 'checkout -B to an existing branch resets branch to HEAD' '
 	do_checkout branch2 "" -B
 '
 
+test_expect_failure 'checkout -B to a merge base' '
+	git checkout branch1 &&
+
+	git checkout -B branch2 branch1...
+'
+
 test_expect_success 'checkout -B to an existing branch from detached HEAD resets branch to HEAD' '
 	git checkout $(git rev-parse --verify HEAD) &&
 
-- 
2.21.0.1033.g0e8cc1100c


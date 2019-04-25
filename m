Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9E011F453
	for <e@80x24.org>; Thu, 25 Apr 2019 21:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387398AbfDYVKk (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 17:10:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34329 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfDYVKj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 17:10:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id b3so545208pfd.1
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 14:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qSoNQaUaZqvH17VggX9DTUkgv6ddCZLRzNE1fkqgTLQ=;
        b=kShagk0N0IwgilGP2Gdv8oOr6Yz85rKncujxhntpccRsGAs9b3UqX6aRNOStQ589h5
         NrgnAA0DwWLck0cioht/39Chi8n62SHrsIDXHTxrltUBwrcpUp7CespqTqXn+2nYUXYh
         NtZ9Ew5Z6kSlNiRttL65B5aBnVv06nwbbn4G5t9Tp6Lg7wtUCACrd+B/80jqYZ1V9lQb
         WE8qhyg7H8nB+ycfjxtecKNe42S6dvjYxiuPvPoM0QWk7yy+RqP0RM+cqEhOhDEELHQj
         1M68uvaUHEYkW3jU7Kx0mQl4JgQyiEYn0boz6/rOfXtwxxRRodptBZMJ7TaqKzdOZABM
         vNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qSoNQaUaZqvH17VggX9DTUkgv6ddCZLRzNE1fkqgTLQ=;
        b=tgVbTRClhkUlLh3ypU77z/kJQJimU0VxeDaWr2ka08CZeYDSxbeOXqvbIm4O68XgWW
         7ln7Pwjjte3K0CNZnin1+t5i2sEI1OUTKVidFIf1ATZu9L16pdiZAnvWRnbpF/Y61CzR
         wm5LYzQPNGQjuiEg7PbP5fqfeYofBkOpI+xYeTuewAuOZDjUkUNejyP93ONO3cgYScTZ
         MYjBlzsGWg5bJyWVNMTgVN1KcJmscHDNG9U9KJMX0I64auC40oJ1mi7j57ZeHn0osRhP
         hIaH7lNxygrwpPRQlhkEFufQRjVFkPfE68fv45JwpdvMk9IQQjcZ7AluX4kLdC9BneGS
         4gzw==
X-Gm-Message-State: APjAAAU4pCVOCLdBz1qwH0ScQ60Zm6Mymtsdd0qZtzRMTBz873a0FY3B
        k09bOdI3WNg4lZckL8uf+gsG8++v
X-Google-Smtp-Source: APXvYqxmeHlLYRUt2LpZXO9dUoznfxXdTbXigElQddWc9MWGGfkhbnuL4Ori4jYCeJCzbqlUqZT/bA==
X-Received: by 2002:a63:531a:: with SMTP id h26mr33331631pgb.428.1556226638280;
        Thu, 25 Apr 2019 14:10:38 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id p2sm59250259pfi.73.2019.04.25.14.10.37
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 14:10:37 -0700 (PDT)
Date:   Thu, 25 Apr 2019 14:10:37 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/3] t2018: demonstrate checkout -b merge base bug
Message-ID: <ff38bdb5649c3bb028a5227bb0f9569073b8a500.1556226502.git.liu.denton@gmail.com>
References: <cover.1556226502.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556226502.git.liu.denton@gmail.com>
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
index fdb7fd282d..a3fa520d2e 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -65,6 +65,12 @@ test_expect_success 'checkout -b to a new branch, set to HEAD' '
 	do_checkout branch2
 '
 
+test_expect_failure 'checkout -b to a merge base' '
+	test_when_finished test_might_fail git branch -D branch2 &&
+	test_when_finished git checkout branch1 &&
+	git checkout -b branch2 branch1...
+'
+
 test_expect_success 'checkout -b to a new branch, set to an explicit ref' '
 	test_when_finished test_might_fail git branch -D branch2 &&
 	test_when_finished git checkout branch1 &&
@@ -122,6 +128,13 @@ test_expect_success 'checkout -B to an existing branch resets branch to HEAD' '
 	do_checkout branch2 "" -B
 '
 
+test_expect_failure 'checkout -B to a merge base' '
+	git checkout branch1 &&
+	git branch -D branch2 &&
+
+	git checkout -B branch2 branch1...
+'
+
 test_expect_success 'checkout -B to an existing branch from detached HEAD resets branch to HEAD' '
 	git checkout $(git rev-parse --verify HEAD) &&
 
-- 
2.21.0.1033.g0e8cc1100c


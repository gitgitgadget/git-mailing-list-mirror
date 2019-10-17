Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A03991F4C1
	for <e@80x24.org>; Thu, 17 Oct 2019 23:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441770AbfJQXRN (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 19:17:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43010 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441765AbfJQXRM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 19:17:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id a2so2594171pfo.10
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 16:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WrkHF6VXC/KRRw3Bgr2hbKey64ERTswQGxFUFEFU2dc=;
        b=nzx2PMc38T3oLKAoiUSLaGDR4jwQOig+crvEp3qo1xn7VLle3rfWu2FlXpgsvT+YYP
         AkqDVddC/OErkPwyLEt1xsV7EJ6wp6VknNDmv8mh19WUP90GRDaw9HZZFcGDG6G6nyTU
         rtYX4ohpF3T/0mO2kkcrEF4E+SCUQXHqseWnToH4LNnmxi9Wlbx+MsRbt+7LXMdJrNt5
         +fsqmRym0cwiXlYyj0CEJxL9RPR39lT7iDIeNtXaLFdWO1+NgX/SmYNMsX2Kk3Mjv63o
         N7UYYQvIGkHD5Dd/1BcO8xtsyN8MUxCTPwTSGPdf0iZegartpYDX06U7wwu8UTj5gqjZ
         v0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WrkHF6VXC/KRRw3Bgr2hbKey64ERTswQGxFUFEFU2dc=;
        b=HTbrV8Nr6gix7b5Bv/OQvUpm6tzRvXVsZidZPW5yVfalaqfZ/Wl6u/7i0+XqD8FbfQ
         JhhpZ8vQPtW2smyG8LigUV5yMMcs+s3M2a6I/9s1nBnNlY05yxchfAXgehKsfiYt85s7
         P97Kujt9wM15oG66xK2d0PFxyx4WgI2M/wDfz6YW+/fmeLHvKwSaNYISYoxQBhOYekfB
         06Q1/8JZYfYbwDBphFT87oniyzdY4svFKX01bqJSpTsO+OX1y52DCJbArHMMdmmF+bBM
         l12tF6gnw03Y8nLTwyxo8YxLSD74TM1vio/CP0nZOaEx/aDatKudMOinfJ0km6TP3nWy
         tZ8Q==
X-Gm-Message-State: APjAAAWHbJsYRbwXqpuDZ6MHUwDkRKl0+KrBrrzIBe/4lf+b1zxsMS/H
        A5VS2T+MgSMkxsi3S4CC9SbZF8L7
X-Google-Smtp-Source: APXvYqx77vbxfOaRWB1L2Aw0UQEG0aIdIaYp/gwn2xEj9bNhel3s+436sRPcrTcEQ/MKtIWeSzo+DA==
X-Received: by 2002:a65:4907:: with SMTP id p7mr6879071pgs.429.1571354231630;
        Thu, 17 Oct 2019 16:17:11 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id c16sm3884719pja.2.2019.10.17.16.17.11
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 16:17:11 -0700 (PDT)
Date:   Thu, 17 Oct 2019 16:17:09 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 07/12] t5520: replace test -{n,z} with test-lib functions
Message-ID: <d6b74c5e58d9a45ca8b915ba699cafe08f300723.1571354136.git.liu.denton@gmail.com>
References: <cover.1571354136.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571354136.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using `test -n` or `test -z`, replace them respectively with
invocations of test_file_not_empty() and test_must_be_empty().

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 9452779f40..c7797b13e6 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -206,15 +206,18 @@ test_expect_success 'fail if the index has unresolved entries' '
 	test_when_finished "git checkout -f copy && git branch -D third" &&
 	test "$(cat file)" = file &&
 	test_commit modified2 file &&
-	test -z "$(git ls-files -u)" &&
+	git ls-files -u >unmerged &&
+	test_must_be_empty unmerged &&
 	test_must_fail git pull . second &&
-	test -n "$(git ls-files -u)" &&
+	git ls-files -u >unmerged &&
+	test_file_not_empty unmerged &&
 	cp file expected &&
 	test_must_fail git pull . second 2>err &&
 	test_i18ngrep "Pulling is not possible because you have unmerged files." err &&
 	test_cmp expected file &&
 	git add file &&
-	test -z "$(git ls-files -u)" &&
+	git ls-files -u >unmerged &&
+	test_must_be_empty unmerged &&
 	test_must_fail git pull . second 2>err &&
 	test_i18ngrep "You have not concluded your merge" err &&
 	test_cmp expected file
@@ -667,7 +670,8 @@ test_expect_success 'git pull --rebase detects upstreamed changes' '
 	(
 		cd dst &&
 		git pull --rebase &&
-		test -z "$(git ls-files -u)"
+		git ls-files -u >untracked &&
+		test_must_be_empty untracked
 	)
 '
 
-- 
2.23.0.897.g0a19638b1e


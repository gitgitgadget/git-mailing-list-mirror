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
	by dcvr.yhbt.net (Postfix) with ESMTP id 214401F454
	for <e@80x24.org>; Thu,  7 Nov 2019 18:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfKGSvc (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 13:51:32 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39148 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbfKGSvc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 13:51:32 -0500
Received: by mail-pl1-f195.google.com with SMTP id o9so2134734plk.6
        for <git@vger.kernel.org>; Thu, 07 Nov 2019 10:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3RW7Tw+dMgeqif8ZNQJXPA0boz1zuyGvTDN3T6nZgzU=;
        b=cQH2XGmWmX2IRgPd87bLjDZtfyduZCyWysD95mfG91oVwIsqvc7nvgHwqG+YKNZHfY
         3mS42UlJm+K8mf1R05Fp2kUlo3X3YJki4Qt7l58q1ybeCvcPs8ib8QKu2y005pFuY6jK
         AQMKLTxUhXtVOMjEpC2bBqHr/I2CIhU+NzelmoPIdwF4ppwzNrpY+oqiNejwPDg9UJ69
         wgxuMYwUeDnRFRo3hb5V6fGL2XM+fzMmO1pYTlo6i1ZBxTNBglBB04kY8BF1wzL7EvU9
         gcx6OWUb4gKbDAXviZhZG5C3Wk+pAbFmkvjsIE2z0kaQucfGtE0dn6CJz6hmLNzwBm1X
         XN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3RW7Tw+dMgeqif8ZNQJXPA0boz1zuyGvTDN3T6nZgzU=;
        b=Ktpat+/NS1emIyoKdPY/YiL99idwQQuT/E9ZJcSj/ciJK1fLB8phcACp50X+QdC2xp
         slBELbNQT4KUD3wBIcvU43AXXAIb5o0JFTpTj44oweVraVNN/VqtiCJDt9n8eRYLlyPh
         +6Q1FQT2ahhWAhd65RKIugZ87/qVKV0tx7/UnjowDQLFbaeyM0Na47v/SpEo9QeM+z8Y
         Y/DXXeMVz+4BVjKor4j7hH7wNWoZdPlEzhSictskbXv8+S7nsjK1spygVei0yey9QAqo
         hx56LhH/pUyqA2KP6T3pAOdsTxgXgEcn1MSaOl1RVV5rQ+lp2y2OfjsCtJGE6gAq2mMp
         vcYg==
X-Gm-Message-State: APjAAAXfabGhCbLyFF+gu60c+cDN9oervNtAs9pR72URCeoR6R7/X8Fp
        C7XU45dtU48OTwoTGOJ9Ru59X8xF
X-Google-Smtp-Source: APXvYqwD6bxGSrVgBhdoOZulV4Vc3r22t65CRHC4w7yyUksazvrx2zkdXUQnGyMSlOg0Fv58dkMJKg==
X-Received: by 2002:a17:90a:5895:: with SMTP id j21mr7340377pji.129.1573152691069;
        Thu, 07 Nov 2019 10:51:31 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id g14sm3480270pgp.32.2019.11.07.10.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 10:51:30 -0800 (PST)
Date:   Thu, 7 Nov 2019 10:51:28 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 05/14] t5520: replace test -f with test-lib functions
Message-ID: <2af85e39133cde036fe1ccd1ed417cdeb3113a64.1573152599.git.liu.denton@gmail.com>
References: <cover.1571739459.git.liu.denton@gmail.com>
 <cover.1573152598.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573152598.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Although `test -f` has the same functionality as test_path_is_file(), in
the case where test_path_is_file() fails, we get much better debugging
information.

Replace `test -f` with test_path_is_file() so that future developers
will have a better experience debugging these test cases.

Also, in the case of `! test -f`, not only should that path not be a
file, it shouldn't exist at all so replace it with
test_path_is_missing().

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 55560ce3cd..004d5884cd 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -39,8 +39,8 @@ test_expect_success 'pulling into void' '
 		cd cloned &&
 		git pull ..
 	) &&
-	test -f file &&
-	test -f cloned/file &&
+	test_path_is_file file &&
+	test_path_is_file cloned/file &&
 	test_cmp file cloned/file
 '
 
@@ -50,8 +50,8 @@ test_expect_success 'pulling into void using master:master' '
 		cd cloned-uho &&
 		git pull .. master:master
 	) &&
-	test -f file &&
-	test -f cloned-uho/file &&
+	test_path_is_file file &&
+	test_path_is_file cloned-uho/file &&
 	test_cmp file cloned-uho/file
 '
 
@@ -99,7 +99,7 @@ test_expect_success 'pulling into void must not create an octopus' '
 	(
 		cd cloned-octopus &&
 		test_must_fail git pull .. master master &&
-		! test -f file
+		test_path_is_missing file
 	)
 '
 
-- 
2.24.0.rc2.262.g2d07a97ef5


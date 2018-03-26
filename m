Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1839B1F404
	for <e@80x24.org>; Mon, 26 Mar 2018 01:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751116AbeCZBOh (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 21:14:37 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42373 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751087AbeCZBOh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 21:14:37 -0400
Received: by mail-pf0-f193.google.com with SMTP id a16so6902620pfn.9
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 18:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0Q6GDGMc2/zJpSqaFom+33YBPSEU6FxLrBVHCieMHlE=;
        b=SMuMMGsZwknSMBC94FDp3LBeI0DA+gbMeQ2xdu9aaJ1252oKN09/B8qNHHmu8oLqxy
         8iUsCbJwI2TqPK3vQblDd1eK9jV+L1njAhB55Sy7xuPpnn/Wr1ltn1blClvtlItz8LjZ
         AR1vf35V1yrIKwoTzasJQ1rkkQBC5S7Rc12Oh3YyOTa/P/uTDen2+1kWnL8C981iAuUy
         71U51G6YxTa8EybFD/SNlWWDsRkg9k8DEhSKU5fQqCZBO0q9vd1MgXJaSU9I3KcpCfyL
         fOVmx4LHHTFWxsk3lRh0Va99DCns+bmLRl9+WVfTie8w3eeerqeHHiqJxopPRpZIoz+g
         zWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0Q6GDGMc2/zJpSqaFom+33YBPSEU6FxLrBVHCieMHlE=;
        b=KH++PLtj0D1exakKEbJ/6OThdEJeupn6+4Ds5sEpJZA2bR4Ts2ENuBhpGThpDNKdZG
         Y6JtB/E1YCxODGnYj7AofNfOXuJ0NaelYmoB4+P6DIHQToJQILYrRyGUmIcTr+0o7MeG
         q3X/qWqAEb6raJoVI0DIbY35csO07lBgCIx/BQ53y3YgJsR/JWwh9bxBd7g8J9TmGyQW
         o1UE9YCAepZVwrGgWRBRCiFj27mc9aBikhhPytM94lqpWD/+0Z5fLMzQLYloYujP6lZ4
         Q3lEKQR34rhkpsJdnYP/0Q4qshUmzxfqRuPGFMn4bgqb0SD2OL05/IyN75GqHKaXfQI1
         998g==
X-Gm-Message-State: AElRT7F23OZtpeE1WOGA8Qb3uFTv4NAWo/m27tsJOTiNEbz1a5ADuihk
        9DHHlqxB5Bnh6HNZTFimp2LJIkQ=
X-Google-Smtp-Source: AG47ELvp9CXzROPLI4s6odY1hGsDaH8l4c0tKSiaAAk+mDRUZh/JUF0Q9N0atZhJOn/7NukMXM8cEw==
X-Received: by 10.99.176.12 with SMTP id h12mr11782406pgf.448.1522026876365;
        Sun, 25 Mar 2018 18:14:36 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id k70sm18664894pga.72.2018.03.25.18.14.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Mar 2018 18:14:35 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH v2 1/6] stash: Add tests for passing in too many refs
Date:   Sun, 25 Mar 2018 18:14:21 -0700
Message-Id: <20180326011426.19159-2-joel@teichroeb.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180326011426.19159-1-joel@teichroeb.net>
References: <20180326011426.19159-1-joel@teichroeb.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
---
 t/t3903-stash.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index aefde7b172..7146e27bb5 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -45,6 +45,12 @@ test_expect_success 'applying bogus stash does nothing' '
 	test_cmp expect file
 '
 
+test_expect_success 'applying with too many agruments does nothing' '
+	test_must_fail git stash apply stash@{0} bar &&
+	echo 1 >expect &&
+	test_cmp expect file
+'
+
 test_expect_success 'apply does not need clean working directory' '
 	echo 4 >other-file &&
 	git stash apply &&
@@ -97,6 +103,10 @@ test_expect_success 'stash drop complains of extra options' '
 	test_must_fail git stash drop --foo
 '
 
+test_expect_success 'stash drop complains with too many refs' '
+	test_must_fail git stash drop stash@{1} stash@{2}
+'
+
 test_expect_success 'drop top stash' '
 	git reset --hard &&
 	git stash list > stashlist1 &&
@@ -160,6 +170,10 @@ test_expect_success 'stash pop' '
 	test 0 = $(git stash list | wc -l)
 '
 
+test_expect_success 'stash pop complains with too many refs' '
+	test_must_fail git stash pop stash@{1} stash@{2}
+'
+
 cat > expect << EOF
 diff --git a/file2 b/file2
 new file mode 100644
@@ -479,6 +493,10 @@ test_expect_success 'stash branch - stashes on stack, stash-like argument' '
 	test $(git ls-files --modified | wc -l) -eq 1
 '
 
+test_expect_success 'stash branch complains with too many refs' '
+	test_must_fail git stash branch stash-branch stash@{1} stash@{2}
+'
+
 test_expect_success 'stash show format defaults to --stat' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
@@ -567,6 +585,10 @@ test_expect_success 'stash show -p - no stashes on stack, stash-like argument' '
 	test_cmp expected actual
 '
 
+test_expect_success 'stash show complains with too many refs' '
+	test_must_fail git stash show stash@{1} stash@{2}
+'
+
 test_expect_success 'stash drop - fail early if specified stash is not a stash reference' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD && git stash clear" &&
-- 
2.16.2


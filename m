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
	by dcvr.yhbt.net (Postfix) with ESMTP id 94BAC1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 18:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfKLS40 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 13:56:26 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33280 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfKLS40 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 13:56:26 -0500
Received: by mail-pg1-f196.google.com with SMTP id h27so12472820pgn.0
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 10:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zu/OAik5fEp2dcLHEX1cIK20xQgwfjqc6swcI7JZ9RU=;
        b=V8vXrFpHoH+keWPA4fkddlUI4zdyWfst96aWSulcD1zjUrRuA+aBL3KXyRFoVa8gtE
         +94lQYbRnq3Wuv5BuuK4jZP+ySCn5+AIsks1kSR6ypgwbf/Wk4DBgESMQd0CbMFRyT4D
         vFG7EIs6SEpnE2b+9l5eFTIcySU/UYbFZQPtgT+mDkLD1Jf05aA4dhU+oRedaT/yCJIN
         TCnpjWHLus6NgETswzdHB27EDN6BH47BznKJJwgkSg05YB6jeU6jbDR+XH9/rGa0lFJC
         uSMO4G/gGgazaVuzx35eNod5H31PDIEypdsjFejNlSpNsNOPwohn5YR/7FPMUDOcc/mo
         AKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zu/OAik5fEp2dcLHEX1cIK20xQgwfjqc6swcI7JZ9RU=;
        b=UcPk47s88Tuz/2aMnz/Y8webZJTob5SckLrhg8/G7CsT75HrOLF+inrG2KFhWRGyJw
         vEp5a4I2YasN1oV3rWQaq/Q6TPHCpcYcFlWSS9wsTud8JNL3h0r098Xw+YAm2h4CI8mi
         4jMH+iMl9yrBTBJMaX0Zk6tzRpsYup/jfEd/tFQUHz/8yeKR67IFi6urydiU2Zrej5Ri
         zSdpy5J789TtWe8Hz4PuYX9eUZqOfqjDidz2CwyBQ3apyiQqy9Pak/LiZ0VnyXvamqzC
         b4a9GqOdt/UqLYo+vkTTi2+XtzOa62Kb607EtJQCAf9Jey1kBM5ILhZF3PLKYKCLgq3L
         npiQ==
X-Gm-Message-State: APjAAAUdDjR+S+6Dcw2WCSAbtoo1w95Qag/yT3bme37GYHn3yY8/umZY
        +gLMmJka4nOlWvyPy55jiGIboyzR
X-Google-Smtp-Source: APXvYqwY0FWVjKoNA2uCpIlWYD9L2cU+wdEsa+kZ7moCVnh7W+PuOtgTe1zUZBlNyGALgq7z3z8Gow==
X-Received: by 2002:aa7:9358:: with SMTP id 24mr38462942pfn.195.1573584985025;
        Tue, 12 Nov 2019 10:56:25 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id y24sm21965277pfr.116.2019.11.12.10.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 10:56:24 -0800 (PST)
Date:   Tue, 12 Nov 2019 10:56:22 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     James Coglan <jcoglan@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v3] t4215: use helper function to check output
Message-ID: <86af5739a4e5f5f38b2597a86d03d5501ad5468b.1573584933.git.liu.denton@gmail.com>
References: <8e950ddfba3fa0f6d0551a153228548da6af6117.1573520653.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e950ddfba3fa0f6d0551a153228548da6af6117.1573520653.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When git commands are placed in the upstream of a pipe, their return
codes are lost. In this particular case, it is especially bad since we
are testing the intricacies of `git log --graph` behavior and if we hit
an unexpected failure or segfault, we want to know this.

Extract the common output checking logic into check_graph() where we
redirect the output of git commands upstream of pipe into a file and
have sed read from that file so that git failures are detected.

This patch is best viewed with `--color-moved`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
Thanks for the feedback, everyone. I decided to take Gábor's suggestion
and write the check_graph() helper function.

Unfortunately, even though in practice I was moving the here-doc lines
down, the diff shows up as me moving the commit and checkout lines up
and this might affect how the blame ends up looking. Is there any way to
force git to make the diff show up the other way in both this diff and
in the blame or is this the best that we can do?

Thanks!

 t/t4215-log-skewed-merges.sh | 208 ++++++++++++++++-------------------
 1 file changed, 97 insertions(+), 111 deletions(-)

diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
index d33c6438d8..18709a723e 100755
--- a/t/t4215-log-skewed-merges.sh
+++ b/t/t4215-log-skewed-merges.sh
@@ -4,8 +4,25 @@ test_description='git log --graph of skewed merges'
 
 . ./test-lib.sh
 
+check_graph () {
+	cat >expect &&
+	git log --graph --pretty=tformat:%s "$@" >actual.raw &&
+	sed "s/ *$//" actual.raw >actual &&
+	test_cmp expect actual
+}
+
 test_expect_success 'log --graph with merge fusing with its left and right neighbors' '
-	cat >expect <<-\EOF &&
+	git checkout --orphan _p &&
+	test_commit A &&
+	test_commit B &&
+	git checkout -b _q @^ && test_commit C &&
+	git checkout -b _r @^ && test_commit D &&
+	git checkout _p && git merge --no-ff _q _r -m E &&
+	git checkout _r && test_commit F &&
+	git checkout _p && git merge --no-ff _r -m G &&
+	git checkout @^^ && git merge --no-ff _p -m H &&
+
+	check_graph <<-\EOF
 	*   H
 	|\
 	| *   G
@@ -20,23 +37,20 @@ test_expect_success 'log --graph with merge fusing with its left and right neigh
 	|/
 	* A
 	EOF
-
-	git checkout --orphan _p &&
-	test_commit A &&
-	test_commit B &&
-	git checkout -b _q @^ && test_commit C &&
-	git checkout -b _r @^ && test_commit D &&
-	git checkout _p && git merge --no-ff _q _r -m E &&
-	git checkout _r && test_commit F &&
-	git checkout _p && git merge --no-ff _r -m G &&
-	git checkout @^^ && git merge --no-ff _p -m H &&
-
-	git log --graph --pretty=tformat:%s | sed "s/ *$//" >actual &&
-	test_cmp expect actual
 '
 
 test_expect_success 'log --graph with left-skewed merge' '
-	cat >expect <<-\EOF &&
+	git checkout --orphan 0_p && test_commit 0_A &&
+	git checkout -b 0_q 0_p && test_commit 0_B &&
+	git checkout -b 0_r 0_p &&
+	test_commit 0_C &&
+	test_commit 0_D &&
+	git checkout -b 0_s 0_p && test_commit 0_E &&
+	git checkout -b 0_t 0_p && git merge --no-ff 0_r^ 0_s -m 0_F &&
+	git checkout 0_p && git merge --no-ff 0_s -m 0_G &&
+	git checkout @^ && git merge --no-ff 0_q 0_r 0_t 0_p -m 0_H &&
+
+	check_graph <<-\EOF
 	*-----.   0_H
 	|\ \ \ \
 	| | | | * 0_G
@@ -57,23 +71,20 @@ test_expect_success 'log --graph with left-skewed merge' '
 	|/
 	* 0_A
 	EOF
-
-	git checkout --orphan 0_p && test_commit 0_A &&
-	git checkout -b 0_q 0_p && test_commit 0_B &&
-	git checkout -b 0_r 0_p &&
-	test_commit 0_C &&
-	test_commit 0_D &&
-	git checkout -b 0_s 0_p && test_commit 0_E &&
-	git checkout -b 0_t 0_p && git merge --no-ff 0_r^ 0_s -m 0_F &&
-	git checkout 0_p && git merge --no-ff 0_s -m 0_G &&
-	git checkout @^ && git merge --no-ff 0_q 0_r 0_t 0_p -m 0_H &&
-
-	git log --graph --pretty=tformat:%s | sed "s/ *$//" >actual &&
-	test_cmp expect actual
 '
 
 test_expect_success 'log --graph with nested left-skewed merge' '
-	cat >expect <<-\EOF &&
+	git checkout --orphan 1_p &&
+	test_commit 1_A &&
+	test_commit 1_B &&
+	test_commit 1_C &&
+	git checkout -b 1_q @^ && test_commit 1_D &&
+	git checkout 1_p && git merge --no-ff 1_q -m 1_E &&
+	git checkout -b 1_r @~3 && test_commit 1_F &&
+	git checkout 1_p && git merge --no-ff 1_r -m 1_G &&
+	git checkout @^^ && git merge --no-ff 1_p -m 1_H &&
+
+	check_graph <<-\EOF
 	*   1_H
 	|\
 	| *   1_G
@@ -88,23 +99,24 @@ test_expect_success 'log --graph with nested left-skewed merge' '
 	|/
 	* 1_A
 	EOF
-
-	git checkout --orphan 1_p &&
-	test_commit 1_A &&
-	test_commit 1_B &&
-	test_commit 1_C &&
-	git checkout -b 1_q @^ && test_commit 1_D &&
-	git checkout 1_p && git merge --no-ff 1_q -m 1_E &&
-	git checkout -b 1_r @~3 && test_commit 1_F &&
-	git checkout 1_p && git merge --no-ff 1_r -m 1_G &&
-	git checkout @^^ && git merge --no-ff 1_p -m 1_H &&
-
-	git log --graph --pretty=tformat:%s | sed "s/ *$//" >actual &&
-	test_cmp expect actual
 '
 
 test_expect_success 'log --graph with nested left-skewed merge following normal merge' '
-	cat >expect <<-\EOF &&
+	git checkout --orphan 2_p &&
+	test_commit 2_A &&
+	test_commit 2_B &&
+	test_commit 2_C &&
+	git checkout -b 2_q @^^ &&
+	test_commit 2_D &&
+	test_commit 2_E &&
+	git checkout -b 2_r @^ && test_commit 2_F &&
+	git checkout 2_q &&
+	git merge --no-ff 2_r -m 2_G &&
+	git merge --no-ff 2_p^ -m 2_H &&
+	git checkout -b 2_s @^^ && git merge --no-ff 2_q -m 2_J &&
+	git checkout 2_p && git merge --no-ff 2_s -m 2_K &&
+
+	check_graph <<-\EOF
 	*   2_K
 	|\
 	| *   2_J
@@ -124,27 +136,23 @@ test_expect_success 'log --graph with nested left-skewed merge following normal
 	|/
 	* 2_A
 	EOF
-
-	git checkout --orphan 2_p &&
-	test_commit 2_A &&
-	test_commit 2_B &&
-	test_commit 2_C &&
-	git checkout -b 2_q @^^ &&
-	test_commit 2_D &&
-	test_commit 2_E &&
-	git checkout -b 2_r @^ && test_commit 2_F &&
-	git checkout 2_q &&
-	git merge --no-ff 2_r -m 2_G &&
-	git merge --no-ff 2_p^ -m 2_H &&
-	git checkout -b 2_s @^^ && git merge --no-ff 2_q -m 2_J &&
-	git checkout 2_p && git merge --no-ff 2_s -m 2_K &&
-
-	git log --graph --pretty=tformat:%s | sed "s/ *$//" >actual &&
-	test_cmp expect actual
 '
 
 test_expect_success 'log --graph with nested right-skewed merge following left-skewed merge' '
-	cat >expect <<-\EOF &&
+	git checkout --orphan 3_p &&
+	test_commit 3_A &&
+	git checkout -b 3_q &&
+	test_commit 3_B &&
+	test_commit 3_C &&
+	git checkout -b 3_r @^ &&
+	test_commit 3_D &&
+	git checkout 3_q && git merge --no-ff 3_r -m 3_E &&
+	git checkout 3_p && git merge --no-ff 3_q -m 3_F &&
+	git checkout 3_r && test_commit 3_G &&
+	git checkout 3_p && git merge --no-ff 3_r -m 3_H &&
+	git checkout @^^ && git merge --no-ff 3_p -m 3_J &&
+
+	check_graph <<-\EOF
 	*   3_J
 	|\
 	| *   3_H
@@ -161,26 +169,21 @@ test_expect_success 'log --graph with nested right-skewed merge following left-s
 	|/
 	* 3_A
 	EOF
-
-	git checkout --orphan 3_p &&
-	test_commit 3_A &&
-	git checkout -b 3_q &&
-	test_commit 3_B &&
-	test_commit 3_C &&
-	git checkout -b 3_r @^ &&
-	test_commit 3_D &&
-	git checkout 3_q && git merge --no-ff 3_r -m 3_E &&
-	git checkout 3_p && git merge --no-ff 3_q -m 3_F &&
-	git checkout 3_r && test_commit 3_G &&
-	git checkout 3_p && git merge --no-ff 3_r -m 3_H &&
-	git checkout @^^ && git merge --no-ff 3_p -m 3_J &&
-
-	git log --graph --pretty=tformat:%s | sed "s/ *$//" >actual &&
-	test_cmp expect actual
 '
 
 test_expect_success 'log --graph with right-skewed merge following a left-skewed one' '
-	cat >expect <<-\EOF &&
+	git checkout --orphan 4_p &&
+	test_commit 4_A &&
+	test_commit 4_B &&
+	test_commit 4_C &&
+	git checkout -b 4_q @^^ && test_commit 4_D &&
+	git checkout -b 4_r 4_p^ && git merge --no-ff 4_q -m 4_E &&
+	git checkout -b 4_s 4_p^^ &&
+	git merge --no-ff 4_r -m 4_F &&
+	git merge --no-ff 4_p -m 4_G &&
+	git checkout @^^ && git merge --no-ff 4_s -m 4_H &&
+
+	check_graph --date-order <<-\EOF
 	*   4_H
 	|\
 	| *   4_G
@@ -198,24 +201,25 @@ test_expect_success 'log --graph with right-skewed merge following a left-skewed
 	|/
 	* 4_A
 	EOF
-
-	git checkout --orphan 4_p &&
-	test_commit 4_A &&
-	test_commit 4_B &&
-	test_commit 4_C &&
-	git checkout -b 4_q @^^ && test_commit 4_D &&
-	git checkout -b 4_r 4_p^ && git merge --no-ff 4_q -m 4_E &&
-	git checkout -b 4_s 4_p^^ &&
-	git merge --no-ff 4_r -m 4_F &&
-	git merge --no-ff 4_p -m 4_G &&
-	git checkout @^^ && git merge --no-ff 4_s -m 4_H &&
-
-	git log --graph --date-order --pretty=tformat:%s | sed "s/ *$//" >actual &&
-	test_cmp expect actual
 '
 
 test_expect_success 'log --graph with octopus merge with column joining its penultimate parent' '
-	cat >expect <<-\EOF &&
+	git checkout --orphan 5_p &&
+	test_commit 5_A &&
+	git branch 5_q &&
+	git branch 5_r &&
+	test_commit 5_B &&
+	git checkout 5_q && test_commit 5_C &&
+	git checkout 5_r && test_commit 5_D &&
+	git checkout 5_p &&
+	git merge --no-ff 5_q 5_r -m 5_E &&
+	git checkout 5_q && test_commit 5_F &&
+	git checkout -b 5_s 5_p^ &&
+	git merge --no-ff 5_p 5_q -m 5_G &&
+	git checkout 5_r &&
+	git merge --no-ff 5_s -m 5_H &&
+
+	check_graph <<-\EOF
 	*   5_H
 	|\
 	| *-.   5_G
@@ -234,24 +238,6 @@ test_expect_success 'log --graph with octopus merge with column joining its penu
 	|/
 	* 5_A
 	EOF
-
-	git checkout --orphan 5_p &&
-	test_commit 5_A &&
-	git branch 5_q &&
-	git branch 5_r &&
-	test_commit 5_B &&
-	git checkout 5_q && test_commit 5_C &&
-	git checkout 5_r && test_commit 5_D &&
-	git checkout 5_p &&
-	git merge --no-ff 5_q 5_r -m 5_E &&
-	git checkout 5_q && test_commit 5_F &&
-	git checkout -b 5_s 5_p^ &&
-	git merge --no-ff 5_p 5_q -m 5_G &&
-	git checkout 5_r &&
-	git merge --no-ff 5_s -m 5_H &&
-
-	git log --graph --pretty=tformat:%s | sed "s/ *$//" >actual &&
-	test_cmp expect actual
 '
 
 test_done
-- 
2.24.0.300.g722ba42680


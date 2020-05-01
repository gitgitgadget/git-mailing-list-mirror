Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B22FC4724C
	for <git@archiver.kernel.org>; Fri,  1 May 2020 14:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FD79208DB
	for <git@archiver.kernel.org>; Fri,  1 May 2020 14:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRs645ol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgEAOXK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 10:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728840AbgEAOXK (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 1 May 2020 10:23:10 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4D7C061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 07:23:09 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e8so4572113ilm.7
        for <git@vger.kernel.org>; Fri, 01 May 2020 07:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c2dEPMlDWowMCPw4kY51qxwQFcB6LjQXVS/KnbRNIPc=;
        b=BRs645ologsaU1fUxP4oEWAx4VkcB3GU7LtJviAqWRMdx7WhcbQ8WNdz+Fqu0sc7ZR
         3W6Z4fIyBqaGLFM4GxDq5gndduGkLvbWnkGrsEOrAIYNtlJCeVc1rMeimSC+lO3C6NEV
         6EdiXBLopTBEuaXcs8zhe+heH4oeuwQP3LuxXsHt508ekpX0+MjvZjOZcjjgCkMhPQrh
         DO/RTtNs+73GH6YMIdOqfCtoAqt9c5Thaeb0V6T/cQmlHbwt5UyjKJCe/Zq+LvQo91cU
         tFg0+RmWcPGvFQp7ZnNzVrBT+Jzyyri0ACjhMpnMHrNbTW2+FHjCxTk76LmZggdxZKGJ
         4nqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c2dEPMlDWowMCPw4kY51qxwQFcB6LjQXVS/KnbRNIPc=;
        b=lZu9SQE3Z3a1R5XSs5w5T9VwF1nEybga5FNZAS5n7Kts6wJukqWH06HZvrr3DQnwOi
         awWDcAK0oEadqpmqs9jY+vFRiKKpeQdIbAs5xXnNAGM64yKxcMnMkngueFUoOYt9Mnrv
         CmsthVKo2OedqI5fVwHcZSFlAcU23s54bv/Uf34yKY3I5sFoqzYIe4TAVtkTZEipgrRp
         etDZk4/U2vXkWh7qG4QNOgSKdURDHt1GatWCFZ9QOcwq3laUu4DVLXs2gOBm30wbN/M1
         QYb/C3E4x40OVzGeRWQ3PwgiRd1PntMBFKFL3Uu+19EZuBWI9y+5Xi+9/F83TWTzpHwe
         WLxA==
X-Gm-Message-State: AGi0PuYWdTMLVxO4l/aDtLoKiAvKxkZGVIPlQg59e2ON5WeZbJFi74R+
        rpUY/CVzfWzqyXqa2GrtPvhyEtlY
X-Google-Smtp-Source: APiQypKErSGcSCHm+9FSX+fVWUTmxZtFL0ix0yzSU7l7g7TgdGbmAzk0zRa5gKIAQW6w6BaAupbJbg==
X-Received: by 2002:a92:760f:: with SMTP id r15mr3856118ilc.202.1588342989006;
        Fri, 01 May 2020 07:23:09 -0700 (PDT)
Received: from ?IPv6:2601:8c0:37f:6012:e01d:d556:c354:b051? ([2601:8c0:37f:6012:e01d:d556:c354:b051])
        by smtp.gmail.com with ESMTPSA id u21sm998544iot.5.2020.05.01.07.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 07:23:08 -0700 (PDT)
Subject: [PATCH 3/3 v3] Add new tests of ignore-merge-bases
From:   Antonio Russo <antonio.e.russo@gmail.com>
To:     git-ml <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Derrick Stolee <dstolee@microsoft.com>
References: <df0b9e59-e6d7-8839-ca3b-86145dc3bdf3@gmail.com>
 <d3079ba8-33e1-3b68-23d2-ea97b9ca1e97@gmail.com>
Message-ID: <c8fb7235-1dd4-ff2c-bae4-0fb83187c155@gmail.com>
Date:   Fri, 1 May 2020 08:23:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d3079ba8-33e1-3b68-23d2-ea97b9ca1e97@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend t4215 and t6016 to also use --ignore-merge-bases on their test
cases.

Add the new test case t4216-log-merges, with three tests: a standard
feature merge, a "twisted" feature merge, and the motivating case for
ignore-merge-bases: a "mountain" of merges.

Signed-off-by: Antonio Russo <antonio.e.russo@gmail.com>
---
 t/t4215-log-skewed-merges.sh               | 165 +++++++++++++
 t/t4216-log-merges.sh                      | 273 +++++++++++++++++++++
 t/t6016-rev-list-graph-simplify-history.sh |  69 ++++++
 3 files changed, 507 insertions(+)
 create mode 100755 t/t4216-log-merges.sh

diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
index 28d0779a8c..fb5df1a323 100755
--- a/t/t4215-log-skewed-merges.sh
+++ b/t/t4215-log-skewed-merges.sh
@@ -38,6 +38,22 @@ test_expect_success 'log --graph with merge fusing with its left and right neigh
 	EOF
 '

+test_expect_success 'log --graph with merge fusing with its left and right neighbors (ignore-merge-bases)' '
+	check_graph --ignore-merge-bases <<-\EOF
+	*   H
+	|\
+	| *   G
+	| |\
+	| | * F
+	| *   E
+	| |\
+	| | * D
+	| * C
+	* B
+	* A
+	EOF
+'
+
 test_expect_success 'log --graph with left-skewed merge' '
 	git checkout --orphan 0_p && test_commit 0_A &&
 	git checkout -b 0_q 0_p && test_commit 0_B &&
@@ -72,6 +88,20 @@ test_expect_success 'log --graph with left-skewed merge' '
 	EOF
 '

+test_expect_success 'log --graph with left-skewed merge (ignore-merge-bases)' '
+	check_graph --ignore-merge-bases <<-\EOF
+	*-----.   0_H
+	|\ \ \ \
+	| | | | * 0_G
+	| | | * 0_F
+	| | | * 0_E
+	| | * 0_D
+	| | * 0_C
+	| * 0_B
+	* 0_A
+	EOF
+'
+
 test_expect_success 'log --graph with nested left-skewed merge' '
 	git checkout --orphan 1_p &&
 	test_commit 1_A &&
@@ -100,6 +130,21 @@ test_expect_success 'log --graph with nested left-skewed merge' '
 	EOF
 '

+test_expect_success 'log --graph with nested left-skewed merge (ignore-merge-bases)' '
+	check_graph --ignore-merge-bases<<-\EOF
+	*   1_H
+	|\
+	| *   1_G
+	| |\
+	| | * 1_F
+	| * 1_E
+	| * 1_D
+	* 1_C
+	* 1_B
+	* 1_A
+	EOF
+'
+
 test_expect_success 'log --graph with nested left-skewed merge following normal merge' '
 	git checkout --orphan 2_p &&
 	test_commit 2_A &&
@@ -137,6 +182,23 @@ test_expect_success 'log --graph with nested left-skewed merge following normal
 	EOF
 '

+test_expect_success 'log --graph with nested left-skewed merge following normal merge (ignore-merge-bases)' '
+	check_graph --ignore-merge-bases<<-\EOF
+	*   2_K
+	|\
+	| *   2_J
+	| |\
+	| | * 2_H
+	| | * 2_G
+	| | * 2_F
+	| * 2_E
+	| * 2_D
+	* 2_C
+	* 2_B
+	* 2_A
+	EOF
+'
+
 test_expect_success 'log --graph with nested right-skewed merge following left-skewed merge' '
 	git checkout --orphan 3_p &&
 	test_commit 3_A &&
@@ -170,6 +232,23 @@ test_expect_success 'log --graph with nested right-skewed merge following left-s
 	EOF
 '

+test_expect_success 'log --graph with nested right-skewed merge following left-skewed merge (ignore-merge-bases)' '
+	check_graph --ignore-merge-bases<<-\EOF
+	*   3_J
+	|\
+	| *   3_H
+	| |\
+	| | * 3_G
+	| * 3_F
+	| *   3_E
+	| |\
+	| | * 3_D
+	| * 3_C
+	| * 3_B
+	* 3_A
+	EOF
+'
+
 test_expect_success 'log --graph with right-skewed merge following a left-skewed one' '
 	git checkout --orphan 4_p &&
 	test_commit 4_A &&
@@ -202,6 +281,23 @@ test_expect_success 'log --graph with right-skewed merge following a left-skewed
 	EOF
 '

+test_expect_success 'log --graph with right-skewed merge following a left-skewed one (ignore-merge-bases)' '
+	check_graph --date-order --ignore-merge-bases<<-\EOF
+	*   4_H
+	|\
+	| *   4_G
+	| |\
+	| * | 4_F
+	| * |   4_E
+	| |\ \
+	| | * | 4_D
+	| |  /
+	| | * 4_C
+	| * 4_B
+	* 4_A
+	EOF
+'
+
 test_expect_success 'log --graph with octopus merge with column joining its penultimate parent' '
 	git checkout --orphan 5_p &&
 	test_commit 5_A &&
@@ -239,6 +335,21 @@ test_expect_success 'log --graph with octopus merge with column joining its penu
 	EOF
 '

+test_expect_success 'log --graph with octopus merge with column joining its penultimate parent (ignore-merge-bases)' '
+	check_graph --ignore-merge-bases<<-\EOF
+	*   5_H
+	|\
+	| *-.   5_G
+	| |\ \
+	| | | * 5_F
+	| | * 5_E
+	| | * 5_C
+	| * 5_B
+	* 5_D
+	* 5_A
+	EOF
+'
+
 test_expect_success 'log --graph with multiple tips' '
 	git checkout --orphan 6_1 &&
 	test_commit 6_A &&
@@ -281,6 +392,27 @@ test_expect_success 'log --graph with multiple tips' '
 	EOF
 '

+test_expect_success 'log --graph with multiple tips (ignore-merge-bases)' '
+	check_graph --ignore-merge-bases 6_1 6_3 6_5 <<-\EOF
+	*   6_I
+	|\
+	| | *   6_H
+	| | |\
+	| | | * 6_G
+	| | * 6_E
+	| | | * 6_F
+	| |_|/|
+	|/| |/
+	| |/|
+	| * | 6_D
+	|  /
+	* / 6_C
+	|/
+	* 6_B
+	* 6_A
+	EOF
+'
+
 test_expect_success 'log --graph with multiple tips and colors' '
 	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
 	cat >expect.colors <<-\EOF &&
@@ -370,4 +502,37 @@ test_expect_success 'log --graph with multiple tips' '
 	EOF
 '

+test_expect_success 'log --graph with multiple tips (ignore-merge-bases)' '
+	check_graph --ignore-merge-bases M_1 M_3 M_5 M_7 <<-\EOF
+	*   7_M1
+	|\
+	| | *   7_M2
+	| | |\
+	| | | * 7_H
+	| | | | *   7_M3
+	| | | | |\
+	| | | | | * 7_J
+	| | | | * | 7_I
+	| | | | * | 7_A
+	| | | |  /
+	| | | | | *   7_M4
+	| |_|_|_|/|\
+	|/| | | |/ /
+	| | |_|/| /
+	| |/| | |/
+	| | | |/|
+	| | |/| |
+	| | * | | 7_G
+	| | | |/
+	| | |/|
+	| | * | 7_F
+	| |  /
+	| * / 7_E
+	| |/
+	| * 7_D
+	* 7_C
+	* 7_B
+	EOF
+'
+
 test_done
diff --git a/t/t4216-log-merges.sh b/t/t4216-log-merges.sh
new file mode 100755
index 0000000000..84b1973131
--- /dev/null
+++ b/t/t4216-log-merges.sh
@@ -0,0 +1,273 @@
+#!/bin/sh
+
+test_description='git log --graph of merges'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-log-graph.sh
+
+check_graph () {
+	cat >expect &&
+	lib_test_cmp_graph --format=%s "$@"
+}
+
+test_expect_success 'log --graph with merge pulling in a feature' '
+	git checkout --orphan _p && test_commit A &&
+	git checkout -b _q &&
+	git checkout _p && test_commit B &&
+	git checkout -b _r &&
+	git checkout _p && test_commit C &&
+	git checkout _r && test_commit F_1 &&
+	git checkout _q && test_commit F_2 &&
+	git checkout _r && git merge --no-ff _q -m M &&
+	git checkout _p && git merge --no-ff _r -m D &&
+
+	check_graph <<-\EOF
+	*   D
+	|\
+	| *   M
+	| |\
+	| | * F_2
+	| * | F_1
+	* | | C
+	|/ /
+	* / B
+	|/
+	* A
+	EOF
+'
+
+test_expect_success 'log --graph with merge pulling in a feature (ignore-merge-bases)' '
+	check_graph --ignore-merge-bases <<-\EOF
+	*   D
+	|\
+	| *   M
+	| |\
+	| | * F_2
+	| * F_1
+	* C
+	* B
+	* A
+	EOF
+'
+
+test_expect_success 'log --graph with twisted merge pulling in a feature from master' '
+	git checkout --orphan 0_p && test_commit 0_A &&
+	git checkout -b 0_q &&
+	git checkout 0_p && test_commit 0_B &&
+	git checkout -b 0_r &&
+	git checkout 0_p && test_commit 0_C &&
+	git checkout 0_q && test_commit 0_F1 && git merge --no-ff 0_r -m 0_M1 &&
+	git checkout 0_p && git merge --no-ff 0_q -m 0_M2 &&
+
+	check_graph <<-\EOF
+	*   0_M2
+	|\
+	| *   0_M1
+	| |\
+	| * | 0_F1
+	* | | 0_C
+	| |/
+	|/|
+	* | 0_B
+	|/
+	* 0_A
+	EOF
+'
+
+test_expect_success 'log --graph with twisted merge pulling in a feature from master (ignore-merge-bases)' '
+	check_graph --ignore-merge-bases <<-\EOF
+	*   0_M2
+	|\
+	| * 0_M1
+	| * 0_F1
+	* 0_C
+	* 0_B
+	* 0_A
+	EOF
+'
+
+test_expect_success 'log --graph with several merges' '
+	git checkout --orphan 1_p &&
+	test_commit 1_root &&
+	for m in $(test_seq 1 10) ;
+	do
+		git checkout -b 1_f${m} 1_root ;
+		test_commit 1_A${m} ;
+	done &&
+	for m in $(test_seq 1 10) ;
+	do
+		i=$((11 - $m)) ;
+		git merge --no-ff 1_f${i} -m 1_M${m}A${i} ;
+	done &&
+	for mp in $(test_seq 1 10) ;
+	do
+		m=$((11 - mp))
+		git checkout 1_f${m} ;
+		test_commit 1_B${m} ;
+		git checkout 1_p ;
+		git merge --no-ff 1_f${m} -m 1_M${m} ;
+	done &&
+
+	check_graph <<-\EOF
+	*   1_M1
+	|\
+	| * 1_B1
+	* |   1_M2
+	|\ \
+	| * | 1_B2
+	* | |   1_M3
+	|\ \ \
+	| * | | 1_B3
+	* | | |   1_M4
+	|\ \ \ \
+	| * | | | 1_B4
+	* | | | |   1_M5
+	|\ \ \ \ \
+	| * | | | | 1_B5
+	* | | | | |   1_M6
+	|\ \ \ \ \ \
+	| * | | | | | 1_B6
+	* | | | | | |   1_M7
+	|\ \ \ \ \ \ \
+	| * | | | | | | 1_B7
+	* | | | | | | |   1_M8
+	|\ \ \ \ \ \ \ \
+	| * | | | | | | | 1_B8
+	* | | | | | | | |   1_M9
+	|\ \ \ \ \ \ \ \ \
+	| * | | | | | | | | 1_B9
+	* | | | | | | | | |   1_M10
+	|\ \ \ \ \ \ \ \ \ \
+	| * | | | | | | | | | 1_B10
+	| * | | | | | | | | |   1_M10A1
+	| |\ \ \ \ \ \ \ \ \ \
+	| | | |_|_|_|_|_|_|_|/
+	| | |/| | | | | | | |
+	| | * | | | | | | | | 1_A1
+	| |/ / / / / / / / /
+	|/| | | | | | | | |
+	| * | | | | | | | |   1_M9A2
+	| |\ \ \ \ \ \ \ \ \
+	| | | |_|_|_|_|_|_|/
+	| | |/| | | | | | |
+	| | * | | | | | | | 1_A2
+	| |/ / / / / / / /
+	|/| | | | | | | |
+	| * | | | | | | |   1_M8A3
+	| |\ \ \ \ \ \ \ \
+	| | | |_|_|_|_|_|/
+	| | |/| | | | | |
+	| | * | | | | | | 1_A3
+	| |/ / / / / / /
+	|/| | | | | | |
+	| * | | | | | |   1_M7A4
+	| |\ \ \ \ \ \ \
+	| | | |_|_|_|_|/
+	| | |/| | | | |
+	| | * | | | | | 1_A4
+	| |/ / / / / /
+	|/| | | | | |
+	| * | | | | |   1_M6A5
+	| |\ \ \ \ \ \
+	| | | |_|_|_|/
+	| | |/| | | |
+	| | * | | | | 1_A5
+	| |/ / / / /
+	|/| | | | |
+	| * | | | |   1_M5A6
+	| |\ \ \ \ \
+	| | | |_|_|/
+	| | |/| | |
+	| | * | | | 1_A6
+	| |/ / / /
+	|/| | | |
+	| * | | |   1_M4A7
+	| |\ \ \ \
+	| | | |_|/
+	| | |/| |
+	| | * | | 1_A7
+	| |/ / /
+	|/| | |
+	| * | |   1_M3A8
+	| |\ \ \
+	| | | |/
+	| | |/|
+	| | * | 1_A8
+	| |/ /
+	|/| |
+	| * | 1_M2A9
+	| |\|
+	| | * 1_A9
+	| |/
+	|/|
+	| * 1_A10
+	|/
+	* 1_root
+	EOF
+'
+
+test_expect_success 'log --graph with several merges (ignore-merge-bases)' '
+	check_graph --ignore-merge-bases <<-\EOF
+	*   1_M1
+	|\
+	| * 1_B1
+	*   1_M2
+	|\
+	| * 1_B2
+	*   1_M3
+	|\
+	| * 1_B3
+	*   1_M4
+	|\
+	| * 1_B4
+	*   1_M5
+	|\
+	| * 1_B5
+	*   1_M6
+	|\
+	| * 1_B6
+	*   1_M7
+	|\
+	| * 1_B7
+	*   1_M8
+	|\
+	| * 1_B8
+	*   1_M9
+	|\
+	| * 1_B9
+	*   1_M10
+	|\
+	| * 1_B10
+	| *   1_M10A1
+	| |\
+	| | * 1_A1
+	| *   1_M9A2
+	| |\
+	| | * 1_A2
+	| *   1_M8A3
+	| |\
+	| | * 1_A3
+	| *   1_M7A4
+	| |\
+	| | * 1_A4
+	| *   1_M6A5
+	| |\
+	| | * 1_A5
+	| *   1_M5A6
+	| |\
+	| | * 1_A6
+	| *   1_M4A7
+	| |\
+	| | * 1_A7
+	| *   1_M3A8
+	| |\
+	| | * 1_A8
+	| *   1_M2A9
+	| |\
+	| | * 1_A9
+	| * 1_A10
+	* 1_root
+	EOF
+'
+
+test_done
diff --git a/t/t6016-rev-list-graph-simplify-history.sh b/t/t6016-rev-list-graph-simplify-history.sh
index eac271a4fa..a097be5ce5 100755
--- a/t/t6016-rev-list-graph-simplify-history.sh
+++ b/t/t6016-rev-list-graph-simplify-history.sh
@@ -78,6 +78,27 @@ test_expect_success '--graph --all' '
 	EOF
 '

+# Make sure that ignore_merge_bases produces a spanning tree
+test_expect_success '--graph --ignore-merge-bases --all' '
+	check_graph --ignore-merge-bases --all <<-\EOF
+	* A7
+	*   A6
+	|\
+	| * C4
+	| * C3
+	* A5
+	*-.   A4
+	|\ \
+	| | * C2
+	| | * C1
+	| * B2
+	| * B1
+	* A3
+	* A2
+	* A1
+	EOF
+'
+
 # Make sure the graph_is_interesting() code still realizes
 # that undecorated merges are interesting, even with --simplify-by-decoration
 test_expect_success '--graph --simplify-by-decoration' '
@@ -147,6 +168,19 @@ test_expect_success '--graph --full-history -- bar.txt' '
 	EOF
 '

+test_expect_success '--graph --ignore-merge-bases --full-history -- bar.txt' '
+	check_graph --ignore-merge-bases --full-history --all -- bar.txt <<-\EOF
+	* A7
+	*   A6
+	|\
+	| * C4
+	* A5
+	* A4
+	* A3
+	* A2
+	EOF
+'
+
 test_expect_success '--graph --full-history --simplify-merges -- bar.txt' '
 	check_graph --full-history --simplify-merges --all -- bar.txt <<-\EOF
 	* A7
@@ -160,6 +194,18 @@ test_expect_success '--graph --full-history --simplify-merges -- bar.txt' '
 	EOF
 '

+test_expect_success '--graph --ignore-merge-bases --full-history --simplify-merges -- bar.txt' '
+	check_graph --ignore-merge-bases --full-history --simplify-merges --all -- bar.txt <<-\EOF
+	* A7
+	*   A6
+	|\
+	| * C4
+	* A5
+	* A3
+	* A2
+	EOF
+'
+
 test_expect_success '--graph -- bar.txt' '
 	check_graph --all -- bar.txt <<-\EOF
 	* A7
@@ -243,4 +289,27 @@ test_expect_success '--graph --boundary ^C3' '
 	EOF
 '

+test_expect_success '--graph --ignore-merge-bases --boundary ^C3' '
+	check_graph --ignore-merge-bases --boundary --all ^C3 <<-\EOF
+	* A7
+	*   A6
+	|\
+	| * C4
+	* | A5
+	| |
+	|  \
+	*-. \   A4
+	|\ \ \
+	| * | | B2
+	| * | | B1
+	|  / /
+	* | | A3
+	o | | A2
+	 / /
+	o / C2
+	 /
+	o C3
+	EOF
+'
+
 test_done
-- 
2.26.2


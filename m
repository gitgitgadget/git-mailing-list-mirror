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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6161C1F463
	for <e@80x24.org>; Wed, 25 Sep 2019 10:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389804AbfIYK1N (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 06:27:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46768 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729987AbfIYK1N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 06:27:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id q5so3113415pfg.13
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 03:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NfXlukhUB4mlQK1zfqd5swFvRy+b9PTZ0fHpMrRG1nQ=;
        b=O+APiwHPIWqBtsfaiJz775ROwsWL2jVyN/Xm7f1p1hjmdRebJvdg+VpFikpdOy1Lzb
         oFQw5ehHblrKlyYlSX9QPPN8T1JrPDcS4G0PjtdR2Uowe6OJO6urYDY+U/U921w4V7Al
         Js/UwJbO/8wsNU/C6Id6rAPrJ8yH0ZSco1EN5WkQHvvEYdMc7CNY/yCZKwF0Ti5QCzHP
         xsaLMuapAABZf9bnYPry9j2YwCCq5guE6EdWtf+hv+6zLsMxKS08/hS3rRkFDJIQ4LHi
         HeFNAD/0Gyuq+3luVdqoOqSTHx9g9Aa87+rXcfoFzK3P6a129eL/ou4HCBsGz2zPx4fF
         RRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NfXlukhUB4mlQK1zfqd5swFvRy+b9PTZ0fHpMrRG1nQ=;
        b=UluH+xdw9bhEmxT1ZrO8FLB8cjwTNa+UdnPctSNLK+SIraiVt/t82gSO+M3zuavl76
         Pp7vVIWXrC+smt6hMeErug5qhdoWSnSsQbdxCxCG/oCKRwsxYoZn2CKG7EFOaSZR85Vq
         PQEmEZE4UEKCFIVGnfOZ5Pfd8Foe1GVzwpHU2e9V9sSVV8NN0aa5i6v2NwJF4kLLd2SW
         gTKz9RJ8kMZ/eMhyhCMvcJ0wrGTB9UEqhzRWPcGqcwqcrEPviYOqyJdqTZLWs62SawVO
         I3NerXhsRI+E9tna4PuIQ0obiBJmNTdxiTCSJjmegipOKoQi3aT8v7b21JWPlpSCp6CU
         NnxA==
X-Gm-Message-State: APjAAAVQPhKNc5DHhtsALz7LB6fz7xnCMm9yb36qEWqImLnCWX2p88KM
        hSQyg4dq1e1KnukC/QqUZ3m0TFnT
X-Google-Smtp-Source: APXvYqz9TTzDwgviABQp8zULhii7zJPeomDeMlQmNyn7FCmCYpPJqQ0/k5PXH4fNlMa73kyWmRjLfA==
X-Received: by 2002:a65:5a84:: with SMTP id c4mr7988446pgt.261.1569407231956;
        Wed, 25 Sep 2019 03:27:11 -0700 (PDT)
Received: from archbookpro.localdomain ([2601:646:280:1b30::6486])
        by smtp.gmail.com with ESMTPSA id v32sm6233679pga.38.2019.09.25.03.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 03:27:11 -0700 (PDT)
Date:   Wed, 25 Sep 2019 03:27:09 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Allan Caffee <allan.caffee@gmail.com>,
        Noam Postavsky <npostavs@users.sourceforge.net>
Subject: [BUG/PATCH 5/5] t4214: demonstrate octopus graph coloring failure
Message-ID: <0b84bf54175cd8ee967ab46ac393c2d5d18d772e.1569407150.git.liu.denton@gmail.com>
References: <cover.1569407150.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1569407150.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The graph coloring logic for octopus merges currently has a bug. This
can be seen git.git with 74c7cfa875 (Merge of
http://members.cox.net/junkio/git-jc.git, 2005-05-05), whose second
child is 211232bae6 (Octopus merge of the following five patches.,
2005-05-05).

If one runs

	git log --graph 74c7cfa875

one can see that the octopus merge is colored incorrectly. In
particular, the horizontal dashes are off by one color. Each horizontal
dash should be the color of the line to their bottom-right. Instead, they
are currently the color of the line to their bottom.

Demonstrate this breakage with two sets of test cases. The first pair of
test cases demonstrates the breakage with a similar case as the above.
The second pair of test cases demonstrates a similar breakage but with
the last parent crossing over.

The second pair of test cases are included as a result of my (poor)
attempts at fixing the bug. This case seems particularly tricky to
handle. Good luck!

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4214-log-graph-octopus.sh | 96 +++++++++++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 1 deletion(-)

diff --git a/t/t4214-log-graph-octopus.sh b/t/t4214-log-graph-octopus.sh
index 097151da39..99e0ea034e 100755
--- a/t/t4214-log-graph-octopus.sh
+++ b/t/t4214-log-graph-octopus.sh
@@ -14,8 +14,11 @@ test_expect_success 'set up merge history' '
 	done &&
 	git checkout 1 -b merge &&
 	test_merge octopus-merge 1 2 3 4 &&
+	test_commit after-merge &&
 	git checkout 1 -b L &&
-	test_commit left
+	test_commit left &&
+	git checkout 4 -b crossover &&
+	test_commit after-4
 '
 
 test_expect_success 'log --graph with tricky octopus merge, no color' '
@@ -98,4 +101,95 @@ test_expect_success 'log --graph with normal octopus merge with colors' '
 	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
 	test_cmp expect.colors actual.colors
 '
+
+test_expect_success 'log --graph with tricky octopus merge and its parent, no color' '
+	cat >expect.uncolored <<-\EOF &&
+	* left
+	| * after-merge
+	| *---.   octopus-merge
+	| |\ \ \
+	|/ / / /
+	| | | * 4
+	| | * | 3
+	| | |/
+	| * | 2
+	| |/
+	* | 1
+	|/
+	* initial
+	EOF
+	git log --color=never --graph --date-order --pretty=tformat:%s left after-merge >actual.raw &&
+	sed "s/ *\$//" actual.raw >actual &&
+	test_cmp expect.uncolored actual
+'
+
+test_expect_failure 'log --graph with tricky octopus merge and its parent with colors' '
+	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
+	cat >expect.colors <<-\EOF &&
+	* left
+	<RED>|<RESET> * after-merge
+	<RED>|<RESET> *<MAGENTA>-<RESET><MAGENTA>-<RESET><CYAN>-<RESET><CYAN>.<RESET>   octopus-merge
+	<RED>|<RESET> <RED>|<RESET><BLUE>\<RESET> <MAGENTA>\<RESET> <CYAN>\<RESET>
+	<RED>|<RESET><RED>/<RESET> <BLUE>/<RESET> <MAGENTA>/<RESET> <CYAN>/<RESET>
+	<RED>|<RESET> <BLUE>|<RESET> <MAGENTA>|<RESET> * 4
+	<RED>|<RESET> <BLUE>|<RESET> * <CYAN>|<RESET> 3
+	<RED>|<RESET> <BLUE>|<RESET> <CYAN>|<RESET><CYAN>/<RESET>
+	<RED>|<RESET> * <CYAN>|<RESET> 2
+	<RED>|<RESET> <CYAN>|<RESET><CYAN>/<RESET>
+	* <CYAN>|<RESET> 1
+	<CYAN>|<RESET><CYAN>/<RESET>
+	* initial
+	EOF
+	git log --color=always --graph --date-order --pretty=tformat:%s left after-merge >actual.colors.raw &&
+	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
+	test_cmp expect.colors actual.colors
+'
+
+test_expect_success 'log --graph with crossover in octopus merge, no color' '
+	cat >expect.uncolored <<-\EOF &&
+	* after-4
+	| *---.   octopus-merge
+	| |\ \ \
+	| |_|_|/
+	|/| | |
+	* | | | 4
+	| | | * 3
+	| |_|/
+	|/| |
+	| | * 2
+	| |/
+	|/|
+	| * 1
+	|/
+	* initial
+	EOF
+	git log --color=never --graph --date-order --pretty=tformat:%s after-4 octopus-merge >actual.raw &&
+	sed "s/ *\$//" actual.raw >actual &&
+	test_cmp expect.uncolored actual
+'
+
+test_expect_failure 'log --graph with crossover in octopus merge with colors' '
+	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
+	cat >expect.colors <<-\EOF &&
+	* after-4
+	<RED>|<RESET> *<BLUE>-<RESET><BLUE>-<RESET><RED>-<RESET><RED>.<RESET>   octopus-merge
+	<RED>|<RESET> <GREEN>|<RESET><YELLOW>\<RESET> <BLUE>\<RESET> <RED>\<RESET>
+	<RED>|<RESET> <GREEN>|<RESET><RED>_<RESET><YELLOW>|<RESET><RED>_<RESET><BLUE>|<RESET><RED>/<RESET>
+	<RED>|<RESET><RED>/<RESET><GREEN>|<RESET> <YELLOW>|<RESET> <BLUE>|<RESET>
+	* <GREEN>|<RESET> <YELLOW>|<RESET> <BLUE>|<RESET> 4
+	<MAGENTA>|<RESET> <GREEN>|<RESET> <YELLOW>|<RESET> * 3
+	<MAGENTA>|<RESET> <GREEN>|<RESET><MAGENTA>_<RESET><YELLOW>|<RESET><MAGENTA>/<RESET>
+	<MAGENTA>|<RESET><MAGENTA>/<RESET><GREEN>|<RESET> <YELLOW>|<RESET>
+	<MAGENTA>|<RESET> <GREEN>|<RESET> * 2
+	<MAGENTA>|<RESET> <GREEN>|<RESET><MAGENTA>/<RESET>
+	<MAGENTA>|<RESET><MAGENTA>/<RESET><GREEN>|<RESET>
+	<MAGENTA>|<RESET> * 1
+	<MAGENTA>|<RESET><MAGENTA>/<RESET>
+	* initial
+	EOF
+	git log --color=always --graph --date-order --pretty=tformat:%s after-4 octopus-merge >actual.colors.raw &&
+	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
+	test_cmp expect.colors actual.colors
+'
+
 test_done
-- 
2.23.0.248.g3a9dd8fb08


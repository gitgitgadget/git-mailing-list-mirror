Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F4F61F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 00:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732449AbfJDAXV (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 20:23:21 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:33587 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732230AbfJDAXV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 20:23:21 -0400
Received: by mail-pl1-f173.google.com with SMTP id d22so2303437pls.0
        for <git@vger.kernel.org>; Thu, 03 Oct 2019 17:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AsNEPpI9a8UlkrneuRtduFHSIgZkqlpYxE+7nah1KkU=;
        b=N0AbGUeJvs0anNtBhBGcIqVxXLf4naGZggNwV8dJ1UFYAeBnRk9kaD2owihdglqQy5
         igan7KeRdVDhHgujYVmxVcjOvnYzXRCTIsy8HDUDY8HtoEUSBcREVesV4tFi2vixpXMX
         AEHwtFm3Ztfl86Ww661/WOLKuTenDu9MiaLd+c+3sZdWbrHj5+SB4TZCMWfBN7x8NJE4
         HYWQjo3V/QNoZFBw9EXdBxSnx1lDQLa/uU8C8HyniktBINVdtXArOANlnXZZQ219D83I
         q3hNuvl5IrScg6emgs4RJUT5+ikr0MmPUd84uhk+7jY9D5//vz44uTBKLStL5P+Hp0b0
         71Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AsNEPpI9a8UlkrneuRtduFHSIgZkqlpYxE+7nah1KkU=;
        b=kLSOAQy1VTXzKQihKmUhzqC8TLL29lz/PuyIifUg/KcS7VxtnLjvalF7694L+73pEd
         RX9K4cFoD45FYC9GRgFN84RlT6A0GN8PxeNa2f01hbz99ylkbLvTtOdnq04MhtMiYZtW
         MrK9rT90P4vYu6TD/eyEPVtFT9RoLpWcI9UqaycKNWTnrpY35xJM8gB/KqViKa6gOErx
         A2nWrGspVSF1N4m4S1X1KiO8L+1jzYSn0UezWXrhPyzGdQtSD+YKn+tAn+oL0R4SnfHm
         2sBFbpy1mTDgLEQi9Qf88q+jNushobtTRpXXa2tJMaw+R7z0ahQjhLOb9qS2UXFohfel
         APAw==
X-Gm-Message-State: APjAAAWfGrWfjhEdXg2nilCVPKRP2eeZJGrP5KQ25nkhYwXFH43nRE0F
        v5zkvrHOkzVJOumaUOcSR1ALEy5u
X-Google-Smtp-Source: APXvYqyCfHO6yLjKSZ4YbSxekvsUx/bKrvI/CV8IXF0BfOrw6acAbb35UclSkpyeSaK7SbnAxPzy2g==
X-Received: by 2002:a17:902:9346:: with SMTP id g6mr12483391plp.0.1570148599978;
        Thu, 03 Oct 2019 17:23:19 -0700 (PDT)
Received: from generichostname ([216.52.21.197])
        by smtp.gmail.com with ESMTPSA id a7sm3233092pjv.0.2019.10.03.17.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 17:23:19 -0700 (PDT)
Date:   Thu, 3 Oct 2019 17:23:17 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Allan Caffee <allan.caffee@gmail.com>,
        Noam Postavsky <npostavs@users.sourceforge.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/5] t4214: generate expect in their own test cases
Message-ID: <c09f761185859998d33c4944fe3a7317e3a8c987.1570148053.git.liu.denton@gmail.com>
References: <cover.1569407150.git.liu.denton@gmail.com>
 <cover.1570148053.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1570148053.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, the expect files of the test case were being generated in the
setup method. However, it would make more sense to generate these files
within the test cases that actually use them so that it's obvious to
future readers where the expected values are coming from.

Move the generation of the expect files in their own respective test
cases.

While we're at it, we want to establish a pattern in this test suite
that, firstly, a non-colored test case is given then, immediately after,
the colored version is given.

Switch test cases "log --graph with tricky octopus merge, no color" and
"log --graph with tricky octopus merge with colors" so that the "no
color" version appears first.

This patch is best viewed with `--color-moved`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4214-log-graph-octopus.sh | 42 ++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/t/t4214-log-graph-octopus.sh b/t/t4214-log-graph-octopus.sh
index f6e22ec825..16776e347c 100755
--- a/t/t4214-log-graph-octopus.sh
+++ b/t/t4214-log-graph-octopus.sh
@@ -5,6 +5,20 @@ test_description='git log --graph of skewed left octopus merge.'
 . ./test-lib.sh
 
 test_expect_success 'set up merge history' '
+	test_commit initial &&
+	for i in 1 2 3 4 ; do
+		git checkout master -b $i || return $?
+		# Make tag name different from branch name, to avoid
+		# ambiguity error when calling checkout.
+		test_commit $i $i $i tag$i || return $?
+	done &&
+	git checkout 1 -b merge &&
+	test_merge octopus-merge 1 2 3 4 &&
+	git checkout 1 -b L &&
+	test_commit left
+'
+
+test_expect_success 'log --graph with tricky octopus merge, no color' '
 	cat >expect.uncolored <<-\EOF &&
 	* left
 	| *---.   octopus-merge
@@ -19,6 +33,13 @@ test_expect_success 'set up merge history' '
 	|/
 	* initial
 	EOF
+	git log --color=never --graph --date-order --pretty=tformat:%s --all >actual.raw &&
+	sed "s/ *\$//" actual.raw >actual &&
+	test_cmp expect.uncolored actual
+'
+
+test_expect_success 'log --graph with tricky octopus merge with colors' '
+	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
 	cat >expect.colors <<-\EOF &&
 	* left
 	<RED>|<RESET> *<BLUE>-<RESET><BLUE>-<RESET><MAGENTA>-<RESET><MAGENTA>.<RESET>   octopus-merge
@@ -33,32 +54,11 @@ test_expect_success 'set up merge history' '
 	<MAGENTA>|<RESET><MAGENTA>/<RESET>
 	* initial
 	EOF
-	test_commit initial &&
-	for i in 1 2 3 4 ; do
-		git checkout master -b $i || return $?
-		# Make tag name different from branch name, to avoid
-		# ambiguity error when calling checkout.
-		test_commit $i $i $i tag$i || return $?
-	done &&
-	git checkout 1 -b merge &&
-	test_merge octopus-merge 1 2 3 4 &&
-	git checkout 1 -b L &&
-	test_commit left
-'
-
-test_expect_success 'log --graph with tricky octopus merge with colors' '
-	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
 	git log --color=always --graph --date-order --pretty=tformat:%s --all >actual.colors.raw &&
 	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
 	test_cmp expect.colors actual.colors
 '
 
-test_expect_success 'log --graph with tricky octopus merge, no color' '
-	git log --color=never --graph --date-order --pretty=tformat:%s --all >actual.raw &&
-	sed "s/ *\$//" actual.raw >actual &&
-	test_cmp expect.uncolored actual
-'
-
 # Repeat the previous two tests with "normal" octopus merge (i.e.,
 # without the first parent skewing to the "left" branch column).
 
-- 
2.23.0.565.g1cc52d20df


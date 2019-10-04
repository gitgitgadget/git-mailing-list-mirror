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
	by dcvr.yhbt.net (Postfix) with ESMTP id F2C131F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 00:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732546AbfJDAX1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 20:23:27 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38088 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731918AbfJDAX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 20:23:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id x10so2729266pgi.5
        for <git@vger.kernel.org>; Thu, 03 Oct 2019 17:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4krdbl2RVnlLX5Fws5JNCN30ZBrWBi0WKJiSdU7Ov4E=;
        b=URPkXl+tuRbDaSsyAx5TN7IvSegkdHfEl90yxSsqE/3WZDDWtf+EzEvU82vWSIETeZ
         O+/tF0D5cfJMQ0mA1NX2Bh6Ci/x2a7MtGrTY67xb3vw3C47FMMHPDVAPWokpqu7y/RGp
         H1ZdBdKuCg1TsfE39Gwuv69pdc1MUwUTXJB4msOFC7oY52lKlOiERDjsAKjWfMqAlIjT
         weyVFmUd9Cvj0h0K3FMQpXBxWLioN5g81lF5LPGTID2a5n/QsZI6YQ2C1M3WC1kLeXaA
         DhHslESr0q1m5qh/SGwliFtaAEkMcfFer83BHEibjHpM7oSEFlCjgG7tuGkUxrCVrIck
         Gznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4krdbl2RVnlLX5Fws5JNCN30ZBrWBi0WKJiSdU7Ov4E=;
        b=AUhjaKuCJ4eMqKpV0v3qB83H0zPSe+Le2tDHai1W9DmBw9POuMQ5w0HmphKbe1zCJq
         OFKA0TC6GWkkKez7I+PDCPpbSg1hhdUKRnA/kBmixI4UDdUqtuY6Qn9SDdQJLL51tTFJ
         w8r5Tsl16tmgWCDBhShThilRdimAxY71SazmAXYsb77QJNaQk/4LBF23wPzcPv7ZKHGE
         lV60la0tWHfuaAK4DKBRLomoLu8626B1+WNp7e7yBlLKmyBvle9rZYw/hjUK8ECGRopi
         37PjqlXZTxhHjcbqcJlzprmH5RcNO5XQ1AdziFs40Pp+3RdlzpHpQvIr1WC7ZUHxbSor
         eDog==
X-Gm-Message-State: APjAAAWErHQnuVGzm7Mm/OQtnwE1YuH1OAF7vEFBhj6dZli5xffaQvUC
        Ik8zpSZKJvcdPBTPNYyy+kQQNADi
X-Google-Smtp-Source: APXvYqxJqEYmeXXTAmFaesLk6I5+96H/UeUcHeWvYzz+1SBd752Wp/fbpGe7mlwQKcZlKNeGIRU9Fw==
X-Received: by 2002:a62:1ad2:: with SMTP id a201mr8377696pfa.151.1570148604619;
        Thu, 03 Oct 2019 17:23:24 -0700 (PDT)
Received: from generichostname ([216.52.21.197])
        by smtp.gmail.com with ESMTPSA id h14sm4319130pfo.15.2019.10.03.17.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 17:23:24 -0700 (PDT)
Date:   Thu, 3 Oct 2019 17:23:22 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Allan Caffee <allan.caffee@gmail.com>,
        Noam Postavsky <npostavs@users.sourceforge.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/5] t4214: demonstrate octopus graph coloring failure
Message-ID: <e58c1929bc40dadc468a3e37e49a8de04c46af99.1570148053.git.liu.denton@gmail.com>
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

Demonstrate this breakage with a few sets of test cases. These test
cases should show not only simple cases of the bug occuring but trickier
situations that may not be handled properly in any attempt to fix the
bug.

While we're at it, include a passing test case as a canary in case an
attempt to fix the bug breaks existing operation.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4214-log-graph-octopus.sh | 282 ++++++++++++++++++++++++++++++++++-
 1 file changed, 281 insertions(+), 1 deletion(-)

diff --git a/t/t4214-log-graph-octopus.sh b/t/t4214-log-graph-octopus.sh
index 097151da39..3ae8e51e50 100755
--- a/t/t4214-log-graph-octopus.sh
+++ b/t/t4214-log-graph-octopus.sh
@@ -14,8 +14,13 @@ test_expect_success 'set up merge history' '
 	done &&
 	git checkout 1 -b merge &&
 	test_merge octopus-merge 1 2 3 4 &&
+	test_commit after-merge &&
 	git checkout 1 -b L &&
-	test_commit left
+	test_commit left &&
+	git checkout 4 -b crossover &&
+	test_commit after-4 &&
+	git checkout initial -b more-L &&
+	test_commit after-initial
 '
 
 test_expect_success 'log --graph with tricky octopus merge, no color' '
@@ -98,4 +103,279 @@ test_expect_success 'log --graph with normal octopus merge with colors' '
 	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
 	test_cmp expect.colors actual.colors
 '
+
+test_expect_success 'log --graph with normal octopus merge and child, no color' '
+	cat >expect.uncolored <<-\EOF &&
+	* after-merge
+	*---.   octopus-merge
+	|\ \ \
+	| | | * 4
+	| | * | 3
+	| | |/
+	| * | 2
+	| |/
+	* | 1
+	|/
+	* initial
+	EOF
+	git log --color=never --graph --date-order --pretty=tformat:%s after-merge >actual.raw &&
+	sed "s/ *\$//" actual.raw >actual &&
+	test_cmp expect.uncolored actual
+'
+
+test_expect_failure 'log --graph with normal octopus and child merge with colors' '
+	cat >expect.colors <<-\EOF &&
+	* after-merge
+	*<BLUE>-<RESET><BLUE>-<RESET><MAGENTA>-<RESET><MAGENTA>.<RESET>   octopus-merge
+	<GREEN>|<RESET><YELLOW>\<RESET> <BLUE>\<RESET> <MAGENTA>\<RESET>
+	<GREEN>|<RESET> <YELLOW>|<RESET> <BLUE>|<RESET> * 4
+	<GREEN>|<RESET> <YELLOW>|<RESET> * <MAGENTA>|<RESET> 3
+	<GREEN>|<RESET> <YELLOW>|<RESET> <MAGENTA>|<RESET><MAGENTA>/<RESET>
+	<GREEN>|<RESET> * <MAGENTA>|<RESET> 2
+	<GREEN>|<RESET> <MAGENTA>|<RESET><MAGENTA>/<RESET>
+	* <MAGENTA>|<RESET> 1
+	<MAGENTA>|<RESET><MAGENTA>/<RESET>
+	* initial
+	EOF
+	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
+	git log --color=always --graph --date-order --pretty=tformat:%s after-merge >actual.colors.raw &&
+	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
+	test_cmp expect.colors actual.colors
+'
+
+test_expect_success 'log --graph with tricky octopus merge and its child, no color' '
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
+test_expect_failure 'log --graph with tricky octopus merge and its child with colors' '
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
+test_expect_success 'log --graph with crossover in octopus merge and its child, no color' '
+	cat >expect.uncolored <<-\EOF &&
+	* after-4
+	| * after-merge
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
+	git log --color=never --graph --date-order --pretty=tformat:%s after-4 after-merge >actual.raw &&
+	sed "s/ *\$//" actual.raw >actual &&
+	test_cmp expect.uncolored actual
+'
+
+test_expect_failure 'log --graph with crossover in octopus merge and its child with colors' '
+	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
+	cat >expect.colors <<-\EOF &&
+	* after-4
+	<RED>|<RESET> * after-merge
+	<RED>|<RESET> *<MAGENTA>-<RESET><MAGENTA>-<RESET><RED>-<RESET><RED>.<RESET>   octopus-merge
+	<RED>|<RESET> <YELLOW>|<RESET><BLUE>\<RESET> <MAGENTA>\<RESET> <RED>\<RESET>
+	<RED>|<RESET> <YELLOW>|<RESET><RED>_<RESET><BLUE>|<RESET><RED>_<RESET><MAGENTA>|<RESET><RED>/<RESET>
+	<RED>|<RESET><RED>/<RESET><YELLOW>|<RESET> <BLUE>|<RESET> <MAGENTA>|<RESET>
+	* <YELLOW>|<RESET> <BLUE>|<RESET> <MAGENTA>|<RESET> 4
+	<CYAN>|<RESET> <YELLOW>|<RESET> <BLUE>|<RESET> * 3
+	<CYAN>|<RESET> <YELLOW>|<RESET><CYAN>_<RESET><BLUE>|<RESET><CYAN>/<RESET>
+	<CYAN>|<RESET><CYAN>/<RESET><YELLOW>|<RESET> <BLUE>|<RESET>
+	<CYAN>|<RESET> <YELLOW>|<RESET> * 2
+	<CYAN>|<RESET> <YELLOW>|<RESET><CYAN>/<RESET>
+	<CYAN>|<RESET><CYAN>/<RESET><YELLOW>|<RESET>
+	<CYAN>|<RESET> * 1
+	<CYAN>|<RESET><CYAN>/<RESET>
+	* initial
+	EOF
+	git log --color=always --graph --date-order --pretty=tformat:%s after-4 after-merge >actual.colors.raw &&
+	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
+	test_cmp expect.colors actual.colors
+'
+
+test_expect_success 'log --graph with unrelated commit and octopus tip, no color' '
+	cat >expect.uncolored <<-\EOF &&
+	* after-initial
+	| *---.   octopus-merge
+	| |\ \ \
+	| | | | * 4
+	| |_|_|/
+	|/| | |
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
+	git log --color=never --graph --date-order --pretty=tformat:%s after-initial octopus-merge >actual.raw &&
+	sed "s/ *\$//" actual.raw >actual &&
+	test_cmp expect.uncolored actual
+'
+
+test_expect_success 'log --graph with unrelated commit and octopus tip with colors' '
+	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
+	cat >expect.colors <<-\EOF &&
+	* after-initial
+	<RED>|<RESET> *<BLUE>-<RESET><BLUE>-<RESET><MAGENTA>-<RESET><MAGENTA>.<RESET>   octopus-merge
+	<RED>|<RESET> <GREEN>|<RESET><YELLOW>\<RESET> <BLUE>\<RESET> <MAGENTA>\<RESET>
+	<RED>|<RESET> <GREEN>|<RESET> <YELLOW>|<RESET> <BLUE>|<RESET> * 4
+	<RED>|<RESET> <GREEN>|<RESET><RED>_<RESET><YELLOW>|<RESET><RED>_<RESET><BLUE>|<RESET><RED>/<RESET>
+	<RED>|<RESET><RED>/<RESET><GREEN>|<RESET> <YELLOW>|<RESET> <BLUE>|<RESET>
+	<RED>|<RESET> <GREEN>|<RESET> <YELLOW>|<RESET> * 3
+	<RED>|<RESET> <GREEN>|<RESET><RED>_<RESET><YELLOW>|<RESET><RED>/<RESET>
+	<RED>|<RESET><RED>/<RESET><GREEN>|<RESET> <YELLOW>|<RESET>
+	<RED>|<RESET> <GREEN>|<RESET> * 2
+	<RED>|<RESET> <GREEN>|<RESET><RED>/<RESET>
+	<RED>|<RESET><RED>/<RESET><GREEN>|<RESET>
+	<RED>|<RESET> * 1
+	<RED>|<RESET><RED>/<RESET>
+	* initial
+	EOF
+	git log --color=always --graph --date-order --pretty=tformat:%s after-initial octopus-merge >actual.colors.raw &&
+	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
+	test_cmp expect.colors actual.colors
+'
+
+test_expect_success 'log --graph with unrelated commit and octopus child, no color' '
+	cat >expect.uncolored <<-\EOF &&
+	* after-initial
+	| * after-merge
+	| *---.   octopus-merge
+	| |\ \ \
+	| | | | * 4
+	| |_|_|/
+	|/| | |
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
+	git log --color=never --graph --date-order --pretty=tformat:%s after-initial after-merge >actual.raw &&
+	sed "s/ *\$//" actual.raw >actual &&
+	test_cmp expect.uncolored actual
+'
+
+test_expect_failure 'log --graph with unrelated commit and octopus child with colors' '
+	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
+	cat >expect.colors <<-\EOF &&
+	* after-initial
+	<RED>|<RESET> * after-merge
+	<RED>|<RESET> *<MAGENTA>-<RESET><MAGENTA>-<RESET><CYAN>-<RESET><CYAN>.<RESET>   octopus-merge
+	<RED>|<RESET> <YELLOW>|<RESET><BLUE>\<RESET> <MAGENTA>\<RESET> <CYAN>\<RESET>
+	<RED>|<RESET> <YELLOW>|<RESET> <BLUE>|<RESET> <MAGENTA>|<RESET> * 4
+	<RED>|<RESET> <YELLOW>|<RESET><RED>_<RESET><BLUE>|<RESET><RED>_<RESET><MAGENTA>|<RESET><RED>/<RESET>
+	<RED>|<RESET><RED>/<RESET><YELLOW>|<RESET> <BLUE>|<RESET> <MAGENTA>|<RESET>
+	<RED>|<RESET> <YELLOW>|<RESET> <BLUE>|<RESET> * 3
+	<RED>|<RESET> <YELLOW>|<RESET><RED>_<RESET><BLUE>|<RESET><RED>/<RESET>
+	<RED>|<RESET><RED>/<RESET><YELLOW>|<RESET> <BLUE>|<RESET>
+	<RED>|<RESET> <YELLOW>|<RESET> * 2
+	<RED>|<RESET> <YELLOW>|<RESET><RED>/<RESET>
+	<RED>|<RESET><RED>/<RESET><YELLOW>|<RESET>
+	<RED>|<RESET> * 1
+	<RED>|<RESET><RED>/<RESET>
+	* initial
+	EOF
+	git log --color=always --graph --date-order --pretty=tformat:%s after-initial after-merge >actual.colors.raw &&
+	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
+	test_cmp expect.colors actual.colors
+'
+
 test_done
-- 
2.23.0.565.g1cc52d20df


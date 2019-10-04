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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E5B21F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 00:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731575AbfJDAXP (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 20:23:15 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44537 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730969AbfJDAXP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 20:23:15 -0400
Received: by mail-pf1-f195.google.com with SMTP id q21so2755114pfn.11
        for <git@vger.kernel.org>; Thu, 03 Oct 2019 17:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jHDAcGVWJ6dKTmqQbf0EXyDEcEIPE4gw3lbNKKzQ80M=;
        b=BDdEcY6tyJzgLopNJBmtrotUMj0piQaExpiBEPhe17eNoNu+D+synj6Prk3S799JHD
         hDv6BEY0lYMNgc1j4ha7S7k2YXj1tc8nCAofxowq1P/ECjVE5E3eW1Ns2oYSyYJvlcqp
         Vb91/cTGY4EczVMFQDWmyOovAlGh9le+Vm/kfGSSFAaqfj2frG75nAYw8e33uXHNjP0V
         SakYVUgrtBqzUZ3jjh4yrQp9ZmHeq/NnsF1nIYK1hNUrNbR+X3tSeNa78yFZHK9Anp9h
         UDFk8Q5/0XLJW5ctNLwtgYnOTXE590xyaZthvS+lkRwCpNan4u19/5dOC29zUbjXk7wJ
         imJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jHDAcGVWJ6dKTmqQbf0EXyDEcEIPE4gw3lbNKKzQ80M=;
        b=r1GoodNus6115rGvJ1x6pwUKxL+ur8+o/LAV+bWbmWpP83iFuQrLw51gTThJFtiBBK
         +H23nH1MysjyUkcswFb4tx0y4Dp4AFGEw7A32WP9QwBDGEQWH6OwzerAgpfJYvAWzs/t
         NMigYyVshOZhcdovOttUCBftfF9d6NN2N2pbiIajL5xbWM8wH10z6UKpO/U9XzJxvdpO
         nB5qUsfcDYSMv9m7t/LWSnsqatj7rSfpzsgKdcy83p7bgdQjdmljUknOzo1Hg4QlGh5z
         eFZFcU1WRyXqvBHmXOrxpfMVCcoexWYv2tlj8erMlllG4h7AkUOhgblldG9Grg1JJ1FA
         YpoQ==
X-Gm-Message-State: APjAAAWQ96hB0IkhXPdkybLzmdp5q1IM6xI6FqEVBli8FG5WQ0rlQYRh
        XfF0xacQqjL4/O4diKL6FS7YzPPj
X-Google-Smtp-Source: APXvYqwcUo40db45seEX60N5oOXmKAIKKqdX25yHjRWSB9ymphEJJzostKm7ikUO8JbR6eMzl/W5oQ==
X-Received: by 2002:a63:5fcf:: with SMTP id t198mr12175497pgb.270.1570148592915;
        Thu, 03 Oct 2019 17:23:12 -0700 (PDT)
Received: from generichostname ([216.52.21.197])
        by smtp.gmail.com with ESMTPSA id s73sm3314440pjb.15.2019.10.03.17.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 17:23:11 -0700 (PDT)
Date:   Thu, 3 Oct 2019 17:23:09 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Allan Caffee <allan.caffee@gmail.com>,
        Noam Postavsky <npostavs@users.sourceforge.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/5] t4214: cleanup and demonstrate graph bug
Message-ID: <cover.1570148053.git.liu.denton@gmail.com>
References: <cover.1569407150.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1569407150.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio, the test cases from earlier didn't exactly cover the cases Peff
talked about so I added a few more test cases. These should cover those
situations and a few more so we can be extra sure when the bug is fixed.


This patchset cleans up t4214 and then, in the last patch, demonstrates
a bug in the way some octopus merges are colored.

While I was playing around with Pratyush's octopus merge in git-gui, I
noticed that there was a bug in `git log --graph`. The horizontal lines
in the octopus merge seemed to have an off-by-one error in their
coloring. More detail in the last patch.

I tried my hand at fixing the bug but in the hour I spent going at it, I
couldn't fix the logic up. The buggy logic is in graph.c:
graph_draw_octopus_merge() in case anyone is interested.

Changes since v1:

* Add a few more test cases to demonstrate more failure (and passing)
  conditions


Denton Liu (5):
  test-lib: let test_merge() perform octopus merges
  t4214: use test_merge
  t4214: generate expect in their own test cases
  t4214: explicitly list tags in log
  t4214: demonstrate octopus graph coloring failure

 t/t4214-log-graph-octopus.sh | 329 ++++++++++++++++++++++++++++++++---
 t/test-lib-functions.sh      |   6 +-
 2 files changed, 308 insertions(+), 27 deletions(-)

Range-diff against v1:
1:  e77af8cde5 = 1:  e77af8cde5 test-lib: let test_merge() perform octopus merges
2:  4a93deb3f6 = 2:  4a93deb3f6 t4214: use test_merge
3:  c09f761185 = 3:  c09f761185 t4214: generate expect in their own test cases
4:  ad6d89440b = 4:  ad6d89440b t4214: explicitly list tags in log
5:  0b84bf5417 ! 5:  e58c1929bc t4214: demonstrate octopus graph coloring failure
    @@ Commit message
         dash should be the color of the line to their bottom-right. Instead, they
         are currently the color of the line to their bottom.
     
    -    Demonstrate this breakage with two sets of test cases. The first pair of
    -    test cases demonstrates the breakage with a similar case as the above.
    -    The second pair of test cases demonstrates a similar breakage but with
    -    the last parent crossing over.
    +    Demonstrate this breakage with a few sets of test cases. These test
    +    cases should show not only simple cases of the bug occuring but trickier
    +    situations that may not be handled properly in any attempt to fix the
    +    bug.
     
    -    The second pair of test cases are included as a result of my (poor)
    -    attempts at fixing the bug. This case seems particularly tricky to
    -    handle. Good luck!
    +    While we're at it, include a passing test case as a canary in case an
    +    attempt to fix the bug breaks existing operation.
     
      ## t/t4214-log-graph-octopus.sh ##
     @@ t/t4214-log-graph-octopus.sh: test_expect_success 'set up merge history' '
    @@ t/t4214-log-graph-octopus.sh: test_expect_success 'set up merge history' '
     -	test_commit left
     +	test_commit left &&
     +	git checkout 4 -b crossover &&
    -+	test_commit after-4
    ++	test_commit after-4 &&
    ++	git checkout initial -b more-L &&
    ++	test_commit after-initial
      '
      
      test_expect_success 'log --graph with tricky octopus merge, no color' '
    @@ t/t4214-log-graph-octopus.sh: test_expect_success 'log --graph with normal octop
      	test_cmp expect.colors actual.colors
      '
     +
    -+test_expect_success 'log --graph with tricky octopus merge and its parent, no color' '
    ++test_expect_success 'log --graph with normal octopus merge and child, no color' '
    ++	cat >expect.uncolored <<-\EOF &&
    ++	* after-merge
    ++	*---.   octopus-merge
    ++	|\ \ \
    ++	| | | * 4
    ++	| | * | 3
    ++	| | |/
    ++	| * | 2
    ++	| |/
    ++	* | 1
    ++	|/
    ++	* initial
    ++	EOF
    ++	git log --color=never --graph --date-order --pretty=tformat:%s after-merge >actual.raw &&
    ++	sed "s/ *\$//" actual.raw >actual &&
    ++	test_cmp expect.uncolored actual
    ++'
    ++
    ++test_expect_failure 'log --graph with normal octopus and child merge with colors' '
    ++	cat >expect.colors <<-\EOF &&
    ++	* after-merge
    ++	*<BLUE>-<RESET><BLUE>-<RESET><MAGENTA>-<RESET><MAGENTA>.<RESET>   octopus-merge
    ++	<GREEN>|<RESET><YELLOW>\<RESET> <BLUE>\<RESET> <MAGENTA>\<RESET>
    ++	<GREEN>|<RESET> <YELLOW>|<RESET> <BLUE>|<RESET> * 4
    ++	<GREEN>|<RESET> <YELLOW>|<RESET> * <MAGENTA>|<RESET> 3
    ++	<GREEN>|<RESET> <YELLOW>|<RESET> <MAGENTA>|<RESET><MAGENTA>/<RESET>
    ++	<GREEN>|<RESET> * <MAGENTA>|<RESET> 2
    ++	<GREEN>|<RESET> <MAGENTA>|<RESET><MAGENTA>/<RESET>
    ++	* <MAGENTA>|<RESET> 1
    ++	<MAGENTA>|<RESET><MAGENTA>/<RESET>
    ++	* initial
    ++	EOF
    ++	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
    ++	git log --color=always --graph --date-order --pretty=tformat:%s after-merge >actual.colors.raw &&
    ++	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
    ++	test_cmp expect.colors actual.colors
    ++'
    ++
    ++test_expect_success 'log --graph with tricky octopus merge and its child, no color' '
     +	cat >expect.uncolored <<-\EOF &&
     +	* left
     +	| * after-merge
    @@ t/t4214-log-graph-octopus.sh: test_expect_success 'log --graph with normal octop
     +	test_cmp expect.uncolored actual
     +'
     +
    -+test_expect_failure 'log --graph with tricky octopus merge and its parent with colors' '
    ++test_expect_failure 'log --graph with tricky octopus merge and its child with colors' '
     +	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
     +	cat >expect.colors <<-\EOF &&
     +	* left
    @@ t/t4214-log-graph-octopus.sh: test_expect_success 'log --graph with normal octop
     +	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
     +	test_cmp expect.colors actual.colors
     +'
    ++
    ++test_expect_success 'log --graph with crossover in octopus merge and its child, no color' '
    ++	cat >expect.uncolored <<-\EOF &&
    ++	* after-4
    ++	| * after-merge
    ++	| *---.   octopus-merge
    ++	| |\ \ \
    ++	| |_|_|/
    ++	|/| | |
    ++	* | | | 4
    ++	| | | * 3
    ++	| |_|/
    ++	|/| |
    ++	| | * 2
    ++	| |/
    ++	|/|
    ++	| * 1
    ++	|/
    ++	* initial
    ++	EOF
    ++	git log --color=never --graph --date-order --pretty=tformat:%s after-4 after-merge >actual.raw &&
    ++	sed "s/ *\$//" actual.raw >actual &&
    ++	test_cmp expect.uncolored actual
    ++'
    ++
    ++test_expect_failure 'log --graph with crossover in octopus merge and its child with colors' '
    ++	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
    ++	cat >expect.colors <<-\EOF &&
    ++	* after-4
    ++	<RED>|<RESET> * after-merge
    ++	<RED>|<RESET> *<MAGENTA>-<RESET><MAGENTA>-<RESET><RED>-<RESET><RED>.<RESET>   octopus-merge
    ++	<RED>|<RESET> <YELLOW>|<RESET><BLUE>\<RESET> <MAGENTA>\<RESET> <RED>\<RESET>
    ++	<RED>|<RESET> <YELLOW>|<RESET><RED>_<RESET><BLUE>|<RESET><RED>_<RESET><MAGENTA>|<RESET><RED>/<RESET>
    ++	<RED>|<RESET><RED>/<RESET><YELLOW>|<RESET> <BLUE>|<RESET> <MAGENTA>|<RESET>
    ++	* <YELLOW>|<RESET> <BLUE>|<RESET> <MAGENTA>|<RESET> 4
    ++	<CYAN>|<RESET> <YELLOW>|<RESET> <BLUE>|<RESET> * 3
    ++	<CYAN>|<RESET> <YELLOW>|<RESET><CYAN>_<RESET><BLUE>|<RESET><CYAN>/<RESET>
    ++	<CYAN>|<RESET><CYAN>/<RESET><YELLOW>|<RESET> <BLUE>|<RESET>
    ++	<CYAN>|<RESET> <YELLOW>|<RESET> * 2
    ++	<CYAN>|<RESET> <YELLOW>|<RESET><CYAN>/<RESET>
    ++	<CYAN>|<RESET><CYAN>/<RESET><YELLOW>|<RESET>
    ++	<CYAN>|<RESET> * 1
    ++	<CYAN>|<RESET><CYAN>/<RESET>
    ++	* initial
    ++	EOF
    ++	git log --color=always --graph --date-order --pretty=tformat:%s after-4 after-merge >actual.colors.raw &&
    ++	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
    ++	test_cmp expect.colors actual.colors
    ++'
    ++
    ++test_expect_success 'log --graph with unrelated commit and octopus tip, no color' '
    ++	cat >expect.uncolored <<-\EOF &&
    ++	* after-initial
    ++	| *---.   octopus-merge
    ++	| |\ \ \
    ++	| | | | * 4
    ++	| |_|_|/
    ++	|/| | |
    ++	| | | * 3
    ++	| |_|/
    ++	|/| |
    ++	| | * 2
    ++	| |/
    ++	|/|
    ++	| * 1
    ++	|/
    ++	* initial
    ++	EOF
    ++	git log --color=never --graph --date-order --pretty=tformat:%s after-initial octopus-merge >actual.raw &&
    ++	sed "s/ *\$//" actual.raw >actual &&
    ++	test_cmp expect.uncolored actual
    ++'
    ++
    ++test_expect_success 'log --graph with unrelated commit and octopus tip with colors' '
    ++	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
    ++	cat >expect.colors <<-\EOF &&
    ++	* after-initial
    ++	<RED>|<RESET> *<BLUE>-<RESET><BLUE>-<RESET><MAGENTA>-<RESET><MAGENTA>.<RESET>   octopus-merge
    ++	<RED>|<RESET> <GREEN>|<RESET><YELLOW>\<RESET> <BLUE>\<RESET> <MAGENTA>\<RESET>
    ++	<RED>|<RESET> <GREEN>|<RESET> <YELLOW>|<RESET> <BLUE>|<RESET> * 4
    ++	<RED>|<RESET> <GREEN>|<RESET><RED>_<RESET><YELLOW>|<RESET><RED>_<RESET><BLUE>|<RESET><RED>/<RESET>
    ++	<RED>|<RESET><RED>/<RESET><GREEN>|<RESET> <YELLOW>|<RESET> <BLUE>|<RESET>
    ++	<RED>|<RESET> <GREEN>|<RESET> <YELLOW>|<RESET> * 3
    ++	<RED>|<RESET> <GREEN>|<RESET><RED>_<RESET><YELLOW>|<RESET><RED>/<RESET>
    ++	<RED>|<RESET><RED>/<RESET><GREEN>|<RESET> <YELLOW>|<RESET>
    ++	<RED>|<RESET> <GREEN>|<RESET> * 2
    ++	<RED>|<RESET> <GREEN>|<RESET><RED>/<RESET>
    ++	<RED>|<RESET><RED>/<RESET><GREEN>|<RESET>
    ++	<RED>|<RESET> * 1
    ++	<RED>|<RESET><RED>/<RESET>
    ++	* initial
    ++	EOF
    ++	git log --color=always --graph --date-order --pretty=tformat:%s after-initial octopus-merge >actual.colors.raw &&
    ++	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
    ++	test_cmp expect.colors actual.colors
    ++'
    ++
    ++test_expect_success 'log --graph with unrelated commit and octopus child, no color' '
    ++	cat >expect.uncolored <<-\EOF &&
    ++	* after-initial
    ++	| * after-merge
    ++	| *---.   octopus-merge
    ++	| |\ \ \
    ++	| | | | * 4
    ++	| |_|_|/
    ++	|/| | |
    ++	| | | * 3
    ++	| |_|/
    ++	|/| |
    ++	| | * 2
    ++	| |/
    ++	|/|
    ++	| * 1
    ++	|/
    ++	* initial
    ++	EOF
    ++	git log --color=never --graph --date-order --pretty=tformat:%s after-initial after-merge >actual.raw &&
    ++	sed "s/ *\$//" actual.raw >actual &&
    ++	test_cmp expect.uncolored actual
    ++'
    ++
    ++test_expect_failure 'log --graph with unrelated commit and octopus child with colors' '
    ++	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
    ++	cat >expect.colors <<-\EOF &&
    ++	* after-initial
    ++	<RED>|<RESET> * after-merge
    ++	<RED>|<RESET> *<MAGENTA>-<RESET><MAGENTA>-<RESET><CYAN>-<RESET><CYAN>.<RESET>   octopus-merge
    ++	<RED>|<RESET> <YELLOW>|<RESET><BLUE>\<RESET> <MAGENTA>\<RESET> <CYAN>\<RESET>
    ++	<RED>|<RESET> <YELLOW>|<RESET> <BLUE>|<RESET> <MAGENTA>|<RESET> * 4
    ++	<RED>|<RESET> <YELLOW>|<RESET><RED>_<RESET><BLUE>|<RESET><RED>_<RESET><MAGENTA>|<RESET><RED>/<RESET>
    ++	<RED>|<RESET><RED>/<RESET><YELLOW>|<RESET> <BLUE>|<RESET> <MAGENTA>|<RESET>
    ++	<RED>|<RESET> <YELLOW>|<RESET> <BLUE>|<RESET> * 3
    ++	<RED>|<RESET> <YELLOW>|<RESET><RED>_<RESET><BLUE>|<RESET><RED>/<RESET>
    ++	<RED>|<RESET><RED>/<RESET><YELLOW>|<RESET> <BLUE>|<RESET>
    ++	<RED>|<RESET> <YELLOW>|<RESET> * 2
    ++	<RED>|<RESET> <YELLOW>|<RESET><RED>/<RESET>
    ++	<RED>|<RESET><RED>/<RESET><YELLOW>|<RESET>
    ++	<RED>|<RESET> * 1
    ++	<RED>|<RESET><RED>/<RESET>
    ++	* initial
    ++	EOF
    ++	git log --color=always --graph --date-order --pretty=tformat:%s after-initial after-merge >actual.colors.raw &&
    ++	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
    ++	test_cmp expect.colors actual.colors
    ++'
     +
      test_done
-- 
2.23.0.565.g1cc52d20df


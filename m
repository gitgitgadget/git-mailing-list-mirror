Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F77E1F453
	for <e@80x24.org>; Fri, 26 Apr 2019 19:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfDZTVK (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 15:21:10 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37285 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfDZTVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 15:21:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id e6so2065397pgc.4
        for <git@vger.kernel.org>; Fri, 26 Apr 2019 12:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Sp20/l1rHLhghCURsfrmtepxT1/A08retYRamuwlf00=;
        b=QS3Tmoa8vURsMmBsJv5us0etKdZeUSGarWAnbUcgvR93LE41S4ajKaqAK4H2Sr/b3I
         d3fGnR7qNQKQKtqlPaGXW2SAIeMkmfIhwnu76PCSaBmnf1WKZ9C7Moly9lft7Me1zcCT
         EsDO30AW7Y176ceEYRj/86KsnWY0hYr/XRzQSlb2Jq+gVLxtPvq1MkjYJ9UAYac7UpRl
         t6mIXdM7osTmS0vXe0OtymT9skY698KC3GSUKi0KxWESZQIspeOAOuuiv+12lEBZQhxV
         rCxmkrBsZlu77tSwlFrO8DTwx97xjVKfNOSOYP2dJgcReb1H2II9Yj/cr2abhvlP1fet
         Apag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Sp20/l1rHLhghCURsfrmtepxT1/A08retYRamuwlf00=;
        b=jgD21yjFOARYG49SKw7gXyXTEQKuQL9mei222BnLWBuxuye5u39tkMB0trWD5GcRXx
         DvPJcxMrs1s31bojLklN5mK7iengJpqDWjdHlz0S4ZQnaxsw1OYgRRdaAg5NcZ4mbMc6
         jYLb3DEDg01rSWsgkkQvaIocld2NQK2imzHTqeU3yzoxu1zvQ7isS4gt9evpsxvN0sey
         dXXpZwVW170vle45Pz6VwiwssQlODp80zjMqQFU9crg9Fn+ecgK3W0kf5k8JVeOfidVJ
         kgRYgU2yhXcxvmx74D5sqTZG/ah82e4TQ6JsfZ6J9/lsTDzDowKDDDquXWX7TsHAdlVM
         0XDA==
X-Gm-Message-State: APjAAAWBolF6WqyMnR3YdlzzW8RZKhoNARUuTT1ckUOyRrlu0ZSS5DyS
        lSrumy67BFvWhgCLz8ENJJQPUec6K/8=
X-Google-Smtp-Source: APXvYqyR9URS25HccHfpHRk22QqxAcr7lk4OTl/v9omlO3jsIZHBCSvowgkx87SpeTYoDESJs78leA==
X-Received: by 2002:a63:2bc8:: with SMTP id r191mr9706054pgr.72.1556306468319;
        Fri, 26 Apr 2019 12:21:08 -0700 (PDT)
Received: from dev-l ([149.28.199.249])
        by smtp.gmail.com with ESMTPSA id 129sm46859845pgc.24.2019.04.26.12.21.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 12:21:07 -0700 (PDT)
Date:   Fri, 26 Apr 2019 12:21:06 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/3] allow checkout and branch to create branches on a
 merge base
Message-ID: <cover.1556305561.git.liu.denton@gmail.com>
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

Thanks for your comments, Eric and Junio.

Eric, I've combined the `test_when_finished` calls together so that the
statements within appear in a more "logical" order.

Junio, I've taken your suggestion and moved the change into
`create_branch`. Initially, I didn't want to do this because I didn't
want to change the semantics of git-branch but introducing the merge
base syntax seems to be a positive change so let's do it.

Thanks,

Denton

---

Changes since v1:

* Moved multiple `test_when_finished` calls that appeared in "reverse
  order" into one call that appears in the logical order
* Made create_branch handle merge base revs instead of putting a hack
  into checkout

Denton Liu (3):
  t2018: cleanup in current test
  t2018: demonstrate checkout -b merge base bug
  branch: make create_branch accept a merge base rev

 Documentation/git-branch.txt |  6 +++-
 branch.c                     |  2 +-
 t/t2018-checkout-branch.sh   | 56 +++++++++++++++++++-----------------
 t/t3200-branch.sh            | 14 ++++++---
 4 files changed, 46 insertions(+), 32 deletions(-)

Range-diff against v1:
1:  c0c7171e3d ! 1:  9d04faf29d t2018: cleanup in current test
    @@ -19,8 +19,9 @@
      '
      
      test_expect_success 'checkout -b to a new branch, set to HEAD' '
    -+	test_when_finished test_might_fail git branch -D branch2 &&
    -+	test_when_finished git checkout branch1 &&
    ++	test_when_finished "
    ++		git checkout branch1 &&
    ++		test_might_fail git branch -D branch2" &&
      	do_checkout branch2
      '
      
    @@ -28,8 +29,9 @@
     -	git checkout branch1 &&
     -	git branch -D branch2 &&
     -
    -+	test_when_finished test_might_fail git branch -D branch2 &&
    -+	test_when_finished git checkout branch1 &&
    ++	test_when_finished "
    ++		git checkout branch1 &&
    ++		test_might_fail git branch -D branch2" &&
      	do_checkout branch2 $HEAD1
      '
      
    @@ -45,8 +47,9 @@
      '
      
      test_expect_success 'checkout -f -b to a new branch with unmergeable changes discards changes' '
    -+	test_when_finished test_might_fail git branch -D branch2 &&
    -+	test_when_finished git checkout branch1 &&
    ++	test_when_finished "
    ++		git checkout branch1 &&
    ++		test_might_fail git branch -D branch2" &&
     +
      	# still dirty and on branch1
      	do_checkout branch2 $HEAD1 "-f -b" &&
    @@ -58,9 +61,10 @@
     -
     -	# clean up from previous test
     -	git branch -D branch2 &&
    -+	test_when_finished test_might_fail git branch -D branch2 &&
    -+	test_when_finished git checkout branch1 &&
    -+	test_when_finished git reset --hard &&
    ++	test_when_finished "
    ++		git reset --hard &&
    ++		git checkout branch1 &&
    ++		test_might_fail git branch -D branch2" &&
      
      	setup_dirty_mergeable &&
      	do_checkout branch2 $HEAD1 &&
2:  ff38bdb564 ! 2:  5e8320cd80 t2018: demonstrate checkout -b merge base bug
    @@ -28,21 +28,21 @@
      '
      
     +test_expect_failure 'checkout -b to a merge base' '
    -+	test_when_finished test_might_fail git branch -D branch2 &&
    -+	test_when_finished git checkout branch1 &&
    ++	test_when_finished "
    ++		git checkout branch1 &&
    ++		test_might_fail git branch -D branch2" &&
     +	git checkout -b branch2 branch1...
     +'
     +
      test_expect_success 'checkout -b to a new branch, set to an explicit ref' '
    - 	test_when_finished test_might_fail git branch -D branch2 &&
    - 	test_when_finished git checkout branch1 &&
    + 	test_when_finished "
    + 		git checkout branch1 &&
     @@
      	do_checkout branch2 "" -B
      '
      
     +test_expect_failure 'checkout -B to a merge base' '
     +	git checkout branch1 &&
    -+	git branch -D branch2 &&
     +
     +	git checkout -B branch2 branch1...
     +'
3:  031780431d < -:  ---------- checkout: allow -b/-B to work on a merge base
-:  ---------- > 3:  c91c7535a7 branch: make create_branch accept a merge base rev
-- 
2.21.0.1033.g0e8cc1100c


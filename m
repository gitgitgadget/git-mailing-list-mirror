Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 570B21F453
	for <e@80x24.org>; Sat, 27 Apr 2019 12:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbfD0MCV (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Apr 2019 08:02:21 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45033 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfD0MCU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Apr 2019 08:02:20 -0400
Received: by mail-pl1-f195.google.com with SMTP id l2so50819plt.11
        for <git@vger.kernel.org>; Sat, 27 Apr 2019 05:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/+HwACN1fMcg0XbL5Arbynge+ftQeedoot011gFUdY4=;
        b=njqsrVS/YSml3eF42Tw905dsrLYV+BAFHOj8xKyGhy0HS84GRBRpVM0absrNaCocXr
         wSbpaCiyZ1PdtXRV7O1XVmZI1iceD5T1/saY7V/f7J/bDiTi13CLrCrN/KwylcVZ9lel
         AH2lAa9q9PuCGyjEfpw/YWT4UKGhPOI/LUsE7IZ2Irzjx+ObXKvAbdcfnE15aTly0qzm
         6Fi4MEoxboFW17sP0x2VqUaV2VMyLPVhaqXKpUm6yi1OgCTA9/Zg4fOliAzGCaNcOpMP
         gaU+UB5ijUIVeoNdHEPOSZ1B8vMDaJ1iWcEmHOFQ8rDhxPVF0f3nDTG2aq/gk8lPtcxv
         rdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/+HwACN1fMcg0XbL5Arbynge+ftQeedoot011gFUdY4=;
        b=kJaq/XDRtkPggOcRnkPB8/DC2xlmER1j3S0qngNErlO6ykd5kJ1WDqDsz9+aPxbkI1
         frsUtK8rih++rygSVqEsHK1aDNyM/jdhIYpC/GZiJrt7hDkcWkhVdyZprByZyg7X203A
         E4aFrW56eqSyIEntszwaW/dtJzFmnVgQ69zV68oqsrPU49Q1tBd0/KZYD8nIE6HOcC6y
         0AY58cEAlTgNFxmZa2XKJ/l93Pp9eOFRYDKYsr4VFj0qaMETWMCulOhzFr3UDhYFKCyi
         V60LVm0CsWUB4vvF9o/MhdoivsdFB1AwOQbcnoOVNdtr/WMoU5ZgyEu2p0ZoYehbu61q
         UAQg==
X-Gm-Message-State: APjAAAVi63fYR5FRNBQkQBzsfRZ1BIj3s1ZzP7/9Zuhdqy/MBEtghQHA
        68gah8MwL1SD2jz5d+dvpxGg8Woe
X-Google-Smtp-Source: APXvYqzVQXu8lQiE13/a0zT3nmfpL3stzZSzbH/G7y6MizKrdIsxkRAF0IFDFXrrCw76TMp1dYTMHA==
X-Received: by 2002:a17:902:1621:: with SMTP id g30mr51212999plg.168.1556366539919;
        Sat, 27 Apr 2019 05:02:19 -0700 (PDT)
Received: from archbookpro.localdomain ([216.9.110.12])
        by smtp.gmail.com with ESMTPSA id 25sm43926354pfo.145.2019.04.27.05.02.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Apr 2019 05:02:18 -0700 (PDT)
Date:   Sat, 27 Apr 2019 05:02:16 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/2] allow checkout and branch to create branches on a
 merge base
Message-ID: <cover.1556366347.git.liu.denton@gmail.com>
References: <cover.1556305561.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556305561.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks again for the review, Junio.

I've squashed 2/3 and 3/3 together and made that documentation change I
was talking about earlier.

---

Changes since v2:

* Squashed 2/3 with 3/3
* Document merge base syntax for <start_point> in git-checkout.txt

Changes since v1:

* Moved multiple `test_when_finished` calls that appeared in "reverse
  order" into one call that appears in the logical order
* Made create_branch handle merge base revs instead of putting a hack
  into checkout

Denton Liu (2):
  t2018: cleanup in current test
  branch: make create_branch accept a merge base rev

 Documentation/git-branch.txt   |  6 +++-
 Documentation/git-checkout.txt |  4 +++
 branch.c                       |  2 +-
 t/t2018-checkout-branch.sh     | 56 ++++++++++++++++++----------------
 t/t3200-branch.sh              | 14 ++++++---
 5 files changed, 50 insertions(+), 32 deletions(-)

Range-diff against v2:
1:  9d04faf29d = 1:  9d04faf29d t2018: cleanup in current test
2:  5e8320cd80 < -:  ---------- t2018: demonstrate checkout -b merge base bug
3:  c91c7535a7 ! 2:  bb25852740 branch: make create_branch accept a merge base rev
    @@ -41,6 +41,21 @@
      Note that this will create the new branch, but it will not switch the
      working tree to it; use "git checkout <newbranch>" to switch to the
     
    + diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
    + --- a/Documentation/git-checkout.txt
    + +++ b/Documentation/git-checkout.txt
    +@@
    + <start_point>::
    + 	The name of a commit at which to start the new branch; see
    + 	linkgit:git-branch[1] for details. Defaults to HEAD.
    +++
    ++As a special case, you may use `"A...B"` as a shortcut for the
    ++merge base of `A` and `B` if there is exactly one merge base. You can
    ++leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
    + 
    + <tree-ish>::
    + 	Tree to checkout from (when paths are given). If not specified,
    +
      diff --git a/branch.c b/branch.c
      --- a/branch.c
      +++ b/branch.c
    @@ -61,20 +76,29 @@
      	do_checkout branch2
      '
      
    --test_expect_failure 'checkout -b to a merge base' '
     +test_expect_success 'checkout -b to a merge base' '
    ++	test_when_finished "
    ++		git checkout branch1 &&
    ++		test_might_fail git branch -D branch2" &&
    ++	git checkout -b branch2 branch1...
    ++'
    ++
    + test_expect_success 'checkout -b to a new branch, set to an explicit ref' '
      	test_when_finished "
      		git checkout branch1 &&
    - 		test_might_fail git branch -D branch2" &&
     @@
      	do_checkout branch2 "" -B
      '
      
    --test_expect_failure 'checkout -B to a merge base' '
     +test_expect_success 'checkout -B to a merge base' '
    - 	git checkout branch1 &&
    ++	git checkout branch1 &&
    ++
    ++	git checkout -B branch2 branch1...
    ++'
    ++
    + test_expect_success 'checkout -B to an existing branch from detached HEAD resets branch to HEAD' '
    + 	git checkout $(git rev-parse --verify HEAD) &&
      
    - 	git checkout -B branch2 branch1...
     
      diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
      --- a/t/t3200-branch.sh
-- 
2.21.0.1000.g11cd861522


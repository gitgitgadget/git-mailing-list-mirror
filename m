Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21A2B1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 13:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbeGPN1g (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 09:27:36 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:41872 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbeGPN1g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 09:27:36 -0400
Received: by mail-pg1-f170.google.com with SMTP id z8-v6so5997560pgu.8
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 06:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=d3qE/y6ddXpx6g6WABGs109JsFtwT7KpBab0zexXLjQ=;
        b=i0R2Ng8fbE6NjYGQWxgoEWvSuchuG7as480DshhSTlpSQIu36aFWpEGpjSVNhY+yKJ
         dCoVDhbfr/Tn6tD7D+m2H46Y9s2nC736WQ1UfE/HNItFD71t1olafKFNWZCaGUHcMEfE
         oPcKNx7+8no+ya+5LpS4Phq3RHn6wRK9PIeP3qaULLOnL1oen91YtFRN4zdGvZeM/e1e
         t+uONvfdNeJAFHkzUwJ31x5W/eEyYQj9cnpsRt37Gl+wYdsScnrTqnMvEFr/kDkdzrXf
         IDlAFufzNnlmK28KqJE0wV2lsVeDKX6UZN3G+mY4csxaEnU3yKsIYSz1wUrJBMCIAJ5t
         CiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=d3qE/y6ddXpx6g6WABGs109JsFtwT7KpBab0zexXLjQ=;
        b=MKdWQqIwT4V55sZla78epOISMONHQLhr+6zIZmri2lknMSF2hvUQGfi4Nk0L5CnpD5
         OBt7BV/CspGIddWHZ50qtfbVEBy0GyYLzNRUYGaGbX9Hpm4M/xu9RbRnKjxm1P2LqaQf
         62DQ300T1jxJ5cSuHzB3uW4bZKLk4fZbWnrbqTZKeg5eiZ2JsITYe47o5+cPXXvJkVYo
         4BbiloKJ2yxTGYq5g5HtQnYMmE9AQyj6rFS8FAKAn9r8ArsLPufE94sxzzfbrI8OCwN1
         vpgrE4UBewbC/kHmtc59HD3CKUbiDfdkLVsKV0RlfuKB/nWbWDE1I3PVNsY1J/Mh0/cS
         R7Ug==
X-Gm-Message-State: AOUpUlHgingT+a9xxVZKRcU2EFDLluTMhyYWKQqp72jM8ch3sqY589WA
        FbnN+IdUHBiN0lwlo8XOPtx9QQ==
X-Google-Smtp-Source: AAOMgpe8XYGp9kmxd64iDEozcLJq6gBY3czrXBHT6l2UcJpHuP3hc79BdSmU0J8MzIDOsQ1AW0LUmA==
X-Received: by 2002:a65:5c83:: with SMTP id a3-v6mr15513692pgt.164.1531746015067;
        Mon, 16 Jul 2018 06:00:15 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id 10-v6sm64701826pfs.111.2018.07.16.06.00.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 06:00:14 -0700 (PDT)
Message-Id: <pull.10.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Jul 2018 13:00:04 +0000
Subject: [PATCH 00/16] Consolidate reachability logic
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are many places in Git that use a commit walk to determine
reachability between commits and/or refs. A lot of this logic is
duplicated.

I wanted to achieve the following:

1. Consolidate several different commit walks into one file
2. Reduce duplicate reachability logic
3. Increase testability (correctness and performance)
4. Improve performance of reachability queries

My approach is mostly in three parts:

  I. Move code to a new commit-reach.c file.
 II. Add a 'test-tool reach' command to test these methods directly.
III. Modify the logic by improving performance and calling methods with
     similar logic but different prototypes.

The 'test-tool reach' command is helpful to make sure I don't break
anything as I change the logic, but also so I can test methods that are
normally only exposed by other more complicated commands. For instance,
ref_newer() is part of 'git push -f' and ok_to_give_up() is buried deep
within fetch negotiation. Both of these methods have some problematic
performance issues that are corrected by this series. As I discovered
them, it was clear that it would be better to consolidate walk logic
instead of discovering a new walk in another file hidden somewhere.

For the ok_to_give_up() method, I refactored the method so I could pull
the logic out of the depths of fetch negotiation. In the commit
"commit-reach: make can_all_from_reach... linear" I discuss how the
existing algorithm is quadratic and how we can make it linear. Also, we
can use heuristic knowledge about the shape of the commit graph and the
usual haves/wants to get some extra performance bonus. (The heuristic is
to do a DFS with first-parents first, and stop on first found result. We
expect haves/wants to include ref tips, which typically have their
previous values in their first-parent history.)

One major difference in this series versus the RFC is that I added a new
method 'generation_numbers_enabled()' to detect if we have a commit-graph
file with non-zero generation numbers. Using can_all_from_reach in
is_descendant_of is only faster if we have generation numbers as a cutoff.

Thanks,
-Stolee

This series is based on jt/commit-graph-per-object-store

CC: sbeller@google.com

Derrick Stolee (16):
  commit-reach: move walk methods from commit.c
  commit-reach: move ref_newer from remote.c
  commit-reach: move commit_contains from ref-filter
  upload-pack: make reachable() more generic
  upload-pack: refactor ok_to_give_up()
  upload-pack: generalize commit date cutoff
  commit-reach: move can_all_from_reach_with_flags
  test-reach: create new test tool for ref_newer
  test-reach: test in_merge_bases
  test-reach: test is_descendant_of
  test-reach: test get_merge_bases_many
  test-reach: test reduce_heads
  test-reach: test can_all_from_reach_with_flags
  commit-reach: replace ref_newer logic
  commit-reach: make can_all_from_reach... linear
  commit-reach: use can_all_from_reach

 Makefile              |   2 +
 builtin/remote.c      |   1 +
 commit-graph.c        |  18 ++
 commit-graph.h        |   6 +
 commit-reach.c        | 662 ++++++++++++++++++++++++++++++++++++++++++
 commit-reach.h        |  76 +++++
 commit.c              | 358 -----------------------
 fast-import.c         |   1 +
 http-push.c           |   1 +
 ref-filter.c          | 147 +---------
 remote.c              |  50 +---
 remote.h              |   1 -
 t/helper/test-reach.c | 104 +++++++
 t/helper/test-tool.c  |   1 +
 t/helper/test-tool.h  |   1 +
 t/t6600-test-reach.sh | 208 +++++++++++++
 upload-pack.c         |  58 +---
 17 files changed, 1095 insertions(+), 600 deletions(-)
 create mode 100644 commit-reach.c
 create mode 100644 commit-reach.h
 create mode 100644 t/helper/test-reach.c
 create mode 100755 t/t6600-test-reach.sh


base-commit: 596e28576ef3ca69432dbe5953b7bdcd18a32876
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-10%2Fderrickstolee%2Freach%2Frefactor-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-10/derrickstolee/reach/refactor-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/10
-- 
gitgitgadget

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A72F81F462
	for <e@80x24.org>; Thu, 25 Jul 2019 17:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403771AbfGYRqS (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 13:46:18 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:42326 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfGYRqS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 13:46:18 -0400
Received: by mail-pf1-f170.google.com with SMTP id q10so23108329pff.9
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 10:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e3LHto13lSPz6bYcWc5gbvnriJxaFRtqS1x6atwTrus=;
        b=ALjVJEsRxky3cOda9Ko1EZGFrlJgn82khd+I4ukZ18x0QZ3nX64nenP3+Uvpy9Elyx
         PbzyuyBKqwODMvfmv79akUsD+QpX5k63ojwv5n+ptFMtkFUfpxOjHXqeI2NP0qybR5Nz
         lRXGMhI5ipVRUQp0Bffe8NsqKNsnzKsqz4vkoi5byh8+FxYqjceAFYUBB2SVkbHllKOZ
         p6ypV4EpMl7iY9SAIEc3shgP23Yl6dtd4/yDAb3VCx4Mc+f7VKrDFiTyDklxOE12pERw
         5NsSnAVuIhuBiv2Om0su+u8xA6lBTqhi9y3iTnoiuYcLcsySQtw4KYHFIxgu8i1cUfAi
         PsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e3LHto13lSPz6bYcWc5gbvnriJxaFRtqS1x6atwTrus=;
        b=CT/F0btX6NycXX3KXJwuOD0VgOIpWOo/jg4I2KxNB5MGb+V1hfxo7TwOoONDX+lj5a
         rGX4if9PjgkTZkCR2pu9a6jcBbDXvkfVmnTAfcN9C04KUH5/kKuwW9c0bGEDgmSvgQnv
         Zceb7RoWZQFW1sg5v95Ra4aTccHX9aAO4B3Z4ajMARInw2irdHIOSPCcC5RrCFeMeAJk
         431LzTpzMXdsTG+gnuJWRbDqR1WBb95watWJHDB24wCCMw45ByCmmEQlrvQROIfvjv8R
         /QYsE4/+/0hsUd5A2/Z0XEAz2CkVVLzJM/r0Ww2l8fisqj76c+3xaPuimU7qV4xk02e8
         /xCA==
X-Gm-Message-State: APjAAAXMFgiJqhsw70zGPJSzOPCNZGhFeoCM4rVaI6uIIAkBoFUnvt6g
        p+Qpr1uht/leubbA7wyhnJM36x9m
X-Google-Smtp-Source: APXvYqwqdPL3BN4hoqOAQF5OeFqfhRGvzSJm9gemvBvgH60D0vrLMHSPmCcYD+gISASot4cOHiOPSg==
X-Received: by 2002:a62:1c93:: with SMTP id c141mr18395182pfc.9.1564076777199;
        Thu, 25 Jul 2019 10:46:17 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id v138sm58171800pfc.15.2019.07.25.10.46.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jul 2019 10:46:16 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 00/19] Cleanup merge API
Date:   Thu, 25 Jul 2019 10:45:52 -0700
Message-Id: <20190725174611.14802-1-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.559.g28a8880890.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before writing a replacement merge strategy for recursive, I decided
to first cleanup the merge API -- streamlining merge-recursive.h and
making it more readable.  It includes some fixes I noticed along the
way, and the last two patches were some forgotten changes of mine I
rediscovered that had minor textual conflicts before I rebased them on
this series.

    While there are minor textual and semantic dependencies between
    these patches (preventing me from splitting up this series), they
    are logically separate and can be reviewed independently.

Stuff I'd most welcome review on:
  * Is cache-tree.c the right place for write_tree_from_memory()?
    [see patch 7]  Should there be docs on how it differs from
    write_index_as_tree(), already found in cache-tree?  What does
    the latter even do?

Some notes:
  * Applies on master, merges cleanly to next & pu
  * Only patches 3, 5-7 touch anything outside of merge-recursive
  * Patches 1 & 3 are bugfixes, 2 & 4 arguably are too, but all are
    quite minor and do not need to be part of the impending release
    candidates or 2.23.0.
  * I'm going to be out next week (July 29-Aug 3), so I can only
    respond to feedback for the next couple days or it'll have to
    wait until the 5th.

Stuff I didn't address:
  * merge_recursive() empties the commit_list of merge_bases it is
    passed, so the caller is expected to NOT use it afterwards.  Seems
    suboptimal to place such an expectation on the caller.
  * All current callers (3 of them?) of merge_recursive() always pass
    it a specially created reversed-list for the merge_bases.  Some
    history spelunking provides no details on any of these about why;
    it appears that the 2nd and 3rd callers reversed the list because
    the first did, and I'm guessing the first did in an attempt to
    exactly match the git-merge-recursive.py scripts' behavior.  But
    if the API needs them in a reverse order from what people would
    normally expect to pass them in, shouldn't it reverse them itself
    instead of making all callers do it?  Also, the order shouldn't
    matter when there are no conflicts, and when there are conflicts
    it'd only change which side of the conflict markers the made-up
    virtual merge base would list things in.  However, we do have
    tests with recursive virtual merge bases and which test the
    output, and I didn't want to try to clean those all up.  Besides,
    the current order shows nicely when commits are named things like
    "L1", "L2", "R1", "R2" -- it's nice having a well defined left and
    right side.  Wasn't sure what to do yet, so I just punted for now;
    this series is already long enough...


Elijah Newren (19):
  merge-recursive: fix minor memory leak in error condition
  merge-recursive: remove another implicit dependency on the_repository
  Ensure index matches head before invoking merge machinery, round N
  merge-recursive: exit early if index != head
  merge-recursive: don't force external callers to do our logging
  Change call signature of write_tree_from_memory()
  Move write_tree_from_memory() from merge-recursive to cache-tree
  merge-recursive: fix some overly long lines
  merge-recursive: use common name for ancestors/common/base_list
  merge-recursive: rename 'mrtree' to 'result_tree', for clarity
  merge-recursive: rename merge_options argument to opt in header
  merge-recursive: move some definitions around to clean up the header
  merge-recursive: consolidate unnecessary fields in merge_options
  merge-recursive: comment and reorder the merge_options fields
  merge-recursive: split internal fields into a separate struct
  merge-recursive.c: alphabetize include list
  merge-recursive: rename MERGE_RECURSIVE_* to MERGE_VARIANT_*
  merge-recursive: be consistent with assert
  merge-recursive: provide a better label for diff3 common ancestor

 builtin/checkout.c                |   2 +-
 builtin/merge-recursive.c         |   4 +
 builtin/stash.c                   |   2 +
 cache-tree.c                      |  30 ++
 cache-tree.h                      |   2 +
 merge-recursive.c                 | 517 +++++++++++++++++-------------
 merge-recursive.h                 | 119 +++----
 sequencer.c                       |   1 -
 t/t3030-merge-recursive.sh        |   9 +-
 t/t6036-recursive-corner-cases.sh |   8 +-
 t/t6047-diff3-conflict-markers.sh | 191 +++++++++++
 11 files changed, 589 insertions(+), 296 deletions(-)
 create mode 100755 t/t6047-diff3-conflict-markers.sh

-- 
2.22.0.564.gb52f8ae349


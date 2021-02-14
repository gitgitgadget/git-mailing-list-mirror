Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E6BC433E0
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 07:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6887E64DCE
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 07:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhBNH7u (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 02:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbhBNH7r (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 02:59:47 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6590C061574
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 23:59:06 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id v14so4877701wro.7
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 23:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=jv84li70HDSptRSGGFzRwo7ivwBa5UuCmX2hl8bPx2E=;
        b=BppltNoKZc3OkmzbFFb/LGQjZac8LYgvWCx9bZ3W6BY6yLW1VIRVL08kdkmkkYSbpE
         VFHzO3lGXpNBFo3vLr7HIzZYXqmQPGi5fv5ILPRM4/1qSpZTLkmhpNUgCN47iOXbJmOT
         HQ0FHBeYBMdfRuKt4X7EeRUUb3NW65uRMTEcLVZ+K18RJamcUUFnFkT0QgSzBJsy/Ib9
         GBuX3BgB9sIpwOIdY4hDsx9pd+Y2+Q4wfNT5ywrcsxL2KHu84Swn7j5a9yC3QVb6wBjQ
         m3+YU4jnGbDe4PivpqTOfLdBC4d4bujH4eVt2/vaAPkXvaqzTXmmloCD+0eiRv4OCt0z
         8XSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=jv84li70HDSptRSGGFzRwo7ivwBa5UuCmX2hl8bPx2E=;
        b=p12ruGMSc+iMxmEDTrpOzLdrl41XbQoS7oJXbk0jjVSRQi37U4ngA+8vvChvWm/p3f
         43kuQm4WYo6WoYa6oZBmndhl6D5vsi13V13GKZ3FKjvowPvUF4RyG0Av0RPajDXoUbgs
         hupuP2esv0wen/l/XQ2hScvh/qlezKTmjfEk6gq4mF8eJxPHiw/WUMkE9UzWenaEjony
         f+TZq40OBarrp+m8IK05DCIbcut0Ca4bsWlL5PnVCuM4Cn7HqMXK/eacXUsm0s9D846s
         T9UlO0+fS+WD8PmNdD7kMclyI0ku1W50S1EpKHA+DtELy8RD8uyyORFFyH0CT3LPYXrG
         3urw==
X-Gm-Message-State: AOAM533QS8Bvp8+r8MJ03/ofZiPE5tuRDCQyl9tx3gMHJ37m6im/p3me
        QNdrI5FUehYj5cwQZXCqiP4/rZpS6iY=
X-Google-Smtp-Source: ABdhPJwZmTttK5/oh2OH7yVtvsuGdq+9vZ/U4SBZ5yFaHvY9W9wnnglk2tEprd6QfwPdzzcp7ssyJQ==
X-Received: by 2002:adf:ee49:: with SMTP id w9mr8028016wro.144.1613289545273;
        Sat, 13 Feb 2021 23:59:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k11sm18132374wrl.84.2021.02.13.23.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 23:59:04 -0800 (PST)
Message-Id: <pull.844.git.1613289544.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Feb 2021 07:58:53 +0000
Subject: [PATCH 00/10] Optimization batch 8: use file basenames even more
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series depends on en/diffcore-rename (a concatenation of what I was
calling ort-perf-batch-6 and ort-perf-batch-7).

I apologize for submitting this so soon after a re-roll of the other two
series, but ideas from it kept coming up in the discussions, so I figured
it'd help to just have them all be submitted. This series can also be rolled
into en/diffcore-rename if it helps simplify.

=== Optimization idea ===

This series uses file basenames (portions of the path after the last '/',
including file extension) in a more involved fashion to guide rename
detection. It's a follow-on improvement to "Optimization #3" from my Git
Merge 2020 talk[1]. The basic idea behind this series is the same as the
last series: people frequently move files across directories while keeping
the filenames the same, thus files with the same basename are likely rename
candidates. However, the previous optimization only applies when basenames
are unique among remaining adds and deletes after exact rename detection, so
we need to do something else to match up the remaining basenames. When there
are many files with the same basename (e.g. .gitignore, Makefile,
build.gradle, or maybe even setup.c, AbtractFactory.java, etc.), being able
to "guess" which directory a given file likely would have moved to can
provide us with a likely rename candidate if there is a file with the same
basename in that directory. Since exact rename detection is done first, we
can use nearby exact renames to help us guess where any given non-unique
basename file may have moved; it just means doing "directory rename
detection" limited to exact renames.

There are definitely cases when this strategy still won't help us: (1) We
only use this strategy when the directory in which the original file was
found has also been removed, (2) a lack of exact renames from the given
directory will prevents us from making a new directory prediction, (3) even
if we predict a new directory there may be no file with the given basename
in it, and (4) even if there is an unmatched add with the appropriate
basename in the predicted directory, it may not meet the higher
min_basename_score similarity threshold.

It may be worth noting that directory rename detection at most predicts one
new directory, which we use to ensure that we only compare any given file
with at most one other file. That's important for compatibility with future
optimizations.

However, despite the caveats and limited applicability, this idea provides
some nice speedups.

=== Results ===

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28), the
changes in just this series improves the performance as follows:

                     Before Series           After Series
no-renames:       12.775 s ±  0.062 s    12.596 s ±  0.061 s
mega-renames:    188.754 s ±  0.284 s   130.465 s ±  0.259 s
just-one-mega:     5.599 s ±  0.019 s     3.958 s ±  0.010 s


As a reminder, before any merge-ort/diffcore-rename performance work, the
performance results we started with (as noted in the same commit message)
were:

no-renames-am:      6.940 s ±  0.485 s
no-renames:        18.912 s ±  0.174 s
mega-renames:    5964.031 s ± 10.459 s
just-one-mega:    149.583 s ±  0.751 s


=== Alternative, rejected idea ===

There was an alternative idea to the series presented here that I also
tried: instead of using directory rename detection based on exact renames to
predict where files would be renamed and then comparing to the file with the
same basename in the new directory, one could instead take all files with
the same basename -- both sources and destinations -- and then do a smaller
M x N comparison on all those files to find renames. Any non-matches after
that step could be combined with all other files for the big inexact rename
detection step.

There are two problems with such a strategy, though.

One is that in the worst case, you approximately double the cost of rename
detection (if most potential rename pairs all have the same basename but
they aren't actually matches, you end up comparing twice).

The second issue isn't clear until trying to combine this idea with later
performance optimizations. The next optimization will provide a way to
filter out several of the rename sources. If our inexact rename detection
matrix is sized 1 x 4000 because we can remove all but one source file, but
we have 100 files with the same basename, then a 100 x 100 comparison is
actually more costly than a 1 x 4000 comparison -- and we don't need most of
the renames from the 100 x 100 comparison. The advantage of the directory
rename detection based idea for finding which basenames to match up, is that
the cost for each file is linear (or, said another way, scales proportional
to doing a diff on that file). As such, the costs for this preliminary
optimization are nicely controlled and the worst case scenario is it has
spent a little extra time upfront but still has to do the full inexact
rename detection.

[1]
https://github.com/newren/presentations/blob/pdfs/merge-performance/merge-performance-slides.pdf

Elijah Newren (10):
  Move computation of dir_rename_count from merge-ort to diffcore-rename
  diffcore-rename: add functions for clearing dir_rename_count
  diffcore-rename: move dir_rename_counts into a dir_rename_info struct
  diffcore-rename: extend cleanup_dir_rename_info()
  diffcore-rename: compute dir_rename_counts in stages
  diffcore-rename: add a mapping of destination names to their indices
  diffcore-rename: add a dir_rename_guess field to dir_rename_info
  diffcore-rename: add a new idx_possible_rename function
  diffcore-rename: limit dir_rename_counts computation to relevant dirs
  diffcore-rename: use directory rename guided basename comparisons

 Documentation/gitdiffcore.txt |   2 +-
 diffcore-rename.c             | 439 ++++++++++++++++++++++++++++++++--
 diffcore.h                    |   7 +
 merge-ort.c                   | 144 +----------
 4 files changed, 439 insertions(+), 153 deletions(-)


base-commit: aeca14f748afc7fb5b65bca56ea2ebd970729814
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-844%2Fnewren%2Fort-perf-batch-8-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-844/newren/ort-perf-batch-8-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/844
-- 
gitgitgadget

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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B41EC433E1
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 21:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AB2761A01
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 21:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238471AbhCXVcm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 17:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238489AbhCXVch (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 17:32:37 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0138CC06174A
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 14:32:37 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 12so53968wmf.5
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 14:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=bnsolccDtQ8aCIxB67X/z562vK06NRfGV/+Iuo4hRWY=;
        b=Mt60sMZ3r47xFfR1K9NSd7Hfv5MMTomAnagIr9pjjxkT9okIyBDHmmWv3e4yWDo6bd
         VACkW5yfigXOguTiiEH4Yvu7Ok5W6E/K52vHhYboQkcDP/DoL+ZRwWIu5kuwsQfgd2Rh
         bv4JUAgAaVf/cI54CUNgV9d3irse+QD+U9p1Wgdt382deCr+zh3P53V+pJ00M6nSEwxx
         HLaBa4SlZ6fWDIuZAOxHZeO5ssqFsiV1M1AyDdsKBch15AciDm72aLgdOH9YOzb8VP60
         5UUDuoLWx8LKZRMa1It+DiFF/7W6ybVidXCq1S09JIfPEgOXE/Q7DV612ttP2zxi2l/H
         U+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=bnsolccDtQ8aCIxB67X/z562vK06NRfGV/+Iuo4hRWY=;
        b=fLfnpkgc9aGZbrgIQwG+GCuazNgeSV2q5ObnCtdINvOY5O1O0iMDQ0CzLDoBwpErdU
         qIAGe2DLDLoE5eNloRNy91OyxLov8CbCUEcPvVcT2/mvJstlwPim39hF7hJMkTJrZxVf
         gf4zLxUnmAOD6yJUstYiKHt2MiINQtlk6zf08Hk185qAfzp/c7xLvXhCziQUV1qmwYaN
         SRBoZIAq0xkspUlNCoGd8ql3DpyB4HXWzLzhCf7a1S9uy4/p8XzOTQ7bP8yW72TVRMKo
         WM1420URikdu8vq2luokkkHGHByqk1IjW80aXLcNo4Fi9wI8HBQfl9JrkNcTk46/SskI
         a3OQ==
X-Gm-Message-State: AOAM5327szntLKSHHk33gyyTCfe2LF5E/ewnY5kKtQojq5dMcmxZMsjC
        LQz5ajZ8Do4F4SEJOpE0+hrarSvBOt4=
X-Google-Smtp-Source: ABdhPJyqM6ji1LQ2hqf2PsGybQvRgZ4p460Hh53TMZpk2nmfTJiu/Awx0mEoKVsqRI4yU6i8++e1ww==
X-Received: by 2002:a7b:ce06:: with SMTP id m6mr4655848wmc.38.1616621555587;
        Wed, 24 Mar 2021 14:32:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g16sm4901510wrs.76.2021.03.24.14.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 14:32:34 -0700 (PDT)
Message-Id: <pull.859.git.1616621553.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 24 Mar 2021 21:32:26 +0000
Subject: [PATCH 0/7] Optimization batch 11: avoid repeatedly detecting same renames
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series builds on ort-readiness, but it's semantically orthogonal to the
previous series and represents a new independent optimization.

=== Basic Optimization idea ===

This series avoids repeatedly detecting the same renames in a sequence of
merges such as a rebase or cherry-pick of several commits. When there are
many renames between the old base and the new base, traditionally all those
renames are re-detected for every commit that is transplanted. This
optimization avoids redoing that work.

This represents "Optimization #4" from my Git Merge 2020 talk[1]; the
details are a bit more involved than I realized at the time, but the high
level idea is the same.

=== Comparison to previous series ===

I previously noted that we had three major rename-related optimizations:

 * exact rename detection (applies when unmodified on renamed side)
 * skip-because-irrelevant (applies when unmodified on unrenamed side)
 * basename-guided rename detection (applies when basename unchanged)

This one adds a fourth (remember-renames), with some interesting properties:

 * unlike basename-guided rename detection, there are no behavioral changes
   (there is no heuristic involved)[2].

 * like skip-because-irrelevant, this optimization does not apply to all git
   commands using the rename machinery. In fact, this one is even more
   restrictive since it is ONLY useful for rebases and cherry-picks (not
   even merges), and only for second and later commits in a linear series.

 * unlike the three previous optimizations, there are no requirements about
   the types of changes done to the file; it just caches renames on the
   "upstream" side of history for subsequent commit picking.

It's also worth noting despite wording about "remembering" or "caching"
renames, that this optimization does NOT write this cache to disk; it's an
in-memory only cache. When the rebase or cherry-pick completes (or hits a
conflict and stops), the cache is discarded.

=== Results ===

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28), the
changes in just this series improves the performance as follows:

                     Before Series           After Series
no-renames:        5.665 s ±  0.129 s     5.624 s ±  0.077 s 
mega-renames:     11.435 s ±  0.158 s    10.213 s ±  0.032 s
just-one-mega:   494.2  ms ±  6.1  ms   497.6  ms ±  5.3  ms


By design, this optimization could not help the just-one-mega testcase. The
gains for the other two testcases may look somewhat smaller than one would
expect given the description (only ~10% for the mega-renames testcase), but
the point was to spend less time detecting renames...and there just wasn't
that much time spent in renames for these testcases before this series for
us to remove. However, if we undid the basename-guided rename detection and
skip-because-unnecessary optimizations, then this series alone would have
improved performance as follows:

                   Before Basename Series   After Just This Series
    no-renames:      13.815 s ±  0.062 s      5.814 s ±  0.094 s
    mega-renames:  1799.937 s ±  0.493 s    303.225 s ±  1.330 s


Showing that this optimization has the ability to improve things when the
other optimizations do not apply. In fact, when I originally implemented
this optimization, it improved the mega-renames testcase by a factor of 2
(at the time, I did not have all the optimizations from ort-perf-batch-7
thru ort-perf-batch-10 in their current shape).

As a reminder, before any merge-ort/diffcore-rename performance work, the
performance results we started with were:

no-renames-am:      6.940 s ±  0.485 s
no-renames:        18.912 s ±  0.174 s
mega-renames:    5964.031 s ± 10.459 s
just-one-mega:    149.583 s ±  0.751 s


=== Further discussion of results ===

If we change our focus from absolute time taken, to the percentage of
overall time spent on rename detection, then we find the following picture
comparing our starting point at the beginning of the performance work to
what we achieve at the end of this series:

       Percentage of time spent on rename detection
   
                  commit 557ac0350d      After this Series
no-renames:             39.4%                   0.2%
mega-renames:           96.6%                   2.7%
just-one-mega:          95.0%                   9.0%


Since this optimization is only applicable for the first two testcases
(because the third only involves rebasing a single commit), even if this
optimization had removed all the remaining time in rename detection it would
have only sped it up the mega-renames case by ~12% rather than the 10% it
achieved. This table makes it clear that our attempts to accelerate rename
detection have succeeded, and any further work to accelerate merges needs to
start concentrating on other areas.

[1]
https://github.com/newren/presentations/blob/pdfs/merge-performance/merge-performance-slides.pdf

[2] Well, almost no changes. There's technically a very narrow way that this
could change the behavior; see the really long "Technically," bullet point
in patch 3 for discussion of this.

Elijah Newren (7):
  merge-ort: add data structures for in-memory caching of rename
    detection
  merge-ort: populate caches of rename detection results
  merge-ort: add code to check for whether cached renames can be reused
  merge-ort: avoid accidental API mis-use
  merge-ort: preserve cached renames for the appropriate side
  merge-ort: add helper functions for using cached renames
  merge-ort, diffcore-rename: employ cached renames when possible

 diffcore-rename.c |  22 +++-
 diffcore.h        |   3 +-
 merge-ort.c       | 273 +++++++++++++++++++++++++++++++++++++++++++---
 merge-ort.h       |   2 +
 4 files changed, 282 insertions(+), 18 deletions(-)


base-commit: c2d2a1ccaea70b7dc8c0539ba9d3a132f9687040
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-859%2Fnewren%2Fort-perf-batch-11-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-859/newren/ort-perf-batch-11-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/859
-- 
gitgitgadget

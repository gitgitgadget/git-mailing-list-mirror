Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46742C433E0
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 03:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB7D164DDC
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 03:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhB1D7Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Feb 2021 22:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhB1D7J (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Feb 2021 22:59:09 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBA5C06174A
        for <git@vger.kernel.org>; Sat, 27 Feb 2021 19:58:29 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id b18so6022619wrn.6
        for <git@vger.kernel.org>; Sat, 27 Feb 2021 19:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=Wyn8L9EtCVevjG+h7N5bIVttWdX3/PgX0KR1EHoWELM=;
        b=peMAptyCx4ww2G1y4upzroO3dnbf3qZpYjS6f5BXoHxCO1Z57pWhredlMTQ5yBfclT
         qQ8Uwt+OlssSMieIG9L5w575SrlHKBx8Qe5TEEkjqfiqHhzE9XofDN50F6MP49TNaoW9
         Tje6nukyuDb+AEhfOrDoqG/JETEvFQ5shcCDonzU6EbYXzFzZh/lGUYiBZ4Xe29P500W
         y7uaRDQKSKQxBLzorzGcX6JxVCZNusfZqZSuGNvsmN3zEwDh0rb8Q3WbQChEIzEkOUJE
         RvvKgNbhaHR99c09dzQT5YkQRMD++bE2O/WbbWtq6OuZvQPBgecDfTZwHppbfqvpgjNK
         etig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Wyn8L9EtCVevjG+h7N5bIVttWdX3/PgX0KR1EHoWELM=;
        b=t7uWxf5wLGFBwzmpeCjcvCI9Crk8tR02NF+u7HQ9GBkkncQXNbkmuQgVx0x19TnbPP
         5BpL3jchfos5nf9pMu3r/zoDGBhxOmwpx/NTQXnj8KMvR5w50kj07xy5BB9PNS/Q6bif
         nzB0HUnIeFCoyLsNJOanZbXhbwO0qtvVhRfIHWihg4QjHTgsh9dKU1izD6Z5dcAu6uCm
         aiavzkLlIN9yoMy4LHegL7RSY1Puzvkvsr8pQ0Q3V28N+fhulo17Y+1ABhrvSdgYZfQd
         i2ligZ1M0qU/UU4tm/nS7rJN1onnsgKKlMpYT0HOSKEUP93SPqzSmSy7wO/a+xdFbHnQ
         OsUQ==
X-Gm-Message-State: AOAM530SinSQBYszM6OqdLpYDw/BATGbTnsOT6u6R9jUIKMMqY0Lcwub
        mEt1ZHTxNpKsU3csHgaLa4WTU56QtSg=
X-Google-Smtp-Source: ABdhPJzXKrw7Ivm02+tXTZUKQtGpvOj4Ctsn1ir0lYXezeTFM9ZoEASePSN6eSUUDNrv+a/xGodifA==
X-Received: by 2002:a5d:67c8:: with SMTP id n8mr3198844wrw.351.1614484708238;
        Sat, 27 Feb 2021 19:58:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l22sm20689396wrb.4.2021.02.27.19.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Feb 2021 19:58:27 -0800 (PST)
Message-Id: <pull.845.git.1614484707.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 28 Feb 2021 03:58:18 +0000
Subject: [PATCH 0/8] Optimization batch 9: avoid detecting irrelevant renames
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

This series depends textually on ort-perf-batch-8, but semantically it's
almost completely unrelated and can be reviewed without any familiarity with
any of the previous patch series.

=== Basic Optimization idea ===

This series determines paths which meet special cases where detection of
renames is irrelevant, where the irrelevance is due to the fact that the
merge machinery will arrive at the same result regardless of whether a
rename is detected for any of those paths. This series represents
"Optimization #2" from my Git Merge 2020 talk[1], though this series has
some improvements on the optimization relative to what I had at that time.

The basic idea here is that if side A of history:

 * only modifies/adds/deletes a few files
 * adds new files to few if any of the directories that side B deleted or
   renamed

then when we do rename detection on side B we can avoid even looking at most
(and perhaps even all) paths that side B deleted. Since commits being
rebased or cherry-picked tend to only modify a few files, this optimization
tends to be particularly effective for rebases and cherry-picks.

Basing rename detection on what the other side of history did to a file
means that extra information needs to be fed from merge-ort to
diffcore-rename in order to take advantage of such an optimization.

=== Comparison to previous series ===

This series differs from my two previous optimizations[2][3] (focusing on
basename-guided rename detection) in two important aspects:

 * there are no behavioral changes (there is no heuristic involved)

 * this optimization is merge specific (it does not help the diff/status/log
   family of commands, just merge/rebase/cherry-pick and such)

=== Results ===

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28), the
changes in just this series improves the performance as follows:

                     Before Series           After Series
no-renames:       12.596 s ±  0.061 s     5.680 s ±  0.096 s
mega-renames:    130.465 s ±  0.259 s    13.812 s ±  0.162 s
just-one-mega:     3.958 s ±  0.010 s   506.0  ms ±  3.9  ms


However, interestingly, if we had ignored the basename-guided rename
detection optimizations[2][3], then this optimization series would have
improved the performance as follows:

               Before Basename Series   After Just This Series
no-renames:      13.815 s ±  0.062 s      5.728 s ±  0.104 s
mega-renames:  1799.937 s ±  0.493 s     18.213 s ±  0.139 s
just-one-mega    51.289 s ±  0.019 s    891.9  ms ±  7.0  ms


As a reminder, before any merge-ort/diffcore-rename performance work, the
performance results we started with (as noted in the same commit message)
were:

no-renames-am:      6.940 s ±  0.485 s
no-renames:        18.912 s ±  0.174 s
mega-renames:    5964.031 s ± 10.459 s
just-one-mega:    149.583 s ±  0.751 s


=== Competition between optimizations ===

We now have three major rename-related optimizations:

 * exact rename detection
 * basename-guided rename detection[2][3]
 * skip-because-unnecessary (this series)

It is possible for all three to potentially apply for specific paths (they
do for the majority of renamed paths in our testcases), but we cannot use
more than one for any given path. It turns out that the priority we give
each optimization is very important and can drastically affect performance.
We get best results by prioritizing them as follows:

 1. exact rename detection
 2. skip-because-unnecessary
 3. basename-guided rename detection

The third-to-last patch of this series also discusses this ordering and
another minor variant of the skip-because-unnecessary optimization that was
tried (and resulted in less effective performance gains than reported here),
as well as some of the preparatory work over the past few years that this
series relies on in order to enable this optimization.

=== Near optimal? ===

You may remember that there was a row labelled "everything else" from the
commit message of 557ac0350d that represented the maximum possible speed-up
from accelerating rename detection alone; as stated in that commit, those
rows represented how fast the code could be if we had somehow infinitely
parallelized the inexact rename detection. However, if you compare those
"maximum speedup" numbers to what we have above, you'll note that the
infinitely parallelized inexact rename detection would have been slightly
slower than the results we have now achieved. (The reason this is possible,
despite the fact that we still spend time in rename detection after our
optimizations, is because we implemented two optimizations outside of
diffcore_rename() along the way.) However, this good news does also come
with a downside -- it means that our remaining optimization potential is
somewhat limited, and subsequent optimization series will have to fight for
much smaller gains.

[1]
https://github.com/newren/presentations/blob/pdfs/merge-performance/merge-performance-slides.pdf
[2]
https://lore.kernel.org/git/pull.843.git.1612651937.gitgitgadget@gmail.com/
[3]
https://lore.kernel.org/git/pull.844.git.1613289544.gitgitgadget@gmail.com/

Elijah Newren (8):
  diffcore-rename: enable filtering possible rename sources
  merge-ort: precompute subset of sources for which we need rename
    detection
  merge-ort: add data structures for an alternate tree traversal
  merge-ort: introduce wrappers for alternate tree traversal
  merge-ort: precompute whether directory rename detection is needed
  merge-ort: use relevant_sources to filter possible rename sources
  merge-ort: skip rename detection entirely if possible
  diffcore-rename: avoid doing basename comparisons for irrelevant
    sources

 diffcore-rename.c |  63 ++++++++++---
 diffcore.h        |   1 +
 merge-ort.c       | 236 +++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 285 insertions(+), 15 deletions(-)


base-commit: 4be565c472088d4144063b736308bf2a57331f45
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-845%2Fnewren%2Fort-perf-batch-9-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-845/newren/ort-perf-batch-9-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/845
-- 
gitgitgadget

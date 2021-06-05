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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B51C4743D
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 01:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5138D61380
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 01:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhFEBbL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 21:31:11 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:45870 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbhFEBbK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 21:31:10 -0400
Received: by mail-wm1-f41.google.com with SMTP id v206-20020a1cded70000b02901a586d3fa23so2248487wmg.4
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 18:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=qRwGSd93SSMzOSS2e0PT5ME+/3RtyAL0NM/nNFgW9q0=;
        b=j8XQRRLGsyYyWQ35a79gy0oYC2yOYJxXcTm3a4tWBDPyjF9Z/wX7eN3qTKwpMkSrWl
         ayaDS4wIAV+IN09bKHL8gLXilSMm67vjLkMZFCAaa5nhbt8JbdlogcM+vad+0Na/xLRs
         gRANSeV07siScDr9KTsr6WdV9mjGHMlmgvCSS8iXX7nS6GKe+OzlI2Nm6Q9KQsH8tRvY
         jEOS7Pzl+luRS4TCmgXDrU0f0Y3j6lSr0Lifm0W06kIh93AEwr4tCau0u3m0TkQQgxix
         dglVE2xNTT8AjeVRRndi3SANiMobVHmVHR4adnkDkAmjI2n3XrIWtarvCOMFw+tSB+VY
         TScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qRwGSd93SSMzOSS2e0PT5ME+/3RtyAL0NM/nNFgW9q0=;
        b=FWFgT/OPsAY+RBhFcI+LMGTWMv7lHCptPdk9ctNR/xFTLVN9PxP+7lmmpTgP7GglFD
         UXCJKfMHAlzlV9eWNs+mJ4ieJJ5lhvVXBZs0aNfkzVJ7hnaz/Us/vhf0cbnhcxIP+Hz4
         1i0QqxzvLyNzIukoBOKZm6Ce03cYdVtshTr36ZubboB/nxLUu/UPU4fB1JyUuCjuDsjh
         SA7TvhJyjNE7FtQ3wH35n9Kxc9xZcDV7wA2CjeSTtJuaNXGrtPEpdLi+bs23mtjSf1Vu
         ifvQVJBDyeCHWa8vnHLVT6ngK8B4UEuPO1+yEjxrhrHHwukF4d5IvJDyN/EZtUYPbTo+
         H+WQ==
X-Gm-Message-State: AOAM530DySJb3gvQlNHHyPVP5HFxHRNnncHyrPXC123DlJ2KjDFJHNNf
        CU8m8wbYnx1JhF56nlvXmK+3zZIoR/o=
X-Google-Smtp-Source: ABdhPJzFeQvpDc3vL+pqffo8ZrjialtArRwqDl8YVYNQZC7UYKe0j+Bho8xidP9J8TLRoTuU9suExw==
X-Received: by 2002:a05:600c:190c:: with SMTP id j12mr6167538wmq.42.1622856486444;
        Fri, 04 Jun 2021 18:28:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 3sm9877832wmi.7.2021.06.04.18.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 18:28:06 -0700 (PDT)
Message-Id: <pull.969.git.1622856485.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 05 Jun 2021 01:27:59 +0000
Subject: [PATCH 0/5] Optimization batch 13: partial clone optimizations for merge-ort
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <dstolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series optimizes blob downloading in merges for partial clones. It can
apply on master.

=== Conflict heads up ===

This series has two minor textual conflicts with
https://lore.kernel.org/git/cover.1622580781.git.jonathantanmy@google.com/,
because we both add a repo parameter to fetch_objects() but Jonathan makes
additional other nearby changes. If it'd help, I can rebase my series on his
if he resolves the GIT_TEST_DEFAULT_HASH=sha256 issue, but I thought I'd
send this out while the topic is fresh on Jonathan's mind.

(This topic is semantically and textually independent of my other in-flight
and not-yet-submitted ort-perf-batch-* topics, so this series need not
include those.)

=== Basic Optimization idea ===

merge-ort was designed to minimize the computation needed to complete a
merge, and much of that (particularly the "irrelevant rename"
determinations) also dramatically reduced the amount of data needed for the
merge. Reducing the amount of data needed to do computations ought to
benefit partial clones as well by enabling them to download less
information. However, my previous series didn't modify the prefetch()
command in diffcore-rename to take advantage of these reduced data
requirements. This series changes that.

Further, although diffcore-rename batched downloads of objects for rename
detection, the merge machinery did not do the same for three-way content
merges of files. This series adds batch downloading of objects within
merge-ort to correct that.

=== Modified performance measurement method ===

The testcases I've been using so far to measure performance were not run in
a partial clone, so they aren't directly usable for comparison. Further,
partial clone performance depends on network speed which can be highly
variable. So I want to modify one of the existing testcases slightly and
focus on two different but more stable metrics:

 1. Number of git fetch operations during rebase
 2. Number of objects fetched during rebase

The first of these should already be decent due to Jonathan Tan's work to
batch fetching of missing blobs during rename detection (see commit
7fbbcb21b1 ("diff: batch fetching of missing blobs", 2019-04-05)), so we are
mostly looking to optimize the second but would like to also decrease the
first if possible.

The testcase we will look at will be a modification of the mega-renames
testcase from commit 557ac0350d ("merge-ort: begin performance work;
instrument with trace2_region_* calls", 2020-10-28). In particular, we
change

$ git clone \
    git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git


to

$ git clone --sparse --filter=blob:none \
    https://github.com/github/linux


(The change in clone URL is just to get a server that supports the filter
predicate.)

We otherwise keep the test the same (in particular, we do not add any calls
to "git-sparse checkout {set,add}" which means that the resulting repository
will only have 7 total blobs from files in the toplevel directory before
starting the rebase).

=== Results ===

For the mega-renames testcase noted above (which rebases 35 commits across
an upstream with ~26K renames in a partial clone), I found the following
results for our metrics of interest:

     Number of `git fetch` ops during rebase

                     Before Series   After Series
merge-recursive:          62              63
merge-ort:                30              20


     Number of objects fetched during rebase

                     Before Series   After Series
merge-recursive:         11423          11423
merge-ort:               11391             63


So, we have a significant reduction (factor of ~3 relative to
merge-recursive) in the number of git fetch operations that have to be
performed in a partial clone to complete the rebase, and a dramatic
reduction (factor of ~180) in the number of objects that need to be fetched.

=== Summary ===

It's worth pointing out that merge-ort after the series needs only ~1.8
blobs per commit being transplanted to complete this particular rebase.
Essentially, this reinforces the fact the optimization work so far has taken
rename detection from often being an overwhelmingly costly portion of a
merge (leading many to just capitulate on it), to what I have observed in my
experience so far as being just a minor cost for merges.

Elijah Newren (5):
  promisor-remote: output trace2 statistics for number of objects
    fetched
  t6421: add tests checking for excessive object downloads during merge
  diffcore-rename: allow different missing_object_cb functions
  diffcore-rename: use a different prefetch for basename comparisons
  merge-ort: add prefetching for content merges

 diffcore-rename.c              | 149 +++++++++---
 merge-ort.c                    |  50 ++++
 promisor-remote.c              |   7 +-
 t/t6421-merge-partial-clone.sh | 433 +++++++++++++++++++++++++++++++++
 4 files changed, 605 insertions(+), 34 deletions(-)
 create mode 100755 t/t6421-merge-partial-clone.sh


base-commit: 01352fcdf3a96480ffa4e25a103a83a9e5d7f67a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-969%2Fnewren%2Fort-perf-batch-13-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-969/newren/ort-perf-batch-13-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/969
-- 
gitgitgadget

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7CDC2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 18:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E35B26134F
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 18:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbhFVSrd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 14:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhFVSrc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 14:47:32 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4ADC061756
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 11:45:16 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id q10so446544oij.5
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 11:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g2tWx8fRoXXIkAVA5KaygmT2WormgWRgNJDayjvi18k=;
        b=iZlO0KT9bss6FgNqg9DhtXh3I265xRMBc4q+frwSaDiEC1lGOGKkONQ68vyLXKig72
         LW4+9HLioqgY1AtVZSlzpf1GB4xTbYA6yk8xO8H4vUkXueLnYoj39GFuKWFqJX/dbfOG
         snKOrtkiWboccyOweGU0BQxGFHZ+YGpsBCw+JPGG2aL6TQShzN80oAZKvnCQHI1X/YNR
         f5XTUK3fME7oMWRLTkeCi0CdG14AAOEOpQCIYPx1w3R7FlmzOcA5RuIiongyym/doKi1
         YxyTSI6y6bUuZTxNg/2GLOb0Um8K7mowX5REYUHxrOZunRnLYQwTVVguFbDT+WUdLfod
         nPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g2tWx8fRoXXIkAVA5KaygmT2WormgWRgNJDayjvi18k=;
        b=npQfgn025Zo6K9oKOLc4T5tXpuuybD4WSgnByTREHZ64RG4MQFlRWYzeqTPGGqaZBV
         l2y+sGhBgyLfLpM2Hps+jgjKbYhHABioiUFHIJKyuYH4u/Ax3io/F/A/ican5WnO6AeG
         a87/RXO/ugVLd3QnSoQG4eRhJkqyrqZ2r8f4T0WwMsFxZYrvIvL2rvf1Szk+MXExxzwa
         QHtCEyaaU6rBt8I+dMRRgGkouk4znmH3LMvYzPV6snT1pnfwqsiMD5n9HfXoF4/SAI1y
         DL9ZvUIMl6iebM++o6bk0bS2u5ggzSxVBXatcuhCm7+iuyQTutkCdHORcSLRe2K3+eTw
         NIBw==
X-Gm-Message-State: AOAM533BCRCyMSS17/0MYs4emp7GE5Cn9FRqxulp6BQFHlPJN4R1NcBW
        Z8jwicT5Ck2s3v0RBRHIK6UdBGr5ZEmOfumDleI=
X-Google-Smtp-Source: ABdhPJxcF6Tin7aID7GAwrv/vNodMRRPyb5vB7M8Mc6hqLduV7tFvLX/h15OXzOwG1tlZDPAFHDNlLLI/njQM90DnMY=
X-Received: by 2002:aca:f482:: with SMTP id s124mr127188oih.167.1624387515272;
 Tue, 22 Jun 2021 11:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <pull.969.v2.git.1623796907.gitgitgadget@gmail.com>
 <pull.969.v3.git.1624349082.gitgitgadget@gmail.com> <3a397e04-88a1-1205-a465-75dc2fd7e93d@gmail.com>
In-Reply-To: <3a397e04-88a1-1205-a465-75dc2fd7e93d@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 22 Jun 2021 11:45:04 -0700
Message-ID: <CABPp-BH9vy3otHvAxR2T6JmVKtH2+EKj-A7NxGsuoqnZA_Bykg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Optimization batch 13: partial clone optimizations
 for merge-ort
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <dstolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 22, 2021 at 9:10 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 6/22/2021 4:04 AM, Elijah Newren via GitGitGadget wrote:
> > This series optimizes blob downloading in merges for partial clones. It can
> > apply on master. It's independent of ort-perf-batch-12.
>
> As promised, I completed a performance evaluation of this series as well
> as ort-perf-batch-12 (and all earlier batches) against our microsoft/git
> fork and running in one of our large monorepos that has over 2 million
> files at HEAD. Here are my findings.

Nice, thanks for the investigation and the detailed report!

> In my comparisons, I compare the recursive merge strategy with renames
> disabled against the ORT strategy (which always has renames enabled). When
> I enabled renames for the recursive merge I saw the partial clone logic
> kick in and start downloading many files in every case, so I dropped that
> from consideration.

I understand it'd take way too long to do an exhaustive testing, but
just doing a couple example comparisons against recursive with rename
detection turned on (and merge.renameLimit set to e.g. 0, or to some
high number if needed) would still be interesting.

> Experiment #1: Large RI/FI merges
> ---------------------------------
>
...
>      Recursive     ORT
> -----------------------
> MAX     34.97s    4.74s
> P90     30.04s    4.50s
> P75     15.35s    3.74s
> P50      7.22s    3.39s
> P10      3.61s    3.08s
>
> (I'm not testing ORT with the sparse-index yet. A significant portion of
> this 3 second lower bound is due to reading and writing the index file
> with 2 million entries. I _am_ using sparse-checkout with only the files
> at root, which minimizes the time required to update the working directory
> with any changed files.)
>
> For these merges, ORT is a clear win.

Wahoo!

I suspect I know what you're seeing from recursive as well; recursive
had some quadratic behaviors found within it, separate from the calls
into diffcore-rename.  It was much less likely to be triggered with
rename detection turned off, but could still be triggered.  I suspect
you just had enough testcases that some of them were affected.  (I
particularly suspect the item described at (5a) of
https://lore.kernel.org/git/pull.842.git.1612331345.gitgitgadget@gmail.com/)

Given the 2 million entries, I'm curious if ort-perf-batch-14 (not yet
submitted; I've been waiting a few weeks for ort-perf-batch-12 to hit
next) will provide further significant benefits.  If it really does
take 3s or so to do index reading and writing, then it'd only be able
to help with the slower cases, but I'm still curious.  It helped
rather dramatically on my linux kernel testcase with lots of renames.


> Experiment #2: User-created merges
> ----------------------------------
>
> To find merges that might be created by actual user cases, I ran
> 'git rev-list --grep="^Merge branch"' to get merges that had default
> messages from 'git merge' runs. (The merges from Experiment #1 had other
> automated names that did not appear in this search.)
>
> Here, the differences are less striking, but still valuable:
>
>      Recursive     ORT
> -----------------------
> MAX     10.61s   6.27s
> P75      8.81s   3.92s
> P50      4.32s   3.21s
> P10      3.53s   2.95s
>
> The ORT strategy had more variance in these examples, though still not as
> much as the recursive strategy. Here the variance is due to conflicting
> files needing content merges, which usually were automatically resolved.

Is the max case on the ort side related to item #2 below, where
perhaps there was a case where there was no automatic resolution of
some file?

> This version of the experiment provided interesting observations in a few
> cases:
>
> 1. One case had the recursive merge strategy result in a root tree that
>    disagreed with what the user committed, but the ORT strategy _did_ the
>    correct resolution. Likely, this is due to the rename detection and
>    resolution. The user probably had to manually resolve the merge to
>    match their expected renames since we turn off merge.renames in their
>    config.

I agree that seems like the likely explanation.

> 2. I watched for the partial clone logic to kick in and download blobs.
>    Some of these were inevitable: we need the blobs to resolve edit/edit
>    conflicts. Most cases none were downloaded at all, so this series is
>    working as advertised. There _was_ a case where the inexact rename
>    detection requested a large list of files (~2900 in three batches) but
>    _then_ said "inexact rename detection was skipped due to too many
>    files". This is a case that would be nice to resolve in this series. I
>    will try to find exactly where in the code this is being triggered and
>    report back.

This suggests perhaps that EITHER there was a real modify/delete
conflict (because you have to do full rename detection to rule out
that the modify/delete was part of some rename), OR that there was a
renamed file modified on both sides that did not keep its original
basename (because that combination is needed to bypass the various
optimizations and make it fall back to full inexact rename detection).
Further, in either case, there were enough adds/deletes that full
inexact detection is still a bit expensive.  It'd be interesting to
know which case it was.  What happens if you set merge.renameLimit to
something higher (the default is surprisingly small)?

> 3. As I mentioned, I was using sparse-checkout to limit the size of the
>    working directory. In one case of a conflict that could not be
>    automatically resolved, the ORT strategy output this error:
>
>    error: could not open '<X>': No such file or directory
>
>    It seems we are looking for a file on disk without considering if it
>    might have the SKIP_WORKTREE bit on in the index. I don't think this is
>    an issue for this series, but might require a follow-up on top of the
>    other ORT work.

I suspect either checkout() or record_conflicted_index_entries() are
to blame, and yeah, it'd be an issue from a previous series.  If you
have any further details or even hints about reproducing (doesn't have
to be a complete set of steps or minimal testcase), I would love to
hear it.  (Incidentally, of all the reviews on merge-ort, those two
functions were left out; look for "17" and "19" in
https://lore.kernel.org/git/pull.923.git.git.1606635803.gitgitgadget@gmail.com/
)


> Conclusions
> -----------
>
> I continue to be excited about the ORT strategy and will likely be
> focusing on it in a month or so to integrate it with the sparse-index. I
> think we would be interested in making the ORT strategy a new default for
> Scalar, but we might really want it to respect merge.renames=false if only
> so we can deploy the settings in stages (first, change the strategy, then
> enable renames as an independent step) so we can isolate concerns.

Given that my ort performance work concentrated on rename detection,
it's encouraging to see that ort-WITH-renames is generally faster for
you than recursive-WITHOUT-renames.  That means not only that rename
detection can be done in reasonable time now, but that the
improvements outside of rename detection show some real benefits as
well.  It'll be interesting to see how the final two performance
series for merge-ort, which will concentrate on performance on areas
other than rename detection, will affect these above results.


And by the way, thanks for the herculean review effort you've put in.
You've reviewed nearly every merge-ort and diffcore-rename patch
(which included many big, tricky patches)...and a quick search says
there's been at least 128 patches so far in the last 8 months.  And
the code is better (cleaner, clearer, and faster) for all your
reviews.

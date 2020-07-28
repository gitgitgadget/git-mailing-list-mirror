Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00175C433E4
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 14:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5F73206D8
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 14:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="YQ+dAxEP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730554AbgG1OzD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 10:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730455AbgG1OzC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 10:55:02 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F689C061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 07:55:02 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id l23so18929642qkk.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 07:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sXpPHlVzA8YmBIWC7gEhnWw2U01D01jCBqsRTXI1/2w=;
        b=YQ+dAxEP6zxJmLhcL0gdX+ecXTk3KiwDYTg/vnApxCAbfP6nLcEY3tfGf1Nn62Il3E
         IwCiNXbPa3Ki1YHeqH4D6vsEeRfJObFRwZUwmxO4nzWx2Om75j1gr26kCDIqsjOT/OUo
         guz0CdH9aOI40Cz7de6JA46AcrVMxtnW9zKb9y7Atb9HtQuup0QZpFYyTuBNmMGa7205
         CDMoytmqblPfZ/ebbvZ9+40XkivAORwIzPIy6H2t5bkxyPw9W8hoLmM31aMIolmVeF1F
         GCSZGYnHYNA5NT8j87w3S3ERsBK2AnKS8x67fXK0mPKXDaeSjhlI90OPEHhHABXsNVAf
         VxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sXpPHlVzA8YmBIWC7gEhnWw2U01D01jCBqsRTXI1/2w=;
        b=Baw0vUU90AY5F2zadQxEeDXRPwhcs3Nirqb0hGZoGKibFbv4/Dyh4OWyltMIimuYKV
         OJ9sik7rK9pAEwdcgwnewTlt+CkQtGcA1PL+smmcioUYzlJjVyG3f6EopggLMW8W1NkB
         yZC+H27EmNq+G27xMlvfqkxyz+wab/qjET+fGKCu/OSsnSt44PItC8ANjArocDc9DIWg
         c+puQbgs6hiQ7hkmZ3z6H8kLgOwFV//fxn83dnT1VtlVmb9NIqFCPRF41nNrbsIzHV9I
         dFTXhvbw/N+HEc8KNSG17xQE9+RHEZfEXClHXxNFHeZHZuNJnS+rPC4zLxXQchXt4POK
         OUFA==
X-Gm-Message-State: AOAM533W6HLLizKgowFmBTpnCFWOe83ENBRcMgnKVMfjf6W4jhNzCNyQ
        lEXzMJ3XfSQb/O4urKT+zdyc2mknS5stPg==
X-Google-Smtp-Source: ABdhPJwBZLzyKQmGS/5uAIqWTHdy0cx5Pu36xI8lUm+5UVAYldOlgvacUvRlLKXYpOER6L0ROSetlg==
X-Received: by 2002:a05:620a:240a:: with SMTP id d10mr6325785qkn.209.1595948100832;
        Tue, 28 Jul 2020 07:55:00 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:9c58:8530:481a:f835])
        by smtp.gmail.com with ESMTPSA id v184sm24248278qki.12.2020.07.28.07.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 07:55:00 -0700 (PDT)
Date:   Tue, 28 Jul 2020 10:54:58 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Subject: Re: [PATCH 0/6] [GSoC] Implement Corrected Commit Date
Message-ID: <20200728145458.GA87373@syl.lan>
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.676.git.1595927632.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Abhishek,

On Tue, Jul 28, 2020 at 09:13:45AM +0000, Abhishek Kumar via GitGitGadget wrote:
> This patch series implements the corrected commit date offsets as generation
> number v2, along with other pre-requisites.

Very exciting. I have been eagerly following your blog and asking
Stolee about your progress, so I am excited to read these patches.

> Git uses topological levels in the commit-graph file for commit-graph
> traversal operations like git log --graph. Unfortunately, using topological
> levels can result in a worse performance than without them when compared
> with committer date as a heuristics. For example, git merge-base v4.8 v4.9
> on the Linux repository walks 635,579 commits using topological levels and
> walks 167,468 using committer date.
>
> Thus, the need for generation number v2 was born. New generation number
> needed to provide good performance, increment updates, and backward
> compatibility. Due to an unfortunate problem, we also needed a way to
> distinguish between the old and new generation number without incrementing
> graph version.
>
> Various candidates were examined (https://github.com/derrickstolee/gen-test,
> https://github.com/abhishekkumar2718/git/pull/1). The proposed generation
> number v2, Corrected Commit Date with Mononotically Increasing Offsets
> performed much worse than committer date (506,577 vs. 167,468 commits walked
> for git merge-base v4.8 v4.9) and was dropped.
>
> Using Generation Data chunk (GDAT) relieves the requirement of backward
> compatibility as we would continue to store topological levels in Commit
> Data (CDAT) chunk. Thus, Corrected Commit Date was chosen as generation
> number v2. The Corrected Commit Date is defined as:
>
> For a commit C, let its corrected commit date be the maximum of the commit
> date of C and the corrected commit dates of its parents. Then corrected
> commit date offset is the difference between corrected commit date of C and
> commit date of C.

Interestingly, we use a very similar metric at GitHub to sort commits in
various UI views which have lots of existing machinery that sorts
an abstract collection by each element's "date". Since that sort is
stable, and we want to respect the order that Git delivered, we take the
pairwise max of each successive pair of commits.

> We will introduce an additional commit-graph chunk, Generation Data chunk,
> and store corrected commit date offsets in GDAT chunk while storing
> topological levels in CDAT chunk. The old versions of Git would ignore GDAT
> chunk, using topological levels from CDAT chunk. In contrast, new versions
> of Git would use corrected commit dates, falling back to topological level
> if the generation data chunk is absent in the commit-graph file.

I'm sure that I'll learn more when I get to this point, but I would like
to hear more about why you want to store the offset rather than the
corrected commit date itself. It seems that the offset could be either
positive or negative, so you'd only have the range of a signed integer
(rather than storing 8 bytes of a time_t for the full breadth of
possibilities).

I know also that Peff is working on negative timestamp support, so I
would want to hear about what he thinks of this, too.

> Here's what left for the PR (which I intend to take on with the second
> version of pull request):
>
>  1. Add an option to skip writing generation data chunk (to test whether new
>     Git works without GDAT as intended).

This will be good to gradually roll-out the new chunk. Another thought
is to control whether or not the commit-graph machinery _reads_ this
chunk if it's present. That can be useful for debugging too (eg., I have
a commit-graph with a GDAT chunk that is broken in some way, what
happens if I don't read that chunk?)

Maybe something like `commitgraph.readsGenerationData`? Incidentally,
I'm preparing a `commitgraph.readsChangedPaths` to control whether or
not we read the Bloom index and data chunks. I'll send that to the list
shortly (it's in my fork somewhere if you want an earlier look), but
that may be a useful reference for you.

>  2. Handle writing to commit-graph for mismatched version (that is, merging
>     all graphs into a new graph with a GDAT chunk).
>  3. Update technical documentation.
>
> I look forward to everyone's reviews!
>
> Thanks
>
>  * Abhishek
>
>
> ----------------------------------------------------------------------------
>
> The build fails for t9807-git-p4-submit.sh on osx-clang, which I feel is
> unrelated to my code changes. Still need to investigate further.
>
> Abhishek Kumar (6):
>   commit-graph: fix regression when computing bloom filter
>   revision: parse parent in indegree_walk_step()
>   commit-graph: consolidate fill_commit_graph_info
>   commit-graph: consolidate compare_commits_by_gen
>   commit-graph: implement generation data chunk
>   commit-graph: implement corrected commit date offset
>
>  blame.c                       |   2 +-
>  commit-graph.c                | 181 +++++++++++++++++++++-------------
>  commit-graph.h                |   7 +-
>  commit-reach.c                |  47 +++------
>  commit-reach.h                |   2 +-
>  commit.c                      |   9 +-
>  commit.h                      |   3 +
>  revision.c                    |  17 ++--
>  t/helper/test-read-graph.c    |   2 +
>  t/t4216-log-bloom.sh          |   4 +-
>  t/t5000-tar-tree.sh           |   4 +-
>  t/t5318-commit-graph.sh       |  21 ++--
>  t/t5324-split-commit-graph.sh |  12 +--
>  upload-pack.c                 |   2 +-
>  14 files changed, 178 insertions(+), 135 deletions(-)
>
>
> base-commit: 47ae905ffb98cc4d4fd90083da6bc8dab55d9ecc
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-676%2Fabhishekkumar2718%2Fcorrected_commit_date-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-676/abhishekkumar2718/corrected_commit_date-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/676
> --
> gitgitgadget

Thanks,
Taylor

Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EFCC433E1
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 06:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3189D2075B
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 06:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laRqevri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgHRGOi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 02:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgHRGOh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 02:14:37 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB6EC061389
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 23:14:37 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o13so9288146pgf.0
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 23:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ijw1S/qfWQhLe2RrYfTAzy/Wkuhh8i9gGCJgf4WVL7o=;
        b=laRqevria9TOuNmxPy77eZQzRECvUZkmVSWg5P+GV9v4TzuuoZeXj6xg9vo3bEflZx
         PajgnoM9FOFfSh7O4hQUe+x06+qoeOAdOJgbAI3Nz4iEvDrbkgyeIO6eDSZCfpnHhw/h
         vZxHttajnZA0cjRLkoIZEtyH4pFTNxpc9UghxmpGvi97RtgzcCuPhy8BjWpZ5VaJo6Us
         g9CM1YU3zvSiEtPb5fdA614+DKNVtELNJm4hOX6xYKmtfAUJ+BBLrxEsreFTajDAbr/Z
         9I6e+AzT8+LT+CmjWHwAaECUCUR4X6ffzHLKhpGvQgRyd0h/rQAEecgJestcJtnnBeQ0
         4PiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=ijw1S/qfWQhLe2RrYfTAzy/Wkuhh8i9gGCJgf4WVL7o=;
        b=qMZ10ufIj28hXxMf8XLsGo91kkjpbMQM6u5Kx2GjAtdjPpbKjLfzs3M3cR3WEBplPu
         kZVpZJuZrO5Mj7I9G4YmNF3KJyaP6l1/43m8IBlTkjA8l9clWy2NLjYIrltxZNHhfQbf
         QY7M/SwMsRYc/RGl1MAO6TGnCt18kwp1c3O8TXucQf0UocGju34fbUFHKlBofat7ixWX
         dGdJQvROMDWeY41EKHHSgVyll+SqUdJEqi7vxZJxO6wtOZHEZzeSip+GBmoufp9twT3p
         ZXOqr0cGyWSMHZfGlSukPxLhB9hovTQeqafq+4a5Yf9qwWI4WRMav5uFGtTpsBSn+dry
         4Bvg==
X-Gm-Message-State: AOAM530bS8RoGpMhBe9FsNuyEuFq9D7ty5PTANlp5gTwcztCrDsgt7dy
        N0xVaSOm4x3Qbmat4oNxiRa85Jp2Ki+Gk06E
X-Google-Smtp-Source: ABdhPJxF9Mfa0FP63KCuxy91pFP1xZUFIVjZqc89tzl6SxSigYyF8aC9eCJaOyVMFJ4ebWQWT/JkCg==
X-Received: by 2002:a63:fd11:: with SMTP id d17mr12047198pgh.272.1597731277066;
        Mon, 17 Aug 2020 23:14:37 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:597:ac34:8be2:2e51:8db6:e9])
        by smtp.gmail.com with ESMTPSA id z29sm23083416pfj.182.2020.08.17.23.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 23:14:36 -0700 (PDT)
Date:   Tue, 18 Aug 2020 11:42:20 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, me@ttaylor.com, stolee@gmail.com
Subject: Re: [PATCH v3 00/11] [GSoC] Implement Corrected Commit Date
Message-ID: <20200818061220.GA28571@Abhishek-Arch>
Reply-To: 85zh6uxh7l.fsf@gmail.com
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
 <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
 <85zh6uxh7l.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85zh6uxh7l.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 17, 2020 at 02:13:18AM +0200, Jakub Narębski wrote:
> "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > This patch series implements the corrected commit date offsets as generation
> > number v2, along with other pre-requisites.
> 
> I'm not sure if this level of detail is required in the cover letter for
> the series, but generation number v2 is corrected commit date; corrected
> commit date offsets is how we store this value in the commit-graph file.
> 
> >
> > Git uses topological levels in the commit-graph file for commit-graph
> > traversal operations like git log --graph. Unfortunately, using topological
> > levels can result in a worse performance than without them when compared
> > with committer date as a heuristics. For example, git merge-base v4.8 v4.9
> > on the Linux repository walks 635,579 commits using topological levels and
> > walks 167,468 using committer date.
> 
> I would say "committer date heuristics" instead of just "committer
> date", to be more exact.
> 
> Is this data generated using https://github.com/derrickstolee/gen-test
> scripts?
> 

Yes, it is.

> >
> > Thus, the need for generation number v2 was born. New generation number
> > needed to provide good performance, increment updates, and backward
> > compatibility. Due to an unfortunate problem, we also needed a way to
> > distinguish between the old and new generation number without incrementing
> > graph version.
> 
> It would be nice to have reference email (or other place with details)
> for "unfortunate problem".
> 

Will add.

> >
> > Various candidates were examined (https://github.com/derrickstolee/gen-test,
> > https://github.com/abhishekkumar2718/git/pull/1). The proposed generation
> > number v2, Corrected Commit Date with Mononotically Increasing Offsets
> > performed much worse than committer date (506,577 vs. 167,468 commits walked
> > for git merge-base v4.8 v4.9) and was dropped.
> >
> > Using Generation Data chunk (GDAT) relieves the requirement of backward
> > compatibility as we would continue to store topological levels in Commit
> > Data (CDAT) chunk. Thus, Corrected Commit Date was chosen as generation
> > number v2.
> 
> This is a bit of simplification, but good enough for a cover letter.
> 
> To be more exact, from various candidates the Corrected Commit Date was
> chosen.  Then it turned out that old Git crashes on changed commit-graph
> format version value, so if the generation number v2 was to replace v1
> it needed to be backward-compatibile: hence the idea of Corrected Commit
> Date with Monotonically Increasing Offsets.  But with GDAT chunk to
> store generation number v2 (and for the time being leaving generation
> number v1, i.e. Topological Levels, in CDAT), we are no longer
> constrained by the requirement of backward-compatibility to make old Git
> work with commit-graph file created by new Git.  So we could go back to
> Corrected Commit Date, and as you wrote above the backward-compatibile
> variant performs worse.
> 
> > The Corrected Commit Date is defined as:
> >
> > For a commit C, let its corrected commit date be the maximum of the commit
> > date of C and the corrected commit dates of its parents.
> 
> Actually it needs to be "corrected commit dates of its parents plus 1"
> to fulfill the reachability condition for a generation number for a
> commit:
> 
>       A can reach B   =>  gen(A) < gen(B)
> 
> Of course it can be computed in simpler way, because
> 
>   max_P (gen(P) + 1)  ==  max_P (gen(P)) + 1
> 
> 
> >                                                           Then corrected
> > commit date offset is the difference between corrected commit date of C and
> > commit date of C.
> 
> All right.
> 
> >
> > We will introduce an additional commit-graph chunk, Generation Data chunk,
> > and store corrected commit date offsets in GDAT chunk while storing
> > topological levels in CDAT chunk. The old versions of Git would ignore GDAT
> > chunk, using topological levels from CDAT chunk. In contrast, new versions
> > of Git would use corrected commit dates, falling back to topological level
> > if the generation data chunk is absent in the commit-graph file.
> 
> All right.
> 
> However I think the cover letter should also describe what should happen
> in a mixed version environment (for example new Git on command line,
> copy of old Git used by GUI client), and in particular what should
> happen in a mixed-chain case - both for reading and for writing the
> commit-graph file.
> 

Yes, definitely. Will add

> For *writing*: because old Git would create commit-graph layers without
> the GDAT chunk, to simplify the behavior and make easy to reason about
> commit-graph data (the situation should be not that common, and
> transient -- it should get more rare as the time goes), we want the
> following behavior from new Git:
> 
> - If top layer contains the GDAT chunk, or we are rewriting commit-graph
>   file (--split=replace), or we are merging layers and there are no
>   layers without GDAT chunk below set of layers that are merged, then
> 
>      write commit-graph file or commit-graph layer with GDAT chunk,
> 
>   otherwise
> 
>      write commit-graph layer without GDAT chunk.
> 
>   This means that there are commit-graph layers without GDAT chunk if
>   and only if the top layer is also without GDAT chunk.
> 
> 
> For *reading* we want to use generation number v2 (corrected commit
> date) if possible, and fall back to generation number v1 (topological
> levels).
> 
> - If the top layer contains the GDAT chunk (or maybe even if the topmost
>   layer that involves all commits in question, not necessarily the top
>   layer in the full commit-graph chain), then use generation number v2
> 

The current implementation checks the entire chain for GDAT, rather than
just the topmost layer as we cannot assert that `g` would be the topmost
layer of the chain.

See the discussion here: https://lore.kernel.org/git/20200814045957.GA1380@Abhishek-Arch/

It's one of drawbacks of having a single member 64-bit `generation`
instead of two 32-bit members `level` and `odate`.

>
>
>   - commit_graph_data->generation stores corrected commit date,
>     computed as sum of committer date (from CDAT) and offset (from GDAT)
> 
>   - A can reach B   =>  gen(A) < gen(B)
> 
>   - there is no need for committer date heuristics, and no need for
>     limiting use of generation number to where there is a cutoff (to not
>     hamper performance).
> 
> - If there are layers without GDAT chunks, which thanks to the write
>   behavior means simply top layer without GDAT chunk, we need to turn
>   off use of generation numbers or fall back to using topological levels
> 
>   - commit_graph_data->generation stores topological levels,
>     taken from CDAT chunk (30-bits)
> 
>   - A can reach B   =>  gen(A) < gen(B)
> 
>   - we probably want to keep tie-breaking of sorting by generation
>     number via committer date, and limit use of generation number as
>     opposed to using committer date heuristics (with slop) to not make
>     performance worse.
> 
> >
> > Thanks to Dr. Stolee, Dr. Narębski, and Taylor for their reviews on the
> > first version.
> >
> > I look forward to everyone's reviews!
> >
> > Thanks
> >
> >  * Abhishek
> >
> >
> > ----------------------------------------------------------------------------
> >
> > Changes in version 3:
> >
> >  * Reordered patches as discussed in 1
> >    [https://lore.kernel.org/git/aee0ae56-3395-6848-d573-27a318d72755@gmail.com/]
> 
> If I remember it correctly this was done to always store in GDAT chunk
> corrected commit date offsets, isn't it?
> 

Yes.

> >  * Split "implement corrected commit date" into two patches - one
> >    introducing the topo level slab and other implementing corrected commit
> >    dates.
> 
> All right.
> 
> I think it might be good idea to split off the change to tar file tests
> (as a preparatory patch), to make reviews and bisecting easier.
> 
> >  * Extended split-commit-graph tests to verify at the end of test.
> 
> Do we also test for proper merging of split commit-graph layers, not
> only adding a new layer and a full rewrite (--split=replace)?
> 

We do not, will add a test at end. Thanks for pointing this out.

> >  * Use topological levels as generation number if any of split commit-graph
> >    files do not have generation data chunk.
> 
> That is good for performance.
> 
> >
> > Changes in version 2:
> >
> >  * Add tests for generation data chunk.
> 
> Good.
> 
> >  * Add an option GIT_TEST_COMMIT_GRAPH_NO_GDAT to control whether to write
> >    generation data chunk.
> 
> Good, that is needed for testing mixed-version behavior.
> 
> >  * Compare commits with corrected commit dates if present in
> >    paint_down_to_common().
> 
> All right, but see the caveat.
> 
> >  * Update technical documentation.
> 
> Always a good thing.
> 
> >  * Handle mixed graph version commit chains.
> 
> Where by "version" you mean generation number version - the commit-graph
> version number unfortunately needs to stay the same...
> 

Yes, clarified.

> >  * Improve commit messages for
>                                 ^^^^^^
> Something missing in this point, the sentence ends abruptly.

I didn't finish the sentence. Meant to say:

- Improve commit messages for "commit-graph: fix regression when computing bloom filter", "commit-graph: consolidate fill_commit_graph_info",
> 
> >  * Revert unnecessary whitespace changes.
> 
> Thanks.
> 
> >  * Split uint_32 -> timestamp_t change into a new commit.
> 
> It is usually better to keep the commits small.  Good.
> 
> 
> Good work!
> 
> ...
> --
> Jakub Narębski

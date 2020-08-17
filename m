Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92ACCC433DF
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 01:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 665742075D
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 01:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="0jxQ09g4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgHQBcM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Aug 2020 21:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbgHQBcL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Aug 2020 21:32:11 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE84C061786
        for <git@vger.kernel.org>; Sun, 16 Aug 2020 18:32:10 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id f19so6831015qtp.2
        for <git@vger.kernel.org>; Sun, 16 Aug 2020 18:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NJ1Y+xSaO5W5w1x2FUyRACj+VcOFm0DcK3JVD6Lp5FY=;
        b=0jxQ09g4N7jps5peZxORlCSsyZX8bJ5wEFYZZRzsriAJrhQWPjA2rkFClaVP2VHHqh
         LBuaDQUnRiWjGnJ2yb3oZvdSJSYsPcTAq20JdPAGeftt6xEJUhjAei7N8kKsm1vtDxTr
         Iwwldi0QHYCVdmPnNAFrMl5e4i/w4YSu8eLFMLJ5dG5vD2T2c+N5yFl87l52xSNCwqSo
         SIgWo+c6Jo1rCtsDKV0nibD+PVOAzCzxwYKje0QXoNP2Jfz3c9k/TF6fLocP2wP7Pob5
         GdfdnQWH3sPS9DRmgBSIiU6uhF2HA4QlL5Rv9NbqrqmEnVTfDWD4WNeivJlRqzNmUiB1
         B9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NJ1Y+xSaO5W5w1x2FUyRACj+VcOFm0DcK3JVD6Lp5FY=;
        b=a7MyCBlojsRqr2/PQcvDfDTSFhfuA3RRwMO01F9HpPx+rQzoKzpq9Np6HqaDoGC2GQ
         gRJA6REaDmDSuP0ZDvrJAIWMjlJwgp/ObnsNbiFl6mgp0uqdBIcYd7bb8n/untyId6MC
         KrrW+xZPDmm1uuCAFza/SqKHWrOaMM4m+izfNYRq0gFzid4juChIBK29FhPVcNwQFptL
         NNC5UUjzcxEeTuPbA39zzo+Rny8tGJws/qU+EkjsPoH+MUacsKuHKf3a36lh1OE6WQEv
         ij60bDphUVr+2obqa3BWDqCYEvPGPZDcs1iBqozqdk5+m6BJMSknpXUbeimzVHD5jgSc
         4EIg==
X-Gm-Message-State: AOAM532P0sXAm6JIGnzH42N4vXGlnRVBpTICXvV1g2hSnsT0Bmq+DjiB
        iKeU5YUk8C0Or0nhLCrNvGx0aErKst7rWfLM
X-Google-Smtp-Source: ABdhPJwhcfaHM6I3hzfW9S6hhQjaj7GQb2y/O2ZF4/psdHIzY5GctHmiuux2HqEePgMwYNeq7aTp3w==
X-Received: by 2002:ac8:6a06:: with SMTP id t6mr11182197qtr.206.1597627928246;
        Sun, 16 Aug 2020 18:32:08 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:64a0:f902:c346:a79e])
        by smtp.gmail.com with ESMTPSA id x29sm17499037qtv.80.2020.08.16.18.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 18:32:07 -0700 (PDT)
Date:   Sun, 16 Aug 2020 21:32:06 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Subject: Re: Fwd: [PATCH v3 00/11] [GSoC] Implement Corrected Commit Date
Message-ID: <20200817013206.GA57201@syl.lan>
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
 <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
 <85zh6uxh7l.fsf@gmail.com>
 <CANQwDwdKp7oKy9BeKdvKhwPUiq0R5MS8TCw-eWGCYCoMGv=G-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANQwDwdKp7oKy9BeKdvKhwPUiq0R5MS8TCw-eWGCYCoMGv=G-g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 17, 2020 at 02:16:08AM +0200, Jakub Narębski wrote:
> "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:
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

This seems very sane to me, and I'd be glad to see it spelled out in
more specific detail. I was wondering this myself, and had to double
check with Stolee off-list that my interpretation of Abhishek's code was
correct.

But yes, only writing GDAT chunks when all layers in the chain have GDAT
chunks makes sense, since we can't interoperate between corrected dates
and topological levels. Since we can't fill in the GDAT data of layers
generated in pre-GDAT versions of Git without invalidating the GDAT
layers on-disk, there's no point to speculatively computing both chunks.

Merging rules are obviously correct, which is good. For what it's worth,
the '--split=replace' case is what we'll really care about at GitHub,
since it's unlikely we'd drop all existing commit-graph chains and
rebuild them from scratch. More likely is that we'll let the new GDAT
chunks trickle in over time when we run 'git commit-graph write' with
'--split=replace', which happens "every so often".

> For *reading* we want to use generation number v2 (corrected commit
> date) if possible, and fall back to generation number v1 (topological
> levels).
>
> - If the top layer contains the GDAT chunk (or maybe even if the topmost
>   layer that involves all commits in question, not necessarily the top
>   layer in the full commit-graph chain), then use generation number v2

I don't follow this. If we have a multi-layer chain, either all or none
of the layers have a GDAT chunk. So, "if the top layer contains the GDAT
chunk" makes sense, since it implies that all layers have the GDAT
chunk. I don't see how "even if the topmost layer that involves all
commits in question" would be possible, since (if I'm understanding your
description correctly), we can't have *some* of the layers having a GDAT
chunk with others only having a CDAT chunk.

I'm a little confused here.

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

Good, I'm glad that this can be a quick check (that we can cache for
future reads, but I'm not even sure the caching would be necessary
without measuring).
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

All makes very good sense, except for the one point I raised above.

> >
> > Thanks to Dr. Stolee, Dr. Narębski, and Taylor for their reviews on the
> > first version.

Thanks, Abhishek for your great work on this. I was feeling bad that I
wasn't more involved in the early discussions about the transition plan,
but what you, Stolee, and Jakub came up with all seems like what I would
have suggested, anyway ;-).

> Jakub Narebski

Thanks,
Taylor

Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DACCC433DF
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 07:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10C0A2072D
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 07:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cijb2KZs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgHQH5X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgHQH5W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 03:57:22 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24180C061388
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 00:57:22 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id c6so13685248ilo.13
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 00:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tC1WynisPp34QbEEDNlw3yh4IAUdz8M+SV/f2HsmwlU=;
        b=Cijb2KZsu3lsEiYZloOlz3YzUPqOEpJQBKNAxKa4GKd6kHoREg7nrrOc7NTRJCFfuW
         otxMvkwjju4yR215EVrfgAOu2rux9Brk70rF7OmI6YZbGVKBYoN2DacQl/gPwCCxLUvP
         SEFgSoCJIm502GbWEa/Sk7/XzLJFHPjk8YhB0vZ5A9diOpAi1SKEoafUPceJ9jE6HY1d
         zp0udCUlzqPMWbbzb0yAt+MMK/TMQMPxYbv2JumY8DwYZsjLo1aAfoZ7uxCmI4ST4SvZ
         fPx4VlDiEYMW0KrX60fN1gUbQiEPKhBMqiPf390gFS6gn7e4iOdOBeY6B310+RfOB16k
         +uqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tC1WynisPp34QbEEDNlw3yh4IAUdz8M+SV/f2HsmwlU=;
        b=kzholEOh6gjHtBnU1Y31R6YiD0c9DS5tmLZnGLlbPvBZGVIGOpLMJiFgXTX5DpkSZi
         bjEm9O0H7lx26qFdsqHQAE6YIqpL4aHaepIaNeJK6tqslv8rc0CuvWb5p+aTDILS1tsc
         dBeieABrx+I30hemig4IT1TafZFTr7DPd8xrGFgtBXPlhBK90ZFChrTzcqnPYquatejW
         CX6l8ueAnHzCZJUl6ZYX5vD2Knn/SNHkZZWcBQkRfNbrCU0cVeYxmctCYrOwOm8nmlxe
         TqYx9/j0NJCYpjUXZeA6N8VLNRVY4Cxoa1mCBZa0sfObyiZLF8w/qvW/dmuzzOGYdcPg
         lUnA==
X-Gm-Message-State: AOAM5324iIGJOah6OirjPbVbiU1x7/gdFygxe4o2dmTgNyR6uU5lXmyh
        cYtsQKDBb2wiki+A8rP+XWJPy40k/hIcBl+sgTI=
X-Google-Smtp-Source: ABdhPJwrFL//f6lozMg81i1Gpac3qvd8ticDtGg0JEWmFf5T5/qDUQG/aqggvO/GUnpwg04w3mw47dhiUxYUauVP0EI=
X-Received: by 2002:a92:4001:: with SMTP id n1mr12898338ila.69.1597651041475;
 Mon, 17 Aug 2020 00:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
 <pull.676.v3.git.1597509583.gitgitgadget@gmail.com> <85zh6uxh7l.fsf@gmail.com>
 <CANQwDwdKp7oKy9BeKdvKhwPUiq0R5MS8TCw-eWGCYCoMGv=G-g@mail.gmail.com> <20200817013206.GA57201@syl.lan>
In-Reply-To: <20200817013206.GA57201@syl.lan>
From:   =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Date:   Mon, 17 Aug 2020 09:56:46 +0200
Message-ID: <CANQwDwebQXS8pghXYCBMHvQhCLr9PKFZYsWO4hLAqV=JctV8dA@mail.gmail.com>
Subject: Re: Fwd: [PATCH v3 00/11] [GSoC] Implement Corrected Commit Date
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git <git@vger.kernel.org>, Derrick Stolee <dstolee@microsoft.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 17 Aug 2020 at 03:32, Taylor Blau <me@ttaylorr.com> wrote:
> On Mon, Aug 17, 2020 at 02:16:08AM +0200, Jakub Nar=C4=99bski wrote:
> > "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > >
> > > We will introduce an additional commit-graph chunk, Generation Data c=
hunk,
> > > and store corrected commit date offsets in GDAT chunk while storing
> > > topological levels in CDAT chunk. The old versions of Git would ignor=
e GDAT
> > > chunk, using topological levels from CDAT chunk. In contrast, new ver=
sions
> > > of Git would use corrected commit dates, falling back to topological =
level
> > > if the generation data chunk is absent in the commit-graph file.
> >
> > All right.
> >
> > However I think the cover letter should also describe what should happe=
n
> > in a mixed version environment (for example new Git on command line,
> > copy of old Git used by GUI client), and in particular what should
> > happen in a mixed-chain case - both for reading and for writing the
> > commit-graph file.
> >
> > For *writing*: because old Git would create commit-graph layers without
> > the GDAT chunk, to simplify the behavior and make easy to reason about
> > commit-graph data (the situation should be not that common, and
> > transient -- it should get more rare as the time goes), we want the
> > following behavior from new Git:
> >
> > - If top layer contains the GDAT chunk, or we are rewriting commit-grap=
h
> >   file (--split=3Dreplace), or we are merging layers and there are no
> >   layers without GDAT chunk below set of layers that are merged, then
> >
> >      write commit-graph file or commit-graph layer with GDAT chunk,
> >
> >   otherwise
> >
> >      write commit-graph layer without GDAT chunk.
> >
> >   This means that there are commit-graph layers without GDAT chunk if
> >   and only if the top layer is also without GDAT chunk.
>
> This seems very sane to me, and I'd be glad to see it spelled out in
> more specific detail. I was wondering this myself, and had to double
> check with Stolee off-list that my interpretation of Abhishek's code was
> correct.
>
> But yes, only writing GDAT chunks when all layers in the chain have GDAT
> chunks makes sense, since we can't interoperate between corrected dates
> and topological levels. Since we can't fill in the GDAT data of layers
> generated in pre-GDAT versions of Git without invalidating the GDAT
> layers on-disk, there's no point to speculatively computing both chunks.
>
> Merging rules are obviously correct, which is good. For what it's worth,
> the '--split=3Dreplace' case is what we'll really care about at GitHub,
> since it's unlikely we'd drop all existing commit-graph chains and
> rebuild them from scratch. More likely is that we'll let the new GDAT
> chunks trickle in over time when we run 'git commit-graph write' with
> '--split=3Dreplace', which happens "every so often".

To be more detailed, without '--split=3Dreplace' we would want the followin=
g
layer merging behavior:

   [layer with GDAT][with GDAT][without GDAT][without GDAT][without GDAT]

In the split commit-graph chain above, merging two topmost layers
should create a layer without GDAT; merging three topmost layers
(and any other layers, e.g. two middle ones) should create a layer
 with GDAT.

> > For *reading* we want to use generation number v2 (corrected commit
> > date) if possible, and fall back to generation number v1 (topological
> > levels).
> >
> > - If the top layer contains the GDAT chunk (or maybe even if the topmos=
t
> >   layer that involves all commits in question, not necessarily the top
> >   layer in the full commit-graph chain), then use generation number v2
>
> I don't follow this. If we have a multi-layer chain, either all or none
> of the layers have a GDAT chunk. So, "if the top layer contains the GDAT
> chunk" makes sense, since it implies that all layers have the GDAT
> chunk. I don't see how "even if the topmost layer that involves all
> commits in question" would be possible, since (if I'm understanding your
> description correctly), we can't have *some* of the layers having a GDAT
> chunk with others only having a CDAT chunk.
>
> I'm a little confused here.

This is only speculative, and most probably totally unnecessary
complication (either that, or something that we would get for free).
Assume that the command in question operates only on
historical data; for example `git log --topo-order HEAD~1000`.
If all commits (or, what's equivalent, most recent commits
i.e. HEAD~1000) have their data in split commit-graph layers
with GDAT, we can theoretically use generation number v2,
even if there are some newer commits that have their data
in layers without GDAT (and some even newer ones outside
commit-graph files).

I hope that this explains my (possibly harebrained) idea.

> >   - commit_graph_data->generation stores corrected commit date,
> >     computed as sum of committer date (from CDAT) and offset (from GDAT=
)
> >
> >   - A can reach B   =3D>  gen(A) < gen(B)
> >
> >   - there is no need for committer date heuristics, and no need for
> >     limiting use of generation number to where there is a cutoff (to no=
t
> >     hamper performance).
> >
> > - If there are layers without GDAT chunks, which thanks to the write
> >   behavior means simply top layer without GDAT chunk, we need to turn
> >   off use of generation numbers or fall back to using topological level=
s
>
> Good, I'm glad that this can be a quick check (that we can cache for
> future reads, but I'm not even sure the caching would be necessary
> without measuring).

There is a question where to store the information that we cannot
use generation number v2 (that 'generation' contains topological
levels and not corrected commit date):
- create new global variable
- store it in `struct split_commit_graph_opts`
- set `chunk_generation_data` to NULL for all graphs
  in chain (it is in `struct commit_graph`)?

> >
> >   - commit_graph_data->generation stores topological levels,
> >     taken from CDAT chunk (30-bits)
> >
> >   - A can reach B   =3D>  gen(A) < gen(B)
> >
> >   - we probably want to keep tie-breaking of sorting by generation
> >     number via committer date, and limit use of generation number as
> >     opposed to using committer date heuristics (with slop) to not make
> >     performance worse.
>
> All makes very good sense, except for the one point I raised above.
>
> > >
> > > Thanks to Dr. Stolee, Dr. Nar=C4=99bski, and Taylor for their reviews=
 on the
> > > first version.
>
> Thanks, Abhishek for your great work on this. I was feeling bad that I
> wasn't more involved in the early discussions about the transition plan,
> but what you, Stolee, and Jakub came up with all seems like what I would
> have suggested, anyway ;-).

Thank you for your work on improving this feature.

Best,
--=20
Jakub Narebski

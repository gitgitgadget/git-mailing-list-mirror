Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0C9C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 18:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68BCA2073B
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 18:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rgG2MOiS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbgC0ScG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 14:32:06 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38529 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgC0ScF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 14:32:05 -0400
Received: by mail-io1-f68.google.com with SMTP id m15so10890607iob.5
        for <git@vger.kernel.org>; Fri, 27 Mar 2020 11:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2fuDB1AYX5e8/vGtvePpAF73PJ3hhjSAIO6EzT8DERc=;
        b=rgG2MOiS7p/Ts7y57CEDKx1GTF+hhTMPa+v0l0enYt4e7haTu3y9NsiREuM3gwWSFs
         RaeuruDU5Aq9Vc6KgKHOhSil7M7rA4y2wEIlbRTEFD+YKUtU5kc3dPnWmcnBHajDCDWU
         M6L6mt2o/bfPW/Lk0lZZzQ2+vewLm5JV7ioTsQb+wXODAfoMMjve0EiU3mJG90+7Pme5
         EUobmCCbISjxlfZXsUZssKFn1ZDCDbIN6TGtmPmH4JOVFC+UiVc2Ti7i2nNWBbl6xBFd
         XNSpc9+ufC8ptmBcI4eCkpryPcqJLHiFmyaXsmU3JwdfY1CAfCfVT8lH4WrOXJkVll1+
         wcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2fuDB1AYX5e8/vGtvePpAF73PJ3hhjSAIO6EzT8DERc=;
        b=lVveh+D5VzGvEQyi7qsWNeV5408us9XZP2lnk139XTNY2AB1r3WJIxhe8Cn2heOApm
         VKRE8zFbI1PLObZkTzwlJLn1P6d1TqXbz0lqEps0EoqjOOFx+t/kaxHGC26ebl1YmHam
         7Cm4YQb3hh8JQ7nrD/R63GZnyhi+qeAf8id0XZtMkrmJgyIQmOX824gClT+wb+r0IRCH
         smt5LB5bebJsnZebT1PZIHMcqRHxirecMLDdiwADom42VkFySscS413yhDwI9vFCGKYU
         uEuNjgR3pWzWo/vpKajZvtNKgClqIVHnE1BXOPNTk/3a0acb9Y14iyMPsrNm9B7GQOlo
         5y6w==
X-Gm-Message-State: ANhLgQ1bvR+tsBhGFXsLKUD1NWoCjtGa5BIuth66PO7x3cbt5c/YcR6h
        d6DQNSYMV/kTF8HrCQFYorgVgPmZVuHOn66HioA=
X-Google-Smtp-Source: ADFU+vsx7Z+DPB7Fuv+ypksAE9DZveolIbExUKxUqqukKgwOdOsAEUbrLD7bnYi5HxdMzSdfFC/hSkNP+dexqxgDsSc=
X-Received: by 2002:a6b:8ec2:: with SMTP id q185mr13651777iod.180.1585333924203;
 Fri, 27 Mar 2020 11:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk66ftQqFqP-4kd4-8cHtCMEofSUvbeSQ24pcCCrkz7+2JG1w@mail.gmail.com>
In-Reply-To: <CAHk66ftQqFqP-4kd4-8cHtCMEofSUvbeSQ24pcCCrkz7+2JG1w@mail.gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Date:   Fri, 27 Mar 2020 19:31:28 +0100
Message-ID: <CANQwDwcu9JvcD-BDyfVdRe5LY16OKd+-bw5Lj35GgEq7Scez7A@mail.gmail.com>
Subject: Re: [RFC] Possible idea for GSoC 2020
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Heba Waly <heba.waly@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Hello Abhishek,

Somehow I have missed replying to this email.

On Wed, 18 Mar 2020 at 17:46, Abhishek Kumar
<abhishekkumar8222@gmail.com> wrote:
[...]
> >>> My _prediction_ is that the two-dimensional system will be more
> >>> complicated to write and use, and will not have any measurable
> >>> difference. I'd be happy to be wrong, but I also would not send
> >>> anyone down this direction only to find out I'm right and that
> >>> effort was wasted.
> >>
> >> Agreed. I have been through the papers of the involved variants and on=
 graphs
> >> comparable to some of the largest git repositories, the performance im=
proves by
> >> fifty nanoseconds for a random query.
> >
> > I would recommend extending results for other types of large graphs to
> > the commit graphs with care.  The characteristics of those graphs are
> > quite different from characteristics of commit graph: they usually are
> > scale-free graphs, with low maximum level, and low connectivity: the
> > probability of two random nodes being connected in order of 10^-3 or
> > 10^-4; see e.g. https://speakerdeck.com/jnareb/graph-operations-in-git-=
and-how-to-make-them-faster?slide=3D99
>
> > The last one, called R-ratio, means that testing on random query
> > actually tests mainly negative-cut filters.  That is why some papers
> > provide either separate numbers for negative and for positive queries,
> > or separate numbers for random and for balanced queries.
>
> I do agree that we should be careful while extending results but am skept=
ical
> about the performance difference. If anything, general results could help=
 us
> eyeball the sort of improvement we can expect.

The fact is that for example in FELINE paper authors add min-post positive-=
cut
filter to their own index to improve performance for positive or
balanced queries.

"Reachability Queries in Very Large Graphs: A Fast Refined Online
Search Approach" (2014)
http://openprocedings.org/EDBT/2014/paper_166.pdf

> Of course, there is only one definitive source of truth -
> implementing indices and benchmarking performance.

Right.

> Speaking of special characteristics, are there any indexes designed for m=
aximum
> performance with such graphs?

I was not able to find any reachability labelings that are intended for
commit graphs; even papers examining characteristics of commit graphs
as graphs are sparse. One that I have found is

Marco Biazzini, Martin Monperrus, Benoit Baudry
"On Analyzing the Topology of Commit Histories in
Decentralized Version Control Systems" (2014)
https://hal.archives-ouvertes.fr/hal-01063789

> > > Additionally:
> > > 1. They require significantly more space per commit.
>
> > This depends on the type of the algorithm: is it Label-Only (answering
> > reachability queries without consulting graph), or Label+Graph
> > (augmented online search algorithms):
> > https://speakerdeck.com/jnareb/graph-operations-in-git-and-how-to-make-=
them-faster?slide=3D78
> >
> > The CDAT chunk in current version of commit-graph format takes H+16
> > bytes per commit (where H is the size of object id hash).  From those
> > H+16 bytes 30 bits (slightly less that 4 bytes) are used for current
> > reachability label: the topological level aka generation number.
> > https://speakerdeck.com/jnareb/graph-operations-in-git-and-how-to-make-=
them-faster?slide=3D45
> >
> > The proposed min-post interval label would take 8 bytes per commit, tha=
t
> > is 4 bytes per single number in interval.  That is not much, provided
> > that we get visible performance improvements for at least some often
> > used git commands.
>
> Agreed. Both min-post and GRAIL use 8 bytes each.

Actually GRAIL uses k*8 bytes, where recommended value of k
is k=3D5 for dense graphs and k=3D2 for sparse graphs, and k is number
of random spanning trees which is number of intervals (negative-cut).

GRAIL =3D Graph Reachability indexing via rAndomized Interval
Labeling.

>                                                                          =
           Even FERRARI's
> performance would reach the flat end of diminishing returns if we
> assign three intervals (or 25 bytes) i.e six interval ends and three bits
> for recording whether intervals are exact or approximate.

Actually the current commit-graph format can store at most
(1 << 30) + (1 << 29) + (1 << 28) - 1 (around 1.8 billion) commits.
We can use most significant bit of one end of interval to record
whether interval is exact or approximate (in current format in
CDAT it is used to record whether there are more than 2 parents).
This means that k intervals for FERRARI take also k*8 bytes.
Again they recommend values of k=3D5 for dense, k=3D3 or k=3D2
for sparse. Also there is FERRARI-G variant, with k intervals
on average (global limit) - though I am not sure if it is something
that we can use.

>
> But PReaCH requires 8m + 65 bytes for each commit, which is a huge ask.

Let's take into account only "Pruning Based on DFS Numbering" from
there - I don't think reachability contraction hierarchies labeling
would be good fit for commit-graphs, because they assume bidi-BFS.
Reverse graph is not something that can be incrementally updated.

Maximum number of 4 byte numbers (one word for each end of interval,
and also one word for position of node) would be 5 or 6, depending
on whether we would store only p_tree, or [min(p_tree), post(p_tree)]
interval directly. Even 6*4 bytes per commit is not that huge of a task,
given that current CDAT is H + 2*4 + 8, where H is hash length.

> [An additional 4m bytes from current commit-graph chunk format since we
> do not store children nodes needed for the bi-directional nature of CHs.]
>
> >> 2. They require significantly more preprocessing time.
> >
> > This again depends on the type of algorithm: Label-Only or Label+G.
> >
> > In the case of min-post interval labels, they can be computed together
> > with generation number, during the same commit-graph walk. The amount
> > of calculations required to compute min-post interval is not much.
> > Therefore I think it would be not unreasonable cost.
>
> Also agreed. I do consider min-post interval labels and GRAIL to be some =
of
> more reasonable choices.
>
> But FERRARI would have marginally better performance than GRAIL and the
> five DFS passes made by PReaCH during preprocessing make it unsuitable.

Actually all five PReaCH DFS-labels can be computed during
_single_ DFS pass; implemented in Colaboratory:
https://colab.research.google.com/drive/1V-U7_slu5Z3s5iEEMFKhLXtaxSu5xyzg#s=
crollTo=3D4l0Ld0Jklq1o
as find_dfs_intervals_extra().

[...]
> >> My recommendation is that a GSoC student update the
> >> generation number to "v2" based on the definition you made in [1].
> >> That proposal is also more likely to be effective in Git because
> >> it makes use of extra heuristic information (commit date) to
> >> assist the types of algorithms we care about.
>
> Hear me out on this but topological levels can be
> considered a special case of all corrected commit
> dates occurring one time unit apart.

Right.

> Storing corrected dates instead of topological levels
> for min-post interval labels might actually have the
> best performance of all.

But you cannot use corrected dates for post(v);
topological levels and post-visit order in DFS
are different beasts.

Best,
--=20
Jakub Nar=C4=99bski

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D0531F406
	for <e@80x24.org>; Mon, 14 May 2018 20:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752411AbeENU6r (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 16:58:47 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50550 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752138AbeENU6n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 16:58:43 -0400
Received: by mail-wm0-f68.google.com with SMTP id t11-v6so15859706wmt.0
        for <git@vger.kernel.org>; Mon, 14 May 2018 13:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=qgZReC5qpHgwbw3ZclVbckRGNfAc7VqPjMhZb/pEhXc=;
        b=WtAQdqe4pW8+bah6/9PDjQcwKc/du+5AHM8EGj4aop3WbBg8cSPHEAWUfzp1l7Zdp3
         0JFSday2Q10DDxfn6ZizwKdqGv+2X/czEs9Yu6jOlFkNMeqxWKhLeq7pAufftTsze008
         6MPQkkTvQipEepM0rs7L2Vc7sR96uY7pBna2CpXCSjqJKFDXjS+/QznsmS6TTc3Aub7w
         qhPZbqu5eLr6KDgNnGkuo5XtPn2TSkwuTNY6jI754LQcf08pOEIorw7tS45zQO1UXx2n
         R63LDGcFwJSIqcWoXDfAWOX4p2Vxh6bu+SMZ5NBJ4smHTxVEbzTKx61PlbMVZHNgAOmh
         sYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=qgZReC5qpHgwbw3ZclVbckRGNfAc7VqPjMhZb/pEhXc=;
        b=EQR3Rwas6jtHFu3uyAdEVnpWQa1qRK8mpSmWqZOoA5D8x1JhgNkkHrZC28XpmdIvml
         bJhHyltLHu8ouBWZDA/PXUsBt0KQGCebAEXMaMizCEvTE5sW5rd+cqh98/VzDeGQQoYK
         aSn+f3pgMoZ4wFLMAEqap73e3+ukLj2jfZbWjBakcoNUhF60BVdP9w+sbrBymdbHRqqs
         861g+CRUOjFfN71ESEj42cLzzs/ACUsZjB35Ax09zAZ+CBw2wIutfVslhfo+nvpPsMHw
         qMf5pDSlQwWSma4ItYrNeI3GOnsrjkP9TRIS7PmMeAqapJTpaZXv9qIwdCn3zPGJ/foi
         CaiA==
X-Gm-Message-State: ALKqPwcnhCLgNa1ms52X3yWZsAsfExFzu4qz4VyNUEJq2eI8ArFBrq6t
        TJHOAlxN7rWVaJlNtDKCs+s=
X-Google-Smtp-Source: AB8JxZrpkvC3kUi58oWFbWXK3W+zqzaCcqGr6cdX8GRk8H+geg/KbZxlu5qES/IomY+zSR6tSur41A==
X-Received: by 2002:a1c:3f56:: with SMTP id m83-v6mr6634550wma.88.1526331522360;
        Mon, 14 May 2018 13:58:42 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abuo243.neoplus.adsl.tpnet.pl. [83.8.186.243])
        by smtp.gmail.com with ESMTPSA id y6-v6sm11472609wmy.39.2018.05.14.13.58.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 May 2018 13:58:40 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC] Other chunks for commit-graph, part 1 - Bloom filters, topo order, etc.
References: <86zi1fus3t.fsf@gmail.com>
        <07250f7b-e880-26f5-d412-4fbe69affd41@gmail.com>
        <86r2mh2cur.fsf@gmail.com>
        <fca023a3-f849-4be8-db42-7027bfe7b0dc@gmail.com>
Date:   Mon, 14 May 2018 22:58:37 +0200
In-Reply-To: <fca023a3-f849-4be8-db42-7027bfe7b0dc@gmail.com> (Derrick
        Stolee's message of "Mon, 14 May 2018 09:20:29 -0400")
Message-ID: <864lja2buq.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:
> On 5/12/2018 10:00 AM, Jakub Narebski wrote:
>> Derrick Stolee <stolee@gmail.com> writes:
>>> On 5/4/2018 3:40 PM, Jakub Narebski wrote:
>>>>
>>>> With early parts of commit-graph feature (ds/commit-graph and
>>>> ds/lazy-load-trees) close to being merged into "master", see
>>>> https://public-inbox.org/git/xmqq4ljtz87g.fsf@gitster-ct.c.googlers.co=
m/
>>>> I think it would be good idea to think what other data could be added
>>>> there to make Git even faster.
>>> Before thinking about adding more data to the commit-graph, I think
>>> instead we need to finish taking advantage of the data that is already
>>> there. This means landing the generation number patch [1] (I think
>>> this is close, so I'll send a v6 this week if there is no new
>>> feedback.) and the auto-compute patch [2] (this could use more
>>> feedback, but I'll send a v1 based on the RFC feedback if no one
>>> chimes in).
>>>
>>> [1]
>>> https://public-inbox.org/git/20180501124652.155781-1-dstolee@microsoft.=
com/
>>>  =C2=A0=C2=A0=C2=A0 [PATCH v5 00/11] Compute and consume generation num=
bers
>>>
>>> [2]
>>> https://public-inbox.org/git/20180417181028.198397-1-dstolee@microsoft.=
com/
>>>  =C2=A0=C2=A0=C2=A0 [RFC PATCH 00/12] Integrate commit-graph into 'fsck=
' and 'gc'
>>
>> Right, so the RFC might be a bit premature; I wanted the discussion to
>> be out there to think about when adding new uses of existing features.
>>
>>
>> DIGRESSION: it is commendable that you are sending patches in small,
>> easy digestible chunks / patch series.  It is much easier to review 10+
>> series than 80+ behemoth (though I understand it is not always possible
>> to subdivide patch series into smaller self-contained sub-series).
>>
>> On the other hand, it would be nice to have some roadmap about series
>> and features to be sent in the future, if possible.  Something like what
>> was done when 'git rebase --interactive' was getting builtinified: moved
>> (in parts) to C.  It would be great to have such roadmap with milestones
>> achieved and milestones to be done in the cover letter for series.
>
> I suppose that is what I intended in the "Future Work" section of
> Documentation/technical/commit-graph.txt. It gives a set of things
> that need to be done in order to make this a default feature, not just
> an expert-level feature. When I wrote the section, I was focused
> entirely on "commit-graph version 1.0" and I didn't know how long that
> would take. The series have been getting interest and review (in great
> part to your interest, Jakub) so they have been moving to 'next'
> faster than I anticipated.
>
> I'll plan on writing a more detailed list of future directions, but
> for now I'll list the things I know about and how I see them in
> priority order:
>
> Commit-graph v1.0:
> * ds/generation-numbers
> * 'verify' and fsck/gc integration
> * correct behavior with shallow clones, replace-objects, and grafts

So the goal of current v1.0 phase is to introduce generation numbers.
use them for better performance ("low hanging fruit"), ensure that it is
automatic and safe -- thus useable for an ordinary user.

>
> Commit-graph v1.1:
> * Place commit-graph storage in the_repository
> * 'git tag --merged' use generation numbers
> * 'git log --graph' use generation numbers
>
> Commit-graph v1.X:
> * Protocol v2 verb for sending commit-graph
> * Bloom filters for changed paths

Thanks, that is what I was missing.  The "Future Work" section, while
very nice to have (because it does not require to follow git
development; it is here in technical documentation), lacked
prioritization and rough milestones map.

[...]
>>> The tougher challenge is `git log --graph`. The revision walk
>>> machinery currently uses two precompute phases before iterating
>>> results to the pager: limit_list() and sort_in_topological_order();
>>> these correspond to two phases of Kahn's algorithm for topo-sort
>>> (compute in-degrees, then walk by peeling commits with in-degree
>>> zero). This requires O(N) time, where N is the number of reachable
>>> commits. Instead, we could make this be O(W) time to output one page
>>> of results, where W is (roughly) the number of reachable commits with
>>> generation number above the last reported result.
>>
>> A reminder: Kahn's algorithm (described for example in [1] and [3])
>> looks like this:
>>
>>    L =E2=86=90 Empty list that will contain the sorted elements
>>    S =E2=86=90 Collection of all nodes with no incoming edge
>>    while S is non-empty do
>>        remove a node 'n' from S
>>        add 'n' to tail of L
>>        for each parent 'm' of 'n' do
>>            decrease the in-degree of 'm'
>>            if 'm' has in-degree of 0 then
>>                insert 'm' into S
>>
>> [1]: https://en.wikipedia.org/wiki/Topological_sorting#Kahn's_algorithm
>> [2]: https://www.geeksforgeeks.org/topological-sorting-indegree-based-so=
lution/
[...]

> I'm not following your pseudocode very well,

Not surprising, I've lost myself in the middle of writing it...

>                                              so instead I'll provide a
> more concrete description of what I mentioned before:

Before we start with helper data structures, we should start with the
inputs.  For topological sort it is set of starting commits that define
the part of commit graph we are interested in; they may be some that are
redundant, but those that do not are assumed to have in-degree of 0.

> Here are some data structures.
>
  IDX : ???

> IDV : A dictionary storing the currently-computed in-degree value of a
> commit 'c' as 'IDV[c]'. Assume all commits start with in-degree 0.

Nitpick: I guess that it is really "with assumed in-degree of 0".

This would be stored using commit-slab, isn't it?

> IDQ : A queue, for storing the "in-degree walk". It is a priority
> queue ordered by generation number.

All right, here we use the fact that if we walk up to and including
generation number of commit, then its in-degree will be calculated
correctly, as any commit with generation number smaller than generation
number of given commit cannot reach given commit and change its
in-degree.

> TOQ : A queue, for storing the "topo-order walk". It is a priority
> queue ordered by "visit order" (see algorithm)

Note: max priority queue ordered by "visit order" is practically a
stack, though I guess we prefer priority queue here to use the same code
for '--date-order'.

>
> Here are some methods.
>
> AdvanceInDegreeWalk(IDQ, IDV, gen):

If I understand it correctly this subroutine walks those commits that do
not have correct in-degree calculated, and walks till all commits with
generation number greater or equal to 'gen' cutoff parameter are walked
and have correct in-degree.

Assumes that all commits in graph but not in IDX have their in-degree
calculated.

> =C2=A0=C2=A0=C2=A0 while !IDX.Empty && IDQ.Max >=3D gen:
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 c =3D IDX.Dequeue
>
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 for each parent p of c:

Here the ordering of parents walked does not matter (much), as
generation number is used as cutoff only.

> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 IDV[p]++;
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 IDQ.Enqueue(p, g=
eneration(p))

All right, looks correct; with gen =3D 0 it probably reduces to the
current code that does in-degree calculation upfront.

>
> InitializeTopoOrder(R):
> =C2=A0=C2=A0=C2=A0 Initialize IDQ, IDV, TOQ
>
> =C2=A0=C2=A0=C2=A0 min_generation =3D GENERATION_NUMBER_INFINITY
> =C2=A0=C2=A0=C2=A0 visit_order =3D 0
>
> =C2=A0=C2=A0=C2=A0 for each commit c in R:
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 min_generation =3D min(min_generati=
on, generation(c))
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 IDQ.Enqueue(c, generation(c))
>
> =C2=A0=C2=A0=C2=A0 AdvanceInDegreeWalk(IDQ, IDV, min_generation)

This means that we walk BFS-like until all starting points, that is all
commits in R, have their in-degree calculated.  I think we can avoid
that, but it may change the exact behavior of '--topo-order'.

Currently if one commit in R is from orphan branch (like 'todo' in
git.git), or has otherwise very low generation number, it would mean
that AdvanceInDegreeWalk would walk almost all commits.

> =C2=A0=C2=A0=C2=A0 for each commit c in R:
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if IDV[c] =3D=3D 0:
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 TOQ.Enqueue(c, v=
isit_order++)

I think we may want to either start from commits in the order given on
command line (given by R), and not reverse order, or maybe even start
from commits with maximum generation number.

>
> =C2=A0=C2=A0=C2=A0 return (IDQ, IDV, TOQ, visit_order)

All right.

Here is my [allegedly] improved version, which assumes that we always
want to start from commit with maximum generation number (there may be
more than one such commit).

Let's add one more data structure:

  RRQ : A queue, for storing remaining commits from R (starting point).
  It is a priority queue ordered by generation number.


InitializeTopoOrder(R):
=C2=A0=C2=A0=C2=A0 Initialize IDQ, IDV, TOQ, RRQ

=C2=A0=C2=A0=C2=A0 max_generation =3D 0
=C2=A0=C2=A0=C2=A0 visit_order =3D 0

=C2=A0=C2=A0=C2=A0 for each commit c in R:
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 max_generation =3D max(max_generation=
, generation(c))
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 unless IsRedundantFilter(R / c, c): #=
 optional
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 RRQ.Enqueue(c, gen=
eration(c))

=C2=A0=C2=A0=C2=A0 while RRQ.Max =3D=3D max_generation:
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 c =3D RRQ.Dequeue()
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 IDV[c] =3D 0  # commits with max gen =
have in-degree of 0
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 IDQ.Enqueue(c, generation(c))

=C2=A0=C2=A0=C2=A0 # this would be almost no-op
=C2=A0=C2=A0=C2=A0 AdvanceInDegreeWalk(IDQ, IDV, max_generation)

=C2=A0=C2=A0=C2=A0 for each commit c in reversed R:
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if generation(c) =3D=3D max_generatio=
n: # then IDV[c] =3D=3D 0
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 TOQ.Enqueue(c, vis=
it_order++)

=C2=A0=C2=A0=C2=A0 return (IDQ, IDV, TOQ, RRQ, visit_order)

>
> GetNextInTopoOrder(IDQ, IDV, TOQ, ref visit_order):
> =C2=A0=C2=A0=C2=A0 if TOQ.Empty:
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return null
>
> =C2=A0=C2=A0=C2=A0 c =3D TOQ.Dequeue()
>
> =C2=A0=C2=A0=C2=A0 for each parent p of c:
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 IDV[p]--
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 AdvanceInDegreeWalk(IDQ, IDV, gener=
ation(p))
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if IDV[p] =3D=3D 0:
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 TOQ.Enqueue(p, v=
isit_order++)
>
> =C2=A0=C2=A0=C2=A0 return c

With the modification to InitializeTopoOrder it would be

GetNextInTopoOrder(IDQ, IDV, TOQ, RRQ, ref visit_order):
=C2=A0=C2=A0=C2=A0 if TOQ.Empty:
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return null

=C2=A0=C2=A0=C2=A0 c =3D TOQ.Dequeue()

=C2=A0=C2=A0=C2=A0 for each parent p of c, sorted by generation number:
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 # some of maybe in-degree zero are no=
w surely in-degree zero
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 while RRQ.Max > generation(p):
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0r =3D RRQ.Dequeue()
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0IDQ.Enqueue(r, gene=
ration(r))

=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 AdvanceInDegreeWalk(IDQ, IDV, generat=
ion(p))
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 IDV[p]--
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if IDV[p] =3D=3D 0:
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 TOQ.Enqueue(p, vis=
it_order++)

=C2=A0=C2=A0=C2=A0 return c


> (I mention "ref visit_order" to be sure we are
> passing-by-reference. In a full implementation, the walk details would
> be grouped into a struct.)
>
> This algorithm is relatively simple, but the hard part is teasing the
> revision walk machinery to initialize the data by calling
> InitializeTopoOrder(R) and to call GetNextInTopoOrder() whenever it
> needs a new element of the walk. That is, it is hard to be sure we are
> not causing side-effects as we make that transformation.

Right.  I'll take a look at existing code to find out how involved that
would be.

It is a pity that we cannot simply turn in-degree calculation into
producer that calculates in-degree in generation number order, and spits
it to FIFO pipe / channel / supply / blocking queue, while topo-order
calculation reads from in-degree pipe, and spits output to pager...

I wonder if we could use Scientist tool to make sure that new and old
code give the same results.

[...]
>> I think that, beside writing patches for Git, exploring how various
>> pieces of data and various indexes affect walking commit graphs is also
>> important.  My explorations shown that, for example, that FELINE index
>> is not good fit for relatively "narrow" graphs of revision history.
>> Exploring this in Python / Jupyter is easier than trying to write a
>> exploratory patch for Git, in my opinion.  Just IMVHO.

Actually I should have said that FELINE index for commit graphs (that I
have checked) does not show improvement over simply using some
topological ordering as negative-cut filter.

>
> You are right. Ruling out possibilities is the best outcome these
> prototypes can have. Your work has saved someone a lot of time in
> investigating that direction.

Regards,
--
Jakub Nar=C4=99bski

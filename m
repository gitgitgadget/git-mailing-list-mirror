Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BB671F406
	for <e@80x24.org>; Sat, 12 May 2018 14:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751110AbeELOAT (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 10:00:19 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34933 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751048AbeELOAR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 10:00:17 -0400
Received: by mail-wr0-f196.google.com with SMTP id i14-v6so7919616wre.2
        for <git@vger.kernel.org>; Sat, 12 May 2018 07:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=BetlaEC2s168be5eql1C+JbJ8kXZp5bq0unyduEc6ng=;
        b=nsdQQT4CQTYyHP40ob4VnOeigTmOPgfCJNbJYzP8DJpqGlQSWKpn16tuRVgE8NdFqB
         DOLzy1+1JDHubThflwnQxo5PVrwjuC0MfBQn7bBAPFJJ8aQ1srw7sVRCyzV3zTD3r9Ok
         2tf9uRoiYkWwNVeJ6f1RRjXikHscOB7odLYZU/cq3X0/jvQdGP7HSvTvZawlBNzO4yHb
         lonkB6+4vn0iuCaqCE0RTO5NhOYn2iJxBMPV0hgre6h/mXq2VkbziT9geuSS/x+08cuv
         5GlBDklZfoRYQTdQmw8JCxo+CAXIiAx5LYPIQot3e4+/ECEVrRI6zaaCrS+JK4xmrjAr
         374g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=BetlaEC2s168be5eql1C+JbJ8kXZp5bq0unyduEc6ng=;
        b=cc57D8pAKm17Bp0s3z2OPdaGmj7vfP1gplo0ZlCJoaqeRNN1Vt7tLiLwcfq5dPzygc
         0Shj1iU7x5ELWMNCTnJKpS3KIPTmVuKzsWQP2Sj9VxLDMb/k/+2yrkeOrDF1eyOnXhan
         B5ok5NGrRlpXtQGYUy1ucwte/dX7v6phPIaWSSaQAFQWbeakDvx8GecNnRrRJAd8AIYR
         mVqGRoIEuLFr+hv31y4273XnXswGu7qi6lp0NdCLf1crRYJkE1daa1Uq+T9y3rzlAQn7
         6ZFyx5uA/inUCBdRpjKXEE8o1cc6MwtaDhPGFcWRK+rFdzS3nEheHja6crOlskR6NxkY
         NdtA==
X-Gm-Message-State: ALKqPwco++9yJND6zCoN0UizET5lGhgcKbMajOzE3O4VRiLFuz8mQJ2l
        r0HA6gx63dHNcboYU4wlVoc=
X-Google-Smtp-Source: AB8JxZouIrnQQ0L2kqChqcdCxLYbcP/b8EP6GMmA2n10tORbITE6CRRYjFuw05mpMrGr7GTtckWEDA==
X-Received: by 2002:adf:a9e6:: with SMTP id b93-v6mr2346313wrd.234.1526133616427;
        Sat, 12 May 2018 07:00:16 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abrh212.neoplus.adsl.tpnet.pl. [83.8.101.212])
        by smtp.gmail.com with ESMTPSA id h5-v6sm5824432wrm.37.2018.05.12.07.00.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 12 May 2018 07:00:15 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC] Other chunks for commit-graph, part 1 - Bloom filters, topo order, etc.
References: <86zi1fus3t.fsf@gmail.com>
        <07250f7b-e880-26f5-d412-4fbe69affd41@gmail.com>
Date:   Sat, 12 May 2018 16:00:12 +0200
Message-ID: <86r2mh2cur.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:
> On 5/4/2018 3:40 PM, Jakub Narebski wrote:
>>
>> With early parts of commit-graph feature (ds/commit-graph and
>> ds/lazy-load-trees) close to being merged into "master", see
>> https://public-inbox.org/git/xmqq4ljtz87g.fsf@gitster-ct.c.googlers.com/
>> I think it would be good idea to think what other data could be added
>> there to make Git even faster.
>
> Before thinking about adding more data to the commit-graph, I think
> instead we need to finish taking advantage of the data that is already
> there. This means landing the generation number patch [1] (I think
> this is close, so I'll send a v6 this week if there is no new
> feedback.) and the auto-compute patch [2] (this could use more
> feedback, but I'll send a v1 based on the RFC feedback if no one
> chimes in).
>
> [1]
> https://public-inbox.org/git/20180501124652.155781-1-dstolee@microsoft.co=
m/
> =C2=A0=C2=A0=C2=A0 [PATCH v5 00/11] Compute and consume generation numbers
>
> [2]
> https://public-inbox.org/git/20180417181028.198397-1-dstolee@microsoft.co=
m/
> =C2=A0=C2=A0=C2=A0 [RFC PATCH 00/12] Integrate commit-graph into 'fsck' a=
nd 'gc'

Right, so the RFC might be a bit premature; I wanted the discussion to
be out there to think about when adding new uses of existing features.


DIGRESSION: it is commendable that you are sending patches in small,
easy digestible chunks / patch series.  It is much easier to review 10+
series than 80+ behemoth (though I understand it is not always possible
to subdivide patch series into smaller self-contained sub-series).

On the other hand, it would be nice to have some roadmap about series
and features to be sent in the future, if possible.  Something like what
was done when 'git rebase --interactive' was getting builtinified: moved
(in parts) to C.  It would be great to have such roadmap with milestones
achieved and milestones to be done in the cover letter for series.

> The big wins remaining from this data are `git tag --merged` and `git
> log --graph`. The `tag` scenario is probably easier: this can be done
> by replacing the revision-walk underlying the call to use
> paint_down_to_common() instead. Requires adding an external method to
> commit.c, but not too much code.

I wonder if there is some significant reason behind `git tag --merged`
using its own codepath, beside historical reasons.  Maybe performance is
better with current code?

Utilizing paint_down_to_common() there, beside reducing amount of code
you would have to modify, would also unify code (and possibly reduce
amount of code).  That's very nice.

>
> The tougher challenge is `git log --graph`. The revision walk
> machinery currently uses two precompute phases before iterating
> results to the pager: limit_list() and sort_in_topological_order();
> these correspond to two phases of Kahn's algorithm for topo-sort
> (compute in-degrees, then walk by peeling commits with in-degree
> zero). This requires O(N) time, where N is the number of reachable
> commits. Instead, we could make this be O(W) time to output one page
> of results, where W is (roughly) the number of reachable commits with
> generation number above the last reported result.

A reminder: Kahn's algorithm (described for example in [1] and [3])
looks like this:

  L =E2=86=90 Empty list that will contain the sorted elements
  S =E2=86=90 Collection of all nodes with no incoming edge
  while S is non-empty do
      remove a node 'n' from S
      add 'n' to tail of L
      for each parent 'm' of 'n' do
          decrease the in-degree of 'm'
          if 'm' has in-degree of 0 then
              insert 'm' into S

[1]: https://en.wikipedia.org/wiki/Topological_sorting#Kahn's_algorithm
[2]: https://www.geeksforgeeks.org/topological-sorting-indegree-based-solut=
ion/

> In order to take advantage of this approach, the two phases of Kahn's
> algorithm need to be done in-line with reporting results to the
> pager. This means keeping two queues: one is a priority queue by
> generation number that computes in-degrees,

This simple solition of using priority queue by generation number won't
work, I think.  In-degree is computed from heads down, generation number
is computed from roots up.

For example in the graph below

   *<---*<---*<---*<---*<---*<---*<---*<---*<---A
         \
          \--*<---B

both A and B have in-degree of 0, but gen(B) << gen(A).

But I might be wrong.

>                                            the other is a priority
> queue (by commit-date or a visit-order value to do the --topo-order
> priority) that peels the in-degree-zero commits (and decrements the
> in-degree of their parents). I have not begun this refactoring effort
> because appears complicated to me, and it will be hard to tease out
> the logic without affecting other consumers of the revision-walk
> machinery.
>
> I would love it if someone picked up the `git log --graph` task, since
> it will be a few weeks before I have the time to focus on it.

Let's assume that we have extra data (indexes such as generation number)
that can be used for positive-cut (we know that A can reach B) and
negative-cut (we know that A cannot reach B) filters.  Generation number
aka. topological level can be used in negative-cut filter.

NOTE: I have not looked at current Git code that does topological
sorting, as to not be suggested by the existing implementation.


How the indexes-amplified incremental Kahn's algorithm could look like:

First we need to find at least one node / vertex / commit with an
in-degree of zero.  We are given a list of commits to start from, but
they may not all have in-degree of zero - they may be dependent, or in
other words some of them may be reachable from others and be
irrelevant.  Here negative-cut and positive-cut filters can help.

If the order of commits on command line does not matter, we can start
from any distinct commit with highest generation number - we know that
it cannot be reached from other heads / refs and thus has in-degree of
zero.

  L =E2=86=90 Empty list that will contain the sorted elements
  S =E2=86=90 Collection of all nodes with no incoming edge
  R =E2=86=90 Collection of starting points (refs)
  while S is non-empty do
      remove a node 'n' from S
      add 'n' to tail of L
      for each parent 'm' of 'n' do
          if 'm' cannot be reached from R then
              # it has in-degree of 0
              insert 'm' into S
          else if 'm' can be reached from R then
              # it has in-degree greater than 0
              insert 'm' into R
          else
              walk from each 'r of R,
              until we know if 'm' is reachable from R
              then insert it into S or R

              perhaps computing in-degrees,
              or marking commits as reachable...


Does it looks correct?  I can try to make this pseudocode into actual
algorithm.

>
> Without completing the benefits we get from generation numbers, these
> investigations into other reachability indexes will be incomplete as
> they are comparing benefits without all consumers taking advantage of
> a reachability index.

On one hand side, you are right: if we try to investigate of some
reachability index is worth it by checking if it *improves performance
of actual git operations* without all consumers taking advantage of a
reachability index would be incomplete.

On the other hand we can still perform synthetic tests: how much less
commits we walk when checking that A can reach B on real commit graphs
(like I did in mentioned Google Colaboratory notebook [3]).  This
assumes that the cost of accessing commit data (and possibly also
indexes data) dominates, and the cost of using reachability indexes is
negligible.

[3]: https://colab.research.google.com/drive/1V-U7_slu5Z3s5iEEMFKhLXtaxSu5x=
yzg

On the gripping hand the construction of algorithms in those future
steps would be, I think, affected by what types of indexes would we
have: negative-cut filters, positive-cut filters, reachability bitmaps,
Bloom filters for changed files, eic.

> [...]
>> Bloom filter for changed paths
>> ------------------------------
>>
>> The goal of this chunk is to speed up checking if the file or directory
>> was changed in given commit, for queries such as "git log -- <file>" or
>> "git blame <file>".  This is something that according to "Git Merge
>> contributor summit notes" [2] is already present in VSTS (Visual Studio
>> Team Services - the server counterpart of GVFS: Git Virtual File System)
>> at Microsoft:
>>
>> AV> - VSTS adds bloom filters to know which paths have changed on the co=
mmit
>> AV> - tree-same check in the bloom filter is fast; speeds up file histor=
y checks
>> AV> - might be useful in the client as well, since limited-traversal is =
common
>> AV> - if the file history is _very_ sparse, then bloom filter is useful
>> AV> - but needs pre-compute, so useful to do once
>> AV> - first make the client do it, then think about how to serve it cent=
rally
>>
>> [2]: https://public-inbox.org/git/alpine.DEB.2.20.1803091557510.23109@al=
exmv-linux/
>>
>> I think it was what Derrick Stolee was talking about at the end of his
>> part of "Making Git for Windows" presentation at Git Merge 2018:
>> https://youtu.be/oOMzi983Qmw?t=3D1835
>>
>> This was also mentioned in subthread of "Re: [PATCH v2 0/4] Lazy-load
>> trees when reading commit-graph", starting from [3]
>> [3]: https://public-inbox.org/git/86y3hyeu6c.fsf@gmail.com/
>
> Again, the benefits of Bloom filters should only be measured after
> already taking advantage of a reachability index during `git
> log`. However, you could get performance benefits from Bloom filters
> in a normal `git log` (no topo-order).

I wonder how much they improve performance of "git blame"...

> The tricky part about this feature is that the decisions we made in
> our C# implementation for the VSTS Git server may be very different
> than the needs for the C implementation of the Git client. Questions
> like "how do we handle merge commits?" may have different answers,
> which can only be discovered by implementing the feature.
>
> (The answer for VSTS is that we only store Bloom filters containing
> the list of changed paths against the first parent. The second parent
> frequently has too many different paths, and if we are computing
> file-history simplification we have already determined the first
> parent is _not_ TREESAME, which requires verifying the difference by
> parsing trees against the first parent.)

Thanks for the information.  I think for now it is sufficient level of
the detail.

> I'm happy to provide more information on how we built this feature if
> someone is writing a patch. Otherwise, I plan to implement it after
> finishing the parts I think are higher priority.

All right, I understand that.  Time is a scarse resource.


I think that, beside writing patches for Git, exploring how various
pieces of data and various indexes affect walking commit graphs is also
important.  My explorations shown that, for example, that FELINE index
is not good fit for relatively "narrow" graphs of revision history.
Exploring this in Python / Jupyter is easier than trying to write a
exploratory patch for Git, in my opinion.  Just IMVHO.

Best,
--=20
Jakub Nar=C4=99bski

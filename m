Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1E0C1F406
	for <e@80x24.org>; Mon, 14 May 2018 13:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753759AbeENNUg (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 09:20:36 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:37753 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753751AbeENNUd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 09:20:33 -0400
Received: by mail-qk0-f173.google.com with SMTP id 11-v6so9916864qkk.4
        for <git@vger.kernel.org>; Mon, 14 May 2018 06:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=c+WqslmsCCbm/yjdLh4PRq3tzMDjHanSkEAkm1aD7fs=;
        b=HDCs9J/KlYLWyJCiQ7xhxb9mzozmhaFsU/B4nVNqbYlnK/hv7U5zoRBESj6qPSN/A4
         jD8YilFYvIuMxue94bxCbAi19zJW7aNgyAuE0lTKhUKmLnkJqLQewYlZ57XEJS/vLd4T
         69rO4/o/Mcl9/H0n7gMzu65XYwDPwSJQFe6vvoS2yyhmOkUt261xnwLAGEIdBqMeAKRS
         SRlNJMp1fUCt7p4ByTdEp6Lt9gqsi8LmEUI4UKoqq1C+lVdU0XP1cc8I1AC3NKYaNqtK
         TLzGUxSM0arS4An8TOBgUKjK4fkP/ogTAd3XSqOmDNSqbD0/kWdwDrrVLOkJwQIZL+Hs
         Uc/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=c+WqslmsCCbm/yjdLh4PRq3tzMDjHanSkEAkm1aD7fs=;
        b=V98zlX+B8DFyGC3BX+HG9jGqfOv3Kc8C/eaIFz7zP6pfh71stAjs6tNz9h2Xu0qGYQ
         SBvCDlkaUHWnKaiiqzDVsIUfNGfnz/tUh0QolmFSVL4sYnBHJBOqJOGUOpbBw5Mu3Oow
         u90+POv8HrW+qZPQTdCQpAMfeJV6Pr+On8t8s+3BYMrWbsgGJHQ084XYvU/97OffXlW/
         T/5bcLaiC/eKf77sgOcCp+uCV9inm0DT4OOo5lY4LJRbSG+xWmgGLCwZN3min7N7Imvs
         hFuQvTExGIjKdVvgrH0dLT/nKgwQWUIOa70/gjxqz79L0Rs8z2DwVYxzdyOzld/RXryF
         Gmmw==
X-Gm-Message-State: ALKqPwetHnjC/uGAsR6aihBhqiV+cB9HWAC91QscjIg2cMZR4wZCZhQZ
        0FyLPHxjiggmmS9ewyzQCO8=
X-Google-Smtp-Source: AB8JxZr8bFRf3CLeAkwQ/ozl3L1qVLZfMVZQ3M5gTVbRqLtvCXwV+VhhoWu3nUfSfDU6p6H1VLtKQA==
X-Received: by 2002:a37:c997:: with SMTP id m23-v6mr8261008qkl.372.1526304031996;
        Mon, 14 May 2018 06:20:31 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id u21-v6sm7261828qki.63.2018.05.14.06.20.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 May 2018 06:20:30 -0700 (PDT)
Subject: Re: [RFC] Other chunks for commit-graph, part 1 - Bloom filters, topo
 order, etc.
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <86zi1fus3t.fsf@gmail.com>
 <07250f7b-e880-26f5-d412-4fbe69affd41@gmail.com> <86r2mh2cur.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <fca023a3-f849-4be8-db42-7027bfe7b0dc@gmail.com>
Date:   Mon, 14 May 2018 09:20:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <86r2mh2cur.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/12/2018 10:00 AM, Jakub Narebski wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>> On 5/4/2018 3:40 PM, Jakub Narebski wrote:
>>> With early parts of commit-graph feature (ds/commit-graph and
>>> ds/lazy-load-trees) close to being merged into "master", see
>>> https://public-inbox.org/git/xmqq4ljtz87g.fsf@gitster-ct.c.googlers.com/
>>> I think it would be good idea to think what other data could be added
>>> there to make Git even faster.
>> Before thinking about adding more data to the commit-graph, I think
>> instead we need to finish taking advantage of the data that is already
>> there. This means landing the generation number patch [1] (I think
>> this is close, so I'll send a v6 this week if there is no new
>> feedback.) and the auto-compute patch [2] (this could use more
>> feedback, but I'll send a v1 based on the RFC feedback if no one
>> chimes in).
>>
>> [1]
>> https://public-inbox.org/git/20180501124652.155781-1-dstolee@microsoft.com/
>>      [PATCH v5 00/11] Compute and consume generation numbers
>>
>> [2]
>> https://public-inbox.org/git/20180417181028.198397-1-dstolee@microsoft.com/
>>      [RFC PATCH 00/12] Integrate commit-graph into 'fsck' and 'gc'
> Right, so the RFC might be a bit premature; I wanted the discussion to
> be out there to think about when adding new uses of existing features.
>
>
> DIGRESSION: it is commendable that you are sending patches in small,
> easy digestible chunks / patch series.  It is much easier to review 10+
> series than 80+ behemoth (though I understand it is not always possible
> to subdivide patch series into smaller self-contained sub-series).
>
> On the other hand, it would be nice to have some roadmap about series
> and features to be sent in the future, if possible.  Something like what
> was done when 'git rebase --interactive' was getting builtinified: moved
> (in parts) to C.  It would be great to have such roadmap with milestones
> achieved and milestones to be done in the cover letter for series.

I suppose that is what I intended in the "Future Work" section of 
Documentation/technical/commit-graph.txt. It gives a set of things that 
need to be done in order to make this a default feature, not just an 
expert-level feature. When I wrote the section, I was focused entirely 
on "commit-graph version 1.0" and I didn't know how long that would 
take. The series have been getting interest and review (in great part to 
your interest, Jakub) so they have been moving to 'next' faster than I 
anticipated.

I'll plan on writing a more detailed list of future directions, but for 
now I'll list the things I know about and how I see them in priority order:

Commit-graph v1.0:
* ds/generation-numbers
* 'verify' and fsck/gc integration
* correct behavior with shallow clones, replace-objects, and grafts

Commit-graph v1.1:
* Place commit-graph storage in the_repository
* 'git tag --merged' use generation numbers
* 'git log --graph' use generation numbers

Commit-graph v1.X:
* Protocol v2 verb for sending commit-graph
* Bloom filters for changed paths

>
>> The big wins remaining from this data are `git tag --merged` and `git
>> log --graph`. The `tag` scenario is probably easier: this can be done
>> by replacing the revision-walk underlying the call to use
>> paint_down_to_common() instead. Requires adding an external method to
>> commit.c, but not too much code.
> I wonder if there is some significant reason behind `git tag --merged`
> using its own codepath, beside historical reasons.  Maybe performance is
> better with current code?
>
> Utilizing paint_down_to_common() there, beside reducing amount of code
> you would have to modify, would also unify code (and possibly reduce
> amount of code).  That's very nice.
>
>> The tougher challenge is `git log --graph`. The revision walk
>> machinery currently uses two precompute phases before iterating
>> results to the pager: limit_list() and sort_in_topological_order();
>> these correspond to two phases of Kahn's algorithm for topo-sort
>> (compute in-degrees, then walk by peeling commits with in-degree
>> zero). This requires O(N) time, where N is the number of reachable
>> commits. Instead, we could make this be O(W) time to output one page
>> of results, where W is (roughly) the number of reachable commits with
>> generation number above the last reported result.
> A reminder: Kahn's algorithm (described for example in [1] and [3])
> looks like this:
>
>    L ← Empty list that will contain the sorted elements
>    S ← Collection of all nodes with no incoming edge
>    while S is non-empty do
>        remove a node 'n' from S
>        add 'n' to tail of L
>        for each parent 'm' of 'n' do
>            decrease the in-degree of 'm'
>            if 'm' has in-degree of 0 then
>                insert 'm' into S
>
> [1]: https://en.wikipedia.org/wiki/Topological_sorting#Kahn's_algorithm
> [2]: https://www.geeksforgeeks.org/topological-sorting-indegree-based-solution/
>
>> In order to take advantage of this approach, the two phases of Kahn's
>> algorithm need to be done in-line with reporting results to the
>> pager. This means keeping two queues: one is a priority queue by
>> generation number that computes in-degrees,
> This simple solition of using priority queue by generation number won't
> work, I think.  In-degree is computed from heads down, generation number
> is computed from roots up.
>
> For example in the graph below
>
>     *<---*<---*<---*<---*<---*<---*<---*<---*<---A
>           \
>            \--*<---B
>
> both A and B have in-degree of 0, but gen(B) << gen(A).
>
> But I might be wrong.
>
>>                                             the other is a priority
>> queue (by commit-date or a visit-order value to do the --topo-order
>> priority) that peels the in-degree-zero commits (and decrements the
>> in-degree of their parents). I have not begun this refactoring effort
>> because appears complicated to me, and it will be hard to tease out
>> the logic without affecting other consumers of the revision-walk
>> machinery.
>>
>> I would love it if someone picked up the `git log --graph` task, since
>> it will be a few weeks before I have the time to focus on it.
> Let's assume that we have extra data (indexes such as generation number)
> that can be used for positive-cut (we know that A can reach B) and
> negative-cut (we know that A cannot reach B) filters.  Generation number
> aka. topological level can be used in negative-cut filter.
>
> NOTE: I have not looked at current Git code that does topological
> sorting, as to not be suggested by the existing implementation.
>
>
> How the indexes-amplified incremental Kahn's algorithm could look like:
>
> First we need to find at least one node / vertex / commit with an
> in-degree of zero.  We are given a list of commits to start from, but
> they may not all have in-degree of zero - they may be dependent, or in
> other words some of them may be reachable from others and be
> irrelevant.  Here negative-cut and positive-cut filters can help.
>
> If the order of commits on command line does not matter, we can start
> from any distinct commit with highest generation number - we know that
> it cannot be reached from other heads / refs and thus has in-degree of
> zero.
>
>    L ← Empty list that will contain the sorted elements
>    S ← Collection of all nodes with no incoming edge
>    R ← Collection of starting points (refs)
>    while S is non-empty do
>        remove a node 'n' from S
>        add 'n' to tail of L
>        for each parent 'm' of 'n' do
>            if 'm' cannot be reached from R then
>                # it has in-degree of 0
>                insert 'm' into S
>            else if 'm' can be reached from R then
>                # it has in-degree greater than 0
>                insert 'm' into R
>            else
>                walk from each 'r of R,
>                until we know if 'm' is reachable from R
>                then insert it into S or R
>
>                perhaps computing in-degrees,
>                or marking commits as reachable...
>
>
> Does it looks correct?  I can try to make this pseudocode into actual
> algorithm.

I'm not following your pseudocode very well, so instead I'll provide a 
more concrete description of what I mentioned before:

Here are some data structures.

IDV : A dictionary storing the currently-computed in-degree value of a 
commit 'c' as 'IDV[c]'. Assume all commits start with in-degree 0.
IDQ : A queue, for storing the "in-degree walk". It is a priority queue 
ordered by generation number.
TOQ : A queue, for storing the "topo-order walk". It is a priority queue 
ordered by "visit order" (see algorithm)

Here are some methods.

AdvanceInDegreeWalk(IDQ, IDV, gen):
     while !IDX.Empty && IDQ.Max >= gen:
         c = IDX.Dequeue

         for each parent p of c:
             IDV[p]++;
             IDQ.Enqueue(p, generation(p))

InitializeTopoOrder(R):
     Initialize IDQ, IDV, TOQ

     min_generation = GENERATION_NUMBER_INFINITY
     visit_order = 0

     for each commit c in R:
         min_generation = min(min_generation, generation(c))
         IDQ.Enqueue(c, generation(c))

     AdvanceInDegreeWalk(IDQ, IDV, min_generation)

     for each commit c in R:
         if IDV[c] == 0:
             TOQ.Enqueue(c, visit_order++)

     return (IDQ, IDV, TOQ, visit_order)

GetNextInTopoOrder(IDQ, IDV, TOQ, ref visit_order):
     if TOQ.Empty:
         return null

     c = TOQ.Dequeue()

     for each parent p of c:
         IDV[p]--
         AdvanceInDegreeWalk(IDQ, IDV, generation(p))
         if IDV[p] == 0:
             TOQ.Enqueue(p, visit_order++)

     return c

(I mention "ref visit_order" to be sure we are passing-by-reference. In 
a full implementation, the walk details would be grouped into a struct.)

This algorithm is relatively simple, but the hard part is teasing the 
revision walk machinery to initialize the data by calling 
InitializeTopoOrder(R) and to call GetNextInTopoOrder() whenever it 
needs a new element of the walk. That is, it is hard to be sure we are 
not causing side-effects as we make that transformation.

>
>> Without completing the benefits we get from generation numbers, these
>> investigations into other reachability indexes will be incomplete as
>> they are comparing benefits without all consumers taking advantage of
>> a reachability index.
> On one hand side, you are right: if we try to investigate of some
> reachability index is worth it by checking if it *improves performance
> of actual git operations* without all consumers taking advantage of a
> reachability index would be incomplete.
>
> On the other hand we can still perform synthetic tests: how much less
> commits we walk when checking that A can reach B on real commit graphs
> (like I did in mentioned Google Colaboratory notebook [3]).  This
> assumes that the cost of accessing commit data (and possibly also
> indexes data) dominates, and the cost of using reachability indexes is
> negligible.
>
> [3]: https://colab.research.google.com/drive/1V-U7_slu5Z3s5iEEMFKhLXtaxSu5xyzg
>
> On the gripping hand the construction of algorithms in those future
> steps would be, I think, affected by what types of indexes would we
> have: negative-cut filters, positive-cut filters, reachability bitmaps,
> Bloom filters for changed files, eic.
>
>> [...]
>>> Bloom filter for changed paths
>>> ------------------------------
>>>
>>> The goal of this chunk is to speed up checking if the file or directory
>>> was changed in given commit, for queries such as "git log -- <file>" or
>>> "git blame <file>".  This is something that according to "Git Merge
>>> contributor summit notes" [2] is already present in VSTS (Visual Studio
>>> Team Services - the server counterpart of GVFS: Git Virtual File System)
>>> at Microsoft:
>>>
>>> AV> - VSTS adds bloom filters to know which paths have changed on the commit
>>> AV> - tree-same check in the bloom filter is fast; speeds up file history checks
>>> AV> - might be useful in the client as well, since limited-traversal is common
>>> AV> - if the file history is _very_ sparse, then bloom filter is useful
>>> AV> - but needs pre-compute, so useful to do once
>>> AV> - first make the client do it, then think about how to serve it centrally
>>>
>>> [2]: https://public-inbox.org/git/alpine.DEB.2.20.1803091557510.23109@alexmv-linux/
>>>
>>> I think it was what Derrick Stolee was talking about at the end of his
>>> part of "Making Git for Windows" presentation at Git Merge 2018:
>>> https://youtu.be/oOMzi983Qmw?t=1835
>>>
>>> This was also mentioned in subthread of "Re: [PATCH v2 0/4] Lazy-load
>>> trees when reading commit-graph", starting from [3]
>>> [3]: https://public-inbox.org/git/86y3hyeu6c.fsf@gmail.com/
>> Again, the benefits of Bloom filters should only be measured after
>> already taking advantage of a reachability index during `git
>> log`. However, you could get performance benefits from Bloom filters
>> in a normal `git log` (no topo-order).
> I wonder how much they improve performance of "git blame"...
>
>> The tricky part about this feature is that the decisions we made in
>> our C# implementation for the VSTS Git server may be very different
>> than the needs for the C implementation of the Git client. Questions
>> like "how do we handle merge commits?" may have different answers,
>> which can only be discovered by implementing the feature.
>>
>> (The answer for VSTS is that we only store Bloom filters containing
>> the list of changed paths against the first parent. The second parent
>> frequently has too many different paths, and if we are computing
>> file-history simplification we have already determined the first
>> parent is _not_ TREESAME, which requires verifying the difference by
>> parsing trees against the first parent.)
> Thanks for the information.  I think for now it is sufficient level of
> the detail.
>
>> I'm happy to provide more information on how we built this feature if
>> someone is writing a patch. Otherwise, I plan to implement it after
>> finishing the parts I think are higher priority.
> All right, I understand that.  Time is a scarse resource.
>
>
> I think that, beside writing patches for Git, exploring how various
> pieces of data and various indexes affect walking commit graphs is also
> important.  My explorations shown that, for example, that FELINE index
> is not good fit for relatively "narrow" graphs of revision history.
> Exploring this in Python / Jupyter is easier than trying to write a
> exploratory patch for Git, in my opinion.  Just IMVHO.

You are right. Ruling out possibilities is the best outcome these 
prototypes can have. Your work has saved someone a lot of time in 
investigating that direction.

Thanks,
-Stolee

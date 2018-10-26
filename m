Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 560B71F453
	for <e@80x24.org>; Fri, 26 Oct 2018 16:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeJ0BdO (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 21:33:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36880 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbeJ0BdO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 21:33:14 -0400
Received: by mail-wr1-f65.google.com with SMTP id g9-v6so2058853wrq.4
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 09:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Y72DWcLvbX1wCD4wQ1+wJSTVe1ENJSy89+C9sITRPrg=;
        b=JLvpnZDdH65B6rxCcJPaoqFQVC+zpgg2cbhYiLGt5sO6PnIgdW1BZldiaiCSPOFBDg
         kbm3Bo6v5XJzvkPrCXNIodXpho4ns/QoKnT0YAY0Zkf9K24IyCWZ7TmwWGynR2WQFG3D
         0dgcJTKGUz9aHlzSiWjeBY8+jJ1BWPUmUtfOnaa7YLQMhk436XNULudYrpFPqeTvAxT0
         BXWGNL/z3f/0tSMIbhbvBDKZber16HHuU6mZlmi+sAXUBWn0yJttohDcnlkjgmg6K+iB
         MrB4TqqamOFH6vDyxAgOdEj9/U08jKDs33jR4VthPG160ufS9mcSMvbzEI3vSZMhikYF
         yoHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=Y72DWcLvbX1wCD4wQ1+wJSTVe1ENJSy89+C9sITRPrg=;
        b=hz5L1R07LGelfcrSeRIhYiHcoU8KmLEPZ/McntQOjyqGg1MNT6/2jppFnt/0tbP2/Y
         m6yetSo2trB1YAFSTaD3wPjPY7lXCxVyDs+Qo9+FPGZIrHr9VbRQ1X2vGBydkwDwEzhL
         OdYCoqfhS8I1H4UARlTT1TcDUJ+v6ctED0QjPCk5wDl5DwvfYsVj82K0ZSRGl4duwSsW
         XbTqq31cMekZVoNyTCiBtPngM+AU72x/bnK54dJzjpRb5BwSJGK1ju97TM+D7LIcotTm
         py1pCVRboDLbzl/sWSl9Dx1Qa7TdLmJV+22QUoYilqVAgFZRLaENhoOhCiQdK0z+we0H
         pasQ==
X-Gm-Message-State: AGRZ1gJomtKE6/fL9WjAjTQ2dIkgOvAILMLsxWf2NHdJV4J52k7hQpwT
        oZUqKec+Fd1CWyWl4ComDdo=
X-Google-Smtp-Source: AJdET5dmEMhROWvY5NJBHqzHRW+r1bRofEd69XzZARUH/1HOaqjxSwd/sq+gmzlX+tPhLRAGZmiuMA==
X-Received: by 2002:a5d:5045:: with SMTP id h5-v6mr6589602wrt.210.1540572926575;
        Fri, 26 Oct 2018 09:55:26 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egq108.neoplus.adsl.tpnet.pl. [83.21.80.108])
        by smtp.gmail.com with ESMTPSA id 125-v6sm6122093wmm.25.2018.10.26.09.55.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 09:55:25 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 6/7] revision.c: generation-based topo-order algorithm
References: <pull.25.v3.git.gitgitgadget@gmail.com>
        <pull.25.v4.git.gitgitgadget@gmail.com>
        <aa0bb2221d437f595f6d0c16b125072fde289c15.1539729393.git.gitgitgadget@gmail.com>
        <86sh0y5cgk.fsf@gmail.com>
        <6501930f-4097-1b81-6d0d-be54f050a5a4@gmail.com>
Date:   Fri, 26 Oct 2018 18:55:22 +0200
In-Reply-To: <6501930f-4097-1b81-6d0d-be54f050a5a4@gmail.com> (Derrick
        Stolee's message of "Tue, 23 Oct 2018 09:54:30 -0400")
Message-ID: <86bm7g641x.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:
> On 10/22/2018 9:37 AM, Jakub Narebski wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
[...]
>> Sidenote: the new algorithm looks a bit like Unix pipeline, where each
>> step of pipeline does not output much more than next step needs /
>> requests.
>
> That's essentially the idea.

Some of the newer languages have built-in support for similar kind of
pipeline for connecting processes, be it channels in Go, supplies and
suppliers in Perl6.  I wonder if there exists some library implementing
this kind of construct in C.

That aside, I wonder if when there would be support for more
reachability indices than generation numbers, if it wouldn't be better
to pass a commit as a limiter (up to this commit), than specific indices
like current passing of generation number.  Just food for thoughs...

[...]
>>> In my local testing, I used the following Git commands on the
>>> Linux repository in three modes: HEAD~1 with no commit-graph,
>>> HEAD~1 with a commit-graph, and HEAD with a commit-graph. This
>>> allows comparing the benefits we get from parsing commits from
>>> the commit-graph and then again the benefits we get by
>>> restricting the set of commits we walk.
>>>
>>> Test: git rev-list --topo-order -100 HEAD
>>> HEAD~1, no commit-graph: 6.80 s
>>> HEAD~1, w/ commit-graph: 0.77 s
>>>    HEAD, w/ commit-graph: 0.02 s
>>>
>>> Test: git rev-list --topo-order -100 HEAD -- tools
>>> HEAD~1, no commit-graph: 9.63 s
>>> HEAD~1, w/ commit-graph: 6.06 s
>>>    HEAD, w/ commit-graph: 0.06 s
>>>
>>> This speedup is due to a few things. First, the new generation-
>>> number-enabled algorithm walks commits on order of the number of
>>> results output (subject to some branching structure expectations).
>>> Since we limit to 100 results, we are running a query similar to
>>> filling a single page of results. Second, when specifying a path,
>>> we must parse the root tree object for each commit we walk. The
>>> previous benefits from the commit-graph are entirely from reading
>>> the commit-graph instead of parsing commits. Since we need to
>>> parse trees for the same number of commits as before, we slow
>>> down significantly from the non-path-based query.
>>>
>>> For the test above, I specifically selected a path that is changed
>>> frequently, including by merge commits. A less-frequently-changed
>>> path (such as 'README') has similar end-to-end time since we need
>>> to walk the same number of commits (before determining we do not
>>> have 100 hits). However, get the benefit that the output is
>>> presented to the user as it is discovered, much the same as a
>>> normal 'git log' command (no '--topo-order'). This is an improved
>>> user experience, even if the command has the same runtime.
>>>
>> First, do I understand it correctly that in first case the gains from
>> new algorithms are so slim because with commit-graph file and no path
>> limiting we don't hit repository anyway; we walk less commits, but
>> reading commit data from commit-graph file is fast/
>
> If you mean 0.77s to 0.02s is "slim" then yes, it is because the
> commit-graph command already made a full walk of the commit history
> faster. (I'm only poking at this because the _relative_ improvement is
> significant, even if the command was already sub-second.)

First, you didn't provide us with percentages, i.e. relative improvement
(and I am lazy).  Second, 0.02s can be within the margin of error,
depending on how it is measured, and how stable this measurement is.

>> Second, I wonder if there is some easy way to perform automatic latency
>> tests, i.e. how fast does Git show the first page of output...
>
> I have talked with Jeff Hostetler about this, to see if we can have a
> "time to first page" traced with trace2, but we don't seem to have
> access to that information within Git. We would need to insert it into
> the pager. The "-100" is used instead.

Perhaps another solution to the problem of "first page of output"
latency tests could be feasible, namely create a helper test-pager-1p
"pager" program that would automatically quit after first page of
output; or perhaps even one that benchmarks each page of output
automatically.

There exists 'pv' (pipe viewer) program for pipes, so I think it would
be possible to do equivalent, but as a pager.

[...]
>>> +static inline void test_flag_and_insert(struct prio_queue *q, struct c=
ommit *c, int flag)
>>> +{
>>> +	if (c->object.flags & flag)
>>> +		return;
>>> +
>>> +	c->object.flags |=3D flag;
>>> +	prio_queue_put(q, c);
>>> +}
>>
>> This is an independent change, though I see that it is quite specific
>> (as opposed to quite generic prio_queue_peek() operation added earlier
>> in this series), so it does not make much sense as standalone change.
>>
>> It inserts commit into priority queue only if it didn't have flags set,
>> and sets the flag (so we won't add it to the queue again, not without
>> unsetting the flag), am I correct?
>
> Yes, this pattern of using a flag to avoid duplicate entries in the
> priority queue appears in multiple walks. It wasn't needed before. We
> call it four times in the code below.

>> I guess that we use test_flag_and_insert() instead of prio_queue_put()
>> to avoid duplicate entries in the queue.  I think the queue is initially
>> populated with the starting commits, but those need not to be
>> unreachable from each other, and walking down parents we can encounter
>> starting commit already in the queue.  Am I correct?
>
> We can also reach commits in multiple ways, so the initial conditions
> are not the only ways to insert duplicates.

Right.

[...]
>>> +	if (c->object.flags & UNINTERESTING)
>>> +		mark_parents_uninteresting(c);
>>> +
>>> +	for (p =3D c->parents; p; p =3D p->next)
>>> +		test_flag_and_insert(&info->explore_queue, p->item, TOPO_WALK_EXPLOR=
ED);
>>
>> Do we need to insert parents to the queue even if they were marked
>> UNINTERESTING?
>
> We need to propagate the UNINTERESTING flag to our parents. That
> propagation happens in process_parents().

I think I understand.  We need to propagate UNINTERESTING flag down the
chain, isn't it?

[...]
>>>     static void init_topo_walk(struct rev_info *revs)
>>>   {
>>>   	struct topo_walk_info *info;
>>> +	struct commit_list *list;
>>>   	revs->topo_walk_info =3D xmalloc(sizeof(struct topo_walk_info));
>>>   	info =3D revs->topo_walk_info;
>>>   	memset(info, 0, sizeof(struct topo_walk_info));
>>>   -	limit_list(revs);
>>> -	sort_in_topological_order(&revs->commits, revs->sort_order);
>>> +	init_indegree_slab(&info->indegree);
>>> +	memset(&info->explore_queue, '\0', sizeof(info->explore_queue));
>>> +	memset(&info->indegree_queue, '\0', sizeof(info->indegree_queue));
>>> +	memset(&info->topo_queue, '\0', sizeof(info->topo_queue));
>>
>> Why this memset uses '\0' as a filler value and not 0?  The queues are
>> not strings [and you use 0 in other places].

I think you missed answering about this issue.

[...]
>> Looks all right.
>
> Thanks for taking the time on this huge patch!

You are welcome.

--=20
Jakub Nar=C4=99bski

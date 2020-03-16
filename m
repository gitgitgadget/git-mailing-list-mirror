Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3ECC0044D
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 12:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D04205ED
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 12:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ie3tbaS/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731020AbgCPMo6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Mar 2020 08:44:58 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46476 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731011AbgCPMo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Mar 2020 08:44:58 -0400
Received: by mail-ot1-f67.google.com with SMTP id 111so17589127oth.13
        for <git@vger.kernel.org>; Mon, 16 Mar 2020 05:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oAyA7OSBh7i9UgXoT8GAbKLUeMySDmOPli90A8AOuG0=;
        b=Ie3tbaS/0PxvfjKHH0TyF5s3Uk8mQ7X+dXPP38OYttgZv/NZbwrzJiZf4v9RqaM4VZ
         Fw7xLgGDymj2dP0WBwNAfd6G9/4ucNPXtVpFrHVXtEUmBCXoVACZ9Ww7UwqsHd3edro+
         aGEps8Y8qOjoAr1Oog/1HP5wt5bbuBZ7C5zh6o6bCs4DTSzAxjrwJCYMFSwy+1T1Lxyc
         gEx05w9q3zQ0KA2yPKRykHQ8B/ERXbWi02akO9dvog+hMNUUY5bULhoJDH/7TQxCL0kv
         Y00n7WC3IDDNS00qvFUlc2Q0VfKVPNxF6578kW8ibpHjrN7f0oJVu4fATenbHbrwroRu
         kGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oAyA7OSBh7i9UgXoT8GAbKLUeMySDmOPli90A8AOuG0=;
        b=TxWTHNGWKVkjZMpntfB1qnfwZVV6UiSgEW5WroJFx0+fTRYi/pAxHN6lkYw11dduo0
         M3HOaeY5w+EUJ+HfKw/poIx3BQWeNYwtYoX98VXEtv6je/KugbgwR1Tuwwnk1dp81/O+
         hE7MQowp2n1k/VwnGr/J28j/P+9b+ZtcrZpxUC3qmzA9XD4GItsjOvNWWp3LeCxlY9ax
         OCpnKTeqcJPOPr2VBXVnQz+/ZQW41bHJQPiCJJkYjURrkF93x5U6HyjvxPr+7g6cupER
         k87MWwiTaWKId/tyHuzFZbar3eK/5ixJkTc1HlCsUiBWoei2DF/IlkoLhEwGD0XfFlb9
         UGmA==
X-Gm-Message-State: ANhLgQ3WWAaGyDEtP/zY2/zSb6lbGshILpyDYN/cDfCuzbAV498vsqBS
        i1ETCvY/WmhHh781wrg3HPo=
X-Google-Smtp-Source: ADFU+vuPN2oGwwXYj7b8h95Uw8N+LebXwn6rDc7jcTQ/YbwV/ndFZPdPbGhHZ1PQy7CvnEE24QF/Jg==
X-Received: by 2002:a9d:554a:: with SMTP id h10mr21232446oti.344.1584362696734;
        Mon, 16 Mar 2020 05:44:56 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id s83sm10886950oif.33.2020.03.16.05.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2020 05:44:56 -0700 (PDT)
Subject: Re: [RFC] Possible idea for GSoC 2020
To:     Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>
References: <86mu8o8dsf.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7d6a84c7-6b16-c2a9-11a1-3397422064d1@gmail.com>
Date:   Mon, 16 Mar 2020 08:44:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:74.0) Gecko/20100101
 Thunderbird/74.0
MIME-Version: 1.0
In-Reply-To: <86mu8o8dsf.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/10/2020 10:50 AM, Jakub Narebski wrote:
> Hello,
> 
> Here below is a possible proposal for a more difficult Google Summer of
> Code 2020 project.
> 
> A few questions:
> - is it too late to propose a new project idea for GSoC 2020?
> - is it too difficult of a project for GSoC?
> 
> Best,
> 
>   Jakub Narębski
> 
> --------------------------------------------------
> 
> ### Graph labelling for speeding up git commands
> 
>  - Language: C
>  - Difficulty: hard / difficult
>  - Possible mentors: Jakub Narębski
> 
> Git uses various clever methods for making operations on very large
> repositories faster, from bitmap indices for git-fetch[1], to generation
> numbers (also known as topological levels) in the commit-graph file for
> commit graph traversal operations like `git log --graph`[2].
> 
> One possible improvement that can make Git even faster is using min-post
> intervals labelling.  The basis of this labelling is post-visit order of
> a depth-first search traversal tree of a commit graph, let's call it
> 'post(v)'.
> 
> If for each commit 'v' we would compute and store in the commit-graph
> file two numbers: 'post(v)' and the minimum of 'post(u)' for all commits
> reachable from 'v', let's call the latter 'min_graph(v)', then the
> following condition is true:
> 
>   if 'v' can reach 'u', then min_graph(v) <= post(u) <= post(v)

I haven't thought too hard about it, but I'm assuming that if v is not
in a commit-graph file, then post(v) would be "infinite" and min_graph(v)
would be zero.

We already have the second inequality (f(u) <= f(v)) where the function
'f' is the generation of v. The success of this approach over generation
numbers relies entirely on how often the inequality min_graph(v) <= post(u)
fails when gen(u) <= gen(v) holds.

> If for each commit 'v' we would compute and store in the commit-graph
> file two numbers: 'post(v)' and the minimum of 'post(u)' for commits
> that were visited during the part of depth-first search that started
> from 'v' (which is the minimum of post-order number for subtree of a
> spanning tree that starts at 'v').  Let's call the later 'min_tree(v)'.
> Then the following condition is true:
> 
>   if min_tree(v) <= post(u) <= post(v), then 'v' can reach 'u'

How many places in Git do we ask "can v reach u?" and how many would
return immediately without needing a walk in this new approach? My
guess is that we will have a very narrow window where this query
returns a positive result.

I believe we discussed this concept briefly when planning "generation
number v2" and the main concern I have with this plan is that the
values are not stable. The value of post(v) and min_tree(v) depend
on the entire graph as a whole, not just what is reachable from v
(and preferably only the parents of v).

Before starting to implement this, I would consider how such labels
could be computed across incremental commit-graph boundaries. That is,
if I'm only adding a layer of commits to the commit-graph without
modifying the existing layers of the commit-graph chain, can I still
compute values with these properties? How expensive is it? Do I need
to walk the entire reachable set of commits?
 
> The task would be to implement computing such labelling (or a more
> involved variant of it[3][4]), storing it in commit-graph file, and
> using it for speeding up git commands (starting from a single chosen
> command) such as:
> 
>  - git merge-base --is-ancestor A B
>  - git branch --contains A
>  - git tag --contains A
>  - git branch --merged A
>  - git tag --merged A
>  - git merge-base --all A B
>  - git log --topo-sort

Having such a complicated two-dimensional system would need to
justify itself by being measurably faster than that one-dimensional
system in these example commands.

The point of generation number v2 [1] was to allow moving to "exact"
algorithms for things like merge-base where we still use commit time
as a heuristic, and could be wrong because of special data shapes.
We don't use generation number in these examples because using only
generation number can lead to a large increase in number of commits
walked. The example we saw in the Linux kernel repository was a bug
fix created on top of a very old commit, so there was a commit of
low generation with very high commit-date that caused extra walking.
(See [2] for a detailed description of the data shape.)

My _prediction_ is that the two-dimensional system will be more
complicated to write and use, and will not have any measurable
difference. I'd be happy to be wrong, but I also would not send
anyone down this direction only to find out I'm right and that
effort was wasted.

My recommendation is that a GSoC student update the
generation number to "v2" based on the definition you made in [1].
That proposal is also more likely to be effective in Git because
it makes use of extra heuristic information (commit date) to
assist the types of algorithms we care about.

In that case, the "difficult" part is moving the "generation"
member of struct commit into a slab before making it a 64-bit
value. (This is likely necessary for your plan, anyway.) Updating
the generation number to v2 is relatively straight-forward after
that, as someone can follow all places that reference or compute
generation numbers and apply a diff

Thanks,
-Stolee

[1] https://lore.kernel.org/git/86o8ziatb2.fsf_-_@gmail.com/
    [RFC/PATCH] commit-graph: generation v5 (backward compatible date ceiling)

[2] https://lore.kernel.org/git/efa3720fb40638e5d61c6130b55e3348d8e4339e.1535633886.git.gitgitgadget@gmail.com/
    [PATCH 1/1] commit: don't use generation numbers if not needed

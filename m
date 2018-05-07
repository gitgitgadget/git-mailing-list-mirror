Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90753200B9
	for <e@80x24.org>; Mon,  7 May 2018 14:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752216AbeEGO0Q (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 10:26:16 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:46495 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752676AbeEGO0L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 10:26:11 -0400
Received: by mail-qt0-f171.google.com with SMTP id m16-v6so36437036qtg.13
        for <git@vger.kernel.org>; Mon, 07 May 2018 07:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=ZZb/l+F2KVWoduM953TOI7PKmzjmMB+XR/hBqEvaWmM=;
        b=AFAZnmIKLbv/rmYJ1SL/74AWI+Y9CyDeHcqCggrASmZYBw7Cs6sULtbUeHd1prYGxK
         Ac6FHvCC89qTHTHFUoiQfRmJyt1eTsl0WztcV5zkgG0FE/Of5UPWVySf0KWyCVjmRDmx
         GP0hcUs3Z15vEasklCA2W+p7cIcpBVuumjDWPSK+P+b+VL6EguxR0RstGMUrqEhG3nHU
         0kqFrk/4CoM1zb04K0HSjwHvYPNRNldRKbmdvXcqTzxP8WZDlnOpvY1g2jxfcczbDUh8
         XEXyvZ7yNkdLda8GW7JILbrhRjYV5lvoGAIuMGH4kLI6SK0AjP4xl+f7GDHER5Zt1oAX
         Hcxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ZZb/l+F2KVWoduM953TOI7PKmzjmMB+XR/hBqEvaWmM=;
        b=GsVIwXZWpQ7kYcg0dJjZ1f3KuFBIj2jldBpHpFIqzD4NbGcfzTsNl6dMnmeHD/XJaG
         oe3mihb3G5Kp01I58LHIponD7I8fDkkmg/TqQYcbQ+L9EKSH4lFmt+uQ/vY2+zbtE/3S
         WM+8VbJuphVXv7TPSVZFWyuObKWRSYOlu18YLY2Y+1CGTLSxaoOylx8GfnZgpoPito0a
         Mt8R0+SbwMfjkT7jMFEqH8alFBPl5ZuaAN6YjcUrZ8QzQY4WIp/LFfm/nkBwi2yew07B
         uo3QApvQ2aTiM+u6Pjmh4WRQD4Py6RW9UHgBuCh0jOWfimAxdDgS4ioss/nrOt3APLlv
         wASQ==
X-Gm-Message-State: ALQs6tCC/rLVSbZc4KDaxZzJoeEK6Np+t9Jss3AzqDwh4xi33G2mjg//
        8CTMT70lH0v5w7tBpeJecpE=
X-Google-Smtp-Source: AB8JxZosiLjGcKCX7ikVuFm+xdyh4Pcmy97QrWLXi76vwTXJcf753MHTJcoJqbzF6W9sq4TgIGzpcg==
X-Received: by 2002:ac8:1766:: with SMTP id u35-v6mr33555290qtk.209.1525703170664;
        Mon, 07 May 2018 07:26:10 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id y41-v6sm20043900qty.84.2018.05.07.07.26.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 May 2018 07:26:10 -0700 (PDT)
Subject: Re: [RFC] Other chunks for commit-graph, part 1 - Bloom filters, topo
 order, etc.
To:     Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <86zi1fus3t.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <07250f7b-e880-26f5-d412-4fbe69affd41@gmail.com>
Date:   Mon, 7 May 2018 10:26:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <86zi1fus3t.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/4/2018 3:40 PM, Jakub Narebski wrote:
> Hello,
>
> With early parts of commit-graph feature (ds/commit-graph and
> ds/lazy-load-trees) close to being merged into "master", see
> https://public-inbox.org/git/xmqq4ljtz87g.fsf@gitster-ct.c.googlers.com/
> I think it would be good idea to think what other data could be added
> there to make Git even faster.

Before thinking about adding more data to the commit-graph, I think 
instead we need to finish taking advantage of the data that is already 
there. This means landing the generation number patch [1] (I think this 
is close, so I'll send a v6 this week if there is no new feedback.) and 
the auto-compute patch [2] (this could use more feedback, but I'll send 
a v1 based on the RFC feedback if no one chimes in).

[1] 
https://public-inbox.org/git/20180501124652.155781-1-dstolee@microsoft.com/
     [PATCH v5 00/11] Compute and consume generation numbers

[2] 
https://public-inbox.org/git/20180417181028.198397-1-dstolee@microsoft.com/
     [RFC PATCH 00/12] Integrate commit-graph into 'fsck' and 'gc'

The big wins remaining from this data are `git tag --merged` and `git 
log --graph`. The `tag` scenario is probably easier: this can be done by 
replacing the revision-walk underlying the call to use 
paint_down_to_common() instead. Requires adding an external method to 
commit.c, but not too much code.

The tougher challenge is `git log --graph`. The revision walk machinery 
currently uses two precompute phases before iterating results to the 
pager: limit_list() and sort_in_topological_order(); these correspond to 
two phases of Kahn's algorithm for topo-sort (compute in-degrees, then 
walk by peeling commits with in-degree zero). This requires O(N) time, 
where N is the number of reachable commits. Instead, we could make this 
be O(W) time to output one page of results, where W is (roughly) the 
number of reachable commits with generation number above the last 
reported result.

In order to take advantage of this approach, the two phases of Kahn's 
algorithm need to be done in-line with reporting results to the pager. 
This means keeping two queues: one is a priority queue by generation 
number that computes in-degrees, the other is a priority queue (by 
commit-date or a visit-order value to do the --topo-order priority) that 
peels the in-degree-zero commits (and decrements the in-degree of their 
parents). I have not begun this refactoring effort because appears 
complicated to me, and it will be hard to tease out the logic without 
affecting other consumers of the revision-walk machinery.

I would love it if someone picked up the `git log --graph` task, since 
it will be a few weeks before I have the time to focus on it.

Without completing the benefits we get from generation numbers, these 
investigations into other reachability indexes will be incomplete as 
they are comparing benefits without all consumers taking advantage of a 
reachability index.

[...]
> Bloom filter for changed paths
> ------------------------------
>
> The goal of this chunk is to speed up checking if the file or directory
> was changed in given commit, for queries such as "git log -- <file>" or
> "git blame <file>".  This is something that according to "Git Merge
> contributor summit notes" [2] is already present in VSTS (Visual Studio
> Team Services - the server counterpart of GVFS: Git Virtual File System)
> at Microsoft:
>
> AV> - VSTS adds bloom filters to know which paths have changed on the commit
> AV> - tree-same check in the bloom filter is fast; speeds up file history checks
> AV> - might be useful in the client as well, since limited-traversal is common
> AV> - if the file history is _very_ sparse, then bloom filter is useful
> AV> - but needs pre-compute, so useful to do once
> AV> - first make the client do it, then think about how to serve it centrally
>
> [2]: https://public-inbox.org/git/alpine.DEB.2.20.1803091557510.23109@alexmv-linux/
>
> I think it was what Derrick Stolee was talking about at the end of his
> part of "Making Git for Windows" presentation at Git Merge 2018:
> https://youtu.be/oOMzi983Qmw?t=1835
>
> This was also mentioned in subthread of "Re: [PATCH v2 0/4] Lazy-load
> trees when reading commit-graph", starting from [3]
> [3]: https://public-inbox.org/git/86y3hyeu6c.fsf@gmail.com/

Again, the benefits of Bloom filters should only be measured after 
already taking advantage of a reachability index during `git log`. 
However, you could get performance benefits from Bloom filters in a 
normal `git log` (no topo-order).

The tricky part about this feature is that the decisions we made in our 
C# implementation for the VSTS Git server may be very different than the 
needs for the C implementation of the Git client. Questions like "how do 
we handle merge commits?" may have different answers, which can only be 
discovered by implementing the feature.

(The answer for VSTS is that we only store Bloom filters containing the 
list of changed paths against the first parent. The second parent 
frequently has too many different paths, and if we are computing 
file-history simplification we have already determined the first parent 
is _not_ TREESAME, which requires verifying the difference by parsing 
trees against the first parent.)

I'm happy to provide more information on how we built this feature if 
someone is writing a patch. Otherwise, I plan to implement it after 
finishing the parts I think are higher priority.

Thanks,
-Stolee

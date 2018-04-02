Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 154DA1F404
	for <e@80x24.org>; Mon,  2 Apr 2018 13:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750816AbeDBNCQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 09:02:16 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:38315 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750710AbeDBNCO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 09:02:14 -0400
Received: by mail-qk0-f194.google.com with SMTP id 132so14915855qkd.5
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 06:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=NKMY2X6rN05YHOspJrT6+V4oSuIR5bO9YXIzpdAW6Ac=;
        b=fXZDJtZm/lUOAHB0udtmyRIStTsCn/RP+tYuNbehO5LugUJPNWzhJAOUzrIP2YEU5j
         CfnR74oOHQRSidOT+m3fmUjllEQ3BOmG+yOhawMd4ZW1wCWtpAvaD/y+9fXJIdm/n5LL
         H4VcpuH184j61eXz2ILdCnLAW1sMYhoUSonqw0NZghEPZpX/mF7RvVMLFgWwc7c4J4WX
         p1YeJ4oUrQMhwEKOxfg1zw+t/cN9i+f0sdpzo8XleYs7OeVT/rKbFWUeaC8QZXuNe6+n
         UAUmSb1NnLKHYcdLtFg+bduVoKKQUx/NtmND/PVWgRli4pjoaJo1VuWkK1tmP/gwFPwG
         ENOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=NKMY2X6rN05YHOspJrT6+V4oSuIR5bO9YXIzpdAW6Ac=;
        b=TKqodLhecISakG7qBqAgrTCn/ks2VmoVzwfn285BxD6EqAgL7nzd8xMzAhFl3NM0Y9
         QTqIUHxEJhxdCtIOARP3ghIc9x60xT85siGbXC9qUUA2xxeH9L+o6/dSeOVyjpN83DJ/
         WZ/qv0uP+Kk8brKG1UAfnZmOC4PmbL4BEg5txfz4LicTAQCax9str8Boq5utYiAWvtMR
         upaQVjqIgWRFAE0D9biuTbvUDDByase08Ll5lkXpGuao9jTFbV2YCefn35u7aOMABzm+
         beFObD6705aHnLOzSWlhknlRQAvldeXirK8GY44VX5aRTbaYD/pl8cF5wVK4VgMiGpm1
         3BTw==
X-Gm-Message-State: ALQs6tAO10yWlSiAA4EBS5qgbOk50X68g/gRG+hrsahykC0z0opk6RSI
        zYlXtQp0nXCHnRb/zPIagC4=
X-Google-Smtp-Source: AIpwx4+1uQGtR0TSeC6CbnD7zNmMlScZMOMN8WGdWBAzU4ZTbHVZt4H1yDe92msZsHX50fv11QdFeQ==
X-Received: by 10.55.19.102 with SMTP id d99mr12250592qkh.355.1522674133783;
        Mon, 02 Apr 2018 06:02:13 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id o22sm275019qtf.59.2018.04.02.06.02.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Apr 2018 06:02:12 -0700 (PDT)
Subject: Re: [PATCH v4 00/13] Serialized Git Commit Graph
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, peff@peff.net,
        jonathantanmy@google.com, szeder.dev@gmail.com, sbeller@google.com,
        gitster@pobox.com, Derrick Stolee <dstolee@microsoft.com>
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
 <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
 <867eptkeeq.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f5d8934e-afc2-39d4-b7d5-e5ba5e5021a1@gmail.com>
Date:   Mon, 2 Apr 2018 09:02:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <867eptkeeq.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/30/2018 7:10 AM, Jakub Narebski wrote:
> I hope that I am addressing the most recent version of this series.

Hi Jakub. Thanks for the interest in this patch series.

The most-recent version is v6 [1], but I will re-roll to v7 soon (after 
v2.17.0 is marked).

[1] 
https://public-inbox.org/git/20180314192736.70602-1-dstolee@microsoft.com/T/#u

> Derrick Stolee <stolee@gmail.com> writes:
>
>> As promised [1], this patch contains a way to serialize the commit graph.
>> The current implementation defines a new file format to store the graph
>> structure (parent relationships) and basic commit metadata (commit date,
>> root tree OID) in order to prevent parsing raw commits while performing
>> basic graph walks. For example, we do not need to parse the full commit
>> when performing these walks:
>>
>> * 'git log --topo-order -1000' walks all reachable commits to avoid
>>    incorrect topological orders, but only needs the commit message for
>>    the top 1000 commits.
>>
>> * 'git merge-base <A> <B>' may walk many commits to find the correct
>>    boundary between the commits reachable from A and those reachable
>>    from B. No commit messages are needed.
>>
>> * 'git branch -vv' checks ahead/behind status for all local branches
>>    compared to their upstream remote branches. This is essentially as
>>    hard as computing merge bases for each.
>>
>> The current patch speeds up these calculations by injecting a check in
>> parse_commit_gently() to check if there is a graph file and using that
>> to provide the required metadata to the struct commit.
> That's nice.
>
> What are the assumptions about the serialized commit graph format? Does
> it need to be:
>   - extensible without rewriting (e.g. append-only)?
>   - like the above, but may need rewriting for optimal performance?
>   - extending it needs to rewrite whole file?
>
> Excuse me if it waas already asked and answered.

It is not extensible without rewriting. Reducing write time was not a 
main goal, since the graph will be written only occasionally during data 
management phases (like 'gc' or 'repack'; this integration is not 
implemented yet).

>
>> The file format has room to store generation numbers, which will be
>> provided as a patch after this framework is merged. Generation numbers
>> are referenced by the design document but not implemented in order to
>> make the current patch focus on the graph construction process. Once
>> that is stable, it will be easier to add generation numbers and make
>> graph walks aware of generation numbers one-by-one.
> As the serialized commit graph format is versioned, I wonder if it would
> be possible to speed up graph walks even more by adding to it FELINE
> index (pair of numbers) from "Reachability Queries in Very Large Graphs:
> A Fast Refined Olnine Search Approach" (2014) - available at
> http://openproceedings.org/EDBT/2014/paper_166.pdf
>
> The implementation would probably need adjustments to make it
> unambiguous and unambiguously extensible; unless there is place for
> indices that are local-only and need to be recalculated from scratch
> when graph changes (to cover all graph).

The chunk-based format is intended to allow extra indexes like the one 
you recommend, without needing to increase the version number. Using an 
optional chunk allows older versions of Git to read the file without 
error, since the data is "extra", and newer versions can take advantage 
of the acceleration.

At one point, I was investigating these reachability indexes (I read 
"SCARAB: Scaling Reachability Computation on Large Graphs" by Jihn, 
Ruan, Dey, and Xu [2]) but find the question that these indexes target 
to be lacking for most of the Git uses. That is, they ask the boolean 
question "Can X reach Y?". More often, Git needs to answer "What is the 
set of commits reachable from X but not from Y" or "Topologically sort 
commits reachable from X" or "How many commits are in each part of the 
symmetric difference between reachable from X or reachable from Y?"

The case for "Can X reach Y?" is mostly for commands like 'git branch 
--contains', when 'git fetch' checks for forced-updates of branches, or 
when the server decides enough negotiation has occurred during a 'git 
fetch'. While these may be worth investigating, they also benefit 
greatly from the accelerated graph walk introduced in the current format.

I would be happy to review any effort to extend the commit-graph format 
to include such indexes, as long as the performance benefits outweigh 
the complexity to create them.

[2] 
http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.719.8396&rep=rep1&type=pdf

>
>> Here are some performance results for a copy of the Linux repository
>> where 'master' has 704,766 reachable commits and is behind 'origin/master'
>> by 19,610 commits.
>>
>> | Command                          | Before | After  | Rel % |
>> |----------------------------------|--------|--------|-------|
>> | log --oneline --topo-order -1000 |  5.9s  |  0.7s  | -88%  |
>> | branch -vv                       |  0.42s |  0.27s | -35%  |
>> | rev-list --all                   |  6.4s  |  1.0s  | -84%  |
>> | rev-list --all --objects         | 32.6s  | 27.6s  | -15%  |
> That's the "Rel %" of "Before", that is delta/before, isn't it?

I do mean the relative change.

>
>> To test this yourself, run the following on your repo:
>>
>>    git config core.commitGraph true
>>    git show-ref -s | git commit-graph write --set-latest --stdin-commits
>>
>> The second command writes a commit graph file containing every commit
>> reachable from your refs. Now, all git commands that walk commits will
>> check your graph first before consulting the ODB. You can run your own
>> performance comparisions by toggling the 'core.commitgraph' setting.
> Good.  It is nicely similar to how bitmap indices (of reachability) are
> handled.
>
> I just wonder what happens in the (rare) presence of grafts (old
> mechanism), or "git replace"-d commits...

In the design document, I mention that the current implementation does 
not work with grafts (it will ignore them). A later patch will refactor 
the graft code so we can access it from the commit-graph parsing of a 
commit without copy-pasting the code out of parse_commit_gently().

The commit-graph is only a compact representation of the object 
database. If a commit is replaced with 'git replace' before 'git 
commit-graph write' then the commit-graph write will write the replaced 
object. I haven't tested what happens when a commit-graph is written and 
then a commit is replaced, but my guess is that the replacement does not 
occur until a full parse is attempted (i.e. when reading author or 
commit message information). This will lead to unknown results.

Thanks for pointing out the interaction with 'git replace'. I have items 
to fix grafts and replaced commits before integrating commit-graph 
writes into automatic actions like 'gc.auto'.

Thanks,
-Stolee

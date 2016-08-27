Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20FE01F6C1
	for <e@80x24.org>; Sat, 27 Aug 2016 13:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751152AbcH0NSB (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Aug 2016 09:18:01 -0400
Received: from atl4mhob09.myregisteredsite.com ([209.17.115.47]:42020 "EHLO
        atl4mhob09.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750746AbcH0NSA (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 27 Aug 2016 09:18:00 -0400
Received: from mailpod.hostingplatform.com ([10.30.77.36])
        by atl4mhob09.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id u7RDHna2003050
        for <git@vger.kernel.org>; Sat, 27 Aug 2016 09:17:49 -0400
Received: (qmail 22084 invoked by uid 0); 27 Aug 2016 13:17:49 -0000
X-TCPREMOTEIP: 73.89.103.237
X-Authenticated-UID: porter@devrts.com
Received: from unknown (HELO ?192.168.1.14?) (porter@devrts.com@73.89.103.237)
  by 0 with ESMTPA; 27 Aug 2016 13:17:49 -0000
Subject: Re: stable as subset of develop
To:     =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        git@vger.kernel.org
References: <57C0FB1D.9070206@devrts.com>
 <1b3990a1-f9a0-f48e-239f-095b17108d0a@gmail.com>
From:   Brett Porter <porter@devrts.com>
Message-ID: <57C192FC.3060107@devrts.com>
Date:   Sat, 27 Aug 2016 09:17:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <1b3990a1-f9a0-f48e-239f-095b17108d0a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you Jakub for your feedback.

On 08/27/2016 03:55 AM, Jakub Narębski wrote:
> W dniu 27.08.2016 o 04:29, Brett Porter pisze:
>>
>> In a small group, develop is the branch where all fixes/additions/... from topic
>> branches are merged rather dynamically. Thorough testing of commits
>> may lag behind, but when we think one is a pretty good commit we want
>> to identify it as (at least relatively) the latest stable. We could
>> tag it, but we would like these stable commits to be a branch in the
>> sense that each commit points back to a previous commit.
>>
>> Merging from a development branch commit to stable isn't quite what
>> we want. It seems more like:
>>
>>    checkout the new good development commit
>>    change HEAD to the head of the stable branch
>>    git add --all
>>    git commit
>>    (maybe tag the new commit with the hash of the chosen development commit)

Oops - used tag in a generic sense when discussing git -- not helpful.
Really - would put the hash of the development commit into the log message for
  the stable commit.

>
> If you are really using topic branches, a better workflow would be
> to make use of them.  That is, do the development of new features
> on topic branches, test them in relative isolation, and when deemed
> ready merge them into development branch, for more testing (including
> integration testing).
>
> Then, those topic branches that are considered stable are merged
> into stable branch ("trunk").  You can think of it as picking
> features to have in stable.

Ok. There are 2 things at play.... The repository contains code for an embedded
system with several subsystems (separate executables on separate processors). We
will be trying to keep testing schemes up to date with respect to the progress
on the code -- but (beyond unit/module tests), the scene will change over time;
and, users may not be able to run much form their local copies. Second, only 2
of us have used git before (and, while trying to get up to speed - I am a ways
from git guru-dom yet), while everyone else has been using visual sourcesafe for
many years.

I want others to merge their work into development sooner rather than later to
minimize their and my problem of untangling conflicts (or - you rebased while
you were sharing work with Jill and...). And, testing on their work may be limited
before they push to our main repository and some integration can be done.

I really want to create a linked list of the development branch commits that are
of interest (their working sets - not the commit objects themselves), and using the
commit object's pointer to its predecessor seems like it could just do the job.
(it wouldn't be the place to go to for history / useful log entries)

>
> Take a look at Junio's blog posts about this topic.

Thanks for that. I will.

>
>> Will that work (one thing beyond my current understanding is if there
>> are index complications)? Other ideas?
>
> That looks a bit like reimplementation of cherry-picking.

Maybe I've misunderstood cherry-picking, but I've thought it different from the
list view that I've been thinking could help us (with merges and multiple
commits).

>
> Also, I think you would loose the ability to run git-bisect to find
> bad commits.

Hmmm - I'm imagining a rather sparse stable, with perhaps time-consuming
integration testing.

>
>> This could help with applying successively more intense testing over
>> time and chase down where problems arose.
>
> Reiterationg: if you are using topic branches, use topic-branch workflow.
>

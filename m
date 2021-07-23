Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94F1C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 10:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCE2B608FE
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 10:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhGWJZI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 05:25:08 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:44530 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230008AbhGWJZA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 05:25:00 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1m6s3J-000CQt-DJ; Fri, 23 Jul 2021 11:05:09 +0100
Subject: Re: [PATCH] doc: pull: fix rebase=false documentation
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Alex Henrie <alexhenrie24@gmail.com>,
        Marc Branchaud <marcnarc@xiplink.com>,
        Elijah Newren <newren@gmail.com>,
        Stephen Haberman <stephen@exigencecorp.com>
References: <20210721221545.1878514-1-felipe.contreras@gmail.com>
 <xmqqy29z9r94.fsf@gitster.g> <xmqqtukn9p0g.fsf@gitster.g>
 <60f8c8c92a215_1d0abb20859@natae.notmuch>
 <YPpwIazVxL4GoLbC@coredump.intra.peff.net>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <9cb70776-8684-9d1e-e4c5-188c6c19fdc7@iee.email>
Date:   Fri, 23 Jul 2021 11:05:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YPpwIazVxL4GoLbC@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/07/2021 08:30, Jeff King wrote:
> On Wed, Jul 21, 2021 at 08:24:25PM -0500, Felipe Contreras wrote:
>
>> I'm not trashing the current behavior, I'm explaining what the consensus
>> is. I spent several man-days re-reading old threads, and this is the
>> consensus of what should happen:
>>
>>   1. git pull              # merge HEAD into upstream
>>   2. git pull origin topic # merge topic into HEAD
>>
>> Of the people that expressed an opinion, 100% of them stated that what
>> `git pull` does in the first case today is not desirable.
> I did not participate in the threads you linked earlier, so I am
> probably not in that 100%. But you did use my name below:
>
>> Yes, you are correct that if *everyone* followed the topic branch
>> workflow, everything would work correctly, but that's not what happens
>> in reality, in reality people do all kinds of workflows, and wrong
>> merges are pervasive.
>>
>> Everyone--including Linus, Jeff, and you--agree that there's two
>> different ways of using `git pull`: integrator versus developer.
>>
>> When a user is doing `git pull` to synchronize changes to push to the
>> same branch, that's a centralized two-way workflow, so he is acting both
>> as an integrator and as a developer, and it's in that particular case
>> that the order of the parents should be reversed. Everyone agrees on
>> that.
>>
>> When the user the opposite explicitely: `git pull origin master`
>> Linus calls it a "back-merge" [1], and in that case the order of the
>> parents should not be reversed.
> So I feel compelled to say now that I do not think that changing the
> order of parents for "git pull" is the obviously correct thing to do.
While I never `pull` because it's not right for me as a 'contributor', I
do agree that the default 'maintainer' view of `pull` will need to be
retained for long term backward compatibility.

What I have rarely seen in the discussion is explanation that is based
on workflow style, though the potential `update` command (1) may break
some of the deadlock about the direction of 'pull requests', and
possibly confusion regarding the location of the 'golden' publish repo.

(1) there are a lot of 'update' commands floating about, esp on Git for
Windows. If there is a suitably named `update` command to do the `pull
--contributor` merge-ff swap then many of the issues could fade away.

> And likewise, in the one thread I do remember participating in, I
> expressed something similar:
>
>   https://lore.kernel.org/git/20140502214817.GA10801@sigill.intra.peff.net/
>
> -Peff
--
Philip

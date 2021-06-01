Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9CFC47080
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 19:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF53561396
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 19:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbhFATk7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 15:40:59 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:11680 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233397AbhFATk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 15:40:58 -0400
Received: from host-92-14-216-189.as13285.net ([92.14.216.189] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1loAEM-000AXe-6D; Tue, 01 Jun 2021 20:39:15 +0100
Subject: Re: [PATCH v2 6/6] doc: push: explain default=simple correctly
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Mathias Kunter <mathiaskunter@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
 <20210529071115.1908310-7-felipe.contreras@gmail.com>
 <xmqqv96zwkl0.fsf@gitster.g> <60b49a3ae829b_24d28208fd@natae.notmuch>
 <xmqqfsy1udf0.fsf@gitster.g> <60b62420858c4_e409520828@natae.notmuch>
 <a385c279-5902-40af-f54d-85b950bbb497@iee.email>
 <60b661d5ee7cc_3c4208c1@natae.notmuch>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <819f7ed4-ef38-32d4-2a64-a38ac37a5736@iee.email>
Date:   Tue, 1 Jun 2021 20:39:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <60b661d5ee7cc_3c4208c1@natae.notmuch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/06/2021 17:35, Felipe Contreras wrote:
> Philip Oakley wrote:
>> On 01/06/2021 13:12, Felipe Contreras wrote:
>>> So it's more like:
>>>
>>>   centralized = ~decentralized
>>>   triangular = ~two-way
>>>
>>> A centralized workflow consists of a single repository where branches
>>> are typically two-way, but not necessarily.
>>>
>>> A decentralized workflow consists of multiple repositories where
>>> branches are typically triangular, but not necessarily.
>>>
>>> So the triangularity is per branch, not per repository, and same_repo
>>> means a two-way branch, could be a centralized or decentralized
>>> workflow.
>> My personal viewpoint is that triangular flow happens when you cannot
>> push to the repo you consider as upstream.
> It's not about permissions. Even if I had permissions to push to git.git,
> I wouldn't do so. I do have permission to push to some public projects, but I
> instead send patches/pull requests like everyone else.

I had it that if you don't have permissions then you definitely need to
use a Triangular flow. Hence how I was presenting the view.
>
> It's more about ownership. In my personal repositories I can push
> whatever I want, but on shared repositories I have to be more careful.

True, there are social choices that are equivalent to a type of
'permission'.
>
>> Rather you typically have a publish/backup repo instead (semi-public,
>> semi-private - few are interested ;-).
>>
>> That (can't push one way around the triangle) part of the flow is
>> separate from the distinction between patch flows and merge (Pull)
>> request flows.
> I think it's not separate, that is the thing that makes a triangular
> flow triangular: the flow of patches goes through a different repository,
> and then they get picked and merged into the upstream one.
Pull requests can do the same thing, just as in Git-for Windows..

>
>> E.g. My personal Git repo can be triangular with both git.git and
>> git-for-windows, plus a few (what I view as) fetch-only repos from other
>> collaborators/maintainers beyond the triangular 'golden' upstream repo.
>>
>> I often consider GitHub as a centraliser, but I don't think it's what is
>> being considered above.
> GitHub is all about pull requests, you fork a repository, you push your
> branch into that personal fork, and then you request a pull from
> upstream.
>
> That's triangular.

Yes.
>
>> --
>> A thought did come to mind that a Git serve/repo (typically bare) should
>> be able to offer a 'refs/users/*' space (c.f. refs/remotes used by
>> individual users) that allows a type of 'centralised' operation (almost
>> as if all the users used a common alternates repo). Users could only
>> push to their own /user refs, but could pull from the main refs/heads,
>> and their own refs/users/ space.
>>
>> This would give flexibility to smaller corporate central operations to
>> offer 'triangular flow' where each dev would feel like they have their
>> own 'push' repo, when in reality it's really personalised branches. As
>> usual the authentication of user names being handed off elsewhere;-). It
>> could avoid some of the --alternate management aspects.
>>
>> It's a thought..
> Yeah, and interesting thought. But it demonstrates what I said above:
> you can have a central repository, and yet have triangular branches:

I see triangular being about repos, rather than branches. The suggestion
about was, essentially, about managing multiple user forks on the same
server without using alternates etc. It's not fully thought through ;-)

>
>  feature-1 <=  origin/master
>             => origin/felipec/feature-1
>
> Cheers.
>
I expect to be off-line for a week or so.

Philip

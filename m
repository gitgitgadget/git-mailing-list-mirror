Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62ECBC388F7
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 09:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17D6C22264
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 09:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgKCJ7V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 04:59:21 -0500
Received: from dd36226.kasserver.com ([85.13.153.21]:46596 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbgKCJ7T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 04:59:19 -0500
Received: from client3368.fritz.box (i5C745802.versanet.de [92.116.88.2])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id 8B4CB3C0BF9;
        Tue,  3 Nov 2020 10:59:15 +0100 (CET)
Subject: Re: [PATCH 00/14] completion: a bunch of updates
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
 <xmqqk1cz0zz1.fsf@gitster-ct.c.googlers.com>
 <CAMP44s3wqxTmgQpMgk2cM33EvtwrvvXYv4_90GKGmHb8yJHAKg@mail.gmail.com>
 <xmqqk0vbbep5.fsf@gitster.c.googlers.com>
 <CAMP44s13nip2_Z1OOFb9iVcrSxQbyJW4cH86J3Ah1p4SmTQWQQ@mail.gmail.com>
 <xmqqr1pj9rf0.fsf@gitster.c.googlers.com>
 <CAMP44s0nxQ8jxxw7wSPOMv9Nx1P7ww3S6dGv27xNVQ_aHTaPng@mail.gmail.com>
 <0ec43318-bf83-25c4-a817-a150e2e47546@haller-berlin.de>
 <CAMP44s0+TMhmPYM7omoFhcebMLhZyh6v77WUFNrscRtPNEDNHQ@mail.gmail.com>
 <xmqqeelh7y23.fsf@gitster.c.googlers.com>
 <010c6222-4365-7446-a666-333ac7b4d415@haller-berlin.de>
 <xmqqh7qb3a3r.fsf@gitster.c.googlers.com>
From:   Stefan Haller <lists@haller-berlin.de>
Message-ID: <e2b59b69-7fd2-f52c-eb06-6b97e3de557a@haller-berlin.de>
Date:   Tue, 3 Nov 2020 10:59:14 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqh7qb3a3r.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30.10.20 18:19, Junio C Hamano wrote:
> Stefan Haller <lists@haller-berlin.de> writes:
> 
>>> How is that completion script developed, maintained and distributed?
> 
> I think we should ask this question to those in Zsh development
> community.
> 
>>> By "by default" I believe you mean that it gets installed when you
>>> install zsh automatically.  Is the situation different on macOS land
>>> (which I can believe, unfortunately)?
>>
>> It's the same on Mac; I get zsh's builtin git completion when I don't
>> install ours.
> 
> I see.  That makes sense.
> 
>>> Stefan?  If at least some people argue what comes with zsh by
>>> default is more complete than the one we have in contrib/, what led
>>> you choose to "symlink" the less complete one to use it instead?
>>
>> I'm not sure I can answer the question which one is more complete. Ours
>> is certainly complete enough for my daily use, but this might not mean much.
>>
>> The reason why I chose ours over the one that comes with zsh is that
>> ours is *way* faster. If I type "git log origin/mas<tab>", with zsh's
>> completion it takes between one and two seconds to auto-complete this to
>> "origin/master". With ours it's instantaneous.
> 
> That is a very good data point.  I re-read the blurb on the
> "gitfast" thing (below) in ohmyzsh and learned that ...
> 
>>> Another question (this is for Felipe).  Is
>>>
>>>    https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/gitfast
>>>
>>> the one that comes with zsh by default, or is it something else
>>> (perhaps it is the go-to version for those who are not satisfied
>>> with the version that comes with zsh by default???)?
> 
> ... it repackages what we have in contrib/ and promises a faster
> completion (which aligns with the reason you stated why you chose
> ours) than the Zsh default one and being always fresh (by frequent
> updates from our contrib/).  In other words, my understanding is
> that it is positioned as a competitor to the Zsh default.
> 
> After making a brief observation for my previous message in the
> thread, I understand that oh-my-zsh is a very popular colleciton of
> third-party stuff for Zsh users, so it seems to me that the real
> useful choices, if I or somebody else were to become a new Zsh user,
> are between sticking with the Zsh default or grabbing the improved
> version from oh-my-zsh collection.  I could also use from our
> contrib/ but I would have to ask myself twice why should I, as a
> (hypothetical) new Zsh user, bother, especially when the latter
> promises to be always fresh anyway.

Using stuff from oh-my-zsh is not an option for me. I'm not using
oh-my-zsh, and I don't want to begin using it just for this one package.

I could use Felipe's version from
<https://github.com/felipec/git-completion> (and in fact, that's what
I'm doing right now, for testing. Works great. :-)  However, I'd have to
remember to manually update it every so often.

So yes, I prefer to use the one from git's distribution, because it is
automatically kept up to date whenever I update git (as long as I
symlink to it rather than copy it.)

-Stefan

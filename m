Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E62C433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 14:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 173BA61107
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 14:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbhKJOfU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 09:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbhKJOfS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 09:35:18 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89476C061764
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 06:32:30 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id f4so11250235edx.12
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 06:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=6MX9I2sHvSHk4dHVJnDz+Ywjwhi5PacO6IL24PYnbSM=;
        b=fJ+iPNr271NSWyZwC6xkVg0/dPzUpNV112inb57FG5U7+Hg0fQxMQDYK2DUHZWA6e3
         /tbvy+j+dpiamDKi5kR+o9iyVlSnlWzRfPn8OF075qugeIRajg1ETNDuueXsweKgxtDM
         1YtSClztKXIyYqp40qJwSPcHfkeFvY2/vSBVlOYN4Pmq3xxkxVZhIOuz+L0ZPcEn9FXT
         wddphx+BB2LFTbluyhnznTEs7wU/p+x54O2ZN3voTE8A2/kwjG6hfpWGAhkMJCLh3Yzj
         swJu4yo1kAJlUrqAmb53wfmOaTFKruWDsCTIXeFH6b2svrACBWwdcBL+v0uhEXglqUa+
         Z3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=6MX9I2sHvSHk4dHVJnDz+Ywjwhi5PacO6IL24PYnbSM=;
        b=PHBGLPxW+HMA668i49qg3xmkxhweyTrEuBhAytSsnc6uac1amLIfFh22IAqk8Xki0S
         5A0eV+hzEQERitOb1MYvkOi5i2fnaSNwDJjtH/iBdkAogYxZH4qh4ChKhpzq8sNyOvKn
         aetC4ukzhn0X1sHoWydg7ym+DRGX2BaMq3LyrKh8bgzQ8DZ/g76yvAi1YoeR5EY7esuz
         q6sDbY3SEiUAkgQdKqdAzCKoDgAy4K697Xnhzl9g0Zpf6BK+1kJ2aUJAZIYo/5k4XO6Y
         xMRtwnYQnrXYtKKw9e9vhICsIkiRVuiRWje2IJv8cqv7RrPL+RuHBjEsYifNknkh8VXk
         V6YQ==
X-Gm-Message-State: AOAM531Cjr1a+r5RBTKm3XPuBDQ7o8l3ATdqQsSs0d8o12r5UQsGvrQl
        dmv5qYh8ADsRIm+r61426Ck=
X-Google-Smtp-Source: ABdhPJxlIQskhcHgL9+N6yX1pQDR21HUFf4sXpWKcaodabRUPU4KaNBwk2aNlZwXed4XiR8QEknjew==
X-Received: by 2002:a17:907:3ea7:: with SMTP id hs39mr89651ejc.164.1636554748746;
        Wed, 10 Nov 2021 06:32:28 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id go10sm9515100ejc.115.2021.11.10.06.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 06:32:28 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mkoeJ-0010QK-Ps;
        Wed, 10 Nov 2021 15:32:27 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: js/scalar, was Re: What's cooking in git.git (Nov 2021, #03;
 Tue, 9)
Date:   Wed, 10 Nov 2021 14:42:22 +0100
References: <xmqqy25wygek.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2111101343570.21127@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <nycvar.QRO.7.76.6.2111101343570.21127@tvgsbejvaqbjf.bet>
Message-ID: <211110.86czn8hyis.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 10 2021, Johannes Schindelin wrote:

> Hi Junio,
>
> On Tue, 9 Nov 2021, Junio C Hamano wrote:
>
>> * js/scalar (2021-10-27) 15 commits
>>  - scalar: accept -C and -c options before the subcommand
>>  - scalar: implement the `version` command
>>  - scalar: implement the `delete` command
>>  - scalar: teach 'reconfigure' to optionally handle all registered enlistments
>>  - scalar: allow reconfiguring an existing enlistment
>>  - scalar: implement the `run` command
>>  - scalar: teach 'clone' to support the --single-branch option
>>  - scalar: implement the `clone` subcommand
>>  - scalar: implement 'scalar list'
>>  - scalar: let 'unregister' handle a deleted enlistment directory gracefully
>>  - scalar: 'unregister' stops background maintenance
>>  - scalar: 'register' sets recommended config and starts maintenance
>>  - scalar: create test infrastructure
>>  - scalar: start documenting the command
>>  - scalar: create a rudimentary executable
>>
>>  Add pieces from "scalar" to contrib/.
>>
>>  What's the status of this thing?
>
> It is on hold, for two reasons: we're in the -rc phase now, and I think we
> all need to focus on it.
>
> Ciao,
> Dscho
>
> P.S.: The second reason is that I was uncertain as to your decision
> regarding Stolee's thread about the optimal final location for Scalar.
> Since it seems that we can actually go forward with `contrib/scalar/` even
> if you eventually decide you prefer another place, I plan on submitting a
> new iteration with adjustments for v2.34.0, after that release.

Whatever anyone thinks about Stolee's thread/proposal
(https://lore.kernel.org/git/b67bbef4-e4c3-b6a7-1c7f-7d405902ef8b@gmail.com/)
it's clear that the proposals outlined there describe an entirely
theoretical end-state for scalar that don't line up with the state of
these patches.

That's not just my opinion, here's Stolee agreeing with that:
https://lore.kernel.org/git/9eb8fd45-c8a5-0320-6d38-56389bef193d@gmail.com/

Re: the "status of this thing" I think it's the same it's been for the
last two months:

I've been pointing out things that are objectively broken, and the
response has been pretty much everything except inline commentary on
proposed fixups I've suggested to fix those observed bugs.

The latest being this patch ready to apply on top of js/scalar with no
response for almost 2 weeks now:
https://lore.kernel.org/git/patch-1.1-86fb8d56307-20211028T185016Z-avarab@gmail.com

I'll be the first to admit that *parts* of that are definitely an
opinionated change-on-top.

I also think anyone who'd look at it would agree that it raises issues
that I think could most generously be described as a disconnect between
your commit messages & patches.

Up to and including them making suggestions of running certain commands
either can't work, or don't work as described.

I'll let this be my last word on this whole scalar series saga. I'll
hedge that & say that if you'd like to meaningfully respond to the
fixups I've been suggesting I'm happy to re-engage with you.

"Meaningfully" as in inline commentary on the patch I'm suggesting
explaining why certain things are not OK, don't provide an example of
specific things that don't work/work before/after etc.

That being said no E-Mail like this would be complete without a plainly
worded last few paragraphs, so here goes:

I find it hard to square your comments in other areas about inclusivity
& assuming good faith from other contributors with my experience in
trying to help in moving this scalar thing along.

My honest intentions in this area are just to help what I see as a
useful feature in need of some fixes along.

I've really not been obstinately insisting that you take all my
suggestions. I'd have been fine with most of the points I've raised just
being addressed with something to the effect of "we know <X> is broken,
but that's OK due to <Y>" in relevant commit messages.

But getting even something terse like that in reply has taken a lot of
time & energy on my part.

No hard feelings on my side, although admittedly some baffled
frustration. I do respect you and the work you do, I suspect that on
your side (at least on this topic) that's now closer to "routing the
E-Mails to /dev/null", at least it seems that way from my side.

If you'd like to talk about it (even privately, or over other media) I'd
be happy to. Right now it feel like I've done something to end up your
your shitlist, and I honestly don't know what that could be.

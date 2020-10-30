Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBCFC00A89
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 17:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72A872083B
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 17:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UkE3NCNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgJ3RUB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 13:20:01 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58977 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgJ3RUB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 13:20:01 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2358E1036C9;
        Fri, 30 Oct 2020 13:19:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PlkB7rCH9qfhhpFPJ3NZg2G3u8A=; b=UkE3NC
        NOjCwPaWbQSiKs2Na9Tbn8Yb6jcjC5bAmRlL5RnyZNlbkvf1eDLjyKJKGWIDaAp3
        dLDrIuq6mnCdE7qus1D703bpVQUSEOQ/Qr29KqsVva9Jm+VWWkByd56HHCW+aZcc
        D0jdA5r7eGMBMzIssg1z0vjbkpCL4Ogu4SI7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uQa9angYYJ1UmEcFBqQ6MnNTOULhKi4R
        zZ/pg17gBNjlyRsQkef9Ot24g8OW4Mo1xkRYg5/3ZyazdbTm8l2p1io1KkD/PhwR
        IqX43ewE+GzAyZV0vgetLJGv/jo/UoK64R2HhvOs+i8KSMR4iWVLDPML6IUG6M0W
        iZxmHq5YDFw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 07DAB1036C8;
        Fri, 30 Oct 2020 13:19:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 441321036C0;
        Fri, 30 Oct 2020 13:19:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Haller <lists@haller-berlin.de>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Git <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 00/14] completion: a bunch of updates
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
Date:   Fri, 30 Oct 2020 10:19:20 -0700
In-Reply-To: <010c6222-4365-7446-a666-333ac7b4d415@haller-berlin.de> (Stefan
        Haller's message of "Fri, 30 Oct 2020 09:01:28 +0100")
Message-ID: <xmqqh7qb3a3r.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0DDDD324-1AD4-11EB-8A25-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Haller <lists@haller-berlin.de> writes:

>> How is that completion script developed, maintained and distributed?

I think we should ask this question to those in Zsh development
community.

>> By "by default" I believe you mean that it gets installed when you
>> install zsh automatically.  Is the situation different on macOS land
>> (which I can believe, unfortunately)?
>
> It's the same on Mac; I get zsh's builtin git completion when I don't
> install ours.

I see.  That makes sense.

>> Stefan?  If at least some people argue what comes with zsh by
>> default is more complete than the one we have in contrib/, what led
>> you choose to "symlink" the less complete one to use it instead?
>
> I'm not sure I can answer the question which one is more complete. Ours
> is certainly complete enough for my daily use, but this might not mean much.
>
> The reason why I chose ours over the one that comes with zsh is that
> ours is *way* faster. If I type "git log origin/mas<tab>", with zsh's
> completion it takes between one and two seconds to auto-complete this to
> "origin/master". With ours it's instantaneous.

That is a very good data point.  I re-read the blurb on the
"gitfast" thing (below) in ohmyzsh and learned that ...

>> Another question (this is for Felipe).  Is
>> 
>>    https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/gitfast
>> 
>> the one that comes with zsh by default, or is it something else
>> (perhaps it is the go-to version for those who are not satisfied
>> with the version that comes with zsh by default???)?

... it repackages what we have in contrib/ and promises a faster
completion (which aligns with the reason you stated why you chose
ours) than the Zsh default one and being always fresh (by frequent
updates from our contrib/).  In other words, my understanding is
that it is positioned as a competitor to the Zsh default.

After making a brief observation for my previous message in the
thread, I understand that oh-my-zsh is a very popular colleciton of
third-party stuff for Zsh users, so it seems to me that the real
useful choices, if I or somebody else were to become a new Zsh user,
are between sticking with the Zsh default or grabbing the improved
version from oh-my-zsh collection.  I could also use from our
contrib/ but I would have to ask myself twice why should I, as a
(hypothetical) new Zsh user, bother, especially when the latter
promises to be always fresh anyway.

Thanks.




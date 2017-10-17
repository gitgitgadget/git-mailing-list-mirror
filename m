Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4F3F1FF32
	for <e@80x24.org>; Tue, 17 Oct 2017 23:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759829AbdJQXWI (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 19:22:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54484 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756794AbdJQXWH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 19:22:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 90758A32FF;
        Tue, 17 Oct 2017 19:22:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=galuEnMMsnux
        0yX4uCwkGXZ3P0o=; b=BQuXBQy9E2RwoKZFhKUnPHa7gc7c14KLs0w2a0wDOgoU
        T3eM+P+YwM7+tk4t9YfEPcusLb9VSFupr+RWlceqWYhAw0HV7Q4uSecVYolFLYRI
        pTkA1cyKHrry9SITejy29yuFv0FcORRANhOWhrSRC7SiF3u0Iog3dFyJQgGhdqk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Yxth9A
        DKM3X2TtHBhXFM2ypyAqS7sUWNQyHHwVSrdtBLv2c63EqhVMjsMbhB4YuFy8ibPe
        LSCAEmQJcCcRWZRk6LUTBNL70IJ3C/DfKhi4kcn76Azm1vOW7SBIymHHb26HvEiP
        Nlxm1NRdfyDQW03t5D/4bW7QGwTif5dIxF0dE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 879A8A32F9;
        Tue, 17 Oct 2017 19:22:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EBAA2A32F8;
        Tue, 17 Oct 2017 19:22:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Thomas Rikl <trikl@online.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [Alt. PATCH] ls-remote: deprecate -h as short for --heads
References: <63fe2a84-d991-9165-32c0-8087d8513ce6@online.de>
        <CAN0heSpPWWdWY4d1wCdRH8TjcmD3kAiSffL0-_9kJWkm5P2EkA@mail.gmail.com>
        <4d110305-0826-6fd1-91a5-c1ebd0b1e80b@web.de>
        <774f08bd-3172-0083-1544-e5f68f6798fa@web.de>
Date:   Wed, 18 Oct 2017 08:22:04 +0900
In-Reply-To: <774f08bd-3172-0083-1544-e5f68f6798fa@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 17 Oct 2017 17:39:14 +0200")
Message-ID: <xmqqk1ztmkbn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FD5CEBCC-B391-11E7-9BB6-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Stop advertising -h as the short equivalent of --heads, because it's
> used for showing a short help text for almost all other git commands.
> Since the ba5f28bf79 (ls-remote: use parse-options api) it has only
> been working when used together with other parameters anyway.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> That would be step on the way towards more consistent command line
> switches, in the same vein as d69155119 (t0012: test "-h" with
> builtins).

Sorry, but I am not sure whom this and the other approach are trying
to help.

The rule we have currently seems to be that "git cmd -h" (no other
arguments) consistently gives a short help, and if a subcommand
supports an option "-h" specific to it that is not about giving a
short help, the caller needs to be aware of it to invoke the option,
by making sure that there is some other arguments on the command
line if "-h" form of that subcommand specific option is used, by
doing e.g. "git ls-remote -h origin" or "git ls-remote --head".

I can see that this "alternative" approach makes it less convenent
for folks who have followed that rule by hiding "-h" (with the
intention of deprecating and possibly removing it in the future) and
encouraging (and later foring) "--head" to be used instead. =20

The other approach burdens new users by changing the rule to "some
subcommands that have their own '-h' option cannot be asked for a
brief usage with 'git cmd -h'".  But the thing is, these new users
who do not know which subcommands do have their own '-h' and which
ones do not are the ones that benefit most from the consistent "'git
cmd -h' with no other argument gets short help" rule.

When making a backward incompatible change, it is asking us to go to
those who are inconvenienced and say "I am sorry that we are making
things less convenient for you, but by doing so we can gain this
greater good which is ...".  I can explain how this and the other
approach make things less convenient for existing or new users, but
I am having a hard time formulating what the greater good is.

In short, I cannot sell this change to our users.  Please help me do
so if you want this (or the other) change made to our system.


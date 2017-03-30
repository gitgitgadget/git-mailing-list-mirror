Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36C8820958
	for <e@80x24.org>; Thu, 30 Mar 2017 00:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933215AbdC3AbU (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 20:31:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51847 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933125AbdC3AbT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 20:31:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 68E058A190;
        Wed, 29 Mar 2017 20:31:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=q4VwNwBlu+Jk4szHhnEDn1mDwW4=; b=C/177K
        xwUivhl+pdTmydtv4MQnvg2x7nj+xUytIraVUuLt6D3XiZ68lB+rOulq7iqXRmQc
        40n3klvgeEwC44c3Rx8+WLBJxcmspd74i4syBf6jCZWDaND7406zGXfJr26vh1Na
        X1ZSMfFYLczN4ZRcckeWneuIi3SHfI8Au4YYs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MiLyn+/gixDT/rEK8AUj8wiKOKqWm91I
        v/gwXoAb738vqAmAvFXIARcixJV5rchL6KS6M9IuTQn2WGXGMf8th0wsm1E7Fy+N
        Lm+1wZ8l3m/RGKSqRK6T394PnwwTsjC+Rb0kbNk+edYWVWFgk7fyZiZIE1/xVZTg
        X14b2OcZcfc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 605918A18F;
        Wed, 29 Mar 2017 20:31:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BD5678A18D;
        Wed, 29 Mar 2017 20:31:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/7] PREVIEW: Introduce DC_AND_OPENSSL_SHA1 make flag
References: <cover.1490397869.git.johannes.schindelin@gmx.de>
        <xmqq7f3d6ev1.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1703291509450.48202@virtualbox>
Date:   Wed, 29 Mar 2017 17:31:15 -0700
In-Reply-To: <alpine.DEB.2.20.1703291509450.48202@virtualbox> (Johannes
        Schindelin's message of "Wed, 29 Mar 2017 22:02:17 +0200 (CEST)")
Message-ID: <xmqqr31f7gh8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2FF47092-14E0-11E7-B837-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> - After the SHAttered blog post became public, Linus first made the case
>   that it matters not all that much: the development of the Linux kernel
>   is based on trust, and nobody would pull from a person they do not trust.
>   This approach does obviously not extend to most other projects.
>
> - By switching the default to DC_SHA1 already in `master`, you now took
>   the exact opposite position: it *always* matters, even when you trust
>   people, and the 6x slowdown demonstrated by my perf test is something that
>   everybody needs to accept, even if it is spent for no benefit in return.

You seem to be trying very hard to make it look like as if Linus
said one thing and I decided to do something else, but if one digs
into the archive, it should be clear that that is not how the
current line of development has happened.  Even from the same
person, you can hear that "the social aspect of how the project is
structured makes the kernel less susceptible to the shattered
attack" [*1*] and that "mitigation at Git level is easy" [*2*].

The kernel as a project may not have to do much, but the world of
projects using Git is wider than the kernel alone, and mitigation
that applies to all was available and is easy to make it the
default.

> The approach I chose instead was to make the switch global, per command.
> Obviously, the next step is to identify the Git commands which accept
> objects from external sources (`clone`, `fetch`, `fast-import` and all the
> remote helpers come to mind) and let them set a global flag before asking
> git_default_config() to parse the core.enableSHA1DC setting, so that the
> special value `external` could trigger the collision detecting code for
> those, and only those, commands. That would still err on the safe side if
> these commands are used to hash objects originating from the same machine,
> but that is a price I would be willing to pay for the simplicity of this
> approach.
>
> Does my explanation manage to illustrate in a plausible way why I chose
> the approach that I did?

I agree that there may be rooms to tweak the degree of paranoia per
codepath (I said that already in the message you are responding to),
but as Linus and Peff already said in the old discussion thread
[*3*], I doubt that it needs to be runtime configurable.

In any case, I do not think you should blindly trust what end-users
add to the repository locally.  A vendor may send in a binary driver
update via a pull-request, and you would want to protect "clone" and
"fetch" client because of that.  The same driver update however may
come as a patch that is accepted by running "git am".  Or you may
get a vendor tarball ftp'ed over and "git add ." the whole thing.

These "local" operations still need the same degree of paranoia as
your "git fetch"; "per command" may not be such a good criterion
because of that.

That is why I mentioned "you want to be paranoid any time you add
new data to the object database" as a rule of thumb in the message
you are responding to.  It may be overly broad, but would be a
better starting point than "'git add' is always safe as it is
local".

So in short, I do agree with your idea of using "faster" hashing for
some codepaths and "paranoid" ones for others.  I think "slower but
collision-attack detecting" one (aka DC_SHA1) plus a choice of
"faster" one at compile time would be a sensible way to go, and if
one is truly paranoid, the "faster" one _could_ be sha1dc.c with
collision detection disabled.  On the other hand, if one is in a
closed environment, one may want both hashes configurable and let
OpenSSL implementation be chosen for both "slower but DC" and
"faster" hash.  And I am OK with that, too.


[Reference]

*1* https://public-inbox.org/git/CA+55aFz98r7NC_3BW_1HU9-0C-HcrFou3=0gmRcS38=-x8dmVw@mail.gmail.com/

*2* https://public-inbox.org/git/CA+55aFxmr6ntWGbJDa8tOyxXDX3H-yd4TQthgV_Tn1u91yyT8w@mail.gmail.com/

*3* https://public-inbox.org/git/20170323174750.xyucxmfhuc6dbrzc@sigill.intra.peff.net/

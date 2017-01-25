Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1886C1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 20:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751635AbdAYUwV (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 15:52:21 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62002 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750880AbdAYUwU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 15:52:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B99E862A85;
        Wed, 25 Jan 2017 15:52:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nq5QI0dcWdtRKxzTtcxDAz5W7BA=; b=r4N4Sv
        dNBGxTSkzkcHoBJ7yVD5uuRHuo9twAtCY3BK6BiDGXO5jfT7icaSlrPwPR3Kncne
        APrDvvdIRAil0svqjAINHqtAKI3TApjFQNt/GjcxLPGXBetiN5TdxAcogexnbgxD
        eOKOdL/AVtsBBvILLrCU0lkvmHqHnxBTMzAFg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GLChYDdcN8j+mBNs23+NWC656bLs7OBZ
        qD5P/EXlWxSQr8VeoPY1aDQ5CCdow98pS7pf9WBAFq63n9nzgqXS89DXIr7uRI8R
        /MuyQ65inNPcwgUwqTbcWDj6jLLAr5Ut4EwPj+1sq7gI70y0u9HP6WA303iEts54
        ddQURauIPSQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B099762A84;
        Wed, 25 Jan 2017 15:52:18 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1072662A81;
        Wed, 25 Jan 2017 15:52:17 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 14/21] read-cache: touch shared index files when used
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
        <20161226102222.17150-15-chriscool@tuxfamily.org>
        <xmqqa8bhb32x.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD1EgOxcPi=tpiosKkYMcCZe+b6gwW0CKt2sE1NZ7gQv=A@mail.gmail.com>
        <xmqqo9zi35n6.fsf@gitster.mtv.corp.google.com>
        <CACsJy8AR6yNr0y+_JZDkW-HO_yHPkUx_6zbLGoviKQBOVcSg5A@mail.gmail.com>
        <xmqqvatouwsh.fsf@gitster.mtv.corp.google.com>
        <CACsJy8B_xe6RtszPrncvDdSYosNUQxvhcEQ3DO_WO0sepXqvvQ@mail.gmail.com>
        <xmqqlgu627uj.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD2LWGtNtdhtQTZXqsACBvK=jD25vt8M4HzBRBVS1sJ+=Q@mail.gmail.com>
        <xmqqefztsj4c.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD3KXOgVOhuMtws36XPiek56U4mQKdUs07hzKc-dC=ppmA@mail.gmail.com>
Date:   Wed, 25 Jan 2017 12:52:16 -0800
In-Reply-To: <CAP8UFD3KXOgVOhuMtws36XPiek56U4mQKdUs07hzKc-dC=ppmA@mail.gmail.com>
        (Christian Couder's message of "Wed, 25 Jan 2017 15:35:47 +0100")
Message-ID: <xmqqsho6amm7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28A787BA-E340-11E6-B87B-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Well, when we cannot freshen a loose file (with
> freshen_loose_object()), we don't warn or die, we just write the loose
> file. But here we cannot write the shared index file.

I think that is an excellent point.  Let me make sure I got you
right.  For loose object files, we may attempt to freshen and when
it fails we stay silent and do not talk about the failure.  Instead,
we write the same file again.  That will have two potential outcomes:

 1. write fails and we fail the whole thing.  It is very clear to
    the user that there is something wrong going on.

 2. write succeeds, and because we just wrote it, we know that the
    file is fresh and is protected from gc.

So the "freshen and if fails just write" is sufficient.  It is
absolutely the right thing to do for loose object files.

When we are forking off a new split index file based on an old
shared index file, we may attempt to "touch" the old shared one, but
we cannot write the old shared one again, because other split index
may be based on that, and we do not have enough information to
recreate the old one [*1*].  The fallback safety is not available.

> And this doesn't lead to a catastrophic failure right away. 

Exactly.

> There
> could be a catastrophic failure if the shared index file is needed
> again later, but we are not sure that it's going to be needed later.
> In fact it may have just been removed because it won't be needed
> later.

You are listing only the irrelevant cases.  The shared one may be
used immediately, and the user can keep using it for a while without
"touching".  Perhaps the shared one was chowned to "root" while the
user is looking the other way, and its timestamp is now frozen to
the time of chown.  It is a ticking time-bomb that will go off when
your expiry logic kicks in.

> So I am not sure it's a good idea to anticipate a catastrophic failure
> that may not happen. Perhaps we could just warn, but I am not sure it
> will help the user. If the catastrophic failure doesn't happen because
> the shared index file is not needed, I can't see how the warning could
> help. And if there is a catastrophic failure, the following will be
> displayed:
>
> fatal: .git/sharedindex.cbfe41352a4623d4d3e9757861fed53f3094e0ac:
> index file open failed: No such file or directory

That "fatal" is given _ONLY_ after time passes and our failure to
"touch" the file that is still-in-use left it subject to "gc".  Of
course, when "fatal" is given, it is too late to warn about ticking
time bomb.

At the time we notice a ticking time bomb is the only sensible time
to warn.  Or better yet take a corrective action.

As I expect (and you seem to agree) that a failure to "touch" would
be a very rare event (like, sysadmin chowning it to "root" by
mistake), I do not mind if the "corrective action" were "immediately
unsplit the index, so that at least the current and the latest index
contents will be written out safely to a new single unsplit index
file".  That won't help _other_ split index files that are based on
the same "untouchable" shared index, but I do not think that is a
problem we need to solve---if they are still in use, the code that
use them will notice it, and otherwise they are not in use and can
be aged away safely.


[Footnote]

*1* My understanding is that we lose information on stale entries in
    the shared file that are covered by the split index overlay
    after read_index() returns, so we _might_ be able to write the
    "old" one that is sufficient for _our_ split index, but we do
    not have good enough information to recreate "old" one usable by
    other split index files.

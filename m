Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D56C433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 18:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 450AE64E24
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 18:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbhBWSPK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 13:15:10 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63597 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbhBWSO6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 13:14:58 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3B08DBBE0A;
        Tue, 23 Feb 2021 13:14:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JPJMeDUO0rNp
        Lv4sq+LH8RJtdp0=; b=T97oY7ynLGSee4JjgW0jo3skYbNGL4YWjiqhuJbEwYkd
        FF5w1CBEyAkDJoexsgvrtVEbSyEsPgXTZztduudBJbBuUZH0XVpqDuq2dkV8Gv1P
        7RA5PORRaJNuPNAC8F1Ksc7o/dcet4VlacVJ2ck9kwrmaruOXvqnzaZ65Lp2tlU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=cNiMoS
        SdsVjD01Y1JvNjWUiaFtRmwq5D4LMebmJ+CZ4GKglmMpm8qWLxVth5advkvvz5Gv
        IYyxppNy+YpcxXc0dwE2mwqVh2MYCFRZhnLMJeF3W1mElBybmbGiHhS9QFdrlVYC
        RHeLY/6jMrNvq8/1aQwxxJ+OFklh2WFAzJCAc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 31204BBE09;
        Tue, 23 Feb 2021 13:14:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A2905BBE08;
        Tue, 23 Feb 2021 13:14:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Stefan Monnier <monnier@iro.umontreal.ca>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: New orphan worktree?
References: <jwvwnwqrqwd.fsf-monnier+gmane.comp.version-control.git@gnu.org>
        <CABPp-BE1QXA0ohB9D-tqKpzDTok0BMsGQjotmcqMxfs9AL5noA@mail.gmail.com>
        <CAPig+cRzXd+zd+xVisaW+HToSaGzAE28acGmxwRxNU4bczHXbw@mail.gmail.com>
        <87wnv688u4.fsf@evledraar.gmail.com>
        <CAPig+cQ9oqMWjBkyRt-SQFuyfAGkMu1J-U6ZCCJqeL0a_3ynkw@mail.gmail.com>
        <87ft1o8mi0.fsf@evledraar.gmail.com>
        <CAPig+cSkL+5otKUWwm=CLaRR+j71wW61U7LWtmuUHO+7bZaY_g@mail.gmail.com>
        <87czwr8wou.fsf@evledraar.gmail.com>
        <CAPig+cQxYtw5z_bRQbS6MLgHQM2OTs5oRfpvKSOwZo8GcuwpTg@mail.gmail.com>
        <87a6rv82n3.fsf@evledraar.gmail.com>
Date:   Tue, 23 Feb 2021 10:14:06 -0800
In-Reply-To: <87a6rv82n3.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 23 Feb 2021 12:06:08 +0100")
Message-ID: <xmqq7dmy4pox.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EB6E94F6-7602-11EB-8779-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> I see where you're coming from in viewing --orphan as a modifier of
>> branch creation rather than as a branch-creation option itself.
>> However, as far as UI is concerned, that ship sailed a long time ago,
>> I suppose.
>
> Not really, I think we can have a new-style of it and just say:
>
>     It is also possible to provide `--orphan <branch-name>`, but
>     supplying it as an option to `-[cC]` as `-[cC] <branch-name>
>     --orphan` is preferred these days.
>
> Whether we should is another matter, see below...

We cannot affored to give it a short-and-sweet "-[oO]", but if we
could, we probably would have, and that would have made the UI
consistent, at least (in other words, I'd see the act of creating an
"orphan" branch something distinct from creation of a normal
branch).

"You can treat --orphan as a standalone and distinct request to
create this specific kind of branch, or you can treat as if it is
just a modifier to specify which kind of branch, and -c/-C is still
used to ask for creation or forced update" does not sound like a
very end-user friendly explanation, at least to me.  Extra choices
that do not make a real difference invites "so, which should I
use?", a question they do not have to ask.

>>> I think not having a -B or -C equivalent at all would be preferrable =
to
>>> having a --force special-case just to work around the lack of it for
>>> --orphan.
>>
>> I'm having trouble wrapping my brain around this statement.
>
> I mean I'd rather not have an --orphan mode that works like -B (as
> opposed to -b) at all instead of having one that's "--orphan
> --force-ref-deletion" or whatever.

If you are saying that we should just have

    -c/-b/--orphan
    -c/-b/--orphan --force
    -C/-B (synonym for -c/-b --force)

then I fully agree.  I think the uppercase ones (and "git branch -d/-D")
were mistakes and should have used --force instead.

> It's an obscure enough thing that I don't think anyone *really* cares. =
I
> just wanted to find out if it not being a boolean was intentional, or a
> historical accident we would consider fixing if there was further work
> on it.

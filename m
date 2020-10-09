Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B97C433DF
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 16:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CFC922281
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 16:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Uz3oK1Hv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389880AbgJIQsG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 12:48:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52998 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389431AbgJIQsG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 12:48:06 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1DC8C884B5;
        Fri,  9 Oct 2020 12:48:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ilEUjq9xxvBe
        6HLsqDFEQNPjbzc=; b=Uz3oK1HvI8u9sCuhzqA7BxhpmpskfhZBRmiBWmM604K4
        o5NNui2PoJ19XslBOhYx1R6iUewPVvbALOhrY4W9kOPAYEiVfUXMhkwma1ZLD4I9
        /+OQjNUQEglIguD1nt4A1j1ujslv5VUgC6hp2T6zUvp6TMGr6dcc9/EinQxsaig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=AnCG/9
        SOTFGvfHCyC5h+Ip91SHToDX05HRzuod62jbBg5pUG2y5ehlodFDG4IDau0oXC/y
        sqgPtEWp7QNDSXgG8RR+WIKJtu0JwvqTrXuaa8yZu4znGD2gMAmMI47/nXQiR+Jn
        za3RBshHxDpQFzP6hjSNk0OaLVxnVkMTCmTLQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 136ED884B4;
        Fri,  9 Oct 2020 12:48:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2DBE9884B3;
        Fri,  9 Oct 2020 12:48:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nathaniel Manista <nathaniel@google.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Shengfa Lin <shengfa@google.com>, rsbecker@nexbridge.com,
        santiago@nyu.edu
Subject: Re: [RFC PATCH 0/1] adding user.hideTimezone for setting UTC timezone
References: <CAEOYnAQYMrNAe9s1V-0DVLdL-B_KpHMDP5e=yRnbCkMWdrvFHQ@mail.gmail.com>
        <20200930232138.3656304-1-shengfa@google.com>
        <xmqqlfgqes95.fsf@gitster.c.googlers.com>
        <xmqqtuved70y.fsf@gitster.c.googlers.com>
        <20201001034350.GB2930867@google.com>
        <xmqqh7rec5h3.fsf@gitster.c.googlers.com>
        <xmqqk0w0wl9t.fsf@gitster.c.googlers.com>
        <CAEOYnASgxCE5NjhoSgDwyQyAmdLhw5UyFq_Fu==8q7y6uXGz6w@mail.gmail.com>
Date:   Fri, 09 Oct 2020 09:48:00 -0700
In-Reply-To: <CAEOYnASgxCE5NjhoSgDwyQyAmdLhw5UyFq_Fu==8q7y6uXGz6w@mail.gmail.com>
        (Nathaniel Manista's message of "Fri, 9 Oct 2020 14:31:43 +0200")
Message-ID: <xmqqimbjtkfz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 31616C7E-0A4F-11EB-BBCB-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nathaniel Manista <nathaniel@google.com> writes:

> If we say that we would like to eventually live in a world in which a
> user's time zones are not recorded until after that user deliberately o=
pts
> into git recording zir time zones, does that point us toward an eventua=
l
> destination of "users who don't wish to record their time zones don't h=
ave
> to do anything to their .gitconfigs, and users who do wish to record th=
eir
> time zones only have to write one line in their .gitconfigs"? If that's=
 the
> case, ought that one line that some users choose to write be targeted t=
o be
> "recordTimeZone =3D true" rather than anything else (particularly rathe=
r than
> "hideTimeZone =3D false")? If all that holds, does
>
> today: introduce recordTimeZone with a default of true and advertise it=
s
> existence so that those users who have feelings one way or the other on=
 the
> matter may explicitly set it to one value or the other
> six months from today: flip recordTimeZone's default from true to false
>
> look like a plausible sketch of how to get to the desired future state?
>
> What am I missing (and =F0=9F=A4=9E that my "if"s hold too...)?

Since it is perfectly OK to have a configuration variable whose
default value is 'true', the choice between the world in which times
are by default hidden and the opposite world does not affect which
way the configuration variable should be named and defined at all.

The system could hide zone when there is no user.hideTimeZone
configured, and those who think that the value of giving others a
useful bit of info outweighs the value of hiding their own zone can
set it explicitly to 'false' to expose their zone.

Or the system could record zone when there is no user.recordTimeZone
configured, and you can set it explicitly to 'false' if you think if
it is more valuable to omit your zone from the commit than recording
the zone in which the commit was written.

Either way, we can make the system to "do what the majority of users
want, with an escape hatch to protect monority"; the naming does not
affect it in any way.

The only thing we should consider when naming, therefore, is how
clearly the name conveys the semantics.

And from that point of view, user.hideTimeZone=3Dyes is a mistake.  It
can be mistaken as if we do record but simply choose not to show at
time of the output.  Contrast that with user.recordTimeZone=3Dno which
has no such room for confusion.  If we are not recording, there is
nothing clever to be done when showing.

FWIW, I am not in favor of dropping info by default myself, but that
is outside the scope of this message.

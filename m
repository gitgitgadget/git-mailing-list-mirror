Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85AC91F89D
	for <e@80x24.org>; Sat, 22 Jul 2017 15:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750872AbdGVPxy (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Jul 2017 11:53:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57131 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750787AbdGVPxx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jul 2017 11:53:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 16BAAA612E;
        Sat, 22 Jul 2017 11:53:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=FEkzbLJzTSJI
        JbOOBhJpCIyOXOY=; b=tEptRcx5xIxLTy3fnBmPEsbybdJMmrBpu4SwL4uOpryP
        n4J4mT9BZkPT3scTTli1qTVrExvcxhM55soBpUNQ4kenHEtnneDNbZEidGr7vRMl
        v0eVFqws/0cu25xvdhLtKZdoIM0YdI9iKcPLEDM4IexBeA4WaMfTHXMUGsYHp9o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=nWVxRb
        kykcklyPXpUOI6uCVx5rJFpGGO7UjzeTZa7FvU40h2c9SzygwynT19fw5nl4ASqN
        5hlvqfOwLX0UmHvOtHaQQXhgVFehBkETCEKi6XH0X50kSDD8Z1J8ESWtO9COrlTn
        pkdVD9+WG7X/DxXnn18WXNXubNvDOos5R+hBQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B85FA612D;
        Sat, 22 Jul 2017 11:53:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5FC74A612C;
        Sat, 22 Jul 2017 11:53:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] PRItime: wrap PRItime for better l10n compatibility
References: <249ac6f8-af3c-4b20-5bf0-87a82866cc7a@free.fr>
        <3ccfa2fb49d471f807d77d9a280e4b7cfe56faea.1500304209.git.worldhello.net@gmail.com>
        <xmqq7ez7htvj.fsf@gitster.mtv.corp.google.com>
        <CANYiYbEcMrriaor9OT4c2qtfh9Ja5NJ9KBSxa3XhPAuoN0t42A@mail.gmail.com>
        <xmqq60epfy27.fsf@gitster.mtv.corp.google.com>
        <CANYiYbFROuyXso2ZKuJWDp4cSwpBu=bNAbC-yZtEyDwkbUcAhQ@mail.gmail.com>
        <alpine.DEB.2.21.1.1707191456010.4193@virtualbox>
        <xmqq8tjkm3ly.fsf@gitster.mtv.corp.google.com>
        <xmqqo9sfkm32.fsf@gitster.mtv.corp.google.com>
        <xmqqfudrkkci.fsf@gitster.mtv.corp.google.com>
        <f00aeb42-75ad-d5ec-b4fb-c80b48827db4@free.fr>
        <xmqq7ez1j0wv.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1707221320350.4271@virtualbox>
Date:   Sat, 22 Jul 2017 08:53:44 -0700
In-Reply-To: <alpine.DEB.2.21.1.1707221320350.4271@virtualbox> (Johannes
        Schindelin's message of "Sat, 22 Jul 2017 13:21:41 +0200 (CEST)")
Message-ID: <xmqqa83wfoxj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F164B556-6EF5-11E7-B429-EFB41968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 21 Jul 2017, Junio C Hamano wrote:
>
>> Jean-No=C3=ABl Avila <jn.avila@free.fr> writes:
>>=20
>> > Le 20/07/2017 =C3=A0 20:57, Junio C Hamano a =C3=A9crit :
>> >>
>> >> +	git diff --quiet HEAD && git diff --quiet --cached
>> >> +
>> >> +	@for s in $(LOCALIZED_C) $(LOCALIZED_SH) $(LOCALIZED_PERL); \
>> >
>> > Does PRIuMAX make sense for perl and sh files?
>>=20
>> Not really; I did this primarily because I would prefer to keep
>> things consistent, anticipating there may be some other things we
>> need to replace before running gettext(1) for other reasons later.
>
> It would add unnecessary churn, too, to add those specific exclusions a=
nd
> make things inconsistent: the use of PRItime in Perl or shell scripts
> would already make those scripts barf. And if it is unnecessary churn..=
.
> let's not do it?

Sorry, but I cannot quite tell if you are in favor of limiting the
set of source files that go through the sed substitution (because we
know PRIuMAX is just as nonsensical as PRItime in perl and shell
source), or if you are in favor of keeping the patch as-is (because
changing the set of source files is a churn and substitutions would
not hurt)?

I am actually OK to change the above loop to process only the C
sources; I am not OK to change it to process only date.c which
happens to be the only source that has PRItime that matters in this
context, of course.

Thanks.



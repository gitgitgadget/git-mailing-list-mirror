Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2186EC433C1
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 20:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D54AC61936
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 20:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhCTUE5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 16:04:57 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60891 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhCTUEp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 16:04:45 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9036D113A98;
        Sat, 20 Mar 2021 16:04:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yL8iL+GZwbMu
        bvOnqsUr1c494nM=; b=fMNJeF7oRPtpoSJ/wNqrrGkKC8SWMmvj0ClrhkntnCDD
        yIK6brZ7ePIVQl0YPh4/d/S2gvX8hxu4DTn9VT7GWuOv06NPj8LbpWTmojJFT+RI
        JC9rw8zdAwl0SvJ6xu0eAorFoBoLjw7mlGvY2KPv+Rmy1UYdf243cF+Yz7VSDhU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Ututjs
        iGPDjjqTNSrr2Q3wogvxb2+FnQxQEppDmTCm95LBfnG6e9mbNuOD47+7dfPB7+in
        8QmPg7S8i31f6a5JT7Zarfjysv/QuoUwNoBEI0XnlBcUId/tmC46M+MQWxy5TGG7
        BtXQlyRShaBStz36TyXf6Q9QXdOwVWZEmaZpU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 88ED1113A97;
        Sat, 20 Mar 2021 16:04:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D42A5113A96;
        Sat, 20 Mar 2021 16:04:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v4 01/22] fsck.h: update FSCK_OPTIONS_* for object_name
References: <20210306110439.27694-1-avarab@gmail.com>
        <20210316161738.30254-2-avarab@gmail.com>
        <nycvar.QRO.7.76.6.2103191540330.57@tvgsbejvaqbjf.bet>
        <87czvuyyk6.fsf@evledraar.gmail.com>
Date:   Sat, 20 Mar 2021 13:04:40 -0700
In-Reply-To: <87czvuyyk6.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sat, 20 Mar 2021 10:16:57 +0100")
Message-ID: <xmqqr1k9k2w7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 82A5A400-89B7-11EB-B1B0-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> In other words, would you mind using the `--thread=3Dshallow` option i=
n the
>> future, for better structuring on the mailing list?
>
> Not at all, I've set it in my config now.
>
> I've just been using the default configuration of format-patch
> --in-reply-to --cover-letter && send-email *.patch all this time.
> ...
> So I wonder if I'm using some different process from the norm, or if
> most everyone else is just looking carefully at Message-ID/In-Reply-To
> norms before sending...

Interesting.  I always let send-email assign the message IDs and
haven't used --thread=3D<any> option at all.  In other words, my
format-patch output files have no message IDs in them or In-reply-to
header fields.  That in turn means that in-reply-to is decided not
when format-patch is run, but when send-email sends things out, it
gives them the ids and structures the in-reply-to chains.

I guess we have too much flexibility in our tooling X-<.

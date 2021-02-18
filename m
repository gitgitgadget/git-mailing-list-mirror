Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCADDC433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 22:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 739A664DA1
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 22:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhBRWgt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 17:36:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61204 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhBRWgs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 17:36:48 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A619B22C2;
        Thu, 18 Feb 2021 17:36:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=oJbjqFUhy9GS
        tJl24oL0Nq2uX2U=; b=wp7E4KPgHUBHqCqtoTQb7af4gYrXfMNU9686aVSIbkEU
        L672sVE4I71z+KbmPScvtMKuWQSfR2qzS8K6vkkcBKk3P7PCGLuOCHshoOLDR3Tu
        0oYDsdkAT056uD0vgx2HVaXF2qnacjfy3qXvFvcytqki2V0M9gmrOvINCx9agbw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ZAQGUm
        SCqLch+BvhBE1Hr9qS9XcpeTZkcQkphDpmrR/0wxfqORGuq6hP8RLmIce1Ays+F5
        O2Ua7IdBqeil9FYzUI5fyinOUoL03elHXTDReeDQ0FVJRrN8yG0DWTmuxOa9hvNf
        7OoBvAXHOCBr9ZYJ9O9gBSjeSQ+Eajkpt30TY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E32EB22C1;
        Thu, 18 Feb 2021 17:36:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 77FB2B22BE;
        Thu, 18 Feb 2021 17:36:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 00/14] fsck: API improvements
References: <87blcja2ha.fsf@evledraar.gmail.com>
        <20210217194246.25342-1-avarab@gmail.com> <xmqqo8gijtl7.fsf@gitster.g>
        <87zh028ctp.fsf@evledraar.gmail.com> <xmqqtuq9faw5.fsf@gitster.g>
        <YC7GupBLb4IoDLj6@coredump.intra.peff.net>
Date:   Thu, 18 Feb 2021 14:36:03 -0800
In-Reply-To: <YC7GupBLb4IoDLj6@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 18 Feb 2021 14:57:46 -0500")
Message-ID: <xmqqczwxc8bw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AF52FD8A-7239-11EB-B68D-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Feb 18, 2021 at 11:12:26AM -0800, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>=20
>> >> Let's get this reviewed now, but with expectation that it will be
>> >> rebased after the dust settles.
>> >
>> > Makes sense. Pending a review of this would you be interested in que=
uing
>> > a v2 of this that doesn't conflict with in-flight topics?
>>=20
>> Not really.  I am not sure your recent patches are getting
>> sufficient review bandwidth they deserve.
>
> FWIW, I just read through v2 (without having looked at all at v1 yet!),
> and they all seemed like quite reasonable cleanups. I left a few small
> comments that might be worth a quick re-roll, but I would also be OK
> with the patches being picked up as-is.

Yeah, all except for a handful minor nits looked good.

Thanks for writing and reviewing.  Perhaps a final reroll to tie the
loose ends, or is it just a matter of signing off one of them and
droping a couple of other ones (which other ones)?




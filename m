Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95F3C433EF
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 00:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BFF661052
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 00:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242793AbhIRA1S (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 20:27:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56890 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbhIRA1R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 20:27:17 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A674E26E4;
        Fri, 17 Sep 2021 20:25:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=joQQNY7nomXn
        QUdznyloJTBqe3yM1vNbTftVViC6qyY=; b=vcyg/YMZ8+izEtPcEnXUDeC+Sxz5
        mTvModvFpi4NRLao6p/I5lx7Tfu+1g0t54ta6hGf6BEwuTWZLm4ZONnK4O9q6Xft
        IZXWuhyKYkU7qmeYoQvMQVdvd2kI601PSKXbttZ2+O+6jmeBQsqIIwbsQrVktaWO
        NCyY/5RxjslrxLo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5FBE3E26E3;
        Fri, 17 Sep 2021 20:25:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8B9E0E26E2;
        Fri, 17 Sep 2021 20:25:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Jeff King <peff@peff.net>, gitmailinglist.bentolor@xoxy.net,
        git@vger.kernel.org
Subject: Re: Should `@` be really a valid git tag name?
References: <0c68d628-e093-1cbd-e3bd-38a827545418@gmx.net>
        <CAPUEspjbiNtffXatzNUUFYyZKRjcqetOTVqQX+MgZf_AJq9hnA@mail.gmail.com>
        <xmqq4kaihqjj.fsf@gitster.g>
        <YUUM5VqTEtjhnfjj@coredump.intra.peff.net>
        <YUUdjNDkL7Uy5erG@carlos-mbp.lan> <xmqqr1dmg5uq.fsf@gitster.g>
        <CAPUEspg3982Wk7vdO-vFimvyApzYwUtsryZdLt1=sLfrrYngyg@mail.gmail.com>
Date:   Fri, 17 Sep 2021 17:25:52 -0700
In-Reply-To: <CAPUEspg3982Wk7vdO-vFimvyApzYwUtsryZdLt1=sLfrrYngyg@mail.gmail.com>
        (Carlo Arenas's message of "Fri, 17 Sep 2021 17:21:49 -0700")
Message-ID: <xmqqh7eig25r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FBE24BFA-1816-11EC-9873-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> On Fri, Sep 17, 2021 at 4:06 PM Junio C Hamano <gitster@pobox.com> wrot=
e:
>>
>> Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:
>>
>> > I was leaning towards something like that plus a Documentation updat=
e, but
>> > noticed that the current behaviour was inconsistent, and the confusi=
on
>> > pointed out by Junio seems to indicate it is better if fully restric=
ted.
>>
>> That is a bad move, as existing repositories may have a ref with
>> such a name.
> ...
>> If we tighten anything retroactively, we probably should forgid '@'
>> short-hand that stands for HEAD, I would think.
>
> regardless of the merits of that feature, it has been in git since
> ~v1.8.4, so its removal will also be breaking the user experience
> IMHO.

I know, but it is lessor of two evils.

I think it is OK to forbid at the higher level Porcelain, while
still allowing read access, but keep the door open for plumbing,
just like Peff suggested.

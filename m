Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F7EC433EF
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 00:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiAVAz1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 19:55:27 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59386 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiAVAz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 19:55:26 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 43EA910CF22;
        Fri, 21 Jan 2022 19:55:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jK9aTggnXyz0
        +T8/ZxZOh3w0pY8MSbdCLNJHpEuuqmg=; b=lD8/8f1MJ4w4Ic1sSEt9pfcWL/Td
        w2oHq7/J/mYlyQXnwVe2SV/ebPsh6UgpWxwhEW+ylo3bgmh0glw6UchQvhobizUC
        cNaW8e/+PA4ZuKMWZoL3Pr0ld5izJ2LxUuguMloIDcaX0DYRyuqsrGNdWNuKtAau
        eicIrV7ckFYubcQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A5AC10CF1F;
        Fri, 21 Jan 2022 19:55:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 98FA710CF1D;
        Fri, 21 Jan 2022 19:55:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        <git@vger.kernel.org>, "David Aguilar" <davvid@gmail.com>,
        "Taylor Blau" <me@ttaylorr.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3] cache.h: auto-detect if zlib has uncompress2()
References: <patch-v2-1.1-444eacf30be-20220119T094428Z-avarab@gmail.com>
        <patch-v3-1.1-e9cb8763fd4-20220120T011414Z-avarab@gmail.com>
        <xmqqr190ekrh.fsf@gitster.g>
        <000a01d80f20$dadd0e80$90972b80$@nexbridge.com>
Date:   Fri, 21 Jan 2022 16:55:24 -0800
In-Reply-To: <000a01d80f20$dadd0e80$90972b80$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Fri, 21 Jan 2022 18:44:33
        -0500")
Message-ID: <xmqqh79wd1xf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FC291372-7B1D-11EC-8B68-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

> On January 21, 2022 6:23 PM, Junio C Hamano wrote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>=20
>> > As noted in the updated commit message this approach of having an
>> > object just for this fallback function comes at the cost of some
>> > complexity, but now the compat object lives neatly in its own object=
.
>>=20
>> I do not see any change in this patch adding costly complexity, but I =
notice lack of
>> one possible trick that might become problem with some compilers and l=
inkers
>> when their zlib has uncompress2() function.  Let's have this graduate =
very early in
>> the next cycle, to see if anybody on a rarer system sees a complaint d=
ue to having
>> to deal with a totally empty object file.
>>=20
>> Will queue.
>
> On behalf of the "rarer systems", I will certainly be putting this thro=
ugh the regression suite.
> With thanks,
> --Randall

;-) =20

I know you are on a rarer system, but I also know you need a real
replacement code in the compat object file, so your linker will not
be dealing with an empty object file.

Thanks.

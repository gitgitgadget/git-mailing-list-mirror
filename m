Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F7EC433F5
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 18:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiJGSNy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 14:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiJGSNw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 14:13:52 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D294C63FD0
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 11:13:51 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2579E145DE4;
        Fri,  7 Oct 2022 14:13:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6eEaWfzm32gY
        ia71XcyDVdbgrtDRbmXM29xwMzw3y5Y=; b=BEliwLkt4u2osWkDpHBiena69hw/
        qixVw4FxLy3MS1qR3HkS0QTeO8rWOIx5bbhaUHTq1Aj3kv29WHnlsmzENnbZfm4F
        i83OHaTE6A76Oqrblzg7YEPYFm06PHGoeTlsmiifTY86pWE1Nq4lF5fD976ywh7x
        6ZZ2idu6oEF2+ko=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1C7DD145DE3;
        Fri,  7 Oct 2022 14:13:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 81F59145DE2;
        Fri,  7 Oct 2022 14:13:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 4/5] CodingGuidelines: mention C99 features we can't use
References: <cover-0.5-00000000000-20221007T092505Z-avarab@gmail.com>
        <patch-4.5-17c2a0d88e8-20221007T092505Z-avarab@gmail.com>
Date:   Fri, 07 Oct 2022 11:13:49 -0700
In-Reply-To: <patch-4.5-17c2a0d88e8-20221007T092505Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 7 Oct
 2022 11:30:33 +0200")
Message-ID: <xmqq1qrjfqn6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CB5A9076-466B-11ED-AAD2-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The C99 section of the CodingGuidelines is a good overview of what we
> can use, but is sorely lacking in what we can't use. Something that
> comes up occasionally is the portability of %z.
>
> Per [1] we couldn't use it for the longest time due to MSVC not
> supporting it, but nowadays by requiring C99 we rely on the MSVC
> version that does, but we can't use it yet because a C library that
> MinGW uses doesn't support it.
>
> 1. https://lore.kernel.org/git/a67e0fd8-4a14-16c9-9b57-3430440ef93c@gma=
il.com/
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  Documentation/CodingGuidelines | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuide=
lines
> index f9affc4050a..893f960231f 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -235,6 +235,13 @@ For C programs:
>     . since late 2021 with 44ba10d6, we have had variables declared in
>       the for loop "for (int i =3D 0; i < 10; i++)".
> =20
> +   New C99 features that we cannot use yet:
> +
> +   . %z and %zu as a printf() argument for a size_t (the %z being for
> +     the POSIX-specific ssize_t). Instead you should use
> +     printf("%"PRIuMAX, (uintmax_t)v); These days the MSVC version we
> +     rely on supports %z, but the C library used by MinGW does not.
> +

Good.  s/; These days/; these days/, though.


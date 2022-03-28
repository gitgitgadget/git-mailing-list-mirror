Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7C9C433F5
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 20:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbiC1U7I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 16:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiC1U7I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 16:59:08 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08466B0B0
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 13:57:26 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 42F3A12F6BC;
        Mon, 28 Mar 2022 16:57:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NCu/fF0wyreW
        odzpgBD7ovZtnV2h3QEO9WRgiGZo+UE=; b=A+PfLOFgobyWRGabsTHCXcMZ+Fb1
        iOQ72bBHEIHfFsmlJBiYlUmMmypiTuDbBHJVGoKz/0f1mG5jO4EvTvoQQG5oTa/o
        yqBsRmY7gOVt6AJJR9+028W5Gws/BBFpxGepfiRdYMg/uAhvQkdsH8wtUg4IdNBy
        UeXhTBZyU84X7cE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3B0AE12F6BB;
        Mon, 28 Mar 2022 16:57:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 93F7112F6B9;
        Mon, 28 Mar 2022 16:57:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH] reftable: make assignments portable to AIX xlc v12.01
References: <c052b97e-e788-f63a-15c5-b1fbb6a480e8@web.de>
        <patch-1.1-98267695418-20220328T190642Z-avarab@gmail.com>
Date:   Mon, 28 Mar 2022 13:57:24 -0700
In-Reply-To: <patch-1.1-98267695418-20220328T190642Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 28 Mar
 2022 21:10:04 +0200")
Message-ID: <xmqq4k3h23t7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ABDDEECA-AED9-11EC-B7FE-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/reftable/generic.c b/reftable/generic.c
> index b27d152e89a..57f8032db94 100644
> --- a/reftable/generic.c
> +++ b/reftable/generic.c
> @@ -130,7 +130,9 @@ int reftable_iterator_next_ref(struct reftable_iter=
ator *it,
>  {
>  	struct reftable_record rec =3D {
>  		.type =3D BLOCK_TYPE_REF,
> -		.u.ref =3D *ref,
> +		.u =3D {
> +			.ref =3D *ref
> +		},
>  	};

Having to do this does *not* look so bad.

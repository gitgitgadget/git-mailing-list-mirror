Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77973C433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 21:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57F1161107
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 21:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243301AbhIWVfJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 17:35:09 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64506 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243292AbhIWVfI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 17:35:08 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9D31114B684;
        Thu, 23 Sep 2021 17:33:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lm0XRojAjRZm
        I3xJUavBmGP/A/GhzvS13q8TWGoZErg=; b=WheE8645S5pGPLYTvB43hBgwlt0J
        4xIHcXEQb6wuTDGqBy/Yno2Ij+aUBuk6Ec2npwQ0oT8xA7kAGC064dQNl5g4WrgA
        TSXszlozWlxzyxPJZ9Om1ZIePfUMUAC8UKz1cQBf9HvHwgNjUS1UPrr1FPytaPtL
        3s5bgqrsQLrFGrA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 94FDB14B682;
        Thu, 23 Sep 2021 17:33:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EA42114B680;
        Thu, 23 Sep 2021 17:33:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 2/2] Makefile: pass -Wno-pendantic under
 GENERATE_COMPILATION_DATABASE=yes
References: <patch-1.1-6b2e9af5e67-20210922T103749Z-avarab@gmail.com>
        <cover-v2-0.2-00000000000-20210922T220532Z-avarab@gmail.com>
        <patch-v2-2.2-6b18bd08894-20210922T220532Z-avarab@gmail.com>
Date:   Thu, 23 Sep 2021 14:33:32 -0700
In-Reply-To: <patch-v2-2.2-6b18bd08894-20210922T220532Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 23 Sep
 2021 00:08:02
        +0200")
Message-ID: <xmqqzgs3x9hv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E778CF9C-1CB5-11EC-A759-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The same bug fixed in the "COMPUTE_HEADER_DEPENDENCIES=3Dauto" mode in
> the preceding commit was also present with
> "GENERATE_COMPILATION_DATABASE=3Dyes". Let's fix it so it works again
> with "DEVOPTS=3D1".
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Makefile b/Makefile
> index 10ea12aae21..94b116d4b37 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1304,6 +1304,7 @@ endif
> =20
>  ifeq ($(GENERATE_COMPILATION_DATABASE),yes)
>  compdb_check =3D $(shell $(CC) $(ALL_CFLAGS) \
> +	-Wno-pedantic \

Yup, I like reusing the same approach from the other fix;
removing $(ALL_CFLAGS) may work fine, too, and that is what I
already queued, but I may swap it out with this later (if I do not
forget, that is).

>  	-c -MJ /dev/null \
>  	-x c /dev/null -o /dev/null 2>&1; \
>  	echo $$?)

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CFEC433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CA2C64EBD
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbhCQSvB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:51:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62090 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbhCQSuo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 14:50:44 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A8C68A3DBE;
        Wed, 17 Mar 2021 14:50:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MDc5/WiQ4GaV
        xurt0Jql+oe0isc=; b=N03Wc2mV5NX5/NFV6XDAa3xPrqIWqVDS+wd8YIHuMWjp
        JT6WiejOTrDfcu0m6505pKUPGj7f+VcYJaJ8YRCPRAGeCsCukKQ8nUEiY9wFcycD
        tDgK06ud2Qqg/G/ihziXDtr1bVbXWC1ShB7KVVtwbXEZ4WNtzO5IZH3Da0MC9KU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=mQU4/z
        zG8zuRHD+y69u0O11f3HuMjkLIs+McIHSUustMaI5zqNCYGj80/CJ53dUPIoLSgR
        +FyqnNGxddvflnEUgS4lma0WLllayw41sBvpt8VzvMtGgGKHQrmkNA2Slxshqeqx
        wQI+PWAjHvmPf8yfcc/J3TohKQkXFs9YvQhu4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A040DA3DBC;
        Wed, 17 Mar 2021 14:50:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2FE80A3DBB;
        Wed, 17 Mar 2021 14:50:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v4 12/22] fsck.h: re-order and re-assign "enum
 fsck_msg_type"
References: <20210306110439.27694-1-avarab@gmail.com>
        <20210316161738.30254-13-avarab@gmail.com>
Date:   Wed, 17 Mar 2021 11:50:42 -0700
In-Reply-To: <20210316161738.30254-13-avarab@gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 16 Mar 2021 17:17:28 +0100")
Message-ID: <xmqqk0q5vcl9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AD287A4E-8751-11EB-BECB-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the values in the "enum fsck_msg_type" from being manually
> assigned to using default C enum values.
>
> This means we end up with a FSCK_IGNORE=3D0, which was previously
> defined as "2".
>
> I'm confident that nothing relies on these values, we always compare
> them explicitly. Let's not omit "0" so it won't be assumed that we're
> using these as a boolean somewhere.

Do you mean by "compare them explicitly", we always compare for
equality? =20

If the code had depended on constructs like "if (msg < FSCK_ERROR)",
this change would break badly.

> diff --git a/fsck.h b/fsck.h
> index 2ecc15eee7..fce9981a0c 100644
> --- a/fsck.h
> +++ b/fsck.h
> @@ -4,11 +4,13 @@
>  #include "oidset.h"
> =20
>  enum fsck_msg_type {
> -	FSCK_INFO  =3D -2,
> -	FSCK_FATAL =3D -1,
> -	FSCK_ERROR =3D 1,
> +	/* for internal use only */
> +	FSCK_IGNORE,
> +	FSCK_INFO,
> +	FSCK_FATAL,
> +	/* "public", fed to e.g. error_func callbacks */
> +	FSCK_ERROR,
>  	FSCK_WARN,
> -	FSCK_IGNORE
>  };
> =20
>  struct fsck_options;

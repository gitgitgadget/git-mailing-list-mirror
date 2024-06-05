Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4B779F0
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 18:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717611471; cv=none; b=SUYyiXYKM4NrRt8RRjonZd22WYiX3cQkmmzok99796ekfU0EsD8n1dTVFEqCEL2kOKj03DPiUGlnfE4vViNAdfKUgW7oQOdKMmadhTvr43zq8J7L6K2I7dIS6Kf4zR2ckhN1DENrmCcm2Paoh53QGUM8w50Gd+oggNvh/6Vj2Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717611471; c=relaxed/simple;
	bh=cFoB5UV/PS5ZX4aNNJ7I1glDRrxFxuDhyDc4rjjrhCE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hp3meIGNKq7U5uDCaQXTc+eq0uP8aYQEBswDhGlILkkAyBEHrREXiGEACrZjws7xB7ujOJrzVTzckzYRJDJZawuKm6MGRIquQxn5sSG4ncDsPQBiSIqBKFTnSTXQtyFr0ELm04ZS1V9DJQoPJ4I8U5cEFVoqTTRLLgiK9lplHlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xzCQMExW; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xzCQMExW"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F3B001ED49;
	Wed,  5 Jun 2024 14:17:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=cFoB5UV/PS5Z
	X4aNNJ7I1glDRrxFxuDhyDc4rjjrhCE=; b=xzCQMExWpW8sA2xW9IAWIwWUP8AK
	ADpfPjZZI0ww2i+0KB5Yulx3jr6ABi0ZuIJDFn6iVXA/CyxJkfNIh8QjlGwhTGCe
	vAQaxxC4Xd6mqHInnGDOsgzajrGFF1tfMFglqHyNMUB0G9INdDFtVTI6IyCuQB5s
	nGWZwvHTSwHqXQk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EC32A1ED48;
	Wed,  5 Jun 2024 14:17:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5D2B21ED47;
	Wed,  5 Jun 2024 14:17:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] format-patch: assume --cover-letter for diff in
 multi-patch series
In-Reply-To: <14365d68-ed04-44fe-823b-a3959626684e@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Wed, 5 Jun 2024 20:01:21 +0200")
References: <6269eed5-f1ff-43f3-9249-d6a0f1852a6c@gmail.com>
	<14365d68-ed04-44fe-823b-a3959626684e@gmail.com>
Date: Wed, 05 Jun 2024 11:17:46 -0700
Message-ID: <xmqqbk4fs185.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 E9DD6566-2367-11EF-8871-6488940A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> diff --git a/builtin/log.c b/builtin/log.c
> index c8ce0c0d88..8032909d4f 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -2277,6 +2277,8 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
>  	if (cover_letter =3D=3D -1) {
>  		if (config_cover_letter =3D=3D COVER_AUTO)
>  			cover_letter =3D (total > 1);
> +		else if ((idiff_prev.nr || rdiff_prev) && (total > 1))
> +			cover_letter =3D (config_cover_letter !=3D COVER_OFF);
>  		else
>  			cover_letter =3D (config_cover_letter =3D=3D COVER_ON);
>  	}

Interesting.  So those who really really hate cover letters can set
the configuration explicitly to 'off' and giving an --interdiff
option would still have the sanity check kick in.  Makes sense.

> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> index 7b05bf3961..5af155805d 100755
> --- a/t/t3206-range-diff.sh
> +++ b/t/t3206-range-diff.sh
> @@ -545,6 +545,12 @@ do
>  	'
>  done
> =20
> +test_expect_success "format-patch --range-diff, implicit --cover-lette=
r" '
> +	git format-patch -v2 --range-diff=3Dtopic main..unmodified &&
> +	test_when_finished "rm v2-000?-*" &&

I was about to make the follwoing:

    Swap these two.  Arrange things we are going to create to be
    removed at end, and then start creating them.  That way, we will
    clean them up even if we fail after creating some but before the
    end of the command.

but this one is littered with exiting breakage, so I'll let it pass.
Somebody will later go in and fix them all (#leftoverbits).

> +	test_grep "^Range-diff against v1:$" v2-0000-*
> +'

Isn't the name of the cover letter file always cover-letter.patch
unless you configure a custom --suffix (which is not the case here)?

> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index ba85b582c5..c844fbfe47 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -2492,6 +2492,12 @@ test_expect_success 'interdiff: solo-patch' '
>  	test_cmp expect actual
>  '
> =20
> +test_expect_success 'interdiff: multi-patch, implicit --cover-letter' =
'
> +	git format-patch --interdiff=3Dboop~2 -2 -v23 &&
> +	test_grep "^Interdiff against v22:$" v23-0000-cover-letter.patch &&
> +	test_cmp expect actual
> +'

OK.

>  test_expect_success 'format-patch does not respect diff.noprefix' '
>  	git -c diff.noprefix format-patch -1 --stdout >actual &&
>  	grep "^--- a/blorp" actual

Looking good.

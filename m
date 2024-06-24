Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7709519DF53
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246081; cv=none; b=mB8vadxtshtCDKmjXyJ6gGv2pHcFhu4mnPDr/z8/3/DiyDj2cB48E55HWH1ffTbsPJq8WiiIe7jhGzSP8zMSjbKRCpLNloD7ef6faAY3kr9RReMcMXGlNtoFGWOhKoCbNdULznoI1fYo0Gg5yXXtYUFEskRjc4Com/oF+BPMm6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246081; c=relaxed/simple;
	bh=udjmSE7iDMYdQJiUFRFtSBbXCdfz00yAci1//zNufYQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WnExKMR2Gp9370Y1rLzRBuySWBoQLBNbcVCrSgHvTsubgXP9Af7zZWbcczgj/5EXgF9uiyjmlANR/c0or183WUDN92q7VLZ4sJrQxc+mjX5gHB84iyryIaQpDNFpUKSnhGtyjPxBN4xKhsq2n3xe2UJGtDAz7ciyegephJzZXRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=UzYY41iO; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UzYY41iO"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 12D482F61B;
	Mon, 24 Jun 2024 12:21:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=udjmSE7iDMYd
	QJiUFRFtSBbXCdfz00yAci1//zNufYQ=; b=UzYY41iOYeGAuZ6BuaHPlIJEQ4fN
	pi6FeVd/bkni7gmKFIvPbaobFHRwiCGmpm4LOTMuB+VHMzT874hcYPf+CKCYMHGh
	JJSTw7Mxz9Psq8IoGt6+KZ2ub1HAHWQlfHJcsIBmzihOchDbR+yLytbretZFZ6t9
	x+9QDQzdyIPt4Ss=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 097A32F61A;
	Mon, 24 Jun 2024 12:21:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2E5EC2F617;
	Mon, 24 Jun 2024 12:21:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: lolligerhans@gmx.de,  git@vger.kernel.org
Subject: Re: [PATCH] diff: allow --color-moved with --no-ext-diff
In-Reply-To: <8a8bd51e-9ce5-4a68-bfbe-f16dcbb7e89c@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sat, 22 Jun 2024 21:41:30 +0200")
References: <trinity-acbdb8fc-3dc3-4dca-890c-8bcb37405782-1719050465639@msvc-mesg-gmx004>
	<8a8bd51e-9ce5-4a68-bfbe-f16dcbb7e89c@web.de>
Date: Mon, 24 Jun 2024 09:21:15 -0700
Message-ID: <xmqqsex2cnwk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 C8A35256-3245-11EF-9F8E-DFF1FEA446E2-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
> index b443626afd..a1478680b6 100755
> --- a/t/t4015-diff-whitespace.sh
> +++ b/t/t4015-diff-whitespace.sh
> @@ -1184,6 +1184,15 @@ test_expect_success 'detect moved code, complete=
 file' '
>  	test_cmp expected actual
>  '
>
> +test_expect_success '--color-moved with --no-ext-diff' '
> +	test_config color.diff.oldMoved "normal red" &&
> +	test_config color.diff.newMoved "normal green" &&

We are making sure we won't be affected by previous tests.  We
assume that we did not set color.diff.{old,new} to these two colors,
but that would be an OK assumption to make.

> +	cp actual.raw expect &&

But then this introduces a dependence to an earlier _specific_ test,
the one that created this version (among three) of actual.raw;

If we did this instead

	git diff --color --color-moved=3Dzebra --no-renames HEAD >expect &&

it would make this a lot more self-contained.

> +	git -c diff.external=3Dfalse diff HEAD --no-ext-diff \
> +		--color-moved=3Dzebra --color --no-renames >actual &&

Also, please do stick to the normal CLI ocnvention, dashed options
come before the revs, i.e.

	git -c diff.external=3Dfalse diff --no-ext-diff --color \
		--color-moved=3Dzebra --no-renames HEAD >actual &&

Our tests shouldn't be setting a wrong example.

> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'detect malicious moved code, inside file' '
>  	test_config color.diff.oldMoved "normal red" &&
>  	test_config color.diff.newMoved "normal green" &&

Other than that, looking very good.

Thanks.

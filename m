Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7B73770C
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 20:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721680896; cv=none; b=lSstw/1ZbqLrXZ2mAYF/CrmkuR+l8z2SC39XrzbsErHU5vrVgy+Qu7PYn54UEdiyaMOSVm3YrEjNWxiBTZ80uWNrAEFmQ0R42onr/tMkgkN6NpHWnMJ1POxBf6B4m6J3luytGih5pDM2z/Tw3Ai47hl8yOoQ4i/n55bBO0l7p+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721680896; c=relaxed/simple;
	bh=NKu8BoUxCPeXUsXGojWLJYrmCtxGaMbr6mTMpW0Lph4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bRgsQTBNytyJ7PpmipkMzvODMuu54UeCcSGPB6+2xnVdPCB1ayItaxplFszvBYKQNk8vh6L3sbKQlbpBeOIUCvVu5cAddGnVvUvkzPbCScGh7sGxB0qBgSA+XxySVApbdfleDvySCxTWsl5tTmKK+w940FBsDwkYOKND84Rz4WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OVVtLzJP; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OVVtLzJP"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6753922449;
	Mon, 22 Jul 2024 16:41:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=NKu8BoUxCPeX
	UsXGojWLJYrmCtxGaMbr6mTMpW0Lph4=; b=OVVtLzJPQVcpxbiY1667yFlzKrHR
	q4QR0+3mWN1ZEQVQgPW2EA0YFDTEmRhazd3rvz6VbJwHFow/lpgzkeFBILY6Cz/n
	tYTHfXF+gOzHzzOF2cF7tWTt17j82wUFYSr99LsKiH3UhXsZ8jqtTCGaC67BSoEb
	nVRW86O8NiDq0MY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F09E22448;
	Mon, 22 Jul 2024 16:41:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BF0F022447;
	Mon, 22 Jul 2024 16:41:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Kyle Lippincott <spectral@google.com>,  Git List <git@vger.kernel.org>,
  Phillip Wood <phillip.wood@dunelm.org.uk>,  Josh Steadmon
 <steadmon@google.com>
Subject: Re: [PATCH v2 2/6] unit-tests: add for_test
In-Reply-To: <be282096-49af-4d83-b5f7-8b4f1b447edb@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Mon, 22 Jul 2024 22:31:48 +0200")
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
	<da7ed537-1c8e-42ec-aa91-49e1319e8c68@web.de>
	<2dff757d-3c5d-4923-97df-26bcb1c21230@web.de>
	<CAO_smVhoobWpsbYHnHJqTj7TJJ1udo_UaGdbOnUqe5jzL+tyaQ@mail.gmail.com>
	<xmqq1q3lb4me.fsf@gitster.g>
	<be282096-49af-4d83-b5f7-8b4f1b447edb@web.de>
Date: Mon, 22 Jul 2024 13:41:32 -0700
Message-ID: <xmqqwmld9n2b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 C86C1B0C-486A-11EF-AF6C-34EEED2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>>> And the issue won't be caught.
>>
>> You are right.  Making an empty body somehow catchable by the
>> compiler would be a vast improvement.
>
> That would be nice, but I have no idea how to do that without compiler
> changes.

Me neither.  I was trying to nerd-snipe Kyle into coming up with a
solution ;-)

> In the meantime the existing runtime checks will catch both
> the empty test in the first line and the out-of-test check in the secon=
d
> one and report them like this:
>
>  # BUG: test has no checks at t/helper/test-example-tap.c:75
>  not ok 1 - for_test passing test
>  Assertion failed: (ctx.running), function test_assert, file test-lib.c=
, line 267.

Nice improvement, I would say.

> diff --git a/t/unit-tests/test-lib.c b/t/unit-tests/test-lib.c
> index 3c513ce59a..9977c81739 100644
> --- a/t/unit-tests/test-lib.c
> +++ b/t/unit-tests/test-lib.c
> @@ -264,7 +264,11 @@ static void test_todo(void)
>
>  int test_assert(const char *location, const char *check, int ok)
>  {
> -	assert(ctx.running);
> +	if (!ctx.running) {
> +		test_msg("BUG: check outside of test at %s",
> +			 make_relative(location));
> +		return 0;
> +	}
>
>  	if (ctx.result =3D=3D RESULT_SKIP) {
>  		test_msg("skipping check '%s' at %s", check,
> --
> 2.45.2

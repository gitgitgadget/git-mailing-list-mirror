Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3232230C
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 09:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709543844; cv=none; b=buVTR4Uz3Aec4BsxxDOAXvdYwQpI9lSpUK/c+HJo2Z09mwWtr8aqW//z1S4dgbioYrnn//qMHJqbj/FsxU0Ub31k0RLyjmjqjMEJup6Kv4unli9Mvf4Le1Y5K530tuffaup+r00Yb5TQnyFhDCTp/ilqhBavoXLTTaJQ0Y71bQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709543844; c=relaxed/simple;
	bh=hHXkv2ZPr1gqA+50ExcRdXerQP4praSjpVjhTwAhx44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1agQ3DoSC46+IANpQrfZhcgWTwNCf5dxrAtcBRs0JeWIMjEMxex3jjznKFuknsqLa7G0ntfmB+4OiCHwf7dXECkppLg6yQxOkIten3TdJdZ7d5TjGC4eflpj6H9OuCAgHSqqFzqtrSLIPVMbj6e1Q9zXmpTCrIpUzIKxPWux1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M988x7wS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VW2AymQ9; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M988x7wS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VW2AymQ9"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 06F211C0006E;
	Mon,  4 Mar 2024 04:17:20 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 04 Mar 2024 04:17:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709543840; x=1709630240; bh=7M5FUoZ8+s
	e5InIbKFgj4H3/75W4wRf/QqbMcbbwpkg=; b=M988x7wSGpCRjVgydJyWxMxU4b
	StsMFCbI8Tty5yI5UbXt6kngbIrljImtxT5YuxU6Siwm/sSCMMZENxNMrHL7j3ML
	W7G45GIotpe8RoZztSiiemrPdx974zKA0zGt+KH7w2u+JacfXosDWaB3zB/ZFQa/
	QFvAWsl/N3wIvbD9Kfdof3T9dW0klcvujFP5JNycJsmCLwXko87F/gpurI5hX/Hk
	MLFcZBL2w/BDBZiGydZ9p1zoCz3XUVGxsNvyFuwL55PiMl8+QH5UQZe6LM/57gPt
	hOitWfmc8BOyUhO9bS3GFfp+S0Wq5+afnRTLYXux/0606xbIZ31ENbzIazcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709543840; x=1709630240; bh=7M5FUoZ8+se5InIbKFgj4H3/75W4
	wRf/QqbMcbbwpkg=; b=VW2AymQ9TsVCAFZlYSrK5Vid2q85yoQa34I7XdJ3oAIX
	6gM2Nx20tExmOUMBWxbdwjfz2YyZkatwnHmyyYD9PIIBofyI47VurXSm3ZsBVg2g
	3JQtntFb1NE2Tas02BvqQArg7O8aTcUSuWTI6VGhsKk/wIKXEWE2kpmDf5qUv3Ue
	1+vbanmj0FfvNqrWTyf5dzFf5OF5dC1vd4cnuGhew/GU41EXgHAO7xycqB1UR8RV
	uE/4dXnEQwdgGCraoRUCQQl/XCzjYeZg6+7aiNJGwe1xZnkkea7e5OKgppPBEDza
	4vgPWDOf8wvKWY0LkoH4ufZGojbvF9YHkgWXXoCukg==
X-ME-Sender: <xms:oJHlZYxX61XeCxRmzwMxFbW1W3iU1VMq6WQQdNgrSKXn0K2KPnDdgg>
    <xme:oJHlZcQq4mrayp3xNqPYEB9jU4atooGOGcmXfc7rnmed12rTMzDYE7Klo7beF7c0k
    iyYEecq6DopE9MWZA>
X-ME-Received: <xmr:oJHlZaWlyBD5gVPzBQFjisxbmN3YY-0-VDXgg_hpEZ3HVYtzIoh37sDVLSXwEsEe6itAWdcI8sVPEXyUVpES6K0GOSOkZPBVJuotgJ1xI2mfzAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhush
    hpvggtthffohhmrghinhculdegledmnecujfgurhepfffhvfevuffkfhggtggujgesghdt
    reertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhsse
    hpkhhsrdhimheqnecuggftrfgrthhtvghrnheptdefledvkeelueefveffjeeijeefheei
    jeekfedtleejhfetvedugfefjefgjeehnecuffhomhgrihhnpehgihhthhhusgdrihhone
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehp
    khhsrdhimh
X-ME-Proxy: <xmx:oJHlZWgxQHmp1_E0C5rum1SOpA6qSQHgCakKj_m51L1zllW7nEleZw>
    <xmx:oJHlZaA93ERWqqojEyA2WJMtf3g3sAb6kn7JkR53uQwwkdPonfsDiA>
    <xmx:oJHlZXKZikHt6k3JSfaiWL2Sy3siMp222dYWLICl_GrDLNXOtBEr6Q>
    <xmx:oJHlZd8zGGkHjr6IlEcKY0dyAguHEDYRrRs74GuOsS15gxDXAwveg8uMaAk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 04:17:19 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f2947282 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Mar 2024 09:12:53 +0000 (UTC)
Date: Mon, 4 Mar 2024 10:17:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] [GSoC][PATCH] t3070: refactor test -e command
Message-ID: <ZeWRnGSU-eZq8WyE@tanuki>
References: <20240229150442.490649-1-shejialuo@gmail.com>
 <20240229150442.490649-2-shejialuo@gmail.com>
 <CAPig+cR2-6qONkosu7=qEQSJa_fvYuVQ0to47D5qx904zW08Eg@mail.gmail.com>
 <xmqqzfvjf5tq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MvAkDmMBIrr53PBv"
Content-Disposition: inline
In-Reply-To: <xmqqzfvjf5tq.fsf@gitster.g>


--MvAkDmMBIrr53PBv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 11:06:41AM -0800, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>=20
> >> @@ -175,7 +175,7 @@ match() {
> >>         test_expect_success EXPENSIVE_ON_WINDOWS 'cleanup after previo=
us file test' '
> >> -               if test -e .git/created_test_file
> >> +               if test_path_exists .git/created_test_file
> >>                 then
> >>                         git reset &&
> >
> > ... which _do_ use test_path_exists() within a `test_expect_success`
> > block. However, the changes are still undesirable because, as above,
> > this `test -e` is merely part of the normal control-flow; it's not
> > acting as an assertion, thus test_path_exists() -- which is an
> > assertion -- is not correct.
> >
> > Unfortunately, none of the uses of`test -e` in t3070 are being used as
> > assertions worthy of replacement with test_path_exists(), thus this
> > isn't a good script in which to make such changes.
>=20
> It seems that there is a recurring confusion among mentorship
> program applicants that use test_path_* helpers as their practice
> material.  Perhaps the source of the information that suggests it as
> a microproject is poorly phrased and needs to be rewritten to avoid
> misleading them.
>=20
> I found one at https://git.github.io/Outreachy-23-Microprojects/,
> which can be one source of such confusion:
>=20
>     Find one test script that verifies the presence/absence of
>     files/directories with =E2=80=98test -(e|f|d|=E2=80=A6)=E2=80=99 and =
replace them
>     with the appropriate test_path_is_file, test_path_is_dir,
>     etc. helper functions.
>=20
> but there may be others.
>=20
> This task specification does not differenciate "test -[efdx]" used
> as a conditional of a control flow statement (which should never be
> replaced by test_path_* helpers) and those used to directly fail the
> &&-chain in test_expect_success with their exit status (which is the
> target that test_path_* helpers are meant to improve).

Good point. I've sent a patch in reply to your message that hopefully
clarifies this a bit. Thanks!

Patrick

--MvAkDmMBIrr53PBv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXlkZsACgkQVbJhu7ck
PpRvTg/9Fxn0zGaOfaj8TZz0fMSH/SpevhLm9LGmszwIaRCNZolVdPXcnyged/je
S86ZsnQa6hUfs9YeoYXs3mK1Kze8jnDeu9krS/tOYSBDdB6059ya8BJZxvduT6i4
S3xm84m4xDgzaRfIR8W+Sq8+Ez1Vmy5xIjShnRxgaK6+IVPz3W67mkuZyXdwKNIu
2GD/BSW9gA/SEkKPIbN0BV9w8VbGtOF4X5GGVaAkIetA2lzSTiE8+his2PjhGofN
AfaNIj51n1tuxrDj2GK4kh92vavdKzuKPOj7X/qXHd+k8EHJ79lH8RIu8OUupyC0
xrTBHoBK/apYt0xjdGIV+gV+fnPW/qBF566QjYxkd+Wzftrl9DYlB9rpJf7FVfEv
L4wsxxRxGw4K/Ai8MGmSQaYhxEd3Q6OD2C5Y1wOg94jA719QTl2ICesNi2fZ284R
Z7K112HnFsvP3a2CJ6v86Zj+gknt3LqWA4RMGLTC3yolKb4hejURe+Yh2ku/UQHH
crGOumIwkuKmRXEQfoRKy+n8IXn28OU1BC7TJCGe5OhIiW7kO9UXPZrge6/vajbl
C2dizyg/toil7Ttr/Ey4wqSPUMXnWFJAYmKrame05HkG7OmSpL40/ba6RKApbiYF
Qd3KT82bD+dPWwJQSECBChy9vkfynlKt1zFT4Nt4Nf7LyArREr4=
=+2sP
-----END PGP SIGNATURE-----

--MvAkDmMBIrr53PBv--

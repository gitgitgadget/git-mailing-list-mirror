Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3017181F
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 06:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709793089; cv=none; b=P/K2xmSKex/LLddscYhmdbTqL1Rv0suud4oSmpX6cDEymceITX28kMM9258hx5NGFRggapDFERMKXgC8D3ewnWCgmgPHJWYd32IVoQZCg8AHZtm5uEzox8YDJI32ZigXkWHr//psELlkbWx/7PEjfzyVA+3Nf/S5t5lisAyvKTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709793089; c=relaxed/simple;
	bh=6orrKtZdf2WfXEn/3zpoeZj/SqLVmiMRUuTv6VLyBVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjxDU2oGGGVxiJTHSO0MHMSXuHCK/7K6xSMaBmWEm/ZnvekKs7TQrBao+5DsLSXlOUsbwCrUWDY23sfV78l+mJh1EDI2gZb9yIyso4xHUValx+nf9e7DTBTLm/GAGMZ9/TRT+K130p5OcUov5bG676Ss4uWbWo64MJ5TYQPdzK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Pycmjmj4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AZlUw+ej; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Pycmjmj4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AZlUw+ej"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 033441C0007E;
	Thu,  7 Mar 2024 01:31:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 07 Mar 2024 01:31:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709793085; x=1709879485; bh=aY8BFhf5mp
	l0jFiuRpvOSS5FZsfoXJopfpvU5ZsCMOw=; b=Pycmjmj4d0esgfxQeKo/s+wBWy
	KeE+Ai5GuIeawVJHlKJjUzv2b5MSu9PAsfYuQCPdszs0/ZbKfKxl0Z0aaUh1hWo9
	qCl2dxcwCYJDtEiZfQA7XwRufGpx0qRt2YJKtpkKjobkpeZ+tyesm1r3W+/vD6AC
	zbDWjpzfvv3oqIeJe3rsEdjR6jFO0cpDc0z7Za5HdgWPPgG2CSaeVXCg5K7PtklC
	pAXyOgdos2XzjkYZyjd2ZxSVlh0ED42Qv3xP4ffJa0MgleRCV43Kk9y5mEbGiWeS
	wdGfJdrSL/mHtsUSFZW4UDrNYmtMd50QJjgXHHm3LcxczwlzYqwKkqubYMUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709793085; x=1709879485; bh=aY8BFhf5mpl0jFiuRpvOSS5FZsfo
	XJopfpvU5ZsCMOw=; b=AZlUw+ejJv7/nSyjZn513ttU6UPs1KbaBJj5g7olx7o0
	iyvTHNVmB0Cb7l5udpixTn4Pe/zUhnjDXklI2kDt7ziVRf6CdbR89jXt8psBS8bw
	DtPYOqSWq+syi/FSYlkqjmjNBqC3WLmYQf8SP9a5PIw5jI2JiXoV5k1aspWmVUR+
	NS3tV/8BXlOgO5uZycbRjiHQS5m4ZUmmr71iPFbgmBv/+uUhd73tniUQl3+1FoAn
	pfSS2D3PUeGvo9CQ3WVDOAAnJt3T9if5Tm96XxeRdP6rNTUQN52vjVeL1BNSR8O/
	GDz+YxeZc8Beg755uzFzFh/cOfFgwg9KUYKrGEtrBA==
X-ME-Sender: <xms:PV_pZUYfQC6kIxda3dosLdxsJ_oy0LxUv9z3usB60RXA8bu_F7a_KA>
    <xme:PV_pZfZQ5B2idQ9Y6k-ic3VUfkc4-JyDUUqE-7iX1OYKu0JG4h0sKDEftuzWcPWa8
    YbsUSB0d7D46I4yiA>
X-ME-Received: <xmr:PV_pZe_UG8mRNTm70AiS0FWPHq4ZLHVoBBURHNygNoAIm_wr86jJRX9vI84lSHAYYa-SnD28JRkKJ_PUy5SmZ8OWwPkWe59yBFeDitM5yyZWhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedvgdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:PV_pZerPX3XiKh2hd7FX0Uk_ecM7FahQPtyjIbNFAEAfgU8WqDqyjA>
    <xmx:PV_pZfqGk-JVzijXaZwqAEOWji0rFMfA0lyYr47rGcNsm0i28wvAqw>
    <xmx:PV_pZcSwc79u-ISz_tUy-uay6EwB593Z5uwVgo9iNyfys1Wxiih7OA>
    <xmx:PV_pZeXqr7aVx41FxUz6jaAy4cpyZAIBBhqi-4CVbMAHj0GODc7fhEv-Uu8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Mar 2024 01:31:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b2c19f5d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 7 Mar 2024 06:26:52 +0000 (UTC)
Date: Thu, 7 Mar 2024 07:31:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/8] builtin/config: introduce subcommands
Message-ID: <ZelfOQ-XvvOpaOzi@tanuki>
References: <cover.1709724089.git.ps@pks.im>
 <xmqqil1zs327.fsf@gitster.g>
 <ZekAWSqr9qb8FIAD@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cs9THzO6WLhoBYGS"
Content-Disposition: inline
In-Reply-To: <ZekAWSqr9qb8FIAD@nand.local>


--cs9THzO6WLhoBYGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2024 at 06:46:33PM -0500, Taylor Blau wrote:
> On Wed, Mar 06, 2024 at 09:06:08AM -0800, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> > >   - `git config --get-urlmatch` -> `git config get-urlmatch`.
> >
> > ... is a Meh to me, personally.  I'd not actively push it
> > enthusiastically, but I'd passively accept its existence.
>=20
> I don't have strong feelings about this, but I wonder if `--urlmatch`
> (or `--url-match`) might be an argument to the "get" mode of this
> sub-command instead. Something like `git config get --urlmatch` feels
> much more natural to me than `git config get-urlmatch`.

Agreed. I allude to this somewhere in the patch series that I only see
this as a first incremental step, and that some of the subcommands
really should be converted to become options eventually. Specifically:

    - `git config get-urlmatch` -> `git config get --urlmatch`

    - `git config get-regexp` -> `git config get --regexp`

    - `git config get-all` -> `git config get --all`
=20
    - `git config set-all` -> `git config set --all`

    - `git config unset-all` -> `git config unset --all`

I didn't yet do it as part of this patch series because I didn't want to
make functional changes at the same time (well, except of course for the
introduction of subcommands). But if we all agree that this patch series
is something we want _and_ that we don't want to have an intermediate
step with the above somewhat weird subcommands then I would be happy to
pile onto the series.

I wouldn't think that keeping this intermediate step would be too bad
though. While we would eventually omit the above subcommands, the infra
to keep them around needs to stay anyway to support old syntax like
`--get-all`. Thus, we can keep the subcommands themselves almost for
free even if we eventually decide to hide them and replace them with
flags.

Patrick

--cs9THzO6WLhoBYGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXpXzgACgkQVbJhu7ck
PpS/nQ/+NohO1P7jdpLAW0sbVuLPEOnOD7BIJn/nU0fWGoNBd5CPhb7oM7SGv/SO
9g2Wd38F/6d/rNU4XXGZbzDvPsb9Ps8vdPndErtboJ9his/ubZGe4sQSOt2EizoY
WVbwTGOn1za8Tbt5VoEh8YAhAVqWYTybnL38KM4wcf8tSRgRSoOmc9kVcECLlwnn
SuogddwCJF+N/3G87vC+puJ7VK2X0lIfa6XrWcOizZjqzXhvZ6Td3YJ2gKfLaLNg
DUPYLLAPLl2DyffGWaVvT6sd2E1pdopt9p/1znwY2QSuZQWj/SbY4ZtfOgRk/15n
tEsYuFoKYqqZxnYQN0Y8JGOkVhDi1ogjBQGfiRbP8Ptqs2WImZFjKeS8RhVc1AQ3
L+SSAAmzmu+kbFDrM0D3/rwPGMpesA2qJ7uCl/xFzK6Bdpy+JrbnIsPveD9DwjID
2D/Kp3ZPRiLDUWhtldtn/W7etH8sdyplf2+TIsVzUCeSDprIgLvaqc8aarpCTw3m
AQAA+7tl1OQ/kwPmbgLbo2rxmdw91Uf8Rl1cEHV/bjlq1bC4TKXMFL5gOsJbTMGL
l0iykgE4n6LiO3wjXA6//FDp8V9fZx5wSRnXIU2ryGNIOnXDY5S8EgkylJTv9Km1
5uSzUaoEb0qEgLRIFXfZjlmXX7G6psETavjomiUyEyFffi47zsE=
=qZHz
-----END PGP SIGNATURE-----

--cs9THzO6WLhoBYGS--

Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9496A344
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 08:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707380654; cv=none; b=OGueC7VTJPzHExgRlA3BwG6W/NPihMNE11j8WHMUXRyGWeOPjZNuhXHeQ9/HeomaSXIodOZCROEV1GPOCi82g34eBLwHqA2ZrrLEedRozyA9L5MW2IUa0lHPFdCC5j4/ZGqi5s+qLHE6kGY/x3v630jfpbktotfFVyqxsQrxS+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707380654; c=relaxed/simple;
	bh=dqLE8uXw6fGnYy3J87evPiRR9AvhZlHSBVBqHMoCsC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRAHsGB5XeetRMXyl3fD2lbR4e1rxwmzksdCdmEZvfMXU6sbSk6divZrOdDbLMspJJ64nBK1nKTYfbhzdC9+2Zv33BVfcTWOowREzIEd646WpHpHJaHtDk6Jzt3hgaoKaumzvV98oOVaRV+qXFMYPszeraPzpOXqdmB75ub18zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EvdhDevN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e3R3xirK; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EvdhDevN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e3R3xirK"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id E57D31C00072;
	Thu,  8 Feb 2024 03:24:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 08 Feb 2024 03:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707380650; x=1707467050; bh=bpS3QvCx97
	DJmr2Db0lodT3RLYCO3j7lBD+gQWHb430=; b=EvdhDevNf2w7dmTI2khugTo6Z2
	xkNjMVur0F9A6DW6jSoLi2ae3uz6xkocnEyoDZmp3jR52MFHkaxQ1yAUGtweQlO1
	ES6WVPHW0LiMZL82EFfb1fC7OqvH/OPzteuWltld9ve85SaiUlLRiFTWNZwumdA2
	5YU19ORZYnmYU6yzQl2iL/lh+njCKn1ohaQvEmy2b6yP4exiDzUgyydElgLh+EnS
	9wEtwfMyVVdF6ndHcqQPT2FEI4PNjw4cb7eE8a9SC7CoBStZ3G+JfXPdu1amDXP5
	7joaswCBL5Ab12lL0bcQ5pX0xrVsArOa1xNadxRKt0MGUY2R4CLOmI4H2NzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707380650; x=1707467050; bh=bpS3QvCx97DJmr2Db0lodT3RLYCO
	3j7lBD+gQWHb430=; b=e3R3xirKbhWHLalGjAuc2kQcO8z6zBma4864vvPShaKU
	5q0lariO90+jLqNhS79JrAeTYX6Jdl1FX52RMWAPUmZZtUzuwwrCGsFLXCL2X1Xs
	5yar/ny/lIXHCgBna9z0v/RIUjAuPTr6jK4QdPD8vdOXOpgErShBYKdhpflxcZeP
	J15O9GcwyfUWKeZtOeyG2fxel/C/jMoIoFxO7M8B204JG3F1wQWCCailzYln4+km
	RONgj/poEa6AD5N8emg/wtDz1TlS44RxLwQfpALYo3A7MMxNJv4lSzFj4QpC1lZ4
	Cw3XjeK5/YDivHfNsGXdPxJqzSZJsbYSoIIAoHWOfA==
X-ME-Sender: <xms:qY_EZT4qwBscAc3cfdz6O3QrEMSXPfeQn0KdMKcqiY3C_q1pIOF8RQ>
    <xme:qY_EZY7M43P0uwbyXV9FwIMFG97vpKc8qi8AZZ07zi8ckeJDnS8K3oIOT08YNRYZ0
    z3eVPV064GZ4mfxVQ>
X-ME-Received: <xmr:qY_EZacEDrCWLMlhbB9w_EeTr97LaegsNGYwmEZdbGEjWPWpzpFCcmqgCy4UYsrzPwVp0WUZBe9Kignl6QKrz7xL350aPghMtnH64_wET9I0SU5r>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdefgdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:qY_EZUJx_e5Qdq1wb6gIscN4yqNguyX1WFs924mz3mNrwb5fDe-vcA>
    <xmx:qY_EZXJJxlYV_VBscbC4w7liTqBb2rQFBl7s-HtGzEFJ9aDlK_OByg>
    <xmx:qY_EZdxNaCpplOYEPgHcn2Y-HlsgZM2-R5wqUeNsbfRuhH8c_Ntyng>
    <xmx:qo_EZUEDAXsHDhWJXi820vLAiSHAOMTQXdQy1Z1wQGDTimAG9DyHJ0sI6O0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Feb 2024 03:24:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 966c6016 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Feb 2024 08:20:33 +0000 (UTC)
Date: Thu, 8 Feb 2024 09:24:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/2] show-ref --verify: accept pseudorefs
Message-ID: <ZcSPpbL6AWAOkkCI@tanuki>
References: <pull.1654.git.1707324277.gitgitgadget@gmail.com>
 <4dedc5704c3af6ab4ec8cc7503dc826480775b8e.1707324277.git.gitgitgadget@gmail.com>
 <xmqq5xz0b3lu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TVRa1uFK7HSXbBHf"
Content-Disposition: inline
In-Reply-To: <xmqq5xz0b3lu.fsf@gitster.g>


--TVRa1uFK7HSXbBHf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 07, 2024 at 09:12:29AM -0800, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
> > ... when CHERRY_PICK_HEAD exists. By calling refname_is_safe() instead
> > of comparing the refname to "HEAD" we can accept all one-level refs that
> > contain only uppercase ascii letters and underscores.
>=20
> Geez.  We have at least three implementations to determine if a ref
> is a valid name?

`check_refname_format()` and `refname_is_safe()` are often used in
tandem. `check_refname_format()` performs the first set of checks to
verify whether the pathname components are valid, whereas
`refname_is_safe()` checks for refs which are unsafe e.g. because they
try to escape out of "refs/".

I think that we really ought to merge `refname_is_safe()` into
`check_refname_format()`. It would require us to introduce a new flag
`REFNAME_ALLOW_BAD_NAME` to the latter function so that it would accept
refs with a bad name that are otherwise safe. But I think we shouldn't
ever allow unsafe names, so merging these two functions would overall
reduce the potential for security-relevant issues.

Patrick

--TVRa1uFK7HSXbBHf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXEj6QACgkQVbJhu7ck
PpQEOg/9E1q2RHwtqqeRHIapKUf91+qvrwQBrEgROzbO2gvvookp8BBBZJZPyH8S
POOCmkZx2dgG3vWhMACYbLRmosZHlYSp0VcqbRLM/TA3CtZJZtOQntLpcXFazP9k
l1YysdD5V8mrEFjr4566rB7/N0UeG36nVJGivx9QECQAri+FMtSfwaBVxoAp5vpl
EBACkqoL4bYKiFFus8L1t1z5Uqdj5EpwHOdyHpQnwFKnucOOtntgZ0S/qhaWGctI
hAma4JaGIjnCPcenkdZvHk6t6rZRvGIY2Hk8jKkeIT5TMiMBoMtiPgF2Cr/8uM5A
UhD4MqZNta2AxQueC/hPmjyT9db17vyND02my1j9BrYjnozToziLzp59fJmiWm9r
yqvtYq/XOYqdzMdBA60pUuTwGeFmRNKd1wv6X6OtMemLZGfFOZx1+FPr25/KFjOr
6g1DdyEbpFbw19qkcyYAMc7GhzxdHA17DTVhntf/deNq3T2ntsXbUAEl8qM6mYQp
CvNDYyZcx/kHk5jQK8yoJFax+MRQt7xKrv6apoo5avJXQjHyVRkku060lyHpZ13X
xxF2UFiWGBBTCmEa7Aot4nJ1Alv0rcmKt6o8qcnetRCSC+tP+5CAx0jSKNzZbXT3
nrBlobkidKKEMjbaTnMmTZcr0YiyrMwx+QZv70sk7kNU7kLz2kA=
=Tga9
-----END PGP SIGNATURE-----

--TVRa1uFK7HSXbBHf--

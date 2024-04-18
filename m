Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5018015FA67
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 12:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713442594; cv=none; b=o9W85y1GQwtqu+v1CqMFluTUJXOPm4AVPZxbDfekCkwEWeVFhRh6/nzjZw+ifRvCLG1eirdugUxvZkXU+/gAkHzXKUFhOy57weGfUiUn/0k2agZxVXeMHPrJgFYNUip41+DVQShR70Y5Ljsh/YQZIGwQ8TPxMY6ub1F4dk2D5hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713442594; c=relaxed/simple;
	bh=cOC8nt95TNAGNWXJK7SMkXo2JUzUgSYbUxX1cg06rS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqJ37lOwB8PuPLTf9yz/UtAB2dEU+ltkDiJTGlXvTeMN4+2u2qx+nagxE9de1+SH/q6l42BaX3g+T2nOgFvm9dvYa/U3A9/yUdz2XJWP6ArpRfQFiTxpxYIXXlXayfPCavdHXOtX/jYp1f/OGGH1X1WyyiIRuK50+ExE4jVPspM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gWuRjxlI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I1iLSZ/V; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gWuRjxlI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I1iLSZ/V"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2ED3913800A6;
	Thu, 18 Apr 2024 08:16:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 18 Apr 2024 08:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713442592; x=1713528992; bh=cOC8nt95TN
	AGNWXJK7SMkXo2JUzUgSYbUxX1cg06rS8=; b=gWuRjxlIeFeFEsRNRMjIJxPM6K
	jP8+c2HZp27gNIQDa+YCEWwYj3qhDKJC3c1ig14IBbcYNyFDx2j8h96OPHnaOR7x
	COIBZhQShvd3usuHFpZxEpXEDot0scDKcYewd0exgUuef+6wUP4tugkdWjdVmxtD
	2nAOFzeNTHwahW292vuZxJp+BylHiYBQlGMpCwRAPzshCp6B3obTSBogDwPfzwaP
	dNEIZIwaZLcLtsgNXMHWgaAwufAbDCcY2cvIvsYgn7fbgGmUpkS3kvT/SWF/ZRsP
	MQct5RuhQYCQwnnCYvR6qt9o0cyJBrQyaat1T/ljwbkEswi39lC5yIVoU8Ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713442592; x=1713528992; bh=cOC8nt95TNAGNWXJK7SMkXo2JUzU
	gSYbUxX1cg06rS8=; b=I1iLSZ/V0w1JtPwocrr475EmxA8dB9bFB3nWEMPmN8Yz
	UBDcYITN4tLbK9j6w0D+y5UzjjG9bTZCTxvIU/fSjWjSJ+4DSF0pww3Sjo53kCV3
	Co8OsvGll/bg8vfkz1OF1tk418dBAkJdWDzOY1GCgNij55WKFgFADLA3rPrfVu3Z
	606gSYy/eX6Z+LZDdvHPIewZ3CGrBMr3boQc2NnNoGdijkfHqNKhSxA0Jb/S4XxQ
	vZ0siigIYrm6nHyEuuIwMBdZIHGKX7VgSeeeoNbi9qpemNvQQA501WmAuXgMZfE+
	D6j5bd//Yr79phywlOdDEfc1JQS/Tbc+6Y9JsD+Xag==
X-ME-Sender: <xms:IA8hZqlBHstmMKjSOu_ksNNrd1VdaCa5SqsfT67W8FVn7Ytgu6Kz6A>
    <xme:IA8hZh3noQhJwk02oDW1uRrfaAxLxXFSp7SVotW_xq6nDgH2xD8KFayEJ54WWcfgk
    jwthnwDJpjv5XBkNA>
X-ME-Received: <xmr:IA8hZorNr04bofOpXBPL4wEz-YJcmj2uj3lRarnGph0MiaeoIzen_uHo9T6MXUMmhGpb5E8Qiu-Y2Tntrc6DCY-ztZhIplx0iNKHhD2woCXahZyL_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudektddggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtroertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheefhfeutdevtdefieetueeggfefleegleevheffueekleefhfeikeetveduhfff
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:IA8hZunrn9_s5mKx_qtVdS6U5TMmarnonFLs0IB3nGgiHQPgbOmvJA>
    <xmx:IA8hZo2MGqqGDOVsmGz0SiTbWgwiKDlVbxFA3GUhglt9Db0ht5D72A>
    <xmx:IA8hZlsid6DxaAexFiHyhvXqA2fkQH_LK4ZnwIY1Gaxa-C8uLuDO8g>
    <xmx:IA8hZkX0GGSw4imFYx0kgjn6htdzzb5r_Xq59kqD1UcgZq0F9kezUw>
    <xmx:IA8hZmC-4wpJHtEjc3crAgnD10Hux0SQ0-9FerqAIrCGQDBVNMv69zEc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Apr 2024 08:16:31 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 40356026 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Apr 2024 12:16:06 +0000 (UTC)
Date: Thu, 18 Apr 2024 14:16:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/5] repository: initialize index in `repo_init()`
Message-ID: <ZiEPHLVhedJCjQjI@tanuki>
References: <cover.1713180749.git.ps@pks.im>
 <96256f9eb30e5aca632942169d5c311b1f245b40.1713180749.git.ps@pks.im>
 <CAOLa=ZQHGSvpzupNPTBQ=j8rd7txMWt9mbGQpQUSJTgr-pP5uA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kKSJgB10TCT6kjpf"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQHGSvpzupNPTBQ=j8rd7txMWt9mbGQpQUSJTgr-pP5uA@mail.gmail.com>


--kKSJgB10TCT6kjpf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 05:38:29PM +0000, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Refactor the code and create a common `initialize_repository()` function
> > that gets called from `repo_init()` and `initialize_the_repository()`.
> > This function sets up both the repository and the index as required.
> > Like this, we can easily special-case when `repo_init()` gets called
> > with `the_repository`.
> >
>=20
> Nit: `initialize_the_repository()` calling `initialize_repository()`
> doesn't really indicate what each of them does and why we have two
> functions which are similarly named but calling each other. Maybe we
> should rename them?

I think once you know about `the_repository` it isn't all that bad.
Whereas `initialize_repository()` initializes any repository,
`initialize_the_repository()` only initializes `the_repository`.

But you know, let's further simplify this and move all initialization
logic into `initialize_repository()` to make this hopefully clearer. And
on top of that we can then also drop `initialize_the_repository()`
completely by statically initializing the `the_repository` pointer so
that callers can simply call `initialize_repository(&the_repository)`
instead.

Patrick

--kKSJgB10TCT6kjpf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYhDxsACgkQVbJhu7ck
PpTYNw//dgd5KsI9GaAGSljjsibX+o34B9+HveqP2BWXVfMFj0pX+KIqw9ZueUIX
ZxtIg5xKzNVDYkWGgJuHEpjWUXrG7GygIheu5B/QjfgQTtagqzQbcucATtNrFBDn
wn4RkSnsiAmoWGHm02V/d4uMvREO3DlMSOY5WgzENA7Jw6rY9fiPOnNa26ue4l73
4pTshwfiHmKOcjRmjoetHyfTiKA/3Oik3TR8hxpOW/RChXMerAP6gInZDm7yfIer
7aPQ+2OULjs1NDqp9AKu3Cz0aACDNExNx8v7nU7k+dY7hkU66ekElLPsq+WJlgxd
FV1UnvYHYbTSw5chqx3afiNnNlZvViR5vYN5s6E8YKoyyOEIAAyylSPQ/PVcelp8
tc26vXhxkfL/gBrOYT9K+24FtVgfx/FzRYKeAe1JvtUagkius8/euQQcM9QqJpz+
migBuH449b65/YZpWsA/fUKyesMwP4gAvD66kh1C9O2GHFx07eywf0Dyq7jjXDFR
+X4f+UcjWhqNuPJ9EoLOkak6rkGBpRbQWv75oIvFn62N0dyH5yCA1WgX5UFtZl5D
XKh1mJxwwk6rn+AhVorul1JFnM8zcIEmFWypXtN8leJiRpfZbPWszl6554DNIfXC
djQlKew9k6keMMxUN5v1u6sQUErmfzG8BerGeZZ29BA94vAW1J0=
=hwrz
-----END PGP SIGNATURE-----

--kKSJgB10TCT6kjpf--

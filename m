Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED2219D890
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 06:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717655553; cv=none; b=nsT2m7vDuhPBQMcAYEvgA5LveVDfwH/Zyg2eYe+jsw2xajaehVwkXoAST/m2r4Uv0X/p9imf8cGAXobiuQnLg0zEXDh4rF0hLaOAofiVXfZZyp7SC7Z+hKxbv8yPBN55FrHk3xY96cO/jIfUiZHUJgoO9Ga3nwDkdbVmYgQPWi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717655553; c=relaxed/simple;
	bh=isVWC3BC7BiOk+KCHhDrOQglLBLCkw3CuI2oeMKvCyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmLfFZbsPnmLbQI465HnQT+Ba5SYZlgNopn3oUkdWSwaiSzK/qjEC0zIbVPllu2UwjqCDx6GOxb5Q+oytKiCOehlLxxLGemcXG3r5vls5u0uXvbeRG2AOBmLYLOOPcMTE5UObKdfDYZmT+Ico5wplv+9o9L2QbwlmMVAs6AZubI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aK1GXTkO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eWfniHKd; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aK1GXTkO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eWfniHKd"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2E517138011F;
	Thu,  6 Jun 2024 02:32:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 06 Jun 2024 02:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717655551; x=1717741951; bh=YKvHQBOtlH
	zXaRatd6bdwVP/68+EXkirY75+1WkrQLw=; b=aK1GXTkOOvwunzfJbzwpILXVJZ
	b7iFiROtPhUg4hgZzqcdP6XRnKzOt7u5n93P8gcVlUO3nl/Wa5sF0Yz9J3aqROpk
	+nPW+xqFXl3lSpwHK9BYhfpZ5DxMwvvA4RtZO4Pz1HLD2ZCST4l5cC2QIvf2TRI0
	Ces0K7tcBzq/vJBsar9UGQEUnKtwrgVbaag+GgTx1ydcmVgn6Hwc5C1dmT3DQcH2
	lNwGoyPRW3AkApLFzKlsIOnoNcKKPus3ICjWhYmQXiICM55nTvj6nhMM1cT7YfLJ
	nnNL647jMiLolqO5fjIAHztY+gplEY4K7duxfdoTgYb2PR1XqI4M1pwbg6ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717655551; x=1717741951; bh=YKvHQBOtlHzXaRatd6bdwVP/68+E
	XkirY75+1WkrQLw=; b=eWfniHKdnIVpPH7hnKFV0IP31IFqyEUj0DjVYhnd8Ffc
	MNe2PZLu+gLL+zRI02Ul/D1GTJYkZflfNkVjuqLDJLpf6TnuEWeO4JDVlXivJYKS
	zxwVKp2FkoE+C6LZ9B4pWsWXodmE7JAE1adQo6ZBdTyccO7kZUIZp8DAg/dQdNxN
	yKlS/7aKajCkvKqloxF1ANr1pfceIbA6rWgKLocqmZrQgvX3Qkb8Hy+igC94kVhK
	rxA9DBrm/Xd7rIoew0/7WdrCUFAcOtx7fC+1/vWQ1K4F21YIiNSd8uXkfGvalaKg
	j4tUd2f6TWYhBh3hNtU8477bGg4HpFrXuhno66fZFw==
X-ME-Sender: <xms:_ldhZs0qChMJY87zolNTlfi3VCwq_iGllKOPFww4NiSt0rBtqyWOtQ>
    <xme:_ldhZnGDusA0ED6A7CGcD_pJoDZfJw9-6JNajqz61n30HyAcSVsMZnJ6ATX_BTtxP
    8WoY7TePSyKs79SdQ>
X-ME-Received: <xmr:_ldhZk7VDcNFS3GTW2YDUEG4Hpohx-MjpwwWmW7cyUJ7LIlcvy-EWoiQyhBS0ZZvIsUjHx2dgZtk4z9AZjEDSIyWv6a5HBMrDi06_h5VkruBQMdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpedtieffleelvdffgfdtjefgveevhfelteejudfhuefhieelvdelteeigfekjeeu
    ffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:_ldhZl1SUwfBMrfrK_2d6-Z26CweXKPYTagElNpL7Tb5xwpINVyHwQ>
    <xmx:_ldhZvFjecqx4qTblq0_QUXsK_Q-mB5syh7A6KPgnMoxB1s2Z6d8RQ>
    <xmx:_ldhZu-vjOY1qSQYUR7jKmzlZbfIb4dJvuSCW2Rgb1JLGz1CyLEapw>
    <xmx:_ldhZkk06XTgQYNqBjD2ohGNbOJtE2H9BkwmUjrmEAgCaOPOPj5ZDw>
    <xmx:_1dhZk7dO9pQI6IS0J00VJIxkAWf1h0KLTx08KeVjPV0HkAdq2LiNHTh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 02:32:29 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2315590d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 06:31:58 +0000 (UTC)
Date: Thu, 6 Jun 2024 08:32:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v4 06/12] refs/files: extract function to iterate through
 root refs
Message-ID: <ZmFX-lE5_vcgXghw@tanuki>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1717402363.git.ps@pks.im>
 <f7577a0ab37988476cdb83e310f96f4841c9364a.1717402363.git.ps@pks.im>
 <20240605100728.GA3440281@coredump.intra.peff.net>
 <ZmFAMBhkuUQEhgCR@tanuki>
 <ZmFF-kgZSlB6O7Gs@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zFD2v9sQBCPWtZpK"
Content-Disposition: inline
In-Reply-To: <ZmFF-kgZSlB6O7Gs@tanuki>


--zFD2v9sQBCPWtZpK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 07:15:38AM +0200, Patrick Steinhardt wrote:
> On Thu, Jun 06, 2024 at 06:50:56AM +0200, Patrick Steinhardt wrote:
> > On Wed, Jun 05, 2024 at 06:07:28AM -0400, Jeff King wrote:
> > > On Mon, Jun 03, 2024 at 11:30:35AM +0200, Patrick Steinhardt wrote:
> > >=20
> > > > +static int for_each_root_ref(struct files_ref_store *refs,
> > > > +			     int (*cb)(const char *refname, void *cb_data),
> > > > +			     void *cb_data)
> > > >  {
> > > >  	struct strbuf path =3D STRBUF_INIT, refname =3D STRBUF_INIT;
> > > >  	const char *dirname =3D refs->loose->root->name;
> > > >  	struct dirent *de;
> > > >  	size_t dirnamelen;
> > > > +	int ret;
> > > >  	DIR *d;
> > >=20
> > > Should we initialize ret to 0 here?
> >=20
> > Yeah, we should. Or rather, I'll set `ret =3D 0;` on the successful pat=
h.
> >=20
> > Patrick
>=20
> I was wondering why the compiler didn't flag it, because I know that GCC
> has `-Wmaybe-uninitialized`. Turns out that this warning only works when
> having optimizations enabled, but if we do then it correctly flags this
> use:
>=20
>      (git) ~/Development/git:HEAD $ make refs/files-backend.o
>         * new build flags
>         CC refs/files-backend.o
>     refs/files-backend.c: In function =E2=80=98for_each_root_ref=E2=80=99:
>     refs/files-backend.c:371:16: error: =E2=80=98ret=E2=80=99 may be used=
 uninitialized [-Werror=3Dmaybe-uninitialized]
>       371 |         return ret;
>           |                ^~~
>     refs/files-backend.c:334:13: note: =E2=80=98ret=E2=80=99 was declared=
 here
>       334 |         int ret;
>           |             ^~~
>     cc1: all warnings being treated as errors
>=20
> I'll have a look at our CI jobs and adapt my own config.mak to include
> `-Og`.
>=20
> Patrick

I've sent out a patch series [1] that would have made CI detect this
issue before hitting any of the mainline branches.

[1]: https://lore.kernel.org/git/cover.1717655210.git.ps@pks.im/

Patrick

--zFD2v9sQBCPWtZpK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhV/kACgkQVbJhu7ck
PpS0Xg/+MmeHLeypv+GkAd9mnCp+ITplcPqR0nnruWntm/QtceVAliBpdrdU82JV
m+hUpxqWqgqr9ulmcgWbxSQCTMt62eOsbvjnwopNYdlZwWRfZiD6XUca1ixdtXQY
uQDrDokNlMn9WsOK1urBCZw8ArmrrrUcJ9xJd7RSDAv7trt9yfJ3ypFaKFigcFii
BQq11zGmTWkKCNpwhnAweAOYFeF0767WXV3FlL/FeBLh/vUcBh6lF63e3c+u2thB
gtK7VtJW79logHn9Pyif+t04Jrm3VcmVKN7WK4zR8VZ6SaI6eVu4Awk/maTZHPrM
Eg2tY4JZIAdGv+bmZp1oyD2VAvMjigChKW7yQOkp6rScehs1Qvu4sv1sUqTNxiwR
efB4qVWb749psWo+1CV9e8L4snJtqcUMaGDrUXhNNlUwUXqS17reTfhwHRssdklQ
vV3oPyo/bKrZrvS4cOa8j61cBO+tf4pP8QphM1c+HWug21ED7Vlddvc20eJzDDjM
xRHfNNPpLvDPbuZdjdjoOd1X9DXsznfAU/t7glhwVWJrmz0ecy8UdzUsd4PWH4dG
kZXsUUpIQbyHnr02gUv2EjKGWhGOQtHTcRpYczJari1lJnf+0WsWbkolJx8wHt6m
UNulBNanBcIl5/87SxWpVZx+9slZmYHo5HRfDNDFWkV7h1Di1D4=
=ByAA
-----END PGP SIGNATURE-----

--zFD2v9sQBCPWtZpK--

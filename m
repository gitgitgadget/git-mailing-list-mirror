Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BEDBA27
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 07:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705476813; cv=none; b=R09YvZg/kEc/lTJ8SdkQZcNN+LXuDT1T1rT2SL4Fy2T3YHpRogYAEGmt1BpDSD9wv3gzUbwmf3Gz4Tj1HXXj6kn+Y8YMLzdcx5CHPol+kydlVJJ1j4jeSvefiVVRmh8vdJEx+FUNEOK/RT9pcukMAQ0li7AqPBbZsuYCphzREg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705476813; c=relaxed/simple;
	bh=Y9b6ayxucNJuynkKiPihWwkSCEKTug7C1vCaGT7PU1o=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=AqgmVS3dkA+tua5UbHo1MUWhRRhsXD5K/3bAK3fZzVYrmpPtKeyuAKVFV66vme7fEuiAp1+CfETQbsp+XY81qo+rodd6Y0qlQtBnBFAXYqTqhZ23PnozQEiUWb8eYE5e/zyX3LGE1Fp/hr+x0ynQj1FsK9qpWM5NuWlEnZ+pQxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JP15fkXg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wLmumlwK; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JP15fkXg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wLmumlwK"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 75CF63200B3E;
	Wed, 17 Jan 2024 02:33:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 17 Jan 2024 02:33:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705476809; x=1705563209; bh=Y9b6ayxucN
	JuynkKiPihWwkSCEKTug7C1vCaGT7PU1o=; b=JP15fkXgMtf8TIfqFU4Bv7UJ5M
	HEUJD5VSpWzTw2JM3VtYgFkdkg4DtAx+GcfpBWlopx7bmpKPSNNsc2UhsGg/HkmZ
	V52eLRa5lRu4aMftGoL29WDJvKUe4g5eBNpU3qxZXuxZeKzuj1ZIARlTDEtbPZ5P
	Fimz/p5ToFNyl0NYXeSeQCVSC8Gsv+OywJmwuEZ4fkob/LMB6gG7H8HKfXakNK50
	LPX3AdN7fbJAW4KAKwWqqLQ7+wQ6PurXPy0Ql5Wpdo4qAKxc9XGEHX2PjDabxmG/
	a3FDyYYTDXxMrxZVQc6RNsrbrvdkN7BRtMH+mYVBiZZq2cKUqXGQTe1bEAvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705476809; x=1705563209; bh=Y9b6ayxucNJuynkKiPihWwkSCEKT
	ug7C1vCaGT7PU1o=; b=wLmumlwKdJF6G6/NwmkOkmJPbES89AC5kxjrjZcNK6Hw
	9gmRUytFIIt9j2hZt/lb4DpEUJd+7WRajfEdI3LsYFp4Eo7k9Pm/Ehf4l29sc3OC
	pyFtJ3i9MVhIbgWjPJM6SZUtPdxqzgoT2TLuNTMiJ3jlEVvA16n63O+jd5Pg12d0
	QaRst5ybxGGomIR/74FdP2p0XozD7d9dwtDQ43wLcn2PjG4W/ERQWjbFrDJ3Mq2C
	2gKHsGe9JSNOtpTF5MkhbfUFS5B9sNp1EOSOB4A/4gUR5vKNqYj1ZJ3HF0NGVzoK
	tiZnp0YUjQVBgoGL+fL4NS+4Kg80/w6UJJ313pBHOQ==
X-ME-Sender: <xms:yYKnZfF0X0PDavqrMuM1SCVogqY2m2k81b8PP66UGmDA0_l_3kU5DA>
    <xme:yYKnZcVs14bR6EtoyIBKGoiQcTco8JnLjT5s537QecQmbE-irUeE_EuqTgkVfAaqw
    VNu4IWA5igyUamYpg>
X-ME-Received: <xmr:yYKnZRKmbghfN6WjQECadZ8d2VFampgT12N2ReWZajlnjg00ppdJxOHAuBDbb1RlS4Nj22ll_0QRMsWfMKVFVj5f62we0v8GkY6f52Cr9PrJbDrTHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejgedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:yYKnZdFNzPkIHxrdBZfpqxofudXLZYx4oRvVAL2Yqln0jTihcnEvIQ>
    <xmx:yYKnZVWs1iDmC1sn-eexvHZD1UgR49hhj0fK4RHvAfXDlMOCm9NL2w>
    <xmx:yYKnZYNafu8ObRvs2ZV46wqXfaPOQec7aupw1e6-iWLevER4x56lSA>
    <xmx:yYKnZSgPyQDaYUZh3RmzrgQa25JJRVusV7u5vAKuh4jPVzF7jZMrbQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jan 2024 02:33:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dfe0a987 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jan 2024 07:29:24 +0000 (UTC)
Date: Wed, 17 Jan 2024 08:32:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] pack-objects: enable multi-pack reuse via
 `feature.experimental`
Message-ID: <ZaeCf1KCwAUCeBPy@tanuki>
References: <cover.1705431816.git.me@ttaylorr.com>
 <a2d0af562a5d0a4052c94f87c1d71639ff0b87f2.1705431816.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Dkoarnl7/3B9kQD9"
Content-Disposition: inline
In-Reply-To: <a2d0af562a5d0a4052c94f87c1d71639ff0b87f2.1705431816.git.me@ttaylorr.com>


--Dkoarnl7/3B9kQD9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 02:03:47PM -0500, Taylor Blau wrote:
> Now that multi-pack reuse is supported, enable it via the
> feature.experimental configuration in addition to the classic
> `pack.allowPackReuse`.
>=20
> This will allow more users to experiment with the new behavior who might
> not otherwise be aware of the existing `pack.allowPackReuse`
> configuration option.
>=20
> The enum with values NO_PACK_REUSE, SINGLE_PACK_REUSE, and
> MULTI_PACK_REUSE is defined statically in builtin/pack-objects.c's
> compilation unit. We could hoist that enum into a scope visible from the
> repository_settings struct, and then use that enum value in
> pack-objects. Instead, define a single int that indicates what
> pack-objects's default value should be to avoid additional unnecessary
> code movement.
>=20
> Though `feature.experimental` implies `pack.allowPackReuse=3Dmulti`, this
> can still be overridden by explicitly setting the latter configuration
> to either "single" or "false". Tests covering all of these cases are
> showin t5332.

I do not mind adding more configs to `feature.experimental` because it
is the best mechanism we have for a staged rollout of features. It is
not ideal by any means as we have no way to tell how many people enable
this, or whether they hit any bugs. But we do not really have any
alternatives.

But one thing I would like to see is to have a clear plan for how
experimental features become stable. It's not a huge problem (yet)
because there are only two experimental features. One of them
("pack.useBitmapBoundaryTraversal=3Dtrue") was recently added by you via
b0afdce5da (pack-bitmap.c: use commit boundary during bitmap traversal,
2023-05-08), which is perfectly fine. But the other one
("fetch.negotiationAlgorithm=3Dskipping") has been added has been added
via b5651a2092 (experimental: default to fetch.writeCommitGraph=3Dfalse,
2020-07-06), so it's been experimental for ~3.5 years by now.

I would like to avoid cases like this by laying out a plan for when
experimental features become the new default. It could be as simple as
"Let's wait N releases and then mark it stable". But having something
and documenting such a plan in our code makes it a lot more actionable
to promote those features to become stable eventually.

I know that this is not in any way specific to your patch, but I thought
this was a good opportunity to start this discussion. If we can agree on
my opinion then it would be great to add a comment to the experimental
feature to explain such an exit criterion.

Other than that this patch looks good to me, thanks!

Patrick

--Dkoarnl7/3B9kQD9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWngn4ACgkQVbJhu7ck
PpTneA/+I/Bxr7xa9Euktuy6uoUL+MypSS/fknSDhIv2+Mtxo7ZDmiki0/xch9Z3
uQyAI32Set9IEEfo6+Dwz4ZzGK0f6SeryIWStNFaROPeZ0F5HXqAUS+P0JHD+y9O
WsyFT7CAdOuaLoWJPA+WbzYGwbV89aTV7aT/s5m9yljOXPr2y6JY7nBSrcwQjhIr
BcqwjTO6WKwu0Vp6Qco/PQzIntGzM85BMg0uSoqibDTceuxCFLwri0UH64yryCme
oAKk46QEjz9laOOX33nKNMHh3xQhFSaKjC/gdMLRgaApGEx/NOzkBjJLsDKL+mLz
xM3duVvPQB7FKBQfeZo5N/aZZ/oBcGAn5BITwz7wQdTyvAwVoWhvyaG+9Zds2vGP
unfoinBKyRllKsRjC+bEOA4cqtz+VsiTXkttzz9xDKKHt26ER/33AOtA16SjYYVY
kljdwTpOYTkOXXDzAWmoWWSyvrTiNFVDbtgCl25T9FUc03FHCHMA0z0FXK7XbdH/
ayaXVShY/oXMBD2gp13eU+Hi3GbLAt8w/mcFM96ddi+WSlDCyFww0x4FHjdCTNPf
gfs2hioXO103y+UNiqcYoTtFo4cddhs4V6nEyINI1EUCSvBEiOSj1SZ0D1s/VEUO
E3HeRre0n6g3c+DgMeD3fbbN9klHJTHnJr1Otr12UphPYnXhB1g=
=DikH
-----END PGP SIGNATURE-----

--Dkoarnl7/3B9kQD9--

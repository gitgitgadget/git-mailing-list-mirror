Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ABA143745
	for <git@vger.kernel.org>; Mon,  6 May 2024 11:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714996377; cv=none; b=oPrytKuTFytEewLTskvB7pTbUqJW/MDiJ0PQYhfoOHd3ink+z498wYI5yGYrEeUsZOgzSJnJuYV3qjcBPJgNHSJQy0KZapAg1auhgBqW5RVSICKuc2L3lLL6Gp8+4fHHRnUot9IxawemSMziCY8znknfZw5WZbiQr4HH8X4x0TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714996377; c=relaxed/simple;
	bh=DyjWtnV0ZNS3oofk5MBq/Wrt80TRvNwafly4WNGvbvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hF5FOw/4S9gSBHUXQ61TwyNK7ZDGI/EvFH8tqMp/rqAoZasQwz5Yt2ZDE6zfNXDZ6mVrwkgg4QrRJ4LmfshTC1hR2xtJjRUxv0lLEcYk0HebBK6w4w5ocdqgo+F5h8ky5+8BjAITvKWQNY0a39I/CyD3rSQmSOcTU3xRGrlUnkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JpW4jlMO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TnOqS2gP; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JpW4jlMO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TnOqS2gP"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 83C1C1C0014A;
	Mon,  6 May 2024 07:52:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 06 May 2024 07:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714996374; x=1715082774; bh=7nfEFKcPwY
	Vv/ym5K7l63+ZPc6Ra1RnBcFjfRk9KrQY=; b=JpW4jlMOdM2/89ApNUMt/jc88J
	qXorAQkY4w9mwmV+6deXf+VId06VtgNSenMbkp7NE4I0ezpz3G4q6suJXbLCyQTJ
	Hq77Omr13Vw9yTjjRwhcoYRgROGg3qK0aKdu/nX/rG9Ej+Fm8vUeEDWP8w7s2rkT
	ofbtxnlGhNkrD5ZVD5Beo5BOhu6os8LOFlvwRDFbYlWMMRIwFisTWq4MzWfINgzi
	6CP/czcCoazZsTWTFW/T9G7n9dQBWCTTEChve6BP6lZ2QOulZgJfNuX8st7//038
	xtNuInc7O5OF+mInUZHsHJikumNl1TRv9YoSNI1sT4fmUdKVRqbWYyz/P5JQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714996374; x=1715082774; bh=7nfEFKcPwYVv/ym5K7l63+ZPc6Ra
	1RnBcFjfRk9KrQY=; b=TnOqS2gPn1DsWwgRvo4OE3kKecJsJLE4V6mW08kILd8D
	oby9Z1UaRawUMZXAdNS4Kp7Zrl5IaW4brRz7wjg9lE1QcgVXxv8M27wXfLZ/f00V
	W0v757ofAAcSDPf1PLmJQaXyV2zxT6xxZu7W2JqHKhJkPHv3prXrxXDec+5IBhGD
	3qCrZZmQM9XwUJ0KTjhVAYBDJ0T6lU3QlWjmltUAz5NO7ETYbNiswPup/vvRj3QH
	nNDNS1wINbN/aPtuuCPHHBK4HckpjsSvcwu7KP6jsyc79XyKrpJkmdfiu1tKEucp
	79Nb8hm5IbykqTIJBur0ISv61Vr9R93JizcXtjTCiA==
X-ME-Sender: <xms:lcQ4ZpbD_3et5J1iD4EWDU9GdBsDTp_RLm2EYCxOkmmp6mtO3LVlrA>
    <xme:lcQ4ZgYn3YuBS-CV6dpgGeYQPASwQoNJPIdPNr3rxz8WU4i_QOGkQ133q-p3I21mx
    RsMo6hF2nEEfiHpoQ>
X-ME-Received: <xmr:lcQ4Zr9ZIWPqwwgy9mYQ45Ceu335u7VsOQBuPplqi5xtx6_5ZabkKEYdh5bwGZHx0RHj5Y6IyBxISng-PZP9VNWC1oI085o4COWk3ZHCaEuGFYTM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddviedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:lsQ4Zno8zM5UWy05k0w5kC1tW9Psada25UJw0u2f4gyyXwPKrA4fVQ>
    <xmx:lsQ4ZkogB1TEuy67f34SvhuUhLPlcYQdqyCiAj11wBWoB9NWwxa8iw>
    <xmx:lsQ4ZtTXKZ_yyDCFxnRoLjVSFSE14c4xyxOROwrsmzeuxT0XwV8qmg>
    <xmx:lsQ4Zsruxp4gJL0EeCW4W-GJJrpnyx7pqHdnYlIs75vV8tx68tNEVw>
    <xmx:lsQ4ZpAkgmquPzjl6iZhawDCHMLhoQ88ZU_ZKhThmxKCcpcCvtZWVcgE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 07:52:52 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ad66f060 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 May 2024 11:52:47 +0000 (UTC)
Date: Mon, 6 May 2024 13:52:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/23] pack-bitmap: move some initialization to
 `bitmap_writer_init()`
Message-ID: <ZjjEkivTeqC0xn_q@tanuki>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1714422410.git.me@ttaylorr.com>
 <3d7d930b1c5c4d122d8731ef0dc3fc90115573a2.1714422410.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NQReOOds1VQcca77"
Content-Disposition: inline
In-Reply-To: <3d7d930b1c5c4d122d8731ef0dc3fc90115573a2.1714422410.git.me@ttaylorr.com>


--NQReOOds1VQcca77
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 04:43:08PM -0400, Taylor Blau wrote:
> The pack-bitmap-writer machinery uses a oidmap (backed by khash.h) to
> map from commits selected for bitmaps (by OID) to a bitmapped_commit
> structure (containing the bitmap itself, among other things like its XOR
> offset, etc.)
>=20
> This map was initialized at the end of `bitmap_writer_build()`. New
> entries are added in `pack-bitmap-write.c::store_selected()`, which is
> called by the bitmap_builder machinery (which is responsible for
> traversing history and generating the actual bitmaps).
>=20
> Reorganize when this field is initialized and when entries are added to
> it so that we can quickly determine whether a commit is a candidate for
> pseudo-merge selection, or not (since it was already selected to receive
> a bitmap, and thus is ineligible for pseudo-merge inclusion).

I feel like this last sentence here could use some more explanation as
the restriction has never been explained before. Is this a strict
requirement, or is this rather "It would be wasted anyway"?

> The changes are as follows:
>=20
>   - Introduce a new `bitmap_writer_init()` function which initializes
>     the `writer.bitmaps` field (instead of waiting until the end of
>     `bitmap_writer_build()`).
>=20
>   - Add map entries in `push_bitmapped_commit()` (which is called via
>     `bitmap_writer_select_commits()`) with OID keys and NULL values to
>     track whether or not we *expect* to write a bitmap for some given
>     commit.
>=20
>   - Validate that a NULL entry is found matching the given key when we
>     store a selected bitmap.

It would be great if this refactoring went way further. Right now it's
quite hard to verify whether the writer has really been initialized in
all the right places because it is a global variable. Ideally, the whole
interface should be refactored to take the writer as input instead,
where `bitmap_writer_init()` would then initialize the local variables.

That'd of course be a bigger refactoring and may or may not be a good
fit for this patch series. But I'd very much love to see such a refactor
as a follow-up series.

[snip]
> diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
> index c35bc81d00f..9bc41a9e145 100644
> --- a/pack-bitmap-write.c
> +++ b/pack-bitmap-write.c
> @@ -46,6 +46,11 @@ struct bitmap_writer {
> =20
>  static struct bitmap_writer writer;
> =20
> +void bitmap_writer_init(struct repository *r)
> +{
> +	writer.bitmaps =3D kh_init_oid_map();
> +}

Given the other safety belts, do we also want to BUG here in case the
bitmap has already been initialized?

Patrick

--NQReOOds1VQcca77
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY4xJEACgkQVbJhu7ck
PpQ7FQ/5AaMI6fTQgszU2xUaL5Ov7C+y6Wamk9fLiNR/hsqNVpo6kWr8UqSFFSJK
zxBotnvYrBzJBzb340nSUdMyrVe5a1NGWi/ecdTk7G/1ABm8SoqBXXWZI7j7Nw3i
/NXQOWMeBMkhOe5zoJS6pXCWRQKWJQyqw/hM1kWdkzYt6sVy0ieYvDV3ZAVpXAj0
pg02PkFKj0BK4kKYvfvVWxj5af+LE4PIDmkhFwyF3rHKUkwDkzoDVssFsBqADcXS
nn4Czh2OgAQdmlNoEFBdyXOPMvQ/AJxFIIrbn2sP/8z8mygpdYGrxVzWH6oMN3+T
owItSFbHjxqSQcImT4AEHb7+/FLZgr7LD7gtxURANrMMZpgQ/ZoFZ2gZe++lYvj+
Ig515tddlHe2qmBlCCYNiV3npRI4ctoMd5lhe6bj475eZ6WpF23I9YOY5qpA2/yF
saen2Bp/7/RlTyS9Dhvowg3K6BpQQdOaPLOGt8ZC9eP7D30vG9yFt/cvuEN58Sqw
eK9fXp4rUvZ5FBDUZi52HIg7EbukuBBn3xAXYCvCmulq9ZYu/8y/mP7HsPke6gXY
ujTYy+reAtsOWJzTJb5T2h9ym34qSB6dIala/xSidlm4Vk3kz4B9JwG68Lr3QAOS
wTcw8F/fE5yG83pNf6By7ntPQpRrL4h81lgyicyI60pV5eQ4FSY=
=AM53
-----END PGP SIGNATURE-----

--NQReOOds1VQcca77--

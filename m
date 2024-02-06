Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D839128814
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 07:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707204341; cv=none; b=ZgBfy3myonyRcD5mtotjGVXq0yvYTZhmwGNYpCygjbAU+SfjHs8L18cZX179xrahE/rr/tsrW4j1q145dfQu4PZNv5uwIuYsJutNcJK5ThnF6TPpxWo/HUS7qqwp5XRnJGx7HdaJevONNzZzCV0L8llmJJ6hPgCl9BFRkKEPNMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707204341; c=relaxed/simple;
	bh=qTFol3NiponiVc301XUxi5d6Cugq0IcLPPRQ2tRTac4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNXsz8D2tgGAjiD4ygB1WrihLmfmiYAF+pZ4GH9gg//qKyZkShTrvPS8kLciyY5e2s/ywaiBKzAzAwqYHCc1KMOQoHgv12gZ90YYF85aWW2Y6P8eILYsmpBJjx0b4tTwYxfR7HdFvnOtIHXrs1lep2YctE+uPogcgLEHThg7sM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Uu1m8JkZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IQ1qAc5r; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Uu1m8JkZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IQ1qAc5r"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 4D7F61800082;
	Tue,  6 Feb 2024 02:25:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 06 Feb 2024 02:25:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707204337; x=1707290737; bh=khRVdfPmKD
	/V0fX3bdHzqhWNa2QbmBv+Fsg+Ix5/Vb8=; b=Uu1m8JkZEuC1bB17uUHcQt32DY
	ghqMuzA72B45tBTqgHrRiO2ulpLHsbQVk/QxtMID89xyWAcMwzARe2BGIHQ3yaP2
	3thYyToQs5wN4zLNPCiRtczlERZAV7kxdu9yikb0uh9yN9Yyi001MrOD0Qoc6Nbr
	7Wbsmk6UkEiHrRn7EMP8Pk4Fv5kdJ2nPLY6UdratEGw3iieCGUsiRjCDaze2jZ8y
	npvWGWvCWXdXtUgifsDh9uS0ozXAUOF4YRJOmz6PiE1YL+EWSAp2oS1RmNOD2Not
	oERp5k3ohVJUARv8G6YnWFDJNGuMt1mveNhTFoNbBfevpHwjX5DIQqSxp38w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707204337; x=1707290737; bh=khRVdfPmKD/V0fX3bdHzqhWNa2Qb
	mBv+Fsg+Ix5/Vb8=; b=IQ1qAc5rHU09VpcMIrWohBAgdcRk6tqtj+Io3Chc0VJu
	BIAjMOEl/X0hardNB9rD5ttQZPf9G9dNGHJCl7hCkJGA3yhoZKI+juNNV8PvAV3X
	BdyGsK17YOotyfoL6MrMGIJtdIqH+b4ZtJUgcly+yhlvilwWDn0fGo02Ekztri10
	UfyfEaYF/cPJ6mmBnTNSxfGJWIHfitu1RNBqADw41tQVL2wFcVKqZDuTly8IERGH
	u8TrZwtNzsmp8k+taojRZYHDPPjwRAg+o6kRBB+LBId7L4hIS3LpBRM6PcUo4Z2s
	2fyMgS9eP++9dQ1gDHv627SiMKPBiBN+ssEojaMWOQ==
X-ME-Sender: <xms:8d7BZaAh0Cf7WD4KIF8Ain_8F-yrUt86rS_hJ-PuANZOW-zJblHSmw>
    <xme:8d7BZUgtSvmg9spzYfKJKkQUR1qqrKbuU7MnCZqirFuVmeu27vdvjvBvAaaodlLaC
    uDHKimvIkLDuIYAyg>
X-ME-Received: <xmr:8d7BZdlPBO9DHA14we_4FVbN53VsTPHrf9sZtleKbMp-hzeJqu82lseF1XaVLd22joBoLNU0r3BiCFoPxCFvo0Uv-3SFxJMZ_x1WqbazDYK4_wz_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedvvddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:8d7BZYxhgrN2wVymcMJd4Ikh17zcJ-gfAWC_0GZPYi2rGn3t5CjyCw>
    <xmx:8d7BZfQUeyMAMLdXfs2O-M7tHlwS1jsN-TUSgjU6u9t-jr9JKDrPOw>
    <xmx:8d7BZTbAERo9RSQEaZZjwGUVa4n7OekOi7kqzFVo1BcsXxet83b2PQ>
    <xmx:8d7BZdMHLggvQ6TruJjYBV9JqTWFgAskfEiEEfTQGVdwGoM1ZDGwuiBW5p4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 02:25:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f0a7170b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Feb 2024 07:22:04 +0000 (UTC)
Date: Tue, 6 Feb 2024 08:25:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <pk@pks.im>
Subject: Re: [PATCH v2 1/2] t5332-multi-pack-reuse.sh: extract pack-objects
 helper functions
Message-ID: <ZcHe67-6VLssXYDL@tanuki>
References: <cover.1705431816.git.me@ttaylorr.com>
 <cover.1707173415.git.me@ttaylorr.com>
 <db3d67bfa38bf3141214619e766d39dc7f709812.1707173415.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yrbEQjLx32SInhIt"
Content-Disposition: inline
In-Reply-To: <db3d67bfa38bf3141214619e766d39dc7f709812.1707173415.git.me@ttaylorr.com>


--yrbEQjLx32SInhIt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2024 at 05:50:19PM -0500, Taylor Blau wrote:
> Most of the tests in t5332 perform some setup before repeating a common
> refrain that looks like:
>=20
>     : >trace2.txt &&
>     GIT_TRACE2_EVENT=3D"$PWD/trace2.txt" \
>       git pack-objects --stdout --revs --all >/dev/null &&
>=20
>     test_pack_reused $objects_nr <trace2.txt &&
>     test_packs_reused $packs_nr <trace2.txt
>=20
> The next commit will add more tests which repeat the above refrain.
> Avoid duplicating this invocation even further and prepare for the
> following commit by wrapping the above in a helper function called
> `test_pack_objects_reused_all()`.
>=20
> Introduce another similar function `test_pack_objects_reused`, which
> expects to read a list of revisions over stdin for tests which need more
> fine-grained control of the contents of the pack they generate.
>=20
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  t/t5332-multi-pack-reuse.sh | 71 +++++++++++++++----------------------
>  1 file changed, 29 insertions(+), 42 deletions(-)
>=20
> diff --git a/t/t5332-multi-pack-reuse.sh b/t/t5332-multi-pack-reuse.sh
> index 2ba788b042..d516062f84 100755
> --- a/t/t5332-multi-pack-reuse.sh
> +++ b/t/t5332-multi-pack-reuse.sh
> @@ -23,6 +23,27 @@ pack_position () {
>  	grep "$1" objects | cut -d" " -f1
>  }
> =20
> +# test_pack_objects_reused_all <pack-reused> <packs-reused>
> +test_pack_objects_reused_all () {
> +	: >trace2.txt &&
> +	GIT_TRACE2_EVENT=3D"$PWD/trace2.txt" \
> +		git pack-objects --stdout --revs --all --delta-base-offset \
> +		>/dev/null &&
> +
> +	test_pack_reused "$1" <trace2.txt &&
> +	test_packs_reused "$2" <trace2.txt
> +}
> +
> +# test_pack_objects_reused <pack-reused> <packs-reused>
> +test_pack_objects_reused () {
> +	: >trace2.txt &&
> +	GIT_TRACE2_EVENT=3D"$PWD/trace2.txt" \
> +		git pack-objects --stdout --revs >/dev/null &&
> +
> +	test_pack_reused "$1" <trace2.txt &&
> +	test_packs_reused "$2" <trace2.txt
> +}
> +
>  test_expect_success 'preferred pack is reused for single-pack reuse' '
>  	test_config pack.allowPackReuse single &&
> =20
> @@ -34,14 +55,10 @@ test_expect_success 'preferred pack is reused for sin=
gle-pack reuse' '
> =20
>  	git multi-pack-index write --bitmap &&
> =20
> -	: >trace2.txt &&
> -	GIT_TRACE2_EVENT=3D"$PWD/trace2.txt" \
> -		git pack-objects --stdout --revs --all >/dev/null &&
> -
> -	test_pack_reused 3 <trace2.txt &&
> -	test_packs_reused 1 <trace2.txt
> +	test_pack_objects_reused_all 3 1
>  '

Sorry for being nitpicky, but now we have the reverse problem where this
function adds `--delta-base-offset`. How about we adapt the helper
function so that it accepts trailing arguments like this:

```
test_pack_objects_reused () {
	local pack_reused=3D"$1"
	local packs_reused=3D"$2"
	shift 2

	: >trace2.txt &&
	GIT_TRACE2_EVENT=3D"$PWD/trace2.txt" \
		git pack-objects --stdout --revs "$@" >/dev/null &&

	test_pack_reused "$pack_reused" <trace2.txt &&
	test_packs_reused "$packs_reused" <trace2.txt
}
```

This merges the two helpers into a single one where callers can decide
by themselves which arguments to pass to git-pack-objects(1).

Patrick

--yrbEQjLx32SInhIt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXB3uoACgkQVbJhu7ck
PpSZQA//Q+clS/6OrWgr6ObuhH5yxa1lUXuYFRdwIhPPbNJD4Z3b2Av0vuR/BrQz
wuG+rxhyYDLm3UqEVYUcAOMDoLAd5sXwcb7Uhw3ntXO4OtYokHGqnE3+H4VkAJpi
qZhKAxkllRo9LkKoZ9hR3sygF9avLVyoNq36q2eOkSD/YOlBIhqUMXDfRTbcZyhJ
czAMqL32j6/vpJWzpSDcNgHizBAimEET60aMXv6GuhQf0OEDMPHKBABEbCEogand
MI1p7b8VhZthuziouXnEUOaEWTIrSOSabtijSkCcZILYYKAgzP8OhoOEzxMIQPfc
kyBZy1zSEO/jlWNLMdy2tsN9Xb9iCl8IWOoZXZdJum5hxMjNgvgBEjTZhnPuMb+w
WucP01RHOCt9+itbH3cZ76FBwnDaja5L1mGB/mJzLzZ9jPRq0v5y1MGkc8oxGgXm
H1eploCbjW8GwbTSfadKudoZnlUZboa0ut2VMaemGNp0b4z7Ulq7RUydZQVkMxlq
C4EbIHohuxhTgE8LWy6x7kCwE/GGOm6weG6xhtlJ9WugEeq9MHWuDJYHb1JogdUn
9FbShbihtBuullmxolp6qummRJU8TWD4zPiAvhFhJKOQGWgdrt8sRoecnyClix+1
GkZ7AIvYw3JjefvfiR1QE9xns/s608UBXzMjViYewoNj7l/uvRU=
=hUSL
-----END PGP SIGNATURE-----

--yrbEQjLx32SInhIt--

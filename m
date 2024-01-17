Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6626DB662
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 07:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705476813; cv=none; b=fYBNT5DXbipn/kuLAhRw/KK8hDfha9FsK+lHaELdAFQ019dsUk0bcs8suJ9JUs6MwrFIXS3zCTb0UpQkF3EBz2e2ii7KSJcbJscbPkKC0Pe4huX46viDjExidfT/G0Oyy3w0iE3l+zdnWj8sdQKTF+9rZsINCEzcGaZysvhWSTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705476813; c=relaxed/simple;
	bh=XrEG18/76nuvMDdDZjg2jtvZkkQbZclqi1fEuCiAA+s=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=AHu7zYz34Veg2Zys1J6gNwER1aogBdMBudPGp5G6+L+mw2YvQr1UHIjNAU8bGPxnegBRHT8BCYfCojJcposp/EyKdQpsq8zOr6UuSCtFMdohRNURvpVyu19Cr0hY+J4omgWWTgEX7NcrsEp50fT+YVhbOGMwGAGdjnMobkxnRYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sb5zDmxf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pze8eMJv; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sb5zDmxf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pze8eMJv"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id E4EC83200AD5;
	Wed, 17 Jan 2024 02:33:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 17 Jan 2024 02:33:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705476809; x=1705563209; bh=46wfAyEiKg
	MzGWf9DhzLolResjgizElYhiLb4PpJWGk=; b=sb5zDmxfGbqx5MQymrth83CTOh
	OoHMHyVmef2GVe5vBDjqRFMhsVDZyShzoLtBTi0elEhVIXm4rUS6jjTNH63Wf0KX
	fD3Xhy1RvDsQFxMA1RaT7Fie8+9+5HQgCXn5mPbUlESjbMxQnfmKHBmSXah9tzep
	RSQVPcuETO/nQ0Ekc5i3VqzmdRIWh/ZfsP6R84vysvaVQDJ6s4qLYVQWphrPpDI0
	CIigrCkfPhHEinIV1syow4yMNIi2dgfXfj6a11tAFZAnyoGys40lxMLVn/KvrMy9
	lto4w3hBJjSibMT+G20IsnQGhEOWhQBSwuBwvatB9LvA2rgCWCw6j7g2lpvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705476809; x=1705563209; bh=46wfAyEiKgMzGWf9DhzLolResjgi
	zElYhiLb4PpJWGk=; b=pze8eMJvImb6j6fQfIM+AC0zB7jGU6bPZNs7XZ+BYCfg
	kKQwqhG2Xf7P21uZR1Eal55vycO5H0C+p7Diyogk6CVRzQSNR/G5tZBMQsp9G6DC
	IbhJ44XI5QnVcNSNFdVskAl50FdaFtUgkV6ODkUEnnVsvOsS9PV2tpxAgSTOhI6M
	BdFXRQXf1RHaI1brnoompj8C1tWbvN+G2kusEruUBHYjA4bYmcX3AWeAOXXXsVV4
	2HpGDxzageL2nwgBnI5SWC9+UXBGaujUh4J8XkjT8Un5iP6gHCypGlQFbcS86tUx
	4HMIN77aVpbz6aGEirm3Eg3/6rB0SrStZyaXVSvymQ==
X-ME-Sender: <xms:yYKnZVXa2ybGXcKKDAbEFvkN4oB7Xc-CeDhkQKCxGkUBqjaSJBUVLg>
    <xme:yYKnZVlwFlbe72-sGdG8d131Oi_8Scnm96zlugnc5MXwAT-mzq08O3hLQxVufIWQm
    1GBQ3Np7hFE5ev9wQ>
X-ME-Received: <xmr:yYKnZRYk6oeDEryX60GYaYAVobSrH-Fz11ZkLBoM6AG8zpMvyJG7NPlakLcKIFacrxA8RLceXWqO0V3ZE0EY4vhWNashtE7Qwl4ClCjtIDLJxA26zw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejgedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:yYKnZYWNSNgJIoy8shHLCbJthpq36FcFcxu0fB1nWnFOziJ1kHEKcg>
    <xmx:yYKnZfmD6U6Cvl-MI0ClY2uFuIJenGhOLxySYxg99O4DcseX7VAhEA>
    <xmx:yYKnZVeDcX6hlNOG91j4KmE7b9I8hIXOYJfnlBNLAb_pkC5qtXnhgw>
    <xmx:yYKnZUy32askv_7fvIeLxGCXZhIpUQVZn8JidOq3yfGbV7ZwCWB4bA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jan 2024 02:33:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 793609a4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jan 2024 07:29:18 +0000 (UTC)
Date: Wed, 17 Jan 2024 08:32:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t5332-multi-pack-reuse.sh: extract pack-objects
 helper functions
Message-ID: <ZaeCeY-9AIR-zt7u@tanuki>
References: <cover.1705431816.git.me@ttaylorr.com>
 <94dd41e1afdd6d926a106ab387295cf5fce624cf.1705431816.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="igrthtNRuRCjX7DE"
Content-Disposition: inline
In-Reply-To: <94dd41e1afdd6d926a106ab387295cf5fce624cf.1705431816.git.me@ttaylorr.com>


--igrthtNRuRCjX7DE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 02:03:44PM -0500, Taylor Blau wrote:
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
>  t/t5332-multi-pack-reuse.sh | 70 +++++++++++++++----------------------
>  1 file changed, 28 insertions(+), 42 deletions(-)
>=20
> diff --git a/t/t5332-multi-pack-reuse.sh b/t/t5332-multi-pack-reuse.sh
> index 2ba788b042..b53e821bc0 100755
> --- a/t/t5332-multi-pack-reuse.sh
> +++ b/t/t5332-multi-pack-reuse.sh
> @@ -23,6 +23,26 @@ pack_position () {
>  	grep "$1" objects | cut -d" " -f1
>  }
> =20
> +# test_pack_objects_reused_all <pack-reused> <packs-reused>
> +test_pack_objects_reused_all () {
> +	: >trace2.txt &&
> +	GIT_TRACE2_EVENT=3D"$PWD/trace2.txt" \
> +		git pack-objects --stdout --revs --all >/dev/null &&
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
[snip]
> @@ -104,12 +110,7 @@ test_expect_success 'reuse objects from first pack w=
ith middle gap' '
>  	^$(git rev-parse D)
>  	EOF
> =20
> -	: >trace2.txt &&
> -	GIT_TRACE2_EVENT=3D"$PWD/trace2.txt" \
> -		git pack-objects --stdout --delta-base-offset --revs <in >/dev/null &&
> -
> -	test_pack_reused 3 <trace2.txt &&
> -	test_packs_reused 1 <trace2.txt
> +	test_pack_objects_reused 3 1 <in

This conversion causes us to drop the `--delta-base-offset` flag. It
would be great to have an explanation in the commit message why it is
fine to drop it.

Other than that this looks like a nice simplification to me.

Patrick

--igrthtNRuRCjX7DE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWngngACgkQVbJhu7ck
PpS5Vg/+KO31CnBXlsHPQtzrhrgWIQFRlee4fGfjug8vXkUzuFjVqCYCIXe2NSNp
eXy88MvN3tS3XagKvEr+6cddiOFuc8W78wM19yd2b2dzGpg41tC8H4oe0HIStQqA
9c7kCCoCq17ZixHF9agJs0FZ2yqRQACDC1H9Glg/pjj8BSIwMeWzJVmjnLheZF7C
5v12rH6JBU87djwfTauRQs36u+ltzyc8KsYMSq8BX89/cTvsgYnRG2pDF7t0yDoe
Em/oUcZDLVvTQrvazSI/jCjMvoNmzt5j8++UsDtb/TJOGdV9nZ1IdYEo77QBkqYw
8icIEZ/k83IUeughHVnNqwnBStIBYpNdfRHty2ISNzy0ukX84CbggRNGcxFz3btD
bc6BfNn5nc6J/z7Xh3uB+jQIcDin9PQFzyK5wlJfped1UaOXWmVvGdp/HnHuh3G4
hTU08Kd7Vg7EBd8+0Zt9YgX9lQjlqmeHZAgCK/tK4pt1MhpOxRuwTD/HYjMZLAb7
Y0QUsBDEQjhoq9SOXjHSBlRVFULqP6/eFrFnP60+gjHEy/j/AeSzMupk3wlK4QCY
/cF8k8l0gnf6MSZ1svbPj8uQnLrdTp2KgewEqeqOq0v6gc+oZphjn8IbE9izvcvN
jilIVgDhhOLfrgaQPINIkrRX+YIWPc7/vW7LjAndg9QCa31AMpo=
=MLx3
-----END PGP SIGNATURE-----

--igrthtNRuRCjX7DE--

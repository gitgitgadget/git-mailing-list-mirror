Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C6E47F4A
	for <git@vger.kernel.org>; Mon,  6 May 2024 05:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714975047; cv=none; b=g6SPiVuehwwWAR7MRUBObrICB41JUOGWuPmXrd2ZK95eVn10hF2vUM+9t/p9mMOPRe7U+3XLYU4qH0qg69iyHyEMhriqJvrQcgm7jf8ei+DnOtCH9LH5kOFcxpXrzvnGxGeqTIlCJbsHms6xMn34hni1a4SMOE4B81mFGGDh3yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714975047; c=relaxed/simple;
	bh=cbONI03ewZzl+CI3+VVn8KeZiNlODGBGMm9pKSf5O8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGpKI/Gx7rWurriSw9mPWqqJqwsGkPu9mg1RMhopT2L7DdoUFX04ip8A7wbpoSThPgeA78hN29B/EmC5dUjJetk5Y3Nc6K4AO5g4mvZ89q3cmcxx7uElw3ltv8t2rGUnQQdIGwRNdr9ZoqTZ/+LaLx/c9Limq7vaQjUyrRn/W3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uepWCo0K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MtDFTnm6; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uepWCo0K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MtDFTnm6"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2809C13800CE;
	Mon,  6 May 2024 01:57:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 06 May 2024 01:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714975045; x=1715061445; bh=ktkELc0eTJ
	rpCJ20euLtqzTKMmVtltdoqQF6ZS4ha2Q=; b=uepWCo0KO6IcLLOcWHel4Vc111
	N7LzJwmhwbYcwfb0XSQy92xW1BNU2WZpvlIiO3FHkhGuZ6Oi+M7L32Dvtgo3+Yn9
	CNkxKsXZEaSPQTnxvEFI5v7Lj9ZxpDd9ywuHTxW3ahZ3xWDRQHstgC3tXSEu+nnL
	97EhjmcuDBcLM7V/5DQ4CU+k0VkkNveWKTCghDp35feTJzvUmcRCOYVmPLIo3cc6
	dApzx5u3YhOKo59fOOQHLGkTC/dW+AItyDPfeQng983Fh3OyoBQ+qK1NDTq+7SCt
	YoBjvXLTeIqU8hUol9OCPUEu+9nLe4dEvMWGsjVFzFwg6L/PgguAUOc7g30g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714975045; x=1715061445; bh=ktkELc0eTJrpCJ20euLtqzTKMmVt
	ltdoqQF6ZS4ha2Q=; b=MtDFTnm6UvvLTMRFIrUxkxDOJjB76fTs9swIvfLoz7qE
	Fnkjp2VvK2QeRxgr83fmSQoiQJwVqr5huHR230aii5u0Ok0CNpQb+/XzUpEoM80s
	Zyl42PWSmk5RsR8Alh4rctH1/dOcRjM2N1tN2BESU5k0hUmZTjuuQZchX6Jm0N3W
	jj06+ZPQDAL3tzSk8riZkFlWoLyaRNJarMwzLSwUtpq7vEmvDPAtO8rmKpHgLem6
	aTRo6UDIFKPIdSI7bB4XtGxmSuHTRfXVopij3PdR7N47P2HNcXzSTHnLMQGn6hrn
	ZDoUvcf/PYZUroMbDEwFxE+Mt1ef/9blUHEToCf+FQ==
X-ME-Sender: <xms:RHE4Zj7HD01EM3-jmsEHTYomElXXa5tYhpQ5RfvfoHn8b6NVrZvp2g>
    <xme:RHE4Zo6l17UQS9acK4Rf-hWZHXgvpVTdnMFTfLtd7laKjCW2wEz-sJJIcmxOONfG0
    jKr2_AVJHkXgCuK0Q>
X-ME-Received: <xmr:RHE4Zqdp1-WGOYApu347y8oebUCbE7DCg2PNmEPa8PjczHd9a2n_1R7WuwFjHP6bpV6idlOxua6S2y1DyBqBfi6Ybsya9-cIHO2fztIAlFgSjGM0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvhedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:RHE4ZkJye-LHWysMuo2gceIuOedrDhWV8tquIECq8ZnU0rUekwcUtA>
    <xmx:RHE4ZnK2UiTse9iJIIEuUuSn4nIlacjBHrZHqaz-u0vbf31zmCEw7A>
    <xmx:RHE4Zty2IFXp9FPdkbZgG2PzOmrg_ho5qsGcaepfVZ2j52Wq_sy1LA>
    <xmx:RHE4ZjIVpXA2LyNvcpqqmkPAlJaF8NxnoxfoqnbqeYMCysxTLR8RBw>
    <xmx:RXE4ZkFYnYAu2JdBmwWtofDiEOarBdQwNm7rDLp2bAIy4clfruzQ1M5e>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 01:57:23 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 520de844 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 May 2024 05:57:18 +0000 (UTC)
Date: Mon, 6 May 2024 07:57:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] attr.c: move ATTR_MAX_FILE_SIZE check into
 read_attr_from_buf()
Message-ID: <ZjhxQOgRgvv7_gGY@tanuki>
References: <28f6267709db78ba526d7ed9fc4a734674697c70.1714763555.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FbzgKkisuTD9OAml"
Content-Disposition: inline
In-Reply-To: <28f6267709db78ba526d7ed9fc4a734674697c70.1714763555.git.me@ttaylorr.com>


--FbzgKkisuTD9OAml
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024 at 03:12:36PM -0400, Taylor Blau wrote:
> Commit 3c50032ff52 (attr: ignore overly large gitattributes files,
> 2022-12-01) added a defense-in-depth check to ensure that .gitattributes
> blobs read from the index do not exceed ATTR_MAX_FILE_SIZE (100 MB).
>=20
> But there were two cases added shortly after 3c50032ff52 was written
> which do not apply similar protections:
>=20
>   - 47cfc9bd7d0 (attr: add flag `--source` to work with tree-ish,
>     2023-01-14)
>=20
>   - 4723ae1007f (attr.c: read attributes in a sparse directory,
>     2023-08-11) added a similar
>=20
> Ensure that we refuse to process a .gitattributes blob exceeding
> ATTR_MAX_FILE_SIZE when reading from either an arbitrary tree object or
> a sparse directory. This is done by pushing the ATTR_MAX_FILE_SIZE check
> down into the low-level `read_attr_from_buf()`.
>=20
> In doing so, plug a leak in `read_attr_from_index()` where we would
> accidentally leak the large buffer upon detecting it is too large to
> process.
>=20
> (Since `read_attr_from_buf()` handles a NULL buffer input, we can remove
> a NULL check before calling it in `read_attr_from_index()` as well).
>=20
> Co-authored-by: Jeff King <peff@peff.net>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---

This patch looks good to me, thanks!

Patrick

--FbzgKkisuTD9OAml
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY4cUAACgkQVbJhu7ck
PpQ+4RAApHahwgmYS8lWEgP9pSN/g52quVwbX+wrRV/ykJgxPjV/FwhrTHt2NEBG
2Pg6krKD6nBh9B6zI2cyGCugq80WBjbIlhUtZC9v87VB70vvkKrLi2LkMBALPw6r
pi3qdNCK9hWqlVEU0V3ZL4n1iss0f0LFxAEinoZTt6F584rixqaT/+JQRajdCdwY
beFgJcoGwCZCjX7r+JhkbNS3BdSFzNfAtDKjgOWeICZgVbo2CrKzQ4+nXT7lKslM
vXGiA7spkc4YD2H2YkcwF9QuWviTSQJcVTCNR5sGAZl7NNidg8Q76Rv3YjnEqXHL
REl3NqK7GRxDIyMqPD8AbFqiRsTn3s1Z/8TCKlXYYH6V0FteOrsoYjGZbCSGgDXq
FXhcTplhQmTXJkyviXOpSiznAPiKXpdcwofbQPiIfSYszRuPbZ8Kh9AICwYJPbQ1
WOatkZVBtWvwOM1mAb0rpvkM7X1Wo+Ngg+twvndnKoo1K0XO8MqfAtwsrFuH7sGc
VtTodYLOTQfhOKX/TQXFIA1K695H7fe2Gr6kFrQ4FfNWSqzQfgS0QVNMJoOfN6uP
Le68g01sqdr+Ddw0o1zvZYEzJlgR6QOt7OglOwIQ/rKK5BWR9yXHY3xBJhHqUQIG
S6e+NOouq0vyITXbTnIiPiPOkBiQELjtSQ6hU8uY0FzG5zV0eNg=
=Tzx+
-----END PGP SIGNATURE-----

--FbzgKkisuTD9OAml--

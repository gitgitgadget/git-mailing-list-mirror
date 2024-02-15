Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A880117581
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996117; cv=none; b=Dz7jVTDlA+Fpsz7sMzSs32voaNrEJIo07N+jnyuc3/MwTlifmNwLH2pPbOpnS5H5HBsj7iirRucAv0MHFollai5IqOtlDVg+otSJODzsl+8iTHUykPxpUXtV5trS2iex1nk9b3Q1jBhjhCBukOEt3m9h7SRlkkqPnMwZ/b7BmJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996117; c=relaxed/simple;
	bh=xz87ssKUbqXcEtlLbUu1QaMPzpmmNs8uzPYk/pgnEjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMo3FPpZIU0oP+itqVKpaDYZi49z++gpWhBYl9fvOM7R3whCpR8kr1viqu/groVWBPAoX1ZDEQorXP5rwXIwRaQunry52mjGRzxhPxxYXHeDE4f2AlbbQ8U3LiKURdDswqwdaQctbBX/GCKCvgGgvRkKykYpeYm+JsySdNTIr2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PyRKL+br; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PrbIV8yz; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PyRKL+br";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PrbIV8yz"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 989725C00C6;
	Thu, 15 Feb 2024 06:21:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 15 Feb 2024 06:21:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707996114; x=1708082514; bh=5eFNBn77E4
	Miy+CYG65m5P4+Js6uwNtgP6W6vPNxwZo=; b=PyRKL+br00rr7PlLSiVh/tQSDv
	IeCCZltOguRLKUrptggbgIPvpUQtzz/yVpsUtvL+dc6kLPjrVf+2gSEiIUBhyfbb
	irEDhgIiX04JXKT8ERv/yNDhSrjlN/Z9UKrpIyItU0uQ9dbi5WeoEU32TAhmxOUX
	91V5U6NLWXjXeK3Zpmmn8ZKRMbCJRQMUpVxLazzbo4svSzBeRL51fljXwAShraOA
	YcZRLEmr804glv71JBKBbRzlOZZTnYd7aqpZIe6DhKXLeA1KS8SL1ef+eC+vaYPn
	z2CPZMKEjGvD3E3+W20NPvhEMhDZaUpmHEqYNgKJk/6QfpdkuHOdV0uUaMdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1707996114; x=1708082514; bh=5eFNBn77E4Miy+CYG65m5P4+Js6u
	wNtgP6W6vPNxwZo=; b=PrbIV8yz2qy2gBsU6iG3WDSXBLWVGCEb9LA0dAuKbyvY
	dVVp90pAePCZXKn8icpRvN+hii/MyZeVMdFeItwZl/f/0ywWGi/2vwqY5cfqL5tx
	2XESE4jIv8gkk6RUrn4ZDVdhw14qPbYFR7ZJN5JTRg6xhfZCLuP4J+Ty4fxKENlW
	44ItqDjDr5kHz7XlaUIqRH8Zt98rmM8d+1XCFRcmcqBpO92JJRrcja3y0JwLgw/s
	k3LABDKc6rsxq3jri7RNp9/AoQYsqvzSF1UKhq3RbvPq4Iz6svgwHwHN8zRCLu2K
	ms5YisXc0iY6o7ZOp0sr8s5/ZXK6VTGRwE8IZs2/bg==
X-ME-Sender: <xms:0vPNZWghY81cg2NDL0JiaF0XklUxaE-sa8bpRV-eKEH1avvCCedD1A>
    <xme:0vPNZXDFDsdCHsfD-tv3DZFFt2t0M1nhDI05bE2MPbph7waAdKHRmamLaj-wdUjD-
    6AkYhCeVanLpCozGw>
X-ME-Received: <xmr:0vPNZeEITSEYf3Oc45akldkY-UBu_8gu9ZL4_cPkEszlJfHlrpfDTd9svgd4McNPZgq66PzohMY36V4grEWREUboVlcwcfY2GQhIUP02lYUK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:0vPNZfRZFvZ4AaN_JTEXyHoSP9qA4VGgdhX2FwgEYLgTEfJmzyjTWQ>
    <xmx:0vPNZTxJiZ0KiUEQnvsDWhkPakm7EqnytA0lUWySPSD6VpYTCG9ixQ>
    <xmx:0vPNZd6ydnd84i_bwaGrkjPJy84DLAz1Mcr-pwz3dpVRn539MxJ87Q>
    <xmx:0vPNZeroVEoeApzFIba-o9bKh_5uTIRpFtQwDN4cxjPxXCt6KAI_lA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 06:21:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id accc8eed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Feb 2024 11:18:00 +0000 (UTC)
Date: Thu, 15 Feb 2024 12:21:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "Eric W. Biederman" <ebiederm@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v2 02/30] oid-array: teach oid-array to handle multiple
 kinds of oids
Message-ID: <Zc3zz0hJFShTZp3M@tanuki>
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
 <20231002024034.2611-2-ebiederm@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="74Lh5T7F7BPMPPWD"
Content-Disposition: inline
In-Reply-To: <20231002024034.2611-2-ebiederm@gmail.com>


--74Lh5T7F7BPMPPWD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 01, 2023 at 09:40:06PM -0500, Eric W. Biederman wrote:
> From: "Eric W. Biederman" <ebiederm@xmission.com>
>=20
> While looking at how to handle input of both SHA-1 and SHA-256 oids in
> get_oid_with_context, I realized that the oid_array in
> repo_for_each_abbrev might have more than one kind of oid stored in it
> simultaneously.
>=20
> Update to oid_array_append to ensure that oids added to an oid array
> always have an algorithm set.
>=20
> Update void_hashcmp to first verify two oids use the same hash algorithm
> before comparing them to each other.
>=20
> With that oid-array should be safe to use with different kinds of
> oids simultaneously.
>=20
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  oid-array.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/oid-array.c b/oid-array.c
> index 8e4717746c31..1f36651754ed 100644
> --- a/oid-array.c
> +++ b/oid-array.c
> @@ -6,12 +6,20 @@ void oid_array_append(struct oid_array *array, const st=
ruct object_id *oid)
>  {
>  	ALLOC_GROW(array->oid, array->nr + 1, array->alloc);
>  	oidcpy(&array->oid[array->nr++], oid);
> +	if (!oid->algo)
> +		oid_set_algo(&array->oid[array->nr - 1], the_hash_algo);

I feel like it's a design wart that `oid_array_append()` now started to
depend on repository discovery, adding an external dependency to it that
may cause very confusing behaviour. Are there for example ever cases
where we populate such an OID array before we have discovered the repo?
Can it happen that we use OID arrays in the context of a submodule that
has a different object ID than the main repository?

>  	array->sorted =3D 0;
>  }
> =20
> -static int void_hashcmp(const void *a, const void *b)
> +static int void_hashcmp(const void *va, const void *vb)
>  {
> -	return oidcmp(a, b);
> +	const struct object_id *a =3D va, *b =3D vb;
> +	int ret;
> +	if (a->algo =3D=3D b->algo)
> +		ret =3D oidcmp(a, b);
> +	else
> +		ret =3D a->algo > b->algo ? 1 : -1;

Okay, so we basically end up sorting first by the algorithm, and then we
sort all object IDs of a specific algorithm relative to each other.

Patrick

> +	return ret;
>  }
> =20
>  void oid_array_sort(struct oid_array *array)
> --=20
> 2.41.0
>=20

--74Lh5T7F7BPMPPWD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXN884ACgkQVbJhu7ck
PpTt2hAAoWbyCM/9pl2DcUY8u0wEJeOBMWZ/4slMkuSGa51jljMy0rToVv4WxNNy
5V5G3BRKL+ARIiktF4MahEjX3sTaY1q2D1pm+QUhBef3QWhVS14Tjm4CA39sNJbi
9oOPPoH8zhTIqF+dKG+nxKUXoQsze9harv4hSahl5X7x1mwnHUGFFX2pHYgspnyr
7W5jzOKCce/R1pa6ZdCB15NjejJP0tCRDtCjqEwZ5ifwHzQA9njPzo32EI/zwOcY
rKZr3lEuQUrhIOMH2Fx1sl4OZ9Zi5Vjt5/hkwqD/M5eP1ZcnZthPvv8tXYFP2fda
p9sqlfO4GrI1ceqjcO8w0n2a0QEnKmjGmafDTv+55qWF0EsPNof+yyhuJO+QlHxc
1m95K78tE6uqzUXpk4Asdeb40WQG8cESppJMvyo527bk61U8vLsQYaHe20vKyNT4
jhhLVLMUzsNxK17XvOI0TXPyNNBeIIycyr32oqit45EiRLiFhVOtzdwZ5C8mexnp
q9hTVAdKooMOYstPwAbTdiDhAdPg0ps5RcYTSijl+lzlqImvVGsKra31PKGR2ylQ
i4lXfe7y8+tXyCSLueJgMux0e3dt3Fat+fIafbvtAT9Xp8PxujTs16Il73ifAgl5
P5ijYEGy7Y4YOCt6C/14bjnxXl3+kpSCapOnuQRVX16Bf7GrLxo=
=KS82
-----END PGP SIGNATURE-----

--74Lh5T7F7BPMPPWD--

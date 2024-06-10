Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C258286D
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718027377; cv=none; b=QD6MMWUxGiP6oIddokogt4UPt5yHzSyZG9lNMlesB4UvbvZPOkNilZoC7259WccgK/L9l41VvArxl8/trOdkT5QUcCl0acu6oA/91slmopFZ/2ZElWn3xhX1Ze37l62QhdoDSYo/Glr0Q9HrU8v++uvHkW9+OsEFM0aKBgFn1ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718027377; c=relaxed/simple;
	bh=1t3UTfO0JKBznsaDF5aKHtd7Tnt4I3L5bdQFU4O7IfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5omzjWZ/yAp0x0JbM4y5f3D8NkH/MFIaRS3ALPgS6RrHw4H9QdEHJORP9x/g1N8WI9TeGSVzNYknk/U0B6bYbT81LJnPdUwVCya8ezadFd+Yza6QaCjYdtgnO2tIPPSI5aOdA4Zd0Mx0v5dVneo4vzi/Y4Vx1Ex4ezKdhnC73o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jzr5SDt9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ez0KcY7q; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jzr5SDt9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ez0KcY7q"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 731E713801DA;
	Mon, 10 Jun 2024 09:49:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 10 Jun 2024 09:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718027374; x=1718113774; bh=fQKYmEYpJc
	kx6Zy4uW2ghsf1p+GGsILVAtP5a1x+0KM=; b=jzr5SDt9btNjIzWbtbj4qat9FG
	XH6AN8oyahs1fSHFZX6ag2jc/7bhyhl5IlRd90W4oXe8nItFLlG4FFnco6yWR2Vu
	6vqoAz/Vjjf1meHcUnZQecAajZDZZqBlx4zjzrRlbsxhZTc+B/r46UdiZrwfA3JJ
	EWo752Pt5eFi0hyPP4s03YCcczX9+6/cGOklLmv45YzTs+XmWzCfz6Ymi0+mdGgI
	kaiiGZl7MRAdN72LdXo8YaHqVdMg0CHcOrEGO42CnIiIaJTFx7owtfNq4lLWUQrV
	KhJCzQoPHJJ1OZ259J25UbcnMeX4G+IvDlGncpsaj5IdGHFy6RhezGFwfVbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718027374; x=1718113774; bh=fQKYmEYpJckx6Zy4uW2ghsf1p+GG
	sILVAtP5a1x+0KM=; b=Ez0KcY7qqaI78U37SDvCm4q2kTMPIksTNKkQfDBgCMKb
	KBab6VbJxiN00trV+JC2CsPv9AiLfUHXBehZnDM80c7PiIepQ+dz+aMJmZEEZTAd
	V14wqG89Hbkll7fOY9eyt94ZtfWcympIJ5z3g0Lu5p7uc/MZ9t+JFCj2dMxvFOnF
	aBSm+hEM9UxBS8E7f08oEtcF/MbvNFodUWYWphZwqw1bafWSdBCEH0au8by28oS0
	nm+0EMZ2zkgX1h0Mg8lRkUDGdJFWG8aaBY6t4RdDsh82pe7XxLcdjMhxunmGtZ7e
	SrTTCxALf1iuzgNGzGyEdH/D7BtOEi89Kyf9GcO9Rg==
X-ME-Sender: <xms:bgRnZlua-OIyjlEdfxga7sS202RM1ROa7SizTUsq7XsoH1zoXNYIkw>
    <xme:bgRnZueWYXxMlKWnQjn8QplQdxKCTe65Bv3UoVa85JH0qvZGTSIznfDEY4mr4RFQY
    ZCFeuzP96Yvfql9lw>
X-ME-Received: <xmr:bgRnZowidQnrhqtzAUPIXPL8vwCRSqbQagh50d12zamcITuolICVa7klXaJV-DFch1jVzFoVwMz9WX63qaY-1TlyGgjlTccxMTiWOdCDv400Uu8v>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedutddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:bgRnZsPp3Mm8ybElOxkgaKKlmR19V_ACUJNC3hMAABHCaPUny1bCPw>
    <xmx:bgRnZl9-HEPYATMkn_ldyPFs7jAhWF85Ec1DgE3dbdt5YaD7rL6ykQ>
    <xmx:bgRnZsXEJY_XAkpD_tXHNpCWy0BCdZ51heA17kbMCPUrkfNZzAAM3Q>
    <xmx:bgRnZmdXF5A2dXm1fV0qAG2gyzktq-dlaaKNFLZ5EN_m1pssD_tzzw>
    <xmx:bgRnZgYeNprMTlcM9uABmsnJplF7J_TA07K40lSPxxGvbwbiHeZFdk44>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Jun 2024 09:49:33 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id bc1fbf23 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Jun 2024 13:49:24 +0000 (UTC)
Date: Mon, 10 Jun 2024 15:49:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/4] t-reftable-tree: split test_tree() into two sub-test
 functions
Message-ID: <ZmcEaFxZhpyrFd-b@tanuki>
References: <20240610131017.8321-1-chandrapratap3519@gmail.com>
 <20240610131017.8321-4-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TNpj8uPfQcgM9Oh/"
Content-Disposition: inline
In-Reply-To: <20240610131017.8321-4-chandrapratap3519@gmail.com>


--TNpj8uPfQcgM9Oh/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 06:31:30PM +0530, Chandra Pratap wrote:
> @@ -44,13 +44,29 @@ static void test_tree(void)
>  		check_pointer_eq(nodes[i], tree_search(values + i, &root, &test_compar=
e, 0));
>  	}
> =20
> -	infix_walk(root, check_increasing, &c);
> +	tree_free(root);
> +}
> +
> +static void test_infix_walk(void)
> +{
> +	struct tree_node *root =3D NULL;
> +	void *values[13] =3D { 0 };

Is there a reason why we have 13 values here while we had 11 values in
the test this was split out from?

> +	struct curry c =3D { 0 };
> +	size_t i =3D 1;
> +
> +	do {
> +		tree_search(values + i, &root, &test_compare, 1);
> +		i =3D (i * 5) % 13;
> +	} while (i !=3D 1);

It's completely non-obvious that `tree_search()` ends up _inserting_
nodes into the tree when the entry we're searching for wasn't found (and
if the last parameter is `1`. I feel like this interface could really
use a complete makeover and split up its concerns. In any case, that
does not need to happen as part of this patch seriesr

What I think would help though is if the commit message itself mentioned
this unorthodox way of inserting values into the tree.

> +	infix_walk(root, &check_increasing, &c);

Not a fault of this commit, but this test certainly isn't great. It
would succeed even if `infix_walk()` didn't do anything as we do not
verify at all whether all nodes have been traversed (and traversed once,
exactly).

Patrick

--TNpj8uPfQcgM9Oh/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZnBGgACgkQVbJhu7ck
PpSETg//VAk1Gdga+bX0yj8N1DhXJ0pBkPlOBZVYKVeazvgqHPvX6PNCL5PFieXX
1dINjOSES0q1HmauHaPoGB1nZMm/OBuu6ADHUvzZMY59ivFB/U0c6wNtlltMtNEi
e6ugYRwt0YP28pooaNwgezPu8kGKUb5LOIklBSwKVig/SWAaW+dkZO2VAK7aEGTM
WU1AXDikdGoDWK8jRlftv01TA+VctHIAlTFALSKcHOzljOJufEKe8SfsPEs1P+Hg
2RNs17zyDNriUydyefWVWVOnEc3mHM4LB/bDY+DprQF5XugLazGy2LTEV81qIQTA
nfwcimfX5a8CRmXCLrSNNDd3DMQIpFhdTKiJ92nv/Z6OLMjUMahGDmrLVh9+EVIm
IYSiPJel79ETqWJbQlFj8+Htn7ktyQHpfgbCmqTSAgjuQGyYesQ1OWmU9UiCLloT
Ws3W3h+qJFdZSCJAlv10IPaNVTRHtiN0buj+71egSMU0SEsDxYLtUfsSsrHBIidv
cqb4cXkt3q1MDeG/veOuiCoXxkv8QDw40IaZ7YClpIHILS8+W5Jiw6zzjx/Qx7T/
L1IE9rXrWdxXBbwvbHCH7njOrPBOQU9KByRD+NgZgjNtonozaX/PAYMUB9BKWAkd
2VqiW4K6d6NtHcLtvrnR7nxww6vpwIuONl9L0NoIFl8etlzRwPQ=
=UkFC
-----END PGP SIGNATURE-----

--TNpj8uPfQcgM9Oh/--

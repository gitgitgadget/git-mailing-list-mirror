Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFA81947D
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 09:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709543056; cv=none; b=oF7xq3HQLf/getqllRv+eQmwRCelLrYcqkZCEVa8j/hEhJNr4UzX+/69dFOSpyDnWgRv/YLa9O1Dz/om7sOzDXR8vjqKFB8w15QovLt1icvdmu6uYTTExB8OqXgMT3jDOv9Yn9T4cbRSpOlijV6bJY0kdbY0kE/bry+org5WkqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709543056; c=relaxed/simple;
	bh=PnPQ1qWC3FcuDrWcL9BjyGJqFdHEDqfVhwMRp/O1fFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuXXqaAUr9lzSH1WXtWLcFUNxd7FBrCQa9MP+0LQGQSivCfxbVPWN+JtatTRuDjViMq73fC/B0xpqp2Ba0DTjpX39FK5d7kNxhEF4mhun/antZsYMMZHL3//26jwOfE7HycnWlzHMAxsDniYbrWIbSNJgqn4jsJ/LIRMbGrL8qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SglhPGEC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ACSegHn8; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SglhPGEC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ACSegHn8"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id 388F418000B4;
	Mon,  4 Mar 2024 04:04:13 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 04 Mar 2024 04:04:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709543052; x=1709629452; bh=k3pJaLcXdH
	PLh6hrVYV7udtRc8vGGKtbgEMk4BFHB9A=; b=SglhPGECR12hnjPCWxdjxDz7SX
	qOG68oFEh4l1rJF8JUsvIqSeg+taZQ8V3wb0nLCh+CJHHgQ9609XITQKR1eZRHQN
	v7GLpqwRfSjVkFeTHrtuopzj05KAKQwmimJIb+pg1CyhjdSXbiAbGW5zkFPWR8AU
	5wSHPtCMUX6fgV6o/N/aCbsRlCMWDmjZb3W2prAaQJi5YOJR3Kih9xaB9ul19lde
	J54Mpb1TUG8SA/t6bAf5zPBOi2+14+mAvQW1+vuWwkTYCJdn/7131cBx92px25Ia
	M7H/LA9qM7CaFSMwuiTiP4wbhWe8aUNsVQ3LDcyKCfp+98t6BGyqgL2yzjjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709543052; x=1709629452; bh=k3pJaLcXdHPLh6hrVYV7udtRc8vG
	GKtbgEMk4BFHB9A=; b=ACSegHn8/loFZRdc7Rli/8TXXIZEHUuLfKicjLBUcvnI
	z+ANpe3uBzXa7MqwWvERNrg6T4g5se2B9mQEejSx+DbNhL7tTxf43UCmbIdHpN/K
	s3uURwgtZz2QgId8NlpgUDsveBZik9EKo99je915NMgQdHhHkKafRr8UCW6TjIgm
	MN+NanEKo9isATXorzmSYO2pQNa/4QhKVV/XepHKgVm9pJEI9Pn/o/N3NAFhdqrw
	BjsuoepJI2F1jRYjTq+O6wsHc6JG5txUXwQcbcgb6FrR3jsoNiq5c4fPLRdxbo1R
	ngm8Ce3rKbH/d2mblKG+JgmUVN9e2u6TRkSpMbpP0w==
X-ME-Sender: <xms:jI7lZXorq4dt5hZwrDB6KQ5rJXWTqpGkgwHGLgHGWfsoqlkpp4J19Q>
    <xme:jI7lZRo7X7Wq1e48FENwVfABikJNa7eHSxVu77jVAPEukxa4FM_FjsjUxzuYmOnBv
    wo4UnSyjUbztJvUsg>
X-ME-Received: <xmr:jI7lZUPe_ccn_t_SGepgLcvtZ8krupAafskGO-JRuG7_dzzGCTEFl5PYDLlgwt7yqzSerhrdtQ34z-T_0q-pmbScb_VooZ5Nr9wUE1PbVzdHnAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheeigdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:jI7lZa5Ab4E3_jaiIZOZghGoavcPR_cN30g3FUN8TmypR6ON6WYudA>
    <xmx:jI7lZW6iJtHQSQ4bgr71dZa2OKOGK9SWpI9ATT6fHBeiEVIqQQQIxQ>
    <xmx:jI7lZSiZsGXeG95ECoWpVjNHLaundoQd8NsExv3R1T3t1jm0BpFHHA>
    <xmx:jI7lZYQygFq5eh_acTusfIn52mjeoZD1IYEL7NiBnqyHqEBoIJOaf4KGDwY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 04:04:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e9c12e61 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Mar 2024 08:59:44 +0000 (UTC)
Date: Mon, 4 Mar 2024 10:04:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Sergius Nyah <sergiusnyah@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	pk@pks.im, shyamthakkar001@gmail.com
Subject: Re: [GSOC][PATCH] userdiff: Add JavaScript function patterns
Message-ID: <ZeWOhxBDvyjH8gW7@tanuki>
References: <xmqqttlsjvsi.fsf@gitster.g>
 <20240301074048.188835-1-sergiusnyah@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JVfmVJrbJH9DJafV"
Content-Disposition: inline
In-Reply-To: <20240301074048.188835-1-sergiusnyah@gmail.com>


--JVfmVJrbJH9DJafV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2024 at 08:40:48AM +0100, Sergius Nyah wrote:
> This commit adds a patterns used to match JavaScript functions.
> It now correctly identifies function declarations, function expressions,
> and functions defined inside blocks. Add test for corresponding change in=
 userdiff.
>=20
> Signed-off-by: Sergius Nyah <sergiusnyah@gmail.com>
> ---
>  t/t4018-diff-funcname.sh | 22 ++++++++++++++++++++++
>  userdiff.c               | 12 ++++++++++++
>  2 files changed, 34 insertions(+)
>=20
> diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
> index e026fac1f4..d35cce18a0 100755
> --- a/t/t4018-diff-funcname.sh
> +++ b/t/t4018-diff-funcname.sh
> @@ -120,3 +120,25 @@ do
>  done
>=20
>  test_done
> +
> +test_expect_success 'identify builtin patterns in JavaScript' '
> +	# setup
> +	echo "function myFunction() { return true; }" > test.js &&
> +	echo "var myVar =3D function() { return false; }" >> test.js &&
> +	git add test.js &&
> +	git commit -m "add test.js" &&
> +
> +	# modify the file
> +	echo "function myFunction() { return false; }" > test.js &&
> +	echo "var myVar =3D function() { return true; }" >> test.js &&
> +
> +	# command under test
> +	git diff >output &&
> +
> +	# check results
> +	test_i18ngrep "function myFunction() { return true; }" output &&
> +	test_i18ngrep "function myFunction() { return false; }" output &&
> +	test_i18ngrep "var myVar =3D function() { return false; }" output &&
> +	test_i18ngrep "var myVar =3D function() { return true; }" output
> +'
> +test_done
> \ No newline at end of file

This `test_done` only needs to be added because you add the new test
before the preceding `test_done`. Instead, you should move up this test
so that it comes before it.

> diff --git a/userdiff.c b/userdiff.c
> index 2b1dab2649..bbe2bcb9a3 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> +PATTERNS("javascript",
> +      /* Looks for lines that start with optional whitespace, followed

Multi-line comments should start with their delimiters on separate
lines. So the "/*" should be on its own line.

Also, the code should be indented with tabs and not spaces. It might
help to read through Documentation/CodingGuidelines to get more familiar
with Git's coding style.

Patrick

> +      * by 'function'* and any characters (for function declarations),
> +      * or valid JavaScript identifiers, equals sign '=3D', 'function' k=
eyword
> +      * and any characters (for function expressions).
> +      * Also considers functions defined inside blocks with '{...}'.
> +      */
> +      "^[ \t]*(function[ \t]*.*|[a-zA-Z_$][0-9a-zA-Z_$]*[ \t]*=3D[ \t]*f=
unction[ \t]*.*|(\\{[ \t]*)?)\n",
> +      /* This pattern matches JavaScript identifiers */
> +      "[a-zA-Z_$][0-9a-zA-Z_$]*"
> +      "|[-+0-9.eE]+|0[xX][0-9a-fA-F]+"
> +      "|[-+*/<>%&^|=3D!:]=3D|--|\\+\\+|<<=3D?|>>=3D?|&&|\\|\\|"),
> --
> 2.43.2
>=20

--JVfmVJrbJH9DJafV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXljoYACgkQVbJhu7ck
PpTWCg//byWEr58h7tBXGqdyXt+Z1hh5AtPiy4DKwvvAeO0SVPP29vsUuUxEgVRz
fTbqgIELS7Lue9CDjhZJBcq3gO+fQJX04sPBjhEJ7YZlZtum9tuf931nYAaRFq7u
Zm8ubUu3AmleeqJVICJqYXt8YjSMv2vh2+MrlssGUCMYcMGJGfL7+oigeN6/wdra
pV3nndOaxRwECtXY0ZvIqzALZt707CbdXWfpyWM9Cf7XwFxioqQ8k3JLMiKBbfXG
/WIn95rTH72QOilCHFDnED+sZ3ME3mIJjrhTrJYjzfI+0Box+yFRkgfFHUcvHjf7
6fZXWsy3dL1W5rClaw/+4KOHx/Yv8aaivhL+pxr6rs+aSWIWJ48igC5pisFMULDI
evRlHB3w6IJgCz80VEx8bNKEknbePVOAGCVgMJDJk1M+rzkfh8m4l7DSzQ7atbdQ
hy1V0xjBAQWqy7TNiBk4Nnaeb/Jdb/p7Z0dAeKHZcGMBuF5NPO8ag3h7C6XafCjW
b9Nug0J6P+9jbpB8vnOLCqmUNSBQoZ65GRB+g/rD/Y/r55XgPwcP7/AeJ2a+Vqfe
wZ6OskY8KNI38zZHuuV+hI4WSxWMvjSrvijJP2HkCPkrHVLl25dJRClLHkMIJV0Q
QSe+0kW8qD84A376nkJhHQKCo9LAZpsQOc8WFUgu7r7+NKaZ5Rg=
=hr94
-----END PGP SIGNATURE-----

--JVfmVJrbJH9DJafV--

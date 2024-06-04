Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52683140399
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 07:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717486978; cv=none; b=Ku1k3+wyKm3X281SSvG2iQ8WS27RxI2+R//LjDVue0CdVPL0lsNNswkwJ8t5OesYrcsfKNk8W9MxJCg+8VTFxHy/kAj3LBhXjDxsNvPE1W/j7UNLhz7GR6HAtC8Ep5AXDuWIrA+UoIea3ihWw41p0jC5FYavi8QLKE1hLD5VLBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717486978; c=relaxed/simple;
	bh=HlgpvVOWuVf2dhBVu0axKcP+Qwb2LxWtyinXBMYwN0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/AwHFdaB+oapD04VAG/YVFRdnIw6Qh0c9zcfqjCmgquBaxB2qCx+6EmthPC1IKzvag0YLIivfSiQ/GOa684irancn3fm02sJMMU2kpststnMHZFEv1D0qtfiJbIek2T8HiauqiERdv7gZhLNICVoCgdqC2gKtp4O/liW98J+zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nZC+s4oa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FgGILa88; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nZC+s4oa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FgGILa88"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 7EEF2180012E;
	Tue,  4 Jun 2024 03:42:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 04 Jun 2024 03:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717486975; x=1717573375; bh=M9Bhv7u0wz
	gzgoFbiaoer7XNquQcAisSlYT81OnmXfA=; b=nZC+s4oaTqLFB4y6pGh6beBLQ1
	MQ1/4sErj+OvyQpNVHh+sgBLy5yuqaeY9HEi4GM3GF1CoeV9QBad9ZIaNraQ8/x2
	fx8ETAPA9huKsZvpE4VGH5B2Kg/4Xuq5qmQsOcJ80fjZw5PgqxPw0eu1pX7O/ayO
	j/QjY7TMbr9TViEfS/k71weXQRon6tAUnxlVQsxFaVZDC6BKu2+CzGIDLPVf9Jmv
	cpojSHZDHXPJtQK4Pd2czvvuwRsyd7HGueK9+YYWnWDscn4N3LhVUclOPnq8HqIb
	PL4xXL3e/BTlxAVMBvMVjvou7OnYrcg1s5gSkfoCU+mndmXQfZDpPVhnfC0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717486975; x=1717573375; bh=M9Bhv7u0wzgzgoFbiaoer7XNquQc
	AisSlYT81OnmXfA=; b=FgGILa88JBPkXFIFxAafJtH9n/ojL162z9lyBPGvpc/b
	BmJGHVTfqUcqCt86jwaSe68pgAOk3+PZMbtukME9k0AMhqv8Mv+uDHoKAxyel2/S
	xlXJFvD4IHjrrjchVw2uIGV521fHUho3NXg923KgcHFbe+mUy2Vym/mKahbEl/Y7
	B0pXjHkE4HSOLMwEV09lRnZItunIKHTUUyJIvdtDXb3vvp7fJyUZGOy/BW6J/ZKZ
	qXer6c0j62ipwNZ/o6x8ZHDdvgA58Lq+CKb69qYSEsLHqXTTl7lIQbsCpiG/pf7q
	1BOEjIGFSal0VDqxQUZuadsf5YvYLstkNyoTTaxoow==
X-ME-Sender: <xms:fsVeZhOTpRbbcLKU7YIRXPH8341L8KbAu0Q8HZt9SKhD_69NvzVJvg>
    <xme:fsVeZj_NHL64mIxpUXfXDu5vFO-f1KAcWT1UoYNifSDhn6aWDTqgjd0dUm1YR1iOy
    3PDEV4YCPmc7lySxw>
X-ME-Received: <xmr:fsVeZgRWHqIPDSKBJY3cYKZugo87W91yWzhf5wsifg-NgkxTv2A76bqAry5iWdQC0h7LYB1IsOu3hmdiytHk-02iwEFKdpHZ2mgdFzDX35KfZBe0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelfedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:f8VeZtujxVAwxcnvBTvs07hwfzk_UrYbI5m8XAj-3vQEeF-VYK0Mpw>
    <xmx:f8VeZpdKhSmn0tMPnTjeyB3mUcnseJnsEdYlCVZ1SLvusaL-eqCgIg>
    <xmx:f8VeZp0I36TXgooeEIJrpIuDw1VBY4ZMh25O1Rd1fBUfB2iEOJa0dg>
    <xmx:f8VeZl9KDR5tXwlafriWcxjhGINDCi4t-eBjw_pjgPpOZqE347-9ow>
    <xmx:f8VeZqpzIHHs8e12PMdegycRTWg3LlhAx6sfKmqSl-1wUGgDjv9S3TcR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 03:42:54 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e366c07c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 07:42:28 +0000 (UTC)
Date: Tue, 4 Jun 2024 09:42:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 09/13] sparse-checkout: refactor temporary
 sparse_checkout_patterns
Message-ID: <Zl7Fe6132gy1JclD@framework>
References: <20240531112433.GA428583@coredump.intra.peff.net>
 <20240531113530.GI428814@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LAYlhfFXPu0ocbHF"
Content-Disposition: inline
In-Reply-To: <20240531113530.GI428814@coredump.intra.peff.net>


--LAYlhfFXPu0ocbHF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 07:35:30AM -0400, Jeff King wrote:
> In update_working_directory(), we take in a pattern_list, attach it to
> the repository index by assigning it to index->sparse_checkout_patterns,
> and then call unpack_trees. Afterwards, we remove it by setting
> index->sparse_checkout_patterns back to NULL.
>=20
> But there are two possible leaks here:
>=20
>   1. If the index already had a populated sparse_checkout_patterns,
>      we've obliterated it. We can fix this by saving and restoring it,
>      rather than always setting it back to NULL.

So this isn't only a leak, but also a potential bug because we did not
restore the old pattern list?

> @@ -241,7 +243,12 @@ static int update_working_directory(struct pattern_l=
ist *pl)
> =20
>  	clean_tracked_sparse_directories(r);
> =20
> -	r->index->sparse_checkout_patterns =3D NULL;
> +	if (r->index->sparse_checkout_patterns !=3D pl) {
> +		clear_pattern_list(r->index->sparse_checkout_patterns);
> +		FREE_AND_NULL(r->index->sparse_checkout_patterns);
> +	} else {
> +		r->index->sparse_checkout_patterns =3D old_pl;
> +	}
>  	return result;
>  }

What I find weird is that we sometimes restore the old value, and
sometimes we don't. I get that it makes sense to conditionally free only
the lazy-loaded list. But shouldn't we then unconditionally assign
`old_pl`?

Makes me wonder whether I miss some subtlety here.

Patrick

--LAYlhfFXPu0ocbHF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZexXsACgkQVbJhu7ck
PpQe+Q//frtkynnA/jFkcPpEjlVIwTk3lcg7uuNfYP232ch99bIlc4yMUJaENRMC
z46QXK3cYjzwby2BHBOqn2d63Ks+1xHQq8cD3Gs12LyA7+hkZ3s82PhARhwtcwvJ
9PTUFhSSgehiFY9vvrv+m/9xp6bnTNRsD8pJqAa6WIriYdU5sgFfcmnCvABZtGvu
A4wUd1cd/Wvfl3oGVWM5ko+q8J9xzPUiax6yS2YYAps6TV8qLJPDdtKS81Aq+4aX
/73PV0zAYnrDc/N+3lJDVM2YyJypQW5FnVmNEUgCC12rRch+3DgXu+I/QyrFrqLU
BvZqI+WpGJ7+zhFJaCEBrYjOF9lonQoRdEbZSZzxbvkMhpcD3pvJjBAufeGNDVJL
JBDj7MZFkkrqNIGSIpUydGv3upDfcvz6B2x5UQXwjDLvT3P2B7QcOdPwOyuQimjr
MHoh589xpTRhToVUD1Av9gCHfAxbaMXjfvnXt2xzE0JSJg5kurVkAWlIcxfm34yi
OSwwey0r6+vASUjzUzp0BJNnwUKpPzoy/wi6F/56+/1vr7uT9E3g0K2HFMLGKViT
8QX3JuyNX1iGt3ogfJBp+UnYo4Jc/FNi8Y6pACWFUbA6msLXrH3vXnA9YoOrsK9O
xD1PNuyPqgd42GvcCVpq36cMK+q53hfXUziOL+1tffabhnYCW5I=
=+gEq
-----END PGP SIGNATURE-----

--LAYlhfFXPu0ocbHF--

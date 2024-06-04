Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36431411D8
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 07:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717486992; cv=none; b=JGZt/3lcJMLtalKNK4LNDsi1bBiCFLRCKCwfz8BfefpQuebeGvQm6EFyoldvEy8vXCqgBdR40ZsPQTxdK8qWfW8No1yW0V3hKb3llpPy74aHV5Iqd5Km78KUfzJxdw06DH5RCOWGHcBYMvBhQLvFKpLoY8kEwJLzLOl/tc9NXzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717486992; c=relaxed/simple;
	bh=ab4RpZ8DPswHyIv3pLJEq5FKgCEAnrO27s42CaIRPgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxGiGL2KVD/OVnedO3UxtNvZ0snCXsuW2lJ6mj5LsjKCvIJMjeiQ7Tf70DwPA8B9taK/38Q7MRoCh5oNurUEELlb30ZlagGv9XN495GPDmxsSJOpWDD96V2+RA/HYD4e2DJeUGONvvOinEu3POOC9zy/ADHeao46t7w4BN7VXw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J2TASmdQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JYnB2tAF; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J2TASmdQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JYnB2tAF"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id E72761C00188;
	Tue,  4 Jun 2024 03:43:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 04 Jun 2024 03:43:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717486988; x=1717573388; bh=FB4vWdf3m1
	0AyN4xY8p5XUa+RhaJ6AdTB8V5g+k38Mo=; b=J2TASmdQLSLDXp02hddaTfcbgD
	KJV/nXCtJYbwf8lcrmuqcvfBsbGQqIPISnSqfK2YRtDxoloCLn4udmtBieoItt5m
	1i/KFF86F0RTYuoDlKLfc/UOn8USdqVgry/Z/Zsc635wceZqqtbHyXVKbtiwzL3L
	RL9jzCC0t1gezzmmEGs4PaYhMEYWY7btsJaDf+FXHfXor2BOmfunKYN592vNExso
	pv+WK2+ZwFYRk32kPfHE1tYgFF5vgMs4EkDu/r8oYbLKYnqkptrhqIoxMW90bp8y
	Qjw5Lxy0CCevLL0QV8nNaXZXvHEJgOLhBjwK+O3rTTYFyD7RWi0bwmDjShyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717486988; x=1717573388; bh=FB4vWdf3m10AyN4xY8p5XUa+RhaJ
	6AdTB8V5g+k38Mo=; b=JYnB2tAFdi+xucFmfWeN8ju6xQtMoC595rqlM03wwkKE
	YZhDyD0MyzTqWWdOTLI148qc4kfjgVifrqlqC0RksUagSpmwlxj+daiR6tB4MYVa
	QYArmfF2ugNs8EGr0nEpYOmaNj659IcswcZ1SJZ/7KyUGBrN0eKA9jUPUI9qthA5
	BiNiJ0Rxf7RpS1LcxgLO4vaRqgLrh51EYJsiLPTZtcJHM/bplbZ60/ycBGIYI6mi
	9z4CIRD095NCXL/vXW75ebNtuhfqtet7SRYkOg0tD+8EKL8adyDN+Wtdn+Gl7ecR
	T5PFZMzBSTY/Iuiha4zG12U9yst3fTxKSa1qtU5EPg==
X-ME-Sender: <xms:jMVeZhJ-czuYO_UtmPsOcSk8BoLVTGt-3-ihzqdHeXADWMmLh5cd1A>
    <xme:jMVeZtL1_i8mGjyPP1yjhvoeijQ5APKRsPqeUuvDhF7j_6MVKwUGwZPrJyXmnsBM6
    Mr8Vn31B0CT9mBFrA>
X-ME-Received: <xmr:jMVeZpuuYTFjMCIx-s8CCRSsJ2KYS8defGGv3Z-iAbmuD8FoHdOqGa3Ofy1deM5Vkm0QsSOObC2XhlX-VHbDBBAxM80dzIVfkKTNSRrzhQcQwdQj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelfedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:jMVeZiYGPm-_m6W9Q3ac6VsZdsXZw-ZoxtvNNWp_aytmDnahWIb5Ag>
    <xmx:jMVeZoaGOvJZBKnvBNtSeuP7ooLW6KWVqq5zyfedFoH3EgjKRp4Hqg>
    <xmx:jMVeZmBHNnCJ63KwM2pIquu7fybY3JUy3zADmk8PIPjKKX9iQsXn4g>
    <xmx:jMVeZmY1WgrchOKuQYy-lEMYoEDX_GFeET5bHar9jcdTNLU4Rqq79g>
    <xmx:jMVeZnmeQfv4QkNSfXZ-CXlLMdRXQk3PBDQuVBAK5oKdE-6gpcnrGwkQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 03:43:07 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4a35747e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 07:42:41 +0000 (UTC)
Date: Tue, 4 Jun 2024 09:43:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 13/13] sparse-checkout: free duplicate hashmap entries
Message-ID: <Zl7FiQ5Kke1ZNq2R@framework>
References: <20240531112433.GA428583@coredump.intra.peff.net>
 <20240531113830.GM428814@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KAcfVF1LW5ZRG5Zq"
Content-Disposition: inline
In-Reply-To: <20240531113830.GM428814@coredump.intra.peff.net>


--KAcfVF1LW5ZRG5Zq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 07:38:30AM -0400, Jeff King wrote:
> @@ -533,8 +534,14 @@ static void insert_recursive_pattern(struct pattern_=
list *pl, struct strbuf *pat
>  		e->pattern =3D xstrndup(oldpattern, newlen);
>  		hashmap_entry_init(&e->ent, fspathhash(e->pattern));
> =20
> -		if (!hashmap_get_entry(&pl->parent_hashmap, e, ent, NULL))
> +		dup =3D hashmap_get_entry(&pl->parent_hashmap, e, ent, NULL);
> +		if (!dup)
>  			hashmap_add(&pl->parent_hashmap, &e->ent);
> +		else {
> +			free(e->pattern);
> +			free(e);
> +			e =3D dup;
> +		}

Nit: code style. The `if (!dup)` branch should also have curly braces.

Patrick

--KAcfVF1LW5ZRG5Zq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZexYgACgkQVbJhu7ck
PpQyKQ//WidpGcL5HEhpk+5EAjntPBUKikyTPPMf5K0e5jmmf799zVzvZPvZL2Jg
zGfBBTyhrfekkxZcbwx5AocddWRxSysgkLzu//5R5wmPDc0e9qXfRv7abMRAizT5
Z3rO5gZ8c0ENGw7bk/6WOjyZopbZWjkPgoORO4StoXOfPfC6vP/tFLHanD3NUIba
C/fEvF825Uh00Kuq/iuW5fSoAjGIzNYdAlzMlfFmclaJnUDTbcu2Lk5DRX1N2UD1
H1Ha6LPiluPh3Y7voh3YcR8WUbu9yWBOmUClOjX8kJpgVeZqc7YuscWGryC4gJLb
pocgBZdG+QnmFDAm8TsmUapj1G1yTGK4vNR/pleP4HmQQkn3/KP6sFCH8t3Pz4zv
0+2hSBbJRbOXZ5u7k3yOF4pys235LuuyBfdf9RtJJy9ZdzswTo08j+A358BVdu/k
sbuIKdfxIMK/wP6RtYNqCoYKrub+VYku3mOtFeCZfQRL0bQeWpJRwLHGN2tZC7uU
Yv8kwc9vwVuddLVm9E9IlE4k7aYMDgi1PX+XsvgyZjZzYfJvDpJ6RV90HXWi5sCu
3LFfZMvQhHsxxZlK5GvVgrxajRKQN1XqhI6W4/wTqFHShp5VZaZwGXL+kUtDnF6G
jBvBlTv2w89SBJFZ6SxnQ3BUS4dyK+qDRyWpcdvEgzHzPAKASVw=
=k7ME
-----END PGP SIGNATURE-----

--KAcfVF1LW5ZRG5Zq--

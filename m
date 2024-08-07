Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE2E25622
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 05:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723008243; cv=none; b=jSOjcqKkc0rt2WPSOJTyVcGPaogFvaTVEuwRAjFnPHmJxI6gi6/BudkxYTjxoyBs+2fjZ4K44SNGZva7nZQfOitMZ4th8G6/iTEV3uLyb66wtoASeRGxqQWYwJjiS47yHova+Yl/GDoBs+v/IAeGuf5zFD1G2XGgcejPcl+RXxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723008243; c=relaxed/simple;
	bh=/kR8uKPmq1l1ei8on13snekeZLsZKPgXk2OclU9gLbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6xqZLHvmUqNUGqi7lYArM+9dni+VjmatidVdybz4uD0g54j2s5+b3TBiLg26njFf0UybQxOBIFwqrg5cxOWkQMjnmxcpw0lY5GN0BY67PzaN3Q6ZT06SHajl7EpAJr+THlbzPzhoxc+CX5vUXpa0FMk/FEoAY7sM0PEbWzTmpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nvaa2I4L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C09k4i/l; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nvaa2I4L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C09k4i/l"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 99781115100A;
	Wed,  7 Aug 2024 01:24:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 07 Aug 2024 01:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723008240; x=1723094640; bh=GIWu4oh52O
	uqulEYmrXf/QizmckvGQ0DYCcBDthriK4=; b=nvaa2I4LLIevbTvlCcBaE7/LZ4
	KdoOwpCvm+5XQxz1bj9XIZtEpoiIhEE8PtckTKCxkYb8GFDxR77M+67eo7GS6DJO
	K/73VBFj/AcRjmjEjIqQO5g/5aTrno0gahwV7FjFLTQBNIIjf0uJ//nVIVINY/kf
	00H1iNlhpMKZQOtIIKAisHWejXkUXNQqNoqUGAZmlcRQYBA8g4jdOzrN+0lsWbQO
	4WGyKEeGQbbti9zMhLZZnDS0MQxHloYy8DnFMmz2OoDovaMrYt9csZSKrP0qtdlF
	zzoAxXvpdquLxH5yY/ZJQxM9OceyAJq8yUDtbW1oqvkJlH0h8x+QLrN+iV7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723008240; x=1723094640; bh=GIWu4oh52OuqulEYmrXf/Qizmckv
	GQ0DYCcBDthriK4=; b=C09k4i/lbtSIdZXUJaS/HgFZ1c7cPvrTyFhqvlmrDZGv
	HdGTkMPTuB3mvQrH9HahcEuY/1ggyL+xAmgZJz6Zp/mwPs0uBW0Ia0sBwELaqNRe
	u6l/qDoDe1vwD2P3ep+eMHooOiVcx+KpPXfn8oRl/hNEBowKTRMTZOwc/1idC6Va
	icbTOpANELSN1XorbEmNi8F1E1sHCzy4yw+qmNk91CkPSuybnOMSzKc0eZrQSusc
	NZXdyWeuMZ3Yzuz1Pyk6wD+KAzjoTxnHmy308svIFzA2awacupG/JhdSUkVuj7x0
	ve2WfZLrp9PZwhbmbZVPkHJiB0np3FbscIduBzJtJA==
X-ME-Sender: <xms:8ASzZl3mqQ4iamJe-06e-Ah9c91M7c9aLAjBK_-kmegWSS1L--Krjg>
    <xme:8ASzZsG_AC9YqlHhBGQfLBIzhKpor6-Sncl3qn5CNfiQZ-AQ-Qo6tR2QBlfUNnVF3
    BBrPs7y54Rpf-fMqg>
X-ME-Received: <xmr:8ASzZl5j5cqTjPTRqrQUpBi-nI2PURkZe8H6YpdjZycbVGOh2lq1HUAe1LITb4AC-X2MzfPPBOnOWEjYh2cj3gj_PiGnMcG_wdpEOFwi8KeKwIs2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:8ASzZi0vfd48tfqSyXLL6gCGrTIzVKRpzQ0cZ1iQ3PRAQfdvfJEJ-g>
    <xmx:8ASzZoFIb_MJxt_s7vWfKk_7xXKzwpCbVhrV0_nsTtVBn7mdcLQuDw>
    <xmx:8ASzZj9hWNe_QAyc2Op7ukKLKrw2lYdNyjnm8kBzjaRmAtkk5se0dg>
    <xmx:8ASzZlmTsdJO9pmnpx9bUub3jhJ4hO8DCoWnxknZrqnWb6RjYpHvUA>
    <xmx:8ASzZsAPjrtHaeS0FFx8GV1FDLxP-JUuuEuTZ_J7ZF6Bybex0hc9D1PP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Aug 2024 01:23:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cab3a881 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Aug 2024 05:23:55 +0000 (UTC)
Date: Wed, 7 Aug 2024 07:23:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 6/6] t-reftable-stack: add test for stack iterators
Message-ID: <ZrME7SDUslFm4FqS@tanuki>
References: <20240806142020.4615-1-chandrapratap3519@gmail.com>
 <20240806142020.4615-7-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2Tntcd6fTBSohzUY"
Content-Disposition: inline
In-Reply-To: <20240806142020.4615-7-chandrapratap3519@gmail.com>


--2Tntcd6fTBSohzUY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 06, 2024 at 07:43:42PM +0530, Chandra Pratap wrote:
> reftable_stack_init_ref_iterator and reftable_stack_init_log_iterator
> as defined by reftable/stack.{c, h} initialize a stack iterator to

Same remark here that Junio posted on a preceding catch, please drop the
space in `stack.{c,h}`.

> @@ -521,6 +521,87 @@ static void t_reftable_stack_add(void)
>  	clear_dir(dir);
>  }
> =20
> +static void t_reftable_stack_iterator(void)
> +{
> +	struct reftable_write_options opts =3D { 0 };
> +	struct reftable_stack *st =3D NULL;
> +	char *dir =3D get_tmp_dir(__LINE__);
> +	struct reftable_ref_record refs[10] =3D { { 0 } };
> +	struct reftable_log_record logs[10] =3D { { 0 } };

Again, these should be initialized with `=3D { 0 }`.

> +	struct reftable_iterator it =3D { 0 };
> +	size_t N =3D ARRAY_SIZE(refs), i;
> +	int err;
> +
> +	err =3D reftable_new_stack(&st, dir, &opts);
> +	check(!err);
> +
> +	for (i =3D 0; i < N; i++) {
> +		char buf[20];
> +		xsnprintf(buf, sizeof(buf), "branch%02"PRIuMAX, (uintmax_t)i);
> +		refs[i].refname =3D xstrdup(buf);

This can be simplified to a single call to `xstrfmt()`.

Patrick

--2Tntcd6fTBSohzUY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazBOwACgkQVbJhu7ck
PpR6/Q//R3XCaxjeCyzN7F0lsZMLcoH/LKgth5n1j1ASVkjB04XnTosUqrPCjGhd
CX68pZGHH8Phdr6uXCCaz6q8o3/So5MZ+yFf0DRr2CMpqWs4PqA8TvPS+t+mSzLB
8TUEeN77tl0WoCU9ArKoVA6TWICjaucAZSLbHgUlTHKMWrKdLyo/5u0oQ1u7OdxU
0TsTYfqBRbPU22vdQEg9JO/93WosFGdfeArXeeQcYkyx7Inv6FQu5TDe1WrV664/
sDAGmy4lmWZjMEE22+r/mfalVK2SXHxzyg/35AjAfp5ZMXmJeL2nl3DCF9G9Ynyq
XPi9cuQFoeg8t8PGB7qAOjuUtCl4O4u2X133FfqH6k7FLzuLqO54P9tomQzXjaVx
pLN23jjgDuYAUe1xM7bo2Y+Xo6/MmAJh3RWMcPx8LLC8vOm50H28mryUiZqoBNNJ
vy6hR3XpxZXoDr6HZsrhjOb9Ec5BhXaAnwXWMpMYjB6bO8OpH63ZET6lRWK7TgC2
MLAJP0P/JOoQj0dGd2IUjNr/YtSNKEnBDilYHwGIQDe64W5HnLq6PfbDudoFLbsJ
diqpf5KxlQnte/bxna3/46FEKdKEje7LIXtwzIGsBvVtDDdaWfPnlndfwZ7B0/rY
gJWAir7OjxxFwofQ2MKVxvrEwFmebyITI4CvxCwV7PoVVb/ul7Q=
=gDLM
-----END PGP SIGNATURE-----

--2Tntcd6fTBSohzUY--

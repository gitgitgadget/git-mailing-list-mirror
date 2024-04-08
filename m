Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40351118B
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 05:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712555096; cv=none; b=NiV+abyC5iq4JL5qvMWELkFfdN2UqKAsN95QIuB1g2ywBSffsJBmpjMESfTrY5KN0EQnIGkl6seyfS6N5zV8ErzcN5WGEfvaa2aKO/1ML2Wjj2aJ3sHy3ZRlB7GsinwSsiozGtf6DbgxMjOBEMw7M5kIFDQK90vt6kFbx0zXC2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712555096; c=relaxed/simple;
	bh=SBNbpT2q5Gb32vJCZtyGUGh1WSCZ0R0lDeTJBC+c0QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DI9fNgchaYzCqIYbHdRjTZUyk34COCvtnHThDdq+AOVnxaIFFbwrLy7/DVcpik7n4vVyAzCxpRyHrP+pjWKPpwthXFJS3Bk/E267dvE4CtL6y9XpQADcF3MKgPuVPjC+Of6zezMRuw5tcQPMeT9pQ0o2D2Q3W9SnQ/wTPigGu6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ljjcuM+Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DxV84caJ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ljjcuM+Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DxV84caJ"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B19B911400B3;
	Mon,  8 Apr 2024 01:44:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 08 Apr 2024 01:44:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712555092; x=1712641492; bh=3ReKw11ge2
	Q0+IOF4Fk0drTcHJqsjRwZ3uPm5/tEcQE=; b=ljjcuM+QKZq3pC/9qNo0x8FnQC
	XDeelXpfkRyx382Y5huMcgV9z47jE4bXn3hnxBg7m3iTZdkAKIiiyRzMGrNBJiLl
	4LfjPz/EXIbdwRdLYp8SwgUDGtnK2iuq3vs6d7IqwS1/SY4MUxCm+CMgzSNbR5Qm
	QLWVZE1V6jkVfnFf6VYIh7Sy/COZHAxanK3aIyBXATAUq28h3q/kx7gz1MazxlUy
	INjl6JRIrBjw72diW/ITmLAwqd5zDKZLkXyDtedLGkgiFMAtQelyUp4dR/nmdx+P
	lDQo3nUKTN2f0gGkeo+lvRg5HV/6OQUnAWcOLqBp1lQQ9eUMQ6VMN3tDzhXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712555092; x=1712641492; bh=3ReKw11ge2Q0+IOF4Fk0drTcHJqs
	jRwZ3uPm5/tEcQE=; b=DxV84caJDoekMn6CTJ+1cJMbhJP05vAimHI36/MLajs9
	MtB65EyXT7CrOcFXdxDAeWhBLYi35FXYgzfz/oDs3s5fvoUXRYzp532TGfWPbLr2
	MBb9gsVEkQSWzJ1dEt68Myty2thh5ZWoNK4cGCuS4NbMzdD9bMtjvqJ619M4qqdo
	NX7p/QPfle7i2qOlGx2fBhxiN00fwmt7qZkmViAPKaDjrKz67qnctjWykW0calYJ
	KT97t3xyDAUO2uWZZt8AD/mZcqM2jBcq4AJwKh8J0fPjBuC/I7wlzOeFxWnHjB2m
	M+rDaIKQhAh4rnHktKpLaUs1SbjZts+c+keVkPzYhw==
X-ME-Sender: <xms:VIQTZnvCgakWUdYZSpV47T116IK9nCJTr_-ySW92SYBXuj54BA8asQ>
    <xme:VIQTZodsVPyfp74tPPB_AgY2DNfVpDy-RtOBUdWHPdoxYbGKk8JPtMlQBmtAm8eIh
    ygxaTT7pCQXfvBVNA>
X-ME-Received: <xmr:VIQTZqzXR1_mJIcMYShGY8rHH4Ap_dmJMPxZve8S8VphsFyZzujrNS23uUAtFoKcUOeaoqqJSLxcqOuVY650VtKUTv8901ibGBKTxy3gcxMG2ViviA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeghedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddunecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeefvdelfeeuteegiedtkeehleffkeekgf
    ffudfhuddvfefftdehkeeihfekjeekheenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:VIQTZmPIzlx71RfaPFWx8dDsMHlnsmwqZyYY9_sRAKOAfp3Vv2QfQA>
    <xmx:VIQTZn8InB1TWMUyLsW9BE_F0n0v44CE1Ehxa_DUJjztqGP45-7ZdA>
    <xmx:VIQTZmVUDEOwpRwHMayOB8GgGZHvcTOuDEig7zSzO3aCgxTrQG0z-A>
    <xmx:VIQTZoc-zHWklk7QbnUPgbms06Uu5flfVDf8U2LsSAfA2EWmmBvWHA>
    <xmx:VIQTZqYBQyC6RoZLk3kqMi5UxhLXDUkQkdLrNI5Yjhpj-IV25jXTPdMh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 01:44:51 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 97929d4b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 05:44:43 +0000 (UTC)
Date: Mon, 8 Apr 2024 07:44:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH] reftable: use xmalloc() and xrealloc()
Message-ID: <ZhOETox9FTIOAShN@tanuki>
References: <963961ee-0f1d-42b8-8dda-5838e7a2ed94@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dsfz8oWnQhwwa7IF"
Content-Disposition: inline
In-Reply-To: <963961ee-0f1d-42b8-8dda-5838e7a2ed94@web.de>


--dsfz8oWnQhwwa7IF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 06, 2024 at 10:37:55PM +0200, Ren=E9 Scharfe wrote:
> malloc(3) and realloc(3) can fail and return NULL.  None of the reftable
> code checks for that possibility and would happily dereference NULL
> pointers.  Use xmalloc() and xrealloc() instead like in the rest of Git
> to report allocation errors and exit cleanly, and to also honor the
> environment variable GIT_ALLOC_LIMIT.
>=20
> Signed-off-by: Ren=E9 Scharfe <l.s.r@web.de>
> ---
>  reftable/publicbasics.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/reftable/publicbasics.c b/reftable/publicbasics.c
> index 44b84a125e..f33a65df34 100644
> --- a/reftable/publicbasics.c
> +++ b/reftable/publicbasics.c
> @@ -19,14 +19,14 @@ void *reftable_malloc(size_t sz)
>  {
>  	if (reftable_malloc_ptr)
>  		return (*reftable_malloc_ptr)(sz);
> -	return malloc(sz);
> +	return xmalloc(sz);
>  }
>=20
>  void *reftable_realloc(void *p, size_t sz)
>  {
>  	if (reftable_realloc_ptr)
>  		return (*reftable_realloc_ptr)(p, sz);
> -	return realloc(p, sz);
> +	return xrealloc(p, sz);
>  }
>=20
>  void reftable_free(void *p)

These are part of the library interfaces that should ideally not be tied
to the Git code base at all so that they can theoretically be reused by
another project like libgit2. So I think that instead of rewriting the
generic fallbacks we should call `reftable_set_alloc()` somewhen early
in Git's startup code.

It does raise the question what to do about the generic fallbacks. We
could start calling `abort()` when we observe allocation failures. It's
not exactly nice behaviour in a library though, where the caller may in
fact want to handle this case. But it may at least be better than
failing on a `NULL` pointer exception somewhere down the road. So it
might be the best alternative for now. We could then conver the reftable
library over time to handle allocation failures and, once that's done,
we can eventually drop such a call to `abort()`.

Cc'ing Han-Wen's new mail address as he no longer works at Google.

Patrick

--dsfz8oWnQhwwa7IF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYThE0ACgkQVbJhu7ck
PpRR3w/8CdU/lanl760OPhXRF8WUc0+3sLYEeQfUSGn9BFj11owL55QoIDPhBgN2
jsIqadCb0oUFH/2iAOyDbNYqnLN4wfhrtZfLISnXTrxj5vtu52TlDZ+3oSZ5mHuH
/m5gWMNmr8d9T1BkYbj26HyTSvGkA9F3oD8igmUMxjV25eFS/XFbUjygUG1GVVmC
Y4yGI5qiLbvnysSQ6r0yr8irPqVMQjfeDTWEjvdbtKg+j9vV8xolCXjBcfGCzkzy
h9j9k6cW9xgmJFIrIjHfpx6olH+DKyWYvcF9soLrdZGX7hjAbeyCzP5m4BoYr1wM
t3gu8ISIkUu1M6mQWAd13D1Kkjq37c4Cr5J3EgMtCnZNzdkIwR98aIdvp48Ik5Pg
MKcN7rtoyTmUden3nu8sfaQHOLfv2li35fOqG+HRxOG+Ymq7LCCvr6vXjJlf7Dra
oJahTL5jBJbHENoNvzWLfQLXllBkpqSPc8kxfTq6BS9bR9VSI7KQI7VgQm6IjC6a
Qbwfg0S0H4+mXScntR+yActXffdOunyBSJkOyyIff7zKdjAgdrDKhdzcYxPEymNR
NgCndW2W3v01PBBa0JGZqffNVJxTKFxsz99Cn9iWgIunSpzvzypYJ3Juo7PrH31j
Ntch5qarj6R7CdT50jeZQyZ/q/Odymas89r2r5V3Evnh+HpPvsY=
=bZkf
-----END PGP SIGNATURE-----

--dsfz8oWnQhwwa7IF--

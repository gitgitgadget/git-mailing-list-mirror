Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8160139FEF
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 11:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717674550; cv=none; b=svj6uneQd5+xbhIHOo13YA96i58NkpRvKY40KiD4g9q8C86dkFvSTee9XiOaKueQBfeyW+19bW39zPpifG1wUnFEMFhMs7UUOPSxv/ryb+6qlMwlZRvXnmbT4w0CHfJ1W8Wp2/37Ksys5/Z+KS9jdLiCcrAGO5zdBQ5aQuO0HiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717674550; c=relaxed/simple;
	bh=pYZlIWuOAmhZBUl8cCOyWD38NOE1nB3Wz5C81HchzB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKfbLUwP3G88L3uTlQhZ9prW9LxGenPHCjxpq0yD1rAb0ykaKgXThvCFxWXiSh2e6jMaCzsOH4s+1tuOAW+u7ZacAQRbXD3pFdmZ7bfT8RNQJdtYfP10bkNKBYllK/wA/T45nAvS99Xx8fDUwjSQGCGWXREMaq0uJwaf4HzIids=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WZHwzOXY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eRJP8vSJ; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WZHwzOXY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eRJP8vSJ"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id C8989138012C;
	Thu,  6 Jun 2024 07:49:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 06 Jun 2024 07:49:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717674547; x=1717760947; bh=H/lfzwrzaC
	k0Deh5mWX/k2hTlfEaIOaVsdn/pzplTj4=; b=WZHwzOXYsZ2dGqK3uM0SEojh1+
	U6zYycQ7XCvOE/ynKxMm5seLpmzXvPpCKaW0XqBuvzhpjkCrDGzRbT/rSkhxEzSc
	7VQu1GASVjIU0hdcrYuQLjZrlUhOXHnq+4Iv8E7+6kf8V+VC7Xx/plI9DI39LB++
	50f8hNBjuLkvYc9xoKJfDqgIgV1lVWm0+raCf6jW0IQXkVfuycMpUi7apGwOeiyO
	FWJXVJD8mvNJf6I7S8CtdVNq6l2xuGSWKHAL7BpUi+8p/JvMx4Dks9r4+bocms+x
	fyfXrspcKI/TI1C3QielqSS+hN7S9sPLVVAw//WJ8xlgPZS5q7E0oE7DWr5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717674547; x=1717760947; bh=H/lfzwrzaCk0Deh5mWX/k2hTlfEa
	IOaVsdn/pzplTj4=; b=eRJP8vSJ5Jel2D/FIbdIsKPOnTBWXT3iqYxG3tg7JTwU
	5f0pzJGA9mUA3q9QC0hIHzaqjqKbl4Oz67xU7BlgtWxP56YtSN36kz4XfY/ICUGy
	sowu1CTwF/ggoB3mirA6ZFB03yniZD+vF9u7OsbYumageR/Pwb2RLdU1Ub0YRPLT
	AUWZ3kIkx5w5nPT+CGEHR8LuLnPY2iKDgQhHs7bWYnWTU5oJtbYORj+dCkAxkrsM
	xkmMZdA8zJqezIq0VQM352S8EbFDsMaTkCB2CRSbVy2ZTsbZtvuviFJuzKsjYfoi
	Q824WamAYmQGgrzA+mrijueGl5S+g2tccxluVteLIA==
X-ME-Sender: <xms:M6JhZopi2rFg3lG8GhzMw0D_vugRudoq8l2CuLx21RhR1GVxRy7amA>
    <xme:M6JhZuoMsrkD-Oq78-8nM_ZISd4S_Tu2RUaFjLLXZngEjnV5p_NhGVEdO9B0SHBcM
    shihx0Gj5G7xHw20g>
X-ME-Received: <xmr:M6JhZtMTgtP2dAZIx1zje5zSKnqVicc9Lztdk3uMYVNWLzDiYumwk5v7bjCoPGaw4BcFUHXm281aXxp_9eRQWTkUXcw6lnJIhZorUPhC_0KupscJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtroertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheefhfeutdevtdefieetueeggfefleegleevheffueekleefhfeikeetveduhfff
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:M6JhZv5umXE9ZowlrBuyHO9JQcHzQYwZKrxJbiI2z-HO2q-oNkFV0w>
    <xmx:M6JhZn46eArbHMRLn4LFRW71qGrn1FxH9ZiFbf8QuXL2ZRZ0m6pajw>
    <xmx:M6JhZvi3zCo5_Z2oOMIB8xyvX8ulvoimq1X4ycmRqA7SViNB6rUk0w>
    <xmx:M6JhZh62sEEqVvQATkhSEE85dTLIgvrzryMrNETY4gDYjlC9kKnpaQ>
    <xmx:M6JhZpkkJy9ma1M_QW43FDQVly-f6fKzD6SRXn2uYw3EOGtvqIZTo-88>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 07:49:06 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 25086aa6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 11:48:36 +0000 (UTC)
Date: Thu, 6 Jun 2024 13:49:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [GSoC][PATCH 6/6] t-reftable-pq: add tests for
 merged_iter_pqueue_top()
Message-ID: <ZmGiMPHyVufQYKwY@tanuki>
References: <20240606075601.6989-1-chandrapratap3519@gmail.com>
 <20240606075601.6989-7-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="P6y3h7NAU7wmKn6j"
Content-Disposition: inline
In-Reply-To: <20240606075601.6989-7-chandrapratap3519@gmail.com>


--P6y3h7NAU7wmKn6j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 01:10:50PM +0530, Chandra Pratap wrote:
> @@ -59,7 +66,6 @@ static void test_pq_record(void)
>  	merged_iter_pqueue_release(&pq);
>  }
> =20
> -
>  static void test_pq_index(void)
>  {
>  	struct merged_iter_pqueue pq =3D { 0 };

Ah, you drop the newline here. This should probably be part of the
preceding commit.

> @@ -98,10 +106,49 @@ static void test_pq_index(void)
>  	merged_iter_pqueue_release(&pq);
>  }
> =20
> +static void test_merged_iter_pqueue_top(void)
> +{
> +	struct merged_iter_pqueue pq =3D { 0 };
> +	struct reftable_record recs[14];
> +	size_t N =3D ARRAY_SIZE(recs), i;
> +
> +	for (i =3D 0; i < N; i++) {
> +		reftable_record_init(&recs[i], BLOCK_TYPE_REF);
> +		recs[i].u.ref.refname =3D xstrdup("refs/heads/master");
> +	}
> +
> +	for (i =3D 0; i < N; i++) {
> +		struct pq_entry e =3D {
> +			.rec =3D &recs[i],
> +			.index =3D i,
> +		};
> +
> +		merged_iter_pqueue_add(&pq, &e);
> +		merged_iter_pqueue_check(&pq);
> +	}
> +
> +	while (!merged_iter_pqueue_is_empty(pq)) {
> +		struct pq_entry top =3D merged_iter_pqueue_top(pq);
> +		struct pq_entry e =3D merged_iter_pqueue_remove(&pq);
> +
> +		merged_iter_pqueue_check(&pq);
> +		check(pq_entry_equal(&top, &e));

Do we also want to check that `top` is equal to the expected entry in
`recs`?

Patrick

--P6y3h7NAU7wmKn6j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhoi8ACgkQVbJhu7ck
PpRpChAAkVZfPDT8s76uXkF8gjkTHnWrU1CmKUdkcdlmyYFqAfxzk8UDlDm+ybcY
k08NAwTeoOwpfWuWs1VIRT25a05V7kdXmidFzArz6FoSlwCfdrHVzNgePqjwESUq
+MnkuKcXeieUTJbwdxkcubtTGgEpH0660FBZzhAEAK13p/pv7r3UGAM9eJtI7iOG
zLljUxmClbpCq2jM8U3zPwd8yLOfXGLQNBMXR60x+xzxhx4qnNroRnxoH3HkRrx8
izmlHBdk7Pp0gMAnbaF3RUX6NBIXPpvBFeTgH+0F26ybGUw4hHvsoHHYmgFVf6kG
l5HRHvwi6OedQbzE+Qo2FKpC0pWuaGI+P8striE290/AnPE143/CzqTR1eGcAHUT
Sv9+Jf/vZTRoeqMoIQNey7paTXrmgspO7kfPvBP+h/Ksu+hxrHxnPiF5Zpb407mB
JzqRC05aC2FtPoQG9aHazFEDcZSf/D35WaEWyenrN40Zw1pVbMuyREjdB+GFULFV
nrKQxdGtxrb/BOwhOMqlMcw6kT4YhS6DQGfNSqhbtRjoNQPxqrqw353wGThIGtuT
kjgxIzscvEvBAmcB+D8E2Yb17ojjOXCm9oavZXhNVCvq1BXBvWb0HBmj0LM/nRsO
MrkU4aHlnSKc3AzlTtbhVLRW3N7l84FB8x+U9314+mU9p7AbOFk=
=JvEm
-----END PGP SIGNATURE-----

--P6y3h7NAU7wmKn6j--

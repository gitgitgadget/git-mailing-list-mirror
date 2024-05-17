Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF7D1863C
	for <git@vger.kernel.org>; Fri, 17 May 2024 07:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715929741; cv=none; b=Ay4kQn9U1VYlh1qLQ93WsTVcxb3kewPaXqCdGAt90tVWTQLERaKW72eW+ofgW+ttjfDnG0w43aEaeDFXyxQfsm32yPwalGZ4V30rIK/UGQrvG2DGP4HaWhwMWNeG56r/Ncr98aK1oj9T24lHqfMxJEo0Tvkb2nWFxB7tODkM3xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715929741; c=relaxed/simple;
	bh=AVxiwphEVHlfYZQ737wqxzDc0r+B52p72/wzxUjvEfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBDNP2DkbEm8XSLnMnyFeRR0NB373UQ2JUST18kOUOfTAIfTm7rLxEjiG3cUp4llU4VGTxcFX06LmWMCF3xhRhHbHIDv3VVWdxoW+ptpiuQtRVZUprQPZsOMvCTTpc0D3bpNPl44ojAv/cAocFiiGF1ZS+5QEsxwVa0ZZBwse24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dCq8XYtp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nbqfhf8s; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dCq8XYtp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nbqfhf8s"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id E27B0180016E;
	Fri, 17 May 2024 03:08:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 17 May 2024 03:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715929738; x=1716016138; bh=svT63Yqdof
	r7iq4OevGHVtrE/1ry+K0Fu3luXecghYA=; b=dCq8XYtpheHz1oZWKfhyI4FZR/
	6AWPnJIVfR+gnhHJ0ZVmHVvBB+YCyAZ7JHK3t+m/10SqC2F+x53aMgyoZPXmg92c
	Vvz/Es3kv6LpgRppPe7+1szbSZ5Ff81abNiIGVKZOB8h9EyndTWyKDxlBcwMmr/4
	8MAVEir5nSZwisTPH3HB87GqjGGMazjwWe9JmiaO0v1mCdwOxbD7NTxMagzJDUS+
	g9j+vfYYmtSYHTrpemCsp6pcCI/n9/3TBBdnCfFp1rQVN6xyUqG15nYCE2/EKes1
	8pj8petg8ng6laklg9U88u1EffE0A0isFyWRbXYP7V8BeA5jwa38IlNoA2mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715929738; x=1716016138; bh=svT63Yqdofr7iq4OevGHVtrE/1ry
	+K0Fu3luXecghYA=; b=Nbqfhf8sbCtasXlTr/ZRoZS53EVvOyyBRC32eDCnEijh
	S+DlIAGorY78wwi9IKDWqB1sM4fUKUwV9nZXCB4mQReANJbnA7Ug4hcNpYl5YiOd
	wbfGV2JIhNV3uQm+f1QpcTnYwBLxjKarQx/PrUSBynb4WPFhQSfPov4BcEE4YKEy
	9CsFP09zterth5t7EjFSls/wYo2kwqe+sdwlXSKg/vVlJ4sqYnXnga5560bs8qVv
	c9/uqU6XihZ3r/5vIoXS93wx2fFNfIbZA7+HwUScDu+mtDjjcGxoBABk/gc9V/1b
	bUwdhBfxpphEUWEARb/5c0bCWWhVYSk/P0sQUDNDVg==
X-ME-Sender: <xms:igJHZl-IXz72Po3Qfmz09vnGzHJ4a1hkYAEfwj83BRzfsl4rGImKLg>
    <xme:igJHZpuGvMQ7i3OrfqeQNHG-PXhmbkh12mXjC0Z1R18kqHTooQsP8Y3JEc7xJWX6k
    Jae0DXdLDvQDOepiw>
X-ME-Received: <xmr:igJHZjDqeJ1CZNbKVN0SpWkzTn3lLp-JkPsrABFDZWjgt3KIQvhMifFPQkpEmztEw1sx3dqZEAqAx-PSpKDC8UkzXO-qZbT-llFJ8d3XY4PWEyyu3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:igJHZpdCBniiLhgBUnuAEbyPPqoLQCIcHDqgN-aMcQWLfJnceY89UQ>
    <xmx:igJHZqPI9Utjp5rcqHBvAGQmut_UoPxUDA93CT963FawOeTHtaWb0A>
    <xmx:igJHZrl7E_uhQoA8i5Cf9xQSWyUDZlDe1HxDHSbqCwuwWsk-NGW_7A>
    <xmx:igJHZkt1nVfnhYZdb7QDTCoiIZ0RTpEDSz7eVhB0k8tj6PJVOpPMjQ>
    <xmx:igJHZjYnpmvfXsMkjK-PiYFA_l6nEdmz-FR8CGkYaFIcSLF0XspnTeLA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 03:08:57 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d4c902f4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 May 2024 07:08:30 +0000 (UTC)
Date: Fri, 17 May 2024 09:08:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/16] refs: implement releasing ref storages
Message-ID: <ZkcCh3OhbPOn0HOF@tanuki>
References: <cover.1715836916.git.ps@pks.im>
 <282fbe35a7c9db715a8a805f93f9b465d42885a5.1715836916.git.ps@pks.im>
 <CAOLa=ZT3VqhrHXt9x-4DN7norTb3RuscBx+VHipn=QxJvwwThQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2ip/zRLRR652GJrL"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZT3VqhrHXt9x-4DN7norTb3RuscBx+VHipn=QxJvwwThQ@mail.gmail.com>


--2ip/zRLRR652GJrL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 11:39:36AM -0500, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> [snip]
>=20
> > diff --git a/refs/debug.c b/refs/debug.c
> > index 58fb4557ed..27aae42134 100644
> > --- a/refs/debug.c
> > +++ b/refs/debug.c
> > @@ -33,6 +33,12 @@ struct ref_store *maybe_debug_wrap_ref_store(const c=
har *gitdir, struct ref_stor
> >  	return (struct ref_store *)res;
> >  }
> >
> > +static void debug_release(struct ref_store *refs)
> > +{
> > +	struct debug_ref_store *drefs =3D (struct debug_ref_store *)refs;
>=20
> We should probably add a trace here, using `trace_printf_key()`

I didn't because we don't have `debug_init()` with a trace, either, and
because there is no error code that we could report. But on the other
hand it does not hurt to have it here, so let's just add it.

[snip]
> > diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> > index a4bb71cd76..6c262c2193 100644
> > --- a/refs/reftable-backend.c
> > +++ b/refs/reftable-backend.c
> > @@ -293,6 +293,27 @@ static struct ref_store *reftable_be_init(struct r=
epository *repo,
> >  	return &refs->base;
> >  }
> >
> > +static void reftable_be_release(struct ref_store *ref_store)
> > +{
> > +	struct reftable_ref_store *refs =3D reftable_be_downcast(ref_store, 0=
, "release");
> > +	struct strmap_entry *entry;
> > +	struct hashmap_iter iter;
> > +
> > +	if (refs->main_stack) {
> > +		reftable_stack_destroy(refs->main_stack);
> > +		refs->main_stack =3D NULL;
> > +	}
> > +
> > +	if (refs->worktree_stack) {
> > +		reftable_stack_destroy(refs->worktree_stack);
> > +		refs->main_stack =3D NULL;
>=20
> This should be `refs->worktree_stack`, right?

Good catch, yes.

Patrick

--2ip/zRLRR652GJrL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZHAoYACgkQVbJhu7ck
PpQ8pA/6A7dl1A5Rut4Z/3axOxFmhQZknPxxwiTcYdeOrCZLUQmNdlQ4lBV+VIuv
q7NSKguCvSxWQLU18wxRz9p6QLe5UGNDJlYOM/KfoiInAiGQgaZHjJ52ONwKP/+3
zR5oqrdNSbgWIYGSUZUzOG3Pc3/6K7Q8dmlT6XlC8378ot5dwk/HIiLa1v0PgAaL
Yy0FBiLEmvyFMVEnTVUv83Os4hiREKktIoSdZH447im9E2Q5X0/ZAjhQNCqmdiWR
gIjZkfpvJQN2NdPhlB0hmOPHPsOVpqH2nK22PtVWpp/NRmKB4WwNgLrlmfOvNzvj
9KG3FhujYaU3CcavH+IvoXiwSUr32O3oJtl+Jt8fxIP8SaaW8K81JGgi9nO7sCKV
jP5qEJPNmqrlOPEKK/ywTyt7ddP2fJXDfv0HTRK915IKBVN5kU+++VdsC5QD2zAm
4Z6rQy8V5jfEOainNOcBLQli/mA7mmJ8JE2rS6A/pNO6Tzv7cXdgWhVg/g+w0/ej
jdUABPowGA4yQEOuVJmIQ2wJhK/oy62gPCaE67DYWmLWakqpjI7hfoarZZUnN88m
kGyOkpz2cgmHQ1F/jBMQjyHyU5z0HF9GABW+v21ltX6iPSQNGQ7++d/NhEZ9Zzkd
N2XwgsG5k/Fp1yoC9nL2Hq06YQmr431u867wSRQsyj5Iabb7CiQ=
=fCH7
-----END PGP SIGNATURE-----

--2ip/zRLRR652GJrL--

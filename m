Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBF917107D
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 09:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711357838; cv=none; b=L8A6bKnyFUNUWJiVkmq7QfJVAhdbXlD4EoBWEOV8Rpl5lmKzUA6eb278Dy6H8Rpk4DeLUNeesPn20827a9ANkUgGKNk38uywViXGr2ENakolxoN6yq+LvGH1lNQitJAHVd0UPEcyB4QgY4+JYm1RCTkAUpyjnBwP8Qxd0ScNk9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711357838; c=relaxed/simple;
	bh=TfF/a/Y4ARXtAjNiiEVW6xS6+kBiz7Dp4uaPOZr3aTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NS9RqVjlAP5NnqZDCke9LlR5EmJjwj4XdyL0sER3V1FoDE1Qfx7zJDuEh2TCrRGDacePK5YuI29gkfq7XQ9scK5kDpQwQwgf2kGwj43X6vkNIBTC78BL2Vg3ULmFvGbK7Fyasndb7NqH3DZk1LlA9o++jbze/KNuYljHpv+9u+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f/vpxJ83; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fuQh1v6m; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f/vpxJ83";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fuQh1v6m"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 65A681380119;
	Mon, 25 Mar 2024 05:10:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 25 Mar 2024 05:10:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711357835; x=1711444235; bh=2t6GEF8cNq
	Vb/SZvjpc6MIGE0tAE3K1LUCgJtyzWYXU=; b=f/vpxJ830frYhfz0vII235M/OR
	nNEyNID9oSZIrBYlGOQG1hfZK2Vp2Vu6LeCZ7Ztn3mpBEP09SPJ4afT5LWmE1go0
	/5y1XCQgPCF5NM+MtCJqmBuD+oU0E6mSa75fu3vrpeSG1CqczvRg+vxvPZxBdqjh
	ums5EVf8eraf96yQDpbg8QoWi4L1G3ayNJRvQ6DAlxniKc/05ohKrpR1pkb93LSq
	yUFnAUHWjiudnPlp2qPCD+k61wGcWRh4aqqjkdCyQWb/y4mf9viUdqkf1Pg6TJnq
	zVIOAwRBn+fq7lrTRNxpzpg/95tQcEH2Cxl64ABN6zwLiIpnZsyeSUqJ70bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711357835; x=1711444235; bh=2t6GEF8cNqVb/SZvjpc6MIGE0tAE
	3K1LUCgJtyzWYXU=; b=fuQh1v6ms/0F5Ws3+GuBB+cANL0qSDxnJJGoaMm8i+Kw
	4IOd35W7F2/+0DjLwLGmoMw4L/+aVkJSPLdfbYLtMQeOL2PWNWNVi4ocb0Qebzyn
	UTi+0SHXnYbJEJJCthjlgO2CO74Gw4JQA/mOgiS7QhAYnWL2z0RWGMtFbh3SVP7U
	N9MtnVQr3aufnZG+ZA5aSJ3xiScWQVw4J33dC9EtXPbLT9W2WJuLCxzuNmPi7chD
	8mrp4kCbsYrUkUj0VFMe1mn9vfnV3s/EMh4Nig+WQS0CsWfrHxkwFGEkCUQMnp1r
	7LbiSf5m4f951lJFlDJUvyp2Lb1wOVKNRj90eR8GdA==
X-ME-Sender: <xms:iz8BZtNx0L50PgWzRas7Pn5VFC1A_iqaEF5sndtGFEeBDkNaKHoykA>
    <xme:iz8BZv8kfrVcQbzvisv8p0uhdfzFFOYnR_mgkwmFXe-FUKG1m7-braBiZLC3zYoSj
    jOrnEu8dPVecdX2kg>
X-ME-Received: <xmr:iz8BZsQyZ9A0dqFc1Ac7l4QrGPUu8F-Jyu70HjguRpYvBOb4flFDdVuCovicZO7k80PEDyDBK1RT7OkIhNNV5WhImCC1M9SBiHcjBJ7S50AvTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtlecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    eukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:iz8BZpshIH0de84KsxJSjEp5eCs7GP02OLE0crj1MhGjz7nHe2fd6w>
    <xmx:iz8BZldVB8Y_dBDQo824wgF0tnTZyl_xarFD9sjFss-fYo0RsVTTcQ>
    <xmx:iz8BZl0c5oYSfJJ6rUZFcbiFPOr3FRFOHNw_rOVgihx6X4LCtb3veg>
    <xmx:iz8BZh8zz2ubGluVbFPqPKoMDsGGXDu7i0j1ilABVnlrQ3kHWdsgxw>
    <xmx:iz8BZs5m4o820QFri9bwuRqX4kvYhCfqxWeDEavf-DZPyfUU-MptQQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 05:10:34 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7bb02117 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 09:10:18 +0000 (UTC)
Date: Mon, 25 Mar 2024 10:10:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 01/15] reftable/stack: fix error handling in
 `reftable_stack_init_addition()`
Message-ID: <ZgE_ggdkO6ejjuOG@tanuki>
References: <cover.1710706118.git.ps@pks.im>
 <1e39d93a45db502280ecff383d53e0294f969719.1710706118.git.ps@pks.im>
 <CAOLa=ZQ5wFCqWZ4yjMzUg5Yz1UeVpwUap0z9Lx9EfRVKnzHttQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Mhp+TGj6W8k6rwyX"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQ5wFCqWZ4yjMzUg5Yz1UeVpwUap0z9Lx9EfRVKnzHttQ@mail.gmail.com>


--Mhp+TGj6W8k6rwyX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 02:50:43PM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > diff --git a/reftable/stack.c b/reftable/stack.c
> > index 1ecf1b9751..92d9a7facb 100644
> > --- a/reftable/stack.c
> > +++ b/reftable/stack.c
> > @@ -590,8 +590,7 @@ static int reftable_stack_init_addition(struct reft=
able_addition *add,
> >  	err =3D stack_uptodate(st);
> >  	if (err < 0)
> >  		goto done;
> > -
> > -	if (err > 1) {
> > +	if (err > 0) {
> >  		err =3D REFTABLE_LOCK_ERROR;
> >  		goto done;
> >  	}
> > @@ -713,10 +712,6 @@ static int stack_try_add(struct reftable_stack *st,
> >  	int err =3D reftable_stack_init_addition(&add, st);
> >  	if (err < 0)
> >  		goto done;
> > -	if (err > 0) {
> > -		err =3D REFTABLE_LOCK_ERROR;
> > -		goto done;
> > -	}
>=20
> This changes the behavior though, since now we skip the `goto done`. It
> would be best to change the previous line to `if (err)`, which is what
> the other function (`reftable_stack_new_addition`) does.

It actually doesn't because `reftable_stack_init_addition()` does not
return a positive value anymore. And as it returns `REFTABLE_LOCK_ERROR`
in the case where it previously did return a positive value the
behaviour is exactly the same because we go into thee `if (err < 0)`
branch.

I'll amend the commit message to clariyf.

Patrick

--Mhp+TGj6W8k6rwyX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBP4EACgkQVbJhu7ck
PpQMKw/+OKjYU9oazdiSmO00DUkEJ2rcJi7zQf3jv5sCajcy5CRVtF1+Cup3Xbys
tO3zrglewVUe2T1LNc/vUukQvTMqDb6ee8SchMdMJdDTOQvNOpjftQm46lHy/DAQ
iWOW7rc+fKuW/awmTS6RP5K42WTr6oKGIjjUTatIKzYzHS0iK6A4kB5bX5jxjFTr
aspA64txB2keT+NAto+U/RqAN/Iu+MKAUMY9JmqCAwIqeSJzG3yeY1IeMkpvL5s2
3diq76Npvx0ROq8UlftZRixfC6cCWuRYnEJn33/3WKlUU2dbBapPRqB0azvik0Cu
PFvpwdmIV/Tau6V1fnrXYhxyFxpe6QlDL4ebN910SupwsemZUd81L05+hs8wbf7h
8pfSTD/ChUq6HoxXAOiC4udmS2lpCqyziVsGnC49iLFBnCE0OWGivaytAyxtsFjg
LttuJWQiSbQdHilqAXcrk0SwbHKS15Dd+yZDhXSbNecTi1GM29fGbxG9sTdqDuaw
tss3TTjuTLNM2k6ZWGMl4Xucj/7YNOYKdEOfHMdy36pD6oP3dFiRr2TnKsg3+A/0
VgLZyPwVW86Md7lw8eYzJH0lmrw6oJ2SAUEGvNf8vKedfylt2DGJf4GIRABrZvlK
7yv4DrcOwsT4k21oRjSk7RxEpdunMJ/NU8N5Tc0W/z8g8KqN0I4=
=dYtS
-----END PGP SIGNATURE-----

--Mhp+TGj6W8k6rwyX--

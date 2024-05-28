Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44A17D07D
	for <git@vger.kernel.org>; Tue, 28 May 2024 17:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716916972; cv=none; b=CnR52QHaYE7ANLIA+wWDikgUC+5K0+Pyx4VFEYECFeKpXg8ZwPay6h5wvxXZZanNvXHyExKRqAG18pAO1BiynYjZdpFcIqkVGrNTl+qCZ3YCo6Ggq5MAOPP/UJgzZI2VzMgx0fUopDEKyIcR0SVzLjscBT9DP0+5OojzhkENtiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716916972; c=relaxed/simple;
	bh=Ks/XPfZ5SRgHf3jaocV5VPIZUpiNcG7H5MqrawkgT58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHbBYf1+F96Y9vjdthoIpCO7C28d1801uYbDx74x3nMl4hZ/CTNlbj4wJGQnY3+zGlwNJ+SVrRxDHakiVaN1YmiW3KSsai2Il+L4EXM/qlwHOB1AZQwVuYpSCQE0iEOAw01C7/t67msyjzWeCdIscB6L5C8Qoh8iFepT5xdWelg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BtkLi26O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SkBd4zyr; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BtkLi26O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SkBd4zyr"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id D11D3180013B;
	Tue, 28 May 2024 13:22:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 28 May 2024 13:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716916969; x=1717003369; bh=jNhq/6zAVd
	ZVdPH+KfvlqEXnr0zK7XRSnOwoOkX2nfM=; b=BtkLi26O6jrxh7RgVbMexWb3Go
	hTdk8MxIWYEGM6f4aG3jasiqukdSswW1S61guF7HBX2OJQx1iMxdD2sH7bkB4Rrs
	uXVo517605KTRgDQpXVvHTo86FCEAzwf5sLUptwTdRGNjjm8BU7VnbcKRPhrV4NE
	JggL/uEq3aBoKDZTc6fhztRHmcSgvnX4h0LANZ7Zf/TeqAE5VQQCCHW+yC1VTpR3
	DHSCGVzl8yGFRb3nMfn1+s5xkHTR2huLoxGiuoMcN8/PU8YEdcPg2UjOFfJWPw90
	sTsGDXZiWu8Kl7w88qcUTpv84oCmKSu+cT00/OsR7s+1K6HtbaI+RDcJuvpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716916969; x=1717003369; bh=jNhq/6zAVdZVdPH+KfvlqEXnr0zK
	7XRSnOwoOkX2nfM=; b=SkBd4zyr6T97Fmh4Rl6UQdpgQ4GAVY1t//IlIK5GgcdI
	rL/7d90CqQB5GuGiaoStpObqYlAs0ZY5X8fmjbyenX6vrAhgMbVg10tUYfZey5AE
	rxm0PyrCqy+GvhmrXFw54Z5uzcPyhf/pfNX5foOZqZJaDtNbr49a15LlbcJIE8aL
	BAmwVOYiDM94DNcV8U3dubQKXJ2vzB9Kz/RmGL4VV00l8DJtwu01zQa+a0g2/8uG
	/zFLOvOwJItsEGqlwnFN7bqGzalMe+lG77psUYlvT1qc/RSLw5T2tq9OexHAwHBl
	2+EXZRORYf6mVK7utdukQ0JLLrXjXca6rUME/BeTfw==
X-ME-Sender: <xms:6RJWZvn-ffYSH-SyjfjAmwzbUhF6bCtXUmBg7atRxy5ToO2XhhhIBw>
    <xme:6RJWZi1iO2onpgjBuKfzZmEq_3uNgnZuu61G8Kv3R551LP9m_5kgqW_cZZcKo69Ke
    4YA1w2xMWQnZ7P24Q>
X-ME-Received: <xmr:6RJWZlqTWRRYqvEg3qWm7HCdwGVppEQ_Ni8mt_UXO0pzzNFzR7kpJi-DX44B4JtEjyiJ7jpvBx4T1nCvT0jY-HEbTbeevDjYsQvXnz1SHxIL4zd0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejkedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:6RJWZnkFYkyAZdZ1FXpGnKlwTrDXjQKgNVTLcz4Jz6NM9G4kWFJZFg>
    <xmx:6RJWZt3OdswipBYktQqTaO7rAimoof1z_AE3K6I5xSUPKMMZSJN2qQ>
    <xmx:6RJWZms-E6cU98cSgXSuBMriLkWcT_v3i7dM9ik5HI0zLZeIZHUCiw>
    <xmx:6RJWZhVHhzR-lixHSAwv_L3QS9FuXl47FLS7NrSBA78uYz-N7uwzWg>
    <xmx:6RJWZoTDkHD_spUGDVSQmHK4QxseESUn040lZFKRG12iC31sNPwjbIkr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 May 2024 13:22:48 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8074528a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 May 2024 17:22:33 +0000 (UTC)
Date: Tue, 28 May 2024 19:22:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Philip Peterson via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Philip Peterson <philip.c.peterson@gmail.com>
Subject: Re: [PATCH 2/2] apply: do not use the_repository
Message-ID: <ZlYS4zHmjKrzFtF6@ncase>
References: <pull.1728.git.git.1716877921.gitgitgadget@gmail.com>
 <36b44eb4c18cfd805ccecd8df695b0d5ee9c409f.1716877921.git.gitgitgadget@gmail.com>
 <ZlWHgBROsPBrmM0D@tanuki>
 <xmqqh6eh7v7g.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="78gsrB0c+9zLnMhO"
Content-Disposition: inline
In-Reply-To: <xmqqh6eh7v7g.fsf@gitster.g>


--78gsrB0c+9zLnMhO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 09:33:07AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > On Tue, May 28, 2024 at 06:32:01AM +0000, Philip Peterson via GitGitGad=
get wrote:
> >> diff --git a/apply.c b/apply.c
> >> index 901b67e6255..364c05fbd06 100644
> >> --- a/apply.c
> >> +++ b/apply.c
> >> @@ -3218,13 +3218,13 @@ static int apply_binary(struct apply_state *st=
ate,
> >>  		return 0; /* deletion patch */
> >>  	}
> >> =20
> >> -	if (has_object(the_repository, &oid, 0)) {
> >> +	if (has_object(state->repo, &oid, 0)) {
> >>  		/* We already have the postimage */
> >>  		enum object_type type;
> >>  		unsigned long size;
> >>  		char *result;
> >> =20
> >> -		result =3D repo_read_object_file(the_repository, &oid, &type,
> >> +		result =3D repo_read_object_file(state->repo, &oid, &type,
> >>  					       &size);
> >>  		if (!result)
> >>  			return error(_("the necessary postimage %s for "
> >
> > We call `get_oid_hex()` in this function, which ultimately ends up
> > accessing `the_repository` via `the_hash_algo`. We should likely convert
> > those to `repo_get_oid()`.
> >
> > There are also other accesses to `the_hash_algo` in this function, which
> > should be converted to use `state->repo->hash_algo`, as well.
>=20
> We as a more experienced developers should come up with a way to
> help developers who are less familiar with the API set, so that they
> can chip in this effort to wean ourselves off of globals.
>=20
> Would a bug like the ones you pointed out be easily caught by say
> running "GIT_TEST_DEFAULT_HASH=3Dsha256 make test"?

No, I don't think so.

I was also thinking about different approaches to this problem overall.
Ideally, I would want to catch this on the programmatic level so that we
do not even have to detect this at runtime. And I think this should be
feasible by introducing something similar to the USE_THE_INDEX_VARIABLE
macro, which we have recently removed.

If we had a USE_THE_REPOSITORY_VARIABLE macro that guards declarations
of:

  - `the_repository`

  - `the_hash_algo`

  - Functions that implicitly rely on either of the above.

Then you could prove that a given code unit does not rely on any of the
above anymore by not declaring that macro.

In fact, these patches prompted me to give this a go this morning. And
while the changes are of course trivial by themselves, I quickly
discovered that they are also pointless because we almost always rely on
either of the above.

The most important reason of this is "hash.h", where `struct object_id`
falls back to `the_hash_algo` in case its own hash algorithm wasn't set.
Ideally, this would never be the case. But a quick test shows that there
are many places where we do rely on the fallback value, mostly around
null OIDs. Fixing this would be a necessary prerequisite.

Another important benefit of the macro would be that we stop working
against a moving target. New files shouldn't declare it, and once a file
has been refactored and the corresponding macro was removed we would
know that we don't add new dependencies on either of the above by
accident.

Patrick

--78gsrB0c+9zLnMhO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZWEt8ACgkQVbJhu7ck
PpRhLg/+IAJIOrW37LehjUOzBIAGxISvw8JhfBZgOgxcBwdmiq5RKY/lPaHmbrqG
uireMraWG6cL2WA4ej8v0TTtAhNMsW71GbV9/5LibJwUE+r5PiA8jsiP/QWktA4g
blYeN5xfjsw0b+qxV7FZtH7zU9FlqvkWNjqxe6nNFxu/RuaCtRi941eT+coNTSMA
iHXqzztsHNtujgYTMItuxMWw/mWghYBBDIUQGaixTd6jp3X445eQFwuSrTvBx6e4
h445nhAbMJMEXoNppo44IYZnqIEOlMvAuStKcVATJqWgNjHPo+r6oSBLypwrCZ1J
Gkh3NyfGJBhIK5v35jFZx1WR0UMhxFWI2E5nT+9iPfEuSGjbOhAq/5aoAuSxixSR
FpEOKCTtUiSxdK87gNcoMtnHja8bagGdQeIJ6Ix8o7nTYAfdrcYGzxJ82wQ9HBDI
Ngjc3J1VBZ0gNeWZUEInP3aidDmFsVo3i1LHk8cvLYVMrzzn/T9yBqipbY2iL6Sp
DcP/jKhpLsEA+Zt490Dgmy+br7+TOhfVUFGlKNIZoXBgvSUS+OHH6vWeLACq7+ra
eHgx9ovIY5lQKuKUvfFrd3qs9NRWoM9GEzSzB4AeFgt9RauYv+T/jFr2yycD88Qj
zS87e0rf/r6sPwmgFt2GwMMfunhCRMwi/Ehw5oMegnm5lbhV0jc=
=Jr/E
-----END PGP SIGNATURE-----

--78gsrB0c+9zLnMhO--

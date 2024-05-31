Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E5429A0
	for <git@vger.kernel.org>; Fri, 31 May 2024 12:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717157416; cv=none; b=S1oV7zPWlEY34HpHCkYGX7AxDE/rPlEaSnhzvDZQWd6G1oUBwcWK1xE5ZD/CTQkzl9i6AjDEnw3EpNL88Y0c3PnrvOBHYR1K2dlts7vUuGtvFmkIjZoHTUGFnJCsdYcPZSmsL1VO1gOiybYO8KH9kJWhly+DcKQO5e090I6tlGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717157416; c=relaxed/simple;
	bh=jWC0t4ylhW77QVI+wYRr0DU8nHPifO9ZTUjqDrzZLcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2mYOb9N57eEm5SdDd/oadcQY52xp7tAnPyYgy6zAVPIwoXent7WoMLhFzdo/TMc/M2lV2gZHc7mMeIv1D82+s2aX7RCvpEE/4Szj3ZOe8nvtyKni5opi1wjLjuVj3amfLgldwzaRcjtOIBuYMhreykao1N1YzDarl9x1m+i/2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m59omAgS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Br+rRt1Q; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m59omAgS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Br+rRt1Q"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 67D051C001D5;
	Fri, 31 May 2024 08:10:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 31 May 2024 08:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717157413; x=1717243813; bh=sdZTgFfwnM
	gaaDoh4gctkxgcTpf4h5VNO3x3jo/btH4=; b=m59omAgS2oCcV+X7m3gbZa0Gl+
	y5Rt/DIP6w4u9B5RJZFG1tj13oqnJ7FaGV3qiUw/IXNPhpgc8MsF/PQG2431a+IA
	98n69IVI9vb3yc694SWruGe21NQK6qZNnVfAyW9lWfBhbIWFTLAE5dimFQfWOE2m
	isvJQccR/sfZYanrrQC2Q4L5qLqq1oWYRo6JdDwTiLBedAt2LDgCGchOxAU6FOXe
	kURc5FvUqSOol0D5La4NeUTsqoyQTAWdvZ4HNSQQQCNwE6UjnlRar2ymZGNFfzrd
	ZXEeho8GYUpZcTHcAwjHALaJTo4C9z0O897I9rrvYDiDuwJyV2tj1t27PPjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717157413; x=1717243813; bh=sdZTgFfwnMgaaDoh4gctkxgcTpf4
	h5VNO3x3jo/btH4=; b=Br+rRt1QkHeqSw+UOP5ZzSuxtg1+SwmuP9BgIzFbD5Dh
	+SBRER5xv/ttD+XvUhmhWzsZtAgAeiwDgNNGFdFl8HT0UVNx+iXDKjQkM43R/rgq
	zYSI7Cexpc4WacUtlr15z0FxKSCRtwrzaBVQYott2AwTd1Q/B/DCTHpzax9SwnxU
	16GgN/RcnOmjheVKct9CceggtIuMtlnX+jR0m1NmV2U0JlwEOt3sfm4BP0g5rIBE
	xFZNvhV4wbRxpd5Z4iusVGe5oYEeh+iAb0innXs1Km5z8/K9zPfTESTCGTSE2fTh
	N4rfWUxbVDGv+zckCGIJ9t8acPLXVFYs/Ckp64S9pA==
X-ME-Sender: <xms:JL5ZZnNyDIzCyiu9TDoIrDz1hVmbWHrHaBJC48wPd4ulpeQ8rej_9Q>
    <xme:JL5ZZh8pGlRpF6-nzg1ziLFFk5WIi68eCEYON_yT4ZIAw9c1gtdVN7C929tJCAVno
    r1KGbiJLQCY5mipIA>
X-ME-Received: <xmr:JL5ZZmS0CRJetjeWwdVSBEmHR1sGYUFkKgujfcH2BUDoxqZlr_vfDBLB9yDRJX4d_CPJTeJIMsAyngn0gZY56KmY8Gj1Hqoirj517n-ncCQf98k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekiedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:JL5ZZrsSR68-4cJuI8KUbJPYKl4hSsjcPbXC6bD8onOt-mrjAx0kmA>
    <xmx:JL5ZZve_viaXnA6Gf5Q1omI7KLWFWhN3CjLDCzdtD5Y51ZJVxwmMTg>
    <xmx:JL5ZZn1CSopvKU9LujZQkMN2Ep36Q07ZdNFLRaUSoRADHn0bgz_sAA>
    <xmx:JL5ZZr8uNL1nJBlxctgMtcqvxhMtClTcUdGxoZiNI9nYSHIGm3eVxQ>
    <xmx:Jb5ZZr6alxcM9sbYozLbIRyPiOna6hKtkUj_d_EzzlAyFNAlUk-qWHQk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 May 2024 08:10:11 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f07ac354 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 31 May 2024 12:09:52 +0000 (UTC)
Date: Fri, 31 May 2024 14:10:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 00/19] Compile with `-Wwrite-strings`
Message-ID: <Zlm-HzEqQ4yUO2QF@tanuki>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717073346.git.ps@pks.im>
 <xmqqle3qjqdk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CmhYxdknV8Lc/NAn"
Content-Disposition: inline
In-Reply-To: <xmqqle3qjqdk.fsf@gitster.g>


--CmhYxdknV8Lc/NAn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 02:13:27AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> >      @@ reftable/readwrite_test.c: static void test_write_key_order(voi=
d)
> >     + 	struct strbuf buf =3D STRBUF_INIT;
> >     + 	struct reftable_writer *w =3D
> >       		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
> >     ++	char a[] =3D "a", b[] =3D "b", target[] =3D "target";
>=20
> So you decided to go in the complete opposite direction, hmph...
>=20
> I was hoping that we do not add more "writable" pieces of memory
> like target[] only to please the constness-strict compilers.

I guess I misunderstood what you were saying. I'll revise this to go
into the other direction.

Patrick

--CmhYxdknV8Lc/NAn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZZvh8ACgkQVbJhu7ck
PpT+wg/+J+w0kQ3Uk6lqSgLJTHb35oMdHfDbsukKe9LGlK3FWXGhm/Fnpu0POoYN
/MCR2kJGX3tkZRDBdL5w2Ahf2oBZCViJZGdDUc4eU3n72cV186EvPk3rKApmdUvy
LL1Ho7AdMKOE6R4dl251zl/GGj6gUIL8zv8Q/YzFx+p9TrtjEv2Yw8QozeLOJP9h
Wr/ZVXaIRhUbK3jS0UhQJozNlXT7AOqnnpOL65OUtUDJGO2OQ9/xk+rRdB96Lqv+
5LEyjcLAsVaL49MK6p2Og5p/wm3NA4Mru8gcaQSFXLzMIuQt1JskEvwb7vbGYElu
LUEQii7gb7lnNflJAqa6txKGJ3qWO3315lAcZY0N1GfOvwKetlLXwo5sr7OfkVGy
UIJAZ+qrHEB0gSK2k7D4ca/l8nhVlRjtm8yumXcjNKvqFY4lK7bGo9m/y+NAYEKA
Du00b+OQEiluHUaRWY7t0q6g5s23mwj60v9yg78MK53ZHixjiM9xnxd87LemQEru
HTxfL/fmYLWF+HwDqi+ehus+dGqnjC+gsacdtYQdyRAwvyt1wfRg7+0kPJl78oy0
4mbKSe9RO87t+bR+lH2vchhgzaH/B9V+3FwBsm4OoOJXAhuEhAkbkq30hxGPy5c5
z4qlVltG02udkTXgFdKZV0hR+j6bcOuuA+RE97ZnBH56S8X/cjU=
=l7b0
-----END PGP SIGNATURE-----

--CmhYxdknV8Lc/NAn--

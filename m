Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96B1657D4
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 03:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712633050; cv=none; b=PEvETK7cvmiu7QNiTIotgX7VFK1ZeFMVfzjFvasZOiwOG2ZkLtHY+xce2ehLIZqyTD8CbO2l40H9IX4WN90+qDAZ8Do5NKaw/l9t7HQDwwhigiJ4HlwSSjJ/9f5FDClJD1bwwFmCAKSXRycRk6oeACb8eSKzbtFdAe24Bvu1Yxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712633050; c=relaxed/simple;
	bh=WO20K4oMIvViambGTkSdC2SIximnIZ9rShr63ts+RgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdV01w6p8jo8RrKNwuCu32/dpsFhOwzbLk4+g/GKApSShwohJyOIhKS2usYvR1d4E/jAN2kQu5b2aJ8IuIpEVAfTFEUFHNxnKh6Wa9lTM0M5Ps9QdiH/JayOlgfwBO9ckxBEWnnacLamjU+t4A/Sq7SApqzFrvzXHq7EF5dCHbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LQq+Zsz4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ITXn/SPE; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LQq+Zsz4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ITXn/SPE"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id F15DF1140187;
	Mon,  8 Apr 2024 23:24:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 08 Apr 2024 23:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712633047; x=1712719447; bh=SnS6MTZ/tr
	k2Oc8QDBhWofUT35ErFCqnlYtCfccP2Os=; b=LQq+Zsz4dZoLajYzAqUKWRobIX
	LbcoQna3ASvD54PQH3jnmituOYokzIK46JNyeZfH2r6s4vSFb56HUhf1pvjleOwA
	2kUpNvfzGubDqO6keIN+1n3y03XfDR/rFfazb+SPNHHcX503UFpGhN9yApHcWi9M
	sNR6qZKUissZaaz8sknPPyu4/lhPTYUs0dfAzb3DYM/kF4LcJhb2mojdZF80FdfO
	y5zV0hOYH3Gg+7v6XtCvQEHywSNgRJNTUxmlBUHJUPqepMziyf4wB/UY2yg/J4ZN
	MsY9cEX7GMrCBfnUdSHqw7C5KI1mV8O6nBImGOfdQoPH6y0vRA9oAqsUqZHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712633047; x=1712719447; bh=SnS6MTZ/trk2Oc8QDBhWofUT35Er
	FCqnlYtCfccP2Os=; b=ITXn/SPE9nP281XuvNzBlXq/zooI5tmqZTEH6VHTdg6T
	AwNy/OhBeub/fMWtQfRm8XvEOSK+R4suQzedbc+rIhgdqSsSETiNX6UdSPwMYEkR
	lFcsbYzrYorG7Z1iB1WMLLq89KcYDSzCd2hHeF6D3k84cAHeGeO7mG8begxSmpn/
	eBNUSIdYrtxceTBrKN/Z0SDJsktwkwOWHHQWkSddxCiGM1mgpkjcvj+PuAZlmlhS
	jw+cdA2BJpM2meW2vs/10yEN+EFKg3lb5oE82VJ7xGLGjJkKzSuI2y3gj8MCyWTv
	jPt5/J0JfTA5oITT5NYGjDYO8LLyRvC2Vs5WLFLl5w==
X-ME-Sender: <xms:17QUZo0G5Jq7uSYLk6V4ijp-he5vAhTTYsjqpTk1aUYxlRKuCaaXmA>
    <xme:17QUZjGU62j8fh6cEY446qJW13x9asebHjlylR00ZMOqYIkrcpYR-lKdtyL1tgcKs
    tvHE0Ex6qpwpjeTbw>
X-ME-Received: <xmr:17QUZg53_mXMmqRmRyEBMkAU5qNk0GrjJopor5YJDkfoBZOH53VsA0XyaJ2wKKIH4F0qNPf136hzCo8LldDe-QeNTGnGLJpHbMlRnmjpapmFr18R>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegkedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:17QUZh2xGjak02vEy_L6FRJGmLs6Jebdp_TCB-hPGhxGwJpMjYpiuQ>
    <xmx:17QUZrE7fa2u00z9MA3J6Mg_4_LGS9D-xys9HnfL54dvrypQ8nl9hw>
    <xmx:17QUZq8MBmgs2Qtb7m0Bm6aZ61IiYwpkAHUl_k_oWC4NuvAXuSgluw>
    <xmx:17QUZgky6p-fTvQwVE07EVluIKKmNtEX3g7uMn2Lwr0bMuZOK-ysPA>
    <xmx:17QUZviYgjnOWUnvbIWnTcKo8FXQD7HRSeYyf7TLuUBDji2zobGaCOlH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 23:24:06 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id db7c2834 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Apr 2024 03:23:58 +0000 (UTC)
Date: Tue, 9 Apr 2024 05:24:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Han-Wen Nienhuys <hanwenn@gmail.com>
Cc: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>, nasamuffin@google.com
Subject: Re: [PATCH] reftable: use xmalloc() and xrealloc()
Message-ID: <ZhS000b12DNoQ2pw@tanuki>
References: <963961ee-0f1d-42b8-8dda-5838e7a2ed94@web.de>
 <ZhOETox9FTIOAShN@tanuki>
 <CAOw_e7Z9dGeVU399D6o37L3am0abnYUrZnNQEFKhyUv=A2=j8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kTfNeoJctf3ts5so"
Content-Disposition: inline
In-Reply-To: <CAOw_e7Z9dGeVU399D6o37L3am0abnYUrZnNQEFKhyUv=A2=j8g@mail.gmail.com>


--kTfNeoJctf3ts5so
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2024 at 07:50:47PM +0200, Han-Wen Nienhuys wrote:
> Op ma 8 apr 2024 07:44 schreef Patrick Steinhardt <ps@pks.im>:
> >
> > It does raise the question what to do about the generic fallbacks. We
> > could start calling `abort()` when we observe allocation failures. It's
> > not exactly nice behaviour in a library though, where the caller may in
> > fact want to handle this case. But it may at least be better than
> > failing on a `NULL` pointer exception somewhere down the road. So it
> > might be the best alternative for now. We could then conver the reftable
> > library over time to handle allocation failures and, once that's done,
> > we can eventually drop such a call to `abort()`.
>=20
>=20
> I must admit that I didn't think this part through very much; I
> believe someone told me that libgit2 has pluggable memory allocation
> routines, so I tried to make the malloc pluggable here too.

That was me probably back when I was writing the libgit2 backend.

> Handling OOM better for the malloc calls themselves doesn't seem too
> difficult,
>=20
>   hanwen@fedora:~/vc/git/reftable$ grep [cme]alloc *c | wc
>      57     276    3469
>=20
> However, it is probably pointless as long as strbuf_* functions do not
> signal OOM gracefully. There was some talk of libifying strbuf. Did
> that work include returning OOM error codes in case malloc returns
> null? A quick look at strbuf.h suggests not.

Yeah, `strbuf` also crossed my mind. And there are some other systems
that the reftable library calls into, like the tempfiles framework, that
would continue to use `xmalloc()` and related functions.

> I would just call xmalloc as default, rather than calling
> reftable_set_alloc, because it might be tricky to ensure it is called
> early enough.

I don't think it should be particularly tricky to call
`reftable_set_alloc()` early enough. The reftable code won't do any
allocations before we set up the refdb. So calling this in our `main()`
function in "common-main.c" should be sufficient.

Patrick

--kTfNeoJctf3ts5so
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYUtNIACgkQVbJhu7ck
PpSj1A//d2bNmBQjzF2GHQElffMryt/eFOlWtifpfqtgIFP83eYmW+br/KS+iN4J
1IvOd+Y/th9NLbRV7rZn6zSJqLpIe/StckMn1YOuHHhFy5lRtasVltQpCZxHU5EQ
DlTCSrZVgx7XSAXaen2KfbMJnZ6b7zbTokzfHNHJjRfSLTnClXYhA+EXtwQAKyk9
KwpdydTyfXxKbyLXHOpAXmlqnfIftln0mR39IBTIFxXFDrxSFE27omzaImn/RKTU
4pNoSrSFaLBSLTfsKOq01txQmycsZ7+dhGDlrKZt5Fp/Hz5waHkQmj7ZBOgF+HRC
KujxXM7Owyf4HV/DvLTOoYK56ona/Jwn64cpzmYhBFDc8lPHnPqi5g9TGCXlv9Ry
SWIvaFB0m/+ZkThSEdd8FPwTg6dQUNH4DkmGmSvv7ktrEax8/xdc+nFgQ2I5cjWO
X7DZXbsIuLTSqtihXXGBMRAzQLWIn0xkhCHGYLJwQng7Vl8umuAgIHJ+Vn9xmeFW
g9/VijoqoAIwkSDHHav+8j/Q8lx9LoDG3WKONwvQsHJhfaqX25YBcAWDlcVdfcmE
WxBX7SACGb2rkbostsiVZF9Vt0X6cjPGFeWUJP7vPepuaid1mcjIkuI3UVmkDdLX
3isnzqumc9MVUEe8AIWCi2D9+9tNcmPaDJIMCAmWmvnEZRDKUIM=
=iD4a
-----END PGP SIGNATURE-----

--kTfNeoJctf3ts5so--

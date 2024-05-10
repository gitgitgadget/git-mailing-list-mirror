Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AC2168AF3
	for <git@vger.kernel.org>; Fri, 10 May 2024 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715336039; cv=none; b=Vi/4PTSsRZqg/eDX20Q+ZUDgoKJCyf8hVlBeOgjV64BsnXjPOK/U3C0nKS1lXL8eYl5TJG0XVpldhIwfRpfvYJOIUuolGHETv1uNRzmxleTROhs8jKkZe1a1eyv3t56BnYTpdIcF+WI6hLnpmwjBhejtW2jbguXQbxM/eULbQO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715336039; c=relaxed/simple;
	bh=NeaRx9uj9kF3G4E4Au5atVlHgTHnNJnKf5fEyXCM1Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdGkOAKXKHN5rzu3ys32JGANSKPo/7JU92zAERju2UX/4IG+ErOw2VADRHQYoiKFJepqpEUhsaYKbL6kpFtdCImx1TTJa2gf4boN+2ESONu17y/U3enl4/44Y5x/SJ+CJJ3zGV2UDLS1CkYvsIMslXDlxiLMkVxY3rxCRU5diiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dmwMznxA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vae1svTL; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dmwMznxA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vae1svTL"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id A301718000A0;
	Fri, 10 May 2024 06:13:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 10 May 2024 06:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715336031; x=1715422431; bh=h3k6JPJPZ9
	za10MsdFyjMw31aEkwuIN6nTLvMkdPM+k=; b=dmwMznxA/9kRxkpsFZBF4RlXTb
	rmDMt/s8MMR7mt64mlcL+wbPf3Oz/VaURg8f+++U0qy+OcUVkSWAlcQsmdsT+p0I
	XQgZPc9TYtNMXYd/U6izbXpmYrxGOphB73uWDjUA4+tn+fhlN7fKa1wxJtT95UWQ
	a8GZHsFOaW9rinvwPtO1pDPMqGwuT98cBu9T+C9AHbiRIpfCAFWqB/p5W5d/3JfG
	lbsOkp/xOqsAD6xouUuMD1NoTGOMgqFVqQmElTvCuAbsXFI8axnsefokBnr8ePLL
	peEvXHN0x/lgwZfSvrTPq5k12h4n6ePRd6Ampxghq1np65C9SR9oZ1cTsgDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715336031; x=1715422431; bh=h3k6JPJPZ9za10MsdFyjMw31aEkw
	uIN6nTLvMkdPM+k=; b=Vae1svTLdan38kC7LjrYJ/cIO7SLI5WcjRcaa1ZfzoAL
	Qmz3V4SGaTcCBtCMwAVcD0u2L2X/6G4fQqAzBF0O+5eUUt8yDCmfpQRHJD+Vy8Zn
	35nGIAu+0kp5WCNlgFoUnEbBsOxb6zH4bgqI8xKDLEZEPbqqRXugmyVuqA6RMFK9
	OJWkGNHtrvQ/mm6268bfzGZM34yPVozBJ6l5BWXzWWvjuV2UDDSFkhc5Zra/BL+r
	Yb+tN9SkqexTtOOCuay7dXVGORap17TK9wjJdTn9mv6+fHbocPkLVtZjg5TEBvOV
	QOJiE4QjFrzUV2TfWOKbSTpXqfxUFPkUTtdo8xj8aw==
X-ME-Sender: <xms:X_M9Zr3NB6vXO5nRKLx89lXEjpVjUhDQxLNjgZ1b8bxSk8PRr9H69Q>
    <xme:X_M9ZqGDXK2TAcc6kTMPUAzz3A__vYa6B35VRc1N4QeOiZlIgDcTrFE30ezUi2Yj1
    gYaoJ9x6noEL1mW0Q>
X-ME-Received: <xmr:X_M9Zr4Jc9yoNskGzYx_GUSrFgi1BoTExJ1cq0pGkRNgOEtLE8nsuGAkAz1vgW81cqLd-1xWsYmDUY3Ken0FhZ7hfmwFoyU2a2ut0UGW1blOdZ8u2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:X_M9Zg1GxzuHTTjgU-WU78CsjSwSrSOWf2d5wAv8vSlX2rA6YW8NDQ>
    <xmx:X_M9ZuFFCJNr7XlYje6DkVKg8vrlv7mW7lYAI1FSjehtrN59yNiDtw>
    <xmx:X_M9Zh-DoBNIxdkKfgDnCjRMwgzcz38uIP9hRorgmEP3TICrm0e0qQ>
    <xmx:X_M9Zrk_V8ZaM09Y1shuzcIhmgeXWarw07uK_-z8NDzYdxen2CKucg>
    <xmx:X_M9ZjTOx6w2Jo5w9Fwa_hsByjYRVWT_cE5at9EqiqAIGq0ov5vMCT4S>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 06:13:50 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 365bc27b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 10:13:37 +0000 (UTC)
Date: Fri, 10 May 2024 12:13:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 10/11] reftable: make the compaction factor configurable
Message-ID: <Zj3zWwkV4CPj78lt@tanuki>
References: <cover.1714630191.git.ps@pks.im>
 <30e2e33479a6b6b07a4652e84eebd78f71fb363a.1714630191.git.ps@pks.im>
 <CAOLa=ZQMoYM6L_2jwE9pOVUOV1tLep93m7VGLA00nrpHKdy0Vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RTDV9YRU1jo4j+db"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQMoYM6L_2jwE9pOVUOV1tLep93m7VGLA00nrpHKdy0Vg@mail.gmail.com>


--RTDV9YRU1jo4j+db
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 04:55:10AM -0500, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
[snip]
> > diff --git a/reftable/stack.c b/reftable/stack.c
> > index 7b4fff7c9e..6b0f8e13e7 100644
> > --- a/reftable/stack.c
> > +++ b/reftable/stack.c
> > @@ -1215,12 +1215,16 @@ static int segment_size(struct segment *s)
> >  	return s->end - s->start;
> >  }
> >
> > -struct segment suggest_compaction_segment(uint64_t *sizes, size_t n)
> > +struct segment suggest_compaction_segment(uint64_t *sizes, size_t n,
> > +					  uint8_t factor)
> >  {
> >  	struct segment seg =3D { 0 };
> >  	uint64_t bytes;
> >  	size_t i;
> >
> > +	if (!factor)
> > +		factor =3D 2;
> > +
>=20
> This should probably go in reftable/constants.h

Good idea, will do.

Patrick

--RTDV9YRU1jo4j+db
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY981oACgkQVbJhu7ck
PpToJA//dlYX4hgcjGb/u6pEzHYGn8SWPi2i9JBVQ2A08ykJYPfq/QOkdxA1B2rf
PS+S6J1yfyO2U3ZJR001JaB7VnHQvHoPuqJ6kUOxJlL3PWZ2PU/f0G2eG3WK78UH
uHxnehCuLi7mwMsW167HWknRdBRWiTwCm1nTVroZTuYhCUCKFidpuSC0nvM8Br4U
1Zmle4yIYHzKyZwIhEfEpRkc2ToW4yscQtMBEJ3WbIw1svYW3cq+fa421oiLmT4F
xsohvfddtCpUBBwb9U3VpnCe7t0y1379V2GRSG7SB9n9+ciK8TRH0w6j9/PbfMCX
8LiWFn14ys2C2r+0Xx9uUxxSek33hFz6omQ3NS9JQxW4Ey3DEvBlQWlG770IF/vE
R5BgA8rzvKud6oQwzhwsHIuctcCEyaHTtH3LcVe8EXA1b7qETap7zCjB6r+vAimK
p80rrhVdkOBRr4Q++fR0c5mJgYmNTFSHZ292YxE4KLi/0w22F+oSdc0ZUXXBlrK4
LK/PBZnBImMXzSxnt+FsN1gGyGrxWSRZh1QUp0r18yYVNeKoV3H/L7GLPJJOwgU9
HPY9bo9/j8NGiR21WC24+8yU46peO11ybUE1OqP8RVzDcHNY3k46AbNZbHwTRJc8
4viY8lOBnyKkWMP74HPPu+CBkkmsh3i6fEUp2lIVxm1V1nM628E=
=++RK
-----END PGP SIGNATURE-----

--RTDV9YRU1jo4j+db--

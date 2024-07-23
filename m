Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B2814F9FE
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721739616; cv=none; b=KbAM7Jd9sAqCAUlLEdGfZhTXFusVXXHxYyEDTKQpnvy+3bkEQaNkgjtVXeR9cDMIQHKnZap7nd34SzE+IBb4TB3ZyG7ddz1NYJ2UDibk72wlYQQwNk2GZKTInzbVIE7Aw8s5/M0EUESHmhcaPm+wztlqP7fz1Tkae9ffgj6zT5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721739616; c=relaxed/simple;
	bh=hVQkpi2W1uS8uExxkiY5mU7qVQjlQ9qXtSvQuZlcliY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqSB65J6bo9OIMOM43kL3zB5UjhRQeZHvcx9f8Uhw01AuNjJ5jnvmIkgEXUHqOMjGPglvNa7g8XUT7pAuMG0hTIpzjxSQQ6ptsL+lEuvAMz4Bnvt7JW14f2iT+NSEoZ8vd+MMj1MFNiNRIm2SFnSJHgKFrfPFCc+axbidk0UO8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KT/3Tzw+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mOTyElMs; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KT/3Tzw+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mOTyElMs"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9DCD91140385;
	Tue, 23 Jul 2024 09:00:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 23 Jul 2024 09:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721739612; x=1721826012; bh=H09R/kdxeT
	qkKdJBGsLkey2zgLRGwjMo2W1V5RydYyo=; b=KT/3Tzw+hBB250KnWvNX1x0Y07
	6TzhgIFB1nHzGYW04U7Ozxktpaw7hfl6nat+4H+INiFENUedOFvPBGap7m2wScEN
	g40/HlZ1cgvX+9hBDRxCjDEKh5EYaLLI9YIrOQRYmiecSE3PZwdv/LrKTTiyYWgR
	XVGn7nKg151taxjEmGm7WmlNkCo+sMLAJ28u4dhzhS5jicvJOWQEYRB7059FHdcV
	dTU7tJRAvItCOWjEEMMCNT2L6Ov4KXFGimWev0HUaIK/8PubGoNDNY0ET4UYsS1a
	rpSCACNa6REOUyf7LKQpe+2425bKP/x6ZDx9lJoIRwCi85l5x8i46gc3J/8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721739612; x=1721826012; bh=H09R/kdxeTqkKdJBGsLkey2zgLRG
	wjMo2W1V5RydYyo=; b=mOTyElMsjf0iZp8ekcbxmIPt/mpvLSUL6D7Uwicm8koH
	ibXcxYs8xQvsW8eX/HYSde82aDdZhbNYbuwz8erKQOrZ3oyWo6qxPnr9S4/H6/dC
	Rc60at5hF3SkamaY1JbAXJCzeFXrcjeRbJPdeMa2InWN0+nOuNHSNT//h/+SP9kK
	3VqjjJjcuffUVVdLUaZRyzlOkRhuhZx+05ZMnFFSE9E4bJHrBzEITAIevoVg4DUW
	7nuMNdn+3oa7RY5IDkev8HgLr+zY9ckK45WgholugndbhKtYC86VDWYfoND09Gj7
	ao7SW9xqYznqO7NCc5CMhTiVDGb0D1jRFjqu1M2Nkg==
X-ME-Sender: <xms:W6mfZmMm4mFhhARcfaAnDR6xB43VM2XQ5h28lG6QNj2CRrCvMC4-jA>
    <xme:W6mfZk9mAWHyNunOrWD-aE-jWVvbcy4etRYo7aeo8RW5x7kAHIT7_PI2hhhNzStTP
    dhO-YGVENz0DROYhQ>
X-ME-Received: <xmr:W6mfZtTht1mK5V91EjWXM_l-kliPYMUs6DXMhcgL2UiOPM1L2QSGIdgRRM68MwTq23Xz6s5JNx1FbuPFWOl7bblFoTLyN7JmSGzao3yTAlbC09-j>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheelgdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:W6mfZmsLg7SFqxeLSWQRw-IsTkIYN-FxdW_sZOgCnO4WO40tf530Xg>
    <xmx:W6mfZufC9SToAIj8vYLtYfvmmhXiEotWvs6O-1eWZAr_6DAJ24a-Mw>
    <xmx:W6mfZq0imgnAhbVFtSHm5-OE7cBI2_b5lkX66qNAk5ZLyTVcSGZKmw>
    <xmx:W6mfZi_D4QGeh384E1Yjv6z5mHGMqrwRENEzK5CM3vyHvcZfymZVxQ>
    <xmx:XKmfZmTqAc8Asq2AKdAASudWz0GPypaXB0oIwDtsRmo7T72k_9F5CKdC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jul 2024 09:00:10 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 84a114ef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 23 Jul 2024 12:58:54 +0000 (UTC)
Date: Tue, 23 Jul 2024 15:00:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Git List <git@vger.kernel.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v2 2/6] unit-tests: add for_test
Message-ID: <Zp-pVsWeTCbfcquh@tanuki>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <da7ed537-1c8e-42ec-aa91-49e1319e8c68@web.de>
 <2dff757d-3c5d-4923-97df-26bcb1c21230@web.de>
 <CAO_smVhoobWpsbYHnHJqTj7TJJ1udo_UaGdbOnUqe5jzL+tyaQ@mail.gmail.com>
 <xmqq1q3lb4me.fsf@gitster.g>
 <Zp9PfdZtWJBp2xgl@tanuki>
 <71aa553e-9b10-4bc7-9c7d-5414691db79a@web.de>
 <Zp99icyrc0rdxg9a@tanuki>
 <0af06e8e-e1d7-4cf6-b968-5dad5f4fef2e@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6e8GCR4UwLXnZBMw"
Content-Disposition: inline
In-Reply-To: <0af06e8e-e1d7-4cf6-b968-5dad5f4fef2e@web.de>


--6e8GCR4UwLXnZBMw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 02:37:35PM +0200, Ren=C3=A9 Scharfe wrote:
> Am 23.07.24 um 11:53 schrieb Patrick Steinhardt:
> > On Tue, Jul 23, 2024 at 11:25:29AM +0200, Ren=C3=A9 Scharfe wrote:
> >> Am 23.07.24 um 08:36 schrieb Patrick Steinhardt:
> >>> There is of course some magic involved with how we generate the file.
> >>
> >> It requires magic function names and generates code using a different
> >> language, while for_test is a just single new control flow keyword,
> >> like the dozen or so we already have.  So the magic employed by the
> >> libgit2 system is both broader and deeper.
> >
> > It is broader, that's certainly true. But it feels more self-contained,
> > less fragile and easier to read to me compared to macros.
>=20
> In which ways can for_test break?

I was mostly referring to the potential for empty-by-accident test
bodies that were mentioned in other parts of this thread.

Patrick

--6e8GCR4UwLXnZBMw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmafqVUACgkQVbJhu7ck
PpSEQA//Uuqbob7qS4P549GvDH8gm6NeZqvgFSuPd7SGnkHl1xvnfggkLGU1Rfuh
YuVyt9lNftDcMkTylBl6zOZRgKdSSnAbhtoZ9yGE0Lt73I4cR1iFXnYsiGr6+EJx
BYIOuXgsf3CeexqroXp5N9Xr7XU3DfIeKpePAYShzS1XyPCqZWO98euuKMVCy/Jj
bHlsBHxqcIkrzCtsylKcFmug20SonTBCzDEGy0wrhj8HcgO08HwWHLNLB5mgooge
+bTlULRxQT35E/SX2yr85/RXQD4hGL+3fVNJ35iVoHCKVcBKS0DY2n8PZnzLOIHT
/3HqFEWNnMerQCI35rVtboxXwC15pxrWsikCAtCNcCg3fB/hUyDVDOYNnB8rUrZO
Q4wXT8l3yBTU/aVbKScT+5RLc0IULlzdbn9yg0EuqpXl1RgIyW3xET13J6NQruCA
5nPyneUlT9f372seqst9OMTfj+r9zHBq3eTr20FKLqyQN8YIHRbs+QIV2gWaTT9e
Fw8JlkZnHcq3MMBhO27AbZfdRCCePhoalFqsSY/JAdKRnTauVD2f3xbwzMAHbWBa
RXHmurUzWYjzz6adgnTjBzV2fXGiEvmT1Rmm4H6p3OHIBJH+B5TyWV5+ACpc9J97
cmZrjtGjPfEfuzB+D5/XfiKH78Lr56gtyZ+lQmS1DEx49Loj/D0=
=YmEh
-----END PGP SIGNATURE-----

--6e8GCR4UwLXnZBMw--

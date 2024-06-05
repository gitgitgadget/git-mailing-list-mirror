Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F220233999
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 05:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717565484; cv=none; b=kVOPumB7k+J68hbiijkyf+7mMgy9T5bkAxL2JB7ocAoDBPOBtQMDWaP2vs0S4SdT76tEMezct91OZMfuLTsQGfHbVUPKFqcJ9gn/QYWzfDwZK2vFdJpGiibq/Qd0EkMGIG0rXYaK4z/BxIHcvAhM71d9cF6fAD0r1G1cyIe7IeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717565484; c=relaxed/simple;
	bh=jcAlrGmELTg6Af9NB395QYcCtHKSk8grbNt284QK9/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4vUdP9qhjndivLQpyuXLimk0ARTinpR/i745F3iu6FCxBnI4C4bMVZnvBrHXQc2CfCqCKfuUSIyyRAukIEkQ86FQ6EkgGWQE4o1Ul4RiJgqmTVquApHl5EHLT/+wSx5sXCWsCjFnPBUFtbRrrXUnCWU7eqKmAd+lQCnAknweZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MfKfejfo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=acPLmHfK; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MfKfejfo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="acPLmHfK"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id AE51A1C0018D;
	Wed,  5 Jun 2024 01:31:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 05 Jun 2024 01:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717565477; x=1717651877; bh=TMJBfMk0hm
	Y4VyCtQfcBCAbVjHl5qupDXw+p8Zcxds4=; b=MfKfejfoT1XbMSnkF3OqTv8ttp
	NI/JL/Tjud4d606jrBQp8rG7BewVkuf1wJvYx1a8WdJRsow7hFaBPDaZad6zanDr
	gqvgZTV7ybKJcTE3GzVm+heWM+gfuhRTBOm8yQnjo03ymFBoK1BVwmkowiLD546J
	Rlfxa8lRgUDPKOVje/eNvP8RZOVrhur6NgL2tGP2q5d1eCElmVNqWTU71otn6Dvh
	DR+tvfDfK3UWTzSESRjJYF8fTmX4EmPpxiVsP0ORXJ4ZwLZTcrKqKSP0yn/d/T17
	MrijT899tTqABVtAgfqFwEOlAf5BReD86L4AtOR1Xeh+JyoJK/C7fcoAeYwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717565477; x=1717651877; bh=TMJBfMk0hmY4VyCtQfcBCAbVjHl5
	qupDXw+p8Zcxds4=; b=acPLmHfKETWrR12cv18vMc0DtJyD0vXpKHnWZx2Rrv2Q
	Cln0IbRuFIHd+i0IJlptxoWjLDs3tg/4JrANbtoA1UMdg9tTKlMlO5DWd1lbdUaY
	bgNYH3ah3V+4uSAfm6bqYjJ8GCR5fTCURivfKM296VZXgsHEaUCsn54gAcq78HMQ
	qYD8B+vmTymQ28KVQCjFYd7eaGZaauEJyPzjjeLla53QoanlSy2hKTT/zWSpSTT5
	thKpKkLeZ7seyurkFjJO/jVteubYPBqxfM6yJTNe/qMctdr0ZJvSoZPERV03mOD9
	nE2ligXR0STdT+OJKxun4OlX4KVGg5Pk504QzHCJWg==
X-ME-Sender: <xms:JPhfZjmtPw4Gfs8TPx4uJUJwVNLaVj8xtx8zYAyZcvGQf6k3hIB_Yw>
    <xme:JPhfZm0TQK1h5RDZ9fzngn_A7xbjdOzYeC_q4fEtKa4PWcqEckIEMvtMya5aAZ97-
    0QsClbVwwmeMByq2Q>
X-ME-Received: <xmr:JPhfZpqLmLuIL9aIO8KzgKJJMH8-AJ3nAAeRxujvSAQ03H4ZI5qCytnWNDVyFff9hJ2CasdFt0M5NM54yuw96Bfkqe64GQt6wCODuL3_g4dxYynsq-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelhedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:JfhfZrk4O3BYqWIs_1WKSpmkcWs0wu2BcADyp6fsdc96U8NdiUhM3g>
    <xmx:JfhfZh0h_fKZcieJ_72L1BHHtxyRNKLjkv4PiAb63BZ58kUxZKZWnA>
    <xmx:JfhfZqvDKQ9_YUr1DaagtbiA3wPnEsiQSiHsw8PePgPF1aaR1zl7kA>
    <xmx:JfhfZlWD1RhbFVZpnMEjE2M13kEiNJo-H02g2dc2a4Go1aCSNrVu2g>
    <xmx:JfhfZqKOSQwFeDuG-DJaLbv_61md_5qwzwxR4iSCu7-zEXehlqiBxS5F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jun 2024 01:31:15 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a649e659 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Jun 2024 05:30:46 +0000 (UTC)
Date: Wed, 5 Jun 2024 07:31:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Karthik Nayak <karthik.188@gmail.com>,
	Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v6 1/4] docs: introduce document to announce breaking
 changes
Message-ID: <Zl_4IIqFmoPhx1Gc@tanuki>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
 <cover.1717504292.git.ps@pks.im>
 <a260bbf281d2975562a042a71ca0dd7f88f03da4.1717504292.git.ps@pks.im>
 <xmqqsexsvbaf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="09rqs04OG7wTjjTx"
Content-Disposition: inline
In-Reply-To: <xmqqsexsvbaf.fsf@gitster.g>


--09rqs04OG7wTjjTx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2024 at 10:59:52AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > +* Git 1.6, released in August 2008. In retrospect, this release should=
 likely
> > +  have bumped the major version.
>=20
> No need to reroll just for this alone, but back then, a non-zero
> third component did not mean they are maintenance releases (e.g.,
> v1.5.3.3 was the third maintenance update for the v1.5.3 series) and
> v1.6.0 _was_ a departure, a breaking change from the v1.5.x series.
>=20
> It is more recent tradition that we only use three numbers.  I'd
> strike the whole "In retrospect" comment if I were writing this.

The reason why I included it is that I didn't want to create the
impression that breaking releases may also happen when bumping the
second version component. It did happen with v1.6.0, but in the future I
think we'd want to always bump the first component on such releases, do
we?

Patrick

--09rqs04OG7wTjjTx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZf+B8ACgkQVbJhu7ck
PpQ1lw/9EGxlYsiKRVo97kjocZkadXWwroEZDatGV/vIlJDzXsaYL8+gT588d7Ns
YhcOsDEzKqOoct3b3dFBJTRhf2jAacJ+j4LloRMn8RC/xSnh5ybToAW/wAUPAzMS
KoiNwuDyLia7B3r6IrwPiCe8ecGvTdRy5YPpdnoOC6m9HsQE/2V2NnW4n7RaPLpX
U94pEEf7PqDwwfdomAS3Edpc++kkUXkTCMDDzlyKahhJ8xyWSLlwrXttQIabvWoX
Q10lnnmxcyjwNWRcSk1PprR6XHWs1FEC+wk8iZj1nO+4MPz51Rd+YUiMJENdOWJq
s5JRqWqj56Ee4SVuYAy7gImxaHJQA9O73zoli+CXs/YPlWatXsp/eSdaSsh2DaVg
Tff3xC8Gwbq21Blumla183cd/a6ZSfezYzM+twKEKmqqjH5+j8xBBrxH5OGa886r
oBYGjxiUTDKXHyyyS+YxMVzxKXZHZ5gZ7fET/6iS2qW7zPF87QC4zM21xKApIUqK
C/2rJk+0ut+lM7TEe21n/MhJiREhKaxgMZzA78h0KR2fjRrUIN4qUOnA3nnQZXap
2aHbL5OV5LLyFi247UvX2fnnJrKTka1hmRdbWB45wT1AG6IG2MzFDKVk6/RLPNcU
wtgKzcb+WVvAsOxWoUmol0rcvYjhjAZAeA5Kuovo7vzPRZHlCsg=
=g1nL
-----END PGP SIGNATURE-----

--09rqs04OG7wTjjTx--

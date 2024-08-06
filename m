Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D201C32
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 06:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722925838; cv=none; b=VmeBHwhk+3CHyddqIyTITVvVChC9GUjDonUkyLFcZ7lD9BaAiBqVE16cpq3/qpE0QYervvXlb9sZjClcSE55zdIaw0SpnO9j0jV9tB7hkTOaRmfWUkb4/mJ6IAkp5Tt1thacHSsf77QK5KLQbE9GDokdZ1M7vKCyzuCewY562vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722925838; c=relaxed/simple;
	bh=sZIx/ydOAk1rkEmcSUsIN24+RRa3rhzORz7QJtjeFrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k95lPNbz8l//BeHX12TqwaaU2hFkILHylOtr6G4a0WmjuIxaArMh6m/SP4qQ42fgirjyIR45o1mrzr7PcMx5gVTV11OPoiw0sNbfS++oqFRiEDPVLeb5D0VD07lIaki0GfEkJa2EiipXxeezzUdigTHRVbXSg30JqUZuSEaBbro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MNWHT1EE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TBnFVl/j; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MNWHT1EE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TBnFVl/j"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3A0FC1151AEE;
	Tue,  6 Aug 2024 02:30:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 06 Aug 2024 02:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722925836; x=1723012236; bh=sZIx/ydOAk
	1rkEmcSUsIN24+RRa3rhzORz7QJtjeFrk=; b=MNWHT1EEj2Pm6ZeCcl2JxZfVFi
	O54vjPWfDVZa9uGeXTl9uj0/9mSD69recs4ATJgFRgrYGCthIqi48NxTSRY2mlg2
	9/1s17BSm+Js5B5pi1RKos0WM+++kd/JSflZw9u5GN03pSYlY6nmFXQ/LAwl7GgN
	hL5sRrmHhBcE7jdCwzgpYIxLSW3PIBX3UBWJ3qqY1LX+Gi0CCGRahff2qXobxOBy
	2rj89SPRpEBFLx0+TiHYW99NkFAd6m/RAmHB4q6iXdnTleOebCNw+9eSPcwf7OrF
	nPHL+juIDTDSB5R2N1+ctINVW/YitoaqBt7izBeEazi6lCkj8uv3Q67t0YzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722925836; x=1723012236; bh=sZIx/ydOAk1rkEmcSUsIN24+RRa3
	rhzORz7QJtjeFrk=; b=TBnFVl/jmAJAjdOcUgUsGYd0r6SoClAx24nE+aC4JLIK
	B0LbCGM4gdlm9V5wVkM4wfkPmKAbh0tmIWHqo7h5Vnn2C/r8NgyKTL6I90dre6yR
	g8B2RURQv1+W9M/aiTE7rFV2segikVGTbipw8kwHaNraQo4GZ9Hg5j8l2uucz+a9
	Ff0HS1BbKKFaZv8TMXUM3/rnV1S0V9dQG3G3lDMo7YwzH7OO6vMkAZcoFnl+5NH6
	hzgL13Hgo00iJiu1DDUM3TErafTMBeQtCFtw4k1+TaVODI6o2QdDJPsAuFX06LE2
	emN12sXW94ZLkZK2Fl/k2y2f9LxUXmK2iwkGPjRrhQ==
X-ME-Sender: <xms:C8OxZq4-BHhOv-HBe1Xaqxlh9P7nDK5a7K9l76vaog9QsanJfG6jOw>
    <xme:C8OxZj4gfd7UBIxWe2f-WXAeqfsAQzUV8aVP3AEi_3WE4Dmd3_hSdNUQtymWyYmvu
    vhx9bjBq_TypBMsZA>
X-ME-Received: <xmr:C8OxZpfGxpoM5hW6LRw-stAdJlAYfPkAP_s3w1GR_Xf2X3LxmSspQ600iCrRJZuo0zzFa4pyULEsQNS-pIzhy0dCFhW-yW3N-uprKvPNsYvH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeejgdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:C8OxZnKkJcfFOE4ihwVnNrdEunbremzd1zRT8GyJIYtCLM6_rW_KUg>
    <xmx:C8OxZuI0IU7Qxx-EnIlbSwEXgSL7dCf0iDGIErmSViIaJ2twm1xepw>
    <xmx:C8OxZows5VaDn1AUeOxM9xsA_s4HP0iG2P1e6gQlrcvfbY2n-Y44gg>
    <xmx:C8OxZiJRR9FSzvbb9wyuaXzL4wwVR6lrUO-Qmb6S1CXY8IUX1XaIXQ>
    <xmx:DMOxZjEicXKTOCrIj7n1eicI3AvAEC7crQh6h68MOvsQjiila_KYN_0D>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Aug 2024 02:30:34 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5e990dae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Aug 2024 06:30:31 +0000 (UTC)
Date: Tue, 6 Aug 2024 08:30:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [GSoC][PATCH v7 0/5] t: port reftable/tree_test.c to the unit
 testing framework
Message-ID: <ZrHDB1-yTv_gD1Mx@tanuki>
References: <20240802121318.4583-1-chandrapratap3519@gmail.com>
 <20240804141105.4268-1-chandrapratap3519@gmail.com>
 <ZrCx0NWRbFOOReki@tanuki>
 <xmqqr0b33r16.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yGPtpBonUzPCY0Qk"
Content-Disposition: inline
In-Reply-To: <xmqqr0b33r16.fsf@gitster.g>


--yGPtpBonUzPCY0Qk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 05, 2024 at 08:53:09AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > On Sun, Aug 04, 2024 at 07:36:44PM +0530, Chandra Pratap wrote:
> >> The reftable library comes with self tests, which are exercised
> >> as part of the usual end-to-end tests and are designed to
> >> observe the end-user visible effects of Git commands. What it
> >> exercises, however, is a better match for the unit-testing
> >> framework, merged at 8bf6fbd0 (Merge branch 'js/doc-unit-tests',
> >> 2023-12-09), which is designed to observe how low level
> >> implementation details, at the level of sequences of individual
> >> function calls, behave.
> >>=20
> >> Hence, port reftable/tree_test.c to the unit testing framework and
> >> improve upon the ported test. The first patch in the series is
> >> preparatory cleanup, the second patch moves the test to the unit
> >> testing framework, and the rest of the patches improve upon the
> >> ported test.
> >>=20
> >> Mentored-by: Patrick Steinhardt <ps@pks.im>
> >> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> >> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> >
> > Only a single change compared to v6, addressing the only feedback on
> > that version. So this looks good to me, thanks!
>=20
> FWIW, I didn't have other feedback not because I found the rest
> perfect, but because I didn't read the series myself carefully,
> hoping others are sharing the burden.

Oh, yes. I didn't mean to say that I relied on your feedback being
addressed exclusively. I already reviewed v5/v6 of this patch series and
found it to be good, and given that there was only a single change
proposed by you that I'm happy with it translates into me being in favor
of v7, as well.

Patrick

--yGPtpBonUzPCY0Qk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaxwwYACgkQVbJhu7ck
PpRjWw//TeFlR5rkG/ooR47zz2sdGTRAEIxzIn/ep/IgWiU4viuc8bznYagNcP39
o9nBiZYKD6xvKkH2aXJjv4QWJCtZhPywt0A246/KeMCR9k/iOslhqef0X8oHYj31
GfXFafy79FgPr+XxIAiIvrPkzokOgfzW4RDACZMZfo8rcHnUUnTR+7SWOJobqYrs
qSNwBdnhmsfPDBRmdFFCnjh+G9BWqMBOFl27d12EMPAZCat7illRlR2KhvPaTDTs
kReUDulKwjOgwueubYEytnw9o8mZZ/i+XKDBOMRbCn+Q6cSt0ipOvYwaOyG4yL/u
WzMJCXnM3A3QIO5eswzAsnRNTh4uBChMStQbn4dlmqFNsf3Z000ISbKqMoOVKonP
+Gpz9msvXrSWi/tqb1weY8yIBmAbsFZqSChO4EwgFtgN0cunhjd/UbGYhclMEv5t
vQC9TlCD+dEtX5rRY1mUwiDJPYs17VlH+9Ed9+IefDTy6rF4jvcX1F3FFPl8bQsH
IW2GW7uEUwBLPBmIx7HreGh1Tjxo14ppQOdY4kULkGLduLApVeVXllo38TyQhSLN
+NKiD3cGU41sacw5QNR334Dusd7dH23TcfB8sbcsL38p4NHijA5OFnkI9GJIM5gt
iZ7jIKbHU2P9WQXYsJX22JYxPnhej40CdvlBsaWQpXC0WY1MWMA=
=h08/
-----END PGP SIGNATURE-----

--yGPtpBonUzPCY0Qk--

Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0704A0F
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 05:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722922392; cv=none; b=dDYzODaJGqXAV1avQch94PWwdQC6hnvLkA5p3HwgGbSqwl3VV2LxbxfT++lJ0DP/T4KcUnjd3yd+JInriJ+HNzU2DyXFGRgnxEFSalIFLDHeIIrkPkgASd5sXaavYvi6/C8m71C/oMt4Xqy0vNeYuqr4qGUqZbpoO35bhOiRBPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722922392; c=relaxed/simple;
	bh=a86R4IjanD7CGaeUVdT/wbaQro8wGdMc1mmGGqJuqRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQQo27z5C9g0Xt2DSE6A+EYBmf1bZqs1jna8BGZ1B49V78W0nTmyuyBJ8U0IHNSuW8AFHaQIV3bgO7X67wiAhjYSNmwIcTdHWy7+KQf31optAxt7X/3MqYQt7ixL6CgEdpwfetM01lwdmOsZhC9k/gNkeOHHYoocejs+VFr0/EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IOox8EqR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=geomg9ek; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IOox8EqR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="geomg9ek"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 44E95138838C;
	Tue,  6 Aug 2024 01:33:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 06 Aug 2024 01:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722922389; x=1723008789; bh=JK91RM56xU
	+8wse5PiWbBBaUD3ymMZdmeNvRA6BKRjs=; b=IOox8EqRWsm8a97x11DWCRj3l9
	yqNcMpHsKPT1xrknWFAy7Q6NCOMthHUgXuam977ZNxHbJUyaZPdMGP6pyKL6Gv4E
	NC129WPTP7COF2lVbEWocfstK+pO37VVwt7TVuDa+eZPYjTOAMDDITKGHtZV1E2r
	VcibvKgsKuNO3KDgANdNLgBFB7rP0OBHSAXm2uOcyD7ItBOoYPJ5tXfW0HZkL3Ys
	rm2NUjkWYCe3nt8h7mtqslfehyAZzPAe7MbKUR2k/UUuuJIap8pwbz3nXT6CjhfU
	o2EnTO8T07SuejnnTgHcRGD9cmLULhDwZes1N+6NNwo0oefpcQ79pyXA1PBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722922389; x=1723008789; bh=JK91RM56xU+8wse5PiWbBBaUD3ym
	MZdmeNvRA6BKRjs=; b=geomg9ek6RnFI+JXf1YzDZpTqDgiTpoL2m93UXrYuXQu
	HNcsmfcKnlrATgn6g0rUUS5D15MVwmygpkWFVXu1ytSwJ6ClJFEOeridI6NldRq5
	4TLKdi7zDoTvU5Y8I1tlIB3Hx+YDyaFvzdiakfmdTSBtR1rGls5gspgNcWC4AM5H
	TiAh93+qBBJEeN9nlhSId+j7EK+3vlsuckVPKCGEMljP2qwuclCJnmZSu94QRiAZ
	Fe6KVVuYo+bPH6WJyRZ02htKDk5I1/xEqYbmDnLJ7OBDSgI8SQ5LSIZZld9xKy08
	nLjt5X0vgrF0xxj9X6c5lNYSpTfX8jrpzspT8/XuHA==
X-ME-Sender: <xms:lbWxZkY552owrwC2G7bhw2lX2f86fRH5dqJs_TiZ1_HCRm4hVqSjCw>
    <xme:lbWxZvZiZgp81vq7oh_UCrhnPZyxlDSzIsFntzkbvuIrZi850W61SVSjDjxOgFccz
    zMo6gQUrSa6jj59Yw>
X-ME-Received: <xmr:lbWxZu9-qfA5WTNpv_lEI-SL5eXp-kK4OwEI_pj2UKcscqn--w67pOYx515HXtcVBj_iDNpaFUlxSdtsbPJqbCcuAp8Jwkf4n09AuQ71j4NX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeejgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnheptdeiteevvedukeekheeiueevtdeigffgte
    fhkeelgeevtdejueelleffteeuieeunecuffhomhgrihhnpehpkhhsrdhimhenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrih
    hmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:lbWxZuoxbUsXSYSwG_LjGuvXAPhEdGE8zvEFm7IrhxohkXTOFIvloA>
    <xmx:lbWxZvpAUmS_8aJC90LRshBDJEsbYuQ5U0gDZO0TONhErs1urY6Dhw>
    <xmx:lbWxZsTixNDsSQXWyGT1_7W6LdeqC_8NaRHCaOwMwB6bDTHPiZDBqQ>
    <xmx:lbWxZvo23j4ln6x10I5cy1Xlj6vSufVUELqs2RQimwSQIMRFtOXnCw>
    <xmx:lbWxZm2z4mvkmaX_d0Jbxhppx454KOQGk6e6H4E_3gySL6IVBNTrK25s>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Aug 2024 01:33:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 477defc5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Aug 2024 05:33:05 +0000 (UTC)
Date: Tue, 6 Aug 2024 07:33:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2024, #02; Mon, 5)
Message-ID: <ZrG1kQeYT_5rdTy5@tanuki>
References: <xmqqfrri1scr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W8mm5ePR+YnbcD55"
Content-Disposition: inline
In-Reply-To: <xmqqfrri1scr.fsf@gitster.g>


--W8mm5ePR+YnbcD55
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 05, 2024 at 04:07:32PM -0700, Junio C Hamano wrote:
> * ps/refs-wo-the-repository (2024-07-30) 5 commits
>  - refs/reftable: stop using `the_repository`
>  - refs/packed: stop using `the_repository`
>  - refs/files: stop using `the_repository`
>  - refs/files: stop using `the_repository` in `parse_loose_ref_contents()`
>  - refs: stop using `the_repository`
>=20
>  In the refs subsystem, implicit reliance of the_repository has been
>  eliminated; the repository associated with the ref store object is
>  used instead.
>=20
>  Will merge to 'next'?
>  cf. <ZqnEuz9uFgUwWKkc@tanuki>
>  source: <cover.1722316795.git.ps@pks.im>

Yes, I think this is ready to go. I've already got a follow up patch
series sitting around that does the same for "path.c" and "config.c",
but these are way bigger compared to the above.

Patrick

--W8mm5ePR+YnbcD55
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaxtZAACgkQVbJhu7ck
PpTTAw//ZAM2ITfAFfLbym48c+zw3MsfhG2L8c3crBpFZQZw6Fe9z4AHekn8waOJ
Xl7d9I4tZiZwycApY2AzoV+HiQiU5mOZb/fVLp0J0CAQyrQs2auPiPKheMk1b+bY
2UtZr1nMm6WLGZ/zXfTNtsdehj+MusH5xFXzDSF+v5ab1I4Wm2/gGeIeuK5pNpC4
F233xCEX9LilgO81zmcLTdnZ3SLX9j+a2dr6tXXKxytjv9vZobqmnb+7cQIlleNh
HT8rEO/YVFwYzOB6vB8DSSLCfNKbqq+cGGnqOzXQ7x/4RJi3gfD6shJlWzLklFfw
CYqJUzPoEkAdTRDu4Vix2mT+OVwnB/cPL1eVKUI9rc03Lq9KhIl5lRIU5ObY4nci
owKe02zwWbC6iQNhNabI0xEI+DHyz2PgOoVWX2WEJWx4oH5Vr+O4zUvj+hWVBTVR
gFCffG0mIXy9aQ/Q95XUDALWYs3g56NEzHggF6RmHEZJCnV+TsYo2KquaUs61ZDu
tQm/btBQGEp2qXkq55UWDmNLG61inRsE8bGM5z8xgjADb8oB/w/aOR3vJVbCfMbw
bEtm9bQXMdDdi1JsfDZrLVmp02BOpJ9dqyc5SEuHZnFiBK+Nps4bTR8Ujz1wwmV7
Z2ykcgHaJ0HQCHrqX9AJ84zQz6YGQSFbtY76A4pLaFyTqRAaw6Y=
=xLTl
-----END PGP SIGNATURE-----

--W8mm5ePR+YnbcD55--

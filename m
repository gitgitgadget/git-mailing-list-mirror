Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772B115279B
	for <git@vger.kernel.org>; Fri, 10 May 2024 07:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715324426; cv=none; b=Ue7hTki74YGVJZsEx8//IXYeVbfmJlC2clbKRk1VuQEPsNAoRhq1NZ49MaOCKrI6RwmbIiZ6/aE8VkBccS0QNGgt1F5QOTqHAInOG5UTnHCt4suOKG6muPP5V0ct0ZRwp8QakKoYdGJZq1EgCg85rACI6Mt80rhCKf3MPkoKIbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715324426; c=relaxed/simple;
	bh=UHEq5UG+Czqj1OFuFNEDrdfe4LcKDSAdu3xBxUxOMkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIZPXm5ZJtGkrqF2/yczITem8u0VSpcTGwDFnnAoxar/V+KdNqvvah+LHqmvBRsu04K5jVae2aTCevFJxvvjcqsHCAF8/oI2iWmtomq8OBjwEc9x19e2OBBql5HowXpJJ4KdjCnBFFPW5h8Olc898shA5Ysw5mcqMGAC46jeqQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MHMWaOiQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ks+wYcZa; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MHMWaOiQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ks+wYcZa"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 95E6C1800114;
	Fri, 10 May 2024 03:00:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 10 May 2024 03:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715324420; x=1715410820; bh=UHEq5UG+Cz
	qj1OFuFNEDrdfe4LcKDSAdu3xBxUxOMkc=; b=MHMWaOiQbspcFUZqNMTapkA8Df
	/NCaMiltSNJRR6+jUAwYgIvjWeByTJdFyD9ofoIYNGs7kJg7XjneR4C4R5am0Q+U
	DylsqVS4G7cA/oS63Axa2TqemUwtKzhO8miIwrJdSxjCUNrQ+0eUW+DiWGsFkBPt
	0RNEjmCaiHIsWq+iielk6n/gORih+5op23t7Hi8MnEqaWDPJxGG7lq/xurqZACtS
	xr8e9y1horb0bKztWdJnlAHXfFnvwnfCFu0znxCr3nHH9A0i5OFM+JCZKNcuZqCJ
	RgWtbIA9fYl4vuQcAYUjiuBXPKL23mUffwkhXuA1d7LQUg4k7JfwLGgOJnbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715324420; x=1715410820; bh=UHEq5UG+Czqj1OFuFNEDrdfe4LcK
	DSAdu3xBxUxOMkc=; b=ks+wYcZa+yESzuHkKSP7byAGFE9yerixByeDb/5hjVhR
	qTkZ2ljGYnjo6fMYOrWK45H6T/gP3zsA9XpPUB3QRkcxe30qY4jBs0KmwyTnNDC/
	pHm4AHUQ/fOV3/f3ItwMzgtHI2grIhoihqRjy9N3bGWNLUcFq+1ewreAsth5fgKa
	ia0C4ljJ1Y3FihG64UYYKMnPTOC0eApkRkCbyYWyCcp1oVsk+olaYg9XtVj0QH8e
	y4TcB/ut+O+hUeakeypsYtWKCcG8mfQC975scBrLX7EfR4OiO5jD4k6TItxPA0SY
	uKX5El2v7+LtjNOrwk0m8sGqjXDZ/oZwPVQmJ+UsVQ==
X-ME-Sender: <xms:A8Y9ZoC4V160nRx2cVMX5j9i8yG_QY51Tunh8fUj_eAmscfVRky-YQ>
    <xme:A8Y9ZqiqEllE9rP3KOd6ZwbgjYnf5iXiJMCM9zIgkWnIg_2Vwcgoiqt8Qwnnb1_Rs
    7MqFuUiliT27JxNBA>
X-ME-Received: <xmr:A8Y9ZrnxhaxVG3OWkK1BaYEMOgBB9uPxV56FyJ9nSjWgbHRGPDX2gL5R75mXB9ktuEfCMCLIRd2G3UAdmzBLUzAIzPPA6dfmP_w69ACHPdyFFMj2GA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefjedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:A8Y9ZuyNo1XNLzfpKQM0At33DMV9-m4k14e-OSk7tc7I8Ym9E-U2DA>
    <xmx:BMY9ZtQ5-SH0nHmetfdRt9XcJWvJWD3qyeqEzGloZqwPD7QVsRIIXg>
    <xmx:BMY9ZpazaAnsak-ZPehv6NaDr_jXJbqSzs7lbSoovujyZjMqS-J-bA>
    <xmx:BMY9ZmTM0ie4G8MSjIECIG4tKCgs1EhK0qdYcDL0slIlb1uQ6hg61A>
    <xmx:BMY9ZoctevDdh_n2eiQTrOQUcgpUxoLsxN5ImdJXkMFYQxDl-mPId1fG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 03:00:19 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id bf31a2a3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 07:00:04 +0000 (UTC)
Date: Fri, 10 May 2024 09:00:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] ci: avoid bare "gcc" for osx-gcc job
Message-ID: <Zj3F_paYzkQUC9fC@tanuki>
References: <20240509162219.GA1707955@coredump.intra.peff.net>
 <20240509162415.GB1708042@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5P8C+aFBO7o/a2+m"
Content-Disposition: inline
In-Reply-To: <20240509162415.GB1708042@coredump.intra.peff.net>


--5P8C+aFBO7o/a2+m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2024 at 12:24:15PM -0400, Jeff King wrote:
> On macOS, a bare "gcc" (without a version) will invoke a wrapper for
> clang, not actual gcc. Even when gcc is installed via homebrew, that
> only provides version-specific links in /usr/local/bin (like "gcc-13"),
> and never a version-agnostic "gcc" wrapper.

That's awful.

> As far as I can tell, this has been the case for a long time, and this
> osx-gcc job has largely been doing nothing. We can point it at "gcc-13",
> which will pick up the homebrew-installed version.
>=20
> The fix here is specific to the github workflow file, as the gitlab one
> does not have a matching job.

Indeed we don't. We could add it, but that certainly does not need to be
part of this patch series.

> It's a little unfortunate that we cannot just ask for the latest version
> of gcc which homebrew provides, but as far as I can tell there is no
> easy alias (you'd have to find the highest number gcc-* in
> /usr/local/bin yourself).
>=20
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> We'll eventually have to bump "gcc-13" to "gcc-14" here, and so on. I
> don't think we ever cared about gcc-13 in particular; it's just that
> older versions of the runner image had some ancient version which we
> wanted to avoid.

As an alternative we could munge PATH such that Homebrew's GCC is found
before Apple's.

Patrick

--5P8C+aFBO7o/a2+m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY9xf0ACgkQVbJhu7ck
PpTUhhAAoza89Mottv5uLMSM0rkV3FbW/5xZye0evN7yB/Va8WURkLa0xIus169m
PS0I1fDnMM/GJ4liFD7x0Fr12rLrVR8Ciun/zgeRLAPqdaG/+knA5xikKDl9LVTh
IbAcJr/hh6sARExeZaKeQDkbxidG4J6pmxzbJXgSkEgsY+4BpGI4xdDLOj2z0Afx
2wpcHwddGMWFEvKv7W2e3Lx1xUpcv8k5IbhXowdL50SDmLpOOk1h+R4fO0GO1bWU
7LAWAwY8J6i5A7oX1Z6ZVvxND2BrnpzLKmMuwNRVeEKKKwMPJa9PXF7vV56Hl7dN
4AJYrxxZziLFOGr5r1XhK89uvkH26Ht/5dCHvJ4LoKRxfcFsWCLEowDsBezhOxQ/
xWIW9Q7qi2WA0T52N1koFLItuwb4PJ4zSwObGp3znTGPTGOr8GXOxK7l4rnEOzSY
pmo9fnPqU9u9SlSiCYV2igyEuBAnMZGnKhHR/IRKiXfOm0NvIPHqtHVOpFKC3tbY
mBAPZsysPWLjLWwkXzebeu+RQKljHfvzZlbKSDol6Tjpl9v/rAQQhdpkyuC5HGSX
Gx/Opq8U38Cc99YpnxpEnIn3DHsSCCfIA4LmJZg1KwdDUhhGsEyZkxab6rsQUBRo
VFOdoJOTyDOS3v4Nupwue3+MlAfcVQqAIna/WH/0TlBozuKteE0=
=Zo8+
-----END PGP SIGNATURE-----

--5P8C+aFBO7o/a2+m--

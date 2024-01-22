Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4948B610C
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 06:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705904058; cv=none; b=uy/3PFb9jkUkrZ6kj8+tSErwd2UhBd0Y9IlILLzF0SF56xfqM5UN4bxc5y6i/L0RIKSxMCOPsAaY18sEankNwXQOr5FK7/Zas/1FakscN/x0AJoNPJcFXCiQhn3XFdmTbE5QXgoXK6UtNvwVkoFiwUaOm7twER3eYCDihOxgDGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705904058; c=relaxed/simple;
	bh=Y+52fSwXtMOiShjxNx/y2YUx6Iyrb0W1nFpCVun/6Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNU/G/VXC4uxdImQMQ1tn8ACncnHDTaSnaeB/M9Wh95OKbuU/0JXHgmqDDMmCZSV8l8XNKFo7IIjUi4+CtXIQLKF3nrNTOHlNKTAwnwjUNwHxfZiarduMS1idcBrYrKqE+M/fZA8PqE761edHeIMcimGzB0mUKejejTavssRvD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AdSKDyfk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T4lPmt+B; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AdSKDyfk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T4lPmt+B"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id EE89A5C00FB;
	Mon, 22 Jan 2024 01:14:12 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 22 Jan 2024 01:14:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705904052; x=1705990452; bh=F02bI6Xsg4
	hnVEX5zpVZ9vtmggP9MsD3BP0kXHbWYU0=; b=AdSKDyfkH1/tvXjSyMeG9vKQtK
	gvuyd90tzkef4aRNAz5ljyaef+aSSVk1rx1ohv4onfXjC6PqhxuBmcxaGoolY3iF
	jQzv30ucqOxZm7neAK2fZ/llxbOvEQ1hcMigBzDYVix6+jWMj6Vc1mPsxOQy7ijW
	Mf26o+qCYgj0hyxc+P8pHdmxLLZy9Ekn4Sw36cG+3fT8Iqys2CThrTeEt87wljaZ
	KB2eYDoXyFNORDnIBvxG6Ue2JIT7FmZ2a8C5Q/60lBzEHXe2A6mjiA+SH/Do4ArN
	N+z/VUWrP46qp0baLklTVP1hGyaQiuRFl+NbOp03QZwBYInLzrD5B7sBTalg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705904052; x=1705990452; bh=F02bI6Xsg4hnVEX5zpVZ9vtmggP9
	MsD3BP0kXHbWYU0=; b=T4lPmt+B+xpCWDoeaFCtorIbeyglGhLCkHlBM9MnmnaL
	pxRb/3rhv1fgLjAdWVJN4UG1aCco3wKSE6FFfWg66QBZr80n2vyJoryKs99OmY21
	tZwm2Pwd42Gk/rzFldbKKHfHjXVRcJAeZmall80niQv7TIVl3sbiC8v56KvatLAv
	7n7AWi+kglmPE5x2qixgtDWAelJJ/V+5HLmXuLwb7a0xCy4eFw7G8IWky7J4FZiB
	xRa+PokPb0Jw8MIiIzdu+gyuzfBi1Da1iwWNFilnV4PS8BPbR+SfWCch+2hfhu5x
	8YgE4DcA0R0FXQQWAjNshoxFG5hgBMmG7pxSHH1gmw==
X-ME-Sender: <xms:sweuZYvLeuEApMsZ4EiyfpYQg0TJ0KyjqMfqjaHCBCOHPOdozvnbpA>
    <xme:sweuZVeoQcppjB-IYtLATKNRg3jIpQOQ3ZLjh2cSsV_tV3lCP6CqEeCC3cghKIJBe
    0Kte6DzTagB9yDBTQ>
X-ME-Received: <xmr:sweuZTwvx7T3x07aWCACtAcxu0wqLFzI4LBcg6QLrk7qruSNahOOCpFE5XPSITxrgD-QAASx-ZcMAETesssUsVc-f1shEEdkF3FLdZluBu_v2EU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekhedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:sweuZbNwcsUuk7jaOfPawtHO4CX1OepXvyJVcr34HZPg1JwoH9L1hw>
    <xmx:sweuZY-SQj41zBh7PjZx6E9kZXdNuz4nv5a9BlVuOZHNRk8blx1vGw>
    <xmx:sweuZTV9v_Bz90-Fy6oxE0WOuntBtT115XUGHGBUDZlgiGhFdW1nHg>
    <xmx:tAeuZWm_9RnBDGJXikvCo3fGxrtA_eDw1o7SbP67O_VML-GHFEf1rQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jan 2024 01:14:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cb9c358d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jan 2024 06:11:06 +0000 (UTC)
Date: Mon, 22 Jan 2024 07:14:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org,
	Matthias =?iso-8859-1?Q?A=DFhauer?= <mha1993@live.de>
Subject: Re: [PATCH v2 0/5] ci: add support for macOS to GitLab CI
Message-ID: <Za4Hr_IIkgKVh4Go@tanuki>
References: <cover.1705318985.git.ps@pks.im>
 <cover.1705573336.git.ps@pks.im>
 <6e190a32-ee45-451b-b841-25cc6eb2c5ab@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UJRcP18RbaFqqEoO"
Content-Disposition: inline
In-Reply-To: <6e190a32-ee45-451b-b841-25cc6eb2c5ab@gmail.com>


--UJRcP18RbaFqqEoO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 21, 2024 at 02:50:05PM +0000, Phillip Wood wrote:
> Hi Patrick
>=20
> On 18/01/2024 10:22, Patrick Steinhardt wrote:
> > Hi,
> >=20
> > this is the second version of my patch series that adds a macOS job to
> > GitLab CI. Changes compared to v1:
> >=20
> >    - Added a fix for a flaky test in t7527 that caused the pipeline to
> >      fail in ~50% of all runs.
> >=20
> >    - Improved some commit messages.
> >=20
> >    - Tests now write test data into a RAMDisk. This speeds up tests and
> >      fixes some hung pipelines I was seeing.
> >=20
> > Thanks for your reviews so far!
>=20
> I've read though all the patches and they seem sensible to me though I'm
> hardly a macOS expert. I did wonder about the use of pushd/popd in the
> fourth patch as they are bashisms but that matches what we're doing on
> Ubuntu already. It's nice to see the GitLab CI running on macOS as well as
> Linux now.

Yeah, that part is a bit weird, agreed. As you say, I basically copied
the code that we use on Ubuntu, and that is intentional because another
follow-up patch series will rip out that part and move the shared code
into a common "install-p4.sh" script. Like that, we can also easily use
this script on the Docker-based Ubuntu jobs.

Thanks for your review!

Patrick

--UJRcP18RbaFqqEoO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWuB6kACgkQVbJhu7ck
PpRyrg//ZQ9yApXX2B8jeojT8zougjTruouCvbuJsRCqbOQLN0YBBS54vfSkQ9t8
1/voTtgbGEByxpGORrWao4tKZ8GE5DAcQA29LCZxwt5/De5uwQ5FbtieP1heL++0
jLQM5m6Patln2oWbPaRIe59LYn2BR8aDHMf2lLJ5InQvTAhd/vDdT2IPSFKUMhfJ
bJd9jh1mOHn/qFzqb+OcQ53tC4aAFf48ssHxO02lRust6Keme3TR7WgpzNlU7W7a
n+4JrIja/iPIMMHQVxI+Zg8XMEbwOjzzVBRpEP7O9dfE1nEVJxqaMsUSgragdaK9
u/t/jDgsTdsssa2WK0FU7IXTllitqutnKYmIsvTlEuyG2riCkEH8i1xiipXfBOT/
NDXBYreSzbQJZ5RQnfuHJ2mWATYwiHcs2xiRLORAcNcNBygC83Rmt26TWsROFYDV
0RKc6u21u5NGXQhwPoH1IgMjb+LtD4VgfMvBdRhEPkzBjXdwBU/KK/LCMlCZP7Kj
Xp7FAouIqjURkc9g+xcgTyHYmS5S5DU+2dmnALEUt91uNFxYd/shIGFANe0+2+0E
vF6oGqJQZ6szD3VMG57UzPzFahAXYtEArk2cGfnLv08gl6b+Q1k+8rsdKOQS8sEj
fa9BkyI5mOhfhTwrqads/vKAOi4C2KU4cWBP4dG/DyzrCjIwQ74=
=Qt7w
-----END PGP SIGNATURE-----

--UJRcP18RbaFqqEoO--

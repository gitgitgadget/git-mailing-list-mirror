Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4504A19CD0C
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 14:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721916714; cv=none; b=aOYIuXl2qAmsxi3OT4DA4cvKewJMRy+4mtoLiNsdSs5oGKPOaS3EDABJpv4bUvYes7FGZjXtP9G69p5FBRbQqPtMPT/o9IbR1BBBuL5g6eOc5tkZznzczGLS8S7Dt4tXUIPPzFJIvgdQTjYzGDprb132eusAl7ApcbKqVoh1CXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721916714; c=relaxed/simple;
	bh=pVPruLxTGwIBQlqFgLWOn1RjTh2bVEJxjSlNyj/xRK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcZJltYCcykusQIxvZWzjjqe90lPqTM/wmLsyjiXFV/GaPJTDVzMDYQ3b/9WHndkikmaHRF7+mpM31SGSl9qNI6iPbAUHezIsCmr65duVm7nyEH3AZQZMHjewt6+a9//+J0iZRVimtBQwdpGCQL12tM5+VuwEF07qOyWqrJmLDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UfbRht0x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DN8SoF3b; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UfbRht0x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DN8SoF3b"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 454FB1140101;
	Thu, 25 Jul 2024 10:11:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 25 Jul 2024 10:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721916710; x=1722003110; bh=ijJm6HbNZ9
	FuIDSyXECbAxPYpjC4dmQzMwBrAK5KhqY=; b=UfbRht0xgGRvQ8/Adqur2Eo4el
	LmkrERbkTnrzZYaPnflzNnoAtiNdgKmrTwfONexwvOyZzzOcqBbhPNVnThfHkBch
	s+iBASg0nDl83DZemKCvyyX4sk4kroI6akf8LOLNWVnaLvttZoxVnhKZUB+7ib5m
	U609+99vCPgBucbRT4BA3fBUHVJN7NpJHobSDDEnMxaVaXe3FtylqMT6nIJ5nbPg
	M4BXVsx/SxbbPGnz4/suN+TWAse9DnZPsokMmRk3ngU7N4h5398ZA55QZpBOaT2d
	oYP+GwxJxqWqdvFaXUbGZ9G4OVgox2Z0t7wzo8Jd3QESARt+peyMQwsivn7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721916710; x=1722003110; bh=ijJm6HbNZ9FuIDSyXECbAxPYpjC4
	dmQzMwBrAK5KhqY=; b=DN8SoF3bOp52riVoGIAefc/aMqNlYomysKYpgZtxIqBM
	wOwn73Ujp3ONG6+jBVg5ZT7uJIblyd0es/COEwrGIrjzgWvyHg74a3vLI6okG0DD
	YY2gINkECXl4AONTdM8Qm4vAnKIGhN2RUT/HopnMqr4H7N0+g1As95mQTcVfiCYu
	QF+aHwH9Hl129vstd20VtVFRO22QKBeUi4ZZEhAmuY64aDc2Dd/+v/8Py0JleZxc
	T0buPAk0n03vsfrMXi07h9sLfeMCN1CtXQOdrY+FuQ3IBQh2AnET4wz3BjzJso/R
	DYdd98IJ5HfjQVY8yyGNrsGK3y4T36mjjW93VbnKWQ==
X-ME-Sender: <xms:Jl2iZj-m97FmbLRLCuExhhjWsDGI_PHlCp5Phs09swlaEeEdpxhgpA>
    <xme:Jl2iZvt-2HF5CisOzbRCq2CDcLr-Krf3n-hnsMeJi1hYumRYkyN4wsxpiM6Ji3vgd
    04LnvGOQE0IcEzHIw>
X-ME-Received: <xmr:Jl2iZhDrB6xD_H7bBkddPGanb0B62APEDq6dA44tW3XWVdzn4GBcWG2YeuyRPGi6q7bIfqmoNi3NdY-zMJquG8qJXLrIdDdQnBN_t-CvYxC5T8jI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieefgdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:Jl2iZvfhMjQaHpeGmHfIi_t15Bm95T7zBUdRjOjjZuuXHAGrTknrrw>
    <xmx:Jl2iZoPkpa5GhpMlyMVvZWrRHXXmn0e-HAw-2yu1Tb_IWqNyT1XySQ>
    <xmx:Jl2iZhmamiuHXOwUGymNv6mEDpfFRipkBCh3hr1I23IJizLr5sh-JA>
    <xmx:Jl2iZiuk76a2AI6_Sth1hUGVT-38WMkvy7J4pwgCat0e4OT1B83wjA>
    <xmx:Jl2iZtrJ6Fb38kUUdUJWdzkqzsudbPa27HZ3pfc0PCe2mwPeu2r6BqGS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jul 2024 10:11:48 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8f907197 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 25 Jul 2024 14:10:26 +0000 (UTC)
Date: Thu, 25 Jul 2024 16:11:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee <stolee@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] ReviewingGuidelines: encourage positive reviews more
Message-ID: <ZqJdHlwIhv7NwJzq@tanuki>
References: <xmqqsevysdaa.fsf@gitster.g>
 <ZqH2DK83PoU2786-@tanuki>
 <3fc33179-cd65-454b-a68e-f1113926eefe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5GMkjRI3cbdUozXw"
Content-Disposition: inline
In-Reply-To: <3fc33179-cd65-454b-a68e-f1113926eefe@gmail.com>


--5GMkjRI3cbdUozXw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 09:31:46AM -0400, Derrick Stolee wrote:
> On 7/25/24 2:51 AM, Patrick Steinhardt wrote:
> > On Wed, Jul 24, 2024 at 02:14:37PM -0700, Junio C Hamano wrote:
> > > I saw some contributors hesitate to give a positive review on
> > > patches by their coworkers.  When written well, a positive review
> > > does not have to be a hollow "looks good" that rubber stamps an
> > > otherwise useless approval on a topic that is not interesting to
> > > anybody.
> >=20
> > Oh, yes, this addition is very welcome indeed! It's a painpoint of ours
> > at GitLab, and folks were indeed quite unsure about how to handle
> > positive reviews. I was trying to guide them into the direction of
> > "reverbalizing" and "thinking out aloud" parts of a patch series that
> > are tricky in order to demonstrate that they have indeed read through
> > the patches and understand them. Having all of this written down
> > explicitly should hopefully help them.
>=20
> I'll add the perspective of my experience here that this is a good
> pattern to follow. One thing that also helps is to avoid doing an
> "internal review" for experienced contributors.

Absolutely! We originally had an internal review first, but I also
changed that procedure earlier this year. Now we have an optional
internal review in case people aren't yet all that familiar with the
mailing list workflow, but more experienced contributors should send
their patches to the mailing list directly.

For one this has sped up our own processes. But second, it allows
reviewers to get more exposure to the mailing list as they are also
encouraged to always review on the mailing list directly.

> When Microsoft was first building up new contributors in this space,
> we were overcautious and performed an internal review before going
> to the mailing list. While this is good for a contributor's first
> series, it loses the benefits of doing review in the open.

Same.

Patrick

--5GMkjRI3cbdUozXw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaiXR0ACgkQVbJhu7ck
PpQitQ//cHtQKOXMo8p7c4nNHrpwLZKGZs39o7hq6ysMFSgPy1UE3lKh+18unOHG
MjS/5loheeD4BATSHDNe15Sge4p2oKkpeF6pbrQCHYM9tK96NyGyJnXOI+exCFfN
tchG4UPwJyxkdv+fGh+30mt79D8BFCQdqR5Q49JU4REJhs1ICsmoqMb6R3YtiKBF
VwnSG9rMg4t486ncYnk/ypGg48IOHP1jl1/g89ipoyTkDtSKLvlIlUvz9nLgXoup
naMPzhqG39S8LmT4IsgRNtF5bVyuemFiUwHDvZQjKzRbIyf2y1JMJsKA74/DHNJV
jq8RYYE4A9OfL09NYepZboAjKH3/RQYptx1NFUA2EevdjFmuMQgsMLRs9fmpMC48
bMCRRHIfti8mezlwW1rM48QsYM0Jo5KXbXPEizYdVZsPO33I1AFFvHs0xsS4VZ10
euRFV0f/wX95hS9JiVT1aOioLOcuZxVRSRvlMrKnSP3842WSGRcaKwik86RpMK8I
qhEuPYh7s19xMgxAKp6WAPzOigbzjjcBYJ4Wrv3aNP64Y/adNWlOq3PKWwWSHFB/
wG93bYlgkwVdHd49zsSEE1lmwYlhUmQjApdCa6+r0ewgWZpgwPG9oBkOWYu8iEB6
anRTK4cdKHiBAgbg0wXNMEvHlOPixXv3Ikzp0em4tpJKAdjTRZo=
=P52h
-----END PGP SIGNATURE-----

--5GMkjRI3cbdUozXw--

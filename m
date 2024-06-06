Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD02C1FBA
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 04:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717649476; cv=none; b=RkT8pcG44FLTsDk0hRcn30pUtFW/SP+redvMvsnMH4MOav2mHczeUHPcFP7rw0k3sH5kPdUMte5fGP77kSQ8OUhHbt/4goO50I6Q0jKqmrmVEw60U7DVfh4il+LKf84qKUa2rCGGp3Ka7n0CE69fpAiNhfCuWv4AZQzi51d3l1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717649476; c=relaxed/simple;
	bh=d+DkV7O3hVFcwegjK9AorMttn+saW6ORB+22oHvnmb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPRWlxxwo1KELlviy15+LCDXRwvYQUtA44GIlKh7HCzEsDeA+bgrDxIXEmOqprTLeB6RojlgIQQYZAWP7Ybr07xKC2cUyXk2u4ENIYfTaDy8OJMLX7YibnVacvBw6+W8y0zu42O82tJMI6C+/pjQ4RZNNU3P6EdM3olZ0CdanjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cC0wOeEm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ludjOxU6; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cC0wOeEm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ludjOxU6"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id A3AC41800186;
	Thu,  6 Jun 2024 00:51:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 06 Jun 2024 00:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717649473; x=1717735873; bh=05+CVjqfyi
	qy3znDwudFV8gS4hEL6n0MlxD4qWq2O9M=; b=cC0wOeEmv6K5gx9cOigYD/jSCc
	8jkdOzY38vplSC34tpp9GjfjO8+jONk3YbWB97Mx0qQa1vD/TH4lnJ+CE/4r4agB
	q/EYw5uTRd+/avVBmZ2n27a8KpF3Gzu/mqb990MoQd3MRu/aPqff1ydY12+PXFUL
	bcXgR47FQEEjpyPUJY3RSCo2WivIlf3LWhXh7tcqncUK/10LdLnMgI8O5bXRmXt8
	YVdd3nSmc8VI9wjY15FI/v5XiGiO5aBHG3kjmPeUaEZ/DqpSdNetD6lPUCz2yICS
	M2YT1BlyScW0qfXwpgyiytiWTfoSxsM1Pi5ZooYprk7xGmpNpf0wfBZFIh+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717649473; x=1717735873; bh=05+CVjqfyiqy3znDwudFV8gS4hEL
	6n0MlxD4qWq2O9M=; b=ludjOxU6WCsScoCw9FCeAGX358VdHOzqpPDlmWvPxr3U
	ladsLwVYVOusEPq1TesKCoFzPwfYeZ6jnJYiZZ9FdAlPFPwzoeadeQawbBo1+cy0
	TKTqMSJUPsjko4E2W8OM2kbQouWH9iyUYXEfciK85rb7syoeJPwQR2pNuyll67oy
	h1XAjZdCI98xKZJ++CsRKJclhsBkVmwGBOQhy8X89LB8bP29lsuVmPCsOoThjAAJ
	X4RAbGcb5PVBZ3wdzH3zZPio6FNc3GMSpY912oTm+PxYMBAmCpJUkl5F+YgSTNrX
	8yTMcWuLAQrBmSG6uVeW1FZjZSvfFI4m2QeQxMGKAg==
X-ME-Sender: <xms:QUBhZiLjYMOa8-sokbUoZvfJ8i0fyU0wuG4sl4RTEt0vm2RCk48X1g>
    <xme:QUBhZqJdn2N_C0MEmGpETCln0jPpMb-KTjygCpVOQWHOHk_dth2jZ_D7uFffL0oQI
    Su2ftWrevJXQ5FqBQ>
X-ME-Received: <xmr:QUBhZivCsl1Kp8JhTWlrRyGTBj9067gC8CpH-XgOOUdSuRa1149LS-NVyY95kHzZnT7yCrIfXe3ltFO2U7OZGm12q5lfX2PmJRVRUXlM4hkO3lJE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:QUBhZna6Fg61d1aDAE8wUWNaiT8wg3JwR9w8rdOhQFBKqk9IgPs6bw>
    <xmx:QUBhZpYsP-AHC69rM9C4s2M-_wazed7MmcO6IYIP3nInaGX9qd5HQg>
    <xmx:QUBhZjBcI-yx-nRs8fc2KFlAbckFtdwwn-v9Wm7WWS0f55E38uhd4A>
    <xmx:QUBhZvbxvl4uBOxJWKP4OE3chla7RlS5OAyrk_pVImeUameV7s7fvQ>
    <xmx:QUBhZuNUNbTVeB0Ex4oGHy4QJCoRZFy1qbTr2I7tjcgJsViDi24CE6EE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 00:51:11 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8185937e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 04:50:42 +0000 (UTC)
Date: Thu, 6 Jun 2024 06:51:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v4 11/12] refs: implement logic to migrate between ref
 storage formats
Message-ID: <ZmFAPS4E0IciYUvN@tanuki>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1717402363.git.ps@pks.im>
 <1f26051eff8b7c18bb7114803454611272f84e19.1717402363.git.ps@pks.im>
 <20240605100318.GA3436391@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FFvUhyfwhCsjxTaf"
Content-Disposition: inline
In-Reply-To: <20240605100318.GA3436391@coredump.intra.peff.net>


--FFvUhyfwhCsjxTaf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2024 at 06:03:18AM -0400, Jeff King wrote:
> On Mon, Jun 03, 2024 at 11:31:00AM +0200, Patrick Steinhardt wrote:
>=20
> > +int repo_migrate_ref_storage_format(struct repository *repo,
> > +				    enum ref_storage_format format,
> > +				    unsigned int flags,
> > +				    struct strbuf *errbuf)
> > +{
> > [...]
> > +	new_gitdir =3D mkdtemp(xstrdup(buf.buf));
> > +	if (!new_gitdir) {
> > +		strbuf_addf(errbuf, "cannot create migration directory: %s",
> > +			    strerror(errno));
> > +		ret =3D -1;
> > +		goto done;
> > +	}
>=20
> Coverity complains here of a leak of the xstrdup(). The return from
> mkdtemp() should generally point to the same buffer we passed in, but if
> it sees an error it will return NULL and the new heap buffer will be
> lost.
>=20
> Probably unlikely, but since you are on a leak-checking kick, I thought
> I'd mention it. ;)
>=20
> Since you have a writable strbuf already, maybe:
>=20
>   new_gitdir =3D mkdtemp(buf.buf);
>   if (!new_gitdir)
> 	...
>   new_gitdir =3D strbuf_detach(&buf, NULL); /* same pointer, but now we o=
wn it */
>=20
> Or since "buf" is not used for anything else, we could just leave it
> attached to the strbuf. And probably give it a better name. Maybe:

I like that version, thanks!

Patrick

--FFvUhyfwhCsjxTaf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhQDwACgkQVbJhu7ck
PpSlkg/+MJx7wto0v2c2lSeLaSnotVd2bep0j5JHqn8N3KF6viwAfQ73G4AKuQBC
sOT41Fo2hZ7kE+hQSdue0PT7jwAwHKnXMMbcx4KKEqYt7RPfk5ghamTIz0TrI4N5
tsZJCPCjtHeTllXnMnNAuu7I0N1iQ8co4esjBExvP6k4LRXRA4wopauqzk98Cot+
dFa+8f2oTtBwlf5gyt6YPB6pIGp0LZilvVDHGcvA1zFFQ6ihaT+Es4eiuhZ6Okcv
8zKcbiTXMrVjYpQS2G5CyIy4VZe1wH8lQueKMUmKB1LZUaBcLR/NxVgR15zwsCyL
CtOfdS3kvJOKTJnneiQxwUMCKGVetsVAoO6zjIWp78Wmnp8Gx8O2Am8nuIgpNlkj
yvBZ3hkE+ROmQEfkp6KPn4/rY/ytxJsx0kbRG6GZEO34GoK500C1tccZXA78pM7z
u9h+NWA4HXQg2aqIa8O4AKbpRZquAudATQEGBDlOxoM2PmUy07JivmSN+of6UA6i
0+q03S3JPibi/EIJf1feRXSPvofcFyePCDeci1ldnnEujv46SjV2d3wt9bfF0uAY
bI2Xb0/b4DY4joZvyYUarvDoz1liozhr9+/zBF1q6DeqoJRnP9MP/vmhSAAGOeU2
tgb6SKiXgh5LYooUyXW++jgRif5EJ3UJ4my4rpfycSIE3TecvkI=
=7EY9
-----END PGP SIGNATURE-----

--FFvUhyfwhCsjxTaf--

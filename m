Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AD57FBDB
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 06:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707199814; cv=none; b=PUa0mMHCcFlTp2Q/QCrYcUSNFBpS0bNMRkp2l7qs66S1ne8N3ZIdNxhTX/XXJ5K6qHyjYApNYPk3z8hGEJwO+XaOnMBkvyckflWKHqPREeoXe/sb6N+76CoNWDxj5Ng72hLlwybfmXil4FsojbvVG6QyNu31WYQM/sqBOHcOgKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707199814; c=relaxed/simple;
	bh=aKhZ13RrlbJoDjivk5zILjQKxGhCgxKO8bRoW+jwh/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLbqk+oknMTSvH51q8vPq32i0wRCSpfi8uecitSneAldi6h5dnoX6oaDRLpayXruv3ROpDh3MMcfXbc4QU7mu0TN5Gm09GKqOYou6w/hzhCDqoQlHPg3T5jbwt+vqmdR77YamcN54UOD7oZN1CDaJiCNj1spa8DmOKeggPmOZ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UXrkiix3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fnTgM0ao; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UXrkiix3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fnTgM0ao"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 555FA3200ADF;
	Tue,  6 Feb 2024 01:10:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 06 Feb 2024 01:10:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707199810; x=1707286210; bh=aKhZ13Rrlb
	JoDjivk5zILjQKxGhCgxKO8bRoW+jwh/0=; b=UXrkiix3OKVIsR8Dwyn33MzfXH
	yn7bybc6ghd4rCQD0cfE8Uvjs06Hx5xE+2fyvifZOA/d/5VoYjeSGppibCIT1lNs
	FpnlJrEqCrjkuExd0naYEBvJwjRZ7B1k60HFCsZTYRKaSMZR50aj9rIoR5sHYYcD
	Zm4YQK7WGInzmz3tS7GfmjNcUGvuOp5fCnSU/y+OrE2uTMp+moXAzGoy9W0ADJKF
	qxfhj9HUTtA9K83O7YQka2oc5Kqv09VKW0+jmkWkhRh1XU7Ifo2OcNp/A+VTOWOl
	v2tfmNiKlQTohbvo8HoWQquy+V8ONDnj9bn6UEm9YpBQOQwY6fLgiINbX4og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707199810; x=1707286210; bh=aKhZ13RrlbJoDjivk5zILjQKxGhC
	gxKO8bRoW+jwh/0=; b=fnTgM0aowj7RgGPLC7yBk60GCQdqOTJaEYIut4acvpjz
	zkgJ3qdQUyHIRBc4LkR6lL7hJQtGTT7ETDJHayC93VLnZBhOVB46+akSWSMzZh+S
	ybufV8VXvo7jiuPusKZY96kf83nsAWQXQnFdK7+Xqsiuh41sXfg4P2qHPGcILj4L
	+raffvV8tZMzni7r9iF9EcQ92KrrZKd+5PxqNE4NP53O8UJ5Bonour2YJe2VSV/W
	8WVhvgxk4SP1UH64mXiJcgB6yOSCmkU5rd/ViIFRQWlaRkg+OhTwj/dv9R0pMVTm
	xTQwGj180rIuXDtX2+ncPP4OoEpl67G7/SmuN9b33g==
X-ME-Sender: <xms:Qs3BZUD7yNymAO012-AFfj3APgN9t5G7tmHXj4ZsqBL4Ts5eCN8AMQ>
    <xme:Qs3BZWiWRPqPQqEQw8HQLrxebyv_VtnE6oJ0_39GvdmygsZpt9JR1bYwbhv23ZzBb
    ObSi05AehQ4yR-D8Q>
X-ME-Received: <xmr:Qs3BZXnSlf16sBl_WZ8T03VS-c0WQqrOgidmvnK63EYHSELO2uBduPNNr1Fk1rOQq8gv78Cuh-qxhjwnSDQh2SQRWbcMQKbQGfjGpJI5oCkMABA_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedvvddgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Qs3BZay_Us4vUhniJzUzxKPhaghsN2bH551THE3YJV8uPQWAULwPGw>
    <xmx:Qs3BZZToQ0gz1O6cSk2lAEa1PjmCBGuf0Qt2i92EzRfmoBXOzzlpOw>
    <xmx:Qs3BZVabNQl9HdGIv2AKgpOJsWnGzKyRYsHSAGUWgywHKj0Kzs99LA>
    <xmx:Qs3BZbfVeT6C17zwnEcyUZcpwbuMQTzYsLf2C3TzFGyBJYA2s9Npjw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 01:10:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0c9ecfb6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Feb 2024 06:06:38 +0000 (UTC)
Date: Tue, 6 Feb 2024 07:10:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/9] reftable: introduce macros to allocate arrays
Message-ID: <ZcHNPXf9ka_KhJxD@tanuki>
References: <cover.1706687982.git.ps@pks.im>
 <cover.1706772591.git.ps@pks.im>
 <2dde581a0256e4634ca4a64f313a98204763906a.1706772591.git.ps@pks.im>
 <CAOLa=ZSDz4PMqFGp3MHr7Ls2xOUs+NEnG-y09J9knNd_eGpZUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JOFzmeQQgiXZRc/U"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSDz4PMqFGp3MHr7Ls2xOUs+NEnG-y09J9knNd_eGpZUQ@mail.gmail.com>


--JOFzmeQQgiXZRc/U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2024 at 07:48:41AM -0800, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Similar to the preceding commit, let's carry over macros to allocate
> > arrays with `REFTABLE_ALLOC_ARRAY()` and `REFTABLE_CALLOC_ARRAY()`. This
> > requires us to change the signature of `reftable_calloc()`, which only
> > takes a single argument right now and thus puts the burden on the caller
> > to calculate the final array's size. This is a net improvement though as
> > it means that we can now provide proper overflow checks when multiplying
> > the array size with the member size.
> >
> > Convert callsites of `reftable_calloc()` to the new signature, using the
> > new macros where possible.
>=20
> What about converting users of `reftable_malloc()` to use
> `REFTABLE_ALLOC_ARRAY()`. This means currently `REFTABLE_ALLOC_ARRAY()`
> is defined and never used in this patch series.

Good point, will do.

Patrick

--JOFzmeQQgiXZRc/U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXBzTwACgkQVbJhu7ck
PpRknxAAi1lVRbopF3yskebGHVrEhPf2H7OgrMNSiWJY028m/IRY3iV+r8CG9AkH
DYaB1YOtSLvOe3L2uh8mbdU5BheywZIoevmR1HPbIYPY8TcPs0H8epOUoCINiKv5
UkBHrOQtBdeM8gWkp41IX6OdD3X+BYLRjW+iOserbZrFQpBFfEwlo9Enp6r+nNLb
4dCaGtLX8Sq6bvh8QQhcG4Dkjr2kpLBnUUoXY/+C39bJN9pNBS52bW1GkU8I7dYd
WJq+mrdr1ltl4SHVn5Yj2ltEvMZKBLMr43P3VaOZPJSwu8/AW7KzNKg6UYcPYq5v
1VkytbgUOnJYDmnHkFa9ovHCSA+sw/ZlDREHQqV+3lnb6QNMCq2tO4/QEIcx+lYf
fF3QyUxO7sf4WuQeqKZgVfSA6VSV0+VvfwKvTIXpA+Ppu/Gbwx1bWhubbb++PLRK
DCHk+iYhHbThiylW8tm8QLTHk2mmQL5Hll1WTqSnGfj1yXma7VQmdyjQjjLfEB+T
sNMXbXUfYPmMFWgE9V+CPRQQIeN/k7Vcp7UqAj7Mh9QUACOPQOHCGwoZMhfagJ5f
6tVRiRN6q06BKXU+d1D/6vw0c1jYwxZ07UejncXuCN6Je0v8993jTRTZ2bU85z6u
hVvhHkBeyCwfbawae6aWMYL89ib19pM9MwGFaimlF1iWGzfouOg=
=wK3E
-----END PGP SIGNATURE-----

--JOFzmeQQgiXZRc/U--

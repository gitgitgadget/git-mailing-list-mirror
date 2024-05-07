Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8907116DEC1
	for <git@vger.kernel.org>; Tue,  7 May 2024 18:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105565; cv=none; b=jo5Wti8q3BXi57Ko0wvDSTgg4q7uNHuXbpc3Z2kOSu34GLU5IslDgBEDW/uNsLL07tyUAMndChU0nqucHIurTcLNPP9VrvZcsRMxCFVmqHcxemtVvlex5M0wtKSmj1UNDaKMRMTvOrulKUDVywpFhKz5n493xNcrRvwdsXaqSa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105565; c=relaxed/simple;
	bh=6Na2QQethDEHKimdE8Km9lT7NaxOjGzQdZfbUg8CYLI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGYKGDbleZAx6/82Aa+nTFeYPYot6AoZqEPY79jXE8l2PxR6ts2MhivfX6+Y315vStZ8sHIat4P8kSlcpql/aaGfjAH9v9pApPQrirXymrTegtL1UpVE2+JBB+ytrvwxdxAGNgK5dwlsaxIGpd5JBmPIGKL4RDDhvwyFeNTP9eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UmieXMmP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GAoK2x6g; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UmieXMmP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GAoK2x6g"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 411D01C0010C;
	Tue,  7 May 2024 14:12:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 07 May 2024 14:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715105560; x=1715191960; bh=6Na2QQethD
	EHKimdE8Km9lT7NaxOjGzQdZfbUg8CYLI=; b=UmieXMmPiIiAKSTg9VdJkN6TSI
	ipmmMQfX3T3ny4f9LuKfaUjkugnRUEIt9o7t2IWBkjMs7CCZrqZlkofZeBG6xDUm
	M4Bqs7YriJGHhMwHW0QlMZAsiM5ewAKCCCB9u9bNCxyw+U47rMWBMfpeFydEVv+P
	sxtwuaLFURYZyCfwOYfXPyZREAaOdt8D1+mqG7Q3ajuVUrYJo+C9/pDZx0/diFlo
	53ojlHhUhAmjHAJfQODUfSWsVkIseZChjLau0IbNJbYp2wqXjSjM9/4ti2jvMBdY
	Xev6UGX8OTacBkICTxDg0SqsbNIvjQvi8102G++8xxq9Q1vO/JknMcjUJd5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715105560; x=1715191960; bh=6Na2QQethDEHKimdE8Km9lT7NaxO
	jGzQdZfbUg8CYLI=; b=GAoK2x6gMEpjyzQ6z+FwHhC6doYT1Pl5D0wlDdE0T69S
	Xbs0JQaA7mgi+9bKeCWXuHqzvTsWUYSskOOQeYzenUjbw32ekMtyhISJWQGGje4t
	MlPACQgBH9QCaB4/CxpV0Ta94sSg5hTvQp6Px83eVGSqGFWHkohPZ7VNY1DG4SKC
	hpQarmPclwNrPiHeyR9tgTQzVYYEA3V8d0bPf1c/c3pW/aXxNQLUMFHEMUxV9MW+
	uCgM3ZIMGEB1m5w9q1Y2DgC+5t3vlZnUXFApj3tbp8v9+lzTxbIBtf0ULVScWqQm
	++2h3FSm4LBW+fo/NgDXNVZbrbscnG/vlOo7inxsyg==
X-ME-Sender: <xms:GG86Zt6dw45olZH8-zib03YvgtWRsdi5lju1-SS4F77I1bTqDoXbuw>
    <xme:GG86Zq7Hvd2Qe6C6uuLSKhg2E4FqZzKj9ZEcZvSGoLlsz7F7m1j0I2aq6wvAUdQWV
    UPIV92El6-qfKRj8A>
X-ME-Received: <xmr:GG86Zkex_Nr9ZrA3yfSB4ez2wYP5ClvUsirtVMOJMSenPmvgZGCYXcyQzhDJloFHZnjSc_S4lI-lj3CFOSU8wjZC8TFz8YEgrznEQPekh_I8Z6IfRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvkedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeffudetueekffdttdfgudejleejffeife
    elfeduhfdvlefgledvfeeitedtteffkeenucffohhmrghinhepghhithhhuhgsrdgtohhm
    pdhusghunhhtuhdvvddtgedqrhgvrggumhgvrdhmugenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:GG86ZmKxNImlCXbnzR85dDC8S4PlDfhy2__0Pih_tHWvvEzMxu3Pqg>
    <xmx:GG86ZhJXaYGSdod8y2CYHYjkgyDuo1WV9LCvGVLZKLP6BunJZl3aQA>
    <xmx:GG86Zvzakh-SEa-kOaCg7lIpZd58T5VLMP9jXx9N7fuxwof3JTyr6w>
    <xmx:GG86ZtI2Mz0ExM4MfEzWYcMftyqXq23kAe6ppAWkIb3gFcRn61EuTw>
    <xmx:GG86ZoV0DZx2J-aL5AluVkVjJBaIxm2q3rQ1chhIx4mBybcUIk3bn9SL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 May 2024 14:12:39 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 66ee7b1f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 May 2024 18:12:29 +0000 (UTC)
Date: Tue, 7 May 2024 20:12:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 5/5] gitlab-ci: add whitespace error check
Message-ID: <ZjpvE-6xQ-rf5xO_@ncase>
References: <20240502193840.105355-1-jltobler@gmail.com>
 <20240503172110.181326-1-jltobler@gmail.com>
 <20240503172110.181326-6-jltobler@gmail.com>
 <Zjh-3dCL2-MnV-PE@tanuki>
 <xmqqle4mzwp8.fsf@gitster.g>
 <xjp247ji6zjyacniodws6jbdms7tr7726h6spsn7jvx3axqd4a@k6xhzf4v5akc>
 <ZjmqEEB2gXU_nKHz@tanuki>
 <lkd7hxcwnepjgyjhz5nl46h2igve2ttdoajtjgnene56qau6gh@dec6ticwjfqu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9SUmMJMKecBaQcpx"
Content-Disposition: inline
In-Reply-To: <lkd7hxcwnepjgyjhz5nl46h2igve2ttdoajtjgnene56qau6gh@dec6ticwjfqu>


--9SUmMJMKecBaQcpx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2024 at 01:06:04PM -0500, Justin Tobler wrote:
> On 24/05/07 06:12AM, Patrick Steinhardt wrote:
> =20
> > I just wondered how GitHub Workflows manages without installing any
> > dependencies at all. Is Git already part of the default images? If so,
> > there is no need to install anything and we can just execute the script
> > directly, which saves some time.
>=20
> Git is not bundled by default in the "ubuntu:latest" container image. We
> would have to install it ourselves. As for why GitHub Workflows do not
> have to install Git, it looks like each runner has a defined set of
> included software which happens to include Git.

Okay.

> https://github.com/actions/runner-images/blob/ubuntu22/20240422.1/images/=
ubuntu/Ubuntu2204-Readme.md
>=20
> > If there is a need to install Git we could either just manually install
> > it in the `before_script` or leave it as-is. I don't mind it much either
> > way.
>=20
> I don't have strong opinions, but I think I would prefer to leave it
> as-is and reuse `ci/install-dependencies.sh`. I'll forgo sending another
> version unless there is addional feedback. Thanks

Fair enough. Let's not overthink this then and get this merged.

Patrick

--9SUmMJMKecBaQcpx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY6bw0ACgkQVbJhu7ck
PpTnYQ/+Lt5UhoAkJne3CYm60NSXnj1UxCvhQCNEo7S2HOJp8/h758W1/oVOV8PL
zj+uUAb0rjM4aJlDHT89dAkP8eE69hggjW0SGJlIu+lOUywSDn5PRCYy6mCMzFrG
SRYIqsJjATyGx/CpDMdlDErNuAFMWC27tsqP42I0Xin+mlVOtm0jCclVsy6d4IeH
STB76V8iMD0OkGm3FUANJc+VFWemtKd4DMLeZIzN0jyBB2x6AUUqE+Kr1PxqcV9U
WZvi0ZirD9Qks8zT0/06rpxkKUwkbEJcwuBuXHGis1gBN82FH8l4VOZNkpL1dbej
6q9dAT2ngSgz6JduwsRVJS3EsQCl5XggnWQWkHtLNPWWbQMsMqN/wamX6ukBh1d2
vlwSgub045hEYwgK8LVzfjDktqWQKS143DLwDFIX64qpx1uedlX4aU+qTw3iOzZj
XZ/WmOnBv5KcJJM64bjsBBPdegOb6sEXR5Ez6RZUF/BuoNRH9Xg52SWtVAQa11wE
f8VPJ8qw+y9CIwmAQtbq98AXmgLryaRoODMIKtJCkQf6HgX3i1dP4sxj+MNEbg11
bmPl2oIK9rlTQHXgEe5jLA1uhUhWx8GbxQFX7nfBtgkuQtXsrEhSOJm6/C5G8Ljr
Z7HLzRoRVQHi31xqS/+95cZ/in0YgbhnLKpI6UI7QqDFLHVQDrE=
=nyNL
-----END PGP SIGNATURE-----

--9SUmMJMKecBaQcpx--

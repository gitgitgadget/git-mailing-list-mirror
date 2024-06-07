Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138B512B73
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 05:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717737015; cv=none; b=C+8WCxVOltR+nKtJLOQbisrq9jgxirZcnFuLrlOlSgyBb21Uz2buHcEWXYyWvm10w4rpmWpAkjwKEgz52i46mIkbuPguqpT+VjcpmmXlOvdexMvsaTji/+fV4a/78JWwklILavQKGSBYvGupNh07wwiMaIvLA1Ip9IJJE9NDroE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717737015; c=relaxed/simple;
	bh=Fks6LZlBJGGd3+lSB5eH8l9sujI+SHCnAOB29xzosYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAZvlgiR4RaiHnEnfH4+In7NLCvBKNtlYDQmjRTwCE/lj4g+sl6nDbU7Z5OGcvlfVHaxNoEIJBN4lgaC/dXbtgniHtX5ynzZxKcP9Xe3DF/c2EQkR2hvqWzH9R74R8c8VrHx+JHLnNp4HadRY5KYiBH0WqZOdHgRgxYAYHrJ6xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iZx225vI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=drmLaVRT; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iZx225vI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="drmLaVRT"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3725E114022D;
	Fri,  7 Jun 2024 01:10:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 07 Jun 2024 01:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717737012; x=1717823412; bh=ZCCnuC5TGN
	Z3I1Fxx0lx5Ki2dG3OcwW4tb7wMzC9E4s=; b=iZx225vI2FtlLVRURPjZdXiJC9
	K41ogDxredgJPtRKgG03L+gxcSkb/gs6hEZQj3Ltvop0zvLc4GZy16/posKjO9g7
	S0CLeIyZha1HuetSB314LxWlbQLEKt8RVb5lcdo8kXXrVvkZoI8ENMEbD+SwRLbR
	1X2yKsm3Kh3KvoYaS/+Tau4oSSvwefsCriK37zP79/1fJweWwarvN+1c/UatJu12
	ze7n/h/aZPkXsQwKG/GsHlXHOfBcZiJHcq20Wk3cGhgURA33sPAclx3EMmK0ecWD
	gw+3osehh6bJY7LT9TnTABQ+caD/426Mf/KRJybbhNLPUXzQXnk8Wb2bbNSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717737012; x=1717823412; bh=ZCCnuC5TGNZ3I1Fxx0lx5Ki2dG3O
	cwW4tb7wMzC9E4s=; b=drmLaVRTYdULVfeFAPA5tSrLuC5TDgA3PeXNqB3B5obJ
	EXyyOc/BHRGYI801KXh6vXyoqswKT0hycKuILWZOTndHekKTh0RV2EJ6Q7NGgPXV
	raEPdANypwLAGFSPVMSnV94rWsqbADHeDMQESSa4wGDzVqf0rhStE4RYGV6D+uN4
	aZKBlewdXS3TwP4ucQjuAhqrATkYXFLbY5NK63pGjqRhQ/3xLqXRraVwNOKLDXtv
	rlyyrTGY9zUZAfK6JXE8HotAiTJ48GKtYp60LfHpgi1I4KQAjm2d2HXHhQkmwIh1
	O1JLl1/wSo+s5sWNlSc9Kmf7sDHyrWwfrQVRgXVkEA==
X-ME-Sender: <xms:NJZiZu6rj1r3-BwKDwzjOiPlcDn-cTvGzw-qo7-6PULV7s9rMAEL3A>
    <xme:NJZiZn4kAs-dVXSDhjhw_iS4ng6QmvA1WweDaDG15bMUqfv-RXj22T6B1F4lVzPJM
    aQq9QfQ1lHvjtA4QA>
X-ME-Received: <xmr:NJZiZtcVO_AaNqKE10s0H6xnqI0WsRhMk5b9gs2Kuqd57QatCWv7-MtB2-7wqw25vyIblNgRiNg9IVjxwAx5oDElUsr3lTmU6EXcgl_JmSyICe-b>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:NJZiZrLi3jdZWBbtYyargyJq2uSgkWfSSjXPx_nmGKUeOrHehZpsyg>
    <xmx:NJZiZiI27p3Yu2F9DaWm0G_xnEsMmZ_6PFBfyD_hM5twXiQNtUsF7A>
    <xmx:NJZiZsw0TieiuC1PKfL1TluQ7gnHY6EKMeN9wh4BS32Pf7xm7RlDag>
    <xmx:NJZiZmJUaQaSGtlmtifNduzXFlwVV45WVLKMF47ALfpSaEAIieBDIA>
    <xmx:NJZiZu3nA9_HlXvv8ZIqjkZDR7NBZo0RgG3-9fiBW7CGNjJeKK2QcpV_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 01:10:11 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6b287307 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 05:10:07 +0000 (UTC)
Date: Fri, 7 Jun 2024 07:10:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] ci: let pedantic job compile with -Og
Message-ID: <ZmKWLV29TQ71DQ7u@tanuki>
References: <cover.1717655210.git.ps@pks.im>
 <351dec4a4d5a5619e7627e11a8e674e32125125e.1717655210.git.ps@pks.im>
 <20240606065236.GA646308@coredump.intra.peff.net>
 <xmqq4ja6niba.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OD4kry8YxnHnb7MD"
Content-Disposition: inline
In-Reply-To: <xmqq4ja6niba.fsf@gitster.g>


--OD4kry8YxnHnb7MD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 09:32:09AM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>=20
> > So for the pedantic warnings, we're left with a guess as to whether -Og
> > or -O2 will yield more results. And in my experience it is probably -O2.
> >
> > If we want to get coverage of -Og, I'd suggest doing it in a job that is
> > otherwise overlapping with another (maybe linux-TEST-vars, which I think
> > is otherwise a duplicate build?).
>=20
> The same knee-jerk reaction came to me.
>=20
> Speaking of variants, is there any interest in migrating one or some
> of the existing x86-64 CI jobs to arm64 CI jobs GitHub introduced
> recently?  I suspect that we won't find any endianness bugs (I
> expect they are configured to do little endian just like everybody
> else) and there may no longer be lurking unaligned read bugs (but
> "git log --grep=3Dunaligned" finds surprising number of them we have
> seen and fixed), so the returns may be very small.

Note that we already run arm64 via GitLab's macOS runners. That's not
Linux of course, but I guess that any architectural issues should still
be caught by that.

Not to say that we shouldn't adapt GitHub.

Patrick

--OD4kry8YxnHnb7MD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZiliwACgkQVbJhu7ck
PpQr3A/+PNOTox845AxQ7/P/tmEP5kll6s4HN+l7620yl9SWAHzAiI1kpwOatwDG
0Ww0s2DCgyoEmTEjBCQfqsH+aGpN+99ZPwUC+oIf09FXMUyrxg0WIjgKGrfCxxia
iepi53g+8UTDql7JxnP86bY1n55l9woILVxmJqZ4WHU/wdnUAr8khwjMyZreXUKH
VSq6xRxNiFDjb5/xzxEPTcjQfjFbM7i4/WVbFIAAP1HORqbT/ALZ9r+seOqXAK6k
WuOS38P2jFVScMUcG1XPGpanPeTDlBHG6wdU0VjQoDVqEtPTNGJjkF4YU9vCQKNG
WR8QE5lqunNVzbT05QfqwGi7sKi/AEmv/drlHvB/1esanSKLk/wonvOZ0L49ruje
8Hq2+Swn2joBroJUpu/dTEgSGtl4R6zPmAlp6sDoFu8bw2Q/48CM+/L3sZ1v8XV5
s5V1ah0LpsfCv3kfv1tuSn8v50fewwT0b+ebsUiNQhDVWRJEVoZsDUe9jB7kf6vs
eDV32/QCru4zxctz8EaNFYkn2sUduAnI0gf56OnrDcdAc4O1AxCS/EJQzy2boXs8
1C2jHuDcckSTPHbDvrTJOtU/ZWBt4U5quOdF3BSyxyFucDWxt93MiHZGsElguDos
kXn7Hjqf57Bp4HC/eFTPHcbDb3ZdgYSFIYubPPe1eU4JMBVVtME=
=qcNz
-----END PGP SIGNATURE-----

--OD4kry8YxnHnb7MD--

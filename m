Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F53012882E
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 13:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237864; cv=none; b=TWQOANCjJwuWuFUFWtzJ0DvtrcboKTRXDe6mjr6ojfeLKdGDKwwVEBh/OfMUf4r19d5WZt7D9Bly0f6WwcfcS2uG/uwdgeHMQqo+QROF9UcaM3SiRGqYzT7X4e2RleoHgcdf35GgVeKsOx0Vs6tbaX0aS5sOdXYMMTogWi5xMgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237864; c=relaxed/simple;
	bh=wL51VYcK+ZV2wsx6g/U5B9Z2M0RFoAIz3zZdJymmjNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ES69uhbxWF1m/+9QHMJ79Hz70EotDxtSamX9OkDuPLh53BAUhFJaY6RCBI1qfYwboGCQi9xqkcFFY+BfVca0ZJ50tPbexGVTcGx+2W/5m1GmsHgmo702RG1KRn8wk4dBejR4bcJvtwvKDGu7KGZ2kJ1vG5XJlw0PF483mkDYmwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=biEOxSPu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s+vzdN/S; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="biEOxSPu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s+vzdN/S"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3A07311400BF;
	Thu,  4 Apr 2024 09:37:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 04 Apr 2024 09:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712237862; x=1712324262; bh=eXC8B1ZTR/
	6cuorjswpusm7TZXe9Zt6mXnS7G/BJJEs=; b=biEOxSPuDUZVS6E6xEuhO78zJD
	jcDxkAftZv8BFU6LKuKc21G06X/yZaQkaeBytNTIdVGMYehEjQg9iAAhS6vYhh+u
	tbK6HFq77XHkm5V9OjbosHrCpQ99NSr2DYO4v5JNpMoJkOzSkFhmnibox+pMS3nE
	632PVZ4Q9TcuswJUSYFbhHgCAKh1LOI+qrK4DCLR7g0AemiY704a92JGGpZXKAWX
	SbpkOyIiTy80GmiYAvYSaq81Mw7s9SUEifen23ryI2kOz7IHfeYqelhpbyZf3Nqr
	8mYzGJTWaj64b3+X9fzpOmjmaa/kVe9sXXoRJDUAhXO7EDliPSNKSp8ZIlxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712237862; x=1712324262; bh=eXC8B1ZTR/6cuorjswpusm7TZXe9
	Zt6mXnS7G/BJJEs=; b=s+vzdN/SOmYLpCKJ8OkSLMO7cOGJ69lJMpWrEXch1/O8
	iE1cN4EBgujFTMoHj7I9U6QFkM3ZjvgtSTT28tnprdcChvGIRah1YrTkE/3A8uPS
	TMm+0mjh/5hPoSkTu3tk3IQkqivC2+xAkB0tt4IknkYv9d4vgFEJ/h5Q4f+SEcIy
	oGgAd1OZWC9Q0X4cOLKJHDaVbzdFMBcferWcnnfWOQmvIvC4Cej9BcBrGuSVKBg5
	j0jH24fPd1VCCfEE45ifRBiBdiLAdOSq16uSbfP756YeU5zDi74xgxiJqL7ve+MH
	oyichMJJGiz6+1lVIEzQKtZZRJF7KHaOJPqAPR2HUQ==
X-ME-Sender: <xms:Ja0OZpMuCZrCL2y-1GYJQNgcmtlnKXaJRaYFPzzYy6X-DDCOz-2Mdw>
    <xme:Ja0OZr8CO4eX31XVIfTEvn14qScxaaIkLJ63fdiHKXy53qyrhfjepqQe0oOdSmt9d
    NGGIR70hEexJDkkIg>
X-ME-Received: <xmr:Ja0OZoQdDLrsPo4WuFjxKDsv49Sx-kw_t4STyYzfwmc6O9jpJdhP6a8aAvFcOhXVzX_4MdiOM9Dq3kAV9VQipDy8YIkwXBEu4tui9kZFLa9-8Edf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefkedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepgffgieffueeiieeujeffffduvdegjeefvdeghfdvudeiieekfeffjeeiteejjeej
    necuffhomhgrihhnpehgihhtlhgrsgdrtghomhdpghhithhhuhgsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mh
X-ME-Proxy: <xmx:Jq0OZluVQAzalJSV63huRWdRQCR-B6R0WsNno8j72XjSKkNJDQVq_Q>
    <xmx:Jq0OZhce1xNHleHpyLRuLuTDj8RPsD2qK_2ENCi7IG0cHZKT9cap9w>
    <xmx:Jq0OZh0Wu-dWCsBoyaLoWwVtwbs-9kZ0upOmitQ8uLixNmuUyhUZRA>
    <xmx:Jq0OZt8J4LtW4BaQr3mIPCyi3xUwAFtCZyvA4X8Jy8Y9DjDPH7qa1Q>
    <xmx:Jq0OZpReuxQ9ihQvAwuiFzCQBg2pYvi-7P9WQZ3OE9qdF-QPNPMWb6LX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 09:37:40 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6da30fb9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 13:37:36 +0000 (UTC)
Date: Thu, 4 Apr 2024 15:37:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	JGit Developers list <jgit-dev@eclipse.org>
Subject: Re: [PATCH 00/12] t: exercise Git/JGit reftable compatibility
Message-ID: <Zg6tIZa5SfSfuIU0@tanuki>
References: <cover.1712235356.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pSvbUyAYMZPc8qa+"
Content-Disposition: inline
In-Reply-To: <cover.1712235356.git.ps@pks.im>


--pSvbUyAYMZPc8qa+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2024 at 03:25:00PM +0200, Patrick Steinhardt wrote:
> Hi,
>=20
> while the reftable backend is a recent addition to Git, it has been part
> of JGit since 2017 already. Given that there are essentially two
> different implementations of the reftable format now there is a very
> real risk of these two diverge and become incompatible with each other,
> which would be a shame.
>=20
> This patch series addresses this risk by introducing compatibility tests
> which assert that both Git and JGit can access reftables written by the
> respective other implementation.
>=20
> The patch series is structured as follows:
>=20
>   - Patches 1-8 merge "install-docker-dependencies.sh" into
>     "install-dependencies.sh". This is done so that both CI job flavors
>     have the same dependencies and thus the same test coverage available
>     without always having to maintain them both.
>=20
>   - Patch 9 makes JGit available.
>=20
>   - Patch 10 starts running backend-specific tests in all jobs, and
>     patch 11 addresses a portability issue surfaced by this.
>=20
>   - Patch 12 adds a very basic compatibility test suite for Git/JGit
>     reftables. I mostly consider this as a proof of concept, it should
>     likely be extended over time.
>=20
> These compatibility tests surface three findings:
>=20
>   - JGit does not support reftables format v2, which was added to
>     support the SHA256 object format.
>=20
>   - JGit cannot read reflogs written by itself when starting from an
>     unborn branch. This smells like a bug in JGit to me where it
>     misinterprets reflog entries with a zero object ID as new OID, but I
>     didn't dig any deeper yet.
>=20
>   - JGit is incompatible with split indices because it cannot handle
>     'link' DIRC entries. This is unrelated to reftables though.
>=20
> I have tested the CI changes against both GitLab [1] and GitHub [2]. The
> macOS test failures on GitHub are caused by the recent curl regression.
>=20
> [1]: https://gitlab.com/gitlab-org/git/-/merge_requests/123
> [2]: https://github.com/git/git/pull/1696
>=20
> Patrick

Hrmpf, Cc'ing the jgit-dev@ list didn't work out as all my mails got
refused there due to myself not being signed up. Oh, well..

Patrick

--pSvbUyAYMZPc8qa+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYOrSAACgkQVbJhu7ck
PpRCbA//VK+gvaekBI7Pn+nOGU+igxMOEggkMceFSTl+6/iMkG9cp7HN+2MVF4kV
VSM2TEL7klK9GVmxH03LJ5gZ/qlMTR8/ED5yfJSVsNQsNjBzU7vxBdHDAp8EcR+v
y1mvlYZySR3Wy+/uz0TNPxHgBC76kjPVaHsD/74X/adMYRYsNcqf8hxFBQtE8IiC
yk0oha0PVDeHUNdw/smtSGjFQgFbVlIOXfG4CsGdq5khSibDgLkUuYu4HKGtbExM
R3O/7X2ROoQw8F9oxiZzcCK1QApXhva5iRrp5Be7MnS4de2dVfrldx3lQikIrPmw
XhmyTmLFa39YR708MNXaxAgY28ZyZDhwg+/PspbDaWLjYbqCjGL1/6HbecehRgLB
Kb+vBF8dLrEN/7em8uX4kV58VJ9lM/bnwLTHQtq0p7u/2O6bFxEO0ZZFO2TsY8VH
4FAQH2UAvwNkfc5e1MPhsPdCzNiiYOpwZS5p4UuEmkN+A2Kc9Sht36BNqQyFTdO/
vIdIsWXL2YAIruiTElndxONgMs7xjvHDrrgMIHHomMzTvY2XoNmwv+k2IocSTB6l
EcSELfgiBKIQ5ngM4b1+olmBxvnO+w5a97giIgI3QmDtrqBgL9jHl4e0/BXweYgZ
qToqn/WUCwrZsdh8BoEC0URH1APE/gI2e6Y47Bu/lBkjlVvzEHQ=
=iarT
-----END PGP SIGNATURE-----

--pSvbUyAYMZPc8qa+--

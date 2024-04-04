Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298E52F37
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 04:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712203651; cv=none; b=tjpmQHP/8rv4Ex9k1sk7DQOpE64a4eNXQCUZumSsLFtjSja+x5JoZ4CBr1Dsz+H9BtkTxc57iWrWUKPISP0WFjvOVmKp7XOlJWVipW7/ehTaT5giQg4OwAnt3DfJ34BaZJhKZ4SqfGjilCGCn9E2nChNo+0LLLYXV9DP54tzNv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712203651; c=relaxed/simple;
	bh=HTXlGKkuo09zLrp9g+UFdreMXgMBsAF05D2YxyiYARE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lh940drXrc8mNChOl8My9WE5P8rZsSkrQ4O24Z/PCV3MYybmx3vULZOAeHAfB6/dXreu3U3rcq3Jn1tYGGYWuzRgnYppAWOGLVfdiiCRpRWBOoAlicFfb3HK2l/4A+y0lhHRRsXq0e0x2lFLasf1HQ4OBTKaxAcUISOcq1j8fkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xv2m8+aT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ie4cBuXP; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xv2m8+aT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ie4cBuXP"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0402D1140102;
	Thu,  4 Apr 2024 00:07:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 04 Apr 2024 00:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712203646; x=1712290046; bh=NTXyLOkYeq
	a/2zk3tvxlAWdNe6T5xE0iz+P8G8FbfZY=; b=Xv2m8+aTIcLmIUz/QLgNroYPAT
	mF0MGR3Mwubic95QBlquZFjHnnc0wEGJyjsRy8/a7UKWpNCn6wdeVCJcqOF3PbfZ
	J93BTV33rbjyp17ODQgNd5agK8XaFRDPIbPlKy0AI2pd3fVszbW58BIfE6JN6ysK
	eQ5wntpQPNAx68tp5OIrkS2m0Z88zl2VzFtA6BES7ghEmQ/fvRA44oNCek9to/A/
	xgzFC2iggt1LkSIVyASDTXrD7Zo/ANTVCPPBGw1vYgYhM0h/ztbCtgFEUMhQkdRq
	1P8Tr1uqzUiO+IGWpOVovJVIrU1LjtuzU8hqA2tpuKIts8y09BFFWFXfzDzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712203646; x=1712290046; bh=NTXyLOkYeqa/2zk3tvxlAWdNe6T5
	xE0iz+P8G8FbfZY=; b=ie4cBuXPcQO38G1ZktlR0lZ/RjhpOoDVXGcoFs5KBwyb
	3d91KRjgUrb/xdX8Qo6FjdMvbdcuSp1YTe1ABhbITQ3ef1GKvpDLMHJVWRryq04m
	ZStgmFkhJCcITJD+RPzkZU12xtB4F6mTr290PiyZ0CYKmZ2Jwj3bzzVfnWzjqEmc
	JX4DmMVExFJ7xftcoe82jAdi4GPHnWDhqAERyZhSbfIrjcgZsjYG73XWZsWLe6If
	IX5+Pm3CCb8wvOt4lpttHne8FKk0oRXN/GyUPLskWN91nrTcOXwWC4qaKHuQGPTd
	NK9rE6heCTz+8QI76z1XiFhO9/x5fpX41cEooRiE9g==
X-ME-Sender: <xms:ficOZnGvM8OBjOmoGpmSAW6lx_JflbHwR_TuUL5SK0bPyJU2NH9bLQ>
    <xme:ficOZkVVw47rty3zxc8ohAZTFDl561UcgXYbajbpaxdFEHTEuuYS50gc8inTstyS3
    8i_xHw66AvWXZTCOg>
X-ME-Received: <xmr:ficOZpKkw7BGSbFNQEYswhrI_hHB8MBIo_9fio36gpidW0FXQBbRZdSI2zPxWQ2tTNMLfsh3giJ7nzF4kSwQx4iX5ngQXAY2I8p0csdoJeRD7XwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:ficOZlGqo6AeJpdmCUnPOrrd3q_bn3WpBqgOm9vf94ZH77mJN7XIwQ>
    <xmx:ficOZtUOpO08Rv-etP0gB4-a_HVdKWlv3J3iK0ysSdXhiopW3yUL3w>
    <xmx:ficOZgNLcHeh-loLGmJvaw7EeyaUoA4Accs3I648jp23SUwtveywvQ>
    <xmx:ficOZs0zlvH_ZJq7m_ZThattKPa3QfvbZBQeuMbIskYPGSr8Woj_0w>
    <xmx:ficOZvLSH4KLmgaktfrTRM5EelrKYe_jL5tnz_XZgkW8_VwQ_Olm6CxJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 00:07:25 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f188517b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 04:07:20 +0000 (UTC)
Date: Thu, 4 Apr 2024 06:07:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH 05/13] credential: gate new fields on capability
Message-ID: <Zg4neXnm2WQHYnhp@tanuki>
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
 <20240324011301.1553072-6-sandals@crustytoothpaste.net>
 <ZgPSn_D8luXQyZGf@tanuki>
 <ZgSQr7uQdIA8oVNn@tapette.crustytoothpaste.net>
 <ZgvYLxfNwBcOB_s1@tanuki>
 <Zg323pR6UYthTakT@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8vkgBmR16zteYWJ8"
Content-Disposition: inline
In-Reply-To: <Zg323pR6UYthTakT@tapette.crustytoothpaste.net>


--8vkgBmR16zteYWJ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2024 at 12:39:58AM +0000, brian m. carlson wrote:
> On 2024-04-02 at 10:04:31, Patrick Steinhardt wrote:
> > The intent of this is quite clear to me, but thanks for re-explaining
> > the bigger picture :)
>=20
> Sorry I misunderstood what you were getting it.
>=20
> > I think you misunderstood my confusion. I didn't meant to say that there
> > should be non-boolean capabilities. I was rather missing the picture of
> > how exactly you can advertise multiple capabilities with the infra that
> > currently exists, and why the infra supports per-phase capabilities.
> >=20
> > Basically, what I would have expected is a protocol where both Git and
> > the credential helper initially did a single "handshake" that also
> > announces capabilities. So something like:
> >=20
> >     HELPER: capability foobar
> >     HELPER: capability barfoo
> >        GIT: capability foobar
> >=20
> > Git would only acknowledge capabilities that it both understands and
> > that have been announced by the helper. So at the end of this both have
> > agreed on a single capability "foobar".
> >=20
> > This is roughly how the remote helper capability subsystem works. What
> > this patch is introducing seems quite a bit more complicated than that
> > though because we have "staged" capabilities. I assume there is good
> > reason for this complexity, but I didn't yet manage to figure out the
> > reasoning behind it.
> >=20
> > To ask more specifically: why would one side ever announce a capability
> > in phase 1, but not in phase 2? Is the reason that capabilities are in
> > fact tied to credentials?
>=20
> More that they're tied to the credential helper.  For example, say we
> have helpers A and B, in that order.  B is incapable, but both A and Git
> understand the new authtype capability.  If we announce the capability
> as in this series, we can get a new credential using the authtype
> capability if A is willing to provide something to us, but we can't if A
> has no credentials for us and B wants to provide them for us.
>=20
> This would also be true if we used your proposal of negotiation, but
> because we have external callers (e.g., Git LFS) who may invoke `git
> credential fill`, which would be a separate process from `git credential
> capability`, we'd still have to have some way to tell `git credential
> fill` what capabilities the external caller supported.
>=20
> The per-phase capabilities are such that we don't request functionality
> that our callers can't use.  For example, if our external caller (phase
> 1) doesn't support the `authtype` credential, then we don't pass it to
> the helper (phase 2), since the external caller might not be able to use
> the result if we do.  If the external caller (phase 1) _does_ support
> it, but the helper does not (phase 2), then we won't return the
> capability as the result of `git credential fill` (phase 3), so our
> external caller will know that this isn't supported.  As a practical
> matter, that doesn't provide a great deal of useful information to the
> caller at the moment, but it definitely could in the future (say, if we
> had a capability for a certain form of data encoding).
>=20
> All of this is also true for internal (e.g., git-http-backend) callers,
> except that phase 1 has all the capabilities we know about automatically
> set, and phase 3 stores the data in the internal structure we'll use for
> the `store` and `erase` calls.
>=20
> I do, however, think some way to query capabilities more generically
> would be helpful, so I'll see if I can add such changes into a v2.  I
> think we still need the current approach to make the use case I
> mentioned work, though.

Great. Thanks a lot for your explanations!

Patrick

--8vkgBmR16zteYWJ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYOJ3QACgkQVbJhu7ck
PpT30w//cza8RYv2u08LxBBkq4mA7xDoejVDgPipPkapXNl3sO99lSjTZ0s9WuxI
c887MfnICfFE/YDbJAU15/td0qxtMwH6mflmWwodRh3z/maoG/v7WNVR1JMaxDYs
VJTX5WU4rpn3je96Hw/VxlNqintNF6bt3ZiQwfydXTPbC1yE4PVTVMej8KQKm8J6
z0F+LD/SbJM5QQf2q5CmLkQQJpBrB5q0rgoQuItfxb96U1HaV+mJHSHfup5Bci2s
ulW6TAO+3KB/0yKhAp/LH0c5XcmKswkCVcATlwdFA3G085Hk/3Z0LPNaFp9P/4Vk
TS0uEdBS2qLHu04IJ/UhLr6Wvkm4V7LirxLeOG45TwRM6zvP5b6eCZ4OA+Yl/Un/
MBILbHcnF5VEMb4rcQldimCdh4byVYzjtIf/JIkXCGlmq2Zqk03mvWQSBybMzXJw
lI1ncbLXMNXF+TXqmanROwjoJ+kppOGfZ+jiqEy/W06CR82QpV1qjXBT4lpXvgdJ
5tDHUZh07EBNmAauuKIFOv0vwEPpzLRCJCXOGBnw8N7GUhMsHzbYWirec3HKX/C0
cmguw4iek9uGs2P9f8GwdNeIHEhtkbFCMp3ni7N/Y/MVVcNcV4ZWsEl7cSITLTKy
mKI5Sswuv3YISdrYV2lKMGsOxItX8CbX/R/KdTYYPvzq6NYeMFk=
=DTCw
-----END PGP SIGNATURE-----

--8vkgBmR16zteYWJ8--

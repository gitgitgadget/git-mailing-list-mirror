Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66D3142642
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 09:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826874; cv=none; b=RDDRu3DEHukEM8jYnCKwaWV6MiAZ6MV6DCwTwp2C19DRLQe3WnIe144jmMXkOXXkAhLToY0xZyMn74EzjpeW87W0pQqi4EHH+fQzv293POBYPjaTiZLXjxvu0bsqYGgeTbs2uHCN54Ue2FU3SGsOTOgukNiE7h2mrr+/K7fmaO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826874; c=relaxed/simple;
	bh=EK3wGs8rTptQwkqEOLOzGm4m+YM8Danmh8U1QRPfyBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/tKLeEf8rlx/J6rViOiMJyr3HkJEEbpd/7fomEWyE+2JtMEnyW1PpMOwzJz8b+5D95IUveXE4zmnL32ENDFzBo07Yw1LRpP2Hegz0SVL8h9KcZ9zoRDHF7T9kYHWKBq/+uMuUnaseVf9HojM280IWXj7J/A7CHtuQ4JSmWMZxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k3mP8wpS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uj0aBdpV; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k3mP8wpS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uj0aBdpV"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0E3931380158;
	Thu, 11 Apr 2024 05:14:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 11 Apr 2024 05:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712826871; x=1712913271; bh=EK3wGs8rTp
	tQwkqEOLOzGm4m+YM8Danmh8U1QRPfyBc=; b=k3mP8wpSfTrDB1Jnt2POhNNIP6
	Psvh+KHWkwap8u9FIVYN1pP88JVSDgvHMnMlkF4D2XzTgWC8QUnzatFcRxwBkVNu
	rltVgqV95PSiBQPLdy05n7Urlr2+39PPF3q5rSIFi24EXJgw6l4rzPvMDXQe787a
	PtCLjY1sg+0xHB6ccNBhTtFQ8J26wqrEEQDNgqBTuxh/JBFxHNax1X5MiZKixlS0
	d7lzmWL79VMgeTXmN7H1nf4LWapMhzfE7ImX9vrCS3O7GHR5H0WOg1AnQYRIYjh4
	9dOK0i4Uju9tGKsbHU0AJma00HDe9d43M+nz3711FU5Xw44nAllXAaZWop6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712826871; x=1712913271; bh=EK3wGs8rTptQwkqEOLOzGm4m+YM8
	Danmh8U1QRPfyBc=; b=uj0aBdpVgsQ7I5AhHwgbq/ec9T1r3uCMeronbpAWcO9X
	7UaZE2RHIvx2DUyPUoyMERlmYmwnOv9ZW870BELvaQimcQEXGvzGSct1BSrEhBgo
	mCwewENnxnoECuRFnmI0/EJPcCi2GlZqvoLaTcHE1p0ZL7bz976SW/jXq4ZbUMGT
	IN+543JkP2J9/9c7A6gFj83ETj7HgA/VLzEFMebAqYur3RNO2BWOh6A6Y/nCdWn1
	f4OuWL6OFf3Y3xUMAbnmXjLHw2Ucbk4210f6VHeDmgFnoCMjFvwHFZHgUFNfeXWG
	JOzQm/8xGAYA0ReK/3P7x1IKco3RcHWkrm/bBF93Xw==
X-ME-Sender: <xms:9qkXZhuI-ulj-izAPfNrxeCfPbQyy-oQ1GMhsECWgX4iQhuoqlRs6g>
    <xme:9qkXZqdRzuAe1S05nL58HpXtlFe4gAzHhswdVOIMRCqEBRSfDy3gAHqX5PPfiC2ED
    9noqfra5A4ezr-5HA>
X-ME-Received: <xmr:9qkXZkwmiSQlEDfxYC89Qy52MzVWCz6xEAi838hMskhvp25giCdjnMZL_4fsDKWYuVwaEcLnTJJFEVc5gvJxc-X5i7bNZAWETpTX4CjfYeXoAtlx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehkedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:9qkXZoMCwUGcEeaPFhBOfVU2b5lMN2Q1uvEMdJHCTrwAWZKFWlp1cg>
    <xmx:9qkXZh-Id45kTpiUOk-yG2RnAifFGOjzZodLDcGvaT4cgwZURH-P2w>
    <xmx:9qkXZoVrq-wm84-VSi11vzURHFH2b4vp9jHSrAccN3v2n9M2Bblc5A>
    <xmx:9qkXZifXz65E0TGuLxsRUUwhT28_URPFKzIV3inwamgEi0pLvPfmdQ>
    <xmx:96kXZklcO5aoAmzU9a6KuZxV8i0eqO18lyodG6bMscvWyeFmLEMMWEnj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Apr 2024 05:14:29 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 00075cbb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Apr 2024 09:14:17 +0000 (UTC)
Date: Thu, 11 Apr 2024 11:14:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Thalia Archibald <thalia@archibald.dev>, git@vger.kernel.org,
	Chris Torek <chris.torek@gmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 6/8] fast-import: document C-style escapes for paths
Message-ID: <Zhep8lEsMa0aEpy_@tanuki>
References: <20240322000304.76810-1-thalia@archibald.dev>
 <cover.1711960552.git.thalia@archibald.dev>
 <cover.1712741870.git.thalia@archibald.dev>
 <1b07ddffe000ed2ab34bd41f4f0558ae8b2dd663.1712741871.git.thalia@archibald.dev>
 <xmqqjzl5t6mn.fsf@gitster.g>
 <FEF264E3-B671-4F0C-AE41-FC8EE44DBE28@archibald.dev>
 <xmqqy19kqxbd.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+9GIGj43LQQwfGgy"
Content-Disposition: inline
In-Reply-To: <xmqqy19kqxbd.fsf@gitster.g>


--+9GIGj43LQQwfGgy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 10:32:06PM -0700, Junio C Hamano wrote:
> Thalia Archibald <thalia@archibald.dev> writes:
>=20
> > I expected more pushback with 3/8, where 9 tests were indented to place
> > them inside loops in order to test them with multiple values for root,
> > so it seems not to be purely about whitespace changes in diffs.
>=20
> Well, if I read it, I may have (or not have) comments on the step,
> but because Patrick started from front, I was reading backwards from
> the end of the series, and I didn't reach 3/8 ;-)

I wasn't all that happy with that conversion indeed. But I also couldn't
really think of a nicer way to handle this. While we could've just not
reindented the tests at all, I kind of doubt that this would be the
wisest decisions.

So I just didn't complain :)

Patrick

--+9GIGj43LQQwfGgy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYXqfEACgkQVbJhu7ck
PpRCnBAAl/93jihM42o3B0UosC5Wkyumb5Ij1uSjz5VmIkqcOEWk3cC4NVo3imUD
P7HJjToRaKAf96oQvmZcOZkpbinmCvJSW5Le8GW+wZEogaI1jZArwUWOXsJghKNs
vBxlM8vwThvMZaircJEhnaNz0Azm4gsTMUr5mhXq108s4eCT1EC86a+Ye9jV2mPk
04axfZsyQCR3VOC/Cgd/WEJuAvpQ9fLoydzuhYQpJTyBcKOsoi9ZUNSxABmx6aIX
DhjYqsgtcL+jbiGNSJH71XHzILa69aBOlSKv9CcywvPZdRUPwCIvQM/6Y04Ccy1E
/yJy0mRabpuzhPGLCg6ixxSFA6zNrTiunpnqspTM/MRopLlzKYnjpXb/qD1qjDk6
Vh9dbBNBnF4GaB9SQTlAmhg3E726LNEJTsNZ8BjfRrS32OB9KHAsvt4bsecMt843
0DVC6mMGohwzq/PPCjtvaa7Tu6p5CUijTWyNEi7bA3Oh0kmjhuS0tmeLSrAxlJmA
UTq2c5+BwOq+rnxk2WJ8D/TKA/QvekZTkZXjXvmUb32OcgyDlRhYFo9lQHsPqa3V
unusCo+TAmz6XbeuEOAkYCR+QGTkGFOGmMyzreWN62vNFbbrJEx8/9DepvOntLeC
u1EHdkbY8Lx15KArEmCYgyAI4fA49eyynPGIhYrCyD+vk4712Qs=
=LaQP
-----END PGP SIGNATURE-----

--+9GIGj43LQQwfGgy--

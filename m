Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F2015ADA7
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 11:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711365905; cv=none; b=VooqTzDfJwN8g5vNCVQcGzBxE79trT3aM0lD9TU+Yj1EKffW1B8sqUVaSGb6sVA0R9Oj7Tg6Vqm2uVGb+mFAWfymTd5jLvh9G+4p+eKgnpewoj3KxIBndWWKsZ3eMt0HL8lLJWLA3txADDo2mPO+XIr/MIJszdHPA5dQqLMijgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711365905; c=relaxed/simple;
	bh=Ivcht9CovLfohWwK5UI1y42Ziur17HNs5mMmR4bcorc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=quBMmz1EtaqtWqCxoXpqKN33HMEByxl82CPB/IDQ+D+dzpC8dtql15gv7VF0wPRBCnPKu037jY5IWyez0Lgm2ZQIILh2Nfeq7tfAiGH83vnL3PTxiEndbHVvyDJBRWK9vD7OQcuh/H2K88t76QDYOn7PKK76hBYHekmcCMIVIOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KakbnDyQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SQGBrj9x; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KakbnDyQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SQGBrj9x"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8805511400D8;
	Mon, 25 Mar 2024 07:25:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 25 Mar 2024 07:25:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711365902; x=1711452302; bh=Ivcht9CovL
	fohWwK5UI1y42Ziur17HNs5mMmR4bcorc=; b=KakbnDyQxtw33aoNlxKLyVGk5/
	T/3/HrX+IPYy3MOS/x2JNOVk+Kj+Rw+E2+Y45EbX6tEbrw15KyEnQTjKRz+ffRO/
	c+KRYCK2NtYBXa8GQUE12n7sTNor7+T+Z/ylKwy26rn8u9A8l4Uyd7NWk5PLPlL6
	Zu8fVvLhSK0J2sSQ+yp61sY8SOKPfGmZEFev61e9HK1pxwwnAc0Ag0GReOzx+dhV
	0If6gCBxsQ0Ne3B+fr+v6frZf1Wxb5AxVkcfiLVqZjVMAGt1DIyOzVeGJmc+haLk
	1kcHulB35AOI4kAf5eEZupG2Y5KHS3Xxhwc1YuAN1zULB1y+lv1CGfN/iCtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711365902; x=1711452302; bh=Ivcht9CovLfohWwK5UI1y42Ziur1
	7HNs5mMmR4bcorc=; b=SQGBrj9xmLtYnOSuSRUF9YcHpkVwElxUib1Pl7YYpT2m
	2OOadl03rAshuWt8xo2ihck64O84bvkJWNQEG/ZGU1vtCIetePqz1c5RQ4yIuddQ
	QMAXDoZWt0NhnJvlmGZtwfWZMNI6HFOgmoJxpdX9gxq4F9b6Pmg8Sm/G7e+dOxzJ
	5KirmzW72kPZ/mgSOSp16ZCpNFoiC2P0G6LfSTHBQ6YuXlSvZYGF5iB6+XCy0CcO
	uYLDzZUKR0IJGidGF1PKnSIu3YtZOKAVOAv3VBB0Ba//6BrFRLEqimtFdBKFb/AE
	N+Kiw6os2FOhdgYu8q779RsAzIRFHXhXXabJThGTbw==
X-ME-Sender: <xms:Dl8BZo9ptlfo6rLAjuHZX6J_lCvpGinCpC59kvZcETRfZ7BgqxlVOg>
    <xme:Dl8BZguIS9Urri5cb4T-4k45W9iFdL9XtPxPTUiJ_of2uuuxk7RQT-cegGhOlF9rw
    u0K25hJfwZaQhaQsw>
X-ME-Received: <xmr:Dl8BZuAm55izMkUTOA5cZVg4M_oZs4rd9K73MSr2YklWfk5cwrtbvbDvRYFkGKXtFO1idn5wadfMSG1Z4EJoiBI9MigHAieyMLw9RwUF6WJ2tg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddutddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtroertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheefhfeutdevtdefieetueeggfefleegleevheffueekleefhfeikeetveduhfff
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Dl8BZoc5vCLwL2CfxoIB9dm0Ygumoj50pkquqlHtov73O-92Nwia2Q>
    <xmx:Dl8BZtOMizyRracPOwl2nWS1NUFfIPLBVs4ua89Aeps5EyAUfFxzyQ>
    <xmx:Dl8BZikkW3X74GiflAUbRL0JA_uHkSHsary8LyE3l3AxIsy3xyEwhg>
    <xmx:Dl8BZvvMtDBmSt6naiV8PfyaZPo-ZfgalKIITohwIZSaEW1x_6v2NA>
    <xmx:Dl8BZpBQXdJ3dIbj8hBU6S2y_MwaGq6r-sVyc5S-zbuF_MzJf-hW7g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 07:25:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1c9bfd9e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 11:24:51 +0000 (UTC)
Date: Mon, 25 Mar 2024 12:24:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: eugenio gigante <giganteeugenio2@gmail.com>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	kaartic.sivaraam@gmail.com
Subject: Re: [RFC][GSoC] Proposal: Refactor git-bisect(1)
Message-ID: <ZgFfCxkHzTHoRgmX@tanuki>
References: <CAFJh0PS_VB8yv7B1uM5+Ts9PtMFtU5mL4y8UUDORKQcYHSoxPA@mail.gmail.com>
 <ZgE1fxIFFQIdtIyN@tanuki>
 <CAFJh0PTxhDSW1qsnVRrDxmMnp5k16nPGe6RAgrmWow0rgYV+dw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fbIQS8LyQ20yuaZ+"
Content-Disposition: inline
In-Reply-To: <CAFJh0PTxhDSW1qsnVRrDxmMnp5k16nPGe6RAgrmWow0rgYV+dw@mail.gmail.com>


--fbIQS8LyQ20yuaZ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 12:00:58PM +0100, eugenio gigante wrote:
> > To further stress the point: the biggest challenge of this project is
> > indeed to find an agreement with the community whether this refactoring
> > will ultimately be worth it. This will require some good arguing on your
> > part why exactly you think this is fine and how exactly this will
> > interact with other implementations of Git like libgit2/JGit/Dulwich. It
> > may very well happen that ultimately the community decides that this
> > whole endeavour is not worth it.
>=20
> Yeah, I'll try to expand a bit in this direction. Meanwhile, if you think
> there are others tools to look into, besides the already cited
> (libgit2/JGit/Dulwich),
> like UI interfaces or something else, please let me know.
> (Maybe GitLab is something to keep in mind?)

I don't think any of the hosting providers would care. GitLab definitely
does not.

Patrick

--fbIQS8LyQ20yuaZ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBXwoACgkQVbJhu7ck
PpQPhQ/+JrFAajMa2ef6b98SkkC0y/G8ANsaqAU4mJFL7K5GZ9l5YdFUh760eUiZ
SYnhkKAJo86ObrbAI4m86cFVOdPa+kDFpZ548MVDqGFi3C2BdcNlnHE1td4loOvk
g1j75Iaa2uS+gut4EaJ3pYpLd5/r36q7CC8FvC9MSDdM+8ZUJVc+USC6P/uMbeFY
pqBcC0gWDCWjvLSS/f5SsfS5WmlCfU8q9uObEy38wehR6u6SVeIk3+CiNlbktu7K
Brg50zgXwWR6kDdCsTDkrFSak+FiabYv5Ybz4qfD+/7fPsH+DOKrmLRtxoXzR1J3
+WZP8XhdVqn0x401HdGCRpHRuParHqDFyalNdIPV6mWJ1AWhEZqvmS4yqxf9cJ4W
1XhgmkzO9mBn3nltRYICFWEwPPFMEse3L6xbmHgMIkLiOhJsynudzYJ2YlCqLpPR
RGRWbeun71bYAsy/8uKJJ0/t+ibWVCex4ck+ZyPhasED6cOl4vQLTja01NawLq+f
rpu1GB1XjWW+B8amFEtEZzDW9gGkRGzB+zymfmkecq4VzUJglXQ683uJzIuMJmID
KvlwtgsoJ+VgOuTFRWmUWqfBExTAE/hUA5KpVJHA2CaL5vntfKfikEFwqSYZhcxm
Zeui3KknzSbzwI6XFofmLV0/7yu2wMstEGV5fuNXUG0kXjdGaJQ=
=tYf1
-----END PGP SIGNATURE-----

--fbIQS8LyQ20yuaZ+--

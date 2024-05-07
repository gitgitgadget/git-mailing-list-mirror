Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CD753364
	for <git@vger.kernel.org>; Tue,  7 May 2024 04:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715054923; cv=none; b=mNxcyg5OoFMFGwDDZjfzV/Vh0ZEvC6BnkFbW/xIVdcCnpJOmm0BDP0pfTFbJRzO6Ij1Vq7vx85LZMZ1bF4PHwmDkksqnyLk5csolcQipQw5NnIRJ3flL/7QZ9u6aV8Wm4iEgBMbl6fI4UsNEHOKj4qi7Grc3CJ0o/el0qzE8qZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715054923; c=relaxed/simple;
	bh=W7rrBrbhxWhYlWfhuSguU5mg7B4fXeftv1Zm0eXSgLQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3WWoRD2OugVhlGP0k4w3byMdatwmb3FxZDonN7ZxPTS3FNl9uC9+syjlZHTD+or5XVAPsJrp3zO7MQDJGgdQVR9NyfM6m8kKwWyjUJC/dzz8QXlUaHV+wqYrgB5/B//X48B50HRPZOSvMNGuL5YH9k31x3tzyfuG46/kGKdK4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=amFKtkI2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gud37XuI; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="amFKtkI2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gud37XuI"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id BC8631140186;
	Tue,  7 May 2024 00:08:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 07 May 2024 00:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715054919; x=1715141319; bh=+E33phy+zg
	kbF8/kgxu+Nbxix/xdW5XfILQRarLtil4=; b=amFKtkI2hBFNY2RYFpOjgmCvOv
	0jLmlJ9y96Ozuf3WOhsKtAetPytk7QzEkL/ZgcSkLar9J06PZqHHfUnPq9Nelb+Z
	K5jpqhTL3wqc8tEAit6frGSzSddSjcZjVYprezxdjdpA5RGmux8hrykuIuIGqifk
	b9nxevkPE68E6yf59qOYDriIDmU80f3PPB4nF5O6E/tHcglIF0ARPQaq220ouaAP
	c7S7pgi5+8GP+3pufv88DNC6UyrqD7S7JYphIijJm3HPbvW5ICD4bDOvLT5r7vtT
	qNUj9QZ833l1XWtoGxgY74OenPc2t/3W5HMwMaBlj+LISLgPPgaDR09D4KVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715054919; x=1715141319; bh=+E33phy+zgkbF8/kgxu+Nbxix/xd
	W5XfILQRarLtil4=; b=Gud37XuInPRnKPDw2pIFJX3eCDA4Y6vokNKR7AvssaQ1
	RF+9u8nAxrOVTk5EvimiBy2O28071dwZJZQVoG5Zvl5frSFaBdAv9PvFKaZEHBx6
	Ip4cJ2BAo+wwvg0a2AjdBqicGeLntVfNRIr8Pb/+Gp/evQn6bpZwchd2JBSRrT0q
	NycIp5+IpCe9wiRAwkww9BVAe1ULJtZHjivLZPMdIz6T2fsDwj23s5Vvr/2jiy1E
	A+t5ci89397WpipRvT/RIc4W2356F0vUAPInvmLsT0zb5txxWGW1MX8K21r/wQ3A
	onsMX1FoXyt29zNwPv1FzKRd3EpfaKk4c8+UDhVkWA==
X-ME-Sender: <xms:R6k5ZphFtdVA23q49FFGtRbHMjKFQOONct7vk7YoW8ds1liVjs4f_g>
    <xme:R6k5ZuBNyxopI_gbsMkyaCIaL0ih-o0N9mAiysmOmnPXmUSy8jNrzxT5wzYtqd71M
    aZIgioWwJYosgFMhw>
X-ME-Received: <xmr:R6k5ZpHAZxJH2apY21bg21FJkjMKmxNr3wwKOH_6Fd-WcFtzV0aP0BfCpLplWNqekdUPgTYoqsZaBh9ezKU1kNlua6j-c2MpGnk4lzLpLMDKY1KuDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvjedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:R6k5ZuSvvpVH9P1QUj5SEwNI1hUrwW-6cBBIera8BdFDdV72L1oAEQ>
    <xmx:R6k5ZmyAqy4S2lIZylb79wGDjBcFGyJCWz9DbA0IQUmt1pGX0CrOJg>
    <xmx:R6k5Zk5S3YDJ-Mz3R3GSJ2uziLo0MgRghWJh_5hkvfWL2jzdh9kXrg>
    <xmx:R6k5Zryws6yqSDHB7R9C1N4vmtwJmcvtcYNfbwfnoywFPgHSEe37Kg>
    <xmx:R6k5Zq9zlE828ExTpiSRoYNkANy0Vvjfx2Yss8dShP3Sc-k_LyOj9XeP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 May 2024 00:08:38 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 864dbe64 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 May 2024 04:08:30 +0000 (UTC)
Date: Tue, 7 May 2024 06:08:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org, Justin Tobler <jtobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ci: fix Python dependency on Ubuntu 24.04
Message-ID: <ZjmpQ4zdlarP4YpF@tanuki>
References: <cb8cefc20f373a3516695e7cbee975132553ea95.1714973381.git.ps@pks.im>
 <7t2cqi643tvzjdeq4fddci2dqclgffkavps652cnf2swehx4uo@kng4bm5kvs6y>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ftDKvekEYM1N7cpJ"
Content-Disposition: inline
In-Reply-To: <7t2cqi643tvzjdeq4fddci2dqclgffkavps652cnf2swehx4uo@kng4bm5kvs6y>


--ftDKvekEYM1N7cpJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2024 at 02:06:04PM -0500, Justin Tobler wrote:
> On 24/05/06 07:35AM, Patrick Steinhardt wrote:
> > Newer versions of Ubuntu have dropped Python 2 starting with Ubuntu
> > 23.04. By default though, our CI setups will try to use that Python
> > version on all Ubuntu-based jobs except for the "linux-gcc" one.
> >=20
> > We didn't notice this issue due to two reasons:
> >=20
> >   - The "ubuntu:latest" tag always points to the latest LTS release.
> >     Until a few weeks ago this was Ubuntu 22.04, which still had Python
> >     2.
> >=20
> >   - Our Docker-based CI jobs had their own script to install
> >     dependencies until 9cdeb34b96 (ci: merge scripts which install
> >     dependencies, 2024-04-12), where we didn't even try to install
> >     Python at all for many of them.
> >=20
> > Since the CI refactorings have originally been implemented, Ubuntu
> > 24.04 was released, and it being an LTS versions means that the "latest"
> > tag now points to that Python-2-less version. Consequently, those jobs
> > that use "ubuntu:latest" broke.
> >=20
> > Address this by using Python 2 on Ubuntu 20.04, only, whereas we use
> > Python 3 on all other Ubuntu jobs. Eventually, we should think about
> > dropping support for Python 2 completely.
> >=20
> > Reported-by: Justin Tobler <jtobler@gmail.com>
>=20
> Not a big deal, but the email is slightly off. Should be:
> <jltobler@gmail.com>
>=20
> Otherwise this patch looks good to me. :)

You know, every single time I copy over addresses. This one time I
didn't and of course I immediately mistype it. Well, lesson learned,
copy & paste it is.

Patrick

--ftDKvekEYM1N7cpJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY5qUIACgkQVbJhu7ck
PpTW+A//fV56bcuienFhQp6k1celu9jO80s0GLfaOz/6YorcoilZARttziY/f5Ov
YOkvaox3gYtZP8SpydM9R8fs3ihSFPXpOm+XkkdznH1lDU9aOAZYkCy8GLJk7STo
jOFD0f9UwcrJUCbfzJqJ/+oPfjy7QLsKK0Z77GW2qr+q0IiznCk2gAH5BhzJ7Rgc
VU1V1OKOkXxAM3QAvrHUBv/txFB4QuPA8v040TtSoA0T2e6lRrQgCDIV9UgiZ0qn
y/tqqqJmdguXAAtiqtQmAzP1ZDjyWX/n/A9bt+bFeEVeUscUkLYGe2WUCmtQ3SsJ
7AO8eKeUal/CjxYoqqQYmG5nup4jQcd6wsRlgYVTsJxVsXP5sSZ+pSGisN99qV5u
LZaJmK6YwAnYAMbyzVLUZJRfXCSRUJDPoXFcsgZEonEBlvIJ9DCFSe4A6FhLcbkn
hkXCuKdqFJeCmMluqo1NqQCLpUYrLi4vQXpaCrTDMutJ5RG6Ndz5UG7/eGTzgW9X
rcNzr9tV2vzTa+/XoICMQKTKKZMnzR0okHDe2e8deB97SIk9r5jmMYe7vov+0suY
296dzdUsB9ezEXRZ2r2Kspf1LlayQYVdr6eV0YZ7ySdKWsqr0vFUKBQTUEaVkmV9
HpyNPSZOKN4RbyYmXegFTL2QdcTqLbsyOO+lgZZDnKYiha01AQk=
=qkX2
-----END PGP SIGNATURE-----

--ftDKvekEYM1N7cpJ--

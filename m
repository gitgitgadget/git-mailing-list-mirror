Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB67D24B23
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 06:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712041004; cv=none; b=GCY96jA9W5Ja6crAi8w+pYyx01e6J0L7HiCiXLs7xSsbcEth2DJJYp8BLdQH1aPtwhwUYX1JDyYVY3bopo5RD+vKiGG47GAwm/E3hdIx7u10LP9VR+M5NX3Kpo2eRqgEBgUTr+u026QOKqjsKx+b8yHpUWW2T3mXaaBmaBO3pjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712041004; c=relaxed/simple;
	bh=EEB8bso4lgD2ozUyRLhBk+IJCqCWseSEnSrq82W/nfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJFyLk00OKMHVvfPNC0FhiTfNf6HO0zTgETvb4190ZVFxa5BG2lREWEBG/D7eZV4iCbXPeCoZeex+0XbCZxWg0UL32Y1RKGHUAOEcfLb1nxthCK/nWHVn0fij3ttJXOLgrlbNRyaPjp1fg2GAzS2Y9I3PU3MD81+t+T5yESUnEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cPvRri1R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RIAs5Owh; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cPvRri1R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RIAs5Owh"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 3191F1800096;
	Tue,  2 Apr 2024 02:56:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 02 Apr 2024 02:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712041000; x=1712127400; bh=EEB8bso4lg
	D2ozUyRLhBk+IJCqCWseSEnSrq82W/nfk=; b=cPvRri1RHavfjcN7UoYcim32HD
	Rs+vxexTVp63jARiAJmmi1w1zdLxMDthQsXEtIWYxI/tgbrtxlW5mhDbDuClj4rl
	oaarGN1gBuWrTYg7I6RurHYuWRQaTtMf5NYwuLABJiz11Zr+yhF6Rk5xPRRJmvic
	ljsZmfpu9pKeOZLNfzfOaI0VIFpNvdLqSBNBQ93QZkfUqdE2Lcr/jxVOVVVMpQm+
	bsjuU3MM1snKxtNwEkoackH2Zm19HbFT4SlP3clYo1oJonrtMZbWmopZ//SeJD/V
	+7BiHQyshhY3FBatuhRJoy6vN3rv9gEsag7wTugFSFOGB8yv9Nvdp8/OYVHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712041000; x=1712127400; bh=EEB8bso4lgD2ozUyRLhBk+IJCqCW
	seSEnSrq82W/nfk=; b=RIAs5OwhEBv9KbY3VAqbkKcBQeY/7vao5Q0MXyoLQbxB
	TPvT3HK71l+xUeZefYq7pQJg5l4gI3Hd07KcFbXNagJvH2B9qZZCbYH6bB8x7W8y
	/xMqkNwBSTo8oOBVx5dmgYxW5OXOSd0ay8ZtrD0tQXBl0svmSVgb3SS+FS4397np
	RXqsZ+WSAZfwfJDSa0EkZ4HCAmH21RaC7DpoMNpqjkx6iuwTbiRs8ZBv3QXb6ubh
	gzCLaeMHxrW+p4RYwIpC3Wd+sq1q5rP8Td6msSYYc6P8Zmwglsu6BQ5HejBVAeXZ
	slhNqQKvkesyNrF8K3p9Oa/Hje3E3Whc+S8z1bfKLQ==
X-ME-Sender: <xms:KKwLZnpoc1DUeF3xoQUOaVJFUpPYh22WLkMaNF9Hmxk1dwrOwZFSxQ>
    <xme:KKwLZho0b1VgJbest0kspRXa9a_4BQMBKvq7bywUTK7QJbHVIvBWvdkd4OEceUqq-
    wHNAyIQXTRuyfqXVQ>
X-ME-Received: <xmr:KKwLZkPjgNQmg4B5U7rxiopKu7JKnpmfo5C_bdBdL2WXxg3plSGQ_wGACb0wLhQ9WHvR74CopZLNdUBEY1O9sWHlZt8vLa6Y95tz2r8xvO7vsys>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefuddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:KKwLZq5htifAbyQHF63J1cU2gtHHvSwwG2gT4mc7Qo4rcAozJ0sCMg>
    <xmx:KKwLZm6vFfGiCFb9yEIWUQDyEhRkAzQh-F2wZrSI5BvTH3S8CQLdQQ>
    <xmx:KKwLZigiJ8B4cuoOyal2UO1Vn0lvV0Lh8PukghbVH9Jv9U4yQVchYA>
    <xmx:KKwLZo4M15hbURnZ4qvT34RHfszsDSkaZc7TVE5c2zu1mC7qWImuvA>
    <xmx:KKwLZoSD7TBxWDjeyAAi9c98VYztt2zNEQUHiiLyiMNoZDgVX4C1ZZ4z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 02:56:39 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a156f23a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Apr 2024 06:56:29 +0000 (UTC)
Date: Tue, 2 Apr 2024 08:56:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: chris.torek@gmail.com, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 0/2] improve documentation around git-update-ref
Message-ID: <ZgusInW9NSjtRiOw@tanuki>
References: <20240401144542.88027-1-knayak@gitlab.com>
 <20240402064915.191104-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+GgHSQkXzRl4C51A"
Content-Disposition: inline
In-Reply-To: <20240402064915.191104-1-knayak@gitlab.com>


--+GgHSQkXzRl4C51A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2024 at 08:49:13AM +0200, Karthik Nayak wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
>=20
> This patch series was derived out of the discussion [1] around my other
> patch series to add symref support for `git-update-ref(1)` [2].
>=20
> The aim of these patches is to improve clarity around OIDs in the
> documentation. This makes it easier to draw parallels between regular
> ref updates and symref updates. The symref patch series will be rebased
> on top of this in the upcoming version.

These patches look good to me, thanks!

Patrick

--+GgHSQkXzRl4C51A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYLrCIACgkQVbJhu7ck
PpSWuQ/9EpuFnHxN2ywyDpcBk6puNlP0opXSrGhfI7MpmHFEyxLgId4PZupWugv1
McPhFrFkZa2TsSVXcygkUn38T5M/6ZXl/UmRWGsaf88/xRdV/6rqQXdm7jRi+7Xp
Zpy1Nl4LouXVENUMfMqlBsom6iBaNPDenC6W8LkXrrwRldKjqcBM4rWzimKRd/YM
ZZjNDxDSviqJ7mwR7NE+a/UgY4P9u6oS5auWco3G0+xZu1y+BKmp3UseLxYbUjXy
tpM0ZGj4rAuG+AAeRK3b8RhfYOtTCk2XXRYMDob6pAqNYa5KANhsA8w5fx510PMB
5SZtECq+IYAQuOZjUBtb98UGQZLo4GKX0leCg75ZchTpqg2EPUDpVDPEGQuWkjg1
nA1MEE99w0Z8QV8vdom1wdxiHRDZTZDiAnS1E9JUc6kEWZ7d67ZuAWk5UMS+idPP
MuEOTGz1r8XUDr2yitdVC8oAXSMYbSFXWcdb20Vmk0aJzYpiTU1WVwJOvDhsF5ul
JBvCCNc7N82TR0vNM2BkyjW7tW14rZga5ckREwj3JMCV5CPjqQlVF05DxbudEWmM
BK7butzxr7ZybJa16oY2E6+hxxEktll6wlqR6TwI/Xx9U6tlKWwfl73HJD9JfL4h
8PwNAwFVvpy2x1E60Sc8th/e7CbZZfByQhCAzXx1X359qYpJsWo=
=VCHP
-----END PGP SIGNATURE-----

--+GgHSQkXzRl4C51A--

Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D94F143752
	for <git@vger.kernel.org>; Mon, 29 Jul 2024 12:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722254641; cv=none; b=H79Qg1gZxmHDVz7dCvuKdas6oWey7B+gYVBP6rY7vv4xfvrmFhIehgih4yFj3qWLVtE1Xn0drjqywDVFurdgLx10gX8cgpnvcD/YGeQwqL2QRb0m9h/LgoH8JRIK+uUgehTvUo2cwvU/epOD/uOc+rs9N1nJAeA7w46A5QXUahU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722254641; c=relaxed/simple;
	bh=xvScB9kFhP1SDtHZqG4DMjpwt3n1JRYXO6VDPYlHAf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=og1DU0WM+wJgMtfpnv0qXPFirXJHhKtg0y+2VaGrItVAEL+9Wmlzk+0i0hfqAvJ1pJ+DzVe27xHm66d8uHpQHwue4o9E2EhZqdXWJSVAR6+SfbJDmG44fTEvcMn+vyT7lMCIZY85WOxYnooz56PfQhfrPGumI2pxF6GjjDFbOhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Mr9lRRTh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vqZ0D8zj; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Mr9lRRTh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vqZ0D8zj"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3D86611400AE;
	Mon, 29 Jul 2024 08:03:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 29 Jul 2024 08:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722254628; x=1722341028; bh=h+c1Wb+8RU
	6YaLwgBhReqWxTzvVxlc8A9RbvcSGdMiE=; b=Mr9lRRTh5ZSomU/UnTEBAZKHux
	/sMOSor5RQm8fJAxwsSRTo5x3nFu+k12IrdgeXg/1ibHjngaunBM6Fx70jZYAWLq
	XWwk8xRs59Bxso/5axb1wJIENxMvYDbE2/DZ95a5Um8Nls5HetiVfh+3fZTvoHea
	Wzo+d2UZZmZxtdnu6aB3Ur5Pgx4pIY/oIYbIj+NzFocph36Eqnug9oSLyvFFVuJV
	8AG9PeqFDtnV6hNl5UDwuPbIF1zdb46v98XdZ9MFs/3CM7Tug2F68lFmrxGqSIjz
	9ToZiZtmLNjRcA0ULtXJCGMZMK3uyA4eqi1QY84vv4ONv7dGSVixl1pB2D2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722254628; x=1722341028; bh=h+c1Wb+8RU6YaLwgBhReqWxTzvVx
	lc8A9RbvcSGdMiE=; b=vqZ0D8zjOy2XOUyYShPFewD3ar3XqE10jXBKZ6P8DV3e
	bPHB2YPLEmDxopY0eeDM3gJQ/X8x03UBsDK1cdUcM5Oo1h5qIjQhko4RII903IZg
	0yqpXtNaI+3G+mNj1QCIi0/KYJ75Jdzd6O9y9Z1WtGCobGUH2lpUMGkWpUXrkiWY
	DvYIhGLqsq54YS/9CYOsmOJ79gsRs7YsYNzwGnVfWFLBGklJlXfMuYL0MwmVIZHR
	V/gW2Bdcjpfsxnab/VZtZCh5TwCFi/NWvLCggh5J680gKaUc3gtk0NHqjlFiHfon
	7eImQgEtQH06MW6xVL9mqLhN2A/VZu96IhClxukUtg==
X-ME-Sender: <xms:JIWnZr3Dxx-LArx9PwKOdtAKSW8qRp6YDqCAXWCG3IK3oGlt-XYTtQ>
    <xme:JIWnZqFBHKL6Z84axST_enorHRQj2SNav6PGSpC_1exh8__gDVDD0a02vrXl9D9DK
    Wc-Xc1sMI_Ejs7xKw>
X-ME-Received: <xmr:JIWnZr7vyn576EenfZZfqtzbuhjJxpD9D7gdPMHkUvegRAIA3zjOmC82PPPARsKveWDmTlfjfHbSM1L-L56yHVvNz_q4eQZFhRBNcYP3NlU-Zh0f-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjedvgdegjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:JIWnZg002Fs45ztwBfDDdTo4DyhkyaT4ZhjTDbBM9GUYYQrLgcpqFw>
    <xmx:JIWnZuGbEdh463rGeKV77zwAhrXFm2Sk06AU6IFYMJHs1G8UE8D2Lg>
    <xmx:JIWnZh8h3iMgEBBN_z4YbmtEAgps4LwEcKU1WLc-pOKieXHAEetTYQ>
    <xmx:JIWnZrmFh7R7tyjJHhnnAAgRrVRhCXcp2Z30-NvZTr4HoRhOv-vDzA>
    <xmx:JIWnZjTkZc1AZj67o-C-yaiZH-DBID8raG-ZhRYX_Oopwd3fE6CHXdVB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jul 2024 08:03:47 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7bd72fe0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jul 2024 12:02:15 +0000 (UTC)
Date: Mon, 29 Jul 2024 14:03:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/5] patch-id: rewrite code that detects the beginning of
 a patch
Message-ID: <ZqeE_GHh1adyK5PM@tanuki>
References: <20240621231826.3280338-1-gitster@pobox.com>
 <20240621231826.3280338-5-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XSIaiCi12u+TmLbn"
Content-Disposition: inline
In-Reply-To: <20240621231826.3280338-5-gitster@pobox.com>


--XSIaiCi12u+TmLbn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 04:18:25PM -0700, Junio C Hamano wrote:
> The get_one_patchid() function reads input lines until it finds a
> patch header (the line that begins a patch), whose beginning is one
> of:
>=20
>  (1) an "<object name>", which is "git diff-tree --stdin" shows;
>  (2) "commit <object name>", which is "git log" shows; or
>  (3) "From <object name>",  which is "git log --format=3Demail" gives.

All of these items should probably say "which is what ...", where "what"
is what is missing.

Patrick

--XSIaiCi12u+TmLbn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmanhPsACgkQVbJhu7ck
PpTa2A//fwY4wj19E9V/pyttr8YDW6FvcmGOmJd9eDq0rJ82I8XUOSeGVTRn3fQq
DRasBmBOLGyG5KSbuQBZ2Kjzi2aoHsg1prF4Ks+sv097WhOQEOrYGYSywE3cYxMk
8R5zIAZzdYJsBXcN0buRqZIuJIF44wWg1Qj1AxE76KiiyiQm7bnDjI9bm6487nBf
h6qxPN3F+8jD9sfS7zh+sC6/PXR23EOqeWGuMPOwpAY2Tns8NsyMqOrkzaSmeO6m
Y2I7kvZMK+qYzc32scrTgUNe7dH1pUNLaKMKsZ6bQlhB+SIcYRAKQQRtbmYXHclf
1DDR2bwT16+27tkPfFFS34QGzoyu0Zs7tSqvA2rysRjM+ZktLAknOI8LUiVOOSPA
eUdSfEFAyGp7hfR7cpAeg0cxXqAhy0v9tcMPoQeQpLJgNgxH+vgFF9mnOJUbeBHX
qZmDsbIkyYNCl7Bej/MHcsx88tjGqGLQgyoqE9uV5BF6dK/ksi/qOVcglO608U/p
9wPVtFt8518dJe1+0oS+XE8Z7Bm4s/4ztxue7vk+ld7fQOAF72H6QFAwWVaSfXu6
uGnNrCinA5lx9FSZkGim0I6lRv+qOKCyWcKXPCi1lkF31XHwayBCoo+Km6sXVn/r
piG+q7O87ZIQ0BCm7dD1MfRX9wbozTcXG2DeunyrynL/d6pWHoM=
=Lzn+
-----END PGP SIGNATURE-----

--XSIaiCi12u+TmLbn--

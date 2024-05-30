Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD141A38CE
	for <git@vger.kernel.org>; Thu, 30 May 2024 07:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717052728; cv=none; b=Fe9bwOkTjaA0IvjYIO4u8JuggmEiIgqlXcRVA+EV4DrW7FbaCvCLO5hryANMNgfWSvqFaGG8UqaP4uv4QCAacEkJA2mWviM3JCzCQonMhCr0QbC6HnjtSqURo3G/ELJt3mHeYz2cIdtc2xFQDM9MYGW0c2M+H/sC1vnLT2yw87U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717052728; c=relaxed/simple;
	bh=sKpAgRRgSxFHhhCi4UNoI1PUBB2F+CupHDLhMCfZ6uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AApaLGvUs4ETtgjNDRF8wsbMjcfbhXkiZqA8LBKqL6PV9aKMZ3FNP70JlR/TFTNaKjs4GGBVedsso2Sa1WsVyhgtq7eLElrJ48YjqR8YVuniQiZxwtoAcVMn8E3GM83Bp5ZUawUsGNHcdL3fw1nGn0oaX+fGCedGCgRo3NY/cs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z3X+ggCF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gBw2xPvs; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z3X+ggCF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gBw2xPvs"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E518C11401E5;
	Thu, 30 May 2024 03:05:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 30 May 2024 03:05:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717052724; x=1717139124; bh=sZP+xIRJoH
	vBka7q7OLsnFV3WRb4kJYpBh8asIqtryM=; b=Z3X+ggCFdGt5ea1e9mvd3h2nWi
	Qp4aNdo5F96TOkC8Mswdy2I/kqfGeZbIp8TMtmXyfKBfC8ny3tvJCgu/zxVg/Vk/
	H3Ok1PSWLQIjUVBgg3vwtv5dLfT8KPQDQR6DQZqyWa51W2ha3BSdJ44qIHoat7qt
	ncBRXf+7OnIdXMM41qmO2Lwf2YiIQjfmrac/1zkCdVZEHeKlZTZ1a1MEjMOP+gmM
	CntuJ05xVDSxDdzlgOW+wmwMnmVKGKoOJeEf3ydPPp23ZfXLQEXLUCQijtFx5NSJ
	VUSnZw1ozoq/g6mKv6TfW3tBJcP5sSon+xWBVq+0eiVbC1xAkTgmRndBzsYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717052724; x=1717139124; bh=sZP+xIRJoHvBka7q7OLsnFV3WRb4
	kJYpBh8asIqtryM=; b=gBw2xPvsMZp0Fu15rlbPynpglCybpnWWC0PkoYPk1YGo
	R2PWEY4wElhAoW2ez6Ku8OuKttLmi8O9LJMRQkp/b11RIHhEMCV9w0Aa23Y/bQDr
	rlXSZm9Eoi2xtLdfmsWMwJNA0nHgPyKmHKupLcoFAOY6nM6hf5V9oWNJQ17gJBxF
	Gu9+xFw3ZBU9DXv0ETuHzWBMjWJwnfyznLh+XaageH1yERuvS89jtPlx6qCzdsrn
	N/hME2RLxh8bHLJaSWQKOhGpTkjXKyYZ1rgaJR7/gq0EVUkzpf5mP5Gpy8VvP7PL
	tOi593y2JpESx+JCIv6UrR034DuXs/mBxUdeXiuJkg==
X-ME-Sender: <xms:NCVYZsakeHgHWe5AD-zcp3bPUAv5L02nG-sHQ0hF8UEbj5nfynKLGw>
    <xme:NCVYZnYo5pFKrAnhqy4dkv6rmyCcYI61MajslBL2BCx9dBzvMMaAdE4O4ybU5bmQy
    9KMbU2EQTwihfaYYg>
X-ME-Received: <xmr:NCVYZm-WgX_FjJnrXccv9SdYsitmJM-GCwfxc851KJtGD7sjTxIRsk6NTeMyKfYv-ZsA1ov5BKwgO2IqdqGjoliGWnrvciIk5R8AZGD0hypQ4aEwOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekfedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:NCVYZmozjOzIkhj5tYW5GFim1uxSduxTrw7qXVohcAA0eRnD2tnLJg>
    <xmx:NCVYZnrk3ju5It1rfNwKLC_BfZZF-R2r6u7J1yKF7xvoaBb9VFbUkQ>
    <xmx:NCVYZkSAi6w0JfYVn_oFO9DXJNlZ1quHVdgoHaxcEZ6lQqrS1deCEQ>
    <xmx:NCVYZnpG8HVddzUJmsAX19S3tjlaQFm1Qdms_q-uiikMYWFhFV6eRw>
    <xmx:NCVYZoBoY5n-qBSFdEUEZgS1_uBQYeOugB1l7zg1Ijx8Ct6utAn7j0z_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 03:05:23 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b4032f75 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 May 2024 07:05:07 +0000 (UTC)
Date: Thu, 30 May 2024 09:05:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 0/5] add-ons for ps/leakfixes
Message-ID: <ZlglMCI3GrN28A_R@tanuki>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716810168.git.ps@pks.im>
 <20240530063857.GA1942535@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NaHaxrxwXC0cdhoj"
Content-Disposition: inline
In-Reply-To: <20240530063857.GA1942535@coredump.intra.peff.net>


--NaHaxrxwXC0cdhoj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 02:38:57AM -0400, Jeff King wrote:
> Here are a few patches to go on top of ps/leakfixes. Patches 1 and 3 fix
> functional problems noticed by Coverity, and then the others are just
> cleanups I noticed while there.
>=20
>   [1/5]: t-strvec: use va_end() to match va_start()
>   [2/5]: t-strvec: mark variable-arg helper with LAST_ARG_MUST_BE_NULL
>   [3/5]: mv: move src_dir cleanup to end of cmd_mv()
>   [4/5]: mv: factor out empty src_dir removal
>   [5/5]: mv: replace src_dir with a strvec

Thanks for the follow up, and thank especially for improving
builtin/mv.c a bit further. The patches all look good to me.

Patrick

--NaHaxrxwXC0cdhoj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZYJS8ACgkQVbJhu7ck
PpRkxhAAjM1bPYnI/X2DmfbzebKvd6L6DyVAblvliwnC6DKTAyUtSgELZ+py33gg
70I5ElmnYTt9RwMkGnesDFPjd1rE2YOyjLEIgshrLsXmw9fM3inIXU33u08VcTPy
4esgN/0/MKt6ro7AH0zlxytG1D1lWInL+XwTnN2KEQ9QzLpP8C2Qs4U6beYHUfIV
lZX9Uy3cVWuPKR6d4eEmE0LznJ47S8EXcoCILXDlGEjVT7hJA7sOQXqVQsHZmPxQ
gZOYLD0QBi19vpk4Nd6M1OXgJAuyt9qswAuFdPaDScGTYUAJjWtV0DT+fA4KPO15
SA+D7+villR32V1seMe+ChXQ26sHMQwlxpNysc82dpXnhjajJ+ylTNJ6uzIZ82Xv
/Ah4ruTTxiZmdZ4w9+3t7j1vij9SOx/n2T6didBQQ8pPwX94SXhA5xbG1ua9770h
zGrCsafjDFHATzGkvzJFwmmXHI2826lqsWeo/bTEcLtENfsDVr/cJUoQQPU2PSLg
QMXXNat58cvdAvBkJHoKzcjD4CveYhIek5vYXRsd2wIYxVBf58Tj2g6lCYylRjgo
nje8V7NPnIlqsNNIHbt1JfH964OT2+OATtFZTL7RSeTwJJZt31O8V+2BxAGdUCgt
V0ZsLb+cSCyIC+zZNBOYCJknfwsjLR42BigS/gkktlKmp6JT5fI=
=QXqL
-----END PGP SIGNATURE-----

--NaHaxrxwXC0cdhoj--

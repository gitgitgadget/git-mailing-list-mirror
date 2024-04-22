Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A6B14F90
	for <git@vger.kernel.org>; Mon, 22 Apr 2024 04:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713761777; cv=none; b=U/Pdk5m69SIGC2iMiezM5cWsm42mpgOWfs9iVxoQFvL4xjslqJynQQzFJ85w85tKYNuBqPp6N5zwdqgG2fadzkWMkVnqbAvD6EHFIoJJP1Rl3fNFlm/heyv6ZQoQ97DZEXmMUklVChv0Y8xCSBsZPySZ4rZQo5PMha6leSDry44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713761777; c=relaxed/simple;
	bh=SJEeGBVNVjrCkvMd00KXHNdIAxLFuQ+f9cd8g9vS7OU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7iSpB27D9VCrgsqeCSyRIgCKO9wzAnuEScCzMH55NknepSPaaXONs1uXFXY4sEQVKWwGX1lqXoSE5bsTeMRIKJg/LAj9l0R66+/3BblnGoKnTYD10UEg2gvI3wD1pK/iOgG/XN6JOWgU3INBTEVybtKQ5YnhAs+J+Blho1ZG7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oSjh34tr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MC5rEe9t; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oSjh34tr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MC5rEe9t"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 24BDC13800DF;
	Mon, 22 Apr 2024 00:56:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 22 Apr 2024 00:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713761775; x=1713848175; bh=SJEeGBVNVj
	rCkvMd00KXHNdIAxLFuQ+f9cd8g9vS7OU=; b=oSjh34tr1KhjWbv6SeBPnk4Lnl
	8ZUtVjlHWkYztv/NbqnM+qXNuzOGdmUx01O7h7fT8t1FB1KGTai2bbjGHQ/6BffA
	JHZM8FNezLSWa/TYqPqTalk3alQ2HNYRxBI9t73GKtiQ8oIordXJu8vMKxcy9CKQ
	FL84IxtQWv4jsSStKVCSppRzuUuODm8EqNw3aEPLdqT2KnvjiJuNKrKsjQyaPAXr
	a2xem4aVSmMCXJFATTLsdYQfhy1z1sljy07OLOjYtZwtwIOr9e9jailpWYJHIpDk
	Pv6GP5SKs9gGidR3gE9+/6ihycpk4XKZxVhuIfnLDbrrBVAPM0Hh2KjTlMjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713761775; x=1713848175; bh=SJEeGBVNVjrCkvMd00KXHNdIAxLF
	uQ+f9cd8g9vS7OU=; b=MC5rEe9tgxewXeRgdkHMyFPduGq4vshTQnDReeH55oow
	M+NQ9JASeSIDU1Jf/CmDD5ItrzqKCasV16yQA2k1zvUlqeFPGsiHAVL3p8ZlMyjB
	PMsdw8qnipS6DDRGtzFUduU77OI0g/Xbw3N8fuisyIR2RXFEat0j3JrBee3c/P8i
	K6313CvpviSLi2trc6SqY5tIcSBAhggmohAr6HFeyZeQPpPiurxPLqpVa2SzrSjP
	ZvSMPUnYgkLA6ctcUg03kDmHGI3re46tkswMP7yQPA8XYCZWCJmrjvlZIhjz+zF9
	akx9KptpQb+UnG/F+CGypGC09jnLodp+8UMttPHs2g==
X-ME-Sender: <xms:7u0lZme4LeUPX0-3pj5TyBeHUPJN_bNFWeAaffLOg4jXD43ivDqN8Q>
    <xme:7u0lZgMqDkGYfRbCS2lK2Wl0WxlLNroqn1voqIIG2bYDZtU0WXgBqoXzmGAbuSkD6
    hfavJ0ckQ-VYNRi1A>
X-ME-Received: <xmr:7u0lZnjt6riYw-QbQpx2-vdbOgaPi1b3glotYouUfXQIF8gy7RFZ1m7FHfvC2FV2Azkocu8tVp3epziTfnqGToTDV650i2MMPsWNZ5yT01Vz86tf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekkedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:7u0lZj9Y5AyC65XXhHyrNQznZAfou6-mIkYudy7KOZNc_RUVz8yFnA>
    <xmx:7u0lZivx2dzKxYUTJ-Ni87RrQPohyDg9Mp6K86izIDkst0FA8Xg5Pg>
    <xmx:7u0lZqHtAvZAeVi_jxgT2C3SUlGSppj67OB5s3HhHHq5-dPzKtqdxQ>
    <xmx:7u0lZhNlx4H0qZd5IZy9TXUNZNIZQPmgm1tbIanv1M04Lf1E0iW9CA>
    <xmx:7-0lZr7Y4yHhlDx3sVjFQGDADa6QiElJjjBfuYCwj_ZnrorxbTdpHRtr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Apr 2024 00:56:14 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e505647e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Apr 2024 04:56:09 +0000 (UTC)
Date: Mon, 22 Apr 2024 06:56:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: [PATCH 01/11] path: harden validation of HEAD with non-standard
 hashes
Message-ID: <ZiXt6w0TCZnkIqbW@tanuki>
References: <cover.1713519789.git.ps@pks.im>
 <aa4d6f508b4af3923813e19ff82a4e8484d5ff11.1713519789.git.ps@pks.im>
 <ZiLABRgJPlNnm-uY@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h6kkGvSIboqQw8vU"
Content-Disposition: inline
In-Reply-To: <ZiLABRgJPlNnm-uY@tapette.crustytoothpaste.net>


--h6kkGvSIboqQw8vU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 07:03:33PM +0000, brian m. carlson wrote:
> On 2024-04-19 at 09:51:10, Patrick Steinhardt wrote:
> > It follows that we could just leave the current code intact, as in
> > practice the code change doesn't have any user visible impact. But it
> > also prepares us for `the_hash_algo` being unset when there is no
> > repositroy.
>=20
> The patch looks fine and is well explained, but you have a typo
> ("repositroy").

Thanks, fixed! I'll refrain from sending out another version just to
address this typo though.

Patrick

--h6kkGvSIboqQw8vU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYl7eoACgkQVbJhu7ck
PpTXfQ//bja+z5pyuYxokEKdYZeOB0vb6oG2rZD2pvhH1lC+qVfzY+qrRYObsPJ/
aMAAno1XNPlPJnl8tyjRC6dtKoc9U+dG04Z5ufPgShQ91mMb6O5A2xMhwF58BJy/
N1xFgKzJJZ/SDA/KBvyKQ88inb+aRUQa6cEDJ7T+Xl4EvIKU9y7mwntVd5w0wBrl
b6bfK6JB32DYFgnc7Vv5LsYAI9JAY9H8QM/DFhBsevdRGZlpGL0TbmQGdNX9bSVU
C/4kQv9/Xcui8K1j0ijH0hWHlXnL4Pxc8UaVfQsCUrKewmLWqIB/3W1D8+SXRvYZ
Eh3SuHS/RpGI6zrLFnNAnlCvZB4BIuuHM4uqJ8+W7EnGQmMGzoIZ21YvuYtSGbct
GP6b0z+rZTS+GcBfXywiz8f65IpN3wKX+rOVw5aFQJcLY8VpdaOt+8Eu4mifl6Ch
naf06PmnMiIixOx89REFqJ+n9YsAvMQIipmNNcutaPiM2h34OvFveLEJuSaAZxsV
x0Er1DsjmrNA0SdS5B6SjADy2kMv7ICY7bHJPpxIZI7jUC3fSx6DnniYZ8V6bVXu
9bHDPeptyiOYhupxLc8myKKuwTZr2k1hJ93DQ/DHkxL59yNNk6C/OyPT8muBLBBh
9kYCx0apinSmEBNRKdYGwWmo+VbXSfdGLSfAoi0ASYR+9X7mHBI=
=bQwH
-----END PGP SIGNATURE-----

--h6kkGvSIboqQw8vU--

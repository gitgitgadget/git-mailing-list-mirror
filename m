Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66D3B667
	for <git@vger.kernel.org>; Thu, 16 May 2024 04:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715832837; cv=none; b=GGA2ktdS8sxULX4yebXV8Pz0qR8zPQ+HV2yHWTzGeqEmJP7i/f/D+Dvun2GHwI+hscbKsAk/bONaAOKZje+xzaSoCB8EqipRhw1X/1Cui8vvLYYSnJPGr2ifl0nTVmoYg6mXoDGe9Ot5jhpguvd1VJ5C2mF+YndxGE+ErGfrWNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715832837; c=relaxed/simple;
	bh=HVUFDtPJ7UKDHbKhH+Flml0qjIyh1kby6pXRMiqQrRM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oiwFwS173wqY1Ee3cJixKoH3kUn8HMcN60hsBhlawzGsrBY5jmDmuvvJdcq3gsxElvj9SjUceNuGBaN8rfiw1+58AXrqucc6QvdXamI4G+xIwjKwucw1GgFWjMIDa8dEPYiMhyPFt6TglSMbvCuHFTOE9XcT5QU7sgDfAo8/4FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aVw4bC3Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MngY9yfX; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aVw4bC3Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MngY9yfX"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7DA3411400D4;
	Thu, 16 May 2024 00:13:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 16 May 2024 00:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715832832; x=1715919232; bh=pxg7WoTnsv
	guJ08Hs4AKI4Wczb5iZ7dHkDXnweQnWJM=; b=aVw4bC3ZsuUqnCGKYerpfMtaIg
	Ngl2SSx2ZOzkYaOeFgnP6LERsJhAx+X5RryLknHpRZ47+/aNsbBN5Kkvzd60zkWj
	Ig5Yfdw7rvZeG2pzUuc6H8C9tv6yh/T5qtIU35TOeY8uZe4MCnJFTpmuwZBc2PYs
	UYVFrjiNASoqWWh/cZKoIGdEV2wkKu10yFIxK87oaBQugDvh+M3MSg1URrj0wqRX
	eeduGANGUvBXmygVgS4rnmkoY3Eja7hj2aOX9lO9f0PSlLW20ts3yGgIMcSLBci3
	d23h4s7eZ/mjPcHCP2cq/CUUo9nzjxYNg295Wnf+Dw5+/jKs8jhR/9s/BI6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715832832; x=1715919232; bh=pxg7WoTnsvguJ08Hs4AKI4Wczb5i
	Z7dHkDXnweQnWJM=; b=MngY9yfXyYk7twzc9XwcAesFJVd2JwH4xr6CtXT3OCTI
	roiwjNbcqqK7YC5U1HRUuAb+kqQi2bFC6PLrzqv8u9gfv6AZb71Rq01yVJIkode5
	Q3Mzar/q5M2LcKwhuHoc0W3H2x0jCzIr4244qgZweQ+LCIIArsc1UopG9w0ZcCGw
	G0VgdIwyTVlFysmgCKo8KuK1zUOouGpWGSGtgZJD3SRRTR9NghrusIyhlLXwdy/8
	YpRh7Y7WHI/MkIcA2vUZo/WWqTqPMQomKEB4LtCe5in9ElgcHn+6iKYLwbwixaWN
	dplmgf+BXPub++vAE84zGuvygBs568qK44bsjye8GA==
X-ME-Sender: <xms:AIhFZmuv0QZhWpWJJMHEm1AXSUzg_M1dPh0H43EnGeqnU011ZHG5sA>
    <xme:AIhFZrfuexNCTksaShR3bcjltfuhSOgzKUPPWdE9FaYIi_KUkGOokPEG9Yu-lWMRb
    Y_v-HGFrlQr2I2WEQ>
X-ME-Received: <xmr:AIhFZhxmUV7VpvRTtQ-cNOb7OdpDnJVaxRb6dG59Xfj-0zfxIpLHh51VhXIdUylU1zvs6PEX7lKBoIv9I6OKehKCdG_v36MZihFVXVwFSlCrsPk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegledgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:AIhFZhMOGfmqlMHyqsbUVjPwAzt7J6HXrDLgxq3dAuwwu_-JoxoGPQ>
    <xmx:AIhFZm_UF0K9ivWn221QwUbixqqq90Q6AGDuSZfAaiakq9aIjTlyxg>
    <xmx:AIhFZpXJOyZXiKuJugRxs0vKk-rn3roNytTaHpsMlFaT1VxmlyYcPQ>
    <xmx:AIhFZvdDinwdxaUv-2O0Y9iXdieO7AN443Wsfvzk4qwfmMmdoLXAEw>
    <xmx:AIhFZrOUqqfw8wC5r8D_s2m33laErB9fIA1gT5bPMfSW4sRJYJTiLGj1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 May 2024 00:13:50 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 65f67daf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 May 2024 04:13:23 +0000 (UTC)
Date: Thu, 16 May 2024 06:13:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <avila.jn@gmail.com>
Subject: Re: [PATCH v5 06/10] refs: do not check ref existence in
 `is_root_ref()`
Message-ID: <ZkWH-eUXtVF9OmfV@tanuki>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1715755591.git.ps@pks.im>
 <af22581c2212088ea6a380cc1a58923abfdc4fe1.1715755591.git.ps@pks.im>
 <vgzwb5xnlvz2gfiqamzrfcjs2xya3zhhoootyzopfpdrjapayq@wfsomyal4cf6>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8XvDZGLZ7lJi2BR/"
Content-Disposition: inline
In-Reply-To: <vgzwb5xnlvz2gfiqamzrfcjs2xya3zhhoootyzopfpdrjapayq@wfsomyal4cf6>


--8XvDZGLZ7lJi2BR/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 03:38:47PM -0500, Justin Tobler wrote:
> On 24/05/15 08:50AM, Patrick Steinhardt wrote:
[snip]
> >     The new behaviour is to include symbolic refs know, which aligns us
>=20
> s/know/now/

Fixed locally. I'll refrain from sending a new version just to fix this
typo though.

> >     with the adapted terminology. Furthermore, files which look like
> >     root refs but aren't are now mark those as "broken". As broken refs
> >     are not surfaced by our tooling, this should not lead to a change in
> >     user-visible behaviour, but may cause us to emit warnings. This
> >     feels like the right thing to do as we would otherwise just silently
> >     ignore corrupted root refs completely.
>=20
> Is there an expected source of broken root refs? Or would it just be due
> to bugs?

Dangling symbolic refs are the only expected source. The fact that we
did not include those here feels like a bug to me.

Patrick

--8XvDZGLZ7lJi2BR/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZFh/MACgkQVbJhu7ck
PpR6+A//VEmlTv9ReqMUwXljvuOahb540fNFJpop6hkRsX11XsrEfJfG74MnKvo1
JMHivxm5AZyc71uYXk2PhZtjVAD0n5x5hgd6rQlG2eHMc0vPS0WrcaklgeqtPOqP
gxYeRsyvd46k7ZIvJ6KZG6K/cYMCZ/uub8VKJGM/Vpx8S8HEF07jQGyNYgVuLFFZ
lXchDly3Aje9YxiN1uTr6nAebyn7e4QtkFokKF6QY16fBEOtflCJGMY5xTqjQyPp
lM91EDCVdWIDm3bvufKYG0aWUUUEIoSbtBaJR1eUyVKwRUkgv3tAwEDH5jiOrk/z
wBhg95jwuTfZSGzSGRsQ4z7A9QSzad+lzILNBBKoc3Wr5a4zuP/0brTmEnguyxjp
d+MTlX7sYELbdG+5RChkVMq3JVto9yVspgQK0lqFccQcfu6bHNXy06VUyixU4mjp
xBJBnLYYffGL5//ORgoTxqS4cG6unfV2i9VoGU7CHwYHJcg9PcHvn1FwuveNINOW
bhnha9nGOu9yMEhU7s95fEJX8Lt9ZBUaQXcymfHGgtIk11IvbmDrCeR2uDoFZWa3
sVuNJxmH8qXtWjncrjftr+N9hatCs6C7C9S8ceMGeixt6TMrKdBk7J+Lo8LwrEF4
BtOqMqlWpyWQybJ1irIAMreouI7f6lnthK3jRxVEekqhZ5mV1H8=
=WZor
-----END PGP SIGNATURE-----

--8XvDZGLZ7lJi2BR/--

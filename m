Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B357D25605
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 04:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718167513; cv=none; b=WvcvKcO7fNiSE7mQwCswtpypFpWk7VduIfHFj4IncJRrU43Tnxq69s4jigm1kebgmPAuwII63UdFOwr/OSTk3rFx9pOG0rVJpVvaeaEUMAhuKN9FZ0WZnWSdXbvimB8oQDZRlnQWi5zALdbllk8j+nGdiLfHraI64XySvFUqPVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718167513; c=relaxed/simple;
	bh=SB7tOU2Fu1+5eZ3ul2BzISUl7sShk106clYIhomH+/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTXbn7s/WKj9+9cyPPuRStR4B7QRmPdemRldjGy11+QRWKrIk4qZyNTrqyG91DlJvCV5GGWs2Awm4thOhlsrAH4UQs826OL2oT8BLc07dEiKOfx1VeysAGQnrry6bTTBYdvWV/XynZqHS/E8RPvc2ZwMt7CvqiQvWowcCTLl9Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WNDYdXYy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p0b8kVXk; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WNDYdXYy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p0b8kVXk"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id D8FA11C000C5;
	Wed, 12 Jun 2024 00:45:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 12 Jun 2024 00:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718167510; x=1718253910; bh=SB7tOU2Fu1
	+5eZ3ul2BzISUl7sShk106clYIhomH+/k=; b=WNDYdXYyDPVfUtj09qD9R5Tife
	/NpOu4zlpTzY91dk/xdOhNXB+k8j3Ni5I87cvgbzmCYP988N/d06lwlq53ZZZcof
	dbny7wm0+dgP/YcOjBkrv3OjIRrM0+LIA8fl9eTYrS4zrk4mn7+KWRYCtSnDFkrn
	u+CwA1frj3iiq5NFWGGY9j0PV7L7OsCEp4EF0cB0pbfqkuD+2osJ93xeu2k8wRzV
	pAoLFcvCKpwuJFicUui3MVC3NAnh7OnEU/+/V0zs/uDl52Zv0F8cO4dEpZuIJqIm
	tCn0RtFTlWSgSA8ppJBLGwOY/AeZGv5eZo2Y37xyjq/JBKxkPYxKuBneM51g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718167510; x=1718253910; bh=SB7tOU2Fu1+5eZ3ul2BzISUl7sSh
	k106clYIhomH+/k=; b=p0b8kVXkOZmR58fOsjIuhTm8WEAqp5qy0UzaDwETUYH4
	U1Dma6sN+eBAL/+r2ztSV1IWF0eVKWEgVyHzPZ6HSEUEMK+7iarlFoZpY9Jhte93
	hsmcX63GbrFM3yn4viRZhMtDxVZmUF/W6lRHYROsuuQpZp3L8qYJirnTrVM4PBfT
	ZxN3s+ryze4IO2QtFc8LKQd23egb7W6VC+wwMHyOTr/9Hqrjm5SdnP9dOb2zx7XO
	fAabkNuIv+RsdN23GiWppQTUAGvgx/o2qfyDmNpPDFcaLqbcnewvgS5zf2FLHWqZ
	7lXcdyR33eqmvlRh0uDWfFjUDEplYYnVZBYctr2iHw==
X-ME-Sender: <xms:1idpZphlH821ZRGO5dgSpDUxmHy5d-CjxAuQgwLfEzKW7DtR1ZLjiQ>
    <xme:1idpZuDtukv8LsM_VdNTUm_iOCORbn5WtODcWz16zpuFoUpFbxLYsX38T2vGyhawC
    BRqN3ZDfAVnYaaxgA>
X-ME-Received: <xmr:1idpZpHgLrKefzPpzD3OCD-HZkjbeXIokag66Vc7So6DxAW0tzfq190ySE6jEgFjKl5QpvzwQZkFLzKCrYTYJm-G4-P7_AHeTIkzTSwSMHlgzSoU1Jc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedufedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:1idpZuRPRwSmgHliVrP0CrTEO7xSNNV6bCJWemAHZlfYzTi8fw0aBw>
    <xmx:1idpZmygl37F2RN0MEHMqd5tiNP9RXQGa-vtC0XeOhVHVSZXX0nrSQ>
    <xmx:1idpZk7yJi2FdTfAL6vRF8X2KO5QXN5En0SFMl2hDtEfdCWChWhFww>
    <xmx:1idpZrzQzK14gch1LiC8lQspiDgME53GS1pqwLwlpWWXSYcczhMtAQ>
    <xmx:1idpZq8Tcl86zRg71_gU8ZSFEmrBmbhkJCcyAs9mCerSkgm1YH3kn-dN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 00:45:09 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 844b3ad9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Jun 2024 04:44:58 +0000 (UTC)
Date: Wed, 12 Jun 2024 06:45:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] DONTAPPLY: -Og fallout workaround
Message-ID: <Zmkn0oWnWvVB6Nej@tanuki>
References: <cover.1717655210.git.ps@pks.im>
 <cover.1718001244.git.ps@pks.im>
 <03270d3414117ae7229d87127cff81e349557039.1718001244.git.ps@pks.im>
 <xmqqed946auc.fsf@gitster.g>
 <xmqqjziw3arr.fsf@gitster.g>
 <xmqqsexk1s43.fsf@gitster.g>
 <Zmg-jl83UA0P2Dnk@tanuki>
 <xmqqtthzwfnz.fsf@gitster.g>
 <ZmknNDRnYGCeqAoQ@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wpONmVJrqYhKxhkJ"
Content-Disposition: inline
In-Reply-To: <ZmknNDRnYGCeqAoQ@tanuki>


--wpONmVJrqYhKxhkJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 06:42:28AM +0200, Patrick Steinhardt wrote:
> On Tue, Jun 11, 2024 at 10:30:24AM -0700, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> > > But now that I see the full picture of this with different compiler
> > > options I have to agree that this is not really worth it. Especially =
not
> > > given that Coverity is able to detect such cases, even though that on=
ly
> > > happens retroactively after a topic has landed.
> > >
> > > Let's drop this experiment.
> >=20
> > OK, but let's keep the CFLAGS_APPEND one ;-)
>=20
> Sure, let's do that. I assume you'll just cherry-pick that single
> commit?

Ah, just spotted that you already did. Thanks!

Patrick

--wpONmVJrqYhKxhkJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZpJ9EACgkQVbJhu7ck
PpT/8A/9GCQn6iizV/ksb877P++jvYNxA1rz1n8w/+PYHxX7IkOodfwnK8nNI/Gx
3JMoPUPU3RgElc6emklNGdZwYTTyuJdJrk4zocWnbmWkQuXZV3vSU01mdiMQHdaz
ciPKoyF+o8xuXPdtH07G+wVdtbyXF+0v6us//qyeW10pgIwbpiekv3DD+k55LLK0
2jt/g9gUpEIrYfqoI6iETXe39jgRdqK1TcOam961yjY9a9fj5JY+4qPWXU+GxZoz
LtAWEjKLt7gTfTac9yt1p+31z2h2YFujyir3ohFDCFpahQ+l8VpJL5wP2e2M9hg4
atF61b6tHwdKgcdYs7Am1bpunLIZQwyT3XuYd4BvpPk7k5YZ2HG4tI42JfhonDkX
KHlWMVUWO9PAxrTMh/bARjgnKv3wKBnwriqHNtP7KwhqMaT8LvkDF5x1zjoE/O2y
LG3WoWnNQvA+QGSj3ussfjYzVhW8BzJtZk8K5Hx+ctiictXXeFJaGwycWXVp7Ane
Cj7XA3zUyEKgRIB/HjtHkdTV8Vu1LVZXcfTfDTcSN42gDs4nVTeFtp87hUkbvNkh
hBUAGEoTfCY8oAloyteR5oJ4OyQNPjG2pY7+ji0Y5qkQ05obg6UBoDXRe+cJND7w
Zsh35AMJEY7btw4sKOTSfP+9dQ592xkzX1yZ5Zk6FPk43V/nQ8o=
=hc5q
-----END PGP SIGNATURE-----

--wpONmVJrqYhKxhkJ--

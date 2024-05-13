Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1853E146D44
	for <git@vger.kernel.org>; Mon, 13 May 2024 07:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715586944; cv=none; b=TX8TtnAqnFXKLil5W22BJ3G0QZqxkqE0eB9jIt8RJwi5xysOLLAKSuVvHkmIxh6GCTbmdHermkbnFxjZCJjQNCfp121Wr1wi4IgJu72O/mtSa9f4wyebiNKy+tyB6aycnTjz5vLgM978UKgCBnlekOCqw9QVGRd1EAO2zEtBmqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715586944; c=relaxed/simple;
	bh=x3XbekC4eSox2zBhGRwW1cMuxnr3JP78pRA1GfTd+ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3CH7EnQG2xePbb2aXOUJAQO3UL1wpiXfCZSFYItGyx9DrA0fUMh9oFOv5+uQ1ErhcUEnRcE1FwuYEXg6uB98PIOD7uKnotXuKcUHA9Ciqx7I4LOYSr0jqK9vBmntIaToego0CvDq9w6oOGs5uypEUOxkj1Fi0nJzeu1Ucwkqvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DUi/XVjC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WHOeWpZk; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DUi/XVjC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WHOeWpZk"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 12E74180013F;
	Mon, 13 May 2024 03:55:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 13 May 2024 03:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715586940; x=1715673340; bh=TVLEjcKrsZ
	PdvQMH834GHC3AixQ5W/oiVmZ454Du130=; b=DUi/XVjCYMq/+gSTuq4eMRPSSG
	Pdzho6zhdKNtwfBSGtnCdY77be+z3eVCWjHkkdGM59yKL7z5SLGyf+6zQdyVlqYg
	FAnrft6MifYEENTg6zi3GpMg92gIczcSTAO+lyKAdly0fxmvlNH2NGWc+MI9teQR
	I0aQpyfDyF1XkP8G4oTowOLrjOfhKK03keyE1rUbyIOIzgyBm41DodBxkhF/3cGW
	VXO8tnHZtCaDakljZ/vyzOvjMvHO3WzqXUxEQ2VQykG2cvsnscBKX05aleouAp+2
	cCBPYLdCgw3udWQ5uyRlOMUCQceSUGlAGymfkMeEGt+pDv6XTSe010XfHR5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715586940; x=1715673340; bh=TVLEjcKrsZPdvQMH834GHC3AixQ5
	W/oiVmZ454Du130=; b=WHOeWpZkUvKHLwvV971MTYtbqcvGzGnhE53sh4v4b6ty
	Dqhsi4W01l43tr++T2ZQ2SoewYOuIvrX2xQ4jZAROwMmKAno75qalpKWvbPgtv6Y
	yB8DPYDiAMKLNby+rO7bdM/Hc7dq1UrecmSIQp5epcyantBgnMsJ1EWImgvvCUNk
	4qpE9k3b/fqAKH8VOUdkkcVYtuZisnp3oY5CYlXF5SNVrUnIcf3EezBeI4WLsixz
	QDf4aVJVzYNleyAF15IV0q3zKcOENbBAmf3smJwyH3UjHpjiDUqm1ypsV7eYjK2c
	tZUQBSMPcKg0sdje36AachD+y3fN6OzpshEzJfagcg==
X-ME-Sender: <xms:fMdBZo3UQ10bkJJL4XEF4yQuiTX_1HTI4ei-zSlSVNztw2gJ7GLAQQ>
    <xme:fMdBZjFKyiY-RI6Lz0_-mLcNN1PFTQherjTMUxQjF6w6X7gXp_q1GWbWxtLe2pHc_
    522Vi9YXhL8OW4W3A>
X-ME-Received: <xmr:fMdBZg71VR3YcP2igxPIo_aa4CGNPAYvf9n-nprYGAs-IqB4OGlNtZmUggKx5GW9UcSspcb9H7CsKaZW86o4VJNfAuVFoY2hpw0LTKdZ85qJ9-M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegfedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnheptdeiteevvedukeekheeiueevtdeigf
    fgtefhkeelgeevtdejueelleffteeuieeunecuffhomhgrihhnpehpkhhsrdhimhenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:fMdBZh1Xjwk4w8B8lcGzv1UdPI4zVfobVd2_94jmYBK8K2jN5Yj60Q>
    <xmx:fMdBZrHpS4sZ2jXM23Ok5X717-ij89BZ6yRK56af7DtSjR1WC6ocTQ>
    <xmx:fMdBZq8iWvFjaODRcFdfU2iUCT0eDxvT_w112z0rqNTKoZL0UG0x0g>
    <xmx:fMdBZgmQe-w4y2EpKH87mMR01yx_moPWC6MZImPwI1Tc9h6Z-9OGdQ>
    <xmx:fMdBZgQcTo2HSRJcsQAmVJ7KNr1A-0G261x8KkWiTRPTPATtnuOKVpjg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 03:55:39 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2c3460fc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 07:55:20 +0000 (UTC)
Date: Mon, 13 May 2024 09:55:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2024, #05; Sat, 11)
Message-ID: <ZkHHebHbhGtN0OLr@tanuki>
References: <xmqqy18ghqqh.fsf@gitster.g>
 <ZkGp9TqxO8Y5_kM_@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qHjZYbrSV48bhxau"
Content-Disposition: inline
In-Reply-To: <ZkGp9TqxO8Y5_kM_@tanuki>


--qHjZYbrSV48bhxau
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 07:49:41AM +0200, Patrick Steinhardt wrote:
> On Sat, May 11, 2024 at 04:29:42PM -0700, Junio C Hamano wrote:
[snip]
> > * ps/reftable-write-options (2024-05-10) 11 commits
> >  - refs/reftable: allow configuring geometric factor
> >  - reftable: make the compaction factor configurable
> >  - refs/reftable: allow disabling writing the object index
> >  - refs/reftable: allow configuring restart interval
> >  - reftable: use `uint16_t` to track restart interval
> >  - refs/reftable: allow configuring block size
> >  - reftable/dump: support dumping a table's block structure
> >  - reftable/writer: improve error when passed an invalid block size
> >  - reftable/writer: drop static variable used to initialize strbuf
> >  - reftable: consistently pass write opts as value
> >  - reftable: consistently refer to `reftable_write_options` as `opts`
> >=20
> >  The knobs to tweak how reftable files are written have been made
> >  available as configuration variables.
> >=20
> >  Will merge to 'next'?
> >  source: <cover.1715336797.git.ps@pks.im>
>=20
> This one is ready from my point of view.

Ah, I only just now read your comments. I think overall this version is
good enough to land, but I also agree with your comments. I'll send a v2
in a bit.

Patrick

--qHjZYbrSV48bhxau
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZBx3gACgkQVbJhu7ck
PpRSrQ/+KrFIqAS6m2Ljq7N2k4jurXJb4qGwLULzLP6bUAKONV0iHQoI9t5WJ61f
6YRIpIDfe66jw5yMWag4DHeg0fO3X/cAR77jbXZFvI0Q0c72ZsfQ79djXpZq525G
bvde/0GijLGcRtx/TUDy3oLeoz007V7CgEEI5FbmkAdoFrRgXNAO7IAAe6g3jn3n
JEp1zW+06LU/pa6aNYWUZebmUtQo2gvFZfgM2fIIkY5AR5apDcooY/veNjMFBY+t
KYKkmMQl25zNreP2TkeNmzIzYJb537ancxTUftEblDXQ+xwC/u4hYfpVAavjLWbY
mIm8qvvZUue/uW6XcUgtaxn62Zo+nmw5vipV2Vlfh8nDOML2UNbxxIlgMepM9aQ/
A4UMXRXslCbDfueZlhWBVnGRnj00gmipCD2qoaY8lcC0VVEkNT/fGj/rzd0y8mKz
U9HDsrsLCwS/Ifjfsf8YWFIQUXAyIKDq8inHM6hsb+8aKRKmBIcArMD1RZ/Si8A2
9ZtUN0alQCu3uQ1ToCk/Z/cuyGaah4hR8jQZYxUSeywN0hkuBZPoVtHzsrDss5Qm
Ax6gG5hxDiJL8asL20TdQ5WJ5lB66cp0fROJ7VdvK5AdyACcZvMv8l8DdoZ7kWWM
KQKxYan1Etb5fcY7QqIUuOTUfl+MiZPHLY8UnRHLwiE0OAbZ5K4=
=xx4Q
-----END PGP SIGNATURE-----

--qHjZYbrSV48bhxau--

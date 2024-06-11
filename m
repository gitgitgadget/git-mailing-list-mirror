Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64134173340
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 08:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718093544; cv=none; b=AsoLy4ktBjQd+I99Mvpyaa3XNsTfiAUmR9JI7j/F8MPkW8/L+i6XmUNhYHZymdLFaXeF755eqUEC2HHgO4Vh9Cjcv0r55YxT6C4pCFdxrYkF40lwogOBYPIPA0e//kCs2MEFyCaan8I7ZmV5JSpglnjI8uPHkHOfXV/guG7fM6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718093544; c=relaxed/simple;
	bh=5zFYPFJHJnhPENTbolfZYZAS7qEfji+fq4gR59MIjlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpRK0oqu0ICY5DnmU/2Vk/6/b+lpqae/Et61rq9ot5OJJqJ22effOLzzaTvBLZjkVjIIrIfIFZW8qwUhqitJstbMsPxTa6TcTZhIbcLmRTGfG6YMOz4q29gELL5rPIm0Qoi6EbEfMNyFKzAxajPtOC5ouyeRtqAqmwQ6/9wozR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WSOcl6DD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=quyJLuYN; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WSOcl6DD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="quyJLuYN"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 62D8418000B3;
	Tue, 11 Jun 2024 04:12:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 11 Jun 2024 04:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718093541; x=1718179941; bh=ezuZ8adNtu
	zrgmLmJ97N8QsZZog8LxZ1iBOV3jxdQqo=; b=WSOcl6DD59Us++SdU9XXx23bLo
	NlYMXKiL2ImQUhse5AJhRNjGn9LzOQWUum6PbZRoMiQZG+VW5nTACA2D3fEamJci
	nPCgv0MXuL79+rV3kFrU1nroSrrwM0cpeyolGU052JMWlXWX0L8ka2D6Oruzzajn
	S5OfMMVeRZ5h6dz9YvhIsjScGzC8oDQSXJDf3n56qKrZhJFPMZ4znSpjIKS0pPbI
	AskQrAO9MpYSMk36H6C7xWYplDbv6odDcCWoSUopPPgC2ytd/ChONq7ZIjjf8oGY
	pc/tr1Oi+g4tlxX6ZYsqfmnSroY4705Mt+kEAv2rf1KoBnI2hAwNq3p/Xq7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718093541; x=1718179941; bh=ezuZ8adNtuzrgmLmJ97N8QsZZog8
	LxZ1iBOV3jxdQqo=; b=quyJLuYNSXSXdzhyu6qDCZwU2auCS7+JZzzfHRE14usr
	7w0CXxJuIZWy+QZ+g74+00uhIdDd0PIj6WqPXEz2Pycug5k3XuxlHnVEdYM8yK2M
	ssNqM/9H/zRZN/IqVHRpaLPkhgMVpzxTzGQ86NGZG6lWzyqMXZwlPWfyrap11P64
	NU7G9P13E2CNCoNXrKIewOYqcU/z+08W5F7JRu3C0BEhJtJ4uVZRgqq3XhNHFhIW
	NJ6sg5QUFK2e7AU8tUQ60pw9NAv0DqkK3QrV1PnzdOx/rEpJ5uZ0oEr5S2dOFgkk
	MdBUuvPKARsS0S5iADM/mckYHyn3aTBmpMGpZ6ZKLA==
X-ME-Sender: <xms:5AZoZkyiIXmWEnYYr2yaNDN0AiBMSUCczzrXcaLA6TIK46d6ZA4-Qg>
    <xme:5AZoZoR-KJmPV7mQiPWDyWloc1U7ICy-hWeNulO2fOVDpVukAy6dK2-TDHa-jB3ke
    f2rWi9W6k7ZWBz6PQ>
X-ME-Received: <xmr:5AZoZmXO-Ki-uTRbQnqtzcKYmlkM8G-FfcZFirB_AQwAzl8vq3dV3gAuT5uiCIEH14ojwdqFVs6sgFpcue5OZKsZjjybKyh-f0duiQM_DVJ_v6lQoSK1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvdcutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekleduvd
    effeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:5AZoZigLXpt3UpGOGvmWOfRXdjTprA4lY6AHD9lCx3M16ZtcAtLtyg>
    <xmx:5AZoZmB0NNpM3Kz8-TdEDP5fNfswQJh3TOiyHtiH8HZ0PBCOmf-k0Q>
    <xmx:5AZoZjJpShKmhltKR5upx30L5xUaNwICCZzp1onVwqf1DEuJNxtBBQ>
    <xmx:5AZoZtBH52xbdxXP_oYFpNSpKt1nWEugHv96hn59bkILmMPKOrIT6Q>
    <xmx:5QZoZt4TaFAqYnkrQk4G3y1ikb3ef7V6iU-C_YxCSgXY4v_5kUsACbhi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 04:12:19 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id daebc56a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Jun 2024 08:12:07 +0000 (UTC)
Date: Tue, 11 Jun 2024 10:12:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH] pack-bitmap.c: avoid uninitialized `pack_int_id` during
 reuse
Message-ID: <ZmgG3nCmprSN-mkh@tanuki>
References: <4aceb9233ed24fb1e1a324a77b665eea2cf22b39.1717946847.git.me@ttaylorr.com>
 <ZmaVYnmgyAr0vapK@tanuki>
 <ZmcUclCErqwyad9D@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f+WTjYE5/gv2LhWn"
Content-Disposition: inline
In-Reply-To: <ZmcUclCErqwyad9D@nand.local>


--f+WTjYE5/gv2LhWn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 10:57:54AM -0400, Taylor Blau wrote:
> On Mon, Jun 10, 2024 at 07:55:46AM +0200, Patrick Steinhardt wrote:
> > On Sun, Jun 09, 2024 at 11:27:35AM -0400, Taylor Blau wrote:
> > > In 795006fff4 (pack-bitmap: gracefully handle missing BTMP chunks,
> > > 2024-04-15), we refactored the reuse_partial_packfile_from_bitmap()
> > > function and stopped assigning the pack_int_id field when reusing only
> > > the MIDX's preferred pack. This results in an uninitialized read down=
 in
> > > try_partial_reuse() like so:
> >
> > I feel like I'm blind, but I cannot see how the patch changed what we do
> > with `pack_int_id`. It's not mentioned a single time in the diff, so how
> > did it have the effect of not setting it anymore?
>=20
> It's because prior to 795006fff4, we handled reusing a single pack from
> a MIDX differently than in the post-image of that commit. Prior to
> 795006fff4, the loop looked like:
>=20
>     if (bitmap_is_midx(bitmap_git)) {
>             for (i =3D 0; i < bitmap_git->midx->num_packs; i++) {
>                     struct bitmapped_pack pack;
>                     if (nth_bitmapped_pack(r, bitmap_git->midx, &pack, i)=
 < 0) {
>                           /* ... */
>                           return;
>                     }
>                     if (!pack.bitmap_nr)
>                           continue;
>                     if (!multi_pack_reuse && pack.bitmap_pos)
>                           continue;
>=20
>                     ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
>                     memcpy(&packs[packs_nr++], &pack, sizeof(pack));
>             }
>     }
>=20
> Since nth_bitmapped_pack() fills out the pack_int_id field, we got it
> automatically since we just memcpy()'d the result of
> nth_bitmapped_pack() into our array.
>=20
> In the single pack bitmap case, we don't need to initialize the
> pack_int_id field because we never read it, hence the lack of MSan
> failures in that mode.
>=20
> But since 795006fff4 combined these two single pack cases (that is,
> single-pack bitmaps, and reusing only a single pack out of a MIDX
> bitmap) into one, 795006fff4 neglected to initialize the pack_int_id
> field, causing this issue.

Makes sense, thanks for the explanation!

Patrick

--f+WTjYE5/gv2LhWn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoBt0ACgkQVbJhu7ck
PpSMzg//To4hbWiUlvfDGY+59xpTqv/WX9jR80FwtMIXjJh4Vlwmqpt71nElWKWq
vRIWLUfU3ZLOOS6Wv2p57DvHJGCNx1ARy0+GqJFY0SdD+M2HZMAfWU2QXqHxc4bz
rnJ8r9/ut1/KROQkLssIRWoGMm0WODPsU4GP/LGmwT+FaNq7a0qxfd8msCWLI860
/GT/HwYsavXvNvIY84TVcqg0J6RgJXeNVcK0O/cbh2L1LBt/SoEGVZveMZ1AB7R5
IkpoJNZCotLgGEvKzXHa2gDQT57/ocZakKp6e5geL4slyxn1RSv7O7bKCNgcafpf
LC/CMIG0dWEvT9sDMd1BR9+O5TGnDuVVm2iWDFHd4ltJmKCZkGyjo1Nettiznz6M
4hIbKGxpKNB+VhvE09iPSE8zD80Nk4B+xBjoJrQN0oIUKmfyP+nIT5b9eMn/PGIQ
dOjKIhKuSdbSlPjkV44Op/gDfZskwzpA1cIbh3nmff2THH9TOD9FJ+6zzQSgWySn
imfKgWQWoll2MsCbljFP9icHNuY2Qpr94QOo9knZ2l72qAntGV06nSbXupHzTftQ
f0VoxK8KUJCinKSMGcLIg16bcmW1Ff/2rnOlfj9SigcJQLOw0nRlijW/2FCh+GLR
2zGcjn4y4RgnM0V7up1w9FiyD/i2xDfzQvsuzZPo/bBjbN8k31U=
=qN8v
-----END PGP SIGNATURE-----

--f+WTjYE5/gv2LhWn--

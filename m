Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB79E39FD3
	for <git@vger.kernel.org>; Wed, 15 May 2024 04:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715748000; cv=none; b=eU4KZA89/CvfQQ9VFOXTDP+ma8RUgAccBJa+wp4QEk5gGg08TYDOaYT/ejWbhYy4oQXjpYaPvFZx2xYVzV7H5c01N0sSrs/Jc9ndWn0ubsgJVOarJQRYgNcnFNI35CP7uZv0TcxCZWK/h3Tzjv344Nv0M+8FDeaiqVF5upEbnYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715748000; c=relaxed/simple;
	bh=zXRNNlpgFTsD8DSzhADiOcqky8AdxTX4OYHwysvxG7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNLIVd9sjhAYzNC5kThK3Gz0R97aRYNeXIrIh815r8eDbUfQpQ6ROek/8TLCYY6CDdqt1es9vcmJ9fbhOKqiHNZkqmUKb7aMutc/45+Xg0eUcfAqKfCRCIpupWDmBKTXZ2pDLw3R62j/axVXYirOknwA5OdrjW59vAGQ86IompU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Sy11uoP2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XPQ0mOo0; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Sy11uoP2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XPQ0mOo0"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id C9A6A13814D8;
	Wed, 15 May 2024 00:39:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 15 May 2024 00:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715747997; x=1715834397; bh=zXRNNlpgFT
	sD8DSzhADiOcqky8AdxTX4OYHwysvxG7c=; b=Sy11uoP2FPyhjyFX2bzSZFOe3n
	nZHYJDWB314sS2jVBEYftzxQJ/GyLD90khBfG0dVYe4Bp5qsVneI1hY50d7kgSjn
	oTLW+OONrIaaAWuX1Vi33RbsV3H+2nZu+OzztulY6zv3ylmg0sOW1TE/EnHX7kB+
	2zvWz1FRiJr3qnbkQ0Wxo8qX/o9S3pqYivl8/yffJxTPy4r0Q8AN7S+THGuvVf3k
	PpfAoeAG5uA067MY1VfPOO5iU+IOWhP1XuINcAHBWsEMu9crRGp7OBI6ItcZljFP
	lrgr38gzY+kY8MyAkLvP2jn5uTolGZoSNcrjf7Zfiu0rHDL0gGWkoWASSY5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715747997; x=1715834397; bh=zXRNNlpgFTsD8DSzhADiOcqky8Ad
	xTX4OYHwysvxG7c=; b=XPQ0mOo0V7QCRMVjNz5LLUeRtjfGf0uPMYsKbkeH5to0
	fmWVI+O5yXonJVBxgQ+4sN2l8+bnIzx+mW22usnW0xJzbVuJvzwmGqfWnhXlSC5d
	NJ9Chd2YYHx+xlpKDGxO9eYB8qbVgwlqHch1CgkZ975p4UZKwfFypK8t0C4zj2zP
	6utjDbzp+qMeB0cK5A2/brRkUh8Bs0dWZobNdOBGRQ6eiIX5VeqFjlB7OD0wtbjH
	2umwZoBGExZa8vTSBzxT2H4bUYqPyVmC5P2X/4jYQ7h2y8ZwnaFOOOa6QWlwNNsr
	dED6zSA2+pdUd1JGL3QxCqLlThnPYarRX5rhHxvdpg==
X-ME-Sender: <xms:nTxEZoOLhFcUVVW5cyqxbfxVIqqVd710HTdxqtlZ1zw98NlKMyPHwQ>
    <xme:nTxEZu80gde8S0pP1A1bnM7CFmZsI0i-MBdKV0SEIf4EuGAbcjknhV9lCMBfq6tbj
    uUVZ-zBQXKArPkNaQ>
X-ME-Received: <xmr:nTxEZvSbRt1fw3_VAiRFOGsaJhnY-Bb7y1i4GQwcJinv0Vv_M-PkqBnEkP_7O-MpwX09B__TkNVJKq6QsAQC_c0VTR2U-52E2QCoO2_mi4Wp1CX5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:nTxEZgsLAUn3T5GVHy-9FHqklpcxleEC8467ydRi-K5WzitUdBHBZA>
    <xmx:nTxEZgdaxfnV9_QobXamSkDtl8dnWS_5bgeF6OD8_BCp5JwwJKI9Gw>
    <xmx:nTxEZk07RDlbtSq7Bel5H3TZ00vji3c_LaUYeCHELiZdNdONsS-JXQ>
    <xmx:nTxEZk__7ZJGMw8mDUH3MN22YgJSpJbPptTf5GrMDZqtBr2vXMjgmg>
    <xmx:nTxEZuvY7UgiiH9-Q5RGbIKVl1DxCrN4bTavC-vlS_PXM-71uOGju1gH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 00:39:56 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f9bb8e36 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 04:39:33 +0000 (UTC)
Date: Wed, 15 May 2024 06:39:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v3 07/10] refs: root refs can be symbolic refs
Message-ID: <ZkQ8mDrBB2eGg8Ns@tanuki>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1714637671.git.ps@pks.im>
 <92a71222e1067ca4ce9ecaaa555d78d0cce0d9d0.1714637671.git.ps@pks.im>
 <20240503181339.GH3631237@coredump.intra.peff.net>
 <ZkQ3EiL1OY10Y2JP@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LpNU2wfjPz6RkV/F"
Content-Disposition: inline
In-Reply-To: <ZkQ3EiL1OY10Y2JP@tanuki>


--LpNU2wfjPz6RkV/F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 06:16:18AM +0200, Patrick Steinhardt wrote:
> On Fri, May 03, 2024 at 02:13:39PM -0400, Jeff King wrote:
> > On Thu, May 02, 2024 at 10:17:42AM +0200, Patrick Steinhardt wrote:
[snip]
> > And arguably is_pseudoref_syntax() should be taking into account the
> > "_HEAD" restriction and special names anyway. It is a bit weird that
> > even if we tighten up the refname checking to use is_pseudoref_syntax(),
> > you'd still be able to "git update-ref FOO" but then not see it as a
> > root ref!
>=20
> True, as well. I'm less comfortable with doing that change in this
> series though as it does impose a major restriction that did not exist
> previously. We probably want some escape hatches so that it would still
> be possible to modify those refs when really required, for example to
> delete such broken refs.
>=20
> I would thus like to defer this to a follow up patch series, if you
> don't mind.

Arguably, we don't need `is_pseudoref_syntax()` (which is being renamed
to `is_root_ref_syntax()`) at all anymore after this series lands
because it can be neatly rolled into `is_root_ref()`. The only caller,
`is_current_worktree_ref()`, should really call `is_roof_ref()` and not
`is_root_ref_syntax()`.

But again, I'll defer this to a follow-up patch series.

Patrick

--LpNU2wfjPz6RkV/F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZEPJcACgkQVbJhu7ck
PpTreA//cN/YYda1LhWm/rSz/UhGgqL+JATVzM6REtEKcHwYnf4PxLUeQWraI28x
CnLo4eO9AlkUtPYS8brR0ZE9o/CU7RnxR08JC/Uk6+iWyN1PZsWcEKT6j3f2p4bt
lmn5upmEze7x9b9TlY8b09ixS6PhcbbSnyiQM531/7rdTMYUcruSmYKc2kfWXDCv
vZFnHGhkyqHL2DlDCrKfTTCFoifAAX/WmxQ/4Ow0IGL7jfU5RH6/4HDJlWO6dPMP
jQWeycI4dl3/fs4Et0qTWpUu0w6KReD0UzUM7WB3n9GisAa59X9B4Vn0oBSXUBN9
NKqP4VVr7MZWeX47vhAWk9VQ03T3RfwA5wBMVjl9XYXv82Fu0tbv91xH1Hx25OSg
AqEEhL1J0xjnt3mcq3mfK5xYqmCmoRLSlDXt+c/phXAhbV4JxBoErDdg89iVgthB
QY4bfiCxme/NtP3XCu6aICsn+75xjUqBDrk3SxMdPh/sQwexjHgpd2L5OTKPgaAK
daxEN52fRNw4dA26sReK/CZPH41getbVKQlgrthmkb09aZrYi1SZ1ONOcbVgPJEH
uunnv8V+ZxRnNKFyqRTFBNk4aWFMhpKNPUhm5OJtiVQ9xzjlX9LE4AOEvJkI8M6B
GGN1RiUaeP8SCbGC4z0LTPMd2E0LhIRxF1UMy0Iwuni2jXKSC2g=
=KLHz
-----END PGP SIGNATURE-----

--LpNU2wfjPz6RkV/F--

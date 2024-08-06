Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B91C1779AB
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 06:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722925251; cv=none; b=NmsYF+QBTlIRgpZD1mQkvRtVEEs9SHJ937BnfrxkZDeAAjahQ9vICsaI6QwKPG9/S5P89H2pg0cEeSQfNoGgjZwZpTOvAP9eyfP6Yua/sg4GpBtdRIkP9k5AU19bieCL1VfOBmfpRiyjm7AYBSiE19xJEWFzw5Afm42rAcpiQWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722925251; c=relaxed/simple;
	bh=CyazuUuoEyYfnkAa7zYSNDIbskfFxpMSsoPyFUmB8WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kaQne4tg5JlKXQjq22GzTbxXMni0ADSc826PiGUIqbjaYjYW9YjFdIuQNqAZHnmBD8E62hkdPN9dKvzn+St1l5WKZbLKK9JIcQLLa/UeVcB7jlo3pvqHjaD+qKajwcTTzGxxtNXidQIGiKH1wTz2EDsrO/mJD4+ZFLQr2rJTSCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LiDd82RK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BLSOfKhy; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LiDd82RK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BLSOfKhy"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 72B81138FC56;
	Tue,  6 Aug 2024 02:20:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 06 Aug 2024 02:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722925248; x=1723011648; bh=OmT1kGfAiV
	ZzfqTxdw3Ev57G5IZciDJbfi5zschQIm4=; b=LiDd82RKqA/zU+UN4LRcTK4/mR
	kQmo1vIOGJf+ut4jktkspE82BxNoLkEZsss9Ud064Su5YR8wsD4UDsEkFQXdrHcl
	whSeTOifjnBkFp8Aagut97hWPx/fI/fcAdgucKMbRhhL1NWkrM3gYtsJZ5JyBEGg
	UhSVMnxRTQCoHiZlEfcb1+VqFuh9NUw0qJMN8ufCb25A5mqUt/M1N2tQOs2aExN9
	0qaRKkSUFeo+TThsbIQTd7bObNK9MO1gYYwXgksS0Lw9yOaR4uF361yG8MaO504e
	i38AHQtuN7M2e4Ox74dow7p05l/xDnMp33ByACCeHdzshpZ+pQUNKHy2V0fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722925248; x=1723011648; bh=OmT1kGfAiVZzfqTxdw3Ev57G5IZc
	iDJbfi5zschQIm4=; b=BLSOfKhy1VfgZMFR27TsifR/EVvI+Ybp6qn6376Z5Z56
	ooaXKL9ScMDNCzhjAqHbOxcp+f0CtoNVM+HUiioMahDCFOyJfYRrdzHkYl/XuFz+
	ovCr5ibdM14Bphyr7I/R2Q9v8mMwFLagkHuLm/IrGrm8XKyxm1/VHBMkhVqOgy5M
	viAZrhhlEeSN/WfW8w2wodbf9sl1Kn4AYyL0/FNcBRP1lE23G4Z3dcnFTfm4cwwI
	If+6YHs/Uv8RAwCg2Azq4Ijr4os39S2bp8xHReVFGIP5Suu7ccPnx/mWTrSXn4fc
	Zp7pbRFGx8x/uBYGMZQLhWJfqnenoXBbSCeKjzEjXw==
X-ME-Sender: <xms:wMCxZiipi8CNhQNLi2nLssdqnO9fpPLuf6CkXqvOl0-B0uCrOkkuUA>
    <xme:wMCxZjASR17IkYcOJhs0GcgAGKfVVkUBr1acRhBAk33RxppdpG4zYlgdl4txY9saY
    _5TdojaRyNhXAkSJg>
X-ME-Received: <xmr:wMCxZqE2Olox4q-k0oZqRoQX8P2oqQR21MK_x6DBOxZTiXV5VIoVy2xOP0xOPmUyAilzBFgCD0uctyXgDPeJ0tOmKQxqWfNxWosRfg1LcmlT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeejgddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:wMCxZrRULfcjKzeCtHSLYiz_eRcjpU1R_BsiWrsYaQZ8s2-MwFtsLA>
    <xmx:wMCxZvyMmmL_F8ARAZ-ZMRz-dmCgLtC6H1J538UA00wzHD9elm-LCg>
    <xmx:wMCxZp4Lr9cvCP3Dopewm5d5BLFPF98wd35vccu42aW-UHEMvtm4cg>
    <xmx:wMCxZsx3PUZT4LqGDgXY8mrsFsbSz8nbZgKtq7Jjd8yrkEZHBjNsEw>
    <xmx:wMCxZhu0wZR8jEUvoVGkU1Z4diFJ-2IWcT9hdWAmwc1yac4WGkNE5iFx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Aug 2024 02:20:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d41aad5c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Aug 2024 06:20:43 +0000 (UTC)
Date: Tue, 6 Aug 2024 08:20:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Sven Strickroth via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Sven Strickroth <email@cs-ware.de>
Subject: Re: [PATCH] repository: prevent memory leak when releasing ref stores
Message-ID: <ZrHAu0wfipR6CShS@tanuki>
References: <pull.1758.git.git.1722855364436.gitgitgadget@gmail.com>
 <xmqq34nj3pez.fsf@gitster.g>
 <xmqqed723mth.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AhqJOuvI9YaMoiGX"
Content-Disposition: inline
In-Reply-To: <xmqqed723mth.fsf@gitster.g>


--AhqJOuvI9YaMoiGX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 05, 2024 at 10:24:10AM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > However, I am fuzzy on the existing uses in the backend
> > implementation.  For example:
> >
> >         static void files_ref_store_release(struct ref_store *ref_store)
> >         {
> >                 struct files_ref_store *refs =3D files_downcast(ref_sto=
re, 0, "release");
> >                 free_ref_cache(refs->loose);
> >                 free(refs->gitcommondir);
> >                 ref_store_release(refs->packed_ref_store);
> >         }
> >
> > The packed-ref-store is "released" here, as part of "releasing" the
> > files-ref-store that uses it as a fallback backend.  The caller of
> > files_ref_store_release() is refs.c:ref_store_release()
> >
> >         void ref_store_release(struct ref_store *ref_store)
> >         {
> >                 ref_store->be->release(ref_store);
> >                 free(ref_store->gitdir);
> >         }
> >
> > So if you have a files based ref store, when you are done you'd be
> > calling ref_store_release() on it, releasing the resources held by
> > the files_ref_store structure, but I do not know who frees the
> > packed_ref_store allocated by files_ref_store_init().  Perhaps it is
> > already leaking?  If that is the case then an API update like I
> > suggested above would make even more sense to make it less likely
> > for such a leak to be added to the system in the future, I suspect.
>=20
> Ahh, that was the leak that you plugged in a separate patch.
>=20
> So it does point us in the other direction to redefine _release with
> a different behaviour that releases the resource held by the
> structure, and frees the structure itself.
>=20
> Something along the following line (caution: totally untested) that
> allows your two patches to become empty, and also allows a few
> callers to lose their existing explicit free()s immediately after
> they call _release(), perhaps?

I don't really know whether it's worth the churn, but if somebody wants
to pull through with this I'm game :) But: if we are going to do this,
we should rename the function to be called `ref_store_free()` instead of
`ref_store_release()` according to our recent coding style update :)

> If this were to become a real patch, I think debug backend should
> learn to use the same _downcast() to become more like the real ones
> before it happens in a preliminary clean-up patch.

That certainly wouldn't hurt, yeah.

Patrick

--AhqJOuvI9YaMoiGX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaxwLoACgkQVbJhu7ck
PpQMXA/9GoFfgGCFKyIeOciAsh+tnhw4CKwkCSgeSWcJmRC6Q4IqVuU8c4ykV/TG
kDCxs6tV67W+ublxodPD8+oNwMnj+PpfYdym/F9Lo3m18UF+UdTMkJc2Ew2lzKdf
JEDJasvxO+K2aqfoVeb2vv1Ifyqx0v5sToKvktBL0JCzoh6OXE6AvS09hf21aqbm
k6I8mGx2POspc/BQZSS/JZbH0SOhbXswq24tXlclhLqg2CknmSVLowSGZDxhTsqZ
AyMGEKfZCg6gMirNeM6UL4NhsbY4Sk7k8ewJ6plZmX2t9YlcJXDOSlGnc0LIbIiv
d80oQVxAMoTwo0ypL1mzfpyo5vDxjlor7BIY/us3y9AjBz7hTc4bY0CrrLz7v8yc
AXU9yMkEcGDjkDztijBgIqKrhhTK3cQGLlsHoRRuCIeEUUq2cQi3vm8RIKfFoWri
dbYkbdTwr/AzD9B0JwxfuWOjDDbdp09glfCrVOYwqejRRlSjGw31BZreidnui6+Q
Xf2YFSOPqaNKNzRVr2DviLx4LcV+M4495tZuGssqqAsJ73PR4YIjyPUoET7AgKFT
FHQq4KzaQwT7xqzbnn1UqUUrz7rXXPZCKRylDqIQkopbdhLPGzf6E56dLBXfETNk
obZJH/75BquPSpcpMEQtZ32uOnQU2wSfTXm6Sqkz5k7eN9xx6Ho=
=uMtN
-----END PGP SIGNATURE-----

--AhqJOuvI9YaMoiGX--

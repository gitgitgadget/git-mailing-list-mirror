Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708C939AC3
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 10:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705919767; cv=none; b=CBSbQ7cHr5WpQ0ZotboQ0vbeP+mSHZdqdPYDPB8Di4C368fBVbxGzf2KasKo6MZ1NaqrFHx4as0Q/Vp2d7Z5rs+ObTD0pLdBTy0LK0sBBvaaRfGbCUIJ0Ra1ILRxqbVuguv58rlXoU1RSMBRGyVB1LAAXI9pKAH5UDGlrCXZYeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705919767; c=relaxed/simple;
	bh=KqwJjYdxCx1FjYnSvtuLTL1q/6+qK5n+Mz/5lXKHsoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VONra4yWR118IbsQ6ygtUsfcf+VOpz48pj5vgVpv8fWx1z502LS4v+xYVzCt1rSeZKPsflGT26VNC2gVSWWowfhCeYqFW3SZqvciv0XCbIWwk965Q0bgmOSFM/rSoWZyXJtZ5c+VXaI0xrHnMT3NCAYl7DZZK9CAoO5QAKC1czs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UMx5FghN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mloKIBnH; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UMx5FghN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mloKIBnH"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 5B7D93200A10;
	Mon, 22 Jan 2024 05:36:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 22 Jan 2024 05:36:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705919763; x=1706006163; bh=NOTRBP26Tu
	0VvRaZj9ofrVmIpRIU7GzSImkRUiC+Wwg=; b=UMx5FghNwdZxf/mwnCkjy0ffiT
	CaKxewSdUESMyWQatBCmfRe3j6dcs9h14c4i1S9mnbTUkpAjaoV0QZUrXgViOKrz
	mU7X0NGeqaRPNWgJ7e1FQDEthhIwb56i7LtOcuXwf9X9/XRCBlvhf8dxR2j1k0Qm
	BCEn/k6G7tv1WZSz8Giz9sgjEOifF0vpiFK8euLZiyjwY0o+7UsNaW5x422w5iC+
	EqzZrQxUmum9F74KMSgCzUmKUuWwVAD1DLGTafxNesXSgUKW8THxS9EncEvswXnU
	4A/ZKFV3K9Xe/ArpKTHlS73LNBtuV48+JYTRKxQ+/e4MfYoBYCFXj7kt/Ilg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705919763; x=1706006163; bh=NOTRBP26Tu0VvRaZj9ofrVmIpRIU
	7GzSImkRUiC+Wwg=; b=mloKIBnHq6EfT7nBUIsu8sd5zKm6XsftejVI/71sZflp
	ST2ovKQsoJv+01U/gt3APancOdMnGRMUafZaG/vtogyaViV4ReyJkk5t9PkTkIsD
	1WePOf+8ay2qVCWf80MbHzuuG2pIEqwAs7BBl3GHwK5Qx4dT4d7xy9vETuM5p8Ux
	lcxTgwreYFm6W45Ekj+setB+OqqTr2ME2B1OGTnrjPtkt/JZNoWZ5a67/3MVFlgm
	jr2a1AjBXe1LT6GsbLhWolYozV6l+87p+UMil2BbGf8HyWrAlrbgafPOZjL/4VS0
	BSD5I5fZFMx0iUoREAsrVkhaPeUNIUIccNFshb6XTw==
X-ME-Sender: <xms:E0WuZcVbWY0_qCzUh20_WSoBR2UWXvAVqVgbk6FliBgvbVyZ4YQ0qA>
    <xme:E0WuZQktES9I_Yiw1bn02oOZ_rrxY4xDbnbnayQofL6WhlvZ00tCi3n597lP00Su6
    dkRx6Mt4vpbXqskWg>
X-ME-Received: <xmr:E0WuZQabcsInrr8MG8tashsgJ-3zM3iMCcbCqSiLThElj0YaqB7Z4mx2UWCdZdyNBiNk43QOsvN8xnmC7ayJMR2-eLmwUp6JoEYKJxKHXxfuHt8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekiedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:E0WuZbXRfiS7CMJTzf-sfPN7zmpdIrTtrEsIMFrbp-6Ez4VWEM34uQ>
    <xmx:E0WuZWmsh__fKoJHFbk-IzwzXkYAjDjpb7x1aetMEYf4NbEED8LLCw>
    <xmx:E0WuZQdbXTGhau8Thf-7AELOawRUd-BL0Rs58THRQbqlIk7StVs6bA>
    <xmx:E0WuZdvSOYlnQR9TL4R1X6uNJfAw6RUumYKSXU5K0-FcOmzbS-9XdA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jan 2024 05:36:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f4e0c796 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jan 2024 10:33:00 +0000 (UTC)
Date: Mon, 22 Jan 2024 11:36:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/7] sequencer: clean up pseudo refs with REF_NO_DEREF
Message-ID: <Za5FEJOrUGTm620N@tanuki>
References: <cover.1705659748.git.ps@pks.im>
 <48b95fe954c1dbdd080ce7a0cc871f4850bddeae.1705659748.git.ps@pks.im>
 <xmqqttn9jfta.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="klaHauqbBdLpHq0C"
Content-Disposition: inline
In-Reply-To: <xmqqttn9jfta.fsf@gitster.g>


--klaHauqbBdLpHq0C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 11:14:57AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > When cleaning up the state-tracking pseudorefs CHERRY_PICK_HEAD or
> > REVERT_HEAD we do not set REF_NO_DEREF. In the unlikely case where those
> > refs are a symref we would thus end up deleting the symref targets, and
> > not the symrefs themselves.
> >
> > Harden the code to use REF_NO_DEREF to fix this.
>=20
> This level of attention to detail is very much appreciated.  I
> suspect that this was inspired by the other topic we discussed the
> other day to tighten accesses to {MERGE,CHERRY_PICK,REVERT}_HEAD
> that is done via repo_get_oid() to the one based on read_ref_full()?

At least not directly, no. I was adding new calls to `delete_ref()` and
was reflexively adding REF_NO_DEREF, which made me wonder why the other
cases in the vicinity didn't use it yet. So it's more inspired by the
first patch series that introduced the "special refs" classification,
where I already added ref deletions with `REF_NO_DEREF`.

Patrick

--klaHauqbBdLpHq0C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWuRRAACgkQVbJhu7ck
PpQBeg//TcdbXHKIWV6297dQwB3SE52fib/VhR9SqrfnMIWukszLVtT2wNQYF9lO
ed3DV5B4+TRVoJCg52ljQ9mVE+wWvH65Zx90MbcgLzKg83rUnOHmoDaEZVkBcSPJ
+OBSXiVZfw8TLzRjhA6RqK/k5fkWY4Uez2ORhiNEHMzBZVQcasKRDZr16/wycuiX
1Qn/3Hu/gIBluWCWDsWdsVmxlMTmHB84lvZbOfX7Gy+YcFYI+Qh10R+SoJm66May
BdHesu4HUciLE363t5heNs2PQKK+K9e5PBWkkR0YdPNxrzsBma41YqyKWeS2lg7v
02AQVr7Ti9PtzLEPnMot19p87SWoGkN2HUxIjkurtuEaacUyBVN1B6VY6jkW9tG3
5Jd28yCVt0bRpMt4fecuyHkE+43Q22iyl0e03Xjcs2rVmBUwH/yTGV4y9k9VR3r7
sa3iWLVuhoL0pVjuyHPV64cuy/fhzjcjxoJbCtaLbExu8j5nK/3fyoTIYxbLuVzV
1aRFN+cvpECdAAqO5P08U6uD/D8bfeeHDw9oYFbLIzZR0E3RxwvHuV9nuwV/U93Y
xlWaUYtNMDRkoMl5isuJGtxH8ZBqXmUbtdb4k6bxhqqadeRvOAKUdZ+Gq/X4iB/o
oPuHCsQaRaQs4eCjKGKlSzes79i2oZi6z0MNyAmz81vvlBehq10=
=rgpe
-----END PGP SIGNATURE-----

--klaHauqbBdLpHq0C--

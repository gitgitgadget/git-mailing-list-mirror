Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3E85A79D
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709634010; cv=none; b=qHHPK60K3H8obNBXFZPejCGrj3ai4impuouzAdw3BSjxSifLGCYDf0ROgvt60eGXhaPoajw4Dr/TzGOMasVdqtnVM/jJMNwbBcAzVGYwghPBkdwg3pTXSVVDzdLp/pF1O0bCdVUZH/taOpzYXjKG8Ff3NFRd6oNI1tFVWTonRng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709634010; c=relaxed/simple;
	bh=QGeLk2loiU/xdr+uDASQrAemQomsrWKT2C1Eux00JzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFhsZsZeypWBAzVj0OMXSiz+bwMlmvge1s9KQZQe6WJzeyFeqHNp7/rwY8up3GPM6gagT2F7YdN+52y++12p6ns01YY9sFeQhNraoIL72VQiYKQWk8BxdFMAoyiaTbz0Afo3lQXPCnI1y+uW7KRRfIPebh8IRwexXCnPsXIbu/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Gfv9IJGH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m+hch+Xf; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Gfv9IJGH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m+hch+Xf"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 24AFB3200A08;
	Tue,  5 Mar 2024 05:20:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 05 Mar 2024 05:20:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709634005; x=1709720405; bh=o+17+L/FOz
	ekWBdtdE04kIwVIaQ56G2KOWQkwXnW5d4=; b=Gfv9IJGHJXKkZhi0yj2zaVNiB5
	D1S/Ns4dS5KEv95rxqMwgoFr/uvmh9FLDU3wvMOG9G9u7zWiKpsAUrckF1P+vZoe
	+3HXenZkzkiZLZO+C7yoI0lyCgqfHIBJxhy6BYwa2xmdZtzc79egLF5LJgZq1pVZ
	zUeVg/8yZLccBUU3jGq740VMwAWkemJqdQIN37fbWFcA8Jsyw4QOAutHP0vVgB9S
	wJbB0qCQ+j89+M4MDylrBAK81YpWDNdcvxnCH4VntMi/YrbSVb7MWyC7QSMBx4W4
	L5eJYkdiEXVBIn5x6NdJ5xVYCW8VRf5kmapSMWJ7GWaT5iuEUbBYqBSvo1/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709634005; x=1709720405; bh=o+17+L/FOzekWBdtdE04kIwVIaQ5
	6G2KOWQkwXnW5d4=; b=m+hch+XfEcArEbJH1mPRNKXg7BiUxYCKKf8Cz3DwZv9x
	L9kCJ1jX8qg5M2TYGLTkbhkXaSetWC6mDcM0p1sttmR63hMe+aYZICG50/cC3Au+
	seYsqXVhA5CqFxnfoJ+DpydL741N7ycLEDJpuCNSdyAKdw6HVMb5DS/v5Gb3NgdO
	bd/fFkAxHlmopGkZCc7FmVr9DU4SVGdDLGTy5VklicKoOghvW/CmDtuWj81nSHOE
	LdNLCAoSRfiTkDQl4GR8YA9ZTBvulzF6Esi5soPgOHNK8R0rI25wZEOJt/tA65N+
	nZntT0kzu2O/Z0m4ffkQi93TYgQAS+ZXMt7zZ2V/Pg==
X-ME-Sender: <xms:1fHmZR7WqTXOX11_FNJcvfdFxTmuCJDQ_FThp7xOcnm0MlURq_9OOQ>
    <xme:1fHmZe46TR-vqfPCRxOqKB0N3B7g02ZUMXjycX0ExCrG_ep50bU2Q9h-6YcYFlh6x
    5LU2N7Kg98gpVf0zQ>
X-ME-Received: <xmr:1fHmZYdDnGVRFXLznPKhewQ1CZ4Xn0ZQJ5QFoJoSE4V1x8qnOlou3SFyWb9v55nM4okLBjoxpyODJQVGZ-ZJtzn4l4Rz1HDZ__4Zg5oWRm-Ykns>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnheptdeiteevvedukeekheeiueevtdeigffgte
    fhkeelgeevtdejueelleffteeuieeunecuffhomhgrihhnpehpkhhsrdhimhenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrih
    hm
X-ME-Proxy: <xmx:1fHmZaJ2iz8hl8DTtD0rorHIha4EWWMt7URJ9_A3QvuHk2FdpKtVBQ>
    <xmx:1fHmZVLTknDEKqLNiltOn1qPiC9sdtzWw3kjEiJqZmsDpmbQb0gXgQ>
    <xmx:1fHmZTxC3kR49cJurZgev2Tp9by_qghydyaAu-H3xGze4g1OJBMqiA>
    <xmx:1fHmZTj0aa7qHW8E-8QSQMu4xFkW6P17Cwrx937cf--Zz9XBIl4mQg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Mar 2024 05:20:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 43fbc375 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Mar 2024 10:15:34 +0000 (UTC)
Date: Tue, 5 Mar 2024 11:19:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2024, #01; Mon, 4)
Message-ID: <Zebxz1-6FUqQuwmm@tanuki>
References: <xmqq4jdloc9a.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3X8YyRUFIviMDPYo"
Content-Disposition: inline
In-Reply-To: <xmqq4jdloc9a.fsf@gitster.g>


--3X8YyRUFIviMDPYo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 02:36:33PM -0800, Junio C Hamano wrote:
> * ps/reftable-iteration-perf-part2 (2024-03-04) 13 commits
>  - refs/reftable: precompute prefix length
>  - reftable: allow inlining of a few functions
>  - reftable/record: decode keys in place
>  - reftable/record: reuse refname when copying
>  - reftable/record: reuse refname when decoding
>  - reftable/merged: avoid duplicate pqueue emptiness check
>  - reftable/merged: circumvent pqueue with single subiter
>  - reftable/merged: handle subiter cleanup on close only
>  - reftable/merged: remove unnecessary null check for subiters
>  - reftable/merged: make subiters own their records
>  - reftable/merged: advance subiter on subsequent iteration
>  - reftable/merged: make `merged_iter` structure private
>  - reftable/pq: use `size_t` to track iterator index
>=20
>  The code to iterate over refs with the reftable backend has seen
>  some optimization.
>=20
>  Will merge to 'next'?
>  source: <cover.1709548907.git.ps@pks.im>

Yeah, I think this topic is ready to go.

Patrick

--3X8YyRUFIviMDPYo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXm8ckACgkQVbJhu7ck
PpQzHA/+OzJ8Qgy3rYuAqDX4UIYsAkqY+JyqjgDsmGHUJizK74nGvuMZY5/9iWd3
0JKxt+wd4y+6ge1gVJppCMzz1d73NV7flTLJ/uElEUGe8n4sEEbvystqre5XSe7E
5SHFmTqyKQAQ6z94ErBohGQJ9Wbd54takVKhQ3KZ7MrKlHZutXglkl7vS13bJUCk
aOdDcymHZs8eUK21TL00qb15DjIWB47HQEaadCHHEwFY1qlQsmrPkpCkwBSk43d1
gqtIGLf4gfHqW45hIcQ+blBWWgXmOa4yjD6v3LhBcHrajYMECdmRCMK3sVV5aSKd
iw4+2xQ4kUI4t8h+07rAlE/LGqeA51KFAX6U3+2Z4n4QsJpC9v023pns4IHptRYt
FNl+PYQ/4QrUjuHPYtAZXZND8ePHioa6recKIF/cm9Yl9Q3ZJxRBGJ3K4QqtPXTe
pfwNAmYOrK/esYDzRrvxvHWc14iccGjuFTpL3F1RMsj9gDjVP/4JP9/xbjrNFoKr
jkE5dGVsSZYGs6pmah8KpZjuz/myYGD5wImPKbnau65S7iGTFiDGK2pLTt0CTLgu
6qd+883SYyFAG2heuXjXfKKUV4gEB3ldoiH/KmHiYWTXroE6VWABMr0iNZDw2e9c
yG4V2VXUFXn+vYLItDslWVc4gAa+sYxV9skGVC7GLWL4iajEKGU=
=BZ9d
-----END PGP SIGNATURE-----

--3X8YyRUFIviMDPYo--

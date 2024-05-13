Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E471474C8
	for <git@vger.kernel.org>; Mon, 13 May 2024 08:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715590027; cv=none; b=anpXtSovIfVYestvyFxJaoAfZpplgdqCuypG6siRlR4BfmxStR1RzG+FJdGBDHhTGngPOORMHCmzcMQfn3FBKDSLj+PL1g2V8wYK9oi/s8HiGQnKrRXFnYjM3kDUdj8tTfKYKa6iWwCw5LW84vqsAbGKdojg8BVEYD9bv/4L9xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715590027; c=relaxed/simple;
	bh=rb2NdnGlKfCsCakwgWs2RkSoUgQ8P2ViELBsToXG+Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fE2YsUPKH5rw87M8/Da3JjT1oJGfnCc/6x8w0QqukVh9pNOPptHQGCBfwaqMjpamR++H1oqe5cqbjUEzNKqZT8u5j6Rt1OP2SdXkF5+D00Gh7Wmv2Myc6d50ofVdclV5bXGGCMU/DSM2ic1p3cY1c8fbYLIlLytMeysTGyzM6bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jjF9ysCK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a2NEG8QT; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jjF9ysCK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a2NEG8QT"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 4A0FA1C00065;
	Mon, 13 May 2024 04:47:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 13 May 2024 04:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715590024; x=1715676424; bh=JGVujBWaB5
	2M7VINiLy8vXOKVcJdNvgjWgx43qn9l3Y=; b=jjF9ysCKRVsjPvILGM6BkB7G7W
	HupdXvegyLHdGK7R0AKk9fXRnVJXw1Sk9NwP5i+VxZtR1jat1CTZ+dNlBfpAlSmX
	bFuryb25zKVH/XfkTSH41O7u7gilmAG6KB9VaZ+Ef3S1XhZ1pg5M6RbPaVBj5+xJ
	78sXGlsnDlm02SZUhW2YT0vCEwdc+1jx5v2rIuEXjf0w8diLmM1CbVa2kEGHLvIE
	ojkla/ffdofWRdzPHrAHc7UW6SRS2bkYlNkpPDfSmXS2c6egZ+/UrBf7XLuGiFji
	8p6WNAzHa/VRD0fMkxYLiHVrMnmVP41j7iOsEfBoPxB3Y9AYbLa94mxEd/Lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715590024; x=1715676424; bh=JGVujBWaB52M7VINiLy8vXOKVcJd
	NvgjWgx43qn9l3Y=; b=a2NEG8QTuPOwD1FX5Ucada99qEaCSgHSUOAhWYO1ganR
	Q5y7t+HOuAwULupIBljDZh3Kiryo3Ki12NOD+Df0T2Wu1NqcRveCwDAnkksZiqOy
	Cv9Z5jpB4WW8h2QJU3/zCUCdHnJtjc2GACeoaiMW+/wkpYHxdJbfMkoob/QAVUqr
	YroTLNIvYI2YUGjkUMGtR8OameYrUSNbrylXwP63nDtQlTpBS+pMyhNrVwB7PfnC
	XqHDUKGJcyTMn6vtSDxEH04rk9YGdj7KrPeZFquk2TYVUb3uSk6NCu/xqFurIVpa
	wVLVKNZKmd3pIDxhlFrEfAC+bj6UemkUH7dNwD+Rrg==
X-ME-Sender: <xms:iNNBZgxB7uyUBr2RzLE2ICVcWSl1dPMr__1FooI4oEHIINP63NXn8w>
    <xme:iNNBZkSW6JZUsj_7j7nSXBdyIWiZmM_91_MdTlwXR76kDPsoVVFBNEGg98POA_c-g
    qpXNJxlbxjy3ftrCQ>
X-ME-Received: <xmr:iNNBZiVrGa5U-6fs0Q1bn363cj9xOOsPSCV3VJnj8w3sJ137TBG6M5i0o-iY7t7xT-WqNgeoBm_8muk6G-TyoCsmd0U2JZ_kRoHbqKaTLFOaLJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:iNNBZuhIFRic6eok4adBlC-C7ne1a4V5PApysoOQkEw46p_Uq2ewaQ>
    <xmx:iNNBZiA_tAJl9p4vsrpTWrDT3KP18-VDrF3n0vg1UsSV0xvEyjIKcw>
    <xmx:iNNBZvI83IlofaRIuRDfFsnJ0nlA2glNFEaU5gZSbJjkb4Upps4yeg>
    <xmx:iNNBZpDwPA88rctFzh09BRqutZEy0sxEmgwsbmwuuW7hh0IxknLuVQ>
    <xmx:iNNBZtOO4JHYSkIQahlhBlxEC9_o4f_Kpl0mQXDKzigqBCwstCa8NBvl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 04:47:03 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7d82619f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 08:46:44 +0000 (UTC)
Date: Mon, 13 May 2024 10:47:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 01/13] reftable/block: use `size_t` to track restart point
 index
Message-ID: <ca86a8b58dd074287dd2dd352610ffe46e1605b9.1715589670.git.ps@pks.im>
References: <cover.1715166175.git.ps@pks.im>
 <cover.1715589670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vTyUMMwmx3xeuTF7"
Content-Disposition: inline
In-Reply-To: <cover.1715589670.git.ps@pks.im>


--vTyUMMwmx3xeuTF7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The function `block_reader_restart_offset()` gets the offset of the
`i`th restart point. `i` is a signed integer though, which is certainly
not the correct type to track indices like this. Furthermore, both
callers end up passing a `size_t`.

Refactor the code to use a `size_t` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 5942cb4053..00030eee06 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -326,9 +326,9 @@ int block_reader_first_key(const struct block_reader *b=
r, struct strbuf *key)
 	return 0;
 }
=20
-static uint32_t block_reader_restart_offset(const struct block_reader *br,=
 int i)
+static uint32_t block_reader_restart_offset(const struct block_reader *br,=
 size_t idx)
 {
-	return get_be24(br->restart_bytes + 3 * i);
+	return get_be24(br->restart_bytes + 3 * idx);
 }
=20
 void block_iter_seek_start(struct block_iter *it, const struct block_reade=
r *br)
--=20
2.45.GIT


--vTyUMMwmx3xeuTF7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB04QACgkQVbJhu7ck
PpTDSw/6AuxdYeLBg53Qi1h/gh3Dqwgr6RQZ93uNaTogQa9jT23IjuQ55wWG0mI7
xYNnctxKdfDu0uN264Zv0CKExzYtp0MvI9Xm2wV0xewrIstV7E+yoiizieoI/Qwy
RqmhtR5w9arDG11P6HmaoZDHTjloyYDoc4r7h0ED7tWqxT4ZfJV7M7aZVE+mGJnf
zpCgNXZgXV046gX6OHO0bC7ffeTxWUGRS7rPgs5nLcJuFit3AxchHFu2SFSHqhvT
9S4ZHq2imTZb0f0Djoh8Mp1aO/C2EDRkKXwUANPeDAT3I+ZyxRprwCg3U4aTVQPM
mwPb3gLEXvzEr5lDux496TK58WPmVnqWz/L83LLadIYzb4f5lJfk+X0BdWJCvLn8
a2mCFed6Cy3tkQ3do6Uox69Nci8e7OR+FW6ElMk2dRF8N6p/cDp921t9TJlYhZN4
qyeRw5MQRZF9UJ2dpX2/rDZmNQNezrGLKwLgr5DqI4gb3/4gQerSOT0u1AdRjJ36
iagl+5R1STtxdcH8BVGZAag8S6sKxx2ef4GomJCKx/0+DngkIh5fLWpBXourturh
qwDv/1bscztAkZ1sMAxd7rjHzQ6zemXjp0HDsBAoTIjjBGKxVck/K2MpqDrw4g7X
kdDlJS0xhyYCDGl4qbXdL5dHs8TZ9LgUJKK099t6hswFeCLobPs=
=99/p
-----END PGP SIGNATURE-----

--vTyUMMwmx3xeuTF7--

Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5AE15B964
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 10:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706783119; cv=none; b=PCaTo5M4jk3RZfQLUenMW+yVeb0znx7yKOF5bOYXqIIdU1vKR16XSgyD3vZtE8yvkuhnUOcCqa2giCERAjG4FHnWMkT1RvaTdKtrgWQh3PS3uSISCbu3ZcSA3d0t79R4+PZzi0cZ04NSSQ9sA+FU4skrBwwdPgZGG95YVcLtrro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706783119; c=relaxed/simple;
	bh=lUG38f103Jl8DBAb32Hr0CeZ0Z+WL1i2ePjrbMkMN68=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNIZ6ncPph1aC1zyF0tDZjCLcSb93+qR0PXsTSoIuGPA1pflfl0ckDzClWQIOvS+I7vLYvDmLmkEE/GUsZHj2sKeeTG4lQ3+VhFH515f8GmsLsAZJ+UDuFwPAl3/55oHp6wyE3Li/NmH3lxJuwpEbjklyG2F35P37wlyMqJPygM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZaJ2AU1k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TbZUD3PH; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZaJ2AU1k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TbZUD3PH"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 8E762180007A
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 05:25:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 01 Feb 2024 05:25:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706783117; x=1706869517; bh=VDwjXmBopJ
	cxeEzKGPCq58246N5MQB0qX7df64U00WQ=; b=ZaJ2AU1k8eskFp9vCO1Rthrp5z
	GWnhM0H1TgLyuX9ZUMcKt7YJzA8ZtYtF2aSzBdufjio5DZ2e7wdfQuGIfoI32mzx
	G44TOpDzNkM+NiOd5NnfadcICnm76Rn7fY3+/p9GudXsmkypgsxtPvKgEoCggl5x
	QTKhZQaftt8gBNUU5W4eyM3qvHaCgKG7b2qetbIP18Mlz6YYtxF51Ri1YLJcpHyF
	Oxl7GuQw+DQaytGvYX8aQzy/NFHWDpwO014crZeIlT9r/o+DhIXLofWnJaZWNd5H
	5Wi+r6Gv2i/B4iY8Y0J4hwIPpzeJctoHe6UL4Xb++KaJStbWNVUJH6nqS0Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706783117; x=1706869517; bh=VDwjXmBopJcxeEzKGPCq58246N5M
	QB0qX7df64U00WQ=; b=TbZUD3PHEMo8FYY3xqvSBZhM+uF+loZGULmrDP26mppa
	Eu1ZgwZE3lSZeEIkDX7fi4zTHVgNKBqXkUBm/jA5rR9BV98ojrroQ3se/QD0bJ3H
	UCBKrNrSqATKCj4ELXI1eYpDC9Hrx5mT4LHoBxODZE1Ex4kWf2Wi1Yx/AWqXma0X
	Gkl2v7Uk+4gP2rsG3SE7AI7NP/vcutbvg/81YsYGoHd1RkxXzFB8je5bhWtxplZc
	X9CVNCkDcFu9CFisBPDa6ZfrOTzDq0gEcz0Zpp2dCKkNaFPDxeZ98NQbLvHQ1B6l
	e+FiN7FsI2gh8wN0CqWZkHVb9lyQg5za1FT9L4fQCA==
X-ME-Sender: <xms:jHG7ZQzE2FcU1tfXMKdEzeUgpssJyXZrVeDSLpa603Kvai3W7k6Qxw>
    <xme:jHG7ZURddJKCM-QS_hL0LzeSD6jRqafLuyY83PcOAmesS_Z0xvXpquSzHck_wseZl
    tk7lFnsS6idUMn8WQ>
X-ME-Received: <xmr:jHG7ZSUmZ9HX1qkXI20e0-3ilro4epkXq4Zw7c92xRdDnT6obwV961Sl2R4KxV_l3FJmrX_haxHdR5O4mR5Y5S7P00J9C7sIdzsJzbQLQO5l8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduuddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhephefgjeeuveejteduhefgffefffdvjeefje
    eivdekfffgkeeugfehveetueefleeknecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:jHG7ZejnL1q6QAVHJlfYW-LQ736-cJdSzcmyQnQYean8R38eCqY__A>
    <xmx:jHG7ZSDy46YpL1P9itzr-x6Fo2qOlL2W_g6dnG84Dq73-VOg1wSQSw>
    <xmx:jHG7ZfJz_VBOod6Tk42uIajbHFvecG0pxvQlAO7GVng0boalHxb7JA>
    <xmx:jXG7ZT4IFRkAxk7iS4VWj0IUS6NHfV74JlbSCAeVd7vMDX25-hZxwe5bf0I>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 1 Feb 2024 05:25:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a59ab554 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 1 Feb 2024 10:21:53 +0000 (UTC)
Date: Thu, 1 Feb 2024 11:25:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 5/7] reftable/block: swap buffers instead of copying
Message-ID: <ac3d43c001ba0db34b8caa1435b91f27a01fd5c9.1706782841.git.ps@pks.im>
References: <cover.1706782841.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DWgfgw9aKYhi2pyR"
Content-Disposition: inline
In-Reply-To: <cover.1706782841.git.ps@pks.im>


--DWgfgw9aKYhi2pyR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When iterating towards the next record in a reftable block we need to
keep track of the key that the last record had. This is required because
reftable records use prefix compression, where subsequent records may
reuse parts of their preceding record's key.

This key is stored in the `block_iter::last_key`, which we update after
every call to `block_iter_next()`: we simply reset the buffer and then
add the current key to it.

This is a bit inefficient though because it requires us to copy over the
key on every iteration, which adds up when iterating over many records.
Instead, we can make use of the fact that the `block_iter::key` buffer
is basically only a scratch buffer. So instead of copying over contents,
we can just swap both buffers.

The following benchmark prints a single ref matching a specific pattern
out of 1 million refs via git-show-ref(1):

  Benchmark 1: show-ref: single matching ref (revision =3D HEAD~)
    Time (mean =C2=B1 =CF=83):     155.7 ms =C2=B1   5.0 ms    [User: 152.1=
 ms, System: 3.4 ms]
    Range (min =E2=80=A6 max):   150.8 ms =E2=80=A6 185.7 ms    1000 runs

  Benchmark 2: show-ref: single matching ref (revision =3D HEAD)
    Time (mean =C2=B1 =CF=83):     150.8 ms =C2=B1   4.2 ms    [User: 147.1=
 ms, System: 3.5 ms]
    Range (min =E2=80=A6 max):   145.1 ms =E2=80=A6 180.7 ms    1000 runs

  Summary
    show-ref: single matching ref (revision =3D HEAD) ran
      1.03 =C2=B1 0.04 times faster than show-ref: single matching ref (rev=
ision =3D HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 1df3d8a0f0..44381ea6a3 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -342,8 +342,7 @@ int block_iter_next(struct block_iter *it, struct refta=
ble_record *rec)
 		return -1;
 	string_view_consume(&in, n);
=20
-	strbuf_reset(&it->last_key);
-	strbuf_addbuf(&it->last_key, &it->key);
+	strbuf_swap(&it->last_key, &it->key);
 	it->next_off +=3D start.len - in.len;
 	return 0;
 }
--=20
2.43.GIT


--DWgfgw9aKYhi2pyR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW7cYkACgkQVbJhu7ck
PpQsihAArfDyg8Ab+wMQoz2bsK8188Lh9dpsFsUgE7uornYPMQ4Lt5VuSXxYCX5h
7uKDQu6YUj2/01DUN1nKViJ7Z87w2MEnsdtAAvVcHnG9rMz/3pQcdgy7YnI4PdZD
BzKzBky3jMT5EaUUaxpsx9LYC6omW3LckJnBvTp6e5pG3TOGuKvhqClm+Fq43uJA
YcdpelQ3Sx3VooFQS5XpUq/Ycol6mUeySxnElCipoiXla2uJJdv7mC5hCdGxWEd+
rlz2TZornb8SFqMbbkuvkHGUait/WKz0OENhMWHOc1IjUaAueMAYqr7Bz5Ul31CB
w5Cdh3nlL6ner2VPX5RF71zZQoXvj6e/mIM31Ku4rIrGC+VEvdudYyhkcjpq/aAg
sVzX27fgu0Buwv68IBTGGREtoAGedRO2qR8+wSlMBo3MilxVz0mvhMi13uzbgRMl
H+ZFnm1sASEpud7BJgIAf014uL4qNZQWtY+fiOKU/n+dE3mM8kWtI1Ouy/fXJFuW
WXZ7dnfxcTtVJ374Vusuo+ek7tDnV29ZldVPkEbHgq1aCyGrXuukOvcF7pbCC3Lr
CiHtPTkgeFHQUHDwRZRiGwtaDQPLa+j4S+W5SNjRjbLIJlIgf7LxFhNyoZIWwXGK
3PFMwqG+r584CaRgfuh+JJ4NhXuwn4LjT0aGp8oiA5ycZ7PJI7s=
=+MfW
-----END PGP SIGNATURE-----

--DWgfgw9aKYhi2pyR--

Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCAB360AE
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 10:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710759153; cv=none; b=nHLV+2BOnRadeF3507hzRbxDfZYrusjvcLqXpvgHm8arQCiBC9HzKJ8ceTXBPCH02DJP9dYgk5bdQUwIrUed4fAj7Vd6bijaUNHA4LO2nakm52Trv5U51LEOx18qjraAcambICmu9ZQTNxS+tDzf3DBerLj2rGODYQ3x7OMUXb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710759153; c=relaxed/simple;
	bh=nEv6E6JCN+i19Xb6dIpJK+9DVVSt24ACbSO2NnjRyJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmrYR4KCOgLcjKwIkKoQ5sYOcBSY7h1pS7uVzO7KQu60cQ6NSVqmS7jpPtfuKaL0ebb1gLmE5eszzUxbv0PGhjJIiJ5d4uKMgOXZk0yVVdAxkvChA2J6dzWI8BCQqHnlNC+KynP53pFzTf40ud4NpmEpbOnA2ncf9onTv8tzJg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L4LP9ziw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FUZ/GbEO; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L4LP9ziw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FUZ/GbEO"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5E8ED13800C8;
	Mon, 18 Mar 2024 06:52:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 18 Mar 2024 06:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1710759150; x=1710845550; bh=6x11qkHIEG
	hset+qHakcZUV6ERKSu63h68YwnEwwm8E=; b=L4LP9ziwKKpqQNisrTm3CZFv4J
	X3nV/JgJzTbMfBOnHS5PleD78jCkKigExI1CAP2LaVf0NxQ7f7DHDNvra5PsM7oH
	TmgHiKszgTSl5kBNQM8M0ckmNxQ9DvYvisYKYE/AKa/vqHdZvF7T+FH1yfm368l7
	CPZb6nZQOksJjT3nWfpyw2/4LxT9xOC/OmRy/GfZxPtrACIx0Xtzfz8bRfdO+HAf
	F84S7U3vUNWRzSqS/vUdTwgV5VbH52ZIt33l6zLAw3z+ul1PYdtdFl3MDsqEK3hQ
	U+DCdlUd64wwEeenBJQbrvM3prBJ9lDyxw4IvrqKQnoxy97USXTUKoKDbsNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1710759150; x=1710845550; bh=6x11qkHIEGhset+qHakcZUV6ERKS
	u63h68YwnEwwm8E=; b=FUZ/GbEOBMYAEMR0ku2/1dBcnTiBLKCvLkFPucnVMmSQ
	j8RU5GNi3lyTFg2pwh1NqrQk6fo2r1mYqG4yqx0LBVwIQcNAwEF6QAdaVkSUFP3B
	M30MY+r9MvHa6l151c+HsDBwPfJVtPtWnSTecFjLcT6y94Ofnavpu8USco0QU99V
	u1+Zv7KoH0BGAXzZPjTzGQe7UD0eMEcX97KcwUcUdtJi8UUwRwb1l8t+svKX8z8C
	Q3n1JJJED/xS/k+YhKtU7p3J7+Qw9vVzLQBQsKKJGRQ7FEzGODiEY0vtupaoaIMA
	Q2+e1lV1OvsumoGMyM6WDEJG3roIlR5G79XHECp2ww==
X-ME-Sender: <xms:7hz4ZfbdMQyxQgofCdMQAhSvxiFq9E7HZhksbVwHIykfa4Xu3qMyvg>
    <xme:7hz4ZeahZDm_9kuQ2GsDrRKklh-yLEN27zBjoKvhdBpH5RKtSzWIx3BGTWLMLaG6Z
    Ye6jclexoL5fRRA3w>
X-ME-Received: <xmr:7hz4ZR_rtYRDAGFv6nVe8Y1UupLe9Knd9wunmKgohtEaF99rWMdKKIRDj0EbyWZY_vn3hvq5lQbzA2DAi5_89jHHI2wwn8DhGnAs2k6oirqAzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeejgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:7hz4ZVpiKtpsn7IvWhmYxiVNWE_StqWJmzRHdxUK6KO9GbCm7abV2Q>
    <xmx:7hz4ZaqApOtdD44EesdkN2PPkP3dkoAFcNIWs2lX9EkxsLPLfu5QCQ>
    <xmx:7hz4ZbQgQqp5QaoU6KVkguBAEe2HsdAJOjhbgAdbPZLE4GVR4JdYKQ>
    <xmx:7hz4ZSo2F5hAWpC1wQPquomSSiJijVOIN514xZEMiwu0WR_1js5AfQ>
    <xmx:7hz4ZdVognABL0PgtjKpIYtViSRSnrdke9NdoIVcILY_QF-xLsB0Ng>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Mar 2024 06:52:29 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b932a93c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Mar 2024 10:47:38 +0000 (UTC)
Date: Mon, 18 Mar 2024 11:52:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 01/15] reftable/stack: fix error handling in
 `reftable_stack_init_addition()`
Message-ID: <1e39d93a45db502280ecff383d53e0294f969719.1710706118.git.ps@pks.im>
References: <cover.1710706118.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WT54rAcZN8pK21hN"
Content-Disposition: inline
In-Reply-To: <cover.1710706118.git.ps@pks.im>


--WT54rAcZN8pK21hN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `reftable_stack_init_addition()` we call `stack_uptodate()` after
having created the lockfile to check whether the stack was modified
concurrently, which is indicated by a positive return code from the
latter function. If so, we return a `REFTABLE_LOCK_ERROR` to the caller
and abort the addition.

The error handling has an off-by-one though because we check whether the
error code is `> 1` instead of `> 0`. Thus, instead of returning the
locking error, we would return a positive value. One of the callers of
`reftable_stack_init_addition()` works around this bug by repeating the
error code check without the off-by-one. But other callers are subtly
broken by this bug.

Fix this by checking for `err > 0` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 1ecf1b9751..92d9a7facb 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -590,8 +590,7 @@ static int reftable_stack_init_addition(struct reftable=
_addition *add,
 	err =3D stack_uptodate(st);
 	if (err < 0)
 		goto done;
-
-	if (err > 1) {
+	if (err > 0) {
 		err =3D REFTABLE_LOCK_ERROR;
 		goto done;
 	}
@@ -713,10 +712,6 @@ static int stack_try_add(struct reftable_stack *st,
 	int err =3D reftable_stack_init_addition(&add, st);
 	if (err < 0)
 		goto done;
-	if (err > 0) {
-		err =3D REFTABLE_LOCK_ERROR;
-		goto done;
-	}
=20
 	err =3D reftable_addition_add(&add, write_table, arg);
 	if (err < 0)
--=20
2.44.0


--WT54rAcZN8pK21hN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX4HOoACgkQVbJhu7ck
PpSiMBAAjTHXloxS0kzTChmcPm1azgL7+OOmRngYzFDpSAfCsAL1VRDD7g/+0F1M
E1LzGl2uyVejD9gOO0mhiJ6puXWGQLQHr6InNwEM5RAKAOnDTTyifViAVXZi/I1j
f900pbi52eZXXeBxKFaFAbFe0L+mGr9tsOb6i5Miu5mGAqD34NVBIlT/oVHvkDng
gX0w0lpCsnBg2dp/6B5IlzCNrKn4IyaTmF2G6M1eQWdY+vlXRfjwjz2g+aPWBJyh
usnWmxWoiudu8BkWcdjg59AbrweAlWjJ895ful0fCvSF4w4j2GwOjcr87CNdb3DM
bQDHXRqo6IT+XRP7JKfshD266E3G+Sz1TCYDN3+tvzWcRxiPNqneKaYCAWwt7nM9
HkQu+SsofexsRD+OD02MrL/nJdZSdlXp+RoNpggtSAmLSBFCGvgnEIImfqRl6i6X
82iZr5vtNoNLtYD3adEZ8gRgWoUSSFgVIg0FCb69uKljUY2IYYb1QUhouvSq8Ti1
Da3NErq0z6ctJ77ZkIOY+qtRTg/p5Q/wlwVCcGeZu4ajG+RHSWE6N+PiVkXwTA+3
HsFhEn5bbaoH2bS/LmISHhZBYrmiJAsZbcZ1s5Y+F8AzDYhivs3SA+d1MSfxyPJF
mIo19FhBKpF3Ne2z03TC/f4gCJ9nMqYU8n5V1NdFDS4HVcM8ASY=
=soAr
-----END PGP SIGNATURE-----

--WT54rAcZN8pK21hN--

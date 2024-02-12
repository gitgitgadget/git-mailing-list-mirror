Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E50D10A05
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 08:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707726763; cv=none; b=qzNtRHWmweVLHf41k78s2kWTbsSRLSPZZnKZjQpdo2K7Cl1n3Lo3J38u+vrCRcYNYyJYf4Kg5panMBeZyOX6HpN2uBlhSvRnCfijCOv0HYWOb6WQJqtz3X73brD00QJPBAoBrTPAW6z0/9p1dTCTnPQ7afMFRAksyfUPbJh+cLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707726763; c=relaxed/simple;
	bh=g59/EbwwpiXrVK1/mtUySWh8H6xpWpH2KPzit1t7YIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umyMRU8x+CkZzDKzplqE9pBEr6Y4NCl1/835VKKKfHZXL1SmOb0vqJ4Snk4CM6Z2a8avkTuJHWDP3E1UgCyRbYh8VrDp9S8yfWTVwRJkXzvFPhFZEs4kOTIe8Mqkx6WkDVutOftnojc7R0nCcmpucvlONy5XeBYljMdVa/iTJns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZraYAelz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UKeZzRNC; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZraYAelz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UKeZzRNC"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4D67B1140099;
	Mon, 12 Feb 2024 03:32:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 12 Feb 2024 03:32:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707726760; x=1707813160; bh=VJzeEQIQHi
	q40lFoyRDy3hyPnHDudasBZ7yDj8vwh6I=; b=ZraYAelzkXgB7wDBFwx4c/tMTA
	xe2EBmdatjkPlIVps3xG9sOl2DJseYhdmTXdvjwHGgQGacRL8KBXM0Z5EUt/BeEu
	AdPmNB0oPNDsXV6Qzs12CKSo9UoFDMG+3sNMIoJEqmEiOfSFFPsQ/ffy6QSmO/rK
	e0UjFMhW3zRua1qc6YZ5gkAZAoa4sX/8NvxNyBaNmGHdL6S1IjbU5AVNmbJJ7FTr
	hvwcasYuaQBmfnieDyW3WCx72BUYLoLkhdhqbhnhhlkbkO83reRv3ht8nMmtz8Be
	4SYHAPRSj9CnwsIpSrbpFU6TSX14B1dorNbtjn9MSms+faz/EYQdokwnUTNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707726760; x=1707813160; bh=VJzeEQIQHiq40lFoyRDy3hyPnHDu
	dasBZ7yDj8vwh6I=; b=UKeZzRNC7LIIFcpOrumXQIUEqnO63SYvFR1cOMwZhClX
	dCj8JOm706yNAimF1ysNg4afW/Vcpj2RH9I+fwUZL1PXydSzIkPKMYrqIVDJB80u
	+Bo8oMqjJ+vMvqybZXxGmk9+vzQqXNpY3c0JxRuuKijNzNevmQgxX23Gpn3O3w6d
	V7kU9MlkK0b0ZmeZ10f2mT+7OVUyFjusgZc0bpDH3bWX+DnSraoC1JlzzisBqADq
	d4Ae9R7MU/oibDhPc352VmsOMpDBg8AbHz3VbplMp9Q05xdPoA5liE92LYX2d8HB
	56n1eTdTYqKmQ/ZktFodqaQfvbjwGrr8g1JFg6Orjg==
X-ME-Sender: <xms:p9fJZQJBBIvNvs-xrec9oG6-xobTdFKG-OeJWIk33IRsgWukcN5eew>
    <xme:p9fJZQKWBfV7kMooQ_JIcDoAhCj70rvLPOgCrSxUzFpLDSqqqDqOXs_uwzFsNlBoL
    gix8dnMaCdcAuKj4A>
X-ME-Received: <xmr:p9fJZQsDX1WzeTaxiFV4fHpqaq6p4pvGt64G4cM9SD5AI4oQar5fdwkhmP9UED1XPwIVWSCAoVicf47oA-eDyMdGwhXxv5JWyR0Lz0WE2I7RPLo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:p9fJZdaZN1P2yTQPml06VkeL2xzdFcwizVdN7YP8e3hB6109Vm_Ypw>
    <xmx:p9fJZXaIbgSyeBQicjMVPG6bR9WmUjaG3mUWfJ-kn5yyiIZbgcygXA>
    <xmx:p9fJZZC6WNOlqqYj_5BOX_Zo6NQSSpME77uvGZ_HzpqMOqIousipeA>
    <xmx:qNfJZTHix6aPvdq8kmib-zmcj6DgvicM-kT3Slj3QmqF09dZsTAOHQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Feb 2024 03:32:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ee8dfd64 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Feb 2024 08:28:52 +0000 (UTC)
Date: Mon, 12 Feb 2024 09:32:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, John Cai <johncai86@gmail.com>
Subject: [PATCH v2 3/7] reftable/merged: skip comparison for records of the
 same subiter
Message-ID: <205e6b488be9165d08e0fecb6197ebfc6747ba1c.1707726654.git.ps@pks.im>
References: <cover.1706782841.git.ps@pks.im>
 <cover.1707726654.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uV7/iz3E63Sp8I9+"
Content-Disposition: inline
In-Reply-To: <cover.1707726654.git.ps@pks.im>


--uV7/iz3E63Sp8I9+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When retrieving the next entry of a merged iterator we need to drop all
records of other sub-iterators that would be shadowed by the record that
we are about to return. We do this by comparing record keys, dropping
all keys that are smaller or equal to the key of the record we are about
to return.

There is an edge case here where we can skip that comparison: when the
record in the priority queue comes from the same subiterator as the
record we are about to return then we know that its key must be larger
than the key of the record we are about to return. This property is
guaranteed by the sub-iterators, and if it didn't hold then the whole
merged iterator would return records in the wrong order, too.

While this may seem like a very specific edge case it's in fact quite
likely to happen. For most repositories out there you can assume that we
will end up with one large table and several smaller ones on top of it.
Thus, it is very likely that the next entry will sort towards the top of
the priority queue.

Special case this and break out of the loop in that case. The following
benchmark uses git-show-ref(1) to print a single ref matching a pattern
out of 1 million refs:

  Benchmark 1: show-ref: single matching ref (revision =3D HEAD~)
    Time (mean =C2=B1 =CF=83):     162.6 ms =C2=B1   4.5 ms    [User: 159.0=
 ms, System: 3.5 ms]
    Range (min =E2=80=A6 max):   156.6 ms =E2=80=A6 188.5 ms    1000 runs

  Benchmark 2: show-ref: single matching ref (revision =3D HEAD)
    Time (mean =C2=B1 =CF=83):     156.8 ms =C2=B1   4.7 ms    [User: 153.0=
 ms, System: 3.6 ms]
    Range (min =E2=80=A6 max):   151.4 ms =E2=80=A6 188.4 ms    1000 runs

  Summary
    show-ref: single matching ref (revision =3D HEAD) ran
      1.04 =C2=B1 0.04 times faster than show-ref: single matching ref (rev=
ision =3D HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/reftable/merged.c b/reftable/merged.c
index fb9978d798..0f74a14a77 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -107,6 +107,14 @@ static int merged_iter_next_entry(struct merged_iter *=
mi,
 		struct pq_entry top =3D merged_iter_pqueue_top(mi->pq);
 		int cmp;
=20
+		/*
+		 * When the next entry comes from the same queue as the current
+		 * entry then it must by definition be larger. This avoids a
+		 * comparison in the most common case.
+		 */
+		if (top.index =3D=3D entry.index)
+			break;
+
 		cmp =3D reftable_record_cmp(&top.rec, &entry.rec);
 		if (cmp > 0)
 			break;
--=20
2.43.GIT


--uV7/iz3E63Sp8I9+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXJ16QACgkQVbJhu7ck
PpTkmw//Sy/jtrEWli4vUyatzmxiFlp4PcIhyn7YDeGQfgp3ZKEcvebMpxen2Ra7
SFriMFFtIOqMuMOXHBvkyYUxZpK21vYJ9JjCyoiPXfiyEDp7SSW1Dc62w1sNLr38
kYt/s80qQ3U7h+z9KheI8rMtPdR1GDbBP747vFYfA5Q6M7DWGh/DNtIryEjg1dDh
1i03wNoIK+vjLEpF1iFf2MgDm5qM5irHG17t+OBNNCvX14yUTcYGQw96DdNbSUmp
dkkoSj/ITrSbivcAPYmF7QElY41LtCLN+RUk/bfk0aLyXY9f8wzfQlxgQX+hyijh
EiTs0d+emSEDBCS2n9OtKyzsxVllR39JXLB0dL+Aqf3rGNJmfkAPG1bW8auKfY/b
KlUarThqlwZozrVOa0GAM4TaSOdPMN4J984shdl74eZAybGNnYbEA9cOdPTsBtfV
VCjYajpQJlQ9Nbqo0cGU6usmleK3sbfsw6zSyOMU2xbDfbhkm/4fYO9e5WXZvdLe
biWx1fxfkt4BnXpmr4zRAA0RQDM5AA8haQar0OCqCXS8iJ42xkCGNcT74Y1uIg3L
/FEm7NTr5EnI/CDU8hpZTz8zeuDJkFeyXLIIlEixE/mI16C5/292SSwWgLopFeH4
dPN0W7xgCmm2hZ4b8kcr/7jykBaIBr6/dsZdCgyUuzpg3zE5qoA=
=0Xzq
-----END PGP SIGNATURE-----

--uV7/iz3E63Sp8I9+--

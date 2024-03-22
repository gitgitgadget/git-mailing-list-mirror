Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7FB45C04
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 12:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711110172; cv=none; b=a2yVT5jfDEYIjWh8LtQwoR32fjPXdLIkSLgAKSqtPoTM2qdynhRz8028ix1iNYN8+knLGapWjvHl2NLhbhBSpvXdCiRTkak4k+s//L3Il+zIiRi8LSQ3/bds4wBwmvLKUS6f7pIEYPPRMXdM8KLL18P+xTTve4r+Ki41u5GtCzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711110172; c=relaxed/simple;
	bh=qymDGwTb333PeIIL16hBSfNl0KsmgDnSkLsI2PjpcAw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMK/k6wamb+QzZu1OIKqvLnrvTG8kYxSWh5P5WoeqcHHGtG8MdbUsAFeW3wg2TMSwlCMWCUxK3xo/k2AYTbR9YRcw6TX3l+HjhN+anSxF2GzzfnTyBxwzSaxhllFmpf7BM5m6lTl9p5Qawt1TgAPgIKgWY74dMWbvZZ8bD9FmEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YSA11hCO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YiCDVZ5k; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YSA11hCO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YiCDVZ5k"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2181F1380068
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 08:22:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 22 Mar 2024 08:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711110170; x=1711196570; bh=bl4V1gOTc8
	TxqvhDWrpWQEwA97Q1CEoWpPydeboV3XY=; b=YSA11hCO4Kb15kSOZXBtO9yV5H
	vJq4jJeh9ZdPEh6kxHtPyE5A7L2iuEQjvLQhv6QOptYyODPCnsqyzkrXC5y/ER46
	7tWgjgedebEIpXA7FWNxronJpjPwPJ+SJLMdOXSxX+iLNcixH6HeJX4Y5XT11/et
	AKYH9kePH0kU3bkbh4ciEFRnrv+3Zu2s9JRu6LfFBKh+pzevUfYXS9TMdPBpag9C
	LtKHBL2j6xz0pLE4R00q7xjaLyfCUfSTCespAQh5ygBzLpQjun5Ew/PgqcIylQNB
	WVPGRkL6bhL8GkNJfJtrQCupqQm04AzM4WHr+5YO7tIhQO1huUBjA95naJYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711110170; x=1711196570; bh=bl4V1gOTc8TxqvhDWrpWQEwA97Q1
	CEoWpPydeboV3XY=; b=YiCDVZ5klUpKS2dAcesBdvR1CQAWRDqU7CWP7GSJD3rE
	XtnYrM/R5+RonMEZPjoO1aWRbvcQTVf6trrKfJwP1mPGbaAXygGFsa9heWamHJXm
	NmKSX/S/g5mGR/uTKoGVlrUVV+bQAUvBH3HhkIx3doVx+XUG9Exd203lzohNo0Ll
	EDdoBfaifNNxkBG8lhI7SSduE2WWZMPuWnbUHUVMKfxuh5UqNB+Iv944n/4fmty9
	jm/hZfBXwq3W0TQotFnpJe0k7Q9oQeJI9tuNDj/NtW7mveui9H0ZN2d430qcITbo
	aqdEflmlX0ccf184w2zleMSy/gBR9xYX7F24J2XkiQ==
X-ME-Sender: <xms:GXj9ZV8wnVm1w7uITV_-IhXeMzEX3IUR4LiYS43S7YFZsw7WJ9H5xg>
    <xme:GXj9ZZsO7aKw1A8M3jdeLGrYYBj0DTnGf2ZuAUMhASoTQTBEhOjYFXfleevBbo6sb
    tvaPLN066qw8i1mEQ>
X-ME-Received: <xmr:GXj9ZTDSUjLccaMSEj1Id9xvvGZ7vBLWJ8MGsBRgAZ5NPYahkzNEK_O17u7trvwGJmX09fm13O3CBs3LvkaJg5FFBb7f4qmCd3VdkZoceI0oCPU3oA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddttddgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:GXj9ZZcKPn-xMJtlKtJUCJePiKHR0-OsxKUwRJDsu7RilvG4OX9Uzg>
    <xmx:Gnj9ZaPwZdw0RP0Jq9MjL3Vi3S3KWyhVowihOFYS59NTec92o85v9g>
    <xmx:Gnj9ZbmDxB4krX-ycNeMhv7qjFax4-OIrJ58FEQ0OYgT3oNId0epgw>
    <xmx:Gnj9ZUvdLfc-QeBSk7bTKudLD1k6MNkl7-6NTs9TLI51HqJBLbI57Q>
    <xmx:Gnj9ZTZP83p_AQerjByNfjK8b0ruf4oSga28vXlmPO_X4Eau9L-g1g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 22 Mar 2024 08:22:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1c367154 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 22 Mar 2024 12:22:43 +0000 (UTC)
Date: Fri, 22 Mar 2024 13:22:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 5/7] reftable/block: fix error handling when searching
 restart points
Message-ID: <36b1ef8e5c0948392210e859b61d9ae3bdb58be9.1711109214.git.ps@pks.im>
References: <cover.1711109214.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Fp1w0d8wkuzRchKU"
Content-Disposition: inline
In-Reply-To: <cover.1711109214.git.ps@pks.im>


--Fp1w0d8wkuzRchKU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When doing the binary search over restart points in a block we need to
decode the record keys. This decoding step can result in an error when
the block is corrupted, which we indicate to the caller of the binary
search by setting `args.error =3D 1`. But the only caller that exists
mishandles this because it in fact performs the error check before
calling `binsearch()`.

Fix this bug by checking for errors at the right point in time.
Furthermore, refactor `binsearch()` so that it aborts the search in case
the callback function returns a negative value so that we don't
needlessly continue to search the block.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.c | 5 ++++-
 reftable/basics.h | 5 +++--
 reftable/block.c  | 9 ++++-----
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/reftable/basics.c b/reftable/basics.c
index 2c5f34b39e..fea711db7e 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -39,8 +39,11 @@ size_t binsearch(size_t sz, int (*f)(size_t k, void *arg=
s), void *args)
 	 */
 	while (hi - lo > 1) {
 		size_t mid =3D lo + (hi - lo) / 2;
+		int ret =3D f(mid, args);
+		if (ret < 0)
+			return sz;
=20
-		if (f(mid, args))
+		if (ret > 0)
 			hi =3D mid;
 		else
 			lo =3D mid;
diff --git a/reftable/basics.h b/reftable/basics.h
index 2672520e76..523ecd5307 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -22,8 +22,9 @@ uint32_t get_be24(uint8_t *in);
 void put_be16(uint8_t *out, uint16_t i);
=20
 /*
- * find smallest index i in [0, sz) at which f(i) is true, assuming
- * that f is ascending. Return sz if f(i) is false for all indices.
+ * find smallest index i in [0, sz) at which `f(i) > 0`, assuming that f is
+ * ascending. Return sz if `f(i) =3D=3D 0` for all indices. The search is =
aborted
+ * and `sz` is returned in case `f(i) < 0`.
  *
  * Contrary to bsearch(3), this returns something useful if the argument i=
s not
  * found.
diff --git a/reftable/block.c b/reftable/block.c
index 6cd4c053df..ca80a05e21 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -387,11 +387,6 @@ int block_reader_seek(struct block_reader *br, struct =
block_iter *it,
 	int err =3D 0;
 	size_t i;
=20
-	if (args.error) {
-		err =3D REFTABLE_FORMAT_ERROR;
-		goto done;
-	}
-
 	/*
 	 * Perform a binary search over the block's restart points, which
 	 * avoids doing a linear scan over the whole block. Like this, we
@@ -405,6 +400,10 @@ int block_reader_seek(struct block_reader *br, struct =
block_iter *it,
 	 * too many record.
 	 */
 	i =3D binsearch(br->restart_count, &restart_needle_less, &args);
+	if (args.error) {
+		err =3D REFTABLE_FORMAT_ERROR;
+		goto done;
+	}
=20
 	/*
 	 * Now there are multiple cases:
--=20
2.44.0


--Fp1w0d8wkuzRchKU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX9eBYACgkQVbJhu7ck
PpR+SQ//VH6EzbYW/bPkQeqiG2H0r34uexJro3Bv1nfokj4vzjxUmwyph+WU5GPP
nrOjAC0oxp6OKdb1LLhT95OVw3zu3s/D6FNSw87kuW1bkOb7BbbcCjbaZjXuWGiy
rUFV0ohBug9sX0oFRDh3Ubt268G4IdSrCDYK5t/6595U5TzoxaygxM74QTIoOJbN
MsUomAsF5MiacgUSfY+Ls6+oMxJrTL8EqrjI11g4ReyAFnil8mqvCzNXTcLacPQT
OpTWODasvEZRnhoHzeMAy7U9obYUQnh+Poc7fQwj6liWyfYFwpmIZFlm4+ZBAt8E
gXGCe6kMcJHQVxVb8Z8WSUv5aNfnnaw9kFflsPjVKugibHRALtpGvLJBwf1ifsbt
40H8Xn3j9XMjqXJHAEUHH4/5iP0XDTY8qFU0UaSYtol1UINwO/7PDNHmpIxMHNGc
nsCDnEpTbS6j3e8h4+GiWyOle3NXIDXtwhMog2K2tl/rhQQeiyVb/eCtL7ESdYu5
X6TBirchJnHR5JvwfXRhz6BCXeAzPncx9XAyGzZMVfLKlmuQmgWffGEv2BjR5TjB
+BtohCFJs8iB+C0kIWe5GjNAIH5uKuWJQXMqrS7NzB7xN6esgv3fmm1b5ek2lD/L
iue8x1/FDFvSRW/9GrAc11bbLmqTXDW9st94KjR2vRrMtSwtWgo=
=F16Y
-----END PGP SIGNATURE-----

--Fp1w0d8wkuzRchKU--

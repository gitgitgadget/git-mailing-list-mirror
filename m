Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E2D1759F
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 07:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707896788; cv=none; b=m7F5qosZyTaQqDWXb6kA/34FSL3hY/tki7T0IzHcsCst1h0rCWFOrGkjLH7H4tPSOkCJlp39k4yBS77+efSYyd+ga2kYa3r3DbBgNKhoaoQgLaMVwQp3GH/+fE3ZSZmxLwlgiA9gLZUycwHZQ2IHpOzPR6+tWyOElq3E2PG77/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707896788; c=relaxed/simple;
	bh=tBJoI8TBqmqvIxgRX7ufSW1+m71jPbaJHs3w56kYuZc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PezI+VviyWhLXU+kqWKE5jaY9AV8vxYNCyHSL8eQgueqy67c3694qdqr1d4WQ1XZmOLTwls4+J4Wyu5+8He2K1aGgP/t97sJayUNDQh6Na5Aaq/1BI6gTS399WNrGR6EFfo9jXXRgAl9HQyi/YDp3noohH6r15ss2rbMhw0ovms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f0NSfjwj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ok2SFBUO; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f0NSfjwj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ok2SFBUO"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 9B45B1C00077
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 02:46:26 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 14 Feb 2024 02:46:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707896786; x=1707983186; bh=VXZ+dYIkAD
	6Emn9akeQuJcCgj3wNJGheR+4+iQ71GLg=; b=f0NSfjwjj/lyY6OpTUjps98TW8
	1IhnH/JNbLM7Caw8MBhXXvTNjPgduwe+R91NMQa7ywQyRlqZ2lk8Xh3/nGwHQ+G8
	i+/b1JLQtSbTAReAZZ2HKvfQg/iK+Ie3bRyx2zlPwYVihAgftPEoHrRPXecOsvKu
	An4U4R+DrqmVqVraw7EhuMY6AL/CcRLyF/Hx9rarTOA3ABhqrnqhIuiN+JcAMHdd
	qNfiCcrMS7gx/Zka3xQ5zsGdDwcdhVu3fhzp7S57C5g4gX0GjanINKPAI80KL9l2
	2k5M7i4OnN+e+vImRxWLlGSBzXQ1C1WuQAY6LfEzKNel9jS4SJQ/GLcPQ4Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707896786; x=1707983186; bh=VXZ+dYIkAD6Emn9akeQuJcCgj3wN
	JGheR+4+iQ71GLg=; b=ok2SFBUO750eUUoF6jshejjWt7RWQF5HmiamGPBgWj1e
	wCCBC6KKhpEdSNKVkjP/cZ+JDPIBCOFIxQgfNLr2aA7dkImdf6rEMwtarhaIeZ6P
	hIZKslgMFlCDlH2rjl8yKjdf/bqS6bT5FXzssgakZ7KL6EZ1AnpfEFSV6qAWfv+/
	TABHY0xFaI1XWFn608VcLP+FULKqAdF2GFQIETVGWTu8NId8pcDB2VqzTyc1JtHv
	2zpbxdZrhzivGFqoanyNxEwOSRSmIEx/UMOcPnk2K3mpn4tPKFIItF+bApxyf/tT
	DRu8pv/difE3IrA3QRt1QXipdgPElpDX5mk0ep7Sbg==
X-ME-Sender: <xms:0W_MZa7E-eDlmZS53lkLTi-_T_B3OZDodLNWzbtJIteUnw6VzwqHVw>
    <xme:0W_MZT4ua62NMMKhZQ29o0NLroGC32ELnGcCd_XZ7cv48ASQMhOkS4bjKT-e5M9wk
    SA5cfOCZZD5pz3NLA>
X-ME-Received: <xmr:0W_MZZe8tn7qmegqM29_9FVuhG3-QdDTiLH8yqu6hLcBkGxjR4kE3NthcQWDz3TcO_E2YLznczslsqVvV6XTIp_PGneqtcnAZeb1SITKs6AGLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeigdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhephefgjeeuveejteduhefgffefffdvjeefje
    eivdekfffgkeeugfehveetueefleeknecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:0m_MZXJiVTM6zHaYa2M-_d2wRLjQ2e9-OG39F6t1wroUCMvwmvpozQ>
    <xmx:0m_MZeIaKWuLVEtLns9u4u-CNHwaNMsvFuNNyfEZFkn2TOG3YSfxFQ>
    <xmx:0m_MZYwa5tNeHhCBJqknvDPlioDB1IzOCMZAvoyGryB4nwnHDScbeQ>
    <xmx:0m_MZQiK98ln-5gob31vDCHy4ABYgm8v3ZyVLEDtaaqNrMyDyC0w_ZyFI40>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 14 Feb 2024 02:46:25 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1b283d2f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 14 Feb 2024 07:42:35 +0000 (UTC)
Date: Wed, 14 Feb 2024 08:46:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 10/12] reftable/record: reuse refname when copying
Message-ID: <d7311598c0f81ad3fa41560b54b0974d41485a23.1707895758.git.ps@pks.im>
References: <cover.1707895758.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Azg2COj26aUFAmkq"
Content-Disposition: inline
In-Reply-To: <cover.1707895758.git.ps@pks.im>


--Azg2COj26aUFAmkq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Do the same optimization as in the preceding commit, but this time for
`reftable_record_copy()`. While not as noticeable, it still results in a
small speedup when iterating over 1 million refs:

  Benchmark 1: show-ref: single matching ref (revision =3D HEAD~)
    Time (mean =C2=B1 =CF=83):     114.0 ms =C2=B1   3.8 ms    [User: 111.1=
 ms, System: 2.7 ms]
    Range (min =E2=80=A6 max):   110.9 ms =E2=80=A6 144.3 ms    1000 runs

  Benchmark 2: show-ref: single matching ref (revision =3D HEAD)
    Time (mean =C2=B1 =CF=83):     112.5 ms =C2=B1   3.7 ms    [User: 109.5=
 ms, System: 2.8 ms]
    Range (min =E2=80=A6 max):   109.2 ms =E2=80=A6 140.7 ms    1000 runs

  Summary
    show-ref: single matching ref (revision =3D HEAD) ran
      1.01 =C2=B1 0.05 times faster than show-ref: single matching ref (rev=
ision =3D HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/record.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index e800cfef00..3f2a639036 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -205,14 +205,26 @@ static void reftable_ref_record_copy_from(void *rec, =
const void *src_rec,
 {
 	struct reftable_ref_record *ref =3D rec;
 	const struct reftable_ref_record *src =3D src_rec;
+	char *refname =3D NULL;
+	size_t refname_cap =3D 0;
+
 	assert(hash_size > 0);
=20
-	/* This is simple and correct, but we could probably reuse the hash
-	 * fields. */
+	SWAP(refname, ref->refname);
+	SWAP(refname_cap, ref->refname_cap);
 	reftable_ref_record_release(ref);
+	SWAP(refname, ref->refname);
+	SWAP(refname_cap, ref->refname_cap);
+
 	if (src->refname) {
-		ref->refname =3D xstrdup(src->refname);
+		size_t refname_len =3D strlen(src->refname);
+
+		REFTABLE_ALLOC_GROW(ref->refname, refname_len + 1,
+				    ref->refname_cap);
+		memcpy(ref->refname, src->refname, refname_len);
+		ref->refname[refname_len] =3D 0;
 	}
+
 	ref->update_index =3D src->update_index;
 	ref->value_type =3D src->value_type;
 	switch (src->value_type) {
--=20
2.43.GIT


--Azg2COj26aUFAmkq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXMb88ACgkQVbJhu7ck
PpSMDA//Qjmp2HU1UKIl83yLVbMr/AlVFUoZgpap8qfJFL8swQB46EO/ZR73hs9b
uN2d/WyiEuAU1ZSr0oJPf3ZWZTeLQuh613Zf97LrC9PBFz+451q31Wz5VHzeuejY
KHBDpBWP0GdxbmLzRO3PUPXZIL0NW07OLE5pRzmJkMNdzeTipusKm/TMvrqeqSbV
oUwknlVbMCxiIlKf6JEclD0tp8d6lsQ7E01VYhnredeeR+5S7KnMleuXVt7Aeykx
FXBa3VopILCZ3uusdF08av1Iv4C76fhJWzCxuepPbd28pv+B7bLsS5twvynoKUbe
docyAEPmWiRLb74d73i3t3IRL/XhNrmToYo+cCeIy+1LjgJa7Oj3kFQY3nnqZWZA
BqCwIVGL+iidH0VkCCezjKXevvrNy1tqCz1TiNKIwCZx/Hqvw4wTiiZVw81rN+q0
8wNSqJprPe0YdWiJJ9uGS1dUqrDbUwIRkBU0u7RGYmTsMi0ocZK0sao34gI3vMzx
H3X7TPK4gTnTIhyDKrDOOm9zYUpUcjWzLnQ3T/Sw66kMfYUOPDU+DeUTExXjij1g
03ZQnnv/Nkj23FvQwFArMqU8jetOYr/dJYrqQLt8eT8kEyGRdA2/WHk9Oj2z5VBc
TLhVueCvIXrM3OvWMR3iVPHXxxalMunBMRrySrQ28AvuBj8l0wM=
=rE5K
-----END PGP SIGNATURE-----

--Azg2COj26aUFAmkq--

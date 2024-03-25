Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C0819F538
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361460; cv=none; b=mibPwzVMUyniEgkpt1intmIFJGjKbV5e1DP5N1qFx0zDHftAJcGHgOrqV7AROKOKyY8hu3yysngq+CbPu4Ua7o6+OWW21Y5sNk5gC3k7KnJvHUdewzwkMecmu4ALDkE8l3mN7PfXH3qHgFzMUASU+pyZ0PLw0T/JLtDCtg/apjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361460; c=relaxed/simple;
	bh=PEjsrV73JvhMQMhOVhibN59d6+pevE6cZPYTJOUnzSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDQW1UQSLe1ILVkkWp6SEpelKYOXtVW7aSXCkv3bWm51sTgJbGtR18r6+se1RzUALnYXIMmsw0KkceFkvC64raFWNouHRjK81deUx151DgDcS+7GnGz/ydZ4kgavLcis4OkwUdggZcNeCe2XNuwpWoTiVSlolhyXrSkDYsqM+gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ANE/zHk5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=knDsNyp0; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ANE/zHk5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="knDsNyp0"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0F5551140105;
	Mon, 25 Mar 2024 06:10:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 25 Mar 2024 06:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711361458; x=1711447858; bh=pEnSqzHHki
	KdCthL1J2g0Ppr/oeSo1rFTCQkuf1jsGc=; b=ANE/zHk59APer/s6307sI9j22H
	3VR1DrhZomUxyCtN417MBhIbt3nvR3ADsfZKkkutQJaolywEH/nRU7J2fJKVoszq
	2AgmbFdoBHPAge7DhrW8YL64aGJ3lf5QHe8VU4/wj0wL0bDa/8pRvjSPDt4Z+vjA
	qG6HTRS9YQQi5JjjM6+7AoM+ENzIwXKUMx7mBmJbTDMrwC5mPTL9c1XprMbHzuMK
	O9W3J3O+ZvyF8dWCrUfy6otr9VRB3fv1Qg8n6eXQxCaG3Rg5yXOis+rCdLi+naMZ
	cLHvafCnhGDsBlVf0Ph3xe75IIlr1LBZsQcof52vW5BVU2YFTOyDsropCQ4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711361458; x=1711447858; bh=pEnSqzHHkiKdCthL1J2g0Ppr/oeS
	o1rFTCQkuf1jsGc=; b=knDsNyp0gC0DGrBMjqh+tvUwV2dSTLOIlAhaMCcnyqxa
	rOX63i9QMQXLxkmBd5XEQLlAHMUl/YFxzz+ZzctWcfVS6uSmAuq3A/0x1hRDxUW8
	1x6/3FI6omZQvkuSyPNZun/ZR0Jo3GTPTyHsGjXsxRG8GfZAwthmyPIPMRNsdfIt
	k0tYI/unnxuMh/QHF52K2SJKtN1SZAotH5pdcIrAEfjaKLY2yMxePtH2e831tA9k
	OB5yx0H96KbwCIw/a6o0cBZKbR3pBOZgvmSt3YhuYKI2BFMF5NSFCBmuINo4Bbyb
	lTAOxT2xa+inBfYCWt05PybY9PMUT7nEAA+zm2QUOw==
X-ME-Sender: <xms:sU0BZhIu2U6biBeXynHnnP4O66DNhDbachSYmneHI1MdYKyxTPEO3w>
    <xme:sU0BZtLlag5GbpmbZP5tve3dNiwZTy3br8UbdwCZnrbMQaw7T6z1bu9zAoqpPlSdX
    sFT5QMxu2mfkDrTQw>
X-ME-Received: <xmr:sU0BZpve9h7e9hTwFJS-w81U7E4nSHt3FssayAs-FG-vImJXlTAPVzIkszduaji6SEiGMMECbDujzWE4p5sQcY7b77p8Hqk5Z39_YQOwE-9hCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtledgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:sU0BZiZ24-C9gYI2o0W7Ntsoyv1jhTWaCIl5rwqdTnBBQP_uq8wFXw>
    <xmx:sU0BZoY2SzhBO381-NnESEi4kz-vcd2mArRDjorDsUG_VXd91o8Rvg>
    <xmx:sU0BZmA3cYMuXOp-DA74hn7BVXy-si-tWmV1PRYVQmzLG8tn_y5ynA>
    <xmx:sU0BZmZlEm71J6Kk36pWFZhmVCRFleXEEqc1Z--UH9tr2ML1TSI_Vw>
    <xmx:sk0BZgEphckvOZbrkhpnQMFbS5JmIdDcTQ-WARaYgFZY1T1hyxYM5A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 06:10:57 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c795c42e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 10:10:47 +0000 (UTC)
Date: Mon, 25 Mar 2024 11:10:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 6/7] reftable/record: extract function to decode key
 lengths
Message-ID: <271bacb210837ca4984155cbbc90915e9f2331c0.1711361340.git.ps@pks.im>
References: <cover.1711109214.git.ps@pks.im>
 <cover.1711361340.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wGsiJzAw7lwiudRV"
Content-Disposition: inline
In-Reply-To: <cover.1711361340.git.ps@pks.im>


--wGsiJzAw7lwiudRV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're about to refactor the binary search over restart points so that it
does not need to fully decode the record keys anymore. To do so we will
need to decode the record key lengths, which is non-trivial logic.

Extract the logic to decode these lengths from `refatble_decode_key()`
so that we can reuse it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/record.c | 34 +++++++++++++++++++++++++---------
 reftable/record.h |  6 ++++++
 2 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index 23b497adab..5506f3e913 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -159,26 +159,42 @@ int reftable_encode_key(int *restart, struct string_v=
iew dest,
 	return start.len - dest.len;
 }
=20
-int reftable_decode_key(struct strbuf *last_key, uint8_t *extra,
-			struct string_view in)
+int reftable_decode_keylen(struct string_view in,
+			   uint64_t *prefix_len,
+			   uint64_t *suffix_len,
+			   uint8_t *extra)
 {
-	int start_len =3D in.len;
-	uint64_t prefix_len =3D 0;
-	uint64_t suffix_len =3D 0;
+	size_t start_len =3D in.len;
 	int n;
=20
-	n =3D get_var_int(&prefix_len, &in);
+	n =3D get_var_int(prefix_len, &in);
 	if (n < 0)
 		return -1;
 	string_view_consume(&in, n);
=20
-	n =3D get_var_int(&suffix_len, &in);
+	n =3D get_var_int(suffix_len, &in);
 	if (n <=3D 0)
 		return -1;
 	string_view_consume(&in, n);
=20
-	*extra =3D (uint8_t)(suffix_len & 0x7);
-	suffix_len >>=3D 3;
+	*extra =3D (uint8_t)(*suffix_len & 0x7);
+	*suffix_len >>=3D 3;
+
+	return start_len - in.len;
+}
+
+int reftable_decode_key(struct strbuf *last_key, uint8_t *extra,
+			struct string_view in)
+{
+	int start_len =3D in.len;
+	uint64_t prefix_len =3D 0;
+	uint64_t suffix_len =3D 0;
+	int n;
+
+	n =3D reftable_decode_keylen(in, &prefix_len, &suffix_len, extra);
+	if (n < 0)
+		return -1;
+	string_view_consume(&in, n);
=20
 	if (in.len < suffix_len ||
 	    prefix_len > last_key->len)
diff --git a/reftable/record.h b/reftable/record.h
index 826ee1c55c..d778133e6e 100644
--- a/reftable/record.h
+++ b/reftable/record.h
@@ -86,6 +86,12 @@ int reftable_encode_key(int *is_restart, struct string_v=
iew dest,
 			struct strbuf prev_key, struct strbuf key,
 			uint8_t extra);
=20
+/* Decode a record's key lengths. */
+int reftable_decode_keylen(struct string_view in,
+			   uint64_t *prefix_len,
+			   uint64_t *suffix_len,
+			   uint8_t *extra);
+
 /*
  * Decode into `last_key` and `extra` from `in`. `last_key` is expected to
  * contain the decoded key of the preceding record, if any.
--=20
2.44.GIT


--wGsiJzAw7lwiudRV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBTa4ACgkQVbJhu7ck
PpS3vg/9F8/xjZ3hhoVHLOl8MCjzvknFicpa6vSFmtMzzTzM5E2w5jhFv+ichBzn
OJRAbRWYZvmT0uw1Ot1ya9qxNQpW3wud0kXELIWDGHSltldb/CGMRtmDnIaHw/5l
0UCcKyGX4Gr/+hj5wuZJEi2sS7UMDq2lVxPSyTIja8ZZv3SXS+b33xEYlO8kw/xZ
9pB8Oyv7za0Zgdn4foIHIGPHeKMPKdFj1AD6ngFs7XdcqnNnCHREFwvoMnFB6/O9
QK4P8DQyNcTf5g1TrlZ5mnl8Egwhyp7FdfiImJLSJdPW8VjpzfTvdcLx7yztfV8K
00bndAiQ6pR7FgPuGL2cn1gZUO57r0I4NLzBwSQZv2mCaHGCdQsG9Q0LZMGEeJfm
OrYP+KEJJvqFMyULiAzlMZ6XTICQT/URQKZbhLmTqVUKHY0CS8KBJ8ynzQ9r8s4R
HcVQRCSrkSfYx0ec0l5sTTBkUhOE+GH42VimHKfrVvgcCbfY9RjU/ng4t+/02hip
VqDCbZTcVl8qZiluRAxu4BVWbjE8wlBORo0DmdDGPRWFybSoRYkEetb7rd/1RVsw
9yhowgQvlGN48XZ3r2lUw30M8pDQdOT4HUrYMUYGMkK85GXhRX/uC1ZkzdVeQbgY
HD6vDLHE/EAlD4IFpcDbODhRB7AQWR0wGzZdNAWcbFRb7Z4MGTk=
=KPXb
-----END PGP SIGNATURE-----

--wGsiJzAw7lwiudRV--

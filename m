Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C4E4F211
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 06:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712124267; cv=none; b=mne6tsRw5D/qoJECwdC0Iidh8LI940aC2R9FR1zdDAB89COccsYegA3DiscauS+pJ34BYuS43m2e4kdTa9TBTT/NEvAMT55Xx3NHSwxIi2BHPObu8m1DCG19vOSs0Mgb2UsOThWdULf/8XJDyV7juaq71+8HpkNlm7f4c0fDlXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712124267; c=relaxed/simple;
	bh=fL8RgjOEf5feptyP6Pqcqe+Nkr2YC6uaTmV/oSINrUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQQKszCBsrfjTzuT5qnaHkxtgFGufr1eRrtfmNjBmKSyApWzDiV3eCP7cMAX33jaYwr7WOux2fVLTYwW8Z1f/+FSNNeewsXI14p941nLbK2M2taEuSc8jAodj2DY/YEBr/iqszrBy/7PrIsU3zJsSAmjlWecef1nyUNbZ48Yd5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i2ogyHZO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KR9+MK2P; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i2ogyHZO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KR9+MK2P"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id C7A3D5C0058;
	Wed,  3 Apr 2024 02:04:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 03 Apr 2024 02:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712124264; x=1712210664; bh=MYoYDCyRX0
	1gsLudcoSFhsEoS7u2hokagnZQDcuRM3A=; b=i2ogyHZOA6u4jGLrYbodfYmMWy
	3sWe4Ln56Xc8y6muEU/pr3dToizzj8MpPM3BLQi+zDO3YLwBvxQkQErMRkxByCRt
	mFslonIsbAqkVOiTPAX+YvhwoEUyGI4fin5j+bPBu5vekRZO17fSV8PaJSsg9aTC
	zsDd5AhQ1Lca4xWOIdSXVddZ7a4Zyh072DOq0nh0onFEh5FuPugQASne3qQerkLz
	VGUc1F2za+lGRZ3xYpwg8eHl+QWLaWBkwfygaJlQ1N+Ntm/sk68SWtcKMtp50Ldu
	bwKiKBr3uAD2w4ecpYnB2NzR5sX/7C9ToR7sxlVMUMX3b1L/CFZUEVwgfAEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712124264; x=1712210664; bh=MYoYDCyRX01gsLudcoSFhsEoS7u2
	hokagnZQDcuRM3A=; b=KR9+MK2PqiHCMvzi+JEsBTFW5aH90/+O2JV0kgxNxg+p
	jDoO2s2pv9z8wtE8CkDfwc+CyQBWpwElFey7cq0wusITp36yEu29VKpx+z22zu5B
	xH+4znSQKX9jDL9swsg8ZqL6Ya7dgfcJnE69lpDE6U2rvGqQM98zfX0/AKJATXF+
	5qUvjGgH2hXdMqfpGpY/19lRhoVRcnvPXRGLEKo8AJSoDN9IQFjtTFo7ml44dYIv
	QkNd8BHoJi9OTO+p2JxYVEb2jvQXJWuKGmNrEHxLap8Wq4y/ATcMlUE4Kbi/Svev
	IjMHZYXlWnRE3eEKjHV/tGnc56pd29p0eOXeflaOFQ==
X-ME-Sender: <xms:aPEMZqWz-J0bJ7ZfXMcCpX-Er1BHm8SYTy9ZDeNDq6Y4LRlM6FHDGg>
    <xme:aPEMZmnXXK4MbXIYQT7svC8Bdf2pnG1fEwb0iteWDBkzw5SxvF8vTAIdhyuyO5dby
    Cv-ze5OzqLtYcYuyw>
X-ME-Received: <xmr:aPEMZuZlPEH0sUwKCcYOLO_Guuq5eUOKVHVeIjzTa-oCpZ30X4VyFF6TDoStgJ0TB396JyKYqI4P6sLYr25c4Gx9A4tpnFqmV_n1Qkvt3yUzxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeffedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:aPEMZhVzL7MqWnfexNZnxJZaYyfgxHKFQEuzcCYkvyRm9j5xMAWnoQ>
    <xmx:aPEMZkmiOHZOjixqzI4-Lc_iGv2XxGsOGkq0tHageTFZMZcR6QiiZA>
    <xmx:aPEMZmdLHaIZSWQtfp2IESVk-x5Hb_MryjF9gH2-utj5N_ifjsk1BQ>
    <xmx:aPEMZmE2yZ-8_gXEKpL6RF0DAkKTtjyW2Tsbq6ucIJ82r8bLXXPRaw>
    <xmx:aPEMZugWJ9xNQGhtwPNRqIY02mRd6PDaSpBy1ER3KJaVagwi3sKZ0XVUxAvY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Apr 2024 02:04:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4b6ec755 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Apr 2024 06:04:14 +0000 (UTC)
Date: Wed, 3 Apr 2024 08:04:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 6/7] reftable/record: extract function to decode key
 lengths
Message-ID: <ca41ad30f46985c227a70cd11cc065363687c32c.1712123093.git.ps@pks.im>
References: <cover.1711109214.git.ps@pks.im>
 <cover.1712123093.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/xZtQmtau8MyFzuV"
Content-Disposition: inline
In-Reply-To: <cover.1712123093.git.ps@pks.im>


--/xZtQmtau8MyFzuV
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


--/xZtQmtau8MyFzuV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYM8WUACgkQVbJhu7ck
PpTCyRAAldNN7dqBuCNVIcOoglsm56LR/PEshkyLdOzClJAroC+Q7K0qO4dqsDfO
f8S0kCoKVmmneNVrj0J948S30M3I6VpWmMZeuvk01lBUV6Vs4Al755sJCL4p/TcA
g5Y4sI4G0RVwy197qZG39S7nL5CJt0aXflQSlgd9yxdFVdB0jzz7BQWdv0nQntXQ
zOBpvVT/0frPUrJV8H1fl1eKaW4xmBV6jhYZsNlHnupUNPocxO+FfWn4CJ9rgxR9
hBG2umo8ho2OV67y4SZ4iAyNjghimCwNjH29KFuRHSxheI+brPsOt4mlhvPXUWOE
6goB+fFFRwg/MLJm8dV98SdwZ8tkTSe1QjUHuEWASn/HBaWp3LNuvRarYR+LXrnT
IR30ukhEbMzKDZYfkai9CabgJhGvA3jaBArcIYXBKFhvJGwXJRHR6HA8FKUWfBb3
YVXeR5ueiuE4xJBKUlZWpOWRAshypJkCkbV+rCRPZQYirUtRpVBNeeaUawzhcC/4
ugVeA94nBXS5KX/+XqSvz42PkwwAE2cib7P6ZJzzFgM4pweuRAW/seLVGLRSCB7Q
Q3Ruf1PRMR8WCI7DCpnUpD0TH0hKh3kPKQfduBUzQC3b9N4efymMgUI8+By8TVGP
hTRBmKV1xMLfNYw7FXMVKvAWKrnvmtstG3mY3DbsGMDsOpgReCE=
=KQRE
-----END PGP SIGNATURE-----

--/xZtQmtau8MyFzuV--

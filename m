Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCE01487DF
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046424; cv=none; b=VItoEsB+4ZznDirtbux8U5dSb6qc/notCRTtv/J/blCcRRH6jl9TTd8H8+Tc33TN/mIlbxkKXqcq9dcJzMr0s15YQCCJRglGleoBgTcWeRjkVxceafMMO2c4CxzMfyfP5CiY+W9dgzFLICyV8EAhA/7ZcB1ybXldbFdC1eIfOVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046424; c=relaxed/simple;
	bh=bwxy3NdcIreWWmerl7X5jwA6Uv97oCQeHhUpLFiUpew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVw/7zsS0HqNJJUIx4W0EJuTd9ydbUtJCrzyS2wZCarX8ARBpWTsn5sgVBQjnIZ7RWciTibGLlvcGVFZwLeBYCnZrVSDTtEPPuy7KncGk6Fwpdx/i9Du9GQdFqTn2OQVRRsCvI+PpzNcto56qFraSeWcsme8tMUo0wfbmhJt+KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MrBcw///; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kwCmgCIf; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MrBcw///";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kwCmgCIf"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 1E43318000B0;
	Tue, 27 Feb 2024 10:07:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 27 Feb 2024 10:07:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709046421; x=1709132821; bh=JQ6Pf1c2wY
	Hysh3NOP66HAv0d4sUnT0xw/at/bnxjKc=; b=MrBcw///dSkVKt4nz43aGpM/2q
	Qsgj4HpS1B44JKEVI4Jbt1OIkBe9KyZ4csqgby/6jWZ8fUEi8hVQloVqwvyGseLd
	DVe3XBvBpEjzs5tpoUG+CSTBWzBnx5fbcbNmQO/hizBbTtxDJi0gd38HQzueX1Rh
	o+911Z2P89Fk5WMJG2gdOe+1V5omAixSqLmE3vIBR91ks73FGDGn+ibwQASGBtl4
	qY2HGTm22cB2ZTtKD82AkrY//t3yHZzN71ooXxwTpSeRRFypiuXhvw4vii7lmTiY
	2WO7LUsd1/LvQHUPVGYsK8XcMBObnXorr3rM2WpxAq5D8VMagMcULnKj7ZGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709046421; x=1709132821; bh=JQ6Pf1c2wYHysh3NOP66HAv0d4sU
	nT0xw/at/bnxjKc=; b=kwCmgCIf54YHL3F63vaDPn38WQUcDQK4/jwwlrBkV3LS
	MCy81zGrEDGHd0Iep19FbOtZZ0356tKhJ8+j1Edd7ALmqFojewusrHTVONmJLxG7
	G+s+MX4C3nnj+N/stlRwuoC8oycFapMqO+pDCJMZStt8uNMC3dUWD4qm5fK5425f
	j5Eod3daRsEaNxQCK5s2VCaB9/pOA09LITMO93OM2SA3ELCI2ODLKx7oHwjKemY+
	RBF5Yg0GbnzjOU5p76aHlH2DJDuBTJHyc7Fj0wmSU6jPyeFoQZYQKzToVeHfX9kC
	NAOFQRuLrWe8knuIzM1Nxx2fV0MUJ4bQqNGa8dxMBg==
X-ME-Sender: <xms:lfrdZdLWMpSTRckSuEwL5WQk8a7vIe9MFezcA2rT7rpBbMSFi9puyQ>
    <xme:lfrdZZI_NDTZZAsk8rX9P3o4TFcV3ZzqAGmvFU14RNWVokboJgQFR1oTJ77G_Njcp
    c0DMQDxa_RzsBKjZw>
X-ME-Received: <xmr:lfrdZVuVVFnwTMoAmzN3B-vetShB_bLPThZ9KZY2OyhOWbKDdyHaNbe7xpzQ4YlsyHzhjw46fyiilrKx5Vh90EZjxR0UmvvFK__h8dhfaL937SHz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeehgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:lfrdZebF-uUa0QXm3hgEcbbFQ0MurpEsNVnm25nSk-69oTcYIOvAKg>
    <xmx:lfrdZUar3lkdqMvyklPx71xpCHX99SHDVZ2IkATQuxdp1wrbxBdtkg>
    <xmx:lfrdZSBtHmtsOcQTAcQXfXPi62Yc-raFtj3HOCwhbOnI5NhQ2gpOuw>
    <xmx:lfrdZTmb_dl1cOUt3vX1RG2r602PrUU_mkZmmM0ljkoHCC5AX7_TSDu8UFQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Feb 2024 10:07:00 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ddfef1fd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Feb 2024 15:02:43 +0000 (UTC)
Date: Tue, 27 Feb 2024 16:06:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 11/13] reftable/record: decode keys in place
Message-ID: <d7151ef361c8433aff8c1d6e0729efeb487e3878.1709045927.git.ps@pks.im>
References: <cover.1707895758.git.ps@pks.im>
 <cover.1709045927.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xKfNnGFK627jwWNW"
Content-Disposition: inline
In-Reply-To: <cover.1709045927.git.ps@pks.im>


--xKfNnGFK627jwWNW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When reading a record from a block, we need to decode the record's key.
As reftable keys are prefix-compressed, meaning they reuse a prefix from
the preceding record's key, this is a bit more involved than just having
to copy the relevant bytes: we need to figure out the prefix and suffix
lengths, copy the prefix from the preceding record and finally copy the
suffix from the current record.

This is done by passing three buffers to `reftable_decode_key()`: one
buffer that holds the result, one buffer that holds the last key, and
one buffer that points to the current record. The final key is then
assembled by calling `strbuf_add()` twice to copy over the prefix and
suffix.

Performing two memory copies is inefficient though. And we can indeed do
better by decoding keys in place. Instead of providing two buffers, the
caller may only call a single buffer that is already pre-populated with
the last key. Like this, we only have to call `strbuf_setlen()` to trim
the record to its prefix and then `strbuf_add()` to add the suffix.

This refactoring leads to a noticeable performance bump when iterating
over 1 million refs:

  Benchmark 1: show-ref: single matching ref (revision =3D HEAD~)
    Time (mean =C2=B1 =CF=83):     112.2 ms =C2=B1   3.9 ms    [User: 109.3=
 ms, System: 2.8 ms]
    Range (min =E2=80=A6 max):   109.2 ms =E2=80=A6 149.6 ms    1000 runs

  Benchmark 2: show-ref: single matching ref (revision =3D HEAD)
    Time (mean =C2=B1 =CF=83):     106.0 ms =C2=B1   3.5 ms    [User: 103.2=
 ms, System: 2.7 ms]
    Range (min =E2=80=A6 max):   103.2 ms =E2=80=A6 133.7 ms    1000 runs

  Summary
    show-ref: single matching ref (revision =3D HEAD) ran
      1.06 =C2=B1 0.05 times faster than show-ref: single matching ref (rev=
ision =3D HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c       | 25 +++++++++++--------------
 reftable/block.h       |  2 --
 reftable/record.c      | 19 +++++++++----------
 reftable/record.h      |  9 ++++++---
 reftable/record_test.c |  3 ++-
 5 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 72eb73b380..ad9074dba6 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -291,9 +291,8 @@ static int restart_key_less(size_t idx, void *args)
 	/* the restart key is verbatim in the block, so this could avoid the
 	   alloc for decoding the key */
 	struct strbuf rkey =3D STRBUF_INIT;
-	struct strbuf last_key =3D STRBUF_INIT;
 	uint8_t unused_extra;
-	int n =3D reftable_decode_key(&rkey, &unused_extra, last_key, in);
+	int n =3D reftable_decode_key(&rkey, &unused_extra, in);
 	int result;
 	if (n < 0) {
 		a->error =3D 1;
@@ -326,35 +325,34 @@ int block_iter_next(struct block_iter *it, struct ref=
table_record *rec)
 	if (it->next_off >=3D it->br->block_len)
 		return 1;
=20
-	n =3D reftable_decode_key(&it->key, &extra, it->last_key, in);
+	n =3D reftable_decode_key(&it->last_key, &extra, in);
 	if (n < 0)
 		return -1;
-
-	if (!it->key.len)
+	if (!it->last_key.len)
 		return REFTABLE_FORMAT_ERROR;
=20
 	string_view_consume(&in, n);
-	n =3D reftable_record_decode(rec, it->key, extra, in, it->br->hash_size);
+	n =3D reftable_record_decode(rec, it->last_key, extra, in, it->br->hash_s=
ize);
 	if (n < 0)
 		return -1;
 	string_view_consume(&in, n);
=20
-	strbuf_swap(&it->last_key, &it->key);
 	it->next_off +=3D start.len - in.len;
 	return 0;
 }
=20
 int block_reader_first_key(struct block_reader *br, struct strbuf *key)
 {
-	struct strbuf empty =3D STRBUF_INIT;
-	int off =3D br->header_off + 4;
+	int off =3D br->header_off + 4, n;
 	struct string_view in =3D {
 		.buf =3D br->block.data + off,
 		.len =3D br->block_len - off,
 	};
-
 	uint8_t extra =3D 0;
-	int n =3D reftable_decode_key(key, &extra, empty, in);
+
+	strbuf_reset(key);
+
+	n =3D reftable_decode_key(key, &extra, in);
 	if (n < 0)
 		return n;
 	if (!key->len)
@@ -371,7 +369,6 @@ int block_iter_seek(struct block_iter *it, struct strbu=
f *want)
 void block_iter_close(struct block_iter *it)
 {
 	strbuf_release(&it->last_key);
-	strbuf_release(&it->key);
 }
=20
 int block_reader_seek(struct block_reader *br, struct block_iter *it,
@@ -408,8 +405,8 @@ int block_reader_seek(struct block_reader *br, struct b=
lock_iter *it,
 		if (err < 0)
 			goto done;
=20
-		reftable_record_key(&rec, &it->key);
-		if (err > 0 || strbuf_cmp(&it->key, want) >=3D 0) {
+		reftable_record_key(&rec, &it->last_key);
+		if (err > 0 || strbuf_cmp(&it->last_key, want) >=3D 0) {
 			err =3D 0;
 			goto done;
 		}
diff --git a/reftable/block.h b/reftable/block.h
index 17481e6331..51699af233 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -84,12 +84,10 @@ struct block_iter {
=20
 	/* key for last entry we read. */
 	struct strbuf last_key;
-	struct strbuf key;
 };
=20
 #define BLOCK_ITER_INIT { \
 	.last_key =3D STRBUF_INIT, \
-	.key =3D STRBUF_INIT, \
 }
=20
 /* initializes a block reader. */
diff --git a/reftable/record.c b/reftable/record.c
index 3f2a639036..37682cc7d0 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -159,20 +159,19 @@ int reftable_encode_key(int *restart, struct string_v=
iew dest,
 	return start.len - dest.len;
 }
=20
-int reftable_decode_key(struct strbuf *key, uint8_t *extra,
-			struct strbuf last_key, struct string_view in)
+int reftable_decode_key(struct strbuf *last_key, uint8_t *extra,
+			struct string_view in)
 {
 	int start_len =3D in.len;
 	uint64_t prefix_len =3D 0;
 	uint64_t suffix_len =3D 0;
-	int n =3D get_var_int(&prefix_len, &in);
+	int n;
+
+	n =3D get_var_int(&prefix_len, &in);
 	if (n < 0)
 		return -1;
 	string_view_consume(&in, n);
=20
-	if (prefix_len > last_key.len)
-		return -1;
-
 	n =3D get_var_int(&suffix_len, &in);
 	if (n <=3D 0)
 		return -1;
@@ -181,12 +180,12 @@ int reftable_decode_key(struct strbuf *key, uint8_t *=
extra,
 	*extra =3D (uint8_t)(suffix_len & 0x7);
 	suffix_len >>=3D 3;
=20
-	if (in.len < suffix_len)
+	if (in.len < suffix_len ||
+	    prefix_len > last_key->len)
 		return -1;
=20
-	strbuf_reset(key);
-	strbuf_add(key, last_key.buf, prefix_len);
-	strbuf_add(key, in.buf, suffix_len);
+	strbuf_setlen(last_key, prefix_len);
+	strbuf_add(last_key, in.buf, suffix_len);
 	string_view_consume(&in, suffix_len);
=20
 	return start_len - in.len;
diff --git a/reftable/record.h b/reftable/record.h
index a05e2be179..91c9c6ebfd 100644
--- a/reftable/record.h
+++ b/reftable/record.h
@@ -81,9 +81,12 @@ int reftable_encode_key(int *is_restart, struct string_v=
iew dest,
 			struct strbuf prev_key, struct strbuf key,
 			uint8_t extra);
=20
-/* Decode into `key` and `extra` from `in` */
-int reftable_decode_key(struct strbuf *key, uint8_t *extra,
-			struct strbuf last_key, struct string_view in);
+/*
+ * Decode into `last_key` and `extra` from `in`. `last_key` is expected to
+ * contain the decoded key of the preceding record, if any.
+ */
+int reftable_decode_key(struct strbuf *last_key, uint8_t *extra,
+			struct string_view in);
=20
 /* reftable_index_record are used internally to speed up lookups. */
 struct reftable_index_record {
diff --git a/reftable/record_test.c b/reftable/record_test.c
index a86cff5526..89209894d8 100644
--- a/reftable/record_test.c
+++ b/reftable/record_test.c
@@ -295,7 +295,8 @@ static void test_key_roundtrip(void)
 	EXPECT(!restart);
 	EXPECT(n > 0);
=20
-	m =3D reftable_decode_key(&roundtrip, &rt_extra, last_key, dest);
+	strbuf_addstr(&roundtrip, "refs/heads/master");
+	m =3D reftable_decode_key(&roundtrip, &rt_extra, dest);
 	EXPECT(n =3D=3D m);
 	EXPECT(0 =3D=3D strbuf_cmp(&key, &roundtrip));
 	EXPECT(rt_extra =3D=3D extra);
--=20
2.44.0


--xKfNnGFK627jwWNW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXd+pIACgkQVbJhu7ck
PpSoLg/+KvF9ZVEWtIL37aEkqzRSl02mCZoqB5CtUyspZPC6+SYgz3+VhFwDqwTy
k7TU21abYVsZWndm7wvOex9/COqFIiRZHZymDSJ/yuJJpRonSkZg89SL92C1yjdk
IBdWvCrIP+YHhw998XN54sE/jRIItl2WdF7EZNf0v9wFd1g3OzlNCfbULBI8eCgu
16yUMFujsNHbNbqgqQt1PXTYCXSm1skPWIduu5z4NI9x55uq3xttEWSuvj7UJI3H
q8x+K06ma4qW+vG4iCzTpiHzD5SfynCktCfXNEqYkG6wrFmARsz+NJOUM7hvb13E
re7aaQDh352lMCbU5NqkBzDEFEAUpyLgZhYbsSunoM9FSLPPaARZRjivz//tWAU3
AL9Iu5++8QelfzUeKIDAJ9Tk3sqOdSb6m5XFpY/YqoHTJZFZr48Ph6/1zNLS9ELP
qQQ4wIKo413ozLX1gfx2Y/geR90sf/MeGASmYTGevshSAzsGrVbrMHcEdOPIuHRH
9wc/ZNFgB6HWepBFQh7rEKb8SVa5GistBzAD1xqQoMiGXs/WtJVbMqd47nj9MJ3y
srA5JCJLBl20jSWq34RF/la2TLIe9409GQvqqDXPOgSyDPojx+nKkyP/kZ0JkeVC
jpzuHN+eq9Bl8CmRfhkhAr7DEsrxW7FJRnxmDEL1FG1GOs31sCs=
=0l+v
-----END PGP SIGNATURE-----

--xKfNnGFK627jwWNW--

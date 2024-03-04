Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A6A3984F
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 10:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549376; cv=none; b=azPcOL+MGAm65vRR21thk4GJr5yHVZPzGnkUOlWqb8GdO2VbDszm14A8+egSbqgU9wzXA5tLiXQED4NwUPQ61uM/0bA3iFCv50UAFAt/ZitjuhcygwFzPMfmiJnIZ2aFdbSZ5Ag+xiVMeS7rkf77NXC++QgmMQL3tEvyMGNTDCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549376; c=relaxed/simple;
	bh=2PgYCVgdi/n7NV7KFcaBxTss6u5AyoXHONPGzVIccec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsTheFVktW/XafVnVpe+v+8Kjp17537z+k24hZ96IBcZpkcsfTAcFD5eLZen8UqnhFHWqZKAkZRUEPsmGaewSqWFs46bp2AMNGAqxKNOkbkwZOJlzCpMovXFNhV8YU+5cNYDFSguB1AVavWTaMCQlqSzHQx38hiHTFWCkuvFZwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eq0NYZfP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hr0GLY0t; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eq0NYZfP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hr0GLY0t"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 4D27518000B2;
	Mon,  4 Mar 2024 05:49:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 04 Mar 2024 05:49:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709549373; x=1709635773; bh=E5rh+U5cRj
	sMVb0O7KGh1A7/n71x+t4lmtrVVzbHRNs=; b=eq0NYZfPrVVIKHs4jfqfVoG+Xg
	NAl3fUvpifv6AubOo3wEBJUpLR2pv35iV7N9zC8nr5AzXZBGqTs1YwOF8KHyHHjg
	teD3OiRj/chELiM/ary0Ee+fz1fkbKODxsyHNZ1L5qKQhpQd/Iauyn4leLT7bJLn
	DOaMmXr2ospIzj2egrmq8TGXG7n2/hvFoFkykOwI3/R1U5oqf2YnLFVDz6RgSfAl
	xPD0Y/AcmnbZRxVFvhRL1FdbMi1FoE7NcK+TgCN99joaCAz1DXYZKt/DsD8cfuKi
	QucKdSF5WM5DSvdRU5tlXnSv4/2EZ8+FrHtluu61+0fojoLQnQd46J2GSdpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709549373; x=1709635773; bh=E5rh+U5cRjsMVb0O7KGh1A7/n71x
	+t4lmtrVVzbHRNs=; b=Hr0GLY0tX6vluagDTTZXwCIuhhbWP9Af5dpyT4OvT1Vd
	x3fPwJp0F6Znl8qxu/7HY8oGZjbrd3b4z1zOhKNeTE9ehkQQvX1Esz3G5BgvkMJU
	soAYvra/8ZCqFpdFuiyeYThsCNXqndepw0EvSPSDW73hzycK2j1i7pkzsekfTJOf
	Ml/7yWrtHDVVwT7WIIxHV+JkrtdeIipvQolz8VrnusHfiAAQTaJBvWsu7BNsEg6Z
	ymktZ/G6RVBLkT+HnrufmUu2GfYR1tMhY2VOT2zVW8hvPQ7XUfaPjbpijlArYz5N
	O9waQ4+9Z+vLCD77RJdaFSYqm7uMb2BwGK02cCfbUw==
X-ME-Sender: <xms:PaflZbaJyf6hN0HeRDswR4Kpq5d3YSXWaGVohuf6JIdpFTxcaI_5gw>
    <xme:PaflZaZCR513goK0a8Lmi-3TvaZ4Adpxvr02Pws8tHIaYoB5v9krp076wmCUD-joJ
    8yz9SpZIwQI3WqpUw>
X-ME-Received: <xmr:PaflZd_coFkBd5qH-aYqPdTKnGrQXqmBjQgTWN_Hs1tcpgCqUwqSk59NOXE9fsaTmQkAezpFRtvMMoJNBhfAxYFuEYSWkR1wCO1rVGCgW_ItDzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:PaflZRrRZfSEpf_5ufTv-NQppKLO8DcS9Sisbktadjg9n2oRXRXXsA>
    <xmx:PaflZWoocxVEawR2J8Pav40fHLU1GkNwxInZHA-aHPzS0sYobymvtQ>
    <xmx:PaflZXQN9kZuJc0k-sjqCf53scqgiUvlSrmIbVKrXPx6uqTveWBwCw>
    <xmx:PaflZZUtf9tweYOCsu8acxZxpS1d_k_rTrdBSFmNHgsaTD3N7ePAewW_DqI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 05:49:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2202d46b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Mar 2024 10:45:08 +0000 (UTC)
Date: Mon, 4 Mar 2024 11:49:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, James Liu <james@jamesliu.io>
Subject: [PATCH v3 11/13] reftable/record: decode keys in place
Message-ID: <f7915f1df8c3fc1c25a5d7c52c8f9de87dbffc30.1709548907.git.ps@pks.im>
References: <cover.1707895758.git.ps@pks.im>
 <cover.1709548907.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nqnP2G1j/xZy8aYO"
Content-Disposition: inline
In-Reply-To: <cover.1709548907.git.ps@pks.im>


--nqnP2G1j/xZy8aYO
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
index 12a44f70e5..b9c6eee88a 100644
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


--nqnP2G1j/xZy8aYO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXlpzoACgkQVbJhu7ck
PpRcqg//a2laGu1+FHfwmVmwaqXfZBdlaD7LzVsv5O4fVzH4/+q+2jngGSFyPiEr
UmtbRbOv36bs4jx/i65X6Ciw946fd8kO/dqgzCtcrjHWYw2vXVQCFFVZ7Xg6HO8m
DJvWPAK3Zt+itjj0j+xnzyz0j5mZXezn7VOQkiZxjMvY6RhAdVV9ymZK5qsX7lfW
Vg9kRGl8LeSN95SRcDKEjdXPuoxdBQ2PscdYoYgOb3+FpWJj5dh+zH9hLCAwLx0W
dQqHqPjJtcig9NPQ9RDoBLYfWQFgcB712hTyWacn98hmn09KJWTl+jaXlVTFjgFo
Bo62raIayPoK3uXdUozHXtzDbDI9xIZuw+z2509I4YAKKZ0ig3ZLg+x/YC7QoooX
v+56ywhrR5kCOTgZfRQwHIa1HMhte3liEDIpiUMkpVs0bg8lC80Qdr1Avs8fpwMq
GuaBRYUeD2uXe3261bxTkL8/J1oauYAx0WT39hTw+DExBamneb2KNKM5fpRe9X5M
/8YAMXPOiZjX0qdctYx6KlrAdrAdML+8ryz1yBuxlwwrLnnEQICOXWTF1j2wspCN
tECijH33c6QQLTjB2yWfPKpNZn7CYOxBvvXSKuSqbhvbVZiYAbzyAUVLccMce5eS
AH4bZtvq5Fip6gxxBK99AYIBMzbpDO+PK2B6sfAOdzIogd5rcL4=
=HeRn
-----END PGP SIGNATURE-----

--nqnP2G1j/xZy8aYO--

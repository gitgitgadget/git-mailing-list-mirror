Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E4C17C98
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 07:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707896793; cv=none; b=RKKCobkljHsyCp5IWie1qU6q6e/ckKNbtTyH5txpVznXsvbillV6dL8PlyvwUue64K4wl7RW09R4pm+tuAMUf7/lR2ijiiIahpmX1qimxfzQmrKVCeKDP+jQi8OgVrwkAUQFunsokv3w9OcTRLcv9i5/p6LBPbFZYjn13i9Fsno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707896793; c=relaxed/simple;
	bh=5TD8+uj6sEL+WXfnhOcB7/4mwG2t2HyplzoLoaqpnY0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPwTlRoFWDTn8fRwPmYAdme1H/JpDiMsfz8v1C1m2V/N5gakayJw9DJcqGcEch5Gjj8cxLTGlDkxf0vQSxnrqcxi58gGsfXmXdqqXakRSQhkLg66DvLFMOjgcSXHPihHu7/eUgvmZzogz0LkUmyfgCx0XDiDSikl00cWCzPrfC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mEXJ5G5c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oSvdH/oa; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mEXJ5G5c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oSvdH/oa"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 2FE8C18000B5
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 02:46:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 14 Feb 2024 02:46:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707896790; x=1707983190; bh=GdJ8OdPv7V
	VLuipkGUIJ2qtYMm5n9XB0c1BjPq59wn8=; b=mEXJ5G5c/Gh1DfCb4MiqKIWEYx
	1ic4l3OOPL19RKJVoqdkE4lakuM0ulosxO8oQB+htp4+XLaiLoCckbcQVjDxedMf
	gbEtwO3TFdU2FK0xIlI+HTjPaZHRcGszMXFxwiRqgremoviIpfkgL9fzOUideet/
	ovwe/55fllS0oUv3zXrh867qPXeh6RDIQFHe/6O7uOuUXZBjhzOji3rSyhFd5bj0
	qGXV3ldD1M2iLENWSLa4H1h1ATIkSHXZTXtmIMhDT1wsu+kGy9Bgv8C+Prlw/x4f
	13bljszjx0jkR+dKBU3ZFrSGPpz7yQFT1RfZrfL3cialqEUvozxWsRxQWg9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707896790; x=1707983190; bh=GdJ8OdPv7VVLuipkGUIJ2qtYMm5n
	9XB0c1BjPq59wn8=; b=oSvdH/oa3jwQmmsXGHLySs4Fe03Ho55pf5mJQQe6YOk/
	YAx75or6FDrFA1dof0aW5Gyf7xBaK2gIOn3wKlvWq+tAvirqNA/yfrsrbtgS2ZXJ
	n2THWwCYKNa+IclFv5LN4iIfoujoFhfe0KwiP8kwK5iOxIsWIMq6nxXg2TdwTRQK
	6RViEdfUiotSAzwA2rPORsFedE7FtRDGZLtOTjJuvwQWQn5ddMM8oM6FiQNuWiYe
	+xCCfna/A2Wzi1PspEiud3kE0TJqE1czeQoi63lh1joInG8Pjv9Fxd0AiFicBKZs
	XBATnMIFYfo2+sotVB7vkuUtk6Gb1IIDkYy+cVHPNw==
X-ME-Sender: <xms:1m_MZdolCQQOHnAcgYBwunNijaUBEQdiS_S5qFg5BALhrp8PCOb0WA>
    <xme:1m_MZfoV1SgRWgAAtkA5GZYMTmJFDg8Pg3O2cY4V-HyvIcIm4quGti5UvgNULkmwB
    CHEr4H1yNoOosCY1g>
X-ME-Received: <xmr:1m_MZaNPUdpjA_06EE_SUavxdz8DvLR6aprGF1BLT1PoONjr_PR74WNloc30DX7Bul3AcmUzTU19HuHpRC7WQRVLxndGk6gBXKbx4EgQelsfcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeigdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhephefgjeeuveejteduhefgffefffdvjeefje
    eivdekfffgkeeugfehveetueefleeknecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:1m_MZY7GUgu6E22KuLlIZeFN14ZvI-Vj3jhFj-hNYneLqqqJvriMNQ>
    <xmx:1m_MZc7izZtLY8kQB4Jl_5-IZYBCvTXMi8D9fctHmH7KhEITSkFA5w>
    <xmx:1m_MZQhCPYsm0YfdKgNe1idrlYqh6bHhXAKzczA6ZIlE0FBEXBrRYQ>
    <xmx:1m_MZaTV2t6GHIUFhCg9I4ctGBUGbdvSXi1u0HyLdqzwXFgY0Bba9EPP6Pk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 14 Feb 2024 02:46:30 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dc786235 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 14 Feb 2024 07:42:40 +0000 (UTC)
Date: Wed, 14 Feb 2024 08:46:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 11/12] reftable/record: decode keys in place
Message-ID: <f0663c1d62d13d01afb1fa6c3760a38741bdfc8e.1707895758.git.ps@pks.im>
References: <cover.1707895758.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+KoSZVUkCSZokNFh"
Content-Disposition: inline
In-Reply-To: <cover.1707895758.git.ps@pks.im>


--+KoSZVUkCSZokNFh
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
2.43.GIT


--+KoSZVUkCSZokNFh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXMb9MACgkQVbJhu7ck
PpSFtg/+LWwFT3Z34HAbMa2posvOyZyZnhJe2h9+uordgeMHFxD0IPQLsfoG2uxI
X5mTq1LjcPBlCNammzm86gWHLS/LmCSd2EieuKkYZKu3oTgIFRYUEGxEiznuQI7h
VOIgLPlArBE8EDmbKamU8f3vdQjsPt/846V9KC1no6Y1bDRN1VTGRsxhWWlQO4t4
eGG2C9PkHarETNgenC0/mp+QlvCOq4a/gFfyFYbOqV9xiPoeg+FaFDmZjhyR7Sg7
inAA1WpFgZCt9XAsrcJYMdyxnKChkIjzM/CUw8BsrRtQrGwZl8ljLFoiDsO/yrku
3EvqL2e8Pk7vAJxrXxJNULTz1dl0DM6EkTpSNO5FWJrNsrGYuEjaDh8coAjEzbBY
0+YGbHdjtAPXCauQjl7Twg/CpOiWomnZ9+rtvIIzVIvavPYkwKwMYtj/qyVKZERa
7g8yqBNdePQTN3OIb0HcG0HLky7yQjgTUEZ9KYHbimzhLZ3MWnMiJzWWx2z1n4LU
iY3PdnvKkCsenHtiaOOJ/ekTEKGv0AuhMMx4XLx2qMSxHRHnx6bFyDDz0qbhO75x
f3SMsfRjhmrpIz7ArruL7e3YGgdikYMvV1On2rjJhWOWylKUzZf7hADoHn+cm5WE
1i2c2OsCMQIJTm62+FixPUo0QzIUZk5z2/8lFiYGEUWch/DabbY=
=//Gi
-----END PGP SIGNATURE-----

--+KoSZVUkCSZokNFh--

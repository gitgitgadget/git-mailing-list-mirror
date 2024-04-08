Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB17A6E61B
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 12:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712578597; cv=none; b=mAXxrWgsHe4woBgeJab901GuJkoZ9LcBa1nXWv+zrCRPa0igpvh10gWVCY4YRexTi+qWxEvaP/flYo0HQ9abpd54muuIedhS36SIRbR53BZvVzwaCTT1tGitDxxi3HxmnXTXPzAtQIZGRKXoRD/MD6T+AxTBimVv7Lq273M5dOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712578597; c=relaxed/simple;
	bh=5WjwbG8avMh+0Gv4XE7sqUqBLXTY2IUuc6aU/pQYonE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDdYLxW2qvXKNoO5dTVvGlnZL8BWTag5kCXvnj25Lj9Zi+rBS5Zm0QIAa+E2sugYKa02eNBQnnuMcc3JAOw261N5mQrS34WX3GGQQiEojbHPI/p6ZWa4Li+XeeXUzXyXtgEXiCzneZvl4gZZ08Hn5NE0JsaRTL4v2BhiG+NUJy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j+7aTqdn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZeBr2zNH; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j+7aTqdn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZeBr2zNH"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id BCA851140095;
	Mon,  8 Apr 2024 08:16:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 08 Apr 2024 08:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712578594; x=1712664994; bh=Tzgy1xmN9Z
	42XI6TaI6KZxBSCDjcNLTNSVtKcZT0f3A=; b=j+7aTqdngUbUi/7Q1XJ/XgW4OW
	qbY1J+z3yMaccKds18LaEjOni/I5MAdZ1EPNadt3r5JTG3v5fJDq6CWbU0HvGDqs
	mPAgQP/3knf2+qqv+XFX8BTsltaSw8a+BLFRhH7rdUZ5iMo7bCKCsjhTtvGWUres
	kM11hFuq/R/yaMtDO+k07gsBopSqFa0DcQQ+XZnPI8BYYNtAIS9RvAwzc09KN4Mz
	0CoEZDSZMcek7rgT/DnzpD+Lv2tjLsLvgl4Tuu1l73X/bTJP3X3e6U59tsA2v9C3
	OGp1Su8yFx5OfJHvakSodGl6xGSYLLebGp6jdcb2RO/6pxxmmDGYFO8x5Htg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712578594; x=1712664994; bh=Tzgy1xmN9Z42XI6TaI6KZxBSCDjc
	NLTNSVtKcZT0f3A=; b=ZeBr2zNHna4KK0mIedqHKsYHMQ3+oiufivl/KUWGEe57
	a+FyCTixGQSHauHOf5FNXVHftHWr0axQjc47tzlYnmOCZizEEBwxOTs8XaM516P0
	6MYD85JmosquWz8KvgPyVMUa2vSeRg/JxolulN7CoVh5hmaup4pF8QwMYiwE+D3t
	1otJ44JzccyVJ9nfV1FQ70naQ0GSzgbI2n9OfvbYp2stDOlqiEA2qinnIlhh1jsk
	drBaMFXyPKVmW7viHDU5S9oV7fYMogaVoBVS6bP8d21WYU8hbG14SjDWGtzgDtnR
	Ke7wolBljNRn1xFUg5gjeJmeBVKuwhUSop5qQpbX1g==
X-ME-Sender: <xms:IuATZm6dwWZ7Ga6HwaY2cE5mu27CXyhReK6da0j0ocyKBXMUd_m1xw>
    <xme:IuATZv73PoFQYTmO9BhZqjVs9EDFSyXhN34kEOn71Ayri-8psFqzjOp5sKJdMo9_I
    bIRsu5FIROYndyPTg>
X-ME-Received: <xmr:IuATZlcjJnRgg635_MN4P_0QMVjc3zT2VrJuIrQlG-F6F5oRHm2Ir3rW4j3TJ0J60wkESBy6Ka3d6nSz74nv5rb0iuaNdMK5fv65VLaNWL-_W7sMZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegiedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:IuATZjKiFAObtt6E-zz5dvvAt3HJBsr6hnEULcAhIRBIR-a_k4t7dw>
    <xmx:IuATZqK_3feWJTHSoP5vg4LLG47bg04IyrqeXrfK3sYycwIeSHK5ag>
    <xmx:IuATZkzA1Gma2_vPuxPEXkf6Sy6_FlqkeeZ4tFhJPQtF6hYeMkTPHQ>
    <xmx:IuATZuK5B9VkY23fk_eeEX_80QXFYNCvwTAUUQN25qLtbHJjMzPjoA>
    <xmx:IuATZvHiDdN4UNAmqIkufxdSN3DX0iIZDeBs9FQ5G1nju_3DNyD2jD9w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 08:16:33 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 925ad9ec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 12:16:27 +0000 (UTC)
Date: Mon, 8 Apr 2024 14:16:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 02/10] reftable/block: merge `block_iter_seek()` and
 `block_reader_seek()`
Message-ID: <d0b318b8ee33b6c8c749dcb5781b9dd37f00ed44.1712578376.git.ps@pks.im>
References: <cover.1711519925.git.ps@pks.im>
 <cover.1712578376.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="USaj1G0QV7r9Pa/C"
Content-Disposition: inline
In-Reply-To: <cover.1712578376.git.ps@pks.im>


--USaj1G0QV7r9Pa/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The function `block_iter_seek()` is merely a simple wrapper around
`block_reader_seek()`. Merge those two functions into a new function
`block_iter_seek_key()` that more clearly says what it is actually
doing.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c      | 9 ++-------
 reftable/block.h      | 7 ++-----
 reftable/block_test.c | 4 ++--
 reftable/reader.c     | 4 ++--
 4 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 53ea92d04e..1015f9c04c 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -373,19 +373,14 @@ int block_reader_first_key(struct block_reader *br, s=
truct strbuf *key)
 	return 0;
 }
=20
-int block_iter_seek(struct block_iter *it, struct strbuf *want)
-{
-	return block_reader_seek(it->br, it, want);
-}
-
 void block_iter_close(struct block_iter *it)
 {
 	strbuf_release(&it->last_key);
 	strbuf_release(&it->scratch);
 }
=20
-int block_reader_seek(struct block_reader *br, struct block_iter *it,
-		      struct strbuf *want)
+int block_iter_seek_key(struct block_iter *it, struct block_reader *br,
+			struct strbuf *want)
 {
 	struct restart_needle_less_args args =3D {
 		.needle =3D *want,
diff --git a/reftable/block.h b/reftable/block.h
index 44a9a8de7d..1734bee917 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -101,8 +101,8 @@ int block_reader_init(struct block_reader *br, struct r=
eftable_block *bl,
 void block_iter_seek_start(struct block_iter *it, struct block_reader *br);
=20
 /* Position `it` to the `want` key in the block */
-int block_reader_seek(struct block_reader *br, struct block_iter *it,
-		      struct strbuf *want);
+int block_iter_seek_key(struct block_iter *it, struct block_reader *br,
+			struct strbuf *want);
=20
 /* Returns the block type (eg. 'r' for refs) */
 uint8_t block_reader_type(struct block_reader *r);
@@ -115,9 +115,6 @@ void block_iter_copy_from(struct block_iter *dest, stru=
ct block_iter *src);
 /* return < 0 for error, 0 for OK, > 0 for EOF. */
 int block_iter_next(struct block_iter *it, struct reftable_record *rec);
=20
-/* Seek to `want` with in the block pointed to by `it` */
-int block_iter_seek(struct block_iter *it, struct strbuf *want);
-
 /* deallocate memory for `it`. The block reader and its block is left inta=
ct. */
 void block_iter_close(struct block_iter *it);
=20
diff --git a/reftable/block_test.c b/reftable/block_test.c
index a719be7c50..26a9cfbc83 100644
--- a/reftable/block_test.c
+++ b/reftable/block_test.c
@@ -89,7 +89,7 @@ static void test_block_read_write(void)
 		strbuf_reset(&want);
 		strbuf_addstr(&want, names[i]);
=20
-		n =3D block_reader_seek(&br, &it, &want);
+		n =3D block_iter_seek_key(&it, &br, &want);
 		EXPECT(n =3D=3D 0);
=20
 		n =3D block_iter_next(&it, &rec);
@@ -98,7 +98,7 @@ static void test_block_read_write(void)
 		EXPECT_STREQ(names[i], rec.u.ref.refname);
=20
 		want.len--;
-		n =3D block_reader_seek(&br, &it, &want);
+		n =3D block_iter_seek_key(&it, &br, &want);
 		EXPECT(n =3D=3D 0);
=20
 		n =3D block_iter_next(&it, &rec);
diff --git a/reftable/reader.c b/reftable/reader.c
index d7d47e8640..f70efa2b7c 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -483,7 +483,7 @@ static int reader_seek_linear(struct table_iter *ti,
 		table_iter_copy_from(ti, &next);
 	}
=20
-	err =3D block_iter_seek(&ti->bi, &want_key);
+	err =3D block_iter_seek_key(&ti->bi, ti->bi.br, &want_key);
 	if (err < 0)
 		goto done;
 	err =3D 0;
@@ -558,7 +558,7 @@ static int reader_seek_indexed(struct reftable_reader *=
r,
 		if (err !=3D 0)
 			goto done;
=20
-		err =3D block_iter_seek(&next.bi, &want_index.u.idx.last_key);
+		err =3D block_iter_seek_key(&next.bi, next.bi.br, &want_index.u.idx.last=
_key);
 		if (err < 0)
 			goto done;
=20
--=20
2.44.GIT


--USaj1G0QV7r9Pa/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYT4B4ACgkQVbJhu7ck
PpRepw/+O7hOexSJxFiSJ8K61DZAwAD0J2hvjma4RHVMJGUvPH5cHNSArts7yR1p
r9w8Kb49n9nqkF09mRVuUA9DHhZFwnBHIj3VQGHjTmUXuNiTKaz6Q8Jeum+JERY9
Y9hQ3e5tLkhW7L9ECNUk3MEyCH9EsFtFHOUc7nrqJFI1F8m1Z71DGzPAVD4GdtV+
35Hzh78yaBWk01TcN4HwbHZ2YJ1e69VYEQ0865ZIlKXFeU9P5nZC3D2y+BjGv+L+
kf4MveEdPLqDPJ5bcjvTGvHAyv5g+Uxa/ZnevlmFbbNdJFn13eZtzvWGvbG1xQsy
p83eZul3jg+XHe8mZjt70DWhzi6MIo6oL+4QeABkOud/ZHoRQBTTBRvInAWg5bpO
uxcKt3+uEKpStYEcCWleZKynz4FuFnnE6X/kQiU2/kD4qAHt5VXblpq7KkQN0NpW
xInKX3r24VATjh6Byqc8ohE5DnUYNUBHdtjUuFlICVSHBl2fRwsW7VgY74N4ML8U
w8LACK7UVrpbqpLG9qXhMqdbhI1ExkLY/YkFxYfcQ7x8Pw9g/UkWMVqvZLLFCUA8
u5TBbdlr8csX4CdVXYNwLALARDsbd7XG7xSkCD8A4kMCnezoWeSLwg/MRn1biWQI
CA7v780h82Pg1sBouHjV0RvbAZVEW9kGw5L0aiZTEl01tV4y3Fc=
=vwu9
-----END PGP SIGNATURE-----

--USaj1G0QV7r9Pa/C--

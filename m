Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC9614AD3D
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 17:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079022; cv=none; b=BIMyefVs5tPTkFaW4tM5Sd7jnQ+PhhKwN4Sozf6hScGytGAT8o4qGhhjalI5zUTOtW6LoWtMLq20jgxWVMUx5GhcS9e7j6jRk1rtTcW/er0FI405+H8tfIojNBp9XC9XtMQdYyc/FbJ/80WUzGFVkd2tYyGcJWHNAjbZyz+92vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079022; c=relaxed/simple;
	bh=oNvdo59gdRlreUsIDGa4sWmcR+O58OIdbW+Cn2ip/mA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFELgLyACZG4u0n0vL5BJPkXNRh5nl1wfCrVz2gLLi7X72mVaFuRKVWpGTxigtrbwU2jq9CFPpYxFeXeaapYW6QLETUcRn4NgCQgABXxYf925ryix50JTvoZR67FMu0FYFW3gxckoOMaWjJGInA8sj8uPEGneOS3QIuNKuFod/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mLO1fQDm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hC3m05rl; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mLO1fQDm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hC3m05rl"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id DADF03200302
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 13:30:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 02 Apr 2024 13:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712079019; x=1712165419; bh=bgXJo5hb6y
	Kd0qB13tBTisTr3p7+/CTng2jSAdhAaaU=; b=mLO1fQDmfuvBX+g52SXd8sLywS
	Vs1OChyCVpcgO5MAwMmcrBEUdorY/ypmgxNf41XgGibJpqq+y5Oecw7nwQAQmBG/
	9Ts9/OmVioOctVSI3F9KD022KJSgtzZyj1NADPEdXh2aDKZgR4X1MlicUb8lMV1T
	d3BTcwkGcIX0JBS3Cb0gAuBK/ecDY3x1EzAoZMl5HMu6dwkrzKurVI5Mg4VWMvSS
	8L8u1iJ0FBKAegtZBgVbVipCTzZbl9BmDNKk3HcVXFj0E5b770UvIuqxABbu8lcd
	wyfgdAtnSxuYxvXGunlo9soiWC+Tvl3yxuRpiGaq2hcDuOAnAoxIoS1DR24Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712079019; x=1712165419; bh=bgXJo5hb6yKd0qB13tBTisTr3p7+
	/CTng2jSAdhAaaU=; b=hC3m05rlK44xVwRG/pXWpgU4ufmcakMb4oQCytU8pj+L
	ZLqqc/vClXuAnwAzpx645KKkVSLHkYcvxU/CC2mGmfEeNcbhVvd58OSznk7mnxRF
	Oc78Qi2UvU6SvUsUSR97n8VcKp//OY+fJHAQIxOCOzpgS8LA8bG1FgtWnsVBl99U
	PPIw/6lrFTfqUIO+vsbqj/fbWuwKdCi7TKO2b4qDc1acRWImqfWmoBJVyOn6cypM
	oGp4MpKu5ArGwWnMiUOS+siwrwoTbUjjW28u04W01aK0dnhaplH4SXogR8yjjOOn
	nqeAwESlMJPPMpIByGPimgKEael7tVU4ddHUlvzEeA==
X-ME-Sender: <xms:q0AMZn7sEZb1HJt_BsnNieFIcgE3t_ZUHD5Ly9hzzYXW4dk0PTa_8Q>
    <xme:q0AMZs4BOZBzAKI79nppfHTQ3MXuElj89m4VO7aOBTXu_rWF_ARzHknnT3Lt839N2
    pqlvYr0VT6_QW-whQ>
X-ME-Received: <xmr:q0AMZucwLeXClvNkNbfZErxMnMfo9JJmJmBqYEzEgZgDAtsd_l8OXgQvS0_-UguezRKamEo-1MXdg1o1jNhUJuqhxSx_B5ezMNBfrOyvRWQIylg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:q0AMZoLIBNrA3tjnOem9br_zH7m2_Oac5ZwOMfX2LIj1JPGwaNfkxg>
    <xmx:q0AMZrLvSfDjljfGm6bhXTGMDSiZJFp4VKEizUDWdfebM_Mua-IGWA>
    <xmx:q0AMZhyX05F3KP4DnfgwK1j03guIX_8PPbapSTLS4cOqAqLwYZcoZw>
    <xmx:q0AMZnIQSDkhomE-7b3efben8Y9tYqBJhr5DMMqQQxmtDu9t3VIhfA>
    <xmx:q0AMZiWB7NQfPtcTuVN0xghYKQJUqgR6GLPgg5CwoPNTiTHnNaaVkW6J4dNi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 2 Apr 2024 13:30:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id feacedce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 2 Apr 2024 17:30:09 +0000 (UTC)
Date: Tue, 2 Apr 2024 19:30:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 7/9] reftable/block: reuse zstream when writing log blocks
Message-ID: <86dab54dfe4501dfa5e50e5a01513c890b62bb4d.1712078736.git.ps@pks.im>
References: <cover.1712078736.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XIY2SaMrDKxr215I"
Content-Disposition: inline
In-Reply-To: <cover.1712078736.git.ps@pks.im>


--XIY2SaMrDKxr215I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While most reftable blocks are written to disk as-is, blocks for log
records are compressed with zlib. To compress them we use `compress2()`,
which is a simple wrapper around the more complex `zstream` interface
that would require multiple function invocations.

One downside of this interface is that `compress2()` will reallocate
internal state of the `zstream` interface on every single invocation.
Consequently, as we call `compress2()` for every single log block which
we are about to write, this can lead to quite some memory allocation
churn.

Refactor the code so that the block writer reuses a `zstream`. This
significantly reduces the number of bytes allocated when writing many
refs in a single transaction, as demonstrated by the following benchmark
that writes 100k refs in a single transaction.

Before:

  HEAP SUMMARY:
      in use at exit: 671,931 bytes in 151 blocks
    total heap usage: 22,631,887 allocs, 22,631,736 frees, 1,854,670,793 by=
tes allocated

After:

  HEAP SUMMARY:
      in use at exit: 671,931 bytes in 151 blocks
    total heap usage: 22,620,528 allocs, 22,620,377 frees, 1,245,549,984 by=
tes allocated

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c  | 83 +++++++++++++++++++++++++++++++----------------
 reftable/block.h  |  1 +
 reftable/writer.c |  4 +++
 3 files changed, 60 insertions(+), 28 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index e2a2cee58d..1fa74d418f 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -76,6 +76,10 @@ void block_writer_init(struct block_writer *bw, uint8_t =
typ, uint8_t *buf,
 	bw->entries =3D 0;
 	bw->restart_len =3D 0;
 	bw->last_key.len =3D 0;
+	if (!bw->zstream) {
+		REFTABLE_CALLOC_ARRAY(bw->zstream, 1);
+		deflateInit(bw->zstream, 9);
+	}
 }
=20
 uint8_t block_writer_type(struct block_writer *bw)
@@ -139,39 +143,60 @@ int block_writer_finish(struct block_writer *w)
 	w->next +=3D 2;
 	put_be24(w->buf + 1 + w->header_off, w->next);
=20
+	/*
+	 * Log records are stored zlib-compressed. Note that the compression
+	 * also spans over the restart points we have just written.
+	 */
 	if (block_writer_type(w) =3D=3D BLOCK_TYPE_LOG) {
 		int block_header_skip =3D 4 + w->header_off;
-		uLongf src_len =3D w->next - block_header_skip;
-		uLongf dest_cap =3D src_len * 1.001 + 12;
-		uint8_t *compressed;
-
-		REFTABLE_ALLOC_ARRAY(compressed, dest_cap);
-
-		while (1) {
-			uLongf out_dest_len =3D dest_cap;
-			int zresult =3D compress2(compressed, &out_dest_len,
-						w->buf + block_header_skip,
-						src_len, 9);
-			if (zresult =3D=3D Z_BUF_ERROR && dest_cap < LONG_MAX) {
-				dest_cap *=3D 2;
-				compressed =3D
-					reftable_realloc(compressed, dest_cap);
-				if (compressed)
-					continue;
-			}
-
-			if (Z_OK !=3D zresult) {
-				reftable_free(compressed);
-				return REFTABLE_ZLIB_ERROR;
-			}
-
-			memcpy(w->buf + block_header_skip, compressed,
-			       out_dest_len);
-			w->next =3D out_dest_len + block_header_skip;
+		uLongf src_len =3D w->next - block_header_skip, compressed_len;
+		unsigned char *compressed;
+		int ret;
+
+		ret =3D deflateReset(w->zstream);
+		if (ret !=3D Z_OK)
+			return REFTABLE_ZLIB_ERROR;
+
+		/*
+		 * Precompute the upper bound of how many bytes the compressed
+		 * data may end up with. Combined with `Z_FINISH`, `deflate()`
+		 * is guaranteed to return `Z_STREAM_END`.
+		 */
+		compressed_len =3D deflateBound(w->zstream, src_len);
+		REFTABLE_ALLOC_ARRAY(compressed, compressed_len);
+
+		w->zstream->next_out =3D compressed;
+		w->zstream->avail_out =3D compressed_len;
+		w->zstream->next_in =3D w->buf + block_header_skip;
+		w->zstream->avail_in =3D src_len;
+
+		/*
+		 * We want to perform all decompression in a single
+		 * step, which is why we can pass Z_FINISH here. Note
+		 * that both `Z_OK` and `Z_BUF_ERROR` indicate that we
+		 * need to retry according to documentation.
+		 *
+		 * If the call fails we retry with a bigger output
+		 * buffer.
+		 */
+		ret =3D deflate(w->zstream, Z_FINISH);
+		if (ret !=3D Z_STREAM_END) {
 			reftable_free(compressed);
-			break;
+			return REFTABLE_ZLIB_ERROR;
 		}
+
+		/*
+		 * Overwrite the uncompressed data we have already written and
+		 * adjust the `next` pointer to point right after the
+		 * compressed data.
+		 */
+		memcpy(w->buf + block_header_skip, compressed,
+		       w->zstream->total_out);
+		w->next =3D w->zstream->total_out + block_header_skip;
+
+		reftable_free(compressed);
 	}
+
 	return w->next;
 }
=20
@@ -425,6 +450,8 @@ int block_reader_seek(struct block_reader *br, struct b=
lock_iter *it,
=20
 void block_writer_release(struct block_writer *bw)
 {
+	deflateEnd(bw->zstream);
+	FREE_AND_NULL(bw->zstream);
 	FREE_AND_NULL(bw->restarts);
 	strbuf_release(&bw->last_key);
 	/* the block is not owned. */
diff --git a/reftable/block.h b/reftable/block.h
index 47acc62c0a..1375957fc8 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -18,6 +18,7 @@ license that can be found in the LICENSE file or at
  * allocation overhead.
  */
 struct block_writer {
+	z_stream *zstream;
 	uint8_t *buf;
 	uint32_t block_size;
=20
diff --git a/reftable/writer.c b/reftable/writer.c
index d347ec4cc6..51e663bb19 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -153,6 +153,10 @@ void reftable_writer_free(struct reftable_writer *w)
 {
 	if (!w)
 		return;
+	if (w->block_writer) {
+		block_writer_release(w->block_writer);
+		w->block_writer =3D NULL;
+	}
 	reftable_free(w->block);
 	reftable_free(w);
 }
--=20
2.44.GIT


--XIY2SaMrDKxr215I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYMQKcACgkQVbJhu7ck
PpSpDg//QHaW9dt4bRGuMRy6TIOqTQ4x9Y5IiroQHmfAE3VhfZvZQpZm4GrpkThZ
I8It7aOnPwlYBojruyAXSJJt02XluzUr5wJGUW6pLrBj2G1U1RJCgb41DcQ6l5vD
V5c/pbq4LgjNNnjQ/EZb6GOWQEA/hfxBkrUEiDVURl/up6XfRo6VtU0iVY2mk/2f
FuznqNyPTzrWynAkOkgzZ62d1kAjbuQ81yDERDPG4OM75M5PLvYjyKrlzbnMV5+v
ZlnP+uSxwKNQ+SkLmlnKTlyAbo2LEPc6jNJ2ZjLvfMEn+LzXO77ESuhz4f1tW4tt
bkr7Disoo1JZPZA3l2J92IpeFHOreaE2ehTdIAXatgedY0sPN/hgX0eY3cgLHexJ
/lBf8YON8rwhumyjUdLDBIZZO/vxYYVtQ3CyEnwH/lqp3BS80hoiXFV9HvKz+pUO
YF7wCBpfF1YTlKd4500Z07YZH1L3wJRXC5A5yUigYjhib1U4zpCN2KunZChEDNfs
c88t7CfxQ0NrtSZO7/B22zdEY0wiAyyYHb0Kug8+iuEgnei7PhtQlXvszVBcG/CV
sEuX88zcwO8Wfne8CmGNEOFmWH1LOx3zxW439pf/p528VOWTQYnURBd9LToh2quc
at5w/lP2LVnZz5FT80s0yCb6xqelv7MmXJcdPCbXkM1IpvOGOMU=
=tzRX
-----END PGP SIGNATURE-----

--XIY2SaMrDKxr215I--

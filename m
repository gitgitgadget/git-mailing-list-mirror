Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1558B22611
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 05:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712209731; cv=none; b=gjnVRAMYpMd5UVl37Ewu3JuPydxf1zDjPMUzKMhESty96WXWAuFq6X7jJm93cO5XD9X8fLvZw2vtgqSNWRaVYPpcoz+73XqGVmV/giL9PvJtWuegGt6pzKt9C9++HpmvodOdkcWhqvAKx6xyEtEZABCXjHbK4eeAld5V2bZG+Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712209731; c=relaxed/simple;
	bh=ggFMAx+8ys0v5Xu6D48UYYtRIQsoiMy8skCH0nFLSuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6HY7COjP7d9NerTPZT7bcJ6+WXrf9LJGshfsESP+ywvlHlz2aB95YNFvwCi3TfIU1mZ5i2O9e8mv+eCxV1IK253CLKmxcTzfs8cSCq+KHtlr8DMoFF033Yemk1UCSwTOABoQXm+wCRRbZlSjW/EvfG6oO8UbA4nF1zLyjEMlD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FWu7FlbM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kcvoSraH; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FWu7FlbM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kcvoSraH"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 68FAD114010A;
	Thu,  4 Apr 2024 01:48:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 04 Apr 2024 01:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712209729; x=1712296129; bh=xUUF0xxpw0
	SuYtVSjXPtX2n0LXMmbozUciW9GQE1Jro=; b=FWu7FlbMjLT+HW3d5SxTL7wkaK
	HAHwfD2+fVDSX5C9J9V9cHUzgKTFTjctBUAJPI0WJajl+tjtGtUqxnXZpb6gNis6
	KrhkErUA4BTtPr21skSKUjQmLX9uKYzpkDF02WImLL+kcpRYLHhZbNZRrSmcir16
	7DgkKtl45nIiKMG1D4LlVXi4Ng6lgK+gbcb23M9Y4Y/iwQPbNKyt1L14YPSWCJJA
	/chKW75EIgALXYE+vx93Lbj4aGEChCLPPfcxZaTRraYkWfHm9cnBf8GklvlMpm3w
	ppIYzZBfYV3LVOm1Xc23bEP8C2kYQ7fIFXPW9qBLWReyl4x2Ov7MRey9jsxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712209729; x=1712296129; bh=xUUF0xxpw0SuYtVSjXPtX2n0LXMm
	bozUciW9GQE1Jro=; b=kcvoSraHy4k4ScWUEyzptVsz2SFtbkQL6XZILsRtbzMy
	MY49pgcxa4Ng149O0TsU72z17ejNHb63gmdv5/6ljFb7rTCS8wQxHMoQwGwKrrYp
	OGYxrNt6Zpr11l2hehFP2iFZpb8xJL+iMlStOJ6naa3vHSqCx+ST5Cr6vhsio4KT
	B426zQd8KxAZ65GlmU1M38Wd27BIZmIgykBIQWle66IYgdbmTdwCZkIUUt9ArxRD
	3kjZqFiNSMLcYn5FBIA2yh9KCkEMZxyCtlCwNZzXO6NdnMXZqJgvD4LiGSOAeBQW
	rMpztfOTifWtJUAdsOGvquLIrSy9dJZqi1ZsOFq+9w==
X-ME-Sender: <xms:QT8OZn8mk4Fzp5Vv7424XAQkStNalA75lJRS44iYjGXl4IN3JKE2Yw>
    <xme:QT8OZjuaR0cbFf_iawCrNnCBpj7L0ZI8WG7uBmxUPVMq7T0_XXwkF1zgMLi0kRoYc
    TGanhM-wTEmluMeng>
X-ME-Received: <xmr:QT8OZlAF0v0ItubFHSDDc1ciA2zRc2UDtib650Lov-1dzc4hoc11uQmn6rc_3y64ajKmtBfwpIpTnwWXy88Xxpbn_8IHYLXQqFUs4GkkGP7Z0-EF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:QT8OZjeP1U3zWISMpWBkCBJVDq7MqsOQkueR3eH0oJFoFJYhhNMhmw>
    <xmx:QT8OZsMokfcZOsST8Av8ZCWQxzWrFWOBFs0EN7vZxlse13jQwjyaeg>
    <xmx:QT8OZlkpGAIQfqoOnuvW6wLQLJZKtfjvvtWFqGC0N2grCFeT-aUcPQ>
    <xmx:QT8OZmsiGViptoJr4akAvESviTh0p-_tmNWy7HirKV1Na4BvTJgHYg>
    <xmx:QT8OZppzBrv1_A6IxwZSh57d6LRkSvceKMa2BitESP7t6aLL62J0Bo0I>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 01:48:48 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 46718985 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 05:48:45 +0000 (UTC)
Date: Thu, 4 Apr 2024 07:48:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: [PATCH v2 10/11] reftable/block: reuse zstream when writing log
 blocks
Message-ID: <26f422703ff6dfeb8de9d5a41af3d322b64e7706.1712209149.git.ps@pks.im>
References: <cover.1712078736.git.ps@pks.im>
 <cover.1712209149.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FIQIpUgyOB5jLTvn"
Content-Disposition: inline
In-Reply-To: <cover.1712209149.git.ps@pks.im>


--FIQIpUgyOB5jLTvn
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
 reftable/block.c | 80 +++++++++++++++++++++++++++++++-----------------
 reftable/block.h |  1 +
 2 files changed, 53 insertions(+), 28 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index e2a2cee58d..9129305515 100644
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
@@ -139,39 +143,57 @@ int block_writer_finish(struct block_writer *w)
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
+		 * We want to perform all decompression in a single step, which
+		 * is why we can pass Z_FINISH here. As we have precomputed the
+		 * deflated buffer's size via `deflateBound()` this function is
+		 * guaranteed to succeed according to the zlib documentation.
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
@@ -425,6 +447,8 @@ int block_reader_seek(struct block_reader *br, struct b=
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
--=20
2.44.GIT


--FIQIpUgyOB5jLTvn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYOPz0ACgkQVbJhu7ck
PpQ7/A/9GVY2SzCRq/aw1BqBuc0I0Efo7rq0QbGDWlg3Eo+aZxGye0NUaKJpOBk3
WPTnvsyT0eb/dTbMB0qmdh6PyMC8C6clda4qTlXWHnwHR6qyg0XxeNwIoMzD0/LS
laHAU5AmMwqaEdhXdaNSRLVY6Cbds0C2+Ug4/NDvyl6V8bHfurj5gRqARYHIR7cr
ao/UDJOcYD23PmksnAWNY3hpk7TouDyQiMDDhhVoWNmsufx2eFUa0ltPBGbPFSNi
VIsoKR8svcSFwflytAbZKl7T18vo1BFZQ6mGvX2EJ3oHUd4AqKjXaFpIa6la75aq
nLILZOnurFg8ypSssndGlZKyeJgWMUKXsS7JXB0QGNWsdNKltvYIE00Ru+9F4d2K
I14ozIAAbFvt0aZ8hPKm77rUEtruttCbOPusscaH9dpb5YvsBZJcT4U3jvSVOSQW
u6Ogy8fWBYIv3fadL1FlY9GzcXXOX2dAOsz0V9hYYUUoa4+PldFrD/mttLJENx/U
R9a9ouay8BEKRWGj4aXF+ademELym2by3OKcqDljhKTGQl94s+AJHBxuwntRK2GE
8VauN2bgbD1jZ+rCSN6nm0XSD58q/lzxOY/TZBrTOO3BYEk5EAmwFzn6nnJyTUgg
TJEhbvKp9k0a+ZqhYGPPhyTk+awZ0wc6KRSHwjTO0RWOeTXxfKU=
=V2TV
-----END PGP SIGNATURE-----

--FIQIpUgyOB5jLTvn--

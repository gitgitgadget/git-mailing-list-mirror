Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BDC22611
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 05:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712209736; cv=none; b=m1dDPzuK5nH9TQdQrNCeXaPkfS8k97Oyo65a2ZUgskE1O2a0td5MD3DSXNrYvsn5AKRqw0ynGem6OSOLKD/ALm+5uTawRlf7nPbMDkaTluDNhPqlQ6MJqeU/OUuWaUBodE+7RBCFRO7YcGy/9skoep9VINEHh6dncQ1IBYpXa9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712209736; c=relaxed/simple;
	bh=a4QBV8+nvnVkWm+S8zbN/S2t1q4Ijxthi66TyZjCkYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyPOq0JE4b+1Z8hdF2C8re7UN1JwhdEpfJ6BhiLfp/QJAtPfxIAlm/OORWM2eh+3X/WODplXD0NDlHlzCBnsn0SOL1pd7w70LsgnSBotRhPxrHTbXltFMGMWNLrCF8n/Iz1RXwtZcvQCak4U7J2iFu9AD9nc9uEoSHV9SZcjomQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DXS7Jy6J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gp/3TUed; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DXS7Jy6J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gp/3TUed"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8756C1380157;
	Thu,  4 Apr 2024 01:48:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 04 Apr 2024 01:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712209733; x=1712296133; bh=j9siwjcGbJ
	ldVveFjy4pgnHFWAphQ6kjpMqLNdYw+GQ=; b=DXS7Jy6JpF1CSGgQxE3kdAHZF8
	CcldyxMs2KrVxUz8iQiAnPdD8THRatQOznEU0ToQf/UYaKnixqPkUCb6UsdiRDzy
	LJG5Y1bTuJO64pUZHhazCAOSL79YvRTZ5DqDv1l0kXsDLvkjIOi0qIfb1OEuwIQp
	iUNLnpjecne4kwAQfJL4skIe8/MMEFttOHQcKwnzA2jU/8e2d31rq/9rq3Me7zpX
	9H8LDt8m/teGIzhwmZcBYauj0NEW5JiZir6Z/YgOxKCMQmh4PmYWewbLJBcCv7Eq
	smUGz9/DLP3uahuOGQo3G4BFh7n4PQj3ZSqH5MuJL1RHdCTEIIk+N9KvJ+cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712209733; x=1712296133; bh=j9siwjcGbJldVveFjy4pgnHFWAph
	Q6kjpMqLNdYw+GQ=; b=Gp/3TUedGOMDbvQEyx558EGUslvlZhANHcBcHeBEf/ZT
	QwAyZMyDESijXOuRjyluaJZGL4FN+6/nb1BjoVh9U5MaqBnfdbMmCI0E4np6a+oO
	lKu5qpHxw0dH5RX0K386wLm8RIGv9GccDJDyEz5WSi+YbAFn8jeQ1Pqjn6YgFmYw
	xpPQCquFmHLfYLvb1zer47eS22CGTAbyA4/z/lXVeCC8tkl6JMkpFjDpU0BkuwP0
	8ufFpxKu63wEQ+lm/rw13bmGH1DWCfuf+9XwRm6Cu9ZBf9h0kLpk1vDfdYJ8NeJm
	PAMUOgfYj5pAqW48+WTW4ax9OhhjgKlNe/FZLmpdRA==
X-ME-Sender: <xms:RT8OZsf4jmO17-OESeo_8IlEE8ei-IWtX3eu-NSXZ9VCLuSBrJ2v5w>
    <xme:RT8OZuPSzAhvkhuuvT92aPhbJ9IWIJb5qmYm6bK6mW2IQ4uBm3V30aRuRe_09W6h5
    tpoSC5w7NOAhBegFg>
X-ME-Received: <xmr:RT8OZtgUUv8URe22hWyvwAAgLnelou6a76gMutXBbWUdTLg9MYEywGRxPIbwKnwjg6GBEbV_g6_DsWnU8MXUZ4X8Y_IMRdjORNySYV7NppVxigJS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:RT8OZh9csECN_HbmU2NbBqhHRZPiz_iu_nX-wH4_hFI27hLJYYOErQ>
    <xmx:RT8OZovXsgitqqLMtFGUP54YS2_S3zBxQ0dKBJH7MhNB2vAxCwV3TA>
    <xmx:RT8OZoFE1yAnSNsXIhu0jhCH-2TfV_QwBvYT2oEpyjIEygGS4jInJg>
    <xmx:RT8OZnOivdobXxfMTOAfFRBTvOgz385arE5apjThMVnLZqoAGmfGlg>
    <xmx:RT8OZqLs5zZcnmTeS1jAVm1rF3GeGM9rkhmSVmuocBQvE5f49nsQXG29>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 01:48:52 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f8fe8f20 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 05:48:50 +0000 (UTC)
Date: Thu, 4 Apr 2024 07:48:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: [PATCH v2 11/11] reftable/block: reuse compressed array
Message-ID: <4f9df714da95a10a5d89225b3ceb8ca42e61ac93.1712209149.git.ps@pks.im>
References: <cover.1712078736.git.ps@pks.im>
 <cover.1712209149.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gT/OTKzgla5sAreg"
Content-Disposition: inline
In-Reply-To: <cover.1712209149.git.ps@pks.im>


--gT/OTKzgla5sAreg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Similar to the preceding commit, let's reuse the `compressed` array that
we use to store compressed data in. This results in a small reduction in
memory allocations when writing many refs.

Before:

  HEAP SUMMARY:
      in use at exit: 671,931 bytes in 151 blocks
    total heap usage: 22,620,528 allocs, 22,620,377 frees, 1,245,549,984 by=
tes allocated

After:

  HEAP SUMMARY:
      in use at exit: 671,931 bytes in 151 blocks
    total heap usage: 22,618,257 allocs, 22,618,106 frees, 1,236,351,528 by=
tes allocated

So while the reduction in allocations isn't really all that big, it's a
low hanging fruit and thus there isn't much of a reason not to pick it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c | 14 +++++---------
 reftable/block.h |  3 +++
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 9129305515..f190c05520 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -150,7 +150,6 @@ int block_writer_finish(struct block_writer *w)
 	if (block_writer_type(w) =3D=3D BLOCK_TYPE_LOG) {
 		int block_header_skip =3D 4 + w->header_off;
 		uLongf src_len =3D w->next - block_header_skip, compressed_len;
-		unsigned char *compressed;
 		int ret;
=20
 		ret =3D deflateReset(w->zstream);
@@ -163,9 +162,9 @@ int block_writer_finish(struct block_writer *w)
 		 * is guaranteed to return `Z_STREAM_END`.
 		 */
 		compressed_len =3D deflateBound(w->zstream, src_len);
-		REFTABLE_ALLOC_ARRAY(compressed, compressed_len);
+		REFTABLE_ALLOC_GROW(w->compressed, compressed_len, w->compressed_cap);
=20
-		w->zstream->next_out =3D compressed;
+		w->zstream->next_out =3D w->compressed;
 		w->zstream->avail_out =3D compressed_len;
 		w->zstream->next_in =3D w->buf + block_header_skip;
 		w->zstream->avail_in =3D src_len;
@@ -177,21 +176,17 @@ int block_writer_finish(struct block_writer *w)
 		 * guaranteed to succeed according to the zlib documentation.
 		 */
 		ret =3D deflate(w->zstream, Z_FINISH);
-		if (ret !=3D Z_STREAM_END) {
-			reftable_free(compressed);
+		if (ret !=3D Z_STREAM_END)
 			return REFTABLE_ZLIB_ERROR;
-		}
=20
 		/*
 		 * Overwrite the uncompressed data we have already written and
 		 * adjust the `next` pointer to point right after the
 		 * compressed data.
 		 */
-		memcpy(w->buf + block_header_skip, compressed,
+		memcpy(w->buf + block_header_skip, w->compressed,
 		       w->zstream->total_out);
 		w->next =3D w->zstream->total_out + block_header_skip;
-
-		reftable_free(compressed);
 	}
=20
 	return w->next;
@@ -450,6 +445,7 @@ void block_writer_release(struct block_writer *bw)
 	deflateEnd(bw->zstream);
 	FREE_AND_NULL(bw->zstream);
 	FREE_AND_NULL(bw->restarts);
+	FREE_AND_NULL(bw->compressed);
 	strbuf_release(&bw->last_key);
 	/* the block is not owned. */
 }
diff --git a/reftable/block.h b/reftable/block.h
index 1375957fc8..657498014c 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -19,6 +19,9 @@ license that can be found in the LICENSE file or at
  */
 struct block_writer {
 	z_stream *zstream;
+	unsigned char *compressed;
+	size_t compressed_cap;
+
 	uint8_t *buf;
 	uint32_t block_size;
=20
--=20
2.44.GIT


--gT/OTKzgla5sAreg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYOP0IACgkQVbJhu7ck
PpQX/A/5AUVXZGGpPUxFvbI4mPYDEbtGg+yTiw4EOjxj/xehKPP71RGiDb7eS64O
GEX0OJIEM9lZ3k+8wZQhi09gcukK4r0uFlvxZJmDw2OkIvJQmcIwQhjPaNOm7Xlh
/78ycZ17yixpa3zGM5wuWfB6Uh6aLDJyLayfKC7UhFcyJ1cAwibWeykqc3Vf3lEt
kHmkEcH81Uu8QLkXh6EDPtAXOciqUh8CUs/CfC4Fi2ps30uQekb+rA62b2KNv9x1
+k/mVBNHaIcH1uEUzMUhyHy2S5UhL/AmChAiECFR3+NobcwAomsjsAoZB8fo2ILZ
1WKjl1XWlNHiGXIApqDkeJ4+2emc/CHa377mRt6P0PjqhIrRjeeEzqD5oMP68/45
zq8ZvFeeChpvEfMjoe4+gVMw4Z1al8LVb1QHE04yhlxjuVRyX0Q3aE6KKKEh1+hO
tZgTS95X4H+5i/cyWsgl2AqTrjS4HYRAnEQoPeyfQGJ/KS/rjqS/Zbjit50QQySY
OlSuAih2MsyZUOmj0IzlSVNj7MCvEXEjmvHDmIbWJNNQ++a1eNIwL3Yfmnjr38CU
0M6X6PcTJnK1kxbIA6PA5CIU1zDWq8EgBiFYzSPzAd97LmhclKaOhwnoViMZIVHQ
ABvh49/ff/sU2cv+fjtnzSTSHa9/rRs4tJt/NCgvdZLDFsyTePE=
=HwHn
-----END PGP SIGNATURE-----

--gT/OTKzgla5sAreg--

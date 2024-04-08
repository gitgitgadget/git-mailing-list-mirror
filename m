Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4415C6F08B
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 12:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712579081; cv=none; b=KMcyyJNs+1YNWyt7TL1GXtwcIuJmf28sGxa4Z9L/bV+eTTYPfBuLuECmTYvpaKHe76qKF71CgnpuD9ZE7HeA3HeRumigg8m6XJWEoiFLv84FPDJdViQI1a+edBzDtFQPNTIxol13KAbF+qBmnIaYI3Y+f/IIcB7Tg04/NjgIX88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712579081; c=relaxed/simple;
	bh=0seTZIEkQNX0xnpW/2R8vF4WeAs4mo3LNMBfOqqUoQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNQdbxfNWJLsFG8aCWgbP1/SijiGFr6+asH62Mh9whgH+me4igpynNevHJYxBrjnqwTplMgV3A8cQuTM3L4FTThhFpWvOSVAGsuwb/7ALwncgQ53pdhZOnIa38nQYe8yMUv1R14AcfybhPJXN7Rf6AIr1URHsLHD6dP5qXWp7DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XPBfg2cR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=roMoE4Vg; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XPBfg2cR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="roMoE4Vg"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3987E13800D8;
	Mon,  8 Apr 2024 08:24:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 08 Apr 2024 08:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712579079; x=1712665479; bh=FyYqKNeGmX
	3sV0fNB4gMa3tfUfwXDLWIqEZlYfONt6A=; b=XPBfg2cRIMjjROLimV2+TajCbv
	yZ6GDudWmLRD5GsgmmaKtwB7PkTiXb+AYnvcCmsUXauHU4T1rASeUzAIVmmbQ5q+
	MxPJuXhzblvIzk/moshoQDDLDPinKm7dbRqbDS8ytN+DYOpdA5iIpbUYpHM46+F0
	5dPWrSGvPnxInFFbiyUuuvwU7RiiJNXvTcTuHDO/Q/y1PnGca9FOiGKpik8PWpK6
	vSFlfV2iSBOiX21S0NAshgCeiX9ZgVDPvCNziOT1HiQa9GFf93bsPYn7+4GVlF5O
	EALKb40Cq2ISjfKqDX+wrEp99oxV4fX0Jc+JvZslla11xXRkbwbX6z+oQL6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712579079; x=1712665479; bh=FyYqKNeGmX3sV0fNB4gMa3tfUfwX
	DLWIqEZlYfONt6A=; b=roMoE4Vg1Ejrcf4e0eWZvKX6OQI7biDBM0CEvXWp42N7
	WICbg+jnbBYQOnN1iDClxoi/i3wPY/4CdUMjeTqlR7q1LTMgXs9WE5zW9JlZUWzi
	w9We0UFKZdubaS/tjx6+1SR8xfkB7JEU35vXemBpc+BtaalSepdhsQd2GBB96yUe
	s84WNc/pLiYXHiIJSa6QO+wLWIDhf6YYy3lgj1kgJxsVPrg+jELQ9tcLIVaXtTkd
	YhuzlY7+dDdfBhp2cMO4Nz/dSxobHStAZEbbJ+FQKHrn/2+xflGggwC665LUwsMw
	6XCEvZb49Tj3Qu2Q1EQxnHLs5HwxkLfxEMF0qVNo6w==
X-ME-Sender: <xms:BuITZv6U7C3VLDJWoyirErmbdg0_FWTthWYF9uG46XgSg_5hmOmLxA>
    <xme:BuITZk7AtQFpzSm9aOD3WOJBlpLobRiKaYYkgTpZKC0pqfg9HY_r9E3RXXA4jXPfS
    RxPnc0Rc_VN-WYcng>
X-ME-Received: <xmr:BuITZmdNcehB4A2TzfI7W7uoUK3K7drTp9j5tz-nptD5P8J6cB5Y30t67em12PqtUzSh9_I0z8wRtmrUljrdpTHvZGSTG49_T0EJ6iomCOD9unhIRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegiedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:B-ITZgLrn7XCfmB04XP6YqUpZDmr9DEdPnj0RUtEwQLwb_khO3gF6A>
    <xmx:B-ITZjKgVqBflshHlpBKWx6Q3Pe7MJIZwgSiXphiGAJ_S-cF7bmebg>
    <xmx:B-ITZpy9zaO0YhVz-yBkeOSDPtxoPR_xMEL0eaS76WbqKgpnB9rKuQ>
    <xmx:B-ITZvJ0YR3srkKj4T5yLYVSoIcAsQi3_LD9fOdTbf6FsOTzSBagMw>
    <xmx:B-ITZr26fRfFXvsY3ZE0cJ7pcv5Gsebk-F43aglK9RBwCX7950CB6k28>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 08:24:38 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 96f87336 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 12:24:32 +0000 (UTC)
Date: Mon, 8 Apr 2024 14:24:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: [PATCH v3 10/11] reftable/block: reuse zstream when writing log
 blocks
Message-ID: <962a96003b02ba21511da8ea820bbada2a767468.1712578837.git.ps@pks.im>
References: <cover.1712078736.git.ps@pks.im>
 <cover.1712578837.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gRdzZQRmr5bK3VpR"
Content-Disposition: inline
In-Reply-To: <cover.1712578837.git.ps@pks.im>


--gRdzZQRmr5bK3VpR
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
index 298e8c56b9..d182561b4d 100644
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
@@ -480,6 +502,8 @@ int block_reader_seek(struct block_reader *br, struct b=
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


--gRdzZQRmr5bK3VpR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYT4gIACgkQVbJhu7ck
PpTAQQ/+KHLUddnocEYy4rs4ydwnSX4sktXjbCI4xYJoC3a93oQmE73D3GPW8YGL
Wjhs6WMrEQLnEGePQrL17DQyBuDY1ZyiNbvdyK8QHfehWyWX+kRvRZk+FLkj8tZ0
BpHpIQS29iImWm2ZvTxGHWvyx0ndrB1dQqh8p31UciDfi8yU1KmNb+1Zf+2BIFMR
TSWISuiUPCEFvMALvKosNSPd8frIWHp+elmCiiIT0As/KkydLrZDtcSxFOAQQS4U
6y/MxrFt586zpKIt1DWvTJViHfxa8I+IDsxp9ipZwdSsdjvHSBL56ssWPuplQvRl
+055S0AUC75j+CqVj42dlw3B6RpsoTvKkZYEqHR9i6X8f/XWX1jGlo2nXFQWyzq4
OZ9PNe8x79B9gi9Y1CqI/JkA2iXtqvXQzMa2Ma6VYeay8ll+2YYmaw0UJhCVDsH/
spGWc4d8gelxAuNlc0ujbku2EnAEJSUbRZKJJXStGYDO2Fwb7YTQbeMSU0jaiP5q
lwg/yhx6R0xjdy+BBjutrsOjku3ricp7lt2i9zNvmNdKkSZwBNjyS/075WSqiZfm
gHu3y13t4IShV8xVTUwQqkygeKj3lywAAC+QuvlANYAKCcaToUYdgFh9pnqtGj8+
Rr+0O1g/FS2M/plSZx+84JSatP9gyJWh7/5VhKK5dpo/jO+9xdk=
=ioJr
-----END PGP SIGNATURE-----

--gRdzZQRmr5bK3VpR--

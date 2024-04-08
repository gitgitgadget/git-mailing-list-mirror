Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155436CDA6
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 12:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712579086; cv=none; b=GM2OuiI9FDIa0sC7B6miP0b6YNjnQ4BcwZd0dqteo00Ni1CJ+mlY3LIZ4ukvNxFT0IMgG+8NbKxKg2t85jjknIAU0d4UssomiBZGH6CeRjy7BNkWUVjRli0hQUMRVHHl6jFPeVcLDuGMUJbNYXfQvb67gNQ0/oS/XuuIfCU6VXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712579086; c=relaxed/simple;
	bh=7/H0xgSFeJ4iUUksFvwoIHmoIevf6MuSGHxoU7Lfdbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DshK4qA0KFKRQiXr78+Qfq9krvVVkhU/aGqfLnP4aKfXRbx280bAuBnlu5y6zJyRgxoNzndFF2RzJUh3iz+73U5J8R1D2WIYwAOPJdbbdo7QgGxTciCi/2eD1HVOtAwcW/I7I0N86O4Ig27BafbAbg1BZBNfbJJ3LJlJFCepHD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e9bnhuvn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TuI1hPl6; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e9bnhuvn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TuI1hPl6"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 654AC1140126;
	Mon,  8 Apr 2024 08:24:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 08 Apr 2024 08:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712579084; x=1712665484; bh=VAr0clLvOF
	n6hHRIW2ybtPgtChyT4RNjjoRjx0LaHH0=; b=e9bnhuvnJh+k6dJYnZIjrJrJPs
	4dhzCa8XaZ6DXGQO6WUVmw5e3zhifqzmH7ZRYh1mHisiosSJ+pLKfVPbChZ+nr/F
	iS4vCHV+H32AwFs7TIllqfNoQcMyECvxlKLq2ujhWAyTB3vE3oNrHHVrGamT3qEj
	IQay3zfGZDA48adOUiVsXtHlOb59Owbm2OCpG1j7UX3csenZMGZWCaZskZ/D2BNg
	t7Vq/yflokGg799/regUgnyW65yfS5dwHmRYsYV08b5Eu5ELXfjVfobagLCD4hW0
	ow0lY3/9zgiQ6ZIAZY02dpmm26DuLqJ+v9e3Px+YEKRUuhHzs93HdWJZJyfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712579084; x=1712665484; bh=VAr0clLvOFn6hHRIW2ybtPgtChyT
	4RNjjoRjx0LaHH0=; b=TuI1hPl6KeWolaL0CaX/tK+cm2k40h0uqe4c0+/0kNe3
	XcY8RdRNYDwtI/yiY9HIk9jKVp00KJ4Ow5foQnYNm7uB2PMP1SdysihS04r2+YiC
	/7XwFjVmkR+f2CazSnX+HyxNz7O3jFEl91a0HPi0UTxyUtM/zPx4kVT98IAsiahX
	Tz4Ir++Q7/EJGIqqMG3mbSs5OIMExM4aVWACYSQTIa2RKr1ebA/ZGYzx+mj5t8GT
	ARClKvScCb4n33dJeMyLwzD364zIsH3UztXCT3T7Ht60eIYA+BmJ4VhFPtRLklAJ
	6CJ7LUFmB83ajaKHvh8ntQ/focmBoTrVn3cQeegljw==
X-ME-Sender: <xms:DOITZqERYDpxg_Yyr-6ylkfD0izknRqIQyP3shSizTE1QtfeJmS6nA>
    <xme:DOITZrVDIFEOH_5PWXiRknz8mPs0d9mMYsiAOYaeN1da9l04keqaabpO8aIYK7KRV
    GR0Ex3T3z_X_u3cNA>
X-ME-Received: <xmr:DOITZkLKzd8xm60daBpQKCQICWZRTEa4hcKSJEqnbRBz1sv5cZcSe85xqgicSdX2HKl56aOmfBc19qDbmkZU81ybv_-9bnWnqiiv9oOyaU0IDmp5vw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegiedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:DOITZkHWESQFn91jVS_FILA-6k4JRnFlpGTgc2FuiD7K6H8Pft1k0w>
    <xmx:DOITZgVkRoA56fUQjmFGf2_07vhj4KP9Enuf3rE69j6yTbmrJ523vQ>
    <xmx:DOITZnOwV-dcUmp5NiDqkK0UD_T7LxcnpYynZYBeXlvYh0jcTgHYbg>
    <xmx:DOITZn0Efx8VLrVhGfavHSaXCCh2F_5chs5eA18fGvxGssQ_MP09rA>
    <xmx:DOITZnSRLByMJwMYZD-wAVAE5Dg2MuUKfRxAIvQpZZfNrig82OJi7mT6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 08:24:43 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 14d1959f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 12:24:37 +0000 (UTC)
Date: Mon, 8 Apr 2024 14:24:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: [PATCH v3 11/11] reftable/block: reuse compressed array
Message-ID: <323892841a3dc31cf0d4c5e614f9f0059a147c1d.1712578837.git.ps@pks.im>
References: <cover.1712078736.git.ps@pks.im>
 <cover.1712578837.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J7lRewV9ivve0T3+"
Content-Disposition: inline
In-Reply-To: <cover.1712578837.git.ps@pks.im>


--J7lRewV9ivve0T3+
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
index d182561b4d..fd494876b7 100644
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
@@ -505,6 +500,7 @@ void block_writer_release(struct block_writer *bw)
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


--J7lRewV9ivve0T3+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYT4gcACgkQVbJhu7ck
PpQHaQ//Qe4arArY225He3SDrhx8gX1YuPUZEviQjfo7H0+LQU31CJdcNt/wc7dH
jpFztg264Gv4vy1BybJ+IT/beinDfUITTWtMJmRlrekX87Hp7bdkYh+cMiVX7GUT
tKOwoEejqAT8GK+HqLo0yOK7UEQ/Ajd+j+XIW+IPGuPxYvrStV24bNDuKae83PC2
mIY3lFiZma2Gak2E2nJkec91zyGQWp1JVJ7I6MKpUMm2eYG2AIdIQywEOB7535z0
5cTWTvzUVLzGlxW4nsJR4emtCsCcDsshJM1I6lhvu4UFJy2m81U+3+CxeOcWF2hr
k6CUtUN2AN3hq4BvPu7sO8GpzKkRzMG2OfGOj9k1gbxdkwS2JTTw1ZeYUWqGSZLk
1hYCg2yGKSPBpT1OKb7VWNktqoegrQK+4y26fFPtzkGLgGk6ZdbASjHhm8YVPc9c
jLOnkR9cFC2ZAiD/aLKfhiDUV5UIwNGkoschAMb+EVZZK5o0jZ9V0cTjuOzwcBQb
i4RPJ5SStffoqyRWE2lsFGD4wXbVastzaKkDhIdwWbyX9oxZ39UCABNFpzIldwu1
IafPcGkFHA1/csMnsFHWzaKwcFisWsRRi04q+5ApL7ecuUYNcrjxk4E0IiuXvquw
nMvetFrIIUsrsy1WaL4HEP0/LGXz0pkE5e5j1jDO5+nLiu7St3A=
=FcNt
-----END PGP SIGNATURE-----

--J7lRewV9ivve0T3+--

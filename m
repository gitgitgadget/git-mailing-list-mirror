Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB6A14AD3D
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 17:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079025; cv=none; b=Et8Vx+V8qad9but0ws5KP5AypKjmrx8vUlyAq8XhNPZpcLwKCQDBgOe+sOjs/E8h1CnSSvYZd9x1+xflQabjmDp5UqUTlt0XbVCLifrqleWC+LUk5AP4u4cvlZ16aUqiRlcHBVtg2a8Jdb3SpuoRVsT7H1g3Nh8HbcHKyRsuOS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079025; c=relaxed/simple;
	bh=xFBnPp281z5tn3rvtFHkuC/4AFW9vcVurDAtURzLrCg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fInZnH0h7elunMCHDLqiYvPcxb7Yz/6cZjTnivIVd71BIQmE4bN9Kt4tlKy4Oy9PrcXWz52QP96eHCRgWYiyccRvtrAtL5DlqP4EWyl5ZFMZ/np91/rZ+lWd/HqzHTtzX8bvilsCvqF+gNCY+IR9dESNu3e3sNBMmGtC4GTQHrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bnJW6q4L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nOQL6i1f; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bnJW6q4L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nOQL6i1f"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 972EE18000F1
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 13:30:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 02 Apr 2024 13:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712079023; x=1712165423; bh=AY2SdgYTUB
	gdYLJogKkCudsfrWpaiS9QWzv7CrYMjK8=; b=bnJW6q4Lf0FLS0aNTkQaYaJ71C
	gMOItb+AB6WQ2yGA7nBpVacJkDgUHq69grSOayJ4AdR98uBujavSk96jp+9f5CFm
	SfNNCs710omDbJ4yYVeVGWlziN+/tCjXVjOArKdwX0arXlxZrlZ6mt2/mlqYSudB
	s1g0zdN4twg12hCBsdZg0vFTd9CUGQmzL/Y4/bhuJ+XN2daAloTuak9FKgJtE2wQ
	InWsQs/Tx0XtRg8MkU2x+30ogmsMi8Z0puTN31daqjUblxWT+9R7D3e66w0LAWrM
	I60xz2l2BQGWOg6zKlJk6Raa1iglmcKUdfF63tr/3wfYjc+2udWQs6LmkGyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712079023; x=1712165423; bh=AY2SdgYTUBgdYLJogKkCudsfrWpa
	iS9QWzv7CrYMjK8=; b=nOQL6i1fB6R+UGgHRLXUvUsb9V+edTZEq5h87MuDnok/
	j/X3/6SyftEsl/ax33xNF36/PYYzRV25x9bo9WvWUZjozs05iEx0U+LxFSspKdcR
	DsUvv2AQxkC9i8kVI8R/ue3ZWgB21dDv3R+vPiouk850934w7po2H1yDH8yalIHo
	2hDtyCKc9EIlCoCdElSIxNlewMhDGXIBCP94Tv0vf3NfQAA8Wr7+VKsYqmphehnY
	OnEazH6yUyn7bDAxIjhRGoLj7K15iLj2kfJJTJEUHTOY6WXY3bv07TZ0+7xgWPua
	u6ZlDE/EAI+d0drI30EYyQucYsGf8q/sFU1lkReeaw==
X-ME-Sender: <xms:rkAMZkbUi6MTzbQaOktfLYBDO6xI796SsFrYfARoRtJS9wGcjLYiiw>
    <xme:rkAMZvZhvu-g2NhjU6jWeVjrx7x3LBCgJJk8bxiYGd_Z610l83Z1IXyyFHbDr3WwH
    xGpTbLg8mQ-1XXFow>
X-ME-Received: <xmr:rkAMZu8RO7qzWynuXs2Mv2XiouZHefiusJGUXpWbP3Q4ipVf-yMgSX-A9qOVHvN7wktiJDS2NQ5exd0nvT3DBhQxYboexbryWxRs3Vd8yIdjSvk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedvnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:rkAMZurIemwLyy5184fNVSVSMT0IZAMsi6SI1Dz2g4bjefpDM9V-Gg>
    <xmx:rkAMZvqLxeCT6Etwj5Q22o11JeXKXPMGXJyHmPU9tWJvBe4XUgnpYQ>
    <xmx:rkAMZsTRPYeq7rnB9SWhCqUKnHbxS5ik30pSd4mNBSCizJXtt4H7-Q>
    <xmx:rkAMZvr5FethwSwc6yErpJeuwuskFGPi_DrvNGcNHP8Nwx58RYVWGQ>
    <xmx:r0AMZm1eVOnT3uhNnCn9XnspitJh0WXog0CZ4F4lMK-nugaPv96uTMx->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 2 Apr 2024 13:30:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dc178624 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 2 Apr 2024 17:30:14 +0000 (UTC)
Date: Tue, 2 Apr 2024 19:30:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 8/9] reftable/block: reuse compressed array
Message-ID: <9899b58dcff6a8380eb7cf3622c7dfff51a10a2c.1712078736.git.ps@pks.im>
References: <cover.1712078736.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UKcTZQZ2cQ/sgnME"
Content-Disposition: inline
In-Reply-To: <cover.1712078736.git.ps@pks.im>


--UKcTZQZ2cQ/sgnME
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
index 1fa74d418f..870d88b58d 100644
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
@@ -180,21 +179,17 @@ int block_writer_finish(struct block_writer *w)
 		 * buffer.
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
@@ -453,6 +448,7 @@ void block_writer_release(struct block_writer *bw)
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


--UKcTZQZ2cQ/sgnME
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYMQKsACgkQVbJhu7ck
PpQfmg//eccdMzQwXStItpPe1mmcW6xeCbfVzrA/76sukf0YMdRJscARyTI//5L5
wnUZvotEjkQp7SqF6catAJpivXN/zjRUztjDyMtBMdHRmwhoGjzHODCIEq9EeE9/
3ex4DJOSV4oSfZcDbAwuDb6PxLkrwCFpiaGnIykbSHBds2+JNGKT2BB4GwHiA1Fl
CuDVqlDCcpPK2Kp6XS4svOqWkYEIQaXR3Qr+g6JBUF8P/+ESG/rhZTbjP+Y/C7+8
YG+YQRP35p2VU9wrk6y75LENF6skx4L+wjN2c2ypJ/ZdqrTzlFtjTOUYYvn4B9fW
Ws9M0rCBo7LKK5p5ZyvPNhHvdb9c32RZvaJn3CCPMg6hUwS5TaRz9zMoqVm/3ng4
BH3KaCTgbYQX1s8yHtdhuy62Db36bMjignhlFyFIzPjvSUgS0ohOfYHv+hqJtR2h
9bpAN9UFJIoWaygcggAnmXQwvXeSyluF72tN7PlWudJa1Df5qw09x9pqrbi8PArF
JINu9hqyvXwN06gYrciVNd78Pv0Xp6UIgCt9VSCO24KNOP7cklMmb9P6CH4oRzO3
f2r3Bl1nePZLK6CifV/DQE3cgJWZKuW7J7bYP8HO7zrdEPExMfpyGc9AxHV/VZNW
btaN0yPPhcPhT4vtTSSSDFzIwkskuUxn8Im2udgtuM1PGt0syR4=
=GhfX
-----END PGP SIGNATURE-----

--UKcTZQZ2cQ/sgnME--

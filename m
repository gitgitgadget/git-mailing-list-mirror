Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B99428E11
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 06:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711521442; cv=none; b=abH5zFyeALsqP8ejIXRmw+UwQCvHyXUwFickve9q12o78v+VU3J/E5bGMIoVfLzNSp04FtzsVWaW1PjzAtZrS5z8hjiIIpNAJUr9GvbVE6u7gEy6FtsyYMqFaBwc8jIOeeofMvyWICew86AMYonYH3baRfWO/RipRz/pLTOXPlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711521442; c=relaxed/simple;
	bh=SxyI2O1eBg1Sj31WD783r8dCVC4rCbMkwtaz2tjtW8s=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUZdrhWZVCF4z169nlVXng9Z+9sU1L0G+1S4XfSgOULzNQGZQI44uR7taneaiO23otoF92UORuNGs64Y5DvRMzRVYSfEVWTbd9c9ciY/NucLu2jlFWmuRq0KWdQu9Wq5AP5cRLvNRleB4bsZhxAnkqy1nIRU+8a0rlAr6UcOqEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Zq3EZUTo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wo6x9Chg; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Zq3EZUTo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wo6x9Chg"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 31F3A114016B
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 02:37:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 27 Mar 2024 02:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711521440; x=1711607840; bh=5wvkeJbbsF
	aFL60VEgh1TRosDvpjNEmcWz0ogscVaWY=; b=Zq3EZUTo7nNxiYoZGbgQo0A/s9
	WREDp1Yp8NCEAXhcwQqhSA3KGvZ4rWmnoK8g5l7+VzEOcCJFT1tTFgfBSEcYntb2
	xgMNv7B+M0h3lc5ifCl2LYMUpZFnijjoWebeGa9wKUOCt/HqRZD5sCxcUiHlBubR
	NKEb7RlmXIORiRsMSYf5sTiCaFi6kyn16mr3QC16Qzj9FZVbqJWUH+b4ekVaqwRi
	lu9CkacE5R+3P/4JRYtL/UcnvljyT9aVB9UmIrWbFe5xwm8O/1jRHe4fb3bAvS5K
	vwcdCqLalMl2jdu4W16GxbsV9D27BbZF4lUp6CbgURke5a1I/DzKeOlyx5Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711521440; x=1711607840; bh=5wvkeJbbsFaFL60VEgh1TRosDvpj
	NEmcWz0ogscVaWY=; b=wo6x9ChgeNIOqf9uEZO7BKXOy3sQqnQ/7y0NvPJroc0s
	8IBBNApFpfpixMWMrV0twIE4fo+Iq+TUsXW1NM3i5c0pXPAQTB5jg7RI1ICLtxNg
	2qMrsFbpNja/OJ7dwz0aQMKPJzd5xTPag/xj5PMvgMBzhoUyZPSLDr/ECu2SC+NV
	ZygokU/DS71nDTJpG/mhukKosxO2ietqUDGzZwQ1+tE2XCh5Zlvxu9aaVZK50wEq
	blo9m7wVMhjpnks0OY+ZpSCTcD9SU4NWJZ2ss6BVPF1t1FKtJ+I/LB5DMaFEAbDC
	s7bTK3l792Tcg005pahW9nZ80hSnFNn99lEC9JQJNw==
X-ME-Sender: <xms:oL4DZoZ9WaI7jb_XEuteUVNG7o3UBYCpl6JmPEEqeJVRCUlh6bvA7A>
    <xme:oL4DZjbyXroVHwkBgqp_mi9FTi9RTNQss1IR0rYcpzO4eW6THTeWAgXVZcMnGln5K
    9Ml-ULBKvqP2Jo1fQ>
X-ME-Received: <xmr:oL4DZi_9Mb0z0qNMFlBCisyDcyKvUfED3RLkWxZ1k6PSjWRM7iU-ZEd_26seqvi_zimYhmDuX4UMdc2GEWkv_CoPnszr-0BuXBMT62k4OXYNEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:oL4DZipz-OWcKv88zSDCJIgaoUMAzldppdU_QUAD0VLgbSbQ9Tjm8A>
    <xmx:oL4DZjqJPPXMhsWtRRrkKQudKUMdp3AVwK1RIG0nbSeFRISzC-bOyA>
    <xmx:oL4DZgQmbxzqA6VX6hI4HaVSHlvJx8qZUDklb03TumnPnSFVw21aJA>
    <xmx:oL4DZjpZyO3j4RUtDbNj7qfSYxnJ4ibFEYVF-TNlXYtjz3r5RvFJrw>
    <xmx:oL4DZq3DNc7LB4W_uixlBqeqwq34NjFCcHXfV03JUq51FZvRJ-R1BQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 27 Mar 2024 02:37:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 03ce2cea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 27 Mar 2024 06:37:06 +0000 (UTC)
Date: Wed, 27 Mar 2024 07:37:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 6/9] reftable/reader: iterate to next block in place
Message-ID: <ae359cb714faa550b585af4a002ad84b01c2b576.1711519925.git.ps@pks.im>
References: <cover.1711519925.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qHcwlsYuLWrYnFIl"
Content-Disposition: inline
In-Reply-To: <cover.1711519925.git.ps@pks.im>


--qHcwlsYuLWrYnFIl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The table iterator has to iterate towards the next block once it has
yielded all records of the current block. This is done by creating a new
table iterator, initializing it to the next block, releasing the old
iterator and then copying over the data.

Refactor the code to instead advance the table iterator in place. This
is simpler and unlocks some optimizations in subsequent patches. Also,
it allows us to avoid some allocations.

The following measurements show a single matching ref out of 1 million
refs. Before this change:

  HEAP SUMMARY:
      in use at exit: 13,603 bytes in 125 blocks
    total heap usage: 7,235 allocs, 7,110 frees, 301,481 bytes allocated

After:

  HEAP SUMMARY:
      in use at exit: 13,603 bytes in 125 blocks
    total heap usage: 315 allocs, 190 frees, 107,027 bytes allocated

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c  |  2 ++
 reftable/reader.c | 47 ++++++++++++++++++++++++++---------------------
 2 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 8f5dfe10bf..471ebd8580 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -188,6 +188,8 @@ int block_reader_init(struct block_reader *br, struct r=
eftable_block *block,
 	uint8_t *restart_bytes =3D NULL;
 	uint8_t *uncompressed =3D NULL;
=20
+	reftable_block_done(&br->block);
+
 	if (!reftable_is_block_type(typ)) {
 		err =3D  REFTABLE_FORMAT_ERROR;
 		goto done;
diff --git a/reftable/reader.c b/reftable/reader.c
index b77b639751..dd4de294a1 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -312,26 +312,20 @@ static void table_iter_close(struct table_iter *ti)
 	block_iter_close(&ti->bi);
 }
=20
-static int table_iter_next_block(struct table_iter *dest,
-				 struct table_iter *src)
+static int table_iter_next_block(struct table_iter *ti)
 {
-	uint64_t next_block_off =3D src->block_off + src->br.full_block_size;
+	uint64_t next_block_off =3D ti->block_off + ti->br.full_block_size;
 	int err;
=20
-	dest->r =3D src->r;
-	dest->typ =3D src->typ;
-	dest->block_off =3D next_block_off;
-
-	err =3D reader_init_block_reader(src->r, &dest->br, next_block_off, src->=
typ);
+	err =3D reader_init_block_reader(ti->r, &ti->br, next_block_off, ti->typ);
 	if (err > 0)
-		dest->is_finished =3D 1;
-	if (err) {
-		table_iter_block_done(dest);
+		ti->is_finished =3D 1;
+	if (err)
 		return err;
-	}
=20
-	dest->is_finished =3D 0;
-	block_iter_seek_start(&dest->bi, &dest->br);
+	ti->block_off =3D next_block_off;
+	ti->is_finished =3D 0;
+	block_iter_seek_start(&ti->bi, &ti->br);
=20
 	return 0;
 }
@@ -342,7 +336,6 @@ static int table_iter_next(struct table_iter *ti, struc=
t reftable_record *rec)
 		return REFTABLE_API_ERROR;
=20
 	while (1) {
-		struct table_iter next =3D TABLE_ITER_INIT;
 		int err;
=20
 		if (ti->is_finished)
@@ -362,14 +355,11 @@ static int table_iter_next(struct table_iter *ti, str=
uct reftable_record *rec)
 		 * table and retry. If there are no more blocks then the
 		 * iterator is drained.
 		 */
-		err =3D table_iter_next_block(&next, ti);
+		err =3D table_iter_next_block(ti);
 		if (err) {
 			ti->is_finished =3D 1;
 			return err;
 		}
-
-		table_iter_close(ti);
-		*ti =3D next;
 	}
 }
=20
@@ -453,9 +443,24 @@ static int reader_seek_linear(struct table_iter *ti,
 	 * have no other way to do this.
 	 */
 	while (1) {
-		struct table_iter next =3D TABLE_ITER_INIT;
+		struct table_iter next =3D *ti;
+
+		/*
+		 * We must be careful to not modify underlying data of `ti`
+		 * because we may find that `next` does not contain our desired
+		 * block, but that `ti` does. In that case, we would discard
+		 * `next` and continue with `ti`.
+		 *
+		 * This also means that we cannot reuse allocated memory for
+		 * `next` here. While it would be great if we could, it should
+		 * in practice not be too bad given that we should only ever
+		 * end up doing linear seeks with at most three blocks. As soon
+		 * as we have more than three blocks we would have an index, so
+		 * we would not do a linear search there anymore.
+		 */
+		memset(&next.br.block, 0, sizeof(next.br.block));
=20
-		err =3D table_iter_next_block(&next, ti);
+		err =3D table_iter_next_block(&next);
 		if (err < 0)
 			goto done;
 		if (err > 0)
--=20
2.44.GIT


--qHcwlsYuLWrYnFIl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYDvpwACgkQVbJhu7ck
PpSEMw//XGuS+pQfzagMeafi1Q7/I0SbeSSglPq9+s1/GBR7alsVhVGg8ub3/cNv
tk2g8WtS9rHpGTLyRQv6a6gmiaP/R0wT8rv7AKBu3qnnFbdrMuNc3ncNkGlyyPuh
rNhR6b2fGAG6Xnzxk3aHg0cndEOF4CBCpqTrEtJfQ73SO4C8gIHS+U+4kaTWpUSs
YeQhYRSa5FbhL/bOFeUwZ6+dv+6yLlatBPjB4pe2i2I5i9BG6U4x4ooGVo7/yaLp
TIJuSlEblWApUk4KD+62+igtCGkS0JyihlNzzfTC5bKlqwwMRVywHzWR3Em8hFfr
z7xGEvntq3wokVlv9WDCjiS23F2mwmgp/jO4/Lt73yhrPG2LAHjs6ZeBtaQb3Etq
D6LGyRoTBYsc6QWn63LbIDQR+IHu5HP9pYmWlRHC5vqFR6HrOeHdaYmImaoXghHB
EiBv4AFLQ7o6+FUo2wicsBj0Pyqg23+NDNCy7EAOkXEW4c2CC/JYaUbpadCCDz70
S7x1rMCRpcaFLYEziq0/sP9JTFByDU9t+V7gUPmxTjCs5+6CEgIo6cJbkG1hYiUZ
hbLuZLjM4TTyaN3O9jiJTU6aPR5L+NdLn46qxMgTpMEBrcVLAr5f9BM8AJoCroRS
0XSQ4dtUfEOpWgRp1fc2nLy3UBdeqhdS/ciNVLDw3/TlHSFF6iA=
=gY+d
-----END PGP SIGNATURE-----

--qHcwlsYuLWrYnFIl--

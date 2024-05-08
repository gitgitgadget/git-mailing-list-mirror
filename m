Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4307D3E4
	for <git@vger.kernel.org>; Wed,  8 May 2024 11:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715166232; cv=none; b=hXDl4vwAIt9YTFGV4e3qko4P+WPxhXw0m6idgiZOpKQ2kHjZn5Ma+aRs4rdk7fJqIv1IwMQlQb6SqeqTCeyGiwLKeyTXGNgc7b8QFFfxVTY7Bb4YX5KJTxWCC4nV0OHSezHaA+NmJ628uuQ+wJuaBVk8dwSnexTgPT4wWwOMO98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715166232; c=relaxed/simple;
	bh=jehmZ4oZkBNEiFe/b2fK7VWez5e0ZNq2jglYqKDBKlc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C44bLAaMZ+PEYsbsso+2cRidfSjoyUp/eAJv0fcwUX2d/3fFUKaeKk43unI24PXZTKWBPKDpGoVQY03HYwu1R8Hy3D2+MZ2xJtbHpe0TWynIKETinShgpnWZB2lc1axAnIoznOuiTqV/RW2nJxvceM/zC69U/Codp1Yi/OlZ+Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CFVcfHzA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k5sfs/VL; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CFVcfHzA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k5sfs/VL"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id AC07A1140071
	for <git@vger.kernel.org>; Wed,  8 May 2024 07:03:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 08 May 2024 07:03:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715166229; x=1715252629; bh=lhK4RYLwoL
	UGoHaO3YxHGJPg7J7FGKEBZ4FQJV2PAeQ=; b=CFVcfHzACuDewz7CrUEv8BN+dz
	NuV3zKc8LVhSJL96oewDINtA+UOwVGvXWlJp9dsZ7kTTjvrySCbJLM20Xrmp0zru
	rcI9RUy3bhPXSBHBtZFW5kltE1FBvBYh1O37ky7uKqFbLlOPC3TePWxaTbpqAlVD
	u+oqM9fZvSGuccdHRQoQeYhtWnXMOIx46jirs6H0NXpkJyEU7NNckERn2MNK5eVg
	gU1bfG9CQxSPDarJ86T2q1Pk84EUfAnCaB17ZkerjmrhpEIx4X88wDc3ZgyehZKd
	km35FMl+Z6m+fAuOyNJyk/3s7XYc/Hh13MPTHBKwg6ByKVNjjpw3mMyvX6UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715166229; x=1715252629; bh=lhK4RYLwoLUGoHaO3YxHGJPg7J7F
	GKEBZ4FQJV2PAeQ=; b=k5sfs/VLaGb4o9rbsBvaY+GWj/NbfiHyICNgNwQIZf0/
	W92FqMu6bDNGeZ1iNVQDoYx4MJFmWjeYdau1oPqE6g8rpLqpT0QS7OGIHGC2EioU
	xACsAlYmi3xQvZQ0CzFgDvoSuMHMNJMAAYdwUPULyRnKFwaCWYGGqkGnP1Y/bgr3
	0M6SBJR2dooLn3wlEFq5bDSVpB0/mr68E4aA1l/sh5t2D8Aydrrh97/4L4JafFmA
	eMqCbYdhjCr1Yy11CRb81oOnlRT3TsowYUDqyZYhE/crjhBRljL3BkQHePeTFj8o
	d/okB5e+Qk8SDpnCYOvtFTy/nL25Ob8T1TSd5j9Zpg==
X-ME-Sender: <xms:FVw7ZrCmpkdnsMRMDRUCHjCAOMMn0k7AuyePQda1RE5qauXH3UUKfw>
    <xme:FVw7Zhg17c1FUCyAR_fPBea-mchy_mkuBP1x3BecApsACzVei_ljokCPCKjcVvZj9
    gIEAUExlC1mTqprFw>
X-ME-Received: <xmr:FVw7ZmmDM4XZbE1R-n0Qpp7ZOzf0Q2lPyaedEgjqyK_YYyOmaWk0hEKwaX7m0Yv_Nx3e_gX2yQiRvQ05b0_buuTu91nLZ_fNgXCAL880UNlzXBYzSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeftddgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:FVw7Zty1rnbQWMWup1m7NMNJAGDTKZkXDMAbFhQ7AmDWFEiLveW3hQ>
    <xmx:FVw7ZgTb2ipUPPNyK-qel3cyBMlf5Yv39a41ijCCp9ThRNSTxKsXcQ>
    <xmx:FVw7ZgZ1i8C30wDqLzL7xW8QwrsPQqfPJznxcYdozc1IhF2EHfTo-g>
    <xmx:FVw7ZhTJqc4dIq-vKidGeoP7xFH37jalkoLOuIDJZE9r0w8Cw-3FdA>
    <xmx:FVw7ZrIgnNd_a8tqeW5jdWu9Bm_jEXtb0OsmT-zJcy8CSeORDVaI3QFb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 8 May 2024 07:03:48 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id db50a0f6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 8 May 2024 11:03:35 +0000 (UTC)
Date: Wed, 8 May 2024 13:03:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 02/13] reftable/reader: avoid copying index iterator
Message-ID: <bdbebdbd363fc264c6327e7bf0af29ee5357e83d.1715166175.git.ps@pks.im>
References: <cover.1715166175.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I9vyXktZ6wNuAP5A"
Content-Disposition: inline
In-Reply-To: <cover.1715166175.git.ps@pks.im>


--I9vyXktZ6wNuAP5A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When doing an indexed seek we need to walk down the multi-level index
until we finally hit a record of the desired indexed type. This loop
performs a copy of the index iterator on every iteration, which is both
hard to understand and completely unnecessary.

Refactor the code so that we use a single iterator to walk down the
indices, only.

Note that while this should improve performance, the improvement is
negligible in all but the most unreasonable repositories. This is
because the effect is only really noticeable when we have to walk down
many levels of indices, which is not something that a repository would
typically have. So the motivation for this change is really only about
readability.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reader.c | 38 ++++++++++++++------------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/reftable/reader.c b/reftable/reader.c
index 481dff10d4..6bfadcad71 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -510,13 +510,11 @@ static int reader_seek_indexed(struct reftable_reader=
 *r,
 		.type =3D BLOCK_TYPE_INDEX,
 		.u.idx =3D { .last_key =3D STRBUF_INIT },
 	};
-	struct table_iter index_iter =3D TABLE_ITER_INIT;
-	struct table_iter empty =3D TABLE_ITER_INIT;
-	struct table_iter next =3D TABLE_ITER_INIT;
+	struct table_iter ti =3D TABLE_ITER_INIT, *malloced;
 	int err =3D 0;
=20
 	reftable_record_key(rec, &want_index.u.idx.last_key);
-	err =3D reader_start(r, &index_iter, reftable_record_type(rec), 1);
+	err =3D reader_start(r, &ti, reftable_record_type(rec), 1);
 	if (err < 0)
 		goto done;
=20
@@ -526,7 +524,7 @@ static int reader_seek_indexed(struct reftable_reader *=
r,
 	 * highest layer that identifies the relevant index block as well as
 	 * the record inside that block that corresponds to our wanted key.
 	 */
-	err =3D reader_seek_linear(&index_iter, &want_index);
+	err =3D reader_seek_linear(&ti, &want_index);
 	if (err < 0)
 		goto done;
=20
@@ -552,44 +550,36 @@ static int reader_seek_indexed(struct reftable_reader=
 *r,
 		 * all levels of the index only to find out that the key does
 		 * not exist.
 		 */
-		err =3D table_iter_next(&index_iter, &index_result);
+		err =3D table_iter_next(&ti, &index_result);
 		if (err !=3D 0)
 			goto done;
=20
-		err =3D reader_table_iter_at(r, &next, index_result.u.idx.offset,
-					   0);
+		err =3D reader_table_iter_at(r, &ti, index_result.u.idx.offset, 0);
 		if (err !=3D 0)
 			goto done;
=20
-		err =3D block_iter_seek_key(&next.bi, &next.br, &want_index.u.idx.last_k=
ey);
+		err =3D block_iter_seek_key(&ti.bi, &ti.br, &want_index.u.idx.last_key);
 		if (err < 0)
 			goto done;
=20
-		if (next.typ =3D=3D reftable_record_type(rec)) {
+		if (ti.typ =3D=3D reftable_record_type(rec)) {
 			err =3D 0;
 			break;
 		}
=20
-		if (next.typ !=3D BLOCK_TYPE_INDEX) {
+		if (ti.typ !=3D BLOCK_TYPE_INDEX) {
 			err =3D REFTABLE_FORMAT_ERROR;
-			break;
+			goto done;
 		}
-
-		table_iter_close(&index_iter);
-		index_iter =3D next;
-		next =3D empty;
 	}
=20
-	if (err =3D=3D 0) {
-		struct table_iter *malloced =3D reftable_calloc(1, sizeof(*malloced));
-		*malloced =3D next;
-		next =3D empty;
-		iterator_from_table_iter(it, malloced);
-	}
+	REFTABLE_ALLOC_ARRAY(malloced, 1);
+	*malloced =3D ti;
+	iterator_from_table_iter(it, malloced);
=20
 done:
-	table_iter_close(&next);
-	table_iter_close(&index_iter);
+	if (err)
+		table_iter_close(&ti);
 	reftable_record_release(&want_index);
 	reftable_record_release(&index_result);
 	return err;
--=20
2.45.0


--I9vyXktZ6wNuAP5A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY7XA0ACgkQVbJhu7ck
PpTVDw//Z68WM5nyhtb/r6gBUdoiNpK3LqIiBrkzxLzo75iVG34yXv5PadRbco3V
m8Fk6ka78ZLKhpcIoAOvC0Xcr+F+ZdTPioKrVC4Hx02YnCAM9Jk7QyapDLTj8zNt
DXZLlAhQFwAItcSI3kT3JyUbUY22mh3hlEYf3MaT8iCdEPhTrjtZmMfzlrEd5wJP
3ol4Tq7MmGkdEwCQahTMTsPGwSkTHRzEzy4/F+FjACkuoTPa0K+HKo3P8ucq2tgs
WxkpMxKfeCKgSKC564IUAcG1syBHAi2zhV0smbeFKorsa3K2tfmfyBWtaer2QjTd
MpvMf+2ZyvISwckMgqHyELGejChttVXkSzxojkZwqpeX0nS1mqDOdgojmsRbItUr
l9qxjduNIJWsVqsxVBRsov+qbJuzlSg9QJBWmZQbPl2LNVbEFijZrO6HvOvpdReE
5dqPRu7PJDg7STWqQIgMBYHRI56RL/hVaReNF4Oq9+rMLVYVZKtPKoUmHU2I6sK9
SVLNw1RBL3dh5aAfqadJeEwMCSNGmeREkAIFo0S8TpXqR5u1qx/+Wrkx728rpKmc
8k1BppiGk2XBhayjCXAL7K3X7PcckuLRRoDt7X/lsAC86karz74keNPyjRJiYFun
uPGAuQckYBVgUcXVfB+nVrlvBTvmcuh51wyLiHnMIjX/TwrOx6Q=
=W9jQ
-----END PGP SIGNATURE-----

--I9vyXktZ6wNuAP5A--

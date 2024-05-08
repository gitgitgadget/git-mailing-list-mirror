Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5AD47F6C
	for <git@vger.kernel.org>; Wed,  8 May 2024 11:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715166232; cv=none; b=Brl2oyVQMs1UzRlGSr+VtgW8hQWOcg/VE7/vHKVb5NuTNSJRXB5FVDM4eRl8PwTPka6tAuLJP0uU+bp/1kAAORAwtuj9KlFiHrvV7PJ/7RxcsRqa3bgN0dJjO6kVGDCOzqpOSy9ODopAmL2Cn1JAKOX4PRQEIjSdGVrDpiNN47k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715166232; c=relaxed/simple;
	bh=8GUU6uTvsZaQ6tzOQXJbHUX6sqOHS86dTy8ciPIx054=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VV8KserZkvLu5w0MXn2OAVVDGZX7iczCs8M4nTm4rdezgXpHr8T95794IgcCzfY6bU1dJ+pcPawkm4opyTlPsi8NyF98/gv0/cw13bKXiZFYQy7Y/v1Qns7Bhzr1m9St9jieH/RnPi0Vf7VWXahu+n1qo2YKA+EOVRyGh8K9r4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BTBiPcKd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eg0hS+Pl; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BTBiPcKd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eg0hS+Pl"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 99D2D1140244
	for <git@vger.kernel.org>; Wed,  8 May 2024 07:03:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 08 May 2024 07:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715166230; x=1715252630; bh=p0J6ziEBN8
	gkGGGdN/msA/lX0AfjB26dbv9YQzNFq5g=; b=BTBiPcKdPq8uEB72kGkhKycQyj
	wvR5D6KXAHmT76HcHyKd8EaJB7GHq0qvb1aJNfhcI/yVIqpJmqIZKPtJCOD/cXPN
	8b0kd0zVkF9fQvSf+3NCHkGt50Ndpclpq5dZ0qPHVBXusRm8g7Z1wduziIDEFR0M
	LG+2wezrMWKu1kP3YQyXYng3bsyTdgyOdmaRsKNdl4xiclEu6L+i0p/TB38MPO56
	WseeuXxbgC4+5kvTZhz4jQzDhLgs9Pi3K2PWfeTh3FDxlKvZYNQgfcWY5nMPbWwK
	z4CEVdAPi6DGgjgqFuSNQj/e9LKTtO40KO+fxSW8Vnd6iI1EFUO4YKktaQHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715166230; x=1715252630; bh=p0J6ziEBN8gkGGGdN/msA/lX0Afj
	B26dbv9YQzNFq5g=; b=eg0hS+PlLdgY/Ahepw5E5/PESJ9hwiuLuwUjRqUE5/cj
	YNAI3KRXC7nlmoR0zsy5XHQvAY9jKhFNESjX1ptp+58AFerOafb4wYh6TDIiqEWz
	9nc59v4oHigS1la7Yb2oLLcSvf2yTBshYzI+W3SO4fFDh3L4ptSTFtG7rfHi6E8w
	sy8UDecOQVSuwEhQzbzEpWSnb0O3hg7yWV/02fBCrUW4jLWuIBq9e8b/Y9JBXjuc
	SntgI0mbccLEINWwSfZmnHoCzLsc41OmVCiPKVoRIYWbkNmiq7SSDjqk3RRwPJmC
	SokgnGPXS9OU1Zu5Vl1dqBxpfVzhvf4xMNzoUdO0nA==
X-ME-Sender: <xms:Flw7ZvcbNQgPi06nOioM0A2kdkSiQoVuUB1EzNLz575dOGBCUcrpng>
    <xme:Flw7ZlPuZndoha5jkYJy118jkurE51DJeqLlVuxHpcutc4q7eAbpqL1pOSvfaa0wq
    KxI3qOhOQ_p-SvXww>
X-ME-Received: <xmr:Flw7Zohj1vaRw2GPc9tXZtBFWBzSsg3g-wv-UUwtClySVDdJbm_7f0zOZCLMEdZuNv5EBIGr4j5ZX5CM6JLbk2Ynu-IGLuw526prIAf1jQTj5lKuEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeftddgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Flw7Zg_996w3fC8yM53DXCH_Kpt3lW0jxBU_8ShtXNoQsD2epEdeEw>
    <xmx:Flw7Zrv9Cft9vxGFI0oenSyJIBmeOCr_yyj4ldSqXJimm_TTCrD-Yw>
    <xmx:Flw7ZvGmgXAPglor_hFGahc3mH-5S7pw_ViCG-vUg54yegwFc-EQCg>
    <xmx:Flw7ZiMs-rlZ52leLj0e8cfs22RIAMi73odVtLPRMHKiDwZZOUwUow>
    <xmx:Flw7ZkX7pVFeziwPCZFh1g_IJ_BTnOY3UV2X37zNwcS0Z7Fat_NE6EnZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 8 May 2024 07:03:49 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 94bffe37 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 8 May 2024 11:03:39 +0000 (UTC)
Date: Wed, 8 May 2024 13:03:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 03/13] reftable/reader: unify indexed and linear seeking
Message-ID: <716863a580f9e1ef8ea796c25c97e50c63585a7b.1715166175.git.ps@pks.im>
References: <cover.1715166175.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IXIZxCU8zoWC8EhZ"
Content-Disposition: inline
In-Reply-To: <cover.1715166175.git.ps@pks.im>


--IXIZxCU8zoWC8EhZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `reader_seek_internal()` we either end up doing an indexed seek when
there is one or a linear seek otherwise. These two code paths are
disjunct without a good reason, where the indexed seek will cause us to
exit early.

Refactor the two code paths such that it becomes possible to share a bit
more code between them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reader.c | 42 ++++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/reftable/reader.c b/reftable/reader.c
index 6bfadcad71..cf7f126d8d 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -425,7 +425,7 @@ static int reader_seek_linear(struct table_iter *ti,
 	struct strbuf want_key =3D STRBUF_INIT;
 	struct strbuf got_key =3D STRBUF_INIT;
 	struct reftable_record rec;
-	int err =3D -1;
+	int err;
=20
 	reftable_record_init(&rec, reftable_record_type(want));
 	reftable_record_key(want, &want_key);
@@ -499,8 +499,8 @@ static int reader_seek_linear(struct table_iter *ti,
 	return err;
 }
=20
-static int reader_seek_indexed(struct reftable_reader *r,
-			       struct reftable_iterator *it,
+static int reader_seek_indexed(struct table_iter *ti,
+			       struct reftable_reader *r,
 			       struct reftable_record *rec)
 {
 	struct reftable_record want_index =3D {
@@ -510,13 +510,9 @@ static int reader_seek_indexed(struct reftable_reader =
*r,
 		.type =3D BLOCK_TYPE_INDEX,
 		.u.idx =3D { .last_key =3D STRBUF_INIT },
 	};
-	struct table_iter ti =3D TABLE_ITER_INIT, *malloced;
-	int err =3D 0;
+	int err;
=20
 	reftable_record_key(rec, &want_index.u.idx.last_key);
-	err =3D reader_start(r, &ti, reftable_record_type(rec), 1);
-	if (err < 0)
-		goto done;
=20
 	/*
 	 * The index may consist of multiple levels, where each level may have
@@ -524,7 +520,7 @@ static int reader_seek_indexed(struct reftable_reader *=
r,
 	 * highest layer that identifies the relevant index block as well as
 	 * the record inside that block that corresponds to our wanted key.
 	 */
-	err =3D reader_seek_linear(&ti, &want_index);
+	err =3D reader_seek_linear(ti, &want_index);
 	if (err < 0)
 		goto done;
=20
@@ -550,36 +546,30 @@ static int reader_seek_indexed(struct reftable_reader=
 *r,
 		 * all levels of the index only to find out that the key does
 		 * not exist.
 		 */
-		err =3D table_iter_next(&ti, &index_result);
+		err =3D table_iter_next(ti, &index_result);
 		if (err !=3D 0)
 			goto done;
=20
-		err =3D reader_table_iter_at(r, &ti, index_result.u.idx.offset, 0);
+		err =3D reader_table_iter_at(r, ti, index_result.u.idx.offset, 0);
 		if (err !=3D 0)
 			goto done;
=20
-		err =3D block_iter_seek_key(&ti.bi, &ti.br, &want_index.u.idx.last_key);
+		err =3D block_iter_seek_key(&ti->bi, &ti->br, &want_index.u.idx.last_key=
);
 		if (err < 0)
 			goto done;
=20
-		if (ti.typ =3D=3D reftable_record_type(rec)) {
+		if (ti->typ =3D=3D reftable_record_type(rec)) {
 			err =3D 0;
 			break;
 		}
=20
-		if (ti.typ !=3D BLOCK_TYPE_INDEX) {
+		if (ti->typ !=3D BLOCK_TYPE_INDEX) {
 			err =3D REFTABLE_FORMAT_ERROR;
 			goto done;
 		}
 	}
=20
-	REFTABLE_ALLOC_ARRAY(malloced, 1);
-	*malloced =3D ti;
-	iterator_from_table_iter(it, malloced);
-
 done:
-	if (err)
-		table_iter_close(&ti);
 	reftable_record_release(&want_index);
 	reftable_record_release(&index_result);
 	return err;
@@ -595,15 +585,15 @@ static int reader_seek_internal(struct reftable_reade=
r *r,
 	struct table_iter ti =3D TABLE_ITER_INIT, *p;
 	int err;
=20
-	if (idx > 0)
-		return reader_seek_indexed(r, it, rec);
-
-	err =3D reader_start(r, &ti, reftable_record_type(rec), 0);
+	err =3D reader_start(r, &ti, reftable_record_type(rec), !!idx);
 	if (err < 0)
 		goto out;
=20
-	err =3D reader_seek_linear(&ti, rec);
-	if (err < 0)
+	if (idx)
+		err =3D reader_seek_indexed(&ti, r, rec);
+	else
+		err =3D reader_seek_linear(&ti, rec);
+	if (err)
 		goto out;
=20
 	REFTABLE_ALLOC_ARRAY(p, 1);
--=20
2.45.0


--IXIZxCU8zoWC8EhZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY7XBIACgkQVbJhu7ck
PpTwqw//dSCPoIMiKTZ3mDQA8KBldnP2z1/W99/Y+p7qqKBgqB4ju+ZhxeU5V8Nz
vVIZzYj101um9+FzqwObktG7NSYuMFcaNG9kLT4riwMaFvwglK4GICyNyROFwpmB
iqgf/6Xp+/2aQrr8tKNZZR1hGoSFGdWO5I54jXDffr48VTBEXpxzGRd/RpeueQ/X
loG/9B3uwgSMBzXMi1yKEah5PDAebN538xvnXB/Z1HFnEm0qPoQeYSmZsP1bI+jV
TrRMtiUtFHrFogyXxbURdnrueNBZDnVhAMicU5M9le8ofi7BjYJbu+N5MaAy+Oa4
Ak5exxVffEDxywUJcwh3KRRsDExgJ5E2iLBD2bZO+xb669JyqCLpPQoSUBjqTF0x
K/MQNWJUFhAU//uJQOPeCXaP9AHYJkyAsJENVEHU8KbARGOSxRUz8JROOZhMEO3c
J75D4WabQ2ZpyfRnFXNT6Ugu2nSMF2oebEa9RzhnseT+pqrMsn5ZV4TJ/jHgS2ZY
Bt4DKHOgzYRCO0tp5m/P0p+i3Ehej7YhVbWLTUaHsA9jtqHNyuLP1zTxmviVRssN
W8SMUrKz1C7k43//QDCak/hPKv+ud2H7y/ASd/dBuIRHQPpfBNh7Gphu07qUNZb/
8uJ99cBSewjL9QJhae582+0JhFg63TMM6JfogEHyKiCw/l6drrc=
=+cfL
-----END PGP SIGNATURE-----

--IXIZxCU8zoWC8EhZ--

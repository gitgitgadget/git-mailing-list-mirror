Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E807D3E4
	for <git@vger.kernel.org>; Wed,  8 May 2024 11:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715166252; cv=none; b=qa+AE1604CLFtJkC/e+EPfch1PPItqJGI4eZmQIF4qEC8xgiPW/ww8PTDASCXKkPFu4NuUaXOjdl4SknXVR7sqxnRIwK8Kde2TQNGm/V+GPRrffdBPrt4KauhCm6bs/jVRlsM1CE9Kpq8WbSbP48slSU5/+fjES/kQ45XzYYomA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715166252; c=relaxed/simple;
	bh=ymd+W+XhHeze7Y302xsI20R6tW37iTs97UpHiK5ZFPk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyrU3mqGkyPCsplHydckJPlBPfpNZ/RE1sg/b36t3uKg9MjGCwxcYMoBmxR/HbOWteS6v6Zs1Jplm92Du+RSEdKGK689G0l7MQ4jsDhGpEHMw+BXZyYGuPp+aD47fCEtXOwU8Ix4Fn9gJIsuG4gNAX224t9GgLI0bbkz+d/l9pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rVb4k8HK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IuigPLfP; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rVb4k8HK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IuigPLfP"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id A10DF1380FDE
	for <git@vger.kernel.org>; Wed,  8 May 2024 07:04:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 08 May 2024 07:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715166249; x=1715252649; bh=zVBGUGV/eg
	XtFwbV2pCtgbleW9ndFrATnQwSlh6ghyU=; b=rVb4k8HKLYZXlNKo9S6r/dHbbg
	UTm4R4EAOXlDR91TY04DtC5ctOpDqgJrhinf4aLmVKmMu5oXjl/OvVfpudKNhQCM
	wIxkUaMmlUzs3ZI73iRQs6SHICpZk0r1A2ZbXpfInyeirJ2RQSTkT27O806tD0YD
	ODsCCeSE8di7U2lpb/F09B9PZwzDXtoPerumuzUB+TrrX1EyzXr5JzhSZh5WbbV7
	oR3Km4wIBTJ+FsAmHhWkDQz/qa42HHOFK1pqDAKAoxXJSKLdxlQtJOJsFVlrYX6E
	SqtbqovTWWefffz8ZwG9/SGlch3YSsS38/Wmn5TmwNSBp7U5VV1nMEiS67qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715166249; x=1715252649; bh=zVBGUGV/egXtFwbV2pCtgbleW9nd
	FrATnQwSlh6ghyU=; b=IuigPLfP3DjGnvUMZae3YDKnbS0oi7egxr5teP1Svkon
	4wk6qCvojFcMpX1mcNC0ao63Aee7FKbp+UdSL5T614frRHj1s4nIF3/gBgdW1Fy1
	FNDU947OcgivkHhfSj/FyikYkAWgszouCiDWccdVsFz+AD7J7p5UnJAV04037EwU
	FYvesVULaTUfYFLoEHT/1aA4AhcT5MiU/fJSLzOnm8PYyV+xb7j31Q/E8ZnJQYrj
	BXb3DLMWQ7V/79uwHdFHO5apaiBrPVXZ192CAnOMUacF2lAeONMhi+ZIgJUJ6Eo1
	PXMnk0Mze7i/cED2W1YrIFiydAIR1gTJpKkEB+1iRg==
X-ME-Sender: <xms:KVw7ZiNHm4fPOToFBjFpM8L9IoRmFGvcOi-NbmbNxNiyLAn0A0fiFQ>
    <xme:KVw7Zg_YQHU27APR-FgCmVNfBLapDMEj6KBVbsaECwQVGFG1GcBFzq1bBROK5nwuo
    XBEEPvHAHvRklXH5w>
X-ME-Received: <xmr:KVw7ZpTQ7VU-XGgE6CV2PJfHbVHkEeDiuslFTchoI-DeYxDBnTsv1Q3GHboTZMCR8siGNRHERkTAiau7PqYUvCSC_S9_4J_u-7MEkDAUATf5eMIYag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeftddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:KVw7Zisz-iREEgphyHA1r7Z72yuGwJrO4NcbHB3wFhtiQEpxhC1rxQ>
    <xmx:KVw7ZqcvaDqRM8-xa1UOS6gUmkMH9-GjE3nap4Advz2LGXdioXdI-g>
    <xmx:KVw7Zm3wBrohHIcIMFyBVJ-GF2QW1Auraix0_7KG2L6azRULVqSLEA>
    <xmx:KVw7Zu_dDw6VBshlXMpIvUisu6uTWtRbFCfjdZCkcazN4WrMFmnvvg>
    <xmx:KVw7ZuFYll9W4vN2NfxaWRlkhZqRB5R06u6s2o725g5i9ZrgsoRoA2mK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 8 May 2024 07:04:08 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 84345899 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 8 May 2024 11:03:58 +0000 (UTC)
Date: Wed, 8 May 2024 13:04:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 07/13] reftable/merged: split up initialization and seeking
 of records
Message-ID: <21b3e3ab5f04e66fdd352187b1da699d1ab67cee.1715166175.git.ps@pks.im>
References: <cover.1715166175.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LnWxsNDADK8+mq5k"
Content-Disposition: inline
In-Reply-To: <cover.1715166175.git.ps@pks.im>


--LnWxsNDADK8+mq5k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

To initialize a `struct merged_iter`, we need to seek all subiterators
to the wanted record and then add their results to the priority queue
used to sort the records. This logic is split up across two functions,
`merged_table_seek_record()` and `merged_table_iter()`. The scope of
these functions is somewhat weird though, where `merged_table_iter()` is
only responsible for adding the records of the subiterators to the
priority queue.

Clarify the scope of those functions such that `merged_table_iter()` is
only responsible for initializing the iterator's structure. Performing
the subiterator seeks are now part of `merged_table_seek_record()`.

This step is required to move seeking of records into the generic
`struct reftable_iterator` infrastructure.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c | 59 ++++++++++++++++++-----------------------------
 1 file changed, 22 insertions(+), 37 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index f85a24c678..4e1b78e93f 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -25,34 +25,18 @@ struct merged_subiter {
 struct merged_iter {
 	struct merged_subiter *subiters;
 	struct merged_iter_pqueue pq;
-	uint32_t hash_id;
 	size_t stack_len;
-	uint8_t typ;
 	int suppress_deletions;
 	ssize_t advance_index;
 };
=20
-static int merged_iter_init(struct merged_iter *mi)
+static void merged_iter_init(struct merged_iter *mi,
+			     struct reftable_merged_table *mt)
 {
-	for (size_t i =3D 0; i < mi->stack_len; i++) {
-		struct pq_entry e =3D {
-			.index =3D i,
-			.rec =3D &mi->subiters[i].rec,
-		};
-		int err;
-
-		reftable_record_init(&mi->subiters[i].rec, mi->typ);
-		err =3D iterator_next(&mi->subiters[i].iter,
-				    &mi->subiters[i].rec);
-		if (err < 0)
-			return err;
-		if (err > 0)
-			continue;
-
-		merged_iter_pqueue_add(&mi->pq, &e);
-	}
-
-	return 0;
+	memset(mi, 0, sizeof(*mi));
+	mi->advance_index =3D -1;
+	mi->suppress_deletions =3D mt->suppress_deletions;
+	REFTABLE_CALLOC_ARRAY(mi->subiters, mt->stack_len);
 }
=20
 static void merged_iter_close(void *p)
@@ -246,32 +230,33 @@ static int merged_table_seek_record(struct reftable_m=
erged_table *mt,
 				    struct reftable_iterator *it,
 				    struct reftable_record *rec)
 {
-	struct merged_iter merged =3D {
-		.typ =3D reftable_record_type(rec),
-		.hash_id =3D mt->hash_id,
-		.suppress_deletions =3D mt->suppress_deletions,
-		.advance_index =3D -1,
-	};
-	struct merged_iter *p;
+	struct merged_iter merged, *p;
 	int err;
=20
-	REFTABLE_CALLOC_ARRAY(merged.subiters, mt->stack_len);
+	merged_iter_init(&merged, mt);
+
 	for (size_t i =3D 0; i < mt->stack_len; i++) {
+		reftable_record_init(&merged.subiters[merged.stack_len].rec,
+				     reftable_record_type(rec));
+
 		err =3D reftable_table_seek_record(&mt->stack[i],
 						 &merged.subiters[merged.stack_len].iter, rec);
 		if (err < 0)
 			goto out;
-		if (!err)
-			merged.stack_len++;
-	}
+		if (err > 0)
+			continue;
=20
-	err =3D merged_iter_init(&merged);
-	if (err < 0)
-		goto out;
+		err =3D merged_iter_advance_subiter(&merged, merged.stack_len);
+		if (err < 0)
+			goto out;
+
+		merged.stack_len++;
+	}
=20
-	p =3D reftable_malloc(sizeof(struct merged_iter));
+	p =3D reftable_malloc(sizeof(*p));
 	*p =3D merged;
 	iterator_from_merged_iter(it, p);
+	err =3D 0;
=20
 out:
 	if (err < 0)
--=20
2.45.0


--LnWxsNDADK8+mq5k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY7XCUACgkQVbJhu7ck
PpQTTg/9Hcls48cq5BuCVt8jnXqPWTqeEkvRZbOS0PGB0zvADI9WnT+HptnyhXs0
s2TQKyoeT0uApCNXjbCUAqAj2mtihEZ5bTfmp7mFsrZOETj8Lqr/7qZV6RiWaulg
Ic7iGS2Ipft3RKwfw8RFVhL/KJRQoIiKFMy9f2LVz8J0MCA6dDH//a9e4AukK5CY
gklPiGgyAOYGlzXUV/MfygauKwdXlsVZ/ux/189WypL9RJeWF+9WpoUFqAn10dlG
O00UakJLD3h0TpgdIu9FTQfxSTpH+O3ueHwx4Gb9KA63tfNy2ci3UWtxKeXPxE+9
ovjhJNuhXYGIOclVxsL2LFDMPUoeB1BN3vDNR9z/Bp0SvX2tbP8n7WT2f7udIog4
RVPxJhwm33QrhYJmE5Clv4Ss1NfRA33HaZQyqN/9eCmLNea2GIi2DcwBaL+nx1br
mpd8CXzfgyaQ7IeCQkLlEYelmIe2z0d74Vwu7cbW9neWLggdmBlN4TC2mCVa0zEt
CFwJHlX/UYuuSvYO42/CYeT4xyjnUK3qzCLNGtzx4U/8gKhx42MC3jMtKxiHgDZ+
LiRBczYt3whsCDyr0yrtpSHF+S1nAcJiO3jsw5n3u2ngQbl6XnOCGOYixIa3SNOs
Y0mg5pfhqO07zngAWl56zTcFa3P8zqCMYRQReibpgansP6YZ0I0=
=F4Cx
-----END PGP SIGNATURE-----

--LnWxsNDADK8+mq5k--

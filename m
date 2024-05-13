Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4EB147C90
	for <git@vger.kernel.org>; Mon, 13 May 2024 08:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715590057; cv=none; b=DDnOoNhGxTTl13pdswxCQEr8XwTZsOt0EVwg4lbkC3MurIykiHEYc+O++nIS030rJB0xoQbm98TMn6dkBDXhFfuBfgVKjp2RuGuXad5CDzc89yrMVQVndI8VZW9swSQi7Ih6GwA++Et5tdzsV2Majnrbh3ooVLiPgLhdGZkJikQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715590057; c=relaxed/simple;
	bh=W6wWELl+G0JcNH1+JM3SyhieiNYYlJOLHUSQ6akIVqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2vsHJyicCoV62bosieQmthECFkIhTyFV3bsfMk6oaxHHxLKgAuYDOVClNp9Uy2YBXeSclpGNRAfndYswu+NswIow4EzRaCygNsD57cgRFlPIjYvWzVGFQ32XGQMDU/d/llXPYaH7iRmB5C1w7wTu8w52kIiTF3aooG0u1ok8Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Q4NYDCjc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CKnj8LJ6; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q4NYDCjc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CKnj8LJ6"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 3D3651800120;
	Mon, 13 May 2024 04:47:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 13 May 2024 04:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715590054; x=1715676454; bh=4PCKekwZIs
	og9BptFHJ2scRgWmaSUOu756PFhah0cQQ=; b=Q4NYDCjc+xz6xjj8UfhokU7xtK
	1s1vgKwTrDunrErMd+xCHOnfzPGCWTA0RLeB0m2qbnESoWxFCQmdiRnT4T6fMLNy
	OfxaQWYsTPCkfM3LUsiNn67d4YFHCGYOOiCbf/TMeQVWX74jEfZa795oK3QXzmdo
	K4QqVb/3ZYTf8LeY/Ew25vpOslnweKMT6noMF/h/06/nyuf52a7YU8X4nd6hrK62
	h0OO4NoS1hJyvTzVU+UY10hyGqbpVB3ax1xG6bPXL8Gm6tsEzcSFe5y99Oxs5k7B
	E+R6Qep3IBshwYZCbX7GoN9oPZ3+PTJ7ZxHxUpM3WdGY9ZLshyhz9O76A8EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715590054; x=1715676454; bh=4PCKekwZIsog9BptFHJ2scRgWmaS
	UOu756PFhah0cQQ=; b=CKnj8LJ6R/eVeIvfkYCRmQWdDJPHUu5Lv8BfCGUuZVL9
	Bb2JRjKEOD4pfSOF/wd11NJrqBi0yHvW3zmXO5Bj1ez/pqXzegG5L7pRCblLDZLJ
	YyQi2j4351yUGBBMGAJObaxDTF0+swXp+lpJOxRd1AjvkHV3OI4KE2QyAbi/XpTV
	8ni9dRJqo4e+Ej0h4+6aaov9GqMREf20B/rYJinz5BqPr2zJU2qIRvRn2uKNRim3
	6dMaY1CuYhjikKEBUhAVfXikLKjCT+SXFwo75tk4bVKfyPBd1Y86x5B8ncRlh0Tz
	cD1fDWpqYbmstz3OdQZLUUlHIHwcEem3oyj8d5RXtQ==
X-ME-Sender: <xms:ptNBZky0HLybKNLPFGsHS9MP1naWTql_Rv9gIq_z_Aov09Lb0lniWw>
    <xme:ptNBZoQoO0h7L8zECfWEW49hMueZ7NPcgDaS5Ch-bnHiafA3zIorq3tet8eSK0OM5
    NLY952N58qQrNQXUg>
X-ME-Received: <xmr:ptNBZmUwp7AGkVOljNQvNDWeieMgipJr8bmtXwrfdYPVzsy8vrPRd-WGAfmmObjCrQU93xI81IlD0143TkW6VIjQm8aStlq80UhUHxoK7wsBxVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:ptNBZijFqeS6BmwnILBrVZCT_CRPB6VjhTPyd2hSbEIzWrRGnia5Kw>
    <xmx:ptNBZmCmjpCF_AF8hwlf-ZNsy8tT0QgmpK8uhsVPhnDHRznDarKyMg>
    <xmx:ptNBZjKznde-nPhqP094cfa2wlA98jINq0352FuvAgcASvjndg5nIA>
    <xmx:ptNBZtDJ2X2rWvjf9twKAiBShozRURfdlPNtWWMxImBubkVb-camHw>
    <xmx:ptNBZhONgpchrjPjo1AjA6w-tctCkQn-231q-9m6PLapK5t2ouHR2512>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 04:47:34 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1292fd8a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 08:47:15 +0000 (UTC)
Date: Mon, 13 May 2024 10:47:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 07/13] reftable/merged: split up initialization and
 seeking of records
Message-ID: <12c10fd366c30a9e615d0928c2874a6099e04e21.1715589670.git.ps@pks.im>
References: <cover.1715166175.git.ps@pks.im>
 <cover.1715589670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mhize0NoUOw/N3NN"
Content-Disposition: inline
In-Reply-To: <cover.1715589670.git.ps@pks.im>


--mhize0NoUOw/N3NN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

To initialize a `struct merged_iter`, we need to seek all subiterators
to the wanted record and then add their results to the priority queue
used to sort the records. This logic is split up across two functions,
`merged_table_seek_record()` and `merged_iter_init()`. The scope of
these functions is somewhat weird though, where `merged_iter_init()` is
only responsible for adding the records of the subiterators to the
priority queue.

Clarify the scope of those functions such that `merged_iter_init()` is
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
2.45.GIT


--mhize0NoUOw/N3NN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB06IACgkQVbJhu7ck
PpQBcQ//faIZLJ5K0oR7u1/jg5pqJoGBL9eZrQSZV+2GY9cVPbQS8j4A/2VYmxsw
m/TquWoJKBiJltdAq3JSq6XUESJsLrTjmyobcuKq0Dz6UayMwlHd+zHirUd3CSND
0nsCEAsQMOXZfLJKz7pvTiesGDdy6qzKLwCaXccSrkhEUyfpbalqbRn71PM3SfDU
w3bSwx6OxbfOia3MNvfRXNs8vMm6A4pp6GijAYwbhMQRQ0vEkEn/oeTwQOAOVpUY
5j31LLyZcWF/1S7LYU1pNmeT1/Ar/mBCCBpCPP1DsMFcn41Ler8uH7gsxREN54Gj
VrgvQrdXLc07Z3VwOz8mjBwwAweUTtwIydqJDyrsXlq9Z6eol6ok3nuqaZnqAWIi
BgYXwy4k/KGlew3dixxMctdg2pjaMM0linbEdbOgEatPksFTLr2tO2KWJp7DBbzc
vldwcTKbeDqG1bYD85Pn3OVcyvW26LKZkCn4hq5zSqBLT9/Cek9WG6cPL3ozKI8Z
1rWd5yeOZRerGsMDCFFaILFlF0OYfC6tteA5y66e4NlcQiw/OHZiOnx6TYYnxVSp
miZuqqTZ/oK/xofZ+fNLL3r6zjZbI0V48wJjlariVaeknCjGPHQdqpHPSmTc+g1z
X6tg3D+JapLn8jPFnMgDG4hsqreZxwlTC7ZJY20wv6/yqrg9UyA=
=bRBf
-----END PGP SIGNATURE-----

--mhize0NoUOw/N3NN--

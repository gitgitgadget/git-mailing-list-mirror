Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1C8364AA
	for <git@vger.kernel.org>; Fri, 17 May 2024 08:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933976; cv=none; b=YunBY2fRnVUZh5IIClwREFY4zyUWN6E684sC96ebJTbGMdhlPgSvTokBC1gL9vvBDI/CLti7dY7yF9Y+opSeqCL5VEsSPOo55nqQIHrsSUf9jNxhFqBuQpSze0nD9LeCvCIU7akc8PLKmKGsbEmUNyBXIPsGdR3RV8VpCY8OEx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933976; c=relaxed/simple;
	bh=sQgH96BBEWRMw0xcKtr7NM99pSQCrObsbRf7lJDuqiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5lGN76MfS/6Clly8vPZd49rDp6JrkUKgO23j12VximydzHt7i6nixr28lakHHenUvbcwRy0BmoONB9Ds2wpc6Gyz//W04NnH/zlrVxUZyqoCEac++bJzInEAE7oX2kHNh2X+9qbkX8OITb7IQAPzqdGjZyW0mPXOxHK+1ANXxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZXlnqdR7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ICp7i/Mv; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZXlnqdR7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ICp7i/Mv"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id BD0751C00131;
	Fri, 17 May 2024 04:19:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 17 May 2024 04:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715933973; x=1716020373; bh=EEfZmMakaP
	p4LmtmSpKTotHeZpRiDtp7DU+YAikU82Q=; b=ZXlnqdR7K7kuvOIQ6o1WfdhoiD
	d/6u2g9GdQqRh6nQrVfL7/qq9IKaNZb6cmwx+xOlm7rN2xcu1dUbsUL8+VyrRJTS
	R/4ti1mLLtz6CPWGuJswc2GyzWxW0MMXpOX0Dl1FTSKKtLfTsZAnCAzQOdDvuWT1
	uyjq3t7CLXSOSkhszrCSdRbJGZgE6bvPY9f5CzW4PBRs7ZbPFOaZG0ZEFaMAQ5+o
	+3eLzX7k2BYVgPCCW4Oc8Ivxm3Y3Uipe396OwAieEAlmLXSOcoTUtOqMrEJQkZ2a
	4U+f3hwU2q177PFMyZYq5pLORO3Zrb65qDRn8Hf41nIdnGYBCjypbNu///yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715933973; x=1716020373; bh=EEfZmMakaPp4LmtmSpKTotHeZpRi
	Dtp7DU+YAikU82Q=; b=ICp7i/MvEcq6zFx2Z4y5UynUYJiAvlD/8NG5GnuQTiXF
	qOdzR7yi/UreQcOdq8CEL2WO6tDJMEUAhTq3m/uh3BRhhWHL4QsQNKQK7YidvivU
	uIDy1SuWWo4W0VfWwLYRfOKr9ojCRWDSFTuL/NUBnrBUa3ZeRvVZ1LmKdATD8cLi
	A7LXIcgHeqJtFWsEmXdd2X+iR0KSmDO0OfV+V/QW4Y27hkB1RvL1NptFff82VjZi
	Gx9A8zBn6PV5hfuIIopgRGuMPsikaOouzbsLLX1V1HshBuzvahh77j04hKi5LMBa
	TQ3iZRqCXWz9sUUfHCxG1ZWb3iyZfugLgwyQ6kWkOg==
X-ME-Sender: <xms:FRNHZrBa9SBnobKPHfGo_2-Aksc_Sl--fUicsbe83T_Gwy38NUg6PA>
    <xme:FRNHZhjZJ_rQy7FKmbMXFEw0Osj1u4mjMDV049dHgxH6vmr87Qw8uF2XEyLsuOooG
    zG26xQfnDQcnT9ZpA>
X-ME-Received: <xmr:FRNHZmlXgzn6H9RFVULyx9gkYTCJaVcrNEW_uX9XR6mnDegyK6AYMcJu6d62FnuGzNWuLgTepT1ikG2mYSpjF2oRS5ATCPd6H53LGYe6CBEFBEF9Dg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:FRNHZtz5I2W0dFcUEz0joIS5N2DsdCLhXsMPHqNlNuKKm4WRL90Ycw>
    <xmx:FRNHZgTP4L1OCP74gjD4N-E0EoOjWPskS1Jd9IHwhoDYJWpGaSRJkg>
    <xmx:FRNHZgZZTKME4x5lfHbYp3cH_oDuqhObZcpgM-QpJXRNcTL1tm1cBA>
    <xmx:FRNHZhTdoteMseEKOyHGV7izhsZQyIZuLjcQWFiGqaYyzcqNVKLguQ>
    <xmx:FRNHZmeZqPWwZuLm1o__Ng3DKO4fNeZLArfGn_-CNsmTV9Z4_coGY9Ql>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 04:19:32 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d60cc6bd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 May 2024 08:19:05 +0000 (UTC)
Date: Fri, 17 May 2024 10:19:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 16/16] refs/packed: remove references to `the_hash_algo`
Message-ID: <5ebe81d8c3410f88e5f6be6383fc301a48fb9eed.1715929858.git.ps@pks.im>
References: <cover.1715929858.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/E5Mnzv7JjWzH9Jl"
Content-Disposition: inline
In-Reply-To: <cover.1715929858.git.ps@pks.im>


--/E5Mnzv7JjWzH9Jl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Remove references to `the_hash_algo` in favor of the hash algo specified
by the repository associated with the packed ref store.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/packed-backend.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index dfdd718eb9..78e26bcf41 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -200,6 +200,11 @@ static int release_snapshot(struct snapshot *snapshot)
 	}
 }
=20
+static size_t snapshot_hexsz(const struct snapshot *snapshot)
+{
+	return snapshot->refs->base.repo->hash_algo->hexsz;
+}
+
 struct ref_store *packed_ref_store_init(struct repository *repo,
 					const char *gitdir,
 					unsigned int store_flags)
@@ -289,11 +294,13 @@ struct snapshot_record {
 	size_t len;
 };
=20
-static int cmp_packed_ref_records(const void *v1, const void *v2)
+static int cmp_packed_ref_records(const void *v1, const void *v2,
+				  void *cb_data)
 {
+	const struct snapshot *snapshot =3D cb_data;
 	const struct snapshot_record *e1 =3D v1, *e2 =3D v2;
-	const char *r1 =3D e1->start + the_hash_algo->hexsz + 1;
-	const char *r2 =3D e2->start + the_hash_algo->hexsz + 1;
+	const char *r1 =3D e1->start + snapshot_hexsz(snapshot) + 1;
+	const char *r2 =3D e2->start + snapshot_hexsz(snapshot) + 1;
=20
 	while (1) {
 		if (*r1 =3D=3D '\n')
@@ -314,9 +321,9 @@ static int cmp_packed_ref_records(const void *v1, const=
 void *v2)
  * refname.
  */
 static int cmp_record_to_refname(const char *rec, const char *refname,
-				 int start)
+				 int start, const struct snapshot *snapshot)
 {
-	const char *r1 =3D rec + the_hash_algo->hexsz + 1;
+	const char *r1 =3D rec + snapshot_hexsz(snapshot) + 1;
 	const char *r2 =3D refname;
=20
 	while (1) {
@@ -363,7 +370,7 @@ static void sort_snapshot(struct snapshot *snapshot)
 		if (!eol)
 			/* The safety check should prevent this. */
 			BUG("unterminated line found in packed-refs");
-		if (eol - pos < the_hash_algo->hexsz + 2)
+		if (eol - pos < snapshot_hexsz(snapshot) + 2)
 			die_invalid_line(snapshot->refs->path,
 					 pos, eof - pos);
 		eol++;
@@ -389,7 +396,7 @@ static void sort_snapshot(struct snapshot *snapshot)
 		if (sorted &&
 		    nr > 1 &&
 		    cmp_packed_ref_records(&records[nr - 2],
-					   &records[nr - 1]) >=3D 0)
+					   &records[nr - 1], snapshot) >=3D 0)
 			sorted =3D 0;
=20
 		pos =3D eol;
@@ -399,7 +406,7 @@ static void sort_snapshot(struct snapshot *snapshot)
 		goto cleanup;
=20
 	/* We need to sort the memory. First we sort the records array: */
-	QSORT(records, nr, cmp_packed_ref_records);
+	QSORT_S(records, nr, cmp_packed_ref_records, snapshot);
=20
 	/*
 	 * Allocate a new chunk of memory, and copy the old memory to
@@ -475,7 +482,8 @@ static void verify_buffer_safe(struct snapshot *snapsho=
t)
 		return;
=20
 	last_line =3D find_start_of_record(start, eof - 1);
-	if (*(eof - 1) !=3D '\n' || eof - last_line < the_hash_algo->hexsz + 2)
+	if (*(eof - 1) !=3D '\n' ||
+	    eof - last_line < snapshot_hexsz(snapshot) + 2)
 		die_invalid_line(snapshot->refs->path,
 				 last_line, eof - last_line);
 }
@@ -570,7 +578,7 @@ static const char *find_reference_location_1(struct sna=
pshot *snapshot,
=20
 		mid =3D lo + (hi - lo) / 2;
 		rec =3D find_start_of_record(lo, mid);
-		cmp =3D cmp_record_to_refname(rec, refname, start);
+		cmp =3D cmp_record_to_refname(rec, refname, start, snapshot);
 		if (cmp < 0) {
 			lo =3D find_end_of_record(mid, hi);
 		} else if (cmp > 0) {
@@ -867,7 +875,7 @@ static int next_record(struct packed_ref_iterator *iter)
 	iter->base.flags =3D REF_ISPACKED;
 	p =3D iter->pos;
=20
-	if (iter->eof - p < the_hash_algo->hexsz + 2 ||
+	if (iter->eof - p < snapshot_hexsz(iter->snapshot) + 2 ||
 	    parse_oid_hex(p, &iter->oid, &p) ||
 	    !isspace(*p++))
 		die_invalid_line(iter->snapshot->refs->path,
@@ -897,7 +905,7 @@ static int next_record(struct packed_ref_iterator *iter)
=20
 	if (iter->pos < iter->eof && *iter->pos =3D=3D '^') {
 		p =3D iter->pos + 1;
-		if (iter->eof - p < the_hash_algo->hexsz + 1 ||
+		if (iter->eof - p < snapshot_hexsz(iter->snapshot) + 1 ||
 		    parse_oid_hex(p, &iter->peeled, &p) ||
 		    *p++ !=3D '\n')
 			die_invalid_line(iter->snapshot->refs->path,
--=20
2.45.1.190.g19fe900cfc.dirty


--/E5Mnzv7JjWzH9Jl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZHExAACgkQVbJhu7ck
PpSx8w//e0xhhIfOVHL0TLor0pHct1s9E6Ke9YnxxWWhK46JsszC3sGJmry0ESaz
B8Wh6icuv9N1uSRjqBsjgCAbhjTfELCTNjbiAnDS/lsYkGCACALLQ1ElVdK1DIkl
pAP7V5zoYu3Kq0gK6ZoN2VuObYRxD6oitB01pOPA+o+bqbht3bX7+0c/eRkjSIi1
h5vzXReq+yLULJbpCkpF8QjQzago1IqUJVZhl6YBmmkWDy2hPgKIHYaoCY+/NXAo
lnAd70bwrYB4NLk5iMVUdDtCQ+LVVcRKYIDyRWDI+Gve05XkR232/aR6au11+WQO
2fWYTrw+u+NpOH0KlwIBnhvXOALioEDArQzIgKgZyv38tZO0/kxE9jltssZNPziG
fSaG6gG9QDt1NFQaSj0b3gnvm0yt2VNZ9HfRm3ITqWXTFeHa8GJLvTBS5hov3swQ
tTZY0Sv10W5WHeSyYrkkpuustk2CsSPCZSwV8EplchhZTKEAr6EtdoCrsQuAMKAf
ICKYSTqhrbEdcJT7CocNyiX5KngFOnDwFHIt1vuVq9lX8W9WU3Ke0kvjJbWn+Y5+
320tSZtza3xTxEckWRCVLzd9Hk12T/2ojDhaxPWvSM3yGMDo9HLtOfNEIbHBXDOi
HcTwgSg2tUtNoreY4bdnXqMeOz1PlkoMFrKBaxQeKEE/O/qKi3A=
=mno7
-----END PGP SIGNATURE-----

--/E5Mnzv7JjWzH9Jl--

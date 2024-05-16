Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73300136E39
	for <git@vger.kernel.org>; Thu, 16 May 2024 08:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715846733; cv=none; b=TrF2aOrvi1AI3h3z86HKion9syRX/Zt7d/jsdQoiPOP6fqqzQgMz29gzufvEIRL+5wY4/gpHmwfMK++Pvuep+F2qdq95+GyXOX/1PH+6AF8JIU1n1gQ8+cAomAUtKyCunqJdAfDmDUTNec1kkAVK9nDsgng8qWNrXxRywS3pQ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715846733; c=relaxed/simple;
	bh=4XJ6jVpXKTPjeuntCNxe7awvp1sE+w76XOV6Tx9VC+4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8b7zbHZdfZOOm1N4DS6YvbWbNh6CzdaZChHEOWKueJGTyfxak8N6It8eHJOqcuVf++1m8r8v7HQIKwgDuY7jAX7UESt29FL98prN92DO5iJOKPvmQEheOFj6SXY075K/b4UG8J/NTO50YxW59W/dl9E5P/tQFXbTck4HBX+CzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Dqju44WL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XvvGu3Sz; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Dqju44WL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XvvGu3Sz"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id BE4E01381145
	for <git@vger.kernel.org>; Thu, 16 May 2024 04:05:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 16 May 2024 04:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715846731; x=1715933131; bh=F6MUewRA2T
	tJ1AY+PZLF91qbA4jG0fuS7iUAyz68kp0=; b=Dqju44WLllT5mEYmhCIlgW++VJ
	F05yZYrRvl6vpf6T2Zuykl3VB9UU8Ve8sXLQnquklePm20JVUyWK4pCe0olKcm2W
	WXsFsRIHzNzXPsyC9RRjy8GGJoKBbaR2FjfhtjezGB5cUnnNqrAur+hRfvFO22M7
	eee2idSTd6nQxPR6Pk5b/kIOw+H6QmH1dJisv86I2+Cy3GMMhhsfQQ+QOo/8KVIk
	b41uyfpFtBSKvEfvN0XdEg0fuGSdf5Ro/blBZJKzJlVFM0U9Wzj8MgrcyDgA5u/V
	5XJSujaWkH0M3JF9t5HuwTBKIDBJszsz20n4fmhM+NUjJz8t9seAygrvFYIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715846731; x=1715933131; bh=F6MUewRA2TtJ1AY+PZLF91qbA4jG
	0fuS7iUAyz68kp0=; b=XvvGu3Szwfy7qWZ6o17QA7Cp92LoVuXgYHohyJCKlT4w
	W9gg4KweFUfsOyHQqPZvoDgTK9bTT5+qgYzJirUt99M21SCyrkeg6OrRpFp7O6/n
	XG1z0S2njEyg4TnI4zj0pYGSfbJ9c7ZVBtRmLa2Rn5EhOp7Ol1fkD6eRxko/589f
	5MVduhZ0aYhCHCPQJ0u3/kRgzxeKibA61TWjjU6lAE752IJNPTTKcPJ/dorZy2pL
	lbdLTKwTYjJObwZlc7GilytRA2oTE+v5KRyAiTnQxo2IcGRtZuTj+dd4QG1doPBa
	3Izn6vglEvFtMd4vVOnBbecKbkybDVSikdPAwlKCWQ==
X-ME-Sender: <xms:S75FZtq6JvTLTOPOySSgvkUsWmzwRhSIOCUiLgyHYbthI-wRTtwywQ>
    <xme:S75FZvqGS1Uuok3Exznt_pYFUhNQXrnZodeLWfgJ8RJ_NYwahrsHj59qKtDEsGHj9
    sWdVsJ9cOZXjgOTDQ>
X-ME-Received: <xmr:S75FZqNsRV5-8aeT-vO7Z76OugIkdqy2OSmh7J0gPCBmxm2mOz5pmhW5_Ga21HCwUU6VdVvHk2RtcVj3WpkHCT_j7ixHSpUmzONyFjJ_6ruet0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehtddgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:S75FZo4fUUjaCXZcmUFSvtMM_cbR2o_YbrE4KJK2BlhF47VRw_Bqag>
    <xmx:S75FZs7HDySP6bSUJqlSaoO4d34ZAGPsWaBA85cLCmFvlO01_8ZXOw>
    <xmx:S75FZgjDCd9cIy8gCGrMmrHelffDYFhGNLp3msED7NHmdkYmd89KYg>
    <xmx:S75FZu7LXuowrsnlygTalC_NdNHoGWUcx3Ddfd8DmikyCDR67gVgyw>
    <xmx:S75FZqRO65EBrvcIt1E8aMj5hmiDRbyY-0HaeDL6cL1Pansl1QT3KbkP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 16 May 2024 04:05:30 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id deca745f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 16 May 2024 08:05:06 +0000 (UTC)
Date: Thu, 16 May 2024 10:05:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 16/16] refs/packed: remove references to `the_hash_algo`
Message-ID: <9cd554166f61b0d1c17b45682422ed9a91814c03.1715836916.git.ps@pks.im>
References: <cover.1715836916.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XD5cHuwhDMLcjUha"
Content-Disposition: inline
In-Reply-To: <cover.1715836916.git.ps@pks.im>


--XD5cHuwhDMLcjUha
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
index 1b06fd936a..1d24c1ff28 100644
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


--XD5cHuwhDMLcjUha
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZFvkgACgkQVbJhu7ck
PpTN0w//Rvch8IBJpBpKJZQGrMdeKtgA3Hz1CtSocPLHzFAvyuUhl3H558Us1d8U
cm3NlF6A2XYs5qjTAlvr7CPQuDEu5rczmgToBL7C6q/GviZd6t+KBu+s2yu7Pb7z
GmNoHK8x8NHfwHNTKgDFqEwXKw8sO5HJKPTv6jO1BCz8ol9j2DZVkDO+a/sEQVo3
ANot7efJNAqkZtsVkilCY5Ep/ZyYc8GSjhikPoXWSgm2EzvdsuIZv0DnGrItazHj
B3P1UJ4KT3EVbnzlOkWuKOpGb6JPp6tHtFh2/oiCZbGbN4xhsoOuXeCc/UxhO7yP
kuoTjFflxpRa/w//5g3yk9RxbU7t3pUIKDv3Cl1shJU9nHtgxs7LFRIpBMLfgQVh
xRK4LlEajHkFGp5gvxmqYxgwAk9GZuLbs7m6myAmWE/bv6MFaupLHH2ChZKb2My2
GEJe3K9Hrb4301HFBeL8pBArjiPJke1KWE2tDsrg2ZEzcqoyjDHNgE88oIIxJJ5h
zrKFxyuTXDRgFpPB9pfk6eKR09Kbm7Lu3+pz9icE+SkfaFAQ9hDAdyTnzzUVsykU
+E4wHk+WYnGcWtzeoD1EKUjYpkHwfdRpIe1s07QTXkxBIuhxClL1qaYFb/LwWle6
x1XMG140QrfGNvRJauflZHqQPDNYC73MHusB+6JYUL3DZsRgcvo=
=z+fX
-----END PGP SIGNATURE-----

--XD5cHuwhDMLcjUha--

Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A465182B5
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 07:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707896800; cv=none; b=jL6Ptd7Fr4k9mi3ENG/cmXMi4OoBUt8kHmgi+jIgt6dhuINyEFxKjM1lMB32b3okmjXIVKtvZ5TTAQC1K5jB/KAFnmR36vRrulx/QIK/25qDEBG0PUvlX6W/h0r17E7y1qGBD/FQZXVtcU6/zzt+uXE7eKlkrKAn2EDxuhhegHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707896800; c=relaxed/simple;
	bh=663k2VAlLJmdXrzi0dG+UZBNaFO9JZI5q/HcImxvzwE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WINkT2hYVZCfE9WJMcBanFLUAm5voLarXnYBiaIfhWX4voXrZcJMQsNA1ysLZe4Vtzx84BRJ4vvEcJGm2XapZRIjoQU3IeUolIVzFYYrNJ3+N8rU76BPoeoI7XoyuNZ+qDJANWc9Iidqm3Hqc8bUks8927xwV6XLy2zRdCSmQQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GT5V8hVn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NBEKhNwt; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GT5V8hVn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NBEKhNwt"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id B4F9C18000B6
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 02:46:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 14 Feb 2024 02:46:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707896797; x=1707983197; bh=mvxIMSRVBQ
	l3HPKdWUjVQP5XHUxlJVA2gjR4UJ/mn7g=; b=GT5V8hVnXXcIk93k0o3eIrzfYC
	0IbEBu6AchURk/SrOPVm+uUYKMhyny9WPGGV9c0pHYKE+WU0/lCZCyHG0pWacZJw
	jIf+ZuAVZgYQ9la+laudzHh3SdXRTcZXqAjo/JJQX2yPg+TctsmynMu3dTNDR1dJ
	zed2rqj/DUwuxatO7CHORiAB6gFzGMtgfpyUDvZ98qO4iJnM2ipApdNlWKYQgiBt
	w9fx4vIIeN12OAhjcPpC+HtrLskiGpKek29Zv56G+lOPgHx0Pc6RrfcVw8TQoya6
	Or1i8C+OcGrpyoidwnXhnLebbBnu1VOykd6skWNUuf6sO5hSBNyHASwpDvzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707896797; x=1707983197; bh=mvxIMSRVBQl3HPKdWUjVQP5XHUxl
	JVA2gjR4UJ/mn7g=; b=NBEKhNwt9bAn54zhFwf/tsy9Ivxx6HNabVCQdOlh0D6L
	igE12zWHx7LoBOM+vwWboNQII1YiWEttaNxeS1Ybxb1qtaPswuFyT+VVhJ50Kxbc
	RUouR/oPckfSDBIaxzO8ss6T4vRgtVOOFv5kdgBJ5XXhanb1Oad1kuHx1IxK0T4k
	S2lBdCmBhCwOGoWiJ7txxxCxI1z59UBD8w+1No3BV+43gzehN7akDBSgbpgP3yxP
	l9JTYgtal20pmWOmUaplphRHkxiraiMLQbJIPjDS4NRvY1rnoJhKMwF8IDlAh1Vq
	UOd3/H2QwCbeqwmPOuJnBihW6NCRhuAzNSsA3n1JtQ==
X-ME-Sender: <xms:3W_MZaDaVZgAlf3dbHVZ2eFkMg2gOGXFH5OZJPdoAhM6FO4w6acYTQ>
    <xme:3W_MZUjyb5J0GLG7N0imKm1HK7crFquMi2nGSx5kBPBGgNbxYNnq1-081I8URo9o4
    mgOWyp9iDU6HDxR0w>
X-ME-Received: <xmr:3W_MZdkwF69J9uVZdxUqLs4ZCJrd-Y7yiwmu7zf7mOuXumrQvj20-cqlyFPe7sekVgDQ-Q6QP8cwL5ZrfW-MEhT1KFJ0p2GRLJHtCSTcGBVp3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeigdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhephefgjeeuveejteduhefgffefffdvjeefje
    eivdekfffgkeeugfehveetueefleeknecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:3W_MZYwust0TehmUl9z4gQYlB11RmeMn5oXldnfaGzL_AK3_lywZPQ>
    <xmx:3W_MZfRdAwj24MONXAd0-JaI0z6xdTXf6IpxfBtbVyQoSXHn3gwblw>
    <xmx:3W_MZTbVriXmY1xS_mozLk5C1ks1JXqb0lvipeFIvKzd6xqutOSCiQ>
    <xmx:3W_MZWL_cwhW1hIgCQQbghXc1-7yXLU8KjT6EQxJ-cUIOHHHnu3C9fNdQP8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 14 Feb 2024 02:46:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d8e0bb08 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 14 Feb 2024 07:42:47 +0000 (UTC)
Date: Wed, 14 Feb 2024 08:46:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 12/12] reftable: allow inlining of a few functions
Message-ID: <56ec6549326e52d88e6d063ce1a9f26b2a805d09.1707895758.git.ps@pks.im>
References: <cover.1707895758.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bSlYyY+HdEaVmLM+"
Content-Disposition: inline
In-Reply-To: <cover.1707895758.git.ps@pks.im>


--bSlYyY+HdEaVmLM+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We have a few functions which are basically just accessors to
structures. As those functions are executed inside the hot loop when
iterating through many refs, the fact that they cannot be inlined is
costing us some performance.

Move the function definitions into their respective headers so that they
can be inlined. This results in a performance improvement when iterating
over 1 million refs:

  Benchmark 1: show-ref: single matching ref (revision =3D HEAD~)
    Time (mean =C2=B1 =CF=83):     102.4 ms =C2=B1   3.7 ms    [User: 99.6 =
ms, System: 2.7 ms]
    Range (min =E2=80=A6 max):    99.1 ms =E2=80=A6 129.1 ms    1000 runs

  Benchmark 2: show-ref: single matching ref (revision =3D HEAD)
    Time (mean =C2=B1 =CF=83):      98.3 ms =C2=B1   3.7 ms    [User: 95.4 =
ms, System: 2.7 ms]
    Range (min =E2=80=A6 max):    94.9 ms =E2=80=A6 126.2 ms    1000 runs

  Summary
    show-ref: single matching ref (revision =3D HEAD) ran
      1.04 =C2=B1 0.05 times faster than show-ref: single matching ref (rev=
ision =3D HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/pq.c     | 10 ----------
 reftable/pq.h     | 12 ++++++++++--
 reftable/record.c | 11 -----------
 reftable/record.h | 12 ++++++++++--
 4 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/reftable/pq.c b/reftable/pq.c
index 0074d6bc43..7fb45d8c60 100644
--- a/reftable/pq.c
+++ b/reftable/pq.c
@@ -20,16 +20,6 @@ int pq_less(struct pq_entry *a, struct pq_entry *b)
 	return cmp < 0;
 }
=20
-struct pq_entry merged_iter_pqueue_top(struct merged_iter_pqueue pq)
-{
-	return pq.heap[0];
-}
-
-int merged_iter_pqueue_is_empty(struct merged_iter_pqueue pq)
-{
-	return pq.len =3D=3D 0;
-}
-
 struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq)
 {
 	int i =3D 0;
diff --git a/reftable/pq.h b/reftable/pq.h
index ce23972c16..f796c23179 100644
--- a/reftable/pq.h
+++ b/reftable/pq.h
@@ -22,12 +22,20 @@ struct merged_iter_pqueue {
 	size_t cap;
 };
=20
-struct pq_entry merged_iter_pqueue_top(struct merged_iter_pqueue pq);
-int merged_iter_pqueue_is_empty(struct merged_iter_pqueue pq);
 void merged_iter_pqueue_check(struct merged_iter_pqueue pq);
 struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq);
 void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, const struct pq=
_entry *e);
 void merged_iter_pqueue_release(struct merged_iter_pqueue *pq);
 int pq_less(struct pq_entry *a, struct pq_entry *b);
=20
+static inline struct pq_entry merged_iter_pqueue_top(struct merged_iter_pq=
ueue pq)
+{
+	return pq.heap[0];
+}
+
+static inline int merged_iter_pqueue_is_empty(struct merged_iter_pqueue pq)
+{
+	return pq.len =3D=3D 0;
+}
+
 #endif
diff --git a/reftable/record.c b/reftable/record.c
index 37682cc7d0..fdda28645c 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -1176,11 +1176,6 @@ void reftable_record_key(struct reftable_record *rec=
, struct strbuf *dest)
 	reftable_record_vtable(rec)->key(reftable_record_data(rec), dest);
 }
=20
-uint8_t reftable_record_type(struct reftable_record *rec)
-{
-	return rec->type;
-}
-
 int reftable_record_encode(struct reftable_record *rec, struct string_view=
 dest,
 			   int hash_size)
 {
@@ -1302,12 +1297,6 @@ int reftable_log_record_is_deletion(const struct ref=
table_log_record *log)
 	return (log->value_type =3D=3D REFTABLE_LOG_DELETION);
 }
=20
-void string_view_consume(struct string_view *s, int n)
-{
-	s->buf +=3D n;
-	s->len -=3D n;
-}
-
 static void *reftable_record_data(struct reftable_record *rec)
 {
 	switch (rec->type) {
diff --git a/reftable/record.h b/reftable/record.h
index 91c9c6ebfd..5e8304e052 100644
--- a/reftable/record.h
+++ b/reftable/record.h
@@ -25,7 +25,11 @@ struct string_view {
 };
=20
 /* Advance `s.buf` by `n`, and decrease length. */
-void string_view_consume(struct string_view *s, int n);
+static inline void string_view_consume(struct string_view *s, int n)
+{
+	s->buf +=3D n;
+	s->len -=3D n;
+}
=20
 /* utilities for de/encoding varints */
=20
@@ -127,7 +131,6 @@ int reftable_record_cmp(struct reftable_record *a, stru=
ct reftable_record *b);
 int reftable_record_equal(struct reftable_record *a, struct reftable_recor=
d *b, int hash_size);
 void reftable_record_print(struct reftable_record *rec, int hash_size);
 void reftable_record_key(struct reftable_record *rec, struct strbuf *dest);
-uint8_t reftable_record_type(struct reftable_record *rec);
 void reftable_record_copy_from(struct reftable_record *rec,
 			       struct reftable_record *src, int hash_size);
 uint8_t reftable_record_val_type(struct reftable_record *rec);
@@ -138,6 +141,11 @@ int reftable_record_decode(struct reftable_record *rec=
, struct strbuf key,
 			   int hash_size);
 int reftable_record_is_deletion(struct reftable_record *rec);
=20
+static inline uint8_t reftable_record_type(struct reftable_record *rec)
+{
+	return rec->type;
+}
+
 /* frees and zeroes out the embedded record */
 void reftable_record_release(struct reftable_record *rec);
=20
--=20
2.43.GIT


--bSlYyY+HdEaVmLM+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXMb9oACgkQVbJhu7ck
PpSf4w//YAzhO/imk2C2iCto4WEfhFUGMgYpGYd03GMhLAnGiMX9iYOY6FBA6DM3
EbJyaybKmWdaM12zWg4Xt8BIVvo46DEVrwiEZJxjc9//pH5inGZkAZZH4moIBh2+
Ua2JOLKkS7zxTsZugrnpTyzKYntuxf+yddQWJBiwWTNGU9/vUFUoes1xVo8+BNSl
tILg99F/dy2c/WPRdy80IWs8FZHSCZehLGXFjcoUbjcinKi2Syz8Nm4Nx8TxwT0a
97Bk8Au76Elau6zbhrPgOk1nc5ZEzjOKjdD+np3EnIqxMBkR3tZfydgrknImLmlp
AKges/y3/gbdFKXUrSRTHlDoWd1iyRb2Mdtw5WPfAxGc1KYjNYsim7grVtGqXNZT
ut8wTHmA1imwnjaXty48CY6Q16byjh4qydqOBPapvnflKFZBuuZjuzVwR6UI+UHb
Ti9iqdE7YCtR9LCJhxmjChdQ66OGUJpPzt81p42G5wGVn7mLdgKiMpc0reXl4qo9
AKMP65oORn1+rdCiMsN/V6JPJCn1hUiqH4+4LpM83rokqUnwlKeTSkrREf1tVpiu
C82d3IrD7Z3qdzy4lQ4yKg4CT8Tc5pm9IGeDEyMAidhqsAJs/fL4M54dLiGHTk7t
HNuiEwhCkKF9CX8OFHiBbC0ptSud8TtE1VXlQ+M5MOWEyKyZrnI=
=OxKs
-----END PGP SIGNATURE-----

--bSlYyY+HdEaVmLM+--

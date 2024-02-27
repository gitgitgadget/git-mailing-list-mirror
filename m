Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E23149DF6
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 15:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046429; cv=none; b=krBJncb8iJARtVvtXNn+/eibkxHzV6b7X4dQS33BYTjRTk06/dMCyeiATjyfS7uIb3ei6DrF7R42UGNa6HwGOBxamIJdsEtIE3G8LfxwMeH5TQOyTLQ3L7zqAgXYMDuCyJ4rY4WAOyr7kXYTMpHor4kz7HrcZ2FxGxZnS0H/FVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046429; c=relaxed/simple;
	bh=bUYldofM5/5KVrLq2XzXxbCi3HafCy/fYOFC9EE0hd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQS98a08ZFNlfBD2zbdtEwB4g4cpQ2+4VJynclUjnzky8htfc17/FtztmCKGt8mfZvGJHchBgq1i3RL9F4uHNJeA8Wj8dKE4rsE3EvypP/5UuUipbKrbhF8X0nmJUQanHukDpQT/Uyd1UL/2mVhPdDglBceRq+g/CKADQHSfoTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sGTL/q1a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SVb9zaS5; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sGTL/q1a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SVb9zaS5"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 1E1493200B8F;
	Tue, 27 Feb 2024 10:07:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 27 Feb 2024 10:07:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709046426; x=1709132826; bh=OSEMD5nyMN
	JDKrQ02d15AEKiDvHwVYz5pQKSPv1ZAFY=; b=sGTL/q1aqA6DKJ4LkvmQcc47M7
	MsnYUQ4P1TDT3soz9Vsn5992U3TI9JjzFS5hbcDGDw+2wO3QP2DltERgDw6yp2HS
	DJ3ZXDdBlisqNUbp2bs64/DcECe1Z2PZedN4A90Lwi8Z3Lme8Uq10JpNFsS/hn8N
	Wny4qtb0IOirlprjAnek5NWJ9ckIsTiYsHS/pCdEmoG4G7TBBIyoyxJThqH4nvVr
	JxN+U4GRvCi5/MGWJQ+6Ja3R1c1y/2BordFQNZAWhhbk/uV8Jb4u2DR90F3h0pcN
	/OqLRDVNsIXPmK1Rdce19yKPYlps9rl6gwT5gRMztdLeNmk8TT9+e/5bxwvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709046426; x=1709132826; bh=OSEMD5nyMNJDKrQ02d15AEKiDvHw
	VYz5pQKSPv1ZAFY=; b=SVb9zaS5QF3nXlLAopdQmUhYvDVOq36RLz6kTtls9fWW
	dhH4x8xEh4uxSGbUGLOU6VlWKpKj6ng3BOT5shbQyyKtWhMDcsmpEaD7Ow4c5Suj
	31eDii/n/Ew193XIqBSFz5wux7kiF3A8QhE7/G+DQZMYfDuznnrDvcezlaXk6tH9
	nfRH+lyCQVDRgoGKMhpIAgiugyqQrbuk4kSge/5OUc8XsfDRPZIWsmECuQe3em7y
	HrTKFsvCQ/6gSyywz8hNLx4qXJlSK8lcYFuD/RvmVwSJZ7UbGiU1+ESaIBfM7E/8
	wHBybGJ97D9Gg0RJq19aaQb2fOJoBeZTLWTwyuPihA==
X-ME-Sender: <xms:mvrdZegn1vJQJReMSZDbhI1SGNle-OuUdYuVAgWjXuthdw_t8NSFdQ>
    <xme:mvrdZfCJ3w6_tqh-6IT0XZb4ntThaEgKUnZeMtvjoWELg-LlAaT-nRREVZOWmBB4K
    jqmx8s_QWiMyWZ-hw>
X-ME-Received: <xmr:mvrdZWGzu2u2F7YNk9N2xr_5tb41iIJU_EsmYo1kyGePjXlvcFMUcV1L6ZfFjyiKJadnFXPBkvGpwbo-4DDk5tV0zsl7fyAk9rAKB1cDLQ1ddCgY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeehgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:mvrdZXTyY0IDeYjgxxvttDDff0WEbbc5XvPjSKu0NFBfEOTM4SGZfQ>
    <xmx:mvrdZbw3lmdLn9id4BIIcG81qTBRVMoXmL_i6tucaRdZBAelzHNhyw>
    <xmx:mvrdZV4_P_sn4hRrpBuzZBjoGAfyJLYh6RAL3m62eOqXBiqQ5W0nHg>
    <xmx:mvrdZUpYk9QnSsela2cjLcMyGB_lCJ0B81TB62Dze9Q-MG8BiYRWcg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Feb 2024 10:07:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 50bdf740 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Feb 2024 15:02:48 +0000 (UTC)
Date: Tue, 27 Feb 2024 16:07:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 12/13] reftable: allow inlining of a few functions
Message-ID: <99b238a40da1837013c45112aa5dea38bba54df9.1709045927.git.ps@pks.im>
References: <cover.1707895758.git.ps@pks.im>
 <cover.1709045927.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gN4LQv2auTr7FWIi"
Content-Disposition: inline
In-Reply-To: <cover.1709045927.git.ps@pks.im>


--gN4LQv2auTr7FWIi
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
      Time (mean =C2=B1 =CF=83):     105.9 ms =C2=B1   3.6 ms    [User: 103=
=2E0 ms, System: 2.8 ms]
      Range (min =E2=80=A6 max):   103.1 ms =E2=80=A6 133.4 ms    1000 runs

    Benchmark 2: show-ref: single matching ref (revision =3D HEAD)
      Time (mean =C2=B1 =CF=83):     100.7 ms =C2=B1   3.4 ms    [User: 97.=
8 ms, System: 2.8 ms]
      Range (min =E2=80=A6 max):    97.8 ms =E2=80=A6 124.0 ms    1000 runs

    Summary
      show-ref: single matching ref (revision =3D HEAD) ran
        1.05 =C2=B1 0.05 times faster than show-ref: single matching ref (r=
evision =3D HEAD~)

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
2.44.0


--gN4LQv2auTr7FWIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXd+pYACgkQVbJhu7ck
PpQnNA/+OXbWhWRqkWPSXFpJ+v2++YMm0+OCS86dQ1+QZMLZzmTZV4nmWiTO7tBU
nIGwSwlb1vUSbL117bFiWu18XQyxW76MgT+KQBo5Q81n3n1BgMr8FNDWrVvpQ/Ij
2e6w6q4IRJhv5OLT4nkjTbjdi8JylgJHHUmmictU8glMbWwQI19wsKqFXAuBFmzc
jLW+GcYjF3t3AdTXI7Hr3rfMpKAPZj5o6PLL879GR/wrjrJ1WyfW8fJkWPRspGHS
y9dAg2BE7YVIMY55aID3mdaIM7CEUf3NW6tMxfeRffkg+C71KrSJTooIeReU789R
4tbbPD+r1zGyVfOxp6Lzb9FTytOefQ7WyoAuGMml3bAl1ILgnL6tJzns4l86t+1K
BuCACI01W0qF0PjuQ7gO9SXvMweUx6TZ5z6b0xiv1hGSpyCrgX9P4+GI6jgJqFtU
vbWwwdyJxINlK3uHieZwWQ97Rkg55d4mgH80qVW8tVe2FJwe1FBn8SXi7WEGMjQR
fiXaOW4r1w7Y/6aQAS+kBDlxXDFQKO5EkPkUJS/fe/PpzXroqtVzJVGETQYIupPQ
vMl2upsVQwYIOQ8jWRdYb4iC02nFqcKUKBSlpoDk8JnzswMSW0+8XXGhbHXAIj+x
/ZPzBa73FdrXTpkNr4fLRALPGhrE2/+Sg0pCM4V45z4LnfTQWWk=
=/R21
-----END PGP SIGNATURE-----

--gN4LQv2auTr7FWIi--

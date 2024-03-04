Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E20376EB
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 10:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549381; cv=none; b=hcW+6Je9EgBh5BSABUoTjmhzYZLZL9H5Ue1knnwcgOMed2jR/yHaILdvWQXiwLbwdl69lUFTMRimmg0c2Z/k0T9b6mt75ISVInPEBj3S4hTKdXJlOYBjvCI2pOckS63/Z6XveMDgkYT0gjNXUk38bmWdb5fM5R0cJJ3noaF/kRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549381; c=relaxed/simple;
	bh=TOhJhxaaGee0jR2kg+vwUGZqwr++FORlmC+yutT8Lyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0lxXVQAwt45sc56XogKTLWUCZRh2iPG2081ayZErkSR+/3Bkk+fDnLS3lzQIv/ZOu28BHcRY/ux2mNPWIMSoIv6M+4tVGk7lcEmRdYBZXKmRXt7qZOOyun8DtBoQ8X1dyMdYbQNsouE3DAuSWCbtSDivY/C5GzN0W7GlSGmfhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oIKmExBM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ofKHh9Kh; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oIKmExBM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ofKHh9Kh"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 3E6E93200406;
	Mon,  4 Mar 2024 05:49:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 04 Mar 2024 05:49:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709549378; x=1709635778; bh=vD9J6m3p2W
	7BlAksvvzMEJj5W/qJN2vBoHD0frQEsC0=; b=oIKmExBMeGacuTuCO6DJqXqC+d
	gJ7sT3KLlXuqCZ1GGbHAt8KHoETrVdjRuftjJoPoYg+2ZOGs1T3F8wMrm9LBCi7C
	WVZoF5mLl4VQgFA18byPTxiC2cR/LIPR8h5RJxwBs5T2ww7VJanM64osf0BRgzpO
	PzAlIAWan7t+Vbz3kQwYTQipQc1lEUFf+dCN0xp3pr3lDw08ce3xwgxsoi03skSR
	hhX83fZFwJXErk6Mb2aMKXuwFK0a8XjbEFPAJ35r7B6CpIz+iV8o+r8Bw431a+RD
	K/1u6RdGLBGRr4RTs3GmR8hctN1fR7Fy4c80esRHvO0l2VmV/THMjmjVJvZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709549378; x=1709635778; bh=vD9J6m3p2W7BlAksvvzMEJj5W/qJ
	N2vBoHD0frQEsC0=; b=ofKHh9Khy4/dwvhsvPfHBhTgDnhyPo4pYQvjUuO3e5gG
	lbho4UaJc0imEBA5o8Mqe6z6vMMEBlDLltTccGOesEuBZqPtjVHt4SqYpOBW9Aed
	gpYFATQHVpEnWSwj+GmToIWHX2TJFCTFvcGHHFOv2v4EsibroIA1y0lhCTPTXaMb
	g8eLer0bBw6KQgeTd/vIVKkJHdLXUhNM2cGGddPfCYEFONy1PmdWa9GEkRWIQi2a
	r5HvXukK10wqr9BNTg2I1dRuJDjp2BvOJ2UeP7fSwO6HK3sYkynL2GbCX62JFva/
	/BwpftaJtryBAfzNwHZhvbsN3aClhm9yB9P7484KXw==
X-ME-Sender: <xms:QqflZRz_86Is_8lW5DegcbKeJD_0uJPbEfwQC8u1CMrNwHI9NpKDdg>
    <xme:QqflZRTj3FYhmXn43afzA1nYwkaFSKt8nMGusdGRfGos1_W0-mES78vLjQQwiWO33
    oCYFlZ2wJYJ5-yZhA>
X-ME-Received: <xmr:QqflZbX_4BXTB56t4pgS7_22hWOJcY7Bc7OR8mqziG7LYzmLfELz85lbk_-tOLJ_b-Stqmv0NJV4EDFgPdTmme1ro67Vqlgxp0Y76GOpLaeM0hE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:QqflZTjqSGzxjckP7jhK5w6ixwSPm-wAdY8GRr9BnRUHT_iiT3Tj6w>
    <xmx:QqflZTDOXVW0yomEHmEWN-PDAP_AgEKd8HKMZC0350I3YR_w18cV6g>
    <xmx:QqflZcKGVtUIC0jMRzyz5_sgoI01twMCxgHRuRezS7w3B6McpMcVUA>
    <xmx:QqflZWNx4p3CXUmEd5Zc4AeM6Devok1m7gsz20iS3NxqCwTLd6NAYA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 05:49:37 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8902bf5e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Mar 2024 10:45:12 +0000 (UTC)
Date: Mon, 4 Mar 2024 11:49:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, James Liu <james@jamesliu.io>
Subject: [PATCH v3 12/13] reftable: allow inlining of a few functions
Message-ID: <527c15e5dae59a85947f0278683c341a0310ee04.1709548907.git.ps@pks.im>
References: <cover.1707895758.git.ps@pks.im>
 <cover.1709548907.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ycgLFsKhS2DM31fM"
Content-Disposition: inline
In-Reply-To: <cover.1709548907.git.ps@pks.im>


--ycgLFsKhS2DM31fM
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
index b9c6eee88a..367de04600 100644
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


--ycgLFsKhS2DM31fM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXlpz4ACgkQVbJhu7ck
PpSgMxAAmLVCxpprmi0V0PRkb5+4YqNjtiCC0ZMyDCxnzTEWaKCxDVsa45UWwHRK
INpr1lmBWFO0kixSW7dJ7GoKkDP0zSHaMWIq1C6ZJKmlieBhjzIrnjO17DFdBslK
pnjOnI7sQmcMMLAuqG2gs4pGvwAOnXhPzB39ZeYSX5O2avs3Ebu00ZICNCUtZX5M
U72V7CPTnk7f9KUoTC61uLarhD1FBJYRapgpSM+dO3OaA87rG/EMnYRxI+Pg/RlF
8h0WBXbc+MT323QfS5PMMcdKUJnDdln8hj5ZhGFnCgqqkbKiNTMG0lDScVFHrLii
UP31uFqCS2KZ3davXxXkzU/AqeSTt5Cye/39jQg1lERcoRWsJk02PLEw8sG4LWL0
+GSlhSkxi4M4amyOJte219wVkuIlZOKMu5HVrJhxkNxgQwb6HvkwWp8WHcaRbi7+
qZ7uBh6TyPs9toWkGw05bzNCMPGucv4AXCgiwVV26XutidCL7tuz66W7fhgO7fmf
fI7CNpIYAvBuI1tFdkAjamkHPLXt3A1NsLBlJ830vArWh8zFqR9vnRVzV+kmX625
sQOgRf87WYwIWI51y15L4r7j8zZo+yf7S2FVnl6AwY+xNrJJO5y9m3bFE6Sdd/WA
PyjBjx7oJ0If1AQQB5KqsDGOhFVxCkdkTieyUxjn5vTb9laHVxE=
=hkl8
-----END PGP SIGNATURE-----

--ycgLFsKhS2DM31fM--

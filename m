Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD35337168
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 10:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549345; cv=none; b=pDMVOV+qcqZTgicY4qRhRPOU5eZS+O/yfxzANYrcJT8pK7f6wcLCOe2/qRzHeXkpZTUPbs5KBcTc3JSqaS6gCENoEH7gavLu5weG+voONHHE6spwZp1nW+xAeXrM0uoCrZ6ZhfVvL52aCiFbzIqcoqfNrV8cSkCVz2BaUSD759A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549345; c=relaxed/simple;
	bh=BgOH3zchA25kixkkVICjhizFnfi2MLAktjXLZO1g8iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGJzvIKXzh5LXDrw/gXqshoMYE1H4FFBTmGsl5mQB0GhFQ7dOB5OQCaHAWlb8r/EXFlh3h087W7BuGcPfDZ5+oFDTHIPretWBS3mdBGEPXdA3dAb2wUOa4kHTmXhKvajvzK7lUGWcG8pltZ05i1GHRTb0lAMvx6aAJtphYtwaeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Sfb8Eakp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nD3hkmRp; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Sfb8Eakp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nD3hkmRp"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id AAF491800090;
	Mon,  4 Mar 2024 05:49:02 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 04 Mar 2024 05:49:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709549342; x=1709635742; bh=On5a504LnL
	cpTbQr9hkk1dtUD1/213NArlsiSn/lYC8=; b=Sfb8EakpTZwd5DSZI1sXaFI3QX
	17ig7Q31zo2fRuVlePYlqIt1qF4TH/Nk1j3NNKztJn50xGUhATWZvzl7bJfSb8Pu
	u/F0Rh4nzSjdUL4RX5GD2SYUNXCfFWwDYZpHEjDzA5J9AilEa8VNWkkc9WU10Lxx
	b6m9LIYKQME/0+r8KxfVIKCn7IQTVzqnYD7Ma5I1RENAq5+xgxgzOxzf7Z3vL/U8
	xznGBfj9Kiy7IJYfP6dhgovWkK9hLA0ck5KuDvMugivY517vXvEVCSB5/QxLCKS2
	svfPgUW9TTCKRKwnZhiITHQBVeRmNGmYDT12yUpTwv6dZZdtCGgYQZA6vK8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709549342; x=1709635742; bh=On5a504LnLcpTbQr9hkk1dtUD1/2
	13NArlsiSn/lYC8=; b=nD3hkmRpHTo0RyEU6hpDKLJhaNhk6NP/5re9HclVY3Yq
	9G5s7qjECDnz4Eg+lnXDkECNcSpaFjuosVwsmVhGc8hGrrnUlqLC62AljxbpqC4A
	hL48QjMxtiHHkl1zuGqAq9KLzC7qgWEBDNh2OHmH85y6PVkDRuXrDqck45g1tisU
	OCiRo1IQnCjazub5WXzYRUtt/+RK58WChszq445Kz6JaplP/O8txmN86/C3YCyw/
	1MV2KYvTbAHawVnj8kFEGz5ddMH3vkQBf72NiJhKNZGLU+UwBCkM7I31vf2lEz/p
	fM0oVEYH9EhsxRATzjaj0B/8hADINb32rxHAGsTC1Q==
X-ME-Sender: <xms:HqflZTJf8pak3GO7NupdTZ9yxWKTpsVRrrtZQxCtRmQtlpoGCjrA1A>
    <xme:HqflZXKQx2wGpJLvFeHDi7FXTrA7icWk2QhJvAx1V3_cl9ryqxNFLnh504P7dnJao
    qsaPEj-SEDPTtZ5qQ>
X-ME-Received: <xmr:HqflZbtEN5lINyFDp-IhYmKTW9wGWqPJsrnW-SKS9NGjpa2wrm_q0b1cbhMcHFF96BuM8s6EWF_qBa0sVro6diaNRB9HcG1hW0g2ZL4olOiBsf8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:HqflZcaxj6_noFzDarywTX_9SM5EKOHXewgAZg0ooAPhtqGlHBSUSw>
    <xmx:HqflZaZZsqx3hmN2txeMCRgSiXzgvwnIi_6R0R0Vp6ITwnns5YhGjw>
    <xmx:HqflZQDsad7ZYNMcQ1zNu5Q8_VFpxJ0zrIzcKA8BgEbLqaYpF9ofgg>
    <xmx:HqflZaHR43aqK5TNZxugdyowi0xvMXi0eumN9Vbs9jnEPnk1ZbPOvOv2HB8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 05:49:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 148a2ed5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Mar 2024 10:44:36 +0000 (UTC)
Date: Mon, 4 Mar 2024 11:48:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, James Liu <james@jamesliu.io>
Subject: [PATCH v3 04/13] reftable/merged: make subiters own their records
Message-ID: <9aa1733aef372bb81516aa0c62f427a1a78e9e66.1709548907.git.ps@pks.im>
References: <cover.1707895758.git.ps@pks.im>
 <cover.1709548907.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="stttyfnGV9yaRZSB"
Content-Disposition: inline
In-Reply-To: <cover.1709548907.git.ps@pks.im>


--stttyfnGV9yaRZSB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

For each subiterator, the merged table needs to track their current
record. This record is owned by the priority queue though instead of by
the merged iterator. This is not optimal performance-wise.

For one, we need to move around records whenever we add or remove a
record from the priority queue. Thus, the bigger the entries the more
bytes we need to copy around. And compared to pointers, a reftable
record is rather on the bigger side. The other issue is that this makes
it harder to reuse the records.

Refactor the code so that the merged iterator tracks ownership of the
records per-subiter. Instead of having records in the priority queue, we
can now use mere pointers to the per-subiter records. This also allows
us to swap records between the caller and the per-subiter record instead
of doing an actual copy via `reftable_record_copy_from()`, which removes
the need to release the caller-provided record.

This results in a noticeable speedup when iterating through many refs.
The following benchmark iterates through 1 million refs:

  Benchmark 1: show-ref: single matching ref (revision =3D HEAD~)
    Time (mean =C2=B1 =CF=83):     145.5 ms =C2=B1   4.5 ms    [User: 142.5=
 ms, System: 2.8 ms]
    Range (min =E2=80=A6 max):   141.3 ms =E2=80=A6 177.0 ms    1000 runs

  Benchmark 2: show-ref: single matching ref (revision =3D HEAD)
    Time (mean =C2=B1 =CF=83):     139.0 ms =C2=B1   4.7 ms    [User: 136.1=
 ms, System: 2.8 ms]
    Range (min =E2=80=A6 max):   134.2 ms =E2=80=A6 182.2 ms    1000 runs

  Summary
    show-ref: single matching ref (revision =3D HEAD) ran
      1.05 =C2=B1 0.05 times faster than show-ref: single matching ref (rev=
ision =3D HEAD~)

This refactoring also allows a subsequent refactoring where we start
reusing memory allocated by the reftable records because we do not need
to release the caller-provided record anymore.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c  | 54 ++++++++++++++++++++++++----------------------
 reftable/pq.c      |  8 ++-----
 reftable/pq.h      |  2 +-
 reftable/pq_test.c | 41 ++++++++++++++++-------------------
 4 files changed, 49 insertions(+), 56 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index 9b1ccfff00..ae74234472 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -17,8 +17,13 @@ license that can be found in the LICENSE file or at
 #include "reftable-error.h"
 #include "system.h"
=20
+struct merged_subiter {
+	struct reftable_iterator iter;
+	struct reftable_record rec;
+};
+
 struct merged_iter {
-	struct reftable_iterator *stack;
+	struct merged_subiter *subiters;
 	struct merged_iter_pqueue pq;
 	uint32_t hash_id;
 	size_t stack_len;
@@ -32,16 +37,18 @@ static int merged_iter_init(struct merged_iter *mi)
 	for (size_t i =3D 0; i < mi->stack_len; i++) {
 		struct pq_entry e =3D {
 			.index =3D i,
+			.rec =3D &mi->subiters[i].rec,
 		};
 		int err;
=20
-		reftable_record_init(&e.rec, mi->typ);
-		err =3D iterator_next(&mi->stack[i], &e.rec);
+		reftable_record_init(&mi->subiters[i].rec, mi->typ);
+		err =3D iterator_next(&mi->subiters[i].iter,
+				    &mi->subiters[i].rec);
 		if (err < 0)
 			return err;
 		if (err > 0) {
-			reftable_iterator_destroy(&mi->stack[i]);
-			reftable_record_release(&e.rec);
+			reftable_iterator_destroy(&mi->subiters[i].iter);
+			reftable_record_release(&mi->subiters[i].rec);
 			continue;
 		}
=20
@@ -56,9 +63,11 @@ static void merged_iter_close(void *p)
 	struct merged_iter *mi =3D p;
=20
 	merged_iter_pqueue_release(&mi->pq);
-	for (size_t i =3D 0; i < mi->stack_len; i++)
-		reftable_iterator_destroy(&mi->stack[i]);
-	reftable_free(mi->stack);
+	for (size_t i =3D 0; i < mi->stack_len; i++) {
+		reftable_iterator_destroy(&mi->subiters[i].iter);
+		reftable_record_release(&mi->subiters[i].rec);
+	}
+	reftable_free(mi->subiters);
 }
=20
 static int merged_iter_advance_nonnull_subiter(struct merged_iter *mi,
@@ -66,17 +75,16 @@ static int merged_iter_advance_nonnull_subiter(struct m=
erged_iter *mi,
 {
 	struct pq_entry e =3D {
 		.index =3D idx,
+		.rec =3D &mi->subiters[idx].rec,
 	};
 	int err;
=20
-	reftable_record_init(&e.rec, mi->typ);
-	err =3D iterator_next(&mi->stack[idx], &e.rec);
+	err =3D iterator_next(&mi->subiters[idx].iter, &mi->subiters[idx].rec);
 	if (err < 0)
 		return err;
-
 	if (err > 0) {
-		reftable_iterator_destroy(&mi->stack[idx]);
-		reftable_record_release(&e.rec);
+		reftable_iterator_destroy(&mi->subiters[idx].iter);
+		reftable_record_release(&mi->subiters[idx].rec);
 		return 0;
 	}
=20
@@ -86,7 +94,7 @@ static int merged_iter_advance_nonnull_subiter(struct mer=
ged_iter *mi,
=20
 static int merged_iter_advance_subiter(struct merged_iter *mi, size_t idx)
 {
-	if (iterator_is_null(&mi->stack[idx]))
+	if (iterator_is_null(&mi->subiters[idx].iter))
 		return 0;
 	return merged_iter_advance_nonnull_subiter(mi, idx);
 }
@@ -121,25 +129,19 @@ static int merged_iter_next_entry(struct merged_iter =
*mi,
 		struct pq_entry top =3D merged_iter_pqueue_top(mi->pq);
 		int cmp;
=20
-		cmp =3D reftable_record_cmp(&top.rec, &entry.rec);
+		cmp =3D reftable_record_cmp(top.rec, entry.rec);
 		if (cmp > 0)
 			break;
=20
 		merged_iter_pqueue_remove(&mi->pq);
 		err =3D merged_iter_advance_subiter(mi, top.index);
 		if (err < 0)
-			goto done;
-		reftable_record_release(&top.rec);
+			return err;
 	}
=20
-	reftable_record_release(rec);
-	*rec =3D entry.rec;
 	mi->advance_index =3D entry.index;
-
-done:
-	if (err)
-		reftable_record_release(&entry.rec);
-	return err;
+	SWAP(*rec, *entry.rec);
+	return 0;
 }
=20
 static int merged_iter_next(struct merged_iter *mi, struct reftable_record=
 *rec)
@@ -257,10 +259,10 @@ static int merged_table_seek_record(struct reftable_m=
erged_table *mt,
 	struct merged_iter *p;
 	int err;
=20
-	REFTABLE_CALLOC_ARRAY(merged.stack, mt->stack_len);
+	REFTABLE_CALLOC_ARRAY(merged.subiters, mt->stack_len);
 	for (size_t i =3D 0; i < mt->stack_len; i++) {
 		err =3D reftable_table_seek_record(&mt->stack[i],
-						 &merged.stack[merged.stack_len], rec);
+						 &merged.subiters[merged.stack_len].iter, rec);
 		if (err < 0)
 			goto out;
 		if (!err)
diff --git a/reftable/pq.c b/reftable/pq.c
index e0ccce2b97..0074d6bc43 100644
--- a/reftable/pq.c
+++ b/reftable/pq.c
@@ -14,7 +14,7 @@ license that can be found in the LICENSE file or at
=20
 int pq_less(struct pq_entry *a, struct pq_entry *b)
 {
-	int cmp =3D reftable_record_cmp(&a->rec, &b->rec);
+	int cmp =3D reftable_record_cmp(a->rec, b->rec);
 	if (cmp =3D=3D 0)
 		return a->index > b->index;
 	return cmp < 0;
@@ -82,10 +82,6 @@ void merged_iter_pqueue_add(struct merged_iter_pqueue *p=
q, const struct pq_entry
=20
 void merged_iter_pqueue_release(struct merged_iter_pqueue *pq)
 {
-	int i =3D 0;
-	for (i =3D 0; i < pq->len; i++) {
-		reftable_record_release(&pq->heap[i].rec);
-	}
 	FREE_AND_NULL(pq->heap);
-	pq->len =3D pq->cap =3D 0;
+	memset(pq, 0, sizeof(*pq));
 }
diff --git a/reftable/pq.h b/reftable/pq.h
index 9e25a43a36..ce23972c16 100644
--- a/reftable/pq.h
+++ b/reftable/pq.h
@@ -13,7 +13,7 @@ license that can be found in the LICENSE file or at
=20
 struct pq_entry {
 	size_t index;
-	struct reftable_record rec;
+	struct reftable_record *rec;
 };
=20
 struct merged_iter_pqueue {
diff --git a/reftable/pq_test.c b/reftable/pq_test.c
index c202eff848..b7d3c80cc7 100644
--- a/reftable/pq_test.c
+++ b/reftable/pq_test.c
@@ -27,48 +27,43 @@ void merged_iter_pqueue_check(struct merged_iter_pqueue=
 pq)
=20
 static void test_pq(void)
 {
-	char *names[54] =3D { NULL };
-	int N =3D ARRAY_SIZE(names) - 1;
-
 	struct merged_iter_pqueue pq =3D { NULL };
+	struct reftable_record recs[54];
+	int N =3D ARRAY_SIZE(recs) - 1, i;
 	char *last =3D NULL;
=20
-	int i =3D 0;
 	for (i =3D 0; i < N; i++) {
-		char name[100];
-		snprintf(name, sizeof(name), "%02d", i);
-		names[i] =3D xstrdup(name);
+		struct strbuf refname =3D STRBUF_INIT;
+		strbuf_addf(&refname, "%02d", i);
+
+		reftable_record_init(&recs[i], BLOCK_TYPE_REF);
+		recs[i].u.ref.refname =3D strbuf_detach(&refname, NULL);
 	}
=20
 	i =3D 1;
 	do {
-		struct pq_entry e =3D { .rec =3D { .type =3D BLOCK_TYPE_REF,
-					       .u.ref =3D {
-						       .refname =3D names[i],
-					       } } };
+		struct pq_entry e =3D {
+			.rec =3D &recs[i],
+		};
+
 		merged_iter_pqueue_add(&pq, &e);
 		merged_iter_pqueue_check(pq);
+
 		i =3D (i * 7) % N;
 	} while (i !=3D 1);
=20
 	while (!merged_iter_pqueue_is_empty(pq)) {
 		struct pq_entry e =3D merged_iter_pqueue_remove(&pq);
-		struct reftable_record *rec =3D &e.rec;
 		merged_iter_pqueue_check(pq);
=20
-		EXPECT(reftable_record_type(rec) =3D=3D BLOCK_TYPE_REF);
-		if (last) {
-			EXPECT(strcmp(last, rec->u.ref.refname) < 0);
-		}
-		/* this is names[i], so don't dealloc. */
-		last =3D rec->u.ref.refname;
-		rec->u.ref.refname =3D NULL;
-		reftable_record_release(rec);
-	}
-	for (i =3D 0; i < N; i++) {
-		reftable_free(names[i]);
+		EXPECT(reftable_record_type(e.rec) =3D=3D BLOCK_TYPE_REF);
+		if (last)
+			EXPECT(strcmp(last, e.rec->u.ref.refname) < 0);
+		last =3D e.rec->u.ref.refname;
 	}
=20
+	for (i =3D 0; i < N; i++)
+		reftable_record_release(&recs[i]);
 	merged_iter_pqueue_release(&pq);
 }
=20
--=20
2.44.0


--stttyfnGV9yaRZSB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXlpxoACgkQVbJhu7ck
PpRm/A//SG7dzB14mZQQ2T64cy9IRv1AH4qfLKVxz07KhrJdjvnOScAjFOvIF17r
VnArFHp7bJOGWUJB9S7mei/w9ua/MhCt12IuQn+6tJXrstzq5eGRmmB9uWDoyd7D
JjuEzQNe9odloHgt2im4JjbtdFsXogRjr+G7KVHcO8tskQw7QWJDyAV7opp5Khgw
sLplusCnYxL+HWEdnl+FWo7hD0hTdp+juPCBZvYOLLS/gSFVflh6FRFmYb+x17Ix
VrjSZFCDqlDWOxYOAMU6KqJhOnJBIc8PLCUga5Xy+QehGphipGTaPjvfHRD1rsOg
35lf6rMY3NBSZ+sDxKDuVvoKVhi297m/1mzU9nsDQjTQaT4QagIFdVIb626u2pRD
u9dLe/uWT+BQyFt2wC+xeEE71abGd7sdrbZeNcWmV2+EaN5NDNbxE8H2j/aTPC/D
Orx8HiUX8vcYDDf0Bdbvgqk1KfFGTW8P5Qohii2xlmARPc1Q6vxr5nVaMvtGwsbT
OK2CopsxX5vv13+hSaIlnUTHucMHu3OU8toRAp5SMe46CeCRBdnBTEW48A1YsdTw
lRSjVTbLBrG1P0mxRCOi6/IvSUfcB5zYBEAQ1n5FKLRQ7i7W9yed6xVpcu5gVd2i
jWn9DHkuAufgZS0zNXKbDthjEC0JUYZMJN/Ivcp8Sfvy3Z2ixhw=
=3Rvi
-----END PGP SIGNATURE-----

--stttyfnGV9yaRZSB--

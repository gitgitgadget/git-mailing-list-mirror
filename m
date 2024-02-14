Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1915312B8A
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 07:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707896760; cv=none; b=t4cXrjdZnRKt1pfWo/oB6K0IEdHES903uPD8q1G/RDqCfAuHqT/DGWPV0lEKUlXd7dWCCzsfajvzEhueYPtczIJddc79DjEEIRmDeUA6Gu83COFczg9jo9J5IagJMod/OfSzLYE2/tmn27/aV+gTvzqoIlhmmNjqBWZyEvTd6u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707896760; c=relaxed/simple;
	bh=OCPPRx0nBlbxQNz35my3h5Ls+3QdZOXu20q5fV7zCg0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSMtTS71hyFsmGq7apP8jn/H3B7NBBGtlsV+gK+OS2Y5UqF+Dyu6uWqGQJimWDxbiZqifY4NyqRTgBmM7RP5z6AKe7MFCVzuiMWPuoj0Ut2XsoIeVOd5teDudYl7bFnHZoGzvp1kPc/bv+b4AKVMMqgh2mJ4NJf3gJGUQY0GSXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KXhZlcWz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ajOATwk4; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KXhZlcWz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ajOATwk4"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 3935532009B5
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 02:45:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 14 Feb 2024 02:45:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707896756; x=1707983156; bh=UuarB80NsG
	bbbRjpH9TeJXYRHgWU/EujF9icdvH0mdY=; b=KXhZlcWzLLECHYJk2ZAzjASkAG
	uaDTiiMO9XW4O9WLJwWe7TtO3Pjxz09YBRDILuhHmrfslPfE37NI88NVglbjHpkf
	8gw0u5tdRQgw14EQaVBfGJ0+/WMbsD0WBJGaQoZ3HRt49r8+oNrM93u1mWV8umig
	HFf+T/JS8K/8FkSkY/3q3MareXZLDrwSplDw/RGyC96lxjxVZNcDgWCpl8yRdSO3
	+0+oEmlPkYG0waRKVL+8SiRs74kODWcdBWfku/iQU4CkNhCbtvaEELj6Hxm5rVOd
	nfRxYZ/3BCQszC87hSYiZd/VB+2JEjJPJ43q+RCBggyb0nI7Mu5TrIl9/0pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707896756; x=1707983156; bh=UuarB80NsGbbbRjpH9TeJXYRHgWU
	/EujF9icdvH0mdY=; b=ajOATwk4Q4caqN3rYgLc/tJEBnjm8QD2wVJ7Ai2Yfxr6
	Ohdom/08daSGrDweJh8ljvGYcVWyOOCQN2Y2DYdYiScWjtZvKF9OhdRlaEuh3xAx
	9A+smyN+lOCmvuDuVCgWQrsbKvQy2PTNsqJ6N3PfLb4pxDdyrBTiLIOmwxI20LwU
	TF+HqTSSu05wuRnNKirTfdoXB6aRNcvDKFGp93edZsGoB0QHe2R7iodd69iffInj
	tmdmlZWxIzqhTaeGBDIR+B3ydQySarNx6Z/wn614xyS+Y6CnXXOFiPtetp0ssrjp
	Q33CEhtozF+mxO9xMgXqLSmGMKcgL0aBp7gr3u55Yg==
X-ME-Sender: <xms:tG_MZTePpRzLuipOVf92M99-dx5fOyjkmURydwrgcY7SzwSIt68naQ>
    <xme:tG_MZZOA0_EYUqEXMHun0qFjPvALNmuhqdnuGLt360qbLKHETHhVr26bmRpEwtuZh
    zjv0R9vkqBwm2Mj3w>
X-ME-Received: <xmr:tG_MZcgodvVC7uQ0VKh4Z82Hn3k-5539TVc6uA56FQxzAu2H16zQkPk43CL2O3c-N2OorqklKvqEPj4U1pdIsbXZiX8leAZA3vS1BZAdkLHXXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeigdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhephefgjeeuveejteduhefgffefffdvjeefje
    eivdekfffgkeeugfehveetueefleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:tG_MZU95NvnCiTGCoFDk8m40Mj_az5E5W-7oMYaBysoSUewrg7FKFg>
    <xmx:tG_MZftkRqAmeip9bmKYbW46Thty0fibk1RZwcbFxs3Bd31kIRgnGQ>
    <xmx:tG_MZTEd_b6HlHWu50VPozvlmAAo7sW2-Ei92bCwwB7ODvIDtFm6Gw>
    <xmx:tG_MZd2WxEw9WFQ_cqXABMLbe8Om7bwFP92uucnCalp_zSF7zQ-B_g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 14 Feb 2024 02:45:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 36ba47a5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 14 Feb 2024 07:42:06 +0000 (UTC)
Date: Wed, 14 Feb 2024 08:45:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 04/12] reftable/merged: make subiters own their records
Message-ID: <2c51c60d165f5bb4e998c8b5dbb33be72e54d8a8.1707895758.git.ps@pks.im>
References: <cover.1707895758.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T4SssDNJUkshMMRF"
Content-Disposition: inline
In-Reply-To: <cover.1707895758.git.ps@pks.im>


--T4SssDNJUkshMMRF
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
2.43.GIT


--T4SssDNJUkshMMRF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXMb7EACgkQVbJhu7ck
PpTRwQ//UogVs+v0E9md8hkk2JyD3EBFWHPTvLDf4acxMnmJOV3Rx+aE21vBgnei
5iEP2FqCzQ/ouRnoYQ0YUGIfUCxte9M92/uZvRt5cMPrsxIEM1HoF7Zn8Lt+jX9E
FsVNLMADHhXjk5ay+yQVkJbw4GXa0ZOpzDrf/Ge+1BesCS+iwxDX47t5xFjzd6qc
7kGNhncQw5DwpjFgdmRSJAx5ZULnK1i0NuZZBP3Xn5SXjO5trmV4Bs0WrPyBIGxf
2/l2GxEhDepksoHpPKNlCBCHH/5HmY/qJGvBH5X7Nj6c/FciHVo99TdqvkvXcbfc
7Tpzlp/iOgR50qv0UN3jB8D5JrSfcIynoQbpbH96Y9HIZSuzDnitJ4gsK3nl1FM+
sPwfHSSBnWOxQcfn1PJ0A82SV2WazNZPs6ZhsaGwg8Q2Yrgowt/LRKSRn15ypXch
nnG2Dmyx+NMbnYB4tyhUn2bp+aukOuFfVQu5qsGuCyBzDqwnF4OLMAdTo0ZCyhGQ
Te5I+HmcxhhD0oNq+bcGTgN8POpP5QrpfxjFTg/xTeCA607bRJkW+eonUDYta8QS
Bx3H0G8KSTUJn7vwctN0BiU1lVu1rePco4m82NwtdHdik4nO8AMAKos/H2BCWkZx
bvf5h9jHHGHA5PRz4z09AhrRfC1xMzqypXO33bcf522r7zG3wlM=
=2DiA
-----END PGP SIGNATURE-----

--T4SssDNJUkshMMRF--

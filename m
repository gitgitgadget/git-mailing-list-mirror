Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A0A55C18
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 08:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706688070; cv=none; b=mJwCz5tturplwVYkyaAUiO53zN/m1yBmxT9FKQ6rSkdFbBtXyCF1810IcsFyI1Z2hpPv5RkIV4vS07L8sX8dMgX2n5+4tg1sNqdWtqI1RTYH0wRF1sETP3lUqR88UWL5BvX9skRkow2F28bcOyFk5XLYORTZscHzcHvsIjbILJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706688070; c=relaxed/simple;
	bh=UXL9C4hP9c/jzW33/QVl6MmVLM13/RfPKCgoFlgBVNM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODlu+rit5SiaW/4H5zURn59fkmsSnwp8gXsHuPwQbj0tk+m7ftgLXt5ioHziWnmZgsSoSzihA+/xAvEHkQgIZAQnIOUUTF31XO0L+xDFBRxUjN5P7ic7GTOyBzBj2XEpg4ot2rcRB9BvjfEOFsaJZ9IRWkK2Vw+I6FkGnSl5sBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P5JuNWEd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LDhmB9eb; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P5JuNWEd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LDhmB9eb"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id F06741140060
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 03:01:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 31 Jan 2024 03:01:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706688065; x=1706774465; bh=jM7qfkpP2t
	rg9sNMFBA19sQCKvDjXI80sDU092Pnwos=; b=P5JuNWEdp0Ixz41Cb5OQlA3zjM
	Y/kl9a0JLUghTE0yzVSRr+k8kq3yAAdAJR6IaWCO8oPZ0uWLRmrwL+eHCGxHNkhi
	Zvwj/RHCssWt91Xu2IjAvxiQlcGCLotaOCbwppDuignMWrGEmh8rpebJHympU1x6
	mz3C0xpVCdI0P4qNjAhNMJZzYTtrLDqEsOJyO5HUeq2H5XOLgjRzDTZkTZ4SE4Ry
	XDJBk0H4BbQ7QV7nmHCpEioEcVgqF4DIMbB9RKVVDd7RZkSi1mohB6ujOOF9MTDD
	BJLxa698PzRNqM0De9wM85JKq2IpKG7BgTwZQqShQZXF5ShVCiLFtNE5OE3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706688065; x=1706774465; bh=jM7qfkpP2trg9sNMFBA19sQCKvDj
	XI80sDU092Pnwos=; b=LDhmB9ebWZf06zVortuIGqpvWurIpDVfk5McVun0zm/S
	Mjy1LSXDeApCDRJE6VHKAmcmp8OdOsdHxRo8zE39K+xwEi3S1BTRIKBQZYbQameW
	DrO0lUDOcRzGFD+NLyNJsqAceq4Xgn3Rh27iPKoClV9mLRTZnAm6zVR0FSBh0wy8
	v4p/zxM6FqEEwmYmeAzUuyJ+ChKPS+irnhpBp9zLvFWCm4FpIK31V8b2HUwag5Hh
	0NBpS/KcLX1I8MfiRDkQ0wm7WUEek48dEGh5O2tljxd17xFePCofG5Q1dtO6zJYK
	SF3ZkHpTqZOJ56GIZ2tNZwGkaxUq4kMP6G/6GmCV+g==
X-ME-Sender: <xms:Qf65ZfskU3GIEVpgXKG4UKFwuIWLKdfUTvw1SN1On9WaBNp8wamjtA>
    <xme:Qf65ZQdd-vwzS3TD1S0wTCtMdUn26vzB9AOuO43Djlh1rlcKvT5u3JBqkZd33t7zt
    wenaWdyLjKcAo4vIQ>
X-ME-Received: <xmr:Qf65ZSw-AnIr9BPcaMwDybtlVGDewHXJIzxRerGExGly0Xe_TmQGDoOeDKo3Al0piNRVEr_MHSOw6HnL_QO1xsHL4BRXz4psSk7_2y_PlfDiNHs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtkedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgfejueevjeetudehgffffeffvdejfe
    ejiedvkeffgfekuefgheevteeufeelkeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Qf65ZeNsQ0yaxxHEV85UqciZgPyA59m5BjoaeLA08K8BC2n7IkGYkg>
    <xmx:Qf65Zf8SEYTyW_zM2hsrUK9wYXSvi4kDL-i8nRJNdfCKXZMPSFa0jA>
    <xmx:Qf65ZeXMULioBu96pnvALvKpG_xPUWStTTHldDVpXZhNXzZIC0i4ng>
    <xmx:Qf65ZZkReIoSGUO63-bCnYQtq8OA8fpR1HwevEpVs3HxkPjbpXxyxQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 31 Jan 2024 03:01:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e01ffe87 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 31 Jan 2024 07:57:46 +0000 (UTC)
Date: Wed, 31 Jan 2024 09:01:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 1/9] reftable: introduce macros to grow arrays
Message-ID: <0597e6944a1a65720d050f47bc82766d5bcf860b.1706687982.git.ps@pks.im>
References: <cover.1706687982.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OWToEAWSY9474oZC"
Content-Disposition: inline
In-Reply-To: <cover.1706687982.git.ps@pks.im>


--OWToEAWSY9474oZC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Throughout the reftable library we have many cases where we need to grow
arrays. In order to avoid too many reallocations, we roughly double the
capacity of the array on each iteration. The resulting code pattern is
thus duplicated across many sites.

We have similar patterns in our main codebase, which is why we have
eventually introduced an `ALLOC_GROW()` macro to abstract it away and
avoid some code duplication. We cannot easily reuse this macro here
though because `ALLOC_GROW()` uses `REALLOC_ARRAY()`, which in turn will
call realloc(3P) to grow the array. The reftable code is structured as a
library though (even if the boundaries are fuzzy), and one property this
brings with it is that it is possible to plug in your own allocators. So
instead of using realloc(3P), we need to use `reftable_realloc()` that
knows to use the user-provided implementation.

So let's introduce two new macros `REFTABLE_REALLOC_ARRAY()` and
`REFTABLE_ALLOC_GROW()` that mirror what we do in our main codebase,
with two modifications:

  - They use `reftable_realloc()`, as explained above.

  - They use a different growth factor of `2 * cap + 1` instead of `(cap
    + 16) * 3 / 2`.

The second change is because we know a bit more about the allocation
patterns in the reftable library. For In most cases, we end up only having a
single item in the array, so the initial capacity that our global growth
factor uses (which is 24), significantly overallocates in a lot of code
paths. This effect is indeed measurable:

  Benchmark 1: update-ref: create many refs (growth factor =3D 2 * cap + 1)
    Time (mean =C2=B1 =CF=83):      4.834 s =C2=B1  0.020 s    [User: 2.219=
 s, System: 2.614 s]
    Range (min =E2=80=A6 max):    4.793 s =E2=80=A6  4.871 s    20 runs

  Benchmark 2: update-ref: create many refs (growth factor =3D (cap + 16) *=
 3 + 2)
    Time (mean =C2=B1 =CF=83):      4.933 s =C2=B1  0.021 s    [User: 2.325=
 s, System: 2.607 s]
    Range (min =E2=80=A6 max):    4.889 s =E2=80=A6  4.962 s    20 runs

  Summary
    update-ref: create many refs (growth factor =3D 2 * cap + 1) ran
      1.02 =C2=B1 0.01 times faster than update-ref: create many refs (grow=
th factor =3D (cap + 16) * 3 + 2)

Convert the reftable library to use these new macros.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.c      |  8 ++------
 reftable/basics.h      | 11 +++++++++++
 reftable/block.c       |  7 +------
 reftable/merged_test.c | 20 ++++++--------------
 reftable/pq.c          |  8 ++------
 reftable/stack.c       | 29 ++++++++++++-----------------
 reftable/writer.c      | 14 ++------------
 7 files changed, 36 insertions(+), 61 deletions(-)

diff --git a/reftable/basics.c b/reftable/basics.c
index f761e48028..af9004cec2 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -89,17 +89,13 @@ void parse_names(char *buf, int size, char ***namesp)
 			next =3D end;
 		}
 		if (p < next) {
-			if (names_len =3D=3D names_cap) {
-				names_cap =3D 2 * names_cap + 1;
-				names =3D reftable_realloc(
-					names, names_cap * sizeof(*names));
-			}
+			REFTABLE_ALLOC_GROW(names, names_len + 1, names_cap);
 			names[names_len++] =3D xstrdup(p);
 		}
 		p =3D next + 1;
 	}
=20
-	names =3D reftable_realloc(names, (names_len + 1) * sizeof(*names));
+	REFTABLE_REALLOC_ARRAY(names, names_len + 1);
 	names[names_len] =3D NULL;
 	*namesp =3D names;
 }
diff --git a/reftable/basics.h b/reftable/basics.h
index 096b36862b..2f855cd724 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -53,6 +53,17 @@ void *reftable_realloc(void *p, size_t sz);
 void reftable_free(void *p);
 void *reftable_calloc(size_t sz);
=20
+#define REFTABLE_REALLOC_ARRAY(x, alloc) (x) =3D reftable_realloc((x), st_=
mult(sizeof(*(x)), (alloc)))
+#define REFTABLE_ALLOC_GROW(x, nr, alloc) \
+	do { \
+		if ((nr) > alloc) { \
+			alloc =3D 2 * (alloc) + 1; \
+			if (alloc < (nr)) \
+				alloc =3D (nr); \
+			REFTABLE_REALLOC_ARRAY(x, alloc); \
+		} \
+	} while (0)
+
 /* Find the longest shared prefix size of `a` and `b` */
 struct strbuf;
 int common_prefix_size(struct strbuf *a, struct strbuf *b);
diff --git a/reftable/block.c b/reftable/block.c
index 1df3d8a0f0..6952d0facf 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -51,12 +51,7 @@ static int block_writer_register_restart(struct block_wr=
iter *w, int n,
 	if (2 + 3 * rlen + n > w->block_size - w->next)
 		return -1;
 	if (is_restart) {
-		if (w->restart_len =3D=3D w->restart_cap) {
-			w->restart_cap =3D w->restart_cap * 2 + 1;
-			w->restarts =3D reftable_realloc(
-				w->restarts, sizeof(uint32_t) * w->restart_cap);
-		}
-
+		REFTABLE_ALLOC_GROW(w->restarts, w->restart_len + 1, w->restart_cap);
 		w->restarts[w->restart_len++] =3D w->next;
 	}
=20
diff --git a/reftable/merged_test.c b/reftable/merged_test.c
index 46908f738f..e05351e035 100644
--- a/reftable/merged_test.c
+++ b/reftable/merged_test.c
@@ -231,14 +231,10 @@ static void test_merged(void)
 	while (len < 100) { /* cap loops/recursion. */
 		struct reftable_ref_record ref =3D { NULL };
 		int err =3D reftable_iterator_next_ref(&it, &ref);
-		if (err > 0) {
+		if (err > 0)
 			break;
-		}
-		if (len =3D=3D cap) {
-			cap =3D 2 * cap + 1;
-			out =3D reftable_realloc(
-				out, sizeof(struct reftable_ref_record) * cap);
-		}
+
+		REFTABLE_ALLOC_GROW(out, len + 1, cap);
 		out[len++] =3D ref;
 	}
 	reftable_iterator_destroy(&it);
@@ -368,14 +364,10 @@ static void test_merged_logs(void)
 	while (len < 100) { /* cap loops/recursion. */
 		struct reftable_log_record log =3D { NULL };
 		int err =3D reftable_iterator_next_log(&it, &log);
-		if (err > 0) {
+		if (err > 0)
 			break;
-		}
-		if (len =3D=3D cap) {
-			cap =3D 2 * cap + 1;
-			out =3D reftable_realloc(
-				out, sizeof(struct reftable_log_record) * cap);
-		}
+
+		REFTABLE_ALLOC_GROW(out, len + 1, cap);
 		out[len++] =3D log;
 	}
 	reftable_iterator_destroy(&it);
diff --git a/reftable/pq.c b/reftable/pq.c
index dcefeb793a..2461daf5ff 100644
--- a/reftable/pq.c
+++ b/reftable/pq.c
@@ -75,13 +75,9 @@ void merged_iter_pqueue_add(struct merged_iter_pqueue *p=
q, const struct pq_entry
 {
 	int i =3D 0;
=20
-	if (pq->len =3D=3D pq->cap) {
-		pq->cap =3D 2 * pq->cap + 1;
-		pq->heap =3D reftable_realloc(pq->heap,
-					    pq->cap * sizeof(struct pq_entry));
-	}
-
+	REFTABLE_ALLOC_GROW(pq->heap, pq->len + 1, pq->cap);
 	pq->heap[pq->len++] =3D *e;
+
 	i =3D pq->len - 1;
 	while (i > 0) {
 		int j =3D (i - 1) / 2;
diff --git a/reftable/stack.c b/reftable/stack.c
index bf3869ce70..1dfab99e96 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -551,7 +551,7 @@ struct reftable_addition {
 	struct reftable_stack *stack;
=20
 	char **new_tables;
-	int new_tables_len;
+	size_t new_tables_len, new_tables_cap;
 	uint64_t next_update_index;
 };
=20
@@ -602,8 +602,9 @@ static int reftable_stack_init_addition(struct reftable=
_addition *add,
=20
 static void reftable_addition_close(struct reftable_addition *add)
 {
-	int i =3D 0;
 	struct strbuf nm =3D STRBUF_INIT;
+	size_t i;
+
 	for (i =3D 0; i < add->new_tables_len; i++) {
 		stack_filename(&nm, add->stack, add->new_tables[i]);
 		unlink(nm.buf);
@@ -613,6 +614,7 @@ static void reftable_addition_close(struct reftable_add=
ition *add)
 	reftable_free(add->new_tables);
 	add->new_tables =3D NULL;
 	add->new_tables_len =3D 0;
+	add->new_tables_cap =3D 0;
=20
 	delete_tempfile(&add->lock_file);
 	strbuf_release(&nm);
@@ -631,8 +633,8 @@ int reftable_addition_commit(struct reftable_addition *=
add)
 {
 	struct strbuf table_list =3D STRBUF_INIT;
 	int lock_file_fd =3D get_tempfile_fd(add->lock_file);
-	int i =3D 0;
 	int err =3D 0;
+	size_t i;
=20
 	if (add->new_tables_len =3D=3D 0)
 		goto done;
@@ -660,12 +662,12 @@ int reftable_addition_commit(struct reftable_addition=
 *add)
 	}
=20
 	/* success, no more state to clean up. */
-	for (i =3D 0; i < add->new_tables_len; i++) {
+	for (i =3D 0; i < add->new_tables_len; i++)
 		reftable_free(add->new_tables[i]);
-	}
 	reftable_free(add->new_tables);
 	add->new_tables =3D NULL;
 	add->new_tables_len =3D 0;
+	add->new_tables_cap =3D 0;
=20
 	err =3D reftable_stack_reload_maybe_reuse(add->stack, 1);
 	if (err)
@@ -792,11 +794,9 @@ int reftable_addition_add(struct reftable_addition *ad=
d,
 		goto done;
 	}
=20
-	add->new_tables =3D reftable_realloc(add->new_tables,
-					   sizeof(*add->new_tables) *
-						   (add->new_tables_len + 1));
-	add->new_tables[add->new_tables_len] =3D strbuf_detach(&next_name, NULL);
-	add->new_tables_len++;
+	REFTABLE_ALLOC_GROW(add->new_tables, add->new_tables_len + 1,
+			    add->new_tables_cap);
+	add->new_tables[add->new_tables_len++] =3D strbuf_detach(&next_name, NULL=
);
 done:
 	if (tab_fd > 0) {
 		close(tab_fd);
@@ -1367,17 +1367,12 @@ static int stack_check_addition(struct reftable_sta=
ck *st,
 	while (1) {
 		struct reftable_ref_record ref =3D { NULL };
 		err =3D reftable_iterator_next_ref(&it, &ref);
-		if (err > 0) {
+		if (err > 0)
 			break;
-		}
 		if (err < 0)
 			goto done;
=20
-		if (len >=3D cap) {
-			cap =3D 2 * cap + 1;
-			refs =3D reftable_realloc(refs, cap * sizeof(refs[0]));
-		}
-
+		REFTABLE_ALLOC_GROW(refs, len + 1, cap);
 		refs[len++] =3D ref;
 	}
=20
diff --git a/reftable/writer.c b/reftable/writer.c
index ee4590e20f..4483bb21c3 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -200,12 +200,7 @@ static void writer_index_hash(struct reftable_writer *=
w, struct strbuf *hash)
 		return;
 	}
=20
-	if (key->offset_len =3D=3D key->offset_cap) {
-		key->offset_cap =3D 2 * key->offset_cap + 1;
-		key->offsets =3D reftable_realloc(
-			key->offsets, sizeof(uint64_t) * key->offset_cap);
-	}
-
+	REFTABLE_ALLOC_GROW(key->offsets, key->offset_len + 1, key->offset_cap);
 	key->offsets[key->offset_len++] =3D off;
 }
=20
@@ -674,12 +669,7 @@ static int writer_flush_nonempty_block(struct reftable=
_writer *w)
 	if (err < 0)
 		return err;
=20
-	if (w->index_cap =3D=3D w->index_len) {
-		w->index_cap =3D 2 * w->index_cap + 1;
-		w->index =3D reftable_realloc(
-			w->index,
-			sizeof(struct reftable_index_record) * w->index_cap);
-	}
+	REFTABLE_ALLOC_GROW(w->index, w->index_len + 1, w->index_cap);
=20
 	ir.offset =3D w->next;
 	strbuf_reset(&ir.last_key);
--=20
2.43.GIT


--OWToEAWSY9474oZC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW5/j4ACgkQVbJhu7ck
PpSWOw//RyB60qRkXJfbes9kfVaXawpeTHucwwu2gSk7LXfZX/6mnujyMe7GdwlY
36cB9Jv5F1v2IhJXDFKv5l8P4pjqP1emARG4kDhqx1wP5RHyPDZOgLq+rMhbCFJo
d9H26nXgTUjRkmTaKavH60TDUtx4mkp+UUFXLAF3tH4YcUHSMEX2p6eukG33548B
I+SdGCCLxcjle+3Mn/RATYwB+d8jf3/+00w0vLPxOQB9besuio+pNBny8DS6cKgx
TKTIMaIfxx2v0VQBcux+vV906qIX5vPJZHCT1o55bcV9VRqbR0Ca4U0x5P7q/Nhg
wtM4/EibA0PCzJ7xQNc4KXaqfeqM5KgeXHd7lIGwIb+q9smwy+kv6jrchMcgw6Jo
xtnitku+b1551K6CC+CSBw7OPtpta5+8nsRlx6nNHIkr6FApqEf3wqetatP4WiKg
Hiygn+F9O5Z3e0k/j5YD/A5UNjjUmS1qKtgm053pyq/Xo3Anc/VSzUr5WY9XBQ48
focatNEDQZ8s+PgX3XEDb3cNPBoQvfhiGsEjUYZM55YCAYtDkWWkXKobJMpfGxE5
jEq8EBM2H6MIHbV6qMeizyJrqTx4D9eNDVh7CEBiBYHzrf+YrUfRECcdK554PKcQ
j45xZ1wojZKBiKn3L/PqaRHjpqy1VpGL+hl15PHKAk+RMpSzxuw=
=K41u
-----END PGP SIGNATURE-----

--OWToEAWSY9474oZC--

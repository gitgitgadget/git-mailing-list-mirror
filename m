Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1AC41C84
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 06:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707201330; cv=none; b=ABuMrdWaQPFc34KYkTlArB66SgW1Xj6/H2YfRfzZT7qyGmOJ4hnuHug7VSmNF2pMJrk3IsyVzPo1aGBOCw9df7aMR5D+q/OrAWVmTn2QgW7l6IyglJoOpv/e+qQmOl/Vg9xptLuMHwt9nGoDveEahwGMo5Hs4duoLcd+0vJcdgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707201330; c=relaxed/simple;
	bh=sx+REWNdhYoidmMJIaBdLB6GikeamS7mXi8j/skXUNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHiBDl/PSY9bcrpCPgi3DcYaW+WWhqASYgVW9IdFpD/wOpvaaIpf3L2s4KN9qHSDRSvsaKkNszc67Z+yfg8f91yvYZcMO006KUn9xSHAsCq5hXCvtapJTdC1Oh34owzYmhaB2Tv3Jn37i3Su7CmtbC6HIpSI1ElITkpNhlc7lAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KZAsAHV1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lq9c4fzE; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KZAsAHV1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lq9c4fzE"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id D3F131C00074;
	Tue,  6 Feb 2024 01:35:26 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 06 Feb 2024 01:35:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707201326; x=1707287726; bh=zQl0dNX+LA
	SazJyO+N+85iYw7JsblCAcMpUGkkgRM1s=; b=KZAsAHV1jQjQnzr40Yj80pOlty
	STFHHucKpadkUyyOEl4BilB8PnB75RVVNRg5mnfur6utSPdFeu5Hdo6BZXDad13g
	o5OjKCUHo+xD2BGTwNQWPwD+Ud2BQBnQYJ4sU0MKKRYAxMgSw14ppgj/NA0/sT//
	nRpi/3GbkBPrgPmq3oxDINjGRuxwJFeS6quAaS2URQ+f5+knPLGE9z29rVwEG6xw
	QXs59itTWc3nCASFXDP5JAyWJLd8EKaugntNbElVMDyCx36S8i0/S/q4jmhYTL08
	OBZYBLRO16toUmcxjVCHBPxCmxKAvIXIAZAezYAmw4FM5VAmVQ0E4B/wKG/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707201326; x=1707287726; bh=zQl0dNX+LASazJyO+N+85iYw7Jsb
	lCAcMpUGkkgRM1s=; b=lq9c4fzEVxi6A0NFwkfEHkg8kagF89Xcvdg7A6nReZGi
	D+fA4654ZFVHPO+S2Di7nOEfXUwpIg769DalXVH84s1sGkUD4ZXOgUqRQ8gOAorF
	LAPlmFHg/0CwpphYPpkJlJg0pMFORfwqojBxAf7ohiXzsOpHAQwf7kdyBz45AtcR
	RkzbO9BWlm20sYZcI7udDIW6R3P1IJXiFwgND3A03DbskbcsiKkJ29mSjvxYytvX
	ad+FFay9wtvumUQ/CK/plpTMRhyjdkL9RkkgGNteGCJctZVMLEL8aFAydiQ1RCZi
	vIpjHmcOU4+nhxvSYuiOFi8KDUThtVZgpKIGVKUHUw==
X-ME-Sender: <xms:LtPBZURWTziCXBHVouSZidQHyIa2jtoVJQqKqvdon6lcB8Pmzhk1Zw>
    <xme:LtPBZRzv7gf7cW2XWYRl4VqF3NCkiQnhUI9VjNpDO9AlDXY0XE9O2iEe389jX5lEx
    hKgErtOYLmnC3a64g>
X-ME-Received: <xmr:LtPBZR1Pv7jZfefdqaDAHG5DBy_j88TyETJCT-QPjP1WtZXj40hpuWmPsVGsxmqi8xbzHRSZH0VmfrE77GvtwOXzauNcWZWaVluflKgBmXXvId4t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedvvddguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:LtPBZYApKOS89L2_Qn6jvyZ0FNYOCpVk3F2mFzpfezuXOZ3Y3_hebw>
    <xmx:LtPBZdhvprgyTIzSqXoDOHW8S6mGhu72PKAEq5ujvHIr0CMKEh-m3w>
    <xmx:LtPBZUpLYBNqiKmCz-AQcaVZUqh0ngc8TWEvip5uT4Co_zA6gtHwZw>
    <xmx:LtPBZbZi_1p1ETBkkk4f4VY8BZ4-6OpLvKacL3mxdL3eKox1e0HnMc3sshI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 01:35:25 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a66554fe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Feb 2024 06:31:55 +0000 (UTC)
Date: Tue, 6 Feb 2024 07:35:23 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 1/9] reftable: introduce macros to grow arrays
Message-ID: <12bd721ddff7020eb9e9ebd4e797d50193250bc0.1707200355.git.ps@pks.im>
References: <cover.1706687982.git.ps@pks.im>
 <cover.1707200355.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ui2G6qpz6EgsToSW"
Content-Disposition: inline
In-Reply-To: <cover.1707200355.git.ps@pks.im>


--Ui2G6qpz6EgsToSW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Throughout the reftable library we have many cases where we need to grow
arrays. In order to avoid too many reallocations, we roughly double the
capacity of the array on each iteration. The resulting code pattern is
duplicated across many sites.

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
patterns in the reftable library. In most cases, we end up only having a
handful of items in the array and don't end up growing them. The initial
capacity that our normal growth factor uses (which is 24) would thus end
up over-allocating in a lot of code paths. This effect is measurable:

  - Before change:

      HEAP SUMMARY:
          in use at exit: 671,983 bytes in 152 blocks
        total heap usage: 3,843,446 allocs, 3,843,294 frees, 223,761,402 by=
tes allocated

  - After change with a growth factor of `(2 * alloc + 1)`:

      HEAP SUMMARY:
          in use at exit: 671,983 bytes in 152 blocks
        total heap usage: 3,843,446 allocs, 3,843,294 frees, 223,761,410 by=
tes allocated

  - After change with a growth factor of `(alloc + 16)* 2 / 3`:

      HEAP SUMMARY:
          in use at exit: 671,983 bytes in 152 blocks
        total heap usage: 3,833,673 allocs, 3,833,521 frees, 4,728,251,742 =
bytes allocated

While the total heap usage is roughly the same, we do end up allocating
significantly more bytes with our usual growth factor (in fact, roughly
21 times as many).

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


--Ui2G6qpz6EgsToSW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXB0yoACgkQVbJhu7ck
PpSJ4g/8DYUtJxNBxUyNvZ0pbj8EQV4vGezbePBWWD1NscJYdKq2Nvhw3LtzpuK0
Txwrj+v7OzURIqqK4baxe6zeGCMUP3rqSghJTyyyJcSTY4zQt/tm7uuFYUQ+PDsV
kXj+D+BsTHX/3xVl8EqrQrnc3hbruHZYUGhMrXXN0Qo4pmWTZEDUAq9MoHkcoq0A
XG6LMfTyCKqdOYCLSUfAuipDCTtwOIeUGwDGLdI+bGGAvo+WuylXX8mYQzyb8///
/5hunKAr5sam6+DL6oLlU05tXZ/uMEzmvXCoe+kBdH3KOgXCLW+cCTHUyz40tl2A
4v7KnKGokZCTiC1ZoR/IUx9mOpqKH9zLnOp1Mttj365jgaTMdZIav6yFZDYz8KSv
/pudzwKghu+HkY/CN70vuaVMuq7yE2fq6yb2BJzUKItvU5h3cHuw0JtplhvLxSwW
fpgdy8ZhigQeglRGWpeveG/mOipXKqDc8cu2aAznOahMb6y8XWRYvo8GIn5eJJip
YJBlGqjT4EJV1hvZZMpD70blwVyCos+lW18lOjWTxzhrp6c7BrS57VgFHX8zEa3z
qKrRcWKQpa3H09alsiBUGYWn+jz4nAgvpVeucFEYbZc2wVIp0zf8PV+lq+9MGx5y
yoqVVxtFns3+kK/QKPHIFfEK9Eb4m1IQVLKS7jz6cQMxkXAW30M=
=wUCK
-----END PGP SIGNATURE-----

--Ui2G6qpz6EgsToSW--

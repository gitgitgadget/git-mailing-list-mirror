Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA0B1586C8
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 07:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706772781; cv=none; b=hltlBtb3ChdwQTDv6MDyguifQmlWPVkq5sR26hznBMMMe0kENimOAtVxoA/HQEjJwItg2Zl7yN22d2hNlG9P3YXAEKeA69mUnn1K2QsgahJO1BULpazl8DncTD6xFvpJL3ikxU2redmq8vY/kvp74PbIANo4P3IWUvDWR7UiVe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706772781; c=relaxed/simple;
	bh=yVkhQYiUZZiYdO6wyCYrIHxMbk/V5KPalqXmk7QkPCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyrKBADyNitTsM+U6dKc/2QYcFrcnxOWHl0Ny2Daj1p8+BkJpyJhPG+VOnt/mBW5seV4hc1LMi4Ku+RNTdtePrjmK2EAK3A3I1hdEv2+YS1Cj6vBLCEoggdDuTF+VWi19TYczC2fZY8DdakgiuKDreLfl6gl5riBGDhf4w0/Gww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X2qHTuXn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RW44S5eF; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X2qHTuXn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RW44S5eF"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id BA6E31800085;
	Thu,  1 Feb 2024 02:32:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 01 Feb 2024 02:32:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706772778; x=1706859178; bh=NN0H941iUo
	c5LY/AP6Rkq4xf1NbqBDFq+6Q03yrzUlk=; b=X2qHTuXnM2uwTqydJRHEREy2Om
	CjnzHo4bCTIPBkkUcFP0rSCNRJCPwya8PeEfftBNEv7HGcXh+Ria45s94wuT+p+s
	jJ/khwZsl/4oQtFVR9LDqo4IAkXmIX6hvt+JtyWdRuXCkvJ/QRPlq8piYFMC4x4v
	nbXVmqMB5+EDvQ4CIVa2bYosGVueO/lVnFkcXbqaPI51o71pJAw1Om6qL0Hni6EW
	C4UEHH8qrZ4lOoY5kNcRGvvyIJ7xMV5fUklBOEnw68NKH23HFgQ2kZY1Q19qnQQC
	MdNaWBFflPpms0GBnAUML2d3WvhOUseOxAOWyXwxc51W59GOi298m3gOsdHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706772778; x=1706859178; bh=NN0H941iUoc5LY/AP6Rkq4xf1Nbq
	BDFq+6Q03yrzUlk=; b=RW44S5eFbvyxBTRKlEQAj3SlGj6ForetUgFv+MqgP3gU
	A7Nv1yW9ID0o2kMC2A2SHrvCElYs4U24iEXy0Gx1W2HvzHMrIVYGGT8/vxBs8pj4
	TPGnJXiFLGNNTXPuRL2MZZhZUo2+1Uqeag6ND9Ip86rYJzJAHUz1O4AgSfLg8UZI
	5chdK2mEVjuyns1aEr6ttSDKb+E2t15wfpa0SHzCJvN/BAfW3TN2X6E790IqywCB
	+HLx1P7iOXpnVJSWwIFuMo1Ojk7Vbsf3C6mB1A2BqVN7sNMSCLlCQ/AskmXFK73Z
	22xMM+P1K4rMt0AcK4chgmSkYfU/4ea/iHG8vq29UQ==
X-ME-Sender: <xms:KUm7ZWizXtrkAgQYc_b2VqNUa5vO6BsWuRZOzO0l5i11IwOUSdrcnA>
    <xme:KUm7ZXDvV-vxBv2oq_Vbov48kjcYgbssQOrbtpUPaLVG3TFOBflkuq386CCJ2D1F6
    VBX2M_VN89f9UMY9Q>
X-ME-Received: <xmr:KUm7ZeHqLwgyRAc0WLC3Qq6zY5m1vOEdFNyEMzGXg6Ux_AMM5H18xXvTs9hxV9bmwE65mOwoiAkTWNXcejiM7-4zoTqSqIxNBvx3gmGLq0hnXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedutddguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:KUm7ZfSTvHNlfPhMI7nFQc7k8fscpgy7FBscHVVrAxsAbNUPwSMoPw>
    <xmx:KUm7ZTz7a-3DZWgdA5QizpvtQNjlsS47vdK7DlQrW1luQvrXajJwkg>
    <xmx:KUm7Zd586D4Z7sDMR7jMKvNwEOjgF-Xi5tFkjUm7yuf8QlJTtOvwBg>
    <xmx:Kkm7ZT9gRFUmnk6I5gaXmp0xZfgyfomg-Uyx0NRDs5KUmZvP1bTolIKUfkE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 02:32:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 05ccdddf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Feb 2024 07:29:34 +0000 (UTC)
Date: Thu, 1 Feb 2024 08:32:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/9] reftable: introduce macros to grow arrays
Message-ID: <12bd721ddff7020eb9e9ebd4e797d50193250bc0.1706772591.git.ps@pks.im>
References: <cover.1706687982.git.ps@pks.im>
 <cover.1706772591.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ux/HEl9ttbNbIlX4"
Content-Disposition: inline
In-Reply-To: <cover.1706772591.git.ps@pks.im>


--Ux/HEl9ttbNbIlX4
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


--Ux/HEl9ttbNbIlX4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW7SSUACgkQVbJhu7ck
PpQDhg//bUmpXpdd5T2xiPUS0x/hp3uTuqKadABel+Xy4CWuih53vFwdJFeU8Sdn
9gKEHEP6enEoqd8+I0IRBGKxMEfkvID+UNCGshASGYfKb9tbXHI2/GO80zGRu2TH
SW3ctzxDvMN8s7imMO+7j3ztySRLwEEpSAMyV+Lo26WBGYBbklJhix8zPxZ6jRQ4
XDtbgphEEsmNFiGK488sCGnEDV5NYCOI7aBxIqPvwTj+4KnVFyUl8K4UovOF4L9o
Nkwe1Y2bZvLUD6xlzWb5I1LbrLdjLmvwXDKrL/c20F7ORvmlkG/07+djafMdna54
SEEXvDATaHzv7QHZKIv77e/Awk8z16ecSnA0/M8qQooTGgoMfOlaUo3mdRJ52Q5M
PWO0aTOJ7Ty1RHCb9pNvZPWWX9baphvBW3hH88WVbMVuo3dluJr5dV+k6siNkgnu
izndHelif1VEHAJ8HovSOBjjDARr1aCTexcFqDSr4rmiwx4bOfsIMjp38gYiQXaj
kmK7zfhVge0wZbOkduQMFu6+qsBIiSxoiGh/9kL0sJaGp15gXgROw5LTAzQun+Yu
+cznphMpZdYCcIZhnrVql00tXjUX4tHkLauaz9jKSyxPOTrbAg3qKPfLMz/30VnA
+Ajx5xxEptc7Z7svxDnptQjT0k9Y+r0/w7+9qeTic22SvXXwpJo=
=Hdlk
-----END PGP SIGNATURE-----

--Ux/HEl9ttbNbIlX4--

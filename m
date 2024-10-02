Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4897C205E30
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 10:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866602; cv=none; b=gUkhwDKA8qf8KSHlIMhrTEg9iM0gqez+Vv8uTYUeZptGNhFjTk17Yvg6QoUxp6mASQvBEnVuZleh5C2Q4s5ncMYY4H4mPA5rMQQIK60LVmiEoKXc+DCvu/yDDTtbLY8SpUxiP6mJRkuXG33O2z2pO27puerVyIc8JTwI7F2Dbvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866602; c=relaxed/simple;
	bh=u081I90gmmLlnAJajMhkpRxIBdNhSNZlkgGvfGrqPlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2u27z5IvvtOuoJ70KXrUT9dMzIcXSbfrrpzVdWhnUKc1PmUv4GGNViH3dJsHvukLAH3j0lP0rp6BwSv6Jv0dTGgbm+8mBXE07wkeXH5GhZJuei7pRoIQ5rJc+4+PuhNmJxZTmASgkuoJvMlfLdClF9RoJzUlQmE6Hub+6MsXZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kQjpEVFf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oJ6gGClr; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kQjpEVFf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oJ6gGClr"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 717AC1140231;
	Wed,  2 Oct 2024 06:56:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 02 Oct 2024 06:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727866600; x=1727953000; bh=dlMhMVzREL
	e4UZSTK2pEfSalKtM9Uu7wV91OvMUNORk=; b=kQjpEVFf449t+7GiulWodlI5l3
	jgeBzlna9/fSPJn0GcQoIdmao4asthqMl2RYPrjilZPVVm6LdbJ/Z0+iJDu56Voc
	Ri9NSJMPk+ZvsvWnEeoDg+Ua5C7fEuBKXn3tkMhLm1ZVO5gzd26lk56qlmahl+RN
	UFwGI7aO+8WJiJ3D8O8VYpeGpWdFgDx2wZLWUyHXvQz5kWF0b0M4S8PKhNKqhkNl
	MPpHTKgb/P253zDOajqW5vY8VxRXKHMikCIdQtjuG2py4E2oDBtqGWkawRJZac6P
	57ZaU+7bLZpgUZ/ivQ8Z+XQHGH+kfWVt0nyDs6ucZ6eyusvrx4VtZndSYqjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727866600; x=1727953000; bh=dlMhMVzRELe4UZSTK2pEfSalKtM9
	Uu7wV91OvMUNORk=; b=oJ6gGClrk9IH2rLgyZSQww5TVuwG1EyN6gUGFlW4Iel3
	kE5XaozyCxbnL6+mn9cELfOSsE5FEDpjscsad3nMnQY6jv6YOB9J5W2KfB6RUjXw
	JlWOuLCh8BmJ2xFufF4/Xtd4/ylADMQM9hZn8sX1jgHN6MiRj7si0/Yeff4cbRMH
	0pcWxIE0lw2tpad59kFyFiYhCQ2N+BaLtOPpCwG9BfSJmf7v8LAVtP4ZiXzgmB6Y
	2ZmPExK9KF/fzfhlcKj+JoKm4otliaCPTzdb9HxlyADA4ZpUYitLV/NFGAOvPu0y
	FtGa/8u9mfe5Q4q/N4FhhGHPWsUtrAN8g2nu/by7Vg==
X-ME-Sender: <xms:6Cb9ZjaqjVb58ZQXnEVsyP8giN7CHD2zsMwAPVpHCcHbcWGn77fkhw>
    <xme:6Cb9ZiYZ_Ca4-_2Kfd16X-3eIMIRwPjf0LjPeo2uZNWCI4PR-QGvjOFXjfV7V4G5h
    bVV77VYFwQj70gKww>
X-ME-Received: <xmr:6Cb9Zl8xVzK0XB9bshcqtJG9AF_nN4gv8966a3I8eeScE9P46zIJQRbDWSlD1Ydu7fyHO2Hc4r14Kh4cr-kQSOmI4BOcuveBpCkoY49nnDguF0mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhephfdvveekteejuddttdfghfegvdejfeejffegjeegjedv
    tdeftdelfeehtdejtdeunecuffhomhgrihhnpehuphgurghtvgdrvghmrghilhdpuhhpug
    grthgvrdhnrghmvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthht
    ohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlrdhsrdhrseif
    vggsrdguvg
X-ME-Proxy: <xmx:6Cb9ZprL8u9Cq0-1erj_B0Iee4fuIP-Kp_j1hwJWvKN9jtGvyFB4sA>
    <xmx:6Cb9ZurQiMfJsrlp-50pm3qcFjM80OPOcK1qdYL33iwePXIPEpJqlA>
    <xmx:6Cb9ZvTLkeUoP-BQB6lTE0FSgzkUws_DafGl3PcQGoo5Fu5oUBkz1Q>
    <xmx:6Cb9Zmqg3suYqhwQedvg7x8T5XWr_W8eTwh-_IDK-Zj_4YVrez5M6g>
    <xmx:6Cb9ZrCJLWYOgNBRJa3DFwzwBOmTg1w_dElsGk-UxPdniZ72ytb-0YK->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 06:56:39 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a5e4718f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 10:55:49 +0000 (UTC)
Date: Wed, 2 Oct 2024 12:56:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v5 24/25] reftable: introduce `REFTABLE_FREE_AND_NULL()`
Message-ID: <1c66f6ef8d9827653fd9df960330431877e1dbc9.1727866394.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727866394.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727866394.git.ps@pks.im>

We have several calls to `FREE_AND_NULL()` in the reftable library,
which of course uses free(3P). As the reftable allocators are pluggable
we should rather call the reftable specific function, which is
`reftable_free()`.

Introduce a new macro `REFTABLE_FREE_AND_NULL()` and adapt the callsites
accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.h               |  1 +
 reftable/block.c                |  6 +++---
 reftable/iter.c                 |  2 +-
 reftable/pq.c                   |  2 +-
 reftable/reader.c               |  2 +-
 reftable/record.c               | 10 +++++-----
 reftable/stack.c                |  8 ++++----
 reftable/writer.c               |  4 ++--
 t/unit-tests/t-reftable-stack.c |  2 +-
 9 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/reftable/basics.h b/reftable/basics.h
index 69adeab2e4..7f0f20e50c 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -71,6 +71,7 @@ char *reftable_strdup(const char *str);
 			REFTABLE_REALLOC_ARRAY(x, alloc); \
 		} \
 	} while (0)
+#define REFTABLE_FREE_AND_NULL(p) do { reftable_free(p); (p) = NULL; } while (0)
 
 /* Find the longest shared prefix size of `a` and `b` */
 struct strbuf;
diff --git a/reftable/block.c b/reftable/block.c
index bfa7dc61bf..8d41a2f99e 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -551,9 +551,9 @@ int block_iter_seek_key(struct block_iter *it, const struct block_reader *br,
 void block_writer_release(struct block_writer *bw)
 {
 	deflateEnd(bw->zstream);
-	FREE_AND_NULL(bw->zstream);
-	FREE_AND_NULL(bw->restarts);
-	FREE_AND_NULL(bw->compressed);
+	REFTABLE_FREE_AND_NULL(bw->zstream);
+	REFTABLE_FREE_AND_NULL(bw->restarts);
+	REFTABLE_FREE_AND_NULL(bw->compressed);
 	strbuf_release(&bw->last_key);
 	/* the block is not owned. */
 }
diff --git a/reftable/iter.c b/reftable/iter.c
index d319538f80..d926db653b 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -237,7 +237,7 @@ void reftable_iterator_destroy(struct reftable_iterator *it)
 		return;
 	it->ops->close(it->iter_arg);
 	it->ops = NULL;
-	FREE_AND_NULL(it->iter_arg);
+	REFTABLE_FREE_AND_NULL(it->iter_arg);
 }
 
 int reftable_iterator_seek_ref(struct reftable_iterator *it,
diff --git a/reftable/pq.c b/reftable/pq.c
index 03b9912282..6ee1164dd3 100644
--- a/reftable/pq.c
+++ b/reftable/pq.c
@@ -68,6 +68,6 @@ int merged_iter_pqueue_add(struct merged_iter_pqueue *pq, const struct pq_entry
 
 void merged_iter_pqueue_release(struct merged_iter_pqueue *pq)
 {
-	FREE_AND_NULL(pq->heap);
+	REFTABLE_FREE_AND_NULL(pq->heap);
 	memset(pq, 0, sizeof(*pq));
 }
diff --git a/reftable/reader.c b/reftable/reader.c
index 98e7aa2637..8d37253922 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -678,7 +678,7 @@ void reftable_reader_decref(struct reftable_reader *r)
 	if (--r->refcount)
 		return;
 	block_source_close(&r->source);
-	FREE_AND_NULL(r->name);
+	REFTABLE_FREE_AND_NULL(r->name);
 	reftable_free(r);
 }
 
diff --git a/reftable/record.c b/reftable/record.c
index 787e134c9a..30d563e16d 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -476,8 +476,8 @@ static void reftable_obj_record_key(const void *r, struct strbuf *dest)
 static void reftable_obj_record_release(void *rec)
 {
 	struct reftable_obj_record *obj = rec;
-	FREE_AND_NULL(obj->hash_prefix);
-	FREE_AND_NULL(obj->offsets);
+	REFTABLE_FREE_AND_NULL(obj->hash_prefix);
+	REFTABLE_FREE_AND_NULL(obj->offsets);
 	memset(obj, 0, sizeof(struct reftable_obj_record));
 }
 
@@ -834,10 +834,10 @@ static int reftable_log_record_decode(void *rec, struct strbuf key,
 	if (val_type != r->value_type) {
 		switch (r->value_type) {
 		case REFTABLE_LOG_UPDATE:
-			FREE_AND_NULL(r->value.update.message);
+			REFTABLE_FREE_AND_NULL(r->value.update.message);
 			r->value.update.message_cap = 0;
-			FREE_AND_NULL(r->value.update.email);
-			FREE_AND_NULL(r->value.update.name);
+			REFTABLE_FREE_AND_NULL(r->value.update.email);
+			REFTABLE_FREE_AND_NULL(r->value.update.name);
 			break;
 		case REFTABLE_LOG_DELETION:
 			break;
diff --git a/reftable/stack.c b/reftable/stack.c
index b2babe8e3d..63976e5cea 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -203,7 +203,7 @@ void reftable_stack_destroy(struct reftable_stack *st)
 
 	err = read_lines(st->list_file, &names);
 	if (err < 0) {
-		FREE_AND_NULL(names);
+		REFTABLE_FREE_AND_NULL(names);
 	}
 
 	if (st->readers) {
@@ -224,7 +224,7 @@ void reftable_stack_destroy(struct reftable_stack *st)
 		}
 		strbuf_release(&filename);
 		st->readers_len = 0;
-		FREE_AND_NULL(st->readers);
+		REFTABLE_FREE_AND_NULL(st->readers);
 	}
 
 	if (st->list_fd >= 0) {
@@ -232,8 +232,8 @@ void reftable_stack_destroy(struct reftable_stack *st)
 		st->list_fd = -1;
 	}
 
-	FREE_AND_NULL(st->list_file);
-	FREE_AND_NULL(st->reftable_dir);
+	REFTABLE_FREE_AND_NULL(st->list_file);
+	REFTABLE_FREE_AND_NULL(st->reftable_dir);
 	reftable_free(st);
 	free_names(names);
 }
diff --git a/reftable/writer.c b/reftable/writer.c
index 550172e65c..b032a47dec 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -593,7 +593,7 @@ static void object_record_free(void *void_arg UNUSED, void *key)
 {
 	struct obj_index_tree_node *entry = key;
 
-	FREE_AND_NULL(entry->offsets);
+	REFTABLE_FREE_AND_NULL(entry->offsets);
 	strbuf_release(&entry->hash);
 	reftable_free(entry);
 }
@@ -709,7 +709,7 @@ static void writer_clear_index(struct reftable_writer *w)
 {
 	for (size_t i = 0; w->index && i < w->index_len; i++)
 		strbuf_release(&w->index[i].last_key);
-	FREE_AND_NULL(w->index);
+	REFTABLE_FREE_AND_NULL(w->index);
 	w->index_len = 0;
 	w->index_cap = 0;
 }
diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index 6e41a4cf7e..cc2db2cdef 100644
--- a/t/unit-tests/t-reftable-stack.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -1149,7 +1149,7 @@ static void unclean_stack_close(struct reftable_stack *st)
 	for (size_t i = 0; i < st->readers_len; i++)
 		reftable_reader_decref(st->readers[i]);
 	st->readers_len = 0;
-	FREE_AND_NULL(st->readers);
+	REFTABLE_FREE_AND_NULL(st->readers);
 }
 
 static void t_reftable_stack_compaction_concurrent_clean(void)
-- 
2.47.0.rc0.dirty


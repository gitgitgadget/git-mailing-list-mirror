Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6B4209690
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 06:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728629686; cv=none; b=b6VM/DCIlLGGUPABNCA+5IqyQIDultudk+AEEWQHmI+TTKBL9uFi/VGP3OZfddnzefKhgONjSi0kKNv+pgSqbbzB4vTV3qJr1xd12J8/BjhD8QJtXZaB0ruNKmEc8Q0x018phc+j86U5zRiPUtYIxl3VODpi/ZUchf952zCOpnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728629686; c=relaxed/simple;
	bh=U+C08MYc0nYz8eqm5vuVIo48ekuiAH5qQgXIXLobtpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0D7I3nVsCM0gyyvwExjSoW47ot1K2hOzWSnhp3ubZ1/Lc5r5FKuDpSMfQTx5mVqSqk3/yoAMof9Rb8sZRTTFG5wVUK4s5zEpR/omGUbPz6F44G/nJXmWerYlxxIE6SCI7J1DAxwhzabJdvnMj5K0Bg68j9vTurZaNKRBrB9JM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=q1bHUsVE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XRdHhBI6; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="q1bHUsVE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XRdHhBI6"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id DB7C413801A5;
	Fri, 11 Oct 2024 02:54:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 11 Oct 2024 02:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728629683; x=1728716083; bh=TYRj1v0KEf
	GuhEFxNV7Wft2Xi/mAqGFbyOfcGzSS2ZQ=; b=q1bHUsVE4MDCbBWZaD0sv3ELqW
	jcW+nqbi96Umf0WOv8QYShoOctLzFbpj1x+aeZou6+5bkATSI7nQq69/kQTWBYLr
	Rw1iGhuDgNuJ6k6Vc3hylu5yCt1z0HJrOBWiTsNsOkpzrz+83avMRaOV6RziiiAr
	X2Mz+dLTxfe21NAPnfjX3GVxbGaWicnnsbCnFHLNsM4onVxgXrFDQLCnUYhH78MW
	gXtJd3ikJlfXtU4CqsFZx8YLAHdjncHAwbUfx0LdTHnF1llCYdnEpquefDMyn+ac
	J7Zsw7kcwVIQ8qkPaiMnWLJ8kmPJW2uyJZikarOjpVWeEMCr7MnEBOseXV3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728629683; x=1728716083; bh=TYRj1v0KEfGuhEFxNV7Wft2Xi/mA
	qGFbyOfcGzSS2ZQ=; b=XRdHhBI6K6OPQnNUKV5tF5CcC9KHKTdaPBaUtZfymJHB
	sfvxstmeYNWFDasImUZmrW9dvgHR5dGXjVNvEBeYWd3KBOZ1boKFHlBTEVj8B5HM
	hDVsXLnnh690jxgWeY8zVNGFqXLuDybHrRnAXN/mVV/8LZCmxu4OD95/EogLTFKw
	8fTYBfK5Ze6o6cVJ8hpmPajZALN6a4jzxy+t3+ujqywm7NhAFEIIsJesH+Vz2rti
	gz/x/pF7WFWESPB4TO/Zz04lgriY81pZ3lAAVOd0qrMrzIUqP6lAMYCqddPOtI9J
	TrgLpH88/jihZGMl6KRwGE75JfO7AMJIreKiWoSD9Q==
X-ME-Sender: <xms:s8sIZ95qdxzVGOIK4sVjfBRj8GASPWsme5UA8jnbNubjDCGDt4_BLQ>
    <xme:s8sIZ64Qerno_Zd-cQbXaLic6jkcJnRsooudOrVAhyLS9BtvfbGrfjMY1GCjzPenJ
    vWJGeCkF9-uiYZYSQ>
X-ME-Received: <xmr:s8sIZ0fGvd9gZQ_kR_TMpN90v0R9uCBcBsWNr0VOGlhAP2MYKyfI0rUytGCypeodLRN1xjohJRQd8dybo0Zj5_JDl-toPH-m1jGi3F8Q3aHkcgU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:s8sIZ2KiSGQbzXUMgjP1ih_Od17xfj3sJTVreJ-vO09sSPVrM53nvw>
    <xmx:s8sIZxL0bN9gxxT7DWsdGtQITP4tiMebwTVcdAFwPpBxAFwAvpHR6g>
    <xmx:s8sIZ_yzKiI9KX7NaixuRtuV3Dl-LXxM4d01RxaFh9fmqM0TCGFeDw>
    <xmx:s8sIZ9Kb0NDa8EQ8SbQKwWmtuuC2r1cX_vhfsAa0JQd_84TONMb0aQ>
    <xmx:s8sIZ4WxB6r1Zezd0FCQJciCQ6tvL4icR_zGJ0pv5hWQVzxrDE3-kvz5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 02:54:42 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 791e63ef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Oct 2024 06:53:36 +0000 (UTC)
Date: Fri, 11 Oct 2024 08:54:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 10/10] reftable: handle trivial `reftable_buf` errors
Message-ID: <8406948ae747844c3dfb1b5454218d116945897a.1728629612.git.ps@pks.im>
References: <cover.1728629612.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728629612.git.ps@pks.im>

Convert the reftable library such that we handle failures with the
new `reftable_buf` interfaces.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c  |  9 +++++++--
 reftable/iter.c   |  5 ++++-
 reftable/reader.c |  5 ++++-
 reftable/record.c | 32 +++++++++++++++++++++++--------
 reftable/stack.c  | 49 +++++++++++++++++++++++++++++++----------------
 reftable/writer.c | 48 +++++++++++++++++++++++++++++++++-------------
 6 files changed, 107 insertions(+), 41 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 697b8b41531..f5b432566a6 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -40,7 +40,9 @@ int footer_size(int version)
 static int block_writer_register_restart(struct block_writer *w, int n,
 					 int is_restart, struct reftable_buf *key)
 {
-	int rlen = w->restart_len;
+	int rlen, err;
+
+	rlen = w->restart_len;
 	if (rlen >= MAX_RESTARTS) {
 		is_restart = 0;
 	}
@@ -60,7 +62,10 @@ static int block_writer_register_restart(struct block_writer *w, int n,
 	w->next += n;
 
 	reftable_buf_reset(&w->last_key);
-	reftable_buf_add(&w->last_key, key->buf, key->len);
+	err = reftable_buf_add(&w->last_key, key->buf, key->len);
+	if (err < 0)
+		return err;
+
 	w->entries++;
 	return 0;
 }
diff --git a/reftable/iter.c b/reftable/iter.c
index 6c193fd31a9..86e801ca9fb 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -197,7 +197,10 @@ int indexed_table_ref_iter_new(struct indexed_table_ref_iter **dest,
 
 	*itr = empty;
 	itr->r = r;
-	reftable_buf_add(&itr->oid, oid, oid_len);
+
+	err = reftable_buf_add(&itr->oid, oid, oid_len);
+	if (err < 0)
+		goto out;
 
 	itr->offsets = offsets;
 	itr->offset_len = offset_len;
diff --git a/reftable/reader.c b/reftable/reader.c
index ab89efd9c55..90dc950b577 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -769,7 +769,10 @@ static int reftable_reader_refs_for_unindexed(struct reftable_reader *r,
 	}
 	*filter = empty;
 
-	reftable_buf_add(&filter->oid, oid, oid_len);
+	err = reftable_buf_add(&filter->oid, oid, oid_len);
+	if (err < 0)
+		goto out;
+
 	iterator_from_table_iter(&filter->it, ti);
 
 	iterator_from_filtering_ref_iterator(it, filter);
diff --git a/reftable/record.c b/reftable/record.c
index 672c5f909a9..fb5652ed575 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -102,7 +102,9 @@ static int decode_string(struct reftable_buf *dest, struct string_view in)
 {
 	int start_len = in.len;
 	uint64_t tsize = 0;
-	int n = get_var_int(&tsize, &in);
+	int n, err;
+
+	n = get_var_int(&tsize, &in);
 	if (n <= 0)
 		return -1;
 	string_view_consume(&in, n);
@@ -110,7 +112,10 @@ static int decode_string(struct reftable_buf *dest, struct string_view in)
 		return -1;
 
 	reftable_buf_reset(dest);
-	reftable_buf_add(dest, in.buf, tsize);
+	err = reftable_buf_add(dest, in.buf, tsize);
+	if (err < 0)
+		return err;
+
 	string_view_consume(&in, tsize);
 
 	return start_len - in.len;
@@ -189,7 +194,7 @@ int reftable_decode_key(struct reftable_buf *last_key, uint8_t *extra,
 	int start_len = in.len;
 	uint64_t prefix_len = 0;
 	uint64_t suffix_len = 0;
-	int n;
+	int err, n;
 
 	n = reftable_decode_keylen(in, &prefix_len, &suffix_len, extra);
 	if (n < 0)
@@ -200,8 +205,14 @@ int reftable_decode_key(struct reftable_buf *last_key, uint8_t *extra,
 	    prefix_len > last_key->len)
 		return -1;
 
-	reftable_buf_setlen(last_key, prefix_len);
-	reftable_buf_add(last_key, in.buf, suffix_len);
+	err = reftable_buf_setlen(last_key, prefix_len);
+	if (err < 0)
+		return err;
+
+	err = reftable_buf_add(last_key, in.buf, suffix_len);
+	if (err < 0)
+		return err;
+
 	string_view_consume(&in, suffix_len);
 
 	return start_len - in.len;
@@ -1047,9 +1058,12 @@ static int reftable_index_record_copy_from(void *rec, const void *src_rec,
 {
 	struct reftable_index_record *dst = rec;
 	const struct reftable_index_record *src = src_rec;
+	int err;
 
 	reftable_buf_reset(&dst->last_key);
-	reftable_buf_add(&dst->last_key, src->last_key.buf, src->last_key.len);
+	err = reftable_buf_add(&dst->last_key, src->last_key.buf, src->last_key.len);
+	if (err < 0)
+		return err;
 	dst->offset = src->offset;
 
 	return 0;
@@ -1090,10 +1104,12 @@ static int reftable_index_record_decode(void *rec, struct reftable_buf key,
 {
 	struct string_view start = in;
 	struct reftable_index_record *r = rec;
-	int n = 0;
+	int err, n = 0;
 
 	reftable_buf_reset(&r->last_key);
-	reftable_buf_add(&r->last_key, key.buf, key.len);
+	err = reftable_buf_add(&r->last_key, key.buf, key.len);
+	if (err < 0)
+		return err;
 
 	n = get_var_int(&r->offset, &in);
 	if (n < 0)
diff --git a/reftable/stack.c b/reftable/stack.c
index 243b10715cc..c33979536ef 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -78,8 +78,9 @@ int reftable_new_stack(struct reftable_stack **dest, const char *dir,
 	*dest = NULL;
 
 	reftable_buf_reset(&list_file_name);
-	reftable_buf_addstr(&list_file_name, dir);
-	reftable_buf_addstr(&list_file_name, "/tables.list");
+	if ((err = reftable_buf_addstr(&list_file_name, dir)) < 0 ||
+	    (err = reftable_buf_addstr(&list_file_name, "/tables.list")) < 0)
+		goto out;
 
 	p->list_file = reftable_buf_detach(&list_file_name);
 	p->list_fd = -1;
@@ -747,12 +748,14 @@ int reftable_addition_commit(struct reftable_addition *add)
 		goto done;
 
 	for (i = 0; i < add->stack->merged->readers_len; i++) {
-		reftable_buf_addstr(&table_list, add->stack->readers[i]->name);
-		reftable_buf_addstr(&table_list, "\n");
+		if ((err = reftable_buf_addstr(&table_list, add->stack->readers[i]->name)) < 0 ||
+		    (err = reftable_buf_addstr(&table_list, "\n")) < 0)
+			goto done;
 	}
 	for (i = 0; i < add->new_tables_len; i++) {
-		reftable_buf_addstr(&table_list, add->new_tables[i]);
-		reftable_buf_addstr(&table_list, "\n");
+		if ((err = reftable_buf_addstr(&table_list, add->new_tables[i])) < 0 ||
+		    (err = reftable_buf_addstr(&table_list, "\n")) < 0)
+			goto done;
 	}
 
 	err = write_in_full(lock_file_fd, table_list.buf, table_list.len);
@@ -867,7 +870,10 @@ int reftable_addition_add(struct reftable_addition *add,
 	err = stack_filename(&temp_tab_file_name, add->stack, next_name.buf);
 	if (err < 0)
 		goto done;
-	reftable_buf_addstr(&temp_tab_file_name, ".temp.XXXXXX");
+
+	err = reftable_buf_addstr(&temp_tab_file_name, ".temp.XXXXXX");
+	if (err < 0)
+		goto done;
 
 	tab_file = mks_tempfile(temp_tab_file_name.buf);
 	if (!tab_file) {
@@ -914,7 +920,10 @@ int reftable_addition_add(struct reftable_addition *add,
 	err = format_name(&next_name, wr->min_update_index, wr->max_update_index);
 	if (err < 0)
 		goto done;
-	reftable_buf_addstr(&next_name, ".ref");
+
+	err = reftable_buf_addstr(&next_name, ".ref");
+	if (err < 0)
+		goto done;
 
 	err = stack_filename(&tab_file_name, add->stack, next_name.buf);
 	if (err < 0)
@@ -975,7 +984,10 @@ static int stack_compact_locked(struct reftable_stack *st,
 	err = stack_filename(&tab_file_path, st, next_name.buf);
 	if (err < 0)
 		goto done;
-	reftable_buf_addstr(&tab_file_path, ".temp.XXXXXX");
+
+	err = reftable_buf_addstr(&tab_file_path, ".temp.XXXXXX");
+	if (err < 0)
+		goto done;
 
 	tab_file = mks_tempfile(tab_file_path.buf);
 	if (!tab_file) {
@@ -1404,7 +1416,9 @@ static int stack_compact_range(struct reftable_stack *st,
 		if (err < 0)
 			goto done;
 
-		reftable_buf_addstr(&new_table_name, ".ref");
+		err = reftable_buf_addstr(&new_table_name, ".ref");
+		if (err < 0)
+			goto done;
 
 		err = stack_filename(&new_table_path, st, new_table_name.buf);
 		if (err < 0)
@@ -1423,16 +1437,19 @@ static int stack_compact_range(struct reftable_stack *st,
 	 * simply skip writing it.
 	 */
 	for (i = 0; i < first_to_replace; i++) {
-		reftable_buf_addstr(&tables_list_buf, names[i]);
-		reftable_buf_addstr(&tables_list_buf, "\n");
+		if ((err = reftable_buf_addstr(&tables_list_buf, names[i])) < 0 ||
+		    (err = reftable_buf_addstr(&tables_list_buf, "\n")) < 0)
+		      goto done;
 	}
 	if (!is_empty_table) {
-		reftable_buf_addstr(&tables_list_buf, new_table_name.buf);
-		reftable_buf_addstr(&tables_list_buf, "\n");
+		if ((err = reftable_buf_addstr(&tables_list_buf, new_table_name.buf)) < 0 ||
+		    (err = reftable_buf_addstr(&tables_list_buf, "\n")) < 0)
+			goto done;
 	}
 	for (i = last_to_replace + 1; names[i]; i++) {
-		reftable_buf_addstr(&tables_list_buf, names[i]);
-		reftable_buf_addstr(&tables_list_buf, "\n");
+		if ((err = reftable_buf_addstr(&tables_list_buf, names[i])) < 0 ||
+		    (err = reftable_buf_addstr(&tables_list_buf, "\n")) < 0)
+			goto done;
 	}
 
 	err = write_in_full(get_lock_file_fd(&tables_list_lock),
diff --git a/reftable/writer.c b/reftable/writer.c
index 377db709c85..fd136794d5a 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -217,6 +217,7 @@ static int writer_index_hash(struct reftable_writer *w, struct reftable_buf *has
 	node = tree_search(w->obj_index_tree, &want, &obj_index_tree_node_compare);
 	if (!node) {
 		struct obj_index_tree_node empty = OBJ_INDEX_TREE_NODE_INIT;
+		int err;
 
 		key = reftable_malloc(sizeof(*key));
 		if (!key)
@@ -225,7 +226,9 @@ static int writer_index_hash(struct reftable_writer *w, struct reftable_buf *has
 		*key = empty;
 
 		reftable_buf_reset(&key->hash);
-		reftable_buf_add(&key->hash, hash->buf, hash->len);
+		err = reftable_buf_add(&key->hash, hash->buf, hash->len);
+		if (err < 0)
+			return err;
 		tree_insert(&w->obj_index_tree, key,
 			    &obj_index_tree_node_compare);
 	} else {
@@ -259,7 +262,10 @@ static int writer_add_record(struct reftable_writer *w,
 	}
 
 	reftable_buf_reset(&w->last_key);
-	reftable_buf_add(&w->last_key, key.buf, key.len);
+	err = reftable_buf_add(&w->last_key, key.buf, key.len);
+	if (err < 0)
+		goto done;
+
 	if (!w->block_writer) {
 		err = writer_reinit_block_writer(w, reftable_record_type(rec));
 		if (err < 0)
@@ -334,8 +340,10 @@ int reftable_writer_add_ref(struct reftable_writer *w,
 		goto out;
 
 	if (!w->opts.skip_index_objects && reftable_ref_record_val1(ref)) {
-		reftable_buf_add(&buf, (char *)reftable_ref_record_val1(ref),
-			   hash_size(w->opts.hash_id));
+		err = reftable_buf_add(&buf, (char *)reftable_ref_record_val1(ref),
+				       hash_size(w->opts.hash_id));
+		if (err < 0)
+			goto out;
 
 		err = writer_index_hash(w, &buf);
 		if (err < 0)
@@ -344,8 +352,10 @@ int reftable_writer_add_ref(struct reftable_writer *w,
 
 	if (!w->opts.skip_index_objects && reftable_ref_record_val2(ref)) {
 		reftable_buf_reset(&buf);
-		reftable_buf_add(&buf, reftable_ref_record_val2(ref),
-			   hash_size(w->opts.hash_id));
+		err = reftable_buf_add(&buf, reftable_ref_record_val2(ref),
+				       hash_size(w->opts.hash_id));
+		if (err < 0)
+			goto out;
 
 		err = writer_index_hash(w, &buf);
 		if (err < 0)
@@ -407,17 +417,27 @@ int reftable_writer_add_log(struct reftable_writer *w,
 
 	input_log_message = log->value.update.message;
 	if (!w->opts.exact_log_message && log->value.update.message) {
-		reftable_buf_addstr(&cleaned_message, log->value.update.message);
+		err = reftable_buf_addstr(&cleaned_message, log->value.update.message);
+		if (err < 0)
+			goto done;
+
 		while (cleaned_message.len &&
-		       cleaned_message.buf[cleaned_message.len - 1] == '\n')
-			reftable_buf_setlen(&cleaned_message,
-				      cleaned_message.len - 1);
+		       cleaned_message.buf[cleaned_message.len - 1] == '\n') {
+			err = reftable_buf_setlen(&cleaned_message,
+						  cleaned_message.len - 1);
+			if (err < 0)
+				goto done;
+		}
 		if (strchr(cleaned_message.buf, '\n')) {
 			/* multiple lines not allowed. */
 			err = REFTABLE_API_ERROR;
 			goto done;
 		}
-		reftable_buf_addstr(&cleaned_message, "\n");
+
+		err = reftable_buf_addstr(&cleaned_message, "\n");
+		if (err < 0)
+			goto done;
+
 		log->value.update.message = cleaned_message.buf;
 	}
 
@@ -781,8 +801,10 @@ static int writer_flush_nonempty_block(struct reftable_writer *w)
 
 	index_record.offset = w->next;
 	reftable_buf_reset(&index_record.last_key);
-	reftable_buf_add(&index_record.last_key, w->block_writer->last_key.buf,
-		   w->block_writer->last_key.len);
+	err = reftable_buf_add(&index_record.last_key, w->block_writer->last_key.buf,
+			       w->block_writer->last_key.len);
+	if (err < 0)
+		return err;
 	w->index[w->index_len] = index_record;
 	w->index_len++;
 
-- 
2.47.0.dirty


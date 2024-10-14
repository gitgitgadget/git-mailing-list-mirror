Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644A71AA7BA
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910971; cv=none; b=dLOKfuOwmv3eKHeKCcRsIfwiph8oonwmJ5q9XbsauEaoxYi5GIpyXjB+FB9t4tpjFN8heOrYYAk+kwHIbtIEVUeDcNWr9Wg5NFyQ/dK1iWCP+DqEKYTJ/xn/9HG8gkkqeryAl6FcX+HBanVJ+NzaGxEDurXE7ggmD5gG8MB+4g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910971; c=relaxed/simple;
	bh=U+C08MYc0nYz8eqm5vuVIo48ekuiAH5qQgXIXLobtpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAlw/r2AhwZ4M2ReEIIUNCBuq1Ff50mHb+eeiz90h6JikbdqgGgl3toXoLEXDbYOEAoGFiGYb1ig+k6T3T58uKYpzxbVMjnEYOOIrmWdsWNBzRbCgI/2nJnTT9Y7gktQSOK9YSZkZpeioc/p/bQTM7Xq9P1XXQOSC7FIfebJ7vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JuDpAL2y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FQMFs/MN; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JuDpAL2y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FQMFs/MN"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9263B1140109;
	Mon, 14 Oct 2024 09:02:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 14 Oct 2024 09:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728910968; x=1728997368; bh=TYRj1v0KEf
	GuhEFxNV7Wft2Xi/mAqGFbyOfcGzSS2ZQ=; b=JuDpAL2yPly6O1U+wUcUmKC/MO
	RTZGcZ6D0umRY+en2mDMpEuJ8p7/no4PeWBJORNY4d4y2/CpQEvQcGW+NsL2Cjtt
	2DsiXRtZS4DXI7NLAew7NvfJ0oJRJLGk31DHGJdJln243rPIR1p/0NtrPM3pEwR8
	xTjEdXWE3PCroVtxZjTOm/genD6u+XOMnFfjyY2lFRiK3tcN6vmsReXGC4c0jE/+
	9b7VOGhf5LwQw9rOGQl4lhavl/hD5M61s3fN33/RwUD21d2eKr0kXiNe6Z7QU49l
	ieQ/RiQ5abm1xOSPBMju8NEHb9vN5/cC6uShPIBtLRHQvXe5NiuJLKSGhP3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728910968; x=1728997368; bh=TYRj1v0KEfGuhEFxNV7Wft2Xi/mA
	qGFbyOfcGzSS2ZQ=; b=FQMFs/MNfq5oUugQ3I9WAVUYw+kk8wkYyVJHQVXJU7T9
	8qB7U2FaoGfrh2+6ARZkY+2V0QRMarjxzTt3l9oo7R6YN53yWEWvzOz9se+HjIUA
	XXG2+Yaa9I31OgHTr8EWVkocVmg4szxbIyYo4fwlUqWE6chf4pwczLLKlP2SxWrP
	fN7VdtmC6kU1/7iZyTVrfJ5uERjtWpf8D/R0APf8yMNvGRvr5kxw2a407l86xFm+
	INwUnkw2+rY/WtR896KALAQGF+FeEI+1nKuXTbHLP7JQGtrQJmfiOFURfB7by+pH
	zHxs8xuVQ4W03iWSPlrPPb6mWc3Qi9gYJmGM0Ekv0Q==
X-ME-Sender: <xms:eBYNZ3YylnzIM5JK8vDsgpxxPgMdsPHbjwKvGIZTFkDPiH50kjGeTw>
    <xme:eBYNZ2acBx55s42HkvASnZLgF-uMnEyaqCOZSLRI2xDdJx4UWw49V0OUHm4Z2Tzlu
    Rn4VcV85uKwmVrtYA>
X-ME-Received: <xmr:eBYNZ5-TKTmMX5nvtFl7chPCQ_JmKauxsT2-gdiIcqiCVNEznXKFdj9bp9MOlcKhBqDbJx1Wbhm83p9gST3LSORewyLA-qMjZ32Tdx7pYF4bWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:eBYNZ9ogzO5FT8WsbxR5yprBczlSgewqzZ_h3qxSQ3hO7kIjqWDh-w>
    <xmx:eBYNZyqdqaOToZhLhaOLxaBVn6s9qWHhvqjxDL14NJjSiUzUqRouvA>
    <xmx:eBYNZzRDCuLru7YEP9ZCRPk4EgToojkP8rq73yCGBfCpXm3dMbv1iw>
    <xmx:eBYNZ6rmTPVuQGdvUXJu-2ylwW5Ni-D5UORmgec1wpwT4fPQja9k8Q>
    <xmx:eBYNZ1VbPGu6sd6mgHXpXS98ulcteQ2VBYv8AZ_riUiK8zDDrUGKB3FP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 09:02:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0468aee0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Oct 2024 13:01:34 +0000 (UTC)
Date: Mon, 14 Oct 2024 15:02:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v2 10/10] reftable: handle trivial `reftable_buf` errors
Message-ID: <90819c90f3858af26d962bb03b801219ee64e2b9.1728910727.git.ps@pks.im>
References: <cover.1728629612.git.ps@pks.im>
 <cover.1728910726.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728910726.git.ps@pks.im>

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


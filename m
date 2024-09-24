Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8BB81742
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 06:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727159551; cv=none; b=QxmI14KbLEt3YBhr4MTNX6fR7h8S6MJ4BimN4IpxBhkxJIAzIAK3P3RZbdUVtbt2LHubaWFD5x96ciFHfpZjmR6LCONv03oZ0FQzqYfsWFhovUDB6cGWvYobh/2iDpxU30lrQh5wVMe7LkoaK9PeyQ0qCSZJO7Aac+Paxm213+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727159551; c=relaxed/simple;
	bh=OoDE6QbyWmiB0tY8TAaXBs+PlRS1J7q3vo27Wriwer8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4UxUsylU285aCpxOmJCEpQFXb2ytE273KEf4uQ2d6gE5Tb9aEJRK5wKEzQ+oh6/87MAC0ACvi2lIdud0te/ONn0rDPd00u/4QAUb1WBR1Ea7hrmn46xe8JZz6tecz7fn/ITecI+by/qY0sDAWoYZe90MsqebaK8SBt8Uyu9gWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V0Ek3RtJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k/jFyrUC; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V0Ek3RtJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k/jFyrUC"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 697E013802E7;
	Tue, 24 Sep 2024 02:32:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 24 Sep 2024 02:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727159548; x=1727245948; bh=nodU5Wpfva
	ETexR0m5fS54Oow+QaAsdGTAd59ppvM2A=; b=V0Ek3RtJH6LcAQ0TKT1GuSciBy
	zOU5EDfWpgxmzUtGdRbVIYGabDop/KrFBQ/w1EOm90H7D+byIgM5yjiW2/LfEm5f
	33D5nuoe3Nup4OPt1kjvLVsCGXnOTd7tu3Fn6Sx7N4gok/pOyuXESeHRtdVTqV5o
	21k7Dz3pfw4MM2ORSgOPAxFNl5gfm1EvWWqlsfEX1dNn6oASYkGF+8VyF0acehho
	H1V1MfKl5DzrKoq0e7gjDqMzehsvDckIY7L3haP6A20BVmgzzPYq8S+i35xMPGCV
	WwdEklXrNra5qGtx7qwz2WJ9S21Xfbr6dtxtI4ephNOHu3P5GumssF+9jJug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727159548; x=1727245948; bh=nodU5WpfvaETexR0m5fS54Oow+Qa
	AsdGTAd59ppvM2A=; b=k/jFyrUCRwirNsKA8LThBSMZwRdrQKzKLKFqIgie/X2/
	JH4fuC2HdffgyxCI/6sfwwBv3cRQuT7cXqbu/deevS3hihq2kDZxcXB3UXK3d4/R
	A9aODx9BogYdSAIdWN5zh7cHTZA6G4QZ8hlPNqGXeFnnhA376AK8JKdqb+QOfSsg
	exgD4mSMM9eqvePGdCFdtqoDDWh4BgQ6+iKzIuHcLEcRFBnO38R6wHySiwPgv8CZ
	0RMdTAxz+mClbzGo2vXiSuhibjVIBKcBMd22MCCHGlK1Rk1b0n9APOjfWNnwRlxU
	Y/EATmVin6bNl3D4hYEvygPhvvoXI/IvZVyAOvZcdQ==
X-ME-Sender: <xms:_FzyZrDrN6pILVCZziyoggJadmhbc467M9QOLYf8Exfd1NPj9M0YVw>
    <xme:_FzyZhiWxeXKCkK5QQs8XSYVw2iK4FkuiU5mHcC4Y3h060RSstlIDTUjdG5pAPgjH
    LyONBiA1pFdi2KhWg>
X-ME-Received: <xmr:_FzyZmnQen-BPz3igYeWlJYIhJadFDmT3igZZsEW7_UN_mE3Jz886ZEAxXDqDGK3uegJNTq1IcP3TXueo3ULEoijjaDq8ESyGCPzBMh_FVRHGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtuddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:_FzyZtx-OBIBMw9eSiA04GAlfx2DiktU0WqyASY_jF305vkh_nnsZA>
    <xmx:_FzyZgRwG3sXNsu8xLAP_geAvOnhbTJyLaf5--XCaEcBgZjaXL9odQ>
    <xmx:_FzyZgbm6E3MnYCbC4bAQelxM2VdjuLh6UhiUSnZ01iM8O_qsOcUVw>
    <xmx:_FzyZhTm-B6h0UEUC9u3i-Bhcp-EZpuxtW3DeVGP9YaDXGuqub9ZIQ>
    <xmx:_FzyZmfGaZCbOVwqBBo6B7RZaBTgDu3qvCBmMSvjLcfEDL72SEs8VP3G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 02:32:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 065526df (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Sep 2024 06:31:54 +0000 (UTC)
Date: Tue, 24 Sep 2024 08:32:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 10/22] reftable/merged: handle allocation failures in
 `merged_table_init_iter()`
Message-ID: <a84e9cadae486557caa92a4962ad880f0cf58420.1727158127.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727158127.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727158127.git.ps@pks.im>

Handle allocation failures in `merged_table_init_iter()`. While at it,
merge `merged_iter_init()` into the function. It only has a single
caller and merging them makes it easier to handle allocation failures
consistently.

This change also requires us to adapt `reftable_stack_init_*_iterator()`
to bubble up the new error codes of `merged_table_iter_init()`. Adapt
callsites accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c          | 39 +++++++++++++----
 reftable/merged.c                | 74 ++++++++++++++++++++------------
 reftable/merged.h                |  6 +--
 reftable/reftable-merged.h       |  8 ++--
 reftable/reftable-stack.h        |  8 ++--
 reftable/stack.c                 | 34 ++++++++++-----
 t/helper/test-reftable.c         | 10 ++++-
 t/unit-tests/t-reftable-merged.c | 12 ++++--
 t/unit-tests/t-reftable-stack.c  |  4 +-
 9 files changed, 131 insertions(+), 64 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 5c241097a4e..9c08c46c85e 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1299,7 +1299,9 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 			struct reftable_log_record log = {0};
 			struct reftable_iterator it = {0};
 
-			reftable_stack_init_log_iterator(arg->stack, &it);
+			ret = reftable_stack_init_log_iterator(arg->stack, &it);
+			if (ret < 0)
+				goto done;
 
 			/*
 			 * When deleting refs we also delete all reflog entries
@@ -1669,7 +1671,10 @@ static int write_copy_table(struct reftable_writer *writer, void *cb_data)
 	 * copy over all log entries from the old reflog. Last but not least,
 	 * when renaming we also have to delete all the old reflog entries.
 	 */
-	reftable_stack_init_log_iterator(arg->stack, &it);
+	ret = reftable_stack_init_log_iterator(arg->stack, &it);
+	if (ret < 0)
+		goto done;
+
 	ret = reftable_iterator_seek_log(&it, arg->oldname);
 	if (ret < 0)
 		goto done;
@@ -1890,7 +1895,10 @@ static struct reftable_reflog_iterator *reflog_iterator_for_stack(struct reftabl
 	if (ret < 0)
 		goto done;
 
-	reftable_stack_init_log_iterator(stack, &iter->iter);
+	ret = reftable_stack_init_log_iterator(stack, &iter->iter);
+	if (ret < 0)
+		goto done;
+
 	ret = reftable_iterator_seek_log(&iter->iter, "");
 	if (ret < 0)
 		goto done;
@@ -1957,7 +1965,10 @@ static int reftable_be_for_each_reflog_ent_reverse(struct ref_store *ref_store,
 	if (refs->err < 0)
 		return refs->err;
 
-	reftable_stack_init_log_iterator(stack, &it);
+	ret = reftable_stack_init_log_iterator(stack, &it);
+	if (ret < 0)
+		goto done;
+
 	ret = reftable_iterator_seek_log(&it, refname);
 	while (!ret) {
 		ret = reftable_iterator_next_log(&it, &log);
@@ -1973,6 +1984,7 @@ static int reftable_be_for_each_reflog_ent_reverse(struct ref_store *ref_store,
 			break;
 	}
 
+done:
 	reftable_log_record_release(&log);
 	reftable_iterator_destroy(&it);
 	return ret;
@@ -1994,7 +2006,10 @@ static int reftable_be_for_each_reflog_ent(struct ref_store *ref_store,
 	if (refs->err < 0)
 		return refs->err;
 
-	reftable_stack_init_log_iterator(stack, &it);
+	ret = reftable_stack_init_log_iterator(stack, &it);
+	if (ret < 0)
+		goto done;
+
 	ret = reftable_iterator_seek_log(&it, refname);
 	while (!ret) {
 		struct reftable_log_record log = {0};
@@ -2044,7 +2059,10 @@ static int reftable_be_reflog_exists(struct ref_store *ref_store,
 	if (ret < 0)
 		goto done;
 
-	reftable_stack_init_log_iterator(stack, &it);
+	ret = reftable_stack_init_log_iterator(stack, &it);
+	if (ret < 0)
+		goto done;
+
 	ret = reftable_iterator_seek_log(&it, refname);
 	if (ret < 0)
 		goto done;
@@ -2150,7 +2168,9 @@ static int write_reflog_delete_table(struct reftable_writer *writer, void *cb_da
 
 	reftable_writer_set_limits(writer, ts, ts);
 
-	reftable_stack_init_log_iterator(arg->stack, &it);
+	ret = reftable_stack_init_log_iterator(arg->stack, &it);
+	if (ret < 0)
+		goto out;
 
 	/*
 	 * In order to delete a table we need to delete all reflog entries one
@@ -2174,6 +2194,7 @@ static int write_reflog_delete_table(struct reftable_writer *writer, void *cb_da
 		ret = reftable_writer_add_log(writer, &tombstone);
 	}
 
+out:
 	reftable_log_record_release(&log);
 	reftable_iterator_destroy(&it);
 	return ret;
@@ -2312,7 +2333,9 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 	if (ret < 0)
 		goto done;
 
-	reftable_stack_init_log_iterator(stack, &it);
+	ret = reftable_stack_init_log_iterator(stack, &it);
+	if (ret < 0)
+		goto done;
 
 	ret = reftable_iterator_seek_log(&it, refname);
 	if (ret < 0)
diff --git a/reftable/merged.c b/reftable/merged.c
index 128a810c55d..5a8ea8ae779 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -30,22 +30,6 @@ struct merged_iter {
 	ssize_t advance_index;
 };
 
-static void merged_iter_init(struct merged_iter *mi,
-			     struct reftable_merged_table *mt,
-			     uint8_t typ)
-{
-	memset(mi, 0, sizeof(*mi));
-	mi->advance_index = -1;
-	mi->suppress_deletions = mt->suppress_deletions;
-
-	REFTABLE_CALLOC_ARRAY(mi->subiters, mt->readers_len);
-	for (size_t i = 0; i < mt->readers_len; i++) {
-		reftable_record_init(&mi->subiters[i].rec, typ);
-		reader_init_iter(mt->readers[i], &mi->subiters[i].iter, typ);
-	}
-	mi->subiters_len = mt->readers_len;
-}
-
 static void merged_iter_close(void *p)
 {
 	struct merged_iter *mi = p;
@@ -244,25 +228,61 @@ reftable_merged_table_min_update_index(struct reftable_merged_table *mt)
 	return mt->min;
 }
 
-void merged_table_init_iter(struct reftable_merged_table *mt,
-			    struct reftable_iterator *it,
-			    uint8_t typ)
+int merged_table_init_iter(struct reftable_merged_table *mt,
+			   struct reftable_iterator *it,
+			   uint8_t typ)
 {
-	struct merged_iter *mi = reftable_malloc(sizeof(*mi));
-	merged_iter_init(mi, mt, typ);
+	struct merged_subiter *subiters;
+	struct merged_iter *mi = NULL;
+	int ret;
+
+	REFTABLE_CALLOC_ARRAY(subiters, mt->readers_len);
+	if (!subiters) {
+		ret = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto out;
+	}
+
+	for (size_t i = 0; i < mt->readers_len; i++) {
+		reftable_record_init(&subiters[i].rec, typ);
+		reader_init_iter(mt->readers[i], &subiters[i].iter, typ);
+	}
+
+	REFTABLE_CALLOC_ARRAY(mi, 1);
+	if (!mi) {
+		ret = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto out;
+	}
+	mi->advance_index = -1;
+	mi->suppress_deletions = mt->suppress_deletions;
+	mi->subiters = subiters;
+	mi->subiters_len = mt->readers_len;
+
 	iterator_from_merged_iter(it, mi);
+	ret = 0;
+
+out:
+	if (ret < 0) {
+		for (size_t i = 0; subiters && i < mt->readers_len; i++) {
+			reftable_iterator_destroy(&subiters[i].iter);
+			reftable_record_release(&subiters[i].rec);
+		}
+		free(subiters);
+		free(mi);
+	}
+
+	return ret;
 }
 
-void reftable_merged_table_init_ref_iterator(struct reftable_merged_table *mt,
-					     struct reftable_iterator *it)
+int reftable_merged_table_init_ref_iterator(struct reftable_merged_table *mt,
+					    struct reftable_iterator *it)
 {
-	merged_table_init_iter(mt, it, BLOCK_TYPE_REF);
+	return merged_table_init_iter(mt, it, BLOCK_TYPE_REF);
 }
 
-void reftable_merged_table_init_log_iterator(struct reftable_merged_table *mt,
-					     struct reftable_iterator *it)
+int reftable_merged_table_init_log_iterator(struct reftable_merged_table *mt,
+					    struct reftable_iterator *it)
 {
-	merged_table_init_iter(mt, it, BLOCK_TYPE_LOG);
+	return merged_table_init_iter(mt, it, BLOCK_TYPE_LOG);
 }
 
 uint32_t reftable_merged_table_hash_id(struct reftable_merged_table *mt)
diff --git a/reftable/merged.h b/reftable/merged.h
index de5fd33f010..89bd0c4b35b 100644
--- a/reftable/merged.h
+++ b/reftable/merged.h
@@ -26,8 +26,8 @@ struct reftable_merged_table {
 
 struct reftable_iterator;
 
-void merged_table_init_iter(struct reftable_merged_table *mt,
-			    struct reftable_iterator *it,
-			    uint8_t typ);
+int merged_table_init_iter(struct reftable_merged_table *mt,
+			   struct reftable_iterator *it,
+			   uint8_t typ);
 
 #endif
diff --git a/reftable/reftable-merged.h b/reftable/reftable-merged.h
index 16d19f8df20..a970d5dd89a 100644
--- a/reftable/reftable-merged.h
+++ b/reftable/reftable-merged.h
@@ -37,12 +37,12 @@ int reftable_merged_table_new(struct reftable_merged_table **dest,
 			      uint32_t hash_id);
 
 /* Initialize a merged table iterator for reading refs. */
-void reftable_merged_table_init_ref_iterator(struct reftable_merged_table *mt,
-					     struct reftable_iterator *it);
+int reftable_merged_table_init_ref_iterator(struct reftable_merged_table *mt,
+					    struct reftable_iterator *it);
 
 /* Initialize a merged table iterator for reading logs. */
-void reftable_merged_table_init_log_iterator(struct reftable_merged_table *mt,
-					     struct reftable_iterator *it);
+int reftable_merged_table_init_log_iterator(struct reftable_merged_table *mt,
+					    struct reftable_iterator *it);
 
 /* returns the max update_index covered by this merged table. */
 uint64_t
diff --git a/reftable/reftable-stack.h b/reftable/reftable-stack.h
index f4f8cabc7fb..e958f911b4e 100644
--- a/reftable/reftable-stack.h
+++ b/reftable/reftable-stack.h
@@ -73,16 +73,16 @@ struct reftable_iterator;
  * be used to iterate through refs. The iterator is valid until the next reload
  * or write.
  */
-void reftable_stack_init_ref_iterator(struct reftable_stack *st,
-				      struct reftable_iterator *it);
+int reftable_stack_init_ref_iterator(struct reftable_stack *st,
+				     struct reftable_iterator *it);
 
 /*
  * Initialize an iterator for the merged tables contained in the stack that can
  * be used to iterate through logs. The iterator is valid until the next reload
  * or write.
  */
-void reftable_stack_init_log_iterator(struct reftable_stack *st,
-				      struct reftable_iterator *it);
+int reftable_stack_init_log_iterator(struct reftable_stack *st,
+				     struct reftable_iterator *it);
 
 /* returns the merged_table for seeking. This table is valid until the
  * next write or reload, and should not be closed or deleted.
diff --git a/reftable/stack.c b/reftable/stack.c
index ea21ca6e5f5..bb4d2309189 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -136,18 +136,18 @@ int read_lines(const char *filename, char ***namesp)
 	return err;
 }
 
-void reftable_stack_init_ref_iterator(struct reftable_stack *st,
+int reftable_stack_init_ref_iterator(struct reftable_stack *st,
 				      struct reftable_iterator *it)
 {
-	merged_table_init_iter(reftable_stack_merged_table(st),
-			       it, BLOCK_TYPE_REF);
+	return merged_table_init_iter(reftable_stack_merged_table(st),
+				      it, BLOCK_TYPE_REF);
 }
 
-void reftable_stack_init_log_iterator(struct reftable_stack *st,
-				      struct reftable_iterator *it)
+int reftable_stack_init_log_iterator(struct reftable_stack *st,
+				     struct reftable_iterator *it)
 {
-	merged_table_init_iter(reftable_stack_merged_table(st),
-			       it, BLOCK_TYPE_LOG);
+	return merged_table_init_iter(reftable_stack_merged_table(st),
+				      it, BLOCK_TYPE_LOG);
 }
 
 struct reftable_merged_table *
@@ -952,7 +952,10 @@ static int stack_write_compact(struct reftable_stack *st,
 	if (err < 0)
 		goto done;
 
-	merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
+	err = merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
+	if (err < 0)
+		goto done;
+
 	err = reftable_iterator_seek_ref(&it, "");
 	if (err < 0)
 		goto done;
@@ -977,7 +980,10 @@ static int stack_write_compact(struct reftable_stack *st,
 	}
 	reftable_iterator_destroy(&it);
 
-	merged_table_init_iter(mt, &it, BLOCK_TYPE_LOG);
+	err = merged_table_init_iter(mt, &it, BLOCK_TYPE_LOG);
+	if (err < 0)
+		goto done;
+
 	err = reftable_iterator_seek_log(&it, "");
 	if (err < 0)
 		goto done;
@@ -1496,7 +1502,10 @@ int reftable_stack_read_ref(struct reftable_stack *st, const char *refname,
 	struct reftable_iterator it = { 0 };
 	int ret;
 
-	reftable_merged_table_init_ref_iterator(st->merged, &it);
+	ret = reftable_merged_table_init_ref_iterator(st->merged, &it);
+	if (ret)
+		goto out;
+
 	ret = reftable_iterator_seek_ref(&it, refname);
 	if (ret)
 		goto out;
@@ -1523,7 +1532,10 @@ int reftable_stack_read_log(struct reftable_stack *st, const char *refname,
 	struct reftable_iterator it = {0};
 	int err;
 
-	reftable_stack_init_log_iterator(st, &it);
+	err = reftable_stack_init_log_iterator(st, &it);
+	if (err)
+		goto done;
+
 	err = reftable_iterator_seek_log(&it, refname);
 	if (err)
 		goto done;
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 29d4e9a755d..5c8849d115b 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -28,7 +28,10 @@ static int dump_table(struct reftable_merged_table *mt)
 	const struct git_hash_algo *algop;
 	int err;
 
-	reftable_merged_table_init_ref_iterator(mt, &it);
+	err = reftable_merged_table_init_ref_iterator(mt, &it);
+	if (err < 0)
+		return err;
+
 	err = reftable_iterator_seek_ref(&it, "");
 	if (err < 0)
 		return err;
@@ -63,7 +66,10 @@ static int dump_table(struct reftable_merged_table *mt)
 	reftable_iterator_destroy(&it);
 	reftable_ref_record_release(&ref);
 
-	reftable_merged_table_init_log_iterator(mt, &it);
+	err = reftable_merged_table_init_log_iterator(mt, &it);
+	if (err < 0)
+		return err;
+
 	err = reftable_iterator_seek_log(&it, "");
 	if (err < 0)
 		return err;
diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index 19e54bdfb8b..3d2848632db 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -82,7 +82,8 @@ static void t_merged_single_record(void)
 	struct reftable_iterator it = { 0 };
 	int err;
 
-	merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
+	err = merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
+	check(!err);
 	err = reftable_iterator_seek_ref(&it, "a");
 	check(!err);
 
@@ -161,7 +162,8 @@ static void t_merged_refs(void)
 	size_t cap = 0;
 	size_t i;
 
-	merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
+	err = merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
+	check(!err);
 	err = reftable_iterator_seek_ref(&it, "a");
 	check(!err);
 	check_int(reftable_merged_table_hash_id(mt), ==, GIT_SHA1_FORMAT_ID);
@@ -367,7 +369,8 @@ static void t_merged_logs(void)
 	size_t cap = 0;
 	size_t i;
 
-	merged_table_init_iter(mt, &it, BLOCK_TYPE_LOG);
+	err = merged_table_init_iter(mt, &it, BLOCK_TYPE_LOG);
+	check(!err);
 	err = reftable_iterator_seek_log(&it, "a");
 	check(!err);
 	check_int(reftable_merged_table_hash_id(mt), ==, GIT_SHA1_FORMAT_ID);
@@ -390,7 +393,8 @@ static void t_merged_logs(void)
 		check(reftable_log_record_equal(want[i], &out[i],
 						 GIT_SHA1_RAWSZ));
 
-	merged_table_init_iter(mt, &it, BLOCK_TYPE_LOG);
+	err = merged_table_init_iter(mt, &it, BLOCK_TYPE_LOG);
+	check(!err);
 	err = reftable_iterator_seek_log_at(&it, "a", 2);
 	check(!err);
 	reftable_log_record_release(&out[0]);
diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index 65e513d5ec8..6e41a4cf7e5 100644
--- a/t/unit-tests/t-reftable-stack.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -599,7 +599,9 @@ static void t_reftable_stack_iterator(void)
 
 	reftable_iterator_destroy(&it);
 
-	reftable_stack_init_log_iterator(st, &it);
+	err = reftable_stack_init_log_iterator(st, &it);
+	check(!err);
+
 	reftable_iterator_seek_log(&it, logs[0].refname);
 	for (i = 0; ; i++) {
 		struct reftable_log_record log = { 0 };
-- 
2.46.0.551.gc5ee8f2d1c.dirty


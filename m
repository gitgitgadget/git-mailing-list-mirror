Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F78161320
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 15:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724082009; cv=none; b=r0ITI+ldcHyAAcIEhIPl+FVyDVRi9vjfW6hPL4QTIaEWt/ade+OxAUWExitd/oR/tyy2SGDP+YS4Yt+zLlN5thES6VZac1Hev8vbIxgb/stbKpTCZg2l6XAJAefif6lM+jygv6nDiCtYui+bYVhluqePY/yw9rctXGyoeVu8blk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724082009; c=relaxed/simple;
	bh=EfZxkguDU0v+bWLzcI608qN3qqOraERCl9qE3rZhHLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGRpvq+b0Fq1XSnjU8QUWeKaJdACgsBUF38knyeDI9jAYboRJ95m76ePAwUT/LIsw3bv0FUuc+aTBWikea7BtlUdzffpbIP+pFIHhYTSEt5n5GOA2YfOMHQZfkxT3qrIxG4Z/YLXUWRRz3Cl3U1wSbmjc8UOCSyjXyTkOc4CSDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ngtkItGl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dK3fqsDV; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ngtkItGl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dK3fqsDV"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id E2F82138FF3A;
	Mon, 19 Aug 2024 11:40:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 19 Aug 2024 11:40:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724082006; x=1724168406; bh=Wu8sfZVfcb
	bcORKjzT2qa59A83bW2tKFIu2PvDPSazE=; b=ngtkItGlw8E6yH9TFarEcsOba7
	PZA5iCcZL9aw4Ft+bDR7Kq0P3lbzx8z5FbTCG20jGGTLBzy3N8kTAZyYW0Dpxo3d
	dSG2gTjLXlKLV0TrOciLJU2zVeDRTNJMb3EBc+tltjDsT3yt+F0W1cuMXdm1DlHN
	Jrnj+n3s529Hj+5zrl9NxfKvYEaii2e+WhgT+JYcY11APShGIw6rKHeTTkd/mBgU
	+/IBfXp/p7NdXWo42ZEIzE9G+3DvMiQA6V0iCU3TNdjabhC7q+Wk0rcaYD6h+SMu
	HnPgswGvY8/rSbnF06sTYSVMaMa57sJtzHdOhi+cL0RqM+o+GTn48DmG1Wig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724082006; x=1724168406; bh=Wu8sfZVfcbbcORKjzT2qa59A83bW
	2tKFIu2PvDPSazE=; b=dK3fqsDVMzZZb4GEtGCcp+1ifcmfQmOSyGxnMiOyzQLS
	dbi20BJPTD3C1WYQq+SzGzeFSIvaU4xCAZLkjdgXt/MWVSW38IhSLRtupi50ok+r
	16NYgr5TKGnCMZcnURdXxpPbn20wD8aCSnsn6TSx35EWVqCcdeLupXmbRrMqx5YG
	6xNdSbUI53sKlaGEUfcnZeSZFPUn90VUq7EHJRtKyb2OFWgFgbcD6200qMBTmoBA
	OcQMcTDWW2WimUnevWsHNuVVF/bdYbQRO+oXPtIqZoRDxx8+OFWKq7KokznCHwo/
	oYNwRsXEV8pv4QrJsxvx4eRCkGArobNPELnCPGdSEA==
X-ME-Sender: <xms:VmfDZiZdofkElmoza8t3syzU5dEPHcxOApUcs-BepYDB4e7rJD6fyA>
    <xme:VmfDZlbpYl6_t8D8vGJFxDQYFAuYi0ktvpyGX7dqy64BReF7CSdx8T4Y5xFs4cbM9
    uZ-of7J20OqdGbV7Q>
X-ME-Received: <xmr:VmfDZs_1aLQV2ClgTEfCuuh_avYgXdjhAiYdesD7KFZciJwRp-9HgjWMmx9vINdR8zf2thhVfRQ2uKMKTrEoS3DoUEaR-hP5WfMbp58ljck0Ffw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddugedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:VmfDZkoPQH87pBKZcRAvW7xqLM6m3YG6miRr0SVJwU1D2Oe8ATa_lg>
    <xmx:VmfDZtrCfjx_d8wCNlELI9Zj917DsM-ZGaEpySB1DaH6JMf2qEdMQA>
    <xmx:VmfDZiRv59Jb8Tq0DdXAy3Nskz4k8-UYgch8uk9yV51yeuy19V9uNQ>
    <xmx:VmfDZto7Mto6wz6Q6O7WN1jRZ-65mDoErTG2SqpUMWIDWrS21xj34Q>
    <xmx:VmfDZk2RqdMZOYcHfNJbz12iR2aER2VEFXugi_kEYegozHZE23aHTu_U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Aug 2024 11:40:06 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0ebab0c6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Aug 2024 15:39:36 +0000 (UTC)
Date: Mon, 19 Aug 2024 17:40:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH 07/10] reftable/reader: introduce refcounting
Message-ID: <fc0ed68d4675bcd4c89bf63419ec6e8b6b7f5fca.1724080006.git.ps@pks.im>
References: <cover.1724080006.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724080006.git.ps@pks.im>

It was recently reported that concurrent reads and writes may cause the
reftable backend to segfault. The root cause of this is that we do not
properly keep track of reftable readers across reloads.

Suppose that you have a reftable iterator and then decide to reload the
stack while iterating through the iterator. When the stack has been
rewritten since we have created the iterator, then we would end up
discarding a subset of readers that may still be in use by the iterator.
The consequence is that we now try to reference deallocated memory,
which of course segfaults.

One way to trigger this is in t5616, where some background maintenance
jobs have been leaking from one test into another. This leads to stack
traces like the following one:

  + git -c protocol.version=0 -C pc1 fetch --filter=blob:limit=29999 --refetch origin
  AddressSanitizer:DEADLYSIGNAL
  =================================================================
  ==657994==ERROR: AddressSanitizer: SEGV on unknown address 0x7fa0f0ec6089 (pc 0x55f23e52ddf9 bp
0x7ffe7bfa1700 sp 0x7ffe7bfa1700 T0)
  ==657994==The signal is caused by a READ memory access.
      #0 0x55f23e52ddf9 in get_var_int reftable/record.c:29
      #1 0x55f23e53295e in reftable_decode_keylen reftable/record.c:170
      #2 0x55f23e532cc0 in reftable_decode_key reftable/record.c:194
      #3 0x55f23e54e72e in block_iter_next reftable/block.c:398
      #4 0x55f23e5573dc in table_iter_next_in_block reftable/reader.c:240
      #5 0x55f23e5573dc in table_iter_next reftable/reader.c:355
      #6 0x55f23e5573dc in table_iter_next reftable/reader.c:339
      #7 0x55f23e551283 in merged_iter_advance_subiter reftable/merged.c:69
      #8 0x55f23e55169e in merged_iter_next_entry reftable/merged.c:123
      #9 0x55f23e55169e in merged_iter_next_void reftable/merged.c:172
      #10 0x55f23e537625 in reftable_iterator_next_ref reftable/generic.c:175
      #11 0x55f23e2cf9c6 in reftable_ref_iterator_advance refs/reftable-backend.c:464
      #12 0x55f23e2d996e in ref_iterator_advance refs/iterator.c:13
      #13 0x55f23e2d996e in do_for_each_ref_iterator refs/iterator.c:452
      #14 0x55f23dca6767 in get_ref_map builtin/fetch.c:623
      #15 0x55f23dca6767 in do_fetch builtin/fetch.c:1659
      #16 0x55f23dca6767 in fetch_one builtin/fetch.c:2133
      #17 0x55f23dca6767 in cmd_fetch builtin/fetch.c:2432
      #18 0x55f23dba7764 in run_builtin git.c:484
      #19 0x55f23dba7764 in handle_builtin git.c:741
      #20 0x55f23dbab61e in run_argv git.c:805
      #21 0x55f23dbab61e in cmd_main git.c:1000
      #22 0x55f23dba4781 in main common-main.c:64
      #23 0x7fa0f063fc89 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
      #24 0x7fa0f063fd44 in __libc_start_main_impl ../csu/libc-start.c:360
      #25 0x55f23dba6ad0 in _start (git+0xadfad0) (BuildId: 803b2b7f59beb03d7849fb8294a8e2145dd4aa27)

While it is somewhat awkward that the maintenance processes survive
tests in the first place, it is totally expected that reftables should
work alright with concurrent writers. Seemingly they don't.

The only underlying resource that we need to care about in this context
is the reftable reader, which is responsible for reading a single table
from disk. These readers get discarded immediately (unless reused) when
calling `reftable_stack_reload()`, which is wrong. We can only close
them once we know that there are no iterators using them anymore.

Prepare for a fix by converting the reftable readers to be refcounted.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reader.c                | 16 ++++++++++++++--
 reftable/reader.h                |  2 ++
 reftable/readwrite_test.c        | 18 +++++++++---------
 reftable/reftable-reader.h       | 15 ++++++++++++---
 reftable/stack.c                 |  8 ++++----
 reftable/stack_test.c            |  6 ++----
 t/helper/test-reftable.c         |  2 +-
 t/unit-tests/t-reftable-merged.c |  4 ++--
 8 files changed, 46 insertions(+), 25 deletions(-)

diff --git a/reftable/reader.c b/reftable/reader.c
index 037417fcf6..64a0953e68 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -621,6 +621,7 @@ int reftable_reader_new(struct reftable_reader **out,
 	r->source = *source;
 	r->name = xstrdup(name);
 	r->hash_id = 0;
+	r->refcount = 1;
 
 	err = block_source_read_block(source, &footer, r->size,
 				      footer_size(r->version));
@@ -645,10 +646,21 @@ int reftable_reader_new(struct reftable_reader **out,
 	return err;
 }
 
-void reftable_reader_free(struct reftable_reader *r)
+void reftable_reader_incref(struct reftable_reader *r)
+{
+	if (!r->refcount)
+		BUG("cannot increment ref counter of dead reader");
+	r->refcount++;
+}
+
+void reftable_reader_decref(struct reftable_reader *r)
 {
 	if (!r)
 		return;
+	if (!r->refcount)
+		BUG("cannot decrement ref counter of dead reader");
+	if (--r->refcount)
+		return;
 	block_source_close(&r->source);
 	FREE_AND_NULL(r->name);
 	reftable_free(r);
@@ -812,7 +824,7 @@ int reftable_reader_print_blocks(const char *tablename)
 	}
 
 done:
-	reftable_reader_free(r);
+	reftable_reader_decref(r);
 	table_iter_close(&ti);
 	return err;
 }
diff --git a/reftable/reader.h b/reftable/reader.h
index 88b4f3b421..3710ee09b4 100644
--- a/reftable/reader.h
+++ b/reftable/reader.h
@@ -50,6 +50,8 @@ struct reftable_reader {
 	struct reftable_reader_offsets ref_offsets;
 	struct reftable_reader_offsets obj_offsets;
 	struct reftable_reader_offsets log_offsets;
+
+	uint64_t refcount;
 };
 
 const char *reader_name(struct reftable_reader *r);
diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index 2f2ff787b2..0494e7955a 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -279,7 +279,7 @@ static void test_log_write_read(void)
 	/* cleanup. */
 	strbuf_release(&buf);
 	free_names(names);
-	reftable_reader_free(reader);
+	reftable_reader_decref(reader);
 }
 
 static void test_log_zlib_corruption(void)
@@ -341,7 +341,7 @@ static void test_log_zlib_corruption(void)
 	reftable_iterator_destroy(&it);
 
 	/* cleanup. */
-	reftable_reader_free(reader);
+	reftable_reader_decref(reader);
 	strbuf_release(&buf);
 }
 
@@ -383,7 +383,7 @@ static void test_table_read_write_sequential(void)
 	EXPECT(j == N);
 
 	reftable_iterator_destroy(&it);
-	reftable_reader_free(reader);
+	reftable_reader_decref(reader);
 	strbuf_release(&buf);
 	free_names(names);
 }
@@ -431,7 +431,7 @@ static void test_table_read_api(void)
 	}
 	reftable_iterator_destroy(&it);
 	reftable_free(names);
-	reftable_reader_free(reader);
+	reftable_reader_decref(reader);
 	strbuf_release(&buf);
 }
 
@@ -498,7 +498,7 @@ static void test_table_read_write_seek(int index, int hash_id)
 		reftable_free(names[i]);
 	}
 	reftable_free(names);
-	reftable_reader_free(reader);
+	reftable_reader_decref(reader);
 }
 
 static void test_table_read_write_seek_linear(void)
@@ -611,7 +611,7 @@ static void test_table_refs_for(int indexed)
 	strbuf_release(&buf);
 	free_names(want_names);
 	reftable_iterator_destroy(&it);
-	reftable_reader_free(reader);
+	reftable_reader_decref(reader);
 }
 
 static void test_table_refs_for_no_index(void)
@@ -657,7 +657,7 @@ static void test_write_empty_table(void)
 	EXPECT(err > 0);
 
 	reftable_iterator_destroy(&it);
-	reftable_reader_free(rd);
+	reftable_reader_decref(rd);
 	strbuf_release(&buf);
 }
 
@@ -863,7 +863,7 @@ static void test_write_multiple_indices(void)
 
 	reftable_iterator_destroy(&it);
 	reftable_writer_free(writer);
-	reftable_reader_free(reader);
+	reftable_reader_decref(reader);
 	strbuf_release(&writer_buf);
 	strbuf_release(&buf);
 }
@@ -919,7 +919,7 @@ static void test_write_multi_level_index(void)
 
 	reftable_iterator_destroy(&it);
 	reftable_writer_free(writer);
-	reftable_reader_free(reader);
+	reftable_reader_decref(reader);
 	strbuf_release(&writer_buf);
 	strbuf_release(&buf);
 }
diff --git a/reftable/reftable-reader.h b/reftable/reftable-reader.h
index 8a05c84685..a600452b56 100644
--- a/reftable/reftable-reader.h
+++ b/reftable/reftable-reader.h
@@ -33,6 +33,18 @@ struct reftable_reader;
 int reftable_reader_new(struct reftable_reader **pp,
 			struct reftable_block_source *src, const char *name);
 
+/*
+ * Manage the reference count of the reftable reader. A newly initialized
+ * reader starts with a refcount of 1 and will be deleted once the refcount has
+ * reached 0.
+ *
+ * This is required because readers may have longer lifetimes than the stack
+ * they belong to. The stack may for example be reloaded while the old tables
+ * are still being accessed by an iterator.
+ */
+void reftable_reader_incref(struct reftable_reader *reader);
+void reftable_reader_decref(struct reftable_reader *reader);
+
 /* Initialize a reftable iterator for reading refs. */
 void reftable_reader_init_ref_iterator(struct reftable_reader *r,
 				       struct reftable_iterator *it);
@@ -44,9 +56,6 @@ void reftable_reader_init_log_iterator(struct reftable_reader *r,
 /* returns the hash ID used in this table. */
 uint32_t reftable_reader_hash_id(struct reftable_reader *r);
 
-/* closes and deallocates a reader. */
-void reftable_reader_free(struct reftable_reader *);
-
 /* return an iterator for the refs pointing to `oid`. */
 int reftable_reader_refs_for(struct reftable_reader *r,
 			     struct reftable_iterator *it, uint8_t *oid);
diff --git a/reftable/stack.c b/reftable/stack.c
index 0ac9cdf8de..8e85f8b4d9 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -186,7 +186,7 @@ void reftable_stack_destroy(struct reftable_stack *st)
 			if (names && !has_name(names, name)) {
 				stack_filename(&filename, st, name);
 			}
-			reftable_reader_free(st->readers[i]);
+			reftable_reader_decref(st->readers[i]);
 
 			if (filename.len) {
 				/* On Windows, can only unlink after closing. */
@@ -290,7 +290,7 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 			const char *name = reader_name(cur[i]);
 			stack_filename(&table_path, st, name);
 
-			reftable_reader_free(cur[i]);
+			reftable_reader_decref(cur[i]);
 
 			/* On Windows, can only unlink after closing. */
 			unlink(table_path.buf);
@@ -299,7 +299,7 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 
 done:
 	for (i = 0; i < new_readers_len; i++)
-		reftable_reader_free(new_readers[i]);
+		reftable_reader_decref(new_readers[i]);
 	reftable_free(new_readers);
 	reftable_free(cur);
 	strbuf_release(&table_path);
@@ -1534,7 +1534,7 @@ static void remove_maybe_stale_table(struct reftable_stack *st, uint64_t max,
 		goto done;
 
 	update_idx = reftable_reader_max_update_index(rd);
-	reftable_reader_free(rd);
+	reftable_reader_decref(rd);
 
 	if (update_idx <= max) {
 		unlink(table_path.buf);
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index de0669b7b8..bc3bf77274 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -1036,10 +1036,8 @@ static void test_reftable_stack_compaction_concurrent(void)
 static void unclean_stack_close(struct reftable_stack *st)
 {
 	/* break abstraction boundary to simulate unclean shutdown. */
-	int i = 0;
-	for (; i < st->readers_len; i++) {
-		reftable_reader_free(st->readers[i]);
-	}
+	for (size_t i = 0; i < st->readers_len; i++)
+		reftable_reader_decref(st->readers[i]);
 	st->readers_len = 0;
 	FREE_AND_NULL(st->readers);
 }
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 87c2f42aae..f6d855a9d7 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -152,7 +152,7 @@ static int dump_reftable(const char *tablename)
 
 done:
 	reftable_merged_table_free(mt);
-	reftable_reader_free(r);
+	reftable_reader_decref(r);
 	return err;
 }
 
diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index 8f51aca1b6..081d3c8b69 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -115,7 +115,7 @@ merged_table_from_records(struct reftable_ref_record **refs,
 static void readers_destroy(struct reftable_reader **readers, const size_t n)
 {
 	for (size_t i = 0; i < n; i++)
-		reftable_reader_free(readers[i]);
+		reftable_reader_decref(readers[i]);
 	reftable_free(readers);
 }
 
@@ -437,7 +437,7 @@ static void t_default_write_opts(void)
 	err = reftable_merged_table_new(&merged, &rd, 1, GIT_SHA1_FORMAT_ID);
 	check(!err);
 
-	reftable_reader_free(rd);
+	reftable_reader_decref(rd);
 	reftable_merged_table_free(merged);
 	strbuf_release(&buf);
 }
-- 
2.46.0.164.g477ce5ccd6.dirty


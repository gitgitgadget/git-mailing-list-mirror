Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1812818BB9A
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724422384; cv=none; b=V43Ng9ibPdLi89hFwrfRAb3Wq9XmedVXwpGHGQta+HN9cDNLjkIGfJ3rOJNKZmaRFfwwY2yuHXEI7Je9tFloPkEfyWczleSZrquqWbO9m2jy/lIzqTNh1FdH4EHqyyNT/1GGzqNbhUjjUt4AfScqfwt+cWRYrFAIHw9i/Qx6wL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724422384; c=relaxed/simple;
	bh=xvgZQtuMN7A8KhF41cJQlXkBiA2m8w641bGW+GLbWPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WF0/LZ6WfJ9T2VsuhP8zFxjbP7dxC2q1C9/p8D8MCeYeiF1HANw6kp/izfV5ejwMwfa4ATI7dmaN3cJdI8OEjf4JITSBwC03p9IEPGpLCCMnT71vBxq5JdUiI3rk2s8Fig6+65rAnKfd5EOJAN+FQGvzF0JANdfaseHN4/h8HJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DUzzS2Le; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IYk+bQlq; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DUzzS2Le";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IYk+bQlq"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 668E01151B87;
	Fri, 23 Aug 2024 10:13:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 23 Aug 2024 10:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724422382; x=1724508782; bh=0hrv8nM1Id
	avGFwL6RP9zWOo3xcReikyLTLNX0+pKtk=; b=DUzzS2LeWKX3fSVXyy2bYico2a
	LvwlZe2+Q3KODiy8smUz8dUY3rTfXk5H9gA2MMQzvU+E9fBCG3AAMLbGSLHmNmz6
	md690sTiJa41lp2T5cXVRlFYJLLsqfh0ArwDk2Ys3XzXa/DTZA0KffpaQXg2OIxn
	3F711IQ1F0TrgLyLit5tqfRdPYUYfJAegPBJ4uZ8mMZdRGHaOmu7lF6OASbxCZjD
	2PoszQPWCJGgmRfsD3PwauMfM6tfK/XQJrcDIqNS6eNnqwnArlZlnN+o3THJU1oq
	DIo0UT1DaOl3ccqxQzGlMQ61otxsKYnxwM28eOX2WoWpLVIiYcYkhJc5y8Og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724422382; x=1724508782; bh=0hrv8nM1IdavGFwL6RP9zWOo3xcR
	eikyLTLNX0+pKtk=; b=IYk+bQlq4TA1XgS7K5AQhCTWAol0oc54iO8MSkrkwUbO
	jbVDpP10lqqBqSkDV91eSlzSWqv8ALmHfV/NlwqARcGfORcr9k48/be8gH1gf2QD
	ZsRLcqCCrgqnf9Hbjr/Ddr8DO8MCCoTiR+8bNslik48gckY33o0zH93+Gjbp92fR
	9M8FukFhzEsOQmxw0cDP+CsaIx/8j7ZSho9hGwD6MG/eJzHzBKzMWur8bBUezvOM
	TGWvbO6wXznyjfeJiZrczlHQ+xYfY6/CTnTwvuKxx73Gl/3KeTknGQSCxvZj05Tr
	4L3O2BksXe4oGi0xhX8AuHAAJ0/XqlOpPU4ZkoP85w==
X-ME-Sender: <xms:7pjIZvt7ZWU_Tc5h6QqNWXOcFYrIxEhagvIXdDgSpxYn25Bjx1vzSQ>
    <xme:7pjIZgdo85YtM7a19UctiCJ5MouL5DcwmRd-q51Px3LSoZkmBLTpdZjMKEQ6zC0iR
    dsTWpH--ArSVtEwMA>
X-ME-Received: <xmr:7pjIZizt7eRe1nmzEKA6VuzQkatKtQyYmAJ9heYBCKRrtKs1273dpDUQch4CLO8ORbDP157OSG9dntCQYWVe3vTkzL76733UckE44Fp0uBccArzTLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvvddgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:7pjIZuPv1k3sSPA168C-0DEh2XP1bGL_5cVnD4V1DTaRUKdTVFltGQ>
    <xmx:7pjIZv_ZkXvUZ3mqf8cuBGEK2B4EzTJQ-7ah7-Uxhqhvw0F7LOjJIQ>
    <xmx:7pjIZuWH70Cu_g5mgehCxzIaZ3Xzb-ilJNdr67KJ9iRjs7hMCe1QXg>
    <xmx:7pjIZgcszilqRvxWDeo_R8-8MvUdLXRxyf63wG7cAPYFgAJHmhITMg>
    <xmx:7pjIZraU4Hs3DiUvnk3n7AzbX-iN2M2nJvMQUp3x1a65jCdlvTKaeiG3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Aug 2024 10:13:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5ed3510b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Aug 2024 14:12:24 +0000 (UTC)
Date: Fri, 23 Aug 2024 16:12:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, karthik nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 10/10] reftable/stack: fix segfault when reload with
 reused readers fails
Message-ID: <4a8d45cc9b49c3351012a36728ee2295b002709a.1724420744.git.ps@pks.im>
References: <cover.1724080006.git.ps@pks.im>
 <cover.1724420744.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724420744.git.ps@pks.im>

It is expected that reloading the stack fails with concurrent writers,
e.g. because a table that we just wanted to read just got compacted.
In case we decided to reuse readers this will cause a segfault though
because we unconditionally release all new readers, including the reused
ones. As those are still referenced by the current stack, the result is
that we will eventually try to dereference those already-freed readers.

Fix this bug by incrementing the refcount of reused readers temporarily.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c      | 23 +++++++++++++++++
 reftable/stack_test.c | 59 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/reftable/stack.c b/reftable/stack.c
index 02472222589..ce0a35216ba 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -226,6 +226,8 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 {
 	size_t cur_len = !st->merged ? 0 : st->merged->readers_len;
 	struct reftable_reader **cur = stack_copy_readers(st, cur_len);
+	struct reftable_reader **reused = NULL;
+	size_t reused_len = 0, reused_alloc = 0;
 	size_t names_len = names_length(names);
 	struct reftable_reader **new_readers =
 		reftable_calloc(names_len, sizeof(*new_readers));
@@ -245,6 +247,18 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 			if (cur[i] && 0 == strcmp(cur[i]->name, name)) {
 				rd = cur[i];
 				cur[i] = NULL;
+
+				/*
+				 * When reloading the stack fails, we end up
+				 * releasing all new readers. This also
+				 * includes the reused readers, even though
+				 * they are still in used by the old stack. We
+				 * thus need to keep them alive here, which we
+				 * do by bumping their refcount.
+				 */
+				REFTABLE_ALLOC_GROW(reused, reused_len + 1, reused_alloc);
+				reused[reused_len++] = rd;
+				reftable_reader_incref(rd);
 				break;
 			}
 		}
@@ -301,10 +315,19 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 	new_readers = NULL;
 	new_readers_len = 0;
 
+	/*
+	 * Decrement the refcount of reused readers again. This only needs to
+	 * happen on the successful case, because on the unsuccessful one we
+	 * decrement their refcount via `new_readers`.
+	 */
+	for (i = 0; i < reused_len; i++)
+		reftable_reader_decref(reused[i]);
+
 done:
 	for (i = 0; i < new_readers_len; i++)
 		reftable_reader_decref(new_readers[i]);
 	reftable_free(new_readers);
+	reftable_free(reused);
 	reftable_free(cur);
 	strbuf_release(&table_path);
 	return err;
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 7fb5beb7c94..6809bf9d300 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -10,6 +10,7 @@ license that can be found in the LICENSE file or at
 
 #include "system.h"
 
+#include "copy.h"
 #include "reftable-reader.h"
 #include "merged.h"
 #include "basics.h"
@@ -1125,6 +1126,63 @@ static void test_reftable_stack_read_across_reload(void)
 	clear_dir(dir);
 }
 
+static void test_reftable_stack_reload_with_missing_table(void)
+{
+	struct reftable_write_options opts = { 0 };
+	struct reftable_stack *st = NULL;
+	struct reftable_ref_record rec = { 0 };
+	struct reftable_iterator it = { 0 };
+	struct strbuf table_path = STRBUF_INIT, content = STRBUF_INIT;
+	char *dir = get_tmp_dir(__LINE__);
+	int err;
+
+	/* Create a first stack and set up an iterator for it. */
+	err = reftable_new_stack(&st, dir, &opts);
+	EXPECT_ERR(err);
+	write_n_ref_tables(st, 2);
+	EXPECT(st->merged->readers_len == 2);
+	reftable_stack_init_ref_iterator(st, &it);
+	err = reftable_iterator_seek_ref(&it, "");
+	EXPECT_ERR(err);
+
+	/*
+	 * Update the tables.list file with some garbage data, while reusing
+	 * our old readers. This should trigger a partial reload of the stack,
+	 * where we try to reuse our old readers.
+	*/
+	strbuf_addf(&content, "%s\n", st->readers[0]->name);
+	strbuf_addf(&content, "%s\n", st->readers[1]->name);
+	strbuf_addstr(&content, "garbage\n");
+	strbuf_addf(&table_path, "%s.lock", st->list_file);
+	write_file_buf(table_path.buf, content.buf, content.len);
+	err = rename(table_path.buf, st->list_file);
+	EXPECT_ERR(err);
+
+	err = reftable_stack_reload(st);
+	EXPECT(err == -4);
+	EXPECT(st->merged->readers_len == 2);
+
+	/*
+	 * Even though the reload has failed, we should be able to continue
+	 * using the iterator.
+	*/
+	err = reftable_iterator_next_ref(&it, &rec);
+	EXPECT_ERR(err);
+	EXPECT(!strcmp(rec.refname, "refs/heads/branch-0000"));
+	err = reftable_iterator_next_ref(&it, &rec);
+	EXPECT_ERR(err);
+	EXPECT(!strcmp(rec.refname, "refs/heads/branch-0001"));
+	err = reftable_iterator_next_ref(&it, &rec);
+	EXPECT(err > 0);
+
+	reftable_ref_record_release(&rec);
+	reftable_iterator_destroy(&it);
+	reftable_stack_destroy(st);
+	strbuf_release(&table_path);
+	strbuf_release(&content);
+	clear_dir(dir);
+}
+
 int stack_test_main(int argc, const char *argv[])
 {
 	RUN_TEST(test_empty_add);
@@ -1148,6 +1206,7 @@ int stack_test_main(int argc, const char *argv[])
 	RUN_TEST(test_reftable_stack_update_index_check);
 	RUN_TEST(test_reftable_stack_uptodate);
 	RUN_TEST(test_reftable_stack_read_across_reload);
+	RUN_TEST(test_reftable_stack_reload_with_missing_table);
 	RUN_TEST(test_suggest_compaction_segment);
 	RUN_TEST(test_suggest_compaction_segment_nothing);
 	return 0;
-- 
2.46.0.164.g477ce5ccd6.dirty


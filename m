Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB3A16C841
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724082018; cv=none; b=Zi6PYDga295gE408oz6O85CUzHqa09p0tm7nmpKBGKX3wrLH+Lc5QGJJKJ1xQe//rtdnLpVlxJKRN1r4/0FdrxEttB5RdUV6/8uHL3LOunS2PDEq+y38gjJtHJlf3d6xgRXvDP+SWC7/PBzBGDbQOoGcybNPUICXHbVEfh760PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724082018; c=relaxed/simple;
	bh=uTuNQN2aeI5JQ7bygsG0vSAFo+okIgdf8vWrkSSYYtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzxv0s5UWTlYdoSA2y6BH5UB8pvEBIxf1kBOMvr4EfKtvG8SgCuIWRIVQ9QwP/TMTW8Wl5CSb+1AI/LwPWfMKXrCit2onOvQM9RtL/4Dol5xPntQkwz7kD7wNw8iTh3zIsqO/q6jUQdKW7LaF/mT37oBKMKG9it1I3vL8cdO/3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oitTj2Pc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mBGKiyhf; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oitTj2Pc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mBGKiyhf"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 10B3B1151777;
	Mon, 19 Aug 2024 11:40:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 19 Aug 2024 11:40:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724082016; x=1724168416; bh=3dhawzIhf3
	g+dK1xM3sD3m391psSw0rHv4B9Ng53oaQ=; b=oitTj2PceGgGNxB9iAS5YjLbpw
	KBU8BLWOK9GZqws0sGuok/U0nI3jYAVdRfJnOzjMp3dCgpzpApDHGom/Lk9bGh8h
	zUkDnpEHPklNPzPBCx824j7q0qTMncgc3ewfimTP4a/AoGhN9Yj+/ypmskbdkfXb
	LvEa9fkU3t/E1ZTsRWLBO2wCedKxkGsjZ4On3EGQX5VBlvgrH7pklWV0fwRVgsbc
	1HrBF3XqOQTP9NzmScRDFgiCfewkoFYw2b1nTDFmx/SskmTbDRhne16AzmV+BYZs
	icXXyW099IULebMExvGFALPMBVZNw86squP5McyAZtEXQkltmShtyjgJaFKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724082016; x=1724168416; bh=3dhawzIhf3g+dK1xM3sD3m391psS
	w0rHv4B9Ng53oaQ=; b=mBGKiyhfjPvd5YZxaPFhS7kcVLRv0jHcHXopybqp1z+Q
	W8ppz1ggdLNYG2mu1k7Hj/XicZPx2IGjoUGUOLu8jvlCV/w5wbHPwrBKReqtjF9v
	mtl6L4NIt60x0AGCm4TWLTs8bjQusn90XmDR8cKYuegGRsbob9VnaRVRsIa2upwY
	L8VicWIbRPFJ0OhhnISx1ZoCpPjpnv1CU+iwgDrPDcqUAULU3NsjMm49a88Ora9y
	2OPNKvKIUy7nzSX5FMYSAUp+kSTvNheL+L5TGHL8DMckuDwj35tC85+a7ijDqQo7
	o5Wv1dkDPC2aJOEJWyM9mbLUz7v6T0Ezif9fsz48Rw==
X-ME-Sender: <xms:X2fDZurq09_VNAKw6ub0gVfM1WCCiVjeTQsb0I16a7A7hedGRyJFng>
    <xme:X2fDZspd93V_Finxj1xPd_XUA6gPYmwjcdZo8lr-COQ9MZVNOUjlpCpWzTGHkoikN
    kxcY4THvdsj-q4V5Q>
X-ME-Received: <xmr:X2fDZjPDLhK_WQC9-m5EWXnrO2Q88hW-xU9ETNzUbbilmMOowRT455lMEuRYX_b_5NukEYcKrl0Iy_Pyy4-9A-u1QGDsD7G0rDH-mGdbIowuUJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddugedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:X2fDZt5aMDN35ZcNoQ8jIuZucXAjTnnRH-DAntYwMRDz8J7iDF9E3A>
    <xmx:X2fDZt7oJcKIBOhHigLOcGUCEC-H94w4pHiIPNAgJQUkCrJB3wWGEA>
    <xmx:X2fDZtg26mpRv0aMidoxI3T78ss8WkWX4iGAQhf_pBNh8IWcnHR8Zg>
    <xmx:X2fDZn77vEQVJJpIHfjdydNi2NZ28WkgId0_Lfie-WPZLZHgG7zXKQ>
    <xmx:YGfDZtHzZdlzqpy3KMk2IANZLllWxue2zqbpPE6k4EYuqkWEgr5F1z-C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Aug 2024 11:40:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b8a29f6a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Aug 2024 15:39:45 +0000 (UTC)
Date: Mon, 19 Aug 2024 17:40:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH 10/10] reftable/stack: fix segfault when reload with reused
 readers fails
Message-ID: <b777818ea998806b75a1ed84a5ceefd28f0ca523.1724080006.git.ps@pks.im>
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
index 0247222258..ce0a35216b 100644
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
index 91e716dc0a..30cdb1739c 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -10,6 +10,7 @@ license that can be found in the LICENSE file or at
 
 #include "system.h"
 
+#include "copy.h"
 #include "reftable-reader.h"
 #include "merged.h"
 #include "basics.h"
@@ -1124,6 +1125,63 @@ static void test_reftable_stack_read_across_reload(void)
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
@@ -1147,6 +1205,7 @@ int stack_test_main(int argc, const char *argv[])
 	RUN_TEST(test_reftable_stack_update_index_check);
 	RUN_TEST(test_reftable_stack_uptodate);
 	RUN_TEST(test_reftable_stack_read_across_reload);
+	RUN_TEST(test_reftable_stack_reload_with_missing_table);
 	RUN_TEST(test_suggest_compaction_segment);
 	RUN_TEST(test_suggest_compaction_segment_nothing);
 	return 0;
-- 
2.46.0.164.g477ce5ccd6.dirty


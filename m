Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18936209689
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 06:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728629658; cv=none; b=QFYXhH/vxmD/azzH0NBtRTrGT4CVn6UXIr+cZB9PejrEEZE1wbvrG1q4qbe6jfykzd8Xr9Dz0ZiV/710cEghkzXHEdCQ9AjuDiy1I177rYmW9yun43fdIS25oAtMYGpwXM8YQAIJy8l+cPA53x0schQ4ljX6Co9c51r/TmQbTeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728629658; c=relaxed/simple;
	bh=QiIgH3+DoxRRaRm41tG8oRz/75QsbdkzymroiB9ksaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lj31bHUiHZOmhwH1q5HFzyTlXlEjLLorcGGfuMNmcLPIV84SehuNNbKo+lL4yTqfmINjNYECVzXMdcaGo6aUhk1MWcRBFcjblosO+px2FXpCJF+ubOL0yccHkJCdzSoRepVSSBuDZ9RSBB0Vx8TVzGhCcbZZ8gwOEBuj9JWdUPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ikBbVwLt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BjX23TXl; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ikBbVwLt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BjX23TXl"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 173D41140165;
	Fri, 11 Oct 2024 02:54:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 11 Oct 2024 02:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728629655; x=1728716055; bh=ukFxIgWuPn
	AfvqCJ1BRtEJu+rCa0/1/sFYDCB3gveR8=; b=ikBbVwLt2wlrGT2hiWWjfL0/Ob
	/yog+ajnzTLa12MA9qRbQFBWoaGLbw1t+8e1rc1z42gXLj/JH9M12HnZ4IfosImE
	aNS0J78F1LWuWAjl0vxJYtkXwK1ZowSLd8hlDu6/PZXDkihvUmgcL+ZAJ2WF6jm3
	nlyNpcpSlNaoGpW7xvJeCaqk/lFvuJDroKdAsQ59k3T3iIRyTNG644cFBnj3Gf4f
	+haMXBOT91aLIVQTa4vueIEEBpibNIm41VV+gXPuHPSC81uToWwuGfKXe5gfPJ3h
	kAbKKy0+MoSNM287dGfw32Jv8vEhzBHUGNt5+rAvMzhU+J49WkEqh6kziEqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728629655; x=1728716055; bh=ukFxIgWuPnAfvqCJ1BRtEJu+rCa0
	/1/sFYDCB3gveR8=; b=BjX23TXlZy+1HsO74UA7KS3uZGlSgd7IIqgFYgVdeckZ
	kcr0N9VyUNviXhxVRbCbOE7XnrsArjHF5+Hr0b9vbe8Km7fgTJus6y9Vcb8SNqtb
	knFSBbkVM0w7HzhA/MuyJeuTJHwPR2DJhpSAMXw+7YSYKxTjLjsnjEQIWbzE6YIC
	lgu59yahz6s+D5gBK9tMfssW3Wwe4hTrFehQx25YEtlRGH8g754Vm92nzW0PDdK0
	dkxJ3J/iq/sKRT5RJroiBw4WoXRnM4sZhnLebl7u2qWnAmEf47vvH89Mbyz3HUdn
	BDSNk8l5ow2Jw1Wr5pPjhNMIkdK9r1SzZNyvjiULsg==
X-ME-Sender: <xms:lssIZxEKsIjYAj0IcJO1p0LFhDtT9sF2D1Sdl3twhtkC-Ffc40pdNw>
    <xme:lssIZ2WroakRmpq58tT4ZwL4aVYSFh5aLmkppYpt06wXbIA8Su9wER-hWrIcq1VrX
    FMzY58Rv-MMgbXCbQ>
X-ME-Received: <xmr:lssIZzIQTwj3trtehPxcqZZO9Vx6HBFLhu4KQ4EL_4qz1ol1xIcDgYZueE_h2Fd0JAZ6HVCgRezjz6yEOIh3tWaJqYJTfBEqezCEdPOUqua_a7E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:lssIZ3E9MiFrrbfbEmSzRtgQDuJqa6My45fI2nyKMSaiEIQFttvpAQ>
    <xmx:lssIZ3VzBySU1cTy-AkdS2SVwJ5qY1vHR30xqQHEnuk49-rU_I4ICQ>
    <xmx:lssIZyPjqW8RbRGjGO-hO8I3S-qW9YK2alCEiU_-7P_v2MhIyLkJuQ>
    <xmx:lssIZ225SF6Ww7Ip7t8R8AHak06edEPyHzVSI3LN9ttkL1TMSnUd2Q>
    <xmx:l8sIZ0iaX13liAbFWP7BxCrH0eSXL_eVB4Cx5eXbjlwJ6Z5fL5To0LP9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 02:54:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 07428e47 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Oct 2024 06:53:08 +0000 (UTC)
Date: Fri, 11 Oct 2024 08:54:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 02/10] reftable: stop using `strbuf_addf()`
Message-ID: <abc28d7664f151e00568a6a3d18bf8a2de46470d.1728629612.git.ps@pks.im>
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

We're about to introduce our own `reftable_buf` type to replace
`strbuf`. Get rid of the seldomly-used `strbuf_addf()` function such
that we have to reimplement one less function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c                    | 18 ++++++++-----
 t/unit-tests/t-reftable-block.c     |  7 +++--
 t/unit-tests/t-reftable-readwrite.c | 20 +++++++-------
 t/unit-tests/t-reftable-stack.c     | 42 ++++++++++++++++-------------
 4 files changed, 50 insertions(+), 37 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 7e617c25914..d7bc1187dfb 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1387,12 +1387,18 @@ static int stack_compact_range(struct reftable_stack *st,
 	 * have just written. In case the compacted table became empty we
 	 * simply skip writing it.
 	 */
-	for (i = 0; i < first_to_replace; i++)
-		strbuf_addf(&tables_list_buf, "%s\n", names[i]);
-	if (!is_empty_table)
-		strbuf_addf(&tables_list_buf, "%s\n", new_table_name.buf);
-	for (i = last_to_replace + 1; names[i]; i++)
-		strbuf_addf(&tables_list_buf, "%s\n", names[i]);
+	for (i = 0; i < first_to_replace; i++) {
+		strbuf_addstr(&tables_list_buf, names[i]);
+		strbuf_addstr(&tables_list_buf, "\n");
+	}
+	if (!is_empty_table) {
+		strbuf_addstr(&tables_list_buf, new_table_name.buf);
+		strbuf_addstr(&tables_list_buf, "\n");
+	}
+	for (i = last_to_replace + 1; names[i]; i++) {
+		strbuf_addstr(&tables_list_buf, names[i]);
+		strbuf_addstr(&tables_list_buf, "\n");
+	}
 
 	err = write_in_full(get_lock_file_fd(&tables_list_lock),
 			    tables_list_buf.buf, tables_list_buf.len);
diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index d470060e8be..8077bbc5e7a 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -308,10 +308,13 @@ static void t_index_block_read_write(void)
 	check(!ret);
 
 	for (i = 0; i < N; i++) {
-		strbuf_init(&recs[i].u.idx.last_key, 9);
+		char buf[128];
+
+		snprintf(buf, sizeof(buf), "branch%02"PRIuMAX, (uintmax_t)i);
 
+		strbuf_init(&recs[i].u.idx.last_key, 9);
 		recs[i].type = BLOCK_TYPE_INDEX;
-		strbuf_addf(&recs[i].u.idx.last_key, "branch%02"PRIuMAX, (uintmax_t)i);
+		strbuf_addstr(&recs[i].u.idx.last_key, buf);
 		recs[i].u.idx.offset = i;
 
 		ret = block_writer_add(&bw, &recs[i]);
diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
index 27ce84445e8..5f59b0ad6ad 100644
--- a/t/unit-tests/t-reftable-readwrite.c
+++ b/t/unit-tests/t-reftable-readwrite.c
@@ -753,12 +753,13 @@ static void t_write_multiple_indices(void)
 	struct reftable_write_options opts = {
 		.block_size = 100,
 	};
-	struct strbuf writer_buf = STRBUF_INIT, buf = STRBUF_INIT;
+	struct strbuf writer_buf = STRBUF_INIT;
 	struct reftable_block_source source = { 0 };
 	struct reftable_iterator it = { 0 };
 	const struct reftable_stats *stats;
 	struct reftable_writer *writer;
 	struct reftable_reader *reader;
+	char buf[128];
 	int err, i;
 
 	writer = t_reftable_strbuf_writer(&writer_buf, &opts);
@@ -770,9 +771,8 @@ static void t_write_multiple_indices(void)
 			.value.val1 = {i},
 		};
 
-		strbuf_reset(&buf);
-		strbuf_addf(&buf, "refs/heads/%04d", i);
-		ref.refname = buf.buf,
+		snprintf(buf, sizeof(buf), "refs/heads/%04d", i);
+		ref.refname = buf;
 
 		err = reftable_writer_add_ref(writer, &ref);
 		check(!err);
@@ -788,9 +788,8 @@ static void t_write_multiple_indices(void)
 			},
 		};
 
-		strbuf_reset(&buf);
-		strbuf_addf(&buf, "refs/heads/%04d", i);
-		log.refname = buf.buf,
+		snprintf(buf, sizeof(buf), "refs/heads/%04d", i);
+		log.refname = buf;
 
 		err = reftable_writer_add_log(writer, &log);
 		check(!err);
@@ -824,7 +823,6 @@ static void t_write_multiple_indices(void)
 	reftable_writer_free(writer);
 	reftable_reader_decref(reader);
 	strbuf_release(&writer_buf);
-	strbuf_release(&buf);
 }
 
 static void t_write_multi_level_index(void)
@@ -848,10 +846,10 @@ static void t_write_multi_level_index(void)
 			.value_type = REFTABLE_REF_VAL1,
 			.value.val1 = {i},
 		};
+		char buf[128];
 
-		strbuf_reset(&buf);
-		strbuf_addf(&buf, "refs/heads/%03" PRIuMAX, (uintmax_t)i);
-		ref.refname = buf.buf,
+		snprintf(buf, sizeof(buf), "refs/heads/%03" PRIuMAX, (uintmax_t)i);
+		ref.refname = buf;
 
 		err = reftable_writer_add_ref(writer, &ref);
 		check(!err);
diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index 874095b9ee2..b56ea774312 100644
--- a/t/unit-tests/t-reftable-stack.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -105,7 +105,6 @@ static int write_test_ref(struct reftable_writer *wr, void *arg)
 static void write_n_ref_tables(struct reftable_stack *st,
 			       size_t n)
 {
-	struct strbuf buf = STRBUF_INIT;
 	int disable_auto_compact;
 	int err;
 
@@ -117,10 +116,10 @@ static void write_n_ref_tables(struct reftable_stack *st,
 			.update_index = reftable_stack_next_update_index(st),
 			.value_type = REFTABLE_REF_VAL1,
 		};
+		char buf[128];
 
-		strbuf_reset(&buf);
-		strbuf_addf(&buf, "refs/heads/branch-%04"PRIuMAX, (uintmax_t)i);
-		ref.refname = buf.buf;
+		snprintf(buf, sizeof(buf), "refs/heads/branch-%04"PRIuMAX, (uintmax_t)i);
+		ref.refname = buf;
 		t_reftable_set_hash(ref.value.val1, i, GIT_SHA1_FORMAT_ID);
 
 		err = reftable_stack_add(st, &write_test_ref, &ref);
@@ -128,7 +127,6 @@ static void write_n_ref_tables(struct reftable_stack *st,
 	}
 
 	st->opts.disable_auto_compact = disable_auto_compact;
-	strbuf_release(&buf);
 }
 
 struct write_log_arg {
@@ -434,7 +432,10 @@ static void t_reftable_stack_auto_compaction_fails_gracefully(void)
 	 * Adding a new table to the stack should not be impacted by this, even
 	 * though auto-compaction will now fail.
 	 */
-	strbuf_addf(&table_path, "%s/%s.lock", dir, st->readers[0]->name);
+	strbuf_addstr(&table_path, dir);
+	strbuf_addstr(&table_path, "/");
+	strbuf_addstr(&table_path, st->readers[0]->name);
+	strbuf_addstr(&table_path, ".lock");
 	write_file_buf(table_path.buf, "", 0);
 
 	ref.update_index = 2;
@@ -1077,8 +1078,10 @@ static void t_reftable_stack_auto_compaction_with_locked_tables(void)
 	 * size, we expect that auto-compaction will want to compact all of the
 	 * tables. Locking any of the tables will keep it from doing so.
 	 */
-	strbuf_reset(&buf);
-	strbuf_addf(&buf, "%s/%s.lock", dir, st->readers[2]->name);
+	strbuf_addstr(&buf, dir);
+	strbuf_addstr(&buf, "/");
+	strbuf_addstr(&buf, st->readers[2]->name);
+	strbuf_addstr(&buf, ".lock");
 	write_file_buf(buf.buf, "", 0);
 
 	/*
@@ -1101,7 +1104,6 @@ static void t_reftable_stack_add_performs_auto_compaction(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st = NULL;
-	struct strbuf refname = STRBUF_INIT;
 	char *dir = get_tmp_dir(__LINE__);
 	int err;
 	size_t i, n = 20;
@@ -1115,6 +1117,7 @@ static void t_reftable_stack_add_performs_auto_compaction(void)
 			.value_type = REFTABLE_REF_SYMREF,
 			.value.symref = (char *) "master",
 		};
+		char buf[128];
 
 		/*
 		 * Disable auto-compaction for all but the last runs. Like this
@@ -1123,9 +1126,8 @@ static void t_reftable_stack_add_performs_auto_compaction(void)
 		 */
 		st->opts.disable_auto_compact = i != n;
 
-		strbuf_reset(&refname);
-		strbuf_addf(&refname, "branch-%04"PRIuMAX, (uintmax_t)i);
-		ref.refname = refname.buf;
+		snprintf(buf, sizeof(buf), "branch-%04"PRIuMAX, (uintmax_t)i);
+		ref.refname = buf;
 
 		err = reftable_stack_add(st, write_test_ref, &ref);
 		check(!err);
@@ -1142,7 +1144,6 @@ static void t_reftable_stack_add_performs_auto_compaction(void)
 	}
 
 	reftable_stack_destroy(st);
-	strbuf_release(&refname);
 	clear_dir(dir);
 }
 
@@ -1163,8 +1164,10 @@ static void t_reftable_stack_compaction_with_locked_tables(void)
 	check_int(st->merged->readers_len, ==, 3);
 
 	/* Lock one of the tables that we're about to compact. */
-	strbuf_reset(&buf);
-	strbuf_addf(&buf, "%s/%s.lock", dir, st->readers[1]->name);
+	strbuf_addstr(&buf, dir);
+	strbuf_addstr(&buf, "/");
+	strbuf_addstr(&buf, st->readers[1]->name);
+	strbuf_addstr(&buf, ".lock");
 	write_file_buf(buf.buf, "", 0);
 
 	/*
@@ -1321,10 +1324,13 @@ static void t_reftable_stack_reload_with_missing_table(void)
 	 * our old readers. This should trigger a partial reload of the stack,
 	 * where we try to reuse our old readers.
 	*/
-	strbuf_addf(&content, "%s\n", st->readers[0]->name);
-	strbuf_addf(&content, "%s\n", st->readers[1]->name);
+	strbuf_addstr(&content, st->readers[0]->name);
+	strbuf_addstr(&content, "\n");
+	strbuf_addstr(&content, st->readers[1]->name);
+	strbuf_addstr(&content, "\n");
 	strbuf_addstr(&content, "garbage\n");
-	strbuf_addf(&table_path, "%s.lock", st->list_file);
+	strbuf_addstr(&table_path, st->list_file);
+	strbuf_addstr(&table_path, ".lock");
 	write_file_buf(table_path.buf, content.buf, content.len);
 	err = rename(table_path.buf, st->list_file);
 	check(!err);
-- 
2.47.0.dirty


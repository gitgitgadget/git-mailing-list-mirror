Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3A674C08
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 04:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729140862; cv=none; b=swygjdUKqV66EERgZpCZnGRjpXddr/HucwkX6y2Jfzghj1BPdhNfaXTbtCfAAwWBJzZqs4iKBT5m2WFx/E8UtKcU0/RnKNwBQ7u4NVhUVvDWXjzdyCfNA59PGfnJCUzS4mwhBhetFwx9gdFLhqSlCtfSBoZb5N/2GViDdTXzs+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729140862; c=relaxed/simple;
	bh=pnZ+8cnrtHyjXJsVHGt4zJxPPAUciETXEp6XDmF03dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8AyHM5JBeOmFXkJh9DApiE1BEZ5nJRah3hNVmTYwlNXECdHIxAi5WQDUwV4xz4M339DZ436UA8RcUV7IBcRB8lLSWhaUSvTL2cFmrh+hHZ6W/MXd3ceMwP3yJnrjNwzyOIMcb4bgJB944mtmHie/P9aDTc+GzaCWG7kiSMsgZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NCoKfF+v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=azllkzH8; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NCoKfF+v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="azllkzH8"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id B2E0D1380206;
	Thu, 17 Oct 2024 00:54:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 17 Oct 2024 00:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729140856; x=1729227256; bh=9qWytnkCCj
	hhyP1p88Jg5gSJ31mfebKrVsggkFABoss=; b=NCoKfF+v1S1ZxM2WilZY5iScGT
	HUm8hJSsgfHkACzHIDDAh06TJhq6WeaG+Mgov6YNlZ1PW6u9UsMfWiyx8LX1dmhj
	8ikQxX3j9g6wdL3xvM0DFQmKfkJsexZUl1GmtTrI7cP/DcJQtqkfvI1KfZ3QlBSN
	yn0F8BFke1oBtE4rkMLcF0m2WOPKfzDw9qFheaecZ7li+9/xs/39LBEO2rZlBbXq
	L67yb1rBINQPqKMnYaxRQ//0wzJu0fiNh5PLqXpKAn4BOqT8nMZGXnpyZKlVAMsi
	8EbtJ9HPkrkethTU5rI01zhn3iarYoEuzkLeXs9v4FchdKED/ESELnYmmbBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729140856; x=1729227256; bh=9qWytnkCCjhhyP1p88Jg5gSJ31mf
	ebKrVsggkFABoss=; b=azllkzH8vvT/djNcNTlzPjIvetoXJSD1z5ltAIvJD4TG
	ztz4mttt5oeohlnBv+g64c2v8VM5HuYd9yl14sIbVV0IqgJwtMSZSsFymLxpN8EF
	I1dxUMIpytsLM0UEVsGEgKhQ/T5WCVi/Q0Irq6zTLqzfWcdI4H2/wWSkwtIwlFav
	UNFojdNXUTSv7Rzxnvs6BMSANA2ZIIKCrTKHkR7tISs33KyO3JAXRA8nUYHR1XQb
	QdP6+s0Qy89wgAanvXqfWLL9/RLwSJPy8HD/NHzjnFufuho5G75YUBAHKWwfINda
	HhDNH8Ov/wJUA4s7EHzDrJjO33ofun3qiPKJH4xurw==
X-ME-Sender: <xms:eJgQZ_CuBbUyemeYdC3KIA2tNVXGzQjspGca_dClY-v1dGXNCyytWA>
    <xme:eJgQZ1g4zdv7iNELjhL2PRGwlHONnm0KCcaVQeQlf7PzEhWtI01ik0X7tCcNcl9V3
    KZRI1Ob5LgLF2ywmQ>
X-ME-Received: <xmr:eJgQZ6llgC8ncMy98lsXF5ZgyEzx4f53hLuEVWqwWbGZfyXwUjgkKpVKcleUF8pt1jpytX5kKiiDNOUVQ8VedHjo3ccG60AgyJsj8UweVRskXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehtddgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrh
    guthhhohhmshhonhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:eJgQZxyLsB9N3BVcoaHpSUhg4_pPV3ZofNQCbQYMVOc1GQzgElCYuA>
    <xmx:eJgQZ0QnOt2EiTJxqZmrvQSr3vt8ocipOGBzuKYh1IXEKB1Jw1jVHw>
    <xmx:eJgQZ0ZsoBydMv4gOMP6j2-8JGt9EHyHjaNfs7g6BeIOjNQ0sHIMBQ>
    <xmx:eJgQZ1SPukjbYkzq0ZOX2p6eO5ByTioIqLhrj6Qc3f6upKBzfrqT1w>
    <xmx:eJgQZ5LRiAnuNSHqT2F6MbNj67lTuRZ3J21mIiEQPFBInJVZEx87y7YZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Oct 2024 00:54:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 90d901c8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 17 Oct 2024 04:52:56 +0000 (UTC)
Date: Thu, 17 Oct 2024 06:54:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	karthik nayak <karthik.188@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, shejialuo <shejialuo@gmail.com>
Subject: [PATCH v3 09/10] reftable/stack: adapt `stack_filename()` to handle
 allocation failures
Message-ID: <245a428842a9ef4dfe3d8a9d5b566876ee359cf7.1729140565.git.ps@pks.im>
References: <cover.1728629612.git.ps@pks.im>
 <cover.1729140565.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729140565.git.ps@pks.im>

The `stack_filename()` function cannot pass any errors to the caller as it
has a `void` return type. Adapt it and its callers such that we can
handle errors and start handling allocation failures.

There are two interesting edge cases in `reftable_stack_destroy()` and
`reftable_addition_close()`. Both of these are trying to tear down their
respective structures, and while doing so they try to unlink some of the
tables they have been keeping alive. Any earlier attempts to do that may
fail on Windows because it keeps us from deleting such tables while they
are still open, and thus we re-try on close. It's okay and even expected
that this can fail when the tables are still open by another process, so
we handle the allocation failures gracefully and just skip over any file
whose name we couldn't figure out.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 62 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 17 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index e94eb3c4685..243b10715cc 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -31,13 +31,16 @@ static void reftable_addition_close(struct reftable_addition *add);
 static int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
 					     int reuse_open);
 
-static void stack_filename(struct reftable_buf *dest, struct reftable_stack *st,
-			   const char *name)
+static int stack_filename(struct reftable_buf *dest, struct reftable_stack *st,
+			  const char *name)
 {
+	int err;
 	reftable_buf_reset(dest);
-	reftable_buf_addstr(dest, st->reftable_dir);
-	reftable_buf_addstr(dest, "/");
-	reftable_buf_addstr(dest, name);
+	if ((err = reftable_buf_addstr(dest, st->reftable_dir)) < 0 ||
+	    (err = reftable_buf_addstr(dest, "/")) < 0 ||
+	    (err = reftable_buf_addstr(dest, name)) < 0)
+		return err;
+	return 0;
 }
 
 static ssize_t reftable_fd_write(void *arg, const void *data, size_t sz)
@@ -211,13 +214,16 @@ void reftable_stack_destroy(struct reftable_stack *st)
 		struct reftable_buf filename = REFTABLE_BUF_INIT;
 		for (i = 0; i < st->readers_len; i++) {
 			const char *name = reader_name(st->readers[i]);
+			int try_unlinking = 1;
+
 			reftable_buf_reset(&filename);
 			if (names && !has_name(names, name)) {
-				stack_filename(&filename, st, name);
+				if (stack_filename(&filename, st, name) < 0)
+					try_unlinking = 0;
 			}
 			reftable_reader_decref(st->readers[i]);
 
-			if (filename.len) {
+			if (try_unlinking && filename.len) {
 				/* On Windows, can only unlink after closing. */
 				unlink(filename.buf);
 			}
@@ -310,7 +316,10 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 
 		if (!rd) {
 			struct reftable_block_source src = { NULL };
-			stack_filename(&table_path, st, name);
+
+			err = stack_filename(&table_path, st, name);
+			if (err < 0)
+				goto done;
 
 			err = reftable_block_source_from_file(&src,
 							      table_path.buf);
@@ -341,7 +350,11 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 	for (i = 0; i < cur_len; i++) {
 		if (cur[i]) {
 			const char *name = reader_name(cur[i]);
-			stack_filename(&table_path, st, name);
+
+			err = stack_filename(&table_path, st, name);
+			if (err < 0)
+				goto done;
+
 			reftable_reader_decref(cur[i]);
 			unlink(table_path.buf);
 		}
@@ -700,8 +713,8 @@ static void reftable_addition_close(struct reftable_addition *add)
 	size_t i;
 
 	for (i = 0; i < add->new_tables_len; i++) {
-		stack_filename(&nm, add->stack, add->new_tables[i]);
-		unlink(nm.buf);
+		if (!stack_filename(&nm, add->stack, add->new_tables[i]))
+			unlink(nm.buf);
 		reftable_free(add->new_tables[i]);
 		add->new_tables[i] = NULL;
 	}
@@ -851,7 +864,9 @@ int reftable_addition_add(struct reftable_addition *add,
 	if (err < 0)
 		goto done;
 
-	stack_filename(&temp_tab_file_name, add->stack, next_name.buf);
+	err = stack_filename(&temp_tab_file_name, add->stack, next_name.buf);
+	if (err < 0)
+		goto done;
 	reftable_buf_addstr(&temp_tab_file_name, ".temp.XXXXXX");
 
 	tab_file = mks_tempfile(temp_tab_file_name.buf);
@@ -900,7 +915,10 @@ int reftable_addition_add(struct reftable_addition *add,
 	if (err < 0)
 		goto done;
 	reftable_buf_addstr(&next_name, ".ref");
-	stack_filename(&tab_file_name, add->stack, next_name.buf);
+
+	err = stack_filename(&tab_file_name, add->stack, next_name.buf);
+	if (err < 0)
+		goto done;
 
 	/*
 	  On windows, this relies on rand() picking a unique destination name.
@@ -954,7 +972,9 @@ static int stack_compact_locked(struct reftable_stack *st,
 	if (err < 0)
 		goto done;
 
-	stack_filename(&tab_file_path, st, next_name.buf);
+	err = stack_filename(&tab_file_path, st, next_name.buf);
+	if (err < 0)
+		goto done;
 	reftable_buf_addstr(&tab_file_path, ".temp.XXXXXX");
 
 	tab_file = mks_tempfile(tab_file_path.buf);
@@ -1174,7 +1194,9 @@ static int stack_compact_range(struct reftable_stack *st,
 	}
 
 	for (i = last + 1; i > first; i--) {
-		stack_filename(&table_name, st, reader_name(st->readers[i - 1]));
+		err = stack_filename(&table_name, st, reader_name(st->readers[i - 1]));
+		if (err < 0)
+			goto done;
 
 		err = hold_lock_file_for_update(&table_locks[nlocks],
 						table_name.buf, LOCK_NO_DEREF);
@@ -1383,7 +1405,10 @@ static int stack_compact_range(struct reftable_stack *st,
 			goto done;
 
 		reftable_buf_addstr(&new_table_name, ".ref");
-		stack_filename(&new_table_path, st, new_table_name.buf);
+
+		err = stack_filename(&new_table_path, st, new_table_name.buf);
+		if (err < 0)
+			goto done;
 
 		err = rename_tempfile(&new_table, new_table_path.buf);
 		if (err < 0) {
@@ -1677,7 +1702,10 @@ static void remove_maybe_stale_table(struct reftable_stack *st, uint64_t max,
 	struct reftable_block_source src = { NULL };
 	struct reftable_reader *rd = NULL;
 	struct reftable_buf table_path = REFTABLE_BUF_INIT;
-	stack_filename(&table_path, st, name);
+
+	err = stack_filename(&table_path, st, name);
+	if (err < 0)
+		goto done;
 
 	err = reftable_block_source_from_file(&src, table_path.buf);
 	if (err < 0)
-- 
2.47.0.72.gef8ce8f3d4.dirty


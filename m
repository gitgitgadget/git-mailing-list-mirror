Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FC21AB501
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910969; cv=none; b=nff3f7aElJNRvUPD3yw/AyZAE6z5o9sDpuVd8y/I8Syqv8R/pPo1puznRAqB+Ixjw4DlS6GoUKpwpfQXWqx9kRUcmaOJ+Rb588fB/7rLI5/nJn+QCGu2oLtAuRMBofKTOOqeIwzOoKoLF7CVMzJreEy3PCCas0U0ZQOOzcRiDJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910969; c=relaxed/simple;
	bh=eD0SdRSlxB/ekNDPTqk6jXUkJfPMTNG3B2B6ojIMEYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRddjhv8sFP+fLPCntPadVQ0G2BXjznnLfuC7uUvdQtOLLipN6bj0pJomrpHk7LvdJ2VKU2n3wABGABYC/gW6Lp2ILKWby6JQkPUOvcn8pIts1OqBfCPAG5MkFRiQfaixrUob4BhfD1FxofAhjFvTMTAkAAGFAXMdx5V+ZD5eoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h+zSei/N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WPffhVqB; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h+zSei/N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WPffhVqB"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 534F61380131;
	Mon, 14 Oct 2024 09:02:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 14 Oct 2024 09:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728910966; x=1728997366; bh=JBs3UMOeQD
	uZXlbtDE4gDPAf7LItAqFIgeLmC4iOIBk=; b=h+zSei/Nf6DRNYyhDBQp23P47G
	XASIttNPJ8xL5S5+1QXm893AoCCy4Jbp2OmBOylBQOB+YXik59EGl4e3uEp7A7+d
	hyPrv3cJUfeCHLC2WY8yQFBNzFXP8ww0TJZKuO69Nvc6HaNYE7du6pdTm6lNfJDz
	fAgZjj4FovKMifzJOze1rlm0096NTWH4HqGMiBjPpvv7rOBlCuMTJjb4vNanM9Vk
	1ILbgUn21A6ECRmw0+MzJul/1GZoof1y1lEBbxCWIBwi+y+43Rq7RuZOh4eNB6/R
	17sCQlhowYddX5bwmBVldNuwlpcO/UjiQwQkchk4Y35CIjZvevcK+bKhVQsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728910966; x=1728997366; bh=JBs3UMOeQDuZXlbtDE4gDPAf7LIt
	AqFIgeLmC4iOIBk=; b=WPffhVqBbI3TE8a9oNjxjB3/My9R0D8St2CMvB7axrwJ
	C3Q0tDGTwAPKCucBwIJt96LtLVFoiEhtCHENHSqnO+v/ZKNGLkmEhdaq7fO1a/oI
	+gx77+dh0j35eqG9M8waQJSh4ooVjo0qQbgHJheIkJ3pjaEysJ1mYmbiAQqC/Wvo
	oFZjihbEfN63pkOwJMGbWVDF+L2Yfn3v03kqUz1PmU146aBAP7z80w0+AhL8JSwO
	fTNHULuUyt1tdhwEpbzoLz0n2PPMvwzkIJg7fKbX+RzktO7WNBVYvHYzIdpQbWNc
	wX79bkrCu9w+wKhnBxtpryCLiloCmAtCEd5LgH9B8Q==
X-ME-Sender: <xms:dhYNZ1Sypi9iUIo7dBGXN-xI5fv29Hr3EWM1uk3J8oGpHcKpLBnh5w>
    <xme:dhYNZ-yBl5MV73PwHQVUd0DzDo1nRuzv6UGYu82Uuj7aPKt1PwqGjh6cLS0r977Ze
    8rWEFfRthbn2lJo8g>
X-ME-Received: <xmr:dhYNZ62xLFukzgljCBAklLm7fGgN_CeZ30gX1WYbwx8Qaw-7hbTYiqM4cLrCn2pVWVhzLqkUADwcCWP8C4xNSikitrnTVitU9xK74spoq8oysQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:dhYNZ9CACBDjBwheeGhn_pP2DW3h4hb-V4PH9kJcy-gRQfMSAxH1nQ>
    <xmx:dhYNZ-h8XdNFIybaiYqlKCKfkRxkFkO0iX2dLVI-bj_ICRIA2L3PJQ>
    <xmx:dhYNZxo7zdPxD5heSraSN3yaVlqwPKlVD_DF4rHNyaerZ67dak1uwA>
    <xmx:dhYNZ5gXEQyTQa-Etq0LiC44Re8XufZ4S1z9ls9byefZubMKlbmb8g>
    <xmx:dhYNZ_splFsrWgcWMExwoKIGjb9XPo_WS0mDyaJSD5RpBYvDpHukGzxS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 09:02:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8e8a9722 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Oct 2024 13:01:31 +0000 (UTC)
Date: Mon, 14 Oct 2024 15:02:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v2 09/10] reftable/stack: adapt `stack_filename()` to handle
 allocation failures
Message-ID: <a9582d51dd1dc0a650f594de81e992a244f311a9.1728910727.git.ps@pks.im>
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
2.47.0.dirty


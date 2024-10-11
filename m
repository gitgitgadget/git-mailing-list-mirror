Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8145220A5F2
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 06:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728629680; cv=none; b=fO0FsLAQDRhMjhpt+TrKcoUb3a/purV4QKGbQozdy4Bp3LHnTi9jk1qSSwViFwcS2NsQ+lnYLJ8uCsZhV6OrhPyyuOrudUdI4Jj8UFW9Cr9cM2x52+lmc+nb37PS2gWgHlY4EeaMuvGTOzF03/vv0VlH/egzLJhYEHzW2sf5Cks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728629680; c=relaxed/simple;
	bh=eD0SdRSlxB/ekNDPTqk6jXUkJfPMTNG3B2B6ojIMEYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OL8daSXGOnrNtPZ9GQVIC8wutROOXnbrfs7Q0dtZ4rn6rx7QPzfSkKlgk0g5ABfCCliZUS4T/gFNxDj0OztuAJI1SbHTHNgIxY2znpiWKwBwF+ua2FWgLg5Ei60kL8FVTTzoa0zg2jmCTDwK5aEmjqP2jpMhhw3xWjUZCef2Lnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gKE+Fobm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kgBRFrT/; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gKE+Fobm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kgBRFrT/"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id C569B1380215;
	Fri, 11 Oct 2024 02:54:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 11 Oct 2024 02:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728629677; x=1728716077; bh=JBs3UMOeQD
	uZXlbtDE4gDPAf7LItAqFIgeLmC4iOIBk=; b=gKE+FobmMB43xCmelyKhPrCPaA
	HJ/yaqqKhUuAST2aX4oUev9keE3v9NUSxUoV/sd9bTGQgk4ldWZVsTb6JVao/K6f
	DPIQILAmK/HJBWiU3EXlMCB6oUEF0a4qxDG6n/zGQEzDS70D4AdPg7erPn41uLb6
	g3I5VROTbNJJy7WcqV/WDzJZSwbqaDTfv5zHfconl7KEt2nM1FBuwpc47RpkaGhH
	W6Fw9lkkPReEHp7ekME1x8eY4LXLkxf5aqcj7drfnXwCVDliYKKkqfDd01fwf4Da
	reR0wdhrpWhw8gZ8t9xCk6ahq+8wkFw/uWSYee5/SPlizwQvfg0X6QZLTXbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728629677; x=1728716077; bh=JBs3UMOeQDuZXlbtDE4gDPAf7LIt
	AqFIgeLmC4iOIBk=; b=kgBRFrT/Py7WPqPwhAKQ/PmmY0yf8APaTg9dxjpdimKX
	F/kwSZGMm17n/wv8buIVidGtEeZhftlDnoAWbQcZT0wU4d5WbkCbhQAbcslXv4Bb
	0WZ8XI6xuFPXqdeANdJD1I2P/PDoiX2CaQ0lHsRRbZOhsH3AzqwwGnBw2AfXyis1
	P+UiOuJPBgTtSrYJo7g397smY7xx6aTkB3eyKKK6//veHza4/43f02jI2KtSQi3R
	+5E+iaZpdM8Znj8Y4YwnUhCHdL59g2I2FX0pf6Pb/WK7mnHAiFB6/LDenUy0okFW
	Si/3d5k6+GEHena1jTNy3Zq4Ih+dB4HBhzK2EUrDkg==
X-ME-Sender: <xms:rcsIZ0IoKYLPtAJYg_3Dn-GkLy2--ppy9vLJeX1NXZTh61ZRXVHlug>
    <xme:rcsIZ0KMfwZO4W1e9jbBFqHUXf1bpfEOV0fufAU6ne6fhVy0SWiFp4_7-kZI7_f73
    CZBUab8N9YaUoeWPg>
X-ME-Received: <xmr:rcsIZ0tcitzbLfd6aCcLUx6OygmQAkJe3EobDr4_5LwZovEp6zCbThBya5dHrOm5jHz0bAYUtzD2EX8Bo4Fc9o6boFFZRrKEbtiul6yzDVTxHh8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmsh
    honhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:rcsIZxYa3JniP_GF6vwFjKTOIovKhJGxuEuJUlHuTyYpard5tv7Zxw>
    <xmx:rcsIZ7ajsp62yZGw8z81KiZnu4PxXqQyufp0_lWOYdzdQTrmmorGHA>
    <xmx:rcsIZ9DU01F5Xntkjk82n6IFvr2Ob_S09I94CTmHBCdDDM9ooH_HGg>
    <xmx:rcsIZxYOwipcdFiUtPohFdVrp-FL1M8wAoZXccUidv3wgaXGZOdOHA>
    <xmx:rcsIZ6kxztg-ZyDVz6VDzphGTQFsqyvBzoGXkj_a1IhpwUpbs-kmPXTs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 02:54:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cc9b0aa8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Oct 2024 06:53:30 +0000 (UTC)
Date: Fri, 11 Oct 2024 08:54:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 09/10] reftable/stack: adapt `stack_filename()` to handle
 allocation failures
Message-ID: <d66d9e50e06ae6e16a4092667c561dccdbabfa08.1728629612.git.ps@pks.im>
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


Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE812209671
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 06:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728629673; cv=none; b=cEZ4PGs9G0KIfECVhs4C6sCsJWam2ad3RNa8aX+ynBCNrDwJN4fEShD3ZcmaLjHjcSVJbgSTUmAnLAE6bcLKvd9ddDE4JuVJedI/98dca7aSjbw58giqJ2EM7Y5WMBN4wQMGy/KiEJDsYuks3tY6tXCDICOoBj6ErulnmJ8ZXLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728629673; c=relaxed/simple;
	bh=Tk0oMZrq4CRE/ub7qX9V8oNGnZIbRZMx8SfDFtiixA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUe0u69DZH1PxzHmrUKSFanzJ+VdBivwCWQvc/ASQXgkbaDx6yMEv1KY6stX60HD4Gz+HLSfL30uY3+uYQBDIHrJKk7vAe7LKtz7RG8yEvQ/nVIezc0wtLp8tgV4EKfm9oo3LrojUkA1qmWrdoRqtgc/JZgg9RuL2+qN8LKYwDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PRpcGhdx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LJybQxom; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PRpcGhdx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LJybQxom"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A421B1140126;
	Fri, 11 Oct 2024 02:54:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 11 Oct 2024 02:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728629669; x=1728716069; bh=scPwH1WlF5
	aRQ4d89oiaN7TBm6/NF1xSMsbZ4zNKfBw=; b=PRpcGhdxOwQX9FGlziuCd5gd+T
	R1nqeU9XIQXlSoVVe2zkV09EF5ZCJ6ALs0WvTigk+a8bduS9zqqG8d3VeE9YbkAY
	tfzfQrPqAONT8ilyromPSH36qVoIanM7zXLjqjc4j7qz2llBrYYxwXGpZlmXcPv3
	msCO97TYkt6gBW6vxXFkYaNIYA+9pYZKmJI5r4F3ldf5Lxu0mvN3NM0Wq7gtHgp8
	NgICVZzBeMGK/eM+Cm8UgbX1FPLaMQpsGBzcm4+fdPhqN07agkg0AmaHGy3YXbLA
	rMJHpfd0ScBG4EKY2Ku4xcBXb4atEQkdUmkNECf4jxP425RbuQFMqwQyQsBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728629669; x=1728716069; bh=scPwH1WlF5aRQ4d89oiaN7TBm6/N
	F1xSMsbZ4zNKfBw=; b=LJybQxomNAW9ziAJS++s2G61KvjKI9OwCiTQK3JM+uxH
	nCVrr4mZf3SK/piyfftoLGiSRpEY+wrvWOFvlOB2DW0IrGKqmWhFIAgbco9JII8g
	CJCpYtSx2yxZbAFPzi2NEJRgyuqDkRPZiT1/akWPf6v6EQR6LV+S0zu91a9eOPJm
	2Knam3NKjRmX7tqHI6bP8FUc0Odsj6sCJs25dtqjdcHHYmsj8Pm0fuE0X4KzkDGi
	FfdkqmjhRT6htfssTF0o+Ou+fVsR4inYzY2g/IgbJBf+u+rbOCc5D5rhvP6mmBoN
	7Ed1aikxex/fAVfcIxVkv/d68bLIAC6AobDQ2BOa1Q==
X-ME-Sender: <xms:pcsIZz1929Z-m9Plv7KA5nVfp7KXRC_b9F2P4yo5ERfi_uk1G2sGXQ>
    <xme:pcsIZyE9K1AAUKIvaulHtnr9Q37DkGdgyZHBLW9tWPmMufYTCMmWUkR-W5i-73bIo
    fHsJ6Q8AFuFjNrmjA>
X-ME-Received: <xmr:pcsIZz4FIes5KumErxXZwEU0vFLlek6Re63HuLyt0OtM97lD5UAbKpm3G_XaVc5tL2Mlctn_cMuwwZrTIPcl7xt5lUa95_ZgM2kkXCd1bVRYFiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmsh
    honhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:pcsIZ41b0KV2KEkArqCL7_zD9YN5FooUk_cFJyfkPNgefyEk0HdIvg>
    <xmx:pcsIZ2FtN7Q7KwYznnTy7x7uOY6PK521o4XkMLIM6IHSjotp669BsQ>
    <xmx:pcsIZ59UMfzlV8SEMtDrolQlxMHwed3dMaasLRjcq9eZtGOzAjtCEg>
    <xmx:pcsIZzlzOQqwEq1z41Lb0oX6W7ux0ugPpbKWmj_19NXW9v7NWmbNhQ>
    <xmx:pcsIZ7Rl5HJLP79Us9m-zMpxF0Ki45CacEuADpcSLaPnkZtrGgjAU9gk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 02:54:28 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8f4cd0a8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Oct 2024 06:53:22 +0000 (UTC)
Date: Fri, 11 Oct 2024 08:54:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 06/10] t/unit-tests: check for `reftable_buf` allocation
 errors
Message-ID: <797e435ed2e2e6e074e960714de6b5eee2b53340.1728629612.git.ps@pks.im>
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

Adapt our unit tests to check for allocations errors.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/unit-tests/t-reftable-basics.c    |  4 +-
 t/unit-tests/t-reftable-block.c     |  4 +-
 t/unit-tests/t-reftable-readwrite.c |  8 ++--
 t/unit-tests/t-reftable-record.c    | 14 +++----
 t/unit-tests/t-reftable-stack.c     | 58 ++++++++++++++---------------
 5 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/t/unit-tests/t-reftable-basics.c b/t/unit-tests/t-reftable-basics.c
index a814e819756..a329f552025 100644
--- a/t/unit-tests/t-reftable-basics.c
+++ b/t/unit-tests/t-reftable-basics.c
@@ -113,8 +113,8 @@ int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
 		};
 
 		for (size_t i = 0; i < ARRAY_SIZE(cases); i++) {
-			reftable_buf_addstr(&a, cases[i].a);
-			reftable_buf_addstr(&b, cases[i].b);
+			check(!reftable_buf_addstr(&a, cases[i].a));
+			check(!reftable_buf_addstr(&b, cases[i].b));
 			check_int(common_prefix_size(&a, &b), ==, cases[i].want);
 			reftable_buf_reset(&a);
 			reftable_buf_reset(&b);
diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index df1d45fe8e4..f9af907117b 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -167,7 +167,7 @@ static void t_log_block_read_write(void)
 	for (i = 0; i < N; i++) {
 		block_iter_reset(&it);
 		reftable_buf_reset(&want);
-		reftable_buf_addstr(&want, recs[i].u.log.refname);
+		check(!reftable_buf_addstr(&want, recs[i].u.log.refname));
 
 		ret = block_iter_seek_key(&it, &br, &want);
 		check_int(ret, ==, 0);
@@ -314,7 +314,7 @@ static void t_index_block_read_write(void)
 
 		reftable_buf_init(&recs[i].u.idx.last_key);
 		recs[i].type = BLOCK_TYPE_INDEX;
-		reftable_buf_addstr(&recs[i].u.idx.last_key, buf);
+		check(!reftable_buf_addstr(&recs[i].u.idx.last_key, buf));
 		recs[i].u.idx.offset = i;
 
 		ret = block_writer_add(&bw, &recs[i]);
diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
index 7c7c72bb162..d279b86df0a 100644
--- a/t/unit-tests/t-reftable-readwrite.c
+++ b/t/unit-tests/t-reftable-readwrite.c
@@ -23,7 +23,7 @@ static void t_buffer(void)
 	struct reftable_block out = { 0 };
 	int n;
 	uint8_t in[] = "hello";
-	reftable_buf_add(&buf, in, sizeof(in));
+	check(!reftable_buf_add(&buf, in, sizeof(in)));
 	block_source_from_buf(&source, &buf);
 	check_int(block_source_size(&source), ==, 6);
 	n = block_source_read_block(&source, &out, 0, sizeof(in));
@@ -443,8 +443,8 @@ static void t_table_read_write_seek(int index, int hash_id)
 		reftable_iterator_destroy(&it);
 	}
 
-	reftable_buf_addstr(&pastLast, names[N - 1]);
-	reftable_buf_addstr(&pastLast, "/");
+	check(!reftable_buf_addstr(&pastLast, names[N - 1]));
+	check(!reftable_buf_addstr(&pastLast, "/"));
 
 	err = reftable_reader_init_ref_iterator(reader, &it);
 	check(!err);
@@ -901,7 +901,7 @@ static void t_corrupt_table(void)
 	struct reftable_block_source source = { 0 };
 	struct reftable_reader *reader;
 	int err;
-	reftable_buf_add(&buf, zeros, sizeof(zeros));
+	check(!reftable_buf_add(&buf, zeros, sizeof(zeros)));
 
 	block_source_from_buf(&source, &buf);
 	err = reftable_reader_new(&reader, &source, "file.log");
diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index f2dd01688f3..eb98bf2da91 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -335,14 +335,14 @@ static void t_key_roundtrip(void)
 	int n, m;
 	uint8_t rt_extra;
 
-	reftable_buf_addstr(&last_key, "refs/heads/master");
-	reftable_buf_addstr(&key, "refs/tags/bla");
+	check(!reftable_buf_addstr(&last_key, "refs/heads/master"));
+	check(!reftable_buf_addstr(&key, "refs/tags/bla"));
 	extra = 6;
 	n = reftable_encode_key(&restart, dest, last_key, key, extra);
 	check(!restart);
 	check_int(n, >, 0);
 
-	reftable_buf_addstr(&roundtrip, "refs/heads/master");
+	check(!reftable_buf_addstr(&roundtrip, "refs/heads/master"));
 	m = reftable_decode_key(&roundtrip, &rt_extra, dest);
 	check_int(n, ==, m);
 	check(!reftable_buf_cmp(&key, &roundtrip));
@@ -469,9 +469,9 @@ static void t_reftable_index_record_comparison(void)
 			.u.idx.last_key = REFTABLE_BUF_INIT,
 		},
 	};
-	reftable_buf_addstr(&in[0].u.idx.last_key, "refs/heads/master");
-	reftable_buf_addstr(&in[1].u.idx.last_key, "refs/heads/master");
-	reftable_buf_addstr(&in[2].u.idx.last_key, "refs/heads/branch");
+	check(!reftable_buf_addstr(&in[0].u.idx.last_key, "refs/heads/master"));
+	check(!reftable_buf_addstr(&in[1].u.idx.last_key, "refs/heads/master"));
+	check(!reftable_buf_addstr(&in[2].u.idx.last_key, "refs/heads/branch"));
 
 	check(!reftable_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
 	check(!reftable_record_cmp(&in[0], &in[1]));
@@ -510,7 +510,7 @@ static void t_reftable_index_record_roundtrip(void)
 	int n, m;
 	uint8_t extra;
 
-	reftable_buf_addstr(&in.u.idx.last_key, "refs/heads/master");
+	check(!reftable_buf_addstr(&in.u.idx.last_key, "refs/heads/master"));
 	reftable_record_key(&in, &key);
 	t_copy(&in);
 
diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index f49856270d6..72f6747064f 100644
--- a/t/unit-tests/t-reftable-stack.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -172,17 +172,17 @@ static void t_reftable_stack_add_one(void)
 	check_int(st->readers_len, >, 0);
 
 #ifndef GIT_WINDOWS_NATIVE
-	reftable_buf_addstr(&scratch, dir);
-	reftable_buf_addstr(&scratch, "/tables.list");
+	check(!reftable_buf_addstr(&scratch, dir));
+	check(!reftable_buf_addstr(&scratch, "/tables.list"));
 	err = stat(scratch.buf, &stat_result);
 	check(!err);
 	check_int((stat_result.st_mode & 0777), ==, opts.default_permissions);
 
 	reftable_buf_reset(&scratch);
-	reftable_buf_addstr(&scratch, dir);
-	reftable_buf_addstr(&scratch, "/");
+	check(!reftable_buf_addstr(&scratch, dir));
+	check(!reftable_buf_addstr(&scratch, "/"));
 	/* do not try at home; not an external API for reftable. */
-	reftable_buf_addstr(&scratch, st->readers[0]->name);
+	check(!reftable_buf_addstr(&scratch, st->readers[0]->name));
 	err = stat(scratch.buf, &stat_result);
 	check(!err);
 	check_int((stat_result.st_mode & 0777), ==, opts.default_permissions);
@@ -432,10 +432,10 @@ static void t_reftable_stack_auto_compaction_fails_gracefully(void)
 	 * Adding a new table to the stack should not be impacted by this, even
 	 * though auto-compaction will now fail.
 	 */
-	reftable_buf_addstr(&table_path, dir);
-	reftable_buf_addstr(&table_path, "/");
-	reftable_buf_addstr(&table_path, st->readers[0]->name);
-	reftable_buf_addstr(&table_path, ".lock");
+	check(!reftable_buf_addstr(&table_path, dir));
+	check(!reftable_buf_addstr(&table_path, "/"));
+	check(!reftable_buf_addstr(&table_path, st->readers[0]->name));
+	check(!reftable_buf_addstr(&table_path, ".lock"));
 	write_file_buf(table_path.buf, "", 0);
 
 	ref.update_index = 2;
@@ -575,17 +575,17 @@ static void t_reftable_stack_add(void)
 	}
 
 #ifndef GIT_WINDOWS_NATIVE
-	reftable_buf_addstr(&path, dir);
-	reftable_buf_addstr(&path, "/tables.list");
+	check(!reftable_buf_addstr(&path, dir));
+	check(!reftable_buf_addstr(&path, "/tables.list"));
 	err = stat(path.buf, &stat_result);
 	check(!err);
 	check_int((stat_result.st_mode & 0777), ==, opts.default_permissions);
 
 	reftable_buf_reset(&path);
-	reftable_buf_addstr(&path, dir);
-	reftable_buf_addstr(&path, "/");
+	check(!reftable_buf_addstr(&path, dir));
+	check(!reftable_buf_addstr(&path, "/"));
 	/* do not try at home; not an external API for reftable. */
-	reftable_buf_addstr(&path, st->readers[0]->name);
+	check(!reftable_buf_addstr(&path, st->readers[0]->name));
 	err = stat(path.buf, &stat_result);
 	check(!err);
 	check_int((stat_result.st_mode & 0777), ==, opts.default_permissions);
@@ -1078,10 +1078,10 @@ static void t_reftable_stack_auto_compaction_with_locked_tables(void)
 	 * size, we expect that auto-compaction will want to compact all of the
 	 * tables. Locking any of the tables will keep it from doing so.
 	 */
-	reftable_buf_addstr(&buf, dir);
-	reftable_buf_addstr(&buf, "/");
-	reftable_buf_addstr(&buf, st->readers[2]->name);
-	reftable_buf_addstr(&buf, ".lock");
+	check(!reftable_buf_addstr(&buf, dir));
+	check(!reftable_buf_addstr(&buf, "/"));
+	check(!reftable_buf_addstr(&buf, st->readers[2]->name));
+	check(!reftable_buf_addstr(&buf, ".lock"));
 	write_file_buf(buf.buf, "", 0);
 
 	/*
@@ -1164,10 +1164,10 @@ static void t_reftable_stack_compaction_with_locked_tables(void)
 	check_int(st->merged->readers_len, ==, 3);
 
 	/* Lock one of the tables that we're about to compact. */
-	reftable_buf_addstr(&buf, dir);
-	reftable_buf_addstr(&buf, "/");
-	reftable_buf_addstr(&buf, st->readers[1]->name);
-	reftable_buf_addstr(&buf, ".lock");
+	check(!reftable_buf_addstr(&buf, dir));
+	check(!reftable_buf_addstr(&buf, "/"));
+	check(!reftable_buf_addstr(&buf, st->readers[1]->name));
+	check(!reftable_buf_addstr(&buf, ".lock"));
 	write_file_buf(buf.buf, "", 0);
 
 	/*
@@ -1324,13 +1324,13 @@ static void t_reftable_stack_reload_with_missing_table(void)
 	 * our old readers. This should trigger a partial reload of the stack,
 	 * where we try to reuse our old readers.
 	*/
-	reftable_buf_addstr(&content, st->readers[0]->name);
-	reftable_buf_addstr(&content, "\n");
-	reftable_buf_addstr(&content, st->readers[1]->name);
-	reftable_buf_addstr(&content, "\n");
-	reftable_buf_addstr(&content, "garbage\n");
-	reftable_buf_addstr(&table_path, st->list_file);
-	reftable_buf_addstr(&table_path, ".lock");
+	check(!reftable_buf_addstr(&content, st->readers[0]->name));
+	check(!reftable_buf_addstr(&content, "\n"));
+	check(!reftable_buf_addstr(&content, st->readers[1]->name));
+	check(!reftable_buf_addstr(&content, "\n"));
+	check(!reftable_buf_addstr(&content, "garbage\n"));
+	check(!reftable_buf_addstr(&table_path, st->list_file));
+	check(!reftable_buf_addstr(&table_path, ".lock"));
 	write_file_buf(table_path.buf, content.buf, content.len);
 	err = rename(table_path.buf, st->list_file);
 	check(!err);
-- 
2.47.0.dirty


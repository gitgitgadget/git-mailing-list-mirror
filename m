Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CC6155A24
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 04:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729140848; cv=none; b=sk76byVQqVoC+a45Pv8PVau2WIpe17xwR9XAJsB9Nv+kJns6KRQGxPbTYDLgbjF75mUvrtTWMpJ2oVDFWQf1CtJRCufMneIV2pwGX3fbX+on4gGrZZSNgRNKpC+3se/ebUPiVV3cpBagEp9S6S7/6KKmIlSScI6Dy/YTe4JOKHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729140848; c=relaxed/simple;
	bh=vfN2VtaYz0lW56996VGQWRlyfPE3s6m1W/MVZPnYRJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5NSAIrQm/Tb97Ty0A+L4PspbvWNbCYiRCyBjTvSbCMXoeg2/uVbzPZXw2TcdOkZCUUV03h5awvKR+pjNDVI7sB2O9nq4L0Hor2s81uUBZUFZef7ILi2wlvDHowgbx4VcJ41K+mZvaLjJZXIqps4ZDi7gmGA9R/ccOe78dHqwuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UKHwakgp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nkYlJ0yN; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UKHwakgp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nkYlJ0yN"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 02DEE11400A6;
	Thu, 17 Oct 2024 00:54:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 17 Oct 2024 00:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729140844; x=1729227244; bh=lQjLp3+p4V
	ol//0QRuiWPzfWGV9Mj+5vKYylTgIj+zY=; b=UKHwakgpf9jrINFUzC/z/zXHSr
	wBPhh8qy/7ksoVWdzqUXBX5CPP0/lgH5MMC7Av3YVJlnmnkn6csoC0O5SHX1LNnH
	mqNC2ZurCy7WBWGebRfGIaBXi+Wb66IKwPpQnNckVUARUovcMP8TKtsQGqP5Ge15
	5uYYJ5sgvNgF7D6x+BCgnod1hqySbpX/OeqTE+0xKkkRPog8+dqtTTNZ8OF/1TSR
	MlYSlKEQm+xcowvj3ZpFX/u4euj3DsO9GsBcNgOWTNLCbtmgqUC2PU7Q/M8qE972
	Vdh32yVcHwbtX/PkgbJnGc4zrZroKMSr+kL7gipyrp8NLC6E2hhsAA11+2WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729140844; x=1729227244; bh=lQjLp3+p4Vol//0QRuiWPzfWGV9M
	j+5vKYylTgIj+zY=; b=nkYlJ0yNYU+23yZNVSzmKtsIazswHjitsKiP0f7lnXKr
	sjAuH5gJUvnxmzKVwEw6t5aVMYojVTKa36Cji/qKcKwb/iSUdEKryMBhQtnSw45X
	d+3oD6d99bwyLbHZBe1Ao4E4if27OXCTl65bnRtvOR5CJzVcH+H8R6Rx9o51RV/S
	C5t4Vn8Yw4wG2/xwWchAQLPV6PGLUu7mMHuM/nT5AbyI8UroUrHbU7Ob+nJIi1xe
	6En+wVKwdzLj8yx6RFvH+KMZyu9tPa0FOwb8EkcfTCrj2bx5CRyCciOKwAPJOH3r
	XHPJq/3ZBn7ApdXDTjU7htO4PiCUl4JSIdRmxKCjZw==
X-ME-Sender: <xms:bJgQZ4maxEJS0UCOP4iAz7_sESDxHninRtonI9L81GcXo-idovaZxQ>
    <xme:bJgQZ33-zpwZs2B6c4GvuyVDqlO_BlRliGmWizEMR26yd4MxYW28uPyG1K4nblsyW
    J9qJo1Nc15Cka5nlw>
X-ME-Received: <xmr:bJgQZ2oBY7XI0ixQ27QKSko9CkBKFVj3Rq1V6H9iAH1kxGAjEPTDGPPQk_9GljoEIMJMh2Rp7VAuHZ3dmQKU0dv98LTL5oHA7zV0m0bEaCi9CQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehtddgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopegvthhhohhmshhonh
    esvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhho
    rhhrrdgtohhm
X-ME-Proxy: <xmx:bJgQZ0lCCK3yBTw_Te8O2cWKe0g0PfspMbqZWUsnOY9jnrgN31avTg>
    <xmx:bJgQZ22Tob3h6gDJ_5zvuP-Cuwf6DR18ZQwbtOgoyKAhYijP_BDQaw>
    <xmx:bJgQZ7tPotclRSdXSJQTnp1Dx58vyX0yf5VRV8mE2UbbJYBz2ldQEA>
    <xmx:bJgQZyWGv8B5_WagEeUQB_zTXAr-5ZY-nJADeHIT8859higgqmUkRA>
    <xmx:bJgQZy9x_0WiwJ15pAvIjUzUyAJyBSnJOjgyhITVXobSPXGxnDyGeLz2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Oct 2024 00:54:03 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ebc81c02 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 17 Oct 2024 04:52:45 +0000 (UTC)
Date: Thu, 17 Oct 2024 06:54:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	karthik nayak <karthik.188@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, shejialuo <shejialuo@gmail.com>
Subject: [PATCH v3 06/10] t/unit-tests: check for `reftable_buf` allocation
 errors
Message-ID: <d850a2fe7d0f86dc5699674633ac396f0b2015c2.1729140565.git.ps@pks.im>
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
2.47.0.72.gef8ce8f3d4.dirty


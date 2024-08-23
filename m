Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20F9192B86
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 14:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724422360; cv=none; b=o2zhJ8YhcwtiI4eS0mTEWi9y8ZDp/qBYbKglQ1af2XIrSJrEGZT0yz2rqFomZaOA9gCuaqBG4jb8gpm8BU3j7kH+Hm9WWXAaMy0didSqgoGS9a+PqN7zqKAioWSPhcHCEIq5FGhPgadwdTedkZSFE6AdW3bHInodEKJMXjQHtfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724422360; c=relaxed/simple;
	bh=KhJQfK4t56PUtkaWwpXHdxrCHPHzsDDM9BE9VZc/cSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALJAg/UGbq1dvn9NBj+LE+/kJEMpfSDYKSsj+7UcGkbqm4dv9ZwFo5U6So6abB56pHiiAtEPqgfYfHZ1ipXyhQ8DE/vL8aiNkaMEDxbF+zNXLgfvv/T6DRKFUfEErAuJun6jPq3bi5gft4KStCIN1bjlUvoFZL54Kz0U/Jy9BOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MZQaVbDV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FhRl80nI; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MZQaVbDV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FhRl80nI"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id D10F8138C92C;
	Fri, 23 Aug 2024 10:12:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 23 Aug 2024 10:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724422357; x=1724508757; bh=IY/5AUnp4X
	k5Pc9iVRmEHZ0teDlUv0wUWehX3wlTuNU=; b=MZQaVbDVi/gYaEOQFDteFtHS54
	moMBi40vF+kk8/9Z19SreKlSaomSTIlVqGkK7/9rV/eCEIrBPGGNywk2+f3aWrLc
	pHuruvjrb+UIpeAAPO+gmKO0EDJZKexkqUlClc0Y75Q/LjR1id67ruvkVeT+cA5g
	d8gEU4iNsmiJZIdJE9Uverr51leTNgiKRIBpOFpK7FGSOb9nFSffals0bfm9BzXf
	EgyL1kffxnBTQMs01BnfGe88FUauwtYOm8HCLMtbMtQA5CNqzCbWcZE+6RYeF8EX
	cXe3KsxuhpkuzuBxJwKB8C4SSqfmREqVRIvP5VtqhUDKxhPEz0WnYj366C0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724422357; x=1724508757; bh=IY/5AUnp4Xk5Pc9iVRmEHZ0teDlU
	v0wUWehX3wlTuNU=; b=FhRl80nI2INXuSC7wNjajKQrRcEgTs+diBAUGJXkIsTZ
	nZ4OTyQXb5SuXwXtTkQwefG1oCJdDbJFHFqMj1VQtEQzFqVRPjpcXUdMGz6MH9Yy
	9fB0pshlldSTq5HPsviXYj5vI5bFl9xR6QP7HTlW+WzhQpb0615B6sMMdlcgfGRX
	KR388bxUDfd8Kzgk3qjrxKr+uUpYkuWNLV1PcYKReKWhpN++X2P9uDk3TxuMOHL9
	lZfIQ9nJCjGQIAqyeJa932NjuRKkkiJyyE64/vo1QgSxjG6Jyf64k6wHjK8rVDAP
	JeZ56F7syvUpkeEmQE+4bkfHSPdECPTFtbgXkcpYCg==
X-ME-Sender: <xms:1ZjIZvU_SPI0XXDKL_7myzvdbtTHSYNChrfir76mKO1gqyz4oipdPA>
    <xme:1ZjIZnl1C8b0u6U2Bd4VZtFPq53mfnZ_mR6kFOaIWYiaCz_K-aBqBbkS33yJOdbh3
    6NiwohQ3s8LeX17jQ>
X-ME-Received: <xmr:1ZjIZrYSWM8sIzz3DDmaPRqMUibhLG1PY2eoVlZaMTvLchDSVCS8fRu7auc6-CeYrCEP5Wd09tE89yTkuyI_T1vLcia557HZOZMzDPExuQvd1Af-Fw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvvddgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:1ZjIZqXn-sFauXIixsLby4Xl5jKBg8lMU-o0GFK6_vyccBfXe7mUwg>
    <xmx:1ZjIZpmjUuJKfXeGs0VmzAWQ5UTJVKH4ZgKA2rzEwYxdRCcEvSee8w>
    <xmx:1ZjIZne6HZwrUF8JXyuf6KBZFfheWqRAQuKUKK-r_nLQF9tEX-i4aw>
    <xmx:1ZjIZjHggLjdx809eXW54aohcVxQ9eJ-cIEZG_6ClU6g_Df2vXqOEw>
    <xmx:1ZjIZiDk4f69fZTm24tu5kf4pFeW4Sthp5rz8srH95QFEXXlrB3w2DNw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Aug 2024 10:12:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 82db40ff (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Aug 2024 14:11:59 +0000 (UTC)
Date: Fri, 23 Aug 2024 16:12:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, karthik nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 03/10] reftable/reader: rename `reftable_new_reader()`
Message-ID: <b4cf97bf7580fff022bf4a1463071ca9b039510f.1724420744.git.ps@pks.im>
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

Rename the `reftable_new_reader()` function to `reftable_reader_new()`
to match our coding guidelines.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reader.c                | 4 ++--
 reftable/readwrite_test.c        | 6 +++---
 reftable/reftable-reader.h       | 4 ++--
 reftable/stack.c                 | 4 ++--
 t/helper/test-reftable.c         | 2 +-
 t/unit-tests/t-reftable-merged.c | 6 +++---
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/reftable/reader.c b/reftable/reader.c
index 082cf00b606..ea4fdea90b6 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -637,7 +637,7 @@ void reader_close(struct reftable_reader *r)
 	FREE_AND_NULL(r->name);
 }
 
-int reftable_new_reader(struct reftable_reader **p,
+int reftable_reader_new(struct reftable_reader **p,
 			struct reftable_block_source *src, char const *name)
 {
 	struct reftable_reader *rd = reftable_calloc(1, sizeof(*rd));
@@ -786,7 +786,7 @@ int reftable_reader_print_blocks(const char *tablename)
 	if (err < 0)
 		goto done;
 
-	err = reftable_new_reader(&r, &src, tablename);
+	err = reftable_reader_new(&r, &src, tablename);
 	if (err < 0)
 		goto done;
 
diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index f411abfe9cb..101cdb5cd66 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -646,7 +646,7 @@ static void test_write_empty_table(void)
 
 	block_source_from_strbuf(&source, &buf);
 
-	err = reftable_new_reader(&rd, &source, "filename");
+	err = reftable_reader_new(&rd, &source, "filename");
 	EXPECT_ERR(err);
 
 	reftable_reader_init_ref_iterator(rd, &it);
@@ -850,7 +850,7 @@ static void test_write_multiple_indices(void)
 	EXPECT(stats->log_stats.index_offset > 0);
 
 	block_source_from_strbuf(&source, &writer_buf);
-	err = reftable_new_reader(&reader, &source, "filename");
+	err = reftable_reader_new(&reader, &source, "filename");
 	EXPECT_ERR(err);
 
 	/*
@@ -907,7 +907,7 @@ static void test_write_multi_level_index(void)
 	EXPECT(stats->ref_stats.max_index_level == 2);
 
 	block_source_from_strbuf(&source, &writer_buf);
-	err = reftable_new_reader(&reader, &source, "filename");
+	err = reftable_reader_new(&reader, &source, "filename");
 	EXPECT_ERR(err);
 
 	/*
diff --git a/reftable/reftable-reader.h b/reftable/reftable-reader.h
index 69621c5b0fc..8a05c846858 100644
--- a/reftable/reftable-reader.h
+++ b/reftable/reftable-reader.h
@@ -23,14 +23,14 @@
 /* The reader struct is a handle to an open reftable file. */
 struct reftable_reader;
 
-/* reftable_new_reader opens a reftable for reading. If successful,
+/* reftable_reader_new opens a reftable for reading. If successful,
  * returns 0 code and sets pp. The name is used for creating a
  * stack. Typically, it is the basename of the file. The block source
  * `src` is owned by the reader, and is closed on calling
  * reftable_reader_destroy(). On error, the block source `src` is
  * closed as well.
  */
-int reftable_new_reader(struct reftable_reader **pp,
+int reftable_reader_new(struct reftable_reader **pp,
 			struct reftable_block_source *src, const char *name);
 
 /* Initialize a reftable iterator for reading refs. */
diff --git a/reftable/stack.c b/reftable/stack.c
index 891ea971b72..c72435b0596 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -258,7 +258,7 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 			if (err < 0)
 				goto done;
 
-			err = reftable_new_reader(&rd, &src, name);
+			err = reftable_reader_new(&rd, &src, name);
 			if (err < 0)
 				goto done;
 		}
@@ -1532,7 +1532,7 @@ static void remove_maybe_stale_table(struct reftable_stack *st, uint64_t max,
 	if (err < 0)
 		goto done;
 
-	err = reftable_new_reader(&rd, &src, name);
+	err = reftable_reader_new(&rd, &src, name);
 	if (err < 0)
 		goto done;
 
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index c1942156b50..87c2f42aaed 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -139,7 +139,7 @@ static int dump_reftable(const char *tablename)
 	if (err < 0)
 		goto done;
 
-	err = reftable_new_reader(&r, &src, tablename);
+	err = reftable_reader_new(&r, &src, tablename);
 	if (err < 0)
 		goto done;
 
diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index 93345c6c8be..8f51aca1b62 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -102,7 +102,7 @@ merged_table_from_records(struct reftable_ref_record **refs,
 		write_test_table(&buf[i], refs[i], sizes[i]);
 		block_source_from_strbuf(&(*source)[i], &buf[i]);
 
-		err = reftable_new_reader(&(*readers)[i], &(*source)[i],
+		err = reftable_reader_new(&(*readers)[i], &(*source)[i],
 					  "name");
 		check(!err);
 	}
@@ -277,7 +277,7 @@ merged_table_from_log_records(struct reftable_log_record **logs,
 		write_test_log_table(&buf[i], logs[i], sizes[i], i + 1);
 		block_source_from_strbuf(&(*source)[i], &buf[i]);
 
-		err = reftable_new_reader(&(*readers)[i], &(*source)[i],
+		err = reftable_reader_new(&(*readers)[i], &(*source)[i],
 					  "name");
 		check(!err);
 	}
@@ -426,7 +426,7 @@ static void t_default_write_opts(void)
 
 	block_source_from_strbuf(&source, &buf);
 
-	err = reftable_new_reader(&rd, &source, "filename");
+	err = reftable_reader_new(&rd, &source, "filename");
 	check(!err);
 
 	hash_id = reftable_reader_hash_id(rd);
-- 
2.46.0.164.g477ce5ccd6.dirty


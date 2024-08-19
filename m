Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57E961FD7
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 15:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724081993; cv=none; b=GNtVrHZEhHxDTFJphw3uJYVmZxyaHBYmVWJMgUxHvJIna1vsQpKOCR44c4Ke6YZB2j5NLbqyR0kGDAxjwXilP5x1vb641BnHjqVSi83t2D61HTwuYXxTH0ELPaVeCXE2K3NVAZy1clj9EHcOUAerdgQJzJErZ20+FUnADir/B7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724081993; c=relaxed/simple;
	bh=tCg52VtFRQWbunFi4Tsofyz5VMuGgGTX6wi1vXBvagg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFS1ynXEjtZY5e528WSx+2cwbozmNahfIDgbhrD5Co/HyDgSAThTokDsFQN+rz5VC/VQjQVDUWCBx88S3ok/ralQ1CgMQ3aW4Q7xYZaYFCja29SglLJzgqk70aUdF2byd8PS/lUYDuXatLX7uufl+m/9x+LmRatkSjfBRs2p7ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CaEHs6/o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ORwJEpyG; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CaEHs6/o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ORwJEpyG"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id AF9951151ACE;
	Mon, 19 Aug 2024 11:39:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 19 Aug 2024 11:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724081990; x=1724168390; bh=II6yM6lotm
	hTAc21eui0N04Vo0NJEltb23pCtMjczwE=; b=CaEHs6/oSBih3/HsD2v5siRUTg
	zDhR68ZMjLYeeFu8RKjcLol4eDsbZUfHkl8ZXc1v2O4Zc7aXvRnE8iFA0XcRFUzx
	I18Et+YSrEF3sPlKk18WeepnuovSF0EJiw7KVTLm8RA6TBqu2iW7VrGHZoy7uyl5
	mhhQwI+fqlmaJ3NeD+yOigN9qnWgRhtP0XqmHmbsIK/jzDzDxXkUTvIfXg0o6+hQ
	11I7ScjtfjKqKSeUpWNB3FKjFvOuj4ej1zPji0CjwYXujQlqZA633uN8KKvBasiT
	/taOxYR2TCGKQ4Vby5sZeVN60diw05YM1cQZlj7p7Klb78nX8XDKlzAmnovw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724081990; x=1724168390; bh=II6yM6lotmhTAc21eui0N04Vo0NJ
	Eltb23pCtMjczwE=; b=ORwJEpyGT1f3aS36K/XKBlYWxLs98C9mPH6/L/FX8gyY
	a89MjFjbVw3QYonRvhyFHvNenQGP1TLYj086uNa86Y2hFiKZNBH+pCH6yCB3PyNP
	gAg/QBd9A7f1RFzitcf34K+z6BUBwbvKG8VQ/M9igYhanXOdSIkvrZSW+gLbO9VR
	OpRKJIYm+DBTEf+5/y2w7J2M8n228AkiC8+AFpwlzTN9afQdkI9Pc7Eg+eSZdxil
	HiDohaUNLBv4mf1vdL2PFihzWumDW1fXHlFltRuElFaEYeOTMRs98bHXe8Byegs/
	Ei3oeLjL6IDLJTot7Aub+oVtwfK3u5dgylr5OU75Fw==
X-ME-Sender: <xms:RmfDZrDffYJvTdyruPEi_LyMPDtDsofC3rGdN-ltFH3YCbfGxPqhRA>
    <xme:RmfDZhh6xsROOlH9leMs0U_cOLsiD7AdRlfntyiykiY15_bZDjP3NMrbI_olzkzuS
    c2gfyDSF1xNQaGmVw>
X-ME-Received: <xmr:RmfDZmnks2_H-u_uYSoFMZenfexUWWT9gN9p-peteUomu1TBrgYr-8yvgIV3_omqfnZJnrJXPwBiwOY_dKTK4uUSqhjTSMvWESwHo01hG8q2pVE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddugedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:RmfDZtwCfhJ8CPVXM1U4_uafXSacvDKDvkvMQy2tYHsmForXGdE2xg>
    <xmx:RmfDZgSkTL3XuchvBtnUvbMa3x8t98m36ANdrXGjte_57-CrazLVyQ>
    <xmx:RmfDZgYKlKHJM2W_plTKnbuSiVgsmEJMwnfSXq88flHUqF-rFFXyow>
    <xmx:RmfDZhQ6L7Ey4YqblIakrZcgCRvUC8k_CTxTKgD4hA16vWHFpViHhg>
    <xmx:RmfDZretHu6FH4_zrP2ObCnN_MRWVPRcDqMWB7Kb9MB-vMfhp7--3FGB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Aug 2024 11:39:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 541d6804 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Aug 2024 15:39:20 +0000 (UTC)
Date: Mon, 19 Aug 2024 17:39:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH 03/10] reftable/reader: rename `reftable_new_reader()`
Message-ID: <e658b372f046616779cf49c6c9346a49c2ce1485.1724080006.git.ps@pks.im>
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

Rename the `reftable_new_reader()` function to `reftable_reader_new()`
to match our coding guidelines.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reader.c                | 4 ++--
 reftable/reader.h                | 2 +-
 reftable/readwrite_test.c        | 6 +++---
 reftable/reftable-reader.h       | 4 ++--
 reftable/stack.c                 | 4 ++--
 t/helper/test-reftable.c         | 2 +-
 t/unit-tests/t-reftable-merged.c | 6 +++---
 7 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/reftable/reader.c b/reftable/reader.c
index 082cf00b60..ea4fdea90b 100644
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
 
diff --git a/reftable/reader.h b/reftable/reader.h
index a2c204d523..d8cbfd6404 100644
--- a/reftable/reader.h
+++ b/reftable/reader.h
@@ -52,7 +52,7 @@ struct reftable_reader {
 	struct reftable_reader_offsets log_offsets;
 };
 
-int init_reader(struct reftable_reader *r, struct reftable_block_source *source,
+int reader_init(struct reftable_reader *r, struct reftable_block_source *source,
 		const char *name);
 void reader_close(struct reftable_reader *r);
 const char *reader_name(struct reftable_reader *r);
diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index f411abfe9c..101cdb5cd6 100644
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
index 69621c5b0f..8a05c84685 100644
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
index 891ea971b7..c72435b059 100644
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
index c1942156b5..87c2f42aae 100644
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
index 93345c6c8b..8f51aca1b6 100644
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


Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3058720013A
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 10:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866565; cv=none; b=PSg+FcCAPn1JfTE8qhSMRVnppIt5CDQEHhVC6WX2mr/YVaekDKDWKSn49ag6bOGHFlHBh+jF9uqyARHRsvgc4rNVnJuOwt4fp2CJPRfD2Zxyt40hZ1CG0HFAaXJTZDa4jtH3sWr/SWZ+Tn25TjzHCtgXf2leGyLxKl+H/DD/7vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866565; c=relaxed/simple;
	bh=TnMRuxLvOthM2Fk74dI32ReBzQNqW+VMyT2XyPacCdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppnm+zYhWvGB9xm/Kyz/7egi8qOEugiYeJgn5WZ5neJ62LwSgkVLMbSCigoRtTLlSLHsG6CNbDJmd2TQbz0tWt070+c+C8wFhvuEBSGDoSs2nZKgywUGMHNLdxpRKJAhgAvQ6Zc8JIEMHsdr0tcQVp++oStNmyuUIR1nFF0t8WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kaydlhaV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JGlxW8IM; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kaydlhaV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JGlxW8IM"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6EAC01140223;
	Wed,  2 Oct 2024 06:56:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 02 Oct 2024 06:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727866563; x=1727952963; bh=s4W/aPV3Ti
	GffFf15PzGX7aV+sCgI87f2r0PJ+GUM4M=; b=kaydlhaVNc11ZCKZUl9KH+Qkuf
	mjP7j3HAWJ8zee5bOgr/IFYAKitreU51a42UAFzmBsfERKxVDTvs4DtCXuvUmrMM
	ZydMHRpijUQQMGjKstb7NEH4IJ8GZgmD03NjzSO2M1NAtQ5E345QeKTg1996IBH/
	yRJVbLzhAZCLQXCG337aKr9AG19wL8SDo9uDMkZON7kc1Qg0D+M0XatTgmG/dcEh
	LjJVqzvn0rVFaPOF3c5NFO/xp5mT8oiXgaXPY62f+Pbbol4G3Imm0sw97KkgfSHi
	5FXfTXQljfhRzGpOequ/Slnu0JQa539UFFZiqDqQO6USxQDA/8B4isfIg9xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727866563; x=1727952963; bh=s4W/aPV3TiGffFf15PzGX7aV+sCg
	I87f2r0PJ+GUM4M=; b=JGlxW8IMrbWqZdIW8WzV5+o7lkhrDBXkug3VEs9gW2S9
	7R63gw2rxZ6vfDesfg6oCN2TCMeNMiZM0AvPJiPEWxt2ZJonKKJ4pUvrk9ZIY3Yf
	SRjvkWbMmcZiUm+2TK5ivG5eZit9jDMB43twDDvcBHcaxfn45otypuXPMk4tk/MH
	N14+6aqA9c/DVO2mueorZ9LJG/UAx89bT0nZeGloJ7q/F7ZCKVFrpKW5et3I5+Zh
	+jQr8k5kNe3FrBR0VMmpyeuk14a0C6vs+Nd80xw3ayV9I2GMzo7EQJjgm0pLXft4
	o1fCXAvTtN6orL3Gzw/qbZmADXgBaIByCZOeMA1eLg==
X-ME-Sender: <xms:wyb9ZggfxNi768JsOM9mUGUJonJs5vRZHprzSRgAAVrfNlGoCx2fLw>
    <xme:wyb9ZpCCuFJuioUM9v5NhOZULarvQXp5Yv1ucVEkfI-Wrn_0qY_YYdhOyERCcVtvB
    A6sjEEp-FiCFnmD9g>
X-ME-Received: <xmr:wyb9ZoFP_TE36iQnADxzxF3T4fperXI4Nq0UXDKls0y0cWIZJcWwxZp5tU36UwWo-7DeWtayZ4BRKXePHKx_EMSRs1j7k7ARKKgoghzMQ2x8C9sN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheplhdrshdrrh
    esfigvsgdruggv
X-ME-Proxy: <xmx:wyb9ZhQsGEyTQAEiDXAX_PqWwk8BUkOKkxYsxRKbdDfoREN4rVKZkA>
    <xmx:wyb9ZtyAmFRgsvsFDjMgdHKIRk_03-Nzqvf6k7N_DZ2twrBoTIaXzw>
    <xmx:wyb9Zv4haxwvSyC1xffszqT-wfg0zRpJPqnzOg-REfl3wmdDNkXq3w>
    <xmx:wyb9Zqw-7WbklOqIlfIHU2xFb0CpmnYc_mb0H8OPSEWEq3ekDBuyUw>
    <xmx:wyb9Zvt2T9ao736weZ1Ta8hukySD10RB0Boewy9jL1neviWyq0jLnejh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 06:56:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 84e1befe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 10:55:11 +0000 (UTC)
Date: Wed, 2 Oct 2024 12:55:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v5 12/25] reftable/reader: handle allocation failures in
 `reader_init_iter()`
Message-ID: <ceed83826537cca26cc04d237efb298343dcde14.1727866394.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727866394.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727866394.git.ps@pks.im>

Handle allocation failures in `reader_init_iter()`. This requires us to
also adapt `reftable_reader_init_*_iterator()` to bubble up the new
error codes. Adapt callers accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c                   |  4 +++-
 reftable/reader.c                   | 28 +++++++++++++++---------
 reftable/reader.h                   |  6 ++---
 reftable/reftable-reader.h          |  8 +++----
 t/unit-tests/t-reftable-readwrite.c | 34 +++++++++++++++++++----------
 5 files changed, 50 insertions(+), 30 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index de4f81abaf..69790c345c 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -244,7 +244,9 @@ int merged_table_init_iter(struct reftable_merged_table *mt,
 
 	for (size_t i = 0; i < mt->readers_len; i++) {
 		reftable_record_init(&subiters[i].rec, typ);
-		reader_init_iter(mt->readers[i], &subiters[i].iter, typ);
+		ret = reader_init_iter(mt->readers[i], &subiters[i].iter, typ);
+		if (ret < 0)
+			goto out;
 	}
 
 	REFTABLE_CALLOC_ARRAY(mi, 1);
diff --git a/reftable/reader.c b/reftable/reader.c
index 485ee085da..f696e992df 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -554,32 +554,37 @@ static void iterator_from_table_iter(struct reftable_iterator *it,
 	it->ops = &table_iter_vtable;
 }
 
-void reader_init_iter(struct reftable_reader *r,
-		      struct reftable_iterator *it,
-		      uint8_t typ)
+int reader_init_iter(struct reftable_reader *r,
+		     struct reftable_iterator *it,
+		     uint8_t typ)
 {
 	struct reftable_reader_offsets *offs = reader_offsets_for(r, typ);
 
 	if (offs->is_present) {
 		struct table_iter *ti;
 		REFTABLE_ALLOC_ARRAY(ti, 1);
+		if (!ti)
+			return REFTABLE_OUT_OF_MEMORY_ERROR;
+
 		table_iter_init(ti, r);
 		iterator_from_table_iter(it, ti);
 	} else {
 		iterator_set_empty(it);
 	}
+
+	return 0;
 }
 
-void reftable_reader_init_ref_iterator(struct reftable_reader *r,
-				       struct reftable_iterator *it)
+int reftable_reader_init_ref_iterator(struct reftable_reader *r,
+				      struct reftable_iterator *it)
 {
-	reader_init_iter(r, it, BLOCK_TYPE_REF);
+	return reader_init_iter(r, it, BLOCK_TYPE_REF);
 }
 
-void reftable_reader_init_log_iterator(struct reftable_reader *r,
-				       struct reftable_iterator *it)
+int reftable_reader_init_log_iterator(struct reftable_reader *r,
+				      struct reftable_iterator *it)
 {
-	reader_init_iter(r, it, BLOCK_TYPE_LOG);
+	return reader_init_iter(r, it, BLOCK_TYPE_LOG);
 }
 
 int reftable_reader_new(struct reftable_reader **out,
@@ -689,7 +694,10 @@ static int reftable_reader_refs_for_indexed(struct reftable_reader *r,
 	struct indexed_table_ref_iter *itr = NULL;
 
 	/* Look through the reverse index. */
-	reader_init_iter(r, &oit, BLOCK_TYPE_OBJ);
+	err = reader_init_iter(r, &oit, BLOCK_TYPE_OBJ);
+	if (err < 0)
+		goto done;
+
 	err = iterator_seek(&oit, &want);
 	if (err != 0)
 		goto done;
diff --git a/reftable/reader.h b/reftable/reader.h
index 3710ee09b4..02d10c5d37 100644
--- a/reftable/reader.h
+++ b/reftable/reader.h
@@ -56,9 +56,9 @@ struct reftable_reader {
 
 const char *reader_name(struct reftable_reader *r);
 
-void reader_init_iter(struct reftable_reader *r,
-		      struct reftable_iterator *it,
-		      uint8_t typ);
+int reader_init_iter(struct reftable_reader *r,
+		     struct reftable_iterator *it,
+		     uint8_t typ);
 
 /* initialize a block reader to read from `r` */
 int reader_init_block_reader(struct reftable_reader *r, struct block_reader *br,
diff --git a/reftable/reftable-reader.h b/reftable/reftable-reader.h
index a600452b56..6a2d0b693f 100644
--- a/reftable/reftable-reader.h
+++ b/reftable/reftable-reader.h
@@ -46,12 +46,12 @@ void reftable_reader_incref(struct reftable_reader *reader);
 void reftable_reader_decref(struct reftable_reader *reader);
 
 /* Initialize a reftable iterator for reading refs. */
-void reftable_reader_init_ref_iterator(struct reftable_reader *r,
-				       struct reftable_iterator *it);
+int reftable_reader_init_ref_iterator(struct reftable_reader *r,
+				      struct reftable_iterator *it);
 
 /* Initialize a reftable iterator for reading logs. */
-void reftable_reader_init_log_iterator(struct reftable_reader *r,
-				       struct reftable_iterator *it);
+int reftable_reader_init_log_iterator(struct reftable_reader *r,
+				      struct reftable_iterator *it);
 
 /* returns the hash ID used in this table. */
 uint32_t reftable_reader_hash_id(struct reftable_reader *r);
diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
index e1b235a5f1..acca927a2c 100644
--- a/t/unit-tests/t-reftable-readwrite.c
+++ b/t/unit-tests/t-reftable-readwrite.c
@@ -206,7 +206,8 @@ static void t_log_write_read(void)
 	err = reftable_reader_new(&reader, &source, "file.log");
 	check(!err);
 
-	reftable_reader_init_ref_iterator(reader, &it);
+	err = reftable_reader_init_ref_iterator(reader, &it);
+	check(!err);
 
 	err = reftable_iterator_seek_ref(&it, names[N - 1]);
 	check(!err);
@@ -221,8 +222,8 @@ static void t_log_write_read(void)
 	reftable_iterator_destroy(&it);
 	reftable_ref_record_release(&ref);
 
-	reftable_reader_init_log_iterator(reader, &it);
-
+	err = reftable_reader_init_log_iterator(reader, &it);
+	check(!err);
 	err = reftable_iterator_seek_log(&it, "");
 	check(!err);
 
@@ -296,7 +297,8 @@ static void t_log_zlib_corruption(void)
 	err = reftable_reader_new(&reader, &source, "file.log");
 	check(!err);
 
-	reftable_reader_init_log_iterator(reader, &it);
+	err = reftable_reader_init_log_iterator(reader, &it);
+	check(!err);
 	err = reftable_iterator_seek_log(&it, "refname");
 	check_int(err, ==, REFTABLE_ZLIB_ERROR);
 
@@ -325,7 +327,8 @@ static void t_table_read_write_sequential(void)
 	err = reftable_reader_new(&reader, &source, "file.ref");
 	check(!err);
 
-	reftable_reader_init_ref_iterator(reader, &it);
+	err = reftable_reader_init_ref_iterator(reader, &it);
+	check(!err);
 	err = reftable_iterator_seek_ref(&it, "");
 	check(!err);
 
@@ -376,7 +379,8 @@ static void t_table_read_api(void)
 	err = reftable_reader_new(&reader, &source, "file.ref");
 	check(!err);
 
-	reftable_reader_init_ref_iterator(reader, &it);
+	err = reftable_reader_init_ref_iterator(reader, &it);
+	check(!err);
 	err = reftable_iterator_seek_ref(&it, names[0]);
 	check(!err);
 
@@ -419,7 +423,8 @@ static void t_table_read_write_seek(int index, int hash_id)
 	}
 
 	for (i = 1; i < N; i++) {
-		reftable_reader_init_ref_iterator(reader, &it);
+		err = reftable_reader_init_ref_iterator(reader, &it);
+		check(!err);
 		err = reftable_iterator_seek_ref(&it, names[i]);
 		check(!err);
 		err = reftable_iterator_next_ref(&it, &ref);
@@ -435,7 +440,8 @@ static void t_table_read_write_seek(int index, int hash_id)
 	strbuf_addstr(&pastLast, names[N - 1]);
 	strbuf_addstr(&pastLast, "/");
 
-	reftable_reader_init_ref_iterator(reader, &it);
+	err = reftable_reader_init_ref_iterator(reader, &it);
+	check(!err);
 	err = reftable_iterator_seek_ref(&it, pastLast.buf);
 	if (err == 0) {
 		struct reftable_ref_record ref = { 0 };
@@ -534,7 +540,8 @@ static void t_table_refs_for(int indexed)
 	if (!indexed)
 		reader->obj_offsets.is_present = 0;
 
-	reftable_reader_init_ref_iterator(reader, &it);
+	err = reftable_reader_init_ref_iterator(reader, &it);
+	check(!err);
 	err = reftable_iterator_seek_ref(&it, "");
 	check(!err);
 	reftable_iterator_destroy(&it);
@@ -593,7 +600,8 @@ static void t_write_empty_table(void)
 	err = reftable_reader_new(&rd, &source, "filename");
 	check(!err);
 
-	reftable_reader_init_ref_iterator(rd, &it);
+	err = reftable_reader_init_ref_iterator(rd, &it);
+	check(!err);
 	err = reftable_iterator_seek_ref(&it, "");
 	check(!err);
 
@@ -802,7 +810,8 @@ static void t_write_multiple_indices(void)
 	 * Seeking the log uses the log index now. In case there is any
 	 * confusion regarding indices we would notice here.
 	 */
-	reftable_reader_init_log_iterator(reader, &it);
+	err = reftable_reader_init_log_iterator(reader, &it);
+	check(!err);
 	err = reftable_iterator_seek_log(&it, "");
 	check(!err);
 
@@ -858,7 +867,8 @@ static void t_write_multi_level_index(void)
 	/*
 	 * Seeking the last ref should work as expected.
 	 */
-	reftable_reader_init_ref_iterator(reader, &it);
+	err = reftable_reader_init_ref_iterator(reader, &it);
+	check(!err);
 	err = reftable_iterator_seek_ref(&it, "refs/heads/199");
 	check(!err);
 
-- 
2.47.0.rc0.dirty


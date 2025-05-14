Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032151FA859
	for <git@vger.kernel.org>; Wed, 14 May 2025 05:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747199560; cv=none; b=c0y729cdnWF9VQDdgPhwcQMG/DaSn2K0CtuFbpFmYN8t+zfw17Y9useOAv3qa4hCaVHxPMh/xToR+QggcT7byJdg0obhNdBoBvqU/v12nDXTOiBUzf+CD6OhuBDYhxtqVWk/n0+3P+pjMwW/OPrtiLt9SS/7tn51OPonXEMI1o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747199560; c=relaxed/simple;
	bh=DaJ4fBjXhZzgLmzi9QlPxRfFSiMeRzNf17tc1g11x+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JXl1TIhyDbiSA7Imt5TvlUABoDBrUwXyXIHMh+Wnh/BjfIHejRiqUO2BvZh2erzqpZh2Z/BHAOrHqGBjbXNPJ7jpdWjaXUzsPhYM6yiXY+MIjqNFVVddqMDFgC6vpNGVjxBvXobb0js3Topl+g8OBP13dMuFM2XO6Gh87WjPtUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iYfkf4p8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZWydcHmU; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iYfkf4p8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZWydcHmU"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 453541140139;
	Wed, 14 May 2025 01:12:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 14 May 2025 01:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747199558;
	 x=1747285958; bh=ZvjjkUPiPKLbagdUir5I9PAaQEmD7K7QTyNuB1aagt4=; b=
	iYfkf4p858spu1gI2wZrffy93vFvn01gJpdXm8zdFmTRgs7zRyRK8ZZRD/E0+u9B
	CFGhAW6adp1uPqPXqhF6PA9VNSzOm0HvdT6rCv7aUdEpTbrv6UVIdGvMDu30CtNJ
	RnBKSTWt4bHA9XCo7+l/jYwNnG8dFUfJMdmPRHwX0aYw9Fdf8NmV83BPDlwgwJDL
	+cU4dkY5pZU1J7LqY0JK//qWumyzrk6JtdrD+MULv+SpSWdXZtu/5N+4UnxmFWGe
	qwYErlzA+RHy4iHiPiHuVOZjhlqspYXwjTt17V7tLMH1DORPg4BAJ8Wi/0dPLeRr
	N48Ma8Mjm9+YnM8y+LoG/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747199558; x=
	1747285958; bh=ZvjjkUPiPKLbagdUir5I9PAaQEmD7K7QTyNuB1aagt4=; b=Z
	WydcHmUuWBEFfuA0T49+lhD9bW9gsT37SbC3g6rUYCY+MrCgmN3j0yu6hdAgXU82
	/fY/hx8gNLlNx9iWDOeta8VxvXvstInuJI35VWhMGTbCPq2gbwbfKF5z0F+kkPQk
	Fi/tgy9CzxeBLK4z9hPslf2C74nzaIJWFNUe0oEuAU/ibfD12XtZcl6AKulKh4KD
	h/F4AF23m4SY58pPomfK9zqK8hYhfSu9xUbFpslWgTxwtilfq3gOAiSUHcCX4ZOR
	0qzlcGuGLOJBlwVu5J86cBwd6ZKEDexmuZ+W7AvaBUaX8N9uM/mpkYQInvuqFoWs
	SPYK46dMUBrvYDK0oFsvg==
X-ME-Sender: <xms:RiYkaBCTkkHUIOjQf3iKLumIcPvpJhBiiOy_oUAfEtSeTiJlMbjobQ>
    <xme:RiYkaPgZP1aSFrLaXKZYIx06bwTX5ejRGUtUU_terf_LaKsjUIxWmfw-7FDCchIql
    6KYBw84CRK_XPUXWQ>
X-ME-Received: <xmr:RiYkaMk2M2KYKZ41ZQzAh5ZqTZfmnP_fk7SAOmmxDDZE8wd9eXI7Oi7kbRRxxHf3xNWmNmVTohTh7tCsRoqi43VlruzI7sVJXT6mDz1tLBU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdeiudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehs
    thholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtg
    homh
X-ME-Proxy: <xmx:RiYkaLxVNucTPn3_nR2wkaLaCG1HOD5_iYJcrzg7AzwYFkyWgs3wYQ>
    <xmx:RiYkaGQtvZDPe4d4zDcy81fSTit3Y5IZ0xVV3L5wyu0zdGvgzDWCQQ>
    <xmx:RiYkaObHaqgDr6iUYjvdzh_95c9_hLMkifHiwa4xBYC8TiJeGeTItQ>
    <xmx:RiYkaHRStdO3xYLUbr1cxMiPPIGe-p8BUzYM9fxeGHzFU10grvihsw>
    <xmx:RiYkaIW-jfaA3J84rUTgkivzWwx-lwIzn8OD_oeyenKxSieN0NW9f1lE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 01:12:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a4d45b3b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 14 May 2025 05:12:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 14 May 2025 07:12:32 +0200
Subject: [PATCH v3 09/17] odb: get rid of `the_repository` in `for_each()`
 functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250514-pks-object-store-wo-the-repository-v3-9-47df1d4ead22@pks.im>
References: <20250514-pks-object-store-wo-the-repository-v3-0-47df1d4ead22@pks.im>
In-Reply-To: <20250514-pks-object-store-wo-the-repository-v3-0-47df1d4ead22@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

There are a couple of iterator-style functions that execute a callback
for each instance of a given set, all of which currently depend on
`the_repository`. Refactor them to instead take an object database as
parameter so that we can get rid of this dependency.

Rename the functions accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/count-objects.c     |  2 +-
 builtin/receive-pack.c      |  3 ++-
 builtin/submodule--helper.c |  3 ++-
 diagnose.c                  |  2 +-
 fetch-pack.c                |  3 ++-
 odb.c                       | 36 +++++++++++++++++++-----------------
 odb.h                       | 23 ++++++++++++++++++-----
 revision.c                  |  3 ++-
 8 files changed, 47 insertions(+), 28 deletions(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index da830fcee57..2752a9b02f4 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -159,7 +159,7 @@ int cmd_count_objects(int argc,
 		printf("prune-packable: %lu\n", packed_loose);
 		printf("garbage: %lu\n", garbage);
 		printf("size-garbage: %s\n", garbage_buf.buf);
-		foreach_alt_odb(print_alternate, NULL);
+		odb_for_each_alternate(the_repository->objects, print_alternate, NULL);
 		strbuf_release(&loose_buf);
 		strbuf_release(&pack_buf);
 		strbuf_release(&garbage_buf);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index cb5fd55a8e4..8c157ea7d1b 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -358,7 +358,8 @@ static void write_head_info(void)
 
 	refs_for_each_fullref_in(get_main_ref_store(the_repository), "",
 				 exclude_patterns, show_ref_cb, &seen);
-	for_each_alternate_ref(show_one_alternate_ref, &seen);
+	odb_for_each_alternate_ref(the_repository->objects,
+				   show_one_alternate_ref, &seen);
 
 	oidset_clear(&seen);
 	strvec_clear(&excludes_vector);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a6c936fb2bd..88bbd97820a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1668,7 +1668,8 @@ static void prepare_possible_alternates(const char *sm_name,
 		die(_("Value '%s' for submodule.alternateErrorStrategy is not recognized"), error_strategy);
 
 	if (!strcmp(sm_alternate, "superproject"))
-		foreach_alt_odb(add_possible_reference_from_superproject, &sas);
+		odb_for_each_alternate(the_repository->objects,
+				       add_possible_reference_from_superproject, &sas);
 	else if (!strcmp(sm_alternate, "no"))
 		; /* do nothing */
 	else
diff --git a/diagnose.c b/diagnose.c
index d407c98d094..0405368f178 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -229,7 +229,7 @@ int create_diagnostics_archive(struct repository *r,
 	strbuf_reset(&buf);
 	strbuf_addstr(&buf, "--add-virtual-file=packs-local.txt:");
 	dir_file_stats(r->objects->alternates, &buf);
-	foreach_alt_odb(dir_file_stats, &buf);
+	odb_for_each_alternate(r->objects, dir_file_stats, &buf);
 	strvec_push(&archiver_args, buf.buf);
 
 	strbuf_reset(&buf);
diff --git a/fetch-pack.c b/fetch-pack.c
index cf157f5d7e5..47fa7fa4c49 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -115,7 +115,8 @@ static void for_each_cached_alternate(struct fetch_negotiator *negotiator,
 	size_t i;
 
 	if (!initialized) {
-		for_each_alternate_ref(cache_one_alternate, &cache);
+		odb_for_each_alternate_ref(the_repository->objects,
+					   cache_one_alternate, &cache);
 		initialized = 1;
 	}
 
diff --git a/odb.c b/odb.c
index bd601471cd7..feca14d9683 100644
--- a/odb.c
+++ b/odb.c
@@ -494,8 +494,8 @@ static void fill_alternate_refs_command(struct child_process *cmd,
 }
 
 static void read_alternate_refs(const char *path,
-				alternate_ref_fn *cb,
-				void *data)
+				odb_for_each_alternate_ref_fn *cb,
+				void *payload)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct strbuf line = STRBUF_INIT;
@@ -517,7 +517,7 @@ static void read_alternate_refs(const char *path,
 			break;
 		}
 
-		cb(&oid, data);
+		cb(&oid, payload);
 	}
 
 	fclose(fh);
@@ -526,16 +526,16 @@ static void read_alternate_refs(const char *path,
 }
 
 struct alternate_refs_data {
-	alternate_ref_fn *fn;
-	void *data;
+	odb_for_each_alternate_ref_fn *fn;
+	void *payload;
 };
 
 static int refs_from_alternate_cb(struct odb_alternate *alternate,
-				  void *data)
+				  void *payload)
 {
 	struct strbuf path = STRBUF_INIT;
 	size_t base_len;
-	struct alternate_refs_data *cb = data;
+	struct alternate_refs_data *cb = payload;
 
 	if (!strbuf_realpath(&path, alternate->path, 0))
 		goto out;
@@ -549,29 +549,31 @@ static int refs_from_alternate_cb(struct odb_alternate *alternate,
 		goto out;
 	strbuf_setlen(&path, base_len);
 
-	read_alternate_refs(path.buf, cb->fn, cb->data);
+	read_alternate_refs(path.buf, cb->fn, cb->payload);
 
 out:
 	strbuf_release(&path);
 	return 0;
 }
 
-void for_each_alternate_ref(alternate_ref_fn fn, void *data)
+void odb_for_each_alternate_ref(struct object_database *odb,
+				odb_for_each_alternate_ref_fn cb, void *payload)
 {
-	struct alternate_refs_data cb;
-	cb.fn = fn;
-	cb.data = data;
-	foreach_alt_odb(refs_from_alternate_cb, &cb);
+	struct alternate_refs_data data;
+	data.fn = cb;
+	data.payload = payload;
+	odb_for_each_alternate(odb, refs_from_alternate_cb, &data);
 }
 
-int foreach_alt_odb(alt_odb_fn fn, void *cb)
+int odb_for_each_alternate(struct object_database *odb,
+			 odb_for_each_alternate_fn cb, void *payload)
 {
 	struct odb_alternate *alternate;
 	int r = 0;
 
-	odb_prepare_alternates(the_repository->objects);
-	for (alternate = the_repository->objects->alternates->next; alternate; alternate = alternate->next) {
-		r = fn(alternate, cb);
+	odb_prepare_alternates(odb);
+	for (alternate = odb->alternates->next; alternate; alternate = alternate->next) {
+		r = cb(alternate, payload);
 		if (r)
 			break;
 	}
diff --git a/odb.h b/odb.h
index 7ff3e54c061..dcc3b0bc1f0 100644
--- a/odb.h
+++ b/odb.h
@@ -66,11 +66,6 @@ struct odb_alternate {
 	char *path;
 };
 
-typedef int alt_odb_fn(struct odb_alternate *, void *);
-int foreach_alt_odb(alt_odb_fn, void*);
-typedef void alternate_ref_fn(const struct object_id *oid, void *);
-void for_each_alternate_ref(alternate_ref_fn, void *);
-
 /*
  * Replace the current writable object directory with the specified temporary
  * object directory; returns the former primary object directory.
@@ -185,6 +180,24 @@ void odb_clear(struct object_database *o);
  */
 struct odb_alternate *odb_find_alternate(struct object_database *odb, const char *obj_dir);
 
+/*
+ * Iterate through all alternates of the database and execute the provided
+ * callback function for each of them. Stop iterating once the callback
+ * function returns a non-zero value, in which case the value is bubbled up
+ * from the callback.
+ */
+typedef int odb_for_each_alternate_fn(struct odb_alternate *, void *);
+int odb_for_each_alternate(struct object_database *odb,
+			   odb_for_each_alternate_fn cb, void *payload);
+
+/*
+ * Iterate through all alternates of the database and yield their respective
+ * references.
+ */
+typedef void odb_for_each_alternate_ref_fn(const struct object_id *oid, void *);
+void odb_for_each_alternate_ref(struct object_database *odb,
+				odb_for_each_alternate_ref_fn cb, void *payload);
+
 /*
  * Create a temporary file rooted in the primary alternate's directory, or die
  * on failure. The filename is taken from "pattern", which should have the
diff --git a/revision.c b/revision.c
index cdefe7d6e48..b0364f556ee 100644
--- a/revision.c
+++ b/revision.c
@@ -1907,7 +1907,8 @@ static void add_alternate_refs_to_pending(struct rev_info *revs,
 	struct add_alternate_refs_data data;
 	data.revs = revs;
 	data.flags = flags;
-	for_each_alternate_ref(add_one_alternate_ref, &data);
+	odb_for_each_alternate_ref(the_repository->objects,
+				   add_one_alternate_ref, &data);
 }
 
 static int add_parents_only(struct rev_info *revs, const char *arg_, int flags,

-- 
2.49.0.1141.g47af616452.dirty


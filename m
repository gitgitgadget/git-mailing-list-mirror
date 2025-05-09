Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A75295DAF
	for <git@vger.kernel.org>; Fri,  9 May 2025 14:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746799944; cv=none; b=ACA3VMeyLQnqF4KSwvkjd5hUDXUFziVqUmvAE7ad7FlPzuTnemOA+b84u5hzNzjBv1cHITusZntQ4Zk81R1R1MQ2GXYSp+HuKFrVcAEBynGflD5wAta6DXX6wzC2ylWpGhP21G2ut0iFItfkIRtOdr6nxBgdqnPPWDWO5OrPsTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746799944; c=relaxed/simple;
	bh=I+jcP5WG7LiR+m6x2sLSdMdC6bHMNx3tentHgsbpteI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HODFzqCo89LUC5lafUt/iilvQ94GOgOuxxf5aXsL6B5Wat+WUZfey8A96OXV+TP0QO4eSHfjuX2iOg1dKNMk8AWZ3H165fI047qEWVzA69vpK9a0wjnJBbpAYK8Fnlu9771v+jZFFwrf+2olETxqJjF0x/fH+fh8bKEly6Ya2eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ntXZxXlG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cNlpnpX2; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ntXZxXlG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cNlpnpX2"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EB33A2540144;
	Fri,  9 May 2025 10:12:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 09 May 2025 10:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746799941;
	 x=1746886341; bh=U89u9wmk4ltxqmcJk0euu2IfRMooTW06tIBEGOrHjbM=; b=
	ntXZxXlGSgYXBf/nbW4jg9z2nDmgx9y6MvKMgN1RTxcWiyCsKc92hJTfY9Ra3Cg8
	WF0zBxs1ioZVM97CvnHmMJ4+ZvdKYOZbiPccY08op8rKaZC7UK2PriFhTORkJ7Xh
	hQq5eKA9j9KNO4pK1UelZyH+kQmH3Cerf6tj4Gb5Exnm/PPPOIP2EbpShX9zdzCu
	OPaYnKjYwhBzBKJMSqdIvpqyKKI6bRCja+BsUNQ12WEqyHQ08tfuE/E1DtYDz6vo
	B7g9zILIb1uqldE83jeUBU50Jn3dBWCjhT1ath58MZDnUCTTkccxZcX1XdEplJyr
	pu9lCrNUvHi4R3T4N4Pwbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746799941; x=
	1746886341; bh=U89u9wmk4ltxqmcJk0euu2IfRMooTW06tIBEGOrHjbM=; b=c
	NlpnpX2g2DNzr4RM+0QoPDgDOylMMaYtQDB7O+acEy5vp1swgDKGO0UCuuhkRGKu
	aH0NwTPUiX4nMrmM9FkMDfsr8jfNcuPp0WT9bp+8Jf3fX6yH2e92iqKSArI7TR9i
	j1ztI9PlyFsmz2oATrdhQP/enj7I29fZcCpuHK+dr6ngJ10Tl69cGiocNFDIs588
	AJY6W42xEICIQ7rQlhJLbsIrmG0MUvLPWjKUO+nMbifQPHoqE3AD4IG8dHgh83B9
	O+AdXZpwg2Y+VeftElf5UNI4nt81EIeHRFUfUTXhkE/WFWDQKlL0v+PJSiE2MU3k
	eOAwdxFmT8tjwRlPccBSg==
X-ME-Sender: <xms:RQ0eaEmKshsHKfbeHFSkjpOLsOQ0sev02S8w0XUFdFVSRhIuNuEQCg>
    <xme:RQ0eaD2ThERv5Gzdr6yqggJ6IeYo19VLuaPQzDMww9B-kuPHeaOu1kuIBsrf3tZxY
    lTzJU4qCwS1eWxnKw>
X-ME-Received: <xmr:RQ0eaCrXV-IqJSpJYMqutbbBK44Dxp3Wp13_BVfyOa6ufQD0vz6lzAUeN-NV_WCZH8NIIITr0kN_Z5WkJ330Gm6aJzUmorST7jTGGvhUcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:RQ0eaAnFUVZyttf-6lOc_TeYs-vm0lfwP-ClRjLU_OtryUmMObheEA>
    <xmx:RQ0eaC2_Zubz_QK-0m_r7w5OIIRfEj0N3M40dJlmvwfqGV7dx8_4hg>
    <xmx:RQ0eaHtw5C35qU82Ki8c9TqpttRbT9dWksE9r1TaIQlQQfWncvsQ4Q>
    <xmx:RQ0eaOX3U5UHf9MdzoNB6tti7KKRuiPlGgs12YmV8x9vC8R1xlo6YQ>
    <xmx:RQ0eaDiNNOtA-c9G26U7w4kR93bNdMtEjRP92URDHCFk6Ynz2JDRK_zs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 10:12:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f29ac2a9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 9 May 2025 14:12:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 May 2025 16:12:09 +0200
Subject: [PATCH v2 09/17] odb: get rid of `the_repository` in `for_each()`
 functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-pks-object-store-wo-the-repository-v2-9-103f59bf8e28@pks.im>
References: <20250509-pks-object-store-wo-the-repository-v2-0-103f59bf8e28@pks.im>
In-Reply-To: <20250509-pks-object-store-wo-the-repository-v2-0-103f59bf8e28@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
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
index 443af1b6154..03ac369bca9 100644
--- a/odb.h
+++ b/odb.h
@@ -63,11 +63,6 @@ struct odb_alternate {
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
@@ -182,6 +177,24 @@ void odb_clear(struct object_database *o);
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
2.49.0.1077.gc0e912fd4c.dirty


Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CEE2798F2
	for <git@vger.kernel.org>; Tue,  6 May 2025 11:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529769; cv=none; b=F8hz4KMNQupU0wCGe74Bxce1cNntXfJMcbvDGyW4p7teV4nQKiF5loPTAlSEsitbVltre3PjA/Un9pN4aoMB9eM3/UTpbozjCiguye120pA5OrIL8NTsPv/22MFw53Tup26avHT5COP9QiGgVbbjiRmYe6mAdcNaLen2AdGeYiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529769; c=relaxed/simple;
	bh=9JiLuYT2G2gXz14rzIDzrhUpBNktc21P4zfY+j+WMuI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SSCWuLXsrgUtwJSAgcCJPu4hpaw+sp4Ru7/LUOHw6Lq7YL3h+dSbE9cdq4BPKc5oMLc/9Rfm8s9+5dmku4ZPuRxMwQrlfCRGMenDgkmKzhIeYSXy/fpxNXWsy0eER2hCtm/UpL2lTXGf4h0h8CXLWNFaARsZ/BULtvx5ugEB1I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VbxRCHiu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tiMVytck; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VbxRCHiu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tiMVytck"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D971F114028C
	for <git@vger.kernel.org>; Tue,  6 May 2025 07:09:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 06 May 2025 07:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746529766;
	 x=1746616166; bh=AxwfhTNFH1p2l1uuIrC9nc+f3a7RMqrKOIehVBI5nGY=; b=
	VbxRCHiulkfYptjPsmk96piL+zlb7+uCsLeh2+wW0BhyU6y9Qcda0yb9HvxU1fOM
	2KdXUO4wPdq9tXy71j8Fg5OJu2MAFQCtZ4hpX+37EA8inssFYETsln4hs0n/EXOz
	SPp/GKtdzGP/sPDnKPvjJa2u7nxcylkC1JkJjnuH3S5EDLlL7YYpp47Xlbn1K0Yx
	7/rRHj9Zn8DSZOEYbEB/63e+mtWTFEmap8ic2H+GpdyhCHIpaGseeUjCHd497tXo
	AaR+1wMDgysB1ZdNOv713Nn/NCPxZNRpy6720a/NEqqbTIAbXKgIO3p4dwycTcpJ
	KSNreqEGT/Mo4DUSGjDaUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746529766; x=
	1746616166; bh=AxwfhTNFH1p2l1uuIrC9nc+f3a7RMqrKOIehVBI5nGY=; b=t
	iMVytck+mMvU5PBTPbDg8pDv6X06GRRyMXuSmYEhItNwDCiKK9Gu4mAtv3VpcYTm
	zxd9AEhAcjzdaMWcPrVTyxPqdos3X36ob7h27hsHjhw8bOdLVp5aTK74fFpJ4p/C
	m19iUote2cklUdkyXrqS2pfRuKxB7k+erkGPa8twH5BH45biYqnnBMY9hsX3e/IH
	k8SpU5Dhe5mv0hcU5IABDi2cU6IVwEJ/QeJ4bo7p1y1nKTK2G/5n8AlAVgy2RYCZ
	M+IQR+8T/r19FNr3mSmtiBlDJZ/z0aCXdz2/ncZNbODQNzLZ4KfF4JohmzXM0xxo
	YFJHbL7MpcpK1NOVdu9ew==
X-ME-Sender: <xms:5u0ZaGoL0oTDMFq5PjmmF8IYq7-pLZbf3lHT0WWDMRd4b400F3g-Pg>
    <xme:5u0ZaEo0Xv33_YbECm-yc5b1pmr-ftCCMSUB_OR7FPrvXsmmC1ArPTSGvmRsbkAO7
    0ejcp-c4PrkM1uO0w>
X-ME-Received: <xmr:5u0ZaLMXr9vUd9brNFku12b7_wIg53lnbpB81mPKzIuGjsqPVPvE0HUY5DhCaK--g6lzMSCFYElfCSJz0fd_I9AWN4Fkme1iI3dOpui0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeefkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:5u0ZaF5VvzAvMIWydd24u-RdWL-Br9rQ1zf8m39xKQx6fNU6mYXcFg>
    <xmx:5u0ZaF6RFRsGWaD0se0WHxF6QI5EYCNUZIb3BCnjSA_2IBm_9P-ofw>
    <xmx:5u0ZaFj1V_DNZH7evD9O7AM3hw5_bzfBI6xbU6V1dWALaiV5aglFMw>
    <xmx:5u0ZaP4XnkvLrlqjOpkeExlHDktEW_1FS_sr69uHncMUHkXnTCl-Zg>
    <xmx:5u0ZaKGJ7Opke9H7sQj0cWGuUloG8e6rIM21_GlNnHqtMW2evGHAzmMr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 May 2025 07:09:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 66c0ce2d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 May 2025 11:09:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 06 May 2025 13:09:22 +0200
Subject: [PATCH 09/17] odb: get rid of `the_repository` in `for_each()`
 functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-pks-object-store-wo-the-repository-v1-9-c05b82e7b126@pks.im>
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
In-Reply-To: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
To: git@vger.kernel.org
Cc: 
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
index 80f2693ac3c..5ca806d53e3 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -159,7 +159,7 @@ int cmd_count_objects(int argc,
 		printf("prune-packable: %lu\n", packed_loose);
 		printf("garbage: %lu\n", garbage);
 		printf("size-garbage: %s\n", garbage_buf.buf);
-		foreach_alt_odb(print_alternate, NULL);
+		odb_for_each_backend(the_repository->objects, print_alternate, NULL);
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
index 7f672e4808c..d54546df9da 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1668,7 +1668,8 @@ static void prepare_possible_alternates(const char *sm_name,
 		die(_("Value '%s' for submodule.alternateErrorStrategy is not recognized"), error_strategy);
 
 	if (!strcmp(sm_alternate, "superproject"))
-		foreach_alt_odb(add_possible_reference_from_superproject, &sas);
+		odb_for_each_backend(the_repository->objects,
+				     add_possible_reference_from_superproject, &sas);
 	else if (!strcmp(sm_alternate, "no"))
 		; /* do nothing */
 	else
diff --git a/diagnose.c b/diagnose.c
index 6ec07761a0f..0529e239837 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -229,7 +229,7 @@ int create_diagnostics_archive(struct repository *r,
 	strbuf_reset(&buf);
 	strbuf_addstr(&buf, "--add-virtual-file=packs-local.txt:");
 	dir_file_stats(r->objects->backends, &buf);
-	foreach_alt_odb(dir_file_stats, &buf);
+	odb_for_each_backend(r->objects, dir_file_stats, &buf);
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
index 229e048d573..66cad14f538 100644
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
 
 static int refs_from_alternate_cb(struct odb_backend *e,
-				  void *data)
+				  void *payload)
 {
 	struct strbuf path = STRBUF_INIT;
 	size_t base_len;
-	struct alternate_refs_data *cb = data;
+	struct alternate_refs_data *cb = payload;
 
 	if (!strbuf_realpath(&path, e->path, 0))
 		goto out;
@@ -549,29 +549,31 @@ static int refs_from_alternate_cb(struct odb_backend *e,
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
+	odb_for_each_backend(odb, refs_from_alternate_cb, &data);
 }
 
-int foreach_alt_odb(alt_odb_fn fn, void *cb)
+int odb_for_each_backend(struct object_database *odb,
+			 odb_for_each_backend_fn cb, void *payload)
 {
 	struct odb_backend *backend;
 	int r = 0;
 
-	odb_prepare_alternates(the_repository->objects);
-	for (backend = the_repository->objects->backends->next; backend; backend = backend->next) {
-		r = fn(backend, cb);
+	odb_prepare_alternates(odb);
+	for (backend = odb->backends->next; backend; backend = backend->next) {
+		r = cb(backend, payload);
 		if (r)
 			break;
 	}
diff --git a/odb.h b/odb.h
index 2221af208ee..2165396a165 100644
--- a/odb.h
+++ b/odb.h
@@ -61,11 +61,6 @@ struct odb_backend {
 	char *path;
 };
 
-typedef int alt_odb_fn(struct odb_backend *, void *);
-int foreach_alt_odb(alt_odb_fn, void*);
-typedef void alternate_ref_fn(const struct object_id *oid, void *);
-void for_each_alternate_ref(alternate_ref_fn, void *);
-
 /*
  * Replace the current writable object directory with the specified temporary
  * object directory; returns the former primary object directory.
@@ -180,6 +175,24 @@ void odb_clear(struct object_database *o);
  */
 struct odb_backend *odb_find_backend(struct object_database *odb, const char *obj_dir);
 
+/*
+ * Iterate through all backends of the database and execute the provided
+ * callback function for each of them. Stop iterating once the callback
+ * function returns a non-zero value, in which case the value is bubbled up
+ * from the callback.
+ */
+typedef int odb_for_each_backend_fn(struct odb_backend *, void *);
+int odb_for_each_backend(struct object_database *odb,
+			 odb_for_each_backend_fn cb, void *payload);
+
+/*
+ * Iterate through all alternative object backends of the database and yield
+ * their respective references.
+ */
+typedef void odb_for_each_alternate_ref_fn(const struct object_id *oid, void *);
+void odb_for_each_alternate_ref(struct object_database *odb,
+				odb_for_each_alternate_ref_fn cb, void *payload);
+
 /*
  * Create a temporary file rooted in the primary object database backend's
  * directory, or die on failure. The filename is taken from "pattern", which
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
2.49.0.1045.g170613ef41.dirty


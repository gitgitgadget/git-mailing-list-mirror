Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01123132122
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 06:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749106031; cv=none; b=qTKoa10rmWLk6+8+f475RVnSTvBWGyJVVarQLoC973hzHtnBMIPYb5V1YxQsx6COkfPJUBd7SSOmvtFctjyFj74RFV03PLNOYnjf6QFa/dW+U/nL2A+fIJ4nyBAbNIxpli1HWH4pSyOsj5tYX/1ymKyBAFxqm3zVsozpbuyQuXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749106031; c=relaxed/simple;
	bh=XOicSGLUkeaqXuVnq+aFracRu1GtnWl5dgCIJnDkqwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t3j/hMbW7zVEBah2a/SJqwBzp5xqRzdgQln5mWKqUFTKX0mNNNT8mdTb7aqgikr//3HmLGgXMVQONFnrR2L4bdgRt3Dd+jhncnULo8Fa+wZQKXm7C7hbM0qyVE+5gUC+HG/OW8NKE640t0TDIFM22a6IBLunegtRWVTAXTN6Q70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ND16BNyw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nHtiZb49; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ND16BNyw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nHtiZb49"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 0E57711400ED;
	Thu,  5 Jun 2025 02:47:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 05 Jun 2025 02:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749106026;
	 x=1749192426; bh=jh6mOx/AKAPC2iU/ZwAd2iiidd8QMCR/mFtj2HBtEMM=; b=
	ND16BNywuQiPaT3x70jMS/X0YJkhPB5bNrId176Zwt08Hj9Enhmk3ftFyArkd9IQ
	hirUBjJ6K7QHVQp9yW0ydL5Y+H0zrnXaNrtMwVAVSIWxJCpqzQOyQtCX/7vH2d80
	UAYQ6E3oS3/y9SI7oWkA0n/K/9S6NSmjjjiuEvbBiFySZ8AzZEIuX0Mrvgos/E3a
	fVfp2q/5fk+HlsbN3oKun2tkWptIo53v6T/85Z3dlMKAATA4EehQ1CmX2kD2v291
	EYenk81Wg9w7VqC6owygqRYcFnMv9y7E3CGCIJAHRSdngbgF8N/IEPUmjJM8g5Eu
	Moz/JHi1/6dKtL4VvyKV6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749106026; x=
	1749192426; bh=jh6mOx/AKAPC2iU/ZwAd2iiidd8QMCR/mFtj2HBtEMM=; b=n
	HtiZb499CB/mZP1ffti6dieGVO82SuTGjoQtA3wNjLFZ44t6b3z+mbAOJqOSwxLZ
	xATMGxSCter2t8xwSS8iImlgDO3abBT9L6c21EvzkrdwBKuBSHgGU4AepguinhML
	nnqlkrZQaMse/jcvWakBIo2IDez4/sjEOaHLs7zV53hIT3tLxdICJZajINtIEu9g
	vP7ol9AKLbFHRFR/Vy5diVC4GNlbhB73/qrzz0+oLwvWixyL2grmkX7q1Fsakrxy
	rd8S5IjlDsB55ghBDS8my2Touk18JfGkp6tPxER4vY3opkrxW65eBPmjL+L0WdNZ
	R8pDReGUTm28wc8/9sqIA==
X-ME-Sender: <xms:aj1BaGQgnpKlVZD3e4T7lyN_QB0kYSJZEk6OKCSG0UMhSnPjMVUQnw>
    <xme:aj1BaLy-k1rwzsqAeh1O4LZnXmaGyXviyFu9mmd33Cy_QQi12kV_KHbDHxRdjbIw0
    rCKvY3MSVGuAvysXg>
X-ME-Received: <xmr:aj1BaD129SJxGOlZYQxfQuCz_az81ryRK9ozBV54SGayuOIMOjHL2bcNaqGKVZbD88AYR6rOKvt6PZ2aWvM8G2UBm6yNBP_1bCoCZbS78g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtth
    hopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:aj1BaCCS3ZWRltdkkaWB1wq9YST5QsE2OffqB0hvmxhz3FkK2YpLHQ>
    <xmx:aj1BaPi7Y5JAv9qKiy1E6xbIXdS4epwpraQm7MDE38LfM_SWOETbWg>
    <xmx:aj1BaOp03sgDe3c5FJZxDxvg-1rwtm8_68-mJu5gAtzW8Tl1O3CKvA>
    <xmx:aj1BaCiVF4p3jSNWfX0Fr2nLX-euIP15-4eFRI7mGjHEHINYpToYMQ>
    <xmx:aj1BaKrgZJltAjx3TfOUTq_eDHgyM6jayiI6o_aSIHLnrOVlY3-Nr1g6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 02:47:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 870a8137 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 5 Jun 2025 06:47:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Jun 2025 08:46:59 +0200
Subject: [PATCH v5 09/17] odb: get rid of `the_repository` in `for_each()`
 functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-pks-object-store-wo-the-repository-v5-9-779d1c28774b@pks.im>
References: <20250605-pks-object-store-wo-the-repository-v5-0-779d1c28774b@pks.im>
In-Reply-To: <20250605-pks-object-store-wo-the-repository-v5-0-779d1c28774b@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
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
index 58e0af433d1..f687647931e 100644
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
index 0f5958c4a66..7ea273d93e4 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -359,7 +359,8 @@ static void write_head_info(void)
 
 	refs_for_each_fullref_in(get_main_ref_store(the_repository), "",
 				 exclude_patterns, show_ref_cb, &seen);
-	for_each_alternate_ref(show_one_alternate_ref, &seen);
+	odb_for_each_alternate_ref(the_repository->objects,
+				   show_one_alternate_ref, &seen);
 
 	oidset_clear(&seen);
 	strvec_clear(&excludes_vector);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 84f7fa53424..7ca483cab52 100644
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
index ad0d5c12465..5092bf80d35 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -229,7 +229,7 @@ int create_diagnostics_archive(struct repository *r,
 	strbuf_reset(&buf);
 	strbuf_addstr(&buf, "--add-virtual-file=packs-local.txt:");
 	dir_file_stats(r->objects->sources, &buf);
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
index 42862ef7fe7..d83f7416e9e 100644
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
 
 static int refs_from_alternate_cb(struct odb_source *alternate,
-				  void *data)
+				  void *payload)
 {
 	struct strbuf path = STRBUF_INIT;
 	size_t base_len;
-	struct alternate_refs_data *cb = data;
+	struct alternate_refs_data *cb = payload;
 
 	if (!strbuf_realpath(&path, alternate->path, 0))
 		goto out;
@@ -549,29 +549,31 @@ static int refs_from_alternate_cb(struct odb_source *alternate,
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
 	struct odb_source *alternate;
 	int r = 0;
 
-	odb_prepare_alternates(the_repository->objects);
-	for (alternate = the_repository->objects->sources->next; alternate; alternate = alternate->next) {
-		r = fn(alternate, cb);
+	odb_prepare_alternates(odb);
+	for (alternate = odb->sources->next; alternate; alternate = alternate->next) {
+		r = cb(alternate, payload);
 		if (r)
 			break;
 	}
diff --git a/odb.h b/odb.h
index eba16929a81..7e65e9707c1 100644
--- a/odb.h
+++ b/odb.h
@@ -73,11 +73,6 @@ struct odb_source {
 	char *path;
 };
 
-typedef int alt_odb_fn(struct odb_source *, void *);
-int foreach_alt_odb(alt_odb_fn, void*);
-typedef void alternate_ref_fn(const struct object_id *oid, void *);
-void for_each_alternate_ref(alternate_ref_fn, void *);
-
 /*
  * Replace the current writable object directory with the specified temporary
  * object directory; returns the former primary object directory.
@@ -192,6 +187,24 @@ void odb_clear(struct object_database *o);
  */
 struct odb_source *odb_find_source(struct object_database *odb, const char *obj_dir);
 
+/*
+ * Iterate through all alternates of the database and execute the provided
+ * callback function for each of them. Stop iterating once the callback
+ * function returns a non-zero value, in which case the value is bubbled up
+ * from the callback.
+ */
+typedef int odb_for_each_alternate_fn(struct odb_source *, void *);
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
2.50.0.rc1.591.g9c95f17f64.dirty


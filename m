Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9545D202F9A
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 10:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748860050; cv=none; b=hggvfI68PULInn4FreBjSym8MO+8IS8pWuMZ7IumsC7oKrTLmrCaj8Vijsl7QRXLY7Ral22UXml97CNo/Lsmo7lXlmIOXWvmCWVCJj11adx2FrwHQ93E5aIhd5YmCB1tNEU8b7XNMntAnOOar5+ewTt+BBh7d6EH/zejZWgcJLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748860050; c=relaxed/simple;
	bh=b+ppJr7oxXuFVbjZiDkqSc8mZvCEb6RV7Rf188wa9ks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j5Y8w73u6wSDvWdfDCVUFvJRVLOCzonJT+hFM1oN4HlxR0Yi1A9MzrRiyGMUFFOhExAFreC5Mtt1NhYXP6PzRWyGZgN7ScH/t91x0TM0KirUCspTuC6Sft+EA03TPvCc4X1igOIE60HuNJx1fRaEA16WnlT7IaDOf3EVEi6JSeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RuhY1+aN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AbKZ4DfG; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RuhY1+aN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AbKZ4DfG"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 95AA92540138;
	Mon,  2 Jun 2025 06:27:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 02 Jun 2025 06:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748860047;
	 x=1748946447; bh=9H1YtWEqlHiBx1UxrcZJFVhN66ZwUkGbOjuo8mVqej4=; b=
	RuhY1+aNChS3e5K7vQsNtwjZtmdHxrZ3ojfYH6azqb5698rjWYdAaRtEyGcptt6P
	YtINljhl5vtHuz4uXKaxibUFPnLttFzA+pvT2trDWOGiQcGHd/j/UHAD2ikLXNhe
	h2sLWw6GDpDrs52/vq7nKzPoGYzzXLoaeCr88NhDL4roo6NAY1SdNjWlGpPhZh0T
	qJQIkXzcpPpa+ZRtF+MIo4kwfNRnEQXY7r/zp+nSB5gBg80FqHDv+mnRBddzdHep
	KJ2S3Do59MFlDwdUqBXYSfBAIwk2TaJjxuR9TPTRmO4cZBjDs/q64ASUYmS92hMv
	s2HRChC/pz3ETcaCDLj6GA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748860047; x=
	1748946447; bh=9H1YtWEqlHiBx1UxrcZJFVhN66ZwUkGbOjuo8mVqej4=; b=A
	bKZ4DfGTv1MITC3q8d+n4CnHjGxrzwRg5hrGII9SSVs+wRnC3lMhLUam+hdDGDO+
	7p5YvXMx57sBmgxdT3zXoxXqJcVtSVIQbz8B5ndJIXdczg2CyowGPcTkpeCBPzKS
	Nb7H1XC6IKSgnHhguZ24LVZ4nbwNVr97Ucpdvr61sAiHNK2PNtbgDaqvfovYbOTt
	SYhSe1YHQzgA9zlRZoOzQem0uriCnRy20HOsxukRr03vvPvqKquccdWXbNUpflHE
	18Dlevo4ulTQfsHeGd/SYI0ARbtqBRLX140nmeOJALwSWJCjO+fnsQLWoFGFNT14
	TEwVclyEUhGkCsWO/1bUA==
X-ME-Sender: <xms:j3w9aICg4bDSLvgoDq3cMUZkXX-mWr7tiw_zgvHtZlaKD0LG9tsJ7A>
    <xme:j3w9aKhyOkQQF-oiQQijXmG9-2cqeUsX-aMSgLw5_zfUtCG_AUNe7VT6YxoF83Khv
    K1fBeP6eI4g9WQl1A>
X-ME-Received: <xmr:j3w9aLkZJur-ShU6N4pLDz5ZlKyLbHfRhL4jAsvrg6VP61IQ9XUbtlu8FXE9vNB0rOdfHs_De6peYo1bTtBr7tYv5wweSFMiZBRTRDDoYdV0sQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefjeegfeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhoohhnsehioh
    httghlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlth
    hosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhl
    rdgtohhm
X-ME-Proxy: <xmx:j3w9aOyVxFbgyEYdOKzfy4whTq1i082jJnuqMxRE0vTYjuxmAp_vvw>
    <xmx:j3w9aNShOaqC59MfQu7g5ZZHOO2G7L4mw-efZAYx8sNT8EK1HAaXUg>
    <xmx:j3w9aJb7RMrAXrXVYoPnQr4d-wi4_NrxwpvT_fOhuQeGVw7qHI3H8w>
    <xmx:j3w9aGR0TY55myuLRNBt4j5GbmFGsYCz9eZnM-cSwp5q9vu76dCtwg>
    <xmx:j3w9aLbhnnUw84gYy13BSAe4zq0Yr8b5W3eBD_e6r353zVNWJy5EihgX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 06:27:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0f6eea79 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 2 Jun 2025 10:27:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Jun 2025 12:27:10 +0200
Subject: [PATCH v4 09/17] odb: get rid of `the_repository` in `for_each()`
 functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-pks-object-store-wo-the-repository-v4-9-e986804a7c62@pks.im>
References: <20250602-pks-object-store-wo-the-repository-v4-0-e986804a7c62@pks.im>
In-Reply-To: <20250602-pks-object-store-wo-the-repository-v4-0-e986804a7c62@pks.im>
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
index abe3d2c7a80..82ddbb71e46 100644
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
2.50.0.rc0.629.g846fc57c9e.dirty


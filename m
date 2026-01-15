Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB48C3624C4
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 11:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768475127; cv=none; b=iPO3NScCu6PvYlnVMb3cGvShcQZYAApjeqhwrtCDYYyXX9l+tpvG9KbNJOfQJqKyFcrodYikPzCG5eKEyxzLL8DhyjPO243djrbWg9WFbl+95nYP89qWxmr3t/97mOUamAwKeAbH+b4RBqC18FwVmnfCzCuOx4lxzOZYnB9hgP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768475127; c=relaxed/simple;
	bh=5HO+kLAVUB/6BDj+MPfQoCZ7EusaMSPTekiWGY29mHk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HM8nsh5oYpW3c2xj00pRea5BVrZLKmwp+mgFf5Anqihz4G0bomsRUgXyMRx/gwe27Tz/pAsu/Xo2T+6LveZLamGPO2Ca31t75JkyHkJnFYWTz8zkFfuXK+vhDO69nWfDH8d1smBCHx+KfebwuhSkn2NO18W3BHnnfuafUUTxn2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DslfbrkO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MzaZN99j; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DslfbrkO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MzaZN99j"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id C6C6B1D000E1
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 06:05:21 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 15 Jan 2026 06:05:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768475121;
	 x=1768561521; bh=zkQgekj57S/3hcmKrz7dPEhRSVwrLbon5s/MWnpIyG0=; b=
	DslfbrkOQIjN0+SfzmppbUtjCinPf1RM2T+zIv4m6KijJHmpQg62+OFVLroq0fUa
	DWMjf1AI2L39bEL8rh7J/f1TVYMf/aTWYejhGf6fySqzlzOzhf66uwBf5Gp0FUfI
	BGRyz/cGa6hEuhlbmy2BLedOrz+nyUHb53gwhCEpJ5JLjZREqmcBFXQ8enTf465o
	BH52Ictzq5D6Z16wOF4rUKAGFyQYn/bOvYnuYlutF0AQjDqumebbg6eq15D8x7LN
	0gCiP3DZiB6v6CGXSlciXszApHgB9WFQlCDt+l0fOSHQJnBhRNJdIfKNbyHfWI4V
	5GgQoY/QZeZ7HondPnvlIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768475121; x=
	1768561521; bh=zkQgekj57S/3hcmKrz7dPEhRSVwrLbon5s/MWnpIyG0=; b=M
	zaZN99jcKDoYpIpTnjydFkNySuaN2SIAlNSMolCt5oFSIYvDD9Vpmqwc+6ZWQqDt
	df/q6nJ9j7pxTp9rK3sNuvttpgzM54nf2zxoeljfhCa8kc2Y+NVIBQtQcrulbHBK
	0UOxvhVk39WbRVAcKiQ64S+t8+/+K/2HLNCeIgKGXuxXQebiUUHvhSBbxxB20AOS
	p4s7gnNbeA51jUA2kt29K5V6q9FtL3P9S5E4chKhdZx+ZwtJF3LLljT7JYwKdzSK
	KXVhldZF0cEGmFME5QUsJUdHd/qgVgUOXmnJfLXKm2u3Expsyi0iJyGfy5a0phY8
	bcgFX6X83wbrZHjP8fxoA==
X-ME-Sender: <xms:8cloaRjf4rLn5j__NckDEHoZEjT_Wp5sFaGvMvZQFM6Qv0GjdbnRmA>
    <xme:8cloac-hyB9tKeOnGvwQuZO795porvhsjh2B9Zrbr9I3LdY5FbtW8WbWSt-EdI4hf
    jWRRxuWG0I9gb0OUjjUnazB08MFv2kTvn7dp5H9bw4GdDSJnPfEzg>
X-ME-Received: <xmr:8cloaWtKw_Ky8Em_SmbwBH4xtFuNxFVXLTUppxEJ8wpmLy1QPC_dDJITFakytrvy5BqItg2QcPD931AdS4UwMor-M4pECiBwhsEqlOszOIb8kw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdehkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:8cloabZSHJ_Q9j2TdbOtGBGwAbQrZtKj8f-QMmIjAv1q634ePS75pQ>
    <xmx:8cloaeqwS-bt4dpsO9wrIX32H53mB0bDyHWJVMUux0tptfGVQy3hpQ>
    <xmx:8cloaY98j9R74Juvf6woyRDgfUKy7ytdXJdKbZvY8DArIfjzOSF53Q>
    <xmx:8cloaV-M00-JZe9npo6xHqHhS5S4VHtabQfELKrk8RzAAYnLN9RC9A>
    <xmx:8cloaai7QrudZBYbTR_NKBij4PC0XiQhfm3rOePlmyo-3ZBWGI0d8Dyn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 15 Jan 2026 06:05:21 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d21e7a4e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 15 Jan 2026 11:05:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 15 Jan 2026 12:04:39 +0100
Subject: [PATCH 10/14] treewide: drop uses of
 `for_each_{loose,packed}_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-pks-odb-for-each-object-v1-10-5418a91d5d99@pks.im>
References: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
In-Reply-To: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

We're using `for_each_loose_object()` and `for_each_packed_object()` at
a couple of callsites to enumerate all loose and packed objects,
respectively. These functions will be removed in a subsequent commit in
favor of the newly introduced `odb_source_loose_for_each_object()` and
`packfile_store_for_each_object()` replacements.

Prepare for this by refactoring the sites accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/cat-file.c | 28 ++++++++++++++++++++++------
 commit-graph.c     | 44 +++++++++++++++++++++++++++++++-------------
 2 files changed, 53 insertions(+), 19 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 6964a5a52c..7d16fbc1b8 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -806,11 +806,14 @@ struct for_each_object_payload {
 	void *payload;
 };
 
-static int batch_one_object_loose(const struct object_id *oid,
-				  const char *path UNUSED,
-				  void *_payload)
+static int batch_one_object_oi(const struct object_id *oid,
+			       struct object_info *oi,
+			       void *_payload)
 {
 	struct for_each_object_payload *payload = _payload;
+	if (oi && oi->whence == OI_PACKED)
+		return payload->callback(oid, oi->u.packed.pack, oi->u.packed.offset,
+					 payload->payload);
 	return payload->callback(oid, NULL, 0, payload->payload);
 }
 
@@ -846,8 +849,15 @@ static void batch_each_object(struct batch_options *opt,
 		.payload = _payload,
 	};
 	struct bitmap_index *bitmap = prepare_bitmap_git(the_repository);
+	struct odb_source *source;
 
-	for_each_loose_object(the_repository->objects, batch_one_object_loose, &payload, 0);
+	odb_prepare_alternates(the_repository->objects);
+	for (source = the_repository->objects->sources; source; source = source->next) {
+		int ret = odb_source_loose_for_each_object(source, NULL, batch_one_object_oi,
+							   &payload, flags);
+		if (ret)
+			break;
+	}
 
 	if (bitmap && !for_each_bitmapped_object(bitmap, &opt->objects_filter,
 						 batch_one_object_bitmapped, &payload)) {
@@ -861,8 +871,14 @@ static void batch_each_object(struct batch_options *opt,
 						&payload, flags);
 		}
 	} else {
-		for_each_packed_object(the_repository, batch_one_object_packed,
-				       &payload, flags);
+		struct object_info oi = { 0 };
+
+		for (source = the_repository->objects->sources; source; source = source->next) {
+			int ret = packfile_store_for_each_object(source->packfiles, &oi,
+								 batch_one_object_oi, &payload, flags);
+			if (ret)
+				break;
+		}
 	}
 
 	free_bitmap_index(bitmap);
diff --git a/commit-graph.c b/commit-graph.c
index 7f1145a082..a3087d7883 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1479,30 +1479,38 @@ static int write_graph_chunk_bloom_data(struct hashfile *f,
 	return 0;
 }
 
+static int add_packed_commits_oi(const struct object_id *oid,
+				 struct object_info *oi,
+				 void *data)
+{
+	struct write_commit_graph_context *ctx = (struct write_commit_graph_context*)data;
+
+	if (ctx->progress)
+		display_progress(ctx->progress, ++ctx->progress_done);
+
+	if (*oi->typep != OBJ_COMMIT)
+		return 0;
+
+	oid_array_append(&ctx->oids, oid);
+	set_commit_pos(ctx->r, oid);
+
+	return 0;
+}
+
 static int add_packed_commits(const struct object_id *oid,
 			      struct packed_git *pack,
 			      uint32_t pos,
 			      void *data)
 {
-	struct write_commit_graph_context *ctx = (struct write_commit_graph_context*)data;
 	enum object_type type;
 	off_t offset = nth_packed_object_offset(pack, pos);
 	struct object_info oi = OBJECT_INFO_INIT;
 
-	if (ctx->progress)
-		display_progress(ctx->progress, ++ctx->progress_done);
-
 	oi.typep = &type;
 	if (packed_object_info(pack, offset, &oi) < 0)
 		die(_("unable to get type of object %s"), oid_to_hex(oid));
 
-	if (type != OBJ_COMMIT)
-		return 0;
-
-	oid_array_append(&ctx->oids, oid);
-	set_commit_pos(ctx->r, oid);
-
-	return 0;
+	return add_packed_commits_oi(oid, &oi, data);
 }
 
 static void add_missing_parents(struct write_commit_graph_context *ctx, struct commit *commit)
@@ -1959,13 +1967,23 @@ static int fill_oids_from_commits(struct write_commit_graph_context *ctx,
 
 static void fill_oids_from_all_packs(struct write_commit_graph_context *ctx)
 {
+	struct odb_source *source;
+	enum object_type type;
+	struct object_info oi = {
+		.typep = &type,
+	};
+
 	if (ctx->report_progress)
 		ctx->progress = start_delayed_progress(
 			ctx->r,
 			_("Finding commits for commit graph among packed objects"),
 			ctx->approx_nr_objects);
-	for_each_packed_object(ctx->r, add_packed_commits, ctx,
-			       ODB_FOR_EACH_OBJECT_PACK_ORDER);
+
+	odb_prepare_alternates(ctx->r->objects);
+	for (source = ctx->r->objects->sources; source; source = source->next)
+		packfile_store_for_each_object(source->packfiles, &oi, add_packed_commits_oi,
+					       ctx, ODB_FOR_EACH_OBJECT_PACK_ORDER);
+
 	if (ctx->progress_done < ctx->approx_nr_objects)
 		display_progress(ctx->progress, ctx->approx_nr_objects);
 	stop_progress(&ctx->progress);

-- 
2.52.0.660.gd05f3a8ea5.dirty


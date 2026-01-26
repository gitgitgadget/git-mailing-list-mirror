Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990C832E150
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 09:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421113; cv=none; b=msCcumgVFWkfSL7Mfk+F8203zBsF6K/hTFg42PlIQjvS+AhACo6ziNivuJq2kW8J/CgJQWCmhJruNQhqIViGz20p6T9vnF92qNQmcHnwLJ30nokNq2DxTBnjVxeo/Gsq503jEb9ny4MMkaTVa87ly+NG4ezgVyiN4vjTstwX23k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421113; c=relaxed/simple;
	bh=UqCg4b8khsmM2abUOc9bmtDgCdY4wdSkxiG6aldtqZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HOTFjr/B3v0KWq8M5z1F52XgUUbVeGX6Qe/Y00aZjBzwKTNOTBm7tHLNYFKVdoV5g6dbPOKAFJuSeXOzgzM/MjGxZZr6j4UK9wonxSoz+eDIE8Ua73WnzU64gJewaESDxS6R1IwO0TjX/wn7cA+x2uzZW0uVvOsBMerWujnaPUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BieYJpJX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s2EzKzBA; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BieYJpJX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s2EzKzBA"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id BCF8D1D0005A;
	Mon, 26 Jan 2026 04:51:50 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 26 Jan 2026 04:51:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1769421110;
	 x=1769507510; bh=z6wCmRNUND0meEQ3Bi2uANuodz3zUD1Xp9WUzdNpkZ8=; b=
	BieYJpJXEOJVZ5C8K0UTPF55wJSxNLopOoxHbsE147aMz2zkQVvOhZbG2HVHo5wq
	qsU9vEpDfVvDU77/j3GM6lhKrMUupZswaypXCR8K5Rk474XjwEoujF6bA0SMZ7Hm
	sjWds91xvAxQW5PYB28Wx5nJ8dqPqrKDxMyGjSY2VWy7YVLLmVVw1ANR4xxEzJ+8
	PfJyRbdAHbJ5NX2Ni3Plfb9sUZO07++0nOo5/1pQGY1OaCPdxJl0lTneAYvrCadC
	BGQE/aHMcrW6owaHNTVU4nqlI7aejq2rMakP+jhp1D7IS82DZa680fVKzuiwzqUM
	2yKhsROx6B6UcZSDAA5eFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769421110; x=
	1769507510; bh=z6wCmRNUND0meEQ3Bi2uANuodz3zUD1Xp9WUzdNpkZ8=; b=s
	2EzKzBAm3xH+7Oyhd3WM3Khqn7/0V4zX4Eu1henEHbaKacDQxTfM9uz6ig5frlhN
	cRzZqeFplUHinqq7T6lpHP6z1kWRhgeLqk7gFR8frxdvqOQVOFojFNe2i/DQeWxU
	YL/XrSZrZXYqxMzxGFZdNWnS6etYPBIfZTSNxpHpLR/57/rwS0OxYncAo0qH2SE9
	syuFCwAaNntwG94coAIRw6g1VLr3+6HobYPsmvUaXiQUP2BXulHc7fxi3tzaIX+4
	SEcVbNAUEPs6fBjSb6vT+bVeMF5YYppVlYARH5aGYsph4FH5HC4rr2Zbix8IRElS
	P5uNol7LmaYaXnrP9HaHg==
X-ME-Sender: <xms:Njl3aaEgWdGCS4IRWoXZBAyryl0bQy1LhNjC2q8g4Ts6E4mBWMzkPQ>
    <xme:Njl3aSVL3ktqxQWrxI92iRyXkocTDtzmkyICyKNGkEquXsLnV5l-TPKZr4VBu_gi_
    Woefe9Y-tmolWYwWsOaYYjsVxWLa9vce2vpgLV0-MjV9EW2Juvesg>
X-ME-Received: <xmr:Njl3aZJKL8-79afc-Iw5XbA8Eq9g9cBtRhJR5BN3Qr0jQaivBcftotwAILT2PFKCHFjHYQScs6ZaW380Qd_SohvTEsQizlSYWAczZwDpcCbCeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheejfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeeinecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Njl3aS_62efnUJOugfYSG0cN_13-TxKck2PFU8HSRQTqw1fWT-PiIA>
    <xmx:Njl3acL1KqHNu1H23Cqh9j9GcbWgYj_X1fT2kX2pgbuL47dlk_-yKw>
    <xmx:Njl3aXk9hVHTJCx8GN9hcFgP_IUktcy94fVRfK_sOdk0uPyOF_7AHQ>
    <xmx:Njl3aQP2bIz3DnEcKjCJq5so7c1A8zb8rBXKH55Z5DAOI6H27snjTQ>
    <xmx:Njl3aUqbEHiJGzISX5_j0Tz9TMzl6RXJgMNAYjMu3Vv9gaio08Ms7lWB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 04:51:49 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 75e58d9e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Jan 2026 09:51:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 26 Jan 2026 10:51:26 +0100
Subject: [PATCH v4 10/14] treewide: drop uses of
 `for_each_{loose,packed}_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-pks-odb-for-each-object-v4-10-5a64a038c791@pks.im>
References: <20260126-pks-odb-for-each-object-v4-0-5a64a038c791@pks.im>
In-Reply-To: <20260126-pks-odb-for-each-object-v4-0-5a64a038c791@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

We're using `for_each_loose_object()` and `for_each_packed_object()` at
a couple of callsites to enumerate all loose and packed objects,
respectively. These functions will be removed in a subsequent commit in
favor of the newly introduced `odb_source_loose_for_each_object()` and
`packfile_store_for_each_object()` replacements.

Prepare for this by refactoring the sites accordingly.

Note that ideally, we'd convert all callsites to use the generic
`odb_for_each_object()` function already. But for some callers this is
not possible (yet), and it would require some significant refactorings
to make this work. Converting these site will thus be deferred to a
later patch series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/cat-file.c | 34 ++++++++++++++++++++++++++++------
 commit-graph.c     | 44 +++++++++++++++++++++++++++++++-------------
 2 files changed, 59 insertions(+), 19 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 6964a5a52c..e2c63dbedf 100644
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
 
@@ -846,8 +849,21 @@ static void batch_each_object(struct batch_options *opt,
 		.payload = _payload,
 	};
 	struct bitmap_index *bitmap = prepare_bitmap_git(the_repository);
+	struct odb_source *source;
 
-	for_each_loose_object(the_repository->objects, batch_one_object_loose, &payload, 0);
+	/*
+	 * TODO: we still need to tap into implementation details of the object
+	 * database sources. Ideally, we should extend `odb_for_each_object()`
+	 * to handle object filters itself so that we can move the filtering
+	 * logic into the individual sources.
+	 */
+	odb_prepare_alternates(the_repository->objects);
+	for (source = the_repository->objects->sources; source; source = source->next) {
+		int ret = odb_source_loose_for_each_object(source, NULL, batch_one_object_oi,
+							   &payload, flags);
+		if (ret)
+			break;
+	}
 
 	if (bitmap && !for_each_bitmapped_object(bitmap, &opt->objects_filter,
 						 batch_one_object_bitmapped, &payload)) {
@@ -861,8 +877,14 @@ static void batch_each_object(struct batch_options *opt,
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
2.53.0.rc1.267.g6e3a78c723.dirty


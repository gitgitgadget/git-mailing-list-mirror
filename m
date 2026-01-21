Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA34221FA0
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 12:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999863; cv=none; b=HCX0GUh38DGx88Kf817rFCeGdVqwyURPkM36nqnCiLTnnM9TU2DvxzUUivx+DNyQ6zrMWxzH8JtBpaG0hgB9G6a2Knr0tvbyXPDAvCwmt2q8P91Ah/+Ep+2ev7TGI7xlMfcZLPl77KWOKISx71SoKn4leZ5AM1UgNf5usB0FT78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999863; c=relaxed/simple;
	bh=Qn5337orNOeJUgdMw7xb9N9IRTflG+zn5z5EwhtHEVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mw/WQYXmwB5FGRsifq7CvuHvril/xQH0aT+SFuE0DO2hmnFGvV6KcMefO/qgwyvJY8/qhXcMcZxhgribB2gRDphjIEk5KU7/MZi2UyiI4QlSzyGW1GJF21RjJ0FphTu/4YtZso9yt/OhDX7dgHgjqdzNJzOmkBg8Fcxo9sUUZVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iE+HFgGT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PIvNRkvJ; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iE+HFgGT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PIvNRkvJ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id CBD291D00125;
	Wed, 21 Jan 2026 07:50:59 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 21 Jan 2026 07:51:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768999859;
	 x=1769086259; bh=TqRuS4IGkn/ebJ+IpNPhw2FbT1WRrK7wtrJSvz4UUgc=; b=
	iE+HFgGTGU7+MlBeY4Eng3jwGeKsjU1kYLR4PfXJpWZ3wqqW3nGfmyZxt2eRmK0K
	YkNHn5gj2ywlme9VtKmsC3qnnbnF3HxDFlVanV6oGxDuyLzCO6D5Lxd9lCICRB7p
	xAlWwoCFbVKfKFVHt6SsE6hm0zCJsNpsPnDFXQJf7HLOOr2T2h3wRbzDU4UFH1vV
	4aB7MbTj0rDMVVRNTP6xqqOa2tYq5CrG5xTq2QHRqxL7RPEZAPnZjlepdJkLbgTD
	kv2NEURg3G4HxlCFAJ8TvrlJMQ1y6RRD4YSKrADZL4hz2BxwuAwYoM98xkCo9Mqj
	2c1RQMoi89bLh0/Wvuzk3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768999859; x=
	1769086259; bh=TqRuS4IGkn/ebJ+IpNPhw2FbT1WRrK7wtrJSvz4UUgc=; b=P
	IvNRkvJt29/DGyUAYCHZpkatb8v38yYk90+w5ce0+DSwamDPGqRydHoNrJujXlqm
	GKrdqvo2CNkHUFABRfoQQrFthahLWsAfe9Jayn0NRwOCioMkZT4iuwaG3IJ1EFRc
	oYnlcdfTxUQ9ENTRbXzKf6S2z2mD7uHg3Ceuj2/7LYgJfz7l1ezSakw2TggsjWah
	xHAl8LW/E5e8Dc1wzsElR/RN4hmjPLU2QMsM3lH1CVJDdIO63cuYny7XeLQbBvf5
	HUKAVipLQa/DGReY28XBudXG/QALniwzuBmO2hXBpnzlLMU1QjAKMP0P9TAwCf5y
	/p+pJtBy7ygCPe7p6btJQ==
X-ME-Sender: <xms:s8twafquH_vi52dXkGdLPqFq6Oq34oX_ciEOKxQp8QsHP6Iy06ZQdQ>
    <xme:s8twaQrdWOH_ELy4DzEwx9qDAnOI6_6iat4UQdaZDDqS_gP1LzOwf-6LQJ0BPX6qx
    SAVWfcxWPmnUsuUhPPX8vF9UmeTyOpoAh8Vb4kG0pw1K-B4Pxrc>
X-ME-Received: <xmr:s8twaRMnj6jbVDc3GTtPuyT3PbeIjyqMlX5yvm-h-QAGFsHNnqXyTRgBf6tJQ5er8MPQVcnY6R91fVPeLPpVNhoCW9RMDlrH0NwNLBXz0xw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeffedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:s8twaRzDsrowMq3P6yv10_Ru-NXQDnK3ReK0s7Xzda8FljJy-P5n8A>
    <xmx:s8twaatweezbhwDJ57UjCOFxJ5sNyCgh86amr_jX5ghlTOIzWWL5gw>
    <xmx:s8twaa7oKEEW_jYwYLA56oKy_hdIY5uWwqmls0cOiSATRJizpJNv7w>
    <xmx:s8twaZR5ymsQEp-BoCrz5OeSHhGb66F-OZolpPOhz1YwnI-m-3-Vqg>
    <xmx:s8twaQvDD8Yq0c7IMbV1Nu15AyMs-STVj5RL3Sxo2GELbkMeIMB9YuXr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 07:50:57 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d4c7b6ee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Jan 2026 12:50:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 21 Jan 2026 13:50:26 +0100
Subject: [PATCH v3 10/14] treewide: drop uses of
 `for_each_{loose,packed}_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-pks-odb-for-each-object-v3-10-12c4dfd24227@pks.im>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
In-Reply-To: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
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
2.53.0.rc0.250.g0ac79233d6.dirty


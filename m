Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D9B44D6B0
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768922806; cv=none; b=t9dxnmxLUlzpRfeFRfNEYhZfVSX4BvFZGAAV6W8amIqsxm92j1E4mw54wC+OU8eAi8EWD0EVJmrxuMHY71bl+ZugR/WkW8c5W1Z33PIjBPEprwcOGFek8cqV4oa9HBlfv2s5slcWdxm/4PgnlVj8bIuSE6VsxCf9ZKjKTho+ewk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768922806; c=relaxed/simple;
	bh=Qn5337orNOeJUgdMw7xb9N9IRTflG+zn5z5EwhtHEVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lCn1d1ScsR7O6eduMdY8lpYhvHXPQidI8H9aXa8scWbixhAXkVSTdkYDDEMnXmpHmD3SakXTfOftG7JY9H/4NNfB35CxW5dauarsHBP4rN5ixfx7ECltQb0DcCmf7dISCsvBsMyRlLzA8DZvve0n3+8L8xY5souuo0zzNkBk8SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NJnCrvfQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GsYhH6OI; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NJnCrvfQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GsYhH6OI"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 70D5D7A00D5;
	Tue, 20 Jan 2026 10:26:43 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 20 Jan 2026 10:26:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768922803;
	 x=1769009203; bh=TqRuS4IGkn/ebJ+IpNPhw2FbT1WRrK7wtrJSvz4UUgc=; b=
	NJnCrvfQJtFEu+0CQDH+RUV3CdPeWBP/EFKiWzehQg+OU7jln3BVhP4fx6c+ibl0
	38B+4FYNZsDa3mM89NGxKoghhA58KXDnRTwHblJLqm3wIVA41cUivzBM4yV7JHgL
	QyG3hiehT7S6OSVn7zIe+QUUTz7veTmij9hBViik5vyP2iA2U3MYNGkP+3b9J9+M
	etl4tZJBcTqfc/qEtaEq1unisPk9L0UKFkwKD2hnen1yzRBBxYAz1UX+qYlyFD/T
	JxHGuG598HAhDpd2r8ot0WXdfLi2EBwx259TCSqx3bSmYz4NGamZ0Q3KLvenDI9D
	Y3yV+9BWfqQGRQhTUEdKNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768922803; x=
	1769009203; bh=TqRuS4IGkn/ebJ+IpNPhw2FbT1WRrK7wtrJSvz4UUgc=; b=G
	sYhH6OIZYL2vl+pGKt/OfYSjglRcvEk+8+vl6g4xHy6c6TEQu6/qGFtKwTPRuuqe
	5pY/ajJ8VdJ/pHfAa9zmu9aEMvttoNkL7p7TjgFYY9RFX4HO7lZ3haC76Yj8CXkf
	CGZtYL8g3OgAe0M6WiI0+TwzS4jIHv37ddqSqQ3p5fsEoFNSC12n4QrJaWp6/yUB
	k6XKqNR/7d1Cz6cWYAbqC4+bEVnXH7oMPaeR6IwzL7yvPvDoROu2HI/4zquiERL0
	Be4xRKOVIv/IUVX19ANvL+cy+6V5Cq6Lw/WP7GsV2HL++xzg5M2IeQHUrdhqKrkB
	3xmCL/XQy3rKtMWkkQ51w==
X-ME-Sender: <xms:s55vacz2U4GyQQyruTsiI5RsY8vwRGXhKAB1MQU8FK4LYLxi-0UqpQ>
    <xme:s55vaXQduk_FWHczDgTHnUIqe7wKs11rjR9W3l3XOyP7fWYWBOjaRfbfwzFYGUynr
    HpMPtUxIqtmX6vGT01ufVbnf_MpF5biL84UpRSaZAScEj8CZjTvEQ>
X-ME-Received: <xmr:s55vaTXQjlUIeOO0xyzHvY7bxpGG-xYHzT3KaiiWHondHVFr2ECwK8nijEa1XUsF19ZzY7L67GnIu4Qt17cRYqSBTvmAr4c4S1QNsxzOfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:s55vaZZS2ny9yYIBq6AKu3k04Jdt9c85Utak6MM-gMcEs4tlayyYaQ>
    <xmx:s55vaZ0jsTLNBRi_AFYhpDe_PMpWO_rFv0jdvQGhYsdhHvy5Fi5wOA>
    <xmx:s55vabiFvQQNaVSNxJ0Ff7Gx3iPRKlcdmt-a9IzVdl5kx0a2nBfCmQ>
    <xmx:s55vadZSYKj-Oq8CA-VqGIxgpNPoDZtlRiJMIeyfXSMyldlzujWm_A>
    <xmx:s55vaa1qb20rMxpb7PTuIJdfkkvweYTwmse9Zq1bGkaaJaEhIGHUG43a>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 10:26:42 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f0d57006 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Jan 2026 15:26:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 20 Jan 2026 16:26:06 +0100
Subject: [PATCH v2 10/14] treewide: drop uses of
 `for_each_{loose,packed}_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-pks-odb-for-each-object-v2-10-d05cbfd3d6f8@pks.im>
References: <20260120-pks-odb-for-each-object-v2-0-d05cbfd3d6f8@pks.im>
In-Reply-To: <20260120-pks-odb-for-each-object-v2-0-d05cbfd3d6f8@pks.im>
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


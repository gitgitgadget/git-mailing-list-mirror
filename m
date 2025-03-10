Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE52A1D5CD1
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 07:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741590813; cv=none; b=OwhoUUSrj6OfifOHBhaHjvfjUJZ/tjQXpcLI21AWxffYIy41Xd5xVpIIaS8hwmAz1iBC2YY61obq3rJcwqG3aR8Bb5MAk1+YmXQQQt498HCw8OmShsxWOTaqfVEDcjVHGEHKEC1VWZFehENLPnK30fF3BYooFpp26x6zb0vWffo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741590813; c=relaxed/simple;
	bh=HPvG6QRmFd2LxU6XlVTh08OhreRXhqgvoiQaKXz9SOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kbj8mu6o7v9mQ4EjISZdnMwTO23QlVVERnSw1xQCWqPynB+v35/y69u8ln6gZZGqQ4vrTQpzX8naQQ/50hSXiPIrFdTHGdYG281LdPIaDE5oTrKWpIuHyrKeES6siwqw7MrE65W3skOekCs3NML1pP8/aDUrcYlcpgL01tjWVcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kGqom28t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t5ig6uAH; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kGqom28t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t5ig6uAH"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id B5A8711400F8;
	Mon, 10 Mar 2025 03:13:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 10 Mar 2025 03:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741590809;
	 x=1741677209; bh=FHKn7PD/XxTVvkaeLX34P8BFoIX4bdw+RpQkUl+Mmqs=; b=
	kGqom28tqrW5lpI1C+sh2yz3OB13/K0xMX2IvEXJAEBzUFvNeZAcxLavRwiDejkE
	xyksYTu1ftdYiVRKVsygWg23bZFk98vP9E3Sfr8E+kXS3NgWTzMaThCbOoZyT0G4
	/27aaYC28IrV+HgyzdV394r2MYRUQAEa8UtWR5Z0gc/b4QpI0H8op28DJ2h/87cl
	YEmvBJatBLmg4Rxa7cuE2916Y8owdSjGu5AuM7TotwcwVFfxnqE/tp9vNWTeTur0
	MYi0pfRuHZNXFiSA/wsUJk7tOXqsf3wAqHXCDyKjFxIS8gx41MyPQ8wWZx/DeDPi
	LyXl70qp8IJLSnDprexzWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741590809; x=
	1741677209; bh=FHKn7PD/XxTVvkaeLX34P8BFoIX4bdw+RpQkUl+Mmqs=; b=t
	5ig6uAHkdTJDKXtJvygEdFAgDI0VfJcsDNHmC4hoc0pd7sV1rTLod5D3rLjLhcyW
	RxlLoZlDei6Hy2RkcErp+gSNPeBcMGJyDFzvGH0Xs+ahKx3yBY5Wyp91LrGcBnOD
	eRh8CyOX6B1h2XOeoTd9rSR1/j2iQdbBhVinhe1iQVHHz/BqGPMEZzYdAMAOHWIK
	S2DLFChN4mVcXOj1TU4IQj31W6X/w0iPwvkaEw1IwLEaCXSoEEMQuB9q/LaDGIYK
	LxWPims9LAODMWitT9z+dbLYQsCpQO7qoUQdMlDqf4YokbMzcmcMPRGPFvrsp3jG
	ziIfg3lbZlddeGoRxangw==
X-ME-Sender: <xms:GZHOZ05n3epqT5KW9fv_7L37DW5urYMmaurmIu2e2NRM32TwlhD30A>
    <xme:GZHOZ14s8xJG69p75_Ml2OdMQ_n8WgOzhiuwt9rPhGnBj6pozm03MxtF5pad4F16F
    RxORS6ehbiG2rUHsw>
X-ME-Received: <xmr:GZHOZzewbu2Yldv3IJRO7RRcuNKRw5glmTlM1e84o5MPFs8UVdsUUnMed_zaLQ62kCMGNo0gAwagySJajQAtExO343UN2XnATg_9db_DdDVO1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudekjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgr
    rhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:GZHOZ5LdCfQy6NwSpcfy26rUJCCNM18CxcA8FKKYYieQKrx0F20Iwg>
    <xmx:GZHOZ4JHIOBSjL8Ve7vO29pAvN2fxJ4clGRPxgyzOGCGG4X4pnYTWw>
    <xmx:GZHOZ6zau5aHfBTYdklUnYw3LGTfcdeN3VxWQavLanHS-6U7XQpaoA>
    <xmx:GZHOZ8I0oCUeK1qEe4ILjlYIfByTe3CLkr0J8IlWQ4V97njfULfEPQ>
    <xmx:GZHOZ9HZZs2ezVn1G_2ivCkHVOjHEMM2pi8gjHVnvezHxfml151vuOxJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 03:13:28 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c765be2c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Mar 2025 07:13:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 10 Mar 2025 08:13:21 +0100
Subject: [PATCH v4 02/12] object: stop depending on `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-b4-pks-objects-without-the-repository-v4-2-f201b8ec57ba@pks.im>
References: <20250310-b4-pks-objects-without-the-repository-v4-0-f201b8ec57ba@pks.im>
In-Reply-To: <20250310-b4-pks-objects-without-the-repository-v4-0-f201b8ec57ba@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Elijah Newren <newren@gmail.com>
X-Mailer: b4 0.14.2

There are a couple of functions exposed by "object.c" that implicitly
depend on `the_repository`. Remove this dependency by injecting the
repository via a parameter. Adapt callers accordingly by simply using
`the_repository`, except in cases where the subsystem is already free of
the repository. In that case, we instead pass the repository provided by
the caller's context.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c         |  4 ++--
 builtin/grep.c         |  2 +-
 builtin/index-pack.c   |  4 ++--
 builtin/log.c          |  2 +-
 builtin/name-rev.c     |  4 ++--
 builtin/pack-objects.c |  2 +-
 builtin/prune.c        |  2 +-
 midx-write.c           |  4 ++--
 object.c               | 21 +++++++++++----------
 object.h               | 10 ++++++----
 pack-bitmap.c          |  6 +++---
 reachable.c            |  6 +++---
 revision.c             |  3 ++-
 shallow.c              | 10 +++++-----
 upload-pack.c          | 12 ++++++------
 15 files changed, 48 insertions(+), 44 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index eea1d43647f..62c7494bbda 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -399,12 +399,12 @@ static void check_connectivity(void)
 	}
 
 	/* Look up all the requirements, warn about missing objects.. */
-	max = get_max_object_index();
+	max = get_max_object_index(the_repository);
 	if (verbose)
 		fprintf_ln(stderr, _("Checking connectivity (%d objects)"), max);
 
 	for (i = 0; i < max; i++) {
-		struct object *obj = get_indexed_object(i);
+		struct object *obj = get_indexed_object(the_repository, i);
 
 		if (obj)
 			check_object(obj);
diff --git a/builtin/grep.c b/builtin/grep.c
index d1427290f77..cbbf6f26439 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1144,7 +1144,7 @@ int cmd_grep(int argc,
 			break;
 		}
 
-		object = parse_object_or_die(&oid, arg);
+		object = parse_object_or_die(the_repository, &oid, arg);
 		if (!seen_dashdash)
 			verify_non_filename(prefix, arg);
 		add_object_array_with_path(object, arg, &list, oc.mode, oc.path);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 3eb5af20950..1268032d769 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -279,14 +279,14 @@ static unsigned check_objects(void)
 {
 	unsigned i, max, foreign_nr = 0;
 
-	max = get_max_object_index();
+	max = get_max_object_index(the_repository);
 
 	if (verbose)
 		progress = start_delayed_progress(the_repository,
 						  _("Checking objects"), max);
 
 	for (i = 0; i < max; i++) {
-		foreign_nr += check_object(get_indexed_object(i));
+		foreign_nr += check_object(get_indexed_object(the_repository, i));
 		display_progress(progress, i + 1);
 	}
 
diff --git a/builtin/log.c b/builtin/log.c
index 04a6ef97bc1..0d4c579dad7 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2468,7 +2468,7 @@ int cmd_format_patch(int argc,
 	base = get_base_commit(&cfg, list, nr);
 	if (base) {
 		reset_revision_walk();
-		clear_object_flags(UNINTERESTING);
+		clear_object_flags(the_repository, UNINTERESTING);
 		prepare_bases(&bases, base, list, nr);
 	}
 
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index beac166b5cb..2fe82c839ba 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -667,9 +667,9 @@ int cmd_name_rev(int argc,
 	} else if (all) {
 		int i, max;
 
-		max = get_max_object_index();
+		max = get_max_object_index(the_repository);
 		for (i = 0; i < max; i++) {
-			struct object *obj = get_indexed_object(i);
+			struct object *obj = get_indexed_object(the_repository, i);
 			if (!obj || obj->type != OBJ_COMMIT)
 				continue;
 			show_name(obj, NULL,
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 8e282f2a980..c3adbc94504 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4161,7 +4161,7 @@ static int mark_bitmap_preferred_tip(const char *refname,
 	if (!peel_iterated_oid(the_repository, oid, &peeled))
 		oid = &peeled;
 
-	object = parse_object_or_die(oid, refname);
+	object = parse_object_or_die(the_repository, oid, refname);
 	if (object->type == OBJ_COMMIT)
 		object->flags |= NEEDS_BITMAP;
 
diff --git a/builtin/prune.c b/builtin/prune.c
index 1c357fffd8c..8f52da8bd66 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -185,7 +185,7 @@ int cmd_prune(int argc,
 		const char *name = *argv++;
 
 		if (!repo_get_oid(the_repository, name, &oid)) {
-			struct object *object = parse_object_or_die(&oid,
+			struct object *object = parse_object_or_die(the_repository, &oid,
 								    name);
 			add_pending_object(&revs, object, "");
 		}
diff --git a/midx-write.c b/midx-write.c
index 26d9d8bb148..ac80a8298ed 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -708,7 +708,7 @@ static int add_ref_to_pending(const char *refname, const char *referent UNUSED,
 	if (!peel_iterated_oid(revs->repo, oid, &peeled))
 		oid = &peeled;
 
-	object = parse_object_or_die(oid, refname);
+	object = parse_object_or_die(revs->repo, oid, refname);
 	if (object->type != OBJ_COMMIT)
 		return 0;
 
@@ -768,7 +768,7 @@ static int read_refs_snapshot(const char *refs_snapshot,
 		if (*end)
 			die(_("malformed line: %s"), buf.buf);
 
-		object = parse_object_or_die(&oid, NULL);
+		object = parse_object_or_die(revs->repo, &oid, NULL);
 		if (preferred)
 			object->flags |= NEEDS_BITMAP;
 
diff --git a/object.c b/object.c
index 100bf9b8d12..154525a4972 100644
--- a/object.c
+++ b/object.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -18,14 +17,15 @@
 #include "commit-graph.h"
 #include "loose.h"
 
-unsigned int get_max_object_index(void)
+unsigned int get_max_object_index(const struct repository *repo)
 {
-	return the_repository->parsed_objects->obj_hash_size;
+	return repo->parsed_objects->obj_hash_size;
 }
 
-struct object *get_indexed_object(unsigned int idx)
+struct object *get_indexed_object(const struct repository *repo,
+				       unsigned int idx)
 {
-	return the_repository->parsed_objects->obj_hash[idx];
+	return repo->parsed_objects->obj_hash[idx];
 }
 
 static const char *object_type_strings[] = {
@@ -283,10 +283,11 @@ struct object *parse_object_buffer(struct repository *r, const struct object_id
 	return obj;
 }
 
-struct object *parse_object_or_die(const struct object_id *oid,
+struct object *parse_object_or_die(struct repository *repo,
+				   const struct object_id *oid,
 				   const char *name)
 {
-	struct object *o = parse_object(the_repository, oid);
+	struct object *o = parse_object(repo, oid);
 	if (o)
 		return o;
 
@@ -524,12 +525,12 @@ void object_array_remove_duplicates(struct object_array *array)
 	}
 }
 
-void clear_object_flags(unsigned flags)
+void clear_object_flags(struct repository *repo, unsigned flags)
 {
 	int i;
 
-	for (i=0; i < the_repository->parsed_objects->obj_hash_size; i++) {
-		struct object *obj = the_repository->parsed_objects->obj_hash[i];
+	for (i=0; i < repo->parsed_objects->obj_hash_size; i++) {
+		struct object *obj = repo->parsed_objects->obj_hash[i];
 		if (obj)
 			obj->flags &= ~flags;
 	}
diff --git a/object.h b/object.h
index 17f32f1103e..a3040939799 100644
--- a/object.h
+++ b/object.h
@@ -169,12 +169,13 @@ int type_from_string_gently(const char *str, ssize_t, int gentle);
 /*
  * Return the current number of buckets in the object hashmap.
  */
-unsigned int get_max_object_index(void);
+unsigned int get_max_object_index(const struct repository *repo);
 
 /*
  * Return the object from the specified bucket in the object hashmap.
  */
-struct object *get_indexed_object(unsigned int);
+struct object *get_indexed_object(const struct repository *repo,
+				       unsigned int);
 
 /*
  * This can be used to see if we have heard of the object before, but
@@ -231,7 +232,8 @@ struct object *parse_object_with_flags(struct repository *r,
  * "name" parameter is not NULL, it is included in the error message
  * (otherwise, the hex object ID is given).
  */
-struct object *parse_object_or_die(const struct object_id *oid, const char *name);
+struct object *parse_object_or_die(struct repository *repo, const struct object_id *oid,
+				   const char *name);
 
 /* Given the result of read_sha1_file(), returns the object after
  * parsing it.  eaten_p indicates if the object has a borrowed copy
@@ -336,7 +338,7 @@ void object_array_remove_duplicates(struct object_array *array);
  */
 void object_array_clear(struct object_array *array);
 
-void clear_object_flags(unsigned flags);
+void clear_object_flags(struct repository *repo, unsigned flags);
 
 /*
  * Clear the specified object flags from all in-core commit objects from
diff --git a/pack-bitmap.c b/pack-bitmap.c
index f0e2c000252..7fd78c634ef 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1301,7 +1301,7 @@ static struct bitmap *find_boundary_objects(struct bitmap_index *bitmap_git,
 	revs->tag_objects = tmp_tags;
 
 	reset_revision_walk();
-	clear_object_flags(UNINTERESTING);
+	clear_object_flags(repo, UNINTERESTING);
 
 	/*
 	 * Then add the boundary commit(s) as fill-in traversal tips.
@@ -1935,7 +1935,7 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 		struct object *object = revs->pending.objects[i].item;
 
 		if (object->type == OBJ_NONE)
-			parse_object_or_die(&object->oid, NULL);
+			parse_object_or_die(revs->repo, &object->oid, NULL);
 
 		while (object->type == OBJ_TAG) {
 			struct tag *tag = (struct tag *) object;
@@ -1945,7 +1945,7 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 			else
 				object_list_insert(object, &wants);
 
-			object = parse_object_or_die(get_tagged_oid(tag), NULL);
+			object = parse_object_or_die(revs->repo, get_tagged_oid(tag), NULL);
 			object->flags |= (tag->object.flags & UNINTERESTING);
 		}
 
diff --git a/reachable.c b/reachable.c
index 9ee04c89ec6..1b26b9b1d76 100644
--- a/reachable.c
+++ b/reachable.c
@@ -45,7 +45,7 @@ static void add_one_file(const char *path, struct rev_info *revs)
 	}
 	strbuf_trim(&buf);
 	if (!get_oid_hex(buf.buf, &oid)) {
-		object = parse_object_or_die(&oid, buf.buf);
+		object = parse_object_or_die(the_repository, &oid, buf.buf);
 		add_pending_object(revs, object, "");
 	}
 	strbuf_release(&buf);
@@ -94,7 +94,7 @@ static int add_one_ref(const char *path, const char *referent UNUSED, const stru
 		return 0;
 	}
 
-	object = parse_object_or_die(oid, path);
+	object = parse_object_or_die(the_repository, oid, path);
 	add_pending_object(revs, object, "");
 
 	return 0;
@@ -218,7 +218,7 @@ static void add_recent_object(const struct object_id *oid,
 	switch (type) {
 	case OBJ_TAG:
 	case OBJ_COMMIT:
-		obj = parse_object_or_die(oid, NULL);
+		obj = parse_object_or_die(the_repository, oid, NULL);
 		break;
 	case OBJ_TREE:
 		obj = (struct object *)lookup_tree(the_repository, oid);
diff --git a/revision.c b/revision.c
index c4390f0938c..b536c4a29ad 100644
--- a/revision.c
+++ b/revision.c
@@ -3612,7 +3612,8 @@ static void set_children(struct rev_info *revs)
 
 void reset_revision_walk(void)
 {
-	clear_object_flags(SEEN | ADDED | SHOWN | TOPO_WALK_EXPLORED | TOPO_WALK_INDEGREE);
+	clear_object_flags(the_repository,
+			   SEEN | ADDED | SHOWN | TOPO_WALK_EXPLORED | TOPO_WALK_INDEGREE);
 }
 
 static int mark_uninteresting(const struct object_id *oid,
diff --git a/shallow.c b/shallow.c
index 4bd9342c9a7..06c3266a3e0 100644
--- a/shallow.c
+++ b/shallow.c
@@ -226,7 +226,7 @@ struct commit_list *get_shallow_commits_by_rev_list(int ac, const char **av,
 	 * SHALLOW (excluded) and NOT_SHALLOW (included) should not be
 	 * set at this point. But better be safe than sorry.
 	 */
-	clear_object_flags(both_flags);
+	clear_object_flags(the_repository, both_flags);
 
 	is_repository_shallow(the_repository); /* make sure shallows are read */
 
@@ -613,9 +613,9 @@ static void paint_down(struct paint_info *info, const struct object_id *oid,
 		}
 	}
 
-	nr = get_max_object_index();
+	nr = get_max_object_index(the_repository);
 	for (i = 0; i < nr; i++) {
-		struct object *o = get_indexed_object(i);
+		struct object *o = get_indexed_object(the_repository, i);
 		if (o && o->type == OBJ_COMMIT)
 			o->flags &= ~SEEN;
 	}
@@ -675,9 +675,9 @@ void assign_shallow_commits_to_refs(struct shallow_info *info,
 	 * Prepare the commit graph to track what refs can reach what
 	 * (new) shallow commits.
 	 */
-	nr = get_max_object_index();
+	nr = get_max_object_index(the_repository);
 	for (i = 0; i < nr; i++) {
-		struct object *o = get_indexed_object(i);
+		struct object *o = get_indexed_object(the_repository, i);
 		if (!o || o->type != OBJ_COMMIT)
 			continue;
 
diff --git a/upload-pack.c b/upload-pack.c
index 728b2477fcc..7412d3c6ce8 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -662,8 +662,8 @@ static int do_reachable_revlist(struct child_process *cmd,
 
 	cmd_in = xfdopen(cmd->in, "w");
 
-	for (i = get_max_object_index(); 0 < i; ) {
-		o = get_indexed_object(--i);
+	for (i = get_max_object_index(the_repository); 0 < i; ) {
+		o = get_indexed_object(the_repository, --i);
 		if (!o)
 			continue;
 		if (reachable && o->type == OBJ_COMMIT)
@@ -731,8 +731,8 @@ static int get_reachable_list(struct upload_pack_data *data,
 			o->flags &= ~TMP_MARK;
 		}
 	}
-	for (i = get_max_object_index(); 0 < i; i--) {
-		o = get_indexed_object(i - 1);
+	for (i = get_max_object_index(the_repository); 0 < i; i--) {
+		o = get_indexed_object(the_repository, i - 1);
 		if (o && o->type == OBJ_COMMIT &&
 		    (o->flags & TMP_MARK)) {
 			add_object_array(o, NULL, reachable);
@@ -1554,7 +1554,7 @@ static int parse_want_ref(struct packet_writer *writer, const char *line,
 		}
 
 		if (!o)
-			o = parse_object_or_die(&oid, refname_nons);
+			o = parse_object_or_die(the_repository, &oid, refname_nons);
 
 		if (!(o->flags & WANTED)) {
 			o->flags |= WANTED;
@@ -1790,7 +1790,7 @@ int upload_pack_v2(struct repository *r, struct packet_reader *request)
 	enum fetch_state state = FETCH_PROCESS_ARGS;
 	struct upload_pack_data data;
 
-	clear_object_flags(ALL_FLAGS);
+	clear_object_flags(the_repository, ALL_FLAGS);
 
 	upload_pack_data_init(&data);
 	data.use_sideband = LARGE_PACKET_MAX;

-- 
2.49.0.rc1.455.g4cd33545ba.dirty


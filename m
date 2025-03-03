Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FA61F03F8
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 08:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991664; cv=none; b=RxVMkbCEyGbUqX8DeXHodVyS85Hb9OoAvh/F645wAXcWl/XqyjroijLu0hc2oEZwPp7h2JxNPjS8dEzgFDhcgW4gDQMz1inbwnFOkxzlA1p6hPizzY2YpIuy85MwLNmaaE7fQXlPZWdJ92u5w34zQSXNBx51EnD1rZuxYGokhzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991664; c=relaxed/simple;
	bh=p+NfXxA1fcVerugX/qFlHrV5t/9vrAQB4r0UO6JUh/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=laUsdE1qt+d3h5cDFxLr6mzE/o1tHG6pGmkzg+aWCdNX20JlKosjEkC+ncxoEOd1Lzpi8AWsJ0scyqU2/fPJvY7VuTS2HJUQNYgYCCoRQ30ms2uyF/seUzSIsfVsBst2bGgdVDEOAG4gAtPJ/ammYHi0P9rhuJ+WATel3BbrjNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Epjva5hk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SpxAyj7F; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Epjva5hk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SpxAyj7F"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id EAD981140100
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 03:47:38 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 03 Mar 2025 03:47:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740991658;
	 x=1741078058; bh=d3Ola0pV+IRfwvJl9dhxYtgA89yRsRWGsN6Xr2RK1rA=; b=
	Epjva5hkHPyUAT1mcpoChLuVfeifHrKqAnTo+HD0WFvTh7rG0iseO/KLzhAHUJF0
	CHdy8adGhj4DzzSU0qc9flbE5igZOh7Bdl8wpid9iSZ+UQQMCvgz3xfLQIwgsrFx
	KtrIfRaUm2pHO+fdss6RkBNmqcJGPFUoYlbTzS2hZ5+7Dhs8vLRMi6+QJH7/CMnD
	z/5bvX9qzj9dD3kXJo/gIEd+tvz/tyF+79xqrQ5sPHQ03va0p8e5RcNobr6v+bh5
	7X+R/V3QeOxxrWzQUvKXE22Nb+K82XoSFnI7+YqBBtLLXTiXABUfAYExqXwoZ0XZ
	SZ5no9VulKdbZ8vubS+NVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740991658; x=
	1741078058; bh=d3Ola0pV+IRfwvJl9dhxYtgA89yRsRWGsN6Xr2RK1rA=; b=S
	pxAyj7Frno02jzPPLbi87X+JaiCh7Bv/zAlxCt0B9LRVSEXWOtVC1MaBWlHpnCmq
	1hOBDCiIFnrV4UiNpBNJUhork4RF6tJD7lNVNLQFUIUYhfAyzXQsI3Steo6Hq/ze
	np8VY3FbWwORFHLYE96JihEqkRLpjGhMWLVPMo24JPNd5CqWJ1kie8Y/XePhQP/p
	CSf+hLhn+gv/ikkXn0d9MphCD/zKKjOx3LvVBKT7tpLUYUOX6F1bh1IX8Y159Gol
	C7tY6M0VIKgrlPB+gmyyBoYbMhr5ctVyxTgVedem61VgHKLgQroQaw+LFzQ3lMpp
	wCpsfEMMyjVsUwpdms+ug==
X-ME-Sender: <xms:qmzFZxlCzDIqdPG-3R28kfP_7LkOCsq34gmFxB6vGdnF1qWSUnXqUA>
    <xme:qmzFZ822XAlagNRChxSfw5j6dZsyeCaE8m0IIlNVOiF08pA2nLmvvofWlhKhKZmf9
    EbX1N5EFZYNfJeMxQ>
X-ME-Received: <xmr:qmzFZ3pbEosFkB6x3Ww_WPIudLEeP8kLO8vb0raTIdIrf6NBfuVjVqWJySYlLv7RVxt-QgmfnFtZySfORI0diVNmbDHxqc2UEreX9psrAZUncV2E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiud
    ejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qmzFZxn7WxoRBqqgEvBwz0wStOs--9ewt_tX9b2KxAbPkKw9-Dfb8Q>
    <xmx:qmzFZ_0jEkJB4lJUzwu0w6Ya1qKNbGzy_7DChvT7RMYjU_sXjnJKSA>
    <xmx:qmzFZws9MYI5z6griSGv_rrpiV4FD1wxs2x-7BvZPNSNJS0geUoXWg>
    <xmx:qmzFZzVxkO4gXbWw-CT8bex6hdl3PO2_6epROqpnL2nBZeywSZu1ew>
    <xmx:qmzFZ4_ww3MKZB1vREpLckHbx7l3xvalNi647j7qbE02aVrEuBTYNlHa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Mar 2025 03:47:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2813d898 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Mar 2025 08:47:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Mar 2025 09:47:31 +0100
Subject: [PATCH 02/12] object: stop depending on `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-b4-pks-objects-without-the-repository-v1-2-c5dd43f2476e@pks.im>
References: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
In-Reply-To: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
To: git@vger.kernel.org
Cc: 
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
index eea1d43647f..a441eda7ff9 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -399,12 +399,12 @@ static void check_connectivity(void)
 	}
 
 	/* Look up all the requirements, warn about missing objects.. */
-	max = get_max_object_index();
+	max = repo_get_max_object_index(the_repository);
 	if (verbose)
 		fprintf_ln(stderr, _("Checking connectivity (%d objects)"), max);
 
 	for (i = 0; i < max; i++) {
-		struct object *obj = get_indexed_object(i);
+		struct object *obj = repo_get_indexed_object(the_repository, i);
 
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
index 3eb5af20950..b8bb0ac01de 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -279,14 +279,14 @@ static unsigned check_objects(void)
 {
 	unsigned i, max, foreign_nr = 0;
 
-	max = get_max_object_index();
+	max = repo_get_max_object_index(the_repository);
 
 	if (verbose)
 		progress = start_delayed_progress(the_repository,
 						  _("Checking objects"), max);
 
 	for (i = 0; i < max; i++) {
-		foreign_nr += check_object(get_indexed_object(i));
+		foreign_nr += check_object(repo_get_indexed_object(the_repository, i));
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
index beac166b5cb..645de1cf819 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -667,9 +667,9 @@ int cmd_name_rev(int argc,
 	} else if (all) {
 		int i, max;
 
-		max = get_max_object_index();
+		max = repo_get_max_object_index(the_repository);
 		for (i = 0; i < max; i++) {
-			struct object *obj = get_indexed_object(i);
+			struct object *obj = repo_get_indexed_object(the_repository, i);
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
index 100bf9b8d12..d0a6b371b36 100644
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
+unsigned int repo_get_max_object_index(const struct repository *repo)
 {
-	return the_repository->parsed_objects->obj_hash_size;
+	return repo->parsed_objects->obj_hash_size;
 }
 
-struct object *get_indexed_object(unsigned int idx)
+struct object *repo_get_indexed_object(const struct repository *repo,
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
index 17f32f1103e..0a5293e9911 100644
--- a/object.h
+++ b/object.h
@@ -169,12 +169,13 @@ int type_from_string_gently(const char *str, ssize_t, int gentle);
 /*
  * Return the current number of buckets in the object hashmap.
  */
-unsigned int get_max_object_index(void);
+unsigned int repo_get_max_object_index(const struct repository *repo);
 
 /*
  * Return the object from the specified bucket in the object hashmap.
  */
-struct object *get_indexed_object(unsigned int);
+struct object *repo_get_indexed_object(const struct repository *repo,
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
index 4bd9342c9a7..4b11b9062af 100644
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
+	nr = repo_get_max_object_index(the_repository);
 	for (i = 0; i < nr; i++) {
-		struct object *o = get_indexed_object(i);
+		struct object *o = repo_get_indexed_object(the_repository, i);
 		if (o && o->type == OBJ_COMMIT)
 			o->flags &= ~SEEN;
 	}
@@ -675,9 +675,9 @@ void assign_shallow_commits_to_refs(struct shallow_info *info,
 	 * Prepare the commit graph to track what refs can reach what
 	 * (new) shallow commits.
 	 */
-	nr = get_max_object_index();
+	nr = repo_get_max_object_index(the_repository);
 	for (i = 0; i < nr; i++) {
-		struct object *o = get_indexed_object(i);
+		struct object *o = repo_get_indexed_object(the_repository, i);
 		if (!o || o->type != OBJ_COMMIT)
 			continue;
 
diff --git a/upload-pack.c b/upload-pack.c
index 728b2477fcc..2b37d1e28f1 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -662,8 +662,8 @@ static int do_reachable_revlist(struct child_process *cmd,
 
 	cmd_in = xfdopen(cmd->in, "w");
 
-	for (i = get_max_object_index(); 0 < i; ) {
-		o = get_indexed_object(--i);
+	for (i = repo_get_max_object_index(the_repository); 0 < i; ) {
+		o = repo_get_indexed_object(the_repository, --i);
 		if (!o)
 			continue;
 		if (reachable && o->type == OBJ_COMMIT)
@@ -731,8 +731,8 @@ static int get_reachable_list(struct upload_pack_data *data,
 			o->flags &= ~TMP_MARK;
 		}
 	}
-	for (i = get_max_object_index(); 0 < i; i--) {
-		o = get_indexed_object(i - 1);
+	for (i = repo_get_max_object_index(the_repository); 0 < i; i--) {
+		o = repo_get_indexed_object(the_repository, i - 1);
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
2.49.0.rc0.375.gae4b89d849.dirty


Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540051F4736
	for <git@vger.kernel.org>; Wed, 30 Oct 2024 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730298770; cv=none; b=JwSbL61ixqbIqw8EVNg2zeBE+UBc0BL/921LeVMJSnlFU2/8yBRs+ka2La+Y2ctUb4sobyDLEobWghXDyGZ2GiX6Gv2Cx3b8aQou3ZSFX50cACH+yncOOO55VieoSC/j1P+1nJnllkanIsyQ4RVWDedk2a7lZp6M/e0Mi8ZmotY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730298770; c=relaxed/simple;
	bh=rrPDM3IBTeVM4O5SdT6lntBJqKMMKSI/OdTI9Unb8TE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcY5NsqHEWXCTek04HQBvFsdgL70X/Z4tB2I8zM3/9dKYOEueLLCKhPlQl6xc/A0aWg4eoCj6K5zg4HtDfB5oIxDbbrZwJSkzRTWCj4sXgjnhGzdWoaRgDqFXZGxu0Y/ZFcz9NvkA+AVaPYaIa8XH5bbhXKv1ilvUPMqmi4mNXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsS8hyT/; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsS8hyT/"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a156513a1so1048231366b.0
        for <git@vger.kernel.org>; Wed, 30 Oct 2024 07:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730298766; x=1730903566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZeqUVWESexmaCjfEuP2jB+YhkYzx69eukp6NUP4AiQ=;
        b=jsS8hyT/6cqTfxdX7S8X6ZDZRDpRepAJwXdasj9HHe7FeYIl/UlW+QQ3VwbDbUX2jT
         TH11ct5vBCuiq0nRagfP470eGsqmEkglquc2TWaWcZyZ8tA+EqNZ8ApHsaTjDsXpp494
         QF1+JFsurx6oG2dsRDb3xYMdt3AcSz9+LnbfWCDphgLx1NZui/D8CtMLDRp5RYXKMw0G
         2Y5T3ZiDleA9H02BGkdASRk2RSXbinUBbfK2JkWyxLkS9HgZlw9iIZ023+xrQrl+2UWe
         bOd/MTvV1EE/2HQzssGaQGiMlaaJZ5Nvgk+zMb2UzIa5rNxVgmDP2ZoBdJqkzo2ohIQv
         ijeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730298766; x=1730903566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZeqUVWESexmaCjfEuP2jB+YhkYzx69eukp6NUP4AiQ=;
        b=ZyUvy/U90C/XJW7MQnC+atJWTH3zVgBmBMD7LR87A2VnV6Cw/bMjx8Rca14FBqGpff
         bAruz+hgBE3V7oYmbvWtALV3wzg8B/PSpVRZGjSNr/6Snrz4QTmWfHOnlV0U4AsLThN9
         cMMvNfxeqMnUQQaSqQWMdD3KqB1a81sHKtNj/Bgt5nTaCoc+49lElRWnHk69OcWwe1GU
         5ANj57Pvxp4Ld4TEQQPiZnn45rbapMYrBKO5A7luzidCqNOjTkFesxIBjq+GmhNNnuLi
         VLPp7d35hVKLvdMGCQeA9lcWUEbosQCn/R9x1lYxrBqgeJM/4xMUad+iUpimr2ba6O59
         LoDA==
X-Gm-Message-State: AOJu0YwaEoofyoJGpe/zhJFpo9AvuabVKvXP6f5T/l+ABJU4pS7hiet+
	85bcCdI8Jg23/sPTvlynNwzzyc2RWvmgIUYYBwUZqI+liUmrDES99tjAaO7M
X-Google-Smtp-Source: AGHT+IHmIYFifTtHtN2BmqySMrbwFXrHDetYA9xO4IPRoeSCa1mujO25Sm5mESRX5BvCY25D9sKKrw==
X-Received: by 2002:a17:906:dc95:b0:a99:f28f:687 with SMTP id a640c23a62f3a-a9de61d1a52mr1419620166b.40.1730298763933;
        Wed, 30 Oct 2024 07:32:43 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1dfbc7d4sm576821066b.32.2024.10.30.07.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:32:43 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com,
	peff@peff.net
Subject: [PATCH v3 6/9] packfile: pass down repository to `for_each_packed_object`
Date: Wed, 30 Oct 2024 15:32:31 +0100
Message-ID: <a5fb3b1a4a242e568a73e2895eeb8d77876b6d4c.1730297934.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730297934.git.karthik.188@gmail.com>
References: <cover.1730297934.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function `for_each_packed_object` currently relies on the global
variable `the_repository`. To eliminate global variable usage in
`packfile.c`, we should progressively shift the dependency on
the_repository to higher layers. Let's remove its usage from this
function and closely related function `is_promisor_object`.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/cat-file.c     |  7 ++++---
 builtin/fsck.c         | 18 +++++++++++-------
 builtin/pack-objects.c |  7 +++++--
 builtin/repack.c       |  2 +-
 builtin/rev-list.c     |  2 +-
 commit-graph.c         |  2 +-
 fsck.c                 |  2 +-
 list-objects.c         |  4 ++--
 object-store-ll.h      |  4 ++--
 packfile.c             | 14 +++++++-------
 packfile.h             |  2 +-
 promisor-remote.c      |  2 +-
 reachable.c            |  2 +-
 revision.c             |  9 +++++----
 tag.c                  |  2 +-
 15 files changed, 44 insertions(+), 35 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index bfdfb51c7c..d67b101c20 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -827,15 +827,16 @@ static int batch_objects(struct batch_options *opt)
 			cb.seen = &seen;
 
 			for_each_loose_object(batch_unordered_loose, &cb, 0);
-			for_each_packed_object(batch_unordered_packed, &cb,
-					       FOR_EACH_OBJECT_PACK_ORDER);
+			for_each_packed_object(the_repository, batch_unordered_packed,
+					       &cb, FOR_EACH_OBJECT_PACK_ORDER);
 
 			oidset_clear(&seen);
 		} else {
 			struct oid_array sa = OID_ARRAY_INIT;
 
 			for_each_loose_object(collect_loose_object, &sa, 0);
-			for_each_packed_object(collect_packed_object, &sa, 0);
+			for_each_packed_object(the_repository, collect_packed_object,
+					       &sa, 0);
 
 			oid_array_for_each_unique(&sa, batch_object_cb, &cb);
 
diff --git a/builtin/fsck.c b/builtin/fsck.c
index bb56eb98ac..0196c54eb6 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -150,7 +150,7 @@ static int mark_object(struct object *obj, enum object_type type,
 		return 0;
 	obj->flags |= REACHABLE;
 
-	if (is_promisor_object(&obj->oid))
+	if (is_promisor_object(the_repository, &obj->oid))
 		/*
 		 * Further recursion does not need to be performed on this
 		 * object since it is a promisor object (so it does not need to
@@ -270,7 +270,7 @@ static void check_reachable_object(struct object *obj)
 	 * do a full fsck
 	 */
 	if (!(obj->flags & HAS_OBJ)) {
-		if (is_promisor_object(&obj->oid))
+		if (is_promisor_object(the_repository, &obj->oid))
 			return;
 		if (has_object_pack(the_repository, &obj->oid))
 			return; /* it is in pack - forget about it */
@@ -391,7 +391,10 @@ static void check_connectivity(void)
 		 * traversal.
 		 */
 		for_each_loose_object(mark_loose_unreachable_referents, NULL, 0);
-		for_each_packed_object(mark_packed_unreachable_referents, NULL, 0);
+		for_each_packed_object(the_repository,
+				       mark_packed_unreachable_referents,
+				       NULL,
+				       0);
 	}
 
 	/* Look up all the requirements, warn about missing objects.. */
@@ -488,7 +491,7 @@ static void fsck_handle_reflog_oid(const char *refname, struct object_id *oid,
 						     refname, timestamp);
 			obj->flags |= USED;
 			mark_object_reachable(obj);
-		} else if (!is_promisor_object(oid)) {
+		} else if (!is_promisor_object(the_repository, oid)) {
 			error(_("%s: invalid reflog entry %s"),
 			      refname, oid_to_hex(oid));
 			errors_found |= ERROR_REACHABLE;
@@ -531,7 +534,7 @@ static int fsck_handle_ref(const char *refname, const char *referent UNUSED, con
 
 	obj = parse_object(the_repository, oid);
 	if (!obj) {
-		if (is_promisor_object(oid)) {
+		if (is_promisor_object(the_repository, oid)) {
 			/*
 			 * Increment default_refs anyway, because this is a
 			 * valid ref.
@@ -966,7 +969,8 @@ int cmd_fsck(int argc,
 
 	if (connectivity_only) {
 		for_each_loose_object(mark_loose_for_connectivity, NULL, 0);
-		for_each_packed_object(mark_packed_for_connectivity, NULL, 0);
+		for_each_packed_object(the_repository,
+				       mark_packed_for_connectivity, NULL, 0);
 	} else {
 		prepare_alt_odb(the_repository);
 		for (odb = the_repository->objects->odb; odb; odb = odb->next)
@@ -1011,7 +1015,7 @@ int cmd_fsck(int argc,
 							   &oid);
 
 			if (!obj || !(obj->flags & HAS_OBJ)) {
-				if (is_promisor_object(&oid))
+				if (is_promisor_object(the_repository, &oid))
 					continue;
 				error(_("%s: object missing"), oid_to_hex(&oid));
 				errors_found |= ERROR_OBJECT;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ceb7e76b10..755d521440 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3858,7 +3858,8 @@ static void show_object__ma_allow_promisor(struct object *obj, const char *name,
 	 * Quietly ignore EXPECTED missing objects.  This avoids problems with
 	 * staging them now and getting an odd error later.
 	 */
-	if (!has_object(the_repository, &obj->oid, 0) && is_promisor_object(&obj->oid))
+	if (!has_object(the_repository, &obj->oid, 0) &&
+	    is_promisor_object(to_pack.repo, &obj->oid))
 		return;
 
 	show_object(obj, name, data);
@@ -3927,7 +3928,9 @@ static int add_object_in_unpacked_pack(const struct object_id *oid,
 
 static void add_objects_in_unpacked_packs(void)
 {
-	if (for_each_packed_object(add_object_in_unpacked_pack, NULL,
+	if (for_each_packed_object(to_pack.repo,
+				   add_object_in_unpacked_pack,
+				   NULL,
 				   FOR_EACH_OBJECT_PACK_ORDER |
 				   FOR_EACH_OBJECT_LOCAL_ONLY |
 				   FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS |
diff --git a/builtin/repack.c b/builtin/repack.c
index d6bb37e84a..96a4fa234b 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -404,7 +404,7 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 	 * {type -> existing pack order} ordering when computing deltas instead
 	 * of a {type -> size} ordering, which may produce better deltas.
 	 */
-	for_each_packed_object(write_oid, &cmd,
+	for_each_packed_object(the_repository, write_oid, &cmd,
 			       FOR_EACH_OBJECT_PROMISOR_ONLY);
 
 	if (cmd.in == -1) {
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index f62bcbf2b1..43c42621e3 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -121,7 +121,7 @@ static inline void finish_object__ma(struct object *obj)
 		return;
 
 	case MA_ALLOW_PROMISOR:
-		if (is_promisor_object(&obj->oid))
+		if (is_promisor_object(the_repository, &obj->oid))
 			return;
 		die("unexpected missing %s object '%s'",
 		    type_name(obj->type), oid_to_hex(&obj->oid));
diff --git a/commit-graph.c b/commit-graph.c
index 83dd69bfeb..e2e2083951 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1960,7 +1960,7 @@ static void fill_oids_from_all_packs(struct write_commit_graph_context *ctx)
 		ctx->progress = start_delayed_progress(
 			_("Finding commits for commit graph among packed objects"),
 			ctx->approx_nr_objects);
-	for_each_packed_object(add_packed_commits, ctx,
+	for_each_packed_object(ctx->r, add_packed_commits, ctx,
 			       FOR_EACH_OBJECT_PACK_ORDER);
 	if (ctx->progress_done < ctx->approx_nr_objects)
 		display_progress(ctx->progress, ctx->approx_nr_objects);
diff --git a/fsck.c b/fsck.c
index 3756f52459..87ce999a49 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1295,7 +1295,7 @@ static int fsck_blobs(struct oidset *blobs_found, struct oidset *blobs_done,
 
 		buf = repo_read_object_file(the_repository, oid, &type, &size);
 		if (!buf) {
-			if (is_promisor_object(oid))
+			if (is_promisor_object(the_repository, oid))
 				continue;
 			ret |= report(options,
 				      oid, OBJ_BLOB, msg_missing,
diff --git a/list-objects.c b/list-objects.c
index 31236a8dc9..d11a389b3a 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -75,7 +75,7 @@ static void process_blob(struct traversal_context *ctx,
 	 */
 	if (ctx->revs->exclude_promisor_objects &&
 	    !repo_has_object_file(the_repository, &obj->oid) &&
-	    is_promisor_object(&obj->oid))
+	    is_promisor_object(ctx->revs->repo, &obj->oid))
 		return;
 
 	pathlen = path->len;
@@ -180,7 +180,7 @@ static void process_tree(struct traversal_context *ctx,
 		 * an incomplete list of missing objects.
 		 */
 		if (revs->exclude_promisor_objects &&
-		    is_promisor_object(&obj->oid))
+		    is_promisor_object(revs->repo, &obj->oid))
 			return;
 
 		if (!revs->do_not_die_on_missing_objects)
diff --git a/object-store-ll.h b/object-store-ll.h
index e8a22ab5fc..ce73d9a670 100644
--- a/object-store-ll.h
+++ b/object-store-ll.h
@@ -550,7 +550,7 @@ typedef int each_packed_object_fn(const struct object_id *oid,
 int for_each_object_in_pack(struct packed_git *p,
 			    each_packed_object_fn, void *data,
 			    enum for_each_object_flags flags);
-int for_each_packed_object(each_packed_object_fn, void *,
-			   enum for_each_object_flags flags);
+int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
+			   void *data, enum for_each_object_flags flags);
 
 #endif /* OBJECT_STORE_LL_H */
diff --git a/packfile.c b/packfile.c
index 3894646573..9eca5a86a7 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2200,15 +2200,15 @@ int for_each_object_in_pack(struct packed_git *p,
 	return r;
 }
 
-int for_each_packed_object(each_packed_object_fn cb, void *data,
-			   enum for_each_object_flags flags)
+int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
+			   void *data, enum for_each_object_flags flags)
 {
 	struct packed_git *p;
 	int r = 0;
 	int pack_errors = 0;
 
-	prepare_packed_git(the_repository);
-	for (p = get_all_packs(the_repository); p; p = p->next) {
+	prepare_packed_git(repo);
+	for (p = get_all_packs(repo); p; p = p->next) {
 		if ((flags & FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
 			continue;
 		if ((flags & FOR_EACH_OBJECT_PROMISOR_ONLY) &&
@@ -2286,14 +2286,14 @@ static int add_promisor_object(const struct object_id *oid,
 	return 0;
 }
 
-int is_promisor_object(const struct object_id *oid)
+int is_promisor_object(struct repository *r, const struct object_id *oid)
 {
 	static struct oidset promisor_objects;
 	static int promisor_objects_prepared;
 
 	if (!promisor_objects_prepared) {
-		if (repo_has_promisor_remote(the_repository)) {
-			for_each_packed_object(add_promisor_object,
+		if (repo_has_promisor_remote(r)) {
+			for_each_packed_object(r, add_promisor_object,
 					       &promisor_objects,
 					       FOR_EACH_OBJECT_PROMISOR_ONLY |
 					       FOR_EACH_OBJECT_PACK_ORDER);
diff --git a/packfile.h b/packfile.h
index b09fb2c530..addb95b0c4 100644
--- a/packfile.h
+++ b/packfile.h
@@ -201,7 +201,7 @@ int has_object_kept_pack(struct repository *r, const struct object_id *oid,
  * Return 1 if an object in a promisor packfile is or refers to the given
  * object, 0 otherwise.
  */
-int is_promisor_object(const struct object_id *oid);
+int is_promisor_object(struct repository *r, const struct object_id *oid);
 
 /*
  * Expose a function for fuzz testing.
diff --git a/promisor-remote.c b/promisor-remote.c
index 9345ae3db2..c714f4f007 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -283,7 +283,7 @@ void promisor_remote_get_direct(struct repository *repo,
 	}
 
 	for (i = 0; i < remaining_nr; i++) {
-		if (is_promisor_object(&remaining_oids[i]))
+		if (is_promisor_object(repo, &remaining_oids[i]))
 			die(_("could not fetch %s from promisor remote"),
 			    oid_to_hex(&remaining_oids[i]));
 	}
diff --git a/reachable.c b/reachable.c
index 09d2c50079..ecf7ccf504 100644
--- a/reachable.c
+++ b/reachable.c
@@ -324,7 +324,7 @@ int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
 	if (ignore_in_core_kept_packs)
 		flags |= FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS;
 
-	r = for_each_packed_object(add_recent_packed, &data, flags);
+	r = for_each_packed_object(revs->repo, add_recent_packed, &data, flags);
 
 done:
 	oidset_clear(&data.extra_recent_oids);
diff --git a/revision.c b/revision.c
index d1d152a67b..45dc6d2819 100644
--- a/revision.c
+++ b/revision.c
@@ -390,7 +390,8 @@ static struct object *get_reference(struct rev_info *revs, const char *name,
 	if (!object) {
 		if (revs->ignore_missing)
 			return NULL;
-		if (revs->exclude_promisor_objects && is_promisor_object(oid))
+		if (revs->exclude_promisor_objects &&
+		    is_promisor_object(revs->repo, oid))
 			return NULL;
 		if (revs->do_not_die_on_missing_objects) {
 			oidset_insert(&revs->missing_commits, oid);
@@ -432,7 +433,7 @@ static struct commit *handle_commit(struct rev_info *revs,
 			if (revs->ignore_missing_links || (flags & UNINTERESTING))
 				return NULL;
 			if (revs->exclude_promisor_objects &&
-			    is_promisor_object(&tag->tagged->oid))
+			    is_promisor_object(revs->repo, &tag->tagged->oid))
 				return NULL;
 			if (revs->do_not_die_on_missing_objects && oid) {
 				oidset_insert(&revs->missing_commits, oid);
@@ -1211,7 +1212,7 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 			     revs->do_not_die_on_missing_objects;
 		if (repo_parse_commit_gently(revs->repo, p, gently) < 0) {
 			if (revs->exclude_promisor_objects &&
-			    is_promisor_object(&p->object.oid)) {
+			    is_promisor_object(revs->repo, &p->object.oid)) {
 				if (revs->first_parent_only)
 					break;
 				continue;
@@ -3915,7 +3916,7 @@ int prepare_revision_walk(struct rev_info *revs)
 		revs->treesame.name = "treesame";
 
 	if (revs->exclude_promisor_objects) {
-		for_each_packed_object(mark_uninteresting, revs,
+		for_each_packed_object(revs->repo, mark_uninteresting, revs,
 				       FOR_EACH_OBJECT_PROMISOR_ONLY);
 	}
 
diff --git a/tag.c b/tag.c
index d24170e340..beef9571b5 100644
--- a/tag.c
+++ b/tag.c
@@ -84,7 +84,7 @@ struct object *deref_tag(struct repository *r, struct object *o, const char *war
 			o = NULL;
 		}
 	if (!o && warn) {
-		if (last_oid && is_promisor_object(last_oid))
+		if (last_oid && is_promisor_object(r, last_oid))
 			return NULL;
 		if (!warnlen)
 			warnlen = strlen(warn);
-- 
2.47.0


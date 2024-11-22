Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887621DED6E
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 10:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732270121; cv=none; b=iAl+0YPYWSYIXL7Hpom4Wdcg8ZACnlUNXG2XTMzeLIbFTM11mSvWCo6siKNq9oSatCChh4STNOX/iLuRMV8g7BImeFV2E4ElJJHenWILbHFefYfJomhPlQpe/3Rnf9VHj2lHh4TNBPruMOIXFT29glSWQO6h9DEN6vj6B5MwHIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732270121; c=relaxed/simple;
	bh=zIdSlXetUd7napztA0/A5bilEoE812jq+5bWl0/ZuYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAm+/mYryXhXg0Rsifv5KlldOhqHCa5NJWaGuVUAN28jwVyTuTXYdUHHsK3PHtUIBFoHGdltA0Xf+XsCqhfkb2yWM7zepGN5ZfJ8XyGihv73+8nfU9iv/XhGMMQJ4DQlVhPth3OwK4B+5Cp/KYGAHr6ugfSZWNzVGyaaIW5pe6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nenE6pXM; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nenE6pXM"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aaddeso2484383a12.2
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 02:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732270118; x=1732874918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcENRcyvXKGjF33VREvvZamZ516tlZezlKhCzAVlV24=;
        b=nenE6pXMil46FH/L1h4dRhPSuWX05Tz/3E1jnRk2SACeNxGNEnXlHJRBJlBlRR1H9g
         O+AymeUbm18OVkIWu+V9KAQli4EyjFKIaqjRYgbG3Ic7EgR5mOv8QULgttJRTW1xPJRs
         SbL5BEMxd4k96fzZGGra+fvefJrVqpvpAzcDKZXdio7V4qlVUH5/CJ7wpwIkqGhDoQJf
         O4WEpuAcH7v/KVDm6MGh/+s2GERybxdhfGRHMnUgl6pPW5gvgtewT6J77ilZtQ05nt26
         pQFFb2kzGF2IA2n0wXFP6QwkV63jmZL6VVdpKeNKB9sx8SFu2B7Ivitau061n6C9Pmc1
         47eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732270118; x=1732874918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcENRcyvXKGjF33VREvvZamZ516tlZezlKhCzAVlV24=;
        b=aMuOrpdvvaTesdOw0juzZ+4/Q5Rzrv0Lz0TgeghsWQr3LL4S/OsENncklHc4UzAy8m
         O9q2uqnfn/ydzHX21c34ZEHav0Gi2UbxzphdSA7mLN6t15uF1UJJRKKVFNfE3jCAzmmp
         EV/HRmwZ9BjdZ8Ic94WjPqrI2whCY150B+XX2gwKLgslvcJOTVLgZyYASTlh1AN9fJzU
         h+BrPEk4mm+K0GbUm1cWzAiW7KP94gsAv2c0UfJKpgF2yma6SqmNSxUyHCLHvVM0zUPZ
         W1TTzA2FadwQ35HENv/g0FjjhGjR74ZWJ8fSWgXHxOmS9FYGBy5QoQrN+PkzSiLsJ459
         3aGQ==
X-Gm-Message-State: AOJu0YyiBwH64oy3PURFaQOQIt62ov2yXhZTw/aDRav4SpY0mxXfCanI
	yDK5vD5YKWL2yqm55ORPZo7q9rxw1LOes2Src6yJdnaOVRMhPweN
X-Gm-Gg: ASbGncv+69xsUwaGlhOQ1ezMlG/I58et/r1h8cFd23Uj+n6/gUR9rZkOS/Q+HUTrTxP
	H2LhCNKV75XJ7C8unZNrhZnNceZB+KyXFu7RAzzoUePImlJvsuHmLcuvWnRjCa0NcE4guBxZRDW
	IJ5KlJjU79bCq+lyLBp5qOB1GGALz0swJvqoMflldlSbKXSUXS0AsaYPdk7m8VFIGEe3kLf1Skv
	BytoKx5iezn2kWqskkuUQAxJErrd/oxnQaJXZbQCARsHaAPWkKpTwKcWx3aHTk=
X-Google-Smtp-Source: AGHT+IG00OKyvyXHPjfVUiYSZjIdtzLWnDO/56PpYA6WPASPAqNGKxQRqT3dHpIJsJDYN6tLex9pTw==
X-Received: by 2002:a05:6402:5384:b0:5cf:cfa8:d6d4 with SMTP id 4fb4d7f45d1cf-5d020688691mr1769047a12.26.1732270117586;
        Fri, 22 Nov 2024 02:08:37 -0800 (PST)
Received: from localhost.localdomain ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3b0b50sm756849a12.30.2024.11.22.02.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 02:08:37 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com,
	peff@peff.net,
	gitster@pobox.com
Subject: [PATCH v8 06/10] packfile: pass down repository to `for_each_packed_object`
Date: Fri, 22 Nov 2024 11:08:25 +0100
Message-ID: <8db7094f4eeea89caab9444b197a60427526a032.1732269840.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1732269840.git.karthik.188@gmail.com>
References: <cover.1732269840.git.karthik.188@gmail.com>
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
index 0f32e92a3a..db20f0cf51 100644
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
index d46cd0e654..cd3bd5bd99 100644
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
index e7dd270217..5e8019b1fe 100644
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


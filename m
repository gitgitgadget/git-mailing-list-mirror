Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40AD1E6DE1
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504700; cv=none; b=Q2Twaieu91FrUBuh948B1GV8fEXa5FV51oCW5gaOKnuCYB941tKZKObaZX9onrO45kWrj3Rm/v2RplggBvNUsXcieTfCm2YL8rpix2TDX6qHTScyI0smRO/wQ6QDv/cX0prBCW3ZzV3IopcDwJgTCP3aUFhpqRUVODRCL29L3c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504700; c=relaxed/simple;
	bh=dwjaqQZokzR+fJC0zCR8xI24COjN1zQS5JdSgb+48sE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjdFPqiedFRVwuz2fS71GSSJAp9kDXoFKpDk+UPpwr9BS91f3nItmM0fzomR9ZgaJPLv7UTbSiOSBbndCKdS/sQ6kUBpKLysDOjB2oRELONAgR5zCfSMN9i8J8TOPrEUU+xwVmjLc1HjT7PFX9FTBcLHX1TL/2KO4r/JzoSHIrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMymjIh9; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMymjIh9"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c94c4ad9d8so5580893a12.2
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 02:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729504696; x=1730109496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fZ5KlnEKShfQCdJmmecWEjcRS7BjGIlTxJWAYZjQxw=;
        b=aMymjIh9GHNtr81mF1NnGyus4gLZrqwEESFls1gVmf4vFafQ18d1qLYLuq6WcSkJtl
         Iy1AkQVbvXbz9i+v/3Vkes7wgdvnZRCrYpfIWkwaRTvVI6YMszDDwfMPOyut4LbTIF6d
         YtvX6gLr39SwuTDy9lg3fVVJ71/WJ01UAg5t30stnHcOk3iWpeFhpMdYnWk6+4T8fzdo
         03JARfCyXbMbGJYrOZDgMRcQKqWlrri14NQUa39vvcCq2eSMYsHoePYU9hPC6NEDWtPF
         X+EJEVh4j6ojrXyk+sSRoz+46t6/cP1ANjjL3aVrLr9VUy/B0wvkC8L+cBEpqO5T3ESf
         ucPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729504696; x=1730109496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fZ5KlnEKShfQCdJmmecWEjcRS7BjGIlTxJWAYZjQxw=;
        b=OI5AaQeqDOnYyd58m3Rqc4zjvpucp3tptdJI4GyvC4Aki9pj2K7BUQd99RMAyBnFoM
         eUWAIWgwwB1QN3/qcVgz6axL/w+/4Bj3UENUje57kNkMl7Dh8/v4b91U7kTvhwkdbbi8
         Mey6mnc4KWoJMInyeuvs6eMyFduRpODDNotzafa77DuvGy6jZjK/sinMJsj+ew3Xw0E/
         jAlzwMT/iN9XAISIP2DywwFdGJSuPoymFDXFyjY/pRl6R8VAdE3tis2UsagTqmi2Yx0W
         d1Dae1pPElNTanxvVKquGSKRbXZqF9i7YGMOp8DPvAHj3Sv+MqjGjdqbzi9Nra8tF8is
         HAQQ==
X-Gm-Message-State: AOJu0YydiAeG1sRPwSTM+uwzWpTQp8k2NAkSzXa/SUeQXh7z1m0hfk3d
	72rOFQ3jWqfLoyY0EzcPNLxkQZheONj9J6fGnZCUjC8+UR7MxjQdOTZPqsC0
X-Google-Smtp-Source: AGHT+IEhIR6PPAHvnJwBa3fDa+eVvS5BkMkq04GnaQQka2Z6jG6OLu5ugHa2qutWxN0pIjGPmilA+Q==
X-Received: by 2002:a17:907:948f:b0:a99:f0d0:4ce3 with SMTP id a640c23a62f3a-a9a69a746f2mr1002562366b.17.1729504695795;
        Mon, 21 Oct 2024 02:58:15 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d631dsm187122266b.17.2024.10.21.02.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 02:58:15 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org
Subject: [PATCH 12/20] packfile: pass down repository to `has_object[_kept]_pack`
Date: Mon, 21 Oct 2024 11:57:55 +0200
Message-ID: <c74d1753ab3e06864a57eb514195463ac504ae25.1729504641.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729504640.git.karthik.188@gmail.com>
References: <cover.1729504640.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The functions `has_object[_kept]_pack` currently rely on the global
variable `the_repository`. To eliminate global variable usage in
`packfile.c`, we should progressively shift the dependency on
the_repository to higher layers. Let's remove its usage from these
functions and any related ones.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/count-objects.c | 2 +-
 builtin/fsck.c          | 2 +-
 builtin/pack-objects.c  | 4 ++--
 diff.c                  | 3 ++-
 list-objects.c          | 3 ++-
 pack-bitmap.c           | 2 +-
 packfile.c              | 9 +++++----
 packfile.h              | 5 +++--
 prune-packed.c          | 2 +-
 reachable.c             | 2 +-
 revision.c              | 4 ++--
 11 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 04d80887e0..1e89148ed7 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -67,7 +67,7 @@ static int count_loose(const struct object_id *oid, const char *path,
 	else {
 		loose_size += on_disk_bytes(st);
 		loose++;
-		if (verbose && has_object_pack(oid))
+		if (verbose && has_object_pack(the_repository, oid))
 			packed_loose++;
 	}
 	return 0;
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 7f4e2f0414..bb56eb98ac 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -272,7 +272,7 @@ static void check_reachable_object(struct object *obj)
 	if (!(obj->flags & HAS_OBJ)) {
 		if (is_promisor_object(&obj->oid))
 			return;
-		if (has_object_pack(&obj->oid))
+		if (has_object_pack(the_repository, &obj->oid))
 			return; /* it is in pack - forget about it */
 		printf_ln(_("missing %s %s"),
 			  printable_type(&obj->oid, obj->type),
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d41259a423..321e77ebf3 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1531,7 +1531,7 @@ static int want_found_object(const struct object_id *oid, int exclude,
 			return 0;
 		if (ignore_packed_keep_in_core && p->pack_keep_in_core)
 			return 0;
-		if (has_object_kept_pack(oid, flags))
+		if (has_object_kept_pack(the_repository, oid, flags))
 			return 0;
 	}
 
@@ -3629,7 +3629,7 @@ static void show_cruft_commit(struct commit *commit, void *data)
 
 static int cruft_include_check_obj(struct object *obj, void *data UNUSED)
 {
-	return !has_object_kept_pack(&obj->oid, IN_CORE_KEEP_PACKS);
+	return !has_object_kept_pack(the_repository, &obj->oid, IN_CORE_KEEP_PACKS);
 }
 
 static int cruft_include_check(struct commit *commit, void *data)
diff --git a/diff.c b/diff.c
index dceac20d18..1d483bdf37 100644
--- a/diff.c
+++ b/diff.c
@@ -4041,7 +4041,8 @@ static int reuse_worktree_file(struct index_state *istate,
 	 * objects however would tend to be slower as they need
 	 * to be individually opened and inflated.
 	 */
-	if (!FAST_WORKING_DIRECTORY && !want_file && has_object_pack(oid))
+	if (!FAST_WORKING_DIRECTORY && !want_file &&
+	    has_object_pack(the_repository, oid))
 		return 0;
 
 	/*
diff --git a/list-objects.c b/list-objects.c
index 985d008799..31236a8dc9 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -41,7 +41,8 @@ static void show_object(struct traversal_context *ctx,
 {
 	if (!ctx->show_object)
 		return;
-	if (ctx->revs->unpacked && has_object_pack(&object->oid))
+	if (ctx->revs->unpacked && has_object_pack(ctx->revs->repo,
+						   &object->oid))
 		return;
 
 	ctx->show_object(object, name, ctx->show_data);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index b699875555..97237acb24 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1891,7 +1891,7 @@ static void filter_packed_objects_from_bitmap(struct bitmap_index *bitmap_git,
 		bitmap_unset(result, i);
 
 	for (i = 0; i < eindex->count; ++i) {
-		if (has_object_pack(&eindex->objects[i]->oid))
+		if (has_object_pack(the_repository, &eindex->objects[i]->oid))
 			bitmap_unset(result, objects_nr + i);
 	}
 }
diff --git a/packfile.c b/packfile.c
index 236c5c0479..6bc7b6e9eb 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2140,16 +2140,17 @@ int find_kept_pack_entry(struct repository *r,
 	return 0;
 }
 
-int has_object_pack(const struct object_id *oid)
+int has_object_pack(struct repository *repo, const struct object_id *oid)
 {
 	struct pack_entry e;
-	return find_pack_entry(the_repository, oid, &e);
+	return find_pack_entry(repo, oid, &e);
 }
 
-int has_object_kept_pack(const struct object_id *oid, unsigned flags)
+int has_object_kept_pack(struct repository *repo, const struct object_id *oid,
+			 unsigned flags)
 {
 	struct pack_entry e;
-	return find_kept_pack_entry(the_repository, oid, flags, &e);
+	return find_kept_pack_entry(repo, oid, flags, &e);
 }
 
 int has_pack_index(struct repository *repo, const unsigned char *sha1)
diff --git a/packfile.h b/packfile.h
index 983d6df385..ec4aff63b4 100644
--- a/packfile.h
+++ b/packfile.h
@@ -200,8 +200,9 @@ const struct packed_git *has_packed_and_bad(struct repository *, const struct ob
 int find_pack_entry(struct repository *r, const struct object_id *oid, struct pack_entry *e);
 int find_kept_pack_entry(struct repository *r, const struct object_id *oid, unsigned flags, struct pack_entry *e);
 
-int has_object_pack(const struct object_id *oid);
-int has_object_kept_pack(const struct object_id *oid, unsigned flags);
+int has_object_pack(struct repository *repo, const struct object_id *oid);
+int has_object_kept_pack(struct repository *repo, const struct object_id *oid,
+			 unsigned flags);
 
 int has_pack_index(struct repository *repo, const unsigned char *sha1);
 
diff --git a/prune-packed.c b/prune-packed.c
index 2bb99c29df..d1c65ab10e 100644
--- a/prune-packed.c
+++ b/prune-packed.c
@@ -24,7 +24,7 @@ static int prune_object(const struct object_id *oid, const char *path,
 {
 	int *opts = data;
 
-	if (!has_object_pack(oid))
+	if (!has_object_pack(the_repository, oid))
 		return 0;
 
 	if (*opts & PRUNE_PACKED_DRY_RUN)
diff --git a/reachable.c b/reachable.c
index 3e9b3dd0a4..09d2c50079 100644
--- a/reachable.c
+++ b/reachable.c
@@ -239,7 +239,7 @@ static int want_recent_object(struct recent_data *data,
 			      const struct object_id *oid)
 {
 	if (data->ignore_in_core_kept_packs &&
-	    has_object_kept_pack(oid, IN_CORE_KEEP_PACKS))
+	    has_object_kept_pack(data->revs->repo, oid, IN_CORE_KEEP_PACKS))
 		return 0;
 	return 1;
 }
diff --git a/revision.c b/revision.c
index f5f5b84f2b..d1d152a67b 100644
--- a/revision.c
+++ b/revision.c
@@ -4103,10 +4103,10 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
 {
 	if (commit->object.flags & SHOWN)
 		return commit_ignore;
-	if (revs->unpacked && has_object_pack(&commit->object.oid))
+	if (revs->unpacked && has_object_pack(revs->repo, &commit->object.oid))
 		return commit_ignore;
 	if (revs->no_kept_objects) {
-		if (has_object_kept_pack(&commit->object.oid,
+		if (has_object_kept_pack(revs->repo, &commit->object.oid,
 					 revs->keep_pack_cache_flags))
 			return commit_ignore;
 	}
-- 
2.47.0


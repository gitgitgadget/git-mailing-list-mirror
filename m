Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0EF1F7083
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237054; cv=none; b=auyN7H2PCIrItSxp6+RPV5RVdBG0EZn1oNHDgzwObmnonZgmxt8Ff1HGLxEPfkLwV41EowhDAKTExDMmeffabhx00Ev85shncyUF3V6+jWP9jNYoS0ez9y4/NUzZy3F6p9HZPVLePljpS5v24Q5Em9+WrFuQum8RgTby0aLOfxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237054; c=relaxed/simple;
	bh=Mj+rxkfkzGqFGNARHi7QSVrdAtHoaziyFBU6nrXfAV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KG+K/Q5T2HHCHrfRNqbJdhlKgtw6IB78gIEUIDllnCCcX1H4eH8kQtb27iBZUc8pSrwdPvgvAxg1KYA71EkSdDQ1NDVck5eFwGa25OPED993cC8O/8QcAyYKxmSAAveNf83vN1LsFe/j5GwP+cOOi4LCDw30uePRfCqNSHhu8Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RjXyrI1f; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjXyrI1f"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa530a94c0eso905468766b.2
        for <git@vger.kernel.org>; Tue, 03 Dec 2024 06:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733237051; x=1733841851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GINt3jzfGDWDQF0QiFhtaqW1PrtHW2B4Zcs1gINi+4=;
        b=RjXyrI1fc9+n8v3N3QxDZfBw775w/LIk2h8jErZ7z7lzsqGspdzcNGhGahAeKwjADf
         ey0jz6ikWRh/RAeKbVjbntNcJEZeYgrWGz4uX4/uTSItjEYDDWlIDIfxcCOmHs0Y+kM1
         Zb5gSp9ZVm8jvcQf3i2h/vDmQqttXY6Au0A23uHzNq3OUFpjymexq35G6A7eQUDErV5k
         xWXiPCXUlsAyuBbvd02yKvouBqoaJbxC+EcKpYJNOEnRGfEI201tigdSLwg2hYCid1XA
         DjXHqfdjra/Dy/bm0lUzhAEWtF89RdnWxdCiRO9J79dcHiZEPD4jK7Io4rYpmgrWWVVT
         dBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733237051; x=1733841851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GINt3jzfGDWDQF0QiFhtaqW1PrtHW2B4Zcs1gINi+4=;
        b=cXUpDnHyI9B2WqoPrjS1QcQmc+wQiFUzJuaHXs2TLFkrotmb8qoDxzffiuJYTxuwM1
         bm+zZgYXAfXlSKuvQxnebSoowA0g9kveg22hxtzTB1HqysNH3NDpgUmou+JN08wfzx75
         sNQBRI027HIdyjP7Etx5MYcttCvG7m2hmLnSyFb8xdXhXry9xi2xipWXbkvsiY6cDCNT
         Wz2mQaA95fBb3cnS9MRzpAgsEzoRS0ben6yAxgpnpccfPLWCaKJfXHCE/3bQEjBh0kCk
         Xolip8UhdTRYauJpSgE1fdhF2hOgaBqFXPCM1Yk7t1AtwDl8EvQH5/+PiWahRcJU4BVF
         6JUA==
X-Gm-Message-State: AOJu0Yz05ttHdins8lHGUmZJH0v8VNC6gao6H7Xiv9iF1tgJyvgv3YmR
	AimhwLHqWtkn2f2d+9b/SqcU5pP0VVtmj8bgsw0xoGRUhYCc3DxS
X-Gm-Gg: ASbGncsf7tbxh9NZdU7/fNuspNzKvL8uOpHSh7y3Pms7DkKFwI+0I3PUzANY7qeVZhn
	hXsGbCqhA7JrQ35l7uAywmovGmO1fovSn9YVhnwVZGHg+ljaTks5Ku0qBwiZIuzXaltesZy6S4w
	N++mZGwaLZoHFrWB+ClacwFvDwvg0PzrVdhkw2LNlwzTGHph8lC1qktCA6GDaIZNbIiX9i8sUCB
	WFRH2vqnzhZDUcm2Pe/4KV0ajjg9ENt7W4pvs/6GqBP23arLi9IOcSAul+igrJaPyTl
X-Google-Smtp-Source: AGHT+IFlua+g5mNA9vvneSs43d+rLiCPvCWfR1FLFPqsYGnNw6GVv+xG4jrJURWkcr8Fs6M15044Yw==
X-Received: by 2002:a17:906:cc9:b0:aa5:4edb:6456 with SMTP id a640c23a62f3a-aa5f7f1159bmr216041466b.49.1733237051113;
        Tue, 03 Dec 2024 06:44:11 -0800 (PST)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996de782sm619021466b.56.2024.12.03.06.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 06:44:10 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com
Subject: [PATCH v10 05/10] packfile: pass down repository to `has_object[_kept]_pack`
Date: Tue,  3 Dec 2024 15:43:59 +0100
Message-ID: <b3fe20c8f14193cdf98701229a4244c14c7c346e.1733236936.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733236936.git.karthik.188@gmail.com>
References: <cover.1733236936.git.karthik.188@gmail.com>
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
index 0800714267..0f32e92a3a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1529,7 +1529,7 @@ static int want_found_object(const struct object_id *oid, int exclude,
 			return 0;
 		if (ignore_packed_keep_in_core && p->pack_keep_in_core)
 			return 0;
-		if (has_object_kept_pack(oid, flags))
+		if (has_object_kept_pack(p->repo, oid, flags))
 			return 0;
 	}
 
@@ -3627,7 +3627,7 @@ static void show_cruft_commit(struct commit *commit, void *data)
 
 static int cruft_include_check_obj(struct object *obj, void *data UNUSED)
 {
-	return !has_object_kept_pack(&obj->oid, IN_CORE_KEEP_PACKS);
+	return !has_object_kept_pack(to_pack.repo, &obj->oid, IN_CORE_KEEP_PACKS);
 }
 
 static int cruft_include_check(struct commit *commit, void *data)
diff --git a/diff.c b/diff.c
index dceac20d18..266ddf18e7 100644
--- a/diff.c
+++ b/diff.c
@@ -4041,7 +4041,8 @@ static int reuse_worktree_file(struct index_state *istate,
 	 * objects however would tend to be slower as they need
 	 * to be individually opened and inflated.
 	 */
-	if (!FAST_WORKING_DIRECTORY && !want_file && has_object_pack(oid))
+	if (!FAST_WORKING_DIRECTORY && !want_file &&
+	    has_object_pack(istate->repo, oid))
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
index 4fa9dfc771..d34ba9909a 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1889,7 +1889,7 @@ static void filter_packed_objects_from_bitmap(struct bitmap_index *bitmap_git,
 		bitmap_unset(result, i);
 
 	for (i = 0; i < eindex->count; ++i) {
-		if (has_object_pack(&eindex->objects[i]->oid))
+		if (has_object_pack(the_repository, &eindex->objects[i]->oid))
 			bitmap_unset(result, objects_nr + i);
 	}
 }
diff --git a/packfile.c b/packfile.c
index 1015dac6db..e7dd270217 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2143,16 +2143,17 @@ int find_kept_pack_entry(struct repository *r,
 	return 0;
 }
 
-int has_object_pack(const struct object_id *oid)
+int has_object_pack(struct repository *r, const struct object_id *oid)
 {
 	struct pack_entry e;
-	return find_pack_entry(the_repository, oid, &e);
+	return find_pack_entry(r, oid, &e);
 }
 
-int has_object_kept_pack(const struct object_id *oid, unsigned flags)
+int has_object_kept_pack(struct repository *r, const struct object_id *oid,
+			 unsigned flags)
 {
 	struct pack_entry e;
-	return find_kept_pack_entry(the_repository, oid, flags, &e);
+	return find_kept_pack_entry(r, oid, flags, &e);
 }
 
 int for_each_object_in_pack(struct packed_git *p,
diff --git a/packfile.h b/packfile.h
index 51187f2393..b09fb2c530 100644
--- a/packfile.h
+++ b/packfile.h
@@ -193,8 +193,9 @@ const struct packed_git *has_packed_and_bad(struct repository *, const struct ob
 int find_pack_entry(struct repository *r, const struct object_id *oid, struct pack_entry *e);
 int find_kept_pack_entry(struct repository *r, const struct object_id *oid, unsigned flags, struct pack_entry *e);
 
-int has_object_pack(const struct object_id *oid);
-int has_object_kept_pack(const struct object_id *oid, unsigned flags);
+int has_object_pack(struct repository *r, const struct object_id *oid);
+int has_object_kept_pack(struct repository *r, const struct object_id *oid,
+			 unsigned flags);
 
 /*
  * Return 1 if an object in a promisor packfile is or refers to the given
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
2.47.1


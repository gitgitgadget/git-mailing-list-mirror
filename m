Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416F01DDC2B
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 13:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123038; cv=none; b=u2vnMevZ4GRCRfGbiNAfaDUDApNjnHWq3au3GOwXJn0ybpPQPuP4LYa7b1yenoW4iIHd30k9gvatrEz7GD8BqlkJfjr6J+VVxSpGLe9D/CjpZI00SZ8GPkxVJmCKfkG8C1BIG9LEDe+4OFIoKvWULudkcIJ6eFP9KUea+xaFSaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123038; c=relaxed/simple;
	bh=HlVJca9WRHbA2LVAnVjlYDcwGIZ4bNtQvlJu22s6nRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tkzXRuW6hkQU+1z8nwkgnJvTV4cY+XSXa1fmk4IaGvXPcGD114bPfKofiXT8EeLaqRxGDPTu1RFQSjs68AOtrD8mzb+4NIjef4aW9nxf9NAQJTQnDmdvrejgNHrmVsqjK7CN+9fzgAF4VoVwcRDVAREhwhZEBjfSzOdGCD8qero=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivcGyw/5; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivcGyw/5"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a628b68a7so669134666b.2
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 06:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730123035; x=1730727835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHw+lGEDKSRuPBQLADGRH3+m8bVFjyRU1u2tu08Zju4=;
        b=ivcGyw/5XyA7oDz+8JYwTJqsl+sEH5yj+Yyte3P5a7Uwzi3pPcuTFBnxHiaa97+xQR
         4cN6WADqTKGCxl/Q3qEcVG79lX2hbRN9G91sOuyxCjDU7hTraX8ES1Bbd4/3Qof1beQO
         uGko2ODbVY9linnlIhVhpcKKVuKVL8N2sVv6tWkeZ2wjhNT+jqxuEE3UTlGi7pnEc8US
         /zV/tPhEPHalU+BeShn3ZrrRswoV1Y5r0FDUEpnWmJriDAnRnfR+JwOFX+oPwkO5/1Sh
         qvXXGGteetou5eul4dBWTsdG5Vl9eyaxn+cYkhQfiuidx7sQgPtmKguh8fUkLpJ7gXPb
         m35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730123035; x=1730727835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IHw+lGEDKSRuPBQLADGRH3+m8bVFjyRU1u2tu08Zju4=;
        b=H/hoLb+GU3DjJM19etP0L11ntavJQap6PUixkgXxBHmeqq+DO7NuE6ZPxGTULPINwr
         +/p/HFnXkp5WAVRp5RtFp/Y97yVRrF5FECuz65enT/338Si/ek5y/9cDDGSYXWQv3L6i
         xxd/0AXkXFiU/OJ/RVSkMTdwLc94I9Wsn0s4Dc+QTt2YkbOH2mPqJRO+dRWeebsnm9g2
         Bd+akd3H4jAOtI0K3atPm2S3JfuB7RbrBM7e3PGZRwC3wTYZw+Qq4y2AxPLV/hHzTn3C
         Kg6f8Ul+1XTgxnhS8qG8f1Tq6UpwYx2NJG+kNWQFrwlD52J8vqwddZpl0AJd9g7wI0iH
         aGJw==
X-Gm-Message-State: AOJu0YzqSmu5ewspQVIWRHskZu9jtxvCvZoNrPuMDlYrahb/iyDkNB9j
	IsjffTjVwfpKuGYuDqMh+lbb4Qm0DqrmNIY8/WUgS3NVZrYECVXK
X-Google-Smtp-Source: AGHT+IEWLX1OlIfGHAmnXDG4m07/xyK0GG50cH+sVIaVnhcHIn0UrmNlYZtU8TRsiXP5afqjbzUdjg==
X-Received: by 2002:a17:907:3f04:b0:a9a:11f5:8cd9 with SMTP id a640c23a62f3a-a9de61ea9f8mr804132866b.56.1730123034412;
        Mon, 28 Oct 2024 06:43:54 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f2971e8sm376647466b.125.2024.10.28.06.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 06:43:54 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com
Subject: [PATCH v2 5/8] packfile: pass down repository to `has_object[_kept]_pack`
Date: Mon, 28 Oct 2024 14:43:43 +0100
Message-ID: <4e883a4d1ccabb35cc6d122f23a475fca0d71ce1.1730122499.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730122499.git.karthik.188@gmail.com>
References: <cover.1730122499.git.karthik.188@gmail.com>
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
index 0800714267..2b2816c243 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1529,7 +1529,7 @@ static int want_found_object(const struct object_id *oid, int exclude,
 			return 0;
 		if (ignore_packed_keep_in_core && p->pack_keep_in_core)
 			return 0;
-		if (has_object_kept_pack(oid, flags))
+		if (has_object_kept_pack(the_repository, oid, flags))
 			return 0;
 	}
 
@@ -3627,7 +3627,7 @@ static void show_cruft_commit(struct commit *commit, void *data)
 
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
index 096a0cd6ba..c6d7ed38f6 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2143,16 +2143,17 @@ int find_kept_pack_entry(struct repository *r,
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
 
 int for_each_object_in_pack(struct packed_git *p,
diff --git a/packfile.h b/packfile.h
index 48d058699d..ac4f2210c5 100644
--- a/packfile.h
+++ b/packfile.h
@@ -193,8 +193,9 @@ const struct packed_git *has_packed_and_bad(struct repository *, const struct ob
 int find_pack_entry(struct repository *r, const struct object_id *oid, struct pack_entry *e);
 int find_kept_pack_entry(struct repository *r, const struct object_id *oid, unsigned flags, struct pack_entry *e);
 
-int has_object_pack(const struct object_id *oid);
-int has_object_kept_pack(const struct object_id *oid, unsigned flags);
+int has_object_pack(struct repository *repo, const struct object_id *oid);
+int has_object_kept_pack(struct repository *repo, const struct object_id *oid,
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
2.47.0


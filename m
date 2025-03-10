Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F30A79C4
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 01:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741571463; cv=none; b=iMe5c1tgVrrKmD+QG/QH9lSXyHtrkgcl+sfxXSeVTlVDv0qhXf5BqJ299e/fsZanMzqkh28Ahv6Is1ZsbKeWQZ/5de8ZS/00VpcSW2gN/2WvnMv8kpMtHJDQaQ5hLr0pVv4aA4hgxU/y0NjM4o/MqkiePR1KBijO3Yz0P8xkZ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741571463; c=relaxed/simple;
	bh=rrWJiDZRa62NeWIzuBayNkgL7bKmrESBgsFekn6aSTo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aalt4Ao1bu5K04GPm2IVjy9Cx2BdfD4nM+cm6tg0xTjuxy/FU36mKj+QXCsd7OuwtIhxIhYrvLoXweuNSF+b/Aegx59BW3+MS0iT8jmh8SGsCE5rNzPfIAHiWNP6ySBXpw+hzArRrXdiccLX9W8in/4EbeYW5hNvlYn5b/m8oJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9zGEBNd; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9zGEBNd"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e5b572e45cso6453636a12.0
        for <git@vger.kernel.org>; Sun, 09 Mar 2025 18:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741571458; x=1742176258; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHfJA8EakFpP4alsVHXP/A3oM0vOFjKNDNe+NK8sJOs=;
        b=P9zGEBNdMEdEGVQeFJJAaARq3e4c+uUF/Ywzlxgc3myo1hgnaLFQSoSCFyVYl9GDF1
         YqZsEMKHDvsjKS6YgQVqb8cYS4RGoxYBrUltcyqEsbfg4RB9xpum7VY+S1YnCnFgpEkB
         B7vyrFA8bZ9ldwe+mEZOz2ec7zXgQnGtSLICqe8nxoPjC4seApKITo3VWF3ghlR5+V8D
         tHnSZpulTckh1U+FY4gCGPRh7GunkfFUL1FB8RaDDTrQ+ioxrb5+sYH1zsH0XcmpAWrX
         brukUjJFSicJo5W+QZ8TZ7Y/ApfdAXHCbtU7RlT9B88HMl9pJwEw52/ooe/r/dtbqlOp
         ibrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741571458; x=1742176258;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IHfJA8EakFpP4alsVHXP/A3oM0vOFjKNDNe+NK8sJOs=;
        b=KdiRRhihdtd6zFJsxWZ7fLJVRdb62foQcCfE9CBAkfRFLcgllcR3yHiKXLb2MXlvmy
         uGesve1Sm29gLzK8aStPVU+x2ykteGj9hdBVmk54TdTtLFt7KbCUpkeZLwMeTR9xO6E+
         ZElyKZMCbbjE6I289nybSL5VT13/QCBNrSoCf3XtZukN9DgRcMtiKQUEP6LhJnYbfX06
         6JdOiPfigMS/eWmxfkhTmY7FllLFVk0aMivdxShFDIF8RBAgzUVApr9ML6q/amqSfZVU
         i8ZrEPdu2vYoN8Y5Cl7ZKSb9xzzhsvz6QXs+4POCYLsgx+Qq21pYVlcyqc4TOCkaYGWV
         ioMQ==
X-Gm-Message-State: AOJu0YzuA8xrLPLQE1QSnjqiSC7haz9U9wn4G0xGYvShSAeqxtMLyRkC
	Z3sNoCK+IOq3bK3esKJ5ynyqsDJa6BjdbVEckRbZJvQG4FHMjC2+z4olMA==
X-Gm-Gg: ASbGnctiPRZ6QjJbOCrwVDoa60++2ZZqWc103zDIL9dX6azmaMu3lnBZVcdyb90oAii
	3GoxbAR6Ofo2Sz2z1vQh1xz3bgiAn34F919z0ZGG1jmW9zyoDI0UM+aNCf/XdADMwx66363J7hV
	w9BznNpG0VdVgnoX/jD5v3wkSSPurdBZtEgqYiHTJNowX5QSWOzn0bN2cUErEZRVuxpV9gdUVn4
	r95bY85jN3zMh8wNEzBC0IhEt7UZ4FkTcDDDANeI1g62caO3ivdODWd3U1v9rOrBSjgpWAWVUTJ
	/YR08l/Dp1uAB2GCEnvw/PciTCaqk/IGha2FZPT8R/+1qQ==
X-Google-Smtp-Source: AGHT+IGimGS7ezV/3xBgr+OzONlJ62q2rL9NNf1pDlo3zeTV5vc8B8097FN4WFMrZ8UmDFJBpq7AiQ==
X-Received: by 2002:a17:907:6ea8:b0:ac2:8a59:92f4 with SMTP id a640c23a62f3a-ac28a5997fdmr515684066b.51.1741571458093;
        Sun, 09 Mar 2025 18:50:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23973a74bsm666260766b.123.2025.03.09.18.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 18:50:57 -0700 (PDT)
Message-Id: <9b31dc87bb61f4d73eced02a24baea58bc51aa5e.1741571455.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 10 Mar 2025 01:50:44 +0000
Subject: [PATCH 02/13] pack-objects: add --path-walk option
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    jonathantanmy@google.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

In order to more easily compute delta bases among objects that appear at
the exact same path, add a --path-walk option to 'git pack-objects'.

This option will use the path-walk API instead of the object walk given
by the revision machinery. Since objects will be provided in batches
representing a common path, those objects can be tested for delta bases
immediately instead of waiting for a sort of the full object list by
name-hash. This has multiple benefits, including avoiding collisions by
name-hash.

The objects marked as UNINTERESTING are included in these batches, so we
are guaranteeing some locality to find good delta bases.

After the individual passes are done on a per-path basis, the default
name-hash is used to find other opportunistic delta bases that did not
match exactly by the full path name.

The current implementation performs delta calculations while walking
objects, which is not ideal for a few reasons. First, this will cause
the "Enumerating objects" phase to be much longer than usual. Second, it
does not take advantage of threading during the path-scoped delta
calculations. Even with this lack of threading, the path-walk option is
sometimes faster than the usual approach. Future changes will refactor
this code to allow for threading, but that complexity is deferred until
later to keep this patch as simple as possible.

This new walk is incompatible with some features and is ignored by
others:

 * Object filters are not currently integrated with the path-walk API,
   such as sparse-checkout or tree depth. A blobless packfile could be
   integrated easily, but that is deferred for later.

 * Server-focused features such as delta islands, shallow packs, and
   using a bitmap index are incompatible with the path-walk API.

 * The path walk API is only compatible with the --revs option, not
   taking object lists or pack lists over stdin. These alternative ways
   to specify the objects currently ignores the --path-walk option
   without even a warning.

Future changes will create performance tests that demonstrate the power
of this approach.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-pack-objects.adoc        |  13 +-
 Documentation/technical/api-path-walk.adoc |   1 +
 builtin/pack-objects.c                     | 147 +++++++++++++++++++--
 t/t5300-pack-object.sh                     |  15 +++
 4 files changed, 166 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index 7f69ae4855f..7dbbe6d54d2 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -16,7 +16,7 @@ SYNOPSIS
 	[--cruft] [--cruft-expiration=<time>]
 	[--stdout [--filter=<filter-spec>] | <base-name>]
 	[--shallow] [--keep-true-parents] [--[no-]sparse]
-	[--name-hash-version=<n>] < <object-list>
+	[--name-hash-version=<n>] [--path-walk] < <object-list>
 
 
 DESCRIPTION
@@ -375,6 +375,17 @@ many different directories. At the moment, this version is not allowed
 when writing reachability bitmap files with `--write-bitmap-index` and it
 will be automatically changed to version `1`.
 
+--path-walk::
+	By default, `git pack-objects` walks objects in an order that
+	presents trees and blobs in an order unrelated to the path they
+	appear relative to a commit's root tree. The `--path-walk` option
+	enables a different walking algorithm that organizes trees and
+	blobs by path. This has the potential to improve delta compression
+	especially in the presence of filenames that cause collisions in
+	Git's default name-hash algorithm. Due to changing how the objects
+	are walked, this option is not compatible with `--delta-islands`,
+	`--shallow`, or `--filter`.
+
 
 DELTA ISLANDS
 -------------
diff --git a/Documentation/technical/api-path-walk.adoc b/Documentation/technical/api-path-walk.adoc
index 3e089211fb4..e522695dd9f 100644
--- a/Documentation/technical/api-path-walk.adoc
+++ b/Documentation/technical/api-path-walk.adoc
@@ -69,4 +69,5 @@ Examples
 
 See example usages in:
 	`t/helper/test-path-walk.c`,
+	`builtin/pack-objects.c`,
 	`builtin/backfill.c`
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1d0992a8dac..5596c409927 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -41,6 +41,9 @@
 #include "promisor-remote.h"
 #include "pack-mtimes.h"
 #include "parse-options.h"
+#include "blob.h"
+#include "tree.h"
+#include "path-walk.h"
 
 /*
  * Objects we are going to pack are collected in the `to_pack` structure.
@@ -217,6 +220,7 @@ static int delta_search_threads;
 static int pack_to_stdout;
 static int sparse;
 static int thin;
+static int path_walk;
 static int num_preferred_base;
 static struct progress *progress_state;
 
@@ -4188,6 +4192,105 @@ static void mark_bitmap_preferred_tips(void)
 	}
 }
 
+static inline int is_oid_interesting(struct repository *repo,
+				     struct object_id *oid)
+{
+	struct object *o = lookup_object(repo, oid);
+	return o && !(o->flags & UNINTERESTING);
+}
+
+static int add_objects_by_path(const char *path,
+			       struct oid_array *oids,
+			       enum object_type type,
+			       void *data)
+{
+	struct object_entry **delta_list;
+	size_t oe_start = to_pack.nr_objects;
+	size_t oe_end;
+	unsigned int sub_list_size;
+	unsigned int *processed = data;
+
+	/*
+	 * First, add all objects to the packing data, including the ones
+	 * marked UNINTERESTING (translated to 'exclude') as they can be
+	 * used as delta bases.
+	 */
+	for (size_t i = 0; i < oids->nr; i++) {
+		int exclude;
+		struct object_info oi = OBJECT_INFO_INIT;
+		struct object_id *oid = &oids->oid[i];
+
+		/* Skip objects that do not exist locally. */
+		if (exclude_promisor_objects &&
+		    oid_object_info_extended(the_repository, oid, &oi,
+					     OBJECT_INFO_FOR_PREFETCH) < 0)
+			continue;
+
+		exclude = !is_oid_interesting(the_repository, oid);
+
+		if (exclude && !thin)
+			continue;
+
+		add_object_entry(oid, type, path, exclude);
+	}
+
+	oe_end = to_pack.nr_objects;
+
+	/* We can skip delta calculations if it is a no-op. */
+	if (oe_end == oe_start || !window)
+		return 0;
+
+	sub_list_size = 0;
+	ALLOC_ARRAY(delta_list, oe_end - oe_start);
+
+	for (size_t i = 0; i < oe_end - oe_start; i++) {
+		struct object_entry *entry = to_pack.objects + oe_start + i;
+
+		if (!should_attempt_deltas(entry))
+			continue;
+
+		delta_list[sub_list_size++] = entry;
+	}
+
+	/*
+	 * Find delta bases among this list of objects that all match the same
+	 * path. This causes the delta compression to be interleaved in the
+	 * object walk, which can lead to confusing progress indicators. This is
+	 * also incompatible with threaded delta calculations. In the future,
+	 * consider creating a list of regions in the full to_pack.objects array
+	 * that could be picked up by the threaded delta computation.
+	 */
+	if (sub_list_size && window) {
+		QSORT(delta_list, sub_list_size, type_size_sort);
+		find_deltas(delta_list, &sub_list_size, window, depth, processed);
+	}
+
+	free(delta_list);
+	return 0;
+}
+
+static void get_object_list_path_walk(struct rev_info *revs)
+{
+	struct path_walk_info info = PATH_WALK_INFO_INIT;
+	unsigned int processed = 0;
+
+	info.revs = revs;
+	info.path_fn = add_objects_by_path;
+	info.path_fn_data = &processed;
+	revs->tag_objects = 1;
+
+	/*
+	 * Allow the --[no-]sparse option to be interesting here, if only
+	 * for testing purposes. Paths with no interesting objects will not
+	 * contribute to the resulting pack, but only create noisy preferred
+	 * base objects.
+	 */
+	info.prune_all_uninteresting = sparse;
+
+	if (walk_objects_by_path(&info))
+		die(_("failed to pack objects via path-walk"));
+}
+
 static void get_object_list(struct rev_info *revs, int ac, const char **av)
 {
 	struct setup_revision_opt s_r_opt = {
@@ -4234,7 +4337,7 @@ static void get_object_list(struct rev_info *revs, int ac, const char **av)
 
 	warn_on_object_refname_ambiguity = save_warning;
 
-	if (use_bitmap_index && !get_object_list_from_bitmap(revs))
+	if (use_bitmap_index && !path_walk && !get_object_list_from_bitmap(revs))
 		return;
 
 	if (use_delta_islands)
@@ -4243,15 +4346,19 @@ static void get_object_list(struct rev_info *revs, int ac, const char **av)
 	if (write_bitmap_index)
 		mark_bitmap_preferred_tips();
 
-	if (prepare_revision_walk(revs))
-		die(_("revision walk setup failed"));
-	mark_edges_uninteresting(revs, show_edge, sparse);
-
 	if (!fn_show_object)
 		fn_show_object = show_object;
-	traverse_commit_list(revs,
-			     show_commit, fn_show_object,
-			     NULL);
+
+	if (path_walk) {
+		get_object_list_path_walk(revs);
+	} else {
+		if (prepare_revision_walk(revs))
+			die(_("revision walk setup failed"));
+		mark_edges_uninteresting(revs, show_edge, sparse);
+		traverse_commit_list(revs,
+				show_commit, fn_show_object,
+				NULL);
+	}
 
 	if (unpack_unreachable_expiration) {
 		revs->ignore_missing_links = 1;
@@ -4461,6 +4568,8 @@ int cmd_pack_objects(int argc,
 			 N_("use the sparse reachability algorithm")),
 		OPT_BOOL(0, "thin", &thin,
 			 N_("create thin packs")),
+		OPT_BOOL(0, "path-walk", &path_walk,
+			 N_("use the path-walk API to walk objects when possible")),
 		OPT_BOOL(0, "shallow", &shallow,
 			 N_("create packs suitable for shallow fetches")),
 		OPT_BOOL(0, "honor-pack-keep", &ignore_packed_keep_on_disk,
@@ -4546,7 +4655,27 @@ int cmd_pack_objects(int argc,
 		window = 0;
 
 	strvec_push(&rp, "pack-objects");
-	if (thin) {
+
+	if (path_walk && filter_options.choice) {
+		warning(_("cannot use --filter with --path-walk"));
+		path_walk = 0;
+	}
+	if (path_walk && use_delta_islands) {
+		warning(_("cannot use delta islands with --path-walk"));
+		path_walk = 0;
+	}
+	if (path_walk && shallow) {
+		warning(_("cannot use --shallow with --path-walk"));
+		path_walk = 0;
+	}
+	if (path_walk) {
+		strvec_push(&rp, "--boundary");
+		 /*
+		  * We must disable the bitmaps because we are removing
+		  * the --objects / --objects-edge[-aggressive] options.
+		  */
+		use_bitmap_index = 0;
+	} else if (thin) {
 		use_internal_rev_list = 1;
 		strvec_push(&rp, shallow
 				? "--objects-edge-aggressive"
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 5ac8d39094b..16420d12863 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -723,4 +723,19 @@ test_expect_success '--name-hash-version=2 and --write-bitmap-index are incompat
 	! test_grep "currently, --write-bitmap-index requires --name-hash-version=1" err
 '
 
+test_expect_success '--path-walk pack everything' '
+	git -C server rev-parse HEAD >in &&
+	git -C server pack-objects --stdout --revs --path-walk <in >out.pack &&
+	git -C server index-pack --stdin <out.pack
+'
+
+test_expect_success '--path-walk thin pack' '
+	cat >in <<-EOF &&
+	$(git -C server rev-parse HEAD)
+	^$(git -C server rev-parse HEAD~2)
+	EOF
+	git -C server pack-objects --thin --stdout --revs --path-walk <in >out.pack &&
+	git -C server index-pack --fix-thin --stdin <out.pack
+'
+
 test_done
-- 
gitgitgadget


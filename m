Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B791DFE0D
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 14:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396737; cv=none; b=Fay8Zfte7NyANfi4wH884tqpcDwzApw3iAeCUnrYtuH+C0advJS3u+njNBXwbx2ecjOVRU7MIoCiyVC7+eUV0lQVjswCxu7hnbMWwkUJ29CwhRDEQaoS/FdATsRrwBjWMZ0no7IO2ZvygEysRpX440f87n1M91QZYsfnz11tYIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396737; c=relaxed/simple;
	bh=gH/98lVyPPiKwu8q/MqA+CPSSvQp8qmW1wOySMXepYw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=llm/FfJ1ITZTDLdjVgg0XlpfkexPl3HU0v4jwZk3u4ZcUMPTEc4lKJx1psw/ydeRShzEmarMt57/FlQbcYOv9KJhEsMV9cES7br/oVpb6Xc6g4dSygXa4nWfGisUtqM2nf7ykmfJpKwncMqYblPSJj5Z6tuLAS18FqrkpYLCzeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iasJJ3Jw; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iasJJ3Jw"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c915308486so478751a12.0
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 07:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728396733; x=1729001533; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZL33WxIVg/i1aIggp6yQ/0v5qyXw7yClyCM1pjCQmlc=;
        b=iasJJ3JwK0rJWhTha7moZLx1G7AKBCHMSu8lak9mVettVaA+soNRuid7rmN12HHkil
         XtdVbTlOhTUO/mPQlAVMzxjI9gg7f6BBJFVseQs8xYlkpEHQ4/Z/+nzwTt/FNdRpAeSd
         zBsP0+OdVc131FPKjteFjMvL+dRxz6hYAjpIQqEU5IvVbJfPUEhmQZeQCz1scULMlFTg
         Y/XpDRlGWrVFz2ErxMiG5hX9H8OuOAG2rps5Y16aeT0MS15bwziEpRJarYCymSyEhec6
         lYosSdQLn0zOjh/C23Wu6QkFPjKY0ozIHvGo57VabQ2VFG4/HzF7AxQVdcZjgzTFFJwt
         KGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728396733; x=1729001533;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZL33WxIVg/i1aIggp6yQ/0v5qyXw7yClyCM1pjCQmlc=;
        b=JrRnt7HhXVKhB9M4T4hmYSDZXdk4IY0bHiGXxgIjGtBl2ny1zCDL+P7VwYbYlr5bmT
         DM4O0rlMipxvJr4sRbiXoq+aWTSZh3Rok4LuHTH4SWrTPJR2qmPS83Lo2M7N6cENrCRR
         P7Ce4TFHySOrOE/LL5/rKGrspTpPXvLka1pSNAK8U9heq8kVDffjmf+QjOIZaBDIwe3q
         oITKa9olj91lvg9XeT/fzTK0BlSSlJjFb32S1z7LGniQN8aqkI7xo4Qic01P12X7c43J
         QaHNksH+2UH3cZJSC+f0LoPkrzDnLf6mjtqixigwd3/1Cq2bGy3RzP1nph6qbaNTvVXK
         onVQ==
X-Gm-Message-State: AOJu0YxoSD+Xq9RWn3yVrsBH6XBS784yW9vT4gAt/e64AZ+6QNjvYJjT
	hPR/B4+Zskj92WHJBY5SyTbnprhhCJ0Ipq1uLvpgHujLv26T1DEaVJxfrw==
X-Google-Smtp-Source: AGHT+IHwbTybGZFamT7HdC68JzCSFOMOYCS/cK6FTYdZzc2UCzfObCIW6yTSU8CP3sb1M+nDzC0tEA==
X-Received: by 2002:a05:6402:520b:b0:5c2:439d:2042 with SMTP id 4fb4d7f45d1cf-5c8d2dfbf37mr14392123a12.5.1728396732938;
        Tue, 08 Oct 2024 07:12:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05eb7f0sm4359171a12.72.2024.10.08.07.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:12:11 -0700 (PDT)
Message-Id: <f8ee11d3003e743affb39835ba3583dd2498e576.1728396724.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Oct 2024 14:11:54 +0000
Subject: [PATCH 08/17] pack-objects: add --path-walk option
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
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    christian.couder@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

In order to more easily compute delta bases among objects that appear at the
exact same path, add a --path-walk option to 'git pack-objects'.

This option will use the path-walk API instead of the object walk given by
the revision machinery. Since objects will be provided in batches
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
 Documentation/git-pack-objects.txt        |  13 +-
 Documentation/technical/api-path-walk.txt |   3 +-
 builtin/pack-objects.c                    | 147 ++++++++++++++++++++--
 t/t5300-pack-object.sh                    |  17 +++
 4 files changed, 169 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index e32404c6aae..f2fda800a43 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -15,7 +15,8 @@ SYNOPSIS
 	[--revs [--unpacked | --all]] [--keep-pack=<pack-name>]
 	[--cruft] [--cruft-expiration=<time>]
 	[--stdout [--filter=<filter-spec>] | <base-name>]
-	[--shallow] [--keep-true-parents] [--[no-]sparse] < <object-list>
+	[--shallow] [--keep-true-parents] [--[no-]sparse]
+	[--path-walk] < <object-list>
 
 
 DESCRIPTION
@@ -345,6 +346,16 @@ raise an error.
 	Restrict delta matches based on "islands". See DELTA ISLANDS
 	below.
 
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
 
 DELTA ISLANDS
 -------------
diff --git a/Documentation/technical/api-path-walk.txt b/Documentation/technical/api-path-walk.txt
index c51f92cd649..2d25281774d 100644
--- a/Documentation/technical/api-path-walk.txt
+++ b/Documentation/technical/api-path-walk.txt
@@ -69,4 +69,5 @@ Examples
 --------
 
 See example usages in:
-	`t/helper/test-path-walk.c`
+	`t/helper/test-path-walk.c`,
+	`builtin/pack-objects.c`
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 82f4ca04000..103263666f6 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -39,6 +39,9 @@
 #include "promisor-remote.h"
 #include "pack-mtimes.h"
 #include "parse-options.h"
+#include "blob.h"
+#include "tree.h"
+#include "path-walk.h"
 
 /*
  * Objects we are going to pack are collected in the `to_pack` structure.
@@ -215,6 +218,7 @@ static int delta_search_threads;
 static int pack_to_stdout;
 static int sparse;
 static int thin;
+static int path_walk;
 static int num_preferred_base;
 static struct progress *progress_state;
 
@@ -4143,6 +4147,105 @@ static void mark_bitmap_preferred_tips(void)
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
@@ -4189,7 +4292,7 @@ static void get_object_list(struct rev_info *revs, int ac, const char **av)
 
 	warn_on_object_refname_ambiguity = save_warning;
 
-	if (use_bitmap_index && !get_object_list_from_bitmap(revs))
+	if (use_bitmap_index && !path_walk && !get_object_list_from_bitmap(revs))
 		return;
 
 	if (use_delta_islands)
@@ -4198,15 +4301,19 @@ static void get_object_list(struct rev_info *revs, int ac, const char **av)
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
@@ -4404,6 +4511,8 @@ int cmd_pack_objects(int argc,
 			 N_("use the sparse reachability algorithm")),
 		OPT_BOOL(0, "thin", &thin,
 			 N_("create thin packs")),
+		OPT_BOOL(0, "path-walk", &path_walk,
+			 N_("use the path-walk API to walk objects when possible")),
 		OPT_BOOL(0, "shallow", &shallow,
 			 N_("create packs suitable for shallow fetches")),
 		OPT_BOOL(0, "honor-pack-keep", &ignore_packed_keep_on_disk,
@@ -4484,7 +4593,27 @@ int cmd_pack_objects(int argc,
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
index 3b9dae331a5..5f6914acae7 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -674,4 +674,21 @@ do
 	'
 done
 
+# Basic "repack everything" test
+test_expect_success '--path-walk pack everything' '
+	git -C server rev-parse HEAD >in &&
+	git -C server pack-objects --stdout --revs --path-walk <in >out.pack &&
+	git -C server index-pack --stdin <out.pack
+'
+
+# Basic "thin pack" test
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


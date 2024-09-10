Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DFF17DFE9
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 02:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935361; cv=none; b=TA8sgvF0rOFVDNk+rY9If4a6yNBa3f2+Bocp4q+9sXtYESshdeo5BAAF9KbPAE1OIXI7OU6ZqRvXnOIeiUngSXN3+20VP/+gZNdanpJYq5VQR2zBf3rKHxadMZ5NENtscX/imOB6bnuinqSDQ6iLWRLHHhDBkS0Qn/mPPbf70LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935361; c=relaxed/simple;
	bh=CWAdBslJWl6GFvz/RSbl236IaaskIQhXAcQ7O7ETmuA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WiCGFRCrt7VaV7Y3SA3Kw4njtvpfWxLwsuReju0TQuA3zNc6BGqkmJLCVjPFZKaz9H0IfXm0ESgyVB24b4pBkxJQRQatNfjr8EOK//DcT5pqUc/yAFFR2H+El+9axvcUPNSK62+1x9J6yQoEy5OpS0khfMQhgJ7rmp+dJmXyPjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPLSlpUc; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPLSlpUc"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7a843bef98so292835066b.2
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 19:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725935358; x=1726540158; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiaOfXbbtucRsfMahbpSduQIJc1ySiE1ouyPD34VKro=;
        b=IPLSlpUc2Su7bfIsiffRqUfiChsxw0ZIbpiE8fj8GOnVYAWgeMtrXl4meOx24R+Hic
         0ZytJh2I8GcLZIRLMhnbeMtzLOuQ6Kc4nZmkldw6yCi4H4fnP931SQyAYMgdUBW9ZcxU
         v2+0b1NL1tiS9SJh4iGJih6tpl8wVs6kdHAwtlhFSEn827SXlFCONCfc5VBWNrI//8e2
         a+J01JvF4BgbOEcVWJS7C0Eh1Ufyv2DpoP0oHVwpXEMpOSC6Em0+RNiqbEuNmDadixNF
         itvF2lCSYjds5k300p88F3nmiBStcMYUKhpsw9xJqFOcILljaBz7tEn03tzEsMNezrrU
         A0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725935358; x=1726540158;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OiaOfXbbtucRsfMahbpSduQIJc1ySiE1ouyPD34VKro=;
        b=ZxNCpC+dvoL2sIGsuHacFDYYCTBHkhImH0IUXUa9dt6TsYZTnefjohHiL9yDhJbXkz
         gweAeWgTWwgglEHevrXIYIZuCadM7gw9rVb1RsA2PlJPfWFg0rnKeM229e9H2fFvyqCy
         IdTNC85jpHDhWAKxwRn8tPppezCmYMx9hNz0CWbW+n7D15kDG4rbavr2rkHsZb0Iw4qv
         BgJs3TTM+q2oDf0VsBIzgSF4NF0AHWWl7zHbc3kH15Opbq/jqdSDQvZs2iTRs5B4a6jZ
         E2P7lAVQFnMVtNKU+uDzdnQJqnzRXLTv4Re+TaSC7RTTs9S+gEkOMOSgpicfHQIhKWas
         Fv8w==
X-Gm-Message-State: AOJu0Yx/5ezxoXXpRWL1r+aYmK2xW9BPLK/49B0skFBw+4szZBQmrgyC
	waTqg9ZRc9mjGRt7O81L2ZnEcgt3WLtZs8yZrK4oN/icxfHLTV1110O1kg==
X-Google-Smtp-Source: AGHT+IEo6uUPXmIn00qP6nwTPVwLJv0/oEoFSzrCmXEPU16B+y6gzPAcm/+MXhP3r2E3wDIp7+QSpA==
X-Received: by 2002:a17:906:da85:b0:a7a:9f0f:ab2c with SMTP id a640c23a62f3a-a8a8866090amr1175665166b.29.1725935357536;
        Mon, 09 Sep 2024 19:29:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25a073b1sm412734866b.82.2024.09.09.19.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 19:29:16 -0700 (PDT)
Message-Id: <3455af21e1bea375f38d21cc3b1d718ca6e563e4.1725935335.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
References: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Sep 2024 02:28:45 +0000
Subject: [PATCH 20/30] pack-objects: add --path-walk option
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

RFC TODO: It is important to note that this option is inherently
incompatible with using a bitmap index. This walk probably also does not
work with other advanced features, such as delta islands.

Getting ahead of myself, this option compares well with --full-name-hash
when the packfile is large enough, but also performs at least as well as
the default in all cases that I've seen.

RFC TODO: this should probably be recording the batch locations to another
list so they could be processed in a second phase using threads.

RFC TODO: list some examples of how this outperforms previous pack-objects
strategies. (This is coming in later commits that include performance
test changes.)

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/pack-objects.c | 209 ++++++++++++++++++++++++++++++++++-------
 path-walk.c            |   2 +-
 2 files changed, 177 insertions(+), 34 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 778be80f564..3d0bb33427d 100644
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
 
@@ -3139,6 +3143,38 @@ static int add_ref_tag(const char *tag UNUSED, const char *referent UNUSED, cons
 	return 0;
 }
 
+static int should_attempt_deltas(struct object_entry *entry)
+{
+	if (DELTA(entry))
+		/* This happens if we decided to reuse existing
+		 * delta from a pack.  "reuse_delta &&" is implied.
+		 */
+		return 0;
+
+	if (!entry->type_valid ||
+		oe_size_less_than(&to_pack, entry, 50))
+		return 0;
+
+	if (entry->no_try_delta)
+		return 0;
+
+	if (!entry->preferred_base) {
+		if (oe_type(entry) < 0)
+			die(_("unable to get type of object %s"),
+				oid_to_hex(&entry->idx.oid));
+	} else {
+		if (oe_type(entry) < 0) {
+			/*
+			 * This object is not found, but we
+			 * don't have to include it anyway.
+			 */
+			return 0;
+		}
+	}
+
+	return 1;
+}
+
 static void prepare_pack(int window, int depth)
 {
 	struct object_entry **delta_list;
@@ -3169,33 +3205,11 @@ static void prepare_pack(int window, int depth)
 	for (i = 0; i < to_pack.nr_objects; i++) {
 		struct object_entry *entry = to_pack.objects + i;
 
-		if (DELTA(entry))
-			/* This happens if we decided to reuse existing
-			 * delta from a pack.  "reuse_delta &&" is implied.
-			 */
+		if (!should_attempt_deltas(entry))
 			continue;
 
-		if (!entry->type_valid ||
-		    oe_size_less_than(&to_pack, entry, 50))
-			continue;
-
-		if (entry->no_try_delta)
-			continue;
-
-		if (!entry->preferred_base) {
+		if (!entry->preferred_base)
 			nr_deltas++;
-			if (oe_type(entry) < 0)
-				die(_("unable to get type of object %s"),
-				    oid_to_hex(&entry->idx.oid));
-		} else {
-			if (oe_type(entry) < 0) {
-				/*
-				 * This object is not found, but we
-				 * don't have to include it anyway.
-				 */
-				continue;
-			}
-		}
 
 		delta_list[n++] = entry;
 	}
@@ -4110,6 +4124,117 @@ static void mark_bitmap_preferred_tips(void)
 	}
 }
 
+static inline int is_oid_interesting(struct repository *repo,
+				     struct object_id *oid,
+				     enum object_type type)
+{
+	if (type == OBJ_TAG) {
+		struct tag *t = lookup_tag(repo, oid);
+		return t && !(t->object.flags & UNINTERESTING);
+	}
+
+	if (type == OBJ_COMMIT) {
+		struct commit *c = lookup_commit(repo, oid);
+		return c && !(c->object.flags & UNINTERESTING);
+	}
+
+	if (type == OBJ_TREE) {
+		struct tree *t = lookup_tree(repo, oid);
+		return t && !(t->object.flags & UNINTERESTING);
+	}
+
+	if (type == OBJ_BLOB) {
+		struct blob *b = lookup_blob(repo, oid);
+		return b && !(b->object.flags & UNINTERESTING);
+	}
+
+	return 0;
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
+		struct object_id *oid = &oids->oid[i];
+		int exclude = !is_oid_interesting(the_repository, oid, type);
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
+
+	info.revs->tag_objects = 1;
+	info.tags = 1;
+	info.commits = 1;
+	info.trees = 1;
+	info.blobs = 1;
+	info.path_fn = add_objects_by_path;
+	info.path_fn_data = &processed;
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
@@ -4156,7 +4281,7 @@ static void get_object_list(struct rev_info *revs, int ac, const char **av)
 
 	warn_on_object_refname_ambiguity = save_warning;
 
-	if (use_bitmap_index && !get_object_list_from_bitmap(revs))
+	if (use_bitmap_index && !path_walk && !get_object_list_from_bitmap(revs))
 		return;
 
 	if (use_delta_islands)
@@ -4165,15 +4290,19 @@ static void get_object_list(struct rev_info *revs, int ac, const char **av)
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
@@ -4368,6 +4497,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			 N_("use the sparse reachability algorithm")),
 		OPT_BOOL(0, "thin", &thin,
 			 N_("create thin packs")),
+		OPT_BOOL(0, "path-walk", &path_walk,
+			 N_("use the path-walk API to walk objects when possible")),
 		OPT_BOOL(0, "shallow", &shallow,
 			 N_("create packs suitable for shallow fetches")),
 		OPT_BOOL(0, "honor-pack-keep", &ignore_packed_keep_on_disk,
@@ -4448,7 +4579,19 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		window = 0;
 
 	strvec_push(&rp, "pack-objects");
-	if (thin) {
+
+	if (path_walk && filter_options.choice) {
+		warning(_("cannot use --filter with --path-walk"));
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
diff --git a/path-walk.c b/path-walk.c
index 08de29614f7..9391e0579ae 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -306,7 +306,7 @@ int walk_objects_by_path(struct path_walk_info *info)
 
 	/* Track all commits. */
 	if (info->commits)
-		ret = info->path_fn("", &commit_list->oids, OBJ_COMMIT,
+		ret = info->path_fn("initial", &commit_list->oids, OBJ_COMMIT,
 				    info->path_fn_data);
 	oid_array_clear(&commit_list->oids);
 	free(commit_list);
-- 
gitgitgadget


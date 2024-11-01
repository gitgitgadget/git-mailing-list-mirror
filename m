Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851BC1D365A
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 20:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730491922; cv=none; b=eyrLbTIoRVoILTfyCOwaBzhLRlmt15No1AOL49t0K1VtJZVANeSNm8XjKcYK/3zyKk0v0PyCWqZkH2nM05Yqc1WRpT1WKni5L+ZyRnE6uvOFLGtJCfdtdysMqoGbin8Hwms0Q0ZUKtPKoBt1El38i7Ea6Pm12GeBtzFih3oVLHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730491922; c=relaxed/simple;
	bh=cSuBWbenz0IXb8tZrp8lZAsNWH3r4fKPnJZax/EnA+M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pNxCKW3wMqVbmTFAywTo60s6t3UoXdsWu/XPI9Umza0Czg2kwmWm8bIKgvny5kNu1ZUpo+bVQMrfJr4x/S9C2olG5sT7eyQ7ycueeVKJYXUq9MfPUM37dhURn9m0EO+Vk1VtsGS7V/v+hcaCEiGoL6iNqX/8FfMjvCEg7Wx751k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XvEuJZOe; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XvEuJZOe"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02fff66a83so4031559276.0
        for <git@vger.kernel.org>; Fri, 01 Nov 2024 13:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730491919; x=1731096719; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GKit1hiwplhhurs7kNkOh0HHhVabIA9rOEBd8MRyX50=;
        b=XvEuJZOeVaKgxGmVeknloG1wHW7os1yPIte75vY8F1yWnQVZx8mPQGq9dOmchGfsiR
         5Odzd1w+yDFCY+Sm+EJ5rsY4iGrl68NaWB7sYZ+oOjo3xppdAsih1kgPuN7hx3Ez0zJV
         pjuSyYlN9sJjVBTawKYXT/aBQ1a7KAcpTvKxLPBzdq5g5hWp1Plkdnk9I1VHXtX2I6RU
         esqPRFFBGyl8dEqZOuhK8eZuUEJa/T+G84MvClbbaEqTszmWkfU3HaKpUWgUvj9hVOqS
         9wPNjffr+PbXG35pHxBgAM6FBjWdN/FD2uG8L8Jbjwv0yLqkUHONfyt2yr79XHyoSyuk
         C/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730491919; x=1731096719;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GKit1hiwplhhurs7kNkOh0HHhVabIA9rOEBd8MRyX50=;
        b=Hsj1R19k28oEM5PucCjbPUTA1aSGotEL9ZAUmGYoKc2e009wweNxXcszumnSwvahQn
         xer1NeHA+d+/Q3AnP+EiWFHqnhU5iPvAKVKA23lcSF6U45tKZ8PpBU9j65pviQY9rlD7
         LTE7YgnAJ0L3Vvb27maFouE+zF/sgPNF0gk8HF+T7qvEloZZsm5BaFeYOTJrv8isM869
         WPTMBYB+/QbRg6izjJeLCftxwzJgGBi/zmCfcw3eXg2GYOHt68pDtmUO0OxgjTy8edw4
         WVJJyxKry156P++pgcCIXWIjRQfYts5o9QV/OasQf7XYLrwhGOvytuJiP/RyhHunVa/J
         9E/g==
X-Gm-Message-State: AOJu0YyPF1NKLts71EYNFIPkUzZgTm2+CnMZ36KFAKtjDByGLPdIf94g
	kvWcl2mzba9FzqZMVuMQufx7cAQyOTltLoTaBiulP6FRzd4SBlRB4V1HjmJ2ndH4tqJQTH6XnXg
	n9dkuS23UY0+Nusf7XtGHTUKXSpJHx2JER7xDR/kNjLZdfVhvm9RIXXaIyVP/JZEmdci4AV+2EA
	XHSPQdX6SFmIxRZZBuXaQW/Zq1wgVPtraKiQISOZC5kD1x+6FD8GSTMiLBioNipaFbhw==
X-Google-Smtp-Source: AGHT+IGUmIZZXPMGsAg4tlTKZ8d2y1jbrWiahZyH+IWv1KMazzceNqFrivCt3agVDYYyG1jq1Rdh3iBRoel5D3VIQ6+v
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:87c0:a56e:d0ff:807f])
 (user=jonathantanmy job=sendgmr) by 2002:a25:86c8:0:b0:e30:d717:36ed with
 SMTP id 3f1490d57ef6-e30e5b3afe2mr4916276.10.1730491918456; Fri, 01 Nov 2024
 13:11:58 -0700 (PDT)
Date: Fri,  1 Nov 2024 13:11:48 -0700
In-Reply-To: <cover.1730491845.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1729792911.git.jonathantanmy@google.com> <cover.1730491845.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <c51fac33fb68b75c28da16005b0e76f5fa2b37f0.1730491845.git.jonathantanmy@google.com>
Subject: [PATCH v2 4/4] index-pack: repack local links into promisor packs
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>, steadmon@google.com, 
	hanyang.tony@bytedance.com, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"

Teach index-pack to, when processing the objects in a pack with
--promisor specified on the CLI, repack local objects (and the local
objects that they refer to, recursively) referenced by these objects
into promisor packs.

This prevents the situation in which, when fetching from a promisor
remote, we end up with promisor objects (newly fetched) referring
to non-promisor objects (locally created prior to the fetch). This
situation may arise if the client had previously pushed objects to the
remote, for example. One issue that arises in this situation is that,
if the non-promisor objects become inaccessible except through promisor
objects (for example, if the branch pointing to them has moved to
point to the promisor object that refers to them), then GC will garbage
collect them. There are other ways to solve this, but the simplest
seems to be to enforce the invariant that we don't have promisor objects
referring to non-promisor objects.

This repacking is done from index-pack to minimize the performance
impact. During a fetch, the only time most objects are fully inflated
in memory is when their object ID is computed, so we also scan the
objects (to see which objects they refer to) during this time.

Also to minimize the performance impact, an object is calculated to be
local if it's a loose object or present in a non-promisor pack. (If it's
also in a promisor pack or referred to by an object in a promisor pack,
it is technically already a promisor object. But a misidentification
of a promisor object as a non-promisor object is relatively benign
here - we will thus repack that promisor object into a promisor pack,
duplicating it in the object store, but there is no correctness issue,
just an issue of inefficiency.)

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/git-index-pack.txt |   5 ++
 builtin/index-pack.c             | 110 ++++++++++++++++++++++++++++++-
 builtin/pack-objects.c           |  28 ++++++++
 t/t5616-partial-clone.sh         |  30 +++++++++
 4 files changed, 171 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 5a20deefd5..4be09e58e7 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -139,6 +139,11 @@ include::object-format-disclaimer.txt[]
 	written. If a `<message>` is provided, then that content will be
 	written to the .promisor file for future reference. See
 	link:technical/partial-clone.html[partial clone] for more information.
++
+Also, if there are objects in the given pack that references non-promisor
+objects (in the repo), repacks those non-promisor objects into a promisor
+pack. This avoids a situation in which a repo has non-promisor objects that are
+accessible through promisor objects.
 
 NOTES
 -----
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 9d23b41b3a..e4afd6725f 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -9,6 +9,7 @@
 #include "csum-file.h"
 #include "blob.h"
 #include "commit.h"
+#include "tag.h"
 #include "tree.h"
 #include "progress.h"
 #include "fsck.h"
@@ -20,9 +21,14 @@
 #include "object-file.h"
 #include "object-store-ll.h"
 #include "oid-array.h"
+#include "oidset.h"
+#include "path.h"
 #include "replace-object.h"
+#include "tree-walk.h"
 #include "promisor-remote.h"
+#include "run-command.h"
 #include "setup.h"
+#include "strvec.h"
 
 static const char index_pack_usage[] =
 "git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--[no-]rev-index] [--verify] [--strict[=<msg-id>=<severity>...]] [--fsck-objects[=<msg-id>=<severity>...]] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
@@ -148,6 +154,13 @@ static uint32_t input_crc32;
 static int input_fd, output_fd;
 static const char *curr_pack;
 
+/*
+ * local_links is guarded by read_mutex, and record_local_links is read-only in
+ * a thread.
+ */
+static struct oidset local_links = OIDSET_INIT;
+static int record_local_links;
+
 static struct thread_local *thread_data;
 static int nr_dispatched;
 static int threads_active;
@@ -799,6 +812,44 @@ static int check_collison(struct object_entry *entry)
 	return 0;
 }
 
+static void record_if_local_object(const struct object_id *oid)
+{
+	struct object_info info = OBJECT_INFO_INIT;
+	if (oid_object_info_extended(the_repository, oid, &info, 0))
+		/* Missing; assume it is a promisor object */
+		return;
+	if (info.whence == OI_PACKED && info.u.packed.pack->pack_promisor)
+		return;
+	oidset_insert(&local_links, oid);
+}
+
+static void do_record_local_links(struct object *obj)
+{
+	if (obj->type == OBJ_TREE) {
+		struct tree *tree = (struct tree *)obj;
+		struct tree_desc desc;
+		struct name_entry entry;
+		if (init_tree_desc_gently(&desc, &tree->object.oid,
+					  tree->buffer, tree->size, 0))
+			/*
+			 * Error messages are given when packs are
+			 * verified, so do not print any here.
+			 */
+			return;
+		while (tree_entry_gently(&desc, &entry))
+			record_if_local_object(&entry.oid);
+	} else if (obj->type == OBJ_COMMIT) {
+		struct commit *commit = (struct commit *) obj;
+		struct commit_list *parents = commit->parents;
+
+		for (; parents; parents = parents->next)
+			record_if_local_object(&parents->item->object.oid);
+	} else if (obj->type == OBJ_TAG) {
+		struct tag *tag = (struct tag *) obj;
+		record_if_local_object(get_tagged_oid(tag));
+	}
+}
+
 static void sha1_object(const void *data, struct object_entry *obj_entry,
 			unsigned long size, enum object_type type,
 			const struct object_id *oid)
@@ -845,7 +896,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 		free(has_data);
 	}
 
-	if (strict || do_fsck_object) {
+	if (strict || do_fsck_object || record_local_links) {
 		read_lock();
 		if (type == OBJ_BLOB) {
 			struct blob *blob = lookup_blob(the_repository, oid);
@@ -877,6 +928,8 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 				die(_("fsck error in packed object"));
 			if (strict && fsck_walk(obj, NULL, &fsck_options))
 				die(_("Not all child objects of %s are reachable"), oid_to_hex(&obj->oid));
+			if (record_local_links)
+				do_record_local_links(obj);
 
 			if (obj->type == OBJ_TREE) {
 				struct tree *item = (struct tree *) obj;
@@ -1719,6 +1772,57 @@ static void show_pack_info(int stat_only)
 	free(chain_histogram);
 }
 
+static void repack_local_links(void)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	FILE *out;
+	struct strbuf line = STRBUF_INIT;
+	struct oidset_iter iter;
+	struct object_id *oid;
+	char *base_name;
+
+	if (!oidset_size(&local_links))
+		return;
+
+	base_name = mkpathdup("%s/pack/pack", repo_get_object_directory(the_repository));
+
+	strvec_push(&cmd.args, "pack-objects");
+	strvec_push(&cmd.args, "--exclude-promisor-objects-best-effort");
+	strvec_push(&cmd.args, base_name);
+	cmd.git_cmd = 1;
+	cmd.in = -1;
+	cmd.out = -1;
+	if (start_command(&cmd))
+		die(_("could not start pack-objects to repack local links"));
+
+	oidset_iter_init(&local_links, &iter);
+	while ((oid = oidset_iter_next(&iter))) {
+		if (write_in_full(cmd.in, oid_to_hex(oid), the_hash_algo->hexsz) < 0 ||
+		    write_in_full(cmd.in, "\n", 1) < 0)
+			die(_("failed to feed local object to pack-objects"));
+	}
+	close(cmd.in);
+
+	out = xfdopen(cmd.out, "r");
+	while (strbuf_getline_lf(&line, out) != EOF) {
+		unsigned char binary[GIT_MAX_RAWSZ];
+		if (line.len != the_hash_algo->hexsz ||
+		    !hex_to_bytes(binary, line.buf, line.len))
+			die(_("index-pack: Expecting full hex object ID lines only from pack-objects."));
+
+		/*
+		 * pack-objects creates the .pack and .idx files, but not the
+		 * .promisor file. Create the .promisor file, which is empty.
+		 */
+		write_special_file("promisor", "", NULL, binary, NULL);
+	}
+
+	fclose(out);
+	if (finish_command(&cmd))
+		die(_("could not finish pack-objects to repack local links"));
+	strbuf_release(&line);
+}
+
 int cmd_index_pack(int argc,
 		   const char **argv,
 		   const char *prefix,
@@ -1794,7 +1898,7 @@ int cmd_index_pack(int argc,
 			} else if (skip_to_optional_arg(arg, "--keep", &keep_msg)) {
 				; /* nothing to do */
 			} else if (skip_to_optional_arg(arg, "--promisor", &promisor_msg)) {
-				; /* already parsed */
+				record_local_links = 1;
 			} else if (starts_with(arg, "--threads=")) {
 				char *end;
 				nr_threads = strtoul(arg+10, &end, 0);
@@ -1970,6 +2074,8 @@ int cmd_index_pack(int argc,
 		free((void *) curr_index);
 	free(curr_rev_index);
 
+	repack_local_links();
+
 	/*
 	 * Let the caller know this pack is not self contained
 	 */
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0fc0680b40..51d2ffe490 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -239,6 +239,7 @@ static enum {
 static uint16_t write_bitmap_options = BITMAP_OPT_HASH_CACHE;
 
 static int exclude_promisor_objects;
+static int exclude_promisor_objects_best_effort;
 
 static int use_delta_islands;
 
@@ -4312,6 +4313,18 @@ static int option_parse_cruft_expiration(const struct option *opt UNUSED,
 	return 0;
 }
 
+static int is_not_in_promisor_pack_obj(struct object *obj, void *data UNUSED)
+{
+	struct object_info info = OBJECT_INFO_INIT;
+	if (oid_object_info_extended(the_repository, &obj->oid, &info, 0))
+		BUG("should_include_obj should only be called on existing objects");
+	return info.whence != OI_PACKED || !info.u.packed.pack->pack_promisor;
+}
+
+static int is_not_in_promisor_pack(struct commit *commit, void *data) {
+	return is_not_in_promisor_pack_obj((struct object *) commit, data);
+}
+
 int cmd_pack_objects(int argc,
 		     const char **argv,
 		     const char *prefix,
@@ -4424,6 +4437,9 @@ int cmd_pack_objects(int argc,
 		  option_parse_missing_action),
 		OPT_BOOL(0, "exclude-promisor-objects", &exclude_promisor_objects,
 			 N_("do not pack objects in promisor packfiles")),
+		OPT_BOOL(0, "exclude-promisor-objects-best-effort",
+			 &exclude_promisor_objects_best_effort,
+			 N_("implies --missing=allow-any")),
 		OPT_BOOL(0, "delta-islands", &use_delta_islands,
 			 N_("respect islands during delta compression")),
 		OPT_STRING_LIST(0, "uri-protocol", &uri_protocols,
@@ -4504,10 +4520,18 @@ int cmd_pack_objects(int argc,
 		strvec_push(&rp, "--unpacked");
 	}
 
+	if (exclude_promisor_objects && exclude_promisor_objects_best_effort)
+		die(_("options '%s' and '%s' cannot be used together"),
+		    "--exclude-promisor-objects", "--exclude-promisor-objects-best-effort");
 	if (exclude_promisor_objects) {
 		use_internal_rev_list = 1;
 		fetch_if_missing = 0;
 		strvec_push(&rp, "--exclude-promisor-objects");
+	} else if (exclude_promisor_objects_best_effort) {
+		use_internal_rev_list = 1;
+		fetch_if_missing = 0;
+		option_parse_missing_action(NULL, "allow-any", 0);
+		/* revs configured below */
 	}
 	if (unpack_unreachable || keep_unreachable || pack_loose_unreachable)
 		use_internal_rev_list = 1;
@@ -4627,6 +4651,10 @@ int cmd_pack_objects(int argc,
 
 		repo_init_revisions(the_repository, &revs, NULL);
 		list_objects_filter_copy(&revs.filter, &filter_options);
+		if (exclude_promisor_objects_best_effort) {
+			revs.include_check = is_not_in_promisor_pack;
+			revs.include_check_obj = is_not_in_promisor_pack_obj;
+		}
 		get_object_list(&revs, rp.nr, rp.v);
 		release_revisions(&revs);
 	}
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index c53e93be2f..2e67f59f89 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -694,6 +694,36 @@ test_expect_success 'lazy-fetch in submodule succeeds' '
 	git -C client restore --recurse-submodules --source=HEAD^ :/
 '
 
+test_expect_success 'after fetching descendants of non-promisor commits, gc works' '
+	# Setup
+	git init full &&
+	git -C full config uploadpack.allowfilter 1 &&
+ 	git -C full config uploadpack.allowanysha1inwant 1 &&
+	touch full/foo &&
+	git -C full add foo &&
+	git -C full commit -m "commit 1" &&
+	git -C full checkout --detach &&
+
+	# Partial clone and push commit to remote
+	git clone "file://$(pwd)/full" --filter=blob:none partial &&
+	echo "hello" > partial/foo &&
+	git -C partial commit -a -m "commit 2" &&
+	git -C partial push &&
+
+	# gc in partial repo
+	git -C partial gc --prune=now &&
+
+	# Create another commit in normal repo
+	git -C full checkout main &&
+	echo " world" >> full/foo &&
+	git -C full commit -a -m "commit 3" &&
+
+	# Pull from remote in partial repo, and run gc again
+	git -C partial pull &&
+	git -C partial gc --prune=now
+'
+
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
2.47.0.163.g1226f6d8fa-goog


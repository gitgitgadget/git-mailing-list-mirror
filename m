Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 874922095B
	for <e@80x24.org>; Sat, 18 Mar 2017 21:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751273AbdCRVWw (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 17:22:52 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:46134 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751134AbdCRVWe (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 18 Mar 2017 17:22:34 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id AA353280C0;
        Sat, 18 Mar 2017 21:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1489872005;
        bh=cy9RAgP8OEyAe9YEVtwd9K9t2eUfZegmnNyPAz5TNeg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mMIkNspzcoYr/UaOu8uPpEY7Iax1d93LYmZYMDg1lJBDgdH9Rft9UxDhveHsFqZRp
         sKmk7djalfZK8Qw2Dvi5RZaL0oo9nOFlDRU0l9xWm6oUXdeCAGmpVzrPFHxk+fIkA7
         cDIkdVIcAbH2v8q88ChSfKqZVL38bDjn/NTkZ0jdjiUQ9Shkfvgj3T2GmWZiMqZeyK
         cGWnGIE/LYghme6Xi2OcY8CQ5wpW8cw7SfTYcbk5IHj0xX33R+wDOJY10E+hx+n0Rg
         vPslYjJnwOPWdlX5Vd947ZBpIU8zpc09oD44Q//VXArF05w1aJ8Is87SYPzeFvo8sL
         AUzAaP+2R6QMqQM13iJgBrBzEjgIY1oUt8j+4tcDhReeaQ5Yxg0oHbmrTLdXzqOdo6
         07aif0buSGY9bhQbuW8S3cqh4k1zDSkbTES/K1LcCT2mawWKIqntOXMj/lpUI2o6ac
         +6MuEAOOq73qSJ7Z1HLrV2KmhBn8qjTeh0KTXypGi4VOh9WPwgH
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 19/20] Rename sha1_array to oid_array
Date:   Sat, 18 Mar 2017 21:19:53 +0000
Message-Id: <20170318211954.564030-20-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170318211954.564030-1-sandals@crustytoothpaste.net>
References: <20170318211954.564030-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since this structure handles an array of object IDs, rename it to struct
oid_array.  Also rename the accessor functions and the initialization
constant.

This commit was produced mechanically by providing non-Documentation
files to the following Perl one-liners:

    perl -pi -E 's/struct sha1_array/struct oid_array/g'
    perl -pi -E 's/\bsha1_array_/oid_array_/g'
    perl -pi -E 's/SHA1_ARRAY_INIT/OID_ARRAY_INIT/g'

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 bisect.c                   | 16 ++++++++--------
 builtin/cat-file.c         | 10 +++++-----
 builtin/diff.c             |  6 +++---
 builtin/fetch-pack.c       |  2 +-
 builtin/pack-objects.c     | 10 +++++-----
 builtin/pull.c             |  6 +++---
 builtin/receive-pack.c     | 24 +++++++++++------------
 builtin/send-pack.c        |  4 ++--
 combine-diff.c             | 12 ++++++------
 commit.h                   | 14 +++++++-------
 connect.c                  |  8 ++++----
 diff.h                     |  4 ++--
 fetch-pack.c               | 26 ++++++++++++-------------
 fetch-pack.h               |  4 ++--
 fsck.c                     |  6 +++---
 fsck.h                     |  2 +-
 parse-options-cb.c         |  4 ++--
 ref-filter.c               |  6 +++---
 ref-filter.h               |  2 +-
 remote-curl.c              |  2 +-
 remote.h                   |  6 +++---
 send-pack.c                |  4 ++--
 send-pack.h                |  2 +-
 sha1-array.c               | 14 +++++++-------
 sha1-array.h               | 12 ++++++------
 sha1_name.c                |  8 ++++----
 shallow.c                  | 12 ++++++------
 submodule.c                | 48 +++++++++++++++++++++++-----------------------
 submodule.h                |  6 +++---
 t/helper/test-sha1-array.c | 10 +++++-----
 transport.c                | 20 +++++++++----------
 31 files changed, 155 insertions(+), 155 deletions(-)

diff --git a/bisect.c b/bisect.c
index f193257509..54d69e77b9 100644
--- a/bisect.c
+++ b/bisect.c
@@ -12,8 +12,8 @@
 #include "sha1-array.h"
 #include "argv-array.h"
 
-static struct sha1_array good_revs;
-static struct sha1_array skipped_revs;
+static struct oid_array good_revs;
+static struct oid_array skipped_revs;
 
 static struct object_id *current_bad_oid;
 
@@ -413,9 +413,9 @@ static int register_ref(const char *refname, const struct object_id *oid,
 		current_bad_oid = xmalloc(sizeof(*current_bad_oid));
 		oidcpy(current_bad_oid, oid);
 	} else if (starts_with(refname, good_prefix.buf)) {
-		sha1_array_append(&good_revs, oid);
+		oid_array_append(&good_revs, oid);
 	} else if (starts_with(refname, "skip-")) {
-		sha1_array_append(&skipped_revs, oid);
+		oid_array_append(&skipped_revs, oid);
 	}
 
 	strbuf_release(&good_prefix);
@@ -451,7 +451,7 @@ static void read_bisect_paths(struct argv_array *array)
 	fclose(fp);
 }
 
-static char *join_sha1_array_hex(struct sha1_array *array, char delim)
+static char *join_sha1_array_hex(struct oid_array *array, char delim)
 {
 	struct strbuf joined_hexs = STRBUF_INIT;
 	int i;
@@ -499,7 +499,7 @@ struct commit_list *filter_skipped(struct commit_list *list,
 	while (list) {
 		struct commit_list *next = list->next;
 		list->next = NULL;
-		if (0 <= sha1_array_lookup(&skipped_revs, &list->item->object.oid)) {
+		if (0 <= oid_array_lookup(&skipped_revs, &list->item->object.oid)) {
 			if (skipped_first && !*skipped_first)
 				*skipped_first = 1;
 			/* Move current to tried list */
@@ -789,9 +789,9 @@ static void check_merge_bases(int no_checkout)
 		const struct object_id *mb = &result->item->object.oid;
 		if (!oidcmp(mb, current_bad_oid)) {
 			handle_bad_merge_base();
-		} else if (0 <= sha1_array_lookup(&good_revs, mb)) {
+		} else if (0 <= oid_array_lookup(&good_revs, mb)) {
 			continue;
-		} else if (0 <= sha1_array_lookup(&skipped_revs, mb)) {
+		} else if (0 <= oid_array_lookup(&skipped_revs, mb)) {
 			handle_skipped_merge_base(mb);
 		} else {
 			printf(_("Bisecting: a merge base must be tested\n"));
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index eb0043231d..1890d7a639 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -413,7 +413,7 @@ static int batch_loose_object(const struct object_id *oid,
 			      const char *path,
 			      void *data)
 {
-	sha1_array_append(data, oid);
+	oid_array_append(data, oid);
 	return 0;
 }
 
@@ -422,7 +422,7 @@ static int batch_packed_object(const struct object_id *oid,
 			       uint32_t pos,
 			       void *data)
 {
-	sha1_array_append(data, oid);
+	oid_array_append(data, oid);
 	return 0;
 }
 
@@ -462,7 +462,7 @@ static int batch_objects(struct batch_options *opt)
 		data.info.typep = &data.type;
 
 	if (opt->all_objects) {
-		struct sha1_array sa = SHA1_ARRAY_INIT;
+		struct oid_array sa = OID_ARRAY_INIT;
 		struct object_cb_data cb;
 
 		for_each_loose_object(batch_loose_object, &sa, 0);
@@ -470,9 +470,9 @@ static int batch_objects(struct batch_options *opt)
 
 		cb.opt = opt;
 		cb.expand = &data;
-		sha1_array_for_each_unique(&sa, batch_object_cb, &cb);
+		oid_array_for_each_unique(&sa, batch_object_cb, &cb);
 
-		sha1_array_clear(&sa);
+		oid_array_clear(&sa);
 		return 0;
 	}
 
diff --git a/builtin/diff.c b/builtin/diff.c
index a5b34eb156..d184aafab9 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -184,7 +184,7 @@ static int builtin_diff_combined(struct rev_info *revs,
 				 struct object_array_entry *ent,
 				 int ents)
 {
-	struct sha1_array parents = SHA1_ARRAY_INIT;
+	struct oid_array parents = OID_ARRAY_INIT;
 	int i;
 
 	if (argc > 1)
@@ -193,10 +193,10 @@ static int builtin_diff_combined(struct rev_info *revs,
 	if (!revs->dense_combined_merges && !revs->combine_merges)
 		revs->dense_combined_merges = revs->combine_merges = 1;
 	for (i = 1; i < ents; i++)
-		sha1_array_append(&parents, &ent[i].item->oid);
+		oid_array_append(&parents, &ent[i].item->oid);
 	diff_tree_combined(ent[0].item->oid.hash, &parents,
 			   revs->dense_combined_merges, revs);
-	sha1_array_clear(&parents);
+	oid_array_clear(&parents);
 	return 0;
 }
 
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 2a1c1c213f..366b9d13f9 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -50,7 +50,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	char **pack_lockfile_ptr = NULL;
 	struct child_process *conn;
 	struct fetch_pack_args args;
-	struct sha1_array shallow = SHA1_ARRAY_INIT;
+	struct oid_array shallow = OID_ARRAY_INIT;
 	struct string_list deepen_not = STRING_LIST_INIT_DUP;
 
 	packet_trace_identity("fetch-pack");
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 028c7be9a2..4fc032e3ec 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2668,7 +2668,7 @@ static int has_sha1_pack_kept_or_nonlocal(const unsigned char *sha1)
  *
  * This is filled by get_object_list.
  */
-static struct sha1_array recent_objects;
+static struct oid_array recent_objects;
 
 static int loosened_object_can_be_discarded(const struct object_id *oid,
 					    unsigned long mtime)
@@ -2677,7 +2677,7 @@ static int loosened_object_can_be_discarded(const struct object_id *oid,
 		return 0;
 	if (mtime > unpack_unreachable_expiration)
 		return 0;
-	if (sha1_array_lookup(&recent_objects, oid) >= 0)
+	if (oid_array_lookup(&recent_objects, oid) >= 0)
 		return 0;
 	return 1;
 }
@@ -2739,12 +2739,12 @@ static void record_recent_object(struct object *obj,
 				 const char *name,
 				 void *data)
 {
-	sha1_array_append(&recent_objects, &obj->oid);
+	oid_array_append(&recent_objects, &obj->oid);
 }
 
 static void record_recent_commit(struct commit *commit, void *data)
 {
-	sha1_array_append(&recent_objects, &commit->object.oid);
+	oid_array_append(&recent_objects, &commit->object.oid);
 }
 
 static void get_object_list(int ac, const char **av)
@@ -2812,7 +2812,7 @@ static void get_object_list(int ac, const char **av)
 	if (unpack_unreachable)
 		loosen_unused_packed_objects(&revs);
 
-	sha1_array_clear(&recent_objects);
+	oid_array_clear(&recent_objects);
 }
 
 static int option_parse_index_version(const struct option *opt,
diff --git a/builtin/pull.c b/builtin/pull.c
index 183e377147..d8aa26d8ab 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -330,7 +330,7 @@ static int git_pull_config(const char *var, const char *value, void *cb)
  * Appends merge candidates from FETCH_HEAD that are not marked not-for-merge
  * into merge_heads.
  */
-static void get_merge_heads(struct sha1_array *merge_heads)
+static void get_merge_heads(struct oid_array *merge_heads)
 {
 	const char *filename = git_path("FETCH_HEAD");
 	FILE *fp;
@@ -344,7 +344,7 @@ static void get_merge_heads(struct sha1_array *merge_heads)
 			continue;  /* invalid line: does not start with SHA1 */
 		if (starts_with(sb.buf + GIT_SHA1_HEXSZ, "\tnot-for-merge\t"))
 			continue;  /* ref is not-for-merge */
-		sha1_array_append(merge_heads, &oid);
+		oid_array_append(merge_heads, &oid);
 	}
 	fclose(fp);
 	strbuf_release(&sb);
@@ -769,7 +769,7 @@ static int run_rebase(const struct object_id *curr_head,
 int cmd_pull(int argc, const char **argv, const char *prefix)
 {
 	const char *repo, **refspecs;
-	struct sha1_array merge_heads = SHA1_ARRAY_INIT;
+	struct oid_array merge_heads = OID_ARRAY_INIT;
 	struct object_id orig_head, curr_head;
 	struct object_id rebase_fork_point;
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 88927a8169..58d4120a26 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -831,7 +831,7 @@ static int command_singleton_iterator(void *cb_data, unsigned char sha1[20]);
 static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 {
 	static struct lock_file shallow_lock;
-	struct sha1_array extra = SHA1_ARRAY_INIT;
+	struct oid_array extra = OID_ARRAY_INIT;
 	struct check_connected_options opt = CHECK_CONNECTED_INIT;
 	uint32_t mask = 1 << (cmd->index % 32);
 	int i;
@@ -842,13 +842,13 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 		if (si->used_shallow[i] &&
 		    (si->used_shallow[i][cmd->index / 32] & mask) &&
 		    !delayed_reachability_test(si, i))
-			sha1_array_append(&extra, si->shallow->oid + i);
+			oid_array_append(&extra, si->shallow->oid + i);
 
 	opt.env = tmp_objdir_env(tmp_objdir);
 	setup_alternate_shallow(&shallow_lock, &opt.shallow_file, &extra);
 	if (check_connected(command_singleton_iterator, cmd, &opt)) {
 		rollback_lock_file(&shallow_lock);
-		sha1_array_clear(&extra);
+		oid_array_clear(&extra);
 		return -1;
 	}
 
@@ -862,7 +862,7 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 		register_shallow(extra.oid[i].hash);
 
 	si->shallow_ref[cmd->index] = 0;
-	sha1_array_clear(&extra);
+	oid_array_clear(&extra);
 	return 0;
 }
 
@@ -1533,7 +1533,7 @@ static void queue_commands_from_cert(struct command **tail,
 	}
 }
 
-static struct command *read_head_info(struct sha1_array *shallow)
+static struct command *read_head_info(struct oid_array *shallow)
 {
 	struct command *commands = NULL;
 	struct command **p = &commands;
@@ -1550,7 +1550,7 @@ static struct command *read_head_info(struct sha1_array *shallow)
 			if (get_oid_hex(line + 8, &oid))
 				die("protocol error: expected shallow sha, got '%s'",
 				    line + 8);
-			sha1_array_append(shallow, &oid);
+			oid_array_append(shallow, &oid);
 			continue;
 		}
 
@@ -1808,7 +1808,7 @@ static void prepare_shallow_update(struct command *commands,
 
 static void update_shallow_info(struct command *commands,
 				struct shallow_info *si,
-				struct sha1_array *ref)
+				struct oid_array *ref)
 {
 	struct command *cmd;
 	int *ref_status;
@@ -1821,7 +1821,7 @@ static void update_shallow_info(struct command *commands,
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (is_null_oid(&cmd->new_oid))
 			continue;
-		sha1_array_append(ref, &cmd->new_oid);
+		oid_array_append(ref, &cmd->new_oid);
 		cmd->index = ref->nr - 1;
 	}
 	si->ref = ref;
@@ -1882,8 +1882,8 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 {
 	int advertise_refs = 0;
 	struct command *commands;
-	struct sha1_array shallow = SHA1_ARRAY_INIT;
-	struct sha1_array ref = SHA1_ARRAY_INIT;
+	struct oid_array shallow = OID_ARRAY_INIT;
+	struct oid_array ref = OID_ARRAY_INIT;
 	struct shallow_info si;
 
 	struct option options[] = {
@@ -1975,8 +1975,8 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	}
 	if (use_sideband)
 		packet_flush(1);
-	sha1_array_clear(&shallow);
-	sha1_array_clear(&ref);
+	oid_array_clear(&shallow);
+	oid_array_clear(&ref);
 	free((void *)push_cert_nonce);
 	return 0;
 }
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 1ff5a67538..b646194429 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -131,8 +131,8 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	const char *dest = NULL;
 	int fd[2];
 	struct child_process *conn;
-	struct sha1_array extra_have = SHA1_ARRAY_INIT;
-	struct sha1_array shallow = SHA1_ARRAY_INIT;
+	struct oid_array extra_have = OID_ARRAY_INIT;
+	struct oid_array shallow = OID_ARRAY_INIT;
 	struct ref *remote_refs, *local_refs;
 	int ret;
 	int helper_status = 0;
diff --git a/combine-diff.c b/combine-diff.c
index c92029484c..c5586c972d 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1311,7 +1311,7 @@ static const char *path_path(void *obj)
 
 /* find set of paths that every parent touches */
 static struct combine_diff_path *find_paths_generic(const unsigned char *sha1,
-	const struct sha1_array *parents, struct diff_options *opt)
+	const struct oid_array *parents, struct diff_options *opt)
 {
 	struct combine_diff_path *paths = NULL;
 	int i, num_parent = parents->nr;
@@ -1359,7 +1359,7 @@ static struct combine_diff_path *find_paths_generic(const unsigned char *sha1,
  * rename/copy detection, etc, comparing all trees simultaneously (= faster).
  */
 static struct combine_diff_path *find_paths_multitree(
-	const unsigned char *sha1, const struct sha1_array *parents,
+	const unsigned char *sha1, const struct oid_array *parents,
 	struct diff_options *opt)
 {
 	int i, nparent = parents->nr;
@@ -1384,7 +1384,7 @@ static struct combine_diff_path *find_paths_multitree(
 
 
 void diff_tree_combined(const unsigned char *sha1,
-			const struct sha1_array *parents,
+			const struct oid_array *parents,
 			int dense,
 			struct rev_info *rev)
 {
@@ -1532,12 +1532,12 @@ void diff_tree_combined_merge(const struct commit *commit, int dense,
 			      struct rev_info *rev)
 {
 	struct commit_list *parent = get_saved_parents(rev, commit);
-	struct sha1_array parents = SHA1_ARRAY_INIT;
+	struct oid_array parents = OID_ARRAY_INIT;
 
 	while (parent) {
-		sha1_array_append(&parents, &parent->item->object.oid);
+		oid_array_append(&parents, &parent->item->object.oid);
 		parent = parent->next;
 	}
 	diff_tree_combined(commit->object.oid.hash, &parents, dense, rev);
-	sha1_array_clear(&parents);
+	oid_array_clear(&parents);
 }
diff --git a/commit.h b/commit.h
index 528272ac9b..7b1986d5c8 100644
--- a/commit.h
+++ b/commit.h
@@ -261,7 +261,7 @@ extern struct commit_list *get_merge_bases_many_dirty(struct commit *one, int n,
 /* largest positive number a signed 32-bit integer can contain */
 #define INFINITE_DEPTH 0x7fffffff
 
-struct sha1_array;
+struct oid_array;
 struct ref;
 extern int register_shallow(const unsigned char *sha1);
 extern int unregister_shallow(const unsigned char *sha1);
@@ -273,18 +273,18 @@ extern struct commit_list *get_shallow_commits_by_rev_list(
 		int ac, const char **av, int shallow_flag, int not_shallow_flag);
 extern void set_alternate_shallow_file(const char *path, int override);
 extern int write_shallow_commits(struct strbuf *out, int use_pack_protocol,
-				 const struct sha1_array *extra);
+				 const struct oid_array *extra);
 extern void setup_alternate_shallow(struct lock_file *shallow_lock,
 				    const char **alternate_shallow_file,
-				    const struct sha1_array *extra);
-extern const char *setup_temporary_shallow(const struct sha1_array *extra);
+				    const struct oid_array *extra);
+extern const char *setup_temporary_shallow(const struct oid_array *extra);
 extern void advertise_shallow_grafts(int);
 
 struct shallow_info {
-	struct sha1_array *shallow;
+	struct oid_array *shallow;
 	int *ours, nr_ours;
 	int *theirs, nr_theirs;
-	struct sha1_array *ref;
+	struct oid_array *ref;
 
 	/* for receive-pack */
 	uint32_t **used_shallow;
@@ -295,7 +295,7 @@ struct shallow_info {
 	int nr_commits;
 };
 
-extern void prepare_shallow_info(struct shallow_info *, struct sha1_array *);
+extern void prepare_shallow_info(struct shallow_info *, struct oid_array *);
 extern void clear_shallow_info(struct shallow_info *);
 extern void remove_nonexistent_theirs_shallow(struct shallow_info *);
 extern void assign_shallow_commits_to_refs(struct shallow_info *info,
diff --git a/connect.c b/connect.c
index 50b503da0d..6afde189a3 100644
--- a/connect.c
+++ b/connect.c
@@ -111,8 +111,8 @@ static void annotate_refs_with_symref_info(struct ref *ref)
  */
 struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 			      struct ref **list, unsigned int flags,
-			      struct sha1_array *extra_have,
-			      struct sha1_array *shallow_points)
+			      struct oid_array *extra_have,
+			      struct oid_array *shallow_points)
 {
 	struct ref **orig_list = list;
 
@@ -153,7 +153,7 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 				die("protocol error: expected shallow sha-1, got '%s'", arg);
 			if (!shallow_points)
 				die("repository on the other end cannot be shallow");
-			sha1_array_append(shallow_points, &old_oid);
+			oid_array_append(shallow_points, &old_oid);
 			continue;
 		}
 
@@ -169,7 +169,7 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 		}
 
 		if (extra_have && !strcmp(name, ".have")) {
-			sha1_array_append(extra_have, &old_oid);
+			oid_array_append(extra_have, &old_oid);
 			continue;
 		}
 
diff --git a/diff.h b/diff.h
index e9ccb38c26..5be1ee77a7 100644
--- a/diff.h
+++ b/diff.h
@@ -14,7 +14,7 @@ struct diff_queue_struct;
 struct strbuf;
 struct diff_filespec;
 struct userdiff_driver;
-struct sha1_array;
+struct oid_array;
 struct commit;
 struct combine_diff_path;
 
@@ -236,7 +236,7 @@ struct combine_diff_path {
 extern void show_combined_diff(struct combine_diff_path *elem, int num_parent,
 			      int dense, struct rev_info *);
 
-extern void diff_tree_combined(const unsigned char *sha1, const struct sha1_array *parents, int dense, struct rev_info *rev);
+extern void diff_tree_combined(const unsigned char *sha1, const struct oid_array *parents, int dense, struct rev_info *rev);
 
 extern void diff_tree_combined_merge(const struct commit *commit, int dense, struct rev_info *rev);
 
diff --git a/fetch-pack.c b/fetch-pack.c
index f4bbd2892a..4092f8af06 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1015,7 +1015,7 @@ static void update_shallow(struct fetch_pack_args *args,
 			   struct ref **sought, int nr_sought,
 			   struct shallow_info *si)
 {
-	struct sha1_array ref = SHA1_ARRAY_INIT;
+	struct oid_array ref = OID_ARRAY_INIT;
 	int *status;
 	int i;
 
@@ -1038,18 +1038,18 @@ static void update_shallow(struct fetch_pack_args *args,
 		 * shallow points that exist in the pack (iow in repo
 		 * after get_pack() and reprepare_packed_git())
 		 */
-		struct sha1_array extra = SHA1_ARRAY_INIT;
+		struct oid_array extra = OID_ARRAY_INIT;
 		struct object_id *oid = si->shallow->oid;
 		for (i = 0; i < si->shallow->nr; i++)
 			if (has_object_file(&oid[i]))
-				sha1_array_append(&extra, oid + i);
+				oid_array_append(&extra, oid + i);
 		if (extra.nr) {
 			setup_alternate_shallow(&shallow_lock,
 						&alternate_shallow_file,
 						&extra);
 			commit_lock_file(&shallow_lock);
 		}
-		sha1_array_clear(&extra);
+		oid_array_clear(&extra);
 		return;
 	}
 
@@ -1060,7 +1060,7 @@ static void update_shallow(struct fetch_pack_args *args,
 	if (!si->nr_ours && !si->nr_theirs)
 		return;
 	for (i = 0; i < nr_sought; i++)
-		sha1_array_append(&ref, &sought[i]->old_oid);
+		oid_array_append(&ref, &sought[i]->old_oid);
 	si->ref = &ref;
 
 	if (args->update_shallow) {
@@ -1070,23 +1070,23 @@ static void update_shallow(struct fetch_pack_args *args,
 		 * shallow roots that are actually reachable from new
 		 * refs.
 		 */
-		struct sha1_array extra = SHA1_ARRAY_INIT;
+		struct oid_array extra = OID_ARRAY_INIT;
 		struct object_id *oid = si->shallow->oid;
 		assign_shallow_commits_to_refs(si, NULL, NULL);
 		if (!si->nr_ours && !si->nr_theirs) {
-			sha1_array_clear(&ref);
+			oid_array_clear(&ref);
 			return;
 		}
 		for (i = 0; i < si->nr_ours; i++)
-			sha1_array_append(&extra, oid + si->ours[i]);
+			oid_array_append(&extra, oid + si->ours[i]);
 		for (i = 0; i < si->nr_theirs; i++)
-			sha1_array_append(&extra, oid + si->theirs[i]);
+			oid_array_append(&extra, oid + si->theirs[i]);
 		setup_alternate_shallow(&shallow_lock,
 					&alternate_shallow_file,
 					&extra);
 		commit_lock_file(&shallow_lock);
-		sha1_array_clear(&extra);
-		sha1_array_clear(&ref);
+		oid_array_clear(&extra);
+		oid_array_clear(&ref);
 		return;
 	}
 
@@ -1102,7 +1102,7 @@ static void update_shallow(struct fetch_pack_args *args,
 				sought[i]->status = REF_STATUS_REJECT_SHALLOW;
 	}
 	free(status);
-	sha1_array_clear(&ref);
+	oid_array_clear(&ref);
 }
 
 struct ref *fetch_pack(struct fetch_pack_args *args,
@@ -1110,7 +1110,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		       const struct ref *ref,
 		       const char *dest,
 		       struct ref **sought, int nr_sought,
-		       struct sha1_array *shallow,
+		       struct oid_array *shallow,
 		       char **pack_lockfile)
 {
 	struct ref *ref_cpy;
diff --git a/fetch-pack.h b/fetch-pack.h
index a2d46e6e75..b6aeb43a8e 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -4,7 +4,7 @@
 #include "string-list.h"
 #include "run-command.h"
 
-struct sha1_array;
+struct oid_array;
 
 struct fetch_pack_args {
 	const char *uploadpack;
@@ -42,7 +42,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		       const char *dest,
 		       struct ref **sought,
 		       int nr_sought,
-		       struct sha1_array *shallow,
+		       struct oid_array *shallow,
 		       char **pack_lockfile);
 
 /*
diff --git a/fsck.c b/fsck.c
index 24daedd6cc..e6152e4e6d 100644
--- a/fsck.c
+++ b/fsck.c
@@ -132,7 +132,7 @@ static int fsck_msg_type(enum fsck_msg_id msg_id,
 
 static void init_skiplist(struct fsck_options *options, const char *path)
 {
-	static struct sha1_array skiplist = SHA1_ARRAY_INIT;
+	static struct oid_array skiplist = OID_ARRAY_INIT;
 	int sorted, fd;
 	char buffer[GIT_MAX_HEXSZ + 1];
 	struct object_id oid;
@@ -156,7 +156,7 @@ static void init_skiplist(struct fsck_options *options, const char *path)
 			break;
 		if (parse_oid_hex(buffer, &oid, &p) || *p != '\n')
 			die("Invalid SHA-1: %s", buffer);
-		sha1_array_append(&skiplist, &oid);
+		oid_array_append(&skiplist, &oid);
 		if (sorted && skiplist.nr > 1 &&
 				oidcmp(&skiplist.oid[skiplist.nr - 2],
 				       &oid) > 0)
@@ -280,7 +280,7 @@ static int report(struct fsck_options *options, struct object *object,
 		return 0;
 
 	if (options->skiplist && object &&
-			sha1_array_lookup(options->skiplist, &object->oid) >= 0)
+			oid_array_lookup(options->skiplist, &object->oid) >= 0)
 		return 0;
 
 	if (msg_type == FSCK_FATAL)
diff --git a/fsck.h b/fsck.h
index 1891c1863b..4525510d99 100644
--- a/fsck.h
+++ b/fsck.h
@@ -34,7 +34,7 @@ struct fsck_options {
 	fsck_error error_func;
 	unsigned strict:1;
 	int *msg_type;
-	struct sha1_array *skiplist;
+	struct oid_array *skiplist;
 	struct decoration *object_names;
 };
 
diff --git a/parse-options-cb.c b/parse-options-cb.c
index 7baecdc864..7419780a9b 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -99,14 +99,14 @@ int parse_opt_object_name(const struct option *opt, const char *arg, int unset)
 	struct object_id oid;
 
 	if (unset) {
-		sha1_array_clear(opt->value);
+		oid_array_clear(opt->value);
 		return 0;
 	}
 	if (!arg)
 		return -1;
 	if (get_oid(arg, &oid))
 		return error(_("malformed object name '%s'"), arg);
-	sha1_array_append(opt->value, &oid);
+	oid_array_append(opt->value, &oid);
 	return 0;
 }
 
diff --git a/ref-filter.c b/ref-filter.c
index 4ee7ebcda3..fe1abf65ff 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1677,21 +1677,21 @@ static int filter_pattern_match(struct ref_filter *filter, const char *refname)
  * the need to parse the object via parse_object(). peel_ref() might be a
  * more efficient alternative to obtain the pointee.
  */
-static const struct object_id *match_points_at(struct sha1_array *points_at,
+static const struct object_id *match_points_at(struct oid_array *points_at,
 					       const struct object_id *oid,
 					       const char *refname)
 {
 	const struct object_id *tagged_oid = NULL;
 	struct object *obj;
 
-	if (sha1_array_lookup(points_at, oid) >= 0)
+	if (oid_array_lookup(points_at, oid) >= 0)
 		return oid;
 	obj = parse_object(oid->hash);
 	if (!obj)
 		die(_("malformed object at '%s'"), refname);
 	if (obj->type == OBJ_TAG)
 		tagged_oid = &((struct tag *)obj)->tagged->oid;
-	if (tagged_oid && sha1_array_lookup(points_at, tagged_oid) >= 0)
+	if (tagged_oid && oid_array_lookup(points_at, tagged_oid) >= 0)
 		return tagged_oid;
 	return NULL;
 }
diff --git a/ref-filter.h b/ref-filter.h
index e738c5dfd3..e5e177d5f1 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -51,7 +51,7 @@ struct ref_array {
 
 struct ref_filter {
 	const char **name_patterns;
-	struct sha1_array points_at;
+	struct oid_array points_at;
 	struct commit_list *with_commit;
 
 	enum {
diff --git a/remote-curl.c b/remote-curl.c
index 5e712e4aa1..82a019d7db 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -163,7 +163,7 @@ struct discovery {
 	char *buf;
 	size_t len;
 	struct ref *refs;
-	struct sha1_array shallow;
+	struct oid_array shallow;
 	unsigned proto_git : 1;
 };
 static struct discovery *last_discovery;
diff --git a/remote.h b/remote.h
index dd8c517577..eb61cc884d 100644
--- a/remote.h
+++ b/remote.h
@@ -149,11 +149,11 @@ int check_ref_type(const struct ref *ref, int flags);
  */
 void free_refs(struct ref *ref);
 
-struct sha1_array;
+struct oid_array;
 extern struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 				     struct ref **list, unsigned int flags,
-				     struct sha1_array *extra_have,
-				     struct sha1_array *shallow);
+				     struct oid_array *extra_have,
+				     struct oid_array *shallow);
 
 int resolve_remote_symref(struct ref *ref, struct ref *list);
 int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid);
diff --git a/send-pack.c b/send-pack.c
index b3040391cd..312cd2c282 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -50,7 +50,7 @@ static void feed_object(const unsigned char *sha1, FILE *fh, int negative)
 /*
  * Make a pack stream and spit it out into file descriptor fd
  */
-static int pack_objects(int fd, struct ref *refs, struct sha1_array *extra, struct send_pack_args *args)
+static int pack_objects(int fd, struct ref *refs, struct oid_array *extra, struct send_pack_args *args)
 {
 	/*
 	 * The child becomes pack-objects --revs; we feed
@@ -376,7 +376,7 @@ static void reject_invalid_nonce(const char *nonce, int len)
 int send_pack(struct send_pack_args *args,
 	      int fd[], struct child_process *conn,
 	      struct ref *remote_refs,
-	      struct sha1_array *extra_have)
+	      struct oid_array *extra_have)
 {
 	int in = fd[0];
 	int out = fd[1];
diff --git a/send-pack.h b/send-pack.h
index 67fc40f4ec..6af71f7008 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -32,6 +32,6 @@ int option_parse_push_signed(const struct option *opt,
 
 int send_pack(struct send_pack_args *args,
 	      int fd[], struct child_process *conn,
-	      struct ref *remote_refs, struct sha1_array *extra_have);
+	      struct ref *remote_refs, struct oid_array *extra_have);
 
 #endif
diff --git a/sha1-array.c b/sha1-array.c
index 82a7f4435c..7d646ab5b8 100644
--- a/sha1-array.c
+++ b/sha1-array.c
@@ -2,7 +2,7 @@
 #include "sha1-array.h"
 #include "sha1-lookup.h"
 
-void sha1_array_append(struct sha1_array *array, const struct object_id *oid)
+void oid_array_append(struct oid_array *array, const struct object_id *oid)
 {
 	ALLOC_GROW(array->oid, array->nr + 1, array->alloc);
 	oidcpy(&array->oid[array->nr++], oid);
@@ -14,7 +14,7 @@ static int void_hashcmp(const void *a, const void *b)
 	return oidcmp(a, b);
 }
 
-static void sha1_array_sort(struct sha1_array *array)
+static void oid_array_sort(struct oid_array *array)
 {
 	QSORT(array->oid, array->nr, void_hashcmp);
 	array->sorted = 1;
@@ -26,14 +26,14 @@ static const unsigned char *sha1_access(size_t index, void *table)
 	return array[index].hash;
 }
 
-int sha1_array_lookup(struct sha1_array *array, const struct object_id *oid)
+int oid_array_lookup(struct oid_array *array, const struct object_id *oid)
 {
 	if (!array->sorted)
-		sha1_array_sort(array);
+		oid_array_sort(array);
 	return sha1_pos(oid->hash, array->oid, array->nr, sha1_access);
 }
 
-void sha1_array_clear(struct sha1_array *array)
+void oid_array_clear(struct oid_array *array)
 {
 	free(array->oid);
 	array->oid = NULL;
@@ -42,14 +42,14 @@ void sha1_array_clear(struct sha1_array *array)
 	array->sorted = 0;
 }
 
-int sha1_array_for_each_unique(struct sha1_array *array,
+int oid_array_for_each_unique(struct oid_array *array,
 				for_each_oid_fn fn,
 				void *data)
 {
 	int i;
 
 	if (!array->sorted)
-		sha1_array_sort(array);
+		oid_array_sort(array);
 
 	for (i = 0; i < array->nr; i++) {
 		int ret;
diff --git a/sha1-array.h b/sha1-array.h
index e2bb139efb..0a6f9e64ad 100644
--- a/sha1-array.h
+++ b/sha1-array.h
@@ -1,22 +1,22 @@
 #ifndef SHA1_ARRAY_H
 #define SHA1_ARRAY_H
 
-struct sha1_array {
+struct oid_array {
 	struct object_id *oid;
 	int nr;
 	int alloc;
 	int sorted;
 };
 
-#define SHA1_ARRAY_INIT { NULL, 0, 0, 0 }
+#define OID_ARRAY_INIT { NULL, 0, 0, 0 }
 
-void sha1_array_append(struct sha1_array *array, const struct object_id *sha1);
-int sha1_array_lookup(struct sha1_array *array, const struct object_id *oid);
-void sha1_array_clear(struct sha1_array *array);
+void oid_array_append(struct oid_array *array, const struct object_id *sha1);
+int oid_array_lookup(struct oid_array *array, const struct object_id *oid);
+void oid_array_clear(struct oid_array *array);
 
 typedef int (*for_each_oid_fn)(const struct object_id *oid,
 			       void *data);
-int sha1_array_for_each_unique(struct sha1_array *array,
+int oid_array_for_each_unique(struct oid_array *array,
 			       for_each_oid_fn fn,
 			       void *data);
 
diff --git a/sha1_name.c b/sha1_name.c
index a9501fb964..323dd34c63 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -426,13 +426,13 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 
 static int collect_ambiguous(const struct object_id *oid, void *data)
 {
-	sha1_array_append(data, oid);
+	oid_array_append(data, oid);
 	return 0;
 }
 
 int for_each_abbrev(const char *prefix, each_abbrev_fn fn, void *cb_data)
 {
-	struct sha1_array collect = SHA1_ARRAY_INIT;
+	struct oid_array collect = OID_ARRAY_INIT;
 	struct disambiguate_state ds;
 	int ret;
 
@@ -445,8 +445,8 @@ int for_each_abbrev(const char *prefix, each_abbrev_fn fn, void *cb_data)
 	find_short_object_filename(&ds);
 	find_short_packed_object(&ds);
 
-	ret = sha1_array_for_each_unique(&collect, fn, cb_data);
-	sha1_array_clear(&collect);
+	ret = oid_array_for_each_unique(&collect, fn, cb_data);
+	oid_array_clear(&collect);
 	return ret;
 }
 
diff --git a/shallow.c b/shallow.c
index dc7b67a294..25b6db989b 100644
--- a/shallow.c
+++ b/shallow.c
@@ -260,7 +260,7 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
 }
 
 static int write_shallow_commits_1(struct strbuf *out, int use_pack_protocol,
-				   const struct sha1_array *extra,
+				   const struct oid_array *extra,
 				   unsigned flags)
 {
 	struct write_shallow_data data;
@@ -281,14 +281,14 @@ static int write_shallow_commits_1(struct strbuf *out, int use_pack_protocol,
 }
 
 int write_shallow_commits(struct strbuf *out, int use_pack_protocol,
-			  const struct sha1_array *extra)
+			  const struct oid_array *extra)
 {
 	return write_shallow_commits_1(out, use_pack_protocol, extra, 0);
 }
 
 static struct tempfile temporary_shallow;
 
-const char *setup_temporary_shallow(const struct sha1_array *extra)
+const char *setup_temporary_shallow(const struct oid_array *extra)
 {
 	struct strbuf sb = STRBUF_INIT;
 	int fd;
@@ -312,7 +312,7 @@ const char *setup_temporary_shallow(const struct sha1_array *extra)
 
 void setup_alternate_shallow(struct lock_file *shallow_lock,
 			     const char **alternate_shallow_file,
-			     const struct sha1_array *extra)
+			     const struct oid_array *extra)
 {
 	struct strbuf sb = STRBUF_INIT;
 	int fd;
@@ -385,7 +385,7 @@ struct trace_key trace_shallow = TRACE_KEY_INIT(SHALLOW);
  * Step 1, split sender shallow commits into "ours" and "theirs"
  * Step 2, clean "ours" based on .git/shallow
  */
-void prepare_shallow_info(struct shallow_info *info, struct sha1_array *sa)
+void prepare_shallow_info(struct shallow_info *info, struct oid_array *sa)
 {
 	int i;
 	trace_printf_key(&trace_shallow, "shallow: prepare_shallow_info\n");
@@ -560,7 +560,7 @@ void assign_shallow_commits_to_refs(struct shallow_info *info,
 				    uint32_t **used, int *ref_status)
 {
 	struct object_id *oid = info->shallow->oid;
-	struct sha1_array *ref = info->ref;
+	struct oid_array *ref = info->ref;
 	unsigned int i, nr;
 	int *shallow, nr_shallow = 0;
 	struct paint_info pi;
diff --git a/submodule.c b/submodule.c
index 29dd91c793..b6bfb0cad9 100644
--- a/submodule.c
+++ b/submodule.c
@@ -20,8 +20,8 @@ static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
 static int parallel_jobs = 1;
 static struct string_list changed_submodule_paths = STRING_LIST_INIT_NODUP;
 static int initialized_fetch_ref_tips;
-static struct sha1_array ref_tips_before_fetch;
-static struct sha1_array ref_tips_after_fetch;
+static struct oid_array ref_tips_before_fetch;
+static struct oid_array ref_tips_after_fetch;
 
 /*
  * The following flag is set if the .gitmodules file is unmerged. We then
@@ -568,18 +568,18 @@ static int check_has_commit(const struct object_id *oid, void *data)
 	return 0;
 }
 
-static int submodule_has_commits(const char *path, struct sha1_array *commits)
+static int submodule_has_commits(const char *path, struct oid_array *commits)
 {
 	int has_commit = 1;
 
 	if (add_submodule_odb(path))
 		return 0;
 
-	sha1_array_for_each_unique(commits, check_has_commit, &has_commit);
+	oid_array_for_each_unique(commits, check_has_commit, &has_commit);
 	return has_commit;
 }
 
-static int submodule_needs_pushing(const char *path, struct sha1_array *commits)
+static int submodule_needs_pushing(const char *path, struct oid_array *commits)
 {
 	if (!submodule_has_commits(path, commits))
 		/*
@@ -601,7 +601,7 @@ static int submodule_needs_pushing(const char *path, struct sha1_array *commits)
 		int needs_pushing = 0;
 
 		argv_array_push(&cp.args, "rev-list");
-		sha1_array_for_each_unique(commits, append_oid_to_argv, &cp.args);
+		oid_array_for_each_unique(commits, append_oid_to_argv, &cp.args);
 		argv_array_pushl(&cp.args, "--not", "--remotes", "-n", "1" , NULL);
 
 		prepare_submodule_repo_env(&cp.env_array);
@@ -623,18 +623,18 @@ static int submodule_needs_pushing(const char *path, struct sha1_array *commits)
 	return 0;
 }
 
-static struct sha1_array *submodule_commits(struct string_list *submodules,
+static struct oid_array *submodule_commits(struct string_list *submodules,
 					    const char *path)
 {
 	struct string_list_item *item;
 
 	item = string_list_insert(submodules, path);
 	if (item->util)
-		return (struct sha1_array *) item->util;
+		return (struct oid_array *) item->util;
 
-	/* NEEDSWORK: should we have sha1_array_init()? */
-	item->util = xcalloc(1, sizeof(struct sha1_array));
-	return (struct sha1_array *) item->util;
+	/* NEEDSWORK: should we have oid_array_init()? */
+	item->util = xcalloc(1, sizeof(struct oid_array));
+	return (struct oid_array *) item->util;
 }
 
 static void collect_submodules_from_diff(struct diff_queue_struct *q,
@@ -646,11 +646,11 @@ static void collect_submodules_from_diff(struct diff_queue_struct *q,
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
-		struct sha1_array *commits;
+		struct oid_array *commits;
 		if (!S_ISGITLINK(p->two->mode))
 			continue;
 		commits = submodule_commits(submodules, p->two->path);
-		sha1_array_append(commits, &p->two->oid);
+		oid_array_append(commits, &p->two->oid);
 	}
 }
 
@@ -670,11 +670,11 @@ static void free_submodules_sha1s(struct string_list *submodules)
 {
 	struct string_list_item *item;
 	for_each_string_list_item(item, submodules)
-		sha1_array_clear((struct sha1_array *) item->util);
+		oid_array_clear((struct oid_array *) item->util);
 	string_list_clear(submodules, 1);
 }
 
-int find_unpushed_submodules(struct sha1_array *commits,
+int find_unpushed_submodules(struct oid_array *commits,
 		const char *remotes_name, struct string_list *needs_pushing)
 {
 	struct rev_info rev;
@@ -687,7 +687,7 @@ int find_unpushed_submodules(struct sha1_array *commits,
 
 	/* argv.argv[0] will be ignored by setup_revisions */
 	argv_array_push(&argv, "find_unpushed_submodules");
-	sha1_array_for_each_unique(commits, append_oid_to_argv, &argv);
+	oid_array_for_each_unique(commits, append_oid_to_argv, &argv);
 	argv_array_push(&argv, "--not");
 	argv_array_pushf(&argv, "--remotes=%s", remotes_name);
 
@@ -702,7 +702,7 @@ int find_unpushed_submodules(struct sha1_array *commits,
 	argv_array_clear(&argv);
 
 	for_each_string_list_item(submodule, &submodules) {
-		struct sha1_array *commits = (struct sha1_array *) submodule->util;
+		struct oid_array *commits = (struct oid_array *) submodule->util;
 
 		if (submodule_needs_pushing(submodule->string, commits))
 			string_list_insert(needs_pushing, submodule->string);
@@ -735,7 +735,7 @@ static int push_submodule(const char *path, int dry_run)
 	return 1;
 }
 
-int push_unpushed_submodules(struct sha1_array *commits,
+int push_unpushed_submodules(struct oid_array *commits,
 			     const char *remotes_name,
 			     int dry_run)
 {
@@ -817,7 +817,7 @@ static void submodule_collect_changed_cb(struct diff_queue_struct *q,
 static int add_sha1_to_array(const char *ref, const struct object_id *oid,
 			     int flags, void *data)
 {
-	sha1_array_append(data, oid);
+	oid_array_append(data, oid);
 	return 0;
 }
 
@@ -828,7 +828,7 @@ void check_for_new_submodule_commits(struct object_id *oid)
 		initialized_fetch_ref_tips = 1;
 	}
 
-	sha1_array_append(&ref_tips_after_fetch, oid);
+	oid_array_append(&ref_tips_after_fetch, oid);
 }
 
 static int add_oid_to_argv(const struct object_id *oid, void *data)
@@ -849,10 +849,10 @@ static void calculate_changed_submodule_paths(void)
 
 	init_revisions(&rev, NULL);
 	argv_array_push(&argv, "--"); /* argv[0] program name */
-	sha1_array_for_each_unique(&ref_tips_after_fetch,
+	oid_array_for_each_unique(&ref_tips_after_fetch,
 				   add_oid_to_argv, &argv);
 	argv_array_push(&argv, "--not");
-	sha1_array_for_each_unique(&ref_tips_before_fetch,
+	oid_array_for_each_unique(&ref_tips_before_fetch,
 				   add_oid_to_argv, &argv);
 	setup_revisions(argv.argc, argv.argv, &rev, NULL);
 	if (prepare_revision_walk(&rev))
@@ -879,8 +879,8 @@ static void calculate_changed_submodule_paths(void)
 	}
 
 	argv_array_clear(&argv);
-	sha1_array_clear(&ref_tips_before_fetch);
-	sha1_array_clear(&ref_tips_after_fetch);
+	oid_array_clear(&ref_tips_before_fetch);
+	oid_array_clear(&ref_tips_after_fetch);
 	initialized_fetch_ref_tips = 0;
 }
 
diff --git a/submodule.h b/submodule.h
index 9c32b28b12..decca25e37 100644
--- a/submodule.h
+++ b/submodule.h
@@ -3,7 +3,7 @@
 
 struct diff_options;
 struct argv_array;
-struct sha1_array;
+struct oid_array;
 
 enum {
 	RECURSE_SUBMODULES_ONLY = -5,
@@ -73,10 +73,10 @@ extern int merge_submodule(unsigned char result[20], const char *path,
 			   const unsigned char base[20],
 			   const unsigned char a[20],
 			   const unsigned char b[20], int search);
-extern int find_unpushed_submodules(struct sha1_array *commits,
+extern int find_unpushed_submodules(struct oid_array *commits,
 				    const char *remotes_name,
 				    struct string_list *needs_pushing);
-extern int push_unpushed_submodules(struct sha1_array *commits,
+extern int push_unpushed_submodules(struct oid_array *commits,
 				    const char *remotes_name,
 				    int dry_run);
 extern void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
diff --git a/t/helper/test-sha1-array.c b/t/helper/test-sha1-array.c
index 2f3d406b63..edfd52d82a 100644
--- a/t/helper/test-sha1-array.c
+++ b/t/helper/test-sha1-array.c
@@ -9,7 +9,7 @@ static int print_oid(const struct object_id *oid, void *data)
 
 int cmd_main(int argc, const char **argv)
 {
-	struct sha1_array array = SHA1_ARRAY_INIT;
+	struct oid_array array = OID_ARRAY_INIT;
 	struct strbuf line = STRBUF_INIT;
 
 	while (strbuf_getline(&line, stdin) != EOF) {
@@ -19,15 +19,15 @@ int cmd_main(int argc, const char **argv)
 		if (skip_prefix(line.buf, "append ", &arg)) {
 			if (get_oid_hex(arg, &oid))
 				die("not a hexadecimal SHA1: %s", arg);
-			sha1_array_append(&array, &oid);
+			oid_array_append(&array, &oid);
 		} else if (skip_prefix(line.buf, "lookup ", &arg)) {
 			if (get_oid_hex(arg, &oid))
 				die("not a hexadecimal SHA1: %s", arg);
-			printf("%d\n", sha1_array_lookup(&array, &oid));
+			printf("%d\n", oid_array_lookup(&array, &oid));
 		} else if (!strcmp(line.buf, "clear"))
-			sha1_array_clear(&array);
+			oid_array_clear(&array);
 		else if (!strcmp(line.buf, "for_each_unique"))
-			sha1_array_for_each_unique(&array, print_oid, NULL);
+			oid_array_for_each_unique(&array, print_oid, NULL);
 		else
 			die("unknown command: %s", line.buf);
 	}
diff --git a/transport.c b/transport.c
index e492757726..c83f3b71be 100644
--- a/transport.c
+++ b/transport.c
@@ -116,8 +116,8 @@ struct git_transport_data {
 	struct child_process *conn;
 	int fd[2];
 	unsigned got_remote_heads : 1;
-	struct sha1_array extra_have;
-	struct sha1_array shallow;
+	struct oid_array extra_have;
+	struct oid_array shallow;
 };
 
 static int set_git_option(struct git_transport_options *opts,
@@ -1023,20 +1023,20 @@ int transport_push(struct transport *transport,
 			      TRANSPORT_RECURSE_SUBMODULES_ONLY)) &&
 		    !is_bare_repository()) {
 			struct ref *ref = remote_refs;
-			struct sha1_array commits = SHA1_ARRAY_INIT;
+			struct oid_array commits = OID_ARRAY_INIT;
 
 			for (; ref; ref = ref->next)
 				if (!is_null_oid(&ref->new_oid))
-					sha1_array_append(&commits,
+					oid_array_append(&commits,
 							  &ref->new_oid);
 
 			if (!push_unpushed_submodules(&commits,
 						      transport->remote->name,
 						      pretend)) {
-				sha1_array_clear(&commits);
+				oid_array_clear(&commits);
 				die("Failed to push all needed submodules!");
 			}
-			sha1_array_clear(&commits);
+			oid_array_clear(&commits);
 		}
 
 		if (((flags & TRANSPORT_RECURSE_SUBMODULES_CHECK) ||
@@ -1045,20 +1045,20 @@ int transport_push(struct transport *transport,
 		      !pretend)) && !is_bare_repository()) {
 			struct ref *ref = remote_refs;
 			struct string_list needs_pushing = STRING_LIST_INIT_DUP;
-			struct sha1_array commits = SHA1_ARRAY_INIT;
+			struct oid_array commits = OID_ARRAY_INIT;
 
 			for (; ref; ref = ref->next)
 				if (!is_null_oid(&ref->new_oid))
-					sha1_array_append(&commits,
+					oid_array_append(&commits,
 							  &ref->new_oid);
 
 			if (find_unpushed_submodules(&commits, transport->remote->name,
 						&needs_pushing)) {
-				sha1_array_clear(&commits);
+				oid_array_clear(&commits);
 				die_with_unpushed_submodules(&needs_pushing);
 			}
 			string_list_clear(&needs_pushing, 0);
-			sha1_array_clear(&commits);
+			oid_array_clear(&commits);
 		}
 
 		if (!(flags & TRANSPORT_RECURSE_SUBMODULES_ONLY))

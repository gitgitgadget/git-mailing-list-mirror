Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1DEE207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 15:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754869AbcI2P1u (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 11:27:50 -0400
Received: from mout.web.de ([212.227.15.3]:59263 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753791AbcI2P1r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 11:27:47 -0400
Received: from [192.168.178.36] ([79.213.113.239]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0LrsGE-1anT3y3kQ2-013dZ4; Thu, 29 Sep 2016 17:27:41
 +0200
Subject: [PATCH 2/3] use QSORT
To:     Git List <git@vger.kernel.org>
References: <67bddc37-4ee2-fef0-c852-e32645421e4c@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <141968a6-bcf9-8792-0313-47a1e10c60f9@web.de>
Date:   Thu, 29 Sep 2016 17:27:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <67bddc37-4ee2-fef0-c852-e32645421e4c@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:ghLEAl8hePAh/Js8J0tK2lIy69ojsnVdbe9mko0lYxuf99ztiKD
 NMVB4jFAinyyVCfdiMfq0q9VohwkEhintM/0pSArR+azUTxO8mKZ6kUrcfcput8hmgzhTg+
 wCcpn4MEvhI8TEpuyVRMgJPsF0wjYhp+Pdg0TIVXxXMaUGqVotT5bpR+jt6Y7NFOwyLCt13
 gmoqNTdGtRCmD7NCbmquA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ug7zFMv7yHk=:RjBHI43f+956pFuGzr6aTs
 aLOwQ/Ar5+d3fJOfilT5bqsZedhD8Q2b2NzorzeZkJkoQJdCnmpdkhipF6ccyCWMXUzflnAJE
 NemUNzMYLZFEjTwYe+m/Rx4FpbGEAb4806UPMGCmweBGnk6rfm4r0ApWOcnFz6/auzaDb0Z/m
 jQmqeOUY5daZQnG36EqAnMuBF4pHqpaGtr6iOa5dEQwtrK/15VTTClHtAVoRxGU/P+2K5ZSGi
 0O9kainMg2qtwzt3xspieJQ27i5ZdhfQOLfPN6SEuLswER69C7VAXxj2ZN1cKuqTml1R8yKN4
 nm46RYRdz7/Lx2autpip3fSzDwx1Nft3AMaDPf6kUTy6pfu7QBodmIebZWiMZqTWNZUPJsW/m
 9Az8zB4/UYpBS2SSoiVDh9AFGax86u2b0hmvVHn8c/oi7C5GcTi02bs/raJ9iPZmWL5XzoKKM
 ZzneKu5K77kytrrA+QilbXEoV/Eihsl27a6uv/GuCJ+v9z8zYeeRu1Y4uxO0aK15N5Q0iBosc
 etD/bNPsZbKALGEr4RFg4LZTZhe7+KazXxB7yLb9nwV0BakgAxo6Eu6Cb7oITrOnJ1r/og27s
 KVC9iacZ5ERURpGjAp3vbrdEJd3ZwyvPFm3oOlI//JCXWMFeZRTuFrd8LzfdWfeWyO3SiZLZO
 s8T0UdiMqZCzJ7x9MnZqsoxLBwSFPqZwOfo8/bCTT3y84G9d2Xl/zRITn4xrJ272cy3/MFmOt
 KibksanbNYZguaZCxr/Dg6Tyq5gf49jrA2Mi4q+2HJvrV8ZQ7Ss23tD9cm8ih589vUmJ/GWTt
 VaBOEMs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apply the semantic patch contrib/coccinelle/qsort.cocci to the code
base, replacing calls of qsort(3) with QSORT.  The resulting code is
shorter and supports empty arrays with NULL pointers.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
Freshly generated using coccicheck, compiles, survives make test.

 bisect.c                             |  2 +-
 builtin/describe.c                   |  2 +-
 builtin/fast-export.c                |  2 +-
 builtin/fmt-merge-msg.c              |  6 ++----
 builtin/index-pack.c                 |  8 +++-----
 builtin/mktree.c                     |  2 +-
 builtin/name-rev.c                   |  3 +--
 builtin/pack-objects.c               |  7 +++----
 builtin/remote.c                     |  3 +--
 diff.c                               |  6 +++---
 diffcore-delta.c                     |  5 +----
 diffcore-order.c                     |  2 +-
 diffcore-rename.c                    |  2 +-
 dir.c                                |  4 ++--
 fast-import.c                        |  4 ++--
 fetch-pack.c                         |  2 +-
 help.c                               | 15 +++++----------
 line-log.c                           |  2 +-
 pack-bitmap-write.c                  |  3 +--
 pack-check.c                         |  2 +-
 pack-write.c                         |  3 +--
 pathspec.c                           |  3 +--
 ref-filter.c                         |  2 +-
 refs/files-backend.c                 |  2 +-
 server-info.c                        |  2 +-
 sh-i18n--envsubst.c                  |  2 +-
 sha1-array.c                         |  2 +-
 string-list.c                        |  2 +-
 t/helper/test-dump-untracked-cache.c |  6 ++----
 tree.c                               |  3 +--
 30 files changed, 44 insertions(+), 65 deletions(-)

diff --git a/bisect.c b/bisect.c
index 6f512c2..21bc6da 100644
--- a/bisect.c
+++ b/bisect.c
@@ -215,7 +215,7 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
 		array[cnt].distance = distance;
 		cnt++;
 	}
-	qsort(array, cnt, sizeof(*array), compare_commit_dist);
+	QSORT(array, cnt, compare_commit_dist);
 	for (p = list, i = 0; i < cnt; i++) {
 		char buf[100]; /* enough for dist=%d */
 		struct object *obj = &(array[i].commit->object);
diff --git a/builtin/describe.c b/builtin/describe.c
index 8a25abe..01490a1 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -352,7 +352,7 @@ static void describe(const char *arg, int last_one)
 			    oid_to_hex(oid));
 	}
 
-	qsort(all_matches, match_cnt, sizeof(all_matches[0]), compare_pt);
+	QSORT(all_matches, match_cnt, compare_pt);
 
 	if (gave_up_on) {
 		commit_list_insert_by_date(gave_up_on, &list);
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index c0652a7..1e815b5 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -347,7 +347,7 @@ static void show_filemodify(struct diff_queue_struct *q,
 	 * Handle files below a directory first, in case they are all deleted
 	 * and the directory changes to a file or symlink.
 	 */
-	qsort(q->queue, q->nr, sizeof(q->queue[0]), depth_first);
+	QSORT(q->queue, q->nr, depth_first);
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filespec *ospec = q->queue[i]->one;
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index dc2e9e4..4976967 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -315,12 +315,10 @@ static void add_people_info(struct strbuf *out,
 			    struct string_list *committers)
 {
 	if (authors->nr)
-		qsort(authors->items,
-		      authors->nr, sizeof(authors->items[0]),
+		QSORT(authors->items, authors->nr,
 		      cmp_string_list_util_as_integral);
 	if (committers->nr)
-		qsort(committers->items,
-		      committers->nr, sizeof(committers->items[0]),
+		QSORT(committers->items, committers->nr,
 		      cmp_string_list_util_as_integral);
 
 	credit_people(out, authors, 'a');
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 4a8b4ae..7657d0a 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1190,10 +1190,8 @@ static void resolve_deltas(void)
 		return;
 
 	/* Sort deltas by base SHA1/offset for fast searching */
-	qsort(ofs_deltas, nr_ofs_deltas, sizeof(struct ofs_delta_entry),
-	      compare_ofs_delta_entry);
-	qsort(ref_deltas, nr_ref_deltas, sizeof(struct ref_delta_entry),
-	      compare_ref_delta_entry);
+	QSORT(ofs_deltas, nr_ofs_deltas, compare_ofs_delta_entry);
+	QSORT(ref_deltas, nr_ref_deltas, compare_ref_delta_entry);
 
 	if (verbose || show_resolving_progress)
 		progress = start_progress(_("Resolving deltas"),
@@ -1356,7 +1354,7 @@ static void fix_unresolved_deltas(struct sha1file *f)
 	ALLOC_ARRAY(sorted_by_pos, nr_ref_deltas);
 	for (i = 0; i < nr_ref_deltas; i++)
 		sorted_by_pos[i] = &ref_deltas[i];
-	qsort(sorted_by_pos, nr_ref_deltas, sizeof(*sorted_by_pos), delta_pos_compare);
+	QSORT(sorted_by_pos, nr_ref_deltas, delta_pos_compare);
 
 	for (i = 0; i < nr_ref_deltas; i++) {
 		struct ref_delta_entry *d = sorted_by_pos[i];
diff --git a/builtin/mktree.c b/builtin/mktree.c
index 4282b62..de9b40f 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -46,7 +46,7 @@ static void write_tree(unsigned char *sha1)
 	size_t size;
 	int i;
 
-	qsort(entries, used, sizeof(*entries), ent_compare);
+	QSORT(entries, used, ent_compare);
 	for (size = i = 0; i < used; i++)
 		size += 32 + entries[i]->len;
 
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 57be35f..cd89d48 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -195,8 +195,7 @@ static const char *get_exact_ref_match(const struct object *o)
 		return NULL;
 
 	if (!tip_table.sorted) {
-		qsort(tip_table.table, tip_table.nr, sizeof(*tip_table.table),
-		      tipcmp);
+		QSORT(tip_table.table, tip_table.nr, tipcmp);
 		tip_table.sorted = 1;
 	}
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 166e52c..8aeba6a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1535,7 +1535,7 @@ static void get_object_details(void)
 	sorted_by_offset = xcalloc(to_pack.nr_objects, sizeof(struct object_entry *));
 	for (i = 0; i < to_pack.nr_objects; i++)
 		sorted_by_offset[i] = to_pack.objects + i;
-	qsort(sorted_by_offset, to_pack.nr_objects, sizeof(*sorted_by_offset), pack_offset_sort);
+	QSORT(sorted_by_offset, to_pack.nr_objects, pack_offset_sort);
 
 	for (i = 0; i < to_pack.nr_objects; i++) {
 		struct object_entry *entry = sorted_by_offset[i];
@@ -2257,7 +2257,7 @@ static void prepare_pack(int window, int depth)
 		if (progress)
 			progress_state = start_progress(_("Compressing objects"),
 							nr_deltas);
-		qsort(delta_list, n, sizeof(*delta_list), type_size_sort);
+		QSORT(delta_list, n, type_size_sort);
 		ll_find_deltas(delta_list, n, window+1, depth, &nr_done);
 		stop_progress(&progress_state);
 		if (nr_done != nr_deltas)
@@ -2449,8 +2449,7 @@ static void add_objects_in_unpacked_packs(struct rev_info *revs)
 	}
 
 	if (in_pack.nr) {
-		qsort(in_pack.array, in_pack.nr, sizeof(in_pack.array[0]),
-		      ofscmp);
+		QSORT(in_pack.array, in_pack.nr, ofscmp);
 		for (i = 0; i < in_pack.nr; i++) {
 			struct object *o = in_pack.array[i].object;
 			add_object_entry(o->oid.hash, o->type, "", 0);
diff --git a/builtin/remote.c b/builtin/remote.c
index 9f6a6b3..e52cf39 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1197,8 +1197,7 @@ static int show(int argc, const char **argv)
 
 		info.width = info.width2 = 0;
 		for_each_string_list(&states.push, add_push_to_show_info, &info);
-		qsort(info.list->items, info.list->nr,
-			sizeof(*info.list->items), cmp_string_with_push);
+		QSORT(info.list->items, info.list->nr, cmp_string_with_push);
 		if (info.list->nr)
 			printf_ln(Q_("  Local ref configured for 'git push'%s:",
 				     "  Local refs configured for 'git push'%s:",
diff --git a/diff.c b/diff.c
index a178ed3..c2f09fb 100644
--- a/diff.c
+++ b/diff.c
@@ -2019,7 +2019,7 @@ static void show_dirstat(struct diff_options *options)
 		return;
 
 	/* Show all directories with more than x% of the changes */
-	qsort(dir.files, dir.nr, sizeof(dir.files[0]), dirstat_compare);
+	QSORT(dir.files, dir.nr, dirstat_compare);
 	gather_dirstat(options, &dir, changed, "", 0);
 }
 
@@ -2063,7 +2063,7 @@ static void show_dirstat_by_line(struct diffstat_t *data, struct diff_options *o
 		return;
 
 	/* Show all directories with more than x% of the changes */
-	qsort(dir.files, dir.nr, sizeof(dir.files[0]), dirstat_compare);
+	QSORT(dir.files, dir.nr, dirstat_compare);
 	gather_dirstat(options, &dir, changed, "", 0);
 }
 
@@ -4923,7 +4923,7 @@ static int diffnamecmp(const void *a_, const void *b_)
 void diffcore_fix_diff_index(struct diff_options *options)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
-	qsort(q->queue, q->nr, sizeof(q->queue[0]), diffnamecmp);
+	QSORT(q->queue, q->nr, diffnamecmp);
 }
 
 void diffcore_std(struct diff_options *options)
diff --git a/diffcore-delta.c b/diffcore-delta.c
index 4159748..2ebedb3 100644
--- a/diffcore-delta.c
+++ b/diffcore-delta.c
@@ -158,10 +158,7 @@ static struct spanhash_top *hash_chars(struct diff_filespec *one)
 		n = 0;
 		accum1 = accum2 = 0;
 	}
-	qsort(hash->data,
-		1ul << hash->alloc_log2,
-		sizeof(hash->data[0]),
-		spanhash_cmp);
+	QSORT(hash->data, 1ul << hash->alloc_log2, spanhash_cmp);
 	return hash;
 }
 
diff --git a/diffcore-order.c b/diffcore-order.c
index 69d41f7..1957f82 100644
--- a/diffcore-order.c
+++ b/diffcore-order.c
@@ -101,7 +101,7 @@ void order_objects(const char *orderfile, obj_path_fn_t obj_path,
 		objs[i].orig_order = i;
 		objs[i].order = match_order(obj_path(objs[i].obj));
 	}
-	qsort(objs, nr, sizeof(*objs), compare_objs_order);
+	QSORT(objs, nr, compare_objs_order);
 }
 
 static const char *pair_pathtwo(void *obj)
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 73d003a..54a2396 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -580,7 +580,7 @@ void diffcore_rename(struct diff_options *options)
 	stop_progress(&progress);
 
 	/* cost matrix sorted by most to least similar pair */
-	qsort(mx, dst_cnt * NUM_CANDIDATE_PER_DST, sizeof(*mx), score_compare);
+	QSORT(mx, dst_cnt * NUM_CANDIDATE_PER_DST, score_compare);
 
 	rename_count += find_renames(mx, dst_cnt, minimum_score, 0);
 	if (detect_rename == DIFF_DETECT_COPY)
diff --git a/dir.c b/dir.c
index 9e09bcb..3bad1ad 100644
--- a/dir.c
+++ b/dir.c
@@ -2005,8 +2005,8 @@ int read_directory(struct dir_struct *dir, const char *path, int len, const stru
 	if (!len || treat_leading_path(dir, path, len, simplify))
 		read_directory_recursive(dir, path, len, untracked, 0, simplify);
 	free_simplify(simplify);
-	qsort(dir->entries, dir->nr, sizeof(struct dir_entry *), cmp_name);
-	qsort(dir->ignored, dir->ignored_nr, sizeof(struct dir_entry *), cmp_name);
+	QSORT(dir->entries, dir->nr, cmp_name);
+	QSORT(dir->ignored, dir->ignored_nr, cmp_name);
 	if (dir->untracked) {
 		static struct trace_key trace_untracked_stats = TRACE_KEY_INIT(UNTRACKED_STATS);
 		trace_printf_key(&trace_untracked_stats,
diff --git a/fast-import.c b/fast-import.c
index bf53ac9..cb545d7 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1460,9 +1460,9 @@ static void mktree(struct tree_content *t, int v, struct strbuf *b)
 	unsigned int i;
 
 	if (!v)
-		qsort(t->entries,t->entry_count,sizeof(t->entries[0]),tecmp0);
+		QSORT(t->entries, t->entry_count, tecmp0);
 	else
-		qsort(t->entries,t->entry_count,sizeof(t->entries[0]),tecmp1);
+		QSORT(t->entries, t->entry_count, tecmp1);
 
 	for (i = 0; i < t->entry_count; i++) {
 		if (t->entries[i]->versions[v].mode)
diff --git a/fetch-pack.c b/fetch-pack.c
index 85e77af..8a38d30 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -812,7 +812,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	int agent_len;
 
 	sort_ref_list(&ref, ref_compare_name);
-	qsort(sought, nr_sought, sizeof(*sought), cmp_ref_by_name);
+	QSORT(sought, nr_sought, cmp_ref_by_name);
 
 	if ((args->depth > 0 || is_repository_shallow()) && !server_supports("shallow"))
 		die("Server does not support shallow clients");
diff --git a/help.c b/help.c
index 2ff3b5a..53e2a67 100644
--- a/help.c
+++ b/help.c
@@ -170,8 +170,7 @@ void load_command_list(const char *prefix,
 
 	if (exec_path) {
 		list_commands_in_dir(main_cmds, exec_path, prefix);
-		qsort(main_cmds->names, main_cmds->cnt,
-		      sizeof(*main_cmds->names), cmdname_compare);
+		QSORT(main_cmds->names, main_cmds->cnt, cmdname_compare);
 		uniq(main_cmds);
 	}
 
@@ -190,8 +189,7 @@ void load_command_list(const char *prefix,
 		}
 		free(paths);
 
-		qsort(other_cmds->names, other_cmds->cnt,
-		      sizeof(*other_cmds->names), cmdname_compare);
+		QSORT(other_cmds->names, other_cmds->cnt, cmdname_compare);
 		uniq(other_cmds);
 	}
 	exclude_cmds(other_cmds, main_cmds);
@@ -238,8 +236,7 @@ void list_common_cmds_help(void)
 			longest = strlen(common_cmds[i].name);
 	}
 
-	qsort(common_cmds, ARRAY_SIZE(common_cmds),
-		sizeof(common_cmds[0]), cmd_group_cmp);
+	QSORT(common_cmds, ARRAY_SIZE(common_cmds), cmd_group_cmp);
 
 	puts(_("These are common Git commands used in various situations:"));
 
@@ -324,8 +321,7 @@ const char *help_unknown_cmd(const char *cmd)
 
 	add_cmd_list(&main_cmds, &aliases);
 	add_cmd_list(&main_cmds, &other_cmds);
-	qsort(main_cmds.names, main_cmds.cnt,
-	      sizeof(*main_cmds.names), cmdname_compare);
+	QSORT(main_cmds.names, main_cmds.cnt, cmdname_compare);
 	uniq(&main_cmds);
 
 	/* This abuses cmdname->len for levenshtein distance */
@@ -359,8 +355,7 @@ const char *help_unknown_cmd(const char *cmd)
 			levenshtein(cmd, candidate, 0, 2, 1, 3) + 1;
 	}
 
-	qsort(main_cmds.names, main_cmds.cnt,
-	      sizeof(*main_cmds.names), levenshtein_compare);
+	QSORT(main_cmds.names, main_cmds.cnt, levenshtein_compare);
 
 	if (!main_cmds.cnt)
 		die(_("Uh oh. Your system reports no Git commands at all."));
diff --git a/line-log.c b/line-log.c
index 916e724..65f3558 100644
--- a/line-log.c
+++ b/line-log.c
@@ -113,7 +113,7 @@ void sort_and_merge_range_set(struct range_set *rs)
 	int i;
 	int o = 0; /* output cursor */
 
-	qsort(rs->ranges, rs->nr, sizeof(struct range), range_cmp);
+	QSORT(rs->ranges, rs->nr, range_cmp);
 
 	for (i = 0; i < rs->nr; i++) {
 		if (rs->ranges[i].start == rs->ranges[i].end)
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index c30bcd0..9705596 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -385,8 +385,7 @@ void bitmap_writer_select_commits(struct commit **indexed_commits,
 {
 	unsigned int i = 0, j, next;
 
-	qsort(indexed_commits, indexed_commits_nr, sizeof(indexed_commits[0]),
-	      date_compare);
+	QSORT(indexed_commits, indexed_commits_nr, date_compare);
 
 	if (writer.show_progress)
 		writer.progress = start_progress("Selecting bitmap commits", 0);
diff --git a/pack-check.c b/pack-check.c
index d123846..72440a8 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -99,7 +99,7 @@ static int verify_packfile(struct packed_git *p,
 		entries[i].offset = nth_packed_object_offset(p, i);
 		entries[i].nr = i;
 	}
-	qsort(entries, nr_objects, sizeof(*entries), compare_entries);
+	QSORT(entries, nr_objects, compare_entries);
 
 	for (i = 0; i < nr_objects; i++) {
 		void *data;
diff --git a/pack-write.c b/pack-write.c
index ea0b788..88bc7f9 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -61,8 +61,7 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 			if (objects[i]->offset > last_obj_offset)
 				last_obj_offset = objects[i]->offset;
 		}
-		qsort(sorted_by_sha, nr_objects, sizeof(sorted_by_sha[0]),
-		      sha1_compare);
+		QSORT(sorted_by_sha, nr_objects, sha1_compare);
 	}
 	else
 		sorted_by_sha = list = last = NULL;
diff --git a/pathspec.c b/pathspec.c
index 24e0dd5..eda13b5 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -446,8 +446,7 @@ void parse_pathspec(struct pathspec *pathspec,
 	if (pathspec->magic & PATHSPEC_MAXDEPTH) {
 		if (flags & PATHSPEC_KEEP_ORDER)
 			die("BUG: PATHSPEC_MAXDEPTH_VALID and PATHSPEC_KEEP_ORDER are incompatible");
-		qsort(pathspec->items, pathspec->nr,
-		      sizeof(struct pathspec_item), pathspec_item_cmp);
+		QSORT(pathspec->items, pathspec->nr, pathspec_item_cmp);
 	}
 }
 
diff --git a/ref-filter.c b/ref-filter.c
index 9adbb8a..44029b0 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1573,7 +1573,7 @@ static int compare_refs(const void *a_, const void *b_)
 void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
 {
 	ref_sorting = sorting;
-	qsort(array->items, array->nr, sizeof(struct ref_array_item *), compare_refs);
+	QSORT(array->items, array->nr, compare_refs);
 }
 
 static void append_literal(const char *cp, const char *ep, struct ref_formatting_state *state)
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0709f60..d16feb1 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -501,7 +501,7 @@ static void sort_ref_dir(struct ref_dir *dir)
 	if (dir->sorted == dir->nr)
 		return;
 
-	qsort(dir->entries, dir->nr, sizeof(*dir->entries), ref_entry_cmp);
+	QSORT(dir->entries, dir->nr, ref_entry_cmp);
 
 	/* Remove any duplicates: */
 	for (i = 0, j = 0; j < dir->nr; j++) {
diff --git a/server-info.c b/server-info.c
index 75dd677..7bc4e75 100644
--- a/server-info.c
+++ b/server-info.c
@@ -229,7 +229,7 @@ static void init_pack_info(const char *infofile, int force)
 	}
 
 	/* renumber them */
-	qsort(info, num_pack, sizeof(info[0]), compare_info);
+	QSORT(info, num_pack, compare_info);
 	for (i = 0; i < num_pack; i++)
 		info[i]->new_num = i;
 }
diff --git a/sh-i18n--envsubst.c b/sh-i18n--envsubst.c
index e06b2c1..3637a2a 100644
--- a/sh-i18n--envsubst.c
+++ b/sh-i18n--envsubst.c
@@ -231,7 +231,7 @@ static inline void
 string_list_sort (string_list_ty *slp)
 {
   if (slp->nitems > 0)
-    qsort (slp->item, slp->nitems, sizeof (slp->item[0]), cmp_string);
+    QSORT(slp->item, slp->nitems, cmp_string);
 }
 
 /* Test whether a sorted string list contains a given string.  */
diff --git a/sha1-array.c b/sha1-array.c
index 6f4a224..21188de 100644
--- a/sha1-array.c
+++ b/sha1-array.c
@@ -16,7 +16,7 @@ static int void_hashcmp(const void *a, const void *b)
 
 static void sha1_array_sort(struct sha1_array *array)
 {
-	qsort(array->sha1, array->nr, sizeof(*array->sha1), void_hashcmp);
+	QSORT(array->sha1, array->nr, void_hashcmp);
 	array->sorted = 1;
 }
 
diff --git a/string-list.c b/string-list.c
index 62d2084..8c83cac 100644
--- a/string-list.c
+++ b/string-list.c
@@ -225,7 +225,7 @@ static int cmp_items(const void *a, const void *b)
 void string_list_sort(struct string_list *list)
 {
 	compare_for_qsort = list->cmp ? list->cmp : strcmp;
-	qsort(list->items, list->nr, sizeof(*list->items), cmp_items);
+	QSORT(list->items, list->nr, cmp_items);
 }
 
 struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
diff --git a/t/helper/test-dump-untracked-cache.c b/t/helper/test-dump-untracked-cache.c
index 50112cc..f752532 100644
--- a/t/helper/test-dump-untracked-cache.c
+++ b/t/helper/test-dump-untracked-cache.c
@@ -18,10 +18,8 @@ static int compare_dir(const void *a_, const void *b_)
 static void dump(struct untracked_cache_dir *ucd, struct strbuf *base)
 {
 	int i, len;
-	qsort(ucd->untracked, ucd->untracked_nr, sizeof(*ucd->untracked),
-	      compare_untracked);
-	qsort(ucd->dirs, ucd->dirs_nr, sizeof(*ucd->dirs),
-	      compare_dir);
+	QSORT(ucd->untracked, ucd->untracked_nr, compare_untracked);
+	QSORT(ucd->dirs, ucd->dirs_nr, compare_dir);
 	len = base->len;
 	strbuf_addf(base, "%s/", ucd->name);
 	printf("%s %s", base->buf,
diff --git a/tree.c b/tree.c
index 2b5a5a8..ce345c5 100644
--- a/tree.c
+++ b/tree.c
@@ -180,8 +180,7 @@ int read_tree(struct tree *tree, int stage, struct pathspec *match)
 	 * Sort the cache entry -- we need to nuke the cache tree, though.
 	 */
 	cache_tree_free(&active_cache_tree);
-	qsort(active_cache, active_nr, sizeof(active_cache[0]),
-	      cmp_cache_name_compare);
+	QSORT(active_cache, active_nr, cmp_cache_name_compare);
 	return 0;
 }
 
-- 
2.10.0


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E087D1F97E
	for <e@80x24.org>; Sun, 14 Oct 2018 14:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbeJNWKg (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Oct 2018 18:10:36 -0400
Received: from mout.web.de ([212.227.17.11]:45759 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbeJNWKg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Oct 2018 18:10:36 -0400
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LuLt5-1fU5BL2qPP-011hef; Sun, 14
 Oct 2018 16:29:08 +0200
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LuLt5-1fU5BL2qPP-011hef; Sun, 14
 Oct 2018 16:29:08 +0200
Subject: Re: [PATCH 15/16] commit-reach: make can_all_from_reach... linear
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.10.git.gitgitgadget@gmail.com>
 <816821eec9ba476ccdfbfdf6e3cdd3619743ea2e.1531746012.git.gitgitgadget@gmail.com>
 <d1b58614-989f-5998-6c53-c19eee409a2f@web.de>
 <dd798e76-922f-a113-4408-e3892bee3b44@gmail.com>
 <223b14f7-213f-4d22-4776-22dcfd1806c2@web.de>
 <7b95417a-c8fb-4f1e-cb09-c36804a3a4d0@web.de>
 <20181005165157.GC11254@sigill.intra.peff.net>
 <dca35e44-a763-bcf0-f457-b8dab53815cf@web.de>
 <20181005190847.GC17482@sigill.intra.peff.net>
 <c05f192b-4e89-48b0-1c23-b43ec6fdb74b@web.de>
 <20181005194223.GA19428@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <c141fb44-904f-e8b6-119f-7d2d6bcfd81a@web.de>
Date:   Sun, 14 Oct 2018 16:29:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181005194223.GA19428@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xfXnefMWeOYoUYkCLi8N9M4mhi/JQd7a5eBtPGwZw+d9prgamxv
 SajuYNLyykh0R4pHNHYwkBEShP/P+2XRNt3dwZv4zz4274C1YIDkLpdlTEs85g7zIt8j+Oj
 hPFgH89DhWZeHFFHexi43yQ8VSlYV/1/tt+rA6yHv1OCrMYdOF7TajMElxAGrkBp7onLlJ8
 f54tv9sDqdTZf7nTIGXIg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:d77nUz9Es8A=:SCBqE4OaR9pAfbM3QWDSNr
 VnWKWg7kDvNykQcp3Dbb420ARZnj7Ob/PzDmUAvpqB+Dvp/ePGPrQtZlCCg1KOg5gA4UqeB8N
 6exl0WbA/Y0p71brlw9FaaKk8CfNmRdLM+/r/8HsUHyAzq8bjQaTq4C0VljDnJgjxo4zsQXJd
 a9Me+DDbxSI7D13DQRrwAiBKgwv+Osj+6o39270gHG3aZ5bEns2P49rNTXZhkQ/yly2ZSSRVq
 8q/N4OWpADR3cr/YJ0ze0vi7IkoDU1tt8TmbRReQDDET6iA04lh4t59geGeypqrVbBJo3WFMf
 ysl9Csh7+C4yhLi45ajKY5GOaZtx0OYQmVhvwCUYlAJXF/p/nUbzvjFXyZo/lnAOkow4TWZ30
 hDkCV3yP7+L5uNSeI+QDz9qFiBeJAHgdCfYY5j8xRI6mihpx3xNNVvmzJ2OrlzYhdpFzHhGCh
 eVumPIaVbC/w6dANRBZ8w/3REpE3ZHjiH8gF2IjiwY/E0RKC5x5271Z8Dy5W407bPKude6N4e
 8QCQMIgr2xNOcDNIpfvBJKa/5sGI2GlBjy5Elk3callrIhaDpScS6KtdrXHQPQObjwEq4P39b
 7lQiSdTuDS2aFLze3Yxs4i3EgvR0d3PX2sdXY+n2Bv4pdgE7OSHmsVXAiqPW20Bds5GS8M9ID
 Vzpw1KVoBR5TQk9H+ze7OLGSLnwwQtYHWivCv6ydMjbD5YHCtpJ192dDZyAP6m9QwSjwksd8V
 Ux9Wih4VdlEsVJBZBkUFXlST54F5A/lh97NMOBgZDU6dP1mKs8YqOPVFGaOgCRcijvwRbXdOI
 m17ugwX4V7mjvXO2mv+2vFUXHBEfakyUs8nnLFV6iXSnNAhTqw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.10.2018 um 21:42 schrieb Jeff King:
> On Fri, Oct 05, 2018 at 09:36:28PM +0200, René Scharfe wrote:
> 
>> Am 05.10.2018 um 21:08 schrieb Jeff King:
>>> On Fri, Oct 05, 2018 at 08:48:27PM +0200, René Scharfe wrote:
>>>> +#define DEFINE_SORT(name, type, compare)				\
>>>> +static int compare##_void(const void *one, const void *two)		\
>>>> +{									\
>>>> +	return compare(one, two);					\
>>>> +}									\
>>>> +static void name(type base, size_t nmemb)				\
>>>> +{									\
>>>> +	const type dummy = NULL;					\
>>>> +	if (nmemb > 1)							\
>>>> +		qsort(base, nmemb, sizeof(base[0]), compare##_void);	\
>>>> +	else if (0)							\
>>>> +		compare(dummy, dummy);					\
>>>> +}
>>>
>>> I do like that this removes the need to have the code block aspart of
>>> the macro.
>>>
>>> Did you measure to see if there is any runtime impact?
>>
>> No, but I wouldn't expect any -- the generated code should be the same
>> in most cases.
>>
>> Here's an example: https://godbolt.org/z/gwXENy.
> 
> OK, that's good enough for me.
> 
>> The typed comparison function can be inlined into the one with the void
>> pointers, though.
> 
> Right, that makes sense. I suspect it depends on the comparison function
> being static, but in a DEFINE_SORT() world, they generally could be.
> 
> So I like this approach.

It still has some repetition, converted code is a bit longer than the
current one, and I don't know how to build a Coccinelle rule that would
do that conversion.

Looked for a possibility to at least leave QSORT call-sites alone by
enhancing that macro, but didn't find any.  Found a few websites
showing off mindblowing macros, thouhg, this one in particular:

https://github.com/pfultz2/Cloak/wiki/C-Preprocessor-tricks,-tips,-and-idioms

Anyway, drove the generative approach a bit further, and came up with
the new DEFINE_SORT below.  I'm unsure about the name; perhaps it should
be called DEFINE_SORT_BY_COMPARE_FUNCTION_BODY, but that's a bit long.
It handles casts and const attributes behind the scenes and avoids
repetition, but looks a bit weird, as it is placed where a function
signature would go.

Apart from that the macro is simple and doesn't use any tricks or
added checks.  It just sets up boilerplate functions to offer type-safe
sorting.

diffcore-rename.c and refs/packed-backend.c receive special treatment in
the patch because their compare functions are used outside of sorting as
well.  I made them take typed pointers nevertheless and used them from
DEFINE_SORT; the wrapper generated by that macro is supposed to be
private.  Given that such reuse is rare and I think we don't need a way
to make it public.

What do y'all think about this direction?

---
 bisect.c                |  8 ++------
 builtin/describe.c      |  6 ++----
 builtin/fmt-merge-msg.c | 10 ++++------
 builtin/index-pack.c    | 14 ++++----------
 builtin/name-rev.c      |  5 ++---
 builtin/pack-objects.c  |  7 ++-----
 builtin/remote.c        |  6 ++----
 builtin/shortlog.c      | 15 ++++++++-------
 commit-graph.c          |  6 ++----
 delta-islands.c         |  8 +++-----
 diff.c                  |  8 +++-----
 diffcore-delta.c        |  7 ++-----
 diffcore-order.c        |  7 ++-----
 diffcore-rename.c       | 11 +++++++----
 git-compat-util.h       | 15 +++++++++++++++
 help.c                  |  7 ++-----
 line-log.c              |  7 ++-----
 midx.c                  | 12 ++++--------
 pack-check.c            |  6 ++----
 pathspec.c              |  8 ++------
 refs/packed-backend.c   | 11 ++++++++---
 sha1-array.c            |  4 ++--
 sha1-name.c             |  4 ++--
 23 files changed, 84 insertions(+), 108 deletions(-)

diff --git a/bisect.c b/bisect.c
index e8b17cf7e1..25257c2e69 100644
--- a/bisect.c
+++ b/bisect.c
@@ -192,12 +192,8 @@ struct commit_dist {
 	int distance;
 };
 
-static int compare_commit_dist(const void *a_, const void *b_)
+DEFINE_SORT(static, sort_by_commit_dist, struct commit_dist *, a, b)
 {
-	struct commit_dist *a, *b;
-
-	a = (struct commit_dist *)a_;
-	b = (struct commit_dist *)b_;
 	if (a->distance != b->distance)
 		return b->distance - a->distance; /* desc sort */
 	return oidcmp(&a->commit->object.oid, &b->commit->object.oid);
@@ -223,7 +219,7 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
 		array[cnt].distance = distance;
 		cnt++;
 	}
-	QSORT(array, cnt, compare_commit_dist);
+	sort_by_commit_dist(array, cnt);
 	for (p = list, i = 0; i < cnt; i++) {
 		struct object *obj = &(array[i].commit->object);
 
diff --git a/builtin/describe.c b/builtin/describe.c
index 22c0541da5..44eaadf0a0 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -220,10 +220,8 @@ struct possible_tag {
 	unsigned flag_within;
 };
 
-static int compare_pt(const void *a_, const void *b_)
+DEFINE_SORT(static, sort_pt, struct possible_tag *, a, b)
 {
-	struct possible_tag *a = (struct possible_tag *)a_;
-	struct possible_tag *b = (struct possible_tag *)b_;
 	if (a->depth != b->depth)
 		return a->depth - b->depth;
 	if (a->found_order != b->found_order)
@@ -410,7 +408,7 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 			    oid_to_hex(cmit_oid));
 	}
 
-	QSORT(all_matches, match_cnt, compare_pt);
+	sort_pt(all_matches, match_cnt);
 
 	if (gave_up_on) {
 		commit_list_insert_by_date(gave_up_on, &list);
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 59a40342b6..2c84349a1b 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -268,9 +268,9 @@ static void record_person(int which, struct string_list *people,
 	unuse_commit_buffer(commit, buffer);
 }
 
-static int cmp_string_list_util_as_integral(const void *a_, const void *b_)
+DEFINE_SORT(static, sort_string_list_by_util_as_integral,
+	    struct string_list_item *, a, b)
 {
-	const struct string_list_item *a = a_, *b = b_;
 	return util_as_integral(b) - util_as_integral(a);
 }
 
@@ -319,10 +319,8 @@ static void add_people_info(struct strbuf *out,
 			    struct string_list *authors,
 			    struct string_list *committers)
 {
-	QSORT(authors->items, authors->nr,
-	      cmp_string_list_util_as_integral);
-	QSORT(committers->items, committers->nr,
-	      cmp_string_list_util_as_integral);
+	sort_string_list_by_util_as_integral(authors->items, authors->nr);
+	sort_string_list_by_util_as_integral(committers->items, committers->nr);
 
 	credit_people(out, authors, 'a');
 	credit_people(out, committers, 'c');
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 2004e25da2..d3e91afb50 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1066,21 +1066,15 @@ static void find_unresolved_deltas(struct base_data *base)
 	}
 }
 
-static int compare_ofs_delta_entry(const void *a, const void *b)
+DEFINE_SORT(static, sort_by_offset, struct ofs_delta_entry *, delta_a, delta_b)
 {
-	const struct ofs_delta_entry *delta_a = a;
-	const struct ofs_delta_entry *delta_b = b;
-
 	return delta_a->offset < delta_b->offset ? -1 :
 	       delta_a->offset > delta_b->offset ?  1 :
 	       0;
 }
 
-static int compare_ref_delta_entry(const void *a, const void *b)
+DEFINE_SORT(static, sort_by_oid, struct ref_delta_entry *, delta_a, delta_b)
 {
-	const struct ref_delta_entry *delta_a = a;
-	const struct ref_delta_entry *delta_b = b;
-
 	return oidcmp(&delta_a->oid, &delta_b->oid);
 }
 
@@ -1206,8 +1200,8 @@ static void resolve_deltas(void)
 		return;
 
 	/* Sort deltas by base SHA1/offset for fast searching */
-	QSORT(ofs_deltas, nr_ofs_deltas, compare_ofs_delta_entry);
-	QSORT(ref_deltas, nr_ref_deltas, compare_ref_delta_entry);
+	sort_by_offset(ofs_deltas, nr_ofs_deltas);
+	sort_by_oid(ref_deltas, nr_ref_deltas);
 
 	if (verbose || show_resolving_progress)
 		progress = start_progress(_("Resolving deltas"),
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index f1cb45c227..e8d2da1101 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -196,9 +196,8 @@ static void add_to_tip_table(const struct object_id *oid, const char *refname,
 	tip_table.sorted = 0;
 }
 
-static int tipcmp(const void *a_, const void *b_)
+DEFINE_SORT(static, sort_by_oid, struct tip_table_entry *, a, b)
 {
-	const struct tip_table_entry *a = a_, *b = b_;
 	return oidcmp(&a->oid, &b->oid);
 }
 
@@ -293,7 +292,7 @@ static const char *get_exact_ref_match(const struct object *o)
 		return NULL;
 
 	if (!tip_table.sorted) {
-		QSORT(tip_table.table, tip_table.nr, tipcmp);
+		sort_by_oid(tip_table.table, tip_table.nr);
 		tip_table.sorted = 1;
 	}
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index e6316d294d..fc37ae186f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2868,11 +2868,8 @@ static void mark_in_pack_object(struct object *object, struct packed_git *p, str
  * Compare the objects in the offset order, in order to emulate the
  * "git rev-list --objects" output that produced the pack originally.
  */
-static int ofscmp(const void *a_, const void *b_)
+DEFINE_SORT(static, sort_in_pack_objects, struct in_pack_object *, a, b)
 {
-	struct in_pack_object *a = (struct in_pack_object *)a_;
-	struct in_pack_object *b = (struct in_pack_object *)b_;
-
 	if (a->offset < b->offset)
 		return -1;
 	else if (a->offset > b->offset)
@@ -2912,7 +2909,7 @@ static void add_objects_in_unpacked_packs(struct rev_info *revs)
 	}
 
 	if (in_pack.nr) {
-		QSORT(in_pack.array, in_pack.nr, ofscmp);
+		sort_in_pack_objects(in_pack.array, in_pack.nr);
 		for (i = 0; i < in_pack.nr; i++) {
 			struct object *o = in_pack.array[i].object;
 			add_object_entry(&o->oid, o->type, "", 0);
diff --git a/builtin/remote.c b/builtin/remote.c
index f7edf7f2cb..0f9e70d445 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1011,10 +1011,8 @@ static int add_push_to_show_info(struct string_list_item *push_item, void *cb_da
  * Sorting comparison for a string list that has push_info
  * structs in its util field
  */
-static int cmp_string_with_push(const void *va, const void *vb)
+DEFINE_SORT(static, sort_by_push_info, struct string_list_item *, a, b)
 {
-	const struct string_list_item *a = va;
-	const struct string_list_item *b = vb;
 	const struct push_info *a_push = a->util;
 	const struct push_info *b_push = b->util;
 	int cmp = strcmp(a->string, b->string);
@@ -1216,7 +1214,7 @@ static int show(int argc, const char **argv)
 
 		info.width = info.width2 = 0;
 		for_each_string_list(&states.push, add_push_to_show_info, &info);
-		QSORT(info.list->items, info.list->nr, cmp_string_with_push);
+		sort_by_push_info(info.list->items, info.list->nr);
 		if (info.list->nr)
 			printf_ln(Q_("  Local ref configured for 'git push'%s:",
 				     "  Local refs configured for 'git push'%s:",
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 3898a2c9c4..ec1ace6ed5 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -29,15 +29,13 @@ static char const * const shortlog_usage[] = {
  */
 #define UTIL_TO_INT(x) ((intptr_t)(x)->util)
 
-static int compare_by_counter(const void *a1, const void *a2)
+DEFINE_SORT(static, sort_by_counter, struct string_list_item *, i1, i2)
 {
-	const struct string_list_item *i1 = a1, *i2 = a2;
 	return UTIL_TO_INT(i2) - UTIL_TO_INT(i1);
 }
 
-static int compare_by_list(const void *a1, const void *a2)
+DEFINE_SORT(static, sort_by_list, struct string_list_item *, i1, i2)
 {
-	const struct string_list_item *i1 = a1, *i2 = a2;
 	const struct string_list *l1 = i1->util, *l2 = i2->util;
 
 	if (l1->nr < l2->nr)
@@ -338,9 +336,12 @@ void shortlog_output(struct shortlog *log)
 	int i, j;
 	struct strbuf sb = STRBUF_INIT;
 
-	if (log->sort_by_number)
-		QSORT(log->list.items, log->list.nr,
-		      log->summary ? compare_by_counter : compare_by_list);
+	if (log->sort_by_number) {
+		if (log->summary)
+			sort_by_counter(log->list.items, log->list.nr);
+		else
+			sort_by_list(log->list.items, log->list.nr);
+	}
 	for (i = 0; i < log->list.nr; i++) {
 		const struct string_list_item *item = &log->list.items[i];
 		if (log->summary) {
diff --git a/commit-graph.c b/commit-graph.c
index 7f4519ec3b..fc2fbf22b4 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -550,10 +550,8 @@ static void write_graph_chunk_large_edges(struct hashfile *f,
 	}
 }
 
-static int commit_compare(const void *_a, const void *_b)
+DEFINE_SORT(static, sort_oids, struct object_id *, a, b)
 {
-	const struct object_id *a = (const struct object_id *)_a;
-	const struct object_id *b = (const struct object_id *)_b;
 	return oidcmp(a, b);
 }
 
@@ -780,7 +778,7 @@ void write_commit_graph(const char *obj_dir,
 
 	close_reachable(&oids);
 
-	QSORT(oids.list, oids.nr, commit_compare);
+	sort_oids(oids.list, oids.nr);
 
 	count_distinct = 1;
 	for (i = 1; i < oids.nr; i++) {
diff --git a/delta-islands.c b/delta-islands.c
index 8e5018e406..29232831d4 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -229,11 +229,9 @@ struct tree_islands_todo {
 	unsigned int depth;
 };
 
-static int tree_depth_compare(const void *a, const void *b)
+DEFINE_SORT(static, sort_by_tree_depth, struct tree_islands_todo *,
+	    todo_a, todo_b)
 {
-	const struct tree_islands_todo *todo_a = a;
-	const struct tree_islands_todo *todo_b = b;
-
 	return todo_a->depth - todo_b->depth;
 }
 
@@ -262,7 +260,7 @@ void resolve_tree_islands(int progress, struct packing_data *to_pack)
 			nr++;
 		}
 	}
-	QSORT(todo, nr, tree_depth_compare);
+	sort_by_tree_depth(todo, nr);
 
 	if (progress)
 		progress_state = start_progress(_("Propagating island marks"), nr);
diff --git a/diff.c b/diff.c
index f0c7557b40..ecb1961173 100644
--- a/diff.c
+++ b/diff.c
@@ -2924,10 +2924,8 @@ static long gather_dirstat(struct diff_options *opt, struct dirstat_dir *dir,
 	return sum_changes;
 }
 
-static int dirstat_compare(const void *_a, const void *_b)
+DEFINE_SORT(static, sort_by_name, struct dirstat_file *, a, b)
 {
-	const struct dirstat_file *a = _a;
-	const struct dirstat_file *b = _b;
 	return strcmp(a->name, b->name);
 }
 
@@ -3021,7 +3019,7 @@ static void show_dirstat(struct diff_options *options)
 		return;
 
 	/* Show all directories with more than x% of the changes */
-	QSORT(dir.files, dir.nr, dirstat_compare);
+	sort_by_name(dir.files, dir.nr);
 	gather_dirstat(options, &dir, changed, "", 0);
 }
 
@@ -3065,7 +3063,7 @@ static void show_dirstat_by_line(struct diffstat_t *data, struct diff_options *o
 		return;
 
 	/* Show all directories with more than x% of the changes */
-	QSORT(dir.files, dir.nr, dirstat_compare);
+	sort_by_name(dir.files, dir.nr);
 	gather_dirstat(options, &dir, changed, "", 0);
 }
 
diff --git a/diffcore-delta.c b/diffcore-delta.c
index c83d45a047..53ed2d5766 100644
--- a/diffcore-delta.c
+++ b/diffcore-delta.c
@@ -107,11 +107,8 @@ static struct spanhash_top *add_spanhash(struct spanhash_top *top,
 	}
 }
 
-static int spanhash_cmp(const void *a_, const void *b_)
+DEFINE_SORT(static, sort_by_spanhash, struct spanhash *, a, b)
 {
-	const struct spanhash *a = a_;
-	const struct spanhash *b = b_;
-
 	/* A count of zero compares at the end.. */
 	if (!a->cnt)
 		return !b->cnt ? 0 : 1;
@@ -158,7 +155,7 @@ static struct spanhash_top *hash_chars(struct diff_filespec *one)
 		n = 0;
 		accum1 = accum2 = 0;
 	}
-	QSORT(hash->data, 1ul << hash->alloc_log2, spanhash_cmp);
+	sort_by_spanhash(hash->data, 1ul << hash->alloc_log2);
 	return hash;
 }
 
diff --git a/diffcore-order.c b/diffcore-order.c
index 19e73311f9..e8abd84242 100644
--- a/diffcore-order.c
+++ b/diffcore-order.c
@@ -78,11 +78,8 @@ static int match_order(const char *path)
 	return order_cnt;
 }
 
-static int compare_objs_order(const void *a_, const void *b_)
+DEFINE_SORT(static, sort_by_order, struct obj_order *, a, b)
 {
-	struct obj_order const *a, *b;
-	a = (struct obj_order const *)a_;
-	b = (struct obj_order const *)b_;
 	if (a->order != b->order)
 		return a->order - b->order;
 	return a->orig_order - b->orig_order;
@@ -101,7 +98,7 @@ void order_objects(const char *orderfile, obj_path_fn_t obj_path,
 		objs[i].orig_order = i;
 		objs[i].order = match_order(obj_path(objs[i].obj));
 	}
-	QSORT(objs, nr, compare_objs_order);
+	sort_by_order(objs, nr);
 }
 
 static const char *pair_pathtwo(void *obj)
diff --git a/diffcore-rename.c b/diffcore-rename.c
index daddd9b28a..0e256377db 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -234,10 +234,8 @@ static void record_rename_pair(int dst_index, int src_index, int score)
  * We sort the rename similarity matrix with the score, in descending
  * order (the most similar first).
  */
-static int score_compare(const void *a_, const void *b_)
+static int score_compare(const struct diff_score *a, const struct diff_score *b)
 {
-	const struct diff_score *a = a_, *b = b_;
-
 	/* sink the unused ones to the bottom */
 	if (a->dst < 0)
 		return (0 <= b->dst);
@@ -250,6 +248,11 @@ static int score_compare(const void *a_, const void *b_)
 	return b->score - a->score;
 }
 
+DEFINE_SORT(static, sort_by_score, struct diff_score *, a, b)
+{
+	return score_compare(a, b);
+}
+
 struct file_similarity {
 	struct hashmap_entry entry;
 	int index;
@@ -576,7 +579,7 @@ void diffcore_rename(struct diff_options *options)
 	stop_progress(&progress);
 
 	/* cost matrix sorted by most to least similar pair */
-	QSORT(mx, dst_cnt * NUM_CANDIDATE_PER_DST, score_compare);
+	sort_by_score(mx, dst_cnt * NUM_CANDIDATE_PER_DST);
 
 	rename_count += find_renames(mx, dst_cnt, minimum_score, 0);
 	if (detect_rename == DIFF_DETECT_COPY)
diff --git a/git-compat-util.h b/git-compat-util.h
index 5f2e90932f..491230fc57 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1066,6 +1066,21 @@ static inline void sane_qsort(void *base, size_t nmemb, size_t size,
 		qsort(base, nmemb, size, compar);
 }
 
+#define DECLARE_SORT(scope, name, elemtype) \
+scope void name(elemtype, size_t)
+
+#define DEFINE_SORT(scope, name, elemtype, one, two)			\
+static int name##_compare(const elemtype, const elemtype);		\
+static int name##_compare_void(const void *a, const void *b)		\
+{									\
+	return name##_compare(a, b);					\
+}									\
+scope void name(elemtype base, size_t nmemb)				\
+{									\
+	QSORT(base, nmemb, name##_compare_void);			\
+}									\
+static int name##_compare(const elemtype one, const elemtype two)
+
 #ifndef HAVE_ISO_QSORT_S
 int git_qsort_s(void *base, size_t nmemb, size_t size,
 		int (*compar)(const void *, const void *, void *), void *ctx);
diff --git a/help.c b/help.c
index 96f6d221ed..c50dd58943 100644
--- a/help.c
+++ b/help.c
@@ -90,11 +90,8 @@ static void print_command_list(const struct cmdname_help *cmds,
 	}
 }
 
-static int cmd_name_cmp(const void *elem1, const void *elem2)
+DEFINE_SORT(static, sort_help_by_name, struct cmdname_help *, e1, e2)
 {
-	const struct cmdname_help *e1 = elem1;
-	const struct cmdname_help *e2 = elem2;
-
 	return strcmp(e1->name, e2->name);
 }
 
@@ -114,7 +111,7 @@ static void print_cmd_by_category(const struct category_description *catdesc)
 		if (longest < strlen(cmds[i].name))
 			longest = strlen(cmds[i].name);
 	}
-	QSORT(cmds, nr, cmd_name_cmp);
+	sort_help_by_name(cmds, nr);
 
 	for (i = 0; catdesc[i].desc; i++) {
 		uint32_t mask = catdesc[i].category;
diff --git a/line-log.c b/line-log.c
index 72a5fed661..e240959166 100644
--- a/line-log.c
+++ b/line-log.c
@@ -72,11 +72,8 @@ void range_set_append(struct range_set *rs, long a, long b)
 	range_set_append_unsafe(rs, a, b);
 }
 
-static int range_cmp(const void *_r, const void *_s)
+DEFINE_SORT(static, sort_by_start, struct range *, r, s)
 {
-	const struct range *r = _r;
-	const struct range *s = _s;
-
 	/* this could be simply 'return r.start-s.start', but for the types */
 	if (r->start == s->start)
 		return 0;
@@ -113,7 +110,7 @@ void sort_and_merge_range_set(struct range_set *rs)
 	unsigned int i;
 	unsigned int o = 0; /* output cursor */
 
-	QSORT(rs->ranges, rs->nr, range_cmp);
+	sort_by_start(rs->ranges, rs->nr);
 
 	for (i = 0; i < rs->nr; i++) {
 		if (rs->ranges[i].start == rs->ranges[i].end)
diff --git a/midx.c b/midx.c
index 713d6f9dde..4407db7949 100644
--- a/midx.c
+++ b/midx.c
@@ -419,10 +419,8 @@ struct pack_pair {
 	char *pack_name;
 };
 
-static int pack_pair_compare(const void *_a, const void *_b)
+DEFINE_SORT(static, sort_by_pack_name, struct pack_pair *, a, b)
 {
-	struct pack_pair *a = (struct pack_pair *)_a;
-	struct pack_pair *b = (struct pack_pair *)_b;
 	return strcmp(a->pack_name, b->pack_name);
 }
 
@@ -438,7 +436,7 @@ static void sort_packs_by_name(char **pack_names, uint32_t nr_packs, uint32_t *p
 		pairs[i].pack_name = pack_names[i];
 	}
 
-	QSORT(pairs, nr_packs, pack_pair_compare);
+	sort_by_pack_name(pairs, nr_packs);
 
 	for (i = 0; i < nr_packs; i++) {
 		pack_names[i] = pairs[i].pack_name;
@@ -455,10 +453,8 @@ struct pack_midx_entry {
 	uint64_t offset;
 };
 
-static int midx_oid_compare(const void *_a, const void *_b)
+DEFINE_SORT(static, sort_midx, struct pack_midx_entry *, a, b)
 {
-	const struct pack_midx_entry *a = (const struct pack_midx_entry *)_a;
-	const struct pack_midx_entry *b = (const struct pack_midx_entry *)_b;
 	int cmp = oidcmp(&a->oid, &b->oid);
 
 	if (cmp)
@@ -573,7 +569,7 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 			}
 		}
 
-		QSORT(entries_by_fanout, nr_fanout, midx_oid_compare);
+		sort_midx(entries_by_fanout, nr_fanout);
 
 		/*
 		 * The batch is now sorted by OID and then mtime (descending).
diff --git a/pack-check.c b/pack-check.c
index fa5f0ff8fa..d4825f80e0 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -15,10 +15,8 @@ struct idx_entry {
 	unsigned int nr;
 };
 
-static int compare_entries(const void *e1, const void *e2)
+DEFINE_SORT(static, sort_by_offset, struct idx_entry *, entry1, entry2)
 {
-	const struct idx_entry *entry1 = e1;
-	const struct idx_entry *entry2 = e2;
 	if (entry1->offset < entry2->offset)
 		return -1;
 	if (entry1->offset > entry2->offset)
@@ -102,7 +100,7 @@ static int verify_packfile(struct packed_git *p,
 		entries[i].offset = nth_packed_object_offset(p, i);
 		entries[i].nr = i;
 	}
-	QSORT(entries, nr_objects, compare_entries);
+	sort_by_offset(entries, nr_objects);
 
 	for (i = 0; i < nr_objects; i++) {
 		void *data;
diff --git a/pathspec.c b/pathspec.c
index 6f005996fd..b559c3d783 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -490,12 +490,8 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
 	}
 }
 
-static int pathspec_item_cmp(const void *a_, const void *b_)
+DEFINE_SORT(static, sort_by_match, struct pathspec_item *, a, b)
 {
-	struct pathspec_item *a, *b;
-
-	a = (struct pathspec_item *)a_;
-	b = (struct pathspec_item *)b_;
 	return strcmp(a->match, b->match);
 }
 
@@ -610,7 +606,7 @@ void parse_pathspec(struct pathspec *pathspec,
 	if (pathspec->magic & PATHSPEC_MAXDEPTH) {
 		if (flags & PATHSPEC_KEEP_ORDER)
 			BUG("PATHSPEC_MAXDEPTH_VALID and PATHSPEC_KEEP_ORDER are incompatible");
-		QSORT(pathspec->items, pathspec->nr, pathspec_item_cmp);
+		sort_by_match(pathspec->items, pathspec->nr);
 	}
 }
 
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 74e2996e93..1339ffd8c3 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -271,9 +271,9 @@ struct snapshot_record {
 	size_t len;
 };
 
-static int cmp_packed_ref_records(const void *v1, const void *v2)
+static int cmp_packed_ref_records(const struct snapshot_record *e1,
+				  const struct snapshot_record *e2)
 {
-	const struct snapshot_record *e1 = v1, *e2 = v2;
 	const char *r1 = e1->start + GIT_SHA1_HEXSZ + 1;
 	const char *r2 = e2->start + GIT_SHA1_HEXSZ + 1;
 
@@ -291,6 +291,11 @@ static int cmp_packed_ref_records(const void *v1, const void *v2)
 	}
 }
 
+DEFINE_SORT(static, sort_packed_ref_records, struct snapshot_record *, a, b)
+{
+	return cmp_packed_ref_records(a, b);
+}
+
 /*
  * Compare a snapshot record at `rec` to the specified NUL-terminated
  * refname.
@@ -380,7 +385,7 @@ static void sort_snapshot(struct snapshot *snapshot)
 		goto cleanup;
 
 	/* We need to sort the memory. First we sort the records array: */
-	QSORT(records, nr, cmp_packed_ref_records);
+	sort_packed_ref_records(records, nr);
 
 	/*
 	 * Allocate a new chunk of memory, and copy the old memory to
diff --git a/sha1-array.c b/sha1-array.c
index b94e0ec0f5..2dcaafe9dc 100644
--- a/sha1-array.c
+++ b/sha1-array.c
@@ -9,14 +9,14 @@ void oid_array_append(struct oid_array *array, const struct object_id *oid)
 	array->sorted = 0;
 }
 
-static int void_hashcmp(const void *a, const void *b)
+DEFINE_SORT(static, sort_by_oid, struct object_id *, a, b)
 {
 	return oidcmp(a, b);
 }
 
 static void oid_array_sort(struct oid_array *array)
 {
-	QSORT(array->oid, array->nr, void_hashcmp);
+	sort_by_oid(array->oid, array->nr);
 	array->sorted = 1;
 }
 
diff --git a/sha1-name.c b/sha1-name.c
index faa60f69e3..39fc68d3c6 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -412,7 +412,7 @@ static int collect_ambiguous(const struct object_id *oid, void *data)
 	return 0;
 }
 
-static int sort_ambiguous(const void *a, const void *b)
+DEFINE_SORT(static, sort_ambiguous, struct object_id *, a, b)
 {
 	int a_type = oid_object_info(the_repository, a, NULL);
 	int b_type = oid_object_info(the_repository, b, NULL);
@@ -486,7 +486,7 @@ static int get_short_oid(const char *name, int len, struct object_id *oid,
 
 		advise(_("The candidates are:"));
 		for_each_abbrev(ds.hex_pfx, collect_ambiguous, &collect);
-		QSORT(collect.oid, collect.nr, sort_ambiguous);
+		sort_ambiguous(collect.oid, collect.nr);
 
 		if (oid_array_for_each(&collect, show_ambiguous_object, &ds))
 			BUG("show_ambiguous_object shouldn't return non-zero");
-- 
2.19.1

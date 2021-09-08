Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B813BC433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 18:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2AD261153
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 18:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349564AbhIHSUQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 14:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350077AbhIHSTe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 14:19:34 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBFEC061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 11:18:26 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id w6-20020a0cfc46000000b00370b0997afeso5416225qvp.15
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 11:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ytIwWEjE21hUv1o4wz/VybIzvmJWeQ+hmqCbY+L6llw=;
        b=NqmVY8kHXPQiAOOpJMQ7ObBpK+BlaNI3q5rZlt9Yw/1eIX+ob7X7MUwNE4hmjw40x+
         SUXVniDipT1uhKP8ZGov5dNklyjMkiqrb3Z2R9FxMgXg6tfC18HB3lGJXAJqhcmjgiMp
         qF8hYIJqQ4x2N0E01j6s0ZLOuMqS2jqCJ1RoQO9/qw1cbPJx6nfG05Qv8Sy7e5ceORVD
         zs1W3syMbd8hPa60e73+VU5Qp7oLNgNelGan99qGgx5xH2ciAAa7Yw7kqvJjOx1w92EC
         4pKHHudApDK3QtF3adQajcnpj7+qnBDNhkBS+Y/M6mUwhsbvIxwkl6KkS5qAY+onmMNR
         7kkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ytIwWEjE21hUv1o4wz/VybIzvmJWeQ+hmqCbY+L6llw=;
        b=K98VEdGlwjPf6ReGgyKycpuGygg5ByX+YUhbttM7rjbMI9FKRLrgLUr6exy1jh2HB1
         SnS586rqxXONyJIoNlTc+odFOviD4zGUEA23cbMMIXG/HfkQdw4ku8LI8TQ412fYgPwA
         QCEK0mNWbZrC0+L5B2CKy2ztLD3FjpXCAANWzBMU43h0QFnd9VQh5TJ2l0WxKuJyZir5
         1Q0risp+g6pzp9bVwYUxC1RrNzrLMZkTQx6WUjtkV6hoaVF3K6JUkYet3vkl02D/YOdU
         VKcPNI0bvf6XeeSoBbJjhU7kAPr+7uyXRV/is4tXXFxMh+kPZpZw5dOvMJhEo1OQHJpZ
         q3jg==
X-Gm-Message-State: AOAM532t7+jjn8XRp+6fUxK8UgcK/msnlvB0AOVwwTIy9RJb2NHEAGbh
        xcSBSlVXLUfn0hGhf45uMM/BpmmeODa2ZpU8R9aiI+0MPKG50yfQdkkKmYmqeyu8arIsqcuDmtf
        Y8Zu7semIsGMcQ0ksTGYuY0VYpsRErh4YtJ32uvsyHuqmDDXFnB46WjJa+yRPP/M/UcEkRL2VnO
        oZ
X-Google-Smtp-Source: ABdhPJzccHlbGwblfIvOYacftmtrhX59Fh87bxPu7X9qLMdyVooViJWMWZWYiatCtpB+Nqu9KN+Y8Q2YyJvsVeUB2gsi
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:1843:: with SMTP id
 d3mr5438869qvy.10.1631125105241; Wed, 08 Sep 2021 11:18:25 -0700 (PDT)
Date:   Wed,  8 Sep 2021 11:18:15 -0700
In-Reply-To: <cover.1631123754.git.jonathantanmy@google.com>
Message-Id: <f149dee7afffc9de72d3b81dfb1afbd2b027c9b4.1631123754.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1631123754.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH 3/3] DO NOT SUBMIT commit-reach,revision: verify non-mixing
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch is provided to show reviewers how I'm verifying that there is
no mixing of object structs in the revision walking mechanisms. I've
intercepted any creation of commit nodes in alloc.c (whether through
alloc_commit_node() directly or through alloc_object_node()) to add the
repository in which that node is allocated, and checked all additions of
commits to data structures (as far as I can tell) in commit-reach.c and
revision.c to make sure that the repository in the added objects is what
we expect. This ensures that any flags set are set on the correct nodes
(for example, it won't be set on an object allocated in the_repository
and then checked from an object allocated in a submodule).

I'll leave out this patch in subsequent revisions of this patch set.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 alloc.c        |  2 ++
 commit-reach.c | 60 +++++++++++++++++++++++++------------
 object.h       |  1 +
 revision.c     | 80 ++++++++++++++++++++++++++++++++------------------
 4 files changed, 97 insertions(+), 46 deletions(-)

diff --git a/alloc.c b/alloc.c
index 957a0af362..98b8c06834 100644
--- a/alloc.c
+++ b/alloc.c
@@ -96,6 +96,7 @@ void *alloc_object_node(struct repository *r)
 {
 	struct object *obj = alloc_node(r->parsed_objects->object_state, sizeof(union any_object));
 	obj->type = OBJ_NONE;
+	obj->repo = r;
 	return obj;
 }
 
@@ -120,6 +121,7 @@ void *alloc_commit_node(struct repository *r)
 {
 	struct commit *c = alloc_node(r->parsed_objects->commit_state, sizeof(struct commit));
 	init_commit_node(c);
+	c->object.repo = r;
 	return c;
 }
 
diff --git a/commit-reach.c b/commit-reach.c
index c226ee3da4..eb868c3837 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -9,6 +9,30 @@
 #include "tag.h"
 #include "commit-reach.h"
 
+static void checked_put(struct repository *repo, struct prio_queue *queue, struct commit *commit)
+{
+	if (repo != commit->object.repo)
+		*(int *)0=1;
+	prio_queue_put(queue, commit);
+}
+#define prio_queue_put DO_NOT_USE
+
+static struct commit_list *checked_insert(struct repository *repo, struct commit *item, struct commit_list **list)
+{
+	if (repo != item->object.repo)
+		*(int *)0=1;
+	return commit_list_insert(item, list);
+}
+#define commit_list_insert DO_NOT_USE
+
+static struct commit_list *checked_insert_by_date(struct repository *repo, struct commit *item, struct commit_list **list)
+{
+	if (repo != item->object.repo)
+		*(int *)0=1;
+	return commit_list_insert_by_date(item, list);
+}
+#define commit_list_insert_by_date DO_NOT_USE
+
 /* Remember to update object flag allocation in object.h */
 #define PARENT1		(1u<<16)
 #define PARENT2		(1u<<17)
@@ -66,11 +90,11 @@ static struct commit_list *paint_down_to_common(struct repository *r,
 		commit_list_append(one, &result);
 		return result;
 	}
-	prio_queue_put(&queue, one);
+	checked_put(r, &queue, one);
 
 	for (i = 0; i < n; i++) {
 		twos[i]->object.flags |= PARENT2;
-		prio_queue_put(&queue, twos[i]);
+		checked_put(r, &queue, twos[i]);
 	}
 
 	while (queue_has_nonstale(&queue)) {
@@ -92,7 +116,7 @@ static struct commit_list *paint_down_to_common(struct repository *r,
 		if (flags == (PARENT1 | PARENT2)) {
 			if (!(commit->object.flags & RESULT)) {
 				commit->object.flags |= RESULT;
-				commit_list_insert_by_date(commit, &result);
+				checked_insert_by_date(r, commit, &result);
 			}
 			/* Mark parents of a found merge stale */
 			flags |= STALE;
@@ -106,7 +130,7 @@ static struct commit_list *paint_down_to_common(struct repository *r,
 			if (repo_parse_commit(r, p))
 				return NULL;
 			p->object.flags |= flags;
-			prio_queue_put(&queue, p);
+			checked_put(r, &queue, p);
 		}
 	}
 
@@ -128,7 +152,7 @@ static struct commit_list *merge_bases_many(struct repository *r,
 			 * We do not mark this even with RESULT so we do not
 			 * have to clean it up.
 			 */
-			return commit_list_insert(one, &result);
+			return checked_insert(r, one, &result);
 	}
 
 	if (repo_parse_commit(r, one))
@@ -143,7 +167,7 @@ static struct commit_list *merge_bases_many(struct repository *r,
 	while (list) {
 		struct commit *commit = pop_commit(&list);
 		if (!(commit->object.flags & STALE))
-			commit_list_insert_by_date(commit, &result);
+			checked_insert_by_date(r, commit, &result);
 	}
 	return result;
 }
@@ -155,7 +179,7 @@ struct commit_list *get_octopus_merge_bases(struct commit_list *in)
 	if (!in)
 		return ret;
 
-	commit_list_insert(in->item, &ret);
+	checked_insert(the_repository, in->item, &ret);
 
 	for (i = in->next; i; i = i->next) {
 		struct commit_list *new_commits = NULL, *end = NULL;
@@ -287,7 +311,7 @@ static int remove_redundant_with_gen(struct repository *r,
 		/* push the STALE bits up to min generation */
 		struct commit_list *stack = NULL;
 
-		commit_list_insert(walk_start[i], &stack);
+		checked_insert(r, walk_start[i], &stack);
 		walk_start[i]->object.flags |= STALE;
 
 		while (stack) {
@@ -317,7 +341,7 @@ static int remove_redundant_with_gen(struct repository *r,
 			while (parents) {
 				if (!(parents->item->object.flags & STALE)) {
 					parents->item->object.flags |= STALE;
-					commit_list_insert(parents->item, &stack);
+					checked_insert(r, parents->item, &stack);
 					break;
 				}
 				parents = parents->next;
@@ -410,7 +434,7 @@ static struct commit_list *get_merge_bases_many_0(struct repository *r,
 	cnt = remove_redundant(r, rslt, cnt);
 	result = NULL;
 	for (i = 0; i < cnt; i++)
-		commit_list_insert_by_date(rslt[i], &result);
+		checked_insert_by_date(r, rslt[i], &result);
 	free(rslt);
 	return result;
 }
@@ -451,7 +475,7 @@ int repo_is_descendant_of(struct repository *r,
 	if (generation_numbers_enabled(the_repository)) {
 		struct commit_list *from_list = NULL;
 		int result;
-		commit_list_insert(commit, &from_list);
+		checked_insert(r, commit, &from_list);
 		result = can_all_from_reach(from_list, with_commit, 0);
 		free_commit_list(from_list);
 		return result;
@@ -550,7 +574,7 @@ struct commit_list *reduce_heads(struct commit_list *heads)
 	}
 	num_head = remove_redundant(the_repository, array, num_head);
 	for (i = 0; i < num_head; i++)
-		tail = &commit_list_insert(array[i], tail)->next;
+		tail = &checked_insert(the_repository, array[i], tail)->next;
 	free(array);
 	return result;
 }
@@ -588,7 +612,7 @@ int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid)
 	if (parse_commit(new_commit) < 0)
 		return 0;
 
-	commit_list_insert(old_commit, &old_commit_list);
+	checked_insert(the_repository, old_commit, &old_commit_list);
 	ret = repo_is_descendant_of(the_repository,
 				    new_commit, old_commit_list);
 	free_commit_list(old_commit_list);
@@ -765,7 +789,7 @@ int can_all_from_reach_with_flag(struct object_array *from,
 		struct commit_list *stack = NULL;
 
 		list[i]->object.flags |= assign_flag;
-		commit_list_insert(list[i], &stack);
+		checked_insert(the_repository, list[i], &stack);
 
 		while (stack) {
 			struct commit_list *parent;
@@ -789,7 +813,7 @@ int can_all_from_reach_with_flag(struct object_array *from,
 					    commit_graph_generation(parent->item) < min_generation)
 						continue;
 
-					commit_list_insert(parent->item, &stack);
+					checked_insert(the_repository, parent->item, &stack);
 					break;
 				}
 			}
@@ -907,7 +931,7 @@ struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
 			c->object.flags |= PARENT2;
 			parse_commit(c);
 
-			prio_queue_put(&queue, *item);
+			checked_put(the_repository, &queue, *item);
 		}
 	}
 
@@ -917,7 +941,7 @@ struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
 		if (current->object.flags & PARENT1) {
 			current->object.flags &= ~PARENT1;
 			current->object.flags |= reachable_flag;
-			commit_list_insert(current, &found_commits);
+			checked_insert(the_repository, current, &found_commits);
 			num_to_find--;
 		}
 
@@ -933,7 +957,7 @@ struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
 				continue;
 
 			p->object.flags |= PARENT2;
-			prio_queue_put(&queue, p);
+			checked_put(the_repository, &queue, p);
 		}
 	}
 
diff --git a/object.h b/object.h
index 3b38c9cc98..22e9d2a52a 100644
--- a/object.h
+++ b/object.h
@@ -90,6 +90,7 @@ struct object {
 	unsigned type : TYPE_BITS;
 	unsigned flags : FLAG_BITS;
 	struct object_id oid;
+	struct repository *repo;
 };
 
 const char *type_name(unsigned int type);
diff --git a/revision.c b/revision.c
index 7e7c41fedd..ba30e58921 100644
--- a/revision.c
+++ b/revision.c
@@ -33,6 +33,30 @@
 #include "bloom.h"
 #include "json-writer.h"
 
+static void checked_put(struct repository *repo, struct prio_queue *queue, struct commit *commit)
+{
+	if (repo != commit->object.repo)
+		*(int *)0=1;
+	prio_queue_put(queue, commit);
+}
+#define prio_queue_put DO_NOT_USE
+
+static struct commit_list *checked_insert(struct repository *repo, struct commit *item, struct commit_list **list)
+{
+	if (repo != item->object.repo)
+		*(int *)0=1;
+	return commit_list_insert(item, list);
+}
+#define commit_list_insert DO_NOT_USE
+
+static struct commit_list *checked_insert_by_date(struct repository *repo, struct commit *item, struct commit_list **list)
+{
+	if (repo != item->object.repo)
+		*(int *)0=1;
+	return commit_list_insert_by_date(item, list);
+}
+#define commit_list_insert_by_date DO_NOT_USE
+
 volatile show_early_output_fn_t show_early_output;
 
 static const char *term_bad;
@@ -1124,9 +1148,9 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 				continue;
 			p->object.flags |= (SEEN | NOT_USER_GIVEN);
 			if (list)
-				commit_list_insert_by_date(p, list);
+				checked_insert_by_date(revs->repo, p, list);
 			if (queue)
-				prio_queue_put(queue, p);
+				checked_put(revs->repo, queue, p);
 		}
 		return 0;
 	}
@@ -1166,9 +1190,9 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 		if (!(p->object.flags & SEEN)) {
 			p->object.flags |= (SEEN | NOT_USER_GIVEN);
 			if (list)
-				commit_list_insert_by_date(p, list);
+				checked_insert_by_date(revs->repo, p, list);
 			if (queue)
-				prio_queue_put(queue, p);
+				checked_put(revs->repo, queue, p);
 		}
 		if (revs->first_parent_only)
 			break;
@@ -1291,7 +1315,7 @@ static int still_interesting(struct commit_list *src, timestamp_t date, int slop
  * the result of "A..B" without --ancestry-path, and limits the latter
  * further to the ones that can reach one of the commits in "bottom".
  */
-static void limit_to_ancestry(struct commit_list *bottom, struct commit_list *list)
+static void limit_to_ancestry(struct repository *repo, struct commit_list *bottom, struct commit_list *list)
 {
 	struct commit_list *p;
 	struct commit_list *rlist = NULL;
@@ -1302,7 +1326,7 @@ static void limit_to_ancestry(struct commit_list *bottom, struct commit_list *li
 	 * process parents before children.
 	 */
 	for (p = list; p; p = p->next)
-		commit_list_insert(p->item, &rlist);
+		checked_insert(repo, p->item, &rlist);
 
 	for (p = bottom; p; p = p->next)
 		p->item->object.flags |= TMP_MARK;
@@ -1362,12 +1386,12 @@ static void limit_to_ancestry(struct commit_list *bottom, struct commit_list *li
  * to filter the result of "A..B" further to the ones that can actually
  * reach A.
  */
-static struct commit_list *collect_bottom_commits(struct commit_list *list)
+static struct commit_list *collect_bottom_commits(struct repository *repo, struct commit_list *list)
 {
 	struct commit_list *elem, *bottom = NULL;
 	for (elem = list; elem; elem = elem->next)
 		if (elem->item->object.flags & BOTTOM)
-			commit_list_insert(elem->item, &bottom);
+			checked_insert(repo, elem->item, &bottom);
 	return bottom;
 }
 
@@ -1399,7 +1423,7 @@ static int limit_list(struct rev_info *revs)
 	struct commit *interesting_cache = NULL;
 
 	if (revs->ancestry_path) {
-		bottom = collect_bottom_commits(original_list);
+		bottom = collect_bottom_commits(revs->repo, original_list);
 		if (!bottom)
 			die("--ancestry-path given but there are no bottom commits");
 	}
@@ -1427,7 +1451,7 @@ static int limit_list(struct rev_info *revs)
 		    !revs->line_level_traverse)
 			continue;
 		date = commit->date;
-		p = &commit_list_insert(commit, p)->next;
+		p = &checked_insert(revs->repo, commit, p)->next;
 
 		show = show_early_output;
 		if (!show)
@@ -1443,7 +1467,7 @@ static int limit_list(struct rev_info *revs)
 		limit_left_right(newlist, revs);
 
 	if (bottom) {
-		limit_to_ancestry(bottom, newlist);
+		limit_to_ancestry(revs->repo, bottom, newlist);
 		free_commit_list(bottom);
 	}
 
@@ -3133,14 +3157,14 @@ static struct commit_list **simplify_one(struct rev_info *revs, struct commit *c
 	for (cnt = 0, p = commit->parents; p; p = p->next) {
 		pst = locate_simplify_state(revs, p->item);
 		if (!pst->simplified) {
-			tail = &commit_list_insert(p->item, tail)->next;
+			tail = &checked_insert(revs->repo, p->item, tail)->next;
 			cnt++;
 		}
 		if (revs->first_parent_only)
 			break;
 	}
 	if (cnt) {
-		tail = &commit_list_insert(commit, tail)->next;
+		tail = &checked_insert(revs->repo, commit, tail)->next;
 		return tail;
 	}
 
@@ -3230,7 +3254,7 @@ static void simplify_merges(struct rev_info *revs)
 		 * Do not free(list) here yet; the original list
 		 * is used later in this function.
 		 */
-		commit_list_insert(commit, &yet_to_do);
+		checked_insert(revs->repo, commit, &yet_to_do);
 	}
 	while (yet_to_do) {
 		list = yet_to_do;
@@ -3252,7 +3276,7 @@ static void simplify_merges(struct rev_info *revs)
 		commit = pop_commit(&list);
 		st = locate_simplify_state(revs, commit);
 		if (st->simplified == commit)
-			tail = &commit_list_insert(commit, tail)->next;
+			tail = &checked_insert(revs->repo, commit, tail)->next;
 	}
 }
 
@@ -3316,13 +3340,13 @@ static void trace2_topo_walk_statistics_atexit(void)
 	jw_release(&jw);
 }
 
-static inline void test_flag_and_insert(struct prio_queue *q, struct commit *c, int flag)
+static inline void test_flag_and_insert(struct repository *repo, struct prio_queue *q, struct commit *c, int flag)
 {
 	if (c->object.flags & flag)
 		return;
 
 	c->object.flags |= flag;
-	prio_queue_put(q, c);
+	checked_put(repo, q, c);
 }
 
 static void explore_walk_step(struct rev_info *revs)
@@ -3352,7 +3376,7 @@ static void explore_walk_step(struct rev_info *revs)
 		mark_parents_uninteresting(c);
 
 	for (p = c->parents; p; p = p->next)
-		test_flag_and_insert(&info->explore_queue, p->item, TOPO_WALK_EXPLORED);
+		test_flag_and_insert(revs->repo, &info->explore_queue, p->item, TOPO_WALK_EXPLORED);
 }
 
 static void explore_to_depth(struct rev_info *revs,
@@ -3393,7 +3417,7 @@ static void indegree_walk_step(struct rev_info *revs)
 		else
 			*pi = 2;
 
-		test_flag_and_insert(&info->indegree_queue, parent, TOPO_WALK_INDEGREE);
+		test_flag_and_insert(revs->repo, &info->indegree_queue, parent, TOPO_WALK_INDEGREE);
 
 		if (revs->first_parent_only)
 			return;
@@ -3464,8 +3488,8 @@ static void init_topo_walk(struct rev_info *revs)
 		if (repo_parse_commit_gently(revs->repo, c, 1))
 			continue;
 
-		test_flag_and_insert(&info->explore_queue, c, TOPO_WALK_EXPLORED);
-		test_flag_and_insert(&info->indegree_queue, c, TOPO_WALK_INDEGREE);
+		test_flag_and_insert(revs->repo, &info->explore_queue, c, TOPO_WALK_EXPLORED);
+		test_flag_and_insert(revs->repo, &info->indegree_queue, c, TOPO_WALK_INDEGREE);
 
 		generation = commit_graph_generation(c);
 		if (generation < info->min_generation)
@@ -3482,7 +3506,7 @@ static void init_topo_walk(struct rev_info *revs)
 		struct commit *c = list->item;
 
 		if (*(indegree_slab_at(&info->indegree, c)) == 1)
-			prio_queue_put(&info->topo_queue, c);
+			checked_put(revs->repo, &info->topo_queue, c);
 	}
 
 	/*
@@ -3545,7 +3569,7 @@ static void expand_topo_walk(struct rev_info *revs, struct commit *commit)
 
 		(*pi)--;
 		if (*pi == 1)
-			prio_queue_put(&info->topo_queue, parent);
+			checked_put(revs->repo, &info->topo_queue, parent);
 
 		if (revs->first_parent_only)
 			return;
@@ -3635,7 +3659,7 @@ static enum rewrite_result rewrite_one_1(struct rev_info *revs,
 	}
 }
 
-static void merge_queue_into_list(struct prio_queue *q, struct commit_list **list)
+static void merge_queue_into_list(struct repository *repo, struct prio_queue *q, struct commit_list **list)
 {
 	while (q->nr) {
 		struct commit *item = prio_queue_peek(q);
@@ -3644,7 +3668,7 @@ static void merge_queue_into_list(struct prio_queue *q, struct commit_list **lis
 		if (p && p->item->date >= item->date)
 			list = &p->next;
 		else {
-			p = commit_list_insert(item, list);
+			p = checked_insert(repo, item, list);
 			list = &p->next; /* skip newly added item */
 			prio_queue_get(q); /* pop item */
 		}
@@ -3655,7 +3679,7 @@ static enum rewrite_result rewrite_one(struct rev_info *revs, struct commit **pp
 {
 	struct prio_queue queue = { compare_commits_by_commit_date };
 	enum rewrite_result ret = rewrite_one_1(revs, pp, &queue);
-	merge_queue_into_list(&queue, &revs->commits);
+	merge_queue_into_list(revs->repo, &queue, &revs->commits);
 	clear_prio_queue(&queue);
 	return ret;
 }
@@ -4075,7 +4099,7 @@ static void create_boundary_commit_list(struct rev_info *revs)
 		if (c->object.flags & (SHOWN | BOUNDARY))
 			continue;
 		c->object.flags |= BOUNDARY;
-		commit_list_insert(c, &revs->commits);
+		checked_insert(revs->repo, c, &revs->commits);
 	}
 
 	/*
@@ -4179,7 +4203,7 @@ struct commit *get_revision(struct rev_info *revs)
 	if (revs->reverse) {
 		reversed = NULL;
 		while ((c = get_revision_internal(revs)))
-			commit_list_insert(c, &reversed);
+			checked_insert(revs->repo, c, &reversed);
 		revs->commits = reversed;
 		revs->reverse = 0;
 		revs->reverse_output_stage = 1;
-- 
2.33.0.309.g3052b89438-goog


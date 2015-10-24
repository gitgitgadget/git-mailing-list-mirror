From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] use pop_commit() for consuming the first entry of a struct
 commit_list
Date: Sat, 24 Oct 2015 18:21:31 +0200
Message-ID: <562BB00B.1000704@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 24 18:22:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zq1aH-0005d6-KH
	for gcvg-git-2@plane.gmane.org; Sat, 24 Oct 2015 18:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643AbbJXQVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2015 12:21:48 -0400
Received: from mout.web.de ([212.227.17.12]:55508 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752260AbbJXQVr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2015 12:21:47 -0400
Received: from [192.168.178.36] ([79.253.137.83]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0LiCx5-1aJoQX1pWl-00nMJS; Sat, 24 Oct 2015 18:21:34
 +0200
X-Mozilla-News-Host: news://news.gmane.org:119
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
X-Provags-ID: V03:K0:/kt4rYq0y2k1GhmLc4NXWaGt9E1ZcO3qYTZm/OU4m/VYAx3Xeus
 eLXV/7ubD0g4r3tOVl7Aog0C65gBdTR5JlA7UQ8wVXsVe2izWj0/5eGMdJ4MIIFsTuH5NZ1
 XnZQAMt/DdvtPy8jcxOW6di294Fg/Aebi/6gGQpK3N4Zb/1Z21e+u1jnHf2n++tzhccurUI
 lMHPGGBqARKzD2VBZ4bQQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CWBjnYv6UQ4=:8N+OPDqJ60A/kEk3j/Cuxx
 ujw6g5UG99l8SVPeUKgOxnz35MxEWi04QUaCvMHb+Zmtg9Ng5jneVEe2CL+Qy8nws+zI4pAYD
 5lWUzQKjAIBiyhuxwRacYxlK1BBHBRvz5nVD1+r2k7wrVTwoiqaZvdT9hxGSj4hpe2lj6VuGd
 HgDcEkPKG3jGqM6vhi0Md+tDf6d6BTq4kcEhSoMdckLNBmaiLsX11bNlTMfBJTQpL/4oCd2FM
 0i4VrdaHoXGL2KhJZ7pG4srpEv8hrMcmhCRblso5xTMhh+CAC56ci8/fKyxLuLAWIVFeIVNV1
 SrpjXyGpAfNVd5sJUkmxzZfha9JxvEvBqAMKOHvmrHSfkjz8cOH+zEfI9zJ/pu+3Isoyb27YH
 tVYpoW6xhZeIYuLSBpUEKvT5HnZtu727LL9KqwJ+9vsEg6srPWRDQM1e3+AO0EtwUNOWDp+Jn
 Nl5Qg+/gyNPKJZuU/qz+HdZBydG2xuPnICoQ+zTC5SZ9ogTqo/3aK2mtGln6ioSgVRUWaz2iT
 ExsV7oUN/vF5w5oFl+h5N6VwmV0bkRDeviSYKVMr/H+l7VCvKVkWCC16fH0YNjj5ej3xHXx2O
 ep2QRrifIqGgqAhZlm/3nuOtD2CT1pd+CacXV5K5Di4O+JUbnRlZapDWgrDmBcjls8DpD985H
 C7fIlz4b65GFATS/iaTfk2zTHcNMWLQUF8Akcc+hQwbTnYBLBRGFCmj5hD1pWrVQW4uHq+DDj
 WMjSd+fHQenh71xesAHViDIjLbFTgS6l/ywnJMpKvotCNpXfvrH3+qVyxwCeA8NcgQh4zZR6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280126>

Instead of open-coding the function pop_commit() just call it.  This
makes the intent clearer and reduces code size.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/fmt-merge-msg.c |  9 +++------
 builtin/merge.c         | 12 +++++-------
 builtin/reflog.c        |  6 +-----
 builtin/rev-parse.c     |  7 ++-----
 builtin/show-branch.c   | 17 +++--------------
 commit.c                | 27 +++++++--------------------
 remote.c                |  6 ++----
 revision.c              | 27 +++++----------------------
 shallow.c               |  6 +-----
 upload-pack.c           |  6 ++----
 10 files changed, 31 insertions(+), 92 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 4ba7f28..846004b 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -537,7 +537,7 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 static void find_merge_parents(struct merge_parents *result,
 			       struct strbuf *in, unsigned char *head)
 {
-	struct commit_list *parents, *next;
+	struct commit_list *parents;
 	struct commit *head_commit;
 	int pos = 0, i, j;
 
@@ -576,13 +576,10 @@ static void find_merge_parents(struct merge_parents *result,
 	parents = reduce_heads(parents);
 
 	while (parents) {
+		struct commit *cmit = pop_commit(&parents);
 		for (i = 0; i < result->nr; i++)
-			if (!hashcmp(result->item[i].commit,
-				     parents->item->object.sha1))
+			if (!hashcmp(result->item[i].commit, cmit->object.sha1))
 				result->item[i].used = 1;
-		next = parents->next;
-		free(parents);
-		parents = next;
 	}
 
 	for (i = j = 0; i < result->nr; i++) {
diff --git a/builtin/merge.c b/builtin/merge.c
index a0a9328..31241b8 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1019,7 +1019,7 @@ static struct commit_list *reduce_parents(struct commit *head_commit,
 					  int *head_subsumed,
 					  struct commit_list *remoteheads)
 {
-	struct commit_list *parents, *next, **remotes = &remoteheads;
+	struct commit_list *parents, **remotes;
 
 	/*
 	 * Is the current HEAD reachable from another commit being
@@ -1033,16 +1033,14 @@ static struct commit_list *reduce_parents(struct commit *head_commit,
 	/* Find what parents to record by checking independent ones. */
 	parents = reduce_heads(remoteheads);
 
-	for (remoteheads = NULL, remotes = &remoteheads;
-	     parents;
-	     parents = next) {
-		struct commit *commit = parents->item;
-		next = parents->next;
+	remoteheads = NULL;
+	remotes = &remoteheads;
+	while (parents) {
+		struct commit *commit = pop_commit(&parents);
 		if (commit == head_commit)
 			*head_subsumed = 0;
 		else
 			remotes = &commit_list_insert(commit, remotes)->next;
-		free(parents);
 	}
 	return remoteheads;
 }
diff --git a/builtin/reflog.c b/builtin/reflog.c
index f96ca2a..cf1145e 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -218,7 +218,6 @@ static int keep_entry(struct commit **it, unsigned char *sha1)
  */
 static void mark_reachable(struct expire_reflog_policy_cb *cb)
 {
-	struct commit *commit;
 	struct commit_list *pending;
 	unsigned long expire_limit = cb->mark_limit;
 	struct commit_list *leftover = NULL;
@@ -228,11 +227,8 @@ static void mark_reachable(struct expire_reflog_policy_cb *cb)
 
 	pending = cb->mark_list;
 	while (pending) {
-		struct commit_list *entry = pending;
 		struct commit_list *parent;
-		pending = entry->next;
-		commit = entry->item;
-		free(entry);
+		struct commit *commit = pop_commit(&pending);
 		if (commit->object.flags & REACHABLE)
 			continue;
 		if (parse_commit(commit))
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 02d747d..e92a782 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -281,11 +281,8 @@ static int try_difference(const char *arg)
 			b = lookup_commit_reference(end);
 			exclude = get_merge_bases(a, b);
 			while (exclude) {
-				struct commit_list *n = exclude->next;
-				show_rev(REVERSED,
-					 exclude->item->object.sha1,NULL);
-				free(exclude);
-				exclude = n;
+				struct commit *commit = pop_commit(&exclude);
+				show_rev(REVERSED, commit->object.sha1, NULL);
 			}
 		}
 		*dotdot = '.';
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 092b59b..ac5141d 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -53,17 +53,6 @@ static struct commit *interesting(struct commit_list *list)
 	return NULL;
 }
 
-static struct commit *pop_one_commit(struct commit_list **list_p)
-{
-	struct commit *commit;
-	struct commit_list *list;
-	list = *list_p;
-	commit = list->item;
-	*list_p = list->next;
-	free(list);
-	return commit;
-}
-
 struct commit_name {
 	const char *head_name; /* which head's ancestor? */
 	int generation; /* how many parents away from head_name */
@@ -213,7 +202,7 @@ static void join_revs(struct commit_list **list_p,
 	while (*list_p) {
 		struct commit_list *parents;
 		int still_interesting = !!interesting(*list_p);
-		struct commit *commit = pop_one_commit(list_p);
+		struct commit *commit = pop_commit(list_p);
 		int flags = commit->object.flags & all_mask;
 
 		if (!still_interesting && extra <= 0)
@@ -504,7 +493,7 @@ static int show_merge_base(struct commit_list *seen, int num_rev)
 	int exit_status = 1;
 
 	while (seen) {
-		struct commit *commit = pop_one_commit(&seen);
+		struct commit *commit = pop_commit(&seen);
 		int flags = commit->object.flags & all_mask;
 		if (!(flags & UNINTERESTING) &&
 		    ((flags & all_revs) == all_revs)) {
@@ -929,7 +918,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 	all_revs = all_mask & ~((1u << REV_SHIFT) - 1);
 
 	while (seen) {
-		struct commit *commit = pop_one_commit(&seen);
+		struct commit *commit = pop_commit(&seen);
 		int this_flag = commit->object.flags;
 		int is_merge_point = ((this_flag & all_revs) == all_revs);
 
diff --git a/commit.c b/commit.c
index 494615d..d1810c9 100644
--- a/commit.c
+++ b/commit.c
@@ -455,11 +455,8 @@ struct commit_list *copy_commit_list(struct commit_list *list)
 
 void free_commit_list(struct commit_list *list)
 {
-	while (list) {
-		struct commit_list *temp = list;
-		list = temp->next;
-		free(temp);
-	}
+	while (list)
+		pop_commit(&list);
 }
 
 struct commit_list * commit_list_insert_by_date(struct commit *item, struct commit_list **list)
@@ -505,12 +502,8 @@ void commit_list_sort_by_date(struct commit_list **list)
 struct commit *pop_most_recent_commit(struct commit_list **list,
 				      unsigned int mark)
 {
-	struct commit *ret = (*list)->item;
+	struct commit *ret = pop_commit(list);
 	struct commit_list *parents = ret->parents;
-	struct commit_list *old = *list;
-
-	*list = (*list)->next;
-	free(old);
 
 	while (parents) {
 		struct commit *commit = parents->item;
@@ -861,11 +854,9 @@ static struct commit_list *merge_bases_many(struct commit *one, int n, struct co
 	list = paint_down_to_common(one, n, twos);
 
 	while (list) {
-		struct commit_list *next = list->next;
-		if (!(list->item->object.flags & STALE))
-			commit_list_insert_by_date(list->item, &result);
-		free(list);
-		list = next;
+		struct commit *commit = pop_commit(&list);
+		if (!(commit->object.flags & STALE))
+			commit_list_insert_by_date(commit, &result);
 	}
 	return result;
 }
@@ -1546,13 +1537,9 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 	 * if everything else stays the same.
 	 */
 	while (parents) {
-		struct commit_list *next = parents->next;
-		struct commit *parent = parents->item;
-
+		struct commit *parent = pop_commit(&parents);
 		strbuf_addf(&buffer, "parent %s\n",
 			    sha1_to_hex(parent->object.sha1));
-		free(parents);
-		parents = next;
 	}
 
 	/* Person/date information */
diff --git a/remote.c b/remote.c
index 1101f82..977e34e 100644
--- a/remote.c
+++ b/remote.c
@@ -1938,10 +1938,8 @@ int resolve_remote_symref(struct ref *ref, struct ref *list)
 static void unmark_and_free(struct commit_list *list, unsigned int mark)
 {
 	while (list) {
-		struct commit_list *temp = list;
-		temp->item->object.flags &= ~mark;
-		list = temp->next;
-		free(temp);
+		struct commit *commit = pop_commit(&list);
+		commit->object.flags &= ~mark;
 	}
 }
 
diff --git a/revision.c b/revision.c
index 2236463..0fbb684 100644
--- a/revision.c
+++ b/revision.c
@@ -153,10 +153,7 @@ void mark_parents_uninteresting(struct commit *commit)
 		commit_list_insert(l->item, &parents);
 
 	while (parents) {
-		struct commit *commit = parents->item;
-		l = parents;
-		parents = parents->next;
-		free(l);
+		struct commit *commit = pop_commit(&parents);
 
 		while (commit) {
 			/*
@@ -1102,14 +1099,10 @@ static int limit_list(struct rev_info *revs)
 	}
 
 	while (list) {
-		struct commit_list *entry = list;
-		struct commit *commit = list->item;
+		struct commit *commit = pop_commit(&list);
 		struct object *obj = &commit->object;
 		show_early_output_fn_t show;
 
-		list = list->next;
-		free(entry);
-
 		if (commit == interesting_cache)
 			interesting_cache = NULL;
 
@@ -2733,10 +2726,7 @@ static void simplify_merges(struct rev_info *revs)
 		yet_to_do = NULL;
 		tail = &yet_to_do;
 		while (list) {
-			commit = list->item;
-			next = list->next;
-			free(list);
-			list = next;
+			commit = pop_commit(&list);
 			tail = simplify_one(revs, commit, tail);
 		}
 	}
@@ -2748,10 +2738,7 @@ static void simplify_merges(struct rev_info *revs)
 	while (list) {
 		struct merge_simplify_state *st;
 
-		commit = list->item;
-		next = list->next;
-		free(list);
-		list = next;
+		commit = pop_commit(&list);
 		st = locate_simplify_state(revs, commit);
 		if (st->simplified == commit)
 			tail = &commit_list_insert(commit, tail)->next;
@@ -3125,11 +3112,7 @@ static struct commit *get_revision_1(struct rev_info *revs)
 		return NULL;
 
 	do {
-		struct commit_list *entry = revs->commits;
-		struct commit *commit = entry->item;
-
-		revs->commits = entry->next;
-		free(entry);
+		struct commit *commit = pop_commit(&revs->commits);
 
 		if (revs->reflog_info) {
 			save_parents(revs, commit);
diff --git a/shallow.c b/shallow.c
index d49a3d6..4dcb454 100644
--- a/shallow.c
+++ b/shallow.c
@@ -401,13 +401,9 @@ static void paint_down(struct paint_info *info, const unsigned char *sha1,
 	commit_list_insert(c, &head);
 	while (head) {
 		struct commit_list *p;
-		struct commit *c = head->item;
+		struct commit *c = pop_commit(&head);
 		uint32_t **refs = ref_bitmap_at(&info->ref_bitmap, c);
 
-		p = head;
-		head = head->next;
-		free(p);
-
 		/* XXX check "UNINTERESTING" from pack bitmaps if available */
 		if (c->object.flags & (SEEN | UNINTERESTING))
 			continue;
diff --git a/upload-pack.c b/upload-pack.c
index 89e832b..d0bc3ca 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -316,10 +316,8 @@ static int reachable(struct commit *want)
 
 	commit_list_insert_by_date(want, &work);
 	while (work) {
-		struct commit_list *list = work->next;
-		struct commit *commit = work->item;
-		free(work);
-		work = list;
+		struct commit_list *list;
+		struct commit *commit = pop_commit(&work);
 
 		if (commit->object.flags & THEY_HAVE) {
 			want->object.flags |= COMMON_KNOWN;
-- 
2.6.2

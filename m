From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH] commit: Append commit_list prefix in two function names.
Date: Sun, 14 Nov 2010 19:03:03 -0200
Message-ID: <0b9cde68dcdfddc13a91a63f9deb3384576164de.1289768501.git.tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 14 22:03:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHjjM-0002c8-5n
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 22:03:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755535Ab0KNVDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Nov 2010 16:03:15 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39148 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754330Ab0KNVDO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 16:03:14 -0500
Received: by ywc21 with SMTP id 21so1412095ywc.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 13:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=LYsuqpgPKvs6dyFKIUCV/uVeWo+YGnq2LxFnXioxrxc=;
        b=xwkMW8stKfZ9cZjQ115hgUNGd1dUbwusvd5iloL45p2fJe4KsT22EigEUkQTBF1Yiz
         CReDJwti6aAGurwdFTqPi1QyAMtVbGRtFGzUNCA6FHG7Soy+IUOwDK7tZHH39OjC0Ika
         cXs2y+0x+PoAmzHVcL1ZWBnCOYV1nyrIXVZDE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=QEg7gs1A+lTfiQDdQvz03sQI6UZvgCe0Ju5DkeEOCwNUN9yuFsSLi/g9wUpbVJGLgu
         I5hf4Zpdfn/2hc3WM7TSTO4NMuS65/PnNRO35MDH4LF2h+7I1VTGUcFUpxhp6vXU9KUq
         UCdF+0L8A9JuEjl6v+nhvoYOP3hJUKlHa97eg=
Received: by 10.150.202.8 with SMTP id z8mr4912359ybf.34.1289768592365;
        Sun, 14 Nov 2010 13:03:12 -0800 (PST)
Received: from localhost ([186.205.6.151])
        by mx.google.com with ESMTPS id w5sm2542702ybe.22.2010.11.14.13.03.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Nov 2010 13:03:11 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.161.g3089c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161440>

Append commit_lis prefix to insert_by_date function and to sort_by_date,
so it's clear that these functions refer to commit_list structure.

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 builtin/describe.c    |    6 +++---
 builtin/fetch-pack.c  |    4 ++--
 builtin/show-branch.c |    6 +++---
 commit.c              |   24 ++++++++++++------------
 commit.h              |   10 +++++-----
 revision.c            |   12 ++++++------
 sha1_name.c           |    2 +-
 upload-pack.c         |    4 ++--
 walker.c              |    2 +-
 9 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 43caff2..9304dd0 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -189,7 +189,7 @@ static unsigned long finish_depth_computation(
 			struct commit *p = parents->item;
 			parse_commit(p);
 			if (!(p->object.flags & SEEN))
-				insert_by_date(p, list);
+				commit_list_insert_by_date(p, list);
 			p->object.flags |= c->object.flags;
 			parents = parents->next;
 		}
@@ -300,7 +300,7 @@ static void describe(const char *arg, int last_one)
 			struct commit *p = parents->item;
 			parse_commit(p);
 			if (!(p->object.flags & SEEN))
-				insert_by_date(p, &list);
+				commit_list_insert_by_date(p, &list);
 			p->object.flags |= c->object.flags;
 			parents = parents->next;
 		}
@@ -328,7 +328,7 @@ static void describe(const char *arg, int last_one)
 	qsort(all_matches, match_cnt, sizeof(all_matches[0]), compare_pt);
 
 	if (gave_up_on) {
-		insert_by_date(gave_up_on, &list);
+		commit_list_insert_by_date(gave_up_on, &list);
 		seen_commits--;
 	}
 	seen_commits += finish_depth_computation(&list, &all_matches[0]);
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index dbd8b7b..b999413 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -47,7 +47,7 @@ static void rev_list_push(struct commit *commit, int mark)
 			if (parse_commit(commit))
 				return;
 
-		insert_by_date(commit, &rev_list);
+		commit_list_insert_by_date(commit, &rev_list);
 
 		if (!(commit->object.flags & COMMON))
 			non_common_revs++;
@@ -436,7 +436,7 @@ static int mark_complete(const char *path, const unsigned char *sha1, int flag,
 	if (o && o->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *)o;
 		commit->object.flags |= COMPLETE;
-		insert_by_date(commit, &complete);
+		commit_list_insert_by_date(commit, &complete);
 	}
 	return 0;
 }
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 8663cca..da69581 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -243,7 +243,7 @@ static void join_revs(struct commit_list **list_p,
 			if (mark_seen(p, seen_p) && !still_interesting)
 				extra--;
 			p->object.flags |= flags;
-			insert_by_date(p, list_p);
+			commit_list_insert_by_date(p, list_p);
 		}
 	}
 
@@ -859,7 +859,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		 */
 		commit->object.flags |= flag;
 		if (commit->object.flags == flag)
-			insert_by_date(commit, &list);
+			commit_list_insert_by_date(commit, &list);
 		rev[num_rev] = commit;
 	}
 	for (i = 0; i < num_rev; i++)
@@ -868,7 +868,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 	if (0 <= extra)
 		join_revs(&list, &seen, num_rev, extra);
 
-	sort_by_date(&seen);
+	commit_list_sort_by_date(&seen);
 
 	if (merge_base)
 		return show_merge_base(seen, num_rev);
diff --git a/commit.c b/commit.c
index 0094ec1..554dcc3 100644
--- a/commit.c
+++ b/commit.c
@@ -360,7 +360,7 @@ void free_commit_list(struct commit_list *list)
 	}
 }
 
-struct commit_list * insert_by_date(struct commit *item, struct commit_list **list)
+struct commit_list * commit_list_insert_by_date(struct commit *item, struct commit_list **list)
 {
 	struct commit_list **pp = list;
 	struct commit_list *p;
@@ -374,11 +374,11 @@ struct commit_list * insert_by_date(struct commit *item, struct commit_list **li
 }
 
 
-void sort_by_date(struct commit_list **list)
+void commit_list_sort_by_date(struct commit_list **list)
 {
 	struct commit_list *ret = NULL;
 	while (*list) {
-		insert_by_date((*list)->item, &ret);
+		commit_list_insert_by_date((*list)->item, &ret);
 		*list = (*list)->next;
 	}
 	*list = ret;
@@ -398,7 +398,7 @@ struct commit *pop_most_recent_commit(struct commit_list **list,
 		struct commit *commit = parents->item;
 		if (!parse_commit(commit) && !(commit->object.flags & mark)) {
 			commit->object.flags |= mark;
-			insert_by_date(commit, list);
+			commit_list_insert_by_date(commit, list);
 		}
 		parents = parents->next;
 	}
@@ -487,7 +487,7 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 
 	/* process the list in topological order */
 	if (!lifo)
-		sort_by_date(&work);
+		commit_list_sort_by_date(&work);
 
 	pptr = list;
 	*list = NULL;
@@ -513,7 +513,7 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 			 */
 			if (--parent->indegree == 1) {
 				if (!lifo)
-					insert_by_date(parent, &work);
+					commit_list_insert_by_date(parent, &work);
 				else
 					commit_list_insert(parent, &work);
 			}
@@ -573,10 +573,10 @@ static struct commit_list *merge_bases_many(struct commit *one, int n, struct co
 	}
 
 	one->object.flags |= PARENT1;
-	insert_by_date(one, &list);
+	commit_list_insert_by_date(one, &list);
 	for (i = 0; i < n; i++) {
 		twos[i]->object.flags |= PARENT2;
-		insert_by_date(twos[i], &list);
+		commit_list_insert_by_date(twos[i], &list);
 	}
 
 	while (interesting(list)) {
@@ -594,7 +594,7 @@ static struct commit_list *merge_bases_many(struct commit *one, int n, struct co
 		if (flags == (PARENT1 | PARENT2)) {
 			if (!(commit->object.flags & RESULT)) {
 				commit->object.flags |= RESULT;
-				insert_by_date(commit, &result);
+				commit_list_insert_by_date(commit, &result);
 			}
 			/* Mark parents of a found merge stale */
 			flags |= STALE;
@@ -608,7 +608,7 @@ static struct commit_list *merge_bases_many(struct commit *one, int n, struct co
 			if (parse_commit(p))
 				return NULL;
 			p->object.flags |= flags;
-			insert_by_date(p, &list);
+			commit_list_insert_by_date(p, &list);
 		}
 	}
 
@@ -618,7 +618,7 @@ static struct commit_list *merge_bases_many(struct commit *one, int n, struct co
 	while (list) {
 		struct commit_list *next = list->next;
 		if (!(list->item->object.flags & STALE))
-			insert_by_date(list->item, &result);
+			commit_list_insert_by_date(list->item, &result);
 		free(list);
 		list = next;
 	}
@@ -711,7 +711,7 @@ struct commit_list *get_merge_bases_many(struct commit *one,
 	result = NULL;
 	for (i = 0; i < cnt; i++) {
 		if (rslt[i])
-			insert_by_date(rslt[i], &result);
+			commit_list_insert_by_date(rslt[i], &result);
 	}
 	free(rslt);
 	return result;
diff --git a/commit.h b/commit.h
index 9113bbe..7fbebb5 100644
--- a/commit.h
+++ b/commit.h
@@ -38,20 +38,20 @@ struct commit *lookup_commit_reference_gently(const unsigned char *sha1,
 					      int quiet);
 
 int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size);
-
 int parse_commit(struct commit *item);
 
 /* Find beginning and length of commit subject. */
 int find_commit_subject(const char *commit_buffer, const char **subject);
 
-struct commit_list * commit_list_insert(struct commit *item, struct commit_list **list_p);
+struct commit_list *commit_list_insert(struct commit *item,
+					struct commit_list **list);
 unsigned commit_list_count(const struct commit_list *l);
-struct commit_list * insert_by_date(struct commit *item, struct commit_list **list);
+struct commit_list *commit_list_insert_by_date(struct commit *item,
+			            struct commit_list **list);
+void commit_list_sort_by_date(struct commit_list **list);
 
 void free_commit_list(struct commit_list *list);
 
-void sort_by_date(struct commit_list **list);
-
 /* Commit formats */
 enum cmit_fmt {
 	CMIT_FMT_RAW,
diff --git a/revision.c b/revision.c
index b1c1890..f8d4f87 100644
--- a/revision.c
+++ b/revision.c
@@ -444,15 +444,15 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 	commit->object.flags |= TREESAME;
 }
 
-static void insert_by_date_cached(struct commit *p, struct commit_list **head,
+static void commit_list_insert_by_date_cached(struct commit *p, struct commit_list **head,
 		    struct commit_list *cached_base, struct commit_list **cache)
 {
 	struct commit_list *new_entry;
 
 	if (cached_base && p->date < cached_base->item->date)
-		new_entry = insert_by_date(p, &cached_base->next);
+		new_entry = commit_list_insert_by_date(p, &cached_base->next);
 	else
-		new_entry = insert_by_date(p, head);
+		new_entry = commit_list_insert_by_date(p, head);
 
 	if (cache && (!*cache || p->date < (*cache)->item->date))
 		*cache = new_entry;
@@ -494,7 +494,7 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
 			if (p->object.flags & SEEN)
 				continue;
 			p->object.flags |= SEEN;
-			insert_by_date_cached(p, list, cached_base, cache_ptr);
+			commit_list_insert_by_date_cached(p, list, cached_base, cache_ptr);
 		}
 		return 0;
 	}
@@ -521,7 +521,7 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
 		p->object.flags |= left_flag;
 		if (!(p->object.flags & SEEN)) {
 			p->object.flags |= SEEN;
-			insert_by_date_cached(p, list, cached_base, cache_ptr);
+			commit_list_insert_by_date_cached(p, list, cached_base, cache_ptr);
 		}
 		if (revs->first_parent_only)
 			break;
@@ -1891,7 +1891,7 @@ int prepare_revision_walk(struct rev_info *revs)
 		if (commit) {
 			if (!(commit->object.flags & SEEN)) {
 				commit->object.flags |= SEEN;
-				insert_by_date(commit, &revs->commits);
+				commit_list_insert_by_date(commit, &revs->commits);
 			}
 		}
 		e++;
diff --git a/sha1_name.c b/sha1_name.c
index 484081d..e55ea05 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -683,7 +683,7 @@ static int handle_one_ref(const char *path,
 	}
 	if (object->type != OBJ_COMMIT)
 		return 0;
-	insert_by_date((struct commit *)object, list);
+	commit_list_insert_by_date((struct commit *)object, list);
 	object->flags |= ONELINE_SEEN;
 	return 0;
 }
diff --git a/upload-pack.c b/upload-pack.c
index f05e422..b40a43f 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -366,7 +366,7 @@ static int reachable(struct commit *want)
 {
 	struct commit_list *work = NULL;
 
-	insert_by_date(want, &work);
+	commit_list_insert_by_date(want, &work);
 	while (work) {
 		struct commit_list *list = work->next;
 		struct commit *commit = work->item;
@@ -387,7 +387,7 @@ static int reachable(struct commit *want)
 		for (list = commit->parents; list; list = list->next) {
 			struct commit *parent = list->item;
 			if (!(parent->object.flags & REACHABLE))
-				insert_by_date(parent, &work);
+				commit_list_insert_by_date(parent, &work);
 		}
 	}
 	want->object.flags |= REACHABLE;
diff --git a/walker.c b/walker.c
index 11d9052..dce7128 100644
--- a/walker.c
+++ b/walker.c
@@ -207,7 +207,7 @@ static int mark_complete(const char *path, const unsigned char *sha1, int flag,
 	struct commit *commit = lookup_commit_reference_gently(sha1, 1);
 	if (commit) {
 		commit->object.flags |= COMPLETE;
-		insert_by_date(commit, &complete);
+		commit_list_insert_by_date(commit, &complete);
 	}
 	return 0;
 }
-- 
1.7.3.2.161.g3089c

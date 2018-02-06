Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 251411F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752415AbeBFAZO (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:25:14 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:46654 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752229AbeBFAZN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:25:13 -0500
Received: by mail-pg0-f67.google.com with SMTP id s9so156485pgq.13
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oBKmrYFIiEAruxVUYhUbNUKto0qIOasygEOCMDBefuY=;
        b=BLVpiZFnzLvg8IUytEYQoJUdkRlvrSF+9ygXQdyCo/tmplsEQ/dEIc9eTw/nhE9nYO
         xrqm85mkjIpXKMl96FFgwXWtor5q7FegnsJRUqYeJkGg2Sy/L6DUU9U5wnOVxmswwpkq
         cvS73YGhV94dv++a1PndEhfQnOWTA5WH2o5QgPaN+KL3Gi8jKgkGY20oupXViEfm1Xj2
         pKAAykDCcV4tHU0H75BiygQSxmyKi2TAq4WHpsZBHM4/KuFvI3rv2qJI/P+hk9rDgSfh
         RLKRTy3hpCmkRg7B6AJ4WAT/M1deVVHAtUQ38ObJNohE3hMAf3L+mlDmXNuWScsSBeED
         BncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oBKmrYFIiEAruxVUYhUbNUKto0qIOasygEOCMDBefuY=;
        b=VQVuD+zTWQuevi8GVWpg5iLghx/ga32jUTZwFD9PMJe9EFd7/0lNlSc04mTxv9P9J1
         EvUq9MibYcgg6k7W2WtKapEGw9WOWSk33FWyoSLK4vyvKeHbtJA7fxh/GVXpwl8pYcuf
         5EhPPR2nNKzg50rZrjIS3G7QpSZuodtBXrsb6W20Opjl0x1pU8q6VImykyEgvEn4ANXJ
         gwq0UQRHJr+/J02IU3TQ5usj0KoqKvygniVgms23/A0EzeTPpHrabHshORU20YprEf5a
         +RarsTrYhGBhOSM+g0AMqskrfcbIXVj4af58mAtgI1RZyTQWWexDWqiDLmnb0sD8nsrv
         gC5g==
X-Gm-Message-State: APf1xPCsko9Rv7L9GduPigl3PoZ6Kzx3DcpfZbO4rxZozlrFUPr6DB0x
        R0H7W1BR9cKXunXNIn2SJfIpj6Ib3U8=
X-Google-Smtp-Source: AH8x224B+nVctyzHONjk0D35b1NpU/9cCwtPlXgIV96b1IpI1ImLjmm46mn2xvEOztoueBCmOGEd3w==
X-Received: by 10.98.9.202 with SMTP id 71mr565848pfj.122.1517876712231;
        Mon, 05 Feb 2018 16:25:12 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id m21sm15360281pgn.37.2018.02.05.16.25.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:25:11 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 144/194] commit: add repository argument to parse_commit
Date:   Mon,  5 Feb 2018 16:16:59 -0800
Message-Id: <20180206001749.218943-46-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow callers of parse_commit to
be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

The included coccinelle semantic patch will adapt any new callers in
the diff produced by `make coccicheck`.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 blame.c                               |  4 ++--
 builtin/checkout.c                    |  4 ++--
 builtin/commit.c                      |  4 ++--
 builtin/describe.c                    |  4 ++--
 builtin/merge-base.c                  |  2 +-
 builtin/name-rev.c                    |  2 +-
 builtin/notes.c                       |  2 +-
 builtin/reflog.c                      |  2 +-
 builtin/show-branch.c                 |  4 ++--
 commit.c                              | 18 +++++++++---------
 commit.h                              |  3 ++-
 contrib/coccinelle/object_store.cocci |  7 +++++++
 fetch-pack.c                          |  6 +++---
 fsck.c                                |  2 +-
 merge-recursive.c                     |  4 ++--
 notes-utils.c                         |  2 +-
 remote.c                              |  2 +-
 revision.c                            |  6 +++---
 sequencer.c                           | 12 ++++++------
 sha1_name.c                           |  4 ++--
 shallow.c                             |  4 ++--
 tree.c                                |  2 +-
 walker.c                              |  2 +-
 23 files changed, 55 insertions(+), 47 deletions(-)

diff --git a/blame.c b/blame.c
index 592bedd0e0..ccd6a5097b 100644
--- a/blame.c
+++ b/blame.c
@@ -1433,7 +1433,7 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 
 			if (sg_origin[i])
 				continue;
-			if (parse_commit(p))
+			if (parse_commit(the_repository, p))
 				continue;
 			porigin = find(p, origin);
 			if (!porigin)
@@ -1572,7 +1572,7 @@ void assign_blame(struct blame_scoreboard *sb, int opt)
 		 * so hold onto it in the meantime.
 		 */
 		blame_origin_incref(suspect);
-		parse_commit(commit);
+		parse_commit(the_repository, commit);
 		if (sb->reverse ||
 		    (!(commit->object.flags & UNINTERESTING) &&
 		     !(revs->max_age != -1 && commit->date < revs->max_age)))
diff --git a/builtin/checkout.c b/builtin/checkout.c
index cef2b4f2ad..4428fd5da5 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -403,7 +403,7 @@ static void describe_detached_head(const char *msg, struct commit *commit)
 {
 	struct strbuf sb = STRBUF_INIT;
 
-	if (!parse_commit(commit))
+	if (!parse_commit(the_repository, commit))
 		pp_commit_easy(CMIT_FMT_ONELINE, commit, &sb);
 	if (print_sha1_ellipsis()) {
 		fprintf(stderr, "%s %s... %s\n", msg,
@@ -724,7 +724,7 @@ static void describe_one_orphan(struct strbuf *sb, struct commit *commit)
 	strbuf_addstr(sb, "  ");
 	strbuf_add_unique_abbrev(sb, commit->object.oid.hash, DEFAULT_ABBREV);
 	strbuf_addch(sb, ' ');
-	if (!parse_commit(commit))
+	if (!parse_commit(the_repository, commit))
 		pp_commit_easy(CMIT_FMT_ONELINE, commit, sb);
 	strbuf_addch(sb, '\n');
 }
diff --git a/builtin/commit.c b/builtin/commit.c
index cd3144f9f4..d15592ad45 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1467,7 +1467,7 @@ static void print_summary(const char *prefix, const struct object_id *oid,
 	commit = lookup_commit(the_repository, oid);
 	if (!commit)
 		die(_("couldn't look up newly created commit"));
-	if (parse_commit(commit))
+	if (parse_commit(the_repository, commit))
 		die(_("could not parse newly created commit"));
 
 	strbuf_addstr(&format, "format:%h] %s");
@@ -1692,7 +1692,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		current_head = NULL;
 	else {
 		current_head = lookup_commit_or_die(&oid, "HEAD");
-		if (parse_commit(current_head))
+		if (parse_commit(the_repository, current_head))
 			die(_("could not parse HEAD commit"));
 	}
 	verbose = -1; /* unspecified */
diff --git a/builtin/describe.c b/builtin/describe.c
index 5bd0920ebd..870a3a780b 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -249,7 +249,7 @@ static unsigned long finish_depth_computation(
 			best->depth++;
 		while (parents) {
 			struct commit *p = parents->item;
-			parse_commit(p);
+			parse_commit(the_repository, p);
 			if (!(p->object.flags & SEEN))
 				commit_list_insert_by_date(p, list);
 			p->object.flags |= c->object.flags;
@@ -367,7 +367,7 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 		}
 		while (parents) {
 			struct commit *p = parents->item;
-			parse_commit(p);
+			parse_commit(the_repository, p);
 			if (!(p->object.flags & SEEN))
 				commit_list_insert_by_date(p, &list);
 			p->object.flags |= c->object.flags;
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 08d91b1f0c..426882818c 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -127,7 +127,7 @@ static void add_one_commit(struct object_id *oid, struct rev_collect *revs)
 	commit = lookup_commit(the_repository, oid);
 	if (!commit ||
 	    (commit->object.flags & TMP_MARK) ||
-	    parse_commit(commit))
+	    parse_commit(the_repository, commit))
 		return;
 
 	ALLOC_GROW(revs->commit, revs->nr + 1, revs->alloc);
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 2cbb702c2c..57db381381 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -71,7 +71,7 @@ static void name_rev(struct commit *commit,
 	int parent_number = 1;
 	char *to_free = NULL;
 
-	parse_commit(commit);
+	parse_commit(the_repository, commit);
 
 	if (commit->date < cutoff)
 		return;
diff --git a/builtin/notes.c b/builtin/notes.c
index 56d99c2789..9100ac5ce0 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -715,7 +715,7 @@ static int merge_commit(struct notes_merge_options *o)
 		die(_("failed to read ref NOTES_MERGE_PARTIAL"));
 	else if (!(partial = lookup_commit_reference(the_repository, &oid)))
 		die(_("could not find commit from NOTES_MERGE_PARTIAL."));
-	else if (parse_commit(partial))
+	else if (parse_commit(the_repository, partial))
 		die(_("could not parse commit from NOTES_MERGE_PARTIAL."));
 
 	if (partial->parents)
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 3b600966e3..05eb1baa31 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -235,7 +235,7 @@ static void mark_reachable(struct expire_reflog_policy_cb *cb)
 		struct commit *commit = pop_commit(&pending);
 		if (commit->object.flags & REACHABLE)
 			continue;
-		if (parse_commit(commit))
+		if (parse_commit(the_repository, commit))
 			continue;
 		commit->object.flags |= REACHABLE;
 		if (commit->date < expire_limit) {
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 03c98efbe5..a3195937d3 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -220,7 +220,7 @@ static void join_revs(struct commit_list **list_p,
 			parents = parents->next;
 			if ((this_flag & flags) == flags)
 				continue;
-			parse_commit(p);
+			parse_commit(the_repository, p);
 			if (mark_seen(p, seen_p) && !still_interesting)
 				extra--;
 			p->object.flags |= flags;
@@ -815,7 +815,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		if (!commit)
 			die(_("cannot find commit %s (%s)"),
 			    ref_name[num_rev], oid_to_hex(&revkey));
-		parse_commit(commit);
+		parse_commit(the_repository, commit);
 		mark_seen(commit, &seen);
 
 		/* rev#0 uses bit REV_SHIFT, rev#1 uses bit REV_SHIFT+1,
diff --git a/commit.c b/commit.c
index 93a4f70fa4..49c8f76e41 100644
--- a/commit.c
+++ b/commit.c
@@ -67,7 +67,7 @@ struct commit *lookup_commit_reference_by_name(const char *name)
 	if (get_oid_committish(name, &oid))
 		return NULL;
 	commit = lookup_commit_reference(the_repository, &oid);
-	if (parse_commit(commit))
+	if (parse_commit(the_repository, commit))
 		return NULL;
 	return commit;
 }
@@ -417,7 +417,7 @@ int parse_commit_gently_the_repository(struct commit *item, int quiet_on_missing
 
 void parse_commit_or_die(struct commit *item)
 {
-	if (parse_commit(item))
+	if (parse_commit(the_repository, item))
 		die("unable to parse commit %s",
 		    item ? oid_to_hex(&item->object.oid) : "(null)");
 }
@@ -522,7 +522,7 @@ struct commit *pop_most_recent_commit(struct commit_list **list,
 
 	while (parents) {
 		struct commit *commit = parents->item;
-		if (!parse_commit(commit) && !(commit->object.flags & mark)) {
+		if (!parse_commit(the_repository, commit) && !(commit->object.flags & mark)) {
 			commit->object.flags |= mark;
 			commit_list_insert_by_date(commit, list);
 		}
@@ -834,7 +834,7 @@ static struct commit_list *paint_down_to_common(struct commit *one, int n, struc
 			parents = parents->next;
 			if ((p->object.flags & flags) == flags)
 				continue;
-			if (parse_commit(p))
+			if (parse_commit(the_repository, p))
 				return NULL;
 			p->object.flags |= flags;
 			prio_queue_put(&queue, p);
@@ -860,10 +860,10 @@ static struct commit_list *merge_bases_many(struct commit *one, int n, struct co
 			return commit_list_insert(one, &result);
 	}
 
-	if (parse_commit(one))
+	if (parse_commit(the_repository, one))
 		return NULL;
 	for (i = 0; i < n; i++) {
-		if (parse_commit(twos[i]))
+		if (parse_commit(the_repository, twos[i]))
 			return NULL;
 	}
 
@@ -922,7 +922,7 @@ static int remove_redundant(struct commit **array, int cnt)
 	ALLOC_ARRAY(filled_index, cnt - 1);
 
 	for (i = 0; i < cnt; i++)
-		parse_commit(array[i]);
+		parse_commit(the_repository, array[i]);
 	for (i = 0; i < cnt; i++) {
 		struct commit_list *common;
 
@@ -1046,10 +1046,10 @@ int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit *
 	struct commit_list *bases;
 	int ret = 0, i;
 
-	if (parse_commit(commit))
+	if (parse_commit(the_repository, commit))
 		return ret;
 	for (i = 0; i < nr_reference; i++)
-		if (parse_commit(reference[i]))
+		if (parse_commit(the_repository, reference[i]))
 			return ret;
 
 	bases = paint_down_to_common(commit, nr_reference, reference);
diff --git a/commit.h b/commit.h
index bb2b1e1e28..16203fb18c 100644
--- a/commit.h
+++ b/commit.h
@@ -68,7 +68,8 @@ struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref
 int parse_commit_buffer_the_repository(struct commit *item, const void *buffer, unsigned long size);
 #define parse_commit_gently(r, i, q) parse_commit_gently_##r(i, q)
 int parse_commit_gently_the_repository(struct commit *item, int quiet_on_missing);
-static inline int parse_commit(struct commit *item)
+#define parse_commit(r, i) parse_commit_##r(i)
+static inline int parse_commit_the_repository(struct commit *item)
 {
 	return parse_commit_gently(the_repository, item, 0);
 }
diff --git a/contrib/coccinelle/object_store.cocci b/contrib/coccinelle/object_store.cocci
index 93b1d03971..3ffb34d5b5 100644
--- a/contrib/coccinelle/object_store.cocci
+++ b/contrib/coccinelle/object_store.cocci
@@ -53,3 +53,10 @@ expression F;
 + the_repository,
   E, F)
 
+@@
+expression E;
+@@
+ parse_commit(
++ the_repository,
+ E)
+
diff --git a/fetch-pack.c b/fetch-pack.c
index f38beea6a3..e8b1fc0d1b 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -112,7 +112,7 @@ static void rev_list_push(struct commit *commit, int mark)
 	if (!(commit->object.flags & mark)) {
 		commit->object.flags |= mark;
 
-		if (parse_commit(commit))
+		if (parse_commit(the_repository, commit))
 			return;
 
 		prio_queue_put(&rev_list, commit);
@@ -176,7 +176,7 @@ static void mark_common(struct commit *commit,
 			if (!ancestors_only && !(o->flags & POPPED))
 				non_common_revs--;
 			if (!o->parsed && !dont_parse)
-				if (parse_commit(commit))
+				if (parse_commit(the_repository, commit))
 					return;
 
 			for (parents = commit->parents;
@@ -203,7 +203,7 @@ static const struct object_id *get_rev(void)
 			return NULL;
 
 		commit = prio_queue_get(&rev_list);
-		parse_commit(commit);
+		parse_commit(the_repository, commit);
 		parents = commit->parents;
 
 		commit->object.flags |= POPPED;
diff --git a/fsck.c b/fsck.c
index 5144ceb8e2..494b4e3b30 100644
--- a/fsck.c
+++ b/fsck.c
@@ -393,7 +393,7 @@ static int fsck_walk_commit(struct commit *commit, void *data, struct fsck_optio
 	int result;
 	const char *name;
 
-	if (parse_commit(commit))
+	if (parse_commit(the_repository, commit))
 		return -1;
 
 	name = get_object_name(options, &commit->object);
diff --git a/merge-recursive.c b/merge-recursive.c
index f6d28f0d8f..719fa58ab1 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -233,7 +233,7 @@ static void output_commit_title(struct merge_options *o, struct commit *commit)
 		strbuf_add_unique_abbrev(&o->obuf, commit->object.oid.hash,
 					 DEFAULT_ABBREV);
 		strbuf_addch(&o->obuf, ' ');
-		if (parse_commit(commit) != 0)
+		if (parse_commit(the_repository, commit) != 0)
 			strbuf_addstr(&o->obuf, _("(bad commit)\n"));
 		else {
 			const char *title;
@@ -2162,7 +2162,7 @@ static struct commit *get_ref(const struct object_id *oid, const char *name)
 		return make_virtual_commit((struct tree*)object, name);
 	if (object->type != OBJ_COMMIT)
 		return NULL;
-	if (parse_commit((struct commit *)object))
+	if (parse_commit(the_repository, (struct commit *)object))
 		return NULL;
 	return (struct commit *)object;
 }
diff --git a/notes-utils.c b/notes-utils.c
index 3ef5340c6e..7b0b2a8f8a 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -22,7 +22,7 @@ void create_notes_commit(struct notes_tree *t, struct commit_list *parents,
 		if (!read_ref(t->ref, &parent_oid)) {
 			struct commit *parent = lookup_commit(the_repository,
 							      &parent_oid);
-			if (parse_commit(parent))
+			if (parse_commit(the_repository, parent))
 				die("Failed to find/parse commit %s", t->ref);
 			commit_list_insert(parent, &parents);
 		}
diff --git a/remote.c b/remote.c
index ecfa60a975..a4cf885012 100644
--- a/remote.c
+++ b/remote.c
@@ -1993,7 +1993,7 @@ int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid)
 		return 0;
 	new = (struct commit *) o;
 
-	if (parse_commit(new) < 0)
+	if (parse_commit(the_repository, new) < 0)
 		return 0;
 
 	used = list = NULL;
diff --git a/revision.c b/revision.c
index 7501ef3160..56c1a9a78f 100644
--- a/revision.c
+++ b/revision.c
@@ -253,7 +253,7 @@ static struct commit *handle_commit(struct rev_info *revs,
 	 */
 	if (object->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *)object;
-		if (parse_commit(commit) < 0)
+		if (parse_commit(the_repository, commit) < 0)
 			die("unable to parse commit %s", name);
 		if (flags & UNINTERESTING) {
 			mark_parents_uninteresting(commit);
@@ -663,7 +663,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 					ts->treesame[0] = 1;
 			}
 		}
-		if (parse_commit(p) < 0)
+		if (parse_commit(the_repository, p) < 0)
 			die("cannot simplify commit %s (because of %s)",
 			    oid_to_hex(&commit->object.oid),
 			    oid_to_hex(&p->object.oid));
@@ -696,7 +696,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 				 * IOW, we pretend this parent is a
 				 * "root" commit.
 				 */
-				if (parse_commit(p) < 0)
+				if (parse_commit(the_repository, p) < 0)
 					die("cannot simplify commit %s (invalid %s)",
 					    oid_to_hex(&commit->object.oid),
 					    oid_to_hex(&p->object.oid));
diff --git a/sequencer.c b/sequencer.c
index 4d259d9ae4..e94ed30965 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -507,7 +507,7 @@ static int is_index_unchanged(void)
 	 * the commit is invalid, parse_commit() will complain.  So
 	 * there is nothing for us to say here.  Just return failure.
 	 */
-	if (parse_commit(head_commit))
+	if (parse_commit(the_repository, head_commit))
 		return -1;
 
 	if (!active_cache_tree)
@@ -700,12 +700,12 @@ static int is_original_commit_empty(struct commit *commit)
 {
 	const struct object_id *ptree_oid;
 
-	if (parse_commit(commit))
+	if (parse_commit(the_repository, commit))
 		return error(_("could not parse commit %s"),
 			     oid_to_hex(&commit->object.oid));
 	if (commit->parents) {
 		struct commit *parent = commit->parents->item;
-		if (parse_commit(parent))
+		if (parse_commit(the_repository, parent))
 			return error(_("could not parse parent commit %s"),
 				oid_to_hex(&parent->object.oid));
 		ptree_oid = &parent->tree->object.oid;
@@ -1019,7 +1019,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		msg_file = NULL;
 		goto fast_forward_edit;
 	}
-	if (parent && parse_commit(parent) < 0)
+	if (parent && parse_commit(the_repository, parent) < 0)
 		/* TRANSLATORS: The first %s will be a "todo" command like
 		   "revert" or "pick", the second %s a SHA1. */
 		return error(_("%s: cannot parse parent commit %s"),
@@ -2774,7 +2774,7 @@ int skip_unnecessary_picks(void)
 			continue;
 		if (item->command != TODO_PICK)
 			break;
-		if (parse_commit(item->commit)) {
+		if (parse_commit(the_repository, item->commit)) {
 			todo_list_release(&todo_list);
 			return error(_("could not parse commit '%s'"),
 				oid_to_hex(&item->commit->object.oid));
@@ -2903,7 +2903,7 @@ int rearrange_squash(void)
 
 		item->commit->util = item;
 
-		parse_commit(item->commit);
+		parse_commit(the_repository, item->commit);
 		commit_buffer = get_commit_buffer(item->commit, NULL);
 		find_commit_subject(commit_buffer, &subject);
 		format_subject(&buf, subject, " ");
diff --git a/sha1_name.c b/sha1_name.c
index 45b7d6be91..43fe20b927 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -850,7 +850,7 @@ static int get_parent(const char *name, int len,
 	if (ret)
 		return ret;
 	commit = lookup_commit_reference(the_repository, &oid);
-	if (parse_commit(commit))
+	if (parse_commit(the_repository, commit))
 		return -1;
 	if (!idx) {
 		oidcpy(result, &commit->object.oid);
@@ -882,7 +882,7 @@ static int get_nth_ancestor(const char *name, int len,
 		return -1;
 
 	while (generation--) {
-		if (parse_commit(commit) || !commit->parents)
+		if (parse_commit(the_repository, commit) || !commit->parents)
 			return -1;
 		commit = commit->parents->item;
 	}
diff --git a/shallow.c b/shallow.c
index 004f99d4e2..254c1a397a 100644
--- a/shallow.c
+++ b/shallow.c
@@ -194,7 +194,7 @@ struct commit_list *get_shallow_commits_by_rev_list(int ac, const char **av,
 		struct commit *c = p->item;
 		struct commit_list *parent;
 
-		if (parse_commit(c))
+		if (parse_commit(the_repository, c))
 			die("unable to parse commit %s",
 			    oid_to_hex(&c->object.oid));
 
@@ -515,7 +515,7 @@ static void paint_down(struct paint_info *info, const struct object_id *oid,
 		if (c->object.flags & BOTTOM)
 			continue;
 
-		if (parse_commit(c))
+		if (parse_commit(the_repository, c))
 			die("unable to parse commit %s",
 			    oid_to_hex(&c->object.oid));
 
diff --git a/tree.c b/tree.c
index 07cea88450..1635a01794 100644
--- a/tree.c
+++ b/tree.c
@@ -106,7 +106,7 @@ static int read_tree_1(struct tree *tree, struct strbuf *base,
 				    oid_to_hex(entry.oid),
 				    base->buf, entry.path);
 
-			if (parse_commit(commit))
+			if (parse_commit(the_repository, commit))
 				die("Invalid commit %s in submodule path %s%s",
 				    oid_to_hex(entry.oid),
 				    base->buf, entry.path);
diff --git a/walker.c b/walker.c
index b96e00a8f1..6efaf087df 100644
--- a/walker.c
+++ b/walker.c
@@ -76,7 +76,7 @@ static struct commit_list *complete = NULL;
 
 static int process_commit(struct walker *walker, struct commit *commit)
 {
-	if (parse_commit(commit))
+	if (parse_commit(the_repository, commit))
 		return -1;
 
 	while (complete && complete->item->date >= commit->date) {
-- 
2.15.1.433.g936d1b9894.dirty


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F0891F516
	for <e@80x24.org>; Fri, 29 Jun 2018 01:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936461AbeF2BW4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 21:22:56 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:40315 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936423AbeF2BWv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 21:22:51 -0400
Received: by mail-yw0-f201.google.com with SMTP id i203-v6so6058701ywg.7
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 18:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=y5R13gPG1wgb+zjcIzX0wXWik8mofXNXLAHVnm6HVso=;
        b=Uk0Bwz1gGfA5mCtLfJChse4z+XAO2qe2B61FTPEJC5fSR6J4PDbzl9bDYRl4AmMbT0
         XrQg7garOl0pK5aHT53VNiPXUy/iBrOAoNJIAiCF8tpm0zR7oR5572yQbhMCJqggEsu0
         tf8t17HB7p8/KCRgU6MYfAVPv4UAtEwWXTg6WSXgNLjQldCb86BrS0b33iISr4ifMDOK
         w8rPUZ9ixh1zqFzPdrRjt2Kp/mc8PLWyegw8qYD0fE0IeY/j5Qc0G0m4fiqkoS+RIhji
         i+up5BJtO/GmORB4XVM9mhm4njiot7+h8hkpGiS2mCzKymX1zoi2xmRe4w1zh0iPnpRE
         3GeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=y5R13gPG1wgb+zjcIzX0wXWik8mofXNXLAHVnm6HVso=;
        b=mDlgcxYP949vHOo/sYdTgtz+kgA/C5zoX96lJzgGGBkFQ4MHNHPWp+OzEJFg2cfgr6
         wAdI+H9yaShFkRD9dI1EBY1mQMLsENPXczINrfoUfBfmKp/x6Ka1KsGCzq2QfMvQ4ZUl
         Q8GoOqReNt57LMnKNMRdd3iWI1ie8d3OdNyrLET+kT1YAwNjrERq/4eM8LU4lzhi9ASe
         kC3DrPnZ+wT5P3u7EKtI1yKY82g7HWzH3+fY/GQKyxoD95Kuhz/LR+51fOke0ODYSZiL
         Q3dkBJVeUjDliQjpANGwCsyRPDHjHvrTIPSsLFgFWqXlxwm4dncHmuDXlDqsfjgz7dH4
         Sxjg==
X-Gm-Message-State: APt69E2yM0MZZhvyMca79tBKzF50KCEpqIUebUCIMXpLqoTw4Ffrtq9+
        G0mgRDKK2oNfTHNEKffrXYHm/dDhutkMM3ose5LUvDlCBRqomdYZHa2Fg/RreyJA0RN2VB9kTu0
        ZDyZtx5nT2Zv8MLcPp4hTLS3K8WSLR/kinzF6HJadad7ENvOR260bpPeJot/1
X-Google-Smtp-Source: ADUXVKKdHs8hL2jGhTQpTVJhe68u1otU3BUavyLcofkyVxLcqCXjT3+lwQhBrjzKbfnO+NV4H0azP0XOR/Ds
MIME-Version: 1.0
X-Received: by 2002:a25:b8cd:: with SMTP id g13-v6mr3481903ybm.81.1530235370933;
 Thu, 28 Jun 2018 18:22:50 -0700 (PDT)
Date:   Thu, 28 Jun 2018 18:21:58 -0700
In-Reply-To: <20180629012222.167426-1-sbeller@google.com>
Message-Id: <20180629012222.167426-9-sbeller@google.com>
References: <20180629012222.167426-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v3 08/32] commit: add repository argument to lookup_commit_reference
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow callers of lookup_commit_reference
to be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 bisect.c              |  2 +-
 blame.c               |  2 +-
 branch.c              |  2 +-
 builtin/branch.c      |  7 ++++---
 builtin/clone.c       |  3 ++-
 builtin/describe.c    |  2 +-
 builtin/diff-tree.c   |  2 +-
 builtin/log.c         |  7 ++++---
 builtin/merge-base.c  |  5 +++--
 builtin/notes.c       |  3 ++-
 builtin/pull.c        | 15 ++++++++++-----
 builtin/replace.c     |  4 ++--
 builtin/reset.c       |  4 ++--
 builtin/rev-parse.c   |  6 +++---
 builtin/show-branch.c |  2 +-
 builtin/tag.c         |  2 +-
 bundle.c              |  3 ++-
 commit.c              |  6 +++---
 commit.h              |  4 +++-
 merge-recursive.c     |  6 +++---
 notes-merge.c         |  5 +++--
 parse-options-cb.c    |  2 +-
 remote.c              |  4 ++--
 revision.c            |  4 ++--
 sequencer.c           |  6 +++---
 sha1-name.c           |  4 ++--
 submodule.c           |  4 ++--
 27 files changed, 65 insertions(+), 51 deletions(-)

diff --git a/bisect.c b/bisect.c
index 6de1abd407b..e1275ba79e8 100644
--- a/bisect.c
+++ b/bisect.c
@@ -724,7 +724,7 @@ static int bisect_checkout(const struct object_id *bisect_rev, int no_checkout)
 
 static struct commit *get_commit_reference(const struct object_id *oid)
 {
-	struct commit *r = lookup_commit_reference(oid);
+	struct commit *r = lookup_commit_reference(the_repository, oid);
 	if (!r)
 		die(_("Not a valid commit name %s"), oid_to_hex(oid));
 	return r;
diff --git a/blame.c b/blame.c
index 5b022cc2254..8a0655a5997 100644
--- a/blame.c
+++ b/blame.c
@@ -119,7 +119,7 @@ static struct commit_list **append_parent(struct commit_list **tail, const struc
 {
 	struct commit *parent;
 
-	parent = lookup_commit_reference(oid);
+	parent = lookup_commit_reference(the_repository, oid);
 	if (!parent)
 		die("no such commit %s", oid_to_hex(oid));
 	return &commit_list_insert(parent, tail)->next;
diff --git a/branch.c b/branch.c
index 6a35dd31f2a..ecd710d7308 100644
--- a/branch.c
+++ b/branch.c
@@ -302,7 +302,7 @@ void create_branch(const char *name, const char *start_name,
 		break;
 	}
 
-	if ((commit = lookup_commit_reference(&oid)) == NULL)
+	if ((commit = lookup_commit_reference(the_repository, &oid)) == NULL)
 		die(_("Not a valid branch point: '%s'."), start_name);
 	oidcpy(&oid, &commit->object.oid);
 
diff --git a/builtin/branch.c b/builtin/branch.c
index 1876ca9e796..a50632fb23f 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -121,7 +121,8 @@ static int branch_merged(int kind, const char *name,
 		    (reference_name = reference_name_to_free =
 		     resolve_refdup(upstream, RESOLVE_REF_READING,
 				    &oid, NULL)) != NULL)
-			reference_rev = lookup_commit_reference(&oid);
+			reference_rev = lookup_commit_reference(the_repository,
+								&oid);
 	}
 	if (!reference_rev)
 		reference_rev = head_rev;
@@ -154,7 +155,7 @@ static int check_branch_commit(const char *branchname, const char *refname,
 			       const struct object_id *oid, struct commit *head_rev,
 			       int kinds, int force)
 {
-	struct commit *rev = lookup_commit_reference(oid);
+	struct commit *rev = lookup_commit_reference(the_repository, oid);
 	if (!rev) {
 		error(_("Couldn't look up commit object for '%s'"), refname);
 		return -1;
@@ -208,7 +209,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	}
 
 	if (!force) {
-		head_rev = lookup_commit_reference(&head_oid);
+		head_rev = lookup_commit_reference(the_repository, &head_oid);
 		if (!head_rev)
 			die(_("Couldn't look up commit object for HEAD"));
 	}
diff --git a/builtin/clone.c b/builtin/clone.c
index 1d939af9d8c..4b3b48ee84a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -696,7 +696,8 @@ static void update_head(const struct ref *our, const struct ref *remote,
 			install_branch_config(0, head, option_origin, our->name);
 		}
 	} else if (our) {
-		struct commit *c = lookup_commit_reference(&our->old_oid);
+		struct commit *c = lookup_commit_reference(the_repository,
+							   &our->old_oid);
 		/* --branch specifies a non-branch (i.e. tags), detach HEAD */
 		update_ref(msg, "HEAD", &c->object.oid, NULL, REF_NO_DEREF,
 			   UPDATE_REFS_DIE_ON_ERR);
diff --git a/builtin/describe.c b/builtin/describe.c
index 0b5d8562331..c8ff64766d0 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -303,7 +303,7 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 	unsigned long seen_commits = 0;
 	unsigned int unannotated_cnt = 0;
 
-	cmit = lookup_commit_reference(oid);
+	cmit = lookup_commit_reference(the_repository, oid);
 
 	n = find_commit_name(&cmit->object.oid);
 	if (n && (tags || all || n->prio == 2)) {
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 29901515a13..a5718d96ee2 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -11,7 +11,7 @@ static struct rev_info log_tree_opt;
 
 static int diff_tree_commit_oid(const struct object_id *oid)
 {
-	struct commit *commit = lookup_commit_reference(oid);
+	struct commit *commit = lookup_commit_reference(the_repository, oid);
 	if (!commit)
 		return -1;
 	return log_tree_commit(&log_tree_opt, commit);
diff --git a/builtin/log.c b/builtin/log.c
index 05217596a2b..55a6286d7f4 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -907,8 +907,8 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids)
 	o2 = rev->pending.objects[1].item;
 	flags1 = o1->flags;
 	flags2 = o2->flags;
-	c1 = lookup_commit_reference(&o1->oid);
-	c2 = lookup_commit_reference(&o2->oid);
+	c1 = lookup_commit_reference(the_repository, &o1->oid);
+	c2 = lookup_commit_reference(the_repository, &o2->oid);
 
 	if ((flags1 & UNINTERESTING) == (flags2 & UNINTERESTING))
 		die(_("Not a range."));
@@ -1864,7 +1864,8 @@ static int add_pending_commit(const char *arg, struct rev_info *revs, int flags)
 {
 	struct object_id oid;
 	if (get_oid(arg, &oid) == 0) {
-		struct commit *commit = lookup_commit_reference(&oid);
+		struct commit *commit = lookup_commit_reference(the_repository,
+								&oid);
 		if (commit) {
 			commit->object.flags |= flags;
 			add_pending_object(revs, &commit->object, arg);
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 3b7600150b6..bbead6f33e5 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -6,6 +6,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "parse-options.h"
+#include "repository.h"
 
 static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
 {
@@ -42,7 +43,7 @@ static struct commit *get_commit_reference(const char *arg)
 
 	if (get_oid(arg, &revkey))
 		die("Not a valid object name %s", arg);
-	r = lookup_commit_reference(&revkey);
+	r = lookup_commit_reference(the_repository, &revkey);
 	if (!r)
 		die("Not a valid commit name %s", arg);
 
@@ -171,7 +172,7 @@ static int handle_fork_point(int argc, const char **argv)
 	if (get_oid(commitname, &oid))
 		die("Not a valid object name: '%s'", commitname);
 
-	derived = lookup_commit_reference(&oid);
+	derived = lookup_commit_reference(the_repository, &oid);
 	memset(&revs, 0, sizeof(revs));
 	revs.initial = 1;
 	for_each_reflog_ent(refname, collect_one_reflog_ent, &revs);
diff --git a/builtin/notes.c b/builtin/notes.c
index a0a18400409..c05cd004abc 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -12,6 +12,7 @@
 #include "builtin.h"
 #include "notes.h"
 #include "object-store.h"
+#include "repository.h"
 #include "blob.h"
 #include "pretty.h"
 #include "refs.h"
@@ -711,7 +712,7 @@ static int merge_commit(struct notes_merge_options *o)
 
 	if (get_oid("NOTES_MERGE_PARTIAL", &oid))
 		die(_("failed to read ref NOTES_MERGE_PARTIAL"));
-	else if (!(partial = lookup_commit_reference(&oid)))
+	else if (!(partial = lookup_commit_reference(the_repository, &oid)))
 		die(_("could not find commit from NOTES_MERGE_PARTIAL."));
 	else if (parse_commit(partial))
 		die(_("could not parse commit from NOTES_MERGE_PARTIAL."));
diff --git a/builtin/pull.c b/builtin/pull.c
index 7197b22b165..4e789353922 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -765,10 +765,13 @@ static int get_octopus_merge_base(struct object_id *merge_base,
 {
 	struct commit_list *revs = NULL, *result;
 
-	commit_list_insert(lookup_commit_reference(curr_head), &revs);
-	commit_list_insert(lookup_commit_reference(merge_head), &revs);
+	commit_list_insert(lookup_commit_reference(the_repository, curr_head),
+			   &revs);
+	commit_list_insert(lookup_commit_reference(the_repository, merge_head),
+			   &revs);
 	if (!is_null_oid(fork_point))
-		commit_list_insert(lookup_commit_reference(fork_point), &revs);
+		commit_list_insert(lookup_commit_reference(the_repository, fork_point),
+				   &revs);
 
 	result = get_octopus_merge_bases(revs);
 	free_commit_list(revs);
@@ -944,9 +947,11 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			struct commit_list *list = NULL;
 			struct commit *merge_head, *head;
 
-			head = lookup_commit_reference(&orig_head);
+			head = lookup_commit_reference(the_repository,
+						       &orig_head);
 			commit_list_insert(head, &list);
-			merge_head = lookup_commit_reference(&merge_heads.oid[0]);
+			merge_head = lookup_commit_reference(the_repository,
+							     &merge_heads.oid[0]);
 			if (is_descendant_of(merge_head, list)) {
 				/* we can fast-forward this without invoking rebase */
 				opt_ff = "--ff-only";
diff --git a/builtin/replace.c b/builtin/replace.c
index deabda21012..0232f98f020 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -371,7 +371,7 @@ static int replace_parents(struct strbuf *buf, int argc, const char **argv)
 			return error(_("Not a valid object name: '%s'"),
 				     argv[i]);
 		}
-		if (!lookup_commit_reference(&oid)) {
+		if (!lookup_commit_reference(the_repository, &oid)) {
 			strbuf_release(&new_parents);
 			return error(_("could not parse %s"), argv[i]);
 		}
@@ -443,7 +443,7 @@ static int create_graft(int argc, const char **argv, int force, int gentle)
 
 	if (get_oid(old_ref, &old_oid) < 0)
 		return error(_("Not a valid object name: '%s'"), old_ref);
-	commit = lookup_commit_reference(&old_oid);
+	commit = lookup_commit_reference(the_repository, &old_oid);
 	if (!commit)
 		return error(_("could not parse %s"), old_ref);
 
diff --git a/builtin/reset.c b/builtin/reset.c
index ffe41c924b4..d9871e5b6c6 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -319,7 +319,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		struct commit *commit;
 		if (get_oid_committish(rev, &oid))
 			die(_("Failed to resolve '%s' as a valid revision."), rev);
-		commit = lookup_commit_reference(&oid);
+		commit = lookup_commit_reference(the_repository, &oid);
 		if (!commit)
 			die(_("Could not parse object '%s'."), rev);
 		oidcpy(&oid, &commit->object.oid);
@@ -396,7 +396,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		update_ref_status = reset_refs(rev, &oid);
 
 		if (reset_type == HARD && !update_ref_status && !quiet)
-			print_new_head_line(lookup_commit_reference(&oid));
+			print_new_head_line(lookup_commit_reference(the_repository, &oid));
 	}
 	if (!pathspec.nr)
 		remove_branch_state();
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 2a6cb298bda..0f09bbbf65a 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -280,8 +280,8 @@ static int try_difference(const char *arg)
 		if (symmetric) {
 			struct commit_list *exclude;
 			struct commit *a, *b;
-			a = lookup_commit_reference(&start_oid);
-			b = lookup_commit_reference(&end_oid);
+			a = lookup_commit_reference(the_repository, &start_oid);
+			b = lookup_commit_reference(the_repository, &end_oid);
 			if (!a || !b) {
 				*dotdot = '.';
 				return 0;
@@ -333,7 +333,7 @@ static int try_parent_shorthands(const char *arg)
 
 	*dotdot = 0;
 	if (get_oid_committish(arg, &oid) ||
-	    !(commit = lookup_commit_reference(&oid))) {
+	    !(commit = lookup_commit_reference(the_repository, &oid))) {
 		*dotdot = '^';
 		return 0;
 	}
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 2456b47d344..4b9d3c0059b 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -831,7 +831,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			       MAX_REVS), MAX_REVS);
 		if (get_oid(ref_name[num_rev], &revkey))
 			die(_("'%s' is not a valid ref."), ref_name[num_rev]);
-		commit = lookup_commit_reference(&revkey);
+		commit = lookup_commit_reference(the_repository, &revkey);
 		if (!commit)
 			die(_("cannot find commit %s (%s)"),
 			    ref_name[num_rev], oid_to_hex(&revkey));
diff --git a/builtin/tag.c b/builtin/tag.c
index 9919b03b2d6..9a19ffb49f6 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -313,7 +313,7 @@ static void create_reflog_msg(const struct object_id *oid, struct strbuf *sb)
 		}
 		free(buf);
 
-		if ((c = lookup_commit_reference(oid)) != NULL)
+		if ((c = lookup_commit_reference(the_repository, oid)) != NULL)
 			strbuf_addf(sb, ", %s", show_date(c->date, 0, DATE_MODE(SHORT)));
 		break;
 	case OBJ_TREE:
diff --git a/bundle.c b/bundle.c
index 0a9f4ee76b2..24cbe409863 100644
--- a/bundle.c
+++ b/bundle.c
@@ -375,7 +375,8 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 			 * in terms of a tag (e.g. v2.0 from the range
 			 * "v1.0..v2.0")?
 			 */
-			struct commit *one = lookup_commit_reference(&oid);
+			struct commit *one = lookup_commit_reference(the_repository,
+								     &oid);
 			struct object *obj;
 
 			if (e->item == &(one->object)) {
diff --git a/commit.c b/commit.c
index 756d557b3c9..5e50a079324 100644
--- a/commit.c
+++ b/commit.c
@@ -35,14 +35,14 @@ struct commit *lookup_commit_reference_gently_the_repository(
 	return object_as_type(the_repository, obj, OBJ_COMMIT, quiet);
 }
 
-struct commit *lookup_commit_reference(const struct object_id *oid)
+struct commit *lookup_commit_reference_the_repository(const struct object_id *oid)
 {
 	return lookup_commit_reference_gently(the_repository, oid, 0);
 }
 
 struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref_name)
 {
-	struct commit *c = lookup_commit_reference(oid);
+	struct commit *c = lookup_commit_reference(the_repository, oid);
 	if (!c)
 		die(_("could not parse %s"), ref_name);
 	if (oidcmp(oid, &c->object.oid)) {
@@ -68,7 +68,7 @@ struct commit *lookup_commit_reference_by_name(const char *name)
 
 	if (get_oid_committish(name, &oid))
 		return NULL;
-	commit = lookup_commit_reference(&oid);
+	commit = lookup_commit_reference(the_repository, &oid);
 	if (parse_commit(commit))
 		return NULL;
 	return commit;
diff --git a/commit.h b/commit.h
index 000d194f8aa..2a411134457 100644
--- a/commit.h
+++ b/commit.h
@@ -64,7 +64,9 @@ void add_name_decoration(enum decoration_type type, const char *name, struct obj
 const struct name_decoration *get_name_decoration(const struct object *obj);
 
 struct commit *lookup_commit(const struct object_id *oid);
-struct commit *lookup_commit_reference(const struct object_id *oid);
+#define lookup_commit_reference(r, o) \
+		lookup_commit_reference_##r(o)
+struct commit *lookup_commit_reference_the_repository(const struct object_id *oid);
 #define lookup_commit_reference_gently(r, o, q) \
 		lookup_commit_reference_gently_##r(o, q)
 struct commit *lookup_commit_reference_gently_the_repository(
diff --git a/merge-recursive.c b/merge-recursive.c
index 666a3bc22fb..fa1981be972 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1192,9 +1192,9 @@ static int merge_submodule(struct merge_options *o,
 		return 0;
 	}
 
-	if (!(commit_base = lookup_commit_reference(base)) ||
-	    !(commit_a = lookup_commit_reference(a)) ||
-	    !(commit_b = lookup_commit_reference(b))) {
+	if (!(commit_base = lookup_commit_reference(the_repository, base)) ||
+	    !(commit_a = lookup_commit_reference(the_repository, a)) ||
+	    !(commit_b = lookup_commit_reference(the_repository, b))) {
 		output(o, 1, _("Failed to merge submodule %s (commits not present)"), path);
 		return 0;
 	}
diff --git a/notes-merge.c b/notes-merge.c
index 9cc2ee16a8c..76ab19e7024 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -2,6 +2,7 @@
 #include "commit.h"
 #include "refs.h"
 #include "object-store.h"
+#include "repository.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "xdiff-interface.h"
@@ -553,7 +554,7 @@ int notes_merge(struct notes_merge_options *o,
 	else if (!check_refname_format(o->local_ref, 0) &&
 		is_null_oid(&local_oid))
 		local = NULL; /* local_oid == null_oid indicates unborn ref */
-	else if (!(local = lookup_commit_reference(&local_oid)))
+	else if (!(local = lookup_commit_reference(the_repository, &local_oid)))
 		die("Could not parse local commit %s (%s)",
 		    oid_to_hex(&local_oid), o->local_ref);
 	trace_printf("\tlocal commit: %.7s\n", oid_to_hex(&local_oid));
@@ -571,7 +572,7 @@ int notes_merge(struct notes_merge_options *o,
 			die("Failed to resolve remote notes ref '%s'",
 			    o->remote_ref);
 		}
-	} else if (!(remote = lookup_commit_reference(&remote_oid))) {
+	} else if (!(remote = lookup_commit_reference(the_repository, &remote_oid))) {
 		die("Could not parse remote commit %s (%s)",
 		    oid_to_hex(&remote_oid), o->remote_ref);
 	}
diff --git a/parse-options-cb.c b/parse-options-cb.c
index 0f9f311a7a9..e8236534ac8 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -91,7 +91,7 @@ int parse_opt_commits(const struct option *opt, const char *arg, int unset)
 		return -1;
 	if (get_oid(arg, &oid))
 		return error("malformed object name %s", arg);
-	commit = lookup_commit_reference(&oid);
+	commit = lookup_commit_reference(the_repository, &oid);
 	if (!commit)
 		return error("no such commit %s", arg);
 	commit_list_insert(commit, opt->value);
diff --git a/remote.c b/remote.c
index 0f1a84d67a3..8c75c45fe65 100644
--- a/remote.c
+++ b/remote.c
@@ -1865,13 +1865,13 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	/* Cannot stat if what we used to build on no longer exists */
 	if (read_ref(base, &oid))
 		return -1;
-	theirs = lookup_commit_reference(&oid);
+	theirs = lookup_commit_reference(the_repository, &oid);
 	if (!theirs)
 		return -1;
 
 	if (read_ref(branch->refname, &oid))
 		return -1;
-	ours = lookup_commit_reference(&oid);
+	ours = lookup_commit_reference(the_repository, &oid);
 	if (!ours)
 		return -1;
 
diff --git a/revision.c b/revision.c
index 02e1296e36d..4dbe406bed2 100644
--- a/revision.c
+++ b/revision.c
@@ -1591,8 +1591,8 @@ static int handle_dotdot_1(const char *arg, char *dotdot,
 		struct commit *a, *b;
 		struct commit_list *exclude;
 
-		a = lookup_commit_reference(&a_obj->oid);
-		b = lookup_commit_reference(&b_obj->oid);
+		a = lookup_commit_reference(the_repository, &a_obj->oid);
+		b = lookup_commit_reference(the_repository, &b_obj->oid);
 		if (!a || !b)
 			return dotdot_missing(arg, dotdot, revs, symmetric);
 
diff --git a/sequencer.c b/sequencer.c
index b4170b748cc..cc7b19199e8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1176,7 +1176,7 @@ static int parse_head(struct commit **head)
 	if (get_oid("HEAD", &oid)) {
 		current_head = NULL;
 	} else {
-		current_head = lookup_commit_reference(&oid);
+		current_head = lookup_commit_reference(the_repository, &oid);
 		if (!current_head)
 			return error(_("could not parse HEAD"));
 		if (oidcmp(&oid, &current_head->object.oid)) {
@@ -1511,7 +1511,7 @@ static int update_squash_messages(enum todo_command command,
 
 		if (get_oid("HEAD", &head))
 			return error(_("need a HEAD to fixup"));
-		if (!(head_commit = lookup_commit_reference(&head)))
+		if (!(head_commit = lookup_commit_reference(the_repository, &head)))
 			return error(_("could not read HEAD"));
 		if (!(head_message = get_commit_buffer(head_commit, NULL)))
 			return error(_("could not read HEAD's commit message"));
@@ -2009,7 +2009,7 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 	if (status < 0)
 		return -1;
 
-	item->commit = lookup_commit_reference(&commit_oid);
+	item->commit = lookup_commit_reference(the_repository, &commit_oid);
 	return !item->commit;
 }
 
diff --git a/sha1-name.c b/sha1-name.c
index 473611879bf..325915fb276 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -844,7 +844,7 @@ static int get_parent(const char *name, int len,
 
 	if (ret)
 		return ret;
-	commit = lookup_commit_reference(&oid);
+	commit = lookup_commit_reference(the_repository, &oid);
 	if (parse_commit(commit))
 		return -1;
 	if (!idx) {
@@ -872,7 +872,7 @@ static int get_nth_ancestor(const char *name, int len,
 	ret = get_oid_1(name, len, &oid, GET_OID_COMMITTISH);
 	if (ret)
 		return ret;
-	commit = lookup_commit_reference(&oid);
+	commit = lookup_commit_reference(the_repository, &oid);
 	if (!commit)
 		return -1;
 
diff --git a/submodule.c b/submodule.c
index 0998ea23458..6688dd5d459 100644
--- a/submodule.c
+++ b/submodule.c
@@ -517,8 +517,8 @@ static void show_submodule_header(struct diff_options *o, const char *path,
 	 * Attempt to lookup the commit references, and determine if this is
 	 * a fast forward or fast backwards update.
 	 */
-	*left = lookup_commit_reference(one);
-	*right = lookup_commit_reference(two);
+	*left = lookup_commit_reference(the_repository, one);
+	*right = lookup_commit_reference(the_repository, two);
 
 	/*
 	 * Warn about missing commits in the submodule project, but only if
-- 
2.18.0.399.gad0ab374a1-goog


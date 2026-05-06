Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6783B3BED
	for <git@vger.kernel.org>; Wed,  6 May 2026 22:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778107417; cv=none; b=guvyBDMBL512QHJv3TvGjR5ePVp7Q1c5db7j96N/rUvKEI+OhQatybo6lUNtarRLirXdOb+EwsM3JMXU8HFMlAvVryFNIZ9X/yb6V2ngZwj1pQcb8Gw0sjcuLnnpNQM07902v5pKZ+axTahRcT+zIcUCdDjd/l43oFgUwBbt2Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778107417; c=relaxed/simple;
	bh=reTaaSWEE36cawxsNtkdoMQDgMHieVCatq+NuIeUHIE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nMFpS7h8+Vqv6V/Os2qxqeXByiVgEQeZVto04CFPcfw5+T1MqoHjhtHZhJJ7XNyV34jgjPszZKeKU7G96Ho3lO9/GCBcHqNLY7OrQG70LmTeEmaLnNRUXsUd8znmP6ZHbw2mw6ZYHgkSrp0xetm87rrSfp8RdBT7npNBFQE0hPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwIe5bhQ; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwIe5bhQ"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-130b2295ed0so816016c88.0
        for <git@vger.kernel.org>; Wed, 06 May 2026 15:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778107408; x=1778712208; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUxkxz6mVK2YdSu8R6STxTdes3TUqxyRnyGBh14tQcE=;
        b=gwIe5bhQvoFH4RvBmxi2bDy16cJLlrshaey1MAKS6OA6Grhpi1q6bRC+HsdEX5yCyr
         dEAHEq+g8YR4FIL0nfHA6qqoQBrp+NvV9cILpMbzIAcIJwMF8NXbcbMCb1JNclRzHoC+
         3M4ZQNNrnIDy7wbiMeWQaodFKu9qz0FTwnQkZWFeTev1tuiKJ+gxffRlmT9r7jsjtFLT
         REGIjXzROGnRT0bnzAGCCmjrJwwaHnUgsDxNIMdQpS6kc4l4LHpYzy5wYycpBccOItx2
         aI83yWFTcfQly7KRsWtlGq9URScrm3wdZW4gzK2GaT8KGxDUbPSBwU2yTbuFJOWVQ+Hf
         0JKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778107408; x=1778712208;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cUxkxz6mVK2YdSu8R6STxTdes3TUqxyRnyGBh14tQcE=;
        b=Q0qL7vLy5kfeMnitVKrxsrEYCSqAI8cz3UqQha7FSkFRumQH71n73KLYgpMtI1dOsJ
         yv3fDy3M4NwO+Bx2rtKQp2KQlijnAObTZzUCzX19uac3brEVBWfSvxdxUM4Xm88+klf8
         /tdJcauhhnmjjoR1DyhAFpEu3K239ePc8aozwpekSraZgnGgsizc+EvnTvqexXT7hcdR
         ALNeH8eLBPw+usSiky3Se2yJ2vF0n0pkDKf2klN5A10w0+bp7wSZ8QFlebzZNhFEiqNt
         dnzmxzpD8u7mD5NuNdyVXuI1rDnnb067eawELIaeEHCJiqf2Ovnv5whH+3PxSGUwa1jQ
         RR7Q==
X-Gm-Message-State: AOJu0YxpOzE4JoI7nCTIf7Vbg5iLBaR5va4wve2/ZDhrtysKJCu940LI
	jHWdQBlKRDJfTDiCjSEhD8Q8EPTwa6fklNlsNPXSd4QVzQHjSUB/mTfoHMIRRg==
X-Gm-Gg: AeBDiet4Nmm6f/N1Yb4tvlF/nwnIyCIdirnlq2nuJ3nQIpknExofFbxbT/IuBa30noQ
	SRtytMHTTRrABNqA+5kBzDaY0wVpXs6kZpgT1cT6H6M+wrgGQVOiyaPHrK36IHMjqlpJ8dDnN+M
	bChKBqX6Rk9snQRpoA3yIrkG0yaXD/oq+houueGLxL3eFXWDpJbfBu0rFqQVZM//216h8ASb3sl
	leAzRFQ23EmEYw5Tv9kfYzr40838++B449cr2FRfRARa7qdksZyPCUZPUc4KpI2hX8ImUi9b8QE
	J454Brmhso1kCcFNFz6v0aFSxbJZFZGGioQFheT64MvVeeNobddgxg/T7FmTw42nJnxnc4tIOxM
	iT8XmcoABmfelCAHh2VRJ5AmQ31mVpBsSNqhPlt5502WaX3hdLx3My1Je4FmI9/jclQc00mP/+2
	OFfoz3R4rk516pDXZwA2H+JkCffDR9I/4ZxkDuQg==
X-Received: by 2002:a05:7022:1e10:b0:12b:fc21:874d with SMTP id a92af1059eb24-131880edbfemr2970173c88.19.1778107408005;
        Wed, 06 May 2026 15:43:28 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.225.84])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-131f9789e3dsm5741721c88.8.2026.05.06.15.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 15:43:27 -0700 (PDT)
Message-Id: <034ab0f83822e6db67baa423d9fcb753b12b5ac8.1778107405.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2106.git.1778107405.gitgitgadget@gmail.com>
References: <pull.2106.git.1778107405.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 06 May 2026 22:43:20 +0000
Subject: [PATCH/RFC 1/5] replay: support replaying 2-parent merges
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
Cc: Elijah Newren <newren@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

`git history` (introduced in v2.54) and the underlying `git replay`
infrastructure both refused to walk past any commit with more than
one parent, dying with "replaying merge commits is not supported
yet!". For real history-rewriting work this is a showstopper: the
natural fallback `git rebase --rebase-merges` is interactive and
stops to ask for re-resolution even when no re-resolution is needed.

Elijah Newren spelled out a way to lift this limitation in his
replay-design-notes [1] and prototyped it in a 2022
work-in-progress sketch [2]. The idea is that a merge commit M on
parents (P1, P2) records both an automatic merge of those parents
AND any manual layer the author put on top of that automatic merge
(textual conflict resolution and any semantic edit outside conflict
markers). Replaying M onto rewritten parents (P1', P2') must
preserve that manual layer, but the rewritten parents change the
automatic merge, so a simple cherry-pick is wrong: the manual layer
would be re-introduced on top of stale auto-merge text.

What works instead is a three-way merge of three trees the existing
infrastructure already knows how to compute. Let R be the recursive
auto-merge of (P1, P2), O be M's actual tree and N be the recursive
auto-merge of (P1', P2'). Then `git diff R O` is morally
`git show --remerge-diff M`: it captures exactly what the author
added on top of the automatic merge. A non-recursive 3-way merge
with R as the merge base, O as side 1 and N as side 2 layers that
manual contribution onto the freshly auto-merged rewritten parents
(N) and produces the replayed tree.

Implement `pick_merge_commit()` along those lines and dispatch to it
from `replay_revisions()` when the commit being replayed has exactly
two parents. Two specific points (learned the hard way) keep
non-trivial cases working where the WIP sketch [2] bailed out.
First, R and N use identical `merge_options.branch1` and `branch2`
labels ("ours"/"theirs"). When the original parents conflicted on a
region of a file, both R and N produce textually identical conflict
markers; the outer non-recursive merge then sees N == R in that
region and the user's manual resolution from O wins cleanly. Without
this, the conflict-marker text would differ between R and N (because
the inner merges would label the conflicts differently), and the
outer merge would itself be unclean even when the user did supply a
clean resolution. Second, an unclean inner merge
(`result.clean == 0`) is _not_ fatal: the tree merge-ort produces in
that case still has well-defined contents (with conflict markers in
the conflicted files) and is a valid input to the outer
non-recursive merge. Only a real error (`< 0`) propagates as
failure.

The replay propagates the textual diffs the user actually made in M;
it does _not_ extrapolate symbol-level intent. If rewriting the
parents pulls in genuinely new content (for example, a brand-new
caller of a function that the merge renamed), that new content stays
as the rewritten parents have it. Symbol-aware refactoring is out of
scope here, just as it is for plain rebase.

Octopus merges (more than two parents) and revert-of-merge are not
supported and are surfaced as explicit errors at the dispatch point.
The "split" sub-command of `git history` continues to refuse when
the targeted commit is itself a merge: split semantics do not apply
to merges. The pre-walk gate in `builtin/history.c` that previously
rejected any merge in the rewrite path now only rejects octopus
merges; rename it accordingly.

A small refactor in `create_commit()` makes the merge case possible:
the helper now takes a `struct commit_list *parents` rather than a
single parent pointer and takes ownership of the list. The single
existing caller in `pick_regular_commit()` builds and passes a
one-element list; the new `pick_merge_commit()` builds a two-element
list, with the order of the `from` and `merge` parents preserved.

Update the negative expectations in t3451, t3452 and t3650 that were
asserting the now-retired "not supported yet" message, replacing
them with positive coverage where it fits. Octopus rejection and
revert-of-merge rejection are covered by new positive tests in
t3650. A dedicated test script with merge-replay scenarios driven by
a new test-tool fixture builder will follow in a subsequent commit.

[1] https://github.com/newren/git/blob/replay/replay-design-notes.txt
[2] https://github.com/newren/git/commit/4c45e8955ef9bf7d01fd15d9106b3bdb8ea91b45

Helped-by: Elijah Newren <newren@gmail.com>
Assisted-by: Claude Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/history.c         |  16 ++-
 replay.c                  | 209 ++++++++++++++++++++++++++++++++++++--
 t/t3451-history-reword.sh |  21 ++--
 t/t3452-history-split.sh  |   6 +-
 t/t3650-replay-basics.sh  |  46 ++++++++-
 5 files changed, 269 insertions(+), 29 deletions(-)

diff --git a/builtin/history.c b/builtin/history.c
index 9526938085..00097b2226 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -195,15 +195,15 @@ static int parse_ref_action(const struct option *opt, const char *value, int uns
 	return 0;
 }
 
-static int revwalk_contains_merges(struct repository *repo,
-				   const struct strvec *revwalk_args)
+static int revwalk_contains_octopus_merges(struct repository *repo,
+					   const struct strvec *revwalk_args)
 {
 	struct strvec args = STRVEC_INIT;
 	struct rev_info revs;
 	int ret;
 
 	strvec_pushv(&args, revwalk_args->v);
-	strvec_push(&args, "--min-parents=2");
+	strvec_push(&args, "--min-parents=3");
 
 	repo_init_revisions(repo, &revs, NULL);
 
@@ -217,7 +217,7 @@ static int revwalk_contains_merges(struct repository *repo,
 	}
 
 	if (get_revision(&revs)) {
-		ret = error(_("replaying merge commits is not supported yet!"));
+		ret = error(_("replaying octopus merges is not supported"));
 		goto out;
 	}
 
@@ -289,7 +289,7 @@ static int setup_revwalk(struct repository *repo,
 		strvec_push(&args, "HEAD");
 	}
 
-	ret = revwalk_contains_merges(repo, &args);
+	ret = revwalk_contains_octopus_merges(repo, &args);
 	if (ret < 0)
 		goto out;
 
@@ -482,6 +482,9 @@ static int cmd_history_reword(int argc,
 	if (ret < 0) {
 		ret = error(_("failed replaying descendants"));
 		goto out;
+	} else if (ret) {
+		ret = error(_("conflict during replay; some descendants were not rewritten"));
+		goto out;
 	}
 
 	ret = 0;
@@ -721,6 +724,9 @@ static int cmd_history_split(int argc,
 	if (ret < 0) {
 		ret = error(_("failed replaying descendants"));
 		goto out;
+	} else if (ret) {
+		ret = error(_("conflict during replay; some descendants were not rewritten"));
+		goto out;
 	}
 
 	ret = 0;
diff --git a/replay.c b/replay.c
index f96f1f6551..3dbce095f9 100644
--- a/replay.c
+++ b/replay.c
@@ -1,6 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
+#include "commit-reach.h"
 #include "environment.h"
 #include "hex.h"
 #include "merge-ort.h"
@@ -77,15 +78,21 @@ static void generate_revert_message(struct strbuf *msg,
 	repo_unuse_commit_buffer(repo, commit, message);
 }
 
+/*
+ * Build a new commit with the given tree and parent list, copying author,
+ * extra headers and (for pick mode) the commit message from `based_on`.
+ *
+ * Takes ownership of `parents`: it will be freed before returning, even on
+ * error. Parent order is preserved as supplied by the caller.
+ */
 static struct commit *create_commit(struct repository *repo,
 				    struct tree *tree,
 				    struct commit *based_on,
-				    struct commit *parent,
+				    struct commit_list *parents,
 				    enum replay_mode mode)
 {
 	struct object_id ret;
 	struct object *obj = NULL;
-	struct commit_list *parents = NULL;
 	char *author = NULL;
 	char *sign_commit = NULL; /* FIXME: cli users might want to sign again */
 	struct commit_extra_header *extra = NULL;
@@ -96,7 +103,6 @@ static struct commit *create_commit(struct repository *repo,
 	const char *orig_message = NULL;
 	const char *exclude_gpgsig[] = { "gpgsig", "gpgsig-sha256", NULL };
 
-	commit_list_insert(parent, &parents);
 	extra = read_commit_extra_headers(based_on, exclude_gpgsig);
 	if (mode == REPLAY_MODE_REVERT) {
 		generate_revert_message(&msg, based_on, repo);
@@ -273,6 +279,7 @@ static struct commit *pick_regular_commit(struct repository *repo,
 {
 	struct commit *base, *replayed_base;
 	struct tree *pickme_tree, *base_tree, *replayed_base_tree;
+	struct commit_list *parents = NULL;
 
 	if (pickme->parents) {
 		base = pickme->parents->item;
@@ -327,7 +334,143 @@ static struct commit *pick_regular_commit(struct repository *repo,
 	if (oideq(&replayed_base_tree->object.oid, &result->tree->object.oid) &&
 	    !oideq(&pickme_tree->object.oid, &base_tree->object.oid))
 		return replayed_base;
-	return create_commit(repo, result->tree, pickme, replayed_base, mode);
+	commit_list_insert(replayed_base, &parents);
+	return create_commit(repo, result->tree, pickme, parents, mode);
+}
+
+/*
+ * Replay a 2-parent merge commit by composing three calls into merge-ort:
+ *
+ *   R = recursive merge of pickme's two original parents (auto-remerge of
+ *       the original merge, accepting any conflicts)
+ *   N = recursive merge of the (possibly rewritten) parents
+ *   O = pickme's tree (the user's actual merge, including any manual
+ *       resolutions)
+ *
+ * The picked tree comes from a non-recursive merge using R as the base,
+ * O as side1 and N as side2. `git diff R O` is morally `git show
+ * --remerge-diff $oldmerge`, so this layers the user's original manual
+ * resolution on top of the freshly auto-merged rewritten parents (see
+ * `replay-design-notes.txt` on the `replay` branch of newren/git).
+ *
+ * If the outer 3-way merge is unclean, propagate the conflict status to
+ * the caller via `result->clean = 0` and return NULL. The two inner
+ * merges (R and N) being unclean is _not_ fatal: the conflict-markered
+ * trees they produce are valid inputs to the outer merge, and using
+ * identical labels for both inner merges keeps the marker text
+ * byte-equal between R and N so the user's resolution recorded in O
+ * collapses the conflict cleanly there. Octopus merges (more than two
+ * parents) and revert-of-merge are rejected by the caller before this
+ * function is invoked.
+ */
+static struct commit *pick_merge_commit(struct repository *repo,
+					struct commit *pickme,
+					kh_oid_map_t *replayed_commits,
+					struct merge_options *merge_opt,
+					struct merge_result *result)
+{
+	struct commit *parent1, *parent2;
+	struct commit *replayed_par1, *replayed_par2;
+	struct tree *pickme_tree;
+	struct merge_options remerge_opt = { 0 };
+	struct merge_options new_merge_opt = { 0 };
+	struct merge_result remerge_res = { 0 };
+	struct merge_result new_merge_res = { 0 };
+	struct commit_list *parent_bases = NULL;
+	struct commit_list *replayed_bases = NULL;
+	struct commit_list *parents;
+	struct commit *picked = NULL;
+	char *ancestor_name = NULL;
+
+	parent1 = pickme->parents->item;
+	parent2 = pickme->parents->next->item;
+
+	/*
+	 * Map the merge's parents to their replayed counterparts. With the
+	 * boundary commits pre-seeded into `replayed_commits`, every parent
+	 * either has an explicit mapping (rewritten or boundary -> onto) or
+	 * sits outside the rewrite range entirely; the latter must stay at
+	 * the original parent commit, so use `parent` itself as the fallback
+	 * for both sides.
+	 */
+	replayed_par1 = mapped_commit(replayed_commits, parent1, parent1);
+	replayed_par2 = mapped_commit(replayed_commits, parent2, parent2);
+
+	/*
+	 * R: auto-remerge of the original parents.
+	 *
+	 * Use the same branch labels for the inner merges that compute R
+	 * and N so conflict markers (if any) are textually identical
+	 * between the two; the outer non-recursive merge can then collapse
+	 * the manual resolution from O against them.
+	 */
+	init_basic_merge_options(&remerge_opt, repo);
+	remerge_opt.show_rename_progress = 0;
+	remerge_opt.branch1 = "ours";
+	remerge_opt.branch2 = "theirs";
+	if (repo_get_merge_bases(repo, parent1, parent2, &parent_bases) < 0) {
+		result->clean = -1;
+		goto out;
+	}
+	merge_incore_recursive(&remerge_opt, parent_bases,
+			       parent1, parent2, &remerge_res);
+	parent_bases = NULL; /* consumed by merge_incore_recursive */
+	if (remerge_res.clean < 0) {
+		result->clean = remerge_res.clean;
+		goto out;
+	}
+
+	/* N: fresh merge of the (possibly rewritten) parents. */
+	init_basic_merge_options(&new_merge_opt, repo);
+	new_merge_opt.show_rename_progress = 0;
+	new_merge_opt.branch1 = "ours";
+	new_merge_opt.branch2 = "theirs";
+	if (repo_get_merge_bases(repo, replayed_par1, replayed_par2,
+				 &replayed_bases) < 0) {
+		result->clean = -1;
+		goto out;
+	}
+	merge_incore_recursive(&new_merge_opt, replayed_bases,
+			       replayed_par1, replayed_par2, &new_merge_res);
+	replayed_bases = NULL; /* consumed by merge_incore_recursive */
+	if (new_merge_res.clean < 0) {
+		result->clean = new_merge_res.clean;
+		goto out;
+	}
+
+	/*
+	 * Outer non-recursive merge: base=R, side1=O (pickme), side2=N.
+	 */
+	pickme_tree = repo_get_commit_tree(repo, pickme);
+	ancestor_name = xstrfmt("auto-remerge of %s",
+				oid_to_hex(&pickme->object.oid));
+	merge_opt->ancestor = ancestor_name;
+	merge_opt->branch1 = short_commit_name(repo, pickme);
+	merge_opt->branch2 = "merge of replayed parents";
+	merge_incore_nonrecursive(merge_opt,
+				  remerge_res.tree,
+				  pickme_tree,
+				  new_merge_res.tree,
+				  result);
+	merge_opt->ancestor = NULL;
+	merge_opt->branch1 = NULL;
+	merge_opt->branch2 = NULL;
+	if (!result->clean)
+		goto out;
+
+	parents = NULL;
+	commit_list_insert(replayed_par2, &parents);
+	commit_list_insert(replayed_par1, &parents);
+	picked = create_commit(repo, result->tree, pickme, parents,
+			       REPLAY_MODE_PICK);
+
+out:
+	free(ancestor_name);
+	free_commit_list(parent_bases);
+	free_commit_list(replayed_bases);
+	merge_finalize(&remerge_opt, &remerge_res);
+	merge_finalize(&new_merge_opt, &new_merge_res);
+	return picked;
 }
 
 void replay_result_release(struct replay_result *result)
@@ -407,17 +550,63 @@ int replay_revisions(struct rev_info *revs,
 	merge_opt.show_rename_progress = 0;
 	last_commit = onto;
 	replayed_commits = kh_init_oid_map();
+
+	/*
+	 * Seed the rewritten-commit map with each negative-side ("BOTTOM")
+	 * cmdline entry pointing at `onto`. This matters for merge replay:
+	 * a 2-parent merge whose first parent is the boundary (e.g. the
+	 * commit being reworded) must replay onto the rewritten boundary,
+	 * yet pick_merge_commit uses a self fallback so the second parent
+	 * (a side branch outside the rewrite range) is preserved as-is.
+	 * Pre-seeding the boundary disambiguates the two: in the map ->
+	 * rewritten, missing -> kept as-is.
+	 *
+	 * Only do this for the pick path; revert mode chains reverts
+	 * through last_commit and a pre-seeded boundary would short-circuit
+	 * that chain.
+	 */
+	if (mode == REPLAY_MODE_PICK) {
+		for (size_t i = 0; i < revs->cmdline.nr; i++) {
+			struct rev_cmdline_entry *e = &revs->cmdline.rev[i];
+			struct commit *boundary;
+			khint_t pos;
+			int hr;
+
+			if (!(e->flags & BOTTOM))
+				continue;
+			boundary = lookup_commit_reference_gently(revs->repo,
+								  &e->item->oid, 1);
+			if (!boundary)
+				continue;
+			pos = kh_put_oid_map(replayed_commits,
+					     boundary->object.oid, &hr);
+			if (hr != 0)
+				kh_value(replayed_commits, pos) = onto;
+		}
+	}
+
 	while ((commit = get_revision(revs))) {
 		const struct name_decoration *decoration;
 		khint_t pos;
 		int hr;
 
-		if (commit->parents && commit->parents->next)
-			die(_("replaying merge commits is not supported yet!"));
-
-		last_commit = pick_regular_commit(revs->repo, commit, replayed_commits,
-						  mode == REPLAY_MODE_REVERT ? last_commit : onto,
-						  &merge_opt, &result, mode);
+		if (commit->parents && commit->parents->next) {
+			if (commit->parents->next->next) {
+				ret = error(_("replaying octopus merges is not supported"));
+				goto out;
+			}
+			if (mode == REPLAY_MODE_REVERT) {
+				ret = error(_("reverting merge commits is not supported"));
+				goto out;
+			}
+			last_commit = pick_merge_commit(revs->repo, commit,
+							replayed_commits,
+							&merge_opt, &result);
+		} else {
+			last_commit = pick_regular_commit(revs->repo, commit, replayed_commits,
+							  mode == REPLAY_MODE_REVERT ? last_commit : onto,
+							  &merge_opt, &result, mode);
+		}
 		if (!last_commit)
 			break;
 
diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
index de7b357685..d103f866a2 100755
--- a/t/t3451-history-reword.sh
+++ b/t/t3451-history-reword.sh
@@ -201,12 +201,21 @@ test_expect_success 'can reword a merge commit' '
 		git switch - &&
 		git merge theirs &&
 
-		# It is not possible to replay merge commits embedded in the
-		# history (yet).
-		test_must_fail git -c core.editor=false history reword HEAD~ 2>err &&
-		test_grep "replaying merge commits is not supported yet" err &&
+		# Reword a non-merge commit whose descendants include the
+		# merge: replay carries the merge through.
+		reword_with_message HEAD~ <<-EOF &&
+		ours reworded
+		EOF
+		expect_graph <<-EOF &&
+		*   Merge tag ${SQ}theirs${SQ}
+		|\\
+		| * theirs
+		* | ours reworded
+		|/
+		* base
+		EOF
 
-		# But it is possible to reword a merge commit directly.
+		# And reword a merge commit directly.
 		reword_with_message HEAD <<-EOF &&
 		Reworded merge commit
 		EOF
@@ -214,7 +223,7 @@ test_expect_success 'can reword a merge commit' '
 		*   Reworded merge commit
 		|\
 		| * theirs
-		* | ours
+		* | ours reworded
 		|/
 		* base
 		EOF
diff --git a/t/t3452-history-split.sh b/t/t3452-history-split.sh
index 8ed0cebb50..ad6309f98b 100755
--- a/t/t3452-history-split.sh
+++ b/t/t3452-history-split.sh
@@ -36,7 +36,7 @@ expect_tree_entries () {
 	test_cmp expect actual
 }
 
-test_expect_success 'refuses to work with merge commits' '
+test_expect_success 'refuses to split a merge commit' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -49,9 +49,7 @@ test_expect_success 'refuses to work with merge commits' '
 		git switch - &&
 		git merge theirs &&
 		test_must_fail git history split HEAD 2>err &&
-		test_grep "cannot split up merge commit" err &&
-		test_must_fail git history split HEAD~ 2>err &&
-		test_grep "replaying merge commits is not supported yet" err
+		test_grep "cannot split up merge commit" err
 	)
 '
 
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index 3353bc4a4d..368b1b0f9a 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -103,10 +103,48 @@ test_expect_success 'cannot advance target ... ordering would be ill-defined' '
 	test_cmp expect actual
 '
 
-test_expect_success 'replaying merge commits is not supported yet' '
-	echo "fatal: replaying merge commits is not supported yet!" >expect &&
-	test_must_fail git replay --advance=main main..topic-with-merge 2>actual &&
-	test_cmp expect actual
+test_expect_success 'using replay to rebase a 2-parent merge' '
+	# main..topic-with-merge contains a 2-parent merge (P) introduced
+	# via test_merge. Use --ref-action=print so this test does not
+	# mutate state for subsequent tests in this file.
+	git replay --ref-action=print --onto main main..topic-with-merge >result &&
+	test_line_count = 1 result &&
+
+	new_tip=$(cut -f 3 -d " " result) &&
+
+	# Result is still a 2-parent merge.
+	git cat-file -p $new_tip >cat &&
+	grep -c "^parent " cat >count &&
+	echo 2 >expect &&
+	test_cmp expect count &&
+
+	# Merge subject is preserved.
+	echo P >expect &&
+	git log -1 --format=%s $new_tip >actual &&
+	test_cmp expect actual &&
+
+	# The replayed merge sits on top of main: walking back via the
+	# first-parent chain reaches main.
+	git merge-base --is-ancestor main $new_tip
+'
+
+test_expect_success 'replaying an octopus merge is rejected' '
+	# Build an octopus side-branch so the rest of the test state stays
+	# untouched.
+	test_when_finished "git update-ref -d refs/heads/octopus-tip" &&
+	octopus_tip=$(git commit-tree -p topic4 -p topic1 -p topic3 \
+		-m "octopus" $(git rev-parse topic4^{tree})) &&
+	git update-ref refs/heads/octopus-tip "$octopus_tip" &&
+
+	test_must_fail git replay --ref-action=print --onto main \
+		topic4..octopus-tip 2>actual &&
+	test_grep "octopus merges" actual
+'
+
+test_expect_success 'reverting a merge commit is rejected' '
+	test_must_fail git replay --ref-action=print --revert=topic-with-merge \
+		topic4..topic-with-merge 2>actual &&
+	test_grep "reverting merge commits" actual
 '
 
 test_expect_success 'using replay to rebase two branches, one on top of other' '
-- 
gitgitgadget


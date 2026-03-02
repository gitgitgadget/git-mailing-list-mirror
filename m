Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4F1366572
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 12:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772453615; cv=none; b=azNIH28vVWHqK52rjvBbDl1UGs6vrSOjmzReEQoq2W1xCmFNuyyHQB2HZbm1GNaR+Csw7fwWfJryPXYkWgj+t+xK4o4nS9JdFie6gI9is5JIAc+t6JbP3jFvKuwGqENCOg5yOBtdSxMq2rUtWVzjHXmfeXAplupLJF3zmq/jWxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772453615; c=relaxed/simple;
	bh=jXcUn2owxZeNfECsPjUBPRo0fnjLy4xU3h01FiaG9Bc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JLomMLGl2qZzg6V/7Y/Lg0tWED9cQ0fvMUG8zBS4tskK0bdbTCMvV7o2t5dZT7mLV7P5OVJa+C8APQ4/xjwrd629fhD84FbUmEaH5TcGY5Jq0EiddqYkai1ampACmtZ6qi/a4VZLXUmkIhqJj6NEFHyP3V8cuod373FtSqTxb1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OkkO+XY4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wjJn+OPT; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OkkO+XY4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wjJn+OPT"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 255967A015B;
	Mon,  2 Mar 2026 07:13:33 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 02 Mar 2026 07:13:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772453612;
	 x=1772540012; bh=+2guefNkfSamf5eG2aaWl11ZuZ1JaiTDMmzJzSAdECw=; b=
	OkkO+XY4RaRInGrMwZONxq1RT3AeB1aBTZEwO4y6yRcgBBuG1BHw0Zkgw3fXx6/D
	zG1VVPqtUKaVHT5fhu/i9B1yjWCMpY8rh7E9PXxmn39rwmFCsXk6hJqOP6XnV6Eu
	LTvgsTtdxT6qOHuaAVR/Q4lEI0EjkkxeDxHO8H0+/HXoCCqK4JJPrrBydWaO5wwm
	gYsn9HhUje3IecJlDXa5EU53kw50IN1N0umIiTNmaftJJLP4rC/XHds1Oz3vLq6a
	Mr6WsrhWVTRpns5wRsGfuO7rSUwhZ3ahEuwGaPRmB9HdKai1fvDo7TJRAb6vAUI9
	y0dPCYOVMDl3+pbgGBnVig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772453612; x=
	1772540012; bh=+2guefNkfSamf5eG2aaWl11ZuZ1JaiTDMmzJzSAdECw=; b=w
	jJn+OPT2Cx3+RJRQkOFS+NvhpkCRviyjLaVEQCwFVU7BsZV1yJF5bgJNocQhBp0k
	/hysbS1sJluREUItwGE50onBce+km/gbuxDMPnqGFo1eCFmzUJVhI1AoyNUGvl9F
	KitHz8fW87NFhB1hu7BMK4xMsUvSgt+r4eqa1YGKHeJEgbP3JTLrkQd7uuyEDx5g
	222tU3gyfPHr9HQqBu/GfFT+X+mDUlNNaCBqlm7tTsgUn1wkxPwtGh1FCg598tP6
	zfNZiHPnuHLXqj1O5UC56As5kFA2j/fvhTVz4jGPQqYGemN6HPJRC4CSSkJfAaOT
	WdRidf2EY45Krq09ydv+w==
X-ME-Sender: <xms:7H6laemJQ1jsgvyRYM0aqaZHNCPUL9hStZztdLGhAIf-ul0CqI7KsQ>
    <xme:7H6lab2tCEzZNA2UDStJo9XuO_W5A0GgB5FGav1AU0u4qwQrburFSN1ZfbAFQHjTU
    D1I7trVan8QCE0VDfvzFBV_UAELhuYh10ZBMXokF6dOVoiejF-ltwY>
X-ME-Received: <xmr:7H6laaS9TnCVB-cDrBnQsrKmUM5imAtpXMQb8RAmFCI0Cai-1sSs32q4qqmrJQi9sGcv1MAROehYvOpyRqpnfrE4TY1VcSlUBM9KYARWhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheejieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7H6ladtf8sKdDCReya33J1Ad_ot6JfzQgOnEKKW4rF21giiLf6lxBg>
    <xmx:7H6lafYP_PSql9iBVAtBKAPQ95_eqSDW7Sk6n5H9pesNSeYms5DU_w>
    <xmx:7H6laSu7CW5IEuOQ0bvNcadI8QPS_73lxxz7UCspoxx9bgwXP_yUWg>
    <xmx:7H6laREGhknXVr3IZk5V_L12lzBB4PX0Ov46pVMaJs6LJSsaPVZY8g>
    <xmx:7H6laXU7wyImTRFma1yjlRSaGqNpd65g5gvESc_KektydKQQ7GLCYgzo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 07:13:32 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d3de4f13 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Mar 2026 12:13:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Mar 2026 13:13:12 +0100
Subject: [PATCH 8/8] builtin/history: implement "split" subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-pks-history-split-v1-8-444fc987a324@pks.im>
References: <20260302-pks-history-split-v1-0-444fc987a324@pks.im>
In-Reply-To: <20260302-pks-history-split-v1-0-444fc987a324@pks.im>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
X-Mailer: b4 0.14.3

It is quite a common use case that one wants to split up one commit into
multiple commits by moving parts of the changes of the original commit
out into a separate commit. This is quite an involved operation though:

  1. Identify the commit in question that is to be dropped.

  2. Perform an interactive rebase on top of that commit's parent.

  3. Modify the instruction sheet to "edit" the commit that is to be
     split up.

  4. Drop the commit via "git reset HEAD~".

  5. Stage changes that should go into the first commit and commit it.

  6. Stage changes that should go into the second commit and commit it.

  7. Finalize the rebase.

This is quite complex, and overall I would claim that most people who
are not experts in Git would struggle with this flow.

Introduce a new "split" subcommand for git-history(1) to make this way
easier. All the user needs to do is to say `git history split $COMMIT`.
From hereon, Git asks the user which parts of the commit shall be moved
out into a separate commit and, once done, asks the user for the commit
message. Git then creates that split-out commit and applies the original
commit on top of it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-history.adoc |  62 ++++
 builtin/history.c              | 250 ++++++++++++++
 t/meson.build                  |   1 +
 t/t3452-history-split.sh       | 757 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1070 insertions(+)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index cc019de697..24dc907033 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [synopsis]
 git history reword <commit> [--dry-run] [--update-refs=(branches|head)]
+git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -57,6 +58,26 @@ The following commands are available to rewrite history in different ways:
 	details of this commit remain unchanged. This command will spawn an
 	editor with the current message of that commit.
 
+`split <commit> [--] [<pathspec>...]`::
+	Interactively split up <commit> into two commits by choosing
+	hunks introduced by it that will be moved into the new split-out
+	commit. These hunks will then be written into a new commit that
+	becomes the parent of the previous commit. The original commit
+	stays intact, except that its parent will be the newly split-out
+	commit.
++
+The commit messages of the split-up commits will be asked for by launching
+the configured editor. Authorship of the commit will be the same as for the
+original commit.
++
+If passed, _<pathspec>_ can be used to limit which changes shall be split out
+of the original commit. Files not matching any of the pathspecs will remain
+part of the original commit. For more details, see the 'pathspec' entry in
+linkgit:gitglossary[7].
++
+It is invalid to select either all or no hunks, as that would lead to
+one of the commits becoming empty.
+
 OPTIONS
 -------
 
@@ -72,6 +93,47 @@ OPTIONS
 	descendants of the original commit will be rewritten. With `head`, only
 	the current `HEAD` reference will be rewritten. Defaults to `branches`.
 
+EXAMPLES
+--------
+
+Split a commit
+~~~~~~~~~~~~~~
+
+----------
+$ git log --stat --oneline
+3f81232 (HEAD -> main) original
+ bar | 1 +
+ foo | 1 +
+ 2 files changed, 2 insertions(+)
+
+$ git history split HEAD
+diff --git a/bar b/bar
+new file mode 100644
+index 0000000..5716ca5
+--- /dev/null
++++ b/bar
+@@ -0,0 +1 @@
++bar
+(1/1) Stage addition [y,n,q,a,d,p,?]? y
+
+diff --git a/foo b/foo
+new file mode 100644
+index 0000000..257cc56
+--- /dev/null
++++ b/foo
+@@ -0,0 +1 @@
++foo
+(1/1) Stage addition [y,n,q,a,d,p,?]? n
+
+$ git log --stat --oneline
+7cebe64 (HEAD -> main) original
+ foo | 1 +
+ 1 file changed, 1 insertion(+)
+d1582f3 split-out commit
+ bar | 1 +
+ 1 file changed, 1 insertion(+)
+----------
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/history.c b/builtin/history.c
index 80726ce14b..dfb9d3f180 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -1,6 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
+#include "cache-tree.h"
 #include "commit.h"
 #include "commit-reach.h"
 #include "config.h"
@@ -8,17 +9,24 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
+#include "lockfile.h"
+#include "oidmap.h"
 #include "parse-options.h"
+#include "path.h"
+#include "read-cache.h"
 #include "refs.h"
 #include "replay.h"
 #include "revision.h"
 #include "sequencer.h"
 #include "strvec.h"
 #include "tree.h"
+#include "unpack-trees.h"
 #include "wt-status.h"
 
 #define GIT_HISTORY_REWORD_USAGE \
 	N_("git history reword <commit> [--dry-run] [--update-refs=(branches|head)]")
+#define GIT_HISTORY_SPLIT_USAGE \
+	N_("git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--] [<pathspec>...]")
 
 static void change_data_free(void *util, const char *str UNUSED)
 {
@@ -484,6 +492,246 @@ static int cmd_history_reword(int argc,
 	return ret;
 }
 
+static int write_ondisk_index(struct repository *repo,
+			      struct object_id *oid,
+			      const char *path)
+{
+	struct unpack_trees_options opts = { 0 };
+	struct lock_file lock = LOCK_INIT;
+	struct tree_desc tree_desc;
+	struct index_state index;
+	struct tree *tree;
+	int ret;
+
+	index_state_init(&index, repo);
+
+	opts.head_idx = -1;
+	opts.src_index = &index;
+	opts.dst_index = &index;
+
+	tree = repo_parse_tree_indirect(repo, oid);
+	init_tree_desc(&tree_desc, &tree->object.oid, tree->buffer, tree->size);
+
+	if (unpack_trees(1, &tree_desc, &opts)) {
+		ret = error(_("unable to populate index with tree"));
+		goto out;
+	}
+
+	prime_cache_tree(repo, &index, tree);
+
+	if (hold_lock_file_for_update(&lock, path, 0) < 0) {
+		ret = error_errno(_("unable to acquire index lock"));
+		goto out;
+	}
+
+	if (write_locked_index(&index, &lock, COMMIT_LOCK)) {
+		ret = error(_("unable to write new index file"));
+		goto out;
+	}
+
+	ret = 0;
+
+out:
+	rollback_lock_file(&lock);
+	release_index(&index);
+	return ret;
+}
+
+static int split_commit(struct repository *repo,
+			struct commit *original,
+			struct pathspec *pathspec,
+			struct commit **out)
+{
+	struct interactive_options interactive_opts = INTERACTIVE_OPTIONS_INIT;
+	struct strbuf index_file = STRBUF_INIT;
+	struct index_state index = INDEX_STATE_INIT(repo);
+	const struct object_id *original_commit_tree_oid;
+	const struct object_id *old_tree_oid, *new_tree_oid;
+	struct object_id parent_tree_oid;
+	char original_commit_oid[GIT_MAX_HEXSZ + 1];
+	struct commit *first_commit, *second_commit;
+	struct commit_list *parents = NULL;
+	struct tree *split_tree;
+	int ret;
+
+	if (original->parents) {
+		if (repo_parse_commit(repo, original->parents->item)) {
+			ret = error(_("unable to parse parent commit %s"),
+				    oid_to_hex(&original->parents->item->object.oid));
+			goto out;
+		}
+
+		parent_tree_oid = *get_commit_tree_oid(original->parents->item);
+	} else {
+		oidcpy(&parent_tree_oid, repo->hash_algo->empty_tree);
+	}
+	original_commit_tree_oid = get_commit_tree_oid(original);
+
+	/*
+	 * Construct the first commit. This is done by taking the original
+	 * commit parent's tree and selectively patching changes from the diff
+	 * between that parent and its child.
+	 */
+	repo_git_path_replace(repo, &index_file, "%s", "history-split.index");
+
+	ret = write_ondisk_index(repo, &parent_tree_oid, index_file.buf);
+	if (ret < 0)
+		goto out;
+
+	ret = read_index_from(&index, index_file.buf, repo->gitdir);
+	if (ret < 0) {
+		ret = error(_("failed reading temporary index"));
+		goto out;
+	}
+
+	oid_to_hex_r(original_commit_oid, &original->object.oid);
+	ret = run_add_p_index(repo, &index, index_file.buf, &interactive_opts,
+			      original_commit_oid, pathspec, ADD_P_DISALLOW_EDIT);
+	if (ret < 0)
+		goto out;
+
+	split_tree = write_in_core_index_as_tree(repo, &index);
+	if (!split_tree) {
+		ret = error(_("failed split tree"));
+		goto out;
+	}
+
+	unlink(index_file.buf);
+	strbuf_release(&index_file);
+
+	/*
+	 * We disallow the cases where either the split-out commit or the
+	 * original commit would become empty. Consequently, if we see that the
+	 * new tree ID matches either of those trees we abort.
+	 */
+	if (oideq(&split_tree->object.oid, &parent_tree_oid)) {
+		ret = error(_("split commit is empty"));
+		goto out;
+	} else if (oideq(&split_tree->object.oid, original_commit_tree_oid)) {
+		ret = error(_("split commit tree matches original commit"));
+		goto out;
+	}
+
+	/*
+	 * The first commit is constructed from the split-out tree. The base
+	 * that shall be diffed against is the parent of the original commit.
+	 */
+	ret = commit_tree_with_edited_message_ext(repo, "split-out", original,
+						  original->parents, &parent_tree_oid,
+						  &split_tree->object.oid, &first_commit);
+	if (ret < 0) {
+		ret = error(_("failed writing first commit"));
+		goto out;
+	}
+
+	/*
+	 * The second commit is constructed from the original tree. The base to
+	 * diff against and the parent in this case is the first split-out
+	 * commit.
+	 */
+	commit_list_append(first_commit, &parents);
+
+	old_tree_oid = &repo_get_commit_tree(repo, first_commit)->object.oid;
+	new_tree_oid = &repo_get_commit_tree(repo, original)->object.oid;
+
+	ret = commit_tree_with_edited_message_ext(repo, "split-out", original,
+						  parents, old_tree_oid,
+						  new_tree_oid, &second_commit);
+	if (ret < 0) {
+		ret = error(_("failed writing second commit"));
+		goto out;
+	}
+
+	*out = second_commit;
+	ret = 0;
+
+out:
+	if (index_file.len)
+		unlink(index_file.buf);
+	strbuf_release(&index_file);
+	free_commit_list(parents);
+	release_index(&index);
+	return ret;
+}
+
+static int cmd_history_split(int argc,
+			     const char **argv,
+			     const char *prefix,
+			     struct repository *repo)
+{
+	const char * const usage[] = {
+		GIT_HISTORY_SPLIT_USAGE,
+		NULL,
+	};
+	enum ref_action action = REF_ACTION_DEFAULT;
+	int dry_run = 0;
+	struct option options[] = {
+		OPT_CALLBACK_F(0, "update-refs", &action, N_("<refs>"),
+			       N_("control ref update behavior (branches|head|print)"),
+			       PARSE_OPT_NONEG, parse_ref_action),
+		OPT_BOOL('n', "dry-run", &dry_run,
+			 N_("perform a dry-run without updating any refs")),
+		OPT_END(),
+	};
+	struct commit *original, *rewritten = NULL;
+	struct strbuf reflog_msg = STRBUF_INIT;
+	struct pathspec pathspec = { 0 };
+	struct rev_info revs = { 0 };
+	int ret;
+
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+	if (argc < 1) {
+		ret = error(_("command expects a committish"));
+		goto out;
+	}
+	repo_config(repo, git_default_config, NULL);
+
+	if (action == REF_ACTION_DEFAULT)
+		action = REF_ACTION_BRANCHES;
+
+	parse_pathspec(&pathspec, 0,
+		       PATHSPEC_PREFER_FULL |
+		       PATHSPEC_SYMLINK_LEADING_PATH |
+		       PATHSPEC_PREFIX_ORIGIN,
+		       prefix, argv + 1);
+
+	original = lookup_commit_reference_by_name(argv[0]);
+	if (!original) {
+		ret = error(_("commit cannot be found: %s"), argv[0]);
+		goto out;
+	}
+
+	ret = setup_revwalk(repo, action, original, &revs);
+	if (ret < 0)
+		goto out;
+
+	if (original->parents && original->parents->next) {
+		ret = error(_("cannot split up merge commit"));
+		goto out;
+	}
+
+	ret = split_commit(repo, original, &pathspec, &rewritten);
+	if (ret < 0)
+		goto out;
+
+	strbuf_addf(&reflog_msg, "split: updating %s", argv[0]);
+
+	ret = handle_reference_updates(&revs, action, original, rewritten,
+				       reflog_msg.buf, dry_run);
+	if (ret < 0) {
+		ret = error(_("failed replaying descendants"));
+		goto out;
+	}
+
+	ret = 0;
+
+out:
+	strbuf_release(&reflog_msg);
+	clear_pathspec(&pathspec);
+	release_revisions(&revs);
+	return ret;
+}
+
 int cmd_history(int argc,
 		const char **argv,
 		const char *prefix,
@@ -491,11 +739,13 @@ int cmd_history(int argc,
 {
 	const char * const usage[] = {
 		GIT_HISTORY_REWORD_USAGE,
+		GIT_HISTORY_SPLIT_USAGE,
 		NULL,
 	};
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
 		OPT_SUBCOMMAND("reword", &fn, cmd_history_reword),
+		OPT_SUBCOMMAND("split", &fn, cmd_history_split),
 		OPT_END(),
 	};
 
diff --git a/t/meson.build b/t/meson.build
index 6d91470ebc..2d578ef58b 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -392,6 +392,7 @@ integration_tests = [
   't3438-rebase-broken-files.sh',
   't3450-history.sh',
   't3451-history-reword.sh',
+  't3452-history-split.sh',
   't3500-cherry.sh',
   't3501-revert-cherry-pick.sh',
   't3502-cherry-pick-merge.sh',
diff --git a/t/t3452-history-split.sh b/t/t3452-history-split.sh
new file mode 100755
index 0000000000..8ed0cebb50
--- /dev/null
+++ b/t/t3452-history-split.sh
@@ -0,0 +1,757 @@
+#!/bin/sh
+
+test_description='tests for git-history split subcommand'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY/lib-log-graph.sh"
+
+# The fake editor takes multiple arguments, each of which represents a commit
+# message. Subsequent invocations of the editor will then yield those messages
+# in order.
+#
+set_fake_editor () {
+	printf "%s\n" "$@" >fake-input &&
+	write_script fake-editor.sh <<-\EOF &&
+	head -n1 fake-input >"$1"
+	sed 1d fake-input >fake-input.trimmed &&
+	mv fake-input.trimmed fake-input
+	EOF
+	test_set_editor "$(pwd)"/fake-editor.sh
+}
+
+expect_graph () {
+	cat >expect &&
+	lib_test_cmp_graph --graph --format=%s "$@"
+}
+
+expect_log () {
+	git log --format="%s" >actual &&
+	cat >expect &&
+	test_cmp expect actual
+}
+
+expect_tree_entries () {
+	git ls-tree --name-only "$1" >actual &&
+	cat >expect &&
+	test_cmp expect actual
+}
+
+test_expect_success 'refuses to work with merge commits' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit base &&
+		git branch branch &&
+		test_commit ours &&
+		git switch branch &&
+		test_commit theirs &&
+		git switch - &&
+		git merge theirs &&
+		test_must_fail git history split HEAD 2>err &&
+		test_grep "cannot split up merge commit" err &&
+		test_must_fail git history split HEAD~ 2>err &&
+		test_grep "replaying merge commits is not supported yet" err
+	)
+'
+
+test_expect_success 'errors on missing commit argument' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		test_must_fail git history split 2>err &&
+		test_grep "command expects a committish" err
+	)
+'
+
+test_expect_success 'errors on unknown revision' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		test_must_fail git history split does-not-exist 2>err &&
+		test_grep "commit cannot be found" err
+	)
+'
+
+test_expect_success '--dry-run does not modify any refs' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit base &&
+		touch bar foo &&
+		git add . &&
+		git commit -m split-me &&
+
+		git refs list --include-root-refs >before &&
+
+		set_fake_editor "first" "second" &&
+		git history split --dry-run HEAD <<-EOF &&
+		y
+		n
+		EOF
+
+		git refs list --include-root-refs >after &&
+		test_cmp before after
+	)
+'
+
+test_expect_success 'can split up tip commit' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		touch bar foo &&
+		git add . &&
+		git commit -m split-me &&
+
+		git symbolic-ref HEAD >expect &&
+		set_fake_editor "first" "second" &&
+		git history split HEAD <<-EOF &&
+		y
+		n
+		EOF
+		git symbolic-ref HEAD >actual &&
+		test_cmp expect actual &&
+
+		expect_log <<-EOF &&
+		second
+		first
+		initial
+		EOF
+
+		expect_tree_entries HEAD~ <<-EOF &&
+		bar
+		initial.t
+		EOF
+
+		expect_tree_entries HEAD <<-EOF &&
+		bar
+		foo
+		initial.t
+		EOF
+
+		git reflog >reflog &&
+		test_grep "split: updating HEAD" reflog
+	)
+'
+
+test_expect_success 'can split up root commit' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		touch bar foo &&
+		git add . &&
+		git commit -m root &&
+		test_commit tip &&
+
+		set_fake_editor "first" "second" &&
+		git history split HEAD~ <<-EOF &&
+		y
+		n
+		EOF
+
+		expect_log <<-EOF &&
+		tip
+		second
+		first
+		EOF
+
+		expect_tree_entries HEAD~2 <<-EOF &&
+		bar
+		EOF
+
+		expect_tree_entries HEAD~ <<-EOF &&
+		bar
+		foo
+		EOF
+
+		expect_tree_entries HEAD <<-EOF
+		bar
+		foo
+		tip.t
+		EOF
+	)
+'
+
+test_expect_success 'can split up in-between commit' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		touch bar foo &&
+		git add . &&
+		git commit -m split-me &&
+		test_commit tip &&
+
+		set_fake_editor "first" "second" &&
+		git history split HEAD~ <<-EOF &&
+		y
+		n
+		EOF
+
+		expect_log <<-EOF &&
+		tip
+		second
+		first
+		initial
+		EOF
+
+		expect_tree_entries HEAD~2 <<-EOF &&
+		bar
+		initial.t
+		EOF
+
+		expect_tree_entries HEAD~ <<-EOF &&
+		bar
+		foo
+		initial.t
+		EOF
+
+		expect_tree_entries HEAD <<-EOF
+		bar
+		foo
+		initial.t
+		tip.t
+		EOF
+	)
+'
+
+test_expect_success 'can split HEAD only' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit base &&
+		touch a b &&
+		git add . &&
+		git commit -m split-me &&
+		git branch unrelated &&
+
+		set_fake_editor "ours-a" "ours-b" &&
+		git history split --update-refs=head HEAD <<-EOF &&
+		y
+		n
+		EOF
+		expect_graph --branches <<-EOF
+		* ours-b
+		* ours-a
+		| * split-me
+		|/
+		* base
+		EOF
+	)
+'
+
+test_expect_success 'can split detached HEAD' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		touch bar foo &&
+		git add . &&
+		git commit -m split-me &&
+		git checkout --detach HEAD &&
+
+		set_fake_editor "first" "second" &&
+		git history split --update-refs=head HEAD <<-EOF &&
+		y
+		n
+		EOF
+
+		# HEAD should be detached and updated.
+		test_must_fail git symbolic-ref HEAD &&
+
+		expect_log <<-EOF
+		second
+		first
+		initial
+		EOF
+	)
+'
+
+test_expect_success 'can split commit in unrelated branch' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit base &&
+		git branch ours &&
+		git switch --create theirs &&
+		touch theirs-a theirs-b &&
+		git add . &&
+		git commit -m theirs &&
+		git switch ours &&
+		test_commit ours &&
+
+		# With --update-refs=head it is not possible to split up a
+		# commit that is unrelated to HEAD.
+		test_must_fail git history split --update-refs=head theirs 2>err &&
+		test_grep "rewritten commit must be an ancestor of HEAD" err &&
+
+		set_fake_editor "theirs-rewritten-a" "theirs-rewritten-b" &&
+		git history split theirs <<-EOF &&
+		y
+		n
+		EOF
+		expect_graph --branches <<-EOF &&
+		* ours
+		| * theirs-rewritten-b
+		| * theirs-rewritten-a
+		|/
+		* base
+		EOF
+
+		expect_tree_entries theirs~ <<-EOF &&
+		base.t
+		theirs-a
+		EOF
+
+		expect_tree_entries theirs <<-EOF
+		base.t
+		theirs-a
+		theirs-b
+		EOF
+	)
+'
+
+test_expect_success 'updates multiple descendant branches' '
+	test_when_finished "rm -rf repo" &&
+	git init repo --initial-branch=main &&
+	(
+		cd repo &&
+		test_commit base &&
+		touch file-a file-b &&
+		git add . &&
+		git commit -m split-me &&
+		git branch branch &&
+		test_commit on-main &&
+		git switch branch &&
+		test_commit on-branch &&
+		git switch main &&
+
+		set_fake_editor "split-a" "split-b" &&
+		git history split HEAD~ <<-EOF &&
+		y
+		n
+		EOF
+
+		# Both branches should now descend from the split commits.
+		expect_graph --branches <<-EOF
+		* on-branch
+		| * on-main
+		|/
+		* split-b
+		* split-a
+		* base
+		EOF
+	)
+'
+
+test_expect_success 'can pick multiple hunks' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		touch bar baz foo qux &&
+		git add . &&
+		git commit -m split-me &&
+
+		set_fake_editor "first" "second" &&
+		git history split HEAD <<-EOF &&
+		y
+		n
+		y
+		n
+		EOF
+
+		expect_tree_entries HEAD~ <<-EOF &&
+		bar
+		foo
+		EOF
+
+		expect_tree_entries HEAD <<-EOF
+		bar
+		baz
+		foo
+		qux
+		EOF
+	)
+'
+
+test_expect_success 'can use only last hunk' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		touch bar foo &&
+		git add . &&
+		git commit -m split-me &&
+
+		set_fake_editor "first" "second" &&
+		git history split HEAD <<-EOF &&
+		n
+		y
+		EOF
+
+		expect_log <<-EOF &&
+		second
+		first
+		EOF
+
+		expect_tree_entries HEAD~ <<-EOF &&
+		foo
+		EOF
+
+		expect_tree_entries HEAD <<-EOF
+		bar
+		foo
+		EOF
+	)
+'
+
+test_expect_success 'can split commit with file deletions' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		echo a >a &&
+		echo b >b &&
+		echo c >c &&
+		git add . &&
+		git commit -m base &&
+		git rm a b &&
+		git commit -m delete-both &&
+
+		set_fake_editor "delete-a" "delete-b" &&
+		git history split HEAD <<-EOF &&
+		y
+		n
+		EOF
+
+		expect_log <<-EOF &&
+		delete-b
+		delete-a
+		base
+		EOF
+
+		expect_tree_entries HEAD~ <<-EOF &&
+		b
+		c
+		EOF
+
+		expect_tree_entries HEAD <<-EOF
+		c
+		EOF
+	)
+'
+
+test_expect_success 'preserves original authorship' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		touch bar foo &&
+		git add . &&
+		GIT_AUTHOR_NAME="Other Author" \
+		GIT_AUTHOR_EMAIL="other@example.com" \
+		git commit -m split-me &&
+
+		set_fake_editor "first" "second" &&
+		git history split HEAD <<-EOF &&
+		y
+		n
+		EOF
+
+		git log -1 --format="%an <%ae>" HEAD~ >actual &&
+		echo "Other Author <other@example.com>" >expect &&
+		test_cmp expect actual &&
+
+		git log -1 --format="%an <%ae>" HEAD >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'aborts with empty commit message' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		touch bar foo &&
+		git add . &&
+		git commit -m split-me &&
+
+		set_fake_editor "" &&
+		test_must_fail git history split HEAD <<-EOF 2>err &&
+		y
+		n
+		EOF
+		test_grep "Aborting commit due to empty commit message." err
+	)
+'
+
+test_expect_success 'commit message editor sees split-out changes' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		touch bar foo &&
+		git add . &&
+		git commit -m split-me &&
+
+		write_script fake-editor.sh <<-\EOF &&
+		cat "$1" >>MESSAGES &&
+		echo "some commit message" >"$1"
+		EOF
+		test_set_editor "$(pwd)"/fake-editor.sh &&
+
+		git history split HEAD <<-EOF &&
+		y
+		n
+		EOF
+
+		# Note that we expect to see the messages twice, once for each
+		# of the commits. The committed files are different though.
+		cat >expect <<-EOF &&
+		split-me
+
+		# Please enter the commit message for the split-out changes. Lines starting
+		# with ${SQ}#${SQ} will be ignored, and an empty message aborts the commit.
+		# Changes to be committed:
+		#	new file:   bar
+		#
+		split-me
+
+		# Please enter the commit message for the split-out changes. Lines starting
+		# with ${SQ}#${SQ} will be ignored, and an empty message aborts the commit.
+		# Changes to be committed:
+		#	new file:   foo
+		#
+		EOF
+		test_cmp expect MESSAGES &&
+
+		expect_log <<-EOF
+		some commit message
+		some commit message
+		EOF
+	)
+'
+
+test_expect_success 'can use pathspec to limit what gets split' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		touch bar foo &&
+		git add . &&
+		git commit -m split-me &&
+
+		set_fake_editor "first" "second" &&
+		git history split HEAD -- foo <<-EOF &&
+		y
+		EOF
+
+		expect_tree_entries HEAD~ <<-EOF &&
+		foo
+		EOF
+
+		expect_tree_entries HEAD <<-EOF
+		bar
+		foo
+		EOF
+	)
+'
+
+test_expect_success 'pathspec matching no files produces empty split error' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		touch bar foo &&
+		git add . &&
+		git commit -m split-me &&
+
+		set_fake_editor "first" "second" &&
+		test_must_fail git history split HEAD -- nonexistent 2>err &&
+		test_grep "split commit is empty" err
+	)
+'
+
+test_expect_success 'split with multiple pathspecs' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		touch a b c d &&
+		git add . &&
+		git commit -m split-me &&
+
+		# Only a and c should be offered for splitting.
+		set_fake_editor "split-ac" "remainder" &&
+		git history split HEAD -- a c <<-EOF &&
+		y
+		y
+		EOF
+
+		expect_tree_entries HEAD~ <<-EOF &&
+		a
+		c
+		initial.t
+		EOF
+
+		expect_tree_entries HEAD <<-EOF
+		a
+		b
+		c
+		d
+		initial.t
+		EOF
+	)
+'
+
+test_expect_success 'split with file mode change' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		echo content >script &&
+		git add . &&
+		git commit -m base &&
+		test_chmod +x script &&
+		echo change >script &&
+		git commit -a -m "mode and content change" &&
+
+		set_fake_editor "mode-change" "content-change" &&
+		git history split HEAD <<-EOF &&
+		y
+		n
+		EOF
+
+		expect_log <<-EOF
+		content-change
+		mode-change
+		base
+		EOF
+	)
+'
+
+test_expect_success 'refuses to create empty split-out commit' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit base &&
+		touch bar foo &&
+		git add . &&
+		git commit -m split-me &&
+
+		test_must_fail git history split HEAD 2>err <<-EOF &&
+		n
+		n
+		EOF
+		test_grep "split commit is empty" err
+	)
+'
+
+test_expect_success 'hooks are not executed for rewritten commits' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		touch bar foo &&
+		git add . &&
+		git commit -m split-me &&
+		old_head=$(git rev-parse HEAD) &&
+
+		ORIG_PATH="$(pwd)" &&
+		export ORIG_PATH &&
+		for hook in prepare-commit-msg pre-commit post-commit post-rewrite commit-msg
+		do
+			write_script .git/hooks/$hook <<-\EOF || exit 1
+			touch "$ORIG_PATH"/hooks.log
+			EOF
+		done &&
+
+		set_fake_editor "first" "second" &&
+		git history split HEAD <<-EOF &&
+		y
+		n
+		EOF
+
+		expect_log <<-EOF &&
+		second
+		first
+		EOF
+
+		test_path_is_missing hooks.log
+	)
+'
+
+test_expect_success 'refuses to create empty original commit' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		touch bar foo &&
+		git add . &&
+		git commit -m split-me &&
+
+		test_must_fail git history split HEAD 2>err <<-EOF &&
+		y
+		y
+		EOF
+		test_grep "split commit tree matches original commit" err
+	)
+'
+
+test_expect_success 'retains changes in the worktree and index' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		echo a >a &&
+		echo b >b &&
+		git add . &&
+		git commit -m "initial commit" &&
+		echo a-modified >a &&
+		echo b-modified >b &&
+		git add b &&
+		set_fake_editor "a-only" "remainder" &&
+		git history split HEAD <<-EOF &&
+		y
+		n
+		EOF
+
+		expect_tree_entries HEAD~ <<-EOF &&
+		a
+		EOF
+		expect_tree_entries HEAD <<-EOF &&
+		a
+		b
+		EOF
+
+		cat >expect <<-\EOF &&
+		 M a
+		M  b
+		?? actual
+		?? expect
+		?? fake-editor.sh
+		?? fake-input
+		EOF
+		git status --porcelain >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_done

-- 
2.53.0.697.g625c4fb2da.dirty


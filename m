Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620BA33C506
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 14:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056194; cv=none; b=TFUV0dsxE3QDVDKVnIuo8WZbYEv0yb/E6ogZxtJyBS4Ht8nPK1Iboy1Se+9y8kgLa3fY2hbEsjPlUM0xcBUSEjY3kU2Vs6TBxsTJDIH98eMGjcTLsXvJBEnD9ecucFElUd+j6+gCkLtf5R2sNDlY2QNoh6jmzwat/8SRzEtWhf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056194; c=relaxed/simple;
	bh=WFgT75+JQ1mmcMWqmdDnaJyGpLp6EybaKCDUvOeohiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GIggPWIEVir62y22jz8rIFdcU9sDYJuUdE6IzbGzuaHB1xudi3H0GdtlHoCEgQt5t+tTrPcSrQ6889QPGtPF+IF4RG2hrkWQjioOqWmcCQhVNvbt0Z4bO3xS8Ho3MlQxOHtexGGVa77LdY7zuL6kXkWdtWW+wR+2q891yKjSNEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ru6E4nlf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tqtbsfJW; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ru6E4nlf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tqtbsfJW"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id CAA84EC01EA;
	Tue, 21 Oct 2025 10:16:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 21 Oct 2025 10:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761056191;
	 x=1761142591; bh=CtEgWvAVzrYZpJCg1d7kkOV49fuoGCeRAkwuGNfqI8Q=; b=
	Ru6E4nlfbZIaL59Iw70mXlj7IuljiaIU6/S+c+R7Cu/CBLPkZ5TAXGuVJ7a+XOXB
	qZM/kO8aE4GE/VzplUL1duM9KuldIIwy/tzdhpZtuE8hRRJdJWTjDcg+BKykFkfT
	P58oZNFBflDHIGgRlgHT8HmjEP9xk0O3k6uLCib/1MVOaZg6q0eHHuGcCJ8Bltzi
	fPV84Z1JXI8CsT9ke+eDii8tmU7ieVG4uE1t8N9gewqJ+YdfIQTYoD8ihOyv+3Xx
	1WfdAS1F7DnccRHdkN0FO5qBrsBqbQGapiAhMbx8RkeSb/D9Tzd/4+GMY065mq52
	eab80TWD++Lks5NL27kelw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761056191; x=
	1761142591; bh=CtEgWvAVzrYZpJCg1d7kkOV49fuoGCeRAkwuGNfqI8Q=; b=t
	qtbsfJWnlJVit6yFFtoJW8ZOaf+dIwu4q+YPaQGPtz+px3RoA7uQpRvd/ixkkrXV
	RpfdXVHeZj8N8BipjbCYlft3VyV5NMHPn6blfktc8sp/qxTnqO3Z5jsHjTQ0/q0w
	z+c4G91WuSRfGAMqNyfYU3K49grsehbaUG5e1yCtX9/mn4vpIrmvYcDWZ12yxwUc
	sFtXWxuAREvn584U0lr+TV2o4iG9u9L2jVYj5/2HpINvIYoH6C08a4qei8tTXEia
	HKzngMVlqygXdPwLOYlWsNFdqD1Aj71W/Z+ZDOQhWWGTUftVW97c6O3+bmzMQYB4
	kqVs0Cg2iy0fajjWCfmyQ==
X-ME-Sender: <xms:v5X3aFx_dPtH7QkFQm_8pbogZfibyXtmXjUHziFQ7bCLeY2XtP4AUQ>
    <xme:v5X3aH3Cih6xZ872-LS8LTG8bcZZQY3eIlpkeTII2_-C6HWClUNTwLyWhWpQ-NbqL
    fa3-DbAYbbSkw4yDCY8EgutbN5B3O2ThOyr9GuxOuiAZj6iDF3kHw>
X-ME-Received: <xmr:v5X3aC_yKuT7E7rqLeya9b9AeJUG4CV1-Kgp4F4qfkYfGOBiLL8Dfo3hIHvr27gd11HQFs_-hNnthcqSj3O8Yrjm0dLnlj7PFwc2ZXAjBXflHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehjnhdrrg
    hvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruh
    hgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtoh
    hm
X-ME-Proxy: <xmx:v5X3aHoNwM6lrLwnfgWzvsVA5GdnvA7S2vQznUtMjRrRXpzoAr-Kiw>
    <xmx:v5X3aMSI2U0eIosSmCYiym7pGT8P55F6lE08ma6q0X_I_nJEZsrscg>
    <xmx:v5X3aKMJ0bSjJfE0wwDVW9g8EsGlkHvIPZa2MVdSiJSbMIgiwUFLeg>
    <xmx:v5X3aKiI9NAjrUY0QvmKmvfy0sDxJkMoLZjMKdB9JCkq4NqmizRHxQ>
    <xmx:v5X3aFMmIDm4isbQY6OVElC_mCz24YwDlpOLLcQyQZTa5TyI8sirekq0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 10:16:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1543bd30 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 14:16:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 21 Oct 2025 16:16:00 +0200
Subject: [PATCH v5 12/12] builtin/history: implement "split" subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-b4-pks-history-builtin-v5-12-78d23f578fe6@pks.im>
References: <20251021-b4-pks-history-builtin-v5-0-78d23f578fe6@pks.im>
In-Reply-To: <20251021-b4-pks-history-builtin-v5-0-78d23f578fe6@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
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
 Documentation/git-history.adoc |  62 ++++++
 builtin/history.c              | 222 ++++++++++++++++++++
 t/meson.build                  |   1 +
 t/t3452-history-split.sh       | 447 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 732 insertions(+)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index 6f016801936..d741caf8347 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -10,6 +10,7 @@ SYNOPSIS
 [synopsis]
 git history [<options>]
 git history reword [<options>] <commit>
+git history split [<options>] <commit> [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -40,6 +41,26 @@ rewrite history in different ways:
 	provided, then this command will spawn an editor with the current
 	message of that commit.
 
+`split [--message=<message>] <commit> [--] [<pathspec>...]`::
+	Interactively split up <commit> into two commits by choosing
+	hunks introduced by it that will be moved into the new split-out
+	commit. These hunks will then be written into a new commit that
+	becomes the parent of the previous commit. The original commit
+	stays intact, except that its parent will be the newly split-out
+	commit.
++
+The commit message of the new commit will be asked for by launching the
+configured editor, unless it has been specified with the `-m` option.
+Authorship of the commit will be the same as for the original commit.
++
+If passed, _<pathspec>_ can be used to limit which changes shall be split out
+of the original commit. Files not matching any of the pathspecs will remain
+part of the original commit. For more details, see the 'pathspec' entry in
+linkgit:gitglossary[7].
++
+It is invalid to select either all or no hunks, as that would lead to
+one of the commits becoming empty.
+
 CONFIGURATION
 -------------
 
@@ -47,6 +68,47 @@ include::includes/cmd-config-section-all.adoc[]
 
 include::config/sequencer.adoc[]
 
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
+$ git history split HEAD --message="split-out commit"
+diff --git a/bar b/bar
+new file mode 100644
+index 0000000..5716ca5
+--- /dev/null
++++ b/bar
+@@ -0,0 +1 @@
++bar
+(1/1) Stage addition [y,n,q,a,d,e,p,?]? y
+
+diff --git a/foo b/foo
+new file mode 100644
+index 0000000..257cc56
+--- /dev/null
++++ b/foo
+@@ -0,0 +1 @@
++foo
+(1/1) Stage addition [y,n,q,a,d,e,p,?]? n
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
index f14e88c9bf4..6ca4382c8e2 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -1,6 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
+#include "cache-tree.h"
 #include "commit-reach.h"
 #include "commit.h"
 #include "config.h"
@@ -8,17 +9,22 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
+#include "oidmap.h"
 #include "parse-options.h"
+#include "path.h"
+#include "read-cache.h"
 #include "refs.h"
 #include "replay.h"
 #include "reset.h"
 #include "revision.h"
+#include "run-command.h"
 #include "sequencer.h"
 #include "strvec.h"
 #include "tree.h"
 #include "wt-status.h"
 
 #define GIT_HISTORY_REWORD_USAGE N_("git history reword [<options>] <commit>")
+#define GIT_HISTORY_SPLIT_USAGE  N_("git history split [<options>] <commit> [--] [<pathspec>...]")
 
 static int collect_commits(struct repository *repo,
 			   struct commit *old_commit,
@@ -357,6 +363,220 @@ static int cmd_history_reword(int argc,
 	return ret;
 }
 
+static int split_commit(struct repository *repo,
+			struct commit *original_commit,
+			struct pathspec *pathspec,
+			const char *commit_message,
+			struct object_id *out)
+{
+	struct interactive_options interactive_opts = INTERACTIVE_OPTIONS_INIT;
+	struct strbuf index_file = STRBUF_INIT, split_message = STRBUF_INIT;
+	struct child_process read_tree_cmd = CHILD_PROCESS_INIT;
+	struct index_state index = INDEX_STATE_INIT(repo);
+	struct object_id original_commit_tree_oid, parent_tree_oid;
+	const char *original_message, *original_body, *ptr;
+	char original_commit_oid[GIT_MAX_HEXSZ + 1];
+	char *original_author = NULL;
+	struct commit_list *parents = NULL;
+	struct commit *first_commit;
+	struct tree *split_tree;
+	size_t len;
+	int ret;
+
+	if (original_commit->parents)
+		parent_tree_oid = *get_commit_tree_oid(original_commit->parents->item);
+	else
+		oidcpy(&parent_tree_oid, repo->hash_algo->empty_tree);
+	original_commit_tree_oid = *get_commit_tree_oid(original_commit);
+
+	/*
+	* Construct the first commit. This is done by taking the original
+	* commit parent's tree and selectively patching changes from the diff
+	* between that parent and its child.
+	*/
+	repo_git_path_replace(repo, &index_file, "%s", "history-split.index");
+
+	read_tree_cmd.git_cmd = 1;
+	strvec_pushf(&read_tree_cmd.env, "GIT_INDEX_FILE=%s", index_file.buf);
+	strvec_push(&read_tree_cmd.args, "read-tree");
+	strvec_push(&read_tree_cmd.args, oid_to_hex(&parent_tree_oid));
+	ret = run_command(&read_tree_cmd);
+	if (ret < 0)
+		goto out;
+
+	ret = read_index_from(&index, index_file.buf, repo->gitdir);
+	if (ret < 0) {
+		ret = error(_("failed reading temporary index"));
+		goto out;
+	}
+
+	oid_to_hex_r(original_commit_oid, &original_commit->object.oid);
+	ret = run_add_p_index(repo, &index, index_file.buf, &interactive_opts,
+			      original_commit_oid, pathspec);
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
+
+	/*
+	* We disallow the cases where either the split-out commit or the
+	* original commit would become empty. Consequently, if we see that the
+	* new tree ID matches either of those trees we abort.
+	*/
+	if (oideq(&split_tree->object.oid, &parent_tree_oid)) {
+		ret = error(_("split commit is empty"));
+		goto out;
+	} else if (oideq(&split_tree->object.oid, &original_commit_tree_oid)) {
+		ret = error(_("split commit tree matches original commit"));
+		goto out;
+	}
+
+	/* We retain authorship of the original commit. */
+	original_message = repo_logmsg_reencode(repo, original_commit, NULL, NULL);
+	ptr = find_commit_header(original_message, "author", &len);
+	if (ptr)
+		original_author = xmemdupz(ptr, len);
+
+	ret = fill_commit_message(repo, &parent_tree_oid, &split_tree->object.oid,
+				  "", commit_message, "split-out", &split_message);
+	if (ret < 0)
+		goto out;
+
+	ret = commit_tree(split_message.buf, split_message.len, &split_tree->object.oid,
+			  original_commit->parents, &out[0], original_author, NULL);
+	if (ret < 0) {
+		ret = error(_("failed writing split-out commit"));
+		goto out;
+	}
+
+	/*
+	* The second commit is much simpler to construct, as we can simply use
+	* the original commit details, except that we adjust its parent to be
+	* the newly split-out commit.
+	*/
+	find_commit_subject(original_message, &original_body);
+	first_commit = lookup_commit_reference(repo, &out[0]);
+	commit_list_append(first_commit, &parents);
+
+	ret = commit_tree(original_body, strlen(original_body), &original_commit_tree_oid,
+			  parents, &out[1], original_author, NULL);
+	if (ret < 0) {
+		ret = error(_("failed writing second commit"));
+		goto out;
+	}
+
+	ret = 0;
+
+out:
+	if (index_file.len)
+		unlink(index_file.buf);
+	strbuf_release(&split_message);
+	strbuf_release(&index_file);
+	free_commit_list(parents);
+	free(original_author);
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
+	const char *commit_message = NULL;
+	struct option options[] = {
+		OPT_STRING('m', "message", &commit_message, N_("message"), N_("commit message")),
+		OPT_END(),
+	};
+	struct oidmap rewritten_commits = OIDMAP_INIT;
+	struct commit *original_commit, *parent, *head;
+	struct strvec commits = STRVEC_INIT;
+	struct commit_list *from_list = NULL;
+	struct object_id split_commits[2];
+	struct pathspec pathspec = { 0 };
+	int ret;
+
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+	if (argc < 1) {
+		ret = error(_("command expects a revision"));
+		goto out;
+	}
+	repo_config(repo, git_default_config, NULL);
+
+	original_commit = lookup_commit_reference_by_name(argv[0]);
+	if (!original_commit) {
+		ret = error(_("commit to be split cannot be found: %s"), argv[0]);
+		goto out;
+	}
+
+	parent = original_commit->parents ? original_commit->parents->item : NULL;
+	if (parent && repo_parse_commit(repo, parent)) {
+		ret = error(_("unable to parse commit %s"),
+			    oid_to_hex(&parent->object.oid));
+		goto out;
+	}
+
+	head = lookup_commit_reference_by_name("HEAD");
+	if (!head) {
+		ret = error(_("could not resolve HEAD to a commit"));
+		goto out;
+	}
+
+	commit_list_append(original_commit, &from_list);
+	if (!repo_is_descendant_of(repo, head, from_list)) {
+		ret = error(_("split commit must be reachable from current HEAD commit"));
+		goto out;
+	}
+
+	parse_pathspec(&pathspec, 0,
+		PATHSPEC_PREFER_FULL | PATHSPEC_SYMLINK_LEADING_PATH | PATHSPEC_PREFIX_ORIGIN,
+		prefix, argv + 1);
+
+	/*
+	 * Collect the list of commits that we'll have to reapply now already.
+	 * This ensures that we'll abort early on in case the range of commits
+	 * contains merges, which we do not yet handle.
+	 */
+	ret = collect_commits(repo, parent, head, &commits);
+	if (ret < 0)
+		goto out;
+
+	/*
+	 * Then we split up the commit and replace the original commit with the
+	 * new ones.
+	 */
+	ret = split_commit(repo, original_commit, &pathspec,
+			   commit_message, split_commits);
+	if (ret < 0)
+		goto out;
+
+	replace_commits(&commits, &original_commit->object.oid,
+			split_commits, ARRAY_SIZE(split_commits));
+
+	ret = apply_commits(repo, &commits, parent, head, "split");
+	if (ret < 0)
+		goto out;
+
+	ret = 0;
+
+out:
+	oidmap_clear(&rewritten_commits, 0);
+	free_commit_list(from_list);
+	clear_pathspec(&pathspec);
+	strvec_clear(&commits);
+	return ret;
+}
+
 int cmd_history(int argc,
 		const char **argv,
 		const char *prefix,
@@ -365,11 +585,13 @@ int cmd_history(int argc,
 	const char * const usage[] = {
 		N_("git history [<options>]"),
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
index a3ec9199947..5d3014a768f 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -386,6 +386,7 @@ integration_tests = [
   't3438-rebase-broken-files.sh',
   't3450-history.sh',
   't3451-history-reword.sh',
+  't3452-history-split.sh',
   't3500-cherry.sh',
   't3501-revert-cherry-pick.sh',
   't3502-cherry-pick-merge.sh',
diff --git a/t/t3452-history-split.sh b/t/t3452-history-split.sh
new file mode 100755
index 00000000000..d9874c61f62
--- /dev/null
+++ b/t/t3452-history-split.sh
@@ -0,0 +1,447 @@
+#!/bin/sh
+
+test_description='tests for git-history split subcommand'
+
+. ./test-lib.sh
+
+set_fake_editor () {
+	write_script fake-editor.sh <<-\EOF &&
+	echo "split-out commit" >"$1"
+	EOF
+	test_set_editor "$(pwd)"/fake-editor.sh
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
+		test_grep "cannot rearrange commit history with merges" err &&
+		test_must_fail git history split HEAD~ 2>err &&
+		test_grep "cannot rearrange commit history with merges" err
+	)
+'
+
+test_expect_success 'refuses to work with unrelated commits' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit base &&
+		git branch branch &&
+		test_commit ours &&
+		git switch branch &&
+		test_commit theirs &&
+		test_must_fail git history split ours 2>err &&
+		test_grep "split commit must be reachable from current HEAD commit" err
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
+		set_fake_editor &&
+		git history split HEAD <<-EOF &&
+		y
+		n
+		EOF
+		git symbolic-ref HEAD >actual &&
+		test_cmp expect actual &&
+
+		expect_log <<-EOF &&
+		split-me
+		split-out commit
+		initial
+		EOF
+
+		expect_tree_entries HEAD~ <<-EOF &&
+		bar
+		initial.t
+		EOF
+
+		expect_tree_entries HEAD <<-EOF
+		bar
+		foo
+		initial.t
+		EOF
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
+		set_fake_editor &&
+		git history split HEAD~ <<-EOF &&
+		y
+		n
+		EOF
+
+		expect_log <<-EOF &&
+		tip
+		root
+		split-out commit
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
+		set_fake_editor &&
+		git history split HEAD~ <<-EOF &&
+		y
+		n
+		EOF
+
+		expect_log <<-EOF &&
+		tip
+		split-me
+		split-out commit
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
+test_expect_success 'can pick multiple hunks' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		touch bar baz foo qux &&
+		git add . &&
+		git commit -m split-me &&
+
+		git history split HEAD -m "split-out commit" <<-EOF &&
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
+		git history split HEAD -m "split-out commit" <<-EOF &&
+		n
+		y
+		EOF
+
+		expect_log <<-EOF &&
+		split-me
+		split-out commit
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
+test_expect_success 'aborts with empty commit message' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		touch bar foo &&
+		git add . &&
+		git commit -m split-me &&
+
+		test_must_fail git history split HEAD -m "" <<-EOF 2>err &&
+		y
+		n
+		EOF
+		test_grep "Aborting commit due to empty commit message." err
+	)
+'
+
+test_expect_success 'can specify message via option' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		touch bar foo &&
+		git add . &&
+		git commit -m split-me &&
+
+		git history split HEAD -m "message option" <<-EOF &&
+		y
+		n
+		EOF
+
+		expect_log <<-EOF
+		split-me
+		message option
+		EOF
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
+		cp "$1" . &&
+		echo "some commit message" >>"$1"
+		EOF
+		test_set_editor "$(pwd)"/fake-editor.sh &&
+
+		git history split HEAD <<-EOF &&
+		y
+		n
+		EOF
+
+		cat >expect <<-EOF &&
+
+		# Please enter the commit message for the split-out changes. Lines starting
+		# with ${SQ}#${SQ} will be ignored.
+		# Changes to be committed:
+		#	new file:   bar
+		#
+		EOF
+		test_cmp expect COMMIT_EDITMSG &&
+
+		expect_log <<-EOF
+		split-me
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
+		git history split HEAD -m "message option" -- foo <<-EOF &&
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
+test_expect_success 'hooks are executed for rewritten commits' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		touch bar foo &&
+		git add . &&
+		git commit -m split-me &&
+		old_head=$(git rev-parse HEAD) &&
+
+		write_script .git/hooks/prepare-commit-msg <<-EOF &&
+		touch "$(pwd)/hooks.log"
+		EOF
+		write_script .git/hooks/post-commit <<-EOF &&
+		touch "$(pwd)/hooks.log"
+		EOF
+		write_script .git/hooks/post-rewrite <<-EOF &&
+		touch "$(pwd)/hooks.log"
+		EOF
+
+		set_fake_editor &&
+		git history split HEAD <<-EOF &&
+		y
+		n
+		EOF
+
+		expect_log <<-EOF &&
+		split-me
+		split-out commit
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
+		git history split HEAD -m a-only <<-EOF &&
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
+		EOF
+		git status --porcelain >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_done

-- 
2.51.1.851.g4ebd6896fd.dirty


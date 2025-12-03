Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CAD2F069E
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 10:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764758959; cv=none; b=ulEpJj33b/R2nsvSHBNZ5/4zi+k2Vgey786TTEbR4oOhV0/dzdDLcPtL6yR1mvYimaP7S9b3mQA2apd4JYHQL3wb91d/hke3yvqjq35ZDMbrQjhj/UIw0Fl1WpoIGDy1VCkPmoq7mGuGwpADexqgqeo27lqVHbHisIwOKO0hUL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764758959; c=relaxed/simple;
	bh=MWESE6JSd1u/PMqBLlPwPZIRKYjlVWybigykFesiO7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sWsJPmSllt/8uxEPB6xqWvZ9Fb/7G8Ntv6TcdPz0nUJdAOVf+Yn4tYCQ4pfhseD8PmX2afr6kK0RnlT52ryRCRqdpifxDfREfqh4qyFSTAtqQfFliC14qhUgoqDVQl3E7zEM6QX54IcplBGrBFOnXBHMtaAYlYkJFUeIOds/OMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c9oHrwrf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jD7MLLgm; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c9oHrwrf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jD7MLLgm"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 60A8F14001B8;
	Wed,  3 Dec 2025 05:49:16 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 03 Dec 2025 05:49:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764758956;
	 x=1764845356; bh=2ml+fSQbl+hqe8uPncTHp8MyQBdNzupGwQkuibbU5qQ=; b=
	c9oHrwrfqNWndUBFg1bZTyNw/5Ep30SUbrPqsk0gHIOek+INDUfEMLLnBo8piS+K
	qLu29qFhxjNkfcKueJRQQ7QOz77TZZ8k62rwVDD81Bi0F+Gm6YuY28S9bqP7ukgL
	xczCx1IYGsm+2kkwLN24BpCI91UyJ+nLR+yh6sta45+r1ULEFPwrRv80l2Xmll48
	MpvLIyC9owpgEasQtfpfo/EE2eJvb7i1zYWWDwONM3EOXGd/hQjNUekchK6fy6iV
	d9KpoQNqQ8TUtWRQ/J6eYhLlTUkxSweFbr5KHMv5sZ+16RYseCISqSwYgF1xcxYO
	pbLFarK6YQjMKhyONW699g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764758956; x=
	1764845356; bh=2ml+fSQbl+hqe8uPncTHp8MyQBdNzupGwQkuibbU5qQ=; b=j
	D7MLLgmv5+97/y3CPLIUgEccKsTbcuBO2/EEo3ua6JbrY/VaCVor0lpMZcMZ0Z0q
	r3BrljqWAo2GLU1tBn6f5hsbknLV2h4wD5HwGLgH/RVntx7A50jqOXNKgrZxB/Xs
	N3w0K0An5hdEbX1el5TvaGkRtNLmArogV0qsllCzRmP7RoEjT7ia2whT6CK1e+/A
	6+eU6V7l2bUpU5yb9I31Lw5dlbpAprzHuOomr0LyW7TFgRk+2Vlu6QJ2GdCZ4uq+
	OutGseIVR8h71hruZDG6Wf3wjdrqtOLCnCFOuodloXbve5ZBRR9kNjjMhD9TJbA4
	or+JiLNfjAiBrQ1ohGJhQ==
X-ME-Sender: <xms:rBUwaQUI_1BL5iFkvLuxo5euTd_snxoxw4_E3ZpMXFsbm4UiLOfxNA>
    <xme:rBUwaXLIGovvxpLj2jlqJBXZNn5PRzz_eGyXZmQ6jfnsI3HF_PA6_XVxFNZvsxzVA
    EnibLLT4ld083lzuw3ycK_eHSTfMkqyFtmD3sFzBb9WSIGMULgEJw>
X-ME-Received: <xmr:rBUwaYCZs3Yt9N5ST3Ho6BfPHuSyvPfI3VBnoclOv2GlY-vQ3OD-SH81BAmjc7cWA11CgGNpsvxqatK6SJVy5T7o3Tfzu3x1IOllEPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucev
    lhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhr
    tghpthhtohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepkh
    grrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:rBUwafcQ7nXA23goslnvATht78_7H4Lkz80ANeO3thQcF2vZMjVNnA>
    <xmx:rBUwaf1Sz3A-Xt6IyQskDIs6Kg0n-Yl5R7mu7vbwqwwGkElZJyFlJA>
    <xmx:rBUwaehZs0XE2AxDD21Nxb2tVU4oijBMzFUt9VuG5m3yD4t1DBLVPg>
    <xmx:rBUwaQm0CqsnZTTApv9nD7Z2hRAadRdaxQTdYCi_DE8prxB-55nk2Q>
    <xmx:rBUwaVBxyU8wEkuiI6RLVx3HTp8wZCfiWBd5mPoyrTq6F7Qy8LX8_edo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Dec 2025 05:49:14 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cf4b3aa5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Dec 2025 10:49:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 03 Dec 2025 11:48:39 +0100
Subject: [PATCH v7 12/12] builtin/history: implement "split" subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-b4-pks-history-builtin-v7-12-9e9f849bfd0e@pks.im>
References: <20251203-b4-pks-history-builtin-v7-0-9e9f849bfd0e@pks.im>
In-Reply-To: <20251203-b4-pks-history-builtin-v7-0-9e9f849bfd0e@pks.im>
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
 builtin/history.c              | 174 ++++++++++++++++
 t/meson.build                  |   1 +
 t/t3452-history-split.sh       | 452 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 689 insertions(+)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index 160bf5d4d2..f1252baa2f 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [synopsis]
 git history reword <commit>
+git history split <commit> [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -37,11 +38,72 @@ Several commands are available to rewrite history in different ways:
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
 CONFIGURATION
 -------------
 
 include::includes/cmd-config-section-all.adoc[]
 
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
index 17bb150b95..c5262d964a 100644
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
 
 #define GIT_HISTORY_REWORD_USAGE N_("git history reword <commit>")
+#define GIT_HISTORY_SPLIT_USAGE  N_("git history split <commit> [--] [<pathspec>...]")
 
 static int collect_commits(struct repository *repo,
 			   struct commit *old_commit,
@@ -364,6 +370,172 @@ static int cmd_history_reword(int argc,
 	return ret;
 }
 
+static int split_commit(struct repository *repo,
+			struct commit *original_commit,
+			struct pathspec *pathspec,
+			struct object_id *out)
+{
+	struct interactive_options interactive_opts = INTERACTIVE_OPTIONS_INIT;
+	struct strbuf index_file = STRBUF_INIT;
+	struct child_process read_tree_cmd = CHILD_PROCESS_INIT;
+	struct index_state index = INDEX_STATE_INIT(repo);
+	struct object_id original_commit_tree_oid, parent_tree_oid;
+	char original_commit_oid[GIT_MAX_HEXSZ + 1];
+	struct commit_list *parents = NULL;
+	struct commit *first_commit;
+	struct tree *split_tree;
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
+	/*
+	 * The first commit is constructed from the split-out tree. The base
+	 * that shall be diffed against is the parent of the original commit.
+	 */
+	ret = commit_tree_with_edited_message(repo, "split-out", original_commit,
+					      &split_tree->object.oid,
+					      original_commit->parents, &parent_tree_oid, &out[0]);
+	if (ret < 0) {
+		ret = error(_("failed writing split-out commit"));
+		goto out;
+	}
+
+	/*
+	* The second commit is constructed from the original tree. The base to
+	* diff against and the parent in this case is the first split-out
+	* commit.
+	*/
+	first_commit = lookup_commit_reference(repo, &out[0]);
+	commit_list_append(first_commit, &parents);
+
+	ret = commit_tree_with_edited_message(repo, "split-out", original_commit,
+					      &original_commit_tree_oid,
+					      parents, get_commit_tree_oid(first_commit), &out[1]);
+	if (ret < 0) {
+		ret = error(_("failed writing split-out commit"));
+		goto out;
+	}
+
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
+	struct option options[] = {
+		OPT_END(),
+	};
+	struct commit *original_commit, *parent, *head;
+	struct strvec commits = STRVEC_INIT;
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
+	parse_pathspec(&pathspec, 0,
+		PATHSPEC_PREFER_FULL | PATHSPEC_SYMLINK_LEADING_PATH | PATHSPEC_PREFIX_ORIGIN,
+		prefix, argv + 1);
+
+	ret = gather_commits_between_head_and_revision(repo, argv[0], &original_commit,
+						       &parent, &head, &commits);
+	if (ret < 0)
+		goto out;
+
+	/*
+	 * Then we split up the commit and replace the original commit with the
+	 * new ones.
+	 */
+	ret = split_commit(repo, original_commit, &pathspec, split_commits);
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
+	clear_pathspec(&pathspec);
+	strvec_clear(&commits);
+	return ret;
+}
+
 int cmd_history(int argc,
 		const char **argv,
 		const char *prefix,
@@ -371,11 +543,13 @@ int cmd_history(int argc,
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
index e187aef31e..1eef433207 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -388,6 +388,7 @@ integration_tests = [
   't3438-rebase-broken-files.sh',
   't3450-history.sh',
   't3451-history-reword.sh',
+  't3452-history-split.sh',
   't3500-cherry.sh',
   't3501-revert-cherry-pick.sh',
   't3502-cherry-pick-merge.sh',
diff --git a/t/t3452-history-split.sh b/t/t3452-history-split.sh
new file mode 100755
index 0000000000..02ae86a7e6
--- /dev/null
+++ b/t/t3452-history-split.sh
@@ -0,0 +1,452 @@
+#!/bin/sh
+
+test_description='tests for git-history split subcommand'
+
+. ./test-lib.sh
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
+		test_grep "commit must be reachable from current HEAD commit" err
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
+			touch "$ORIG_PATH/hooks.log
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
2.52.0.239.gd5f0c6e74e.dirty


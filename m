Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5822A2DEA7E
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756057459; cv=none; b=LjlYcsIz6NZ41UqDVwvUQGRZAbOOPnjAJ+Qdb0lvjFhnT7JfAJimwgBgPIQDGA6fAygYzdfYF3464LgG7QaG//C/HbvQVCfxIIrdTAipYm96n2PZ6b7Q/0kW16d5pCltrRpMu5eLXh537/tRCHhIA0HHSHqeoU1cIP0oPHI0Kj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756057459; c=relaxed/simple;
	bh=lOIE/QHFpy1GimlvBvZGsV3/i/7kpd1rOED1ktf4pK0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X6C4AFzXXwALiCXwf9JVC0e0oTu1nAjK0XIfsPzpl2To7ytSuZ7UDEaMh7OkPvxOdBrL9GOxrZSxHUZElLz1u6ZFiVkEY5B0io+c3WIzTqQRO4O5Nizcf3sqnQGByiGZYLjeNAZh4vaDc9/xQhF3Ay8dXr6EyH900u24cr4fqHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dzBmgiG1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hmqof7vN; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dzBmgiG1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hmqof7vN"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 87FC71D000A0;
	Sun, 24 Aug 2025 13:44:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 24 Aug 2025 13:44:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756057456;
	 x=1756143856; bh=FpYKwNEm1FkTudpTcuTq6NyDW1m1i1r8PktdeR+ADXE=; b=
	dzBmgiG1MJT5gSgdacyJx6oXYTZSuUrZar7n6ZNM+jMSiJzV50MOkzF2dkOFAlrB
	hTNxgDsFl4FOKksy9WIdqBED/LIv+LAViYIKRcjzd1GsmsW4yt6ai0Tpj0Ak+cCs
	tW4veknY4l81T63nN0VZDbkpE++XsAVdD9szXSHsA52Ab0b/qZP0txmM7SdfeDs5
	4vFZBExI9rROjwiwiZ/Jhsh9BPo9/BJa5H212YBKgxePjbTv6Vuh/WFK6ZYLVYJ8
	+gSZ4QFLYX6QJPJQLEZUQLln/0r3kXDi9MfZB67GCxqG1FG/xre/SL3PfP1LtZyu
	6ynWgDspmDvs5NoVXWsS5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1756057456; x=
	1756143856; bh=FpYKwNEm1FkTudpTcuTq6NyDW1m1i1r8PktdeR+ADXE=; b=H
	mqof7vNPZi4WO2m/7EjMo89phN6tqk0dXKjWDaKnmNETszZBNG1K0YNueOS79Ly5
	9XhvKfJ1Q/ZY2KR/+nDE96o2sajAobL5tNQ/ya5NB9lOG9Ys49ibosqvtrag2Maf
	C5jUAscAnkh3jtYJkzTO7mc2LKyAAcO1frHLfc82sAlAClv9ZHxT74X4j7taPUTJ
	L29BUO7p6MHBmbOtC0DZTl0gXQzHTyH2c4uRdwkxTLNuAKePHk4zcHWnyjN/dXse
	jxXl7+MeHt/6aZK1Hf431GtAFc78r8mR8PABss58EiX8bN6aaerbn85Ia4OchIyF
	nATxhEILRh+P60zaULRtQ==
X-ME-Sender: <xms:cE-raFyNiN8Zkz3rj-RoZhK9H84h5gzOK4X47qoWp4GXxcaiegTIIQ>
    <xme:cE-raC20OODdHZ_bA1-BzsX-rX2pWB9URLM8lszxpNS1Tj2alX_3RghHHii__S5JZ
    QBzxuSP7CnuCyvl5Q>
X-ME-Received: <xmr:cE-raFyTMBilcZoJ2Rkc8kX-5cuXAiSdzX7s2Ojb0gMDvOT4a4_t20kXrtGX6nI2OP0wCeTU_A2qLs13KJv4HlPRkLx8N95ppKUpLu1o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedtudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnvh
    honhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrse
    hfrhgvvgdrfhhrpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtthhopegsvg
    hnrdhknhhosghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:cE-raJE6mNmGwwM7KhurBoL-TTXahaNHpMRVS4N_AP7WH7Wp1bjBBg>
    <xmx:cE-raIaVaHj9JRBpwJodAkmcUb5WQm6uKF3u_u938iYYd3ds2S8mQA>
    <xmx:cE-raLBpQLpmRKRh6yvHToEtrRUclqBmWZ6Smj2giddR4ofqoaqlkg>
    <xmx:cE-raAkbCsnTFclf1ZzMfKMjIuOrEW3jZq_uOwLRF5pj3EgFBc3MdQ>
    <xmx:cE-raItINQHoHDw2PKy1EZrkBGgvIda4E0p1cCRFrUlNAvIu1gbeuj_0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Aug 2025 13:44:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id debb3904 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 24 Aug 2025 17:44:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sun, 24 Aug 2025 19:42:28 +0200
Subject: [PATCH RFC v2 15/16] builtin/history: implement "split" subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250824-b4-pks-history-builtin-v2-15-964ac12f65bd@pks.im>
References: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
In-Reply-To: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.2

It is quite a common use case that one wants to split up one commit into
multiple commits by moving parts of the changes of the original commit
out of it into a separate commit. This is quite an involved operation
though:

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
 Documentation/git-history.adoc |  60 +++++++
 builtin/history.c              | 291 +++++++++++++++++++++++++++++++
 t/meson.build                  |   1 +
 t/t3453-history-split.sh       | 387 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 739 insertions(+)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index b36cd925dd..6f0c64b90e 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -13,6 +13,7 @@ git history continue
 git history quit
 git history drop <commit>
 git history reorder <commit> (--before=<following-commit>|--after=<preceding-commit>)
+git history split [<options>] <commit> [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -52,6 +53,26 @@ child commits, as that would lead to an empty branch.
 	be related to one another and must be reachable from the current `HEAD`
 	commit.
 
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
 The following commands are used to manage an interrupted history-rewriting
 operation:
 
@@ -111,6 +132,45 @@ f44a46e third
 bf7438d first
 ----------
 
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
+
 CONFIGURATION
 -------------
 
diff --git a/builtin/history.c b/builtin/history.c
index 16b516856e..6d3f44152c 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -1,17 +1,27 @@
+/* Required for `comment_line_str`. */
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "builtin.h"
 #include "branch.h"
+#include "cache-tree.h"
 #include "commit.h"
 #include "commit-reach.h"
 #include "config.h"
+#include "editor.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "object-name.h"
 #include "parse-options.h"
+#include "path.h"
+#include "pathspec.h"
+#include "read-cache-ll.h"
 #include "refs.h"
 #include "reset.h"
 #include "revision.h"
+#include "run-command.h"
 #include "sequencer.h"
+#include "sparse-index.h"
 
 static int cmd_history_abort(int argc,
 			     const char **argv,
@@ -517,6 +527,285 @@ static int cmd_history_reorder(int argc,
 	return ret;
 }
 
+static void change_data_free(void *util, const char *str UNUSED)
+{
+	struct wt_status_change_data *d = util;
+	free(d->rename_source);
+	free(d);
+}
+
+static int fill_commit_message(struct repository *repo,
+			       const struct object_id *old_tree,
+			       const struct object_id *new_tree,
+			       const char *default_message,
+			       const char *provided_message,
+			       const char *action,
+			       struct strbuf *out)
+{
+	if (!provided_message) {
+		struct wt_status s;
+		const char *path = git_path_commit_editmsg();
+		const char *hint =
+			_("Please enter the commit message for the %s changes. Lines starting\n"
+			  "with '%s' will be kept; you may remove them yourself if you want to.\n");
+
+		strbuf_addstr(out, default_message);
+		strbuf_addch(out, '\n');
+		strbuf_commented_addf(out, comment_line_str, hint, action, comment_line_str);
+		write_file_buf(path, out->buf, out->len);
+
+		wt_status_prepare(repo, &s);
+		FREE_AND_NULL(s.branch);
+		s.ahead_behind_flags = AHEAD_BEHIND_QUICK;
+		s.commit_template = 1;
+		s.colopts = 0;
+		s.display_comment_prefix = 1;
+		s.hints = 0;
+		s.use_color = 0;
+		s.whence = FROM_COMMIT;
+		s.committable = 1;
+
+		s.fp = fopen(git_path_commit_editmsg(), "a");
+		if (!s.fp)
+			return error_errno(_("could not open '%s'"), git_path_commit_editmsg());
+
+		wt_status_collect_changes_trees(&s, old_tree, new_tree);
+		wt_status_print(&s);
+		wt_status_collect_free_buffers(&s);
+		string_list_clear_func(&s.change, change_data_free);
+
+		strbuf_reset(out);
+		if (launch_editor(path, out, NULL)) {
+			fprintf(stderr, _("Please supply the message using either -m or -F option.\n"));
+			return -1;
+		}
+		strbuf_stripspace(out, comment_line_str);
+
+	} else {
+		strbuf_addstr(out, provided_message);
+	}
+
+	cleanup_message(out, COMMIT_MSG_CLEANUP_ALL, 0);
+
+	if (!out->len) {
+		fprintf(stderr, _("Aborting commit due to empty commit message.\n"));
+		return -1;
+	}
+
+	return 0;
+}
+
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
+	 * Construct the first commit. This is done by taking the original
+	 * commit parent's tree and selectively patching changes from the diff
+	 * between that parent and its child.
+	 */
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
+	 * We disallow the cases where either the split-out commit or the
+	 * original commit would become empty. Consequently, if we see that the
+	 * new tree ID matches either of those trees we abort.
+	 */
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
+	 * The second commit is much simpler to construct, as we can simply use
+	 * the original commit details, except that we adjust its parent to be
+	 * the newly split-out commit.
+	 */
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
+		N_("git history split [<options>] <commit>"),
+		NULL,
+	};
+	const char *commit_message = NULL;
+	struct option options[] = {
+		OPT_STRING('m', "message", &commit_message, N_("message"), N_("commit message")),
+		OPT_END(),
+	};
+	struct commit *original_commit, *head;
+	struct strvec commits = STRVEC_INIT;
+	struct commit_list *list = NULL;
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
+	if (original_commit->parents && original_commit->parents->next) {
+		ret = error(_("commit to be split must not be a merge commit"));
+		goto out;
+	}
+
+	head = lookup_commit_reference_by_name("HEAD");
+	if (!head) {
+		ret = error(_("could not resolve HEAD to a commit"));
+		goto out;
+	}
+
+	commit_list_append(original_commit, &list);
+	if (!repo_is_descendant_of(repo, original_commit, list)) {
+		ret = error (_("split commit must be reachable from current HEAD commit"));
+		goto out;
+	}
+
+	parse_pathspec(&pathspec, 0,
+		       PATHSPEC_PREFER_FULL | PATHSPEC_SYMLINK_LEADING_PATH | PATHSPEC_PREFIX_ORIGIN,
+		       prefix, argv + 1);
+
+	/*
+	 * Collect the list of commits that we'll have to reapply now already.
+	 * This ensures that we'll abort early on in case the range of commits
+	 * contains merges, which we do not yet handle.
+	 */
+	ret = collect_commits(repo, original_commit->parents ? original_commit->parents->item : NULL,
+			      head, &commits);
+	if (ret < 0)
+		goto out;
+
+	/*
+	 * Then we split up the commit and replace the original commit with the
+	 * new new ones.
+	 */
+	ret = split_commit(repo, original_commit, &pathspec,
+			   commit_message, split_commits);
+	if (ret < 0)
+		goto out;
+
+	replace_commits(&commits, &original_commit->object.oid,
+			split_commits, ARRAY_SIZE(split_commits));
+
+	ret = apply_commits(repo, &commits, head, original_commit, "split");
+	if (ret < 0)
+		goto out;
+
+	ret = 0;
+
+out:
+	clear_pathspec(&pathspec);
+	strvec_clear(&commits);
+	free_commit_list(list);
+	return ret;
+}
+
 int cmd_history(int argc,
 		const char **argv,
 		const char *prefix,
@@ -528,6 +817,7 @@ int cmd_history(int argc,
 		N_("git history quit"),
 		N_("git history drop <commit>"),
 		N_("git history reorder <commit> (--before=<following-commit>|--after=<preceding-commit>)"),
+		N_("git history split [<options>] <commit> [--] [<pathspec>...]"),
 		NULL,
 	};
 	parse_opt_subcommand_fn *fn = NULL;
@@ -537,6 +827,7 @@ int cmd_history(int argc,
 		OPT_SUBCOMMAND("quit", &fn, cmd_history_quit),
 		OPT_SUBCOMMAND("drop", &fn, cmd_history_drop),
 		OPT_SUBCOMMAND("reorder", &fn, cmd_history_reorder),
+		OPT_SUBCOMMAND("split", &fn, cmd_history_split),
 		OPT_END(),
 	};
 
diff --git a/t/meson.build b/t/meson.build
index 2bf7bcab5a..b3d33c8588 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -379,6 +379,7 @@ integration_tests = [
   't3450-history.sh',
   't3451-history-drop.sh',
   't3452-history-reorder.sh',
+  't3453-history-split.sh',
   't3500-cherry.sh',
   't3501-revert-cherry-pick.sh',
   't3502-cherry-pick-merge.sh',
diff --git a/t/t3453-history-split.sh b/t/t3453-history-split.sh
new file mode 100755
index 0000000000..b053fc2f29
--- /dev/null
+++ b/t/t3453-history-split.sh
@@ -0,0 +1,387 @@
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
+		test_grep "commit to be split must not be a merge commit" err &&
+		test_must_fail git history split HEAD~ 2>err &&
+		test_grep "cannot rearrange commit history with merges" err
+	)
+'
+
+test_expect_success 'refuses to work with changes in the worktree or index' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		touch bar foo &&
+		git add . &&
+		git commit -m split-me &&
+
+		echo changed >bar &&
+		test_must_fail git history split -m message HEAD 2>err <<-EOF &&
+		y
+		n
+		EOF
+		test_grep "Your local changes to the following files would be overwritten" err &&
+
+		git add bar &&
+		test_must_fail git history split -m message HEAD 2>err <<-EOF &&
+		y
+		n
+		EOF
+		test_grep "Your local changes to the following files would be overwritten" err
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
+		# with ${SQ}#${SQ} will be kept; you may remove them yourself if you want to.
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
+test_done

-- 
2.51.0.308.g032396e0da.dirty


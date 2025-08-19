Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EBF322C87
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 10:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755601000; cv=none; b=A0ZDV+kKdEbpd2c9c5W6e/XV7uZkpevDjE7Lt/NzdeCA5OXR8mSry67wvW1+PrUZnR+sjB5i3/stcPZAHxdQ3W/DQqbawgT9di2I9HqdCfXT0hTpHmxfCBNXxtUj/S5O1N5o2mOpIBuluyDqTna+1qsLtcWAEfiMmnOZ4FKZXms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755601000; c=relaxed/simple;
	bh=HgrNhxLaYwcGWV3E1icqvgn92QE3/unozSsckEREWwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PxIVuhocRDJ5PQReGwfPW6R5o4tLCj92Hz+BmWbxai31ULz85PqU2xW+AmeqlxzldSOozng+gqUfVer9ZTT5rXP1vCGGb9CDsH/TETvW4ulxMxO2Qn0GU8Qq2O+uJeZbNn0Udh5OLGVspeoazVsyOV7IiK6WYYUSWzDT5ENqa+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RFnIG9ME; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JAS9LuQ7; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RFnIG9ME";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JAS9LuQ7"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id D58A51D0020B
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 06:56:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 19 Aug 2025 06:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755600996;
	 x=1755687396; bh=oRURUad+u9sLaUT3OAa8BI3yn8GnH2fb86lguw5pZRk=; b=
	RFnIG9MEUmWaeltH5dUTK/mu+6gL+mjQz55uwkFlGNaQ2HQKhVXxxWEBkPuETM8Y
	aE+TIwssZEZhH8RBo1GqaLYM5ucsH5eEA19+hrhhYmvrb4Q58m+7U2Y3EtaNKxEB
	aYmjlqYT3VHwS5HXx+GR24fV0FG/PMWaAaIMkL2NqKZZNt7MWkspTvxR8UG9RH56
	ZKKJN+aIVndkB4cthFGgHKBkzDw4CI7398mbvIV0Y3vhjPcgMl4LCR6VCQS/o8Ci
	z0cPBMHPwXHPIX/fGYmMZBx0WUae28jJ056l2a/yobpIgoDT98aEO1qK4Kl8fDR1
	ulYSH8hm0XdC9W/h0+bZWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755600996; x=
	1755687396; bh=oRURUad+u9sLaUT3OAa8BI3yn8GnH2fb86lguw5pZRk=; b=J
	AS9LuQ71xJTF7elXshIr5Pr5o9MlRSRxK5ylDHUTNOfFcWISdjyv1XMtmUtcMeqx
	LfUU9dyBEWm3BbZtX4LdQwRK09wFRBkYPO85WnXVg5FW+PT3Lq0WfjxlbkohgfPe
	apL68f9L8l5Mh9kFXL0vSKy5F/iJXJsq9/ZG5GVNKM1pVzPE3sYchJqSp9MUt9r4
	hWTOMlK+RjP/MozvUWQ4AWBWSZtYxN4sCymH6sfh9njVPYoQAO/lNM+4EuakndMF
	n87kQD/X/1yAeTMXywFh2o49YxctmJq17+1K/coJAK9RG9pNBD4jUlJj960Eh/aq
	1DaXcHk6Um8WRwqQqhN1g==
X-ME-Sender: <xms:ZFikaASGGI3osRLtUGzDmRG4l7PM8DkFOn8_7AUI0YnLhDdslmdQJg>
    <xme:ZFikaPwSq5tbKtV77urSB113gdypwK418GJgZ6-ZcwbsN0y9WP39TG65NBgCs4pwe
    azC8z2mzFSZeU16oQ>
X-ME-Received: <xmr:ZFikaHP-qmveaOgUZpZ8t39VHwx91a2KY8mtbeSgzvC2_exdmOYHTZ8XNjzd856300GY3kNjnLSsbwpEZ80rRvCYBxxU6INd_E_n6oHUV4Pq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheehfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:ZFikaGOekmWh6_Ws7YOpaOtsGKhgw_TJ97D9OR7LyZIg9V3iMUsYYg>
    <xmx:ZFikaBRPqZgMU_7cFZaWdvDTAVNrSgsAmSyVnjG3CtE0U3QWynVwSQ>
    <xmx:ZFikaACtkWrrM5tc4zIfBbVxpNSkUhQ2JooAMXpsm90JFv4Iyt3h2Q>
    <xmx:ZFikaIhICJZwIhb8rZ1bqy9QjpEjbPOQVd38kFRJlaFWV9YVXWwazQ>
    <xmx:ZFikaBIifqbeSUs63RybIeUOcYgwFvBjhBYSGy17KUy8g-fJDRLwiQZD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 19 Aug 2025 06:56:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6aa2fbc5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 19 Aug 2025 10:56:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Aug 2025 12:56:07 +0200
Subject: [PATCH RFC 11/11] builtin/history: implement "split" subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-b4-pks-history-builtin-v1-11-9b77c32688fe@pks.im>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
In-Reply-To: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
To: git@vger.kernel.org
Cc: 
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
 Documentation/git-history.adoc |  59 ++++++++
 builtin/history.c              | 245 +++++++++++++++++++++++++++++++++
 t/meson.build                  |   1 +
 t/t3452-history-split.sh       | 304 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 609 insertions(+)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index 6e8b4e1326..f0f1f2a093 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -10,6 +10,7 @@ SYNOPSIS
 [synopsis]
 git history drop [<options>] <revision>
 git history reorder [<options>] <revision> --(before|after)=<revision>
+git history split [<options>] <revision> [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -47,6 +48,26 @@ reorder <revision> (--before=<revision>|--after=<revision>)::
 	commit. The commits must be related to one another and must be
 	reachable from the current `HEAD` commit.
 
+split <revision> [--message=<message>] [--] [<pathspec>...]::
+	Interactively split up the commit into two commits by choosing
+	hunks introduced by it that will be moved into the new split-out
+	commit. These hunks will then be written into a new commit that
+	becomes the parent of the previous commit. The original commit
+	stays intact, except that its parent will be the newly split-out
+	commit.
++
+The commit message of the new commit will be asked for by launching the
+configured editor. Authorship of the commit will be the same as for the
+original commit.
++
+If passed, _<pathspec>_ can be used to limit which changes shall be split out
+of the original commit. Files not matching any of the pathspecs will remain
+part of the original commit. For more details about the _<pathspec>_ syntax,
+see the 'pathspec' entry.
++
+It is invalid to select either all or no hunks, as that would lead to
+one of the commits becoming empty.
+
 EXAMPLES
 --------
 
@@ -88,6 +109,44 @@ f44a46e third
 bf7438d first
 ----------
 
+* Split a commit.
++
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
index de6073f557..b2dab826ac 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -1,16 +1,26 @@
+/* Required for `comment_line_str`. */
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "builtin.h"
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
 
 static int collect_commits(struct repository *repo,
 			   struct commit *old_commit,
@@ -424,6 +434,239 @@ static int cmd_history_reorder(int argc,
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
+	char *split_message_path = NULL, *original_author = NULL;
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
+	/*
+	 * But we do ask the user for a new commit message. This is in contrast
+	 * to the second commit, where we'll retain the original commit
+	 * message.
+	 */
+	if (!commit_message) {
+		split_message_path = repo_git_path(repo, "SPLIT_MSG");
+		strbuf_addch(&split_message, '\n');
+		strbuf_commented_addf(&split_message, comment_line_str,
+				      _("Please enter a commit message for the split-out changes."));
+		write_file_buf(split_message_path, split_message.buf, split_message.len);
+
+		strbuf_reset(&split_message);
+		if (launch_editor(split_message_path, &split_message, NULL)) {
+			fprintf(stderr, _("Please supply the message using either -m or -F option.\n"));
+			ret = -1;
+			goto out;
+		}
+		strbuf_stripspace(&split_message, comment_line_str);
+	} else {
+		strbuf_addstr(&split_message, commit_message);
+	}
+	cleanup_message(&split_message, COMMIT_MSG_CLEANUP_ALL, 0);
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
+	free(split_message_path);
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
+		N_("git history split [<options>] <revision>"),
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
+	/*
+	 * And now we pick commits in the new order on top of either the root
+	 * commit or on top the old commit's parent.
+	 */
+	ret = apply_commits(repo, &commits, head,
+			    original_commit->parents ? original_commit->parents->item : NULL,
+			    "split");
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
@@ -432,12 +675,14 @@ int cmd_history(int argc,
 	const char * const usage[] = {
 		N_("git history drop [<options>] <revision>"),
 		N_("git history reorder [<options>] <revision> --(before|after)=<revision>"),
+		N_("git history split [<options>] <revision> [--] [<pathspec>...]"),
 		NULL,
 	};
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
 		OPT_SUBCOMMAND("drop", &fn, cmd_history_drop),
 		OPT_SUBCOMMAND("reorder", &fn, cmd_history_reorder),
+		OPT_SUBCOMMAND("split", &fn, cmd_history_split),
 		OPT_END(),
 	};
 
diff --git a/t/meson.build b/t/meson.build
index 8eded9ec1b..80beac8c1f 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -378,6 +378,7 @@ integration_tests = [
   't3438-rebase-broken-files.sh',
   't3450-history-drop.sh',
   't3451-history-reorder.sh',
+  't3452-history-split.sh',
   't3500-cherry.sh',
   't3501-revert-cherry-pick.sh',
   't3502-cherry-pick-merge.sh',
diff --git a/t/t3452-history-split.sh b/t/t3452-history-split.sh
new file mode 100755
index 0000000000..bc965b15b2
--- /dev/null
+++ b/t/t3452-history-split.sh
@@ -0,0 +1,304 @@
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
+		set_fake_editor &&
+		git history split HEAD <<-EOF &&
+		y
+		n
+		EOF
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
2.51.0.261.g7ce5a0a67e.dirty


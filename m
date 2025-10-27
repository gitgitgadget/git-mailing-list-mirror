Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FDF2FA0C7
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 11:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761564880; cv=none; b=BfjJffvSnacpMFBVOX2Tt2p0uxZ4fz4oiAz0WrvRn9PWKmrof+STNxY1UKPFAjhJIlp27nKq5ItL77eTY2q+LZ+bh9TgMDdSZKiDnV0gHWqVkpOlvR3t8IQK4MCqnhYEqh+cSpCHR4jfUMSNlilxB7AksprcbBXa7MLvaTF8XRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761564880; c=relaxed/simple;
	bh=UWmmA6vJ+q+U807f1MNMH0zOTdCaXdVLf2whhrmdPqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ga1TH5Vn8NIoXlrypjkgTKo3rg76A5VnL+SI+XBSxhSc0NuKcrEmXs58ukgaOMjycYC5BjljQ0zaAEBxisQgYDy3fIr5YhU2v6qDnlgGG9qHvIjaFQ5UzQJl2pjNQ9bhJM6BDKdbnXKdCjKavsZd7oEu8JorIy2Imr3BgVB6rbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pMrkzPFM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wRDsYNYO; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pMrkzPFM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wRDsYNYO"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 34AA014002EA;
	Mon, 27 Oct 2025 07:34:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 27 Oct 2025 07:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761564877;
	 x=1761651277; bh=TAKJG2ngeSzAPWNpsCfBzKelKgNOWzsAiH1Qs12Bmtg=; b=
	pMrkzPFMuW2ekBSO04im7tEWZ8gMHZqNlAaetM+uZ02ILMdzfi4BcaHXYd9tbeek
	C3HWoKw5WG7QXLdpYL2kNjGfe2Ej5LbYFMbPEO7qeokTTdtZ3vLmLSd25c6Sq69h
	+oKSOOo1geQBc/zJmfLYH+HJqJNkk8VPZcF33roA59RDL96bm9c1XICuS9gfG5h7
	iRE5xDlazEArJZA3PjvULsmNvI3NddwTb+ooPbNrjCNa6n08P3KPiFQwgwlKEoVW
	pltbWzOkEgySGZ+Jzq3gt7c6KnMBmLqwu58euaoFNSP1/Zsp7gDcfkyYEM6MDLR3
	DuPy7SxTBQ3uaDOljboCNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761564877; x=
	1761651277; bh=TAKJG2ngeSzAPWNpsCfBzKelKgNOWzsAiH1Qs12Bmtg=; b=w
	RDsYNYO1jSIEuERh+rRV6w464oTqXHmZQ0Su8SWQosDj3k5QjiNUA0wWu+pAtTcy
	Vl8wMbcJpRgm9Cq0UK7BZI/1XBye/WfBOnUe8W495vG2q1St0HfPeN9BakaVlZ7I
	zi70+74oDLWCVDXorUC6mlpM+XrcqxQ/sFGdhEVnA2RQnAzfCVwaBqlVhyJoBfSO
	srTWL49zNft96aO2pq3dhRtp5mgyg4Ob6Hi8iFSv3cTh6eiJFBOZvFJ3skN4VPME
	PwwwXYuIVcTzVHdA9H5v9X2UcVAV142vu0Ycmb2RYEH/Q48cPOHx+v79l5o+5T8I
	SNioRyCfeHVeD+KeKaZQw==
X-ME-Sender: <xms:zFj_aHfp1XaluqPsEDsB0UqmiN6AoYMBE7im4RdTag0n3rQ6kiTIbQ>
    <xme:zFj_aPwxPWccA6SyoCZNSptvDBDOjAIXUkWsqvDd5Mtcz5KU7yoStqXADHrQhioiX
    jCBrKb9RLAAuHR1rJtvm1lAALJd9Nr2eDCNSiRTxWJHfSpDhnhzog>
X-ME-Received: <xmr:zFj_aEKFZBNSArC0K7DQRbfdlfNlKceXyqPd_fibNzzIaH_k0TAttOznHtJwdv5H4kjnoMfewQ5koHV5bu4Y0UzO8L5z1-3YbDICXmihEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghi
    lhdrtghomhdprhgtphhtthhopehmrghrthhinhhvohhniiesghhmrghilhdrtghomhdprh
    gtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehsohhrghgr
    nhhovhesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtoh
    hm
X-ME-Proxy: <xmx:zFj_aJG-6rM0FTdwNO39AaevaMqTpcHPUykuFPfr1X8oX7--EbsgNQ>
    <xmx:zVj_aI-ZVW-sXENV1rGvjwBLANuhWCopNKHu5unmRCs29zZXNZczsA>
    <xmx:zVj_aBKS3vJcsnb4PcasZXv8sq4UUEDGZApefzQ5PfsG7gZ24JzWNw>
    <xmx:zVj_aOtZn23pkCUwryzAZiBupAHljaWvu2y8HlTD9RcQQe2qPziRLA>
    <xmx:zVj_aOodnDew57LAtk1V620v0MXwUX4VCaSEomo4wDTCmWyvog4Bk8uE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 07:34:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 43ee7bdb (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 27 Oct 2025 11:34:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 27 Oct 2025 12:33:59 +0100
Subject: [PATCH v6 11/11] builtin/history: implement "split" subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-b4-pks-history-builtin-v6-11-407dd3f57ad3@pks.im>
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
In-Reply-To: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
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
 builtin/history.c              | 218 +++++++++++++++++++++
 t/meson.build                  |   1 +
 t/t3452-history-split.sh       | 432 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 713 insertions(+)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index bd903875120..3d6b2665f8d 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [synopsis]
 git history reword <commit>
+git history split <commit> [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -37,6 +38,26 @@ Several commands are available to rewrite history in different ways:
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
+The commit message of the new commit will be asked for by launching the
+configured editor. Authorship of the commit will be the same as for the
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
 
@@ -44,6 +65,47 @@ include::includes/cmd-config-section-all.adoc[]
 
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
index cb251ae2e01..cae841707d0 100644
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
@@ -323,6 +329,216 @@ static int cmd_history_reword(int argc,
 	return ret;
 }
 
+static int split_commit(struct repository *repo,
+			struct commit *original_commit,
+			struct pathspec *pathspec,
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
+				  "", "split-out", &split_message);
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
+	struct option options[] = {
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
@@ -330,11 +546,13 @@ int cmd_history(int argc,
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
index 00000000000..2aac28afdf0
--- /dev/null
+++ b/t/t3452-history-split.sh
@@ -0,0 +1,432 @@
+#!/bin/sh
+
+test_description='tests for git-history split subcommand'
+
+. ./test-lib.sh
+
+set_fake_editor () {
+	write_script fake-editor.sh <<-EOF &&
+	echo "$@" >"\$1"
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
+		set_fake_editor "split-out commit" &&
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
+		set_fake_editor "split-out commit" &&
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
+		set_fake_editor "split-out commit" &&
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
+		set_fake_editor "split-out-commit" &&
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
+		set_fake_editor "split-out commit" &&
+		git history split HEAD <<-EOF &&
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
+		set_fake_editor "split-out commit" &&
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
+		set_fake_editor "split-out commit" &&
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
+		set_fake_editor "a-only" &&
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
+		EOF
+		git status --porcelain >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_done

-- 
2.51.1.930.gacf6e81ea2.dirty


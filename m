Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902F9286404
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 15:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759334307; cv=none; b=k9JdlR7lUZfz8Gd6O6bBQpiew8xxytP3kQhuah1zKb7wE0iazN5/cRvuyeyUCG/4n80mzSMqj4DY0q3cgodVUS/cln1eEE9/7ehpxouM1+Yt/Fyb5P7mj/8trHEaC74cbIjY66XeW6zuqSGuGSk8JLRPmLAFa/+H9L2+CIp975M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759334307; c=relaxed/simple;
	bh=OfLomzmDnNsxcrJ06Mkb6/T1hg7iE0j7/xOlSKrEdtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ouDETU/bBuz+z/2RF+j5cfUGhfACRhR48FW7/Srkm4Cv5W4555T9WJVX7caV5PK/I/+059aNU5tw+VHt3Lj7Vi1vFiIKkcqIEj5P2TbDkQVBt4p22szd1vlpQMiU3VOWQCly7u7nwrlkNV08AnBu/fw3/77NK6gBhFcP2NFQfpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Rx6CiDTj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FFKJQ18Y; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Rx6CiDTj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FFKJQ18Y"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8CE217A0163;
	Wed,  1 Oct 2025 11:58:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 01 Oct 2025 11:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759334304;
	 x=1759420704; bh=HOABD+ZbPkQxlAP+Q3jJaWG5tw4L7braBvCewjisHEQ=; b=
	Rx6CiDTjXzoyDt+f5MmdyI3z/sKH5cLNK8YGcm1GqM6w0lgfYBbu8Lz4gDmVnNPS
	PJDgvJioxWynJPYA9NxIxMuUrGAqHNg9tLTxz6/Lj19Kh0imR0q+n8ZZl6k+KrZb
	qAcrrRt699s8SzQZKmqt3ROjmOZlhqJ1UvyBJAefdueR1LMY2n8f7ynNpl4je+C9
	bWIL0T4szIqgaPf9F73DGzo6eKY/yHAjCQXKe/VRyNmbzGGJCtl5QbuPh5DRT1DD
	MJNdkm2BYH2OEKglJhJ0IUNvQ5p3XZElkjwq5jld5s6aOm3J1kdKoVYSUBxBqgtT
	WrePVd0tOJwLSp4N168/yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759334304; x=
	1759420704; bh=HOABD+ZbPkQxlAP+Q3jJaWG5tw4L7braBvCewjisHEQ=; b=F
	FKJQ18YIDDOUla/8XKeQ1Lh2o8bqGgA7KpOSZNUo10HIEsLBahmHh6qr4hTFXHlr
	4jCGE5C8fiIx/QYK/VaPA1TUUu3fzO2u26vtUVlFoAnbc1lGGJZaX6JNvr+WayUl
	A9VcHGeGViu1bkdL1olpr4PFO8HgJCPHocbbSV38ApqoKMhb/7lDeh2dhzML2QBV
	4pLaCa8KLR2rqy0mddKb6hSASfpWvU4xlKiQRsy41genc2S1B5jroW9DWJZ0RdvX
	I0fsCLgUIFKWEvAL63Ld4B6fOgjSYnKVvacM+exSAoL5lHkWiOJ7jApEQW8cLARt
	aWSQP7AybrqG+pqv3CTRQ==
X-ME-Sender: <xms:oE_daAueJmtt6v-KzoNHzgwmI64sUpmwtEUZSPJ9hBOBr0gMJe67zw>
    <xme:oE_daMgn_Bsqpr5A6pG_QBqdrZqvpJhlXOz-1WB1Z8eKDIEPyAy37rf1vbll9eoH5
    q-2ePmDkCcpP9ka1zrXQpb_ypldXUiDnTWGva7Qih_DB65-0nlOB7I>
X-ME-Received: <xmr:oE_daB9eBybEWaHrBS13ODLWWzEDL-daiXZeuAGKM3sjzc_xDaPbkY9rh9JOUZl1C5p2Sg5Oa8Js0MOtnEVc3lF0vEqJ0I6UgJ6Rv8cH2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekfeehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepmhgrrhhtihhnvhhonh
    iisehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsg
    gvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:oE_daPsKMOsOXJq3ELpskzAh5v6NV0QwErxPxktOcBOLPwFvIpikig>
    <xmx:oE_daFq99D7eGYQ6SuZzAda47SRP1O_IigD4Ty66KIdJzD6x-Jb3TA>
    <xmx:oE_daDp5AywczRnilgltZbDehbu32g1ZT9oGW8jty3ekgOgUFcgxmg>
    <xmx:oE_daEYKoGwtSpDQ3L4nP_A3khcc-6ZP4y1SsVG5a011QbTnfbtNPw>
    <xmx:oE_daNpcuwDJFpbBlB5v_dA0-YI2a9sufIzZojQ6vxAlSu-1xEZvZgPT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 11:58:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 619d8e83 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 1 Oct 2025 15:58:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 01 Oct 2025 17:57:38 +0200
Subject: [PATCH v4 12/12] builtin/history: implement "split" subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-b4-pks-history-builtin-v4-12-8e61ddb86317@pks.im>
References: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im>
In-Reply-To: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>
X-Mailer: b4 0.14.2

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
 builtin/history.c              | 225 +++++++++++++++++++++
 t/meson.build                  |   1 +
 t/t3452-history-split.sh       | 432 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 720 insertions(+)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index b55babe206..83d675afea 100644
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
index 7b2a0023e8..8851a2945e 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -1,6 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
+#include "cache-tree.h"
 #include "commit-reach.h"
 #include "commit.h"
 #include "config.h"
@@ -10,10 +11,13 @@
 #include "hex.h"
 #include "oidmap.h"
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
@@ -368,6 +372,225 @@ static int cmd_history_reword(int argc,
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
+		N_("git history split [<options>] <commit>"),
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
+	commit_list_append(original_commit, &list);
+	if (!repo_is_descendant_of(repo, original_commit, list)) {
+		ret = error (_("split commit must be reachable from current HEAD commit"));
+		goto out;
+	}
+
+	parse_pathspec(&pathspec, 0,
+		PATHSPEC_PREFER_FULL | PATHSPEC_SYMLINK_LEADING_PATH | PATHSPEC_PREFIX_ORIGIN,
+		prefix, argv + 1);
+
+	/*
+	* Collect the list of commits that we'll have to reapply now already.
+	* This ensures that we'll abort early on in case the range of commits
+	* contains merges, which we do not yet handle.
+	*/
+	ret = collect_commits(repo, parent, head, &commits);
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
+	ret = apply_commits(repo, &commits, parent, head, "split");
+	if (ret < 0)
+		goto out;
+
+	ret = 0;
+
+out:
+	oidmap_clear(&rewritten_commits, 0);
+	clear_pathspec(&pathspec);
+	strvec_clear(&commits);
+	free_commit_list(list);
+	return ret;
+}
+
 int cmd_history(int argc,
 		const char **argv,
 		const char *prefix,
@@ -376,11 +599,13 @@ int cmd_history(int argc,
 	const char * const usage[] = {
 		N_("git history [<options>]"),
 		N_("git history reword [<options>] <commit>"),
+		N_("git history split [<options>] <commit> [--] [<pathspec>...]"),
 		NULL,
 	};
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
 		OPT_SUBCOMMAND("reword", &fn, cmd_history_reword),
+		OPT_SUBCOMMAND("split", &fn, cmd_history_split),
 		OPT_END(),
 	};
 
diff --git a/t/meson.build b/t/meson.build
index 2a74243202..fb05be16ae 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -384,6 +384,7 @@ integration_tests = [
   't3438-rebase-broken-files.sh',
   't3450-history.sh',
   't3451-history-reword.sh',
+  't3452-history-split.sh',
   't3500-cherry.sh',
   't3501-revert-cherry-pick.sh',
   't3502-cherry-pick-merge.sh',
diff --git a/t/t3452-history-split.sh b/t/t3452-history-split.sh
new file mode 100755
index 0000000000..45d3b32ebf
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
2.51.0.700.g236ee7b076.dirty


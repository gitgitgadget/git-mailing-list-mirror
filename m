Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B93631A564
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 14:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996115; cv=none; b=SigYGjkqH/kL56NTqBN+szXbUltX1eLLtzSriC76kfxeJ2lp7zoCmOupmdueKagJS4CHLfubqirJNq8dEEkACruStV0DuTbOy6IQ+weew3YxpVAq1ymYEotn5KKSZxhCYCU3vYXWCaKA8SH055364dvT5j2fU4LVahmJexvDZ6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996115; c=relaxed/simple;
	bh=NsSHTID2c4YB9Cjv8Gmqd0vY0EjP3aFheCyBfSvsWoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u7V++9RQ+3voLoWNMcZoRXCC44sdvdsTPZkm7/oWUkkS/aNZ6TfBxmcjwRrlTFxNOY3a/v4Lm5lunDG6rxPaFZc/SfXLfcopjThC+QRO+ZIuOo48AJxd0Re2XAKRKQgJDmkh+1SeyP8Tu9Fn51XW+Wl6Wn11E+6V0QpMu73Qp8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Zi4Z2D30; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SiDTlN7/; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Zi4Z2D30";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SiDTlN7/"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1EAE77A034B;
	Thu,  4 Sep 2025 10:28:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 04 Sep 2025 10:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756996111;
	 x=1757082511; bh=p+IDhDHpJ8KK6SZughCeWJPvWW/sirmvg2aEr2wyOwk=; b=
	Zi4Z2D30KEmEvwdm6RACp8zoYoARyS05FkN9YqC0FCJLI30levXXRLhbftkVOm5/
	dUFfEPS02gBYQUGnP51mhXw9krpfKrTBMxfsB9K9m/Vxt147sL7WR++ZxTWHbU7i
	ZL8BWUa5J50cUmmkwYBOpEVn6ZeVKkla7gxN/m2Xd5gWO4ttbdUigJz0wBJQL/FZ
	MKLAJ5GP0mIdf8UkMVhObsVHiUapnpsk5l9n+UpeKQ+auL7RALEA0p6KMIia+SpD
	enwfhjB5m+2n/LDDM4K+ls2pVOIhVNtr8BeI3ASWBnKiPkOJGnzGhX9cpu7Ic2hD
	31LcqSXVn70bVNs168X12Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756996111; x=
	1757082511; bh=p+IDhDHpJ8KK6SZughCeWJPvWW/sirmvg2aEr2wyOwk=; b=S
	iDTlN7/Pc3a70qqJ7wM1LaD0cp877/W+UXQ7EaJ4ACG7Mk+fACKS+lxQEHosFWgL
	0gAKHLF8tXa9jEtUWuxmJII+aAMJFzM96Jjl1NJjlLl417JuenZQ8V2uE0cpv99y
	EYt/6FyqdW+cjsOh3BBOso6mZzfMLpTuLRab5sY6pYd0WBtk0xu9JbyL0sovw+g2
	lJmu9mJkOnC5UJPVy9aetbdh7c1fbfukGC/XEU+y4hwi1F9CSteMEVSVyshO1JP5
	vN+OmGAGL4gtYnstuZh3mdUchANrPc1tS/PtKtRfJeoqEOxiY7nnr2LILPvS/Ceo
	Kn8/ow7pU7OS3oKWRPQ9g==
X-ME-Sender: <xms:D6K5aJ3IH0__NoPtjfeSY6mcM_-vReHT5C6R9230BQZNgIsTRfEICA>
    <xme:D6K5aNpUxUCGjHG2-A4EpYRI49pE47nYF4NKwjznlFbNqbIRKLxhDysUL5vjMoDqu
    xs06gvDxwDFof_-bQ>
X-ME-Received: <xmr:D6K5aAVr6LE96u8pM_J5m_pxYbmm1lytgHGSWseocnhtt2jarPOFhNY46hnDrXRU-FfVH2814xc5um_fTswJrS8rW94_5KfDVNBdZZiV0erYUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeivdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucev
    lhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtthhopehmrghr
    thhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehjnhdrrghvihhlrgesfh
    hrvggvrdhfrhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:D6K5aIbjbNZEJTJpRM7qQns1-FnEtwuTx9Bso6CcwUiQy_WrK53J1g>
    <xmx:D6K5aNejnGbxKPCJp2VaFZbXO5hCOAI_NTgjO5J_fEjJcsAdEjv6gg>
    <xmx:D6K5aC1I81sYsmy9M4TkqniqemOrYfzbKrFB6swRS3fipwk8ULThDw>
    <xmx:D6K5aEIkU9f9JA2EMfn2HRVkxcfRJQCdgkMLOOLnk0ldZ8xJu1robg>
    <xmx:D6K5aLg4dKC4Q9dZe2afx3-sruzEJCyoesQ6Bb-SdTsD4o0vwgmbELoW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 10:28:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8b9160d6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 4 Sep 2025 14:28:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Sep 2025 16:27:47 +0200
Subject: [PATCH RFC v3 17/18] builtin/history: implement "split" subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-b4-pks-history-builtin-v3-17-509053514755@pks.im>
References: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
In-Reply-To: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
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
 Documentation/git-history.adoc |  60 ++++++
 builtin/history.c              | 313 ++++++++++++++++++++++++++-
 t/meson.build                  |   1 +
 t/t3453-history-split.sh       | 468 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 840 insertions(+), 2 deletions(-)

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
index 16b516856e..df04b8dfc6 100644
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
@@ -213,6 +223,7 @@ static int apply_commits(struct repository *repo,
 			 const struct strvec *commits,
 			 struct commit *head,
 			 struct commit *base,
+			 const struct oidmap *rewritten_commits,
 			 const char *action)
 {
 	struct setup_revision_opt revision_opts = {
@@ -238,6 +249,7 @@ static int apply_commits(struct repository *repo,
 		replay_opts.strategy = replay_opts.default_strategy;
 		replay_opts.default_strategy = NULL;
 	}
+	replay_opts.old_oid_mappings = rewritten_commits;
 
 	strvec_push(&args, "");
 	strvec_pushv(&args, commits->v);
@@ -403,7 +415,8 @@ static int cmd_history_drop(int argc,
 		if (ret < 0)
 			goto out;
 
-		ret = apply_commits(repo, &commits, head, commit_to_drop, "drop");
+		ret = apply_commits(repo, &commits, head, commit_to_drop,
+				    NULL, "drop");
 		if (ret < 0)
 			goto out;
 	}
@@ -505,7 +518,7 @@ static int cmd_history_reorder(int argc,
 	replace_commits(&commits, &commit_to_reorder->object.oid, NULL, 0);
 	replace_commits(&commits, &anchor->object.oid, replacement, ARRAY_SIZE(replacement));
 
-	ret = apply_commits(repo, &commits, head, old, "reorder");
+	ret = apply_commits(repo, &commits, head, old, NULL, "reorder");
 	if (ret < 0)
 		goto out;
 
@@ -517,6 +530,300 @@ static int cmd_history_reorder(int argc,
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
+		const char *path = git_path_commit_editmsg();
+		const char *hint =
+			_("Please enter the commit message for the %s changes. Lines starting\n"
+			  "with '%s' will be kept; you may remove them yourself if you want to.\n");
+		int verbose = 1;
+
+		strbuf_addstr(out, default_message);
+		strbuf_addch(out, '\n');
+		strbuf_commented_addf(out, comment_line_str, hint, action, comment_line_str);
+		write_file_buf(path, out->buf, out->len);
+
+		repo_config_get_bool(repo, "commit.verbose", &verbose);
+		if (verbose) {
+			struct wt_status s;
+
+			wt_status_prepare(repo, &s);
+			FREE_AND_NULL(s.branch);
+			s.ahead_behind_flags = AHEAD_BEHIND_QUICK;
+			s.commit_template = 1;
+			s.colopts = 0;
+			s.display_comment_prefix = 1;
+			s.hints = 0;
+			s.use_color = 0;
+			s.whence = FROM_COMMIT;
+			s.committable = 1;
+
+			s.fp = fopen(git_path_commit_editmsg(), "a");
+			if (!s.fp)
+				return error_errno(_("could not open '%s'"), git_path_commit_editmsg());
+
+			wt_status_collect_changes_trees(&s, old_tree, new_tree);
+			wt_status_print(&s);
+			wt_status_collect_free_buffers(&s);
+			string_list_clear_func(&s.change, change_data_free);
+		}
+
+		strbuf_reset(out);
+		if (launch_editor(path, out, NULL)) {
+			fprintf(stderr, _("Please supply the message using the -m option.\n"));
+			return -1;
+		}
+		strbuf_stripspace(out, comment_line_str);
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
+	struct oidmap rewritten_commits = OIDMAP_INIT;
+	struct commit *original_commit, *head;
+	struct strvec commits = STRVEC_INIT;
+	struct commit_list *list = NULL;
+	struct object_id split_commits[2];
+	struct replay_oid_mapping mapping[2] = { 0 };
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
+	mapping[0].entry.oid = split_commits[0];
+	mapping[0].rewritten_oid = original_commit->object.oid;
+	oidmap_put(&rewritten_commits, &mapping[0]);
+	mapping[1].entry.oid = split_commits[1];
+	mapping[1].rewritten_oid = original_commit->object.oid;
+	oidmap_put(&rewritten_commits, &mapping[1]);
+
+	replace_commits(&commits, &original_commit->object.oid,
+			split_commits, ARRAY_SIZE(split_commits));
+
+	ret = apply_commits(repo, &commits, head, original_commit,
+			    &rewritten_commits, "split");
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
@@ -528,6 +835,7 @@ int cmd_history(int argc,
 		N_("git history quit"),
 		N_("git history drop <commit>"),
 		N_("git history reorder <commit> (--before=<following-commit>|--after=<preceding-commit>)"),
+		N_("git history split [<options>] <commit> [--] [<pathspec>...]"),
 		NULL,
 	};
 	parse_opt_subcommand_fn *fn = NULL;
@@ -537,6 +845,7 @@ int cmd_history(int argc,
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
index 0000000000..a6a652e7df
--- /dev/null
+++ b/t/t3453-history-split.sh
@@ -0,0 +1,468 @@
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
+test_expect_success 'skips change summary with commit.verbose=false' '
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
+		git -c commit.verbose=false history split HEAD <<-EOF &&
+		y
+		n
+		EOF
+
+		cat >expect <<-EOF &&
+
+		# Please enter the commit message for the split-out changes. Lines starting
+		# with ${SQ}#${SQ} will be kept; you may remove them yourself if you want to.
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
+		echo "prepare-commit-msg: \$@" >>"$(pwd)/hooks.log"
+		EOF
+		write_script .git/hooks/post-commit <<-EOF &&
+		echo "post-commit" >>"$(pwd)/hooks.log"
+		EOF
+		write_script .git/hooks/post-rewrite <<-EOF &&
+		{
+			echo "post-rewrite: \$@"
+			cat
+		} >>"$(pwd)/hooks.log"
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
+		cat >expect <<-EOF &&
+		prepare-commit-msg: .git/COMMIT_EDITMSG message
+		post-commit
+		prepare-commit-msg: .git/COMMIT_EDITMSG message
+		post-commit
+		post-rewrite: history
+		$old_head $(git rev-parse HEAD~)
+		$old_head $(git rev-parse HEAD)
+		EOF
+		test_cmp expect hooks.log
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
2.51.0.417.g1ba7204a04.dirty


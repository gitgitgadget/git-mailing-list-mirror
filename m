Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBF2311959
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 10:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767780640; cv=none; b=Cxnrgnwm0/NRP1vZxWzLhCV4V5Qj82u8OY1taBt7f0SKEyMI7vBmKOadyczO6FpsHl9ZI+KshqWb1YhhsJ+mnNE4oqmec7WC155EmXjNyXs4qD9WlCxsd/XTGqpgWiS14/HZ9PT/GbzT9H8CznfHZij8/JyIiwl9EBtyQYgeklU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767780640; c=relaxed/simple;
	bh=vph2Z6NMksv3zoBWHM8gv8xBcJU/HMblZhnAE/Oebq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cu0fxx2YH9Fc6F1Pmsa8SzKEWfxia1yGLVGCV8SP+1wCKQjFdJ2pqI2xMVRwP9Ng3yWGhLXkEDHI144nKVSEsv3eWEjCnNq3gQK7H1cvCShKhqZAs0fqX2pE6cGGPlJ5luC1027oNJLKha4SRqfqt5DIGWcUz4e+uKlVrFRhWIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P0HT1159; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HGUar/tG; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P0HT1159";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HGUar/tG"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E6B99140016C;
	Wed,  7 Jan 2026 05:10:35 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 07 Jan 2026 05:10:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767780635;
	 x=1767867035; bh=SjpT4BP10OJY5hHwybabvT0IQZZfxYsufPv7jSc0jzM=; b=
	P0HT1159BLMx1Vf2WKQxTDAkAlryBHf5GPawIJUySBve1+Nl2jXF/98LvANuMdLk
	h1rhP6nKGZzfYrmLuZcHyKfHccJwplEEQJ2OqfVcnFCTnQoNHBt9YXhyWf5MQfLq
	Yxa7WEvySm2VbQxDiwtBl2ZLXtx5ft+ZuAt2K907cZrgc5VKYFTrjNhGXZ65QRVd
	PAmu0mLpQ904ulk/4wB0Hjw459R/fwmV8YftT3/4XTf0Y2w+pjPd5AjLzVgePAk/
	OAHR0VY6O5zWr95vEa/bTSuJXWVtn53WIb3VOfinq0Y/ycBSPtlSJjAnyvCfCNJu
	gAM7cXB2C2EHH/9cI7vF3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767780635; x=
	1767867035; bh=SjpT4BP10OJY5hHwybabvT0IQZZfxYsufPv7jSc0jzM=; b=H
	GUar/tGjOekHF9NVU/weWrbSs0l+DIXAlczAtLmE5PF8XN8fEF8toSJoKYrvodbz
	CTuIBvjBf6GwtjVy9oJOO8Bw+EZZWV3vHhrlfPOZByccf2kfv7xZTG8LxxRAH8it
	wKDEmcSgu44B72TpOMq/kyHnm598RaKgh8OtKIInwTxLFi4j/0ibyBcyEDZ6VLOW
	QrC6f8s4x/IBVKKAMIQRJo0dcdelsSW5vkN2nxPAnm/QVo57JP1NkpMlpf+3aT1v
	7fhWv/Lemk4L4LIO3SOxT8miJup1U0KMQKdSstggTvddKFbeBo40a4ydVU+JSC+t
	onZDPtdjLLi9ZIaxVsvKA==
X-ME-Sender: <xms:GzFeaQMFukGPAjbG4V3bb0Ufu36HK8JeTMUrKNwG4Y9YWVQg-zx7oQ>
    <xme:GzFeaSw_qhI1Swt8rjhxEzUEXSJVLwZFJD-u1d7CTym60z1ywhLptmx9JuXLOdHGx
    CqPypg6P_5q2OW28fV-bS-mbCHKVVlKrxoo0DwyGwfRzhMG-NQOclw>
X-ME-Received: <xmr:GzFeaSqnHxRaYDdTtR8SEADR-mYFT32Ta2Ybb1v2oZlYYcSpSN40YSkABQfYfpXfMaoWpqA-zGn2bx8_pNWZwt0CJCcsdhdPcKhYdT5OUfc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddvjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepphhh
    ihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsohhrgh
    grnhhovhesghhmrghilhdrtghomhdprhgtphhtthhopehmrghilhessggvhigvrhhmrght
    thhhihgrshdruggvpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgr
    rhhtihhnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:GzFeaSMmELtH91jIJ1Q62ZW2eMqOyDWp-wZlCjpYC3g-tZMjJBf4Nw>
    <xmx:GzFeaWdF8vDbj7sGa4J0K0AWq5Q4jXebIJX2ZWrLEcqOAKTWZ3zc4g>
    <xmx:GzFeaYXodLmaxBuYkGGlXxNNKmPVsq7btC4_2_l2MUGCcygpK0zfPw>
    <xmx:GzFeaXCM43ncjhtesfa3GqgEwDtVIpqWhgvICLqEpoC91iUQpu6Tvg>
    <xmx:GzFeaZNX6ao7LI3OV50slM4TDSHbQkmK-rV0mLuksYSxCkjGlbhAa1wy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jan 2026 05:10:34 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 18d86a71 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Jan 2026 10:10:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 07 Jan 2026 11:10:15 +0100
Subject: [PATCH v8 7/7] builtin/history: implement "reword" subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-b4-pks-history-builtin-v8-7-18e9779e3a26@pks.im>
References: <20260107-b4-pks-history-builtin-v8-0-18e9779e3a26@pks.im>
In-Reply-To: <20260107-b4-pks-history-builtin-v8-0-18e9779e3a26@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Matthias Beyer <mail@beyermatthias.de>
X-Mailer: b4 0.14.3

Implement a new "reword" subcommand for git-history(1). This subcommand
is similar to the user performing an interactive rebase with a single
commit changed to use the "reword" instruction.

The "reword" subcommand is built on top of the replay subsystem
instead of the sequencer. This leads to some major differences compared
to git-rebase(1):

  - We do not check out the commit that is to be reworded and instead
    perform the operation in-memory. This has the obvious benefit of
    being significantly faster compared to git-rebase(1), but even more
    importantly it allows the user to rewrite history even if there are
    local changes in the working tree or in the index.

  - We do not execute any hooks, even though we leave some room for
    changing this in the future.

  - By default, all local branches that contain the commit will be
    rewritten. This especially helps with workflows that use stacked
    branches.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-history.adoc |  23 ++-
 builtin/history.c              | 392 ++++++++++++++++++++++++++++++++++++++++-
 replay.c                       |   5 +-
 t/meson.build                  |   1 +
 t/t3450-history.sh             |   6 +-
 t/t3451-history-reword.sh      | 344 ++++++++++++++++++++++++++++++++++++
 6 files changed, 758 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index 5a9d931efc..4eea317e5c 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -8,7 +8,7 @@ git-history - EXPERIMENTAL: Rewrite history
 SYNOPSIS
 --------
 [synopsis]
-git history [<options>]
+git history reword <commit> [--ref-action=(branches|head|print)]
 
 DESCRIPTION
 -----------
@@ -32,8 +32,9 @@ Overall, linkgit:git-history[1] aims to provide a more opinionated way to modify
 your commit history that is simpler to use compared to linkgit:git-rebase[1] in
 general.
 
-If you want to reapply a range of commits onto a different base, or interactive
-rebases if you want to edit a range of commits.
+Use linkgit:git-rebase[1] if you want to reapply a range of commits onto a
+different base, or interactive rebases if you want to edit a range of commits
+at once.
 
 LIMITATIONS
 -----------
@@ -51,6 +52,22 @@ COMMANDS
 
 Several commands are available to rewrite history in different ways:
 
+`reword <commit>`::
+	Rewrite the commit message of the specified commit. All the other
+	details of this commit remain unchanged. This command will spawn an
+	editor with the current message of that commit.
+
+OPTIONS
+-------
+
+`--ref-action=(branches|head|print)`::
+	Control which references will be updated by the command, if any. With
+	`branches`, all local branches that point to commits which are
+	decendants of the original commit will be rewritten. With `head`, only
+	the current `HEAD` reference will be rewritten. With `print`, all
+	updates as they would be performed with `branches` are printed in a
+	format that can be consumed by linkgit:git-update-ref[1].
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/history.c b/builtin/history.c
index f6fe32610b..59011ea517 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -1,22 +1,404 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "builtin.h"
+#include "commit.h"
+#include "commit-reach.h"
+#include "config.h"
+#include "editor.h"
+#include "environment.h"
 #include "gettext.h"
+#include "hex.h"
 #include "parse-options.h"
+#include "refs.h"
+#include "replay.h"
+#include "revision.h"
+#include "sequencer.h"
+#include "strvec.h"
+#include "tree.h"
+#include "wt-status.h"
+
+#define GIT_HISTORY_REWORD_USAGE \
+	N_("git history reword <commit> [--ref-action=(branches|head|print)]")
+
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
+			       const char *action,
+			       struct strbuf *out)
+{
+	const char *path = git_path_commit_editmsg();
+	const char *hint =
+		_("Please enter the commit message for the %s changes."
+		  " Lines starting\nwith '%s' will be ignored, and an"
+		  " empty message aborts the commit.\n");
+	struct wt_status s;
+
+	strbuf_addstr(out, default_message);
+	strbuf_addch(out, '\n');
+	strbuf_commented_addf(out, comment_line_str, hint, action, comment_line_str);
+	write_file_buf(path, out->buf, out->len);
+
+	wt_status_prepare(repo, &s);
+	FREE_AND_NULL(s.branch);
+	s.ahead_behind_flags = AHEAD_BEHIND_QUICK;
+	s.commit_template = 1;
+	s.colopts = 0;
+	s.display_comment_prefix = 1;
+	s.hints = 0;
+	s.use_color = 0;
+	s.whence = FROM_COMMIT;
+	s.committable = 1;
+
+	s.fp = fopen(git_path_commit_editmsg(), "a");
+	if (!s.fp)
+		return error_errno(_("could not open '%s'"), git_path_commit_editmsg());
+
+	wt_status_collect_changes_trees(&s, old_tree, new_tree);
+	wt_status_print(&s);
+	wt_status_collect_free_buffers(&s);
+	string_list_clear_func(&s.change, change_data_free);
+
+	strbuf_reset(out);
+	if (launch_editor(path, out, NULL)) {
+		fprintf(stderr, _("Aborting commit as launching the editor failed.\n"));
+		return -1;
+	}
+	strbuf_stripspace(out, comment_line_str);
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
+static int commit_tree_with_edited_message(struct repository *repo,
+					   const char *action,
+					   struct commit *original,
+					   struct commit **out)
+{
+	const char *exclude_gpgsig[] = { "gpgsig", "gpgsig-sha256", NULL };
+	const char *original_message, *original_body, *ptr;
+	struct commit_extra_header *original_extra_headers = NULL;
+	struct strbuf commit_message = STRBUF_INIT;
+	struct object_id rewritten_commit_oid;
+	struct object_id original_tree_oid;
+	struct object_id parent_tree_oid;
+	char *original_author = NULL;
+	struct commit *parent;
+	size_t len;
+	int ret;
+
+	original_tree_oid = repo_get_commit_tree(repo, original)->object.oid;
+
+	parent = original->parents ? original->parents->item : NULL;
+	if (parent) {
+		if (repo_parse_commit(repo, parent)) {
+			ret = error(_("unable to parse parent commit %s"),
+				    oid_to_hex(&parent->object.oid));
+			goto out;
+		}
+
+		parent_tree_oid = repo_get_commit_tree(repo, parent)->object.oid;
+	} else {
+		oidcpy(&parent_tree_oid, repo->hash_algo->empty_tree);
+	}
+
+	/* We retain authorship of the original commit. */
+	original_message = repo_logmsg_reencode(repo, original, NULL, NULL);
+	ptr = find_commit_header(original_message, "author", &len);
+	if (ptr)
+		original_author = xmemdupz(ptr, len);
+	find_commit_subject(original_message, &original_body);
+
+	ret = fill_commit_message(repo, &parent_tree_oid, &original_tree_oid,
+				  original_body, action, &commit_message);
+	if (ret < 0)
+		goto out;
+
+	original_extra_headers = read_commit_extra_headers(original, exclude_gpgsig);
+
+	ret = commit_tree_extended(commit_message.buf, commit_message.len, &original_tree_oid,
+				   original->parents, &rewritten_commit_oid, original_author,
+				   NULL, NULL, original_extra_headers);
+	if (ret < 0)
+		goto out;
+
+	*out = lookup_commit_or_die(&rewritten_commit_oid, "rewritten commit");
+
+out:
+	free_commit_extra_headers(original_extra_headers);
+	strbuf_release(&commit_message);
+	free(original_author);
+	return ret;
+}
+
+enum ref_action {
+	REF_ACTION_DEFAULT,
+	REF_ACTION_BRANCHES,
+	REF_ACTION_HEAD,
+	REF_ACTION_PRINT,
+};
+
+static int parse_ref_action(const struct option *opt, const char *value, int unset)
+{
+	enum ref_action *action = opt->value;
+
+	BUG_ON_OPT_NEG_NOARG(unset, value);
+	if (!strcmp(value, "branches")) {
+		*action = REF_ACTION_BRANCHES;
+	} else if (!strcmp(value, "head")) {
+		*action = REF_ACTION_HEAD;
+	} else if (!strcmp(value, "print")) {
+		*action = REF_ACTION_PRINT;
+	} else {
+		return error(_("%s expects one of 'branches', 'head' or 'print'"),
+			     opt->long_name);
+	}
+
+	return 0;
+}
+
+static int handle_reference_updates(enum ref_action action,
+				    struct repository *repo,
+				    struct commit *original,
+				    struct commit *rewritten,
+				    const char *reflog_msg)
+{
+	const struct name_decoration *decoration;
+	struct replay_revisions_options opts = { 0 };
+	struct replay_ref_updates updates = {
+		.final_oid = rewritten->object.oid,
+	};
+	struct ref_transaction *transaction = NULL;
+	struct strvec args = STRVEC_INIT;
+	struct strbuf err = STRBUF_INIT;
+	struct commit *head = NULL;
+	struct rev_info revs;
+	char hex[GIT_MAX_HEXSZ + 1];
+	int ret;
+
+	repo_init_revisions(repo, &revs, NULL);
+	strvec_push(&args, "ignored");
+	strvec_push(&args, "--reverse");
+	strvec_push(&args, "--topo-order");
+	strvec_push(&args, "--full-history");
+
+	/* We only want to see commits that are descendants of the old commit. */
+	strvec_pushf(&args, "--ancestry-path=%s",
+		     oid_to_hex(&original->object.oid));
+
+	/*
+	 * Ancestry path may also show ancestors of the old commit, but we
+	 * don't want to see those, either.
+	 */
+	strvec_pushf(&args, "^%s", oid_to_hex(&original->object.oid));
+
+	/*
+	 * When we're asked to update HEAD we need to verify that the commit
+	 * that we want to rewrite is actually an ancestor of it and, if so,
+	 * update it. Otherwise we'll update (or print) all descendant
+	 * branches.
+	 */
+	if (action == REF_ACTION_HEAD) {
+		struct commit_list *from_list = NULL;
+
+		head = lookup_commit_reference_by_name("HEAD");
+		if (!head) {
+			ret = error(_("cannot look up HEAD"));
+			goto out;
+		}
+
+		commit_list_insert(original, &from_list);
+		ret = repo_is_descendant_of(repo, head, from_list);
+		free_commit_list(from_list);
+
+		if (ret < 0) {
+			ret = error(_("cannot determine descendance"));
+			goto out;
+		} else if (!ret) {
+			ret = error(_("rewritten commit must be an ancestor "
+				      "of HEAD when using --ref-action=head"));
+			goto out;
+		}
+
+		strvec_push(&args, oid_to_hex(&head->object.oid));
+	} else {
+		strvec_push(&args, "--branches");
+	}
+
+	setup_revisions_from_strvec(&args, &revs, NULL);
+	if (revs.nr)
+		BUG("revisions were set up with invalid argument '%s'", args.v[0]);
+
+	opts.onto = oid_to_hex_r(hex, &rewritten->object.oid);
+
+	ret = replay_revisions(repo, &revs, &opts, &updates);
+	if (ret)
+		goto out;
+
+	switch (action) {
+	case REF_ACTION_DEFAULT:
+	case REF_ACTION_BRANCHES:
+		transaction = ref_store_transaction_begin(get_main_ref_store(repo), 0, &err);
+		if (!transaction) {
+			ret = error(_("failed to begin ref transaction: %s"), err.buf);
+			goto out;
+		}
+
+		for (size_t i = 0; i < updates.nr; i++) {
+			ret = ref_transaction_update(transaction,
+						     updates.items[i].refname,
+						     &updates.items[i].new_oid,
+						     &updates.items[i].old_oid,
+						     NULL, NULL, 0, reflog_msg, &err);
+			if (ret) {
+				ret = error(_("failed to update ref '%s': %s"),
+					    updates.items[i].refname, err.buf);
+				goto out;
+			}
+		}
+
+		/*
+		 * `replay_revisions()` only updates references that are
+		 * ancestors of `rewritten`, so we need to manually
+		 * handle updating references that point to `original`.
+		 */
+		for (decoration = get_name_decoration(&original->object);
+		     decoration;
+		     decoration = decoration->next)
+		{
+			if (decoration->type != DECORATION_REF_LOCAL)
+				continue;
+
+			ret = ref_transaction_update(transaction,
+						     decoration->name,
+						     &rewritten->object.oid,
+						     &original->object.oid,
+						     NULL, NULL, 0, reflog_msg, &err);
+			if (ret) {
+				ret = error(_("failed to update ref '%s': %s"),
+					    decoration->name, err.buf);
+				goto out;
+			}
+		}
+
+		if (ref_transaction_commit(transaction, &err)) {
+			ret = error(_("failed to commit ref transaction: %s"), err.buf);
+			goto out;
+		}
+
+		break;
+	case REF_ACTION_HEAD:
+		ret = refs_update_ref(get_main_ref_store(repo), reflog_msg, "HEAD",
+				      &updates.final_oid, &head->object.oid, 0,
+				      UPDATE_REFS_MSG_ON_ERR);
+		if (ret)
+			goto out;
+		break;
+	case REF_ACTION_PRINT:
+		for (size_t i = 0; i < updates.nr; i++)
+			printf("update %s %s %s\n",
+			       updates.items[i].refname,
+			       oid_to_hex(&updates.items[i].new_oid),
+			       oid_to_hex(&updates.items[i].old_oid));
+		break;
+	default:
+		BUG("unsupported ref action %d", action);
+	}
+
+	ret = 0;
+
+out:
+	replay_ref_updates_release(&updates);
+	ref_transaction_free(transaction);
+	release_revisions(&revs);
+	strbuf_release(&err);
+	strvec_clear(&args);
+	return ret;
+}
+
+static int cmd_history_reword(int argc,
+			      const char **argv,
+			      const char *prefix,
+			      struct repository *repo)
+{
+	const char * const usage[] = {
+		GIT_HISTORY_REWORD_USAGE,
+		NULL,
+	};
+	enum ref_action action = REF_ACTION_DEFAULT;
+	struct option options[] = {
+		OPT_CALLBACK_F(0, "ref-action", &action, N_("<action>"),
+			       N_("control ref update behavior (branches|head|print)"),
+			       PARSE_OPT_NONEG, parse_ref_action),
+		OPT_END(),
+	};
+	struct strbuf reflog_msg = STRBUF_INIT;
+	struct commit *original, *rewritten;
+	int ret;
+
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+	if (argc != 1) {
+		ret = error(_("command expects a single revision"));
+		goto out;
+	}
+	repo_config(repo, git_default_config, NULL);
+
+	original = lookup_commit_reference_by_name(argv[0]);
+	if (!original) {
+		ret = error(_("commit cannot be found: %s"), argv[0]);
+		goto out;
+	}
+
+	ret = commit_tree_with_edited_message(repo, "reworded", original, &rewritten);
+	if (ret < 0) {
+		ret = error(_("failed writing reworded commit"));
+		goto out;
+	}
+
+	strbuf_addf(&reflog_msg, "reword: updating %s", argv[0]);
+
+	ret = handle_reference_updates(action, repo, original, rewritten,
+				       reflog_msg.buf);
+	if (ret < 0) {
+		ret = error(_("failed replaying descendants"));
+		goto out;
+	}
+
+	ret = 0;
+
+out:
+	strbuf_release(&reflog_msg);
+	return ret;
+}
 
 int cmd_history(int argc,
 		const char **argv,
 		const char *prefix,
-		struct repository *repo UNUSED)
+		struct repository *repo)
 {
 	const char * const usage[] = {
-		N_("git history [<options>]"),
+		GIT_HISTORY_REWORD_USAGE,
 		NULL,
 	};
+	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
+		OPT_SUBCOMMAND("reword", &fn, cmd_history_reword),
 		OPT_END(),
 	};
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
-	if (argc)
-		usagef("unrecognized argument: %s", argv[0]);
-	return 0;
+	return fn(argc, argv, prefix, repo);
 }
diff --git a/replay.c b/replay.c
index 8c2f2d3710..5203f9db4c 100644
--- a/replay.c
+++ b/replay.c
@@ -254,7 +254,9 @@ int replay_revisions(struct repository *repo, struct rev_info *revs,
 	struct commit *commit;
 	struct commit *onto = NULL;
 	struct merge_options merge_opt;
-	struct merge_result result;
+	struct merge_result result = {
+		.clean = 1,
+	};
 	char *advance;
 	int ret;
 
@@ -270,7 +272,6 @@ int replay_revisions(struct repository *repo, struct rev_info *revs,
 	}
 
 	init_basic_merge_options(&merge_opt, repo);
-	memset(&result, 0, sizeof(result));
 	merge_opt.show_rename_progress = 0;
 	last_commit = onto;
 	replayed_commits = kh_init_oid_map();
diff --git a/t/meson.build b/t/meson.build
index 73006b095a..c9f92450dc 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -388,6 +388,7 @@ integration_tests = [
   't3437-rebase-fixup-options.sh',
   't3438-rebase-broken-files.sh',
   't3450-history.sh',
+  't3451-history-reword.sh',
   't3500-cherry.sh',
   't3501-revert-cherry-pick.sh',
   't3502-cherry-pick-merge.sh',
diff --git a/t/t3450-history.sh b/t/t3450-history.sh
index 417c343d43..f513463b92 100755
--- a/t/t3450-history.sh
+++ b/t/t3450-history.sh
@@ -5,13 +5,13 @@ test_description='tests for git-history command'
 . ./test-lib.sh
 
 test_expect_success 'does nothing without any arguments' '
-	git history >out 2>&1 &&
-	test_must_be_empty out
+	test_must_fail git history 2>err &&
+	test_grep "need a subcommand" err
 '
 
 test_expect_success 'raises an error with unknown argument' '
 	test_must_fail git history garbage 2>err &&
-	test_grep "unrecognized argument: garbage" err
+	test_grep "unknown subcommand: .garbage." err
 '
 
 test_done
diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
new file mode 100755
index 0000000000..cd5883051d
--- /dev/null
+++ b/t/t3451-history-reword.sh
@@ -0,0 +1,344 @@
+#!/bin/sh
+
+test_description='tests for git-history reword subcommand'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY/lib-log-graph.sh"
+
+reword_with_message () {
+	cat >message &&
+	write_script fake-editor.sh <<-\EOF &&
+	cp message "$1"
+	EOF
+	test_set_editor "$(pwd)"/fake-editor.sh &&
+	git history reword "$@" &&
+	rm fake-editor.sh message
+}
+
+expect_graph () {
+	cat >expect &&
+	lib_test_cmp_graph --graph --format=%s "$@"
+}
+
+expect_log () {
+	git log --format="%s" "$@" >actual &&
+	cat >expect &&
+	test_cmp expect actual
+}
+
+test_expect_success 'can reword tip of a branch' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+
+		git symbolic-ref HEAD >expect &&
+		reword_with_message HEAD <<-EOF &&
+		third reworded
+		EOF
+		git symbolic-ref HEAD >actual &&
+		test_cmp expect actual &&
+
+		expect_log <<-\EOF &&
+		third reworded
+		second
+		first
+		EOF
+
+		git reflog >reflog &&
+		test_grep "reword: updating HEAD" reflog
+	)
+'
+
+test_expect_success 'can reword commit in the middle' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+
+		git symbolic-ref HEAD >expect &&
+		reword_with_message HEAD~ <<-EOF &&
+		second reworded
+		EOF
+		git symbolic-ref HEAD >actual &&
+		test_cmp expect actual &&
+
+		expect_log <<-\EOF
+		third
+		second reworded
+		first
+		EOF
+	)
+'
+
+test_expect_success 'can reword root commit' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+		reword_with_message HEAD~2 <<-EOF &&
+		first reworded
+		EOF
+
+		expect_log <<-\EOF
+		third
+		second
+		first reworded
+		EOF
+	)
+'
+
+test_expect_success 'can reword in a bare repo' '
+	test_when_finished "rm -rf repo repo.git" &&
+	git init repo &&
+	test_commit -C repo first &&
+	git clone --bare repo repo.git &&
+	(
+		cd repo.git &&
+		reword_with_message HEAD <<-EOF &&
+		reworded
+		EOF
+
+		expect_log <<-\EOF
+		reworded
+		EOF
+	)
+'
+
+test_expect_success 'can reword a commit on a different branch' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit base &&
+		git branch theirs &&
+		test_commit ours &&
+		git switch theirs &&
+		test_commit theirs &&
+
+		git rev-parse ours >ours-before &&
+		reword_with_message theirs <<-EOF &&
+		Reworded theirs
+		EOF
+		git rev-parse ours >ours-after &&
+		test_cmp ours-before ours-after &&
+
+		expect_graph --branches <<-\EOF
+		* Reworded theirs
+		| * ours
+		|/
+		* base
+		EOF
+	)
+'
+
+test_expect_success 'can reword a merge commit' '
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
+
+		# It is not possible to replay merge commits embedded in the
+		# history (yet).
+		test_must_fail git history reword HEAD~ 2>err &&
+		test_grep "replaying merge commits is not supported yet" err &&
+
+		# But it is possible to reword a merge commit directly.
+		reword_with_message HEAD <<-EOF &&
+		Reworded merge commit
+		EOF
+		expect_graph <<-\EOF
+		*   Reworded merge commit
+		|\
+		| * theirs
+		* | ours
+		|/
+		* base
+		EOF
+	)
+'
+
+test_expect_success '--ref-action=print prints ref updates without modifying repo' '
+	test_when_finished "rm -rf repo" &&
+	git init repo --initial-branch=main &&
+	(
+		cd repo &&
+		test_commit base &&
+		git branch branch &&
+		test_commit ours &&
+		git switch branch &&
+		test_commit theirs &&
+
+		git refs list >refs-expect &&
+		reword_with_message --ref-action=print base >updates <<-\EOF &&
+		reworded commit
+		EOF
+		git refs list >refs-actual &&
+		test_cmp refs-expect refs-actual &&
+
+		test_grep "update refs/heads/branch" updates &&
+		test_grep "update refs/heads/main" updates &&
+		git update-ref --stdin <updates &&
+		expect_log --branches <<-\EOF
+		theirs
+		ours
+		reworded commit
+		EOF
+	)
+'
+
+test_expect_success '--ref-action=head updates only HEAD' '
+	test_when_finished "rm -rf repo" &&
+	git init repo --initial-branch=main &&
+	(
+		cd repo &&
+		test_commit base &&
+		git branch branch &&
+		test_commit theirs &&
+		git switch branch &&
+		test_commit ours &&
+
+		# When told to update HEAD, only, the command will refuse to
+		# rewrite commits that are not an ancestor of HEAD.
+		test_must_fail git history reword --ref-action=head theirs 2>err &&
+		test_grep "rewritten commit must be an ancestor of HEAD" err &&
+
+		reword_with_message --ref-action=head base >updates <<-\EOF &&
+		reworded base
+		EOF
+		expect_log HEAD <<-\EOF &&
+		ours
+		reworded base
+		EOF
+		expect_log main <<-\EOF
+		theirs
+		base
+		EOF
+	)
+'
+
+test_expect_success 'editor shows proper status' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+
+		write_script fake-editor.sh <<-\EOF &&
+		cp "$1" . &&
+		printf "\namend a comment\n" >>"$1"
+		EOF
+		test_set_editor "$(pwd)"/fake-editor.sh &&
+		git history reword HEAD &&
+
+		cat >expect <<-EOF &&
+		first
+
+		# Please enter the commit message for the reworded changes. Lines starting
+		# with ${SQ}#${SQ} will be ignored, and an empty message aborts the commit.
+		# Changes to be committed:
+		#	new file:   first.t
+		#
+		EOF
+		test_cmp expect COMMIT_EDITMSG &&
+
+		test_commit_message HEAD <<-\EOF
+		first
+
+		amend a comment
+		EOF
+	)
+'
+
+# For now, git-history(1) does not yet execute any hooks. This is subject to
+# change in the future, and if it does this test here is expected to start
+# failing. In other words, this test is not an endorsement of the current
+# status quo.
+test_expect_success 'hooks are not executed for rewritten commits' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
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
+		reword_with_message HEAD~ <<-EOF &&
+		second reworded
+		EOF
+
+		cat >expect <<-EOF &&
+		third
+		second reworded
+		first
+		EOF
+		git log --format=%s >actual &&
+		test_cmp expect actual &&
+
+		test_path_is_missing hooks.log
+	)
+'
+
+test_expect_success 'aborts with empty commit message' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+
+		! reword_with_message HEAD 2>err </dev/null &&
+		test_grep "Aborting commit due to empty commit message." err
+	)
+'
+
+test_expect_success 'retains changes in the worktree and index' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		touch a b &&
+		git add . &&
+		git commit -m "initial commit" &&
+		echo foo >a &&
+		echo bar >b &&
+		git add b &&
+		reword_with_message HEAD <<-EOF &&
+		message
+		EOF
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
2.52.0.542.g9473a8513b.dirty


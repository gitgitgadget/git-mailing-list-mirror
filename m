Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B583090DC
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996070; cv=none; b=qHQsJ/g4vRzkz57SxbBBz9NHTqJMRNWg/SYppmG/ZipatMGNIj8GvV7xXDTH3/wFOnyKlQtFSNcHVBlnHJRSRYTbRNQRrW3IRbTCt8YZAcIVM83G7O4GtaC+DPNQXSnaITdZvMdvkadHXV2eWnHDd8zfrRkyVwASibuQjh4MQmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996070; c=relaxed/simple;
	bh=mL85XJoZjhC4M4FvOgL6XlxAT4gd2zSJewCEsl+K0YE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qKtpezfHaFU5uRV7Go/xL0VDDbGbKFrx21HcxtaK3f/xVqfNhePcQSMAH9zSc8SQExTB32lUO9j+7OdzpAeskvlbTRclKUrepLMxjB6gPCht2W0wMgq0ablFBwPHaWkUOqb3D74vOsSGj18bN05j0gjZaS8ui/SaSKty7DgMpZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LagHfVxM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YjLB7DSS; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LagHfVxM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YjLB7DSS"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 1B7471D00290;
	Thu,  4 Sep 2025 10:27:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 04 Sep 2025 10:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756996066;
	 x=1757082466; bh=iV8abwLdwMs1w3HnGWwl8DxBcth+xe8skVcSsNqhfa4=; b=
	LagHfVxM5PFCpWsVRTujaASfRZfq8Ji9X6lCBJRBPrz3OKAOXKLBuxV8ELg11Ddf
	Qcqj1QPQdgbvo77iM0fMwkI1L/jfMWv07mfK8knaHPgn8j4k4VGkjfOEeRTwvosv
	pAR/wBNCea09tXqKVpaHNASJY9zb94BjWLG6zkhBP+e9VJE0yI4xn48JDLk0my+K
	iPtWmCg0SK2GWpxvYrl3yUidjX6obe2aPd2/QkyJi9TQU9O+GXiCRj+TQXri5Un6
	3sUW/3F8GsH6aULfBfVsBOVujZJ45O+1Zp72oybTmF+wJtpohFEg+TZEDCypf4Yh
	hXBOmAmWiZC/FODgR5NcIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756996066; x=
	1757082466; bh=iV8abwLdwMs1w3HnGWwl8DxBcth+xe8skVcSsNqhfa4=; b=Y
	jLB7DSS9F56Nt5NbRV1D2CKfhKQpeOF0G++Wb2j95eoPm/O9QieSMI5coWFcngUo
	4Pp6FPH7hOzGE2zG9HUtezImGhpxENc2f0jQ9UzcBeks5AJmJi9Ox0t3/L20siH1
	uMNT7l4LWFYAJn9x3mJt417cynURlrYdXVFfZb7XGpG5Nztgq0V6X95X2DESGAc1
	FUWXQNjMualdfPW8hCVieO6wCcUtv6H1E2YELFSKurPIdnLFxg1M3ucA8NdJl3kZ
	k+Pn2zxDS+48WKkAIigXjJC+zMK+UlHUy8P4/6S0B23fkx1o/pVH7G+glGXeTxAH
	/8zXz/ELC7Ab0mvDJPunw==
X-ME-Sender: <xms:4qG5aLlkHdaHEGYaUjYfvFn99sU_R8Ln54LJu4sJZM6pQTZKRkfCng>
    <xme:4qG5aMb00cZve7j3ORAc5sw5XgexCgPGioECZkmPcp7qUZYsKKPMPlQ5vhAuVvEOp
    LtrpeZh6LLYEm3AaA>
X-ME-Received: <xmr:4qG5aIGKhjIy03Oo5xduR6O6yWuc42D04ZjnDkKF3ZhvwtZ3R8YOSgAoGTbnfMLnCd4kvjhCo_5jJWzlB6YxXrV94CEfrE0LpwWuT1b9WIu6ww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeivdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgs
    rghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnvhhonhiise
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hjnhdrrghvihhlrgesfhhrvggvrdhfrh
X-ME-Proxy: <xmx:4qG5aFKzWTjYcQqVzsu9cCyHpXiVHfzwQSEdc6PX3DtGve1d8hIRUQ>
    <xmx:4qG5aLNlMlOEe0T-sIiZQKFVwVILKSy6_2TMVg9dc0YC2mVBvUSIJQ>
    <xmx:4qG5aNl6siK5y7k4cM13NgnNLWe4ym51Oq5MJcq5zePCcQbp65DRYw>
    <xmx:4qG5aH4_0hyb6h60Z1XzwT-IqOPhWFnZo4g7dp0TDBGYewCcnkwmOA>
    <xmx:4qG5aKQKYRrsXsn_DMcPmIDhLJrmcvt3H4xrKV7Sod-axtUjzRZ2jyt2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 10:27:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bd999800 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 4 Sep 2025 14:27:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Sep 2025 16:27:33 +0200
Subject: [PATCH RFC v3 03/18] sequencer: introduce new history editing mode
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-b4-pks-history-builtin-v3-3-509053514755@pks.im>
References: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
In-Reply-To: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.2

Introduce a new history editing mode into our sequencer machinery. This
mode is basically the same as `REBASE_CHERRY`, but will be used by the
new git-history(1) command that is to be introduced in a subsequent
commit.

Note that the advice already points towards the git-history(1) command.
This advice is bogus right now, but we'll introduce the relevant infra
in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 sequencer.c | 116 +++++++++++++++++++++++++++++++++++++++++++++++-------------
 sequencer.h |   3 +-
 2 files changed, 93 insertions(+), 26 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index bff181df76..9a66e7d128 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -465,6 +465,8 @@ static const char *action_name(const struct replay_opts *opts)
 		return N_("cherry-pick");
 	case REPLAY_INTERACTIVE_REBASE:
 		return N_("rebase");
+	case REPLAY_HISTORY_EDIT:
+		return N_("history edit");
 	}
 	die(_("unknown action: %d"), opts->action);
 }
@@ -557,6 +559,13 @@ static void print_advice(struct repository *r, int show_hint,
 					    "You can instead skip this commit with \"git revert --skip\".\n"
 					    "To abort and get back to the state before \"git revert\",\n"
 					    "run \"git revert --abort\"."));
+		else if (opts->action == REPLAY_HISTORY_EDIT)
+			advise_if_enabled(ADVICE_MERGE_CONFLICT,
+					  _("After resolving the conflicts, mark them with\n"
+					    "\"git add/rm <pathspec>\", then run\n"
+					    "\"git history continue\".\n"
+					    "To abort and get back to the state before \"git history\",\n"
+					    "run \"git history abort\"."));
 		else
 			BUG("unexpected pick action in print_advice()");
 	}
@@ -1742,6 +1751,8 @@ static int do_commit(struct repository *r,
 		if (!res) {
 			refs_delete_ref(get_main_ref_store(r), "",
 					"CHERRY_PICK_HEAD", NULL, REF_NO_DEREF);
+			refs_delete_ref(get_main_ref_store(r), "",
+					"HISTORY_EDIT_HEAD", NULL, REF_NO_DEREF);
 			unlink(git_path_merge_msg(r));
 			if (!is_rebase_i(opts) && !opts->skip_commit_summary)
 				print_commit_summary(r, NULL, &oid,
@@ -2491,16 +2502,24 @@ static int do_pick_commit(struct repository *r,
 	 * However, if the merge did not even start, then we don't want to
 	 * write it at all.
 	 */
-	if ((command == TODO_PICK || command == TODO_REWORD ||
-	     command == TODO_EDIT) && !opts->no_commit &&
-	    (res == 0 || res == 1) &&
-	    refs_update_ref(get_main_ref_store(the_repository), NULL, "CHERRY_PICK_HEAD", &commit->object.oid, NULL,
-			    REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR))
-		res = -1;
-	if (command == TODO_REVERT && ((opts->no_commit && res == 0) || res == 1) &&
-	    refs_update_ref(get_main_ref_store(the_repository), NULL, "REVERT_HEAD", &commit->object.oid, NULL,
-			    REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR))
-		res = -1;
+	if (opts->action == REPLAY_HISTORY_EDIT && command == TODO_PICK &&
+	    !opts->no_commit && (res == 0 || res == 1)) {
+		if (refs_update_ref(get_main_ref_store(the_repository), NULL,
+				    "HISTORY_EDIT_HEAD", &commit->object.oid, NULL,
+				    REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR))
+			res = -1;
+	} else if ((command == TODO_PICK || command == TODO_REWORD ||
+		   command == TODO_EDIT) && !opts->no_commit && (res == 0 || res == 1)) {
+		if (refs_update_ref(get_main_ref_store(the_repository), NULL,
+				    "CHERRY_PICK_HEAD", &commit->object.oid, NULL,
+				    REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR))
+			res = -1;
+	} else if (command == TODO_REVERT && ((opts->no_commit && res == 0) || res == 1)) {
+		if (refs_update_ref(get_main_ref_store(the_repository), NULL,
+				    "REVERT_HEAD", &commit->object.oid, NULL,
+				    REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR))
+			res = -1;
+	}
 
 	if (res) {
 		error(command == TODO_REVERT
@@ -2526,6 +2545,8 @@ static int do_pick_commit(struct repository *r,
 		unlink(git_path_merge_msg(r));
 		refs_delete_ref(get_main_ref_store(r), "", "AUTO_MERGE",
 				NULL, REF_NO_DEREF);
+		refs_delete_ref(get_main_ref_store(r), "", "HISTORY_EDIT_HEAD",
+				NULL, REF_NO_DEREF);
 		fprintf(stderr,
 			_("dropping %s %s -- patch contents already upstream\n"),
 			oid_to_hex(&commit->object.oid), msg.subject);
@@ -2843,12 +2864,17 @@ static int parse_insn_line(struct repository *r, struct replay_opts *opts,
 	return 0;
 }
 
-int sequencer_get_last_command(struct repository *r UNUSED, enum replay_action *action)
+int sequencer_get_last_command(struct repository *r, enum replay_action *action)
 {
 	const char *todo_file, *bol;
 	struct strbuf buf = STRBUF_INIT;
 	int ret = 0;
 
+	if (refs_ref_exists(get_main_ref_store(r), "HISTORY_EDIT_HEAD")) {
+		*action = REPLAY_HISTORY_EDIT;
+		return 0;
+	}
+
 	todo_file = git_path_todo_file();
 	if (strbuf_read_file(&buf, todo_file, 0) < 0) {
 		if (errno == ENOENT || errno == ENOTDIR)
@@ -2995,6 +3021,15 @@ void sequencer_post_commit_cleanup(struct repository *r, int verbose)
 		need_cleanup = 1;
 	}
 
+	if (refs_ref_exists(get_main_ref_store(r), "HISTORY_EDIT_HEAD")) {
+		if (!refs_delete_ref(get_main_ref_store(r), "",
+				     "HISTORY_EDIT_HEAD", NULL, REF_NO_DEREF) &&
+		    verbose)
+			warning(_("cancelling a history edit in progress"));
+		opts.action = REPLAY_HISTORY_EDIT;
+		need_cleanup = 1;
+	}
+
 	if (refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD")) {
 		if (!refs_delete_ref(get_main_ref_store(r), "", "REVERT_HEAD",
 				     NULL, REF_NO_DEREF) &&
@@ -3028,6 +3063,19 @@ static void todo_list_write_total_nr(struct todo_list *todo_list)
 	}
 }
 
+static enum todo_command action_to_command(enum replay_action action)
+{
+	switch (action) {
+	case REPLAY_PICK:
+	case REPLAY_HISTORY_EDIT:
+		return TODO_PICK;
+	case REPLAY_REVERT:
+		return TODO_REVERT;
+	default:
+		BUG("unsupported action %d", action);
+	}
+}
+
 static int read_populate_todo(struct repository *r,
 			      struct todo_list *todo_list,
 			      struct replay_opts *opts)
@@ -3052,17 +3100,19 @@ static int read_populate_todo(struct repository *r,
 		return error(_("no commits parsed."));
 
 	if (!is_rebase_i(opts)) {
-		enum todo_command valid =
-			opts->action == REPLAY_PICK ? TODO_PICK : TODO_REVERT;
+		enum todo_command valid = action_to_command(opts->action);
 		int i;
 
-		for (i = 0; i < todo_list->nr; i++)
+		for (i = 0; i < todo_list->nr; i++) {
 			if (valid == todo_list->items[i].command)
 				continue;
 			else if (valid == TODO_PICK)
-				return error(_("cannot cherry-pick during a revert."));
+				return error(_("cannot cherry-pick during a %s."),
+					     action_name(opts));
 			else
-				return error(_("cannot revert during a cherry-pick."));
+				return error(_("cannot revert during a %s."),
+					     action_name(opts));
+		}
 	}
 
 	if (is_rebase_i(opts)) {
@@ -3353,15 +3403,16 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
 static int walk_revs_populate_todo(struct todo_list *todo_list,
 				struct replay_opts *opts)
 {
-	enum todo_command command = opts->action == REPLAY_PICK ?
-		TODO_PICK : TODO_REVERT;
-	const char *command_string = todo_command_info[command].str;
+	enum todo_command command;
+	const char *command_string;
 	const char *encoding;
 	struct commit *commit;
 
 	if (prepare_revs(opts))
 		return -1;
 
+	command = action_to_command(opts->action);
+	command_string = todo_command_info[command].str;
 	encoding = get_log_output_encoding();
 
 	while ((commit = get_revision(opts->revs))) {
@@ -3412,6 +3463,11 @@ static int create_seq_dir(struct repository *r)
 			in_progress_advice =
 			_("try \"git cherry-pick (--continue | %s--abort | --quit)\"");
 			break;
+		case REPLAY_HISTORY_EDIT:
+			in_progress_error = _("history edit is already in progress");
+			in_progress_advice =
+			_("try \"git history (continue | abort | quit)\"");
+			break;
 		default:
 			BUG("unexpected action in create_seq_dir");
 		}
@@ -3472,13 +3528,14 @@ static int reset_merge(const struct object_id *oid)
 	return run_command(&cmd);
 }
 
-static int rollback_single_pick(struct repository *r)
+static int rollback_single_pick(struct repository *r, struct replay_opts *opts)
 {
 	struct object_id head_oid;
 
 	if (!refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD") &&
+	    !refs_ref_exists(get_main_ref_store(r), "HISTORY_EDIT_HEAD") &&
 	    !refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD"))
-		return error(_("no cherry-pick or revert in progress"));
+		return error(_("no %s in progress"), action_name(opts));
 	if (refs_read_ref_full(get_main_ref_store(the_repository), "HEAD", 0, &head_oid, NULL))
 		return error(_("cannot resolve HEAD"));
 	if (is_null_oid(&head_oid))
@@ -3509,7 +3566,7 @@ int sequencer_rollback(struct repository *r, struct replay_opts *opts)
 		 * If CHERRY_PICK_HEAD or REVERT_HEAD indicates
 		 * a single-cherry-pick in progress, abort that.
 		 */
-		return rollback_single_pick(r);
+		return rollback_single_pick(r, opts);
 	}
 	if (!f)
 		return error_errno(_("cannot open '%s'"), git_path_head_file());
@@ -5213,8 +5270,9 @@ static int continue_single_pick(struct repository *r, struct replay_opts *opts)
 	struct child_process cmd = CHILD_PROCESS_INIT;
 
 	if (!refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD") &&
+	    !refs_ref_exists(get_main_ref_store(r), "HISTORY_EDIT_HEAD") &&
 	    !refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD"))
-		return error(_("no cherry-pick or revert in progress"));
+		return error(_("no %s in progress"), action_name(opts));
 
 	cmd.git_cmd = 1;
 	strvec_push(&cmd.args, "commit");
@@ -5393,6 +5451,14 @@ static int commit_staged_changes(struct repository *r,
 			goto out;
 		}
 
+		if (refs_ref_exists(get_main_ref_store(r),
+				    "HISTORY_EDIT_HEAD") &&
+		    refs_delete_ref(get_main_ref_store(r), "",
+				    "HISTORY_EDIT_HEAD", NULL, REF_NO_DEREF)) {
+			ret = error(_("could not remove HISTORY_EDIT_HEAD"));
+			goto out;
+		}
+
 		if (unlink(git_path_merge_msg(r)) && errno != ENOENT) {
 			ret = error_errno(_("could not remove '%s'"),
 					  git_path_merge_msg(r));
@@ -5471,6 +5537,7 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 		/* Verify that the conflict has been resolved */
 		if (refs_ref_exists(get_main_ref_store(r),
 				    "CHERRY_PICK_HEAD") ||
+		    refs_ref_exists(get_main_ref_store(r), "HISTORY_EDIT_HEAD") ||
 		    refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD")) {
 			res = continue_single_pick(r, opts);
 			if (res)
@@ -5505,8 +5572,7 @@ static int single_pick(struct repository *r,
 	int check_todo;
 	struct todo_item item;
 
-	item.command = opts->action == REPLAY_PICK ?
-			TODO_PICK : TODO_REVERT;
+	item.command = action_to_command(opts->action);
 	item.commit = cmit;
 
 	return do_pick_commit(r, &item, opts, 0, &check_todo);
diff --git a/sequencer.h b/sequencer.h
index a905f6afc7..082fbe3e35 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -21,7 +21,8 @@ extern const char *rebase_resolvemsg;
 enum replay_action {
 	REPLAY_REVERT,
 	REPLAY_PICK,
-	REPLAY_INTERACTIVE_REBASE
+	REPLAY_INTERACTIVE_REBASE,
+	REPLAY_HISTORY_EDIT,
 };
 
 enum commit_msg_cleanup_mode {

-- 
2.51.0.417.g1ba7204a04.dirty


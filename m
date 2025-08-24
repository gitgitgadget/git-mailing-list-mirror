Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B421CA92E
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 17:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756057376; cv=none; b=pKPx27lY5Yh4GI8rGq08aSAZoF0w7RogkWMn3wpKQMuHRmPuTqisxeXnKR9F+TSio+5Y+AoI0YtbUfrNSTM62b8g7sP0SMqHncIMu2Ly5sduw0QpJ41ZMQ0u825t9GbyWJettgNj7zTusmHSwu2r5BUelq8dTy1x1bV20EU3Yk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756057376; c=relaxed/simple;
	bh=K4OusrpyMZcb3vNm66OvBwvarvq20LpdhB3nepU4D+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oOa1OZ5gs0HrRmgHDIM7WGjOMoGekImfmUOxv1JLzBUvSelRVlpnMZI3ZhZ0Vq0PxO/VpTA3w1m5/4dXyuZeq3kRdCbUjFrCYIDa44uDKSlu4PKL+vtabARjWpJlb3NJHO5B9pZ6vHBf/gKoNgE0iBDXdpCmlsdYBy0zBAjF5Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HBs5QgIO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RxILA13V; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HBs5QgIO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RxILA13V"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8DE627A00C3;
	Sun, 24 Aug 2025 13:42:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 24 Aug 2025 13:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756057373;
	 x=1756143773; bh=Y3n1Ufntg2RPtZ2E8xhhgCgVwkDPGqqNWYi42MAS7po=; b=
	HBs5QgIOQ5CvFNtGxo6gWeXvfqT8Ql901pk9n00LKe1pi4fsUOssAClAtvsrVH9U
	d9q/r0Bt0oc5QR58TIGUdtJlX65aKLqLCH6J+9sRArC8U9cNgloHI6m1MAm8w48c
	FTaxI5EUKE5V+mBsTJL3xWdm5LB1Q++BJDgcSa1YlOHNeX2GEY1oLLJWjnWz62rA
	EMOLfqAAyyqK/0MkNXOCRjGfPyoZOmEs5cEGMtm1lIGbzAU8mE1Y1pW8ev3egdb7
	ucGuSMFAmGQ9QZz4UX2jn/jdIaOEjlAEGtdaf3mlFCEYKo7IfxXBQQxhI7NgFg33
	rPiXgx9c3V45FRu+I9jvBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1756057373; x=
	1756143773; bh=Y3n1Ufntg2RPtZ2E8xhhgCgVwkDPGqqNWYi42MAS7po=; b=R
	xILA13VUNs23n80WioNGLblOnvyh9MVeRPQSLzm91CENDDZej/g8ejg/2Kv8okkl
	+q+hi7epvLuPcFm9KXn2fvCt+An8Qt7LQ3YNKEaiHddp7UVgnDZiw/5CMwA67mi0
	xmIpX/3qWD6lDelKpvudGCikiAUpwIxVnjhINKcIiXhxGh1TxAo2RRsg0iMk+ZFH
	tTYPoo7bzVFkYKg4fYxfo3JwgwyfJwMMKUYHxv2bqWaEa/ZZll+8CB0p/seXPRii
	sAac5jz6AhO/BR6VEi0gfDojLIOlMsONZUVcoSCDkCJ5rjFphHgDwBFGbaShIwv5
	I6gjNuvSNEUSw4hXN487A==
X-ME-Sender: <xms:HU-raJbEQ_F4tLTdRG3MALhFXaQQF4zBpWQBN3ApDFN5NSTZ3iHQ4Q>
    <xme:HU-raN9TBdZB0lEFbPBgKX0JwYD6Ipv2k1Hk_UOb5GDhf7NaqTna4YIELhNxV2RA0
    1Z04qug82C2iqD1cg>
X-ME-Received: <xmr:HU-raCZ-4itC1oioGGZfgs-E90kKQVJZoweTxWZdwKFsbZHE788mtbz8TmjZ3PFjTS0gxN3vED0aeJz-cOvcKkwF-tffphguTzC4ErNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedtudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinh
    hvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggv
    rdhfrhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoh
    epsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:HU-raJOugrPZzor_AeGtoHBPaxovwIj8-6PMPXQ7pH_XL5PJJVo9Qw>
    <xmx:HU-raGDGTZOKWF7zJ_cVbcPWJ88tGYA6sax0UpBZitkJ5SvWvkp8zA>
    <xmx:HU-raIISsiy9BV76dY-RWX18laFmu9uXvaFMKMLOQc449M7Imyz5Dw>
    <xmx:HU-raHOos16inxPrnboX_Y7FlmHICHx9JvlyF34Mzo2QOUPU1X5NOg>
    <xmx:HU-raD2r2pzJMuyKbXyS_hW4vMGx0WQlV9s2ZK7OrPzuJ-8p5k-4F0MQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Aug 2025 13:42:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 149bf1f4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 24 Aug 2025 17:42:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sun, 24 Aug 2025 19:42:16 +0200
Subject: [PATCH RFC v2 03/16] sequencer: introduce new history editing mode
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250824-b4-pks-history-builtin-v2-3-964ac12f65bd@pks.im>
References: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
In-Reply-To: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
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
 sequencer.c        | 130 ++++++++++++++++++++++++++++++++++++++++++-----------
 sequencer.h        |   3 +-
 t/t3450-history.sh |  12 +++++
 3 files changed, 119 insertions(+), 26 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index bff181df76..898ac1a2a8 100644
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
@@ -3052,17 +3087,29 @@ static int read_populate_todo(struct repository *r,
 		return error(_("no commits parsed."));
 
 	if (!is_rebase_i(opts)) {
-		enum todo_command valid =
-			opts->action == REPLAY_PICK ? TODO_PICK : TODO_REVERT;
+		enum todo_command valid;
 		int i;
 
-		for (i = 0; i < todo_list->nr; i++)
+		switch (opts->action) {
+		case REPLAY_PICK:
+		case REPLAY_HISTORY_EDIT:
+			valid = TODO_PICK;
+			break;
+		default:
+			valid = TODO_REVERT;
+			break;
+		}
+
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
@@ -3353,15 +3400,25 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
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
 
+	switch (opts->action) {
+	case REPLAY_PICK:
+	case REPLAY_HISTORY_EDIT:
+		command = TODO_PICK;
+		break;
+	default:
+		command = TODO_REVERT;
+		break;
+	}
+
+	command_string = todo_command_info[command].str;
 	encoding = get_log_output_encoding();
 
 	while ((commit = get_revision(opts->revs))) {
@@ -3412,6 +3469,11 @@ static int create_seq_dir(struct repository *r)
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
@@ -3472,13 +3534,14 @@ static int reset_merge(const struct object_id *oid)
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
@@ -3509,7 +3572,7 @@ int sequencer_rollback(struct repository *r, struct replay_opts *opts)
 		 * If CHERRY_PICK_HEAD or REVERT_HEAD indicates
 		 * a single-cherry-pick in progress, abort that.
 		 */
-		return rollback_single_pick(r);
+		return rollback_single_pick(r, opts);
 	}
 	if (!f)
 		return error_errno(_("cannot open '%s'"), git_path_head_file());
@@ -5213,8 +5276,9 @@ static int continue_single_pick(struct repository *r, struct replay_opts *opts)
 	struct child_process cmd = CHILD_PROCESS_INIT;
 
 	if (!refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD") &&
+	    !refs_ref_exists(get_main_ref_store(r), "HISTORY_EDIT_HEAD") &&
 	    !refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD"))
-		return error(_("no cherry-pick or revert in progress"));
+		return error(_("no %s in progress"), action_name(opts));
 
 	cmd.git_cmd = 1;
 	strvec_push(&cmd.args, "commit");
@@ -5393,6 +5457,14 @@ static int commit_staged_changes(struct repository *r,
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
@@ -5471,6 +5543,7 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 		/* Verify that the conflict has been resolved */
 		if (refs_ref_exists(get_main_ref_store(r),
 				    "CHERRY_PICK_HEAD") ||
+		    refs_ref_exists(get_main_ref_store(r), "HISTORY_EDIT_HEAD") ||
 		    refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD")) {
 			res = continue_single_pick(r, opts);
 			if (res)
@@ -5505,8 +5578,15 @@ static int single_pick(struct repository *r,
 	int check_todo;
 	struct todo_item item;
 
-	item.command = opts->action == REPLAY_PICK ?
-			TODO_PICK : TODO_REVERT;
+	switch (opts->action) {
+	case REPLAY_PICK:
+	case REPLAY_HISTORY_EDIT:
+		item.command = TODO_PICK;
+		break;
+	default:
+		item.command = TODO_REVERT;
+		break;
+	}
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
diff --git a/t/t3450-history.sh b/t/t3450-history.sh
new file mode 100755
index 0000000000..9eb1ed6749
--- /dev/null
+++ b/t/t3450-history.sh
@@ -0,0 +1,12 @@
+#!/bin/sh
+
+test_description='tests for git-history command'
+
+. ./test-lib.sh
+
+test_expect_success 'refuses to do anything without subcommand' '
+	test_must_fail git history 2>err &&
+	test_grep foo err
+'
+
+test_done

-- 
2.51.0.308.g032396e0da.dirty


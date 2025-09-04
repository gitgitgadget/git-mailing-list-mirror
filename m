Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C249630AAB6
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 14:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996076; cv=none; b=qHCvLWC/LgkSjxbUZEzQQhpLb8fqTR3xbzueILDRBzmS8FovDwvh6LG7H4XNwWC/Jk1edIpo6k7aYNAPbVtuRBoemGRgf4xiRjim8sGVUqBVdpkLzRK/vCbs6L+2bIBM35U1pFuBpQObV/PpZirvLSuHhHPD9KhZn00iVl+eQkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996076; c=relaxed/simple;
	bh=IY2jrLAOlBqx1ilOD1uUX5ndxHP/d2uoUEG1fT996aA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oz62+xOqoIDnyULkeTRB3dPAFv8MLZZzuW/gZRlSME2r7G+XGFPrAqb9d7366+O/VAMntTmo9VRi3sNZWuG0W1Y7AJKCYnv7JdKJqWo2O7FpYbQdUHwExT0abEkSugU3tUxtYnPSSDgOelkmnUIWhtMpB0Wjlj+PM3x+9Hd6Aus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kK5auo42; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SvPWs8dB; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kK5auo42";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SvPWs8dB"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AB7CD7A034B;
	Thu,  4 Sep 2025 10:27:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 04 Sep 2025 10:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756996073;
	 x=1757082473; bh=X9ScWhZ1/qaNydrgQdFEPvRNsnj8LF7sT5XayoD3lII=; b=
	kK5auo42fmvuTsLbfgLQoO1EREk52eqAJVfq/rv2X92PSeiOWniQVl9x0H154lya
	Vfk/roVwWGcK76ZIgbNqm89hCXxnr0WDku4pY2A0bn/qDqmulF5pypVhBX/oObN+
	tjpMykmOkOZARiE5bvo+z0awNxaDYulMGogCCFWVGd096csOhKGxi+2ktbbE1siN
	h5XFYxeHWtWUZHWxabEX15c9rLCWU3yq8cQowGca9Xu71x7AQseTFTqZ6S7iOcPP
	RUz2w3Fjhe/ZRnF//0LCuoS3NcG8b8iaiuSRMyf6SL41jMG+RfzXl1iWlxIW5tH5
	N4gZH4P0TGLvN+lCvaFSbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756996073; x=
	1757082473; bh=X9ScWhZ1/qaNydrgQdFEPvRNsnj8LF7sT5XayoD3lII=; b=S
	vPWs8dB9jhmr0sQ9dsZHddO9HJUQfy1gy200KL5/HKVBoD1utiuF3PGTZV388u8Q
	pi/iFKc+0bLcXrJpU7terveNb2SGaVaMdBSpo9rJ0J0WiGeyO/dQacR/w6ZR1/a6
	pJqr5bsa9MOabHK3OASUBldi1HMPlp9uJpji1yLS1rKW9nCcAgJAQJq9XAtRfr/p
	waXP5Rh4cHHtcIYTK4L0TN/cjHC2sH/weAGD0c622aXEVYDuGIXnca9noc6b0xLY
	0ZFEbtWd6lZslnq7SAOikcg4SYEV8A0SYsgCF9pWVvAgjm+kXLXwAbnu6JDxE5zd
	5bgnxwP13X6bPjU7UhORw==
X-ME-Sender: <xms:6aG5aD7hiV8eu-Gq1yIK3OgT9XR1O35R-Zo6Jn7nlSquvq3rDK0E8w>
    <xme:6aG5aGd3fuKaIUfq4djNh-T55kzm9EXLrPcOmarij_wHBJkm4L203pegtXKpxOUvE
    qOmWu3GmzNSA5ZVgA>
X-ME-Received: <xmr:6aG5aA7PwgJyDX0rBUsmWmOPeW_--B3q3a1c6iNWXlPlyyUfrcnoekf0fWpb85HRyTkn1eFbH1pqxQmtZoXwvbUly9H2PKXTvDZGwzjyJOhHhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeivdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucev
    lhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinhhvoh
    hniiesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtth
    hopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdp
    rhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhope
    hjnhdrrghvihhlrgesfhhrvggvrdhfrh
X-ME-Proxy: <xmx:6aG5aFuRlX9yFBIRxlqtkq2mPci3U6MbNrUma4Lqm_CYKuGgVHTyWQ>
    <xmx:6aG5aIgFeO_cFRldTLiiv0xzEvX0lTp05ywRXgYDue1FK8lDbxGshw>
    <xmx:6aG5aIrmTEi5_bOPB04hAl4outSOkzHydKDg5Beo-oyw0Ov1VCfxuQ>
    <xmx:6aG5aNsff6HfqQIxY33mA97qdBCm3dq6Fxk6BcFBPtF4NFiBcVsHpQ>
    <xmx:6aG5aMX6Gr9jl7i0QR-bg4zWg6h0upxS_WVc_xTdqjQp0q1H2wWaVoH4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 10:27:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 41bcb0ad (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 4 Sep 2025 14:27:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Sep 2025 16:27:35 +0200
Subject: [PATCH RFC v3 05/18] sequencer: wire up "rewritten-hook" for
 REPLAY_HISTORY_EDIT
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-b4-pks-history-builtin-v3-5-509053514755@pks.im>
References: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
In-Reply-To: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.2

While the sequencer already knows to drive REPLAY_HISTORY_EDIT, we
currently skip the execution of the "rewritten-hook" as it is only
specific to interactive rebases. We do want to execute this hook though
for commits we're rewriting in the upcoming git-history(1) command.

Wire up the infrastructure so that we also execute this hook with
REPLAY_HISTORY_EDIT.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 sequencer.c | 79 +++++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 56 insertions(+), 23 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 36e4db8526..61447e5ccf 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -70,6 +70,8 @@ static GIT_PATH_FUNC(git_path_seq_dir, "sequencer")
 static GIT_PATH_FUNC(git_path_todo_file, "sequencer/todo")
 static GIT_PATH_FUNC(git_path_opts_file, "sequencer/opts")
 static GIT_PATH_FUNC(git_path_head_file, "sequencer/head")
+static GIT_PATH_FUNC(git_path_rewritten_list_file, "sequencer/rewritten-list")
+static GIT_PATH_FUNC(git_path_rewritten_pending_file, "sequencer/rewritten-pending")
 static GIT_PATH_FUNC(git_path_abort_safety_file, "sequencer/abort-safety")
 
 static GIT_PATH_FUNC(rebase_path, "rebase-merge")
@@ -2170,15 +2172,25 @@ static int update_squash_messages(struct repository *r,
 	return res;
 }
 
-static void flush_rewritten_pending(void)
+static void flush_rewritten_pending(struct replay_opts *opts)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct object_id newoid;
+	const char *pending_path;
+	const char *list_path;
 	FILE *out;
 
-	if (strbuf_read_file(&buf, rebase_path_rewritten_pending(), (GIT_MAX_HEXSZ + 1) * 2) > 0 &&
+	if (opts->action == REPLAY_HISTORY_EDIT) {
+		pending_path = git_path_rewritten_pending_file();
+		list_path = git_path_rewritten_list_file();
+	} else {
+		pending_path = rebase_path_rewritten_pending();
+		list_path = rebase_path_rewritten_list();
+	}
+
+	if (strbuf_read_file(&buf, pending_path, (GIT_MAX_HEXSZ + 1) * 2) > 0 &&
 	    !repo_get_oid(the_repository, "HEAD", &newoid) &&
-	    (out = fopen_or_warn(rebase_path_rewritten_list(), "a"))) {
+	    (out = fopen_or_warn(list_path, "a"))) {
 		char *bol = buf.buf, *eol;
 
 		while (*bol) {
@@ -2190,16 +2202,24 @@ static void flush_rewritten_pending(void)
 			bol = eol + 1;
 		}
 		fclose(out);
-		unlink(rebase_path_rewritten_pending());
+		unlink(pending_path);
 	}
 	strbuf_release(&buf);
 }
 
 static void record_in_rewritten(struct object_id *oid,
-		enum todo_command next_command)
+				enum todo_command next_command,
+				struct replay_opts *opts)
 {
-	FILE *out = fopen_or_warn(rebase_path_rewritten_pending(), "a");
+	const char *path;
+	FILE *out;
 
+	if (opts->action == REPLAY_HISTORY_EDIT)
+		path = git_path_rewritten_pending_file();
+	else
+		path = rebase_path_rewritten_pending();
+
+	out = fopen_or_warn(path, "a");
 	if (!out)
 		return;
 
@@ -2207,7 +2227,7 @@ static void record_in_rewritten(struct object_id *oid,
 	fclose(out);
 
 	if (!is_fixup(next_command))
-		flush_rewritten_pending();
+		flush_rewritten_pending(opts);
 }
 
 static int should_edit(struct replay_opts *opts) {
@@ -4984,9 +5004,9 @@ static int pick_one_commit(struct repository *r,
 		return error_with_patch(r, commit,
 					arg, item->arg_len, opts, res, !res);
 	}
-	if (is_rebase_i(opts) && !res)
+	if ((is_rebase_i(opts) || opts->action == REPLAY_HISTORY_EDIT) && !res)
 		record_in_rewritten(&item->commit->object.oid,
-				    peek_command(todo_list, 1));
+				    peek_command(todo_list, 1), opts);
 	if (res && is_fixup(item->command)) {
 		if (res == 1)
 			intend_to_amend();
@@ -5020,6 +5040,7 @@ static int pick_commits(struct repository *r,
 			struct todo_list *todo_list,
 			struct replay_opts *opts)
 {
+	struct strbuf head_ref = STRBUF_INIT, buf = STRBUF_INIT;
 	struct replay_ctx *ctx = opts->ctx;
 	int res = 0, reschedule = 0;
 
@@ -5106,7 +5127,7 @@ static int pick_commits(struct repository *r,
 				reschedule = 1;
 			else if (item->commit)
 				record_in_rewritten(&item->commit->object.oid,
-						    peek_command(todo_list, 1));
+						    peek_command(todo_list, 1), opts);
 			if (res > 0)
 				/* failed with merge conflicts */
 				return error_with_patch(r, item->commit,
@@ -5142,9 +5163,6 @@ static int pick_commits(struct repository *r,
 	}
 
 	if (is_rebase_i(opts)) {
-		struct strbuf head_ref = STRBUF_INIT, buf = STRBUF_INIT;
-		struct stat st;
-
 		if (read_oneliner(&head_ref, rebase_path_head_name(), 0) &&
 				starts_with(head_ref.buf, "refs/")) {
 			const char *msg;
@@ -5206,13 +5224,24 @@ static int pick_commits(struct repository *r,
 			}
 			release_revisions(&log_tree_opt);
 		}
-		flush_rewritten_pending();
-		if (!stat(rebase_path_rewritten_list(), &st) &&
-				st.st_size > 0) {
+	}
+
+	if (is_rebase_i(opts) || opts->action == REPLAY_HISTORY_EDIT) {
+		const char *rewritten_list_path;
+		struct stat st;
+
+		flush_rewritten_pending(opts);
+
+		if (opts->action == REPLAY_HISTORY_EDIT)
+			rewritten_list_path = git_path_rewritten_list_file();
+		else
+			rewritten_list_path = rebase_path_rewritten_list();
+
+		if (!stat(rewritten_list_path, &st) && st.st_size > 0) {
 			struct child_process child = CHILD_PROCESS_INIT;
 			struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
 
-			child.in = open(rebase_path_rewritten_list(), O_RDONLY);
+			child.in = open(rewritten_list_path, O_RDONLY);
 			child.git_cmd = 1;
 			strvec_push(&child.args, "notes");
 			strvec_push(&child.args, "copy");
@@ -5220,10 +5249,13 @@ static int pick_commits(struct repository *r,
 			/* we don't care if this copying failed */
 			run_command(&child);
 
-			hook_opt.path_to_stdin = rebase_path_rewritten_list();
-			strvec_push(&hook_opt.args, "rebase");
+			hook_opt.path_to_stdin = rewritten_list_path;
+			strvec_push(&hook_opt.args, is_rebase_i(opts) ? "rebase" : "history");
 			run_hooks_opt(r, "post-rewrite", &hook_opt);
 		}
+	}
+
+	if (is_rebase_i(opts)) {
 		apply_autostash(rebase_path_autostash());
 
 		if (!opts->quiet) {
@@ -5555,7 +5587,7 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 		if (read_oneliner(&buf, rebase_path_stopped_sha(),
 				  READ_ONELINER_SKIP_IF_EMPTY) &&
 		    !get_oid_hex(buf.buf, &oid))
-			record_in_rewritten(&oid, peek_command(&todo_list, 0));
+			record_in_rewritten(&oid, peek_command(&todo_list, 0), opts);
 		strbuf_release(&buf);
 	}
 
@@ -6396,7 +6428,8 @@ int todo_list_write_to_file(struct repository *r, struct todo_list *todo_list,
 /* skip picking commits whose parents are unchanged */
 static int skip_unnecessary_picks(struct repository *r,
 				  struct todo_list *todo_list,
-				  struct object_id *base_oid)
+				  struct object_id *base_oid,
+				  struct replay_opts *opts)
 {
 	struct object_id *parent_oid;
 	int i;
@@ -6435,7 +6468,7 @@ static int skip_unnecessary_picks(struct repository *r,
 		todo_list->done_nr += i;
 
 		if (is_fixup(peek_command(todo_list, 0)))
-			record_in_rewritten(base_oid, peek_command(todo_list, 0));
+			record_in_rewritten(base_oid, peek_command(todo_list, 0), opts);
 	}
 
 	return 0;
@@ -6630,7 +6663,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		BUG("invalid todo list after expanding IDs:\n%s",
 		    new_todo.buf.buf);
 
-	if (opts->allow_ff && skip_unnecessary_picks(r, &new_todo, &oid)) {
+	if (opts->allow_ff && skip_unnecessary_picks(r, &new_todo, &oid, opts)) {
 		todo_list_release(&new_todo);
 		return error(_("could not skip unnecessary pick commands"));
 	}

-- 
2.51.0.417.g1ba7204a04.dirty


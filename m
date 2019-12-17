Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23150C2D0D1
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 10:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC912072D
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 10:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrnxeuZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfLQKlO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 05:41:14 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33905 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfLQKlN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 05:41:13 -0500
Received: by mail-wr1-f66.google.com with SMTP id t2so10757103wrr.1
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 02:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iKYjsTVoHCPqhKRIOYQ7xpxTcpGdRZqXJQ/3ZOkY8vg=;
        b=FrnxeuZTkfdXDQmYoOczx7gFMirJS+CSqPo3qNCE3zpIrZmd4SWOPwo1o3yHNwaSEh
         Tv3x1KTmSslms7PRQKSwbx52tHahp3LOZx7aXzZkr9NkhVd6QMRsAmbv74HJfTNpASm2
         k5y29teG5WMHu7iy3e9Pv23g7z6IWKGCfSUKaFTJdqo1eS440MS7L22WZ3wx9m7mmIiL
         99JFfF7QIZWh0waWQvlaRBWCtxor1A/ZNLXfzyABm65iUD+FRhoEbnNJCIatWcpBmpne
         zR1QnipDB32sq4bQAIrq52eS6eIDfAOiVsJ4JZGXvJbNR2gdKFgnUACAzmvFpCAXJTC2
         zUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iKYjsTVoHCPqhKRIOYQ7xpxTcpGdRZqXJQ/3ZOkY8vg=;
        b=JheUUkNVoNG+cEsPe06O75AhcsgyMielPF7v9SpYU30OJVeStuhgwYWQMdfaffLZCw
         EpvKV5wUvJ6yjK6Nk+H5dHkuQrCWqQravMg4D5LokKHTCuKv/1k1WDjyMfobZaZCOU1R
         yfSXgssu7FKcu+uDmtvZ4JSTVJkb919rgizPm1C82qBXsGZy1lzq8fWXEcMQctDd2RkM
         NXghUqQ5UyIc5ONOkbewm7XrO5xG8+SkXjb9bOpg44lZMT4zUzTLhvstbg8zDI8iMRpu
         NUwZYUz0MJpjkO9kmZYPO21mtdRrpA4gewB9xfQi9Ft9BnEzrjHmIohprzktcIVqsIw3
         Nl4w==
X-Gm-Message-State: APjAAAXUPv+y2s5yzEyywHbh2qvob+d/fSmag3nN9AHeW/twZ14aBdVo
        1o3FP+o7FudPDBA617LoZ2BTdsKn
X-Google-Smtp-Source: APXvYqxUirBTetksPgenBCgGjgMBJHKyAJbyWYBVjHSfV1U/SR/AhSqDHoC0etwU+D3RefjgTDgHDQ==
X-Received: by 2002:a05:6000:cb:: with SMTP id q11mr34995390wrx.14.1576579270467;
        Tue, 17 Dec 2019 02:41:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c4sm2556657wml.7.2019.12.17.02.41.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 02:41:10 -0800 (PST)
Message-Id: <3c55f106c7e5f246d4bc55256249cd0bf7183dd8.1576579264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.174.git.1576579264.gitgitgadget@gmail.com>
References: <pull.174.git.1576579264.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Dec 2019 10:41:02 +0000
Subject: [PATCH 5/7] built-in add -p: implement the "checkout" patch modes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This patch teaches the built-in `git add -p` machinery all the tricks it
needs to know in order to act as the work horse for `git checkout -p`.

Apart from the minor changes (slightly reworded messages, different
`diff` and `apply --check` invocations), it requires a new function to
actually apply the changes, as `git checkout -p` is a bit special in
that respect: when the desired changes do not apply to the index, but
apply to the work tree, Git does not fail straight away, but asks the
user whether to apply the changes to the worktree at least.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.h |   1 +
 add-patch.c       | 139 ++++++++++++++++++++++++++++++++++++++++++++--
 builtin/add.c     |   5 +-
 3 files changed, 138 insertions(+), 7 deletions(-)

diff --git a/add-interactive.h b/add-interactive.h
index c278f3e26f..f865f1e8ca 100644
--- a/add-interactive.h
+++ b/add-interactive.h
@@ -27,6 +27,7 @@ enum add_p_mode {
 	ADD_P_STAGE,
 	ADD_P_STASH,
 	ADD_P_RESET,
+	ADD_P_CHECKOUT,
 };
 
 int run_add_p(struct repository *r, enum add_p_mode mode,
diff --git a/add-patch.c b/add-patch.c
index 694e8e6624..dea99a79a4 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -108,6 +108,72 @@ static struct patch_mode patch_mode_reset_nothead = {
 			"the file\n"),
 };
 
+static struct patch_mode patch_mode_checkout_index = {
+	.diff = { "diff-files", NULL },
+	.apply = { "-R", NULL },
+	.apply_check = { "-R", NULL },
+	.is_reverse = 1,
+	.prompt_mode = {
+		N_("Discard mode change from worktree [y,n,q,a,d%s,?]? "),
+		N_("Discard deletion from worktree [y,n,q,a,d%s,?]? "),
+		N_("Discard this hunk from worktree [y,n,q,a,d%s,?]? "),
+	},
+	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
+			     "will immediately be marked for discarding."),
+	.help_patch_text =
+		N_("y - discard this hunk from worktree\n"
+		   "n - do not discard this hunk from worktree\n"
+		   "q - quit; do not discard this hunk or any of the remaining "
+			"ones\n"
+		   "a - discard this hunk and all later hunks in the file\n"
+		   "d - do not discard this hunk or any of the later hunks in "
+			"the file\n"),
+};
+
+static struct patch_mode patch_mode_checkout_head = {
+	.diff = { "diff-index", NULL },
+	.apply_for_checkout = 1,
+	.apply_check = { "-R", NULL },
+	.is_reverse = 1,
+	.prompt_mode = {
+		N_("Discard mode change from index and worktree [y,n,q,a,d%s,?]? "),
+		N_("Discard deletion from index and worktree [y,n,q,a,d%s,?]? "),
+		N_("Discard this hunk from index and worktree [y,n,q,a,d%s,?]? "),
+	},
+	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
+			     "will immediately be marked for discarding."),
+	.help_patch_text =
+		N_("y - discard this hunk from index and worktree\n"
+		   "n - do not discard this hunk from index and worktree\n"
+		   "q - quit; do not discard this hunk or any of the remaining "
+			"ones\n"
+		   "a - discard this hunk and all later hunks in the file\n"
+		   "d - do not discard this hunk or any of the later hunks in "
+			"the file\n"),
+};
+
+static struct patch_mode patch_mode_checkout_nothead = {
+	.diff = { "diff-index", "-R", NULL },
+	.apply_for_checkout = 1,
+	.apply_check = { NULL },
+	.is_reverse = 0,
+	.prompt_mode = {
+		N_("Apply mode change to index and worktree [y,n,q,a,d%s,?]? "),
+		N_("Apply deletion to index and worktree [y,n,q,a,d%s,?]? "),
+		N_("Apply this hunk to index and worktree [y,n,q,a,d%s,?]? "),
+	},
+	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
+			     "will immediately be marked for applying."),
+	.help_patch_text =
+		N_("y - apply this hunk to index and worktree\n"
+		   "n - do not apply this hunk to index and worktree\n"
+		   "q - quit; do not apply this hunk or any of the remaining "
+			"ones\n"
+		   "a - apply this hunk and all later hunks in the file\n"
+		   "d - do not apply this hunk or any of the later hunks in "
+			"the file\n"),
+};
+
 struct hunk_header {
 	unsigned long old_offset, old_count, new_offset, new_count;
 	/*
@@ -1064,6 +1130,57 @@ static int edit_hunk_loop(struct add_p_state *s,
 	}
 }
 
+static int apply_for_checkout(struct add_p_state *s, struct strbuf *diff,
+			      int is_reverse)
+{
+	const char *reverse = is_reverse ? "-R" : NULL;
+	struct child_process check_index = CHILD_PROCESS_INIT;
+	struct child_process check_worktree = CHILD_PROCESS_INIT;
+	struct child_process apply_index = CHILD_PROCESS_INIT;
+	struct child_process apply_worktree = CHILD_PROCESS_INIT;
+	int applies_index, applies_worktree;
+
+	setup_child_process(s, &check_index,
+			    "apply", "--cached", "--check", reverse, NULL);
+	applies_index = !pipe_command(&check_index, diff->buf, diff->len,
+				      NULL, 0, NULL, 0);
+
+	setup_child_process(s, &check_worktree,
+			    "apply", "--check", reverse, NULL);
+	applies_worktree = !pipe_command(&check_worktree, diff->buf, diff->len,
+					 NULL, 0, NULL, 0);
+
+	if (applies_worktree && applies_index) {
+		setup_child_process(s, &apply_index,
+				    "apply", "--cached", reverse, NULL);
+		pipe_command(&apply_index, diff->buf, diff->len,
+			     NULL, 0, NULL, 0);
+
+		setup_child_process(s, &apply_worktree,
+				    "apply", reverse, NULL);
+		pipe_command(&apply_worktree, diff->buf, diff->len,
+			     NULL, 0, NULL, 0);
+
+		return 1;
+	}
+
+	if (!applies_index) {
+		err(s, _("The selected hunks do not apply to the index!"));
+		if (prompt_yesno(s, _("Apply them to the worktree "
+					  "anyway? ")) > 0) {
+			setup_child_process(s, &apply_worktree,
+					    "apply", reverse, NULL);
+			return pipe_command(&apply_worktree, diff->buf,
+					    diff->len, NULL, 0, NULL, 0);
+		}
+		err(s, _("Nothing was applied.\n"));
+	} else
+		/* As a last resort, show the diff to the user */
+		fwrite(diff->buf, diff->len, 1, stderr);
+
+	return 0;
+}
+
 #define SUMMARY_HEADER_WIDTH 20
 #define SUMMARY_LINE_WIDTH 80
 static void summarize_hunk(struct add_p_state *s, struct hunk *hunk,
@@ -1389,11 +1506,16 @@ static int patch_update_file(struct add_p_state *s,
 		reassemble_patch(s, file_diff, 0, &s->buf);
 
 		discard_index(s->s.r->index);
-		setup_child_process(s, &cp, "apply", NULL);
-		argv_array_pushv(&cp.args, s->mode->apply);
-		if (pipe_command(&cp, s->buf.buf, s->buf.len,
-				 NULL, 0, NULL, 0))
-			error(_("'git apply' failed"));
+		if (s->mode->apply_for_checkout)
+			apply_for_checkout(s, &s->buf,
+					   s->mode->is_reverse);
+		else {
+			setup_child_process(s, &cp, "apply", NULL);
+			argv_array_pushv(&cp.args, s->mode->apply);
+			if (pipe_command(&cp, s->buf.buf, s->buf.len,
+					 NULL, 0, NULL, 0))
+				error(_("'git apply' failed"));
+		}
 		if (!repo_read_index(s->s.r))
 			repo_refresh_and_write_index(s->s.r, REFRESH_QUIET, 0,
 						     1, NULL, NULL, NULL);
@@ -1420,6 +1542,13 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 			s.mode = &patch_mode_reset_head;
 		else
 			s.mode = &patch_mode_reset_nothead;
+	} else if (mode == ADD_P_CHECKOUT) {
+		if (!revision)
+			s.mode = &patch_mode_checkout_index;
+		else if (!strcmp(revision, "HEAD"))
+			s.mode = &patch_mode_checkout_head;
+		else
+			s.mode = &patch_mode_checkout_nothead;
 	} else
 		s.mode = &patch_mode_stage;
 	s.revision = revision;
diff --git a/builtin/add.c b/builtin/add.c
index f238e8b623..f4d6eb9e06 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -206,9 +206,10 @@ int run_add_interactive(const char *revision, const char *patch_mode,
 			mode = ADD_P_STASH;
 		else if (!strcmp(patch_mode, "--patch=reset"))
 			mode = ADD_P_RESET;
+		else if (!strcmp(patch_mode, "--patch=checkout"))
+			mode = ADD_P_CHECKOUT;
 		else
-			die("'%s' not yet supported in the built-in add -p",
-			    patch_mode);
+			die("'%s' not supported", patch_mode);
 
 		return !!run_add_p(the_repository, mode, revision, pathspec);
 	}
-- 
gitgitgadget


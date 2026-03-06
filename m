Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB4B3AE6E9
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 14:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772808866; cv=none; b=CgrQfPhLOXRy2MFelEwXZXO6rQEsnLuMBLRlqqj/JqpuG65FAUDUOi7bCaYNDUoEGGx5ou2peMnqfwvbXbtONQCWn/PTXB0oNfSkMgXlxSfrI54zKUbYYc+CmcRrZARRjt5hHdq2NhM2QJUKW4q1Q/eOQqK5GF9enILwsNpI9IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772808866; c=relaxed/simple;
	bh=WHd7Su3R+FknU78UZYE3P/mx3KLgzMXhbEDct7gSFQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRWg7LAvfjG0PehjwkVzifIMYSe5BvmZJzx6QAY37KzTBBcNkwTCEAq2PYKLebDif9WNzngkSPlVEPaPHU/klBfdESs0pF8Kc3BCbdgbbG1UjQDqMOQXUIEzu2dFhr4hp2urBC78rzEqbu4fjZlqc/y4AHeNtG/k+LwS9+0hOy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUL0ffJR; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUL0ffJR"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439ac15f35fso5960685f8f.0
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 06:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772808863; x=1773413663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MdjyO0TNPKpPFopumSypg4FeXK4J7Bh5xHIK/TEkaLA=;
        b=EUL0ffJRujZomAgmxyUpvbh+K0n+1OpEgIRHUeBj6li68XyBW8+xRftRE4hvV4KKFc
         /gBXedv5wz6nj1t7zN5E10gxYesnX47mDf+U1R1dpngg80sBx0zojbjBpUiLbJ8OraJE
         aFOtM2mc57q7IrVgumX2W+iZewA83OHjut5eC6PZG3nZqFlwNXzzNbi2FWql8SMx+Ivo
         CqmZP0rqDjsbBAewYkjU3o89soeFOj8AsMM5VqU3nKqitHrOsoWZYgSmwuIFvuMI8OlB
         TXehy43oGpxFKO6q6xqAcD9wjtyWeBhbMbtpao6GtS+FBAiwM72fBQ4ZbOugvDwfLjWR
         PFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772808863; x=1773413663;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MdjyO0TNPKpPFopumSypg4FeXK4J7Bh5xHIK/TEkaLA=;
        b=HnObjVriSY27LYPcv5NM0dkPPftX4cHiwwWa61ol321WTX9uMA7DuLgk8BuLPujaBO
         qtrNe2Og+4Mn5sBL24Yx+wHV1BsC+vpz01M8ieIa1tzgk9qRzlHuilt0S0p4H037wSWM
         ReKV2fG1VGV8Q0HhpmYH741+LyggmVr4H9Yj039RRRnuSE1ddTM/OE7PGQSX1tcid8Lj
         h11MBEasuW9h7oXne7IRCP1+2rCQ5wYxEN3n/SaO3Kvbb+Kmm2f5gyOySO6awWjDU2r3
         H4xX0zZJafBQ2/gIsCtIy0DtyzHOVYZIQcPLv+LelnHEf9HoKRIJSjS4zETQ5m0TIM6z
         mLQg==
X-Gm-Message-State: AOJu0YxtAQCgcVfi6jkPNkuHd3tr3vqAzgF2McVSob6IKGyBYsiJcTQC
	lmUjF9mf4MDvi6nXpCd4zZhV7FvrafUEhOK9eKfYYacOG3oGeCHQ44agvrOTcA==
X-Gm-Gg: ATEYQzxigXe8GTf//wc4vDjaLtcVreQP8Lb6F+P86k2Xe4Ytm1P6BFRAkS0TXmeRUsF
	GbnPVCvvybfPF+pK2SnyEA2GNM9x90NNnwmwPpM6Rcr2a/znSyZQfoDJ39xgxK7nzggOxaD3jXH
	ooOoxRikT3cA1Y36hmUDKLCSUGN967wJ6isJmGxA8A4+I7u146lxADPaagqek6ukFnunQ67uI9x
	Uni+O6RCLUe7f0Tv4TPPetV6CjtbXu+NBWbuxzYfh2kJTZgIIMBAN8POIyQ9T4Gt7fnvv8I4C14
	NPn+Y6aZc+z/DqweNLgkixEdNtNsn01gQHTiuy4IE9fH0vcw+VP+m/EVGHuFL4RDjOmRUrYLema
	63F+CHvzDQUrmwcuC4eZhmOVHFIBJTtqQJivNBd/Wjw9Rt1nP1CeY4J1++rvZHvHVMcI6HcwmVX
	RHOv9pAPFVjJQpVP9Tbogbp7Nr/FQ=
X-Received: by 2002:a05:6000:4301:b0:439:afd8:6230 with SMTP id ffacd0b85a97d-439da65315amr4118446f8f.58.1772808862820;
        Fri, 06 Mar 2026 06:54:22 -0800 (PST)
Received: from berwick ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad1cb7csm4278563f8f.0.2026.03.06.06.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 06:54:22 -0800 (PST)
From: Phillip Wood <phillip.wood123@gmail.com>
To: Git Mailing List <git@vger.kernel.org>,
	Li Chen <me@linux.beauty>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v8 6/6] rebase: support --trailer
Date: Fri,  6 Mar 2026 14:53:32 +0000
Message-ID: <99654d805471188695c0ccf400a485db16e51dd4.1772808594.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9
In-Reply-To: <cover.1772808594.git.phillip.wood@dunelm.org.uk>
References: <20260224070552.148591-1-me@linux.beauty> <cover.1772808594.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunlem.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Chen <me@linux.beauty>

Add a new --trailer=<trailer> option to git rebase to append trailer
lines to each rewritten commit message (merge backend only).

Because the apply backend does not provide a commit-message filter,
reject --trailer when --apply is in effect and require the merge backend
instead.

This option implies --force-rebase so that fast-forwarded commits are
also rewritten. Validate trailer arguments early to avoid starting an
interactive rebase with invalid input.

Add integration tests covering error paths and trailer insertion across
non-interactive and interactive rebases.

Signed-off-by: Li Chen <me@linux.beauty>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/git-rebase.adoc |   8 ++
 builtin/rebase.c              |  19 +++++
 sequencer.c                   |  52 +++++++++++-
 sequencer.h                   |   3 +
 t/meson.build                 |   1 +
 t/t3440-rebase-trailer.sh     | 147 ++++++++++++++++++++++++++++++++++
 6 files changed, 228 insertions(+), 2 deletions(-)
 create mode 100755 t/t3440-rebase-trailer.sh

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index e177808004f..f6c22d15989 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -497,6 +497,13 @@ See also INCOMPATIBLE OPTIONS below.
 +
 See also INCOMPATIBLE OPTIONS below.
 
+--trailer=<trailer>::
+	Append the given trailer to every rebased commit message, processed
+	via linkgit:git-interpret-trailers[1]. This option implies
+	`--force-rebase`.
++
+See also INCOMPATIBLE OPTIONS below.
+
 -i::
 --interactive::
 	Make a list of the commits which are about to be rebased.  Let the
@@ -653,6 +660,7 @@ are incompatible with the following options:
  * --[no-]reapply-cherry-picks when used without --keep-base
  * --update-refs
  * --root when used without --onto
+ * --trailer
 
 In addition, the following pairs of options are incompatible:
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index c487e109077..fe25d2ad4bc 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -36,6 +36,7 @@
 #include "reset.h"
 #include "trace2.h"
 #include "hook.h"
+#include "trailer.h"
 
 static char const * const builtin_rebase_usage[] = {
 	N_("git rebase [-i] [options] [--exec <cmd>] "
@@ -113,6 +114,7 @@ struct rebase_options {
 	enum action action;
 	char *reflog_action;
 	int signoff;
+	struct strvec trailer_args;
 	int allow_rerere_autoupdate;
 	int keep_empty;
 	int autosquash;
@@ -143,6 +145,7 @@ struct rebase_options {
 		.flags = REBASE_NO_QUIET, 		\
 		.git_am_opts = STRVEC_INIT,		\
 		.exec = STRING_LIST_INIT_NODUP,		\
+		.trailer_args = STRVEC_INIT,		\
 		.git_format_patch_opt = STRBUF_INIT,	\
 		.fork_point = -1,			\
 		.reapply_cherry_picks = -1,             \
@@ -166,6 +169,7 @@ static void rebase_options_release(struct rebase_options *opts)
 	free(opts->strategy);
 	string_list_clear(&opts->strategy_opts, 0);
 	strbuf_release(&opts->git_format_patch_opt);
+	strvec_clear(&opts->trailer_args);
 }
 
 static struct replay_opts get_replay_opts(const struct rebase_options *opts)
@@ -177,6 +181,10 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 	sequencer_init_config(&replay);
 
 	replay.signoff = opts->signoff;
+
+	for (size_t i = 0; i < opts->trailer_args.nr; i++)
+		strvec_push(&replay.trailer_args, opts->trailer_args.v[i]);
+
 	replay.allow_ff = !(opts->flags & REBASE_FORCE);
 	if (opts->allow_rerere_autoupdate)
 		replay.allow_rerere_auto = opts->allow_rerere_autoupdate;
@@ -1132,6 +1140,8 @@ int cmd_rebase(int argc,
 			.flags = PARSE_OPT_NOARG,
 			.defval = REBASE_DIFFSTAT,
 		},
+		OPT_STRVEC(0, "trailer", &options.trailer_args, N_("trailer"),
+			   N_("add custom trailer(s)")),
 		OPT_BOOL(0, "signoff", &options.signoff,
 			 N_("add a Signed-off-by trailer to each commit")),
 		OPT_BOOL(0, "committer-date-is-author-date",
@@ -1285,6 +1295,12 @@ int cmd_rebase(int argc,
 			     builtin_rebase_options,
 			     builtin_rebase_usage, 0);
 
+	if (options.trailer_args.nr) {
+		if (validate_trailer_args(&options.trailer_args))
+			die(NULL);
+		options.flags |= REBASE_FORCE;
+	}
+
 	if (preserve_merges_selected)
 		die(_("--preserve-merges was replaced by --rebase-merges\n"
 			"Note: Your `pull.rebase` configuration may also be set to 'preserve',\n"
@@ -1542,6 +1558,9 @@ int cmd_rebase(int argc,
 	if (options.root && !options.onto_name)
 		imply_merge(&options, "--root without --onto");
 
+	if (options.trailer_args.nr)
+		imply_merge(&options, "--trailer");
+
 	if (isatty(2) && options.flags & REBASE_NO_QUIET)
 		strbuf_addstr(&options.git_format_patch_opt, " --progress");
 
diff --git a/sequencer.c b/sequencer.c
index a3eb39bb252..a2d72ce8b3b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -209,6 +209,7 @@ static GIT_PATH_FUNC(rebase_path_reschedule_failed_exec, "rebase-merge/reschedul
 static GIT_PATH_FUNC(rebase_path_no_reschedule_failed_exec, "rebase-merge/no-reschedule-failed-exec")
 static GIT_PATH_FUNC(rebase_path_drop_redundant_commits, "rebase-merge/drop_redundant_commits")
 static GIT_PATH_FUNC(rebase_path_keep_redundant_commits, "rebase-merge/keep_redundant_commits")
+static GIT_PATH_FUNC(rebase_path_trailer, "rebase-merge/trailer")
 
 /*
  * A 'struct replay_ctx' represents the private state of the sequencer.
@@ -420,6 +421,7 @@ void replay_opts_release(struct replay_opts *opts)
 	if (opts->revs)
 		release_revisions(opts->revs);
 	free(opts->revs);
+	strvec_clear(&opts->trailer_args);
 	replay_ctx_release(ctx);
 	free(opts->ctx);
 }
@@ -2019,12 +2021,15 @@ static int append_squash_message(struct strbuf *buf, const char *body,
 	if (is_fixup_flag(command, flag) && !seen_squash(ctx)) {
 		/*
 		 * We're replacing the commit message so we need to
-		 * append the Signed-off-by: trailer if the user
-		 * requested '--signoff'.
+		 * append any trailers if the user requested
+		 * '--signoff' or '--trailer'.
 		 */
 		if (opts->signoff)
 			append_signoff(buf, 0, 0);
 
+		if (opts->trailer_args.nr)
+			amend_strbuf_with_trailers(buf, &opts->trailer_args);
+
 		if ((command == TODO_FIXUP) &&
 		    (flag & TODO_REPLACE_FIXUP_MSG) &&
 		    (file_exists(rebase_path_fixup_msg()) ||
@@ -2443,6 +2448,9 @@ static int do_pick_commit(struct repository *r,
 	if (opts->signoff && !is_fixup(command))
 		append_signoff(&ctx->message, 0, 0);
 
+	if (opts->trailer_args.nr && !is_fixup(command))
+		amend_strbuf_with_trailers(&ctx->message, &opts->trailer_args);
+
 	if (is_rebase_i(opts) && write_author_script(msg.message) < 0)
 		res = -1;
 	else if (!opts->strategy ||
@@ -3172,6 +3180,33 @@ static void read_strategy_opts(struct replay_opts *opts, struct strbuf *buf)
 	parse_strategy_opts(opts, buf->buf);
 }
 
+static int read_trailers(struct replay_opts *opts, struct strbuf *buf)
+{
+	ssize_t len;
+
+	strbuf_reset(buf);
+	len = strbuf_read_file(buf, rebase_path_trailer(), 0);
+	if (len > 0) {
+		char *p = buf->buf, *nl;
+
+		trailer_config_init();
+
+		while ((nl = strchr(p, '\n'))) {
+			*nl = '\0';
+			if (!*p)
+				return error(_("trailers file contains empty line"));
+			strvec_push(&opts->trailer_args, p);
+			p = nl + 1;
+		}
+	} else if (!len) {
+		return error(_("trailers file is empty"));
+	} else if (errno != ENOENT) {
+		return error(_("cannot read trailers files"));
+	}
+
+	return 0;
+}
+
 static int read_populate_opts(struct replay_opts *opts)
 {
 	struct replay_ctx *ctx = opts->ctx;
@@ -3233,6 +3268,11 @@ static int read_populate_opts(struct replay_opts *opts)
 			opts->keep_redundant_commits = 1;
 
 		read_strategy_opts(opts, &buf);
+
+		if (read_trailers(opts, &buf)) {
+			ret = -1;
+			goto done_rebase_i;
+		}
 		strbuf_reset(&buf);
 
 		if (read_oneliner(&ctx->current_fixups,
@@ -3328,6 +3368,14 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
 		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
 	else
 		write_file(rebase_path_no_reschedule_failed_exec(), "%s", "");
+	if (opts->trailer_args.nr) {
+		struct strbuf buf = STRBUF_INIT;
+
+		for (size_t i = 0; i < opts->trailer_args.nr; i++)
+			strbuf_addf(&buf, "%s\n", opts->trailer_args.v[i]);
+		write_file(rebase_path_trailer(), "%s", buf.buf);
+		strbuf_release(&buf);
+	}
 
 	return 0;
 }
diff --git a/sequencer.h b/sequencer.h
index 719684c8a9f..bea20da085f 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -57,6 +57,8 @@ struct replay_opts {
 	int ignore_date;
 	int commit_use_reference;
 
+	struct strvec trailer_args;
+
 	int mainline;
 
 	char *gpg_sign;
@@ -84,6 +86,7 @@ struct replay_opts {
 #define REPLAY_OPTS_INIT {			\
 	.edit = -1,				\
 	.action = -1,				\
+	.trailer_args = STRVEC_INIT,		\
 	.xopts = STRVEC_INIT,			\
 	.ctx = replay_ctx_new(),		\
 }
diff --git a/t/meson.build b/t/meson.build
index 6d91470ebc1..3e0bb631af8 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -390,6 +390,7 @@ integration_tests = [
   't3436-rebase-more-options.sh',
   't3437-rebase-fixup-options.sh',
   't3438-rebase-broken-files.sh',
+  't3440-rebase-trailer.sh',
   't3450-history.sh',
   't3451-history-reword.sh',
   't3500-cherry.sh',
diff --git a/t/t3440-rebase-trailer.sh b/t/t3440-rebase-trailer.sh
new file mode 100755
index 00000000000..8b475795660
--- /dev/null
+++ b/t/t3440-rebase-trailer.sh
@@ -0,0 +1,147 @@
+#!/bin/sh
+#
+
+test_description='git rebase --trailer integration tests
+We verify that --trailer works with the merge backend,
+and that it is rejected early when the apply backend is requested.'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-rebase.sh # test_commit_message, helpers
+
+REVIEWED_BY_TRAILER="Reviewed-by: Dev <dev@example.com>"
+SP=" "
+
+test_expect_success 'setup repo with a small history' '
+	git commit --allow-empty -m "Initial empty commit" &&
+	test_commit first file a &&
+	test_commit second file &&
+	git checkout -b conflict-branch first &&
+	test_commit file-2 file-2 &&
+	test_commit conflict file &&
+	test_commit third file &&
+	git checkout main
+'
+
+test_expect_success 'apply backend is rejected with --trailer' '
+	git checkout -B apply-backend third &&
+	test_expect_code 128 \
+		git rebase --apply --trailer "$REVIEWED_BY_TRAILER" HEAD^ 2>err &&
+	test_grep "fatal: --trailer requires the merge backend" err
+'
+
+test_expect_success 'reject empty --trailer argument' '
+	git checkout -B empty-trailer third &&
+	test_expect_code 128 git rebase --trailer "" HEAD^ 2>err &&
+	test_grep "empty --trailer" err
+'
+
+test_expect_success 'reject trailer with missing key before separator' '
+	git checkout -B missing-key third &&
+	test_expect_code 128 git rebase --trailer ": no-key" HEAD^ 2>err &&
+	test_grep "missing key before separator" err
+'
+
+test_expect_success 'allow trailer with missing value after separator' '
+	git checkout -B missing-value third &&
+	git rebase --trailer "Acked-by:" HEAD^ &&
+	test_commit_message HEAD <<-EOF
+	third
+
+	Acked-by:${SP}
+	EOF
+'
+
+test_expect_success 'CLI trailer duplicates allowed; replace policy keeps last' '
+	git checkout -B replace-policy third &&
+	git -c trailer.Bug.ifexists=replace -c trailer.Bug.ifmissing=add \
+		rebase --trailer "Bug: 123" --trailer "Bug: 456" HEAD^ &&
+	test_commit_message HEAD <<-EOF
+	third
+
+	Bug: 456
+	EOF
+'
+
+test_expect_success 'multiple Signed-off-by trailers all preserved' '
+	git checkout -B multiple-signoff third &&
+	git rebase --trailer "Signed-off-by: Dev A <a@example.com>" \
+		--trailer "Signed-off-by: Dev B <b@example.com>" HEAD^ &&
+	test_commit_message HEAD <<-EOF
+	third
+
+	Signed-off-by: Dev A <a@example.com>
+	Signed-off-by: Dev B <b@example.com>
+	EOF
+'
+
+test_expect_success 'rebase --trailer adds trailer after conflicts' '
+	git checkout -B trailer-conflict third &&
+	test_commit fourth file &&
+	test_must_fail git rebase --trailer "$REVIEWED_BY_TRAILER" second &&
+	git checkout --theirs file &&
+	git add file &&
+	git rebase --continue &&
+	test_commit_message HEAD <<-EOF &&
+	fourth
+
+	$REVIEWED_BY_TRAILER
+	EOF
+	test_commit_message HEAD^ <<-EOF
+	third
+
+	$REVIEWED_BY_TRAILER
+	EOF
+'
+
+test_expect_success '--trailer handles fixup commands in todo list' '
+	git checkout -B fixup-trailer third &&
+	test_commit fixup-base base &&
+	test_commit fixup-second second &&
+	cat >todo <<-\EOF &&
+	pick fixup-base fixup-base
+	fixup fixup-second fixup-second
+	EOF
+	(
+		set_replace_editor todo &&
+		git rebase -i --trailer "$REVIEWED_BY_TRAILER" HEAD~2
+	) &&
+	test_commit_message HEAD <<-EOF &&
+	fixup-base
+
+	$REVIEWED_BY_TRAILER
+	EOF
+	git reset --hard fixup-second &&
+	cat >todo <<-\EOF &&
+	pick fixup-base fixup-base
+	fixup -C fixup-second fixup-second
+	EOF
+	(
+		set_replace_editor todo &&
+		git rebase -i --trailer "$REVIEWED_BY_TRAILER" HEAD~2
+	) &&
+	test_commit_message HEAD <<-EOF
+	fixup-second
+
+	$REVIEWED_BY_TRAILER
+	EOF
+'
+
+test_expect_success 'rebase --root honors trailer.<name>.key' '
+	git checkout -B root-trailer first &&
+	git -c trailer.review.key=Reviewed-by rebase --root \
+		--trailer=review="Dev <dev@example.com>" &&
+	test_commit_message HEAD <<-EOF &&
+	first
+
+	Reviewed-by: Dev <dev@example.com>
+	EOF
+	test_commit_message HEAD^ <<-EOF
+	Initial empty commit
+
+	Reviewed-by: Dev <dev@example.com>
+	EOF
+'
+test_done
-- 
2.52.0.362.g884e03848a9


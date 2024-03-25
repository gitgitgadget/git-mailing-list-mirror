Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30A783CD9
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 23:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711409165; cv=none; b=EfwLMgqfTvUQtDPBQMkXvYSYAjGlsycfD0xx+f9pQxEM65xDjrK7huMsXjTdBPFXDg9rMATrzq4lZohCYf+UxJPGJnxQeIrLbOJYKkjIet+R4paG1veF/pakqqonimkEBmNxkg/EpGXXJmWm8KAzpvJQc4BGnuqgwlr8K2SrBz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711409165; c=relaxed/simple;
	bh=ucKrMg0wDux31H9mhEcggaTKBtbIowT+k00sBW2tpjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HsRRn4c8RdJY8OeOOqsTMYzSBDBkup+VMmwfsvZCWwgHqt0/o2MQKtS5Jm5A5f4IQlcMeg6itfUnte3ZfZMxYJMx3CVRv+wmzJB88g9no11RfKuHCHPm4Bkvz56T5c7jxwFDRjDGokvCSo0TJEQ6KE+YPmZDZFaTzDkV2DFH3EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZX8d3Iz4; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZX8d3Iz4"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-22988692021so2086171fac.1
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 16:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711409162; x=1712013962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5y4EITr3qbAPjn085Olt1drrfSlGPcO5RESN90LFv0=;
        b=ZX8d3Iz4gizGYOgRNaJM0kpIxj8uIlPMLhoQk9i4O5ZUpfVAOocioYGPeICyojvU/s
         H6z3FcEkq6e8f8uQRV1HEDXsDPdQAVufW742kilKnnuXJ8/lWIGhsIC/oQrp5vMbvZP6
         8Q2qB7HB8fmvPuD89bl50EekTKBGWcwc5v06jN6JLE3LsPIvMwnNINWeCmVeoLuPyUHw
         I73BTCmx1J6X2blBIVwdR3euqV1EtHR7tLnoAcaTD8aVER0xJgkqcklW66zc5sR5ms7w
         Ytzt+pOEZiRpAYhcqxjuBeDxAe8ONnffVUhMZTYKr8EenRvWfxBtySj261uiyk6c5i/F
         Q47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711409162; x=1712013962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5y4EITr3qbAPjn085Olt1drrfSlGPcO5RESN90LFv0=;
        b=fcMUQbvBbIDGt0Qd/x8OdVFNzzR8fcRkO8MeY3rvY+Dymw1DR4laIG0TsQthHab7pk
         Of9yRfHb4c+POlgp+u0TX401UHBGnaNxERMei+8o8LAFXZI1hhYB/tGRnxsrwCcQLNXM
         6/kh219S+Xulbp0IeMoM2fBRBuKgIgERzPUrFkw5PM0meHAXh0VA/BHCV8szWwZ4qXup
         H2IwA/D0fFjsTysojn9OMnu7U2qvS12PEeuLI2LZyGz12/nzq+2m28fv+2n6EHxE/kc8
         +fBtm/OCgvSMoV+CNSym12nvnqCL4Q7RctU/XA5jzu1V6U0Dktw78NZyxLr8gsKuWIv8
         hqZQ==
X-Gm-Message-State: AOJu0YywOC4P8Cc39QisBr80MWjqU2PyWS1T419yCdZkaFFVeNOAnEqD
	8K1/ygJhko3sOZrQH7NqDcsU/JVN3tG3o72AV030POk/f7BXLlkB1yj0OSV6GGs=
X-Google-Smtp-Source: AGHT+IHQgWplrYsXlLP6x8UjUnGuunLi67z4occnTPbBJjYCetspvkYOzTkjYDOqOkg0gJnGykrJXA==
X-Received: by 2002:a05:6870:7b4a:b0:22a:3226:b10a with SMTP id ji10-20020a0568707b4a00b0022a3226b10amr1994818oab.17.1711409161763;
        Mon, 25 Mar 2024 16:26:01 -0700 (PDT)
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id vp8-20020a056871a00800b0022a1d794bb8sm1454868oab.22.2024.03.25.16.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 16:26:01 -0700 (PDT)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
	newren@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com
Subject: [PATCH v5 7/7] cherry-pick: add `--empty` for more robust redundant commit handling
Date: Mon, 25 Mar 2024 18:16:54 -0500
Message-ID: <20240325232451.963946-8-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240119060721.3734775-2-brianmlyles@gmail.com>
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As with git-rebase(1) and git-am(1), git-cherry-pick(1) can result in a
commit being made redundant if the content from the picked commit is
already present in the target history. However, git-cherry-pick(1) does
not have the same options available that git-rebase(1) and git-am(1) have.

There are three things that can be done with these redundant commits:
drop them, keep them, or have the cherry-pick stop and wait for the user
to take an action. git-rebase(1) has the `--empty` option added in commit
e98c4269c8 (rebase (interactive-backend): fix handling of commits that
become empty, 2020-02-15), which handles all three of these scenarios.
Similarly, git-am(1) got its own `--empty` in 7c096b8d61 (am: support
--empty=<option> to handle empty patches, 2021-12-09).

git-cherry-pick(1), on the other hand, only supports two of the three
possiblities: Keep the redundant commits via `--keep-redundant-commits`,
or have the cherry-pick fail by not specifying that option. There is no
way to automatically drop redundant commits.

In order to bring git-cherry-pick(1) more in-line with git-rebase(1) and
git-am(1), this commit adds an `--empty` option to git-cherry-pick(1). It
has the same three options (keep, drop, and stop), and largely behaves
the same. The notable difference is that for git-cherry-pick(1), the
default will be `stop`, which maintains the current behavior when the
option is not specified.

Like the existing `--keep-redundant-commits`, `--empty=keep` will imply
`--allow-empty`.

The `--keep-redundant-commits` option will be documented as a deprecated
synonym of `--empty=keep`, and will be supported for backwards
compatibility for the time being.

Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
---
 Documentation/git-cherry-pick.txt | 30 +++++++++++++++++++------
 builtin/revert.c                  | 37 ++++++++++++++++++++++++++++++-
 sequencer.c                       |  6 +++++
 t/t3505-cherry-pick-empty.sh      | 37 ++++++++++++++++++++++++++++++-
 t/t3510-cherry-pick-sequence.sh   | 32 ++++++++++++++++++++++++++
 5 files changed, 133 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index fdcad3d200..81ace900fc 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -131,20 +131,36 @@ effect to your index in a row.
 	even without this option.  Note also, that use of this option only
 	keeps commits that were initially empty (i.e. the commit recorded the
 	same tree as its parent).  Commits which are made empty due to a
-	previous commit are dropped.  To force the inclusion of those commits
-	use `--keep-redundant-commits`.
+	previous commit will cause the cherry-pick to fail.  To force the
+	inclusion of those commits, use `--empty=keep`.
 
 --allow-empty-message::
 	By default, cherry-picking a commit with an empty message will fail.
 	This option overrides that behavior, allowing commits with empty
 	messages to be cherry picked.
 
+--empty=(drop|keep|stop)::
+	How to handle commits being cherry-picked that are redundant with
+	changes already in the current history.
++
+--
+`drop`;;
+	The commit will be dropped.
+`keep`;;
+	The commit will be kept. Implies `--allow-empty`.
+`stop`;;
+	The cherry-pick will stop when the commit is applied, allowing
+	you to examine the commit. This is the default behavior.
+--
++
+Note that `--empty=drop` and `--empty=stop` only specify how to handle a
+commit that was not initially empty, but rather became empty due to a previous
+commit. Commits that were initially empty will still cause the cherry-pick to
+fail unless one of `--empty=keep` or `--allow-empty` are specified.
++
+
 --keep-redundant-commits::
-	If a commit being cherry picked duplicates a commit already in the
-	current history, it will become empty.  By default these
-	redundant commits cause `cherry-pick` to stop so the user can
-	examine the commit. This option overrides that behavior and
-	creates an empty commit object.  Implies `--allow-empty`.
+	Deprecated synonym for `--empty=keep`.
 
 --strategy=<strategy>::
 	Use the given merge strategy.  Should only be used once.
diff --git a/builtin/revert.c b/builtin/revert.c
index a1936ef70e..53935d2c68 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -43,6 +43,31 @@ static const char * const *revert_or_cherry_pick_usage(struct replay_opts *opts)
 	return opts->action == REPLAY_REVERT ? revert_usage : cherry_pick_usage;
 }
 
+enum empty_action {
+	EMPTY_COMMIT_UNSPECIFIED = -1,
+	STOP_ON_EMPTY_COMMIT,      /* output errors and stop in the middle of a cherry-pick */
+	DROP_EMPTY_COMMIT,         /* skip with a notice message */
+	KEEP_EMPTY_COMMIT,         /* keep recording as empty commits */
+};
+
+static int parse_opt_empty(const struct option *opt, const char *arg, int unset)
+{
+	int *opt_value = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+
+	if (!strcmp(arg, "stop"))
+		*opt_value = STOP_ON_EMPTY_COMMIT;
+	else if (!strcmp(arg, "drop"))
+		*opt_value = DROP_EMPTY_COMMIT;
+	else if (!strcmp(arg, "keep"))
+		*opt_value = KEEP_EMPTY_COMMIT;
+	else
+		return error(_("invalid value for '%s': '%s'"), "--empty", arg);
+
+	return 0;
+}
+
 static int option_parse_m(const struct option *opt,
 			  const char *arg, int unset)
 {
@@ -85,6 +110,7 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 	const char * const * usage_str = revert_or_cherry_pick_usage(opts);
 	const char *me = action_name(opts);
 	const char *cleanup_arg = NULL;
+	enum empty_action empty_opt = EMPTY_COMMIT_UNSPECIFIED;
 	int cmd = 0;
 	struct option base_options[] = {
 		OPT_CMDMODE(0, "quit", &cmd, N_("end revert or cherry-pick sequence"), 'q'),
@@ -114,7 +140,10 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 			OPT_BOOL(0, "ff", &opts->allow_ff, N_("allow fast-forward")),
 			OPT_BOOL(0, "allow-empty", &opts->allow_empty, N_("preserve initially empty commits")),
 			OPT_BOOL(0, "allow-empty-message", &opts->allow_empty_message, N_("allow commits with empty messages")),
-			OPT_BOOL(0, "keep-redundant-commits", &opts->keep_redundant_commits, N_("keep redundant, empty commits")),
+			OPT_BOOL(0, "keep-redundant-commits", &opts->keep_redundant_commits, N_("deprecated: use --empty=keep instead")),
+			OPT_CALLBACK_F(0, "empty", &empty_opt, "(stop|drop|keep)",
+				       N_("how to handle commits that become empty"),
+				       PARSE_OPT_NONEG, parse_opt_empty),
 			OPT_END(),
 		};
 		options = parse_options_concat(options, cp_extra);
@@ -134,6 +163,11 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
 
+	if (opts->action == REPLAY_PICK) {
+		opts->drop_redundant_commits = (empty_opt == DROP_EMPTY_COMMIT);
+		opts->keep_redundant_commits = opts->keep_redundant_commits || (empty_opt == KEEP_EMPTY_COMMIT);
+	}
+
 	/* implies allow_empty */
 	if (opts->keep_redundant_commits)
 		opts->allow_empty = 1;
@@ -168,6 +202,7 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 				"--rerere-autoupdate", opts->allow_rerere_auto == RERERE_AUTOUPDATE,
 				"--no-rerere-autoupdate", opts->allow_rerere_auto == RERERE_NOAUTOUPDATE,
 				"--keep-redundant-commits", opts->keep_redundant_commits,
+				"--empty", empty_opt != EMPTY_COMMIT_UNSPECIFIED,
 				NULL);
 	}
 
diff --git a/sequencer.c b/sequencer.c
index 04ee94bd81..72ca483459 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2930,6 +2930,9 @@ static int populate_opts_cb(const char *key, const char *value,
 	else if (!strcmp(key, "options.allow-empty-message"))
 		opts->allow_empty_message =
 			git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
+	else if (!strcmp(key, "options.drop-redundant-commits"))
+		opts->drop_redundant_commits =
+			git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
 	else if (!strcmp(key, "options.keep-redundant-commits"))
 		opts->keep_redundant_commits =
 			git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
@@ -3474,6 +3477,9 @@ static int save_opts(struct replay_opts *opts)
 	if (opts->allow_empty_message)
 		res |= git_config_set_in_file_gently(opts_file,
 				"options.allow-empty-message", "true");
+	if (opts->drop_redundant_commits)
+		res |= git_config_set_in_file_gently(opts_file,
+				"options.drop-redundant-commits", "true");
 	if (opts->keep_redundant_commits)
 		res |= git_config_set_in_file_gently(opts_file,
 				"options.keep-redundant-commits", "true");
diff --git a/t/t3505-cherry-pick-empty.sh b/t/t3505-cherry-pick-empty.sh
index 61f91aaa0a..9748443530 100755
--- a/t/t3505-cherry-pick-empty.sh
+++ b/t/t3505-cherry-pick-empty.sh
@@ -84,7 +84,7 @@ test_expect_success 'cherry-pick a commit that becomes no-op (prep)' '
 	git commit -m "add file2 on the side"
 '
 
-test_expect_success 'cherry-pick a no-op without --keep-redundant' '
+test_expect_success 'cherry-pick a no-op with neither --keep-redundant nor --empty' '
 	git reset --hard &&
 	git checkout fork^0 &&
 	test_must_fail git cherry-pick main
@@ -113,4 +113,39 @@ test_expect_success '--keep-redundant-commits is incompatible with operations' '
 	git cherry-pick --abort
 '
 
+test_expect_success '--empty is incompatible with operations' '
+	test_must_fail git cherry-pick HEAD 2>output &&
+	test_grep "The previous cherry-pick is now empty" output &&
+	test_must_fail git cherry-pick --empty=stop --continue 2>output &&
+	test_grep "fatal: cherry-pick: --empty cannot be used with --continue" output &&
+	test_must_fail git cherry-pick --empty=stop --skip 2>output &&
+	test_grep "fatal: cherry-pick: --empty cannot be used with --skip" output &&
+	test_must_fail git cherry-pick --empty=stop --abort 2>output &&
+	test_grep "fatal: cherry-pick: --empty cannot be used with --abort" output &&
+	test_must_fail git cherry-pick --empty=stop --quit 2>output &&
+	test_grep "fatal: cherry-pick: --empty cannot be used with --quit" output &&
+	git cherry-pick --abort
+'
+
+test_expect_success 'cherry-pick a no-op with --empty=stop' '
+	git reset --hard &&
+	git checkout fork^0 &&
+	test_must_fail git cherry-pick --empty=stop main 2>output &&
+	test_grep "The previous cherry-pick is now empty" output
+'
+
+test_expect_success 'cherry-pick a no-op with --empty=drop' '
+	git reset --hard &&
+	git checkout fork^0 &&
+	git cherry-pick --empty=drop main &&
+	test_commit_message HEAD -m "add file2 on the side"
+'
+
+test_expect_success 'cherry-pick a no-op with --empty=keep' '
+	git reset --hard &&
+	git checkout fork^0 &&
+	git cherry-pick --empty=keep main &&
+	test_commit_message HEAD -m "add file2 on main"
+'
+
 test_done
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 72020a51c4..7eb52b12ed 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -90,6 +90,38 @@ test_expect_success 'cherry-pick persists opts correctly' '
 	test_cmp expect actual
 '
 
+test_expect_success 'cherry-pick persists --empty=stop correctly' '
+	pristine_detach yetanotherpick &&
+	# Picking `anotherpick` forces a conflict so that we stop. That
+	# commit is then skipped, after which we pick `yetanotherpick`
+	# while already on `yetanotherpick` to cause an empty commit
+	test_must_fail git cherry-pick --empty=stop anotherpick yetanotherpick &&
+	test_must_fail git cherry-pick --skip 2>msg &&
+	test_grep "The previous cherry-pick is now empty" msg &&
+	rm msg &&
+	git cherry-pick --abort
+'
+
+test_expect_success 'cherry-pick persists --empty=drop correctly' '
+	pristine_detach yetanotherpick &&
+	# Picking `anotherpick` forces a conflict so that we stop. That
+	# commit is then skipped, after which we pick `yetanotherpick`
+	# while already on `yetanotherpick` to cause an empty commit
+	test_must_fail git cherry-pick --empty=drop anotherpick yetanotherpick &&
+	git cherry-pick --skip &&
+	test_cmp_rev yetanotherpick HEAD
+'
+
+test_expect_success 'cherry-pick persists --empty=keep correctly' '
+	pristine_detach yetanotherpick &&
+	# Picking `anotherpick` forces a conflict so that we stop. That
+	# commit is then skipped, after which we pick `yetanotherpick`
+	# while already on `yetanotherpick` to cause an empty commit
+	test_must_fail git cherry-pick --empty=keep anotherpick yetanotherpick &&
+	git cherry-pick --skip &&
+	test_cmp_rev yetanotherpick HEAD^
+'
+
 test_expect_success 'revert persists opts correctly' '
 	pristine_detach initial &&
 	# to make sure that the session to revert a sequence
-- 
2.43.2


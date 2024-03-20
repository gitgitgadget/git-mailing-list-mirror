Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C4B8627A
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 23:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710977964; cv=none; b=cJkyvbSxOwcV8vd0oxi374pXdrKLA/gxalRf5m0iMSir27WzvIp+xoo22SYYbG0d7o0+11L4pDmyTgxZa5L/3ymIZhj3XTVHjht9GE/2jBojGPlDfUo9to31GMwalMW/dAdd1QDRXg/88on97K0DFaUIqSBSCFCT+93x7Z6c0Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710977964; c=relaxed/simple;
	bh=+UCX0H73ME1tPbJUTHQiOIALqDXOKmpSuSgPgnZSQKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J7/YFGgDS6sn5j/gxD2l+x6Au4qNB8lPK0pCH5ckYm2+BrWP5kQGn3GA1OWMYgkWTZ5NqGOpbPUInPYVftopYqGpm6nLIKgDPH8QC58W4aCk2xgsDkGrAZVEOfAc4GCxSQ6bBtHssEH4M3cPpk3+ZnkA+YT95ymnT7xH5bNaPIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CiayaONH; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiayaONH"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78a26aaefc8so28312485a.1
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 16:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710977961; x=1711582761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTe5nnuPRpf28rxTb5fSFuPC2Vt9Qqei4RIDrtO47z8=;
        b=CiayaONH80FbXImZUj+Vhnct55CQ/H+sOPxk1NyiUCyISYzC3cVoMCMF7e6dnhqlpV
         3yt2bzP3NfP8Qda4iOHVtthKxk/sxhPV3cTa1afHLqgWrmJzzEnU+vneiHZrybBWoohD
         FKKVrLUnfF+GNL6hM3IwvoX2FDDmIstOjd08JW7NQTlkn0n54UvU3L9Xme55yK/VtPJM
         wU3Dp+rVARP8vqw4T2l7KYk+buo4or9BZj/SWNF0Ne69xX3YDsXThLnf0iWYkhpl4trA
         46LWdWroT11CtyP2nPtyEP/T0iJaoG+OnaFNCMurKg+djacqDs6/nNgSTWSqcpuL9DQd
         0WvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710977961; x=1711582761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTe5nnuPRpf28rxTb5fSFuPC2Vt9Qqei4RIDrtO47z8=;
        b=Nk65bBK4O8id7ATMVUMQf6E/WiUN7zgTE03j1IiYNHCcWDYu8x/L7vdMnGr1duFcWo
         BdcuiRVUSvPntLNRBgdhOAl+lhLPbjDUv0umRW5MSB2Adaqy1uiXFJUloKgXHwU8zVaZ
         +k5S3ll21M3R2XODSX+X5SuZlMlQFhcEihuZg4stLbJemOgCH4sfDFFy60ou2bvsBIGI
         rOcMMmPn8k1u8e9X/Lt7qmyYhpCDTvIxfJ2Lt23b9cyro/Pf9Z2gHssshEgIQck1GBY+
         g4xaygeHG5Ixpzg/fW9jMSJIn0rpAlsV9MAe5YI0QF+oQvuARZbrTdv0c/VG7zwYtKlJ
         aJcQ==
X-Gm-Message-State: AOJu0YwDTe2k4Z35AvyGJiJ/pxfS+GozpXqMm7/1pX5N9tho2gDxc/ji
	9PNykuxM7Rj1LBFl8uhlzZ9yIecYaBwEm9TPvuTITKvv4LYY5JrBE1snKtcdskI=
X-Google-Smtp-Source: AGHT+IEoX9LsbT4xyytAmtRCK2ntrDn18Dl5g4GSmOlmAaFL1+O0v7BcSRqJPhevy0hE6u77SdCUxA==
X-Received: by 2002:ae9:f311:0:b0:789:f776:82b1 with SMTP id p17-20020ae9f311000000b00789f77682b1mr6674243qkg.27.1710977960804;
        Wed, 20 Mar 2024 16:39:20 -0700 (PDT)
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id v18-20020a05620a123200b0078a0edbaa94sm2400867qkj.91.2024.03.20.16.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 16:39:20 -0700 (PDT)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
	newren@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com
Subject: [PATCH v4 7/7] cherry-pick: add `--empty` for more robust redundant commit handling
Date: Wed, 20 Mar 2024 18:37:02 -0500
Message-ID: <20240320233724.214369-8-brianmlyles@gmail.com>
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

Changes from v3:

- Re-worded the note about initially-empty commits in the documentation
  for the new `--empty` option.

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
index b8d8f15e65..42bac5ebd7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2928,6 +2928,9 @@ static int populate_opts_cb(const char *key, const char *value,
 	else if (!strcmp(key, "options.allow-empty-message"))
 		opts->allow_empty_message =
 			git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
+	else if (!strcmp(key, "options.drop-redundant-commits"))
+		opts->drop_redundant_commits =
+			git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
 	else if (!strcmp(key, "options.keep-redundant-commits"))
 		opts->keep_redundant_commits =
 			git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
@@ -3472,6 +3475,9 @@ static int save_opts(struct replay_opts *opts)
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


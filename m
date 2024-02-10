Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF8236AF2
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 07:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707551387; cv=none; b=CsaOVZZIpoUYjzOEWYG3VfTpCO5blFsWexbGGByZQhxD4SqzCfsgLAIV7ukiydiXaGWdiVcY3eKHY2/OhZaA2yco1QH0OY+kIk3pm5MUkgDGV8FjWF/8r6YYuowvE1QYtQrkupJ9wpFmBr/mUTr1PWJIiLGRFutFe5Z+8iI0kx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707551387; c=relaxed/simple;
	bh=LXm2CkngSFQAbgw7oN88w5SDGr6f/papuLFgTk7mst4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLdozxvdjcansVOkP44AFVOuoxxU2rdZevzo/kfrTvMJ5VUypSghPtRum+HgrGj+yplkO2fLXkTkD/GxSvY1Gp3Gu9ydqO+h4KU1bVcknr52y+hWkuhuxMHnxlRw/drDxVbbShLh/LeEIhKYGO0mOtb618sfhQ8N0dswZLNa/Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2nrEZIH; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2nrEZIH"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e0f43074edso843078a34.1
        for <git@vger.kernel.org>; Fri, 09 Feb 2024 23:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707551383; x=1708156183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gu1Riqn+fMaWy9vOIAlFdfl2h9HhLgp9wn/NlHr5UIU=;
        b=c2nrEZIHuObKu/t6QOPICqd8OQ+yZ9ymO8B41Ytfs9j2WGboskAOyI304u6KnnSwD/
         2c+va1pwSfcjTJTEl7jXv4EKopis7qvT+Aqj3TVz9FH4YzTiBE2ZQSjIt2/rFsCSDrNJ
         DrxxBA/yT2N4kn6bBTCRrNerUuDzMK3Iqu0uMJ/vgurh1KAZMlhD7Dj0zGWGjqXgaWwa
         FnzAeN6EwqwjOUT5Mg1D851lZCICNpyxPi7AiPl6t00W33+kHWIuDuJqDKBqMTnMsOYk
         pED1lTa/kA3E9O48YT3f8uKkc+uUyZR2xu8jDVKujCv9BYp3yWh6/O/u0XU9SnXSvnId
         zsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707551383; x=1708156183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gu1Riqn+fMaWy9vOIAlFdfl2h9HhLgp9wn/NlHr5UIU=;
        b=HMUiQiKeT59sj3KnJ9OLAW4VeEJ0DF5lk1aUhIFP2Hse2hEe/tzfWkY4ImekaB4Dpv
         i/VCkQkKpB8xtyebHOqiBjEtSvONEYMHCYN6+NdjadeLtJ3D/FyrNA8XGaM7WcZ1pewG
         vJKnCyv1pOCEgd6PzjXBajUhaHyX3fVTSb4DJeKgBgEI1QPJbamvBwE9lgJJpK2ww0Z9
         BxwgXNCX4JB7ZfeicU5MXA+8xeysWYGFrq2H3LFt29020CebFVqVKXRyX5ht4x7dxWm8
         pz7aRRoptYa44XRoEHPF66vGYzNacJtMhBqT67wQNih9BTrxLVy/u3pJEnHzzWi2eG6E
         SlVw==
X-Gm-Message-State: AOJu0YwbObxQf+QMUDzq5r7V9P24bPK7pc47JO+RdgywKHvB26ALOVgF
	DSNJuWpScZi/IrIND6CU4pgZQqs38lFBaLBJb5wtDsM34xOP4TFn78ECjV0iFb4=
X-Google-Smtp-Source: AGHT+IGj1gyBzXTIQ7v+4cUl37ifXfr4G3BjJvNMQq6UvSWgnxsie3DWSxCmuRPf21+l6UCWUmD2dQ==
X-Received: by 2002:a05:6870:2247:b0:219:1dc6:fdff with SMTP id j7-20020a056870224700b002191dc6fdffmr1415352oaf.55.1707551383538;
        Fri, 09 Feb 2024 23:49:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV926tmqP1xtJeRydWpYfsxuf7hK5XgL9Mw/AQ3//2DptkHlQ5oX1Ubxg4yblgrszmhKCK/n29aohiioLhyIiuxb//ue73PN/nJY+PGyEaMZbka0iKVdF6k8iE/8fkJZ/qmNP2mqsgPmS56krPPGWfsI3oSnlwekYooKl7nJMIU
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id v19-20020a056870955300b00219fd9e3194sm310028oal.7.2024.02.09.23.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 23:49:42 -0800 (PST)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
	newren@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com
Subject: [PATCH v2 8/8] cherry-pick: add `--empty` for more robust redundant commit handling
Date: Sat, 10 Feb 2024 01:43:56 -0600
Message-ID: <20240210074859.552497-9-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The `--keep-redundant-commits` option will be documented as a deprecated
synonym of `--empty=keep`, and will be supported for backwards
compatibility for the time being.

Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
---
 Documentation/git-cherry-pick.txt           | 32 +++++++++++------
 builtin/revert.c                            | 37 ++++++++++++++++++-
 sequencer.c                                 |  6 ++++
 t/t3505-cherry-pick-empty.sh                | 23 +++++++++++-
 t/t3510-cherry-pick-sequence.sh             | 40 +++++++++++++++++++++
 t/t3515-cherry-pick-incompatible-options.sh | 14 ++++++++
 6 files changed, 140 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index c88bb88822..a444d960b1 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -132,23 +132,35 @@ effect to your index in a row.
 	keeps commits that were initially empty (i.e. the commit recorded the
 	same tree as its parent).  Commits which are made empty due to a
 	previous commit will cause the cherry-pick to fail.  To force the
-	inclusion of those commits, use `--keep-redundant-commits`.
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
+	The commit will be kept.
+`stop`;;
+	The cherry-pick will stop when the commit is applied, allowing
+	you to examine the commit. This is the default behavior.
+--
++
+Note that this option species how to handle a commit that was not initially
+empty, but rather became empty due to a previous commit. Commits that were
+initially empty will cause the cherry-pick to fail. To force the inclusion of
+those commits, use `--allow-empty`.
++
+
 --keep-redundant-commits::
-	If a commit being cherry picked duplicates a commit already in the
-	current history, it will become empty.  By default these
-	redundant commits cause `cherry-pick` to stop so the user can
-	examine the commit. This option overrides that behavior and
-	creates an empty commit object. Note that use of this option only
-	results in an empty commit when the commit was not initially empty,
-	but rather became empty due to a previous commit. Commits that were
-	initially empty will cause the cherry-pick to fail. To force the
-	inclusion of those commits use `--allow-empty`.
+	Deprecated synonym for `--empty=keep`.

 --strategy=<strategy>::
 	Use the given merge strategy.  Should only be used once.
diff --git a/builtin/revert.c b/builtin/revert.c
index 48c426f277..27efb6284b 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -43,6 +43,31 @@ static const char * const *revert_or_cherry_pick_usage(struct replay_opts *opts)
 	return opts->action == REPLAY_REVERT ? revert_usage : cherry_pick_usage;
 }

+enum empty_action {
+	EMPTY_COMMIT_UNSPECIFIED = 0,
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
 	if (cleanup_arg) {
 		opts->default_msg_cleanup = get_cleanup_mode(cleanup_arg, 1);
 		opts->explicit_cleanup = 1;
@@ -164,6 +198,7 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 				"--rerere-autoupdate", opts->allow_rerere_auto == RERERE_AUTOUPDATE,
 				"--no-rerere-autoupdate", opts->allow_rerere_auto == RERERE_NOAUTOUPDATE,
 				"--keep-redundant-commits", opts->keep_redundant_commits,
+				"--empty", empty_opt != EMPTY_COMMIT_UNSPECIFIED,
 				NULL);
 	}

diff --git a/sequencer.c b/sequencer.c
index 3f41863dae..509a5244d2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2921,6 +2921,9 @@ static int populate_opts_cb(const char *key, const char *value,
 	else if (!strcmp(key, "options.allow-empty-message"))
 		opts->allow_empty_message =
 			git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
+	else if (!strcmp(key, "options.drop-redundant-commits"))
+		opts->drop_redundant_commits =
+			git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
 	else if (!strcmp(key, "options.keep-redundant-commits"))
 		opts->keep_redundant_commits =
 			git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
@@ -3465,6 +3468,9 @@ static int save_opts(struct replay_opts *opts)
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
index 2709cfc677..669416c158 100755
--- a/t/t3505-cherry-pick-empty.sh
+++ b/t/t3505-cherry-pick-empty.sh
@@ -90,7 +90,7 @@ test_expect_success 'cherry-pick a commit that becomes no-op (prep)' '
 	git commit -m "add file2 on the side"
 '

-test_expect_success 'cherry-pick a no-op without --keep-redundant' '
+test_expect_success 'cherry-pick a no-op with neither --keep-redundant nor --empty' '
 	git reset --hard &&
 	git checkout fork^0 &&
 	test_must_fail git cherry-pick main
@@ -105,4 +105,25 @@ test_expect_success 'cherry-pick a no-op with --keep-redundant' '
 	test_cmp expect actual
 '

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
index 72020a51c4..5f6c45dfe3 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -90,6 +90,46 @@ test_expect_success 'cherry-pick persists opts correctly' '
 	test_cmp expect actual
 '

+test_expect_success 'cherry-pick persists --empty=stop correctly' '
+	pristine_detach initial &&
+	# to make sure that the session to cherry-pick a sequence
+	# gets interrupted, use a high-enough number that is larger
+	# than the number of parents of any commit we have created
+	mainline=4 &&
+	test_expect_code 128 git cherry-pick -s -m $mainline --empty=stop initial..anotherpick &&
+	test_path_is_file .git/sequencer/opts &&
+	test_must_fail git config --file=.git/sequencer/opts --get-all options.keep-redundant-commits &&
+	test_must_fail git config --file=.git/sequencer/opts --get-all options.drop-redundant-commits
+'
+
+test_expect_success 'cherry-pick persists --empty=drop correctly' '
+	pristine_detach initial &&
+	# to make sure that the session to cherry-pick a sequence
+	# gets interrupted, use a high-enough number that is larger
+	# than the number of parents of any commit we have created
+	mainline=4 &&
+	test_expect_code 128 git cherry-pick -s -m $mainline --empty=drop initial..anotherpick &&
+	test_path_is_file .git/sequencer/opts &&
+	test_must_fail git config --file=.git/sequencer/opts --get-all options.keep-redundant-commits &&
+	echo "true" >expect &&
+	git config --file=.git/sequencer/opts --get-all options.drop-redundant-commits >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'cherry-pick persists --empty=keep correctly' '
+	pristine_detach initial &&
+	# to make sure that the session to cherry-pick a sequence
+	# gets interrupted, use a high-enough number that is larger
+	# than the number of parents of any commit we have created
+	mainline=4 &&
+	test_expect_code 128 git cherry-pick -s -m $mainline --empty=keep initial..anotherpick &&
+	test_path_is_file .git/sequencer/opts &&
+	echo "true" >expect &&
+	git config --file=.git/sequencer/opts --get-all options.keep-redundant-commits >actual &&
+	test_cmp expect actual &&
+	test_must_fail git config --file=.git/sequencer/opts --get-all options.drop-redundant-commits
+'
+
 test_expect_success 'revert persists opts correctly' '
 	pristine_detach initial &&
 	# to make sure that the session to revert a sequence
diff --git a/t/t3515-cherry-pick-incompatible-options.sh b/t/t3515-cherry-pick-incompatible-options.sh
index 6100ab64fd..b2780fdbf3 100755
--- a/t/t3515-cherry-pick-incompatible-options.sh
+++ b/t/t3515-cherry-pick-incompatible-options.sh
@@ -31,4 +31,18 @@ test_expect_success '--keep-redundant-commits is incompatible with operations' '
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
 test_done
-- 
2.43.0


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038D4C433FE
	for <git@archiver.kernel.org>; Sun,  2 Jan 2022 17:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiABRQE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Jan 2022 12:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiABRPz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jan 2022 12:15:55 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2021EC061761
        for <git@vger.kernel.org>; Sun,  2 Jan 2022 09:15:55 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id j18so65759699wrd.2
        for <git@vger.kernel.org>; Sun, 02 Jan 2022 09:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=m0etoXIeTLgCHVhPj+wWj3mngiDrUwMGCkbo2gdxMeQ=;
        b=bzdPeSKkZ7oXbitDFkk7nK6uhde3J+bvEFCvLAe3hBocS7u3GkNMQKbGHCnofxPrpo
         QV6lafDtAty28bUkPqLt+Slo/EiCDGSbcU8pyiGwnEfCH3dHMpHBHM35Wpod75sDRXoU
         UqJhHuxuNyGP1NOlKx/s+aL5mRy8+QNjynJUJxrhbtXJW8I/ZMA/T+mw1tzNTz0YJqsT
         DT6OI4CFlJ/4cCpXZbtPLXpUo9E+4re34ugcYT4uH8plfBaE0NsxsJ3OVe7IkChFbMSh
         0NDVxULxYHYDWfF/beF3MjLZqch8C2sP4UWfWA6lR8oLhARZ8dHONcnl/oE3GCE5rYMv
         wQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=m0etoXIeTLgCHVhPj+wWj3mngiDrUwMGCkbo2gdxMeQ=;
        b=rTvzxxyEVh6nQLzgQn90VeouzviLOiX9auk/Wdf0YIs/6RDMOFzsknjXYHCl4DghW+
         HylvaxIu1OzkWNl6H8dQL3+v27kNnnfAKaKVbKtPiedRB6A8GiXzBpCSbgZwzQE5Xq7h
         Kt7s8FDoceCCuyJHCbUKLUYvodPqsLrjnH/cwgMKx67EuKEbGmudyVCaxDEWVxhMVTay
         +vbDnegMZHL6utsTD7LOAzxjWVFlLut+mxDgao6Nlp23edKn4Jc4tPdAIkH/PQydQjwG
         Vn9jrJv0rI9AuwJgiVu4JEwYSk1lp0C++7SskhvPtPcC5+ITo+y3dJiNcNAOeymNb7OJ
         SM4w==
X-Gm-Message-State: AOAM530vnewDyVRO3reWox+TKr46dOrWGF33UBFVHQrOhr8aYar2wPr1
        XjgmlSRTyVNdITbuqJwtsPj27z0hhd8=
X-Google-Smtp-Source: ABdhPJzz+XrHkglc69eQKBSp4/RNDmw9v3lKrR/qIGg/hzhswV9J3RbQhT0N93bBnat13L4TqwYvNw==
X-Received: by 2002:adf:df81:: with SMTP id z1mr36953722wrl.668.1641143753403;
        Sun, 02 Jan 2022 09:15:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l12sm38133745wmq.2.2022.01.02.09.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 09:15:53 -0800 (PST)
Message-Id: <969946274aa526e176de22686e691c51582886dd.1641143746.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.v4.git.1641143745.gitgitgadget@gmail.com>
References: <pull.1088.v3.git.1640804107.gitgitgadget@gmail.com>
        <pull.1088.v4.git.1641143745.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sun, 02 Jan 2022 17:15:40 +0000
Subject: [PATCH v4 06/11] i18n: factorize "--foo requires --bar" and the like
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

They are all replaced by "the option '%s' requires '%s'", which is a
new string but replaces 17 previous unique strings.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 archive.c                         | 2 +-
 builtin/add.c                     | 4 ++--
 builtin/checkout.c                | 2 +-
 builtin/commit.c                  | 2 +-
 builtin/fast-export.c             | 2 +-
 builtin/index-pack.c              | 2 +-
 builtin/log.c                     | 2 +-
 builtin/reset.c                   | 4 ++--
 builtin/rm.c                      | 2 +-
 builtin/stash.c                   | 2 +-
 builtin/worktree.c                | 2 +-
 fetch-pack.c                      | 2 +-
 http-fetch.c                      | 4 ++--
 revision.c                        | 2 +-
 t/t2026-checkout-pathspec-file.sh | 2 +-
 t/t2072-restore-pathspec-file.sh  | 2 +-
 t/t3601-rm-pathspec-file.sh       | 2 +-
 t/t3704-add-pathspec-file.sh      | 2 +-
 t/t3909-stash-pathspec-file.sh    | 2 +-
 t/t7107-reset-pathspec-file.sh    | 2 +-
 t/t7526-commit-pathspec-file.sh   | 2 +-
 21 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/archive.c b/archive.c
index 78d35467008..d571249cf39 100644
--- a/archive.c
+++ b/archive.c
@@ -577,7 +577,7 @@ static int parse_archive_args(int argc, const char **argv,
 	if (remote)
 		die(_("Unexpected option --remote"));
 	if (exec)
-		die(_("Option --exec can only be used together with --remote"));
+		die(_("the option '%s' requires '%s'"), "--exec", "--remote");
 	if (output)
 		die(_("Unexpected option --output"));
 	if (is_remote && args->extra_files.nr)
diff --git a/builtin/add.c b/builtin/add.c
index 4b2754345ad..067ec53d69f 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -541,7 +541,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		die(_("options '%s' and '%s' cannot be used together"), "-A", "-u");
 
 	if (!show_only && ignore_missing)
-		die(_("Option --ignore-missing can only be used together with --dry-run"));
+		die(_("the option '%s' requires '%s'"), "--ignore-missing", "--dry-run");
 
 	if (chmod_arg && ((chmod_arg[0] != '-' && chmod_arg[0] != '+') ||
 			  chmod_arg[1] != 'x' || chmod_arg[2]))
@@ -573,7 +573,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 				    PATHSPEC_SYMLINK_LEADING_PATH,
 				    prefix, pathspec_from_file, pathspec_file_nul);
 	} else if (pathspec_file_nul) {
-		die(_("--pathspec-file-nul requires --pathspec-from-file"));
+		die(_("the option '%s' requires '%s'"), "--pathspec-file-nul", "--pathspec-from-file");
 	}
 
 	if (require_pathspec && pathspec.nr == 0) {
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 73f5a6fbfa1..af5fa8228eb 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1758,7 +1758,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 				    0,
 				    prefix, opts->pathspec_from_file, opts->pathspec_file_nul);
 	} else if (opts->pathspec_file_nul) {
-		die(_("--pathspec-file-nul requires --pathspec-from-file"));
+		die(_("the option '%s' requires '%s'"), "--pathspec-file-nul", "--pathspec-from-file");
 	}
 
 	opts->pathspec.recursive = 1;
diff --git a/builtin/commit.c b/builtin/commit.c
index 067c795ca4b..49e7477747f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -367,7 +367,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 				    PATHSPEC_PREFER_FULL,
 				    prefix, pathspec_from_file, pathspec_file_nul);
 	} else if (pathspec_file_nul) {
-		die(_("--pathspec-file-nul requires --pathspec-from-file"));
+		die(_("the option '%s' requires '%s'"), "--pathspec-file-nul", "--pathspec-from-file");
 	}
 
 	if (!pathspec.nr && (also || (only && !allow_empty &&
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 1f8fe7b3ac1..f4d9aa1e8d1 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -1254,7 +1254,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		usage_with_options (fast_export_usage, options);
 
 	if (anonymized_seeds.cmpfn && !anonymize)
-		die(_("--anonymize-map without --anonymize does not make sense"));
+		die(_("the option '%s' requires '%s'"), "--anonymize-map", "--anonymize");
 
 	if (refspecs_list.nr) {
 		int i;
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 30ce2ac746d..3c2e6aee3cc 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1845,7 +1845,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (!pack_name && !from_stdin)
 		usage(index_pack_usage);
 	if (fix_thin_pack && !from_stdin)
-		die(_("--fix-thin cannot be used without --stdin"));
+		die(_("the option '%s' requires '%s'"), "--fix-thin", "--stdin");
 	if (from_stdin && !startup_info->have_repository)
 		die(_("--stdin requires a git repository"));
 	if (from_stdin && hash_algo)
diff --git a/builtin/log.c b/builtin/log.c
index 74b41db1cee..ded042f3e01 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2112,7 +2112,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (creation_factor < 0)
 		creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT;
 	else if (!rdiff_prev)
-		die(_("--creation-factor requires --range-diff"));
+		die(_("the option '%s' requires '%s'"), "--creation-factor", "--range-diff");
 
 	if (rdiff_prev) {
 		if (!cover_letter && total != 1)
diff --git a/builtin/reset.c b/builtin/reset.c
index 248998fd6fa..4779e70dfbe 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -432,7 +432,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				    PATHSPEC_PREFER_FULL,
 				    prefix, pathspec_from_file, pathspec_file_nul);
 	} else if (pathspec_file_nul) {
-		die(_("--pathspec-file-nul requires --pathspec-from-file"));
+		die(_("the option '%s' requires '%s'"), "--pathspec-file-nul", "--pathspec-from-file");
 	}
 
 	unborn = !strcmp(rev, "HEAD") && get_oid("HEAD", &oid);
@@ -490,7 +490,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		    _(reset_type_names[reset_type]));
 
 	if (intent_to_add && reset_type != MIXED)
-		die(_("-N can only be used with --mixed"));
+		die(_("the option '%s' requires '%s'"), "-N", "--mixed");
 
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
diff --git a/builtin/rm.c b/builtin/rm.c
index 3d0967cdc11..cfdf24cf49a 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -278,7 +278,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 				    PATHSPEC_PREFER_CWD,
 				    prefix, pathspec_from_file, pathspec_file_nul);
 	} else if (pathspec_file_nul) {
-		die(_("--pathspec-file-nul requires --pathspec-from-file"));
+		die(_("the option '%s' requires '%s'"), "--pathspec-file-nul", "--pathspec-from-file");
 	}
 
 	if (!pathspec.nr)
diff --git a/builtin/stash.c b/builtin/stash.c
index 4d793bd0b52..3e3743fd5a3 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1712,7 +1712,7 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 				    PATHSPEC_PREFER_FULL | PATHSPEC_PREFIX_ORIGIN,
 				    prefix, pathspec_from_file, pathspec_file_nul);
 	} else if (pathspec_file_nul) {
-		die(_("--pathspec-file-nul requires --pathspec-from-file"));
+		die(_("the option '%s' requires '%s'"), "--pathspec-file-nul", "--pathspec-from-file");
 	}
 
 	return do_push_stash(&ps, stash_msg, quiet, keep_index, patch_mode,
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 27b60732a22..78e146bd3cd 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -505,7 +505,7 @@ static int add(int ac, const char **av, const char *prefix)
 	if (!!opts.detach + !!new_branch + !!new_branch_force > 1)
 		die(_("options '%s', '%s', and '%s' cannot be used together"),"-b", "-B", "--detach");
 	if (lock_reason && !keep_locked)
-		die(_("--reason requires --lock"));
+		die(_("the option '%s' requires '%s'"), "--reason", "--lock");
 	if (lock_reason)
 		opts.keep_locked = lock_reason;
 	else if (keep_locked)
diff --git a/fetch-pack.c b/fetch-pack.c
index 34987a2c30d..dd6ec449f2d 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -297,7 +297,7 @@ static int find_common(struct fetch_negotiator *negotiator,
 	struct packet_reader reader;
 
 	if (args->stateless_rpc && multi_ack == 1)
-		die(_("--stateless-rpc requires multi_ack_detailed"));
+		die(_("the option '%s' requires '%s'"), "--stateless-rpc", "multi_ack_detailed");
 
 	packet_reader_init(&reader, fd[0], NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE |
diff --git a/http-fetch.c b/http-fetch.c
index c7c7d391ac5..58b394cd47f 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -141,7 +141,7 @@ int cmd_main(int argc, const char **argv)
 
 	if (packfile) {
 		if (!index_pack_args.nr)
-			die(_("--packfile requires --index-pack-args"));
+			die(_("the option '%s' requires '%s'"), "--packfile", "--index-pack-args");
 
 		fetch_single_packfile(&packfile_hash, argv[arg],
 				      index_pack_args.v);
@@ -150,7 +150,7 @@ int cmd_main(int argc, const char **argv)
 	}
 
 	if (index_pack_args.nr)
-		die(_("--index-pack-args can only be used with --packfile"));
+		die(_("the option '%s' requires '%s'"), "--index-pack-args", "--packfile");
 
 	if (commits_on_stdin) {
 		commits = walker_targets_stdin(&commit_id, &write_ref);
diff --git a/revision.c b/revision.c
index d28b63a3253..13ccc6829f1 100644
--- a/revision.c
+++ b/revision.c
@@ -2884,7 +2884,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (revs->no_walk && revs->graph)
 		die(_("options '%s' and '%s' cannot be used together"), "--no-walk", "--graph");
 	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
-		die("cannot use --grep-reflog without --walk-reflogs");
+		die(_("the option '%s' requires '%s'"), "--grep-reflog", "--walk-reflogs");
 
 	if (revs->line_level_traverse &&
 	    (revs->diffopt.output_format & ~(DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT)))
diff --git a/t/t2026-checkout-pathspec-file.sh b/t/t2026-checkout-pathspec-file.sh
index fbe26de2f90..9e6b17e2d23 100755
--- a/t/t2026-checkout-pathspec-file.sh
+++ b/t/t2026-checkout-pathspec-file.sh
@@ -158,7 +158,7 @@ test_expect_success 'error conditions' '
 	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
 
 	test_must_fail git checkout --pathspec-file-nul 2>err &&
-	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err
+	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec-from-file." err
 '
 
 test_done
diff --git a/t/t2072-restore-pathspec-file.sh b/t/t2072-restore-pathspec-file.sh
index ad1fc0ed071..af67ca7d52b 100755
--- a/t/t2072-restore-pathspec-file.sh
+++ b/t/t2072-restore-pathspec-file.sh
@@ -158,7 +158,7 @@ test_expect_success 'error conditions' '
 	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
 
 	test_must_fail git restore --pathspec-file-nul --source=HEAD^1 2>err &&
-	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err &&
+	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec-from-file." err &&
 
 	test_must_fail git restore --pathspec-from-file=empty_list --source=HEAD^1 2>err &&
 	test_i18ngrep -e "you must specify path(s) to restore" err
diff --git a/t/t3601-rm-pathspec-file.sh b/t/t3601-rm-pathspec-file.sh
index b2a8db69afc..bbed67f8ef5 100755
--- a/t/t3601-rm-pathspec-file.sh
+++ b/t/t3601-rm-pathspec-file.sh
@@ -70,7 +70,7 @@ test_expect_success 'error conditions' '
 	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
 
 	test_must_fail git rm --pathspec-file-nul 2>err &&
-	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err &&
+	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec-from-file." err &&
 
 	>empty_list &&
 	test_must_fail git rm --pathspec-from-file=empty_list 2>err &&
diff --git a/t/t3704-add-pathspec-file.sh b/t/t3704-add-pathspec-file.sh
index 7e17ae80229..47ad96bf661 100755
--- a/t/t3704-add-pathspec-file.sh
+++ b/t/t3704-add-pathspec-file.sh
@@ -150,7 +150,7 @@ test_expect_success 'error conditions' '
 	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
 
 	test_must_fail git add --pathspec-file-nul 2>err &&
-	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err &&
+	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec-from-file." err &&
 
 	# This case succeeds, but still prints to stderr
 	git add --pathspec-from-file=empty_list 2>err &&
diff --git a/t/t3909-stash-pathspec-file.sh b/t/t3909-stash-pathspec-file.sh
index aae2b25f766..fde4625cfcb 100755
--- a/t/t3909-stash-pathspec-file.sh
+++ b/t/t3909-stash-pathspec-file.sh
@@ -94,7 +94,7 @@ test_expect_success 'error conditions' '
 	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
 
 	test_must_fail git stash push --pathspec-file-nul 2>err &&
-	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err
+	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec-from-file." err
 '
 
 test_done
diff --git a/t/t7107-reset-pathspec-file.sh b/t/t7107-reset-pathspec-file.sh
index b211fbc0a52..f753e3229e2 100755
--- a/t/t7107-reset-pathspec-file.sh
+++ b/t/t7107-reset-pathspec-file.sh
@@ -166,7 +166,7 @@ test_expect_success 'error conditions' '
 	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
 
 	test_must_fail git reset --pathspec-file-nul 2>err &&
-	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err &&
+	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec-from-file." err &&
 
 	test_must_fail git reset --soft --pathspec-from-file=list 2>err &&
 	test_i18ngrep -e "fatal: Cannot do soft reset with paths" err &&
diff --git a/t/t7526-commit-pathspec-file.sh b/t/t7526-commit-pathspec-file.sh
index 574cf30285c..ea69e3a6ad1 100755
--- a/t/t7526-commit-pathspec-file.sh
+++ b/t/t7526-commit-pathspec-file.sh
@@ -153,7 +153,7 @@ test_expect_success 'error conditions' '
 	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
 
 	test_must_fail git commit --pathspec-file-nul -m "Commit" 2>err &&
-	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err &&
+	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec-from-file." err &&
 
 	test_must_fail git commit --pathspec-from-file=empty_list --include -m "Commit" 2>err &&
 	test_i18ngrep -e "No paths with --include/--only does not make sense." err &&
-- 
gitgitgadget


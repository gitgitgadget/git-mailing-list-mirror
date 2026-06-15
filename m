Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6231E410D3E
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 16:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542061; cv=none; b=bgmWcikdEaKqdrZrwNKX9v+E/741OL2Cjr3IfwgkJPa5NdCKuk8ZNVr11IYg0Xn2/u00j+U1nUB3fVHBZbzjFggyE1yIRv5f8Qa2QA9CFn2NkmC44oGuJm6aVEM+KPbt5kHDblAc9ZaFk/bjcVjwKF9gdHSH2V6+BBJFk1pBqx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542061; c=relaxed/simple;
	bh=ci4OKeHT9eDgHTpxr156Qllfg2LMdgWxKHoX5gvSnew=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=P37Zcnkk0UkOJCfduoJlC6nNPPAyLOY2y1DouzTs8ToufBA57x1/yLQhVY1Z7HrpxXO88wwUdyEpqRvLn2N9mBAqa21YaOYicDIGChwMIbcbxF4hCZeUzUBkx3P9nLxeD37Q0vJ5UoYcOLmDlC2kKSCnFPjUtjbICWpq8osVV0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r4Xy6qBH; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4Xy6qBH"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-30807ba471bso10138528eec.1
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 09:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781542059; x=1782146859; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wdaiaAsOn5ptqV1LOJnXvC4Y/auDZW1TmtrKWSp9Bw=;
        b=r4Xy6qBHtFR7ZgNTObfn2CXwmDmPSyChQkrp5AIh+FX/qvG+eimCECBHc+KTmOX7ul
         4zHDzoaojnXFiKivyXZ4FwoSdzj9W/fvzBuYxiNiIF0Bth3hXcyX8Hb3EPuyFtHXdYpq
         R2idEGJ2HSLvyaMDXt+eLAtxGEOJmQsxYyhcB2/4hRGiGg/wjG2Vg3liqLE41vTx4Yjl
         OHv92yARc/Cgxa2PpHzuQ52SaJWUMHNbvIM6IQlo1ZeeqWp0hFjF23DLBRQgFuU6WE1z
         0yUvBaJWm62gS9CyB88Lk9qjY6XDJ8Hls7nC7oJbgP6FGkN5sLFuVYiKkbwFtIIqqhOj
         FZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781542059; x=1782146859;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+wdaiaAsOn5ptqV1LOJnXvC4Y/auDZW1TmtrKWSp9Bw=;
        b=pF6JJB3wehOBuh1vHKQXKd1CgnlTRarlJuJF27g3PgQ+DcFXu4/9xJkgadwGXNBjcp
         nd6QVeU8rTT7PpKtAM0D0+T8X/mYVdZXC5LyBynMaFaUEVb5Nd9LcbQ6+9ZHBuf0ZkcM
         5EE66RdbkA4GJP5RkwCIDHAAUPA8SR56NUvxkiJy39Odh+iPYFRE1+VpqM+OQJ/poZNM
         SqOzu5I6U8Kcq2V/YhCx2JnHw+vKNKt4FZ1OIxxq7efTY/JpFnPG6blITKmIZj6/ninj
         +Gh63R9ONq+b8ArwNhTFamjn/n5UPUMbAF2KjnCOXwnRSsnxsqLQTCH3JLZUnocJZ9Kd
         Dleg==
X-Gm-Message-State: AOJu0Yy7/9tqx+xS2kZnlvSUVs9NK7U86B38bxfvSB0LcgpzL6wnWTfA
	N6+P5neC89yY86gqPzyB+7+T8ev5usOJrLOOZuoonFZexZBZfjwX5TC1XX4epg==
X-Gm-Gg: Acq92OFO6CHlO7utJuZGtmeJd0DrIOTFkDrsxqGMQCXMK4s3oBKRh7ZuMnGn6sBP7Cg
	UFLrgV0RFviZ7Rkuct9qiseqCwQhGfSNPnE/2NcxARez1pyCtxuJbcB73/iaxbveNSpowK0YcCS
	wa2MmPzXB/FXAMj6t9CKgraGGzTYgdVeS2npu09rx721Khdy1mgKwFkdjOnM5ZKZSQHRVtvwpy5
	yePpgngK6aFMclGG3D4wXwM285u0OTCXuQUpgRITLe34SFOcKgijx9IbUIhsfTmHw0l96C7APyv
	eKpUv+KID/r6UeCP6t5EoexLUaTDiuaXSdPSyA9HvfYTKrtY6IV9cplfPHtWMRSEB8K9LShcyDd
	EzcJPWvT6nWqbsgrLObZ7rQVS2QA1Tk97/Y1z/U3n2EkpIXronZkjcTFp7eplWsTkzpvhUIbDLp
	/RC1VqtMU+PqXZyWsyFSFGX75g
X-Received: by 2002:a05:7300:b54b:b0:304:de28:1b16 with SMTP id 5a478bee46e88-308200a60b5mr8801981eec.28.1781542058574;
        Mon, 15 Jun 2026 09:47:38 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.162.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5fefecsm15507203eec.13.2026.06.15.09.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 09:47:38 -0700 (PDT)
Message-Id: <7b2b01b9887d630a47be0f9e98c4a75f0b22626f.1781542042.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v15.git.git.1781542042.gitgitgadget@gmail.com>
References: <pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
	<pull.2285.v15.git.git.1781542042.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 15 Jun 2026 16:47:22 +0000
Subject: [PATCH v15 7/7] branch: add --dry-run for --delete-merged
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

With --dry-run, --delete-merged prints the local branches it would
delete, one "Would delete branch <name>" line each, and exits
without touching any ref. The same filtering applies, so the output
is exactly the set that the real run would delete.

--dry-run is only meaningful together with --delete-merged and is
rejected otherwise.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc |  8 ++++++-
 builtin/branch.c              | 13 ++++++++---
 t/t3200-branch.sh             | 44 +++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 91700f2e8a..09063d74f2 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -25,7 +25,7 @@ git branch (-m|-M) [<old-branch>] <new-branch>
 git branch (-c|-C) [<old-branch>] <new-branch>
 git branch (-d|-D) [-r] <branch-name>...
 git branch --edit-description [<branch-name>]
-git branch --delete-merged <branch>...
+git branch [--dry-run] --delete-merged <branch>...
 
 DESCRIPTION
 -----------
@@ -226,6 +226,12 @@ A branch whose work has not yet been merged into its upstream is
 silently skipped. Delete it with `git branch -D` if you want to
 remove it anyway.
 
+`--dry-run`::
+	With `--delete-merged`, print which branches would be
+	deleted and exit without touching any ref.  Useful for
+	sanity-checking a wide pattern like `'origin/*'` before
+	committing to the deletion.
+
 `-v`::
 `-vv`::
 `--verbose`::
diff --git a/builtin/branch.c b/builtin/branch.c
index 0e1e7c2e6f..d18a830249 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -716,7 +716,7 @@ static int parse_opt_forked(const struct option *opt, const char *arg, int unset
 }
 
 static int delete_merged_branches(int argc, const char **argv,
-				 int quiet)
+				 int quiet, int dry_run)
 {
 	struct ref_store *refs = get_main_ref_store(the_repository);
 	struct ref_filter filter = REF_FILTER_INIT;
@@ -775,7 +775,8 @@ static int delete_merged_branches(int argc, const char **argv,
 				      FILTER_REFS_BRANCHES,
 				      DELETE_BRANCH_SKIP_UNMERGED |
 				      DELETE_BRANCH_NO_HEAD_FALLBACK |
-				      (quiet ? DELETE_BRANCH_QUIET : 0));
+				      (quiet ? DELETE_BRANCH_QUIET : 0) |
+				      (dry_run ? DELETE_BRANCH_DRY_RUN : 0));
 
 	strvec_clear(&deletable);
 	ref_array_clear(&candidates);
@@ -825,6 +826,7 @@ int cmd_branch(int argc,
 	int delete = 0, rename = 0, copy = 0, list = 0,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
 	int delete_merged = 0;
+	int dry_run = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -880,6 +882,8 @@ int cmd_branch(int argc,
 			 N_("edit the description for the branch")),
 		OPT_BOOL(0, "delete-merged", &delete_merged,
 			N_("delete local branches whose upstream matches <branch> and are merged")),
+		OPT_BOOL(0, "dry-run", &dry_run,
+			N_("with --delete-merged, only print which branches would be deleted")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -942,6 +946,9 @@ int cmd_branch(int argc,
 	if (noncreate_actions > 1)
 		usage_with_options(builtin_branch_usage, options);
 
+	if (dry_run && !delete_merged)
+		die(_("--dry-run requires --delete-merged"));
+
 	if (recurse_submodules_explicit) {
 		if (!submodule_propagate_branches)
 			die(_("branch with --recurse-submodules can only be used if submodule.propagateBranches is enabled"));
@@ -981,7 +988,7 @@ int cmd_branch(int argc,
 				      (quiet ? DELETE_BRANCH_QUIET : 0));
 		goto out;
 	} else if (delete_merged) {
-		ret = delete_merged_branches(argc, argv, quiet);
+		ret = delete_merged_branches(argc, argv, quiet, dry_run);
 		goto out;
 	} else if (show_current) {
 		print_current_branch_name();
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 5ac3c2bb5d..1cb32497b8 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -2060,4 +2060,48 @@ test_expect_success 'branch -d still deletes a deleteMerged=false branch' '
 	test_must_fail git -C pm-optout-d rev-parse --verify refs/heads/one
 '
 
+test_expect_success '--delete-merged --dry-run lists but does not delete' '
+	test_when_finished "rm -rf pm-dry" &&
+	git clone pm-upstream pm-dry &&
+	git -C pm-dry remote add fork ../pm-fork &&
+	test_config -C pm-dry remote.pushDefault fork &&
+	test_config -C pm-dry push.default current &&
+	git -C pm-dry branch one one-commit &&
+	git -C pm-dry branch --set-upstream-to=origin/next one &&
+	git -C pm-dry branch two two-commit &&
+	git -C pm-dry branch --set-upstream-to=origin/next two &&
+
+	git -C pm-dry branch --dry-run --delete-merged "origin/*" >actual &&
+	test_grep "Would delete branch one " actual &&
+	test_grep "Would delete branch two " actual &&
+
+	git -C pm-dry rev-parse --verify refs/heads/one &&
+	git -C pm-dry rev-parse --verify refs/heads/two
+'
+
+test_expect_success '--delete-merged --dry-run only lists branches the live run would delete' '
+	test_when_finished "rm -rf pm-dry-mixed" &&
+	git clone pm-upstream pm-dry-mixed &&
+	git -C pm-dry-mixed remote add fork ../pm-fork &&
+	test_config -C pm-dry-mixed remote.pushDefault fork &&
+	test_config -C pm-dry-mixed push.default current &&
+	git -C pm-dry-mixed checkout -b wip origin/next &&
+	git -C pm-dry-mixed branch --set-upstream-to=origin/next wip &&
+	test_commit -C pm-dry-mixed local-only &&
+	git -C pm-dry-mixed checkout - &&
+	git -C pm-dry-mixed branch merged one-commit &&
+	git -C pm-dry-mixed branch --set-upstream-to=origin/next merged &&
+
+	git -C pm-dry-mixed branch --dry-run --delete-merged "origin/*" >out &&
+	test_grep "Would delete branch merged" out &&
+	test_grep ! "Would delete branch wip" out &&
+	git -C pm-dry-mixed rev-parse --verify refs/heads/wip &&
+	git -C pm-dry-mixed rev-parse --verify refs/heads/merged
+'
+
+test_expect_success '--dry-run without --delete-merged is rejected' '
+	test_must_fail git -C forked branch --dry-run 2>err &&
+	test_grep "requires --delete-merged" err
+'
+
 test_done
-- 
gitgitgadget

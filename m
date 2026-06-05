Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A1D3ED5CD
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 18:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684566; cv=none; b=Z4LdhFYLneft/XjAKSa12M8pUfGULCPntGmgGmVcbQbAKFU7jxlqDUVsK9kaMroK8Rldt6snE9cgVZwQn4g2SNp/eLD8UVv/xg0yMl5LSaX+SzRIguVT8xR3g36p6s21KXORl6SyZHzmxv+zdO1zaZJH26dIDoIKtIXAlfer5hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684566; c=relaxed/simple;
	bh=S08OU5uDcavPkT7FR4K7n/Zj5COcVrcHpBuPxXbJnHg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=laPtF19uaZo7R92g+DkI7lh3b8aSVtETfDzv92sd/Tiu+E/yZDtquoknxkXuDxnUK6MJ3ilyJ9ag9lHrufpi1bNArA6cF4t+9ZkkB0zTsQHBNULez+wcOsdkZbKYYvXMgPijAfgZbHAzbs7xMcP8uzNY2wn2VbuhUpzvXorTBcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkPMjx81; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkPMjx81"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-13721dfd471so3046951c88.1
        for <git@vger.kernel.org>; Fri, 05 Jun 2026 11:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780684564; x=1781289364; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSBK12ieg1oeTUtcJjhB+RSAbeTA06/dXwUEJXA9yjs=;
        b=KkPMjx81vCEpeJmoCitplHqkbrcmj87Y2oyep61XK4rEYSrZ4PRYW5t9xoW/3IEaRp
         7PUfW6ULmSCHjcNKLHnp4EEzUIo+1kZWdThLloy1gdw3XjcNUjI3TEbG2YzaBtdojPN8
         l1Po9Xdr6PcyJO5PBZiP9AGeKSAswFp0+/g7OTyjkXN+/pzB3cddbR//ZBn2ac9gnMnB
         2U6ZMc3kwUCRE6hg2CF7VHuDUO837SJEorjQ5FJIXPISjxUQxFfzKAoIJyUV9veqmj7n
         I9vSQJj8xOTmJ8U07Gcsv6XzNq6vrVRfBxChepyYoTNwS+3mzCzGAMwBDGOB9M6IOrzs
         9qJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780684564; x=1781289364;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DSBK12ieg1oeTUtcJjhB+RSAbeTA06/dXwUEJXA9yjs=;
        b=ZbaMH02n+gtI4BFQfn4UGVZMBdWjET6gccvvzpvqxomSrIY6+okmYXtPyc6wCm5tGf
         O5OyIrGBJTmW7eV5QTg4w/5EvqG6xmcKyvTvNmayZw5v5ZdL/NYnef5frFE/NCTsCVPq
         +65wMKxTFxfzGPNipVGQfwMvOSnkObVY37aQxwY9et2mwUCh2HkRGOZNgOJCtr0Mcj8m
         Cmg7v507x9aYJ+2tyb4158UtkyS0S6bFKnaqbVtnbwHr/rp12XMhF+3I6g/Peutj2Sea
         Zj8cxiHgTJixK6igPOaTdnl9kdNnnoNFoese2B/PE3B+25yhKVdGG051le3hs7MGXVca
         lk+A==
X-Gm-Message-State: AOJu0YzeiuedRuVQm02ajfE3PEtVzoCkEOd10Q6wC6TBn+cxzreEaKKk
	Gmp2NX9zlYbMQ2k+aQek/5Pmf8rBVIoe95CPHLQ7hX13MANpP0dXFqitvR1Sg5/s
X-Gm-Gg: Acq92OEUaaOC0CXxAcrOkAHwJ/9R9d6jnH95/IFdimFrLuxLDH2/mDKmJe0BohEkBH2
	QDHPQ5JqUAURP0NDFLIFXktAsBIdfIZPUnXevg12EkXIvlQi/Kuw8qE/9NBMoP6uXu2sZBFfQ/k
	3HjJM3S5YBoWnQckiwN8EQGn7ys36PYWTuCi5DF7L5HkI7NI6JsvwtI3gFPAMLvM2e3LmEN6bsl
	+E4xsBuKL81hj9c9sddYL1UYOBUErWYoaj4Yf5DTmVt39nnePK/VT+9WpZLtF/0QYNE4AfLB8vF
	Sirt4rfRQP0ofEFtOrt8RpAM8PIyMKJy3C8I06IL8j3vl8Hl7n1I3Sjyb7BW8DjTGNulOmYHSrw
	NTq6PhV7DYlB2fQLjtDDozfrH7Pr5Vj/xTXE9dT3YD/Vk+LcSb7rSd9xwu4zPDMyGOweC9jxOLJ
	+/Fl56zWsahFVgfcASHM8dxSnaOkFy74J8ELA=
X-Received: by 2002:a05:7022:6b99:b0:136:b370:64de with SMTP id a92af1059eb24-1380671273bmr2355392c88.32.1780684563940;
        Fri, 05 Jun 2026 11:36:03 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.53.54])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f53f06c4sm6206663c88.0.2026.06.05.11.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 11:36:03 -0700 (PDT)
Message-Id: <511de4788ed4589b5e63db15cb1b75d5eb4b5c59.1780684553.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
References: <pull.2285.v12.git.git.1780477479.gitgitgadget@gmail.com>
	<pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 05 Jun 2026 18:35:53 +0000
Subject: [PATCH v13 6/6] branch: add --dry-run for --prune-merged
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

With --dry-run, --prune-merged prints the local branches it would
delete, one "Would delete branch <name>" line each, and exits
without touching any ref. The same filtering applies, so the output
is exactly the set that the real run would delete.

--dry-run is only meaningful together with --prune-merged and is
rejected otherwise.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc |  8 ++++++-
 builtin/branch.c              | 13 ++++++++---
 t/t3200-branch.sh             | 44 +++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 5c43dc55a8..1f49a831fd 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -25,7 +25,7 @@ git branch (-m|-M) [<old-branch>] <new-branch>
 git branch (-c|-C) [<old-branch>] <new-branch>
 git branch (-d|-D) [-r] <branch-name>...
 git branch --edit-description [<branch-name>]
-git branch --prune-merged <branch>...
+git branch [--dry-run] --prune-merged <branch>...
 
 DESCRIPTION
 -----------
@@ -226,6 +226,12 @@ Branches refused by the "fully merged" safety check are listed as
 warnings and skipped; pass them to `git branch -D` explicitly if
 you want them gone.
 
+`--dry-run`::
+	With `--prune-merged`, print which branches would be
+	deleted and exit without touching any ref.  Useful for
+	sanity-checking a wide pattern like `'origin/*'` before
+	committing to the deletion.
+
 `-v`::
 `-vv`::
 `--verbose`::
diff --git a/builtin/branch.c b/builtin/branch.c
index be4218ded3..98e56d4ff8 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -715,7 +715,7 @@ static int parse_opt_forked(const struct option *opt, const char *arg, int unset
 }
 
 static int prune_merged_branches(int argc, const char **argv,
-				 int quiet)
+				 int quiet, int dry_run)
 {
 	struct ref_store *refs = get_main_ref_store(the_repository);
 	struct ref_filter filter = REF_FILTER_INIT;
@@ -775,7 +775,8 @@ static int prune_merged_branches(int argc, const char **argv,
 				      FILTER_REFS_BRANCHES,
 				      DELETE_BRANCH_WARN_ONLY |
 				      DELETE_BRANCH_NO_HEAD_FALLBACK |
-				      (quiet ? DELETE_BRANCH_QUIET : 0));
+				      (quiet ? DELETE_BRANCH_QUIET : 0) |
+				      (dry_run ? DELETE_BRANCH_DRY_RUN : 0));
 
 	strvec_clear(&deletable);
 	ref_array_clear(&candidates);
@@ -825,6 +826,7 @@ int cmd_branch(int argc,
 	int delete = 0, rename = 0, copy = 0, list = 0,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
 	int prune_merged = 0;
+	int dry_run = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -880,6 +882,8 @@ int cmd_branch(int argc,
 			 N_("edit the description for the branch")),
 		OPT_BOOL(0, "prune-merged", &prune_merged,
 			N_("delete local branches whose upstream matches <branch> and is merged")),
+		OPT_BOOL(0, "dry-run", &dry_run,
+			N_("with --prune-merged, only print which branches would be deleted")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -942,6 +946,9 @@ int cmd_branch(int argc,
 	if (noncreate_actions > 1)
 		usage_with_options(builtin_branch_usage, options);
 
+	if (dry_run && !prune_merged)
+		die(_("--dry-run requires --prune-merged"));
+
 	if (recurse_submodules_explicit) {
 		if (!submodule_propagate_branches)
 			die(_("branch with --recurse-submodules can only be used if submodule.propagateBranches is enabled"));
@@ -981,7 +988,7 @@ int cmd_branch(int argc,
 				      (quiet ? DELETE_BRANCH_QUIET : 0));
 		goto out;
 	} else if (prune_merged) {
-		ret = prune_merged_branches(argc, argv, quiet);
+		ret = prune_merged_branches(argc, argv, quiet, dry_run);
 		goto out;
 	} else if (show_current) {
 		print_current_branch_name();
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 3f7b1fc3d6..305c0141fc 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -2040,4 +2040,48 @@ test_expect_success 'branch -d still deletes a pruneMerged=false branch' '
 	test_must_fail git -C pm-optout-d rev-parse --verify refs/heads/one
 '
 
+test_expect_success '--prune-merged --dry-run lists but does not delete' '
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
+	git -C pm-dry branch --dry-run --prune-merged "origin/*" >actual &&
+	test_grep "Would delete branch one " actual &&
+	test_grep "Would delete branch two " actual &&
+
+	git -C pm-dry rev-parse --verify refs/heads/one &&
+	git -C pm-dry rev-parse --verify refs/heads/two
+'
+
+test_expect_success '--prune-merged --dry-run only lists branches the live run would delete' '
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
+	git -C pm-dry-mixed branch --dry-run --prune-merged "origin/*" >out &&
+	test_grep "Would delete branch merged" out &&
+	test_grep ! "Would delete branch wip" out &&
+	git -C pm-dry-mixed rev-parse --verify refs/heads/wip &&
+	git -C pm-dry-mixed rev-parse --verify refs/heads/merged
+'
+
+test_expect_success '--dry-run without --prune-merged is rejected' '
+	test_must_fail git -C forked branch --dry-run 2>err &&
+	test_grep "requires --prune-merged" err
+'
+
 test_done
-- 
gitgitgadget

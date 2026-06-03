Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0039A36AB77
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 09:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780477498; cv=none; b=KgMtftDqnB2WOXWqf+i6BY6fAEQkMBmRgzaPRCuxvnAwwftDPscHeb/4yTKNlM9ec8gIiPxO4DKCWWvy4dNG6FgTs0eqRcrI07PpxXZNnWn8O9T3ud2eF6CD/9hmQkrzG3JTB9CKv8pUNm1k2Gcuj3YzvfuyZY+raQaJfeJOsuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780477498; c=relaxed/simple;
	bh=oSZhL4kJqUEz3PPBzV9/P5db6j/Mmm9mnk+cOTMJy9Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WND1r5ec8lqaGRUVRyox3KdqWQIUEjRx7hYgqzEd8wV9BixHK+lJjeVJYE/kU/y8AZDv00Jwtd8q/ID2GS01UCvzKX15ZUP2OyMfpve8q6qUvB8U0AZqNFT3pjSlUUJ+hOQrkmbZeczXc1g4Q3D2s2ug8c5pA6UmAHuKXcHfYhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XObw7MKf; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XObw7MKf"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1363e78746eso15541663c88.1
        for <git@vger.kernel.org>; Wed, 03 Jun 2026 02:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780477496; x=1781082296; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UX3rOPowY+luuxWd7N1DePRMJgDpujxBvgosjNovdQs=;
        b=XObw7MKf/IRRc9WbhF7gMVZ5ylrzFQfRySz5zuDMM8MMmsDkAoV9Q15bX1Y0XbqdXa
         ShWNZqoO7ax2oBXCLJ8cHn9MvC7orR/zcmIn5zfkO8t321Da2sZfKI9nclhXATSeSgse
         RunCe2hC6xy2jklx7QhSIO80IjuxQyO2k2YWzn5Pr1NkdBJSnH70vuOMnClHHBzdYtbb
         mSrVfAcxUx4dpjFmcMIVF3G1IdxeM46mYRTMPNGinMgmJpAc95eQAF1Uf7ysEDCSBOge
         n+2lgRCUPj2dIyu3O0f5Eohbzu8wDA/smKiuw01TZkTO3wJ1hYl2d8VUON9I9RQBWHs1
         fSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780477496; x=1781082296;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UX3rOPowY+luuxWd7N1DePRMJgDpujxBvgosjNovdQs=;
        b=ljy6JFN78sJr0Cfi37pMNbrErAB1o6FtW2gUvZnVhGvTUaoFQEnioEbo+LnYRp/x0r
         1GalcdXPIFjoXPxiLKjMGNeolq7y8M1jTTNMx9/p0cAWggUmxJUkTNs9WUAwPVpFmAzW
         kDRPHbhEDGwhpevisKu5pd8zeDuczzvO3ki/ZvOPjLFpRlafbMaH98naPCFRiV01Qr4V
         OgPsSgIPjs2jfEnK/CuJaq4JO4H6aMM3FqlcVym6qgGAxAToCEmD4wURVovXoEnu30+l
         /Ccw5gnwOXYtc8pMo3mwDaCdUpT6SsZ+AUqFnx+sByu5wp8jaqWzkbZRORq0g+2oU4ea
         OBPw==
X-Gm-Message-State: AOJu0YxDZKUmykEQucm8UcT6iIdVirEXFflHwofJt/H2aoCfcl9aVLWO
	VKECYaNDWlGawxuIEJXdlQ72NTY2MsMK8BabRlpd60+V7LtUbul2eNdr7DWu0n+w
X-Gm-Gg: Acq92OGflXePMgPchXsg7oE4A4W4LpZEKs/N20wrrMOh5CityAVYplWRCcZ9N2mjAKZ
	gNe3DZDkf94g1OKXIel4Sni4kTsWk0cjhv4olbE/L7RnfEkJJ14kfZGVxDDW9hKcTAkjKG75gPC
	W5E0ILmZHaZNgtp9vxLbERaYYIeFQns+jEO9Nu6RIve6ZOSXnPF0t8rgoFDs7C00/Jo4D0yEGlj
	IPjhSi6oIs4O0svLaaACHQfcA4MGnGSdSWxsArqM7Ed2KL+Dzg8o7gy8LxUX7NlRIoUtkeCL3+Q
	xYAYGmwHeZMkWb3cDLhbr1Pzb3/HZkoz9k7yR1H5/7s3wLtrfFDky5hSIZSsR7VY6/mwMN0qs2X
	K3BuPeWO5B0T+UPKDIuopNbnFJvon6cwFrwFggkEw/MnrwNAL6/ifQyRwqPvMyxpdWS+VY8tM+L
	83+IFHlAQ2QiifVKfUpbsISS4ZHYMcRJDZebevQw==
X-Received: by 2002:a05:7022:6286:b0:136:b67e:93e6 with SMTP id a92af1059eb24-137f6c456f4mr896938c88.37.1780477495938;
        Wed, 03 Jun 2026 02:04:55 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.228.214])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f5539035sm1600167c88.11.2026.06.03.02.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 02:04:53 -0700 (PDT)
Message-Id: <1a0d5eab1598bec2b61a46578cfc8d3274398d35.1780477479.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v12.git.git.1780477479.gitgitgadget@gmail.com>
References: <pull.2285.v11.git.git.1779449498.gitgitgadget@gmail.com>
	<pull.2285.v12.git.git.1780477479.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 03 Jun 2026 09:04:39 +0000
Subject: [PATCH v12 6/6] branch: add --dry-run for --prune-merged
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
delete, one "Would delete branch <name>" line per candidate, and
exits without touching any ref.

The @{push}-vs-@{upstream} and unmerged filtering still applies,
so the dry-run output is exactly the set that the live run would
delete.

--dry-run is only meaningful in combination with --prune-merged
and is rejected otherwise.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc |  8 ++++++-
 builtin/branch.c              | 12 +++++++---
 t/t3200-branch.sh             | 44 +++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 69878549fc..c579df4fe0 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -25,7 +25,7 @@ git branch (-m|-M) [<old-branch>] <new-branch>
 git branch (-c|-C) [<old-branch>] <new-branch>
 git branch (-d|-D) [-r] <branch-name>...
 git branch --edit-description [<branch-name>]
-git branch (--prune-merged <branch>)...
+git branch [--dry-run] (--prune-merged <branch>)...
 
 DESCRIPTION
 -----------
@@ -230,6 +230,12 @@ Branches refused by the "fully merged" safety check are listed as
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
index e03805a8a7..1811511b9e 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -860,7 +860,7 @@ static void collect_forked_set(const struct string_list *upstreams,
 }
 
 static int prune_merged_branches(const struct string_list *upstreams,
-				 int quiet)
+				 int quiet, int dry_run)
 {
 	struct ref_store *refs = get_main_ref_store(the_repository);
 	struct string_list candidates = STRING_LIST_INIT_DUP;
@@ -917,7 +917,7 @@ static int prune_merged_branches(const struct string_list *upstreams,
 				      quiet,
 				      1, /* warn_only */
 				      1, /* no_head_fallback */
-				      0  /* dry_run */);
+				      dry_run);
 
 	strvec_clear(&deletable);
 	string_list_clear(&candidates, 0);
@@ -967,6 +967,7 @@ int cmd_branch(int argc,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
 	struct string_list forked_upstreams = STRING_LIST_INIT_DUP;
 	struct string_list prune_merged_upstreams = STRING_LIST_INIT_DUP;
+	int dry_run = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -1024,6 +1025,8 @@ int cmd_branch(int argc,
 			N_("list local branches whose upstream matches <branch> (repeatable)")),
 		OPT_STRING_LIST(0, "prune-merged", &prune_merged_upstreams, N_("branch"),
 			N_("delete local branches whose upstream matches <branch> and is merged (repeatable)")),
+		OPT_BOOL(0, "dry-run", &dry_run,
+			N_("with --prune-merged, only print which branches would be deleted")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -1083,6 +1086,9 @@ int cmd_branch(int argc,
 	if (noncreate_actions > 1)
 		usage_with_options(builtin_branch_usage, options);
 
+	if (dry_run && !prune_merged_upstreams.nr)
+		die(_("--dry-run requires --prune-merged"));
+
 	if (recurse_submodules_explicit) {
 		if (!submodule_propagate_branches)
 			die(_("branch with --recurse-submodules can only be used if submodule.propagateBranches is enabled"));
@@ -1124,7 +1130,7 @@ int cmd_branch(int argc,
 		if (argc)
 			die(_("--prune-merged does not take positional arguments; "
 			      "repeat --prune-merged for each <branch>"));
-		ret = prune_merged_branches(&prune_merged_upstreams, quiet);
+		ret = prune_merged_branches(&prune_merged_upstreams, quiet, dry_run);
 		goto out;
 	} else if (show_current) {
 		print_current_branch_name();
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 9e33179590..29bfd0e109 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -2027,4 +2027,48 @@ test_expect_success 'branch -d still deletes a pruneMerged=false branch' '
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

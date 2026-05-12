Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68A5385D7E
	for <git@vger.kernel.org>; Tue, 12 May 2026 17:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778605673; cv=none; b=cMTyXDXojCvuBIZRncPyU9TKFUQOnT2d4+oz7srgOp2ouFUtkdTKwM7UJ4XJuUhRGP+Jj9a/6HJ4wVk4pNnFHr1lL3yI66XVmWlPtwugbZNjA+fpEbbUnNvTIGiSlIW/ZcwDoG5uBKK0aBFVhTxh4JyXD8MVOLxEv+Lgobkt/4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778605673; c=relaxed/simple;
	bh=fRynSVv8/iDdeECF8zGwnJDWcRh+ybSujcJD6suCfwk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=W8de7kZbkv3LnPq/m0nItLNvl+BhuUsa61gPo6fC73nUft+7Wa5nUo1gOd9BfwLvBV7kP7NMzGoi2KpN6cqYYeVR0wMjbfR3MePLO+LLNxNCv/zktXKLYu9FFf2HaoH4hAACdyVJUBuqI/Q/7EgobaYZ3/85lD+WL38pxfRiVRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvP3gCVS; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvP3gCVS"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-365eecc5885so5770108a91.0
        for <git@vger.kernel.org>; Tue, 12 May 2026 10:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778605671; x=1779210471; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EorhB6SXL5dm82aq4wm72csffp2mQwLOQLDEylf15aw=;
        b=EvP3gCVSIJNrq3VkTAp+AXTytw311wdR76Cda4x8YEhZOysbKb/SmxBx1CFoKeqgW9
         vxyos8uOBOmlzxUHi83XhYP4iaJpGEUFw97Hx1qKUK9XKlwnHXid8M7FhzXFUVqnIWai
         FhV5br6I4T5ty7N+XEmCa3OveKsvGaKJJcrNKVP/B/uO4+nZzwH4sE+gfKuSyuWCblOC
         FNRsWRagp/6e4EnZBWkCxZhDIJeHD2vSWQZ/CCZb5qqDiVohvSEx8+Fog+FYaD83TVfV
         SZrWRhp3+HtAGP/hn06c+dd4qyI8aFSwIPJiX7xbaezLOK49/JR5z1UpFL6RRbDhp7Y5
         /+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778605671; x=1779210471;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EorhB6SXL5dm82aq4wm72csffp2mQwLOQLDEylf15aw=;
        b=BhXEzlZOrzUprXD36iePw1Z2MVsFltKPHdGLNBASQzWGfJlJkCVFSlAZhHtk+G3BuM
         mynwGxiwSOwza4xoXEYROHoRY3NVWSuZcKN+1I6AikdkWpRHJVNhHUjiWVL0dcojRIpe
         wyFRIDYPqtRjwwieER5P63cFosVr2PTJehTtR1Mz8/Px5DFB4/Y23TZIoBz4ofbKuHPd
         DYrcO4XPQ/tIFsCPnjdRKg6cZRYtxjZSNn57o3Ltk9JvHza161nP0wYO9mstabWJ56a6
         B59825j9Nr2avhuiT4o/8n56PoAaafvtwbNJynK21Ph8eatZTc/48XWX375PSZMnlzmf
         GjKQ==
X-Gm-Message-State: AOJu0YzZ+DWUUMXr8nOf+mtznIKxiLz4OxlkLfXC34GlbXFnNHdESf14
	qjs0n+Pkve+a2k5rb50uRCTnbR1ADZhlEDDFA6IrUJ3F7PvdGSl6IRPYmea3NO+h
X-Gm-Gg: Acq92OEPbICgYT/6WwdKJ+6iONgazzxLR2EPWrkjSa4rmLodyZ4lxhPBkpdvEqzkYR4
	Lqzr7ajpXRep2+DUkx8lnIn9F/qJf9cx4NAd4u2jQFkVWUMm9Mb6krRCK8apIEOfUq1fug4bKcz
	pgFgxmVjHeJfxhreoEHwwtJgM+oIBVlE2Ae2fRHOaKeuKR8Cs6KZneyxvPI9wouXO5hqFKISTL1
	18CXFe1+JED97U5vRsIk6HjiLOBnokDti0d9ZAgkNcu3ASXvIrOM/WmTWHs6OgyFMzDAxEfjLZc
	dGhR8zYLOAhcxj5fpQqOPPNpe3cegRwIfTo7ph55SbvWXarMBqKRZtmouBc4mnSe0PSThsowQ1U
	fvlgDmVqXLJDPmhw3xUTW443KJxNgtTzTvt1wwSTCMrFKmrOhVXAFf7cXFbxhBv1K5nNgfA9CpZ
	Ztoqfv9b/ODaRZTdUIbJ7aSQqoYWM=
X-Received: by 2002:a17:90b:1808:b0:367:bb47:9fc2 with SMTP id 98e67ed59e1d1-367d468c45cmr15361546a91.2.1778605670687;
        Tue, 12 May 2026 10:07:50 -0700 (PDT)
Received: from [127.0.0.1] ([20.163.246.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368ac4c8f2bsm2657912a91.0.2026.05.12.10.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 10:07:50 -0700 (PDT)
Message-Id: <6e81ed3147ac388aadd7e4034604f3be07c576eb.1778605658.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v8.git.git.1778605658.gitgitgadget@gmail.com>
References: <pull.2285.v7.git.git.1778574229.gitgitgadget@gmail.com>
	<pull.2285.v8.git.git.1778605658.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 12 May 2026 17:07:38 +0000
Subject: [PATCH v8 5/5] branch: add --all-remotes flag
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
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Combined with --forked or --prune-merged, --all-remotes acts on
every configured remote, in addition to any explicit <remote>
arguments. Used alone, it errors out.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc |  9 +++++--
 builtin/branch.c              | 41 ++++++++++++++++++++++----------
 t/t3200-branch.sh             | 44 +++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 080cdc218a..bf59f4852d 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -24,8 +24,8 @@ git branch (-m|-M) [<old-branch>] <new-branch>
 git branch (-c|-C) [<old-branch>] <new-branch>
 git branch (-d|-D) [-r] <branch-name>...
 git branch --edit-description [<branch-name>]
-git branch --forked <remote>...
-git branch [-f] --prune-merged <remote>...
+git branch --forked (<remote>... | --all-remotes)
+git branch [-f] --prune-merged (<remote>... | --all-remotes)
 
 DESCRIPTION
 -----------
@@ -232,6 +232,11 @@ currently checked-out branch in any worktree is always preserved,
 as is any branch with `branch.<name>.pruneMerged` set to `false`,
 and the local branch that mirrors _<remote>_'s default branch.
 
+`--all-remotes`::
+	With `--forked` or `--prune-merged`, act on every
+	configured remote in addition to any explicit _<remote>_
+	arguments.
+
 `-v`::
 `-vv`::
 `--verbose`::
diff --git a/builtin/branch.c b/builtin/branch.c
index 2969780210..081a1a1467 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -687,6 +687,13 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	free_worktrees(worktrees);
 }
 
+static int collect_remote_name(struct remote *remote, void *cb_data)
+{
+	struct string_list *remote_names = cb_data;
+	string_list_insert(remote_names, remote->name);
+	return 0;
+}
+
 static void parse_forked_args(int argc, const char **argv,
 			      struct string_list *remote_names,
 			      struct string_list *tracking_refs)
@@ -776,7 +783,7 @@ static void collect_default_branch_refs(const struct string_list *remote_names,
 	}
 }
 
-static void collect_forked_set(int argc, const char **argv,
+static void collect_forked_set(int argc, const char **argv, int all_remotes,
 			       struct string_list *protected_default_refs,
 			       struct string_list *out)
 {
@@ -789,6 +796,8 @@ static void collect_forked_set(int argc, const char **argv,
 	};
 
 	parse_forked_args(argc, argv, &remote_names, &tracking_refs);
+	if (all_remotes)
+		for_each_remote(collect_remote_name, &remote_names);
 
 	refs_for_each_branch_ref(get_main_ref_store(the_repository),
 				 collect_forked_branch, &cb);
@@ -802,15 +811,15 @@ static void collect_forked_set(int argc, const char **argv,
 	string_list_clear(&tracking_refs, 0);
 }
 
-static int list_forked_branches(int argc, const char **argv)
+static int list_forked_branches(int argc, const char **argv, int all_remotes)
 {
 	struct string_list out = STRING_LIST_INIT_DUP;
 	struct string_list_item *item;
 
-	if (!argc)
-		die(_("--forked requires at least one <remote>"));
+	if (!argc && !all_remotes)
+		die(_("--forked requires at least one <remote> or --all-remotes"));
 
-	collect_forked_set(argc, argv, NULL, &out);
+	collect_forked_set(argc, argv, all_remotes, NULL, &out);
 	for_each_string_list_item(item, &out)
 		puts(item->string);
 
@@ -818,8 +827,8 @@ static int list_forked_branches(int argc, const char **argv)
 	return 0;
 }
 
-static int prune_merged_branches(int argc, const char **argv, int force,
-				 int quiet)
+static int prune_merged_branches(int argc, const char **argv,
+				 int all_remotes, int force, int quiet)
 {
 	struct string_list candidates = STRING_LIST_INIT_DUP;
 	struct string_list protected_default_refs = STRING_LIST_INIT_DUP;
@@ -828,10 +837,11 @@ static int prune_merged_branches(int argc, const char **argv, int force,
 	int n_not_merged = 0;
 	int ret = 0;
 
-	if (!argc)
-		die(_("--prune-merged requires at least one <remote>"));
+	if (!argc && !all_remotes)
+		die(_("--prune-merged requires at least one <remote> or --all-remotes"));
 
-	collect_forked_set(argc, argv, &protected_default_refs, &candidates);
+	collect_forked_set(argc, argv, all_remotes, &protected_default_refs,
+			   &candidates);
 
 	for_each_string_list_item(item, &candidates) {
 		const char *short_name = item->string;
@@ -944,6 +954,7 @@ int cmd_branch(int argc,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
 	int forked = 0;
 	int prune_merged = 0;
+	int all_remotes = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -1001,6 +1012,9 @@ int cmd_branch(int argc,
 			N_("list local branches forked from the given <remote>s")),
 		OPT_BOOL(0, "prune-merged", &prune_merged,
 			N_("delete local branches forked from the given <remote>s that are merged into their upstream")),
+		OPT_BOOL_F(0, "all-remotes", &all_remotes,
+			N_("with --forked or --prune-merged, act on every configured remote"),
+			PARSE_OPT_NONEG),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -1044,6 +1058,9 @@ int cmd_branch(int argc,
 	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
 			     0);
 
+	if (all_remotes && !forked && !prune_merged)
+		die(_("--all-remotes requires --forked or --prune-merged"));
+
 	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
 	    !show_current && !unset_upstream && !forked && !prune_merged &&
 	    argc == 0)
@@ -1097,10 +1114,10 @@ int cmd_branch(int argc,
 				      quiet, 0, NULL);
 		goto out;
 	} else if (forked) {
-		ret = list_forked_branches(argc, argv);
+		ret = list_forked_branches(argc, argv, all_remotes);
 		goto out;
 	} else if (prune_merged) {
-		ret = prune_merged_branches(argc, argv, force, quiet);
+		ret = prune_merged_branches(argc, argv, all_remotes, force, quiet);
 		goto out;
 	} else if (show_current) {
 		print_current_branch_name();
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 8e877862f5..e93e93654e 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1771,6 +1771,27 @@ test_expect_success '--forked requires at least one <remote>' '
 	test_grep "at least one <remote>" err
 '
 
+test_expect_success '--forked --all-remotes covers every configured remote' '
+	git -C forked branch --forked --all-remotes >actual &&
+	cat >expect <<-\EOF &&
+	local-foreign
+	local-one
+	local-two
+	main
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--forked --all-remotes still validates explicit <remote>' '
+	test_must_fail git -C forked branch --forked nope --all-remotes 2>err &&
+	test_grep "neither a configured remote nor a remote-tracking branch" err
+'
+
+test_expect_success '--all-remotes alone is rejected' '
+	test_must_fail git -C forked branch --all-remotes 2>err &&
+	test_grep "requires --forked or --prune-merged" err
+'
+
 test_expect_success '--prune-merged: setup' '
 	test_create_repo pm-upstream &&
 	test_commit -C pm-upstream base &&
@@ -1908,4 +1929,27 @@ test_expect_success 'branch -d still deletes a pruneMerged=false branch' '
 	test_must_fail git -C pm-optout-d rev-parse --verify refs/heads/one
 '
 
+test_expect_success '--prune-merged --all-remotes covers every configured remote' '
+	test_when_finished "rm -rf pm-allremotes pm-other" &&
+	git clone pm-upstream pm-allremotes &&
+	test_create_repo pm-other &&
+	test_commit -C pm-other other-base &&
+	git -C pm-other checkout -b stable &&
+	test_commit -C pm-other foreign-commit &&
+	git -C pm-other branch foreign HEAD &&
+	git -C pm-other checkout main &&
+
+	git -C pm-allremotes remote add other ../pm-other &&
+	git -C pm-allremotes fetch other &&
+	git -C pm-allremotes branch one one-commit &&
+	git -C pm-allremotes branch --set-upstream-to=origin/next one &&
+	git -C pm-allremotes branch foreign other/foreign &&
+	git -C pm-allremotes branch --set-upstream-to=other/stable foreign &&
+
+	git -C pm-allremotes branch --prune-merged --all-remotes &&
+
+	test_must_fail git -C pm-allremotes rev-parse --verify refs/heads/one &&
+	test_must_fail git -C pm-allremotes rev-parse --verify refs/heads/foreign
+'
+
 test_done
-- 
gitgitgadget

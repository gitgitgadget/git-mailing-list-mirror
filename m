Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7C53AA195
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 11:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784979162; cv=none; b=E9Mah/l769ri7SKHjC2lQVa86M016ltw/OE1MUqwikpT7FlZtrCyKmhFnnJTaitTJrN/RLUlT/YbmHfCo3gQjtQFGiwLzYZjTxHf71+Q0jDE/NYrA6SS/LL8jWtr7tH7MEY5YnAqSf5pZDp0YFkxpn2vQYelpgWuByf00U6wIPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784979162; c=relaxed/simple;
	bh=K/qsjITLBgG+Tp7vKQfzglSB0X+A8WX1XfOFBEbUGW4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=T87BRlR2HD61JwfvDUl1ciyeyhiN0tTtNyGa8eLLdmaUd/4zDmQXgB7Y541M9APAi263aRocRZ5ZDS25BZSNPJAjMHKT6H/tZ9/mbeuJJKcMEUBWi4svx+V3c2qWd3Db32UTaukFHqRRz6YoPZxKBFAsEBYLKCUMRqafwO+J0q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVnh2zUr; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVnh2zUr"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6ab02abdbd7so137434eaf.1
        for <git@vger.kernel.org>; Sat, 25 Jul 2026 04:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784979159; x=1785583959; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=M+uFQilHA+8v/W4//grHxVJ25sWgKIY0/Miu9bmzzps=;
        b=mVnh2zUrqlEAsrszRXKVkTrCNyItBhrYPBfvG7A1xYP9Ys8o5+ysIhI/y5F18Kzf3c
         uOm4QEvA6MpA5E/OUiA8zHm6NXit6Ehpi7QcTFvSd8FG2Qwm1M38+wBXu5KvpExgO45a
         N0q4t7AxGylJ2AmRk7EwVmvUTNFevCeRY6s7dvNHvQS/Ddf3WzsB1gQolIYzSsUhrL66
         PVJqTo9cWg3FuxGq6h0HolzzY6fCKn9y50B/O4Mgo+2OwFCoHnnYOnJw3dG5UmJjvODh
         GDUT0szED1JXL75vCc2ujdczp7n/nRIBxemEnbcIaEWqc5GX/Z2fdV2qRV55mjEddEXO
         geuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784979159; x=1785583959;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M+uFQilHA+8v/W4//grHxVJ25sWgKIY0/Miu9bmzzps=;
        b=kl9DRPpAjAxOsAmH+LElC7gqsE/2WKyTZmtYqPXnPWkskGV6JExJKX9reGfQCJITdk
         AQLaNkvoYFrqGpQaX4xDg49Sw+Wc+2KltxgyT3I3RbusKb3HAc44Zfv5+UHwMAQ0HP6+
         mf4OwEb1BP7FOcX7ELJtRuHXydFAYMeyUtpIPnv+vFgk8mYMCyOXcEr1tN/4aSZxmtcL
         DnOL8zZV3uDK/D8C0pzPWc88HgnQ+iYh/GzS5JkBjUt6MSFWl5ZpLLJMGL87RLzhVhgt
         zyh0+NXgy2W3y6QapbkY0GIkE4ltlxvkPVZYWUlBThUuYtqLNVpyfeNI9W/t2TzesNe1
         3VuA==
X-Gm-Message-State: AOJu0YxAuvzPj/x9/pTFkrFa2d9sEbNhxOWaznQ/zMI4f+R3gG/CkCak
	zpAHAqdD2ENGTci8ozk1cSx/Y4QXl5Zd5NBwDWgumcjZwR+tfuMUiHQY4B4bcGYD
X-Gm-Gg: AR+sD13UAp0JcFn6e4+OC7ik49NS8y2kK8HT14/WVYuJLE5r1pUHQ3qT051w1PrROZm
	FK7QCWpcQKLP03l2VT0aFkk5y2tuy4R5z0LZx8PIELqwk/btCQGhUbLekSRHp8uptWmkT9LFDsG
	TH9d6LETY6dd8+ya3GFCFpmObXDLWPIuDCuu6FR29/7tcw4es1hBYcSbSOehau8bZhhT8L8X6x8
	fZ+XA5GVNnJQfxfFhfwlRx7HUzvBeAUgrTBI100sghfnXWiKG2zdPA9g/SacfUoVAxlWlZqpbhL
	csEl8PqHvoL8TIo7LOL4URrOZ7qcsLp4K1mFzyHfmxn6olRun/hUiSC2ez1RouxIjj9o6MxWfOY
	ubceYfOQtfBlziFi9AcUV1+4xjqqya3fhKbVOqmc/Vwsp3mirfUUg39OMVovLcUOpXltDJqHogd
	y+N9sbGaGy6JPz6lo=
X-Received: by 2002:a05:6820:80e:b0:6aa:e176:bcb5 with SMTP id 006d021491bc7-6aaff9d258fmr1385558eaf.14.1784979159407;
        Sat, 25 Jul 2026 04:32:39 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.94.33])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-457ab7405a9sm6804081fac.18.2026.07.25.04.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 04:32:38 -0700 (PDT)
Message-Id: <7102c931e2adeb5d95f3eaf54f9b3f6d6897d78e.1784979136.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v23.git.git.1784979136.gitgitgadget@gmail.com>
References: <pull.2285.v22.git.git.1784921375.gitgitgadget@gmail.com>
	<pull.2285.v23.git.git.1784979136.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 25 Jul 2026 11:32:16 +0000
Subject: [PATCH v23 7/7] branch: add --dry-run for --delete-merged
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

"git branch --dry-run --delete-merged ..." prints one line per ref that
would be deleted without modifying refs or branch configuration.

--dry-run is only meaningful together with --delete-merged and is
rejected otherwise.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc |  8 +++++++-
 builtin/branch.c              | 21 ++++++++++++++++---
 t/t3200-branch.sh             | 38 ++++++++++++++++++++++++++++++++++-
 3 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 2b206e8689..51dda15114 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -25,7 +25,7 @@ git branch (-m|-M) [<old-branch>] <new-branch>
 git branch (-c|-C) [<old-branch>] <new-branch>
 git branch (-d|-D) [-r] <branch-name>...
 git branch --edit-description [<branch-name>]
-git branch (--delete-merged <branch>)... [<pattern>...]
+git branch [--dry-run] (--delete-merged <branch>)... [<pattern>...]
 
 DESCRIPTION
 -----------
@@ -232,6 +232,12 @@ A branch that a surviving branch depends on through a chain of local
 upstreams is kept, so a branch is never deleted out from under stacked
 work.
 
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
index dc1d74077b..e0e91743ca 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -199,6 +199,7 @@ enum delete_branch_flags {
 	DELETE_BRANCH_QUIET = (1 << 1),
 	DELETE_BRANCH_SKIP_UNMERGED = (1 << 2),
 	DELETE_BRANCH_NO_HEAD_FALLBACK = (1 << 3),
+	DELETE_BRANCH_DRY_RUN = (1 << 4),
 };
 
 static int check_branch_commit(const char *branchname, const char *refname,
@@ -340,13 +341,20 @@ static int delete_branches(int argc, const char **argv, int kinds,
 		free(target);
 	}
 
-	if (refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
+	if (!(flags & DELETE_BRANCH_DRY_RUN) &&
+	    refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
 		ret = 1;
 
 	for_each_string_list_item(item, &refs_to_delete) {
 		char *describe_ref = item->util;
 		char *name = item->string;
-		if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
+		if (flags & DELETE_BRANCH_DRY_RUN) {
+			if (!(flags & DELETE_BRANCH_QUIET))
+				printf(remote_branch
+					? _("Would delete remote-tracking branch %s (was %s).\n")
+					: _("Would delete branch %s (was %s).\n"),
+					name + branch_name_pos, describe_ref);
+		} else if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
 			char *refname = name + branch_name_pos;
 			if (!(flags & DELETE_BRANCH_QUIET))
 				printf(remote_branch
@@ -922,6 +930,7 @@ int cmd_branch(int argc,
 	int delete = 0, rename = 0, copy = 0, list = 0,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
 	struct strvec delete_merged = STRVEC_INIT;
+	int dry_run = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -978,6 +987,8 @@ int cmd_branch(int argc,
 		OPT_CALLBACK_F(0, "delete-merged", &delete_merged, N_("branch"),
 			N_("delete merged branches whose upstream matches <branch> (repeatable)"),
 			PARSE_OPT_NONEG, parse_opt_strvec),
+		OPT_BOOL(0, "dry-run", &dry_run,
+			N_("with --delete-merged, only print which branches would be deleted")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -1040,6 +1051,9 @@ int cmd_branch(int argc,
 	if (noncreate_actions > 1)
 		usage_with_options(builtin_branch_usage, options);
 
+	if (dry_run && !delete_merged.nr)
+		die(_("--dry-run requires --delete-merged"));
+
 	if (recurse_submodules_explicit) {
 		if (!submodule_propagate_branches)
 			die(_("branch with --recurse-submodules can only be used if submodule.propagateBranches is enabled"));
@@ -1080,7 +1094,8 @@ int cmd_branch(int argc,
 		goto out;
 	} else if (delete_merged.nr) {
 		ret = delete_merged_branches(&delete_merged, argv,
-					     quiet ? DELETE_BRANCH_QUIET : 0);
+					     (quiet ? DELETE_BRANCH_QUIET : 0) |
+					     (dry_run ? DELETE_BRANCH_DRY_RUN : 0));
 		goto out;
 	} else if (show_current) {
 		print_current_branch_name();
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 7111306150..eb1c57a5ca 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1938,6 +1938,19 @@ test_expect_success '--delete-merged deletes only selected merged branches' '
 		git checkout -b tracks-other other/main --track &&
 		sha=$(git rev-parse --short merged) &&
 
+		git branch --dry-run --delete-merged origin/next merged >actual 2>&1 &&
+		echo "Would delete branch merged (was $sha)." >expect &&
+		test_cmp expect actual &&
+		git rev-parse --verify refs/heads/merged &&
+
+		check_branches <<-\EOF &&
+		also-merged
+		main
+		merged
+		tracks-other
+		unmerged
+		EOF
+
 		git branch --delete-merged origin/next merged >actual 2>&1 &&
 		echo "Deleted branch merged (was $sha)." >expect &&
 		test_cmp expect actual &&
@@ -1986,9 +1999,12 @@ test_expect_success '--delete-merged keeps the upstream of a surviving branch' '
 		git checkout -b topic feature --track &&
 		git commit --allow-empty -m "topic work" &&
 
-		git branch --delete-merged origin/next 2>err &&
+		git branch --dry-run --delete-merged origin/next >out &&
+		test_grep ! "feature" out &&
 
+		git branch --delete-merged origin/next 2>err &&
 		test_must_be_empty err &&
+
 		check_branches <<-\EOF &&
 		feature
 		main
@@ -2016,6 +2032,21 @@ test_expect_success '--delete-merged keeps the upstream chain of a surviving bra
 		git checkout -b tip mid --track &&
 		git commit --allow-empty -m "tip work" &&
 
+		git branch --dry-run --delete-merged origin/next \
+			--delete-merged lower >actual 2>&1 &&
+		test_must_be_empty actual &&
+
+		git config --local --get-regexp "branch\\.(lower|mid|tip)\\.(merge|remote)" >actual &&
+		cat >expect <<-\EOF &&
+		branch.lower.remote origin
+		branch.lower.merge refs/heads/next
+		branch.mid.remote .
+		branch.mid.merge refs/heads/lower
+		branch.tip.remote .
+		branch.tip.merge refs/heads/mid
+		EOF
+		test_cmp expect actual &&
+
 		git branch --delete-merged origin/next \
 			--delete-merged lower >actual 2>&1 &&
 		test_must_be_empty actual &&
@@ -2112,4 +2143,9 @@ test_expect_success "branch -d still deletes a deleteMerged=false branch" '
 	)
 '
 
+test_expect_success '--dry-run without --delete-merged is rejected' '
+	test_must_fail git -C forked branch --dry-run 2>err &&
+	test_grep "requires --delete-merged" err
+'
+
 test_done
-- 
gitgitgadget

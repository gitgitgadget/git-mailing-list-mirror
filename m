Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0927424D5A
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784889391; cv=none; b=Onh595l9oLS5qfIOwxCvyyGK180uASpcL6WztH8oVvdYdDj3EzprQsM/7TojNQpZ2ULuB+uk4O7n4eSbCppWFumKJWNKhBAq0gzsJBeSM18r5UC9YEUOMC42SlgB/yQdDptDlwDUZUQVvbLFREkMr6UMde4+OuPEwwMkDg4oUsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784889391; c=relaxed/simple;
	bh=z+zFu5AdeCgbWbV3QsifeCc1mLWUwXDwrzklE8432xU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SNiEZW2XM/Du1zaeqNBy7EIbxpPouci8Xp0HxvpnQozKs6/w8sfHdhZ5oOdQJvuGgW4jdz77FO/h5hKMLM8bYVtUtMPlrrp+Yr21Ku7AC+/tsSrOulRa0qgylAxht5Z9TYQg3c7kDbhSDBPkz/IR3jGSz/SVZF8d5bSMo1GiQdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pIZaq89g; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pIZaq89g"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38511175ad3so142441a91.2
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 03:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784889389; x=1785494189; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h7S/BMBQFSEswNt7HAoFkjmxGt7+NFDhxaVybms6rMc=;
        b=pIZaq89gMeOafdGNko3syShdvHOMSTUEfWqNy44qsi6z8J8NXBj9g0MuuD12xdK4P1
         y//HGQYPG63b971phdQNybC/A/Ei6XFeXCttWJq51b07c0V4oI//AylU8dxlUSvw8XJD
         y7E4PJs14R5Y0YHdQhEcla9aYYkubOzBixLUtxNeaszimi+K2AMyum6846Tir2Z72Ggy
         /6E2panb5rsu24lVHsxE2iHesKLALX8G+gUixA7HXEExM12Xm9IvY22vX+jq0YJT+1+D
         tX65o7GSgLLIVG2c7xz1wf6fD5bsC5Mp+PMTJBJhH5xR3WkKNtA25NZ6AdWZwbXQzbWo
         nyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784889389; x=1785494189;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h7S/BMBQFSEswNt7HAoFkjmxGt7+NFDhxaVybms6rMc=;
        b=HY5e6b0ymk7b4UrL5WS/r8enNRyFWubZ9ZQsVFN1YPouTtvDAV7vCfd8NrKZBjBABO
         YZBvRbLelfHvEIHyc/6APIJabys1WaQWjR8d/U3Ikcq1sRD2PDL+HNhXsDvRLVGaFrq3
         YoGy4sfd7zp7dP0/19jsglkB2nVBu524Ds8wz84He0W1BFNV3NOHBI/+G9lLi2gxQRkT
         /le/VwQDPzRVZ2FeWLjF4hXs+ByT20V1ZzmOUc2OcYyXyfrWQHr/0pnooC1pt5SNL/H0
         UW0SDKTWcyCMsXhWTpZZaI5+4inbFsgyk6zmwu/sT9gYUBbDU+kseI7htafI2FZxrAqq
         Sfyg==
X-Gm-Message-State: AOJu0YxvTvz0kg2vgSoWq5wQaLjioWs90+IadNd7Qf87Kg4PFkogyO51
	J2Yp9Fj1r68HmbI9foK/UwJbaw4eNDYlJmBsnw3Gnb5ePEyDkBRjz+2QH4xIBQ==
X-Gm-Gg: AR+sD12+XjWccYnXQIJbpk/4wZzCbQOxhiMHM9Kkq7FZpyYH79Ley31xe9vTNKPKEfL
	f6YL5DlYxNURvh4kZphhoRhXsU3k/AzKM3VTxB899jIopvWhVc8MEZX65iHLFtYD2Ma26kXuWvM
	K11EburnoWkdriRwXEsCzMZ7zVE5n62Aug+10anly4d+k1GkpQ1hgIq/UWUjaq4HU4MdlG0ZeeU
	i/P1kDnhCamhODouoVUV0VWakxtdh9MG1COD7j2E8Eh+rhLBuO5JuVUeqfoWT839A50Vu7sFgBX
	sMhRpxTGguR+iHbsxLMfBepcdr7OWFDJITuOr+FjUNpMFXfpg7OWhwA000EkLH4CZUJBriAxoYQ
	XZA+FfzOxC92cs4tWNyh7uogPh71qUYpeztXiSEp8HBiodcXsKMUkuVw3ucVcXQiDkFa8QIsplT
	y/w7H3NQ==
X-Received: by 2002:a17:90b:1802:b0:38d:c0f9:30be with SMTP id 98e67ed59e1d1-38ec664172cmr6425356a91.38.1784889389011;
        Fri, 24 Jul 2026 03:36:29 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.128.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03c4580csm1267203a91.15.2026.07.24.03.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 03:36:28 -0700 (PDT)
Message-Id: <ac63689d8aad83eda01c06ddf6c7a8c3fd3df7bc.1784889377.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v21.git.git.1784889377.gitgitgadget@gmail.com>
References: <pull.2285.v20.git.git.1784704238.gitgitgadget@gmail.com>
	<pull.2285.v21.git.git.1784889377.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 24 Jul 2026 10:36:16 +0000
Subject: [PATCH v21 6/7] branch: add branch.<name>.deleteMerged opt-out
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

Setting branch.<name>.deleteMerged=false exempts that branch from
"git branch --delete-merged", which is useful for a topic you want
to keep developing after an early round of it has been merged
upstream. Unless --quiet is given, each skip is reported so the
user knows why their topic was kept.

Explicit deletion with "git branch -d" still uses the normal merge
check and ignores this setting.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/branch.adoc |  7 +++++++
 Documentation/git-branch.adoc    |  5 +++--
 builtin/branch.c                 | 14 +++++++++++++
 t/t3200-branch.sh                | 36 ++++++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/branch.adoc b/Documentation/config/branch.adoc
index a4db9fa5c8..d8483acb4f 100644
--- a/Documentation/config/branch.adoc
+++ b/Documentation/config/branch.adoc
@@ -102,3 +102,10 @@ for details).
 	`git branch --edit-description`. Branch description is
 	automatically added to the `format-patch` cover letter or
 	`request-pull` summary.
+
+`branch.<name>.deleteMerged`::
+	If set to `false`, branch _<name>_ is exempt from
+	`git branch --delete-merged`.  Useful for a topic branch you
+	intend to develop further after an initial round has been
+	merged upstream.  Defaults to true.  Explicit deletion via
+	`git branch -d` is unaffected.
diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 2a96cd7253..2b206e8689 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -216,11 +216,12 @@ A branch is not deleted when:
 +
 --
 * its configured upstream ref no longer exists,
-* it is checked out in any worktree, or
+* it is checked out in any worktree,
 * pushing it by name to the remote configured by
   `branch.<name>.remote` would update its upstream, so it cannot be
   distinguished from a branch that just looks "fully merged" right
-  after a pull.
+  after a pull, or
+* `branch.<name>.deleteMerged` is set to `false`.
 --
 +
 A branch whose work has not yet been merged into its upstream is
diff --git a/builtin/branch.c b/builtin/branch.c
index e7677dcefa..b8aa5054cb 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -786,6 +786,7 @@ static int delete_merged_branches(const struct strvec *upstreams,
 	struct ref_array candidates = { 0 };
 	struct strset deletable_branch_names = STRSET_INIT;
 	struct strvec branches_to_delete = STRVEC_INIT;
+	struct strbuf key = STRBUF_INIT;
 	struct hashmap_iter iter;
 	struct strmap_entry *entry;
 	int ret = 0;
@@ -804,6 +805,7 @@ static int delete_merged_branches(const struct strvec *upstreams,
 		const char *branch_name;
 		struct branch *branch;
 		const char *upstream_refname;
+		int opt_out;
 
 		if (!skip_prefix(branch_refname, "refs/heads/", &branch_name))
 			BUG("filter returned non-branch ref '%s'", branch_refname);
@@ -821,6 +823,17 @@ static int delete_merged_branches(const struct strvec *upstreams,
 					FILTER_REFS_BRANCHES, DELETE_BRANCH_SKIP_UNMERGED))
 			continue;
 
+		strbuf_reset(&key);
+		strbuf_addf(&key, "branch.%s.deletemerged", branch_name);
+		if (!repo_config_get_bool(the_repository, key.buf, &opt_out) &&
+		    !opt_out) {
+			if (!(flags & DELETE_BRANCH_QUIET))
+				fprintf(stderr,
+					_("Skipping '%s' (branch.%s.deleteMerged is false)\n"),
+					branch_name, branch_name);
+			continue;
+		}
+
 		strset_add(&deletable_branch_names, branch_name);
 	}
 
@@ -836,6 +849,7 @@ static int delete_merged_branches(const struct strvec *upstreams,
 				      DELETE_BRANCH_NO_HEAD_FALLBACK |
 				      flags);
 
+	strbuf_release(&key);
 	strvec_clear(&branches_to_delete);
 	strset_clear(&deletable_branch_names);
 	ref_array_clear(&candidates);
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 268203089b..7111306150 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -2076,4 +2076,40 @@ test_expect_success '--delete-merged requires a value' '
 	test_must_fail git -C forked branch --delete-merged 2>err &&
 	test_grep "requires a value" err
 '
+
+test_expect_success '--delete-merged honours branch.<name>.deleteMerged=false' '
+	setup_repo_for_delete_merged &&
+	create_merged_branch deleted &&
+	create_merged_branch kept &&
+	(
+		cd repo &&
+		git config branch.kept.deleteMerged false &&
+		git checkout --detach &&
+
+		git branch --delete-merged origin/next 2>err &&
+
+		test_grep "Skipping .kept." err &&
+		check_branches <<-\EOF
+		kept
+		main
+		EOF
+	)
+'
+
+test_expect_success "branch -d still deletes a deleteMerged=false branch" '
+	setup_repo_for_delete_merged &&
+	create_merged_branch kept &&
+	(
+		cd repo &&
+		git config branch.kept.deleteMerged false &&
+		git checkout --detach &&
+
+		git branch -d kept &&
+
+		check_branches <<-\EOF
+		main
+		EOF
+	)
+'
+
 test_done
-- 
gitgitgadget


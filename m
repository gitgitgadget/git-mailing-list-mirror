Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64CB277C9E
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 21:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338120; cv=none; b=hmzSVCUc8qYRDNxuMZZuEhSpoBenzBkOSgQjr7PM3pVSDCHCuZLHH/o42mgwK5m7ag+bACPxgn+D3eU1oZqv716Yduux/93f6n/PKutlUv/EYWn3392i6syJp7NkwAWwlEgFpl3LcSSH42mrSDSev46Lc0Uu9b50ASp9T3EQTuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338120; c=relaxed/simple;
	bh=VtqoNLehDZzjotPeVlAIzCcEGuFNy+bxynpRVam1GA0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Q82u9bDeGwXP9Pg8dKF1uUtnjAA8hPjA2nEMz1DNkZrxCeKhcZXovf+kzzUidi6cn637mcM1Myjqgdy2RMpfbpxiBZ7m0J4NXZVrcwopW3jye8PTVqO11Y4sS7ziR6iwA0MgeaHWqAiroQuZf8iVrO1pxaM00/iMpqsd5i03eGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZMDT6oE; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZMDT6oE"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-30c713f37c2so288346eec.0
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 14:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782338118; x=1782942918; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmVcV/3ibM4/UOIR4/ODNAVK0NEAMXVqxQtrmbQrEMs=;
        b=JZMDT6oEtrKo+a9kq5EP8VCleI2MUHV6A+vW/6RfV9d8kp/Kbr81qLhNEGCqfTwdbN
         wDriJDO1N+9iGIIvlKKCi94jvJf9mLdMT1G65xljRNLXNDEVXczsukrVVRTUq38q6gO5
         txpuuddljhS+jjD9wgMsEoMcRcwJZ2dys9ekIxFWIMAVqoyY98fwqMYOI+Ve06vFnU3T
         xKjkqzv8WuD+4O0QOuTqd4b42xDpMbESodBpB+BhBQd+tG4TXpqnFtAAJd3ZO0rR31vF
         PmiW1zP1SscuL2sdX+G/Ju+K2Z0Jh0b+s7U0sN45ioXDlbId5fq1LdJGRj3CrBh3RYFB
         hkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782338118; x=1782942918;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZmVcV/3ibM4/UOIR4/ODNAVK0NEAMXVqxQtrmbQrEMs=;
        b=I+fHtkMvgvzC7teKhtEinGOJpsze5AXqmCil1c6UNnAUFzi8IOyTPKNGt4y3Pvnaba
         BUwuyMSuQmFyiv1Gmm/hxmS3Slqz91HutK5j30OqSNFY6Ciy5Pw5C1U1gMfY7gs0oLxL
         PmW+dG1Fxk7BVMquSZNc94iEgosSYRqN6T5cPpqjKULtmT4TjgkQdqO0R9oPUWDLYBzC
         Y6IcRXqXoBwaWvE9eBGPxCO/pXwAYuVrjzbU0sYebuvlIXFhAt+Ma7XA4zVbeGFxqjZ2
         cmcSVNRNvIhv5m4Tb9/vGDhJnDsAcoIFINbYlP6+OZf0Jp0t65O0g+KYHMsj4gO1ZRp1
         J1Rg==
X-Gm-Message-State: AOJu0YwYBfF3J8QBCzneU55tmigKHFWL0rCOXMTRLZKI3yDB1+ioWzrb
	wbKxTZSX6543sLEUO9RxD0/sWfcjWBrCy6bcrMfKsJ6pIUK10XCTJe5WA6LrZQLK
X-Gm-Gg: AfdE7ckYW0K4hV/Bp0QmIqQkWP1JpBxaaG8rpuiY0SlSpdx//exlJ75DxH2/NyJcIR5
	ixh1JwgGOMPdClzOPQNKlgZbGTzmT1XNEdFhSVgzXpTLdfSDarfNHj1IPU1/XcOBx5LaKv4KuG4
	gRhF2k3//Y9vinpXncM9UCWTFcjR5RpRhoO+KcODaAz+Sov5ZznuWjB9hdXyi3OM3VByW/JBOy9
	NcAtC3V0yNEiCq9av8XEn/68tJyYVLu6B1agpyCgXn78dzVFGo6U62NUpdahIFzUNgvb4JCy5rw
	kKPHeFTXw3Z74MVwtNg4KS2uvgxiwAzGUQ404jORMyghEIF33yKCSWV+4byFK0945H3X3SALzhi
	Ez4PS7iGGU8NpYEz4NVl8IAoLpX6v6fgxREjthAM/tkQF+BI4SI1/TSMGkNr8NxUnPNVreeyb3o
	tepEBJE07kD8QigNlc
X-Received: by 2002:a05:693c:2d88:b0:30b:c0b4:db42 with SMTP id 5a478bee46e88-30c78e0ea04mr1627734eec.11.1782338118030;
        Wed, 24 Jun 2026 14:55:18 -0700 (PDT)
Received: from [127.0.0.1] ([52.160.149.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c9e220bsm1775532eec.21.2026.06.24.14.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:55:17 -0700 (PDT)
Message-Id: <d52d717b70c80b668e6d3a1fdf186ab4846664c7.1782338106.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
References: <pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
	<pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jun 2026 21:55:05 +0000
Subject: [PATCH v18 6/7] branch: add branch.<name>.deleteMerged opt-out
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
 builtin/branch.c                 | 15 +++++++++++++++
 t/t3200-branch.sh                | 26 ++++++++++++++++++++++++++
 4 files changed, 51 insertions(+), 2 deletions(-)

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
index 66b1c87c55..d482cded3d 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -215,10 +215,11 @@ A branch is not deleted when:
 +
 --
 * its upstream remote-tracking branch no longer exists,
-* it is checked out in any worktree, or
+* it is checked out in any worktree,
 * its push destination (`<branch>@{push}`) equals its upstream
   (`<branch>@{upstream}`), so it cannot be distinguished from a
-  branch that just looks "fully merged" right after a pull.
+  branch that just looks "fully merged" right after a pull, or
+* `branch.<name>.deleteMerged` is set to `false`.
 --
 +
 A branch whose work has not yet been merged into its upstream is
diff --git a/builtin/branch.c b/builtin/branch.c
index d12a2f57ea..bce85cb52e 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -781,8 +781,10 @@ static int delete_merged_branches(int argc, const char **argv,
 	struct ref_array candidates = { 0 };
 	struct strset deletable = STRSET_INIT;
 	struct strvec to_delete = STRVEC_INIT;
+	struct strbuf key = STRBUF_INIT;
 	struct hashmap_iter iter;
 	struct strmap_entry *entry;
+	bool quiet = flags & DELETE_BRANCH_QUIET;
 	int i, ret = 0;
 
 	if (!argc)
@@ -800,6 +802,7 @@ static int delete_merged_branches(int argc, const char **argv,
 		const char *short_name;
 		struct branch *branch;
 		const char *upstream, *push;
+		int opt_out;
 
 		if (!skip_prefix(full_name, "refs/heads/", &short_name))
 			BUG("filter returned non-branch ref '%s'", full_name);
@@ -818,6 +821,17 @@ static int delete_merged_branches(int argc, const char **argv,
 					FILTER_REFS_BRANCHES, DELETE_BRANCH_SKIP_UNMERGED))
 			continue;
 
+		strbuf_reset(&key);
+		strbuf_addf(&key, "branch.%s.deletemerged", short_name);
+		if (!repo_config_get_bool(the_repository, key.buf, &opt_out) &&
+		    !opt_out) {
+			if (!quiet)
+				fprintf(stderr,
+					_("Skipping '%s' (branch.%s.deleteMerged is false)\n"),
+					short_name, short_name);
+			continue;
+		}
+
 		strset_add(&deletable, short_name);
 	}
 
@@ -833,6 +847,7 @@ static int delete_merged_branches(int argc, const char **argv,
 				      DELETE_BRANCH_NO_HEAD_FALLBACK |
 				      flags);
 
+	strbuf_release(&key);
 	strvec_clear(&to_delete);
 	strset_clear(&deletable);
 	ref_array_clear(&candidates);
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 047ba54778..b7595610d9 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -2024,4 +2024,30 @@ test_expect_success '--delete-merged clears the upstream of a kept base whose ow
 	test_cmp expect actual
 '
 
+test_expect_success '--delete-merged honours branch.<name>.deleteMerged=false' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo_for_delete_merged &&
+	merged_branch deleted origin/next &&
+	merged_branch kept origin/next &&
+	git -C repo config branch.kept.deleteMerged false &&
+	git -C repo checkout --detach &&
+
+	git -C repo branch --delete-merged origin/next 2>err &&
+
+	test_grep "Skipping .kept." err &&
+	test_must_fail git -C repo rev-parse --verify refs/heads/deleted &&
+	git -C repo rev-parse --verify refs/heads/kept
+'
+
+test_expect_success "branch -d still deletes a deleteMerged=false branch" '
+	test_when_finished "rm -rf repo" &&
+	setup_repo_for_delete_merged &&
+	merged_branch kept origin/next &&
+	git -C repo config branch.kept.deleteMerged false &&
+	git -C repo checkout --detach &&
+
+	git -C repo branch -d kept &&
+	test_must_fail git -C repo rev-parse --verify refs/heads/kept
+'
+
 test_done
-- 
gitgitgadget


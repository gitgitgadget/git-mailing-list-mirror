Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C263542DA51
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 18:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784053509; cv=none; b=sKUdDgZBSjmIJLZf/PT6PqUfkPuISNNsbILbgNpQOAKXHL3AsODkfrqeaCJ8U6a0UC1aH0Osvdv5aW5w/eY2E3cano4tad538/C4bR9octuMnc1VAqi4vp7fkjkyjQJL0I4sbaosmFecZ1xyms8U5mEfD14cF2QeEYJEObNzwHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784053509; c=relaxed/simple;
	bh=SX1+EL9A1nDLjDauw0/V0uWHhrxw2BpVm+HtCsMoNQ8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pS+GRq42XLCY0bEQ7WtWJ41mK0Xo8ATqSInTAxEyWaKjUWrXoZavkiVjhsZ7Duuf3m4hy7KOLGB1vxN+hoI0HyOB0w49/3gaAR8q1nma2bZaLg9+OHjFaG/JVKx9l2QwrXZSevdmNI1TBEQ/I3w2KyXg+Z6B1WctIYB/CC2RBP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b52sYofF; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b52sYofF"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38dcbade417so3033866a91.1
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 11:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784053505; x=1784658305; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b86Cq70aoiBV2Jkl4Kpefs+E+54BMfD1Enjnx4jLp7A=;
        b=b52sYofFdDwBqZIARQFTGCL3DzrqqvMuEFQo4SY2GaL+Wd4Ww1MIFwYtSqkuCB2Bu3
         qogKu62OjVNUUcmGMsJOrSMVad4++4mKeQuaDnr5LikdBLS+EL+NGmRx53uLfxLnvOVy
         HkmY34x1IevBo0+H2PqAg0g5qu5UOOQNcxEgxyzN0buY4NI1WVHxY2lr6ru8Ay5tuLO8
         b+aOUVUJLb//qb4rh1/RB3PLoL6P6kGFXX5hdpBZMr7pT+r/WU9YUMo0QlQtKX10b6gd
         pjz0U01WrQcRY282+zBKXbCAQBwIoSMByU3U4fMOmJLG0nNATkBCMDqMpsbiGjbHuUoc
         WXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784053505; x=1784658305;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b86Cq70aoiBV2Jkl4Kpefs+E+54BMfD1Enjnx4jLp7A=;
        b=L1akYT3i0uAOMielumJfSL94d+indyPDitTjhMnzH5d+/lgvRjV53cimyyHWha9kuq
         EAi/+D42w7FwPtbgvG2rnGLcUtkxdVxlP7N09Cyv1C8YyRqu4X/c/fqFi1nv6dGW/MXB
         cBG0Vjl3pnGDj7fukZw3bODHAeh/V5mDTJNoKoSI5kG8ykYbhQqL1TmChQwCJ1c0jtGe
         WmBWrCU0jNKGjfXlvKMnj2VSOMX+pFl3ujjnb+WH+qBG0KiUaxVjAXJVe/Sh3y5Ohc+Y
         S5Y++T+CdoTpwBT1KHXjnbjbXnemXHEk+VVdYmEq9lq1MSdfZ0Sz4QvE1o1iUfQw+2Ap
         8PJg==
X-Gm-Message-State: AOJu0YxEQlfr8iz6baH6patzCbE9MddW0pVmdFYJtWwZnWolLN0zjQ4I
	XE/sD4VrLdhntA29AU5ZG9GmtYodq5Wc+JEgA1Q56GZU9R4K091O0B41N4WGvA==
X-Gm-Gg: AfdE7clvQGPOBJULSe8UbBXVd2ngMyDKMGMGAbunDgoHjAkKw5cJKgREaX6O5WDklRh
	UcW0RgIketS50MIqE+s15tUOKliR4VYxPCcekuu5/rH2j3WdgDodtiwyOGRC8V2x/z3qdIyyVeH
	8KQdpBQlQd0oXGCPU4XFFN5BdolP1XFGE3f8nsVytvjMGOcL5TG7r91sVRc6sGho0MuhxbNGzUN
	LT90jjPS90Yn2ynErhfZDxrihagovXKWQM/pPG2csSTLVOXwoufIceedjCfj52bhCSSmxqiyZ5i
	g6gkJiJsPhUg/8dbz6Mr+Rr3HiWSxScY9QBrykup+uGBZrFNFSQCgEh3LIya8FPYt3/gmyXf8u5
	bdeFDXs2996PnzY3OcjIohOZYUlBIJIJYVE7PY2sLLN0HQVQtXtR8CMy36AYIXPq+TLMVpS3gpT
	6Zx4ashI5K6qC2ursU
X-Received: by 2002:a05:6a21:a46:b0:3bf:49c8:f8a with SMTP id adf61e73a8af0-3c34d7199a7mr5422094637.36.1784053505244;
        Tue, 14 Jul 2026 11:25:05 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.211.71])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b4cbafa1sm79877497eec.6.2026.07.14.11.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:25:04 -0700 (PDT)
Message-Id: <734d27c908d24fe23e3475c820333415af5caf1e.1784053493.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v19.git.git.1784053493.gitgitgadget@gmail.com>
References: <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
	<pull.2285.v19.git.git.1784053493.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Jul 2026 18:24:52 +0000
Subject: [PATCH v19 6/7] branch: add branch.<name>.deleteMerged opt-out
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
index cee3904cfd..ffb39811ab 100644
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
index 8ce8840fa7..61f414b3c7 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -791,6 +791,7 @@ static int delete_merged_branches(const struct strvec *upstreams,
 	struct ref_array candidates = { 0 };
 	struct strset deletable = STRSET_INIT;
 	struct strvec to_delete = STRVEC_INIT;
+	struct strbuf key = STRBUF_INIT;
 	struct hashmap_iter iter;
 	struct strmap_entry *entry;
 	size_t i;
@@ -810,6 +811,7 @@ static int delete_merged_branches(const struct strvec *upstreams,
 		const char *short_name;
 		struct branch *branch;
 		const char *upstream;
+		int opt_out;
 
 		if (!skip_prefix(full_name, "refs/heads/", &short_name))
 			BUG("filter returned non-branch ref '%s'", full_name);
@@ -827,6 +829,17 @@ static int delete_merged_branches(const struct strvec *upstreams,
 					FILTER_REFS_BRANCHES, DELETE_BRANCH_SKIP_UNMERGED))
 			continue;
 
+		strbuf_reset(&key);
+		strbuf_addf(&key, "branch.%s.deletemerged", short_name);
+		if (!repo_config_get_bool(the_repository, key.buf, &opt_out) &&
+		    !opt_out) {
+			if (!(flags & DELETE_BRANCH_QUIET))
+				fprintf(stderr,
+					_("Skipping '%s' (branch.%s.deleteMerged is false)\n"),
+					short_name, short_name);
+			continue;
+		}
+
 		strset_add(&deletable, short_name);
 	}
 
@@ -842,6 +855,7 @@ static int delete_merged_branches(const struct strvec *upstreams,
 				      DELETE_BRANCH_NO_HEAD_FALLBACK |
 				      flags);
 
+	strbuf_release(&key);
 	strvec_clear(&to_delete);
 	strset_clear(&deletable);
 	ref_array_clear(&candidates);
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index fa8a60c9e7..54292bfbdf 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -2000,4 +2000,40 @@ test_expect_success '--delete-merged requires a value' '
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


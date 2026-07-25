Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6C93BA249
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 11:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784979159; cv=none; b=uDm0NjNROczaOApVY2YaXI6lSRBcTZ/hOMXXZfQvXL6RuqPMbP5xuBupZ1uW4RS3wP03MOdkW7KnEuOVPET2lGfgw2IQx70Iuc59t2zlcM4+8g7KUD7H9EV2sJojVOTigjwih8CTIZ7B98XuIt8LU5WFU5/d/Pn0IDLo7WpVUEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784979159; c=relaxed/simple;
	bh=4q9pjboy9jScK1my5XhpDzX11J1+OHSVlBdf24ZSzDs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XiGxn9jX7SOdxvasP5ycMrKXVeSY0tp267yqlkIFJc7pkwarSRmBN0UxNySsoELFkq+NXG/Eo/P+/Jw3os9towINULRJYl+MSGAxYEyURGN6yY5P/3/DLJyst/JEan4QbqptRRJ6HEiXGNV07JTcWZPeJtuQoifu5xR60yZOqc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuA84VPG; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuA84VPG"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6aade397f0eso360058eaf.2
        for <git@vger.kernel.org>; Sat, 25 Jul 2026 04:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784979157; x=1785583957; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NND2ZAWSGBlGRys7jRUsdKZimRZ4EvPaiV+gin1wtns=;
        b=UuA84VPG15c+sR8rDbxrb5pWS/fGAp5M60BJNsqjVmlMZuGyl2K6sa7wgewmbCQC4H
         JnRQSAuAseEK2MBbX7h+gfY2lq2ocfKRMgo859Jn3pnMc6m6XcHqaM+DDfHn1lKzGlhl
         fa3381hKGHiOeA51KcO1r30fGy3+QsX/vkog4YS7+aE5CoiR2ummx2d3UJvuZsdry0PY
         2O2gfA2bl8+F04hdY4bIcZNgb9kp6vaFwlYZ6EXRJkT+VCs8E0FhavtGQaWLety1oCPA
         8or6wx2lJZbVGwqjAMIJKhPCDNW6IEfJTVlqYa3LmKWDgjB2R6ovBTLeMdkEzrYifQzK
         PL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784979157; x=1785583957;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NND2ZAWSGBlGRys7jRUsdKZimRZ4EvPaiV+gin1wtns=;
        b=flb5m35szWtGGRL9S96uXm2FDWlPrgRbkFZYGZ3wpO9HgUed4Gl4s7S2okYtPDMPGZ
         K4Ibzys0gOBtd6zfv3PRx/CpvSbB+XgmbC2Yy55G4i+h/Y739YHCUqwa72uisTi6mF2B
         v1uWU5RP1odnDDuqxxsAhPeHB8/rdav8BRKdWRvPEUk4ZAAu10WqGNel+c50VMVCa/bt
         H4uxbwGXkmx7ZMxa30W5Yr4no5+DMoG4BC/KgtYec7xmMDcj9j4MowzSR+cKNwQoH5Jj
         dBsgk4VorUiMfukJIfXsbqxU+g0Gogfczh0jdPSwf25m2uvFh9rTixuoc4huJm4am5mM
         sUHA==
X-Gm-Message-State: AOJu0YyNWQWrOli68jfCqFrpaUthtqTC8Kt0p+cSRwWkDe2PelRF8bER
	BUrf92yl3caKXV/jm0aG3XMbmWbzjwZSG0wSWrJvb71m9jQAWQ9WhDe4ReTAPcL2
X-Gm-Gg: AR+sD13cjMhByhWZLzHyaRXEJelUWSkUYvKJLButcSFDYoQbfo6gkzPZgxbk/L0LbJ6
	ypLRF0+qPAOLeFNN8l1VqI+G9TFTt+xUUmdF6dWu6mZ0b+hF2ch0ysKpinwVbK1fnJhz28gnUVY
	IK8uCS/SYHEqDsDb+z0G8v26R4oowR2njUIZcaNalOD/XT0YxSTFbBAenkixwthfGLykXI/rWsh
	2fefktEU60tkWycqs0WIiZtNBHUQPkp3uE8Ncy7I193tszzb19yU+US5aiM0Slofc3DbupogjET
	BQTuwX/D/32t+0AhMgJU5fjoUw1VUqeljS7RXWLPpEiV08Vs8o4rTPQDpoCep+6HzkPRT24ittE
	T5yeFUFtbbdUslpgQVx04yo4HX/Kfkrx26HVMzzzJhlwmiUa/axNpERKOdUsWqGikwGpenHx8dr
	sklI17
X-Received: by 2002:a05:6820:4dec:b0:6a1:3dd5:adf5 with SMTP id 006d021491bc7-6aaff7e09d0mr1462882eaf.3.1784979157246;
        Sat, 25 Jul 2026 04:32:37 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.94.33])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6aaf96c130esm1589814eaf.10.2026.07.25.04.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 04:32:35 -0700 (PDT)
Message-Id: <6494be7c75d1298912d2149f149a72bbbad97cf4.1784979136.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v23.git.git.1784979136.gitgitgadget@gmail.com>
References: <pull.2285.v22.git.git.1784921375.gitgitgadget@gmail.com>
	<pull.2285.v23.git.git.1784979136.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 25 Jul 2026 11:32:15 +0000
Subject: [PATCH v23 6/7] branch: add branch.<name>.deleteMerged opt-out
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
index 78b694034f..dc1d74077b 100644
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


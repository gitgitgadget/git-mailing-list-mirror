Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7364243D4EC
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 13:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419927; cv=none; b=DTsgM0kHpKHPnzCZ8fFn4VHzFaWYP85NqbqVYraXM2lODMS+6C+hjd2TC+gUMzxQgusRJX9RKSOT11O66ORpYF5gvxNl7RaHbXpSVyffonDuDCwjh9U6kUWf4IiOo8HC7438hzaK02CDoQsT9tQGLf1W6DOhcg3Dq4wIBBrGXAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419927; c=relaxed/simple;
	bh=B5e1ASTsAflEu8wWCxpz1D6NeQ21+RYtYSfroUpu7dE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=U30Aco6adOf4p/Ge/VWSe1/EwCXV8ite4rL4kh5JpMJxYuy931bV/yenCZIVwftLNLH+GOHKcUeVbWCSCAfzbkxhOWHyT3UBDZbvULdtibBKvP9kfZLBkCmTopAjSx65qk1Vk92VUie1/iuVno1J28bWS/ftuIoK62Kdv1dZWVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RG+3jCY5; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RG+3jCY5"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8485b358552so2491932b3a.2
        for <git@vger.kernel.org>; Thu, 30 Jul 2026 06:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785419926; x=1786024726; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Xl1GUuZQCnUIcZe+crmBjUUgEdlZuwXClPMHkRFgLRg=;
        b=RG+3jCY57mZso7Ag1/saZ1WO7FbZpakv1Wc+LRS50oB8m7XwEM0ZLRlcTR49iwxBnE
         X1+zo5gddDo6wA2cE+AvQJ3XDQFH/PvI7XzqVEmwQPVjIEDWRKsVExd5EXYilSUZnSz3
         UfKQeiFXAugtS9AmtGaTJGkQS7YmqVmrGQFrV7XwVMaQgJ25Q7yP6MBxr4oyzf9ZaXpY
         nDVJN3ymsj/oBcx++fqSrohHe8rLM6Hl2EyTXbc7QE0iGDaot48FUHxxkh8Er8BU1Kei
         oNi34mZpQDuRe+snQYCHyT9Om2du2CyHdH24tq+Q+/bP0V7MK1OvEYXWG15dfPSMVW9C
         q7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785419926; x=1786024726;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xl1GUuZQCnUIcZe+crmBjUUgEdlZuwXClPMHkRFgLRg=;
        b=hLWc44SQ6r8MvbOpR4Qx55EonH3fpM8HDRO/OjnmryX6DGwS7Q1a5nKb+7M3ERVXAp
         88zal/3sfa4f3I50UF21jjMD0GEDwRTxbvoNGvJAFYWRLPG5Hc/yV57RwbdmrRTsjB47
         1sTUoMelM6TIioeYFdDdVG2PTGrWJ4HpzddFXdkRi+1lVsYJeHYCqEUgCOkC9f4DOY29
         6b9Rb41v/d7DcPFzIjwXAy9dQTUjuhLQBHXspqAx+ti3zNK06nW6YtCN2FeMDuYDykQC
         SbVulz0Axt4i1AaMI7acyXJJbfFJNINzEgRNY25sByp/jnNy6gsCZ4eyA3c938daW0Mi
         m/Hw==
X-Gm-Message-State: AOJu0YyL3QWXx2faxuDX0S2KXtcxpfrgVYiGIaLloYnQDE0u3eHMNITa
	qrsdQhcKkN86Ki1hOMTlQb9LmL8JPx8l6edqkk1rfVvXGETabh7sqIbN2YjyCvo0
X-Gm-Gg: AR+sD11joNIaaei2jTkixq2UGAnYC+i7bRCm6wACf9FGV04+WzS9lzyWJql16GQOkMj
	ASaUohZF8zf+mVy9QcG1vpXDzyWJKVdj2CL5VtIF1JLa19h4Fn5kA41UOmzn0bnrcYFOKrneYsv
	pgvzPS5Ld8E8kdBaRsiUps9fsruB1gjnA0klhHMhC9NRk6RA/EYR0g78NVRyFE2Jp3alCIxv1Dw
	O6XOWq5ZIVs5UvfcBi7ytG7RHzYFwNA7Bj/uMO+oFzjm7/PHQNGcntVh7U0dJSXXgQrkutMnz1w
	DeJ15Iodz1KPIJV88G3+3tUNct8E9l998HcbVkI43NQv+461GYZDm2ntgaTo9GLo8Rgb0f9Tkxq
	eXnS4utl5HH/LQPqdyYTVSt9XYxJl/T4LznKsYDJ7ppgWp5OWux/sqKcoyUQTsIUvLSHPV6iRnR
	ZCP0t1d5lGHJGdnkL6BX14oB92zqOmofofG1ZJQIGnzI8shxyShSsaYWCqZ05DzDF0/Bf9DwhIb
	JCb
X-Received: by 2002:a05:6a00:c82:b0:845:3fea:96c with SMTP id d2e1a72fcca58-84ebc22e874mr2527076b3a.21.1785419925654;
        Thu, 30 Jul 2026 06:58:45 -0700 (PDT)
Received: from [127.0.0.1] ([20.120.230.195])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea00514d8sm3240404b3a.13.2026.07.30.06.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 06:58:44 -0700 (PDT)
Message-Id: <aa845096d853b5613059433429dbcf4a44804047.1785419916.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v24.git.git.1785419916.gitgitgadget@gmail.com>
References: <pull.2285.v23.git.git.1784979136.gitgitgadget@gmail.com>
	<pull.2285.v24.git.git.1785419916.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 30 Jul 2026 13:58:35 +0000
Subject: [PATCH v24 6/7] branch: add branch.<name>.deleteMerged opt-out
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
 Documentation/git-branch.adoc    |  3 ++-
 builtin/branch.c                 | 14 +++++++++++++
 t/t3200-branch.sh                | 36 ++++++++++++++++++++++++++++++++
 4 files changed, 59 insertions(+), 1 deletion(-)

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
index 4766178204..cfaac4b90f 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -224,7 +224,8 @@ A branch is not deleted when:
   distinguished from a branch that just looks fully merged right
   after a pull; this is determined by the remote's configured push and
   fetch refspecs,
-* it is the local upstream of a branch that is not being deleted.
+* it is the local upstream of a branch that is not being deleted, or
+* `branch.<name>.deleteMerged` is set to `false`.
 --
 +
 When such a local upstream branch has its own upstream deleted by the
diff --git a/builtin/branch.c b/builtin/branch.c
index f1a73bcea1..2d0c4f51ea 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -818,6 +818,7 @@ static int delete_merged_branches(const struct strvec *upstreams,
 	struct strset deletable_branch_names = STRSET_INIT;
 	struct strset protected_branch_names = STRSET_INIT;
 	struct strvec branches_to_delete = STRVEC_INIT;
+	struct strbuf key = STRBUF_INIT;
 	struct hashmap_iter iter;
 	struct strmap_entry *entry;
 	int ret = 0;
@@ -836,6 +837,7 @@ static int delete_merged_branches(const struct strvec *upstreams,
 		const char *branch_name;
 		struct branch *branch;
 		const char *upstream_refname;
+		int opt_out;
 
 		if (!skip_prefix(branch_refname, "refs/heads/", &branch_name))
 			BUG("filter returned non-branch ref '%s'", branch_refname);
@@ -853,6 +855,17 @@ static int delete_merged_branches(const struct strvec *upstreams,
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
 
@@ -873,6 +886,7 @@ static int delete_merged_branches(const struct strvec *upstreams,
 		clear_deleted_upstreams(&protected_branch_names,
 					&deletable_branch_names);
 
+	strbuf_release(&key);
 	strvec_clear(&branches_to_delete);
 	strset_clear(&protected_branch_names);
 	strset_clear(&deletable_branch_names);
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 322c5a20cc..50fd1d348c 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -2084,4 +2084,40 @@ test_expect_success '--delete-merged requires a value' '
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


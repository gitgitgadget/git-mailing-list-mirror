Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421FB36165A
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 21:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775854880; cv=none; b=QXLjMyvlD105SLRC2g1fjb0+i1+j5UcuDoq/XRT0XNtmnOfG31OX+y9AvmDY4oWhW1tuDqxlzAyhbUX1nrhfNXk5fMms/iWF03eigCzzO4AjIHzJ76QOSSV5iSqGAv5igjh+5FF/47P/+sHf8YJCm+yhRySccscEBLZVnjwuSyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775854880; c=relaxed/simple;
	bh=BhbBMlHe2weVPQhjLVck9zpJsbjGkl2KYvB1ip6Kxb0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BtKzp45cHdcqoaf7EmUu8h0LO/BzNSxIg6t9Yj4Smie+ZlJSYuYieOwoGXM/ueF9var8g2nwItwmPERHNdBWSsLs/Mq6GCFVTE1rwsngQlhtZdwukHOMBpy/STcbpkYW9/qDhuhCeGX8wNzmB5mk5xs0uHSv/oRm5QH4NSKDA/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkk7JCKQ; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkk7JCKQ"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8a3b0242631so28878146d6.3
        for <git@vger.kernel.org>; Fri, 10 Apr 2026 14:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775854878; x=1776459678; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ij+z/COhdj/tGRH/945uWYZ7SWfYyfPgzOr9ewVDN6Q=;
        b=fkk7JCKQ/UgeYo20Gq1eehLw5SzupbD/NvUcPly1PKKwv6vcofwUfIapEIf96fdtAE
         Ya0yFgT4Qo1fS9yYkDq0gX3Fm2A1/DoeJlDs8jpfDDjdTmOhnZbTlTLbBFdh9k2kj5bM
         lYTETX6ukTjeCRu/yNnxL6TmT9klG6SZibujze7oIuP5qsw5Au1yf9GBXZeqKBPLdULV
         3OpwuyqeIoxhsUiw4jbkthcXN8zc8c4v6GJhpA7zErecGLNP8378LOqyre1zTyUbvEJB
         20rnUCTW716/dOCZx1OVY/FnlM1sWgtW71n2JKaZ4N5sVVXIRJvlpYMQVPAOcoDdBxBA
         wNpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775854878; x=1776459678;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ij+z/COhdj/tGRH/945uWYZ7SWfYyfPgzOr9ewVDN6Q=;
        b=jArmNoRNpaF+JDhCL67fGToUqwRGr46rVPOWhhAg15xELPxxt0+uZgnNt3bNos2I9z
         7pyCk4emrLzcWmDpiutQ2zi4z3WIV5km42yYBsStuvt0T43hTK0s9LfPWXjsiwAvLOoo
         RUq6yUVdhocSCVgRnIUpBquSVUxxFcobPtAO7eCFOWo0Ni1pFzspIPJr5x2XP9E8iwe4
         My1tpBq5i07aYEtugjt8SvGKFDUOQXkYDlSs4YAgF3/D3VCz0ZO+mx8uhk9liFCyzgsB
         0rkYov/J0L9TpOSYSkxBzJlso1MJclMerHejzj2k3Z+YxT2PW3vyxIv0Qy1AIav2kxXn
         1PDA==
X-Gm-Message-State: AOJu0YzqASNo0bGv13TeIeO+o/3hBDn94tOG/GTMozyGX+F4AEzPKDdB
	FvhNbl7v5bdVbQzIBM523d5rk3+LfzmJs+RUx6oM4u4XgPHX7dODhjeUsM54sA==
X-Gm-Gg: AeBDiesZzYYwMqUFoeBTJXorBT/aRJUlWt8NwE2KMFW+0BSM4sbUXPWMF6luNQWpHyJ
	m87mDPNXm8Xc0vTOag4WghLd8FdR6yom52ebum/WW/IkorURRCriVdEvpiGLPOm84eB/XGogQaW
	pJkP/X7SNzOkUgJvTVPiwSkMgL0+LKyOSoy+tYqIuxPyQGmu33K4OziD6COl6qtDHwVLtie8Knx
	mJ7+9oAFLXivTNMawuQ048CAbTo4BO/Hk6AwchuVjizgcteOoTJTTEFb1XRHmWaAMp+RnxWsiv1
	UbdeOv/XSmRcxn9Wtr5093Xky8864vIv9uvfGUh53tHuBHbX1FDJx5shFy18uF6Ljjyb7SR7WUv
	tKA3NQolCyPqA4hEgxvK5YbbaAs/2QOuxc1P3c8RoUjScRl0VEbjxIkxO8jhmf1KSEcXjy2/mRR
	zNig1gRHBWBeydtaU6SCEKMo7ksuNJ8HxXAAed
X-Received: by 2002:a05:6214:ac6:b0:899:ea9e:31d0 with SMTP id 6a1803df08f44-8ac862feddemr75599566d6.53.1775854877182;
        Fri, 10 Apr 2026 14:01:17 -0700 (PDT)
Received: from [127.0.0.1] ([52.150.30.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84c464a4sm32401106d6.28.2026.04.10.14.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 14:01:16 -0700 (PDT)
Message-Id: <5d5dc1f60e92c9c10366f235a3eff554a67804b5.1775854874.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v9.git.git.1775854874.gitgitgadget@gmail.com>
References: <pull.2234.v8.git.git.1775762235.gitgitgadget@gmail.com>
	<pull.2234.v9.git.git.1775854874.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Apr 2026 21:01:10 +0000
Subject: [PATCH v9 1/4] stash: add --label-ours, --label-theirs, --label-base
 for apply
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Allow callers of "git stash apply" to pass custom labels for conflict
markers instead of the default "Updated upstream" and "Stashed changes".
Document the new options and add a test.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-stash.adoc | 11 ++++++++++-
 builtin/stash.c              | 32 +++++++++++++++++++++++++-------
 t/t3903-stash.sh             | 29 +++++++++++++++++++++++++++++
 xdiff/xmerge.c               |  6 +++---
 4 files changed, 67 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
index b05c990ecd..50bb89f483 100644
--- a/Documentation/git-stash.adoc
+++ b/Documentation/git-stash.adoc
@@ -12,7 +12,7 @@ git stash list [<log-options>]
 git stash show [-u | --include-untracked | --only-untracked] [<diff-options>] [<stash>]
 git stash drop [-q | --quiet] [<stash>]
 git stash pop [--index] [-q | --quiet] [<stash>]
-git stash apply [--index] [-q | --quiet] [<stash>]
+git stash apply [--index] [-q | --quiet] [--label-ours=<label>] [--label-theirs=<label>] [--label-base=<label>] [<stash>]
 git stash branch <branchname> [<stash>]
 git stash [push] [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
 	     [-u | --include-untracked] [-a | --all] [(-m | --message) <message>]
@@ -195,6 +195,15 @@ the index's ones. However, this can fail, when you have conflicts
 (which are stored in the index, where you therefore can no longer
 apply the changes as they were originally).
 
+`--label-ours=<label>`::
+`--label-theirs=<label>`::
+`--label-base=<label>`::
+	These options are only valid for the `apply` command.
++
+Use the given labels in conflict markers instead of the default
+"Updated upstream", "Stashed changes", and "Stash base".
+`--label-base` only has an effect with merge.conflictStyle=diff3.
+
 `-k`::
 `--keep-index`::
 `--no-keep-index`::
diff --git a/builtin/stash.c b/builtin/stash.c
index 0d27b2fb1f..00314e2b13 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -44,7 +44,7 @@
 #define BUILTIN_STASH_POP_USAGE \
 	N_("git stash pop [--index] [-q | --quiet] [<stash>]")
 #define BUILTIN_STASH_APPLY_USAGE \
-	N_("git stash apply [--index] [-q | --quiet] [<stash>]")
+	N_("git stash apply [--index] [-q | --quiet] [--label-ours=<label>] [--label-theirs=<label>] [--label-base=<label>] [<stash>]")
 #define BUILTIN_STASH_BRANCH_USAGE \
 	N_("git stash branch <branchname> [<stash>]")
 #define BUILTIN_STASH_STORE_USAGE \
@@ -590,8 +590,11 @@ static void unstage_changes_unless_new(struct object_id *orig_tree)
 		die(_("could not write index"));
 }
 
-static int do_apply_stash(const char *prefix, struct stash_info *info,
-			  int index, int quiet)
+static int do_apply_stash_with_labels(const char *prefix,
+				      struct stash_info *info,
+				      int index, int quiet,
+				      const char *label_ours, const char *label_theirs,
+				      const char *label_base)
 {
 	int clean, ret;
 	int has_index = index;
@@ -643,9 +646,9 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 
 	init_ui_merge_options(&o, the_repository);
 
-	o.branch1 = "Updated upstream";
-	o.branch2 = "Stashed changes";
-	o.ancestor = "Stash base";
+	o.branch1 = label_ours ? label_ours : "Updated upstream";
+	o.branch2 = label_theirs ? label_theirs : "Stashed changes";
+	o.ancestor = label_base ? label_base : "Stash base";
 
 	if (oideq(&info->b_tree, &c_tree))
 		o.branch1 = "Version stash was based on";
@@ -717,17 +720,31 @@ restore_untracked:
 	return ret;
 }
 
+static int do_apply_stash(const char *prefix, struct stash_info *info,
+			  int index, int quiet)
+{
+	return do_apply_stash_with_labels(prefix, info, index, quiet,
+					  NULL, NULL, NULL);
+}
+
 static int apply_stash(int argc, const char **argv, const char *prefix,
 		       struct repository *repo UNUSED)
 {
 	int ret = -1;
 	int quiet = 0;
 	int index = use_index;
+	const char *label_ours = NULL, *label_theirs = NULL, *label_base = NULL;
 	struct stash_info info = STASH_INFO_INIT;
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
 		OPT_BOOL(0, "index", &index,
 			 N_("attempt to recreate the index")),
+		OPT_STRING(0, "label-ours", &label_ours, N_("label"),
+			   N_("label for the upstream side in conflict markers")),
+		OPT_STRING(0, "label-theirs", &label_theirs, N_("label"),
+			   N_("label for the stashed side in conflict markers")),
+		OPT_STRING(0, "label-base", &label_base, N_("label"),
+			   N_("label for the base in diff3 conflict markers")),
 		OPT_END()
 	};
 
@@ -737,7 +754,8 @@ static int apply_stash(int argc, const char **argv, const char *prefix,
 	if (get_stash_info(&info, argc, argv))
 		goto cleanup;
 
-	ret = do_apply_stash(prefix, &info, index, quiet);
+	ret = do_apply_stash_with_labels(prefix, &info, index, quiet,
+					 label_ours, label_theirs, label_base);
 cleanup:
 	free_stash_info(&info);
 	return ret;
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 70879941c2..00bcb1f802 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1666,6 +1666,35 @@ test_expect_success 'restore untracked files even when we hit conflicts' '
 	)
 '
 
+test_expect_success 'apply with custom conflict labels' '
+	git init conflict_labels &&
+	(
+		cd conflict_labels &&
+		test_commit base file &&
+		echo stashed >file &&
+		git stash push -m "stashed" &&
+		test_commit upstream file &&
+		test_must_fail git -c merge.conflictStyle=diff3 stash apply --label-ours=UP --label-theirs=STASH &&
+		test_grep "^<<<<<<< UP" file &&
+		test_grep "^||||||| Stash base" file &&
+		test_grep "^>>>>>>> STASH" file
+	)
+'
+
+test_expect_success 'apply with empty conflict labels' '
+	git init empty_labels &&
+	(
+		cd empty_labels &&
+		test_commit base file &&
+		echo stashed >file &&
+		git stash push -m "stashed" &&
+		test_commit upstream file &&
+		test_must_fail git stash apply --label-ours= --label-theirs= &&
+		test_grep "^<<<<<<<$" file &&
+		test_grep "^>>>>>>>$" file
+	)
+'
+
 test_expect_success 'stash create reports a locked index' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 29dad98c49..659ad4ec97 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -199,9 +199,9 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 			      int size, int i, int style,
 			      xdmerge_t *m, char *dest, int marker_size)
 {
-	int marker1_size = (name1 ? strlen(name1) + 1 : 0);
-	int marker2_size = (name2 ? strlen(name2) + 1 : 0);
-	int marker3_size = (name3 ? strlen(name3) + 1 : 0);
+	int marker1_size = (name1 && *name1 ? strlen(name1) + 1 : 0);
+	int marker2_size = (name2 && *name2 ? strlen(name2) + 1 : 0);
+	int marker3_size = (name3 && *name3 ? strlen(name3) + 1 : 0);
 	int needs_cr = is_cr_needed(xe1, xe2, m);
 
 	if (marker_size <= 0)
-- 
gitgitgadget


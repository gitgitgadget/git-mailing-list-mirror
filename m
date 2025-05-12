Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0A7265CC1
	for <git@vger.kernel.org>; Mon, 12 May 2025 23:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747093330; cv=none; b=IQclo306MITDOmbI7N9WvdOozL4Zep5OxqsNRxWrjsUrssJpZ1nst3LP2LsequPRrV6LrEt6zJmdHVa2FvTjf/69lY+8mxDtWkLdY4weFQuuCRFO4hWz3ncJXdLx+gD5pDyEZ2pmIFUDXKnB9jPEraYoOwK2lBtCEiWHAWFXYKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747093330; c=relaxed/simple;
	bh=EseOyFIwYSFwSv4t3742CkCg7lFwxN1+B+W1M5NY9+Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YOmjo3vxxAfUnFL87BjAgGIvwd+y3xWSNtMbsPHZBVIieJYelUY1dfo95ifQlaIPcqoGD+omkVr6CDO4+XvWtzc/s3qI8F04ncSld4vFoA6r6gCU+zx//lDIdvGUspng5jTkoq/aMjLvmtKds8XaMH27Lej5RIBSnRSosKFfjTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCBw85K0; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCBw85K0"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so36572545e9.1
        for <git@vger.kernel.org>; Mon, 12 May 2025 16:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747093327; x=1747698127; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KX3l3inZo1RQpdAozxwGepiAlpduFMkPF+9+pQzewkM=;
        b=gCBw85K07hkYOS4y55gYt+TE9uV7K2KygDwt5QD5WpxUkLlB41Rm46ex4VemSMBO7T
         FHll+0H12kbBtR/dLYOULnG9pyrpQojkg9PsAoc+bZ3vA0vEAK04zjLU0TizUqOY0c5z
         +Gs4gJ+9tmD6Ie/E6HkmSdLEfcD8ouP82OJuAzABq20Ar8OO1DuhZFg2ZEfFlJscyJH1
         eCnZ3VXKvU5tUAdjB9Ug09alDc3v3O57o1y4+hG8Sy9/eciFxWL/9ufBVXo17Y8bFPm6
         0f84m8t8VgFkBTnoQCl+XGJfm2TjyXdWIxiYqWvo0m6INa0mptNoOlJhb6Nx2LBa7eG+
         43ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747093327; x=1747698127;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KX3l3inZo1RQpdAozxwGepiAlpduFMkPF+9+pQzewkM=;
        b=Y5JLd7QzxhBqjNinFG9Rky7uRJXx7Lyo23vrAztwvDmVcoBpKQVnTsCyz1Y25VXRrg
         8xe7uCnvvt7J0rLlP/rDD+3cqrmAE3ZFpB/TT8NTo5ouCM+5Zp8RTOdkxXLBgGe9KFu7
         7Qc0KNtSE7OAjHvhIPO0+MXASXYbcSGnVtJq1nCNAm+KEIBwhHqSKCNKV/+VhB8WxbO8
         MtOoSvba2veHCggH8HRFuUUGXdycrgHB2+SwLmlW9wIlTtytvjMRiL6FUZMTG5P7xex6
         BSHaLrVojsaafvr2RrJvecbOHd3V8ImXU/JLMrb8jIG7ILpisg+KRA3dYJIdnRIwCv1x
         HS5w==
X-Gm-Message-State: AOJu0Yxm1IR7R/+4UjIn0gph9wrnQl1AFqN/DR62sh5f9ND2vCDXJucM
	1LD4GvPjKNMjnmaJzWrf7qmPmWARh+dkzx/FLOYxQ3ZsgZpNs1nHrwJ/Sg==
X-Gm-Gg: ASbGncs32jYsuBKtI33Xi3dCyuV9+3DY2Q+VJfdKU9LSy6sNecO/HfCzko8Qw4R8+gD
	LtBo5/WIMYqtXlXJ7JKzPFk6iLuUX8/cOWMt/16/jmM+ZSYjtP56rpdAH3W0PS46uhxSAXA9y36
	C8w25wFX6mCOMWx/mNENnqX9fREp1HAO+V0p7qxNFi5Fnr6fvaNhKF2uO0Qo0bJKc1FMtf3NpcA
	vDC38ZfgWMf3On56CbmxC+jn5fCCm0lfSS/xcqvu1vCA8n5dpnzrlBmbyFCbgH/OjLgLpEclyoz
	/pWI9A+XSQ6DT4zopYtYYK/HopFP6tX53lvzyxIwY3o3HArfbdv3
X-Google-Smtp-Source: AGHT+IG+2aeS3b9CsZPyd4m93ZXQhcCs4iVLWAp+OocPXXf0LuzxsThTl7ub7LlrFwx5UpUhaNg6XQ==
X-Received: by 2002:a05:600c:154b:b0:441:ac58:ead5 with SMTP id 5b1f17b1804b1-442d6ddd0afmr155303855e9.31.1747093326352;
        Mon, 12 May 2025 16:42:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2ca47sm14115033f8f.73.2025.05.12.16.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 16:42:05 -0700 (PDT)
Message-Id: <1d18ab7feb877a4173ac55814177aefe88cee658.1747093322.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1920.v2.git.1747093322.gitgitgadget@gmail.com>
References: <pull.1920.git.1746914561.gitgitgadget@gmail.com>
	<pull.1920.v2.git.1747093322.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 12 May 2025 23:42:02 +0000
Subject: [PATCH v2 2/2] merge-tree: add a new --dry-run flag
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Git Forges may be interested in whether two branches can be merged while
not being interested in what the resulting merge tree is nor which files
conflicted.  For such cases, add a new --dry-run flag which
will make use of the new mergeability_only flag added to merge-ort in
the previous commit.  This option allows the merge machinery to, in the
outer layer of the merge:
    * exit early when a conflict is detected
    * avoid writing (most) merged blobs/trees to the object store

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-merge-tree.adoc |  6 +++++
 builtin/merge-tree.c              | 22 ++++++++++++++++++
 t/t4301-merge-tree-write-tree.sh  | 38 +++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/Documentation/git-merge-tree.adoc b/Documentation/git-merge-tree.adoc
index cf0578f9b5e8..7dcc17806191 100644
--- a/Documentation/git-merge-tree.adoc
+++ b/Documentation/git-merge-tree.adoc
@@ -65,6 +65,12 @@ OPTIONS
 	default is to include these messages if there are merge
 	conflicts, and to omit them otherwise.
 
+--mergeability-only::
+	Disable all output from the program.  Useful when you are only
+	interested in the exit status.  Allows merge-tree to exit
+	early on the first conflict it finds, and allows it to avoid
+	writing most objects created by merges.
+
 --allow-unrelated-histories::
 	merge-tree will by default error out if the two branches specified
 	share no common history.  This flag can be given to override that
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 4aafa73c6155..579e81d51844 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -490,6 +490,9 @@ static int real_merge(struct merge_tree_options *o,
 	if (result.clean < 0)
 		die(_("failure to merge"));
 
+	if (o->merge_options.mergeability_only)
+		goto cleanup;
+
 	if (show_messages == -1)
 		show_messages = !result.clean;
 
@@ -522,6 +525,8 @@ static int real_merge(struct merge_tree_options *o,
 	}
 	if (o->use_stdin)
 		putchar(line_termination);
+
+cleanup:
 	merge_finalize(&opt, &result);
 	clear_merge_options(&opt);
 	return !result.clean; /* result.clean < 0 handled above */
@@ -538,6 +543,7 @@ int cmd_merge_tree(int argc,
 	int original_argc;
 	const char *merge_base = NULL;
 	int ret;
+	int dry_run = 0;
 
 	const char * const merge_tree_usage[] = {
 		N_("git merge-tree [--write-tree] [<options>] <branch1> <branch2>"),
@@ -552,6 +558,10 @@ int cmd_merge_tree(int argc,
 			    N_("do a trivial merge only"), MODE_TRIVIAL),
 		OPT_BOOL(0, "messages", &o.show_messages,
 			 N_("also show informational/conflict messages")),
+		OPT_BOOL_F(0, "dry-run",
+			   &dry_run,
+			   N_("suppress all output; only exit status wanted"),
+			   PARSE_OPT_NONEG),
 		OPT_SET_INT('z', NULL, &line_termination,
 			    N_("separate paths with the NUL character"), '\0'),
 		OPT_BOOL_F(0, "name-only",
@@ -583,6 +593,18 @@ int cmd_merge_tree(int argc,
 	argc = parse_options(argc, argv, prefix, mt_options,
 			     merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPTION);
 
+	if (dry_run && o.show_messages == -1)
+		o.show_messages = 0;
+	o.merge_options.mergeability_only = dry_run;
+	die_for_incompatible_opt2(dry_run, "--mergeability-only",
+				  o.show_messages, "--messages");
+	die_for_incompatible_opt2(dry_run, "--mergeability-only",
+				  o.name_only, "--name-only");
+	die_for_incompatible_opt2(dry_run, "--mergeability-only",
+				  o.use_stdin, "--stdin");
+	die_for_incompatible_opt2(dry_run, "--mergeability-only",
+				  !line_termination, "-z");
+
 	if (xopts.nr && o.mode == MODE_TRIVIAL)
 		die(_("--trivial-merge is incompatible with all other options"));
 	for (size_t x = 0; x < xopts.nr; x++)
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index f9c5883a7f7c..566a2b4ec737 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -54,6 +54,25 @@ test_expect_success setup '
 	git commit -m first-commit
 '
 
+test_expect_success '--dry-run on clean merge' '
+	# Get rid of loose objects to start with
+	git gc &&
+	echo "0 objects, 0 kilobytes" >expect &&
+	git count-objects >actual &&
+	test_cmp expect actual &&
+
+	# Ensure merge is successful (exit code of 0)
+	git merge-tree --write-tree --dry-run side1 side3 >output &&
+
+	# Ensure there is no output
+	test_must_be_empty output &&
+
+	# Ensure no loose objects written (all new objects written would have
+	# been in "outer layer" of the merge)
+	git count-objects >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'Clean merge' '
 	TREE_OID=$(git merge-tree --write-tree side1 side3) &&
 	q_to_tab <<-EOF >expect &&
@@ -72,6 +91,25 @@ test_expect_success 'Failed merge without rename detection' '
 	grep "CONFLICT (modify/delete): numbers deleted" out
 '
 
+test_expect_success  '--dry-run on conflicted merge' '
+	# Get rid of loose objects to start with
+	git gc &&
+	echo "0 objects, 0 kilobytes" >expect &&
+	git count-objects >actual &&
+	test_cmp expect actual &&
+
+	# Ensure merge has conflict
+	test_expect_code 1 git merge-tree --write-tree --dry-run side1 side2 >output &&
+
+	# Ensure there is no output
+	test_must_be_empty output &&
+
+	# Ensure no loose objects written (all new objects written would have
+	# been in "outer layer" of the merge)
+	git count-objects >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'Content merge and a few conflicts' '
 	git checkout side1^0 &&
 	test_must_fail git merge side2 &&
-- 
gitgitgadget

Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268E21E5B6D
	for <git@vger.kernel.org>; Sat, 10 May 2025 22:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746914569; cv=none; b=HTq6o/c8BOIkZ8y6DXayDyrPYGYdqpt1UGyOgh05UAfLAbYrXr1kRJ1p6NXS8itAcW037GoKAaQ0LJD5dEFvcZF42PN2mJdJupdfSgzUYlichrGRisC9eJEbP0w86k3XbEH0S7NXximzY441i8GhSqLnahr+7BAvIt6lgOjqRJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746914569; c=relaxed/simple;
	bh=HKSle50LUzENRzZ1rOvcHx8GBgUI1UTL34WIoTWkx2I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=coRHym8aNo+Q2mkqmQthjiEjq5FZPTmMyQ0xKKQ/VTOEbNKUO6wGcS348S6YNq4X+WJP378+iENJPJbpKYUdKppRTFB/Dsm0wWUVVrVEku98+uJAGeGIK8KEt3Xz+5v11XGMJz6PZYhzIee9k7KG/H8hsXlJksIat8yK0S7dJZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mA052Ima; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mA052Ima"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a1f8c85562so1149074f8f.1
        for <git@vger.kernel.org>; Sat, 10 May 2025 15:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746914565; x=1747519365; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oEXUijIc7NtfmG6m0/ay9EPu3d3ozJ/9+McRW5nQHM=;
        b=mA052ImasJdTj8BjMm3XoxYxF+h9D44qKvk4X0xkisT6yiC2wuGafP4XJD7uwOlNws
         Wip3oicnEmjM1Q/MRve29fv9R6/5XJC+5KKc8WKuf8zjw3WstEaaAxLXM+Z0knS5ZRwi
         VBkYxBpjOE1KaJpE4J0z4NYE2mdb2pw4gAMDNJO7AH8nNKeImgKKB3R5PfMRQM4yBkNo
         RjoDqDtfulWZsng7fPRRwTryj324bUkAYJ9J2gTP2E6LJizAN8D1GQHT5eCPgq3kjvQe
         jU5w9+5QjIRMMc6mLEfnINILJFvvPCDMEks6ZulP+n7rDqlsztWRQLENccLysDt7vBQp
         5Mwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746914565; x=1747519365;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3oEXUijIc7NtfmG6m0/ay9EPu3d3ozJ/9+McRW5nQHM=;
        b=m8++AQZQ3iEQMoDHdaiAjfLy6bGkbZoVecr3vfgcddRfHLNfXOXItCTAfzI0gfVZxQ
         W60yQomE0+i2hDb2MXPEK9uwMnGbH2FqcMO8W5qglDJMT1r2yIrKmMmNhPDqjiUSEV7P
         NDVQv4mQcHGHfmtp1UulE3kVTrjReD8JPIeiYlS8rJ7rLlLyYzcnUSE0TDHpygryiX41
         mDW+BVWVzVkWsMlkFd4GCslYnUdQUgM+WORwdTGbysgYHIIS6TIx0FsXRYOuRjvxImqq
         t1V/WvQPYodbZ4IWqdEkKOq3CoGnRUyeu5VZw1yD4I0xNYTsYO7N7KRixS60drsjFo6G
         eVbg==
X-Gm-Message-State: AOJu0Ywd1u2/YbevvaMZSXnW6nZfWiZh4pX55SRWAtUFLmZKkcxANy6N
	TeyzY6k3+iUYxcgvWmVovzrkiaj6qNjDjFibY9xeoXbKbc9F5nGOlXo1XQ==
X-Gm-Gg: ASbGnctLa1x2vJbv1ddwqEJFfElYND47rL5H8g++Fjh3VO+AnqwFXa4/2nABDSKdXPN
	HdKGP/OZ4R/XFY5Qctwv0Ha6/quZujKbkAq1T62PxpiExa67snD7WtwStz7Bjl3J3s3rcG9QtrF
	OMqxQGKEVD/I86JdbzO0j8Ik3JsFCsDptXMA03IToV1j3N6U9gt3vpyQE3UaTeCyLTn2c4SHo2N
	UCnjf/GS9KnONj1RBKwKhsfzXeYo+N/XVp+3v5HaxPNgdtTjEcJuiMZwzVOibn1fEqCMfiC3hdy
	yXPPQqyBwt9vG2QN5wDZfxYF01GCq0RH4JrNI76hbTD3VQ7RYQv1
X-Google-Smtp-Source: AGHT+IH8eoW1orhVqdDibzrfUThzK7ZWiiMh6/Xsa6P3Ima6/jCq2j+EB53/OpG4yFMwUNb67CJfBA==
X-Received: by 2002:a5d:5986:0:b0:3a1:fd74:4248 with SMTP id ffacd0b85a97d-3a1fd744420mr3171121f8f.5.1746914564468;
        Sat, 10 May 2025 15:02:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f396asm7672619f8f.59.2025.05.10.15.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 15:02:43 -0700 (PDT)
Message-Id: <0b32c80d2867492b7b63f346bdf1e9401d4644ae.1746914561.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1920.git.1746914561.gitgitgadget@gmail.com>
References: <pull.1920.git.1746914561.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 10 May 2025 22:02:41 +0000
Subject: [PATCH 2/2] merge-tree: add a new --mergeability-only flag
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
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Git Forges may be interested in whether two branches can be merged while
not being interested in what the resulting merge tree is nor which files
conflicted.  For such cases, add a new --mergeability-only flag which
will make use of the new mergeability_only flag added to merge-ort in
the previous commit.  This option allows the merge machinery to, in the
outer layer of the merge:
      * exit upon first conflict
      * avoid writing merged blobs/trees to the object store

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
index 4aafa73c6155..48179d83596c 100644
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
+	int mergeability_only = 0;
 
 	const char * const merge_tree_usage[] = {
 		N_("git merge-tree [--write-tree] [<options>] <branch1> <branch2>"),
@@ -552,6 +558,10 @@ int cmd_merge_tree(int argc,
 			    N_("do a trivial merge only"), MODE_TRIVIAL),
 		OPT_BOOL(0, "messages", &o.show_messages,
 			 N_("also show informational/conflict messages")),
+		OPT_BOOL_F(0, "mergeability-only",
+			   &mergeability_only,
+			   N_("suppress all output; only exit status wanted"),
+			   PARSE_OPT_NONEG),
 		OPT_SET_INT('z', NULL, &line_termination,
 			    N_("separate paths with the NUL character"), '\0'),
 		OPT_BOOL_F(0, "name-only",
@@ -583,6 +593,18 @@ int cmd_merge_tree(int argc,
 	argc = parse_options(argc, argv, prefix, mt_options,
 			     merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPTION);
 
+	if (mergeability_only && o.show_messages == -1)
+		o.show_messages = 0;
+	o.merge_options.mergeability_only = mergeability_only;
+	die_for_incompatible_opt2(mergeability_only, "--mergeability-only",
+				  o.show_messages, "--messages");
+	die_for_incompatible_opt2(mergeability_only, "--mergeability-only",
+				  o.name_only, "--name-only");
+	die_for_incompatible_opt2(mergeability_only, "--mergeability-only",
+				  o.use_stdin, "--stdin");
+	die_for_incompatible_opt2(mergeability_only, "--mergeability-only",
+				  !line_termination, "-z");
+
 	if (xopts.nr && o.mode == MODE_TRIVIAL)
 		die(_("--trivial-merge is incompatible with all other options"));
 	for (size_t x = 0; x < xopts.nr; x++)
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index f9c5883a7f7c..3170830dd79d 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -54,6 +54,25 @@ test_expect_success setup '
 	git commit -m first-commit
 '
 
+test_expect_success '--mergeability-only on clean merge' '
+	# Get rid of loose objects to start with
+	git gc &&
+	echo "0 objects, 0 kilobytes" >expect &&
+	git count-objects >actual &&
+	test_cmp expect actual &&
+
+	# Ensure merge is successful (exit code of 0)
+	git merge-tree --write-tree --mergeability-only side1 side3 >output &&
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
 
+test_expect_success  '--mergeability-only on conflicted merge' '
+	# Get rid of loose objects to start with
+	git gc &&
+	echo "0 objects, 0 kilobytes" >expect &&
+	git count-objects >actual &&
+	test_cmp expect actual &&
+
+	# Ensure merge has conflict
+	test_expect_code 1 git merge-tree --write-tree --mergeability-only side1 side2 >output &&
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

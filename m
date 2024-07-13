Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2691A137742
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720889513; cv=none; b=lvtoAZtTEoLmmv/IGQAywWtZA2o143R36rs10DAXhKtJ0938x/Z85f/ElTtldG1a8+KS9FTJTuertHQqWNNGk/CgaFi6/Hp+R93VFPuusHvMwH9gjIcP8RJ1nqVHLPpMA3YzHNA9KyLWg6bbWbCPk4LuhOmXCM616P1K3u/bcWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720889513; c=relaxed/simple;
	bh=7WdQqQ2l8xq46fVsNqjJiO+UBedM71ds0oZV6gPx8qU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HOB5LEIkT6zfPxoVSe9qG1uF06krCWGLor3KHQv2zZDHDf31LGskfqPaRW9xHm0zfUDp/cii/X/JhlSPY6R1u5sJbBXf5p8HLMN+NRGfewWQJAroD2Gyg1euewaQVzVaISNzhVPeFQjfSbn0KmE66A1gB8aldmIKuxN6gwAfJCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsDSCKk0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsDSCKk0"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4266f344091so21918925e9.0
        for <git@vger.kernel.org>; Sat, 13 Jul 2024 09:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720889509; x=1721494309; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxKV2HuWVBMQBQEGZB/j6qa5cR/wan85/yqZVnqL1CU=;
        b=YsDSCKk0gk7teKvph2Ct5sFUkVJtVAalzEOABZMFXiN+eYiMU4HcW/1oFNvF7B97wJ
         O8Mzaojuy523g9/OpV12EP55g2kFx1iL1ij9sBFv0b51pLAX5/yq0GMkkcxZFgBUFYF1
         Ogqtl9YyUncLYXUqBQ9nr0XLZvxotH+9WoBAH9O6ZrFqluNmW++b2757F8911eb+O/WB
         zU1JQpvZRJQVFCwkgH9jbBBDpfWcjTOAPL4i5n2y+lGULPFq45M+gH1nHSXoitKjnNaq
         Zo/Pnd6GP/hNmlOtcVFDRQ0raYegtE677EUfoZSjyXiUshU1MBIaF21XJSZURWL8Kho1
         NXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720889509; x=1721494309;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxKV2HuWVBMQBQEGZB/j6qa5cR/wan85/yqZVnqL1CU=;
        b=Tqm3lXc3gKnnDW+Pm1gjj/NDd6KeK2mtlm3rjFtN4ZzfC65cPlOFNEeFxzWifBPGgW
         1wUMhO48e8wOsI9Ak6Sgbn0OHWR8+n1/K0/Z1JQjCcqviLw1mOtOYN4O4RNIE0Ve4yw+
         iIdRN4M4ECtuEWMRYqwzk9mAvDo8+EFpdIvWOylDGrY+hTqTqMcsk8zLMad1CYXdEO+N
         0+zbw0P1+YCw5Y7f9PnCj+W6vCh8acylbomjW5xc2yLaKhZ2f+FYjN3UmNij7USf+7n9
         JTFbq8rFk43ICSmGFah8Tc+QRWE4O5Tr8RHKn9D2umZ+qgiO7FTSuwRKZo6tqImnZs4q
         ykpA==
X-Gm-Message-State: AOJu0YxAACoCvLywYR01FXyP6CYpxLdP3k9iiRE5FbRO40mcQh+Teh94
	gaQX/SKyEcjFRoDfFDfOmd3EA4GD8qejTrBeHOPZqZWze/QKV2o8P+THsA==
X-Google-Smtp-Source: AGHT+IH3y0fkdlVF4kiuadU06PnSRcDDFSyDP9oDGQ0wlrOLx/mzy7WLsNxvPv8b3iCYQiT/jxvksQ==
X-Received: by 2002:a05:600c:4a23:b0:425:80d5:b8b2 with SMTP id 5b1f17b1804b1-426707d03b6mr100271395e9.16.1720889508581;
        Sat, 13 Jul 2024 09:51:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dab3d4dsm1941119f8f.23.2024.07.13.09.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 09:51:48 -0700 (PDT)
Message-Id: <pull.1743.v3.git.git.1720889507066.gitgitgadget@gmail.com>
In-Reply-To: <pull.1743.v2.git.git.1720551701648.gitgitgadget@gmail.com>
References: <pull.1743.v2.git.git.1720551701648.gitgitgadget@gmail.com>
From: "Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 13 Jul 2024 16:51:46 +0000
Subject: [PATCH v3] merge-recursive: honor diff.algorithm
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
Cc: "Junio C Hamano [ ]" <gitster@pobox.com>,
    Antonin Delpeuch <antonin@delpeuch.eu>,
    Antonin Delpeuch <antonin@delpeuch.eu>

From: Antonin Delpeuch <antonin@delpeuch.eu>

The documentation claims that "recursive defaults to the diff.algorithm
config setting", but this is currently not the case. This fixes it,
ensuring that diff.algorithm is used when -Xdiff-algorithm is not
supplied. This affects the following porcelain commands: "merge",
"rebase", "cherry-pick", "pull", "stash", "log", "am" and "checkout".
It also affects the "merge-tree" ancillary interrogator.

This change refactors the initialization of merge options to introduce
two functions, "init_merge_ui_options" and "init_merge_basic_options"
instead of just one "init_merge_options". This design follows the
approach used in diff.c, providing initialization methods for
porcelain and plumbing commands respectively. Thanks to that, the
"replay" and "merge-recursive" plumbing commands remain unaffected by
diff.algorithm.

Signed-off-by: Antonin Delpeuch <antonin@delpeuch.eu>
---
    merge-recursive: honor diff.algorithm
    
    Changes since v2:
    
     * merge test cases of "merge" and "cherry-pick" together to keep things
       simple

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1743%2Fwetneb%2Frecursive_respects_diff.algorithm-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1743/wetneb/recursive_respects_diff.algorithm-v3
Pull-Request: https://github.com/git/git/pull/1743

Range-diff vs v2:

 1:  9c1907fad43 ! 1:  abba5c3c0cf merge-recursive: honor diff.algorithm
     @@ sequencer.c: static int do_merge(struct repository *r,
       	o.branch2 = ref_name.buf;
       	o.buffer_output = 2;
      
     - ## t/t3515-cherry-pick-diff.sh (new) ##
     + ## t/t7615-diff-algo-with-mergy-operations.sh (new) ##
      @@
      +#!/bin/sh
      +
     -+test_description='git cherry-pick
     ++test_description='git merge and other operations that rely on merge
      +
      +Testing the influence of the diff algorithm on the merge output.'
      +
     @@ t/t3515-cherry-pick-diff.sh (new)
      +. ./test-lib.sh
      +
      +test_expect_success 'setup' '
     -+	cp "$TEST_DIRECTORY"/t3515/base.c file.c &&
     ++	cp "$TEST_DIRECTORY"/t7615/base.c file.c &&
      +	git add file.c &&
      +	git commit -m c0 &&
      +	git tag c0 &&
     -+	cp "$TEST_DIRECTORY"/t3515/ours.c file.c &&
     ++	cp "$TEST_DIRECTORY"/t7615/ours.c file.c &&
      +	git add file.c &&
      +	git commit -m c1 &&
      +	git tag c1 &&
      +	git reset --hard c0 &&
     -+	cp "$TEST_DIRECTORY"/t3515/theirs.c file.c &&
     ++	cp "$TEST_DIRECTORY"/t7615/theirs.c file.c &&
      +	git add file.c &&
      +	git commit -m c2 &&
      +	git tag c2
      +'
      +
     ++GIT_TEST_MERGE_ALGORITHM=recursive
     ++
     ++test_expect_success 'merge c2 to c1 with recursive merge strategy fails with the current default myers diff algorithm' '
     ++	git reset --hard c1 &&
     ++	test_must_fail git merge -s recursive c2
     ++'
     ++
     ++test_expect_success 'merge c2 to c1 with recursive merge strategy succeeds with -Xdiff-algorithm=histogram' '
     ++	git reset --hard c1 &&
     ++	git merge --strategy recursive -Xdiff-algorithm=histogram c2
     ++'
     ++
     ++test_expect_success 'merge c2 to c1 with recursive merge strategy succeeds with diff.algorithm = histogram' '
     ++	git reset --hard c1 &&
     ++	git config diff.algorithm histogram &&
     ++	git merge --strategy recursive c2
     ++'
     ++
      +test_expect_success 'cherry-pick c2 to c1 with recursive merge strategy fails with the current default myers diff algorithm' '
      +	git reset --hard c1 &&
      +	test_must_fail git cherry-pick -s recursive c2
     @@ t/t3515-cherry-pick-diff.sh (new)
      +	git config diff.algorithm histogram &&
      +	git cherry-pick --strategy recursive c2
      +'
     ++
      +test_done
      
     - ## t/t3515/base.c (new) ##
     + ## t/t7615/base.c (new) ##
      @@
      +int f(int x, int y)
      +{
     @@ t/t3515/base.c (new)
      +        return u;
      +}
      
     - ## t/t3515/ours.c (new) ##
     + ## t/t7615/ours.c (new) ##
      @@
      +int g(size_t u)
      +{
     @@ t/t3515/ours.c (new)
      +        return y;
      +}
      
     - ## t/t3515/theirs.c (new) ##
     + ## t/t7615/theirs.c (new) ##
      @@
      +int f(int x, int y)
      +{
     @@ t/t3515/theirs.c (new)
      +        }
      +        return u;
      +}
     -
     - ## t/t7615-merge-diff.sh (new) ##
     -@@
     -+#!/bin/sh
     -+
     -+test_description='git merge
     -+
     -+Testing the influence of the diff algorithm on the merge output.'
     -+
     -+TEST_PASSES_SANITIZE_LEAK=true
     -+. ./test-lib.sh
     -+
     -+test_expect_success 'setup' '
     -+	cp "$TEST_DIRECTORY"/t3515/base.c file.c &&
     -+	git add file.c &&
     -+	git commit -m c0 &&
     -+	git tag c0 &&
     -+	cp "$TEST_DIRECTORY"/t3515/ours.c file.c &&
     -+	git add file.c &&
     -+	git commit -m c1 &&
     -+	git tag c1 &&
     -+	git reset --hard c0 &&
     -+	cp "$TEST_DIRECTORY"/t3515/theirs.c file.c &&
     -+	git add file.c &&
     -+	git commit -m c2 &&
     -+	git tag c2
     -+'
     -+
     -+GIT_TEST_MERGE_ALGORITHM=recursive
     -+
     -+test_expect_success 'merge c2 to c1 with recursive merge strategy fails with the current default myers diff algorithm' '
     -+	git reset --hard c1 &&
     -+	test_must_fail git merge -s recursive c2
     -+'
     -+
     -+test_expect_success 'merge c2 to c1 with recursive merge strategy succeeds with -Xdiff-algorithm=histogram' '
     -+	git reset --hard c1 &&
     -+	git merge --strategy recursive -Xdiff-algorithm=histogram c2
     -+'
     -+
     -+test_expect_success 'merge c2 to c1 with recursive merge strategy succeeds with diff.algorithm = histogram' '
     -+	git reset --hard c1 &&
     -+	git config diff.algorithm histogram &&
     -+	git merge --strategy recursive c2
     -+'
     -+test_done


 builtin/am.c                               |  2 +-
 builtin/checkout.c                         |  2 +-
 builtin/merge-recursive.c                  |  2 +-
 builtin/merge-tree.c                       |  2 +-
 builtin/merge.c                            |  2 +-
 builtin/replay.c                           |  2 +-
 builtin/stash.c                            |  2 +-
 log-tree.c                                 |  2 +-
 merge-recursive.c                          | 29 +++++++++--
 merge-recursive.h                          |  5 +-
 sequencer.c                                |  4 +-
 t/t7615-diff-algo-with-mergy-operations.sh | 60 ++++++++++++++++++++++
 t/t7615/base.c                             | 17 ++++++
 t/t7615/ours.c                             | 17 ++++++
 t/t7615/theirs.c                           | 17 ++++++
 15 files changed, 150 insertions(+), 15 deletions(-)
 create mode 100755 t/t7615-diff-algo-with-mergy-operations.sh
 create mode 100644 t/t7615/base.c
 create mode 100644 t/t7615/ours.c
 create mode 100644 t/t7615/theirs.c

diff --git a/builtin/am.c b/builtin/am.c
index 8f9619ea3a3..b821561b15a 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1630,7 +1630,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 	 * changes.
 	 */
 
-	init_merge_options(&o, the_repository);
+	init_ui_merge_options(&o, the_repository);
 
 	o.branch1 = "HEAD";
 	their_tree_name = xstrfmt("%.*s", linelen(state->msg), state->msg);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3cf44b4683a..5769efaca00 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -884,7 +884,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 
 			add_files_to_cache(the_repository, NULL, NULL, NULL, 0,
 					   0);
-			init_merge_options(&o, the_repository);
+			init_ui_merge_options(&o, the_repository);
 			o.verbosity = 0;
 			work = write_in_core_index_as_tree(the_repository);
 
diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index c2ce044a201..9e9d0b57158 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -31,7 +31,7 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix UNUSED)
 	char *better1, *better2;
 	struct commit *result;
 
-	init_merge_options(&o, the_repository);
+	init_basic_merge_options(&o, the_repository);
 	if (argv[0] && ends_with(argv[0], "-subtree"))
 		o.subtree_shift = "";
 
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 1082d919fd1..aab0843ff5a 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -570,7 +570,7 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 	};
 
 	/* Init merge options */
-	init_merge_options(&o.merge_options, the_repository);
+	init_ui_merge_options(&o.merge_options, the_repository);
 
 	/* Parse arguments */
 	original_argc = argc - 1; /* ignoring argv[0] */
diff --git a/builtin/merge.c b/builtin/merge.c
index 66a4fa72e1c..686326bc1d3 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -720,7 +720,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 			return 2;
 		}
 
-		init_merge_options(&o, the_repository);
+		init_ui_merge_options(&o, the_repository);
 		if (!strcmp(strategy, "subtree"))
 			o.subtree_shift = "";
 
diff --git a/builtin/replay.c b/builtin/replay.c
index 6bf0691f15d..d90ddd0837d 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -373,7 +373,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		goto cleanup;
 	}
 
-	init_merge_options(&merge_opt, the_repository);
+	init_basic_merge_options(&merge_opt, the_repository);
 	memset(&result, 0, sizeof(result));
 	merge_opt.show_rename_progress = 0;
 	last_commit = onto;
diff --git a/builtin/stash.c b/builtin/stash.c
index 7859bc0866a..86803755f03 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -574,7 +574,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 		}
 	}
 
-	init_merge_options(&o, the_repository);
+	init_ui_merge_options(&o, the_repository);
 
 	o.branch1 = "Updated upstream";
 	o.branch2 = "Stashed changes";
diff --git a/log-tree.c b/log-tree.c
index 101079e8200..5d8fb6ff8df 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -1025,7 +1025,7 @@ static int do_remerge_diff(struct rev_info *opt,
 	struct strbuf parent2_desc = STRBUF_INIT;
 
 	/* Setup merge options */
-	init_merge_options(&o, the_repository);
+	init_ui_merge_options(&o, the_repository);
 	o.show_rename_progress = 0;
 	o.record_conflict_msgs_as_headers = 1;
 	o.msg_header_prefix = "remerge";
diff --git a/merge-recursive.c b/merge-recursive.c
index 46ee364af73..cd9bd3c03ef 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3901,7 +3901,7 @@ int merge_recursive_generic(struct merge_options *opt,
 	return clean ? 0 : 1;
 }
 
-static void merge_recursive_config(struct merge_options *opt)
+static void merge_recursive_config(struct merge_options *opt, int ui)
 {
 	char *value = NULL;
 	int renormalize = 0;
@@ -3930,11 +3930,20 @@ static void merge_recursive_config(struct merge_options *opt)
 		} /* avoid erroring on values from future versions of git */
 		free(value);
 	}
+	if (ui) {
+		if (!git_config_get_string("diff.algorithm", &value)) {
+			long diff_algorithm = parse_algorithm_value(value);
+			if (diff_algorithm < 0)
+				die(_("unknown value for config '%s': %s"), "diff.algorithm", value);
+			opt->xdl_opts = (opt->xdl_opts & ~XDF_DIFF_ALGORITHM_MASK) | diff_algorithm;
+			free(value);
+		}
+	}
 	git_config(git_xmerge_config, NULL);
 }
 
-void init_merge_options(struct merge_options *opt,
-			struct repository *repo)
+static void init_merge_options(struct merge_options *opt,
+			struct repository *repo, int ui)
 {
 	const char *merge_verbosity;
 	memset(opt, 0, sizeof(struct merge_options));
@@ -3953,7 +3962,7 @@ void init_merge_options(struct merge_options *opt,
 
 	opt->conflict_style = -1;
 
-	merge_recursive_config(opt);
+	merge_recursive_config(opt, ui);
 	merge_verbosity = getenv("GIT_MERGE_VERBOSITY");
 	if (merge_verbosity)
 		opt->verbosity = strtol(merge_verbosity, NULL, 10);
@@ -3961,6 +3970,18 @@ void init_merge_options(struct merge_options *opt,
 		opt->buffer_output = 0;
 }
 
+void init_ui_merge_options(struct merge_options *opt,
+			struct repository *repo)
+{
+	init_merge_options(opt, repo, 1);
+}
+
+void init_basic_merge_options(struct merge_options *opt,
+			struct repository *repo)
+{
+	init_merge_options(opt, repo, 0);
+}
+
 /*
  * For now, members of merge_options do not need deep copying, but
  * it may change in the future, in which case we would need to update
diff --git a/merge-recursive.h b/merge-recursive.h
index e67d38c3030..85a5c332bbb 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -54,7 +54,10 @@ struct merge_options {
 	struct merge_options_internal *priv;
 };
 
-void init_merge_options(struct merge_options *opt, struct repository *repo);
+/* for use by porcelain commands */
+void init_ui_merge_options(struct merge_options *opt, struct repository *repo);
+/* for use by plumbing commands */
+void init_basic_merge_options(struct merge_options *opt, struct repository *repo);
 
 void copy_merge_options(struct merge_options *dst, struct merge_options *src);
 void clear_merge_options(struct merge_options *opt);
diff --git a/sequencer.c b/sequencer.c
index b4f055e5a85..3608374166a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -762,7 +762,7 @@ static int do_recursive_merge(struct repository *r,
 
 	repo_read_index(r);
 
-	init_merge_options(&o, r);
+	init_ui_merge_options(&o, r);
 	o.ancestor = base ? base_label : "(empty tree)";
 	o.branch1 = "HEAD";
 	o.branch2 = next ? next_label : "(empty tree)";
@@ -4308,7 +4308,7 @@ static int do_merge(struct repository *r,
 	bases = reverse_commit_list(bases);
 
 	repo_read_index(r);
-	init_merge_options(&o, r);
+	init_ui_merge_options(&o, r);
 	o.branch1 = "HEAD";
 	o.branch2 = ref_name.buf;
 	o.buffer_output = 2;
diff --git a/t/t7615-diff-algo-with-mergy-operations.sh b/t/t7615-diff-algo-with-mergy-operations.sh
new file mode 100755
index 00000000000..9a83be518cb
--- /dev/null
+++ b/t/t7615-diff-algo-with-mergy-operations.sh
@@ -0,0 +1,60 @@
+#!/bin/sh
+
+test_description='git merge and other operations that rely on merge
+
+Testing the influence of the diff algorithm on the merge output.'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	cp "$TEST_DIRECTORY"/t7615/base.c file.c &&
+	git add file.c &&
+	git commit -m c0 &&
+	git tag c0 &&
+	cp "$TEST_DIRECTORY"/t7615/ours.c file.c &&
+	git add file.c &&
+	git commit -m c1 &&
+	git tag c1 &&
+	git reset --hard c0 &&
+	cp "$TEST_DIRECTORY"/t7615/theirs.c file.c &&
+	git add file.c &&
+	git commit -m c2 &&
+	git tag c2
+'
+
+GIT_TEST_MERGE_ALGORITHM=recursive
+
+test_expect_success 'merge c2 to c1 with recursive merge strategy fails with the current default myers diff algorithm' '
+	git reset --hard c1 &&
+	test_must_fail git merge -s recursive c2
+'
+
+test_expect_success 'merge c2 to c1 with recursive merge strategy succeeds with -Xdiff-algorithm=histogram' '
+	git reset --hard c1 &&
+	git merge --strategy recursive -Xdiff-algorithm=histogram c2
+'
+
+test_expect_success 'merge c2 to c1 with recursive merge strategy succeeds with diff.algorithm = histogram' '
+	git reset --hard c1 &&
+	git config diff.algorithm histogram &&
+	git merge --strategy recursive c2
+'
+
+test_expect_success 'cherry-pick c2 to c1 with recursive merge strategy fails with the current default myers diff algorithm' '
+	git reset --hard c1 &&
+	test_must_fail git cherry-pick -s recursive c2
+'
+
+test_expect_success 'cherry-pick c2 to c1 with recursive merge strategy succeeds with -Xdiff-algorithm=histogram' '
+	git reset --hard c1 &&
+	git cherry-pick --strategy recursive -Xdiff-algorithm=histogram c2
+'
+
+test_expect_success 'cherry-pick c2 to c1 with recursive merge strategy succeeds with diff.algorithm = histogram' '
+	git reset --hard c1 &&
+	git config diff.algorithm histogram &&
+	git cherry-pick --strategy recursive c2
+'
+
+test_done
diff --git a/t/t7615/base.c b/t/t7615/base.c
new file mode 100644
index 00000000000..c64abc59366
--- /dev/null
+++ b/t/t7615/base.c
@@ -0,0 +1,17 @@
+int f(int x, int y)
+{
+        if (x == 0)
+        {
+                return y;
+        }
+        return x;
+}
+
+int g(size_t u)
+{
+        while (u < 30)
+        {
+                u++;
+        }
+        return u;
+}
diff --git a/t/t7615/ours.c b/t/t7615/ours.c
new file mode 100644
index 00000000000..44d82513970
--- /dev/null
+++ b/t/t7615/ours.c
@@ -0,0 +1,17 @@
+int g(size_t u)
+{
+        while (u < 30)
+        {
+                u++;
+        }
+        return u;
+}
+
+int h(int x, int y, int z)
+{
+        if (z == 0)
+        {
+                return x;
+        }
+        return y;
+}
diff --git a/t/t7615/theirs.c b/t/t7615/theirs.c
new file mode 100644
index 00000000000..85f02146fee
--- /dev/null
+++ b/t/t7615/theirs.c
@@ -0,0 +1,17 @@
+int f(int x, int y)
+{
+        if (x == 0)
+        {
+                return y;
+        }
+        return x;
+}
+
+int g(size_t u)
+{
+        while (u > 34)
+        {
+                u--;
+        }
+        return u;
+}

base-commit: 06e570c0dfb2a2deb64d217db78e2ec21672f558
-- 
gitgitgadget

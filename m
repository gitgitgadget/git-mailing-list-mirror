Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9751B86D8
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 19:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720551708; cv=none; b=vGbtNDoHqMOYkofH05UqHkSi3aKY97N59yBiDmmoqIlkgqaZMdZh8ejJN9Zw4YzCqbQa1s+L4Rocwqf6C2XMuV0tPFeVutC6qLEDdRffbCgUyP63wCuo3nX/dozQUBjYBwoc5UxqlLdCDk/i1Ce74Ycf87noeBFgXl5irri1uEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720551708; c=relaxed/simple;
	bh=A+rMmpaUMTD6Ha3LyERoI2ZGeGPmyIYPazb5HoOCgGQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pxhMGgN6LUrINpA+hwDigA4P6TR8d1/tV4xtxopNowEC75VIbuqErRB/w/RrEyM5sRY1zhlaqQCdIgmOtPqn6oCB0dPzvqzjZOn3UKSW861e4LB2/0JcE8BcBC1tAtT6NwMIs6ixuxwuDnZACJbj1e4Bfst1Jh2YTIPaR4bMHs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apS3S1qy; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apS3S1qy"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-426685732dcso17988945e9.1
        for <git@vger.kernel.org>; Tue, 09 Jul 2024 12:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720551704; x=1721156504; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmrnB72ZvlRY8A+jS/R7SLJ3ANLYgLjHe6uEljn682w=;
        b=apS3S1qyls7DcGt1Cml5MOM0FtU06et9C7JDDe338N/0tpzf6vDkFoGcnLRvLwEhFK
         ag0dApYOQhiIG1UGxPwCql6qSCMrx2dG+BCFKSsGEv/vea1ZHwikeiKKgRpA6auEDe2+
         hJfrrta5uZQ458X7xJjtU/WNbVSQDhg8G5+5XtJJFvSptJS0ASY20DigtZREhHWBbRKI
         hchXleY8boAH+OTnYMiMrjtSNvA+SmDzHEqa4DT//KnEw/Oai6wdoq1vR7kgUTkiaigD
         gAKLK7/bsBwz0IgEFBQu42PA9VqrZYwqcXsDmWFTkCsnmwzbrNnSAdc65GGF1dTXqlsn
         npwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720551704; x=1721156504;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmrnB72ZvlRY8A+jS/R7SLJ3ANLYgLjHe6uEljn682w=;
        b=gBZBzXc+615GXmXTTvdg3V2X2BnyZlwgQW1YEisBr11EMVgwLeEhO4EFIUTBEqiI7S
         1DZptAZaSjHHmu1zLaeGGLogGD1cc8mu/iifmuFUIky6WWCBJJ6aqPIvIckQimECKJDD
         EQBYDrggP5FhysEoosSpT6zLLVGReAUrQAoVHIIf0LN88Htq5nMJOjgjXFTRyE7noqHp
         PwvXT6DnebxNpth5NhH7+S22VtEYKeV7xI/6c//4Gh2+MtxCecA6u2Yng4Ez+nUPX47D
         BejCJVwcpE/Z5cfgGRhpPrxFU/kxRVqsym8Y0eILCjo1pyUMiHCjgRdBNXnWzhiwQEXV
         /KQg==
X-Gm-Message-State: AOJu0YzXizqNB180KSmuwZMVGxwpWzuLXIG8p1fv23Gb/CLD9agWY+dU
	8rrtRr9GW78PuehXBnsmKiiwTOOzo5eVkEw3fQywwt5tp3MQ929V6UpBrg==
X-Google-Smtp-Source: AGHT+IG44wo1C3W6b0RMYyrye5TdN5MZ+6PONsPb8z8BgLE3Rl/UR5bAVVGtq8Zf4UDFYxLYxPYwMA==
X-Received: by 2002:a05:6000:546:b0:367:926f:5419 with SMTP id ffacd0b85a97d-367cea680b6mr2552066f8f.16.1720551703414;
        Tue, 09 Jul 2024 12:01:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfb2281sm3269387f8f.115.2024.07.09.12.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 12:01:42 -0700 (PDT)
Message-Id: <pull.1743.v2.git.git.1720551701648.gitgitgadget@gmail.com>
In-Reply-To: <pull.1743.git.git.1720431288496.gitgitgadget@gmail.com>
References: <pull.1743.git.git.1720431288496.gitgitgadget@gmail.com>
From: "Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 09 Jul 2024 19:01:41 +0000
Subject: [PATCH v2] merge-recursive: honor diff.algorithm
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
    
    Changes since v1:
    
     * introduce separate initialization methods for porcelain and plumbing
       commands
     * adapt commit message accordingly

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1743%2Fwetneb%2Frecursive_respects_diff.algorithm-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1743/wetneb/recursive_respects_diff.algorithm-v2
Pull-Request: https://github.com/git/git/pull/1743

Range-diff vs v1:

 1:  798b1612189 ! 1:  9c1907fad43 merge-recursive: honor diff.algorithm
     @@ Commit message
          "rebase", "cherry-pick", "pull", "stash", "log", "am" and "checkout".
          It also affects the "merge-tree" ancillary interrogator.
      
     -    This change also affects the "replay" and "merge-recursive" plumbing
     -    commands, which happen to call 'merge_recursive_config' and therefore
     -    are also affected by other configuration variables read in this
     -    function. For instance theay read "diff.renames", classified in diff.c
     -    as a diff "UI" config variable. Removing the reliance of those
     -    commands on this set of configuration variables feels like a bigger
     -    change and introducing an argument to 'merge_recursive_config' to
     -    prevent only the newly added diff.algorithm to be read by plumbing
     -    commands feels like muddying the architecture, as this function
     -    should likely not be called at all by plumbing commands.
     +    This change refactors the initialization of merge options to introduce
     +    two functions, "init_merge_ui_options" and "init_merge_basic_options"
     +    instead of just one "init_merge_options". This design follows the
     +    approach used in diff.c, providing initialization methods for
     +    porcelain and plumbing commands respectively. Thanks to that, the
     +    "replay" and "merge-recursive" plumbing commands remain unaffected by
     +    diff.algorithm.
      
          Signed-off-by: Antonin Delpeuch <antonin@delpeuch.eu>
      
     + ## builtin/am.c ##
     +@@ builtin/am.c: static int fall_back_threeway(const struct am_state *state, const char *index_pa
     + 	 * changes.
     + 	 */
     + 
     +-	init_merge_options(&o, the_repository);
     ++	init_ui_merge_options(&o, the_repository);
     + 
     + 	o.branch1 = "HEAD";
     + 	their_tree_name = xstrfmt("%.*s", linelen(state->msg), state->msg);
     +
     + ## builtin/checkout.c ##
     +@@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *opts,
     + 
     + 			add_files_to_cache(the_repository, NULL, NULL, NULL, 0,
     + 					   0);
     +-			init_merge_options(&o, the_repository);
     ++			init_ui_merge_options(&o, the_repository);
     + 			o.verbosity = 0;
     + 			work = write_in_core_index_as_tree(the_repository);
     + 
     +
       ## builtin/merge-recursive.c ##
      @@ builtin/merge-recursive.c: int cmd_merge_recursive(int argc, const char **argv, const char *prefix UNUSED)
       	char *better1, *better2;
       	struct commit *result;
       
     -+	/*
     -+	 * FIXME: This reads various config variables,
     -+	 * which 'merge-recursive' should ignore as a plumbing command
     -+	 */
     - 	init_merge_options(&o, the_repository);
     +-	init_merge_options(&o, the_repository);
     ++	init_basic_merge_options(&o, the_repository);
       	if (argv[0] && ends_with(argv[0], "-subtree"))
       		o.subtree_shift = "";
     + 
     +
     + ## builtin/merge-tree.c ##
     +@@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **argv, const char *prefix)
     + 	};
     + 
     + 	/* Init merge options */
     +-	init_merge_options(&o.merge_options, the_repository);
     ++	init_ui_merge_options(&o.merge_options, the_repository);
     + 
     + 	/* Parse arguments */
     + 	original_argc = argc - 1; /* ignoring argv[0] */
     +
     + ## builtin/merge.c ##
     +@@ builtin/merge.c: static int try_merge_strategy(const char *strategy, struct commit_list *common,
     + 			return 2;
     + 		}
     + 
     +-		init_merge_options(&o, the_repository);
     ++		init_ui_merge_options(&o, the_repository);
     + 		if (!strcmp(strategy, "subtree"))
     + 			o.subtree_shift = "";
     + 
      
       ## builtin/replay.c ##
      @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix)
       		goto cleanup;
       	}
       
     -+	/*
     -+	 * FIXME: This reads various config variables,
     -+	 * which 'replay' should ignore as a plumbing command
     -+	 */
     - 	init_merge_options(&merge_opt, the_repository);
     +-	init_merge_options(&merge_opt, the_repository);
     ++	init_basic_merge_options(&merge_opt, the_repository);
       	memset(&result, 0, sizeof(result));
       	merge_opt.show_rename_progress = 0;
     + 	last_commit = onto;
     +
     + ## builtin/stash.c ##
     +@@ builtin/stash.c: static int do_apply_stash(const char *prefix, struct stash_info *info,
     + 		}
     + 	}
     + 
     +-	init_merge_options(&o, the_repository);
     ++	init_ui_merge_options(&o, the_repository);
     + 
     + 	o.branch1 = "Updated upstream";
     + 	o.branch2 = "Stashed changes";
     +
     + ## log-tree.c ##
     +@@ log-tree.c: static int do_remerge_diff(struct rev_info *opt,
     + 	struct strbuf parent2_desc = STRBUF_INIT;
     + 
     + 	/* Setup merge options */
     +-	init_merge_options(&o, the_repository);
     ++	init_ui_merge_options(&o, the_repository);
     + 	o.show_rename_progress = 0;
     + 	o.record_conflict_msgs_as_headers = 1;
     + 	o.msg_header_prefix = "remerge";
      
       ## merge-recursive.c ##
     +@@ merge-recursive.c: int merge_recursive_generic(struct merge_options *opt,
     + 	return clean ? 0 : 1;
     + }
     + 
     +-static void merge_recursive_config(struct merge_options *opt)
     ++static void merge_recursive_config(struct merge_options *opt, int ui)
     + {
     + 	char *value = NULL;
     + 	int renormalize = 0;
      @@ merge-recursive.c: static void merge_recursive_config(struct merge_options *opt)
       		} /* avoid erroring on values from future versions of git */
       		free(value);
       	}
     -+	if (!git_config_get_string("diff.algorithm", &value)) {
     -+		long diff_algorithm = parse_algorithm_value(value);
     -+		if (diff_algorithm < 0)
     -+			die(_("unknown value for config '%s': %s"), "diff.algorithm", value);
     -+		opt->xdl_opts = (opt->xdl_opts & ~XDF_DIFF_ALGORITHM_MASK) | diff_algorithm;
     -+		free(value);
     ++	if (ui) {
     ++		if (!git_config_get_string("diff.algorithm", &value)) {
     ++			long diff_algorithm = parse_algorithm_value(value);
     ++			if (diff_algorithm < 0)
     ++				die(_("unknown value for config '%s': %s"), "diff.algorithm", value);
     ++			opt->xdl_opts = (opt->xdl_opts & ~XDF_DIFF_ALGORITHM_MASK) | diff_algorithm;
     ++			free(value);
     ++		}
      +	}
       	git_config(git_xmerge_config, NULL);
       }
       
     +-void init_merge_options(struct merge_options *opt,
     +-			struct repository *repo)
     ++static void init_merge_options(struct merge_options *opt,
     ++			struct repository *repo, int ui)
     + {
     + 	const char *merge_verbosity;
     + 	memset(opt, 0, sizeof(struct merge_options));
     +@@ merge-recursive.c: void init_merge_options(struct merge_options *opt,
     + 
     + 	opt->conflict_style = -1;
     + 
     +-	merge_recursive_config(opt);
     ++	merge_recursive_config(opt, ui);
     + 	merge_verbosity = getenv("GIT_MERGE_VERBOSITY");
     + 	if (merge_verbosity)
     + 		opt->verbosity = strtol(merge_verbosity, NULL, 10);
     +@@ merge-recursive.c: void init_merge_options(struct merge_options *opt,
     + 		opt->buffer_output = 0;
     + }
     + 
     ++void init_ui_merge_options(struct merge_options *opt,
     ++			struct repository *repo)
     ++{
     ++	init_merge_options(opt, repo, 1);
     ++}
     ++
     ++void init_basic_merge_options(struct merge_options *opt,
     ++			struct repository *repo)
     ++{
     ++	init_merge_options(opt, repo, 0);
     ++}
     ++
     + /*
     +  * For now, members of merge_options do not need deep copying, but
     +  * it may change in the future, in which case we would need to update
     +
     + ## merge-recursive.h ##
     +@@ merge-recursive.h: struct merge_options {
     + 	struct merge_options_internal *priv;
     + };
     + 
     +-void init_merge_options(struct merge_options *opt, struct repository *repo);
     ++/* for use by porcelain commands */
     ++void init_ui_merge_options(struct merge_options *opt, struct repository *repo);
     ++/* for use by plumbing commands */
     ++void init_basic_merge_options(struct merge_options *opt, struct repository *repo);
     + 
     + void copy_merge_options(struct merge_options *dst, struct merge_options *src);
     + void clear_merge_options(struct merge_options *opt);
     +
     + ## sequencer.c ##
     +@@ sequencer.c: static int do_recursive_merge(struct repository *r,
     + 
     + 	repo_read_index(r);
     + 
     +-	init_merge_options(&o, r);
     ++	init_ui_merge_options(&o, r);
     + 	o.ancestor = base ? base_label : "(empty tree)";
     + 	o.branch1 = "HEAD";
     + 	o.branch2 = next ? next_label : "(empty tree)";
     +@@ sequencer.c: static int do_merge(struct repository *r,
     + 	bases = reverse_commit_list(bases);
     + 
     + 	repo_read_index(r);
     +-	init_merge_options(&o, r);
     ++	init_ui_merge_options(&o, r);
     + 	o.branch1 = "HEAD";
     + 	o.branch2 = ref_name.buf;
     + 	o.buffer_output = 2;
      
       ## t/t3515-cherry-pick-diff.sh (new) ##
      @@


 builtin/am.c                |  2 +-
 builtin/checkout.c          |  2 +-
 builtin/merge-recursive.c   |  2 +-
 builtin/merge-tree.c        |  2 +-
 builtin/merge.c             |  2 +-
 builtin/replay.c            |  2 +-
 builtin/stash.c             |  2 +-
 log-tree.c                  |  2 +-
 merge-recursive.c           | 29 +++++++++++++++++++++----
 merge-recursive.h           |  5 ++++-
 sequencer.c                 |  4 ++--
 t/t3515-cherry-pick-diff.sh | 41 +++++++++++++++++++++++++++++++++++
 t/t3515/base.c              | 17 +++++++++++++++
 t/t3515/ours.c              | 17 +++++++++++++++
 t/t3515/theirs.c            | 17 +++++++++++++++
 t/t7615-merge-diff.sh       | 43 +++++++++++++++++++++++++++++++++++++
 16 files changed, 174 insertions(+), 15 deletions(-)
 create mode 100755 t/t3515-cherry-pick-diff.sh
 create mode 100644 t/t3515/base.c
 create mode 100644 t/t3515/ours.c
 create mode 100644 t/t3515/theirs.c
 create mode 100755 t/t7615-merge-diff.sh

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
diff --git a/t/t3515-cherry-pick-diff.sh b/t/t3515-cherry-pick-diff.sh
new file mode 100755
index 00000000000..caeaa01c590
--- /dev/null
+++ b/t/t3515-cherry-pick-diff.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+
+test_description='git cherry-pick
+
+Testing the influence of the diff algorithm on the merge output.'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	cp "$TEST_DIRECTORY"/t3515/base.c file.c &&
+	git add file.c &&
+	git commit -m c0 &&
+	git tag c0 &&
+	cp "$TEST_DIRECTORY"/t3515/ours.c file.c &&
+	git add file.c &&
+	git commit -m c1 &&
+	git tag c1 &&
+	git reset --hard c0 &&
+	cp "$TEST_DIRECTORY"/t3515/theirs.c file.c &&
+	git add file.c &&
+	git commit -m c2 &&
+	git tag c2
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
+test_done
diff --git a/t/t3515/base.c b/t/t3515/base.c
new file mode 100644
index 00000000000..c64abc59366
--- /dev/null
+++ b/t/t3515/base.c
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
diff --git a/t/t3515/ours.c b/t/t3515/ours.c
new file mode 100644
index 00000000000..44d82513970
--- /dev/null
+++ b/t/t3515/ours.c
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
diff --git a/t/t3515/theirs.c b/t/t3515/theirs.c
new file mode 100644
index 00000000000..85f02146fee
--- /dev/null
+++ b/t/t3515/theirs.c
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
diff --git a/t/t7615-merge-diff.sh b/t/t7615-merge-diff.sh
new file mode 100755
index 00000000000..be335c7c3d1
--- /dev/null
+++ b/t/t7615-merge-diff.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+
+test_description='git merge
+
+Testing the influence of the diff algorithm on the merge output.'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	cp "$TEST_DIRECTORY"/t3515/base.c file.c &&
+	git add file.c &&
+	git commit -m c0 &&
+	git tag c0 &&
+	cp "$TEST_DIRECTORY"/t3515/ours.c file.c &&
+	git add file.c &&
+	git commit -m c1 &&
+	git tag c1 &&
+	git reset --hard c0 &&
+	cp "$TEST_DIRECTORY"/t3515/theirs.c file.c &&
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
+test_done

base-commit: 06e570c0dfb2a2deb64d217db78e2ec21672f558
-- 
gitgitgadget

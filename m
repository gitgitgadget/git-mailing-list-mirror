Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C571363C73
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 11:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776251522; cv=none; b=cG2lPkJ9REsfO8njUOW9GSfdnZbvenqsvBCVIG8MjUaWsuzeunWFz0IjC17rDE3frsy2hl8fsLIPCKo5RqzUipGtoGCXnpK6auwrhmq4FyaivAjq4PEzhPiitlevR2u6pNoA1b0O7yv7IaNPtGIQJnjM1/4eWlXGigRSqdo4pF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776251522; c=relaxed/simple;
	bh=Mm5UxApJFCFp2PvbHaiNil4FNevHPZ2Js0PNFWjAWMM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pFVq9OvuIGm/W2wtkamUXkYSZqItSwLfMg9JBD9kQMHOzQMmq3qlcdK0cn36OlH9AVRlw7IZE8xHetKjbSys+tqUhRQoajW8P5uSHDd5cOZG9i4FJrHGFuj4uOhknziBazVMSvyOgD2wBpAqcBMj+aSeVwcu1+XFybL3YPl0WP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxAt/Rr3; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxAt/Rr3"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8a58057d7baso71505946d6.1
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 04:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776251519; x=1776856319; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zv4a9qYB+oha3Jojko0Q2Xx7zIaGaNrmfs70/vnG+YQ=;
        b=VxAt/Rr3ALJrTFIRgN9TUCHkwLTJnksokBAGKsBsmQQwyS5VV//38GfkGoMli1IE5n
         ZvciLkjVI1ojkAYiuwvIRnDEssdi5hOuWh7G3FXyZdkTV/v0xu4C1tFLNZ6xrV3ealWa
         paIlV8r9/ynSUobBWpHIMrS29XXkSPKMerOHV9q0EF5aFXR/2TKA6/iFJa2Et2AhkY1i
         6riSqpmf5LPFugvIfwquq1d2dDOjTFpBftSQT/ruKiioGbVMOP2tOrZuSePG9a4zsTmE
         A5bXPqlcqc6zxjlrrz1gIaC9VYke4fwb1utDetOOJgon7ERnXyiiENA++XVaKvSCQ3Gz
         soYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776251519; x=1776856319;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zv4a9qYB+oha3Jojko0Q2Xx7zIaGaNrmfs70/vnG+YQ=;
        b=fDGVYaNbwFMkHqqUACeN6Dnbsp51GYrRsbFFUHtsPkR62WfeTkb0H/+B5s7lfAtbme
         O8IRJQdsHT5OnCWBcFXviaXFyBcINDMzLj1QRRWibDuPR7ZjZD37T3bFZGcJczKMFxj/
         QQdXY+9DuYE/VPQl7Zan8F0kEeMwyv9smKiX/Jgeev2gBX3cCQPEf+pqH6fSAdL8U2iW
         FAs70IX5xN2bJmt5ElqYSa2A14filPzunyttNPhhpRmXUVDF+Pk9NMb7jFHLSjqx7u1V
         H28ghkBZD1LCiQ2fOW2/lQH5n+rluQTlapEfep7zNyKRPziHGP8BFYlYQEvE8GF/lVs/
         drMg==
X-Gm-Message-State: AOJu0YxeWCB97TPP9PrR2ZFJR9JZgKaxpnO93BtB4bzFBKcf2cKDSKGE
	2QCjScemNHtIbPTix+jnLPrP457t81cXdcoZvXjEZ/PSG7covWwa2dUSMmJn8w==
X-Gm-Gg: AeBDietufwLVYFVQ/QtYj+/oHlbA/FyCoXABGBlU9aDE31Yvg5vNKpSjkLUJvvuqgZt
	p6urvwSYb707lg1jo/+zskNcl6sf1hFVXXjEok7r+y7vP4TkDKs/VT/40bR7oHkG17luQdSxZVq
	UA89W6ORAJgf6Yk/LskeQ4g2DZAf7KEzyLws+sIpUXOr2hftknYohyMByGaPBcVU9rXobuBVXQc
	q41uHAbCSzXmuGTdqp//gDg3jEQwQY6JRK4zEI4cmmfN1ogZGArV4NzBgiezZxYbo57Bwa7FLGK
	61MJzusKD5Se1FmyDla3IUtsLUNCF6g97VmyTFR1ywgNX9rUc74cngVX5tv/FOVkwI1UjZ1taLj
	HA2OI7uGNua+p0h6AlCkPWHCYaxRfaA0/bc5JNDsUUZHGHQkn0M4Zc0sXC1x8IjTCU6A05GfCBt
	7NZkYdfd1hrkQBNZmOAzer3H5Q+sac
X-Received: by 2002:a05:6214:d4f:b0:8ac:bae5:7477 with SMTP id 6a1803df08f44-8acbae57d27mr130378856d6.26.1776251518901;
        Wed, 15 Apr 2026 04:11:58 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.227.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6cb9eb92sm9100486d6.24.2026.04.15.04.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 04:11:58 -0700 (PDT)
Message-Id: <pull.2234.v13.git.git.1776251517.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v12.git.git.1776171585.gitgitgadget@gmail.com>
References: <pull.2234.v12.git.git.1776171585.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 11:11:52 +0000
Subject: [PATCH v13 0/5] checkout: 'autostash' for branch switching
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
    Jeff King <peff@peff.net>,
    Harald Nordgren <haraldnordgren@gmail.com>

Handling the review comments from Phillip Wood and JCH.

The ones I struggled to fix I commented on on the mailing list instead, wuld
be nice to get some feedback on my proposed fixes 🤗

Harald Nordgren (5):
  stash: add --label-ours, --label-theirs, --label-base for apply
  sequencer: allow create_autostash to run silently
  sequencer: teach autostash apply to take optional conflict marker
    labels
  checkout: rollback lock on early returns in merge_working_tree
  checkout -m: autostash when switching branches

 Documentation/git-checkout.adoc |  58 ++++-----
 Documentation/git-stash.adoc    |  11 +-
 Documentation/git-switch.adoc   |  33 ++---
 builtin/checkout.c              | 149 +++++++++++------------
 builtin/commit.c                |   3 +-
 builtin/merge.c                 |  15 ++-
 builtin/stash.c                 |  28 +++--
 sequencer.c                     |  73 ++++++++---
 sequencer.h                     |   7 +-
 t/t3420-rebase-autostash.sh     |  24 +++-
 t/t3903-stash.sh                |  25 ++++
 t/t7201-co.sh                   | 208 ++++++++++++++++++++++++++++++++
 t/t7600-merge.sh                |   2 +-
 xdiff-interface.c               |  12 ++
 xdiff-interface.h               |   1 +
 xdiff/xmerge.c                  |   6 +-
 16 files changed, 484 insertions(+), 171 deletions(-)


base-commit: 9e8f4e9c04e3efa494e78b710e0c5f6cc77a0a5e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2234%2FHaraldNordgren%2Fcheckout_autostash-v13
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2234/HaraldNordgren/checkout_autostash-v13
Pull-Request: https://github.com/git/git/pull/2234

Range-diff vs v12:

 1:  9ab5431b47 ! 1:  43bfdf2136 stash: add --label-ours, --label-theirs, --label-base for apply
     @@ builtin/stash.c
       	N_("git stash branch <branchname> [<stash>]")
       #define BUILTIN_STASH_STORE_USAGE \
      @@ builtin/stash.c: static void unstage_changes_unless_new(struct object_id *orig_tree)
     - 		die(_("could not write index"));
       }
       
     --static int do_apply_stash(const char *prefix, struct stash_info *info,
     + static int do_apply_stash(const char *prefix, struct stash_info *info,
      -			  int index, int quiet)
     -+static int do_apply_stash_with_labels(const char *prefix,
     -+				      struct stash_info *info,
     -+				      int index, int quiet,
     -+				      const char *label_ours, const char *label_theirs,
     -+				      const char *label_base)
     ++			  int index, int quiet,
     ++			  const char *label_ours, const char *label_theirs,
     ++			  const char *label_base)
       {
       	int clean, ret;
       	int has_index = index;
     @@ builtin/stash.c: static int do_apply_stash(const char *prefix, struct stash_info
       
       	if (oideq(&info->b_tree, &c_tree))
       		o.branch1 = "Version stash was based on";
     -@@ builtin/stash.c: restore_untracked:
     - 	return ret;
     - }
     - 
     -+static int do_apply_stash(const char *prefix, struct stash_info *info,
     -+			  int index, int quiet)
     -+{
     -+	return do_apply_stash_with_labels(prefix, info, index, quiet,
     -+					  NULL, NULL, NULL);
     -+}
     -+
     - static int apply_stash(int argc, const char **argv, const char *prefix,
     - 		       struct repository *repo UNUSED)
     - {
     +@@ builtin/stash.c: static int apply_stash(int argc, const char **argv, const char *prefix,
       	int ret = -1;
       	int quiet = 0;
       	int index = use_index;
     @@ builtin/stash.c: static int apply_stash(int argc, const char **argv, const char
       		goto cleanup;
       
      -	ret = do_apply_stash(prefix, &info, index, quiet);
     -+	ret = do_apply_stash_with_labels(prefix, &info, index, quiet,
     -+					 label_ours, label_theirs, label_base);
     ++	ret = do_apply_stash(prefix, &info, index, quiet,
     ++			     label_ours, label_theirs, label_base);
       cleanup:
       	free_stash_info(&info);
       	return ret;
     +@@ builtin/stash.c: static int pop_stash(int argc, const char **argv, const char *prefix,
     + 	if (get_stash_info_assert(&info, argc, argv))
     + 		goto cleanup;
     + 
     +-	if ((ret = do_apply_stash(prefix, &info, index, quiet)))
     ++	if ((ret = do_apply_stash(prefix, &info, index, quiet,
     ++				  NULL, NULL, NULL)))
     + 		printf_ln(_("The stash entry is kept in case "
     + 			    "you need it again."));
     + 	else
     +@@ builtin/stash.c: static int branch_stash(int argc, const char **argv, const char *prefix,
     + 	strvec_push(&cp.args, oid_to_hex(&info.b_commit));
     + 	ret = run_command(&cp);
     + 	if (!ret)
     +-		ret = do_apply_stash(prefix, &info, 1, 0);
     ++		ret = do_apply_stash(prefix, &info, 1, 0,
     ++				     NULL, NULL, NULL);
     + 	if (!ret && info.is_stash_ref)
     + 		ret = do_drop_stash(&info, 0);
     + 
      
       ## t/t3903-stash.sh ##
      @@ t/t3903-stash.sh: test_expect_success 'restore untracked files even when we hit conflicts' '
     @@ t/t3903-stash.sh: test_expect_success 'restore untracked files even when we hit
       '
       
      +test_expect_success 'apply with custom conflict labels' '
     -+	git init conflict_labels &&
     -+	(
     -+		cd conflict_labels &&
     -+		test_commit base file &&
     -+		echo stashed >file &&
     -+		git stash push -m "stashed" &&
     -+		test_commit upstream file &&
     -+		test_must_fail git -c merge.conflictStyle=diff3 stash apply --label-ours=UP --label-theirs=STASH &&
     -+		test_grep "^<<<<<<< UP" file &&
     -+		test_grep "^||||||| Stash base" file &&
     -+		test_grep "^>>>>>>> STASH" file
     -+	)
     ++	test_when_finished "git reset --hard && git stash drop" &&
     ++	git reset --hard &&
     ++	test_commit label-base conflict-file base-content &&
     ++	echo stashed >conflict-file &&
     ++	git stash push -m "stashed" &&
     ++	test_commit label-upstream conflict-file upstream-content &&
     ++	test_must_fail git -c merge.conflictStyle=diff3 stash apply --label-ours=UP --label-theirs=STASH &&
     ++	test_grep "^<<<<<<< UP" conflict-file &&
     ++	test_grep "^||||||| Stash base" conflict-file &&
     ++	test_grep "^>>>>>>> STASH" conflict-file
      +'
      +
      +test_expect_success 'apply with empty conflict labels' '
     -+	git init empty_labels &&
     -+	(
     -+		cd empty_labels &&
     -+		test_commit base file &&
     -+		echo stashed >file &&
     -+		git stash push -m "stashed" &&
     -+		test_commit upstream file &&
     -+		test_must_fail git stash apply --label-ours= --label-theirs= &&
     -+		test_grep "^<<<<<<<$" file &&
     -+		test_grep "^>>>>>>>$" file
     -+	)
     ++	test_when_finished "git reset --hard && git stash drop" &&
     ++	git reset --hard &&
     ++	test_commit empty-label-base conflict-file base-content &&
     ++	echo stashed >conflict-file &&
     ++	git stash push -m "stashed" &&
     ++	test_commit empty-label-upstream conflict-file upstream-content &&
     ++	test_must_fail git stash apply --label-ours= --label-theirs= &&
     ++	test_grep "^<<<<<<<$" conflict-file &&
     ++	test_grep "^>>>>>>>$" conflict-file
      +'
      +
       test_expect_success 'stash create reports a locked index' '
 2:  e11a622bdf ! 2:  7f3c32f5e9 sequencer: allow create_autostash to run silently
     @@ Commit message
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     + ## builtin/merge.c ##
     +@@ builtin/merge.c: int cmd_merge(int argc,
     + 		}
     + 
     + 		if (autostash)
     +-			create_autostash_ref(the_repository, "MERGE_AUTOSTASH");
     ++			create_autostash_ref(the_repository, "MERGE_AUTOSTASH",
     ++					     NULL, false);
     + 		if (checkout_fast_forward(the_repository,
     + 					  &head_commit->object.oid,
     + 					  &commit->object.oid,
     +@@ builtin/merge.c: int cmd_merge(int argc,
     + 		die_ff_impossible();
     + 
     + 	if (autostash)
     +-		create_autostash_ref(the_repository, "MERGE_AUTOSTASH");
     ++		create_autostash_ref(the_repository, "MERGE_AUTOSTASH",
     ++				     NULL, false);
     + 
     + 	/* We are going to make a new commit. */
     + 	git_committer_info(IDENT_STRICT);
     +
       ## sequencer.c ##
      @@ sequencer.c: static enum todo_command peek_command(struct todo_list *todo_list, int offset)
       
     @@ sequencer.c: static void create_autostash_internal(struct repository *r,
      +	create_autostash_internal(r, path, NULL, NULL, false);
       }
       
     - void create_autostash_ref(struct repository *r, const char *refname)
     +-void create_autostash_ref(struct repository *r, const char *refname)
     ++void create_autostash_ref(struct repository *r, const char *refname,
     ++			  const char *message, bool silent)
       {
      -	create_autostash_internal(r, NULL, refname);
     -+	create_autostash_internal(r, NULL, refname, NULL, false);
     -+}
     -+
     -+void create_autostash_ref_with_msg_silent(struct repository *r, const char *refname,
     -+				 const char *message)
     -+{
     -+	create_autostash_internal(r, NULL, refname, message, true);
     ++	create_autostash_internal(r, NULL, refname, message, silent);
       }
       
       static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
      
       ## sequencer.h ##
      @@ sequencer.h: void commit_post_rewrite(struct repository *r,
     + 			 const struct object_id *new_head);
       
       void create_autostash(struct repository *r, const char *path);
     - void create_autostash_ref(struct repository *r, const char *refname);
     -+void create_autostash_ref_with_msg_silent(struct repository *r, const char *refname,
     -+				 const char *message);
     +-void create_autostash_ref(struct repository *r, const char *refname);
     ++void create_autostash_ref(struct repository *r, const char *refname,
     ++			  const char *message, bool silent);
       int save_autostash(const char *path);
       int save_autostash_ref(struct repository *r, const char *refname);
       int apply_autostash(const char *path);
 3:  4593745e90 ! 3:  b279d1dac8 sequencer: teach autostash apply to take optional conflict marker labels
     @@ Metadata
       ## Commit message ##
          sequencer: teach autostash apply to take optional conflict marker labels
      
     -    Add label_ours, label_theirs, and label_base parameters to the autostash
     -    apply machinery so callers can pass custom conflict marker labels
     -    through to "git stash apply --label-ours/--label-theirs/--label-base".
     -    Introduce apply_autostash_ref_with_labels() for callers that want
     -    to pass labels.
     +    Add label_ours, label_theirs, label_base, and stash_msg parameters to
     +    apply_autostash_ref() and the autostash apply machinery so callers can
     +    pass custom conflict marker labels through to
     +    "git stash apply --label-ours/--label-theirs/--label-base", as well as
     +    a custom stash message for "git stash store -m".
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     + ## builtin/commit.c ##
     +@@ builtin/commit.c: int cmd_commit(int argc,
     + 				     &oid, flags);
     + 	}
     + 
     +-	apply_autostash_ref(the_repository, "MERGE_AUTOSTASH");
     ++	apply_autostash_ref(the_repository, "MERGE_AUTOSTASH",
     ++			    NULL, NULL, NULL, NULL);
     + 
     + cleanup:
     + 	free_commit_extra_headers(extra);
     +
     + ## builtin/merge.c ##
     +@@ builtin/merge.c: static void finish(struct commit *head_commit,
     + 	run_hooks_l(the_repository, "post-merge", squash ? "1" : "0", NULL);
     + 
     + 	if (new_head)
     +-		apply_autostash_ref(the_repository, "MERGE_AUTOSTASH");
     ++		apply_autostash_ref(the_repository, "MERGE_AUTOSTASH",
     ++				    NULL, NULL, NULL, NULL);
     + 	strbuf_release(&reflog_message);
     + }
     + 
     +@@ builtin/merge.c: int cmd_merge(int argc,
     + 					  &head_commit->object.oid,
     + 					  &commit->object.oid,
     + 					  overwrite_ignore)) {
     +-			apply_autostash_ref(the_repository, "MERGE_AUTOSTASH");
     ++			apply_autostash_ref(the_repository, "MERGE_AUTOSTASH",
     ++					    NULL, NULL, NULL, NULL);
     + 			ret = 1;
     + 			goto done;
     + 		}
     +@@ builtin/merge.c: int cmd_merge(int argc,
     + 		else
     + 			fprintf(stderr, _("Merge with strategy %s failed.\n"),
     + 				use_strategies[0]->name);
     +-		apply_autostash_ref(the_repository, "MERGE_AUTOSTASH");
     ++		apply_autostash_ref(the_repository, "MERGE_AUTOSTASH",
     ++				    NULL, NULL, NULL, NULL);
     + 		ret = 2;
     + 		goto done;
     + 	} else if (best_strategy == wt_strategy)
     +
       ## sequencer.c ##
     -@@ sequencer.c: void create_autostash_ref_with_msg_silent(struct repository *r, const char *refn
     - 	create_autostash_internal(r, NULL, refname, message, true);
     +@@ sequencer.c: void create_autostash_ref(struct repository *r, const char *refname,
     + 	create_autostash_internal(r, NULL, refname, message, silent);
       }
       
      -static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
     @@ sequencer.c: static int apply_save_autostash_ref(struct repository *r, const cha
      +					NULL, NULL, NULL, NULL);
       }
       
     - int apply_autostash_ref(struct repository *r, const char *refname)
     +-int apply_autostash_ref(struct repository *r, const char *refname)
     ++int apply_autostash_ref(struct repository *r, const char *refname,
     ++			const char *label_ours, const char *label_theirs,
     ++			const char *label_base, const char *stash_msg)
       {
      -	return apply_save_autostash_ref(r, refname, 1);
      +	return apply_save_autostash_ref(r, refname, 1,
     -+					NULL, NULL, NULL, NULL);
     -+}
     -+
     -+int apply_autostash_ref_with_labels(struct repository *r, const char *refname,
     -+				    const char *label_ours, const char *label_theirs,
     -+				    const char *label_base,
     -+				    const char *stash_msg)
     -+{
     -+	return apply_save_autostash_ref(r, refname, 1,
      +					label_ours, label_theirs, label_base,
      +					stash_msg);
       }
     @@ sequencer.c: static int apply_save_autostash_ref(struct repository *r, const cha
       static int checkout_onto(struct repository *r, struct replay_opts *opts,
      
       ## sequencer.h ##
     -@@ sequencer.h: int save_autostash_ref(struct repository *r, const char *refname);
     +@@ sequencer.h: int save_autostash(const char *path);
     + int save_autostash_ref(struct repository *r, const char *refname);
       int apply_autostash(const char *path);
       int apply_autostash_oid(const char *stash_oid);
     - int apply_autostash_ref(struct repository *r, const char *refname);
     -+int apply_autostash_ref_with_labels(struct repository *r, const char *refname,
     -+				    const char *label_ours, const char *label_theirs,
     -+				    const char *label_base,
     -+				    const char *stash_msg);
     +-int apply_autostash_ref(struct repository *r, const char *refname);
     ++int apply_autostash_ref(struct repository *r, const char *refname,
     ++			const char *label_ours, const char *label_theirs,
     ++			const char *label_base, const char *stash_msg);
       
       #define SUMMARY_INITIAL_COMMIT   (1 << 0)
       #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
 -:  ---------- > 4:  04869314ec checkout: rollback lock on early returns in merge_working_tree
 4:  911e520431 ! 5:  4b3c6025ac checkout: -m (--merge) uses autostash when switching branches
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    checkout: -m (--merge) uses autostash when switching branches
     +    checkout -m: autostash when switching branches
      
     -    When switching branches with "git checkout -m", local modifications
     -    can block the switch.  Teach the -m flow to create a temporary stash
     -    before switching and reapply it after.  On success, only "Applied
     -    autostash." is shown.  If reapplying causes conflicts, the stash is
     -    kept and the user is told they can resolve and run "git stash drop",
     -    or run "git reset --hard" and later "git stash pop" to recover their
     -    changes.
     +    When switching branches with "git checkout -m", the attempted merge
     +    of local modifications may cause conflicts with the changes made on
     +    the other branch, which the user may not want to (or may not be able
     +    to) resolve right now.  Because there is no easy way to recover from
     +    this situation, we discouraged users from using "checkout -m" unless
     +    they are certain their changes are trivial and within their ability
     +    to resolve conflicts.
     +
     +    Teach the -m flow to create a temporary stash before switching and
     +    reapply it after.  On success, the stash is silently applied and
     +    the list of locally modified paths is shown, same as a successful
     +    "git checkout" without "-m".
     +
     +    If reapplying causes conflicts, the stash is kept and the user is
     +    told they can resolve and run "git stash drop", or run "git reset
     +    --hard" and later "git stash pop" to recover their changes.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ builtin/checkout.c
       #include "setup.h"
       #include "submodule.h"
       #include "symlinks.h"
     -@@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *opts,
     - 	struct tree *new_tree;
     - 
     - 	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
     --	if (repo_read_index_preload(the_repository, NULL, 0) < 0)
     -+	if (repo_read_index_preload(the_repository, NULL, 0) < 0) {
     -+		rollback_lock_file(&lock_file);
     - 		return error(_("index file corrupt"));
     -+	}
     - 
     - 	resolve_undo_clear_index(the_repository->index);
     - 	if (opts->new_orphan_branch && opts->orphan_from_empty_tree) {
     -@@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *opts,
     - 	} else {
     - 		new_tree = repo_get_commit_tree(the_repository,
     - 						new_branch_info->commit);
     --		if (!new_tree)
     -+		if (!new_tree) {
     -+			rollback_lock_file(&lock_file);
     - 			return error(_("unable to read tree (%s)"),
     - 				     oid_to_hex(&new_branch_info->commit->object.oid));
     -+		}
     - 	}
     - 	if (opts->discard_changes) {
     - 		ret = reset_tree(new_tree, opts, 1, writeout_error, new_branch_info);
     --		if (ret)
     -+		if (ret) {
     -+			rollback_lock_file(&lock_file);
     - 			return ret;
     -+		}
     - 	} else {
     - 		struct tree_desc trees[2];
     - 		struct tree *tree;
     -@@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *opts,
     - 		refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL, NULL);
     - 
     - 		if (unmerged_index(the_repository->index)) {
     -+			rollback_lock_file(&lock_file);
     - 			error(_("you need to resolve your current index first"));
     - 			return 1;
     - 		}
      @@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *opts,
       		ret = unpack_trees(2, trees, &topts);
       		clear_unpack_trees_porcelain(&topts);
     @@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *op
      -			struct strbuf sb = STRBUF_INIT;
      -			struct strbuf old_commit_shortname = STRBUF_INIT;
      -
     --			if (!opts->merge)
     +-			if (!opts->merge) {
     +-				rollback_lock_file(&lock_file);
      -				return 1;
     +-			}
      -
      -			/*
      -			 * Without old_branch_info->commit, the below is the same as
      -			 * the two-tree unpack we already tried and failed.
      -			 */
     --			if (!old_branch_info->commit)
     +-			if (!old_branch_info->commit) {
     +-				rollback_lock_file(&lock_file);
      -				return 1;
     +-			}
      -			old_tree = repo_get_commit_tree(the_repository,
      -							old_branch_info->commit);
      -
     @@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *op
      -			ret = reset_tree(new_tree,
      -					 opts, 1,
      -					 writeout_error, new_branch_info);
     --			if (ret)
     +-			if (ret) {
     +-				rollback_lock_file(&lock_file);
      -				return ret;
     +-			}
      -			o.ancestor = old_branch_info->name;
      -			if (!old_branch_info->name) {
      -				strbuf_add_unique_abbrev(&old_commit_shortname,
     @@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *op
      -					 writeout_error, new_branch_info);
      -			strbuf_release(&o.obuf);
      -			strbuf_release(&old_commit_shortname);
     --			if (ret)
     +-			if (ret) {
     +-				rollback_lock_file(&lock_file);
      -				return ret;
     +-			}
      +			rollback_lock_file(&lock_file);
     -+			return 1;
     ++			return ret;
       		}
       	}
       
     @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
      +
       	if (do_merge) {
       		ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
     -+		if (ret && opts->merge) {
     ++		if (ret == -1 && opts->merge) {
      +			strbuf_addf(&autostash_msg,
      +				    "autostash while switching to '%s'",
      +				    new_branch_info->name);
     -+			create_autostash_ref_with_msg_silent(the_repository,
     -+						   "CHECKOUT_AUTOSTASH_HEAD",
     -+						   autostash_msg.buf);
     ++			create_autostash_ref(the_repository,
     ++					     "CHECKOUT_AUTOSTASH_HEAD",
     ++					     autostash_msg.buf, true);
      +			created_autostash = 1;
      +			ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
      +		}
       		if (ret) {
     -+			apply_autostash_ref_with_labels(the_repository,
     -+						       "CHECKOUT_AUTOSTASH_HEAD",
     -+						       new_branch_info->name,
     -+						       "local",
     -+						       stash_label_base,
     -+						       autostash_msg.len ? autostash_msg.buf : NULL);
     ++			if (created_autostash)
     ++				apply_autostash_ref(the_repository,
     ++						    "CHECKOUT_AUTOSTASH_HEAD",
     ++						    new_branch_info->name,
     ++						    "local",
     ++						    stash_label_base,
     ++						    autostash_msg.buf);
       			branch_info_release(&old_branch_info);
     +-			return ret;
      +			strbuf_release(&old_commit_shortname);
      +			strbuf_release(&autostash_msg);
     - 			return ret;
     ++			return ret < 0 ? 1 : ret;
       		}
       	}
     + 
      @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
       
       	update_refs_for_switch(opts, &old_branch_info, new_branch_info);
     @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
      +		git_config_push_parameter(cfg.buf);
      +		strbuf_release(&cfg);
      +	}
     -+	apply_autostash_ref_with_labels(the_repository, "CHECKOUT_AUTOSTASH_HEAD",
     -+				       new_branch_info->name, "local",
     -+				       stash_label_base,
     -+				       autostash_msg.len ? autostash_msg.buf : NULL);
     ++	apply_autostash_ref(the_repository, "CHECKOUT_AUTOSTASH_HEAD",
     ++			    new_branch_info->name, "local",
     ++			    stash_label_base,
     ++			    autostash_msg.buf);
      +
      +	discard_index(the_repository->index);
      +	if (repo_read_index(the_repository) < 0)
      +		die(_("index file corrupt"));
      +
     -+	if (created_autostash && !opts->discard_changes && !opts->quiet &&
     -+	    new_branch_info->commit)
     ++	if (created_autostash && !opts->quiet && new_branch_info->commit)
      +		show_local_changes(&new_branch_info->commit->object,
      +				   &opts->diff_options);
      +

-- 
gitgitgadget

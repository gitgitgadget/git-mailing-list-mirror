Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1392C3A7F55
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 21:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775854880; cv=none; b=hDBh2e92Nk/Iv1TBiPsJQy2TYCDzgt4qV2FXVD+AVRWzOuvA8UaIvOHQtZbHElmZyxaCuYipVWZylc9BKyyy/tq4OsH4B9/DJ5MjR++HEfrsTxYm9kumgzsCrkN8SVohcP6CDrFU8mEXqrMDRYIMwsBFmD4evfImDsCPUn5gMUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775854880; c=relaxed/simple;
	bh=mRKiB1jsALOv2+RxNzDxPmpJqIFfSiWTni/fVNSt5Jc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=vA2EYPbNpLU+e+uq2sdYpSYRWbNPqNWeNt/ML81BpR+ImWikghqi5zRM8Wx7u0658lUkQdPac3O++ZCbYhVlyfDOKEw017vztqLVjgVNt6oN89B0M7W1+3XI3E0PYj9yl2xvLwUCN0bLVUgYPSN1wrCCG4AC3hrrj0l6Je3HZ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8yCLI6Q; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8yCLI6Q"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-89e8e352dc1so13449186d6.1
        for <git@vger.kernel.org>; Fri, 10 Apr 2026 14:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775854876; x=1776459676; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dw48wc1EqSKxdleiljnG0SmFnbzTTv/xWO9yyNTS9Ug=;
        b=B8yCLI6QgkHeW9yc7Qq2rgIMN7yUskxhq8PVNnDAU9jxon/lDqDG5NedRDIeMfy5pB
         r8iOrGD3eK9uxQ4YQ7Flcny5ihEF8NQzCLsrUHQ010vq94NzhAAA71C/+G0TH4Ai2fGr
         DxbwTCKWzXMcDXeOwuiCtcF3CrO8EWGplBZsZeAEuJrCRlZ2I5zGo0u9KLYRbLpkENRV
         dRPKUHt4s10cppHrvx0o6P4kJvG4ja/H5mgkzTkxdtF27ukAOWrLgK+LLYOTmiW4cPlO
         8heyoDHAKZSv7relIzjf7wB+F+GN//1w0cfnmbNSJw7a5dC+EWnyHlbAfwwhjeMk5//G
         0jWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775854876; x=1776459676;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dw48wc1EqSKxdleiljnG0SmFnbzTTv/xWO9yyNTS9Ug=;
        b=XBTF0JLuaCh7J5ljXAtiIkh3uIedtSR3Qttbh9yezU8xe7rEC2UJhE4CrxGfLL9BzJ
         5HWUpMNYV4wTUDvxGtugFTqXD9E6KL62yEc4xu/eJZTyeAMucjs396JnwpnXycay150n
         IFPNqOhXPZ5yrfe9n2O11ox1S0SAqb0fk/0/JpFl5KbRbJqKCeqd7n5r1wxyLTEFPUrG
         a6pTiq6wt+bvPncEJrTn9RjLE/DP/eH87P9b/wS4lFInq4+JkHxQG+U7ZN4aHebCUo8a
         EMZIJU6nRchkDiu+d3NLtsqmUUh1wQPnVcjsFgOcY6nyyKRgJSK9ldWV4xqE21yBMWJa
         Cqiw==
X-Gm-Message-State: AOJu0YxfPKmwWcrkeS9OrNWvXFdMPDkXPdudw28MC6a1+9i9ypiWPFkH
	tzIDnAQSysrrJFEhs6IafDPhpK/6cCH9nqOCzjqxs4PYJjmpRZjHk076bkgLmA==
X-Gm-Gg: AeBDiesgDOjraFj1dYQ2zgbSpl+bSOFhTgs3mBWC7xHVXhYzPNT3f4/XHMe6oX0eryR
	EWoJ6pj3bjhRGur7OMDLOs//8zHZGPQDeAnk6+5KDJtr13xVqOFAWhSnPvd7OVxoOAEOVfhYHAk
	zgsEJi0vgHfQlBt/1y6DI1xJaOGMs6oKMbiOYNE+wWC8VGpJwpX+k8Ku/TLYUdGxqYm6so7kxk+
	E2GC+mV8GTMJPGZ2FqWf0JvBN+RXQAsfJ5WajbZiaTrspr8Lm4amub4ZMn7ibsEU3hti/ziUzj1
	UiJB3GQCw+C+5gTHaG4E5481MxXnjXjxLBvoUojM5T5VopSqd5jGEarT8eKSHD0koR7G6vxN0Qd
	rDyqbcK5Oh584ijnYteoDfhONdMjOp2+vzzte7NKVGAXgNcQe1y5V3+jOk1/1pN/uXM2OqnegES
	WmARSrSfhMyXMpVK9/uCtJQ2sxLw==
X-Received: by 2002:a0c:e017:0:b0:89c:4d3e:fa41 with SMTP id 6a1803df08f44-8ac860e881bmr61348036d6.12.1775854875915;
        Fri, 10 Apr 2026 14:01:15 -0700 (PDT)
Received: from [127.0.0.1] ([52.150.30.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84a37f1csm32486396d6.18.2026.04.10.14.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 14:01:14 -0700 (PDT)
Message-Id: <pull.2234.v9.git.git.1775854874.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v8.git.git.1775762235.gitgitgadget@gmail.com>
References: <pull.2234.v8.git.git.1775762235.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Apr 2026 21:01:09 +0000
Subject: [PATCH v9 0/4] checkout: 'autostash' for branch switching
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
    Harald Nordgren <haraldnordgren@gmail.com>

Harald Nordgren (4):
  stash: add --label-ours, --label-theirs, --label-base for apply
  sequencer: allow create_autostash to run silently
  sequencer: teach autostash apply to take optional conflict marker
    labels
  checkout: -m (--merge) uses autostash when switching branches

 Documentation/git-checkout.adoc |  58 +++++-----
 Documentation/git-stash.adoc    |  11 +-
 Documentation/git-switch.adoc   |  33 +++---
 builtin/checkout.c              | 138 ++++++++++------------
 builtin/stash.c                 |  32 ++++--
 sequencer.c                     |  67 ++++++++---
 sequencer.h                     |   4 +
 t/t3420-rebase-autostash.sh     |  24 +++-
 t/t3903-stash.sh                |  29 +++++
 t/t7201-co.sh                   | 195 ++++++++++++++++++++++++++++++++
 t/t7600-merge.sh                |   2 +-
 xdiff-interface.c               |  12 ++
 xdiff-interface.h               |   1 +
 xdiff/xmerge.c                  |   6 +-
 14 files changed, 455 insertions(+), 157 deletions(-)


base-commit: cd412a49627774a14b3e49237109a77bd3ea70c0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2234%2FHaraldNordgren%2Fcheckout_autostash-v9
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2234/HaraldNordgren/checkout_autostash-v9
Pull-Request: https://github.com/git/git/pull/2234

Range-diff vs v8:

 1:  8fcf377820 ! 1:  5d5dc1f60e stash: add --ours-label, --theirs-label, --base-label for apply
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    stash: add --ours-label, --theirs-label, --base-label for apply
     +    stash: add --label-ours, --label-theirs, --label-base for apply
      
          Allow callers of "git stash apply" to pass custom labels for conflict
          markers instead of the default "Updated upstream" and "Stashed changes".
     @@ Documentation/git-stash.adoc: git stash list [<log-options>]
       git stash drop [-q | --quiet] [<stash>]
       git stash pop [--index] [-q | --quiet] [<stash>]
      -git stash apply [--index] [-q | --quiet] [<stash>]
     -+git stash apply [--index] [-q | --quiet] [--ours-label=<label>] [--theirs-label=<label>] [--base-label=<label>] [<stash>]
     ++git stash apply [--index] [-q | --quiet] [--label-ours=<label>] [--label-theirs=<label>] [--label-base=<label>] [<stash>]
       git stash branch <branchname> [<stash>]
       git stash [push] [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
       	     [-u | --include-untracked] [-a | --all] [(-m | --message) <message>]
     @@ Documentation/git-stash.adoc: the index's ones. However, this can fail, when you
       (which are stored in the index, where you therefore can no longer
       apply the changes as they were originally).
       
     -+`--ours-label=<label>`::
     -+`--theirs-label=<label>`::
     -+`--base-label=<label>`::
     ++`--label-ours=<label>`::
     ++`--label-theirs=<label>`::
     ++`--label-base=<label>`::
      +	These options are only valid for the `apply` command.
      ++
      +Use the given labels in conflict markers instead of the default
      +"Updated upstream", "Stashed changes", and "Stash base".
     -+`--base-label` only has an effect with merge.conflictStyle=diff3.
     ++`--label-base` only has an effect with merge.conflictStyle=diff3.
      +
       `-k`::
       `--keep-index`::
     @@ builtin/stash.c
       	N_("git stash pop [--index] [-q | --quiet] [<stash>]")
       #define BUILTIN_STASH_APPLY_USAGE \
      -	N_("git stash apply [--index] [-q | --quiet] [<stash>]")
     -+	N_("git stash apply [--index] [-q | --quiet] [--ours-label=<label>] [--theirs-label=<label>] [--base-label=<label>] [<stash>]")
     ++	N_("git stash apply [--index] [-q | --quiet] [--label-ours=<label>] [--label-theirs=<label>] [--label-base=<label>] [<stash>]")
       #define BUILTIN_STASH_BRANCH_USAGE \
       	N_("git stash branch <branchname> [<stash>]")
       #define BUILTIN_STASH_STORE_USAGE \
     +@@ builtin/stash.c: static void unstage_changes_unless_new(struct object_id *orig_tree)
     + 		die(_("could not write index"));
     + }
     + 
     +-static int do_apply_stash(const char *prefix, struct stash_info *info,
     +-			  int index, int quiet)
     ++static int do_apply_stash_with_labels(const char *prefix,
     ++				      struct stash_info *info,
     ++				      int index, int quiet,
     ++				      const char *label_ours, const char *label_theirs,
     ++				      const char *label_base)
     + {
     + 	int clean, ret;
     + 	int has_index = index;
     +@@ builtin/stash.c: static int do_apply_stash(const char *prefix, struct stash_info *info,
     + 
     + 	init_ui_merge_options(&o, the_repository);
     + 
     +-	o.branch1 = "Updated upstream";
     +-	o.branch2 = "Stashed changes";
     +-	o.ancestor = "Stash base";
     ++	o.branch1 = label_ours ? label_ours : "Updated upstream";
     ++	o.branch2 = label_theirs ? label_theirs : "Stashed changes";
     ++	o.ancestor = label_base ? label_base : "Stash base";
     + 
     + 	if (oideq(&info->b_tree, &c_tree))
     + 		o.branch1 = "Version stash was based on";
     +@@ builtin/stash.c: restore_untracked:
     + 	return ret;
     + }
     + 
     ++static int do_apply_stash(const char *prefix, struct stash_info *info,
     ++			  int index, int quiet)
     ++{
     ++	return do_apply_stash_with_labels(prefix, info, index, quiet,
     ++					  NULL, NULL, NULL);
     ++}
     ++
     + static int apply_stash(int argc, const char **argv, const char *prefix,
     + 		       struct repository *repo UNUSED)
     + {
     + 	int ret = -1;
     + 	int quiet = 0;
     + 	int index = use_index;
     ++	const char *label_ours = NULL, *label_theirs = NULL, *label_base = NULL;
     + 	struct stash_info info = STASH_INFO_INIT;
     + 	struct option options[] = {
     + 		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
     + 		OPT_BOOL(0, "index", &index,
     + 			 N_("attempt to recreate the index")),
     ++		OPT_STRING(0, "label-ours", &label_ours, N_("label"),
     ++			   N_("label for the upstream side in conflict markers")),
     ++		OPT_STRING(0, "label-theirs", &label_theirs, N_("label"),
     ++			   N_("label for the stashed side in conflict markers")),
     ++		OPT_STRING(0, "label-base", &label_base, N_("label"),
     ++			   N_("label for the base in diff3 conflict markers")),
     + 		OPT_END()
     + 	};
     + 
     +@@ builtin/stash.c: static int apply_stash(int argc, const char **argv, const char *prefix,
     + 	if (get_stash_info(&info, argc, argv))
     + 		goto cleanup;
     + 
     +-	ret = do_apply_stash(prefix, &info, index, quiet);
     ++	ret = do_apply_stash_with_labels(prefix, &info, index, quiet,
     ++					 label_ours, label_theirs, label_base);
     + cleanup:
     + 	free_stash_info(&info);
     + 	return ret;
      
       ## t/t3903-stash.sh ##
      @@ t/t3903-stash.sh: test_expect_success 'restore untracked files even when we hit conflicts' '
     @@ t/t3903-stash.sh: test_expect_success 'restore untracked files even when we hit
      +	git init conflict_labels &&
      +	(
      +		cd conflict_labels &&
     -+		echo base >file &&
     -+		git add file &&
     -+		git commit -m base &&
     ++		test_commit base file &&
      +		echo stashed >file &&
      +		git stash push -m "stashed" &&
     -+		echo upstream >file &&
     -+		git add file &&
     -+		git commit -m upstream &&
     -+		test_must_fail git -c merge.conflictStyle=diff3 stash apply --ours-label=UP --theirs-label=STASH &&
     ++		test_commit upstream file &&
     ++		test_must_fail git -c merge.conflictStyle=diff3 stash apply --label-ours=UP --label-theirs=STASH &&
      +		test_grep "^<<<<<<< UP" file &&
      +		test_grep "^||||||| Stash base" file &&
      +		test_grep "^>>>>>>> STASH" file
     @@ t/t3903-stash.sh: test_expect_success 'restore untracked files even when we hit
      +	git init empty_labels &&
      +	(
      +		cd empty_labels &&
     -+		echo base >file &&
     -+		git add file &&
     -+		git commit -m base &&
     ++		test_commit base file &&
      +		echo stashed >file &&
      +		git stash push -m "stashed" &&
     -+		echo upstream >file &&
     -+		git add file &&
     -+		git commit -m upstream &&
     -+		test_must_fail git stash apply --ours-label= --theirs-label= &&
     ++		test_commit upstream file &&
     ++		test_must_fail git stash apply --label-ours= --label-theirs= &&
      +		test_grep "^<<<<<<<$" file &&
      +		test_grep "^>>>>>>>$" file
      +	)
 2:  86cf68d024 ! 2:  a1fa04a965 sequencer: allow create_autostash to run silently
     @@ Commit message
      
          Add a silent parameter to create_autostash_internal and introduce
          create_autostash_ref_silent so that callers can create an autostash
     -    without printing the "Created autostash" message.  Use stderr for
     -    the message when not silent.
     +    without printing the "Created autostash" message.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ sequencer.c: static enum todo_command peek_command(struct todo_list *todo_list,
       				      const char *path,
      -				      const char *refname)
      +				      const char *refname,
     -+				      int silent)
     ++				      bool silent)
       {
       	struct strbuf buf = STRBUF_INIT;
       	struct lock_file lock_file = LOCK_INIT;
     @@ sequencer.c: static void create_autostash_internal(struct repository *r,
       
      -		printf(_("Created autostash: %s\n"), buf.buf);
      +		if (!silent)
     -+			fprintf(stderr, _("Created autostash: %s\n"), buf.buf);
     ++			printf(_("Created autostash: %s\n"), buf.buf);
       		if (reset_head(r, &ropts) < 0)
       			die(_("could not reset --hard"));
       		discard_index(r->index);
     @@ sequencer.c: static void create_autostash_internal(struct repository *r,
       void create_autostash(struct repository *r, const char *path)
       {
      -	create_autostash_internal(r, path, NULL);
     -+	create_autostash_internal(r, path, NULL, 0);
     ++	create_autostash_internal(r, path, NULL, false);
       }
       
       void create_autostash_ref(struct repository *r, const char *refname)
       {
      -	create_autostash_internal(r, NULL, refname);
     -+	create_autostash_internal(r, NULL, refname, 0);
     ++	create_autostash_internal(r, NULL, refname, false);
      +}
      +
      +void create_autostash_ref_silent(struct repository *r, const char *refname)
      +{
     -+	create_autostash_internal(r, NULL, refname, 1);
     ++	create_autostash_internal(r, NULL, refname, true);
       }
       
       static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
 3:  78300e0e9a ! 3:  87216a633b sequencer: teach autostash apply to take optional conflict marker labels
     @@ Metadata
       ## Commit message ##
          sequencer: teach autostash apply to take optional conflict marker labels
      
     -    Add label1, label2, and label_ancestor parameters to the autostash
     +    Add label_ours, label_theirs, and label_base parameters to the autostash
          apply machinery so callers can pass custom conflict marker labels
     -    through to "git stash apply --ours-label/--theirs-label/--base-label".
     +    through to "git stash apply --label-ours/--label-theirs/--label-base".
          Introduce apply_autostash_ref_with_labels() for callers that want
          to pass labels.
      
     @@ Commit message
      
       ## sequencer.c ##
      @@ sequencer.c: void create_autostash_ref_silent(struct repository *r, const char *refname)
     - 	create_autostash_internal(r, NULL, refname, 1);
     + 	create_autostash_internal(r, NULL, refname, true);
       }
       
      -static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
     @@ sequencer.c: static int apply_save_autostash_oid(const char *stash_oid, int atte
       		strvec_push(&child.args, "stash");
       		strvec_push(&child.args, "apply");
      +		if (label_ours)
     -+			strvec_pushf(&child.args, "--ours-label=%s", label_ours);
     ++			strvec_pushf(&child.args, "--label-ours=%s", label_ours);
      +		if (label_theirs)
     -+			strvec_pushf(&child.args, "--theirs-label=%s", label_theirs);
     ++			strvec_pushf(&child.args, "--label-theirs=%s", label_theirs);
      +		if (label_base)
     -+			strvec_pushf(&child.args, "--base-label=%s", label_base);
     ++			strvec_pushf(&child.args, "--label-base=%s", label_base);
       		strvec_push(&child.args, stash_oid);
       		ret = run_command(&child);
       	}
 4:  aa18313362 ! 4:  00e0b3196c checkout: -m (--merge) uses autostash when switching branches
     @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
       	int do_merge = 1;
      +	int created_autostash = 0;
      +	struct strbuf old_commit_shortname = STRBUF_INIT;
     -+	const char *stash_label_ancestor = NULL;
     ++	const char *stash_label_base = NULL;
       
       	trace2_cmd_mode("branch");
       
     @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
       	}
       
      +	if (old_branch_info.name)
     -+		stash_label_ancestor = old_branch_info.name;
     ++		stash_label_base = old_branch_info.name;
      +	else if (old_branch_info.commit) {
      +		strbuf_add_unique_abbrev(&old_commit_shortname,
      +					 &old_branch_info.commit->object.oid,
      +					 DEFAULT_ABBREV);
     -+		stash_label_ancestor = old_commit_shortname.buf;
     ++		stash_label_base = old_commit_shortname.buf;
      +	}
      +
       	if (do_merge) {
     @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
      +						       "CHECKOUT_AUTOSTASH",
      +						       new_branch_info->name,
      +						       "local",
     -+						       stash_label_ancestor);
     ++						       stash_label_base);
       			branch_info_release(&old_branch_info);
      +			strbuf_release(&old_commit_shortname);
       			return ret;
     @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
      +	}
      +	apply_autostash_ref_with_labels(the_repository, "CHECKOUT_AUTOSTASH",
      +				       new_branch_info->name, "local",
     -+				       stash_label_ancestor);
     ++				       stash_label_base);
      +
      +	discard_index(the_repository->index);
      +	if (repo_read_index(the_repository) < 0)
     @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
       	return ret || writeout_error;
       }
      
     - ## builtin/stash.c ##
     -@@ builtin/stash.c: static void unstage_changes_unless_new(struct object_id *orig_tree)
     - 		die(_("could not write index"));
     - }
     - 
     --static int do_apply_stash(const char *prefix, struct stash_info *info,
     --			  int index, int quiet)
     -+static int do_apply_stash_with_labels(const char *prefix,
     -+				      struct stash_info *info,
     -+				      int index, int quiet,
     -+				      const char *label1, const char *label2,
     -+				      const char *label_ancestor)
     - {
     - 	int clean, ret;
     - 	int has_index = index;
     -@@ builtin/stash.c: static int do_apply_stash(const char *prefix, struct stash_info *info,
     - 
     - 	init_ui_merge_options(&o, the_repository);
     - 
     --	o.branch1 = "Updated upstream";
     --	o.branch2 = "Stashed changes";
     --	o.ancestor = "Stash base";
     -+	o.branch1 = label1 ? label1 : "Updated upstream";
     -+	o.branch2 = label2 ? label2 : "Stashed changes";
     -+	o.ancestor = label_ancestor ? label_ancestor : "Stash base";
     - 
     - 	if (oideq(&info->b_tree, &c_tree))
     - 		o.branch1 = "Version stash was based on";
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
     - 	int ret = -1;
     - 	int quiet = 0;
     - 	int index = use_index;
     -+	const char *label1 = NULL, *label2 = NULL, *label_ancestor = NULL;
     - 	struct stash_info info = STASH_INFO_INIT;
     - 	struct option options[] = {
     - 		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
     - 		OPT_BOOL(0, "index", &index,
     - 			 N_("attempt to recreate the index")),
     -+		OPT_STRING(0, "ours-label", &label1, N_("label"),
     -+			   N_("label for the upstream side in conflict markers")),
     -+		OPT_STRING(0, "theirs-label", &label2, N_("label"),
     -+			   N_("label for the stashed side in conflict markers")),
     -+		OPT_STRING(0, "base-label", &label_ancestor, N_("label"),
     -+			   N_("label for the base in diff3 conflict markers")),
     - 		OPT_END()
     - 	};
     - 
     -@@ builtin/stash.c: static int apply_stash(int argc, const char **argv, const char *prefix,
     - 	if (get_stash_info(&info, argc, argv))
     - 		goto cleanup;
     - 
     --	ret = do_apply_stash(prefix, &info, index, quiet);
     -+	ret = do_apply_stash_with_labels(prefix, &info, index, quiet,
     -+					 label1, label2, label_ancestor);
     - cleanup:
     - 	free_stash_info(&info);
     - 	return ret;
     -
       ## sequencer.c ##
      @@ sequencer.c: static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
       		strvec_push(&store.args, stash_oid);

-- 
gitgitgadget

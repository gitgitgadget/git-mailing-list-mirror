Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD42518787A
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 09:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773740143; cv=none; b=aIQeCmKP+FssPEdjrNNYhFgZAmy3t7UntXpd7IrEeJbHJAd+fMRIjR/reihbGpY4UEw0XrJSU3oCn/L38IgcUKBo3iKS0mgqfuDtiiiSAe4ryY5EPBvyRjNYk/85hR8upGD7YB5CRE3lh91wzR09OcBJ40+nbp6Q50CUxeBz5WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773740143; c=relaxed/simple;
	bh=N39TI3uwmY89yxeA/MPRrfSbR8+X+3wrrN4IUW06CkI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UaZZpc4/8Cw4iaAmPgRcihzbqLO9mzWkUjF06HnlFjVg1zOfRe9xlWeAdBrSVtDbzBXBu9sL0g4fiZhtZA0MGeHHVbtG+/qEg6rz0g8AsCdog7cJoxDq+2On4llGpyJZ3iOUzKdRVeC+JwY5Mtt1F5etWAHkrGZBPsDEtA5gfI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jn3oGmAm; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jn3oGmAm"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-829abaaa92bso3574845b3a.1
        for <git@vger.kernel.org>; Tue, 17 Mar 2026 02:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773740141; x=1774344941; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfPMR7Wu8jDb+ZSBTNuRvkN/yJaXpg02WJ4CCmcxz7U=;
        b=jn3oGmAm6eDPhrVENd/xA7Z8ce06vkXJJFn+ORxJLgjjUGcl83sCB2wjFNjw4h2oKI
         Sn1B/XnKiFnRHCesiBv4/UxTtOsnUCmJ1i3yRvU2vb07FXffLm7mNSWzQCZG/6oR6u+h
         Dq37TjsGb/soyXXh1Ayk/KZlsk65EU/HbHJotuGzg+XUDxMKlMmDT16KRHeI2e2Retgh
         nwIrrYoqy/2U/IrBvOftxcBZSxM0D326aTkQexqG9F2+asev/pml0TySPGgb49cbsDRx
         FOHjXE4IyyCK63//OGl3X7ncGyFyv1HmyZn+ipjxNmckfeuFTLuXnFo4buQnqqikU5yi
         qXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773740141; x=1774344941;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vfPMR7Wu8jDb+ZSBTNuRvkN/yJaXpg02WJ4CCmcxz7U=;
        b=lzDoYr/Irv9HcuBfSByTDKPvX+FCDtHiaXYeCXh5EQPZ0Mr2906lA9683xa1jeIqML
         hOoRmQYDRxB1Tdxqzt12t+/Rcwpp2NlyDswYBBX3sFQC3jeixPbDkKqasfivYjEEo40T
         Ttd+SU6Jjrr2zFsYvGHiQ9QKUKXloDcwA/i4BwKTZbtPf2ZmwPyjmA68koE7nQUUA9Ef
         xgepqK4XwlQzKfhQ8wjKJOs86068NSyBaQ/eOq/Zg5iSkhq4wxtE5SgnbpPV+Bb2KzMt
         tbTRx4+Z6dbtX89H1OxM+fvbTJ3Gxi+fB1UWDSPRjGd/yPsWhjRH71oo2mOwibO4LbQw
         3Z1w==
X-Gm-Message-State: AOJu0YyeOC+YgL7/lLshcuaTe5g/+QFCaiGn55jMFezNVCGI62R+XytY
	e+13UAp5j777igNwH+FQmZQAKEBjLhcDXaWJ1fgibzO8716ITQwW7KofKBCE4A==
X-Gm-Gg: ATEYQzy1PMvsUZieQ2WJjpJeqWZsccDkIoP/n01CTYFEBacRkAq9qVo6y7g5eOrWGLB
	3KFHhvZfnbcN2BXXgPJhiUenfJ/2292VlFA8+hA4SyGspMGRouQAzJXcr0Xu5Kr6HdN9gaWlHzc
	jyILsL53U3/eI3b2b9sVOc2jDA7xqKK49NVo3czE/A6CEZrQ8ndNm6W2V7+sGPNQ/TzqjS8Hhck
	fOzmtbJ87Wj7hht/8a8Rk76AbB9J1x1SGFKN228OqFAXrJLZEHm1mRxn5QsnvPBZqLwwGvCbDcC
	60fPm1gCoglKAvKykRUViq0noKFTRl1RoqEZ/sIYsTrtVdSlAiVJN76UzsiZd+55a/wQMJ8D/AB
	SA3n4u6+xc+l6wKB8QDHAHMkY7ggwnd6Fqi/lm+PIzGPurdKPGZ/MOmBN0O5L4H006ZrEjlYV74
	CnKPp4OFJj6ZVZPmqbLF0TUbk=
X-Received: by 2002:a05:6a00:2499:b0:81f:5ec1:8bcd with SMTP id d2e1a72fcca58-82a1983f759mr12172427b3a.20.1773740140704;
        Tue, 17 Mar 2026 02:35:40 -0700 (PDT)
Received: from [127.0.0.1] ([20.3.221.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a64b9566fsm222810b3a.25.2026.03.17.02.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 02:35:40 -0700 (PDT)
Message-Id: <pull.2234.v6.git.git.1773740139.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v5.git.git.1773573553.gitgitgadget@gmail.com>
References: <pull.2234.v5.git.git.1773573553.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Mar 2026 09:35:35 +0000
Subject: [PATCH v6 0/4] checkout: 'autostash' for branch switching
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>

cc: Phillip Wood phillip.wood123@gmail.com

Harald Nordgren (4):
  stash: add --ours-label, --theirs-label, --base-label for apply
  sequencer: allow create_autostash to run silently
  sequencer: teach autostash apply to take optional conflict marker
    labels
  checkout: -m (--merge) uses autostash when switching branches

 Documentation/git-checkout.adoc |  58 ++++++------
 Documentation/git-stash.adoc    |  11 ++-
 Documentation/git-switch.adoc   |  27 +++---
 builtin/checkout.c              | 137 ++++++++++++---------------
 builtin/stash.c                 |  32 +++++--
 sequencer.c                     |  67 +++++++++----
 sequencer.h                     |   4 +
 t/t3420-rebase-autostash.sh     |  24 +++--
 t/t3903-stash.sh                |  18 ++++
 t/t7201-co.sh                   | 160 ++++++++++++++++++++++++++++++++
 t/t7600-merge.sh                |   2 +-
 xdiff-interface.c               |  12 +++
 xdiff-interface.h               |   1 +
 13 files changed, 403 insertions(+), 150 deletions(-)


base-commit: ca1db8a0f7dc0dbea892e99f5b37c5fe5861be71
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2234%2FHaraldNordgren%2Fcheckout_autostash-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2234/HaraldNordgren/checkout_autostash-v6
Pull-Request: https://github.com/git/git/pull/2234

Range-diff vs v5:

 1:  00d8920498 = 1:  cd9c64ba60 stash: add --ours-label, --theirs-label, --base-label for apply
 2:  5d176f1700 = 2:  d572c4bb7d sequencer: allow create_autostash to run silently
 3:  3d6829438a = 3:  80a98116fc sequencer: teach autostash apply to take optional conflict marker labels
 4:  7f3735d40e ! 4:  7ecb0835b7 checkout: -m (--merge) uses autostash when switching branches
     @@ builtin/checkout.c
       #include "submodule.h"
       #include "symlinks.h"
      @@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *opts,
     + 	struct tree *new_tree;
       
     + 	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
     +-	if (repo_read_index_preload(the_repository, NULL, 0) < 0)
     ++	if (repo_read_index_preload(the_repository, NULL, 0) < 0) {
     ++		rollback_lock_file(&lock_file);
     + 		return error(_("index file corrupt"));
     ++	}
     + 
     + 	resolve_undo_clear_index(the_repository->index);
     + 	if (opts->new_orphan_branch && opts->orphan_from_empty_tree) {
     +@@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *opts,
     + 	} else {
     + 		new_tree = repo_get_commit_tree(the_repository,
     + 						new_branch_info->commit);
     +-		if (!new_tree)
     ++		if (!new_tree) {
     ++			rollback_lock_file(&lock_file);
     + 			return error(_("unable to read tree (%s)"),
     + 				     oid_to_hex(&new_branch_info->commit->object.oid));
     ++		}
     + 	}
     + 	if (opts->discard_changes) {
     + 		ret = reset_tree(new_tree, opts, 1, writeout_error, new_branch_info);
     +-		if (ret)
     ++		if (ret) {
     ++			rollback_lock_file(&lock_file);
     + 			return ret;
     ++		}
     + 	} else {
     + 		struct tree_desc trees[2];
     + 		struct tree *tree;
     +@@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *opts,
     + 		refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL, NULL);
     + 
     + 		if (unmerged_index(the_repository->index)) {
     ++			rollback_lock_file(&lock_file);
     + 			error(_("you need to resolve your current index first"));
     + 			return 1;
     + 		}
     +@@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *opts,
       		ret = unpack_trees(2, trees, &topts);
       		clear_unpack_trees_porcelain(&topts);
     --		if (ret == -1) {
     + 		if (ret == -1) {
      -			/*
      -			 * Unpack couldn't do a trivial merge; either
      -			 * give up or do a real merge, depending on
     @@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *op
      -			strbuf_release(&old_commit_shortname);
      -			if (ret)
      -				return ret;
     --		}
     -+		if (ret == -1)
     ++			rollback_lock_file(&lock_file);
      +			return 1;
     + 		}
       	}
       
     - 	if (!cache_tree_fully_valid(the_repository->index->cache_tree))
     -@@ builtin/checkout.c: static void orphaned_commit_warning(struct commit *old_commit, struct commit *ne
     - 	release_revisions(&revs);
     - }
     - 
     -+static int checkout_would_clobber_changes(struct branch_info *old_branch_info,
     -+					  struct branch_info *new_branch_info)
     -+{
     -+	struct tree_desc trees[2];
     -+	struct tree *old_tree, *new_tree;
     -+	struct unpack_trees_options topts;
     -+	struct index_state tmp_index = INDEX_STATE_INIT(the_repository);
     -+	const struct object_id *old_commit_oid;
     -+	int ret;
     -+
     -+	if (!new_branch_info->commit)
     -+		return 0;
     -+
     -+	old_commit_oid = old_branch_info->commit ?
     -+		&old_branch_info->commit->object.oid :
     -+		the_hash_algo->empty_tree;
     -+	old_tree = repo_parse_tree_indirect(the_repository, old_commit_oid);
     -+	if (!old_tree)
     -+		return 0;
     -+
     -+	new_tree = repo_get_commit_tree(the_repository,
     -+					new_branch_info->commit);
     -+	if (!new_tree)
     -+		return 0;
     -+	if (repo_parse_tree(the_repository, new_tree) < 0)
     -+		return 0;
     -+
     -+	memset(&topts, 0, sizeof(topts));
     -+	topts.head_idx = -1;
     -+	topts.src_index = the_repository->index;
     -+	topts.dst_index = &tmp_index;
     -+	topts.initial_checkout = is_index_unborn(the_repository->index);
     -+	topts.merge = 1;
     -+	topts.update = 1;
     -+	topts.dry_run = 1;
     -+	topts.quiet = 1;
     -+	topts.fn = twoway_merge;
     -+
     -+	init_tree_desc(&trees[0], &old_tree->object.oid,
     -+		       old_tree->buffer, old_tree->size);
     -+	init_tree_desc(&trees[1], &new_tree->object.oid,
     -+		       new_tree->buffer, new_tree->size);
     -+
     -+	ret = unpack_trees(2, trees, &topts);
     -+	discard_index(&tmp_index);
     -+
     -+	return ret != 0;
     -+}
     -+
     - static int switch_branches(const struct checkout_opts *opts,
     - 			   struct branch_info *new_branch_info)
     - {
      @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
       	struct object_id rev;
       	int flag, writeout_error = 0;
     @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
      +		stash_label_ancestor = old_commit_shortname.buf;
      +	}
      +
     -+	if (opts->merge) {
     -+		if (repo_read_index(the_repository) < 0)
     -+			die(_("index file corrupt"));
     -+		if (checkout_would_clobber_changes(&old_branch_info,
     -+						   new_branch_info)) {
     + 	if (do_merge) {
     + 		ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
     ++		if (ret && opts->merge) {
      +			create_autostash_ref_silent(the_repository,
      +						   "CHECKOUT_AUTOSTASH");
      +			created_autostash = 1;
     ++			ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
      +		}
     -+	}
     -+
     - 	if (do_merge) {
     - 		ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
       		if (ret) {
      +			apply_autostash_ref_with_labels(the_repository,
      +						       "CHECKOUT_AUTOSTASH",

-- 
gitgitgadget

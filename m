Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243F6265CDD
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 21:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338105; cv=none; b=UjSkuEP4gT7e+GXskflswCPKnaVZFQE5EZTpxtz6oBcQP46U/10bBfkj0DPLjUgV533qRhkp0oHaOUuFgv/bP0uTLrcT9i+pmA1AH0nz7yo90TwabOcY8l2gRkHYCr0UMEPTNh+V9EfN4+Wn4wjcMrojS24pQ++NgDiNtNl5Dws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338105; c=relaxed/simple;
	bh=5mv0vy/k+3Lh2oPN1s/YiE7+OAy8bQp1NkKz49pjp6c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lL004luTJ60/BCJ/Sc0iHOoNb75CavmUyZoRSO4MWhfiGLd35gJn5Dhz69HAHwBCTom5gEtvak4ZHzlVhYoExRh4c0kdGvJTPk+cIhLxSKXS7gBwp/BluCWzCmip39iZSiwmjmEoFqAqbnSdfWKcsMPmkCSLlppRqswMbDdkO7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLalgxqe; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLalgxqe"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8dc09919aa2so25358046d6.3
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 14:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782338103; x=1782942903; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VaibiwvNwXN7jZGp4ZNB5MQyWv/fnhET8cd/0usXMcw=;
        b=YLalgxqeR37uaBFN3x2CedmprKlb6twNR71voJ3qccLqHRfHXlJddhow6xsq4hwKQ5
         Gg05lXruATXHlDxF4oDdsLj9AK0QPgidHfzwTY2P0EcLKKYb2535dqYqcN2eON8CU7wp
         YMwfMGnnI1lI3OSvwPqfe7PLA8GJ1Ky7+kdDehmGWdi/s9UaiTtnto3VvWP8ZyBcb2sh
         T2KNZeH90PGOqjMrEe6bAu/pyAdrV6ipch1CndyrqupefqL43u+l31HhlqjzsBlPUDid
         CUxCNxsYvEr1OAB29LxZtzi98Tccc75sMMcTpbRKloJSORdaH0tt/lQQ5pZwDltG7Q2E
         N8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782338103; x=1782942903;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VaibiwvNwXN7jZGp4ZNB5MQyWv/fnhET8cd/0usXMcw=;
        b=RkaDp3if3gAuWdcEtfSgNsHulbvqZSDr44V/REAJSvoqs6nXbgP2buYtegssI1Hsys
         YLtKlMfU7wwTx5hCQedt/tEWZJAWQ0tUMg7JvI0M/ajb0FfhcRfSpN5p248bh6+nZc3A
         2TK/mSGai4I0GesWy0FyBizHM/JVFS887ilakjlbbDMEqvJLqZmNF2Yj88YzC6rzJitg
         /oRNYdFEtbBd/V3Ky2Pu+jI9tEJJc1QdP6pPYlvIKqj1jPm+7wrwdxHrZuc6rzEE1bSZ
         nYbwNx+rosPrxHEPo4n3UbJgaJ5wWk7dxAeEkXeXWIYHdaqmvqCxV4R8oM2H9qdNEP5W
         WaUw==
X-Gm-Message-State: AOJu0YytBYX43VKOT3+/9Cl5V30RvpuHRw06WAzeq9UCi34XIok1uFCW
	S499+pD9+ezsNHvKaqthnInSdz4D2QzLAh7NQblEP+vPm+OwwUkotLwFSYxVdaaX
X-Gm-Gg: AfdE7cm49clY0C3pfaSRDKULuHRhg2fzsRA2u/xEGZxB4NYFcOXu9BCv2NV3IY5DKGj
	rMyvR/uQU4/75KGN4QOY3ppXMsFmS5bLzSPa+puuT1fYw1KL71q2Ezjnb4Xpemp70jIGVrEwz7Y
	NKtNKNH1PUzSalF5eAtbSbLUywNGvF/5v0Xg8V1QIds++h61peL7jML3r/m7hjiULEXTGKe0V/r
	zBB4/5OD9/MnxJiano/ziMijzvKcnyjGFg9awJkWvE6vDhbtcuDHhLErP6lKrXtL7g83Hp7mk5m
	BIOIxdvzgernBWUTyFaxRWK6d52W8aCytd/91duMD1+frYJRJjQyPh7iEWCq8t1rsc41Cq/13CM
	+7V4T1Ry4bB0wonJV3kcDSn7XxsKtag/Po5V/km/jfujwtgVt0+Se6laivkGgzkKxNNxkzbQ6XI
	Jg1bK4EC49gJohIaHX8EUSn+KIxA==
X-Received: by 2002:a05:6214:459d:b0:8cc:d165:7ee0 with SMTP id 6a1803df08f44-8e6d2ec7aaamr381596d6.11.1782338103035;
        Wed, 24 Jun 2026 14:55:03 -0700 (PDT)
Received: from [127.0.0.1] ([20.106.191.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df81cdd8e2sm166546786d6.27.2026.06.24.14.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:55:02 -0700 (PDT)
Message-Id: <pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>
References: <pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jun 2026 21:54:58 +0000
Subject: [PATCH v5 0/4] history: add squash subcommand to fold a range
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

Adds git history squash <revision-range> to fold a range of commits.

Changes in v5:

 * The range walk now uses --ancestry-path, so only commits descended from
   the base are folded; a single revision such as HEAD or HEAD~1 is now
   rejected as "not a <base>..<tip> range" rather than treated as a squash
   down to the root.
 * This adopts the --ancestry-path suggestion; the multi-base rejection is
   unchanged, so a side branch that forked before the base and merged in is
   still refused.
 * Added tests covering more merge topologies: two interior merges, a nested
   merge, an octopus merge, an octopus arm forked before the base, a merge
   among the descendants replayed above the range, and a ref pointing at an
   interior merge commit.

Changes in v4:

 * git history squash now detects when another ref points at a commit inside
   the range being folded and refuses, with an advice.historyUpdateRefs hint
   to use --update-refs=head.
 * A merge inside the range is folded fine as long as the range has a single
   base; a range with merge commit at the tip or base also folds correctly.
   Only a range with more than one base is rejected.

Changes in v3:

 * Moved the feature out of git rebase and into a new git history squash
   <revision-range> subcommand, per the list discussion. git rebase --squash
   is dropped.
 * Takes an arbitrary range (git history squash @~3.., git history squash
   @~5..@~2), folding it into the oldest commit and replaying any
   descendants on top.
 * Implemented as a single tree operation rather than picking each commit,
   so there are no repeated conflict stops (addresses Phillip's efficiency
   point).
 * A merge inside the range is folded fine, only a range with more than one
   base is rejected.
 * --reedit-message seeds the editor with every folded-in message, not just
   the oldest.

Harald Nordgren (4):
  history: extract helper for a commit's parent tree
  history: give commit_tree_ext a message template
  history: add squash subcommand to fold a range
  history: re-edit a squash with every message

 Documentation/config/advice.adoc |   4 +
 Documentation/git-history.adoc   |  26 ++
 advice.c                         |   1 +
 advice.h                         |   1 +
 builtin/history.c                | 341 ++++++++++++++++++---
 t/meson.build                    |   1 +
 t/t3455-history-squash.sh        | 497 +++++++++++++++++++++++++++++++
 7 files changed, 833 insertions(+), 38 deletions(-)
 create mode 100755 t/t3455-history-squash.sh


base-commit: 26d8d94e94df5535eecd036f16627493506a0614
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2337%2FHaraldNordgren%2Frebase-fixup-fold-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2337/HaraldNordgren/rebase-fixup-fold-v5
Pull-Request: https://github.com/git/git/pull/2337

Range-diff vs v4:

 1:  fc2801c0b1 = 1:  0f1ae9b05a history: extract helper for a commit's parent tree
 2:  ee591e83b4 = 2:  a97ffab1e6 history: give commit_tree_ext a message template
 3:  80bfea642e ! 3:  04e18ef979 history: add squash subcommand to fold a range
     @@ builtin/history.c: out:
      +	struct rev_info revs;
      +	struct commit *commit, *base = NULL, *oldest = NULL, *tip = NULL;
      +	struct strvec args = STRVEC_INIT;
     ++	size_t i;
      +	int ret;
      +
      +	repo_init_revisions(repo, &revs, NULL);
     @@ builtin/history.c: out:
      +	strvec_push(&args, "--reverse");
      +	strvec_push(&args, "--topo-order");
      +	strvec_push(&args, "--boundary");
     ++	strvec_push(&args, "--ancestry-path");
      +	strvec_push(&args, range);
      +	setup_revisions_from_strvec(&args, &revs, NULL);
      +	if (args.nr != 1) {
     @@ builtin/history.c: out:
      +		goto out;
      +	}
      +
     ++	/*
     ++	 * A squash needs a base to reparent onto, so the argument has to
     ++	 * exclude something, as in "<base>..<tip>". A single revision has no
     ++	 * such bottom commit and cannot be squashed.
     ++	 */
     ++	for (i = 0; i < revs.cmdline.nr; i++)
     ++		if (revs.cmdline.rev[i].flags & UNINTERESTING)
     ++			break;
     ++	if (i == revs.cmdline.nr) {
     ++		ret = error(_("'%s' is not a '<base>..<tip>' range"), range);
     ++		goto out;
     ++	}
     ++
      +	if (prepare_revision_walk(&revs) < 0) {
      +		ret = error(_("error preparing revisions"));
      +		goto out;
     @@ builtin/history.c: out:
      +		goto out;
      +	}
      +
     -+	if (!base) {
     -+		ret = error(_("cannot squash the root commit"));
     -+		goto out;
     -+	}
     ++	if (!base)
     ++		BUG("a non-empty range must have a boundary commit");
      +
      +	*base_out = base;
      +	*oldest_out = oldest;
     @@ t/t3455-history-squash.sh (new)
      +	test_grep "the range .* is empty" err
      +'
      +
     -+test_expect_success 'errors when the range includes the root commit' '
     ++test_expect_success 'errors on a single revision that is not a range' '
      +	test_must_fail git history squash HEAD 2>err &&
     -+	test_grep "cannot squash the root commit" err
     ++	test_grep "is not a .*range" err &&
     ++	test_must_fail git history squash HEAD~1 2>err &&
     ++	test_grep "is not a .*range" err
      +'
      +
      +test_expect_success 'squashes a range into a single commit without changing the tree' '
     @@ t/t3455-history-squash.sh (new)
      +	test_path_is_file inner
      +'
      +
     ++test_expect_success 'folds a merge of a branch that forked at the base' '
     ++	git reset --hard start &&
     ++	git checkout -b base-fork-side &&
     ++	test_commit --no-tag base-fork-side side x &&
     ++	git checkout - &&
     ++	test_commit --no-tag base-fork-main file b &&
     ++	git merge --no-ff -m "merge base-fork-side" base-fork-side &&
     ++	git branch -D base-fork-side &&
     ++	test_commit --no-tag base-fork-tail file c &&
     ++	tip_tree=$(git rev-parse HEAD^{tree}) &&
     ++
     ++	git history squash start.. &&
     ++
     ++	git rev-list --count start..HEAD >count &&
     ++	echo 1 >expect &&
     ++	test_cmp expect count &&
     ++	test_cmp_rev start HEAD^ &&
     ++	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
     ++	test_path_is_file side
     ++'
     ++
      +test_expect_success 'folds a range whose tip is a merge commit' '
      +	git reset --hard start &&
      +	test_commit --no-tag tipmerge-base file b &&
     @@ t/t3455-history-squash.sh (new)
      +	test_cmp_rev "$merged" HEAD
      +'
      +
     ++test_expect_success 'folds a range with two interior merges' '
     ++	git reset --hard start &&
     ++	test_commit --no-tag two-merge-a file a1 &&
     ++	git checkout -b two-merge-s1 &&
     ++	test_commit --no-tag two-merge-s1 s1 x &&
     ++	git checkout - &&
     ++	git merge --no-ff -m "merge s1" two-merge-s1 &&
     ++	test_commit --no-tag two-merge-b file b1 &&
     ++	git checkout -b two-merge-s2 &&
     ++	test_commit --no-tag two-merge-s2 s2 y &&
     ++	git checkout - &&
     ++	git merge --no-ff -m "merge s2" two-merge-s2 &&
     ++	git branch -D two-merge-s1 two-merge-s2 &&
     ++	tip_tree=$(git rev-parse HEAD^{tree}) &&
     ++
     ++	git history squash start.. &&
     ++
     ++	git rev-list --count start..HEAD >count &&
     ++	echo 1 >expect &&
     ++	test_cmp expect count &&
     ++	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
     ++	test_path_is_file s1 &&
     ++	test_path_is_file s2
     ++'
     ++
     ++test_expect_success 'folds a range with a nested merge' '
     ++	git reset --hard start &&
     ++	main=$(git symbolic-ref --short HEAD) &&
     ++	git checkout -b nested-outer &&
     ++	test_commit --no-tag nested-outer outer x &&
     ++	git checkout -b nested-inner &&
     ++	test_commit --no-tag nested-inner inner y &&
     ++	git checkout nested-outer &&
     ++	git merge --no-ff -m "merge inner" nested-inner &&
     ++	git checkout "$main" &&
     ++	test_commit --no-tag nested-main file b1 &&
     ++	git merge --no-ff -m "merge outer" nested-outer &&
     ++	git branch -D nested-outer nested-inner &&
     ++	tip_tree=$(git rev-parse HEAD^{tree}) &&
     ++
     ++	git history squash start.. &&
     ++
     ++	git rev-list --count start..HEAD >count &&
     ++	echo 1 >expect &&
     ++	test_cmp expect count &&
     ++	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
     ++	test_path_is_file outer &&
     ++	test_path_is_file inner
     ++'
     ++
     ++test_expect_success 'folds a range with an octopus merge' '
     ++	git reset --hard start &&
     ++	main=$(git symbolic-ref --short HEAD) &&
     ++	test_commit --no-tag octo-base file a1 &&
     ++	git checkout -b octo-1 &&
     ++	test_commit --no-tag octo-1 o1 x &&
     ++	git checkout "$main" &&
     ++	git checkout -b octo-2 &&
     ++	test_commit --no-tag octo-2 o2 y &&
     ++	git checkout "$main" &&
     ++	git merge --no-ff -m octopus octo-1 octo-2 &&
     ++	git branch -D octo-1 octo-2 &&
     ++	tip_tree=$(git rev-parse HEAD^{tree}) &&
     ++
     ++	git history squash start.. &&
     ++
     ++	git rev-list --count start..HEAD >count &&
     ++	echo 1 >expect &&
     ++	test_cmp expect count &&
     ++	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
     ++	test_path_is_file o1 &&
     ++	test_path_is_file o2
     ++'
     ++
     ++test_expect_success 'refuses an octopus merge with an arm forked before the base' '
     ++	git reset --hard start &&
     ++	main=$(git symbolic-ref --short HEAD) &&
     ++	git checkout -b octo-pre &&
     ++	test_commit octo-pre-side pside x &&
     ++	git checkout "$main" &&
     ++	test_commit octo-pre-main file b1 &&
     ++	octo_base=$(git rev-parse HEAD) &&
     ++	git checkout -b octo-within &&
     ++	test_commit --no-tag octo-within wside y &&
     ++	git checkout "$main" &&
     ++	git merge --no-ff -m octopus octo-pre octo-within &&
     ++	merged=$(git rev-parse HEAD) &&
     ++	git branch -D octo-pre octo-within &&
     ++
     ++	test_must_fail git history squash "$octo_base.." 2>err &&
     ++	test_grep "more than one base" err &&
     ++	test_cmp_rev "$merged" HEAD
     ++'
     ++
     ++test_expect_success 'refuses when a descendant above the range is a merge' '
     ++	git reset --hard start &&
     ++	main=$(git symbolic-ref --short HEAD) &&
     ++	test_commit --no-tag desc-base file b &&
     ++	git tag desc-tip &&
     ++	git checkout -b desc-above &&
     ++	test_commit --no-tag desc-above above x &&
     ++	git checkout "$main" &&
     ++	test_commit --no-tag desc-main file c &&
     ++	git merge --no-ff -m "merge desc-above" desc-above &&
     ++	git branch -D desc-above &&
     ++	head_before=$(git rev-parse HEAD) &&
     ++
     ++	test_must_fail git history squash start..desc-tip 2>err &&
     ++	test_grep "merge commits is not supported" err &&
     ++	test_cmp_rev "$head_before" HEAD
     ++'
     ++
     ++test_expect_success 'refuses to fold a range a ref points into at a merge' '
     ++	git reset --hard start &&
     ++	main=$(git symbolic-ref --short HEAD) &&
     ++	test_commit --no-tag refmerge-base file b &&
     ++	git checkout -b refmerge-side &&
     ++	test_commit --no-tag refmerge-side side x &&
     ++	git checkout "$main" &&
     ++	test_commit --no-tag refmerge-main file c &&
     ++	git merge --no-ff -m "interior merge" refmerge-side &&
     ++	git branch -D refmerge-side &&
     ++	git branch at-merge HEAD &&
     ++	test_commit --no-tag refmerge-tail file d &&
     ++	head_before=$(git rev-parse HEAD) &&
     ++
     ++	test_must_fail git history squash start.. 2>err &&
     ++	test_grep "at-merge" err &&
     ++	test_grep "points into the squashed range" err &&
     ++	test_cmp_rev "$head_before" HEAD &&
     ++
     ++	git branch -D at-merge
     ++'
     ++
      +test_done
 4:  85c7817d7e = 4:  a758e1f084 history: re-edit a squash with every message

-- 
gitgitgadget

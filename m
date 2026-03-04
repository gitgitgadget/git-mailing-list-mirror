Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB3B3A872F
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 12:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772627137; cv=none; b=aoagMavG7xIhzU6FEXD8xmiE8VtIL5pWp8GHgmYmR6ilxD6o1CDIqp25dnasqA5XwPqIrgs08//kH+9+Zacdfh9RDyZqoKv0TMaivxmWkDKZ9WQ4Gbku6Ee42tdjD1c4mFsTmTWkHIov7ECjGEkMOQVwFnMCO8v3DWIDIBdrufM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772627137; c=relaxed/simple;
	bh=95jzqMyRavP9g8OC5SO+gJe53Mtcbp7LyUHby+zC2l0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fo4DvIjgzY2qiWikML4e5Uu8PbelKBYVm5hBcknFdVbnnuxTLERrWcVbBC0hG+cNv2FdR+4sxOpxSi6FgOLIpIbG/yO9dYuk6vK5lwCKHoCyAK3o/q7s5ox2u8lvUEfBm9jvC0gHYBnHOsPqQCi5MeBHX6iTnB1Q/1rlRoqmw58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsifaaLS; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsifaaLS"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-503347dea84so74182811cf.3
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 04:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772627132; x=1773231932; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFq3ZisNUIvDNiSk1VPsXbnrC+fTSwLnTZAn5EOqwqs=;
        b=WsifaaLSguNkr5YXfVwx0A401nHdeCmQx6R07Di7LU9ge6rq08OFQ3suDX5CnhhPi+
         H3BnwzkqW1hMqmjigGvesP53YUoNc9IGAYyZ7lKjBLDcSaEOPZH7xoIImz1iUEKBhr8K
         JK6PaLmKVvqCxfWoN3YP+E9ZfPpmtdkS17LXbq24Eg1mLE09KXaHZSjO7Mur7z9QkuSR
         G2hNAuu5HIB6C/54uPNMiNJR44/jpyOTXSfjP0nXhtQjg3pmuNpyE+k5NF9DS1+tkm2d
         4RVzA5RJAnAJzfweM/iKBZ8NnCSZL9rIuDsrF97+M10Y1kB5e89f/+0VLawxbnRcXIUn
         PFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772627132; x=1773231932;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rFq3ZisNUIvDNiSk1VPsXbnrC+fTSwLnTZAn5EOqwqs=;
        b=n2fznpUdFRChSaNLIHhS6GajRTah3iK0f8mQYfW5ZaYIZWQCLtA3VfRonoebnHZK0S
         6dHPwKoRQQVnGwupAWlBzatbwwVJcKfnDtQaN1bM+nmRi7TnzE6oQ9D4x2BELH4q5lZF
         0ZEvE1Kqh4NjFkdW9oxGdMmgKg2WYpxdzDBkl2gyVXzKme0JfWX7FkkCcV+zRhXRHZlx
         4t68Djwg4qCqZL1fUpYk8d5rTGS/FkiopBePp50D271CNwcy/1s2jU+LycCbNfEbKw7R
         h3ny1YzcmpC0fhSu0O0lf4Q/UnhspsRAHdAWAewUZpjTbGRerPlKEMyZDcPgtcMRUOgp
         zZ6g==
X-Gm-Message-State: AOJu0YyRyOb68mPaqcGJeLO8bOEM5dt/KLpuATUROYaIVCd+gO1iv2/J
	AMFN0vQ+bpIm5kiytA3e/uohJN6LGYATpcm9LRrb7/i7SL5VB06nduceYi0LEg==
X-Gm-Gg: ATEYQzz55gPUxSSu59MJyTLtXuCE9CG7P0go6sWRRiRhwI9V1UfRYPRezbPxgDzAwRZ
	+RqMfz9znF6dyjcZUCvxxhexnPbM9h4Bg9MwkRGTg1UCcjmBvedzOnDI9KxtXdQ7rKMgW8IYCNE
	utYpwXQZuYFvYe5Onrpp+ANb55ZUJJzeGiZJYoUYeBn3+XRfnH8xuXEBP18QqpxqWHpQm46GP56
	BCUW2/DIhdkPInJOFK/aJSqSj15bCf0NOgkdcCa8fzoPAHZMcknI10qum0fL1sJffmc3Pnenx9N
	3bbCEXfR9LV9UDGajiz+7TV7QFKjPF4/hy0eZ862JzsVfv414dJoWipytz2CjhNBZdRQb/alKy4
	SNQsWW2FBLMY730SoQKo4fHZYT/9gWfmpEWc6vA9Bu9et4RSHRIv0FD/ZIhWt9JjgHEGLDz3ZAy
	r3005aL/PqzNjS4QPPJXBa9L7M
X-Received: by 2002:a05:622a:1883:b0:506:1d7a:7250 with SMTP id d75a77b69052e-508db3d666amr19646941cf.66.1772627132447;
        Wed, 04 Mar 2026 04:25:32 -0800 (PST)
Received: from [127.0.0.1] ([4.227.135.148])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50744afa7d7sm153313601cf.32.2026.03.04.04.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 04:25:31 -0800 (PST)
Message-Id: <pull.2138.v31.git.git.1772627131.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v30.git.git.1772102022.gitgitgadget@gmail.com>
References: <pull.2138.v30.git.git.1772102022.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Mar 2026 12:25:29 +0000
Subject: [PATCH v31 0/2] status: add status.compareBranches config for multiple branch comparisons
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

cc: Chris Torek chris.torek@gmail.com cc: Yee Cheng Chin
ychin.macvim@gmail.com cc: "brian m. carlson" sandals@crustytoothpaste.net
cc: Ben Knoble ben.knoble@gmail.com cc: "Kristoffer Haugsbakk"
kristofferhaugsbakk@fastmail.com cc: Phillip Wood phillip.wood123@gmail.com
cc: Nico Williams nico@cryptonector.com cc: Patrick Steinhardt ps@pks.im cc:
Jeff King peff@peff.net

Harald Nordgren (2):
  refactor format_branch_comparison in preparation
  status: add status.compareBranches config for multiple branch
    comparisons

 Documentation/config/status.adoc |  25 +++
 remote.c                         | 178 ++++++++++++----
 t/t6040-tracking-info.sh         | 354 +++++++++++++++++++++++++++++++
 3 files changed, 520 insertions(+), 37 deletions(-)


base-commit: 50d063e335afd5828fbb9de2f2b2fb44fd884d2b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2138%2FHaraldNordgren%2Fahead_of_main_status-v31
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2138/HaraldNordgren/ahead_of_main_status-v31
Pull-Request: https://github.com/git/git/pull/2138

Range-diff vs v30:

 1:  7f517b8c7f = 1:  320c1ce55a refactor format_branch_comparison in preparation
 2:  501bd40294 ! 2:  f07ccb278c status: add status.compareBranches config for multiple branch comparisons
     @@ Documentation/config/status.adoc: status.aheadBehind::
      +If not set, the default behavior is equivalent to `@{upstream}`, which
      +compares against the configured upstream tracking branch.
      ++
     ++The entries are shown in the order they appear in the configuration.
     ++Duplicate entries that resolve to the same ref are suppressed after
     ++their first occurrence, so `@{push} @{upstream} @{push}` shows at
     ++most two comparisons.  When `@{upstream}` and `@{push}` resolve to
     ++the same remote-tracking branch, only one comparison is shown.
     +++
      +Example:
      ++
      +----
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
       '
       
      +test_expect_success 'status tracking origin/main shows only main' '
     -+	(
     -+		cd test &&
     -+		git checkout b4 &&
     -+		git status >../actual
     -+	) &&
     ++	git -C test checkout b4 &&
     ++	git -C test status >actual &&
      +	cat >expect <<-EOF &&
      +	On branch b4
      +	Your branch is ahead of ${SQ}origin/main${SQ} by 2 commits.
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +'
      +
      +test_expect_success 'status --no-ahead-behind tracking origin/main shows only main' '
     -+	(
     -+		cd test &&
     -+		git checkout b4 &&
     -+		git status --no-ahead-behind >../actual
     -+	) &&
     ++	git -C test checkout b4 &&
     ++	git -C test status --no-ahead-behind >actual &&
      +	cat >expect <<-EOF &&
      +	On branch b4
      +	Your branch and ${SQ}origin/main${SQ} refer to different commits.
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'status.compareBranches from upstream has no duplicates' '
     ++test_expect_success 'status.compareBranches deduplicates when upstream and push are the same' '
      +	test_config -C test status.compareBranches "@{upstream} @{push}" &&
      +	git -C test checkout main &&
      +	git -C test status >actual &&
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'status.compareBranches shows ahead of both upstream and push branch' '
     ++test_expect_success 'status.compareBranches with only upstream shows only upstream' '
     ++	test_config -C test status.compareBranches "@{upstream}" &&
     ++	git -C test checkout main &&
     ++	git -C test status >actual &&
     ++	cat >expect <<-EOF &&
     ++	On branch main
     ++	Your branch is up to date with ${SQ}origin/main${SQ}.
     ++
     ++	nothing to commit, working tree clean
     ++	EOF
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'status.compareBranches with only push shows only push' '
      +	test_config -C test push.default current &&
     -+	test_config -C test status.compareBranches "@{upstream} @{push}" &&
     ++	test_config -C test status.compareBranches "@{push}" &&
      +	git -C test checkout -b feature2 origin/main &&
      +	git -C test push origin HEAD &&
      +	(cd test && advance work) &&
      +	git -C test status >actual &&
      +	cat >expect <<-EOF &&
      +	On branch feature2
     ++	Your branch is ahead of ${SQ}origin/feature2${SQ} by 1 commit.
     ++	  (use "git push" to publish your local commits)
     ++
     ++	nothing to commit, working tree clean
     ++	EOF
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'status.compareBranches shows ahead of both upstream and push branch' '
     ++	test_config -C test push.default current &&
     ++	test_config -C test status.compareBranches "@{upstream} @{push}" &&
     ++	git -C test checkout -b feature3 origin/main &&
     ++	git -C test push origin HEAD &&
     ++	(cd test && advance work) &&
     ++	git -C test status >actual &&
     ++	cat >expect <<-EOF &&
     ++	On branch feature3
      +	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
      +
     -+	Your branch is ahead of ${SQ}origin/feature2${SQ} by 1 commit.
     ++	Your branch is ahead of ${SQ}origin/feature3${SQ} by 1 commit.
      +	  (use "git push" to publish your local commits)
      +
      +	nothing to commit, working tree clean
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +test_expect_success 'checkout with status.compareBranches shows both branches' '
      +	test_config -C test push.default current &&
      +	test_config -C test status.compareBranches "@{upstream} @{push}" &&
     -+	git -C test checkout feature2 >actual &&
     ++	git -C test checkout feature3 >actual &&
      +	cat >expect <<-EOF &&
      +	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
      +
     -+	Your branch is ahead of ${SQ}origin/feature2${SQ} by 1 commit.
     ++	Your branch is ahead of ${SQ}origin/feature3${SQ} by 1 commit.
      +	  (use "git push" to publish your local commits)
      +	EOF
      +	test_cmp expect actual
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	test_cmp expect actual
      +'
      +
     ++test_expect_success 'status.compareBranches deduplicates repeated specifiers' '
     ++	test_config -C test push.default current &&
     ++	test_config -C test remote.pushDefault origin &&
     ++	test_config -C test status.compareBranches "@{push} @{upstream} @{push}" &&
     ++	git -C test checkout -b feature7 upstream/main &&
     ++	git -C test push origin &&
     ++	(cd test && advance work) &&
     ++	git -C test status >actual &&
     ++	cat >expect <<-EOF &&
     ++	On branch feature7
     ++	Your branch is ahead of ${SQ}origin/feature7${SQ} by 1 commit.
     ++	  (use "git push" to publish your local commits)
     ++
     ++	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
     ++
     ++	nothing to commit, working tree clean
     ++	EOF
     ++	test_cmp expect actual
     ++'
     ++
      +test_expect_success 'status.compareBranches with diverged push branch' '
      +	test_config -C test push.default current &&
      +	test_config -C test remote.pushDefault origin &&
      +	test_config -C test status.compareBranches "@{upstream} @{push}" &&
     -+	git -C test checkout -b feature7 upstream/main &&
     -+	(cd test && advance work71) &&
     ++	git -C test checkout -b feature8 upstream/main &&
     ++	(cd test && advance work81) &&
      +	git -C test push origin &&
      +	git -C test reset --hard upstream/main &&
     -+	(cd test && advance work72) &&
     ++	(cd test && advance work82) &&
      +	git -C test status >actual &&
      +	cat >expect <<-EOF &&
     -+	On branch feature7
     ++	On branch feature8
      +	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
      +
     -+	Your branch and ${SQ}origin/feature7${SQ} have diverged,
     ++	Your branch and ${SQ}origin/feature8${SQ} have diverged,
      +	and have 1 and 1 different commits each, respectively.
      +
      +	nothing to commit, working tree clean
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	test_config -C test push.default current &&
      +	test_config -C test remote.pushDefault origin &&
      +	test_config -C test status.compareBranches "@{upstream} @{push}" &&
     -+	git -C test checkout -b feature8 upstream/main &&
     ++	git -C test checkout -b feature9 upstream/main &&
      +	git -C test push origin &&
      +	git -C test status >actual &&
      +	cat >expect <<-EOF &&
     -+	On branch feature8
     ++	On branch feature9
      +	Your branch is up to date with ${SQ}upstream/main${SQ}.
      +
     -+	Your branch is up to date with ${SQ}origin/feature8${SQ}.
     ++	Your branch is up to date with ${SQ}origin/feature9${SQ}.
      +
      +	nothing to commit, working tree clean
      +	EOF
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	test_config -C test push.default current &&
      +	test_config -C test remote.pushDefault origin &&
      +	test_config -C test status.compareBranches "@{upstream} @{push}" &&
     -+	git -C test checkout feature8 >actual &&
     ++	git -C test checkout feature9 >actual &&
      +	git -C test push origin &&
      +	git -C test status --no-ahead-behind >actual &&
      +	cat >expect <<-EOF &&
     -+	On branch feature8
     ++	On branch feature9
      +	Your branch is up to date with ${SQ}upstream/main${SQ}.
      +
     -+	Your branch is up to date with ${SQ}origin/feature8${SQ}.
     ++	Your branch is up to date with ${SQ}origin/feature9${SQ}.
      +
      +	nothing to commit, working tree clean
      +	EOF
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	test_config -C test push.default current &&
      +	test_config -C test remote.pushDefault origin &&
      +	test_config -C test status.compareBranches "@{upstream} @{push}" &&
     -+	git -C test checkout feature8 >actual &&
     ++	git -C test checkout feature9 >actual &&
      +	cat >expect <<-EOF &&
      +	Your branch is up to date with ${SQ}upstream/main${SQ}.
      +
     -+	Your branch is up to date with ${SQ}origin/feature8${SQ}.
     ++	Your branch is up to date with ${SQ}origin/feature9${SQ}.
      +	EOF
      +	test_cmp expect actual
      +'
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	git -C test checkout -b ahead upstream/main &&
      +	(cd test && advance work) &&
      +	git -C test push upstream HEAD &&
     -+	git -C test checkout -b feature9 upstream/main &&
     ++	git -C test checkout -b feature10 upstream/main &&
      +	git -C test push origin &&
      +	git -C test branch --set-upstream-to upstream/ahead &&
      +	git -C test status >actual &&
      +	cat >expect <<-EOF &&
     -+	On branch feature9
     ++	On branch feature10
      +	Your branch is behind ${SQ}upstream/ahead${SQ} by 1 commit, and can be fast-forwarded.
      +	  (use "git pull" to update your local branch)
      +
     -+	Your branch is up to date with ${SQ}origin/feature9${SQ}.
     ++	Your branch is up to date with ${SQ}origin/feature10${SQ}.
      +
      +	nothing to commit, working tree clean
      +	EOF
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +'
      +
      +test_expect_success 'status.compareBranches with remapped push refspec' '
     -+	test_config -C test remote.origin.push refs/heads/feature10:refs/heads/remapped &&
     ++	test_config -C test remote.origin.push refs/heads/feature11:refs/heads/remapped &&
      +	test_config -C test status.compareBranches "@{upstream} @{push}" &&
     -+	git -C test checkout -b feature10 origin/main &&
     ++	git -C test checkout -b feature11 origin/main &&
      +	git -C test push &&
      +	(cd test && advance work) &&
      +	git -C test status >actual &&
      +	cat >expect <<-EOF &&
     -+	On branch feature10
     ++	On branch feature11
      +	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
      +
      +	Your branch is ahead of ${SQ}origin/remapped${SQ} by 1 commit.
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +
      +test_expect_success 'status.compareBranches with remapped push and upstream remote' '
      +	test_config -C test remote.pushDefault origin &&
     -+	test_config -C test remote.origin.push refs/heads/feature11:refs/heads/remapped &&
     ++	test_config -C test remote.origin.push refs/heads/feature12:refs/heads/remapped &&
      +	test_config -C test status.compareBranches "@{upstream} @{push}" &&
     -+	git -C test checkout -b feature11 upstream/main &&
     ++	git -C test checkout -b feature12 upstream/main &&
      +	git -C test push origin &&
      +	(cd test && advance work) &&
      +	git -C test status >actual &&
      +	cat >expect <<-EOF &&
     -+	On branch feature11
     ++	On branch feature12
      +	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
      +
      +	Your branch is ahead of ${SQ}origin/remapped${SQ} by 1 commit.

-- 
gitgitgadget

Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106381397
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 21:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767389654; cv=none; b=qB2wZ+s6r+wzPRaNFEO73yTtUOjgiE7IrSLBnRWxlDpdPw2if7dKwZieV/8/ERYJWPyPeBM4WFv7trKyvC/l7v9RkZbVnvIQGaX59Kk4v9irfKU1dL3lgtL2lpd/WHlDkNm5uUpehiL8JwmBsZlOR80g54aZ4MEja+uqj2YwVC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767389654; c=relaxed/simple;
	bh=31MpljcKeBF1cKJReROhNO0ABccAwyeyXFoOkr3VAdg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=K1s0FdZILvMj25/bCgQqPIbkOC44YRuaHsRqe6mysYgWhC/pVakhFq12wI8SZ8Gv65SCkdFR+NrucwHFG3NnOVV590jRjaNRmB6nNCdU7njdISSzxP9OTXV5Tx5rVvzu5IieGwDlBIbnXmw1fb8gcslisTeS2j+yhsqeI7NzKUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwgQMlKZ; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwgQMlKZ"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-88860551e39so106912676d6.3
        for <git@vger.kernel.org>; Fri, 02 Jan 2026 13:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767389650; x=1767994450; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0k263GegizBNmDfc8wKJXZnZTh4QCL/bzGPx/hpAUw=;
        b=hwgQMlKZbw1ENBsRBz3vRoxVb6PMbTgtpr3cCNdClYHRTA6jPywOuHx8zbC0rK9j93
         u1P3pJ2lNZeHjkmnJVK4r4iPeEPOX4vDmeKJ6nt55KSd0hddwDH+mRMOhCwTS+U+D+nG
         9326IlFPHDpzdT9cl4YZbfh9+tHmFYBDdunG+pQwpyt3qTO/oXeON8lp5BB4MBCK+V91
         1jjVZX4JZIdIOj6PURhP6QloErV5ETaPLRjS30a1lvk1VrWpL9Qt6C7VhnaUS6kjgxkL
         RGdacu/Uj8ncW+ka5HUcrPFlEIDb0GqYCQOqYSptxWmDd99Sv84QSt98qO+GRUrH/TPD
         PO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767389650; x=1767994450;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u0k263GegizBNmDfc8wKJXZnZTh4QCL/bzGPx/hpAUw=;
        b=jzOEe1HA/c8Li0rfagQzgvWn6RONg6MP309CRh6HxAmD/LLCNXRaDfOm7qNMPaaA+p
         sPa44iZzQGnNKH0NPkg/zj/Q9dGb/T2TDF4z9nBRMcdYaV9HBAdtnFT8Sy3qK2AvEbMt
         +mU9bUKdoMrxCrHVeB7pHD+xWJeiKfPeWe414FlCQ0xrIo/NELGTeFnwTi30eY/9nWaG
         w2/1Ah/wJHRO8R+DATg7z18cvgb27eT/DH5tCbdHqWNoWIOzD4ZNtPGlZ7zLbd8prrZ/
         FzWloFBVtTMhWaUn1bCz+p867XDJ6atW3iJtftoDuYHw34X8XTpRyKRzYxmv3r3t/NV5
         AYXg==
X-Gm-Message-State: AOJu0YwS7njyOUKnx1/Bdcp0aH39s0dhA4h2xJTaLcWaQ8EwUaByu288
	W64CS7VjCmyl98N3CnHkWBF/lMUiApHgKWBFZrrYhDeUiSx3ipFoQzHd6t9dFw==
X-Gm-Gg: AY/fxX7/dQCF7G8hAmbgT/Mx5V1N5D9IS1g8mTHI9m8fFJXxOl/npRNhyH+Ka+efehR
	/NHce4OxszBNBi+R/mS2rEnibV6AL57ejkq6QYZX+UBpnEkjLhmmYWlN+YPpxGc97E1nS5qdPXU
	+Zgl4YEAwmaWor6113MRvKhqDA7fYHvOEvEu4ABmvtcdR1pZwooCjjSHj1xwn9AWp3jE0bYwK30
	iNY/Yr/qzlqMfDS5zPO+xdjAnoWSp1BSo+ZRDw6OMZM6h0mMIV52qtevNSK/xYMq2zSSnFRwDhd
	SeJ4h6S1TLlUwwf1m/M89uEbhIL0w5ogaC6LKtqJuCqJVqz8BdxSOcygnakHyNzwlzP9Ys5//Ar
	rHZYmM3jmoIrzrExcvP4wXf0Cqbc75DAd5gY08AHHS6tqOMlMR8gr/7z/dHqYxZcl0yTj/azOyi
	YjnZWiDbRJQH6T
X-Google-Smtp-Source: AGHT+IGfzi6Pi9GZta8GBAPQKRbP11NKt7nZjDw3Wx+dRo+1I8YeykbnFeykqa9A+VV1I4HaVwKzzA==
X-Received: by 2002:a05:6214:570c:b0:890:5973:a567 with SMTP id 6a1803df08f44-8905973a83bmr14574286d6.12.1767389650064;
        Fri, 02 Jan 2026 13:34:10 -0800 (PST)
Received: from [127.0.0.1] ([20.161.70.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d969fed73sm303444666d6.15.2026.01.02.13.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 13:34:09 -0800 (PST)
Message-Id: <pull.2138.v12.git.git.1767389649.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v11.git.git.1767352663477.gitgitgadget@gmail.com>
References: <pull.2138.v11.git.git.1767352663477.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Jan 2026 21:34:07 +0000
Subject: [PATCH v12 0/2] status: show comparison with push remote tracking branch
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

Harald Nordgren (2):
  refactor: format_branch_comparison in preparation
  status: show comparison with push remote tracking branch

 remote.c                 | 164 +++++++++++++++++++++++++++++---------
 t/t6040-tracking-info.sh | 168 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 295 insertions(+), 37 deletions(-)


base-commit: 68cb7f9e92a5d8e9824f5b52ac3d0a9d8f653dbe
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2138%2FHaraldNordgren%2Fahead_of_main_status-v12
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2138/HaraldNordgren/ahead_of_main_status-v12
Pull-Request: https://github.com/git/git/pull/2138

Range-diff vs v11:

 -:  ---------- > 1:  a2c160c53e refactor: format_branch_comparison in preparation
 1:  53bb1cb6bb ! 2:  a586038d1f status: show comparison with push remote tracking branch
     @@ Commit message
          builds upon, to show "ahead", "behind", or "diverged" status.
      
          When working on a feature branch that tracks a remote feature branch,
     -    but you also want to track progress relative to the push remote's
     +    but you also want to track progress relative to the push destination
          tracking branch (which may differ from the upstream branch), git status
          now shows an additional comparison.
      
     -    When a push remote is configured (via branch.<name>.pushRemote or
     -    remote.pushDefault), git status shows both the comparison with the
     -    upstream tracking branch (as before) and an additional comparison with
     -    the push remote's tracking branch, if it differs from the upstream
     -    tracking branch. The push branch comparison appears on a separate
     -    line after the upstream branch status, using the same format:
     -    - "Ahead of 'origin/feature' by N commits" when purely ahead
     -    - "Behind 'origin/feature' by N commits" when purely behind
     -    - "Diverged from 'origin/feature' by N commits" when diverged
     +    When the upstream tracking branch differs from the push destination
     +    tracking branch, git status shows both the comparison with the upstream
     +    tracking branch (as before) and an additional comparison with the push
     +    destination tracking branch. The push branch comparison appears on a
     +    separate line after the upstream branch status, using the same format.
      
     -    Example output when tracking upstream/main with pushRemote set to origin:
     +    Example output when tracking origin/main but push destination is
     +    origin/feature:
              On branch feature
     -        Your branch is ahead of 'upstream/main' by 2 commits.
     +        Your branch and 'origin/main' have diverged,
     +        and have 3 and 1 different commits each, respectively.
                (use "git pull" if you want to integrate the remote branch with yours)
      
     -        Ahead of 'origin/feature' by 5 commits.
     +        Your branch is ahead of 'origin/feature' by 1 commit.
     +          (use "git push" to publish your local commits)
      
     -    The comparison is only shown when a push remote is configured and the
     -    push remote's tracking branch differs from the upstream tracking branch.
     +    The comparison is only shown when the push destination tracking branch
     +    differs from the upstream tracking branch, even if they are on the same
     +    remote.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ remote.c: int stat_tracking_info(struct branch *branch, int *num_ours, int *num_
      +{
      +	const char *push_remote;
      +	const char *resolved;
     -+	int flag;
      +	struct strbuf ref_buf = STRBUF_INIT;
      +	char *ret = NULL;
      +
     @@ remote.c: int stat_tracking_info(struct branch *branch, int *num_ours, int *num_
      +		get_main_ref_store(the_repository),
      +		ref_buf.buf,
      +		RESOLVE_REF_READING,
     -+		NULL, &flag);
     ++		NULL, NULL);
      +
      +	if (resolved) {
      +		if (full_ref_out)
     @@ remote.c: int stat_tracking_info(struct branch *branch, int *num_ours, int *num_
      +	return ret;
      +}
      +
     -+static void format_push_branch_comparison(struct strbuf *sb,
     -+					     const char *branch_refname,
     -+					     const char *push_full,
     -+					     const char *push_short,
     -+					     enum ahead_behind_flags abf)
     -+{
     -+	int push_ahead = 0, push_behind = 0;
     -+	int stat_result;
     -+
     -+	stat_result = stat_branch_pair(branch_refname, push_full,
     -+				       &push_ahead, &push_behind, abf);
     -+	if (stat_result < 0)
     -+		return;
     -+
     -+	strbuf_addstr(sb, "\n");
     -+
     -+	if (stat_result == 0 || (push_ahead == 0 && push_behind == 0)) {
     -+		strbuf_addf(sb,
     -+			_("Your branch is up to date with '%s'.\n"),
     -+			push_short);
     -+	} else if (push_ahead > 0 && push_behind == 0) {
     -+		strbuf_addf(sb,
     -+			Q_("Ahead of '%s' by %d commit.\n",
     -+			   "Ahead of '%s' by %d commits.\n",
     -+			   push_ahead),
     -+			push_short, push_ahead);
     -+	} else if (push_behind > 0 && push_ahead == 0) {
     -+		strbuf_addf(sb,
     -+			Q_("Behind '%s' by %d commit.\n",
     -+			   "Behind '%s' by %d commits.\n",
     -+			   push_behind),
     -+			push_short, push_behind);
     -+	} else if (push_ahead > 0 && push_behind > 0) {
     -+		strbuf_addf(sb,
     -+			Q_("Diverged from '%s' by %d commit.\n",
     -+			   "Diverged from '%s' by %d commits.\n",
     -+			   push_ahead + push_behind),
     -+			push_short, push_ahead + push_behind);
     -+	}
     -+}
     -+
     - /*
     -  * Return true when there is anything to report, otherwise false.
     -  */
     + static void format_branch_comparison(struct strbuf *sb,
     + 				     int ahead, int behind,
     + 				     const char *branch_name,
      @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
     + 	const char *full_base;
     + 	char *base;
     + 	int upstream_is_gone = 0;
     ++	int push_ours = 0, push_theirs = 0;
     ++	int push_stat_result = -1;
     ++	int will_show_push_comparison = 0;
       
     + 	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
     + 	if (sti < 0) {
     +@@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
       	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
       					    full_base, 0);
     + 
     ++	if (!upstream_is_gone && abf != AHEAD_BEHIND_QUICK) {
     ++		char *push_full = NULL;
     ++		char *push_short = get_remote_push_branch(branch, &push_full);
      +
     - 	if (upstream_is_gone) {
     - 		strbuf_addf(sb,
     - 			_("Your branch is based on '%s', but the upstream is gone.\n"),
     -@@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
     ++		if (push_short && strcmp(base, push_short)) {
     ++			push_stat_result = stat_branch_pair(branch->refname, push_full,
     ++							    &push_ours, &push_theirs, abf);
     ++			if (push_stat_result >= 0)
     ++				will_show_push_comparison = 1;
     ++		}
     ++
     ++		free(push_short);
     ++		free(push_full);
     ++	}
     ++
     + 	format_branch_comparison(sb, ours, theirs, base, upstream_is_gone, abf, sti);
     + 	if (sti > 0 && abf != AHEAD_BEHIND_QUICK) {
     +-		if (!theirs && advice_enabled(ADVICE_STATUS_HINTS)) {
     ++		if (!theirs && !will_show_push_comparison &&
     ++		    advice_enabled(ADVICE_STATUS_HINTS)) {
       			strbuf_addstr(sb,
     - 				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
     + 				_("  (use \"git push\" to publish your local commits)\n"));
     + 		} else if (!ours && advice_enabled(ADVICE_STATUS_HINTS)) {
     +@@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
     + 		}
       	}
     -+
     -+	if (!upstream_is_gone && sti >= 0 && abf != AHEAD_BEHIND_QUICK) {
     + 
     ++	if (will_show_push_comparison) {
      +		char *push_full = NULL;
      +		char *push_short = get_remote_push_branch(branch, &push_full);
      +
     -+		if (push_short && strcmp(base, push_short))
     -+			format_push_branch_comparison(sb, branch->refname, push_full,
     -+						     push_short, abf);
     ++		if (push_short && strcmp(base, push_short)) {
     ++			strbuf_addstr(sb, "\n");
     ++			format_branch_comparison(sb, push_ours, push_theirs, push_short, 0, abf,
     ++						push_ours || push_theirs);
     ++			if (push_ours > 0 && push_theirs == 0 &&
     ++			    advice_enabled(ADVICE_STATUS_HINTS)) {
     ++				strbuf_addstr(sb,
     ++					_("  (use \"git push\" to publish your local commits)\n"));
     ++			}
     ++		}
      +
      +		free(push_short);
      +		free(push_full);
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	cat >expect <<-EOF &&
      +	On branch feature2
      +	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
     -+	  (use "git push" to publish your local commits)
      +
     -+	Ahead of ${SQ}origin/feature2${SQ} by 1 commit.
     ++	Your branch is ahead of ${SQ}origin/feature2${SQ} by 1 commit.
     ++	  (use "git push" to publish your local commits)
      +
      +	nothing to commit, working tree clean
      +	EOF
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	) &&
      +	cat >expect <<-EOF &&
      +	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
     -+	  (use "git push" to publish your local commits)
      +
     -+	Ahead of ${SQ}origin/feature2${SQ} by 1 commit.
     ++	Your branch is ahead of ${SQ}origin/feature2${SQ} by 1 commit.
     ++	  (use "git push" to publish your local commits)
      +	EOF
      +	test_cmp expect actual
      +'
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	and have 3 and 1 different commits each, respectively.
      +	  (use "git pull" if you want to integrate the remote branch with yours)
      +
     -+	Ahead of ${SQ}origin/feature4${SQ} by 1 commit.
     ++	Your branch is ahead of ${SQ}origin/feature4${SQ} by 1 commit.
     ++	  (use "git push" to publish your local commits)
      +
      +	nothing to commit, working tree clean
      +	EOF
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	cat >expect <<-EOF &&
      +	On branch feature5
      +	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
     -+	  (use "git push" to publish your local commits)
      +
     -+	Ahead of ${SQ}origin/feature5${SQ} by 1 commit.
     ++	Your branch is ahead of ${SQ}origin/feature5${SQ} by 1 commit.
     ++	  (use "git push" to publish your local commits)
      +
      +	nothing to commit, working tree clean
      +	EOF
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	cat >expect <<-EOF &&
      +	On branch feature6
      +	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
     -+	  (use "git push" to publish your local commits)
      +
     -+	Diverged from ${SQ}origin/feature6${SQ} by 2 commits.
     ++	Your branch and ${SQ}origin/feature6${SQ} have diverged,
     ++	and have 1 and 1 different commits each, respectively.
      +
      +	nothing to commit, working tree clean
      +	EOF

-- 
gitgitgadget

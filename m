Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E1D33A6FB
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771511209; cv=none; b=Yl9QGktlXp8rNi4Nnje0mrtzWf3oKFsEP7ZL3w+cZ1UZEiMVg8EAM17+r87FJQVwIug8CFT9C0oL8eWQsveqEw0Og9b+JcPtKFDLzyhrlT7hh/XWlyqb2KfjCl+3mlTpGuyXRHKrL4Ehl3aDIpL+eHw0vlWyRBNSV7ztnICf6qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771511209; c=relaxed/simple;
	bh=6xdB26cKhIBVFcc2qMbUijlgxJLYkMDCG8QCwjAfwaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BS2KQ0k2J4O/cp2JgdGprdGi4vcI0h3gy5rmXjWWh/3i4lQeb6mrUgk/hvOsfSIsP7YIXEVcPt0jZzjegyif5A8U3swnm+GTYzBFNibjWZlcwnuTV6bMdPsx0As1RyyjgH06P3HDtAnl0QeLloG878gg8pGw3nDLEmlghZpeMfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4Rqwu59; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4Rqwu59"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-481188b7760so8943315e9.0
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 06:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771511206; x=1772116006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dNI4hB5x+4+BOUnSkrNG7padk4LpZe8nGdStHunVcMA=;
        b=E4Rqwu59w/t6o6hlUpdhfDzRiFsJ5F+K+9pcYrT7ioO8tGpkx/DQaVbYlf/WTRoVV7
         6Afhd3fNE0CCKBus3ZPs3Pk459VzvM3XhHJIBMKXdeccQLK5Ragc5QlEf5yDxhCEezpx
         CGzU8FpcjzGhDtpJASpbuwynwJhxdGE89Tf2UARlXX6b/BZyllF7ZPD6woUn8SxvVTVI
         R5s4sPRuIFOH9U0HqRtJmtyQhfC7ZbWyq1Yo2qxVdE/w0BIPYSx5mQH0UEraeyYbfhUq
         0INCJkyEdzv1TcSpKc2euoOVlnIF5waUXmzxgyIHf3A6zXwx0mtxvOcy6Oouy1jU3eq0
         uKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771511206; x=1772116006;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dNI4hB5x+4+BOUnSkrNG7padk4LpZe8nGdStHunVcMA=;
        b=JEJcq9jMP587EsSFsQTjyvuxXvNYUKMVfzaBMkuEh0DhP46BM03qf2seuMXUdPwBA2
         WgKssVAgwHG+yEYOS7Yx2T2k1PaqULQb2HjSgP164kN47Vc1jCs4AoEQlH+V3JNbcfHs
         QBu1cw1xZd9nA74do2OV1NK10k7uHeXI7vpeQRyyX+rvuYSqf163cuij0PSmJSy8DCaj
         5skSWlpJbydqracujp42bkY+qdqCs3VqSnrUZBHOiDgNiVZQxmyPhXcrVwjrj96ZML0R
         GKm1qxFQKmT/zDCi3Lk+5xuPMWVl+EIsg8W7XCwigNGHckhKOUrCpK0jT7bzejUGksMD
         OEPQ==
X-Gm-Message-State: AOJu0YwaIOt/cLjAA43WD8J1LMQuPawcGqEatscJ7SmBHENqTRQXS0FP
	Jk0j28o6kj5y7FRM+o7U4kwyvXbpLQ6uTQ4gWpNfqOpCzwJV2C0rmlTJ8y7jGaMp
X-Gm-Gg: AZuq6aJZUHF9Eo7v3Etwa8mBbMHUEL//EV3SAQoQbG7U4rdolS2LHwZqqtYJjTYdtjQ
	ViYXHVfqoiOsVVpGgYPdw4JcL4Db1HXkIXHyVK9hYyjQ9VvSx9EuTZSz/KrcPbrSDTzra2GhyXP
	wnmwKJkxsvCGDr18+guYDron1QJPiG2QeN2bgh2irvUbN17Bl9uia4x+wGWCF5J2ks1gfSlgMu1
	xevBtUesqJ8dnek7fD3ugwA6d/G1Go50cbnKqRPs8ggIkU7PZ9Y3Fgye0Huk5mig+OwWymNPpTl
	NXeKrMHNoSqyI88lGtaEgR1+zOpa6B3RpLE3QGn+rqUcrhZ/x4Ytd09tyv4Akg1lUovhNdcNizB
	O+b+GYcM5EAv0WFO1apnxijmHDgqKtH/8g/D//7VyjSOgVNkQaJSMPQklkm9DxaQssp0cFZHIzl
	E1lktc7phsJ38yVagOZxrWUH3UoAA=
X-Received: by 2002:a05:600c:1387:b0:480:3ad0:93bf with SMTP id 5b1f17b1804b1-4839e661cd7mr47338895e9.24.1771511205647;
        Thu, 19 Feb 2026 06:26:45 -0800 (PST)
Received: from berwick ([2a0a:ef40:68d:f601:6840:9d65:3109:8533])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4839f99275esm21611135e9.32.2026.02.19.06.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 06:26:45 -0800 (PST)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 0/2] worktree_git_path(): remove repository argument
Date: Thu, 19 Feb 2026 14:26:31 +0000
Message-ID: <cover.1771511192.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9
In-Reply-To: <cover.1771258688.git.phillip.wood@dunelm.org.uk>
References: <cover.1771258688.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

These patches remove the repository argument from worktree_git_path()
in favor of using the repository in the "sturct worktree" argument.
This enables us to remove some uses of "the_repository". The first
patch adds a new function git_worktree_from_repository() to construct
a "struct worktree" based on the repository's worktree and uses it
to avoid passing a NULL worktree to worktree_git_path(). The second
patch then removes the repository argument from that function and
always uses the repository in the worktree argument instead.

Thanks to Karthik and Junio for their comments, here are the changes
since V1:
 - always set worktree path - for bare repositories the worktree path
   is repo->gitdir
 - fix the worktree bareness (there were too many negations)
 - fix the wortkree id (it comes from repo->gitdir not repo->commondir)
 - add a test for "git status" on a rebase in a linked worktree.
 - expand the commit message to explain
   (a) that we use the "gitdir" and "worktree" members of "struct
       repository" to construct the "struct worktree"
   (b) how the "current" worktree is determined

Base-Commit: 852829b3dd2fe4e7c7fc4d8badde644cf1b66c74
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fget-current-worktree%2Fv2
View-Changes-At: https://github.com/phillipwood/git/compare/852829b3d...db9d519cb
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/get-current-worktree/v2


Phillip Wood (2):
  wt-status: avoid passing NULL worktree
  path: remove repository argument from worktree_git_path()

 builtin/fsck.c         |  2 +-
 builtin/worktree.c     |  4 ++--
 path.c                 |  9 ++++-----
 path.h                 |  8 +++-----
 revision.c             |  2 +-
 t/t7512-status-help.sh |  9 +++++++++
 worktree.c             | 22 +++++++++++++++++++++-
 worktree.h             |  6 ++++++
 wt-status.c            | 29 +++++++++++++++++++----------
 9 files changed, 66 insertions(+), 25 deletions(-)

Range-diff against v1:
1:  409871a7d52 ! 1:  902295b8714 wt-status: avoid passing NULL worktree
    @@ Commit message
     
         In preparation for removing the repository argument from
         worktree_git_path() add a function to construct a "struct worktree"
    -    from a "struct repository" and use that to avoid passing a NULL
    -    worktree to wt_status_check_bisect() and wt_status_check_rebase().
    +    from a "struct repository" using its "gitdir" and "worktree"
    +    members. This function is then used to avoid passing a NULL worktree to
    +    wt_status_check_bisect() and wt_status_check_rebase(). In general the
    +    "struct worktree" returned may not correspond to the "current" worktree
    +    defined by is_current_worktree() as that function uses "the_repository"
    +    rather than "wt->repo" when deciding which worktree is "current". In
    +    practice the "struct repository" we pass corresponds to "the_repository"
    +    as we only ever operate on a single repository at the moment.
     
         wt_status_check_bisect() and wt_status_check_rebase() have the following
         callers:
    @@ Commit message
            NULL worktree by this patch.
     
         This updates the only callers that pass a NULL worktree to
    -    worktree_git_path().
    +    worktree_git_path(). A new test is added to check that "git status"
    +    detects a rebase in a linked worktree.
     
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
    + ## t/t7512-status-help.sh ##
    +@@ t/t7512-status-help.sh: EOF
    + 	test_cmp expected actual
    + '
    + 
    ++test_expect_success 'rebase in a linked worktree' '
    ++	test_might_fail git rebase --abort &&
    ++	git worktree add wt &&
    ++	test_when_finished "test_might_fail git -C wt rebase --abort;
    ++				git worktree remove wt" &&
    ++	GIT_SEQUENCE_EDITOR="echo break >" git -C wt rebase -i HEAD &&
    ++	git -C wt status >actual &&
    ++	test_grep "interactive rebase in progress" actual
    ++'
    + 
    + test_expect_success 'prepare am_session' '
    + 	git reset --hard main &&
    +
      ## worktree.c ##
     @@ worktree.c: static int is_current_worktree(struct worktree *wt)
      	return is_current;
    @@ worktree.c: static int is_current_worktree(struct worktree *wt)
     +	char *commondir = absolute_pathdup(repo->commondir);
     +
     +	wt->repo = repo;
    -+	if (repo->worktree)
    -+		wt->path = absolute_pathdup(repo->worktree);
    -+	wt->is_bare = !!repo->worktree;
    ++	wt->path = absolute_pathdup(repo->worktree ? repo->worktree
    ++						   : repo->gitdir);
    ++	wt->is_bare = !repo->worktree;
     +	if (fspathcmp(gitdir, commondir))
    -+		wt->id = xstrdup(find_last_dir_sep(commondir) + 1);
    ++		wt->id = xstrdup(find_last_dir_sep(gitdir) + 1);
     +	wt->is_current = is_current_worktree(wt);
     +	add_head_info(wt);
     +
    @@ worktree.h: struct worktree **get_worktrees(void);
       */
      struct worktree **get_worktrees_without_reading_head(void);
      
    --/*
    -+/* Construct a struct worktree from a struct repository */
    ++/*
    ++ * Construct a struct worktree corresponding to repo->gitdir and
    ++ * repo->worktree.
    ++ */
     +struct worktree *get_worktree_from_repository(struct repository *repo);
     +
    -+ /*
    + /*
       * Returns 1 if linked worktrees exist, 0 otherwise.
       */
    - int submodule_uses_worktrees(const char *path);
     
      ## wt-status.c ##
     @@ wt-status.c: int wt_status_check_rebase(const struct worktree *wt,
2:  23b8a355b41 = 2:  db9d519cbda path: remove repository argument from worktree_git_path()
-- 
2.52.0.362.g884e03848a9


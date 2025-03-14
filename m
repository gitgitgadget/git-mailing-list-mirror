Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5C41953A2
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 08:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741941652; cv=none; b=aGC+pPoa7NZQYSiJ30cpOzVr6bxY4rV80Q+xCNTYb/0HSIufxpnf9DlIJvRvljdCCn6N4i79BKypFXY6BIHKMGwtO3ao6CUbG58Owfhch/4FqVsZMNx+GWKxlncvJW7aVt8ZPZlZh6G4Lzm/fmNQLyBlWVWkU19tY3u1Tzhpgwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741941652; c=relaxed/simple;
	bh=HC+9iSsn6NP4slrQVp4y7+tFiQQWe/20PNpYL2naMmI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=JwEKEBSV/R12f7xU021qAcfNNLQncsNdbeCcRa7X+Bn8J6WhnJ1VkhLElYPzatn55ZO1RhgEng80klIuWyzuV/fBWSdbtfuaYtwJYVOGbpnz+1plreNjr7IQXYlSkZlcLymZK82RqnBDPGv/mgShPUAD/yoYFGsZBNl8axsjmmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3EOJgvK; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3EOJgvK"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so403682166b.1
        for <git@vger.kernel.org>; Fri, 14 Mar 2025 01:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741941649; x=1742546449; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gp8GfZVbRDVL+df/pxDPTPtxftMsaa10sUH/suf/qOc=;
        b=l3EOJgvKULPlbl0eVXO2I4LF0jvb4gKLHp5CrC5fU1HzGmuEl22OXuxf36TjA2w0E0
         a7GLiCECPcWghloaYky+NMBPoAKU8MymR4dWsOpu0+z3xkBjyc5e5CL5Wbm4G3lsdu69
         3wTwgWXDsIj1fqBUNumoob8m5Gk7gbzyoW6ijP9hNvsHtLgfAEdAjXARkm/fGQUeX75p
         qIq+8MbeEgWNP6/fiG+CD22Tu7Op7L/UBK4l1Gegpx+J+THocCW83txee+zXd9HhNyCd
         nWY2m8Q2gCb15qYg5P5wKrpGUts3YbcSTYSTBvn+7B8TszTtJh0Agu0Hz2iTYvQwv4jY
         SPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741941649; x=1742546449;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gp8GfZVbRDVL+df/pxDPTPtxftMsaa10sUH/suf/qOc=;
        b=WxgaQcL8n02TjXJmbgvlW3ar0BkWxPkouocMbK9l4KePDQyRL5JNYHIM1P8L/5U6QD
         ss1kOvUnkffLVyfWirqym7S2OPnjkw1kbH0a+ajl0RtbKH1cqGBM4CEnArqqA28n2Bzh
         Mw6j3SVEm5/9LqyGqpRf9mZcG8N9YIbp57s0WEp5Sj+54mq9mCbI3hpd4rF4+5Rr20Qf
         Nmu5XuSEByBqpmpo3qoIC5kwN+coPFrufa+RICPNxLqWB+sHHonqkgwm1EFoCznpFo6x
         txgpObzkp+bnrC7mTWmB9VMRDyXQgH+dS0vm3RrdJ6F4bFxJfFfuorJTgttJ33O08RnF
         wNsg==
X-Gm-Message-State: AOJu0YyoUug0ld0tvFqCZQ/I+wyYEcd7T1Y+VPpzcVz3M6/+yPyBZzQN
	t/YxqOm175sj7EQ0YkuWANXP7oWyUf0YCS0IOgS9vBy3Vrdvy9vC
X-Gm-Gg: ASbGncveVFoCx38eRpCbKoByuQTHT9sh11ocdPGJ3V7fJOOqBu1yJZ+2WPr6VYP8wBo
	fnJfhKkzcaIIxNchVDydQQ9iSURohvEB22hsnoTsOxnwllkXs4OLh8D9IjOWgjfeEGwJ7+KTD/J
	S5Tphuwf9ztA3MMmUgEIP9vxjCKFad7mjYj3XNu+zHKyPV2y8erIYKDDhfie9uZTQLhGBFf+WJe
	WKpA6UH9AwH8ED+0A8Bn1e6hR/v7rDh+gVVhAKr2pnUG6cMyGNvZAb8E6wCYGJMDypvERb7TmUH
	SqHbna2FsfdojmF6OyiB3R48G9YVPb+5PyfhQL6EZZVtMNhfM1XXbTmWDUW16g==
X-Google-Smtp-Source: AGHT+IG/WwqDZPJu+Rm6ySRmYWU7y++sNYgTnPMyE7xYl1Cj+j9W5YYH6qV0eYgW4+ZRQT88g3RZUw==
X-Received: by 2002:a17:907:94c7:b0:ac2:1c64:b0a with SMTP id a640c23a62f3a-ac3301940d2mr142087066b.14.1741941648288;
        Fri, 14 Mar 2025 01:40:48 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:f2db:c900:a4aa:e466])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314858edcsm191081866b.85.2025.03.14.01.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 01:40:47 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 0/2] reflog: implement subcommand to drop reflogs
Date: Fri, 14 Mar 2025 09:40:33 +0100
Message-Id: <20250314-493-add-command-to-purge-reflog-entries-v3-0-c24e23a6146d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIHr02cC/42NSwqDMBBAryJZd0qMsWpXvUfpYkxGDaiRxIYW8
 e6NQsGlyzef9xbmyRny7J4szFEw3tgxQnZJmOpwbAmMjswEFznP+A1klQFqDcoOA44aZgvT28U
 7R01vW6Bx3oRQayFyWaDOJLJom+LefPbS8xW5M3627ruHQ7pN/43idCOkwKGUWJe5qFRT0aMd0
 PTX+Me2RhAHb8rPewVEc64QK0G8bvDoXdf1B97+J1U2AQAA
X-Change-ID: 20250306-493-add-command-to-purge-reflog-entries-bd22547ad34a
In-Reply-To: <20250307-493-add-command-to-purge-reflog-entries-v1-0-84ab8529cf9e@gmail.com>
References: <20250307-493-add-command-to-purge-reflog-entries-v1-0-84ab8529cf9e@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, kristofferhaugsbakk@fastmail.com, gitster@pobox.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=10919;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=HC+9iSsn6NP4slrQVp4y7+tFiQQWe/20PNpYL2naMmI=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGfT64/KkewgDS3hEiMixRk/cfrr1tMEvsJsK
 xlhk153AVjAN4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJn0+uPAAoJED7VnySO
 Rox//aoL/jy+rG8YIK35Ir8N6gIREc8/ws1CP1+7vbwN3iQp81K4meE/uHzEeJIpOPhLx+lvsv3
 naLalCqYsSxuaWJkzT0h6PlFDdLfKvl5e4pBCicd8nLSsek8D07mrNGyB7GgTjqHToHNptr/Jng
 ce616xv/QxDrnH6a7E4rqYhMLtXql2epWfJHOSm8UhwXOT2dvu5/DhYCJV9GM2FkrVVT4+dh7Zd
 CQnm296eINIwwqZK4XrIezd0ay+UfrIpZ7D2IJFvn9OnDrm/FU+e8Bwjj+94AprR43VueiHvd07
 njVW5/dHvzM+kaOxUnOCBjBgsa654hWpLuQPxTYbgInti8LX7Qz7Xpk+Wz1gZFqNDmjm3EZWeRx
 yb1FHW+QcSWbINnBytRdqgu4tBlW33Sn9vgKmhYBXQMgjwuPKXMiMgxzVa4n5k3B8jnMI+Siye3
 qCLn+Usn6A0hS/p8Rswh3FP0jfh/7pJVSxjlAOKZ+33NeTdq9MhhD+4mZPnBjnGBukjLRySaPw8
 OU=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

While 'git-reflog(1)' currently allows users to expire reflogs and
delete individual entries, it lacks functionality to completely remove
reflogs for specific references. This becomes problematic in
repositories where reflogs are not needed but continue to accumulate
entries despite setting 'core.logAllRefUpdates=false'.

Add a new 'drop' subcommand to git-reflog that allows users to delete
the entire reflog for a specified reference. Include a '--all' flag to
enable dropping all reflogs from all worktrees and an addon flag
'--single-worktree', to drop all reflogs from the current worktree.

The first patch is a small cleanup in 'git refs expire' which improves
the error message used when there is no reflog present for a given
reference.

Changes in v3:
- Add a preparatory commit to fix the error message in 'git reflog
  expire' when a non-existent ref is provided.
- Add support for '--single-worktree' to provide feature parity with
  'git reflog expire'.
- Improved error message and small code fixes.
- Added some additional tests.
- Link to v2: https://lore.kernel.org/r/20250310-493-add-command-to-purge-reflog-entries-v2-1-05caa92e0bfa@gmail.com

Changes in v2:
- Rephrase the commit message to be clearer and fix typo.
- Move the documentation to be next to 'git reflog delete' and also
  add missing documentation for the '--all' flag.
- Ensure '--all' is not used with references and add a test.
- Cleanup variable assignment.
- Check for error message in the test.
- Drop the cleanup commit.
- Rebased on top of master a36e024e98 (Merge branch 'js/win-2.49-build-fixes',
  2025-03-06), this was to include the adoc changes which were breaking
  tests on the CI.
- Link to v1: https://lore.kernel.org/r/20250307-493-add-command-to-purge-reflog-entries-v1-0-84ab8529cf9e@gmail.com

 Documentation/git-reflog.adoc |  23 ++++++--
 builtin/reflog.c              |  68 ++++++++++++++++++++++-
 t/t1410-reflog.sh             | 126 +++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 209 insertions(+), 8 deletions(-)

Karthik Nayak (2):
      reflog: improve error for when reflog is not found
      reflog: implement subcommand to drop reflogs

Range-diff versus v2:

-:  ---------- > 1:  d4c4bf8c99 reflog: improve error for when reflog is not found
1:  9405eaacb7 ! 2:  a7f88d71da reflog: implement subcommand to drop reflogs
    @@ Commit message
         entries despite setting 'core.logAllRefUpdates=false'.
     
         Add a new 'drop' subcommand to git-reflog that allows users to delete
    -    the entire reflog for a specified reference. Include a '--all' flag to
    -    enable dropping all reflogs in a repository.
    +    the entire reflog for a specified reference. Include an '--all' flag to
    +    enable dropping all reflogs from all worktrees and an addon flag
    +    '--single-worktree', to only drop all reflogs from the current worktree.
     
         While here, remove an extraneous newline in the file.
     
    @@ Documentation/git-reflog.adoc: SYNOPSIS
      	[--dry-run | -n] [--verbose] [--all [--single-worktree] | <refs>...]
      'git reflog delete' [--rewrite] [--updateref]
      	[--dry-run | -n] [--verbose] <ref>@{<specifier>}...
    -+'git reflog drop' [--all | <refs>...]
    ++'git reflog drop' [--all [--single-worktree] | <refs>...]
      'git reflog exists' <ref>
      
      DESCRIPTION
    @@ Documentation/git-reflog.adoc: and not reachable from the current tip, are remov
     +not the reflog itself. Its argument must be an _exact_ entry (e.g. "`git
     +reflog delete master@{2}`"). This subcommand is also typically not used
     +directly by end users.
    - 
    - The "exists" subcommand checks whether a ref has a reflog.  It exits
    - with zero status if the reflog exists, and non-zero status if it does
    - not.
    - 
    ++
     +The "drop" subcommand completely removes the reflog for the specified
     +references. This is in contrast to "expire" and "delete", both of which
     +can be used to delete reflog entries, but not the reflog itself.
    -+
    - OPTIONS
    - -------
      
    + The "exists" subcommand checks whether a ref has a reflog.  It exits
    + with zero status if the reflog exists, and non-zero status if it does
     @@ Documentation/git-reflog.adoc: Options for `delete`
      `--dry-run`, and `--verbose`, with the same meanings as when they are
      used with `expire`.
    @@ Documentation/git-reflog.adoc: Options for `delete`
     +
     +--all::
     +	Drop the reflogs of all references from all worktrees.
    ++
    ++--single-worktree::
    ++	By default when `--all` is specified, reflogs from all working
    ++	trees are dropped. This option limits the processing to reflogs
    ++	from the current working tree only.
      
      GIT
      ---
    @@ builtin/reflog.c
      	N_("git reflog exists <ref>")
      
     +#define BUILTIN_REFLOG_DROP_USAGE \
    -+	N_("git reflog drop [--all | <refs>...]")
    ++	N_("git reflog drop [--all [--single-worktree] | <refs>...]")
     +
      static const char *const reflog_show_usage[] = {
      	BUILTIN_REFLOG_SHOW_USAGE,
    @@ builtin/reflog.c: static int cmd_reflog_exists(int argc, const char **argv, cons
     +static int cmd_reflog_drop(int argc, const char **argv, const char *prefix,
     +			   struct repository *repo)
     +{
    -+	int ret = 0, do_all = 0;
    ++	int ret = 0, do_all = 0, single_worktree = 0;
     +	const struct option options[] = {
    -+		OPT_BOOL(0, "all", &do_all, N_("process the reflogs of all references")),
    ++		OPT_BOOL(0, "all", &do_all, N_("drop the reflogs of all references")),
    ++		OPT_BOOL(0, "single-worktree", &single_worktree,
    ++			 N_("drop reflogs from the current worktree only")),
     +		OPT_END()
     +	};
     +
     +	argc = parse_options(argc, argv, prefix, options, reflog_drop_usage, 0);
     +
     +	if (argc && do_all)
    -+		die(_("references specified along with --all"));
    ++		usage(_("references specified along with --all"));
     +
     +	if (do_all) {
     +		struct worktree_reflogs collected = {
    @@ builtin/reflog.c: static int cmd_reflog_exists(int argc, const char **argv, cons
     +
     +		worktrees = get_worktrees();
     +		for (p = worktrees; *p; p++) {
    ++			if (single_worktree && !(*p)->is_current)
    ++				continue;
     +			collected.worktree = *p;
     +			refs_for_each_reflog(get_worktree_ref_store(*p),
     +					     collect_reflog, &collected);
    @@ builtin/reflog.c: static int cmd_reflog_exists(int argc, const char **argv, cons
     +			ret |= refs_delete_reflog(get_main_ref_store(repo),
     +						     item->string);
     +		string_list_clear(&collected.reflogs, 0);
    ++
    ++		return ret;
     +	}
     +
     +	for (int i = 0; i < argc; i++) {
     +		char *ref;
     +		if (!repo_dwim_log(repo, argv[i], strlen(argv[i]), NULL, &ref)) {
    -+			ret |= error(_("%s points nowhere!"), argv[i]);
    ++			ret |= error(_("reflog could not be found: '%s'"), argv[i]);
     +			continue;
     +		}
     +
    @@ t/t1410-reflog.sh: test_expect_success 'reflog with invalid object ID can be lis
     +		cd repo &&
     +		test_must_fail git reflog exists refs/heads/non-existent &&
     +		test_must_fail git reflog drop refs/heads/non-existent 2>stderr &&
    -+		test_grep "error: refs/heads/non-existent points nowhere!" stderr
    ++		test_grep "error: reflog could not be found: ${SQ}refs/heads/non-existent${SQ}" stderr
     +	)
     +'
     +
    @@ t/t1410-reflog.sh: test_expect_success 'reflog with invalid object ID can be lis
     +	)
     +'
     +
    ++test_expect_success 'reflog drop multiple references some non-existent' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		test_commit A &&
    ++		test_commit_bulk --ref=refs/heads/branch 1 &&
    ++		git reflog exists refs/heads/main &&
    ++		git reflog exists refs/heads/branch &&
    ++		test_must_fail git reflog exists refs/heads/non-existent &&
    ++		test_must_fail git reflog drop refs/heads/main refs/heads/non-existent refs/heads/branch 2>stderr &&
    ++		test_must_fail git reflog exists refs/heads/main &&
    ++		test_must_fail git reflog exists refs/heads/branch &&
    ++		test_must_fail git reflog exists refs/heads/non-existent &&
    ++		test_grep "error: reflog could not be found: ${SQ}refs/heads/non-existent${SQ}" stderr
    ++	)
    ++'
    ++
     +test_expect_success 'reflog drop --all' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
    @@ t/t1410-reflog.sh: test_expect_success 'reflog with invalid object ID can be lis
     +	)
     +'
     +
    ++test_expect_success 'reflog drop --all multiple worktrees' '
    ++	test_when_finished "rm -rf repo" &&
    ++	test_when_finished "rm -rf wt" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		test_commit A &&
    ++		git worktree add ../wt &&
    ++		test_commit_bulk -C ../wt --ref=refs/heads/branch 1 &&
    ++		git reflog exists refs/heads/main &&
    ++		git reflog exists refs/heads/branch &&
    ++		git reflog drop --all &&
    ++		test_must_fail git reflog exists refs/heads/main &&
    ++		test_must_fail git reflog exists refs/heads/branch
    ++	)
    ++'
    ++
    ++test_expect_success 'reflog drop --all --single-worktree' '
    ++	test_when_finished "rm -rf repo" &&
    ++	test_when_finished "rm -rf wt" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		test_commit A &&
    ++		git worktree add ../wt &&
    ++		test_commit -C ../wt foobar &&
    ++		git reflog exists refs/heads/main &&
    ++		git reflog exists refs/heads/wt &&
    ++		test-tool ref-store worktree:wt reflog-exists HEAD &&
    ++		git reflog drop --all --single-worktree &&
    ++		test_must_fail git reflog exists refs/heads/main &&
    ++		test_must_fail git reflog exists refs/heads/wt &&
    ++		test_must_fail test-tool ref-store worktree:main reflog-exists HEAD &&
    ++		test-tool ref-store worktree:wt reflog-exists HEAD
    ++	)
    ++'
    ++
     +test_expect_success 'reflog drop --all with reference' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
    @@ t/t1410-reflog.sh: test_expect_success 'reflog with invalid object ID can be lis
     +		cd repo &&
     +		test_commit A &&
     +		test_must_fail git reflog drop --all refs/heads/main 2>stderr &&
    -+		test_grep "fatal: references specified along with --all" stderr
    ++		test_grep "usage: references specified along with --all" stderr
     +	)
     +'
     +


base-commit: a36e024e989f4d35f35987a60e3af8022cac3420
change-id: 20250306-493-add-command-to-purge-reflog-entries-bd22547ad34a

Thanks
- Karthik


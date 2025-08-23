Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FED19DF62
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 06:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755928821; cv=none; b=Uw0Yu0is9JkmMAvc2+qhrcRfWd+Dw9XFhSKzZGMerFWBqAhypWXeEKaZuKO+sEUvNUF+JclCZkZFRmjCufAOTYZLnTu36Di2bHwTmsN3bWhli7zbqxQJf1fzugHzI9OmeFrcM4fyJSegi6wdpWoUBce9QNKTC0/sjY7boPAhFzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755928821; c=relaxed/simple;
	bh=cnZyp6asXv4TFILSoRPjFedsdFMfcmjf1Vqq1hPukug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BksNtfuuiJ1ih+Nn45eooOsHjvs0f7NDUsXYfoaSpUseVI0iipBrizsi4CP1KO/qxwEZvpjxEvty2iPuUvSfOEdjh3tTgscf9A/aK08ZxX5ayKa3GqJ8ILHTxzW5IpcygSuyNE2WQAzjcxmEeT0aUpsaY9A0cTtPcfIljM1ToXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmzO7mr6; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmzO7mr6"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e4f2e4c40so2545725b3a.2
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 23:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755928819; x=1756533619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3i7+zUe45/kZWPfzYE9nuzLxzTp7mSyLTaqKM7CWIM=;
        b=hmzO7mr6EXyuLI6X7fBur3a0AQoLKPIQyAJ6tobqpxujAFeu4cXw2qHveB3qSY0IyL
         F6OyS8vVcEDt14+GuyLxilhE7JqrwMYxWWmOsyfMaSwnSDa0IG3PxZM+wGE7/PuNxATu
         kfFXX5G3hOhqMwlTw4ryCrOKG7J4RFmk8PhNqQwpRmzxDk6njEJuQvNbTEzgWqffC1wR
         P+39c3lEeJ9LdQdxcjY+Ywhh7T0sTR0YsjhfrMR7wbRIRC2s1/RxzmFd7CACZN8N6NVz
         uVGnmw0fIa5IJT+dysKp1FM8S05Emd/mu0YZ5wMonr3EVVF9JU8eqIXtkV2XNXBySDdq
         fLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755928819; x=1756533619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3i7+zUe45/kZWPfzYE9nuzLxzTp7mSyLTaqKM7CWIM=;
        b=o/cuBTcOMVuAyy3xZWoQKLNA/QJR85tV9UtDavm6UwSST3VUhN02Y+dYl7hyaotngd
         1vFrf7KIKquEwFd2g+g2KCJkcc8Kzgks+4rrAVrIuO+1u6YnqXHjHw+rKtVQ3V4pGwik
         RATiGrtmmbFzVvDEqUYNPf5DTaOJqElvUJ5quwvvbZHT+E7wcv+kVPg8fydqUCq3Q1mt
         pqicAeJ0xBwhus/DflZ5oZ1E0qfVE6ZkzHL50OoZHw01i+VaZ21zrMpNaIgVOAl7kFvK
         sBB5Fs1PT8MYP+bAEljPZBR+Hat1tHPhAeCw9eLe9Fy7TnyLqM5xrmRGu7xCLtSRoLrw
         0pBw==
X-Gm-Message-State: AOJu0YzkIeHu81vKJIYlca/CPfi2M/OLRYBUotMSdLB/ysZYNCP+5zpF
	4WkXPg/j5Lz2jFmsHdKdK+2hW3X0GnDcOU4SGXxJrw4ZS90LSFOamKTd8YJq8Q==
X-Gm-Gg: ASbGnct+4Mq+vlqCsiov0LU6giNS9SU/VFii1kFAbpri/tzM2rzXIBiHV9mYm5odFN3
	nsKZWjPXOlcduGKBzeNbFxuMEGziyEI6wjpb7SO8/xCb85E1y3Z6B4ansXH6ttxMWcRcu/NQ4ps
	GSX3KRhXAQmH1hrTNkD30IylJ4ocAdxrnAp1CO/d6PVdQonnJVDpm2dkbmCVCeAc82c26Dv9djL
	jw1SyRkLdKQ5ljo41dAHlfpEn48EULg8URvq++dhlZMpbuXQ4XiKuPbD/4pY7BHuy62y1DLjKuM
	xRHQuZKW86pJoT3zsiaERBkfjyUbJ4T7ad3ZpWi66pDfcNr3LGpDAOTisMPoKNakyp/HSpKVTQt
	Gjbxmm65UrZ9WF1goaOo=
X-Google-Smtp-Source: AGHT+IFLE1lmmbB8UnM31wN53UvmBtuFVeTEeoM9xIwzemVJuqVkLXdA53v+No7/KPwPMUV5GCdHHg==
X-Received: by 2002:a05:6a20:914b:b0:240:2473:57c5 with SMTP id adf61e73a8af0-24340bce6d2mr7895969637.26.1755928818663;
        Fri, 22 Aug 2025 23:00:18 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbb7b6fbsm1434145a12.30.2025.08.22.23.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 23:00:18 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH v2 0/4] Add refs exists subcommand
Date: Sat, 23 Aug 2025 11:30:08 +0530
Message-Id: <20250823060012.540433-1-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821085246.929307-1-meetsoni3017@gmail.com>
References: <20250821085246.929307-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces `git refs exists` as a modern replacement for
`git show-ref --exists`, continuing the effort to consolidate commands
under the `git refs` namespace.

Changes in v2:
  - v1 was based on the "next" branch as this series required a couple
    of commits merged in it, but as those commits are now completely
    merged into the master branch, I've rebased the v2 onto master
    branch.

  - split the test commit to make the setup shareable.

Meet Soni (4):
  builtin/refs: add 'exists' subcommand
  t1403: split 'show-ref --exists' tests into a separate file
  t1422: refactor tests to be shareable
  t: add test for git refs exists subcommand

 Documentation/git-refs.adoc |  7 ++++
 builtin/refs.c              | 48 +++++++++++++++++++++++
 t/meson.build               |  4 +-
 t/show-ref-exists-tests.sh  | 76 +++++++++++++++++++++++++++++++++++++
 t/t1403-show-ref.sh         | 65 -------------------------------
 t/t1422-show-ref-exists.sh  |  9 +++++
 t/t1462-refs-exists.sh      | 10 +++++
 7 files changed, 153 insertions(+), 66 deletions(-)
 create mode 100644 t/show-ref-exists-tests.sh
 create mode 100755 t/t1422-show-ref-exists.sh
 create mode 100755 t/t1462-refs-exists.sh

Range-diff against v1:
 1:  3fe68ee250 <  -:  ---------- bloom: optimize multiple pathspec items in revision
 2:  36554bf51a <  -:  ---------- commit: convert pop_most_recent_commit() to prio_queue
 3:  304f06e0c0 <  -:  ---------- commit: use prio_queue_replace() in pop_most_recent_commit(),MIME-Version: 1.0
 4:  e436bc94f3 <  -:  ---------- prio-queue: add prio_queue_replace()
 5:  c7a5d9a13c <  -:  ---------- Revert "Merge branch 'rs/pop-recent-commit-with-prio-queue' into next"
 6:  d66d5bfc41 <  -:  ---------- archive: flush deflate stream until Z_STREAM_END
 7:  5297b08916 <  -:  ---------- Revert "Merge branch 'jt/archive-zip-deflate-fix' into next"
 8:  19623eb97e <  -:  ---------- doc: factor out common option
 9:  69c207dc45 <  -:  ---------- builtin/for-each-ref: align usage string with the man page
10:  6eeb1c070a <  -:  ---------- builtin/for-each-ref: factor out core logic into a helper
11:  eecccfe98b <  -:  ---------- builtin/refs: add list subcommand
12:  aa91c5c570 <  -:  ---------- t6300: refactor tests to be shareable
13:  fed66d91c0 <  -:  ---------- t: add test for git refs list subcommand
14:  9bb4abe6cd <  -:  ---------- combine-diff: zero memory used for callback filepairs
15:  2a43e0e550 <  -:  ---------- within_depth: fix return for empty path
16:  a1dfa5448d <  -:  ---------- diff: teach tree-diff a max-depth parameter
17:  b55e6d36eb <  -:  ---------- diff: ensure consistent diff behavior with ignore options
18:  fe54b9ef02 <  -:  ---------- parse-options: refactor flags for usage_with_options_internal
19:  129b3632f3 <  -:  ---------- builtin: also setup gently for --help-all
20:  e1d3d61a45 <  -:  ---------- diff: --no-index should ignore the worktree
21:  621ce9c1c6 <  -:  ---------- git-jump: make `diff` work with filenames containing spaces
22:  9a49aef8dc <  -:  ---------- environment: remove the global variable 'merge_log_config'
23:  22d421fed9 <  -:  ---------- builtin/fmt-merge-msg: stop depending on 'the_repository'
24:  f81a574f59 <  -:  ---------- doc: test linkgit macros for well-formedness
25:  63d33eb7f6 <  -:  ---------- doc: check well-formedness of delimited sections
26:  ed26022094 <  -:  ---------- doc: check for absence of multiple terms in each entry of desc list
27:  03a353bb97 <  -:  ---------- doc: check for absence of the form --[no-]parameter
28:  93203872d7 <  -:  ---------- doc:git-for-each-ref: fix styling and typos
29:  84f3d6e11e <  -:  ---------- doc lint: check that synopsis manpages have synopsis inlines
30:  741f36c7d9 <  -:  ---------- docs: remove stray bracket from git-clone synopsis
31:  83d64df8d5 <  -:  ---------- t7005: use modern test style
32:  a9c4141abb <  -:  ---------- t7005: stop abusing --exec-path
33:  a60203a015 <  -:  ---------- t7005: sanitize test environment for subsequent tests
34:  7d4a5fef7d <  -:  ---------- count-objects: document count-objects pack
35:  3481cb7dfd <  -:  ---------- commit-graph: stop using `the_hash_algo` via macros
36:  e45402bb19 <  -:  ---------- commit-graph: store the hash algorithm instead of its length
37:  f1141b4391 <  -:  ---------- commit-graph: refactor `parse_commit_graph()` to take a repository
38:  89cc9b9adf <  -:  ---------- commit-graph: stop using `the_hash_algo`
39:  ddacfc7466 <  -:  ---------- commit-graph: stop using `the_repository`
40:  7be9e410b2 <  -:  ---------- commit-graph: stop passing in redundant repository
41:  cab69db9c3 <  -:  ---------- t/t1517: mark tests that fail with GIT_TEST_INSTALLED
42:  ab94bb8000 <  -:  ---------- repo: declare the repo command
43:  9adb8a7fd1 <  -:  ---------- repo: add the field references.format
44:  acf2669b54 <  -:  ---------- repo: add the field layout.bare
45:  e52cd654c9 <  -:  ---------- repo: add the field layout.shallow
46:  a81224d128 <  -:  ---------- repo: add the --format flag
47:  d59b2a3793 <  -:  ---------- Revert "Merge branch 'ad/t1517-short-help-tests-fix' into next"
48:  5643b59dea !  1:  d1fa4e927e builtin/refs: add 'exists' subcommand
    @@ Commit message
         builtin/refs: add 'exists' subcommand
     
         As part of the ongoing effort to consolidate reference handling,
    -    introduce a new `exists` subcommand. This command provides the same
    +    introduce `exists` subcommand. This command provides the same
         functionality and exit-code behavior as `git show-ref --exists`, serving
         as its modern replacement.
     
    @@ Commit message
         `git refs list`, where sharing the larger implementation of
         `for-each-ref` was necessary.
     
    -    Documentation for the new subcommand is also added to the `git-refs(1)`
    +    Documentation for this subcommand is also added to the `git-refs(1)`
         man page.
     
         Mentored-by: Patrick Steinhardt <ps@pks.im>
    @@ Documentation/git-refs.adoc
     @@ Documentation/git-refs.adoc: git refs list [--count=<count>] [--shell|--perl|--python|--tcl]
      		   [--contains[=<object>]] [--no-contains[=<object>]]
      		   [(--exclude=<pattern>)...] [--start-after=<marker>]
    - 		   [ --stdin | (<pattern>...)]
    + 		   [ --stdin | <pattern>... ]
     +git refs exists <ref>
      
      DESCRIPTION
    @@ builtin/refs.c: static int cmd_refs_list(int argc, const char **argv, const char
     +	unsigned int unused_type;
     +	int failure_errno = 0;
     +	const char *ref;
    -+
    ++	int ret = 0;
     +	const char * const exists_usage[] = {
     +		REFS_EXISTS_USAGE,
     +		NULL,
    @@ builtin/refs.c: static int cmd_refs_list(int argc, const char **argv, const char
     +	};
     +
     +	argc = parse_options(argc, argv, prefix, options, exists_usage, 0);
    -+	if (!argc)
    -+		die("'git refs exists' requires a reference");
    ++	if (argc != 1)
    ++		die(_("'git refs exists' requires a reference"));
     +
     +	ref = *argv++;
    -+	if (*argv)
    -+		die("'git refs exists' requires exactly one reference");
    -+
     +	if (refs_read_raw_ref(get_main_ref_store(the_repository), ref,
     +			      &unused_oid, &unused_referent, &unused_type,
     +			      &failure_errno)) {
     +		if (failure_errno == ENOENT || failure_errno == EISDIR) {
     +			error(_("reference does not exist"));
    -+			return 2;
    ++			ret = 2;
     +		} else {
     +			errno = failure_errno;
     +			error_errno(_("failed to look up reference"));
    -+			return 1;
    ++			ret = 1;
     +		}
    ++
    ++		goto out;
     +	}
     +
    ++out:
     +	strbuf_release(&unused_referent);
    -+	return 0;
    ++	return ret;
     +}
     +
      int cmd_refs(int argc,
 -:  ---------- >  2:  f1dfafe6c9 t1403: split 'show-ref --exists' tests into a separate file
49:  e14bd088bd !  3:  a2a65c428c t: add test for git refs exists subcommand
    @@ Metadata
     Author: Meet Soni <meetsoni3017@gmail.com>
     
      ## Commit message ##
    -    t: add test for git refs exists subcommand
    +    t1422: refactor tests to be shareable
     
    -    The new `git refs exists` subcommand must have identical behavior to its
    -    predecessor, `git show-ref --exists`. To avoid duplicating the entire
    -    test suite, refactor the existing tests into a shareable helper script.
    +    In preparation for adding tests for the `git refs exists` command,
    +    refactor the existing t1422 test suite to make its logic shareable.
     
    -    Extract the tests for the `--exists` flag from `t1403-show-ref.sh` into
    -    a new `show-ref-exists-tests.sh` helper. The command under test is
    -    parameterized using the `$git_show_ref_exists` variable.
    +    Move the core test logic from `t1422-show-ref-exists.sh` to
    +    `show-ref-exists-tests.sh` file. Inside this script, replace hardcoded
    +    calls to "git show-ref --exists" with the `$git_show_ref_exists`
    +    variable.
     
    -    Source new helper to both `t1403-show-ref.sh` and the new test file,
    -    `t1462-refs-exists.sh`, ensuring both commands are verified against the
    -    same comprehensive test suite.
    +    The original `t1422-show-ref-exists.sh` script now becomes a simple
    +    "driver". It is responsible for setting the default value of the
    +    variable and then sourcing the test library.
    +
    +    This structure follows an established pattern for sharing tests and
    +    prepares the test suite for the `refs exists` tests to be added in a
    +    subsequent commit.
     
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: shejialuo <shejialuo@gmail.com>
         Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
     
    - ## t/meson.build ##
    -@@ t/meson.build: integration_tests = [
    -   't1451-fsck-buffer.sh',
    -   't1460-refs-migrate.sh',
    -   't1461-refs-list.sh',
    -+  't1462-refs-exists.sh',
    -   't1500-rev-parse.sh',
    -   't1501-work-tree.sh',
    -   't1502-rev-parse-parseopt.sh',
    -@@ t/meson.build: if perl.found() and time.found()
    -       timeout: 0,
    -     )
    -   endforeach
    --endif
    - \ No newline at end of file
    -+endif
    -
      ## t/show-ref-exists-tests.sh (new) ##
     @@
     +git_show_ref_exists=${git_show_ref_exists:-git show-ref --exists}
    ++test_expect_success setup '
    ++	test_commit --annotate A &&
    ++	git checkout -b side &&
    ++	test_commit --annotate B &&
    ++	git checkout main &&
    ++	test_commit C &&
    ++	git branch B A^0
    ++'
     +
     +test_expect_success '--exists with existing reference' '
     +	${git_show_ref_exists} refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    @@ t/show-ref-exists-tests.sh (new)
     +	git rev-parse HEAD >.git/FETCH_HEAD &&
     +	${git_show_ref_exists} FETCH_HEAD
     +'
    ++
    ++test_done
     
    - ## t/t1403-show-ref.sh ##
    -@@ t/t1403-show-ref.sh: test_expect_success 'show-ref sub-modes are mutually exclusive' '
    - 	grep "cannot be used together" err
    - '
    + ## t/t1422-show-ref-exists.sh (mode change 100644 => 100755) ##
    +@@ t/t1422-show-ref-exists.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    + 
    + . ./test-lib.sh
      
    +-test_expect_success setup '
    +-	test_commit --annotate A &&
    +-	git checkout -b side &&
    +-	test_commit --annotate B &&
    +-	git checkout main &&
    +-	test_commit C &&
    +-	git branch B A^0
    +-'
    +-
     -test_expect_success '--exists with existing reference' '
     -	git show-ref --exists refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     -'
    @@ t/t1403-show-ref.sh: test_expect_success 'show-ref sub-modes are mutually exclus
     -	git show-ref --exists FETCH_HEAD
     -'
     -
    +-test_done
     +. "$TEST_DIRECTORY"/show-ref-exists-tests.sh
    - test_done
    -
    - ## t/t1462-refs-exists.sh (new) ##
    -@@
    -+#!/bin/sh
    -+
    -+test_description='refs exists'
    -+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    -+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    -+
    -+. ./test-lib.sh
    -+
    -+git_show_ref_exists='git refs exists'
    -+
    -+test_expect_success setup '
    -+	test_commit --annotate A &&
    -+	git checkout -b side &&
    -+	test_commit --annotate B &&
    -+	git checkout main &&
    -+	test_commit C &&
    -+	git branch B A^0
    -+'
    -+
    -+. "$TEST_DIRECTORY"/show-ref-exists-tests.sh
    -+
    -+test_done
 -:  ---------- >  4:  e92da499b5 t: add test for git refs exists subcommand
-- 
2.34.1


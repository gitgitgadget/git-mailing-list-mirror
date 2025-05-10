Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE2829D0E
	for <git@vger.kernel.org>; Sat, 10 May 2025 13:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746884797; cv=none; b=i2LTym79b/jJuYOmtz45WNAgwUuuoGlivsJZ6RAH9LFT2R+jSFm35YDEptv6iUb2uSH1A587mYOZdvkkIuqvQcniEkTIiArt0m5dj7T3snuIfkqA7t9UCDPS3N7/xqONYj7jbc3yOWcL+GmiPJ8cMw0v4r7WE/FmZsljQVc7yFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746884797; c=relaxed/simple;
	bh=lluqiE/NoUPAVgLvUaqGfORvaCu2bVKcbn1Tb9ybB+M=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aaE3l7UhqjW8Au9KSgOvYQqOW5+cHOKRMD5wGHtDZUAOZkj+kI+uzLEg3R4XXC6GpRwy2e0d4t141BwJt6JWzSCGw5hn6qJoP68n5qb1WltVQYSOhdr+f3yNNd83CFiUz/skjXX4sLj89OZqaWThrVHJ3HtefC4zM9MKwzu08H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YiMHDPLG; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiMHDPLG"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a108684f90so1702848f8f.1
        for <git@vger.kernel.org>; Sat, 10 May 2025 06:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746884792; x=1747489592; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2pO27a9/NkB+QuoIf1kg+2hl4wZMzUyuhrExEN7GRM=;
        b=YiMHDPLGP/eUsYzVm9YBSv6gI1xXc3tAEWBzHzx8e1CB81aujFtiRRgerFiLP/UE3z
         4A4UNJFSKSyh6OPVYpZ9aL15RjTc3MX/m/RaIKCEj6VDa1diEHQrincNoc3fgYxuAfUk
         AQ2ZRFOkF5OfTVlPAhgkdjX/pzqlDuAgjf7zKQHywCsLxwEOcuH+stVsRYImwqQrtdOZ
         xzDq8bBBuEpEqKAHmEG55Xemq719zqq4tdbU6XQgttoFZ5PgfpnbORLsWAPeNjnITbyT
         MgGzOafI8ualHyYrSYpTScPqtWdPjg8AtxJuvJjzAmg90Q2E0EwyOqPJi83YTsAWaE0L
         gypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746884792; x=1747489592;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d2pO27a9/NkB+QuoIf1kg+2hl4wZMzUyuhrExEN7GRM=;
        b=a6Cab7FYyllublJnaJJH9eCS89k9uaQTwts/Ep4/Rib50//e3OXt7dLBzDGANuhJfG
         mSdIh08vG1cfZFnrlDeP3j3PEYzQdeMOUTjCDc/Fhkc10akzEBOQNRyO3dhaaQTCLVeR
         169p9YhuwTBTK9Jo/0pgweocHIY8JNe9Tl/c0j5onsn50Pccp74XREi0YO/bGXox/HJN
         QmHoue/l4xdvfo1qVK0RWiNXMEi7BG5efsCCxWzz7YAcVeQ9X42YIxzEbXfkTkMJexKy
         ZEiWWgpnCcJMJb0chJX6wY+2MzeApWH4LxrRAJvzjQUEb/k7aQWV7vhfeN+HzCqW7TEu
         oIFw==
X-Gm-Message-State: AOJu0Yw6bj/FwqB6rr62zVH8/9V6u1fyuMvKNYRztx8X/Uu46k3tFgMI
	xwPOY/oxSAouljwW7tDlitiej1g9EwmsyNeWrs2iUcQncx+22CQ6jV4lGA==
X-Gm-Gg: ASbGncsEsU5Zu6bOEl65rn49jYWvFnZh+5AOl0cvo81emoK+2K7vyodnWD1Ro7pidzQ
	2e5gs6w1Thta3HTBlaXzTLMCA9Lmti1ZMmdcvUUNoazBMs62kYd5RZEfdOfj+UzYR2wagc33dUS
	a65Tk23L18RnBhfJXlZvpy5IhPi0AbgrLaKEInM/4DxkwfFG78UDRUwWivvFOio0XUu1020b0yU
	5ppEKSciRiG9ovCO93n6+UXLG05JjLNCffJsofDpjA90uvCwi4JJPCYFc0qhb3bFNhkCIYPNqdM
	TTHZOurRqTH5GbK2fzVL/tAbQYyEZFBG9actwDUP5Z7WCYNR2Tjy
X-Google-Smtp-Source: AGHT+IFN1o0tqk4HaPrNNWa0hxSyjUQmEgO2/uw8nSEJypzjWJAyoCqMnv/4fO2YtmWbrCIrKq9Q2g==
X-Received: by 2002:a05:6000:2506:b0:3a1:f537:94d0 with SMTP id ffacd0b85a97d-3a1f6487b80mr6297009f8f.41.1746884791429;
        Sat, 10 May 2025 06:46:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d67d5c09sm63844695e9.7.2025.05.10.06.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 06:46:30 -0700 (PDT)
Message-Id: <pull.1915.v2.git.1746884789.gitgitgadget@gmail.com>
In-Reply-To: <pull.1915.git.1746436719.gitgitgadget@gmail.com>
References: <pull.1915.git.1746436719.gitgitgadget@gmail.com>
From: "Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 10 May 2025 13:46:25 +0000
Subject: [PATCH v2 0/4] Better support for customising context lines in --patch commands
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Christian Couder <christian.couder@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Leon Michalak <leonmichalak6@gmail.com>

This series of patches attempt to give --interactive/--patch compatible
builtins ("add", "commit", "checkout", "reset", "restore" and "stash")
better support and nicer experience for configuring how many context lines
are shown in diffs through a variety of ways.

Prior to these patches, the user could not choose how many context lines
they saw in --patch commands (apart from one workaround by using
GIT_DIFF_OPTS=-u<number> ..., however this isn't a good user experience or a
persistent solution). Additionally, the behaviour around reading from the
diff.context and diff.interHunkContext configs was also inconsistent with
other diff generating commands such as "log -p".

The summarised changes below hopefully make this experience better and fix
some inconsistencies:

 * diff.context and diff.interHunkContext configs are now respected by
   --patch compatible commands
 * --unified and --inter-hunk-context command line options have been added
   to --patch compatible commands (which take prescendence over file
   configs)
 * "add" and "commit" in --interactive mode now expose a new "context"
   subcommand which configures the amount of context lines you wish to see
   in subsequent diffs generated from other subcommands such as "patch" or
   "diff"

The original discussion for this can be read at:

 * https://lore.kernel.org/git/CAP9jKjGb-Rcr=RLJEzeFdtrekYM+qmHy+1T1fykU3n9cV4GhGw@mail.gmail.com/

Changes since v1:

 * Update commit descriptions
 * Update tests to use the more modern and robust test_grep and test_config
   utils
 * Reword some documentation / user messages
 * Ensure each commit is atomic and builds/passes tests on it's own
 * Make new command line options DRY
 * Add tests for interhunk context interaction
 * Error if context config/command line options are negative
 * Drop previous last commit to do with new subcommand for --interactive
   add/commit. My motivations behind this patch series originally where
   quite simple, just for add-patch commands to respect context configs.
   This subcommand, after the discussion in v1, will require more thought
   and a larger implementation that what I had anticipated. I would prefer
   to leave this for another time as it's the least impactful but the most
   time intensive and complicated idea.

Leon Michalak (4):
  test: refactor to use "test_grep"
  test: refactor to use "test_config"
  add-patch: respect diff.context configuration
  add-patch: add diff.context command line overrides

 Documentation/diff-context-options.adoc |  10 ++
 Documentation/git-add.adoc              |   2 +
 Documentation/git-checkout.adoc         |   2 +
 Documentation/git-commit.adoc           |   2 +
 Documentation/git-reset.adoc            |   2 +
 Documentation/git-restore.adoc          |   2 +
 Documentation/git-stash.adoc            |   2 +
 add-interactive.c                       |  53 +++++++--
 add-interactive.h                       |  17 ++-
 add-patch.c                             |  11 +-
 builtin/add.c                           |  16 ++-
 builtin/checkout.c                      |  24 +++-
 builtin/commit.c                        |  11 +-
 builtin/reset.c                         |  12 +-
 builtin/stash.c                         |  46 ++++++--
 commit.h                                |   3 +-
 parse-options.h                         |   2 +
 t/t3701-add-interactive.sh              |  48 ++++----
 t/t4032-diff-inter-hunk-context.sh      |  61 ++++++++++
 t/t4055-diff-context.sh                 | 142 ++++++++++++++++++++----
 t/t9902-completion.sh                   |   2 +
 21 files changed, 390 insertions(+), 80 deletions(-)
 create mode 100644 Documentation/diff-context-options.adoc


base-commit: f65182a99e545d2f2bc22e6c1c2da192133b16a3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1915%2FNinjaInShade%2Finteractive-patch-context-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1915/NinjaInShade/interactive-patch-context-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1915

Range-diff vs v1:

 -:  ----------- > 1:  4f92a1b4c24 test: refactor to use "test_grep"
 -:  ----------- > 2:  75424cb8e1c test: refactor to use "test_config"
 1:  8b91eef8120 ! 3:  f16d3de8611 add-patch: respect diff.context configuration
     @@ Metadata
       ## Commit message ##
          add-patch: respect diff.context configuration
      
     -    This aims to teach relevant builtins (that take in `--patch`) to respect
     +    Various builtins that use add-patch infrastructure do not respect
          the user's diff.context and diff.interHunkContext file configurations.
     -
     -    Since these are both UI options and `--patch` is designed for the end user,
     -    I believe this was previously just an inconsistency, which this patch hopes
     -    to address.
     +    This patch fixes this inconsistency.
      
          Signed-off-by: Leon Michalak <leonmichalak6@gmail.com>
      
       ## add-interactive.c ##
     -@@ add-interactive.c: void init_add_i_state(struct add_i_state *s, struct repository *r)
     +@@ add-interactive.c: static void init_color(struct repository *r, struct add_i_state *s,
     + void init_add_i_state(struct add_i_state *s, struct repository *r)
     + {
       	const char *value;
     ++	int context;
     ++	int interhunkcontext;
       
       	s->r = r;
      +	s->context = -1;
     @@ add-interactive.c: void init_add_i_state(struct add_i_state *s, struct repositor
       	repo_config_get_string(r, "diff.algorithm",
       			       &s->interactive_diff_algorithm);
       
     -+	repo_config_get_int(r, "diff.context", &s->context);
     -+	repo_config_get_int(r, "diff.interHunkContext", &s->interhunkcontext);
     ++	if (!repo_config_get_int(r, "diff.context", &context)) {
     ++		if (context < 0)
     ++			die(_("%s cannot be negative"), "diff.context");
     ++		else
     ++			s->context = context;
     ++	};
     ++	if (!repo_config_get_int(r, "diff.interHunkContext", &interhunkcontext)) {
     ++		if (interhunkcontext < 0)
     ++			die(_("%s cannot be negative"), "diff.interHunkContext");
     ++		else
     ++			s->interhunkcontext = interhunkcontext;
     ++	};
      +
       	repo_config_get_bool(r, "interactive.singlekey", &s->use_single_key);
       	if (s->use_single_key)
       		setbuf(stdin, NULL);
     -@@ add-interactive.c: static int run_diff(struct add_i_state *s, const struct pathspec *ps,
     - 	if (count > 0) {
     - 		struct child_process cmd = CHILD_PROCESS_INIT;
     +
     + ## add-interactive.h ##
     +@@ add-interactive.h: struct add_i_state {
     + 
     + 	int use_single_key;
     + 	char *interactive_diff_filter, *interactive_diff_algorithm;
     ++	int context, interhunkcontext;
     + };
       
     --		strvec_pushl(&cmd.args, "git", "diff", "-p", "--cached",
     --			     oid_to_hex(!is_initial ? &oid :
     --					s->r->hash_algo->empty_tree),
     --			     "--", NULL);
     -+		strvec_pushl(&cmd.args, "git", "diff", "-p", "--cached", NULL);
     -+		if (s->context != -1)
     -+			strvec_pushf(&cmd.args, "--unified=%i", s->context);
     -+		if (s->interhunkcontext != -1)
     -+			strvec_pushf(&cmd.args, "--inter-hunk-context=%i", s->interhunkcontext);
     -+		strvec_pushl(&cmd.args, oid_to_hex(!is_initial ? &oid :
     -+			     s->r->hash_algo->empty_tree), "--", NULL);
     - 		for (i = 0; i < files->items.nr; i++)
     - 			if (files->selected[i])
     - 				strvec_push(&cmd.args,
     + void init_add_i_state(struct add_i_state *s, struct repository *r);
      
       ## add-patch.c ##
      @@ add-patch.c: static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
     @@ add-patch.c: static int parse_diff(struct add_p_state *s, const struct pathspec
      
       ## t/t4055-diff-context.sh ##
      @@ t/t4055-diff-context.sh: test_expect_success 'diff.context honored by "log"' '
     - 	! grep firstline output &&
     - 	git config diff.context 8 &&
     - 	git log -1 -p >output &&
     --	grep "^ firstline" output
     -+	grep "^ firstline" output &&
     -+	git config --unset diff.context
     -+'
     -+
     + 	test_grep "^ firstline" output
     + '
     + 
      +test_expect_success 'diff.context honored by "add"' '
      +	git add -p >output &&
     -+	! grep firstline output &&
     -+	git config diff.context 8 &&
     -+	git add -p >output &&
     -+	grep "^ firstline" output &&
     -+	git config --unset diff.context
     ++	test_grep ! firstline output &&
     ++	test_config diff.context 8 &&
     ++	git log -1 -p >output &&
     ++	test_grep "^ firstline" output
      +'
      +
      +test_expect_success 'diff.context honored by "commit"' '
      +	! git commit -p >output &&
     -+	! grep firstline output &&
     -+	git config diff.context 8 &&
     ++	test_grep ! firstline output &&
     ++	test_config diff.context 8 &&
      +	! git commit -p >output &&
     -+	grep "^ firstline" output &&
     -+	git config --unset diff.context
     ++	test_grep "^ firstline" output
      +'
      +
      +test_expect_success 'diff.context honored by "checkout"' '
      +	git checkout -p >output &&
     -+	! grep firstline output &&
     -+	git config diff.context 8 &&
     ++	test_grep ! firstline output &&
     ++	test_config diff.context 8 &&
      +	git checkout -p >output &&
     -+	grep "^ firstline" output &&
     -+	git config --unset diff.context
     ++	test_grep "^ firstline" output
      +'
      +
      +test_expect_success 'diff.context honored by "stash"' '
      +	! git stash -p >output &&
     -+	! grep firstline output &&
     -+	git config diff.context 8 &&
     ++	test_grep ! firstline output &&
     ++	test_config diff.context 8 &&
      +	! git stash -p >output &&
     -+	grep "^ firstline" output &&
     -+	git config --unset diff.context
     ++	test_grep "^ firstline" output
      +'
      +
      +test_expect_success 'diff.context honored by "restore"' '
      +	git restore -p >output &&
     -+	! grep firstline output &&
     -+	git config diff.context 8 &&
     ++	test_grep ! firstline output &&
     ++	test_config diff.context 8 &&
      +	git restore -p >output &&
     -+	grep "^ firstline" output &&
     -+	git config --unset diff.context
     ++	test_grep "^ firstline" output
     ++'
     ++
     + test_expect_success 'The -U option overrides diff.context' '
     + 	test_config diff.context 8 &&
     + 	git log -U4 -1 >output &&
     +@@ t/t4055-diff-context.sh: test_expect_success 'negative integer config parsing' '
     + 	test_grep "bad config variable" output
       '
       
     - test_expect_success 'The -U option overrides diff.context' '
     ++test_expect_success 'negative integer config parsing by "add"' '
     ++	test_config diff.context -1 &&
     ++	test_must_fail git add -p 2>output &&
     ++	test_grep "diff.context cannot be negative" output
     ++'
     ++
     ++test_expect_success 'negative integer config parsing by "commit"' '
     ++	test_config diff.context -1 &&
     ++	test_must_fail git commit -p 2>output &&
     ++	test_grep "bad config variable" output
     ++'
     ++
     ++test_expect_success 'negative integer config parsing by "checkout"' '
     ++	test_config diff.context -1 &&
     ++	test_must_fail git checkout -p 2>output &&
     ++	test_grep "diff.context cannot be negative" output
     ++'
     ++
     ++test_expect_success 'negative integer config parsing by "stash"' '
     ++	test_config diff.context -1 &&
     ++	test_must_fail git stash -p 2>output &&
     ++	test_grep "diff.context cannot be negative" output
     ++'
     ++
     ++test_expect_success 'negative integer config parsing by "restore"' '
     ++	test_config diff.context -1 &&
     ++	test_must_fail git restore -p 2>output &&
     ++	test_grep "diff.context cannot be negative" output
     ++'
     ++
     + test_expect_success '-U0 is valid, so is diff.context=0' '
     + 	test_config diff.context 0 &&
     + 	git diff >output &&
 2:  7700eb173e7 ! 4:  973dfadd1b3 add-patch: add diff.context command line overrides
     @@ Metadata
       ## Commit message ##
          add-patch: add diff.context command line overrides
      
     -    This patch compliments `8b91eef812`, where builtins that accept
     -    `--patch` options now respect `diff.context` and `diff.interHunkContext`
     -    file configurations.
     +    This patch compliments the previous commit, where builtins that use
     +    add-patch infrastructure now respect diff.context and
     +    diff.interHunkContext file configurations.
      
          In particular, this patch helps users who don't want to set persistent
          context configurations or just want a way to override them on a one-time
          basis, by allowing the relevant builtins to accept corresponding command
          line options that override the file configurations.
      
     -    This mimics `diff` which allows for both context file configuration and
     -    command line overrides.
     +    This mimics commands such as diff and log, which allow for both context
     +    file configuration and command line overrides.
      
          Signed-off-by: Leon Michalak <leonmichalak6@gmail.com>
      
     - ## Documentation/git-add.adoc ##
     -@@ Documentation/git-add.adoc: This effectively runs `add --interactive`, but bypasses the
     - initial command menu and directly jumps to the `patch` subcommand.
     - See ``Interactive mode'' for details.
     - 
     + ## Documentation/diff-context-options.adoc (new) ##
     +@@
      +`-U<n>`::
      +`--unified=<n>`::
      +	Generate diffs with _<n>_ lines of context. Defaults to `diff.context`
     -+	or 3 if the config option is unset. Implies `--interactive/--patch`.
     ++	or 3 if the config option is unset.
      +
      +`--inter-hunk-context=<n>`::
      +	Show the context between diff hunks, up to the specified _<number>_
      +	of lines, thereby fusing hunks that are close to each other.
      +	Defaults to `diff.interHunkContext` or 0 if the config option
     -+	is unset. Implies `--interactive/--patch`.
     ++	is unset.
     +
     + ## Documentation/git-add.adoc ##
     +@@ Documentation/git-add.adoc: This effectively runs `add --interactive`, but bypasses the
     + initial command menu and directly jumps to the `patch` subcommand.
     + See ``Interactive mode'' for details.
     + 
     ++include::diff-context-options.adoc[]
      +
       `-e`::
       `--edit`::
     @@ Documentation/git-checkout.adoc: section of linkgit:git-add[1] to learn how to o
       Note that this option uses the no overlay mode by default (see also
       `--overlay`), and currently doesn't support overlay mode.
       
     -+`-U<n>`::
     -+`--unified=<n>`::
     -+	Generate diffs with _<n>_ lines of context. Defaults to `diff.context`
     -+	or 3 if the config option is unset. Implies `--patch`.
     -+
     -+`--inter-hunk-context=<n>`::
     -+	Show the context between diff hunks, up to the specified _<number>_
     -+	of lines, thereby fusing hunks that are close to each other.
     -+	Defaults to `diff.interHunkContext` or 0 if the config option
     -+	is unset. Implies `--patch`.
     ++include::diff-context-options.adoc[]
      +
       --ignore-other-worktrees::
       	`git checkout` refuses when the wanted branch is already checked
     @@ Documentation/git-commit.adoc: OPTIONS
       	which changes to commit. See linkgit:git-add[1] for
       	details.
       
     -+`-U<n>`::
     -+`--unified=<n>`::
     -+	Generate diffs with _<n>_ lines of context. Defaults to `diff.context`
     -+	or 3 if the config option is unset. Implies `--interactive/--patch`.
     -+
     -+`--inter-hunk-context=<n>`::
     -+	Show the context between diff hunks, up to the specified _<number>_
     -+	of lines, thereby fusing hunks that are close to each other.
     -+	Defaults to `diff.interHunkContext` or 0 if the config option
     -+	is unset. Implies `--interactive/--patch`.
     ++include::diff-context-options.adoc[]
      +
       `-C <commit>`::
       `--reuse-message=<commit>`::
     @@ Documentation/git-reset.adoc: OPTIONS
       	separated with _NUL_ character and all other characters are taken
       	literally (including newlines and quotes).
       
     -+`-U<n>`::
     -+`--unified=<n>`::
     -+	Generate diffs with _<n>_ lines of context. Defaults to `diff.context`
     -+	or 3 if the config option is unset. Implies `--patch`.
     -+
     -+`--inter-hunk-context=<n>`::
     -+	Show the context between diff hunks, up to the specified _<number>_
     -+	of lines, thereby fusing hunks that are close to each other.
     -+	Defaults to `diff.interHunkContext` or 0 if the config option
     -+	is unset. Implies `--patch`.
     ++include::diff-context-options.adoc[]
      +
       `--`::
       	Do not interpret any more arguments as options.
     @@ Documentation/git-restore.adoc: leave out at most one of _<rev-A>__ and _<rev-B>
       	Mode" section of linkgit:git-add[1] to learn how to operate
       	the `--patch` mode.
       
     -+`-U<n>`::
     -+`--unified=<n>`::
     -+	Generate diffs with _<n>_ lines of context. Defaults to `diff.context`
     -+	or 3 if the config option is unset. Implies `--patch`.
     -+
     -+`--inter-hunk-context=<n>`::
     -+	Show the context between diff hunks, up to the specified _<number>_
     -+	of lines, thereby fusing hunks that are close to each other.
     -+	Defaults to `diff.interHunkContext` or 0 if the config option
     -+	is unset. Implies `--patch`.
     ++include::diff-context-options.adoc[]
      +
       `-W`::
       `--worktree`::
     @@ Documentation/git-stash.adoc: to learn how to operate the `--patch` mode.
       The `--patch` option implies `--keep-index`.  You can use
       `--no-keep-index` to override this.
       
     -+`-U<n>`::
     -+`--unified=<n>`::
     -+	Generate diffs with _<n>_ lines of context. Defaults to `diff.context`
     -+	or 3 if the config option is unset. Implies `--patch`.
     -+
     -+`--inter-hunk-context=<n>`::
     -+	Show the context between diff hunks, up to the specified _<number>_
     -+	of lines, thereby fusing hunks that are close to each other.
     -+	Defaults to `diff.interHunkContext` or 0 if the config option
     -+	is unset. Implies `--patch`.
     ++include::diff-context-options.adoc[]
      +
       -S::
       --staged::
     @@ add-interactive.c: static void init_color(struct repository *r, struct add_i_sta
      +		      struct add_p_opt *add_p_opt)
       {
       	const char *value;
     - 
     + 	int context;
      @@ add-interactive.c: void init_add_i_state(struct add_i_state *s, struct repository *r)
       	repo_config_get_bool(r, "interactive.singlekey", &s->use_single_key);
       	if (s->use_single_key)
       		setbuf(stdin, NULL);
      +
     -+	if (add_p_opt->context != -1)
     ++	if (add_p_opt->context != -1) {
     ++		if (add_p_opt->context < 0)
     ++			die(_("%s cannot be negative"), "--unified");
      +		s->context = add_p_opt->context;
     -+	if (add_p_opt->interhunkcontext != -1)
     ++	}
     ++	if (add_p_opt->interhunkcontext != -1) {
     ++		if (add_p_opt->interhunkcontext < 0)
     ++			die(_("%s cannot be negative"), "--inter-hunk-context");
      +		s->interhunkcontext = add_p_opt->interhunkcontext;
     ++	}
       }
       
       void clear_add_i_state(struct add_i_state *s)
     @@ add-interactive.c: static int run_patch(struct add_i_state *s, const struct path
       		strvec_clear(&args);
       		clear_pathspec(&ps_selected);
       	}
     +@@ add-interactive.c: static int run_diff(struct add_i_state *s, const struct pathspec *ps,
     + 	if (count > 0) {
     + 		struct child_process cmd = CHILD_PROCESS_INIT;
     + 
     +-		strvec_pushl(&cmd.args, "git", "diff", "-p", "--cached",
     +-			     oid_to_hex(!is_initial ? &oid :
     +-					s->r->hash_algo->empty_tree),
     +-			     "--", NULL);
     ++		strvec_pushl(&cmd.args, "git", "diff", "-p", "--cached", NULL);
     ++		if (s->context != -1)
     ++			strvec_pushf(&cmd.args, "--unified=%i", s->context);
     ++		if (s->interhunkcontext != -1)
     ++			strvec_pushf(&cmd.args, "--inter-hunk-context=%i", s->interhunkcontext);
     ++		strvec_pushl(&cmd.args, oid_to_hex(!is_initial ? &oid :
     ++			     s->r->hash_algo->empty_tree), "--", NULL);
     + 		for (i = 0; i < files->items.nr; i++)
     + 			if (files->selected[i])
     + 				strvec_push(&cmd.args,
      @@ add-interactive.c: static void command_prompt_help(struct add_i_state *s)
       			 _("(empty) select nothing"));
       }
     @@ add-interactive.h
       
       #include "color.h"
       
     -+#define ADD_P_OPT_INIT { .context = -1, .interhunkcontext = -1 }
     -+
      +struct add_p_opt {
      +	int context;
      +	int interhunkcontext;
      +};
     ++
     ++#define ADD_P_OPT_INIT { .context = -1, .interhunkcontext = -1 }
      +
       struct add_i_state {
       	struct repository *r;
       	int use_color;
      @@ add-interactive.h: struct add_i_state {
     - 
     - 	int use_single_key;
     - 	char *interactive_diff_filter, *interactive_diff_algorithm;
     -+	int context, interhunkcontext;
     + 	int context, interhunkcontext;
       };
       
      -void init_add_i_state(struct add_i_state *s, struct repository *r);
     @@ builtin/add.c: int interactive_add(struct repository *repo,
       
       	if (patch)
      -		ret = !!run_add_p(repo, ADD_P_ADD, NULL, &pathspec);
     -+		ret = !!run_add_p(repo, ADD_P_ADD, add_p_opt, NULL,
     -+				  &pathspec);
     ++		ret = !!run_add_p(repo, ADD_P_ADD, add_p_opt, NULL, &pathspec);
       	else
      -		ret = !!run_add_i(repo, &pathspec);
      +		ret = !!run_add_i(repo, &pathspec, add_p_opt);
     @@ builtin/add.c: static struct option builtin_add_options[] = {
       	OPT_GROUP(""),
       	OPT_BOOL('i', "interactive", &add_interactive, N_("interactive picking")),
       	OPT_BOOL('p', "patch", &patch_interactive, N_("select hunks interactively")),
     -+	OPT_INTEGER_F('U', "unified", &add_p_opt.context,
     -+		      N_("generate diffs with <n> lines context, implies --interactive/--patch"),
     -+		      PARSE_OPT_NONEG),
     -+	OPT_INTEGER_F(0, "inter-hunk-context", &add_p_opt.interhunkcontext,
     -+		      N_("show context between diff hunks up to the specified number of lines, implies --interactive/--patch"),
     -+		      PARSE_OPT_NONEG),
     ++	OPT_DIFF_UNIFIED(&add_p_opt.context),
     ++	OPT_DIFF_INTERHUNK_CONTEXT(&add_p_opt.interhunkcontext),
       	OPT_BOOL('e', "edit", &edit_interactive, N_("edit current diff and apply")),
       	OPT__FORCE(&ignored_too, N_("allow adding otherwise ignored files"), 0),
       	OPT_BOOL('u', "update", &take_worktree_changes, N_("update tracked files")),
     @@ builtin/checkout.c: static struct option *add_checkout_path_options(struct check
       			      N_("checkout their version for unmerged files"),
       			      3, PARSE_OPT_NONEG),
       		OPT_BOOL('p', "patch", &opts->patch_mode, N_("select hunks interactively")),
     -+		OPT_INTEGER_F('U', "unified", &opts->patch_context,
     -+			N_("generate diffs with <n> lines context, implies --patch"),
     -+			PARSE_OPT_NONEG),
     -+		OPT_INTEGER_F(0, "inter-hunk-context", &opts->patch_interhunk_context,
     -+			N_("show context between diff hunks up to the specified number of lines, implies --patch"),
     -+			PARSE_OPT_NONEG),
     ++		OPT_DIFF_UNIFIED(&opts->patch_context),
     ++		OPT_DIFF_INTERHUNK_CONTEXT(&opts->patch_interhunk_context),
       		OPT_BOOL(0, "ignore-skip-worktree-bits", &opts->ignore_skipworktree,
       			 N_("do not limit pathspecs to sparse entries only")),
       		OPT_PATHSPEC_FROM_FILE(&opts->pathspec_from_file),
     @@ builtin/commit.c: int cmd_commit(int argc,
       		OPT_BOOL('i', "include", &also, N_("add specified files to index for commit")),
       		OPT_BOOL(0, "interactive", &interactive, N_("interactively add files")),
       		OPT_BOOL('p', "patch", &patch_interactive, N_("interactively add changes")),
     -+		OPT_INTEGER_F('U', "unified", &add_p_opt.context,
     -+			      N_("generate diffs with <n> lines context, implies --interactive/--patch"),
     -+			      PARSE_OPT_NONEG),
     -+		OPT_INTEGER_F(0, "inter-hunk-context", &add_p_opt.interhunkcontext,
     -+			      N_("show context between diff hunks up to the specified number of lines, implies --interactive/--patch"),
     -+			      PARSE_OPT_NONEG),
     ++		OPT_DIFF_UNIFIED(&add_p_opt.context),
     ++		OPT_DIFF_INTERHUNK_CONTEXT(&add_p_opt.interhunkcontext),
       		OPT_BOOL('o', "only", &only, N_("commit only specified files")),
       		OPT_BOOL('n', "no-verify", &no_verify, N_("bypass pre-commit and commit-msg hooks")),
       		OPT_BOOL(0, "dry-run", &dry_run, N_("show what would be committed")),
     @@ builtin/reset.c: int cmd_reset(int argc,
       			       PARSE_OPT_OPTARG,
       			       option_parse_recurse_submodules_worktree_updater),
       		OPT_BOOL('p', "patch", &patch_mode, N_("select hunks interactively")),
     -+		OPT_INTEGER_F('U', "unified", &add_p_opt.context,
     -+			       N_("generate diffs with <n> lines context, implies --patch"),
     -+			       PARSE_OPT_NONEG),
     -+		OPT_INTEGER_F(0, "inter-hunk-context", &add_p_opt.interhunkcontext,
     -+			       N_("show context between diff hunks up to the specified number of lines, implies --patch"),
     -+			       PARSE_OPT_NONEG),
     ++		OPT_DIFF_UNIFIED(&add_p_opt.context),
     ++		OPT_DIFF_INTERHUNK_CONTEXT(&add_p_opt.interhunkcontext),
       		OPT_BOOL('N', "intent-to-add", &intent_to_add,
       				N_("record only the fact that removed paths will be added later")),
       		OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),
     @@ builtin/stash.c: static int push_stash(int argc, const char **argv, const char *
       			 N_("stash staged changes only")),
       		OPT_BOOL('p', "patch", &patch_mode,
       			 N_("stash in patch mode")),
     -+		OPT_INTEGER_F('U', "unified", &add_p_opt.context,
     -+			      N_("generate diffs with <n> lines context, implies --patch"),
     -+			      PARSE_OPT_NONEG),
     -+		OPT_INTEGER_F(0, "inter-hunk-context", &add_p_opt.interhunkcontext,
     -+			      N_("show context between diff hunks up to the specified number of lines, implies --patch"),
     -+			      PARSE_OPT_NONEG),
     ++		OPT_DIFF_UNIFIED(&add_p_opt.context),
     ++		OPT_DIFF_INTERHUNK_CONTEXT(&add_p_opt.interhunkcontext),
       		OPT__QUIET(&quiet, N_("quiet mode")),
       		OPT_BOOL('u', "include-untracked", &include_untracked,
       			 N_("include untracked files in stash")),
     @@ builtin/stash.c: static int save_stash(int argc, const char **argv, const char *
       			 N_("stash staged changes only")),
       		OPT_BOOL('p', "patch", &patch_mode,
       			 N_("stash in patch mode")),
     -+		OPT_INTEGER_F('U', "unified", &add_p_opt.context,
     -+			      N_("generate diffs with <n> lines context, implies --patch"),
     -+			      PARSE_OPT_NONEG),
     -+		OPT_INTEGER_F(0, "inter-hunk-context", &add_p_opt.interhunkcontext,
     -+			      N_("show context between diff hunks up to the specified number of lines, implies --patch"),
     -+			      PARSE_OPT_NONEG),
     ++		OPT_DIFF_UNIFIED(&add_p_opt.context),
     ++		OPT_DIFF_INTERHUNK_CONTEXT(&add_p_opt.interhunkcontext),
       		OPT__QUIET(&quiet, N_("quiet mode")),
       		OPT_BOOL('u', "include-untracked", &include_untracked,
       			 N_("include untracked files in stash")),
     @@ commit.h: int for_each_commit_graft(each_commit_graft_fn, void *);
       struct commit_extra_header {
       	struct commit_extra_header *next;
      
     + ## parse-options.h ##
     +@@ parse-options.h: int parse_opt_tracking_mode(const struct option *, const char *, int);
     + #define OPT_PATHSPEC_FROM_FILE(v) OPT_FILENAME(0, "pathspec-from-file", v, N_("read pathspec from file"))
     + #define OPT_PATHSPEC_FILE_NUL(v)  OPT_BOOL(0, "pathspec-file-nul", v, N_("with --pathspec-from-file, pathspec elements are separated with NUL character"))
     + #define OPT_AUTOSTASH(v) OPT_BOOL(0, "autostash", v, N_("automatically stash/stash pop before and after"))
     ++#define OPT_DIFF_UNIFIED(v) OPT_INTEGER_F('U', "unified", v, N_("generate diffs with <n> lines context"), PARSE_OPT_NONEG)
     ++#define OPT_DIFF_INTERHUNK_CONTEXT(v) OPT_INTEGER_F(0, "inter-hunk-context", v, N_("show context between diff hunks up to the specified number of lines"), PARSE_OPT_NONEG)
     + 
     + #define OPT_IPVERSION(v) \
     + 	OPT_SET_INT_F('4', "ipv4", (v), N_("use IPv4 addresses only"), \
     +
     + ## t/t4032-diff-inter-hunk-context.sh ##
     +@@ t/t4032-diff-inter-hunk-context.sh: t() {
     + 	"
     + }
     + 
     ++t_patch() {
     ++	use_config=
     ++	git config --unset diff.interHunkContext
     ++
     ++	case $# in
     ++	4) hunks=$4; cmd="add -p -U$3";;
     ++	5) hunks=$5; cmd="add -p -U$3 --inter-hunk-context=$4";;
     ++	6) hunks=$5; cmd="add -p -U$3"; git config diff.interHunkContext $4; use_config="(diff.interHunkContext=$4) ";;
     ++	esac
     ++	label="$use_config$cmd, $1 common $2"
     ++	file=f$1
     ++
     ++	if ! test -f $file
     ++	then
     ++		f A $1 B >$file
     ++		git add $file
     ++		git commit -q -m. $file
     ++		f X $1 Y >$file
     ++	fi
     ++
     ++	test_expect_success "$label: count hunks ($hunks)" "
     ++		test $(test_write_lines q | git $cmd $file | sed -n 's/^([0-9]*\/\([0-9]*\)) Stage this hunk.*/\1/p') = $hunks
     ++	"
     ++}
     ++
     + cat <<EOF >expected.f1.0.1 || exit 1
     + diff --git a/f1 b/f1
     + --- a/f1
     +@@ t/t4032-diff-inter-hunk-context.sh: t 3 lines	1	2	1	config
     + t 9 lines	3	2	2	config
     + t 9 lines	3	3	1	config
     + 
     ++# common lines	ctx	intrctx	hunks
     ++t_patch 1 line	0		2
     ++t_patch 1 line	0	0	2
     ++t_patch 1 line	0	1	1
     ++t_patch 1 line	0	2	1
     ++t_patch 1 line	1		1
     ++
     ++t_patch 2 lines	0		2
     ++t_patch 2 lines	0	0	2
     ++t_patch 2 lines	0	1	2
     ++t_patch 2 lines	0	2	1
     ++t_patch 2 lines	1		1
     ++
     ++t_patch 3 lines	1		2
     ++t_patch 3 lines	1	0	2
     ++t_patch 3 lines	1	1	1
     ++t_patch 3 lines	1	2	1
     ++
     ++t_patch 9 lines	3		2
     ++t_patch 9 lines	3	2	2
     ++t_patch 9 lines	3	3	1
     ++
     ++#					use diff.interHunkContext?
     ++t_patch 1 line	0	0	2	config
     ++t_patch 1 line	0	1	1	config
     ++t_patch 1 line	0	2	1	config
     ++t_patch 9 lines	3	3	1	config
     ++t_patch 2 lines	0	0	2	config
     ++t_patch 2 lines	0	1	2	config
     ++t_patch 2 lines	0	2	1	config
     ++t_patch 3 lines	1	0	2	config
     ++t_patch 3 lines	1	1	1	config
     ++t_patch 3 lines	1	2	1	config
     ++t_patch 9 lines	3	2	2	config
     ++t_patch 9 lines	3	3	1	config
     ++
     + test_expect_success 'diff.interHunkContext invalid' '
     + 	git config diff.interHunkContext asdf &&
     + 	test_must_fail git diff &&
     +
       ## t/t4055-diff-context.sh ##
      @@ t/t4055-diff-context.sh: test_expect_success 'The -U option overrides diff.context' '
     - 	! grep "^ firstline" output
     + 	test_grep ! "^ firstline" output
       '
       
      +test_expect_success 'The -U option overrides diff.context for "add"' '
     -+	git config diff.context 8 &&
     ++	test_config diff.context 8 &&
      +	git add -U4 -p >output &&
     -+	! grep "^ firstline" output
     ++	test_grep ! "^ firstline" output
      +'
      +
      +test_expect_success 'The -U option overrides diff.context for "commit"' '
     -+	git config diff.context 8 &&
     ++	test_config diff.context 8 &&
      +	! git commit -U4 -p >output &&
     -+	! grep "^ firstline" output
     ++	test_grep ! "^ firstline" output
      +'
      +
      +test_expect_success 'The -U option overrides diff.context for "checkout"' '
     -+	git config diff.context 8 &&
     ++	test_config diff.context 8 &&
      +	git checkout -U4 -p >output &&
     -+	! grep "^ firstline" output
     ++	test_grep ! "^ firstline" output
      +'
      +
      +test_expect_success 'The -U option overrides diff.context for "stash"' '
     -+	git config diff.context 8 &&
     ++	test_config diff.context 8 &&
      +	! git stash -U4 -p >output &&
     -+	! grep "^ firstline" output
     ++	test_grep ! "^ firstline" output
      +'
      +
      +test_expect_success 'The -U option overrides diff.context for "restore"' '
     -+	git config diff.context 8 &&
     ++	test_config diff.context 8 &&
      +	git restore -U4 -p >output &&
     -+	! grep "^ firstline" output
     ++	test_grep ! "^ firstline" output
      +'
      +
       test_expect_success 'diff.context honored by "diff"' '
     - 	git config diff.context 8 &&
     + 	test_config diff.context 8 &&
       	git diff >output &&
      
       ## t/t9902-completion.sh ##
 3:  b4b7854f330 < -:  ----------- add-interactive: add new "context" subcommand

-- 
gitgitgadget

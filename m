Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE98AC433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD75D60F23
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236721AbhJLNc5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 09:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbhJLNc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 09:32:56 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D422FC061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:30:54 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id a25so65266148edx.8
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xe0nkLpteO5UpPGluzcXIhGtDvn0FuG3208/vG09AaE=;
        b=NjDjorgsGfxaRc3P8inrbLNvrRt2wzwhd7lInZUmCbayIsC13gRJfC/jV8X8ldilMk
         Y+4rPRCp2V69g6gTr7gBUwKYjkxYJM2c1fhiMYZnP1ov6xqcxyW5jFpySbNvaTw3GX0Z
         YEAhAxs31F6o6InpXWOsjKrZ0lhnWuNfmHbQF3pcfq2adRISPfeloE6E+PrD5330AW1/
         e/irzFvmwY2YNBEcgrnMMcE9H0tsZo06fcIlbjd3KXGTU0Y8sGUpPmJlw+kgqtfcyfoL
         VAm1cvGTA03kmA/Pe6PnfeK6rHl5+J6ea3dkiCjti4TPWdyn61qq3tT1fETLB8dgWfd+
         jtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xe0nkLpteO5UpPGluzcXIhGtDvn0FuG3208/vG09AaE=;
        b=v4hgUyIiuHBN+eK24Wum9X6kjN/36UR3IgNuY8HPOmQgCifUE7HoXhjE52Fykm2LCK
         t2fSD1oiggoT0ArnDP2Uq5wGbpeyxzbY6XInzs5h5cpOKeoI/FF5RGHXfE6U90UeM/T0
         vAuQMVcYLGtITWsWAGTeM3IfRbCQehT18v8Zmd0RVqOuVAWsg0yYZsHQ/4G4VnFyH8UG
         BaveeX9viTSGnmtO1yyMqpzBbCwpUUesIjN4oiCalimtLMcWetBPP8z0AsGB/ZPOjx04
         eQTEYolDJ7jPT+IPEw/kd5Fv0Imy2p+Az9NeC5Z0ii/q9ngQQQVWEvqAEOdm43pDFSa/
         TC6A==
X-Gm-Message-State: AOAM532JSkSTV7WSV74j7i9qoguFZMfxtU+VY33wm1Y5w9TlGVGeYws7
        m2F5/47jhpVgYpgysHC7PaxvGxFYUCQ/YQ==
X-Google-Smtp-Source: ABdhPJyOm1eHE96r1x2YWyrBKoQSWatKwrN7rLp/SV6/Nmg5rc2ip7/6F1gA97lyAh8Sq0gMLQdoPw==
X-Received: by 2002:a05:6402:1356:: with SMTP id y22mr9565374edw.3.1634045449710;
        Tue, 12 Oct 2021 06:30:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bi23sm2016405ejb.122.2021.10.12.06.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 06:30:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Luke Diamand <luke@diamand.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/13] hook.[ch]: new library to run hooks + simple hook conversion
Date:   Tue, 12 Oct 2021 15:30:25 +0200
Message-Id: <cover-00.13-00000000000-20211012T131934Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1567.g7b23ce7ed9e
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is part 2 of an incremental restart of the greater
"config-based hooks" topic by Emily Shaffer that I've been helping
with. See [1] for part 1, and [2] (search for "mark2") for a summary
of parts to come.

This goes on top of the "ab/config-based-hooks-1" topic that's already
in "next" and marked for graduation to "master".

In this topic we build upon the skeleton hook.[ch] library and build
infrastructure added in part 1 and add a hook running library and new
"git hook" command.

The new "git hook" command is (for now) only for the benefit of
in-tree non-C programs that need to run hooks, and this series
converts git-send-email and git-p4 to use it.

At the end of the series we remove
"run_hook_{le,ve}()" from run-command.c, as we've migrated all its
callers.

What we don't do is convert any of the more complex in-tree hooks that
require input on stdin such as "pre-receive" and the like, that's in
later parts once this lands.

This series is approximately patch 6-20/36 of the previous 36 patch
ab/config-based-hooks-base topic. A range-diff to that v5[3] is
included below.

The changes since that v5 are rather trivial, they are:

 * Formatting changes to reduce the diff to parts that come after this
   (which Emily & I were juggling at the time), and re-flowing some
   overly long lines.

 * The new test is now marked for SANITIZE=leak testing, with the new
   test facility I've added recently (and which just landed in
   "master"). They all pass, the new API doesn't leak.

 * I rewrote some of the git-send-email.perl code to avoid
   de-duplication and hardcoding (just using intermediate variables).

Things to focus on reviewing:

 * This should all be pretty solid and well tested, but the git-p4.py
   part in particular I've never tested for real (not having access to
   p4), and think Emily hasn't either[4].

   The relevant patch looks trivially correct to me[5], and I've tried it
   out in the Python REPL. But if any of the CC'd people active in
   git-p4.py development could give it some end-to-end testing that
   would be much appreciated.

 * Both Python and Perl code now calls the in-between "git hook run"
   command rather than calling hooks directly. Will this behave
   differently due to any special behavior running via a git built-in
   adds?

   I vaguely recall a third-party "git-foo" program breaking in the
   past when invoked as "git foo" but not "git-foo", due to git
   squatting on SIGINT, but none of that should be relevant here
   (we're not starting a pager etc.).

1. https://lore.kernel.org/git/cover-v2-0.8-00000000000-20210926T185800Z-avarab@gmail.com/
2. https://lore.kernel.org/git/875yut8nns.fsf@evledraar.gmail.com/
3. https://lore.kernel.org/git/cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com/
4. https://lore.kernel.org/git/20210311021037.3001235-26-emilyshaffer@google.com/
5. https://lore.kernel.org/git/patch-09.13-69cc447a1e1-20211012T131934Z-avarab@gmail.com

Emily Shaffer (12):
  hook: add 'run' subcommand
  gc: use hook library for pre-auto-gc hook
  rebase: convert pre-rebase to use hook.h
  am: convert applypatch to use hook.h
  hooks: convert 'post-checkout' hook to hook library
  merge: convert post-merge to use hook.h
  send-email: use 'git hook run' for 'sendemail-validate'
  git-p4: use 'git hook' to run hooks
  commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
  read-cache: convert post-index-change to use hook.h
  receive-pack: convert push-to-checkout hook to hook.h
  run-command: remove old run_hook_{le,ve}() hook API

Ævar Arnfjörð Bjarmason (1):
  git hook run: add an --ignore-missing flag

 .gitignore                 |   1 +
 Documentation/git-hook.txt |  46 +++++++++++++
 Documentation/githooks.txt |   4 ++
 Makefile                   |   1 +
 builtin.h                  |   1 +
 builtin/am.c               |   8 ++-
 builtin/checkout.c         |  14 ++--
 builtin/clone.c            |   7 +-
 builtin/gc.c               |   3 +-
 builtin/hook.c             |  96 ++++++++++++++++++++++++++
 builtin/merge.c            |   4 +-
 builtin/rebase.c           |   8 ++-
 builtin/receive-pack.c     |   7 +-
 builtin/worktree.c         |  28 ++++----
 command-list.txt           |   1 +
 commit.c                   |  15 +++--
 git-p4.py                  |  72 ++------------------
 git-send-email.perl        |  22 +++---
 git.c                      |   1 +
 hook.c                     | 130 +++++++++++++++++++++++++++++++++++
 hook.h                     |  61 +++++++++++++++++
 read-cache.c               |  11 ++-
 reset.c                    |  14 ++--
 run-command.c              |  32 ---------
 run-command.h              |  17 -----
 t/t1800-hook.sh            | 134 +++++++++++++++++++++++++++++++++++++
 t/t9001-send-email.sh      |   4 +-
 27 files changed, 572 insertions(+), 170 deletions(-)
 create mode 100644 Documentation/git-hook.txt
 create mode 100644 builtin/hook.c
 create mode 100755 t/t1800-hook.sh

Range-diff:
 1:  72dd1010f5b !  1:  a39c0748d3f hook: add 'run' subcommand
    @@ hook.h
     +	struct run_hooks_opt *options;
     +};
      
    - /**
    + /*
       * Returns the path to the hook file, or NULL if the hook is missing
     @@ hook.h: const char *find_hook(const char *name);
       */
    @@ t/t1800-hook.sh (new)
     +
     +test_description='git-hook command'
     +
    ++TEST_PASSES_SANITIZE_LEAK=true
     +. ./test-lib.sh
     +
     +test_expect_success 'git hook usage' '
 2:  821cc9bf11e !  2:  dbac4204f7b gc: use hook library for pre-auto-gc hook
    @@ hook.c: int run_hooks(const char *hook_name, const char *hook_path,
     +int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *options)
     +{
     +	const char *hook_path;
    -+	int ret;
     +	struct run_hooks_opt hook_opt_scratch = RUN_HOOKS_OPT_INIT;
    ++	int ret = 0;
     +
     +	if (!options)
     +		options = &hook_opt_scratch;
     +
     +	hook_path = find_hook(hook_name);
    -+	if (!hook_path) {
    -+		ret = 0;
    ++	if (!hook_path)
     +		goto cleanup;
    -+	}
     +
     +	ret = run_hooks(hook_name, hook_path, options);
    -+
     +cleanup:
     +	run_hooks_opt_clear(options);
     +
 3:  d71c90254ea !  3:  ff306debcb8 rebase: convert pre-rebase to use hook.h
    @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
      	}
      
      	/* If a hook exists, give it a chance to interrupt*/
    -+	strvec_pushl(&hook_opt.args, options.upstream_arg, argc ? argv[0] : NULL, NULL);
    ++	strvec_push(&hook_opt.args, options.upstream_arg);
    ++	if (argc)
    ++		strvec_push(&hook_opt.args, argv[0]);
      	if (!ok_to_skip_pre_rebase &&
     -	    run_hook_le(NULL, "pre-rebase", options.upstream_arg,
     -			argc ? argv[0] : NULL, NULL))
 4:  ea3af2ccc4d =  4:  b1d529ca485 am: convert applypatch to use hook.h
 5:  fed0b52f88f !  5:  15d71fc210b hooks: convert 'post-checkout' hook to hook library
    @@ builtin/clone.c: static int checkout(int submodule_progress)
      
     -	err |= run_hook_le(NULL, "post-checkout", oid_to_hex(null_oid()),
     -			   oid_to_hex(&oid), "1", NULL);
    -+	strvec_pushl(&hook_opt.args, oid_to_hex(null_oid()), oid_to_hex(&oid), "1", NULL);
    ++	strvec_pushl(&hook_opt.args, oid_to_hex(null_oid()), oid_to_hex(&oid),
    ++		     "1", NULL);
     +	err |= run_hooks_oneshot("post-checkout", &hook_opt);
      
      	if (!err && (option_recurse_submodules.nr > 0)) {
 6:  53d8721a0e3 =  6:  08f27f0d6be merge: convert post-merge to use hook.h
 7:  d60827a2856 !  7:  107c14d740f git hook run: add an --ignore-missing flag
    @@ builtin/hook.c: static int run(int argc, const char **argv, const char *prefix)
      	const char *hook_path;
      	struct option run_options[] = {
     +		OPT_BOOL(0, "ignore-missing", &ignore_missing,
    -+			 N_("exit quietly with a zero exit code if the requested hook cannot be found")),
    ++			 N_("silently ignore missing requested <hook-name>")),
      		OPT_END(),
      	};
      	int ret;
 8:  d4976a0821f !  8:  1d30e2dbbe0 send-email: use 'git hook run' for 'sendemail-validate'
    @@ git-send-email.perl: sub validate_patch {
      				or die("chdir: $!");
      			local $ENV{"GIT_DIR"} = $repo->repo_path();
     -			$hook_error = system_or_msg([$validate_hook, $target]);
    -+			my @validate_hook = ("git", "hook", "run", "--ignore-missing", $hook_name, "--", $target);
    -+			$hook_error = system_or_msg(\@validate_hook, undef,
    -+						       "git hook run $hook_name -- <patch>");
    ++			my @cmd = ("git", "hook", "run", "--ignore-missing",
    ++				    $hook_name, "--");
    ++			my @cmd_msg = (@cmd, "<patch>");
    ++			my @cmd_run = (@cmd, $target);
    ++			$hook_error = system_or_msg(\@cmd_run, undef, "@cmd_msg");
      			chdir($cwd_save) or die("chdir: $!");
      		}
      		if ($hook_error) {
    @@ t/t9001-send-email.sh: test_expect_success $PREREQ "--validate respects relative
      	cat >expect <<-EOF &&
      	fatal: longline.patch: rejected by sendemail-validate hook
     -	fatal: command '"'"'my-hooks/sendemail-validate'"'"' died with exit code 1
    -+	fatal: command '"'"'git hook run sendemail-validate -- <patch>'"'"' died with exit code 1
    ++	fatal: command '"'"'git hook run --ignore-missing sendemail-validate -- <patch>'"'"' died with exit code 1
      	warning: no patches were sent
      	EOF
      	test_cmp expect actual
    @@ t/t9001-send-email.sh: test_expect_success $PREREQ "--validate respects absolute
      	cat >expect <<-EOF &&
      	fatal: longline.patch: rejected by sendemail-validate hook
     -	fatal: command '"'"'$hooks_path/sendemail-validate'"'"' died with exit code 1
    -+	fatal: command '"'"'git hook run sendemail-validate -- <patch>'"'"' died with exit code 1
    ++	fatal: command '"'"'git hook run --ignore-missing sendemail-validate -- <patch>'"'"' died with exit code 1
      	warning: no patches were sent
      	EOF
      	test_cmp expect actual
 9:  99f3dcd1945 =  9:  69cc447a1e1 git-p4: use 'git hook' to run hooks
10:  509761454e6 = 10:  1c22b2992cf commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
11:  e2c94d95427 ! 11:  e762fce32af read-cache: convert post-index-change to use hook.h
    @@ Commit message
         Move the post-index-change hook away from run-command.h to and over to
         the new hook.h library.
     
    -    This removes the last direct user of run_hook_ve(), so we can make the
    -    function static now. It'll be removed entirely soon.
    +    This removes the last direct user of "run_hook_ve()" outside of
    +    run-command.c ("run_hook_le()" still uses it). So we can make the
    +    function static now. A subsequent commit will remove this code
    +    entirely when "run_hook_le()" itself goes away.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    @@ read-cache.c: static int do_write_locked_index(struct index_state *istate, struc
      	int was_full = !istate->sparse_index;
     +	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
      
    - 	ret = convert_to_sparse(istate);
    + 	ret = convert_to_sparse(istate, 0);
      
     @@ read-cache.c: static int do_write_locked_index(struct index_state *istate, struct lock_file *l
      	else
12:  fa7d0d24ea2 = 12:  d63b91196ae receive-pack: convert push-to-checkout hook to hook.h
13:  428bb5a6792 = 13:  fe8996dda3e run-command: remove old run_hook_{le,ve}() hook API
-- 
2.33.0.1567.g7b23ce7ed9e


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C86CCA485
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 21:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiGTVWI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 17:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiGTVWG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 17:22:06 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3CB4D4E2
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 14:22:04 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a5so27830890wrx.12
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 14:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rttT4yGjK3pKTn3ZqPcq4S/047hi8Zed5iILVrbnZBM=;
        b=PmZqNpDNTe9eu2mDYgw6ofpzhifU6Q6yiRYRJ65H5Y/akyqp/CRVx0b0NraZa5C67n
         8KsoExOpYztvBqnWpifWs+NR0tS81mBsjZOWeVP2woT+x9g29NtTypwZaOBkpipQNk2Q
         ZZNybjVV99kOa8rnsi5Te8BRLCcob/H+t4UjpK8YvuYIEceQkrze6hDYZeo/KwLoWjBN
         Ysot0s+aZbYdE3fJVIfJQf0D2i+7ZIYqJ87lSEFnKrgY4dLFdkAPAdSsIsDacBgJQsXZ
         kMGG3IKQhPO6oKif37bfj0+a+EgDQpVkqQcipJ4jQbQgM1AyH+OmUgZJtTXU9jLyu6gN
         LhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rttT4yGjK3pKTn3ZqPcq4S/047hi8Zed5iILVrbnZBM=;
        b=y3IBnRgNDLHUt0lBsj8ME5DKzMPJdUgYzxRcM3qSjSG+ydXL9Ju/TXapRw+kWPobtE
         GGWlcZA7e0uLI/HfmLWTAQfrEXoQS5u9HiO9kSeW88JfW6cSjrc+Io3WgYb7Gl5+/nCJ
         OgHleZWcOOmxHjjkVnSFO8CDajpUlF2GgmZpiJS+FUjnGunkrBLxj6OuFyqaOhIMUSyQ
         1vgxiaSqKh9CDqoXwrW88WEzNdXYaqbXdzvtb1gSsDhhfxlsZ1FYgDqjg0UCgR1ttSCT
         /9UGPl/A5JhUhd4NfdWs8ChcFi7JJCj8qb2OBMX1K33d3sEda0op1UN2lxrs1MCuFxgs
         rQ3A==
X-Gm-Message-State: AJIora8pVEbY05gQiiX1nGoPnBa1or+JPmss2SPnuxLCHeixFfjX9it5
        L6eHWdf32/FZwrNpLTDygUDOjr94I3Y/1w==
X-Google-Smtp-Source: AGRyM1s0/n+Deb407W1maxCLw5VgykC2rarcnzRKBwjn+KST8PKmXP87MBPGszQaO4ATs/AOe8IVVA==
X-Received: by 2002:a5d:5885:0:b0:21d:ad15:30be with SMTP id n5-20020a5d5885000000b0021dad1530bemr32244496wrf.90.1658352121723;
        Wed, 20 Jul 2022 14:22:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c024800b003a0375c4f73sm3605441wmj.44.2022.07.20.14.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 14:22:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/14] leak test: add "check" test mode, mark leak-free tests
Date:   Wed, 20 Jul 2022 23:21:38 +0200
Message-Id: <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1064.gc96144cf387
In-Reply-To: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series adds a "check" leak-testing mode, which allows us to
assert that the tests we mark as leak free and those that don't leak
are one-to-one mapped to one another.

Changes since v1:

 * Changed "test-lib.sh" to "test-lib" in $subject, some used that
   form already, and since some of the subjects were long let's use
   that for brevity, and use it consistently.

 * Fix a bug in how --stress interacted with --invert-exit-code, we'll
   no longer remove the trash directory of the "failed" test.

 * Various rewording etc. fixes to t/README. I think this should
   address all of Derrick's comments, and more.

   I opted to split some of that up to avoid the very lengthy
   paragraphs to some extent.

 * v1 had a workaround to not use the "check" mode for t9700. There
   were issues with how that interacted with "test_external" still, so
   this re-roll proposes to remove "test_external" entirelry.

   I'd proposed that as part of a series that didn't make it before, I
   think the end-state is much better:
   https://lore.kernel.org/git/20210309160219.13779-2-avarab@gmail.com/

 * Ejected the "log tests: don't use "exit 1" outside a sub-shell" fix
   from this series. I'll submit it seperately. This series can still
   be based on "master".

   It will fail under "check", but e.g. t7517-per-repo-email.sh also
   occasionally fails for me (it's flaky, sometimes reporting leaks,
   sometimes not). We can just leave it for now...

 * Fix a memory leak in upload-pack under gcc (which is funny with
   "die" sometimes), which allows us to....

 * Turn on "GIT_TEST_SANITIZE_LEAK_LOG=true" in the linux-leaks CI, to
   harden our assertions. Now we really know that we don't have any
   leaks there.

 * Add missing &&-chaining.

 * Under GIT_TEST_SANITIZE_LEAK_LOG=true we'll emit the log content
   now, rather than just linking to it. I omitted it before because
   the "test-results" might include logs from a previous run, but now
   the message we emit is adjusted to account for that instead.

 * Added some missing cases to the commit message explanation of why
   we miss certain leaks without "GIT_TEST_SANITIZE_LEAK_LOG=true".

 * Clarified in t/README how these various new modes interact with one
   another.

Ævar Arnfjörð Bjarmason (14):
  test-lib: use $1, not $@ in test_known_broken_{ok,failure}_
  test-lib: don't set GIT_EXIT_OK before calling test_atexit_handler
  test-lib: fix GIT_EXIT_OK logic errors, use BAIL_OUT
  test-lib: add a --invert-exit-code switch
  t/README: reword the "GIT_TEST_PASSING_SANITIZE_LEAK" description
  test-lib: add a SANITIZE=leak logging mode
  t/Makefile: don't remove test-results in "clean-except-prove-cache"
  tests: move copy/pasted PERL + Test::More checks to a lib-perl.sh
  test-lib: simplify by removing test_external
  test-lib: add a GIT_TEST_PASSING_SANITIZE_LEAK=check mode
  test-lib: have the "check" mode for SANITIZE=leak consider leak logs
  leak tests: mark passing SANITIZE=leak tests as leak-free
  upload-pack: fix a memory leak in create_pack_file()
  CI: use "GIT_TEST_SANITIZE_LEAK_LOG=true" in linux-leaks

 ci/lib.sh                                     |   1 +
 .../netrc/t-git-credential-netrc.sh           |  18 +-
 contrib/scalar/t/Makefile                     |   2 +-
 contrib/subtree/t/Makefile                    |   2 +-
 t/Makefile                                    |   2 +-
 t/README                                      |  73 ++---
 t/lib-perl.sh                                 |  19 ++
 t/t0000-basic.sh                              |  72 +++++
 t/t0027-auto-crlf.sh                          |   1 +
 t/t0032-reftable-unittest.sh                  |   1 +
 t/t0033-safe-directory.sh                     |   1 +
 t/t0050-filesystem.sh                         |   1 +
 t/t0095-bloom.sh                              |   2 +
 t/t0202-gettext-perl.sh                       |  22 +-
 t/t1405-main-ref-store.sh                     |   1 +
 t/t1407-worktree-ref-store.sh                 |   1 +
 t/t1418-reflog-exists.sh                      |   1 +
 t/t1701-racy-split-index.sh                   |   1 +
 t/t2006-checkout-index-basic.sh               |   1 +
 t/t2023-checkout-m.sh                         |   1 +
 t/t2205-add-worktree-config.sh                |   1 +
 t/t3012-ls-files-dedup.sh                     |   1 +
 t/t4017-diff-retval.sh                        |   1 +
 t/t4051-diff-function-context.sh              |   1 +
 t/t4057-diff-combined-paths.sh                |   1 +
 t/t4114-apply-typechange.sh                   |   1 +
 t/t4301-merge-tree-write-tree.sh              |   1 +
 t/t5315-pack-objects-compression.sh           |   1 +
 t/t5351-unpack-large-objects.sh               |   1 +
 t/t5402-post-merge-hook.sh                    |   1 +
 t/t5503-tagfollow.sh                          |   1 +
 t/t6404-recursive-merge.sh                    |   1 +
 t/t6405-merge-symlinks.sh                     |   1 +
 t/t6407-merge-binary.sh                       |   1 -
 t/t6408-merge-up-to-date.sh                   |   1 +
 t/t6411-merge-filemode.sh                     |   1 +
 t/t6413-merge-crlf.sh                         |   1 +
 t/t6415-merge-dir-to-symlink.sh               |   1 +
 t/t6425-merge-rename-delete.sh                |   1 +
 t/t6431-merge-criscross.sh                    |   1 +
 t/t7060-wtstatus.sh                           |   1 +
 t/t7062-wtstatus-ignorecase.sh                |   1 +
 t/t7110-reset-merge.sh                        |   1 +
 t/t7111-reset-table.sh                        |   1 +
 t/t7609-mergetool--lib.sh                     |   1 +
 t/t9100-git-svn-basic.sh                      |   1 -
 t/t9700-perl-git.sh                           |  23 +-
 t/t9901-git-web--browse.sh                    |   1 +
 t/test-lib-functions.sh                       |  89 +------
 t/test-lib.sh                                 | 249 ++++++++++++++----
 upload-pack.c                                 |   1 +
 51 files changed, 396 insertions(+), 216 deletions(-)
 create mode 100644 t/lib-perl.sh

Range-diff against v1:
 1:  5664c4f9a0e !  1:  e53cf647b44 test-lib.sh: use $1, not $@ in test_known_broken_{ok,failure}_
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    test-lib.sh: use $1, not $@ in test_known_broken_{ok,failure}_
    +    test-lib: use $1, not $@ in test_known_broken_{ok,failure}_
     
         Clarify that these two functions never take N arguments, they'll only
         ever receive one. They've needlessly used $@ over $1 since
 2:  c228308c121 !  2:  00af775bd0d test-lib.sh: don't set GIT_EXIT_OK before calling test_atexit_handler
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    test-lib.sh: don't set GIT_EXIT_OK before calling test_atexit_handler
    +    test-lib: don't set GIT_EXIT_OK before calling test_atexit_handler
     
         Change the control flow in test_done so that we'll set GIT_EXIT_OK=t
         after we call test_atexit_handler(). This seems to have been a mistake
 3:  e57e7ca898e !  3:  419bc2c6a6e test-lib.sh: fix GIT_EXIT_OK logic errors, use BAIL_OUT
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    test-lib.sh: fix GIT_EXIT_OK logic errors, use BAIL_OUT
    +    test-lib: fix GIT_EXIT_OK logic errors, use BAIL_OUT
     
         Change various "exit 1" checks that happened after our "die" handler
         had been set up to use BAIL_OUT instead. See 234383cd401 (test-lib.sh:
 4:  4aab7af60e3 !  4:  668c25f4d7e test-lib.sh: add a --invert-exit-code switch
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    test-lib.sh: add a --invert-exit-code switch
    +    test-lib: add a --invert-exit-code switch
     
         Add the ability to have those tests that fail return 0, and those
         tests that succeed return 1. This is useful e.g. to run "--stress"
    @@ t/test-lib.sh: test_ok_ () {
      		_error_exit
      	fi
      	finalize_test_case_output failure "$failure_label" "$@"
    +@@ t/test-lib.sh: test_done () {
    + 			esac
    + 		fi
    + 
    +-		if test -z "$debug" && test -n "$remove_trash"
    ++		if test -n "$stress" && test -n "$invert_exit_code"
    ++		then
    ++			# We're about to move our "$TRASH_DIRECTORY"
    ++			# to "$TRASH_DIRECTORY.stress-failed" if
    ++			# --stress is combined with
    ++			# --invert-exit-code.
    ++			say "with --stress and --invert-exit-code we're not removing '$TRASH_DIRECTORY'"
    ++		elif test -z "$debug" && test -n "$remove_trash"
    + 		then
    + 			test -d "$TRASH_DIRECTORY" ||
    + 			error "Tests passed but trash directory already removed before test cleanup; aborting"
     @@ t/test-lib.sh: test_done () {
      			} ||
      			error "Tests passed but test cleanup failed; aborting"
 5:  6f474a0f83d =  5:  a26cb02db0a t/README: reword the "GIT_TEST_PASSING_SANITIZE_LEAK" description
 6:  ad1395f45af !  6:  f1acf762899 test-lib: add a SANITIZE=leak logging mode
    @@ Commit message
     
             grep -o -P -h '(?<=DEDUP_TOKEN: ).*' test-results/*.leak/trace.git.* | grep -E -o '[^-]+' | sort | uniq -c | sort -nr | head -n 20
     
    +    This new mode requires git to be compiled with SANITIZE=leak, rather
    +    than explaining that in the documentation let's make it
    +    self-documenting by bailing out if the user asks for this without git
    +    having been compiled with SANITIZE=leak, as we do with
    +    GIT_TEST_PASSING_SANITIZE_LEAK=true.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/README ##
    @@ t/README: declared themselves as leak-free by setting
      test mode is used by the "linux-leaks" CI target.
      
     +GIT_TEST_SANITIZE_LEAK_LOG=true will log memory leaks to
    -+"test-results/$TEST_NAME.leak/trace.*" files. Useful in combination
    -+with "GIT_TEST_PASSING_SANITIZE_LEAK" to check if we're falsely
    -+reporting a test as "passing" with SANITIZE=leak due to ignored exit
    -+codes.
    ++"test-results/$TEST_NAME.leak/trace.*" files. The logs include a
    ++"dedup_token" (see +"ASAN_OPTIONS=help=1 ./git") and other options to
    ++make logs +machine-readable.
     +
      GIT_TEST_PROTOCOL_VERSION=<n>, when set, makes 'protocol.version'
      default to n.
    @@ t/test-lib.sh: TEST_NUMBER="${TEST_NAME%%-*}"
      TRASH_DIRECTORY="trash directory.$TEST_NAME$TEST_STRESS_JOB_SFX"
      test -n "$root" && TRASH_DIRECTORY="$root/$TRASH_DIRECTORY"
      case "$TRASH_DIRECTORY" in
    +@@ t/test-lib.sh: then
    + 	test_done
    + fi
    + 
    ++BAIL_OUT_ENV_NEEDS_SANITIZE_LEAK () {
    ++	BAIL_OUT "$1 has no effect except when compiled with SANITIZE=leak"
    ++}
    ++
    + # skip non-whitelisted tests when compiled with SANITIZE=leak
    + if test -n "$SANITIZE_LEAK"
    + then
     @@ t/test-lib.sh: then
      			test_done
      		fi
    @@ t/test-lib.sh: then
     +	fi
      elif test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
      then
    - 	BAIL_OUT "GIT_TEST_PASSING_SANITIZE_LEAK=true has no effect except when compiled with SANITIZE=leak"
    +-	BAIL_OUT "GIT_TEST_PASSING_SANITIZE_LEAK=true has no effect except when compiled with SANITIZE=leak"
    ++	BAIL_OUT_ENV_NEEDS_SANITIZE_LEAK "GIT_TEST_PASSING_SANITIZE_LEAK=true"
    ++elif test_bool_env GIT_TEST_SANITIZE_LEAK_LOG false
    ++then
    ++	BAIL_OUT_ENV_NEEDS_SANITIZE_LEAK "GIT_TEST_SANITIZE_LEAK_LOG=true"
    + fi
    + 
    + # Last-minute variable setup
 -:  ----------- >  7:  0723e90df7b t/Makefile: don't remove test-results in "clean-except-prove-cache"
 -:  ----------- >  8:  987d9d0e98c tests: move copy/pasted PERL + Test::More checks to a lib-perl.sh
 -:  ----------- >  9:  20bd31615e4 test-lib: simplify by removing test_external
 7:  0961df2ab6c ! 10:  78a47d2b348 test-lib.sh: add a GIT_TEST_PASSING_SANITIZE_LEAK=check mode
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    test-lib.sh: add a GIT_TEST_PASSING_SANITIZE_LEAK=check mode
    +    test-lib: add a GIT_TEST_PASSING_SANITIZE_LEAK=check mode
     
         Add a new "GIT_TEST_PASSING_SANITIZE_LEAK=check" mode to the
         test-lib.sh.
    @@ Commit message
         956d2e4639b (tests: add a test mode for SANITIZE=leak, run it in CI,
         2021-09-23).
     
    -    It does so by adding the ability to check that there's a 1=1
    -    correspondence between those tests that are marked as passing with
    -    SANITIZE=leak, and those tests that are leak-free. I.e. a test that
    -    passes with SANITIZE=leak but isn't marked as such with
    -    TEST_PASSES_SANITIZE_LEAK=true will error out.
    +    Rather than document this all in one (even more) dense paragraph split
    +    up the discussion of how it combines with --immediate into its own
    +    paragraph following the discussion of
    +    "GIT_TEST_SANITIZE_LEAK_LOG=true".
    +
    +    Before the removal of "test_external" in a preceding commit we would
    +    have had to special-case t9700-perl-git.sh and t0202-gettext-perl.sh.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ t/README: declared themselves as leak-free by setting
      test mode is used by the "linux-leaks" CI target.
      
     +GIT_TEST_PASSING_SANITIZE_LEAK=check checks that our
    -+"TEST_PASSES_SANITIZE_LEAK=true" markings are current. The "check" is
    -+particularly useful with "--immediate", but otherwise acts the same
    -+for tests that have "TEST_PASSES_SANITIZE_LEAK=true" set. For those
    -+that don't have it set it runs them, and considers them passing
    -+without errors a failure (by providing "--invert-exit-code"). Thus the
    -+"check" mode can be used e.g. with "git rebase --exec" to ensure that
    -+there's a 1=1 mapping between "TEST_PASSES_SANITIZE_LEAK=true" and
    -+those tests that pass under "SANITIZE=leak".
    ++"TEST_PASSES_SANITIZE_LEAK=true" markings are current. Rather than
    ++skipping those tests that haven't set "TEST_PASSES_SANITIZE_LEAK=true"
    ++before sourcing "test-lib.sh" this mode runs them with
    ++"--invert-exit-code". This is used to check that there's a one-to-one
    ++mapping between "TEST_PASSES_SANITIZE_LEAK=true" and those tests that
    ++pass under "SANITIZE=leak". This is especially useful when testing a
    ++series that fixes various memory leaks with "git rebase -x".
     +
      GIT_TEST_SANITIZE_LEAK_LOG=true will log memory leaks to
    - "test-results/$TEST_NAME.leak/trace.*" files. Useful in combination
    - with "GIT_TEST_PASSING_SANITIZE_LEAK" to check if we're falsely
    -
    - ## t/t9700-perl-git.sh ##
    -@@ t/t9700-perl-git.sh: if ! test_have_prereq PERL; then
    - 	test_done
    - fi
    + "test-results/$TEST_NAME.leak/trace.*" files. The logs include a
    + "dedup_token" (see +"ASAN_OPTIONS=help=1 ./git") and other options to
    + make logs +machine-readable.
      
    -+if test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check" && test_have_prereq SANITIZE_LEAK
    -+then
    -+	skip_all='SANITIZE=leak and GIT_TEST_PASSING_SANITIZE_LEAK=check do not combine with test_external'
    -+	test_done
    -+fi
    ++GIT_TEST_PASSING_SANITIZE_LEAK=check when combined with "--immediate"
    ++will run to completion faster, and result in the same failing
    ++tests. The only practical reason to run
    ++GIT_TEST_PASSING_SANITIZE_LEAK=check without "--immediate" is to
    ++combine it with "GIT_TEST_SANITIZE_LEAK_LOG=true". If we stop at the
    ++first failing test case our leak logs won't show subsequent leaks we
    ++might have run into.
     +
    - perl -MTest::More -e 0 2>/dev/null || {
    - 	skip_all="Perl Test::More unavailable, skipping test"
    - 	test_done
    + GIT_TEST_PROTOCOL_VERSION=<n>, when set, makes 'protocol.version'
    + default to n.
    + 
     
      ## t/test-lib.sh ##
    -@@ t/test-lib.sh: fi
    +@@ t/test-lib.sh: BAIL_OUT_ENV_NEEDS_SANITIZE_LEAK () {
      # skip non-whitelisted tests when compiled with SANITIZE=leak
      if test -n "$SANITIZE_LEAK"
      then
    @@ t/test-lib.sh: then
     +elif test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check" ||
     +     test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
      then
    - 	BAIL_OUT "GIT_TEST_PASSING_SANITIZE_LEAK=true has no effect except when compiled with SANITIZE=leak"
    - fi
    + 	BAIL_OUT_ENV_NEEDS_SANITIZE_LEAK "GIT_TEST_PASSING_SANITIZE_LEAK=true"
    + elif test_bool_env GIT_TEST_SANITIZE_LEAK_LOG false
 8:  afbb7e19195 ! 11:  8cc6ab390db test-lib: have the "check" mode for SANITIZE=leak consider leak logs
    @@ Commit message
     
         Before this compiling with SANITIZE=leak and running:
     
    -        ./t4058-diff-duplicates.sh
    +        ./t6407-merge-binary.sh
     
         Will exit successfully, now we'll get an error and an informative
         message on:
     
    -        GIT_TEST_SANITIZE_LEAK_LOG=true ./t4058-diff-duplicates.sh
    +        GIT_TEST_SANITIZE_LEAK_LOG=true ./t6407-merge-binary.sh
     
    -    And even more useful, we'll now either error or exit successfully on
    -    this command, depending on whether or not the test has labeled itself
    -    leak-free with TEST_PASSES_SANITIZE_LEAK=true or not.
    +    Even better, as noted in the updated t/README we'll now error out when
    +    combined with the "check" mode:
     
    -        GIT_TEST_SANITIZE_LEAK_LOG=true GIT_TEST_PASSING_SANITIZE_LEAK=check ./t4058-diff-duplicates.sh
    +        GIT_TEST_PASSING_SANITIZE_LEAK=check \
    +        GIT_TEST_SANITIZE_LEAK_LOG=true \
    +            ./t4058-diff-duplicates.sh
     
    -    Why do we miss these leaks in the first place? As initially noted in
    -    [1] (and discussed downthread) the reasons are:
    +    Why do we miss these leaks? Because:
     
    -     * Our tests will (mostly) catch segfaults and abort(), but if we
    +     * We have leaks inside "test_expect_failure" blocks, which by design
    +       will not distinguish a "normal" failure from an abort() or
    +       segfault. See [1] for a discussion of it shortcomings.
    +
    +     * We have "git" invocations outside of "test_expect_success",
    +       e.g. setup code in the main body of the test, or in test helper
    +       functions that don't use &&-chaining.
    +
    +     * Our tests will otherwise catch segfaults and abort(), but if we
            invoke a command that invokes another command it needs to ferry the
            exit code up to us.
     
    @@ Commit message
            abort()'s. If the test invoking the parent command(s) is using
            "test_must_fail" we'll consider it an expected "ok" failure.
     
    -     * run-command.c notably does not do that, so for e.g. "git push"
    -       tests where we expect a failure and an underlying "git" command
    -       fails we won't ferry up the segfault or abort exit code.
    +     * run-command.c doesn't (but probably should) ferry up such exit
    +       codes, so for e.g. "git push" tests where we expect a failure and an
    +       underlying "git" command fails we won't ferry up the segfault or
    +       abort exit code.
     
          * We have gitweb.perl and some other perl code ignoring return values
            from close(), i.e. ignoring exit codes from "git rev-parse" et al.
     
          * We have in-tree shellscripts like "git-merge-one-file.sh" invoking
    -       git commands, and if they fail returning "1", not ferrying up the
    -       segfault or abort() exit code, or simply ignoring the exit codes(s)
    -       entirely, e.g. these invocations in git-merge-one-file.sh leak, but
    -       aren't reflected in the "git merge" exit code:
    +       git commands, they'll usually return their own exit codes on "git"
    +       failure, rather then ferrying up segfault or abort() exit code.
    +
    +       E.g. these invocations in git-merge-one-file.sh leak, but aren't
    +       reflected in the "git merge" exit code:
     
                 src1=$(git unpack-file $2)
                 src2=$(git unpack-file $3)
    @@ Commit message
            write_tree_trivial() in "builtin/merge.c" calling die() instead of
            ferrying up the relevant exit code.
     
    -    Let's remove "TEST_PASSES_SANITIZE_LEAK=true" from the one test we
    -    were falsely marking as leak-free, marked as such in my
    +    Let's remove "TEST_PASSES_SANITIZE_LEAK=true" from tests we
    +    were falsely marking as leak-free.
    +
    +    In the case of t6407-merge-binary.sh it was marked as leak-free in
         9081a421a6d (checkout: fix "branch info" memory leaks,
         2021-11-16). I'd previously removed other bad
         "TEST_PASSES_SANITIZE_LEAK=true" opt-ins in the series merged in
         ea05fd5fbf7 (Merge branch 'ab/keep-git-exit-codes-in-tests',
    -    2022-03-16).
    +    2022-03-16). The case of t1060-object-corruption.sh is more subtle,
    +    and will be discussed in a subsequent commit.
     
    -    1. https://lore.kernel.org/git/cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com/
    +    1. https://lore.kernel.org/git/cover-0.7-00000000000-20220318T002951Z-avarab@gmail.com/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/README ##
    -@@ t/README: without errors a failure (by providing "--invert-exit-code"). Thus the
    - there's a 1=1 mapping between "TEST_PASSES_SANITIZE_LEAK=true" and
    - those tests that pass under "SANITIZE=leak".
    +@@ t/README: GIT_TEST_SANITIZE_LEAK_LOG=true will log memory leaks to
    + "dedup_token" (see +"ASAN_OPTIONS=help=1 ./git") and other options to
    + make logs +machine-readable.
      
    -+The "check" mode is especially useful if combined with
    -+GIT_TEST_SANITIZE_LEAK_LOG=true.
    ++With GIT_TEST_SANITIZE_LEAK_LOG=true we'll look at the leak logs
    ++before exiting and exit on failure if the logs showed that we had a
    ++memory leak, even if the test itself would have otherwise passed. This
    ++allows us to catch e.g. missing &&-chaining. This is especially useful
    ++when combined with "GIT_TEST_PASSING_SANITIZE_LEAK", see below.
     +
    - GIT_TEST_SANITIZE_LEAK_LOG=true will log memory leaks to
    - "test-results/$TEST_NAME.leak/trace.*" files. Useful in combination
    - with "GIT_TEST_PASSING_SANITIZE_LEAK" to check if we're falsely
    - reporting a test as "passing" with SANITIZE=leak due to ignored exit
    - codes.
    + GIT_TEST_PASSING_SANITIZE_LEAK=check when combined with "--immediate"
    + will run to completion faster, and result in the same failing
    + tests. The only practical reason to run
    +@@ t/README: combine it with "GIT_TEST_SANITIZE_LEAK_LOG=true". If we stop at the
    + first failing test case our leak logs won't show subsequent leaks we
    + might have run into.
      
    -+When GIT_TEST_SANITIZE_LEAK_LOG=true is set we'll look at the
    -+"test-results/$TEST_NAME.leak/trace.*" files at the end of the test
    -+run in combination with the "TEST_PASSES_SANITIZE_LEAK" and
    -+GIT_TEST_PASSING_SANITIZE_LEAK=check setting to see if we'll fail a
    -+test leaked, but which the test run itself didn't catch due to ignored
    -+or missed exit codes.
    ++GIT_TEST_PASSING_SANITIZE_LEAK=(true|check) will not catch all memory
    ++leaks unless combined with GIT_TEST_SANITIZE_LEAK_LOG=true. Some tests
    ++run "git" (or "test-tool" etc.) without properly checking the exit
    ++code, or git will invoke itself and fail to ferry the abort() exit
    ++code to the original caller. When the two modes are combined we'll
    ++look at the "test-results/$TEST_NAME.leak/trace.*" files at the end of
    ++the test run to see if had memory leaks which the test itself didn't
    ++catch.
     +
      GIT_TEST_PROTOCOL_VERSION=<n>, when set, makes 'protocol.version'
      default to n.
      
     
    + ## t/t1060-object-corruption.sh ##
    +@@
    + 
    + test_description='see how we handle various forms of corruption'
    + 
    +-TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + # convert "1234abcd" to ".git/objects/12/34abcd"
    +
      ## t/t6407-merge-binary.sh ##
     @@ t/t6407-merge-binary.sh: test_description='ask merge-recursive to merge binary files'
      GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    @@ t/test-lib.sh: test_atexit_handler () {
     +losing the exit code somewhere, or not propagating it appropriately
     +upwards!
     +
    -+See the logs at \"%s.*\"" \
    ++See the logs at \"%s.*\";
    ++those logs are reproduced below." \
     +	       "$new" "$old" "$file"
     +}
     +
    @@ t/test-lib.sh: test_atexit_handler () {
     +	if test -z "$TEST_RESULTS_SAN_FILE"
     +	then
     +		return
    -+	fi
    ++	fi &&
     +	local old="$TEST_RESULTS_SAN_DIR_NR_LEAKS_STARTUP" &&
     +	local new="$(nr_san_dir_leaks_)" &&
     +
     +	if test $new -le $old
     +	then
     +		return
    -+	fi
    ++	fi &&
     +	local out="$(sanitize_leak_log_message_ "$new" "$old" "$TEST_RESULTS_SAN_FILE")" &&
     +	say_color error "$out" &&
    ++	if test "$old" != 0
    ++	then
    ++		echo &&
    ++		say_color error "The logs include output from past runs to avoid" &&
    ++		say_color error "that remove 'test-results' between runs."
    ++	fi &&
    ++	say_color error "$(cat "$TEST_RESULTS_SAN_FILE".*)" &&
     +
     +	if test -n "$passes_sanitize_leak" && test "$test_failure" = 0
     +	then
    -+		say "As TEST_PASSES_SANITIZE_LEAK=true and our logs show we're leaking, exit non-zero!"
    ++		say "As TEST_PASSES_SANITIZE_LEAK=true and our logs show we're leaking, exit non-zero!" &&
     +		invert_exit_code=t
     +	elif test -n "$passes_sanitize_leak"
     +	then
    -+		say "As TEST_PASSES_SANITIZE_LEAK=true and our logs show we're leaking, and we're failing for other reasons too..."
    ++		say "As TEST_PASSES_SANITIZE_LEAK=true and our logs show we're leaking, and we're failing for other reasons too..." &&
     +		invert_exit_code=
     +	elif test -n "$sanitize_leak_check" && test "$test_failure" = 0
     +	then
    -+		say "As TEST_PASSES_SANITIZE_LEAK=true isn't set the above leak is 'ok' with GIT_TEST_PASSING_SANITIZE_LEAK=check"
    ++		say "As TEST_PASSES_SANITIZE_LEAK=true isn't set the above leak is 'ok' with GIT_TEST_PASSING_SANITIZE_LEAK=check" &&
     +		invert_exit_code=
     +	elif test -n "$sanitize_leak_check"
     +	then
    -+		say "As TEST_PASSES_SANITIZE_LEAK=true isn't set the above leak is 'ok' with GIT_TEST_PASSING_SANITIZE_LEAK=check"
    ++		say "As TEST_PASSES_SANITIZE_LEAK=true isn't set the above leak is 'ok' with GIT_TEST_PASSING_SANITIZE_LEAK=check" &&
     +		invert_exit_code=t
     +	else
    -+		say "With GIT_TEST_SANITIZE_LEAK_LOG=true our logs revealed a memory leak, exit non-zero!"
    ++		say "With GIT_TEST_SANITIZE_LEAK_LOG=true our logs revealed a memory leak, exit non-zero!" &&
     +		invert_exit_code=t
     +	fi
     +}
    @@ t/test-lib.sh: test_done () {
      		then
      			say_color warn "# faking up non-zero exit with --invert-exit-code"
     @@ t/test-lib.sh: test_done () {
    - 		exit 0 ;;
    + 		say_color error "# failed $test_failure among $msg"
    + 		say "1..$test_count"
      
    - 	*)
     +		check_test_results_san_file_ "$test_failure"
     +
    - 		if test $test_external_has_tap -eq 0
    + 		if test -n "$invert_exit_code"
      		then
    - 			say_color error "# failed $test_failure among $msg"
    + 			_invert_exit_code_failure_end_blurb
     @@ t/test-lib.sh: then
      
      	if test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check"
 9:  b75b93822e1 ! 12:  e3c8909207b leak tests: mark passing SANITIZE=leak tests as leak-free
    @@ Commit message
         2021-12-15) and 5a4f8381b68 (Merge branch 'ab/mark-leak-free-tests',
         2021-10-25), or have had their memory leaks fixed since then.
     
    -    With this change there's now a a 1=1 mapping between those tests that
    -    we have opted-in via "TEST_PASSES_SANITIZE_LEAK=true", and those that
    -    pass with the new "check" mode:
    +    With this change there's now a a one-to-one mapping between those
    +    tests that we have opted-in via "TEST_PASSES_SANITIZE_LEAK=true", and
    +    those that pass with the new "check" mode:
     
    -        GIT_TEST_PASSING_SANITIZE_LEAK=check GIT_TEST_SANITIZE_LEAK_LOG=true make test SANITIZE=leak
    +            GIT_TEST_PASSING_SANITIZE_LEAK=check \
    +            GIT_TEST_SANITIZE_LEAK_LOG=true \
    +            make test SANITIZE=leak
     
         Note that the "GIT_TEST_SANITIZE_LEAK_LOG=true" is needed due to the
         edge cases noted in a preceding commit, i.e. in some cases we'd pass
    @@ Commit message
         marking those tests as passing that really don't have any leaks,
         whether that was reflected in their exit code or not.
     
    +    Note that the change here to "t9100-git-svn-basic.sh" is marking that
    +    test as passing under SANITIZE=leak, we're removing a
    +    "TEST_FAILS_SANITIZE_LEAK=true" line, not
    +    "TEST_PASSES_SANITIZE_LEAK=true". See 7a98d9ab00d (revisions API: have
    +    release_revisions() release "cmdline", 2022-04-13) for the
    +    introduction of that t/lib-git-svn.sh-specific variable.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/t0027-auto-crlf.sh ##
    @@ t/t9100-git-svn-basic.sh: test_description='git svn basic tests'
      
      prepare_utf8_locale
     
    + ## t/t9700-perl-git.sh ##
    +@@
    + #
    + 
    + test_description='perl interface (Git.pm)'
    ++
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + . "$TEST_DIRECTORY"/lib-perl.sh
    + 
    +
      ## t/t9901-git-web--browse.sh ##
     @@ t/t9901-git-web--browse.sh: test_description='git web--browse basic tests
      
10:  9cedf0cb0e2 <  -:  ----------- log tests: don't use "exit 1" outside a sub-shell
 -:  ----------- > 13:  07b6572aea9 upload-pack: fix a memory leak in create_pack_file()
 -:  ----------- > 14:  eaa35d1bc59 CI: use "GIT_TEST_SANITIZE_LEAK_LOG=true" in linux-leaks
-- 
2.37.1.1064.gc96144cf387


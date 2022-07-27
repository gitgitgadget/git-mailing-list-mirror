Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A68BC19F29
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 23:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbiG0XNz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 19:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiG0XNx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 19:13:53 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAF24C63A
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 16:13:50 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id u14-20020a05600c00ce00b003a323062569so206812wmm.4
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 16:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=0pINDKRz8hM/4vjdMhHKncYLTisPOdyMeXvmYuEXh5A=;
        b=Ow68IA3aCbVNI0SxZsxTAJQU1td+5zTj5qmdyJfrQ7oPEhXfIDwntnc/qiAMWwyT9J
         AEuK7qVa3ebeBr/xULmUK9Ge7KQJ0KeHnwmwbTEclbpeeimy+bT6fWZWB2+7Hr7IbcMl
         8bOxXscTjbLfy7W35eTh3+kTuxixjmEO4OU/pjXimlV3y3ZL4VpQq92welKsimdFfUjF
         0X7DMOfs5jJw5sGcEooPyz2cC1QnoE6DuZKC/KPkoq4b1Ab1o2DengMElv9pWt0At23z
         XtB7EsvKQJDFZForoLIPBjbIdSV4xZs9oldIVxXHSiNH+iR/cyBIdDe0eeDLm5k52RkU
         cihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=0pINDKRz8hM/4vjdMhHKncYLTisPOdyMeXvmYuEXh5A=;
        b=h123EQ7eu12xlq2cYpLCK649E2p52sMHGw464MJBpg9StVXllktKbs3Hr6DtB4VnO4
         nWfqVy2OvQ9UXwvVl2LTOdgEocdVrwrhInTZXBrKRvmWr0idBPUn0Bh4WUqDF4h9Q3zK
         yA9CRRRoPm1qGIEDzzSEebnGFG5BZ6ylP8hmiTx8gnA/q9mPGvMHwE4dUYXHUee2ve/I
         8avsXaoVZZFTuSMo+Bshs7oO/2ersUNfEcwT+L3h8gnqOetktOFi3lKOF62oz42xNuL/
         9h0mVc1kY0Z42st6atJYGFN3blTx+rJ+nrTVJ/WHZwhRbCKgboUqG7+GrSYcOTuvJXoE
         1H+A==
X-Gm-Message-State: AJIora9XvEopIFZLSEE97wZnCjnqfA9NrvckcBnbuZBZg6xe9/0wPDdY
        LsMOKgjn3RG4svw9L3fVeVfGQYT5wzdOWQ==
X-Google-Smtp-Source: AGRyM1vkD2cknu1oYj7A1s5Gj55fzfh64pLvJbnz2Bxi3TKgaZKlpPEum7tm3EDhh8HSs1N0MYxEbQ==
X-Received: by 2002:a05:600c:a4c:b0:39c:6517:1136 with SMTP id c12-20020a05600c0a4c00b0039c65171136mr4635254wmq.12.1658963628639;
        Wed, 27 Jul 2022 16:13:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z3-20020adfec83000000b0021dd08ad8d7sm1692806wrn.46.2022.07.27.16.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 16:13:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 00/15] leak test: add "check" test mode, mark leak-free tests
Date:   Thu, 28 Jul 2022 01:13:28 +0200
Message-Id: <cover-v3-00.15-00000000000-20220727T230800Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1127.g4ecf1c08f67
In-Reply-To: <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com>
References: <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series adds a "check" leak-testing mode, which allows us to
assert that the tests we mark as leak free and those that don't leak
are one-to-one mapped to one another.

Changes since v2:

 * Should fix linux-leaks CI failures when merged with "seen"

 * Rebase on landed topic(s), including updating the mention of the
   now-landed whitelist/blacklist topic.

 * Stopped marking t6415 as leak-free. GCC at some versions and higher
   optimization levels in some versions will spot that it leaks.

 * A new commit to undo various !SANITIZE_LEAK prereqs, for leaks that
   have since been solved.

 * Note that the v2 of this marked t1500 as leak-free, but another
   topic added a leak there. That's since been fixed:
   20220726210020.3397249-1-calvinwan@google.com

1. https://lore.kernel.org/git/cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (15):
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
  leak tests: don't skip some tests under SANITIZE=leak
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
 t/t0002-gitfile.sh                            |   2 +-
 t/t0004-unwritable.sh                         |   2 +-
 t/t0027-auto-crlf.sh                          |   1 +
 t/t0032-reftable-unittest.sh                  |   1 +
 t/t0033-safe-directory.sh                     |   1 +
 t/t0050-filesystem.sh                         |   1 +
 t/t0095-bloom.sh                              |   2 +
 t/t0202-gettext-perl.sh                       |  22 +-
 t/t1405-main-ref-store.sh                     |   1 +
 t/t1407-worktree-ref-store.sh                 |   1 +
 t/t1418-reflog-exists.sh                      |   1 +
 t/t1503-rev-parse-verify.sh                   |   2 +-
 t/t1701-racy-split-index.sh                   |   1 +
 t/t2006-checkout-index-basic.sh               |   1 +
 t/t2023-checkout-m.sh                         |   1 +
 t/t2205-add-worktree-config.sh                |   1 +
 t/t3001-ls-files-others-exclude.sh            |   4 +-
 t/t3012-ls-files-dedup.sh                     |   1 +
 t/t3305-notes-fanout.sh                       |   2 +-
 t/t4017-diff-retval.sh                        |   1 +
 t/t4020-diff-external.sh                      |   4 +-
 t/t4051-diff-function-context.sh              |   1 +
 t/t4057-diff-combined-paths.sh                |   1 +
 t/t4114-apply-typechange.sh                   |   1 +
 t/t4301-merge-tree-write-tree.sh              |   1 +
 t/t5315-pack-objects-compression.sh           |   1 +
 t/t5351-unpack-large-objects.sh               |   1 +
 t/t5402-post-merge-hook.sh                    |   1 +
 t/t5503-tagfollow.sh                          |   1 +
 t/t6102-rev-list-unexpected-objects.sh        |   4 +-
 t/t6404-recursive-merge.sh                    |   1 +
 t/t6405-merge-symlinks.sh                     |   1 +
 t/t6407-merge-binary.sh                       |   1 -
 t/t6408-merge-up-to-date.sh                   |   1 +
 t/t6411-merge-filemode.sh                     |   1 +
 t/t6413-merge-crlf.sh                         |   1 +
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
 t/test-lib.sh                                 | 250 ++++++++++++++----
 upload-pack.c                                 |   1 +
 57 files changed, 405 insertions(+), 227 deletions(-)
 create mode 100644 t/lib-perl.sh

Range-diff against v2:
 1:  e53cf647b44 =  1:  65930cc1445 test-lib: use $1, not $@ in test_known_broken_{ok,failure}_
 2:  00af775bd0d =  2:  242f3c9ed20 test-lib: don't set GIT_EXIT_OK before calling test_atexit_handler
 3:  419bc2c6a6e =  3:  385d5c52d5a test-lib: fix GIT_EXIT_OK logic errors, use BAIL_OUT
 4:  668c25f4d7e =  4:  f3144af2190 test-lib: add a --invert-exit-code switch
 5:  a26cb02db0a !  5:  80a36a47b37 t/README: reword the "GIT_TEST_PASSING_SANITIZE_LEAK" description
    @@ Commit message
         t/README: reword the "GIT_TEST_PASSING_SANITIZE_LEAK" description
     
         Reword the documentation added in 956d2e4639b (tests: add a test mode
    -    for SANITIZE=leak, run it in CI, 2021-09-23) for brevity, and to avoid
    -    a merge conflict with another topic, per [1].
    +    for SANITIZE=leak, run it in CI, 2021-09-23) for brevity.
     
    -    1. https://lore.kernel.org/git/220719.86lespun6l.gmgdl@evledraar.gmail.com/
    +    The comment added in the same commit was also misleading: We skip
    +    certain tests if SANITIZE=leak and GIT_TEST_PASSING_SANITIZE_LEAK=true,
    +    not if we're compiled with SANITIZE=leak. Let's just remove the
    +    comment, the control flow here is obvious enough that the code can
    +    speak for itself.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ t/README: excluded as so much relies on it, but this might change in the future.
      
      GIT_TEST_PROTOCOL_VERSION=<n>, when set, makes 'protocol.version'
      default to n.
    +
    + ## t/test-lib.sh ##
    +@@ t/test-lib.sh: then
    + 	test_done
    + fi
    + 
    +-# skip non-whitelisted tests when compiled with SANITIZE=leak
    + if test -n "$SANITIZE_LEAK"
    + then
    + 	if test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
 6:  f1acf762899 !  6:  4f9b2396c15 test-lib: add a SANITIZE=leak logging mode
    @@ t/test-lib.sh: then
     +	BAIL_OUT "$1 has no effect except when compiled with SANITIZE=leak"
     +}
     +
    - # skip non-whitelisted tests when compiled with SANITIZE=leak
      if test -n "$SANITIZE_LEAK"
      then
    + 	if test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
     @@ t/test-lib.sh: then
      			test_done
      		fi
 7:  0723e90df7b =  7:  c7ea6dc013b t/Makefile: don't remove test-results in "clean-except-prove-cache"
 8:  987d9d0e98c =  8:  53ea78bf417 tests: move copy/pasted PERL + Test::More checks to a lib-perl.sh
 9:  20bd31615e4 =  9:  871d266f435 test-lib: simplify by removing test_external
10:  78a47d2b348 ! 10:  32564b8fcb3 test-lib: add a GIT_TEST_PASSING_SANITIZE_LEAK=check mode
    @@ t/README: declared themselves as leak-free by setting
     
      ## t/test-lib.sh ##
     @@ t/test-lib.sh: BAIL_OUT_ENV_NEEDS_SANITIZE_LEAK () {
    - # skip non-whitelisted tests when compiled with SANITIZE=leak
    + 
      if test -n "$SANITIZE_LEAK"
      then
     -	if test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
11:  8cc6ab390db = 11:  fb7e5e1b4cb test-lib: have the "check" mode for SANITIZE=leak consider leak logs
 -:  ----------- > 12:  6df9078e266 leak tests: don't skip some tests under SANITIZE=leak
12:  e3c8909207b ! 13:  28255ac3239 leak tests: mark passing SANITIZE=leak tests as leak-free
    @@ t/t6413-merge-crlf.sh: test_description='merge conflict in crlf repo
      
      test_expect_success setup '
     
    - ## t/t6415-merge-dir-to-symlink.sh ##
    -@@ t/t6415-merge-dir-to-symlink.sh: test_description='merging when a directory was replaced with a symlink'
    - GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    - export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    - 
    -+TEST_PASSES_SANITIZE_LEAK=true
    - . ./test-lib.sh
    - 
    - test_expect_success 'create a commit where dir a/b changed to symlink' '
    -
      ## t/t6425-merge-rename-delete.sh ##
     @@ t/t6425-merge-rename-delete.sh: test_description='Merge-recursive rename/delete conflict message'
      GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
13:  07b6572aea9 = 14:  c1436269c64 upload-pack: fix a memory leak in create_pack_file()
14:  eaa35d1bc59 = 15:  e4acdb18ec2 CI: use "GIT_TEST_SANITIZE_LEAK_LOG=true" in linux-leaks
-- 
2.37.1.1127.g4ecf1c08f67


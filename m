Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8D6C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 18:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236619AbiF3SOV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 14:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbiF3SOE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 14:14:04 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8581D3E0E9
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:14:02 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k22so28475350wrd.6
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qZXHGbCGytjXvch86tMixD8+T89LuBCY+4RITY27p94=;
        b=R0OFX60ynbyZjH2gOnC5hTgaS9f9FU/2yVOq5PrPSZ6rae7CSuwL5SdfTHL7sz/0Z7
         vcOypQw/0rCCbPUGBqgCFrhf6mlNndt2MBIPMf+xamMY46bw9NMJ5fNWlN0/POa9bVvV
         vtFZpkVspNqeyxuTT29xP/PhtyHoel5Vh1TYYb+gjtkLhn6Gfikq9w46rsSqIsbTSNFn
         QeParAl+Odappnpwr4jQ/uOVqIoQnyHJD26H2F/k5mvsKslUFnCwtAx0HgTzSwie6pKl
         ot5vSZ1OCNBg2WpUNGB5eleWUx9JVxVGO+draclNe7V5v7esQhWeUtALwg8t+9+GTfLC
         ODEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qZXHGbCGytjXvch86tMixD8+T89LuBCY+4RITY27p94=;
        b=qgGOPaLnWx0ibrC50OuKx8qWIMtLoyFhPHuTICn+DxY+B0CupB+pehYqF1zKE4dDOF
         u22xR+8IrpohMNRj2MszPKldhkqiUykUXaUVa1r+oeT+ZVPFS7TNPPodIn1/DQ/m0wbs
         +RAhlK0jB7ah6/+6T+jBxzSWdrJPQaB9gsJCCHPgG3TkYQt4Z8CHLA7k0B8JfUQ6jkum
         aGsgqSYxEQuQI92w9NAb7yFBs/d1SLlsKXXCj68zq/uY/2/xPJPCcmU7v+xVF9qY9hjt
         J9zXd0UZZ9orqpqUCFR3T6Utwjuh1L0+NB4cpWeiqLJl7GxsguE5FcVR6C95Ul2vvmDC
         biOQ==
X-Gm-Message-State: AJIora8wiX6Y+srIqQUiW3dF0Fx6BZriiZHxqoCMqO8uCvNOKptInno2
        pC09fgL+IQoCA7r4YZCcnVD9jV5WUa8=
X-Google-Smtp-Source: AGRyM1tsNCa5MCQO5Lg7npDBkN+5SJ8T4k/5zqs6ZsmYjPlIg7+KGCyTpBY5PlZYY4gM9HVZH0TNAA==
X-Received: by 2002:a5d:64a3:0:b0:21b:b86f:e9cc with SMTP id m3-20020a5d64a3000000b0021bb86fe9ccmr9392770wrp.156.1656612840708;
        Thu, 30 Jun 2022 11:14:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d10-20020adff2ca000000b0021a38089e99sm20014162wrp.57.2022.06.30.11.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 11:14:00 -0700 (PDT)
Message-Id: <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.v5.git.git.1656354994.gitgitgadget@gmail.com>
References: <pull.1261.v5.git.git.1656354994.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Jun 2022 18:13:54 +0000
Subject: [PATCH v6 0/5] config: introduce discovery.bare and protected config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a quick re-roll to address Ævar's comments on the tests (thanks!).

This version is mostly simple refactoring, and I also removed a useless test
assertion (see "Series history").

= Description

There is a known social engineering attack that takes advantage of the fact
that a working tree can include an entire bare repository, including a
config file. A user could run a Git command inside the bare repository
thinking that the config file of the 'outer' repository would be used, but
in reality, the bare repository's config file (which is attacker-controlled)
is used, which may result in arbitrary code execution. See [1] for a fuller
description and deeper discussion.

This series implements a simple way of preventing such attacks: create a
config option, discovery.bare, that tells Git whether or not to die when it
finds a bare repository. discovery.bare has two values:

 * "always": always allow bare repositories (default), identical to current
   behavior
 * "never": never allow bare repositories

and users/system administrators who never expect to work with bare
repositories can secure their environments using "never". discovery.bare has
no effect if --git-dir or GIT_DIR is passed because we are confident that
the user is not confused about which repository is being used.

This series does not change the default behavior, but in the long-run, a
"no-embedded" option might be a safe and usable default [2]. "never" is too
restrictive and unlikely to be the default.

For security reasons, discovery.bare cannot be read from repository-level
config (because we would end up trusting the embedded bare repository that
we aren't supposed to trust to begin with). Since this would introduce a 3rd
variable that is only read from 'protected/trusted configuration' (the
others are safe.directory and uploadpack.packObjectsHook) this series also
defines and creates a shared implementation for 'protected configuration'

= Patch organization

 * Patch 1 add a section on configuration scopes to our docs
 * Patches 2-3 define 'protected configuration' and create a shared
   implementation.
 * Patch 4 refactors safe.directory to use protected configuration
 * Patch 5 adds discovery.bare

= Series history

Changes in v6:

 * Add TEST_PASSES_SANITIZE_LEAK=true
 * Replace all sub-shells with -C and use test_config_global
 * Change the expect_rejected helper to use "grep -F" with a more specific
   message.
   * This reveals that the "-c discovery.bare=" assertion in the last test
     was passing for the wrong reason (because '' is an invalid value for
     "discovery.bare"). I removed it because it wasn't doing anything useful
     anyway - I was trying to make discovery.bare unset in the command line,
     but the whole point of that test is to assert that we respect the CLI
     arg.

Changes in v5:

 * Standardize the usage of "protected configuration" instead of mixing
   "config" and "configuration". This required some unfortunate rewrapping.
 * Remove mentions of "trustworthiness" when discussing protected
   configuration and focus on what Git does instead.
   * The rationale of protected vs non-protected is still kept.
 * Fix the stale documentation entry for discovery.bare.
 * Include a fuller description of how discovery.bare and "--git-dir"
   interact instead of saying "has no effect".

Changes in v4:

 * 2/5's commit message now justifies what scopes are included in protected
   config
 * The global configset is now a file-scope static inside config.c
   (previously it was a member of the_repository).
 * Rename discovery_bare_config to discovery_bare_allowed
 * Make discovery_bare_allowed function-scoped (instead of global).
 * Add an expect_accepted helper to the discovery.bare tests.
 * Add a helper to "upload-pack" that reads the protected and non-protected
   config

Changes in v3:

 * Rebase onto a more recent 'master'
 * Reframe this feature in only in terms of the 'embedded bare repo' attack.
 * Other docs improvements (thanks Stolee in particular!)
 * Protected config no longer uses read_very_early_config() and is only read
   once
 * Protected config now includes "-c"
 * uploadpack.packObjectsHook now uses protected config instead of ignoring
   repo config using config scopes

Changes in v2:

 * Rename safe.barerepository to discovery.bare and make it die()
 * Move tests into t/t0034-discovery-bare.sh
 * Avoid unnecessary config reading by using a static variable
 * Add discovery.bare=cwd
 * Fix typos

= Future work

 * This series does not implement the "no-embedded" option [2] and I won't
   work on it any time soon, but I'd be more than happy to review if someone
   sends patches.
 * With discovery.bare, if a builtin is marked RUN_SETUP_GENTLY, setup.c
   doesn't die() and we don't tell users why their repository was rejected,
   e.g. "git config" gives an opaque "fatal: not in a git directory". This
   isn't a new problem though, since safe.directory has the same issue.

[1]
https://lore.kernel.org/git/kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com

[2] This was first suggested in
https://lore.kernel.org/git/5b969c5e-e802-c447-ad25-6acc0b784582@github.com

Glen Choo (5):
  Documentation/git-config.txt: add SCOPES section
  Documentation: define protected configuration
  config: learn `git_protected_config()`
  safe.directory: use git_protected_config()
  setup.c: create `discovery.bare`

 Documentation/config.txt            |  2 +
 Documentation/config/discovery.txt  | 23 +++++++++
 Documentation/config/safe.txt       |  6 +--
 Documentation/config/uploadpack.txt |  6 +--
 Documentation/git-config.txt        | 77 +++++++++++++++++++++++------
 config.c                            | 51 +++++++++++++++++++
 config.h                            | 17 +++++++
 setup.c                             | 59 +++++++++++++++++++++-
 t/t0033-safe-directory.sh           | 24 ++++-----
 t/t0035-discovery-bare.sh           | 52 +++++++++++++++++++
 t/t5544-pack-objects-hook.sh        |  7 ++-
 upload-pack.c                       | 27 ++++++----
 12 files changed, 304 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/config/discovery.txt
 create mode 100755 t/t0035-discovery-bare.sh


base-commit: f770e9f396d48b567ef7b37d273e91ad570a3522
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1261%2Fchooglen%2Fsetup%2Fdisable-bare-repo-config-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1261/chooglen/setup/disable-bare-repo-config-v6
Pull-Request: https://github.com/git/git/pull/1261

Range-diff vs v5:

 1:  ee9619f6ec0 = 1:  ee9619f6ec0 Documentation/git-config.txt: add SCOPES section
 2:  43627c05c0b = 2:  43627c05c0b Documentation: define protected configuration
 3:  3efe282e6b9 = 3:  3efe282e6b9 config: learn `git_protected_config()`
 4:  ec925823414 = 4:  ec925823414 safe.directory: use git_protected_config()
 5:  14411512783 ! 5:  a1323d963f9 setup.c: create `discovery.bare`
     @@ t/t0035-discovery-bare.sh (new)
      +
      +test_description='verify discovery.bare checks'
      +
     ++TEST_PASSES_SANITIZE_LEAK=true
      +. ./test-lib.sh
      +
      +pwd="$(pwd)"
     @@ t/t0035-discovery-bare.sh (new)
      +
      +expect_rejected () {
      +	test_must_fail git "$@" rev-parse --git-dir 2>err &&
     -+	grep "discovery.bare" err
     ++	grep -F "cannot use bare repository" err
      +}
      +
      +test_expect_success 'setup bare repo in worktree' '
     @@ t/t0035-discovery-bare.sh (new)
      +'
      +
      +test_expect_success 'discovery.bare unset' '
     -+	(
     -+		cd outer-repo/bare-repo &&
     -+		expect_accepted
     -+	)
     ++	expect_accepted -C outer-repo/bare-repo
      +'
      +
      +test_expect_success 'discovery.bare=always' '
     -+	git config --global discovery.bare always &&
     -+	(
     -+		cd outer-repo/bare-repo &&
     -+		expect_accepted
     -+	)
     ++	test_config_global discovery.bare always &&
     ++	expect_accepted -C outer-repo/bare-repo
      +'
      +
      +test_expect_success 'discovery.bare=never' '
     -+	git config --global discovery.bare never &&
     -+	(
     -+		cd outer-repo/bare-repo &&
     -+		expect_rejected
     -+	)
     ++	test_config_global discovery.bare never &&
     ++	expect_rejected -C outer-repo/bare-repo
      +'
      +
      +test_expect_success 'discovery.bare in the repository' '
     -+	(
     -+		cd outer-repo/bare-repo &&
     -+		# Temporarily set discovery.bare=always, otherwise git
     -+		# config fails with "fatal: not in a git directory"
     -+		# (like safe.directory)
     -+		git config --global discovery.bare always &&
     -+		git config discovery.bare always &&
     -+		git config --global discovery.bare never &&
     -+		expect_rejected
     -+	)
     ++	# discovery.bare must not be "never", otherwise git config fails
     ++	# with "fatal: not in a git directory" (like safe.directory)
     ++	test_config -C outer-repo/bare-repo discovery.bare always &&
     ++	test_config_global discovery.bare never &&
     ++	expect_rejected -C outer-repo/bare-repo
      +'
      +
      +test_expect_success 'discovery.bare on the command line' '
     -+	git config --global discovery.bare never &&
     -+	(
     -+		cd outer-repo/bare-repo &&
     -+		expect_accepted -c discovery.bare=always &&
     -+		expect_rejected -c discovery.bare=
     -+	)
     ++	test_config_global discovery.bare never &&
     ++	expect_accepted -C outer-repo/bare-repo \
     ++		-c discovery.bare=always
      +'
      +
      +test_done

-- 
gitgitgadget

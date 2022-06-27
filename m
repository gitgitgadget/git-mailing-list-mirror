Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB1FC43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 18:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240479AbiF0Sik (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 14:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240486AbiF0SiL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 14:38:11 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B303C66
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:36:37 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id o16so14305163wra.4
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=juupe2wte1ZN55ESCyVSF/JkL1t0eQWgVngJ5i0wg8g=;
        b=XvZJ3yoNEslr9IQ5T0XrCuXmGL4ku4PeCFCv5Ykttwfo2l9OYI/XbK79E86OvQWt0K
         eAMDfSA01XeCKtgZY1Ov0EuZWMGYed4nU1Qq2hUnQ6KVLu0bzgUrSGph7hXucRGIoN5X
         /mo3ZX+0dDlZGDfDh2+wCVNcnv4sCK+96f5Q06rvvuNyZJehUuNlmjbtTQp9o4j7KjU9
         r4TjhEBzTyq/UXvuE40eluDjit9jF/mQBnIgyym4r8XDgXlAoPhNdEEv9Oi01mdjsOWF
         sXZiNyI+lSXy6tZcVbz70KECpcVk4zydgNmGK8jLVDB1S7CKwMi0HjfFveJX4tN71QTE
         xKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=juupe2wte1ZN55ESCyVSF/JkL1t0eQWgVngJ5i0wg8g=;
        b=c9lJGHfPm7L2zlLEoMaKnX4QatN/zSGEpAFNiqg93UZ7RhDnItJpmcPqJu0a+lgzhn
         YpSgusqLjRKF9xCei9v8JJFo1Crr9ufK58oTijabmPjKpsLG1gjNPaJJw4+RKuswkhiD
         hw3/gV4F2XSWEvB0UHDdB/CO8Bp6qhGbNGqWmN2IJym1xuv63pjpk0tWij9oVzgiU2e3
         /tIFFFFa9vKmyzBuhx6NAN0a1YenyOhFhOF47tbdxCZT1SP3exxjIYcKTRAz8nEBQO2z
         T/prW0mFDt2a2JJU4tcwOF/ti+5z7CQQ6SUEm6eqBU+jHX9yiXmPx7reGXEKfnSvl9YL
         ZDPQ==
X-Gm-Message-State: AJIora9mEuPM8ZUNFf9L8E8Z0KAOpKMO1wdoFUNqmdXjUVCvIOO+ZpVu
        f8ZaBwH82QSxV2N0JQHWUFn5b5YeBvniDg==
X-Google-Smtp-Source: AGRyM1uJCTtYgA1qGL3/5ox0j79+fHizzrbcX80pevsfsSRKygc0cWcJwa79BGrLvoxJPjtpGb9oXg==
X-Received: by 2002:a05:6000:991:b0:21b:b7b1:ac50 with SMTP id by17-20020a056000099100b0021bb7b1ac50mr13628488wrb.718.1656354995460;
        Mon, 27 Jun 2022 11:36:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j10-20020a5d448a000000b0021b8c99860asm11275014wrq.115.2022.06.27.11.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 11:36:34 -0700 (PDT)
Message-Id: <pull.1261.v5.git.git.1656354994.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.v4.git.git.1654635432.gitgitgadget@gmail.com>
References: <pull.1261.v4.git.git.1654635432.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jun 2022 18:36:29 +0000
Subject: [PATCH v5 0/5] config: introduce discovery.bare and protected config
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
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous round of this series was picked up by the Google-hosted "Review
Club" (the event is on http://tinyurl.com/gitcal). This round incorporates
Jonathan Tan's feedback (thanks!) as well some feedback from Review Club
itself.

This round only contains changes to commit messages and documentation. As
requested in Review Club, I've included a full "Description" section in this
cover letter for the convenience of new readers.

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
 t/t0035-discovery-bare.sh           | 68 +++++++++++++++++++++++++
 t/t5544-pack-objects-hook.sh        |  7 ++-
 upload-pack.c                       | 27 ++++++----
 12 files changed, 320 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/config/discovery.txt
 create mode 100755 t/t0035-discovery-bare.sh


base-commit: f770e9f396d48b567ef7b37d273e91ad570a3522
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1261%2Fchooglen%2Fsetup%2Fdisable-bare-repo-config-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1261/chooglen/setup/disable-bare-repo-config-v5
Pull-Request: https://github.com/git/git/pull/1261

Range-diff vs v4:

 1:  c0e27ab3b3e ! 1:  ee9619f6ec0 Documentation/git-config.txt: add SCOPES section
     @@ Metadata
       ## Commit message ##
          Documentation/git-config.txt: add SCOPES section
      
     -    In a subsequent commit, we will introduce "protected config", which is
     -    easiest to describe in terms of configuration scopes (i.e. it's the
     -    union of the 'system', 'global', and 'command' scopes). This description
     -    is fine for ML discussions, but it's inadequate for end users because we
     -    don't provide a good description of "config scopes" in the public docs.
     +    In a subsequent commit, we will introduce "protected configuration",
     +    which is easiest to describe in terms of configuration scopes (i.e. it's
     +    the union of the 'system', 'global', and 'command' scopes). This
     +    description is fine for ML discussions, but it's inadequate for end
     +    users because we don't provide a good description of "configuration
     +    scopes" in the public docs.
      
          145d59f482 (config: add '--show-scope' to print the scope of a config
          value, 2020-02-10) introduced the word "scope" to our public docs, but
     @@ Commit message
          those values mean.
      
          Add a SCOPES section to Documentation/git-config.txt that describes the
     -    config scopes, their corresponding CLI options, and mentions that some
     -    configuration options are only respected in certain scopes. Then,
     +    configuration scopes, their corresponding CLI options, and mentions that
     +    some configuration options are only respected in certain scopes. Then,
          use the word "scope" to simplify the FILES section and change some
          confusing wording.
      
 2:  a5a1dcb03e1 ! 2:  43627c05c0b Documentation: define protected configuration
     @@ Commit message
          Documentation: define protected configuration
      
          For security reasons, there are config variables that are only trusted
     -    when they are specified in extra-trustworthy configuration scopes, which
     -    are sometimes referred to on-list as 'protected configuration' [1]. A
     -    future commit will introduce another such variable, so let's define our
     -    terms so that we can have consistent documentation and implementation.
     +    when they are specified in certain configuration scopes, which are
     +    sometimes referred to on-list as 'protected configuration' [1]. A future
     +    commit will introduce another such variable, so let's define our terms
     +    so that we can have consistent documentation and implementation.
      
     -    In our documentation, define 'protected config' as the system, global
     -    and command config scopes. As a shorthand, I will refer to variables
     -    that are only respected in protected config as 'protected config only',
     -    but this term is not used in the documentation.
     +    In our documentation, define 'protected configuration' as the system,
     +    global and command config scopes. As a shorthand, I will refer to
     +    variables that are only respected in protected config as 'protected
     +    configuration only', but this term is not used in the documentation.
      
     -    This definition of protected configuration is based on whether or not
     -    Git can reasonably protect the user by ignoring the configuration scope:
     +    This definition of protected config is based on whether or not Git can
     +    reasonably protect the user by ignoring the configuration scope:
      
          - System, global and command line config are considered protected
            because an attacker who has control over any of those can do plenty of
     @@ Commit message
            considered protected because it is relatively easy for an attacker to
            control local config, e.g.:
            - On some shared user environments, a non-admin attacker can create a
     -        repository high up the directory hierarchy (e.g. C:\.git on Windows),
     -        and a user may accidentally use it when their PS1 automatically
     -        invokes "git" commands.
     +        repository high up the directory hierarchy (e.g. C:\.git on
     +        Windows), and a user may accidentally use it when their PS1
     +        automatically invokes "git" commands.
      
              `safe.directory` prevents attacks of this form by making sure that
              the user intended to use the shared repository. It obviously
     @@ Commit message
              repository (because "git upload-pack" would fail), but we can limit
              the risks by ignoring `uploadpack.packObjectsHook`.
      
     -    Only `uploadpack.packObjectsHook` is 'protected config only'. The
     +    Only `uploadpack.packObjectsHook` is 'protected configuration only'. The
          following variables are intentionally excluded:
      
     -    - `safe.directory` should be 'protected config only', but it does not
     -      technically fit the definition because it is not respected in the
     +    - `safe.directory` should be 'protected configuration only', but it does
     +      not technically fit the definition because it is not respected in the
            "command" scope. A future commit will fix this.
      
          - `trace2.*` happens to read the same scopes as `safe.directory` because
     @@ Documentation/git-config.txt: Most configuration options are respected regardles
       defined in, but some options are only respected in certain scopes. See the
       option's documentation for the full details.
       
     -+Protected config
     -+~~~~~~~~~~~~~~~~
     -+
     -+Protected config refers to the 'system', 'global', and 'command' scopes. Git
     -+considers these scopes to be especially trustworthy because they are likely
     -+to be controlled by the user or a trusted administrator. An attacker who
     -+controls these scopes can do substantial harm without using Git, so it is
     -+assumed that the user's environment protects these scopes against attackers.
     ++Protected configuration
     ++~~~~~~~~~~~~~~~~~~~~~~~
      +
     ++Protected configuration refers to the 'system', 'global', and 'command' scopes.
      +For security reasons, certain options are only respected when they are
     -+specified in protected config, and ignored otherwise.
     ++specified in protected configuration, and ignored otherwise.
     ++
     ++Git treats these scopes as if they are controlled by the user or a trusted
     ++administrator. This is because an attacker who controls these scopes can do
     ++substantial harm without using Git, so it is assumed that the user's environment
     ++protects these scopes against attackers.
      +
       ENVIRONMENT
       -----------
 3:  94b40907e66 ! 3:  3efe282e6b9 config: read protected config with `git_protected_config()`
     @@ Metadata
      Author: Glen Choo <chooglen@google.com>
      
       ## Commit message ##
     -    config: read protected config with `git_protected_config()`
     +    config: learn `git_protected_config()`
      
     -    `uploadpack.packObjectsHook` is the only 'protected config only'
     +    `uploadpack.packObjectsHook` is the only 'protected configuration only'
          variable today, but we've noted that `safe.directory` and the upcoming
     -    `discovery.bare` should also be 'protected config only'. So, for
     +    `discovery.bare` should also be 'protected configuration only'. So, for
          consistency, we'd like to have a single implementation for protected
          config.
      
          The primary constraints are:
      
     -    1. Reading from protected config should be as fast as possible. Nearly
     -       all "git" commands inside a bare repository will read both
     +    1. Reading from protected configuration should be as fast as possible.
     +       Nearly all "git" commands inside a bare repository will read both
             `safe.directory` and `discovery.bare`, so we cannot afford to be
             slow.
      
     @@ Commit message
             `safe.directory` and `discovery.bare` both affect repository
             discovery and the gitdir is not known at that point [1].
      
     -    The chosen implementation in this commit is to read protected config and
     -    cache the values in a global configset. This is similar to the caching
     -    behavior we get with the_repository->config.
     +    The chosen implementation in this commit is to read protected
     +    configuration and cache the values in a global configset. This is
     +    similar to the caching behavior we get with the_repository->config.
      
     -    Introduce git_protected_config(), which reads protected config and
     -    caches them in the global configset protected_config. Then, refactor
     +    Introduce git_protected_config(), which reads protected configuration
     +    and caches them in the global configset protected_config. Then, refactor
          `uploadpack.packObjectsHook` to use git_protected_config().
      
     -    The protected config functions are named similarly to their
     +    The protected configuration functions are named similarly to their
          non-protected counterparts, e.g. git_protected_config_check_init() vs
          git_config_check_init().
      
          In light of constraint 1, this implementation can still be improved
          since git_protected_config() iterates through every variable in
          protected_config, which may still be too expensive. There exist constant
     -    time lookup functions for non-protected config (repo_config_get_*()),
     -    but for simplicity, this commit does not implement similar functions for
     -    protected config.
     +    time lookup functions for non-protected configuration
     +    (repo_config_get_*()), but for simplicity, this commit does not
     +    implement similar functions for protected configuration.
      
          An alternative that avoids introducing another configset is to continue
          to read all config using git_config(), but only accept values that have
     @@ Commit message
          the_repository->config, which would need to be reset when the gitdir is
          known and git_config() needs to read the local and worktree config.
          Resetting the_repository->config might be reasonable while we only have
     -    these 'protected config only' variables, but it's not clear whether this
     -    extends well to future variables.
     +    these 'protected configuration only' variables, but it's not clear
     +    whether this extends well to future variables.
      
          [1] In this case, we do have a candidate gitdir though, so with a little
          refactoring, it might be possible to provide a gitdir.
 4:  156817966fa ! 4:  ec925823414 safe.directory: use git_protected_config()
     @@ Commit message
          safe.directory: use git_protected_config()
      
          Use git_protected_config() to read `safe.directory` instead of
     -    read_very_early_config(), making it 'protected config only'. As a
     -    result, `safe.directory` now respects "-c", so update the tests and docs
     -    accordingly.
     +    read_very_early_config(), making it 'protected configuration only'.
     +
     +    As a result, `safe.directory` now respects "-c", so update the tests and
     +    docs accordingly. It used to ignore "-c" due to how it was implemented,
     +    not because of security or correctness concerns [1].
     +
     +    [1] https://lore.kernel.org/git/xmqqlevabcsu.fsf@gitster.g/
      
          Signed-off-by: Glen Choo <chooglen@google.com>
      
 5:  29053d029f8 ! 5:  14411512783 setup.c: create `discovery.bare`
     @@ Commit message
          Create a config variable, `discovery.bare`, that tells Git whether or
          not to die() when it discovers a bare repository. This only affects
          repository discovery, thus it has no effect if discovery was not
     -    done (e.g. `--git-dir` was passed).
     +    done, e.g. if the user passes `--git-dir=my-dir`, discovery will be
     +    skipped and my-dir will be used as the repo regardless of the
     +    `discovery.bare` value.
      
          This config is an enum of:
      
     @@ Documentation/config.txt: include::config/diff.txt[]
       ## Documentation/config/discovery.txt (new) ##
      @@
      +discovery.bare::
     -+	'(Protected config only)' Specifies whether Git will work with a
     -+	bare repository that it found during repository discovery. This
     -+	has no effect if the repository is specified directly via the
     -+	--git-dir command-line option or the GIT_DIR environment
     -+	variable (see linkgit:git[1]).
     ++	Specifies whether Git will work with a bare repository that it
     ++	found during repository discovery. If the repository is
     ++	specified directly via the --git-dir command-line option or the
     ++	GIT_DIR environment variable (see linkgit:git[1]), Git will
     ++	always use the specified repository, regardless of this value.
     +++
     ++This config setting is only respected in protected configuration (see
     ++<<SCOPES>>). This prevents the untrusted repository from tampering with
     ++this value.
      ++
      +The currently supported values are:
      ++

-- 
gitgitgadget

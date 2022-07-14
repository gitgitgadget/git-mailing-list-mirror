Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB35C43334
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 21:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240832AbiGNV2K (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 17:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240827AbiGNV2I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 17:28:08 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043A826AC0
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 14:28:06 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id o8so1793310wms.2
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 14:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1rW2biMskx8wdP+uBBFXYLemTbORS5b4Gj7Lh9l12jk=;
        b=VBYWdPG1wcH3hIKkhPxz/eCNndm8qZhdyRzayd7p0iUQrwwz53BfSyrTGCB7w9uXGo
         IEXYqdE6nlgXWEBTID6WmdNAfalRLo2smlS74TFtIwAXyJqRLiz0QfzGHm7ZV47BDmEY
         VyxFPB6r+ujnHm1ruPXpbpYlCcyk676lnucRhA1+4QQOldvPAI3w8KcV0TeDfA+y9P6U
         2PF25FiISuEcs5c+xz+IZD5vcczIr1hNA2ehEI95r+7w+3cTbutEWp138gKGVSRHSOMb
         M63bgn3+woWDc6EofBb2zb8PTyxhGacUwo541dkruWh0u9Qlnm+5zUaFUQSBJndPPf7h
         yxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1rW2biMskx8wdP+uBBFXYLemTbORS5b4Gj7Lh9l12jk=;
        b=WOXptAIG+hZtu0g8iHVOQbLGR7PlHAC21bk3DY3L6mPbXR3EpQnKJ5YrR0A7pca6oF
         04w/BB6K41MGKQojtRUl3FbLvghLBSX4tDyzalfcl9OFOtHgIYjv6Az0VvYWLRoKBYpQ
         4hChbpqK6KrcMuvbVpm6D/USfb5NQTeYbIO90vFetRqVFMR7DUmFcbUpqGLs3vQtDys4
         y8LF+B2F8VQtU+atHkMnmebFgp/ilkAUGEvmbGIas9kVTyz6/8oTpmwgyFeivh2QV4d7
         m029nQnnwxVSHvTBsgwec3cfDuI3UxeIzHyEuT2t12jHOL86pcQhl0dNQegCK5r2Jzar
         s3oQ==
X-Gm-Message-State: AJIora9tC3KTx54AYOcP0M6P+0G1dRyNQAvbrjPZiepIXYc38BYp+WHM
        s9/7MSeJ2QRU1ZNX1tL9PvUKhkn6UVI=
X-Google-Smtp-Source: AGRyM1spMaGt3m5DoFZDq/ACyxQHd8x0WAcSCjHcp4nAp0zlYr8d2iEIjdR9JOFalbvxR8AAB+ka8Q==
X-Received: by 2002:a7b:c4d3:0:b0:3a1:8fbf:f03f with SMTP id g19-20020a7bc4d3000000b003a18fbff03fmr17063576wmk.172.1657834083834;
        Thu, 14 Jul 2022 14:28:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m9-20020adfe949000000b0021d4694fcaesm2230718wrn.107.2022.07.14.14.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 14:28:03 -0700 (PDT)
Message-Id: <pull.1261.v8.git.git.1657834081.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.v7.git.git.1657234914.gitgitgadget@gmail.com>
References: <pull.1261.v7.git.git.1657234914.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 14 Jul 2022 21:27:56 +0000
Subject: [PATCH v8 0/5] config: introduce safe.bareRepository and protected config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks all! This version takes Junio's wording suggestions on the previous
round, renames the config variable and, because of conflicts with 2.37.1, is
newly rebased onto master.

The config variable is now named "safe.bareRepository"; I discarded this
name earlier in this series, but the intent behind the series has come
around to the point where "safe.bareRepository" makes sense again. And
thanks to Dscho's suggestion to explicitly create an option for "no
discovered bare repos" [1], the UI is self-documenting enough that we can
write terser docs.

As mentioned upthread, I would love to see "safe.*" namespace renamed (it's
an adjective, not a Git command/entity), but I'm doubling down on it anyway.
This config option does such a similar thing to "safe.directory" that they
really should be siblings, and I don't foresee a world where
"safe.directory" gets renamed.

I've triple-checked to make sure I've scrubbed the commits of the old name,
but I'd appreciate the extra eyes :)

= Description

There is a known social engineering attack that takes advantage of the fact
that a working tree can include an entire bare repository, including a
config file. A user could run a Git command inside the bare repository
thinking that the config file of the 'outer' repository would be used, but
in reality, the bare repository's config file (which is attacker-controlled)
is used, which may result in arbitrary code execution. See [2] for a fuller
description and deeper discussion.

This series implements a simple way of preventing such attacks: create a
config option, safe.bareRepository, that tells Git whether or not to die
when it finds a bare repository. safe.bareRepository has two values:

 * "all": allow all bare repositories (default), identical to current
   behavior
 * "explicit": only allow bare repositories specified via --git-dir or
   GIT_DIR

and users/system administrators who never expect to work with bare
repositories can secure their environments using "explicit". We still trust
explicit bare repositories because we are confident that the user is not
confused about which repository is being used.

This series does not change the default behavior, but in the long-run, a
"no-embedded" option might be a safe and usable default [3]. "never" is too
restrictive and unlikely to be the default.

For security reasons, safe.bareRepository cannot be read from
repository-level config (because we would end up trusting the embedded bare
repository that we aren't supposed to trust to begin with). Since this would
introduce a 3rd variable that is only read from 'protected/trusted
configuration' (the others are safe.directory and
uploadpack.packObjectsHook) this series also defines and creates a shared
implementation for 'protected configuration'

= Patch organization

 * Patch 1 add a section on configuration scopes to our docs
 * Patches 2-3 define 'protected configuration' and create a shared
   implementation.
 * Patch 4 refactors safe.directory to use protected configuration
 * Patch 5 adds safe.bareRepository

= Series history

Changes in v8:

 * Rename discovery.bare -> safe.bareRepository, change values from
   "always|never" -> "all|explicit"
 * Numerous docs improvements
 * Rebase onto post-2.37.1 master

Changes in v7:

 * Numerous docs improvements and code cleanup.
 * In 3/5's commit message, drop "as fast as possible" and allude to lookup
   functions coming in a later series.
 * Remove a comment in 3/5 about repository.protected_config. That was stale
   since v4, but slipped under the radar until now.
 * Fix some s/protected config/protected configuration (leftover from v5).

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

 * This series doesn't implement config lookup functions for protected
   config. This will be done in a follow up series.
 * This series does not implement the "no-embedded" option [3] and I won't
   work on it any time soon, but I'd be more than happy to review if someone
   sends patches.
 * With discovery.bare, if a builtin is marked RUN_SETUP_GENTLY, setup.c
   doesn't die() and we don't tell users why their repository was rejected,
   e.g. "git config" gives an opaque "fatal: not in a git directory". This
   isn't a new problem though, since safe.directory has the same issue.

[1] https://lore.kernel.org/git/5ps2q552-1rr3-7161-4181-31556pp2ns12@tzk.qr

[2]
https://lore.kernel.org/git/kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com

[3] This was first suggested in
https://lore.kernel.org/git/5b969c5e-e802-c447-ad25-6acc0b784582@github.com

Glen Choo (5):
  Documentation/git-config.txt: add SCOPES section
  Documentation: define protected configuration
  config: learn `git_protected_config()`
  safe.directory: use git_protected_config()
  setup.c: create `safe.bareRepository`

 Documentation/config/safe.txt       | 25 +++++++-
 Documentation/config/uploadpack.txt |  6 +-
 Documentation/git-config.txt        | 95 ++++++++++++++++++++++-------
 config.c                            | 43 +++++++++++++
 config.h                            | 16 +++++
 setup.c                             | 59 +++++++++++++++++-
 t/t0033-safe-directory.sh           | 24 +++-----
 t/t0035-safe-bare-repository.sh     | 54 ++++++++++++++++
 t/t5544-pack-objects-hook.sh        |  7 ++-
 upload-pack.c                       | 27 +++++---
 10 files changed, 300 insertions(+), 56 deletions(-)
 create mode 100755 t/t0035-safe-bare-repository.sh


base-commit: 4e2a4d1dd44367d7783f33b169698f2930ff13c0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1261%2Fchooglen%2Fsetup%2Fdisable-bare-repo-config-v8
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1261/chooglen/setup/disable-bare-repo-config-v8
Pull-Request: https://github.com/git/git/pull/1261

Range-diff vs v7:

 1:  5c58db3bb21 ! 1:  6147751c9c1 Documentation/git-config.txt: add SCOPES section
     @@ Commit message
          145d59f482 (config: add '--show-scope' to print the scope of a config
          value, 2020-02-10) introduced the word "scope" to our public docs, but
          that only enumerates the scopes and assumes the user can figure out
     -    those values mean.
     +    what those values mean.
      
          Add a SCOPES section to Documentation/git-config.txt that describes the
          configuration scopes, their corresponding CLI options, and mentions that
     @@ Documentation/git-config.txt: The default is to use a pager.
       
       $(prefix)/etc/gitconfig::
       	System-wide configuration file.
     + 
     + $XDG_CONFIG_HOME/git/config::
     +-	Second user-specific configuration file. If $XDG_CONFIG_HOME is not set
     +-	or empty, `$HOME/.config/git/config` will be used. Any single-valued
     +-	variable set in this file will be overwritten by whatever is in
     +-	`~/.gitconfig`.  It is a good idea not to create this file if
     +-	you sometimes use older versions of Git, as support for this
     +-	file was added fairly recently.
     +-
     + ~/.gitconfig::
     +-	User-specific configuration file. Also called "global"
     +-	configuration file.
     ++	User-specific configuration files. When the XDG_CONFIG_HOME environment
     ++	variable is not set or empty, $HOME/.config/ is used as
     ++	$XDG_CONFIG_HOME.
     +++
     ++These are also called "global" configuration files. If both files exist, both
     ++files are read in the order given above.
     + 
     + $GIT_DIR/config::
     + 	Repository specific configuration file.
      @@ Documentation/git-config.txt: $GIT_DIR/config.worktree::
       	This is optional and is only searched when
       	`extensions.worktreeConfig` is present in $GIT_DIR/config.
     @@ Documentation/git-config.txt: $GIT_DIR/config.worktree::
      +git command by using the `-c` option. See linkgit:git[1] for details.
      +
      +Options will be read from all of these files that are available. If the
     -+global or the system-wide configuration file are not available they will be
     -+ignored. If the repository configuration file is not available or readable,
     -+'git config' will exit with a non-zero error code. Note that neither case
     -+produces an error message.
     ++global or the system-wide configuration files are missing or unreadable they
     ++will be ignored. If the repository configuration file is missing or unreadable,
     ++'git config' will exit with a non-zero error code. An error message is produced
     ++if the file is unreadable, but not if it is missing.
       
       The files are read in the order given above, with last value found taking
       precedence over values read earlier.  When multiple values are taken then all
     @@ Documentation/git-config.txt: $GIT_DIR/config.worktree::
      +	$GIT_DIR/config.worktree
      +
      +command::
     -+	environment variables
     ++	GIT_CONFIG_{COUNT,KEY,VALUE} environment variables (see <<ENVIRONMENT>>
     ++	below)
      ++
      +the `-c` option
      +
     @@ Documentation/git-config.txt: $GIT_DIR/config.worktree::
      +defined in, but some options are only respected in certain scopes. See the
      +respective option's documentation for the full details.
       
     ++[[ENVIRONMENT]]
       ENVIRONMENT
       -----------
     + 
 2:  58f25612aa3 ! 2:  df8a1a78d53 Documentation: define protected configuration
     @@ Commit message
          - System, global and command line config are considered protected
            because an attacker who has control over any of those can do plenty of
            harm without Git, so we gain very little by ignoring those scopes.
     +
          - On the other hand, local (and similarly, worktree) config are not
            considered protected because it is relatively easy for an attacker to
            control local config, e.g.:
     +
            - On some shared user environments, a non-admin attacker can create a
              repository high up the directory hierarchy (e.g. C:\.git on
              Windows), and a user may accidentally use it when their PS1
     @@ Commit message
              the user intended to use the shared repository. It obviously
              shouldn't be read from the repository, because that would end up
              trusting the repository that Git was supposed to reject.
     +
            - "git upload-pack" is expected to run in repositories that may not be
              controlled by the user. We cannot ignore all config in that
              repository (because "git upload-pack" would fail), but we can limit
     @@ Documentation/git-config.txt: Most configuration options are respected regardles
      +substantial harm without using Git, so it is assumed that the user's environment
      +protects these scopes against attackers.
      +
     + [[ENVIRONMENT]]
       ENVIRONMENT
       -----------
     - 
 3:  3683d20f232 ! 3:  30ac73716cb config: learn `git_protected_config()`
     @@ Commit message
      
          `uploadpack.packObjectsHook` is the only 'protected configuration only'
          variable today, but we've noted that `safe.directory` and the upcoming
     -    `discovery.bare` should also be 'protected configuration only'. So, for
     -    consistency, we'd like to have a single implementation for protected
     +    `safe.bareRepository` should also be 'protected configuration only'. So,
     +    for consistency, we'd like to have a single implementation for protected
          configuration.
      
          The primary constraints are:
      
          1. Reading from protected configuration should be fast. Nearly all "git"
             commands inside a bare repository will read both `safe.directory` and
     -       `discovery.bare`, so we cannot afford to be slow.
     +       `safe.bareRepository`, so we cannot afford to be slow.
      
          2. Protected configuration must be readable when the gitdir is not
     -       known. `safe.directory` and `discovery.bare` both affect repository
     -       discovery and the gitdir is not known at that point [1].
     +       known. `safe.directory` and `safe.bareRepository` both affect
     +       repository discovery and the gitdir is not known at that point [1].
      
          The chosen implementation in this commit is to read protected
          configuration and cache the values in a global configset. This is
 4:  6394818ffd8 ! 4:  b3256d68f84 safe.directory: use git_protected_config()
     @@ Documentation/config/safe.txt: via `git config --add`. To reset the list of safe
       path relative to the home directory and `%(prefix)/<path>` expands to a
      
       ## setup.c ##
     -@@ setup.c: static int ensure_valid_ownership(const char *path)
     - 	    is_path_owned_by_current_user(path))
     - 		return 1;
     - 
     +@@ setup.c: static int ensure_valid_ownership(const char *gitfile,
     + 	 * constant regardless of what failed above. data.is_safe should be
     + 	 * initialized to false, and might be changed by the callback.
     + 	 */
      -	read_very_early_config(safe_directory_cb, &data);
      +	git_protected_config(safe_directory_cb, &data);
       
     @@ t/t0033-safe-directory.sh: test_expect_success 'safe.directory is not set' '
       
      -test_expect_success 'ignoring safe.directory on the command line' '
      -	test_must_fail git -c safe.directory="$(pwd)" status 2>err &&
     --	grep "unsafe repository" err
     +-	grep "dubious ownership" err
      +test_expect_success 'safe.directory on the command line' '
      +	git -c safe.directory="$(pwd)" status
       '
     @@ t/t0033-safe-directory.sh: test_expect_success 'safe.directory is not set' '
      -		GIT_CONFIG_KEY_0="safe.directory" \
      -		GIT_CONFIG_VALUE_0="$(pwd)" \
      -		git status 2>err &&
     --	grep "unsafe repository" err
     +-	grep "dubious ownership" err
      +test_expect_success 'safe.directory in the environment' '
      +	env GIT_CONFIG_COUNT=1 \
      +	    GIT_CONFIG_KEY_0="safe.directory" \
     @@ t/t0033-safe-directory.sh: test_expect_success 'safe.directory is not set' '
      -	test_must_fail env \
      -		GIT_CONFIG_PARAMETERS="${SQ}safe.directory${SQ}=${SQ}$(pwd)${SQ}" \
      -		git status 2>err &&
     --	grep "unsafe repository" err
     +-	grep "dubious ownership" err
      +test_expect_success 'safe.directory in GIT_CONFIG_PARAMETERS' '
      +	env GIT_CONFIG_PARAMETERS="${SQ}safe.directory${SQ}=${SQ}$(pwd)${SQ}" \
      +	    git status
 5:  eff4b07480e ! 5:  50069bba9a5 setup.c: create `discovery.bare`
     @@ Metadata
      Author: Glen Choo <chooglen@google.com>
      
       ## Commit message ##
     -    setup.c: create `discovery.bare`
     +    setup.c: create `safe.bareRepository`
      
          There is a known social engineering attack that takes advantage of the
          fact that a working tree can include an entire bare repository,
     @@ Commit message
          `--git-dir` or `GIT_DIR`. In environments that don't use bare
          repositories, this would be minimally disruptive.
      
     -    Create a config variable, `discovery.bare`, that tells Git whether or
     -    not to die() when it discovers a bare repository. This only affects
     -    repository discovery, thus it has no effect if discovery was not
     -    done, e.g. if the user passes `--git-dir=my-dir`, discovery will be
     -    skipped and my-dir will be used as the repo regardless of the
     -    `discovery.bare` value.
     +    Create a config variable, `safe.bareRepository`, that tells Git whether
     +    or not to die() when working with a bare repository. This config is an
     +    enum of:
      
     -    This config is an enum of:
     -
     -    - "always": always allow bare repositories (this is the default)
     -    - "never": never allow bare repositories
     +    - "all": allow all bare repositories (this is the default)
     +    - "explicit": only allow bare repositories specified via --git-dir
     +      or GIT_DIR.
      
          If we want to protect users from such attacks by default, neither value
     -    will suffice - "always" provides no protection, but "never" is
     +    will suffice - "all" provides no protection, but "explicit" is
          impractical for bare repository users. A more usable default would be to
          allow only non-embedded bare repositories ([2] contains one such
          proposal), but detecting if a repository is embedded is potentially
     @@ Commit message
      
          Signed-off-by: Glen Choo <chooglen@google.com>
      
     - ## Documentation/config.txt ##
     -@@ Documentation/config.txt: include::config/diff.txt[]
     - 
     - include::config/difftool.txt[]
     - 
     -+include::config/discovery.txt[]
     -+
     - include::config/extensions.txt[]
     - 
     - include::config/fastimport.txt[]
     -
     - ## Documentation/config/discovery.txt (new) ##
     + ## Documentation/config/safe.txt ##
      @@
     -+discovery.bare::
     -+	Specifies whether Git will work with a bare repository that
     -+	wasn't specified via the top-level `--git-dir` command-line
     -+	option, or the `GIT_DIR` environment variable (see
     -+	linkgit:git[1]). If the repository is specified, Git will always
     -+	use the specified repository, regardless of this value.
     ++safe.bareRepository::
     ++	Specifies which bare repositories Git will work with. The currently
     ++	supported values are:
     +++
     ++* `all`: Git works with all bare repositories. This is the default.
     ++* `explicit`: Git only works with bare repositories specified via
     ++  the top-level `--git-dir` command-line option, or the `GIT_DIR`
     ++  environment variable (see linkgit:git[1]).
     +++
     ++If you do not use bare repositories in your workflow, then it may be
     ++beneficial to set `safe.bareRepository` to `explicit` in your global
     ++config. This will protect you from attacks that involve cloning a
     ++repository that contains a bare repository and running a Git command
     ++within that directory.
      ++
      +This config setting is only respected in protected configuration (see
      +<<SCOPES>>). This prevents the untrusted repository from tampering with
      +this value.
     -++
     -+The currently supported values are:
     -++
     -+* `always`: Git always works with bare repositories
     -+* `never`: Git never works with bare repositories
     -++
     -+If you do not use bare repositories in your workflow, then it may be
     -+beneficial to set `discovery.bare` to `never` in your global config.
     -+This will protect you from attacks that involve cloning a repository
     -+that contains a bare repository and running a Git command within that
     -+directory.
     ++
     + safe.directory::
     + 	These config entries specify Git-tracked directories that are
     + 	considered safe even if they are owned by someone other than the
      
       ## setup.c ##
      @@
       static int inside_git_dir = -1;
       static int inside_work_tree = -1;
       static int work_tree_config_is_bogus;
     -+enum discovery_bare_allowed {
     -+	DISCOVERY_BARE_NEVER = 0,
     -+	DISCOVERY_BARE_ALWAYS,
     ++enum allowed_bare_repo {
     ++	ALLOWED_BARE_REPO_EXPLICIT = 0,
     ++	ALLOWED_BARE_REPO_ALL,
      +};
       
       static struct startup_info the_startup_info;
       struct startup_info *startup_info = &the_startup_info;
     -@@ setup.c: static int ensure_valid_ownership(const char *path)
     +@@ setup.c: static int ensure_valid_ownership(const char *gitfile,
       	return data.is_safe;
       }
       
     -+static int discovery_bare_cb(const char *key, const char *value, void *d)
     ++static int allowed_bare_repo_cb(const char *key, const char *value, void *d)
      +{
     -+	enum discovery_bare_allowed *discovery_bare_allowed = d;
     ++	enum allowed_bare_repo *allowed_bare_repo = d;
      +
     -+	if (strcmp(key, "discovery.bare"))
     ++	if (strcasecmp(key, "safe.bareRepository"))
      +		return 0;
      +
     -+	if (!strcmp(value, "never")) {
     -+		*discovery_bare_allowed = DISCOVERY_BARE_NEVER;
     ++	if (!strcmp(value, "explicit")) {
     ++		*allowed_bare_repo = ALLOWED_BARE_REPO_EXPLICIT;
      +		return 0;
      +	}
     -+	if (!strcmp(value, "always")) {
     -+		*discovery_bare_allowed = DISCOVERY_BARE_ALWAYS;
     ++	if (!strcmp(value, "all")) {
     ++		*allowed_bare_repo = ALLOWED_BARE_REPO_ALL;
      +		return 0;
      +	}
      +	return -1;
      +}
      +
     -+static enum discovery_bare_allowed get_discovery_bare(void)
     ++static enum allowed_bare_repo get_allowed_bare_repo(void)
      +{
     -+	enum discovery_bare_allowed result = DISCOVERY_BARE_ALWAYS;
     -+	git_protected_config(discovery_bare_cb, &result);
     ++	enum allowed_bare_repo result = ALLOWED_BARE_REPO_ALL;
     ++	git_protected_config(allowed_bare_repo_cb, &result);
      +	return result;
      +}
      +
     -+static const char *discovery_bare_allowed_to_string(
     -+	enum discovery_bare_allowed discovery_bare_allowed)
     ++static const char *allowed_bare_repo_to_string(
     ++	enum allowed_bare_repo allowed_bare_repo)
      +{
     -+	switch (discovery_bare_allowed) {
     -+	case DISCOVERY_BARE_NEVER:
     -+		return "never";
     -+	case DISCOVERY_BARE_ALWAYS:
     -+		return "always";
     ++	switch (allowed_bare_repo) {
     ++	case ALLOWED_BARE_REPO_EXPLICIT:
     ++		return "explicit";
     ++	case ALLOWED_BARE_REPO_ALL:
     ++		return "all";
      +	default:
     -+		BUG("invalid discovery_bare_allowed %d",
     -+		    discovery_bare_allowed);
     ++		BUG("invalid allowed_bare_repo %d",
     ++		    allowed_bare_repo);
      +	}
      +	return NULL;
      +}
     @@ setup.c: static enum discovery_result setup_git_directory_gently_1(struct strbuf
       		}
       
       		if (is_git_directory(dir->buf)) {
     -+			if (get_discovery_bare() == DISCOVERY_BARE_NEVER)
     ++			if (get_allowed_bare_repo() == ALLOWED_BARE_REPO_EXPLICIT)
      +				return GIT_DIR_DISALLOWED_BARE;
     - 			if (!ensure_valid_ownership(dir->buf))
     + 			if (!ensure_valid_ownership(NULL, NULL, dir->buf))
       				return GIT_DIR_INVALID_OWNERSHIP;
       			strbuf_addstr(gitdir, ".");
      @@ setup.c: const char *setup_git_directory_gently(int *nongit_ok)
     @@ setup.c: const char *setup_git_directory_gently(int *nongit_ok)
       		break;
      +	case GIT_DIR_DISALLOWED_BARE:
      +		if (!nongit_ok) {
     -+			die(_("cannot use bare repository '%s' (discovery.bare is '%s')"),
     ++			die(_("cannot use bare repository '%s' (safe.bareRepository is '%s')"),
      +			    dir.buf,
     -+			    discovery_bare_allowed_to_string(get_discovery_bare()));
     ++			    allowed_bare_repo_to_string(get_allowed_bare_repo()));
      +		}
      +		*nongit_ok = 1;
      +		break;
     @@ setup.c: const char *setup_git_directory_gently(int *nongit_ok)
       		/*
       		 * As a safeguard against setup_git_directory_gently_1 returning
      
     - ## t/t0035-discovery-bare.sh (new) ##
     + ## t/t0035-safe-bare-repository.sh (new) ##
      @@
      +#!/bin/sh
      +
     -+test_description='verify discovery.bare checks'
     ++test_description='verify safe.bareRepository checks'
      +
      +TEST_PASSES_SANITIZE_LEAK=true
      +. ./test-lib.sh
     @@ t/t0035-discovery-bare.sh (new)
      +	git init --bare outer-repo/bare-repo
      +'
      +
     -+test_expect_success 'discovery.bare unset' '
     ++test_expect_success 'safe.bareRepository unset' '
      +	expect_accepted -C outer-repo/bare-repo
      +'
      +
     -+test_expect_success 'discovery.bare=always' '
     -+	test_config_global discovery.bare always &&
     ++test_expect_success 'safe.bareRepository=all' '
     ++	test_config_global safe.bareRepository all &&
      +	expect_accepted -C outer-repo/bare-repo
      +'
      +
     -+test_expect_success 'discovery.bare=never' '
     -+	test_config_global discovery.bare never &&
     ++test_expect_success 'safe.bareRepository=explicit' '
     ++	test_config_global safe.bareRepository explicit &&
      +	expect_rejected -C outer-repo/bare-repo
      +'
      +
     -+test_expect_success 'discovery.bare in the repository' '
     -+	# discovery.bare must not be "never", otherwise git config fails
     -+	# with "fatal: not in a git directory" (like safe.directory)
     -+	test_config -C outer-repo/bare-repo discovery.bare always &&
     -+	test_config_global discovery.bare never &&
     ++test_expect_success 'safe.bareRepository in the repository' '
     ++	# safe.bareRepository must not be "explicit", otherwise
     ++	# git config fails with "fatal: not in a git directory" (like
     ++	# safe.directory)
     ++	test_config -C outer-repo/bare-repo safe.bareRepository \
     ++		all &&
     ++	test_config_global safe.bareRepository explicit &&
      +	expect_rejected -C outer-repo/bare-repo
      +'
      +
     -+test_expect_success 'discovery.bare on the command line' '
     -+	test_config_global discovery.bare never &&
     ++test_expect_success 'safe.bareRepository on the command line' '
     ++	test_config_global safe.bareRepository explicit &&
      +	expect_accepted -C outer-repo/bare-repo \
     -+		-c discovery.bare=always
     ++		-c safe.bareRepository=all
      +'
      +
      +test_done

-- 
gitgitgadget

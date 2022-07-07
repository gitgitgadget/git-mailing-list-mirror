Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6365BC433EF
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 23:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236820AbiGGXCD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 19:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236798AbiGGXCB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 19:02:01 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941B161D58
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 16:01:58 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id f2so22886831wrr.6
        for <git@vger.kernel.org>; Thu, 07 Jul 2022 16:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=A2PExFRrrjXuMXG3JddDorMqzyh0QAaPvh5r+5l6tWM=;
        b=Gw0pN/2epgS2xk20o8X+xltYWpWbiC2OLUIk1WsGEy5hjTdGj3kbgKsnNtTFKcRsnA
         9vz90wd2lq1rJ/Y4okQfRSlOU90X4iy1/goJhsEpZoQC6y4l4twgkWrB4ZHIG4/1NK9j
         qb6JyLPE2KY14AVHX3PpzRFK8j7EAQnyr04fTp4d26kSbrLGeeqTUvIYUTCEFVmQz36n
         01OiflD1WZX77Z/8Ux0vyoy/4SP+3AYPaw3YWgW9o8mKMsi1luTFF+2nDmkkgntfKSLT
         X2unekk3hYbDOyjHCdwxUPGNvyuzxlngX8D+xSSJV31BCJK00upx6YEWGBPl652oogHt
         olqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=A2PExFRrrjXuMXG3JddDorMqzyh0QAaPvh5r+5l6tWM=;
        b=m1LCRNw/MtanJYZiSfP7QuDzbAIQbzVdRvktPgw1RmGHThl1YSu33HNHIfUGqu+nHK
         UkAbocupiIF8PR48Xf1KRr/q2Dxum4Ey14fUnm2RX7Q4TfLapJIa9AlRqATY4Dq3yz08
         YNGKk2sK/jv5kjNsznw5dc9T8O5e8ShH1r+B+no8jEEbETl3OsCM1paDKVe4/h/I5xQi
         qNQr9+Wg6zgtd8kPo9o1zLZts+juFO/5pHlO+MuDrpLP5J0LudSUPXxOqqUJtR4sqOBD
         NZ+dzYzGEV1BdkVtbzx3pogp2asv97n+jT++OgS2SNQ13aPyT9KDWXH0G9/cpsjZ1yC7
         yIAw==
X-Gm-Message-State: AJIora/+JbAaQa1m3GBhGD9IRcld2MPNSHVBvheGXfULsesaUbOUjDm4
        FDuQpLWXfKPEo1C/RFQdY3TX7phk+0E=
X-Google-Smtp-Source: AGRyM1uXretO1QcfPm1csz7H1ZZwndvUss/HI9N1STtVKiGjr22kh0EpxCHnkGRMSYyCwxS0+TW9Og==
X-Received: by 2002:adf:f20e:0:b0:21d:8aa6:69da with SMTP id p14-20020adff20e000000b0021d8aa669damr263520wro.66.1657234916497;
        Thu, 07 Jul 2022 16:01:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v16-20020a5d4a50000000b0021d7d251c76sm5531447wrs.46.2022.07.07.16.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 16:01:55 -0700 (PDT)
Message-Id: <pull.1261.v7.git.git.1657234914.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com>
References: <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jul 2022 23:01:49 +0000
Subject: [PATCH v7 0/5] config: introduce discovery.bare and protected config
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

This version incorporates most of Taylor's comments and suggestions. Thanks
especially for the wording suggestions, I struggled with those a lot :)

(I believe) I've responded upthread with my intention for each comment. The
only differences between that and the actual changes are:

 * In Documentation/git-config.txt, I dropped a suggestion to mention that
   "git config --local" is identical to the default behavior when writing
   options because I found it too hard to fit in.

 * In Documentation/config/discovery.txt, I took Taylor's suggestion, but
   didn't mention "discovery" for the same reasons.

 * I decided to leave out the protected config lookup functions. I made some
   POC patches at:
   
   https://github.com/chooglen/git/compare/setup/disable-bare-repo-config...chooglen:git:config/protected-config-lookup-fns
   
   which show that the code ends up cleaner with the lookup functions (in
   particular, it lets us remove struct safe_directory_data, which we only
   needed to maintain the state of the config iteration). But, I ultimately
   decided to leave them out of this series because the safe.directory
   conversion is pretty noisy and might end up becoming a distraction from
   the discussion here. If there are no strong objections, I'll send them as
   a follow up series instead.

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
 Documentation/config/discovery.txt  | 21 ++++++++
 Documentation/config/safe.txt       |  6 +--
 Documentation/config/uploadpack.txt |  6 +--
 Documentation/git-config.txt        | 78 +++++++++++++++++++++++------
 config.c                            | 43 ++++++++++++++++
 config.h                            | 16 ++++++
 setup.c                             | 59 +++++++++++++++++++++-
 t/t0033-safe-directory.sh           | 24 ++++-----
 t/t0035-discovery-bare.sh           | 52 +++++++++++++++++++
 t/t5544-pack-objects-hook.sh        |  7 ++-
 upload-pack.c                       | 27 ++++++----
 12 files changed, 294 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/config/discovery.txt
 create mode 100755 t/t0035-discovery-bare.sh


base-commit: f770e9f396d48b567ef7b37d273e91ad570a3522
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1261%2Fchooglen%2Fsetup%2Fdisable-bare-repo-config-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1261/chooglen/setup/disable-bare-repo-config-v7
Pull-Request: https://github.com/git/git/pull/1261

Range-diff vs v6:

 1:  ee9619f6ec0 ! 1:  5c58db3bb21 Documentation/git-config.txt: add SCOPES section
     @@ Documentation/git-config.txt: $GIT_DIR/config.worktree::
      +Options will be read from all of these files that are available. If the
      +global or the system-wide configuration file are not available they will be
      +ignored. If the repository configuration file is not available or readable,
     -+'git config' will exit with a non-zero error code. However, in neither case
     -+will an error message be issued.
     ++'git config' will exit with a non-zero error code. Note that neither case
     ++produces an error message.
       
       The files are read in the order given above, with last value found taking
       precedence over values read earlier.  When multiple values are taken then all
     @@ Documentation/git-config.txt: $GIT_DIR/config.worktree::
      -You can override these rules using the `--global`, `--system`,
      -`--local`, `--worktree`, and `--file` command-line options; see
      -<<OPTIONS>> above.
     -+You can change the way options are read/written by specifying the path to a
     -+file (`--file`), or by specifying a configuration scope (`--system`,
     -+`--global`, `--local`, `--worktree`); see <<OPTIONS>> above.
     ++You can limit which configuration sources are read from or written to by
     ++specifying the path of a file with the `--file` option, or by specifying a
     ++configuration scope with `--system`, `--global`, `--local`, or `--worktree`.
     ++For more, see <<OPTIONS>> above.
      +
      +SCOPES
      +------
     @@ Documentation/git-config.txt: $GIT_DIR/config.worktree::
      +the `-c` option
      +
      +With the exception of 'command', each scope corresponds to a command line
     -+option - `--system`, `--global`, `--local`, `--worktree`.
     ++option: `--system`, `--global`, `--local`, `--worktree`.
      +
      +When reading options, specifying a scope will only read options from the
      +files within that scope. When writing options, specifying a scope will write
     @@ Documentation/git-config.txt: $GIT_DIR/config.worktree::
       
      +Most configuration options are respected regardless of the scope it is
      +defined in, but some options are only respected in certain scopes. See the
     -+option's documentation for the full details.
     ++respective option's documentation for the full details.
       
       ENVIRONMENT
       -----------
 2:  43627c05c0b ! 2:  58f25612aa3 Documentation: define protected configuration
     @@ Commit message
      
          In our documentation, define 'protected configuration' as the system,
          global and command config scopes. As a shorthand, I will refer to
     -    variables that are only respected in protected config as 'protected
     -    configuration only', but this term is not used in the documentation.
     +    variables that are only respected in protected configuration as
     +    'protected configuration only', but this term is not used in the
     +    documentation.
      
     -    This definition of protected config is based on whether or not Git can
     -    reasonably protect the user by ignoring the configuration scope:
     +    This definition of protected configuration is based on whether or not
     +    Git can reasonably protect the user by ignoring the configuration scope:
      
          - System, global and command line config are considered protected
            because an attacker who has control over any of those can do plenty of
     @@ Documentation/config/uploadpack.txt: uploadpack.packObjectsHook::
      -repository-level config (this is a safety measure against fetching from
      -untrusted repositories).
      +Note that this configuration variable is only respected when it is specified
     -+in protected config (see <<SCOPES>>). This is a safety measure against
     -+fetching from untrusted repositories.
     ++in protected configuration (see <<SCOPES>>). This is a safety measure
     ++against fetching from untrusted repositories.
       
       uploadpack.allowFilter::
       	If this option is set, `upload-pack` will support partial
      
       ## Documentation/git-config.txt ##
     -@@ Documentation/git-config.txt: You can change the way options are read/written by specifying the path to a
     - file (`--file`), or by specifying a configuration scope (`--system`,
     - `--global`, `--local`, `--worktree`); see <<OPTIONS>> above.
     +@@ Documentation/git-config.txt: specifying the path of a file with the `--file` option, or by specifying a
     + configuration scope with `--system`, `--global`, `--local`, or `--worktree`.
     + For more, see <<OPTIONS>> above.
       
      +[[SCOPES]]
       SCOPES
     @@ Documentation/git-config.txt: You can change the way options are read/written by
       
      @@ Documentation/git-config.txt: Most configuration options are respected regardless of the scope it is
       defined in, but some options are only respected in certain scopes. See the
     - option's documentation for the full details.
     + respective option's documentation for the full details.
       
      +Protected configuration
      +~~~~~~~~~~~~~~~~~~~~~~~
 3:  3efe282e6b9 ! 3:  3683d20f232 config: learn `git_protected_config()`
     @@ Commit message
          variable today, but we've noted that `safe.directory` and the upcoming
          `discovery.bare` should also be 'protected configuration only'. So, for
          consistency, we'd like to have a single implementation for protected
     -    config.
     +    configuration.
      
          The primary constraints are:
      
     -    1. Reading from protected configuration should be as fast as possible.
     -       Nearly all "git" commands inside a bare repository will read both
     -       `safe.directory` and `discovery.bare`, so we cannot afford to be
     -       slow.
     +    1. Reading from protected configuration should be fast. Nearly all "git"
     +       commands inside a bare repository will read both `safe.directory` and
     +       `discovery.bare`, so we cannot afford to be slow.
      
     -    2. Protected config must be readable when the gitdir is not known.
     -       `safe.directory` and `discovery.bare` both affect repository
     +    2. Protected configuration must be readable when the gitdir is not
     +       known. `safe.directory` and `discovery.bare` both affect repository
             discovery and the gitdir is not known at that point [1].
      
          The chosen implementation in this commit is to read protected
     @@ Commit message
          non-protected counterparts, e.g. git_protected_config_check_init() vs
          git_config_check_init().
      
     -    In light of constraint 1, this implementation can still be improved
     -    since git_protected_config() iterates through every variable in
     -    protected_config, which may still be too expensive. There exist constant
     -    time lookup functions for non-protected configuration
     -    (repo_config_get_*()), but for simplicity, this commit does not
     -    implement similar functions for protected configuration.
     +    In light of constraint 1, this implementation can still be improved.
     +    git_protected_config() iterates through every variable in
     +    protected_config, which is wasteful, but it makes the conversion simple
     +    because it matches existing patterns. We will likely implement constant
     +    time lookup functions for protected configuration in a future series
     +    (such functions already exist for non-protected configuration, i.e.
     +    repo_config_get_*()).
      
          An alternative that avoids introducing another configset is to continue
          to read all config using git_config(), but only accept values that have
     @@ config.c: static enum config_scope current_parsing_scope;
       static int zlib_compression_seen;
       
      +/*
     -+ * Config that comes from trusted sources, namely:
     -+ * - system config files (e.g. /etc/gitconfig)
     -+ * - global config files (e.g. $HOME/.gitconfig,
     -+ *   $XDG_CONFIG_HOME/git)
     -+ * - the command line.
     ++ * Config that comes from trusted scopes, namely:
     ++ * - CONFIG_SCOPE_SYSTEM (e.g. /etc/gitconfig)
     ++ * - CONFIG_SCOPE_GLOBAL (e.g. $HOME/.gitconfig, $XDG_CONFIG_HOME/git)
     ++ * - CONFIG_SCOPE_COMMAND (e.g. "-c" option, environment variables)
      + *
      + * This is declared here for code cleanliness, but unlike the other
      + * static variables, this does not hold config parser state.
     @@ config.c: int repo_config_get_pathname(struct repository *repo,
      +	free(user_config);
      +}
      +
     -+/* Ensure that protected_config has been initialized. */
     -+static void git_protected_config_check_init(void)
     -+{
     -+	if (protected_config.hash_initialized)
     -+		return;
     -+	read_protected_config();
     -+}
     -+
      +void git_protected_config(config_fn_t fn, void *data)
      +{
     -+	git_protected_config_check_init();
     ++	if (!protected_config.hash_initialized)
     ++		read_protected_config();
      +	configset_iter(&protected_config, fn, data);
      +}
      +
     @@ config.h: int repo_config_get_maybe_bool(struct repository *repo,
       
      +/*
      + * Functions for reading protected config. By definition, protected
     -+ * config ignores repository config, so it is unnecessary to read
     -+ * protected config from any `struct repository` other than
     -+ * the_repository.
     ++ * config ignores repository config, so these do not take a `struct
     ++ * repository` parameter.
      + */
      +void git_protected_config(config_fn_t fn, void *data);
      +
 4:  ec925823414 = 4:  6394818ffd8 safe.directory: use git_protected_config()
 5:  a1323d963f9 ! 5:  eff4b07480e setup.c: create `discovery.bare`
     @@ Documentation/config.txt: include::config/diff.txt[]
       ## Documentation/config/discovery.txt (new) ##
      @@
      +discovery.bare::
     -+	Specifies whether Git will work with a bare repository that it
     -+	found during repository discovery. If the repository is
     -+	specified directly via the --git-dir command-line option or the
     -+	GIT_DIR environment variable (see linkgit:git[1]), Git will
     -+	always use the specified repository, regardless of this value.
     ++	Specifies whether Git will work with a bare repository that
     ++	wasn't specified via the top-level `--git-dir` command-line
     ++	option, or the `GIT_DIR` environment variable (see
     ++	linkgit:git[1]). If the repository is specified, Git will always
     ++	use the specified repository, regardless of this value.
      ++
      +This config setting is only respected in protected configuration (see
      +<<SCOPES>>). This prevents the untrusted repository from tampering with
     @@ Documentation/config/discovery.txt (new)
      +* `always`: Git always works with bare repositories
      +* `never`: Git never works with bare repositories
      ++
     -+This defaults to `always`, but this default may change in the future.
     -++
      +If you do not use bare repositories in your workflow, then it may be
      +beneficial to set `discovery.bare` to `never` in your global config.
      +This will protect you from attacks that involve cloning a repository
     @@ setup.c: static enum discovery_result setup_git_directory_gently_1(struct strbuf
       		}
       
       		if (is_git_directory(dir->buf)) {
     -+			if (!get_discovery_bare())
     ++			if (get_discovery_bare() == DISCOVERY_BARE_NEVER)
      +				return GIT_DIR_DISALLOWED_BARE;
       			if (!ensure_valid_ownership(dir->buf))
       				return GIT_DIR_INVALID_OWNERSHIP;

-- 
gitgitgadget

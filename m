Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8A1CCA47F
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 00:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386780AbiFHAaD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 20:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1451290AbiFGXM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 19:12:29 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C483A0E50
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 13:57:17 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id m26so14303333wrb.4
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 13:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=p9Dit82ve9bNZzQVvBGAhA/vK5QGikDWf2lpcpscY20=;
        b=kYE6h1dRIbTZkKVEFv4zZxj7/EPF8IqKtYlOFpy0G6MGxVkJ7gzj/D0WNdI8eAdRKU
         igSZl8Xs7Epo1cTX4ozQUtpMWcex593WtwDxjcq8c+5s+ApfCiothiTBALdAg/isGLdU
         vfUVyWZShw6f3EueAsvqfSoQHSFm/WqC27ps9V88Nb5YoGM5mzCpkJ1atoVHGzPxOmlO
         YcgN8NbqW2UeG3QfGSZf6oOwQOD7sz2lrE1DDO28dgfdY4HFqNFXP32X2Imc0KbjvtF8
         LbvQRD24Z1XTwKUmLr0sIl8LtkEm6S8GIxNMXqUREE7Wv+CtLNb2p5iPmnvJOB/GwhyP
         2P5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=p9Dit82ve9bNZzQVvBGAhA/vK5QGikDWf2lpcpscY20=;
        b=10HbqJ5972YHcRPLGK76Gryg4ILIt9PbL1wBliqPOzR4zZ9iEnmUdIecK+rXgRRj0v
         kObEHfA9K/oN1EiL9P5ZaN+sCC/KA1SPPG/JiNWh5b6da37ibdGcunDrLjJqO7mS7gg8
         wpE/roidXUEyM2NCgssUScAKHOlq23dheOCeW8d6lqSTqEjcR6VWduJzqlIE35MBcNaL
         jRNOn7bKU2/d6WRe57DxcJ5EorPr+Xj7eKuEPYfcUfZh0kflIj+56lQK9ROwuuVGBoCu
         uoyrsIYKIAx51Cf0FBgyLgB9fAyyzBjbyV5J0tSh0ugwTZj9AQBAp2R+KNUk/oGcjT9v
         PmjA==
X-Gm-Message-State: AOAM530gE0nypQ7zkWrS3SjpHzKQ7A2nJG5ny4TkFE23vyzUWPoP/2UC
        c4/Ncuia86Z47/ZiCCFUV2kBsjuMcoLAI20d
X-Google-Smtp-Source: ABdhPJwpAt7Mb9ifg475wFWlcShz46WMyxY4RVBqXkIRPrBT/zjQ6KMmYDVJhtGLSAvIH8Ad/dqglQ==
X-Received: by 2002:a05:6000:188b:b0:218:5d79:dc6e with SMTP id a11-20020a056000188b00b002185d79dc6emr674990wri.183.1654635433825;
        Tue, 07 Jun 2022 13:57:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l19-20020a1ced13000000b0039c1396b495sm21357751wmh.9.2022.06.07.13.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 13:57:13 -0700 (PDT)
Message-Id: <pull.1261.v4.git.git.1654635432.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.v3.git.git.1653685761.gitgitgadget@gmail.com>
References: <pull.1261.v3.git.git.1653685761.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jun 2022 20:57:07 +0000
Subject: [PATCH v4 0/5] config: introduce discovery.bare and protected config
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
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks again for the kind feedback, everyone :)

The motivation has remained the same as the last round; you can find it in
the "Description" section in the previous cover letter [1].

This round doesn't introduce any major code changes. The most notable
changes are:

 * I've reorganized the patches so that protected config includes "-c" from
   the beginning (3/5) (instead of trying to avoid changing safe.directory).
   As a result, uploadpack.packObjectsHook becomes the first 'protected
   config only' variable instead of safe.directory.
   
   Since we start the conversion with uploadpack.packObjectHook, I was
   curious whether we might be able to reuse its approach of "reading the
   full set of config, but checking the scope of each value", which might be
   nice because we could reuse the cache in the_repository->config instead
   of creating an entirely new configset. I didn't pursue it further, but
   I've noted this alternative in 3/5's commit message.

 * 'Protected configuration' is now defined as a set of configuration scopes
   (2/5). This follows a suggestion from Junio [2], which I thought read
   very clearly. We haven't done a great job at describing 'scopes' in
   Documentation/git-config.txt though, so I tried to remedy that by
   cleaning up a little and adding a SCOPES section (1/5).
   
   Frankly, I'm not very happy with the end result - it's not nearly as
   clear as I had hoped, and I think I might be introducing some confusion
   between the words "config" and "scope". I'd appreciate any feedback that
   helps us get to a good final wording.

 * I added a test for "git config --show-scope" and the 'worktree' scope,
   since 'worktree' wasn't listed in Documentation/git-config.txt (6/5).

= Patch organization

 * Patch 1 add a section on config scopes to our docs
 * Patches 2-3 define 'protected config' and create a shared implementation.
 * Patch 4 refactors safe.directory to use protected config
 * Patch 5 adds discovery.bare

= Series history

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

 * This series does not implement the "no-embedded" option [3] and I won't
   work on it any time soon, but I'd be more than happy to review if someone
   sends patches.
 * With discovery.bare, if a builtin is marked RUN_SETUP_GENTLY, setup.c
   doesn't die() and we don't tell users why their repository was rejected,
   e.g. "git config" gives an opaque "fatal: not in a git directory". This
   isn't a new problem though, since safe.directory has the same issue.

[1]
https://lore.kernel.org/git/pull.1261.v3.git.git.1653685761.gitgitgadget@gmail.com
[2] https://lore.kernel.org/git/xmqqh75a1rmd.fsf@gitster.g [3] This was
first suggested in
https://lore.kernel.org/git/5b969c5e-e802-c447-ad25-6acc0b784582@github.com

Glen Choo (5):
  Documentation/git-config.txt: add SCOPES section
  Documentation: define protected configuration
  config: read protected config with `git_protected_config()`
  safe.directory: use git_protected_config()
  setup.c: create `discovery.bare`

 Documentation/config.txt            |  2 +
 Documentation/config/discovery.txt  | 19 +++++++
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
 12 files changed, 316 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/config/discovery.txt
 create mode 100755 t/t0035-discovery-bare.sh


base-commit: f9b95943b68b6b8ca5a6072f50a08411c6449b55
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1261%2Fchooglen%2Fsetup%2Fdisable-bare-repo-config-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1261/chooglen/setup/disable-bare-repo-config-v4
Pull-Request: https://github.com/git/git/pull/1261

Range-diff vs v3:

 1:  575676c760d < -:  ----------- Documentation: define protected configuration
 -:  ----------- > 1:  c0e27ab3b3e Documentation/git-config.txt: add SCOPES section
 5:  e25d5907cd1 ! 2:  a5a1dcb03e1 upload-pack: make uploadpack.packObjectsHook protected
     @@ Metadata
      Author: Glen Choo <chooglen@google.com>
      
       ## Commit message ##
     -    upload-pack: make uploadpack.packObjectsHook protected
     +    Documentation: define protected configuration
      
     -    Now that protected config includes "-c", "uploadpack.packObjectsHook"
     -    behaves identically to a 'Protected config only' variable. Refactor it
     -    to use git_protected_config() and mark it 'Protected config only'.
     +    For security reasons, there are config variables that are only trusted
     +    when they are specified in extra-trustworthy configuration scopes, which
     +    are sometimes referred to on-list as 'protected configuration' [1]. A
     +    future commit will introduce another such variable, so let's define our
     +    terms so that we can have consistent documentation and implementation.
     +
     +    In our documentation, define 'protected config' as the system, global
     +    and command config scopes. As a shorthand, I will refer to variables
     +    that are only respected in protected config as 'protected config only',
     +    but this term is not used in the documentation.
     +
     +    This definition of protected configuration is based on whether or not
     +    Git can reasonably protect the user by ignoring the configuration scope:
     +
     +    - System, global and command line config are considered protected
     +      because an attacker who has control over any of those can do plenty of
     +      harm without Git, so we gain very little by ignoring those scopes.
     +    - On the other hand, local (and similarly, worktree) config are not
     +      considered protected because it is relatively easy for an attacker to
     +      control local config, e.g.:
     +      - On some shared user environments, a non-admin attacker can create a
     +        repository high up the directory hierarchy (e.g. C:\.git on Windows),
     +        and a user may accidentally use it when their PS1 automatically
     +        invokes "git" commands.
     +
     +        `safe.directory` prevents attacks of this form by making sure that
     +        the user intended to use the shared repository. It obviously
     +        shouldn't be read from the repository, because that would end up
     +        trusting the repository that Git was supposed to reject.
     +      - "git upload-pack" is expected to run in repositories that may not be
     +        controlled by the user. We cannot ignore all config in that
     +        repository (because "git upload-pack" would fail), but we can limit
     +        the risks by ignoring `uploadpack.packObjectsHook`.
     +
     +    Only `uploadpack.packObjectsHook` is 'protected config only'. The
     +    following variables are intentionally excluded:
     +
     +    - `safe.directory` should be 'protected config only', but it does not
     +      technically fit the definition because it is not respected in the
     +      "command" scope. A future commit will fix this.
     +
     +    - `trace2.*` happens to read the same scopes as `safe.directory` because
     +      they share an implementation. However, this is not for security
     +      reasons; it is because we want to start tracing so early that
     +      repository-level config and "-c" are not available [2].
     +
     +      This requirement is unique to `trace2.*`, so it does not makes sense
     +      for protected configuration to be subject to the same constraints.
     +
     +    [1] For example,
     +    https://lore.kernel.org/git/6af83767-576b-75c4-c778-0284344a8fe7@github.com/
     +    [2] https://lore.kernel.org/git/a0c89d0d-669e-bf56-25d2-cbb09b012e70@jeffhostetler.com/
      
          Signed-off-by: Glen Choo <chooglen@google.com>
      
       ## Documentation/config/uploadpack.txt ##
     -@@ Documentation/config/uploadpack.txt: uploadpack.keepAlive::
     - 	disables keepalive packets entirely. The default is 5 seconds.
     - 
     - uploadpack.packObjectsHook::
     --	If this option is set, when `upload-pack` would run
     --	`git pack-objects` to create a packfile for a client, it will
     --	run this shell command instead.  The `pack-objects` command and
     --	arguments it _would_ have run (including the `git pack-objects`
     --	at the beginning) are appended to the shell command. The stdin
     --	and stdout of the hook are treated as if `pack-objects` itself
     --	was run. I.e., `upload-pack` will feed input intended for
     --	`pack-objects` to the hook, and expects a completed packfile on
     --	stdout.
     --+
     +@@ Documentation/config/uploadpack.txt: uploadpack.packObjectsHook::
     + 	`pack-objects` to the hook, and expects a completed packfile on
     + 	stdout.
     + +
      -Note that this configuration variable is ignored if it is seen in the
      -repository-level config (this is a safety measure against fetching from
      -untrusted repositories).
     -+	'(Protected config only)' If this option is set, when
     -+	`upload-pack` would run `git pack-objects` to create a packfile
     -+	for a client, it will run this shell command instead. The
     -+	`pack-objects` command and arguments it _would_ have run
     -+	(including the `git pack-objects` at the beginning) are appended
     -+	to the shell command. The stdin and stdout of the hook are
     -+	treated as if `pack-objects` itself was run. I.e., `upload-pack`
     -+	will feed input intended for `pack-objects` to the hook, and
     -+	expects a completed packfile on stdout.
     ++Note that this configuration variable is only respected when it is specified
     ++in protected config (see <<SCOPES>>). This is a safety measure against
     ++fetching from untrusted repositories.
       
       uploadpack.allowFilter::
       	If this option is set, `upload-pack` will support partial
      
     - ## upload-pack.c ##
     -@@ upload-pack.c: static int upload_pack_config(const char *var, const char *value, void *cb_data)
     - 		data->advertise_sid = git_config_bool(var, value);
     - 	}
     + ## Documentation/git-config.txt ##
     +@@ Documentation/git-config.txt: You can change the way options are read/written by specifying the path to a
     + file (`--file`), or by specifying a configuration scope (`--system`,
     + `--global`, `--local`, `--worktree`); see <<OPTIONS>> above.
       
     --	if (current_config_scope() != CONFIG_SCOPE_LOCAL &&
     --	    current_config_scope() != CONFIG_SCOPE_WORKTREE) {
     --		if (!strcmp("uploadpack.packobjectshook", var))
     --			return git_config_string(&data->pack_objects_hook, var, value);
     --	}
     --
     - 	if (parse_object_filter_config(var, value, data) < 0)
     - 		return -1;
     ++[[SCOPES]]
     + SCOPES
     + ------
       
     - 	return parse_hide_refs_config(var, value, "uploadpack");
     - }
     +@@ Documentation/git-config.txt: Most configuration options are respected regardless of the scope it is
     + defined in, but some options are only respected in certain scopes. See the
     + option's documentation for the full details.
       
     -+static int upload_pack_protected_config(const char *var, const char *value, void *cb_data)
     -+{
     -+	struct upload_pack_data *data = cb_data;
     ++Protected config
     ++~~~~~~~~~~~~~~~~
      +
     -+	if (!strcmp("uploadpack.packobjectshook", var))
     -+		return git_config_string(&data->pack_objects_hook, var, value);
     -+	return 0;
     -+}
     ++Protected config refers to the 'system', 'global', and 'command' scopes. Git
     ++considers these scopes to be especially trustworthy because they are likely
     ++to be controlled by the user or a trusted administrator. An attacker who
     ++controls these scopes can do substantial harm without using Git, so it is
     ++assumed that the user's environment protects these scopes against attackers.
      +
     - void upload_pack(const int advertise_refs, const int stateless_rpc,
     - 		 const int timeout)
     - {
     -@@ upload-pack.c: void upload_pack(const int advertise_refs, const int stateless_rpc,
     - 	upload_pack_data_init(&data);
     - 
     - 	git_config(upload_pack_config, &data);
     -+	git_protected_config(upload_pack_protected_config, &data);
     - 
     - 	data.stateless_rpc = stateless_rpc;
     - 	data.timeout = timeout;
     -@@ upload-pack.c: int upload_pack_v2(struct repository *r, struct packet_reader *request)
     - 	data.use_sideband = LARGE_PACKET_MAX;
     - 
     - 	git_config(upload_pack_config, &data);
     -+	git_protected_config(upload_pack_protected_config, &data);
     ++For security reasons, certain options are only respected when they are
     ++specified in protected config, and ignored otherwise.
     ++
     + ENVIRONMENT
     + -----------
       
     - 	while (state != FETCH_DONE) {
     - 		switch (state) {
 2:  7499a280961 ! 3:  94b40907e66 config: read protected config with `git_protected_config()`
     @@ Metadata
       ## Commit message ##
          config: read protected config with `git_protected_config()`
      
     -    Protected config is read using `read_very_early_config()`, which has
     -    several downsides:
     -
     -    - Every call to `read_very_early_config()` parses global and
     -      system-level config files anew, but this can be optimized by just
     -      parsing them once [1].
     -    - Protected variables should respect "-c" because we can reasonably
     -      assume that it comes from the user. But, `read_very_early_config()`
     -      can't use "-c" because it is called so early that it does not have
     -      access to command line arguments.
     -
     -    Introduce `git_protected_config()`, which reads protected config and
     -    caches the values in `the_repository.protected_config`. Then, refactor
     -    `safe.directory` to use `git_protected_config()`.
     -
     -    This implementation can still be improved, however:
     -
     -    - `git_protected_config()` iterates through every variable in
     -      `the_repository.protected_config`, which may still be too expensive to
     -      be called in every "git" invocation. There exist constant time lookup
     -      functions for non-protected config (repo_config_get_*()), but for
     -      simplicity, this commit does not implement similar functions for
     -      protected config.
     -
     -    - Protected config is stored in `the_repository` so that we don't need
     -      to statically allocate it. But this might be confusing since protected
     -      config ignores repository config by definition.
     -
     -    [1] While `git_protected_config()` should save on file I/O, I wasn't
     -    able to measure a meaningful difference between that and
     -    `read_very_early_config()` on my machine (which has an SSD).
     +    `uploadpack.packObjectsHook` is the only 'protected config only'
     +    variable today, but we've noted that `safe.directory` and the upcoming
     +    `discovery.bare` should also be 'protected config only'. So, for
     +    consistency, we'd like to have a single implementation for protected
     +    config.
     +
     +    The primary constraints are:
     +
     +    1. Reading from protected config should be as fast as possible. Nearly
     +       all "git" commands inside a bare repository will read both
     +       `safe.directory` and `discovery.bare`, so we cannot afford to be
     +       slow.
     +
     +    2. Protected config must be readable when the gitdir is not known.
     +       `safe.directory` and `discovery.bare` both affect repository
     +       discovery and the gitdir is not known at that point [1].
     +
     +    The chosen implementation in this commit is to read protected config and
     +    cache the values in a global configset. This is similar to the caching
     +    behavior we get with the_repository->config.
     +
     +    Introduce git_protected_config(), which reads protected config and
     +    caches them in the global configset protected_config. Then, refactor
     +    `uploadpack.packObjectsHook` to use git_protected_config().
     +
     +    The protected config functions are named similarly to their
     +    non-protected counterparts, e.g. git_protected_config_check_init() vs
     +    git_config_check_init().
     +
     +    In light of constraint 1, this implementation can still be improved
     +    since git_protected_config() iterates through every variable in
     +    protected_config, which may still be too expensive. There exist constant
     +    time lookup functions for non-protected config (repo_config_get_*()),
     +    but for simplicity, this commit does not implement similar functions for
     +    protected config.
     +
     +    An alternative that avoids introducing another configset is to continue
     +    to read all config using git_config(), but only accept values that have
     +    the correct config scope [2]. This technically fulfills constraint 2,
     +    because git_config() simply ignores the local and worktree config when
     +    the gitdir is not known. However, this would read incomplete config into
     +    the_repository->config, which would need to be reset when the gitdir is
     +    known and git_config() needs to read the local and worktree config.
     +    Resetting the_repository->config might be reasonable while we only have
     +    these 'protected config only' variables, but it's not clear whether this
     +    extends well to future variables.
     +
     +    [1] In this case, we do have a candidate gitdir though, so with a little
     +    refactoring, it might be possible to provide a gitdir.
     +    [2] This is how `uploadpack.packObjectsHook` was implemented prior to
     +    this commit.
      
          Signed-off-by: Glen Choo <chooglen@google.com>
      
       ## config.c ##
     +@@ config.c: static enum config_scope current_parsing_scope;
     + static int pack_compression_seen;
     + static int zlib_compression_seen;
     + 
     ++/*
     ++ * Config that comes from trusted sources, namely:
     ++ * - system config files (e.g. /etc/gitconfig)
     ++ * - global config files (e.g. $HOME/.gitconfig,
     ++ *   $XDG_CONFIG_HOME/git)
     ++ * - the command line.
     ++ *
     ++ * This is declared here for code cleanliness, but unlike the other
     ++ * static variables, this does not hold config parser state.
     ++ */
     ++static struct config_set protected_config;
     ++
     + static int config_file_fgetc(struct config_source *conf)
     + {
     + 	return getc_unlocked(conf->u.file);
     +@@ config.c: int git_configset_add_file(struct config_set *cs, const char *filename)
     + 	return git_config_from_file(config_set_callback, filename, cs);
     + }
     + 
     ++int git_configset_add_parameters(struct config_set *cs)
     ++{
     ++	return git_config_from_parameters(config_set_callback, cs);
     ++}
     ++
     + int git_configset_get_value(struct config_set *cs, const char *key, const char **value)
     + {
     + 	const struct string_list *values = NULL;
      @@ config.c: int repo_config_get_pathname(struct repository *repo,
       	return ret;
       }
       
     -+/* Read protected config into the_repository->protected_config. */
     ++/* Read values into protected_config. */
      +static void read_protected_config(void)
      +{
      +	char *xdg_config = NULL, *user_config = NULL, *system_config = NULL;
      +
     -+	CALLOC_ARRAY(the_repository->protected_config, 1);
     -+	git_configset_init(the_repository->protected_config);
     ++	git_configset_init(&protected_config);
      +
      +	system_config = git_system_config();
      +	git_global_config(&user_config, &xdg_config);
      +
     -+	git_configset_add_file(the_repository->protected_config, system_config);
     -+	git_configset_add_file(the_repository->protected_config, xdg_config);
     -+	git_configset_add_file(the_repository->protected_config, user_config);
     ++	git_configset_add_file(&protected_config, system_config);
     ++	git_configset_add_file(&protected_config, xdg_config);
     ++	git_configset_add_file(&protected_config, user_config);
     ++	git_configset_add_parameters(&protected_config);
      +
      +	free(system_config);
      +	free(xdg_config);
      +	free(user_config);
      +}
      +
     -+/* Ensure that the_repository->protected_config has been initialized. */
     ++/* Ensure that protected_config has been initialized. */
      +static void git_protected_config_check_init(void)
      +{
     -+	if (the_repository->protected_config &&
     -+	    the_repository->protected_config->hash_initialized)
     ++	if (protected_config.hash_initialized)
      +		return;
      +	read_protected_config();
      +}
     @@ config.c: int repo_config_get_pathname(struct repository *repo,
      +void git_protected_config(config_fn_t fn, void *data)
      +{
      +	git_protected_config_check_init();
     -+	configset_iter(the_repository->protected_config, fn, data);
     ++	configset_iter(&protected_config, fn, data);
      +}
      +
       /* Functions used historically to read configuration from 'the_repository' */
     @@ config.c: int repo_config_get_pathname(struct repository *repo,
       {
      
       ## config.h ##
     +@@ config.h: void git_configset_init(struct config_set *cs);
     +  */
     + int git_configset_add_file(struct config_set *cs, const char *filename);
     + 
     ++/**
     ++ * Parses command line options and environment variables, and adds the
     ++ * variable-value pairs to the `config_set`. Returns 0 on success, or -1
     ++ * if there is an error in parsing. The caller decides whether to free
     ++ * the incomplete configset or continue using it when the function
     ++ * returns -1.
     ++ */
     ++int git_configset_add_parameters(struct config_set *cs);
     ++
     + /**
     +  * Finds and returns the value list, sorted in order of increasing priority
     +  * for the configuration variable `key` and config set `cs`. When the
      @@ config.h: int repo_config_get_maybe_bool(struct repository *repo,
       int repo_config_get_pathname(struct repository *repo,
       			     const char *key, const char **dest);
     @@ config.h: int repo_config_get_maybe_bool(struct repository *repo,
        * Querying For Specific Variables
        * -------------------------------
      
     - ## repository.c ##
     -@@ repository.c: void repo_clear(struct repository *repo)
     - 		FREE_AND_NULL(repo->remote_state);
     - 	}
     - 
     -+	if (repo->protected_config) {
     -+		git_configset_clear(repo->protected_config);
     -+		FREE_AND_NULL(repo->protected_config);
     -+	}
     + ## t/t5544-pack-objects-hook.sh ##
     +@@ t/t5544-pack-objects-hook.sh: test_expect_success 'hook does not run from repo config' '
     + 	! grep "hook running" stderr &&
     + 	test_path_is_missing .git/hook.args &&
     + 	test_path_is_missing .git/hook.stdin &&
     +-	test_path_is_missing .git/hook.stdout
     ++	test_path_is_missing .git/hook.stdout &&
      +
     - 	repo_clear_path_cache(&repo->cached_paths);
     - }
     ++	# check that global config is used instead
     ++	test_config_global uploadpack.packObjectsHook ./hook &&
     ++	git clone --no-local . dst2.git 2>stderr &&
     ++	grep "hook running" stderr
     + '
       
     + test_expect_success 'hook works with partial clone' '
      
     - ## repository.h ##
     -@@ repository.h: struct repository {
     + ## upload-pack.c ##
     +@@ upload-pack.c: static int upload_pack_config(const char *var, const char *value, void *cb_data)
     + 		data->advertise_sid = git_config_bool(var, value);
     + 	}
       
     - 	struct repo_settings settings;
     +-	if (current_config_scope() != CONFIG_SCOPE_LOCAL &&
     +-	    current_config_scope() != CONFIG_SCOPE_WORKTREE) {
     +-		if (!strcmp("uploadpack.packobjectshook", var))
     +-			return git_config_string(&data->pack_objects_hook, var, value);
     +-	}
     +-
     + 	if (parse_object_filter_config(var, value, data) < 0)
     + 		return -1;
     + 
     + 	return parse_hide_refs_config(var, value, "uploadpack");
     + }
       
     -+	/*
     -+	 * Config that comes from trusted sources, namely
     -+	 * - system config files (e.g. /etc/gitconfig)
     -+	 * - global config files (e.g. $HOME/.gitconfig,
     -+	 *   $XDG_CONFIG_HOME/git)
     -+	 */
     -+	struct config_set *protected_config;
     ++static int upload_pack_protected_config(const char *var, const char *value, void *cb_data)
     ++{
     ++	struct upload_pack_data *data = cb_data;
     ++
     ++	if (!strcmp("uploadpack.packobjectshook", var))
     ++		return git_config_string(&data->pack_objects_hook, var, value);
     ++	return 0;
     ++}
     ++
     ++static void get_upload_pack_config(struct upload_pack_data *data)
     ++{
     ++	git_config(upload_pack_config, data);
     ++	git_protected_config(upload_pack_protected_config, data);
     ++}
      +
     - 	/* Subsystems */
     - 	/*
     - 	 * Repository's config which contains key-value pairs from the usual
     -
     - ## setup.c ##
     -@@ setup.c: static int ensure_valid_ownership(const char *path)
     - 	    is_path_owned_by_current_user(path))
     - 		return 1;
     + void upload_pack(const int advertise_refs, const int stateless_rpc,
     + 		 const int timeout)
     + {
     +@@ upload-pack.c: void upload_pack(const int advertise_refs, const int stateless_rpc,
     + 	struct upload_pack_data data;
       
     --	read_very_early_config(safe_directory_cb, &data);
     -+	git_protected_config(safe_directory_cb, &data);
     + 	upload_pack_data_init(&data);
     +-
     +-	git_config(upload_pack_config, &data);
     ++	get_upload_pack_config(&data);
       
     - 	return data.is_safe;
     - }
     + 	data.stateless_rpc = stateless_rpc;
     + 	data.timeout = timeout;
     +@@ upload-pack.c: int upload_pack_v2(struct repository *r, struct packet_reader *request)
     + 
     + 	upload_pack_data_init(&data);
     + 	data.use_sideband = LARGE_PACKET_MAX;
     +-
     +-	git_config(upload_pack_config, &data);
     ++	get_upload_pack_config(&data);
     + 
     + 	while (state != FETCH_DONE) {
     + 		switch (state) {
 4:  66a0a208176 ! 4:  156817966fa config: include "-c" in protected config
     @@ Metadata
      Author: Glen Choo <chooglen@google.com>
      
       ## Commit message ##
     -    config: include "-c" in protected config
     +    safe.directory: use git_protected_config()
      
     -    Protected config should include the command line (aka "-c") because we
     -    can be quite certain that this config is specified by the user.
     -
     -    Introduce a function, `git_configset_add_parameters()`, that adds "-c"
     -    config to a config_set, and use it to add "-c" to protected config.
     +    Use git_protected_config() to read `safe.directory` instead of
     +    read_very_early_config(), making it 'protected config only'. As a
     +    result, `safe.directory` now respects "-c", so update the tests and docs
     +    accordingly.
      
          Signed-off-by: Glen Choo <chooglen@google.com>
      
     - ## Documentation/config.txt ##
     -@@ Documentation/config.txt: names do not conflict with those that are used by Git itself and
     - other popular tools, and describe them in your documentation.
     - 
     - Variables marked with '(Protected config only)' are only respected when
     --they are specified in protected configuration. This includes global and
     --system-level config, and excludes repository config, the command line
     --option `-c`, and environment variables. For more details, see the
     -+they are specified in protected configuration. This includes global,
     -+system-level config, the command line option `-c`, and environment
     -+variables, and excludes repository config. For more details, see the
     - 'protected configuration' entry in linkgit:gitglossary[7].
     - 
     - include::config/advice.txt[]
     -
     - ## Documentation/glossary-content.txt ##
     -@@ Documentation/glossary-content.txt: Protected configuration includes:
     - - system-level config, e.g. `/etc/git/config`
     - - global config, e.g. `$XDG_CONFIG_HOME/git/config` and
     -   `$HOME/.gitconfig`
     -+- the command line option `-c` and its equivalent environment variables
     + ## Documentation/config/safe.txt ##
     +@@ Documentation/config/safe.txt: via `git config --add`. To reset the list of safe directories (e.g. to
     + override any such directories specified in the system config), add a
     + `safe.directory` entry with an empty value.
       +
     - Protected configuration excludes:
     +-This config setting is only respected when specified in a system or global
     +-config, not when it is specified in a repository config, via the command
     +-line option `-c safe.directory=<path>`, or in environment variables.
     ++This config setting is only respected in protected configuration (see
     ++<<SCOPES>>). This prevents the untrusted repository from tampering with this
     ++value.
       +
     - - repository config, e.g. `$GIT_DIR/config` and
     -   `$GIT_DIR/config.worktree`
     --- the command line option `-c` and its equivalent environment variables
     - 
     - [[def_reachable]]reachable::
     - 	All of the ancestors of a given <<def_commit,commit>> are said to be
     + The value of this setting is interpolated, i.e. `~/<path>` expands to a
     + path relative to the home directory and `%(prefix)/<path>` expands to a
      
     - ## config.c ##
     -@@ config.c: int git_configset_add_file(struct config_set *cs, const char *filename)
     - 	return git_config_from_file(config_set_callback, filename, cs);
     - }
     + ## setup.c ##
     +@@ setup.c: static int ensure_valid_ownership(const char *path)
     + 	    is_path_owned_by_current_user(path))
     + 		return 1;
       
     -+int git_configset_add_parameters(struct config_set *cs)
     -+{
     -+	return git_config_from_parameters(config_set_callback, cs);
     -+}
     -+
     - int git_configset_get_value(struct config_set *cs, const char *key, const char **value)
     - {
     - 	const struct string_list *values = NULL;
     -@@ config.c: static void read_protected_config(void)
     - 	git_configset_add_file(the_repository->protected_config, system_config);
     - 	git_configset_add_file(the_repository->protected_config, xdg_config);
     - 	git_configset_add_file(the_repository->protected_config, user_config);
     -+	git_configset_add_parameters(the_repository->protected_config);
     +-	read_very_early_config(safe_directory_cb, &data);
     ++	git_protected_config(safe_directory_cb, &data);
       
     - 	free(system_config);
     - 	free(xdg_config);
     -
     - ## config.h ##
     -@@ config.h: void git_configset_init(struct config_set *cs);
     -  */
     - int git_configset_add_file(struct config_set *cs, const char *filename);
     - 
     -+/**
     -+ * Parses command line options and environment variables, and adds the
     -+ * variable-value pairs to the `config_set`. Returns 0 on success, or -1
     -+ * if there is an error in parsing. The caller decides whether to free
     -+ * the incomplete configset or continue using it when the function
     -+ * returns -1.
     -+ */
     -+int git_configset_add_parameters(struct config_set *cs);
     -+
     - /**
     -  * Finds and returns the value list, sorted in order of increasing priority
     -  * for the configuration variable `key` and config set `cs`. When the
     + 	return data.is_safe;
     + }
      
       ## t/t0033-safe-directory.sh ##
      @@ t/t0033-safe-directory.sh: test_expect_success 'safe.directory is not set' '
     @@ t/t0033-safe-directory.sh: test_expect_success 'safe.directory is not set' '
       '
       
       test_expect_success 'ignoring safe.directory in repo config' '
     -
     - ## t/t0035-discovery-bare.sh ##
     -@@ t/t0035-discovery-bare.sh: test_expect_success 'discovery.bare on the command line' '
     - 	git config --global discovery.bare never &&
     - 	(
     - 		cd outer-repo/bare-repo &&
     --		test_must_fail git -c discovery.bare=always rev-parse --git-dir 2>err &&
     --		grep "discovery.bare" err
     -+		git -c discovery.bare=always rev-parse --git-dir
     - 	)
     - '
     - 
 3:  d5a3e9f9845 ! 5:  29053d029f8 setup.c: create `discovery.bare`
     @@ setup.c
       static int inside_git_dir = -1;
       static int inside_work_tree = -1;
       static int work_tree_config_is_bogus;
     -+enum discovery_bare_config {
     -+	DISCOVERY_BARE_UNKNOWN = -1,
     ++enum discovery_bare_allowed {
      +	DISCOVERY_BARE_NEVER = 0,
      +	DISCOVERY_BARE_ALWAYS,
      +};
     -+static enum discovery_bare_config discovery_bare_config =
     -+	DISCOVERY_BARE_UNKNOWN;
       
       static struct startup_info the_startup_info;
       struct startup_info *startup_info = &the_startup_info;
     @@ setup.c: static int ensure_valid_ownership(const char *path)
       
      +static int discovery_bare_cb(const char *key, const char *value, void *d)
      +{
     ++	enum discovery_bare_allowed *discovery_bare_allowed = d;
     ++
      +	if (strcmp(key, "discovery.bare"))
      +		return 0;
      +
      +	if (!strcmp(value, "never")) {
     -+		discovery_bare_config = DISCOVERY_BARE_NEVER;
     ++		*discovery_bare_allowed = DISCOVERY_BARE_NEVER;
      +		return 0;
      +	}
      +	if (!strcmp(value, "always")) {
     -+		discovery_bare_config = DISCOVERY_BARE_ALWAYS;
     ++		*discovery_bare_allowed = DISCOVERY_BARE_ALWAYS;
      +		return 0;
      +	}
      +	return -1;
      +}
      +
     -+static int check_bare_repo_allowed(void)
     ++static enum discovery_bare_allowed get_discovery_bare(void)
      +{
     -+	if (discovery_bare_config == DISCOVERY_BARE_UNKNOWN) {
     -+		discovery_bare_config = DISCOVERY_BARE_ALWAYS;
     -+		git_protected_config(discovery_bare_cb, NULL);
     -+	}
     -+	switch (discovery_bare_config) {
     -+	case DISCOVERY_BARE_NEVER:
     -+		return 0;
     -+	case DISCOVERY_BARE_ALWAYS:
     -+		return 1;
     -+	case DISCOVERY_BARE_UNKNOWN:
     -+		BUG("invalid discovery_bare_config %d", discovery_bare_config);
     -+	}
     -+	return 0;
     ++	enum discovery_bare_allowed result = DISCOVERY_BARE_ALWAYS;
     ++	git_protected_config(discovery_bare_cb, &result);
     ++	return result;
      +}
      +
     -+static const char *discovery_bare_config_to_string(void)
     ++static const char *discovery_bare_allowed_to_string(
     ++	enum discovery_bare_allowed discovery_bare_allowed)
      +{
     -+	switch (discovery_bare_config) {
     ++	switch (discovery_bare_allowed) {
      +	case DISCOVERY_BARE_NEVER:
      +		return "never";
      +	case DISCOVERY_BARE_ALWAYS:
      +		return "always";
     -+	case DISCOVERY_BARE_UNKNOWN:
     -+		BUG("invalid discovery_bare_config %d", discovery_bare_config);
     ++	default:
     ++		BUG("invalid discovery_bare_allowed %d",
     ++		    discovery_bare_allowed);
      +	}
      +	return NULL;
      +}
     @@ setup.c: static enum discovery_result setup_git_directory_gently_1(struct strbuf
       		}
       
       		if (is_git_directory(dir->buf)) {
     -+			if (!check_bare_repo_allowed())
     ++			if (!get_discovery_bare())
      +				return GIT_DIR_DISALLOWED_BARE;
       			if (!ensure_valid_ownership(dir->buf))
       				return GIT_DIR_INVALID_OWNERSHIP;
     @@ setup.c: const char *setup_git_directory_gently(int *nongit_ok)
      +		if (!nongit_ok) {
      +			die(_("cannot use bare repository '%s' (discovery.bare is '%s')"),
      +			    dir.buf,
     -+			    discovery_bare_config_to_string());
     ++			    discovery_bare_allowed_to_string(get_discovery_bare()));
      +		}
      +		*nongit_ok = 1;
      +		break;
     @@ t/t0035-discovery-bare.sh (new)
      +
      +pwd="$(pwd)"
      +
     ++expect_accepted () {
     ++	git "$@" rev-parse --git-dir
     ++}
     ++
      +expect_rejected () {
     -+	test_must_fail git rev-parse --git-dir 2>err &&
     ++	test_must_fail git "$@" rev-parse --git-dir 2>err &&
      +	grep "discovery.bare" err
      +}
      +
     @@ t/t0035-discovery-bare.sh (new)
      +test_expect_success 'discovery.bare unset' '
      +	(
      +		cd outer-repo/bare-repo &&
     -+		git rev-parse --git-dir
     ++		expect_accepted
      +	)
      +'
      +
     @@ t/t0035-discovery-bare.sh (new)
      +	git config --global discovery.bare always &&
      +	(
      +		cd outer-repo/bare-repo &&
     -+		git rev-parse --git-dir
     ++		expect_accepted
      +	)
      +'
      +
     @@ t/t0035-discovery-bare.sh (new)
      +	git config --global discovery.bare never &&
      +	(
      +		cd outer-repo/bare-repo &&
     -+		test_must_fail git -c discovery.bare=always rev-parse --git-dir 2>err &&
     -+		grep "discovery.bare" err
     ++		expect_accepted -c discovery.bare=always &&
     ++		expect_rejected -c discovery.bare=
      +	)
      +'
      +

-- 
gitgitgadget

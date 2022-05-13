Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50330C433F5
	for <git@archiver.kernel.org>; Fri, 13 May 2022 23:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiEMXsK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 May 2022 19:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiEMXsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 May 2022 19:48:09 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BFD3778BB
        for <git@vger.kernel.org>; Fri, 13 May 2022 16:37:41 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d5so13227605wrb.6
        for <git@vger.kernel.org>; Fri, 13 May 2022 16:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mkiATRjhg52FT/UaYp0PleSFyv5kKcaUZ1cWaPb3fEg=;
        b=QqwSPu6Cc6yKAL6Lgj6x3zBT1tRlHiKypKe4yk5Jvlk7+YdOkqUeXEFhKlLLDzYe4F
         MMTJ5iDFyFvMzvCTtLsKsORvdyLz7ClOM2n7otwypghG0t0osxKAeiyIRUnlz6BXK6bx
         YrpkyJFTSv4Xh39K7pV5sCJ5PZzrUMKx2DRlpoN6depIb4wzzabc+ejjrvwreKINDOgT
         +qFBuc5JWuoU3ta7ySYfqCtmOkeWMriaDz2AhpEBdSHpBUtiR0GRNpjYDoGevplLFE1x
         uZLQoGcNwvWqoRToeFw8cd5oeTKU2cdt35WbYrjAgQEnbd6RW1PkMIQv/oNryIcL2yaJ
         2qDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mkiATRjhg52FT/UaYp0PleSFyv5kKcaUZ1cWaPb3fEg=;
        b=MXp0t7iO+S6/gjlF9EiukDnH+ktGfZLB9zXj9HNymI3TwRO7IRAVz7D3beVKgl4ki2
         QYrwEaftBQFnNLzI05vB+Bw0IdqFbhXZP/ED/MDZdZ17qexplcwmpAq+bPxBu2ly1RQx
         MCFmAVdteviVuCARVpVa+LOtWapbCnSlMC/ajSb2k3O1l6/NxbyTNILO10KcSrQ5peHP
         /kmZMQ7dIHTxepJeLnjYlmAGVoM5DmPvOIdZrQEDMeXkJqplbrAOxY5xVtBAmCAJtcSM
         PlByhFoGV7bOZWAEg4Y1KWHLtSPnGDWfpiYmMd5dRhjRI15qAnxhBcBEd7srXiKnR90/
         6YPg==
X-Gm-Message-State: AOAM531GuNBc65DN2rpWexW4r6x20KeMpdEZGd0zVIspB2vGdC2eDCRe
        RmTSHP3oTfUhJEAXSLCOxGtvq+xbfxI=
X-Google-Smtp-Source: ABdhPJxCwAqTkyx5plDyT7EvBUyDLLKLe+sF1z7mLFfvYkaurufQ9RKYAJp6RM72/Vy/wYr/VxGfEQ==
X-Received: by 2002:a05:6000:145:b0:20a:ebb3:5c2c with SMTP id r5-20020a056000014500b0020aebb35c2cmr5693790wrx.545.1652485059836;
        Fri, 13 May 2022 16:37:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p15-20020a7bcdef000000b00394351e35edsm6754390wmj.26.2022.05.13.16.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 16:37:39 -0700 (PDT)
Message-Id: <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.git.git.1651861810633.gitgitgadget@gmail.com>
References: <pull.1261.git.git.1651861810633.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 May 2022 23:37:36 +0000
Subject: [PATCH v2 0/2] setup.c: make bare repo discovery optional
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

Thanks all for the comments on v1, I've expanded this series somewhat to
address them, notably:

 * The config value is now named discovery.bare and is an enum (instead of
   an allow-list). This hopefully moves us away from "bare repos are unsafe
   and need to be guarded against" and towards "bare repos can be made
   optional if it serves your needs better".
 * discovery.bare now causes git to die() instead of silently ignoring the
   bare repo.
 * Add an option that allows a bare repo if it is the CWD, since this is
   presumably a reasonable default for 99% of bare repo users [1].

= Questions/Concerns

 * die()-ing is necessary if we're trying to flip the default value of
   discovery.bare. We'd expect many bare repo users to be broken, and it's
   more helpful to fail loudly than to silently ignore the bare repo.
   
   But in the long term, long after we've flipped the default and users know
   that they need to opt into bare repo discovery, would it be a better UX
   to just silently ignore the bare repo?

= Patch organization

 * Patch 1 introduces discovery.bare with allowed values [always|never].

 * Patch 2 adds discover.bare=cwd, which is useful when users don't always
   set GIT_DIR e.g. their workflow really depends on it, they are in the
   midst of migration.

= Series history

Changes since v1:

 * Rename safe.barerepository to discovery.bare and make it die()
 * Move tests into t/t0034-discovery-bare.sh
 * Avoid unnecessary config reading by using a static variable
 * Add discovery.bare=cwd
 * Fix typos

[1] I tried this 'cwd' setting on our test suite, with some pretty promising
results.

https://github.com/chooglen/git/actions/runs/2321914777

Out of the 8 failing scripts:

 * 6 are of the form "make sure we 'do the right thing' inside a
   subdirectory of a bare repo" (which typically means .git) e.g.
   t9903-bash-prompt.sh. We should be setting discovery.bare=always for
   these tests, so this is a non-issue.
 * t5323-pack-redundant.sh can be rewritten to -C into the root of the bare
   repo instead of a subdirectory.
 * t3310-notes-merge-manual-resolve.sh: not sure what the test is checking
   in particular, but I think this can be rewritten.

IOW, I don't think we have any commands that require that CWD is a
subdirectory of a bare repo, and we could use discovery.bare without much
hassle.

Glen Choo (2):
  setup.c: make bare repo discovery optional
  setup.c: learn discovery.bareRepository=cwd

 Documentation/config/discovery.txt | 26 +++++++++
 setup.c                            | 89 ++++++++++++++++++++++++++++--
 t/t0034-discovery-bare.sh          | 69 +++++++++++++++++++++++
 3 files changed, 178 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/config/discovery.txt
 create mode 100755 t/t0034-discovery-bare.sh


base-commit: e8005e4871f130c4e402ddca2032c111252f070a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1261%2Fchooglen%2Fsetup%2Fdisable-bare-repo-config-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1261/chooglen/setup/disable-bare-repo-config-v2
Pull-Request: https://github.com/git/git/pull/1261

Range-diff vs v1:

 1:  3370258c4b3 ! 1:  22b10bf9da8 [RFC] setup.c: make bare repo discovery optional
     @@ Metadata
      Author: Glen Choo <chooglen@google.com>
      
       ## Commit message ##
     -    [RFC] setup.c: make bare repo discovery optional
     +    setup.c: make bare repo discovery optional
      
     -    Add a config variable, `safe.barerepository`, that tells Git whether or
     -    not to recognize bare repositories when it is trying to discover the
     -    repository. This only affects repository discovery, thus it has no
     +    Add a config variable, `discovery.bare`, that tells Git whether or not
     +    it should work with the bare repository it has discovered i.e. Git will
     +    die() if it discovers a bare repository, but it is not allowed by
     +    `discovery.bare`. This only affects repository discovery, thus it has no
          effect if discovery was not done (e.g. `--git-dir` was passed).
      
          This is motivated by the fact that some workflows don't use bare
     @@ Commit message
            are probably very rare in practice, this lets users reduce the chance
            to zero.
      
     -    This config is designed to be used like an allow-list, but it is not yet
     -    clear what a good format for this allow-list would be. As such, this
     -    patch limits the config value to a tri-state of [true|false|unset]:
     +    This config is an enum of:
      
     -    - [*|(unset)] recognize all bare repositories (like Git does today)
     -    - (empty) recognize no bare repositories
     +    - ["always"|(unset)]: always recognize bare repositories (like Git does
     +      today)
     +    - "never": never recognize bare repositories
      
     -    and leaves the full format to be determined later.
     +    More values are expected to be added later, and the default is expected
     +    to change (i.e. to something other than "always").
      
          [1]: https://lore.kernel.org/git/kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com
          [2]: I don't personally know anyone who does this as part of their
     @@ Commit message
      
          Signed-off-by: Glen Choo <chooglen@google.com>
      
     - ## Documentation/config/safe.txt ##
     +    WIP setup.c: make discovery.bare die on failure
     +
     +    Signed-off-by: Glen Choo <chooglen@google.com>
     +
     + ## Documentation/config/discovery.txt (new) ##
      @@
     -+safe.barerepository::
     -+	This config entry specifies directories that Git can recognize as
     -+	a bare repository when looking for the repository (aka repository
     ++discovery.bare::
     ++	Specifies what kinds of directories Git can recognize as a bare
     ++	repository when looking for the repository (aka repository
      +	discovery). This has no effect if repository discovery is not
      +	performed e.g. the path to the repository is set via `--git-dir`
      +	(see linkgit:git[1]).
      ++
     -+It is recommended that you set this value so that Git will only use the bare
     -+repositories you intend it to. This prevents certain types of security and
     -+non-security problems, such as:
     -+
     -+* `git clone`-ing a repository containing a maliciously bare repository
     -+  inside it.
     -+* Git recognizing a directory that isn't mean to be a bare repository,
     -+  but happens to look like one.
     -++
     -+The currently supported values are `*` (Git recognizes all bare
     -+repositories) and the empty value (Git never recognizes bare repositories).
     -+Defaults to `*`.
     -++
      +This config setting is only respected when specified in a system or global
      +config, not when it is specified in a repository config or via the command
     -+line option `-c safe.barerepository=<path>`.
     ++line option `-c discovery.bare=<value>`.
     +++
     ++The currently supported values are `always` (Git always recognizes bare
     ++repositories) and `never` (Git never recognizes bare repositories).
     ++This defaults to `always`, but this default is likely to change.
     +++
     ++If your workflow does not rely on bare repositories, it is recommended that
     ++you set this value to `never`. This makes repository discovery easier to
     ++reason about and prevents certain types of security and non-security
     ++problems, such as:
      +
     - safe.directory::
     - 	These config entries specify Git-tracked directories that are
     - 	considered safe even if they are owned by someone other than the
     ++* `git clone`-ing a repository containing a malicious bare repository
     ++  inside it.
     ++* Git recognizing a directory that isn't meant to be a bare repository,
     ++  but happens to look like one.
      
       ## setup.c ##
     +@@
     + static int inside_git_dir = -1;
     + static int inside_work_tree = -1;
     + static int work_tree_config_is_bogus;
     ++enum discovery_bare_config {
     ++	DISCOVERY_BARE_UNKNOWN = -1,
     ++	DISCOVERY_BARE_NEVER = 0,
     ++	DISCOVERY_BARE_ALWAYS,
     ++};
     ++static enum discovery_bare_config discovery_bare_config =
     ++	DISCOVERY_BARE_UNKNOWN;
     + 
     + static struct startup_info the_startup_info;
     + struct startup_info *startup_info = &the_startup_info;
      @@ setup.c: static int ensure_valid_ownership(const char *path)
       	return data.is_safe;
       }
       
     -+/*
     -+ * This is similar to safe_directory_data, but only supports true/false.
     -+ */
     -+struct safe_bare_repository_data {
     -+	int is_safe;
     -+};
     -+
     -+static int safe_bare_repository_cb(const char *key, const char *value, void *d)
     ++static int discovery_bare_cb(const char *key, const char *value, void *d)
      +{
     -+	struct safe_bare_repository_data *data = d;
     -+
     -+	if (strcmp(key, "safe.barerepository"))
     ++	if (strcmp(key, "discovery.bare"))
      +		return 0;
      +
     -+	if (!value || !strcmp(value, "*")) {
     -+		data->is_safe = 1;
     ++	if (!strcmp(value, "never")) {
     ++		discovery_bare_config = DISCOVERY_BARE_NEVER;
      +		return 0;
      +	}
     -+	if (!*value) {
     -+		data->is_safe = 0;
     ++	if (!strcmp(value, "always")) {
     ++		discovery_bare_config = DISCOVERY_BARE_ALWAYS;
      +		return 0;
      +	}
      +	return -1;
      +}
      +
     -+static int should_detect_bare(void)
     ++static int check_bare_repo_allowed(void)
      +{
     -+	struct safe_bare_repository_data data;
     -+
     -+	read_very_early_config(safe_bare_repository_cb, &data);
     ++	if (discovery_bare_config == DISCOVERY_BARE_UNKNOWN) {
     ++		read_very_early_config(discovery_bare_cb, NULL);
     ++		/* We didn't find a value; use the default. */
     ++		if (discovery_bare_config == DISCOVERY_BARE_UNKNOWN)
     ++			discovery_bare_config = DISCOVERY_BARE_ALWAYS;
     ++	}
     ++	switch (discovery_bare_config) {
     ++	case DISCOVERY_BARE_NEVER:
     ++		return 0;
     ++	case DISCOVERY_BARE_ALWAYS:
     ++		return 1;
     ++	default:
     ++		BUG("invalid discovery_bare_config %d", discovery_bare_config);
     ++	}
     ++}
      +
     -+	return data.is_safe;
     ++static const char *discovery_bare_config_to_string(void)
     ++{
     ++	switch (discovery_bare_config) {
     ++	case DISCOVERY_BARE_NEVER:
     ++		return "never";
     ++	case DISCOVERY_BARE_ALWAYS:
     ++		return "always";
     ++	default:
     ++		BUG("invalid discovery_bare_config %d", discovery_bare_config);
     ++	}
      +}
      +
       enum discovery_result {
       	GIT_DIR_NONE = 0,
       	GIT_DIR_EXPLICIT,
     +@@ setup.c: enum discovery_result {
     + 	GIT_DIR_HIT_CEILING = -1,
     + 	GIT_DIR_HIT_MOUNT_POINT = -2,
     + 	GIT_DIR_INVALID_GITFILE = -3,
     +-	GIT_DIR_INVALID_OWNERSHIP = -4
     ++	GIT_DIR_INVALID_OWNERSHIP = -4,
     ++	GIT_DIR_DISALLOWED_BARE = -5
     + };
     + 
     + /*
      @@ setup.c: static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
     - 			return GIT_DIR_DISCOVERED;
       		}
       
     --		if (is_git_directory(dir->buf)) {
     -+		if (should_detect_bare() && is_git_directory(dir->buf)) {
     + 		if (is_git_directory(dir->buf)) {
     ++			if (!check_bare_repo_allowed())
     ++				return GIT_DIR_DISALLOWED_BARE;
       			if (!ensure_valid_ownership(dir->buf))
       				return GIT_DIR_INVALID_OWNERSHIP;
       			strbuf_addstr(gitdir, ".");
     +@@ setup.c: const char *setup_git_directory_gently(int *nongit_ok)
     + 		}
     + 		*nongit_ok = 1;
     + 		break;
     ++	case GIT_DIR_DISALLOWED_BARE:
     ++		if (!nongit_ok) {
     ++			die(_("cannot use bare repository '%s' (discovery.bare is '%s')"),
     ++			    dir.buf,
     ++			    discovery_bare_config_to_string());
     ++		}
     ++		*nongit_ok = 1;
     ++		break;
     + 	case GIT_DIR_NONE:
     + 		/*
     + 		 * As a safeguard against setup_git_directory_gently_1 returning
      
     - ## t/t1510-repo-setup.sh ##
     -@@ t/t1510-repo-setup.sh: test_expect_success '#16e: bareness preserved by --bare' '
     - 	)
     - '
     - 
     -+# Test the tri-state of [(unset)|""|"*"].
     -+test_expect_success '#16f: bare repo in worktree' '
     -+	test_when_finished "git config --global --unset safe.barerepository" &&
     -+	setup_repo 16f unset "" unset &&
     + ## t/t0034-discovery-bare.sh (new) ##
     +@@
     ++#!/bin/sh
      +
     -+	git init --bare 16f/default/bare &&
     -+	git init --bare 16f/default/bare/bare &&
     -+	try_case 16f/default/bare unset unset \
     -+		. "(null)" "$here/16f/default/bare" "(null)" &&
     -+	try_case 16f/default/bare/bare unset unset \
     -+		. "(null)" "$here/16f/default/bare/bare" "(null)" &&
     ++test_description='verify discovery.bare checks'
      +
     -+	git config --global safe.barerepository "*" &&
     -+	git init --bare 16f/all/bare &&
     -+	git init --bare 16f/all/bare/bare &&
     -+	try_case 16f/all/bare unset unset \
     -+		. "(null)" "$here/16f/all/bare" "(null)" &&
     -+	try_case 16f/all/bare/bare unset unset \
     -+		. "(null)" "$here/16f/all/bare/bare" "(null)" &&
     ++. ./test-lib.sh
      +
     -+	git config --global safe.barerepository "" &&
     -+	git init --bare 16f/never/bare &&
     -+	git init --bare 16f/never/bare/bare &&
     -+	try_case 16f/never/bare unset unset \
     -+		".git" "$here/16f" "$here/16f" "never/bare/" &&
     -+	try_case 16f/never/bare/bare unset unset \
     -+		".git" "$here/16f" "$here/16f" "never/bare/bare/"
     -+'
     ++pwd="$(pwd)"
      +
     -+test_expect_success '#16g: inside .git with safe.barerepository' '
     -+	test_when_finished "git config --global --unset safe.barerepository" &&
     ++expect_allowed () {
     ++	git rev-parse --absolute-git-dir >actual &&
     ++	echo "$pwd/outer-repo/bare-repo" >expected &&
     ++	test_cmp expected actual
     ++}
      +
     -+	# Omit the "default" case; it is covered by 16a.
     ++expect_rejected () {
     ++	test_must_fail git rev-parse --absolute-git-dir 2>err &&
     ++	grep "discovery.bare" err
     ++}
      +
     -+	git config --global safe.barerepository "*" &&
     -+	setup_repo 16g/all unset "" unset &&
     -+	mkdir -p 16g/all/.git/wt/sub &&
     -+	try_case 16g/all/.git unset unset \
     -+		. "(null)" "$here/16g/all/.git" "(null)" &&
     -+	try_case 16g/all/.git/wt unset unset \
     -+		"$here/16g/all/.git" "(null)" "$here/16g/all/.git/wt" "(null)" &&
     -+	try_case 16g/all/.git/wt/sub unset unset \
     -+		"$here/16g/all/.git" "(null)" "$here/16g/all/.git/wt/sub" "(null)" &&
     ++test_expect_success 'setup bare repo in worktree' '
     ++	git init outer-repo &&
     ++	git init --bare outer-repo/bare-repo
     ++'
     ++
     ++test_expect_success 'discovery.bare unset' '
     ++	(
     ++		cd outer-repo/bare-repo &&
     ++		expect_allowed &&
     ++		cd refs/ &&
     ++		expect_allowed
     ++	)
     ++'
     ++
     ++test_expect_success 'discovery.bare=always' '
     ++	git config --global discovery.bare always &&
     ++	(
     ++		cd outer-repo/bare-repo &&
     ++		expect_allowed &&
     ++		cd refs/ &&
     ++		expect_allowed
     ++	)
     ++'
      +
     -+	git config --global safe.barerepository "" &&
     -+	setup_repo 16g/never unset "" unset &&
     -+	mkdir -p 16g/never/.git/wt/sub &&
     -+	try_case 16g/never/.git unset unset \
     -+		".git" "$here/16g/never" "$here/16g/never" ".git/" &&
     -+	try_case 16g/never/.git/wt unset unset \
     -+		".git" "$here/16g/never" "$here/16g/never" ".git/wt/" &&
     -+	try_case 16g/never/.git/wt/sub unset unset \
     -+		".git" "$here/16g/never" "$here/16g/never" ".git/wt/sub/"
     ++test_expect_success 'discovery.bare=never' '
     ++	git config --global discovery.bare never &&
     ++	(
     ++		cd outer-repo/bare-repo &&
     ++		expect_rejected &&
     ++		cd refs/ &&
     ++		expect_rejected
     ++	) &&
     ++	(
     ++		GIT_DIR=outer-repo/bare-repo &&
     ++		export GIT_DIR &&
     ++		expect_allowed
     ++	)
      +'
      +
     - test_expect_success '#17: GIT_WORK_TREE without explicit GIT_DIR is accepted (bare case)' '
     - 	# Just like #16.
     - 	setup_repo 17a unset "" true &&
     ++test_done
 -:  ----------- > 2:  62070aab7eb setup.c: learn discovery.bareRepository=cwd

-- 
gitgitgadget

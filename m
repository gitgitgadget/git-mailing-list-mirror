Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBD9C433E0
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 15:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3705320842
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 15:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="l+YFDE2U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgFLPpS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 11:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgFLPpS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 11:45:18 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4248C03E96F
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 08:45:17 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l17so9374904qki.9
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 08:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JhH//QdxOo6lgtHOM3x+Lg0Rv1/9H9lqXsqLZlcg/T0=;
        b=l+YFDE2U93v3r/cGXj+SgTuxJ3XzdW3g9t4XKksCjb/eEKJbgYgTGH+gG0ZcrRRZGf
         FnZni1KC3ZwpBDc1FQZM/rnl1j6MJvet6xAeH7PwuyS+YgtpepMJnzUszvRKO3T1KbaZ
         WR1YNqa7S+i+BqFpPzBMiiIAvXLMIFXify10rCaJRSUuqulUGztZ4DpYqaSKaAZOMfcg
         qf1WPpcURmgHJdaI1sQqeFINwLh8F9nXUQsfwTVkVopMTMBF46ZqQMLcin50EJZIrt50
         VG3DiwN5iNeFoM7c9HDGhHWdi2a9z1ZdVfgVzPE3OxDNT4qnfCyoAf2s8igbIUZJtdCE
         kqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JhH//QdxOo6lgtHOM3x+Lg0Rv1/9H9lqXsqLZlcg/T0=;
        b=U2nc/BEcjtzyetIyCh0ac7bGsenZO7KJqCfl9EEePCum5pFx6fP5JkxxkqbUmHxvcN
         33ecDe3eTlapb58+YiOwcnLlfCazNb04O/CpXAZW5nTtHLHe551+xTecDsNSD5pwzka8
         qRcnWQ0myT2JxlN5EqITP5i/umZw2BbaqGnxxACp7yOhe7uTIo114+Ey9C1D+8HkjSvB
         LBKcQ/v2+78kB12IYbpSVSMNfR3KJ1gCEZ1nUlsqeN6ORxKRQkagmhfFT5iy+MwYs4hP
         4ZnyC2bQ0pkkUumoDE45JjMe6S8FNuGTRizWecgV3DhoNN6LIgVCtYCY8VUR6ia6N1+r
         VeWg==
X-Gm-Message-State: AOAM530ifBmtMuKYY+kyO3T97OuTfobp9H7T9E6xT9MWtC3K8cvzCm4m
        1n0d67QQMt6m7JEO9jHnQ/inIwjVsN6RqQ==
X-Google-Smtp-Source: ABdhPJw4T1eVREvlf+79nfSGYm9fPORC3zI9TI4Rl1r3+GM0hlEMUtFj/ulfy9R1v3qGdgaot4fVKA==
X-Received: by 2002:a37:9e10:: with SMTP id h16mr3627945qke.381.1591976715956;
        Fri, 12 Jun 2020 08:45:15 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:9a16::3])
        by smtp.gmail.com with ESMTPSA id r37sm4988157qtk.34.2020.06.12.08.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 08:45:14 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, newren@gmail.com,
        jonathantanmy@google.com
Subject: [PATCH v4 0/6] grep: honor sparse checkout and add option to ignore it
Date:   Fri, 12 Jun 2020 12:44:58 -0300
Message-Id: <cover.1591974940.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590627264.git.matheus.bernardino@usp.br>
References: <cover.1590627264.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series makes git-grep restrict its output to the present sparsity
patterns. A new global option is added to toggle this behavior in grep
and hopefully more commands in the future.

Main changes since v3:

Patch 2:
- Reworded commit message for clarity.

Patch 3 and 4:
- Split into two patches. The first one contains the changes to easily
  accommodate new options in t/helper/test-config; the second adds
  --submodule=path.

Patch 4:
- Removed the section "Such scenario might not be needed now..." from
  the commit message. This was not true as we already have other
  submodule configs, even in git-grep itself, which should be considered
  when recursing into submodules.  And this should happen for both the
  local scope and worktree scope of the submodules configs.

Patch 5:
- Reworded commit message as suggested by Elijah [1].
- Fixed spelling errors in t7817 (as also pointed in [1]).
- Added test to ensure grep searches unmerged files despite not matching
  the sparsity patterns.
- Renamed builtin/grep.c:in_sparse_checkout() to
  path_in_sparse_checkout() for clarity.

Patch 6:
- Fixed typos and spelling errors.
- Removed unnecessary new line in git.c.
- Included "sparse-checkout.h" in git.c to avoid Sparse error as Ramsay
  Jones pointed out. And moved opt_restrict_to_sparse_paths to
  sparse-checkout.c.
- Moved information about how grep honors sparse.restrictCmds to grep's
  man page.

[1]: https://lore.kernel.org/git/CABPp-BFsCPPNOZ92JQRJeGyNd0e-TCW-LcLyr0i_+VSQJP+GCg@mail.gmail.com/

CI: https://github.com/matheustavares/git/actions/runs/133459296

Matheus Tavares (6):
  doc: grep: unify info on configuration variables
  t/helper/test-config: return exit codes consistently
  t/helper/test-config: facilitate addition of new cli options
  config: correctly read worktree configs in submodules
  grep: honor sparse checkout patterns
  config: add setting to ignore sparsity patterns in some cmds

 Documentation/config.txt               |   2 +
 Documentation/config/grep.txt          |  18 +-
 Documentation/config/sparse.txt        |  20 ++
 Documentation/git-grep.txt             |  36 +--
 Documentation/git.txt                  |   4 +
 Makefile                               |   1 +
 builtin/grep.c                         | 134 ++++++++++-
 config.c                               |  21 +-
 contrib/completion/git-completion.bash |   2 +
 git.c                                  |   5 +
 sparse-checkout.c                      |  18 ++
 sparse-checkout.h                      |  11 +
 t/helper/test-config.c                 | 183 +++++++++-----
 t/t2404-worktree-config.sh             |  16 ++
 t/t7011-skip-worktree-reading.sh       |   9 -
 t/t7817-grep-sparse-checkout.sh        | 321 +++++++++++++++++++++++++
 t/t9902-completion.sh                  |   4 +-
 17 files changed, 687 insertions(+), 118 deletions(-)
 create mode 100644 Documentation/config/sparse.txt
 create mode 100644 sparse-checkout.c
 create mode 100644 sparse-checkout.h
 create mode 100755 t/t7817-grep-sparse-checkout.sh

Range-diff against v3:
1:  86602034c1 = 1:  99cf2124f3 doc: grep: unify info on configuration variables
2:  e5b689aaad ! 2:  85c429ac69 t/helper/test-config: return exit codes consistently
    @@ Commit message
         different codes, to reflect the status of the requested operations.
         These codes are sometimes checked in the tests, but not all of the codes
         are returned consistently by the helper: 1 will usually refer to a
    -    "value not found", but usage errors can also return 1 or 128. The latter
    -    is also expected on errors within the configset functions. These
    +    "value not found", but usage errors can also return 1 or 128. Moreover,
    +    128 is also expected on errors within the configset functions. These
         inconsistent uses of the exit codes can lead to false positives in the
    -    tests. Although all tests that currently check the helper's exit code,
    -    on errors, do also check the output, it's still better to standardize
    -    the exit codes and avoid future problems in new tests. While we are
    -    here, let's also check that we have the expected argc for
    +    tests. Although all tests which expect errors and check the helper's
    +    exit code currently also check the output, it's still better to
    +    standardize the exit codes and avoid future problems in new tests.
    +    While we are here, let's also check that we have the expected argc for
         configset_get_value and configset_get_value_multi, before trying to use
         argv.
     
-:  ---------- > 3:  e9eaaecccc t/helper/test-config: facilitate addition of new cli options
3:  0d2fd01305 ! 4:  6402c96807 config: correctly read worktree configs in submodules
    @@ Commit message
         to make the path to the file. Furthermore, it also checks that
         extensions.worktreeConfig is set through the
         repository_format_worktree_config variable, which refers to
    -    the_repository only. Thus, when a submodule has worktree settings, a
    -    command executed in the superproject that recurses into the submodule
    -    won't find the said settings.
    +    the_repository only. Thus, when a submodule has worktree-specific
    +    settings, a command executed in the superproject that recurses into the
    +    submodule won't find the said settings.
     
    -    Such a scenario might not be needed now, but it will be in the following
    -    patch. git-grep will learn to honor sparse checkouts and, when running
    -    with --recurse-submodules, the submodule's sparse checkout settings must
    -    be loaded. As these settings are stored in the config.worktree file,
    -    they would be ignored without this patch. So let's fix this by reading
    -    the right config.worktree file and extensions.worktreeConfig setting,
    -    based on the git_dir and commondir paths given to
    -    do_git_config_sequence(). Also add a test to avoid any regressions.
    +    This will be especially important in the next patch: git-grep will learn
    +    to honor sparse checkouts and, when running with --recurse-submodules,
    +    the submodule's sparse checkout settings must be loaded. As these
    +    settings are stored in the config.worktree file, they would be ignored
    +    without this patch. So let's fix this by reading the right
    +    config.worktree file and extensions.worktreeConfig setting, based on the
    +    git_dir and commondir paths given to do_git_config_sequence(). Also
    +    add a test to avoid any regressions.
     
         Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
     
    @@ t/helper/test-config.c
       * get_value -> prints the value with highest priority for the entered key
       *
     @@ t/helper/test-config.c: int cmd__config(int argc, const char **argv)
    - 	int i, val;
    - 	const char *v;
      	const struct string_list *strptr;
    --	struct config_set cs;
    -+	struct config_set cs = { .hash_initialized = 0 };
    + 	struct config_set cs = { .hash_initialized = 0 };
      	enum test_config_exit_code ret = TC_SUCCESS;
     +	struct repository *repo = the_repository;
     +	const char *subrepo_path = NULL;
    -+
    -+	argc--; /* skip over "config" */
    -+	argv++;
    -+
    -+	if (argc == 0)
    -+		goto print_usage_error;
    -+
    + 
    + 	argc--; /* skip over "config" */
    + 	argv++;
    +@@ t/helper/test-config.c: int cmd__config(int argc, const char **argv)
    + 	if (argc == 0)
    + 		goto print_usage_error;
    + 
     +	if (skip_prefix(*argv, "--submodule=", &subrepo_path)) {
     +		argc--;
     +		argv++;
     +		if (argc == 0)
     +			goto print_usage_error;
     +	}
    - 
    --	if (argc == 3 && !strcmp(argv[1], "read_early_config")) {
    --		read_early_config(early_config_cb, (void *)argv[2]);
    -+	if (argc == 2 && !strcmp(argv[0], "read_early_config")) {
    ++
    + 	if (argc == 2 && !strcmp(argv[0], "read_early_config")) {
     +		if (subrepo_path) {
     +			fprintf(stderr, "Cannot use --submodule with read_early_config\n");
     +			return TC_USAGE_ERROR;
     +		}
    -+		read_early_config(early_config_cb, (void *)argv[1]);
    + 		read_early_config(early_config_cb, (void *)argv[1]);
      		return TC_SUCCESS;
      	}
    - 
    +@@ t/helper/test-config.c: int cmd__config(int argc, const char **argv)
      	setup_git_directory();
    --
      	git_configset_init(&cs);
      
    --	if (argc < 2)
    --		goto print_usage_error;
     +	if (subrepo_path) {
     +		const struct submodule *sub;
     +		struct repository *subrepo = xcalloc(1, sizeof(*repo));
    @@ t/helper/test-config.c: int cmd__config(int argc, const char **argv)
     +		}
     +		repo = subrepo;
     +	}
    - 
    --	if (argc == 3 && !strcmp(argv[1], "get_value")) {
    --		if (!git_config_get_value(argv[2], &v)) {
    -+	if (argc == 2 && !strcmp(argv[0], "get_value")) {
    ++
    + 	if (argc == 2 && !strcmp(argv[0], "get_value")) {
    +-		if (!git_config_get_value(argv[1], &v)) {
     +		if (!repo_config_get_value(repo, argv[1], &v)) {
      			if (!v)
      				printf("(NULL)\n");
      			else
    - 				printf("%s\n", v);
    - 		} else {
    --			printf("Value not found for \"%s\"\n", argv[2]);
    -+			printf("Value not found for \"%s\"\n", argv[1]);
    +@@ t/helper/test-config.c: int cmd__config(int argc, const char **argv)
      			ret = TC_VALUE_NOT_FOUND;
      		}
    --	} else if (argc == 3 && !strcmp(argv[1], "get_value_multi")) {
    --		strptr = git_config_get_value_multi(argv[2]);
    -+	} else if (argc == 2 && !strcmp(argv[0], "get_value_multi")) {
    + 	} else if (argc == 2 && !strcmp(argv[0], "get_value_multi")) {
    +-		strptr = git_config_get_value_multi(argv[1]);
     +		strptr = repo_config_get_value_multi(repo, argv[1]);
      		if (strptr) {
      			for (i = 0; i < strptr->nr; i++) {
      				v = strptr->items[i].string;
     @@ t/helper/test-config.c: int cmd__config(int argc, const char **argv)
    - 					printf("%s\n", v);
    - 			}
    - 		} else {
    --			printf("Value not found for \"%s\"\n", argv[2]);
    -+			printf("Value not found for \"%s\"\n", argv[1]);
      			ret = TC_VALUE_NOT_FOUND;
      		}
    --	} else if (argc == 3 && !strcmp(argv[1], "get_int")) {
    --		if (!git_config_get_int(argv[2], &val)) {
    -+	} else if (argc == 2 && !strcmp(argv[0], "get_int")) {
    + 	} else if (argc == 2 && !strcmp(argv[0], "get_int")) {
    +-		if (!git_config_get_int(argv[1], &val)) {
     +		if (!repo_config_get_int(repo, argv[1], &val)) {
      			printf("%d\n", val);
      		} else {
    --			printf("Value not found for \"%s\"\n", argv[2]);
    -+			printf("Value not found for \"%s\"\n", argv[1]);
    + 			printf("Value not found for \"%s\"\n", argv[1]);
      			ret = TC_VALUE_NOT_FOUND;
      		}
    --	} else if (argc == 3 && !strcmp(argv[1], "get_bool")) {
    --		if (!git_config_get_bool(argv[2], &val)) {
    -+	} else if (argc == 2 && !strcmp(argv[0], "get_bool")) {
    + 	} else if (argc == 2 && !strcmp(argv[0], "get_bool")) {
    +-		if (!git_config_get_bool(argv[1], &val)) {
     +		if (!repo_config_get_bool(repo, argv[1], &val)) {
      			printf("%d\n", val);
      		} else {
    --			printf("Value not found for \"%s\"\n", argv[2]);
     +
    -+			printf("Value not found for \"%s\"\n", argv[1]);
    + 			printf("Value not found for \"%s\"\n", argv[1]);
      			ret = TC_VALUE_NOT_FOUND;
      		}
    --	} else if (argc == 3 && !strcmp(argv[1], "get_string")) {
    --		if (!git_config_get_string_const(argv[2], &v)) {
    -+	} else if (argc == 2 && !strcmp(argv[0], "get_string")) {
    + 	} else if (argc == 2 && !strcmp(argv[0], "get_string")) {
    +-		if (!git_config_get_string_const(argv[1], &v)) {
     +		if (!repo_config_get_string_const(repo, argv[1], &v)) {
      			printf("%s\n", v);
      		} else {
    --			printf("Value not found for \"%s\"\n", argv[2]);
    -+			printf("Value not found for \"%s\"\n", argv[1]);
    + 			printf("Value not found for \"%s\"\n", argv[1]);
      			ret = TC_VALUE_NOT_FOUND;
      		}
    --	} else if (argc >= 3 && !strcmp(argv[1], "configset_get_value")) {
    --		for (i = 3; i < argc; i++) {
    -+	} else if (argc >= 2 && !strcmp(argv[0], "configset_get_value")) {
    + 	} else if (argc >= 2 && !strcmp(argv[0], "configset_get_value")) {
     +		if (subrepo_path) {
     +			fprintf(stderr, "Cannot use --submodule with configset_get_value\n");
     +			ret = TC_USAGE_ERROR;
     +			goto out;
     +		}
    -+		for (i = 2; i < argc; i++) {
    + 		for (i = 2; i < argc; i++) {
      			int err;
      			if ((err = git_configset_add_file(&cs, argv[i]))) {
    - 				fprintf(stderr, "Error (%d) reading configuration file %s.\n", err, argv[i]);
     @@ t/helper/test-config.c: int cmd__config(int argc, const char **argv)
    - 				goto out;
    - 			}
    - 		}
    --		if (!git_configset_get_value(&cs, argv[2], &v)) {
    -+		if (!git_configset_get_value(&cs, argv[1], &v)) {
    - 			if (!v)
    - 				printf("(NULL)\n");
    - 			else
    - 				printf("%s\n", v);
    - 		} else {
    --			printf("Value not found for \"%s\"\n", argv[2]);
    -+			printf("Value not found for \"%s\"\n", argv[1]);
      			ret = TC_VALUE_NOT_FOUND;
      		}
    --	} else if (argc >= 3 && !strcmp(argv[1], "configset_get_value_multi")) {
    --		for (i = 3; i < argc; i++) {
    -+	} else if (argc >= 2 && !strcmp(argv[0], "configset_get_value_multi")) {
    + 	} else if (argc >= 2 && !strcmp(argv[0], "configset_get_value_multi")) {
     +		if (subrepo_path) {
     +			fprintf(stderr, "Cannot use --submodule with configset_get_value_multi\n");
     +			ret = TC_USAGE_ERROR;
     +			goto out;
     +		}
    -+		for (i = 2; i < argc; i++) {
    + 		for (i = 2; i < argc; i++) {
      			int err;
      			if ((err = git_configset_add_file(&cs, argv[i]))) {
    - 				fprintf(stderr, "Error (%d) reading configuration file %s.\n", err, argv[i]);
     @@ t/helper/test-config.c: int cmd__config(int argc, const char **argv)
    - 				goto out;
    - 			}
    - 		}
    --		strptr = git_configset_get_value_multi(&cs, argv[2]);
    -+		strptr = git_configset_get_value_multi(&cs, argv[1]);
    - 		if (strptr) {
    - 			for (i = 0; i < strptr->nr; i++) {
    - 				v = strptr->items[i].string;
    -@@ t/helper/test-config.c: int cmd__config(int argc, const char **argv)
    - 					printf("%s\n", v);
    - 			}
    - 		} else {
    --			printf("Value not found for \"%s\"\n", argv[2]);
    -+			printf("Value not found for \"%s\"\n", argv[1]);
      			ret = TC_VALUE_NOT_FOUND;
      		}
    --	} else if (!strcmp(argv[1], "iterate")) {
    + 	} else if (!strcmp(argv[0], "iterate")) {
     -		git_config(iterate_cb, NULL);
    -+	} else if (!strcmp(argv[0], "iterate")) {
     +		repo_config(repo, iterate_cb, NULL);
      	} else {
      print_usage_error:
4:  3b819a8d52 ! 5:  4d2916eb99 grep: honor sparse checkout patterns
    @@ Commit message
     
         One of the main uses for a sparse checkout is to allow users to focus on
         the subset of files in a repository in which they are interested. But
    -    git-grep currently ignores the sparsity patterns and report all matches
    +    git-grep currently ignores the sparsity patterns and reports all matches
         found outside this subset, which kind of goes in the opposite direction.
    -    Let's fix that, making it honor the sparsity boundaries for every
    -    grepping case where this is relevant:
    +    There are some use cases for ignoring the sparsity patterns and the next
    +    commit will add an option to obtain this behavior, but here we start by
    +    making grep honor the sparsity boundaries in every case where this is
    +    relevant:
     
         - git grep in worktree
         - git grep --cached
         - git grep $REVISION
     
    -    For the worktree case, we will not grep paths that have the
    -    SKIP_WORKTREE bit set, even if they are present for some reason (e.g.
    -    manually created after `git sparse-checkout init`). But the next patch
    -    will add an option to do so. (See 'Note' below.)
    +    For the worktree and cached cases, we iterate over paths without the
    +    SKIP_WORKTREE bit set, and limit our searches to these paths. For the
    +    $REVISION case, we limit the paths we search to those that match the
    +    sparsity patterns. (We do not check the SKIP_WORKTREE bit for the
    +    $REVISION case, because $REVISION may contain paths that do not exist in
    +    HEAD and thus for which we have no SKIP_WORKTREE bit to consult. The
    +    sparsity patterns tell us how the SKIP_WORKTREE bit would be set if we
    +    were to check out $REVISION, so we consult those. Also, we don't use the
    +    sparsity patterns with the worktree or cached cases, both because we
    +    have a bit we can check directly and more efficiently, and because
    +    unmerged entries from a merge or a rebase could cause more files to
    +    temporarily be present than the sparsity patterns would normally
    +    select.)
     
    -    For `git grep $REVISION`, we will choose to honor the sparsity patterns
    -    only when $REVISION is a commit-ish object. The reason is that, for a
    -    tree, we don't know whether it represents the root of a repository or a
    -    subtree. So we wouldn't be able to correctly match it against the
    -    sparsity patterns. E.g. suppose we have a repository with these two
    -    sparsity rules: "/*" and "!/a"; and the following structure:
    -
    -    /
    -    | - a (file)
    -    | - d (dir)
    -        | - a (file)
    -
    -    If `git grep $REVISION` were to honor the sparsity patterns for every
    -    object type, when grepping the /d tree, we would wrongly ignore the /d/a
    -    file. This happens because we wouldn't know it resides in /d and
    -    therefore it would wrongly match the pattern "!/a". Furthermore, for a
    -    search in a blob object, we wouldn't even have a path to check the
    -    patterns against. So, let's ignore the sparsity patterns when grepping
    -    non-commit-ish objects.
    -
    -    Note: The behavior introduced in this patch is what some users have
    -    reported[1] that they would like by default. But the old behavior is
    -    still desirable for some use cases. Therefore, the next patch will add
    -    an option to allow restoring it when needed.
    -
    -    [1]: https://lore.kernel.org/git/CABPp-BGuFhDwWZBRaD3nA8ui46wor-4=Ha1G1oApsfF8KNpfGQ@mail.gmail.com/
    +    Note that there is a special case here: `git grep $TREE`. In this case,
    +    we cannot know whether $TREE corresponds to the root of the repository
    +    or some sub-tree, and thus there is no way for us to know which sparsity
    +    patterns, if any, apply. So the $TREE case will not use sparsity
    +    patterns or any SKIP_WORKTREE bits and will instead always search all
    +    files within the $TREE.
     
         Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
     
    @@ builtin/grep.c: static int grep_cache(struct grep_opt *opt,
     +	return patterns;
     +}
     +
    -+static int in_sparse_checkout(struct strbuf *path, int prefix_len,
    -+			      unsigned int entry_mode,
    -+			      struct index_state *istate,
    -+			      struct pattern_list *sparsity,
    -+			      enum pattern_match_result parent_match,
    -+			      enum pattern_match_result *match)
    ++static int path_in_sparse_checkout(struct strbuf *path, int prefix_len,
    ++				   unsigned int entry_mode,
    ++				   struct index_state *istate,
    ++				   struct pattern_list *sparsity,
    ++				   enum pattern_match_result parent_match,
    ++				   enum pattern_match_result *match)
     +{
     +	int dtype = DT_UNKNOWN;
     +	int is_dir = S_ISDIR(entry_mode);
    @@ builtin/grep.c: static int grep_tree(struct grep_opt *opt, const struct pathspec
     +			struct strbuf path = STRBUF_INIT;
     +			strbuf_addstr(&path, base->buf + tn_len);
     +
    -+			if (!in_sparse_checkout(&path, old_baselen - tn_len,
    -+						entry.mode, repo->index,
    -+						sparsity, default_sparsity_match,
    -+						&sparsity_match)) {
    ++			if (!path_in_sparse_checkout(&path, old_baselen - tn_len,
    ++						     entry.mode, repo->index,
    ++						     sparsity, default_sparsity_match,
    ++						     &sparsity_match)) {
     +				strbuf_setlen(base, old_baselen);
     +				continue;
     +			}
    @@ t/t7817-grep-sparse-checkout.sh (new)
     +`-- sub2
     +    `-- a
     +
    -+Where . has non-cone mode sparsity patterns, sub is a submodule with cone mode
    -+sparsity patterns and sub2 is a submodule that is excluded by the superproject
    -+sparsity patterns. The resulting sparse checkout should leave the following
    -+structure on the working tree:
    ++Where the outer repository has non-cone mode sparsity patterns, sub is a
    ++submodule with cone mode sparsity patterns and sub2 is a submodule that is
    ++excluded by the superproject sparsity patterns. The resulting sparse checkout
    ++should leave the following structure in the working tree:
     +
     +.
     +|-- a
    @@ t/t7817-grep-sparse-checkout.sh (new)
     +	test_path_is_file sub2/a
     +'
     +
    -+# The test bellow checks a special case: the sparsity patterns exclude '/b'
    -+# and sparse checkout is enable, but the path exists on the working tree (e.g.
    ++# The test below checks a special case: the sparsity patterns exclude '/b'
    ++# and sparse checkout is enabled, but the path exists in the working tree (e.g.
     +# manually created after `git sparse-checkout init`). In this case, grep should
     +# skip it.
     +test_expect_success 'grep in working tree should honor sparse checkout' '
    @@ t/t7817-grep-sparse-checkout.sh (new)
     +	test_cmp expect actual
     +'
     +
    ++test_expect_success 'grep unmerged file despite not matching sparsity patterns' '
    ++	cat >expect <<-EOF &&
    ++	b:modified-b-in-branchX
    ++	b:modified-b-in-branchY
    ++	EOF
    ++	test_when_finished "test_might_fail git merge --abort && \
    ++			    git checkout master" &&
    ++
    ++	git sparse-checkout disable &&
    ++	git checkout -b branchY master &&
    ++	test_commit modified-b-in-branchY b &&
    ++	git checkout -b branchX master &&
    ++	test_commit modified-b-in-branchX b &&
    ++
    ++	git sparse-checkout init &&
    ++	test_path_is_missing b &&
    ++	test_must_fail git merge branchY &&
    ++	git grep "modified-b" >actual &&
    ++	test_cmp expect actual
    ++'
    ++
     +test_expect_success 'grep --cached should honor sparse checkout' '
     +	cat >expect <<-EOF &&
     +	a:text
5:  02990a6fa1 ! 6:  4547718b60 config: add setting to ignore sparsity patterns in some cmds
    @@ Documentation/config.txt: include::config/sequencer.txt[]
      
      include::config/ssh.txt[]
     
    + ## Documentation/config/grep.txt ##
    +@@ Documentation/config/grep.txt: grep.fullName::
    + grep.fallbackToNoIndex::
    + 	If set to true, fall back to git grep --no-index if git grep
    + 	is executed outside of a git repository.  Defaults to false.
    ++
    ++ifdef::git-grep[]
    ++sparse.restrictCmds::
    ++	See base definition in linkgit:git-config[1]. grep honors
    ++	sparse.restrictCmds by limiting searches to the sparsity paths in three
    ++	cases: when searching the working tree, when searching the index with
    ++	--cached, and when searching a specified commit.
    ++endif::git-grep[]
    +
      ## Documentation/config/sparse.txt (new) ##
     @@
     +sparse.restrictCmds::
    @@ Documentation/config/sparse.txt (new)
     +to the paths specified by the sparsity patterns, or to the intersection of
     +those paths and any (like `*.c`) that the user might also specify on the
     +command line. When false, the affected commands will work on full trees,
    -+ignoring the sparsity patterns. For now, only git-grep honors this setting. In
    -+this command, the restriction takes effect in three cases: with --cached; when
    -+a commit-ish is given; when searching a working tree where some paths excluded
    -+by the sparsity patterns are present (e.g. manually created paths or not
    -+removed submodules).
    ++ignoring the sparsity patterns. For now, only git-grep honors this setting.
     ++
     +Note: commands which export, integrity check, or create history will always
     +operate on full trees (e.g. fast-export, format-patch, fsck, commit, etc.),
    -+unaffected by any sparsity patterns. Also, writting commands such as
    ++unaffected by any sparsity patterns. Also, writing commands such as
     +sparse-checkout and read-tree will not be affected by this configuration.
     
    - ## Documentation/git-grep.txt ##
    -@@ Documentation/git-grep.txt: characters.  An empty string as search expression matches all lines.
    - CONFIGURATION
    - -------------
    - 
    -+git-grep honors the sparse.restrictCmds setting. See its definition in
    -+linkgit:git-config[1].
    -+
    - :git-grep: 1
    - include::config/grep.txt[]
    - 
    -
      ## Documentation/git.txt ##
     @@ Documentation/git.txt: If you just want to run git as if it was started in `<path>` then use
      	Do not perform optional operations that require locks. This is
    @@ contrib/completion/git-completion.bash: __git_main ()
      		*)
     
      ## git.c ##
    -@@ git.c: const char git_more_info_string[] =
    - 	   "See 'git help git' for an overview of the system.");
    - 
    - static int use_pager = -1;
    -+int opt_restrict_to_sparse_paths = -1;
    - 
    - static void list_builtins(struct string_list *list, unsigned int exclude_option);
    +@@
    + #include "run-command.h"
    + #include "alias.h"
    + #include "shallow.h"
    ++#include "sparse-checkout.h"
      
    + #define RUN_SETUP		(1<<0)
    + #define RUN_SETUP_GENTLY	(1<<1)
     @@ git.c: static int handle_options(const char ***argv, int *argc, int *envchanged)
      			} else {
      				exit(list_cmds(cmd));
    @@ git.c: static int handle_options(const char ***argv, int *argc, int *envchanged)
      		} else {
      			fprintf(stderr, _("unknown option: %s\n"), cmd);
      			usage(git_usage_string);
    -@@ git.c: static int handle_options(const char ***argv, int *argc, int *envchanged)
    - 		(*argv)++;
    - 		(*argc)--;
    - 	}
    -+
    - 	return (*argv) - orig_argv;
    - }
    - 
     
      ## sparse-checkout.c (new) ##
     @@
    @@ sparse-checkout.c (new)
     +#include "config.h"
     +#include "sparse-checkout.h"
     +
    ++int opt_restrict_to_sparse_paths = -1;
    ++
     +int restrict_to_sparse_paths(struct repository *repo)
     +{
     +	int ret;
    @@ sparse-checkout.h (new)
     +
     +struct repository;
     +
    -+extern int opt_restrict_to_sparse_paths; /* from git.c */
    ++extern int opt_restrict_to_sparse_paths;
     +
     +/* Whether or not cmds should restrict behavior on sparse paths, in this repo */
     +int restrict_to_sparse_paths(struct repository *repo);
    @@ t/t7817-grep-sparse-checkout.sh: test_expect_success 'setup' '
      	test_path_is_file sub2/a
      '
      
    --# The test bellow checks a special case: the sparsity patterns exclude '/b'
    -+# The two tests bellow check a special case: the sparsity patterns exclude '/b'
    - # and sparse checkout is enable, but the path exists on the working tree (e.g.
    +-# The test below checks a special case: the sparsity patterns exclude '/b'
    ++# The two tests below check a special case: the sparsity patterns exclude '/b'
    + # and sparse checkout is enabled, but the path exists in the working tree (e.g.
      # manually created after `git sparse-checkout init`). In this case, grep should
     -# skip it.
     +# skip the file by default, but not with --no-restrict-to-sparse-paths.
    @@ t/t7817-grep-sparse-checkout.sh: test_expect_success 'grep in working tree shoul
     +	test_cmp expect actual
     +'
      
    - test_expect_success 'grep --cached should honor sparse checkout' '
    + test_expect_success 'grep unmerged file despite not matching sparsity patterns' '
      	cat >expect <<-EOF &&
     @@ t/t7817-grep-sparse-checkout.sh: test_expect_success 'grep <tree-ish> should ignore sparsity patterns' '
      '
    @@ t/t7817-grep-sparse-checkout.sh: test_expect_success 'grep --recurse-submodules
     +	'
     +done
     +
    -+test_expect_success 'grep --recurse-submodules --cached \w --no-restrict-to-sparse-paths' '
    ++test_expect_success 'grep --recurse-submodules --cached w/ --no-restrict-to-sparse-paths' '
     +	cat >expect <<-EOF &&
     +	a:text
     +	b:text
    @@ t/t7817-grep-sparse-checkout.sh: test_expect_success 'grep --recurse-submodules
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'grep --recurse-submodules <commit-ish> \w --no-restrict-to-sparse-paths' '
    ++test_expect_success 'grep --recurse-submodules <commit-ish> w/ --no-restrict-to-sparse-paths' '
     +	commit=$(git rev-parse HEAD) &&
     +	cat >expect_commit <<-EOF &&
     +	$commit:a:text
-- 
2.26.2


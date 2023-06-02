Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33606C7EE24
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 14:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbjFBO3g (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 10:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbjFBO3d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 10:29:33 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D172E51
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 07:29:22 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3078a3f3b5fso2115257f8f.0
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 07:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685716160; x=1688308160;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jU9peHLAtAIZMLzp7t+Qy0YvWUW2s4wEPel/pHzBQ6Q=;
        b=MSYi+StYemXarjbo23t6wghorFlc9RK1VyRoum0Hgn+JjPanDzdOly4E8DwZIuc8pu
         SSpADBFNikSwoSJqIiLLAwFIU8PiJ5cwl4pGZOxPQZtY8doXRZhAtFgGG0WcK8WIJfdh
         WaMSddNBBR/UrPx9DJKtJNy0K3o4a8U1Z9VbXZTqsPTSEClBoQBuTBlX61+9z49Mc8aP
         7xi7ipcnF6vkqZPIFctxKQFMSm+3fiW/4j1cSRm9ADsD8j5A2m3RSsqlMmDc2xVlHgk1
         ZX4iA1iyy1WT8c6lgC8uTvpJ3XmMNMxryFf5RD3pIET3McBZR8cNxpMggYXapQzcnK7H
         HRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685716160; x=1688308160;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jU9peHLAtAIZMLzp7t+Qy0YvWUW2s4wEPel/pHzBQ6Q=;
        b=HLgdpTDAJPlIYyrCCMmgwHBh4q41nxETnixAARGlayFvBCEPiUd5SiQj4/wazaJ03W
         KVzzGn6Mo0rROdkcKZFtZFu6XLZDcJEOeUQNbUHZBqoBHgJ68yaqz6AjqeVtJKcH3xnp
         pMj4+PHSLRM2ubxh98R2Yw+6Y/jkgjww5dl3c1kjH850R93k51adJouLX4Q3vTJ56RMR
         G9EGqeMse28Cf7foKqoB5EAxUJnIAYMCY7x8U8/yf7na71gh6lIYcCJKQ/lM/F+TyPky
         GKpxfFUx4F+ncS05zH6DDe0vW0/WN6qCHpxUnhXHRLKt/VfXVvMRKymsNO+gV42JuzjM
         QSTA==
X-Gm-Message-State: AC+VfDxYN7OmThwJ5mugnHmoH/6ssJITdswLc3oAJ/MHCP1BaR2FDUv0
        4h2NQyN3BKv3qFLg8+LEO68Y0oRycuA=
X-Google-Smtp-Source: ACHHUZ6VMcJBNZEv+Pf1aHof8JyKxAWiBABmA+jF1JsjG4jMCJfios3onH4rDFh+LgDBQKz16yecTA==
X-Received: by 2002:a5d:5488:0:b0:306:2de6:6f9b with SMTP id h8-20020a5d5488000000b003062de66f9bmr99289wrv.58.1685716160018;
        Fri, 02 Jun 2023 07:29:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j6-20020a5d6186000000b002ffbf2213d4sm1842462wru.75.2023.06.02.07.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 07:29:19 -0700 (PDT)
Message-Id: <pull.1537.v2.git.1685716157.gitgitgadget@gmail.com>
In-Reply-To: <pull.1537.git.1685126617.gitgitgadget@gmail.com>
References: <pull.1537.git.1685126617.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 02 Jun 2023 14:29:14 +0000
Subject: [PATCH v2 0/3] Create stronger guard rails on replace refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     vdye@github.com, me@ttaylorr.com, newren@gmail.com,
        gitster@pobox.com, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(This series is based on tb/pack-bitmap-traversal-with-boundary due to
wanting to modify prepare_repo_settings() in a similar way.)

The replace-refs can be ignored via the core.useReplaceRefs=false config
setting. This setting is possible to miss in some Git commands if they do
not load default config at the appropriate time. See [1] for a recent
example of this.

[1]
https://lore.kernel.org/git/pull.1530.git.1683745654800.gitgitgadget@gmail.com/

This series aims to avoid this kind of error from happening in the future.
The idea is to encapsulate the setting in such a way that we can guarantee
that config has been checked before using the in-memory value.

Further, we must be careful that some Git commands want to disable replace
refs unconditionally, as if GIT_NO_REPLACE_REFS was enabled in the
environment.

The approach taken here is to split the global into two different sources.
First, read_replace_refs is kept (but moved to replace-objects.c scope) and
reflects whether or not the feature is permitted by the environment and the
current command. Second, a new value is added to repo-settings and this is
checked after using prepare_repo_settings() to guarantee the config has been
read.

This presents a potential behavior change, in that now core.useReplaceRefs
is specific to each in-memory repository instead of applying the
superproject value to all submodules. I could not find a Git command that
has multiple in-memory repositories and follows OIDs to object contents, so
I'm not sure how to demonstrate it in a test.

Here is the breakdown of the series:

 * Patch 1 creates disable_replace_refs() to encapsulate the global
   disabling of the feature.
 * Patch 2 creates replace_refs_enabled() to check if the feature is enabled
   (with respect to a given repository). This is a thin wrapper of the
   global at this point, but does allow us to remove it from environment.h.
 * Patch 3 creates the value in repo-settings as well as ensures that the
   repo settings have been prepared before accessing the value within
   replace_refs_enabled(). A test is added to demonstrate how the config
   value is now scoped on a per-repository basis.


Updates in v2
=============

Thanks for the careful review on v1!

 * disable_replace_refs() now replaces "read_replace_refs = 0" in the exact
   same line to avoid possible behavior change.
 * Stale comments, include headers, and commit messages are updated to
   include the latest status.
 * Patch 3 contains a test of the repo-scoped value using 'git grep'.

Thanks, -Stolee

Derrick Stolee (3):
  repository: create disable_replace_refs()
  replace-objects: create wrapper around setting
  repository: create read_replace_refs setting

 builtin/cat-file.c                 |  2 +-
 builtin/commit-graph.c             |  2 +-
 builtin/fsck.c                     |  2 +-
 builtin/index-pack.c               |  2 +-
 builtin/pack-objects.c             |  2 +-
 builtin/prune.c                    |  2 +-
 builtin/replace.c                  |  2 +-
 builtin/unpack-objects.c           |  2 +-
 builtin/upload-pack.c              |  2 +-
 commit-graph.c                     |  4 +--
 config.c                           |  5 ----
 environment.c                      |  3 +--
 git.c                              |  2 +-
 log-tree.c                         |  2 +-
 replace-object.c                   | 23 ++++++++++++++++-
 replace-object.h                   | 31 ++++++++++++++++-------
 repo-settings.c                    |  1 +
 repository.h                       |  9 +++++++
 t/t7814-grep-recurse-submodules.sh | 40 ++++++++++++++++++++++++++++++
 19 files changed, 107 insertions(+), 31 deletions(-)


base-commit: b0afdce5dab61f224fd66c13768facc36a7f8705
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1537%2Fderrickstolee%2Freplace-refs-safety-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1537/derrickstolee/replace-refs-safety-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1537

Range-diff vs v1:

 1:  56544abc15d ! 1:  0616fdbf303 repository: create disable_replace_refs()
     @@ Commit message
          transition by abstracting the purpose of these global assignments with a
          method call.
      
     -    We will never scope this to an in-memory repository as we want to make
     -    sure that we never use replace refs throughout the life of the process
     -    if this method is called.
     +    We will need to keep this read_replace_refs global forever, as we want
     +    to make sure that we never use replace refs throughout the life of the
     +    process if this method is called. Future changes may present a
     +    repository-scoped version of the variable to represent that repository's
     +    core.useReplaceRefs config value, but a zero-valued read_replace_refs
     +    will always override such a setting.
      
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
     @@ builtin/cat-file.c: static int batch_objects(struct batch_options *opt)
       		cb.expand = &data;
      
       ## builtin/commit-graph.c ##
     -@@ builtin/commit-graph.c: static int graph_verify(int argc, const char **argv, const char *prefix)
     - 	return ret;
     - }
     - 
     --extern int read_replace_refs;
     - static struct commit_graph_opts write_opts;
     - 
     - static int write_option_parse_split(const struct option *opt, const char *arg,
      @@ builtin/commit-graph.c: int cmd_commit_graph(int argc, const char **argv, const char *prefix)
     - 	struct option *options = parse_options_concat(builtin_commit_graph_options, common_opts);
       
       	git_config(git_default_config, NULL);
     --
     + 
      -	read_replace_refs = 0;
     ++	disable_replace_refs();
       	save_commit_buffer = 0;
       
       	argc = parse_options(argc, argv, prefix, options,
     - 			     builtin_commit_graph_usage, 0);
     - 	FREE_AND_NULL(options);
     - 
     -+	disable_replace_refs();
     -+
     - 	return fn(argc, argv, prefix);
     - }
      
       ## builtin/fsck.c ##
      @@ builtin/fsck.c: int cmd_fsck(int argc, const char **argv, const char *prefix)
     @@ builtin/fsck.c: int cmd_fsck(int argc, const char **argv, const char *prefix)
       
       	errors_found = 0;
      -	read_replace_refs = 0;
     ++	disable_replace_refs();
       	save_commit_buffer = 0;
       
       	argc = parse_options(argc, argv, prefix, fsck_opts, fsck_usage, 0);
     -@@ builtin/fsck.c: int cmd_fsck(int argc, const char **argv, const char *prefix)
     - 
     - 	git_config(git_fsck_config, &fsck_obj_options);
     - 	prepare_repo_settings(the_repository);
     -+	disable_replace_refs();
     - 
     - 	if (connectivity_only) {
     - 		for_each_loose_object(mark_loose_for_connectivity, NULL, 0);
      
       ## builtin/index-pack.c ##
      @@ builtin/index-pack.c: int cmd_index_pack(int argc, const char **argv, const char *prefix)
     @@ builtin/pack-objects.c: int cmd_pack_objects(int argc, const char **argv, const
       		BUG("too many dfs states, increase OE_DFS_STATE_BITS");
       
      -	read_replace_refs = 0;
     --
     - 	sparse = git_env_bool("GIT_TEST_PACK_SPARSE", -1);
      +	disable_replace_refs();
     + 
     + 	sparse = git_env_bool("GIT_TEST_PACK_SPARSE", -1);
       	if (the_repository->gitdir) {
     - 		prepare_repo_settings(the_repository);
     - 		if (sparse < 0)
      
       ## builtin/prune.c ##
      @@ builtin/prune.c: int cmd_prune(int argc, const char **argv, const char *prefix)
     @@ builtin/prune.c: int cmd_prune(int argc, const char **argv, const char *prefix)
       	expire = TIME_MAX;
       	save_commit_buffer = 0;
      -	read_replace_refs = 0;
     ++	disable_replace_refs();
       	repo_init_revisions(the_repository, &revs, prefix);
       
       	argc = parse_options(argc, argv, prefix, options, prune_usage, 0);
     -@@ builtin/prune.c: int cmd_prune(int argc, const char **argv, const char *prefix)
     - 	if (repository_format_precious_objects)
     - 		die(_("cannot prune in a precious-objects repo"));
     - 
     -+	disable_replace_refs();
     -+
     - 	while (argc--) {
     - 		struct object_id oid;
     - 		const char *name = *argv++;
      
       ## builtin/replace.c ##
      @@ builtin/replace.c: int cmd_replace(int argc, const char **argv, const char *prefix)
     @@ builtin/replace.c: int cmd_replace(int argc, const char **argv, const char *pref
       	};
       
      -	read_replace_refs = 0;
     ++	disable_replace_refs();
       	git_config(git_default_config, NULL);
       
       	argc = parse_options(argc, argv, prefix, options, git_replace_usage, 0);
     - 
     -+	disable_replace_refs();
     -+
     - 	if (!cmdmode)
     - 		cmdmode = argc ? MODE_REPLACE : MODE_LIST;
     - 
      
       ## builtin/unpack-objects.c ##
      @@ builtin/unpack-objects.c: int cmd_unpack_objects(int argc, const char **argv, const char *prefix UNUSED)
     @@ builtin/unpack-objects.c: int cmd_unpack_objects(int argc, const char **argv, co
       	struct object_id oid;
       
      -	read_replace_refs = 0;
     --
     - 	git_config(git_default_config, NULL);
      +	disable_replace_refs();
       
     - 	quiet = !isatty(2);
     + 	git_config(git_default_config, NULL);
       
      
       ## builtin/upload-pack.c ##
     @@ builtin/upload-pack.c: int cmd_upload_pack(int argc, const char **argv, const ch
       
       	packet_trace_identity("upload-pack");
      -	read_replace_refs = 0;
     ++	disable_replace_refs();
       
       	argc = parse_options(argc, argv, prefix, options, upload_pack_usage, 0);
       
     -@@ builtin/upload-pack.c: int cmd_upload_pack(int argc, const char **argv, const char *prefix)
     - 	if (!enter_repo(dir, strict))
     - 		die("'%s' does not appear to be a git repository", dir);
     - 
     -+	disable_replace_refs();
     -+
     - 	switch (determine_protocol_version_server()) {
     - 	case protocol_v2:
     - 		if (advertise_refs)
      
       ## environment.c ##
      @@ environment.c: void setup_git_env(const char *git_dir)
     @@ replace-object.h: static inline const struct object_id *lookup_replace_object(st
      +void disable_replace_refs(void);
      +
       #endif /* REPLACE_OBJECT_H */
     -
     - ## repo-settings.c ##
     -@@
     - #include "repository.h"
     - #include "midx.h"
     - #include "compat/fsmonitor/fsm-listen.h"
     -+#include "environment.h"
     - 
     - static void repo_cfg_bool(struct repository *r, const char *key, int *dest,
     - 			  int def)
 2:  5fc2f923d9e = 2:  0831e7f8b5e replace-objects: create wrapper around setting
 3:  481a81a515e ! 3:  4c7dbeb8c6d repository: create read_replace_refs setting
     @@ Commit message
          then it would now respect the core.useReplaceRefs config value in each
          repository.
      
     -    Unfortunately, the existing processes that recurse into submodules do
     -    not appear to follow object IDs to their contents, so this behavior
     -    change is not visible in the current implementation. It is something
     -    valuable for future behavior changes.
     +    'git grep --recurse-submodules' is such a command that recurses into
     +    submodules in-process. We can demonstrate the granularity of this config
     +    value via a test in t7814.
      
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
     @@ repository.h: struct repo_settings {
       	int pack_use_bitmap_boundary_traversal;
       
      +	/*
     -+	 * Do replace refs need to be checked this run?  This variable is
     -+	 * initialized to true unless --no-replace-object is used or
     -+	 * $GIT_NO_REPLACE_OBJECTS is set, but is set to false by some
     -+	 * commands that do not want replace references to be active.
     ++	 * Has this repository have core.useReplaceRefs=true (on by
     ++	 * default)? This provides a repository-scoped version of this
     ++	 * config, though it could be disabled process-wide via some Git
     ++	 * builtins or the --no-replace-objects option. See
     ++	 * replace_refs_enabled() for more details.
      +	 */
      +	int read_replace_refs;
      +
       	struct fsmonitor_settings *fsmonitor; /* lazily loaded */
       
       	int index_version;
     +
     + ## t/t7814-grep-recurse-submodules.sh ##
     +@@ t/t7814-grep-recurse-submodules.sh: test_expect_success 'grep partially-cloned submodule' '
     + 	)
     + '
     + 
     ++test_expect_success 'check scope of core.useReplaceRefs' '
     ++	git init base &&
     ++	git init base/sub &&
     ++
     ++	echo A >base/a &&
     ++	echo B >base/b &&
     ++	echo C >base/sub/c &&
     ++	echo D >base/sub/d &&
     ++
     ++	git -C base/sub add c d &&
     ++	git -C base/sub commit -m "Add files" &&
     ++
     ++	git -C base submodule add ./sub &&
     ++	git -C base add a b sub &&
     ++	git -C base commit -m "Add files and submodule" &&
     ++
     ++	A=$(git -C base rev-parse HEAD:a) &&
     ++	B=$(git -C base rev-parse HEAD:b) &&
     ++	C=$(git -C base/sub rev-parse HEAD:c) &&
     ++	D=$(git -C base/sub rev-parse HEAD:d) &&
     ++
     ++	git -C base replace $A $B &&
     ++	git -C base/sub replace $C $D &&
     ++
     ++	test_must_fail git -C base grep --cached --recurse-submodules A &&
     ++	test_must_fail git -C base grep --cached --recurse-submodules C &&
     ++
     ++	git -C base config core.useReplaceRefs false &&
     ++	git -C base grep --recurse-submodules A &&
     ++	test_must_fail git -C base grep --cached --recurse-submodules C &&
     ++
     ++	git -C base/sub config core.useReplaceRefs false &&
     ++	git -C base grep --cached --recurse-submodules A &&
     ++	git -C base grep --cached --recurse-submodules C &&
     ++
     ++	git -C base config --unset core.useReplaceRefs &&
     ++	test_must_fail git -C base grep --cached --recurse-submodules A &&
     ++	git -C base grep --cached --recurse-submodules C
     ++'
     ++
     + test_done

-- 
gitgitgadget

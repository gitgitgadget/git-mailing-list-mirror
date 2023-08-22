Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE733EE49A3
	for <git@archiver.kernel.org>; Tue, 22 Aug 2023 17:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjHVRYW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Aug 2023 13:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHVRYV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2023 13:24:21 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3854027D
        for <git@vger.kernel.org>; Tue, 22 Aug 2023 10:24:19 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe4cdb727cso45703245e9.0
        for <git@vger.kernel.org>; Tue, 22 Aug 2023 10:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692725058; x=1693329858;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3RVz0eWPpQTQb8wyGgNtsCV30o/t/4xk/gWiuWEOwA=;
        b=hww6+Ms7PkAt7SoBK6AVAfXNMirrTeubfROhOJsKQw72fDfVowATU/jSdiMdC5HneD
         IUBuK92nFuaHaGoTUZoQeVLcaBADYAFf6UqwHmULQn0QZiG/hyBnIcCjHOxS+wfqbn+E
         AmibLaq8gCn98Qf6lyNVeZsANymigcv1AU49EmMAZheUT0q+Q59EM+DCUf3h1P7qnSbp
         ukrv4CkYukPAlLY538tnKGvmBJ+3z2v9yoOPp8ilaFEDjAmyTWgnLp0zFIXjwdX4tqyw
         kMNQYOzNOeBIGEjKmjZlznK/ICQd6h0thaULDTeFesxAV0Ve65FunroEcVaxnFaaeiDB
         Ir7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692725058; x=1693329858;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3RVz0eWPpQTQb8wyGgNtsCV30o/t/4xk/gWiuWEOwA=;
        b=aj9krsvzySQIvnlp+mslvA5RDNQeWgi+LxoXmM1Yt0CrI7DaxORMzpoyqKna+/2dqV
         nchNFptple/2AX/BAoi7A6WW0C6j/u2WI6glsuHeUD4P6ML7LFl2xChlFcIv3oLX/j3Y
         4eSF7JLVYSutbpRMy0NAZ/3gYhlDTvRun8QgAO1ZmxcIiqoQlR7mb0XWnE4W0dZ6VxVN
         jQID/YxqEh17NLJgOkXi523gQR363iVT73hMLYrXocSe0IPULYCLD/I8HtGlxMbbAJ88
         SCIvUsGK0XtbwHC7qY7Dh2hw7SgeXOZfgH+isV1rBWqsJ1W9VWIGBBVJ74bzIC9Z03qR
         9zLQ==
X-Gm-Message-State: AOJu0YxnHR9vm2r4GcWFtoVHMBEu669Ay2Oqadx2osp6cxhbZurHsMbB
        LLCFGxpbmAmiTkGzKdw8Y9E1SzuXFro=
X-Google-Smtp-Source: AGHT+IHlPuFRLVbiNNm7lrCNm9FGikPtX6WOktUJcsPtjCzMipJxwNiX+yqWxq5DFlgqWrIh4pxiFA==
X-Received: by 2002:a05:600c:4617:b0:3fe:d5a4:43cf with SMTP id m23-20020a05600c461700b003fed5a443cfmr8141225wmo.38.1692725057365;
        Tue, 22 Aug 2023 10:24:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i4-20020a5d6304000000b0031431fb40fasm16422157wru.89.2023.08.22.10.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 10:24:17 -0700 (PDT)
Message-ID: <pull.1569.v2.git.1692725056.gitgitgadget@gmail.com>
In-Reply-To: <pull.1569.git.1692025937.gitgitgadget@gmail.com>
References: <pull.1569.git.1692025937.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Aug 2023 17:24:12 +0000
Subject: [PATCH v2 0/3] scalar: two downstream improvements
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While updating git-for-windows/git and microsoft/git for the 2.42.0 release
window, a few patches that we've been running in those forks for a while
came to light as something that would be beneficial to the core Git project.
Here are some that are focused on the 'scalar' command.

 * Patch 1 adds a --no-src option to scalar clone to appease users who want
   to use scalar but object to the creation of the src directory.
 * Patches 2 and 3 help when scalar reconfigure -a fails. Patch 2 is a
   possibly helpful change on its own for other uses in the future.


Updates in V2
=============

Thanks, Junio, for the helpful review!

 * In Patch 1, the '--[no-]src' documentation is tightened and the tests
   check the contents of the repository worktree.
 * In Patch 2, the commit message is reworded to be more clear about
   positive values of the enum.
 * In Patch 2, the GIT_DIR_NONE option of the enum is never returned, so it
   does not need to exist. A case in scalar.c referenced it, so it is
   removed as part of the patch (though that case was removed later by patch
   3 anyway).
 * In Patch 2, the discover_git_directory() wrapper is updated to return -1
   instead of 1, as it did before this patch.
 * In Patch 3, the 'failed' variable is renamed to 'succeeded' and the cases
   that update the value are swapped. The return code is set to -1 for any
   error instead of having a custom value based on the return from error()
   or error_errno().

Thanks, -Stolee

Derrick Stolee (3):
  scalar: add --[no-]src option
  setup: add discover_git_directory_reason()
  scalar reconfigure: help users remove buggy repos

 Documentation/scalar.txt |  8 ++++-
 scalar.c                 | 65 +++++++++++++++++++++++++++++-----------
 setup.c                  | 34 ++++++++-------------
 setup.h                  | 35 ++++++++++++++++++++--
 t/t9211-scalar-clone.sh  | 12 ++++++++
 5 files changed, 110 insertions(+), 44 deletions(-)


base-commit: a82fb66fed250e16d3010c75404503bea3f0ab61
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1569%2Fderrickstolee%2Fscalar-no-src-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1569/derrickstolee/scalar-no-src-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1569

Range-diff vs v1:

 1:  c1c7e2f049e ! 1:  0b6957beccb scalar: add --[no-]src option
     @@ Documentation/scalar.txt: remote-tracking branch for the branch this option was
       `--single-branch` clone was made, no remote-tracking branch is created.
       
      +--[no-]src::
     -+	Specify if the repository should be created within a `src` directory
     -+	within `<enlistment>`. This is the default behavior, so use
     -+	`--no-src` to opt-out of the creation of the `src` directory.
     ++	By default, `scalar clone` places the cloned repository within a
     ++	`<entlistment>/src` directory. Use `--no-src` to place the cloned
     ++	repository directly in the `<enlistment>` directory.
      +
       --[no-]full-clone::
       	A sparse-checkout is initialized by default. This behavior can be
     @@ t/t9211-scalar-clone.sh: test_expect_success 'scalar clone warns when background
      +	scalar clone --no-src "file://$(pwd)/to-clone" without-src &&
      +
      +	test_path_is_dir with-src/src &&
     -+	test_path_is_missing without-src/src
     ++	test_path_is_missing without-src/src &&
     ++
     ++	(cd with-src/src && ls ?*) >with &&
     ++	(cd without-src && ls ?*) >without &&
     ++	test_cmp with without
      +'
      +
       test_done
 2:  fbba6252aea ! 2:  787af0f9744 setup: add discover_git_directory_reason()
     @@ Commit message
          1. The zero value of the enum is actually GIT_DIR_NONE, so nonpositive
             results are errors.
      
     -    2. There are multiple successful states, so some positive results are
     +    2. There are multiple successful states; positive results are
             successful.
      
     +    It is worth noting that GIT_DIR_NONE is not returned, so we remove this
     +    option from the enum. We must be careful to keep the successful reasons
     +    as positive values, so they are given explicit positive values.
     +    Further, a use in scalar.c was previously impossible, so it is removed.
     +
          Instead of updating all callers immediately, add a new method,
          discover_git_directory_reason(), and convert discover_git_directory() to
          be a thin shim on top of it.
      
     +    One thing that is important to note is that discover_git_directory()
     +    previously returned -1 on error, so let's continue that into the future.
     +    There is only one caller (in scalar.c) that depends on that signedness
     +    instead of a non-zero check, so clean that up, too.
     +
          Because there are extra checks that discover_git_directory_reason() does
          after setup_git_directory_gently_1(), there are other modes that can be
          returned for failure states. Add these modes to the enum, but be sure to
     @@ Commit message
      
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
     + ## scalar.c ##
     +@@ scalar.c: static int cmd_reconfigure(int argc, const char **argv)
     + 				warning(_("removing stale scalar.repo '%s'"),
     + 					dir);
     + 			strbuf_release(&buf);
     +-		} else if (discover_git_directory(&commondir, &gitdir) < 0) {
     +-			warning_errno(_("git repository gone in '%s'"), dir);
     +-			res = -1;
     + 		} else {
     + 			git_config_clear();
     + 
     +
       ## setup.c ##
      @@ setup.c: static const char *allowed_bare_repo_to_string(
       	return NULL;
     @@ setup.c: static enum discovery_result setup_git_directory_gently_1(struct strbuf
       
       	cwd_len = dir.len;
      -	if (setup_git_directory_gently_1(&dir, gitdir, NULL, 0) <= 0) {
     -+	if ((result = setup_git_directory_gently_1(&dir, gitdir, NULL, 0)) <= 0) {
     ++	result = setup_git_directory_gently_1(&dir, gitdir, NULL, 0);
     ++	if (result <= 0) {
       		strbuf_release(&dir);
      -		return -1;
      +		return result;
     @@ setup.c: int discover_git_directory(struct strbuf *commondir,
       
       const char *setup_git_directory_gently(int *nongit_ok)
      @@ setup.c: const char *setup_git_directory_gently(int *nongit_ok)
     + 		}
       		*nongit_ok = 1;
       		break;
     - 	case GIT_DIR_NONE:
     +-	case GIT_DIR_NONE:
      +	case GIT_DIR_CWD_FAILURE:
      +	case GIT_DIR_INVALID_FORMAT:
       		/*
     @@ setup.h: const char *resolve_gitdir_gently(const char *suspect, int *return_erro
      + * from discover_git_directory.
      + */
      +enum discovery_result {
     -+	GIT_DIR_NONE = 0,
     -+	GIT_DIR_EXPLICIT,
     -+	GIT_DIR_DISCOVERED,
     -+	GIT_DIR_BARE,
     ++	GIT_DIR_EXPLICIT = 1,
     ++	GIT_DIR_DISCOVERED = 2,
     ++	GIT_DIR_BARE = 3,
      +	/* these are errors */
      +	GIT_DIR_HIT_CEILING = -1,
      +	GIT_DIR_HIT_MOUNT_POINT = -2,
     @@ setup.h: const char *resolve_gitdir_gently(const char *suspect, int *return_erro
       /*
        * Find the commondir and gitdir of the repository that contains the current
        * working directory, without changing the working directory or other global
     -@@ setup.h: void setup_work_tree(void);
     +  * state. The result is appended to commondir and gitdir.  If the discovered
     +  * gitdir does not correspond to a worktree, then 'commondir' and 'gitdir' will
        * both have the same result appended to the buffer.  The return value is
     -  * either 0 upon success and non-zero if no repository was found.
     +- * either 0 upon success and non-zero if no repository was found.
     ++ * either 0 upon success and -1 if no repository was found.
        */
      -int discover_git_directory(struct strbuf *commondir,
      -			   struct strbuf *gitdir);
      +static inline int discover_git_directory(struct strbuf *commondir,
      +					 struct strbuf *gitdir)
      +{
     -+	return discover_git_directory_reason(commondir, gitdir) <= 0;
     ++	if (discover_git_directory_reason(commondir, gitdir) <= 0)
     ++		return -1;
     ++	return 0;
      +}
      +
       const char *setup_git_directory_gently(int *);
 3:  907410f76c4 ! 3:  7ac7311863d scalar reconfigure: help users remove buggy repos
     @@ scalar.c: static int cmd_reconfigure(int argc, const char **argv)
       	git_config(get_scalar_repos, &scalar_repos);
       
       	for (i = 0; i < scalar_repos.nr; i++) {
     -+		int failed = 0;
     ++		int succeeded = 0;
       		const char *dir = scalar_repos.items[i].string;
       
       		strbuf_reset(&commondir);
     @@ scalar.c: static int cmd_reconfigure(int argc, const char **argv)
       				warning_errno(_("could not switch to '%s'"), dir);
      -				res = -1;
      -				continue;
     -+				failed = -1;
      +				goto loop_end;
       			}
       
     @@ scalar.c: static int cmd_reconfigure(int argc, const char **argv)
       			if (remove_deleted_enlistment(&buf))
      -				res = error(_("could not remove stale "
      -					      "scalar.repo '%s'"), dir);
     -+				failed = error(_("could not remove stale "
     -+						 "scalar.repo '%s'"), dir);
     - 			else
     +-			else
      -				warning(_("removing stale scalar.repo '%s'"),
     ++				error(_("could not remove stale "
     ++					"scalar.repo '%s'"), dir);
     ++			else {
      +				warning(_("removed stale scalar.repo '%s'"),
       					dir);
     ++				succeeded = 1;
     ++			}
       			strbuf_release(&buf);
     --		} else if (discover_git_directory(&commondir, &gitdir) < 0) {
     --			warning_errno(_("git repository gone in '%s'"), dir);
     --			res = -1;
      -		} else {
      -			git_config_clear();
     --
     --			the_repository = &r;
     --			r.commondir = commondir.buf;
     --			r.gitdir = gitdir.buf;
     --
     --			if (set_recommended_config(1) < 0)
     --				res = -1;
      +			goto loop_end;
      +		}
      +
      +		switch (discover_git_directory_reason(&commondir, &gitdir)) {
      +		case GIT_DIR_INVALID_OWNERSHIP:
      +			warning(_("repository at '%s' has different owner"), dir);
     -+			failed = -1;
      +			goto loop_end;
      +
      +		case GIT_DIR_DISCOVERED:
     ++			succeeded = 1;
      +			break;
      +
      +		default:
      +			warning(_("repository not found in '%s'"), dir);
     -+			failed = -1;
      +			break;
      +		}
      +
     @@ scalar.c: static int cmd_reconfigure(int argc, const char **argv)
      +		the_repository = &r;
      +		r.commondir = commondir.buf;
      +		r.gitdir = gitdir.buf;
     -+
     -+		if (set_recommended_config(1) < 0)
     -+			failed = -1;
     -+
     + 
     +-			the_repository = &r;
     +-			r.commondir = commondir.buf;
     +-			r.gitdir = gitdir.buf;
     ++		if (set_recommended_config(1) >= 0)
     ++			succeeded = 1;
     + 
     +-			if (set_recommended_config(1) < 0)
     +-				res = -1;
      +loop_end:
     -+		if (failed) {
     -+			res = failed;
     ++		if (!succeeded) {
     ++			res = -1;
      +			warning(_("to unregister this repository from Scalar, run\n"
      +				  "\tgit config --global --unset --fixed-value scalar.repo \"%s\""),
      +				dir);

-- 
gitgitgadget

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0D8C77B7A
	for <git@archiver.kernel.org>; Thu, 25 May 2023 01:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235529AbjEYBFl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 May 2023 21:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233861AbjEYBFk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2023 21:05:40 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB20FE6
        for <git@vger.kernel.org>; Wed, 24 May 2023 18:05:38 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba81b24b878so3713371276.3
        for <git@vger.kernel.org>; Wed, 24 May 2023 18:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684976738; x=1687568738;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IuvrE3UGRLM3WmUHZrhz1+ZBOlbv3Jq2b+fhy1lPSyU=;
        b=ar9vpd33uch8U+N2aj4Ex65xlKXOaqUjOeNmEX10JQAVqYMFQkt73LsA5wKRQr0o+z
         htzG6/7VdT+a77/UKeNp3H9AJOnJOXp5ZH1V1UQbtlkDqw/zkln4qfPAHeoAXRqvQ5/J
         j5mJqoaeAm2pAWSgmNvqseLTFBJYcYI7t83hqd6Qv4AUXEuBaZRfSxDPtNzRF8YK8dzL
         63rkOhwZ4TBlLzP6qDAvlb/7wo9b1VsWjc+l2x4STAt+P7un8IbeoVmbHBpQJI3Th//b
         GgCWqidwkihswZrSG1jHTukzvKr7MkfHi3EyDoYIIEBtdh+MA6vepcs15ycmM5lBVYi9
         xmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684976738; x=1687568738;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IuvrE3UGRLM3WmUHZrhz1+ZBOlbv3Jq2b+fhy1lPSyU=;
        b=TNaID8IpN2TY6gisLnFFpgcgzg962l77Ca9VbHwudH7dj+Ax/Ad1RAmhRpsAdK5RKo
         G1h5SRbipETj+fW9l8vys+B+lgplWhBdOnPXLk+RhxUaIBTG/lRleu2rCTX6YmWLu7DA
         bXJ2sUewPqhQ1qhvTrMbvkJYyRunn+3bjfjh3faMDM/EzKV4unA9xv+SDqXJzF8E/F6L
         D+wGOi/IRIs0O7eK0LadwlXlCnzqGlWz/sm21G+NcGGYybnzkYJYsXDtE+xOjXhHe6ew
         ctx+giFLuSZwQUZAHvEmRrL8KggR2V7+GHeI9hJnwskM43uLIU4/T4pOIAzwjEBZX4i+
         9AHg==
X-Gm-Message-State: AC+VfDwxCpfDT7MS9pDkQGoX91/s5YpNd31JQfQnkQccK/58KpDs7cdK
        51A2hoT6qriA4vwvwkj06Ya3o7/l8PtWVw==
X-Google-Smtp-Source: ACHHUZ40N3aZSV2nhj59J9UWJTwirNqJwe+2x8fUL84naxpI2R700gyws2MNzRPFAc3bLG/obW+zw8Ow7LX37Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6902:4c8:b0:b9a:703d:e650 with SMTP
 id v8-20020a05690204c800b00b9a703de650mr770631ybs.7.1684976737890; Wed, 24
 May 2023 18:05:37 -0700 (PDT)
Date:   Wed, 24 May 2023 18:05:36 -0700
In-Reply-To: <aead2fe1ce162949fb313a92fe960e5a64512f60.1684883872.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1536.git.1684883872.gitgitgadget@gmail.com> <aead2fe1ce162949fb313a92fe960e5a64512f60.1684883872.git.gitgitgadget@gmail.com>
Message-ID: <kl6ly1ldxlsv.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 1/2] config: use gitdir to get worktree config
From:   Glen Choo <chooglen@google.com>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     derrickstolee@github.com, Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Victoria Dye <vdye@github.com>
>
> Update 'do_git_config_sequence()' to read the worktree config from
> 'config.worktree' in 'opts->git_dir' rather than the gitdir of
> 'the_repository'.

Thanks for the patches! This makes sense. do_git_config_sequence() is
eventually called by repo_config(), which is supposed to read config
into a "struct repository", so any reliance on the_repository's settings
is wrong.

>                                        Note that behavior still isn't ideal
> because 'extensions.worktreeConfig' in the super project[...]

Nit: We typically use "superproject" without the space.

> diff --git a/config.c b/config.c
> index b79baf83e35..a93f7bfa3aa 100644
> --- a/config.c
> +++ b/config.c
> @@ -2200,14 +2200,24 @@ static int do_git_config_sequence(struct config_reader *reader,
>  	char *xdg_config = NULL;
>  	char *user_config = NULL;
>  	char *repo_config;
> +	char *worktree_config;
>  	enum config_scope prev_parsing_scope = reader->parsing_scope;
>  
> -	if (opts->commondir)
> +	/*
> +	 * Ensure that either:
> +	 * - the git_dir and commondir are both set, or
> +	 * - the git_dir and commondir are both NULL
> +	 */
> +	if (!opts->git_dir != !opts->commondir)
> +		BUG("only one of commondir and git_dir is non-NULL");
> +
> +	if (opts->commondir) {
>  		repo_config = mkpathdup("%s/config", opts->commondir);
> -	else if (opts->git_dir)
> -		BUG("git_dir without commondir");
> -	else
> +		worktree_config = mkpathdup("%s/config.worktree", opts->git_dir);
> +	} else {
>  		repo_config = NULL;
> +		worktree_config = NULL;
> +	}

Makes sense to me. I don't see why we would ever want to set one without
the other.

I looked into whether we could get replace opts->commondir and
opts->git_dir with a "struct repository" arg, but unfortunately
read_early_config() needs to pass these values without touching
"the_repository".

> diff --git a/t/t3007-ls-files-recurse-submodules.sh b/t/t3007-ls-files-recurse-submodules.sh
> index dd7770e85de..e35c203241f 100755
> --- a/t/t3007-ls-files-recurse-submodules.sh
> +++ b/t/t3007-ls-files-recurse-submodules.sh
> @@ -299,6 +299,29 @@ test_expect_success '--recurse-submodules does not support --error-unmatch' '
>  	test_i18ngrep "does not support --error-unmatch" actual
>  '
>  
> +test_expect_success '--recurse-submodules parses submodule repo config' '
> +	test_when_finished "git -C submodule config --unset feature.experimental" &&
> +	git -C submodule config feature.experimental "invalid non-boolean value" &&
> +	test_must_fail git ls-files --recurse-submodules 2>err &&
> +	grep "bad boolean config value" err
> +'

This test has a few bits that are important but non-obvious. It would be
useful to capture them in either the commit message or a comment.

Firstly, we can't test this using "git config" because that only uses
the_repository, and we specifically need to read config in-core into a
"struct repository" that is a submodule, so we need a command that
recurses into a submodule without using subprocesses. IIRC the only
choices are "git grep" and "git ls-files".

Secondly, when we test that config is read from the submodule the choice
of "feature.experimental" is quite important. The config is read quite
indirectly: "git ls-files" reads from the submodule's index, which
will call prepare_repo_settings() on the submodule, and eventually calls
repo_config_get_bool() on "feature.experimental". Any of the configs in
prepare_repo_settings() should do, though. A tiny suggestion would be to
use "index.sparse" instead of "feature.experimental", since (I presume)
we'll have to add sparse index + submodule tests for "git ls-files"
eventually.

> +test_expect_success '--recurse-submodules parses submodule worktree config' '
> +	test_when_finished "git -C submodule config --unset extensions.worktreeConfig" &&

I believe "test_config -C" will achieve the desired effect.

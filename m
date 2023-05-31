Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE87AC77B73
	for <git@archiver.kernel.org>; Wed, 31 May 2023 22:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjEaWRf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 May 2023 18:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjEaWRd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2023 18:17:33 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B93E1BC
        for <git@vger.kernel.org>; Wed, 31 May 2023 15:17:10 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-64d60dafa80so129088b3a.3
        for <git@vger.kernel.org>; Wed, 31 May 2023 15:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685571423; x=1688163423;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kEh0VjWAAuDKMSF35Y82cdCzcD00T6AlvnZWVGbGa6k=;
        b=xj3KC0gr9liapYnKrxV8hAUKH2mzMT6ssWsF4ryEWUFR3q0SZGpXKd1yjU5vWJ9d4i
         S6Vty9gqOKvwCYsLL29ozLs794xmaOSCrjJAnY3mO19FsfteyUAYaSM4ZLPjILrbtsyY
         YR4guSi2QhVYeVGzdozaWNcp8hhnrvDyBRvVQIUnPb/H3spC+7yP3B43KNw/yH/Nc3/i
         NcbcNI3l0QUug0ih93/lth+FOdNV1sGBO9C5dZHWrj2u4fGWm36k+AmqxjgDTf8NYw2d
         hskZFiLGjOeRM3RrMLw58ocjOkaI3Gum0LlOZt/iE7t+tvZ+NXkyq9GaWy3vNVi1/n8r
         JSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685571423; x=1688163423;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kEh0VjWAAuDKMSF35Y82cdCzcD00T6AlvnZWVGbGa6k=;
        b=HLGOEOmvZm5VZ8jpo8y7UzTOp93kuggZgj4ul/hJ2xq0GgmbKgFYm+JygIU2ZFKb1L
         JStjHZwFWOsUoAPsSuhPmpW7qCmgT16PQPYXOlDDcBuo8cmAjx0KOLOacfRsBZWUvgUW
         gUl8Jp40AT5HXN4Y+Yo7xunoP6KWlU/THnEvID1HnUl/4gOs7wFVWBRZs5iwLkgxXFfB
         F6CIQhh7GNCK6XFZqhrrDbqpjUs8HuAkR1zE987IsqfVcisp/YniNw5rbv0qk5/L0372
         8xNGs+xLJr8h/4JrZ+lp7fENACuAFSsy9lEBLzJCdUrLc62DTKGJI9dbbdeUE9QOe+w6
         zTqA==
X-Gm-Message-State: AC+VfDxOsK62hk4Vwlx60C2rHdPfqgxYyKM7i2etqXVUrKUotFvCegpi
        I6V7RsfFSZ06D3ms+y2y+o9B9oDhBqV93g==
X-Google-Smtp-Source: ACHHUZ4XSVyO0Prg0pJW2YwoIdE88Q8cCKFoZ1qUvz/fqdLccMkjUzMb2cYpUiigy+BuA4gSQxISVNG6fSccwg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:2316:b0:64c:b6d6:6f60 with SMTP
 id h22-20020a056a00231600b0064cb6d66f60mr2746167pfh.1.1685571423186; Wed, 31
 May 2023 15:17:03 -0700 (PDT)
Date:   Wed, 31 May 2023 15:17:01 -0700
In-Reply-To: <506a2cf8c73549bc8f9761b56532ef08ed220da4.1685064781.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1536.git.1684883872.gitgitgadget@gmail.com>
 <pull.1536.v2.git.1685064781.gitgitgadget@gmail.com> <506a2cf8c73549bc8f9761b56532ef08ed220da4.1685064781.git.gitgitgadget@gmail.com>
Message-ID: <kl6lr0qwno2q.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 3/3] repository: move 'repository_format_worktree_config'
 to repo scope
From:   Glen Choo <chooglen@google.com>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Cc:     derrickstolee@github.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The changes that replace repository_format_worktree_config with "struct
repository".worktree_config look trivially good. The "struct
repository_format" bits track ebaf3bcf1ae (repository: move global
r_f_p_c to repo struct, 2021-06-17) so it preserves the status quo, but
I have some questions about ebaf3bcf1ae. Cc-ing the author (Jonathan
Tan) for context.

Rearranging the hunks for clarity,

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -1560,6 +1562,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  		}
>  		if (startup_info->have_repository) {
>  			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
> +			the_repository->repository_format_worktree_config =
> +				repo_fmt.worktree_config;
>  			/* take ownership of repo_fmt.partial_clone */
>  			the_repository->repository_format_partial_clone =
>  				repo_fmt.partial_clone;

[snip]

> @@ -1651,6 +1655,8 @@ void check_repository_format(struct repository_format *fmt)
>  	check_repository_format_gently(get_git_dir(), fmt, NULL);
>  	startup_info->have_repository = 1;
>  	repo_set_hash_algo(the_repository, fmt->hash_algo);
> +	the_repository->repository_format_worktree_config =
> +		fmt->worktree_config;
>  	the_repository->repository_format_partial_clone =
>  		xstrdup_or_null(fmt->partial_clone);
>  	clear_repository_format(&repo_fmt);

[snip]

> diff --git a/repository.c b/repository.c
> index c53e480e326..104960f8f59 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -182,6 +182,7 @@ int repo_init(struct repository *repo,
>  		goto error;
>  
>  	repo_set_hash_algo(repo, format.hash_algo);
> +	repo->repository_format_worktree_config = format.worktree_config;
>  
>  	/* take ownership of format.partial_clone */
>  	repo->repository_format_partial_clone = format.partial_clone;

This patch adds another instance of copying fields from "struct
repository_format" to "struct repository", so I think that we should
start doing this with a helper function instead of copy-pasting the
logic.

As for what should be in the helper function, the above hunks suggest
that we should copy .hash_algo, .partial_clone, and .worktree_config.
However...

> @@ -1423,6 +1422,9 @@ int discover_git_directory(struct strbuf *commondir,
>  		return -1;
>  	}
>  
> +	the_repository->repository_format_worktree_config =
> +		candidate.worktree_config;
> +
>  	/* take ownership of candidate.partial_clone */
>  	the_repository->repository_format_partial_clone =
>  		candidate.partial_clone;

This hunk does not copy .hash_algo. I initially wondered if it is safe
to just copy .hash_algo here too, but I now suspect that we shouldn't
have done the_repository setup in discover_git_directory() in the first
place. It isn't used by the setup.c machinery - its one caller in "git"
(it's used by "scalar") is read_early_config(), which is supposed to
work without a fully set up repository, and bears a comment saying that
"no global state is changed" by calling discover_git_directory() (which
stopped being true in ebaf3bcf1ae). It looks like
discover_git_directory() is just a lightweight entrypoint into the
setup.c machinery. 16ac8b8db6 (setup: introduce the
discover_git_directory() function, 2017-03-13)) says "Let's just provide
a convenient wrapper function with an easier signature that *just*
discovers the .git/ directory. We will use it in a subsequent patch to
fix the early config."

If I'm wrong and we _should_ be doing the_repository setup, then I'm
guessing it's safe to copy .hash_algo here too. So either way, I think
we should introduce a helper function to do the copying, especially
because we will probably need to repeat this process yet again for
"repository_format_precious_objects".

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 845A91F404
	for <e@80x24.org>; Mon, 11 Dec 2017 19:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752373AbdLKTJv (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 14:09:51 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:37006 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752066AbdLKTJu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 14:09:50 -0500
Received: by mail-it0-f66.google.com with SMTP id d137so18348515itc.2
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 11:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5q2TtcKdMIO2slBwNoUCHR31Su4yJJ5zDddnfnZ2Fcs=;
        b=Em1AxEJ2oLMAxTFeWW8tt9H8h+VYFfAXBqjLJKi3XHTP+vPPYPzPJXyX26b30Xje9P
         T6OkQeHWqAUrUjqgRzItZMYNcfjiAiz4rwHJf6JlaA6Y+0VdkP9SBnTzrbUu1awlkMca
         X2LvIAQZReXXyCeemnpPhmJr4gik03YCqNAn7Iue++FEKAxe1zhkgh5xJ3ZQuoWjlAUf
         iGk2TaJTE6FqcGdCWOd4JM7I/F5DjNaSR+hQ+oV02n0kdukkunRNbs/gFpY1Ne30snw8
         A/ptdpMpqEp8LBnb09lNtVSqkZBsL5Mo0z9OUBx5owNQX7BjlN+tY11q4HcyO6wRWjBl
         97wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5q2TtcKdMIO2slBwNoUCHR31Su4yJJ5zDddnfnZ2Fcs=;
        b=rWyxsNvwmdVi+nJJ0YiSfK85RQPh/ih6jNdnxksvX4vVqPVMyDSSD76hdwAnmKhD+Z
         mMp4y63/DFQxGXzRYrnEFA9IOXwiKz4HmhDMOhikut7BUgaxt8RhrLogxxdzY8ry4ASc
         yVBrHdy8DPuhUGx3MyeJqAS9XMTXqAoJWGc6aXKXBAxIhEWsBXa+GGtXoibhhY09lkui
         h2t24xMYW6kLkWRhNCg6NQbjno26DWTUPNRONn4IBvhcEnPT1ZCKHqyRTjYn24fLEQHU
         UnELRWgd9MV740gHfFdrBmlqwt/QdSEAPZpuTs7gqRNWN8V0F/kupSmTnKIbg9yGAOul
         EBQQ==
X-Gm-Message-State: AKGB3mJUfEdbJJFvBpUUrgGPF/f6CXK+KLOjSP0RgK1skvrG/0JY7fkN
        hi1nX4t2GQ16DA3lZ93qQhAo8g==
X-Google-Smtp-Source: ACJfBotkS+UoRjSkkUQLUR75+Ddj3qyn3AUzYrfv9PSIuakRcoYal6SBxm7Y7dbbV5RQX/sbjPu7VA==
X-Received: by 10.107.174.98 with SMTP id x95mr2106529ioe.241.1513019388598;
        Mon, 11 Dec 2017 11:09:48 -0800 (PST)
Received: from google.com ([2620:0:100e:422:bdc4:e5a2:2ef4:d600])
        by smtp.gmail.com with ESMTPSA id f206sm6462504ioa.32.2017.12.11.11.09.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 11 Dec 2017 11:09:47 -0800 (PST)
Date:   Mon, 11 Dec 2017 11:09:46 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/3] prune: fix pruning with multiple worktrees and split
 index
Message-ID: <20171211190946.GB177995@google.com>
References: <20171210212202.28231-1-t.gummerer@gmail.com>
 <20171210212202.28231-3-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171210212202.28231-3-t.gummerer@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/10, Thomas Gummerer wrote:
> be489d02d2 ("revision.c: --indexed-objects add objects from all
> worktrees", 2017-08-23) made sure that pruning takes objects from all
> worktrees into account.
> 
> It did that by reading the index of every worktree and adding the
> necessary index objects to the set of pending objects.  The index is
> read by read_index_from.  As mentioned in the previous commit,
> read_index_from depends on the CWD for the location of the split index,
> and add_index_objects_to_pending doesn't set that before using
> read_index_from.
> 
> Instead of using read_index_from, use repo_read_index, which is aware of
> the proper paths for the worktree.
> 
> This fixes t5304-prune when ran with GIT_TEST_SPLIT_INDEX set.
> 

I'm on the fence about this change.  I understand that this will ensure
that the proper objects aren't pruned when using a split index in the
presence of worktrees but I think the solution needs to be thought
through a bit more.

My big concern right now is the interaction of 'struct worktree's and
'struct repository'.  I'll try to highlight my concerns below.

> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
> 
> This also fixes t7009 when ran with GIT_TEST_SPLIT_INDEX.  I'm not
> quite sure why it is fixed by this.  Either way I tracked the failure
> down to f767178a5a ("Merge branch 'jk/no-null-sha1-in-cache-tree'",
> 2017-05-16).  Maybe Peff has an idea why this fixes that test?
> 
>  repository.c | 11 +++++++++++
>  repository.h |  2 ++
>  revision.c   | 13 ++++++++-----
>  3 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/repository.c b/repository.c
> index 928b1f553d..3c9bfbd1b8 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -2,6 +2,7 @@
>  #include "repository.h"
>  #include "config.h"
>  #include "submodule-config.h"
> +#include "worktree.h"
>  
>  /* The main repository */
>  static struct repository the_repo = {
> @@ -146,6 +147,16 @@ int repo_init(struct repository *repo, const char *gitdir, const char *worktree)
>  	return -1;
>  }
>  
> +/*
> + * Initialize 'repo' based on the provided worktree
> + * Return 0 upon success and a non-zero value upon failure.
> + */
> +int repo_worktree_init(struct repository *repo, struct worktree *worktree)
> +{
> +	return repo_init(repo, get_worktree_git_dir(worktree),
> +			 worktree->path);
> +}

My first concern is the use of 'get_worktree_git_dir()'.  Under the hood
it calls 'get_git_dir()', 'get_git_common_dir()', and
'git_common_path()' which rely on global state as stored in
'the_repository'.  So how does one initialize a repository struct (using
this initializer) using a worktree from a repository other than the
global 'the_repository' struct?  I'm not sure I have an answer right
now, but its an issue that needs to be thought through before we head
down this road.

Just thinking to myself, Does it make sense to have worktree's as a
separate struct or to have them stored in 'struct repository' in some
way?  Shouldn't a repository struct have a way to interact with all of
its worktrees?  How would initializing a repository struct for every
worktree work once we migrate the object store to be stored in 'struct
repoisotry'?  Shouldn't every worktree share the same object store
in-memory like they do on-disk?

> +
>  /*
>   * Initialize 'submodule' as the submodule given by 'path' in parent repository
>   * 'superproject'.
> diff --git a/repository.h b/repository.h
> index 7f5e24a0a2..2adeb05bf4 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -4,6 +4,7 @@
>  struct config_set;
>  struct index_state;
>  struct submodule_cache;
> +struct worktree;
>  
>  struct repository {
>  	/* Environment */
> @@ -87,6 +88,7 @@ extern struct repository *the_repository;
>  extern void repo_set_gitdir(struct repository *repo, const char *path);
>  extern void repo_set_worktree(struct repository *repo, const char *path);
>  extern int repo_init(struct repository *repo, const char *gitdir, const char *worktree);
> +extern int repo_worktree_init(struct repository *repo, struct worktree *worktree);
>  extern int repo_submodule_init(struct repository *submodule,
>  			       struct repository *superproject,
>  			       const char *path);
> diff --git a/revision.c b/revision.c
> index e2e691dd5a..9d8d9b96d1 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -22,6 +22,7 @@
>  #include "packfile.h"
>  #include "worktree.h"
>  #include "argv-array.h"
> +#include "repository.h"
>  
>  volatile show_early_output_fn_t show_early_output;
>  
> @@ -1346,15 +1347,17 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
>  	worktrees = get_worktrees(0);
>  	for (p = worktrees; *p; p++) {
>  		struct worktree *wt = *p;
> -		struct index_state istate = { NULL };
> +		struct repository *repo;
>  
> +		repo = xmalloc(sizeof(struct repository));

This was allocated but never freed, was that intentional?

>  		if (wt->is_current)
>  			continue; /* current index already taken care of */
> +		if (repo_worktree_init(repo, wt))
> +			BUG("couldn't initialize repository object from worktree");
>  
> -		if (read_index_from(&istate,
> -				    worktree_git_path(wt, "index")) > 0)
> -			do_add_index_objects_to_pending(revs, &istate);
> -		discard_index(&istate);
> +		if (repo_read_index(repo) > 0)
> +			do_add_index_objects_to_pending(revs, repo->index);
> +		discard_index(repo->index);

One we have separate object stores per-repository how would we handle
this since this pruning should only work on a single repository's object
store?

>  	}
>  	free_worktrees(worktrees);
>  }
> -- 
> 2.15.1.504.g5279b80103
> 

-- 
Brandon Williams

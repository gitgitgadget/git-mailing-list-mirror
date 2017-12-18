Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 273291F424
	for <e@80x24.org>; Mon, 18 Dec 2017 18:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938025AbdLRSTW (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 13:19:22 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:45468 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933266AbdLRSTR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 13:19:17 -0500
Received: by mail-it0-f67.google.com with SMTP id z6so29303733iti.4
        for <git@vger.kernel.org>; Mon, 18 Dec 2017 10:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r212rNmxwgGEk50WQWvvhkw6dDngMXqKEVjiWbvPk2w=;
        b=s73/ormmFg1+Fs9q8XLO+qRxtGHIy+8pKtC2WxMl/R1qkJy9+7AkypKimAZMtsM+fq
         bAW6XoBoY25Pb5jdiwoPK3y/t/JsSMFNqMiOmta91LMqE5Tff8G7y6TwU06VgBjLT3k1
         P1iJPgvkAGAOos9F/b1nG+MzkFFPCvAAJraYdJcNC6XWuBpzRTFyXnuEgxIhdnNnACwa
         k/lhhAHj5jUEzBO6VDX33DFKnHWyAzhfy9IYJx9RbNw59fhAlCwmZUdLy6NhMm9ev4A9
         BfKPd98TfOfHIZyjzQt+YoK2nZD1HSSeMpqxjUT6ah/skLwhZRzn+i8GDW3XGjibvQea
         LJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r212rNmxwgGEk50WQWvvhkw6dDngMXqKEVjiWbvPk2w=;
        b=p0ny1MRSomRbFdKl5xIF6/WmQQT12Izw2Jbn5S43cSJOf/IfslnX1e93oI4iRQJmpj
         H0fnSXyfCzOoDTK48HOUamuJUiHUxjwrA0MLxL5StNJF+Cee2wCDgMpCHoPxyuEW0oFO
         WKBaRqAcg7qRJW5OJcbSrRlsezyWMRJ6nQhnSxDqS0GwGWf7RGYALy76MknLzkd+RJgY
         1aXsJPKxTuOxtYuoyQ5CL9nJ8SY06FlFjcArBP89kPqgy5ZPdz3Z52NsEatQaeOpena7
         a9i7F/BEfRlR88Onwo2OquwbgPYnNQL8RmvHWMx87DpBpCNq++g51HPr6FkMxlbfcr9k
         UC5Q==
X-Gm-Message-State: AKGB3mJDF1LFXo7lN9a94D9BEkspwAnqCCunTvcj7QiFvJPjhJomLcVg
        4jLLWZPwL3pjspVJD/ptdr3m4w==
X-Google-Smtp-Source: ACJfBosAbVk2db9SsCXttFoa9zrYI6PZlugnqGyVY4pKJJukeTgMpcsfPgdt4Yol2upMDwOp1HasEA==
X-Received: by 10.36.219.214 with SMTP id c205mr680992itg.65.1513621156405;
        Mon, 18 Dec 2017 10:19:16 -0800 (PST)
Received: from google.com ([2620:0:100e:422:1d4c:2092:ef96:42])
        by smtp.gmail.com with ESMTPSA id g2sm6737852ioa.13.2017.12.18.10.19.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 18 Dec 2017 10:19:15 -0800 (PST)
Date:   Mon, 18 Dec 2017 10:19:13 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 2/3] prune: fix pruning with multiple worktrees and
 split index
Message-ID: <20171218181913.GB147973@google.com>
References: <20171210212202.28231-1-t.gummerer@gmail.com>
 <20171217225122.28941-1-t.gummerer@gmail.com>
 <20171217225122.28941-3-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171217225122.28941-3-t.gummerer@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/17, Thomas Gummerer wrote:
> be489d02d2 ("revision.c: --indexed-objects add objects from all
> worktrees", 2017-08-23) made sure that pruning takes objects from all
> worktrees into account.
> 
> It did that by reading the index of every worktree and adding the
> necessary index objects to the set of pending objects.  The index is
> read by read_index_from.  As mentioned in the previous commit,
> read_index_from depends on the CWD for the location of the split index,

As I mentioned before this doesn't actually depend on the CWD but
rather the per-worktree gitdir.

> and add_index_objects_to_pending doesn't set that before using
> read_index_from.
> 
> Instead of using read_index_from, use repo_read_index, which is aware of
> the proper paths for the worktree.
> 
> This fixes t5304-prune when ran with GIT_TEST_SPLIT_INDEX set.
> 
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  repository.c | 11 +++++++++++
>  repository.h |  2 ++
>  revision.c   | 14 +++++++++-----
>  3 files changed, 22 insertions(+), 5 deletions(-)
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

I still feel very unsettled about this and don't think its a good idea.
get_worktree_git_dir depends implicitly on the global the_repository
object and I would like to avoid relying on it for an initialization
function like this.

> +}
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
> index e2e691dd5a..34e1e4b799 100644
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
> @@ -1346,15 +1347,18 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
>  	worktrees = get_worktrees(0);
>  	for (p = worktrees; *p; p++) {
>  		struct worktree *wt = *p;
> -		struct index_state istate = { NULL };
> +		struct repository *repo;
>  
> +		repo = xmalloc(sizeof(struct repository));
>  		if (wt->is_current)
>  			continue; /* current index already taken care of */
> +		if (repo_worktree_init(repo, wt))
> +			BUG("couldn't initialize repository object from worktree");
>  
> -		if (read_index_from(&istate,
> -				    worktree_git_path(wt, "index")) > 0)

Ok, after thinking this through a bit more I think a better approach may
be to restructure the call to read_index_from to take in both an index
file as well as the explicit gitdir to use when constructing a path to
the sharedindex file.  That way you can fix this for worktrees and
submodules without having to pass in a repository object to the logic
which is reading an index file as well as avoiding needing to init a
repository object for every worktree.

So you could rework the first patch to do something like:

diff --git a/read-cache.c b/read-cache.c
index 2eb81a66b..3a04b5567 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1863,20 +1863,19 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
  * This way, shared index can be removed if they have not been used
  * for some time.
  */
-static void freshen_shared_index(char *base_sha1_hex, int warn)
+static void freshen_shared_index(const char *shared_index, int warn)
 {
-	char *shared_index = git_pathdup("sharedindex.%s", base_sha1_hex);
 	if (!check_and_freshen_file(shared_index, 1) && warn)
 		warning("could not freshen shared index '%s'", shared_index);
-	free(shared_index);
 }
 
-int read_index_from(struct index_state *istate, const char *path)
+int read_index_from(struct index_state *istate, const char *path,
+		    const char *gitdir)
 {
 	struct split_index *split_index;
 	int ret;
 	char *base_sha1_hex;
-	const char *base_path;
+	char *base_path;
 
 	/* istate->initialized covers both .git/index and .git/sharedindex.xxx */
 	if (istate->initialized)
@@ -1896,14 +1895,14 @@ int read_index_from(struct index_state *istate, const char *path)
 		split_index->base = xcalloc(1, sizeof(*split_index->base));
 
 	base_sha1_hex = sha1_to_hex(split_index->base_sha1);
-	base_path = git_path("sharedindex.%s", base_sha1_hex);
+	base_path = xstrfmt("%s/sharedindex.%s", gitdir, base_sha1_hex);
 	ret = do_read_index(split_index->base, base_path, 1);
 	if (hashcmp(split_index->base_sha1, split_index->base->sha1))
 		die("broken index, expect %s in %s, got %s",
 		    base_sha1_hex, base_path,
 		    sha1_to_hex(split_index->base->sha1));
 
-	freshen_shared_index(base_sha1_hex, 0);
+	freshen_shared_index(base_path, 0);
 	merge_base_index(istate);
 	post_read_index_from(istate);
+ free(base_path);
 	return ret;


-- 
Brandon Williams

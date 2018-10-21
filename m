Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C296A1F454
	for <e@80x24.org>; Sun, 21 Oct 2018 15:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbeJVAKM (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Oct 2018 20:10:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33938 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbeJVAKM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Oct 2018 20:10:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id z25-v6so7427683wmf.1
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 08:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aW5U1a0OmEoCks2f+NEcGzGilmnmSTUsxsJSdpfIWAQ=;
        b=HM/3YTr1KbqTcTau3XmxZSkzv9QLvCfzU1ianrNczPuoN9+1UHNY10nsGuM7eyvPXi
         3I5/+08O6OgZHZpnk92UAw0vizLlULQpQupYQI4baGWb3ZxW97M08kj+k7AFWvQB+l/K
         2SonGyknPa/8TpOki2IXgpuidsvQUp0ftTNPpAtu4wzIAbhKDTeTNUmWkaq83zMwmSaq
         UsgbmeWrNRI38d2Ed17qJUpOv5daoLzYnIxH9oXdSlOM+zON+tD1A5LYqdg5EcXbhASz
         t4yXejx6KqgiEArAwJ4PgsQQKzs2/uAHMPznT9b7rBxStw6h3DWpZpn4EFJNs1ZC2eSv
         19kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=aW5U1a0OmEoCks2f+NEcGzGilmnmSTUsxsJSdpfIWAQ=;
        b=Bcj4ySDG3y4q1rvCCWaF15OYy6vsOhfa21nLZJ+qJNF9544HJxtVUrXxYx5ASvNjbj
         qHAWjr8qwxaSaxsNfDi+5O3Jm02DXveoxZmVT0ivrDExlRT454jvH9HCNyF/MVpU5jwM
         2aO0fqYSrI65Q7WWjNygzsqrfk71AFdcKEkr0PPrN1uDLQRWr5SSkgXDIzH+X2KU6Uga
         uH87eauUrwMydJNg54dXJ6Gp40/irs9NtHowCh2+8a+ENt4CgUs5AhFnjwTc5pcqD/CZ
         zxubDMELrSzHK5UrJ0yIXuawQmdli97ZWlFGwKa6QNdyvEwiO0QrSE6lxjnvBNsHlHQQ
         JyfA==
X-Gm-Message-State: ABuFfogyUZ+Gxa8nSEt1NTXPGIefhqneyrS96jHsQjre15hKMi7BPa3L
        cpEoN3NQp2eLTpfu24H/4gg=
X-Google-Smtp-Source: ACcGV63d5e4rpTvxQfSZlLShT2I6fXmaS639n/4gi4Mz+vdYrEqXjKaO+egyNaBRPynIF/LKxa3dCw==
X-Received: by 2002:a1c:9753:: with SMTP id z80-v6mr12713308wmd.1.1540137325288;
        Sun, 21 Oct 2018 08:55:25 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abps207.neoplus.adsl.tpnet.pl. [83.8.60.207])
        by smtp.gmail.com with ESMTPSA id z185-v6sm20836215wmz.47.2018.10.21.08.55.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Oct 2018 08:55:24 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 4/7] revision.c: begin refactoring --topo-order logic
References: <pull.25.v3.git.gitgitgadget@gmail.com>
        <pull.25.v4.git.gitgitgadget@gmail.com>
        <cd9eef96885a811196ab0b851a98de4455b950ab.1539729393.git.gitgitgadget@gmail.com>
Date:   Sun, 21 Oct 2018 17:55:23 +0200
In-Reply-To: <cd9eef96885a811196ab0b851a98de4455b950ab.1539729393.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 16 Oct 2018
        15:36:42 -0700 (PDT)")
Message-ID: <86h8hfguqc.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> When running 'git rev-list --topo-order' and its kin, the topo_order
> setting in struct rev_info implies the limited setting. This means
> that the following things happen during prepare_revision_walk():
>
> * revs->limited implies we run limit_list() to walk the entire
>   reachable set. There are some short-cuts here, such as if we
>   perform a range query like 'git rev-list COMPARE..HEAD' and we
>   can stop limit_list() when all queued commits are uninteresting.

And if revs->topo_order is set, then (with current implementation) we
need limit_list() to run to generate commit_list with commits to be
topologically sorted, which is done by setting revs->limited.

In short, with current code revs->topo_order implies revs->limited.

>
> * revs->topo_order implies we run sort_in_topological_order(). See
>   the implementation of that method in commit.c. It implies that
>   the full set of commits to order is in the given commit_list.

So the current code uses "generate list of commits, then sort it"
approach...

>
> These two methods imply that a 'git rev-list --topo-order HEAD'
> command must walk the entire reachable set of commits _twice_ before
> returning a single result.
>
> If we have a commit-graph file with generation numbers computed, then
> there is a better way.

...instead of generating commits in topological order as you go.

>                        This patch introduces some necessary logic
> redirection when we are in this situation.

O.K., this should make main commit smaller.  All right.

> In v2.18.0, the commit-graph file contains zero-valued bytes in the
> positions where the generation number is stored in v2.19.0 and later.
> Thus, we use generation_numbers_enabled() to check if the commit-graph
> is available and has non-zero generation numbers.
>
> When setting revs->limited only because revs->topo_order is true,
> only do so if generation numbers are not available. There is no
> reason to use the new logic as it will behave similarly when all
> generation numbers are INFINITY or ZERO.

O.K. we will be using new algorithm only when there actually are some
generation numbers.


> In prepare_revision_walk(), if we have revs->topo_order but not
> revs->limited, then we trigger the new logic. It breaks the logic
> into three pieces, to fit with the existing framework:

So if revs->limited is set (but not because revs->topo_order is set),
which means A..B queries, we will be still using the old algorithm.
All right, though I wonder if it could be improved in the future
(perhaps with the help of other graph labelling / indices than
generation numbers, maybe a positive-cut index).

Do you have an idea why there is no improvement with the new code in
this case?

> 1. init_topo_walk() fills a new struct topo_walk_info in the rev_info
>    struct. We use the presence of this struct as a signal to use the
>    new methods during our walk. In this patch, this method simply
>    calls limit_list() and sort_in_topological_order(). In the future,
>    this method will set up a new data structure to perform that logic
>    in-line.
>
> 2. next_topo_commit() provides get_revision_1() with the next topo-
>    ordered commit in the list. Currently, this simply pops the commit
>    from revs->commits.
>
> 3. expand_topo_walk() provides get_revision_1() with a way to signal
>    walking beyond the latest commit. Currently, this calls
>    add_parents_to_list() exactly like the old logic.

So all three new functions should perform exactly like the old logic,
isn't it?

> While this commit presents method redirection for performing the
> exact same logic as before, it allows the next commit to focus only
> on the new logic.

All right, it's logical.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  revision.c | 42 ++++++++++++++++++++++++++++++++++++++----
>  revision.h |  4 ++++
>  2 files changed, 42 insertions(+), 4 deletions(-)
>
> diff --git a/revision.c b/revision.c
> index e18bd530e4..2dcde8a8ac 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -25,6 +25,7 @@
>  #include "worktree.h"
>  #include "argv-array.h"
>  #include "commit-reach.h"
> +#include "commit-graph.h"
>  
>  volatile show_early_output_fn_t show_early_output;
>  
> @@ -2454,7 +2455,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>  	if (revs->diffopt.objfind)
>  		revs->simplify_history = 0;
>  
> -	if (revs->topo_order)
> +	if (revs->topo_order && !generation_numbers_enabled(the_repository))
>  		revs->limited = 1;

All right, with --topo-order and existing generation numbers don't force
the revs->limited code (i.e. explicit not wrapped use of limit_list()).

So with --topo-order and A..B, we have revs->limited set, with
--topo-order and no generation numbers we have revs->limited set.

>  
>  	if (revs->prune_data.nr) {
> @@ -2892,6 +2893,33 @@ static int mark_uninteresting(const struct object_id *oid,
>  	return 0;
>  }
>  
> +struct topo_walk_info {};

Nice trick with using NULL-ness of the pointer to the currently empty
struct as a boolean flag denoting whether to use new generation number
using algorithm for topological sorting.

> +
> +static void init_topo_walk(struct rev_info *revs)
> +{
> +	struct topo_walk_info *info;

I guess this helper variables is here for next revisions, as we could
have made without it...

> +	revs->topo_walk_info = xmalloc(sizeof(struct topo_walk_info));
> +	info = revs->topo_walk_info;
> +	memset(info, 0, sizeof(struct topo_walk_info));

...by using

  +	memset(revs->topo_walk_info, 0, sizeof(struct topo_walk_info));

> +
> +	limit_list(revs);
> +	sort_in_topological_order(&revs->commits, revs->sort_order);

This is not exactly identical to the old code, which has

	if (limit_list(revs) < 0)
		return -1;
	if (revs->topo_order)
		sort_in_topological_order(&revs->commits, revs->sort_order);

We know that init_topo_walk() would be invoked, as the name implies,
only when revs->topo_order is set, but do we know that limit_list()
would not return an error?

> +}
> +
> +static struct commit *next_topo_commit(struct rev_info *revs)
> +{
> +	return pop_commit(&revs->commits);
> +}

All right, identical to the old code.

> +
> +static void expand_topo_walk(struct rev_info *revs, struct commit *commit)
> +{
> +	if (add_parents_to_list(revs, commit, &revs->commits, NULL) < 0) {
> +		if (!revs->ignore_missing_links)
> +			die("Failed to traverse parents of commit %s",
> +			    oid_to_hex(&commit->object.oid));
> +	}
> +}

All right, identical to the old code.

While at it, should this message be marked up for translation, or is it
something so low-level (and rare) that should be kept untranslated?  But
this would be better left for separate commit series, to not entangle
this one with spurious changes.

> +
>  int prepare_revision_walk(struct rev_info *revs)
>  {
>  	int i;
> @@ -2928,11 +2956,13 @@ int prepare_revision_walk(struct rev_info *revs)
>  		commit_list_sort_by_date(&revs->commits);
>  	if (revs->no_walk)
>  		return 0;
> -	if (revs->limited)
> +	if (revs->limited) {
>  		if (limit_list(revs) < 0)
>  			return -1;
> -	if (revs->topo_order)
> -		sort_in_topological_order(&revs->commits, revs->sort_order);
> +		if (revs->topo_order)
> +			sort_in_topological_order(&revs->commits, revs->sort_order);
> +	} else if (revs->topo_order)
> +		init_topo_walk(revs);

Previously when revs->topo_order was set, Git called
sort_in_topological_order(), because revs->limited got always set to
truthy value if revs->topo_order was true.

Now running sort_in_topological_order() is done only if revs->limited is
set (because of A..B); if it is not, init_topo_walk() is called.

All right, identical to the old code, up to checking the return value of
limit_list(), see previous comments.

>  	if (revs->line_level_traverse)
>  		line_log_filter(revs);
>  	if (revs->simplify_merges)
> @@ -3257,6 +3287,8 @@ static struct commit *get_revision_1(struct rev_info *revs)
>  
>  		if (revs->reflog_info)
>  			commit = next_reflog_entry(revs->reflog_info);
> +		else if (revs->topo_walk_info)
> +			commit = next_topo_commit(revs);
>  		else
>  			commit = pop_commit(&revs->commits);

All right, identical to the old code.

> @@ -3278,6 +3310,8 @@ static struct commit *get_revision_1(struct rev_info *revs)
>  
>  			if (revs->reflog_info)
>  				try_to_simplify_commit(revs, commit);
> +			else if (revs->topo_walk_info)
> +				expand_topo_walk(revs, commit);
>  			else if (add_parents_to_list(revs, commit, &revs->commits, NULL) < 0) {
>  				if (!revs->ignore_missing_links)
>  					die("Failed to traverse parents of commit %s",

All right, identical to the old code.

> diff --git a/revision.h b/revision.h
> index 2b30ac270d..fd4154ff75 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -56,6 +56,8 @@ struct rev_cmdline_info {
>  #define REVISION_WALK_NO_WALK_SORTED 1
>  #define REVISION_WALK_NO_WALK_UNSORTED 2
>  
> +struct topo_walk_info;
> +
>  struct rev_info {
>  	/* Starting list */
>  	struct commit_list *commits;
> @@ -245,6 +247,8 @@ struct rev_info {
>  	const char *break_bar;
>  
>  	struct revision_sources *sources;
> +
> +	struct topo_walk_info *topo_walk_info;
>  };
>  
>  int ref_excluded(struct string_list *, const char *path);

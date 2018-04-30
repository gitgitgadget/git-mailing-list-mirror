Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDA8F215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 22:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754504AbeD3WTO (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 18:19:14 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43291 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753537AbeD3WTN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 18:19:13 -0400
Received: by mail-wr0-f196.google.com with SMTP id v15-v6so9394391wrm.10
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 15:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wBKYf+FtAjMTZ0IDclFLZ8+Wq7MTYz5mRXgD75eGypg=;
        b=c/LAQFL32Mk5F7D4FgUxIAPglB/kd2FjNa8FvnYVO8xmnfmVrU9L0K1J526MSB1ed3
         jIQ/dybYggmB2Ker7RF3mz6IdphLCuABccBE738Uk95Uaum9FxPiigdi2VVWS+VVG/w6
         xqsmled9Cp/QH5Qk1Jg4drNZJxaSSo/YNF64IbTcJUSjqQ71ugjv3owUDYFbfV3ovf59
         wg8k09vF/vpAMdwEdbyD7oSvOZMb4SzXfwGa0kQvaiHlELzNPdavohQlXTWt83i85pfh
         XwiscCNehYW9qaF0C6MzFugZ3CV6k74lXm5xchTnma5B72hR5Ptcnhg5SSFtY43lG9bX
         ZSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=wBKYf+FtAjMTZ0IDclFLZ8+Wq7MTYz5mRXgD75eGypg=;
        b=d5QJ8tKEFOnofJtC1BaQg48lhVnzTC49vKiq/lyEYVjvq1A2DuxRdPOYEWLzId+yFA
         gHwxNWeJanjVjLQcBNbFdGS2ys9KjhgCXdOzG4QuWYqjv46TtrxdF21IoEL1Ubfi57O0
         xaDuGZnho6CD0rDgH/QdQQjh7+uLMY3fwfME8uRoPu/xwLCaU6tgskCIuEYkn4IaaQIT
         sbg8g7EJRScAgEt6+h7j4aqjgele4euMRlgyE6wUBw+TzoBwUxKL4cy6tZE6SrD6FMLQ
         ElunmYRJA7HYT1dzGr3VmCi1IBqmsV9R66EV8gv75nMFLjTJ22/h9Ofj9Wwn3NvuheHM
         XLag==
X-Gm-Message-State: ALQs6tAN371s/Yt3PsGRZwSxkIPnG7J6/ZGRB5LH6atY3y1H2l4kmOQ3
        MyUd4XkW/gC3YftHoKsLKMU=
X-Google-Smtp-Source: AB8JxZptkgjEFN7vx/NNYGNPjQavMVgAAnfSY4Iaduk5xzThbqbA2mX926rW69w5l59VdBW+hw+xug==
X-Received: by 2002:adf:abab:: with SMTP id s40-v6mr10716940wrc.259.1525126751730;
        Mon, 30 Apr 2018 15:19:11 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abqa10.neoplus.adsl.tpnet.pl. [83.8.68.10])
        by smtp.gmail.com with ESMTPSA id v75-v6sm14969026wrc.65.2018.04.30.15.19.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Apr 2018 15:19:10 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 08/10] commit: add short-circuit to paint_down_to_common()
References: <20180417170001.138464-1-dstolee@microsoft.com>
        <20180425143735.240183-1-dstolee@microsoft.com>
        <20180425143735.240183-9-dstolee@microsoft.com>
Date:   Tue, 01 May 2018 00:19:06 +0200
In-Reply-To: <20180425143735.240183-9-dstolee@microsoft.com> (Derrick Stolee's
        message of "Wed, 25 Apr 2018 14:38:00 +0000")
Message-ID: <864ljsgwx1.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> When running 'git branch --contains', the in_merge_bases_many()
> method calls paint_down_to_common() to discover if a specific
> commit is reachable from a set of branches. Commits with lower
> generation number are not needed to correctly answer the
> containment query of in_merge_bases_many().
>
> Add a new parameter, min_generation, to paint_down_to_common() that
> prevents walking commits with generation number strictly less than
> min_generation. If 0 is given, then there is no functional change.

This is thanks to the fact that generation numbers start at zero (as
special case, though, with _ZERO), and we use strict inequality to avoid
handling _ZERO etc. in a special way.

As you wrote in response in previous version of this series, because
paint_down_to_common() is file-local, there is no need to come up with
symbolic name for GENERATION_NO_CUTOFF case.

All right.

>
> For in_merge_bases_many(), we can pass commit->generation as the
> cutoff, and this saves time during 'git branch --contains' queries
> that would otherwise walk "around" the commit we are inspecting.

All right, and when using paint_down_to_common() to actually find merge
bases, and not only check for containment, we cannot use cutoff.
Therefore at least one call site needs to run it without functional
change... which we can do.  Good.

>
> For a copy of the Linux repository, where HEAD is checked out at
> v4.13~100, we get the following performance improvement for
> 'git branch --contains' over the previous commit:
>
> Before: 0.21s
> After:  0.13s
> Rel %: -38%

Nice.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)

Let me reorder chunks a bit to make it easier to review.

>
> diff --git a/commit.c b/commit.c
> index 7bb007f56a..e2e16ea1a7 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1070,7 +1080,7 @@ int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit *
>  	if (commit->generation > min_generation)
>  		return ret;
>  
> -	bases = paint_down_to_common(commit, nr_reference, reference);
> +	bases = paint_down_to_common(commit, nr_reference, reference, commit->generation);
>  	if (commit->object.flags & PARENT2)
>  		ret = 1;
>  	clear_commit_marks(commit, all_flags);
> @@ -808,11 +808,14 @@ static int queue_has_nonstale(struct prio_queue *queue)
>  }
>  
>  /* all input commits in one and twos[] must have been parsed! */
> -static struct commit_list *paint_down_to_common(struct commit *one, int n, struct commit **twos)
> +static struct commit_list *paint_down_to_common(struct commit *one, int n,
> +						struct commit **twos,
> +						int min_generation)
>  {
>  	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
>  	struct commit_list *result = NULL;
>  	int i;
> +	uint32_t last_gen = GENERATION_NUMBER_INFINITY;
>  
>  	one->object.flags |= PARENT1;
>  	if (!n) {
> @@ -831,6 +834,13 @@ static struct commit_list *paint_down_to_common(struct commit *one, int n, struc
>  		struct commit_list *parents;
>  		int flags;
>  
> +		if (commit->generation > last_gen)
> +			BUG("bad generation skip");
> +		last_gen = commit->generation;

Shouldn't we provide more information about where the problem is to the
user, to make it easier to debug the repository / commit-graph data?

Good to have this sanity check here.

> +
> +		if (commit->generation < min_generation)
> +			break;

So the reasoning for this, as far as I understand, is the following.
Please correct me if I am wrong.

The callsite with non-zero min_generation, in_merge_bases_many(), tries
to find out if "commit" is an ancestor of one of the "references".  At
least one of "references" is above "commit", so in_merge_bases_many()
uses paint_down_to_common() - but is interested only if "commit" was
painted as reachable from one of "references".

Thus we can interrupt the walk if we know that none of [considered]
commits in the queue can reach "commit"/"one" - as if they were all
STALE.

The search is done using priority queue (a bit like in Dijkstra
algorithm), with newer commits - with larger generation numbers -
considered first.  Thus if current commit has generation number less
than min_generation cutoff, i.e. if it is below "commit", then all
remaining commits in the queue are below cutoff.

Good.

> +
>  		flags = commit->object.flags & (PARENT1 | PARENT2 | STALE);
>  		if (flags == (PARENT1 | PARENT2)) {
>  			if (!(commit->object.flags & RESULT)) {
> @@ -879,7 +889,7 @@ static struct commit_list *merge_bases_many(struct commit *one, int n, struct co
>  			return NULL;
>  	}
>  
> -	list = paint_down_to_common(one, n, twos);
> +	list = paint_down_to_common(one, n, twos, 0);

When calculating merge bases there is no such possibility of an early
return due to generation number cutoff.  All right then.

>  
>  	while (list) {
>  		struct commit *commit = pop_commit(&list);
> @@ -946,7 +956,7 @@ static int remove_redundant(struct commit **array, int cnt)
>  			filled_index[filled] = j;
>  			work[filled++] = array[j];
>  		}
> -		common = paint_down_to_common(array[i], filled, work);
> +		common = paint_down_to_common(array[i], filled, work, 0);

Here we are interested not only if "one"/array[i] is reachable from
"twos"/work, but also if "twos" is reachable from "one".  Simple cutoff
only works in one way, though I wonder if we couldn't use cutoff being
minimum generation number of "one" and "twos" together.

But that may be left for a separate commit (after checking that the
above is correct).

Not as simple and obvious as paint_down_to_common() used in
in_merge_bases_any(), so it is all right.

>  		if (array[i]->object.flags & PARENT2)
>  			redundant[i] = 1;
>  		for (j = 0; j < filled; j++)

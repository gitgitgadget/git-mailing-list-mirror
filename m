Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BC831F428
	for <e@80x24.org>; Sun, 29 Apr 2018 15:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753590AbeD2Pks (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 11:40:48 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36608 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753404AbeD2Pkr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 11:40:47 -0400
Received: by mail-wm0-f67.google.com with SMTP id n10so10466044wmc.1
        for <git@vger.kernel.org>; Sun, 29 Apr 2018 08:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=18ngC4L1sQ3YnLTl46nlEXb6X8wJWAuTALbj3ifwmMo=;
        b=ZTbJI2TAcS3ErJcbzJLRHY67Zdwd6cZZ+ZZgirKTZ0MZWHBJMHPkakkH+Nb/0vhGF7
         iEWwX7Y+un+2FIXANTgOKIIdMtDdn4tKriOScIsTSJe9FDGy2iV42yMnsyXKCVTOKlQZ
         tUYnIiKnZaRFI/D8Fm7mo3u1YPM99ev2gUiyr8K3knIIKK22fub0cOVfJ09NY0/HZirh
         POdsvOmsG8PFw1ulY7YCiHSZLaKVciIIzm5jn+zuXIJRE1og5TjC0Z0n1SKX/0NxOrmU
         oxSlJmyLvmCXWG4w4G2dBAaBhPakFYatqAoknGAOutOYKIYp77MXLuvuYfgtET2bp3mm
         7Iuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=18ngC4L1sQ3YnLTl46nlEXb6X8wJWAuTALbj3ifwmMo=;
        b=PwW0eoeRhYhhUYwr3EckzBh3bKqhnNlJqLcEquEp2IWpRfe3s2vU60PMiv/x7ZxnfS
         Fno2YPkAnTNL6v9/Vj/n9PWcVc9nDFEwd+GcRfHErx7EQq2ihzZSxfXL3d6MYim8067a
         Qf2XBSw2bh8S0qeTAgTVMb9K7PHL+NVKTAFscmCRrWgXYCV1pymLV4RddNje8qjwB7m0
         pse8MeRxOWZbXrJBPyzVUv3+4aVC0OTzyoKV1cVTiqc8FoZCiCPvx3103ZHFEt38ZYxZ
         V4vUjyFlqqzs+r/O01FnyApgdjHCLj9puBU+yEvb0czLib34uR5xEE4Hq7Il6VwAV9aF
         bDUQ==
X-Gm-Message-State: ALQs6tAx1mBAqvBHQXsFWFNupOt1fRqVA/hln3b3joC4okokrhqRwBuW
        fDwuNec5jq4gOwtWmjqekn4=
X-Google-Smtp-Source: AB8JxZr2LEH/zlIC8d7AzkZjNWV14feUeY3j/sZPg+Nlj7DHE2JUavF6kekcwlej2cqvZoRC5FThiA==
X-Received: by 10.28.198.202 with SMTP id w193mr5574829wmf.68.1525016445983;
        Sun, 29 Apr 2018 08:40:45 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abps22.neoplus.adsl.tpnet.pl. [83.8.60.22])
        by smtp.gmail.com with ESMTPSA id q2-v6sm5020502wrm.26.2018.04.29.08.40.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Apr 2018 08:40:44 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 04/10] commit: use generations in paint_down_to_common()
References: <20180417170001.138464-1-dstolee@microsoft.com>
        <20180425143735.240183-1-dstolee@microsoft.com>
        <20180425143735.240183-5-dstolee@microsoft.com>
Date:   Sun, 29 Apr 2018 17:40:41 +0200
In-Reply-To: <20180425143735.240183-5-dstolee@microsoft.com> (Derrick Stolee's
        message of "Wed, 25 Apr 2018 14:37:57 +0000")
Message-ID: <86k1sqhvgm.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> Define compare_commits_by_gen_then_commit_date(), which uses generation
> numbers as a primary comparison and commit date to break ties (or as a
> comparison when both commits do not have computed generation numbers).

All right, this looks reasonable thing to do when we have access to
commit generation numbers..

> Since the commit-graph file is closed under reachability, we know that
> all commits in the file have generation at most GENERATION_NUMBER_MAX
> which is less than GENERATION_NUMBER_INFINITY.

Thus the condition that if B is reachable from A, then gen(A) >= gen(B),
even if they have generation numbers _INFINITY, _MAX or _ZERO.

We use generation numbers, if possible, to choose closest commit; if
not, we use dates.

>
> This change does not affect the number of commits that are walked during
> the execution of paint_down_to_common(), only the order that those
> commits are inspected. In the case that commit dates violate topological
> order (i.e. a parent is "newer" than a child), the previous code could
> walk a commit twice: if a commit is reached with the PARENT1 bit, but
> later is re-visited with the PARENT2 bit, then that PARENT2 bit must be
> propagated to its parents. Using generation numbers avoids this extra
> effort, even if it is somewhat rare.

Actually the ordering of commits walked does not affect the correctness
of the result.  Better ordering means that commits do not need to be
walked twice; I think it would be possible to craft repository in which
unlucky clock skew would lead to depth-first walk of commits later part
of walk would mark STALE.

Pedantry aside, I think it is a good description of analysis of change
results.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit.c | 20 +++++++++++++++++++-
>  commit.h |  1 +
>  2 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/commit.c b/commit.c
> index 711f674c18..4d00b0a1d6 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -640,6 +640,24 @@ static int compare_commits_by_author_date(const void *a_, const void *b_,
>  	return 0;
>  }
>  
> +int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void *unused)
> +{
> +	const struct commit *a = a_, *b = b_;
> +
> +	/* newer commits first */

To be pedantic, larger generation number does not necessary mean that
commit was created later (is newer), only that it is on longer chain
since common ancestor or root commit.

> +	if (a->generation < b->generation)
> +		return 1;
> +	else if (a->generation > b->generation)
> +		return -1;

If the commit-graph feature is not available, or is disabled, all
commits would have the same generation number (_INFINITY), then this
block would be always practically no-op.

This is not very costly: 2 access to data which should be in cache, and
1 to 2 comparison operations.  But I wonder if we wouldn't want to avoid
this nano-cost if possible...

> +
> +	/* use date as a heuristic when generations are equal */
> +	if (a->date < b->date)
> +		return 1;
> +	else if (a->date > b->date)
> +		return -1;
> +	return 0;

The above is the same code as in compare_commits_by_commit_date(), but
there it is with "newer commits with larger date first" as comment
instead.

All right: we need inlining for speed.

> +}
> +
>  int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused)
>  {
>  	const struct commit *a = a_, *b = b_;
> @@ -789,7 +807,7 @@ static int queue_has_nonstale(struct prio_queue *queue)
>  /* all input commits in one and twos[] must have been parsed! */
>  static struct commit_list *paint_down_to_common(struct commit *one, int n, struct commit **twos)
>  {
> -	struct prio_queue queue = { compare_commits_by_commit_date };
> +	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };

I wonder if it would be worth it to avoid comparing by generation
numbers without commit graph data:

  +	struct prio_queue queue;
  [...]
  +	if (commit_graph)
  +		queue.compare = compare_commits_by_gen_then_commit_date;
  +	else
  +		queue.compare = compare_commits_by_commit_date;

Or something like that.  But perhaps this nano-optimization is not worth
it (it is not that complicated, though).


Sidenote: when I searched for compare_commits_by_commit_date use, I have
noticed that it is used, I think as heuristics, for packfile creation in
upload-pack.c and fetch-pack.c.  Would they similarly improve with
compare_commits_by_gen_then_commit_date?

This is of course not something that this commit, or this patch series,
needs to address now.

>  	struct commit_list *result = NULL;
>  	int i;
>  
> diff --git a/commit.h b/commit.h
> index aac3b8c56f..64436ff44e 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -341,6 +341,7 @@ extern int remove_signature(struct strbuf *buf);
>  extern int check_commit_signature(const struct commit *commit, struct signature_check *sigc);
>  
>  int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused);
> +int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void *unused);

All right.

>  
>  LAST_ARG_MUST_BE_NULL
>  extern int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...);

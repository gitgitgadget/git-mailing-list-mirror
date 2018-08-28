Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 549B21F404
	for <e@80x24.org>; Tue, 28 Aug 2018 16:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbeH1UiZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 16:38:25 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55770 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbeH1UiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 16:38:25 -0400
Received: by mail-wm0-f67.google.com with SMTP id f21-v6so2602349wmc.5
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 09:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RnxwI3+dAtDu0GxynM+Pyc/oCJ+2d2AvloJGr/vVHWU=;
        b=gcDO6A4J0BnniqTCqwjwOKhXke+Ul9F5CjviZqwiqBoHLM+KewXLfuE/+VmM2aJW6y
         R4jfbbSIpVfBjFe5wNMqpKZxeQoKjv5bRZvZtL9ZFuRHUWaENf+MUK0BrmgbsxqGqIF6
         QV8Yzjr0/Rb9+fBuTDi++egyJKl1hrJmOO7sBEFLK6hEFYWXuZ7YNfIGSX9q5/uoz6uy
         S9zTPapFsIfb3aMG7pwOgV/Z+J14QYWXVhRxw3bMvi6hnTojqTPmQP684+zszMlrKdMV
         lhG6/U1hoLhzvox5wRNECUVcAcD7l0/ig0SYVm9EPX52//2ILyWqrUGfEPKWCRoekL2L
         IOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RnxwI3+dAtDu0GxynM+Pyc/oCJ+2d2AvloJGr/vVHWU=;
        b=Bv58/EDaHKWQhfGnsd2drVASY7++y5Js6G4IZe+ogXJR5SNHYZzzRMPYVVgudai9L4
         8/2UogihNlxdSSoPNDgn+RJeu46Apd0H+lrLDnK8KMgTws0/UKuuS2MEDOMQAyZF9+bG
         meKLYlTeIMT+JmcbLD5vD+Q6aeeovwqdSk7cU0rKCoAoaLOlKLeYRq9HI6xhNb+zjPBO
         MgT/yP7m0goV2y6O76RyblIrCzIcBGyKhpqadfau/U6hNwv9N39o4r5jPykkoxxCwWjJ
         zGXk+f59Z0V5x5S+Y4B/Wu8DJUNzvjpsPVu5HxMKM9DRBPdoTtChVfLBigmA59lnlTRJ
         dDaA==
X-Gm-Message-State: APzg51CpBFjnr1ePPlRjwgq4KfA0dwg4lXHPkg1gMVU7gzG4/o0Y7Jyd
        cK2lDcgBXcfI7VF0Y7Jtd34=
X-Google-Smtp-Source: ANB0VdZBYrBMb6n1ZlreAU4lQAmD1yn1nkBJuuBxTyXXnik5wpZVpVZw5M4Yuo1oqHSB9xIe/dKmCg==
X-Received: by 2002:a1c:c5cc:: with SMTP id v195-v6mr1943439wmf.29.1535474752509;
        Tue, 28 Aug 2018 09:45:52 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 124-v6sm3547815wmk.20.2018.08.28.09.45.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 09:45:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tiago Botelho <tiagonbotelho@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, haraldnordgren@gmail.com,
        Tiago Botelho <tiagonbotelho@hotmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v6] Implement --first-parent for git rev-list --bisect
References: <20180828123234.44582-1-tiagonbotelho@hotmail.com>
Date:   Tue, 28 Aug 2018 09:45:49 -0700
In-Reply-To: <20180828123234.44582-1-tiagonbotelho@hotmail.com> (Tiago
        Botelho's message of "Tue, 28 Aug 2018 14:32:34 +0200")
Message-ID: <xmqqlg8qh22q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tiago Botelho <tiagonbotelho@gmail.com> writes:

> diff --git a/bisect.c b/bisect.c
> index 4eafc8262..cb80f29c5 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -82,15 +82,16 @@ static inline void weight_set(struct commit_list *elem, int weight)
>  	*((int*)(elem->item->util)) = weight;
>  }
>  
> -static int count_interesting_parents(struct commit *commit)
> +static int count_interesting_parents(struct commit *commit, unsigned bisect_flags)
>  {
>  	struct commit_list *p;
>  	int count;
>  
>  	for (count = 0, p = commit->parents; p; p = p->next) {
> -		if (p->item->object.flags & UNINTERESTING)
> -			continue;
> -		count++;
> +		if (!(p->item->object.flags & UNINTERESTING))
> +		    count++;
> +		if (bisect_flags & BISECT_FIRST_PARENT)
> +			break;
>  	}
>  	return count;
>  }

We either say 0 ("the first parent is uninteresting") or 1 ("it is")
under BISECT_FIRST_PARENT mode.  OK.

> @@ -117,10 +118,10 @@ static inline int halfway(struct commit_list *p, int nr)
>  }
>  
>  #if !DEBUG_BISECT
> -#define show_list(a,b,c,d) do { ; } while (0)
> +#define show_list(a,b,c,d,e) do { ; } while (0)
>  #else
>  static void show_list(const char *debug, int counted, int nr,
> -		      struct commit_list *list)
> +		      struct commit_list *list, unsigned bisect_flags)
>  {
>  	struct commit_list *p;
>  
> @@ -146,10 +147,14 @@ static void show_list(const char *debug, int counted, int nr,

An unrelated tangent, but I think I just spotted a bug in the
existing code on the line immediately before this hunk, which reads

		if (commit->util)
			fprintf(stderr, "%3d", weight(p));

I think this was a bug introduced at bb408ac9 ("bisect.c: use
commit-slab for commit weight instead of commit->util", 2018-05-19)
where the internal implementation of weight() was changed not to
touch commit->util but instead to use a separate commit-slab storage

Looking at the code before that conversion, it seems that we were
using ->util to store a pointer to an integer, so we had the ability
to differenciate non-negative weight (i.e. weight already computed
for the commit), negative weight (i.e. not computed yet, but will
be), and commits to which the concept of weight is not applicable.
When we went to the commit-slab with the change, we lost the ability
to represent the third case.  I am offhand not sure what the best
remedy would be.  Perhaps stuff a so-far unused value like -3 to the
weight() and use weight(p) == -3 instead of the old !commit->util or
something like that?

(Duy CC'ed to help checking my sanity on this point).

In any case, this is an existing bug in a debug helper, and the
focus of this patch is not about fixing that bug, so you can and
should leave it as-is, until this patch successfully adds the
"bisection following only the first parent" feature.

>  		else
>  			fprintf(stderr, "---");
>  		fprintf(stderr, " %.*s", 8, oid_to_hex(&commit->object.oid));
> -		for (pp = commit->parents; pp; pp = pp->next)
> +		for (pp = commit->parents; pp; pp = pp->next) {
>  			fprintf(stderr, " %.*s", 8,
>  				oid_to_hex(&pp->item->object.oid));
>  
> +			if (bisect_flags & BISECT_FIRST_PARENT)
> +				break;
> +		}
> +

I am not sure if we want to do this.  This is a debugging aid that
allows us to peek into the internal state of the commit history
graph being worked on; don't we rather want to make sure that tips
of merged side branches are not participating (e.g. commit->util
that records "weight" is used differently between the first and
other parent commits)?

>  		subject_len = find_commit_subject(buf, &subject_start);
>  		if (subject_len)
>  			fprintf(stderr, " %.*s", subject_len, subject_start);
> @@ -267,13 +272,13 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
>  		unsigned flags = commit->object.flags;
>  
>  		p->item->util = &weights[n++];
> -		switch (count_interesting_parents(commit)) {
> +		switch (count_interesting_parents(commit, bisect_flags)) {
>  		case 0:
>  			if (!(flags & TREESAME)) {
>  				weight_set(p, 1);
>  				counted++;
>  				show_list("bisection 2 count one",
> -					  counted, nr, list);
> +					  counted, nr, list, bisect_flags);
>  			}
>  			/*
>  			 * otherwise, it is known not to reach any

Because count_interesting_parents() returns either 0 or 1 under
BISECT_FIRST_PARENT mode, we will never set -2 in this switch()
statement.  We either paint the bottom boundary with the correct
weight, or -1 (i.e. "its weight is one plus its first parent's
weight" marker).  OK.

> @@ -289,7 +294,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
>  		}
>  	}
>  
> -	show_list("bisection 2 initialize", counted, nr, list);
> +	show_list("bisection 2 initialize", counted, nr, list, bisect_flags);
>  
>  	/*
>  	 * If you have only one parent in the resulting set
> @@ -319,7 +324,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
>  		counted++;
>  	}
>  
> -	show_list("bisection 2 count_distance", counted, nr, list);
> +	show_list("bisection 2 count_distance", counted, nr, list, bisect_flags);

The loop before this part (not shown) is about counting weight for
merges the hard way, which does not apply to us under the new
BISECT_FIRST_PARENT mode.  IOW, "initialize" and "count_distance"
should show exactly the same output from show_list().

>  	while (counted < nr) {
>  		for (p = list; p; p = p->next) {
> @@ -329,6 +334,11 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
>  			if (0 <= weight(p))
>  				continue;

If we know the weight of 'p' already, then we are already done with
it.  In the normal code, that means we are done with all the merges,
so the loop immediately below deals only with a single strand of
pearls.  However, under BISECT_FIRST_PARENT mode, that is
different.  Let's see.

>  			for (q = p->item->parents; q; q = q->next) {
> +				if ((bisect_flags & BISECT_FIRST_PARENT)) {
> +					if (weight(q) < 0)
> +						q = NULL;
> +					break;
> +				}

Under first-parent mode, we uncondtionally break out of the loop
after inspecting the first parent, even if it is a merge.  The code
after this loop (outside the context) says

			if (!q)
				continue;

which is to say "we are not ready to set the weight of p based on
the weight of q, because the latter is unknown".  So that is done by
setting q to NULL, which makes sort of sense.

>  				if (q->item->object.flags & UNINTERESTING)
>  					continue;
> ...
>  				if (0 <= weight(q))

Post context of this hunk is "break;", meaning that if we find an
interesting parent 

What the above original tells us is that when we are doing a full
bisection, we do not look at weight of uninteresting parent and
continue.  In that case we know p is not a merge so we will exit
this for() loop with q set to NULL.

Shouldn't we keep that property even under BISECT_FIRST_PARENT mode?
What I am wondering is the block added to the top of this for() loop.

Shouldn't it be more like this?

                                if ((bisect_flags & BISECT_FIRST_PARENT)) {
					if ((q->item->object.flags & UNINTERESTING) ||
					    (weight(q) < 0))
						q = NULL;
					break;
				}

I do not even recall if weight(q) is defined for an uninteresting q
offhand; your patch requires weight(q) is defined and is negative
for such a 'q' to be correct.  Code would be more trivially correct
with an explicit check for UNINTERESTING, I would think.

In any case, after finding a parent (or not finding, signalled by
being NULL) whose weight is either the same or one less than our
weight, we leave the above for() loop and then ...

> @@ -346,7 +356,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
>  				weight_set(p, weight(q)+1);
>  				counted++;
>  				show_list("bisection 2 count one",
> -					  counted, nr, list);
> +					  counted, nr, list, bisect_flags);
>  			}
>  			else
>  				weight_set(p, weight(q));

... we set our weight based on its weight.  OK.

The remainder of the change looked OK (I didn't look at the the test).

Thanks.

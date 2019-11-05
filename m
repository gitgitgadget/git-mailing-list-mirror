Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 863351F454
	for <e@80x24.org>; Tue,  5 Nov 2019 23:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730509AbfKEXEJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 18:04:09 -0500
Received: from mail-ua1-f73.google.com ([209.85.222.73]:50110 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbfKEXEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 18:04:09 -0500
Received: by mail-ua1-f73.google.com with SMTP id r21so3855269uao.16
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 15:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GUtFv/KvbIYsgK+ugWaMPQktKGQS+fRgwbTwS+xvzyo=;
        b=DcKeLTOwbbNvpkopVYFlBFgThegyepht1Q+Ur57YNgde7PCUw0tS0l8g+DRY+MnZ/f
         gHULD+hDJxIngbGxblfYuqBdi5rAlGZrehIOwBPCq/gNPJGoe/E7xICrazrO+OwQ3Pz5
         2D2GQK+rT4yMxy4XMD9YwvHi87Hd+noPqyqDScXb6DVLR1HrJ/0E61JOAf8N/0CS+wb1
         0cnRJEEGo8HNRss8AG47Xuvmbue01C9j+FbMP8ZujQhbOcYDGYckJWQkuLQyRqxEE3sP
         KcFhVXiqIwfZpCvFwRH2q+3BRlJfpdv4nqSwv2NXYjb2ZNbKnPTthsVHuc1vaO6ajo7h
         WIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GUtFv/KvbIYsgK+ugWaMPQktKGQS+fRgwbTwS+xvzyo=;
        b=WvFWx8M+s+QordCDLvtmEgfNqLvMzvpjRI3bUkjBPa07GzVOgOtN6gWBXc0m4yF6QF
         BwYfyNT1yQ9jxWaG83AikyYpupdX8STItIZG194NzRBN/017ej/f4rG0l8YEOPZM7+dQ
         nZs53FYk9C6PuYejm71kQaXgNNPwiOLKMKJ/NxoEb5/CnqaYjUA3okUq7Oko1ZsbqUHI
         dTiyZ27ENFbkEXJD6pT2la7Iew9nwjycR4PffOEHhxuBx9LrJdo8SYsyKWLV5Y8fE69l
         yeNuOGSxKlmfhqwC7e1xFTqjA4cBWoathM6Uy0ab5CwDPXT7fJlQ9SuZVbd17vjMbyHP
         KjjQ==
X-Gm-Message-State: APjAAAXEh1dc7qqJMHZhhOjGp4T4aahFYbQx/smaLcBt+wApcqyqUMZc
        XNpkATuIHIOFTBXFdTFns3JxpAosEb2KnHkOa1PT
X-Google-Smtp-Source: APXvYqw/t3Rqxyzkk9IxNxZG++TLPYe9GsPezvgZF7+tUEvnbDyMl9VhXSioQSh1PH9wJBIbMPgA7DFjAQxaUiuhMAt0
X-Received: by 2002:a1f:5f08:: with SMTP id t8mr15883065vkb.87.1572995046368;
 Tue, 05 Nov 2019 15:04:06 -0800 (PST)
Date:   Tue,  5 Nov 2019 15:04:03 -0800
In-Reply-To: <20191105052141.15913-2-workingjubilee@gmail.com>
Message-Id: <20191105230403.5542-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20191105052141.15913-2-workingjubilee@gmail.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: Re: [PATCH v7 1/1] Implement rev-list --bisect* --first-parent
From:   Jonathan Tan <jonathantanmy@google.com>
To:     workingjubilee@gmail.com
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, gitster@pobox.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First of all, thanks for taking a year-old patch and updating it.
Overall, this looks good. I have some minor comments, but it might be
best to wait until someone more experienced with bisect.c takes a look
too.

Your commit message title should be of the form "<component>: <change>",
e.g.:

  rev-list: support --first-parent with --bisect*

> Not all repository maintainers expect every commit to pass tests, only
> testing the merge commits. Currently bisection assumes every commit is
> of interest. The highly-requested --bisect --first-parent feature imbues
> git with the same indifference to minutiae when the option is set, so
> that it casually riffles through commits, throwing aside mountains of
> irrelevant data when looking for a breaking change. Further refinement
> of where breaks occurred can be gained by bisecting over the merge's
> range.

I would be much more laconic (in particular, omitting subjective terms
like "minutiae" and "mountains of irrelevant data"), but perhaps that is
just a matter of subjective style.

> Note, bisecting on --first-parent becomes part of findall's previously
> existing pass-through as an "option state" flag.

I don't understand this part.

> In order to limit possible obfuscation of bisect operations resulting
> from the addition of new flags, some extra documentation was folded in
> to the patch.

What is being obfuscated, and what extra documentation was "folded"?

Also, clarify in the commit message somewhere that this commit does not
change the behavior of "git bisect".

As for the diff, besides my comments below, a change in the user-facing
documentation of "rev-list" is needed, since --bisect and --first-parent
now work together.

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
> +			count++;
> +		if (bisect_flags & BISECT_FIRST_PARENT)
> +			break;
>  	}
>  	return count;
>  }

(Note that I'm writing my thoughts as I go along to aid future
reviewers, and to show the author (you) how I'm understanding the
patch.)

We only take into account the first parent - straightforward enough.
I'll have to see how this function is used to ensure that this change is
correct.

>  static void show_list(const char *debug, int counted, int nr,
> -		      struct commit_list *list)
> +		      struct commit_list *list, unsigned bisect_flags)
>  {
>  	struct commit_list *p;

What is the purpose of this change? bisect_flags is never used anywhere
in show_list().

> @@ -271,13 +274,13 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
>  		unsigned flags = commit->object.flags;
>  
>  		*commit_weight_at(&commit_weight, p->item) = &weights[n++];
> -		switch (count_interesting_parents(commit)) {
> +		switch (count_interesting_parents(commit, bisect_flags)) {
>  		case 0:

[snip]

Not shown, but this is an iteration over all commits in the parameter
"list". I'll quote the entire loop:

>         for (n = 0, p = list; p; p = p->next) {
>                 struct commit *commit = p->item;
>                 unsigned flags = commit->object.flags;
> 
>                 *commit_weight_at(&commit_weight, p->item) = &weights[n++];
>                 switch (count_interesting_parents(commit, bisect_flags)) {
>                 case 0:
>                         if (!(flags & TREESAME)) {
>                                 weight_set(p, 1);
>                                 counted++;
>                                 show_list("bisection 2 count one",
>                                           counted, nr, list, bisect_flags);
>                         }
>                         /*
>                          * otherwise, it is known not to reach any
>                          * tree-changing commit and gets weight 0.
>                          */
>                         break;
>                 case 1:
>                         weight_set(p, -1);
>                         break;
>                 default:
>                         weight_set(p, -2);
>                         break;
>                 }
>         }

Looks like count_interesting_parents() is correct. After this loop, all
commits have weight 1, 0 (weights is xcalloc'ed by the caller), -1, or
-2 (impossible when BISECT_FIRST_PARENT). We'll have to observe how
subsequent code treats the weights 1, 0, and -1.

> -	show_list("bisection 2 count_distance", counted, nr, list);
> +	/* should match bisection 2 initialize when BISECT_FIRST_PARENT */
> +	show_list("bisection 2 count_distance", counted, nr, list, bisect_flags);

Besides the review comment I made about show_list() earlier, this /* */
comment is also unnecessary.

> @@ -333,6 +337,17 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
>  			if (0 <= weight(p))
>  				continue;
>  			for (q = p->item->parents; q; q = q->next) {
> +				/*
> +				 * first_parent can skip parent nodes, but only when
> +				 * confirmed as being of no interest.
> +				 */
> +				if (first_parent) {
> +					if ((q->item->object.flags & UNINTERESTING) ||
> +						(weight(q) < 0)) {
> +						q = NULL;
> +					}
> +					break;
> +				}
>  				if (q->item->object.flags & UNINTERESTING)
>  					continue;
>  				if (0 <= weight(q))

This is also in a loop. As can be seen at the top of the diff ("if (0 <=
weight(p))"), this only operates on commits with negative weights.

Originally, the inner loop advances until a non-UNINTERESTING parent
with a non-negative weight. If no such parent is found, at the end of
the loop, q is NULL. The added code effectively replicates what's going
on, but ignoring any parents after the first.

A previous reviewer [1] wanted an explanation for this part, so thanks
for attempting to do that. But I don't understand the explanation -
firstly, it is not a question of "can" (optional) but of "will"
(mandatory), and it is not only UNINTERESTING that determines skipping,
but weight as well.

I would write the entire section like this (remember to wrap the lines):

	if (first_parent) {
		q = p->item->parents;
		if (q && ((q->item->object.flags & UNINTERESTING) || weight(q) < 0))
			q = NULL;
	} else {
		/*
		 * Find an interesting parent with non-negative weight.
		 */
		for (...) {
		}
	}

Looking at the rest of do_find_bisection():

- I don't see any other parts that would be affected by only calculating
  weights based on the first parent, so that's fine.

- There are some early returns that assume that "list" is generated by
  iterating only over first parents. do_find_bisection() is called only
  by find_bisection(), and the latter is called only by cmd_rev_list()
  and bisect_next_all(). The former is fine, but I will discuss the
  latter later.

- I do see some unclear parts (in particular, counter might not reach nr
  if any of the weights are 0 and if the "weight_set(p, weight(q));"
  line is reached, potentially resulting in an infinite loop) but that
  is unrelated to this patch, so don't worry about it.

[1] https://public-inbox.org/git/nycvar.QRO.7.76.6.1808281512240.73@tvgsbejvaqbjf.bet/

> @@ -964,7 +981,12 @@ int bisect_next_all(struct repository *r, const char *prefix, int no_checkout)
>  
>  	bisect_common(&revs);
>  
> -	find_bisection(&revs.commits, &reaches, &all, !!skipped_revs.nr);
> +	if (skipped_revs.nr)
> +		bisect_flags |= BISECT_FIND_ALL;
> +	if (revs.first_parent_only)
> +		bisect_flags |= BISECT_FIRST_PARENT;
> +
> +	find_bisection(&revs.commits, &reaches, &all, bisect_flags);
>  	revs.commits = managed_skipped(revs.commits, &tried);
>  
>  	if (!revs.commits) {

I don't see how revs.first_parent_only is ever set in this function. If
it's never set, undo this change, since this code is never executed.

> +/*
> + * Coordinates a bisection by examining input made available so far,
> + * setting up internal variables, and then bisecting with them.
> + * no_checkout directs this to only update BISECT_HEAD refs.
> + *
> + * Exit code 10 on successful bisection, so caller should exit with 0.
> + * Exit code 4 when no commits were found to bisect through.
> + * Exit code 1 MAY result from skipping the commit it would report.
> + *
> + * Otherwise, returns a call to command handlers which choose an exit.
> + */
>  int bisect_next_all(struct repository *r,
>  		    const char *prefix,
>  		    int no_checkout);

I haven't looked at this function in detail, so I can't verify that this
comment is correct. But in any case, if you end up not making any change
to bisect_next_all(), I think it's best to leave this change out as
well.

> diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
> index b8cf82349b..95949e4ff1 100755
> --- a/t/t6000-rev-list-misc.sh
> +++ b/t/t6000-rev-list-misc.sh
> @@ -122,8 +122,8 @@ test_expect_success 'rev-list can negate index objects' '
>  	test_cmp expect actual
>  '
>  
> -test_expect_success '--bisect and --first-parent can not be combined' '
> -	test_must_fail git rev-list --bisect --first-parent HEAD
> +test_expect_success '--bisect and --first-parent CAN be combined' '
> +	git rev-list --bisect --first-parent HEAD
>  '
>  

I think this test can just be deleted. It is tested in t6002.

> diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
> index a661408038..6caf2af650 100755
> --- a/t/t6002-rev-list-bisect.sh
> +++ b/t/t6002-rev-list-bisect.sh
> @@ -263,4 +263,58 @@ test_expect_success 'rev-parse --bisect can default to good/bad refs' '
>  	test_cmp expect.sorted actual.sorted
>  '
>  
> +# --first-parent tests
> +
> +# --bisect --first-parent should pluck out the middle.
> +printf "%s\n" e4 |
> +test_output_expect_success "--bisect --first-parent" '
> +	git rev-list --bisect --first-parent E ^F
> +'
> +
> +printf "%s\n" E e1 e2 e3 e4 e5 e6 e7 e8 |
> +test_output_expect_success "--first-parent" '
> +	git rev-list --first-parent E ^F
> +'
> +
> +test_output_expect_success '--bisect-vars --first-parent' '
> +	git rev-list --bisect-vars --first-parent E ^F
> +' <<-EOF
> +	bisect_rev='e5'
> +	bisect_nr=4
> +	bisect_good=4
> +	bisect_bad=3
> +	bisect_all=9
> +	bisect_steps=2
> +EOF

Looks good, except for the middle test - that should already be working
even before the current patch, right? If there's a reason for including
it anyway, mention it in the commit message.

> +test_expect_success '--bisect-all --first-parent returns correct order' '
> +	git rev-list --bisect-all --first-parent E ^F >actual &&
> +
> +	# Make sure the entries are sorted in the dist order
> +	sed -e "s/.*dist=\([0-9]\).*/\1/" actual >actual.dists &&
> +	sort -r -n actual.dists >actual.dists.sorted &&
> +	test_cmp actual.dists.sorted actual.dists
> +'
> +
> +# NEEDSWORK: this test could afford being hardened against other
> +# changes in the same file.
> +test_expect_success '--bisect-all --first-parent compares correctly' '
> +	cat >expect <<-EOF &&
> +	$(git rev-parse tags/e5) (tag: e5, dist=4)
> +	$(git rev-parse tags/e4) (tag: e4, dist=4)
> +	$(git rev-parse tags/e6) (tag: e6, dist=3)
> +	$(git rev-parse tags/e3) (tag: e3, dist=3)
> +	$(git rev-parse tags/e7) (tag: e7, dist=2)
> +	$(git rev-parse tags/e2) (tag: e2, dist=2)
> +	$(git rev-parse tags/e8) (tag: e8, dist=1)
> +	$(git rev-parse tags/e1) (tag: e1, dist=1)
> +	$(git rev-parse tags/E) (tag: E, dist=0)
> +EOF
> +
> +git rev-list --bisect-all --first-parent E ^F >actual &&
> +	sort actual >actual.sorted &&
> +	sort expect >expect.sorted &&
> +	test_cmp expect.sorted actual.sorted
> +'

I think these 2 tests can be combined, since the latter also checks the
dists. Also, correct the indentation of the latter test.

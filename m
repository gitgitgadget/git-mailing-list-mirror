Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A3161F454
	for <e@80x24.org>; Thu,  7 Nov 2019 16:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbfKGQAm (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 11:00:42 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:32925 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfKGQAm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 11:00:42 -0500
Received: by mail-lf1-f66.google.com with SMTP id d6so1617988lfc.0
        for <git@vger.kernel.org>; Thu, 07 Nov 2019 08:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2U8x9RaYkXTNr+PGW6xfQTGASz2jBSzQucH0F9j+Ayo=;
        b=otyNrmippBcodU3E4r3QwN55QVY51zEc/YGVDpjupI4Pt6mAi227DXPUkprU8zK2Wk
         ZDcek9oRbLI9wmWrhBWTiFKVIPbjKzclnFLeZqyfrEcL0AHEkhsNP4bTDfYT+xGWn0Nd
         aAEgSVqLKphp+ET0bFyw+5FaJoM0C8o8Lrle8KlcIKlKGIbksPtQqBwu78HvagJdlt5D
         DEd9sHJuH5bpdP9RPADs6XSxuECQHdiCsgFJ9cY2Ts/7m6yZwlZyV6Ae+0zQqqhSIRG9
         jTipby2KCXbbhLGXkIfKG+2aq2zIUH1J14w94y6/3pW/a1PxtcahftJT69BqvdtrFOM1
         WuQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2U8x9RaYkXTNr+PGW6xfQTGASz2jBSzQucH0F9j+Ayo=;
        b=MqQZciz4fLhviYwV+X5/itSHKLVA1C0ilMSKKqV7U2BcV2/Tu1UuDjtKCjZYV4FpBM
         K5hHk4gjxq5SgTIhIvphW5hsbrNRrwicUsXq5+ze2dJuaVzt/3ut9WNrHMrDBeIhKh4Z
         FAfsFLRjVUqrY8rsHlPXmmNakQH9ounIocaLa+HX7xoVUYZ+LhA8qtcT+mEWm4Dc0jtF
         sYuuvbJBwP9dUGnZkeLXdiHFV77xbglFjDRC3fsp5JuUHH5piI0Te1zexKDb66M9QaBp
         lXMq7WyESL0IeD0/TLgH+zRVbASzSto2aWYw0L36+kJV1VRXwlbVlxiO2Hb7P7Glf+nx
         eAIg==
X-Gm-Message-State: APjAAAX3OKPa1SNxPa6XqhP8+1TIkjzjclHpfMxKbgKrm+reYyCFP32X
        1M3gPIqyLcjZ2tcZ39vvnQYRoXegQnPbtXtm4Lw=
X-Google-Smtp-Source: APXvYqxBly6IjD+0MYuQbZQo473p6TuZl3EfIsD3OU24zIqO3u44rditfSMFZNlo5XcW3rH9PnSNNzl9Y3USv9h0CJQ=
X-Received: by 2002:ac2:46e3:: with SMTP id q3mr2996926lfo.9.1573142438657;
 Thu, 07 Nov 2019 08:00:38 -0800 (PST)
MIME-Version: 1.0
References: <20191105052141.15913-2-workingjubilee@gmail.com> <20191105230403.5542-1-jonathantanmy@google.com>
In-Reply-To: <20191105230403.5542-1-jonathantanmy@google.com>
From:   Jubilee Young <workingjubilee@gmail.com>
Date:   Thu, 7 Nov 2019 08:00:00 -0800
Message-ID: <CAPNHn3qj7v=xu1ogG4q9NrHvp1zfZFvUWQKJqf0DJcavxgsz6Q@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] Implement rev-list --bisect* --first-parent
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        johannes.schindelin@gmx.de, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 5, 2019 at 3:04 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> First of all, thanks for taking a year-old patch and updating it.
> Overall, this looks good. I have some minor comments, but it might be
> best to wait until someone more experienced with bisect.c takes a look
> too.
>
> Your commit message title should be of the form "<component>: <change>",
> e.g.:
>
>   rev-list: support --first-parent with --bisect*
>
> > Not all repository maintainers expect every commit to pass tests, only
> > testing the merge commits. Currently bisection assumes every commit is
> > of interest. The highly-requested --bisect --first-parent feature imbues
> > git with the same indifference to minutiae when the option is set, so
> > that it casually riffles through commits, throwing aside mountains of
> > irrelevant data when looking for a breaking change. Further refinement
> > of where breaks occurred can be gained by bisecting over the merge's
> > range.
>
> I would be much more laconic (in particular, omitting subjective terms
> like "minutiae" and "mountains of irrelevant data"), but perhaps that is
> just a matter of subjective style.
>
> > Note, bisecting on --first-parent becomes part of findall's previously
> > existing pass-through as an "option state" flag.
>
> I don't understand this part.
>
> > In order to limit possible obfuscation of bisect operations resulting
> > from the addition of new flags, some extra documentation was folded in
> > to the patch.
>
> What is being obfuscated, and what extra documentation was "folded"?
>
> Also, clarify in the commit message somewhere that this commit does not
> change the behavior of "git bisect".
>
> As for the diff, besides my comments below, a change in the user-facing
> documentation of "rev-list" is needed, since --bisect and --first-parent
> now work together.

Will do.

>
> > -static int count_interesting_parents(struct commit *commit)
> > +static int count_interesting_parents(struct commit *commit, unsigned bisect_flags)
> >  {
> >       struct commit_list *p;
> >       int count;
> >
> >       for (count = 0, p = commit->parents; p; p = p->next) {
> > -             if (p->item->object.flags & UNINTERESTING)
> > -                     continue;
> > -             count++;
> > +             if (!(p->item->object.flags & UNINTERESTING))
> > +                     count++;
> > +             if (bisect_flags & BISECT_FIRST_PARENT)
> > +                     break;
> >       }
> >       return count;
> >  }
>
> (Note that I'm writing my thoughts as I go along to aid future
> reviewers, and to show the author (you) how I'm understanding the
> patch.)
>
> We only take into account the first parent - straightforward enough.
> I'll have to see how this function is used to ensure that this change is
> correct.
>
> >  static void show_list(const char *debug, int counted, int nr,
> > -                   struct commit_list *list)
> > +                   struct commit_list *list, unsigned bisect_flags)
> >  {
> >       struct commit_list *p;
>
> What is the purpose of this change? bisect_flags is never used anywhere
> in show_list().

Insufficiently cleaned-up change cruft! Thanks for catching it.

> This is also in a loop. As can be seen at the top of the diff ("if (0 <=
> weight(p))"), this only operates on commits with negative weights.
>
> Originally, the inner loop advances until a non-UNINTERESTING parent
> with a non-negative weight. If no such parent is found, at the end of
> the loop, q is NULL. The added code effectively replicates what's going
> on, but ignoring any parents after the first.
>
> A previous reviewer [1] wanted an explanation for this part, so thanks
> for attempting to do that. But I don't understand the explanation -
> firstly, it is not a question of "can" (optional) but of "will"
> (mandatory), and it is not only UNINTERESTING that determines skipping,
> but weight as well.
>
> I would write the entire section like this (remember to wrap the lines):
>
>         if (first_parent) {
>                 q = p->item->parents;
>                 if (q && ((q->item->object.flags & UNINTERESTING) || weight(q) < 0))
>                         q = NULL;
>         } else {
>                 /*
>                  * Find an interesting parent with non-negative weight.
>                  */
>                 for (...) {
>                 }
>         }
>

"uninteresting" was meant in the colloquial sense rather than the
CONSTANT, but fair, it's probably just confusing.

> Looking at the rest of do_find_bisection():
>
> - I don't see any other parts that would be affected by only calculating
>   weights based on the first parent, so that's fine.
>
> - There are some early returns that assume that "list" is generated by
>   iterating only over first parents. do_find_bisection() is called only
>   by find_bisection(), and the latter is called only by cmd_rev_list()
>   and bisect_next_all(). The former is fine, but I will discuss the
>   latter later.
>
> - I do see some unclear parts (in particular, counter might not reach nr
>   if any of the weights are 0 and if the "weight_set(p, weight(q));"
>   line is reached, potentially resulting in an infinite loop) but that
>   is unrelated to this patch, so don't worry about it.
>
> [1] https://public-inbox.org/git/nycvar.QRO.7.76.6.1808281512240.73@tvgsbejvaqbjf.bet/
>
> > @@ -964,7 +981,12 @@ int bisect_next_all(struct repository *r, const char *prefix, int no_checkout)
> >
> >       bisect_common(&revs);
> >
> > -     find_bisection(&revs.commits, &reaches, &all, !!skipped_revs.nr);
> > +     if (skipped_revs.nr)
> > +             bisect_flags |= BISECT_FIND_ALL;
> > +     if (revs.first_parent_only)
> > +             bisect_flags |= BISECT_FIRST_PARENT;
> > +
> > +     find_bisection(&revs.commits, &reaches, &all, bisect_flags);
> >       revs.commits = managed_skipped(revs.commits, &tried);
> >
> >       if (!revs.commits) {
>
> I don't see how revs.first_parent_only is ever set in this function. If
> it's never set, undo this change, since this code is never executed.

In this function, we call bisect_rev_setup() using the revs struct we
made, which then calls setup_revisions() on the revs, which appears to
call handle_revision_opt() with that struct again,which finally is
allowed to set revs->first_parent_only = 1; in revision.c.

So unless I am horribly misreading something, we do set it.

> > diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
> > index b8cf82349b..95949e4ff1 100755
> > --- a/t/t6000-rev-list-misc.sh
> > +++ b/t/t6000-rev-list-misc.sh
> > @@ -122,8 +122,8 @@ test_expect_success 'rev-list can negate index objects' '
> >       test_cmp expect actual
> >  '
> >
> > -test_expect_success '--bisect and --first-parent can not be combined' '
> > -     test_must_fail git rev-list --bisect --first-parent HEAD
> > +test_expect_success '--bisect and --first-parent CAN be combined' '
> > +     git rev-list --bisect --first-parent HEAD
> >  '
> >
>
> I think this test can just be deleted. It is tested in t6002.

Sure, I'll drop it.

> > diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
> > index a661408038..6caf2af650 100755
> > --- a/t/t6002-rev-list-bisect.sh
> > +++ b/t/t6002-rev-list-bisect.sh
> > @@ -263,4 +263,58 @@ test_expect_success 'rev-parse --bisect can default to good/bad refs' '
> >       test_cmp expect.sorted actual.sorted
> >  '
> >
> > +# --first-parent tests
> > +
> > +# --bisect --first-parent should pluck out the middle.
> > +printf "%s\n" e4 |
> > +test_output_expect_success "--bisect --first-parent" '
> > +     git rev-list --bisect --first-parent E ^F
> > +'
> > +
> > +printf "%s\n" E e1 e2 e3 e4 e5 e6 e7 e8 |
> > +test_output_expect_success "--first-parent" '
> > +     git rev-list --first-parent E ^F
> > +'
> > +
> > +test_output_expect_success '--bisect-vars --first-parent' '
> > +     git rev-list --bisect-vars --first-parent E ^F
> > +' <<-EOF
> > +     bisect_rev='e5'
> > +     bisect_nr=4
> > +     bisect_good=4
> > +     bisect_bad=3
> > +     bisect_all=9
> > +     bisect_steps=2
> > +EOF
>
> Looks good, except for the middle test - that should already be working
> even before the current patch, right? If there's a reason for including
> it anyway, mention it in the commit message.

Also cutting, I think.

> > +test_expect_success '--bisect-all --first-parent returns correct order' '
> > +     git rev-list --bisect-all --first-parent E ^F >actual &&
> > +
> > +     # Make sure the entries are sorted in the dist order
> > +     sed -e "s/.*dist=\([0-9]\).*/\1/" actual >actual.dists &&
> > +     sort -r -n actual.dists >actual.dists.sorted &&
> > +     test_cmp actual.dists.sorted actual.dists
> > +'
> > +
> > +# NEEDSWORK: this test could afford being hardened against other
> > +# changes in the same file.
> > +test_expect_success '--bisect-all --first-parent compares correctly' '
> > +     cat >expect <<-EOF &&
> > +     $(git rev-parse tags/e5) (tag: e5, dist=4)
> > +     $(git rev-parse tags/e4) (tag: e4, dist=4)
> > +     $(git rev-parse tags/e6) (tag: e6, dist=3)
> > +     $(git rev-parse tags/e3) (tag: e3, dist=3)
> > +     $(git rev-parse tags/e7) (tag: e7, dist=2)
> > +     $(git rev-parse tags/e2) (tag: e2, dist=2)
> > +     $(git rev-parse tags/e8) (tag: e8, dist=1)
> > +     $(git rev-parse tags/e1) (tag: e1, dist=1)
> > +     $(git rev-parse tags/E) (tag: E, dist=0)
> > +EOF
> > +
> > +git rev-list --bisect-all --first-parent E ^F >actual &&
> > +     sort actual >actual.sorted &&
> > +     sort expect >expect.sorted &&
> > +     test_cmp expect.sorted actual.sorted
> > +'
>
> I think these 2 tests can be combined, since the latter also checks the
> dists. Also, correct the indentation of the latter test.

I understand they are similar tests, but... Is there a tangible
reason for combining them? Especially when their logic can
live and breathe completely separately, compacting tests
reduces the resolution of the information we can extract from failure.

I would rather simply drop one and preserve 1 test = 1 data point.

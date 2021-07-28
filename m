Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B936BC4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 19:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 989F461040
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 19:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhG1Tif (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 15:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhG1Tie (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 15:38:34 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C41C061757
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 12:38:32 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id gs8so6346141ejc.13
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 12:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PCXTzXSBeL8WNQ7L3QAHnCFmeuFTxyEhgAL7P0ArfQU=;
        b=pZI4u8xHU31H03+Z0rIWVPdZflLbVoh7MLX7//D1Ya/ki3yJUlMq8noH2DWqv0uJXu
         ij3V1rI10OVuilpz0zOHMqv7vO6L5wD2ftPHi4ew1pKWNxOoy9xI2qI3IxCN3Cle1M2c
         uoS5u1TPGJcpdgnQlUxDwTYoVIbHWl4kfvJ1ktPsTMbCnnN++jmY4gca3EiroR0JAbj6
         lVA48oMSEE2wHdo2c4pUO/d8p8nD1AGlR7NrA1GelOubmPhQZafT+6MfXRy9hplhyEz2
         a+ypcfj3A/cya9AzAIw63TBhtDTB648EzDVSHVCcPpYn+EX1Gosuw/Em+3oHPPERWzub
         9XQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PCXTzXSBeL8WNQ7L3QAHnCFmeuFTxyEhgAL7P0ArfQU=;
        b=gTifaXCUPT8OJ1mcdA8edWP0Omsf910K+zUa6mUXdAeAnbDV9HS0Brm3RPSb9FBGvK
         fyIE1wF+tjvu5qtOi6ymcVp8xLykGvGjZih4M1/r5jXn72O8r7zbqzqKs618w95zl9VJ
         hOi3u3kPFgXfmKOg70tyWJLB5Mo+26V/7OJsQb4XignFRkEIT7wqIckUuIFXq1AQQhY0
         VnMxL/rez0vGj9Gch9eH7A020S1caHyV60tbU2S0Sz6fYhDZfcDJeo+EC5nAu1KvY5Ih
         NxQli7l5J6YNvMt4Umia2ZdjLt9gusXK5YsqQD1x2+Wr+5/JRhnwCiaIs3/rrIAy+tpb
         mnOw==
X-Gm-Message-State: AOAM5314VdejuZ0uIrwWRFv4CHJLgqd4LDzAN9+jl9A5gHohjhjxBl70
        0RjCC6rURKrx8O8df9MWR/+uMtetTQa6qTpO4qHrpw==
X-Google-Smtp-Source: ABdhPJzDhmPUWlCYhEWizgs9aebLy4TrLUn/HLHQdnpn49w+OBP/BU6ohB4ha/WSHt1WDu/RGzmF2neJMthvmbW+MLE=
X-Received: by 2002:a17:906:f1c4:: with SMTP id gx4mr1049604ejb.410.1627501111335;
 Wed, 28 Jul 2021 12:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210728024434.20230-1-jerry@skydio.com> <xmqqh7gfawlt.fsf@gitster.g>
In-Reply-To: <xmqqh7gfawlt.fsf@gitster.g>
From:   Jerry Zhang <jerry@skydio.com>
Date:   Wed, 28 Jul 2021 12:38:20 -0700
Message-ID: <CAMKO5CvZCMHuzRLSs2aHJ3iUH-LBJfFP3fG+GgwtQvsKQPtT5Q@mail.gmail.com>
Subject: Re: [PATCH] git-apply: fix --3way with binary patch
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, lilinchao@oschina.cn
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 27, 2021 at 9:30 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jerry Zhang <jerry@skydio.com> writes:
>
> > Binary patches applied with "--3way" will
> > always return a conflict even if the patch
> > should cleanly apply because the low level
> > merge function considers all binary merges
> > without a variant to be conflicting.
> >
> > Fix by falling back to normal patch application
> > for all binary patches.
> >
> > Add tests for --3way and normal applications
> > of binary patches.
> >
> > Fixes: 923cd87ac8 ("git-apply: try threeway first when "--3way" is used")
> > Signed-off-by: Jerry Zhang <jerry@skydio.com>
> > ---
> >  apply.c                   |  3 ++-
> >  t/t4108-apply-threeway.sh | 45 +++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 47 insertions(+), 1 deletion(-)
> >
> > diff --git a/apply.c b/apply.c
> > index 1d2d7e124e..78e52f0dc1 100644
> > --- a/apply.c
> > +++ b/apply.c
> > @@ -3638,7 +3638,8 @@ static int apply_data(struct apply_state *state, struct patch *patch,
> >       if (load_preimage(state, &image, patch, st, ce) < 0)
> >               return -1;
> >
> > -     if (!state->threeway || try_threeway(state, &image, patch, st, ce) < 0) {
> > +     if (!state->threeway || patch->is_binary ||
> > +             try_threeway(state, &image, patch, st, ce) < 0) {
>
> Thanks for a quick turnaround.  However.
>
> Because apply.c::three_way_merge() calls into ll_merge() that lets
> the low-level custom merge drivers to take over the actual merge, I
> do not think your "if binary, bypass and never call try_threway() at
> all" is the right solution.  The custom merge driver user uses for
> the path may successfully perform such a "trivial" three-way merge
> and return success.
I understand now, thanks for the explanation
>
> Why does the current code that lets threeway tried first fails to
> fall back to direct application?  The code before your change, if
> fed a binary patch that does not apply, would have failed the direct
> application first *and* then fell back to the threeway (if only to
> fail because we do not let binary files be merged), no?
>
> Is it that try_threeway()'s way to express failure slightly
> different from how direct application reports failure, but your
> change used the same "only if it is negative, we fail and fallback"
> logic?  IIRC, apply_fragments() which is the meat of the direct
> application logic reports failures by negative, but try_threeway()
> can return positive non-zero to signal a "recoverable" failure (aka
> "conflicted merge").  Which should lead us to explore a different
> approach, which is ...
>
>     Would it be possible for a patch to leave conflicts when
>     try_threeway() was attempted, but will cleanly apply if direct
>     application is done?
>
> If so, perhaps
>
>  - we first run try_threeway() and see if it cleanly resolves; if
>    so, we are done.
>
>  - then we try direct application and see if it cleanly applies; if
>    so, we are done.
>
>  - finally we run try_threeway() again and let it fail with
>    conflict.
>
> might be the right sequence?  We theoretically could omit the first
> of these three steps, but that would mean we'd write 923cd87a
> (git-apply: try threeway first when "--3way" is used, 2021-04-06)
> off as a failed experiment and revert it, which would not be ideal.
>
>
> Also, independent from this "if we claim we try threeway first and
> fall back to direct application, we really should do so" fix we are
> discussing, I think our default binary merge can be a bit more
> lenient and resolve this particular case of applying the binary
> patch taken from itself (i.e. a patch that takes A to B gets applied
> using --3way option to A).  I wonder if it can be as simple as the
> attached patch.  FWIW, this change is sufficient (without the change
> to apply.c we are reviewing here) to make your new tests in t4108
> pass.
So basically, another way of stating the problem would be that binary
patches can apply cleanly with direct application in some cases where
merge application is not clean. If i understand correctly this is unique
to binary files, although it would be possible for a user to supply a custom
merge driver for text files that is worse than direct application, that is
most likely heavy user error that we shouldn't have to cater to. However
the issue with binary is that the *default* merge driver is actually worse
than direct application (in some cases). Therefore our options are

1. do as you suggest and run 3way -> direct -> 3way. I would modify
this and say we should only attempt this for binary patches, since a text
file that fails 3way would most likely also fail direct, so it would be a waste
of time to try it. furthermore if we cache results from the first 3way and
return them after attempting direct, it can save us from having to compute
the 3way twice, so would be no worse than our current performance.

2. improve the default binary merge driver to be at least as good as direct
application. this would allow us to say overall that "merge drivers should
be at least as intelligent as direct patch application" and would greatly
simplify logic in apply.c. Your change is a good first step in allowing it
to handle more cases. A trivial way to make the binary merge driver
at least as good as patch application is to generate a patch and apply
it as part of the merge. I imagine this would have other consequences
though as many parts of git use the binary merge driver.

Separately I think it would be a worthwhile follow-up patch to also handle
trivial three-way merges in try_threeway(). This would:
1. Allow us to compare oid instead of the entire file buffer, which would be
faster.
2. Handle trivial merges of all file types, which would save time.

>
> ---- >8 ------- >8 ------- >8 ------- >8 ------- >8 ------- >8 ----
> Subject: ll-merge: teach ll_binary_merge() a trivial three-way merge
>
> The low-level binary merge code assumed that the caller will not
> feed trivial merges that would have been resolved at the tree level;
> because of this, ll_binary_merge() assumes the ancestor is different
> from either side, always failing the merge in conflict unless -Xours
> or -Xtheirs is in effect.
>
> But "git apply --3way" codepath could ask us to perform three-way
> merge between two binaries A and B using A as the ancestor version.
> The current code always fails such an application, but when given a
> binary patch that turns A into B and asked to apply it to A, there
> is no reason to fail such a request---we can trivially tell that the
> result must be B.
>
> Arguably, this fix may belong to one level higher at ll_merge()
> function, which dispatches to lower-level merge drivers, possibly
> even before it renormalizes the three input buffers.  But let's
> first see how this goes.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  ll-merge.c | 56 +++++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 39 insertions(+), 17 deletions(-)
>
> diff --git c/ll-merge.c w/ll-merge.c
> index 261657578c..bc8038d404 100644
> --- c/ll-merge.c
> +++ w/ll-merge.c
> @@ -46,6 +46,13 @@ void reset_merge_attributes(void)
>         merge_attributes = NULL;
>  }
>
> +static int same_mmfile(mmfile_t *a, mmfile_t *b)
> +{
> +       if (a->size != b->size)
> +               return 0;
> +       return !memcmp(a->ptr, b->ptr, a->size);
> +}
> +
>  /*
>   * Built-in low-levels
>   */
> @@ -58,9 +65,18 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
>                            const struct ll_merge_options *opts,
>                            int marker_size)
>  {
> +       int status;
>         mmfile_t *stolen;
>         assert(opts);
>
> +       /*
> +        * With -Xtheirs or -Xours, we have cleanly merged;
> +        * otherwise we got a conflict, unless 3way trivially
> +        * resolves.
> +        */
> +       status = (opts->variant == XDL_MERGE_FAVOR_OURS ||
> +                 opts->variant == XDL_MERGE_FAVOR_THEIRS) ? 0 : 1;
> +
>         /*
>          * The tentative merge result is the common ancestor for an
>          * internal merge.  For the final merge, it is "ours" by
> @@ -68,18 +84,30 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
>          */
>         if (opts->virtual_ancestor) {
>                 stolen = orig;
> +               status = 0;
>         } else {
> -               switch (opts->variant) {
> -               default:
> -                       warning("Cannot merge binary files: %s (%s vs. %s)",
> -                               path, name1, name2);
> -                       /* fallthru */
> -               case XDL_MERGE_FAVOR_OURS:
> -                       stolen = src1;
> -                       break;
> -               case XDL_MERGE_FAVOR_THEIRS:
> +               if (same_mmfile(orig, src1)) {
>                         stolen = src2;
> -                       break;
> +                       status = 0;
> +               } else if (same_mmfile(orig, src2)) {
> +                       stolen = src1;
> +                       status = 0;
> +               } else if (same_mmfile(src1, src2)) {
> +                       stolen = src1;
> +                       status = 0;
> +               } else {
> +                       switch (opts->variant) {
> +                       default:
> +                               warning("Cannot merge binary files: %s (%s vs. %s)",
> +                                       path, name1, name2);
> +                               /* fallthru */
> +                       case XDL_MERGE_FAVOR_OURS:
> +                               stolen = src1;
> +                               break;
> +                       case XDL_MERGE_FAVOR_THEIRS:
> +                               stolen = src2;
> +                               break;
> +                       }
>                 }
>         }
>
> @@ -87,13 +115,7 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
>         result->size = stolen->size;
>         stolen->ptr = NULL;
>
> -       /*
> -        * With -Xtheirs or -Xours, we have cleanly merged;
> -        * otherwise we got a conflict.
> -        */
> -       return opts->variant == XDL_MERGE_FAVOR_OURS ||
> -              opts->variant == XDL_MERGE_FAVOR_THEIRS ?
> -              0 : 1;
> +       return status;
>  }
>
>  static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B105CECAAA3
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 13:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344120AbiHZNPo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 09:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344185AbiHZNPf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 09:15:35 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED2524BE0
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 06:15:32 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-3376851fe13so35007557b3.6
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 06:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=xJFts0btAUza12kFNcQn75la7jTqd/JOXwe405X8GHo=;
        b=qDPRakPGTs97qSzyApLfKSsWKqiuWUdT3ZVME1K/cnGQxrheV36cDgyYRB2izIQ0yt
         tqJH78v86tQPntH5jQN09LNSvmpeVv00dtjQSg9QOflDHPEe6wnQtiVNty4PAlGNvd7+
         aD4k5HMkFK4kDAwQEJZ/9suffDHH8x0yQLUWqMQNnlKMJ3YOY3J+r7zG6oI058ttVm0N
         fX0MU4E03Y3tnByvrXQrddCWZ6JAshukdK9BpapwOovbKxl3kSuENTyBKB5l7bQgn0Sh
         h+6VV9pK9bXaBn67cm+oCle8SI0Zmu2+i/4L793rTPBfMC7MGQqrA7wToLNiV1M8taw0
         6Lig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=xJFts0btAUza12kFNcQn75la7jTqd/JOXwe405X8GHo=;
        b=pINMY568uS8xgYQruSmf2MXQ7tPsP8EXLbTqse2Oz5NNqTRwiDdEq99iplO9lEyxJi
         DeLu9OSs3MRMPTtjEAsGVsT6bGRd9I06uvKE6Q9KzViQ7ly+7JSp6fsYjWq4+sX91edD
         a5nBcRvJ8YbkrM9r4KtoGg/LDbOFXiAxy14vhNYqkZU+HCB4pW35TmMNwV67XEpvKwqV
         fretiJKRXNipRO2o23tLMhhgypKpwAVQ7cg0l+CY9BPZNPbiy/0yNb4tpH0mkBdpXw29
         6HyCzxQNhbpqPX+ivPgHnbU4O4K2sMHP7htke25mjy2W6KSxiEWEOlnEpdYey9zBbJml
         HKUw==
X-Gm-Message-State: ACgBeo0h63R5XN1UygFe+9hBKGFmRRwFa0pPwbCIMVOqVvhPoEkVchol
        rCSwK39+Zy1oUNKRvcA9gJH3HbVdE3boMfkXvio=
X-Google-Smtp-Source: AA6agR6mMvwvZVYsGrx6ONfSmCmG2wkmq9p31VHLgl08K+/R0CBG0pngrnImpMwA6JDxAiWg0q3Ii9Ec4on6CsjcwK4=
X-Received: by 2002:a5b:4c7:0:b0:676:13b:fd63 with SMTP id u7-20020a5b04c7000000b00676013bfd63mr7486330ybp.444.1661519731588;
 Fri, 26 Aug 2022 06:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <Yv9Oay+tNqhLDqVl@coredump.intra.peff.net> <Yv9OpXIQ9dYMQJ4B@coredump.intra.peff.net>
 <CAPoeCOa6BDsunamy7_GtaSy-gL_0r3kAwDJ7ffA_uiFUzhen9w@mail.gmail.com>
 <YwCGJLJU2+ui+hvn@coredump.intra.peff.net> <YwCO+WE2Z+sJofEb@coredump.intra.peff.net>
In-Reply-To: <YwCO+WE2Z+sJofEb@coredump.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
Date:   Fri, 26 Aug 2022 14:15:20 +0100
Message-ID: <CAPoeCOZFua+VvwBPix2M-8sRhfhymFCpejOPbCERtCp7fZ9FWQ@mail.gmail.com>
Subject: Re: [PATCH 7/6] xdiff: drop unused mmfile parameters from xdl_do_patience_diff()
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff

On Sat, 20 Aug 2022 at 08:36, Jeff King <peff@peff.net> wrote:
>
> On Sat, Aug 20, 2022 at 02:58:44AM -0400, Jeff King wrote:
>
> > > Looking at the xpatience.c I think we can remove the mmfile_t
> > > parameters there as well, they are only end up being used because
> > > patience_diff() gets called recursively. I'm about to go off list for
> > > a week, but I can look at putting a patch together for that when I get
> > > back unless you want to.
> >
> > I wondered that, too, but they also get passed in to fill_hashmap(),
> > which records the pointers in its "struct hashmap". It looks like those
> > fields are never accessed, though, and could even be removed from the
> > struct entirely!
> >
> > So I think there is some room for cleanup.
>
> And here's a patch, so we don't forget about it. It could be applied
> independently of this series, but there's a small textual dependency
> since we're touching a line close to the related histogram cleanup.
>
> Thanks for mentioning this. I had given only a cursory glance before,
> and just assumed it would be hard to trace. It turned out to be fun. :)

Yes, it took me a couple of minutes to realize that it wasn't doing
anything useful with the pointers in "struct hashmap" but it was quite
satisfying when I did. The patch looks good, thanks for putting it
together.

Best Wishes

Phillip

> Junio: this could go on top of the jk/unused-fixes topic.
>
> -- >8 --
> Subject: xdiff: drop unused mmfile parameters from xdl_do_patience_diff()
>
> The entry point to the patience-diff algorithm takes two mmfile_t
> structs with the original file contents, but it doesn't actually do
> anything useful with them. This is similar to the case recently cleaned
> up in the histogram code via f1d019071e (xdiff: drop unused mmfile
> parameters from xdl_do_histogram_diff(), 2022-08-19), but there's a bit
> more subtlety going on.
>
> We pass them into the recursive patience_diff(), which in turn passes
> them into fill_hashmap(), which stuffs the pointers into a struct. But
> the only thing which reads the struct fields is our recursion into
> patience_diff()!
>
> So it's unlikely that something like -Wunused-parameter could find this
> case: it would have to detect the circular dependency caused by the
> recursion (not to mention tracing across struct field assignments).
>
> But once found, it's easy to have the compiler confirm what's going on:
>
>   1. Drop the "file1" and "file2" fields from the hashmap struct
>      definition. Remove the assignments in fill_hashmap(), and
>      temporarily substitute NULL in the recursive call to
>      patience_diff(). Compiling shows that no other code touched those
>      fields.
>
>   2. Now fill_hashmap() will trigger -Wunused-parameter. Drop "file1"
>      and "file2" from its definition and callsite.
>
>   3. Now patience_diff() will trigger -Wunused-parameter. Drop them
>      there, too. One of the callsites is the recursion with our
>      NULL values, so those temporary values go away.
>
>   4. Now xdl_do_patience_diff() will trigger -Wunused-parameter. Drop
>      them there. And we're done.
>
> Suggested-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Explaining the 4 steps is probably overkill, but I found it a little
> interesting how one can bend the compiler to their will here. At least I
> didn't make it a series of 4 patches. ;)
>
>  xdiff/xdiffi.c    |  2 +-
>  xdiff/xdiffi.h    |  3 +--
>  xdiff/xpatience.c | 23 +++++++----------------
>  3 files changed, 9 insertions(+), 19 deletions(-)
>
> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
> index 8c64519eac..32652ded2d 100644
> --- a/xdiff/xdiffi.c
> +++ b/xdiff/xdiffi.c
> @@ -321,7 +321,7 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
>                 return -1;
>
>         if (XDF_DIFF_ALG(xpp->flags) == XDF_PATIENCE_DIFF) {
> -               res = xdl_do_patience_diff(mf1, mf2, xpp, xe);
> +               res = xdl_do_patience_diff(xpp, xe);
>                 goto out;
>         }
>
> diff --git a/xdiff/xdiffi.h b/xdiff/xdiffi.h
> index 9d988e0263..126c9d8ff4 100644
> --- a/xdiff/xdiffi.h
> +++ b/xdiff/xdiffi.h
> @@ -56,8 +56,7 @@ int xdl_build_script(xdfenv_t *xe, xdchange_t **xscr);
>  void xdl_free_script(xdchange_t *xscr);
>  int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
>                   xdemitconf_t const *xecfg);
> -int xdl_do_patience_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
> -               xdfenv_t *env);
> +int xdl_do_patience_diff(xpparam_t const *xpp, xdfenv_t *env);
>  int xdl_do_histogram_diff(xpparam_t const *xpp, xdfenv_t *env);
>
>  #endif /* #if !defined(XDIFFI_H) */
> diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
> index fe39c2978c..a2d8955537 100644
> --- a/xdiff/xpatience.c
> +++ b/xdiff/xpatience.c
> @@ -69,7 +69,6 @@ struct hashmap {
>         } *entries, *first, *last;
>         /* were common records found? */
>         unsigned long has_matches;
> -       mmfile_t *file1, *file2;
>         xdfenv_t *env;
>         xpparam_t const *xpp;
>  };
> @@ -139,13 +138,10 @@ static void insert_record(xpparam_t const *xpp, int line, struct hashmap *map,
>   *
>   * It is assumed that env has been prepared using xdl_prepare().
>   */
> -static int fill_hashmap(mmfile_t *file1, mmfile_t *file2,
> -               xpparam_t const *xpp, xdfenv_t *env,
> +static int fill_hashmap(xpparam_t const *xpp, xdfenv_t *env,
>                 struct hashmap *result,
>                 int line1, int count1, int line2, int count2)
>  {
> -       result->file1 = file1;
> -       result->file2 = file2;
>         result->xpp = xpp;
>         result->env = env;
>
> @@ -254,8 +250,7 @@ static int match(struct hashmap *map, int line1, int line2)
>         return record1->ha == record2->ha;
>  }
>
> -static int patience_diff(mmfile_t *file1, mmfile_t *file2,
> -               xpparam_t const *xpp, xdfenv_t *env,
> +static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
>                 int line1, int count1, int line2, int count2);
>
>  static int walk_common_sequence(struct hashmap *map, struct entry *first,
> @@ -286,8 +281,7 @@ static int walk_common_sequence(struct hashmap *map, struct entry *first,
>
>                 /* Recurse */
>                 if (next1 > line1 || next2 > line2) {
> -                       if (patience_diff(map->file1, map->file2,
> -                                       map->xpp, map->env,
> +                       if (patience_diff(map->xpp, map->env,
>                                         line1, next1 - line1,
>                                         line2, next2 - line2))
>                                 return -1;
> @@ -326,8 +320,7 @@ static int fall_back_to_classic_diff(struct hashmap *map,
>   *
>   * This function assumes that env was prepared with xdl_prepare_env().
>   */
> -static int patience_diff(mmfile_t *file1, mmfile_t *file2,
> -               xpparam_t const *xpp, xdfenv_t *env,
> +static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
>                 int line1, int count1, int line2, int count2)
>  {
>         struct hashmap map;
> @@ -346,7 +339,7 @@ static int patience_diff(mmfile_t *file1, mmfile_t *file2,
>         }
>
>         memset(&map, 0, sizeof(map));
> -       if (fill_hashmap(file1, file2, xpp, env, &map,
> +       if (fill_hashmap(xpp, env, &map,
>                         line1, count1, line2, count2))
>                 return -1;
>
> @@ -374,9 +367,7 @@ static int patience_diff(mmfile_t *file1, mmfile_t *file2,
>         return result;
>  }
>
> -int xdl_do_patience_diff(mmfile_t *file1, mmfile_t *file2,
> -               xpparam_t const *xpp, xdfenv_t *env)
> +int xdl_do_patience_diff(xpparam_t const *xpp, xdfenv_t *env)
>  {
> -       return patience_diff(file1, file2, xpp, env,
> -                       1, env->xdf1.nrec, 1, env->xdf2.nrec);
> +       return patience_diff(xpp, env, 1, env->xdf1.nrec, 1, env->xdf2.nrec);
>  }
> --
> 2.37.2.931.g60e3983abc
>

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73D0C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 00:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A57246112F
	for <git@archiver.kernel.org>; Thu, 20 May 2021 00:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhETAuZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 20:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhETAuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 20:50:25 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2094C061574
        for <git@vger.kernel.org>; Wed, 19 May 2021 17:49:04 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id x15so14805809oic.13
        for <git@vger.kernel.org>; Wed, 19 May 2021 17:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GQnFSKYkANWeRSMO1m2pxtRUPRC7b/xemTB4OtuAndA=;
        b=Y7EOsrQAF9fFcwOUgfI5oUx+spECqoDSkIQkiOhHYf+n9fUCPdhCiStQ3BkC1+cjnN
         /4EY3hW7+zpbk9ii2pwNEG0IcAvX/FA1pFbu+fz7CwxMQR6XVknhAMamWJw+URen8v9l
         /dN/t2VbVTAtxTF/j0dHNMBXMBw5ZehnvFtLfSjbCoTvAHijH1XXwMKS3cRrij6pGy3K
         r/neSIfuaOlAieorUWtvHdc5xxXg1zRPjKAfy1tGuVi8Rt0IWCmVKnAXQh2qTKaHUKi6
         iPDVcd/X/rQnb2J1DzpNFFhDpWDbjR8B6SD+2UIZ0nl8NOlEkwEl1C2zdg51Tlc5c/8M
         YsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GQnFSKYkANWeRSMO1m2pxtRUPRC7b/xemTB4OtuAndA=;
        b=E/7GQuOZHITNHAHlfNTW8MS8YCQ6EP7qyOnjzFqsxNNKI5vyVlEfA/lk9bMCSjI1Mf
         U/y/pmsl8RR3e9Pb1kDTFdNOTrbvdgTYWUOOxxHDaSXPGqltze+8lfwPAxbz5rsW6aaS
         dIV8BKGMIjNiuwMP40vdDEzkSRnJpG0nYFmAsMmG1zCec6yR+UxpVdxXq/+Mriglr+/9
         lPgKBEsnNbEKc82aYyTuwuRcSlf6smGZxw4E80nDAXQYp/9D4/z/+iKTXZ+YyAxeCyV+
         XfDCxFHbof3WGBWSJMi66ab5Pxd6XMggKzo/K1uZapkTd70pCOnH5do5EetA5cXLiUjA
         4QAQ==
X-Gm-Message-State: AOAM532LDPEHQM86T+ToYvPD34BFW+EjyAsivlc7tHckpJd5yY8oIgFj
        fGIkdNC2pK5vKWSql7Rrk73Im6zl1VTWddOMYfk+CK6Q1mQ=
X-Google-Smtp-Source: ABdhPJxkmyshhu4Bn1qMZT45QYuVvgiZfoEv+E9aVEYdOdr+gxZgz2i2v3VoZIo4uApbqRnXiWFSontzDLGQznFFHqw=
X-Received: by 2002:aca:3e05:: with SMTP id l5mr1533626oia.39.1621471744028;
 Wed, 19 May 2021 17:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <pull.859.git.1616621553.gitgitgadget@gmail.com>
 <pull.859.v2.git.1620094339.gitgitgadget@gmail.com> <02d517f052a35a952c726e7e941650ce424abb85.1620094339.git.gitgitgadget@gmail.com>
 <df8260bf-0990-a2df-86be-0059ca561751@gmail.com>
In-Reply-To: <df8260bf-0990-a2df-86be-0059ca561751@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 19 May 2021 17:48:53 -0700
Message-ID: <CABPp-BH79AC+k99djq28my=3VyyszR4=uRhSU8Ouy=P9WmiSCw@mail.gmail.com>
Subject: Re: [PATCH v2 07/13] merge-ort: populate caches of rename detection results
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 17, 2021 at 6:51 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 5/3/21 10:12 PM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Fill in cache_pairs, cached_target_names, and cached_irrelevant based on
> > rename detection results.  Future commits will make use of these values.
>
> Thank you for continuing to break this down into nice-sized pieces.
>
> > +static void possibly_cache_new_pair(struct rename_info *renames,
> > +                                 struct diff_filepair *p,
> > +                                 unsigned side,
> > +                                 char *new_path)
> > +{
> > +     char *old_value;
> > +     int dir_renamed_side = 0;
> > +
> > +     if (new_path) {
> > +             /*
> > +              * Directory renames happen on the other side of history from
> > +              * the side that adds new files to the old directory.
> > +              */
> > +             dir_renamed_side = 3 - side;
>
> Neat trick. Side is in { 1, 2 } so this makes sense.
>
> > +     } else {
> > +             int val = strintmap_get(&renames->relevant_sources[side],
> > +                                     p->one->path);
> > +             if (val == RELEVANT_NO_MORE) {
> > +                     assert(p->status == 'D');
> > +                     strset_add(&renames->cached_irrelevant[side],
> > +                                p->one->path);
>
> Ok, I see a transition here from a relevant side to an
> irrelevant one.
>
> > +             }
> > +             if (val <= 0)
> > +                     return;
> > +     }
> > +
> > +     if (p->status == 'D') {
> > +             /*
> > +              * If we already had this delete, we'll just set it's value
> > +              * to NULL again, so no harm.
> > +              */
> > +             strmap_put(&renames->cached_pairs[side], p->one->path, NULL);
> > +     } else if (p->status == 'R') {
> > +             if (new_path) {
> > +                     new_path = xstrdup(new_path);
> > +                     old_value = strmap_put(&renames->cached_pairs[dir_renamed_side],
> > +                                            p->two->path, new_path);
> > +                     strset_add(&renames->cached_target_names[dir_renamed_side],
> > +                                new_path);
> > +                     assert(!old_value);
>
> This assert implies that p->status == 'R' only if this is the
> first side (and first commit) to show a rename, right?

Um, this assert implies that p->two->path was not already found in
renames->cached_pairs[dir_renamed_side].

>
> > +             }
> > +             if (!new_path)
> > +                     new_path = p->two->path;
> > +             new_path = xstrdup(new_path);
>
> If new_path was provided as non-NULL, then this is the second
> time we are dup-ing it. However, that seems correct because we
> want a different copy or every time we add it to the cached_pairs
> and cached_target_names data.
>
> > +             old_value = strmap_put(&renames->cached_pairs[side],
> > +                                    p->one->path, new_path);
> > +             strset_add(&renames->cached_target_names[side],
> > +                        new_path);
>
> Since we appear to be doing this in multiple places, would this
> be a good place for a helper method? We could have it take a
> `const char *new_path` and have the helper manage the `xstrdup()`
> so we never forget to do that exactly once per insert to these
> sets.

Makes sense.

> > +             free(old_value);
> > +     } else if (p->status == 'A' && new_path) {
> > +             new_path = xstrdup(new_path);
> > +             old_value = strmap_put(&renames->cached_pairs[dir_renamed_side],
> > +                                    p->two->path, new_path);
> > +             strset_add(&renames->cached_target_names[dir_renamed_side],
> > +                        new_path);
> > +             assert(!old_value);
>
> And here's the third instance, making the "three is many" rule
> kick in. A helper method would help make this easier. You can
> also have a parameter corresponding to whether you need to
> free() the old_value or assert it is NULL.

Yep, I'll add a helper.

>
> > +     }
> > +}
> > +
> >  static int compare_pairs(const void *a_, const void *b_)
> >  {
> >       const struct diff_filepair *a = *((const struct diff_filepair **)a_);
> > @@ -2415,6 +2474,7 @@ static int collect_renames(struct merge_options *opt,
> >               char *new_path; /* non-NULL only with directory renames */
> >
> >               if (p->status != 'A' && p->status != 'R') {
> > +                     possibly_cache_new_pair(renames, p, side_index, NULL);
> >                       diff_free_filepair(p);
> >                       continue;
> >               }
> > @@ -2426,11 +2486,11 @@ static int collect_renames(struct merge_options *opt,
> >                                                     &collisions,
> >                                                     &clean);
> >
> > +             possibly_cache_new_pair(renames, p, side_index, new_path);
> >               if (p->status != 'R' && !new_path) {
> >                       diff_free_filepair(p);
> >                       continue;
> >               }
> > -
>
> nit: this deletion seems unnecessary.

Will fix.

> >               if (new_path)
> >                       apply_directory_rename_modifications(opt, p, new_path);
> >
> > @@ -3701,8 +3761,16 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
> >                                        NULL, 1);
> >               strmap_init_with_options(&renames->dir_renames[i],
> >                                        NULL, 0);
> > +             /*
> > +              * relevant_sources uses -1 for the default, because we need
> > +              * to be able to distinguish not-in-strintmap from valid
> > +              * relevant_source values from enum file_rename_relevance.
> > +              * In particular, possibly_cache_new_pair() expects a negative
> > +              * value for not-found entries.
> > +              */
> >               strintmap_init_with_options(&renames->relevant_sources[i],
> > -                                         0, NULL, 0);
> > +                                         -1 /* explicitly invalid */,
> > +                                         NULL, 0);
> >               strmap_init_with_options(&renames->cached_pairs[i],
> >                                        NULL, 1);
> >               strset_init_with_options(&renames->cached_irrelevant[i],
> >
>
> Functionally looks good. I just had some nits about organization.

As always, thanks for the review and the helpful suggestions!

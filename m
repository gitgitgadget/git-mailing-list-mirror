Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E510C4361B
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 22:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B31C2065D
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 22:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403858AbgLKV6J (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 16:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393025AbgLKV5r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 16:57:47 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896B7C0613CF
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 13:57:07 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id f16so9615424otl.11
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 13:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8F0+AsPQmFTORoEbox5WADChYj45lzeC2Fy+wMC64YQ=;
        b=LBDPRGIaPUHe3cJSbnlEJvWuQeE+lhjXXWNDdJEGSbrwrMRPvHf1uefdd4F42cpvdf
         71zwj8gaqO9vXalATSQlSsvqP/BYIE70Ubt9NxOa/VTjL0HqhCSpsG3QZ6Dp2jQ0EMP3
         rYjXj4CF5KThPSAdKRszGraYQcHZU5gqKmyZGIiEoWCafYSi+6ZXxRwzb3yOWt5i2XSz
         aFW6AirWtdrxiqkHES8Z+/xQOYIhk09h9yXCJ6uvK/KDCY8DcOwpKwaW4UWNGcDqzsOs
         DiDm20ljZ0rsgL84aFb0+cKeTjtijN0Nm4Cyla72fQLHbHgSvzfW88YxBnTHAkA+eLMm
         4w/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8F0+AsPQmFTORoEbox5WADChYj45lzeC2Fy+wMC64YQ=;
        b=l3vDqZakncvaC+90RlSZK2vMdt8SPcyEXSv4G7Xa80nhQzLZ89Y9TDnQGlWe5u2jUA
         tuqCujLVLeGGWGsH0LepI+X66UdrECTchxa/Mgh7UbK2+rzOBnKwBJBM6/uVAD5pqmNg
         gaKpFMBKyc3TKl/IXSz2ccogtc9Dnq873w4tnTNSjSUl03YCpPdU+7GW32nd+Zd8Jfua
         w6d4BbJGzjZRKGB6FoeZRO6LDguIBH6UoFd/jP8ZQamBg4hMdHnoSp/RtnGTrSszJuwP
         WWvkGGQvodgdliYIq9Y+Qj3Sot0Cn1bXmQFqs0OJtFB69FI2xK70jev3jAMJzOcbSESu
         j3bQ==
X-Gm-Message-State: AOAM5319VTjrtK0ml2uejLL62iKq/IorChmLVTg+VBV8tcCyfsToTPxG
        S/ti7zVxMgWUjzYs97t0Pmfl1y8eDDqjj6yunzg=
X-Google-Smtp-Source: ABdhPJyz2UCxM8+r2visU4aH3Rayx2yCbcnrCf9jCQoPDDpmYCH1gnk3qp/3C/T9YDc1xx7m8MCwcfdxj299zNbUy5c=
X-Received: by 2002:a05:6830:1610:: with SMTP id g16mr11375070otr.345.1607723826827;
 Fri, 11 Dec 2020 13:57:06 -0800 (PST)
MIME-Version: 1.0
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
 <d4595397052568ea6ea0cf46190374c74140fed7.1607542887.git.gitgitgadget@gmail.com>
 <5b9f5db0-b4d5-f60d-b5c5-2f8376d4bf12@gmail.com>
In-Reply-To: <5b9f5db0-b4d5-f60d-b5c5-2f8376d4bf12@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 11 Dec 2020 13:56:55 -0800
Message-ID: <CABPp-BE8Pjv6cPKBggWWyDutyb4686vXgJy4P-JqoH03KJzGdQ@mail.gmail.com>
Subject: Re: [PATCH 07/11] merge-ort: add implementation of both sides
 renaming differently
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 10, 2020 at 7:39 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 12/9/2020 2:41 PM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Implement rename/rename(1to2) handling, i.e. both sides of history
> > renaming a file and rename it differently.  This code replaces the
> > following from merge-recurisve.c:
> >
> >   * all the 1to2 code in process_renames()
> >   * the RENAME_ONE_FILE_TO_TWO case of process_entry()
> >   * handle_rename_rename_1to2()
> >
> > Also, there is some shared code from merge-recursive.c for multiple
> > different rename cases which we will no longer need for this case (or
> > other rename cases):
> >
> >   * handle_file_collision()
> >   * setup_rename_conflict_info()
> >
> > The consolidation of five separate codepaths into one is made possible
> > by a change in design:
>
> Excellent!
>
> >                       /* This is a rename/rename(1to2) */
> > -                     die("Not yet implemented");
> > +                     clean_merge = handle_content_merge(opt,
> > +                                                        pair->one->path,
> > +                                                        &base->stages[0],
> > +                                                        &side1->stages[1],
> > +                                                        &side2->stages[2],
> > +                                                        pathnames,
> > +                                                        1 + 2 * opt->priv->call_depth,
> > +                                                        &merged);
>
> (this method currently die()s. ok)
>
> > +                     if (!clean_merge &&
> > +                         merged.mode == side1->stages[1].mode &&
> > +                         oideq(&merged.oid, &side1->stages[1].oid)) {
> > +                             was_binary_blob = 1;
> > +                     }
>
> nit: Extraneous braces?

Yeah.

> > +                     memcpy(&side1->stages[1], &merged, sizeof(merged));
> > +                     if (was_binary_blob) {
> > +                             /*
> > +                              * Getting here means we were attempting to
> > +                              * merge a binary blob.
> > +                              *
> > +                              * Since we can't merge binaries,
> > +                              * handle_content_merge() just takes one
> > +                              * side.  But we don't want to copy the
> > +                              * contents of one side to both paths.  We
> > +                              * used the contents of side1 above for
> > +                              * side1->stages, let's use the contents of
> > +                              * side2 for side2->stages below.
> > +                              */
> > +                             oidcpy(&merged.oid, &side2->stages[2].oid);
> > +                             merged.mode = side2->stages[2].mode;
> > +                     }
> > +                     memcpy(&side2->stages[2], &merged, sizeof(merged));
> > +
> > +                     side1->path_conflict = 1;
> > +                     side2->path_conflict = 1;
> > +                     /*
> > +                      * TODO: For renames we normally remove the path at the
> > +                      * old name.  It would thus seem consistent to do the
> > +                      * same for rename/rename(1to2) cases, but we haven't
> > +                      * done so traditionally and a number of the regression
> > +                      * tests now encode an expectation that the file is
> > +                      * left there at stage 1.  If we ever decide to change
> > +                      * this, add the following two lines here:
> > +                      *    base->merged.is_null = 1;
> > +                      *    base->merged.clean = 1;
> > +                      * and remove the setting of base->path_conflict to 1.
> > +                      */
> > +                     base->path_conflict = 1;
>
> I'm getting the point of the review/evening where I'm starting to gloss
> over these important details. Time to take a break (after this patch).

I'm surprised you didn't take a break after giving a talk at GitHub
Universe earlier yesterday.  I don't think I got anything done the
rest of the day after I gave my talk at GitMerge 2020.  Nice job on
your talk, by the way; I'm sending it along to some others to watch.

> > +                     path_msg(opt, oldpath, 0,
> > +                              _("CONFLICT (rename/rename): %s renamed to "
> > +                                "%s in %s and to %s in %s."),
> > +                              pathnames[0],
> > +                              pathnames[1], opt->branch1,
> > +                              pathnames[2], opt->branch2);
>
> This output differs a bit from handle_rename_rename_1to2() in
> merge-recursive.c:
>
>         output(opt, 1, _("CONFLICT (rename/rename): "
>                "Rename \"%s\"->\"%s\" in branch \"%s\" "
>                "rename \"%s\"->\"%s\" in \"%s\"%s"),
>                o->path, a->path, ci->ren1->branch,
>                o->path, b->path, ci->ren2->branch,
>                opt->priv->call_depth ? _(" (left unresolved)") : "");
>
> How much do we want to have _exact_ output matches between the
> two strategies, at least in the short term?

Good question.  I started with such a goal, and discarded it when I
discovered it was unrealistic and even actively harmful -- at least in
the extreme of exact matching in all cases.  I've already updated the
regression tests to expect differences in output and behavior in a few
different series that merged down months ago[1][2][3].
   [1] https://lore.kernel.org/git/pull.827.v3.git.git.1597098559.gitgitgadget@gmail.com/
   [2] https://lore.kernel.org/git/pull.769.v2.git.1603731704.gitgitgadget@gmail.com/
   [3] https://lore.kernel.org/git/pull.879.git.git.1602794790.gitgitgadget@gmail.com/

 Of particular note from those series, at least as far as output
messages, are the following commits:
   1f3c9ba707 ("t6425: be more flexible with rename/delete conflict
messages", 2020-08-10)
   2a7c16c980 ("t6422, t6426: be more flexible for add/add conflicts
involving renames", 2020-08-10)
   c8c35f6a02 ("merge tests: expect slight differences in output for
recursive vs. ort", 2020-10-26)

Summarizing those, I split some conflict messages into multiple
messages, changed the name of some conflict types that get reported,
avoided having some messages go to stdout while others go to stderr
(based on who added them rather than differences in severity of the
message), and even just changed some messages (because once you've
accepted the other changes, exact matching just doesn't matter).
Other commits in the series also note how I changed the merge behavior
in addition to the output in various cases.

The rename/delete conflict commit message is particularly
illustrative.  It demonstrates why exact matching of output messages
is unachievable short of keeping a completely busted code design.

We can certainly tweak individual messages if we feel something will
make them clearer, but matching isn't a goal for me.

> > @@ -1257,13 +1309,13 @@ static void process_entry(struct merge_options *opt,
> >               int side = (ci->filemask == 4) ? 2 : 1;
> >               ci->merged.result.mode = ci->stages[side].mode;
> >               oidcpy(&ci->merged.result.oid, &ci->stages[side].oid);
> > -             ci->merged.clean = !ci->df_conflict;
> > +             ci->merged.clean = !ci->df_conflict && !ci->path_conflict;
> >       } else if (ci->filemask == 1) {
> >               /* Deleted on both sides */
> >               ci->merged.is_null = 1;
> >               ci->merged.result.mode = 0;
> >               oidcpy(&ci->merged.result.oid, &null_oid);
> > -             ci->merged.clean = 1;
> > +             ci->merged.clean = !ci->path_conflict;
>
> These exist because this is the first time we assign path_conflict.
> Sure.
>
> Thanks,
> -Stolee


Thanks for all your detailed reviews!

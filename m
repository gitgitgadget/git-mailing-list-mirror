Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF38C433E0
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 04:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D366765267
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 04:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhCIE2C (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 23:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbhCIE1r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 23:27:47 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15F1C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 20:27:46 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id o22so3810078oic.3
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 20:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dThKOpH6vHJwPGmsyGNRvXxqiX9/i9MSS7PhaxUrn9Y=;
        b=BA/kC5LmnDjSAU3Pvgw///yi8/TZZnPAQu/JHtIjeUH/9fuP3zRg/O2SAoX5TiwVTE
         J4li5bC1eZ75/48Ma6JTYkx4BeVKcLIWU1892+AzcPWQHChEpgOtJdJkkmKddm2WC43o
         LTKKdRlIxM9X/wYy1uLX3eYhciF28DXTfK/dhmw5vV6JKqEwA/ScQqiGUZunv8uBD2E1
         Yz8Dg8dJ/gDtiBlPiHk61fmLpCP6wBiXOchApWV9LEqV5iK8evPGElds/zFXJiwuhsT4
         1L/2cdrQEYxhfCIZSrgDWUWkUkSAbP3BMo9txdvszTs2GdqubAS6onnZL6NybY7F5BXr
         yPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dThKOpH6vHJwPGmsyGNRvXxqiX9/i9MSS7PhaxUrn9Y=;
        b=isWFXivnqyl5Azf+uNguP+efSLl8ucsOx7+I4Yi2SLiFBCJEt0RZ5x+btMfzWpoC7j
         ragKhb127dT8je9kJ9aBTIbG1m46jGQOxrU8DrvbluDJrXOWGkvPw7yBHEpELYAPjqrP
         lixCJeMqptTqyiRs7KZeOX7mvdnvXSbL3KEHAUJFloF7s6OEY0t2SGw6FvTsdW3swHvO
         Gd0xgpHVijIhEqHEcsJqtPVj1c8Q1HACb2IxGTEohsXFBKLslEKRxbGkieSW9k+S09ny
         SEG/+qpqILRYyMn8HcZ19KQexkEC1aM2OKnE/CBgUtry6qLpjU/CNVw/NzcJ+GXxhyri
         8x4g==
X-Gm-Message-State: AOAM532mzklMXC2Akjccu8dU/zjgAl+iwJxSADzsXRL1p1zGrLeKyrkH
        ulsBxboUlXl3XA1GNLE1trX+YOm0N3/nlQiXQJw=
X-Google-Smtp-Source: ABdhPJzb9SBOv96cH8Ds2xfsiz4PN2kvUc2UcyVJqsm8eB2NR9/2LKK7s89u9KUgIFyVJ0FBvQCObUSkh5R2Om8b/Nw=
X-Received: by 2002:aca:b489:: with SMTP id d131mr1651982oif.39.1615264066366;
 Mon, 08 Mar 2021 20:27:46 -0800 (PST)
MIME-Version: 1.0
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
 <cb035ac5fe4ab18b697eff42afedcab62880ceec.1614905738.git.gitgitgadget@gmail.com>
 <87a6rdkdxq.fsf@evledraar.gmail.com>
In-Reply-To: <87a6rdkdxq.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 8 Mar 2021 20:27:35 -0800
Message-ID: <CABPp-BEMAbeQAcja=MFU3_N7dUOpKWCohtyNfnTj9npep8j1Lw@mail.gmail.com>
Subject: Re: [PATCH 04/11] merge-ort: have ll_merge() calls use the attr_index
 for renormalization
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 8, 2021 at 4:49 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
>
> On Fri, Mar 05 2021, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > ll_merge() needs an index when renormalization is requested.  Give it
> > the special one we created exactly for that purpose.  This fixes t6418.=
4
> > and t6418.5 under GIT_TEST_MERGE_ALGORITHM=3Dort.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  merge-ort.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/merge-ort.c b/merge-ort.c
> > index 028d1adcd2c9..87c553c0882c 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -360,7 +360,7 @@ static void clear_or_reinit_internal_opts(struct me=
rge_options_internal *opti,
> >       string_list_clear(&opti->paths_to_free, 0);
> >       opti->paths_to_free.strdup_strings =3D 0;
> >
> > -     if (opti->attr_index.cache_nr)
> > +     if (opti->attr_index.cache_nr) /* true iff opt->renormalize */
> >               discard_index(&opti->attr_index);
>
> Perhaps instead of a comment, in that "if":
>
>     assert(opt->renormalize);

I would, but opt isn't defined here, and passing it in merely for an
assertion seems overboard.

> >       /* Free memory used by various renames maps */
> > @@ -988,7 +988,6 @@ static int merge_submodule(struct merge_options *op=
t,
> >       return 0;
> >  }
> >
> > -MAYBE_UNUSED
> >  static void initialize_attr_index(struct merge_options *opt)
> >  {
> >       /*
> > @@ -1063,6 +1062,8 @@ static int merge_3way(struct merge_options *opt,
> >       char *base, *name1, *name2;
> >       int merge_status;
> >
> > +     initialize_attr_index(opt);
>
> Subjective, but I think it's more readable to move the "initialized"
> check in initialize_attr_index() here, so:
>
>     if (!attr_index->initialized)
>         initialize_attr_index(opt);
>
> Saves the reader a trip to the function to see that it doesn't do
> anything except exit early on that flag.

Makes sense; I'll fix this up.

>
> >       ll_opts.renormalize =3D opt->renormalize;
> >       ll_opts.extra_marker_size =3D extra_marker_size;
> >       ll_opts.xdl_opts =3D opt->xdl_opts;
> > @@ -1101,7 +1102,7 @@ static int merge_3way(struct merge_options *opt,
> >
> >       merge_status =3D ll_merge(result_buf, path, &orig, base,
> >                               &src1, name1, &src2, name2,
> > -                             opt->repo->index, &ll_opts);
> > +                             &opt->priv->attr_index, &ll_opts);
> >
> >       free(base);
> >       free(name1);
>

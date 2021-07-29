Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536BEC4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 18:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3074160F01
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 18:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhG2SiI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 14:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhG2SiI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 14:38:08 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD487C061765
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 11:38:03 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id c2-20020a0568303482b029048bcf4c6bd9so6824282otu.8
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 11:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8/QtzBCSbbcmoyfmHSrV6XjvsjU7a8HOKbOe98fiaK4=;
        b=fbAdBdcPaFxxdu0aZlKViHwfEtVLWTcSJAo1jZaxXSDpAw61REb6FOkjz8WnQ7EUg4
         Emehqw3vDkOAOxhrNunnUk2SM0JwCih0a3HEkItWk0p9CUHt+MJxdIeGvga1emYzkpak
         eLMbUdZPg5cnNlwBO4L8nZojeEJwNK0pMMz9ohGPuPR8CyHZEBKdtlaB5Mnf2vu3jehS
         W9SPPweSALpZib24tMJwhfgm6g9dNnfZFKS2sCRzRdT3ZHHIFnsFTnQmirlQxCVY/sik
         0WbJ+NDSfMJ16Jl8e4JcVFvCK9yLBLEkgIJRXPsD8KK91nhqCKFmxDR73nbt45Zaid7q
         viww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8/QtzBCSbbcmoyfmHSrV6XjvsjU7a8HOKbOe98fiaK4=;
        b=FCheDUltVyF9Z9CXCzp4Y1HHvxhwHvpkGP7vxNGHm6LWXaGWotCSJmaP7SRIQS/PXe
         neS5zTx9DJ2AHFwDqXSxrXnmKmbMYN/HIEASEzdCeahGjvwdBNeMXmnuYh8gAc2h4r92
         vR+0I6PTBmRSzFtBZaQgh4rY21LbZTSUlmWyeD53ezOXzN/8H3EvEkeUO1Q8QZPRJbV/
         7b+tMhU2iEuM81T/pQf4SCSGwyx/suyGKfDjgiKb8kTC1TiStLGGhC8VvZ7+MG8bSQNv
         CSsPGsbIpb8iJp26JD7dw/GDAeat8iXX+FMUIhTgDG0eiVAW8rO2dgYIt+Vov80pVwWx
         5I4Q==
X-Gm-Message-State: AOAM531c1tXhAQ6cWyfctz3IFbJ6H9mOBwjYFMuDnKd+ih3dWzM3D8TW
        f/ikMsPZVvx07WKrHFXXBpvbjgIbqBaAGvffPH0=
X-Google-Smtp-Source: ABdhPJyD4BD4xX8yognZLX/VFAx0jlvTtUYs3ah0ReGPvqZsoSfUpzi3mj3l9qI2cq6EKOFH2sWcLsOK/LRbtLOo7Gc=
X-Received: by 2002:a05:6830:78c:: with SMTP id w12mr4324000ots.162.1627583883140;
 Thu, 29 Jul 2021 11:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <pull.990.git.1627044897.gitgitgadget@gmail.com>
 <pull.990.v2.git.1627531121.gitgitgadget@gmail.com> <dd8839b284330892a3bbcafbc03d71489fc9b01f.1627531121.git.gitgitgadget@gmail.com>
 <YQLJOsvATnTBd9pB@coredump.intra.peff.net>
In-Reply-To: <YQLJOsvATnTBd9pB@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 29 Jul 2021 12:37:52 -0600
Message-ID: <CABPp-BHzJ365Jed38s-VQb2PqRy7t=58sZwgmeVG=mqKeA2neg@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] merge-ort: switch our strmaps over to using memory pools
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 29, 2021 at 9:29 AM Jeff King <peff@peff.net> wrote:
>
> On Thu, Jul 29, 2021 at 03:58:38AM +0000, Elijah Newren via GitGitGadget wrote:
>
> > diff --git a/merge-ort.c b/merge-ort.c
> > index 2bca4b71f2a..5fd2a4ccd35 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -539,15 +539,19 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
> >       void (*strset_func)(struct strset *) =
> >               reinitialize ? strset_partial_clear : strset_clear;
> >
> > -     /*
> > -      * We marked opti->paths with strdup_strings = 0, so that we
> > -      * wouldn't have to make another copy of the fullpath created by
> > -      * make_traverse_path from setup_path_info().  But, now that we've
> > -      * used it and have no other references to these strings, it is time
> > -      * to deallocate them.
> > -      */
> > -     free_strmap_strings(&opti->paths);
> > -     strmap_func(&opti->paths, 1);
> > +     if (opti->pool)
> > +             strmap_func(&opti->paths, 0);
>
> This isn't new in your patch here, but I did scratch my head a bit over
> what "strmap_func" is. It's a bit less confusing if you read the whole
> function (as opposed to a diff), since then you're more likely to see
> the definition. But something like "strmap_clear_func()" would have been
> a lot less confusing.

Makes sense.

> Arguably, the existence of these function indirections is perhaps a sign
> that the strmap API should provide a version of the clear functions that
> takes "partial / not-partial" as a parameter.

Are you suggesting a modification of str{map,intmap,set}_clear() to
take an extra parameter, or removing the
str{map,intmap,set}_partial_clear() functions and introducing new
functions that take a partial/not-partial parameter?  I think you're
suggesting the latter, and that makes more sense to me...but I'm
drawing blanks trying to come up with a reasonable function name.

(If it helps for context -- the only current callers of the
*_partial_clear() functions are found in diffcore-rename.c and
merge-ort.c, so it'd be a pretty easy change to make to those.  There
are additionally some callers of strmap_clear() and strset_clear() in
builtin/shortlog.c and rerere.c, and it'd be nice to avoid exposing
those to the complexity of the partial clearing.)

> (Again, not really part of this patch series, but I hadn't looked at
> some of the earlier optimization steps).

Yeah, but this is the kind of reason I wanted you to review this
series, because I figured you might have more good comments on the
str{map,intmap,set} API calls.  :-)

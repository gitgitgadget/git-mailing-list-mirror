Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D58C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 18:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D50582068D
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 18:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grEQEk+I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgKKSt7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 13:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgKKSt7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 13:49:59 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D31C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 10:49:59 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id f16so3088867otl.11
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 10:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KperZmt2X1geHI/TWgCCMkx2kL0U+UU1fdawMKU2mm0=;
        b=grEQEk+IPpy4/+sl9TIxEVkxUDfeYm2C7YZroR9IHjhTIsoSqAQN1TVuRJziEtb7m4
         I9HXF8oRDh+oF5UJelkxyACV7Y+Ot5Efj2WsX86cWor6DXMSzF1UMqdbyTTaDsuJnVx6
         VgZ+wafCVxosAdvLSTTYYBkZK0Rg0NwwKe05zQLe9th1x15gZcvflQPO/O1Et/K12mQv
         B9s5rCqarUYjwLTdlLbtYt01umqx/yjVeveWrJDJqnvMSh1fUFdqYRFrNklnzelMKs1s
         FW86NbRvLtAFREN7U1oSEGVQ+vnbSrR1Q6dA5CZ94IaLcYnoWvSsNZIldkQbieTCCXZd
         vQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KperZmt2X1geHI/TWgCCMkx2kL0U+UU1fdawMKU2mm0=;
        b=Qp2HM5nelhjBOmNy5UgOBof4AX98FiyE+zH0hrOrBFd8WyX86NS3Jeh6pE38krULN2
         PkHnxug+sKOjKdb3vKfWMqfIxzesnDsH12v+6WcU2MuEctorK0MEOaTX/6V133c8UDdG
         4mPcDdaRrd6+21geAeSJFc/runisLXye/3ixbeGAbec5KjuRs9KNCgS3DhbiP5BR79EQ
         Uz4dVq9yXSrQaXgfbwzeW2Z6PTm/OGDpceSHD0i+oZ/bgVPfnYE9SSf/aUDtP1AN83bx
         OtIZy/CsdNHwoamQI0621ygOXqsUSWY7HPCKGdN3JDziDq6XjtdFy6RCGF2YU0RNXfDl
         z4Tg==
X-Gm-Message-State: AOAM5339VmBbnxDBrP7+HCMHCrqazW051G+kxDHlLDGmn3LD2QyUGQ+F
        z6kELBrHL1KtK62dGnCdCVlrUGPUIixWxfNpAQ4=
X-Google-Smtp-Source: ABdhPJwG79taXsrZQ120JmdPTrJ8Y35f1Wkou7gd3e4rgkIhcct8+UIc2kKrpmLS7L9UZsj02N6in15LU4YjWqg4QG8=
X-Received: by 2002:a05:6830:1002:: with SMTP id a2mr19441649otp.316.1605120597343;
 Wed, 11 Nov 2020 10:49:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
 <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com> <34f542d9dd846da5fd81274966ee2ebe0660dcef.1604622299.git.gitgitgadget@gmail.com>
 <fbaa60c4-ee6b-02b7-68b5-e5873f8ec713@gmail.com>
In-Reply-To: <fbaa60c4-ee6b-02b7-68b5-e5873f8ec713@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 11 Nov 2020 10:49:46 -0800
Message-ID: <CABPp-BGTS+qe1V7=ie7PjbRmKwwF=c54uOm43R1dnv7MgBJfyA@mail.gmail.com>
Subject: Re: [PATCH v5 12/15] strmap: enable allocations to come from a mem_pool
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 11, 2020 at 9:33 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Elijah
>
> On 06/11/2020 00:24, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > For heavy users of strmaps, allowing the keys and entries to be
> > allocated from a memory pool can provide significant overhead savings.
> > Add an option to strmap_init_with_options() to specify a memory pool.
> > [...]
> > diff --git a/strmap.h b/strmap.h
> > index c8c4d7c932..dda928703d 100644
> > --- a/strmap.h
> > +++ b/strmap.h
> > @@ -3,8 +3,10 @@
> >
> >   #include "hashmap.h"
> >
> > +struct mempool;
>
> I think this is a typo - I assume you wanted to declare `struct
> mem_pool` but it's not strictly necessary as you're only adding a
> pointer to the struct below.
>
> Best Wishes
>
> Phillip

Indeed, thanks.

>
> >   struct strmap {
> >       struct hashmap map;
> > +     struct mem_pool *pool;
> >       unsigned int strdup_strings:1;
> >   };
> >
> > @@ -37,9 +39,10 @@ void strmap_init(struct strmap *map);
> >
> >   /*
> >    * Same as strmap_init, but for those who want to control the memory management
> > - * carefully instead of using the default of strdup_strings=1.
> > + * carefully instead of using the default of strdup_strings=1 and pool=NULL.
> >    */
> >   void strmap_init_with_options(struct strmap *map,
> > +                           struct mem_pool *pool,
> >                             int strdup_strings);
> >
> >   /*
> > @@ -137,9 +140,10 @@ static inline void strintmap_init(struct strintmap *map, int default_value)
> >
> >   static inline void strintmap_init_with_options(struct strintmap *map,
> >                                              int default_value,
> > +                                            struct mem_pool *pool,
> >                                              int strdup_strings)
> >   {
> > -     strmap_init_with_options(&map->map, strdup_strings);
> > +     strmap_init_with_options(&map->map, pool, strdup_strings);
> >       map->default_value = default_value;
> >   }
> >
> > @@ -221,9 +225,10 @@ static inline void strset_init(struct strset *set)
> >   }
> >
> >   static inline void strset_init_with_options(struct strset *set,
> > +                                         struct mem_pool *pool,
> >                                           int strdup_strings)
> >   {
> > -     strmap_init_with_options(&set->map, strdup_strings);
> > +     strmap_init_with_options(&set->map, pool, strdup_strings);
> >   }
> >
> >   static inline void strset_clear(struct strset *set)
> >

Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13D1C00A89
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 16:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7397B20725
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 16:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sKEpmzmk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgJ3Qnp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 12:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgJ3Qnp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 12:43:45 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32073C0613CF
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 09:43:45 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id b2so6107375ots.5
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 09:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y86LTROoDDdhkKbRUhKxJNu7n7EYHfXLnv21tkrrugc=;
        b=sKEpmzmk37igS84M69MCYCINNvGh1SMTj3fi5TuTlG4cMqlhYVPysKN3MmM3DGff3s
         fmuPauhmNKafA7cHakQLesPRsTG6aPwTAEbhN0E5zgmTuPJ6nzXgycz7FMQigQwP65j4
         M3DT4mlimbl81LtCemSkRoWa9b8OF8RzswYGc2iAzF/514OoSGmGkeZ6ngmeD7fabFg9
         0eH5MgXl1596TvB7ZlezfCkYFhhqIvh5/2UwmYm4MhWAVL6cBLMkInghWu+8R6i+M6l9
         b09JpkGT1Wgw3lUA/7voNxk72088IGG99Xor1xfi72zBCJ2h1e1iH1u/rtTUWP7RhntW
         MBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y86LTROoDDdhkKbRUhKxJNu7n7EYHfXLnv21tkrrugc=;
        b=CgN7sTP3m7+2D96g8dOEiPIRVHeW6oho63EIx8i8PpQiyphU1PcgNPbNJhXby8ypj6
         jYhAM3960hhd4KzwiBQnvtaajiGbuSH45+qBRQ2l4t9jVvNNPIOPJmGE4ysCOe6Sr9il
         RgSKEFugY+zusBbomlb1126CWAs23ZjRHxM7XeFvaOdVBsq9hNKmvriZ/57LxIsDPcpz
         icLRo3vHrfEU93p5L2lAAII9pSp2ofWITunVlWiVcHhd4ZCXGPwibT50ArXsmf+0oTWS
         SF2hP6tIEGCFSpy6Eznf7UApEP5s/1Q6x3MQLkRTq0TSA/9HTk3yJfO2yFRs7eEVuSKv
         WbmA==
X-Gm-Message-State: AOAM531GK8oj+eGKsiB3Z0ORnfpl7XeyCMQvIMUfAme9CkfN/8WuYpkE
        Lcv0ibbznQYZQX+3mGhFba8nlj9dDY3vJPaye5k=
X-Google-Smtp-Source: ABdhPJx0gakjqoWPNvKzUwqNTVq8jX4EucEfKy9TC/szEJhHBdt4TDaqdZ10DC7bcqblTKpuM+OQjZIPv9NDz48kfN0=
X-Received: by 2002:a9d:6003:: with SMTP id h3mr2409196otj.345.1604076224535;
 Fri, 30 Oct 2020 09:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com> <61b5bf11103a7bd12de8fd066e128c469da3a0a4.1602549650.git.gitgitgadget@gmail.com>
 <20201030142350.GF3277724@coredump.intra.peff.net>
In-Reply-To: <20201030142350.GF3277724@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 30 Oct 2020 09:43:33 -0700
Message-ID: <CABPp-BEBQ0kAQVRuXRoZnRAm_BmAXUKv9XtC+R4UH0VDZBw6Sg@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] strmap: add more utility functions
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 30, 2020 at 7:23 AM Jeff King <peff@peff.net> wrote:
>
> On Tue, Oct 13, 2020 at 12:40:46AM +0000, Elijah Newren via GitGitGadget wrote:
>
> > strmap_get_entry() is similar to strmap_get() except that instead of just
> > returning the void* value that the string maps to, it returns the
> > strmap_entry that contains both the string and the void* value (or
> > NULL if the string isn't in the map).  This is helpful because it avoids
> > multiple lookups, e.g. in some cases a caller would need to call:
> >   * strmap_contains() to check that the map has an entry for the string
> >   * strmap_get() to get the void* value
> >   * <do some work to update the value>
> >   * strmap_put() to update/overwrite the value
>
> Oh, I guess I should have read ahead when responding to the last patch. :)
>
> Yes, this function makes perfect sense to have (along with the simpler
> alternatives for the callers that don't need this complexity).
>
> >  strmap.c | 20 ++++++++++++++++++++
> >  strmap.h | 38 ++++++++++++++++++++++++++++++++++++++
>
> The implementation all looks pretty straight-forward.
>
> > +void strmap_remove(struct strmap *map, const char *str, int free_util)
> > +{
> > +     struct strmap_entry entry, *ret;
> > +     hashmap_entry_init(&entry.ent, strhash(str));
> > +     entry.key = str;
> > +     ret = hashmap_remove_entry(&map->map, &entry, ent, NULL);
> > +     if (!ret)
> > +             return;
> > +     if (free_util)
> > +             free(ret->value);
> > +     if (map->strdup_strings)
> > +             free((char*)ret->key);
> > +     free(ret);
> > +}
>
> Another spot that would be simplified by using FLEXPTRs. :)
>
> > +/*
> > + * Return whether the strmap is empty.
> > + */
> > +static inline int strmap_empty(struct strmap *map)
> > +{
> > +     return hashmap_get_size(&map->map) == 0;
> > +}
>
> Maybe:
>
>   return strmap_get_size(&map) == 0;
>
> would be slightly simpler (and more importantly, show callers the
> equivalence between the two).

Makes sense; will change it.

> > +/*
> > + * iterate through @map using @iter, @var is a pointer to a type strmap_entry
> > + */
> > +#define strmap_for_each_entry(mystrmap, iter, var)   \
> > +     for (var = hashmap_iter_first_entry_offset(&(mystrmap)->map, iter, \
> > +                                                OFFSETOF_VAR(var, ent)); \
> > +             var; \
> > +             var = hashmap_iter_next_entry_offset(iter, \
> > +                                                  OFFSETOF_VAR(var, ent)))
>
> Makes sense. This is like hashmap_for_each_entry, but we don't need
> anyone to tell us the offset of "ent" within the struct.
>
> I suspect we need the same "var = NULL" that hashmap recently got in
> 0ad621f61e (hashmap_for_each_entry(): workaround MSVC's runtime check
> failure #3, 2020-09-30). Alternatively, I think you could drop
> OFFSETOF_VAR completely in favor offsetof(struct strmap_entry, ent).
>
> In fact, since we know the correct type for "var", we _could_ declare it
> ourselves in a new block enclosing the loop. But that is probably making
> the code too magic; people reading the code would say "huh? where is
> entry declared?".

Actually, since we know ent is the first entry in strmap, the offset
is always 0.  So can't we just avoid OFFSETOF_VAR() and offsetof()
entirely, by just using hashmap_iter_first() and hashmap_iter_next()?
I'm going to try that.

Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8607EC4741F
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 16:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 276F420A8B
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 16:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grzpOev7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgJ3Q0P (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 12:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgJ3Q0O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 12:26:14 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD295C0613CF
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 09:26:14 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id k65so7199238oih.8
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 09:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D2K7OWsfXKHdYc+ORuDZkDhohuRM2BceAay9hovC4Es=;
        b=grzpOev7z8RjSeF5EOdU4oTta++gnfMkqLs5LMT3U1Gdt3ghve8EakxzbYmIKYkou1
         MSt2+6gbfaDkh1Bsex36SGqjnngndrB83TeONTfdGJyVakcl1nP2GXXK6qKloBgbuOi3
         yvP8ixAoH/lvQcNLolaH436FX6ElbmSxuju6uSHYZQQZb6GBW3tdB2Df5DPZHKp6RjD5
         CaoHKfuAILtE1f9sujgqjVDpPbyn+0RPFVq/RZp9n6Wu9NwU0Hv4e1H+/n0DASjnXDNf
         eoyuXgL1/+10+CrqwGIsr4si+GHhdteWRtsjxaHNCJtkF8KEbQ1ifJ2sNAI2gUetyxdL
         yAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D2K7OWsfXKHdYc+ORuDZkDhohuRM2BceAay9hovC4Es=;
        b=qwGRMgW+5yPLTvLLsc/L4zue0VEXi0ow4ItFCknK46vlJrub59rbl35mRkFS1wpROO
         rT5H0FC1nyEvgf7Ba9bP3vFxb9ZK9rACvxw5eyCoCgE0qiRLdcJ64yU74q28UecxLKoh
         GRpGBo01LdUi4Ip2pA7AtTuPkMeCkj9PgLjHQk8qLU/YcCcEQ73w649GgfkacJGXVgza
         sQIocrxn5Gpyebnx/qeAeQ7YbTOwLZZp1pslxpSKCM9rnTmuSZUyWsN//PqvG8cyAdv6
         wAUT/u4udO/OTeivg6XWnJA3tovioISYMP5/IK19E7FUrNUFHufolSwJdIDj494qEw1C
         ED7A==
X-Gm-Message-State: AOAM532NEX+jvqg7MsaRwqgRiuPN4cDbLXtoypCTxvtQ6F1DbkO9SmQX
        SwBBGEZcbdDXRv5Gph8XCqAcKntcOdlqXtL/IH4=
X-Google-Smtp-Source: ABdhPJzNynJzmZYF/U9UvleCe84RgqHz0ufSUoai7VBjlbWESsqjcU+ndx9boFuJ/I94A4XfVKLzPvtwFBlNyKtfWT0=
X-Received: by 2002:a05:6808:17:: with SMTP id u23mr2102716oic.31.1604075173950;
 Fri, 30 Oct 2020 09:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com> <5c7507f55b09e24c0bfe87cc3df06213cfd1235b.1602549650.git.gitgitgadget@gmail.com>
 <20201030141233.GE3277724@coredump.intra.peff.net>
In-Reply-To: <20201030141233.GE3277724@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 30 Oct 2020 09:26:02 -0700
Message-ID: <CABPp-BGTjUdgmiEneVNsLWyODZtH-d+x6uTFfwbOtyba3K76HQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] strmap: new utility functions
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 30, 2020 at 7:12 AM Jeff King <peff@peff.net> wrote:
>
> On Tue, Oct 13, 2020 at 12:40:45AM +0000, Elijah Newren via GitGitGadget wrote:
>
> > Add strmap as a new struct and associated utility functions,
> > specifically for hashmaps that map strings to some value.  The API is
> > taken directly from Peff's proposal at
> > https://lore.kernel.org/git/20180906191203.GA26184@sigill.intra.peff.net/
>
> This looks overall sane to me. I mentioned elsewhere that we could be
> using FLEXPTR_ALLOC to save an extra allocation. I think it's easy and
> worth doing here, as the logic would be completely contained within
> strmap_put():
>
>   if (strdup_strings)
>         FLEXPTR_ALLOC_STR(entry, key, str);
>   else {
>         entry = xmalloc(sizeof(*entry));
>         entry->key = str;
>   }
>
> And free_entries() then doesn't even have to care about strdup_strings.

Yeah, as you noted in your review of 10/10 this idea wouldn't play
well with the later mem_pool changes.

> > A couple of items of note:
> >
> >   * Similar to string-list, I have a strdup_strings setting.  However,
> >     unlike string-list, strmap_init() does not take a parameter for this
> >     setting and instead automatically sets it to 1; callers who want to
> >     control this detail need to instead call strmap_ocd_init().
>
> That seems reasonable. It could just be a parameter, but I like that you
> push people in the direction of doing the simple and safe thing, rather
> than having them wonder whether they ought to set strdup_strings or not.

Well, in my first round of the series where I did make it a parameter
you balked pretty loudly.  ;-)

> >   * I do not have a STRMAP_INIT macro.  I could possibly add one, but
> >       #define STRMAP_INIT { { NULL, cmp_str_entry, NULL, 0, 0, 0, 0, 0 }, 1 }
> >     feels a bit unwieldy and possibly error-prone in terms of future
> >     expansion of the hashmap struct.  The fact that cmp_str_entry needs to
> >     be in there prevents us from passing all zeros for the hashmap, and makes
> >     me worry that STRMAP_INIT would just be more trouble than it is worth.
>
> You can actually omit everything after cmp_str_entry, and those fields
> would all get zero-initialized. But we also allow C99 designed
> initializers these days. Coupled with the HASHMAP_INIT() I mentioned in
> the earlier email, you'd have:
>
>   #define STRMAP_INIT { \
>                 .map = HASHMAP_INIT(cmp_strmap_entry, NULL), \
>                 .strdup_strings = 1, \
>           }
>
> which seems pretty maintainable.

Makes sense; will add.

> > +static int cmp_strmap_entry(const void *hashmap_cmp_fn_data,
> > +                         const struct hashmap_entry *entry1,
> > +                         const struct hashmap_entry *entry2,
> > +                         const void *keydata)
> > +{
> > +     const struct strmap_entry *e1, *e2;
> > +
> > +     e1 = container_of(entry1, const struct strmap_entry, ent);
> > +     e2 = container_of(entry2, const struct strmap_entry, ent);
> > +     return strcmp(e1->key, e2->key);
> > +}
>
> I expected to use keydata here, but it's pretty easy to make a fake
> strmap_entry because of the use of the "key" pointer. So that makes
> sense.
>
> > +static void strmap_free_entries_(struct strmap *map, int free_util)
>
> You use the term "value" for the mapped-to value in this iteration. So
> perhaps free_values here (and in other functions) would be a better
> name?

Oops, yes, definitely.

> > +     /*
> > +      * We need to iterate over the hashmap entries and free
> > +      * e->key and e->value ourselves; hashmap has no API to
> > +      * take care of that for us.  Since we're already iterating over
> > +      * the hashmap, though, might as well free e too and avoid the need
> > +      * to make some call into the hashmap API to do that.
> > +      */
> > +     hashmap_for_each_entry(&map->map, &iter, e, ent) {
> > +             if (free_util)
> > +                     free(e->value);
> > +             if (map->strdup_strings)
> > +                     free((char*)e->key);
> > +             free(e);
> > +     }
> > +}
>
> Yep, makes sense.
>
> > +void strmap_clear(struct strmap *map, int free_util)
> > +{
> > +     strmap_free_entries_(map, free_util);
> > +     hashmap_free(&map->map);
> > +}
>
> This made me wonder about a partial_clear(), but it looks like that
> comes later.
>
> > +void *strmap_put(struct strmap *map, const char *str, void *data)
> > +{
> > +     struct strmap_entry *entry = find_strmap_entry(map, str);
> > +     void *old = NULL;
> > +
> > +     if (entry) {
> > +             old = entry->value;
> > +             entry->value = data;
>
> Here's a weird hypothetical. If strdup_strings is not set and I do:
>
>   const char *one = xstrdup("foo");
>   const char *two = xstrdup("foo");
>
>   hashmap_put(map, one, x);
>   hashmap_put(map, two, y);
>
> it's clear that the value should be pointing to "y" afterwards (and you
> return "x" so the caller can free it or whatever, good).
>
> But which key should the entry be pointing to? The old one or the new
> one? I'm trying and failing to think of a case where it would matter.
> Certainly I could add a free() to the toy above where it would, but it
> feels like a real caller would have to have pretty convoluted memory
> lifetime semantics for it to make a difference.
>
> So I'm not really asking for a particular behavior, but just bringing it
> up in case you can think of something relevant.

I'll keep mulling it over, but I likewise can't currently think of a
case where it'd matter.

>
> > +     } else {
> > +             /*
> > +              * We won't modify entry->key so it really should be const.
> > +              */
> > +             const char *key = str;
>
> The "should be" here confused me. It _is_ const. I'd probably just
> delete the comment entirely, but perhaps:
>
>   /*
>    * We'll store a const pointer. For non-duplicated strings, they belong
>    * to the caller and we received them as const in the first place. For
>    * our duplicated ones, they do point to memory we own, but they're
>    * still conceptually constant within the lifetime of an entry.
>    */
>
> Though it might make more sense in the struct definition, not here.

Either I was (mistakenly) worried about "I'm going to allocate and
copy, but during the copy it isn't actually const", or this is a
leftover artifact from some of the other iterations I tried.  Anyway,
I think this comment isn't useful; I'll just strike it.

> > +void *strmap_get(struct strmap *map, const char *str)
> > +{
> > +     struct strmap_entry *entry = find_strmap_entry(map, str);
> > +     return entry ? entry->value : NULL;
> > +}
>
> Just noting that the caller can't tell the difference between "no such
> entry" and "the entry is storing NULL". I think the simplicity offered
> by this interface makes it worth having (and being the primary one). If
> some caller really needs to tell the difference between the two, we can
> add another function later.
>
> Obviously they could use strmap_contains(), but that would mean two hash
> lookups.

Yep, addressed later by strmap_get_entry() in another patch, as you
noticed in your later review.

> > +/*
> > + * Same as strmap_init, but for those who want to control the memory management
> > + * carefully instead of using the default of strdup_strings=1.
> > + * (OCD = Obsessive Compulsive Disorder, a joke that those who use this function
> > + * are obsessing over minor details.)
> > + */
> > +void strmap_ocd_init(struct strmap *map,
> > +                  int strdup_strings);
>
> I'm not personally bothered by this name, but I wonder if some people
> may be (because they have or know somebody who actually has OCD).
>
> Perhaps strmap_init_with_options() would be a better name? It likewise
> would extend well if we want to add other non-default options later.

Doh!  That's going to push a bunch of lines past 80 characters.  Sigh...

It's probably a better name though; I'll change it.

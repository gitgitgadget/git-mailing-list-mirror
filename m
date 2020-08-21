Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29263C433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 20:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F40C320724
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 20:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rz0PlOiu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgHUUwL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 16:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgHUUwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 16:52:09 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB10C061573
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 13:52:09 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id u24so2658228oic.7
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 13:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LdPlfdSXQXFcMqvLRYNQJVp6LErdhSw1uPBJRS12Grw=;
        b=Rz0PlOiuvvdvyPPBPWx0Jb3AcL+nn1QwejbYZpccvYVmIcbFfHkHB/WXqB1zefjARJ
         lDOYwv2jrZRGXaju3RZwzYxbcp+G9mxEnBvELKFyURjORCCsAC7AbbEGTMfyyu7BE81P
         gVLm0Ql5j/nO5EE9d7xbu4efZnNrM1puzrfYRikOhZWAQ6KGc7epN1bVWNmzTRJ9yyY7
         bF60iAd4UZGsaJV19U8suN+Yf85J26Oc1jlI2zRApuZSvkk6JB0tifGd/0VQKkBtxFDs
         ZKVdlZ2nBuSWyJ5Z5MtT1nJzndasVniK3voXtmwPEGOTysJS+5SkTOg7bGXTMIeZRuG9
         hmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LdPlfdSXQXFcMqvLRYNQJVp6LErdhSw1uPBJRS12Grw=;
        b=AiO/87OWFOstLu+wuRcx+rURM16ECkr5cxeycBy68wBASOhRaRlvXdvF+Ws/M+Zndy
         Ezrhz1gsMKwVZbWBN7I351LK1cGf2jozOUxmdTAa/bdCyd6VqlgrMHrFULbbtal0C5Tl
         lNWwoAu+Y5BiDzTC4DRmwC4Jy8Y6420o/mAU/sOsRtn2a8/t5KA7S/rKy0brZa4csD7i
         MPwzmCIZTGQDg+wLhsKCdjb7300G97ML9Tw38eGZRsfK1XG7Og5I4Rn/+ht6tooNBQxr
         M8xC3XAk4HDD7HzVnAP0iY/p83o3/MByZ5AT3odtLRHJdozB9na+uCKyeFhpPU4hB8S9
         53WQ==
X-Gm-Message-State: AOAM532QbfSEl4ZjG7Jx+eyTL2lVlqVdYEC3WURr+oqwp5oEkbAJrXbO
        qfTO8/RCSUnSH+5+ksP5961/5OyhF5Pj5d/6/TVwTLyDMgE=
X-Google-Smtp-Source: ABdhPJzSOCmQ/kFppd7Q2mzXYgGjUdaHgGz183MlldEtjYQGuLUqTdRZqrhQDHBKfGgSwx1VsXaFRerVSHjNO0ONq6I=
X-Received: by 2002:aca:b705:: with SMTP id h5mr2845895oif.31.1598043128627;
 Fri, 21 Aug 2020 13:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <418975b46039f63476852a868ca6221244b5d88e.1598035949.git.gitgitgadget@gmail.com>
 <20200821201034.GG1165@coredump.intra.peff.net>
In-Reply-To: <20200821201034.GG1165@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 21 Aug 2020 13:51:57 -0700
Message-ID: <CABPp-BFi7JSkkVSLkS9Kb5fMJ3xM3CjM7_ZsvJZMv=XgQgb6Lw@mail.gmail.com>
Subject: Re: [PATCH 5/5] strmap: add functions facilitating use as a
 string->int map
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 21, 2020 at 1:10 PM Jeff King <peff@peff.net> wrote:
>
> On Fri, Aug 21, 2020 at 06:52:29PM +0000, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Although strmap could be used as a string->int map, one either had to
> > allocate an int for every entry and then deallocate later, or one had to
> > do a bunch of casting between (void*) and (intptr_t).
> >
> > Add some special functions that do the casting.  Also, rename put->set
> > for such wrapper functions since 'put' implied there may be some
> > deallocation needed if the string was already found in the map, which
> > isn't the case when we're storing an int value directly in the void*
> > slot instead of using the void* slot as a pointer to data.
>
> I think wrapping this kind of hackery is worth doing.
>
> You'd be able to use put() as usual, wouldn't you? It never deallocates
> the util field, but just returns the old one. And the caller knows that
> it's really an int, and shouldn't be deallocated.

You can use put() as normal, if you don't mind the need to explicitly
throw in a typecast when you use it.  In fact, strintmap_set() does no
more than typecasting the int to void* and otherwise calling
strmap_put().

I initially called that strintmap_put(), but got confused once or
twice and looked up the function definition to make sure there wasn't
some deallocation I needed to handle.  After that, I decided to just
rename to _set() because I thought it'd reduce the chance of myself or
others wondering about that in the future.

>
> > A note on the name: strintmap looks and sounds pretty lame to me, but
> > after trying to come up with something better and having no luck, I
> > figured I'd just go with it for a while and then at some point some
> > better and obvious name would strike me and I could replace it.  Several
> > months later, I still don't have a better name.  Hopefully someone else
> > has one.
>
> strnummap? That's pretty bad, too.
>
> Since the functions all take a raw strmap, you _could_ just do
> "strmap_getint()", etc. But I think you could actually get some
> additional safety by defining a wrapper type:
>
>   struct strintmap {
>           struct strmap strmap;
>   };
>
> It's a bit annoying because you a bunch of pass-through boilerplate for
> stuff like:
>
>   static inline int strintmap_empty(struct strintmap *map)
>   {
>           return strmap_empty(&map->map);
>   }
>
> but it would prevent mistakes like:
>
>   strintmap_incr(&map, "foo", 10);
>   strmap_clear(&map, 1);
>
> which would try to free (void *)10.  I'm not sure if that's worth it or
> not. You'd almost have to be trying to fail to pass "1" for free_util
> there. But I've seen stranger things. :)

I like this idea and the extra safety it provides.  Most of strintmap
is static inline functions anyway, adding a few more wouldn't hurt.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474BAC4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 02:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17D3860F46
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 02:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbhG3C2H (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 22:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhG3C2H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 22:28:07 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E3DC061765
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 19:28:03 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id t1-20020a4a54010000b02902638ef0f883so2081896ooa.11
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 19:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kaCVh1/ZtR311VPdSQHjxfLu9LN9Zo0jpyoKCCKPROQ=;
        b=IICEHDbwW0M32Ms7BjNvCfMYmnWGGliXC48ZRnvAyAg2s+KPQEjMhzv82LVMa5gwxn
         W7d7r/Rx9ixRf6Xp3bmGFb7qJQr3CLaVB34jHiO1gXkqC4t3g/CqC6oX6CcZzywfnmGp
         2UyieCaMWbWV7/ZJaxz0NEl53ih51H5Ilq1UAefjrae/ZAROC4jJmfUe5h7Kp6qotIQv
         xdu0qdW8gEkhy8rCiS6NkzP6jmvQ3jX9YPqaPY1/gIlx2r77418/BLBW7bvHaMQbA8Sz
         qs7snB2zH/WWRXpfgXm9HIGdpSIaSZb2T/7XtYRYTbkl4Sgubgl7w0BL/hSgaCKPqbgE
         UAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kaCVh1/ZtR311VPdSQHjxfLu9LN9Zo0jpyoKCCKPROQ=;
        b=LoBjcSYt9PVWaTGgJ/Ayx7enn4GrQ3Oqgi05r+30IFM32gG5TRcV1iloCR8+rW7qnq
         +VqihvscRKRQhDxqt0nX79zEsiXr/swMgn/gKm/nculJM1uCTIkZPHn0M9bEv9roZVnx
         3yrTnOrvb+JcfziCLvOhUxROFYKezYUW0B51kXJV0fa+0kGrcxsfihlmaQiJS+xzmEJO
         1wvCWlyrSbxP3gW6vxyEiNmwqT0Y5vI8HNad9HM90hWhDriuHr+LGI3wr2yBYAFdcPML
         VO67lIZfN28pB5XLZpQZ+i3890KR47Ng0QJyrs/qp1V4fINHnkMzpb4Gtn6p+SVT2HL6
         bbEg==
X-Gm-Message-State: AOAM533+Vf1cZmOLWYIqAec39PGh9QivqBprK/mOorxLttUH8ufhfhwC
        bvATlWM7HxR66YZtYj18nUXmgzIBw95+S6ClpRkzePxlLaw=
X-Google-Smtp-Source: ABdhPJzF3IqQldOr5R3YpIzEdFeFsZwpQiRfCOVX7jrciPB0yMTyCNvNjLgV1eHd1Ys/Rqszxaqx183BAbuqa4n8Kns=
X-Received: by 2002:a4a:d40a:: with SMTP id n10mr186558oos.32.1627612082716;
 Thu, 29 Jul 2021 19:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <pull.990.git.1627044897.gitgitgadget@gmail.com>
 <e30b8c8fea110b2475d00a4b37eb62a4883999c4.1627044897.git.gitgitgadget@gmail.com>
 <bc24ea9c-178c-bcc9-2097-2271df93ae76@gmail.com> <CABPp-BGjrKWXn2ZzeJ-nsZTwsDE=gbaX=1YKfiNtC70VeN9VVA@mail.gmail.com>
 <YQLInKdjor6Vs1yE@coredump.intra.peff.net>
In-Reply-To: <YQLInKdjor6Vs1yE@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 29 Jul 2021 20:27:51 -0600
Message-ID: <CABPp-BF+1=yajJ_Z9MHHbeL6XkctfStj63xVXTkguNicx_PcPw@mail.gmail.com>
Subject: Re: [PATCH 3/7] merge-ort: add pool_alloc, pool_calloc, and
 pool_strndup wrappers
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 29, 2021 at 9:26 AM Jeff King <peff@peff.net> wrote:
>
> On Wed, Jul 28, 2021 at 04:49:18PM -0600, Elijah Newren wrote:
>
> > On Mon, Jul 26, 2021 at 8:36 AM Derrick Stolee <stolee@gmail.com> wrote:
> > >
> > > On 7/23/2021 8:54 AM, Elijah Newren via GitGitGadget wrote:
> > > > From: Elijah Newren <newren@gmail.com>
> > > >
> > > > We need functions which will either call
> > > >     xmalloc, xcalloc, xstrndup
> > > > or
> > > >     mem_pool_alloc, mem_pool_calloc, mem_pool_strndup
> > > > depending on whether we have a non-NULL memory pool.  Add these
> > > > functions; the next commit will make use of these.
> > >
> > > I briefly considered that this should just be the way the
> > > mem_pool_* methods work. It does rely on the caller knowing
> > > to free() the allocated memory when their pool is NULL, so
> > > perhaps such a universal change might be too much. What do
> > > you think?
> >
> > That's interesting, but I'm worried it might be a bit much.  Do others
> > on the list have an opinion here?
>
> FWIW, I had the same thought. You can also provide a helper to make the
> freeing side nicer:
>
>   static void mem_pool_free(struct mem_pool *m, void *ptr)
>   {
>         if (m)
>                 return; /* will be freed when pool frees */
>         free(ptr);
>   }
>
> We do something similar with unuse_commit_buffer(), where the caller
> isn't aware of we pulled the buffer from cache or allocated it
> especially for them.

Having a paired function may help one side, but I worry that the name
(mem_pool_free) might introduce some confusion of its own -- "Why is
there a mem_pool_free() function, isn't the point of memory pools to
not need to individually free things?"  Or, "Why are they freeing the
pool here and what's the extra parameter?"

I'm not sure I see the right way to address that, so I think I'm going
to leave this part out of my series and let someone else add such
changes on top if they feel motivated to do so.

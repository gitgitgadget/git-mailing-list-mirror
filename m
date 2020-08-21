Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A474AC433E4
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7825D20724
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAzyyPJB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgHUVeM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgHUVeG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 17:34:06 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4C7C061573
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 14:34:05 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id a65so2707978otc.8
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 14:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+rrSNTJyIlXOEmajGmNTlPCoLAJQBMPCywZVYD6lLBw=;
        b=QAzyyPJB3ZCIDIFF1p4ll0ELFOXJqnFG0SSWxEwg/j41NfC5XaaiZa5Ft9ltUS5UCu
         3b8VdVx8TyNpj/Bmf46qSav/QluZjmuCa8HaJPx79t8jSYSortEFRgEO8I3JP++KVpQ/
         2slj5gkkAEWV9q5e/pmH45xXtzx361N5r5ojlLCbfIbhnc6bBTJcsREt8CPXsb6IjEpQ
         cZ8qiVrf55AnmaC58ZL8L/nJrlVOlFQIpC6su3fFPYyVRn5wlzVzmWXVUdiu2j+nWLHe
         dt0lZ/XkJkg7SVglFS3pLK166MhMHcQhB56GTEone/760tn0998JEjiu7NZGIxNN17EZ
         krxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+rrSNTJyIlXOEmajGmNTlPCoLAJQBMPCywZVYD6lLBw=;
        b=eF53dz1KjfFiIx2u1Xzbfy4Slajuhi2MhuVmYnXZ1PTe8vn53PrMqAoA67HJ4F2v4e
         1fPWnjM1mX9vlTjxOqK7gzzpD+PRfGDsknorH8zw1WUeGeJrZy7jdYYzk6dhCv4s63HN
         pEb2C2M+yf+9uxaLgZ1CNfCYvb0YKEz5Mkn7da3mpaq5HT3fxDmysH41awSPu6S07byg
         byzgDORh5SAesDN+9gF65ei3H2OGXF0B+l9r5/lf/Y3k3rQ3SuizkKiJCXJqCqXMNx76
         6dCNjLBXj4kjkR46eZdLQWflCg4ha/yB21lwpEPAhzL008wdAHeWXGNRrODnkzzbuNB+
         63+w==
X-Gm-Message-State: AOAM533VpoBypTIALBlj2RLlJcqSO3gUp6KqScSBylnp7PeDBEPio56k
        JoPeho7JS/+oQSbbK7dDN3vUxpMg7FdF9e5QJcPTjpcuHYg=
X-Google-Smtp-Source: ABdhPJwzmL0nWGYa5MSgWY/v0/bhBb+SrE4etOWXCnSnHJIIh5rQoNfJwxYX86OulIc8JVeZw0yC+jWZ9H2OV5tNUJ0=
X-Received: by 2002:a9d:67d3:: with SMTP id c19mr3421860otn.162.1598045645201;
 Fri, 21 Aug 2020 14:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com> <20200821201648.GH1165@coredump.intra.peff.net>
In-Reply-To: <20200821201648.GH1165@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 21 Aug 2020 14:33:54 -0700
Message-ID: <CABPp-BGYiphp-93Bf=2z-ZLd-Y=buTA0BCp6zuTJF39n1x3Rfw@mail.gmail.com>
Subject: Re: [PATCH 0/5] Add struct strmap and associated utility functions
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 21, 2020 at 1:16 PM Jeff King <peff@peff.net> wrote:
>
> On Fri, Aug 21, 2020 at 06:52:24PM +0000, Elijah Newren via GitGitGadget wrote:
>
> > Here I introduce a new strmap type, which my new merge backed, merge-ort,
> > uses heavily. (I also made significant use of it in my changes to
> > diffcore-rename). This strmap type was based on Peff's proposal from a
> > couple years ago[1], but has additions that I made as I used it. I also
> > start the series off with a quick documentation improvement to hashmap.c to
> > differentiate between hashmap_free() and hashmap_free_entries(), since I
> > personally had difficulty understanding them and it affects how
> > strmap_clear()/strmap_free() are written.
>
> I like the direction overall (unsurprisingly), but left a bunch of
> comments. I do think if we're going to do this that it may be worth
> cleaning up hashmap a bit first, especially around its clear/free
> semantics, and its ability to lazy-allocate the table.
>
> I'm happy to work on that, but don't want to step on your toes.

I have patches which introduce hashmap_clear() and
hashmap_clear_entries() to hashmap.[ch], which allowed me to simplify
strmap_clear(); instead of needing to call both
hashmap_free[_entries]() && strmap_init(), I could just call
hashmap_clear[_entries]().  Doing that surprised me with a significant
performance impact (in a good direction), at which point I started
adding mem-pool integration into hashmap for storing the entries that
hashmap.c allocates and got further good speedups.

I thought those were better explained when I got to the performance
stuff, so I had held off on those patches.  I could pull them out and
submit them first.

However, there's an important difference here between what I've done
and what you've suggested for hashmap: my method did not deallocate
hashmap->table in hashmap_clear() and then use lazy initialization.
In fact, I think not deallocating the table was part of the charm --
the table had already naturally grown to the right size, and because
the repository has approximately the same number of paths in various
commits, this provided me a way of getting a table preallocated to a
reasonable size for all merges after the first (and there are multiple
merges either when recursiveness is needed due to multiple merge
bases, OR when rebasing or cherry-picking a sequence of commits).
This prevented, as hashmap.h puts it, "expensive resizing".

So, once again, my performance ideas might be clashing with some of
your desires for the API.  Any clever ideas for resolving that?

Also, since you want to see hashmap cleanup first, should I submit
just the hashmap_clear[_entries()] stuff, or should I also submit the
API additions to allow mem-pool integration in hashmap (it's pretty
small and self-contained, but it'll be a while before I submit the
patches that use it...)?

> I also wonder if you looked at the khash stuff at all. Especially for
> storing integers, it makes things much more natural. You'd do something
> like:
>
>   /* you might even be able to just write !strcmp in the macro below */
>   static inline int streq(const char *a, const char *b)
>   {
>           return !strcmp(a, b);
>   }
>
>   KHASH_INIT(strint_map, char *, int, 1, strhash, streq);
>
> and then you'd probably want a "put" wrapper that makes a copy of the
> string. khash has its own charming awkwardness, but I'm just curious if you
> looked at it and found it more awkward than hashmap.c, or if you just
> didn't look at it.

I did look at it, but only briefly.  I had a further investigation on
my TODO list for months, along with several other improvement ideas.
But it seemed like my TODO list was really long, and my new merge
backend hasn't benefited anyone yet.  At some point, I decided to punt
on it and other ideas and start cleaning up my code and submitting.  I
believe merge-ort is more accurate than merge-recursive (it fixes
several test_expect_failures) and is a lot faster as well for the
cases I'm looking at.  So, for now, I've pulled it off my radar.

But I'd be really happy if someone else wanted to jump in and try
switching out hashmap for khash in the strmap API and see if it helps
merge-ort performance.  :-)

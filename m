Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3170CC433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 22:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3FFD20738
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 22:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkCTkpnr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgHUW2X (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 18:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgHUW2W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 18:28:22 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83054C061573
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 15:28:22 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id r6so675874oon.13
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 15:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KvlWn6J0Pf3iW33Qk5OpytsxRPw6T+D2qbkH8Kmt1DM=;
        b=EkCTkpnrKdZ3UpIm8b68yy9qDUrHv6Ap9OgJWUTbpDWI2JNbmt3q5FJPUWcdmqfUyd
         ui0JXZ9OCT/0Hz6RxqQvSVdSMQ+7CElfzMAdBA28kl0EfInO3Z9pFdRYzXQIHzH5A/YN
         Swuz9hfiii/jpkTeTtps3eJkQY2xXz+PFksDdJACE3Nvfd0LoANUw+oJfg4Mc/XRHnxX
         oEcFlmQT31cvQDeSFU1C+rS3lSPSNJe+BAdPfvgu6l9O/zG+4tjaIuKPToY3WSeSuwx3
         2WDpGPn/s8O7tKjV5qK2dGj8JAlFy/EcuL1+PtlMzioXPHEPh/B025bh20W85ZIaVYOW
         GLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KvlWn6J0Pf3iW33Qk5OpytsxRPw6T+D2qbkH8Kmt1DM=;
        b=qcImb8J8cBcbZIdRFPbL2QcIi5jIGEKor3rF1s4AMw9PNgxUeG8BHnz1AENifERY6Z
         dgrxFWagyQsFw5dtv958MajVXd0ZDP7mMElExnFmFRgveqEVrWjTb4VCiEbA7xGEbaZW
         tFMXj7bMFgIt0Yft9+YsVjsdvNT6t3r06HdFguFeXFRzVq60cPTUlmN05gDNKtNOJp8b
         8kqSxoela3jqBrWbu5Ay8Qho+dpHrn+Q7Hd1dtrrnzgSKzYO2GumQBoYBgjQBG7kodVO
         c/qa8JRp3mP6TYDEZylf3YQhv90wjrFShYyucx0aeNRO/jlizoQSLg694E269IqqZ/2Q
         zjJQ==
X-Gm-Message-State: AOAM532y9hQla8Az23bzBmiyuJnqlQyHkOj1ONZ7yio6qJd0a0gXaWKA
        4OnSMoXCbTDyif9mA00ezOg0CHpCjXhQ9l9msJg=
X-Google-Smtp-Source: ABdhPJwm9TmVhKydcWarqWBSyvUY6QbzmLS1Jr2tc2WjPa4arDAkWg67Nl2RCqPQ2e47ICZ664xEzjCgGM6dJkFsOOI=
X-Received: by 2002:a4a:98ed:: with SMTP id b42mr3905400ooj.32.1598048899057;
 Fri, 21 Aug 2020 15:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <20200821201648.GH1165@coredump.intra.peff.net> <CABPp-BGYiphp-93Bf=2z-ZLd-Y=buTA0BCp6zuTJF39n1x3Rfw@mail.gmail.com>
In-Reply-To: <CABPp-BGYiphp-93Bf=2z-ZLd-Y=buTA0BCp6zuTJF39n1x3Rfw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 21 Aug 2020 15:28:07 -0700
Message-ID: <CABPp-BFFOKcBsPEu+zueCKwPGMh9RgOE8QJonKxkNNE3-Ym7Gw@mail.gmail.com>
Subject: Re: [PATCH 0/5] Add struct strmap and associated utility functions
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 21, 2020 at 2:33 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Fri, Aug 21, 2020 at 1:16 PM Jeff King <peff@peff.net> wrote:
> >
> > On Fri, Aug 21, 2020 at 06:52:24PM +0000, Elijah Newren via GitGitGadget wrote:
> >
> > > Here I introduce a new strmap type, which my new merge backed, merge-ort,
> > > uses heavily. (I also made significant use of it in my changes to
> > > diffcore-rename). This strmap type was based on Peff's proposal from a
> > > couple years ago[1], but has additions that I made as I used it. I also
> > > start the series off with a quick documentation improvement to hashmap.c to
> > > differentiate between hashmap_free() and hashmap_free_entries(), since I
> > > personally had difficulty understanding them and it affects how
> > > strmap_clear()/strmap_free() are written.
> >
> > I like the direction overall (unsurprisingly), but left a bunch of
> > comments. I do think if we're going to do this that it may be worth
> > cleaning up hashmap a bit first, especially around its clear/free
> > semantics, and its ability to lazy-allocate the table.
> >
> > I'm happy to work on that, but don't want to step on your toes.
>
> I have patches which introduce hashmap_clear() and
> hashmap_clear_entries() to hashmap.[ch], which allowed me to simplify
> strmap_clear(); instead of needing to call both
> hashmap_free[_entries]() && strmap_init(), I could just call
> hashmap_clear[_entries]().  Doing that surprised me with a significant
> performance impact (in a good direction), at which point I started
> adding mem-pool integration into hashmap for storing the entries that
> hashmap.c allocates and got further good speedups.
>
> I thought those were better explained when I got to the performance
> stuff, so I had held off on those patches.  I could pull them out and
> submit them first.
>
> However, there's an important difference here between what I've done
> and what you've suggested for hashmap: my method did not deallocate
> hashmap->table in hashmap_clear() and then use lazy initialization.
> In fact, I think not deallocating the table was part of the charm --
> the table had already naturally grown to the right size, and because
> the repository has approximately the same number of paths in various
> commits, this provided me a way of getting a table preallocated to a
> reasonable size for all merges after the first (and there are multiple
> merges either when recursiveness is needed due to multiple merge
> bases, OR when rebasing or cherry-picking a sequence of commits).
> This prevented, as hashmap.h puts it, "expensive resizing".
>
> So, once again, my performance ideas might be clashing with some of
> your desires for the API.  Any clever ideas for resolving that?
>
> Also, since you want to see hashmap cleanup first, should I submit
> just the hashmap_clear[_entries()] stuff, or should I also submit the
> API additions to allow mem-pool integration in hashmap (it's pretty
> small and self-contained, but it'll be a while before I submit the
> patches that use it...)?

Nevermind, I mis-remembered.  The mempool integration was added
specifically to strmap, not to hashmap, because strmap_put() does the
allocation of the str_entry.  So I'll just pull out the
hashmap_clear[_entries]() stuff and send it up.

>
> > I also wonder if you looked at the khash stuff at all. Especially for
> > storing integers, it makes things much more natural. You'd do something
> > like:
> >
> >   /* you might even be able to just write !strcmp in the macro below */
> >   static inline int streq(const char *a, const char *b)
> >   {
> >           return !strcmp(a, b);
> >   }
> >
> >   KHASH_INIT(strint_map, char *, int, 1, strhash, streq);
> >
> > and then you'd probably want a "put" wrapper that makes a copy of the
> > string. khash has its own charming awkwardness, but I'm just curious if you
> > looked at it and found it more awkward than hashmap.c, or if you just
> > didn't look at it.
>
> I did look at it, but only briefly.  I had a further investigation on
> my TODO list for months, along with several other improvement ideas.
> But it seemed like my TODO list was really long, and my new merge
> backend hasn't benefited anyone yet.  At some point, I decided to punt
> on it and other ideas and start cleaning up my code and submitting.  I
> believe merge-ort is more accurate than merge-recursive (it fixes
> several test_expect_failures) and is a lot faster as well for the
> cases I'm looking at.  So, for now, I've pulled it off my radar.
>
> But I'd be really happy if someone else wanted to jump in and try
> switching out hashmap for khash in the strmap API and see if it helps
> merge-ort performance.  :-)

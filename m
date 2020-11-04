Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3344AC388F7
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 22:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D99F420756
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 22:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4/hmXqw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgKDWVM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 17:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729564AbgKDWUq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 17:20:46 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A72C0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 14:20:46 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id w145so18235331oie.9
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 14:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FizTCiiKZSDf2HNJh8ezM7QyZV9NKoON5JkBK8EgJzk=;
        b=m4/hmXqwseYPnD+UPJKhZ6SezyYo5LiRKoFXNVA2lWyohW2qtI38hXVpvOxb+FuaZ3
         hhF1VpGY5/rbf34CuHjj8828LQhh0xS/Hs8h0Jk20waPB3HHFvAoLBvtME+yWQpz3eLx
         r0P+zLf4lpqddn22fdL44bXCklkUa9VBSNcaTjHOeJBmY9OT9TOpBCyBFJlGrUdjuk5y
         cpSK3ETsay1kiZYE9Jp3ii6qgbYpIxTHAK+vKSl4RKgMn9uKmqGTi0ETQMf9F0tbDhog
         75iTkiXd9dQseRGQAPcc6t5ePRI+78lXWHQbYjGqiFZ5x3qZ6G1C1F7lv+koPFEp77+o
         m3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FizTCiiKZSDf2HNJh8ezM7QyZV9NKoON5JkBK8EgJzk=;
        b=opYS93TKnIESegXQwPCqmjTXzaDY4zHwJt/apIM1SzVxpuJ0Yg3GZOqGeu7gngoJvy
         9hwwNU3kJT7r07zHGHMohPllZm+FtKHyqDddWHrtBDHHOgufqRYAlTp7Yecrpwg9kbN1
         Czja6Lnx1AfLurBYu9su84ZZXIBsvsvwoyB5XF75VPx9/a8lcligak8SYSWwbUTWx1EM
         PP24TeAewMLMGncWEPrZIs6/+/3KjgbldyYbiNC338QzU8BBY+rOnpLRDY/8pFP18BPM
         ++RjT2ecXlL/Mf0nGXIAURxvdm1I9wtfBh+GghAZZYZZXtQUPD7U3z6i5ngL4AYTPuSj
         27+g==
X-Gm-Message-State: AOAM533bTlHRGBoqDNaTFTUZvWZCeedpbzO+sgW4F2LP9A+Nf1D3Beun
        a4omw8W2cOJf7swETWzaJu2qQrFOZW/V9VyiiDc=
X-Google-Smtp-Source: ABdhPJyIoAOehhf6SYqU8n/0WuTL59Bk+qCjYpTwqY7QSiHD67MR0MwWaC8RzTWxKL2zdE0TFzV9ufjd9jJBM5LqTCU=
X-Received: by 2002:a05:6808:17:: with SMTP id u23mr3724272oic.31.1604528446067;
 Wed, 04 Nov 2020 14:20:46 -0800 (PST)
MIME-Version: 1.0
References: <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
 <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com> <20201104205250.GF3629238@coredump.intra.peff.net>
In-Reply-To: <20201104205250.GF3629238@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 4 Nov 2020 14:20:35 -0800
Message-ID: <CABPp-BGSgv07wuLQKTvApzmBEEbd7rnzH_xUSJ6gZGtHO6PXPA@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] Add struct strmap and associated utility functions
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 4, 2020 at 12:52 PM Jeff King <peff@peff.net> wrote:
>
> On Mon, Nov 02, 2020 at 06:55:00PM +0000, Elijah Newren via GitGitGadget wrote:
>
> > Changes since v2 (almost all of which were suggestions from Peff):
>
> Thanks again for your work on this series, and your willingness to
> listen to my various suggestions. ;)
>
> This mostly looks good to me. I pointed out a few minor nits in reply to
> individual patches, but there's at least one correctness problem, so
> we'll need a v4.

Cool, thanks for the careful reviews; I'll fix it up and send a v4 out.

> > Things that I'm still unsure about:
> >
> >  * strintmap_init() takes a default_value parameter, as suggested by Peff.
> >    But this makes the function name strintmap_init_with_options() weird,
> >    because strintmap_init() already takes one option, so it seems like the
> >    name needs to replace "options" with "more_options". But that's kinda
> >    ugly too. I'm guessing strintmap_init_with_options() is fine as-is, but
> >    I'm wondering if anyone else thinks it looks weird and if so if there is
> >    anything I should do about it.
>
> You could drop default_value from strintmap_init_with_options(). I'd
> _guess_ most callers would be happy with 0, but you'd know much better
> than I what your first crop of callers will want.
>
> I'm happy with it either way.
>
> > Things Peff mentioned on v2 that I did NOT do:
> >
> >  * Peff brought up some questions about mapping strintmap to an int rather
> >    than an unsigned or intptr_t. I discussed my rationale in the thread
>
> Yeah, I'm well convinced that what you have here is fine.
>
> > Things Peff mentioned on v1 that are still not included and which Peff
> > didn't comment on for v2, but which may still be worth mentioning again:
> >
> >  * Peff brought up the idea of having a free_values member instead of having
> >    a free_values parameter to strmap_clear(). That'd just mean moving the
> >    parameter from strmap_clear() to strmap_init() and would be easy to do,
> >    but he sounded like he was just throwing it out as an idea and I didn't
> >    have a strong opinion, so I left it as-is. If others have
> >    opinions/preferences, changing it is easy right now.
>
> Yeah, I was mostly thinking out loud. What you have here looks fine to
> me.
>
> >  * Peff early on wanted the strmap_entry type to have a char key[FLEX_ALLOC]
> >    instead of having a (const) char *key. I spent a couple more days on this
> >    despite him not mentioning it while reviewing v2, and finally got it
> >    working this time and running valgrind-free. Note that such a change
> >    means always copying the key instead of allowing it as an option. After
> >    implementing it, I timed it and it slowed down my important testcase by
> >    just over 6%. So I chucked it. I think the FLEXPTR_ALLOC_STR usage in
> >    combination with defaulting to strdup_strings=1 gives us most the
> >    benefits Peff wanted, while still allowing merge-ort to reuse strings
> >    when it's important.
>
> Yes, I'd agree that FLEXPTR is a good middle ground. If I really manage
> to find a caller later where I think the complexity might be worth
> saving a few bytes, perhaps I'll try it then and get some real
> measurements. My guess is that won't ever actually happen. :)
>
> -Peff

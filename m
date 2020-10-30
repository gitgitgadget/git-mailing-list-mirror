Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BA9C00A89
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 19:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0470820719
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 19:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1Gx9mu/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgJ3T4E (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 15:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgJ3T4D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 15:56:03 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C2BC0613CF
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 12:56:03 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id d9so1856975oib.3
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 12:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+JXsutNZbmCQwTJwY1dFHz+TNYhUc3+rIf135PBn5FY=;
        b=K1Gx9mu/mk2QeCWRRnQK0tVw3F9NPyXvkgPwDd+a4T6D7LjtKjfTPa9gtzdR5u/Zig
         iYPnUrKjMe72BDsXHYH8nAoP0NWwPw1DjSBWHhPTAl3p6PpE60ITxGvtHGHDXqQg2Tf9
         nPw5hq6t7reu1zKzFaP42SGNuDvoMTZ4yViJ/SxW/3BxbPL4Vz+sHDBHowutc+EyTJIo
         tRgrK9nqm2QQt9oBikp8C0IYUhW8Gnb0b2JeGUOPwe/GFDHk033SUBJRhAl2c+SvTxaV
         rHW1hce/cVzaJ6MqhpQGVQaO1fyVndSPYWz/tP/SLckFY52bDDj/t2ToFE31jTkZ8nhL
         JTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+JXsutNZbmCQwTJwY1dFHz+TNYhUc3+rIf135PBn5FY=;
        b=Gdyv2ybck956Hc8q/aocUg9L1BoLpjgXsH2XM3hZJS+G8/yKByg5WhmZejc4W4j7gb
         PaqR37y3yO7lQaiGvUsJ3r6/bRMSHgRsk9PQtnPsUWh+SBzpbq5bveEJf8xeHPQ2yIJp
         zyer2t/yNUdFs7N6gzBakcp8Q0cJ5jkDQufnfZUt70wprZnYf9jk9AkWmZRmYYavp41f
         UDOASqqYvH+axT+9oKyGnQpfQd7WFtHeEOFAMQvLzYYWnYuqbGLToM9mbf+Fz0IOTOLI
         jWMafc6zyVMJCz5DpbMJCCc2izwyZWEjDmPGzjPGBRfw8HbtP3OugpUvp3cL+v4Ymz54
         H41Q==
X-Gm-Message-State: AOAM531Oer9nihW75dcZlbIqjm3itiqO1HjGhOYHceVkq7TsxFzyG5LJ
        NFz1RKvlFvA8eH+i3rjHIdliCBfRXjWFmCHkzaL0TkpR1ak=
X-Google-Smtp-Source: ABdhPJxaEiDC+tNnBuw1XhKyaqOPo8Tm14V/2bivPSo/JvqRzuerOY8sUfzOtQvgYXDKHwQe5XX607V7Z7i2+k+bcZw=
X-Received: by 2002:aca:3b0a:: with SMTP id i10mr2888002oia.167.1604087762688;
 Fri, 30 Oct 2020 12:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com> <af6b6fcb460be900d3fffeb743a42f3f87ce6b7f.1602549650.git.gitgitgadget@gmail.com>
 <20201030125059.GA3277724@coredump.intra.peff.net>
In-Reply-To: <20201030125059.GA3277724@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 30 Oct 2020 12:55:51 -0700
Message-ID: <CABPp-BGdM0tkQgqRQzzpTOyKPoQVLsppK_EUcthAO8LbtzcTNA@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] hashmap: add usage documentation explaining hashmap_free[_entries]()
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 30, 2020 at 5:51 AM Jeff King <peff@peff.net> wrote:
>
> On Tue, Oct 13, 2020 at 12:40:41AM +0000, Elijah Newren via GitGitGadget wrote:
>
> > The existence of hashmap_free() and hashmap_free_entries() confused me,
> > and the docs weren't clear enough.  We are dealing with a map table,
> > entries in that table, and possibly also things each of those entries
> > point to.  I had to consult other source code examples and the
> > implementation.  Add a brief note to clarify the differences.  This will
> > become even more important once we introduce a new
> > hashmap_partial_clear() function which will add the question of whether
> > the table itself has been freed.
>
> This is a definite improvement, and I don't see any inaccuracies in the
> descriptions. I do think some re-naming would help in the long run,
> though. E.g.:
>
>   - hashmap_clear() - remove all entries and de-allocate any
>     hashmap-specific data, but be ready for reuse
>
>   - hashmap_clear_and_free() - ditto, but free the entries themselves
>
>   - hashmap_partial_clear() - remove all entries but don't deallocate
>     table
>
>   - hashmap_partial_clear_and_free() - ditto, but free the entries
>
> So always call it "clear", but allow options in two dimensions (partial
> or not, free entries or not).
>
> Those could be parameters to a single function, but I think it gets a
> little ugly because "and_free" requires passing in the type of the
> entries in order to find the pointers.
>
> The "not" cases are implied in the names, but hashmap_clear_full() would
> be OK with me, too.
>
> But I think in the current scheme that "free" is somewhat overloaded,
> and if we end with a "clear" and a "free" that seems confusing to me.

Hmm...there are quite a few calls to hashmap_free() and
hashmap_free_entries() throughout the codebase.  I'm wondering if I
should make switching these over to your new naming suggestions a
separate follow-on series from this one, so that if there are any
conflicts with other series it doesn't need to hold these first 10
patches up.

If I do that, I could also add a patch to convert several callers of
hashmap_init() to use the new HASHMAP_INIT() macro, and another patch
to convert shortlog to using my strset instead of its own.

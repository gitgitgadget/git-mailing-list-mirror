Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4D5C433E2
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 15:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17494208C9
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 15:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvbbOoco"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgH1P36 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 11:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgH1P34 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 11:29:56 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119D4C061264
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 08:29:56 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id w10so1169272oti.2
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 08:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wTzcoiYibaJMsEngIbbK60Unn6X0wupfZyDTm8zpLL4=;
        b=bvbbOocoybtDDQeaU8yPFkPg00+Ikfy2knijp7cYNeJJ7UhgNkRi4mdKdDchOFjQmc
         QwTlzYrEdl7QXp0Qd3YOzrOp70rVCP7EKQrG0x0S+vEMAqHwKuoJ+917cWZVAZTo5wwh
         kKg8rABMjkvB75kI6eigqC4FgnYTtdsyuXXTMB62xoJDWBrvFTyxS4k4EoW2ZyKzoWaP
         C7GwkBVj/jvj2z35ofrh12bTA5VHjvHM9G8ycFN00dumo9lJaP2ZJ0Xax4iIoIatr6+K
         Zvi4lzadKljdNbiQV66WrUchUfEs4wZrG/mz80S+ABkxJfte3ptIaf+eUO66npIFtWIp
         U6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wTzcoiYibaJMsEngIbbK60Unn6X0wupfZyDTm8zpLL4=;
        b=hPUD4tOTAEPIr1mLoek2f4kek+Gt2ffgXnQ5Bd8nIiP5wGKw+x1pWc7bJUcOQuzJTA
         gJwu15BRGtf2g1xGhRuZGnP+VNFBx2MgZxvazRFIeIF2FAtBs7Jncs/lXqzy9+RfYzDV
         CQ0vqc+wOIh9l6Kfl1rpiWneLYeusQ2IR8ZYSEr1JfCBZlzlWyT+tzE8Y6KYlZl89cVj
         r5Tp6RXTbtY+MPQCFlusoJKhYXacYhdY9RKv7pqfX5JulOHVlNjwVmlG3CROnVg+At1F
         kvKqGElbWEkf9OJpZj0Zs6HwKissfNEQtcgembMU2amyez9Ph+2Gbd6uy/zaw51JVKIk
         dM+g==
X-Gm-Message-State: AOAM5320ju1ElaWln078S3hbH8g+kApegBYd+fuSnJzM6i4CWw8d0K5c
        QrQiuW3V4db4ZrJyti42e46l6vIuJI45Hp6twas=
X-Google-Smtp-Source: ABdhPJy4TNIMkm/9VcyKJP9XsZC6+iJG9fyUJBxp5El5V54lkwUJtppOxSjqQZzQf6aqn8tDN3lYlr2tkc/0xkyxB50=
X-Received: by 2002:a05:6830:1258:: with SMTP id s24mr1557158otp.162.1598628595203;
 Fri, 28 Aug 2020 08:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <20200821201648.GH1165@coredump.intra.peff.net> <CABPp-BGYiphp-93Bf=2z-ZLd-Y=buTA0BCp6zuTJF39n1x3Rfw@mail.gmail.com>
 <20200828070335.GB2105050@coredump.intra.peff.net>
In-Reply-To: <20200828070335.GB2105050@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 28 Aug 2020 08:29:44 -0700
Message-ID: <CABPp-BGQB8rD8KyzccTQQ_X3Puyy3g5OOSEQES8Lv8Qtb-zRPg@mail.gmail.com>
Subject: Re: [PATCH 0/5] Add struct strmap and associated utility functions
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 28, 2020 at 12:03 AM Jeff King <peff@peff.net> wrote:
>
> On Fri, Aug 21, 2020 at 02:33:54PM -0700, Elijah Newren wrote:
>
> > However, there's an important difference here between what I've done
> > and what you've suggested for hashmap: my method did not deallocate
> > hashmap->table in hashmap_clear() and then use lazy initialization.
> > In fact, I think not deallocating the table was part of the charm --
> > the table had already naturally grown to the right size, and because
> > the repository has approximately the same number of paths in various
> > commits, this provided me a way of getting a table preallocated to a
> > reasonable size for all merges after the first (and there are multiple
> > merges either when recursiveness is needed due to multiple merge
> > bases, OR when rebasing or cherry-picking a sequence of commits).
> > This prevented, as hashmap.h puts it, "expensive resizing".
> >
> > So, once again, my performance ideas might be clashing with some of
> > your desires for the API.  Any clever ideas for resolving that?
>
> If the magic is in pre-sizing the hash, then it seems like the callers
> ought to be feeding the size hint. That does make a little more work for
> them, but I think there's real value in having consistent semantics for
> "clear" across our data structures.

I thought about adding a size hint from the callers, but the thing is
I don't know how to get a good one short of running a merge and
querying how big things were sized in that merge.  (In some common
cases I can get an upper bound, but I can't get it in all cases and
that upper bound might be a couple orders of magnitude too big.)
Thus, it's really a case where I just punt on pre-sizing for the first
merge, and use the size from the previous merge for subsequent ones.
If you have a non-recursive merge or are cherry-picking only a single
commit, then no sizing hint is used.

> However, one cheat would be to free the memory but retain the size hint
> after a clear. And then if we lazy-init, grow immediately to the hint
> size. That's more expensive than a true reuse, because we do reallocate
> the memory. But it avoids the repeated re-allocation during growth.
>
> It may also be a sign that we should be growing the hash more
> aggressively in the first place. Of course all of this is predicated
> having some benchmarks. It would be useful to know which part actually
> provided the speedup.

Your thoughts here are great; I also had another one this past week --
I could introduce a hashmap_partial_clear() (in addition to
hashmap_clear()) for the special usecase I have of leaving the table
allocated and pre-sized.  It'd prevent people from accidentally using
it and forgetting to free stuff, while still allowing me to take
advantage.  But, as you say, more benchmarks would be useful to find
which parts provided the speedup before taking any of these steps.

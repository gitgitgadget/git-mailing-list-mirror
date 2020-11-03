Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B746BC2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 16:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60BC8206CB
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 16:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGiWyeMa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgKCQQU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 11:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbgKCQQU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 11:16:20 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F5BC0613D1
        for <git@vger.kernel.org>; Tue,  3 Nov 2020 08:16:20 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id n15so16439900otl.8
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 08:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=paLJypuKS18plAmBRNwPf4/uZysw/VY7Q7yXabCCE9w=;
        b=BGiWyeMaq8XmfD1lrUIsDhWklaZ0qnAQL1U8q1ZB3Kb2448uNNvRjxULNsZTc1S1bk
         ZnBnIUxZAYmOtsIjH3hvWPwgHZb/W6f/kRYqjP1GLi7K+c6stex4+CjQRFYENBmIpYih
         2FWo3fosQdyeiYBs/O3X6PifMowzudec/VIocjw7CZ32RCI+lAbZ/ZKkmgxY7BGQ/sWT
         nMS1Apc5ZtQ6LzWLpsfcuhk5KMXbiWc7ANweEaEkgPevTrJCF+Aezjjt9vPajANz57T2
         xFdIwtQ2hwYlt0nV0fN60Muda06nsi5nFyRVht58Y696Vb/LdpibAGnuLCbssy+ZEk6t
         UX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=paLJypuKS18plAmBRNwPf4/uZysw/VY7Q7yXabCCE9w=;
        b=jgXUs63phNZ4HEHyBRlGD4vEHOXOD0+lkZKkjKU1XpXUnTK6J2KWaIA+sEGxRgCxaN
         dwst2oCdhD719O+VN3HCIc+EfrR4NYt1dPmBuaEuEFwPTzM63/Uy7K4e5jTQXl/lHFUY
         OH4INwtII6P8s0GqK6cnYpWOw7U0Kjj48kOknxd6ZpLNinJT1iDyfDkZW4hCUO1hSrFu
         zPJkqvqo3faXOHAvJ+VfZ2MvMu5qx0lvXGRK2tXWEGrVhBlTKFeYs6ucwMMIm5v4WGlD
         At+9YsCfV8tKrozHojP7xTRvSBlCBmmyFYmYVo2wsiVH/tB6OhM/3ZMT6kCxYohxcNA5
         11FA==
X-Gm-Message-State: AOAM531KDUmmnvyI3tfWIjQteuOX+LkK1P2lCwnY3Ua83A5DtZ6qYWsM
        d6V0xoR0rEWPOv/WoUHVssgSHvNJCleae/+j89KLHuFe2ek0mw==
X-Google-Smtp-Source: ABdhPJzs0rHabI8csMiuxQtHjmbrtv6Se6EEg690WDyvvJy+M1QxyWwWhTj2gF0QbY5U2Jx4dGnIa+eaDt7kU2a2ZLs=
X-Received: by 2002:a05:6830:208d:: with SMTP id y13mr2536116otq.162.1604420179534;
 Tue, 03 Nov 2020 08:16:19 -0800 (PST)
MIME-Version: 1.0
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com> <a686d0758a2652c91363dcf68da7726093d00c23.1602549650.git.gitgitgadget@gmail.com>
 <20201030133518.GC3277724@coredump.intra.peff.net> <CABPp-BHRSottxaYO+Ot5tPpNCf4scxmtwBLZicMJ4ChNEhmGHA@mail.gmail.com>
 <20201103160818.GB444466@coredump.intra.peff.net>
In-Reply-To: <20201103160818.GB444466@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 3 Nov 2020 08:16:08 -0800
Message-ID: <CABPp-BH7A7jXWm28+gpFHacMnteNN7gRLpWT6YaVqqkAffn8Mg@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] hashmap: allow re-use after hashmap_free()
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 3, 2020 at 8:08 AM Jeff King <peff@peff.net> wrote:
>
> On Fri, Oct 30, 2020 at 08:37:42AM -0700, Elijah Newren wrote:
>
> > > This part I disagree with. If we did:
> > >
> > >   #define HASHMAP_INIT(fn, data) = { .cmpfn = cmpfn, cmpfn_data = data }
> > >
> > > then many callers could avoid handling the lazy-init themselves. E.g.:
> >
> > Ah, gotcha.  That makes sense to me.  Given that 43 out of 47 callers
> > of hashmap_init use cmpfn_data = NULL, should I shorten it to just one
> > parameter for the macro, and let the four special cases keep calling
> > hashmap_init() to specify a non-NULL cmpfn_data?
>
> I'd be fine with it either way. I actually wrote it without the data
> parameter at first, then changed my mine and added it in. ;)
>
> You could also do:
>
>   #define HASHMAP_INIT_DATA(fn, data) { .cmpfn = cmpfn, cmpfn_data = data }
>   #define HASHMAP_INIT(fn) HASHMAP_INIT_DATA(fn, NULL)
>
> if you want to keep most callers simple.

I ended up going with your HASHMAP_INIT(fn, data) in v3 that I
submitted yesterday (except that you have a stray '=', are missing a
'.' in front of cmpfn_data, and you'll trigger BUG()s if you don't
also add .do_count_items = 1, but those are all minor fixups).  In the
future, if we determine we want/need the extra simplicity then we can
always convert to this newer suggestion.  I don't think it's that big
a deal either way.

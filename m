Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE5EC388F7
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 20:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D35C020874
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 20:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWE3M1Wh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372073AbgJVU7b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 16:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897292AbgJVU7a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 16:59:30 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2683EC0613CE
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 13:59:29 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id 16so3273499oix.9
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 13:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PKYyjYnXqU1sgiwZJaZVO6N/I0klS+YYLBZn/4G2Slc=;
        b=lWE3M1Wh0Cvxonu8GenGkernEwyKmSHehyL6Rad0o2huRjdMUQ6g0ktttV2Dkc0tSH
         T19ycMQ/lo8gANtU2G+DVt8NTnSzdU+mTMRGZcBr0qpnqpu9p3rcEUfq2Xo0l6tiCkfk
         kF7BgQrmAjgI3HVNzg7OC4bBnvTsOz0B1WtQr3dDbn+swZbsQ3qiWcys6z58LBmJyx/Z
         BG9HwAMJExelGtJtkXsr6McyzRizbUUSh5YUiD0NXWvOND3QLNxz81a8k1e/vgghN+oJ
         NcQj2x942rDNjtXJKwyPED+gdhJidZs/czDc3+sOHRSBJtgJ9O59hbWBbGi7xbCzzBwN
         sZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PKYyjYnXqU1sgiwZJaZVO6N/I0klS+YYLBZn/4G2Slc=;
        b=PddnUzBNGWRvi8SVdVok+j6uo+gR1WSvloNPpc/ocDIYpUglEPpLu4xpR+HnKjQ0XN
         rNW+QLrXZG4lOO97NQeZjP3/aQ9rF045q8IogzsUaV86suZMr7jkUO8tFiW46v7f29JE
         /guUl1F44tY8uvEgp5gZMJPgX38vdWP5uphfx4SK7Mc0JC/UeqrHK/w+tbQKRRO0EwpI
         A/ov/e4Mg8+UrJVXxAF8mwf1mV9j+e3AghYvxeTaeSks3N3GPYYfJXqnNZww1qcQZfzO
         6lU+ZYKd1OmyKBHsG65DjMpNc8wdZOwXQ3ctaWCHOH3SKPEffCxNXskDfqDA4rU7DF4V
         aq3Q==
X-Gm-Message-State: AOAM533JN3i811W5HKDZzfoVvdjTz/Ft9g+KLElutmsczbTczMWHxYgo
        AaY/Yx0VuDnIMr9AZPY2MOxH7nDQhEPaXtr9kV0=
X-Google-Smtp-Source: ABdhPJy0ILdiyMR7s3tmihFJE9rHcGin+dHjEGDJMVv5hQMe6oMJTX983RNnTvGFOAO/1AzMwMhfnZYQlTF76Cr3BVw=
X-Received: by 2002:aca:c5ce:: with SMTP id v197mr2422399oif.93.1603400368508;
 Thu, 22 Oct 2020 13:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <pull.767.git.1603303474.gitgitgadget@gmail.com>
 <pull.767.v2.git.1603326066.gitgitgadget@gmail.com> <20201022174043.GA775513@nand.local>
 <xmqqblgum7qk.fsf@gitster.c.googlers.com> <20201022183822.GA781760@nand.local>
 <xmqq7drim5st.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq7drim5st.fsf@gitster.c.googlers.com>
From:   Nipunn Koorapati <nipunn1313@gmail.com>
Date:   Thu, 22 Oct 2020 21:59:15 +0100
Message-ID: <CAN8Z4-Vb3qc7eyzczEC7hcf3DmHEXkcV1AGRfC_L0uFKDU2W5A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] fsmonitor inline / testing cleanup
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> from Taylor
> I'm still iffy on whether or not this series makes sense to apply
> without the rest of the code that depends on it

Sorry for confusion. I don't think we should assume there is more code coming
related to this. I think this is intended to stand on its own.
It's not a required dependency either. Rather, it's motivated by
simplicity
- remove the dir.h dependency from fsmonitor.h.
- Keep implementation in fsmonitor.c and definitions in fsmonitor.h

> From Junio
> Those without fsmonitor would pay the call/return cost for no good
> reason if core_fsmonitor is not set, and checking that on the caller
> side may make a big difference.  How big?  That needs measurement.

Noted! This is not called out or measured - it is simply assumed based
on earlier
conversation. I should be able to run the fsmonitor perf suite before/after this
change and include the results in the commit message.

> This is a tangent, but with or without inlining, I find it iffy to
> see that untracked_cache_invalidate_path() is called only when
> fsmonitor is in use.  Does untracked_cache depend on fsmonitor for
> its correct operation?  Why is it OK not to invlidate when the
> caller would tell fsmonitor that a path is invalid if fsmonitor were
> in use?  The call is a statement of fact that the path is no longer
> valid, and that bit of information would be useful to the parts of
> the system outside fsmonitor, no?  Puzzled....

I did some source diving in an attempt to understand what's happening here.
I believe that untracked_cache_invalidate_path() is called in dir.c
whenever an entry is added or removed from
a directory.
This is an additional call when fsmonitor is enabled - because
fsmonitor's whole purpose
is to avoid the lstat on the other path. There is a nice explanation
in the original commit message

Commit 883e248b (fsmonitor: teach git to optionally utilize a file
system monitor to speed up detecting new or changed files.,
2017-09-22)

--Nipunn

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C89EC433F5
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 01:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5374613CE
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 01:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243540AbhI2BCc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 21:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243532AbhI2BCb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 21:02:31 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05393C06174E
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 18:00:51 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id n17so1030720vsr.10
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 18:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w8kG/BGSeASPJeKCj0GqKbWW7yTig3k9VZepjRM5U4I=;
        b=Aa3G4YlsjkfVg4eIGuRvRR15YHXnCwuCvJkoMJ0tPDW90m+h0RWGRfzkTQ5z+nFKb+
         EqCniCicu/E3mu6WMuj1GM5HWFbAHXtA+2ylcPnMqqE3pTtNzfhI2pR0zAolAE05+f/0
         7g/uPij1XQHWatQ3hU5Xguzbf1LRi7v20YfQgU7uCFM1QWVnrFZuKINI+bXQT49vJtQp
         bfpfumS/8cONO0na9qHWJ9DunmWVheaGVSx0W4ZJ5pgoOSz3BPIhfSkz28GSrop2PBWN
         frRNk+dq7mIDK8soGTj+eNM2g2lKR4qgO11C8xbct/V/4ySCrPYp486tAgTwGlP1wuo2
         tsvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w8kG/BGSeASPJeKCj0GqKbWW7yTig3k9VZepjRM5U4I=;
        b=Sh8zZFUzRCwR8cYvh1K+zX1/bQ05SFPIN2sFtlwBoLl9IzpowmORTBJLZmNo68pK5J
         BaKL3pGCGM7lzApnMafLiGbggfMaeRdG45E+lUgwLW/HUAB9YvTYlNbhfP1RB8hb9est
         gRNverqrnHmn0W0iufnEKJsSSGeXHEb+wMS8mU8q9QrajY56CExo28w04GdplisLIutj
         Y9gTPulZvl4cIIWby/2wqIytE0G+I4sIZ4r013vDRUotLHn5tSqYPC6/dfEgR5PPvow2
         6Yo/lrX8v3cYWIwknmf3lrOMb4qMah+M+r/3VwVIxcX4dz8cw8cKQpXNyZ8IbRrmx47r
         GBYA==
X-Gm-Message-State: AOAM530aHSfw1zq5R1mQ0Oa9o9TlnK3WDRrTw2HE6P3+cdoDWo4KE/cc
        Tl5U0petS+cQ2gRdR4BucAUFvSHh4WhCIulQSYE=
X-Google-Smtp-Source: ABdhPJyeIMYsFr5+yZtwkhkxsen2Ob2ootLYOEkJeHto4WIXLl7bl/xkRP5uMv0c75Z/Fn+/i0OTvcIG/LtE15w1sPE=
X-Received: by 2002:a67:fa41:: with SMTP id j1mr8327819vsq.11.1632877249918;
 Tue, 28 Sep 2021 18:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq35polhye.fsf@gitster.g> <20210928201613.1110573-1-jonathantanmy@google.com>
In-Reply-To: <20210928201613.1110573-1-jonathantanmy@google.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 28 Sep 2021 18:00:36 -0700
Message-ID: <CAPUEsphVJBCPLSfOyH2bqTCpcDvtPuOVGQsD3XaWVuZbFiVUeA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] win32: allow building with pedantic mode enabled
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, peff@peff.net,
        avarab@gmail.com, phillip.wood@dunelm.org.uk,
        sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 28, 2021 at 1:16 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > Carlo Arenas <carenas@gmail.com> writes:
> >
> > > Apologies; it is gone already in "seen" (and hopefully soon in "next")
> > > by merging js/win-lazyload-buildfix[1]
> >
> > I will mark it not ready for 'next', while waiting for a fix-up.
> > Thanks for stopping me.
>
> Just checking - which branch is not ready for next? The issue I noticed
> is already in master, and js/win-lazyload-buildfix contains the fix for
> the issue (which ideally would be merged as soon as possible, but
> merging according to the usual schedule is fine).

My guess was that he meant to have also the windows specific check
added as part of this branch, and that would have prevented the issue
you reported originally as well.

Either way, a v4 has been posted[1] (sorry, forgot to CC you), and
hopefully that is now ready for next ;)

Carlo

[1] https://lore.kernel.org/git/20210929004832.96304-1-carenas@gmail.com/

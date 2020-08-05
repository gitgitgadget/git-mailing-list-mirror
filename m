Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BABC433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 20:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E8EC22D00
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 20:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfMMLwlt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgHEUeW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbgHEUeV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 16:34:21 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1D9C061575
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 13:34:21 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id r197so5632455vkf.13
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 13:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/iD1kKq22ezeKtETTDiVJZdE7b0BaKOjhy5Mc0tvE68=;
        b=GfMMLwltXkQXJ2GCk3eawjOAbNNAIQxOfBLZelRQJVks/pbz2cuqv8sz0C2CeE1rBS
         0WJ+Q1z2P8u7B8RAUdD+o2EBGz0E0ec1D/TBD+J6RStFaBHNWAirKi/NkPMhO3vuSVyq
         0h+CRZi+g5nhRutkmdNcga2fgpyojCKYUHhhtSqLDwIDposTY8fsxYXshN4JMADk7jzN
         m3tDd3WXN/5FgY4LSmnp8s4bXXsFkQcSlJgZNAj/JjYOLhu18nVF14izfGdw2jOdRy8M
         ujUgPNKBnqzEs5bdqYU43aLSWX8zalVuW3xjcUs1admAeq+JnGLhT8d2niKVbV7w+o+u
         mqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/iD1kKq22ezeKtETTDiVJZdE7b0BaKOjhy5Mc0tvE68=;
        b=nt5zLVjkNUR/SjQeRJEZJQnh757/Gjj9uKpIu4SfMypW51+MebC8AEhL7gMPv9Hei4
         m4cYVXhhN8+Ffo6VaUuxb1vI04GOvnAckism4LnLeb0YN51YPn+3b0u4UM6YCIKwEvIC
         j7GKPP3IWCxzq7w3Fk5fI7pfEKO/CAfwDNNvP7Vvw2ABHNzvRtiDU0w0zXjv4nrf6BIn
         KjP9jwK8+Pbdclctw93VjT9gYXWzU6wIuDWQad4EBNxbyXgIdJEtnJFUPDfQel5qisY3
         5sdvgpcm8fvRXIwu3LAT62n3cIIkrT4dZP1/nKDNd/mybtH9ftTu+KSrRK92Y37AWtgU
         8UEg==
X-Gm-Message-State: AOAM533+mQLvMF3HdDvNjM4uUgt+NgiYyv/Fk1gZcYhXb/c2yoFkqDhm
        1gOQgQE1P234QPjauUKWLHwJ1qspPmGLNAPc4jWf5Jp5
X-Google-Smtp-Source: ABdhPJz9FtcKxgtTK4NdO7VYgfFpRW+vFWp0IDeE/vuOAu4dvdG7/x+DxttyBji30YJW4Vlp82g8Wvn4zSMvjBFBZjc=
X-Received: by 2002:a1f:9149:: with SMTP id t70mr4240320vkd.14.1596659659863;
 Wed, 05 Aug 2020 13:34:19 -0700 (PDT)
MIME-Version: 1.0
References: <CA+P7+xpokJ3Z4xZ9ibCBpBO65D1v-AD6_JknprGUsEDxEvMGGw@mail.gmail.com>
 <20200805063704.GA2690083@coredump.intra.peff.net> <xmqq1rkloyeg.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq1rkloyeg.fsf@gitster.c.googlers.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 5 Aug 2020 13:34:08 -0700
Message-ID: <CA+P7+xrAyCgYyh4_WM5hcBv8+WXaRvN_Cf6nqz4ruO4oHzwjvQ@mail.gmail.com>
Subject: Re: avoiding fetching specific refs from a remote
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 5, 2020 at 9:22 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> >> Essentially, because both main and master have similar names, tab
> >> completion requires remembering to type one additional character than
> >> I am used to.
> >
> > Heh, I didn't think anybody considered that implication so far; the fact
> > that they were similar names has generally been considered a positive. I
> > agree it would be annoying.
>
> FWIW, I've been saying that 'maint' will become harder to type all
> along ever since I heard 'main'.
>
> https://lore.kernel.org/git/xmqqtuz9tq30.fsf@gitster.c.googlers.com/
>

Right. I'm generally for the name change, and I like having the remote
honor the old name as a compatibility at least for some duration.

> > This is definitely a reasonable thing to want, and it has come up off
> > and on over the years. One search term for the list archive is "negative
> > refspecs", though it turns up a lot of useless hits when the two words
> > are not directly adjacent.
> >
> > This old thread might be worth reading:
> >
> >   https://lore.kernel.org/git/20140124090104.GA396@x4/
> >
> > and there is even a patch in there:
> >
> >   https://lore.kernel.org/git/20140125013433.GA22336@sigill.intra.peff.net/
> >
> > but I didn't go over it carefully enough to know whether it is utter
> > trash, or something that could be used as a starting point.
>
> I think the idea is interesting.  I sometimes find negative
> pathspecs quite useful, and I suspect negative refspecs would also
> be.

I've found negative pathspecs incredibly useful in some contexts,
(with my only issue being to remember that if you specify a negative
pathspec, you must also specify a positive one i.e. "." or something)

I think I'll try to revive that one patch Peff pointed out and then
see if it makes sense or needs to be redone.

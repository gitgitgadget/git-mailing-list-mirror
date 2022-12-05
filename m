Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852D2C4321E
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 12:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbiLEM4Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 07:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiLEM4P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 07:56:15 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FE01A392
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 04:56:15 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-3704852322fso116641027b3.8
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 04:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+CTpYNMNsuaaLUpRcX6C0SYa44WBI1bMeW7u64IElKc=;
        b=MkMkK1Ktk40RUs12aI/Jn2O/gkt3PnX300cQaGcLT4DHvzLANBS2zhhArPZcOSz0gp
         iWDt6GoBrOzp0eH++5baCfVT9eR9qBCkkouc5v7mFukcHtYdkwGZCZcgCa4G3tlR2Dpr
         4WYQ2NLDiBETcfsNttSvNYqTB7v9KKYCOJXS2sknoWUfPf9g9/UHjpx+DK2rH4/3bxip
         8xyfXmEI7vIpB/M4fRoUvhQqayOKlLnyr78CqJe6GjGrcVFHqa1ByPOil15IUh0PfSYr
         d0qmzwIGtE7P1ksUE0uOFtxrsRp8phTpWzwLZezcgseUM1xw7/wi2CxJHEignu5y/xmw
         YMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+CTpYNMNsuaaLUpRcX6C0SYa44WBI1bMeW7u64IElKc=;
        b=2S9NiB0HXVAM+ice/NJ3jz41or3HLw/i1e+s9rkTmXOc5bK6KS9crGPsMj8uZ+o89b
         MnrV2gXOag9u3HbSBdR8dWOrjhr1JROgR0a8IvK39K7UjwZS7BAKS7GyitRn/DwNoSbx
         hZDuFVeDbCYdS1LQwxbkMIozM0UFPj4gFQlr/9zVh3AklJyb3Ve7DHGO8gtNfBzr/h8i
         THmFPEYs52xV/fpCiUetiJpLWwdWQepPCIx6ccIYYUT3FMQTqwpyaUypm1utbRTcYWHb
         R2JWZA+pCoo1F+Mm0m38kvOpIY8PAiVvCFrey9G8KFkVmDvdoCV70w9XxiBU6GUTHMkn
         OAoQ==
X-Gm-Message-State: ANoB5pm1VyS5zX0PjsFA/oH+dTgr63M5fQWPiwtPNBoClHfbzOcvFyAK
        8FLQPNQjkaDCt8oSs9MGow1EGZ6kUSP/PiRUG6YDP2mOXxY=
X-Google-Smtp-Source: AA0mqf7nytE/f4XlvZF1dw2gJFb5yaTsKn3ft7i+c92jxu1dWYRdyNJqUELrO5yrQrIS0j1+mdp8m7wHvGYvqqJVpUw=
X-Received: by 2002:a81:5c07:0:b0:370:4db0:6a3c with SMTP id
 q7-20020a815c07000000b003704db06a3cmr60010084ywb.179.1670244974278; Mon, 05
 Dec 2022 04:56:14 -0800 (PST)
MIME-Version: 1.0
References: <20221202141153.GA5599@cventin.lip.ens-lyon.fr>
 <75e00d43-3184-dcf8-4621-cdf02c9f7320@dunelm.org.uk> <20221202170144.GC5599@cventin.lip.ens-lyon.fr>
 <a97758b5-dfdc-9a24-654b-8846a9feb45d@dunelm.org.uk> <20221204154927.GF33204@zira.vinc17.org>
In-Reply-To: <20221204154927.GF33204@zira.vinc17.org>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 5 Dec 2022 13:56:02 +0100
Message-ID: <CAP8UFD1G++GvNxCVdwDqSm4P3SseyOWNh2jKBZ4jm-OTn2Vsmg@mail.gmail.com>
Subject: Re: git cherry-pick -x: missing blank line before the "cherry picked
 from commit" line
To:     Vincent Lefevre <vincent@vinc17.net>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 4, 2022 at 4:49 PM Vincent Lefevre <vincent@vinc17.net> wrote:
>
> On 2022-12-04 15:13:52 +0000, Phillip Wood wrote:
> > On 02/12/2022 17:01, Vincent Lefevre wrote:
> > > First, one issue is that this is not documented (I was not aware of
> > > the notion of trailers, well, at least concerning a special handling
> > > by Git).
> >
> > They are mentioned in the documentation for 'git commit' see the --signoff
> > and --trailer options. The main reference is 'git interpret-trailers'
>
> This issue occurs with "git cherry-pick -x", so that one could expect
> documentation there. Since I don't use trailers (this was a false
> positive), I wouldn't have the idea to look at the --trailer
> documentation.

Yeah, the documentation for the -x option on the git cherry-pick page
should probably say that the added line will be put at the end of the
trailer part of the commit message and perhaps link to the git commit
or git interpret-trailers page. Patch welcome!

> > > Then perhaps there should be some configuration to define which
> > > tokens are allowed (or forbidden) for trailers. For instance,
> > > I would say that "Note" is too common in log messages to be
> > > regarded as a trailer token.
> >
> > There are some safeguards when looking for trailers (see the
> > interpret-trailers man page) I think you have been unlucky here, I don't
> > remember this being reported before. I've cc'd Christian who knows more
> > about trailers than I do to see if he has anything to add.
>
> I think that what could be interesting there is a
> trailer.<token>.separators option (assuming that one can
> use an empty list of separators to disable a token), but
> that doesn't exist.

There is the trailer.separators config option. I am not sure if it
disables trailers completely though if it is empty. If it doesn't,
that could be an interesting feature to implement for people who don't
use trailers at all (except for lines added by cherry-pick).

A trailer.<token>.separators option that disables some <token> when
empty could be another interesting idea, but it might have drawbacks.
For example you might disable the "note" token, but then find that
people sometimes use "notes:" or "NB:" or "PS:" or other things like
that at the end of their commit messages.

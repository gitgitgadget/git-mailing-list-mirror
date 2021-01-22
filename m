Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822DCC433E6
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 20:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DB8723B04
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 20:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbhAVUc6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 15:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731066AbhAVUa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 15:30:28 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E2CC0613D6
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 12:29:39 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id b11so6666650ybj.9
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 12:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hnho0tb1ykmpagsaoud57dfLr4fLhPkMp/Lw1mCXULw=;
        b=EHD8RYd3e+YB2reOagYgvFk89SwuyaiGyG+J+1PtA7vey1P7QEfqu5i13J1orwGAoo
         xIfyRPuPmI9zlKnnZtD3is5wc3FDaYHhRJYcqm38E4lMK4SfO1IdnxTKXw0KxModias7
         tTbu/v/q5VfmO7f+fkuxFMy/v7wvF7hwQVV2qWlHcNEmSNdYSQIrXS7aVxtcauYRqg0c
         KvxoEVVipPlyWEma7LUGX0F69xwObEZN4cr+/KzBxG1xRvJFQJ0wOvn08ef3HbDmosB7
         69aRKN08xP4l7+AHzypPHzJ1vVNTWf5izd2CAw7NSf8Z0DoFC1hx+Xn1WJ61YirWeaOv
         REAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hnho0tb1ykmpagsaoud57dfLr4fLhPkMp/Lw1mCXULw=;
        b=bmDOaXiGEdaWu/gPuQ3yLXz8fbXbaQ+ZhUCxz9xTTvF/0j4HxgMr3HEr8IeJvhxap5
         Qa0vRsD7pFVYo28xtjMARozBDpBtmr5v161liY8VC3Hf1xmoMFTQulzWKo3+6QGx4q7u
         YN4Wx3f0AsonF7ptBNWE9gk3fp44hzNFVu683ereSeov89Hfz2oDrn78QbnndpeC+pZA
         tSaxLcDS9Et7SIEDrBpNsfcUpeM1VbmOBnDJj2gTB80J5srXnBq7nyFK3vtmxdvKOcZV
         UyXNZDZsrQLWPEk+9zQCc4URveVx0FXF2fktzepgm+nq2gHX3jDDG1uLnHsldtKA6KPi
         goOw==
X-Gm-Message-State: AOAM531xkGSslns1eiDA5ov0dwaPNSN37eQN6MddIyrsGbMoHZne9VGJ
        wSCUlBqrDYn7Uv0EO2ZVFcVw8lBo2uvkDve2JxQ=
X-Google-Smtp-Source: ABdhPJyjSsMThCX1+Gqy0gstDBVW6FsnxiLDKJVrWoGRKNuwfH9d1+RVAikZqA9mlZrqq3Uu7Cg1aDncAsUVdzkbVTA=
X-Received: by 2002:a25:16c5:: with SMTP id 188mr9120233ybw.62.1611347378932;
 Fri, 22 Jan 2021 12:29:38 -0800 (PST)
MIME-Version: 1.0
References: <20210121032332.658991-1-phil.hord@gmail.com> <xmqqpn1xalav.fsf@gitster.c.googlers.com>
 <CABURp0pqdK+Mrqi=r40YeUitaB2s44iYO=2UFFSh0UC_o4Mosg@mail.gmail.com> <xmqqlfclaf6b.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqlfclaf6b.fsf@gitster.c.googlers.com>
From:   Phil Hord <phil.hord@gmail.com>
Date:   Fri, 22 Jan 2021 12:29:27 -0800
Message-ID: <CABURp0rvK=53L6UsSirZ0bs-FhK+s_3s7VNvwhR4ky-Pf7HEog@mail.gmail.com>
Subject: Re: [PATCH v3] use delete_refs when deleting tags or branches
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 21, 2021 at 6:17 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Phil Hord <phil.hord@gmail.com> writes:
>
> > Oof.  Sorry.  I forgot I have diff.noprefix=true in my local config.
> > It is a huge timesaver for me when looking at diffs on a console since
> > I can quickly highlight the filename with a mouse to paste into an
> > editor.
> >
> > Sometimes it bites me, though.  Usually I notice in the diff, but this
> > one I was sending with format-patch / send-email.
> >
> > I guess I'll turn that off in git.git so I don't misfire at you again someday.
>
> I think per-repository configuration might be sufficient for this
> particular case (after all, it is project's preference), I wonder if
> a more command-specific variant of diff.noprefix so that "log -p"
> and "format-patch" can be configured separately would make sense,
> something like...
>
>     [diff]
>         noprefix = true
>     [diff "format-patch"]
>         noprefix = false
>     [diff "show"]
>         noprefix = false

That seems reasonable.  I was trying to think of something clever like
a setting like "auto" that means "noprefix when output is to a tty".
But I still sometimes send a patch to a coworker that I copied from my
console and I then have to remember to add back in the prefixes.  So
there is no perfect solution from Git, I think.  The correct solution
is to teach my console to skip the prefixes when I double-click the
filename; or to add symlinks at `a` and `b` in my project; or
something else.  But these are all more painful than noprefix = true,
so far.

Fwiw - I know this issue has been discussed on the list before; there
are others who feel this itch.

Having config diff.<command>.noprefix seems reasonable as a fix for
format-patch. At first glance it seems like this could get confused
with diff.<driver>.*, but I suppose those settings are all specific to
a driver section, so it would be easy enough to keep them separate.

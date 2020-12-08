Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D512EC4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 20:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AE4522582
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 20:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgLHUxp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 15:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgLHUxp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 15:53:45 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78E2C0613CF
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 12:53:04 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id l207so17996846oib.4
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 12:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=unwhxH4iPMrn93ntrlBNW/EurKvCZxQpmYnVUG7rE18=;
        b=U10RQSFyAx7LfI6rg/+h5zSB2cIBzC6bwDin7DcwnM+aX+LOWacxJbjcjrFiPOnYk2
         jIgkmzs5+ws/t1Q+j544VOG0idNNPHSnUmstmSvHl7BbQ0jGLdlX9QDlXyrur2n36gkw
         SfeN1Kln475Clmfp7FpR2K1SleRZGg7i4TG4nEX2dLOdenhfCp+Sl9rLomP4vEU1spvy
         oVtU07LqXuMtxxpmDBWwnjPa12ITCH1aWl9p1YbbqBPNPgQL4mMIGMpp9QKkeYLUh632
         KSdPDEosu29sSVmLmt1G4qk7ihlENesGxLyjVDqMgyJ4q20gBb/pt6lzi/IGe730GPbO
         v6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=unwhxH4iPMrn93ntrlBNW/EurKvCZxQpmYnVUG7rE18=;
        b=LQWTxcrkPaLJ8BX2MpfX/ppyfG0poAr+v4cnQ7puJQVGJ5rlB8eeB4Ii5dijPBSuiG
         Y4u5mZpiljx7HsYDhHyYHb5T0jo7n8O/6H4nfFqfZQHsH0m+4dChuOepxYwuY6JtoQQX
         1E8MEkMnRhKlNsqJzP/ZQS2ZaWB3GAGfRMMNJe4Q9uyD6llIhm1Cklecm8LoAGBfPK9e
         7lx6MAiAPE7a86gLkDt4RK79nIcKLuXgCGurxQZt1MkoOaiQ/E/DAjU3wVWiJHD4IB57
         LJDdy2AvhllrJVe1hlWSR9M7TywTfLGS4wh2O/jp/ZP50Ll52vn8MaLYH1eA4LKSM9n4
         wDQg==
X-Gm-Message-State: AOAM532phRKZqEWBtVBwkJIrAkmfzhaLSSJzlE6OB5Ps92DfD6Si8hqv
        joqOAv3Psg3vMRfgu4heBsunCvMrD91woascj6M=
X-Google-Smtp-Source: ABdhPJzMUGUS76twwEaQtZ3eB9nZcIiVIR2a8wirzzNYw3ptFr0FzhTO4aSLbkVpyKUij9S5B630UOURjZZ59ndJQhc=
X-Received: by 2002:a05:6808:991:: with SMTP id a17mr4120615oic.167.1607460784109;
 Tue, 08 Dec 2020 12:53:04 -0800 (PST)
MIME-Version: 1.0
References: <20201101193330.24775-1-sorganov@gmail.com> <87y2i8dptj.fsf@osv.gnss.ru>
In-Reply-To: <87y2i8dptj.fsf@osv.gnss.ru>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 8 Dec 2020 12:52:52 -0800
Message-ID: <CABPp-BGuLX8Msghbo6L7vB2Wqys=Xg_uvV2Aui-1q4-+ijuNEw@mail.gmail.com>
Subject: Re: [PATCH 00/26] git-log: implement new --diff-merge options
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On Tue, Dec 8, 2020 at 12:07 PM Sergey Organov <sorganov@gmail.com> wrote:
>
> Sergey Organov <sorganov@gmail.com> writes:
>
>
> [...]
>
> > The series also cleanup logic of handling of diff merges options and
> > fix an issue found in the original implementation where logically
> > mutually exclusive options -m/-c/--cc failed to actually override each
> > other.
>
> Working further on this, I've noticed very irregular interactions
> between -m/-c/--cc and --oneline:
>
> 1. --oneline disables -m output for 'git log', and leaves -m output enabled
> for 'git show':
>
> $ /usr/bin/git show -n1 -m --oneline 2e673356aef | wc -l
> 80
> $ /usr/bin/git log -n1 -m --oneline 2e673356aef | wc -l
> 1

If you leave off --oneline, you'll note that git show produces a diff
and git log does not (regardless of whether 2e673356aef is a merge
commit or a regular commit).  So, I don't think this is related to
--oneline.

> 2. For 'git log', --oneline disables -m output, and leaves -c/--cc output
> enabled:
>
> $ /usr/bin/git log -n1 -m --oneline 2e673356aef | wc -l
> 1
> $ /usr/bin/git log -n1 -c --oneline 2e673356aef | wc -l
> 16
> $ /usr/bin/git log -n1 --cc --oneline 2e673356aef | wc -l
> 16
>
> The question is: what's the right interaction between --oneline and
> -m/-c/--cc?

I believe the right question is: Should -m be a no-op unless -p is
also specified?  In the past, --cc and -c were no-ops except when -p
was also specified.  It was somewhat unfriendly and surprising, and
thus was changed so that --cc and -c implied -p (and thus would cause
output for non-merge commits to be shown differently, namely shown
with a diff, in addition to affecting the type of diff shown for merge
commits).  I think -m was overlooked at the time.

> I tend to think they should be independent, so that --oneline doesn't
> affect diff output, and then the only offender is -m.

I agree that they should be independent, but I believe they are
already independent unless you have more evidence of weirdness
somewhere.  The differences you are seeing are due to -m, -c, and --cc
being handled differently, and I think we should probably just give -m
the same treatment that we give to -c and --cc (namely, make all three
imply -p).

Hope that helps,
Elijah

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F674C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 00:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 730F760720
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 00:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbhHDAow (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 20:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbhHDAov (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 20:44:51 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2539C06175F
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 17:44:38 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id u10so949039oiw.4
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 17:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LA9Z8ETDka2Lfl+0RDplbd4baLWxYgkKqfbV9/IHSUg=;
        b=tdVS9zdVL8T0uwqnQat5SXWsOPLhfnt1M1Vh6lylOFwnYJ+9go+tZ091mAHsZzf8ZU
         NEnlfPHsfe5VIf7kabV8DYfMk/t5JCMx2XAJ4UBaDL8Rmxk5wJKLYw4fy1Llavctg4hE
         jvUs/RwyVFk36CPMgTc5SPZEAZiCGpefy2TYnGeush2XEP/bh7wkTP/ily6NfNVmTGEn
         W4LMrtED0zMBdcPNkbVUZwj/7n6gkgzLKGuu2ZZPieMs20d8fZde01NrtTzjkcfdyIWf
         KFp3nnb6ERXLs+ExaFJHXjqblWtVohrhZGokbX7Q5TQc7IoNaIsATQxPKJ6BpmGw1iYN
         9kxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LA9Z8ETDka2Lfl+0RDplbd4baLWxYgkKqfbV9/IHSUg=;
        b=SWVpqdbvZICbQ+GeWcC97bBn6L0Zeju7poJfDsOPX3x1OK7yvaR3TN0x+4/1ZeP79W
         3pDnaUG5DuZ/3Gv/JWp2Etiz1x/DAy1DiKLKiEz7HbEaWaN3e4zwIeJEJf7w6YtBr8/L
         muWBsX2VPnFXq37WD6m/N588xmpTU/NKmc6OcGo/VjMKgHw5yBJe0bEHQs9mvn6yRW5T
         mTRgoPc6XLOEDWm3bcVF7svptSXprO9UWhI9fFmmn2mnNXbMCztZZU3nrshsQkQNOb8X
         +FVFOGCzQipPqMxkVUVxLzOG7gaaPSsYrP8S5FM9V7Jofpu68EWcMtcdRyB0TvpKrNRl
         R9xw==
X-Gm-Message-State: AOAM533TIjIiuKX1cTNP9v8pYVmvx1okjfPPK89fF5O6ev7+VvEodZPT
        eB73PoPHOSsdYVT7u2hTc/5UHIrCi++sRmH3u8g=
X-Google-Smtp-Source: ABdhPJxVhyTVQS0u2ldel7eJzbmUrX0dQGXfeYicwUOQ+Sp9dBCV/E7C9U6T6Fn0RrsKyZYi7BdocjnnTLWe8rz1hAg=
X-Received: by 2002:aca:d644:: with SMTP id n65mr16264548oig.31.1628037878388;
 Tue, 03 Aug 2021 17:44:38 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
 <7eecf879d608d8be17d4aa0ae087fb610156019c.1628004920.git.gitgitgadget@gmail.com>
 <xmqqeebarr36.fsf@gitster.g>
In-Reply-To: <xmqqeebarr36.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 3 Aug 2021 18:44:27 -0600
Message-ID: <CABPp-BGKbV7WPKmMdzetXgzaqzzaGGQ6SRuKHENkQh98-huotw@mail.gmail.com>
Subject: Re: [PATCH 07/10] merge-strategies.txt: explain why no-renames might
 be useful
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 3, 2021 at 6:28 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  Documentation/merge-strategies.txt | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
> > index eb43befac7b..d21dbd1e051 100644
> > --- a/Documentation/merge-strategies.txt
> > +++ b/Documentation/merge-strategies.txt
> > @@ -75,9 +75,10 @@ no-renormalize;;
> >       `merge.renormalize` configuration variable.
> >
> >  no-renames;;
> > -     Turn off rename detection. This overrides the `merge.renames`
> > -     configuration variable.
> > -     See also linkgit:git-diff[1] `--no-renames`.
> > +     Turn off rename detection, which can be computationally
> > +     expensive.  This overrides the `merge.renames`
> > +     configuration variable.  See also linkgit:git-diff[1]
> > +     `--no-renames`.
>
> Other reasons are that we may find a pair that the user did not
> intend to when they made the change (i.e. it was done purely a
> creation and a deletion but we found similarity), or we may find a
> wrong original to consolidate changes from a side branch into, and
> these are fundamental as it is our early design choice not to
> record renames at the time of committing.

Good points.  Trying to describe all of that makes it somewhat
lengthy; does it make sense to include all of that, or should I just
drop this patch?

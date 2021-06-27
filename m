Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A995C49EA5
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 00:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6047D61C29
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 00:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhF0AUh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Jun 2021 20:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhF0AUh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jun 2021 20:20:37 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8909C061574
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 17:18:12 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id x20so11822973ljc.5
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 17:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lp/9fqfYCZeFWrPpmR70IdRqy4wAvXPdwzYVYRuVfZw=;
        b=fov7IFfbk/98UQJB4X8TkgPDL4Kt7FtyO1J9zz40MuAx3+VSrzLKFdHFk+exwKTyN1
         +R9xMlkgDgUm2dis5kbyLLFxk3dGnVJX/nIbA6keyu+TA3CNOYs2FfA7Rdve8C+d25kV
         O4UoouXX+ctNB71zSZ1MoQ1Cz0aV2arMTpnPlx6FrTe3Rh14B8vJHCkCR8mm/+Ezt4hc
         AfYM+/wBiZi8D9Ut2nVI7KB2DZ0T8DI2AKSZApR6i/Wx8E4UFwXvamXyPI0yGubM5RRA
         M4xbo3TpwdH37UX1kbw8BxQnqpmAaoNY+bGggRyVXKLGadSO+FWOcOXg6BYe72Vtq6Gf
         mAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lp/9fqfYCZeFWrPpmR70IdRqy4wAvXPdwzYVYRuVfZw=;
        b=HL8ItIlsCl4gS4bXPLOwQVIWz+Rmsf1bq4LulPqWAzSOgFkO7S24LHamyaaeN0u8eb
         uedySvOhv0pXES1Se6U2Y+Y7YbOOQeeIe8vAcnhmlwdTlKCn4e2Xb32/KLx++aEOF56g
         JYQqtfOUInZekT5nLhH8ztL65Yhaleo+30tE0aAMFh9/gK5+sF7+34dEqVYtfFn9nNCF
         n4JdU9oUFEuo2NyjkyoqSVTPF3feaQ0/N1ndw/rlhJFNYBwC24c6tON3GjTJS6SdYwUw
         VnPmNE94/SBPmaK3q4iBd+oduXiRKaeTKLLzOrlQ1xJD7/ur8qaYlzxTbT0wSkbsx9yB
         YW/g==
X-Gm-Message-State: AOAM532tjs3AGekDc7lBMn9u93HyrzJpYw69mKbX/r0v99xAgGM+MvjK
        68wIafQ+Py4uijcb0drDn90epHG4LYTBR5npkNM=
X-Google-Smtp-Source: ABdhPJxwEqBriw+7nIdrCI/0uQ+uU1KbrI1pa2+LSRMZtFeQ5A5J7Ticu2jTSHRfXFRp+oU+exdY1Xda1UdH66UZF1I=
X-Received: by 2002:a2e:91c7:: with SMTP id u7mr9230603ljg.74.1624753091094;
 Sat, 26 Jun 2021 17:18:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210621175234.1079004-1-felipe.contreras@gmail.com>
 <20210621175234.1079004-3-felipe.contreras@gmail.com> <CAMMLpeR2Y_EGwqGJzghSQ1DzpYQyWr6ENmGCvPRdhhYFkTW4yw@mail.gmail.com>
 <60d0df99d91e1_108e902085e@natae.notmuch> <CAMMLpeRnUC+nOek=Kz6bj0_R6EUaDr=7ObKF01V641_ByOmk6A@mail.gmail.com>
 <60d10ebd99d86_113139208cd@natae.notmuch> <CAMMLpeRa3atkZxEtV--YD6-JSf0Bp9xRw9kS5wSWerxpsGrvrw@mail.gmail.com>
 <CABPp-BF1noWhiJadHzjJmnGo8hdZj6Fk7XnZ=u6BVVSGfHE7og@mail.gmail.com>
 <60d289c84fadf_312208dc@natae.notmuch> <CABPp-BHSxNT0rG3LMrDVH64mBwTgeF197oZFnbHvvKk=SB--WA@mail.gmail.com>
 <60d37b3b77aeb_378720834@natae.notmuch> <CAMMLpeTQjw0W8ZTegPru_9muRBGj7RDfk3WgEEN34vm-PG9Jfg@mail.gmail.com>
 <60d41e6464a6c_3d32208a7@natae.notmuch>
In-Reply-To: <60d41e6464a6c_3d32208a7@natae.notmuch>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Sat, 26 Jun 2021 18:17:59 -0600
Message-ID: <CAMMLpeSa=Shw3Y5=D9VZhRFJb922ZJD5L=X=eqGZFRkrDJG7dw@mail.gmail.com>
Subject: Re: [PATCH 2/2] pull: improve default warning
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 23, 2021 at 11:55 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Alex Henrie wrote:
> > On Wed, Jun 23, 2021 at 12:19 PM Felipe Contreras
> > <felipe.contreras@gmail.com> wrote:
> > >
> > > Similarly, until "git pull" does something sensible by default (which
> > > isn't the case now), these debates will continue, and there's value in
> > > them.
> >
> > At this point, I'm inclined to push for s/advise/die/ in pull.c in the
> > next release, without a transitional period, just to end the argument
> > over how to best explain the current awkward situation. (I'm sure
> > there will be more arguments after that, but hopefully they won't be
> > as tiresome.)
>
> Give it a try. You will inevitably stumble upon all the problems I
> already fixed.

Patch sent.

> In the meantime what's the problem with v2?

I think that setting pull.rebase on a per-repository basis (instead of
globally or per-invocation) makes for the easiest workflow in the
majority of cases, so I would prefer to continue to recommend that to
users primarily, but I don't have a strong opinion.

-Alex

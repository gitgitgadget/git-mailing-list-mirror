Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09937C4363A
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 11:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 936FC206C1
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 11:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYm5YMLM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgJ3LVG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 07:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgJ3LVF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 07:21:05 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53573C0613CF
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 04:11:34 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id v19so1497320lji.5
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 04:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6xBkE+KS/ATfSSqXYrML/3RDRnGCYDMOwpvD0f45T7M=;
        b=CYm5YMLMN/esEGVHxg6z4OvfCtzEyVayda4P3e1XiJh2tW07uMUNRUV6jZIlGJ0uoL
         +d6mzJ3SpMWW4jwzS15OWiMWKEgxku+fUMyPug1JJbZ4C+W/U+nHQEUqTjC36sLW5Mhs
         9sgmUl7O7/xbcC1P+zVNdnT5z1Ake/+x+GqFKYweDZW09FGd11oFVVqA+CdqsYSugeX2
         zZZrQEXGAy485tg88xiJF9r5KQZXN5gp0auKESM9IeuuhfmvJ8Y+CujBtBKCnIu+rzmB
         BNftplj8QC562iEZ/spdLpVGUcHQAoW6SoAZPk52EYOq5bDXIsXxvo/usgeMiR1du7rt
         uouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6xBkE+KS/ATfSSqXYrML/3RDRnGCYDMOwpvD0f45T7M=;
        b=GxxAzhYQQvEHyDGSibGUdsrkqYwgp7G1SBzGZrIT84zmloS1Gr2CbrPRMmD0eQ5w8m
         PfytpSjntBIMHnxOpmA/KHcn0KN9RzRnZqUbw/esWreF0oe9xSIT3xdlKERWZnV3JnbI
         IQV6gx3r4yVrLNH4z7CHQh/2lnR0fx64fPV21JTuaDsovgkw/GheSeCGFxAdAYkcJLw3
         E2BhUwgjd5mr+iQALWK+pAgnKtoIB4fhZC90fuLov9zQfVFwUN+j09feANxIb58VJnRF
         Mmx/uqsM6yZVW3r8ha/oGQ/4C+sv71Gx1tWaJFMS2wLUInmzvY7ujmRJwppQ5DNcpbFx
         fP8A==
X-Gm-Message-State: AOAM531gFuPE6kuc62yWxCAILiMlJ+M1qHa0h6zHSMyp7IAksFyM2hdw
        TeMkpBGmyHqVoal1uuUzyxQEe0O5dQ+cJmqKmWJ0+yxuFek=
X-Google-Smtp-Source: ABdhPJximbT3LqffMyWX1TlgpC5yE8C80h23GbhMB4/72Ot+BAmrpJhL3+qmxyixAhg7gP2Au0W6E6KDsGx/bbUanrE=
X-Received: by 2002:a2e:50a:: with SMTP id 10mr733166ljf.55.1604056292185;
 Fri, 30 Oct 2020 04:11:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=KpNaPFjMOzXzF382cv1p58nMoOPXAm0MCdA8WZMBznVA@mail.gmail.com>
 <20201030105856.ctjkxxwmudaeewpa@yadavpratyush.com>
In-Reply-To: <20201030105856.ctjkxxwmudaeewpa@yadavpratyush.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Fri, 30 Oct 2020 12:11:21 +0100
Message-ID: <CAGr--=KTbc7zBaYavFPafXjEGT5PJC6UXw7cmW-fSgXpQagKFw@mail.gmail.com>
Subject: Re: git-gui: How to configure for use in gigantic projects?
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ah, that one changed everything! Thank you Pratyush!

On Fri, Oct 30, 2020 at 11:59 AM Pratyush Yadav <me@yadavpratyush.com> wrote:
>
> Hi Birger,
>
> On 30/10/20 11:16AM, Birger Skogeng Pedersen wrote:
> > Hi,
> >
> > I would like to use git gui for a project. The problem is that the
> > repository directory is really gigantic. Doing a scan (F5) takes a
> > couple of minutes to finish.
> >
> > I would like the scan to only focus on files that are specifically
> > added to the index. In git I do this:
> >
> > git config status.showUntrackedFiles no
> >
> > git status will then only show status of files that I have
> > specifically added. So git status completion is instant.
> >
> > But this configuration appears to have no effect on git-gui. The scan
> > is just as slow as before.
> >
> > Anything I can do to make git-gui only scan files that are
> > specifically added, and not look through the whole directory?
>
> Uncheck "Show untracked files" in options. It is controlled by the
> config 'gui.displayuntracked'.
>
> --
> Regards,
> Pratyush Yadav

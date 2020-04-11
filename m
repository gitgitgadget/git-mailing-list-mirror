Return-Path: <SRS0=KYeX=53=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DBEC2BA2B
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 12:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBB420732
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 12:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfZQn63+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgDKMnF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:43:05 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:36893 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgDKMnE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Apr 2020 08:43:04 -0400
Received: by mail-vs1-f66.google.com with SMTP id o3so2854305vsd.4
        for <git@vger.kernel.org>; Sat, 11 Apr 2020 05:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+iwKsub7uQi6J4RN+W8z8SR2/YV8MWkfhwQW8hRSzuo=;
        b=MfZQn63+kBt+PEhbX0av7LNlIZ/upZJ3/bdhIlxQAcGJZsuEhoUI5iITUwcn2Sq+WG
         uD2bFo0oyZ9WnTg4YRnjn0+bopDDI6awQNh/xJgfNvPGVqQam4cIua/hYRCrajzUYJUW
         84MW4634EZ9AjYKcfdtiRqGW1JOzKovB3XOaYrwGWHDETPka5h93rlUS2tuWTbwdjNwZ
         iqKJhqVN8Mw2OykAn1pv9EqDNe8kXfRJNKzO5dG1TKoNtYHOLQnAwQLaoHxE1qxNuu7j
         WUSIu6pe9HvyoZ/ZHt+qlXaG4mYTOYOahjDiLJt9gsOd59hAktzf9el2ElZFaU6Vr9Jt
         ssnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+iwKsub7uQi6J4RN+W8z8SR2/YV8MWkfhwQW8hRSzuo=;
        b=Tpfi7GhCammVmlGyrbF6aFWHQcDxklik6k4S4BbfA4EBoA6cBdAQXAkU7LfModoidJ
         Jr04P/6y4gdTkHJjPuREoTGRym0UPbstBTT3wrfHIuzZDpZ15CHgup9wUoKu6VMxQLS2
         RcdPJQr9QqUAPL9DJxtafEjDoFG/qjD5dbGeym0M5QJQKO4eyvJMSyi46DuLOBKmsJBh
         B99g2oGUI3Hvtr5b/BgptwaALOCLD9FXD23MaDELoI2n6F7rf0U7KGYwbSY0lOF1R94C
         1u3yt/SNdFuvrZ3j8IL2oWiwpPO1REpnxTl7wb8F0IovngJLZ+OCcR0RpfL8j0PHFY8I
         WFKg==
X-Gm-Message-State: AGi0PuZL/ANqrTZ8mm8ts5d5VmFmmXb2W1SX50tcRMjFaKUDQF/CoWyl
        rTwBxAci7N6PwFZHYknqFhU6/9AbZa+zQKzl2Hc=
X-Google-Smtp-Source: APiQypJeHuSPLi8NDKhxNl6EqDDgRrL0ocEBCBThcJD8+Z8ek0aSlyryGEYvA54DULu6d/f4FSUwC9XW64vNAIYbK74=
X-Received: by 2002:a05:6102:116d:: with SMTP id k13mr6359104vsg.79.1586608984541;
 Sat, 11 Apr 2020 05:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <FC3905FB-D3B9-433D-876D-8DB68D3491C3@anirban.org>
 <CAN0heSrFFABmtitJHu1tVw03oRCs63=UiSknmoZr60NT9dR9Fg@mail.gmail.com> <b26f041f-82d5-450f-998d-5a5c557a7994@Spark>
In-Reply-To: <b26f041f-82d5-450f-998d-5a5c557a7994@Spark>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 11 Apr 2020 14:42:52 +0200
Message-ID: <CAN0heSodSeT=Sj4pnutFPgbu9jjwQ_JBtBee1iyP=D3Oc_5G=g@mail.gmail.com>
Subject: Re: Cherry pick a commit but with files in another location
To:     Ani Sinha <ani@anirban.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 11 Apr 2020 at 14:24, Ani Sinha <ani@anirban.org> wrote:
> On Apr 11, 2020, 17:51 +0530, Martin =C3=85gren <martin.agren@gmail.com>,=
 wrote:
>
> > On Sat, 11 Apr 2020 at 13:33, Ani Sinha <ani@anirban.org> wrote:
>
> > > I have an use case where I need to cherry pick a change from one bran=
ch
> > > to another. The change will apply cleanly but the files in the branch
> > > where I want to cherry pick the co mit to have been moved under a
> > > different directory. So simple cherry pick will result in conflicts. =
Is
> > > there a clean way to cherry pick in this case? Is there an option to
> > > provide -p0, -p1 etc to the patch?
>
>
> > I just tried the following commands. Admittedly, this example is a bit
> > silly, but at least for me, Git does handle the move just fine. Does
> > this work for you?
> >
> > mkdir test
> > cd test
> > git init
> > mkdir olddir
...
> > git mv olddir newdir
...

> > What kind of conflicts do you get in your real-world use case?

> My usecase is slightly different. The files I want to patch has been
> moved under a new subdirectory which is under the original root
> directory. So in order to patch, I need to add a new prefix to the patch
> manually.

I'm not able to fully guess your situation from this, but I wonder about
one thing: Do you use "git cherry-pick", "git am" or "git apply"? (Or
something else entirely?) Are you aware of "-p<n>" for "git apply"
(and "--directory=3D<root>"?) and are wondering what similar options are
available with "git cherry-pick"?

I still don't fully understand what you're doing and what you're seeing,
so it's hard to get a good picture of the problem.

I'm about to leave, so if I stay silent for several hours, that's why. :)

Martin

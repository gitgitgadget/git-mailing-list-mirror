Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF2AC433E0
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 14:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF62E2076C
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 14:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvuGX+p5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgHLOur (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 10:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgHLOup (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 10:50:45 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EF5C061383
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 07:50:44 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id j7so2024108oij.9
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 07:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wljctqfBWk1CEbc9CtCwDiin4WUkX+f/hF7l/EorTao=;
        b=jvuGX+p5OAjiJH4tq4NnTJ2kpI52eenOQrI1/c58RNGFcjp/SacENxmeQT2zgZYiYm
         XScIb2uMmSyCjciC/WpkaFhPZ6wSeLlti4TZGhMAiRSrCT/jRPWLKrh/Oz1IMU0eVYCo
         FXWQmrFeK49/KZmCY17fTISXkzS+6LK/7emOwSMcmlFkJv4Q6adYoL5920/aa6XBt2/o
         +ek3Yv4IxnS+jpFwdEtDDrkERHTwFb7ASkYW2E5NwjWpSkNzplDiPEklQvcY5Ig2jMQO
         FUbJvvbKRu3MHkI0spBwlpX5snTy8VOlKY5qguEByuEPq16NrzCN2NPyR2kV+EEO05SV
         TNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wljctqfBWk1CEbc9CtCwDiin4WUkX+f/hF7l/EorTao=;
        b=qyCNSvpR/HBJiIwiAhiBfUV3C6hT6q9Ls6g97qRlmJXNp2xHr1/q+FDj8OLuVLgPnV
         v6mc/vlPTEAjI5ZNVjwHussHBiU/Vbzda/niFG8FM4jeq5tpvfHOPv8QdFBfqpC3tjaM
         UbwrqaqhStyG5Z+70vpJOkV2/M+f+cQDHr23nh8A2j2qc7SjbtVlZMSMf95Vr0cLKfQe
         up/csdcAbZHzE8CzXiRRvZZZ8qM1SOOwoBogD0igbwxGlJp4UH8APDAxFwNU75gHb9yY
         oaDYqD+XtyIJyXTBgzUSLFrVkL0InVh7h/J4IkGH7jr4x9Gs9yggkP8AdDMsRrqLE7+u
         R6GQ==
X-Gm-Message-State: AOAM532i7HZMcOt6+ck1eShlmhmajll28GKlMWaV8l1fxAi90VS9d2Ay
        JGTEYNjPEHmtABgNiT7DFYrdaI1JSiRgtvWru1Q=
X-Google-Smtp-Source: ABdhPJy7c5IOT6yD09qO6e8684w7cP0f8AaVWmstRsOs8H1oa48Ip+m2FZWYa/rLGsrtJnLXPAQgfK5+ZZtyoCnEv4I=
X-Received: by 2002:aca:b705:: with SMTP id h5mr7389895oif.31.1597243843306;
 Wed, 12 Aug 2020 07:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <CADjceoQxoL932W4mkfhG6VOgrQBhs9k6tXkWSkraKVPmUP+uCw@mail.gmail.com>
 <878ses4pay.fsf@kyleam.com> <CADjceoRtFmM2H1z48HcmvWBF1KmMrwMnE6YdC9HJGFjdXXivJw@mail.gmail.com>
 <8736504k06.fsf@kyleam.com> <CABPp-BEmrcY8wr_rb+Y4gacNEeeEPTUxWw2Mq0A9LMzpx2bQnA@mail.gmail.com>
In-Reply-To: <CABPp-BEmrcY8wr_rb+Y4gacNEeeEPTUxWw2Mq0A9LMzpx2bQnA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 12 Aug 2020 07:50:31 -0700
Message-ID: <CABPp-BFWfwkYAPyySjWOMZ02_+YLf=TJ_aVMaHaizJWAsCL67g@mail.gmail.com>
Subject: Re: ls-files bug report
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     christian w <usebees@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 6, 2020 at 9:10 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Wed, Aug 5, 2020 at 6:54 PM Kyle Meyer <kyle@kyleam.com> wrote:
> >
> > christian w writes:
> >
> > > Sorry for the insufficient reproduction steps.
> > >
> > > I managed to figure out it has something to do with git repos within
> > > git repos. It happened to us because of go packages that are inside
> > > our repo. These are the reproduction steps that work for me
> > > consistently using Go version go1.14.4 darwin/amd64. This is the repo
> > > that gets cloned into src/golang.org/x/debug by the go get command:
> > > https://github.com/golang/debug/tree/66ec140f2f72d15dc6133502edd2bb7238b1740c
> > >
> > > $ mkdir testdir
> > > $ cd testdir
> > > $ git init .
> > > $ GOPATH=$(pwd) go get -u golang.org/x/debug/ || true
> > > $ git ls-files --others '*.txt'#
> > > src/golang.org/x/debug/
> >
> > Okay, removing Go from the equation:
> >
> >      $ # in fresh repo
> >      $ mkdir a
> >      $ git init a/d0
> >      $ touch a/f0.txt
> >      $ git ls-files --others 'a/*.txt'
> >      a/d0/
> >      a/f0.txt
> >
> > It looks like the spurious a/d0/ entry doesn't show up until v2.27.0, in
> > particular 95c11ecc73 (Fix error-prone fill_directory() API; make it
> > only return matches, 2020-04-01).  Adding the author to the Cc.  (Sorry,
> > Elijah, I recall your frustration with dir.c from a previous ls-files
> > issue that I reported [1]).
>
> Thanks for digging in and coming up with a smaller list of steps to
> reproduce.  You are right that I dread reports that touch dir.c -- if
> I would have just ignored the first report back in March of 2018,
> there's a really, really long list of problems I could have avoided...
>
> I'll try to take a look in the next week.

Should be solved by this fix:
https://lore.kernel.org/git/11a286b071ca8a6b96f4fba6658e9bafb9314be4.1597216356.git.gitgitgadget@gmail.com/

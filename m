Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FB3720248
	for <e@80x24.org>; Tue, 12 Mar 2019 19:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfCLTjS (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 15:39:18 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41329 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfCLTjR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 15:39:17 -0400
Received: by mail-vs1-f66.google.com with SMTP id m20so2340287vsq.8
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 12:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mte6CJEkcAVVyzxur5Iuy+oTfWMDZaibnH+wCEjXHUM=;
        b=Dt+Mv66mpH2HwU1LDh0MFeCdZ3Toner0fF4bc92870g44tiuHo+ywiLtXhrwGJLwkt
         0WHqpC5ul+/W8GJgJp1noREFTf9l213h9PcHtT0Veu3rbV6L1FxVCnFe/0nTqWJS1eMa
         wFcG8TM0fwbuUK0stvSuEUYrif9eokH98VAbwUAnt8yyMyBMp3WaKjqBxaUvRC+Ebheo
         uVmy5PLq3O8FpQIfAKsg7orYEkF+KV+w4h32VqqLyw/SGx6bg59M/IUcG/eHkLWOujUo
         jWnrUnSgqGaWM9xCb6CHgZQQ7o2LnuYZJDqeToDEC/ejMW4XknAww1EYjDQSlbqXyAgh
         yNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mte6CJEkcAVVyzxur5Iuy+oTfWMDZaibnH+wCEjXHUM=;
        b=VwELYl5Yapnq2Rp4bj77TKRIUMXiMaBSUVNMFz29ktOEbPBL3J6+RuQhySTH6pAfez
         IQwFH7HwYCVz7shZFRsw0nlUlG+GQCmOt4S6QjxEf4Y9BRlIW3ejkV0VqJj+ghF5eJVJ
         2/Y1gGW7mpBRBKxjOv4kMgqyTWq5a67wvmccRkfpQZjfG6v1CO87E9PbV7SH4zVLQDab
         pjGqt1DVdPaiTr4yhbUuTKAwSnxl6VdZtMeUYM/EebcxL7QdB1BbInw7yO4GEx/d/5yy
         T4Hzzf59iyyDlSIqjRDARrPXQS71eAoycBMSC78SRdP3ji8gfjVYWJO4FGbZLbiGGL0+
         +QEw==
X-Gm-Message-State: APjAAAVVZf3F4KUSYQt/4J34sFZ5DDkxsNSfUxtVokmPysqoMKY+gRBe
        NkSdHFvEW88ymT7J0r0301oyF32aS+RcQIIXzAg=
X-Google-Smtp-Source: APXvYqysfn2wTNNGYU6O9V0kHoBb7ZQ/ZoLkO8ifrgwlro2tmuEOgnz6YLuKsZHdQ2r4u2APQFbQ4Va9eyFO0qAc9cs=
X-Received: by 2002:a67:f8cc:: with SMTP id c12mr20748344vsp.136.1552419556238;
 Tue, 12 Mar 2019 12:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <87k1h55bx0.fsf@sergiodj.net> <CACsJy8ANLkz=3cj1dAuHdUCkrgQzos=90EEG0n901o3QAp3PUQ@mail.gmail.com>
 <877ed459eh.fsf@sergiodj.net> <CABPp-BFnxhiXfvZUZndD-_htMEw0bZzrLRFpAF9u5YV3wi6qnA@mail.gmail.com>
 <8736nr6g94.fsf@sergiodj.net>
In-Reply-To: <8736nr6g94.fsf@sergiodj.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 12 Mar 2019 12:39:04 -0700
Message-ID: <CABPp-BH2k2yz-MrEvN2dX1jLVJydxOBv-bu-H5M_SXO_aLK8hw@mail.gmail.com>
Subject: Re: Possible race condition with git-rebase + .git/index.lock
To:     Sergio Durigan Junior <sergiodj@sergiodj.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 12, 2019 at 12:32 PM Sergio Durigan Junior
<sergiodj@sergiodj.net> wrote:
>
> On Tuesday, March 12 2019, Elijah Newren wrote:
>
> > On Tue, Mar 12, 2019 at 9:48 AM Sergio Durigan Junior
> > <sergiodj@sergiodj.net> wrote:
> >> On Tuesday, March 12 2019, Duy Nguyen wrote:
> >>
> >> > On Tue, Mar 12, 2019 at 5:18 AM Sergio Durigan Junior
> >> > <sergiodj@sergiodj.net> wrote:
> >> >> This works without problems most of the time (well, usually there are
> >> >> conflicts and all, but that's a burden I have to carry).  However,
> >> >> sometimes I notice that git fails with:
> >> >>
> >> >>   # git rebase origin/master
> >> >>   ...
> >> >>   Applying: commitX
> >> >>   Applying: commitY
> >> >>   Applying: commitZ
> >> >>   fatal: Unable to create '/home/xyz/dir1/dir2/.git/index.lock': File exists.
> >> >>
> >> >> The first thing I did was to check whether the index.lock file existed,
> >> >> but it doesn't.
> >> >
> >> > Is the output this clean? What I'm looking for is signs of automatic
> >> > garbage collection kicking in the middle of the rebase. Something like
> >> > "Auto packing the repository blah blah for optimum performance".
> >>
> >> Yeah, this is the exact output.  I also thought about "git gc", but I
> >> don't see any output related to it.  Is it possible that it's being
> >> executed in the background and not printing anything?
> >
> > Any chance you have a cronjob or other task execution mechanism that
> > is running git commands in various directories (even simple commands
> > like 'git status' since it's not read-only contrary to what some
> > expect, or 'git fetch' which might trigger a background gc)?
>
> Nope, nothing like this.  AFAIK, nothing is touching that repository at
> the same time that I am.  Besides, even if I wait some minutes before
> trying again, the bug manifests again.

Well, even though you didn't see the output Duy was looking for, if
you set gc.auto to 0 and gc.autoPackLimit to 0 (and maybe
gc.autoDetach to false just for good measure), does the problem still
occur?

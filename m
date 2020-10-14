Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CFCC433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 01:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B40C622254
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 01:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGxqcRae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388852AbgJOBag (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 21:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732254AbgJOB3i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 21:29:38 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E247C05111B
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 15:59:53 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id h19so518939qtq.4
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 15:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+Hijq7FXlhFjDYo3wQRsSNBid3sK9eucOig1CIIorLs=;
        b=LGxqcRae0sQgYqHVqlvAu6xeYpQtPOYS5flQ0CI5z/ljjAGRS8l0Whu96C0sn71ogg
         fcLnlQwdC1kBYxZYLa19f9MN9PahQMIUTt3fH9kGjzTmOgWpCrHoz8ag5LP663GvmM6q
         GnZDvK6FLEKmQcPlEWLsWcwiJIO7KT0wKYwpuw+KlzF/KxLkgiCu3IirTPQxxJiEaqNi
         fT+us9sH9dQNgvooANqb8zRr5xkts4f4JM2MDk/Q9bpLPNj6/V7xWQSCmA3aqwMa+oJ8
         1I5/Zk2gTUHCQZbqAXnyN8Ov5bNjM2o/TgGI+T2A+ZmWgV6GroxCB/9+wy9tqKS0ekbo
         1w/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+Hijq7FXlhFjDYo3wQRsSNBid3sK9eucOig1CIIorLs=;
        b=FU4pS4gftWc8DZRNnH+zVPh0Oz52Z1+TplSKvhPMohAhYO5fXXAapirpWbsle3fNrv
         RFKuxPwaptJD4fECul/yy5axCJyoaCAAj2l66y8bSsL32c3XRUmzK6+HidltQVXhC+/B
         oXSLzz8X88Codnc+rv5bGa6jIgMVwMn6IxkrVOycUR/v59G0n78zlz4NQvkuaSt6nPCN
         q4+rMYH3TYOH4griAuqZ6OjcF3Ax10+vL/pa6oGNG40EPvIy+FZ8q1i/OuxaKedWNfUr
         5JgqYP1gn8B3XbI57jnhCyDslluwYhIHA+whEoR3YqyX2A4yOrY1JaeLG5BR9ZW+vu08
         TdBA==
X-Gm-Message-State: AOAM533bBke28GJUul3vNcmqejQ+eoNbHpq/1Y/ir2+wdHM3Vni2uJdN
        QipgARkpy5zQJzTkAwGMFKUSKB+15WNBTRG+JLogHIYlXWA=
X-Google-Smtp-Source: ABdhPJyr4GWn7gHmXPllVaMNopOJqLnkHUdBdOdQiS74ImTEmVywQDTq7zPO53o6NFVc3GhzUaFPymPkipH0HZ/odlY=
X-Received: by 2002:ac8:5acb:: with SMTP id d11mr1468920qtd.161.1602716392615;
 Wed, 14 Oct 2020 15:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <CA+3n-TrVncSq6kY8sTTw=LiOvLKe=6k1yBE8cmmR3i40CaXR6w@mail.gmail.com>
 <E3D98950-2EA1-4BFE-8A2D-CE8AEAF5AD39@gmail.com> <CA+3n-Tpb4BGM5W3e5vHwqkU-Tnh2gs0_K1ciEcJ25SnYe5PTOw@mail.gmail.com>
 <D853766B-B4D8-46B3-A3BA-68519DCFC7C5@gmail.com>
In-Reply-To: <D853766B-B4D8-46B3-A3BA-68519DCFC7C5@gmail.com>
From:   Marc Sune <marcdevel@gmail.com>
Date:   Thu, 15 Oct 2020 00:59:41 +0200
Message-ID: <CA+3n-TrSdMAZmdew3kAQQA6CPRQi+7-LksGBNkNxFsnXsrhqjg@mail.gmail.com>
Subject: Re: git diff --submodule=diff and --stat/--dirstat/--name-only
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe,

Missatge de Philippe Blain <levraiphilippeblain@gmail.com> del dia
dj., 15 d=E2=80=99oct. 2020 a les 0:51:
>
> Hi Marc,
>
> > Le 14 oct. 2020 =C3=A0 10:35, Marc Sune <marcdevel@gmail.com> a =C3=A9c=
rit :
> >
> > Philippe,
> >
> > Missatge de Philippe Blain <levraiphilippeblain@gmail.com> del dia
> > dc., 14 d=E2=80=99oct. 2020 a les 15:29:
> >>
> >> Hi Marc,
> >>
> >>> Le 14 oct. 2020 =C3=A0 06:14, Marc Sune <marcdevel@gmail.com> a =C3=
=A9crit :
> >>>
> >>> Hello all,
> >>>
> >>> First, thank you to the community for the great work. Worth saying it
> >>> from time to time, I think.
> >>>
> >>> I am dealing with a couple of big repositories that use git
> >>> submodules. They have nested submodules, and some of them are pretty
> >>> huge. I came across:
> >>>
> >>> git diff --submodule=3Ddiff
> >>>
> >>> Which is very handy for creating some tooling, but it's obviously slo=
w
> >>> - in the order of tens of minutes in my case - for big diffs. I was
> >>> only interested in the list files that changed, in this particular
> >>> case, but:
> >>>
> >>> git diff --stat --submodule=3Ddiff
> >>>
> >>> doesn't seem to honour `--submodule=3Ddiff` and it doesn't go into th=
e
> >>> submodule(s) nor recurses, of course. Other options like `--dirstat`
> >>> or `--name-only` seem to behave the same way.
> >>>
> >>> I've tried this v2.20.1 and the HEAD of master (d4a392452e) with the
> >>> same results. Is this a missing feature, a bug or is it just the
> >>> intended behaviour?
> >>>
> >>> Regards
> >>> marc
> >>
> >> This would indeed be useful. It's a missing feature, and so intended b=
ehaviour
> >> for the moment, I would say. It was discussed recently on the list [1]=
 :
> >>
> >>
> >> [1] https://lore.kernel.org/git/20200924063829.GA1851751@coredump.intr=
a.peff.net/t/#u
> >
> > Thank you for the pointer and the clarification.
> >
> > I am not sure extending `git diff` options (only) under
> > `--submodule=3D`, e.g. `--submodule=3Dstat` is the way to go. It seems
> > redundant to me.
> >
> > I am wondering if it would make sense to have basic options of git
> > commands, e.g. `git diff --stat`, be honoured for submodules too, and
> > just control whether git commands should get in the submodule(s) or
> > not, and perhaps the depth of the recursion (optionally).
>
> Did you try `git submodule foreach` ? If you are scripting, you could do:
>
>     git diff --stat && git submodule foreach [--recursive] git diff --sta=
t

Yes, ofc. There are multiple reasons for not using it in this specific
case I am facing (specially performance), but this is probably
offtopic.

>
> Although here the recursion is an all-or-nothing business.
>
> > For instance, I don't fully get the use-case(s) in which parts of the
> > output are --stat (supermodule) and submodules show something
> > different:
> >
> > git diff --stat --submodule=3Ddiff
> > git diff --stat --submodule=3Dlog
> >
> > Specially for log, this sounds to me like it should be under `git
> > log`, with the appropriate options.
>
> I think 'log' is useful; it's more descriptive then having just a hash,
> which is the default...
>
> > Perhaps you can shed some light on
> > the use-cases these combinations support.
> >
> > I would think something like:
> >
> > git diff --stat --submodule-follow
> > git diff --stat --submodule-follow-depth=3D4
> >
> > git diff --names-only --submodule-follow
> > git diff --dirstat --submodule-follow
> > and for other commands (some sort of header line should be printed to
> > note the history is under the submodule X):
> >
> > git log --submodule-follow
> > git log --submodule-follow-depth=3D4
> >
> > and of course allowing `--` modifier:
> >
> > git log --submodule-follow -- libs/library1
> >
> > would be easier to use.
>
> I'm not sure of the use case for these... The history
> of the submodule project can be seen with `git -C path/to/submodule log`
> (or just `cd` there and `git log`), and the history of the gitlink in the=
 superproject
> with `git log -- path/to/submodule`...
>
> It does not really make sense to interleave the history of the superproje=
ct and
> the submodule in the same output, in my opinion at least.
>
> > Let me know if any of this resonates, and if some patches along these
> > lines would be welcomed
>
> I can't really answer that, I'm just a small time contributor :)

I will wait for some thoughts on the proposal, and to see if someone
can shed some light on the reasons why `--submodule=3D` option works the
way it does, today, in git diff.

Regards
marc

>
> > (might ask some help offlist).
>
> You should ask on the list, on the mentoring list, or on IRC (see [1]).
>
> [1] https://git-scm.com/docs/MyFirstContribution#getting-help
>
> Cheers,
> Philippe.
>

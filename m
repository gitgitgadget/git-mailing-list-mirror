Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2AEC2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 03:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C561820857
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 03:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nl2tHFPi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgKXDlS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 22:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgKXDlS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 22:41:18 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C6FC0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 19:41:17 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id s13so1434221wmh.4
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 19:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SgRjcCQnuq3j4UT7cAMbC2YLr0/GWo5nmAyIO5q0KRA=;
        b=nl2tHFPi2MX5urIMScq4GShq61beN0krxma7rX3vhfFM+xNfvPkT0ohLgjLeROo1yH
         NbBLnS7wOnbH2YqHlyyg6N4HkrMOE68WtM0i0n2Ir9mmA/R83HocKoihExLff2ziqjJC
         2Pe+zBrEAV59RdNSDzGyAcBGl9F/FCQ/D4TH8rLAFR+37aIBrjvvEhYEtzQxh6u99vvh
         MXTXgijhafMs3CH4thW44zQu8aX5EM3uJbb5gR10sPJgrZh5Dk2wluuZFwOay2OG1j2z
         Ma53CpNJN1ebUHbAUGga5lzaJ1drmjG4F9zlvBEq/jWu7McsJFpCG5KjGtnn7rOivNOP
         f1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SgRjcCQnuq3j4UT7cAMbC2YLr0/GWo5nmAyIO5q0KRA=;
        b=cN/enm+khgZ7rb8/i7CKpwsMyfxVnBiVd/DDdyy0j39Ev+uOrYK0j+GGlWLVAT2CKp
         u6dGeiIeGsq7CR1zHe9xsrgHA/M9BcXGM1OSvbO2pFuMVfNt1y1SoEhL9PSlPSZXyE/t
         Pq9eWxlDj8hnqMBFuKMARoN87ZnmMiDbG3GXKtu3F6VZ/i7V0Db1gTQ1ZPyKAe+CSbGO
         ysO5oGv4jjGSQLun79xr6Ns40dIx/iW3tbGGzWDAcAC8Ub5Db2oDPf63CHH/UTIHqVBl
         gHFGji2zZIJLNgDxPIY49kUl1pHH+fPgt5pGLM2bw3EJcF9NxPLkcwDm1LMLcWXsI8co
         wBfQ==
X-Gm-Message-State: AOAM533sqXUhOByPbGn3elzIAbKbvZXdB2dm4sxBCQAxyJ3oNSiVXP0P
        e+h4+SmE0/vWxv4SQhksFhGKfBgs5bDfNlNrWN8=
X-Google-Smtp-Source: ABdhPJzCLaMAjraOj0wleRxDOUAIOyDFLb9NU4kIo9A+lcBUESEgD9kvfYWGh4yyYOEuvQ4tQQySI+sMxqUisNJPtnc=
X-Received: by 2002:a7b:c843:: with SMTP id c3mr2021464wml.100.1606189276374;
 Mon, 23 Nov 2020 19:41:16 -0800 (PST)
MIME-Version: 1.0
References: <20201123191355.GA132317@mit.edu> <CAMP44s3cKVxKa0gOPfi3XRKbGbV=DweFE5pL0HM+v0kECFyPWA@mail.gmail.com>
 <20201123202003.GB132317@mit.edu> <CAMP44s27oEjScrJjeDVoNcWcvRsn173L_Kx+TOPfchOwge9zUQ@mail.gmail.com>
 <X7wuMvHRURK1QS/Q@coredump.intra.peff.net> <CAMP44s0QOcMnYQqFFSE1jV_T6=e4=xTM0zr_06C6+aYb7oqb4A@mail.gmail.com>
 <X7xWSs3/vVqKl6sK@coredump.intra.peff.net> <CAMP44s1Z4tDXO4jstGMtYVOYzkQQnZMHp45pYPOimk+=jwFHcw@mail.gmail.com>
 <X7xgow4pchnhf2iY@coredump.intra.peff.net> <xmqqy2irjy4f.fsf@gitster.c.googlers.com>
 <X7xw0xb9UnGKbS8m@coredump.intra.peff.net>
In-Reply-To: <X7xw0xb9UnGKbS8m@coredump.intra.peff.net>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 23 Nov 2020 21:41:05 -0600
Message-ID: <CAMP44s08mEyYqbjOeTeS46CngrbQMqP2=cMr1dtRLLk_BLAq3w@mail.gmail.com>
Subject: Re: Pick the right default and stop warn on `git pull`
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Alex Henrie <alexhenrie24@gmail.com>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 8:32 PM Jeff King <peff@peff.net> wrote:
> On Mon, Nov 23, 2020 at 06:18:40PM -0800, Junio C Hamano wrote:

> > So an obvious thing we could do, if pull.mode is too much of a
> > change, is to make "pull --rebase" codepath honor pull.ff as well,
> > perhaps?  I.e. those who set pull.ff=only are saying that "please
> > stop me when I have any local change---I want to be notified if my
> > pull on this branch results in anything but a fast-forward from the
> > upstream".
> >
> > And then making an unconfigured pull.ff to default to pull.ff=only
> > may give a proper failure whether you merge or rebase.  I dunno.
>
> Yeah, I would be perfectly happy with that (and it's in fact what I
> _thought_ was happening before today's discussion).
>
> I do wonder if anybody has set:
>
>   pull.rebase=true
>   pull.ff=only
>
> which would then refuse to rebase at all, and whether they would be
> annoyed. I am scratching my head over why one would do that, though. It
> is meaningful only if you usually rebase, but when you say "--no-rebase"
> you want to make sure you do not create a merge commit. Which seems
> weird.

I think you are losing track of the goal.

The goal is that *eventually*:

1. No warning is issued
2. No configuration is needed
3. The default behavior is sane.

The whole point of "pull.rebase=ff-only" (aka. "pull.mode=ff-only")
was to make it the *default*.

If you make "pull.ff=only" the default, *and* you make "git pull
--rebase" respect that, then "git pull --rebase" will fail by default
(unless it's a fast-forward).

What we really need is something like:

1. git pull # fail by default unless it's a fast-forward
2. git pull --merge # force a merge (unless it's a fast-forward,
depending on pull.ff)
3. git pull --rebase # force a rebase (unless it's a fast-forward,
depending on pull.ff)

Therefore, what we really want is "git pull --rebase" *ignore*
"pull.ff=only" (a possible default) or ignore "pull.rebase=ff-only"
(also another possible default).

It would be possible to do something like:

  if (!opt_rebase && (!opt_ff || !strcmp(opt_ff, "--ff-only")))
    turn_default_behavior = 1;

But then how would we distinguish between "git pull", and "git pull
--no-rebase" (aka. "git pull --merge" / "pull.rebase=false")?


This is just too much unnecessary complication There's no need to
entertain a dozen possible heuristics to avoid "pull.mode", none of
which avoid breaking existing behavior.

Let's just accept we need push.mode, and then we can have everything:
default, ff-only, merge, rebase.

Cheers.

-- 
Felipe Contreras

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA377ECAAA1
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 18:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbiIISJT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 14:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiIISJS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 14:09:18 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EF2139C03
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 11:09:16 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id u9so5868262ejy.5
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 11:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Qhwx0Liejffaq0K7H47gH611GvlLUsZkOmALTr1+GKc=;
        b=Osl+IvXrUD1TdpkDVJqchMh1pVbayShW6cYL8HH7GTP8Dxyg7MXdSmAvRoXTxW32Ji
         H+NGehbVY9MOcoOdO5ko606Nt94yGElXenI2uM4lN93EOTqNi7NeA2GqauoI6kX9i5c9
         rvcPwoggrnooyFRfXliX1mPVmYhpYPnc83fDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Qhwx0Liejffaq0K7H47gH611GvlLUsZkOmALTr1+GKc=;
        b=KNY0nfcPGEDWfhfE04r0fJ0w2wXySbjVJpJyYFxomqMTYEcibZjbK3TRIfQO/x+LO5
         P3/kDgkzigxarCFhLsQAGkVti/HWEvY7QM+1s2ri/VTvjsntqfYsdAnzYfkd4MEq2nX8
         fXDugkMHSfldATys9cZWOr8MTjyhfCxB4AbK5dCv4JKHpXlPB7VM73axwaA8yJ3VAkhx
         S1fXclTXN/0Ohjoii5EU2yK5NibL80NIHsfBneXOh4fzw0rDWUfMipdNG2GLsLvztzyX
         Nr4oA2AGKEUj3n4dReRZjmcMr6AEFOJMsEEWPH0YOjNJjpTfXmQkGtpFjN2XnqG2pvVu
         Pw4w==
X-Gm-Message-State: ACgBeo18yfgOz3TH1Q1tFaYptr8g9YpTq1q7DMJpp9VwjTuDLAl6LNIP
        kRedvfP0IiBy5lKJpzCT8QUdTjAVo9Y+/JNzkAkZF68dyba49YfB
X-Google-Smtp-Source: AA6agR4qXacanid2jaxX/gQMW97XKBUtpHK+JOVGtYra6tnyZJmmbG4hQzs8aEaza/rfh1wNxYA434ScUyG7/9O15XU=
X-Received: by 2002:a17:907:60c7:b0:731:2be4:f72d with SMTP id
 hv7-20020a17090760c700b007312be4f72dmr10769808ejc.639.1662746954875; Fri, 09
 Sep 2022 11:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpogZd_em4_Fdk0sNFqAXqH19VOVyw3WsNT2LHsQNOb0_rw@mail.gmail.com>
 <xmqqpmg4lbnd.fsf@gitster.g>
In-Reply-To: <xmqqpmg4lbnd.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Fri, 9 Sep 2022 20:09:03 +0200
Message-ID: <CAPMMpoj9ww18j4gUKhXsLFUGrYsbuq6Aww4z9VDboA3h78eHsw@mail.gmail.com>
Subject: Re: git mergetool, merge.tool, merge.guitool and DISPLAY
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Denton Liu <liu.denton@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 9, 2022 at 7:07 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Tao Klerks <tao@klerks.biz> writes:
>
> > The upshot, as I understand it, is that the only way to get a GUI when
> > I'm connected with an X session, and get a terminal-based mergetool
> > when I'm not, without having to be aware and issue different commands,
> > is to accept whatever tooling default order is hardcoded in
> > "git-mergetool--lib.sh"
>
> 60aced3d (mergetool: fallback to tool when guitool unavailable,
> 2019-04-29) says something interesting:
>
>     The behavior for when difftool or mergetool are called without `--gui`
>     should be identical with or without this patch.
>
> So, either we broke that promise since then, or the above commit was
> already broken, or the tool was already broken before that?

Thanks for the quick feedback!

I don't think that promise was then, or is now, broken. The behavior
without `--gui` is to always use the merge.tool (and never the
merge.guitool). That is in fact my complaint - that I believe there
should be an auto-selection of merge.tool or merge.guitool, depending
on the DISPLAY variable, when neither `--gui` nor `--no-gui` have been
specified.

My proposed behavior would be different to the current and original
behavior, for users that have added a merge.guitool to their config in
the meantime. If DISPLAY-sensitivity had been added at the time
(before any users had a merge.guitool) it would have been a safe
change without change in behavior for existing users, but now that
some users do already have a merge.guitool, that is no longer the
case.

> In any
> case, I do not think of a good reason why configured .guitool is not
> automatically honored and .tool ignored when we know we are in an GUI
> environment.  In other words, the choice of the tool should probably
> go like:
>
>     are we in GUI? (determined by an explicit --gui, --no-gui, or env)
>     if so
>         pick one from configured .guitool (or from the fallback default
>         list of tools)
>     else
>         pick one from configured .tool (or from the fallback default
>         list of non-GUI tools)
>
> I would think.

Excellent, I agree. My concern then is whether this behavior should be
placed behind a new config switch, to avoid surprising users who might
have come to expect the current (in my opinion suboptimal) behavior,
or whether invoking the merge.guitool instead of the merge.tool, when
there is a merge.guitool of course and the DISPLAY is set, would be a
net improvement even for those users and should just be implemented.

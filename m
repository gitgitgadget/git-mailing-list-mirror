Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA3AC43334
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 23:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236368AbiFMXUp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 19:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237654AbiFMXUm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 19:20:42 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10992A42D
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 16:20:38 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id d39so7369879vsv.7
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 16:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ka7TacrnRLqEDE20NsVT6pM1pPa++41nXPPA34CBKh0=;
        b=M+Y0p/ryM0zfG5IPlOH67wC3kjv4Ucld2VSUHOIydFLGJHvjEnoNF03tQhEFqaTj0w
         jvlGqE6zln8yUO84eryySdPaatGcLSqzSv0Cn6xvZL6Ar6wEv83cGzgh5vr+5pKbTzJf
         NZtaouYMBgdVBGIWn5NOs1p15xAacHpM2gpRbZCaAiQkCIpbdotkljKuPOypT57t1/Ti
         U37wB1pkNrsYCO8EW5tRX47CfTaALJVotaJDGeRcVxNOqLGEGDBUiVoQbk6XbtWl9gEe
         7YRIOnphk2egbqnpJ8zKgSIqSxxv1Dz2deVZkvgmtu1/piY7tc3f6K6eAWUvRucbnNtq
         8Buw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ka7TacrnRLqEDE20NsVT6pM1pPa++41nXPPA34CBKh0=;
        b=QE8V16hbClTbxgCV++t3AopWPTj36TA8uvxoMubyLHrGUnLaPViCtIX3HzWPGhP9FV
         oxstBWga23uIALP2ASxKfEeqTNjQCnO4BvNOm9Hixsvf3zziM8cMlUDLu6TA8EqC7B+Q
         ggaa9O01eqnlDyuy3Szp5b01nQY3LMvoLmpPT9qqOalq0jcWmp6TVvueDD9aT9B0XbAO
         S4oCNKeLGbX24WzCidZuIoF/fDZ8aWCAgHraE1M73Yt+U4WumYelb6K38Bh1qJSOyDRX
         gadg0C7+wZnWkKuUeRC9oIV3gJFB+YfHzJ7pRjozhcAYNH4EExhL2iODibBExAlaNjQ+
         7fnQ==
X-Gm-Message-State: AJIora+OiMU/+QQ7OTGJizri9aovvJAXFm9naW+CpGiZWn6KEfXGdmiA
        aCGUgLBgC2E1RdLH6WccjL24qzcSSYeJuhQBriL6Dd3s
X-Google-Smtp-Source: AGRyM1u0IVoLkjGgUQjO5F/Tu01GTOBOklujRTcYBJ3fnjYMpkWeQBhtOnkHbDBiYT5v+GtPs+2Y50uaKPToD5pTgyo=
X-Received: by 2002:a67:ea85:0:b0:34b:912f:2c66 with SMTP id
 f5-20020a67ea85000000b0034b912f2c66mr975741vso.42.1655162437697; Mon, 13 Jun
 2022 16:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAChcVumTgNqRTt=EtThXiw9ga=W9WC-uS0XOkz7T+TbtGKeU+w@mail.gmail.com>
 <xmqq1qvwfntm.fsf@gitster.g>
In-Reply-To: <xmqq1qvwfntm.fsf@gitster.g>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 13 Jun 2022 16:20:28 -0700
Message-ID: <CA+P7+xrfkApv_r_YQqOt-LiaC=Ctb2px0UuaSwqU_ua_qmH4OA@mail.gmail.com>
Subject: Re: Should `git remote show` display excluded branches as to-be-fetched?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Pavel Rappo <pavel.rappo@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 10, 2022 at 10:08 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Pavel Rappo <pavel.rappo@gmail.com> writes:
>
> > Here's a console session:
> >
> >   % git config --get-all remote.jdk19.fetch
> >   +refs/heads/*:refs/remotes/jdk19/*
> >   ^refs/heads/pr/*
>
> Thanks
>
> "Negative refspecs" is relatively new feature introduced in c0192df6
> (refspec: add support for negative refspecs, 2020-09-30), so it
> would not be so surprising if it still had some surprising behaviour
> ;-)
>
> Jacob, care to take a look?
>

Ok, so this looks like its caused by the fact that get_fetch_map in
builtin/remote.c ignores all negative refspecs. I think what we really
want to do is check if a given ref matches any negative ref and then
maybe move it from the new listing into a separate skipped listing.

Figuring out the best way to do this is a little bit of a challenge.
It looks like maybe we need to use one of the functions in remote.c
just after the get_fetch_map call in get_ref_states. But exactly what
has so far eluded me after a bit of digging.

I'm still looking at this, but help would be appreciated if anyone
else has a suggestion.

Thanks,
Jake

> >   % git remote show jdk19
> >
> >   * remote jdk19
> >     Fetch URL: git@github.com:openjdk/jdk19.git
> >     Push  URL: git@github.com:openjdk/jdk19.git
> >     HEAD branch: master
> >     Remote branches:
> >       master tracked
> >       pr/1   new (next fetch will store in remotes/jdk19)
> >       pr/2   new (next fetch will store in remotes/jdk19)
> >       pr/3   new (next fetch will store in remotes/jdk19)
> >     Local ref configured for 'git push':
> >       master pushes to master (fast-forwardable)
> >
> > I would naively expect the pr/1, pr/2, and pr/3 branches to be either:
> >
> > - not displayed, or better
> > - displayed with a hint that they won't be fetched (since they match a
> > _negative_ refspec, which is the second line in the `git config`
> > output above)
> >
> > Thanks,
> > -Pavel

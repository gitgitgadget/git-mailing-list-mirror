Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904D6C433F5
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 05:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239524AbiD1GBg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Apr 2022 02:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbiD1GBe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2022 02:01:34 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E948F34B9C
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 22:58:19 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id s68so1859424vke.6
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 22:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0NtQaXXwNPMkbi4Ijfvy+3sGafen94gfKmr/34/bHAs=;
        b=c97vjrup+eNkhz16gFNO3qvGXKggJV8ziaxly4/pdvOdrp0B8zqE31t9i8v1L0mVsE
         DoVyAz+5I0HURzDIIZ0M0boJGM87WY7nec7RsXXcq5ElnFzVpjfFzJSULuNA21J7GYQk
         wzPWcPETcIx7dfokj8CZZhx6haJStD491xOvNsE8xiJoey4H8cKLue6QOiepdYhwkP93
         QlRPX/rAydGyDXlCpdUlpq0Rd00A/+ISbnsq/1q7+BtAyGIbJFvQlCvLEL0NZIEbsfa9
         PYWyidLD/NsyEtq1OeSNzcLFjbiPEpD8IhOf91KI9tOgKOkuPi58OQqV6+oWiJnT5WdQ
         MFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0NtQaXXwNPMkbi4Ijfvy+3sGafen94gfKmr/34/bHAs=;
        b=UIm1Dj6dt/gGQBu5BdRTC7DQhvSt05LrH7xsHF7+B/ZyQQmzv+BXCWbjD8keJVsdJz
         f+t5LpXw0jV9K697RgPAtKST2LoVDuIRWoXhbgFq2ukmjev/f5BR/Ty8pZYNZOKLXRh3
         8BPFFbJOV+1GgK6Su639DzUk/sCxEKx6fdebi4zf5VOD6GvKcp097Rn4Ok6aQkEF5Hur
         wKzw/tXDqdlpF8x0PDr69jSTW/KZQ7wjATRU/hsntMl7Kb/jcPSn9LGLvzW8ksXHQ9mA
         3l7SU1g9d3og6gHRWoUvcLpuhoIwKTv7/3pAeKaUo9iRNQoprJu2r5sKSfcRa3ZM1UdY
         ms+w==
X-Gm-Message-State: AOAM533r6rn3opvISAnm1PRC3MwRaVJxvQne3esveb8fRxsiO4XLWEuE
        usf1BBwcngkbAaTOGH7BSrr1NPT+1euzrCG8qh1KvooG
X-Google-Smtp-Source: ABdhPJx2BTlEGoXqSdZYGxQEkuqpoxx6II4ce3JNukkrmVyt6HOO8uuBmLn8DjrPzMNswt6iz8HZI8gHDOkilBqoSOc=
X-Received: by 2002:a05:6122:984:b0:34d:8cc5:43d8 with SMTP id
 g4-20020a056122098400b0034d8cc543d8mr6338424vkd.39.1651125499023; Wed, 27 Apr
 2022 22:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220427222649.63516-1-carenas@gmail.com> <20220428033544.68188-1-carenas@gmail.com>
 <20220428033544.68188-2-carenas@gmail.com> <xmqqlevphjmg.fsf@gitster.g>
In-Reply-To: <xmqqlevphjmg.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 27 Apr 2022 22:58:07 -0700
Message-ID: <CAPUEsphE1PkZ_oZVAizUqeJRaA3muL1t8ONH=7bCqvxOksf2zg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Documentation: explain how safe.directory works when
 running under sudo
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 27, 2022 at 10:17 PM Junio C Hamano <gitster@pobox.com> wrote:
> Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:
> > diff --git a/Documentation/config/safe.txt b/Documentation/config/safe.=
txt
> > index 6d764fe0ccf..67f8ef5d766 100644
> > --- a/Documentation/config/safe.txt
> > +++ b/Documentation/config/safe.txt
> > @@ -26,3 +26,11 @@ directory was listed in the `safe.directory` list. I=
f `safe.directory=3D*`
> >  is set in system config and you want to re-enable this protection, the=
n
> >  initialize your list with an empty value before listing the repositori=
es
> >  that you deem safe.
> > ++
> > +When git tries to check for ownership of git repositories it will obvi=
ously
>
> Comma before "it will obviously".

Obviously my whole paragraph could be improved further, do you want
a reroll with this fix, or would instead fixup locally?

> > +use the user that is being used to run git itself, but if git is runni=
ng

"use the user that is being used", is something my high school grammar
teacher would label as a "cacophony", so feel free to provide an
alternative as well there.

> > +as root, it will first check if it might had been started through `sud=
o`,
> > +and if that is the case, will use the user id that invoked sudo instea=
d.
>
> This raises a design question.  In a repository is owned by root,
> shouldn't "sudo git describe" work?  IOW, I am wondering if the
> "instead" at the end of the description is what we want, or if we
> want to check both the original user and "root".

I think it makes sense to have both, and your implementation below
seems like a good way to do it but it might not be as safe as it
seems, since sometimes directories owned by root might be also world
writable and therefore not necessarily safe.

This is obviously not directly related to this code, but the original
issue as reported in Windows for the original CVE could be traced back
to the default policy to allow any authenticated user to write in the
root directory.

Carlo

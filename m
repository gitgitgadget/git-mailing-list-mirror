Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FEAC433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 19:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54E7C613F4
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 19:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236917AbhD0TYM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 15:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbhD0TYL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 15:24:11 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49673C061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 12:23:26 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id v23so9121546qkj.13
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 12:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=caI3ele0eCgQN7hBeB5mgsAvnmH+EqgDxX+LKgQgcck=;
        b=QEFBppwhU9b8FIZSXgHbDp6QH+QFPSgW62CmKoJJB2Mo9cD8NitGRCCmkIRbwq2OaZ
         Q7hU14Cx1t7ZQQzjjpwenrfSdmS2V5gGDnuZsAzSeKibkoUbdHtm8h2GQ2B1cLhX2OMy
         ctFf0WuROpQ8YN+mO7y1H7cHjDn+9dS0wAyKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=caI3ele0eCgQN7hBeB5mgsAvnmH+EqgDxX+LKgQgcck=;
        b=Pc2xTGDywHbhUKib4rKZZekw/UDLAbktZ/V6m+suvVRe2jq1SXuJ1htyuPmwLxXWqs
         yViNxxygNpcM12Il1ogy/1y3uJJHC271RLPscPFLoz2eLAG67Tro4gx8w50lL+gjO9Zj
         7tfGPzFayOde5nOHwNdgAQQ1mc1c6Wad2h9/uqEUuuyMVuWwv8GcR/88jvdNSJhHcd/F
         7gBeyICMuYDh9+0Rk+uZyHsWlVHxxVf9p6mydaOB5eXgBV8ewpNPDGmWcZ/1whKkL93b
         MIkgTJlppfIkJ/Y6J4DKfKYagxJo4uDqFI3Tyava/RWKBg9Z3xtnALzar/UFaZFRDZjZ
         oo/w==
X-Gm-Message-State: AOAM531u15Caru14mInlwkeOlYPT1CnGrfqcR2KiPBlyJ8zJDaVU7jnq
        WFy5da9R8P7b17mqwe2snHaedI5XAbL5prXxtE8xZQ==
X-Google-Smtp-Source: ABdhPJzEfID2np3aPZsc0sK0bc16Dz8CzxRvi/1mIyuL7Wiip+SaBYJeYLH75igK54i8rUKoITAsKW7RE5kQiHKsN7k=
X-Received: by 2002:a37:64d:: with SMTP id 74mr24409156qkg.6.1619551405383;
 Tue, 27 Apr 2021 12:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210424212117.6165-1-adam@dinwoodie.org> <nycvar.QRO.7.76.6.2104250413320.54@tvgsbejvaqbjf.bet>
 <CA+kUOan3vk1zJezpieRhKwZ8gsYrCxDBefkXJ1fUC61O+gb12A@mail.gmail.com>
In-Reply-To: <CA+kUOan3vk1zJezpieRhKwZ8gsYrCxDBefkXJ1fUC61O+gb12A@mail.gmail.com>
From:   Adam Dinwoodie <adam@dinwoodie.org>
Date:   Tue, 27 Apr 2021 20:22:49 +0100
Message-ID: <CA+kUOamYmFcKA+_on83=EbitvL4FQo9teMEbRHsQ=xo2ave1yQ@mail.gmail.com>
Subject: Re: [RFC PATCH] cygwin: disallow backslashes in file names
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     RyotaK <security@ryotak.me>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Re-adding the previous Cc list that I'd failed to copy on my previous
email, sorry!]

On Mon, 26 Apr 2021 at 20:56, Adam Dinwoodie wrote:
>
> On Mon, 26 Apr 2021 at 15:08, Johannes Schindelin wrote:
> >
> > Hi Adam,
> >
> > On Sat, 24 Apr 2021, Adam Dinwoodie wrote:
> > > Notes:
> > >     The patch to read-cache.c is the one I've applied downstream as t=
he Cygwin Git
> > >     maintainer to resolve this vulnerability, and I've manually teste=
d that it
> > >     resolves the vulnerability, so that's the change I'd recommend an=
yone who needs
> > >     to build Git on Cygwin themselves take until there's something of=
ficially in
> > >     the Git source code.
> > >
> > >     I'm much less convinced by my approach for the test script.  I de=
finitely think
> > >     it's worth having a test here, but the test as written still fail=
s, as the test
> > >     seems to be looking for the error message "directory not empty", =
but running
> > >     the test on Cygwin produces the error "cannot create submodule di=
rectory d\a".
> > >     I'm not sure why that difference exists, and whether the correct =
approach would
> > >     be to (a) ensure the error messages are consistent across platfor=
ms or (b) to
> > >     change the test to expect the appropriate error on the appropriat=
e platform.
> >
> > Wasn't there something in Cygwin that _allowed_ backslashes as file nam=
e
> > characters? I vaguely remember that the ASCII characters forbidden by
> > Windows were mapped into some "private page".
> >
> > Maybe that is responsible for the difference here?
>
> So there is special handling of a bunch of characters like ":" that
> are valid as parts of filenames on most *nix systems, but which aren't
> valid on Windows, by substituting them for characters in the Unicode
> "private use area" space. Backslash isn't one of those characters,
> though; quoting
> https://cygwin.com/cygwin-ug-net/using-specialnames.html (which I just
> checked myself to be sure): "The backslash has to be exempt from this
> conversion, because Cygwin accepts Win32 filenames including
> backslashes as path separators on input."
>
> Which is not to say this special handling _isn't_ the cause of the
> difference here, but it's not so simple as that. If nobody spots an
> explanation I've missed, I'll start digging into the code and strace
> to work out exactly what's causing the difference in behaviour.

I've worked out what's going wrong here: the "prevent git~1 squatting
on Windows" test is actually testing a selection of different Windows
path oddities, which are handled differently between Git for Windows
and Cygwin Git. The specific behaviour here is the handling of a
directory called "d."; Git for Windows (I assume in the MSYS2 layer)
follows the standard Windows convention of treating "d." and "d" as
identical filenames, while Cygwin sticks to its general design
philosophy of mostly emulating *nix systems, allowing objects with
both filenames to exist in the same directory (and causing pain for
most non-Cygwin applications that try to interact with them).

Essentially this test is checking a bunch of different oddities about
path handling on Windows. Some things =E2=80=93 such as handling backslashe=
s =E2=80=93
are common to both Cygwin and MSYS2; some =E2=80=93 such as handling traili=
ng
periods =E2=80=93 aren't. So I expect the solution here will be to have
separate tests for (a) Git for Windows, (b) Cygwin Git, and (c) common

behaviour.

> > >     I'm also not convinced by my approach of adding a "WINDOWS" prere=
quisite to
> > >     test-lib.sh. I went with this as I couldn't immediately see a way=
 to pass
> > >     prerequisites on an "any" rather than "all" basis to test_expect_=
success, and
> > >     this would allow us to simplify all the tests that currently have
> > >     "!MINGW,!CYGWIN" as prerequisites, but it still feels a bit clunk=
y to me.
> >
> > Right, the only way I could think of it would be
> >
> >         test_lazy_prereq 'test_have_prereq MINGW || test_have_prereq CY=
GWIN'
> >
> > Your approach looks fine to me, though.
>
> Grand, okay. I'll stick with that for now, then, and follow up with a
> patch to tidy up the other prerequisites at some point in the future.
>
> Adam

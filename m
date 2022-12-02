Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4111C4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 23:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbiLBXNB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 18:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbiLBXM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 18:12:59 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63384A3225
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 15:12:58 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id v8so8366679edi.3
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 15:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=55kWaTlaVyjwnnQuExwSmSalTAl+zGNJ4RzE5Tus+S0=;
        b=Arr/YZLe3LssU/x/Dx+yCg3dsl7hfgrzEwhtVR8Uy89WmObiQFaLKM+ksMeQ8+XzUx
         /pTugPJUZPJRHnqAnIrW8rm65/QFFyhBlovjj7rs1giEBIzSz/x6hZB+n5LTkxG1X0i8
         smwbQRHJLs8pn1/Oxno4iDlykSEx/p6zQmEM0wYm1ze23dibm5TkIjhCwn+HGWK9SrS9
         wGl6qlkZNt2nldGz+Pz4UxjrH8GRvqA/wOXAX/xhy4Z5f7WiJz5Dh3zegVdNPIDfuOp9
         k8ZygiROEoBJB1KSmHj9XsejNfOuYOeWbu1THkzwOxW/fQX14XIlofzl54OewzB8idX7
         /nLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=55kWaTlaVyjwnnQuExwSmSalTAl+zGNJ4RzE5Tus+S0=;
        b=XBylUoYDxHCyjvPppjsuH0uIr525Vr6aBnib+1SniDQTySIrQ9Mmey9X0pY8GtIjtN
         1v++v6yB3G8PwSmo/UKtclp9HHhXHwcHLSMdR4fJYETuGx20ul+mrnhmkFV4ms8PiCsc
         NshydiJ+jUZ9AUwYx7U9EIoYdJx25OqY1Bl66PKEvgUKXjWfeuI8rz/3DENy2l7uPYGD
         maXkdJuT1JzHUvOm35jyVIiqcBdvs/BeuHzNT2U//JxD62sS87Qhf5BuKp3EC+oKXk6M
         ppz12F0rk6Uu6wQ1BzjPmTP4koTd7gMKxNSNilFcNatgQXEb0CpKA3mKKIqCm7i8IbX5
         hQLw==
X-Gm-Message-State: ANoB5pme4vgfaHC/FAKtcbdR3CLmPs3FljxZAJP1LPvvDE2C1N7WNyAz
        eGmVc2ZtgJgywg2xCR1/GMY=
X-Google-Smtp-Source: AA0mqf52dbdmGcoVZ2++fUUGYsf0yCb74Vlfs2sjByaGgc7vDWXT61simvamPcGReoHzdAt27rZbOQ==
X-Received: by 2002:a05:6402:1145:b0:46a:d5ee:d150 with SMTP id g5-20020a056402114500b0046ad5eed150mr30478850edw.312.1670022776747;
        Fri, 02 Dec 2022 15:12:56 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id ky16-20020a170907779000b007c08091ad7esm3482071ejc.208.2022.12.02.15.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 15:12:56 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p1FDD-002whZ-0e;
        Sat, 03 Dec 2022 00:12:55 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stefan Sundin <git@stefansundin.com>
Cc:     Victoria Dye <vdye@github.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff Hostetler <jeffhostetler@github.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH] fsmonitor: eliminate call to deprecated FSEventStream
 function
Date:   Sat, 03 Dec 2022 00:02:07 +0100
References: <pull.1436.git.1669991072393.gitgitgadget@gmail.com>
 <221202.86o7slfzot.gmgdl@evledraar.gmail.com>
 <3e2bd865-3ca5-b0f7-095e-f8b97ec8822c@jeffhostetler.com>
 <221202.867cz9fwnf.gmgdl@evledraar.gmail.com>
 <4711d955-02b2-f599-7f89-b442dd0b6215@github.com>
 <221202.86359xfs5c.gmgdl@evledraar.gmail.com>
 <1b090929-f2da-f075-01d4-458804fc0717@github.com>
 <CAMDaVWGKx3YMuzRvqGTvvcwh1y9CotFtOCpyAzm=QW3YLy5ROg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <CAMDaVWGKx3YMuzRvqGTvvcwh1y9CotFtOCpyAzm=QW3YLy5ROg@mail.gmail.com>
Message-ID: <221203.86tu2de6x4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 02 2022, Stefan Sundin wrote:

> On Fri, Dec 2, 2022 at 6:24 AM Jeff Hostetler via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> The MacOS version of the builtin FSMonitor feature uses the
>> `FSEventStreamScheduleWithRunLoop()` function to drive the event loop
>> and process FSEvents from the system.  This routine has now been
>> deprecated by Apple.  The MacOS 13 (Ventana) compiler tool chain now
>> generates a warning when compiling calls to this function.  In
>> DEVELOPER=3D1 mode, this now causes a compile error.
>
> Typo here, MacOS 13 is Ventura not Ventana.
>
>
> On Fri, Dec 2, 2022 at 1:17 PM Victoria Dye <vdye@github.com> wrote:
>> My point is that such a user for this scenario is so unlikely to exist t=
hat
>> holding up this patch - which provides a real, tangible benefit to
>> developers *right now* - to implement your suggestion or modify the comm=
it
>> message is, at best, an unnecessary distraction.
>>
>> If, somewhere, there is a user that 1) keeps up-to-date with the latest
>> version of Git, 2) uses FSMonitor, and 3) is working on the sole version=
 of
>> MacOS that was theoretically compatible with FSMonitor before this change
>> but now is not, we can accommodate that once such a need is shown to exi=
st.
>
> Looking at config.mak.uname it seems quite easy to keep git working on
> old MacOS versions by adding a check like =C3=86var suggested.
>
> Something like this:
>
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -161,12 +161,15 @@ ifeq ($(uname_S),Darwin)
>
>         # The builtin FSMonitor on MacOS builds upon Simple-IPC.  Both re=
quire
>         # Unix domain sockets and PThreads.
> +       # FSMonitor on Darwin requires MacOS 10.6 or later.
>         ifndef NO_PTHREADS
>         ifndef NO_UNIX_SOCKETS
> +       ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`"
> -ge 10 && echo 1),1)
>         FSMONITOR_DAEMON_BACKEND =3D darwin
>         FSMONITOR_OS_SETTINGS =3D darwin
>         endif
>         endif
> +       endif
>
>         BASIC_LDFLAGS +=3D -framework CoreServices
>  endif

That looks reasonable, but just to be clear I'm completely neutral on
the question of whether it even makes sense to support versions this
old. I.e. maybe it should just be:

	ifeq [some expression detecting older than OSX <=3D10.X]
	$(error We do not support building on versions this old, sorry...)
	endif

> Looking at that file it seems like a lot of care has gone into keeping
> compatibility with older MacOS versions so in my mind it seems
> appropriate to continue that legacy, especially since it is so easy.

There's a lot of care for some of it, but some of it's just old build
definitions covered in cobwebs that nobody cares about anymore :)

E.g. there's bits in there to support AIX v1..4, the last v4 came out
before this millenium, and I v1..3 was in the 1980s. Ditto probably
SunOS 5.6 and older (which would be *very* conservative),

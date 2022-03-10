Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C8EC433FE
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 01:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbiCJB5X (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 20:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbiCJB5W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 20:57:22 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C847128596
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 17:56:22 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id v28so5692245ljv.9
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 17:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=FcLEKpFQIQBw5NbmvmyFnX/Jxb2rQSkCylHljhbh6RE=;
        b=e/rqb6zG9nPd0ZRhfOlYsbAMvEU0awj+ObfrDkmRyqaEAxmGwnCEALkYQD7YmMJE9t
         CGcvZBY77IiBMkVLQq+/J0AejWyYNYr/Yqz7HWmPyTYnU6taYrwc5RiViHL429LM5DI1
         yPklNyJf3tOEYbtm8tJFVltzTeinEfuZrueCZrv1MNsimBfs14vXjJB57YDpDLqw0rxY
         13vQ8Yrx0K2QUNuuBBCkQ20pOD3jbXXJBLFsuXnseTQyunVCzVWK/LRQdAlIP6mwsVvq
         fN31NJQx7exfW1XsCHBb5z5pRoHCcRjrnXAOyTRkvofdEFkLS5HijmBUpkhi8ZPZ5UYg
         4deQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=FcLEKpFQIQBw5NbmvmyFnX/Jxb2rQSkCylHljhbh6RE=;
        b=jncAhfLS7GgpiBBprADdZ2axfgPDc9IolOBe+Bok3IbgUeZTPBa/gH5rsmGaGPMP0D
         r28yxRada9trXoDrwg/u6PYKWiUIOtcx/g1CZK5GQp0EG2bx8m0+GvL7jkrpBMb3fV2F
         XsAVBP+2tnwhds1/yYBsIUOntw8kRylZMDkExLlRE3+tDV3XD72nBvSHF2sC/0QNY1aQ
         7ETrQuZJ6BU62p/vU5poY04WtfSisfEBNVofRc8AWrzgvqGv0CcyfEEc7x9NDDbgJeC3
         lJkxttqJojma5hZP8Hz6QpzVzzgXPDJq8WVIsAIdXrHQ2mgRTv0DwvJgw7xWMcrgJGQv
         G1aA==
X-Gm-Message-State: AOAM531AyQi4CFVMht55k1J3vrJXFmezrdhD23sVMYY7dXo3d6ULxw65
        rE1icepR6aEvgQIHHbfSd7Mytho69ndoZU0Hww8=
X-Google-Smtp-Source: ABdhPJw/i3Lws0w+1/M6wCc2xtvA5EOC2GGWanFJQUFdb6l9fNA7NqlSA5wp72zyIXo63eYBmGZbJmpCGyP4WGC6JIs=
X-Received: by 2002:a2e:9c01:0:b0:247:e785:49cf with SMTP id
 s1-20020a2e9c01000000b00247e78549cfmr1509417lji.413.1646877380611; Wed, 09
 Mar 2022 17:56:20 -0800 (PST)
MIME-Version: 1.0
References: <pull.1093.v4.git.1643686424.gitgitgadget@gmail.com>
 <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com> <685b1db888079c83573cfd984ae64f46284544af.1646866998.git.gitgitgadget@gmail.com>
 <YilTug0iH/N2Fbpb@camp.crustytoothpaste.net>
In-Reply-To: <YilTug0iH/N2Fbpb@camp.crustytoothpaste.net>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 9 Mar 2022 17:56:09 -0800
Message-ID: <CANQDOdfZbOHZQt9Ah0t1AamTO2T7Gq0tmWX1jLqL6njE0LF6DA@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] wrapper: move inclusion of CSPRNG headers the
 wrapper.c file
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 9, 2022 at 5:26 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2022-03-09 at 23:03:14, Neeraj Singh via GitGitGadget wrote:
> > From: Neeraj Singh <neerajsi@microsoft.com>
> >
> > Including NTSecAPI.h in git-compat-util.h causes build errors in any
> > other file that includes winternl.h. That file was included in order to
> > get access to the RtlGenRandom cryptographically secure PRNG. This
> > change scopes the inclusion of all PRNG headers to just the wrapper.c
> > file, which is the only place it is really needed.
>
> We generally prefer to do system includes in git-compat-util.h because
> it allows us to paper over platform incompatibilities in one place and
> to deal with the various ordering problems that can happen on certain
> systems.
>
> It may be that Windows needs additional help here; I don't know, because
> I don't use Windows.  I personally find it unsavoury that Windows ships
> with multiple incompatible header files like this, since such problems
> are typically avoided by suitable include guards, whose utility has been
> well known for several decades.  However, if that's the case, let's move
> only the Windows changes there, and leave the Unix systems, which lack
> this problem, alone.
>
> It would also be helpful to explain the problem that Windows has in more
> detail here, including any references to documentation that explains
> this incompatibility, so those of us who are not Windows users can more
> accurately reason about why we need to be so careful when including
> header files there and why this is the best solution (and not, say,
> providing our own include guards in a compat file).
> --
> brian m. carlson (he/him or they/them)
> Toronto, Ontario, CA

I wasn't able to find any documentation from other people who hit this problem.

The root cause is that NtSecAPI.h has a typedef like this:
```
#ifndef _NTDEF_
typedef LSA_UNICODE_STRING UNICODE_STRING, *PUNICODE_STRING;
typedef LSA_STRING STRING, *PSTRING ;
#endif
```
That's not really appropriate since NtSecAPI.h isn't the correct place
to define this core primitive NT type.  It should be including
winternl.h or a similar header.

I'll update the change to only move the Windows definition to the .c file.

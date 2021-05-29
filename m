Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A63C47082
	for <git@archiver.kernel.org>; Sat, 29 May 2021 22:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 061F4610FC
	for <git@archiver.kernel.org>; Sat, 29 May 2021 22:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhE2WPu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 18:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhE2WPu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 18:15:50 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C530C061574
        for <git@vger.kernel.org>; Sat, 29 May 2021 15:14:13 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id e2so1909885vsr.7
        for <git@vger.kernel.org>; Sat, 29 May 2021 15:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mTlSwwKfY4Z4IE6+8SfyhnlNMfOCmsOUl0Rr8sXDYgY=;
        b=tUXuvu1HtnSZdGTT9Cn4fIQXd4BdJ5gbw/OVPuufocm2Eo+E+ayojiet9xCQ3pqPc9
         9Yd6PwwUyflV3o0lVOZrpH8SVfU7jA9eG5jQHf2p1lVjmIyRkimRPotgDlNCt0Dq4xvE
         kwY7lvgFJPb9ldR1gJhLzAzNlVYZxKy+DbDnUYS1aApbYwaKESv1gLG348Esoj4aUqpX
         NhKZgRDgdK3J0zBJ8rc8ym0QA2yUIe9FPvbfBx7WyTNy3epscM9xAS3jLBSAbf/d1C9P
         c/Jv1wDP4zsR7vzG0oTlJlyEP0lIJjTfw/2ZprjrdfK72LJQ8EQ2ywCLZ96a5lHOJGB2
         qkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mTlSwwKfY4Z4IE6+8SfyhnlNMfOCmsOUl0Rr8sXDYgY=;
        b=N3JtHjT8QGNST/ad3ctojOhrhQz3euZsH1pB2xOeDohZH5z44D7aV/5nCUL0eOggQA
         PdxV6m+HQjrOeWUjJLbsf2ssxIIR9uuH2aZjhXUR8eow3RnVaMfzDMPLoJNY+NbIAeLn
         h8KYyghbuou6i/pzi1oykmFr9vhqTC2fCCMB5GG4SK5A4yzHe73fBBHSnB19Qv3wDno2
         Mtq90mjzlt2wHlIHX6zWPN6aOwm4x2j6yx4qLqKto/xMbqXR6JItBYghvGM5ftsVFPG1
         A2mPdxOZ71y3G1qiTGt+HxSVbJ8JrXr+70dJWl/MpBjNz1mgPavCVzOjb+421VS38r5U
         0roQ==
X-Gm-Message-State: AOAM5315KARBJ+PpDrVdhHWIMqyOWJoHbIUxVZlP0p6aMsSQ0V5VX1v/
        np3LXKZXbu9ZGEWCYKFH2uId/VVPqG7bBLD4Bm4=
X-Google-Smtp-Source: ABdhPJzzg+SrLbKojENyudtJD0YZAjYJB0i0tylnzPALNEUDFExCx12v5qHIDDyC0WT2u5dc9eEDkQvHYENOw+w9j/w=
X-Received: by 2002:a67:cb0a:: with SMTP id b10mr11663402vsl.9.1622326452249;
 Sat, 29 May 2021 15:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <013f42a4-19f4-a935-7068-db3f7ff40446@iee.email>
 <CAOjrSZtWVEUNEuJFw8WGPAW0YNccN9LWyuHZ28aKecdjd6dp=A@mail.gmail.com>
 <7aadc622-ad4f-1d7e-a956-57ab74f18096@iee.email> <CAKiG+9U70wXm7MtTLMUpPC_aHMp58bTtJBbP=NgoAcQQmCPSuQ@mail.gmail.com>
 <7ac2c0f4-e8ed-5676-1f81-3446e33def9c@iee.email>
In-Reply-To: <7ac2c0f4-e8ed-5676-1f81-3446e33def9c@iee.email>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Sun, 30 May 2021 03:44:01 +0530
Message-ID: <CAKiG+9UeT70S3_jNXUbx2KCM6UDUxPKMizFX_fUiioDo-zmp+Q@mail.gmail.com>
Subject: Re: [RFH] CMake: detect if being run via Visual Studio, independent
 of build generator?
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Matt Rogers <mattr94@gmail.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Danh Doan <congdanhqx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Ahh, so it (MSVC) would be unset at that point no matter what at that
> early point in the code, yes?
>

yes

> >
> > To fix this I would suggest to change line:53
> >
> > -  if(MSVC AND NOT EXISTS ${VCPKG_DIR})
> > + if(CMAKE_GENERATOR MATCHES "Visual Studio" AND NOT EXISTS ${VCPKG_DIR})
>
> I'd seen this one recommended on a few StackOverflow answers but it no
> longer works (for a new install of Visual Studio) because
> CMAKE_GENERATOR is now set to "Ninja" as default (sigh).
>
> Simply dropping the MSVC test may be one option - we are already guarded
> by the earlier WIN32 test so were aren't on another OS, though I expect
> there could be some who want to not use VS, and already have options..

I am one of them, I use clang and MSVC with Ninja.

> > and
>
> > add CMakeSettings.json to force Visual Studio to use MSBuild.
>
> I was trying to avoid requiring VS users do any extra set up steps. Too
> many steps often puts off new users, and forcing a change could be
> annoying for established users - hence the caution.
>

Yeah, I agree.

Right now, I seriously think that we need to revert
958a5f5dfe4dda4fd59af30c1d58abe43ff19d6e.
This patch also hurts command line users like me.

A more complete solution would involve adding an explicit option to use vcpkg.
This can cater to people who prefer using vcpkg and to people who
prefer using their
own packages (like me).
But this means that you have to generate the solution file using the command
line. Some people might be put off due to this extra  'single' step.

I am afraid this is a situation where you cannot make everyone happy.

Thank You,
Sibi Siddharthan



.

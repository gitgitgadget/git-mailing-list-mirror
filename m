Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21FCC2D0E2
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 10:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8805623772
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 10:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGH/bfde"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbgIXKel (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 06:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgIXKel (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 06:34:41 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10729C0613CE
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 03:34:41 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id u4so1462507plr.4
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 03:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SzwD1o8TTj2pUKaehyvGNeoiwKIreiSFL+trT8wczAY=;
        b=aGH/bfde8n+t1YeXqj08V8W6jaTK4sOxADB1UpBUOeoaZ3Dz+U/udIvllp6g6dtEHJ
         4uWYNHQk1Drb0gMcEd1ADC0PlgIde+diSobsqi7mDe62m0KJnuMdeKTkCPTXLSf0qqBC
         DzovouUlWKYsisPhWf3DxCxLXcOi/I0FewvxvLWrHviA+r8kux2u8NbbRp34TifieYBl
         pcicDi2yyJI6PvtgS4VL+EYFm4ALMI9bETLcrWwWA1jBLqPgwdSHGFljSrjgqrhEVhOT
         A3r2I71jRUhWTBV1bFmVnPzX7nSbb9xlaS4SRm+tx+QLE877gU3ZMo+LHE29I5ZpehsI
         kKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SzwD1o8TTj2pUKaehyvGNeoiwKIreiSFL+trT8wczAY=;
        b=Ghj23ToQZTANZ3bma574TAIPEj3GXjR04TK6f8c2U055kMC/RBv3Jfj9Jrud9z/DDX
         Rh8fGw6dXyy+qM0A7SD/Tt61z/UQ/mQETnUYK6uImwvUIWukTKs4qWcjPycfV1907zqm
         aoReY2nU3hJPZZMKMatFg449yyueToS4dGz41Cn0/f1dSrPWL5+MtTIOHrtKeHgszi2a
         dMZeSElpVXUdj+df3/lVE4Vqvv8EonfLHmGzFI3xE5EPE/e0PDx0w6Wy9R1u57U1d5Pf
         8oSmuCHj4kmnpCC2OCIAC3dJqGKm4jdtP15tokwnWHohMqMkD8JrwEzHy+anm9yMewJ7
         DcbQ==
X-Gm-Message-State: AOAM533SS+sZt7rNxzWRpPPd8uQUH3jvGF4WHg3H8lmYEotYAKhQx5a6
        tCdGFH7RuDZRh2SQOOo3JoI=
X-Google-Smtp-Source: ABdhPJzFh8UxS9ETGX5athXO0Tp9qLmTSamWIruUkFofbRcqIsZEH5cPj4wNEgPTYU+zs+ctL/wRnQ==
X-Received: by 2002:a17:902:8545:b029:d1:f2e3:8dd4 with SMTP id d5-20020a1709028545b02900d1f2e38dd4mr3968996plo.65.1600943680597;
        Thu, 24 Sep 2020 03:34:40 -0700 (PDT)
Received: from localhost ([2402:800:63a8:845a:d928:cf31:b27:22d1])
        by smtp.gmail.com with ESMTPSA id q4sm2377162pjl.28.2020.09.24.03.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 03:34:39 -0700 (PDT)
Date:   Thu, 24 Sep 2020 17:34:37 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] cmake: ignore generated files
Message-ID: <20200924103437.GA18952@danh.dev>
References: <pull.735.git.1600375065498.gitgitgadget@gmail.com>
 <xmqqtuvwoyz5.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2009181510240.5061@tvgsbejvaqbjf.bet>
 <xmqqft7fnlxr.fsf@gitster.c.googlers.com>
 <20200918155015.GA1837@danh.dev>
 <xmqq7dsrnjhi.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2009201916040.5061@tvgsbejvaqbjf.bet>
 <xmqqr1qsjxgb.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2009232224410.5061@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2009232224410.5061@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On 2020-09-23 22:27:17+0200, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > ... the above sounds like the argument concentrates too much on
> > where the build directory is (i.e. between "in place" and "a
> > throw-away directory next door"), which sounds like much smaller
> > point compared to the other things that needs to be improved in the
> > VS users.  And making a choice against what is recommended as best
> > practice...?  I dunno.
> 
> All I want is for the CMake support to be easier to use, yet we go in the
> opposite direction: instead of allowing to use CMake under more
> circumstances (which actually *works*, we just don't have the appropriate
> patterns in our `.gitignore` yet to avoid adding and committing the
> generated files), we now seem to intend to require a separate build
> directory.

I've left Windows development land for a long time.
So, please take below discussion with grain of salt.

When I was there, CMake Users on Windows mostly used CMake-GUI to
generate build system for CMake since running CMake as CLI in Windows
takes too much hassle.

When I was there, CMake-GUI shows the option to choose build directories
explicitly, and whenever the source directories changed, the build
directories also changed, with some [-/]build added into sourcedir [1]

I heard that nowaday, CMake is supported natively with MSVC, I don't
know what is the default option when using CMake with MSVC, but from
the history of MSVC always supports building out of tree, and
information for Microsoft Docs [2]:

	Click the Show All Files button at the top of Solution
	Explorer to see all the CMake-generated output in the
	out/build/<config> folders.

I think the default UX with CMake on Windows is building project out
of tree.

> That's the opposite direction of making things more convenient for Visual
> Studio users.

So, I don't think we would provide them more convenient with this change.


1: https://cmake.org/runningcmake/
2: https://docs.microsoft.com/en-us/cpp/build/cmake-projects-in-visual-studio?view=vs-2019

-- 
Danh

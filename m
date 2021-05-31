Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CC3C47093
	for <git@archiver.kernel.org>; Mon, 31 May 2021 00:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 160E361220
	for <git@archiver.kernel.org>; Mon, 31 May 2021 00:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhEaADD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 20:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhEaADB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 20:03:01 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA77C061574
        for <git@vger.kernel.org>; Sun, 30 May 2021 17:01:21 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id b7so4352453plg.0
        for <git@vger.kernel.org>; Sun, 30 May 2021 17:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I8U7RGYgjYVxGEf1hgj38M5sr5+wA9i7FegxAKebeCs=;
        b=LdggUgP/xxtNv8wTXhnDhJvbEgJ8T3KCUJhA64zJBiJBDlIWZjzIAHFfAVc4aM2fbZ
         drSUnVjzTAquIM4tCeGO4FgwtXAxhxorNACPuBoFG31HRevCZ6KvsJIMwnCDiDmyH1A7
         V8vs3OQo8sjFBXbJmv0qKYwLKyhlOB0t2BSYGxvvsB0nyTI2hMf0HOPG/LfpW2urK98K
         WAi6xlDfN1HydasxFU+rHpBGxswWsOazWbKMEADIET2YIchGCEYTAHs/pE7M2MZQSpiO
         mAocuZFWBbBXd1c/dbOAbxRvjcKy+JNGDZEbHAq1RJOiW0klCfFG/SUeYxoUQaR0R6zk
         Oa4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I8U7RGYgjYVxGEf1hgj38M5sr5+wA9i7FegxAKebeCs=;
        b=lzsjzkNJuJMH/8eIepDcjLAE4XD2TG+gFNsYaszKaBaWzkL+pogbR+z+L3OR+Ptjo9
         1eouor/B0cdi0evA0x6PAZhlzTjfJSC4R+TdSQh684+XnpU7Q2A1R6qnRkieqg1RQy0q
         k/geA8HymE4N/0L3HrHoGkkRTMKgGtf6IvaWI2AMwUm+aG5PeU8NoqIknpbZYUqP9y6O
         K/9FmjK7SKyZfTaS7hAlsKCZ8BT88kmNgjMKyl4Yx6FTcmqKw9tEEd6sh8cVxyaBfpRq
         Od6A0equv2MdvOs+GhYTy7Wtw9X9VnNsqIJ5Wd4h56qaJa5vpdGoPAW8yrEWPAoZLqVo
         0OpA==
X-Gm-Message-State: AOAM530hf4oEiABqqMSigJrHnPf/ZSQC9bjPxgtm/xR2EYLcwjmd5bux
        7trwrVQZQrb5MxbQemg95+fw6eqq3xcHigdCteEvyUMiS9HPLg==
X-Google-Smtp-Source: ABdhPJyRefdcf7exoajCjQD+cGY1D5Npza3wCnDWmtBBNJioXCsckh69VfSpzBtMWBN7a4hRoYOwBREgt2G03yyncCY=
X-Received: by 2002:a17:902:b683:b029:ee:f0e3:7a50 with SMTP id
 c3-20020a170902b683b02900eef0e37a50mr17787780pls.7.1622419280672; Sun, 30 May
 2021 17:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <013f42a4-19f4-a935-7068-db3f7ff40446@iee.email>
 <CAOjrSZtWVEUNEuJFw8WGPAW0YNccN9LWyuHZ28aKecdjd6dp=A@mail.gmail.com>
 <7aadc622-ad4f-1d7e-a956-57ab74f18096@iee.email> <CAKiG+9U70wXm7MtTLMUpPC_aHMp58bTtJBbP=NgoAcQQmCPSuQ@mail.gmail.com>
 <7ac2c0f4-e8ed-5676-1f81-3446e33def9c@iee.email> <CAKiG+9UeT70S3_jNXUbx2KCM6UDUxPKMizFX_fUiioDo-zmp+Q@mail.gmail.com>
 <CAOjrSZtRH-sqh8RJm3W00dUWTbT-xcpzDWCQFt=3CNaVnOyVWQ@mail.gmail.com>
 <953d685c-3c89-7377-ed49-b79fb4e0acb5@iee.email> <CAOjrSZuzgBs8camWdUjEU+JOjRYwv3MVjRgnyW50pchq6rpYsQ@mail.gmail.com>
 <CAKiG+9WwRHz-5JDPe6KL763kVfRP7vX5HgtDMiX-S1Je5+oWfg@mail.gmail.com>
 <e33bd72f-2095-f32d-5f4f-6137f6a12d22@iee.email> <580d858d-dcd3-9d62-ec97-2daa9d9e0f45@iee.email>
In-Reply-To: <580d858d-dcd3-9d62-ec97-2daa9d9e0f45@iee.email>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Sun, 30 May 2021 20:01:09 -0400
Message-ID: <CAOjrSZusMSvs7AS-ZDsV8aQUgsF2ZA754vSDjgFKMRgi_oZAWw@mail.gmail.com>
Subject: Re: [RFH] CMake: detect if being run via Visual Studio, independent
 of build generator?
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Danh Doan <congdanhqx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > My other consideration is that the build process should generate enough
> > of the right artefacts (e.g. a .sln etc). This is so that other typical
> > tools and extensions e.g. Sourcetrail which expects the .sln, but maybe
> > they'll also cope with Ninja/Cmake builds soon...
> >

Something to keep in mind is that the generator is what decides what artifacts
get produced.  As a consumer of the CMakeLists.txt it's on you to tell
CMake what
your tool needs, i.e. if it needs a compile_commands.json to run clang-tidy or a
.sln file or a ninja.build that would be on the user to generate.  I
think that's
acceptable, if there are common tools in use that require a more
complicated cmake
invocation to get that generation, then it might pay to define a preset in our
CMakePresets.json so that users can get those artifacts with a straightforward
invocation like:

cd contrib/buildsystems
mkdir build
cd build
cmake --preset sourcetrail ..

which I would still consider pretty "batteries included".

I do think however is that there are a few problems you're
encountering in this case:

1. Visual Studio build breaks because we don't install vcpkg here when we should
2. Visual Studio is no longer creating the .sln files, which some of
your external tools
were relying on.

I think that the solution to 1. would be to add a knob for vcpkg
installation, and either
have that knob "on" by default and/or provide a configuration in a
CMakePresets.json
that Visual Studio (and other IDE's/tools) could use to build.

I think the problem with 2. is that CMake is a build file generator
rather than an actual
build system itself, so it needs a user to tell it what kind of files
that their tools expect.
And I don't think there's any way to make it guess what kind of files the
user expects cmake to generate.  Depending on the complexity of the
configuration
it may be worth providing a CMakePresets.json file to make it easier to use, but
I guess it would depend on what exactly you need it to do.



-- 
Matthew Rogers

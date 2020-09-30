Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6983C2D0A8
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 05:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C14B2074A
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 05:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUpxT5gW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbgI3FGJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 01:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgI3FGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 01:06:09 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D8DC061755
        for <git@vger.kernel.org>; Tue, 29 Sep 2020 22:06:08 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c2so266310qkf.10
        for <git@vger.kernel.org>; Tue, 29 Sep 2020 22:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ABupA93zjCwufRQJwrKFej920xFwOuLPrIS/z+dGIDg=;
        b=QUpxT5gWxEU+lFd7tSwGG+PtDIKDvn+i/fFYnQzrGP9DeBMyOM8cdLZxJOuLlEkmLC
         BKEUsiBPvxWbzel5ctoXaSCQ6fdRsmTgNYImcTHvBdvALxea1eDHJE3/kE4C1U/2RV3I
         vi7E+BQ8VNh117xiCo1fD8Qu6UCzDQqeI++CZduir7D4/3D/yPPyABor7w4YRPqFiTyV
         I4vA+yOIFCt+d/PxjoomCTkFnfd9dhE2JIe3Nbo4etS9CmeXM1zgeg4oj1AMcK3nUz5C
         QyZfeEofcADR7wLzHVfI88lXhw8cH8Tah0PM5UpMDIZNDg5RoGpXiyJxUSSXWjKucyRy
         /dnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ABupA93zjCwufRQJwrKFej920xFwOuLPrIS/z+dGIDg=;
        b=YaSXHE62a+jdLRITfa2nvWRFxSWIPOs/IQZ78bs7NWXCKAb7ISb39R9y9x/hlOJFGe
         IEYRSPIzBsyKgvnxhNcIvV+dKj51FDK7NtvnWZh7WBnAlE7HXK1nclK1jJfmzcu3Y9Gc
         c5o9dEGFQev6g3q/dlFHv4CC4PWUrUnOrwK5//wxp8AXqVomLyYr6k8ZaPcz+gTxyaRG
         gC8Bibw2FMqXEdaiJfxKD8Es/OJ1bTjxFSYGcoSZow7JMv2Agq6gBCt2spzMKZXgq+52
         ZhvOXoovDI8/K9Nr1S+IDmX9LIpCssaS8FdS6bXDqjTEDDFXqFXZ/DimpJIcnk2SZ+XN
         92ng==
X-Gm-Message-State: AOAM533zdkwwAf57Oe35xQ9mCDBSyiRRFb/PDGajgPmaZnwvD+B5GrZk
        Garq06FK0uo5UXx2h4l3iWVwizjVoIdTWNaxN1A=
X-Google-Smtp-Source: ABdhPJwHi253V/+CyDOJJskSpPiAkGjdjCfaPcbIWa3Zf/5bNcatzK3nZic4z5W4rMBg+g+W+qZT9xY5LfDClkpdy5g=
X-Received: by 2002:a37:68d4:: with SMTP id d203mr901758qkc.125.1601442367931;
 Tue, 29 Sep 2020 22:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <pull.738.git.1601044118.gitgitgadget@gmail.com> <3a07bd4916c3949eadaa10fde142fba0acaa974b.1601044118.git.gitgitgadget@gmail.com>
In-Reply-To: <3a07bd4916c3949eadaa10fde142fba0acaa974b.1601044118.git.gitgitgadget@gmail.com>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Wed, 30 Sep 2020 10:35:55 +0530
Message-ID: <CAKiG+9W71vEd3bUOEq=vtgcaHuWsjmzGqAdg-rszMANrskQDzg@mail.gmail.com>
Subject: Re: [PATCH 08/10] cmake (Windows): initialize vcpkg/build
 dependencies automatically
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 25, 2020 at 7:58 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The idea of having CMake support in Git's source tree is to enable
> contributors on Windows to start contributing with little effort. To
> that end, we just added some sensible defaults that will let users open
> the worktree in Visual Studio and start building.
>
> This expects the dependencies (such as zlib) to be available already,
> though. If they are not available, we expect the user to run
> `compat/vcbuild/vcpkg_install.bat`.
>
> Rather than requiring this step to be manual, detect the situation and
> run it as part of the CMake configuration step.
>
> This concludes our journey to make it as effortless as possible to start
> developing Git in Visual Studio: all the developer needs to do is to
> clone Git's repository, open the worktree via `File>Open>Folder...` and
> wait for CMake to finish configuring.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  contrib/buildsystems/CMakeLists.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index d21849b730..1eaeb8b8e0 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -42,6 +42,10 @@ cmake_minimum_required(VERSION 3.14)
>  set(CMAKE_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../..)
>  if(WIN32)
>         set(VCPKG_DIR "${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg")
> +       if(NOT EXISTS ${VCPKG_DIR})
> +               message("Initializinge vcpkg and building the Git's dependencies (this will take a while...)")
> +               execute_process(COMMAND ${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg_install.bat)
> +       endif()
>         list(APPEND CMAKE_PREFIX_PATH "${VCPKG_DIR}/installed/x64-windows")
>
>         # In the vcpkg edition, we need this to be able to link to libcurl
> --
> gitgitgadget
>

After reading the patch series I seem to get to feeling that people on
Windows are being nudged to use Visual Studio and vcpkg.
Although they are great tools, when I want to specify my own libraries
I don't see an option here.
I think we need to define a variable, which this conditional block
uses, which is set to true if we are using a Visual Studio Generator.
We also need a way to override this option if needed.
If this variable(explained above) is not set or false or OFF, we defer
building vcpkg libraries. This can also save time in the case
when we already have the dependencies(libraries) and just want to
point to them instead of building with vcpkg.
I also see that people who use gcc(MinGW) are left out. I think we
also need to set the supported compiler(s) here before executing
vcpkg_install.bat. People who use gcc would need to point to their own
libraries with CMAKE_PREFIX_PATH.

Thank You,
Sibi Siddharthan

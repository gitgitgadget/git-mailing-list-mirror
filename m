Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB312C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 16:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FD6E22B2D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 16:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKs/fP/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgIYQZl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 12:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729123AbgIYQZl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 12:25:41 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FFEC0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 09:25:41 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id b13so1673864qvl.2
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 09:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mXXtj77NuN2EjAkORN/Rp10QeSN06LJxnCqzYOwEHLI=;
        b=jKs/fP/DELyHygfnwQk5jbDIL6uLDKBTcWw5lzVR0tmbYx6znHra7rFucOqq+Ym3a9
         oVG/wWOvdm2STWqdscJQ9fhajv6VFT+RK5aio476fOqhMuZ6RvJTqHgGUJqRt6cIIQEr
         GOkSbDC+xvIsB7pZSUcHQqLBRdMMcm9XiZpK6mbnjEeVaMIr/GWdmqLEy3C/PCXC2CAI
         Z91kImY0V1XJiUt8VjAnogvn6ZrQamI8GtcgZjn2uomnRHHJbmgqpkglSCPTvoj1Q36C
         aUFhkoiE733Qy2myqI7HSAj9bfVKkCpjimlQMCOyhBsM+x+L7ARh1t6iLfqoNZ7jo5pG
         hG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mXXtj77NuN2EjAkORN/Rp10QeSN06LJxnCqzYOwEHLI=;
        b=W9k/VQVP0MuDqLtVBrrIe4v9nK7lIvs+CVs3TP7wjQGs+hbimqz0hpM5Ya+3ZkgI1X
         U0K2V4k2PN1MLBQLX01JrGxXLKnBwxvAzRQJa9nEFs3sGxCRGRD0If9Qb08VzD+QwhL8
         7Glq9uFatChUHd20W6BYm8M3Nkr4CmMc/Qm7PMU4qYL04D7KCP9ZMUoFa53uR31GuJsB
         6K4Grj6D9sJ5bg7C1sr0anexTaiSWnB78DYeDOHbYMj6Dz/Q+ET0hednfE8IkJGYEvw7
         eZaJv0TIhIK+59KxtLIXRSrOHbuBb6lnO13NB+3ianlvVDjVFE6eX+c9S3nVw8SGlB0g
         Ay4w==
X-Gm-Message-State: AOAM530hKRcKyYkYtBjv4h1PedCAZDGiZadowsf6uydcX9NVCIoS477P
        miNwRoYHGD35FWGjmxXbPZFE3CVPcnbdLxYfXVpelG8g
X-Google-Smtp-Source: ABdhPJxLwFHQt+RD4di76LQkS9qgNdXQ8XTXEI/WtAvuEK0CrExYZ4YDWzniEPo8Rb1QD2dBd8oahkqpA2/rVylIXqM=
X-Received: by 2002:a05:6214:8f2:: with SMTP id dr18mr173891qvb.49.1601051140509;
 Fri, 25 Sep 2020 09:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <pull.738.git.1601044118.gitgitgadget@gmail.com> <05b4b69fee2b8c32769dd72dea182cfb72a14876.1601044118.git.gitgitgadget@gmail.com>
In-Reply-To: <05b4b69fee2b8c32769dd72dea182cfb72a14876.1601044118.git.gitgitgadget@gmail.com>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Fri, 25 Sep 2020 21:55:28 +0530
Message-ID: <CAKiG+9V=BGX4k_dM-5JzYmko0cZfYXuSxEk5-UuHZpAqaWoU_A@mail.gmail.com>
Subject: Re: [PATCH 02/10] cmake: do find Git for Windows' shell interpreter
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index 5007f173f1..d14fa4f3dc 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -43,8 +43,11 @@ set(CMAKE_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../..)
>
>  find_program(SH_EXE sh)
>  if(NOT SH_EXE)
> -       message(FATAL_ERROR "sh: shell interpreter was not found in your path, please install one."
> -                       "On Windows, you can get it as part of 'Git for Windows' install at https://gitforwindows.org/")
> +       set(SH_EXE "C:/Program Files/Git/bin/sh.exe")
> +       if(NOT EXISTS ${SH_EXE})
> +               message(FATAL_ERROR "sh: shell interpreter was not found in your path, please install one."
> +                               "On Windows, you can get it as part of 'Git for Windows' install at https://gitforwindows.org/")
> +       endif()
>  endif()
>
Let's not point SH_EXE to the 'program files' directory.
find_program() searches 'PATH' for sh.
Since the Git-for-windows installer does append
'your_installation_directory'/Git/bin to the PATH variable, it should
be fine.

I personally don't install my dev tools(except Visual Studio) to
Program Files(because of the _space_), it messes up the Makefiles.

Thank You,
Sibi Siddharthan

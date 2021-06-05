Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85E7C47082
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 23:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A2EA611C0
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 23:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhFEXZ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 19:25:27 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:43916 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhFEXZ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 19:25:26 -0400
Received: by mail-pf1-f175.google.com with SMTP id t28so10245745pfg.10
        for <git@vger.kernel.org>; Sat, 05 Jun 2021 16:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+jWNzufJNN3ilfGjt6/8Di3QHoOMcAxkWzR86mbkG6o=;
        b=olQKD69LTRr8acDOHG1vrCwcYe/X355wZJ8PLMR4DcvHpkFDVuklcXfPPfGllYGEeU
         SQ4pE/ggwgWYcQwqmncsycBX89vhTkK0D+gYEgjkd+qP/RQT2exMyGlMuCJr7hBEAVpx
         q3f5XeVBkA6ygKybjU7JnTc2fFE2z90KQE0s2HNIvWKR2YRkCofx8p0TKK7R/s+JK8zh
         jR3qnfU3WldFjTKu0xh89+r0CAgJ/qGgKwt5EhRq6ZMcyJnhBa3Mu347eairhjxV2N5o
         K12mXjiW5xq0XzDSrDMxF/Ugit+MrsLq/QpIcKMgM6UeaJM03vuUmnIaQH1pmmoR1FfF
         A4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+jWNzufJNN3ilfGjt6/8Di3QHoOMcAxkWzR86mbkG6o=;
        b=VGcJO01uZ/5WzK+cbMHKgimwKM8b0RwAh23gpsog225gScRCmfxBsjLQkzEL3xWyIK
         qsl6PhgZuBGVx1XuqHdJvm2ysgz5iz9C6zcYhxOeN0+5CYmopWL8vYenKJuhjIXm35SL
         2Gf6HdRRd7RILMpifUhSdv8prw+NDMUQTPwgQeaufhvAaDS65PMCXCZxqGdjlW4GIgvs
         CtA2TSA0CCI2j9/OU01X/gDhm5LrJDh2nfPzDlhzke7f7D1Sm+wjElNZ/UA44OCAVf+M
         I0gapNJXHoebTTC4QIF6GZkBjn8T3/wPWIR3bmLa2qWGH6EJJRd9+V0Q24S1h7anZq2S
         c0EA==
X-Gm-Message-State: AOAM532VGe3hWqa27IKpKSOv+HgRnCSvVMjrfTzw5uKFeYcQAKQF1r11
        ElolqGAR/W0EuP5A+2pOucBOM+NqQEYbGDY0C3w=
X-Google-Smtp-Source: ABdhPJwtWwpYpL6mW4Q5rFZMjJyg7P09DA6epDPsp3uDJNpkUnm1CBPOlPqNfNryYwavffS+GgDg4n2YYeJ6TFcigqQ=
X-Received: by 2002:a62:784d:0:b029:2e9:a58e:8006 with SMTP id
 t74-20020a62784d0000b02902e9a58e8006mr10710167pfc.22.1622935347440; Sat, 05
 Jun 2021 16:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <pull.970.git.1622828605.gitgitgadget@gmail.com> <6a9150ca-5c1a-1874-5f8b-35187f197d47@gmail.com>
In-Reply-To: <6a9150ca-5c1a-1874-5f8b-35187f197d47@gmail.com>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Sat, 5 Jun 2021 19:22:18 -0400
Message-ID: <CAOjrSZueB46DgwX7Aymdr=KgzG52kHiEQ52z2q5vczaF9jtedw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Make CMake work out of the box
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Danh Doan <congdanhqx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 4, 2021 at 11:40 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> Hi,
>
> On 05/06/21 00.43, Matthew Rogers via GitGitGadget wrote:
> > This pull request comes from our discussion here[1], and I think these
> > patches provide a good compromise around the concerns discussed there
> >
> > 1:
> > https://lore.kernel.org/git/CAOjrSZusMSvs7AS-ZDsV8aQUgsF2ZA754vSDjgFKMRgi_oZAWw@mail.gmail.com/
> >
> > CCing the people involved in the original discussion.
>
> This focused on improving CMake support, especially on Visual Studio, right?
>
> Then so we have three ways to build Git:
> 1. plain Makefile
> 2. ./configure (really just wrapper on top of Makefile)
> 3. generate build file with CMake
>
> If we want to support all of them, it may makes sense to have CI jobs
> that perform build with each options above.
>
> --
> An old man doll... just what I always wanted! - Clara

Here's my understanding of the current pipeline situation:

I know the Visual Studio CMake generator is currently used to build on
Windows for gitgitgadget[1].

I'm not sure how worth it it would be to add another pipeline just to test if
we correctly set EXPORT_COMPILE_COMMANDS=TRUE on by default
correctly.

I think adding support for running cmake builds on linux is a bit of a waste
since those platforms should have ready access to make, and that's the build
method that gets the official support.

I don't really have much more of a position on this other than "Probably not
worth it to add a cmake build on linux"

1: https://github.com/gitgitgadget/git/runs/2748313673

--
Matthew Rogers

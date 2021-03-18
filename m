Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C3BC433E0
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 13:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 917D964F1D
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 13:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhCRNsR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 09:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhCRNsE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 09:48:04 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD6EC06174A
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 06:48:03 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id o19so6741865edc.3
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 06:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xl5UGF/A3DJedO48Ndn67jS82zod/asT58mZdb1SpGY=;
        b=XVojLFldxxa82XvoCQpyyEnP/HJa9NX/quOJ/ogBPe9G9lT2gdR2uwT54B58gWADLl
         SggGFgGb1ZKAHJwfdjcWzMYjLG9VwDKktXX8IdaQgpTtnErOHCZbX/aYt/2uHKuQyfPy
         9Pm/RGsFACS4wfns+PaNaQHBLl1kLTq26rx7lWt4xpeL3W976osstEGvjvo61y0fQyjM
         r1Ngnea7jhagLMcy4G4njkX2rU5T6E063kyfCT10MfkOavg3fw7hXaaltcZXXsXL9+0B
         7EfHmfsk4SznlA1wHwOUCviFH6Y20Y0k3DBnUm6xlCp9A9ia+2fRz2C491PjRN20LZH9
         Toiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xl5UGF/A3DJedO48Ndn67jS82zod/asT58mZdb1SpGY=;
        b=MjIoPpU7g0IJBOaTaBN55q+1x8Tkkzk0r91PaVCqJJP6Kz0bN1iEVu5Y+zFW93Ajl0
         Rqy6X1Mor1rHZPxE/6zpU7JLXwLctU/NKD3bnJH/fxAfjo4IjTIj59dFwLyZAClncVWE
         EtS2KqZTU1f03K9mMdgdVWNXCA0evbzkxpVrsSEdT8XJWZAvFcJKTUGnQum0rppstEn4
         Bt9/zQoEFoCQZwl0VLZ7jlYFQM+aUbxXMGYWBOmIhylUbkDHvsLTimEQ5d25yb0D5cpW
         WzTiWNc6Q9GeJmenVj/M5W8Ykn4cGQmUOAZRatQA0Rz8JJtKwIg+VGmWkDJA+bw3aOcU
         MiNg==
X-Gm-Message-State: AOAM532wZVCedY2K971KAkWPoS40zfmIdZLKvxj8TPJASLS8agDxPsbr
        DLCipcURuHD8hPJe/N36gLf26SIe+eSPUiD1cuwIIblsrqxQUg==
X-Google-Smtp-Source: ABdhPJykX0sQ5bokg0iz7ILTr6neGlM0bFj5MgY8Cfo/vSG7LTAw+1r/wqzW5uB3kNtL+smonwoDvO5ChD8mTh+LCbE=
X-Received: by 2002:aa7:c4d1:: with SMTP id p17mr3763532edr.387.1616075282426;
 Thu, 18 Mar 2021 06:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <pull.901.v9.git.1615891183320.gitgitgadget@gmail.com> <pull.901.v10.git.1616066156.gitgitgadget@gmail.com>
In-Reply-To: <pull.901.v10.git.1616066156.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 18 Mar 2021 14:47:51 +0100
Message-ID: <CAP8UFD0UJvRn6VN5NaYiCK__Z=A_PTowpNxu8wi=9Byh+jJdFA@mail.gmail.com>
Subject: Re: [PATCH v10 0/3] [GSOC] commit: add --trailer option
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 18, 2021 at 12:15 PM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Now maintainers or developers can also use commit
> --trailer="Signed-off-by:commiter<email>" from the command line to provide
> trailers to commit messages. This solution may be more generalized than v1.
>
> ZheNing Hu (3):
>   [GSOC] commit: add --trailer option
>   interpret-trailers: add own-identity option
>   commit: add own-identity option

I see that you discussed an own-identity option in this thread
recently, but this is version 10 of a patch series, so I don't think
it's a good idea to introduce new features at this point. I think it's
better to not tie the work that has already been done on polishing the
first patch to new patches implementing an additional feature. The
additional feature can be discussed and worked on in its own patch
series building on top of this one.

Also it feels strange that only the first patch has "[GSOC]".

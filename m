Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A8AC433E0
	for <git@archiver.kernel.org>; Thu, 14 May 2020 18:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F08482054F
	for <git@archiver.kernel.org>; Thu, 14 May 2020 18:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HohcimjY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgENS10 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 14:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726075AbgENS1Z (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 14 May 2020 14:27:25 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DA8C061A0C
        for <git@vger.kernel.org>; Thu, 14 May 2020 11:27:25 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id a136so4008670qkg.6
        for <git@vger.kernel.org>; Thu, 14 May 2020 11:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/w9iCsvK/5/tD1Id/UFcJUzu6YWjNIvHIigSeqNU2M4=;
        b=HohcimjY8mKQ9wcV+qKC689Crtm2SZZRsgG48jEfI63EmtDi8Gv3GarBaa0o4GaYVn
         IJMnDPwlmairGXkgBGBd4MDxtjiCjC/opYuPozao4luG19JTsgfoogQUkNV13I1zaWtv
         bjPm82raEZ43CjL2TUojSMXAulKGHXio6T4dig4dU0cYgN0kbzeQVAj1LGh0h9x/THMe
         5vH2J00FVkkHo9VvHnkT1g9bsNad9N9G0ekEkVf4flbhi1MhtZCJeVOf4EIfbyRXEUef
         PDjHSB1fn0a+eG+yV6pbUz8w00heh5SO9s+U7Ly14XJucgJEya3/B9ZgmTCVK2D7StwE
         H5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/w9iCsvK/5/tD1Id/UFcJUzu6YWjNIvHIigSeqNU2M4=;
        b=CGiZm+rLvtxDhB7y3CGeehFPBq9xWFuhy/1jedft8+99lEbpVjZJJUwiAmEo9fvNNX
         PWqQGCL6F+QsnpmX4jdajS+eCK9CPqqCLS+iqUXqJvNlnrkiQ8iR08ztHEOwcfbZwWo3
         PTXOmB7R+0Dj7Vz81DE+sj6j6zN3ncxQ0f/2KvwsIxj247oB/lnuY98IKEus9BFfdukN
         /mQrnu/lVDW6m8GhxhGVP+HId0dKvBptPnOAi1lAZ+HBOcUofxn1ZYwS+do0h9kRzmMl
         Vlx5Qu+gdQgLSC/z0butHB94xJZVoxIykh5ryVi0Gz7V7xxM4xSApfYPFb0dFvjmTYCr
         ujwA==
X-Gm-Message-State: AOAM530n1mTOKUJksj8O3vlncUkHL+0U93cFWLr1/c6oRqrstVtpdVOP
        BE4t2Cyefr0Kxg3kHPixuuq534TGj6FUAtSAnj4=
X-Google-Smtp-Source: ABdhPJy1RyKl3t47DHA0/pCfjGOKPzN/flbWbagTJW6gi7XTdzkZcn3oGG2xSJ4EY+YJ2HaJzbM0n8o4l7lRdO3FK1I=
X-Received: by 2002:a37:49cb:: with SMTP id w194mr5874729qka.77.1589480844687;
 Thu, 14 May 2020 11:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <pull.614.v2.git.1589302254.gitgitgadget@gmail.com> <00cae10bbb7870b27202642d6e1e284a97a3c5b7.1589302254.git.gitgitgadget@gmail.com>
 <20200514152559.GA1939@danh.dev>
In-Reply-To: <20200514152559.GA1939@danh.dev>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Thu, 14 May 2020 23:57:14 +0530
Message-ID: <CAKiG+9Uozz0q_Jk2dPhrh7nKCoObeJWZ-zyX5cr0Zc4Q_0YVsA@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] cmake: support for building git on windows with mingw
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 14, 2020 at 8:56 PM =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh
<congdanhqx@gmail.com> wrote:
>
> Hi Sibi,
>
> On 2020-05-12 16:50:49+0000, Sibi Siddharthan via GitGitGadget <gitgitgad=
get@gmail.com> wrote:
> > From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> > diff --git a/CMakeLists.txt b/CMakeLists.txt
> > index 47d3f3c2866..9625e41886f 100644
> > --- a/CMakeLists.txt
> > +++ b/CMakeLists.txt
> > @@ -13,9 +13,12 @@ project(git
> >       VERSION ${git_version}
> >       LANGUAGES C)
> >
> > +
>
> This newline maybe left from debugging. (and other new newline below).
>
> > +#Platform Specific
> > +if(${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
>
> Please drop ${} around CMAKE_SYSTEM_NAME, here (and other if)
> Or user may accidental messed up.
> ------------8<----------------
> $ cat CMakeLists.txt
> project(test)
> message("This is ${CMAKE_SYSTEM_NAME}")
> if (${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
>         message("Yes, STREQUAL Windows")
> endif()
> $ cmake . -DLinux=3DWindows
> This is Linux
> Yes, STREQUAL Windows
> -- Configuring done
> -- Generating done
> -- Build files have been written to: /tmp
> ---------------->8--------------
>

Thanks for pointing it out, will fix it ASAP.

Thank You,
Sibi Siddharthan


>
> --
> Danh

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375EAC47082
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 22:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BC97613B4
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 22:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhFEWdw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 18:33:52 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:36793 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhFEWdv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 18:33:51 -0400
Received: by mail-pj1-f41.google.com with SMTP id d5-20020a17090ab305b02901675357c371so9203287pjr.1
        for <git@vger.kernel.org>; Sat, 05 Jun 2021 15:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uSKHpIiaF5BDbSI9CFYZdaZFkqg6yIpEkfRo9DcUiWg=;
        b=ThgRPZd75qF42qJNXh8TMm+eiLmWUBv7zalj6RTnXwrNzSY94gQqqIHOVmn9HoMFOn
         FEt8kJYQgfP0yXBKc9awdKudy+EIUin6oGx6AOMYd9iROraircCH2Seite2GWYCc6oSw
         HLGeVuMaeTzMept1XuYtANPnkitEvVOWh2nTQQQOnGBm5eNWnIZJyDzSDRRhnJa7Mw4s
         LUoR3sMFA0fgZyhTdM9rrYSTgJgPaFEr2WzZgeEqEvcq1FuElicvMKGSzt019XRVzGmt
         shpy+2giH9iTUlRfkKpwfE4ylJGpSXwUjF2bBgSoL9A0470nNex1EyfdovAEx96U+/is
         qaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uSKHpIiaF5BDbSI9CFYZdaZFkqg6yIpEkfRo9DcUiWg=;
        b=gnhm3VzugiAwc2k1lNyLe3T6QyvNe1HDPu0Ri9OrYrGisLNUym3F5RKFnnwuhamZ7X
         6bbluBUxLIRoelAJb5B2XDJEUapT0KGNUAXXPfJKWDpLTVQkmSdlf8oyqWntrs61SyYE
         ecEZ7sylSzZF2GFyKeePg99Yht6oC5dyTa2gQjxx+n9wMpXgb3hnJF9xBCjg8kysSd5Z
         cuvlIVuiacp/h8IFVSCiDOVFPycQZzM/RCFxygZ/N5zh1lC0EuEc3FR5Cg85HjqCPgsa
         nNTmBtccbnkH/Dblg44vmlLd4fm35lTBHH187HqOllMsOgr5LmTJwQs4lhzIeL+JUWK2
         bR0Q==
X-Gm-Message-State: AOAM531tkFTm6HKFFtCBXbV740k6TpU3g8mSOZaJY7TERUcsJ4tzKK2p
        UDddMvEB7vC7sik1qOcUxx4N8gpD4Ubii7iZFuY=
X-Google-Smtp-Source: ABdhPJxwoxFHnuc6/LdoAzSWJ4c7Eojfpft0DVn4cfhFBEeSFuv0diP81L4f9Xx0e2ezS4YW9UEv9T8wxEPbrfDnx48=
X-Received: by 2002:a17:90a:4216:: with SMTP id o22mr24335106pjg.3.1622932263395;
 Sat, 05 Jun 2021 15:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <pull.970.git.1622828605.gitgitgadget@gmail.com>
 <3170f78daa5fa89f04f61e24c9c64c93ea5b394f.1622828605.git.gitgitgadget@gmail.com>
 <CAKiG+9UT+B-kFiY7sA8ZedB31xYARbFgSFwQRzktww_S2B_tfA@mail.gmail.com>
In-Reply-To: <CAKiG+9UT+B-kFiY7sA8ZedB31xYARbFgSFwQRzktww_S2B_tfA@mail.gmail.com>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Sat, 5 Jun 2021 18:30:53 -0400
Message-ID: <CAOjrSZv9h09y-=KVz8UGZaB0r5MHRqFZJjp0VDFX6fnohoFx9Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] cmake: add knob to disable vcpkg
To:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Cc:     Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Danh Doan <congdanhqx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 4, 2021 at 4:55 PM Sibi Siddharthan
<sibisiddharthan.github@gmail.com> wrote:
>
> On Fri, Jun 4, 2021 at 11:13 PM Matthew Rogers via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>
> > -if(WIN32)
> > +
> > +if (WIN32 AND NOT NO_VCPKG)
> > +       set(USING_VCPKG TRUE)
> > +else()
> > +       set(USING_VCPKG FALSE)
> > +endif()
>
> I think it would be better if we could have an option for this knob.
> Maybe like this
>
> option(NO_VCPKG "Don't use vcpkg for obtaining dependencies. Only
> applicable to Windows platforms" OFF)

Option would definitely be the better tool to use here, I just didn't
think about
it when originally writing it, so I'll send a reroll with that and the spelling
corrections suggested by Eric Sunshine.  I assume you'd prefer something
with a final form more like:

option(USE_VCPKG "Whether or not to use vcpkg for obtaining dependencies.
Only applicable to Windows platforms" ON)


>
> I would prefer to use `USE_VCPKG`.
>
> Thank You,
> Sibi Siddharthan



-- 
Matthew Rogers

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF60DC47096
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 04:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACDD4613F3
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 04:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhFFEly (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Jun 2021 00:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhFFEly (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jun 2021 00:41:54 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A93C061766
        for <git@vger.kernel.org>; Sat,  5 Jun 2021 21:39:50 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id b1so5382263vsh.7
        for <git@vger.kernel.org>; Sat, 05 Jun 2021 21:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GPLByMoxOc6dMY7PNtheRJhIYMATCHAQMWI71Azu8eI=;
        b=KChXAjr0ONK/h88Qle+3nfJjDoI/5xzo03Pv4EMpkTVE0Y9HTIy87vLWxonNiFoVX+
         wf/93G5jU2DjrGk7O7SYH4rdQGRDw92fv7z3BUA0AP/VXwMLIVgRdiFYtxGhmsX1E4Cq
         udMkybm9Yi6MNaR2aBfd467qoXJkbpccGutSsvxMC05E0bF7L0Y+FGt/reBlOqc73qq3
         sM/djABO/Xk91WOauDueL8TvXSEpa/F1ZyFIrhowu+1DQJseST3RAAa4/tZAXG1pIw/P
         +U7oDaXFq1VHVw9409VeqHOT0JU9BrMaT8GsT+IUxfpZKssMhPTj0VnHxb25+AIeGPeb
         SROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GPLByMoxOc6dMY7PNtheRJhIYMATCHAQMWI71Azu8eI=;
        b=NtRN94q/6pN3KA06/cjtkdjhENtc9T0jciLX8TzFXNbpoXXeEFmuJEk8ROvNwGKZs+
         /PjLm93TUynj4tDDJNxIwzUeD/LcUHpF7MuGcRfehn8hAv0P9xNOU1bdLo+RLqZVDNW2
         drDRehe/mjziiBzXbu8DTb65dpYhZDu3JT0QOoF1R3UgO2ZN6OiJbU506wWXo0pkkV9z
         6zCRwoyCn2WrLs0rBy1eh41ibQ1nbH9Pehryj+JnxQJ5g8wOxF0bmdKLAWkNy7RoOw15
         Lo6qf37VkLxvvQGr44ckygsoB1sHydWiRGaO+WScsqq6dNEoWbBLNFeT4QG8lkZ7AaPY
         vQMw==
X-Gm-Message-State: AOAM533ts72nuxqU7u4cL3Hi0nyTsWG9F/SiOB/DzuHLV+KGyiQNX87T
        pvC25GjkDBiS/YTOIoucEnpIDjfaAPYZQiIb5jA=
X-Google-Smtp-Source: ABdhPJy8neESDbn5BKf1IkCUD0h2LocmaswXkqQrkeYBEiOmo63oYLDmwhEDZhspjRqegdGjEFZesUi2WWg80ugaxO8=
X-Received: by 2002:a05:6102:2008:: with SMTP id p8mr6417795vsr.53.1622954389095;
 Sat, 05 Jun 2021 21:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.970.git.1622828605.gitgitgadget@gmail.com>
 <c3bf266cf03a9678933623b48927ee749956218d.1622828605.git.gitgitgadget@gmail.com>
 <CAKiG+9W8Da4bG87VjTKN6m=cX+v_x33YAw8p4MqCfmNinYt1XA@mail.gmail.com> <CAOjrSZsyUi+RAqxXyd6JqzWqO8hMdtwTuWpZy+cKbz654Xu45A@mail.gmail.com>
In-Reply-To: <CAOjrSZsyUi+RAqxXyd6JqzWqO8hMdtwTuWpZy+cKbz654Xu45A@mail.gmail.com>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Sun, 6 Jun 2021 10:09:38 +0530
Message-ID: <CAKiG+9U2tXu+k+oEx-fx9tjTYEdrL_Nf3Cxk14=ik1Ji8ZUehg@mail.gmail.com>
Subject: Re: [PATCH 2/3] cmake: create compile_commands.json by default
To:     Matt Rogers <mattr94@gmail.com>
Cc:     Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Danh Doan <congdanhqx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 6, 2021 at 4:06 AM Matt Rogers <mattr94@gmail.com> wrote:
>
> On Fri, Jun 4, 2021 at 5:09 PM Sibi Siddharthan
> <sibisiddharthan.github@gmail.com> wrote:
> >
> > On Fri, Jun 4, 2021 at 11:13 PM Matthew Rogers via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> > >
> > > A straightforward way to accomplish this is to make it as simple as
> > > possible is to enable the generation of the compile_commands.json file,
> > > which is supported by many tools such as: clang-tidy, clang-format,
> > > sourcetrail, etc.
> > >
> > > This does come with a small run-time overhead during the configuration
> > > step (~6 seconds on my machine):
> > >
> > >     Time to configure with CMAKE_EXPORT_COMPILE_COMMANDS=TRUE
> > >
> > >     real    1m9.840s
> > >     user    0m0.031s
> > >     sys     0m0.031s
> > >
> > >     Time to configure with CMAKE_EXPORT_COMPILE_COMMANDS=FALSE
> > >
> > >     real    1m3.195s
> > >     user    0m0.015s
> > >     sys     0m0.015s
> > >
> > > This seems like a small enough price to pay to make the project more
> > > accessible to newer users.  Additionally there are other large projects
> > > like llvm [2] which has had this enabled by default for >6 years at the
> > > time of this writing, and no real negative consequences that I can find
> > > with my search-skills.
> > >
> >
> > The overhead is actually much smaller than that. In my system it is
> > less than 150ms.
>
> Is that 150 ms for the whole process or just the difference between the two
> options?  I'm running this on windows via the git bash provided by the
> git sdk.

The difference between the two. Without exporting compile_commands.json
it takes around 650ms, with it around 750ms.
NOTE: This is for subsequent CMake runs. (Excludes the initial run)

Thank You,
Sibi Siddharthan

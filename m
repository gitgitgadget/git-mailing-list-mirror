Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7795BC4743D
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 18:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 629DA6140B
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 18:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhFDSgZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 14:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbhFDSgX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 14:36:23 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46D9C061766
        for <git@vger.kernel.org>; Fri,  4 Jun 2021 11:34:23 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id e22so8538712pgv.10
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 11:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uTaCml9DXgTOJUqMNehBcYgaJkne8Nd+fABUNY06jCs=;
        b=qJAQevl46uyUvggOfnB7T8cZx+pEY8OgVw9icMCgkim46yAIYxqLk5Gnnj2jg2P5Pk
         r8OukrlWxxPQ6QsAVlrDYi0FUfmGdbko36LgEXaL+CN8Nznu37vsTy5kCytGYn6tzx05
         8vwJdVWmyzrm9ajztKxJMOv1fWWLqhF3PYdVHEuht2EkS208TpHTOg3uKlxFNyempkpY
         0xcB+rSdtYLJx7cvN1IWhSpaK/loQxPeo+tDfBrpARAWegiUPDN3A02amrEMciPBkHfC
         I0prm1TeekcF+FfIjDO0HRkfkTiZu3BmD0QpQ1DGtWZT4EB6FnXU2LKiJx7NOoZPGCU+
         aXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uTaCml9DXgTOJUqMNehBcYgaJkne8Nd+fABUNY06jCs=;
        b=gA7Afh8zwe51ZJI5qs9CAYygtiEWXy1+FiBKOr1JjS1zBlip09muW/dt0GnQmIcRDx
         iP9gJe46k2hKFpVMMtN1HhasknLMtQyOmvdRGkTuob47CSRuHZ9AMpXOqjOVery6JJwm
         DWFr327kI0I5vVW3s/IT/e6yPa9k6zFplhy/qkR6gXxlJMamGRd7CiQOddgnqpAWzXhX
         KHAQqYnPho0i0fvyIeLEOckRoINay7FQypg4DqBMbYf3qG1s15vtEhautXX4U4UpArju
         T5BxtY/X1EMk74o0XsVe+OCCg38kisdLWwQql745hGFxCjp1DnPh76p8miefJYMvkWt7
         xpgg==
X-Gm-Message-State: AOAM531Q9OVFfdc7ipbdf5UJ2vHEIeO85F1VzO7TEFJQV0jbn3AXgzIN
        UqrcrL/uqprtzIFtbznin5ESWlQSOt1S4oPX3jU=
X-Google-Smtp-Source: ABdhPJxXUpTFvPLc8NFNXrIYobvw3kREz6YUUrL3ARbRjNiZynJ3iyMDQS1+aD3vgqjt1OvNhHmWTZXerTdIiv5BJ5w=
X-Received: by 2002:a63:ee53:: with SMTP id n19mr6393608pgk.268.1622831660029;
 Fri, 04 Jun 2021 11:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <pull.970.git.1622828605.gitgitgadget@gmail.com>
 <3170f78daa5fa89f04f61e24c9c64c93ea5b394f.1622828605.git.gitgitgadget@gmail.com>
 <CAPig+cRBQYbhPbvGvEcmqUFmXM4yysRnWam=Sx_Lr8uWbEZVMg@mail.gmail.com>
In-Reply-To: <CAPig+cRBQYbhPbvGvEcmqUFmXM4yysRnWam=Sx_Lr8uWbEZVMg@mail.gmail.com>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Fri, 4 Jun 2021 14:34:08 -0400
Message-ID: <CAOjrSZuO14F2ShmfYeTdf39YOhWDJWFm2PQtXR5abJh5FsigYw@mail.gmail.com>
Subject: Re: [PATCH 1/3] cmake: add knob to disable vcpkg
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Danh Doan <congdanhqx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 4, 2021 at 2:03 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Fri, Jun 4, 2021 at 1:44 PM Matthew Rogers via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > When building on windows users have the option to use vcpkg to provide
> > the dependencies needed to compile.  Previously, this was used only when
> > using the Visual Studio generator which was not ideal because:
> >
> >   - Not all users who want to use vcpkg use the Visual Studio
> >     generators.
> >
> >   - Some versions of Visual Studio 2019 moved away from using the
> >     VS 2019 by default, making it impossible for Visual Studio to
> >     configure the project in the likely event that it couldn't find the
> >     dependencies.
>
> Is there something missing between "using the" and "VS 2019"? I'm
> having a hard time trying to understand what this bullet point is
> saying due to this apparent gap.
>

Yeah, this should really read
- Some versions of Visual Studio 2019 moved away from using the
     VS 2019 _Generator_ by default, making it impossible for Visual Studio to
     configure the project in the likely event that it couldn't find the
     dependencies.


> >   - Inexperienced users of CMake are very likely to get tripped up by
> >     the errors caused by a lack of vcpkg, making the above bullet point
> >     both annoying and hard to debug.
> >
> > As such, lets make using vcpkg the default on windows.  Users who want
> > to avoid using vcpkg can disable it by passing -DNO_VCPKG=TRUE.
>
> s/lets/let's/
>
> > Signed-off-by: Matthew Rogers <mattr94@gmail.com>



-- 
Matthew Rogers

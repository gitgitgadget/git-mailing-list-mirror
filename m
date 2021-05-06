Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399A5C433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 21:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6288613B5
	for <git@archiver.kernel.org>; Thu,  6 May 2021 21:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhEFVg4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 17:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhEFVg4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 17:36:56 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A66C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 14:35:57 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id q7-20020a9d57870000b02902a5c2bd8c17so6211516oth.5
        for <git@vger.kernel.org>; Thu, 06 May 2021 14:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+N9BGgYDZeHSRLhCuyt7sizaKVOK/yY7lvZEsu7mn58=;
        b=kAiXGixnYTOl1InSUidsaMcQ+xjdMZsg42nvG4tZpWqBtxsB3FKpY/+zoWaT45nXSv
         AevJ2xg+LJVRXn0Mrs5+8160iszdDNaiDWbJy+b9Oak+voAnDPN5hSG8dXCPqEKXhk9G
         PFB4FDBKrenAWgPaF92Mcgwdl6EDoDl0zRtFsu9TjoYqq/wPmrePv5N7MZvPKgkJk41F
         Mn6Mj//AhaIaOKnMmil5v+C/TSXQYAT0Hx9co7OERYA1QmE6g2HUZJE6g0DgpR19DiLU
         K2owAXRDrW2MVzvwITC4GB621URSTJY59qpIs9/F1fQHdTQQvlOLi2bAzO2fXD1dNwGI
         Jwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+N9BGgYDZeHSRLhCuyt7sizaKVOK/yY7lvZEsu7mn58=;
        b=OAtX59DXZxNdx0TJkkQ2LRi6SN0JVI83zo3lurENsvPyxE4Yk8in9fh/S3ASsjTEO7
         721OoqHNBfMxgkXV81FelW+74Xf0ibVYAApsALTKoZvAuTVwEK1V2/S+pWcmnjcVwSKS
         mlD8IkXYy4Ru8kvuQZnLLoigefF3No9XQlxQl6njfRws/rUPiw1IqNohkprP4WfVFvvQ
         FgjQO6xONO0QJrKJAovio7swYo2Jc3QPn6H3kOSdEA7ho1/sd6plyl9ei9x3pDc9avEp
         JuzsR2bFubpsvNY0N7rEtd4SxdMNq7U9WglBxq1byQpNJH6HoT8osoZ9IxmH7U9JTAAq
         SQ1A==
X-Gm-Message-State: AOAM533GgaI4tBnCP8Wsm2fHo38fE4sNn2B0Pz4ShzoyZZeAePr9tbjo
        aXk63e0u04komL9GSawU6q4wjvHmc+plgohUpW8=
X-Google-Smtp-Source: ABdhPJxOWkfLX7IoyIzZfY4fkFgt7B506WxtMzxN6ED2I6JFXZa/ue0GUfRHMeK4oEasDwWN99/q2EHOlx5rc0vhgHg=
X-Received: by 2002:a05:6830:108d:: with SMTP id y13mr5352958oto.162.1620336956882;
 Thu, 06 May 2021 14:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <4f88ac58e46782c7cf335e13fabd14c8b4438267.1620329445.git.matheus.bernardino@usp.br>
 <YJRLim10cznG5G3d@coredump.intra.peff.net>
In-Reply-To: <YJRLim10cznG5G3d@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 6 May 2021 14:35:45 -0700
Message-ID: <CABPp-BGj5AmWrQLfU7u1MZbcjGiytCMkAXwutEZG1tjfJYWDTQ@mail.gmail.com>
Subject: Re: [PATCH] clean: remove unnecessary variable
To:     Jeff King <peff@peff.net>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 6, 2021 at 1:03 PM Jeff King <peff@peff.net> wrote:
>
> On Thu, May 06, 2021 at 04:33:15PM -0300, Matheus Tavares wrote:
>
> > The variable `matches` used to hold the return of a `dir_path_match()`
> > call that was removed in 95c11ecc73 ("Fix error-prone fill_directory()
> > API; make it only return matches", 2020-04-01). Now `matches` will
> > always hold 0, which is the value it's initialized with; and the
> > condition `matches != MATCHED_EXACTLY` will always evaluate to true. So
> > let's remove this unnecessary variable.
> >
> > Interestingly, it seems that `matches != MATCHED_EXACTLY` was already
> > unnecessary before 95c11ecc73. That's because `remove_directories` is
> > always set to 1 when we have pathspecs; So, in the condition
> > `!remove_directories && matches != MATCHED_EXACTLY`, we would either:
> >
> > - have pathspecs (or have been given `-d`) and ignore `matches` because
> >   `remove_directories` is 1; or
> >
> > - not have pathspecs (nor `-d`) and end up just checking that
> >   `0 != MATCHED_EXACTLY`, as `matches` would never get reassigned
> >   after its zero initialization (because there is no pathspec to match).
>
> Thanks for this digging and the extra analysis. We can see from the
> patch that this variable can't possibly be doing anything, but it is
> always a comfort to see authors researching the source of the oddity and
> explaining what they found.
>
> I'm adding Elijah to the cc as an area expert, just in case he has any
> other insight.

Thanks for catching this Matheus, and digging in a bit on the
analysis.  This change looks good to me:

Reviewed-by: Elijah Newren <newren@gmail.com>


>
> > diff --git a/builtin/clean.c b/builtin/clean.c
> > index 995053b791..f6d7e8119c 100644
> > --- a/builtin/clean.c
> > +++ b/builtin/clean.c
> > @@ -1003,7 +1003,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
> >
> >       for (i = 0; i < dir.nr; i++) {
> >               struct dir_entry *ent = dir.entries[i];
> > -             int matches = 0;
> >               struct stat st;
> >               const char *rel;
> >
> > @@ -1013,8 +1012,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
> >               if (lstat(ent->name, &st))
> >                       die_errno("Cannot lstat '%s'", ent->name);
> >
> > -             if (S_ISDIR(st.st_mode) && !remove_directories &&
> > -                 matches != MATCHED_EXACTLY)
> > +             if (S_ISDIR(st.st_mode) && !remove_directories)
> >                       continue;
> >
> >               rel = relative_path(ent->name, prefix, &buf);
>
> Definitely not necessary, but on a patch like this I'll sometimes
> manually specify "-U4" (and I always have diff.interhunkcontext set to
> "1") to show the complete code between the declaration and use. It makes
> it even more obvious that the result is correct (though obviously
> applying and compiling shows it, too). #gitlifehacks
>
> -Peff

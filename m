Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5434CC35240
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 02:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142C22083E
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 02:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOdg+Za1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgA0CWP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jan 2020 21:22:15 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35064 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgA0CWO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jan 2020 21:22:14 -0500
Received: by mail-ed1-f68.google.com with SMTP id f8so9270541edv.2
        for <git@vger.kernel.org>; Sun, 26 Jan 2020 18:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vTYicT+YDWdyQUBMlq3WumfypRZTc7F5uTx3vTc8WjI=;
        b=HOdg+Za1cyljMfV1sTDZNgX7VAutxZOQfcxOUEtmyCIuwb8JxD790xY8zjCaCo2Bsc
         69R+PQ1YDUBHuoucDtu2EdJ8SVL9+IJyQ+B8yEMZJVyhQaVqKQV9bJoKU7JlHQoTfwmP
         tfCI5AvdjpfehbvQ59c98lB4xJNDGR54j6xBgVbhuQRpeQsVo+gxAwqjQ9Z48V3rEl/B
         q1+62kuLeIQTxF//6LmR67tDy9UR/D7Ch+eiXc17mbHBfj7c45O5JeqG3RFyJeVM/rmS
         enw5uzZ74glvt8tXQTMLODJXYd6NZl+M4XriM1ZolqTdIBfwU1fm2K3C/Iri1jJYmqfC
         otaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vTYicT+YDWdyQUBMlq3WumfypRZTc7F5uTx3vTc8WjI=;
        b=HFaVDLabgUfEFyYRnzf72q0HxgPfz1/5/e8w6mB57S8l43hPmChsvk5Hqk0rTjOD6z
         nZnyOsGYC/wzkbsajdOzBfhPLNcHW6mS9/p81LPfvYL7/3SCjECYxEnohREjrK+BPl+R
         0VFySu07u1SJbhgoVQJ0txvfBBp5WcjPs7z4Tt2+M1J6udLYxO8IF5uUeaZKxYfM9B99
         tXFPdlVVg6gDlyOiLd5noS5SWp4X5Xgw6Q8JitDwoRYFBob+q8v3Fu8Oww8yQILBSarR
         GNqx09E7R3SGKHTHF6BFWNvGP4PdhIP6JjY0I9kSl7BBu/T7ayyyWmyjefyPN9OTO+Z7
         /D3Q==
X-Gm-Message-State: APjAAAWjkY+48WE1xoS+sy6tOHjhwtd+Umgk57tvSxbX3Bfo2ThsYb3g
        9DE4+AoddMx4GhnZujPlMGWG6iinSgSRpXsk4bA9l8Su
X-Google-Smtp-Source: APXvYqymw1DHS8dz3izF64aHTE97Bxxl+95WiZSOi51m1BesGqfox3HmUJ1+kCRP+QwFgfBMPs/ha7LZzA2iQ+rx7uE=
X-Received: by 2002:a17:907:375:: with SMTP id rs21mr11824912ejb.352.1580091733180;
 Sun, 26 Jan 2020 18:22:13 -0800 (PST)
MIME-Version: 1.0
References: <pull.537.git.1579745811615.gitgitgadget@gmail.com> <xmqq1rrq65ed.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq1rrq65ed.fsf@gitster-ct.c.googlers.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Mon, 27 Jan 2020 15:22:01 +1300
Message-ID: <CACg5j260t0Q1=5i_The5ARN0qRTDKiwmH-KYN5KqHye+Y_9gig@mail.gmail.com>
Subject: Re: [PATCH] git: update documentation for --git-dir
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 23, 2020 at 7:41 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> It is not "not be able to figure out".  Specifying GIT_DIR (either
> with environment or the --git-dir option) tells Git that the $cwd is
> the top of the working tree unless otherwise specified (e.g. with
> GIT_WORK_TREE environment).  If you have to say something, saying
> "When GIT_DIR is specified, the usual repository discovery is
> skipped and the current directory is taken as the top level of the
> working tree unless otherwise speciffied" is probably OK.
>

Ok, I didn't understand it as intentional before, will update that.

> > +     Set the path to the repository (i.e. the .git folder). This can also be
>
> I suspect (i.e. ".git") may be clear enough, but if you must, say
> ".git directory", not ".git folder", as you mention "current working
> directory" later.
>

Fair enough.

> > +     It's preferrable to set --work-tree=<path> as well when setting
> > +     --git-dir to make sure Git will run your command across the correct
> > +     work tree.
>
> It does not help the readers that much to say "It's preferrable"
> without saying what negative implications there are if they don't
> use it, or what positive effect they would observe if they do.

I agree, I couldn't find enough information on the matter to elaborate more.

> If I were writing it, I'd drop "Note that..." and rewrite the three
> lines more like...
>
>         Specifying the location of the ".git" directory using this
>         option (or GIT_DIR environment variable) turns off the
>         repository discovery that tries to find a directory with
>         ".git" subdirectory (which is how the repository and the
>         top-level of the working tree are discovered), and tells Git
>         that you are at the top level of the working tree.  If you
>         are not at the top-level directory of the working tree, you
>         should tell Git where the top-level of the working tree is,
>         with the --work-tree=<path> option (or GIT_WORK_TREE
>         environment variable)
>
> perhaps.

That helped me understand it better also, will use this, thanks.

>
> >  --work-tree=<path>::
> >       Set the path to the working tree. It can be an absolute path
> >       or a path relative to the current working directory.
> >
> > base-commit: 232378479ee6c66206d47a9be175e3a39682aea6
>
> I do not know if GGG users have control over this, but I'd prefer to
> see a "-- " divider before this "base-commit: ..." footer material.

No I don't think I can change this one.

Thanks,
Heba

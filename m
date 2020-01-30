Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A47C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 17:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD5E20663
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 17:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJ6y3NDr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbgA3Rps (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 12:45:48 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41408 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbgA3Rpr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 12:45:47 -0500
Received: by mail-oi1-f196.google.com with SMTP id i1so4329189oie.8
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 09:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nHsbAmxInfypNEFlCkKLP2KqL6FOcR3rhRfgf7MbDWI=;
        b=GJ6y3NDrYEeZPTX63gytgI4ogLKO8GXpnLBTH6yOachqC3nxtCAwVN8ouzqIUKnpHc
         E72mLEHn5CUl8cT3S2VjN95Q0hPTcA0I6yetCyzqbyKia1SHTa2110RCaZ2KDUcY2uOM
         rjzdgD82EFF+H5hR/AyNMjYojlG1xRXehQnScbjjeEVATT435fPRYIGzdrm++H/gU9Qu
         OlYEL0Wpij6iBFJdJJYBrb+XCmfztgL0h2y1++Lgx06s6IBpUQm4Tam2Fu97JpWEHYWd
         Ol/rs0TBU4pUZmhxTqp3cBAN6tSyvENInupPfEbWZpJAw/63LbH2Wd5Qj1vs6FKoOiT3
         tseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nHsbAmxInfypNEFlCkKLP2KqL6FOcR3rhRfgf7MbDWI=;
        b=jWUUnK7npDpKmyRvafRNLFfiY+d7DgY5pVZNpEuTUYYYVq/7FHIKM8agIBS12xnGBv
         WPuy/EayffnTJgREsGn2/rLu/Gp56unXtXRWNoTg4PvfE9j+HsB7mtW3eQ8RbobM2hfM
         zXkSIHS8mDbO+ZeTMcwqCoJ/P8PHP6jJBNmhC8ahePFyU1gNvzRHuwUublDZf1e8bfUe
         YNg6Cl6kQSbW6YInoScRuf3b62XbyJN3aAbQKWV8NeGNyg46ygMhqICNgNnFtc+57mrn
         3Kvp6DdEcZDLPm7517NTjnvp/vos5x6PCsLTFqAF88uepgwSwQB5m1BWycTnkAULAM4l
         E9nw==
X-Gm-Message-State: APjAAAV/i0jy9JXnKfPLPLUl2E3bAKhko82cAHprFV8lLQ3PgO8btjHA
        Qo7mRFCK42Y7P7vThxpbdjz5KanC1kpht1i/Vtc=
X-Google-Smtp-Source: APXvYqzZyPXsYoeF4/W6VbE1pGabvN9l2e2XIstZeybirYiKQGtAHx3/C0fx8bM4rKMneOQDgnMcNsWp7B9QU8xl6Mk=
X-Received: by 2002:aca:5588:: with SMTP id j130mr3541644oib.122.1580406346558;
 Thu, 30 Jan 2020 09:45:46 -0800 (PST)
MIME-Version: 1.0
References: <pull.700.git.git.1580335424.gitgitgadget@gmail.com>
 <40b378e7adbbff5ecfd95fd888465fd0f99791c8.1580335424.git.gitgitgadget@gmail.com>
 <59b5b766-29e2-a709-b407-56bf6ea60b47@gmail.com> <CABPp-BEQ5s=+6Rnb-A+pdEaoPXxfo-hMSegSe1eai=RE74A3Og@mail.gmail.com>
In-Reply-To: <CABPp-BEQ5s=+6Rnb-A+pdEaoPXxfo-hMSegSe1eai=RE74A3Og@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 30 Jan 2020 09:45:35 -0800
Message-ID: <CABPp-BHR7mFP1rKJ6UBETHbv+R6GbDKO8wA31RJ7f4VqpJ77DQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] dir: replace exponential algorithm with a linear one
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Martin Melka <martin.melka@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Kevin.Willford@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 30, 2020 at 9:13 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Thu, Jan 30, 2020 at 7:55 AM Derrick Stolee <stolee@gmail.com> wrote:
[...]
> > > @@ -1713,18 +1719,101 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
> > >
> > >       /* This is the "show_other_directories" case */
> > >
> > > -     if (!(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
> > > +     /*
> > > +      * We only need to recurse into untracked/ignored directories if
> > > +      * either of the following bits is set:
> > > +      *   - DIR_SHOW_IGNORED_TOO (because then we need to determine if
> > > +      *                           there are ignored directories below)
> > > +      *   - DIR_HIDE_EMPTY_DIRECTORIES (because we have to determine if
> > > +      *                                 the directory is empty)
> >
> > Perhaps here is where you could also have a DIR_LIST_ALL_UNTRACKED
> > flag to ensure the untracked cache loads all untracked paths?
>
> Do you mean DIR_KEEP_UNTRACKED_CONTENTS (which is documented in dir.h
> as only having meaning when DIR_SHOW_IGNORED_TOO is also set, and thus
> caused me to not list it separately)?
>
> Speaking of DIR_KEEP_UNTRACKED_CONTENTS, though, its handling as a
> post-processing step in read_directory() is now inconsistent with how
> we handle squashing a directory full of ignores into just marking the
> containing directory as ignored.  I think I should move the
> read_directory() logic for DIR_KEEP_UNTRACKED_CONTENTS to
> treat_directory() and use another counter similar to old_ignored_nr.
> It should be more efficient that way, too.

Oh, actually, I think I understand what you're getting at so let me
clear it up.  With DIR_SHOW_IGNORED_TOO, we always recurse to the
bottom, because it's needed to find any files that might be ignored.
(Maybe we could do something clever with checking .gitignore entries
and seeing if it's impossible for them to match anything below the
current directory, but the code doesn't do anything that clever.)  As
a side effect, we'll get all untracked files whenever that flag is
set.  As such, the only question is whether we want to keep all those
extra untracked files that we found or not, which is the purpose of
DIR_KEEP_UNTRACKED_CONTENTS.  Without DIR_SHOW_IGNORED_TOO, there's no
need or want to visit all untracked files without also learning of all
ignored files (and, in fact, git-clean is currently the only one that
wants to know about all untracked files).

As far as a simple test goes, in a simple repository with a file named
   one/two/three/four/five/untracked-file
and with nothing else under one/:

Before my changes:
    $ strace -e trace=file git status --ignored 2>&1 | grep
'open("one/' | grep -v gitignore.*ENOENT | wc -l
    62
Note that 62 == 2^5 + 2^4 + 2^3 + 2^2 + 2^1, showing how many
directories we open and read.

After my changes:
    $ strace -e trace=file git status --ignored 2>&1 | grep
'open("one/' | grep -v gitignore.*ENOENT | wc -l
    5
showing that it does open and read each directory, but does so only once.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF0331F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 08:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeKKSbH (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 13:31:07 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:35334 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbeKKSbH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 13:31:07 -0500
Received: by mail-vs1-f67.google.com with SMTP id e7so3455523vsc.2
        for <git@vger.kernel.org>; Sun, 11 Nov 2018 00:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6DFUQhbWnU62rU7i91X31h6vt/jy2evzL8M5lSN6cMs=;
        b=Lrw5hB6hrQ+FeXgZHKra/bW8DlPK5ZIdl0u453E4O4SP59Xix8BsatT+DFuDfgRlCR
         pGQlo4BPfbjG9khkvuu6FpdK0MvhCvRgCx/4v5/SkNfXoyt3FHaaHeS/nk1v9jPkPkvT
         T78E1IUcBk6opiHtos65zvoNZknNf9v9zl9yLLYpKUMrYYL1euI2NVWWmA/Z0CEKINtg
         cwLx8AYYaIv6l6hhOTy0jRIgGVj/s616aYAGoG3VAIxEkxIKzTVzIVkwIwA4D0PTrZDj
         Hhb9TIjd3ZnYk6n9hSmQT74zDB0hm6MtPW865C727uj9kk4ynriEtCwmH5EYVyVCNSdY
         ul1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6DFUQhbWnU62rU7i91X31h6vt/jy2evzL8M5lSN6cMs=;
        b=YLa7i4R+38ng6p7KcgWcFunQ7SRcvis3hkenXvRwIIfV2VjFUzJZQ4rhPhQ83IMsRQ
         WQB0OzQXIJj0Av9Mu5UJYYh6PxNiJekk2mNTbJdiw7dYecAxyvZj7+wt4/E3tDra0d+t
         vy+yan8nKzXGlhEbhjFykGd09Dlz9FxjOotc41PaMvHZcJ54v0kw3waSxRM0g47/ReWm
         rizm9MieHdFlHlqdIsQbDakIKyW9EHnWB2vKT4baQMm6Ig+JFgvfzzC2NNGVP0t8SNUF
         4nmwwF1jmTqF/hL3kCzvHeAMVreeiqwi+FIi6+SKJYx28LeqU8yO01bQ7kGQ0tN9mMdn
         x6Ww==
X-Gm-Message-State: AGRZ1gK739+50x/vjW7FRGWjyl0tta/O1VjjjHRN7l1IdTXtV/49hnbV
        1m6tKG7z0XCMebcxrsB0hdMPuk7sPdlQY93FoLY=
X-Google-Smtp-Source: AJdET5fgTDYjHZqGwAaoP2fvtF87jF4J8R97RYNcAG2HUDNyJDBOCu2boM1Z7xJHEZbtwf18WePQrg/rn1ZzYGD3+74=
X-Received: by 2002:a67:3edc:: with SMTP id a89mr6556490vsi.136.1541925789345;
 Sun, 11 Nov 2018 00:43:09 -0800 (PST)
MIME-Version: 1.0
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com> <20181111062312.16342-11-newren@gmail.com>
 <20181111072356.GJ30850@sigill.intra.peff.net>
In-Reply-To: <20181111072356.GJ30850@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Sun, 11 Nov 2018 00:42:58 -0800
Message-ID: <CABPp-BGREOAvF-6DBymdwsUL2LpyPNqy8dCw0RuUKZf2Da6cJA@mail.gmail.com>
Subject: Re: [PATCH 10/10] fast-export: add --always-show-modify-after-rename
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 10, 2018 at 11:23 PM Jeff King <peff@peff.net> wrote:
>
> On Sat, Nov 10, 2018 at 10:23:12PM -0800, Elijah Newren wrote:
>
> > fast-export output is traditionally used as an input to a fast-import
> > program, but it is also useful to help gather statistics about the
> > history of a repository (particularly when --no-data is also passed).
> > For example, two of the types of information we may want to collect
> > could include:
> >   1) general information about renames that have occurred
> >   2) what the biggest objects in a repository are and what names
> >      they appear under.
> >
> > The first bit of information can be gathered by just passing -M to
> > fast-export.  The second piece of information can partially be gotten
> > from running
> >     git cat-file --batch-check --batch-all-objects
> > However, that only shows what the biggest objects in the repository are
> > and their sizes, not what names those objects appear as or what commits
> > they were introduced in.  We can get that information from fast-export,
> > but when we only see
> >     R oldname newname
> > instead of
> >     R oldname newname
> >     M 100644 $SHA1 newname
> > then it makes the job more difficult.  Add an option which allows us to
> > force the latter output even when commits have exact renames of files.
>
> fast-export seems like a funny tool to look up paths. What about "git
> log --find-object=$SHA1" ?

Eek, and give me O(N*M) behavior, where N is the number of commits in
the repository and M is the number of renames that occur in its
history?  Also, that's the inverse of the lookup I need anyway (I have
the commit and filename, but am missing the SHA).

One of the problems with filter-branch that people often run into is
they know what they want at a high-level (e.g. extract the history of
this directory for a new repository, or rewrite the history of this
repo to appear at a subdirectory so it can be merged into a bigger
repo and people passing filenames to log will still get the history of
those files, or I want to remove some of the big stuff in my history),
but often times that's not quite enough.  They need help finding big
objects, or may be unaware that the subset of files they want used to
be known by alternative names.

I want a simple --analyze mode that can report on all files that have
been renamed (so users don't just say "all I care about is these N
files, give me a rewritten history just including those" -- we can
point out to them whether those N files used to be known by other
names), as well as reporting on all big files and if they've been
deleted, and aggregations of the "big files" information across
directories and file extensions.

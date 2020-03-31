Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC1BC43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 16:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7B12137B
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 16:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6+F751O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbgCaQtA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:49:00 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42587 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730413AbgCaQtA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 12:49:00 -0400
Received: by mail-oi1-f195.google.com with SMTP id e4so19483934oig.9
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 09:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uNEMpmb9am3kLUNX1N+1ixftYdutH3nwyKzMbKOTREQ=;
        b=Y6+F751O2Y5jKEdmSaVzVzlKKfDULV+9Ky+1axCCAVNhesZp9H48pQ375eRnxRWrr4
         cb1o7qgWDWPEnNOhHqfAO0na9nwSzJ/7go+RLZsYIvyADRqjF1o70GZFMtXH6IyKFyOG
         GSwNFkoLu6PzAfDPklj0HQzOcsqRW/WBeEQryLsRFM2MsUzdEOPw7ToHI3VnNWzTQNlI
         GBTYEFYhEvAiApwUkYfubjxORF67EjXQ3Wzq3kFqwlPObyvUcsLwkhtTtHgU7GPqP9U+
         bWzL4YgO8igQJEYnIxaT50YJWLYAM9mkrO46Db1V8B7kIYw08ruj9ObxSZKFezFvU4Ws
         sJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uNEMpmb9am3kLUNX1N+1ixftYdutH3nwyKzMbKOTREQ=;
        b=bqxnV3JF2d6A7ZTZ9z206hDajjL3+Q2qClcfF2fsiO0mVPW8zRLIP0HGeUqsupCDvQ
         vd7GfGj0JK30BaLYCJEoHqgxBX7EnbVAlWPfxGW6rqDqbVW1Gdn9kkhaI6tRSzF5PI7c
         TlBQMoHvt6rFZZWZgl2x5bMSGUEESEqJGorGxwzfR/vhf9fD90DqUMEKq38n2fBPQtJU
         DfwGi9xe3wH7EBb9+lrWh0V6ZIeLB9l8Byc5msKuoIaxCwLyxau9IVJY9YwI4nCLTaSY
         XakERITVgvdt/FcoaRkT1mNQjPWp7+foqhX+AbpKlrmwGF0X+A8eHFQFzBw6kZKTPpOY
         J6Sw==
X-Gm-Message-State: ANhLgQ0ig2qBgiIcJqzgwcXkHpBQ2jjWEnE/MN3/adIUe8xDxz0B9yM0
        BqnWWOLxZDdY8osi5ZvfE1i6xm4yb01WNfKQ0To=
X-Google-Smtp-Source: ADFU+vuKyt/4ysKiADcVMN7XdeQdBscGh5Lq3H7hHvuDvZedTsK4TDC8AZvK5+VikIbtJJLZoDLjk2mlOTp590ybz2w=
X-Received: by 2002:aca:4b84:: with SMTP id y126mr2631821oia.31.1585673338715;
 Tue, 31 Mar 2020 09:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585027716.git.matheus.bernardino@usp.br>
 <a76242ecfa69cf29995bd859305dc2ab1bc1a221.1585027716.git.matheus.bernardino@usp.br>
 <CABPp-BEbNCYk0pCuEDQ_ViB2=varJPBsVODxNvJs0EVRyBqjBg@mail.gmail.com>
 <CAHd-oW6ANf_iNmYkgXt4jo1seB-AEx1TSH384v+oh1bicG8RDA@mail.gmail.com>
 <CABPp-BGVO3QdbfE84uF_3QDF0-y2iHHh6G5FAFzNRfeRitkuHw@mail.gmail.com> <CAHd-oW6_KuHtNN2qJrkqYSuCF665AuE3mO6YEbmPdtRiq-EbXQ@mail.gmail.com>
In-Reply-To: <CAHd-oW6_KuHtNN2qJrkqYSuCF665AuE3mO6YEbmPdtRiq-EbXQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 31 Mar 2020 09:48:47 -0700
Message-ID: <CABPp-BEQunNsBffa8pbqC-BoRQ6C6HfY12m4VT7eH86=HCMi8w@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] grep: add option to ignore sparsity patterns
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 29, 2020 at 6:13 PM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> On Thu, Mar 26, 2020 at 3:02 AM Elijah Newren <newren@gmail.com> wrote:
> >
> > Hi Matheus!
>
> Hi, Elijah.
>
> First of all, thanks for taking the time to go over these topics in
> great detail. I must say it's much clearer for me now.
>
> > On Wed, Mar 25, 2020 at 4:15 PM Matheus Tavares Bernardino
> > <matheus.bernardino@usp.br> wrote:
> > >
> [...]
> > One more useful case to consider before we start adding SKIP_WORKTREE
> > into the mix.  Let's say that you have three files:
> >    fileA
> >   fileB
> >    fileC
> > and all of them are tracked.  You have made edits to fileA and fileB,
> > and ran 'rm fileC' (NOT 'git rm fileC', i.e. the deletion is not
> > staged).  Now, you run 'git grep mystring'.  Quick question: Which
> > files are searched for 'mystring'?  Well...
> >   * REVISION and --cached were left out of the git grep command, so
> > working tree files should be searched, not staged versions or versions
> > from other commits
> >  * No flags like --untracked or --no-exclude-standard were included,
> > so only tracked files in the working tree should be searched
> >   * There are two files in the working tree, both tracked: fileA and fileB.
> > So, this searches fileA and fileB.  In particular: NO VERSION of fileC
> > is searched.  fileC may be tracked/cached, but we don't search any
> > version of that file, because this particular command line is about
> > searching the working directory and fileC is not in the working
> > directory.  To the best of my knowledge, git grep has always behaved
> > that way.
> >
> > Users understand the idea of searching the working copy vs. the index
> > vs. "old" (or different) versions of the repository.  They also
> > understand that when searching the working copy, by default a subset
> > of the files are searched.  Tell me: given all this information here,
> > what possible explanation is there for SKIP_WORKTREE entries to be
> > translated into searches of the cache when --cached is not specified?
> > Please square that away with the fact that 'rm fileC' results in fileC
> > NOT being searched.
> >
> > It's just completely, utterly wrong.
>
> Makes sense, thanks. I agree that we shouldn't fall back to the cache
> when searching the working tree.
>
> > Also, hopefully this helps answer your question about --untracked and
> > skip_worktree.  --untracked is only useful when searching through the
> > working tree, and is entirely about adding the "untracked" category to
> > the things we search.  The skip_worktree bit is about adding more
> > granularity to the "tracked" category.  The two are thus entirely
> > orthogonal and --untracked shouldn't change behavior at all in the
> > face of sparse checkouts.
>
> Thanks, your explanation clarified the issue I had. I see now why
> --untracked and --ignore-sparsity don't make sense together.
>
> It also made me think about the combination of --cached and
> --untracked which, IIUC, should be prohibited. I will add a patch in
> v2, making git-grep error out in this case.
>
> > And I also think it explains more when the sparsity patterns and
> > --ignore-sparsity-patterns flags even matter.  The division of working
> > tree files which were tracked into two subsets (those that match
> > sparsity patterns and those that don't) didn't matter because only one
> > of those two sets existed and could be searched.  So the question is,
> > when can the sparsity pattern divide a set of files into two subsets
> > where both are non-empty?  And the answer is when --cached or REVISION
> > is specified.
>
> Makes sense. I will add in --ignore-sparsity's description that it is
> only relevant with --cached or REVISION, as you previously suggested.
> When it is used outside of these cases, though, I think we could just
> warn that --ignore-sparsity will be discarded (to avoid erroring out
> when users have grep.ignoreSparsity enabled).

Not grep.ignoreSparsity but core.ignoreSparsity or core.$WHATEVER  ;-)

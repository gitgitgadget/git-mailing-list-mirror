Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1FCC43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 01:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE2D206F6
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 01:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="szP9wfMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgC3BNC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 21:13:02 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36608 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728026AbgC3BNC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 21:13:02 -0400
Received: by mail-lf1-f65.google.com with SMTP id u15so3631142lfi.3
        for <git@vger.kernel.org>; Sun, 29 Mar 2020 18:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jHJxXNym8sTS74FjHkd+BL/FnAhKVr5vf7d6QN+3oZg=;
        b=szP9wfMZYgmkXpu+VtxXv4dArGRpVCMZuWHQw6yK+3yIJA3zu1tmaQG6YN7zJxCcTw
         qxyUmp4+rFAMHwMpKNX7RFNiUxmJMm4nixdxr3w2TCvcgfL+iEL62uAOB7ihb0i6Cilm
         QLHolSBlbfiOpQ+Np7yz7cynd0ZqfnhYBQCuVO75ipWe8yMfHq1v1K4wnAX3rPbt2TjY
         W34Tm5IptLwC8SPV9d2TmcXdV8txnnyWCg7szJ/0hVfNO7AxaCEgvnZ1ZQeJA9jyOLNI
         IFhPLQgu9C4sZ2gmKAhK50WOInkzHeO3fHhZ0hzVABkRqj2xG7iMvsPFVEbjWoa7eDY7
         zqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jHJxXNym8sTS74FjHkd+BL/FnAhKVr5vf7d6QN+3oZg=;
        b=lEqpvKvDoZJxJVPhXi6MdNpeW9tNazN+kcszD8GrYpaS5eqahN1TyT7AxVwzrtBi1s
         kjkGfZ78H2NfI/ohPdZ2NK24vIM1+QI1jqJTFKE9cm657OK10DhjL96Lu3zNj3u0GrmN
         ZAIVl7tRajSFeFL/A3iyAF8DJo6nOUh0yG8BfUS+GtT+GPkUH9t1XJF1lnYjQf2U4cMW
         Rdl0ajabLiaLOZs+jcrNwZ7EAroq8GejLhmlASl9l+DODzRbY3WpuRbhdogll8zJGLsr
         UmhGHHSa/SHt2aGzovPdjyY59S4Gc5DPl2mPCN1dKha9ndUEuOBGep0zO8y0ySIKaKci
         4/7A==
X-Gm-Message-State: AGi0PuYH7ObwrbHTxpc5qSUFjt1E+Epa74EI/VrVo1ZdkrHn3ClBzQFS
        sqDjoXUAvitezy2ubpeRtKwSQrOgiD0B+nM0DsuAuR3SWdI=
X-Google-Smtp-Source: APiQypIQAy3byEXqWkB2VTJF6QE3I6+vlcMoYOfZ8+xdTOrChNIlLjSLdOgcfws03Wa042QqjD6goU2xNEtsLrTAN7E=
X-Received: by 2002:a05:6512:31d5:: with SMTP id j21mr6701916lfe.23.1585530779322;
 Sun, 29 Mar 2020 18:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585027716.git.matheus.bernardino@usp.br>
 <a76242ecfa69cf29995bd859305dc2ab1bc1a221.1585027716.git.matheus.bernardino@usp.br>
 <CABPp-BEbNCYk0pCuEDQ_ViB2=varJPBsVODxNvJs0EVRyBqjBg@mail.gmail.com>
 <CAHd-oW6ANf_iNmYkgXt4jo1seB-AEx1TSH384v+oh1bicG8RDA@mail.gmail.com> <CABPp-BGVO3QdbfE84uF_3QDF0-y2iHHh6G5FAFzNRfeRitkuHw@mail.gmail.com>
In-Reply-To: <CABPp-BGVO3QdbfE84uF_3QDF0-y2iHHh6G5FAFzNRfeRitkuHw@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sun, 29 Mar 2020 22:12:48 -0300
Message-ID: <CAHd-oW6_KuHtNN2qJrkqYSuCF665AuE3mO6YEbmPdtRiq-EbXQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] grep: add option to ignore sparsity patterns
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 26, 2020 at 3:02 AM Elijah Newren <newren@gmail.com> wrote:
>
> Hi Matheus!

Hi, Elijah.

First of all, thanks for taking the time to go over these topics in
great detail. I must say it's much clearer for me now.

> On Wed, Mar 25, 2020 at 4:15 PM Matheus Tavares Bernardino
> <matheus.bernardino@usp.br> wrote:
> >
[...]
> One more useful case to consider before we start adding SKIP_WORKTREE
> into the mix.  Let's say that you have three files:
>    fileA
>   fileB
>    fileC
> and all of them are tracked.  You have made edits to fileA and fileB,
> and ran 'rm fileC' (NOT 'git rm fileC', i.e. the deletion is not
> staged).  Now, you run 'git grep mystring'.  Quick question: Which
> files are searched for 'mystring'?  Well...
>   * REVISION and --cached were left out of the git grep command, so
> working tree files should be searched, not staged versions or versions
> from other commits
>  * No flags like --untracked or --no-exclude-standard were included,
> so only tracked files in the working tree should be searched
>   * There are two files in the working tree, both tracked: fileA and fileB.
> So, this searches fileA and fileB.  In particular: NO VERSION of fileC
> is searched.  fileC may be tracked/cached, but we don't search any
> version of that file, because this particular command line is about
> searching the working directory and fileC is not in the working
> directory.  To the best of my knowledge, git grep has always behaved
> that way.
>
> Users understand the idea of searching the working copy vs. the index
> vs. "old" (or different) versions of the repository.  They also
> understand that when searching the working copy, by default a subset
> of the files are searched.  Tell me: given all this information here,
> what possible explanation is there for SKIP_WORKTREE entries to be
> translated into searches of the cache when --cached is not specified?
> Please square that away with the fact that 'rm fileC' results in fileC
> NOT being searched.
>
> It's just completely, utterly wrong.

Makes sense, thanks. I agree that we shouldn't fall back to the cache
when searching the working tree.

> Also, hopefully this helps answer your question about --untracked and
> skip_worktree.  --untracked is only useful when searching through the
> working tree, and is entirely about adding the "untracked" category to
> the things we search.  The skip_worktree bit is about adding more
> granularity to the "tracked" category.  The two are thus entirely
> orthogonal and --untracked shouldn't change behavior at all in the
> face of sparse checkouts.

Thanks, your explanation clarified the issue I had. I see now why
--untracked and --ignore-sparsity don't make sense together.

It also made me think about the combination of --cached and
--untracked which, IIUC, should be prohibited. I will add a patch in
v2, making git-grep error out in this case.

> And I also think it explains more when the sparsity patterns and
> --ignore-sparsity-patterns flags even matter.  The division of working
> tree files which were tracked into two subsets (those that match
> sparsity patterns and those that don't) didn't matter because only one
> of those two sets existed and could be searched.  So the question is,
> when can the sparsity pattern divide a set of files into two subsets
> where both are non-empty?  And the answer is when --cached or REVISION
> is specified.

Makes sense. I will add in --ignore-sparsity's description that it is
only relevant with --cached or REVISION, as you previously suggested.
When it is used outside of these cases, though, I think we could just
warn that --ignore-sparsity will be discarded (to avoid erroring out
when users have grep.ignoreSparsity enabled).

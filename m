Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F68C433E0
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 22:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42F9D20810
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 22:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brMhwMIu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgFQWgW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 18:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgFQWgW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 18:36:22 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0A9C06174E
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 15:36:21 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id t6so2976935otk.9
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 15:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CUa+cRftanHK1SSl3BJUFoXU6qC9mx7BcssLGSEPjUs=;
        b=brMhwMIuNEvHhnuMm/yaKRIT4VIybRf0yB/qHUR811U9Q1swuyQi5HdSR4Nl7fRU33
         bB/9Ry84xKsNvRGLr/5yRrGPY633D1WIlEuvduQ87QcAX5ni1ldyiFaQD3La/okPwjLj
         hVbdj1ELy7E225TkZsryOEok5FVb8x1nbEEQgBmcGpF9cMusOQc0OqvQP/pnJLWev0TI
         9XKH2cufK9nmM7EAuJCJiTzEu9QVxJYtjgocGXhzXMZKkvgF+Mj/csFTWP5to6ME/Xli
         rTJPxEg/Q8CnOyk4XQLiunmMG+J/Kfv8rtrq8xJ3JINfDBW3QrJ1Kq4VK/kvKSx/b7x/
         mZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CUa+cRftanHK1SSl3BJUFoXU6qC9mx7BcssLGSEPjUs=;
        b=N/PKsJX5fnPo0mMjST0oaQTtY1PQJalBM3tJa/9ZNElVqsSYJiXHwoRj0yhW7KZkFb
         NwLcsMRgoUa++XvUlqPUg/nZ2MgMU/Msl/Y+4vqDaKzLJPejZf2KsOlWceJ/snMT5rMa
         +EDJxdQbF4/Pit1M8WOQKjfjSkOq2Esn79XkNdDfYnidcZtsk/Cu/l2nguQAghCykdRU
         +YsErtOIsPUcNBDFqiYL0jCvXB973TFG82SWryIXUr7f3RrCIr5C+yYnY4cZdDgwDAS8
         zxtG9K21jxKLn0dcTTcq7vmsrg8FMIKBNbQN77lMWiU0CblpNX0Yh26wApUr1jRL880T
         im2A==
X-Gm-Message-State: AOAM530Some2xSvv3oZrIloe5uwL9imRBLgP5Sv9VmgMpBya4IpuzjsN
        RLrhDvO8qt8bF/lXFotwb+xGAyJ64ekBMOZs6KM=
X-Google-Smtp-Source: ABdhPJw8+sk5r+nnaPUoFPAgrVMNGVMkuqNMtbS8B6IVOsnICzcoe6d/mb97bDRO4Fc+oQ2fFE0+426DtjPkNyFiiqU=
X-Received: by 2002:a9d:7606:: with SMTP id k6mr1094283otl.316.1592433381053;
 Wed, 17 Jun 2020 15:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAL3xRKf+rQuq=j_4NJpNbRq4Rdxz7MjQaxi3c9usS+c615k19Q@mail.gmail.com>
 <CABPp-BHyc=aYqY+YuvNRsFsrMPL6+O=CX37jzXx38_-SXw5gLA@mail.gmail.com> <20200617175850.GA57254@C02YX140LVDN.corpad.adbkng.com>
In-Reply-To: <20200617175850.GA57254@C02YX140LVDN.corpad.adbkng.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 17 Jun 2020 15:36:10 -0700
Message-ID: <CABPp-BGLBmWXrmPsTogyBFMgwYbHjN39oWbU=qDWroU1_fJaoQ@mail.gmail.com>
Subject: Sparse checkout and recorded dependencies between directories (Was:
 Re: [PATCH 0/2] Sparse checkout status)
To:     Son Luong Ngoc <sluongng@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Son,

On Wed, Jun 17, 2020 at 10:58 AM Son Luong Ngoc <sluongng@gmail.com> wrote:
>
> Hi Elijah,
>
> On Wed, Jun 17, 2020 at 09:48:22AM -0700, Elijah Newren wrote:
> >
> > An aside, though, since you linked to the in-tree sparse-checkout
> > definitions: When I reviewed that series, the possibility of merge
> > conflicts and not knowing what sparse-checkout should have checked out
> > when the in-tree defintions themselves were in a conflicted state
> > seemed to me to be a pretty tough sticking point.  I'm hoping someone
> > has a clever solution, but I still don't yet.  Do you?
>
> I am no clever person, but I often take great pleasure in reading up
> works of smarter people. One of which is the Google's and Facebook's Mercurial
> extension sets that they opensourced a while ago to support large repos.
>
> The test suite for FB's 'sparse' extension[1] may address your concerns?
>
> The 'sparse' extension defines the sparse checkout definition of a
> working repository. It supports '--enable-profile' which take in definition
> files ('.sparse'). These profiles are often checked into the root dir
> of the repo.
>
> [1]: https://bitbucket.org/facebook/hg-experimental/src/05ed5d06b353aca69551f3773f56a99994a1a6bf/tests/test-sparse-profiles.t#lines-115

Ooh, interesting; thanks for the link.  It provides an idea, though
I'm not completely sure how it maps to our implementation.  The test
file says that during a merge you get "unioned files".  It's not fully
clear what union means, especially when the files have both includes
and excludes.  For example, does the union of matches mean a union of
includes and an intersection of excludes?  Also, digging a bit
further, it appears mercurial requires all includes to be before all
excludes[2].  But git's pattern specification used in
.git/info/sparse-checkout (taken from .gitignore rules) allows
includes and excludes to be arbitrarily interspersed, so what is an
appropriate union in our case?  (Can we sidestep this question by
limiting the in-tree sparsity definitions to cone mode only, which
then only have includes in the form of directory names, since that'd
allow easy "unioning"?)

A little more digging suggests that mercurial also only allows sparse
definitions to be read from commits, not from the working tree[3].
That seems bad to me; it's too much of a pain for users who want to
edit and test changes.  Sure, if their first commit is bad they could
`git commit --amend` after the fact, but I don't like forcing them
through that workflow.  (This is perhaps especially true if they're
trying to fix the definition during a rebase; they shouldn't have to
commit first to get a corrected sparsity definition, especially as
that can easily mess up rebase state.)

However, although I don't like reading sparsity definition from
commits rather than the working tree, it probably did have an
advantage in that it made it easier for mercurial folks to notice the
union idea: since they only get sparsity patterns from revisions, they
are kind of forced into thinking about getting them from both parents
and then "doing a union".  Anyway, following that logic, it'd be
tempting to say that we limit the in-tree definitions to cone mode,
and then if any of the definitions have conflicts then we just load
stages 2 and 3 of the file and union them.  But...what if stages 2 and
3 also have conflict markers in them (either because of recursive
merges or the more involved rename/rename(2to1) cases)?  How do we
ensure a well defined "union" of values?

I guess a similar question is what if users, while editing, fill the
sparse definition file with syntax errors -- and maybe even commit it.
Do we sparsify down to nothing? Expand out to everything? Ignore the
lines that don't otherwise parse and just use the rest?  Something
else?

The one other thing I noticed of interest from mercurial's sparsify
was that it apparently suffers from the same problems we used to in
git < 2.27.0: inability to update sparsity definitions when there are
any dirty changes[4].  That was a huge pain point; I'm glad we're not
stuck with that anymore.


Anyway, the mercurial link certainly provides some ideas even if it
doesn't answer all the questions.  Thanks for pointing it out.


Elijah


[2] https://fossies.org/linux/mercurial/mercurial/sparse.py#l_59
[3] https://fossies.org/linux/mercurial/mercurial/sparse.py#l_123
[4] https://fossies.org/linux/mercurial/mercurial/sparse.py#l_485
     https://fossies.org/linux/mercurial/mercurial/sparse.py#l_526

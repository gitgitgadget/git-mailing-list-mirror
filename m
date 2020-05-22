Return-Path: <SRS0=kZBr=7E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6655FC433DF
	for <git@archiver.kernel.org>; Fri, 22 May 2020 21:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32E2B20663
	for <git@archiver.kernel.org>; Fri, 22 May 2020 21:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zf9Sc5HW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731051AbgEVVGs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 May 2020 17:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730963AbgEVVGs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 May 2020 17:06:48 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33CCC061A0E
        for <git@vger.kernel.org>; Fri, 22 May 2020 14:06:47 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id l6so10464776oic.9
        for <git@vger.kernel.org>; Fri, 22 May 2020 14:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ve4J/wd8Lo5P9jCJjVEJaMHnpPjiuNhW/GtOK8zWFOc=;
        b=Zf9Sc5HWZrx+plcpT3ZogXqQk/jQVx2UQ/buz8UmgOhzieghwjejtNvD3P/c4ssU00
         vfSTdeLPTaDQzHC3yZv+YJsmMb9H2fx1yFkDQysOWS93rDzwPXkR6dPjs2/OArn9kx3S
         JV3TKMZRT6QQiYOLEKyXJhbReb63tZshs87YmKUXoqalKIypbuh9+LjdgDTWadIp8jNT
         69Oe3Gd4gqKnEsPoGWLo2zAZpgwqKA2uKU1TMJ0oJLYXS2W/3PS8zW8/MgV5GUdu+8cU
         LWT3qsvtvrw/L/uAEEVTp29YFuEeqZLCqlUrP0oHWfS9DmsTr45R53ZJn1QtsangtoVy
         wOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ve4J/wd8Lo5P9jCJjVEJaMHnpPjiuNhW/GtOK8zWFOc=;
        b=T2xYB17uJc4EpK/sv3Uqbz9B70qqVNHmre2fN9KyfL1FFLga38NramWvOrLEjbLILU
         crgl35MfZXHi5m+gIZxfKMfXmw3ozUfyvsO8se+zI7kjN0zixf74Z6hsm1Owr6qyfBFz
         /+2xioBlvXy+Dy9qhauMw2nX8rEgLVNDpTkWd+9Xw+GHQxzK4k68xvT0DLP2rEimgeum
         Ai8uHnxd86acPXMrZydkKLKZ43qaR4OjzzgeJYHtlPjDO5R6QjdJCJsMcXHEnrPqHli6
         T8Bu1EMczyeEriwII6hTzgkN5gvNhRM4YHBnJzM4QdsKwPX7Rb7xZ7sShGt5jS+tVJsP
         0BVQ==
X-Gm-Message-State: AOAM533p1MNKnbM2l12tUblq7xCSCkr9mFEZbj8T9HEVhE3zsAeqcXfD
        gBqcKhV3ysEBCCpdNSvtkEQ2do88jQJosE86RUg=
X-Google-Smtp-Source: ABdhPJwwEBEakBRK7L283mcv2f+f7cw4/hWR+ISdOzqYn9LqLZ0acIid5oSBd6ye7jDci9sXIOALM/2/XIfqaTCrw5s=
X-Received: by 2002:aca:2b04:: with SMTP id i4mr4092934oik.39.1590181607071;
 Fri, 22 May 2020 14:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW7_6+Jv+SQG3qh8eRjwJmqnRJKs=_bAV3WaC4-SKkoywg@mail.gmail.com>
 <20200522142611.1217757-1-newren@gmail.com> <CABPp-BE6M9ATDYuQh8f_r3S00dM2Cv9vM3T5j5W_odbVzhC-5A@mail.gmail.com>
 <CAHd-oW6BoHkMSAQVquHR+H7=g84VE-qmXGYcDmWwFxuLyqZSzg@mail.gmail.com>
In-Reply-To: <CAHd-oW6BoHkMSAQVquHR+H7=g84VE-qmXGYcDmWwFxuLyqZSzg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 22 May 2020 14:06:35 -0700
Message-ID: <CABPp-BGEPU49yRN2FRtwhYn6Uh+scGKEFYP4G2GH6=uBTN1SCw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] grep: honor sparse checkout patterns
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 22, 2020 at 1:54 PM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> Hi, Elijah
>
> On Fri, May 22, 2020 at 12:36 PM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Fri, May 22, 2020 at 7:26 AM Elijah Newren <newren@gmail.com> wrote:
> > >
> > > Hi Matheus,
> > >
> > > On Thu, May 21, 2020 at 10:49 PM Matheus Tavares Bernardino <matheus.bernardino@usp.br> wrote:
> > > >
> > > > On Thu, May 21, 2020 at 2:52 PM Elijah Newren <newren@gmail.com> wrote:
> > > > >
> > <snip>
> > > > Does this seem like a good approach? Or is there another solution that
> > > > I have not considered? Or even further, should we choose to skip the
> > > > submodules in excluded paths? My only concern in this case is that it
> > > > would be contrary to the design in git-sparse-checkout.txt. And the
> > > > working tree grep and cached grep would differ even on a clean working
> > > > tree.
> > >
> > <snip>
> > > Anyway, the wording in that file seems to be really important, so
> > > let's fix it.
> > >
> >
> > Let me also try to give a concrete proposal for grep behavior for the
> > edge cases we've discussed:
>
> Thank you for this proposal and for the previous comments as well.
>
> > git -c sparse.restrictCmds=true grep --recurse-submodules $PATTERN
> >
> > This goes through all the files in the index (i.e. all tracked files)
> > which do not have the SKIP_WORKTREE bit set.  For each of these: If
> > the file is a symlink, ignore it (like grep currently does).  If the
> > file is a regular file and is present in the working copy, search it.
> > If the file is a submodule and it is initialized, recurse into it.
>
> Sounds good. And when sparse.restrictCmds=false, we also search the
> present files and present initialized submodules that have the
> SKIP_WORKTREE set, right?

You're really pushing those corner cases, I love it.  :-)
SKIP_WORKTREE is supposed to mean we have removed it from the working
tree, i.e. it shouldn't be present (if we decide we're not going to
remove it from the working tree, e.g. because the file is unmerged or
something, then we don't mark it as SKIP_WORKTREE even if it doesn't
match sparsity patterns).  Therefore, the set of files that satisfy
this condition you have given should generally be empty.

But presuming we hit this corner case, I'd say you are right.
sparse.restrictCmds=false means we ignore the SKIP_WORKTREE bit
entirely (and in the case of grepping a $REVISION, we ignore the
sparsity patterns entirely).

> > git -c sparse.restrictCmds=true grep --recurse-submodules --cached $PATTERN
> >
> > This goes through all the files in the index (i.e. all tracked files)
> > which do not have the SKIP_WORKTREE bit set.  For each of these: Skip
> > symlinks.  Search regular files.  Recurse into submodules if they are
> > initialized.
>
> OK.
>
> > git -c sparse.restrictCmds=true grep --recurse-submodules $REVISION $PATTERN
> >
> > This goes through all the files in the given revision (i.e. all
> > tracked files) which match the sparsity patterns (i.e. that would not
> > have the SKIP_WORKTREE bit set if were we to checkout that commit).
> > For each of these: Skip symlinks.  Search regular files.  Recurse into
> > submodules if they are initialized.
>
> OK.
>
> > Further, for any of these, when recursing into submodules, make sure
> > to load that submodules' core.sparseCheckout setting (and related
> > settings) and the submodules' sparsity patterns, if any.
> >
> > Sound good?
> >
> > I think this addresses the edge cases we've discussed so far:
> > interaction between submodules and sparsity patterns, and handling of
> > files that are still present despite not matching the sparsity
> > patterns. (Also note that files which are present-despite-the-rules
> > are prone to be removed by the next `git sparse-checkout reapply` or
> > anything that triggers a call to unpack_trees(); there's already
> > multiple things that do and Stolee's proposed patches would add more).
> > If I've missed edge cases, let me know.
>
> Sounds great. This addresses all the edge cases we've mentioned
> before. Thanks again for the detailed proposal, and for considering
> case by case.

And thank you for working on this.  :-)

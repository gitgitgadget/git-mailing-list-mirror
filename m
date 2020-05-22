Return-Path: <SRS0=kZBr=7E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40ECC433DF
	for <git@archiver.kernel.org>; Fri, 22 May 2020 20:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A03F820679
	for <git@archiver.kernel.org>; Fri, 22 May 2020 20:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="O/kB7KnU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731028AbgEVUyq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 May 2020 16:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730963AbgEVUyq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 May 2020 16:54:46 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70C3C061A0E
        for <git@vger.kernel.org>; Fri, 22 May 2020 13:54:45 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q2so14247211ljm.10
        for <git@vger.kernel.org>; Fri, 22 May 2020 13:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iqhiZPjgyxnLvIwj4aRtK2YxL2ugSKzi7wQm2Y+aTvM=;
        b=O/kB7KnUdYx8RpIpBpgr0qyEjgpTkEVja+YJXC9ldPPbXUzUFw0ThzIH7NpmjQVM0P
         hS8Ku2ywVeDZK60WU7wBiXjgyqyXk75LUr5OeEZiG8yQHm2tQlx/8sDdqox2CzOPyyRJ
         zO5f3BC+NMn/3oJcZ2ABk/sJ1V6IV1vpYcnSsaGRs3v+deBRLOX0x7haw+ger5pPfrWH
         xFEFq4jMim++aT3os407IJ9m/EkXexSsqKJzcNBOlO0jksnfKoh1qndK9QiwY4CWdwWc
         DgwYZ2rtJSbZOK4GDBF+9hnJEXo2pJgMYzVW0rLZ/4QZ85JZqdgsJYH5wD0Wcg7qkbf6
         Mc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iqhiZPjgyxnLvIwj4aRtK2YxL2ugSKzi7wQm2Y+aTvM=;
        b=LQvcrLE9mWOB/7TJiraSdCLUThHe8ik12NhB5inLbbUPyopgnxdRjD6r3xHkS4Dfqf
         xfr2hx3L4rK8z/afvPBH3wDSbZLU68Pd/BotDNzhLTWryQDFWtiHOw2DkXRra1tXJKex
         zFFfo6U0N0RAU+xUPoXEFjbBe92ViHcQeXIKIr9I8UTdGEGxjB0POqSwVsGrDFiiCyiD
         Jdq1/dbgT9h/dASdL7yweXrZ6yv7f5of4VbGzlBPjszyX0TchTQd3nsKaACsUjYmnLNd
         wuxFXy3DTcFB3p4UetAbpCYhKrcMjfuXtI9DKp+9vvwQ0T+pg8Seyj3/XVGLGDsspQUM
         wrZg==
X-Gm-Message-State: AOAM533My+i0RyLs+iKJiLsmIdIz30M2bjjxLr/jJe8NsNn9X95Y2vqR
        UDnnY611zfwO0DKVmHlD1Uo8JLQGVOmb4219TkNmhQ==
X-Google-Smtp-Source: ABdhPJxQ5y4CclJD0ZUweTmGO3gl0SUOk/kG/p+0iteSvDLPkPH6CiKdNWU2b9EkxAmFKIddUSkjOd3goBQS/x3WmF8=
X-Received: by 2002:a2e:7007:: with SMTP id l7mr2119710ljc.74.1590180884193;
 Fri, 22 May 2020 13:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW7_6+Jv+SQG3qh8eRjwJmqnRJKs=_bAV3WaC4-SKkoywg@mail.gmail.com>
 <20200522142611.1217757-1-newren@gmail.com> <CABPp-BE6M9ATDYuQh8f_r3S00dM2Cv9vM3T5j5W_odbVzhC-5A@mail.gmail.com>
In-Reply-To: <CABPp-BE6M9ATDYuQh8f_r3S00dM2Cv9vM3T5j5W_odbVzhC-5A@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Fri, 22 May 2020 17:54:33 -0300
Message-ID: <CAHd-oW6BoHkMSAQVquHR+H7=g84VE-qmXGYcDmWwFxuLyqZSzg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] grep: honor sparse checkout patterns
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Elijah

On Fri, May 22, 2020 at 12:36 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Fri, May 22, 2020 at 7:26 AM Elijah Newren <newren@gmail.com> wrote:
> >
> > Hi Matheus,
> >
> > On Thu, May 21, 2020 at 10:49 PM Matheus Tavares Bernardino <matheus.bernardino@usp.br> wrote:
> > >
> > > On Thu, May 21, 2020 at 2:52 PM Elijah Newren <newren@gmail.com> wrote:
> > > >
> <snip>
> > > Does this seem like a good approach? Or is there another solution that
> > > I have not considered? Or even further, should we choose to skip the
> > > submodules in excluded paths? My only concern in this case is that it
> > > would be contrary to the design in git-sparse-checkout.txt. And the
> > > working tree grep and cached grep would differ even on a clean working
> > > tree.
> >
> <snip>
> > Anyway, the wording in that file seems to be really important, so
> > let's fix it.
> >
>
> Let me also try to give a concrete proposal for grep behavior for the
> edge cases we've discussed:

Thank you for this proposal and for the previous comments as well.

> git -c sparse.restrictCmds=true grep --recurse-submodules $PATTERN
>
> This goes through all the files in the index (i.e. all tracked files)
> which do not have the SKIP_WORKTREE bit set.  For each of these: If
> the file is a symlink, ignore it (like grep currently does).  If the
> file is a regular file and is present in the working copy, search it.
> If the file is a submodule and it is initialized, recurse into it.

Sounds good. And when sparse.restrictCmds=false, we also search the
present files and present initialized submodules that have the
SKIP_WORKTREE set, right?

> git -c sparse.restrictCmds=true grep --recurse-submodules --cached $PATTERN
>
> This goes through all the files in the index (i.e. all tracked files)
> which do not have the SKIP_WORKTREE bit set.  For each of these: Skip
> symlinks.  Search regular files.  Recurse into submodules if they are
> initialized.

OK.

> git -c sparse.restrictCmds=true grep --recurse-submodules $REVISION $PATTERN
>
> This goes through all the files in the given revision (i.e. all
> tracked files) which match the sparsity patterns (i.e. that would not
> have the SKIP_WORKTREE bit set if were we to checkout that commit).
> For each of these: Skip symlinks.  Search regular files.  Recurse into
> submodules if they are initialized.

OK.

> Further, for any of these, when recursing into submodules, make sure
> to load that submodules' core.sparseCheckout setting (and related
> settings) and the submodules' sparsity patterns, if any.
>
> Sound good?
>
> I think this addresses the edge cases we've discussed so far:
> interaction between submodules and sparsity patterns, and handling of
> files that are still present despite not matching the sparsity
> patterns. (Also note that files which are present-despite-the-rules
> are prone to be removed by the next `git sparse-checkout reapply` or
> anything that triggers a call to unpack_trees(); there's already
> multiple things that do and Stolee's proposed patches would add more).
> If I've missed edge cases, let me know.

Sounds great. This addresses all the edge cases we've mentioned
before. Thanks again for the detailed proposal, and for considering
case by case.

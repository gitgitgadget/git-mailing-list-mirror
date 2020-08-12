Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5B4C433E0
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 17:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B76C2076C
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 17:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xje/2RaA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHLRs4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 13:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgHLRsy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 13:48:54 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AEEC061383
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 10:48:54 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id s189so3911420iod.2
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 10:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K7sX//PGwmcA2w2n/uqjdBv4+u7Y4eqXGAHSgoYFONo=;
        b=Xje/2RaAC9oNth0uNXM2GRUOZUonSrx6/9ZtsOlkQCPDPX1p8OMM8GKHNpvB/K/RIC
         ryw8xiQ8W0qjRmVz2ko8P6yuyrOVY0KSa2x1jr92fdERN46cvqJq7eQAi9+RTGQj7zMK
         Qh4PZ+Egr1TLvKVBwOw3IJyzHl/PsMcsc9be52NKPMqIkLBvQ8wUclKrsk0OUDAh/uFX
         jjhhMdGGFwf8ZIo2EBtzZPRxNGgHqYRuzJArjZCis9efjjucNx0Vpy34MpCo8QYvTwnP
         Fk9F6X87hUrDrv+BptBZUSkxpX7SeFXRa+TtTNYHjrM2v3m9+KHS5czGv6bA6y2o9O2D
         IBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K7sX//PGwmcA2w2n/uqjdBv4+u7Y4eqXGAHSgoYFONo=;
        b=Dk+Vtu44VMonxq6PLLuR44XGnkI9CFRkVLb6tRq3cvBtzRWV+BqZhItrqZaBMZdyh7
         w1cQ94/x5b8QSQqelpls5iza/zJiWXds4GYj1G6syI0/xhdFY58rXh4qp3auo4XV7ID0
         wqO4+nVTcJp+5Gv3HeuwElhk1kEu1Tb7pMVgqoS1bE3IpQZ8/0wYIx5g8RG2KrZn2U0A
         9MgbnBA/BseZESYHlVQAOkpD6e6vlTfeeV8b3Tuo/DsmnO/5oG6XSHhCjTW70vd9xcan
         nodjGghJK2zX2Tos+KaGwaLplWTyXVy41alp9ew7SXeQ9IH3t7uA7mfudVcTmYoyv4BG
         J4yw==
X-Gm-Message-State: AOAM532KpBd9MJd7joMtdchgsrSe8XXKk2ccFZxdBdtRzJEdydxWzDVy
        +JwbHghdAoqhG4zMKbd1wn+eqDn6pJMAXLH/Ygk=
X-Google-Smtp-Source: ABdhPJyJvDkaKDITpvK44/1FYJqP8lxEkSdHvK1rVVfUmZIKV9/Cy4DLaovFtl/oe05n593pWP+MJ4x7cLhbrwsDZ9g=
X-Received: by 2002:a02:ccd7:: with SMTP id k23mr589249jaq.73.1597254533812;
 Wed, 12 Aug 2020 10:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <CADjceoQxoL932W4mkfhG6VOgrQBhs9k6tXkWSkraKVPmUP+uCw@mail.gmail.com>
 <878ses4pay.fsf@kyleam.com> <CADjceoRtFmM2H1z48HcmvWBF1KmMrwMnE6YdC9HJGFjdXXivJw@mail.gmail.com>
 <8736504k06.fsf@kyleam.com> <CABPp-BEmrcY8wr_rb+Y4gacNEeeEPTUxWw2Mq0A9LMzpx2bQnA@mail.gmail.com>
 <CABPp-BFWfwkYAPyySjWOMZ02_+YLf=TJ_aVMaHaizJWAsCL67g@mail.gmail.com>
In-Reply-To: <CABPp-BFWfwkYAPyySjWOMZ02_+YLf=TJ_aVMaHaizJWAsCL67g@mail.gmail.com>
From:   christian w <usebees@gmail.com>
Date:   Wed, 12 Aug 2020 13:48:42 -0400
Message-ID: <CADjceoREZm4BrdAApqnsb_uX_QBaEKC=qs7Zk0uD6L-o907hDA@mail.gmail.com>
Subject: Re: ls-files bug report
To:     Elijah Newren <newren@gmail.com>
Cc:     Kyle Meyer <kyle@kyleam.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

that's great to hear, thanks for jumping on this so quickly!

On Wed, Aug 12, 2020 at 10:50 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Thu, Aug 6, 2020 at 9:10 PM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Wed, Aug 5, 2020 at 6:54 PM Kyle Meyer <kyle@kyleam.com> wrote:
> > >
> > > christian w writes:
> > >
> > > > Sorry for the insufficient reproduction steps.
> > > >
> > > > I managed to figure out it has something to do with git repos within
> > > > git repos. It happened to us because of go packages that are inside
> > > > our repo. These are the reproduction steps that work for me
> > > > consistently using Go version go1.14.4 darwin/amd64. This is the repo
> > > > that gets cloned into src/golang.org/x/debug by the go get command:
> > > > https://github.com/golang/debug/tree/66ec140f2f72d15dc6133502edd2bb7238b1740c
> > > >
> > > > $ mkdir testdir
> > > > $ cd testdir
> > > > $ git init .
> > > > $ GOPATH=$(pwd) go get -u golang.org/x/debug/ || true
> > > > $ git ls-files --others '*.txt'#
> > > > src/golang.org/x/debug/
> > >
> > > Okay, removing Go from the equation:
> > >
> > >      $ # in fresh repo
> > >      $ mkdir a
> > >      $ git init a/d0
> > >      $ touch a/f0.txt
> > >      $ git ls-files --others 'a/*.txt'
> > >      a/d0/
> > >      a/f0.txt
> > >
> > > It looks like the spurious a/d0/ entry doesn't show up until v2.27.0, in
> > > particular 95c11ecc73 (Fix error-prone fill_directory() API; make it
> > > only return matches, 2020-04-01).  Adding the author to the Cc.  (Sorry,
> > > Elijah, I recall your frustration with dir.c from a previous ls-files
> > > issue that I reported [1]).
> >
> > Thanks for digging in and coming up with a smaller list of steps to
> > reproduce.  You are right that I dread reports that touch dir.c -- if
> > I would have just ignored the first report back in March of 2018,
> > there's a really, really long list of problems I could have avoided...
> >
> > I'll try to take a look in the next week.
>
> Should be solved by this fix:
> https://lore.kernel.org/git/11a286b071ca8a6b96f4fba6658e9bafb9314be4.1597216356.git.gitgitgadget@gmail.com/

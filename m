Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59047C433EF
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 09:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 278D061051
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 09:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbhIDJwd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Sep 2021 05:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbhIDJwd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Sep 2021 05:52:33 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAC3C061575
        for <git@vger.kernel.org>; Sat,  4 Sep 2021 02:51:31 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id w78so1638840qkb.4
        for <git@vger.kernel.org>; Sat, 04 Sep 2021 02:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DUBEzkp+ev1QQ77vz2hwosTU57FRw9HuXz+K/trjUxQ=;
        b=hVK1zkiN4ms0tx2RbcAy0g3Zh8fXK0C+VMV18qSrcrKKwikqXzkq0Xmz78GKhdPTtd
         c9jN+CnlFgsmnZm0V3jRYpkwMSKfFH1eM2ALgN0bzAoMKr2ME6TaT5LpqsJUC7aecbew
         vqN6uPgPeZWrfqx6SltELigQRA74VIG0wTF7lk8fXMDoni3DbACwNaM1iNRLWMvy94cf
         wqeLrwQfhqnrMWi3ILiokA7NVEMajGaAItoDU/jbRUI8B14DBY/f6xlUMVpq3i16aDun
         hmDGt4KBiBPruF0lNvhMjrKnX/vLE1PTQ0fLJr+jEq9R+bjhFGOuFmKT3YwlQhYjT0rm
         MIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DUBEzkp+ev1QQ77vz2hwosTU57FRw9HuXz+K/trjUxQ=;
        b=AnwWpovXOSeAvdfpsnbYuJrJpJRXRuYHc3J529ZC6PIHS45ggzhQrXBdvOlOVciJDP
         8bGwrcVmL3yeIgEt/qv5FPx+mnxS5pYT7FpeYQyEZyOt29TBHmIkIO04y9wDRP0qfjB+
         a4swg2sY1Zoe7JJzKJHPsjn/4NoYAX6WCructth1Jp88uNwKfAMOPxrKYByi5OcOeN8W
         amvKB+VB31KqOYKgnrM2r0N/wvjcSE8MDc4chBpUBdTtG6D+HHDPaybymDx+Fz7IeE+h
         NKC4c1L6g4/YwOl6RRrLLWg3EuLzekf5qyS5Ql6n8GXMfE5xnxITFanqvfbwye7JXzV9
         71BQ==
X-Gm-Message-State: AOAM532zCjc5pJ2Lu2drPjS3yZdRRZMl7IEAJyH1Y8DkOkZq01P/t2QH
        So5GM2TBOpjrMZJOsJNrjYv7uk0o1jwbMTUCY2Rd/uG91oA=
X-Google-Smtp-Source: ABdhPJzi5fcdLvkVddgR7iLkRSuCPO5dpEuKEL/1e33oXZE1yOELKxwTXra5RS5COHaADFNYoU1741kIMMDJy3KU0Gk=
X-Received: by 2002:a05:620a:2008:: with SMTP id c8mr2524348qka.493.1630749090783;
 Sat, 04 Sep 2021 02:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAG2t84Uaw-Kdp+EXU8CY1QYfykFQj-hGLJnTSH8MYO8Vi_yqgA@mail.gmail.com>
 <C357A648-8B13-45C3-9388-C0C7F7D40DAE@gmail.com> <dbe7d88d-4174-e080-03df-e35d0ac6004f@gmail.com>
 <YTNA6Qo6Yj5o9NmQ@coredump.intra.peff.net>
In-Reply-To: <YTNA6Qo6Yj5o9NmQ@coredump.intra.peff.net>
From:   Fedor Biryukov <fedor.birjukov@gmail.com>
Date:   Sat, 4 Sep 2021 11:51:19 +0200
Message-ID: <CAG2t84Xe2XwdwdAK42bRrwAeNaB3-A+WhgSsJGOoW9-rG1S9Xg@mail.gmail.com>
Subject: Re: Aborting 'rebase main feat' removes unversioned files
To:     Jeff King <peff@peff.net>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is no way this could be the intended behavior, but the good news
is that I cannot reproduce it...
Looks like it occurs only in one git version (2.31.0.windows.1, IIRC).
And it does not occur in the latest git version: git version 2.33.0.windows.2.

-Fedor

On Sat, Sep 4, 2021 at 11:48 AM Jeff King <peff@peff.net> wrote:
>
> On Sat, Sep 04, 2021 at 01:57:11PM +0700, Bagas Sanjaya wrote:
>
> > On 04/09/21 03.33, Fedor Biryukov wrote:
> > > Looks like a bug in git rebase main feat.
> > >
> > > To reproduce:
> > > git init
> > > git commit -m 'init' --allow-empty
> > > git checkout -b feat
> > > echo 123 > readme.txt
> > > git add readme.txt
> > > git commit -m 'txt=123'
> > > git checkout main
> > > echo 012 > readme.txt
> > > git rebase main feat
> > > git rebase --abort
> > >
> >
> > Did you forget committing?
>
> I don't think so.
>
> The point is that "readme.txt" is not a tracked file on the main branch,
> and thus Git should consider it precious.
>
> I don't think the "rebase --abort" is the problem here, though. It's the
> command before:
>
>   git rebase main feat
>
> The "feat" branch is already ahead of "main" (which has no new commits),
> and so it just says:
>
>   Current branch feat is up to date.
>
> and leaves us on the "feat" branch. But in doing so, it overwrites the
> precious untracked content in the working tree.
>
> The "git rebase --abort" command then does nothing, because there's no
> rebase in progress.
>
> -Peff

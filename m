Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F40C433DF
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 17:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87F3821D7F
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 17:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxcIGqdO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731485AbgJNREa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 13:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbgJNREa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 13:04:30 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BA0C061755
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 10:04:30 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 65so280922otu.9
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 10:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p+E0xiu/ARebHNUoQDnsQT8xdaAdEkv9xb56e43jNBg=;
        b=ZxcIGqdOg1e4OHSU6T3qpux8E25uawK4SvIppayUG+Ma43febQKPU4efhgoCfFywGv
         Phmt7+f36jXzy+6aG1NQqYlLPdqvUaUf8ACNrEj4YyENbogC8TkSsBe7mB8cPB+ehNHS
         yBAc84IMvFJQShgTN1CWb4e1WHcQLA5vgS+Nnn/vb11sYVrWerPLt36TdgjxEcqGmmj5
         LGp0DC/VZjKwL/7yZAtv7drFv9h5LwVN3mytt/6kCZxG0Wpf0wYYzzmTouoM7RfgMh0s
         zu8/OABWUrecQwZD+dgOb1prmpDmeFMlRWaOK66QrotFdCGA6YFtiJAGephE2MM2/HvP
         UkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p+E0xiu/ARebHNUoQDnsQT8xdaAdEkv9xb56e43jNBg=;
        b=Et/+FO8UREIwUiIambspYWWCpByE53GzVFIbHDE8ANt0fuoH2ONU3XU9WSCWq32SEC
         yxeaGHKCSEGy9ioNngPN7l4p5xoJ17xkTVB9n3Rdm4jxreZahe/YhEs6IeeovDlHV0y2
         64xOxHd6vIp7MvygApyncCGHJenroVEQVtWrFHOf45SvizcDqPEgTsZAFU7sU6skP3zy
         aea7IHNxUn1ayEaTCMCFGl4MHJ7Ez0zpAeGdhRpFiLSxXYyQw9jYo2aaTSmD1dcibeDC
         6dMiVBcgAyhHMXhxnDC6f8WXTcKLUFsf2n2AV6PuhsZe5h4gYBhlpzu+wOGjozG0vsWO
         a7tw==
X-Gm-Message-State: AOAM531CJ2TC6b1sHnwAKZ0MuusrY5EQp3+qtUordHy1+wFNf1PB+E0p
        XF+5RbmSpKazl2ihFIPIzdvkwX0Yyv1So8EO65V8WsfbQ9Uj6U6S
X-Google-Smtp-Source: ABdhPJwrDkdhTF58N2x1idv+yHqbaNdVnJzap7uw72zNCFYlXTfE8kv+CqOOu0qVzcxOZKaMEH3RN+fqUPcSqtFPubU=
X-Received: by 2002:a05:6830:1347:: with SMTP id r7mr91611otq.172.1602695069585;
 Wed, 14 Oct 2020 10:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAN8Z4-XgctFZxZoTWRpD1V9NFr34ObzG2dxUoAfuJ4NOsBDdtg@mail.gmail.com>
 <20201014165607.GA2044338@nand.local>
In-Reply-To: <20201014165607.GA2044338@nand.local>
From:   Nipunn Koorapati <nipunn1313@gmail.com>
Date:   Wed, 14 Oct 2020 18:04:18 +0100
Message-ID: <CAN8Z4-XGbb_z3vmJYATONmBkxBcfxwyC-_4XEOkP0sxsdT9wxw@mail.gmail.com>
Subject: Re: Partial clone fails with file:/// URI
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've been building git from source and directly using the executable. Roughly
```
cd git
make
cd ..
git/git clone --filter=blob:none file://$(pwd)/git a_clone_of_git
```

This is what I was missing:
git config uploadpack.allowanysha1inwant true

If this is not set, then the checkout fails w/ a

fatal: protocol error: bad pack header

Perhaps the error message and/or docs could be improved here to
something with more detail than "bad pack header"?
Not seeing anything to suggest this in the docs
https://git-scm.com/docs/partial-clone

Thanks for the prompt response. Appreciated!
--Nipunn

On Wed, Oct 14, 2020 at 5:56 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> Hi Nipunn,
>
> On Wed, Oct 14, 2020 at 05:38:15PM +0100, Nipunn Koorapati wrote:
> > Hi friends,
> >
> > When I run a git clone with --filter and a file:/// URI - it fails.
> >
> > Repro steps:
> >
> > I have the `git` repo cloned and built into the CWD at v2.28.0
> > git/git clone --filter=blob:none file:///home/nipunn/src/git git2
>
> I couldn't quite reproduce this. Here's my reproduction:
>
>   #!/bin/sh
>
>   rm -fr repo clone
>   git init repo
>
>   (
>     cd repo
>
>     git config uploadpack.allowfilter true
>     git config uploadpack.allowanysha1inwant true
>
>     for f in a b; do
>       echo $f > $f
>       git add $f
>       git commit -m "$f: initial commit"
>     done
>   )
>
>   git clone --filter=blob:none file://$(pwd)/repo clone
>
> That works on v2.28.0, and v2.29.0 for me. Is git installed properly on
> your system?
>
> Thanks,
> Taylor

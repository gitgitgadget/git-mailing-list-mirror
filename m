Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B56C63793
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 13:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4608261278
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 13:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbhGVMdZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 08:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbhGVMdY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 08:33:24 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B2AC061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 06:13:58 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id a17-20020a4ad5d10000b0290263c143bcb2so1307145oot.7
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 06:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1EWeHDe2ltRH/yjFlIXuhd0ZlTH6yLGOndUawIBfE4Y=;
        b=rVwPtGNU/FVm+AnonfSOfDQ+i5CKqNrZwfg8efH+K2NIjC5P43uFffgBCsU7dHOqlw
         XSFfWSggxNQ6+vXCi/cLb6XilBB3xHJXUKkHktfcViBXdI5esLwcaL4Gfo7c+ykZQHWo
         KI+plykVkKnbTEAekgZOlCyYeedzZrZNqWbmKntFB1LmZ4rCCM50zBxYGx61yhN2cr/9
         iH1XjFcnIBHayXvcxGbgJCwT3GeVsyN0p4UJsoYaNZqb6/bUsEbLHimDYMINnrbNJp3y
         K+LB/WIhiX4fAZQH7wh698gCe8Zuc0j2565FkpqWgWG0Vzbt5DR6/grFf1IjK/q1z4Xs
         y02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1EWeHDe2ltRH/yjFlIXuhd0ZlTH6yLGOndUawIBfE4Y=;
        b=DX6BCHGE4Zg16BhjCnKTmtIdiiPMnuMyGzZy5YN3PK1B2tmWBMCpoXMdvT3MDLTVZL
         yYMWFfcO8bM/OfNTMPfyLHT18p/Q7t23bS+ncmYHUYKOZqzTtaogzGloFBx3w7K20WC1
         FEHfrruqeB94ldhvEfcdJf8Wz56gKJ2bo1wGXHWmJIqXtkJonvfkciyeV6Zp236PJoiZ
         82wbtMUPyiTngAJuzY0tE41rDzAaxIr4NGrs7tVpSVMyWrQ7O4yF4g6kIIrKN2jxTx1G
         yjwLzUJZytOOlPt04EJlQ0VLMQuKHfbiFgpEcRsTDGkQB7cNkWXBN7hglQorOYKrjm+r
         34XQ==
X-Gm-Message-State: AOAM531cVqoin2OKOTMYY4yMsMcmRQ5wcIwvIgnFNlbuBz1oaUlH0SLa
        7/GrTAxA1sfJCLVNWusO/UqMc12WQp+9GtZJwgu59cK3ei8=
X-Google-Smtp-Source: ABdhPJzrhJGhBetTgSO+G5RZEyezIZQ6ujUKPntEFBukbc+m+266KboESNtCAxT6YmaK9auPeLLsu+Q++lTRJsGCArM=
X-Received: by 2002:a4a:55cd:: with SMTP id e196mr27217471oob.2.1626959637641;
 Thu, 22 Jul 2021 06:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAFSh4UzCWMCpOGZUYnrxwK79F6jN3irdNs=J7O6RMCeJbBxFBw@mail.gmail.com>
 <YPimnEtNgKD32r2o@camp.crustytoothpaste.net>
In-Reply-To: <YPimnEtNgKD32r2o@camp.crustytoothpaste.net>
From:   Tom Cook <tom.k.cook@gmail.com>
Date:   Thu, 22 Jul 2021 14:13:46 +0100
Message-ID: <CAFSh4Uyr5v9Ao-j0j7yO_HkUZSovBmSg7ADia7XCNZfsspFUYg@mail.gmail.com>
Subject: Re: Bug: All git operations fail when .git contains a non-existent gitdir
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Tom Cook <tom.k.cook@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The easiest way to reproduce it is this:

$ mkdir test
$ cd test
$ echo "gitdir: /foo/bar" > .git
$ git ls-remote https://github.com/torvalds/linux

We happen to use overlay mounts in our build system in a way that maps
a git submodule from one place to another so that its "gitdir" is
invalid and then attempt a `git ls-remote` from that location which
unexpectedly fails.  But the above reproduces the problem well enough.

Regards,
Tom

On Wed, Jul 21, 2021 at 11:59 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2021-07-21 at 09:17:36, Tom Cook wrote:
> > What did you do before the bug happened? (Steps to reproduce your issue)
> >
> > Add a git submodule to a git repository.
> > Overlay-mount that submodule to another place in the filesystem.
> > Attempt any git operation in the overlay-mounted path.
>
> I'm not sure about what you mean by an overlay-mount operation.  Can you
> provide some specific commands that we can run at a shell that reproduce
> the issue?
> --
> brian m. carlson (he/him or they/them)
> Toronto, Ontario, CA

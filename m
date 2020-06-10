Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E3DC433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 14:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE615206F7
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 14:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8kWuuKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgFJOTY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 10:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgFJOTY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 10:19:24 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB631C03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 07:19:23 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id v1so532512ooh.0
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 07:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DDv74afYKRuFk1mJz8cSL+E5zplk4eX+ZVcXa8yzTYc=;
        b=V8kWuuKQtUsZuqV1Dg/c9Tw7W2Rm4O2D/hhu5mXPd9D4FDMLDsh3waFu1vECzhUXTo
         Vhy4XTSUEWzc6KgtT6aSp4hJLkueIxGJOGjbMASNgZYKvIT+cQsNI2mHaZPFHyGL0CGe
         1X6T3/YDC7ZjqPuVK7IkH5fDRz3tLbPtAb3/QuQBRd1RlOOAyxboy80W7aLwytGU6fqs
         2N9q8FvJTTjjq9+hI0hgJsC+uOYKMbMs4lzNvbS+y2b9xeL/Czt6xMvx+mmZ+UNAPiM1
         cc6jpYWjuqNyBAb8Wp9pc7hINhnSAsF4EHuxFdyIVn+DNOjFDZ1u9y7fd+/EwxyatUMW
         PP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DDv74afYKRuFk1mJz8cSL+E5zplk4eX+ZVcXa8yzTYc=;
        b=r5gTS/ou7D9l9v5sWuin6AGfbIt6b85k6MDtHpYwqraXPCYhZTVJFIdIibrVgNqCsx
         lGT1/HxG/toYZXFzSnCwGS1fJwRb7iMvNoPrWydF0vq9TG+2F0Z61ZJfIMsphgzZguqq
         lI4lGDcnVRT5ZbBW1n71BWS7Awqwl1rezCQV3mfqnLcb1ArwxgRm0x1NfVzXoalZPx+C
         7kkI4GOnf1/DOzG+CXKhP9sEx5OgFyn+DqSVbBlDmYnjRBEmQRVf2drFNC0O2jgfT8FM
         RW8PxouknQC13Bs/b5XCU4MmNCoYPEKure5TCVnZxN/CUa6d8UQzKlYPAR+cnQYUz6TH
         nrfQ==
X-Gm-Message-State: AOAM530QktzLw+RMfn685B0WVR6EJ0NqtUxurPKy5LoB4qN5oN/mx1Ea
        hdjt4EpE756H5bLgdbswP9/lctH/on3PvDa2frLuVYXBIIE=
X-Google-Smtp-Source: ABdhPJwLHupxaYQjmnlePfIOkFgGbMaKF8qmD7OOBwdItcwR67H0+jNbXe2guX0lSDy83np/cvyxmMcs/iQKBZ8QZ5k=
X-Received: by 2002:a4a:374b:: with SMTP id r72mr2677049oor.15.1591798762363;
 Wed, 10 Jun 2020 07:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <CACPiFCJKvnDL9Xj1Xs0RCvuhymjDz4N0hT42dNtBQxp+TLiPaw@mail.gmail.com>
 <20200609231336.GQ6569@camp.crustytoothpaste.net> <CACPiFCK0h0LfdyE6Q=UJkuX+Qdb=rULcgDJwgxQ0w-1O0zpMew@mail.gmail.com>
 <20200610000358.GR6569@camp.crustytoothpaste.net> <CACPiFCKEGXK+TJtQiPub3dW6dYKJ7a=mXL+UCDP57N-3XtRYLg@mail.gmail.com>
 <027001d63f2f$622f2d00$268d8700$@nexbridge.com>
In-Reply-To: <027001d63f2f$622f2d00$268d8700$@nexbridge.com>
From:   Martin Langhoff <martin.langhoff@gmail.com>
Date:   Wed, 10 Jun 2020 10:19:11 -0400
Message-ID: <CACPiFCLEgaCiE_LjdvQLhpFXU2XEZ1gpFEDrMkdwF+p=qPJ3Eg@mail.gmail.com>
Subject: Re: osx autocrlf sanity?
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From my original post -

A few tests.
 - I set core.autocrlf=input globally --> a fresh clone doesn't have a
clean status files look modified right after a clone)
 - set core.autocrlf=false globally --> a fresh clone doesn't have a
clean status
 - set core.autocrlf=true globally --> a fresh clone doesn't have a clean status

... I was an early contributor to git, so I am hopefully not too naive
about the basics. Of course, I sometimes make a boneheaded mistake.

cheers,


m

On Wed, Jun 10, 2020 at 9:59 AM Randall S. Becker
<rsbecker@nexbridge.com> wrote:
>
> On June 10, 2020 9:55 AM, Martin Langhoff wrote:
> > To: brian m. carlson <sandals@crustytoothpaste.net>; Martin Langhoff
> > <martin.langhoff@gmail.com>; Git Mailing List <git@vger.kernel.org>
> > Subject: Re: osx autocrlf sanity?
> >
> > On Tue, Jun 9, 2020 at 8:04 PM brian m. carlson
> > <sandals@crustytoothpaste.net> wrote:
> > > On 2020-06-09 at 23:31:23, Martin Langhoff wrote:
> > > > good question! There is a .gitattributes file, all the files
> > > > affected have these attributes
> > > >
> > > > *.py     text diff=python
> > >
> > > By default, Git will check out files with the text attribute with the
> > > native line ending, and it will check them in with LF endings.  That
> > > can be controlled by core.eol and core.autocrlf
> >
> > Why is core.autocrlf false not working for me?
> >
> > I want to work on a repo that has a mix of newlines. I'd like git to completely
> > ignore them. Treat all files as a bag'o'bytes.
> >
> > Assume I am running git rebase over commits that have .gitattributes, so I
> > can't "just remove it".
>
> We use core.autocrlf=input on all our platforms for source files, including OSX.
>
> Does that work for you?
>
> Regards,
> Randall
>
> -- Brief whoami:
>  NonStop developer since approximately 211288444200000000
>  UNIX developer since approximately 421664400
> -- In my real life, I talk too much.
>
>
>


-- 
 martin.langhoff@gmail.com
 - ask interesting questions  ~  http://linkedin.com/in/martinlanghoff
 - don't be distracted        ~  http://github.com/martin-langhoff
   by shiny stuff

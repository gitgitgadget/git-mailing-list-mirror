Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37206C433E0
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 04:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1454E22CF7
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 04:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBteKIBc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgHGELM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 00:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgHGELL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 00:11:11 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1FDC061574
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 21:11:11 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id j7so769403oij.9
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 21:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LqRZYkNj0/E6WIk+6z2622o+q7kqANDMizarVmV/Q/g=;
        b=KBteKIBcXB/YpnxkAn7dt9fCbz0MbvL39NQZT/GScnBAR5VyKt9Vnl1QCfvoO7Uxtf
         eHgAm4cyau8w/6bXAk8aZORh0kP98XLi0cDnvA4qdswKZJSOgbErB+eOYJSHnmjOPSnI
         88WjysNUc46+bxjjbYQ/wr4Yaz/BfB7/mSHe4eFj/ciE8vWpXf2nqfRUt9vmtSOA+kf+
         cg6Of1PEwDDu4rb/S9dVQzv3dkXDlVk7R8rQge6Mi+Vtethcav2lK5qnTpg22E3WKaUG
         xvPyvCEmzwlnI/DjjBFcptDwFJiHQ03MUejkXEeiVpiJhy5S0MVuGMMBLVEVJ4SKzIrD
         fdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LqRZYkNj0/E6WIk+6z2622o+q7kqANDMizarVmV/Q/g=;
        b=qav09LBPeGvgXyV7whYj8OqsB/+BBoIWjqw2mvL5VZUZyMfjxhKw7MoazG7hjdOs5M
         wb+Aa3pbj5bFr9I8wZ+4aaqh8mUd05Aiw7/lbOxd2TS2LGjiZ5qYfNYtXhVGaPPKVNYb
         2KthfqPjLXs5VKTVQpha80gpVzM8TWQhtZLvSsO/RXMaBenGVmlObFQoLrEzjLNWRLMn
         pFL0K+penO82JzQjQOE1NHNEwd7qQfKaK4VqKmoNHQVveBbPSj/YCXr6mCYRSsydTHVs
         mtB8ik8HI7A2Ulu42IRil7/PjQ1UDN254ShkXpZD8JeEUb7DYgEjl1GdIALKVBxu9zNt
         Ur/w==
X-Gm-Message-State: AOAM53206k39Loux3ehQN6ju2VMe+afxDvEVWp5XzwjLFX/EG6eSbwQZ
        JssSw/0tgAZcxQF6dZvheI1cJ2o14rZeRHCxFbPTwAR9
X-Google-Smtp-Source: ABdhPJwjr8rz4KSDnJJPrmL2zrzmILTgNNcy+oBdzvLb0u+BfiWf0ervhG3m2KwGjDIil9MX+DuwFZ0b2Dyah5q4wmQ=
X-Received: by 2002:a54:4099:: with SMTP id i25mr10221863oii.39.1596773470618;
 Thu, 06 Aug 2020 21:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <CADjceoQxoL932W4mkfhG6VOgrQBhs9k6tXkWSkraKVPmUP+uCw@mail.gmail.com>
 <878ses4pay.fsf@kyleam.com> <CADjceoRtFmM2H1z48HcmvWBF1KmMrwMnE6YdC9HJGFjdXXivJw@mail.gmail.com>
 <8736504k06.fsf@kyleam.com>
In-Reply-To: <8736504k06.fsf@kyleam.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 6 Aug 2020 21:10:59 -0700
Message-ID: <CABPp-BEmrcY8wr_rb+Y4gacNEeeEPTUxWw2Mq0A9LMzpx2bQnA@mail.gmail.com>
Subject: Re: ls-files bug report
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     christian w <usebees@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 5, 2020 at 6:54 PM Kyle Meyer <kyle@kyleam.com> wrote:
>
> christian w writes:
>
> > Sorry for the insufficient reproduction steps.
> >
> > I managed to figure out it has something to do with git repos within
> > git repos. It happened to us because of go packages that are inside
> > our repo. These are the reproduction steps that work for me
> > consistently using Go version go1.14.4 darwin/amd64. This is the repo
> > that gets cloned into src/golang.org/x/debug by the go get command:
> > https://github.com/golang/debug/tree/66ec140f2f72d15dc6133502edd2bb7238b1740c
> >
> > $ mkdir testdir
> > $ cd testdir
> > $ git init .
> > $ GOPATH=$(pwd) go get -u golang.org/x/debug/ || true
> > $ git ls-files --others '*.txt'#
> > src/golang.org/x/debug/
>
> Okay, removing Go from the equation:
>
>      $ # in fresh repo
>      $ mkdir a
>      $ git init a/d0
>      $ touch a/f0.txt
>      $ git ls-files --others 'a/*.txt'
>      a/d0/
>      a/f0.txt
>
> It looks like the spurious a/d0/ entry doesn't show up until v2.27.0, in
> particular 95c11ecc73 (Fix error-prone fill_directory() API; make it
> only return matches, 2020-04-01).  Adding the author to the Cc.  (Sorry,
> Elijah, I recall your frustration with dir.c from a previous ls-files
> issue that I reported [1]).

Thanks for digging in and coming up with a smaller list of steps to
reproduce.  You are right that I dread reports that touch dir.c -- if
I would have just ignored the first report back in March of 2018,
there's a really, really long list of problems I could have avoided...

I'll try to take a look in the next week.

>
> [1] https://lore.kernel.org/git/CABPp-BFG3FkTkC=L1v97LUksndkOmCN8ZhNJh5eoNdquE7v9DA@mail.gmail.com/

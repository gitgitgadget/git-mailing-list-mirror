Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB90ECAAA1
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 17:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbiIIRd2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 13:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiIIRd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 13:33:27 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D4C130D38
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 10:33:26 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bz13so4008444wrb.2
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 10:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=hoKlTsppxnCF1wEHd3OfcSSRdWNldnN1+JUp5X4ez3k=;
        b=dbDtByZZoXWmeGUI+LolJyPhXbSXO8jz1oOvwKcL5u+olm1QsCSm7dohQqrAxEqCLy
         5MS5+H2J/F8zaVGwnW5n6NhnYgrA+IKtI4d/IlBajJJkWTLdDbLG5XhQvfML+03pHJx6
         3f0lkOZ7pvSLUGJ/9v1EOtHKxa3PH0JcLpCyme+lOzg5ojYtuo/ZE5JL2hHve6n51UmD
         nAIwzack3gwqu4K7IfaVwzpVKo5b8U3N/bymZIiFX64X/ozcF65wd7ay9PPJxMDBGW1P
         V/pAQ0CQp5hSQKZauOBatJUNTl3vzspnBV5eU5XBF/t7u/oZaAD1QyB0iqYFDCiSBw69
         Mmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hoKlTsppxnCF1wEHd3OfcSSRdWNldnN1+JUp5X4ez3k=;
        b=yG2QGVosDAxuhbGzOCiY0YCLznWiz6ihNTAjUzm/6lYuJDYY79Z2kFyxAHZa9Pji/W
         pXrolPEBAxqzrruRYGscK2kj964c+X2g0u3JzgfFKLZV264hRITkGo3NqYhofMJFWO4c
         uPI9S+yhsSCvw68xO3RqXdskhAxzTyk3D5LXXSz7hvIDgsPLfoJrb3VGYu1kGX9PkuxX
         VD426ViCw3wtUk8G9rUx/u+3BcHEBCOTb4AqPi7vY4bnp0gqlotEWaopko2H4PONfDDC
         smKJei6Ytb2qW0Q6WNrPUuEoWHOIeUNnootT5L1KsfkFdkmQCyhGoS/TCROkEQEmVCLd
         58NQ==
X-Gm-Message-State: ACgBeo2OMeZXxPV298KTk/sRANTYlxjLRp5EFOb6fuKH7FJ9ymF7EsdA
        lUBq7O/XE3Uub5B/1Egzj3y14TuWQZIegHuF9wmdQK7p
X-Google-Smtp-Source: AA6agR5NViWW2CkJ6rMbI4ChcIqZM+MOkwwBjXeLFGZOGi0o2o5eIOECYfvYU+hA0PEBTLsfs2HZcYBHliWnISOg1sY=
X-Received: by 2002:a5d:598c:0:b0:22a:47b1:d367 with SMTP id
 n12-20020a5d598c000000b0022a47b1d367mr66076wri.612.1662744804964; Fri, 09 Sep
 2022 10:33:24 -0700 (PDT)
MIME-Version: 1.0
References: <CA+4x=b_07g6STT0nvma_gRhv=zdj+7TQx5SxKLUtuqONLwv=TQ@mail.gmail.com>
 <YxKo2l5nBoOa9Jfa@coredump.intra.peff.net> <CA+4x=b-GYMnZygHXOfNb3CdSRoxUeT80n=gSCLyfCA9WsB0wEw@mail.gmail.com>
 <Yxf9yETBi3k6Wasl@danh.dev> <CA+4x=b9M+HRWdDx-Mr4q0NiRQESwJ5uEkOBL_nVPPPHhXs7i_g@mail.gmail.com>
 <YxjhQ8xVI4YtA7xb@coredump.intra.peff.net> <CA+4x=b9upd2uTihZK5hXDULkCz6y+CX-dS7p65Pfhn0zh0eMiA@mail.gmail.com>
 <YxkI2zqCheqTv/wc@coredump.intra.peff.net> <CA+4x=b-SqzGfeTu4c8akk3quYF7ORZ5jYCpey5221H8=+_PfRg@mail.gmail.com>
 <Yxow7zrYF/xOijVr@coredump.intra.peff.net>
In-Reply-To: <Yxow7zrYF/xOijVr@coredump.intra.peff.net>
From:   Lana Deere <lana.deere@gmail.com>
Date:   Fri, 9 Sep 2022 13:32:49 -0400
Message-ID: <CA+4x=b_eOO=ThnSkMARPXBH6cJLeuYPfF-PZNy4Vjpbk=BWQYw@mail.gmail.com>
Subject: Re: 2.37.2 can't "git pull" but 2.18.0 can
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I can use a workaround to continue testing 2.37.2, but I saw in a
different mail that there has already been a patch for this problem.
I'm guessing that will be in 2.37.4.  When would that be likely to be
available?

Thanks for the quick patch, by the way.

.. Lana (lana.deere@gmail.com)



On Thu, Sep 8, 2022 at 2:14 PM Jeff King <peff@peff.net> wrote:
>
> On Thu, Sep 08, 2022 at 12:46:14PM -0400, Lana Deere wrote:
>
> > With an explicit -c protocol.version=0 on the 2.37.2 git command line,
> > the pull is successful.  For what it's worth, the server git is still
> > 2.18.0 in all of these cases.  Only the client side is being tested so
> > far.  I will try to gather the packet traces and see if there's a
> > problem sharing them.  Will this mailing list allow attachments?
>
> You can send attachments to the list as long as the total mail size is
> under 100kb. But to keep the list in the loop: Lana sent me the traces
> off-list, because naturally they have a bunch of semi-private ref names.
>
> I was able to see the problem from the traces: the v2 protocol has an
> extension to tell the server to limit the advertisement only to branches
> we're interested in. And it does so based on the configured refspec. As
> Dscho noted earlier in the thread, the upstream branch you want isn't in
> the refspec. We try to add that branch explicitly to what we're
> fetching, but I think that happens too late to affect the ref-prefix
> limiting. So the server is asked not to advertise the ref, and from the
> client's perspective, it looks like the branch does not exist on the
> server.
>
> Here's a minimal reproduction:
>
>   # a server with two branches
>   git init server
>   (
>     cd server
>     git checkout -b branch1
>     git commit --allow-empty -m foo
>     git branch branch2
>   )
>
>   # and a client which points its origin there,
>   # and has local copies of both branches, tracking
>   # the upstream versions
>   git clone server client
>   cd client
>   git checkout branch1
>   git checkout branch2
>
>   # but afterwards, the client narrows its refspec to only fetch branch1
>   git config remote.origin.fetch +refs/heads/branch1:refs/remotes/origin/branch1
>
>   # pulling branch2 with v0 works
>   git -c protocol.version=0 pull
>
>   # but does not with v2, because the ref-prefix extension tells the
>   # server not to advertise anything outside of branch1
>   git -c protocol.version=2 pull
>
> This is a bug which we should fix. But in the meantime the obvious
> workaround is to expand the default refspec to cover both branches.
> Obviously the default of fetching "refs/heads/*" would work, but if you
> want to keep it limited for some reason, you can add the second branch
> explicitly. In the example above, it would be:
>
>   git config --add remote.origin.fetch +refs/heads/branch2:refs/remotes/origin/branch2
>
> -Peff

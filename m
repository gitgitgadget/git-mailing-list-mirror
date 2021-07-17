Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011BEC636CA
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 22:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C384D6101A
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 22:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhGQWpg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 18:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbhGQWpf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 18:45:35 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1943C061762
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 15:42:38 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id d9so15084373ioo.2
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 15:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J+xxxfMO3osy1EygUraFVYN6Rbrt5wqonwkIHgYMP0s=;
        b=eXOOnIQqxwh9TxZrfduIG31zStZBh2RrOH1332GaLTXvHLGoe9psIQ4tUZzWiJrmk7
         8poK1CV689amgvlreS+6xoOkbWGmQINgyIwfMaYZjSOJgZAykOrdVbRRC/nhPKooROkj
         VB2XFHkFZdIA0cIFA9RadFYEqbEqCqmHwRq5iu46tkOqMgvMz/OlLA4H6Pt/Jyqiuhal
         S5F84nT4Y3/vykM2Wv4k1GdCPFY4q/UA8e6I7SnEPr54Sn4zQOnicc9oBD3J3E9g1Gx6
         Ty/ZZIdNFPQ65cYukg5u/qYOf2ohhe0UOrh5PANbp28PwHV3XSwc8viHXdhGOVJSgx8k
         lWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J+xxxfMO3osy1EygUraFVYN6Rbrt5wqonwkIHgYMP0s=;
        b=YZAzmUQi8ypV5p7JseZ6KMhL6wqhIYSAM9fW4PI3QlW1nnRD56DE3MjbHtkop3No7h
         vwBW0eoBIufzfFxoW0vS5HMWhLsM7iszY/D/W8LUoKf+5aQ4nRZYtGY5urI4ASbs5dD9
         CZDaA9c2VkFFzW0vDnL5IEE3rixRgZNncwBBNHOqJCOe+kU5+uEjFj3wlPh9Y8QXAKfe
         yvXj7OzUVALPUFezZ01GTWj7Z647PJ8l4o/dPq5ugkZR12Z/lgBmTEuBLj14BHQfUBEz
         xh0esBU4vJHXkDERplsNhpL6PKo1R0QwzULblAediYsV75cLkxh1BajNk5x634NOzHGj
         QCFg==
X-Gm-Message-State: AOAM532vVOeoSkG2bptTMmS2bY6iq2HvA31OYRQWyMchP+kAXPzh7ctq
        hxxoXhNlw0bNd9KKW1ge6NqfQxuxPg0kYRfEtho=
X-Google-Smtp-Source: ABdhPJxEbbPp57w8xAxOtQBYQFpE0At3sQrC+Z/KZvdSawOLuhCroiP7/05e9Dk4EcXjQRi9spYC7j0i4RbWPNdTHWk=
X-Received: by 2002:a02:c8d0:: with SMTP id q16mr14937665jao.110.1626561758040;
 Sat, 17 Jul 2021 15:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <CANt7McFAu5gAFcgd+dejQjDQDxfcnyhz=BxSAejXGMMtGQzO_w@mail.gmail.com>
 <20210717170536.x2n443dtejk76wfp@tb-raspi4>
In-Reply-To: <20210717170536.x2n443dtejk76wfp@tb-raspi4>
From:   Rostislav Krasny <rosti.bsd@gmail.com>
Date:   Sun, 18 Jul 2021 01:42:26 +0300
Message-ID: <CANt7McECMjz_=EnB5NxeY9sHSzjNLXtkrqPhyLArBXJswM4xQQ@mail.gmail.com>
Subject: Re: Incorrect and inconsistent End-Of-Line characters in .gitmodules
 after "git submodule set-branch --branch <branch_name>"
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 17, 2021 at 8:05 PM Torsten B=C3=B6gershausen <tboegi@web.de> w=
rote:
>
> On Fri, Jul 16, 2021 at 12:55:07AM +0300, Rostislav Krasny wrote:
> > Hello,
> >
> > Originally this bug was reported in the Git for Windows project and
> > contains two screenshots:
> > https://github.com/git-for-windows/git/issues/3321
> > Johannes Schindelin (dscho) is convinced that this is not a
> > Windows-specific issue. Following is a brief description of this bug
> > as I've faced it:
> >
> > After running the "git submodule set-branch --branch master -- ms1"
> > I've noticed that the .gitmodules file is encoded with both DOS and
> > UNIX End-of-Line characters simultaneously: all original lines use DOS
> > EOL characters but the added "branch =3D master" line uses UNIX EOL.
>
> First of all: Thanks for posting this here.
>
> Then there are some questions, at least from my side.
> How did you get there ?

I just tried to use submodules and wanted to change the default state
of the submodules (from detached HEAD into some branch) after cloning
their parent repository together with the submodules. Take a look at
my question to Brian in this thread.

> In which shell did you enter the command ?

Git Bash inside MINTTY of Git for Windows

$ bash --version
GNU bash, version 4.4.23(1)-release (x86_64-pc-msys)
Copyright (C) 2016 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.htm=
l>

This is free software; you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

> Could you run
> od -c .gitmodules
> and post the results here ?

Sure:
$ od -c .gitmodules
0000000   [   s   u   b   m   o   d   u   l   e       "   m   s   1   "
0000020   ]  \r  \n  \t   p   a   t   h       =3D       m   s   1  \r  \n
0000040  \t   u   r   l       =3D       .   .   /   m   s   1  \r  \n  \t
0000060   b   r   a   n   c   h       =3D       m   a   s   t   e   r  \n
0000100   [   s   u   b   m   o   d   u   l   e       "   m   s   2   "
0000120   ]  \r  \n  \t   p   a   t   h       =3D       m   s   2  \r  \n
0000140  \t   u   r   l       =3D       .   .   /   m   s   2  \r  \n
0000157

> Or is it possible to set up a dummy repo, which does show the problem,
> somewhere ?
>
> What we appreciate is a fully reproducable receipt, so that anybody can
> reproduce the problem.

Try to do the following steps on Windows:
1. Download https://github.com/git-for-windows/git/files/6835344/git-tryout=
s.tar.gz
2. Extract the tarball and go into the git-tryouts/local-parent directory
3. Run the "git clone --recurse-submodules ../parent/ ." command
4. Run the "git submodule set-branch --branch master -- ms1" command

Now you can check the content of the .gitmodules file for the EOL issue.

Optional steps:

5. try to commit the new version of the .gitmodules file and push this
commit back by "git push" command
6. Delete everything in the git-tryouts/local-parent directory, for
example by the "rm -rf .git* *" command
7. Do step number 3 again

There is yet another inconsistency. Right after the commit or commit
plus push are done the .gitmodules file still has the EOL issue but
then after deleting everything and cloning the whole repository again
a different version of .gitmodules is created (because of
core.autocrlf=3Dtrue). This inconsistency seems to be general and can
happen with any textual file on Windows.

>
> I have the slight suspicion that the CR as part of CRLF had sneaked in
> somewhere via the command line. But that is already a speculation.
>
> And I don't know, if there is a problem at all, or is it just cosmetics ?

As I already answered to Brian I don't know, at least in the vi editor
it looks broken because of all
those '^M' symbols.

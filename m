Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7418FC388F9
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 13:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DD932075A
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 13:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="PACY0ajz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732309AbgKWNXh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 08:23:37 -0500
Received: from mout.gmx.net ([212.227.15.18]:36539 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730646AbgKWNXf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 08:23:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606137812;
        bh=ztyw4lvt3mlua4qCatrlBGiSgGHNHtGMtfY38f+eMIk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PACY0ajz5Jt2PC5Rr0ilD68Y+swCEa/Pxi9883/EqqbMyljq6fWzHEnAW5thEY61+
         Ewav645v/H3plShvZXE6mh2DONsHlBDJ0jkLCugDBEi5HyNLK83Sl6I/3RQUoSiLVy
         hi6rVCw5XTa8FYgiN0iU37XYck5iF9eL1iTlI4ck=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.22.105] ([89.1.213.133]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MStCe-1koNLO1geU-00UIIo; Mon, 23
 Nov 2020 14:23:32 +0100
Date:   Mon, 23 Nov 2020 14:23:30 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
cc:     Johannes Sixt <j6t@kdbg.org>, Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] rm: honor sparse checkout patterns
In-Reply-To: <CAHd-oW4OVDvfkaMjsO4vLvwrnHbyhngwW2y6AkoScJmS6XGVeQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2011231421520.56@tvgsbejvaqbjf.bet>
References: <9f2135f90ffea7f4ccb226f506bf554deab324cc.1605205427.git.matheus.bernardino@usp.br> <CABPp-BGkkNwdjLB4HSygvU43OZRiuhDyt7RjrDGodWrfNgkBXQ@mail.gmail.com> <70ae5b1d-b1d2-1b3f-11cf-8e5ceafe6048@gmail.com> <CAHd-oW7X3fEM8PDFWQVc4kG_vfkY4LbvADzJfQrocjyaAr28TQ@mail.gmail.com>
 <79313c8c-c927-78d4-bb1d-024f9feb553c@kdbg.org> <CAHd-oW4OVDvfkaMjsO4vLvwrnHbyhngwW2y6AkoScJmS6XGVeQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:E1nJWcFzr/zZQXleXJO2Ox5jXQjIktHRJkGV+zEs8NQr/lbRQbd
 4Aq602F7Goyt2FluaTZhrjlzpLc1K6JjYke1dtcEAPeacYCCIM4FVHqXOwI4ckwet4FighF
 I3VshGDob+vX9kBecdS5iZ6cD8t4CYNOuou/tQTlp7quJ622YNFyp7Bnses6PFQVqY/TBuY
 bxPhb4l0NpKjGmCO4B1cg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BlzUl7mHBO8=:/f2i9rMYIoQPt6FZbxtt2K
 v5dzkIAemLfHaDG3Yt/fd1KREThRyXFz/7pqsfIgPL9Li2E4NnKrv/tfHm5ttDW0XGq+2+95C
 +0V/Mt4MoOTXnoYokMWR4sp5KASy4gADNxuawry8WOnKWYj2ijuwmonWkz0GJuAwqIkwN1tKR
 Gc8ByjXC1o69fve6IovTZBoiYKQjIQUvOt8Une+Wan75t6yl3mZTGyWvJAOg2VgYjQ99YCYf7
 wLZNUE+oQzGmE9MFnpE5V/wOHA1hgpDFH0u8Yv9hVUP1TDkHgOQ8/uBpRSrBBupFIaPgWNf39
 FbWfeO/i8eeu3rGRoJK2NQGVIXeDG7mWUN/+YZuFcvETtQ/aOLNPZ31jEDapRGBvhURT5dlh5
 mRJ9n27MxLf9jimD8woqYneKP+TMpKOgB2B1B4fG9+MyqHQ+bXuI5gD01E/YDNvW32VkpHNwb
 +8uDVX5/eml4OsGL0hioxQudaFxqfpmbv5ZIWzkzZpoY0J1XngGUbU9opvzcSQTq8xzuFIsPI
 Yeo7NcnriToKIaj8ZZhNEwVKB5HO9SW0n1ofo50GOv3uzbyHXxMb68A31vNCuoI9wDjVFIwG5
 HWyFlJlVEz32Iu07pjsp80nmOF6TJ9LLQMZUNQ2Je+TfMQEo/HSLLteaECCtPJjSs04ZAg8Ft
 X2as1fsVRm6UMI1cFbOwfzDpAOb4eByTgvmJvqkqSEYTR09wovOVnyhBAkW+kAHQHJk322Kl7
 96c4Qjvq002Yc71Te6HdX8V5nG9HXMmCjvekBHKf3GmnO2Xc3ZcxhvQ5kURhVTJ4wTQzgOfse
 pFvsQdpKRcgg9+IWnHQUt73q+c/Io30RPdeJ1+EnHuqodO89xZ+DZoQBiAjngRjn3o1tEr9IW
 bzMfJPqFOtKrr/qWxVxrjymrXyIsFgnigV8wqlnxs=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus,

On Mon, 16 Nov 2020, Matheus Tavares Bernardino wrote:

> On Sun, Nov 15, 2020 at 6:42 PM Johannes Sixt <j6t@kdbg.org> wrote:
> >
> > Am 15.11.20 um 21:12 schrieb Matheus Tavares Bernardino:
> > > Thank you both for the comments. I'll try to send v2 soon.
> > >
> > > On Fri, Nov 13, 2020 at 10:47 AM Derrick Stolee <stolee@gmail.com> w=
rote:
> > >>
> > >> On 11/12/2020 6:54 PM, Elijah Newren wrote:
> > >>>
> > >>> Do we also want to include a testcase where the user specifies a
> > >>> directory and part of that directory is within the sparsity paths =
and
> > >>> part is out?  E.g.  'git sparse-checkout set /sub/dir && git rm -r
> > >>> sub' ?
> > >>
> > >> That is definitely an interesting case.
> > >
> > > I've added the test [1], but it's failing on Windows and I'm not qui=
te
> > > sure why. The trash dir artifact shows that `git sparse-checkout set
> > > /sub/dir` produced the following path on the sparse-checkout file:
> > > "D:/a/git/git/git-sdk-64-minimal/sub/dir".
> >
> > If 'git sparse-checkout' is run from a bash command line, I would not =
be
> > surprised if the absolute path is munched in the way that you observe,
> > provided that D:/a/git/git/git-sdk-64-minimal is where your MinGW
> > subsystem is located. I that the case?
>
> Yeah, that must be it, thanks. I didn't run the command myself as I'm
> not on Windows, but D:/a/git/git/git-sdk-64-minimal must be the path
> where MinGW was installed by our GitHub Actions script, then. I'll use
> "sub/dir" without the root slash in t3600 to avoid the conversion.
> Thanks again!

In the `windows-test` job, the construct `$(pwd)` will give you the
Windows form (`D:/a/git/git/git-sdk-64-minimal`) whereas the `$PWD` form
will give you the Unix-y form (`/`). What form to use depends on the
context (if the absolute path comes from a shell script, the Unix-y form,
if the absolute path comes from `git.exe` itself, the Windows form).

Ciao,
Dscho

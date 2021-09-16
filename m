Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBB8C433FE
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 15:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C79261212
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 15:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240329AbhIPPwH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 11:52:07 -0400
Received: from mout.gmx.net ([212.227.17.21]:53683 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240260AbhIPPv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 11:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631807400;
        bh=NqVVwzeNWwEQk/AH9IAdroOp0Zewk+TH9OlgrOa/d6k=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=g0JiMKjsxv+7t975Uxx7FMptmex2oLUzPZJetuPKZr2DlSyfUznIeFvRfSDA9RvsA
         GxiUhFM5epDdPunCK2QsF+Ll+02twmrfCHQW3mvH78w+ZomKoBFqEmFZFSqP7Qs54B
         M9pB9YEbSMB9D/w0gTOx0jhN3MbIBtKEhP8M9XCw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.149.64]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5GE1-1ms9GP20rV-0119As; Thu, 16
 Sep 2021 17:50:00 +0200
Message-ID: <b14d79e49e3abe3fdf00cf18bb8c992b4575c5cc.camel@gmx.de>
Subject: Re: data loss when doing ls-remote and piped to command
From:   Mike Galbraith <efault@gmx.de>
To:     Rolf Eike Beer <eb@emlix.com>, git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tobias Ulmer <tu@emlix.com>, Junio C Hamano <gitster@pobox.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 16 Sep 2021 17:49:59 +0200
In-Reply-To: <2677927.DK6gFqPMyL@devpool47>
References: <6786526.72e2EbofS7@devpool47> <2279155.Qy0YqsFniq@devpool47>
         <85a103f6-8b3c-2f21-cc0f-04f517c0c9a1@emlix.com>
         <2677927.DK6gFqPMyL@devpool47>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.41.2 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zjb95XSYmLriFpx4k9d48zBomGRzo4W1Dxm6ED4bwUcICm/rtFS
 czgPSnlJ4tsxdnUog5ZG9/aWPVpAuGYE/LH/jhWI9jcN5zvEASQ8vqa0pspfuM7tw8rm3Cr
 Uzt0q1r6QnDg1azxS3A7v8T6uaMXk0zpS3V+sXs/HVlWe5oJNoX8xByhCmWbszEBPSLcvw5
 K+ZPX4WLA/Cu4ZWUSdxvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5l5HbZwJxpU=:GKFoQbq7FgUVIanhTs1VGP
 AWai0zr4lJMJp+xS1zat4NAvoj4vTf3Jk8zOJb6n2uNyp9H76phPuOvE7MiUfsNJZ+0nwlZiI
 cBN/qy23GKuKV+5joQ9zo5qlPYqEpGnu4/yGnwjivRq1ZvdAd/Vz8yV4OP0nkba9A3MFtksnS
 roVtbfV2OwQXdH7NVHNIPhW3bc1TPhM6fzCYchcOPD/r0pJbY+0trpa4nDohYEOcqzheXuuXT
 C+inJPzh1M2uu9wIjAVB38oyLvhH0SFSmwue2XaVR4XVMeMvvO/VC70XpoiJ/fJCu9j9g8njU
 oUzS+ZWjtXqvxdna/ZScXJIUKQH1xUcbZN7/8uQp9ChTj8uq+uJoUhnxfs4QC+JpiR+34CUkB
 KGZPL34GiRrLTkj8Q6cb0eT11UgIAwVxES0r9tHhDJqFKLAGln536YjOBtcy/QD4ALGFx6DU6
 iw6AXaEOpEPrezy7eJqwsjR6oH6obpU+G94ZO6crmtDwb34YHRweNbnaEPPEPR+ZzVCDLzLLe
 jBryg9eYCFzVeyow1uRJ4MxvoNcbGLP8Y/0Xlby6Y1bMOk93HR7d1j23UTNjMCNoOewnA5z7d
 HLClfvrTJZVqeOyI7WL/TJtZbuXo42DMcuKEYu24235PTpOHbwx/ikJIpWFh6XXA45wkmjwip
 raES7ygfsqGSWsq8vKbRiMRd5FGCMjmoEaeq9tRvYfVxo3J5CKODXEZVbQFd2hR91LPQM738u
 3Rwa+eIXn/u2FRId3m94SJ6p+94M2kMP6Wuw/GmzNl3ulOBR7mk75VSWpa93oLNaMvRlhgucs
 xuoIhp4DYy64vxLtytl1aexUI5V4SNCM2uiQj6LGbJ1864JkNyRixIffkCU1bIdlN1JZZj8h3
 5W0aDgcuktu299WX4GI/a6+hqNhHwkLHhn7SY9RuhGKbhALpQr+2XFPkcT65jliAFOkoxvKqo
 IeFT9Bo3sD3YJPQu7/KzEP9rjNRH73yv3xan6HDDyPlHwFh6Bkp/JiOx+I3A4AJ1etgzDta6z
 US6ji5yT7i9Zc9CsIk8s661qjfm8xMBQADNU+8tXSbjV/d5NinRwHUd2i5V7v9+Sai9Q4Hulf
 T+29SxldoE+hwk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2021-09-16 at 14:17 +0200, Rolf Eike Beer wrote:
> Am Donnerstag, 16. September 2021, 12:12:48 CEST schrieb Tobias Ulmer:
> > On 16/09/2021 08:38, Rolf Eike Beer wrote:
> > ...
> >
> > > The redirection seems to be an important part of it. I now did:
> > >
> > > git ... 2>&1 | sha256sum
> >
> > I've tried to reproduce this since yesterday, but couldn't until now:
> >
> > 2>&1 made all the difference, took less than a minute.
> >
> > Different repo, different machine, but also running Tumbleweed
> > 5.14.1-1-default, git 2.33.0
> >
> > while [ "`git --git-dir=3D$PWD/in/linux/.git ls-remote origin 2>&1 | t=
ee
> > failed.out | sha1sum`" =3D "7fa299e589bacdc908395730beff542b0fc684eb=
=C2=A0 -"
> > ]; do echo -n .; done
> > ..........
> >
> > failed.out has multiple lines like this:
> >
> > --8<--
> > 4e77f7f1261f65cff06918bc5e66d02a418fc842=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 refs/tags/v3.10.18^{}
> > f7b8df0cc81cf82a4ac6834225bddbe46a340455a4a5d52f29d08d923ce8d232b0b497=
da674d
> > d2c refs/tags/v3.18
> > b2776bf7149bddd1f4161f14f79520f17fc1d71d=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 refs/tags/v3.18^{}
> > --8<--
> >
> >
> > Running the same on Archlinux (5.13.13-arch1-1, 2.33.0) doesn't show t=
he
> > problem.
> > This may well turn out not to be git, but a kernel issue.
>
> Linus,
>
> since you have been hacking around in pipe.c recently, I fear this isn't
> entirely impossible. Have you any idea?
>
> For easier reference, the complete thread is at:
>
> https://public-inbox.org/git/85a103f6-8b3c-2f21-cc0f-04f517c0c9a1@emlix.=
com/T/
>

I use git-daemon (2.33) and reference clones for my local pile of
kernel trees (74), so out of curiosity, modified the above ls-remote
loop to fit one of them, and tried to reproduce with both master.today
(ff1ffd71) and SUSE's stable branch (where Tumbleweed gets source,
currently at 5.14.4).  Both kernels failed to reproduce given a few
minutes each (zzzz) to do so.  I'm running Leap-15.3 vs Tumbleweed, but
that shouldn't matter.

	-Mike

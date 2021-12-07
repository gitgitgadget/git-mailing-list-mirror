Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CBBC433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 21:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237407AbhLGVtF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 16:49:05 -0500
Received: from mout.gmx.net ([212.227.17.20]:54321 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230374AbhLGVtC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 16:49:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638913523;
        bh=RNxPF7qxpeIaI7Wr4kgEL6rTCijB2mZcJkpS5YcZswU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=irxln0Tb0KL6i2MoxqWXxoRzv9Xdtqc5h3hrVaSaqYldAWUX68oWTDsiI27m63xT8
         HvLTcpglW0+s2fQLxjmXwe23ub4+TQ4aJwZTZgGtN7Yu18mMYPkfzTQUsRCT2ZLTC6
         Q2fk/47ZfidvVbZlO4tCnKqoc3MaaJKSWkGDnZYg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.164.160] ([89.1.212.223]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNsw4-1nEQyx0ceG-00ODFu; Tue, 07
 Dec 2021 22:45:23 +0100
Date:   Tue, 7 Dec 2021 22:45:20 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     James Limbouris via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, James Limbouris <james@digitalmatter.com>,
        James Limbouris <james@digitalmatter.com>
Subject: Re: [PATCH] subtree: fix argument handling in check_parents
In-Reply-To: <nycvar.QRO.7.76.6.2112031610590.63@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2112072243310.90@tvgsbejvaqbjf.bet>
References: <pull.1086.git.1638324413653.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2112031610590.63@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UfXBlfsb34DqhA58uzzRvWYPcz17/pN4RpE3WEHE90vL3avHYCn
 vsKI7KB/EtrU+iSnXG32+jn3eOwiFxd7RU5XzJDHioU9nIiDt6oEZqsOCBDDo30fPzUmbKC
 OquHG2/DJaH8hlaQZr8Oy3UWneZ6uDXHLigZn3d+kLpxKmR//MXgwNrxLc8tslYbN4nKqVJ
 SQX2IvKrTRA5r+T6qijVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ju2puEGJZ7I=:WvnedkHny/20fx+uZKPP40
 jt26utnNzj8qiv7HffwmrXLP4pIuiGlyRGcTGRDbnG3HMnMNNx8Lbv15zF12C5pdnFTVm9WeG
 m5U0UKKe4ma+8hDBHcu2r2TQPTj6CI3pm9vHdoHwuT1vbV3M9b6gdOtyemAr4DpsJo+Qi4raw
 yS4dC8pX81Rhb7vw7c0+sguKpGbP8WGkhiHIT3i6rfdEOasXUPrNilec7Bu29x5YH6eco2do4
 ZU1aNL0pXtoiPZUM0qrshh1gtT89oG4+z3jc7Sn7oekWliMpX98bKT4Mc2U9irElYZ0BqmbEY
 iEZ3G67sE+Zo4oCd5jiyPYFNCrcRNvSUgE8TfcKJ9Y7ZFX/IbUJ5hx7pAPw+zHwqhE75oGIaE
 OC6WHsVbsjmvW8Ptgtb1ycuYrKt4JU0nDbZhijfOhH55ioYXFsQlJIS8+y6AwjXYSs7aDkGX/
 UDLJvSEgu/qPcud00Q7bpIjciPdGvGU6U0XbPceWKgrOfVbx2NPYEVHrE3Uqo6bxvUblD1gjs
 lQgfV2qqM4TYGvncYqvIB9N3vW+DiE1KAK8R+S+2ilR/oboyUboxcEm/Uro0ucSLSNmivGgq1
 mrQ6FPBVklD4oVqPr7R+JNuGz+bjiG8dtZrr329sKlJ9lGq/RemU1L56jvLBCAVMGasVTJMKO
 +NKCybER3Os0XH62RS8IZwXP2gDmPqTdACqir2r+0w2D5kDbryl1NJFY4+WGQFuv/mnn9erjq
 CmR9A5aHIq10K84cb84v55Aj/EaZZVtGUhH6jnKtjkm/pyvu1G0EKtKGT33ho+/d7B6u5omK4
 /0Q3qjfQMqIiT0YIpzNi4pr6LotVlE9VoZy1Aatap30J3UC2Le6vrMyc/UJZu+nImU5dc33rw
 1iahc6Pu2V4oJkG7XmRy8p5zUt0iD2FDiK9LosRRW41G8b8RmVNbKe+CYZvgMIneO3zPimsKF
 p4GIBGsDESjjlIi58yMa5KheD37I8WkmRdyhithuyMstJ3pLuAv+CH3N8gdogqZc7LTc1CY01
 VxO5AGtf/JEvYwjGkcBD/0S7bxY6AlQmPAvTBoRjG+90HPW3+y/doTjGgDKMc5NhT+nGZCuI8
 5+6QiEGXZSSy1w=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi James,

I saw that you sent a v3, but did not see any of this information (which
took a good while to assemble, as you might have guessed) in the commit
message. However, I think that message would make for the best home for
this information:

On Fri, 3 Dec 2021, Johannes Schindelin wrote:

> On Wed, 1 Dec 2021, James Limbouris via GitGitGadget wrote:
>
> > From: James Limbouris <james@digitalmatter.com>
> >
> > check_parents was taking all of its arguments as a single string,
> > and erroneously passing them to cache_miss as a single string.
> > cache_miss would then fail, and the spurious cache misses it produced
> > would hurt performance.
> >
> > For consistency, take multiple arguments in check_parents,
> > and pass all of them to cache_miss separately.
> >
> > Signed-off-by: James Limbouris <james@digitalmatter.com>
> > ---
> >     subtree: fix argument handling in check_parents
> >
> >     Hello git developers. Please consider this small patch that fixes =
a bug
> >     introduced during a coding style cleanup of the subtree command. C=
hanges
> >     to the argument handling were causing check_parents to fail when m=
ore
> >     than one parent was supplied, which led to a small loss of perform=
ance.
>
> When I look through the commit history of `git-subtree.sh`, I see that t=
he
> change was introduced in 315a84f9aa0 (subtree: use commits before rejoin=
s
> for splits, 2018-09-28) (which was not really a coding style cleanup).
>
> The change was actually not done right, if I read the commit correctly,
> because it added a new parameter _to the end_, even if the
> `check_parents()` function took an arbitrary number of parameters alread=
y.
> And indeed, it changed the `"$@"` into a "$1", pretending that only one
> parent would be passed.
>
> Now, I do not really understand under what circumstances multiple parent=
s
> could be passed to `check_parents()`, but I think that it does not matte=
r
> whether you use `--format=3D%P` or `^@` (the former was changed to the
> latter in 19ad68d95d6 (subtree: performance improvement for finding
> unexpected parent commits, 2018-10-12)), you can always get an arbitrary
> number of parents that way.
>
> The natural thing, now, would be to move the added `indent` parameter to
> the front of the parameter list, but I see that there was some cleanup i=
n
> e9525a8a029 (subtree: have $indent actually affect indentation,
> 2021-04-27) which _removed_ that `indent` parameter.

Thanks,
Dscho

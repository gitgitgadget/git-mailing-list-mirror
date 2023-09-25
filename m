Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5E3CE7A81
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 11:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjIYLw5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 07:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjIYLw4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 07:52:56 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1404BDF
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 04:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695642764; x=1696247564; i=johannes.schindelin@gmx.de;
 bh=gaTUBblmtD8GBggCFDVQHlbjV3sb0ucPffMaADyCtiA=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=qD2dfNE5p1cyZjdDoHZXx6MizauRZf2o/vibiICKgyANdFL+lUS9gJNAHgwT8PCM/LSORIRYN8r
 a3iAZSxwRnWSRitSYsxHD5UpdtYXr3qFZVHxDueKvKFlhKnrNIiYJAnD0XJt2Xpmtr1TWgSOWXAy0
 kn1MhWxJI1B/VC2c31olcO/4R31pen3+XXsBHSLgPRMKnroKleg3FqSsP+1K/PqQ27EwSuxlUpYFz
 lwFRSnBdjc3AxTaq2V5b+uN/BytpMjUxo5uGa3pI4zXwT7eg5JEiFOtI/ME+t7nTPBRblwLPhZTgd
 nhVokU8nYJPFjI2pSxeBOFekBb0jWUtxXkPw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.206]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mzyyk-1rYq5q1CVi-00x39b; Mon, 25
 Sep 2023 13:52:44 +0200
Date:   Mon, 25 Sep 2023 13:52:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/6] coverity: cache the Coverity Build Tool
In-Reply-To: <20230923065813.GC1469941@coredump.intra.peff.net>
Message-ID: <e1da76b8-df4a-cdd2-c349-6558a55a1c15@gmx.de>
References: <pull.1588.git.1695379323.gitgitgadget@gmail.com> <8420a76eba3eba3afdc7747af6d609ad8dbd8cb6.1695379323.git.gitgitgadget@gmail.com> <20230923065813.GC1469941@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mNyvt8DV3gjH1KsKe6HH2ixSw+qoNhN2zce7RX6ScIskU9FqWJB
 dx2Dg/2L8IS0hGGY1bi7FYWJlDj9l7ZmpLobUdNMiqbHPbhEkExzmXnwVQCY7yZUyepB9TF
 mtQJyzmTz9ns376RqTOxgTtKsbjql2Ifp5hPWmGz6Duv92nIiq90R6uBkajPaT+ajF8HUdY
 yxrz1yD4BloTvQMH/ZePA==
UI-OutboundReport: notjunk:1;M01:P0:7SqAVHgKxIs=;pyiOp5gVENP+p9NQ21h7H6+VcIQ
 Y2kTtYzsWNoki5zcNZr62PT6C4EqZCCW3ggEus/FXCnSTW9mCwUKfWX4TFehjHdiOZjoAil4c
 wGyKli3WeDiTUTOm26Q4bo5ELhJ9twe6T1O3cZ1Yj/e9kzoxCL/JrXQdV7kmNF9ltoEuCsA1g
 nP5dtkFPhqiISvYizAvtAunb1Pc5lnzs4q9V9Ig2dOcbVjyU0Mk8Ul8gzmKe3VDvgelrUZfad
 YvD3GhpriDXxycSBNpZAmEr+5G1kNN1XjcAUTo9rx6ZzvujPJZghtK3zwTKIlTfdX4owYFapU
 Kuab4B9piSfPA/Nh0HfNSJqjGqZ/J6a+cz86ZN9plrDx16mT59GvjUL0AhM9oxu8RGMV34yVr
 aOA1188DUn+CiAqxwGwtf/nisfjXXP6ikTvnG+rP9PxgIrM9F/iuzkzdJ8ee45RF8Y6kNK/xr
 V6JyM6nzVQUUGuOFvY+aNiFFRBNdR5JUKDcF2Tq69SxBSIJ7ziXOP2Uq8PNdoeli+OMqVRjdK
 ugzvMyuLqwvqOo/J5BHkGy/60nUtqToAwvPEUzyDbdLf906QlkeYCMRTLwF4zIXRw9B0x93ug
 UTXeCt014iqt6brSz5MOSEaIXH8tfN0IGv5DkKRDfbbhQApZr2AsCQFLiwmfuLOAf9BAu8BNa
 kw8hCt0GhQFZstNWAGwDXnzGVpIDEvNnRTzWUClTOPH+uYFgk9xDwmNrQiS425HBziyeUbqza
 gnntfJ3d1Ti6Asyz4nlflIyJ5jymfdo1olDsI2xo99xQ2NwhOpAkMW3gFgpcyicDpX0QmiiNi
 ZQF4O5r/vB+ZHxICMx+9DFXDtyitYAmIbIVUy9NqOuGQLFyA2tg6v6EQCYKNlxInFKIrVz61M
 hVTsGQ6lJEIqoxVc1Mo7q0JiQWWqYS43LT2Foc/78+vgTPSqq9PKWQ43UpBNlM/IZ+1/i19hN
 DT5736u1wpfKkkRs0LrgvtENdLM=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Sat, 23 Sep 2023, Jeff King wrote:

> On Fri, Sep 22, 2023 at 10:41:59AM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > It would add a 1GB+ download for every run, better cache it.
> >
> > This is inspired by the GitHub Action `vapier/coverity-scan-action`,
> > however, it uses the finer-grained `restore`/`save` method to be able =
to
> > cache the Coverity Build Tool even if an unrelated step in the GitHub
> > workflow fails later on.
>
> Nice. This is the big thing that I think the vapier action was providing
> us, and it does not look too bad.
>
> I have never used actions/cache before, but it all looks plausibly
> correct to me (and I assume you did a few test-runs to check it).

I use `actions/cache` extensively, both in GitHub workflows via the Action
as well as in custom Actions like `setup-git-for-windows-sdk`, so I am
confident that I am using this tool correctly here, too.

>
> One note:
>
> > +      # The Coverity site says the tool is usually updated twice year=
ly, so the
> > +      # MD5 of download can be used to determine whether there's been=
 an update.
> > +      - name: get the Coverity Build Tool hash
> > +        id: lookup
> > +        run: |
> > +          MD5=3D$(curl https://scan.coverity.com/download/$COVERITY_L=
ANGUAGE/$COVERITY_PLATFORM \
> > +                   --data "token=3D${{ secrets.COVERITY_SCAN_TOKEN }}=
&project=3D$COVERITY_PROJECT&md5=3D1")
> > +          echo "hash=3D$MD5" >>$GITHUB_OUTPUT
>
> We probably want --fail here, too.

I concur, after verifying that the scary manual page note about
authentication issues often not being handled correctly by `curl --fail`
does not affect this particular scenario.

Ciao,
Johannes

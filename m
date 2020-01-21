Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB21C2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 11:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7BB20882
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 11:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Ks3kRDPO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgAULtk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 06:49:40 -0500
Received: from mout.gmx.net ([212.227.17.20]:40049 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbgAULtk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 06:49:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579607363;
        bh=WuXWy4nz1VGEAQ7murX2YYpLE1Shankkic24JmwQpZY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ks3kRDPOcup/HMDGm0n3LiSYn2d+8gXufzCZ1hMDlMcM5rNPe9FkGlGz3BN6PWY4u
         HeCkLkUuKWL+rTigtftFCIhB71lyTkEAA/W3THWYnPGwmzReDjXW5Jh6uEOZm46/hq
         s1e4cC3yhxANNoHIX1waRqgrKW3im/oaidkEoOJo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLQxX-1jB7tw13kR-00ISU6; Tue, 21
 Jan 2020 12:49:23 +0100
Date:   Tue, 21 Jan 2020 12:49:07 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alban Gruin <alban.gruin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] rebase -i: re-fix short SHA-1 collision
In-Reply-To: <CAPig+cR2T26nJ1G5n82r_Xi8Y84k211n6bhBxG4Ku27vaW1pWA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001211248440.46@tvgsbejvaqbjf.bet>
References: <pull.529.git.1579209506.gitgitgadget@gmail.com> <pull.529.v2.git.1579304283.gitgitgadget@gmail.com> <102fa568dc09c1faa2d36903ccb7e1b285dd50b2.1579304283.git.gitgitgadget@gmail.com> <CAPig+cT8t39UvnF2i6CDoHW4kfEGr-CRFxZKOCstCTU0YzrCgQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2001202103221.46@tvgsbejvaqbjf.bet> <CAPig+cR2T26nJ1G5n82r_Xi8Y84k211n6bhBxG4Ku27vaW1pWA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:udVTm1WEEo95h3JwYEl7zaUYQmmwQxF0Ghe18bpy3LgA3gXtLm5
 K3jqYAUBnhtxuJf0oCkL4Lebw/Z1FsVCK4b1egi6902nGyDIylOvDvdHfU171aBaput8CSl
 i1k/HCY1q0qIlBN6ofGnMVCdDZncfDLzGjMx9INeUSYQsIIJ73s2WwAjJ2FNjM/biocej+7
 bbqfwLMm7BhMNvOUNARjw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YqTLE4PJ1bI=:VZJAqUcrCvip2fGVvlaMz7
 mXK+momEGvkL30+/rW9FoYOfvsYo7hTzoX7jncWKZTKqG78Hy8woXblkb/cKvlUBT2TxuzJ5L
 LYi2nf6bR7znXvVhOJ4Wls7k8stjJLoBGdHqMLz572zdhpmRiT84/ni7wXvOcoTnS5Lzz28ah
 BKTSUxT4RU40VgOTGknJvkQ9HwpF8FgDmFTtZU7zYO4w4H0wikj5+U0aRyr+A1CRUxbtA9n/w
 PlyxGIgEIKJStbp8TFfcUdxcl5HE2A/nbCdAgVTlgotiXMROVkzEvbyM5+5Ep4xAAnMG9VcHF
 aoAWsKu10aB59ytcJDQpvriS5VuWaUj2ATX9Yio0Pq0gsKDA56mLVUFgP2hIOvqInK6gQHSnB
 1yo+ldyo+C64Ay2kVbtMKVaYPybvuJiAEalDiBm79rhYHakEdGhUjGIBP38lDglNvgICw6Aji
 eNp2wZ3yr0Roa8ShGAvOvjzF1lzYy1iiJui4LgRMV666cBUamZtEnSOh8Mou2DiH7BeJMYmrd
 ohjdJcLMy51h96usLdJuhrYM5YCHEUutBzPg+8EEowL6xmYr6xA2yjYSGUuUYZDjSnLAm61Qu
 t96pKLGKs/p6ESXX/a6RrOhbZO3qAeHX8oszylyUUTHw7X6yFmMkrgdfBto2f4XBos7UjYlzz
 tkSo+P5nR5fkGTgyS1sRJpohYu2pbgSUwkWVu+GD5PHTZFLvhtQ6wPKE1NEHFYjuatWonZtZM
 TkDNDQRYTvA0C+QfsWdTZo6BJ7YLXEitCkpEoevw6HCUKxOZUB3Tay+Hpzx4V3k3zBaJr9wvE
 L3BcJIMXFJZM9H1IFOxW3rpWo1AMCd5KXyY8U5wZmMWYPcSXSgmAa/bKiV13JuvzPOgZ+ac8+
 Tlw+RVBehCyfM0DMhL8sblWcYTUk7FzJtpeSgTs77T2tILQxm+uqS2DOscCEaTSzPta4UV1fI
 sQneyHq/4xqnQHdNogo5VvTwpdeZJRffe4xr9l4VT23mu6ANwQsMeIQnPwOUnCE5XCMZVxRPn
 RGG3ZY51GVpGqHh0XGde5yZijuEGlsxTalGDmWUP9iWY8ix8KskdYzINwpm3IbkTmLJOsL6b2
 sdUCw6y9plgAPfUoo2T7us8JTHZLkFtJGd8nOipXyDg1U/p5w8QB9C5jE77cZdBvIxr8ntlib
 Yup6kYib+v/EIuDqH2KsItyODVmx6jJjQRlywOimM1WGZP/7sg1teC6IBuhDIOgXsC9yCW8rs
 ML5W5s5W7vaEDMSlw9dH3mP5UC+mTp1wRaebtEu9zH9O8mSES8i2svyc5tRw=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, 20 Jan 2020, Eric Sunshine wrote:

> On Mon, Jan 20, 2020 at 3:04 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > On Mon, 20 Jan 2020, Eric Sunshine wrote:
> > > On Fri, Jan 17, 2020 at 6:38 PM Johannes Schindelin via GitGitGadget
> > > <gitgitgadget@gmail.com> wrote:
> > > > +       test $colliding_sha1 =3D "$(git rev-parse HEAD | cut -c 1-=
7)" &&
> > >
> > > How much do we care that this is introducing new code with git
> > > upstream of a pipe (considering recent efforts to eradicate such
> > > usage)? Same question regarding several other new instances introduc=
e
> > > by this patch.
> >
> > I would argue that the test case will fail if the `git` call fails. So=
 I
> > am not overly concerned if that `git` call is upstream of a pipe.
>
> Unless the git command crashes _after_ it produces the correct output...

Yes, that is true. In a very hypothetical way, of course.

:-)

Ciao,
Dscho

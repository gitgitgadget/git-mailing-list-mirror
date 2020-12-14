Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E15C4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 16:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00B9C22286
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 16:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389013AbgLNQv4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 11:51:56 -0500
Received: from mout.gmx.net ([212.227.15.18]:38321 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731110AbgLNQvx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 11:51:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607964620;
        bh=bEsX12v2mHUNYqlLNXHsz+Xens5OWY+1q/TletNHM3A=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DSktD+4swDAv9Y+IwpMzYIYKfx0dYH6iiZ+br9l0fX+1UhW0i4AeU2ulos6OnhHiI
         WBEEPKpsAVTVB+q57Sff3vy1UxwZKRGRLOf4T5WT8Rc7gJDRsYHQTKFu2F0oXBUbgk
         NqFWxGA94jBHkxTc1X5l+GWQB7lPalmvL692OfT0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.88.62] ([89.1.214.172]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8GMk-1k2PD20g5I-014G61; Mon, 14
 Dec 2020 17:50:20 +0100
Date:   Mon, 14 Dec 2020 17:50:18 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 02/11] merge-ort: add initial outline for basic rename
 detection
In-Reply-To: <CABPp-BHyNuhNtc6JQgQRBsQFbobzYyS6fs=nopRuv8c1+9zW_w@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2012141747400.25979@tvgsbejvaqbjf.bet>
References: <pull.812.git.1607542887.gitgitgadget@gmail.com> <b9e0e1a60b92a6a220193bf9fe80796df91126a7.1607542887.git.gitgitgadget@gmail.com> <84a4d97b-8496-4c83-5d32-19f57e17a871@gmail.com> <CABPp-BHa0zehQd-axmb4bF6fR4PTWwGu9uLjOzgTW8_Gu12iZA@mail.gmail.com>
 <7b0aafae-cd57-d4f7-ac85-238471428d24@gmail.com> <nycvar.QRO.7.76.6.2012141641230.25979@tvgsbejvaqbjf.bet> <CABPp-BHyNuhNtc6JQgQRBsQFbobzYyS6fs=nopRuv8c1+9zW_w@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wx6qmolFTWmWfxNCiE/pp8OyGHEvM/4IuWSi0604uPisjjhJuFH
 WxzFkxWmJwzpb+csmnW31p6aGKgH2Y1qiri/VZvloHIK75JlAwJNJsa9xSC7fCSZDisBdp5
 YMTujMSR8bYx4jErvVvwZwGlXDNduH7D0SywdXegUTydygAmRQMTG3MXXJXQ3A0NremfMNi
 PrPqCPbZHCkQ2hL+SbLNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r5h7m9YuBow=:yWjDyl8ERi6NrPZ2YpVIBO
 0GzPG0tKDmNiZmQmLrKXb8Y2mEv/RGIn9qXyBYpIj8HiA4PBgQBP9+nazPcx1zDEsDqlWF9cP
 VYnhtWw2ApflOZruFnFU6gRY3+dwJ3673Qxc1+TGp3x1GFgRvXrJXpNSkfpYRrxh2Hj0dW6vU
 1OVOMhYZZPOssmjtktnMyipI+3/DVDItxX0gokwArx3bcFUpjHvgmHKn7T4lpurxFtj1pxqx/
 ZBZeJo9rc1JzTSKPmHAl1jCZpTGWFaIaaR49I8vlC7r7gxq2Xyy2kSZ23TnnON40HboWnQMjY
 EN3//51D27xwd9BTqk+1YdhkmZY1YmpyOJQBBC5inhpOiI/MAyvBKHz8UqX1apcYQqA4O2ovP
 0sY+0mxr4EFWasofj6WfVtbLRgvUnC+qwx0rW1NI29eqWIWMG2SMhuAQOEyO8V0zjPvYUaYIA
 tYAElV/ZPw4oyyowuBokUWCSImE1VnxpcObsLzWvw3eN5oIWXbDv8TtOS92JrddRp74QlPaIu
 FoYLpZNyuX3gqTe4BGFQP8AcQU+PCizwCrEjuAO+lMDbycpVeKTfvebJ6bBArTCSuPohBmsHX
 NBtmN71xUjzgM8NEQ0yfnOWaLPuoFUVhHpYi25hWQ9KkJKhR0A84p6K2NfbNVnMXv8Vn9NlC0
 45sB+Rv8UQm+CsWOO5qZ+lVs+efbIstTE0cNsV3r4/9fE1uzFxqGJBFiqNLWGvoAP20RI2Hu/
 Hb7OrzZ5bfRevIchVEjaPs8qg2gRNM7yvue/93rSR0MCSSwaPZwx9higaa8IMw1IODNWuwfOb
 RgyUIuSpiHblciBiWxBUMBPQsmv7pxmiQblQPeqL56nuw7yCpYEwDCxEWw+cl+WGONIBCevMn
 7zrERC0RZlcwDm8AmMTGYKB1fTLz52Di7YDl9EBgM=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Mon, 14 Dec 2020, Elijah Newren wrote:

> On Mon, Dec 14, 2020 at 7:42 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > Hi Elijah & Stolee,
> >
> > On Mon, 14 Dec 2020, Derrick Stolee wrote:
> >
> > > On 12/13/2020 2:47 AM, Elijah Newren wrote:
> > > >
> > > > Sorry for two different email responses to the same email...
> > > >
> > > > Addressing the comments on this patchset mean re-submitting
> > > > en/merge-ort-impl, and causing conflicts in en/merge-ort-2 and thi=
s
> > > > series en/merge-ort-3.  Since gitgitgadget will not allow me to su=
bmit
> > > > patches against a series that isn't published by Junio, I'll need =
to
> > > > ask Junio to temporarily drop both of these series, then later
> > > > resubmit en/merge-ort-2 after he publishes my updates to
> > > > en/merge-ort-impl.  Then when he publishes my updates to
> > > > en/merge-ort-2, I'll be able to submit my already-rebased patches =
for
> > > > en/merge-ort-3.
> > >
> > > Let's chat privately about perhaps creatin
> >
> > Yes, I am totally willing to push up temporary branches if that helps =
you,
> > or even giving you push permissions to do that.
> >
> > Ciao,
> > Dscho
>
> Given the amount of changes left to push up, I suspect there'll be
> more cases where it'd be useful.  If I could get push permissions, and
> a suggested namespace to use for such temporary branches, that'd help.

I invited you into the GitGitGadget organization.

Recently, I pushed up `hanwen/libreftable` to have a proper base branch
for myself, but I think that was probably not a good idea. I should have
opened a namespace like `temp/` or some such.

> In this particular case, though, one of my two fears was already
> realized -- Junio jumped in and did the work of rebasing and conflict
> resolving for en/merge-ort-2 and en/merge-ort-3.  I didn't want to
> burden him with that extra work, but what he pushed up for
> en/merge-ort-2 is identical to what I have.  So, all I have to do is
> push en/merge-ort-3 with the extra changes I have in it.  So this
> particular time is taken care of.

Understood.

Thanks,
Dscho

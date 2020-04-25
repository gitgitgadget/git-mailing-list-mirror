Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D971FC55185
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 12:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9D2520661
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 12:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="iX4i9S5R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgDYMyQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 08:54:16 -0400
Received: from mout.gmx.net ([212.227.17.21]:34925 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbgDYMyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Apr 2020 08:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587819253;
        bh=bzaw0Or7rF2Gm8XUk2JIfOX1v0L/rX6TWdTEbl6BR/g=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=iX4i9S5RIujBWy4eOea9cD/sRbbO5byrcIt3FAefFSyU9buVHtfOyqfKx/zKptLeE
         q46qCb6ChahpaLsDFruVyh3a9C34JMvqnwMexxJO3YU1Lt8h91T98QiV8BXewc1/Th
         LkJuB+PLpbtRaRntgJhttfFW7Wlp4s9lWFG3rphE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.212.117]) by mail.gmx.com
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MPGRp-1jplWL3C17-00PeMz; Sat, 25 Apr 2020 14:54:12 +0200
Date:   Sat, 25 Apr 2020 14:54:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] macos: do let the build find the gettext
 headers/libraries/msgfmt
In-Reply-To: <CAPig+cSkr+2dExzETScru0N5_=JhjVR=QZKuY5CbhstwrUUk5w@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2004251452200.18039@tvgsbejvaqbjf.bet>
References: <pull.616.git.1587628367528.gitgitgadget@gmail.com> <CAPig+cSDQe7YDke=fyfdeSZOimcR5jj3FFk=Q4iOk6uiHsT-Zw@mail.gmail.com> <CAPig+cSkr+2dExzETScru0N5_=JhjVR=QZKuY5CbhstwrUUk5w@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:GZowly50cZKuSMDq+oW5MmrGN2O6ypKFgr0zBLcvlLgDFHFVzeE
 D8ELjaLkO9laFm5G1MTCdLoJ5ZTyH1O4J/Hqeu7zVmQr67fjfxQabGY18GnyvF5u5MPyvU5
 R7GYyy4/LZ/L78swVq47LqmVZd5Y/VdYd/mwwFfBZmVHEOpegcEaZ+9EnJBOk4DPQG5eL3r
 riMf+dO7GFkgy1svV165w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MzsDj9Q1C/I=:+PgNE1TJZjNt0907mP2xJ+
 9uXbVPeBkoV5KNE2KhlNiaEC8JSSlhaOp6EsuuYiI8KJGcLDj/kTAGbxuBRckAjXlagkQnfE7
 D4oBv8WepoY1bRPdYd2x1CsObzZ2FC7BjSqOmek7vb7q/geUOm/BjMAk4BPW4+1F0zIcGe8Fd
 filSfZ7fLs1HO9hltFQp0pn55/BC1+8G40ntEwGdHK3pCbrsBM3uWYYwwx6o1dd/zZdabQqOY
 4w6NyRMyebx9gL/nlCabb9cx6UJh5dEffeKoXyiBAnDTtvsxTFwBZHmqWo6gnZ5UKMBQARRfm
 1iCLE5nK8nB/Jid4xk8yT/X4nVLMmE71SMkFIKraXChx/ZVymv477dS/+qxW5hfsp9DU97X8j
 9F2P18TNIeHhuWyHiJN2p0ov5oC+OlgaOiTmzsYIYq1cFSZFiqUEZsbK7RP76akT3KtVDeYVR
 RVFFQG6+esPbL5OVtKHphEwpzSYwHPuoBkw41F9OJW3oVo1jiu1HAczQyboZUfJnZ5AZI/9rT
 xsfk+n7WM13UZ96BcKtDEEHuG9Q3even27XnW25ax6a2kbpEjiM7Ah+gSgkzQV8RJ7jGCObD1
 N7g8Ao5INQCZ3PSRHU84FC5nJp4lZETfxiG1dHEWBcW3X89aQtmwc7rfrc9P8OntVh5Qf+VAJ
 9oZUDkkhLH5viofGBnhg2whEhli/H0nCk71eTlpX2oeMUQsVPd7hBQf0YMU62ZwEZSuhFLjLr
 l2w7WGJpqIq5x90C0+v+MyIQB4goNkUu/3WYtlukrO3UVPgyhN0N8ysWMtaXfOuMGDltrvA9k
 ywudm08qukP82/SD11CIjBSkw4uBrPwidOk0lXjKnJHzvLD8w1pcudXLjdWBohxymMSIDeX1J
 bgFaEySDMGExRit13lBdfgxoYV8yttoU8XwIkRqvBnore4LAFgRrBxrbB0bt/kAntJT6aJ8Eb
 POblh4oQYPob4wPV6QJJ6bJD2vG8I8eZ6bQQI/tcGirmU3TWSXn0bT4OiXtV8rbW5JlaiBNpZ
 kA/q9vbxonrWE3L5DlMt7Qh+nL+DXctWHCNzF4RPhiuAGvw5KfCtOaVaajZTyTC9exUZoUXh0
 kJuV9ino1xfauNRd1lejxKwHmVaEBHpye1I106FPnfO4Hwb92iZaa4L1Kuniuis+GfHn1t65V
 /XlJg3fvTojZXcsw+xDLyxGJXJX+x9oBW3Kvvut5L/aAlt6fA3ebiWr1SUIE8R2vcp5y7M8gw
 qRoCA60l6egxa8rUO
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Thu, 23 Apr 2020, Eric Sunshine wrote:

> On Thu, Apr 23, 2020 at 12:17 PM Eric Sunshine <sunshine@sunshineco.com>=
 wrote:
> > I'm slightly leery of seeing these applied globally on Mac OS in
> > config.mak.uname since various package managers on Mac OS install
> > packages in wildly different locations, and these settings might cause
> > the wrong version of a package to be picked up if a user has a
> > preferred version installed elsewhere.
>
> As a follow up, although slightly leery of applying this change
> globally to config.mak.uname, I don't necessarily oppose it either.
> Considering how widely adopted Homebrew is on Mac OS, baking in a bit
> of Homebrew-specific knowledge would make it easier for a Git
> developer to get up and running by eliminating some of the manual
> fiddling and configuration currently necessary.

I share your concern. But in contrast to Fink and DarwinPorts, we have no
Homebrew-specific knob in the Makefile (does this mean that we expect
users to use Homebrew by default?).

With the update that I just sent out, which guards the added flags behind
a check for that directory's existence, would you agree that the current
state is "good enough"?

Thanks,
Dscho

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F2DC433F5
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 16:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8939A6112F
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 16:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240189AbhKIQoc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 11:44:32 -0500
Received: from mout.gmx.net ([212.227.17.20]:48845 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240283AbhKIQoc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 11:44:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636476101;
        bh=hDxvG+misw4bd9zaVThq0Qt5OuYN3yaL27oCUmV1e0U=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KoQ+H4+2EBKFI3ULoHDxB+lu0rSz70dP1/QdaofRRlwDcomN6LBYbltdeoRIFQcX2
         qQzAQiuWat+Y/dFW7SAtegopKUWK+Ke7Mnj7SWONFzmD+HKCpVlYzSnPqeGCF+Qj2M
         c0x0vkcgvqjlL8aBj50s4dqHNqXnaN31bFewHBIc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.22.201.164] ([89.1.212.10]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJmGP-1n0EpA1opl-00K5Eg; Tue, 09
 Nov 2021 17:41:41 +0100
Date:   Tue, 9 Nov 2021 17:41:39 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Samuel Yvon via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Samuel Yvon <samuelyvon9@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Description of github.com/git/git, was Re: [PATCH] builtin-commit:
 re-read file index before launching editor
In-Reply-To: <pull.1127.git.git.1636423586620.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111091732040.54@tvgsbejvaqbjf.bet>
References: <pull.1127.git.git.1636423586620.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:s5CUKZKyzNulXz1HJhYLT+PUX4Bv6se1o2VajSLA8/SLqmmujiq
 l4sKLZjKd1tcpz9f0jtTM1xA7+r8xD2+jp4cknnRX7AUrcZMKUX8UtS1PIhdUGf4rIOYSsJ
 SmmZnAK5X1aZPwkvdBZLnqTIvsIhHzKJi+71919JpfSMpeaHZaBNrE+eAwVnh2dcAN3F3hW
 wFFQr1ob/AuHp/qs9wXwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/0JfFOo5oS0=:JpdgWE9FxMAymHnB1L/EyZ
 oPXTiVTYeZSs8cApCKfrbB1PtFlj5/JL4zIBFbxX5eiPxF0zgNJcDphe8J+rSyFDfw0973Nn/
 oLwI4wli1lJTuJa8pUqKJse2r9hYhgwMhJQlpvkHDr2Cj6BM4kF5yd1oBPGmlPb+nfWpahEAB
 EPC9ccxbbvObQNH+1ywQtx9S+6y3Nyw1KJjuBDTD4/dMHkhME7czBguuuyq5fxkuRoy1/Sv2q
 VrXMNcf3+BvqzwsZKz3SLz7t3AcUbLZmMlmtGPVl96GL9sLiUTc5zMbxdixgykpwed2Jc6Lux
 KYRxF4uhxzCCDuBB6yj1DjtrjkTU5CBo4csEkTuHS6hbyXa4RXtD5dloFg8+q9DDXEKmemKrQ
 GhKkcz6E8Ezbw4W7VfN29vRHdHxD81pZgzi2kOL2RZ4fpwuTMMOb7AX075au6XXgx0KDnzord
 FygWWcoFflqQ16vEcR2gfGi+JN+TzLxe5i8L3VK1eeBFTNe0C1ZlrpQ7kUwd+y17OfGmD3Adt
 EwoEaAPbJO5Scb7GOe0HiwxdfHJByH2v/Y3kpfBzkQyUtDL+bGOYJzTktkuFpFB/vkH7t+y6X
 9dl5S+Nif2GHYKIUr2YaZfvM2cMqi8ptUJnmt6oVf9Q3FXZZzqVPe2bxj/donXMYC6A/YhygU
 VqU+u9ULtYj/Rktrafq1Ol8RB19+uli7BQi3gHnz8aQrMc3wPRSBWDYuuhS040fC3Qxoj4Phf
 dfUORrw5R3MnxMQKXFG6Af3ka0v4sCUEw0tBE73VwpwVYD2phnhYEi20+8lRbj3XY8/tw3C3Z
 59C0uWn9wjG+bg2YnApg9OOVd2JKItgK5M/cYvCje37pHTBLOH91aZUFb38oJPDIb9Vvw2NGL
 K3szNCWA8q3/jNs4af/GLKnOmiKGo6Ri0nr8wachHJB1fBO7zkrc1uHmo2/ekBYfZyye49jDp
 Z26dfLTxhdNDvrAe+gJXULBnxwBPVMZeY+KzjmHluZ2GbhfZlIlikIBOc+8UahTqRJVVpTCOC
 yIolr8EWLgD7IurWSBWuE5D07+xOhIcH3HegDkpnzr2dFsTJFP8+5Ou5in83LM3pe+Yztwv7Z
 wGNoWP9gr6wOtY=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Samuel,

On Tue, 9 Nov 2021, Samuel Yvon via GitGitGadget wrote:

>     As a side note, I do not know who manages the Github Repo but the
>     following description threw me off a little bit:
>
>     Git Source Code Mirror - This is a publish-only repository and all p=
ull requests are ignored.

I would be in favor of changing this description. How about:

	Git Source Code Mirror - Pull Requests can be submitted via GitGitGadget

Thoughts?

Ciao,
Dscho

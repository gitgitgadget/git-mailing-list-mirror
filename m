Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6745FC433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 11:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4523E63220
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 11:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbhKPLGk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 06:06:40 -0500
Received: from mout.gmx.net ([212.227.15.15]:42665 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234621AbhKPLFh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 06:05:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637060541;
        bh=j5/ZjVanSQnNT9r7s4HUKPzyUYM+AmiL1X21YQ0nJM4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aZ/S9dy3OS5b4W9GUOY6FFhzqkzCASY03ilZJVOr8bN2RyimYg+v62JH91m8PU7nW
         UqHOHoCzah066pHD2iUBOj0O8H608mlYRQakKy3k5ptlEPTtB3SY3Jdq1CO6WpNv2V
         tN50uEAmlbJSWlVO1lazb2ZRRRafIzuaz1ypdSn0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.166.205] ([89.1.213.220]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MnaoZ-1mNFua2EhJ-00jbGX; Tue, 16
 Nov 2021 12:02:21 +0100
Date:   Tue, 16 Nov 2021 12:02:18 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Adam Dinwoodie <adam@dinwoodie.org>
cc:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Carlo Arenas <carenas@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 7/7] t/helper/simple-ipc: convert test-simple-ipc to
 use start_bg_command
In-Reply-To: <CA+kUOanh1m=dkE-gDikg53zOPXx_7v65ggqxPspuZWDbdOrR=g@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111161158230.21127@tvgsbejvaqbjf.bet>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com> <pull.1040.v2.git.1632152178.gitgitgadget@gmail.com> <6b7a058284b93fab52458b12a6aede5e8aed6652.1632152179.git.gitgitgadget@gmail.com> <20211104194619.GA12886@dinwoodie.org>
 <nycvar.QRO.7.76.6.2111090051530.54@tvgsbejvaqbjf.bet> <dca03da9-5684-10c7-2315-2d10affd4f0a@ramsayjones.plus.com> <nycvar.QRO.7.76.6.2111092358240.54@tvgsbejvaqbjf.bet> <xmqqee7ozyx4.fsf@gitster.g> <nycvar.QRO.7.76.6.2111101324020.21127@tvgsbejvaqbjf.bet>
 <CA+kUOanh1m=dkE-gDikg53zOPXx_7v65ggqxPspuZWDbdOrR=g@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:72Tv7+y3vmlv087unv+hpGHygTrZiuHTVlWHelXovaK9cq8RUfA
 Xm6q+dSfP9ha6zyv/TkRk/Iq/htHrtW/FxC2mj8+xYnEwcHd2PqM1QDHLMYy0Bt0nZgLTn9
 wNpFDVMKLKOXG732kL2HSzUQBNTZ7UYAGVUBoWgMZdSGMyQOEH9mMPocOsaZRf1xr6Nb25P
 Lc3TU5MR82D1gyMRSX21A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:I2iCd3vYWCY=:xCSEJBk1SzQSvvm+T3uI0S
 0JOXjqSpMYtHehRLcE8IjUtjocUJLS0OWKIdN526PaAhF4mjOd7ilovYBTuAfISbKihEIWBzD
 kvFWnNBYo8rWQLECfcihvRDfsyVPrLm2Z1g8gkNhQr1hEYcdU04sUFCUVez8sTlYSbQQgi321
 Gy+C9GxQDWNT0qObq9/ISu1Wpan9zNqlp2VRGOjMiArXly4OREYcqePPV7PlsN7xTcqiljPA7
 pYGc74URODgSsIDVHU7GcPtYERFc9cL196LsBHgH5PENXubc2Tg2DECQ0Q/zlnttzoqhNMF+U
 j8dAZMWFXfMIIw62z6c9oOijBhYJgJpux8qKHEsx9Upn0lrdGMOFQsO9HoVQ1JNyX2q2njr0g
 Kngm/jH5xaZpVSuE3zAccspX7Fm45kovkRCV1xemPXAe+2ZA2s78nMu3R7vZ3Mi5kdcOy8Ilw
 GtubB3tivUEYZ9yq3wvjO9pkcMkktVxVLdJY5aF1t6CjCTvtCQvVwj9zDNNncP/vbBHCvSbqB
 V/F9I+171SmZSXl536MNhdNMFpzR5Hr4bwHTyQGxyCque4oBQ1tdWSAoH3LosaTVz6sYuygPC
 J0WPD04WDrQXmfRYJ6aFbX7oT4GdSvngee7vC0lkxsyce6e+gn9kOrCCRDX7w/bOx3YeF4pED
 DVEYksNY4ziop6FpXFVc+P1MHt775eZes/OmzbR4t9or8WhYFv8xZoZoN5vmfpmD4OTycHANq
 O2I09V3mOGmuMOZ5COBp96j5J0Zasiogm53Zpc+ZEYW0k4hwvlFAPu5BCn0BUxLTasp0zkCZo
 pFZPf4yoXPNVCjcYXvOkFiTcv7/BzhN20iIz82uTKW25xC2etBLv7LEfbhomMbdKDlOnwpt9g
 g4ZDd/qleCllhP7jLTnGHgysQgbLDyEe0myEFJpb+XlDzia6yKardWpfo4KsvmSGk4wXQmJdX
 5fy/FWGfGoF6WnNaq1z2GjkM6Fqx8iJngGgTgWAeZf5Q8MQyJIX9bRcGiPPLwL2UkXVm/B0P5
 A+8Juuo/LJnRySlQEu2XQjoFK34rPhnZZlmrWXSozMaoM/wI4OWq5xs3ip+UUZEhF/ziaDE2j
 HPHA2sA2+RRrEY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Adam,

On Fri, 12 Nov 2021, Adam Dinwoodie wrote:

> [...] the (lack of) speed of running the Git test suite on Cygwin
> is one of the reasons I run the tests on high-spec Azure VMs rather
> than my own systems. Unfortunately the Cygwin compatibility layer plus
> the overheads of NTFS mean things are unlikely to get significantly
> quicker any time soon, and between WSL and Git for Windows, I expect
> interest in improving Cygwin's performance is going to continue to
> wane.

Well, at least from the Git point of view, there is still _some_ hope. At
the Git Contributor Summit, we talked (very, very briefly) about moving
parts of Git's test infrastructure from shell code to C.

This would definitely help not only save electricity (and we all _do_ have
to get used to the idea that we cannot continue spending as much energy as
we do right now) when running the CI/PR builds, but also accelerate
running the test suite on Cygwin (or for that matter, I suspect HP NonStop
to be helped tremendously, too).

Ciao,
Dscho

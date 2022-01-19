Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859C2C433EF
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 22:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357621AbiASWkE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 17:40:04 -0500
Received: from mout.gmx.net ([212.227.15.18]:41409 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357612AbiASWkE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 17:40:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642631998;
        bh=/tprcVCzOPsuRzcm6wjHDMOWxDe0fFrbNchAe+NOtH4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=apZ5V4xzgVzDcwPHsMPfio+IDC3LmRZLMHuSKmYs+BhJVCDcEJSufzgaXClDGH6lP
         Y8HTyqhzay/G052FA51OOhd83oFhfbX7LUqwhEp6TVVmyhbRmjgvlpHS8dxldMKOHJ
         JmpRFSy49dksjwQ9+1Xhe4ZZTuUncc9woLEu316E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.174.184] ([89.1.213.181]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTzay-1mkZI41XrG-00R1dq; Wed, 19
 Jan 2022 23:39:58 +0100
Date:   Wed, 19 Jan 2022 23:39:56 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] getcwd(mingw): handle the case when there is no cwd
In-Reply-To: <xmqqr193mspy.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2201192339250.2121@tvgsbejvaqbjf.bet>
References: <pull.1120.git.1642618562012.gitgitgadget@gmail.com> <xmqqr193mspy.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qkuSLWf9+ExEFjNOZB8o4tAeWAJ5nBkRAEiarhUhcgeCMJpw/1c
 Rz6X2UFIYSu97NloNjLNa/15ueJNMF5rBZ5PkEBqcDyfYIMG+7XIbQTt/Nu5P2Wl+0Q9D5b
 3jI/NIsKYE8ZwTGcUkmQqjXQF5ViGwVOTLEgEQgRVDSmsyzrV+RCXvk3yUTA5QmfITDS4LM
 KU7LUHEOdlZaSFSKu/arg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PMFAVfvQ2r8=:pCUm43bTDZBAGr65EKYiMm
 x5x5ViXX/g7wSu9W5oYTQaPD+aKi3kY9s2o15CCvIHFBBtIMhqV/VkkDC4bpdPeBlGkUc6xUC
 KFKW68Rmx5u6pXkMshEIOo/QLyebMiHHT/bzzoPC+PJKcZ71wj8blFVMPu6RXO/9CjzGo6DU5
 oZqQq6X1zQp6/6T5gq99pI9LkL6hjgiHcU3+/8/+dGZ5HseyU2AIPMErCNDyJaJzl5uXdUS6s
 rBAQwTW3oXoGPUsFzpvTRV3dfCffymkmYv78GGK+GadDYIIt5YYTHECFJWzHjK4PqFphkANdM
 9MwuD6nHafZ0LXpqAwioSAmUGVuquRxn0dDQJJ7v1pX5C7Uqc6dsct3sQV2LvPRf7roHXvUS4
 tylJ2Lkz64cqndTBnlWVJZh1gm3Ev4KE4zQdUyHu/iv+ZPIAcErZOAu1eRqpr2LXw+SZn5bhZ
 3WgVXzU1G9j5bte5UrZPo0+P6s+NQLKIDxNSN1PdmeXzNf/OQbKWWVuUw2MbmH3SPVTDWqz4t
 mNBBDDFSxqWWnpOmhma9OBjuYi+VJ3goS1n0xWbY3PQenOEGC5Aog9rZZDa1pI1vHUoXv7rY6
 pbH48o3dLffOk5ynwv7VjPTqpnpNOfITkU/I6kA1fNzvkzgb15MoboJqsjZgODgie/4txvMrA
 AR6ln1nRZfcpykGZXNo/g3HKmdYlfm0XT00qHbesOm/9WCG0yHyn4hgAC2s0sUN89nTJkGViR
 OkebLyJNPzfHqCkinEQAUZ6LVmmJbXCTB4Oi/87u6uBrxLgU6qiafcepQLTIo+A5lqcRGJMlu
 XEmyzYEHUlmH9Xp62CuNr2lUndVLk4ytkXpJgwcVEPMq+Ym5KO9Mjtvzmxp3c79SZS7lNijeY
 bahsq5YlG8DAl1Zhgqt87zIp1D8qmJkVntFSOpyy1zwaMU/3UaKLMB0Xu81k93mDybac13ajF
 x6KOSgP4a7CZRL49I6+rwe4Jf1jGA5b80uYRTMJ9hYc5D5UQ7H/udJGRfF1BIdUcCZ2wKL5ZB
 8+HiBlNcWeCdDS4CHEUzOnwKX+b2GBF67f6fGs7TJOJJ68M9aaNquS/3jppwNli8trujXpaV2
 YokDVCrY2UN1JQ=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 19 Jan 2022, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> >     The bug fixed by this topic was noticed due to test failures while
> >     rebasing Microsoft's fork of Git onto v2.35.0-rc1. It may not be
> >     desirable to take it into Git v2.35.0 this late in the -rc phase, =
even
> >     though I do plan on integrating it into Git for Windows v2.35.0
>
> I think we can and should take it in my tree (even direct to
> 'master'), as it is very clear it affects nobody other than Windows,
> and even if this has any unintended negative effect, having that
> common with "Git for Windows" would only help.

Thank you!
Dscho

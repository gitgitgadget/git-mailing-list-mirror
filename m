Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2AAC433FE
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 09:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiAVJcX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jan 2022 04:32:23 -0500
Received: from mout.gmx.net ([212.227.17.21]:58893 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230011AbiAVJcV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jan 2022 04:32:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642843937;
        bh=aW2qGYU6T0GWmsSPRlw3WXChLCCD5TNwUut2T7COKxU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=YyZI2KvHiihEFpgUr0XGGqfABD+y+jhk59YJiYifsCn+kT0Azd2rf81guhWGrmdrJ
         v9Pp0ycpVQYgXt7GWUgXLCWkgPxVOGyiPIjM+0fu487gQEG9Q4s/Krr7InhvGC0rfu
         nzp0pQcN9y3pFx/Ax/0f/MLL5NgjUYyQ0fxl58BQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.174.184] ([89.1.213.181]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDQic-1n2z0p288c-00AV76; Sat, 22
 Jan 2022 10:32:17 +0100
Date:   Sat, 22 Jan 2022 10:32:16 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] split-index: it really is incompatible with the
 sparse index
In-Reply-To: <xmqqh79wejzo.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2201221032060.2121@tvgsbejvaqbjf.bet>
References: <pull.1119.git.1642613379.gitgitgadget@gmail.com> <1bb57ccd61452124119bb663f5e35e9676748c82.1642613380.git.gitgitgadget@gmail.com> <xmqqh79wejzo.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:onVfDuhlCxKN3r7Jl2/qEZ6PnlrlgaMlHAPokHvZFdefZ11pziK
 t/oK941rYW6bvSHlRtmB0fn9Km9IhPVzCocCgLr9vfehE4wLjW41HaTV26wBwQ8xbwa/rXB
 gx1ku9UushjMOkONzqrZlQ8o2GzsXxGpbfgxpxcOcWLf5K3ifbBV+uZkg8DICs0DeKgDFNj
 3O+SasCajHjnVWjwcg74g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GZtc+yTL//A=:bEAWC3+fAcGDJ8xCxu6DI2
 xEhrxBsGGHgj+tl4N+excQa37qQD1pLCfGNKCRak2vunsp4xFqbMl8ilM93CyANajSVYlwZBF
 Inb71kFd5FGEFcLe6NOwJhBM9hBXr+Bkh0aqkg86nV5ydz46rj7834DMDttR4+UqYE7V5mGfm
 pPqIgOgiAzCigECVqjckAlUb17wyv09wHZpUEfhN14J+mcAEjfEbiOxUZ9c/Gc+8+w1apnt7B
 ABHV/BQ+HjOEKqXLsIUHvOCmsaLVrEVhdDanr7dNsSrcv3PB9kPACQf6tTvQ3gXXogzO7Yfbp
 kOJ3p7lHeBzO3XZxNXPnoH7ae3sPO2Ac55vHnuLaul+3RcdaQVabsL2Uk3d7/IHczra2W0Twt
 GDyhETdtTbp5e6cEhu0yB2vbNMs47lqtMlKXFsC03Hamy98HwXaXvc55Ii0JhvCLThXp2nM0t
 Dxp3x6gYbMsS/m5jsxEndEMZDD4X/HgV3v7Y3OynwvvuIX3G+R5PSphlKZQ4WM/Q9LHLzZAe1
 dKcV+FNAhj38J0gRiFGv+6iwsQkzsT+8u5FOFIlXTz5pktlbeS8xYWy3zwgeyAZm/kyQRq/5s
 Z5+FPGrniOcJsQFBGWy9STDAyQGvO1IVgvr1GG1ffL+/tpgjmk7EhSBB2Fc640RbkEs0UyLt/
 zDbCcSFP1zhYACwD8vc1O38rV3L5cmm7fqkdvinLlUzkcXnz1DcOf7tdzlMf5DDQ9aT8PSQJv
 qoXl4J/MjRR5wfpbGe8+LkcCtzjIy5A/NNIuVvA4GG6ycOdXnSMOYuTe5BtGhuQkFkO7Iezgc
 Xs709/C8QExWnTsx63BsRtUilfE5jeATX+SeenBNh2kw6vpniaxbo+8pfFDLJN80wPo8ReI6u
 ++FDEIfc/HWPuN322ZizKwmvEZbNJMMcA4gdEWxYbm14GgKtnM02fJQ0u/nNLxQPuxPjPPL8/
 gLY7Cho2XO0MEraigOZSuqiaopPle06M73TkrgjvcVeJz8ea2sn5qXfu4dC6vu9IofwQVU3L9
 zciXfekO/IBbC9CO8OkGPT5Kk6mzOklxH8120+nmlSn9whlplS6R9M0FSJ30s3vDfVMjgdHxK
 Y61QtVdzrEjrUQ=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 21 Jan 2022, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > ... at least for now. So let's error out if we are even trying to
> > initialize the split index when the index is sparse, or when trying to
> > write the split index extension for a sparse index.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  read-cache.c  | 3 +++
> >  split-index.c | 3 +++
> >  2 files changed, 6 insertions(+)
>
> Good.  Will queue.

Thank you!
Dscho

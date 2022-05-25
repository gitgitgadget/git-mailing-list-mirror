Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B20C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 10:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242247AbiEYKbi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 06:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239770AbiEYKbg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 06:31:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF57B6EC4C
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653474677;
        bh=+fuNuFE8c5hlncC7zaCdKQg9Pvkra2+UpKmF5Ly6IlE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=X1BG0Htv+wSq7CUM+HqaNWm6gfjyDaBhK3//lLrE+kisr2c4xvkujjMQCzg3QkgDU
         kE1jkxz2UzwlswAIYUH8+Tf3yM/5/+3GGiVHJszjVg6zEoRrI/WeFCcTycfHWM6Uh7
         31qGO32f1E+eLAHTKqyXJ052GO6veuUbDcrZY0as=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.214.24]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3lcJ-1ntXJW0twR-000wiu; Wed, 25
 May 2022 12:31:17 +0200
Date:   Wed, 25 May 2022 12:31:14 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 3/7] scalar: validate the optional enlistment
 argument
In-Reply-To: <xmqqsfoyhgqe.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2205251224560.352@tvgsbejvaqbjf.bet>
References: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>        <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>        <da9f52a82406ffc909e9c5f2b6b5e77818d972c0.1652210824.git.gitgitgadget@gmail.com>        <220517.867d6k6wjr.gmgdl@evledraar.gmail.com>
        <xmqqbkvuwxps.fsf@gitster.g>        <220520.86fsl43bkf.gmgdl@evledraar.gmail.com>        <nycvar.QRO.7.76.6.2205201753300.352@tvgsbejvaqbjf.bet>        <220521.86leuv199g.gmgdl@evledraar.gmail.com>        <xmqqleuuazew.fsf@gitster.g>       
 <nycvar.QRO.7.76.6.2205241423260.352@tvgsbejvaqbjf.bet>        <220524.86h75ex01s.gmgdl@evledraar.gmail.com> <xmqqsfoyhgqe.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/mQlcWKsvhfysCRCMZjNOGmGFygmP0DxX1sXJYlXb6ZRVivfIno
 qUG1IV8Mb/aRBn28TCrkpU38YYhQkSCF6X8cpDYOSaLmmciHybDS9gphBVnuKzqskJ0Jz5c
 KRSB6XcQDJtOLfE1vXUKlFaODWlky8nVvzxJC3RP/Gh3t8xLFGZx1ly3lgRKGs7a2uVHO7k
 7F0XYHRINlaCyPQK8D/xA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PuXg+SgG9D4=:Epo1lNQOGvQwXNUjDRhxy8
 qg7I14QHZ4BI/f4yUR4BzY4meGxgCc4kHI/SbOjY1FI/lNSgjY6JaqiiPcUR/14cHuS3Q03x8
 LDCL/j98IsyxkwZJDJBeLBmNP12LbkSuFIlIlF/8sWkrBPP5xsxqc3RmAnXsGvLHfbghOLnJf
 oDugzopISG3hwcL9uiticbEtxGZEtrOSfFPTJz+qhwg+4mrMrsD4S7WzE+J0t7GhdWB/1Oq8K
 Rv9MNY0qSStpKMMO03sk5lyn/azh3SgJDjgfInr02m6/bfPjY0qFVAonXg15i2NHNNJfqhK19
 lj1VOKgFlO5LkzofCXdow7M1ya206c+2d/8zQrfe2m/zUTTL7v6yhHDLIm1gEnFMSGpgIWKJa
 PoBlFfj7zaYsY/VafBajQs9o9+7u/TR/TFrDB6mOFWDw+3/NeRXQDO+V4t74gwbpnpOvU4mEr
 MKf7sExaD++yaaVk7P3KUTj6mdCoeVduFbeLeOrqQMprKcSZ9tJR2wAsA6rpI631ycj8HuoFb
 Z2ZN2b+fdvwmK3OzhU5D1Vpjfx97w2RUASQyAq4OAOCkkLQdu1x7bRyZ0SJR9LkARgwTmkust
 ar6VWdSLxeFge/U40Gebc5jbA5tXMBOHB818kAb5yZFQtBVW+5j/9iBnLRO8eCQrSqebGlwzj
 uWbHxv6ikOk44mlVP2u3LddnC22PLQiboauj8LyKEiHjnLSOY9E9OAWpPnR7SbL9DcENUc327
 My2PJkwqxLsUvzwccWP7onC1N3523iODhY5FVPVRYu/Y/yvEivJ1sEpJ87vxAWSHV/ZOvH0yp
 S4yc8G/C9P3Y05Z7B/SY0XX4IfAgoMBoDq1VvrIvaWPrE86gjsLLdL5gj2Tpsu1xOPpl0l7U2
 F/dSGxYjpPVXbKdG5RwUMDxDudXOWPW8zLUVTiSncKTHX4tvj6WqB+6KpSswj9yYDu/M6FAtb
 yMq1tTcS9i81KBFznsNZSMwfSmkZWPbHNOmsNiJwZBFF4IGQCUEZaa7/dSdMoqgc1VT7439so
 h8zQZGUhu8sarktgNJq0STCEB2cXs+oBN7qoi6tcMMtj85QiTfJ5mcz0Na2fT/OgRaeKFwFjn
 tU/XiZZsY+JyiFGYW+Rbj5PTHL+vuqHI3WMUrAmp98RTTOOcuyguMxFpA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 24 May 2022, Junio C Hamano wrote:

> We can stop arguing and instead send in a reroll that squashes in
> something like this, which shouldn't be controversial, I would say.
>
>  t/test-lib-functions.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git i/t/test-lib-functions.sh w/t/test-lib-functions.sh
> index 93c03380d4..8899eaabed 100644
> --- i/t/test-lib-functions.sh
> +++ w/t/test-lib-functions.sh
> @@ -1106,7 +1106,7 @@ test_must_fail_acceptable () {
>  	fi
>
>  	case "$1" in
> -	git|__git*|test-tool|test_terminal)
> +	git|__git*|scalar|test-tool|test_terminal)
>  		return 0
>  		;;
>  	*)
>
>
>
>

It is still wrong to adjust Git's test suite for a user that is not part
of Git proper. But if your pragmatism says that this is the only way we
can venture on to more productive venues, I won't argue against that :-)

Ciao,
Dscho

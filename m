Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A62C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 12:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbhLHMeP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 07:34:15 -0500
Received: from mout.gmx.net ([212.227.17.20]:36799 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233448AbhLHMeO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 07:34:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638966635;
        bh=tK9OEaG8W2efOvMo3NMLFDlqmpRsmIAWxIYHMwkm2Xg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=P1u/uwMQCeR5qw9jFoFLJz635FJPaLcJbEkW9Xkt14h5AseqL/P9LxUEh9w6ax2/Y
         UJubjLm18genLLh1uwbWSwrjyAxbiV6s3Wpecnwq8hh5KGfol+laQO7xexScV+e2A3
         mf7+ggmJL/NWzKYPj10bfw3t21s6lx5FaKa3Vs8E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.164.160] ([89.1.212.223]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGhuU-1miGu92gEs-00DrCY; Wed, 08
 Dec 2021 13:30:35 +0100
Date:   Wed, 8 Dec 2021 13:30:33 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 00/15] diff --color-moved[-ws] speedups
In-Reply-To: <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2112081329030.90@tvgsbejvaqbjf.bet>
References: <pull.981.v3.git.1635336262.gitgitgadget@gmail.com> <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:IJyWPaB6fl+1db0MN49gHU+9fki3FADWymdMxpJWtqF/qfM1QAK
 FO6RzFFIc8Hv0Y4qQl6jY1SCWQDblDDgAs/MUUaLKa86C2IadCsO4IZ1UOSzqtECbnG+Axp
 8vC/WAUhxgQkCtfr40xwTr8f/jb0JR2R9Ff0Vjk6Z3eZFkDHyzL/8r69JJy0pSYCVfCaME8
 vw1Ma8sIENy6VIwcMNiDA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jWH/0urKfjI=:/rsogBq2Set+wYFp0txqrs
 21vi5EhGPuXJZebYkZ/B2obY5o7HiRqGEJPpMNUAIjrLJIaU9zKXT7o5Ipy+WbB8kfbfqDjZj
 UHVfZ7cKzAr+SHwFHsNfRtL8+d3h+TRgddKgtKCil4ZXE2Hb4YuwKNP/XYKvnEoSVsHAhC383
 PwwjQLQY59YxhMz/WWxodzvb4Ld7zKdCTVQhBD2jQhvMcAT5+VWuBeDmtC8sHlnEq3ju6dyHJ
 iZjgdXiIHnQ98oqSCNlJlCp3ltPunRzQPxvirOJydFgVf0rWr7yr+6vkXqVeYS1R5UWUzzMz2
 ODUZtUdaMJJdd0eLVJLBUd1enRwcLNExCcavXj1pmaAujWsq2izz0FBMg7M/JvfLlYZz03a2m
 OAiYtMDSSqOvfG2pwt1jLzDoOBnuGikCzFmyuWLjI785TyhZgsFO9XRiyYkjTaN6+fTiOcyop
 7Mh0PfFyHBAe6JxF8sgz7UBiP/hLwbn46guVSQYyanlZIvkk/evszt+Ycv8d5j6qqzevKOPKs
 C3qj8V4QqDc0RXyHHALTPyZaoWc6O2lIs2qWpj0pGX94Su6kwXDzVJe2ojOGrB0trm9uKYmcG
 2UFTf4SiLKbTfjV9RcNoQj3nn6h+Y84xMsn3+V2lidMyTXu2/R34Yts0FvgxKwW1oOWrkdajC
 HXZnBGkSzH1XLp8l1SUSMq++26EYkNQ6jniHbdkccsV2ElIOMLclSfMtwgLI1s0zRL5o/GH5/
 EEiZ7yrFWsSbpbvcDMXVXNNyrY7PvBHGVoYNECmtBMFspgc0Y5n+0cTzoexjQISHEhILb7dV1
 oQ5U1EoQbJfnDdWoAxYIPpowJwAND0vM70URiB3NTm80blHzU3WtFGYio+XH6i5LuMWYymeZc
 YKWaBI9TEl8N0FTWC6qM0BsTFwq3DKhRJHIkRvLm2KoMgvaDTP5OU88Lb/4M6Davfe0nF5bdD
 SyNTatoQ5iLkObnXjjl17YJKFdvlR6ezIbVf7INxAhlOHx0MS6/y3f+4IHdsyv/N+p0JYHbRI
 NepCE3ZgFRpHDqMlmybNnJr48jHkrPLFFs137Q8igt3yqpMx7HXWS/k2qlTiHOLNo/FBDlUtd
 gwhbBPidwyO/nc=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Tue, 16 Nov 2021, Phillip Wood via GitGitGadget wrote:

> Changes since V3:
>
>  * Patch 1 now allows the user to choose different endpoints for the dif=
f
>    perf tests to facilitate testing with different repositories.
>  * Fixed the alignment of the perf results column headers in a couple of
>    patches.

I finished reading over the patches in this iteration. Although I did not
have the mental bandwidth to review in particular the last patch in the
series in detail, the regression tests seem comprehensive enough for me to
be confident in the correctness.

So: from my side, this patch series is good to go!

Thank you,
Dscho

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDBAC433F5
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 13:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240407AbiAKNSD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 08:18:03 -0500
Received: from mout.gmx.net ([212.227.15.15]:46799 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240470AbiAKNRu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 08:17:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641907061;
        bh=tuZ630pSXoHgHm+QMsx8JLL0VDv6Mpy7ZZshSWuWCAk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Li9Gu9H+Yu4CZStWd4fprQ4niCk2M+vSpv/DRTuA7gBg9ajBVCMEkl6SgEfvCF3Ph
         i2mT6UVHTSHf/xnqwSpS1UcnWYslEi5E78vmaL8YTp+nnWg0fAn3A2kY/DUAYN+1Jn
         DIQ8heFSgpNePvddetqtygLcxsHRLQ1dvu5l3iLo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.82.111] ([89.1.215.56]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mzyya-1mBThz33Bu-00x6m9; Tue, 11
 Jan 2022 14:17:41 +0100
Date:   Tue, 11 Jan 2022 14:17:39 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, reiter.christoph@gmail.com,
        =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>,
        =?UTF-8?Q?Matthias_A=C3=9Fhauer_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Subject: Re: [PATCH] lazyload: use correct calling conventions
In-Reply-To: <xmqqh7abxmxs.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2201111412300.1081@tvgsbejvaqbjf.bet>
References: <pull.1181.git.git.1641657750776.gitgitgadget@gmail.com> <xmqqh7abxmxs.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zWnekr/lUrPvkD+T6RjMRTpLlqDEKNZUSUYhFUMjW0q+vi25FhS
 uoc/D8CzrSJBJ543mQ3HditMaLM9NqlX5BpCWBQw6pgxx1GoKrb4UK3JjiWGqdXhZzEbgmn
 qn5hj61ArUVxaLv5i8Ize28rjRNdKOO/E2xu8Ik+bqfJq5muldtIdsot+XzozQjeGBQLyqO
 ZHdQJ/X6jc7n5W81gvIQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dDiQ5lsW0OM=:aTdkHEhmrjDLv6RGvaW2qN
 6y52zZNxsaEf1zi+GYfwyHlsQucN/4dhzSMnhdnnCnXe6Y9q1F5cWPSqsADB0fY1P4fmnFqiA
 myl8wg4FCYAJfOdwZpd8zP1uM63QszsFTKbSIYWVX0pNgHN003E2RiT0+pIpeIMyH6wKGNMsJ
 9M7+nJYZzY3bEWhw38F7niryb5KQluH2iUaEpdwWmUx7GBAvjF24H3yRkRHYWTsEY7p6Svuqt
 lLONdTauOAgNntmksh5zZVrDuarZ7jHqv7UywrRSSFuOJ0BL9cNZoT+fm4rGlsyG6Y9+CngzQ
 veM84lWv//wdJPwWbPAe3IgoXxvAXKYPMoXYTpx0BZrGosxxG2icjfi73jNH6qb4M0zXqo+68
 HcqzwsnHVeGgL31RvzRplaRmxMbzU4GGsRjE/IIyC1j/tdl9t3mk1N50Wtf6OAH2gek8gHgSK
 7owaJ+LcFUCq2pdmZjKgyFF4WgbUa+12bPYa1Q5/4TI+4vbAIcQYfty7MynBNzFgg6cl+2U42
 h1pixpPdufw6+jMdEMPzCFnUL9/B2JrKGNxHF+sX6MMhZCSBySaJpTvsMfLV3qv6+1B9cI1Tg
 t7E3nvH/I+LCp0BVsQ03Zl4ywHnDtD9AAc0KP4uIOX+6Szvf3BwppElvmIG4GEqApe7GuRvIH
 DKJ0V/gkeyrZi2bd2nlQMPkU4ulJJkIRrS5QYcaujnvfsZmK/ndu7T/WIk7lmBu8xRTPVKKa4
 NxOZ7luwxgUkIECMRDvMxrY8riTgVuYq+ZsyB3bkpPO+FoK1debD+nHu7mSoLfK/O3wO640NE
 XC0hvJyN8bUZcCDuF5r5ebNX8GiL8hABmhi6EhfeZMeIbR6YBVqQsNlsNOlu4lO8LwcAx7GKT
 XOTw4z/WEE2yo2hBNW6dTY1t04LPiLrJ6iYXlxXcgPqt24BVUAldTg3rNsHWIEe+7y6YrytrQ
 3/KtRB/AR9N27jfyXnLieAOcLcMlZRWXUQi+aQxbaNVKgOLLfXm9yccxZJpP3aV9lAFGzC9eS
 ffdEGKO+wdXrdA8e456YXydm1aBUKP7/qYkfLW6ffBbPppllYVhGTI04QcCgwigrauxXGFL0f
 qZBJ4FeOFe9lyI=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 10 Jan 2022, Junio C Hamano wrote:

> Dscho, how does this look?  My choices are
>
>  - Waiting for review.
>  - Will merge to 'next'.
>  - Will merge to 'next' and then to 'master'.

My preference is the last option, merge it down quickly.

> The last one will make it as part of Git 2.35.0 final, unless there
> is some unexpected breakage found later.

I do not expect anything to break. Just like Matthias, I actually expect
future breakages to be fended off by this.

Merging it into v2.35.0 final will require a tiny fixup in
`compat/win32/flush.c` (which we carry in Git for Windows already), but
that's a much smaller deal than the fall-out of the v2.34.0 refactorings
we had to deal with.

Thank you,
Dscho

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD76C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 21:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236013AbhKVV5Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 16:57:16 -0500
Received: from mout.gmx.net ([212.227.17.22]:32833 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232805AbhKVV5P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 16:57:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637618044;
        bh=8BAb/WWf+ErMWMPwX0pUu2IPl8EvjLnNV1E1OWCH+zU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JGuRQ8QWWW/JzL/FX3J89OptjIqK/pbhhVBXIgKD6FHtB/8ErLFn5OjUBsDKg/tUa
         qdvIt+SiAJ+E42P9BpovcvnyLe4HVwehNXUChr4H2rM5v2NRUcVP43iat3yWGkAWI9
         T0B3UT2d8qb2AW8HdcH6FGCpBRlgVgxq/NddR97o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.219]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYNNy-1nBuhi2zZK-00VPSz; Mon, 22
 Nov 2021 22:54:04 +0100
Date:   Mon, 22 Nov 2021 22:54:03 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 06/15] diff --color-moved: avoid false short line
 matches and bad zerba coloring
In-Reply-To: <a6ff589e-c968-8a96-a8ec-1a982d71f6be@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111222252450.63@tvgsbejvaqbjf.bet>
References: <pull.981.v3.git.1635336262.gitgitgadget@gmail.com> <pull.981.v4.git.1637056178.gitgitgadget@gmail.com> <10b11526206d3b515ba08ac80ccf09ecb7a03420.1637056178.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2111221435140.63@tvgsbejvaqbjf.bet>
 <a6ff589e-c968-8a96-a8ec-1a982d71f6be@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:j7IRi+WMF0V7GXZNnYC1KFQDkx/W5PoXLpNisr48QEDNVLGdUc0
 vY5c0PMAAG4TexvtMD1bZuiufA0zXzMmKarWh5L36EsW9cURAHM8htFYEaTc08bVVOHw41v
 hwU3/DECkbfwkmJFZJQU4hafGItPk4l+tSrJCEs2tAp6xZi7HIj0p0nrBn/Ls/2v6R/Pwcg
 ty/nnThTkdSaJyiBM0zRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pcKT+r+Rryo=:X54cuUMOSb3Xfm4Mb87Pc7
 OK7p3d5EMNIlpNvO98P3RnnGf9QJoUYN8fn3J7FAvtNAEyn6OjU9Ona1ZZOZxjhdVuVEYCmlB
 CBjUMH6hg6Li6VH/VGiwDK7WkI9Bd2ikizHMDikOaA6oneYgI2KCC3iCFmE58GuD2SnhQZ+zc
 xQH0I3We8jsypqpJAMjO0jJU+M3qJOBZIuInfyrO0lc7/ty3r+vLAJU23cU4CafrG5xWYW4b3
 ZmXSFjQngOhKO6RJKIb0AL9sDmNWFat9H8HCUmbZk+kuoYR/yBD1+0jy+r1XhtGiryDoJlLZQ
 4o2O9EW6lpBqF8ORYVHlMmf8eXeDWnYPAuJwvUa3jrDKNUoAnihhNJVHukqrtx/yvnpOMuAqk
 R7kuoLyCqkU11AfCh+JCf7RSe8uir9zTtm+alKd6TQS7ZPSe2tuh+wCYiuVEjysxk7CS6cDgK
 2IHVBLk68tLrUMx0vdGw9dgtbCAkFbxFq+ocJV/OsZaAoeVOZ/X//ljOHX4Zw7g1hw/K7wPZb
 ah4to+luX4dpAtQO683vCY7XEOgY4FM8U9+yhNY9Q+WcxkHVAJskGn1f2ZWszZaZRoHJk+yAF
 eFFQJwl7lnZCHJx5N7nEFcTse88A4/n1MeJuQXg1Q1C0RA5BUGlZPITMBu0tI1BdlTYeCu6Rd
 KDdebCx4BcpazTj6e3rCiOKwqzb+alpez3OSV03Qpp6L8TqUlasGbr/KqwFJwyvX2v2rEj0zG
 6THYrNua/T/lI6pC1bQtw4ZXC8NXA9eF7hfZvjKPRKQ5BrfOvOQl5wEaezdJURd1ZMyBygJgI
 vmtnoPGsJn1PUcY2QlUwDwckLUuHYWlTO4J+jAbc4peMkup4S86tjNKGHMGJcj51A/Bv5bz0C
 tdUnIFeGtfgem7TNaCdMiKTy297TFDUeGlwZApj5/IBT2VySaK4TRZn2MmmjUcr6D2QeHrAsf
 gaN7hTDxl8PS8NBfWJssNjFr2LetNCOQgzLpsRPF5IgwnlwrB+CqWFxWN5r6/UWlOSWW9uQ3c
 0YT6tBqkUmnnIeXBoLraa0ryHYbDuXEG8jH6W1GwyenhWLt5sj+XP9sHVaf17F2yJ5OwJdJyI
 o0XGyCOU/Di4Qg=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, 22 Nov 2021, Phillip Wood wrote:

[... a good explanation...]

> On 22/11/2021 14:18, Johannes Schindelin wrote:
>
> > As I said, I do not quite understand this patch yet, and am looking
> > for your guidance to wrap my head around it.
>
> Thanks for looking at it, I hope these comments help, let me know if I'v=
e
> failed to explain well enough.

Yes, thank you, I think I understand enough now to say that the patch
looks good to me.

Thanks,
Dscho

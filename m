Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F96C33C8C
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 12:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF78206F0
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 12:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="jmXvVH/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbgAGMLr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:11:47 -0500
Received: from mout.gmx.net ([212.227.15.18]:57177 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbgAGMLq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 07:11:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578399100;
        bh=PzofCelMIJE58RAq8AnYPKCFCcArY4fepSbY03gLEhU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jmXvVH/OuZlPx30VhFUqDZ47ZUdOxc4aphVNNUsDTI5FdnLZwAld0CGYna8D7kIvy
         6CFU2Vdu8pG4dPptAY4ZCwtgYDxgbLv6cH6VzgF2k5jH1DphjuMcx4uk288jJwkH9s
         nu7ubs7XMeWBB2HFjU43xyIF15XvTcYSd/qCozO8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mg6e4-1jLNMg33B0-00hi1p; Tue, 07
 Jan 2020 13:11:40 +0100
Date:   Tue, 7 Jan 2020 13:11:41 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Sergey Rudyshin via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Sergey Rudyshin <540555@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/1] Preserve topological ordering after merges
In-Reply-To: <pull.514.git.1578393057.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001071308290.46@tvgsbejvaqbjf.bet>
References: <pull.514.git.1578393057.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XpKbG8vJGAgMLigIgb/5CMJ8iwQbvG5lqmUO8Z8XWVFbRIzMaWV
 2j2qBAHg+zGVbGvMSWakIcTZmmvNP1redQZVT8ACqNUnPywHjwG5G4v2GeUi1jBEDZvB8OS
 6ki+kONNNRY2ydimz20a93axQq8WVcjUvBD/65E7Ripf7ZGfuGT45ueJysthE2yH3/EoZsY
 olVRdBLXlYY1lQDihW/YA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZPfmmrLeiCk=:0zDp6LdjTepA451ie1kRF7
 bo2THHIM07TLOmKThu75ilnk8XXR0WK7KnIR+2aT2uXP5SpxjlKhum8yGhdOq+EeKK0x6jGxl
 5wZnUzFig15y2zFVYHyGvWW28HCxZrKE8qYqpR8IjOP4Z1viBR1yEIEAtxkFvb9L4ojHbx8kB
 YS55nZy07C+TpmxtIoJIR7sdmka+TIMLpG8RdF85fPB4cs5lIjzHIkAPGLq5KqCjt6Xq11j7C
 AKnZq8MNGMYifK/s1CmvOYtx6m6bWHCyJ0Zdpd4c21eRN6cbFYEjvMr4S4syOspV3p7B9GyCa
 2SHSeLhgvpbwlJh5ILSuuonNijGH6Iy9sUCwyCnHyNz0YE7rXWSekoOApXCDNBtn1yvos4ihE
 AWgDqXVaQBfqyFOR7wJBX3P5OYEFuui7s/C1Gm1hxoTCO7fdMoL3kgqxqwzCxssdpTIQsz+k9
 Va+qUxv3O1X3kzcPR1wXta6E9vQqqS9QzD2wkJXEke89vUcCQ6OHwdT4tGQH3icuif31K7GQn
 +Ajn0aWr0axaZVAQoyi63Rulyqp1+kWQnOjpXYvMN3jFksEJXM4O/JwXHV5MYglZ5jac9o9Ch
 sb9R+yp6Xk0nrvgTd6HuKa0m8xrQ2UxhqaG4gJul/ZVqUyrWyH/Os/RqNuN3+tBIZKrXpNnag
 NxLyaktFDV1EduNA3OmH4ShD1oXjMW5CLJNk6EyPeYNAYM7CDZs1E4twAxCwJwlmib1przbdU
 MoMH0lP8uC87x/XXDYyrJ0R9SYHDUGAt2hJt04aRUcUgs8t/bjhvaqJ7vMAEfGEAxAFgwwRrT
 9ISGOh0VA30/j7R2TdnB2LIV/lC4E483LZVozxEnrBfvpNh1sF6oOk8YVEcfo7ts4MrPomCPB
 UeCJEENvKNnlOMVtQCfH0q5JtReH3wOakU4XRVI9uqUVOoFM2sROiEAki+tTU461/Posy/9/F
 OwqDIAl5vaWEaP/nQ4YvLIDQks1H06vjpW6vxK+zLJlJngXGkTg8trZ/nwg/Dk361f5AjAYCH
 ee72d5nh+Zl3AbV/eF4XgU5/89Ao8uOiEchJhi0wVKo0GTKRYsiuLraMKSXA88bSzZ+EWIXMZ
 xOIcwl83XpgnSO3mHHWSean0IDZoQqlCfpFTSI0Y3XE4rfCdqd4ioDHcMGSwWGJVbso3qYaEB
 1DwZc6gaxWO+plMYF8q7QcRht9dO5wNQKlWuSLDzpnDSzNT++POJIgIC/s4A5gkgy0lcl/oJo
 NXdUZQvKkPzfj/kLjB33N1AXquVm7ALOLCCU3E1Wn5tadkwdxz+z+hTMeT1M=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On Tue, 7 Jan 2020, Sergey Rudyshin via GitGitGadget wrote:

> This modifies the algoritm of topopological ordering. The problem with t=
he
> current algoritm is that it displays the graph below as following
>
> * E
> |\
> | * D
> | |\
> | |/
> |/|
> * | C
> | * B
> |/
> * A
>
> commit B is placed between A and C, which is wrong because E stays that =
D
> and B comes after C
>
> the only correct solution here is
>
> * E
> |\
> | * D
> | |\
> | |/
> |/|
> | * B
> * | C
> |/
> * A
>
> while it seems that it contradicts to D staiting that C shoud be between=
 D
> and B The new algorithm solves this issue
>
> Here is an example: walk to to the root via "first" parents go E -> C ->=
 A
> print A because it has no parents step back to C print C because it has =
no
> other parents then step back to E go D -> B -> A do not print A becase A=
 is
> already printed step back to B print B so on
>
> This change makes option "--topo-order" obsolete, because for a single
> commit there is only one way to order parents. "--date-order" and
> "--author-date-order" are preserved and make sence only for the case whe=
n
> multiple commits are given to be able to sort those commits.

I have to admit that I am not a fan of this change, as I find that there
are legitimate use cases where I want to order the commits by commit
topology, and other use cases where I want to order them by date.

Maybe other reviewers agree with your reasoning, though, in that case you
still will need to address the test failures in t4202, t4215 and t6012:
https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D25867&view=
=3Dms.vss-test-web.build-test-results-tab

Ciao,
Johannes

>
> Sergey Rudyshin (1):
>   Preserve topological ordering after merges This modifies the algorithm
>     of topopological ordering. The problem with the current algoritm is
>     that it displays the graph below as follows
>
>  Documentation/git-rev-list.txt             |   4 +-
>  Documentation/rev-list-options.txt         |  41 +++---
>  commit.c                                   | 149 ++++++++++++++-------
>  commit.h                                   |   4 +-
>  t/t4202-log.sh                             |  15 +--
>  t/t4215-log-skewed-merges.sh               |  44 +++---
>  t/t6003-rev-list-topo-order.sh             |  54 ++++----
>  t/t6012-rev-list-simplify.sh               |   8 +-
>  t/t6016-rev-list-graph-simplify-history.sh |  41 +++---
>  t/t6600-test-reach.sh                      |   6 +-
>  10 files changed, 214 insertions(+), 152 deletions(-)
>
>
> base-commit: 8679ef24ed64018bb62170c43ce73e0261c0600a
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-514%2F=
SergeyRudyshin%2Ftopo_order_fix-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-514/Serge=
yRudyshin/topo_order_fix-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/514
> --
> gitgitgadget
>

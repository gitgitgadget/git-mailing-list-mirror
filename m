Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82832C33CB1
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 09:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529632073A
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 09:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="CSrhSm8k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgAQJv5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 04:51:57 -0500
Received: from mout.gmx.net ([212.227.15.19]:47977 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgAQJv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 04:51:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579254704;
        bh=iJ9lvWyOpZ1Ifl2fWDvi3pVglQkYW4A5VFkAEJg+AZ0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CSrhSm8kK8w7aAE5cetiRo6IreOFOz9jca2wTgzthsmHorZo43ESBX92Xb/vV18qY
         H9pJmU5g1NWb8hEFhRNFvLnyQbStyk/+mYB+kcnK9+Bujltop6lJxL3D5UzPXkeK3V
         dEWxNxz1YIViL+Hx787JKvVS1U05Eei1NuDuZSnc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMXQ5-1jBR0p2kRL-00JdIC; Fri, 17
 Jan 2020 10:51:44 +0100
Date:   Fri, 17 Jan 2020 10:51:42 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Alban Gruin <alban.gruin@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Re-fix rebase -i with SHA-1 collisions
In-Reply-To: <20200116235411.GZ6570@camp.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2001171050000.46@tvgsbejvaqbjf.bet>
References: <pull.529.git.1579209506.gitgitgadget@gmail.com> <20200116235411.GZ6570@camp.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:N6Odr22mh+enRF6E1Uk+vZ/1M99ItbSA0cNt3Q238ykmvBddaa2
 +7EGavMWC8N51PS0X1piAgcAs/2UYZ51mgttS0N2tTZSgSg4SkQS4f3nHPauNBae7XKDaWp
 K7vi2xdmGKSTOqsujhGieCFFUe86+g5qQ2sio7GPPTDbiqusthjM6d1RwUDw2ChZU2vmvZS
 /JUJJy+9et9hdcrFSwJWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q6hA5UG5HiY=:3UJP18FTJAe90bSXY0d+Jj
 pIzxMZ0TPAmjcoHDlWJ5nZTu7NvNCLB+oaF0XNgFSbLslunmDRX0ZzwmD928R0+JDWH8Et4va
 y7+zV9pzjk23Eqq3cRAQ7EuUjKsiO2M78rxQi7QcjEzXUcZGkCq0DxnsZG5vDSEvrEKHA/8y4
 YUhLaItxRKDBJHDabk8euiNpRYICCl1LUsu/h7+gl7ancTpi7ID+tGj/eTJspyZJIrUD3mltY
 datuh7Qjx4rCtEtj6iU7NRSPSbRu2m5k0yDO7oaYP6CGWSCI8Vzak42BMInHuBLZWSz1CJ3AK
 6RqxYOO9BwzA8MzzCLXlRNf+SnZrh81wC7tCxu5eStMBMteYuymtVNxtuyayy/SjU8JfjkAEE
 yzbpfV1PYhP99yhB0JFtuu4KdaM49aiCvU3y4f5pWPJFBnuTYhEuhbkL1YJ90WqCGYEcJbyvr
 fI3Dbz5DFH5h9FkIB8bDKVihWCmG4y27GsfWympf5WQ13UOFRm/lwWDvNBI4zb/0cz7SZ2Djl
 Nt9mO1JuRcC0QyWdMNkuM0BzNzcklDSCBqH/nXJpskuFbztEpe7HrmSasA7yoCjExhdNf6w2j
 bg9s+qistABnQ2uJfakDQMajvFeT2Ez7c/vE6cZBgggeyaYjf3PlFBDgHWZ6d3jpxlYga1WbY
 qF3gJaivJ7B9HYG1AMlHjAWlpfwGMca2oe2koqf4OhCmeFFoMe/dqis12dYak0wjyTSLBVPHB
 EVJOd+49sUe9VRi7dwvQvGJi1N6prbzeJoEeARvqgvclg1JdaSQjAS9/a1ILYWsFae8X1C9zl
 UeFYu7bKl6fU/T6CUVmYDdWHYlOKtwCgmtRcL+i6n5pibup5T5XsxSejnuH7hEAal1vbkePqe
 EDwvyGTThBzJtq2mA09uYy2T5oxnT+ICILqhvliJvzoO+mi1kurWihfpWR0dgizWAmdhKbd3e
 ZtQLPB+8kzQI3xroDukiNdfn0Xa0R9nR2HzfetxL1SPYWidekhrvGtBvN1FvOBYB+MSmBTQB7
 YLJ7MHX32ZdqWdIkSHuJPpEyYWyGlZ4qs97B8zvrTNq1kPvApSlx7to+yhO9l+Q87wq/N4kXc
 P8zM9Gc2RVqA9Vs3Ij1An3fuEODNBJ+1KE/fPErnnsacW3HNF7OiJFcfX5LjBpFl9SJuZH1lG
 zrfmGRgw5BPMO8AmKyjfArXFhMAAm9BF8E7jkyGPx4JWopjpIjQys4ZKSK5Nx2Hg1FLIXBAyf
 GcCWbt1QvUhIXFFzdiIzkHtAqc0UWhg+JrljgtOVptEpQIhus/1t87aA5HeU=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Thu, 16 Jan 2020, brian m. carlson wrote:

> On 2020-01-16 at 21:18:23, Johannes Schindelin via GitGitGadget wrote:
> > Triggered by one of brian's SHA-256 patch series, I looked at the reas=
on why
> > the SHA-1 collision test case passed when it shouldn't. Turns out that=
 the
> > regression test was not quite thorough enough, and the interactive reb=
ase
> > did regress recently.
> >
> > While in the area, I realized that the same bug exists in the code bac=
king
> > the rebase.missingCommitsCheck feature: the backed-up todo list uses
> > shortened commit IDs that may very well become ambiguous during the re=
base.
> > For good measure, this patch series fixes that, too.
> >
> > Finally, I saw that git rebase --edit-todo reported the line in an awk=
ward,
> > maybe even incorrect, way when there was an ambiguous commit ID, and I=
 also
> > fixed that.
> >
> > To make sure that the code can be easily adapted to SHA-256 after thes=
e
> > patches, I actually already made those adjustments on top and offered =
them
> > up at https://github.com/bk2204/git/pull/1.
>
> This series looks great to me, and thanks for fixing this.
>
> As mentioned in the PR, I'm happy for you to drop the SHA-256 patch into
> this series if you like, or I can carry it in a future series.  Either
> way is fine with me.

Excellent. Given that the re-fix to avoid short commit ID collisions has
little to do with supporting SHA-256, I would like to keep the patch
series separate, then.

The question whether to move the SHA-256 support patch into your series is
more a question to Junio, i.e. which patch series will be merged down
faster.

Junio, what is your preference here?

Ciao,
Dscho

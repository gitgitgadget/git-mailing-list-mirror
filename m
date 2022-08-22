Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E773C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 14:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbiHVOnH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 10:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234896AbiHVOnB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 10:43:01 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44488371B1
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 07:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661179370;
        bh=heYV/9rgd0BNfFb5dfJ4VCwlycvTzhA1nfu3EWWhFOE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hdf3tB5nIIc+hJutgiT1hUIm6WGYLuSRXPHr9LM6ImrXbjQp+fG5Oibr65JvHlIHa
         1QMETaOVSkk2lzF95Bm0YISQ93E9NFCfIeyrBh1f/XovP/eJsZngx3esO+STq2zSbU
         r/K1PqFvBOsOP/I632AjPKFTyp7Sd/OKt6SoB/L0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.137.196] ([89.1.212.11]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MV67o-1orBfQ0QCM-00SBBL; Mon, 22
 Aug 2022 16:42:50 +0200
Date:   Mon, 22 Aug 2022 16:42:49 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v6 0/6] [GSoC] bitmap: integrate a lookup table extension
 to the bitmap format
In-Reply-To: <xmqqlerkj5f9.fsf@gitster.g>
Message-ID: <80852679-rsso-rp45-q328-99n36q0639sq@tzk.qr>
References: <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com> <pull.1266.v6.git.1660496112.gitgitgadget@gmail.com> <xmqqlerkj5f9.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:CCqMVV3CXBmnZNSitnrsyyK+tzG2DVG1eDpzMk7GWzEBvCHD/QD
 T+tM7HRpaPR4KOIZ9MS+6KXFOPmh7CZMtESoipYZgVVByQ2rgcWvT6znx4XKgBw5Z/CUcDg
 Xs2QiP1531l0ZQ2C7EvyR8obf80axbaJPiuiwU5cHOTwSE9c9iqyIgTD4Jl/mlOPZ3KBAAK
 pNPfO5EFxS1Ob1kW/Y3gA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z8Aw28ow0KM=:UcIuTJ8mdLpQqo+r6QbgcK
 B+S7PN5bB0Yq/wChGcjGxbozceq8iGlDYq3+wVk7UxDtEcg8x4GDz1BROv9STxUzXg0Qgn6oX
 wlbRrFjQwEBRFryLTYuArnB3r9glhHTmpvjC/WTxLbFMW6IrMHbYkRiltMkN4OWZpivpqkmGq
 DPLl3WgZZixbuNNLeAc/GMSfWxL95eAoJojP2HcOMUKlmhZZyYHXblW7+QavXAps2E35YI3tq
 PwScAB0xqB47muO/NIQ/0KWql96L/5onPnb1pAgYvijTvXsLL2KJXhJoKlOVAkqYs3B4JzpS9
 hTu1c0hiDA2mAidNpN5/GhkD4tNE0QO/OSTzg+S6mfGcFdVBNnLNywjFJ5YZl9AKTPI1ZhOPq
 oG37h4x0UkMnSzfuLqQxmG3Z5u6bGn/3HrtPxQglasEhEW7Zl3y12xoxclXSeIpHq7GXzZh/6
 nTzr8nWEgTJUXRHrSgTeMCP/5CSUz9IEIV32ZZpEzoe70J6/Km4+LERYYf7P8nG7Em8nFO1u0
 BFf3vHQDEn8Y9NmqF98cuEng2VGPOJCgOhS64qZUCum0K9WEDayKgBxoexdcRj54/HJCeiGwt
 e8Rzo1YhO7uNeJ2IkxVi2N2WIUVrH+fSG2ARxPhJnoIQWA8Tl5oeVzi9Q5eC7ob9Hss6rn0+v
 POETEH6TfhgaWYoy+KzZjUOwRSpb/5LvvHBQyObQHhUou5lCJwX/mtGu/A5T6AiVIrNSX+FNw
 fd3UlTJmpYlino5xGhbJLdSlevUWOYfoSutBEwRTulcIgHxt26GvgiDnbrALYdKq4FxD0mRGP
 SjRyh31cOD4slQAM5xlYXee3l2MsA6snckDalGuL1aX8oL2dFMPfFRN0DMEPmO9YqnZt5M24L
 g1DQ656V4bM1bx3rDJMb1+cz7W5q4cmtcIB5oAc38QukRmbhbwLaHeCsYc62HRlA1/wPLOq6y
 HIzS3Zhj3juyBUjHXgCnvhzxszM4nmO4cBi+g5/d+XQ3eM7GNh330iHf36Xtc2d77SX1J67ar
 +Y0U81JPs0ituqUOfXcod95iB47yMGPo7SHwlVHPeOTDeTRjGaVVzmdAcJad2xes8trvnPoJd
 Nkvu1HbVf7OoUTH9tYJVy9zcVad6VR1Oty9hq/IGm7fGEAJPeAixKFTiw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 19 Aug 2022, Junio C Hamano wrote:

> "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > When parsing the .bitmap file, git loads all the bitmaps one by one ev=
en if
> > some of the bitmaps are not necessary. We can remove this overhead by
> > loading only the necessary bitmaps. A look up table extension can solv=
e this
> > issue.
> >
> > Changes since v5:
> >
> > As the failure in the test case is not due to this code, I think it ma=
kes no
> > sense to delay the patch further.
> >
> >  * The performance test changes were not accurate as the second
> >    test_bitmap_cases call using the repo built for the previous call. =
This
> >    version fixes that.
> >  * Taylor suggested some minor changes. Those are addressed in this ve=
rsion.
>
> The discussion on v5 was quite active, but we haven't seen any
> traffic on this round.  Is everybody happy with what we see here?

The part of the lively discussion in which I participated exclusively
focused on the failed CI runs and trying to get to the bottom of this bug.

Taylor contributed <cover.1660944574.git.me@ttaylorr.com> to address the
bug. While he seems grateful for my help, I am honestly puzzled because I
lack too much knowledge about the code to have been of assistance in any
meaningful way.

My participation in this thread should not be mistaken for a review: I am
woefully unfamiliar with the bitmap design (let alone code) and would
therefore not _dare_ to offer anything that I would claim is a code
review.

Ciao,
Dscho

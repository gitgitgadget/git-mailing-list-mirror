Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA222C432BE
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 21:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8499460F9F
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 21:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbhHNVrx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Aug 2021 17:47:53 -0400
Received: from mout.gmx.net ([212.227.15.19]:40221 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229532AbhHNVrw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Aug 2021 17:47:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628977612;
        bh=vneFeE/UK46s6QBnsmgI1JmuEo7TV8fvZzI3Y923lVQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gLOKNbpLcVhIkTWYiLKNvsCFnqwp0lPPiXQoE7Es3bgs9KinBjM6VZEhfhBw6pI9B
         /7yztFJbiGXFCgmQX2QmXF4nmEyGHnDgC7DXA0BuUdcmaXYDMcTJfMCnDezTFmcmL2
         r8H9qTBqwPnkKwMN16/B1a+YRv9ve4vpQhr54IHo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.60.179] ([213.196.213.229]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MzQkE-1n1blz3u4G-00vSBR; Sat, 14
 Aug 2021 23:46:52 +0200
Date:   Sat, 14 Aug 2021 23:46:49 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Kim Altintop <kim@eagain.st>
cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        bwilliams.eng@gmail.com, jrnieder@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [PATCH v6 0/3] upload-pack: treat want-ref relative to
 namespace
In-Reply-To: <20210813062237.10403-1-kim@eagain.st>
Message-ID: <nycvar.QRO.7.76.6.2108142344570.59@tvgsbejvaqbjf.bet>
References: <20210730135845.633234-1-kim@eagain.st> <20210731203415.618641-1-kim@eagain.st> <20210804203829.661565-1-kim@eagain.st> <20210804205951.668140-1-kim@eagain.st> <20210809175530.75326-1-kim@eagain.st> <20210813062237.10403-1-kim@eagain.st>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2VpHG9yRu/eRkKFCuU+BPE5H3ip4FM2qdF9eznL9LHxeNCI8OW0
 X1rl7UOogoYNC3aqITCZSxSGroDErcYKyBjzYxxU+Wdsxk3rT/xJDpTuPMKOWoUdxuFj9CC
 ECXf6PX6hrizQpGr0CUe+MVIfzxZN+2YMCgZ2nChHHPQOcg/5+RYWFHPzpwK2ZFps2jnSQm
 gwWcdV3TMtXU5AGNpJcEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RkppJyIQLl0=:2VDoFBHbgopxsxDSCU4jce
 PGX1jC9UXJKGeFE2DSkha7dhkBU1eltdPzmWEdx1FUkbxntdRbzx5hv+KIuvCd4u6UOWFA9FT
 ZI+zlv6/3o7Dj3OS0XvBTGJBAte30dS4/ZZGZlVWczd1v06QeUyAt70RKWAtUsuIDQ1J0zwwo
 6tYD3cm+V4ivZMeFsBaG8oKl0hVQezKV6Hco7AUj1oWXbyktGfFgqPXC03JosywbLhBG2cNGo
 F8nqI/zTAgHQF54flDWhnsefVHXjAKdhm86qu6fMVO8tRl1Si5dSbhG4nvTAZ8zQMnM3+rW4H
 SdDI2meO/grObkG88nq/azI2S1rjo2TvF6GCpBoh8f1g55Bmk5sCor/kyLCaJJ6kAljDYaCgA
 6iR/9aD1pY45EbUlEAeE0kIQdhYuTD3W5P3hiV0LOEZNfAcbbSoYSwe9qxsVZQ2gdbHif0ih4
 AxjkscPDe+foc6pXke9r4zKou8jVPt9jnps6Y345Sm+8GxJnSsddp9D1URvesBZz7aPxJaF/6
 BBN+iUW1tx2MvKvOzlgAaYAv/kTaqwVLCjNlq6axbhzJDqAY4v7ROwdyY6bfQsuufWt62r9rC
 gQgUW+X0XNRlVMrWw2V2951i5zlpjxO0sguWPCQXUz62hsV6PiTY+/3jJZzclOVxeIERuSclO
 SLQKrGirAnbUhT4MnrbpGj7CG45XFwyeS+wY0ve8A+ZAT4CqBUXY8L9lkBlQHi9e86vy7LNqQ
 yQAiRU5VcLsacSNxdazTW0p1dM594c6MOqsXFcSFxtZYhgBjok4LkGrmQhiLSkXDvQ4ExW3fJ
 aUI20REC9YhL0ky0/JsrzpR/pJD7qZrOH3PLlhVEEhl9s4qy9/ZTnTa8hhrjPe94gbfXqbb8w
 I0i+E5xkNJTD8RnfHHpigxeOvCq6v6ul1DNzh8JHBqas5YgHSc7DTGLdsdHWGCmcYReo3pZmh
 0JnrSiVn6EkBXm0DcUlb+yvRtRAnL/Y4UQ9ldpz372Wg9s4c+jXmX/r9UoWzfFw6Shrk3FYhT
 O5KVjOq0LGabl1lsG7Zq1bwoa4EljyoLZcsa4GEYMSP74NByhHgQYYiiPRRlGGxZbZ+w9ywcI
 HdujQ4NyDfaWTv3ZlC5qA9mibHRfaZxZo04UO0DycLkylZQ3SIme9t5nA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kim,

On Fri, 13 Aug 2021, Kim Altintop wrote:

> CC'ing Johannes Schindelin as suggested by git-contacts.

`git-contacts` wouldn't know that there are better experts on the
namespace matter.

My only comment is that I would find the diff to `upload-pack.c` much
easier to parse if the `arg` variable hadn't been renamed.

Ciao,
Johannes

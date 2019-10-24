Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B4191F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 22:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731317AbfJXWXJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 18:23:09 -0400
Received: from mout.gmx.net ([212.227.15.19]:39151 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729789AbfJXWXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 18:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571955783;
        bh=W8nY3XTypXIbG5ht864oYOLVGVslHuZzBd4azT5z62c=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eBvXaepTZu344zEdlRuP4SLfjY8mCcvIyzN0pDxikY92xFMg/Kc5fvHt0m7QUxtDn
         6arZ8Dof7yCH03j4DraDJY9NMwpVlKdc85XACy8kPOeB0Z07fgruYwAWpHikTQ5uVT
         0WgwSQ3UXs0AkT2cJk2/WP/bqxodm0YDbuLSEk88=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkHQh-1hiM9u1dKz-00kib8; Fri, 25
 Oct 2019 00:23:03 +0200
Date:   Fri, 25 Oct 2019 00:22:47 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] merge-recursive: fix merging a subdirectory into
 the root directory
In-Reply-To: <CABPp-BFYWhyLqUktEnk6A7v6135k4TQHO20Wiy32mRQekt-3cg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910250020220.46@tvgsbejvaqbjf.bet>
References: <pull.390.git.gitgitgadget@gmail.com> <37aee862e14b1352eb08485f15ea06bab33679df.1570826543.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.1910122152210.3272@tvgsbejvaqbjf.bet> <CABPp-BFNCLJnt4NgFKVxURBGD1Z00gastc5q4ZPjcHmwS=kuFw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1910141211130.46@tvgsbejvaqbjf.bet> <CABPp-BFYWhyLqUktEnk6A7v6135k4TQHO20Wiy32mRQekt-3cg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:aDhIMmEO/aLO/ePqCEggf88T2ey4WAJYYJtoapGLbzcZQzgT2t+
 M868Vl+1sBIlyxNSnHJhn3qcsOSPM/IlwpyFlLE5vxQopQ9AeUI69LwFD68wgOHg77TVpXI
 VqowFnn6WD/5P4MVKF74jepuEuwTTUDImxDplem1hzpewgvIE4iJm68/e24vhmG5mNLfVcA
 nMOtev2s4KnZqv+tRcdFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LJSOAdcFXIc=:6GpKOoaKs65+o2p+4nf+1D
 mu36wcuEOE+hIdOjZx6Yui9Fmeq3ICyJ4nkCn3JwPkaR/Lm8rp0qYtyY/5zJOvdjonoJz4Xrt
 /ZVY2wesehw6obsVbx7teqIhEuCFy269o+A08+NNRtJuJasYCLRk0TTaPJD5ZHHwEu49o0yws
 VEfyfpNJeujBlmvWvMXpvAgqUGFStIkldPLuEFyKERdXqLpxFBAsJNf5Qdu/5fVr2F/pK8lmE
 wvtNWGh/usARjfQ4mSdiNt06bLAB2V9dNBRciNZner2Qj0blMSR4HwLJ68tH0DzlGG8fcw5aQ
 i42rdGQHW7yth9Mm7MHg3KS4DcwjpaIVa6soCRDW5vbhJ9OZhbsu4l2d4MZ4G41/2myIxNgpc
 aBAAe3YRn66Wqkr1cd9YJlJnGID//YuVyHGk1PqizuRLl9eErgWlYDcv+AFOlaeS4vX/oyLsE
 yfZTAr6bwITglxX49i4UWmQza1IJMILCudqhqGf6VcCqr/FNCROjfrR5Ew5DYJiZar9UnbWYy
 Ob4owtgfZbHe2jlNFr1rv9xw1AUkRecMK0s9hi50iGWWplQEi5wF8JyMmMvhV8yj/h97aQeiV
 yuy8HqTBrGLm+PEWM0v41Qh4IdM+4oGYx2mNDdOJc5qXfG6mDxSCQu/HAefZi5u/xU4KWAprp
 iay+HMTU0R6BHAgws+zhEtTsL7ih4X8ea8oguk0NonW8Naj5SibsD0ShRsZj/rsN/o0llq9Ld
 WGGTCua37iaXpjj4gQb4JuZW6aC3E2cTVpPvByn3KovCUEo7A7t603tHOXmq0HOKPWrXYFpwc
 YGQDBPsklsUIvslTP4XIdqKpUVbg7ybqtMlyg7PikAhSwLdfONbvfF4OtWDtDcBJwTe2YgKW/
 9YtZxR/u+yPJZX5yoC6Qm+arnkfjh2Czk0UB/6Xa7Tg22+P/zO7IcQpxOr7/OJjtc1Aq7Vli9
 kfmkA+clT13EcaAc/IlubyutJ7cqB8v+STaYVJ1Po1TRHh/4L+Ooywrn/5FYOAH4nL5hnGNfZ
 gQw9bYcxqrxGzG7n1Upyr6HXe+tDR4mSUOcaiWfUSPpIit8Zt6DpIDoPuPXsbduvdFSY6E4XS
 2xu/l41O/kGDAFgmm2IZki8Lx3CLC2sm7NVaNUWAxmlh44fMft18LBnoHEUcM9cCjOgOWbsW1
 2yRptZMqk0F6x7i9UB53Uih2izO1s6fALEOhKNrTMb79KOv8X2mJdF/yphA7ViCoSuZosujKd
 z+OiF5J3gZ0pL/Kytb8PumNXqp9aY0ap4KIH2QsyMm3Y82/mnNF6ZNXcGBro=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Tue, 22 Oct 2019, Elijah Newren wrote:

> [...]
> Yes, t6043 is pretty long code-wise, and still has over five dozen
> tests after ditching the separate "setup" tests -- but all of those
> tests still run in 3.6s on my box. [...]

$ time sh t6043-*.sh --quiet
not ok 74 - 9g-check: Renamed directory that only contained immediate subdirs, immediate subdirs renamed # TODO known breakage
not ok 87 - 10e-check: Does git complain about untracked file that is not really in the way? # TODO known breakage
# still have 2 known breakage(s)
# passed all remaining 117 test(s)
1..119

real    7m22.393s
user    0m52.115s
sys     3m53.212s

And this is not a slow box. So yes, those extra spawned processes? They
accumulate. Spawning processes is what Linux was optimized for. You're
optimizing for Linux.

Ciao,
Dscho

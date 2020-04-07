Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21996C2BA2B
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE6162072A
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ZJUMooPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbgDGOnn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:43:43 -0400
Received: from mout.gmx.net ([212.227.17.21]:54487 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729064AbgDGOnn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 10:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586270612;
        bh=UUqn9PGoZG8pfpZOk8NQvSsHK7921pXiJkJV5Gl7LHM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZJUMooPqbNEtWIvbFA23tQYArURksHM0QiSapEMgpYPvmeKOchQXjGScPhFh++O++
         37jdGJyKBJFm4G8cs2hY9Mwct1gZX7SHW/fZt36ZugziJ9uNmnck9+zaplzGic10aT
         VPjzDMHgADCeNwC7QcMJOLUbgtrrk5HH+Abs1Yn8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.212.75]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MhU9j-1irhYd071v-00eZen; Tue, 07 Apr 2020 16:43:32 +0200
Date:   Tue, 7 Apr 2020 16:43:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Danh Doan <congdanhqx@gmail.com>
cc:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, jrnieder@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 00/15] [RFC] Maintenance jobs and job runner
In-Reply-To: <20200407142647.GB1963@danh.dev>
Message-ID: <nycvar.QRO.7.76.6.2004071634570.46@tvgsbejvaqbjf.bet>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com> <xmqqv9mgxn7u.fsf@gitster.c.googlers.com> <cc9df614-2736-7cdd-006f-59878ee551c8@gmail.com> <20200407005004.GB2568@danh.dev> <8946b9bc-06c2-3269-0fea-c9ba5b60d0ba@gmail.com>
 <20200407142647.GB1963@danh.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:u9Hdy6/af9KFJDLdek1vRV0P9FoFZDADRFNpc5bNhj24acfaTTD
 w8zG9uCDF1O2ly+/QwQJq8/kfxjn5dI7Zcv4Qh48wVs8ykIkbbuaPx+WL4YwsBe5wJicLiX
 MEs8GXh3jHzEQfTco/zPG+VXjJJZFgjYwb1nTEIwOhLPuFPwXDEpQkCeBVUXdHWbYzEGri7
 oGxSArLzy5m0xPv1BsjZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DdLi2OUerEE=:DZ351xXmgk3A9hEgc2Ma42
 FMcdABDn34kzlEHXOrAHjom0TT3KiLilDcmkPQLnazQfnWqgb9uT7Vg97drbvO6KIKkCt93J0
 6h7L8Tn0jXymBhMWVvyqVE3HWxz2L6KzKL2wcMEX1RAntWhpgyf6QG4q9aRoPbdsJGhBSxWws
 xQxEyYutSI+hTuGcRKB1BI/O1aLtu8H7USDd3u4zrTrFf4vshqPLYhFaF7Dw3mPK5+6YH8PXW
 BWTgPuOeYEMN1X5UfO3gzC0OUlCB5z97Nzy7bcOppidDm69yS06mdKEz7YzhtsRMSApezUH8z
 gF6BnN5giZC7gLJBqUfbPd4co3zolfoEtptRYo0/b0eyU4xUrAF29p9mHHl8TAVklzRTPXYAC
 lZt7d0eOE+R4UpDyBNZgsjZmcidcwLbB394s/+dvFm4kRKrbU3L4NWPskt9iAMkldekfvO1UZ
 HkCuhAVMUP3Ya3ecRp7eh93ITjOwbjfCnrU88F+piNT8hJIjkjAnS7s+DRwvIzDRGvSKZMwb3
 uVe1tFbZXx6Ag6fitWernNs+pONpCbjn9H2xECwEy9blW8rWVqfxgBho/riIyWCXoo/6sWUmf
 L9bvFefc9FFdQLMEDWe/OUORtSDcnvN4wdYkaLITlVvaxFmRfqJA8eLdEzHU/dGqKM/pPqbr1
 RaD6o2rnKfyP6LIySsErMTCksfSyFfJWni/LOYSW1sOYGIYKPvqdMsp5twkLEmVUwnTCqgeEi
 9W2o0DTlUk+YT/g2g+X/rpf3D0xucMARYG1wWNl6Nt9WC6YqUBrwHhBi+hZj4b1GOzdUGQF1E
 Jfcrsb/le/JcLYGw/j0yrCv2v6vf9rq7NALu0xwtWdvcUthNrofH/FQYuV8VfXfNdDtc08waI
 pn+AXn81jPFo0R65/6vMt5iBiz8okZcaOtXK/xOo+Yh5MHMsjUKTVwCHYbH3m54xTX9IPeUL6
 5NhZYUGI9tMH5ebbgPeS/wXRB+mzqcOMvRZVmPhxlLjCsn/kyh/taAYfdJLVWZ2kxP6OA0yK3
 3zYMLUayCjqc8pjb9+Uo/TSbSmQGieqkKoeiqo4TeWW5Sx4G88+lO2y/1XkVYdB7t+CdiFBwC
 StilMfpi/+bVqPQUSRPwrBfXKpx2v4SqVvOn90X0+8VHUJpCt0L55qxGSn0v2YvyiMBguvfYD
 up427A1gLz4qnMNs+Nuta6itkEpWBOsoNbo+IQruoFkgPsQfTyTEYLAWJtfr3Uki5L0IPOIzY
 vAotm81iEiiTNgfoLxFNc2Z4Vpg1/5PiogqILkw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Danh,

On Tue, 7 Apr 2020, Danh Doan wrote:

> Adding this set of commands to Git gonna made Git over-complicated,
> IMHO.

Let me counter that by The Tale of the Green Button: while it is not
completely historically accurate, it is a good illustration of focusing on
What Matters Most:

Once upon a time, Xerox built really nice copy machines that were very
good and did a lot of useful things such as making one or more copies of
one or more pages at a certain set of paper sizes with a certain set of
paper criteria (heavy paper, shiny paper, double-sided copies) etc.

And the tale goes: nobody used it. Then a usability expert came in,
interviewed the users and figured out that it was too complicated to use.
The result was the big green button with which you can make one copy using
the standard paper size and the default paper.

This set of commands that you are complaining about is intended to be that
Big Green Button.

Also, maybe we should not talk too loudly about "making" Git
over-complicated. If you care to have a look at
https://git-man-page-generator.lokaltog.net/ and find yourself being very
much reminded of the current Git User Interface's complexity, you might
agree that we should probably try to make _using_ Git less complicated.

Even if it means adding new commands. Such as `git restore` and `git
switch`. And, yes, like `git job-runner` (or whatever we end up calling
it, I do agree with Junio that `git maintenance` is a nice name for its
intended purpose).

Don't just believe me. I invite you to interview the software engineers
developing the Windows Operating System,. Or for that matter, _any_
software engineers working on projects substantially larger than git.git.

Ciao,
Dscho

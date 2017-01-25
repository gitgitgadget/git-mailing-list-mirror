Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DE8B1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 18:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751861AbdAYSnU (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 13:43:20 -0500
Received: from mout.web.de ([212.227.15.14]:64764 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751513AbdAYSnT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 13:43:19 -0500
Received: from [192.168.178.36] ([79.237.55.102]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Mbhiv-1cpMrb20kn-00J3us; Wed, 25
 Jan 2017 19:43:10 +0100
Subject: Re: [DEMO][PATCH v2 6/5] compat: add a qsort_s() implementation based
 on GNU's qsort_r(1)
To:     Jeff King <peff@peff.net>
References: <67ac53cd-3fc0-8bd0-30f4-129281c3090f@web.de>
 <9f8b564d-ec9f-abc9-77f6-aa84c6e78b7a@web.de>
 <xmqq60l5sihz.fsf@gitster.mtv.corp.google.com>
 <4e416167-2a33-0943-5738-79b4da5f2c11@web.de>
 <20170124203949.46lbmiyj26xx4hrk@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f41e5053-ee24-060f-0fb9-b257b3ba35a0@web.de>
Date:   Wed, 25 Jan 2017 19:43:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170124203949.46lbmiyj26xx4hrk@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:kEhAE2YPyxK9hebMMCF0RRSk8WXBje6urj7kDk+nL13VCUXKanO
 F7sZxfJhIUGPACksW8tFyxOVTXRgBXOqZrD4+Gxc21O9RPI4MNaeiull79gIZBzuHghl4D6
 DqE16SqusVFs6DqL8G2QE4O5cJ9LVytak1He/qAU9BXUWlLIUBT7k6+sxGybl9VdbvEwbY9
 1/ineghb+NEbwUFdxq/0g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:czy6S9hXcMk=:PMLVfbaZ5iB38mPvprojmw
 1TZeisS98Bi3KY50aG+pW2N/KcOjwmxvfk33xvWVyzC4XZqApb4RRcjPDHhyaw+5IEph2Clf2
 QH6UjglluUjuNzcK7SKKse3T3mRxBPBFsdRfTcu4IOZRdavnDlEh5tuKF7tv0ivUUBJrX/rIN
 joKe5BwpIIFAUDuT0bsPe6zYx7mbp6FwYRmTeGx64ISpu8cRNr617KHBBTZiCUt2Efc5ZyTU3
 vv2kxvvonE4SyEuU/ubp23unCp0WyY+baKcOXPYCw3zUNy1XOj/4GfwTnZfAToKkWX4QlXZYS
 qYeSnCJrUeD+g4W91cRRQHBzZzkUuluD8RuSCnY1Z3qafAYNyUOlIS+qxSGB6dr0W1FM7yN1n
 Gz3JwT4e/J7Bwje7zGKJikwj6+Fo8UilknEAIVDP21UCePVDZuYpQV5R7vhogHsYaTLmL7aDm
 NzUxu6Pmu8FkOpp3flQm/LOflG3Y9HpjaLcIG1Zxm4xwBXyNYK/DbHZbXrEXd14t7Qqg+Jn5m
 7e4/rbKvE6I9JZ2bu6R7NXS2dUQNLiUW0vqayF7aRzOvlTzAMnkw/+CbU9fUQC/gii00/hhRU
 G9FHUSOEvChsecEQZDpX+XPld85k04iZ5xJOUyFhfLFX3bpnXAyLhWzMaewkRzLUuFsfDw9vS
 g8qHem6LKChdgesPnT0EsITMN0PBuJ1SY8YTz9MYkpWtVvaEeLph/0VLzyLgYP/+miUCS0nfm
 v2/qpdc+fYGSEdScofL3V1PielTO+9K3wETRw9GdSLGvNc3BSVXPfL04bqSLBGp9UGuIB/TPq
 oGW8Xpz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.01.2017 um 21:39 schrieb Jeff King:
> On Tue, Jan 24, 2017 at 07:00:03PM +0100, René Scharfe wrote:
>
>>> I do worry about having to support more implementations in the
>>> future that have different function signature for the comparison
>>> callbacks, which will make things ugly, but this addition alone
>>> doesn't look too bad to me.
>>
>> It is unfair of me to show a 5% speedup and then recommend to not
>> include it. ;-)  That difference won't be measurable in real use cases
>> and the patch is not necessary.  This patch is simple, but the overall
>> complexity (incl. #ifdefs etc.) will be lower without it.
>
> I care less about squeezing out the last few percent performance and
> more that somebody libc qsort_r() might offer some other improvement.
> For instance, it could sort in-place to lower memory use for some cases,
> or do some clever thing that gives more than a few percent in the real
> world (something like TimSort).
>
> I don't know to what degree we should care about that.

That's a good question.  Which workloads spend a significant amount of 
time in qsort/qsort_s?

We could track processor time spent and memory allocated in QSORT_S and 
the whole program and show a warning at the end if one of the two 
exceeded, say, 5% of the total, asking nicely to send it to our mailing 
list.  Would something like this be useful for other functions or 
metrics as well?  Would it be too impolite to use users as telemetry 
transports?

If we find such cases then we'd better fix them for all platforms, e.g. 
by importing timsort, no?

René

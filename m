Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E98B1F406
	for <e@80x24.org>; Tue, 15 May 2018 19:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752030AbeEOTgp (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 15:36:45 -0400
Received: from mout.web.de ([217.72.192.78]:38529 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751884AbeEOTgo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 15:36:44 -0400
Received: from [192.168.178.36] ([79.237.255.222]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LpO4v-1eg14S3sFp-00fE9v; Tue, 15
 May 2018 21:36:30 +0200
Subject: Re: [PATCH] fast-export: avoid NULL pointer arithmetic
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <d50a4d5d-3b99-453e-1b52-4e733453fb78@web.de>
 <99d443cd-e817-7db5-f758-bf4cf47f7c06@web.de>
 <xmqqo9hniy1v.fsf@gitster-ct.c.googlers.com>
 <654fac2a-8dca-7bee-2bab-a3986aa7e52d@web.de>
 <xmqqbmdnhr8b.fsf@gitster-ct.c.googlers.com>
 <xmqq7eoahk49.fsf@gitster-ct.c.googlers.com>
 <CACsJy8AN4nssu1+x0x9Kmz1BB1aXO7_UBFCjpyULMeC5K-Fzvw@mail.gmail.com>
 <20180511085634.GC22086@sigill.intra.peff.net>
 <CACsJy8CnJYsgDe11tK4JzH2sDRuLwgoUz=HCso5qOhEfyZNH5Q@mail.gmail.com>
 <20180511133419.GA2170@duynguyen.home>
 <20180511174237.GA19670@sigill.intra.peff.net>
 <80397e16-8667-e0cd-4049-aad453d35e6f@web.de>
 <xmqqwow7c90d.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <bcb24c9e-e10e-7f1b-6cbd-9cdd2508e795@web.de>
Date:   Tue, 15 May 2018 21:36:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqwow7c90d.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:b2QxsBDsFd41mHU8DCKFjIFj0slACOCxAkLdd6v5Bgbi555ogb7
 O110FNt1XZUksYenLLx/+xEZKZJWESBxWdSbqMTqJexPOk/YR7QZRywXifDEVJOCnqaHLxH
 1U0Axo/pHoMNhgBPVTObJb1kPgFdIZxWSpAUM5mH55PHjJHlK7zqstzhftIUn5PX3Em8JSG
 Tl9HwC3uuol3Fc4K3oP8w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zeOcJPKsZrk=:ssT8yQdg2QT5KppcqRVTQ5
 DB8xJbJt1EVO7KmxOdHcgmp0ZVz21iJXsYsE5nqZjDPVt2NN62sIxJJQZp24dJ6bUwmtrQEMu
 lleLdD3YonDsEuV+SQNuQsFe16BOQ4tnUD7JurBYfxiAEmq3phV9zXiU+6TYCGzdlqeZcDqvT
 gc6jFtknH3jIyXj2ykbBuSbx6wlnH2CiIcf9fqHllHR0rG2PqLQyjf7QZpl/G8hFwyv4X0ca5
 WAjDvPxG8u7G73fo392nI9c6grFGgsYHrCXHfg/YPGZB4Le8gewrJ2lLIzwjKq1/19e3Ibnkl
 4metAWW3DCMF8CCEV9+IUbB37Hm7ik6UNR8APHhk4Ve0r+N1DO6/xy77vyRcvXQR/k9N/ceUM
 yPcTz9LUaD4tcWSGG/0gKliN4aj/eLWz+emgm74L1kK6jA/Jdz0ilHze7vf4Tzw8ofcakE2f+
 rIprlgH2HFY3WMbcY5AT5DAZzXxmzdVWQn9YCObsZyPRvfOMU/gLWdyqzF0nEMMrTP5ArjMf0
 qMfXeV03wzP7e2zlzODd/lETK9RhVdWyWiHnA+0SswGkdgcCMujlSAAIYEAVUrZ8t2SoFV5Rg
 faM3Gjd2YUppRDzmnuS4CvaVCsZkLTdRbScrk4Z5dNtsOBgy3q05kh6ac7FkP0yduChu5Cytd
 CDn1wW4uUYnXW5vjQFyikA0eT/XJ71+30LT7OxHw1CWvOcw+ZO0UphHuvVrT5WVRA9AMwwp76
 fMhCSOY2NaJHYanUZbG/ZFq3ONRbrWlSmuqLxG+F9+c9aybEd510y4OF2gIYIFQJ5x7RG/Vav
 PbC30w/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.05.2018 um 03:37 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
> 
>> Storing integer values in pointers is a trick that seems to have worked
>> so far for fast-export.  A portable way to avoid that trick without
>> requiring more memory would be to use a union.
>>
>> Or we could roll our own custom hash map, as I mused in an earlier post.
>> That would duplicate quite a bit of code; are there reusable pieces
>> hidden within that could be extracted into common functions?
> 
> Hmm, this together with your follow-up does not look too bad, but it
> does introduce quite a lot of code that could be refactored, so I am
> not sure if I really like it or not.

Putting keys and values into separate arrays probably causes stores and
lookups to hit (at least) two cache lines instead of just one.  Not sure
how much of an impact that has on the overall performance (probably not
much), but we'd need at least a perf test for that.

And we have enough hash map implementations already.

Casting should be good enough for now, to avoid the compiler warning.

René

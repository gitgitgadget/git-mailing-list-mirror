Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDF741F403
	for <e@80x24.org>; Sun, 10 Jun 2018 11:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753868AbeFJLDX (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Jun 2018 07:03:23 -0400
Received: from mout.web.de ([217.72.192.78]:39001 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751815AbeFJLDW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jun 2018 07:03:22 -0400
Received: from [192.168.178.36] ([79.237.242.156]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MejmG-1fd3vP1nlw-00OEuH; Sun, 10
 Jun 2018 13:03:15 +0200
Subject: Re: [PATCH 24/30] merge-recursive: Add computation of collisions due
 to dir rename & merging
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <20171110190550.27059-1-newren@gmail.com>
 <20171110190550.27059-25-newren@gmail.com>
 <7d1237c7-5a83-d766-7d93-5f0d59166067@web.de>
Message-ID: <e702fb82-2dd2-5060-3f34-0f60882e05c2@web.de>
Date:   Sun, 10 Jun 2018 13:03:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <7d1237c7-5a83-d766-7d93-5f0d59166067@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JWtoayV3dAUrY3V9t6acFihm1ra3H0OtbvexB05hTj4AVFen6b4
 PiiEaRllQMvzJgM2QNzqP9OnYakLk0IeoZF9z0pOe3U/3Y4jGWsQmEZZV6IJqCo1JUPBhtO
 2oUaKKRG8CX6LBGdTSPNAdWt+bbEeLjoSElqABB4VJc1KP+i+68C7aYRYJ/UkhctYjkEcdg
 2pXQgbjpYijBLnQdU4uVw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:L7Bq5zy23qY=:oECGCkEgkyr55izQh9SAYr
 FJPqVCk212nIPKoFq8fJs0DCdQ0RHvoaR1L96K5SStfyc1hzBxOzoBtAnxJaA5VET5M2WlUib
 Zsz2urUFPIPNlBOh7kofm8Fw0J8+HWgDx05f7KyFNfYM7SePPzRHU8Z7o1pGCU3I5w5YuVxRc
 f2quGkfMFM9iY+YN+mG5XXxJAeQGQARZAWjpV+xUpAb5CoCpSqrIcA/LIx2nRiPVmnjm24o48
 4euxrxzcZOeLC5UCV+BQXcD95qslnVDGGZXGIDDSt89Jt8WQC+5Yz/r3Lb+xqOqio1KubteKd
 tHmewnl95Z2wpWjenOF3k6b+cZRhSwz7Rh2vIUQB1rxcj6EiG6XYydxZrGECurk6pnUuEkROt
 RSx4GhgCWT+nZs2lHy+7Kf4MvhkWrSMPlVjHKwYGtfH0UQ3RbkrSLDf4z/ZOKheovUe/9/o/8
 vtNFErWmexd5Y/Mcun+h7yjt1ClpU7e/lui94PdHSTXVRV52q1RF44ocKJMAZmTe15X58ahxr
 iNFFr4298vsHL8nkG+aB25n00IR0VratWZA6yoviDPe9TiIzhH/lEzH1JvcZcZU3Oa1SuTs6c
 rf6CtmcSMb1DoHrGFbtGHp28orb62o4v1vxOtSooW795dJyrIz11hWSW1GBu8+mKZsuM6EGbe
 CaVq9gWaiyCgtQeSAtXK03dttAbpvEYDGGHnaB0bJMBYwUbsnAUjfgPtHljwdjk88jYrunaT7
 Htaj4N7yXA0LvidGi/XFDMmtRHL06byOc+JiNCDCWtQDj0XhKkxD1R7Ts4emUi3vEqXAsc8cu
 yJOKcVm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.06.2018 um 12:56 schrieb René Scharfe:
> Am 10.11.2017 um 20:05 schrieb Elijah Newren:
>> +static struct dir_rename_entry *check_dir_renamed(const char *path,
>> +						  struct hashmap *dir_renames) {
>> +	char temp[PATH_MAX];
>> +	char *end;
>> +	struct dir_rename_entry *entry;
>> +
>> +	strcpy(temp, path);
>> +	while ((end = strrchr(temp, '/'))) {
>> +		*end = '\0';
>> +		entry = dir_rename_find_entry(dir_renames, temp);
>> +		if (entry)
>> +			return entry;
>> +	}
>> +	return NULL;
>> +}
> 
> The value of PATH_MAX is platform-dependent, so it's easy to exceed when
> doing cross-platform development.  It's also not a hard limit on most
> operating systems, not even on Windows.  Further reading:
> 
>     https://insanecoding.blogspot.com/2007/11/pathmax-simply-isnt.html
> 
> So using a fixed buffer is not a good idea, and writing to it without
> checking is dangerous.  Here's a fix:

Argh, I meant to reply to v10 of that patch, i.e. this:

   https://public-inbox.org/git/20180419175823.7946-21-newren@gmail.com/

The cited code wasn't changed and is in current master, though, so both
that part and my patch are still relevant.

René

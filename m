Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61B0220323
	for <e@80x24.org>; Wed, 22 Mar 2017 19:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935347AbdCVTWR (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 15:22:17 -0400
Received: from siwi.pair.com ([209.68.5.199]:55793 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935003AbdCVTWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 15:22:16 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 5E8C784614;
        Wed, 22 Mar 2017 15:22:14 -0400 (EDT)
Subject: Re: [PATCH 0/6] thread lazy_init_name_hash
To:     Stefan Beller <sbeller@google.com>
References: <1490202865-31325-1-git-send-email-git@jeffhostetler.com>
 <CAGZ79kYh0eP-dzpX58SrSRJGEr9iyOb0Q3vizsvxE81kzddwxQ@mail.gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <90a7b4fa-67bf-6501-1da6-97883d7cde4a@jeffhostetler.com>
Date:   Wed, 22 Mar 2017 15:22:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kYh0eP-dzpX58SrSRJGEr9iyOb0Q3vizsvxE81kzddwxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/22/2017 2:02 PM, Stefan Beller wrote:
> On Wed, Mar 22, 2017 at 10:14 AM,  <git@jeffhostetler.com> wrote:
>>
>> During our testing on the Windows source tree (3.1M
>> files, 500K folders, 450MB index), this change reduced
>> the runtime of lazy_init_name_hash() from 1.4 to 0.27
>> seconds.
>
> This sounds promising. :)
> A fast skim over the code makes me like the code.

I forgot to mention that this was on an 8 (logical) core machine.

>
>>  hashmap.c                           |  29 ++-
>>  hashmap.h                           |  25 ++
>
> Could you add some documentation to
> Documentation/technical/api-hashmap.txt ?

Will do. Thanks.

> (Bonus points for migrating the documentation inline,
> c.f. discussion surrounding [1])
>
> [1] https://public-inbox.org/git/20141212212800.GA27451@peff.net/

I'd like to save this for a separate effort.

>
>>  name-hash.c                         | 490 +++++++++++++++++++++++++++++++++++-
>
> AFAICT the new threading is all implicit in name-hash and we do not expose
> its functionality or tuning knobs outside the testing helper, such that we do
> not need API documentation here, but only enough code comments to
> understand the code for maintainability?

Yes, my goal was to just make it transparent to all callers.
Especially since the main lazy_init_name_hash() function is static
and not visible anyway.

Jeff


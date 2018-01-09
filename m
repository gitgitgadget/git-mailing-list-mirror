Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D995E1F404
	for <e@80x24.org>; Tue,  9 Jan 2018 07:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756583AbeAIHdR (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 02:33:17 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:14020 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753757AbeAIHdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 02:33:16 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3zG3lZ34xNz5tlD;
        Tue,  9 Jan 2018 08:33:14 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id B06C441FB;
        Tue,  9 Jan 2018 08:33:13 +0100 (CET)
Subject: Re: [PATCH] oidset: don't return value from oidset_init
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180107230404.23289-1-t.gummerer@gmail.com>
 <xmqqincc6if3.fsf@gitster.mtv.corp.google.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <63acb4e5-4ebe-0fc3-a9ba-8141cceeee0c@kdbg.org>
Date:   Tue, 9 Jan 2018 08:33:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <xmqqincc6if3.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.01.2018 um 00:26 schrieb Junio C Hamano:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
>> c3a9ad3117 ("oidset: add iterator methods to oidset", 2017-11-21)
>> introduced a 'oidset_init()' function in oidset.h, which has void as
>> return type, but returns an expression.
>> ...
>> diff --git a/oidset.h b/oidset.h
>> index 783abceccd..40ec5f87fe 100644
>> --- a/oidset.h
>> +++ b/oidset.h
>> @@ -27,7 +27,7 @@ struct oidset {
>>   
>>   static inline void oidset_init(struct oidset *set, size_t initial_size)
>>   {
>> -	return oidmap_init(&set->map, initial_size);
>> +	oidmap_init(&set->map, initial_size);
>>   }
> 
> Makes sense.  Perhaps "inline" hids this from error-checking
> compilers, I wonder?

outmap_init returns void itself. It is a modern language feature, I 
guess, that this void "value" can be forwarded in a return statement.

-- Hannes

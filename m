Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EE952013B
	for <e@80x24.org>; Mon, 13 Feb 2017 06:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751727AbdBMGlF (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 01:41:05 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:42629 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751523AbdBMGlE (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Feb 2017 01:41:04 -0500
X-AuditID: 12074412-4bbff70000000b04-b2-58a154fc1b25
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id CD.35.02820.CF451A85; Mon, 13 Feb 2017 01:41:03 -0500 (EST)
Received: from [192.168.69.190] (p579064F7.dip0.t-ipconnect.de [87.144.100.247])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v1D6evpW014920
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 13 Feb 2017 01:40:58 -0500
Subject: Re: [PATCH v2 9/9] read_loose_refs(): read refs using
 resolve_ref_recursively()
To:     Junio C Hamano <gitster@pobox.com>
References: <cover.1486724698.git.mhagger@alum.mit.edu>
 <d8e906d969700acbca8dc717673d0a9cdc910f62.1486724698.git.mhagger@alum.mit.edu>
 <xmqqbmu9lul6.fsf@gitster.mtv.corp.google.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <ff0b0df6-9aed-9417-d9d4-1234d53f05c3@alum.mit.edu>
Date:   Mon, 13 Feb 2017 07:40:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqbmu9lul6.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqPs/ZGGEwdr9MhZdV7qZLBp6rzBb
        9C/vYrNY8vA1s0X3lLeMFj9aepgtNm9uZ3Fg99g56y67x4ePcR4LNpV6dLUfYfN41ruH0ePi
        JWWPz5vkAtijuGxSUnMyy1KL9O0SuDLun5vAVvBEuGLD/zssDYzX+bsYOTkkBEwktp5+z9TF
        yMUhJLCDSeLx13vsEM4FJokdU4+xgVQJC0RJvLyziRHEFhFQk5jYdogFomgno8TTt/vA2pkF
        pjFJHG9sYwKpYhPQlVjU0wxm8wrYS3S+2w00iYODRUBVYnMjF0hYVCBEYs7CB4wQJYISJ2c+
        YQGxOQWsJVruHwRbzCygJ7Hj+i9WCFteYvvbOcwTGPlnIWmZhaRsFpKyBYzMqxjlEnNKc3Vz
        EzNzilOTdYuTE/PyUot0zfRyM0v0UlNKNzFCAl5oB+P6k3KHGAU4GJV4eBvaFkQIsSaWFVfm
        HmKU5GBSEuWttl8YIcSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEd3IQUI43JbGyKrUoHyYlzcGi
        JM77c7G6n5BAemJJanZqakFqEUxWhoNDSYJ3KjCyhQSLUtNTK9Iyc0oQ0kwcnCDDeYCGu4LU
        8BYXJOYWZ6ZD5E8xKkqJ80aDJARAEhmleXC9sIT0ilEc6BVh3r5goCoeYDKD634FNJgJZPCD
        uSCDSxIRUlINjFZ/7Q4v8zDKLFOy7ddLf6PK+E2qdN8Er+JOpvIFIvJmZT+elk0MfbEtj+H5
        RfE1C6attuYxsrzqxaRsKi/QW7HryNtaI6n1G2YHiU2f+04ic+2dTX+jYxJ0t7NVPLF5tqEn
        5ezStzJ/JHd/fhgd972uIWXHpv09QSsnuCsdUQibacezYWvLdCWW4oxEQy3mouJEAGV+RTgj
        AwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/10/2017 08:22 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> [...]
> 
> OK, but one thing puzzles me...
> 
>> @@ -1390,27 +1390,6 @@ static struct ref_store *main_ref_store;
>>  static struct hashmap submodule_ref_stores;
>>  
>>  /*
>> - * Return the ref_store instance for the specified submodule (or the
>> - * main repository if submodule is NULL). If that ref_store hasn't
>> - * been initialized yet, return NULL.
>> - */
>> -static struct ref_store *lookup_ref_store(const char *submodule)
>> -{
>> -	struct submodule_hash_entry *entry;
>> -
>> -	if (!submodule)
>> -		return main_ref_store;
>> -
>> -	if (!submodule_ref_stores.tablesize)
>> -		/* It's initialized on demand in register_ref_store(). */
>> -		return NULL;
>> -
>> -	entry = hashmap_get_from_hash(&submodule_ref_stores,
>> -				      strhash(submodule), submodule);
>> -	return entry ? entry->refs : NULL;
>> -}
>> -
>> -/*
>>   * Register the specified ref_store to be the one that should be used
>>   * for submodule (or the main repository if submodule is NULL). It is
>>   * a fatal error to call this function twice for the same submodule.
>> @@ -1451,6 +1430,27 @@ static struct ref_store *ref_store_init(const char *submodule)
>>  	return refs;
>>  }
>>  
>> +/*
>> + * Return the ref_store instance for the specified submodule (or the
>> + * main repository if submodule is NULL). If that ref_store hasn't
>> + * been initialized yet, return NULL.
>> + */
>> +static struct ref_store *lookup_ref_store(const char *submodule)
>> +{
>> +	struct submodule_hash_entry *entry;
>> +
>> +	if (!submodule)
>> +		return main_ref_store;
>> +
>> +	if (!submodule_ref_stores.tablesize)
>> +		/* It's initialized on demand in register_ref_store(). */
>> +		return NULL;
>> +
>> +	entry = hashmap_get_from_hash(&submodule_ref_stores,
>> +				      strhash(submodule), submodule);
>> +	return entry ? entry->refs : NULL;
>> +}
>> +
> 
> I somehow thought that we had an early "reorder the code" step to
> avoid hunks like these?  Am I missing some subtle changes made while
> moving the function down?

You are quite right; thanks for noticing. I forgot to un-move this
function when re-rolling. These two hunks can be discarded (the function
text is unchanged).

I pushed the fixed commit to branch `submodule-hash` in my fork [1]. If
you'd like me to send it to the mailing list again, please let me know.

Michael

[1] https://github.com/mhagger/git


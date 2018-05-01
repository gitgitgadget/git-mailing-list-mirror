Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E6C7215F4
	for <e@80x24.org>; Tue,  1 May 2018 13:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754613AbeEANo5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 09:44:57 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:38558 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753800AbeEANo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 09:44:56 -0400
Received: by mail-qk0-f180.google.com with SMTP id b39so8885318qkb.5
        for <git@vger.kernel.org>; Tue, 01 May 2018 06:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=K8PQksEByXCqYys9RSDxAK3h+AtH30P1ZLUj9odAoXw=;
        b=qx/c/2LuuFpUgsnQ/zoQyt7Wkscrh7v80SFiN8gPM4W7OMaQx35w+2amqTelre+i4Q
         pCx0GKl9PTsLllpWG3YbO3TIh6NaD72AUVXfd8ciUz0NmRKXBFEU2+3dsaylb0dMxhrt
         Gb/auYKoAQNj4uAtB8nCGny0+sMX68zPOsvzCOGO3XzahiBYH+p9O+zGi7X0cRNXVns9
         kpPTPc7FKZvVys5MCzJLFjIWrRWwB7QPNw8FIiIcuRGpng3ueQy06kqK7l2wFZ5Dlr/P
         TzFHrtNg0YghyRwfyf0L605L4TVwxsEvoJJQIIG1OJtcUheNFn9yI38tLUvLTAwske5W
         CdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=K8PQksEByXCqYys9RSDxAK3h+AtH30P1ZLUj9odAoXw=;
        b=TX6uDfurRB/1wdpgDZRSoopMAdd1Fib5PNvvTwDWY+7PJXtc9VL05+ZNSkILAqIoGC
         bX3jVuyBS5f7UemvZ5C+Ll6wpTfA7nk7NaC7u17FhbJseGmP4Oen4YZOPTa/BT8vok7D
         k583FOdR+9wp5QpfH2ZYjFy/fmXWFV/8nj57IKt/SqlUB5Hh0i1GwTk9yzKR6mYwVu8t
         1hUcW97LwFJCfKcYpKY2B9ZKxryzzPl63u2bXiCPyUHGHSEuVuzS443WwnrnFrQUzcht
         0H89ezGvTRQ8d+ijUw23uCSla7rggCZxMd4qTsZt6raOmvVltgJSFP3kalHtn4+4VxYO
         OYnQ==
X-Gm-Message-State: ALQs6tCvVgqXkqTtJXY90ULPHbRHLNxWuXuxOR9+bqNkVxoqLFGV6j8U
        FpIij1bxIL44eTuQM60PFfDB12Ao
X-Google-Smtp-Source: AB8JxZrf3QGxfpKxcyYhkYF/ubFFaiFQdfps+qMmBoNECo1KaDvy/k0IgmgSE1FRxqTOq4pBoFYRfw==
X-Received: by 10.55.26.21 with SMTP id a21mr12868215qka.381.1525182295351;
        Tue, 01 May 2018 06:44:55 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id m24sm6757879qkk.67.2018.05.01.06.44.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 06:44:53 -0700 (PDT)
Subject: Re: [PATCH v2 06/11] get_short_oid: sort ambiguous objects by type,
 then SHA-1
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <20180501120651.15886-1-avarab@gmail.com>
 <20180501130318.58251-1-dstolee@microsoft.com>
 <876047ze9v.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <40868abd-6d2f-3f05-e099-6f0d06cc0683@gmail.com>
Date:   Tue, 1 May 2018 09:44:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <876047ze9v.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/1/2018 9:39 AM, Ævar Arnfjörð Bjarmason wrote:
> On Tue, May 01 2018, Derrick Stolee wrote:
>
>> From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>>
>> Here is what I mean by sorting during for_each_abbrev(). This seems to work for
>> me, so I don't know what the issue is with this one-pass approach.
>> [...]
>> +static int sort_ambiguous(const void *a, const void *b)
>> +{
>> +	int a_type = oid_object_info(a, NULL);
>> +	int b_type = oid_object_info(b, NULL);
>> +	int a_type_sort;
>> +	int b_type_sort;
>> +
>> +	/*
>> +	 * Sorts by hash within the same object type, just as
>> +	 * oid_array_for_each_unique() would do.
>> +	 */
>> +	if (a_type == b_type)
>> +		return oidcmp(a, b);
>> +
>> +	/*
>> +	 * Between object types show tags, then commits, and finally
>> +	 * trees and blobs.
>> +	 *
>> +	 * The object_type enum is commit, tree, blob, tag, but we
>> +	 * want tag, commit, tree blob. Cleverly (perhaps too
>> +	 * cleverly) do that with modulus, since the enum assigns 1 to
>> +	 * commit, so tag becomes 0.
>> +	 */
>> +	a_type_sort = a_type % 4;
>> +	b_type_sort = b_type % 4;
>> +	return a_type_sort > b_type_sort ? 1 : -1;
>> +}
>> +
>>   static int get_short_oid(const char *name, int len, struct object_id *oid,
>>   			  unsigned flags)
>>   {
>> @@ -451,6 +479,9 @@ int for_each_abbrev(const char *prefix, each_abbrev_fn fn, void *cb_data)
>>   	find_short_object_filename(&ds);
>>   	find_short_packed_object(&ds);
>>
>> +	QSORT(collect.oid, collect.nr, sort_ambiguous);
>> +	collect.sorted = 1;
>> +
> Yes this works. You're right. I wasn't trying to intentionally omit
> stuff in my recent 878t93zh60.fsf@evledraar.gmail.com, I'd just written
> this code some days ago and forgotten why I did what I was doing (and
> this is hard to test for), but it's all coming back to me now.
>
> The actual requirement for oid_array_for_each_unique() working properly
> is that you've got to feed it in hash order,

To work properly, duplicate entries must be consecutive. Since duplicate 
entries have the same type, our sort satisfies this condition.

> but my new sort_ambiguous()
> still does that (barring any SHA-1 collisions, at which point we have
> bigger problems), so two passes aren't needed. So yes, this apporoach
> works and is one-pass.
>
> But that's just an implementation detail of the current sort method,
> when I wrote this I was initially playing with other sort orders,
> e.g. sorting SHAs regardless of type by the mtime of the file I found
> them in. With this approach I'd start printing duplicates if I changed
> the internals of sort_ambiguous() like that.

That makes sense.

> But I think it's extremely implausible that we'll start sorting things
> like that, so I'll just take this method of doing it and add some
> comment saying we must hashcmp() the entries in our own sort function
> for the de-duplication to work, I don't see us ever changing that.

Sounds good.

Thanks,
-Stolee

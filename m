Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A362F20357
	for <e@80x24.org>; Mon, 17 Jul 2017 20:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751348AbdGQUJV (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 16:09:21 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35687 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbdGQUJU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 16:09:20 -0400
Received: by mail-qt0-f195.google.com with SMTP id h15so49278qte.2
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 13:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U4kc9/04QcSVEybKzc3FPvSt6G/+de/MRj50Cne1G7Y=;
        b=EzfDyu4zq7LmncVoYKdUAHmH/XaHQ7vLmlLuCmM4fbW2Ke9w6huikteIi4U/NNXUf6
         bzSEW7XHnWQjVFhWauyNbqd0zL/vGUaCIupkZkGzy5Or5XfEJ15Qn6OQc1QkKc41DfaF
         +LGNHi72LQXshNr43nvrGl3ervrtfdieNM6ZPDZYUllqr+AMAl8eAH/6S1FLUho/cm6L
         ZFkrzvylZMiO5oIfN8I6vDALapQaprjcdJOxfCFCHbX6SkBN7qtjNCx9qaQonQ/RILqM
         /HVLjLZx1buF5lUk9Qaopvaws5eFXQTHfUS63eGIV9Q7S4LUqZ+wMNFPWTJA0B2ltvX2
         6Slw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U4kc9/04QcSVEybKzc3FPvSt6G/+de/MRj50Cne1G7Y=;
        b=tu5dAzEEh1VG4ttTHd9ay+h05U66799VVhM6ZjyQrT0cDVvXmX7NQIu+YRjndcT9+S
         ZskRo+GLGP3z2tWLKaLjCMpv/a/I+F6WFn6XCDNtfEGSX/4wFqvguZWMr7ycon2ckslN
         nGgH4eWQd1P8yEfUbvHZ87GdquuX7bzmOZqV+osxesI3sUAuWou0AP8sqwffY8wU7ylg
         WSVG0ZvEXnLNkRpTnvWGxGwQ7HaDAFBqZA1jMj5ElnT2kh/CRq0RH+7d2Ze84AvfAw15
         Gz2glfyX2XVmVNMrWb3wzYqMiOAQf6p+5S2RDSRTM0HhZgpP7amdN7Fo9phf1pmiW29a
         fo/Q==
X-Gm-Message-State: AIVw1137A+waTRgGS4wagF+T/WVM0+JmD5ikMSbbDelYeWtleaC6+NoX
        awuTawVIOXET8g==
X-Received: by 10.237.45.194 with SMTP id i60mr4415605qtd.121.1500322159805;
        Mon, 17 Jul 2017 13:09:19 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id 59sm111367qtc.35.2017.07.17.13.09.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jul 2017 13:09:18 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] sha1_file: Add support for downloading blobs on
 demand
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, benpeart@microsoft.com,
        pclouds@gmail.com, christian.couder@gmail.com,
        git@jeffhostetler.com
References: <20170714132651.170708-1-benpeart@microsoft.com>
 <20170714132651.170708-2-benpeart@microsoft.com>
 <20170717110602.6fac89ea@twelve2.svl.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <d3f1f884-7b8a-885f-47cb-eca2b8ef0ecf@gmail.com>
Date:   Mon, 17 Jul 2017 16:09:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170717110602.6fac89ea@twelve2.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/17/2017 2:06 PM, Jonathan Tan wrote:
> About the difference between this patch and my patch set [1], besides
> the fact that this patch does not spawn separate processes for each
> missing object, which does seem like an improvement to me, this patch
> (i) does not use a list of promised objects (but instead communicates
> with the hook for each missing object), and (ii) provides backwards
> compatibility with other Git code (that does not know about promised
> objects) in a different way.
> 
> The costs and benefits of (i) are being discussed here [2]. As for (ii),
> I still think that my approach is better - I have commented more about
> this below.
> 
> Maybe the best approach is a combination of both our approaches.

Yes, in the context of the promised objects model patch series, the 
value of this patch series is primarily as a sample of how to use the 
sub-process mechanism to create a versioned interface for retrieving 
objects.

> 
> [1] https://public-inbox.org/git/34efd9e9936fdab331655f5a33a098a72dc134f4.1499800530.git.jonathantanmy@google.com/
> 
> [2] https://public-inbox.org/git/20170713123951.5cab1adc@twelve2.svl.corp.google.com/
> 
> On Fri, 14 Jul 2017 09:26:51 -0400
> Ben Peart <peartben@gmail.com> wrote:
> 
>> +------------------------
>> +packet: git> command=get
>> +packet: git> sha1=0a214a649e1b3d5011e14a3dc227753f2bd2be05
>> +packet: git> 0000
>> +------------------------
> 
> It would be useful to have this command support more than one SHA-1, so
> that hooks that know how to batch can do so.
> 

I agree.  Since nothing was using that capability yet, I decided to keep 
it simple and not add support for a feature that wasn't being used. The 
reason the interface is versioned is so that if/when something does need 
that capability, it can be added.

>> +static int subprocess_map_initialized;
>> +static struct hashmap subprocess_map;
> 
> The documentation of "tablesize" in "struct hashmap" states that it can
> be used to check if the hashmap is initialized, so
> subprocess_map_initialized is probably unnecessary.
> 

Nice.  That will make things a little simpler.

>>   static int check_and_freshen(const unsigned char *sha1, int freshen)
>>   {
>> -	return check_and_freshen_local(sha1, freshen) ||
>> -	       check_and_freshen_nonlocal(sha1, freshen);
>> +	int ret;
>> +	int already_retried = 0;
>> +
>> +retry:
>> +	ret = check_and_freshen_local(sha1, freshen) ||
>> +		check_and_freshen_nonlocal(sha1, freshen);
>> +	if (!ret && core_virtualize_objects && !already_retried) {
>> +		already_retried = 1;
>> +		if (!read_object_process(sha1))
>> +			goto retry;
>> +	}
>> +
>> +	return ret;
>>   }
> 
> Is this change meant to ensure that Git code that operates on loose
> objects directly (bypassing storage-agnostic functions such as
> sha1_object_info_extended() and has_sha1_file()) still work? If yes,
> this patch appears incomplete (for example, read_loose_object() needs to
> be changed too), and this seems like a difficult task - in my patch set
> [1], I ended up deciding to create a separate type of storage and
> instead looked at the code that operates on *packed* objects directly
> (because there were fewer such methods) to ensure that they would work
> correctly in the presence of a separate type of storage.
> 

Yes, with this set of patches, we've been running successfully on 
completely sparse clones (no commits, trees, or blobs) for several 
months.  read_loose_object() is only called by fsck when it is 
enumerating existing loose objects so does not need to be updated.

We have a few thousand developers making ~100K commits per week so in 
our particular usage, I'm fairly confident it works correctly.  That 
said, it is possible there is some code path I've missed. :)

> [1] https://public-inbox.org/git/34efd9e9936fdab331655f5a33a098a72dc134f4.1499800530.git.jonathantanmy@google.com/
> 

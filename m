Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095AFC43334
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 14:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245182AbiFNOfO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 10:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbiFNOfN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 10:35:13 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DDB36E14
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 07:35:13 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id p69so9617790iod.0
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 07:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BzXbzYopGct1c3tfXpXkHPMnW3GfxOYUNO/wpDkGbao=;
        b=fQxD0XtjEhKW3dFQ/bjsQpHtw8KZjhS0Or+prmR3xqiny8h0l6hTdnyckUDzaDNJHn
         CF3062/PJIUxcaZfANNVNFw+o79852lGXf/tovY3mysD3/Vxr/2yJr31EK72ktr4WdHu
         XzUu3jc0Otxkp/0hyMvIEJcMHLxfIRBkHJGPTTX9pRdKD4V4mKU68AOeQwQnWqOdyHlW
         mkhfmjnnOptKpyfrpPh2pMkKTXUsGQoJnuYEci1UI2Qeu2h4CzuLbFfo2k+sW3RsBiyH
         h07Nlz5OHctnVI8SsdhEJ54qgpRA05/POlMPhZmC5T/yWfLHN0bIVZZumfg1zfZ2wwOI
         Xp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BzXbzYopGct1c3tfXpXkHPMnW3GfxOYUNO/wpDkGbao=;
        b=Wnc/hzDp1yV+KJ/Shiv7oTTN3uhwwqWjchA0FV9w8TOEN6VtGUJMX8/FIHWFjsUxwV
         PeaWClKONfoIDHab1s7Ok0JVBwYJDDE6HeH1jD2L3xDJejvMKCKGFnn+05TRcNnuX54A
         9lcJs7i9NKx5l79Sy8CEP9HmrnqXq+E7R/9hO77cbBm2ZcxYyl5DusKQ4rx/XzBTX+H+
         SRZ+oCxnq3PqicHEKJm3npKHpJbLPr8fNU9AymVtU45AycjiDGJ34UJOZEuQJh31X8zP
         qcZ0P/eukvXcs0dgHdRd9/bPnOj95b1aYypplvwvJOsB5kkAlKRlU0nlQbID/FGvuiVi
         b6XA==
X-Gm-Message-State: AOAM533UcW+C+Fs/hagRxpz2kX9RmfMavXbA4Ol7NF6PIcrvzsvUPskg
        1UvY6KsKcpdB1VgUqbvDbLEoSTkrVPJm
X-Google-Smtp-Source: ABdhPJzQHY+AyBVx7IBsjrB8VKltVxe0jkPU4CaXSUYF7g4ha60SC9C9K8UFGvmY/nLebJc2fEAmnw==
X-Received: by 2002:a02:ceba:0:b0:331:bd1c:a97f with SMTP id z26-20020a02ceba000000b00331bd1ca97fmr3001291jaq.216.1655217312263;
        Tue, 14 Jun 2022 07:35:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:508:3b97:7c0b:efc0? ([2600:1700:e72:80a0:508:3b97:7c0b:efc0])
        by smtp.gmail.com with ESMTPSA id b14-20020a92c84e000000b002d1df239846sm5462930ilq.79.2022.06.14.07.35.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 07:35:11 -0700 (PDT)
Message-ID: <31f406b1-b4e8-5da2-40af-5747938de634@github.com>
Date:   Tue, 14 Jun 2022 10:35:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] revision: mark blobs needed for resolve-undo as reachable
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqfskdieqz.fsf@gitster.g>
 <7cd41846-e6ef-7a24-0426-6031a529360f@github.com>
 <220614.86czfcytlz.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220614.86czfcytlz.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/13/2022 8:24 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Jun 13 2022, Derrick Stolee wrote:
> 
>> On 6/9/2022 7:44 PM, Junio C Hamano wrote:
>>
>>> +	struct string_list *resolve_undo = istate->resolve_undo;
>>> +
>>> +	if (!resolve_undo)
>>> +		return 0;
>>> +
>>> +	for_each_string_list_item(item, resolve_undo) {
>>
>> I see this is necessary since for_each_string_list_item() does
>> not handle NULL lists. After attempting to allow it to handle
>> NULL lists, I see that the compiler complains about the cases
>> where it would _never_ be NULL, so that change appears to be
>> impossible.
>>  
>> The patch looks good. I liked the comments for the three phases
>> of the test.
> 
> I think it's probably good to keep for_each_string_list_item()
> implemented the way it is, given that all existing callers of it feed
> non-NULL lists to it.

We are talking right now about an example where it would be cleaner to
allow a NULL value.

This guarded example also exists in http.c (we would still need to guard
on NULL options):

	/* Add additional headers here */
	if (options && options->extra_headers) {
		const struct string_list_item *item;
		for_each_string_list_item(item, options->extra_headers) {
			headers = curl_slist_append(headers, item->string);
		}
	}

These guarded examples in ref_filter_match() would be greatly simplified:

	if (exclude_patterns && exclude_patterns->nr) {
		for_each_string_list_item(item, exclude_patterns) {
			if (match_ref_pattern(refname, item))
				return 0;
		}
	}

	if (include_patterns && include_patterns->nr) {
		for_each_string_list_item(item, include_patterns) {
			if (match_ref_pattern(refname, item))
				return 1;
		}
		return 0;
	}

	if (exclude_patterns_config && exclude_patterns_config->nr) {
		for_each_string_list_item(item, exclude_patterns_config) {
			if (match_ref_pattern(refname, item))
				return 0;
		}
	}

(The include_patterns check would still be needed for that extra
return 0; in the middle.)

There are more examples, but I'll stop listing them here.

> But why is it impossible to make it handle NULL lists? This works for
> me, and passes the tests:

> 	 /** Iterate over each item, as a macro. */
> 	 #define for_each_string_list_item(item,list)            \
> 	-	for (item = (list)->items;                      \
> 	+	for (item = (((list) && (list)->items) ? ((list)->items) : NULL); \

I thinks I had something like

	for ((list) && item = (list)->items; (list) && item && ...

but even with your suggestion, I get this compiler error:

In file included from convert.h:8,
                 from cache.h:10,
                 from apply.c:10:
apply.c: In function ‘write_out_results’:
string-list.h:146:22: error: the address of ‘cpath’ will always evaluate as ‘true’ [-Werror=address]
  146 |         for (item = ((list) && (list)->items) ? (list)->items : NULL;     \
      |                      ^
apply.c:4652:25: note: in expansion of macro ‘for_each_string_list_item’
 4652 |                         for_each_string_list_item(item, &cpath)
      |   

(along with many other examples).

Junio is right that we would need to convert this into a method with a
function pointer instead of a for_each_* macro. That's quite a big lift
for some small convenience for the callers.

Thanks,
-Stolee

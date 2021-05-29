Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F513C4708E
	for <git@archiver.kernel.org>; Sat, 29 May 2021 13:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2CAE610A5
	for <git@archiver.kernel.org>; Sat, 29 May 2021 13:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhE2NYw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 09:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhE2NYr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 09:24:47 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452FFC061574
        for <git@vger.kernel.org>; Sat, 29 May 2021 06:23:09 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id c3so5962523wrp.8
        for <git@vger.kernel.org>; Sat, 29 May 2021 06:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=71kJKpCfuVUjgVLL2UZez7hvUUndspGBGKe/0vGeWwQ=;
        b=kEIZKF+DqTNxLFxNTTImsMLtQ0e/r2oJUolj7Xz9vyAs9yj1w6jEwHILgWBVwiY2wM
         8D7tNBfFntxnswBGqrR+3Qvlc/5sK8GpYP2wmhS+rcBaaRzRLZTqbsKrZJKuPSxXZ/lr
         4LTqjWrF8tcMKgVjovHD+OKOwJGnb48iTOFQiGBXiFCkyrNJrcIvLVUDk3gJmRd2wSXl
         su3Pi43UXwnn7SYvcFXXI3f8sO4vm6dH4yeIrlk1vD5Ojq+FJlhPhefBhKGoJfcCDQpg
         pHZm7LzGoqfWjVnLgsgB1vVDjLpwSfQ685TYmd7E1uD096uztsyIusPzRiK3t+JV1Nfu
         2R5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=71kJKpCfuVUjgVLL2UZez7hvUUndspGBGKe/0vGeWwQ=;
        b=B43JHdSRlIo7npheLryhx8ZjZvyRGW/udqaNA15YP5EolWhv/oNzMzibTUWwliGyaL
         3bAmLpQE+R+zpJa1pEftpQ65TeQK/7ZqbUK/a9TEB4J3fxVspl2B3a1IsdIyp6CBNi3t
         ResZxoqjrFbRYRIoJcyhP9STlhLOElUpyyBvgGc+OublwurIUpRkE1ic4y/zDqkuztET
         xqt4uNgBAs7RANBIuMpDQXWibyEoTm5T/DcAA2S96J0cM7TdwHJH28m7wn6OxRhHgBJG
         AfCDqCEEFJIvBUr3I7bp0VI2yTCBM9pk1Y8M5l30UGSCj8EGW+ei5TjzLAwKNarn5+bc
         2nuw==
X-Gm-Message-State: AOAM530G8D/eFyDt8IT2ZxVfaHZ6fRzGbX3kt6RwZWHGXcscWrwi2aXm
        jdsXsSKBrDaGBrxhOhKBmDaZMayMMJw=
X-Google-Smtp-Source: ABdhPJzzVNQVJjvlIKhGgFLWD1yWnboG3Ol/uR0Rba8fTjMZS3fYt5ti9GnyHQibkceLdL/vFQA1Vw==
X-Received: by 2002:adf:f044:: with SMTP id t4mr1964790wro.73.1622294587873;
        Sat, 29 May 2021 06:23:07 -0700 (PDT)
Received: from [192.168.1.201] (11.22.198.146.dyn.plus.net. [146.198.22.11])
        by smtp.googlemail.com with ESMTPSA id o11sm10690349wrq.93.2021.05.29.06.23.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 May 2021 06:23:07 -0700 (PDT)
Subject: Re: [PATCH 1/2] [GSOC] ref-filter: add %(raw) atom
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
References: <pull.963.git.1622126603.gitgitgadget@gmail.com>
 <b3848f24f2d3f91fc96f20b5a08cbfbe721acbd6.1622126603.git.gitgitgadget@gmail.com>
 <60afca827a28f_265302085b@natae.notmuch>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <13c63e79-27fd-58d5-9a4c-6b58c40ef4b8@gmail.com>
Date:   Sat, 29 May 2021 14:23:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <60afca827a28f_265302085b@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/05/2021 17:36, Felipe Contreras wrote:
> ZheNing Hu via GitGitGadget wrote:
> [...]
>> +static int memcasecmp(const void *vs1, const void *vs2, size_t n)
> 
> Why void *? We can delcare as char *.

If you look at how this function is used you'll see
	int (*cmp_fn)(const void *, const void *, size_t);
	cmp_fn = s->sort_flags & REF_SORTING_ICASE
			? memcasecmp : memcmp;

So the signature must match memcmp to avoid undefined behavior (a 
ternary expression is undefined unless both sides evaluate to the same 
type and calling a function through a pointer a different type is 
undefined as well)

>> +{
>> +	size_t i;
>> +	const char *s1 = (const char *)vs1;
>> +	const char *s2 = (const char *)vs2;
> 
> Then we avoid this extra step.
> 
>> +	for (i = 0; i < n; i++) {
>> +		unsigned char u1 = s1[i];
>> +		unsigned char u2 = s2[i];
> 
> There's no need for two entirely new variables...
> 
>> +		int U1 = toupper (u1);
>> +		int U2 = toupper (u2);
> 
> You can do toupper(s1[i]) directly (BTW, there's an extra space: `foo(x)`,
> not `foo (x)`).
> 
> While we are at it, why keep an extra index from s1, when s1 is never
> used again?
> 
> We can simply advance both s1 and s2:
> 
>    s1++, s2++
> 
>> +		int diff = (UCHAR_MAX <= INT_MAX ? U1 - U2
>> +			: U1 < U2 ? -1 : U2 < U1);
> 
> I don't understand what this is supposed to achieve. Both U1 and U2 are
> integers, pretty low integers actually.
> 
> If we get rid if that complexity we don't even need U1 or U2, just do:
> 
>    diff = toupper(u1) - toupper(u2);
> 
>> +		if (diff)
>> +			return diff;
>> +	}
>> +	return 0;
>> +}
> 
> All we have to do is define the end point, and then we don't need i:
> 
> 	static int memcasecmp(const char *s1, const char *s2, size_t n)
> 	{
> 		const char *end = s1 + n;
> 		for (; s1 < end; s1++, s2++) {
> 			int diff = tolower(*s1) - tolower(*s2);
> 			if (diff)
> 				return diff;
> 		}
> 		return 0;
> 	}
> 
> (and I personally prefer lower to upper)

We should be using tolower() as that is what POSIX specifies for 
strcasecmp() [1] which we are trying to emulate and there are cases[2] where
	(tolower(c1) == tolower(c2)) != (toupper(c1) == toupper(c2))

Best Wishes

Phillip

[1] https://pubs.opengroup.org/onlinepubs/9699919799/
[2] https://en.wikipedia.org/wiki/Dotted_and_dotless_I#In_computing

> Check the following resource for a detailed explanation of why my
> modified version is considered good taste:
> 
> https://github.com/felipec/linked-list-good-taste
> 
>>   static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, struct ref_array_item *b)
>>   {
>>   	struct atom_value *va, *vb;
>> @@ -2304,6 +2382,7 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
>>   	int cmp_detached_head = 0;
>>   	cmp_type cmp_type = used_atom[s->atom].type;
>>   	struct strbuf err = STRBUF_INIT;
>> +	size_t slen = 0;
>>   
>>   	if (get_ref_atom_value(a, s->atom, &va, &err))
>>   		die("%s", err.buf);
>> @@ -2317,10 +2396,32 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
>>   	} else if (s->sort_flags & REF_SORTING_VERSION) {
>>   		cmp = versioncmp(va->s, vb->s);
>>   	} else if (cmp_type == FIELD_STR) {
>> -		int (*cmp_fn)(const char *, const char *);
>> -		cmp_fn = s->sort_flags & REF_SORTING_ICASE
>> -			? strcasecmp : strcmp;
>> -		cmp = cmp_fn(va->s, vb->s);
>> +		if (va->s_size == ATOM_VALUE_S_SIZE_INIT &&
>> +		    vb->s_size == ATOM_VALUE_S_SIZE_INIT) {
>> +			int (*cmp_fn)(const char *, const char *);
>> +			cmp_fn = s->sort_flags & REF_SORTING_ICASE
>> +				? strcasecmp : strcmp;
>> +			cmp = cmp_fn(va->s, vb->s);
>> +		} else {
>> +			int (*cmp_fn)(const void *, const void *, size_t);
>> +			cmp_fn = s->sort_flags & REF_SORTING_ICASE
>> +				? memcasecmp : memcmp;
>> +
>> +			if (va->s_size != ATOM_VALUE_S_SIZE_INIT &&
>> +			    vb->s_size != ATOM_VALUE_S_SIZE_INIT) {
>> +				cmp = cmp_fn(va->s, vb->s, va->s_size > vb->s_size ?
>> +				       vb->s_size : va->s_size);
>> +			} else if (va->s_size == ATOM_VALUE_S_SIZE_INIT) {
>> +				slen = strlen(va->s);
>> +				cmp = cmp_fn(va->s, vb->s, slen > vb->s_size ?
>> +					     vb->s_size : slen);
>> +			} else {
>> +				slen = strlen(vb->s);
>> +				cmp = cmp_fn(va->s, vb->s, slen > va->s_size ?
>> +					     slen : va->s_size);
>> +			}
>> +			cmp = cmp ? cmp : va->s_size - vb->s_size;
>> +		}
> 
> This hurts my eyes. I think the complexity of this chunk warrants a
> separate function. Then the logic would be easer to see.
> 
> Cheers.
> 


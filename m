Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14FCD215F4
	for <e@80x24.org>; Tue,  1 May 2018 14:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755832AbeEAOP2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 10:15:28 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:43926 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755305AbeEAOP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 10:15:26 -0400
Received: by mail-qk0-f169.google.com with SMTP id h19so8952076qkj.10
        for <git@vger.kernel.org>; Tue, 01 May 2018 07:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=v1TZGHaJ7rMrTDNDYG/U3tkv9N+MHK6sA71nzvjI2Hg=;
        b=VdJN6OoaTua+vPtnTGZJdEnpBjKVHPsQO5VROpmW3VgKmPX41KcZq3l24OYgenQvSY
         PN2jUzRNAMo2dNehZMUpj57qeN0gd60moa9JibLNMNMq8IwFn73FSBd4wCVtC9CxFeRx
         4s6G03Uj4UdqLKbzlhFEyStbZIYEogWQw0Qtha2j3e3ArugmNV5inNK34md3bdE6dZ2H
         2QzuDvqW9tsrhrBG8BoXeD6B5noqD9ifm2f4ZTxpid39sIzp2FKoSfh7lWXQq3SYmcTW
         mMz67ClAmV+AGbNEPDq8nv9PEJq7LfCSI3fLMTXEKjzB7v77JS8nzHckuAE5I6JCegeI
         vqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=v1TZGHaJ7rMrTDNDYG/U3tkv9N+MHK6sA71nzvjI2Hg=;
        b=K3+GtT3eyQgnmGoGsE2JP1Z8DIDNVkGqutjGiTge8TmAzP3IO2QULyfndDRktJNHaL
         VK5tQHdRUlJOpyBCmIUJRkUSLjWM1GDTdOknwdNTncStFGYQ677pUtdBteEjV7IglNQ4
         F11QQ+VvqZClqoZQM145TQ5KIbj64Eb/qY3G7X7fu4I7kXKItmTTxgQgdptRgm1FWDTD
         hDtVxIizXk/Dfuqpo2czPYrr8lHC0F5yX+47XJy12b0csfokLqweXJsb7AScHqPT9rvB
         qL3beprG+Dhxpwnt2hjp83DBUX3Smj5HnbUVfB6CBanukIhv4GonWv6uxojS1/LSsM6M
         +tJg==
X-Gm-Message-State: ALQs6tCE10cAebIB4sbvI894Vwiirf8YkjLOKhs4ZUe0OIawOpjkusNc
        l1twlBxcI/eu0klWbpKd7CAVrfOM
X-Google-Smtp-Source: AB8JxZqB4H0+OOBYCy4wZweTXoglc3d2AtnbSrpMJrWc/m56QYXm4xcVN9EjlFRGNY6EKPt77In97A==
X-Received: by 10.55.95.196 with SMTP id t187mr13183492qkb.62.1525184125139;
        Tue, 01 May 2018 07:15:25 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id 13-v6sm9154831qtp.14.2018.05.01.07.15.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 07:15:24 -0700 (PDT)
Subject: Re: [PATCH v2 06/11] get_short_oid: sort ambiguous objects by type,
 then SHA-1
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <20180501120651.15886-1-avarab@gmail.com>
 <20180501130318.58251-1-dstolee@microsoft.com>
 <876047ze9v.fsf@evledraar.gmail.com>
 <40868abd-6d2f-3f05-e099-6f0d06cc0683@gmail.com>
 <874ljrzctc.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <00b64485-44ef-709c-2f9d-56e790ca3a5e@gmail.com>
Date:   Tue, 1 May 2018 10:15:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <874ljrzctc.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/1/2018 10:10 AM, Ævar Arnfjörð Bjarmason wrote:
> Actually I'm having second thoughts about that and thinking I might keep
> my original approach (with a better explanation).
>
> A few more lines of code seems worthwhile in order to not break the
> assumptions a documented API is making, no matter how briefly, so I set
> about documenting this case and supporting it, since
> e.g. oid_array_lookup() will completely fail with the hack of setting
> the .sorted member, and came up with this:
>
> diff --git a/Documentation/technical/api-oid-array.txt b/Documentation/technical/api-oid-array.txt
> index b0c11f868d..ff87260220 100644
> --- a/Documentation/technical/api-oid-array.txt
> +++ b/Documentation/technical/api-oid-array.txt
> @@ -16,6 +16,20 @@ Data Structures
>   	the actual data. The `nr` member contains the number of items in
>   	the set.  The `alloc` and `sorted` members are used internally,
>   	and should not be needed by API callers.
> ++
> +Both the `oid_array_lookup` and `oid_array_for_each_unique` functions
> +rely on the array being sorted. For the former it's an absolute
> +requirenment that the internal `oid_array_sort` function has been
> +called on it, bu for the latter it's enough that the elements are
> +ordered in such a way as to guarantee that identical object IDs are
> +adjacent in the array.

s/bu/but/

> ++
> +This is useful e.g. to print output where commits, tags etc. are
> +grouped together (barring a hash collision they won't have the same
> +object ID), in such cases the `custom_sorted` member can be set to `1`
> +before calling `oid_array_for_each_unique`, and it'll skip its own
> +sorting. Once it's been set calling e.g. `oid_array_lookup` without it
> +being cleared again will cause an internal panic, so use it carefully.
>
>   Functions
>   ---------
> diff --git a/sha1-array.c b/sha1-array.c
> index 466a926aa3..cbae07ff78 100644
> --- a/sha1-array.c
> +++ b/sha1-array.c
> @@ -18,6 +18,7 @@ static void oid_array_sort(struct oid_array *array)
>   {
>   	QSORT(array->oid, array->nr, void_hashcmp);
>   	array->sorted = 1;
> +	array->custom_sorted = 0;
>   }
>
>   static const unsigned char *sha1_access(size_t index, void *table)
> @@ -28,6 +29,13 @@ static const unsigned char *sha1_access(size_t index, void *table)
>
>   int oid_array_lookup(struct oid_array *array, const struct object_id *oid)
>   {
> +	if (array->custom_sorted)
> +		/*
> +		 * We could also just clear custom_sorted here, but if
> +		 * the caller is custom sorting and then calling this
> +		 * that's likely something they'd like to know about.
> +		 */
> +		BUG("PANIC: Cannot lookup OIDs in arrays with a custom sort!");

Probably don't need the "PANIC: " here.

>   	if (!array->sorted)
>   		oid_array_sort(array);
>   	return sha1_pos(oid->hash, array->oid, array->nr, sha1_access);
> @@ -39,6 +47,7 @@ void oid_array_clear(struct oid_array *array)
>   	array->nr = 0;
>   	array->alloc = 0;
>   	array->sorted = 0;
> +	array->custom_sorted = 0;
>   }
>
>   int oid_array_for_each_unique(struct oid_array *array,
> @@ -47,7 +56,7 @@ int oid_array_for_each_unique(struct oid_array *array,
>   {
>   	int i;
>
> -	if (!array->sorted)
> +	if (!array->sorted && !array->custom_sorted)
>   		oid_array_sort(array);
>
>   	for (i = 0; i < array->nr; i++) {
> diff --git a/sha1-array.h b/sha1-array.h
> index 1e1d24b009..bfa77ba1e4 100644
> --- a/sha1-array.h
> +++ b/sha1-array.h
> @@ -6,6 +6,7 @@ struct oid_array {
>   	int nr;
>   	int alloc;
>   	int sorted;
> +	int custom_sorted;
>   };
>
>   #define OID_ARRAY_INIT { NULL, 0, 0, 0 }
> diff --git a/sha1-name.c b/sha1-name.c
> index b81e07adbb..d190800db0 100644
> --- a/sha1-name.c
> +++ b/sha1-name.c
> @@ -490,9 +490,11 @@ int for_each_abbrev(const char *prefix, each_abbrev_fn fn, void *cb_data)
>   	find_short_packed_object(&ds);
>
>   	QSORT(collect.oid, collect.nr, sort_ambiguous);
> -	collect.sorted = 1;
>
> +	collect.custom_sorted = 1;
>   	ret = oid_array_for_each_unique(&collect, fn, cb_data);
> +	collect.custom_sorted = 0;
> +
>   	oid_array_clear(&collect);
>   	return ret;
>   }
>
> So maybe I should just stop worrying and YOLO it, it just seems wrong to
> leave such a fragile setup in place where we set .sorted=1 and some
> future refactoring reasonably tries to call oid_array_lookup() on it and
> silently fails.
>
> What do you think?
I think this extra custom_sort check is worth keeping the API stable to 
future changes.

Thanks,
-Stolee

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0AC4215F4
	for <e@80x24.org>; Tue,  1 May 2018 12:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755239AbeEAM0u (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 08:26:50 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:34467 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754907AbeEAM0u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 08:26:50 -0400
Received: by mail-qk0-f170.google.com with SMTP id p186so8744160qkd.1
        for <git@vger.kernel.org>; Tue, 01 May 2018 05:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=gtwhI4QBbsTN+5UrKJjaclu6KBjebObB5vveAILPhgE=;
        b=fMN3SDJ82JTukj0W6uhusINRGSmY0+cO4J4BlqhvpsSF2gk57sdVTu/CgO+3hqow3S
         JI7t5spbOr6wLnjlGNbowcx9DMyyATViKIJngd1/l7F/P4HziLLm5YrR5r39Si2xp3Lu
         7yq/08NYs1VoM0t8xcHg8TUf0aOb95ihSvOZKmYXKOAqQHDOMqWcIRyNSPiv62d5E7LL
         XTduWQIAyVennRjSUvx8puaLrnWTNSnHZlvJzbUpEibRmwTg/7B+huUDktFbqEF23nOz
         xkY5AExAGbuYJ69NSffUZaNd1B3j3AfToggXTuwoVqGZB0uK6MD7k9UrZW3R0GmlhLxP
         LX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gtwhI4QBbsTN+5UrKJjaclu6KBjebObB5vveAILPhgE=;
        b=EV+zXHRT4C5p1TJDl+wk51aEaEbZLb3AyXCEqFmfHRG34qBSgBpU88aQq9bK7NWdQQ
         mM0SYs3NvPItvH1+rR5uoU9dbT76kuBUqDH6ZgKsnxnwARZTc5djaK8LXuw3a8VTwy5I
         FNKzRZgbgKCPN/Hp40KpMiNnQBtZYRv6Zo1kzAvdWR0lZ5FfYa6jbtD82zfDYitO4udm
         X7/+QGmgYmkk+w/nXWnRz6Vg26OaJP19iRxfAgLQZLkXjCILnDjhQKzPwnF1BzjaxaBH
         58hRRCD+8eql2hSdnYtjD8rzElXruVsMhymomC1nUmWbRWFJ4Pdi67AxpwOZTTuGzYI0
         6Heg==
X-Gm-Message-State: ALQs6tAd3KZro6UwMCYP8Oj40Ew/hymSPGHB47wxmeprYz9SFjFkQo+B
        mlCTbilGp7Av/lxzrZPSYu0=
X-Google-Smtp-Source: AB8JxZrljXb364dMJYxCg1Q3rECbLGNpLOVKCSAgsf3meFa3bSTH4GNzVmmzCmVBnG7BkrnG5W2Vbw==
X-Received: by 10.55.80.196 with SMTP id e187mr12769546qkb.166.1525177609193;
        Tue, 01 May 2018 05:26:49 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id l38-v6sm8923692qta.86.2018.05.01.05.26.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 05:26:48 -0700 (PDT)
Subject: Re: [PATCH 4/9] get_short_oid: sort ambiguous objects by type, then
 SHA-1
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <20180430220734.30133-1-avarab@gmail.com>
 <20180430220734.30133-5-avarab@gmail.com>
 <5f8b1ec1-258d-1acc-133e-a7c248b4083e@gmail.com>
 <87a7tjzkdm.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <348f193f-47bb-112f-6ef5-571749bb01e2@gmail.com>
Date:   Tue, 1 May 2018 08:26:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87a7tjzkdm.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/1/2018 7:27 AM, Ævar Arnfjörð Bjarmason wrote:
> On Tue, May 01 2018, Derrick Stolee wrote:
>
>> On 4/30/2018 6:07 PM, Ævar Arnfjörð Bjarmason wrote:
>>> Since we show the commit data in the output that's nicely aligned once
>>> we sort by object type. The decision to show tags before commits is
>>> pretty arbitrary, but it's much less likely that we'll display a tag,
>>> so if there is one it makes sense to show it first.
>> Here's a non-arbitrary reason: the object types are ordered
>> topologically (ignoring self-references):
>>
>> tag -> commit, tree, blob
>> commit -> tree
>> tree -> blob
> Thanks. I'll add a patch with that comment to v2.
>
>>> @@ -421,7 +451,12 @@ static int get_short_oid(const char *name, int len, struct object_id *oid,
>>>    			ds.fn = NULL;
>>>      		advise(_("The candidates are:"));
>>> -		for_each_abbrev(ds.hex_pfx, show_ambiguous_object, &ds);
>>> +		for_each_abbrev(ds.hex_pfx, collect_ambiguous, &collect);
>>> +		QSORT(collect.oid, collect.nr, sort_ambiguous);
>> I was wondering how the old code sorted by SHA even when the ambiguous
>> objects were loaded from different sources (multiple pack-files, loose
>> objects). Turns out that for_each_abbrev() does its own sort after
>> collecting the SHAs and then calls the given function pointer only
>> once per distinct object. This avoids multiple instances of the same
>> object, which may appear multiple times across pack-files.
>>
>> I only ask because now we are doing two sorts. I wonder if it would be
>> more elegant to provide your sorting algorithm to for_each_abbrev()
>> and let it call show_ambiguous_object as before.
>>
>> Another question is if we should use this sort generally for all calls
>> to for_each_abbrev(). The only other case I see is in
>> builtin/revparse.c.
> When preparing v2 I realized how confusing this was, so I'd added this
> to the commit message of my WIP re-roll which should explain this:
>
>      A note on the implementation: I started out with something much
>      simpler which just replaced oid_array_sort() in sha1-array.c with a
>      custom sort function before calling oid_array_for_each_unique(). But
>      then dumbly noticed that it doesn't work because the output function
>      was tangled up with the code added in fad6b9e590 ("for_each_abbrev:
>      drop duplicate objects", 2016-09-26) to ensure we don't display
>      duplicate objects.
>      
>      That's why we're doing two passes here, first we need to sort the list
>      and de-duplicate the objects, then sort them in our custom order, and
>      finally output them without re-sorting them. I suppose we could also
>      make oid_array_for_each_unique() maintain a hashmap of emitted
>      objects, but that would increase its memory profile and wouldn't be
>      worth the complexity for this one-off use-case,
>      oid_array_for_each_unique() is used in many other places.

How would sorting in our custom order before de-duplicating fail the 
de-duplication? We will still pair identical OIDs as consecutive 
elements and oid_array_for_each_unique only cares about consecutive 
elements having distinct OIDs, not lex-ordered OIDs.

Perhaps the noise is because we rely on oid_array_sort() to mark the 
array as sorted inside oid_array_for_each_unique(), but that could be 
remedied by calling our QSORT() inside for_each_abbrev() and marking the 
array as sorted before calling oid_array_for_each_unique().

(Again, my comments are not meant to block this series.)

Thanks,
-Stolee

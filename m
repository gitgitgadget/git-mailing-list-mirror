Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33EE0215F4
	for <e@80x24.org>; Tue,  1 May 2018 12:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755233AbeEAMgn (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 08:36:43 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:53328 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755044AbeEAMgm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 08:36:42 -0400
Received: by mail-wm0-f51.google.com with SMTP id a67so9970451wmf.3
        for <git@vger.kernel.org>; Tue, 01 May 2018 05:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=WfNdD9qhzeFS9l9ulMl6ZCqOSoMQ/DQnb6kuP8H9enA=;
        b=BoYTF6ymD50MbswXReP9hR/H8mcaRGEebfV7ED02J9/IvB6juK8XDC/V+dJ2aJqFBA
         nr8MqY7Fcx880AcjSqZTlwgLqNgZRbUWYsGLmcbdILKrRqNZ779It7zqfcPlMbA6lNfK
         bRragotIstMUJ6sfrtFhNZZCIQbsAyGXEKM2+mHv3I2FlLpfPMtWV1rBBNpwsWXka9Qu
         a9ZsWU/oaV2twBYKsp3UMIkuUYEXrs16EmXgZM7rnvxojuQwKWJ8+fHSN8NQGqOCreyB
         eNdodYRZanwTsZy7blQRL2KQFhOQiNQeIjBAbvo2G8AAaw4VqWWxH/p0FPvDFHCLSbOs
         yruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=WfNdD9qhzeFS9l9ulMl6ZCqOSoMQ/DQnb6kuP8H9enA=;
        b=DO3bkzGmNW32WaBTXWygWW3vcKgDMan45uhxVr/KsPp6oft9YIlcOhzOWfx9ZPky/Z
         VxwSsDBUWRmb5NsftGN+8JOZ8dGcmVeRrZXv9F/JQAebezlboXVxJiGY2vsVvOQIl46Z
         Z6h+EktGMs5frlDYbpoLsO+1McWnI8vhJPiV0QbjnnrsJ8FoxHUGqA90GeDoG/4immz3
         pt9FsOL7iCVj2Kg7UK+PeYOXJuQWM6kij0/8t4ZSHgrotWYYVXm5uSrSoJ6OjJFWTV6x
         KRQ/vRfuS/6wNnrURYxPkhwsyJQlIPXG5TZzYNS+w7ENJTCZop1d4gMOcyzVvYHdU5hx
         WTsQ==
X-Gm-Message-State: ALQs6tA5L4A1h0aLY5ukPFnkktlgtZ1h6qkJvu18K6T5xxQpyEtR878v
        1E0uTtzAOWpla93ZtivqOwg=
X-Google-Smtp-Source: AB8JxZrzMv7fmT/jhN36A+5UGi9c6RvSPjxFY7+4VyAs6jA8aB5TBNKxHItXpThRFS6KI33+OvtCtw==
X-Received: by 2002:a50:8561:: with SMTP id 88-v6mr21335523edr.119.1525178201159;
        Tue, 01 May 2018 05:36:41 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id 49-v6sm4820234edz.87.2018.05.01.05.36.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 05:36:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 4/9] get_short_oid: sort ambiguous objects by type, then SHA-1
References: <20180430220734.30133-1-avarab@gmail.com>
        <20180430220734.30133-5-avarab@gmail.com>
        <5f8b1ec1-258d-1acc-133e-a7c248b4083e@gmail.com>
        <87a7tjzkdm.fsf@evledraar.gmail.com>
        <348f193f-47bb-112f-6ef5-571749bb01e2@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <348f193f-47bb-112f-6ef5-571749bb01e2@gmail.com>
Date:   Tue, 01 May 2018 14:36:39 +0200
Message-ID: <878t93zh60.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 01 2018, Derrick Stolee wrote:

> On 5/1/2018 7:27 AM, Ævar Arnfjörð Bjarmason wrote:
>> On Tue, May 01 2018, Derrick Stolee wrote:
>>
>>> On 4/30/2018 6:07 PM, Ævar Arnfjörð Bjarmason wrote:
>>>> Since we show the commit data in the output that's nicely aligned once
>>>> we sort by object type. The decision to show tags before commits is
>>>> pretty arbitrary, but it's much less likely that we'll display a tag,
>>>> so if there is one it makes sense to show it first.
>>> Here's a non-arbitrary reason: the object types are ordered
>>> topologically (ignoring self-references):
>>>
>>> tag -> commit, tree, blob
>>> commit -> tree
>>> tree -> blob
>> Thanks. I'll add a patch with that comment to v2.
>>
>>>> @@ -421,7 +451,12 @@ static int get_short_oid(const char *name, int len, struct object_id *oid,
>>>>    			ds.fn = NULL;
>>>>      		advise(_("The candidates are:"));
>>>> -		for_each_abbrev(ds.hex_pfx, show_ambiguous_object, &ds);
>>>> +		for_each_abbrev(ds.hex_pfx, collect_ambiguous, &collect);
>>>> +		QSORT(collect.oid, collect.nr, sort_ambiguous);
>>> I was wondering how the old code sorted by SHA even when the ambiguous
>>> objects were loaded from different sources (multiple pack-files, loose
>>> objects). Turns out that for_each_abbrev() does its own sort after
>>> collecting the SHAs and then calls the given function pointer only
>>> once per distinct object. This avoids multiple instances of the same
>>> object, which may appear multiple times across pack-files.
>>>
>>> I only ask because now we are doing two sorts. I wonder if it would be
>>> more elegant to provide your sorting algorithm to for_each_abbrev()
>>> and let it call show_ambiguous_object as before.
>>>
>>> Another question is if we should use this sort generally for all calls
>>> to for_each_abbrev(). The only other case I see is in
>>> builtin/revparse.c.
>> When preparing v2 I realized how confusing this was, so I'd added this
>> to the commit message of my WIP re-roll which should explain this:
>>
>>      A note on the implementation: I started out with something much
>>      simpler which just replaced oid_array_sort() in sha1-array.c with a
>>      custom sort function before calling oid_array_for_each_unique(). But
>>      then dumbly noticed that it doesn't work because the output function
>>      was tangled up with the code added in fad6b9e590 ("for_each_abbrev:
>>      drop duplicate objects", 2016-09-26) to ensure we don't display
>>      duplicate objects.
>>           That's why we're doing two passes here, first we need to
>> sort the list
>>      and de-duplicate the objects, then sort them in our custom order, and
>>      finally output them without re-sorting them. I suppose we could also
>>      make oid_array_for_each_unique() maintain a hashmap of emitted
>>      objects, but that would increase its memory profile and wouldn't be
>>      worth the complexity for this one-off use-case,
>>      oid_array_for_each_unique() is used in many other places.
>
> How would sorting in our custom order before de-duplicating fail the
> de-duplication? We will still pair identical OIDs as consecutive
> elements and oid_array_for_each_unique only cares about consecutive
> elements having distinct OIDs, not lex-ordered OIDs.

Because there's no de-duplication without the array first being sorted
in oidcmp() order, which oid_array_for_each_unique() checks for and
re-sorts if !array->sorted. I.e. its de-duplication is just a state
machine where it won't call the callback if the currently processed
element has the same SHA1 as the last one.

> Perhaps the noise is because we rely on oid_array_sort() to mark the
> array as sorted inside oid_array_for_each_unique(), but that could be
> remedied by calling our QSORT() inside for_each_abbrev() and marking
> the array as sorted before calling oid_array_for_each_unique().

As noted above this won't work, because the function inherently relies
on the array being sorted to be able to de-duplicate. Doing this will
yield duplicate entries.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8D8C433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 19:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9723260F5A
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 19:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239088AbhJ0TZw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 15:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbhJ0TZv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 15:25:51 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5879C061570
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 12:23:25 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id i9so3016785qki.3
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 12:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Kn0kRyeksOXnA69TjM9/0FiaUKj0gWkvf38/+CLvkwE=;
        b=hWmVsJhNckTXCR8PurNauNJ5cBySvXXZvAAe/Po5+SeC+LNtsXk/iHhvFcop/Fi71U
         njTAyFi6pDDIONx6e/AIGlr3IzbHNaOiMBINTKMkzGBje2D7PzhIEyAT2xqZUkidQyeb
         LNlJSpV/vNKHAXJp1BpLNEMEPBXsRiD9fx9LwXPcmVDPo7hYUstUu42+7mmYx8nrpCXb
         ybnWnHjbEijybyoTNXZ6J55fGd8HPKprdbcYrlZccchoACkU/Uq0HPs6Cx/yh1JXQOge
         fPqkAAuwYyH+73+uwonw+5pIoSv0Q6eijbrbv9ZPeyG+Xlr3k9wFsrH87/guRTQdIG1Z
         QqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Kn0kRyeksOXnA69TjM9/0FiaUKj0gWkvf38/+CLvkwE=;
        b=agrq2NSIAhn5CD+PnKZOqyJdgN6Fgw/frn34wPnTw4rSTVrwvW6wXLrrfjgkzwFvW0
         UO4w5y4mu0XlvwBI9w477PK2j8lzpRv9ivUi57pjyRHK4ih59lP+Kww3O3Ykequ7SBEa
         OG04mTG5G2GTpsVKCh7Hjf8ArtlXDgvKm95HTgpiMwBJTGNrQO9KS8G7MegDlYL69n4B
         5Y6YS5UoNJ4t67NjFgF8ztJvH74oP+lWvo4nxNinW9CaSZCqEibydBdZ5aHU7bHKNkMN
         Tg6bla2obvcg11Sowg8EyKt6IhkX29mq98fPWChn064G9vJh0cEQh6F+chcPjHCOVs2m
         t6EA==
X-Gm-Message-State: AOAM532Ed8rir3Rq+BwWGyLii13ymWRTvIOD3cR5RcoKItkQAA02rvBt
        ivMlL/jBIJHqy7C2F/stYEw=
X-Google-Smtp-Source: ABdhPJz+b6cQDd2/gf3i29oP01Ci3ZFTN4jkt7P7gHpN+DwUYLF6ohmkjMPpFaVgyF12wJi2y5ylBw==
X-Received: by 2002:a05:620a:4003:: with SMTP id h3mr26515983qko.277.1635362604656;
        Wed, 27 Oct 2021 12:23:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:e44a:53c8:a196:8752? ([2600:1700:e72:80a0:e44a:53c8:a196:8752])
        by smtp.gmail.com with ESMTPSA id i2sm526017qti.92.2021.10.27.12.23.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 12:23:24 -0700 (PDT)
Message-ID: <e3c923b4-cce0-372c-31f4-9f091239ad8b@gmail.com>
Date:   Wed, 27 Oct 2021 15:23:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 2/3] protocol v2: specify static seeding of clone/fetch
 via "bundle-uri"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        "Robin H . Johnson" <robbat2@gentoo.org>
References: <cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com>
 <patch-2.3-3ac0539c053-20211025T211159Z-avarab@gmail.com>
 <7fab28bf-54e7-d0e9-110a-53fad6244cc9@gmail.com>
 <211027.86r1c6yh52.gmgdl@evledraar.gmail.com>
 <756524c1-a3b9-29b5-bb72-f75a0c76ea1f@gmail.com>
 <211027.86ilxixoxz.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <211027.86ilxixoxz.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/27/2021 2:01 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Oct 27 2021, Derrick Stolee wrote:
> 
>> On 10/27/2021 4:29 AM, Ævar Arnfjörð Bjarmason wrote:
>>>
>>> On Tue, Oct 26 2021, Derrick Stolee wrote:
>>>
>>>> On 10/25/2021 5:25 PM, Ævar Arnfjörð Bjarmason wrote:
>>>>> Add a server-side implementation of a new "bundle-uri" command to
>>>>> protocol v2. As discussed in the updated "protocol-v2.txt" this will
>>>>> allow conforming clients to optionally seed their initial clones or
>>>>> incremental fetches from URLs containing "*.bundle" files created with
>>>>> "git bundle create".
>>>>
>>>> ...
>>>>
>>>>> +DISCUSSION of bundle-uri
>>>>> +^^^^^^^^^^^^^^^^^^^^^^^^
>>>>> +
>>>>> +The intent of the feature is optimize for server resource consumption
>>>>> +in the common case by changing the common case of fetching a very
>>>>> +large PACK during linkgit:git-clone[1] into a smaller incremental
>>>>> +fetch.
>>>>> +
>>>>> +It also allows servers to achieve better caching in combination with
>>>>> +an `uploadpack.packObjectsHook` (see linkgit:git-config[1]).
>>>>> +
>>>>> +By having new clones or fetches be a more predictable and common
>>>>> +negotiation against the tips of recently produces *.bundle file(s).
>>>>> +Servers might even pre-generate the results of such negotiations for
>>>>> +the `uploadpack.packObjectsHook` as new pushes come in.
>>>>> +
>>>>> +I.e. the server would anticipate that fresh clones will download a
>>>>> +known bundle, followed by catching up to the current state of the
>>>>> +repository using ref tips found in that bundle (or bundles).
>>>>> +
>>>>> +PROTOCOL for bundle-uri
>>>>> +^^^^^^^^^^^^^^^^^^^^^^^
>>>>> +
>>>>> +A `bundle-uri` request takes no arguments, and as noted above does not
>>>>> +currently advertise a capability value. Both may be added in the
>>>>> +future.
>>>>
>>>> One thing I realized was missing from this proposal is any interaction
>>>> with partial clone. It would be disappointing if we could not advertise
>>>> bundles of commit-and-tree packfiles for blobless partial clones.
>>>>
>>>> There is currently no way for the client to signal the filter type
>>>> during this command. Not having any way to extend to include that
>>>> seems like an oversight we should remedy before committing to a
>>>> protocol that can't be extended.
>>>>
>>>> (This also seems like a good enough reason to group the URIs into a
>>>> struct-like storage, because the filter type could be stored next to
>>>> the URI.)
>>>
>>> I'll update the docs to note that. I'd definitely like to leave out any
>>> implementation of filter/shallow for an initial iteration of this for
>>> simplicity, but the protocol keyword/behavior is open-ended enough to
>>> permit any extension.
>>
>> It would be good to be explicit about how this would work. Looking at
>> it fresh, it seems that the server could send multiple bundle URIs with
>> the extra metadata to say which ones have a filter (and what that filter
>> is). The client could then check if a bundle matches the given filter.
>>
>> But this is a bit inverted: the filter mechanism currently has the client
>> request a given filter and the server responds with _at least_ that much
>> data. This allows the server to ignore things like pathspec-filters or
>> certain size-based filters. If the client just ignores a bundle URI
>> because it doesn't match the exact filter, this could lead the client to
>> ask for the data without a bundle, even if it would be faster to just
>> download the advertised bundle.
>>
>> For this reason, I think it would be valuable for the client to tell
>> the server the intended filter, and the server responds with bundle
>> URIs that contain a subset of the information that would be provided
>> by a later fetch request with that filter.
>>
>>> I.e. the server can start advertising "bundle-uri=shallow", and future
>>> clients can request arbitrary key-value pairs in addition to just
>>> "bundle-uri" now.
>>>
>>> Having said that I think that *probably* this is something that'll never
>>> be implemented, but maybe I'll eat my words there.
> 
> I didn't mean to elide past "filter", but was just using "shallow" as a
> short-hand for one thing in the "fetch" dialog that a client can mention
> that'll impact PACK generation, just like filter.
> 
> Having thought about this a bit more, I think it should be an invariant
> in any bundle-uri design that the server shouldn't communicate any
> side-channel information whatsoever about a bundle it advertises, if
> that information can't be discovered in the header of that bundle file.
> 
> Mind you, this means throwing out large parts of my current proposed
> over-the-wire design, but I think for the better. I.e. the whole
> response part where we communicate:
> 
>     (bundle-uri (SP bundle-feature-key (=bundle-feature-val)?)* LF)*
>     flush-pkt
> 
> Would just become something like:
> 
>     (bundle-uri delim-pkt bundle-header? delim-pkt)*
>     flush-pkt
> 
> I.e. we'd optionally transfer the content of the bundle header (content
> up to the first "\n\n") to the client, but *only* ever as a shorthand
> for saving the client a roundtrip.

It still seems like we're better off letting the client request a
filter and have the server present URIs that the client can use,
and the server can choose to ignore the filter or provide URIs that
are specific to that filter. Sending the full list and making the
client decide what it wants seems like it will be more complicated
than necessary.

However, I'll withhold complete judgement until I see a full proposal
in a v2.

> I think the sweet spot for "bundle-uri" is to advertise a small number
> of bundles that encompass common clone/fetch patterns. I.e. something
> like a bundle for a full clone with the repo data up to today, and maybe
> a couple of other bundles covering a time period that clients would be
> likely to incrementally update within, e.g. 1 week ago..today &&
> yesterday..now.
> 
> I agree that adding say "full clone, --depth=1" and "full clone, no
> blobs" etc. to that might be *very* useful for some deployments, but per
> the above I think we should really add that to the bundle format first,
> not protocol v2.
 
I'm focusing my interest in this topic not on "how can we make what we
already do faster?" but "how can we unlock scale not previously
possible?" Allowing blobless clones is an important part of this, in
my opinion, so it is my _default_ mode of operating.

Thanks,
-Stolee

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E746C433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 16:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5001160F92
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 16:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236750AbhJ0Qdu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 12:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbhJ0Qdt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 12:33:49 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6BCC061570
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 09:31:23 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id jk5so2123548qvb.9
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 09:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=moUaAcD3+pJckYVkf0lCArndckfwxAfzWIT9D4KAEQw=;
        b=osRoFHHRGzsc60fulIzrx/Lp6uGkPCdZ19aHbGAIey3vKRPrgt5FltMsa5lNH71Zlz
         9JmkM1m93TfoTKeRhPI0/iIwfjvx5PQzEcJZsb1btZUjI1aJcyUjsA4xMkek8j7SA/Ag
         5j1ZDPS7JLwiYrh8huJrZrpVSqFz1Rdt3yuIEVGLqaPEhBP0XFDyPnd905CwJr+vs1PO
         zHqpwkgsevXWaFNioBMDnSDeEhxfFAP7ozzZAYJlJYIvlYrK3UVbDE9S6AOyp4GiJSv8
         ywcsKsnNOD5NuSN9eDwPT7Yn/Sv1/gJvqHcVPUvMFjQrg08s1ca+hpkAEoZfPZ/NPQWq
         SDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=moUaAcD3+pJckYVkf0lCArndckfwxAfzWIT9D4KAEQw=;
        b=N7ep09VhStDgyPStRvc9gEYucL9ujUtTQlGW4Xl6gutJ8eFwpwJJpAh5gEl9k4RI/L
         xQkLZbBMdFr39mh/u3RlHz/3oWRbQ9uJz5iF3s16MpUmlNg788llfSlKqTSCAvICqyOq
         7VQAFg0O9ayQr9HZByZAoMPqW+GIYTCSsUEXkb1EGZwsT/0xNQYVoQGjBykRPW8oFORH
         mXwSn1tnLeb0UHY7MUhSVeLv8hefdqojZ951gFC2w8fdCpTi/kXE0ruqDU5FGUCQ93K/
         fh+L+bOU3kxskVykbRNr/x8yyuVlx7Y3uvvPgoWmrBpejMg0IwZkeZIGDLvv2slUqmUm
         HK6w==
X-Gm-Message-State: AOAM533lQJcB41U1lLNJpIV5b7PMK2bXLDnJfKbjGkBztsk/Q52Dv9Yv
        90twSy+4OtJIfk/BdjFJ2Kc=
X-Google-Smtp-Source: ABdhPJxm0lh+wWAO2GxsxEB0inHXMraYi0YE0P8THKnGTK+mwB8YuesU0B3IOMD2c7aDIQP5GcTPNw==
X-Received: by 2002:a05:6214:1250:: with SMTP id q16mr10792965qvv.52.1635352282794;
        Wed, 27 Oct 2021 09:31:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:e44a:53c8:a196:8752? ([2600:1700:e72:80a0:e44a:53c8:a196:8752])
        by smtp.gmail.com with ESMTPSA id 17sm247529qtw.16.2021.10.27.09.31.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 09:31:22 -0700 (PDT)
Message-ID: <756524c1-a3b9-29b5-bb72-f75a0c76ea1f@gmail.com>
Date:   Wed, 27 Oct 2021 12:31:20 -0400
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
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <211027.86r1c6yh52.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/27/2021 4:29 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Oct 26 2021, Derrick Stolee wrote:
> 
>> On 10/25/2021 5:25 PM, Ævar Arnfjörð Bjarmason wrote:
>>> Add a server-side implementation of a new "bundle-uri" command to
>>> protocol v2. As discussed in the updated "protocol-v2.txt" this will
>>> allow conforming clients to optionally seed their initial clones or
>>> incremental fetches from URLs containing "*.bundle" files created with
>>> "git bundle create".
>>
>> ...
>>
>>> +DISCUSSION of bundle-uri
>>> +^^^^^^^^^^^^^^^^^^^^^^^^
>>> +
>>> +The intent of the feature is optimize for server resource consumption
>>> +in the common case by changing the common case of fetching a very
>>> +large PACK during linkgit:git-clone[1] into a smaller incremental
>>> +fetch.
>>> +
>>> +It also allows servers to achieve better caching in combination with
>>> +an `uploadpack.packObjectsHook` (see linkgit:git-config[1]).
>>> +
>>> +By having new clones or fetches be a more predictable and common
>>> +negotiation against the tips of recently produces *.bundle file(s).
>>> +Servers might even pre-generate the results of such negotiations for
>>> +the `uploadpack.packObjectsHook` as new pushes come in.
>>> +
>>> +I.e. the server would anticipate that fresh clones will download a
>>> +known bundle, followed by catching up to the current state of the
>>> +repository using ref tips found in that bundle (or bundles).
>>> +
>>> +PROTOCOL for bundle-uri
>>> +^^^^^^^^^^^^^^^^^^^^^^^
>>> +
>>> +A `bundle-uri` request takes no arguments, and as noted above does not
>>> +currently advertise a capability value. Both may be added in the
>>> +future.
>>
>> One thing I realized was missing from this proposal is any interaction
>> with partial clone. It would be disappointing if we could not advertise
>> bundles of commit-and-tree packfiles for blobless partial clones.
>>
>> There is currently no way for the client to signal the filter type
>> during this command. Not having any way to extend to include that
>> seems like an oversight we should remedy before committing to a
>> protocol that can't be extended.
>>
>> (This also seems like a good enough reason to group the URIs into a
>> struct-like storage, because the filter type could be stored next to
>> the URI.)
> 
> I'll update the docs to note that. I'd definitely like to leave out any
> implementation of filter/shallow for an initial iteration of this for
> simplicity, but the protocol keyword/behavior is open-ended enough to
> permit any extension.

It would be good to be explicit about how this would work. Looking at
it fresh, it seems that the server could send multiple bundle URIs with
the extra metadata to say which ones have a filter (and what that filter
is). The client could then check if a bundle matches the given filter.

But this is a bit inverted: the filter mechanism currently has the client
request a given filter and the server responds with _at least_ that much
data. This allows the server to ignore things like pathspec-filters or
certain size-based filters. If the client just ignores a bundle URI
because it doesn't match the exact filter, this could lead the client to
ask for the data without a bundle, even if it would be faster to just
download the advertised bundle.

For this reason, I think it would be valuable for the client to tell
the server the intended filter, and the server responds with bundle
URIs that contain a subset of the information that would be provided
by a later fetch request with that filter.

> I.e. the server can start advertising "bundle-uri=shallow", and future
> clients can request arbitrary key-value pairs in addition to just
> "bundle-uri" now.
> 
> Having said that I think that *probably* this is something that'll never
> be implemented, but maybe I'll eat my words there.

You continue focusing on the shallow option, which I agree is not
important. The filter option, specifically --filter=blob:none, seems
to be critical to have a short-term plan for implementing with this
in mind.

Thanks,
-Stolee

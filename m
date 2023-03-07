Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11BAC678D5
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 15:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjCGPDa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 10:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjCGPCu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 10:02:50 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC643574F6
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 06:52:21 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id h19so14502250qtk.7
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 06:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1678200740;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2zrlmjam5gGGikaCi2vN/VH4kq0bfUIaCXNpG3pgqcA=;
        b=EtGzKfV0Qq6Y7DnOzKF2PtHMPE2bXjJnknL4Dk+kWg+ggje1RcK3vgHl522BHFFW3m
         gf2oDloMofQMt20vUfvKjFhlWORCeDQDCwFkfdoPaN3aaPGz6V8O00OcZjMqXT+2qamG
         OyYxdWqhn+BRZ24aErHrv98OVBtNvGDXCSqRG+Tdkwo1ychKfaUDD0NzqUkea5CaVcD4
         /aRgj8x0wJnhltd0yzbgxiw3ejnD13fOXbOuz/AO1XGlKpPGYkMepo7c6smQ84E9PtNu
         Cc0sWeClV0LgOuHo2S1YLdUzXOzRrxWNT95nQMCcS5A7EOrbyEOKBBpVP2NQIHRMtsoM
         m48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678200740;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2zrlmjam5gGGikaCi2vN/VH4kq0bfUIaCXNpG3pgqcA=;
        b=bfBw2yNgTwbQLsf8tF4FH5/oLKxQnGZ54B9x9nl241uQNKHOtBBIML8mw45dVlwyrW
         EhkIySTD7SjzbTJ8qS2HRheD8ir2EtOPTU6JZYDwL+tru0IZmNIaV6fxYHqL8q3fnWAS
         1TU7p9gQPXxhqO/dzikN6PXHBHPH5Oao9rKm2TtfaL+N/z8X4zC47JUuA84a0LzMaCBA
         4tDX+O98+muDbJDyOcfMGTg2wrlfVOlczsQr1c+OqHew0S1dwld4VKfy2AvZjx3OQC1L
         rfX1aadeKU4l3NvAgQtI7N4WXGsz4uYGIE62mxh23nNKtmbwmSx6M4qG/7PNiEbQOQkp
         eedQ==
X-Gm-Message-State: AO0yUKUO6ZA7detOaNETYd9E8CO8CeAbSaJ5f6KnhY953W3UKrmjq2U4
        GpprjlTTVuF5AyO5seTna7RP
X-Google-Smtp-Source: AK7set/Q+daUtGhNOVXh4XOlgAB/vtMTitRri97aw69k8CdMNlm7arx6lo8KDFX/ZkseMVJNP9j5JA==
X-Received: by 2002:ac8:5c4a:0:b0:3bf:d0ac:5ba9 with SMTP id j10-20020ac85c4a000000b003bfd0ac5ba9mr25975765qtj.7.1678200740612;
        Tue, 07 Mar 2023 06:52:20 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:bc03:c8e9:97f2:aeb0? ([2600:1700:e72:80a0:bc03:c8e9:97f2:aeb0])
        by smtp.gmail.com with ESMTPSA id dm53-20020a05620a1d7500b0074235386738sm9648262qkb.37.2023.03.07.06.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 06:52:20 -0800 (PST)
Message-ID: <901299ac-e543-b7e5-0a1a-c90e667a947d@github.com>
Date:   Tue, 7 Mar 2023 09:52:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] object-file: reprepare alternates when necessary
To:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1490.git.1678136369387.gitgitgadget@gmail.com>
 <xmqqy1o97apj.fsf@gitster.g> <ZAaFQJm6UGYH4YIi@nand.local>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <ZAaFQJm6UGYH4YIi@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/6/2023 7:28 PM, Taylor Blau wrote:
> On Mon, Mar 06, 2023 at 02:54:00PM -0800, Junio C Hamano wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> @@ -1008,6 +1008,7 @@ void reprepare_packed_git(struct repository *r)
>>>  	struct object_directory *odb;
>>>
>>>  	obj_read_lock();
>>> +	reprepare_alt_odb(r);
>>>  	for (odb = r->objects->odb; odb; odb = odb->next)
>>>  		odb_clear_loose_cache(odb);
>>
>> Hmph, if there was an old alternate ODB from which we took some
>> loose object from and cached, and if that ODB no longer is on the
>> updated alternate list, would we now fail to clear the loose objects
>> cache for the ODB?  Or are we only prepared for seeing "more"
>> alternates and assume no existing alternates go away?
> 
> Based on my understanding of the patch, we are only prepared to see
> "more" alternates, rather than some existing alternate going away.
> 
> That being said, I am not certain that is how it works. Perhaps an
> alternate "goes away", but does not actually get removed from the list
> of alternate ODBs. If that's the case, any object lookup in that
> now-missing ODB would fail, but any subsequent ODBs which were added
> after calling reprepare_alt_odb() would succeed on that object lookup.
> 
> So, I don't know. I don't have the implementation details of the
> alternates ODB mechanism paged in enough to say for sure. Hopefully
> Stolee can point us in the right direction.

The prepare_alt_odb() call only _adds_ to the linked odb list. It
will not remove any existing ODBs. Adding this reprepare_*() method
makes it such that we can use the union of the alternates available
across the lifetime of the process.

Thanks,
-Stolee


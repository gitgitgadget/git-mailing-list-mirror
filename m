Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD58CC32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 19:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbiI1TcC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 15:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbiI1Tbz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 15:31:55 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F899677F
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 12:31:51 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id 13so29233090ejn.3
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 12:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=7G7Zt4Ekypzb2EN1+6BOvjIUf35HTPk4VQy5EZhT9fs=;
        b=C3ZErllyJh85eQi8DcgqCmF8SRy4Ud+tuAmW+TOeBdcwQy4DEZvJis8KLAIBEz4sBR
         O2GN2OJQQTsS+pbClESggAOqA8ttNPmgDuqqRX2ebIjzF9DWsPvY6PtqdU505pQPSFk0
         3bGl/vnabJ4phLI5n0R2VRkHscNoyMAnUlET6e8A/CL/gcN2tTo6Pjknwbjj1xq0mAcy
         SVZlNP9+8mKZlI3repl2xB+waKJ4nuQgmsHBDyESQCdGcD56gWVSlO/xgbw2838VQnKk
         P83pmgJmj43OdrCebeB09YbGcHPGmn589kUxsocHA0tvhl2pZR1V1JvaS9nbt60uqCpa
         I01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=7G7Zt4Ekypzb2EN1+6BOvjIUf35HTPk4VQy5EZhT9fs=;
        b=gdeNIqJ2RF9HUVFp+J0A/6ItUHRwq+MhWV6ITB/t5dlEF7ytup739ki73qQJr/oDhV
         NRJNpuGqGuCdNw1YWGs6zl65SpmSk3JVvETAcaRKsoADt0x2zYyHOw1uHhfGryvFdrL4
         YDqsEfx4oP9l4mIFjREJg8UiZQSV2udLXI2GhUACkXK400F5Ryn6E6dnZAyy6OgLpK+2
         smA527mbYC48FtwmTgw8tUWZzf5z4PRIBSpg/elJOwoWtMAY7QRFfdhv9IcgwOiPtyrD
         EDND80IDaOANOzvmaZ6OLaYqQXeTp/Og9f1kY6ENVm6ax1JmG43dhoWNRufwkdjG23CM
         79tA==
X-Gm-Message-State: ACrzQf14DQxX+WSeZ9dtSWReW7jqR6hqrcuISpmTkWFQih/DISC7SKDY
        ivQQbGnBHtfgaWz31k49DMc=
X-Google-Smtp-Source: AMsMyM5NKz01NXE0lx8KTOLWWMxdjDuoPCAy5YLlfjSEQNoU9y0Db17WSAG7kEIU5yXh0AnZDLdLGw==
X-Received: by 2002:a17:907:7fa1:b0:782:7c58:5341 with SMTP id qk33-20020a1709077fa100b007827c585341mr26123236ejc.368.1664393509696;
        Wed, 28 Sep 2022 12:31:49 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id g17-20020a50ee11000000b00452e7ae2214sm809064eds.42.2022.09.28.12.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 12:31:48 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1odcmZ-0014Vn-1G;
        Wed, 28 Sep 2022 21:31:47 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/5] [RFC] config API: return empty list, not NULL
Date:   Wed, 28 Sep 2022 21:27:56 +0200
References: <pull.1369.git.1664287711.gitgitgadget@gmail.com>
 <xmqq35cc1arp.fsf@gitster.g>
 <35f6d380-f7a5-558d-1cfc-f5eb6ea6c818@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <35f6d380-f7a5-558d-1cfc-f5eb6ea6c818@github.com>
Message-ID: <220928.86czbfwb18.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 28 2022, Derrick Stolee wrote:

> On 9/27/2022 10:40 PM, Junio C Hamano wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> 
>>> This work changes the behavior of asking for a multi-valued config key to
>>> return an empty list instead of a NULL value. This simplifies the handling
>>> of the result and is safer for development in the future.
>>>
>>> This is based on v4 of my unregister series [1]
>>>
>>> [1]
>>> https://lore.kernel.org/git/pull.1358.v4.git.1664287021.gitgitgadget@gmail.com/
>>>
>>> This idea came about due to a bug in the git maintenance unregister work
>>> where the result from git_config_get_value_multi() was sent directly to
>>> for_each_string_list_item() without checking for a NULL value first.
>>>
>>> I'm sending this as an RFC mostly because I'm not 100% sure this shift is
>>> worth the refactoring pain and effort. I personally think getting an empty
>>> list is a safer choice, but I can also understand if someone has a different
>>> opinion.
>> 
>> Thanks.
>> 
>> I actually am in favor of the idea that a NULL can be passed around
>> to signal the lack of a string_list (or the lack of a instance of
>> any "collection" type), and the current code is structured as such,
>> and it gives us extra flexibility.  Of course, we need to see if
>> that extra flexibility is worth it.
>> 
>> With a colleciton col, "if (col && col->nr)" checks if we have
>> something to work on.  But a code like this (which is a longhand for
>> the for_each_string_list_item() issue we just reencountered):
>> 
>>     col = git_get_some_collection(...);
>>     if (!col)
>> 	return; /* no collection */
>>     if (!col->nr)
>> 	git_add_to_some_collection(col, the default item);
>>     for (i = 0; i < col->nr; i++)
>> 	do things on col.stuff[i];
>> 
>> can react differently to cases where we have an empty collection
>> and where we do not have any collection to begin with.  
>> 
>> The other side of the coin is that it would make it harder to treat
>> the lack of collection itself and the collection being empty the
>> same way.  The above code might need to become
>> 
>>     col = git_get_some_collection(...);
>>     if (!col)
>> 	col = git_get_empty_collection();
>>     if (!col->nr)
>> 	git_add_to_some_collection(col, the default item);
>>     for (i = 0; i < col->nr; i++)
>> 	do things on col.stuff[i];
>> 
>> but if the "get the collection" thing returns an empty collection
>> when there is actually no collection, we can lose two lines from
>> there.
>
> I'm all for conveying more information when possible, but how can
> the config API provide a distinction between an empty list and a
> NULL list? The only thing I can think about is a case where the
> empty value clears the list and no new values are added, such as
>
> 	[bogus "key"]
> 		item = one
> 		item = two
> 		item =
>
> With this, the key exists in the config file, but the multi-valued
> list is empty.

It's not empty, that's a list with three items: ["one", "two", ""], the
last one is just the empty string.

We then have some stateful parsing logic for individual keys that
decides to apply the business logic that an empty value clears the list,
but none of that's implemented as part of the config API itself.

I think we might want to create some helper function for such a
special-cased "multi" list, but...

> Is that an important distinction? I don't think so.

...even then no, I don't think there should be a distinction. It
shouldn't be an "empty list" in the "list.nr == 0" sense if the config
API understood that sort of construct natively, it should just act as
though the key wasn't specified, surely...

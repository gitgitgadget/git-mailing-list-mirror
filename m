Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CF7C433B4
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 19:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1B40613CC
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 19:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245095AbhDFTwg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 15:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbhDFTwg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 15:52:36 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C3DC06174A
        for <git@vger.kernel.org>; Tue,  6 Apr 2021 12:52:27 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id c204so7440443pfc.4
        for <git@vger.kernel.org>; Tue, 06 Apr 2021 12:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=Yzjrcn4fyCQXA3HK4HHbhiP++jPRQHBZJ32Fp9KomDQ=;
        b=sIQzq6wH1Ugze2YyRaARBsWgidrid4J2rMcI/TkblSuxd7kFrw2kB1bR7h9nr2KXPZ
         aJCxAkfKtbbxg8jUe1cNgUVciuZBT4CTnpybR/yfKVAauIZV9AfKqFZMxwIYNq4jWYv0
         x2hMJ1Z4i4VfgFnQVL+d9BnBD6F/TLrLdlVUuGsPraeCU2aW0uRyhpxWa5m+iAwgI4EO
         /ZnWmX2Cg+jVUO/YRS0OuskjCNd06/lBPr+UY1vv3ZaCYoRif6jp7Y3E7+eN9/DTr0co
         ObCm+VE7UM0Vz/t/BOVBR+AyjJ7R4wP/ofYZB+XAR5aLFeQzCEYhsIXvVVIYAzkC0zpA
         MHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Yzjrcn4fyCQXA3HK4HHbhiP++jPRQHBZJ32Fp9KomDQ=;
        b=qH0FBzLm1XEAKHD9WG1BgNCw+jBgcg7qoX+IGqBXoK0AMSA9XcMGcNYdCBK/V2R03F
         DoK1ElmS8wt5DvT5EQ0rWs25Zsjcp9FyMJwwqz0ym7asw7sJaYW2t7L3Jaisnmbgv6YO
         MH0iyps3gfkA6rK5NNCeq/Hh4meTWiKGkkvKEo/uuh+T/iDqE9oRfRazfAmtYgbfE0z9
         4VVFFueqjoIC2OAdrGptwQgxHRe0nSpQNQPMrIm2aXzmoTXKcVvfLfJFn6AtsJKasTyP
         VTy+j/CHmjxxeVzgY20OX5/K7KhooG79zFYmKE15cMXIvbDJS/EpaD2ZfXhIu6NUrNmZ
         B07A==
X-Gm-Message-State: AOAM532rdnPnbNHpTeJ0jcEa1G6Ba8p32rLcrlBG/221HhOQDhOeeDA4
        6KC1/xCJcrHsNAVlohQxb16cHcxlkdwtiQ==
X-Google-Smtp-Source: ABdhPJxuGwFJVF+whmU4kNI6MiOberGTwaQVCi8iwhzoU6G9ZOKBp+7Zv9jEfUDlukFmxFaL6tm22A==
X-Received: by 2002:a05:6a00:cd5:b029:20f:eaee:df1c with SMTP id b21-20020a056a000cd5b029020feaeedf1cmr29575902pfv.79.1617738746871;
        Tue, 06 Apr 2021 12:52:26 -0700 (PDT)
Received: from [192.168.0.107] ([103.112.34.122])
        by smtp.gmail.com with ESMTPSA id x4sm18676347pfn.134.2021.04.06.12.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 12:52:26 -0700 (PDT)
Subject: Re: [GSoC] Draft Proposal (Convert submodule to builtin)
To:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
References: <195bf718-6226-43c9-8c58-167388d3d99b@gmail.com>
 <f5b9ea24-e2f7-6c54-b4ff-86cef27527f7@gmail.com>
 <CAP8UFD1PC=vQCXLLoECPzFc8BGGfQxptHE5+Et11F-=3-twZYg@mail.gmail.com>
 <769c7c48-a518-2636-10be-1479997e8f15@gmail.com>
 <CAP8UFD0RyhnurYdWt1xWF2O-bpk-irSs71+XH1Zd8ghdzRKZ8Q@mail.gmail.com>
From:   Chinmoy Chakraborty <chinmoy12c@gmail.com>
Message-ID: <f58da7ee-1f35-0e59-a5ac-ae1a268719ed@gmail.com>
Date:   Wed, 7 Apr 2021 01:23:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD0RyhnurYdWt1xWF2O-bpk-irSs71+XH1Zd8ghdzRKZ8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 4/5/21 8:14 PM, Christian Couder wrote:
> You could add something like "so that the `git submodule` is fully
> implemented using C".
>
Sure I'll add this.


>> ##Work to be done##
>>
>> The only command that is left to be ported is `git submodule add`.
>> The previous work on this by Shourya Shukla in GSoC 2020, did
>> not reach a successful merge due to some issues in design and
>> was kicked out because it has been stale for so long.
> Maybe you could explain a bit what "kicked out" means, or replace it
> with something more explicit, for people who don't know well how Git
> development works.

Okay, I'll explain it in simple terms. Actually in the docs version

I added a link to the `kicked out` phrase directing to :

https://github.com/git/git/blob/1861aa482a38ae84f597cede48167ab43e7e50a3/whats-cooking.txt#L1158-L1169

I'll add this in the textual format too.


>> The first
>> and foremost aim of the project will be to finish porting this
>> command.
> You mean the "add" sub-command, or the full "submodule" command?

The "add" command.


> Before porting the `git submodule add` command the initial work
>> would be dedicated to the implementation of small helper functions
>> in the form of small patches, which would be directly used by the
>> `add` command. This workflow is based on the suggestion by
>> Junio C Hamano on the thread:
>> https://lore.kernel.org/git/xmqqd01sugrg.fsf@gitster.c.googlers.com/.
>>
>> This workflow would help in the following ways:
>>
>> - It would help in sending patches in a small digestible format.
>> - It would help the reviewers easily review those small units
>>     of patches in a single sitting.
>> - It would help keep small logical units of code in different clean commits.
> Yeah, nice!
>
> How does this compare with Shourya's work? Will this avoid the design
> issues in Shourya's work?

It would help in faster and more thorough reviews by the reviewers.

Since last time, the patches sent were quite large in size, it became quite

tedious and difficult to review the patch at once. Due to this, the review

and changes cycle slacked off and hence the patch never made it to master.

Sending the patches in small chunks and separate logic units would speed up

the review cycle.


> Nice! Maybe you could give an example and tell:
> - how you would name one of the above function,
> - what would be its arguments,
> - perhaps how you would test it
> ...

Sure I'll add example prototype of the functions.


>> - After implementation of all these helper methods, the main
>>     `module_add()` function would be implemented using the helper
>>     functions listed above as well as those helper functions which
>>     are predefined.
>> =================================================
> Ok, I will review the other parts later.
>
> Thanks!
Thanks for the review, really helpful :).

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF9FC48BE0
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 17:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85370613D0
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 17:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhFKRUI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 13:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhFKRUH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 13:20:07 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F20C0617AF
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 10:18:09 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so3824198oth.8
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 10:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t4jXFBXniW0p1KntW90zu5NEDOErmSYqdqv458DUY+U=;
        b=nFoFugVct6HbkLisJp+l52NMBBvHijy+DWYl6zq0JC8uP8WTixl9Eb6w/xdaL5VTw+
         MkU8zNy139nLBBLG5iXP72fQnBOyAwFI/8/x2pZdEQ41k8G5Eg4fM18s7lCsvGofRg7d
         05LGSu+iqukAUdApbj6h3FjohkpLQiOsalvsBlbTjFD2K3y8+pGnW5Ag81X1I/ux2baG
         saOaGMX3737IXI9Fx9FjyeJBDNsvmxLLkDFP4GjD1C28vyS4R5bFaB0fQOWR5DRAPQ2+
         G+41Px1DTpfbmx30wuN5SFTVu85pOJDOBhZcVnGH/s8uqnS0HtjUEazh5EWSklW0FHAW
         bMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t4jXFBXniW0p1KntW90zu5NEDOErmSYqdqv458DUY+U=;
        b=Mc3bwmt0gRofd8KCLQwKe79h3IBjtPysH4DHM4G89nLlZj/bHV7zWPIhYphhXg/AAk
         jW8xpIHmJqbfGYANnH/1fXxRTeK6SaPOnl7dl66iAGrsQXq/7jw9D4kzqQS/vzz7Bw7P
         T2NGQy0w2naLt3AmsbTIzgXhl2GuHhc3610IEOyP48bLkoBKWgaka2mq+yB4Ez4vGHDd
         9KXlukJ2L7p882CkA/DFyEZXdzkH0uFGU+Vt2Z9SMj8MED0QK4nO75vrRZ2mpmWlVJy2
         NP5ySJPRlyPIGpsT0LaXft3rzv3mjCOYr8DWxOSdnUr5hAtGOen1vl6EpEnuKi3OKbMW
         /daw==
X-Gm-Message-State: AOAM532qo99EqDec2YmgJEhDoOA5+TRTy2qXMTxFug/NGyBik8wXJCiV
        IowVzZrd8JQtwMQV9pCE5Tg=
X-Google-Smtp-Source: ABdhPJwDvyrZT+urtt4tYxObsSxLXVo8XwTo8YHWUYfOc3JpHE4uGmlDOvsZKeka4qhQHV0NDjW7KQ==
X-Received: by 2002:a05:6830:168e:: with SMTP id k14mr4122439otr.280.1623431888385;
        Fri, 11 Jun 2021 10:18:08 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3c70:274a:799:2c37? ([2600:1700:e72:80a0:3c70:274a:799:2c37])
        by smtp.gmail.com with ESMTPSA id l12sm1285290oig.49.2021.06.11.10.18.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 10:18:08 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] Use singular "they" when appropriate
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
 <87a6nz2fda.fsf@evledraar.gmail.com>
 <YMKTARn368Qzsqc2@camp.crustytoothpaste.net>
 <87pmwt1dz3.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f4488360-bdaf-3e97-69c5-00087f797117@gmail.com>
Date:   Fri, 11 Jun 2021 13:18:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87pmwt1dz3.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/10/2021 6:58 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Jun 10 2021, brian m. carlson wrote:
> 
...
>> In many cases, saying less is better, I agree.  If we don't need to
>> refer to a human being, then we don't need to consider any pronouns for
>> that human being.  If we communicate things more simply with fewer
>> words, then that's clearly better overall for everyone involved.
>> Nobody's reading documentation for pleasure, after all.
>>
>> I do think that the recommendation that we refer to an anonymous user in
>> a gender-neutral way still stands, though.  Sometimes we will need to
>> refer to the user or another human actor and that will be the most
>> natural way to express the idea, so we should use gender-neutral
>> language to do so.
>>
>> So roughly here, I'm in favor of both approaches.
> 
> When do we need or even prefer to refer to a user like that?
> 
> I haven't seen an example in our documentation that's actually better
> off because we're talking about things as if two "people" we need to
> invent pronouns for are interacting.
> 
> Can anyone name one that'll stand up under scrutiny, i.e. once we can
> look at it and see if we couldn't phrase it better by avoiding the issue
> this series tries to address with a regex search-replacement?
> 
> The diffstat of this series is only:
> 
>  12 files changed, 22 insertions(+), 15 deletions(-)
> 
> I've looked at all of them and I can't see one that wouldn't be better
> if the relevant text was changed similarly to what I've suggested
> upthread.
> 
> That's why I don't think this proposal is useful. If we accept this
> series we're going to be left with an active recommendation for a
> pattern that's already almost nonexistent in our documentation.
> 
> Perhaps that's because we're doing it 98% right already and aren't using
> "he" or "she" but "they" or "their". The multiple ways you can use
> "they" or "their" in the English language makes that hard to grep for. A
> lot of our "they"'s are referring e.g. to a command-line option, or
> "their" referring to "their arguments", as in the argv vector of a
> program.

Since the examples are already few in number, it is not an
overwhelming amount of work to remove third-person singular pronouns
from the necessary locations. Perhaps if there were more examples
then such a conversion would be too difficult and we would want to
use a more mechanical replacement with singular "they".

My general approach (as specified in this v2) is:

1. Use singular "they" over "he" or "she" and other variants.
2. If you don't want to write "they", then avoid third-person
   singular pronouns.

Your approach focuses only on item 2, giving this recommendation:

* Avoid third-person singular pronouns.

I think your change to CodingGuidelines is a bit verbose to get to
that point, and makes it difficult to understand one goal is to
avoid gendered pronouns, which I think reduces the chance that a
new contributor would discover and understand that recommendation.

A semantically similar addition would be:

	Avoid gendered pronouns such as "he/him" and "she/her". If
	necessary, alter your sentence structure to use singular "you"
	to refer to the reader or plural "they" to refer to multiple
	actors.

> The skepticism about this being needed at all isn't an opinion I hold
> about software documentation in general, but about software in Git's
> problem space specifically.

A change that says "don't use 'he' and/or 'she' unnecessarily" is
important to encode as a project guideline so we can stop having
discussions about their use whenever they are introduced in a patch.

There is value in having this decision encoded, and the important
thing from my standpoint is that we explicitly avoid gendered pronouns
and can simply point contributors to that decision if we ever notice
one being introduced. That reduces friction the same way that we
decide where curly braces should be placed after an "if" statement.

My preference continues to be singular "they" because it is an easy
way to adapt natural sentence structures into an inclusive language.
But if we decide that this grammar is too difficult for some readers
to understand (due to English as a secondary language or other
reasons to be more strict to older language patterns), then avoiding
gendered pronouns entirely would satisfy my goals in this series.

Thanks,
-Stolee

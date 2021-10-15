Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822E5C433FE
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 09:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5958360241
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 09:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbhJOJwk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 05:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhJOJwj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 05:52:39 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FD2C061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 02:50:33 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id g198-20020a1c20cf000000b0030d60cd7fd6so1921813wmg.0
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 02:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=APfmp4YCZbFAoEHNjcuMMT0gNGUCyooFuscTXK/ecwI=;
        b=Ev+k4hClKTqPn4JMzSDFc5UEEHZoiOZsWgAVKsqUZv0kRCe3AJtgpRCXzOJNt5W/UP
         i3P0haYWm7X6XPP7rH4IVadRDBedsEVSNooxoaG/BONBjxLbyN3rueLlvUFDwjfCmtOe
         tA5oFPLodl2IN41XwAqAhEg84F64HEDHrIf4rtOHhYdprYd7IK4Oaa22WcIdiPLycLqB
         3W09gYEwUkEStNPqG1zP8B4Q7RAfYDiX+UWG/ujd0D6XBr2cke4ppTdYWZKq1B0+8FW7
         ajXiwqMGR+sJ6KCvvV0fyF72cCKxR8iMqQGZK2+le9Te6zGQP4oiYRnAyaCvrk4CpfMQ
         FDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=APfmp4YCZbFAoEHNjcuMMT0gNGUCyooFuscTXK/ecwI=;
        b=jzArjAcPp0dzJv9VT5QXClnqv3sw6n3+7alxG4C6GL6/jDTwowicligpoDlwyOyHbn
         eO70qNavsrIys4QOE/oylPGcUN85a2wAG0/WzndFKOq+u/MLfKdJVWiLSrXeQHTEsWDD
         DJXXbBl59fdKGZSj3HuYXhNiKmsPLrpTBnrzQvhKm1ITdxWlHx0XiiQtV+ZzOwy/X8dD
         WARk/DDkfRfOqvWfw3InNj/Oz95KaZmsV6QO1BPBkJgnICbzG8bNDK4nViO6nUX8AKpu
         IsDbUOzbdcyKy31PT0r7FmgoVJAXRADnKzrxEleMBB2JP7zX7oO7Sk6LtxqzZNaZ0dxc
         /TvQ==
X-Gm-Message-State: AOAM5339jhBcUp9s35h7VeaLJ9yUJReHAFHHUVl5aX9hoTvGE2whDhk5
        6MlBT+IAhD1XjFmSWPrbLJ22C0xE6zA=
X-Google-Smtp-Source: ABdhPJzkh1FRJIAUle1XZrb6BxL60bo0BfkMV13hmYDvKf6TJs2cHvutEtu8h1lqSc1ap6LB26fZLw==
X-Received: by 2002:a05:600c:b41:: with SMTP id k1mr25161279wmr.4.1634291431606;
        Fri, 15 Oct 2021 02:50:31 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id t21sm4157126wmi.19.2021.10.15.02.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 02:50:31 -0700 (PDT)
Message-ID: <00c06d4c-7e8a-2306-7278-3bc73e4cbc44@gmail.com>
Date:   Fri, 15 Oct 2021 10:50:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: To "const char *" and cast on free(), or "char *" and no cast...
Content-Language: en-GB-large
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Eric Wong <e@80x24.org>
References: <patch-1.1-9b17170b794-20211014T000949Z-avarab@gmail.com>
 <8f87cdb9-b52b-8d1a-545d-ed3055c536c0@gmail.com>
 <87mtnbfk0g.fsf@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <87mtnbfk0g.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 14/10/2021 20:54, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Oct 14 2021, Phillip Wood wrote:
> 
> [Changed $subject]
> 
>> On 14/10/2021 01:10, Ævar Arnfjörð Bjarmason wrote:
>>> The "checkout" command is one of the main sources of leaks in the test
>>> suite, let's fix the common ones by not leaking from the "struct
>>> branch_info".
>>> Doing this is rather straightforward, albeit verbose, we need to
>>> xstrdup() constant strings going into the struct, and free() the ones
>>> we clobber as we go along.
>>
>> It's great to see these leaks being fixed. I wonder though if it would
>> be better to change the structure definition so that 'name' and 'path'
>> are no longer 'const'. That would be a better reflection of the new
>> regime.[...]
> 
> I think this is the right thing to do, but I'm not quite sure. There was
> a thread at it here:
> 
>      https://lore.kernel.org/git/YUZG0D5ayEWd7MLP@carlos-mbp.lan/
> 
> Where I chimed in and suggested exactly what you're saying here, but the
> consensus seemed to go the other way, and if you grep:
> 
>      git grep -F 'free((char *)'
> 
> You can see that we use this pattern pretty widely.
> 
>> It would also mean we could lose all the casts when freeing
>> and there would be a compiler warning if a string literal is assigned
>> to one of those fields.
> 
> What compiler/set of warnings gives you a warning when you do that? I
> don't get warned on e.g.:

Oh, I think I was thinking of -Wwrite-strings but we don't have that 
warning on and turning it on causes a bunch of -Wdiscarded-qualifier 
warnings.

Best Wishes

Phillip

>      diff --git a/builtin/checkout.c b/builtin/checkout.c
>      index a32af16d5e4..d7053579bdf 100644
>      --- a/builtin/checkout.c
>      +++ b/builtin/checkout.c
>      @@ -94 +94 @@ struct branch_info {
>      -       const char *name; /* The short name used */
>      +       char *name; /* The short name used */
>      @@ -110 +110 @@ static void branch_info_release(struct branch_info *info)
>      -       free((char *)info->name);
>      +       free(info->name);
>      @@ -1107 +1107 @@ static int switch_branches(const struct checkout_opts *opts,
>      -               new_branch_info->name = xstrdup("(empty)");
>      +               new_branch_info->name = "(empty)";
> 
> Now, what is really useful is making it a "char * const", especially
> when hacking up these changes as you'll find all the assignments, but I
> haven't found the general use in having that make it to a submitted
> patch, since you need to assign somewhere, and those then need to be a
> str[n]cpy() (except we banned.h it) or memcpy() with a cast...
> 

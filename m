Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67E1C433FE
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 16:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiKEQg3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 12:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKEQgY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 12:36:24 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9D62037E
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 09:36:23 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bk15so10758949wrb.13
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 09:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oAreKjIKfBrvvUfMsV4UAVphzOp+s1tNN2BCZGAigMk=;
        b=nJupZ9KphCb9HsxD5kQGod+m0mffHFWeAqG5T9491BPAbIdz+vDC6iiJdcPK6+3g5s
         z9ccvB0oBJwG4afqVIrs+Sa3v57IlfkgpRlqMT0n3g2+gARTsLY1xxzDeEZwrC7p7BJ9
         ZNqlIdHUAfJSC29VGZkqRet9I6xPBDBEGy+zBuQ5e5rMU9or1FY1pOlGIZHNar4Sz3gN
         nbBwsXe9y+Db1MJsPZpSCCgf00Gew9G286jN3OwmpN6rTzbdL7osu5OwI3+HCLW7yPpW
         TVWPtF93wFgnY0MEFkV6UYF9LKWUfZCzVoob492P83tRKFi82DuDD7Agcd8m496rOdus
         M+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAreKjIKfBrvvUfMsV4UAVphzOp+s1tNN2BCZGAigMk=;
        b=m9xoP9qc2psKg2ORa+myDHVfJXUCBihHhP1t52vocmHc+C/bRICWEUhOhHkPxsJgDv
         yFOz31QUnuPfkJWzij/NIfvTjZ/4/XUTsPg9PzexRr+dM8UVH/Iy0cw9vRUgnrn655Cs
         twsWjBQeNPyrvZhpMA6RTh45I45+Sxdnq0YsCeOhhK2pZtdPjDld4uOj5kbEfn7LVIVi
         EFUdrB9SEYj9lzzVr3a1zSFbb41udo22j005YDKNwmm+R+9AJjdkgg26qHuHeda1cCLY
         B3ikn7O7NY9BIBZl4aPh1cdxegTQ4BiR0xDKd8y4HQK13BEL/EOcnR8QaKEpj0t0htrt
         7v/Q==
X-Gm-Message-State: ACrzQf1CW8BYIVfawpkh8Pe8nvDTgUbpRF+hi6DcPqT6XjdUyPK4Fejd
        Gb63ySaU80gRPxjsB1mmbq0=
X-Google-Smtp-Source: AMsMyM6jJtGXDx5h/u2du85YA/oKaYZ/6JrZgAsJTMYbQjQEXRay0wgzbGEc2Oa1n7UkNfNQsv/+cA==
X-Received: by 2002:a05:6000:1143:b0:236:5ede:cdad with SMTP id d3-20020a056000114300b002365edecdadmr26703991wrx.410.1667666181060;
        Sat, 05 Nov 2022 09:36:21 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id r17-20020a05600c35d100b003c6cd82596esm6813735wmq.43.2022.11.05.09.36.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Nov 2022 09:36:20 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <1b158749-44b1-34e0-5b52-1d3bfad9bc9a@dunelm.org.uk>
Date:   Sat, 5 Nov 2022 16:36:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 09/13] parse-options API: don't restrict OPT_SUBCOMMAND()
 to one *_fn type
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com>
 <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
 <patch-09.13-2cb3807aa17-20221104T132117Z-avarab@gmail.com>
 <df855ba1-52b1-1007-68e8-2e28e85b6822@web.de>
 <221105.861qqhxz0o.gmgdl@evledraar.gmail.com>
In-Reply-To: <221105.861qqhxz0o.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/11/2022 13:52, Ævar Arnfjörð Bjarmason wrote:
> 
> On Sat, Nov 05 2022, René Scharfe wrote:
> 
>> Am 04.11.22 um 14:22 schrieb Ævar Arnfjörð Bjarmason:
>>> diff --git a/parse-options.h b/parse-options.h
>>> index b6ef86e0d15..61e3016c3fc 100644
>>> --- a/parse-options.h
>>> +++ b/parse-options.h
>>> @@ -128,19 +128,24 @@ typedef int parse_opt_subcommand_fn(int argc, const char **argv,
>>>    *			 the option takes optional argument.
>>>    *
>>>    * `callback`::
>>> - *   pointer to the callback to use for OPTION_CALLBACK
>>> + *   pointer to the callback to use for OPTION_CALLBACK and OPTION_SUBCOMMAND.
>>>    *
>>>    * `defval`::
>>>    *   default value to fill (*->value) with for PARSE_OPT_OPTARG.
>>>    *   OPTION_{BIT,SET_INT} store the {mask,integer} to put in the value when met.
>>> + *   OPTION_SUBCOMMAND stores the pointer the function selected for
>>> + *   the subcommand.
>>> + *
>>>    *   CALLBACKS can use it like they want.
>>>    *
>>>    * `ll_callback`::
>>>    *   pointer to the callback to use for OPTION_LOWLEVEL_CALLBACK
>>>    *
>>>    * `subcommand_fn`::
>>> - *   pointer to a function to use for OPTION_SUBCOMMAND.
>>> - *   It will be put in value when the subcommand is given on the command line.
>>> + *   pointer to the callback used with OPT_SUBCOMMAND() and
>>> + *   OPT_SUBCOMMAND_F(). Internally we store the same value in
>>> + *   `defval`. This is only here to give the OPT_SUBCOMMAND{,_F}()
>>> + *   common case type safety.
>>>    */
>>>   struct option {
>>>   	enum parse_opt_type type;
>>> @@ -217,12 +222,24 @@ struct option {
>>>   #define OPT_ALIAS(s, l, source_long_name) \
>>>   	{ OPTION_ALIAS, (s), (l), (source_long_name) }
>>>
>>> +static inline int parse_options_pick_subcommand_cb(const struct option *option,
>>> +						   const char *arg UNUSED,
>>> +						   int unset UNUSED)
>>> +{
>>> +	parse_opt_subcommand_fn *fn = (parse_opt_subcommand_fn *)option->defval;
>>> +	*(parse_opt_subcommand_fn **)option->value = fn;
>>
>> ->defval is of type intptr_t and ->value is a void pointer.  The result
>> of converting a void pointer value to an intptr_t and back is a void
>> pointer equal to the original pointer if I read 6.3.2.3 (Pointers,
>> paragraphs 5 and 6) and 7.18.1.4 (Integer types capable of holding
>> object pointers) in C99 correctly.
>>
>> 6.3.2.3 paragraph 8 says that casting between function pointers of
>> different type is OK and you can get your original function pointer
>> back and use it in a call if you convert it back to the right type.
>>
>> Casting between a function pointer and an object pointer is undefined,
>> though.  They don't have to be of the same size, so a function pointer
>> doesn't have to fit into an intptr_t.  I wouldn't be surprised if CHERI
>> (https://www.cl.cam.ac.uk/research/security/ctsrd/cheri/) was an actual
>> example of that.
> 
> I should have called this out explicitly. I think you're right as far as
> what you're summarizing goes.
> 
> To elaborate on it, paragraph 8 of 6.3.2.3 says:
> 
> 	A pointer to a function of one type may be converted to a
> 	pointer to a function of another type and back again; the result
> 	shall compare equal to the original pointer. If a converted
> 	pointer is used to call a function whose type is not compatible
> 	with the pointed-to type, the behavior is undefined.
> 
> And 7.18.1.4 says, when discussing (among other things) "intptr_t"
> ("[such" added for clarity:
> 
> 	[...]any valid [such] pointer to void can be converted to this
> 	type, then converted back to pointer to void, and the result
> 	will compare equal to the original pointer:
> 
> But as you point out that doesn't say anything about whether a pointer
> to a function is a "valid .. pointer to void".
> 
> I think that's an "unportable" extension covered in "J.5 Common
> extensions", specifically "J.5.7 Function pointer casts":
> 
> 	A pointer to an object or to void may be cast to a pointer to a
> 	function, allowing data to be invoked as a function

This is a common extension, it is _not_ guaranteed by the standard and 
so still undefined behavior unless your compiler happens to have 
implemented that extension.

> Thus, since the standard already establishes that valid "void *" and
> "intptr_t" pointers can be cast'd back & forth, the J.5.7 bridges the
> gap between the two saying a function pointer can be converted to
> either.

How does J.5.7 bridge the gap when compilers are not required to 
implement it?

> Now, I may be missing something here, but I was under the impression
> that "intptr_t" wasn't special in any way here, and that any casting of
> a function pointer to either it or a "void *" was what was made portable
> by "J.5.7"

How is it made portable by an "unportable" extension?

> So I think aside from other concerns this should be safe to use, as
> real-world data backing that up we've had a intptr_t converted to a
> function pointer since v2.35.0: 5cb28270a1f (pack-objects: lazily set up
> "struct rev_info", don't leak, 2022-03-28).

Saying "it works so it is fine" is not a convincing argument that it is 
compliant with the standard. If it is undefined then it may work now but 
not in a future compiler.

>> Why is this trickery needed?  Above you write that callbacks in
>> builtin/bisect--helper.c can't use subcommand_fn because they need
>> their own argument.  Can we extend subcommand_fn or use a global
>> variable to pass that extra thing instead?  The latter may be ugly, but
>> at least it's valid C..

Unfortunately the current code relies on being able to cast function 
pointers to void* so it is not just this patch that is relying on 
undefined behavior.

Best Wishes

Phillip

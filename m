Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9709FC05027
	for <git@archiver.kernel.org>; Sun, 29 Jan 2023 12:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjA2M2p (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Jan 2023 07:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjA2M2o (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jan 2023 07:28:44 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C101DBAB
        for <git@vger.kernel.org>; Sun, 29 Jan 2023 04:28:41 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id x10so8513165edd.10
        for <git@vger.kernel.org>; Sun, 29 Jan 2023 04:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IA0Bkz3U6hTWLTPxFomaMl4Pc1iEq/JkQqoxL60O4VA=;
        b=kligiu3YjHXnQcL+5pOz7iiCIYldGOAyCTrX2/xqWVq4qilmdRPqKNUrPjRt6t3abf
         aDFwx6TgC1RwhJ9TyZNuAWBGDoBRFNK6WFVDQeqZGIf7cDCL15dRo3s29ouKcmG1WltD
         VM5tmMuMPjZ1+BRhbj4YhR5xW2g51w8bVEo6Nhq4qL+/tHV4ndpOvz65iGn0bw0HVxxC
         ZiaDMgez64+IVTwQJiOvZJAByNLee3ghaf48kNuuY5aBH1lyJ13rLIBGcfXk/jNdnJwd
         Kf0SAdgvLO++H8j1Ml8L64VgdcSpcORFTZLM19f2dYPPgc+HEY3tXVxm3E/l4YsbdQRT
         MDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IA0Bkz3U6hTWLTPxFomaMl4Pc1iEq/JkQqoxL60O4VA=;
        b=kxI3NU7DhSfxGDjxWiFGprgngdQxED/3Ob5pdmZUiyQA1ZtWTEYNCityG5ylCinxRL
         wp+gU5MuyBz5+qrljIkthiDl/sCvqe6GYqFsT709XlA+2FYy16lsr34SbwTZCAAHhb/E
         Gpc9Uqlu9ZaFz59K5H819oB358ihVcUKjwnreXFykNjoaKpEE+qY4VyDViObh511OIBK
         kZV4ns+beNYGqSg/iAUR1Bu+YIp4ooqIXBFcKujQ4XVezNc+N9Sm0nHjhSfHsNv7+erF
         v6Sl1BJCRbtngWn8Rak2lkBXfjBp2pVShEk8QpDAsHVPVYVuYqwKDTJflu1oSlQsA11b
         U2KA==
X-Gm-Message-State: AO0yUKVEhHUmZRFIPrgKIUF/jURq9tz7D6ilun6CDwKLynySfQYk8IFw
        QUU4dSKo6lwD9KnKbbCa/MbUnw==
X-Google-Smtp-Source: AK7set/1jj2jIP3d1fOFWJp9fJFQkMCe/RScL0dXYEf6ACyfjt0lxNARlQAwvv2ERKtT6mfsHdHJ/Q==
X-Received: by 2002:a05:6402:4504:b0:4a2:1d08:283b with SMTP id ez4-20020a056402450400b004a21d08283bmr6284224edb.11.1674995319946;
        Sun, 29 Jan 2023 04:28:39 -0800 (PST)
Received: from ?IPV6:2003:f6:af40:8200:19e:ccc3:be2a:f498? (p200300f6af408200019eccc3be2af498.dip0.t-ipconnect.de. [2003:f6:af40:8200:19e:ccc3:be2a:f498])
        by smtp.gmail.com with ESMTPSA id ov9-20020a170906fc0900b0087bdae9a1ebsm3697805ejb.94.2023.01.29.04.28.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jan 2023 04:28:39 -0800 (PST)
Message-ID: <d9f368bb-ff22-5294-3974-e0017f512c1a@grsecurity.net>
Date:   Sun, 29 Jan 2023 13:28:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] grep: fall back to interpreter if JIT memory
 allocation fails
Content-Language: en-US, de-DE
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>
References: <20221216121557.30714-1-minipli@grsecurity.net>
 <20230127154952.485913-1-minipli@grsecurity.net> <xmqqbkmk9bsn.fsf@gitster.g>
From:   Mathias Krause <minipli@grsecurity.net>
In-Reply-To: <xmqqbkmk9bsn.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27.01.23 17:34, Junio C Hamano wrote:
> Mathias Krause <minipli@grsecurity.net> writes:
> 
>> As having a functional PCRE2 JIT compiler is a legitimate use case for
>> performance reasons, we'll only do the fallback if the supposedly
>> available JIT is found to be non-functional by attempting to JIT compile
>> a very simple pattern. If this fails, JIT is deemed to be non-functional
>> and we do the interpreter fallback. For all other cases, i.e. the simple
>> pattern can be compiled but the user provided cannot, we fail hard as we
>> do now as the reason for the failure must be the pattern itself.
> 
> I do not know if it is a good idea to rely on the "very simple
> pattern".  The implementation of JIT could devise various ways to
> succeed for such simple patterns without having writable-executable
> piece of memory.

Well, if PCRE2 JIT ever changes to optimize this case, we would be back
to the error I'm seeing right now. But I doubt that PCRE2 will be doing
optimizations like that. The current implementation does the JIT memory
allocation test very early, even before looking at the pattern:

https://github.com/PCRE2Project/pcre2/blob/pcre2-10.42/src/pcre2_jit_compile.c#L14450-L14465

But I can add a call to pcre2_pattern_info(PCRE2_INFO_JITSIZE) if you
really like me to, but IMHO it's not needed.

>                   What happened to the earlier idea of falling back
> to the interpreted codepath, which will catch any bad pattern that
> has "the reason for the failure" by failing anyway?

Ævar's concerns about always falling back to the interpreter mode made
me change the patch like this. Basically what he's concerned about are
two things:
1/ "Crazy patterns" that fail the JIT but will work for the interpreter
can be a serve performance regression.
2/ Always falling back to interpreter mode might mask JIT API usage
errors, we'd like to see.

While 1/ could also be seen as a limitation of current 'git grep', I
share Ævar's extended runtime regression concerns. If, for example, some
web interface offers users to supply arbitrary grep patterns, abusing
the interpreter mode fallback will consume significant more CPU
resources than it does right now (which simply fails with an error).

> 
>> +static int pcre2_jit_functional(void)
>> +{
>> +	static int jit_working = -1;
>> +	pcre2_code *code;
>> +	size_t off;
>> +	int err;
>> +
>> +	if (jit_working != -1)
>> +		return jit_working;
>> +
>> +	/*
>> +	 * Try to JIT compile a simple pattern to probe if the JIT is
>> +	 * working in general. It might fail for systems where creating
>> +	 * memory mappings for runtime code generation is restricted.
>> +	 */
>> +	code = pcre2_compile((PCRE2_SPTR)".", 1, 0, &err, &off, NULL);
>> +	if (!code)
>> +		return 0;
>> +
>> +	jit_working = pcre2_jit_compile(code, PCRE2_JIT_COMPLETE) == 0;
>> +	pcre2_code_free(code);
> 
> I'd prefer not having to worry about: Or it might not fail for such
> systems, as the pattern is too simple and future versions of
> pcre2_compile() could have special case code.

See above, it's unlikely to happen.

> 
>> @@ -317,8 +342,23 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
>>  	pcre2_config(PCRE2_CONFIG_JIT, &p->pcre2_jit_on);
>>  	if (p->pcre2_jit_on) {
>>  		jitret = pcre2_jit_compile(p->pcre2_pattern, PCRE2_JIT_COMPLETE);
>> -		if (jitret)
>> +		if (jitret == PCRE2_ERROR_NOMEMORY && !pcre2_jit_functional()) {
>> +			/*
>> +			 * Even though pcre2_config(PCRE2_CONFIG_JIT, ...)
>> +			 * indicated JIT support, the library might still
>> +			 * fail to generate JIT code for various reasons,
>> +			 * e.g. when SELinux's 'deny_execmem' or PaX's
>> +			 * MPROTECT prevent creating W|X memory mappings.
>> +			 *
>> +			 * Instead of faling hard, fall back to interpreter
>> +			 * mode, just as if the pattern was prefixed with
>> +			 * '(*NO_JIT)'.
>> +			 */
>> +			p->pcre2_jit_on = 0;
>> +			return;
> 
> Yes, the "instead of failing hard, fall back" makes sense.  Just
> that I do not see why the runtime test is a good thing to have.

It prevents the fallback from being abused and introducing new
regressions. So it's good to have.

>                                                                  In
> short, we are not in the business of catching bugs in pcre2_jit
> implementations, so if they say they cannot compile the pattern (I
> would even say I doubt the point of checking the return code to
> ensure it is NOMEMORY), it would be fine to let the interpreter
> codepath to inspect the pattern and diagnose problems with it, or
> take the slow match without JIT.

Yeah, unfortunately they're not gonna fix what's a bug, IMHO. They think
it's a feature: https://github.com/PCRE2Project/pcre2/pull/157

Anyhow, the error code is very well documented, see pcre2_jit_compile(3)
"""
          [...]  The  function can also return PCRE2_ERROR_NOMEMORY if
       JIT is unable to allocate executable memory for  the  compiler,
       even if it was because of a system security restriction.
"""

And that's very much in line with what the test in pcre2_jit_compile()'s
current implementation does.

> What am I missing?

Please have a look at Ævar's reasoning here:
https://lore.kernel.org/git/221220.86bknxwy9t.gmgdl@evledraar.gmail.com/

Thanks,
Mathias

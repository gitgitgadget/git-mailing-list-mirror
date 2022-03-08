Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC49C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 10:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346033AbiCHK4E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 05:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346035AbiCHKz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 05:55:58 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52DA4349F
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 02:55:01 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id j17so27921087wrc.0
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 02:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m1WLqXaliJLrN471EXcqhSBOdiZo0gWh+cXdECZZo6M=;
        b=nDMbLZKsc5SJavADaVcCvSNFN9gpQCxg+JFzPy2IM4CULBJbOlstVFIyFlsUjE/xy6
         9n9MCHpmdqjzu7NT7s5tOrygq7wMh2gO/jihhdsIBUtNPFqBmcR1nTHmFg1zel72lOwO
         x+lCnzFbW4J7/dJBQ9mnbNnEKuf9R6+d8tEf5NPzuiHZC8vwXUR0WRcuvYHmP53VpOU/
         6sHizJYOEyu6s7PJnKWAORbCLadKnIu2Ieh7WcGCks5yZZc1g2MEv3ihX148tDYCFes/
         HqjEvEwSf4NCOpRMQ/FzSGN9IEhGj6DaSnj3vVmgEwgX6vVc+HvZ7Z00XyXzqIsWTZMN
         g2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m1WLqXaliJLrN471EXcqhSBOdiZo0gWh+cXdECZZo6M=;
        b=UeSTrEW+M+nBbJZpNxgZM3ceCVr5BOg7J3MybWkcIXOO4hM5ilN3wIjWeXWz4htWgN
         OQKR1uq9aTIx5u7rI25ZYAPzBF1WKqjnA0LxkYL1c6vX8T+X89zINIXCRcO3QSpclMPG
         PV6uDAm7j6xUwDSi+P+uPkEOUknzpWeFHsunE4tBi3dKWO5DgnW0mFFqWdcTi/JK5mR3
         h2FTtAVUBsAaOI93QrMtXtg4lwpAPG6IDKJ6juUEIsvmmpcZzUMmyOi/MAo+iReIKnn8
         QYWptXW4eKRmT4cXtbTSEVVBfAqSQtGICZRjaeuF0Q83wJNIQRkqV7WN8jIXKzn4WKxg
         aLGw==
X-Gm-Message-State: AOAM533oN1WnM5p32zVYWQvuQmEptqcI7uI0LO1zWk+Udr3xNts9Q589
        ILlOdqTdUjjteHnayuTaITPSEQLQRZA=
X-Google-Smtp-Source: ABdhPJyyDAvJ1Qm0dnYJT0Et8nagui5aGtvaxSvsJo2GT6zXLZZogcpbqHDPdmb4DoWJ8tNA7QzOKA==
X-Received: by 2002:adf:e50a:0:b0:1f0:224e:fd6f with SMTP id j10-20020adfe50a000000b001f0224efd6fmr11815913wrm.209.1646736900324;
        Tue, 08 Mar 2022 02:55:00 -0800 (PST)
Received: from [192.168.1.201] (206.2.7.51.dyn.plus.net. [51.7.2.206])
        by smtp.googlemail.com with ESMTPSA id f20-20020a05600c4e9400b003898e252cd4sm2107977wmq.12.2022.03.08.02.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 02:54:59 -0800 (PST)
Message-ID: <09a0bb3f-1e03-5692-f54e-2ff080c21cc8@gmail.com>
Date:   Tue, 8 Mar 2022 10:54:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/4] terminal: restore settings on SIGTSTP
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        phillip.wood@dunelm.org.uk
Cc:     Git Mailing List <git@vger.kernel.org>, carenas@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20220304131126.8293-1-phillip.wood123@gmail.com>
 <20220304131126.8293-5-phillip.wood123@gmail.com>
 <220305.86bkyk4hwc.gmgdl@evledraar.gmail.com>
 <8aa11144-c9ce-46aa-2edd-15e8fa1298dc@gmail.com>
 <220307.86ilsq0xxr.gmgdl@evledraar.gmail.com>
 <a02dea22-7403-7302-cf20-9aff75a10d14@gmail.com>
 <220307.86o82hzucl.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <220307.86o82hzucl.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/03/2022 14:45, Ævar Arnfjörð Bjarmason wrote:
>[...] 
> On Mon, Mar 07 2022, Phillip Wood wrote:
> 
>> On 07/03/2022 11:49, Ævar Arnfjörð Bjarmason wrote:
>>> On Mon, Mar 07 2022, Phillip Wood wrote:
>>>
>>>> Hi Ævar
>>>>
>>>> On 05/03/2022 13:59, Ævar Arnfjörð Bjarmason wrote:
>>>>> [...]
>>>>>>     int save_term(unsigned flags)
>>>>>>     {
>>>>>> +	struct sigaction sa;
>>>>>> +
>>>>>>     	if (term_fd < 0)
>>>>>>     		term_fd = (flags & SAVE_TERM_STDIN) ? 0
>>>>>>     						    : open("/dev/tty", O_RDWR);
>>>>>> @@ -44,6 +136,26 @@ int save_term(unsigned flags)
>>>>>>     	if (tcgetattr(term_fd, &old_term) < 0)
>>>>>>     		return -1;
>>>>>>     	sigchain_push_common(restore_term_on_signal);
>>>>>> +	/*
>>>>>> +	 * If job control is disabled then the shell will have set the
>>>>>> +	 * disposition of SIGTSTP to SIG_IGN.
>>>>>> +	 */
>>>>>> +	sigaction(SIGTSTP, NULL, &sa);
>>>>>> +	if (sa.sa_handler == SIG_IGN)
>>>>>> +		return 0;
>>>>>> +
>>>>>> +	/* avoid calling gettext() from signal handler */
>>>>>> +	background_resume_msg = xstrdup(_("error: cannot resume in the background"));
>>>>>> +	restore_error_msg = xstrdup(_("error: cannot restore terminal settings"));
>>>>> You don't need to xstrdup() the return values of gettext() (here
>>>>> _()),
>>>>> you'll get a pointer to static storage that's safe to hold on to for the
>>>>> duration of the program.
>>>>
>>>> I had a look at the documentation and could not see anything about the
>>>> lifetime of the returned string, all it says is "don't alter it"
>>> I think this is overed in "11.2.7 Optimization of the *gettext
>>> functions", a pedantic reading might suggest not, but what's meant with
>>> the combination of that API documentation & the description of how MO
>>> files work is that you're just getting pointers into the already-loaded
>>> translation catalog, so it's safe to hold onto the pointer and re-use it
>>> later.
>>
>> Strictly that section only shows it is safe if there are no other
>> calls to gettext() before the returned string is used. I agree the
>> implementation is likely to be just returning static strings but I
>> can't find anywhere that says another implementation (e.g. on
>> macos/*bsd) has to do that.
> 
> I agree. I'm 99.99% sure this is safe & portable use of the API, but I'm
> having some trouble finding documentation for that...
> 
>>> In any case, if we're going to be paranoid about gettext() it would make
>>> sense to propose that as some general change to how we use it, we rely
>>> on this assumption holding in a lot of our use of the API:
>>>       git grep '= _\('
>>> Rather than sneak that partcular new assumption in here in this
>>> already
>>> tricky code...
>>
>> The ones I looked at are mostly not calling gettext() again before
>> using the translated string (there is one exception in
>> builtin/remote.c).
> 
> Doesn't validate_encoding() in convert.c, process_entry() in
> merge-ort.c, setup_unpack_trees_porcelain() in unpack-trees.c cmd_mv()
> in builtin/mv.c etc. qualify?

I only checked a few, cmd_mv() always assigns to the same variable so 
the previous value is overwritten anyway, some of the others such as 
unpack_trees are assuming the return value is valid after a subsequent 
call to gettext(). I found[1] which states

     The string returned must not be modified by the program and can
     be invalidated by a subsequent call to bind_textdomain_codeset()
     or setlocale(3C).

so I think we can drop the copying.

> I.e. for a hypothetical gettext() that always returned the same pointer
> and just overwrote it with the latest message those would all emit bad
> output, wouldn't they?
> 
>> In restore_term() I'm checking if the messages are NULL to see if job
>> control is enabled, I could use a flag but I'm inclined to just keep
>> coping the strings.
> 
> Checking if they're NULL is orthagonal to whether we xstrdup()
> them. I.e. you'd just skip the xstrdup() and replace the FREE_AND_NULL
> with a "= NULL" assignment, no?

Yes, I'm not sure what I was thinking when I wrote that.

Best Wishes

Phillip

[1] 
https://docs.oracle.com/cd/E88353_01/html/E37843/gettext-3c.html#REFMAN3Agettext-3c


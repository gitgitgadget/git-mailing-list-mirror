Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DB4C433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 13:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241523AbiCGNu5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 08:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242491AbiCGNuy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 08:50:54 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA918BF55
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 05:49:59 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id k8-20020a05600c1c8800b003899c7ac55dso1777465wms.1
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 05:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=u/LhRNmROH1Yf3DSLl7tJx3x9YaLi8s6o1VOPIQ89/U=;
        b=iNBmwgrcoaaR7XkNf+Hv+oYchQ1+kryPUvck/Ea0IhSBDmnL48lXl9ko4VzbBLS2A9
         /bWmUDvRxCIps+RIXk7dMVSZ2kbmR9xqIYMdyNMYiVMESKd1hKu8gQ9luFqAVpol5hZR
         KO/LvNzg+VlaVQ1EQRs9lsHJbLlPuNswj5HtSJbtEOHje+uPzYuBoCVPOhFQa0iiur2X
         EHcsP1hjizzU6wPo6q1hchutALlWrYFZjLUE+sF0jWB5Yw+wcnjsb6Pgst0nVY9LBnGm
         v4839EPTgccOzds8ypsg6XDE8cuosaaST8cOc5HwWu48NVY0rbHrJ1IXd25l1gHUJAuU
         thWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=u/LhRNmROH1Yf3DSLl7tJx3x9YaLi8s6o1VOPIQ89/U=;
        b=F7cQvJEiBz4bb7aRktUNr4tVXkFynDo3nGoLVHe6wpK0SDlHdewSY+3WjaeWS3iQco
         xxAl5xGJOUaBzIWnUrrA1CGWWOqtiesfsNcnD6u1O23s3qubZoeFKkyVm9kSkNZESvFA
         bGOEY0TFGyfvR2wqUpVldmlPIVlL2EssoKSaCmmld+zQwr+cSU/hxKCC0IF7rkYJLX0E
         qJU+AFueIracd0ly+HdT00FzfpKwGlLEfDnSkszQK4PrzAG48JvdgPQL9UNtAMOMmMTe
         teva+4b4AI3mrl5bfw3nvKPZsVx7wj3ZpsQBo7GwmH7JEWGViTVkjLpWwZw+3ln4JaUm
         sjhw==
X-Gm-Message-State: AOAM530ijzSErThkI+PIs3sgPmvtn+6mfDSpHAs3O3FeSmdRiltiN4B8
        9rMIeeVZgvTHwkO95biClX0=
X-Google-Smtp-Source: ABdhPJymBc2uCETYghuJHPFxlch/m0FtHFw+x3FCCvy+v7HBh02XX+RGZSfJhwn3OV62FEsGAUC2xw==
X-Received: by 2002:a7b:c30d:0:b0:381:4bb9:eede with SMTP id k13-20020a7bc30d000000b003814bb9eedemr18579038wmj.74.1646660998185;
        Mon, 07 Mar 2022 05:49:58 -0800 (PST)
Received: from [192.168.1.201] (206.2.7.51.dyn.plus.net. [51.7.2.206])
        by smtp.googlemail.com with ESMTPSA id f4-20020a5d4dc4000000b001d8e67e5214sm11507910wru.48.2022.03.07.05.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 05:49:57 -0800 (PST)
Message-ID: <a02dea22-7403-7302-cf20-9aff75a10d14@gmail.com>
Date:   Mon, 7 Mar 2022 13:49:51 +0000
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
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <220307.86ilsq0xxr.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/03/2022 11:49, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Mar 07 2022, Phillip Wood wrote:
> 
>> Hi Ævar
>>
>> On 05/03/2022 13:59, Ævar Arnfjörð Bjarmason wrote:
>>> [...]
>>>>    int save_term(unsigned flags)
>>>>    {
>>>> +	struct sigaction sa;
>>>> +
>>>>    	if (term_fd < 0)
>>>>    		term_fd = (flags & SAVE_TERM_STDIN) ? 0
>>>>    						    : open("/dev/tty", O_RDWR);
>>>> @@ -44,6 +136,26 @@ int save_term(unsigned flags)
>>>>    	if (tcgetattr(term_fd, &old_term) < 0)
>>>>    		return -1;
>>>>    	sigchain_push_common(restore_term_on_signal);
>>>> +	/*
>>>> +	 * If job control is disabled then the shell will have set the
>>>> +	 * disposition of SIGTSTP to SIG_IGN.
>>>> +	 */
>>>> +	sigaction(SIGTSTP, NULL, &sa);
>>>> +	if (sa.sa_handler == SIG_IGN)
>>>> +		return 0;
>>>> +
>>>> +	/* avoid calling gettext() from signal handler */
>>>> +	background_resume_msg = xstrdup(_("error: cannot resume in the background"));
>>>> +	restore_error_msg = xstrdup(_("error: cannot restore terminal settings"));
>>> You don't need to xstrdup() the return values of gettext() (here
>>> _()),
>>> you'll get a pointer to static storage that's safe to hold on to for the
>>> duration of the program.
>>
>> I had a look at the documentation and could not see anything about the
>> lifetime of the returned string, all it says is "don't alter it"
> 
> I think this is overed in "11.2.7 Optimization of the *gettext
> functions", a pedantic reading might suggest not, but what's meant with
> the combination of that API documentation & the description of how MO
> files work is that you're just getting pointers into the already-loaded
> translation catalog, so it's safe to hold onto the pointer and re-use it
> later.

Strictly that section only shows it is safe if there are no other calls 
to gettext() before the returned string is used. I agree the 
implementation is likely to be just returning static strings but I can't 
find anywhere that says another implementation (e.g. on macos/*bsd) has 
to do that.

> In any case, if we're going to be paranoid about gettext() it would make
> sense to propose that as some general change to how we use it, we rely
> on this assumption holding in a lot of our use of the API:
> 
>      git grep '= _\('
> 
> Rather than sneak that partcular new assumption in here in this already
> tricky code...

The ones I looked at are mostly not calling gettext() again before using 
the translated string (there is one exception in builtin/remote.c).

In restore_term() I'm checking if the messages are NULL to see if job 
control is enabled, I could use a flag but I'm inclined to just keep 
coping the strings.

> 
>>> In this case I think it would make sense to skip "error: " from the
>>> message itself.
>>> Eventually we'll get to making usage.c have that prefix translated,
>>> and
>>> can have some utility function exposed there (I have WIP patches for
>>> this already since a while ago).
>>> To translators it'll look like the same thing, and avoid churn when
>>> we
>>> make the "error: " prefix translatable.
>>
>> Unless we add a function that returns a string rather than printing
>> the message I don't see how it avoids churn in the future. Having the
>> whole string with the "error: " prefix translated here does not add
>> any extra burden to translators - it is still the same number of
>> strings to translate.
> 
> Because translators translate "we failed" for most errors, not "error:
> we failed".
> 
> If and when we convert it from "error: we failed" to "we failed" they'll
> need to translate it again (although to be fair, the translation cache
> will help).
> 
> And even then it'll be one of very few exceptions where the "error: "
> currently that *is* translated.
> 
>>> Aside: If you do keep the xstrdup() (perhaps an xstrfmt() with the above
>>> advice...) doesn't it make sense to add the "\n" here, so you'll have
>>> one write_in_full() above?
>>
>> I decided to keep the translated string simpler by omitting the
>> newline, calling write_in_full() twice isn't a bit deal (I don't think
>> the output can be split by a write from another thread or signal
>> handler in between).
> 
> Makes sense.
> 
> FWIW I meant if you're going to xstrdup() or xstrfmt() it anyway you
> could do:
> 
>      xstrfmt("error: %s\n", _("the error"))
> 
> And then do one call to write_in_full().
> 
> But I think just:
> 
>      msg = _("the error");
> 
> And then:
> 
> 	const char *const = pfx = "error: ";
>          const size_t len = strlen(pfx);
> 
> 	write_in_full(2, pfx, len);
>          write_in_full(2, msg, strlen(msg));
> 	write_in_full(2, "\n", 1);
> 
> Makes more sense :)

Agreed, I'll change that.

Best Wishes

Phillip


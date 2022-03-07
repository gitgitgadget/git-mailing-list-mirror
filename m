Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC509C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 11:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239553AbiCGLZE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 06:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241982AbiCGLYr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 06:24:47 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004C66F480
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 02:53:37 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id o18-20020a05600c4fd200b003826701f847so10483007wmq.4
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 02:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+iWGcOgW0mv+6f02ssJExmbZZ+a4hJl3QsZACgUMNqY=;
        b=a6WPasn36afdcEC5TqoiJ2ScSEumPxW39YqPIUvPACf508EanQsrJviW2Yc05wO3KU
         QzGYZHgBGYsr1AB3R6uGJA0TAcdtZe6+y6wTCXBT2jYg2NgsmD84yArlyknAg0AUzvM1
         +5AtumFV0JzyFkXiU6UCXpy+VNVNo6L3m5aW0Oe2VM2QJLUjyDKe1JdkmHDXYVgbMEbF
         eCVW9qd7MuPZSLZKW49UwmgqsqtpncwU79AydOLvr0fmHhX2ihKjZPU1zZguMiFDLnwI
         KxMdA2nRf/A2JO6h2I3VRzBC23Ms6fog15/oH2rFmXyTeUDn5KlJ1VO3w/0fE74A2FNj
         GkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+iWGcOgW0mv+6f02ssJExmbZZ+a4hJl3QsZACgUMNqY=;
        b=zWOmLwwJs0OUTbL0mwpElXZ8qPQwdx5mS7XAnZDALx4jvLcbiRe4m1j57VIfeL20bI
         Os3nhKe9u2rP96FBDvr3DBqVutZGSgn5IydPUS0Hzsa1rouHxbQ6JsjkmqBOSQeiwgbN
         t7uU4XZSKJaBUaHRZRQAYhNQLLMaABTPjBgjKgdjwEiJDDJA+44fzk3Y9MZ8OdkiKZDu
         Tsrcw1nowxTPJZ7/aN1rAdZv4gmn9agZBk+w2/vmYmQBU1OZdD12B+bz2DqEzJLvnjsk
         soMmnIbl6qa5twjl+7qBI0H/TvMDNmkAOrH8k3Xf6UYtkFaQmzrGMl3eFmcXdS+7UTTT
         PZXA==
X-Gm-Message-State: AOAM532wWvtipyFGuoopEenQMnpQOuEVoGl26hd/5NlERUNJomBjAdep
        xcX/6lFqfxTZtbYfjJi+uZw=
X-Google-Smtp-Source: ABdhPJyyoiluwZE7iND2JcIFzUfdp1Tw3PXJr7NumhiEZljHXXpdHh+lcVlujEERwjjmHbB3Y0ONdw==
X-Received: by 2002:a1c:f003:0:b0:37b:d5fc:5c9e with SMTP id a3-20020a1cf003000000b0037bd5fc5c9emr8634639wmb.154.1646650416518;
        Mon, 07 Mar 2022 02:53:36 -0800 (PST)
Received: from [192.168.1.201] (206.2.7.51.dyn.plus.net. [51.7.2.206])
        by smtp.googlemail.com with ESMTPSA id h36-20020a05600c49a400b00382aa0b1619sm12214837wmp.45.2022.03.07.02.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 02:53:35 -0800 (PST)
Message-ID: <8aa11144-c9ce-46aa-2edd-15e8fa1298dc@gmail.com>
Date:   Mon, 7 Mar 2022 10:53:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/4] terminal: restore settings on SIGTSTP
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>, carenas@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20220304131126.8293-1-phillip.wood123@gmail.com>
 <20220304131126.8293-5-phillip.wood123@gmail.com>
 <220305.86bkyk4hwc.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <220305.86bkyk4hwc.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 05/03/2022 13:59, Ævar Arnfjörð Bjarmason wrote:
> [...] 
>>   int save_term(unsigned flags)
>>   {
>> +	struct sigaction sa;
>> +
>>   	if (term_fd < 0)
>>   		term_fd = (flags & SAVE_TERM_STDIN) ? 0
>>   						    : open("/dev/tty", O_RDWR);
>> @@ -44,6 +136,26 @@ int save_term(unsigned flags)
>>   	if (tcgetattr(term_fd, &old_term) < 0)
>>   		return -1;
>>   	sigchain_push_common(restore_term_on_signal);
>> +	/*
>> +	 * If job control is disabled then the shell will have set the
>> +	 * disposition of SIGTSTP to SIG_IGN.
>> +	 */
>> +	sigaction(SIGTSTP, NULL, &sa);
>> +	if (sa.sa_handler == SIG_IGN)
>> +		return 0;
>> +
>> +	/* avoid calling gettext() from signal handler */
>> +	background_resume_msg = xstrdup(_("error: cannot resume in the background"));
>> +	restore_error_msg = xstrdup(_("error: cannot restore terminal settings"));
> 
> You don't need to xstrdup() the return values of gettext() (here _()),
> you'll get a pointer to static storage that's safe to hold on to for the
> duration of the program.

I had a look at the documentation and could not see anything about the 
lifetime of the returned string, all it says is "don't alter it"

> In this case I think it would make sense to skip "error: " from the
> message itself.
> 
> Eventually we'll get to making usage.c have that prefix translated, and
> can have some utility function exposed there (I have WIP patches for
> this already since a while ago).
> 
> To translators it'll look like the same thing, and avoid churn when we
> make the "error: " prefix translatable.

Unless we add a function that returns a string rather than printing the 
message I don't see how it avoids churn in the future. Having the whole 
string with the "error: " prefix translated here does not add any extra 
burden to translators - it is still the same number of strings to translate.

> Aside: If you do keep the xstrdup() (perhaps an xstrfmt() with the above
> advice...) doesn't it make sense to add the "\n" here, so you'll have
> one write_in_full() above?

I decided to keep the translated string simpler by omitting the newline, 
calling write_in_full() twice isn't a bit deal (I don't think the output 
can be split by a write from another thread or signal handler in between).

Best Wishes

Phillip


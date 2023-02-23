Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA57C61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 19:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjBWTtr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 14:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBWTtn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 14:49:43 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95B35DCE5
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 11:49:27 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id c1so14577871plg.4
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 11:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F14ch0Iq1GVQEgwLhXicPFY24368jJBQvfmttetpiUM=;
        b=jyjhy+E+Ff9IxDl/w0+oSxufviArE4djaTQ5jl3+gptIdrICf2XAPd1MdcOus1QWGF
         USFKzfbrneaU4MxvKgSzGK7xcwuBIal1WcYS38KLnK7GhZDn4c4GRy6scx+eGwyvU1Zv
         QGE91ZNBq1vNde7YPu1H9OgC2sMFIkP0aZkxo6vG0IHPucxLr+TGvjfpq1X556tIu7Oz
         NjVnsedYSlZeZpclXLs7LYPEqhByP0H9qs0zyrWqDrexonZYcM6ISx3P4541hLqzwm1E
         nwDK79ocYnks5Bw6tqli5TjlnXOtQRd105Fs08W/y0hNe0+tMIK1uvRg71boRVReelLh
         S2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F14ch0Iq1GVQEgwLhXicPFY24368jJBQvfmttetpiUM=;
        b=AChSGO37e1WRxYbjrK6t6VaoAutmWCncEeCD4sZBXPcxvbYTlCY65c7UFrP3FHWjYT
         PUfG9tAm13b9Eh2uXihTD6xJNLLJH2LelD9X+eR8/F0HTdCSuHEFmADX4R72T6k0s7YG
         stteLxEjPRRx7efxI15e42AUQGKy0SpnkxX93fx77Q4SRCZi2wBZy+wM1xQUAI0jU2Dn
         PJL2P0dUtXqiYq84qB1SzPNZwOGp5LHcm+LuViN0d+7RvmVidwnqbFBejFxOTe6+fQAB
         8zYBeSaV6ArbIW2h93dY43QyWXTOcLEpf4l1kQ+9oNqjvwLpObEH1TUMqDfJDm2OqXyL
         lrKA==
X-Gm-Message-State: AO0yUKV50nBF2pIQM4zqrw/WL+RR1LjJL2PoitP0F/R9cBmwS3Fe1aJt
        USfIupmhlVZuJXNyCQJNwCk=
X-Google-Smtp-Source: AK7set8ScAn51LhZ31hZGW/bw5wNUOYyKd017rryUJc6527Tg7u5nTuewnn2vQO1yBA/jbzJEfJydA==
X-Received: by 2002:a05:6a21:9994:b0:be:b137:9d15 with SMTP id ve20-20020a056a21999400b000beb1379d15mr16274757pzb.36.1677181767208;
        Thu, 23 Feb 2023 11:49:27 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id j18-20020aa78dd2000000b00590ede84b1csm3305044pfr.147.2023.02.23.11.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 11:49:26 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v10 2/3] http: read HTTP WWW-Authenticate response headers
References: <pull.1352.v9.git.1676496846.gitgitgadget@gmail.com>
        <pull.1352.v10.git.1676586881.gitgitgadget@gmail.com>
        <703ac15222fdcfc98751b11af725cc1395134bd1.1676586881.git.gitgitgadget@gmail.com>
        <Y/c1+Llb/D27eWdg@coredump.intra.peff.net>
Date:   Thu, 23 Feb 2023 11:49:26 -0800
In-Reply-To: <Y/c1+Llb/D27eWdg@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 23 Feb 2023 04:46:32 -0500")
Message-ID: <xmqqo7pk6u2h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Alternatively, you could copy the tolower() loop from skip_iprefix().
> Something like:
>   
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 28456241b6..f671a0ec3f 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1296,17 +1296,13 @@ static inline int skip_iprefix_mem(const char *buf, size_t len,
>  				   const char *prefix,
>  				   const char **out, size_t *outlen)
>  {
> -	size_t prefix_len = strlen(prefix);
> -
> -	if (len < prefix_len)
> -		return 0;
> -
> -	if (!strncasecmp(buf, prefix, prefix_len)) {
> -		*out = buf + prefix_len;
> -		*outlen = len - prefix_len;
> -		return 1;
> -	}
> -
> +	do {
> +		if (!*prefix) {
> +			*out = buf;
> +			*outlen = len;
> +			return 1;
> +		}
> +	} while (len-- > 0 && tolower(*buf++) == tolower(*prefix++));
>  	return 0;
>  }
>  
>
> looks right to me, though only lightly tested (via t5563). I'm happy
> with either implementation.

Yeah, the alternative version looks clearer to me.

>> +static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p)
>> [...]
>> +	/*
>> +	 * If this is a HTTP status line and not a header field, this signals
>> +	 * a different HTTP response. libcurl writes all the output of all
>> +	 * response headers of all responses, including redirects.
>> +	 * We only care about the last HTTP request response's headers so clear
>> +	 * the existing array.
>> +	 */
>> +	if (!strncasecmp(ptr, "http/", 5))
>> +		strvec_clear(values);
>
> Since "ptr" isn't NUL terminated, using strncasecmp() may walk off the
> end. I think you'd need to check that there are five bytes. You could
> even use skip_iprefix_mem(), though of course we'd throw away the output
> values. (For strings there is also istarts_with(), but I don't think we
> have a "mem" equivalent).

Yuck, thank you very much for carefully reading.  I missed this one
when I queued it.

> The rest of the parsing looks good to me.

Thanks.

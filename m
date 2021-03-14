Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCDBC433E0
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 17:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF5B564E7C
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 17:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhCNREB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 13:04:01 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:34210 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233530AbhCNRDb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 13:03:31 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id B64D4DB4;
        Sun, 14 Mar 2021 18:03:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1615741407; x=1617555808; bh=POGuVuMtJQxApL4OlDh
        /lyLwMJiVf3Z/lbjXhJ62PmA=; b=c51HR6UgfTtggZIS2pdfNk3fMhqkSckIYS8
        7D2LKa0q9V/FMI5vwvuBH54GmoVHcBg1cSjcFsXaQ+/LcaFiulINggT57S63SfMp
        LWz8VEcNaRU1rW2JuJd1FkyKb24QR9ULi6ju+pEqpHlEfw3EHXjPY24Ra5EhW9Aj
        HRR6BDmsl4APhV10M1NvT3QjTvmNfjLqUVO/pfcgxbuKj23qb18yHTsGVWmB049v
        Zcv/v17E6RGjSXwKhp3fpxDVgVpDZhS8VfIlFfy3vC8whwTsW6a9aJK+YHc0Soz7
        HdLe0xyP7b00aheg4nrVOILbaIbt4wZU5fLhh+AlCuPtdEXJ2/xXs5es8vdURMBn
        qL7mQlCOinsAVQt/Lq1T0Z6Cynk6C+5qKvJkLHXUz9yN5SkC13sglCnAoXjZtPbw
        MF/q/lQrkQzT2Ew0nqh/o4AwbEtvIwC1AZ87yYEqOC2oTCeRPmLNnKrI/8O9/olg
        +Wpv/JasZ6X9udR/QiGT69ysXH884uz5Mg9Mv527KP7AtOcLBC+zqsdsF+sa2nDV
        Vy2sAT6fI27eOhrYL2J4tvX5kp6nUFAjSBs4vWeeJfNcZGp6Rr9dlxmlXI7S+ni8
        vtSJN6Fs6ulUI1413FyimUdkE9V5bT2fsFczV8nJcowDJKWpB8Drwg13/YOidU6C
        07USJMu0=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ooBjEz_Tqruq; Sun, 14 Mar 2021 18:03:27 +0100 (CET)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id E2E71B00;
        Sun, 14 Mar 2021 18:03:26 +0100 (CET)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 9DE93B1D;
        Sun, 14 Mar 2021 18:03:24 +0100 (CET)
Subject: Re: [PATCH 7/7] parse-options: don't leak alias help messages
To:     Jeff King <peff@peff.net>,
        Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Andrzej Hunt <ajrhunt@google.com>
References: <pull.899.git.1615228580.gitgitgadget@gmail.com>
 <fb456bee0f69e0ca5e596b30705c42cc037edecc.1615228580.git.gitgitgadget@gmail.com>
 <YEZ/BWWbpfVwl6nO@coredump.intra.peff.net>
From:   Andrzej Hunt <andrzej@ahunt.org>
Message-ID: <6ddb4ca3-8486-a8cf-24ed-1ae6220602f3@ahunt.org>
Date:   Sun, 14 Mar 2021 18:03:22 +0100
MIME-Version: 1.0
In-Reply-To: <YEZ/BWWbpfVwl6nO@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/03/2021 20:46, Jeff King wrote:
> On Mon, Mar 08, 2021 at 06:36:20PM +0000, Andrzej Hunt via GitGitGadget wrote:
> 
>> +static void free_preprocessed_options(const struct option ** preprocessed_options, const struct option *original_options)
> 
> A few style nits:
> 
>    - omit the space between "**" and preprocessed_options
> 
>    - we'd usually break a long line (after the first parameter comma)
> 
> I think preprocessed_options shouldn't be const here. After all, our aim
> is to free it! I'm also not sure why it's a pointer-to-pointer. If we
> were setting it to NULL after freeing, that would be valuable, but we
> don't. So all together >
>    static void free_preprocessed_options(struct option *preprocessed_options,
>                                          const struct option *original_options)

I'm not sure what I was originally thinking when I used the 
pointer-to-pointer - I've incorporated your suggestions, they do make 
everything easier to read. Moreover we'll remove original_options as per 
your later suggestions anyway.

> 
>> +	for (i = 0; original_options[i].type != OPTION_END; i++) {
>> +		if (original_options[i].type == OPTION_ALIAS) {
>> +			free((void *)(*preprocessed_options)[i].help);
>> +		}
>> +	}
> 
> OK, so we look through the original options to find ones that became an
> alias, and then free them. Makes sense.
> 
> Do the indexes always correspond between the original and the
> preprocessed arrays? I _think_ so, but preprocess_options() is a little
> hard to follow.
> 
> If the preprocess code set a flag in the resulting option, though, we
> could make it much more obviously correct. And avoid having to pass
> original_options at all.

_At this time_, indexes always correspond between the original and 
preprocessed options, but in the back of my mind I was still a little 
bit uncomfortable depending on that. Your suggestion is much better - so 
I've gone ahead and implemented it.

> 
>> +	free((void *)*preprocessed_options);
> 
> With the interface suggestions above, this becomes just:
> 
>    free(preprocessed_options);
> 
>> @@ -838,15 +855,17 @@ int parse_options(int argc, const char **argv, const char *prefix,
>>   		  int flags)
>>   {
>>   	struct parse_opt_ctx_t ctx;
>> -	struct option *real_options;
>> +	const struct option *preprocessed_options, *original_options = NULL;
>>   
>>   	disallow_abbreviated_options =
>>   		git_env_bool("GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS", 0);
>>   
>>   	memset(&ctx, 0, sizeof(ctx));
>> -	real_options = preprocess_options(&ctx, options);
>> -	if (real_options)
>> -		options = real_options;
>> +	preprocessed_options = preprocess_options(&ctx, options);
>> +	if (preprocessed_options) {
>> +		original_options = options;
>> +		options = preprocessed_options;
>> +	}
> 
> OK, we have to keep two variables now rather than aliasing "options",
> because we need the original for feeding to the free function (but this
> hunk too would go away if we set a flag).

Indeed - after adding the flag as suggested, the changes to 
parse_options() are reduced down to calling free_preprocessed_options() 
instead of free() - which is quite a nice simplification.

> 
> To spell it out, I mean something like on the writing side:
> 
> diff --git a/parse-options.c b/parse-options.c
> index fbea16eaf5..43431b96b1 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -678,6 +678,7 @@ static struct option *preprocess_options(struct parse_opt_ctx_t *ctx,
>   			newopt[i].short_name = short_name;
>   			newopt[i].long_name = long_name;
>   			newopt[i].help = strbuf_detach(&help, NULL);
> +			newopt[i].flags |= PARSE_OPT_FROM_ALIAS;
>   			break;
>   		}
>   
> diff --git a/parse-options.h b/parse-options.h
> index ff6506a504..32b0b49a2d 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -47,7 +47,8 @@ enum parse_opt_option_flags {
>   	PARSE_OPT_SHELL_EVAL = 256,
>   	PARSE_OPT_NOCOMPLETE = 512,
>   	PARSE_OPT_COMP_ARG = 1024,
> -	PARSE_OPT_CMDMODE = 2048
> +	PARSE_OPT_CMDMODE = 2048,
> +	PARSE_OPT_FROM_ALIAS = 4096,
>   };
>   
>   enum parse_opt_result {
> 
> (as an aside, these manual bitfield values are tedious; I wouldn't be
> sad to see them converted to "1 << 0", "1 << 1", and so on).

I've added a separate patch to take care of the bitfield improvements - 
and have incorporated the PARSE_OPT_FROM_ALIAS change into the original 
patch!



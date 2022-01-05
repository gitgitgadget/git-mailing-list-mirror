Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B563C433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 11:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbiAELVX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 06:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239648AbiAELVT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 06:21:19 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6137C061761
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 03:21:18 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id j18so82255159wrd.2
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 03:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iTWAfALBuFk2QvUt+hN0qgaxsDSKJPIfkse7PWYJM1k=;
        b=bJJhKtH6mhifdDgbeGrnq6KTOik/cmE/hNm9u467kOuo7fF88N7Yy3sEIUipezWwjw
         pyOZjvOb20a3ff8XtkDI6IRkWm8vce/qgH4RRUOkpl/65mu2nOhQ3vj8PlxWSDEMxHw2
         /nxn0yCvUh3bRrt9TECas3FiLKoObQkkn0I7jg3AaqYuoVgYXPSL4pGE72jRgbXbkfci
         hCiTRyjxF4utqr3iwT/g0g/1J5lY3mTCz1NVWMaYk0n4QwOhw0XRLwXPxHIVm23EqR+6
         WmyAwMo/0pY6KFpEDMrDsx1xqEXPh6EHWoaCGQyw/RVZB8VpFV1UpVK2AHePjGZ3UfEi
         9y8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iTWAfALBuFk2QvUt+hN0qgaxsDSKJPIfkse7PWYJM1k=;
        b=b0ZlN4cRN6HaLnMaaG4KIJtcK1lJ0sJJmhRJdfgREom8uMw5TrMZZZilzaNKiXJ3Cp
         mcD7RzhEHQLe953VVkPZSkYVvwqtI0OFaulyaJwCl0xEcd9tgvuE76fNcZImxQZHZhFT
         5J6yDV2VW+6mTJG+/5w4is/cO3zCMfejtDUO43RcrJnS+097bqjITenHWNbRIA7A2Q5H
         VeE2Ec9wND0TG4EYqz6IIMrwSzJQ2Mr4tsBAveg0Bg3CiXUno0AYin7E52DhKWxfd96M
         jf+z6OmXuBvAhljjtWDYN/8ncgwAcVqAZC+MKzuR+mZv85rSOiSXvwg+u/tYaNMOHgam
         CSvg==
X-Gm-Message-State: AOAM533UDyCFYwTSU9f/iKmO5vpb9PHxpQele/YKHbZKwM9bMHw+W7jw
        jt+ROfr8lCOoOkyUqB3ZD/KZoVyX8Ak=
X-Google-Smtp-Source: ABdhPJw/+GHPwi8Vrt4W8lDyl+PYoK61Pw0C94JnbSxgEa9sLedDJkfXkMQAtwq6x1qNSTexyWP++Q==
X-Received: by 2002:a5d:6da3:: with SMTP id u3mr43494096wrs.712.1641381677503;
        Wed, 05 Jan 2022 03:21:17 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id c2sm45446842wri.50.2022.01.05.03.21.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 03:21:17 -0800 (PST)
Message-ID: <9e36813e-2573-35c9-442c-f5a06fa6a739@gmail.com>
Date:   Wed, 5 Jan 2022 11:21:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/1] builtin/pull.c: use config value of autostash
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>
Cc:     git@vger.kernel.org, Tilman Vogel <tilman.vogel@web.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
References: <20220104214522.10692-1-johncai86@gmail.com>
 <20220104214522.10692-2-johncai86@gmail.com> <xmqqbl0r9l0l.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqbl0r9l0l.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John and Junio

On 04/01/2022 22:46, Junio C Hamano wrote:
> John Cai <johncai86@gmail.com> writes:
> 
>> diff --git a/builtin/pull.c b/builtin/pull.c
>> index 100cbf9fb8..fb700c2d39 100644
>> --- a/builtin/pull.c
>> +++ b/builtin/pull.c
>> @@ -86,7 +86,8 @@ static char *opt_ff;
>>   static char *opt_verify_signatures;
>>   static char *opt_verify;
>>   static int opt_autostash = -1;
>> -static int config_autostash;
>> +static int rebase_autostash = 0;
>> +static int cfg_rebase_autostash;
> 
> Do not explicitly initialize statics to '0' (or NULL for that matter).
> 
> But more importantly, I have a feeling that you are making a piece
> of code that is already hard to read impossible to follow by adding
> yet another variable.
> 
>> diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
>> index 66cfcb09c5..28f551db8e 100755
>> --- a/t/t5521-pull-options.sh
>> +++ b/t/t5521-pull-options.sh
>> @@ -251,5 +251,56 @@ test_expect_success 'git pull --no-verify --verify passed to merge' '
>>   	test_commit -C src two &&
>>   	test_must_fail git -C dst pull --no-ff --no-verify --verify
>>   '
>> +test_expect_success 'git pull --rebase --autostash succeeds on ff' '
> 
> Missing blank line between tests.
> 
> 
> I thought that the root cause of the problem is that run_merge() is
> called even when rebase was asked for (either via pull.rebase=true
> configuration or "pull --rebase" option), when the other side is a
> descendant of HEAD.  The basic idea behind that behaviour may be
> sound (i.e. if we do not have any of our own development on top of
> their history, rebase vs merge shouldn't make any difference while
> fast-forwarding HEAD to their history), except that rebase vs merge
> look at different configuration variables.
> 
> I wonder if the following two-liner patch is a simpler fix that is
> easier to understand.  run_merge() decides if we should pass the
> "--[no-]autostash" option based on the value of opt_autostash, and
> we know the value of rebase.autostash in config_autostash variable.
> 
> It appears to pass all four tests your patch adds.

I think this is a better approach - it's simpler and it is clear that we 
only use rebase.autostash when a rebase was requested.

Best Wishes

Phillip

>   builtin/pull.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git c/builtin/pull.c w/builtin/pull.c
> index 100cbf9fb8..d459a91a64 100644
> --- c/builtin/pull.c
> +++ w/builtin/pull.c
> @@ -1133,7 +1133,14 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>   			die(_("cannot rebase with locally recorded submodule modifications"));
>   
>   		if (can_ff) {
> -			/* we can fast-forward this without invoking rebase */
> +			/*
> +			 * We can fast-forward without invoking
> +			 * rebase, by calling run_merge().  But we
> +			 * have to allow rebase.autostash=true to kick
> +			 * in.
> +			 */
> +			if (opt_autostash < 0)
> +				opt_autostash = config_autostash;
>   			opt_ff = "--ff-only";
>   			ret = run_merge();
>   		} else {
> 


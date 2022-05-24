Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7001C433FE
	for <git@archiver.kernel.org>; Tue, 24 May 2022 20:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241431AbiEXUOP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 16:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238992AbiEXUOM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 16:14:12 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D3282165
        for <git@vger.kernel.org>; Tue, 24 May 2022 13:14:11 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 14so9763148qkl.6
        for <git@vger.kernel.org>; Tue, 24 May 2022 13:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OjlnOaQWmt5xiFQO49cQmpyl1W86/2hPeHLowDRBYi4=;
        b=Uk3l+PvFAMSUfGNCJACvfU7rvVpb+E8UpwZnu7MXnTstNrjhuhcKIU7mNz7p+8d4Iu
         Fa3lmnCcJfVeVE+gs5ou8pwClrWXj9m20jwa8ffDCUYzSIspsxARwxFL4Hl18RFQqemI
         Jf6gN+W9wwqtxWNIfuGsRLLYjyY866cn+L+mle+cvEi4viHxNai4ixYex5cGqaH/OVvV
         boWfjMb1IFGhkvaEFoPv11cTvL511IZDjmT28UL8VKclqPcml5HsG/H0HnSI/juN6aFQ
         28f/zVKXXYT3mDHR1IKcLVWmSj4gp9z3N4FSXAlWrU/ZpeFFCKXaH0u8c4dys2KSTVAb
         rFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OjlnOaQWmt5xiFQO49cQmpyl1W86/2hPeHLowDRBYi4=;
        b=mSCcCzQxUum7RZ8clK1ma9S6L8uGP52ZW1B3QOiunSWJr+To+2pHSBKvJ1Qi8NhUQE
         anqBYc/L7RLZA9TmjmLZYWv0NfUubM1mtcgFZxVOEUtei2eaMaKpsFpwhXan5o3CaHiS
         MiuYvhuNTjK2KRbQbBpw87Y4DyJEGQyFOzPhguya2AEm+o+cEuvWikJaWaPQ4vC4Agtw
         6UBdDlEDWrXA7J9ZoS/QgFdEPtwmzMEErJF4eQZ/oOs/vFffcfGtcUoYJfMFn+Mb7Hf8
         pbPFV0ULjnuXz2n3wfU7Gee0DilKdQUygbPi3/EuRMx7IaZbmX51ParsNOujpggbHgft
         yUHw==
X-Gm-Message-State: AOAM530BNduPOepFXhqQC0jg9KvrWk1i+0iynvNnpik0VIKGRUTcKSp5
        p9hIL2A/OYiUajf2chMUCvUw
X-Google-Smtp-Source: ABdhPJy7GZVfk2Vp2D1P1ibGeuS5F4Px/Ft0Gcrf2eOPRSJS48FNWMNPv2PENbgyEEBr7tam+DiJtg==
X-Received: by 2002:a05:620a:2848:b0:67d:35de:bb5b with SMTP id h8-20020a05620a284800b0067d35debb5bmr18321098qkp.499.1653423250031;
        Tue, 24 May 2022 13:14:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:9dd7:2c4b:2dbd:828e? ([2600:1700:e72:80a0:9dd7:2c4b:2dbd:828e])
        by smtp.gmail.com with ESMTPSA id c186-20020ae9edc3000000b006a37eb728cfsm127505qkg.1.2022.05.24.13.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 13:14:09 -0700 (PDT)
Message-ID: <9318a400-479f-4029-c10b-3bfe498fcbb7@github.com>
Date:   Tue, 24 May 2022 16:14:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] urlmatch: create fetch.credentialsInUrl config
Content-Language: en-US
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        avarab@gmail.com, christian.couder@gmail.com, jrnieder@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Coup <robert.coup@koordinates.com>
References: <pull.1237.git.1653329044940.gitgitgadget@gmail.com>
 <xmqqr14kqdag.fsf@gitster.g>
 <7495dac8-0241-ad56-59e3-100673c88c52@github.com>
 <nycvar.QRO.7.76.6.2205241343390.352@tvgsbejvaqbjf.bet>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <nycvar.QRO.7.76.6.2205241343390.352@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/24/2022 7:46 AM, Johannes Schindelin wrote:
> Hi Stolee,
> 
> On Mon, 23 May 2022, Derrick Stolee wrote:
> 
>> On 5/23/2022 3:06 PM, Junio C Hamano wrote:
>>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>
>>>> +static void detected_credentials_in_url(const char *url, size_t scheme_len)
>>>> +{
>>>> +	char *value = NULL;
>>>> +	const char *at_ptr;
>>>> +	const char *colon_ptr;
>>>> +	struct strbuf anonymized = STRBUF_INIT;
>>>> +
>>>> +	/* "ignore" is the default behavior. */
>>>> +	if (git_config_get_string("fetch.credentialsinurl", &value) ||
>>>> +	    !strcasecmp("ignore", value))
>>>> +		goto cleanup;
>>>> +
>>>> +	at_ptr = strchr(url, '@');
>>>> +	colon_ptr = strchr(url + scheme_len + 3, ':');
>>>
>>> We expect that at_ptr would come after colon_ptr (i.e. in
>>> "scheme://<u>:<p>@host", no @ exists in <u> or <p> part) and the
>>> while() loop below assumes that for redacting.
> 
> Careful here. https://me@there.com:9999/ _is_ a valid URL, too.

Thanks for checking. The method should not be called unless the
password region was already detected. I'll add a BUG() statement and
a comment to prevent future callers from providing incorrect URLs.

I can also add a test to show that this warning is not output when
the only colon is for the port number.
 
>>> Are we better off if we assert it here, or has the calling parser
>>> already rejected such cases?
>>
>> This computation of at_ptr matches the one in url_normalize_1(),
>> so it at least agrees about where the "username[:password]" section
>> could be. That does mean that the password cannot contain an "@"
>> symbol (unless it is special-cased somehow?).
> 
> The password cannot contain a literal `@`, and neither can the user name.
> They have to be URL-encoded, via `%40`.

Thanks!
-Stolee

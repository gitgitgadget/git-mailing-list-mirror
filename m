Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBBEC433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 18:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346154AbiETSFN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 14:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237434AbiETSFM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 14:05:12 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C4C18C047
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:05:11 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id t2so6015735ilm.13
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+kkW1+0zRgKZP1s2AAkHyQYYah6STSl09lUhQENlpus=;
        b=Mo/uA+iG1bVgq4TtxyzXC4hb1gB4qOeEdYr3lm/kJ9H6wxsAEwboNyjft5uTBFnhfy
         /0DcyrXFBlTrlck5qjUyus0tD9CNCLrYVJKhytW1X6HFmM9Wzya9uO8Oy7u53OuSRnY4
         UkLI/BicHkR6qboWkuUXz+ltjrdZWDlDFa6v/7O+5lL1qXycC/gZoiZQfQ6CAfBCNE5V
         hpvIpbNqFt9KbwUCs5xeNMfDUwy4Ro5xxHKb5b0pa0F2zW8jGRzFtzcw8+12tIL9PmbA
         iJ8rHJfWz/4KvHDlmmX6WRNEiMehkgSl/lzWKFtvE1d1bphyE0t3siGPtZo5/kfPjREz
         EwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+kkW1+0zRgKZP1s2AAkHyQYYah6STSl09lUhQENlpus=;
        b=AbEXvqoqa0kSx7lzQ3kYakmmnFiDsdsizYyU6zktpwznlEbz9dmqsZls6Vd7tYPRxl
         wtz8jVpaB8cGbgQJ25TdVDWClilbrVKwsdG4nglJGpttnBkGm8IHhXXvoRCJuYaSr036
         fM3FT62FZK9nseq99dLn03M5oC4DR6P9D3ofpxCS3REyIBQtcxTQqTmcWWDE45mPIzOT
         rZFNAPnuo3EBoyo7ydFyEhqP40rYsJmTd1BDjvh9RsiwULUxTErSHlZNFN6msLsmhm+N
         NWVFn1rmZGZGsuFT8akoajBoz3JL+YCw62H6CaSHltwHProMit4fElyW2AH2pOvcyJFp
         0gBg==
X-Gm-Message-State: AOAM5321OsKzPwm/Um1RyOCI6k4pPPNJDeSL+v4FdZDf7mZPooTRB2IC
        y4tvQh+2LxqY476o8+B5OV83+LDLcMvv
X-Google-Smtp-Source: ABdhPJzCMTCDvQAwjSwgzctmiPZZCPApRLKx7UbsK10+f6IryeMwnPvoa0OUrqWDfKe/TE84tl23MQ==
X-Received: by 2002:a05:6e02:19cd:b0:2ce:ff0d:b8b7 with SMTP id r13-20020a056e0219cd00b002ceff0db8b7mr5977506ill.189.1653069910884;
        Fri, 20 May 2022 11:05:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:34b9:84ab:204:3752? ([2600:1700:e72:80a0:34b9:84ab:204:3752])
        by smtp.gmail.com with ESMTPSA id z17-20020a92d191000000b002d138bd0d2asm2094171ilz.21.2022.05.20.11.05.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 11:05:10 -0700 (PDT)
Message-ID: <0b2215e1-7f12-ed0d-b7bf-03648b19e30a@github.com>
Date:   Fri, 20 May 2022 14:05:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 04/10] sparse-index: introduce partially-sparse indexes
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
 <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
 <269c206c331bb43006678beaa20832a75754c3df.1652982758.git.gitgitgadget@gmail.com>
 <xmqqleuxmgof.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqleuxmgof.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/19/2022 4:05 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +enum sparse_index_mode {
>> +	/*
>> +	 * COMPLETELY_FULL: there are no sparse directories
>> +	 * in the index at all.
>> +	 */
>> +	COMPLETELY_FULL = 0,
> 
> Two things that make me wonder are:
> 
>  * Do concrete values assigned to these symbols matter?  If we do
> 
> 	if (some_function_that_returns_this_type())
> 		/* ok, we know it is full */
> 		do_full_thing();
> 
>    then the answer is yes.  If we write these values to on-disk
>    file, and other versions and reimplementations of Git need to
>    know the concrete values, then the answer is yes.  Otherwise, we
>    may not want to say "= 0" and the like here.

The = 0 case matters because that is the default when the index
struct is initialized to zero. The other values are not important.
 
>  * Is it worth repeating the label in the comment?  IOW, I am
>    wondering if
> 
> 	/* there are no sparse directories in the index */
> 	COMPLETELY_FULL,
> 
>    is equally readable and slightly more maintainable.

Can do.

> Also these names being in cache.h and visible everywhere is somewhat
> worrying.  Other CPP macros and enum constants in the file have
> names that are prepared to be truly global, but COMPLETELY_FULL and
> COLLAPSED do not hint that they are about sparse-index state as
> strongly as PARTIALLY_SPARSE does.

Would prepending with "INDEX_" be sufficient?

>> -		 /*
>> -		  * sparse_index == 1 when sparse-directory
>> -		  * entries exist. Requires sparse-checkout
>> -		  * in cone mode.
>> -		  */
>> -		 sparse_index : 1;
>> +		 fsmonitor_has_run_once : 1;
>> +	enum sparse_index_mode sparse_index;
> 
> Good that we can lose the comment on a single bit.  Are some of the
> enum sparse_index_mode values only possible in cone mode, just like
> having true in this bit was only possible in cone mode?  Perhaps a
> comment before "enum sparse_index_mode {" can say "in non-cone mode,
> COMPLETELY_FULL is the only possible value" or somesuch?

I can add that comment for the COMPLETELY_FULL enum value.

Thanks,
-Stolee

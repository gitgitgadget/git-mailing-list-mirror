Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD67C433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 16:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238003AbiB1Qon (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 11:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237990AbiB1Qol (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 11:44:41 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39520694BB
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 08:44:02 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id h13so13386527qvk.12
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 08:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FmEL3X3FMLJ4StgK5z2qIBuxnY7dONzQbsELJluQi1I=;
        b=ft15jYoUOxwBwSGTnqQVQL4RBnTdq4LA+yZjVC85sbgn9wpAivpVpI9JJlQ7+clRFk
         2tcv8I2LgO5hpLFdx8TSp28GkL9rMwJDcG7pSPplPHc0tx+O0I1pNJwYDl01jByePAYv
         A6hS5LFVvorj9WWY7LyVol82mH6X9w1pPor7ER7uWgCMf7V1z87tFayK1/KUIqYT0oLx
         iHpT+Wh647N0Cvvew+JVFk9zaPWl2ujMVwUB6zpxUkkmo6QKoFCREG4sTqG7Kc5vzL/t
         lu2G6fFhzRMPnkrJ1u/tOs4I9nKxAK5JTwCXBgB+mboFP26P3aDWIw7EmxW25jNqwEmU
         oTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FmEL3X3FMLJ4StgK5z2qIBuxnY7dONzQbsELJluQi1I=;
        b=7jJ8LANekERtGOuuyMBnNxL1rTa0oQpHrJlk9KfgiBP5/xjaW6MYRFXrOunauBh23S
         rjr/h2/QDivKmYQU7dEvt9XExHtZTMA3MbrcgFfBR/XpYRQcRlTUE25aXEoCggYjtBQm
         cRPJt1kVdpT281A0geDAaTzegc1BIcy2Ko5WqAG/gEX7f+fgkMsDfoGvn42Ywzti/wiT
         M/6ViJUlL0OXaqDHTlt/cvugy1tESZwHAKWMymWDbBwT/LPJ45OOtWlAkmO79u15BLn2
         dDJcH44qY6HGpJyp4sVT1T6SsH5TdTHdVQhTyemnPP9lnJ2vKT0/zFXpq1Y3jdmOixNY
         Hesg==
X-Gm-Message-State: AOAM530aTFWt6xYRPiYwW9raFoE2186ZBElLbBiPT9NfNFHeNDY6Egu/
        Gf05FWshahe2BZZjItpLqlyI
X-Google-Smtp-Source: ABdhPJwc5TS8qNih/8II5gAn9KBCWKWaQrnxgRab+3PHb6KDpWziyXfniYoR1Jr5mXs75+ZovJP3Eg==
X-Received: by 2002:ac8:5813:0:b0:2de:15ef:8bab with SMTP id g19-20020ac85813000000b002de15ef8babmr17090128qtg.515.1646066641323;
        Mon, 28 Feb 2022 08:44:01 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id de18-20020a05620a371200b00662cf4b5631sm3256859qkb.23.2022.02.28.08.44.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 08:44:01 -0800 (PST)
Message-ID: <b65f405e-665b-ae32-aa4e-7dbdc874485d@github.com>
Date:   Mon, 28 Feb 2022 11:43:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 3/4] commit-graph: start parsing generation v2 (again)
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        abhishekkumar8222@gmail.com
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
 <pull.1163.v2.git.1646056423.gitgitgadget@gmail.com>
 <5bc6a7660d897ca6c52eabba8fb9ecfb6304dabb.1646056423.git.gitgitgadget@gmail.com>
 <220228.86czj73sre.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220228.86czj73sre.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/28/2022 10:30 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Feb 28 2022, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>> [...]
>> +	GENERATION_VERSION=2
>> +	if test ! -z "$3"
> 
> TIL this works somewhere :)
> 
> I thought it *might* be unportable behavior (but didn't check at
> first), but it's not! We have a few such cases already.
> 
> But IMO much less puzzling would be at least:
> 
>     if ! test -z "$3"
> 
> Or in this case, more plainly:
> 
>     if test -n "$3"

Sure, that makes sense.

>> +	then
>> +		GENERATION_VERSION=$3
>> +	fi
>> +	OPTIONS=
>> +	if test $GENERATION_VERSION -gt 1
>> +	then
>> +		OPTIONS=" read_generation_data"
>> +	fi
> 
> Or actually, since we don't use $GENERATION_VERSION further down setting
> it to a default etc. here seems a bit odd. Perhaps something closer to:
> 
>     if test $# -eq 3 && test $3 -gt 1
> 
> It's also possible to be more clever as e.g.:
> 
>     test "${3:-2}" -gt 1
> 
> But that hardly seems worth it...

I prefer to use a variable so the code is self-documenting.

>>  NUM_COMMITS=9
>> diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
>> index 778fa418de2..669ddc645fa 100755
>> --- a/t/t5324-split-commit-graph.sh
>> +++ b/t/t5324-split-commit-graph.sh
>> @@ -30,11 +30,16 @@ graph_read_expect() {
>>  	then
>>  		NUM_BASE=$2
>>  	fi
>> +	OPTIONS=
>> +	if test -z "$3"
>> +	then
>> +		OPTIONS=" read_generation_data"
>> +	fi
>>  	cat >expect <<- EOF
>>  	header: 43475048 1 $(test_oid oid_version) 4 $NUM_BASE
>>  	num_commits: $1
>>  	chunks: oid_fanout oid_lookup commit_metadata generation_data
>> -	options:
>> +	options:$OPTIONS
>>  	EOF
>>  	test-tool read-graph >output &&
>>  	test_cmp expect output
> 
> Not a new issue, but it would be nice to have the mostly copy/pasted
> code in a lib-commit-graph.sh or something, but probably too distracting
> for this small series...

These cases are different enough in the needs of the test files
that they cannot be shared without significant complication.

Thanks,
-Stolee

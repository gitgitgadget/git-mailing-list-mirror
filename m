Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58A3620A27
	for <e@80x24.org>; Mon, 18 Sep 2017 13:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754362AbdIRNuC (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 09:50:02 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:52144 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754016AbdIRNuA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 09:50:00 -0400
Received: by mail-qk0-f174.google.com with SMTP id c69so543482qke.8
        for <git@vger.kernel.org>; Mon, 18 Sep 2017 06:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xvem56/YBizkD5jUTbWPB9k9/6vn5m8r0g7lYdJuYKs=;
        b=XPSvqsn+BMGFcEU+a9nBdX8r423f2//th/8ffOijfij3JpPcT5w3IazxLpuQ1DKqMe
         RUzgAenYEZUEO/PlaQcbnPm4fIpFxApuduuoDFxGbqQ4lCfFZs9bHO2VaXYFqYNLIMLa
         OqOOgz5wLiNu8uTwJf0yqM0s2EyFZeOyEg4gk+fmTq13H8IQNEFQ7HLmDzqGK+N/1ldX
         GwXAllVhMZuvO/HYAkljZVepV5/FvTLe30AygXfKo+k4h8VHcEF6m7urku6DJiL6KbWg
         diPKXWOqdSIePOU8/BZf6j3XQFcBum+TOzKBFaMkhCOWYByZ880+THL9E2RkJ/xPWxKy
         dL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xvem56/YBizkD5jUTbWPB9k9/6vn5m8r0g7lYdJuYKs=;
        b=Bg0sUJL2glc5WIOkcci3oUuOPnAmZY13tmuLVexmhk83C6UiD928FXLopGbS9N9pAP
         B0EL5bS9JF5OfdjoUO7BGlGk6Gxh/xcODkHlduUnXTg73E7qAYT3d3c/tfxKeX1ha5DW
         X3U9hL3NocO6/lrviOkgxbN6XRWqI0yc/q6V4vbTd+MfAVVZ8pUlY6AYyZwEWH16+zx7
         mrax4o1buOB5q+LMPbGPn3BAL5/VhrGTLif0AiFFiSpXxFTt6CEiyL4uv09qfaXDyRbS
         fjg977xtwRBLltwWSXLylsxA/OdBw4ElHYXxeh7o0ZjWyf37w5zN5PadIrn8Frmmj2Yz
         dKWw==
X-Gm-Message-State: AHPjjUjUyWw05y6lY3BUrOWjxq5nxyDeKT2+XhaWaoKNos+WW6zFHBIF
        mJyOr0lSEq8lqQ==
X-Google-Smtp-Source: AOwi7QAYLZbwZljf99oH7pNUG2gUekANQF8lDVaRvnZMcAL+eKmo9IvrWecKXupe/WXVmX2QwVHuew==
X-Received: by 10.233.237.7 with SMTP id c7mr20963520qkg.69.1505742599882;
        Mon, 18 Sep 2017 06:49:59 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id t90sm5168627qkl.77.2017.09.18.06.49.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Sep 2017 06:49:59 -0700 (PDT)
Subject: Re: [PATCH v6 04/12] fsmonitor: teach git to optionally utilize a
 file system monitor to speed up detecting new or changed files.
To:     David Turner <David.Turner@twosigma.com>,
        'Ben Peart' <benpeart@microsoft.com>
Cc:     "avarab@gmail.com" <avarab@gmail.com>,
        "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "peff@peff.net" <peff@peff.net>
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170915192043.4516-1-benpeart@microsoft.com>
 <20170915192043.4516-5-benpeart@microsoft.com>
 <850c2ad20acc4c14be87a767af851b19@exmbdft7.ad.twosigma.com>
 <3e0d003e-0643-0359-35fd-a5ecf9b751c3@gmail.com>
 <1f095732aec2469f86a7018aa9f1f8ec@exmbdft7.ad.twosigma.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <36e55efe-b5d0-b7f3-50d2-600771235327@gmail.com>
Date:   Mon, 18 Sep 2017 09:49:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1f095732aec2469f86a7018aa9f1f8ec@exmbdft7.ad.twosigma.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/18/2017 9:32 AM, David Turner wrote:
>> -----Original Message-----
>> From: Ben Peart [mailto:peartben@gmail.com]
>> Sent: Monday, September 18, 2017 9:07 AM
>> To: David Turner <David.Turner@twosigma.com>; 'Ben Peart'
>> <benpeart@microsoft.com>
>> Cc: avarab@gmail.com; christian.couder@gmail.com; git@vger.kernel.org;
>> gitster@pobox.com; johannes.schindelin@gmx.de; pclouds@gmail.com;
>> peff@peff.net
>> Subject: Re: [PATCH v6 04/12] fsmonitor: teach git to optionally utilize a file
>> system monitor to speed up detecting new or changed files.
>>
>> Thanks for taking the time to review/provide feedback!
>>
>> On 9/15/2017 5:35 PM, David Turner wrote:
>>>> -----Original Message-----
>>>> From: Ben Peart [mailto:benpeart@microsoft.com]
>>>> Sent: Friday, September 15, 2017 3:21 PM
>>>> To: benpeart@microsoft.com
>>>> Cc: David Turner <David.Turner@twosigma.com>; avarab@gmail.com;
>>>> christian.couder@gmail.com; git@vger.kernel.org; gitster@pobox.com;
>>>> johannes.schindelin@gmx.de; pclouds@gmail.com; peff@peff.net
>>>> Subject: [PATCH v6 04/12] fsmonitor: teach git to optionally utilize
>>>> a file system monitor to speed up detecting new or changed files.
>>>
>>>> +int git_config_get_fsmonitor(void)
>>>> +{
>>>> +	if (git_config_get_pathname("core.fsmonitor", &core_fsmonitor))
>>>> +		core_fsmonitor = getenv("GIT_FSMONITOR_TEST");
>>>> +
>>>> +	if (core_fsmonitor && !*core_fsmonitor)
>>>> +		core_fsmonitor = NULL;
>>>> +
>>>> +	if (core_fsmonitor)
>>>> +		return 1;
>>>> +
>>>> +	return 0;
>>>> +}
>>>
>>> This functions return values are backwards relative to the rest of the
>> git_config_* functions.
>>
>> I'm confused.  If core.fsmonitor is configured, it returns 1. If it is not
>> configured, it returns 0. I don't make use of the -1 /* default value */ option
>> as I didn't see any use/value in this case. What is backwards?
> 
> The other git_config_* functions return 1 for error and 0 for success.

Hmm, I followed the model (ie copy/paste :)) used by the tracked cache. 
If you look at how it uses, the return value, it is 0 == false == remove 
the extension, 1 == true == add the extension.  I'm doing the same with 
fsmonitor.

static void tweak_untracked_cache(struct index_state *istate)
{
	switch (git_config_get_untracked_cache()) {
	case -1: /* keep: do nothing */
		break;
	case 0: /* false */
		remove_untracked_cache(istate);
		break;
	case 1: /* true */
		add_untracked_cache(istate);
		break;
	default: /* unknown value: do nothing */
		break;
	}
}

void tweak_fsmonitor(struct index_state *istate)
{
	switch (git_config_get_fsmonitor()) {
	case -1: /* keep: do nothing */
		break;
	case 0: /* false */
		remove_fsmonitor(istate);
		break;
	case 1: /* true */
		add_fsmonitor(istate);
		break;
	default: /* unknown value: do nothing */
		break;
	}
}

> 
>>> [snip]
>>>
>>> +>	/*
>>> +>	 * With fsmonitor, we can trust the untracked cache's valid field.
>>> +>	 */
>>>
>>
>> Did you intend to make a comment here?
> 
> Sorry.  I was going to make a comment that I didn't see how that could work
> since we weren't touching the untracked cache here, but then I saw the bit
> further down.   I'm still not sure it works (see comment on 10/12), but at
> least it could in theory work.
>   
> 

The logic here assumes that when the index is written out, it is valid 
including the untracked cache and the CE_FSMONITOR_VALID bits. 
Therefore it should still all be valid as of the time the fsmonitor was 
queried and the index saved.

Another way of thinking about this is that the fsmonitor extension is 
simply adding another persisted bit on each index entry.  It just gets 
persisted/restored differently than the other persisted bits.

Obviously, before we can use it assuming it reflects the *current* state 
of the working directory, we have to refresh the bits via the refresh logic.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC40C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 21:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiKHV2g (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 16:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiKHV2e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 16:28:34 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F746B88
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 13:28:32 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id k8so23030021wrh.1
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 13:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l4+Te7fPnfdW/Lwrtyi3L4OKTU8ZTrFglzhlTyrSD50=;
        b=CuhRoG7XUXdjgUQI2INYVN61AFMEx7NIht+Wxqr9KTUNFv8D4Brc21CjSPAWmbRIVx
         MxCCwyQszEapFpGSkXt6XL0FfwTg9Ig0xnRtmQXkGbx/Ls8C5VN/XDJn1aKqD9vLD4UB
         mSi1z+pFbZ1s+5MPsv0UDe14AaNZEE4JZDjsB1in1wpCQztF8cw+0p/PouXo7FAuughj
         39GePofHLetJy4Ic6y18ed3YD5loZ8yaO2qIp48IU7TYxBXTG13HE4YCMyRrWbuLEAac
         pZ6U49hfrRbK2SdqGdZggjvlSTOfFVLWntDZ1ub7MJ5D/6oQXFO3/GPvf241zHFKIRJ+
         7Yew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4+Te7fPnfdW/Lwrtyi3L4OKTU8ZTrFglzhlTyrSD50=;
        b=fbtg6UtC8SSswccQwq6/Dq02UT8jT2JdmVOyRj7z1BuKqXwj3loX4UVrG+hhNUjYwj
         qul8KhvyC4GeuPn/AS5xn3wOSXlN4psgJEsqDwNhIiJy3RKG3Xj+Hus6UOcYXY4SCJQt
         Hr+4Wckop/2A1SHW9+ziF6EwDa/yf2/c1ivlosCUDJ89De+DhuG3I3GthCgZ5xX6Uxlb
         KgUxTt2zug2Z9JwvodYO/umHjTCEqSWjZ7NIdOP0PAyY9ww1m7rxsDb88m/VVFHCoLzH
         ga25vAXah7KXU+me6FN1giL7DAzlrh2R/aqk46Ni1z3GaHO2dcV7iU6fKu/UcFub1oM5
         x8eQ==
X-Gm-Message-State: ACrzQf3rh9Po7dk8koqXzUFDHRnxvwWdrS5fKU0hN+iKHBxHESz0DB2B
        fPDcKtNjX+YsupJXO++4KTu8kkavsYk=
X-Google-Smtp-Source: AMsMyM7/iZup/TVz4h6koDcBYTpgzujYnMy1L2cz7C46KFg9bnAatmjHJB5YnMOkU1q+wdBp9GAsBg==
X-Received: by 2002:a5d:680a:0:b0:236:b797:5d80 with SMTP id w10-20020a5d680a000000b00236b7975d80mr35523684wru.403.1667942910789;
        Tue, 08 Nov 2022 13:28:30 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id q2-20020a7bce82000000b003cf7292c553sm12291162wmj.13.2022.11.08.13.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 13:28:30 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <7730f942-7332-4408-a2c0-f6ccde3cdb3a@dunelm.org.uk>
Date:   Tue, 8 Nov 2022 21:28:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/2] maintenance: add option to register in a specific
 config
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Ronan Pigott <ronan@rjp.ie>, git@vger.kernel.org, me@ttaylor.com,
        derrickstolee@github.com
References: <20221108194930.25805-1-ronan@rjp.ie>
 <20221108194930.25805-3-ronan@rjp.ie>
 <448cc6ed-c441-85a3-2780-0c07e56f53f8@dunelm.org.uk>
 <Y2rCsq5y9TuCfrKC@nand.local>
In-Reply-To: <Y2rCsq5y9TuCfrKC@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor

On 08/11/2022 20:57, Taylor Blau wrote:
> On Tue, Nov 08, 2022 at 08:38:51PM +0000, Phillip Wood wrote:
>>> diff --git a/builtin/gc.c b/builtin/gc.c
>>> index 24ea85c7af..1709355bce 100644
>>> --- a/builtin/gc.c
>>> +++ b/builtin/gc.c
>>> @@ -1497,12 +1499,16 @@ static int maintenance_register(int argc, const char **argv, const char *prefix)
>>>    	if (!found) {
>>>    		int rc;
>>> -		char *user_config, *xdg_config;
>>> -		git_global_config(&user_config, &xdg_config);
>>> -		if (!user_config)
>>> -			die(_("$HOME not set"));
>>> +		char *user_config = NULL, *xdg_config = NULL;
>>> +
>>> +		if (!config_file) {
>>> +			git_global_config(&user_config, &xdg_config);
>>> +			config_file = user_config;
>>
>> Here we need to decide whether to use user_config or xdg_config as the
>> config file. In builtin/config.c we do this with
>>
>> 		if (access_or_warn(user_config, R_OK, 0) &&
>> 		    xdg_config && !access_or_warn(xdg_config, R_OK, 0)) {
>> 			given_config_source.file = xdg_config;
>> 			free(user_config);
>> 		} else {
>> 			given_config_source.file = user_config;
>> 			free(xdg_config);
>> 		}
>>
>> We need something similar here (maybe we should create a helper function to
>> find the appropriate file)
>>
>>> +			if (!user_config)
>>> +				die(_("$HOME not set"));
>>
>> This check needs to come before deciding which config file to use
> 
> True, but that problem existed before this series, too.

Oh yes, sorry I'd missed that

Phillip

> So the new
> behavior is no worse with respect to the XDG config stuff, and any
> improvements to that behavior can be done independently on top. >> Thanks,
> Taylor

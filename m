Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA899C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 12:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiHJMwe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 08:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbiHJMw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 08:52:26 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C747695B
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 05:52:25 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id i24so10954047qkg.13
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 05:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=/tPLXh0uGa7Y6zM6BLedq+8tgOL/Z5qAmQdIDHWwgHc=;
        b=i4VGWrJ5Lz66ZHyZ+AR+YTnNHAzwmEg6grP4cZhMfHt2wcQHKjk4NANGBEpZTwfmow
         h9iuXCdTXUyLO8D913lRlBX8YlUIgnkOZU58UGUZWBjvL3cd40eB6PzY2tPwaUCbuOJx
         dKrcAOA9S2c3FaC0y5IT+ZCAXgLOioVo/x6KJDZJ69xd5qXWQxpvaEFJ65FQnQ8BkdvT
         So8oLIKFex8jyoFwm4yLznej2vSgYyEphGcyGbNJk4fXZudCWwHcu4SSDz1VrhSwmdWM
         C9M0FwyGbWxnIhhFPSvRNvOkdxQd+fkrP5S0XM05ZGEp0TZN+4E3AT9m747+SItd/CZk
         nKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=/tPLXh0uGa7Y6zM6BLedq+8tgOL/Z5qAmQdIDHWwgHc=;
        b=4l7FmA7p7D1cFQC1TJCY3Y3e+04+EMrfV3TLWJQqz4Yibs03qFK9vLnkYr8rAloTRw
         0PFSg9rKBCoyK6sLD/5+FWTlCnRCBpTSjz8g+YujOFve59wP5gU9ZaKOXbvXxhWBv61S
         bV+oJmmFAROwaHSmjTZ/ZH1X+QuHVLX+NcqPzNDeqTl/A/JkjK0hlvM714a8FP+BnqCa
         SuvexDpDTig4dKngC7dZv5M/hdS4R5o9LskWSYYBub1CUuf61JuVurPsodlQ2NGWKrk4
         5Qe4/wjOCEA/P6MNHpLu3rtT7OmcVN+5hhoS7jabJV/K+h4VafQ1YbSX59yb7dJEOMij
         cWag==
X-Gm-Message-State: ACgBeo2T2gCado/W/2eg39kiHh5YrBWRkkGeeVMFuk57mOQxgAnmHrgD
        Rw+bvhnWMKZf2iQNWv7YMUp3
X-Google-Smtp-Source: AA6agR6egbSk2G9ZLUluJQ36Nq1FIaEZqQPxkSxOWj3K7FcFQRNshJtK+iZwh9bIhJ47MCWXNi0E8Q==
X-Received: by 2002:a05:620a:bcd:b0:6ab:84b8:25ee with SMTP id s13-20020a05620a0bcd00b006ab84b825eemr20550748qki.512.1660135944283;
        Wed, 10 Aug 2022 05:52:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:91c5:d5d6:a070:72da? ([2600:1700:e72:80a0:91c5:d5d6:a070:72da])
        by smtp.gmail.com with ESMTPSA id s8-20020a05620a0bc800b006b5c061844fsm13471865qki.49.2022.08.10.05.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 05:52:24 -0700 (PDT)
Message-ID: <77f445f7-3934-c165-3160-e09d7b884774@github.com>
Date:   Wed, 10 Aug 2022 08:52:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v2 08/10] builtin/bugreport.c: create '--diagnose' option
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
 <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
 <d81e7c10997e9e8dc211d241019fbafa6b25fb04.1659577543.git.gitgitgadget@gmail.com>
 <3dc402e1-1f27-8a24-544d-d90d403a7da0@github.com>
 <a45f5693-7186-2953-6620-3f1359a12238@github.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <a45f5693-7186-2953-6620-3f1359a12238@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/9/22 7:53 PM, Victoria Dye wrote:
> Derrick Stolee wrote:
>> On 8/3/2022 9:45 PM, Victoria Dye via GitGitGadget wrote:

>>> +static int option_parse_diagnose(const struct option *opt,
>>> +				 const char *arg, int unset)
>>> +{
>>> +	enum diagnose_mode *diagnose = opt->value;
>>> +
>>> +	BUG_ON_OPT_NEG(unset);
>>> +
>>> +	if (!arg || !strcmp(arg, "basic"))
>>> +		*diagnose = DIAGNOSE_BASIC;
>>> +	else if (!strcmp(arg, "all"))
>>> +		*diagnose = DIAGNOSE_ALL;
>>
>> Should we allow "none" to reset the value to DIAGNOSE_NONE?
> 
> As far as I can tell, while some builtins have options that  match the
> default behavior of the command (e.g., '--no-autosquash' in 'git rebase'),
> those options typically exist to override a config setting (e.g.,
> 'rebase.autosquash'). No config exists for 'bugreport --diagnose' (and I
> don't think it would make sense to add one), so '--diagnose=none' would only
> be used to override another '--diagnose' specification in the same
> command/alias (e.g., 'git bugreport --diagnose=basic --diagnose=none'). 

Ah, so --diagnose=none isn't valuable because --no-diagnose would be
the better way to write the same thing. You would need to remove the
PARSE_OPT_NONEG from your OPT_CALLBACK_F() to allow that (and then do
the appropriate logic with the "unset" parameter).

The reason to have these things is basically so users can create
aliases (say 'git br' expands to 'git bugreport --diagnose=all', but
they want to run 'git br --no-diagnose' to clear that --diagnose=all).

Thanks,
-Stolee

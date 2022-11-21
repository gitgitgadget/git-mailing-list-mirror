Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A520C433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 15:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiKUPvc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 10:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiKUPva (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 10:51:30 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D859BBF71
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 07:51:27 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id d1so8373655wrs.12
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 07:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yOXRVNqbWg78jxjzR7LLTdXIL2tPnkS43jq4/v+uaiU=;
        b=UpHmEnvZU4htUexPxx3aUVkb2bOYiGHvdNbQg+QPJ78Q5XnsgUJbUlkWeCZ7wIH3mN
         wdgBAs9oWvyonjzTXh9Kx4EbXunzbS0wgqy8vRXTs0LXEvtbb8Z/4EKUE+A8KcDuuyqW
         iUyPuaOVGvHr6qm5oqD51+Wphm1zihQ3W96m+T4StB+iBmRiIez9ECM4KjWBb1sRRVDR
         13d860oyn46k+RE7LeSGs2/6pF4Jz3B661rNVVWPwEZGD8G73b5KnahDT0a7cz3UC6hB
         TrLVUSIOiXdowruNHTrV+c9ZQRF4HbphE6XGEbtL8BKeUS38UCNK9m9+FCPnAdBNBkxG
         kG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOXRVNqbWg78jxjzR7LLTdXIL2tPnkS43jq4/v+uaiU=;
        b=LgP34Yz9pUXec4876RLxqRDN+i/B9unznJYcI7LR5pqIWtYFVutrQjOVfXryliwnSx
         /P+R1g+yHnKOl2bKBn7+7fNEe2SUW/kyqx1B5f/m6mRTNAXV+e+YcxVAljCxmlkrNh9z
         OxOAfHzRMt1fJc2MgZSFmi5knS0FAYIulzcYhGegw7Fvxpn0aS4L+SbrBAtAcxIzs4uw
         4Gt4evznMihXegSSQkmjWERGDFnFvJc4K85HfoRYtMZEq5EC1GbaUt+ki3iVXQ+5gSYQ
         xoPVd8afJM/7HQRuFe61WL0fwEAiH+0KtufUkIL8U1+8ZstyuoXGU4zAtQQ0EMolJRb5
         f1uA==
X-Gm-Message-State: ANoB5pkbSPGMBdC4jMTiapGW/OtNRkWxDxRGsd9/+NaEOQOqo3Qu5u/X
        Icfe8/GCTtSF4swC6b7xihU=
X-Google-Smtp-Source: AA0mqf5pxS++0CbPH9GAvyIaZrL3mxr949lntWvfU8sJqtxfTXG+6r1STux8Nbg8QV0Lny0qTdWvKw==
X-Received: by 2002:adf:db81:0:b0:236:5144:f8ce with SMTP id u1-20020adfdb81000000b002365144f8cemr5235527wri.657.1669045886335;
        Mon, 21 Nov 2022 07:51:26 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id bg21-20020a05600c3c9500b003b497138093sm15795351wmb.47.2022.11.21.07.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 07:51:26 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <aa054864-203b-3c06-0706-6cc40310a830@dunelm.org.uk>
Date:   Mon, 21 Nov 2022 15:51:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] config: introduce an Operating System-specific
 `includeIf` condition
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1429.git.1669037992587.gitgitgadget@gmail.com>
 <221121.86pmdgbdwa.gmgdl@evledraar.gmail.com>
In-Reply-To: <221121.86pmdgbdwa.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho and Ævar

On 21/11/2022 13:51, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Nov 21 2022, Johannes Schindelin via GitGitGadget wrote:
> 
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> It is relatively common for users to maintain identical `~/.gitconfig`
>> files across all of their setups, using the `includeIf` construct
>> liberally to adjust the settings to the respective setup as needed.
>>
>> In case of Operating System-specific adjustments, Git currently offers
>> no support to the users and they typically use a work-around like this:
>>
>> 	[includeIf "gitdir:/home/"]
>> 		path = ~/.gitconfig-linux
>> 	[includeIf "gitdir:/Users/"]
>> 		path = ~/.gitconfig-mac
>> 	[includeIf "gitdir:C:"]
>> 		path = ~/.gitconfig-windows
>>
>> However, this is fragile, as it would not even allow to discern between
>> Operating Systems that happen to host their home directories in
>> `/home/`, such as Linux and the BSDs.
> 
> This looks like a really sensible thing to do, thanks.

Yes, it looks like a really useful enhancement

>> +`os`::
>> +	The data that follows this keyword is taken as the name of an
>> +	Operating System; If it matches the output of `uname -s`, the

Maybe add e.g. "Windows or Linux" after Operating System?

>> +static int include_by_os(const char *cond, size_t cond_len)
>> +{
>> +	struct utsname uname_info;
>> +
>> +	return !uname(&uname_info) &&
>> +		!strncasecmp(uname_info.sysname, cond, cond_len) &&
> 
> Our config.mak.uname doesn't to case-insensitive uname matching, and
> AFAIK these don't change between platforms versions. So why do we need
> to support LINUX, LiNuX etc. in addition to the canonical Linux?
> 
> I'm not opposed to it if there's a good reason, but as we have "gitdir"
> and "gitdir/i" shouldn't we make that "os/i" for consistency, if it's
> needed?

Why should we penalize users who write "linux" rather than "Linux"? 
Making the comparison case insensitive seems eminently sensible. File 
systems can be case sensitive so having the option to specify whether a 
match for "gitdir" is case sensitive or not makes sense there but not 
for the name of an operating system.

Best Wishes

Phillip

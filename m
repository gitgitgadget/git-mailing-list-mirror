Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46BEC4321E
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 15:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiLBPlB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 10:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbiLBPk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 10:40:59 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F161C4CE9
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 07:40:58 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id h17so2218355ila.6
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 07:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o9G72UWS7masRuaU/wC/OsqrTRjaC00EjNQoCy2t7Mo=;
        b=SfhekvRwEsoTabO8A5nd19cEKQAZyVJjBowRqGmamkdQgbNntKbCoDluNby1JOsqZu
         q1F+jVwmF7iGgOjeme4gWyopku8c2H6tr8YEd9H8tn0Bn+2ULjvPz7W8usPncBaIyrST
         Y8a1E95SRCVF7pxUiv6wjjN12ay8VNLjYOnDghIBUVPIOF4vpQvX3cUwdjw1bOqOWuXT
         2PuCYS0BIcLNGCGMWoQlKnaq3XP9c6NY5T5uQFX4akKmGSl6OPGzV0RQkHol0vqL9iID
         Qh/ooX9XI23NHLrKsUJB1slSRKBHEqRnUK+djNhrWZJ2xVGmwjGRVt+Fo62P7FMX2urP
         bshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o9G72UWS7masRuaU/wC/OsqrTRjaC00EjNQoCy2t7Mo=;
        b=KEeetXlgc9H2l4qhtw8hzEL4rBYA3kPxoIyLb8Av7kGmcQwjDUS1PaTXGNA1naLqWz
         ej6wEGPo/NzJ/r5YZPSsmljzeUemr2SOAaZjgCP7lIXwLt9uO69sPE3bbNXzSdFf+XqW
         YqpK1/GFbgokosTJBu35oosy+kuPhB9hbrKRPiDPSknSaO/uqHgT1ms2/vsBLSoLRFVM
         TN5JdQ+EhphkU3K/ZWIsmUfJnt10AQZ7p6iIFTruLY+nEW1wsm09B6wGBY72aORE9gxR
         F/XD1s9zAhHy4e89xlxfTBaZWj6VXCcyrKXEtDBodkmJEeZGDRKFh5BMD1pzar5wGZrQ
         fBlA==
X-Gm-Message-State: ANoB5pmeEDivpc4BIfpI8bspcOirTVcvnn7oAchss9QTWksf4gY5woNn
        ayCqJ7jnauHmpRJCyOblyWvE
X-Google-Smtp-Source: AA0mqf6WR2F6hY/3Lgm9RPl4sXjK/UUylDbflZcCgVnqKm6sBUo161kJxqjbG+SvudY0chH2iKLQVQ==
X-Received: by 2002:a05:6e02:4a4:b0:303:259:fefc with SMTP id e4-20020a056e0204a400b003030259fefcmr15073848ils.81.1669995657904;
        Fri, 02 Dec 2022 07:40:57 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:8051:a31f:2c93:87e9? ([2600:1700:e72:80a0:8051:a31f:2c93:87e9])
        by smtp.gmail.com with ESMTPSA id v11-20020a056602058b00b006dfe3511ee0sm295133iox.24.2022.12.02.07.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 07:40:57 -0800 (PST)
Message-ID: <9ac3d892-0f67-3d4d-060e-a599551c0fd3@github.com>
Date:   Fri, 2 Dec 2022 10:40:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 6/9] strbuf: introduce strbuf_strip_file_from_path()
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com, dyroneteng@gmail.com
References: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
 <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
 <7d86852c01513ee131bf993302416f4c881a0bc6.1668628303.git.gitgitgadget@gmail.com>
 <be89bbec-1a8b-1337-a5f7-f43420da64de@github.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <be89bbec-1a8b-1337-a5f7-f43420da64de@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/28/2022 8:03 PM, Victoria Dye wrote:
> Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> The strbuf_parent_directory() method was added as a static method in
>> contrib/scalar by d0feac4e8c0 (scalar: 'register' sets recommended
>> config and starts maintenance, 2021-12-03) and then removed in
>> 65f6a9eb0b9 (scalar: constrain enlistment search, 2022-08-18), but now
>> there is a need for a similar method in the bundle URI feature.
>>
>> Re-add the method, this time in strbuf.c, but with a new name:
>> strbuf_strip_file_from_path(). The method requirements are slightly
>> modified to allow a trailing slash, in which case nothing is done, which
>> makes the name change valuable. The return value is the number of bytes
>> removed.
> 
> *Extremely* minor point, but why return anything at all? The call in the
> next patch doesn't use the return value, and some similar-in-spirit 'strbuf'
> functions (like 'strbuf_trim()') return nothing. 
> 
> I don't think this is worth changing if you can imagine using that return
> value for something eventually; just wanted to point it out as something to
> (optionally) consider if you re-roll for something else anyway.

While I'm here, it's not too hard to remove that and save some lines.
We can always bring that back if someone needs it in the future.

Thanks,
-Stolee

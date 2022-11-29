Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C77C4332F
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 03:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbiK2DqK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 22:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbiK2DqI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 22:46:08 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22F71F610
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 19:46:05 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id c15so3174876pfb.13
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 19:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bstEjZ3tsomXiAv4mXFpHHok2ntEaIURyl4HMO+AGZg=;
        b=o4pVWSmGpIPZuJEFZrTLSgKLjP0EK/0EJcMIHf02EduWsZLu2aFSVmMZPuY3q6BajA
         V1w5da96BrWr+6+9m6IUxNnoPf9LGPBlordcN+kO/SByNmfpTUCtfNbNpnE5mGGUfR11
         h1XT4cH+ncqY99krMLGkVByIs7xwFFVGnHOWa8zcQzK4uN9mn+wSDQ+66VFGPPjAUEzg
         B4DbEul4PHE6/uWYX/c1Hs9l3FdUMU5YCDQepTNKFzAeToqGGNApHGN3qF/7p4lKOXaW
         X3+hhJ80SiRAjWBC+QEHd1yD3+UFtrzQkp2M4zs2fQmvEZbCmDpF7L6pbEQIylwjxlYs
         xFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bstEjZ3tsomXiAv4mXFpHHok2ntEaIURyl4HMO+AGZg=;
        b=fz4KVQWfI9MoAG7KDV54Uc1naxoeIYUnvoNZOp7dDh8AyyG7r84L9XvKODamQwbkN3
         bHOV2lUBqxuTEGWHqKQOrvT49pVk2rNWdrzPhqqYv6sXKkY2K27KG+m9+sX2UCTaezoL
         55SCXLAIRaHtrXTi2v36yr5GNcEJwMcwqwJatijYwBkmpIEXAQABYGdCjJf5yltLTSyi
         pNsWTFMH8BdhTxkcpbURbRFGVcYJzzUgk5PN11cl1NHBqeUJq94bNjQt9BwjhGnzcgEy
         OHH5zp9hPCAMlVnsN3dcwW8fKonE8LYsO8+D6cOLV2B1PmSvKbe3SmZ/A+QuTDO5ZENT
         DgCQ==
X-Gm-Message-State: ANoB5pkR9NpoAIUZP5gSwwTvoVWKzd6kfCdPh5Ah/4mLKrho/MTdeQq9
        jo7G1WuOzpPkPx0qFdpFh1Y=
X-Google-Smtp-Source: AA0mqf6nI+6szBDWkiv2YLezzRzPJjQ3XH6+Elqvyi9nGC/Ha+vHbA+2Km1fE2w4P8kWkBBLCnQMJg==
X-Received: by 2002:a63:5910:0:b0:477:2793:f821 with SMTP id n16-20020a635910000000b004772793f821mr47281908pgb.150.1669693565465;
        Mon, 28 Nov 2022 19:46:05 -0800 (PST)
Received: from [192.168.43.80] (subs28-116-206-12-33.three.co.id. [116.206.12.33])
        by smtp.gmail.com with ESMTPSA id p1-20020a170902e74100b001896ba683b9sm7021570plf.131.2022.11.28.19.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 19:46:05 -0800 (PST)
Message-ID: <f6a8210b-d224-161d-d8bf-c1de7bca5367@gmail.com>
Date:   Tue, 29 Nov 2022 10:46:02 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] git-compat-util.h: Fix build without threads
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Fabrice Fontaine <fontaine.fabrice@gmail.com>,
        Jeff King <peff@peff.net>
References: <20221125092339.29433-1-bagasdotme@gmail.com>
 <221126.86lenymw7p.gmgdl@evledraar.gmail.com>
 <a1e9449c-80b4-782d-faed-f2ae45420015@gmail.com>
In-Reply-To: <a1e9449c-80b4-782d-faed-f2ae45420015@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/29/22 10:30, Bagas Sanjaya wrote:
> On 11/26/22 06:47, Ævar Arnfjörð Bjarmason wrote:
>> Per f43cce23add (git-compat-util: add fallbacks for unlocked stdio,
>> 2015-04-16) wouldn't it make more sense to do something like:
>>
>> #ifdef NO_FLOCKFILE
>> #undef _POSIX_THREAD_SAFE_FUNCTIONS
>> #endif
>>
>> Or the other way around here? I.e. have _POSIX_THREAD_SAFE_FUNCTIONS
>> define/undefine NO_FLOCKFILE?
> 
> From the commit you mentioned, I think that above is OK. However,
> because I'm no C expert, I'm unsure whether I should go with #undef
> suggestion alone or #undef following by no-op declaration below #endif.
> 
> Thanks.
> 

Also, I think NO_FLOCKFILE is rather misnomer: it is the knob
when there is no _POSIX_THREAD_SAFE_FUNCTION, so the knob name should
have been "NO_POSIX_THREAD_SAFE_FUNCTION" instead.

-- 
An old man doll... just what I always wanted! - Clara


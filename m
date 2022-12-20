Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B47C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 13:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbiLTNj7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 08:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbiLTNj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 08:39:56 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA0618E33
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 05:39:55 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id i186so12928326ybc.9
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 05:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AUounwtmnLdxxiXBBmVXtJCLr/p7wZG+jWZifTVWEyI=;
        b=eT7UissT9dHmj2bOQQkAICNWXzfH/GheMdTxwEgpRH2c7JbMScf3OHdVQttlHLC/Cr
         5gslavRUX9Y05qYSw223AltKfxpbVh45v8unXbO9mrWpTsnQVNKxBviOCYM07CU5YZnc
         aeAktOeg23T6HltK9Li7M+O9WA0VtrFfVKXwtEefxZ5QvAZ4BL5hQ6Zh2yWS4k5/OVxN
         PktEiyWhSaMNIhkscXsGn0L+nGoecV/fVrD4KMVgaVKo1gtiUYq5SlDpjcmbPeHGMfjs
         eI0bPGZmZxKi/TMg+JXQlEcXvkI+sM1SPcA3MSExWlrPH9fdLDo4Uo8npipkMjfh3Mmg
         miMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AUounwtmnLdxxiXBBmVXtJCLr/p7wZG+jWZifTVWEyI=;
        b=fTuQznu5msUUlhH8doc48JQ8eTHoEgacona7FXVkfZp+pQ9/jFet6jEi/yLT2fczpO
         1oyvbDot5NeBkKBkMlMBQWDJil+j1bLTeXQgsPuDpBsZ0OU/mhat0ebn7PTq6rJeykSb
         LtqpAJ8uWNkJPHDTQMTQqWXSt4YSdZ+Cdq5CQCSy3lzRW9uQtJZM+HbRdgfQlOEcJDPU
         Vi13iOhBu8ri8ZocA0bawZEgGYmZOmag9QEEYonswx2tuQc6nad1fQXec1KsXjB11KQ2
         L+mpoAui3+giwgrH1lwsJvRVqJqtDa1am1iU1A60L5DAM3oERjII9PH0MszNx0lT3vrZ
         odkA==
X-Gm-Message-State: ANoB5pl8CO5UL3eqT+6uzLWAZTHTdFga6sTc5w5sWj+aKXv6s+wOfnUw
        8wwMrMvquJDHllR3XANG6STlax8bIxR1Stg=
X-Google-Smtp-Source: AA0mqf7e4MT6ttZQADjTU97WcI20fFxmkS679sN2XOLN72nnGHuQb/1QKpFYcFX38fIrH0Hk3EbTIg==
X-Received: by 2002:a25:4fd7:0:b0:700:e0f1:632e with SMTP id d206-20020a254fd7000000b00700e0f1632emr39811622ybb.60.1671543594733;
        Tue, 20 Dec 2022 05:39:54 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:6103:2a44:3e02:702f? ([2600:1700:e72:80a0:6103:2a44:3e02:702f])
        by smtp.gmail.com with ESMTPSA id u5-20020a05620a430500b006ff8ac9acfdsm9049052qko.49.2022.12.20.05.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 05:39:54 -0800 (PST)
Message-ID: <0113fed3-5dca-6a31-9b9d-becd009c2fca@github.com>
Date:   Tue, 20 Dec 2022 08:39:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: ds/omit-trailing-hash-in-index (was: What's cooking in git.git
 (Dec 2022, #06; Sun, 18))
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqh6xtw4uw.fsf@gitster.g>
 <221219.86y1r3zmrv.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <221219.86y1r3zmrv.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/19/22 5:49 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Sun, Dec 18 2022, Junio C Hamano wrote:
> 
>> * ds/omit-trailing-hash-in-index (2022-12-17) 4 commits
>>  - features: feature.manyFiles implies fast index writes
>>  - test-lib-functions: add helper for trailing hash
>>  - read-cache: add index.skipHash config option
>>  - hashfile: allow skipping the hash function
>>
>>  Introduce an optional configuration to allow the trailing hash that
>>  protects the index file from bit flipping.
>>
>>  Will merge to 'next'?
>>  source: <pull.1439.v4.git.1671204678.gitgitgadget@gmail.com>
> 
> I've been following this closely & reviewing it. I think the end-state
> is probably good, but noted in [1] that the intermediate progression
> equates bad config with "true", so:
> 
> 	git -c index.skipHash=blahblah status
> 
> Enables it, fixing that is trivial, and probably worth a re-roll.

Fixing it is trivial, but as you say it is correct in the final
version so I don't think this triviality is worth a re-roll.

> The "probably" above is then because the patches seemingly try to make
> this compatible with different config for submodules, but there's no
> tests for submodule interaction, so that may or may not work.
> 
> Normally we could just trust the "struct repository *" parameter we get,
> but in this case it's "istate->repo", which (as I showed in the v3
> feedback[2]) is sometimes NULL.

This, and other feedback you've given around 'struct repository *' values
makes me think you are not aware of the current state of the submodule
work. I'm also a bit out-of-date, but my understanding is that the
conversion to stop using the_repository everywhere is only halfway
complete, which makes it difficult to properly test things with multiple
'struct repository *' pointers. However, the best thing we can do is to
use whatever local repository we have, so we don't contribute further to
the problem.

The fact that istate->repo is sometimes NULL is a separate issue, but is
generally unrelated to the subject at hand and should be fixed by another
topic, not used to block this one.

Thanks,
-Stolee

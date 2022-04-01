Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB345C4332F
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 16:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348800AbiDAQLi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 12:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350065AbiDAQJO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 12:09:14 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3794760DC
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 08:33:26 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r13so4760230wrr.9
        for <git@vger.kernel.org>; Fri, 01 Apr 2022 08:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nM4VQ3XKMzprsooerfpU6opL16VeubydfDQ8TSlQQUA=;
        b=VFALoHeX5L0u/ziOb1TvrJOLiW49ZhL/8l3+Ro/g/T7l8aCf59b43qDNnV69hQIUz4
         AOosPvXKCgxafEHfOixdVNv8t+19j++m5maZDJHOO0s6Grjohv9FGV/vB2kIv6UldD4S
         N4d5Pa3Rw6V2N8yTYKy1j/nOHtI/XQX+GE2UATZmWsIYBKegR+eVAzssXzJ86YtYMIkF
         HnDpiEMCzQO8qnQJUWlaa6+SVhb5kapBMdlNWW2r4+AGExlMdavmnmzoxurnY6oUQgME
         BACaP3eJ7T+dmEqbw/6ZbxjPjf7wv00iUA5NWrbjtfjVbqupcdYFFFWcdqG005RSHMyy
         xvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nM4VQ3XKMzprsooerfpU6opL16VeubydfDQ8TSlQQUA=;
        b=KQBwl2Y/8/UD3q+BuY1JvySKI8vfPxSDRkWk23TrgC6PKX0YILT+gCRtkBdDqTM6mK
         m+Q95RrXJtAKIe2CLSOXrFHnQZ8fLxMAkBhW9nD3KHasjc2GbRoQ2rZgzscncQkLXO5H
         mADH/n4XTCFlrMvWOP78oTJ05sNqxwFARK2OnNYO5g/6XHBfQWhVE1RwUQMn24ZG7uKU
         c+S7v4YzNdfqIqDfR1q8wEH8DDxHunQIeaEMqCC7JqlfTa2sQ+PT6KaALT24qO/5KAHr
         RWRmiPIF749xPeLQwgf8Wy7owMGEndm1KqBsnTr/E0vA9mvO+Ggoji+lA2KM9Xa6k1xv
         ocKw==
X-Gm-Message-State: AOAM5335nW2NRwhCCHtSTUU3f0fftaip0csSJMKyoj7ZcMr5EYNm6Kny
        4Bu7RcnZtUXO9eUh+4kEVod1GD/cKLI=
X-Google-Smtp-Source: ABdhPJzUHmPo3Z6kptHlHd/DUXVtaPutl6EeKJPiv3cxUKzcHOlQEMNt9Saw6p6qg+AzPuiaI3GapQ==
X-Received: by 2002:adf:e604:0:b0:203:d866:f741 with SMTP id p4-20020adfe604000000b00203d866f741mr8061486wrm.391.1648827205279;
        Fri, 01 Apr 2022 08:33:25 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.224])
        by smtp.gmail.com with ESMTPSA id f9-20020a05600c4e8900b0038cc29bb0e1sm12542287wmq.4.2022.04.01.08.33.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 08:33:24 -0700 (PDT)
Message-ID: <3b08ab38-0d91-a361-544c-c3af68715e79@gmail.com>
Date:   Fri, 1 Apr 2022 16:33:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 10/27] stash: always have the owner of "stash_info"
 free it
Content-Language: en-GB-large
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
 <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
 <patch-v4-10.27-145a0f74b6a-20220331T005325Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <patch-v4-10.27-145a0f74b6a-20220331T005325Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi Ævar

On 31/03/2022 02:11, Ævar Arnfjörð Bjarmason wrote:
> Change the initialization of the "revision" member of "struct
> stash_info" to be initialized vi a macro, and more importantly that
> that initializing function be tasked to free it, usually via a "goto
> cleanup" pattern.
> 
> Despite the "revision" name (and the topic of the series containing
> this commit) the "stash info" has nothing to do with the "struct
> rev_info". I'm making this change because in the subsequent commit
> when we do want to free the "struct rev_info" via a "goto cleanup"
> pattern we'd otherwise free() uninitialized memory in some cases, as
> we only strbuf_init() the string in get_stash_info().
> 
> So while it's the smallest possible change, let's convert all users of
> this pattern in the file while we're at it.
> 
> A good follow-up to this change would be to change all the "ret = -1;
> goto done;" in this file to instead use a "goto cleanup", and
> initialize "int ret = -1" at the start of the relevant functions. That
> would allow us to drop a lot of needless brace verbosity on two-line
> "if" statements, but let's leave that alone for now.
>[...]   
> @@ -912,8 +912,11 @@ static int show_stash(int argc, const char **argv, const char *prefix)
>   	}
>   	log_tree_diff_flush(&rev);
>   
> +	ret = diff_result_code(&rev.diffopt, 0);;

Extra ';'

Best Wishes

Phillip

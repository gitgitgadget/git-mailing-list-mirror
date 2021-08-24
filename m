Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC023C432BE
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 17:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8516610CD
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 17:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241705AbhHXRih (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 13:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241606AbhHXRgh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 13:36:37 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0F4C08ED3F
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 10:01:41 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id y14-20020a0568302a0e00b0051acbdb2869so41100699otu.2
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 10:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rCdb59S4ASWULvz1ZznZ+vW8Fmky2IKIk40eVojds2o=;
        b=TTHz1eChT+4wU3nniy+ie7E6FdGH6sO4wEE11Q3Q2AN22KOQl93+OIlTzvMLK7vlI5
         GSubmmudwR3NjIzFBJ5FqwTYy5+ethhAyWl6oOaNZBPUctmu0eNo1XhwwCwBpz9Kbwok
         8C2c/l8xJu/hXTL2e/lZh/7CWwOI3Lan/+d7FIt0E+i6+xwGC6S1pJqIWJf1XzRsjVjp
         EmdCT3nZXs/G+xHIPvpCZDwm95QLwrO/3Zbdf6pwUDTeOoV2j6h2m1PsjHM30IhD5yPX
         UUK+vrauEhOkkFVPO+UkeONpwvOpM8xJ10AtR9zW+xokZjRSGxk7Getr8QsnwT+TrEUC
         ePlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rCdb59S4ASWULvz1ZznZ+vW8Fmky2IKIk40eVojds2o=;
        b=lkKUG0CMVsYrqZ/ELVMJpr9RIhIKLhFIUcRQa/1Gy1Eizy0UyTawBKDPSAjxu0QwLu
         LM7hkdMnWtigNWwu9I6tOydgJ5P1G+rbEeKF4PexX312yWDWEgKl4DwtyknmNS2TUdAJ
         +yXRhz9i71OdNsiQjZQnu3pIZSj8OviJljoCovwWGAkSunglthxuh6EO5ciqX4GT+OG3
         50MSIHNyi5210uBtFHgbC08HlN8wQfK2uMwh30O38spQTr4qXAGwNfK/6ZDh89BgOwfN
         /2rQdNaTG3l+G2NAD2YuhneYu+wB7oHlKMJjFwSr/6ufHzYzASadYwEDh+yZnCs5WjFE
         ZzMQ==
X-Gm-Message-State: AOAM532ml/hFoDqtsLLXwCjw/NkivJDySwGXCpB+XNgg/1Av5rlKkCYG
        Jnbe8zJtkD7LgdEm0nJv+fHex3swl88=
X-Google-Smtp-Source: ABdhPJyIHpfubvrRnJTkhK50mVwSnR2N3HdSiPNHkSEI5J33Ts3VNG0/gyIl3rwPi5EThr1dxCI5iQ==
X-Received: by 2002:a05:6808:2193:: with SMTP id be19mr3646853oib.102.1629824500392;
        Tue, 24 Aug 2021 10:01:40 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3cc8:64de:6d4:4ca6? ([2600:1700:e72:80a0:3cc8:64de:6d4:4ca6])
        by smtp.gmail.com with ESMTPSA id w12sm979505oor.23.2021.08.24.10.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 10:01:39 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] bundle API: start writing API documentation
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com>
 <cover-v2-0.4-00000000000-20210823T110136Z-avarab@gmail.com>
 <patch-v2-1.4-dc8591f6d0b-20210823T110136Z-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1193fbe3-f4f6-d8e7-3730-770d2932655d@gmail.com>
Date:   Tue, 24 Aug 2021 13:01:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <patch-v2-1.4-dc8591f6d0b-20210823T110136Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/23/2021 7:02 AM, Ævar Arnfjörð Bjarmason wrote:
> There are no other API docs in bundle.h, but this is at least a
> start. We'll add a parameter to this function in a subsequent commit,
> but let's start by documenting it.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  bundle.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/bundle.h b/bundle.h
> index 1927d8cd6a4..84a6df1b65d 100644
> --- a/bundle.h
> +++ b/bundle.h
> @@ -27,6 +27,13 @@ int create_bundle(struct repository *r, const char *path,
>  		  int version);
>  int verify_bundle(struct repository *r, struct bundle_header *header, int verbose);
>  #define BUNDLE_VERBOSE 1
> +
> +/**

nit: what's the use of the "/**" start to these doc comments?

I see examples in the codebase of both, but we are not consistent even
within a single file. Here is how I counted instances of each:

$ git grep "^/\\*\\*\$" -- *.h | wc -l
266
$ git grep "^/\\*\$" -- *.h | wc -l
775

So we use "/*" three times as often as "/**". Should we attempt to
be more consistent in the future?

Thanks,
-Stolee

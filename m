Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AB6C7EE24
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 09:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbjFBJyb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 05:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbjFBJya (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 05:54:30 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6241E2
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 02:54:28 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f4f3ac389eso2489282e87.1
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 02:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685699667; x=1688291667;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yHyaY5e2pSDYi3f6vYuWB2Oowy8FsVZfxOgBNsenK48=;
        b=d6qR9fZSn6hyjFCmH1VT1rMkUYmk3kBhJT2mntMjLMvshwxmEyCxODO5oiZRrQqqaJ
         DiSpIu2fkzssYZwMD1P9wmZ1I+mjhMinb/CcJRCwd+JzZFTKw0R1dmHeUjXjYRBqcHxJ
         GKvQQFAUr27NvTQbu2/+BqAj53rTzyzPvJKykQ++m2YX2+RqQr4gF0XjhDOvgaTJwQaV
         7+JvFoe8NktGd1JG8yzlNW7QYYfxZC53JOmpqdLQKaoYQLtjgmhqMUVpD6UezrSvq8pI
         Nr/UDyGXQU3LO3TmOu3zXtIe61eCCYWqKNuC1YlsVeBdzzirLYT7q/mRxoTl/NFzaPG1
         aAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685699667; x=1688291667;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yHyaY5e2pSDYi3f6vYuWB2Oowy8FsVZfxOgBNsenK48=;
        b=CbzNclteMdr6xxND7IE4xH1CZdAHRzqR1cElzUvKt/+yBrJSQM9m67ApuvApsv1UQd
         noiorecYfbM6c9s6B/YKkJtcCMnsP4YJ1fRw00w0q9XLqlvzRvQHgSVO4jYil39KbUIm
         pGJiZ2AslI88G3a+hfFCsJ9wRVYU4G5H18BpW8hKJz3QPno3nmudKm2fwk2eUsFWyl50
         EZZKDT0vmeMLju8eiJ47pWJwo5hUenmSjPULvK8TMfWXLEkM0igAOhZcSFBO9FH6C2G7
         MnELihisSVbJPlxpn5e3f6uJvAeCbC5pg75lGzUoC41vpsncjlDzgYcGZyv8Oe5SfUie
         6cIw==
X-Gm-Message-State: AC+VfDzThXfqxJeL6owN9pFU1Ban28VAtIvqggiW7QQ5IwA4Y2/UTQzL
        S4Qgcs7Cs1jPQ1BIE7N4B4c=
X-Google-Smtp-Source: ACHHUZ7cETqVpCAVlwCOImVYoPGcvo3kjljdHy5C5GnP09otwxp5w0Z+XO99up6OH5lQOwgJS7Av1w==
X-Received: by 2002:a05:6512:3906:b0:4f4:e744:2e71 with SMTP id a6-20020a056512390600b004f4e7442e71mr1292304lfu.64.1685699666491;
        Fri, 02 Jun 2023 02:54:26 -0700 (PDT)
Received: from [192.168.1.195] ([90.255.142.254])
        by smtp.googlemail.com with ESMTPSA id n16-20020a1c7210000000b003f60119ee08sm4994421wmc.43.2023.06.02.02.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 02:54:26 -0700 (PDT)
Message-ID: <4de362b4-dcce-3b5a-0011-73dc7dec79c3@gmail.com>
Date:   Fri, 2 Jun 2023 10:54:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 03/14] (RFC-only) config: add kvi arg to config_fn_t
Content-Language: en-US
To:     Glen Choo <chooglen@google.com>, phillip.wood@dunelm.org.uk,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Emily Shaffer <nasamuffin@google.com>
References: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
 <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
 <6834e37066e7877646fc7c37aa79704d14381251.1685472133.git.gitgitgadget@gmail.com>
 <6faf1b17-a1ca-0c22-2e43-aee121c4e36a@gmail.com>
 <kl6l4jnr17am.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <kl6l4jnr17am.fsf@chooglen-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/06/2023 17:22, Glen Choo wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>    - is it worth making struct key_value_info opaque and provide getters
>>      for the fields so we can change the implementation in the future
>>      without having to modify every user. We could rename it
>>      config_context or something generic like that if we think it might
>>      grow in scope in the future.
> 
> Yes! I planned to do the key_value_info -> config_context conversion
> when I send the first non-RFC version for this exact reason.

That's great

>>    - (probably impractical) could we stuff the key and value into struct
>>      key_value_info so config_fn_t becomes
>>      fn(const struct key_value_info, void *data)
>>      that would get rid of all the UNUSED annotations but would mean even
>>      more churn.
> 
> Some of my colleagues also suggested this off-list. I think it is
> impractical for this series because I don't think anyone could
> reasonably review with all of the added churn. At least its current
> form, the churn is mostly concentrated in the signatures, but performing
> ^this change would make the bodies quite churny too.

I agree that keeping the churn to the function signatures makes it 
bearable. I wonder though if we could make the change by doing

-git_default_config(const char *key, const char *value, void *data)
+git_default_config(const struct key_value_info *kvi, void *data)
  {
+	const char *key = kvi_key(kvi);
+	const char *value = kvi_value(kvi);
+

That would add to the diffstat but I think it wouldn't really be any 
harder to review than just changing the signature as we're not modifying 
any existing lines in the function body, just adding a couple of 
variable declarations to the start of the function. If there is an error 
in either of the variable declarations then the compiler will complain 
as "key" or "value" will end up not being declared. It would pave the 
way for gradually changing the function bodies to use "kvi" directly and 
removing "key" and "value"

> After this series, I think it becomes somewhat feasible with coccinelle.
> My .cocci files were difficult to craft because we couldn't rely on the
> signature of config_fn_t alone to tell us if the function is actually
> used as config_fn_t, but after this series, we can just use the
> signature since config_fn_t has a struct key_value_info param.

That's an interesting possibility, I worry though that two huge changes 
to the config callbacks might be one too many though.

>>      The advantage is that one could add functions like
>>      kvi_bool_or_int(kvi, &is_bool) and get good error messages because
>>      all the config parsing functions would all have access to location
>>      information.
> 
> Interesting, I hadn't considered this possibility. This seems like a
> pretty good abstraction to me, though I worry about the feasibility
> since this is yet again more churn.

It could be done gradually though, converting one config callback at a 
time once the relevant changes have been made to config.c.

As an aside, I think we'd also want a couple of helpers for matching 
keys so we can just write kvi_match_key(kvi, "user.name") or 
kvi_skip_key_prefix(kvi, "core.", &p) rather than having to extract the 
key name first.

Best Wishes

Phillip


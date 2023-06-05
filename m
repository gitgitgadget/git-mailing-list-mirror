Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2C0C7EE23
	for <git@archiver.kernel.org>; Mon,  5 Jun 2023 09:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjFEJiu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jun 2023 05:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjFEJis (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2023 05:38:48 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC36FBD
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 02:38:46 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f6dfc4e01fso47043895e9.0
        for <git@vger.kernel.org>; Mon, 05 Jun 2023 02:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685957925; x=1688549925;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uyUVBnItV7lubLq1D3BaRflb2GegAJeRzV7YhTKjgQw=;
        b=XVrzwAOFWJRuincphApeKcydYUKgOIQ9teEcw1CV4EEI1/897H6/4qnGODPWK7koZ+
         zy3yJVU/KuMqp8ThzBe3cgIeUDc4jkxBK/WxbvfQwcVXfqNthWYuv6t59QAkw3+FRH4+
         Gb5hSzFktpuUPhC+/KdX+WeJa/AqH1kpKNftxTSrz/08y2lZS6ShgagFLwrWyu40PPsa
         Ze7LJO1NjO+EBBqijQan6YbUwQ8fhyNky3m+CqPivAjWQjfimlSq3UoPsEZPP919Jo0g
         C6x+HoWD1qMn8/suf7JqyAjpNI31bp7MlceYO6n1R3kwGJIAa9DUq5VW/jc4l4xMLfhw
         FELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685957925; x=1688549925;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uyUVBnItV7lubLq1D3BaRflb2GegAJeRzV7YhTKjgQw=;
        b=R9QNOBzvMHY8NczkNyyJOgy4//wSx1d/JG8FkLEykO/6VG2/3ZbLKKgJknMeAwNXFK
         ipRUQPL9ZSTqxZGOnTQrUZxl/Xq5bQEDNqWpYo3SGJaL4HyvJSFoalt0YvWr3jZKEmV7
         EM5hWfrJf8fq4gVK3FzL6yatpdPcQtMoqKgU01hbac+m2GvrNI3EEtDD/5+8cZwMLodi
         Xfs2mWS8wdyhcR5jvE2QdtsRrYpM8jvQHeUTlZQm8CsxGZ6GmI0i6imx4hz4/i0kyM+D
         SEcWpTjJbiRQyB//zdWhZyWKhMgwQD2eqqpL4+JzCq3tgCfQ3XhBcAGH7rHHVP22Mo2N
         xmCw==
X-Gm-Message-State: AC+VfDzO/Wvb/F3Xydmcr4vUQizctBZykoJlwpURoEStyc1OYvZk/2+J
        fD7/o9QzKCfylv5HVuxv2AaryXJUI+Q=
X-Google-Smtp-Source: ACHHUZ4ae5JscuoIHWyvg/IXsXhwRDmX5G3ef3rBB6ObD73Kud///7Pl1vEXTFoE15sarAOOLHtg1Q==
X-Received: by 2002:a1c:7713:0:b0:3f6:40d:136a with SMTP id t19-20020a1c7713000000b003f6040d136amr8147447wmi.41.1685957925057;
        Mon, 05 Jun 2023 02:38:45 -0700 (PDT)
Received: from [192.168.1.212] ([90.255.142.254])
        by smtp.gmail.com with ESMTPSA id q7-20020adff787000000b0030af1d87342sm9299462wrp.6.2023.06.05.02.38.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 02:38:44 -0700 (PDT)
Message-ID: <1ca04355-8faf-e7f9-051f-a6a568ff99c5@gmail.com>
Date:   Mon, 5 Jun 2023 10:38:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
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
 <4de362b4-dcce-3b5a-0011-73dc7dec79c3@gmail.com>
 <kl6lv8g5zu9v.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <kl6lv8g5zu9v.fsf@chooglen-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/06/2023 17:46, Glen Choo wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>> As an aside, I think we'd also want a couple of helpers for matching
>> keys so we can just write kvi_match_key(kvi, "user.name") or
>> kvi_skip_key_prefix(kvi, "core.", &p) rather than having to extract the
>> key name first.
> 
> Yes, and that would also abstract over implementation details like
> matching keys using strcasecmp() and not strcmp(). For reasons like
> this, I think your proposal paves the way for a harder-to-misuse API.
> 
> I still have some nagging, probably irrational fear that consolidating
> all of the config_fn_t args is trickier to manage than adding a single
> key_value_info arg. It definitely *sounds* trickier, but I can't really
> think of a real downside.
>
> Maybe I just have to try it and send the result for others to consider.

That's probably the best way to see if it is an improvement - you can 
always blame me if it turns out not to be! Hopefully it isn't too much 
work to add enough api to be able to convert a couple of config_fn_t 
functions to see how it pans out.

Best Wishes

Phillip

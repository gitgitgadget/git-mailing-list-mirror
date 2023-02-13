Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D6DC636D4
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 13:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjBMNhk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 08:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjBMNhj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 08:37:39 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D229F59C2
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 05:37:38 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id v24-20020a05683011d800b0068bdd29b160so3702416otq.13
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 05:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GWkfqN/5MGq7TsO49gs3IUGasnTjUWZXNux+eGkZTZs=;
        b=eJRBrlwrxhOw9eHPmzVhOXzmj0FmNUbWVSQHwxpKdX60EijLEk9VCds2kAvMLv7eTd
         o+etFduKgtVhoGr3JNLLY44lMvh4jxMJy2xDZMxnYJf3xqXKGRrnDF4/L2+NslBJUV4b
         B3x5CxW6D123nFlcxDfu7lm42xHgenJLu6eWS6o9ssajVVzcd+d1chfPHTaQ24hcXP3y
         X782mThcZuDdSLAKyyDMOt5OT+oB5S/jTrsCFwpoigCH5IwirsYQvCiXOw0FhtH7zjmJ
         EtEJbQv6q5kYwVdXH9Z0kLGsnl0Oq28QRp+d6G0vWYGR5iWOiDxEFTbGac11eS03MJ6Q
         A5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GWkfqN/5MGq7TsO49gs3IUGasnTjUWZXNux+eGkZTZs=;
        b=qh+bc8wdR8deqWXmHTj1jS+g7nZZJRREkXKcr13TN6YRmtL22qQFN1CwAKssx6z0Un
         w3cNxqno9rIobsEEGALHwDHITAjTeuxThwd8z66ceyhMCsqO5NvqnHGW/RX89G3zsCiU
         8SBs3CnMpmDxL8O5il50Oc4jaJkbZkz07I9FxmXvjXSVW0MLL20ZrRuDGKEiijgDxpwJ
         ERoskYvc7uuV7pt1CU8ncDoDRvfX53tzyXpw8M/cjWbsdLpkqdy5hIJgKt4EDY/AzsIs
         M6mWHGlyhJaJVK4d7l5VJ3EKOxb0bWhF7RWHdn6WvKiDBLpdsxDSHW50Z2tH0yOjUjrm
         Foyg==
X-Gm-Message-State: AO0yUKVcrlQRGhoUM/7fOOBjMYAv3WeFXA8gpA04vD/pnVe3CSVy9jI3
        0pMrI24GmdLpC0suJ2t09b8e
X-Google-Smtp-Source: AK7set/oCABUB0YhksXXz9IS0G9lGV450fsPmtzblG+T2YW6kutcvv/ZmImadq39Jicq+Y7LlCLrtw==
X-Received: by 2002:a05:6830:1f57:b0:68b:d0bf:99ec with SMTP id u23-20020a0568301f5700b0068bd0bf99ecmr14543619oth.31.1676295458150;
        Mon, 13 Feb 2023 05:37:38 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:71cb:950b:48ab:5f9? ([2600:1700:e72:80a0:71cb:950b:48ab:5f9])
        by smtp.gmail.com with ESMTPSA id di14-20020a0568303a0e00b0068bd922a244sm5271625otb.20.2023.02.13.05.37.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 05:37:37 -0800 (PST)
Message-ID: <7c8b6420-fe69-a190-9197-0ddbb3e4a964@github.com>
Date:   Mon, 13 Feb 2023 08:37:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] cache-tree: fix strbuf growth in
 prime_cache_tree_rec()
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
References: <ff3ac119-9b00-746f-470c-8db18c9c61a1@web.de>
 <a37623c8-d2fb-aec6-3423-2d402d717959@web.de>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <a37623c8-d2fb-aec6-3423-2d402d717959@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/10/2023 3:20 PM, René Scharfe wrote:
> Use size_t to store the original length of the strbuf tree_len, as
> that's the correct type.
> 
> Don't double the allocated size of the strbuf when adding a subdirectory
> name.  And the chance of the trailing slash fitting in the slack left by
> strbuf_add() is very high, so stop pre-growing the strbuf at all.

> -	int base_path_len = tree_path->len;
> +	size_t base_path_len = tree_path->len;

>  				strbuf_setlen(tree_path, base_path_len);
> -				strbuf_grow(tree_path, base_path_len + entry.pathlen + 1);
>  				strbuf_add(tree_path, entry.path, entry.pathlen);

Excellent. LGTM.

-Stolee

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C39C2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 04:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 225586100A
	for <git@archiver.kernel.org>; Sat, 22 May 2021 04:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhEVE0k (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 00:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhEVE0j (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 00:26:39 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C75C061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 21:25:15 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id ep16-20020a17090ae650b029015d00f578a8so8222959pjb.2
        for <git@vger.kernel.org>; Fri, 21 May 2021 21:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4ya4fPOzvFW3hjdWwy3GiZwImbrmf4q3S0LRu4vYUmM=;
        b=aNvxl3cRVJhf3nJpF4W++RgqXvV3hr+QU7p8LVxw4GrXtRJTsKdevP2WUDN/L1aLx7
         9w8gam9Q/GlNjOZZ0oh0K5YJvlU5uXsyWV0WkebzKs6JsIgqC/FDFSiOyIfakRQ4d/Ph
         rAmdnau606BvqwRa+9cySJvbHYpRioJoZtZKe5XV1qKAzERMBu373YTc3nGCoBgZxZRd
         fRVecgdlSpPt3CmV/o3sMcO9am7YmHiuMKuO66MPwhWpxAKjNs/Vyu3D1kk9GSMmTg1Z
         kvXSPb3hTQE69SxO6WxI7vWblmnHftyHXjal/VWNIGltDicDhTZmKuQZw5t+AO9RDXgd
         KYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4ya4fPOzvFW3hjdWwy3GiZwImbrmf4q3S0LRu4vYUmM=;
        b=G90IwMoU/Tn8Hv9JIlxChcm/cP1n3DuAKNzh8cQjoSO9j0ITh7C1lmk+6kNi7Cp7hJ
         xeE1d4ZVnKyRUaDFR980IXUwtx81j3WHihJW9cBQJIRDw3C3f95Ts8yJidYcLbnEBFWI
         Ngui7SqBq91Uo5/UZa0x8OvCtm5Kd96ypP9l1ON9a8Q1dOTk1sOGjJeXXffHRpwaIvgd
         9D+eX9+ws9rTEMF7PvBFhZoQ0REPmkxQsAgNuP/jJR3lJf/TMJe3xwOA1c9wlwybghS+
         hIdmVgBcJqinBtqHIhQ7dWwnl7VmGSS9FFJbxUXaP8aMPouVSuhCw+83Hmvnx5wmtQQh
         9Ddw==
X-Gm-Message-State: AOAM533qXBn7Qrgx5jLGW5Y9LiUerHzW6wWjW+oe1ZP+bo1ijDEY8vI8
        MHILY4lAyieyCsePADOIDx0=
X-Google-Smtp-Source: ABdhPJypKODRjvV9kUTyh7yQxKGsMKJjBug6eSQzgDFID2p+lBsP0U+/JA/2u7COgboFB8Xuwrs8+w==
X-Received: by 2002:a17:902:e812:b029:ee:ff2f:da28 with SMTP id u18-20020a170902e812b02900eeff2fda28mr15197728plg.15.1621657515036;
        Fri, 21 May 2021 21:25:15 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-19.three.co.id. [116.206.28.19])
        by smtp.gmail.com with ESMTPSA id i14sm5468295pfk.130.2021.05.21.21.25.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 21:25:14 -0700 (PDT)
Subject: Re: [PATCH v2 01/11] doc: doc-diff: set docdate manually
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20210521224452.530852-1-felipe.contreras@gmail.com>
 <20210521224452.530852-2-felipe.contreras@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <0c4ca3b5-7be4-1cdc-fbf1-b7a1541fe4b2@gmail.com>
Date:   Sat, 22 May 2021 11:25:11 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210521224452.530852-2-felipe.contreras@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/05/21 05.44, Felipe Contreras wrote:
> In order to minimize the differences in the footer.
> 
> Asciidoc automatically generates a date with format '%Y-%m-%d', while
> asciidoctor '%F'.
> 

%F is short yyyy-mm-dd date. AFAIK, it is the same effect as `%Y-%m-%d`.

> I personally prefer the latter, so only modify it for diff purposes.
> 
> Fixes tons of these:
> 
> -Git omitted                       01/01/1970                        GIT-ADD(1)
> +Git omitted                       1970-01-01                        GIT-ADD(1)
>
  
So, the asciidoctor generated date was the bottom one, while the asciidoc
counterpart was the above one, right?

The above one, however, was actually %m/%d/%Y.

-- 
An old man doll... just what I always wanted! - Clara

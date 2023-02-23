Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05C1C636D6
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 14:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbjBWOUo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 09:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234365AbjBWOUn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 09:20:43 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7C02A15A
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 06:20:42 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id g6-20020a056830308600b0068d4b30536aso2283917ots.9
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 06:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ipZzXq3Y7kwnUjxzVLjIogeR04wNQXZqirucXTd62as=;
        b=TDRZ05UImVeG0/ZTD0p/N/ksuuEmJsVaNz10eiJxxT/0gkj4E1FWO6zryVaVBwNrjn
         lF4J9EpvR/dVuA+K4EUNYneibGaLIeEBNHp1UHn8vSODLiclX1Q6j5AKF1OIPROYGUCS
         iQ1ilYjXqKcdEqnAAyJlgj57HXsIGNIKluwoMq2n/Iw2tFy1UcCIczzgGB4Mdrd0k2Sl
         JMW5mF+cLBAemwIDS/Ao4eHxw6EgLbgQyhDvIR36RPfcE+DI5EBryXZMtT5x4f+ML6bg
         yxbFhpMcSrQ0tlhpU2hAcDAXIUr49AgV/KVyaoFMq2vgGhh8vOaFXy+ZyU6bEsD4d9sG
         J4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ipZzXq3Y7kwnUjxzVLjIogeR04wNQXZqirucXTd62as=;
        b=tQF0k5bP2/ZyHGRFEPLVepyN0v4K3qRQxHHrWBOAgDlHUZGLJBZzPjD9T1DslFZkB8
         mm0v/RU8UkbjMONlewM4yMbj8pjj++oIjg1NL9J4a2hFC3+yFnxuPAxQolN3apb79Lyn
         3b7nYyX4Ci87YX0N6TvcFR2ryrMzyhLVgn5+B2FDR0gswW3dDwKVhtNgSXsQjwRu+5rg
         D+HZ2fVMq2AACa1ugQL9kmfUk+qHJDDdk8wUbcqxHXQmEl034a6XQzPqLxpMEIj+HICB
         YcIFJ/c3kNe+IHJH+D2Cae2oG0KmUlJUI6Z+XX25c1TM4KqNpUNEKKcrmRwK9LMJ3FRb
         YU8g==
X-Gm-Message-State: AO0yUKVT7ANOuJTSJTlNQzAcxJYOIs3+pFFdt9yIITMNU0rz4fxTXnLp
        wIdCBeNPE7IQfkEQ7ClaOFVf
X-Google-Smtp-Source: AK7set/FoqkdUMr2/9YFGcpe1R2bJ6ZWxrpYLRrwuYaZfneqpDRNg40s+os9CgsHVjbaG/AJXGetlw==
X-Received: by 2002:a05:6830:2656:b0:693:c3bb:8392 with SMTP id f22-20020a056830265600b00693c3bb8392mr3931419otu.7.1677162041674;
        Thu, 23 Feb 2023 06:20:41 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:e099:82d3:1307:6825? ([2600:1700:e72:80a0:e099:82d3:1307:6825])
        by smtp.gmail.com with ESMTPSA id g7-20020a9d5f87000000b0068664355604sm2405883oti.22.2023.02.23.06.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 06:20:41 -0800 (PST)
Message-ID: <1bdd1b4f-ca8e-5790-ef24-7e289692a721@github.com>
Date:   Thu, 23 Feb 2023 09:20:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 12/16] object-store.h: move struct object_info from
 cache.h
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Emily Shaffer <nasamuffin@google.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
 <c42261483cff903c8742fd8e1423ac0b14c65099.1677139522.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <c42261483cff903c8742fd8e1423ac0b14c65099.1677139522.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/23/2023 3:05 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Move struct object_info, and a few related #define's from cache.h to
> object-store.h.

> diff --git a/replace-object.h b/replace-object.h
> index 3fbc32eb7b7..3c92ae94610 100644
> --- a/replace-object.h
> +++ b/replace-object.h
> @@ -1,6 +1,7 @@
>  #ifndef REPLACE_OBJECT_H
>  #define REPLACE_OBJECT_H
>  
> +#include "cache.h"
>  #include "oidmap.h"
>  #include "repository.h"
>  #include "object-store.h"

This seems like an unlikely side-effect of the changes you're
making. What is the reason we need this?

Thanks,
-Stolee

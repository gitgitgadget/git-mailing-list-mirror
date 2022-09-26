Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3602EC07E9D
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 14:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbiIZOpo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 10:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbiIZOoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 10:44:25 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F177BC81
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 06:08:21 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bk15so2383133wrb.13
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 06:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=vz1Bp8dL3FiW6a9Exb2C2JMSCdz/wd8dI+ryeN8L07o=;
        b=AgvmQfYSFKnPJntSQ5XN+/Fgmg4buVdSRu6CMogQIZLm1+PucSYbiQUJjWevXheSQT
         6EOmET6IUmwRU1F4BEVqXZtgghsmjl9NRYsvNnty3gXReJ+vbBF0Ry7Lp4yT6Var8y+v
         6CIry/6XyOyHoOvrzECe0+Q3a61vSfL+qQl52Z5wY1zopY1owu36rQeol4heTwIRTka2
         T8ytmpywyB7d7UUXs3smhQZ1QD5aic8ydAnwn7+Skyf/9WmU12/ZFzuqiq5qjPc2KVvn
         8ibUvZB3ZAcGkWgFyI2LGCPntt+q/9fkhWABg7JBDEuk54nLcL1NExAlsGYLSm299ryb
         ghRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=vz1Bp8dL3FiW6a9Exb2C2JMSCdz/wd8dI+ryeN8L07o=;
        b=tTve2cufLlGPCKRSLmFB/TUAGSla2K8N6OV/g4nUmtgwhdUaUpM3U1PJs5PLV2ME86
         vE7JnaWps7b5wruMj4Cd3zVv70wff6ljtaoj61fOwJY4sbChmdEhqjrg28txZOiqSGQU
         sBQPM1WWuLJ0UgEU5RJeydsfYhsOPTt0EGfGj09Dw33024OoDj9C3DcoyqaXIr+BnKs7
         BjU/W9U16qqde/upP2Hc+OXNKXzKB7rPtKl/Xbl+HtAloN/Anl+EykJgHvDNnF9zAZg7
         5shZVZri1bw+epPwJfHli031a/O+Wz/kgjZUwtekfU8RD6XYVTRiObxyjnokb6DJHDbb
         wEGw==
X-Gm-Message-State: ACrzQf2YgvIKLxgM7Nns+vdZ8fmohwffeeDGFI75P2xB8tTDB2bt0XZv
        bC2y9I7raipxWpwUFqMX2qHRm47rAdNG+w==
X-Google-Smtp-Source: AMsMyM7oUAMmiYjroDf63AxyjenqnQRwwjKMuZ/Bc5vD96rz/jtalPQFWEUMHp/916zygpMe8AD++A==
X-Received: by 2002:adf:d1e4:0:b0:22a:34a4:79ab with SMTP id g4-20020adfd1e4000000b0022a34a479abmr12767664wrd.188.1664197699681;
        Mon, 26 Sep 2022 06:08:19 -0700 (PDT)
Received: from [192.168.1.81] ([31.185.185.144])
        by smtp.googlemail.com with ESMTPSA id bg34-20020a05600c3ca200b003b4ff30e566sm23748622wmb.3.2022.09.26.06.08.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 06:08:19 -0700 (PDT)
Message-ID: <2d886c19-09a8-c3cb-308b-b30ece02fb32@gmail.com>
Date:   Mon, 26 Sep 2022 14:08:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 02/10] sha1-array: implement oid_array_readonly_contains
To:     Chris Poucet via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Christophe Poucet <christophe.poucet@gmail.com>,
        Chris Poucet <poucet@google.com>
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
 <84588312c1d4a62ff6c6211e85b4e58ab0563daa.1663959324.git.gitgitgadget@gmail.com>
Content-Language: en-US
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <84588312c1d4a62ff6c6211e85b4e58ab0563daa.1663959324.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Chris

On 23/09/2022 19:55, Chris Poucet via GitGitGadget wrote:
> From: Chris Poucet <poucet@google.com>
> 
> Implement a "readonly_contains" function for oid_array that won't
> sort the array if it is unsorted. This can be used to test containment in
> the rare situations where the array order matters.
> 
> The function has intentionally been given a name that is more cumbersome
> than the "lookup" function, which is what most callers will will want
> in most situations.

It certainly is more cumbersome. I also find it completely impenetrable, 
I wonder if lookup_unsorted or lookup_no_sort strike better balance 
between being cumbersome and descriptive.

> Signed-off-by: Chris Poucet <poucet@google.com>
> ---
>   oid-array.c               | 12 ++++++++++++
>   oid-array.h               |  7 +++++++
>   t/helper/test-oid-array.c |  6 ++++++
>   t/t0064-oid-array.sh      | 22 ++++++++++++++++++++++
>   4 files changed, 47 insertions(+)
> 
> diff --git a/oid-array.c b/oid-array.c
> index 73ba76e9e9a..1e12651d245 100644
> --- a/oid-array.c
> +++ b/oid-array.c
> @@ -28,6 +28,18 @@ static const struct object_id *oid_access(size_t index, const void *table)
>   	return &array[index];
>   }
>   
> +int oid_array_readonly_contains(const struct oid_array *array,
> +				const struct object_id* oid) {
> +	int i;

array->nr is size_t so i should be as well.

Best Wishes

Phillip


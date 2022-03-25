Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E69BC433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 15:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359465AbiCYPGK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 11:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356893AbiCYPGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 11:06:09 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0274A76EC
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 08:04:34 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id j83so8425048oih.6
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 08:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WSl55pOY+PoMtXKVCtnV+uC9ly4NBpYyumHUg+KqEeQ=;
        b=EWI8vVdw7Xqq/+wRlw5Uxml6smGhvWXgjS2qCkJqg18ycPK5vi4qqUjCargb1/E/bx
         bhiO0YyS4nMyQfAWlTWwrdR/EcIoohMx6nMBTDYKxs/VCDs7a1NYsIPo1r74cw3nMGsa
         tXUB8mmaVxFfplPwKOD3GUQgkU+sgdY8bpYXYTk8gQYByRcsCVm23JFnlMEZnJwPNrt4
         HCc0nnFfxp0cvOaUiRgQvdk9OGfcDa/4w+Am9QROHMB3ZP0F144xaOr4BCPu7hpqk4BT
         G3DdvkyHuLXig5QYRQCO3tfoBQ8ct5YWV56AZl6EWXNCLOrj1RFGg0lSnRB1PrE/wEiF
         h5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WSl55pOY+PoMtXKVCtnV+uC9ly4NBpYyumHUg+KqEeQ=;
        b=En8+9JTFcrrI6AisPNJ08hUELTXh1lz1XDegbPUzSiQ6Pt5tRBwLSaGijGRecNs7p0
         Cvpxvq5HnTtzb1NfXw/mjcMVswpLw+EFG287QiLBWlOc5xD5+tFrfZywFU2UIxRW/5DL
         B9DrIxxqCpm1ir4ecC/R5nC/ga+F/YI01FonTCSA+UJAqVhq3x0B6u7oc6xwXG/LBb8H
         YH0YZj5739DscrY80hMOtWgT1X5CVOW+ZXNkDGUPidfv+mxz7WZlluHC4qj6MmIjd4DU
         Ny0jCjG1Dz7hwmLMK3d6VubKQvRzECKEM5nEC2N77diAChw/NjESJfihqff15kBMXSub
         1nDw==
X-Gm-Message-State: AOAM532vj68WY61rFTpP7mo/X6YukWefZMW2wFclIVGFtozeNVINnzjU
        3qCRPEdw8Pfrc0SM3uHyzhUx
X-Google-Smtp-Source: ABdhPJzPuO6my9C6zouE/SQmswf06ElOofFijcM4LIuEml4LZnedGaB1SbvPb+flBlztvWgB/d7LgA==
X-Received: by 2002:a05:6808:8a:b0:2da:429f:8cd3 with SMTP id s10-20020a056808008a00b002da429f8cd3mr5110557oic.98.1648220674354;
        Fri, 25 Mar 2022 08:04:34 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id q6-20020a056870028600b000d9be0ee766sm2623199oaf.57.2022.03.25.08.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 08:04:34 -0700 (PDT)
Message-ID: <202ec3ce-76ee-a46b-3235-e801339eb153@github.com>
Date:   Fri, 25 Mar 2022 11:04:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/3] reset: make --no-refresh the only way to skip
 index refresh
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Victoria Dye <vdye@github.com>
References: <pull.1184.git.1647894889.gitgitgadget@gmail.com>
 <pull.1184.v2.git.1648059480.gitgitgadget@gmail.com>
 <6d424915-5c63-bebd-f3b5-f153a541d077@gmail.com> <xmqqsfr7jmtb.fsf@gitster.g>
 <xmqq7d8jjlwp.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq7d8jjlwp.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/24/2022 1:33 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>> #leftoverbit: we may want to discuss if it is a good idea to teach
>> OPT_BOOL() to list "--[no-]<option>" in "git cmd -h", instead of
>> just "--<option>".

Good idea!

> Unfortunately, I merged these already to 'next' before seeing your
> comment, so we'd need to go incremental.
> 
> How about this?

> -		OPT_BOOL(0, "refresh", &refresh,
> +		OPT_BOOL(0, "no-refresh", &no_refresh,
>  				N_("skip refreshing the index after reset")),

I'm pleasantly surprised that this still allows --refresh (in addition to
--no-no-refresh). So, the only meaningful functional change is indeed the
-h output.

Thanks,
-Stolee

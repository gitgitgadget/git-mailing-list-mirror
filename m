Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0926C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 12:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349198AbiHSMyf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 08:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349205AbiHSMyT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 08:54:19 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C23132BB4
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 05:53:58 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id x5so3210227qtv.9
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 05:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=5nz2I4F4utiEmMiY/hSvZ68SfLxxuGTmAhBhSOZJaxo=;
        b=epefvzsrxTcYQQYj36Ul2nQ+omBDsjvyFGvwbtutbzmRwqMGzPTc1IkqkrTc8BCbgp
         RwgsW/cHV+UOjN4qj3jJeSNXh3jfZnnMjwUqL9Tn/HXFS+QO4VOI/zItWaUkGtGKFfft
         Jy6q8dDgoQ8/9qZLT+jcYoYGCstW6NL+SvM6R9VLQS6zTLwonooO0woDDkodmmMYh1UO
         9baAf30/l7BA9js2hfa4/Rfkp8vnSODtE6FvL9c8a+/pENiLkvQrqkXQSBUocbezSmcf
         z42Ty6nF5UgXIoZgnyr5Ube/8axksWPvAzlikBvvRt/ohZTgBQkJFMOk4JTryGW6b9ZV
         +sLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=5nz2I4F4utiEmMiY/hSvZ68SfLxxuGTmAhBhSOZJaxo=;
        b=hhU/va6c3k1syiV6p3PbywpullqmKdQBdlxeE+H4PlC2K0w8ivb2vT/qUCIo7xktVH
         VGjQJEHdEZT7ROYQJfKu6FkhR+jYnS4Rq01WZuyv2wrQeTToQqGJHOhYU2Jvl0bWgcIx
         bv8A0pVGriyFfOVPcXPLKgak8xstRXyIwavAE6REUTDJgriq380vBKBkCJAayfHvXXmq
         Aq6xGzsPXJDqWq67Nz8IEHeVbz88dxyTI2hkeyfwWfts8355ygJ3wev4vIA4041zZlBR
         11Aw9rYJ2NMNwwN1LZU6yzyR1s28NZJ7QSssYwU4C69VVwVP3AgAc3TyqxhTCufO84+o
         IknA==
X-Gm-Message-State: ACgBeo3dF6iv16svVS0YiUly8rbvox3VCetTvjzR5HevaET8lmoF2c6x
        /C15AUxJvJzVZARLdxDAoLWw
X-Google-Smtp-Source: AA6agR51Ou0aQpI3EHxvN7plfebl29KoMiuLvz464zb2vrdWfaqLoFljWXmWh5gJ0OkZNKE8gK1/Zg==
X-Received: by 2002:a05:622a:1485:b0:343:781b:d1b with SMTP id t5-20020a05622a148500b00343781b0d1bmr6373940qtx.536.1660913636935;
        Fri, 19 Aug 2022 05:53:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:55ca:650:1968:6180? ([2600:1700:e72:80a0:55ca:650:1968:6180])
        by smtp.gmail.com with ESMTPSA id j20-20020a05620a411400b006b9a24dc9d7sm3645598qko.7.2022.08.19.05.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 05:53:56 -0700 (PDT)
Message-ID: <7b7918f8-d997-89e8-2ba0-7bb31beb9335@github.com>
Date:   Fri, 19 Aug 2022 08:53:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 0/3] Allow --ancestry-path to take an argument
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <pull.1303.v2.git.1660803467.gitgitgadget@gmail.com>
 <pull.1303.v3.git.1660883290.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1303.v3.git.1660883290.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/19/2022 12:28 AM, Elijah Newren via GitGitGadget wrote:
> Changes since v2:
> 
>  * Incorporated Stolee's suggested patch as a preliminary cleanup of t6019.
>    Slightly modified his patch by:
>    * fixing the "repetitive" typo pointed out by Eric
>    * removed the unnecessary "return 1" pointed out by Ævar
>    * switched "rev-list" to "log" since we are using --format anyway, in
>      order to remove the need to call "sed" afterward

Thanks! I appreciate you fixing all of my mistakes and
incorporating all of the existing feedback. It also looks
nicer as your patch 2 than as a third on top.

This version looks good to me.

-Stolee

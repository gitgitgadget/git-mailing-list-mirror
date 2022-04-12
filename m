Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27A2C433EF
	for <git@archiver.kernel.org>; Tue, 12 Apr 2022 20:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiDLU3W (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Apr 2022 16:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiDLU2q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Apr 2022 16:28:46 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F977CDCD
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 13:26:26 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id md4so11243097pjb.4
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 13:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=f6DGSj4g0cNh09EAmqzSuIqdFLoX9+SyPu8xuGU/Gbk=;
        b=krBxt0TB9PfPO7PJDcD3+L+QAIySwudB7ka3UZ+ewjpmJmAjG6N2WFww450n1Dh8du
         TULnja1MtrQT7eRnqgQ5yhCDLZl6EoTHkO1d/Nt7YxsWOYeAqQioXblDNmqukekHDZt7
         xvOZAAw36gPiyevwsH8TIziPVzg7hoTxCUFWrLa2DKIuIez0G7sBTSqAvJFtIFFvR8vh
         ynk7FqgfXGxH2ZMv3qxwoMnaZKWQgZEqjYKjz8P00ZEanVbOWFr5/AkN66bHrPEuWh3E
         KqPACiXiuV2CKOnmV4zbHbZ5PVICSfomjYmH4XjcFUgOi7l/63TDuv1vJEXPIg/fxc9R
         ZzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=f6DGSj4g0cNh09EAmqzSuIqdFLoX9+SyPu8xuGU/Gbk=;
        b=GNNVqUYG+zAE1lK6qEFvc0s+E6HRw6ZbTR254TjjoFgQt/vUcC1bdhY0yrDqEG9p4I
         BWR4i1YC4pUuGdOOAwgvMsc1qZfZ/QodJNY0oY4GVj5VICuFmZs3eMouqu4+XN5N/k7Q
         p4FppcRA25lFdFbgECJ2fHGu8qKkxRuijGPtODDkjddBc5LQeZAGSsynYxtvcl6d5YEr
         jDbyjCLKi2yTLLlWiYZHM7crW8jC1sOS1nEFHlhnx1ldgXCSaBvA8WtWun4M4OwqcIMy
         J8vm1uxe/q9bCTAiFdOnU4RsBVUm/F4CxaW3SO1hO+ZUNp9OStxC5k1YHuuYGVHWr/QT
         J9BQ==
X-Gm-Message-State: AOAM531i6C+A6PaeQKVCW+Kp/2qw1ZwTKBJwQTSvRLbPgZHmzl+rP6fe
        IbNw72FIIjgFEUZ/28mT+/TgezZiI0cW4UN4
X-Google-Smtp-Source: ABdhPJxhiTHeDPDO0AMoy8jjm9pQjk07kcsp6h9bhw1FvCd8vGvyuDkWBEVBj61Hes76ruL6vr+Ztg==
X-Received: by 2002:a17:90b:1b12:b0:1cb:66b7:968a with SMTP id nu18-20020a17090b1b1200b001cb66b7968amr6962509pjb.71.1649794886959;
        Tue, 12 Apr 2022 13:21:26 -0700 (PDT)
Received: from ?IPV6:2409:4043:4c88:e096:3c28:bfd2:5de6:8af8? ([2409:4043:4c88:e096:3c28:bfd2:5de6:8af8])
        by smtp.gmail.com with ESMTPSA id k17-20020a056a00135100b004fa9df39517sm40230982pfu.198.2022.04.12.13.21.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 13:21:26 -0700 (PDT)
Message-ID: <5e1797de-e06a-c811-1e49-00e19b7e66c1@gmail.com>
Date:   Wed, 13 Apr 2022 01:51:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [GSoC] [PATCH] t1011: replace test -f with test_path_is_file
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>
References: <20220409114458.23435-1-siddharthasthana31@gmail.com>
 <xmqq1qy3igif.fsf@gitster.g>
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <xmqq1qy3igif.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks a lot Junio for the feedback. I will send a new patch fixing it.

Best Wishes
Siddharth

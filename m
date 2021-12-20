Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A38C433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 15:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238502AbhLTPES (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 10:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240889AbhLTPCR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 10:02:17 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0579DC094246
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 06:51:55 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id p27-20020a05600c1d9b00b0033bf8532855so40502wms.3
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 06:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=zCHcc3XQRGKwiAWbenRLoPcVFCK3IY6uxM4GiOz+LXA=;
        b=ogA6z5q9/qsK6rZgltDf/cPGjLhQ5/R7J4hNFAek+wlbd7No7koQmknFbGE8yhLd9b
         Q+MrtVrZ5UR+Gt68nRO7NDdPcdiZZMmMXasF2tL/DsPposkdL35RguqWl8yl8D/l9Xhc
         xcEnCZZ7RilfT9LjmiCejO7XU1x9I5ufTQjZ4NYAvQBIv8+Qin4x264fagObJD5iKcXY
         DHEziXYcbfm963Ywdvquyk/6JfvQ8ebYTHOqGpL+VOXiEnyy5AlkII+egwg8kcNv/Qsi
         SiLnj6NfY8kfByZHClVe17BkKmh09X1QKs0BxdqCRAu6JtSmmmlhiTLohtjSFmhey4MI
         NIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=zCHcc3XQRGKwiAWbenRLoPcVFCK3IY6uxM4GiOz+LXA=;
        b=jPUN6LT1sdMmaL5/5chiL5oDgv4sJNoF3I+a8MD87cFSvZEpg1urHmtQ+ba0aZvKWJ
         nAq65GWK2qLjomNO9dPioIF09igHFt0igN1M9dfDvcKYRuJiQiRZMRONMeRye70CmLcU
         B0XupRD5u8UXpWMZKzCDP0sj/X+GYqXwh2wAuApnnkKEQ0gAEAfe4kGEsHHH3dEjmiMY
         ttlKsNVDa7W1fq0a4OCNGlbSwqr+tZFvdabJ4OPjN+iS611m1XnYp7ZXcYpC6yKXn2HW
         d7f/DYJF3ALnq9RDoszHJYAQMEAovdhGpjPADeIH+xtRthCWmxQTsGucCSDYMcM7qSFA
         6/jw==
X-Gm-Message-State: AOAM531MG7sAY3CFFZHFFfaKCrzQZb4waI7Uh5xFsN+8x3btRWo2cygL
        rqldKerJKzlZ46SKiCGWlGT6aYJIZAA=
X-Google-Smtp-Source: ABdhPJxFoaoaOdd0lKFnAvifqFJ4rl4QMQbxSLILNcbtoi7NY5ClXGKbC3KZSS6cL46OGKW/bqK2jQ==
X-Received: by 2002:a05:600c:4f55:: with SMTP id m21mr21280345wmq.68.1640011913617;
        Mon, 20 Dec 2021 06:51:53 -0800 (PST)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id o10sm7771102wrc.55.2021.12.20.06.51.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 06:51:53 -0800 (PST)
Message-ID: <1de02f5c-2b47-50dd-f80c-708dd811e2ab@gmail.com>
Date:   Mon, 20 Dec 2021 14:51:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: builtin add interactive regression
Content-Language: en-GB-large
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
References: <20211209193625.GA3294@szeder.dev>
 <53fdf2c2-1e01-a105-6a20-8115f88b39f6@gmail.com>
In-Reply-To: <53fdf2c2-1e01-a105-6a20-8115f88b39f6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/12/2021 14:13, Phillip Wood wrote:
> [...]
> If anyone wants to take this forward please
> do, if not I'll try and find some time later next week to turn it
> into a proper patch with a commit message and test.

I've submitted the fix at 
https://lore.kernel.org/git/pull.1100.git.1640010777.gitgitgadget@gmail.com/T/#t

Best Wishes

Phillip

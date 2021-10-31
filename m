Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1D0C433EF
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 07:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37E3760E8C
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 07:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhJaHHO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Oct 2021 03:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhJaHHO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Oct 2021 03:07:14 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A81C061570
        for <git@vger.kernel.org>; Sun, 31 Oct 2021 00:04:42 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id n23so3572843pgh.8
        for <git@vger.kernel.org>; Sun, 31 Oct 2021 00:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JzvXpNHPnhXa1ni7YO0s94OB5r2GqBDBHsTCA1AX/18=;
        b=jYy9ElhGDL7vqTimq5nk1N5CCL8TCJVXdEGMxUSLX+Qwj8W+1WCmV1+RDe0P8txor4
         Ud1a5Q/6osbpZxyLCdKVBfm4+pzU0UKfmabIWx/FXyxvcnYaznNA7wwtOK29MCjuw5fo
         a1eGTeo2jyV566llttw+sWUqsEU2k2VTpIBu9Bw+36ArvEdpfmQnZlzFNHJn1Y53nuez
         H+PDE77h7hBXbt2FIlK/Ohi7qOApjDg8H1ZlOeUq55W84plqQ0iaxtDe13F4yHAtnbjQ
         Kw6/hGkxHo7oY1k+YorJOLMfAZxvuc4nF2KywvK/ryDDilchkHOssQXPh7Mm751GwMJA
         xh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JzvXpNHPnhXa1ni7YO0s94OB5r2GqBDBHsTCA1AX/18=;
        b=hTmHzGzjlWxnwR5jS4rEWfMENSX/G5BexQ+2OGKf/+y0VMBzTrni3wD4dY/5XWF6Xf
         8ixECi8chU/yXyRiSSWDvdTFE0dRijZhgr16uHKTTJEZEmPpW6bvwu7bezA/Z18n+ii+
         iv2dXkX/9it5G5zGDDg5xXLQWOo6rOtMnXes37e1TQVwpkDfGm47sXvNdaM1SVa7GgZU
         fCSdYTrUX2QXwK1JWapfP0e74UIZyRI2KSF+cLPP0H/ikxM5A5LVd00nyY4ISgXS9pWG
         o6KMMrG4wgCbsd3tnyNfDA+lr6pvJpZcqvxAnjHdSQxlh2d4lijO5IFv18+zMdV1eVC/
         fX0g==
X-Gm-Message-State: AOAM5326NRbi1J8RlHpgrkU4Iz2cFE2q8pRxrZaFvVvxaPARieG1D6DJ
        CGkY1EnlVQxqYxpvAgDhHCA=
X-Google-Smtp-Source: ABdhPJz8uX25S1FyRosAr2kbbzPzOpGc2OJpW3T4mLr8rSCiRljh0BjjtM6siYSqYI/H2LG095J0zQ==
X-Received: by 2002:a63:2a93:: with SMTP id q141mr9083068pgq.45.1635663882309;
        Sun, 31 Oct 2021 00:04:42 -0700 (PDT)
Received: from ?IPV6:2409:4060:2d9e:bfec:c94:c5a9:fe0f:3e04? ([2409:4060:2d9e:bfec:c94:c5a9:fe0f:3e04])
        by smtp.gmail.com with ESMTPSA id b18sm12945250pfl.24.2021.10.31.00.04.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Oct 2021 00:04:41 -0700 (PDT)
Message-ID: <2dd5cf43-31da-a494-077b-4cdfdd86daec@gmail.com>
Date:   Sun, 31 Oct 2021 12:34:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] amend error message violations
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Abhradeep Chakraborty via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1062.git.1635164026698.gitgitgadget@gmail.com>
 <211025.86y26hgtm0.gmgdl@evledraar.gmail.com>
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
In-Reply-To: <211025.86y26hgtm0.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Any opinion about this patch?

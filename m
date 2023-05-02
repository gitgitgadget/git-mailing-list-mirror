Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFE8C77B73
	for <git@archiver.kernel.org>; Tue,  2 May 2023 17:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbjEBRgO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 13:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbjEBRgK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 13:36:10 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B3B10CA
        for <git@vger.kernel.org>; Tue,  2 May 2023 10:36:04 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-24dec03ad8fso2192490a91.1
        for <git@vger.kernel.org>; Tue, 02 May 2023 10:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1683048963; x=1685640963;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uw/qJ90/QplQMxhSr6iGh1FzrkP4WalXrXqSN4EG0DQ=;
        b=Ssl0v635Rv/+OzHdLXTCWizWGj9URAT7G5/R5V7zl0f86/ivYtn7lmv8+RuK5gbbQp
         dpq4Uy1vqDQOt/9mbMk6qirgD13C/PByqGOp48w68s0A6LIpLgn4kvK4BAioMYv4/sRv
         HE/slWhGkFBQTru3aD/CmEmfnieTy0q9K3/QRQuBqqqW8EBHd1gj16btLIcHc07hihqA
         Q971h9MV3oYaMb17VtEMJ2kUmsZ3oSzk3v4uEWoEl2u3YXIPqmhTbtPu0DIjtD9gjabv
         z64cyYWN4Lx8OHCVku+Qyq5B3dCblKGEd9hgQygWYjV82QfrXZIFhy4imlJRgJ/ArMCg
         N+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683048963; x=1685640963;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uw/qJ90/QplQMxhSr6iGh1FzrkP4WalXrXqSN4EG0DQ=;
        b=RrwoZEYIGNdFowo/U3ZbaRPyrshEvTSQuErFYz+5JUdZkJ2j1I++2akuYEeXZBm1WZ
         at7ihvqWnjsN+b9t3gORQAn2CQ28GFjy9a49w+aUHT+7qnP75IgUJHnVE/m33fEpVZr1
         h+Fx5WLqGR7jeFusWCnbC3rJS4tEOY6mHX46UFAdtE8Go1gl8iJlP/c+WSBNcvUt/hOK
         I8vhKdWd2mDkyO6/+B4pRTVbQiJjRDVDfEnLE/QqDk0P3LFgQSZk62yJBw9DQVXjOHUI
         IE7ACdW1j2+Z5PwXG56OJBKVjWxGp9OTTzuKgAn9LbKKwfeYg7jG4fNBTaM74TvViBat
         aFYQ==
X-Gm-Message-State: AC+VfDxm7Nx7i6EqpgUWWsXlRly/WO3Gr3pMRhQlEkaHgLNrrpXIroMK
        f4TBI18XzCW9UJ3+sOfUY8jb
X-Google-Smtp-Source: ACHHUZ4CGLoiDRgrOx0lrDiRfJhywVD30+yjYXNWpNvlDnL61DRWDJxKVUnY84DZkM3vpk/S/t32Rw==
X-Received: by 2002:a17:90a:e548:b0:24e:40db:b46d with SMTP id ei8-20020a17090ae54800b0024e40dbb46dmr472931pjb.34.1683048963498;
        Tue, 02 May 2023 10:36:03 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id n2-20020a17090a4e0200b00246774a9addsm20757244pjh.48.2023.05.02.10.36.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 10:36:03 -0700 (PDT)
Message-ID: <522272ca-f294-b2c5-aea7-e264c9faab85@github.com>
Date:   Tue, 2 May 2023 10:35:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [GSOC] diff-index: enable sparse index
Content-Language: en-US
To:     Raghul Nanth A <nanth.raghul@gmail.com>, cheskaqiqi@gmail.com
Cc:     derrickstolee@github.com, git@vger.kernel.org, gitster@pobox.com
References: <20230422212500.476955-1-cheskaqiqi@gmail.com>
 <20230502094658.608646-1-nanth.raghul@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230502094658.608646-1-nanth.raghul@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Raghul Nanth A wrote:
> Hey,
>   Thanks for the info. Your explanations make sense and I will make the
>   appropriate changes. I had two questions I had two questions regarding
>   this: 
>   I have been trying to base my changes off the 'sl/diff-files-sparse'
>   branch, but I am not sure how I would go about doing that. I thought I
>   would be just pulling changes from some remote repo but I couldn't find
>   one. So, could you let me know how I could do that?

You should be able to find that branch in the https://github.com/gitster/git
remote.

>   Also, I don't seem to have been CC'd on this email. Just wanted to point
>   that out, so that I don't accidentally miss conversations.
> 
> Thanks,
> Raghul


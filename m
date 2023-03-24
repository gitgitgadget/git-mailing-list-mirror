Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CC1C6FD20
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 17:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjCXRk2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 13:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCXRk1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 13:40:27 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B749DC170
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 10:40:26 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id p203so3113814ybb.13
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 10:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1679679626;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZSMPIPadQXl+O/ZbuJUa4iTcvhvDo70Ew+iwQ09cWBw=;
        b=LmwE7dcYskRwrhp+CsQQz7fQ6qgNhfMlogJv3d/UHMmsvr8qzLIbkvqLyXrzjM1Fip
         1npXfzg1e4ofuHcaYEurv+xPbBurltTTbijB/qwkzU0j9WLmgvKleF6q5ni9qV98mBs4
         SYqs5lFfgTt90i78MwkkSbcnVWitamFjBDnyq9z8zS18rN18JdaJbVeQxiRHlqL1CY5U
         RJngFCags2i9qtQk69x2YrhRC1s/xPRcWQmtnQcRfqh0l9AiUS5sZLSJk5Eb3dcubIiI
         9V7ZVoAED3jgEOQFFSwVemHLnrO4WJpDAyqbTK+vnP5Ig4+eUvob9UrYrcHFs141s3nB
         Kt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679679626;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSMPIPadQXl+O/ZbuJUa4iTcvhvDo70Ew+iwQ09cWBw=;
        b=EZnicv1a1VTcD8+DjB227P3aJUqpQI1jPIfEPdnZx1CrW1S9PVrCELEgA6mUw/w2yF
         nVp9rBJccZgmxD3gvFbrvG8DBx0SuzcVS+n7tYV0uU1appjqMo7XcfjlwXz4yi7SmuM2
         ZDQ59mN9QRW3sL9vKychyhM4EdQnmL4BKP3M1S/XAUuD97B/APqq9BpufXaN4Y7Y8shi
         XrYHAFf1Fp/0W0N7osoFpCoz2l1EdUW112OGOEqel6ATE81v7S/R8/+6HNqgoY+y9KkC
         DrHS3EEI0c9Yx8L8krmD7t5Z0p46F7/N5U3y19RB8ZPfkM3uvJQfNIHqzELLM33ybPYC
         1pMQ==
X-Gm-Message-State: AAQBX9cDWb/MIHdpE+p20VTD/Fe0VOq1qt+ZW1zoQmA+PklDjsBAnYSZ
        Ed/Iloztrolx07ImCUI6FeIiJ25fuvOJp/eH2w==
X-Google-Smtp-Source: AKy350baWdhJCzL4Q9rql/qWxTF15GvIqoz4i2lvec6uL4ToOBsjVpYx8JKHt1VR4tQkM+HmFcHkYQ==
X-Received: by 2002:a25:3254:0:b0:b72:364e:f5e0 with SMTP id y81-20020a253254000000b00b72364ef5e0mr3255682yby.21.1679679625897;
        Fri, 24 Mar 2023 10:40:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:55e4:a877:13cb:cca6? ([2600:1700:e72:80a0:55e4:a877:13cb:cca6])
        by smtp.gmail.com with ESMTPSA id l62-20020a252541000000b00b7767ca7482sm568127ybl.31.2023.03.24.10.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 10:40:25 -0700 (PDT)
Message-ID: <4931e301-2fb6-0d4b-a7bd-f65dee87071a@github.com>
Date:   Fri, 24 Mar 2023 13:40:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/6] minor cleanups to fast-export --anonymize
Content-Language: en-US
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20230322173636.GA5643@coredump.intra.peff.net>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20230322173636.GA5643@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/22/2023 1:36 PM, Jeff King wrote:
> My goal here was cleaning up some -Wunused-parameter warnings, but doing
> so required a few preparatory cleanups, one of which actually fixes a
> really minor bug (in patch 4).

I saw this was on its way to next(?) without any comment, but it
really doesn't need any. Each patch was clear and created a self-
sufficient reason, but the culmination of dropping parameters and
clearing up memory is also good.

Thanks,
-Stolee

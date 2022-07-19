Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E17C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 18:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240025AbiGSSPb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 14:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240013AbiGSSPa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 14:15:30 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9322531930
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:15:29 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id f1so2300722ilu.3
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4N1CR9x/Jwj6+Rr+kq4LKwOMyfKLzlndWv0wpObTJbw=;
        b=Ak1VF7wzheChMhzzpVAg2x79Vx+q4IF8F4uBDhuTUakoDh2T503dw625jmMjqz+eFq
         V+WPqSrHBQcFgmvBmxKHYAtspTn6LgIDdkO1FCiKdE7V1O7B/grEedS+7X7LQSPSeuN/
         tJB6KACgOzzSEyGpndA88DabzmOrik+mF/SdOQM3/aP9JQ03IpBueaYosNnp+CM96DYK
         fkvgD/4c3WtD+NiTQjPU54yTM5Ub89uRViZXQb9VVWhdlf9Y/dft/se36XxdlQPTISa0
         /VPnAVSxKD5PipuNprNAswe/1zMSfswauPBtk6DhX3S7sLXhW2EB4JqIat9qN6jdtlXh
         4IWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4N1CR9x/Jwj6+Rr+kq4LKwOMyfKLzlndWv0wpObTJbw=;
        b=fc1YdbKG4yDpnHUXNnkt/3hdBRh9EOmD/4hcBEfAZd/C4s+Vy9CHV4/Ebbg4x4y/8G
         R7KmR3bBd07GJRrpinHcsN2ktyP7s1xh9tiVELr3Sa08P8Nka8VNecIEDttuX5hrVHpu
         RKN0FjH7NMzq4OqbbBk9CEQF6v7nCSjbMc0ZIp42jCouSe9IMRBtWmTZP5fZR3GFkdiq
         8UEUBYnOBCIQPftlBr14ASXMk/hu7iuHN2exBcheZ2XMexOwNn1s7bDOdUXx/cfoiGOx
         Pb96KV3Fb9Z7Pzlyh+uzQsKy1z3qcH9kSWEN7e//HAZCc9AqCVBwZEeIn9JAKmunS7Gz
         chAQ==
X-Gm-Message-State: AJIora9mfZPnxWvHVGbpgi30kOGzt7kZDoIBisZA95wjYmKe0gSQQbqz
        b1ixTmmy0tNGbo0Z3BFb63qOfXpnVfqp
X-Google-Smtp-Source: AGRyM1umkthRlmMsW3lWX7ubgb5M2jNC7oz8mZl3S6LxAz6b7R5K0vwx2TVWs3mVhCyF6VEfjgz3kw==
X-Received: by 2002:a92:7f12:0:b0:2d9:1e05:6310 with SMTP id a18-20020a927f12000000b002d91e056310mr16445162ild.317.1658254528971;
        Tue, 19 Jul 2022 11:15:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:3950:7a99:4a4a:8622? ([2600:1700:e72:80a0:3950:7a99:4a4a:8622])
        by smtp.gmail.com with ESMTPSA id v20-20020a02b094000000b0033c836fe144sm6953721jah.85.2022.07.19.11.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 11:15:28 -0700 (PDT)
Message-ID: <97586f49-1d06-636a-200f-00b68930ed5e@github.com>
Date:   Tue, 19 Jul 2022 14:15:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 7/7] mv: check overwrite for in-to-out move
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     vdye@github.com, gitster@pobox.com
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220719132809.409247-8-shaoxuan.yuan02@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220719132809.409247-8-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/19/2022 9:28 AM, Shaoxuan Yuan wrote:
> Add checking logic for overwritng when moving from in-cone to

s/overwritng/overwriting/

> out-of-cone. It is the index version of the original overwrite logic.

Code looks good to me.

Thanks,
-Stolee

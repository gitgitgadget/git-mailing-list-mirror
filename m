Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A346FC77B7D
	for <git@archiver.kernel.org>; Wed, 17 May 2023 18:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjEQStS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 14:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjEQStR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 14:49:17 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFB4FE
        for <git@vger.kernel.org>; Wed, 17 May 2023 11:49:16 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ac4910e656so2920625ad.0
        for <git@vger.kernel.org>; Wed, 17 May 2023 11:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1684349356; x=1686941356;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0zsX5MP2ARFeg5lz8xH0NzotzkZs9ij1NYzJl4LbzIw=;
        b=NP9+vyPYrhr9pLxTCyUMu+2NXAj5qbXgDkvNghKIL7dv0ZTJlDxjdCHeGo455T6rcw
         BvY6MfaEMIB0bE9v02dkFw7MDPhyoYnNpCTz7F/KvjjNvj7EcIgVA5H4Kx+OMHklsOkS
         Q2jltp03i1kESnhvUUGTSM7+iewwmFp5SjQBrmoaoTOKiLIuhe5cQGufDWHWpZEd5/ZY
         cbgm336QXIcze1J2zwZvFlBSm16aZn/x8lkg9GCRijmBezOVtAaqmpl683KmsB1d/PcN
         TxFT6OZiBUKGoocbBreml32KQ9eYexC3jyw1TKH2R7BqieFOQQBbsr+ifdpJGB6JrwsR
         FwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684349356; x=1686941356;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0zsX5MP2ARFeg5lz8xH0NzotzkZs9ij1NYzJl4LbzIw=;
        b=e8Sq4q/ZsYpUQhboDRdOzFYv+VpeyZV0DSuJLAYBYhuHrf50v7wxn01TLeKPRguUoI
         Fq9wSIllmfVklelm3FVUuLwJEgIyYdqf89abREWYO/U0wjUmzo4kVAunG7TBmwklXZ/8
         NcHVvgRGhHRoc50P4EaI+ZkMP28GGfnS/P5jrl/nosyOEuek3RCzEpQ8OlssTk+H5xHb
         eL4F5iCDm4Z1rXYcejP5xzffmFUVNVrP+13P8k1xGv3LqxNt1Q3sCDszI9y+Fsb/8hEy
         V9P3sLLycZ+o84n3VdKWUMM14oEW5aY9eDfzr/KVdPs/g+1K8rXypWsKYqRyxvJtrVmf
         R4eQ==
X-Gm-Message-State: AC+VfDyg+ibEbao6xSUBM5/u5AnVcs/SFAPn/dLr2fxZZAJiU7vIGtCH
        VIZeQvQo7fHtoQE4y6AXXh9S0+I9u/IYFowGPQ==
X-Google-Smtp-Source: ACHHUZ4qaO6b1nfceL25IxH2SKLXxB6Y1Gy7oJyiyfeI9/+QTJi01ZFwJhO6h96XlRbSj3ZHDyzFUQ==
X-Received: by 2002:a17:902:f541:b0:1ac:750e:33d6 with SMTP id h1-20020a170902f54100b001ac750e33d6mr3519442plf.23.1684349355735;
        Wed, 17 May 2023 11:49:15 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902e88300b001aaffe15f39sm17912640plg.30.2023.05.17.11.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 11:48:09 -0700 (PDT)
Message-ID: <2d99fbed-3074-be22-2b8c-a75dd22bda65@github.com>
Date:   Wed, 17 May 2023 11:47:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [RFC][PATCH V1] diff-tree: integrate with sparse index
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org,
        derrickstolee@github.com
References: <20230515191836.674234-1-cheskaqiqi@gmail.com>
 <fa24482c-7c48-9b7f-5d97-3dbf9822728c@github.com>
 <xmqqsfbvswci.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqqsfbvswci.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Victoria Dye <vdye@github.com> writes:
> 
>> Note that, if you want to make
>> that change in this series, it should be done in a separate patch _before_
>> this one (since dropping the deprecated setup infrastructure isn't really
>> part of the sparse index integration).
> 
> Or after this one, perhaps?  I agree that the clean-up opportunity
> you found is very much unrelated to the work to teach diff-tree to
> take advantage of the sparse index.

You're right, it doesn't need to come before this patch (or belong to this
series). *If* the cleanup was done in this series, my thought was that it
would be (subjectively) better to end the series on the sparse index
integration. However, it doesn't really make a practical difference whether
the cleanup is done before or after this patch, since it's functionally
unrelated to the sparse index work. 

Thanks for the clarification!


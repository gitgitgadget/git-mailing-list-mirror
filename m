Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD2AC7EE2D
	for <git@archiver.kernel.org>; Mon, 22 May 2023 19:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbjEVTH3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 May 2023 15:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjEVTH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2023 15:07:27 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E553A7
        for <git@vger.kernel.org>; Mon, 22 May 2023 12:07:27 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ae452c2777so28307995ad.0
        for <git@vger.kernel.org>; Mon, 22 May 2023 12:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1684782446; x=1687374446;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DKeX3jAG+Y+G5G5h0xhU2tDh2Lk+CJRbksVlSmkDfrE=;
        b=SrfLw8O1VUwC/ByvX0wRUqhcWMU+o/X64DPT8FV6LLbREFW1K/KNgGEwiJNfEQBBZT
         jvFkDUbrC3MLE+GVyJ8d8c/n/dyVCiiyxsEEYjxzJexP1VN+bckrtFUgkJQclDKXXYVO
         yG10/k36FoS+oLIh9h5xjErjPOajPElCOvnwCT58KEzRIpEIhIB08UdenkqY9/QaDzAS
         F4ubSa28JH2bOsm1etIIWxH/SDlwrb51UfNf9BfL9tdKMv+joDfOY7kjqruD2UuD1UCr
         dzRN9GwrG+BXRE3tWLHOdDfVhkDTmTWdGKv0uIdX1oOXmXsLYD1uEIvx/cX8lcjxSHS4
         Leqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684782446; x=1687374446;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DKeX3jAG+Y+G5G5h0xhU2tDh2Lk+CJRbksVlSmkDfrE=;
        b=hdvkvm33WLEUCfZqzznOnM+bxXBRmLp/8UMs4UjKfjGVbdhWQm4993og5RrE3AVY8w
         6vwC1m9SnLJ9gfZG9Cw/VqQOI839PRQ1bhVsyWKbSf8Kp2U7yAhCDqkx1zZUkOzP/8JH
         oVZPTMT4HtExGPjBuHxYTjbu0Lv07m76sq7eVOTgc/rLR3qcpvfpoM+/R109Z2HDGkDn
         8SAC9zbMUmD+Lc7w5qrURt2Q1PRl1zSElQzHrZ+OKvosFBD5TzvhcKxCWEKS6m0VTqiK
         Lqc0vnKboomVp0Y2rNJjE09LAVvoTl6jiIKJXiTklmnfNftJugb0ezV/wNCBOsQAEJBH
         mO2w==
X-Gm-Message-State: AC+VfDyr/WEDh4cK5bqdEMQtf/IeIUf/lA0q89S516T1dm4iBcTPEpas
        EU5G74+B60ILMGgBVsGbvP/LdfFivZ7bwSUQ9w==
X-Google-Smtp-Source: ACHHUZ7BrinRKxXBFI1RO+/OXTnv1gxsNk2zlnNHTIS4TtXfsR9LYJyxPWPSWUi69r7+htsiiTyqzg==
X-Received: by 2002:a17:902:dac8:b0:1ae:89a:a4 with SMTP id q8-20020a170902dac800b001ae089a00a4mr13188749plx.8.1684782446569;
        Mon, 22 May 2023 12:07:26 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id l12-20020a170902d34c00b0019e5fc21663sm5177177plk.218.2023.05.22.12.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 12:07:26 -0700 (PDT)
Message-ID: <2a2b7223-bb5d-65f9-95bb-9be45d329c87@github.com>
Date:   Mon, 22 May 2023 12:07:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH v2] diff-tree: integrate with sparse index
Content-Language: en-US
To:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, derrickstolee@github.com
References: <20230515191836.674234-1-cheskaqiqi@gmail.com>
 <20230518154454.475487-1-cheskaqiqi@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230518154454.475487-1-cheskaqiqi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang wrote:
> Change since v1:
> 
> * Update commit message.
> * Use existing test repo to simplify the test.
> * Add test to ensure index won't expand regardless of 'diff-tree' a file
> inside or outside the cone

Thanks for these updates! This version looks ready for 'next' to me.


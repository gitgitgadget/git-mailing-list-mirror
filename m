Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1680BC7EE23
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 12:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbjFLMt1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 08:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbjFLMtZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 08:49:25 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E12A10CC
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:49:23 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-3f9a949c012so38405891cf.0
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686574162; x=1689166162;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWdXL+ki7Q5/lEu1fCu+egqbvALkBE/ZpJw2LhdfEBo=;
        b=s0UPVY6A7urYtnufy8u0VJRx8HRndV+egiITjX9irSRtvxjevpwe8kry5I07kcupWX
         FAjEtLinFqhMNGRBUuVLvddaCQXhlQBxiXi2WLRpS8uGfcupsVjAPpdNDMh6w7DzXd3i
         037cm5FjKT8KhV9NwkRUeh4Kj4Xg3TTQHSgH7asXOOZvFQXY3AIF2FTvmFF7VOXb41h2
         x9emwDzuECC4ow+5PqEoIjppWkyJ4l2/RHKfPmG+lC65Kgz49S/gFHrZGgflmfZNWsoY
         l3oDrh6W6Pwa6ucpljV2x9QyWSSFznwbg9pUnTjDc7oRKSSetREJEFvKDurGDa+8RIPs
         rPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574162; x=1689166162;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pWdXL+ki7Q5/lEu1fCu+egqbvALkBE/ZpJw2LhdfEBo=;
        b=KO5NdkRijz7gcqNG8s8LEiPlNCqPwT2AV5z8d/kSG13CzTNEI4ZXCbYShRoSCexDkz
         /rEXhBuXw4ZSxIXFqU8KtvHxqkRJjAsn4zIU01C3VRYjdjDHWDLy2sqiwL9vLLrkTpT7
         OFsfrcjxXpWWCf50Zn4G5dS+7pZXvYodINX4H+Pq4boGvA5P03KTdzSWEWG1IiHrlNpx
         CB0TJjn6heV7gFFDb8tNqrKHottaH8B0FKs3BRt6FnzWU7n+IW74bZCHlTCsHJYx+Vgq
         c/P8WFx5SVKg8hE7Yx7U9VwquzT5jJEMijD+1QpMxb0IpqmNmZ8gdkHSF0JTRXCpZbpN
         tbzQ==
X-Gm-Message-State: AC+VfDykQfj1wyEqhq9e5nKZA7iXq529AsodzlNlTvqHiwjVg2SnPePM
        ZyWA9GOncIaY/VbLVND7d+P/yIBjg1c=
X-Google-Smtp-Source: ACHHUZ4qMdZQ0Ysqpry1Cp1VanSlJdc9Ta7adLKuyO71gH1r3GDhsTKs04HiyCju+FF+i0HW5+lCAQ==
X-Received: by 2002:a05:622a:15d3:b0:3f9:d266:7be7 with SMTP id d19-20020a05622a15d300b003f9d2667be7mr9630918qty.42.1686574162238;
        Mon, 12 Jun 2023 05:49:22 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id i18-20020ac860d2000000b003ef189ffa82sm3331223qtm.90.2023.06.12.05.49.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 05:49:21 -0700 (PDT)
Subject: Re: [PATCH 21/25] completion: complete --ws-error-highlight
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Philippe Blain <philippe.blain@canada.ca>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
 <f8246a2a581f3bb1e424da6f2cf6d8f5b377f2c6.1686428485.git.gitgitgadget@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <1a290787-9756-3d07-f95f-3915299cdb8b@gmail.com>
Date:   Mon, 12 Jun 2023 08:49:21 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <f8246a2a581f3bb1e424da6f2cf6d8f5b377f2c6.1686428485.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 2023-06-10 à 16:21, Philippe Blain via GitGitGadget a écrit :
> From: Philippe Blain <philippe.blain@canada.ca>

This is a operator mistake that has slipped in. I'll resend with correct
author information. Please wait before merging this to seen. 

Thanks,
Philippe.

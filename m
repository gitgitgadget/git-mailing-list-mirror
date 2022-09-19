Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4D3ECAAD3
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 15:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiISPEz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 11:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiISPEy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 11:04:54 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63295DFFD
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 08:04:53 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id o184so14981540oif.13
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 08:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=MU7Oq/t4g/p16/9u7WZiUsp/iGHMWRZjE7XRZWHJCzU=;
        b=ipjfhEur6T+kJ5vMBYIPDCKBAm0MPHoJW3eNs3JklFkbRwvOliCwgkNUQncSrPwd2l
         iIQEQ3eb7x0MFg3PEeQhDguepYx5WCOJvkzcWI3wFnGh20qYlVBk274YAhQq2dWVhlxz
         Xewb6fUtRgZ8ChO0t2b6C8B2J3AiIIVmPOUFwb5ln5yO7VOXiWllbT1PljgMO91CyGuS
         agIuelRMxW1rrEmOM4K2k1Ofyx7eBNd9ovS729dqVxgEWExO7resDOoCjlekn2N7XsgI
         rshBG5NIH9fhmQ52is8zAjSBdx4Ok4J0ZIoSvwgR7EMI25pieMb8ToJwP8l2hbw6nORm
         F5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=MU7Oq/t4g/p16/9u7WZiUsp/iGHMWRZjE7XRZWHJCzU=;
        b=P9jpuWtCWH1WygsdYLxvm1eT//PriNYFrQgi5hH8mFKVzYUP1lBPdKs8f1QCeWgNeN
         J3Ri7YlOvSvr80wYczr4SM9Hj19PLSuxaJ64ntGAd4dcmHLJl49YEZHYAjqOMXsykQ9u
         8APgnshOI7aR5N/jO20PcCv9s4aH2dzSerch2ToizXwnry1ipI1JSr4P95M1BNBJ270G
         bggBjtf0qm/66FgzNe/2Vp61zvuE/VNbXrVg74Ji6J9Qc0xsepYjGcUs3HGbfQfv4i4D
         /iohcwxydQfjq2i18ge8+QefHMeH97nBogNDWXCaqcW64/jAvZOrVREN0kAMxMW9OzRg
         nkfQ==
X-Gm-Message-State: ACgBeo20tpc35jMN064zubTjaSC0c42Ba2NNTdnVk+miTBQYMBKu5mvZ
        CqzfnusJAOWjf9capLumdSzL
X-Google-Smtp-Source: AA6agR4dB/gBanT1UjWhO8MPWWUHFVAVVx+DLQ+jPvPvcWTev0J70PjKHgTrX7ms3cY2z03FwEFShA==
X-Received: by 2002:aca:240b:0:b0:350:3bed:5893 with SMTP id n11-20020aca240b000000b003503bed5893mr9457422oic.180.1663599892653;
        Mon, 19 Sep 2022 08:04:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:fd97:43ff:6c00:2cf8? ([2600:1700:e72:80a0:fd97:43ff:6c00:2cf8])
        by smtp.gmail.com with ESMTPSA id e3-20020a544f03000000b00342e8bd2299sm13333982oiy.6.2022.09.19.08.04.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 08:04:52 -0700 (PDT)
Message-ID: <4f1cf64e-2864-a979-6f75-d9d4148d57da@github.com>
Date:   Mon, 19 Sep 2022 11:04:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2] commit-graph: Fix missing closedir in
 expire_commit_graphs
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <20220919141441.5644-1-linmq006@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220919141441.5644-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/19/2022 10:14 AM, Miaoqian Lin wrote:
> The function calls opendir() but missing the corresponding
> closedir() before exit the function.
> Add missing closedir() to fix it.

Thanks for the patch, Miaoqian.

I only have a very tiny nitpick with the line breaks in your
commit message. Either the "Add missing..." sentence should
start immediately after the previous sentence or have another
line break between the paragraphs. This shouldn't merit a
re-roll, but keep it in mind for future contributions.

>  out:
> +	if(dir)
> +		closedir(dir);
>  	strbuf_release(&path);
>  }

This change looks correct to me. Thanks!
-Stolee

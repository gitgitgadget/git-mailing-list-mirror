Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD1EC636D6
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 14:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbjBWO1V (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 09:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbjBWO1U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 09:27:20 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F055584A2
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 06:27:19 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id s12so10907447qtq.11
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 06:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cyTM4VlL4mpe9uDG6A3xJdK8N8sCqNwqqSUq7gjTit8=;
        b=iBQlNNP/2sStPEEGzFVlxilDv3X4gQMs7JRXiMIIFLowVqePxAHqC+aaU3HX2gDDov
         6tqPMze/OEL/ljSUSWWavf98vZI5Zf596ohGI0sqxplZRE/i6xMFNFYTYqbAeDwzV9tV
         4/NZg6WOB+s95FUD6til+GDUbPhW3E93iXMnLfHrzYXqQtX+h4TnqlDAM8IAg9OitsOH
         WYhzKuSikNQ5XhWXTRLAbVmmooxHGWJSAV/e+oWPMmxRadPnPV7C+6txllxJemUPCs7m
         y8OQbHYMlHEqkPEXjYRch3jgMOGw6j4Za7+LRlonB/ZNGQQeNHaMnpCK1g58t349+NPT
         ZG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cyTM4VlL4mpe9uDG6A3xJdK8N8sCqNwqqSUq7gjTit8=;
        b=zP0llet0ce5d4fgRkCoE0U2Bi92Y2kcREVjFuZ70yrlfMmC3w8C2tzYx/tEZGGXqam
         R4XbbaX9CRRmsJ7r2x+8mlEIRUK96UN6PeDjXHgOjIox6xEA+yRoUNiVCuZz/xgVlo2u
         svEDDrHhZzglACapfg7ltQuAO0ZI5FbrdC5RSMT6WF+qMwbOSNojXJ/5zcyoN8U/Kkyg
         oT5k3JjZGSTutdvDLx6U6ysCJt56hYeva1HljDhq5+kXd9ISN9KrFcYwQKZnnzJ5uQWU
         yeMZ1HmJ+t9445V6dfmQmPFzrE8xxnETsfGeuKPSgJNTgPdjGMrYhkiiqvdJYDzYXQ/m
         0G0A==
X-Gm-Message-State: AO0yUKXhF4gOtm3ECdvJnE+lrQNM0oFnjW9+OTtEYLaDzRrgmoRMGycK
        T1gDaxvGhRvvVCwvh3h6y6ly
X-Google-Smtp-Source: AK7set+yd636ipBqsYbv1WBuy+dwH71f9CuK5wIOOSElJb14QW/7meCN5G+QFmvyzzv1HA0Lw6/K5g==
X-Received: by 2002:a05:622a:183:b0:3ba:1acd:4f8 with SMTP id s3-20020a05622a018300b003ba1acd04f8mr20184707qtw.42.1677162438190;
        Thu, 23 Feb 2023 06:27:18 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:e099:82d3:1307:6825? ([2600:1700:e72:80a0:e099:82d3:1307:6825])
        by smtp.gmail.com with ESMTPSA id m19-20020ac86893000000b003b68d445654sm725066qtq.91.2023.02.23.06.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 06:27:17 -0800 (PST)
Message-ID: <4ef6665d-b924-6f81-06a4-b51ecccccfa8@github.com>
Date:   Thu, 23 Feb 2023 09:27:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 00/16] Header cleanups
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Emily Shaffer <nasamuffin@google.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/23/2023 3:05 AM, Elijah Newren via GitGitGadget wrote:

> This series cleans up headers a bit, trying to remove excessive dependency
> on "cache.h". I created this series a while ago, but decided to clean it up
> and submit it due to Emily's recent thread and suggestion that this might be
> helpful to their efforts[1].

Thanks for doing this cleanup. It certainly doesn't look like an easy task.

I read the patches carefully and tried to point out anything that looked
fishy and not fully supported by the commit message. However, some things
are probably only fishy because it was the least-complicated time to make
that change.

I'd be happy with this series as-is, allowing further improvements on top.
I just wanted to poke a little at these bits that were not super-clear in
case there was a possible improvement.

Thanks,
-Stolee

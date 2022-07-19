Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE01C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 18:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239829AbiGSSAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 14:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239786AbiGSSAs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 14:00:48 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1B25246D
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:00:47 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-10c0052da61so32917149fac.12
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RikSS8l3wIQiMHNAKro/YhPF/BNtPfc3y3HIY+ZueEw=;
        b=SXVgm/CykrsVJKQfgflTBnv6bJbeKKkgf8GsGUbWlf1S+50yjFSalmw2ebyS4Jc9ja
         ZzF1pI47n1Tvf3qo5uog9dK/kUpXe4OSKKUvNQod/Ai9H1ez3e7wIpxiOKpEAZeYlU65
         2U0aDeqlbY9eh7olOyGcZjx+itLKaAGBnUeva5rdrWShLZk+Mlsnsrzr3ZLGd1xI5OM0
         QPfUMFdwKTZ0vkpJbxDQQ2+i96DubKYOEj4mWNJ3UZ4/Fv0PVVLkPxAzcbaPWgtuRyzE
         I8GMrvQiXL70t8QKKk+YmMn4B7a/8H4O1b7kiKlVahlNVJQsgYsXIuEtn1cLVKNFNIgo
         Oh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RikSS8l3wIQiMHNAKro/YhPF/BNtPfc3y3HIY+ZueEw=;
        b=eynP3HGwfzldZ4B8sB7HvR2Z9y0NNI0ZEJlWvQjZLDgG2sgbGOZ4rWweGfiV+qNioe
         1f3PUc6LC5w2U1sFnLQMe8En8txhT99R607g8WQ30hOJK2o3FE8shr5cn2CUsf1a7oiG
         FMG9IUWWNhjCWLaIvScCoRyQt6mom+/NA1wEeAsjO8tGFaGv6d2ZwhGi/yMo5KCvqFO0
         5XTuoBKW+KmV2fQpJ5NZNrnH681/vjrwveeYNGtxWLwZ/tBJ4YRB0/F6E5iHQNHo0Wwg
         qwlgZT4VDnqEreOlUPqywn7BKa3J9LcuoYI9F8pxw549u11L3dH9DhOIMQE5zyPo7QAU
         ZumA==
X-Gm-Message-State: AJIora9wNZ8jANmIBFwmaN+K+MwegZfGeHgXdufX4enxh96DTl9SGoaK
        lkE09ZC8nxw5IKxpcyutfyRf
X-Google-Smtp-Source: AGRyM1u4PKiF6WXa7eh9YgMNf11+fUS8w1TGIJ6YUBi3hgSVKcDuABd1IwhrEMLo4tGzF1bxym9ZuA==
X-Received: by 2002:a05:6870:178d:b0:10b:e0fd:c27a with SMTP id r13-20020a056870178d00b0010be0fdc27amr353483oae.64.1658253646801;
        Tue, 19 Jul 2022 11:00:46 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:3950:7a99:4a4a:8622? ([2600:1700:e72:80a0:3950:7a99:4a4a:8622])
        by smtp.gmail.com with ESMTPSA id y11-20020a056830208b00b0061c4a7a37fasm2468415otq.41.2022.07.19.11.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 11:00:46 -0700 (PDT)
Message-ID: <4996a896-cf92-7fc7-40d3-dc3e74e804a4@github.com>
Date:   Tue, 19 Jul 2022 14:00:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 5/7] mv: remove BOTH from enum update_mode
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     vdye@github.com, gitster@pobox.com
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220719132809.409247-6-shaoxuan.yuan02@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220719132809.409247-6-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/19/2022 9:28 AM, Shaoxuan Yuan wrote:
> Since BOTH is not practically used anywhere in the code and its meaning
> is unclear, remove it.

It's literally not used any where. (I would just drop "practically".)

Also, now that enum update_mode is a flag-based enum, the 0 value cannot
have any meaning to it except "none of the other flags are on".
 
Thanks,
-Stolee


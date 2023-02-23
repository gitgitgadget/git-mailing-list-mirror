Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F17CC61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 14:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbjBWOI1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 09:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbjBWOI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 09:08:26 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C107497C8
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 06:08:19 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id b6so4619875qtb.1
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 06:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=odMWCYzJufO2Ck5wIgD1GKZeCiYOWxYWZVOS+S4GE3Y=;
        b=ET+xwhyaD6rAVkqpX20asSlz/uCpIJD99eNCALa2/9e+HivknEH/jizO74wHFm5sQL
         8s5M2xYzPxBfd7gUzo3Sm26noOX5LpHuxV12UTxyoEF5tQNnj5uSamds/TGMK4IV50io
         rkZNqX0pmKYO+4q72EiBCvCTw/k1QmxMqCxd+ee1UD9Ocs88pbBUFH3o64Qnv2Vb6tTf
         5WhUnAQnxdLnHTuZUQxQ6X0S7owHanYorAW2R2p1naOmfSSnXtvVHbTLXwMXGGlGhIZS
         eSEVGmYZsmjOwcv3lNuV5hFOPbQ/g3RI9wOhzKc/G9suTmzVnGuPbFiMdbPfSqj6peHT
         LaMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=odMWCYzJufO2Ck5wIgD1GKZeCiYOWxYWZVOS+S4GE3Y=;
        b=I1yoKc2tssRvvfWa5epjKn6YwAXUDO5MrP0M2xsIqnWZDJ/NnDOd+Yw0kzNPrYRZZg
         ce7V64VhZlWOjpH0W1s4ycdevvsvqnAF8/5Z4xXYCl+FlO7AYcTx2SpP4233Y+1k17IV
         Qiqkjh6FawFrpZjnFgzRCe86HbN2QC6/ZkE1oUl0KdQ+CvtsJhxrbHGailwl4v14dZmA
         C1jxSpgQzZxU4td5CQuZOvbdQ+w6gFAAHEhZF/ka76LBqvQkXqoG62B1tuk0gQLYQrGs
         yNV4P0gfp5q1S1j5hZX+l6OQfUopCS44O3n6jo5878pyxQQCUd0HRwvOftCP7EoKohz1
         VxLA==
X-Gm-Message-State: AO0yUKU3k1p3wz3WCrE/Y4fxQOatAi93G0uw66ZXG21En/K2kOpB92uG
        s1E7QpM0zYzzaG2foQIUfO++bzOrMQvGzVA=
X-Google-Smtp-Source: AK7set+f3h54ori5ExMvoISFHQMOGugfYE8dwagwgNtbOtIg291LgijrAAxcHXfTdNek/PabR+GuEw==
X-Received: by 2002:a05:622a:198d:b0:3ba:1c07:e472 with SMTP id u13-20020a05622a198d00b003ba1c07e472mr9066044qtc.51.1677161298160;
        Thu, 23 Feb 2023 06:08:18 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:e099:82d3:1307:6825? ([2600:1700:e72:80a0:e099:82d3:1307:6825])
        by smtp.gmail.com with ESMTPSA id ew10-20020a05622a514a00b003b8484fdfccsm6222462qtb.42.2023.02.23.06.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 06:08:17 -0800 (PST)
Message-ID: <49082769-81b7-8a47-ace1-59c21b4396c9@github.com>
Date:   Thu, 23 Feb 2023 09:08:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 06/16] hash.h: move some oid-related declarations from
 cache.h
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Emily Shaffer <nasamuffin@google.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
 <9f78f0f215595d55ead4d82d20e1d0c9892171ec.1677139522.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <9f78f0f215595d55ead4d82d20e1d0c9892171ec.1677139522.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/23/2023 3:05 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> These defines and enum are all oid-related and as such seem to make
> more sense being included in hash.h.  Further, moving them there
> allows us to remove some includes of cache.h in other files.


> diff --git a/line-log.h b/line-log.h
> index 82ae8d98a40..adff361b1bc 100644
> --- a/line-log.h
> +++ b/line-log.h
> @@ -5,6 +5,7 @@
>  
>  struct rev_info;
>  struct commit;
> +struct string_list;
>  
>  /* A range [start,end].  Lines are numbered starting at 0, and the
>   * ranges include start but exclude end. */

This hunk seems unrelated to the current patch. Perhaps misplaced?

Thanks,
-Stolee

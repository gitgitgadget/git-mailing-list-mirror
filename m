Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F70C61DB3
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 19:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238021AbjALTsO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 14:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240098AbjALTr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 14:47:28 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80497FEF
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 11:44:02 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id h7so10367759pfq.4
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 11:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jjVY5/B7BCKYLD7bAEH7XK7mzoHf3x1bmEcYGPwSqs8=;
        b=KLLksXjBXIoh/Q72hf+4xt/nZrZZODupCH5ecXq45ZTUCoE2UcCecOPcFnwtwouRLD
         lEAwFn0Cybm0B+FWiKXmIlsR/m/x/DaDlpwf3T5tnNFFh+N5cGyW9bX8zt+u6m8pOqBH
         FlldrRN9C+R5vyQyHO3pWrrQPpB9+yOalbvHAnb+yrQt7YqQ6G4lMkhOkywEFxznieYV
         Fe+GxDgI45HM9jD/fPAcwooa9tUPqgLbvYUfEaYfWHgAvMaRbPcwzmx8zr4qqBz5j1EK
         xSACjfyiW+OezfJXhHrVw7DgTNKUNeQ6eq8sjmfYQJ31UC5KNCau3vYDo+I9wMTFYOd/
         AxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jjVY5/B7BCKYLD7bAEH7XK7mzoHf3x1bmEcYGPwSqs8=;
        b=5+cWeHX9IdY6nE/MkVQxspfK7KpbHLtVGxqN5Gt9Io248xta1tNkVjrk0/fS5i++EV
         tes+nHjdYvV7J0azq2rWfYEqbNgAdRMoXTcsd5PxR9OSAuzl/YwhJNuX3QzxEdIlunOs
         iPvxHZycbpQiPrx3BG3pY8Co9glhddLTIqtZpQHC+TKBgwKi84yZavcl3OJDnL/L1FwB
         XpSfrpKuM2Oi15QTNegCl84Ik+SijhTIhDzGG48ncHCALg0mLHZTp5CAbDg1rbLRq0Yw
         R8oYqFTsTVkXoj/Z8W/juUNa/XzX6/hhYilrhRv9PMyltq9o1P9gsrkjiSHh9Cy6/fH+
         ongA==
X-Gm-Message-State: AFqh2kp3Z0GjWK5eEQlNcmd+cmaXElXnkPO4FJ/0hhiXiPbkVHzYxUJq
        ++jUiC5xZT+hlH4IUIrS2aBe
X-Google-Smtp-Source: AMrXdXuZ6v95UEc2Zv1ot8HoMrEpJ9ZMEEDyNNgmXgoqJ246klfhQ+GXIb+r0+tD4RwfQEvenzmn1w==
X-Received: by 2002:a05:6a00:2997:b0:582:1f25:5b8 with SMTP id cj23-20020a056a00299700b005821f2505b8mr46789898pfb.19.1673552642019;
        Thu, 12 Jan 2023 11:44:02 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id t16-20020aa79470000000b00580f445d1easm884836pfq.216.2023.01.12.11.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 11:44:01 -0800 (PST)
Message-ID: <da31180a-5beb-4f0e-667b-ddceba941e9f@github.com>
Date:   Thu, 12 Jan 2023 11:44:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v5 03/10] daemon: rename some esoteric/laboured
 terminology
Content-Language: en-US
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Matthew John Cheetham <mjcheetham@github.com>
References: <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
 <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
 <8f176d5955dfc83616a39622972aaa71a71f5599.1673475190.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <8f176d5955dfc83616a39622972aaa71a71f5599.1673475190.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew John Cheetham via GitGitGadget wrote:
> From: Matthew John Cheetham <mjcheetham@outlook.com>
> 
> Rename some of the variables and function arguments used to manage child
> processes. The existing names are esoteric; stretching an analogy too
> far to the point of being confusing to understand.
> 
> Rename "firstborn" to simply "first", "newborn" to "new_cld", "blanket"
> to "current" and "cradle" to "ptr".

Thanks for this, I agree that the new names make the code much easier to
read.

> diff --git a/daemon.c b/daemon.c
> index ec3b407ecbc..d3e7d81de18 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -789,7 +789,7 @@ static int max_connections = 32;
>  
>  static unsigned int live_children;
>  
> -static struct child *firstborn;
> +static struct child *first_child;

minor nit: you changed "firstborn" to "first" in 'daemon-utils.c' (aligning
with the commit message), but it's "first_child" here. If you end up
re-rolling, it would be nice to make the names consistent across both files
(could be 'first', 'first_child', 'first_cld', or anything really).


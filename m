Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36EAC433FE
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 18:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbiJFSNH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 14:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiJFSNC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 14:13:02 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF72FF23A
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 11:13:01 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id g23so1496537qtu.2
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 11:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PbXz9Kb13okYZ+HTGXgO7GufpYDPU+F+kUljZUzrtz0=;
        b=P0JEOwRZUgNjfMqOmOpTxQG7jL/iAmMiKUfN434HU3ywnnS3a9sD1MqimEcNIcJdw/
         UEO3KzBjCcaMLd/vkLC9wvtnTnG1jbQz44Z+qORFuHxzf67B7sh9IMqhZiR1F67zJPVM
         5+bMRICdaDA1vQxDJALpM+kiPppMoQHkTe6HoxIXd53rDDaRrQgtu7xV1nnGceHMAz5W
         CwdjJno9vaF9V4gMt+tg+hQWqlijvrZ6gT+zjaEMTnuNNzZCqMpB4U0yzwE9Bom82CUw
         H7uDg9U2p75td3HvXiyy0UGAPCTJhgZp/6Kf9ZdZPyVUgxVMO6ePkyEmxzuTVp+7Jfen
         YnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PbXz9Kb13okYZ+HTGXgO7GufpYDPU+F+kUljZUzrtz0=;
        b=BoJAlI1gmMM/NMWXh+JRIHbIYWrARXnYoVjDMswm8RIRQUB9HxRl9kuKp7NrYBI6kD
         c5vgDOOAxurIV/VVokoBMD/3aX+ZZMoVQ7CAwRa93Jdg+KcjbX7zdz+BDR8CO+P5U4D/
         yQbHtdf765Pyx6gvEa/arRrQgJK5jvm9eBEx9/G+J7+A/oYxV149UEUDk03LNgkxd42c
         a9YgyTcIhalq5uZ69Bh+fUYnm6iFm/uqaF8DoY3yA5sTpXH4YgNeyC3A5BebkEQs77BW
         6ZeZe4nJ23BYGMlEonkREuaFKvvwXNfGIl49e/Bg4bSDcI+v5mJiy3eF7oISchRZnSpG
         0/Pg==
X-Gm-Message-State: ACrzQf2xOQQ6NNGXQsxWKkRHrUlnOAgakp4FGJdu1xiMXs1teHTJSyyk
        H5+QVX6MiLLX/AAwlZHTlSmDn2lK+b4l
X-Google-Smtp-Source: AMsMyM4z0UCVKOn8u2oxpJrdY4iV6aFDDAzDOK1z2P4LJ60GELoBL0YGkK5q+ZONogGMfLr/1Y1GHg==
X-Received: by 2002:a05:622a:4c8:b0:392:8097:eec0 with SMTP id q8-20020a05622a04c800b003928097eec0mr1294253qtx.186.1665079980663;
        Thu, 06 Oct 2022 11:13:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:2185:e582:857d:e0db? ([2600:1700:e72:80a0:2185:e582:857d:e0db])
        by smtp.gmail.com with ESMTPSA id u4-20020a37ab04000000b006e26c6db902sm5215394qke.53.2022.10.06.11.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 11:12:59 -0700 (PDT)
Message-ID: <c9534d61-a0ad-2e9a-1504-d5f69eee7e17@github.com>
Date:   Thu, 6 Oct 2022 14:12:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH 0/9] Trace2 timers and counters and some cleanup
Content-Language: en-US
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/4/22 12:19 PM, Jeff Hostetler via GitGitGadget wrote:
> This patch series add stopwatch timers and global counters to the trace2
> logging facility. It also does a little housecleaning.
> 
> This is basically a rewrite of the series that I submitted back in December
> 2021: [1] and [2]. Hopefully, it addresses all of the concerns raised back
> then and does it in a way that avoids the issues that stalled that effort.

Thanks for working on this again. As I mentioned earlier [3], this
would be really helpful when doing performance investigations. I
also plan to insert some timers and counters as a follow-up when
this series stabilizes.

[3] https://lore.kernel.org/git/pull.1365.git.1663938034607.gitgitgadget@gmail.com/

I was unable to find further improvements than the ones you
already acknowledged for your v2.

Thanks,
-Stolee

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A224FC54EE9
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 18:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbiIVSdx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 14:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiIVSd0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 14:33:26 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF5D9A6A0
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 11:31:18 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id 138so8441788iou.9
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 11:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=hREkSeyEbH8RlsgTSsVLltG4+F17PxLk1PEUrurtdNw=;
        b=LpRH9wa5wEYudJUcpOy1dJ6zkwRlb2EI/jzmtypnpgBPg9996QP/Qke9McffDm4uPi
         yBqeT4yzFuw8OSIRtnbjR/XN38OYW8b54vE+wE7q/ULfJeZTRfb1zQiineMIqXYMNSaY
         VdXxyaL1c2WxSCjanQtS1Mxln7xJL7tLYwovXdtzI5lwBpT67MmVFUjc1MdlzvbhydD9
         36mTI8r7wyuCc/iNTjir2xU8Jl8QVRD0bjMemHmFJS2xOLBpe5XHdi7wIklAT/bp0DnP
         UKls+j897jplNcZGyf5DP0zIDsL03xhYop0LJEMnic+UzYeJULgyt3boUsEcMxuo+JZu
         HsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=hREkSeyEbH8RlsgTSsVLltG4+F17PxLk1PEUrurtdNw=;
        b=1ydn6vBt+PRJZ9h92vrAIbccil7WQYyt/6LoP/mmTPz0rqEGYWAzYmpgSn6Fidiu8p
         lGQLuJXFJISOBQALlUOR5s8CoBEC+vydSSEbPyBKd7lW+CF64YENtRskF64dNs2etvWM
         fekV55r8QGlWFtF6PwsncdxSC+FAhenwlXUoP8y5vCxfJ1z24Fyq6yuTw2dFeynLFuXk
         ANB5P1alaz6VYQUzOCsicJ4RsJPoX4bwvh8MJnFh9bOpiIvP/jf2fElpjsls9c2meqg/
         WJzWDPBJv8WhnCnR7Uhu59heeyOaeoVksrtzq3WExa7G/qk5fdJlIvSUMIO5Lo7k1v3a
         FrJQ==
X-Gm-Message-State: ACrzQf2rfLdbS6S2x+UeFgQTvYHVyHauzxsnm5b8oQFpv0QUp7dsH9TJ
        9sajuImEf4uj0Vq+TWkVoh+6
X-Google-Smtp-Source: AMsMyM5oQC1KoJXCeIupYJyTRZH3ijV6Lv8qgQDtcd2PXdFb0gyrsHCGV2gSd/6RAjrG7JKU4v+rZw==
X-Received: by 2002:a05:6638:439a:b0:35b:1318:ac53 with SMTP id bo26-20020a056638439a00b0035b1318ac53mr2888860jab.74.1663871478324;
        Thu, 22 Sep 2022 11:31:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:e4c7:912a:7017:ed79? ([2600:1700:e72:80a0:e4c7:912a:7017:ed79])
        by smtp.gmail.com with ESMTPSA id h3-20020a92d843000000b002f4aa150479sm2280763ilq.9.2022.09.22.11.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 11:31:18 -0700 (PDT)
Message-ID: <0e3bafd2-b331-96af-b379-f00a27909da6@github.com>
Date:   Thu, 22 Sep 2022 14:31:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 0/3] Correct credential helper discrepancies handling
 input
Content-Language: en-US
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     mjcheetham@outlook.com,
        Matthew John Cheetham <mjcheetham@github.com>
References: <pull.1363.git.1663865974.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1363.git.1663865974.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/22/2022 12:59 PM, Matthew John Cheetham via GitGitGadget wrote:
> Whilst working in the credential helper and auth space I happened to notice
> that the behaviour of some of the credential helpers in contrib/credential/
> is not consistent.
> 
> Specifically both the git-credential-wincred and git-credential-netrc
> helpers die when they receive unknown credential property keys, which is
> contrary to the behaviour of all the other in-tree helpers including:
> git-credential-cache, -store, -libsecret, -gnome-keyring, -osxkeychain.
> 
> Also update the git-credential-osxkeychain helper to include a comment
> making it's behaviour explicit in ignoring unknown keys, as per other
> helpers.

Thanks for sending this patches separate from your earlier RFC. I
think these patches speak for themselves and are good to go.

Thanks,
-Stolee


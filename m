Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5675CC4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 20:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbiKGUCP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 15:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiKGUCM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 15:02:12 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8EA21E35
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 12:02:12 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id fz10so7550910qtb.3
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 12:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Og1mTA0MqjYIruuP2Z6bYklrzpdLy/N0r2n9ML9FovQ=;
        b=cuYxQPF0jc/eZkLAoTFaDr9FKCF4zzondEJ4ajyKOSOEvVkDu8wVWdgygU7sXptiN6
         lkLZKQrJTBfjv4zbE7+WAySEILgDW+FMV2vQD4uQvE3N1CGOldompzwMjPfSq5/kBG2D
         BrzD+SpvflMurYdTtc1VlPg6Rd5UtRpl4iN+bCZYyNEGQxLQa5dffwTWgp67/bPScili
         44D/SYdrp22gTpE+2/W6dW22yf8rUceph163nlCUAxptMVwmenFMCeGjEaFGBAbBiXCR
         gySVvrTjlsNWXM8o9MvjSKNvqQGDS9jcv4OQlwqFYUCqOWt5UNrnL+V1+enuNb2CxQaV
         FKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Og1mTA0MqjYIruuP2Z6bYklrzpdLy/N0r2n9ML9FovQ=;
        b=gCTsJYQeoAlpmCIMciplbFhHnNAPs6lklOb5DzoJnF6JCN9pwteeMKEBlyqebf4POU
         7/OYtrrmSQzPYS0qWDTOTbrL7nykJJJznUPypYC5xMq9R7Psu5aD2K+neAGvbQf2OZNI
         355k1GdKcag9qmBUyd0KO1Vq+3MdATCsPQTKS7mvhQ5nsd/TZS3uiXLSpz0G8S9LR1yr
         13HL4mt/uQJ1yw6ILZZy5Ux8A45wy/5s86k72N7guMWX1yLst3MkELOcj1dSQNArcn0T
         /58iBrX9+kQLGeSu44VCSmw7tNY9NAmkqZB6xEqjzJil1beQyhZiSR3mNObI5nkqOBi0
         2Viw==
X-Gm-Message-State: ACrzQf1on8an55+Pdtgf0SzXSgx+11IfM6sRfjKLJSU/MjaCHJbyG+cB
        qOpKqKQSjdDwcnXeg6ALpwqys3qbUFw3
X-Google-Smtp-Source: AMsMyM7NfR/V7yuSCoqPIpCY7qv+LuZkXxenl83WyBiXgw2dcz2pHxLo/u+2A6DBh76tD4aISrM33Q==
X-Received: by 2002:ac8:478f:0:b0:3a5:673f:c45a with SMTP id k15-20020ac8478f000000b003a5673fc45amr14217719qtq.94.1667851331156;
        Mon, 07 Nov 2022 12:02:11 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d948:f30c:63de:b667? ([2600:1700:e72:80a0:d948:f30c:63de:b667])
        by smtp.gmail.com with ESMTPSA id j3-20020a05620a288300b006faac3c33b8sm7332741qkp.27.2022.11.07.12.02.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 12:02:10 -0800 (PST)
Message-ID: <32e86ad3-2576-b90e-444b-636131bc168d@github.com>
Date:   Mon, 7 Nov 2022 15:02:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v3] status: long status advice adapted to recent
 capabilities
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>,
        Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Rudy Rigot <rudy.rigot@gmail.com>
References: <pull.1384.v2.git.1667002005494.gitgitgadget@gmail.com>
 <pull.1384.v3.git.1667424467505.gitgitgadget@gmail.com>
 <Y2WG6ursW7qT29lc@nand.local>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Y2WG6ursW7qT29lc@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/4/22 5:40 PM, Taylor Blau wrote:
> On Wed, Nov 02, 2022 at 09:27:47PM +0000, Rudy Rigot via GitGitGadget wrote:
>> From: Rudy Rigot <rudy.rigot@gmail.com>
>>
>> Improve the advice displayed when `git status` is slow because
>> of excessive numbers of untracked files.  Update the `git status`
>> man page to explain the various configuration options.
> 
> This one is looking good to me. Jeff: do you agree? If so, I'm ready to
> start merging this one down.

Sorry, I came in with some late review. I think one more round
would be helpful.

Thanks,
-Stolee

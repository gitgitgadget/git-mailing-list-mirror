Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CCCC28B2B
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 18:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350758AbiHSSc7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 14:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349790AbiHSSc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 14:32:58 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588E7C9261
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 11:32:57 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id p9so2698882ilq.13
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 11:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=uOl/EOacu7ukmYl4YLVkOPpd/oOWgUflUVdqLthOUME=;
        b=gIJ5Vm2SFpMtMslom6tP6D4jo4uOpxkzOQdck/8cbD6WG4Q1geBuLNe2W7rw8/muE7
         hshk4bUna7v71J9L5CXcub/jz4l5meoVa0QSwD9ApFNpMBgpaMcCr9cMTNJ0g9xr0Dnu
         GAICzaBc/3SkD+w1otKSqEbVLOtKtZwIUnWjJzITXOXdr82iW9XGuV9Kap+1LaDh5q2r
         pgy5YqBroLSOlkjh07UElgtPsJIbgoefN7vdRqUevjRJULuCELoDf2CsMIBEqeaPDx8B
         xvQCiim53gdj8vks68AfLytiBC76pula9wDI7U3mklpCfp60Bw2mlAn+xPXt56En34Zk
         Q/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=uOl/EOacu7ukmYl4YLVkOPpd/oOWgUflUVdqLthOUME=;
        b=NORR64PWcoUrboc5fQEyJpGT/Sy1ZiGX0Uh6guBdH5xvUsW0ShqUWuHfIdO8JSHtDn
         WGvBGzKNaaO6P/yQda7xtGCdbw6PrJom1thmymTZsOnfKvdq9KJG5gaxeUKJ35RJeQTT
         DeK6omOxuCtOoArOk3f0w90KKVlqlxYc5He0cgTlXFhqk0FQJSYeYeiIt/K3Ps9IEgPB
         GH3uVPs5gE1/Dguxb93YDHbY3Hjx/XW0vRJrkvfnBObSymscxKfAbxLUQGS0fUyXjjLw
         RJgayRGPPHpKGm9Ix1QkAexm6brjHAWkEwv+ipWU59pUpabEA5A6skXd/CWzNmZ3pPzp
         Oqww==
X-Gm-Message-State: ACgBeo2yA5EMRTKE9hEkvwfvDsHIfW2k4gOJRTwrypzmFz8PQLumg/0D
        ZGXqUZnxXI1wKsp6snaWZn0r
X-Google-Smtp-Source: AA6agR4uYugcJzYFexBSlSvWF7Od9+eCvA0dFWh5mTNN1vVu0LgIb5AJBMOjvE971g/phMr9nEcxeg==
X-Received: by 2002:a05:6e02:148c:b0:2de:c3b:91d with SMTP id n12-20020a056e02148c00b002de0c3b091dmr4397036ilk.95.1660933976776;
        Fri, 19 Aug 2022 11:32:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:55ca:650:1968:6180? ([2600:1700:e72:80a0:55ca:650:1968:6180])
        by smtp.gmail.com with ESMTPSA id f1-20020a022401000000b003434acdba3dsm2015234jaa.105.2022.08.19.11.32.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 11:32:55 -0700 (PDT)
Message-ID: <0f2df5ed-3380-8162-80c9-10d2eb644965@github.com>
Date:   Fri, 19 Aug 2022 14:32:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 1/8] scalar: constrain enlistment search
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, mjcheetham@outlook.com,
        gitster@pobox.com, Victoria Dye <vdye@github.com>
References: <pull.1324.v2.git.1660694290.gitgitgadget@gmail.com>
 <pull.1324.v3.git.1660858853.gitgitgadget@gmail.com>
 <2f6cad8361324cecdb0ee7b13a96477a8317c358.1660858853.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <2f6cad8361324cecdb0ee7b13a96477a8317c358.1660858853.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/18/2022 5:40 PM, Victoria Dye via GitGitGadget wrote:
> From: Victoria Dye <vdye@github.com>
> 
> Make the search for repository and enlistment root in
> 'setup_enlistment_directory()' more constrained to simplify behavior and
> adhere to 'GIT_CEILING_DIRECTORIES'.

Thanks for doing this rather substantial rework. The logic makes
sense to me and the tests really help to demonstrate the different
cases.

-Stolee

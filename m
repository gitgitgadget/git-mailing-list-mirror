Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C21C433F5
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 13:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350503AbiDZNFf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 09:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350481AbiDZNFc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 09:05:32 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECA736E2C
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 06:02:18 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id z26so1272516iot.8
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 06:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=m45dMeWPapN6aBTg7+rpsrW7STvf3QiukzdZy/8VuRo=;
        b=Waw/RCJGTlBnAWpYDRLPBrrhhQRYlqH6b1gf/bPtUNW2jnI+p/BNv+yTw4i5VM08tr
         LOQlnLiy8m66dn2fsroz8Ub6at5KofhlhJrFRlZ9/AtNYCEjYsbLH2f/tEWUmRRoQ7SZ
         kCO5aTFHAXXUnBokb5SPbad1KJltb/pqBYzfDEtOkn4Yp9JRRvit330cWMXu/jCcgVn3
         LeLXQunH8lPq1cFs5OszHiLC88+PYx/hQZ0gfQy4rfygmFVXPr90cOvoAI9DLNsXrpdF
         a36k3PDlSimE6aDGzR716KWN76U2R3keT8LhXgtpCdABh3yvq4NKdxQ4qGLxmy9B5gMu
         A6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m45dMeWPapN6aBTg7+rpsrW7STvf3QiukzdZy/8VuRo=;
        b=VufMcuQ11BVoqP8xtWGv5ul8IhJ97GxFdiZJ3MJRnqhohFUq2bMpAFECjdukA9kwHb
         /+wyPusKJsdukkdcT7QflHFS5fwCTG9EfoZV/uJwJg2U2RUeA6yKypinyl73Wy71rhxk
         rDH35gCHoHqVxKiMBlyapRVypWup5U6tMf3QXqQC6beoFvVGR9H/0iMJh5jtkrutWrp+
         3ZGzcUsVnFWTXUWWA5kKaQJ/MUyATZmjYb+pRLeOS6MKpXDIllPA0lYm9SWDGmidWLQ4
         XJf6lK6U7SSjL8U0SLD0ANM13UH/+QMK3xLNZ3UcjzWW4hlTpPi6bPgoGkSdHy1wIzIb
         ZRcw==
X-Gm-Message-State: AOAM531yFdtTtm2PEQ1u+OUelS0UDn7KUgpewA4vhp/R1Uhsd+0XrIQP
        Tv5A9T7jCyNoAX6C6d2w3Ikb
X-Google-Smtp-Source: ABdhPJzPkrMgTer5LXBSZlkyQkb93RHX1n32X4PKPtoLbD7jYoQxVumY8jkVOdwJF69ND43nHkCLmw==
X-Received: by 2002:a02:69c6:0:b0:32a:ef6e:68d7 with SMTP id e189-20020a0269c6000000b0032aef6e68d7mr4150076jac.259.1650978138063;
        Tue, 26 Apr 2022 06:02:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:a3:141e:f20d:6edf? ([2600:1700:e72:80a0:a3:141e:f20d:6edf])
        by smtp.gmail.com with ESMTPSA id i10-20020a056e021d0a00b002cd804f045dsm410723ila.1.2022.04.26.06.02.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 06:02:17 -0700 (PDT)
Message-ID: <f2b4b885-b473-bea7-29e5-9e4f6002fc27@github.com>
Date:   Tue, 26 Apr 2022 09:02:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 6/7] stash: merge applied stash with merge-ort
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, Victoria Dye <vdye@github.com>
References: <pull.1171.git.1650908957.gitgitgadget@gmail.com>
 <76f2a9e87223e1c1ebf2de6629c46bdf7ad326f1.1650908958.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <76f2a9e87223e1c1ebf2de6629c46bdf7ad326f1.1650908958.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/25/2022 1:49 PM, Victoria Dye via GitGitGadget wrote:
> From: Victoria Dye <vdye@github.com>
> 
> Change the merge function used in 'do_apply_stash()' from 'merge_recursive'
> to 'merge_ort_recursive'. In addition to aligning with the default merge
> strategy used by 'git merge' (6a5fb96672 (Change default merge backend from
> recursive to ort, 2021-08-04)), this allows 'git stash <apply|pop>' to
> operate without expanding the index by default. Update tests in 't1092'
> verifying index expansion for 'git stash' accordingly.

This is an interesting change, not just in the sparse index sense. Yes,
using ORT by default is a good idea to align with our default merge
strategy _and_ allowing us to avoid expanding the sparse index.

But: should we allow this algorithm to change via our pull.twoHead
config value? By default, it will be fast with the sparse index. Would
there be value in allowing a user to change back to the recursive
strategy if they want?

This also seems like we should have a measurable performance impact
for 'git stash <apply|pop>' when the stash contains a lot of renames.
It would be interesting to have that documented here. Elijah might
have some thoughts on how to measure this performance impact.

Thanks,
-Stolee

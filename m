Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F04EC10DCE
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 12:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A41205C9
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 12:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVmfwnBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbgCOM0x (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Mar 2020 08:26:53 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35504 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbgCOM0x (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Mar 2020 08:26:53 -0400
Received: by mail-qk1-f193.google.com with SMTP id d8so21232568qka.2
        for <git@vger.kernel.org>; Sun, 15 Mar 2020 05:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l7T8iur5UxnF6QKYxzweDKJYIy6PwN9Oo4fuzDjOdQE=;
        b=qVmfwnBYgUwcMQoYyBhL2IXgxfRelLHnpQMJdomH0FN2m/T45DjxLFlXt2WZn81GQp
         0Xh6tTc3x8QKwX9EWOJIgPqGczB/29nc6emjguBWmLbHvTTiPvjGi4JKQQ8si99umfI2
         jZ30SPVpdt5lFERlP1DjTh0SesiRdU0+j4LyaacZ8lJlKTAeXmL6earUuFvbuENh0tkX
         5zHwFR5PmMT54B5imgLcbmVfz9HljrYXb0PtcAN/TfCzPSRnGvBwFHKJxNqBhrCu1NDG
         K4/EVdacAxjo4ffdDjWiFNUT2/30I9TVQXufNL0xTWl1R/lOoiY/JpDb07qmpwgC3iJI
         mR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l7T8iur5UxnF6QKYxzweDKJYIy6PwN9Oo4fuzDjOdQE=;
        b=tQO36+NiZWTN/wumUvoUbt+zJWasiruL7e9fBWktLf62Or9LgrZwamWyEjF731XuC2
         9iCiafp/iffin6Pf98BmkuEywN+BcyYUcCW6uc76wOAOQFTiPaVvCcNw4vibEDN3265k
         1GX9f9PS6HZrqXmRL2Oo0DRVCAMsgam1PMhhUQlW52iItJEAcnI3TTHi5HztcdHL7Hzn
         zBus6n4e3CZinor8hNubGomBu04pOEAkcopglZNbnW3ecDM2buwKZ9w9Al5zR6nLNMqh
         tXTrgSu4QLZFhYDH3i5TO7W9Ws/pDpZFCa2A4If7qAYLJAY/VM8N74vhBhFea7T7gouZ
         UWqg==
X-Gm-Message-State: ANhLgQ2S2ep/S98zbvKrIoHzoFqiKdR2nOhiDaIAWPNmSXwGH5z0XVvF
        cCO/Z9OGyC1dJyrg6MxNGjc=
X-Google-Smtp-Source: ADFU+vs0mR7ogEmhW9ndhdES9uqQ3CUHpSsSgaj4XpAeLBpoPy/NyChST1mY3sUplvFDVO8NBIVQ/Q==
X-Received: by 2002:a37:9186:: with SMTP id t128mr20126089qkd.180.1584275211909;
        Sun, 15 Mar 2020 05:26:51 -0700 (PDT)
Received: from [192.168.1.76] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id t7sm9554893qtr.88.2020.03.15.05.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Mar 2020 05:26:51 -0700 (PDT)
Subject: Re: [PATCH 0/7] Sparse checkout improvements -- improved sparsity
 updating
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f99f5379-0e27-4cce-de80-8f780b9544d6@gmail.com>
Date:   Sun, 15 Mar 2020 08:26:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:74.0) Gecko/20100101
 Thunderbird/74.0
MIME-Version: 1.0
In-Reply-To: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/14/2020 3:11 AM, Elijah Newren via GitGitGadget wrote:
> This series provides a replacement for the git read-tree -mu HEAD-based
> sparsity updating used by sparse-checkout, fixing the myriad problems it
> causes. The most important bit is patch 5 and its lengthy commit message
> explaining the current state and rationale.

I'm excited to dig into this change! I'm pleasantly surprised you have
something ready so soon after we talked about it at the summit.

> Consider the series RFC for now; I probably need to add some tests, get some
> people at work who are willing to test it in real cases, and get some
> community feedback particularly on the choices/comments highlighted in the
> commit message to patch 5. But it's at least basically functional so I
> wanted to send it out to the community for feedback.

Count me in for testing and reviewing. Just expect me to be a little
slow this week as I'll likely be juggling work time with kid time as
things shut down. I'm very excited for this feature, and I'll try to
help as much as I can.

Thanks,
-Stolee

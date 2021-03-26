Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A33FC433E2
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 20:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C87B61A28
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 20:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhCZUQc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 16:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhCZUQH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 16:16:07 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8336DC0613AA
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 13:16:07 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id y5so6523451qkl.9
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 13:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JPpW3PAK8HPW7DgQ4+GxZL+QMykTaKHV6xca7moCQlc=;
        b=Eo1iyJBuH83oYRz+8VY1yp/9zskrVoqV0EvuNzlYCgmGwdZ7RHuMdFMdpC42dF3800
         kqPN3cFyrJFibZwMitSKCl6e592UGa2XJE4+F30u7IQYxsJPvCr2kwfN/8eR6jB25olM
         pN6CuZ97tvv1lytlqUDqxtavaLWLQTBudbD2HcSQrpLR/KnyHe/K7XO6y1MrhkIptjZG
         AwmRUS8qWuO83Sk0UrijQViSJk7KDW6LOMUrnMgc5Y6ng9DFRSCriIMeWWWKl1lszcXu
         QtTIi5stXZHgIklxI938Xr+lsCKk7IKXhRVk+hPXqcF2QRczQXO+KbcAhUN7WGkUzvJG
         0ONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JPpW3PAK8HPW7DgQ4+GxZL+QMykTaKHV6xca7moCQlc=;
        b=KprkSzlH1mIy2W5ZZ706fdMgk9/BNYDnpAV1gMFfwn9Fj6Sl/avS9V5tV3DSdfk2tr
         ZB70z7L7UB6+Prtc6FJDH7jf8SW+xOHrf7oCcmENhf/hqz5GyrKVONISfu0SgP/zPNel
         XhMFWyCz/sfQ5dNjcubW7fLMcgmq6aMmL51lhwlGvrtqdhrR272Gb0y5G0sGlVk02K/O
         k5vnsMD0B7vTZs22uuHRDDBw9HrLffD/HbOuCbVSI+CSHgwCjhJHhAsgJ3iBj8K8lc91
         JTke6PAUN6Rxke0Rma/7Kk/qd62eIyCfHqKZfx+UJsYLhUWUEjfzLLpUkHQOQQv46MUW
         byhQ==
X-Gm-Message-State: AOAM531sP9Q/pNtA3V2wpIatqBwNW8aSq1apE6wxRCZtMC7Th69KXWCr
        kL03VpEiP9sSIcvNhe/ERxcdW8us0v3JoQ==
X-Google-Smtp-Source: ABdhPJxVruocn9TfVN20txnV5achALTBVkC6edadnQ+jMBsa1F25bvfRpfg9AV0dhaM1TcUbNjyimQ==
X-Received: by 2002:a37:8443:: with SMTP id g64mr15013648qkd.185.1616789766664;
        Fri, 26 Mar 2021 13:16:06 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:21ff:ce2b:b4cd:16f6? ([2600:1700:e72:80a0:21ff:ce2b:b4cd:16f6])
        by smtp.gmail.com with ESMTPSA id t24sm6445675qto.23.2021.03.26.13.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 13:16:05 -0700 (PDT)
Subject: Re: [PATCH 0/3] Convert index writes to use hashfile API
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.916.git.1616785928.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <01c1c74d-cc8a-0541-5193-723c41dd877c@gmail.com>
Date:   Fri, 26 Mar 2021 16:16:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <pull.916.git.1616785928.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/26/2021 3:12 PM, Derrick Stolee via GitGitGadget wrote:
> As I prepare some ideas on index v5, one thing that strikes me as an
> interesting direction to try is to use the chunk-format API. This would make
> our extension model extremely simple (they become optional chunks, easily
> identified by the table of contents).
> 
> But there is a huge hurdle to even starting that investigation: the index
> uses its own hashing methods, separate from the hashfile API in csum-file.c!
> 
> The internals of the algorithms are mostly identical. The only possible
> change is that the buffer sizes are different: 8KB for hashfile and 128KB in
> read-cache.c. I was unable to find a performance difference in these two
> implementations, despite testing on several repo sizes.

Of course, shortly after I send this series (thinking I've checked all the
details carefully) I notice that I was using "git update-index --really-refresh"
for testing, but what I really wanted was "git update-index --force-write".

In this case, I _do_ see a performance degradation using the hashfile API.
I will investigate whether this is just a poor implementation of the nesting
hashfile, or something else more tricky. Changing the buffer size doesn't do
the trick.

Please ignore this series for now. Sorry for the noise.

-Stolee

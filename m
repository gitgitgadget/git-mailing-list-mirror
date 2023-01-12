Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334E3C54EBE
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 20:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240256AbjALUv7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 15:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbjALUvU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 15:51:20 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE75C69B21
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 12:23:03 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id x7so7348955qtv.13
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 12:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P0jjXKrQsOpZR+NszULIhtKzqzWafh6zkpGbHjnfQBY=;
        b=SVTkmCo/ZdxdJ+CNwaEGmfKGwFKNYWZ8amhK4loxnpHn2P6qstOQxPnUttO7OuzpV9
         JtveBd61WoGKH+5VPyD6sIrWGJ0eBxGTTJFLhOPpkrqulfOjm6gwoQV7I1zLgBB4tMtv
         VR2ofBTYS1gnr9mU2XB8QFk8VTB41276b2uhffJP0ekCV25zUm+tVUHq3NiGD4Ma/r2t
         6ZOpQOoU6d7lhGxpBgoNLpKppIMEPck8zidw7htfTzpQgU/7Q03i8KLRTBcrRktxAGvr
         4SyPMAUPaUAitbrWPg41kCLVN510YxRl0tsOq1CaphV1GX8uxBt5mo7nnJyH29c1QTbE
         p8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P0jjXKrQsOpZR+NszULIhtKzqzWafh6zkpGbHjnfQBY=;
        b=jwNFmjzhE9EllRc0DI5gFhQCw+xP9TqcMxbuW0FeZpB3kdB962vTDE5T/OLHgA2YrG
         q+V1b12l1H8PoiXMlVLWP4dSTOuw8tOEvxaUYDT4q7ywuFzjuPWDNNmlxWy5SJ5yege6
         oDu05p1h9vdlXUKgIieUgNOH/OcCnfntyrd6u0jtTboPSml6PKukftrK11J/5+wtQGVK
         WHoKWfPp0DgUaUFxIZ4maF3ILhw3uCLeHYLkHmmNbWp7aZ3tRcr9LrlHZMKx1LLHBE9A
         sgnCTzadB9oHaWfjvKaZpP4xfDoO834bOKJq3mJbZKAPblDJRfe2DorleYt71BEnoHgv
         gmLQ==
X-Gm-Message-State: AFqh2kqQfnkXAf16tLFveNoUMLBpfFakPl7ecNqEYXQccHcyGyMn9GwE
        CXpYMqnmuc1lz4LfNuLnCnA+
X-Google-Smtp-Source: AMrXdXuP267ZL54/gCNYCF+iOz1AGLm50CYe59fhvgvhNNl3ibNfwJJKcJcXiS4aU5LTX6lquLJekg==
X-Received: by 2002:a05:622a:50a5:b0:3a7:e467:b39e with SMTP id fp37-20020a05622a50a500b003a7e467b39emr14312388qtb.65.1673554982821;
        Thu, 12 Jan 2023 12:23:02 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:58df:ae78:2cd7:f615? ([2600:1700:e72:80a0:58df:ae78:2cd7:f615])
        by smtp.gmail.com with ESMTPSA id u15-20020a05620a454f00b006ce76811a07sm11608939qkp.75.2023.01.12.12.23.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 12:23:02 -0800 (PST)
Message-ID: <2f40f8f7-7323-94ac-b423-9d35583f0dc3@github.com>
Date:   Thu, 12 Jan 2023 15:22:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 01/10] daemon: libify socket setup and option functions
To:     Victoria Dye <vdye@github.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Matthew John Cheetham <mjcheetham@github.com>
References: <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
 <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
 <74b0de14185120c9d53d7470e59f57fa20a1927f.1673475190.git.gitgitgadget@gmail.com>
 <e1b1a53b-69d7-6fd6-513d-0f6cb3751b51@github.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <e1b1a53b-69d7-6fd6-513d-0f6cb3751b51@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/12/2023 2:35 PM, Victoria Dye wrote:
> Matthew John Cheetham via GitGitGadget wrote:
>> From: Matthew John Cheetham <mjcheetham@outlook.com>
>>
>> Extract functions for setting up listening sockets and keep-alive options
>> from `daemon.c` to new `daemon-utils.{c,h}` files. Remove direct
>> dependencies on global state by inlining the behaviour at the callsites
>> for all libified functions.
> 
> Thanks for making this change, the reduced code duplication should make the
> common daemon-related code more maintainable.
> 
> For reference, I used 
> 
> 'git blame -s -b -C -C -C master..<this patch> -- daemon-utils.c' 
> 
> to help identify which lines in 'daemon-utils.c' were changed from their
> original implementation in 'daemon.c'.

Neat trick! Thanks for sharing. Using --color-moved was giving similar
results, but with a lot more tracking back-and-forth to see what the
differences were.

I agree with your assessment on this patch that the differences are
valid, safe, and desired.

Thanks,
-Stolee

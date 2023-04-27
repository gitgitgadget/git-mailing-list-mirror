Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A12DC77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 13:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243654AbjD0NCv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 09:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243467AbjD0NCu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 09:02:50 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EAD30C8
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 06:02:48 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-54fb9384c2dso99647187b3.2
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 06:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1682600567; x=1685192567;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ar5WQhXEtMKIU1rr5HL/RfLmagQcxX9Tg7v9sqMhmLA=;
        b=d0cNvtntZ/Uo9hZhAulHt3vlW3oF7cQwuA55I/rpe3jxRvufkpgIUPBuQ6INkyGtvu
         LkBJTCRkM2UvWCpRZh14imndoPdnhOn5HtGc15AyiadVLqYJHCcTuXO94HZJ+xGB/LB2
         JCk8TSu6hPfX5d3BvE9g2sHGpSM80m7n25+ibCu/rIfsgigF70PtASQy//3m7NMullMf
         FyIqOiND0agofIik5RGTfjokatqfZbgWY8C3Yk/bLC4exzn99LN6VepJb/kKS+tfS6kF
         s6qGkTacGbJYKmDBE5N+UBRmlcw7HysCmz0G0rJQT/DClvIvck+gh2E+SDq9V9Pu2E4t
         rhog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682600567; x=1685192567;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ar5WQhXEtMKIU1rr5HL/RfLmagQcxX9Tg7v9sqMhmLA=;
        b=IN/ve/sfJfH3rEZCgrIai5rynJGiim/KmQ2FC4vLqZqIbHYk8YinwsbcbeRvUFDltQ
         W3bhi759NeNA+u7tJzVxqlg91uZeV6v7TUywSgQDS7Gg8QeKiwT3tNRtQztt+XYSKzof
         T86YIQVOx5aGb9/35xnjo413Dk3TcycgHmUSa1fm+99txxeSs3VBeIseanG7ASyhQFCq
         SCNANh+4TtAq7+xkG1+IfUYr+26XMWgnt7Oy5n4O3TC3cRCrGPfvpFJF4rPwg/Z5kTWu
         6RAWU2eQLuWbE2Q3mlzDEPyLYEzKjdC08mSM2G1V2Pcdny2Bbmui07LVif3nrWoC9K8N
         zfGQ==
X-Gm-Message-State: AC+VfDynTm0l7MkFUkINLVF52PT6+f1C+R/hDZOEziRzQk4+45PMlY8W
        UcfnERV0RrYpv4Tq2KOnuWDg
X-Google-Smtp-Source: ACHHUZ5Bs+ji6xzN+1LkB0z28u9C5l3FNETuQnbM/Nl8UvX7OTBJkn/Fsx9xmzGeJ6/Uy6Hmo1ILaw==
X-Received: by 2002:a81:4885:0:b0:552:a840:9da0 with SMTP id v127-20020a814885000000b00552a8409da0mr1086446ywa.10.1682600567418;
        Thu, 27 Apr 2023 06:02:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:d9b2:b2fc:28d:50f3? ([2600:1700:e72:80a0:d9b2:b2fc:28d:50f3])
        by smtp.gmail.com with ESMTPSA id c125-20020a0dc183000000b00555d2944284sm4744510ywd.67.2023.04.27.06.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 06:02:46 -0700 (PDT)
Message-ID: <7ec7f7b2-3e7a-afb9-7042-a4375970e8d8@github.com>
Date:   Thu, 27 Apr 2023 09:02:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Commit graph not using minimal number of columns
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Javier Mora <cousteaulecommandant@gmail.com>, git@vger.kernel.org
References: <CAH1-q0hReZoDWmXo7St10Dk6uc+6ZUQSxqvu1cJ7w3r7ftR9PQ@mail.gmail.com>
 <xmqq8refy114.fsf@gitster.g>
 <86188f31-f492-d195-d4d5-b0582906621a@github.com>
 <xmqq1qk6vd3v.fsf@gitster.g>
 <eb1c6c62-1081-a9d2-8504-db8bffc6c870@github.com>
 <xmqqwn1ysfo4.fsf@gitster.g>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqwn1ysfo4.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/26/2023 1:43 PM, Junio C Hamano wrote:
> Derrick Stolee <derrickstolee@github.com> writes:
> 
>> To adapt this algorithm to a newer, dynamic ordering that cares about
>> minimizing the rendered graph, I don't think changing the priority
>> queue comparison would be sufficient. Something deeper would be
>> required and would be quite messy.
> 
> Oh, I wasn't thinking about "graph-friendly" at all.  
> 
> I was wondering if we replaced --date-order implementation with
> corrected commit date from the generation number work would give us
> a better output order that users would expect in general (with or
> without --graph).

Ah. My mistake.

Corrected commit date should be equal to commit date unless there
is clock skew causing a commit to be older than its parent, (or
we have a path of commits with equal commit date) so I don't
anticipate that being helpful in general.

Thanks,
-Stolee

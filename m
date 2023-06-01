Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E14C77B7A
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 16:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjFAQfd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 12:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjFAQf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 12:35:29 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F59D128
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 09:35:28 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64d30ab1f89so753620b3a.3
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 09:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1685637328; x=1688229328;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L38+yyygcgSdBuKZgPZbQLMc0jNkZG/tr37OxEoKdFs=;
        b=dyF/VqNjLIXrZqCVZkAtoD8/MPrWpJtD/T/n33dQfCJ04qwmS9zj0TXOiNifIAq927
         evd3Dmh529vavGxXhIfRz6gt0o+rJetOH/w4O5AvwKLJyxZLJy0/GUA5sun/Kz4TJ8b0
         MqjsVeAY23OXaNvFtuQF8ZSGsH9/wBD0h17EVkVqFIXq6tZn0Bj/bcRmFInZbvHJua2A
         aeCdnysyLmo3giISnTgRnN10boNjUObEfvECmlgvpIuIJDbJ36FCehGyzFPf32BMEpqX
         f5IKQK80rOWGqenBtSYWKujYY4TwxP/csJB7DISScqkGXPYMVUb2UftmzMQ8dUTzvKJb
         gDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685637328; x=1688229328;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L38+yyygcgSdBuKZgPZbQLMc0jNkZG/tr37OxEoKdFs=;
        b=Qa/Y4zawbGeIjiHODiq7f9Bf2/Po5IPZ1CKmz8c+g24RQOPo9uZ2hMcjjZDEv9fpfW
         q7HDi2kSxdPHg1aHwnyV0j93/um2FmnDBe2zETOPmYkWv7sD+5JDaj0OfapIkBci/Ma2
         bhJpEiS8jzFvzJNaHYfLsTcJqG1+dltM3fiVhmDLoWam1vMGuArNL+xJowpxnDn6ref8
         VrXuk72IRREL/VcADj0KVvJEYFxBrcaKGgGtq/5xUq5K9uYntTqe4Mc8MOfpZuU2uDiO
         broGUDm4gle2UueTGTtDBUia1Y4NXgcTRMo3dcsmy4MK6emo97Qm3xIhbyepiTINnLrL
         24+w==
X-Gm-Message-State: AC+VfDyZdu8gBKZvZepzO9UzDMaAX81nb22kXjSW1vYC28risBa/G+JE
        AJFt5+gwMrRIttwL7cXlztva
X-Google-Smtp-Source: ACHHUZ6psucJLPcTqgX51Gk0GpYbHG6y/0CqoTvY+B+OliO4Iyp8Y9KtiBB90sXSVfXBcdrzCML08w==
X-Received: by 2002:a05:6a20:c896:b0:10b:d3e0:78a7 with SMTP id hb22-20020a056a20c89600b0010bd3e078a7mr6784925pzb.61.1685637328013;
        Thu, 01 Jun 2023 09:35:28 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id m5-20020a655645000000b004ff6b744248sm3136029pgs.48.2023.06.01.09.35.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 09:35:27 -0700 (PDT)
Message-ID: <caa3540c-0e7c-f428-e635-0cf54fc04eff@github.com>
Date:   Thu, 1 Jun 2023 09:35:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] repository: create disable_replace_refs()
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     me@ttaylorr.com, newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1537.git.1685126617.gitgitgadget@gmail.com>
 <56544abc15d1fce6fb4a0946e709470af9225395.1685126618.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <56544abc15d1fce6fb4a0946e709470af9225395.1685126618.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> Several builtins depend on being able to disable the replace references
> so we actually operate on each object individually. These currently do
> so by directly mutating the 'read_replace_refs' global.
> 
> A future change will move this global into a different place, so it will
> be necessary to change all of these lines. However, we can simplify that
> transition by abstracting the purpose of these global assignments with a
> method call.
> 
> We will never scope this to an in-memory repository as we want to make
> sure that we never use replace refs throughout the life of the process
> if this method is called.
> 

Although unfortunate (it would be nice to remove the global), this makes
sense. Disabling replace refs needs to be process-wide, and manually
propagating a repository setting to other repositories would be awkward
and prone to error.

All of my questions on this patch ("why were the 'disable_replace_refs()'
calls added later in the function than the original 'read_replace_refs =
0'?" and "why was '#include "environment.h"' added in 'repo-settings.c'?")
were asked [1] and answered [2] already. Beyond those two points, this patch
looks good!

[1] https://lore.kernel.org/git/CABPp-BFzA0yVecHK1DEGMpAhewm7oyqEim7BCw7-DTKpUzWnpw@mail.gmail.com/
[2] https://lore.kernel.org/git/ae89feda-0a76-29d7-14ce-662214414638@github.com/

> +/*
> + * Some commands override config and environment settings for using
> + * replace references. Use this method to disable the setting and ensure
> + * those other settings will not override this choice. This applies
> + * globally to all in-process repositories.
> + */
> +void disable_replace_refs(void);
> +

Thanks for including the function documentation. It concisely explains the
purpose of 'disable_replace_refs()' and helps clarify how replace refs are
treated in Git. 

>  #endif /* REPLACE_OBJECT_H */


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF51AC433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 14:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbhLHOjL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 09:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbhLHOjK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 09:39:10 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA41C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 06:35:38 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id m186so2115392qkb.4
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 06:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=O/1ywfirFDaNYSw3j7+JRizEdLKjueQWUe7u/kkueV8=;
        b=PAyklHKJWasiBK/ciB2yslCkAI9oq7QE6YH6WUrKKYMC4620Vfz17nluAHzfI3pjPh
         ILx8L/Y8jM2SpQdbi4tXgJIR0/34VKLrFWSWde0IkXqxMe1gjHvd+cVpGV0nUJcrtva0
         ZisC8YrA/Vm+pNnPkD9Gg77gqHqp8CgbqIfxrvmOF90uNbdHi+NHoZMsDBr5QkfWvAeL
         LD5IdfaShPcPuvNJH+FLVwUrfQyCnLJen1JCjeanF1lgUs53Kpr5acFLiggblPqE0jMx
         SjyCLHGKdI1CdaIA9yWky4lYG5nmKD1LoIU5p5aHLw/5VBvhO9aLWjPXeaXQulwey314
         fM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=O/1ywfirFDaNYSw3j7+JRizEdLKjueQWUe7u/kkueV8=;
        b=hbPAAeG4V8vDprlU25ApwZW4S0xx1WBXKIImPykeLi387B86haGFIjbVkwJdwjSgYH
         5SdAaaWR2o2s4b8ZQiGYM6HvimSAnfZJb6WAVZMJgwjvzrgsxMtxv8cllds3YUJBudGc
         AQl1gOLIW0ssowNnfRKzv1cl0t2uVHRHmf3AhrRlaxttM/KhSLPPYcivCLwqsRs6fSQZ
         CS6AbwI7TERF4XVeS0uiOTpKcuyqJvFrTnQXXRV1Gv0DWh0fiMoBR9lDeA45WHoZUIRF
         hJlR9I6qeP0ZPoBB0PgYghfIZCXabceGIwDoYW7GCiyuqtq2CU2HD6sLwLulBc073gu3
         a3hA==
X-Gm-Message-State: AOAM533BShBYFg2JrFE02yfUfvBO0nn74FJe4Dn3HPXe/k4UJlsXWT3Z
        u15ym/m1ME7tSOoR8V41c3g/oWZEI1M=
X-Google-Smtp-Source: ABdhPJzh079G+UIxf1HJcXpUI3vJcs8jda0OHFquu9dJOQWTZyHau1VEORZb3Fw9Fg9qnrnB0QNSuQ==
X-Received: by 2002:ae9:e317:: with SMTP id v23mr7197847qkf.446.1638974137553;
        Wed, 08 Dec 2021 06:35:37 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:5056:be20:f10c:bfd5? ([2600:1700:e72:80a0:5056:be20:f10c:bfd5])
        by smtp.gmail.com with ESMTPSA id z8sm1808039qta.50.2021.12.08.06.35.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 06:35:36 -0800 (PST)
Message-ID: <072ff09c-9174-e769-7ebb-4bb248199337@gmail.com>
Date:   Wed, 8 Dec 2021 09:35:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 10/10] reftable: make reftable_record a tagged union
Content-Language: en-US
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
 <8deccc3a1dff7e4f7d613fa63d2781fd1f11f841.1638899124.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <8deccc3a1dff7e4f7d613fa63d2781fd1f11f841.1638899124.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/7/2021 12:45 PM, Han-Wen Nienhuys via GitGitGadget wrote:
> From: Han-Wen Nienhuys <hanwen@google.com>
> 
> This reduces the amount of glue code, because we don't need a void pointer or
> vtable within the structure.
> 
> The only snag is that reftable_index_record contain a strbuf, so it cannot be
> zero-initialized. To address this, introduce reftable_record_for() to create a
> fresh instance, given a record type.
> 
> Thanks to Peff for the suggestion.
> 
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  reftable/block.c       |   4 +-
>  reftable/block_test.c  |  22 +++---
>  reftable/generic.c     |  35 ++++----
>  reftable/iter.c        |   4 +-
>  reftable/merged.c      |  37 ++++-----
>  reftable/pq.c          |   3 +-
>  reftable/pq_test.c     |  31 ++++----
>  reftable/reader.c      | 105 ++++++++++++------------
>  reftable/record.c      | 176 ++++++++++++++++-------------------------
>  reftable/record.h      |  45 +++++------
>  reftable/record_test.c | 162 +++++++++++++++++++------------------
>  reftable/writer.c      |  46 ++++++-----

This is a HUGE diff, especially compared to the previous changes
in this series. I recommend splitting this out into its own series
and finding a way to break it down into smaller changes.

Thanks,
-Stolee

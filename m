Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F142C76196
	for <git@archiver.kernel.org>; Fri, 31 Mar 2023 16:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbjCaQdm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 12:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbjCaQd0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 12:33:26 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE5829502
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 09:29:51 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m8so2334577wmq.5
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 09:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680280190;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aqCw6eohDKURjThm0ycOyMkQhsJLPsW78TlEmzZHNDs=;
        b=pKkNrroNJf/kin9HActPI0//z9pVzSlkv88rP7owGaCCRbaRA3BXu27bahe+OLI/3x
         vjcAT0e13X7kXYCvSuJLVBvUBPgCzgNNS6LSYxu+pwzLiHY3NzhjrVI1ELa+93EiBR0G
         VwjxediRNDZk7MviYw1T6EtG+kzNsAKN8UcyqZ7T9i44fZjZq7AIugRiCXcTFhILgMqe
         sLqjyQi/e+EeS77aeZHvsMwfe95j6pmKwrak5Kl+UU3wWnHZ9N3RALvnGD9I8fZLihBE
         O98I+102oVyoKIxcMh1tPgiuVcEguCZ+YIVDkSCjJuAUBcR2ybK7IDDw3cIVx18eIuWX
         dubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680280190;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aqCw6eohDKURjThm0ycOyMkQhsJLPsW78TlEmzZHNDs=;
        b=W29ToYlO0Gytf1vUD5f4xL6pSQbZKPT19OhG5fiRgU54fY2YsQ4X5YJ3kT9SxJ+Hnq
         K4HIzg0Gz+vpB41H8pZD9E0uUKIPBBJz7+JhzNtJCPvSHmmDBEJu3gBcgavGIrJsbdmI
         D7guQAG5HiX6p/YT/XkJb/5D2TVJS7C81OhwZMeoxWgmIM/7F8VUFD7Flc43mE8tTPgf
         j1ZFuN6gWeBLA06gSAh7k+i1Dl3V35m7kojFT/DRGDTTDfA2YQqLXv/4LLzIldZal/io
         7/d+eJR2PQj1FNnCpZaNq2GT1BjhO22KuG9hZHZzK+0LUCZU9INkIYjXYBOKkoz1hiUs
         pbwA==
X-Gm-Message-State: AO0yUKV0IlG5uj/RaJ3HDGi5LfWX4/YznoNIWBnERYILQt25geCQG+rm
        frP1DUExpprPROTln+zKnFY=
X-Google-Smtp-Source: AK7set85wcQJMbPNx1p0dNk2gJa7tUQ00uIkEeOODdOI/uwLdc2ycRPXNfNQRtX4b8BxkIzjn4DSoQ==
X-Received: by 2002:a05:600c:280e:b0:3ea:bc08:b63e with SMTP id m14-20020a05600c280e00b003eabc08b63emr21544281wmb.2.1680280189998;
        Fri, 31 Mar 2023 09:29:49 -0700 (PDT)
Received: from [192.168.1.212] ([90.253.53.152])
        by smtp.gmail.com with ESMTPSA id h7-20020a05600c314700b003ef66c89af0sm17676933wmo.0.2023.03.31.09.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 09:29:49 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <6c2c663d-9d91-3395-5dd5-844d6daef57a@dunelm.org.uk>
Date:   Fri, 31 Mar 2023 17:29:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] doc: add that '-' is the same as '@{-1}'
To:     ryicoh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     ryicoh <ryicoh@gmail.com>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
References: <pull.1484.git.git.1680257503697.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.1484.git.git.1680257503697.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi ryicoh

On 31/03/2023 11:11, ryicoh via GitGitGadget wrote:
> From: ryicoh <ryicoh@gmail.com>
> 
> Signed-off-by: ryicoh <ryicoh@gmail.com>
> ---
>      doc: add that '-' is the same as '@{-1}'

A few commands (checkout, merge, rebase and switch spring to mind) 
accept '-' as a shorthand for '@{-1}' but I don't think it is 
universally accepted.

Best Wishes

Phillip

>      
>      Now, the document of '-' is written only git-switch.txt.
>      
>      https://github.com/git/git/blob/6369acd968d02899973a9a853c48029b92cea401/Documentation/git-switch.txt#L51
>      
>      I want same one in revisions.txt.
>      
>      Thank you.
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1484%2Fryicoh%2Fdoc-hyphen-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1484/ryicoh/doc-hyphen-v1
> Pull-Request: https://github.com/git/git/pull/1484
> 
>   Documentation/revisions.txt | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> index 9aa58052bc7..9e7ea2cf71e 100644
> --- a/Documentation/revisions.txt
> +++ b/Documentation/revisions.txt
> @@ -94,7 +94,8 @@ some output processing may assume ref names in UTF-8.
>   
>   '@{-<n>}', e.g. '@{-1}'::
>     The construct '@{-<n>}' means the <n>th branch/commit checked out
> -  before the current one.
> +  before the current one. You may also specify - which is synonymous
> +  to @{-1}.
>   
>   '[<branchname>]@\{upstream\}', e.g. 'master@\{upstream\}', '@\{u\}'::
>     A branch B may be set up to build on top of a branch X (configured with
> 
> base-commit: 6369acd968d02899973a9a853c48029b92cea401

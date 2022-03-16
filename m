Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152F8C433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 13:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241230AbiCPNfk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 09:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiCPNfj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 09:35:39 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998B647048
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 06:34:25 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id 10so1702179qtz.11
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 06:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YbKvGK1OsbkA9BE51Oc0VLVGWofpmfRsI79I5nx1Uc0=;
        b=QcnbKfNKu0C6RyGPaDWXo+WRIpdUxvyNogNQlfGL0a5sB38L+AsQiOOQmBNOX+0w4Y
         62VKnQACcyr2CZcdHwJIWFXSZMdoGpAdgXm08BSemBh1D1Scw3uUugB7R6m2/8Rm6lRq
         JA819L1Hp9ypTpXNIr2sV+OW1yYrQUDIHq/6AASYIRHtg2LudGEskf+fSy21C4sCM0Es
         l6WodNWZPw8pLgVivr2V0sRrpF81khklkrS4hwodH247tLd4SXf5gDagzj0N7F5Ug8Li
         eFJxjdumkoz6bH9QAB1hdtF2CR86rSqFOJyTeJBYAY61LECQeg9hoq3gnCnTW9humUML
         Io2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YbKvGK1OsbkA9BE51Oc0VLVGWofpmfRsI79I5nx1Uc0=;
        b=4Lib75Qpf+t+OdiZbrhIx6q5TiCatfo7CaV4TvE3FGveG8y6eGxe09sz+X7M9R6E59
         85GvoeleqY/8cE8XFSNGPavmwT50WVOmUc+07RtOlF0EtEGteAPu2bm4UBnl78222WNk
         K4UPY64vjNnNW2O/dG6R87vTiDusU1F7m7rkX9aTu/7B8DYRn1uzPT0/ZrUewpNbAVZ2
         EI6k1/qMa3DW2qDm2P7Ii49CyQj7aSP4CgckrLZK8ZKPTHCG55RoiRMUdeA2bTBTjCg9
         RJ7ewSREMBSTZfkyOVL4JrE5BdSV/RisUKIbK15t+MM5tBH9cYvpBkYpWSkCHJtyMRMB
         ttNw==
X-Gm-Message-State: AOAM5328pvJDrYwcZVfUt89W0KDtdHA+knNSI9iQollDZx7ydoHld2n7
        /GHegrUQEFvnadtruLVrXh7IuhfStAhw
X-Google-Smtp-Source: ABdhPJwp4dbe+SCV4Uvbms2jNM/KR1LAd2Yq7L4MKxcr6LaeZO5M1C12Au3HJdqWSUmpHUIoZWkqcw==
X-Received: by 2002:ac8:7d0d:0:b0:2e1:cd83:33d3 with SMTP id g13-20020ac87d0d000000b002e1cd8333d3mr14068387qtb.315.1647437664557;
        Wed, 16 Mar 2022 06:34:24 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id t128-20020a37aa86000000b0060ddf2dc3ecsm888788qke.104.2022.03.16.06.34.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 06:34:24 -0700 (PDT)
Message-ID: <675c7681-c495-727d-1262-ee8c6a5c8ce5@github.com>
Date:   Wed, 16 Mar 2022 09:34:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH 1/1] mv: integrate with sparse-index
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Victoria Dye <vdye@github.com>
Cc:     git@vger.kernel.org
References: <20220315100145.214054-1-shaoxuan.yuan02@gmail.com>
 <20220315100145.214054-2-shaoxuan.yuan02@gmail.com>
 <1ab24e4b-1feb-e1bc-4ae4-c28a69f77e05@github.com>
 <CAJyCBORDOJUwTzOC+hYwGGPUBCXST0_mBdwRLh2N+cA=5k0d4A@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CAJyCBORDOJUwTzOC+hYwGGPUBCXST0_mBdwRLh2N+cA=5k0d4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/16/2022 6:45 AM, Shaoxuan Yuan wrote:
> Hi Victoria,
> 
> Just found an interesting (probably) behavior.
> 
> In the `sparse-checkout` directory created in `init_repos()` in t1092, if I
> say:
> 
> $ mkdir folder3
> $ touch folder3/a

The issue here is that this file is "untracked", not just outside
of the sparse-checkout cone.

> $ git mv folder3/a deep
> 
> and git will prompt:
> 
> "fatal: not under version control, source=folder3/a, destination=deep/a"
> 
> And if I say:
> 
> $ git mv folder3 deep
> 
> git will prompt:
> 
> "fatal: source directory is empty, source=folder3, destination=deep/folder3"
> 
> What I am wondering is that file `folder3/a` is outside of sparse-checkout cone,
> should `git mv` instead prompts with `advise_on_updating_sparse_paths()` or this
> "not under version control" alarm is acceptable?

Instead, what about

	git mv folder2/a deep/new

since folder2/a is a tracked file, just not in the working tree
since it is outside the sparse-checkout cone.

(If it fails, then it should fail the same with and without the
sparse index, which is what "test_sparse_match" is for.)

Thanks,
-Stolee

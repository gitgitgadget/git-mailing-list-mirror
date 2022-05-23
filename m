Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197B4C433FE
	for <git@archiver.kernel.org>; Mon, 23 May 2022 18:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240547AbiEWSwR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 14:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241534AbiEWSvG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 14:51:06 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E395DA20
        for <git@vger.kernel.org>; Mon, 23 May 2022 11:36:22 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id e17so12712227qvj.11
        for <git@vger.kernel.org>; Mon, 23 May 2022 11:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JkwIGm1g6zo15x4JU7BbDPwjDMXMG+02s8EFJ5yJqos=;
        b=iA6NrKEgX6Lx43ROcC5TnXpfc/g7Ar+KwK2EWL0poSvVfVkGAgP1bfaLcwdIKTcQJc
         VKZkhdkv2XWJh9nIpg02i44/RQfSWcWh9+HsZ7WBRkdZO2BG54OypaUYA/xAITxFTZdN
         RM9XkUr9N2F2vshXinFvz/24yJTx0LBpQ7Vd95v0oc3r950hax92pl1wIyTZhF6W3XSp
         sXrR0yH1Udg4Q0RC1v+faLQrgI7EQhvtxgDZjgEa6UCb2Re/3wrqGD+MeAlRYoqHPLlU
         zuW3dmH6WRIKg5xoFtRjYVIMseVDJi1bABDBFDKyzMuXGMXNHiXC0PYOs2tOIHqeAKIV
         Ax/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JkwIGm1g6zo15x4JU7BbDPwjDMXMG+02s8EFJ5yJqos=;
        b=0cRhglx/0uq8NbZFlgRDudafnAIxEbwVLWxxUZJLWWon0+ixKtgBTRMTOXz8cQn9zR
         g0R+u1CqngANZUZJpK4Vpmv6bHyTb/MuyFh4v21GI8C7BffO5SJGcaDWU24qheR+VhL2
         PoNB3Sr72Gpcy0eT045cmo/szu11qAb/G7oLsslWmg55aMh3WllRuc/bH41q40ItP4qG
         G/cP86zwDqW4qkzIJP9InTO3cdEXc9zlgmtsC5BpfdoGI3pwrclrnLtF+U7a6NkrVfle
         /e0FBIWdCwirkr/AI9aRoAb5HObqgMni8AUsWYAJGTj/ugelgSbQAnfNTZwB3G1Yl0Ug
         hJBw==
X-Gm-Message-State: AOAM5337oXF4VjPglYOhdLDyON1sWqWSVBIpMRcNaEy8Ui0fKE9rcy+J
        FZHuxXoxwpWUS4Jwwf7K7qmK
X-Google-Smtp-Source: ABdhPJy2JlSD82kSCNoOgMRQL3FcYCd/pGRIuNebxFd0oYSu27Py8FmEgFj+Fwq193X/aw0BUdvpDg==
X-Received: by 2002:ad4:5948:0:b0:461:fc7d:a48d with SMTP id eo8-20020ad45948000000b00461fc7da48dmr16065151qvb.96.1653330981207;
        Mon, 23 May 2022 11:36:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:71ba:8ad9:40cd:d364? ([2600:1700:e72:80a0:71ba:8ad9:40cd:d364])
        by smtp.gmail.com with ESMTPSA id a68-20020a37b147000000b006a33fc1113csm4926326qkf.23.2022.05.23.11.36.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 11:36:20 -0700 (PDT)
Message-ID: <75aa1726-dca2-5e4b-387e-229e1501209e@github.com>
Date:   Mon, 23 May 2022 14:36:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH] Add pcre2 support for cmake build system.
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Yuyi Wang via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Yuyi Wang <Strawberry_Str@hotmail.com>
References: <pull.1267.git.git.1652846305514.gitgitgadget@gmail.com>
 <xmqq1qwqts6w.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq1qwqts6w.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/18/22 6:02 PM, Junio C Hamano wrote:
> "Yuyi Wang via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Yuyi Wang <Strawberry_Str@hotmail.com>
>>
>> This commit fixes one of the TODOs listed in the CMakeLists.txt.
>>
>> There's also some small fix to ensure it builds successfully.
>>
>> Signed-off-by: Yuyi Wang <Strawberry_Str@hotmail.com>
>> ---
> 
> I haven't worked on the CMakeLists but is the above description
> sufficient to tell what is going on if given to those who are
> familiar with it (I ask because it is not clear at all to me).

I had the same confusion. Perhaps the message could indicate
how one could test this PCRE2 compilation so we could try it
out ourselves?

Thanks,
-Stolee

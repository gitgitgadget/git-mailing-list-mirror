Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B677C77B7D
	for <git@archiver.kernel.org>; Wed, 10 May 2023 19:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbjEJT0j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 15:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjEJT0i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 15:26:38 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84105595
        for <git@vger.kernel.org>; Wed, 10 May 2023 12:26:36 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-55af4277904so117770007b3.1
        for <git@vger.kernel.org>; Wed, 10 May 2023 12:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1683746796; x=1686338796;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cQVg/yRqK2Z6mWc7P9cITGrxGNGvhoaIia+gLb5LtI4=;
        b=KKoLObjjRKqmTGTYXZtTDt7NYArNn30zgYQkO8Z4svVHH2bZ3DcSDSfdl3SNXmkxj+
         dbActXmhF/z3Mulnvo60HLBvHI/VfoXmKzdPxX6sSSSp/h9cJlrV1gYyhQWSGcJv/x6D
         NnT7Lfvo++SXjhSnNT+lrbEcP9QUYBXrxUkQWZi4co++npucB0HPE5TBuhk37GRLbDv8
         Ov0XGQfgy9NzsgxuCwHGlRn7QkJC3j91bICKtcEzU+UBZfbTywBgvW2//Rsd+OcaffqQ
         /dndlLLwuEaplkH5GqrFr7HhH9yBK0ZcD9lwRQgte86eosLwUnMtVcJahOH+YL1gisnf
         9OOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683746796; x=1686338796;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQVg/yRqK2Z6mWc7P9cITGrxGNGvhoaIia+gLb5LtI4=;
        b=k2l5RLaIBg9aXgRF7ZjyofqIA289XqSVGNsFNUtHCmLln6TRpIUuurQuZVo50KAODo
         QFh8iF2Xx1gT8f691QTlELeiyDahbt4boWlyAwvaCYcCrxV6YK5jLA9JvAGUrvoYX6Re
         20hFqF+kLbOjHoPNKM4bLfLanTTQ1ioWBI+f7dJekI55UwUWgP/8wHFPBTrMJCa2AOtE
         G/ZaC2VL0pip5B9AtAMcSyfdh4jO6wPmiIzpluE7xJXOzcXEmgI96qwW4m8shc1VpBIN
         BvUQeQW2uapAu+DJFldI/31xMZHX77Ho9XPdOPqAvjZ5clNgZWu4iuo8H9QhUaGqeh0o
         NP8g==
X-Gm-Message-State: AC+VfDxUcix1yQO1a4zW4+wGAOHCUHcIMi9HOYJf4OJDHPye+wQugYc8
        vUYltzLNpIHaInXrDsb0fEum
X-Google-Smtp-Source: ACHHUZ7gqv2jW0UZTvRtqNOcEJBQVDldXMcPr1op3//a1DcnajnwFH5qU6ipamMIgD6jLs7B0e5HyA==
X-Received: by 2002:a0d:ce84:0:b0:55a:30f4:23e7 with SMTP id q126-20020a0dce84000000b0055a30f423e7mr20501588ywd.24.1683746795912;
        Wed, 10 May 2023 12:26:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:872:7afa:ea2c:790e? ([2600:1700:e72:80a0:872:7afa:ea2c:790e])
        by smtp.gmail.com with ESMTPSA id q188-20020a8180c5000000b0054f9e7fed7asm4322079ywf.137.2023.05.10.12.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 12:26:35 -0700 (PDT)
Message-ID: <cc058647-554b-3b40-b8b9-52de0b7bd9e4@github.com>
Date:   Wed, 10 May 2023 15:26:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] merge-tree: load default git config
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, christian.couder@gmail.com
References: <pull.1530.git.1683745654800.gitgitgadget@gmail.com>
 <xmqqsfc43si0.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqsfc43si0.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/10/2023 3:18 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>>     This patch was reviewed on the Git security list, but the impact seemed
>>     limited to Git forges using merge-ort to create merge commits. The
>>     forges represented on the list have deployed versions of this patch and
>>     thus are no longer vulnerable.
> 
> Let's queue directly on 'next' (unlike 'master', where we want to
> merge only commits that had exposure in 'next' for a week or so,
> there is no formal requirement for topics to enter 'next' before
> spending any time in 'seen') and fast-track to 'master', as I've
> seen it already reviewed adequately over there.

Thanks for picking it up so quickly. I did not mean to imply that
we should merge to master without giving the public list time to
digest the patch. It is a rather simple one, though.

Thanks,
-Stolee

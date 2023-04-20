Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01E0C77B72
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 13:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjDTNOv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 09:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjDTNOr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 09:14:47 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D47172A4
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 06:14:15 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54ee0b73e08so41921347b3.0
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 06:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1681996451; x=1684588451;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ke7rOB6/HAFURpoFEl/GABaBmaqqIWPuOg9v2t2RUUs=;
        b=UbtFGRdhphSMSRPplSSrp7T0933HoExWZQ7gJopfNAMQiLQtoQqd3Tx7HVP5YEFU3W
         AoyHcU/oldhgLFKhpb89mR9ktHYrU378YWIBSB5fCcb6cznwVIdT5l7QvYbsQ+OfOW3S
         6QgYE2gJO+e6QQBulEao2e8O3rlBhotaky+nZZDdkb1leigpL5vlABBWshwXnF7T16qV
         BenCVYZXqMDUjTg7tg0676xOJNSwwReUtoz2UZ1d/axxAWsd+U+dtDtRCv20BRzpNQ3+
         pCJvY0XqUclIt+P1nPoZMh4OMhJOKWxw4ZBbirmL2jnOqi1Mgxb+4XXdkQ4o3wGWwM4w
         ucwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681996451; x=1684588451;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ke7rOB6/HAFURpoFEl/GABaBmaqqIWPuOg9v2t2RUUs=;
        b=cYs2aVBN4XOkQmOo+syvBSvVLrd5YXkZEO3L/FPxGLlYjy7cTbBPfugz/jaeremJeI
         Olb3CMZLLjsFPTC5h5mKoY6DmywvZyWzRIwa/0gCNr+nGZkfMdVqTMQpcjg4tjmPoRS0
         /fGMJ/h6pujRL5ArRFHVLUa2sKLokxWQIN/19uRPk4jwbEaIEpoWeA7aSwMdiZePZ9kH
         3cpwJMcvODeVJtqcy3lvALhx2g5eiZ5fq6cp/rNotvg4QVx3mxrssK786VC6wymlcaZ+
         9XslyS7iBqVaMzDSNGauOmglrBZMwmh7XtJ3y/4VuWrbAplLutKN8lGtMNLlDPYSKREb
         evgw==
X-Gm-Message-State: AAQBX9eJFBPHTb/siF9NgkJ+Ow3ctornV99cSmEazlDb3MPZmyYbNw6c
        QO4dw87evboOiKSelqEzMMhJ
X-Google-Smtp-Source: AKy350YorIJo/0Y5QWvhaJbZ/GuKMkjEn+F8224xpocjQRBaXUGEU25QmlQ8mReq2QuNK3ml8MH7Hg==
X-Received: by 2002:a0d:cb12:0:b0:54f:16d:c3d5 with SMTP id n18-20020a0dcb12000000b0054f016dc3d5mr778889ywd.22.1681996451319;
        Thu, 20 Apr 2023 06:14:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:c9cd:9424:a6a5:5425? ([2600:1700:e72:80a0:c9cd:9424:a6a5:5425])
        by smtp.gmail.com with ESMTPSA id w137-20020a81498f000000b00545a08184d5sm320909ywa.101.2023.04.20.06.14.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 06:14:10 -0700 (PDT)
Message-ID: <947db4da-13d9-d81a-1c0c-d8fe62a9279f@github.com>
Date:   Thu, 20 Apr 2023 09:14:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 14/23] hash.h, repository.h: reverse the order of these
 dependencies
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Calvin Wan <calvinwan@google.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
 <1c6989ae456c86850761b079384f1505735e317a.1681614206.git.gitgitgadget@gmail.com>
 <ad90e716-ba23-040f-66be-4c4faff02ea8@github.com>
 <xmqqedogbwh3.fsf@gitster.g>
 <CABPp-BELApT-6YrYJ5qwme9uwP_2gqERdiLiE7mJu_b0bXmCbg@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CABPp-BELApT-6YrYJ5qwme9uwP_2gqERdiLiE7mJu_b0bXmCbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/20/2023 1:06 AM, Elijah Newren wrote:

> What would you think of either of the two following alternative solutions:
> 
>   * Move these into a new header, say "hash-repository.h" that folks
> could include.  People wanting to use these macros would have to
> include an alternate header, but one that is perhaps more logically
> named, and would allow other headers to get the basics of hash.h
> without repository.h
> 
>   * Move everything else in hash.h to a new header, say
> "hash-basics.h", which hash.h will #include.  That retains the ability
> for people to depend on hash.h and use these inline functions, while
> also giving other headers the option of including the basics of
> today's hash.h without repository.h.

I like both of these options, but prefer the second one.

This is mostly because most consumers in the Git codebase will want
these methods, and only the most fundamental hashing code will care
about hashing separate from the_hash_algo. So, the most-natural name
for "the header file that lets me hash stuff" would be "hash.h" and
"hash-basics.h" is for "I'm doing very simple, low-level hashing".

Thanks,
-Stolee

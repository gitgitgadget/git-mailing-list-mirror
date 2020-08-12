Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BA2C433E1
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 12:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 113A8204FD
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 12:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bv0bpAdW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgHLMzZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgHLMzR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 08:55:17 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5D9C06174A
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 05:55:16 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id n129so1872092qkd.6
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 05:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BmnaG2VayU98wTvwqW9h2+3U0BxM+/A6+jeN6AHB3xI=;
        b=bv0bpAdWYjwVP93N16IIbMd4D8qRVrbGGmvN7Z5DCeknDLlouofTAbnKWXxITUxaoy
         CuqFk8qmSskg8q5gRjMhZnBTElU3BsWkxiOFeGYodTCJyQmGpb3Js9iHVNfUumdxAw76
         CTdgAG/8vdGl2A9T5k9WQBK5D1Q16YPc3bD5WKnlqBGgcSIUxYinfLnALbEt9SIDEjXt
         O9yfl50Rli/CLwqmxHEZnOyD7MTG7YeVzYINYDBs/UqqhAkD6WwEeJAU9ijioHwRcOr9
         fg9RTE8nZEw9drZXcsmWQV6Apng77QhsH7hyGwlb1AqCCFhnkbKQIOXKPj0CZUf5NZ7h
         idlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BmnaG2VayU98wTvwqW9h2+3U0BxM+/A6+jeN6AHB3xI=;
        b=TTkTLqtgzICEQIprCLRCl9aJX1y/6T0vZZNJ5g/9BZUdaEg7fXf9+mUXh07B44qR7I
         Gwuk5YWBn0hi8Uaxsxu1zaVUmFeY6eFyFlsd19T67XpT9c4+NZrVrF4F6Ypz1Gvf4QzR
         CKh5WpYzCZHsGxpXhsrpVzfqbG8x95G6fDTQbq50kx3EvrqlEGioqV2RX2osV5oTnWUc
         PVQEMHJHIggdNpGfkGSk/cJpqmTqPXmrPOKh/wiE6COGtpUJDYFtmICa9tCtekfAMN6C
         cszNXkUVAxdZy0JDwXEYUnCeVQmZ21lLtyCBOXG9U9hQZ6sH3E2Pw/bbeMnhgLitmvFU
         lFcg==
X-Gm-Message-State: AOAM532dx29Qcs5M7pxjjG7OCdeGyrsp8rt9lZg5lUEl7a3ul1KjnjyI
        g6YgDZQzhMRgOKN82man67I=
X-Google-Smtp-Source: ABdhPJwdBbxws5l6JRfRKBKSaZUOETqbGN1VI6TSe0mkGR2OFgAUv7R/fgbdQvwBizpB35gbuIYduw==
X-Received: by 2002:a37:63d3:: with SMTP id x202mr5604283qkb.1.1597236915322;
        Wed, 12 Aug 2020 05:55:15 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:79ce:9d5a:1dc3:8f14? ([2600:1700:e72:80a0:79ce:9d5a:1dc3:8f14])
        by smtp.gmail.com with ESMTPSA id y3sm2216100qkd.132.2020.08.12.05.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 05:55:14 -0700 (PDT)
Subject: Re: [PATCH v2 1/7] negotiator/null: add null fetch negotiator
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc:     gitster@pobox.com
References: <20200724223844.2723397-1-jonathantanmy@google.com>
 <cover.1597184948.git.jonathantanmy@google.com>
 <35bdd372ae3691f54775dd616576e8ed6d68f1d3.1597184949.git.jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2f6b3e7e-8f83-bfde-ab63-1eed08ff32b5@gmail.com>
Date:   Wed, 12 Aug 2020 08:55:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <35bdd372ae3691f54775dd616576e8ed6d68f1d3.1597184949.git.jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/11/2020 6:52 PM, Jonathan Tan wrote:
> Add a null fetch negotiator. 

I understand the value of this negotiator. I'm concerned about using
"null" as the name, since it has a clear relationship to zero-valued
pointers and that's not what is happening. (My gut feeling starting the
patch was that some function pointers would be NULL or something.)

Instead, might I recommend "noop" or "no_op" in place of "null" here?

Thanks,
-Stolee


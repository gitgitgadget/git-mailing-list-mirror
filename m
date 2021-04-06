Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01987C433B4
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 13:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB827613C9
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 13:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239590AbhDFNFV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 09:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbhDFNFU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 09:05:20 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF76C06174A
        for <git@vger.kernel.org>; Tue,  6 Apr 2021 06:05:11 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id s16-20020a0568301490b02901b83efc84a0so5611706otq.10
        for <git@vger.kernel.org>; Tue, 06 Apr 2021 06:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iOs+CTo0eDBV1OCnPQpq3lO91Fvl08Wj0F8E9oHMPA0=;
        b=P7Sx701wkG2bv+8SCZyBK0lo9gW2jqBgapR1zVK3rLSbSJ+bKFtRfj+zIiEL7R0ATm
         eqUhDu/I4SYpB4WHSJCI1pyIJgoeoYpKBLgl6YoMGBtOOP9/DRoG3yvtGLMaOsjVB5mQ
         If/TYFK3PvaeiWcYxRoJ6Z5onyF1q+PBsSY2s3fYgRsLbaSAMgA1zLLj3yK69ju1kQmT
         aYI2SGzi6sJ3cdspqtlBjYkA0PPn6VaNjhH09khXBq37R1/rzp+DKTLxtc2fWOc9dZ+C
         oGQhf6riVsJNJa97HYEO+xbi0FfaFPSxkspyeyZzsXg3hYpdiR+kh/stoxF6uAbSA+vT
         al2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iOs+CTo0eDBV1OCnPQpq3lO91Fvl08Wj0F8E9oHMPA0=;
        b=K/UfJsb3zr0lswJAJGsFz6OBkndckXMYxfdqkgifct0N38a/PWHenerWrFYmgf245f
         yiWwE7HOllnTtLaBhAqn9v2qBbEhCTf6mcrm4rUs6VKLroVdRfMpW1snNFbWKs1WZ9d5
         TCV6div95N+FFh5k3GPCgQLm14BPHbOflBczJuuaXSkFkidF2FFDfwVbuxlNAeOrVf4d
         apwIB4kKx5Tew4mIhm7sQnnR7aOPGrDd75RWx3BGOsKj6XosgrMnWCqcmqHfN0WgZes/
         TYiXy1Vmnh1uKYr3s1OZ9oY1qhxDerH2iY3+FTfL+HAATlPRUyaPE/ULM4nSDORBWrbr
         pvyw==
X-Gm-Message-State: AOAM532J8GkxE8dz/uMHqz77FSf4GxwKpxUUCCP9ROYqzoDxN7bEfYsg
        s7lqlfLMAPwk9GKd3Z04vYY=
X-Google-Smtp-Source: ABdhPJx7UxPBrhAXvZCiyGT1Dg/hWH/CRxKPyzNtbRaaxGfkx3NgWq0y66JeLtry5TGFGcohhPwZTQ==
X-Received: by 2002:a9d:6e18:: with SMTP id e24mr27012592otr.284.1617714311269;
        Tue, 06 Apr 2021 06:05:11 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:7d35:99dc:7770:379a? ([2600:1700:e72:80a0:7d35:99dc:7770:379a])
        by smtp.gmail.com with ESMTPSA id a16sm4675374otk.62.2021.04.06.06.05.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 06:05:10 -0700 (PDT)
Subject: Re: [PATCH] test-bloom: fix missing 'bloom' from usage string
To:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>
References: <20210406023514.27060-1-chriscool@tuxfamily.org>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <149395c6-1c68-cf8b-2322-e62b0e48c652@gmail.com>
Date:   Tue, 6 Apr 2021 09:05:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210406023514.27060-1-chriscool@tuxfamily.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/5/2021 10:35 PM, Christian Couder wrote:
> Like 'get_murmur3' and 'generate_filter', 'get_filter_for_commit' is a
> subcommand of `test-tool bloom` not of `test-tool` itself.
> 
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  t/helper/test-bloom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
> index 2a1ae3dae6..ad3ef1cd77 100644
> --- a/t/helper/test-bloom.c
> +++ b/t/helper/test-bloom.c
> @@ -48,7 +48,7 @@ static void get_bloom_filter_for_commit(const struct object_id *commit_oid)
>  static const char *bloom_usage = "\n"
>  "  test-tool bloom get_murmur3 <string>\n"
>  "  test-tool bloom generate_filter <string> [<string>...]\n"
> -"  test-tool get_filter_for_commit <commit-hex>\n";
> +"  test-tool bloom get_filter_for_commit <commit-hex>\n";

Obviously correct. Good find.

Thanks,
-Stolee

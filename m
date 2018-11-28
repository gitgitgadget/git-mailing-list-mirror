Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7F9F1F609
	for <e@80x24.org>; Wed, 28 Nov 2018 19:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbeK2G6q (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 01:58:46 -0500
Received: from mail-yw1-f46.google.com ([209.85.161.46]:43998 "EHLO
        mail-yw1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbeK2G6q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 01:58:46 -0500
Received: by mail-yw1-f46.google.com with SMTP id l200so11241918ywe.10
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 11:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=67DtyK+x9rUhBWBmk15mjEfXQ2OaG3F8/eNXkLGVk0o=;
        b=cYYDqtd++41YtlRH5JafvC90CmJ5NoG9KsTTjMS9UaLTuzQsBQAwN0vqtESIyExx6j
         HH3T1J26exjraBzSbJNagH7CNK47o3otF+4kb0U8QqhSZNJSYI0PA7LhVVtnVHYEqj6H
         K2t06gRIll6aFxf50jZKyhK4QBYpVFPXt4zqw9YSwwYzu2wWu0FqK3tF2aGn7z9kK5Qf
         4xrN7w755DIdSDD5gdz6J4WGl4K4ZeFVcnsCo7V1rr0f4cAJxCXS5TLmSgB95/magc44
         /Oj0QZC912AOOli8i3ATkJJnGG6FpfCP3H7Qef6HeGNpshs/e+ZgQOZFXfL0SMGR1qKa
         4HIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=67DtyK+x9rUhBWBmk15mjEfXQ2OaG3F8/eNXkLGVk0o=;
        b=r9muTm0xbxvD0Ump3YpKImFpxQN37Kjx3lxCodo5Vck2CgYNJ/fmPOREqoavT0I0xK
         j4I3siyso1KwWDz2KpxOvXIwaQ4FNTz2x3LKHWWz/MZHIVSfSuOzgtb15woRM5GwsMFE
         Y4i9GUZp2xaXyfL+Jp2QCwRF5b8o5Jtpv/5RQ1ziC1vlEIbokeJEILxAQRH5Q/oUw/Sv
         FzpgGSCV7sHMFyaYRGhf8GyzwKnS7XmsdZZshJ8jNEmKZocuDyH1l8CLd9Fp2uSHkETs
         z3lMIZtgQtwSZfoZ7D/Y4KXV42bQPRqq0jaLVsvPgxaCj+Yi4SZ71pzMpoKzullrdVly
         PcWw==
X-Gm-Message-State: AA+aEWYUURVOT5dLtBY1/cq85b4y8GbpGPyjudXa+8EeeLlXbouetFWy
        Vgk7MxjiOvXqv4Lilhsre/g=
X-Google-Smtp-Source: AFSGD/V4OhuYa/iYvGYfYH+rsYAK+V8L813uKU8QKKb2sXvByLpYUVjpPVDeYiSFGt2xCI+SpXEdWw==
X-Received: by 2002:a81:378b:: with SMTP id e133mr35961291ywa.79.1543434957927;
        Wed, 28 Nov 2018 11:55:57 -0800 (PST)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id r63sm2145364ywe.18.2018.11.28.11.55.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 11:55:57 -0800 (PST)
Subject: Re: [BUG REPORT] t5322: demonstrate a pack-objects bug
From:   Derrick Stolee <stolee@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>
References: <20181128194536.57019-1-dstolee@microsoft.com>
Message-ID: <8774b686-e399-975f-b033-421b3ec1427d@gmail.com>
Date:   Wed, 28 Nov 2018 14:55:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20181128194536.57019-1-dstolee@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/28/2018 2:45 PM, Derrick Stolee wrote:
> I was preparing a new "sparse" algorithm for calculating the
> interesting objects to send on push. The important steps happen
> during 'git pack-objects', so I was creating test cases to see
> how the behavior changes in narrow cases. Specifically, when
> copying a directory across sibling directories (see test case),
> the new logic would accidentally send that object as an extra.
>
> However, I found a bug in the existing logic. The included test
> demonstrates this during the final 'git index-pack' call. It
> fails with the message
>
> 	'fatal: pack has 1 unresolved delta'

I realize now that I've gone through this effort that the problem is me 
(of course it is).

> +	git pack-objects --stdout --thin --revs <packinput.txt >nonsparse.pack &&

Since I'm packing thin packs, the index operation is complaining about 
deltas. So, I need to use a different mechanism to list the objects in 
the pack (say, 'git verify-pack -v').

Sorry for the noise!

Thanks,

-Stolee


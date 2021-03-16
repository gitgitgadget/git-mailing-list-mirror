Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3794BC433E6
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 11:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3A5F65023
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 11:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237420AbhCPLn3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 07:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237402AbhCPLnF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 07:43:05 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2298C06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 04:43:04 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id m186so18169705qke.12
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 04:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=m4v+uNUyDNnDC8DF+TM3VTKuZKZkS2MQ6oR3Tk0O+Bw=;
        b=i97KV9tY7K0mq90Rr5BNJjaK3zRgYh9ccZjCdHBubsfBLclRNH06DGWJxrtZjw8qcf
         MzeMOvdSynqcJQxw2SwLO9WzwVtztltVnV28bmNUELlMczD1KBFNmr1YUq3+9Zzilng0
         ACfwPDCT237sdQloxGkJzE5YJt82swpDXhM807XjBYql7RDC1p1eJs2H6h4Fe9GfQC8T
         JhM8Et+33dtcF04VDD674VKSUnOhi5BuCT2FQOrCadl+lBj3LgHj1lRm50uGKjORzPPi
         ODly8efIkhaoLpNzidh6g+PxS6RUyhBOb5uHL6NJvQP33sEmncZapcR5HL9g9gv2ulJN
         N2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m4v+uNUyDNnDC8DF+TM3VTKuZKZkS2MQ6oR3Tk0O+Bw=;
        b=pinVz2Xj3LVDqR7WO9oEZ59KOCK49ztZjnivcci3pZk14GZPFmYEyxC0WWevsOcyH4
         eKaBkn0bN7mitJsf8NRj75fWuKV/6WwnarjeRGTZf0ZsYbVzBsBhoUbGmhTsHmNti6j9
         w//EK9lf6xSdj3uWZyBem6DxIyHhM2nBjOdqYJgcXbC2A8wH6dLJSkA3o0WXiwrxRKSE
         WacL2SUew/7QkDSMDWYbkAu623JkHP48BFFSGbVyTMISfKML0UG6VUWg24lHlCzhJm/w
         Al20UUUXpbdsHOl0dU36uIGxoXxgVw/F1SqjQps1m02G0fQsEfSzXrEPKqXM9wuYAgU3
         Mgqg==
X-Gm-Message-State: AOAM532U5Cw8uoz2Qw5dxof2Ki3O7reoRqTd14vUzkMGJB8KZ8AcVgdh
        R7QhKx6yibmVTU4h71BtMGaVzJMYHfGcyQ==
X-Google-Smtp-Source: ABdhPJwIErRwSCtPyfhMx1dSOpozXhsUr2+nvAN+MxJNnkPeON3QlRlE0Yw8zUQYfuzorOst9fvjLA==
X-Received: by 2002:a37:c07:: with SMTP id 7mr28576367qkm.312.1615894983601;
        Tue, 16 Mar 2021 04:43:03 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:fcd1:da21:8108:69bc? ([2600:1700:e72:80a0:fcd1:da21:8108:69bc])
        by smtp.gmail.com with ESMTPSA id e14sm14468917qka.56.2021.03.16.04.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 04:43:03 -0700 (PDT)
Subject: Re: [PATCH] xcalloc: use CALLOC_ARRAY() when applicable
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <b417c7cc-8e40-04df-0314-d4c3fab278b7@web.de>
 <b2942f67-f0c0-872b-9b8c-11b6ea295412@web.de> <xmqq35ww1amf.fsf@gitster.g>
 <48772615-4b68-724f-dae6-4153aafbde35@web.de> <xmqqk0q8ynz0.fsf@gitster.g>
 <xmqqft0vzzm9.fsf_-_@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <311a844d-a174-3e22-a7f1-3339e00e5241@gmail.com>
Date:   Tue, 16 Mar 2021 07:43:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <xmqqft0vzzm9.fsf_-_@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/15/2021 8:55 PM, Junio C Hamano wrote:
> These are for codebase before Git 2.31
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * In addition to fixes to topics in flight, I found these in the
>    codebase dating as far back as 2.27 days.

Thanks for catching these items. LGTM.

-Stolee

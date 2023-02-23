Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62253C61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 05:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbjBWFvd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 00:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjBWFvb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 00:51:31 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38AD498AB
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 21:51:30 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id gi3-20020a17090b110300b0023762f642dcso798008pjb.4
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 21:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ht0lk8DFUjah6Y6nDdX9Eq0icx2Aj1Rk4D77AtzY9c=;
        b=d/8QG2CIyNoqRwTWjMxQSeoXwIBVgcfcUG4X0L1vl9+GdTU6hQhJxqXq2OoMADOEkf
         3M2GTYkdHhpxOVgQ/neC6dsztsoUaCydG0mo3VtTMs8NtTW4VJGbTxf3N+8BmldQogC+
         hIa/4HTOrlzLLzjzoXW44SFLKYQywrCUXK2RDwbu6lHb08rpKVqL1LT9IAJwNi9I1PDi
         IrMDuQZNkZjGUMvHQKZtikICrslG7w3Ezid0SljDw4qo6wBasoiWjrwPlDXc9DOTYfY9
         jrF05iA7BX6KGVls87YJXolyEmsM+iKmSD4cl+Fll7423CLHy2uULMveuQuLkzyuA26U
         7hhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ht0lk8DFUjah6Y6nDdX9Eq0icx2Aj1Rk4D77AtzY9c=;
        b=5qKG0b3fO9GMcw4SjRu6v715DTbAoA7BxU1kMcOb4atmNi6yTL+0M0uZlumh3qhlBe
         homPOrACSCf+Cjkwh0kTqTRZ1pzTqS7BH06ap/CvhYE9xEXQo/ptvsT22kASPCtKlUTq
         ZFmbKI1qdekLSckQYAmwRQ6quHXzMYDWxECZobFd2RDDMzLdyeGbSwn2/zxt1YTN4i1e
         wMg9gO/E7pkwlgP9VKwQxYMLZ+QskazPFIvrfl4sy49S6hsqpWGnZrpH2MV6oiaulz2V
         YGpu2JvEXNlbELhHUJbFaJImI+Lo2vtbyn6UD0GQvtQU2MOQUGKrgYOOQQdrCxW+ZUHC
         r2wQ==
X-Gm-Message-State: AO0yUKUjSRZL4piW7h2ygv4Fb02aBrODmm9PwHXYwTISfhMw+Bzmyn1S
        S/48jXaIjVLaj4YXOz6JgBJ1thCObFv/hXg=
X-Google-Smtp-Source: AK7set+g661n+PogDJyi1b46BzoaKFxCrZEW3WzQee3+vnx9n81peGZqZ0ktWAFEihMBVESve63XcQ==
X-Received: by 2002:a17:902:f98d:b0:19a:ac93:64a with SMTP id ky13-20020a170902f98d00b0019aac93064amr10020481plb.18.1677131490181;
        Wed, 22 Feb 2023 21:51:30 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id r18-20020a170902be1200b0019cad2de870sm1992362pls.211.2023.02.22.21.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 21:51:29 -0800 (PST)
Message-ID: <3ab86863-fa15-a5c5-08c8-73ad775e04c8@github.com>
Date:   Wed, 22 Feb 2023 21:51:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: mc/credential-helper-www-authenticate (Re: What's cooking in git.git
 (Feb 2023, #04; Wed, 22))
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
References: <xmqqbkllaxd7.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqqbkllaxd7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> * mc/credential-helper-www-authenticate (2023-02-16) 3 commits
>  - credential: add WWW-Authenticate header to cred requests
>  - http: read HTTP WWW-Authenticate response headers
>  - t5563: add tests for basic and anoymous HTTP access
> 
>  Allow information carried on the WWW-AUthenticate header to be
>  passed to the credential helpers.
> 
>  Will merge to 'next'?
>  source: <pull.1352.v10.git.1676586881.gitgitgadget@gmail.com>

Aside from some relatively minor touch-ups, this has been fairly stable
since v8. I'm happy with it at this point, but I'm also curious to hear
Peff's thoughts (since it was his review that prompted the switch to Apache
for the test helper, among other changes).


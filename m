Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348A1C433F5
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 13:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiJGN3Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 09:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiJGN3X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 09:29:23 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B100DFBCEF
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 06:29:22 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id t7so2842963qkt.10
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 06:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KuOLOtrb0hZCajl0SfWWlEQ6qWvVDrGyED1BSSXT/vQ=;
        b=C3V2Oao08yKMgB1oih/eluHJYuQVNtGWb2ZcmKTC47p9or6F77IGtQG7E59TnCJdaW
         X6etcyFE7mzZpTlZ+QdU8bYrnGS1MlHoxuKkh0QjvKepwbWONi4KJYLnJTwoyQ9wgyCT
         lzutQwYZIp/LMGrz+2JlAKttHPtga43m1lPWd3/7Wc8PQFVtN5XuaBDGgRSShsFsNT3Z
         T1Dx34dur2alqnDSyevNQ00w4PnGgDmzhvwKqtrzy8EIiWbMGP7BT9VOVqZY8/eeR4zO
         TwUjSXc0F+wNNAwcVW8ekA4fjXs3ZiRL9T3RTt3/Xuf0ad87G3WEyadUmeZeSpAZT6MW
         G8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KuOLOtrb0hZCajl0SfWWlEQ6qWvVDrGyED1BSSXT/vQ=;
        b=02wSx1UZLLXNI8Mgd4c+biR+K72z0RoopjfKXRfImI/Q3yuqLLlZEr9ReJPGnDI6vD
         YBsYGCiShOYGg/F60YNRCyf9fCIrjb6J5dHWcHTHJjrTaIthUZ+DZoU7a7V/7gq5gr1w
         hvQ22s2VGr4n66+KscnWnkHK2l1ywS7WfOohNTF4KK82AeGjVJjdpN5GMUjSE+kTrhZe
         bnTCsamlfj5QGal76EqLnhw/PuVS5kDNkqEe5U4Png9HSyKyvgqvg/CCfyXFziKhDs9Q
         kQBRgyQ8WpdHpVi98z3I1NyD+hYobcGAPpctbZUosTnGnXwIq4zX3HrF+5y0peJQPg9g
         mSAg==
X-Gm-Message-State: ACrzQf11QnU9fLm2/CEvqjU8/krSf51hn3LH5K9bT8CMkI0KoJnI41Cn
        TX8awhuAJi4gEI38fbjPifqY
X-Google-Smtp-Source: AMsMyM4bZwQHmJoy/b8Q8dTApA9v3OUuH9QFkeuNoCId7+4OxW63hBDXADVkPZdod0YnY4KMXJv2oQ==
X-Received: by 2002:a05:620a:44cc:b0:6ce:a6ed:ee62 with SMTP id y12-20020a05620a44cc00b006cea6edee62mr3533609qkp.743.1665149361699;
        Fri, 07 Oct 2022 06:29:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:2185:e582:857d:e0db? ([2600:1700:e72:80a0:2185:e582:857d:e0db])
        by smtp.gmail.com with ESMTPSA id bp19-20020a05620a459300b006cf9084f7d0sm2067204qkb.4.2022.10.07.06.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 06:29:21 -0700 (PDT)
Message-ID: <baf088d7-72f7-a811-888e-81526957ca4b@github.com>
Date:   Fri, 7 Oct 2022 09:29:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH v3 8/9] bundle-uri: fetch a list of bundles
Content-Language: en-US
To:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, avarab@gmail.com, mjcheetham@outlook.com,
        steadmon@google.com, Glen Choo <chooglen@google.com>,
        Teng Long <dyroneteng@gmail.com>
References: <20221004214455.3383714-1-jonathantanmy@google.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20221004214455.3383714-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/4/22 5:44 PM, Jonathan Tan wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> +static int unbundle_all_bundles(struct repository *r,
>> +				struct bundle_list *list)
>> +{
>> +	/*
>> +	 * Iterate through all bundles looking for ones that can
>> +	 * successfully unbundle. If any succeed, then perhaps another
>> +	 * will succeed in the next attempt.
>> +	 *
>> +	 * Keep in mind that a non-zero result for the loop here means
>> +	 * the loop terminated early on a successful unbundling, which
>> +	 * signals that we can try again.
>> +	 */
>> +	while (for_all_bundles_in_list(list, attempt_unbundle, r)) ;
>> +
>> +	return 0;
>> +}
> 
> This function always returns 0 regardless of how many successful 
> iterations there were: we would need the number to be equal to the 
> number of bundles in the list if ALL, and 1 if ANY. 

The ALL mode is a bit more permissive than requiring literally
every bundle: if some fail to download or apply, then we continue
with whatever we were able to unbundle. The ALL mode indicates that
the bundles build on each other, so the client should download as
many as possible. By contrast, ANY indicates that they are independent
so the client should stop after the first successful download.

We could still find a way to indicate how many bundles were downloaded
in the return of this method, but we don't want to have additional
warnings based on that return value.

> Which brings up the question...we probably need a test for when the 
> unbundling is unsuccessful. 

I will add more failure scenarios, including no successful downloads
or only a partial success in ALL mode.
 
> Other than that, everything looks good, including the removal of one 
> patch and the addition of the "bundle-uri: suppress stderr from 
> remote-https" patch.

Thanks!

-Stolee

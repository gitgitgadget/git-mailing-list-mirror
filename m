Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE22C43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 20:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235792AbiGRUbC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 16:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235704AbiGRUa5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 16:30:57 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0AC2E9FE
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 13:30:57 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id c16so5404337ils.7
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 13:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=H95TPD7yz/+XXzOtjjsAfIs19AVeykaMiEkamkqCvOI=;
        b=WR5Uvp3LnsKJBoOSZmWOX93j0jAL5rmJ4IbkCov0Y+4ewxPkUihb2XEI3Szvq5+y2s
         xJFjDL8MaYt90PZpaRWuPIGRrbmxHuabrLNXMeeHEfQFNeO0Ub9XTvVbNlKpAlSyt0Nu
         2+qptdgxxeQA8c+/YX1EteAKLQPCR46IcmjTYRYjxo579Er5kX2AYFlgMB/FFgyfLs1z
         fqnTpBJQW2UyEu9a/Yjl9GDF6KsbUwJmwcd2Lxa1st2crHLpDlOhLdT39t5fwZrZWt7s
         R22KbcrkhdDcI+4w7uV9ZWA/LXJigvt4zYauqoP3UjJQHz56Vn5cjOD01X1fVZWgxXgA
         Fi7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=H95TPD7yz/+XXzOtjjsAfIs19AVeykaMiEkamkqCvOI=;
        b=FQvk+LSP56FcHH33m+7+QVS20jce4o4T/0SHLK7bJL0vIIIbGfqbWUoZgB5VCW9xy1
         oPSSqnCG4BAYiTQvE1skHq5xwwXzXGt4Fatwx9FG+UKIHFQpOOueKRWkdKqHouqCBkKm
         VAP07SCkvI8sVvRW73qbfS9ricoX/91Iedn5f+viwaR3Wl4LLaqG6Je+uDzozydoBk4S
         cPmz1xqr9UNMrSHNqdEe8jR0rDnjKaEHF8NpEmJbNFCCe8bm08aTWx5aGAW/GRZ1PE27
         H8v+x1UEBo3pEEIcspewrGKcXyrnk212b+UbqnIHf41xmR48lF/wA3L7yOQzMZ//8Mzx
         DV/Q==
X-Gm-Message-State: AJIora8kymXpbp+IqE++ZkZPQtmg2lSjD/YapqL4t/bd6TPeZKAuD2bJ
        d+0u9PtcwvNVThDakoitG1a3c4IiaVSe
X-Google-Smtp-Source: AGRyM1sYpJbsFMDy0SvI2cF3LW5PUE2d+hd+0onyF1PL+ayyv0tsTR4zEwl/ZKR8WIvwzWX12RgoKA==
X-Received: by 2002:a05:6e02:1906:b0:2dc:7399:aa4e with SMTP id w6-20020a056e02190600b002dc7399aa4emr15139582ilu.181.1658176256603;
        Mon, 18 Jul 2022 13:30:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:74b1:e8b4:99c9:4baf? ([2600:1700:e72:80a0:74b1:e8b4:99c9:4baf])
        by smtp.gmail.com with ESMTPSA id p9-20020a056638216900b003316536ebc1sm5799956jak.73.2022.07.18.13.30.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 13:30:56 -0700 (PDT)
Message-ID: <a27913f5-797d-3de2-4c73-5c1b8e654d44@github.com>
Date:   Mon, 18 Jul 2022 16:30:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] builtin/mv.c: use the MOVE_ARRAY() macro instead of
 memmove()
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq8rp54r4l.fsf@gitster.g> <xmqqy1x531vp.fsf@gitster.g>
 <xmqq4jzpu4xp.fsf_-_@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq4jzpu4xp.fsf_-_@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/9/2022 9:33 PM, Junio C Hamano wrote:
> The variables 'source', 'destination', and 'submodule_gitfile' are
> all of type "const char **", and an element of such an array is of
> "type const char *", but these memmove() calls were written as if
> these variables are of type "char **".
> 
> Once these memmove() calls are fixed to use the correct type to
> compute the number of bytes to be moved, e.g.
> 
> -      memmove(source + i, source + i + 1, n * sizeof(char *));
> +      memmove(source + i, source + i + 1, n * sizeof(const char *));
> 
> existing contrib/coccinelle/array.cocci rules can recognize them as
> candidates for turning into MOVE_ARRAY().
> 
> While at it, use CALLOC_ARRAY() instead of xcalloc() to allocate the
> modes[] array that is involved in the change.

I'm super late in noticing this, but these changes will fix the
static-analysis build in the CI build, so the sooner this can make
it to master the better.

Thanks!
-Stolee


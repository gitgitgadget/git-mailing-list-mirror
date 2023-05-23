Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516B2C7EE29
	for <git@archiver.kernel.org>; Tue, 23 May 2023 13:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236999AbjEWNBK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 May 2023 09:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236858AbjEWNBI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2023 09:01:08 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC29FF
        for <git@vger.kernel.org>; Tue, 23 May 2023 06:01:03 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-561d5a16be0so93991347b3.2
        for <git@vger.kernel.org>; Tue, 23 May 2023 06:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1684846862; x=1687438862;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wmbNAfIp5l+R9ga3+hlHuA91W+mX8CjZRVaiOsCTKLk=;
        b=cCJGgYK4uuW6ZwzIN1p4BBMaVot77mBFGvkv2dxj7YAc972z8S29jgiCo7qzZV4Pn0
         u3HN7QAzK9Z821yfEvajh0iOJicKqXxEN1pxdTN8Ls+F/mLs7y0AhvZoxoUewHKiN+u/
         qqwwEzWAOnliUQMlHvL/Xc92RUctNqqQRDAzN6DIVfbyieI0wL39/FTYPT7B3i7xfxIU
         wS1QNe7HA3jnqnzcU6RjwVZ9bxdh7G1+e+/MIsFA9oYvTcsrMP5jI1MRVGjKCwZ3Z8Yc
         r5SFMQ9gM1wff+FhAFYquvftXmElLlZmHXT/I6oiQkG8WqLpMIkwyhrbnAWYn/NqefOq
         AECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684846862; x=1687438862;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wmbNAfIp5l+R9ga3+hlHuA91W+mX8CjZRVaiOsCTKLk=;
        b=PvTPIWyQoz9MDKaJSCrvTewJ1AgCj5+cLRHTCmKRzsfcxJsj/JCtMfzwS0lLLLoZS1
         PFvTohOzy8xdE4beafMcbMj79dn4q7JzfiMvd0sN3am4oX4AuteE3CoKstp6DpobGhOb
         y5ArKwq7MMyYyASWNCZg9pgy5oZqYsbnfKWKPPBMKMJ9kkhsRVr3cN/sl9Fp5q9xSPkv
         j4R4G+GU6DT+goSAHjwgSqji446p0OcFb0GM0GaP7h5mw9DSHT0bEeRsr5Df79/PgRXZ
         8aj2Uz0/gOe5w94raI/lmxM4r83DaSSnHv/5CqhEOUDVj9kjrt73xB0gKFWliEAnLOez
         gBmQ==
X-Gm-Message-State: AC+VfDxQKFSPkkvGI2cSKPOwo9D7GL7JBOoj9xLMKcfPvSecmxeGd5EK
        Xp3ebmlZlUDbDiBgXSMiUTCTVlgt/jsqpqLFYw==
X-Google-Smtp-Source: ACHHUZ4JBNTDWOcueX7NcAbPm2LY8Udj9386Sjp9o+tgNMWr2DkaSTDpH42Z4ihM+Ies8ShzeVzfwg==
X-Received: by 2002:a0d:c2c1:0:b0:561:bae4:c377 with SMTP id e184-20020a0dc2c1000000b00561bae4c377mr12971876ywd.14.1684846862241;
        Tue, 23 May 2023 06:01:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:e927:d084:264a:5182? ([2600:1700:e72:80a0:e927:d084:264a:5182])
        by smtp.gmail.com with ESMTPSA id g65-20020a0dc444000000b005612fc707bfsm2856474ywd.120.2023.05.23.06.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 06:01:01 -0700 (PDT)
Message-ID: <def26c71-0fbb-58a3-f1cd-f8e532b67503@github.com>
Date:   Tue, 23 May 2023 09:00:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] commit-graph: fix murmur3, bump filter ver. to 2
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc:     me@ttaylorr.com
References: <cover.1684790529.git.jonathantanmy@google.com>
 <1cb0ee10253ab38b194c6554ecc68a5267e21145.1684790529.git.jonathantanmy@google.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <1cb0ee10253ab38b194c6554ecc68a5267e21145.1684790529.git.jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/22/2023 5:48 PM, Jonathan Tan wrote:
> The murmur3 implementation in bloom.c has a bug when converting series
> of 4 bytes into network-order integers when char is signed (which is
> controllable by a compiler option, and the default signedness of char is
> platform-specific). When a string contains characters with the high bit
> set, this bug causes results that, although internally consistent within
> Git, does not accord with other implementations of murmur3 and even with
> Git binaries that were compiled with different signedness of char. This
> bug affects both how Git writes changed path filters to disk and how Git
> interprets changed path filters on disk.
> 
> Therefore, fix this bug. And because changed path filters on disk might
> no longer be compatible, teach Git to write "2" as the version when
> writing changed path filters (instead of "1" currently), and only accept
> "2" as the version when reading them (instead of "1" currently).

I appreciate that you discovered and are presenting a way out of this
problem, however the current approach does not preserve compatibility
enough.

> @@ -82,10 +82,10 @@ uint32_t murmur3_seeded(uint32_t seed, const char *data, size_t len)
>  
>  	uint32_t k;
>  	for (i = 0; i < len4; i++) {
> -		uint32_t byte1 = (uint32_t)data[4*i];
> -		uint32_t byte2 = ((uint32_t)data[4*i + 1]) << 8;
> -		uint32_t byte3 = ((uint32_t)data[4*i + 2]) << 16;
> -		uint32_t byte4 = ((uint32_t)data[4*i + 3]) << 24;
> +		uint32_t byte1 = (uint32_t)(unsigned char)data[4*i];
> +		uint32_t byte2 = ((uint32_t)(unsigned char)data[4*i + 1]) << 8;
> +		uint32_t byte3 = ((uint32_t)(unsigned char)data[4*i + 2]) << 16;
> +		uint32_t byte4 = ((uint32_t)(unsigned char)data[4*i + 3]) << 24;
>  		k = byte1 | byte2 | byte3 | byte4;
>  		k *= c1;
>  		k = rotate_left(k, r1);

By changing this algorithm directly (instead of making an "unsigned" version,
or renaming this one to the "maybe signed" version), you are making it
impossible for us to ship a version that can read version 1 Bloom filters,
so all read-only history operations will immediately slow down (because they
will ignore v1 chunks, better than incorrectly parsing v1 chunks).

> @@ -314,7 +314,7 @@ static int graph_read_bloom_data(const unsigned char *chunk_start,
>  	g->chunk_bloom_data = chunk_start;
>  	hash_version = get_be32(chunk_start);
>  
> -	if (hash_version != 1)
> +	if (hash_version != BLOOM_HASH_VERSION)
>  		return 0;
  
Here's where we would ignore v1 filters, instead of continuing to read them
(with all the risks involved).

In order for this to be something we can ship safely to environments that depend
on changed-path Bloom filters, we need to be able to parse v1 filters. It would
be even better if we didn't write v2 filters by default, but instead hid it
behind a config option that is off by default for at least one major release.

I notice that you didn't update the commit-graph format docs, which seems like
a valuable place to describe the new version number, as well as any plans to
completely deprecate v1. For instance, describing the v1 implementation as
having inconsistent application of murmur3 is a valuable thing to have, but
then describe the plans for deprecating it as an unsafe format.

Here is a potential plan to consider:

 1. v2.42.0 includes writing v2 format, off by default.
 2. v2.43.0 writes v2 format by default.
 3. v2.44.0 no longer parses v1 format (ignored without error).

Thanks,
-Stolee

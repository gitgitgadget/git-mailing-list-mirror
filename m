Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C482ECAAD3
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 17:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiISRun (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 13:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiISRul (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 13:50:41 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A810402F8
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 10:50:39 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id ay9so82456qtb.0
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 10:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=q1rDXJg0Cg28kzlpdokyZuk+FPpt82nludKLWc7DLFI=;
        b=FYrPzGCetoCAwN90zdXmPub88t2Ru2c26sWYzJxqi45UvlCdcTFrb9f2A3Hsxd9ELe
         vXkzYMU7Kx04seLzrsGVEQvsh6PF0M5OlAFHdROTCQLLT6QJd4rFE3fYvdov0I0Mz0zk
         DZDrfgeY8UplHF2deHPst8PyJq8ZY1keLt9fnmbrI0K/7Hec248k8IIMRpHMLiDm387K
         e9DKRRDn1bVr6B9F4mgo5+MDbS6WTMGXVV4doAsmjdUUPqojZiCJNpmtKtRTTXsWjl5+
         sHtvsrI2ZlO2t9ayROIkG6MxRYh81JqmNq09oxr4/N2+eW9sowNR47m7sGwEoTW7eO/R
         3cIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=q1rDXJg0Cg28kzlpdokyZuk+FPpt82nludKLWc7DLFI=;
        b=sIcWk6cyMkQxGhlJmqvHhGvxxVVSy6yxZpGNlb/6hF+3O+4OiiRbQFWgknBZVoDbKq
         BTD3A53wqGM0NUK56j507ril9Typr4fhj0LO1keH8fsKkyE2IrhjrBONIItiu15BosbF
         tjFxpaqWr/tDOVi9AP+GMx9zcNypATgwzoDyqx2HN4YjMKAThOZQ9gfTwhz/vujPOH8o
         uNDQ4MMG9mkMXEs8VbBYD5Cod2AhDxzJzptQxJMH3WBcpcB50Vt50FvLuSrrqaVLBlyT
         qDw7Ljehw3R/34lm9D7lIiAzwvbB8uSxjKjRsU49FXS46v0kpBJofFjsn3lQR8SXxIPn
         YTeA==
X-Gm-Message-State: ACrzQf1wIqa+zIDoocWajvpk+bbOSfC4Gafo6JVCY8j/3GjN/PZRbCgF
        LlvmamoUfPmH8BcrJ5NnqJzai4EJ/8Jl
X-Google-Smtp-Source: AMsMyM4FVVgGhxTHb38mPHF63DMktW7kG174p8zlTN3TziiQq+PlwFfBv40VuK9qSpqgDpuL1NMv1A==
X-Received: by 2002:a05:622a:44d:b0:343:571a:1420 with SMTP id o13-20020a05622a044d00b00343571a1420mr15936208qtx.15.1663609838298;
        Mon, 19 Sep 2022 10:50:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:fd97:43ff:6c00:2cf8? ([2600:1700:e72:80a0:fd97:43ff:6c00:2cf8])
        by smtp.gmail.com with ESMTPSA id o17-20020a05622a139100b0035ced0a8382sm1872845qtk.54.2022.09.19.10.50.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 10:50:37 -0700 (PDT)
Message-ID: <2c6fca96-6b7b-b4c4-526c-2497422d8b8f@github.com>
Date:   Mon, 19 Sep 2022 13:50:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 4/4] list-objects-filter: convert filter_spec to a strbuf
Content-Language: en-US
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <Yx1qwlpNbxGEiUgc@coredump.intra.peff.net>
 <Yx1sI8cjU/SWUKVy@coredump.intra.peff.net>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Yx1sI8cjU/SWUKVy@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/11/2022 1:03 AM, Jeff King wrote:
> -	if (!filter_options->filter_spec.strdup_strings)
> +	if (!filter_options->filter_spec.buf)
>  		BUG("filter_options not properly initialized");

I couldn't figure out why this would work until I dug into
STRBUF_INIT and found this:

/*
 * Used as the default ->buf value, so that people can always assume
 * buf is non NULL and ->buf is NUL terminated even for a freshly
 * initialized strbuf.
 */
char strbuf_slopbuf[1];

So, this makes sense now.

> -#define LIST_OBJECTS_FILTER_INIT { .filter_spec = STRING_LIST_INIT_DUP }
> +#define LIST_OBJECTS_FILTER_INIT { .filter_spec = STRBUF_INIT }

And now this macro swap works, too.

Thanks,
-Stolee


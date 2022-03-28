Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C045C433F5
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 10:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240373AbiC1KxQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 06:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbiC1KxP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 06:53:15 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2134E387
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 03:51:34 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b19so19728131wrh.11
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 03:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iusCNn47l1UGWyUUTwSXFqbjCWZXwPsQ+9g1owdhjDk=;
        b=g2ueMi69kp7WJ840ZRPhC88DexPCcrgmYQlL5hO2IlBSmzA0oHhavqL/KIH85TTxUJ
         lrTkC57ZbERTHeYc6yLugkedtz+rRYFEJUkN6yXn3sBVJSEkDNHVV31ACqkuFFHWxJb4
         HPe2OS0CUme//X+IidhuautpR0O0vabPTfZ6CkeOO7Y//eGSWrlNZuwZd6iL3UdRJV2t
         eBJDQsp+ORi2SVMFbp5eWhBmCTNT/+01dGoEngfpp1jUYJmO9TWhXepxVK9JJfjfQ2Q1
         T6jxxP1c5rHetKwEV21tVNw61oUt0NqkgaM/vbmdr5OTuU8saw98CcHHbWW8DcR/T8vM
         9KaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iusCNn47l1UGWyUUTwSXFqbjCWZXwPsQ+9g1owdhjDk=;
        b=s18iTJc6Monau+yGLMfLQB0pbj7P9paDkEMSeF4FJcQPhaMv8T7c8ZbV3dS/berA5l
         RPean0/La1AknSWrniTjDPdB7gYoQRQ/e11f6luA9LVrjaMJ+/DrC5tRb1s3e4wVhT7X
         gpPQUzgzpTTh3eYkNyQSkqka60s7N3Sq4KDs40tpSGCicvdx1xY0p0p+mlB5t3IgG2MO
         32datmU6XtUtCH/0eLBAjsGN5mYd7J9+QPi0s6a4WnqObaZnCFZsIJPxWXU6x2uDGb8s
         hWjWWmdsNFcvbOOrKofObB8gtZz16f/KOnNUdhN9Nz/aHSF8tOPjVNCJe5adggRAJY/P
         +PnA==
X-Gm-Message-State: AOAM533mYXqgwzH5EjZxKZ62jdmNwNz+V8Dk87s2RUATZH8pVQQ2ArQY
        wmStZmpKacLvuBUJ+Pijklg/p1rDj3YARQ==
X-Google-Smtp-Source: ABdhPJzuJkLUznT3a4Rguk5j80wY74j2ZXOkHGG6GkSUhjAWTpzjjs6vtxSuVzVHRaDG+6a6bEHrbg==
X-Received: by 2002:a05:6000:1545:b0:205:a82d:8007 with SMTP id 5-20020a056000154500b00205a82d8007mr16154425wry.88.1648464693309;
        Mon, 28 Mar 2022 03:51:33 -0700 (PDT)
Received: from [192.168.1.240] (172.2.7.51.dyn.plus.net. [51.7.2.172])
        by smtp.gmail.com with ESMTPSA id f10-20020a0560001b0a00b0020402c09067sm6033141wrz.50.2022.03.28.03.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 03:51:32 -0700 (PDT)
Message-ID: <7ff6c154-4f39-bd66-db89-970e92526ba8@gmail.com>
Date:   Mon, 28 Mar 2022 11:51:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/4] a couple of read_key_without_echo() fixes
Content-Language: en-GB-large
To:     Carlo Arenas <carenas@gmail.com>, phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.1146.git.1645008873.gitgitgadget@gmail.com>
 <pull.1146.v2.git.1645556015.gitgitgadget@gmail.com>
 <xmqqv8x5s1w3.fsf@gitster.g> <8d44b509-ff19-0629-30f5-ae785c73c3aa@gmail.com>
 <CAPUEspg1cJC_UwjJFx-jnzWsascY++S3UgM1UCLRcnK_Mv2wOg@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAPUEspg1cJC_UwjJFx-jnzWsascY++S3UgM1UCLRcnK_Mv2wOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo

On 22/03/2022 20:18, Carlo Arenas wrote:
> On Thu, Feb 24, 2022 at 6:30 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> That sounds good. I've got a couple more patches based on top of these
>> which hopefully fix the remaining problems (notably the macos poll()
>> bug). I'll polish and post them next week. Once those are in I hope
>> we'll be able to enable the builtin "add -p" by default.
> 
> As this topic just hit master noticed (I apologize for not doing it
> sooner) the macOS problem (tested in 10.15.7) was gone (suspect fixed
> with 1/4) and therefore enabling the builtin by default as proposed
> originally by dscho could proceed without the additional series.

Thanks for testing this series

Best Wishes

Phillip

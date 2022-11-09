Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB5CC4332F
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 15:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbiKIPPn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 10:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbiKIPPm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 10:15:42 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865111115B
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 07:15:41 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id s206so19118259oie.3
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 07:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kd7CKQFA5xVqYvQgSjviIk1x3n2arOmqMw1NbXUv+K4=;
        b=MDoCfFrmeo47q6LaiZa1i9Io9ZeNX5ARiyW4+kuzApNrpTU8ioWpxMbq7HKU9OCKel
         EFUpBZGtezplq/9Y2LRB+n3X9ZGcP7jEzaECGiquFTG07GPSpSV1z3OLjm8tPfZeTi1/
         m4v12QLsAQbjuhbFvz9en9lDuYo9+3fKfj9uzynU43dZcB/17jDe2aRQPLfG1jaPUpi9
         GIlvLIbc19lDRcFzsOfn6EKuqRf7WYeB0tDnxuuZ9zm/Yi54iJrIDsO647s09jjP84tn
         opZAOLghVJ+u6T2VE6fIwI247RwE4l0yKJHfPawbKNnUOqcqbCry1xwTXk01PE5PUq1s
         W/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kd7CKQFA5xVqYvQgSjviIk1x3n2arOmqMw1NbXUv+K4=;
        b=JukgRwg9c9A8FxiL6lBO1h8EvrG3cxI+EuCOFK3pKRGYAZAyQKDgbvIh2XadFhBntF
         xR8vtQNANSlp1exUJ7dnypVuOKGTRY6kTqadhUkAVQ2KcuTS42ZIocC6ceEqBINIy/it
         FlBU+hPrwKjY2PW0XYpXisgEIMtMR8osjXslxcFDxjKObcoNhqac45w3O5Rl4aDqXgHJ
         tiDFELVxcdOPqF2TwxBFHad9u2y/zrONUJQmgpfoKEd6GTOQ1HkJ91jRitW+NhqdlJdC
         NnzZLEVDRERPrSOo4RPxdDERSFU2nmF+UA6z4yaKPtEyfS4rBkxJqod0M0whYe5Auw8Q
         aUJA==
X-Gm-Message-State: ACrzQf3iNHqc6ghuJ+TiPrYavbxrBTnIbBwNO6WletNdMWLGqz0FBZFx
        Lp///9am96Zr2Sp/zfDusjpk
X-Google-Smtp-Source: AMsMyM6YYShlTy9flyIDoxr0kYCHG8fImLOBppN93Wn7H/7nfRhE3/r3UCp+4airKDvVrr8Q7YZThQ==
X-Received: by 2002:a05:6808:300d:b0:35a:7041:1200 with SMTP id ay13-20020a056808300d00b0035a70411200mr11983561oib.38.1668006940762;
        Wed, 09 Nov 2022 07:15:40 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:9489:2f30:3101:b539? ([2600:1700:e72:80a0:9489:2f30:3101:b539])
        by smtp.gmail.com with ESMTPSA id w17-20020a9d77d1000000b006679a03a753sm5317622otl.11.2022.11.09.07.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 07:15:40 -0800 (PST)
Message-ID: <5ca6f871-3b12-a6e6-2996-9f1a79ee0977@github.com>
Date:   Wed, 9 Nov 2022 10:15:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 00/30] [RFC] extensions.refFormat and packed-refs v2 file
 format
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     jrnieder@gmail.com, gitster@pobox.com, me@ttaylorr.com,
        l.s.r@web.de, mhagger@alum.mit.edu, hanwen@google.com,
        hanwenn@gmail.com
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/7/2022 1:35 PM, Derrick Stolee via GitGitGadget wrote:
> This RFC is quite long, but the length seemed necessary to actually provide
> and end-to-end implementation that demonstrates the packed-refs v2 format
> along with test coverage (via the new GIT_TEST_PACKED_REFS_VERSION
> variable).

Apologies. I had intended to CC a long list of people, but I messed up
the "cc:" lines on my GGG PR. Appropriate people are CC'd. Please add
anyone who I might have missed.

Thanks,
-Stolee

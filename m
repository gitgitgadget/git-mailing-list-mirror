Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5031C433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 19:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiCDTMP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 14:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiCDTMM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 14:12:12 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E3E199D7F
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 11:11:21 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id ay7so8781479oib.8
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 11:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AiDxHS2NdQhOu+KFhPqadeaaVXP/ilpPvsbeyXBMJ7A=;
        b=KR9ub9K3Iro7q3PvGmJpg5EoMCOBlHBs7205Awc3dTfSaZzcG8eYRsVckBAxfDGQGo
         13n50zgRp4mFUCWhZL8yh75DcmlByFadGV8ktckVNMlr90NsPav5iytTGy1PycIq8Ivq
         bUpkubmNVmBdserC5bSiQEbu81WV9UshGQDHhOtEpfwxrSZ9AoNqpLhySacy3Sktk9rJ
         ise7OYSki3tgFD04MDpAkRCwYbZCvzN3GH9yudaEMmv5JdxwwV4r1xOeTBxJ5jniNX5w
         7FtAeTbcaTOajTTjKe1dU5Jl29D8syE+mVPYw80j/aWuN58x38hWKSOsfkzlvsg1ommm
         hmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AiDxHS2NdQhOu+KFhPqadeaaVXP/ilpPvsbeyXBMJ7A=;
        b=hr49GIj7biDWWEP8Vzfm14IYnadjg8Xl2Vq0Z474ndjx23Lz+XgTak+9poEuTRix4x
         z4795fY9ybpDnCMNe9JZrg7ugOlisz2WVGCux+GAc+596SQEC6Qtz+q0xZFwmfJBRn6/
         9McdKuGuNPvvitcHNyxV/jMxXwBMfnj/oyBAtN4gjanJ3KH+ggVJYKdbQSoLgGZFshKY
         AHeyb4uJFM50A2yuOhZrmcg2xuu6H2AHn0YA/CeBzhsF+r7khKPB2SoOaS/qVt9CzkWD
         jFLrSIkwIM/qdyoPVbhciFy+YfWZxXtK1MAo0gL9gP1iG+WqtBxzkR2UEa93fLWtU6fJ
         QZuA==
X-Gm-Message-State: AOAM532TW4m09kvrDeyye7HFlaFoLXG90fQVJ26LyhwZ2NF87YECpX1F
        5K/pqcs7hJOSg0KmX9lyRi57
X-Google-Smtp-Source: ABdhPJwLXu2QH653F3g6ff4Errps/4wem0d7LQp+NNxzWaG4gvO7OGjPMmo0OshCAr/+r5jyBL4kpA==
X-Received: by 2002:a05:6808:f11:b0:2d9:a01a:4b9b with SMTP id m17-20020a0568080f1100b002d9a01a4b9bmr22032oiw.194.1646421080791;
        Fri, 04 Mar 2022 11:11:20 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id j9-20020a056808056900b002d3ebd30b3esm2858297oig.41.2022.03.04.11.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 11:11:20 -0800 (PST)
Message-ID: <2e32b2cf-0208-1476-57f0-88f68a5936a1@github.com>
Date:   Fri, 4 Mar 2022 14:11:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 00/14] tree-wide: small fixes for memory leaks
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
 <cover-v2-00.14-00000000000-20220304T182902Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <cover-v2-00.14-00000000000-20220304T182902Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/4/2022 1:32 PM, Ævar Arnfjörð Bjarmason wrote:
> This is a collection of various otherwise unrelated tree-wide fixes
> for memory leaks. See v1 for a (short) overview:
> https://lore.kernel.org/git/cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com/
> 
> This re-roll addresses issues Derrick Stolee noted. There's a trivial
> commit-message change in 1/14, and a rather trivial (but important)
> change in how a variable is incremented in 7/14.
> 
> That change to v1 is actually small, but the range-diff is big since
> "git diff" picks a different way to "anchor" the diff as a result.

Yep. This version looks good to go. Thanks for the re-roll.

-Stolee


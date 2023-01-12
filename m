Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C70C678D5
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 10:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjALKoQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 05:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjALKnS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 05:43:18 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1031D517CD
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 02:38:49 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id p1-20020a05600c1d8100b003d8c9b191e0so14651783wms.4
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 02:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eucyEr1KNPCFWWbRfaTFs0vnXkbruZSJt+I3l9851Eo=;
        b=eqFl71rd8iq2Sy9unVuGw2hE8epHXkW1ry1M/N5jec72vogFsN27sxu8oQGNNJ1uwW
         cIkInYeACun1atZ5mCPF0+Xb2INumrqgA5tBrpUMktHjHfvEOFNorut0N9VFcfDxEQDk
         UMyKy4oe3veABAZg4clqX8zqpx+zAwJpOitHNwS7mOrsIYrRnLuS2ZaPhKzJv3QPi46F
         sqQn+IKCN28cQIcMN+vBtJRtV7vyRXK571hZ6EzYZW9nVbpA4oxqjZdOQTggM5XV/il8
         oIhe1aPiKmBdC4G5DuzdxX2+niJQZfJCd1226KyNiyLLJumynPsmVsHYShBvJrKtoqSG
         vkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eucyEr1KNPCFWWbRfaTFs0vnXkbruZSJt+I3l9851Eo=;
        b=rhMLAyII/y4zVH3Q/BQYzj3FcONIM1/UvevQxGwF7GY4z4HRRjQ1iDBrblQ3XDFoEd
         eaqcqSNTMf6JTi1AXbde81JsLsxVHb80PhMBa/ioEJyvM7rGoDBDV1dty/1zFlwag+pQ
         IGo236TL1QGfTG7i2aShN5dECzkASnDGPtolFOypddKuGCYok0thlOZLrayCNBkhtGaL
         H8GOloLppqPcikpao7g0p8+nJog3CsEG3qp6X1RfOUgx+kCFHTemRPK/NXeQ5cqmcFQn
         f95h97RbHVINUA1b75L+CSSdPX7yGbTa2GcXs4sLJlJ0QjPvHhOZ7RJNB1Hu5dN2jAFf
         Xkdw==
X-Gm-Message-State: AFqh2kpsbFrMrVce/IjiH+D+mQykH/9c/X/q6qZd6gb7weiuXc2lmCbj
        aJqNTTVLLRBZ51VLXZi34CU=
X-Google-Smtp-Source: AMrXdXtQkthOWF1owo15NiKHgPXYW9m+d3Iqw/Pv2xzmHD8x7ojcI969IsE4BHUei9O2wAlJzECpKw==
X-Received: by 2002:a7b:cd99:0:b0:3d3:5506:1bac with SMTP id y25-20020a7bcd99000000b003d355061bacmr55894154wmj.30.1673519927507;
        Thu, 12 Jan 2023 02:38:47 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id h14-20020a05600c314e00b003d9fa355387sm8913078wmo.27.2023.01.12.02.38.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 02:38:47 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <cf9f2bc0-0aea-2cd7-8f3f-a4c90b12503f@dunelm.org.uk>
Date:   Thu, 12 Jan 2023 10:38:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git: The break command does not allow for comments
Content-Language: en-US
To:     Olliver Schinagl <oliver@schinagl.nl>, git@vger.kernel.org
References: <7bfd9ca1-43c0-6c2a-b220-5ad4bac82faf@schinagl.nl>
In-Reply-To: <7bfd9ca1-43c0-6c2a-b220-5ad4bac82faf@schinagl.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Olliver

On 22/12/2022 10:41, Olliver Schinagl wrote:
> When doing an interactive rebase, I'd like to leave notes to myself why 
> I'm doing a break somewhere. Currently, the 'b' or 'break' command do 
> not like any arguments.
> 
> It should however be quite alright  to add a (quoted) string after a 
> break, without it causing to error out.

I think this is a good suggestion, I've posted a patch at 
https://lore.kernel.org/git/pull.1460.git.1673519809510.gitgitgadget@gmail.com 
- I'd be interested to hear your thoughts.

Best Wishes

Phillip

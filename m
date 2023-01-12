Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A2CC54EBD
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 15:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbjALPbM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 10:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240681AbjALP3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 10:29:24 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A715643F
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 07:22:33 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id fd15so6757941qtb.9
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 07:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WUvpeVVHMeWnwUU5m2Hv/hLBH6RAMifnxW7ht5MYjtQ=;
        b=MWMBjuXg2XfeGtsbtLUs6SMuGpWzZdv+Surptvu7Ihi7J1MsSZhgaWBX44W463cJ0T
         YMuSQg2mOhpZHDyZrZyJ5A9UC9vLFT4yBVKYV6mFsUW8qqTgQJ2lHWe4VJYCIj3W6HyK
         yi9lZBcqDYwiHDWKMIKjSFpTWNYr9eVetW4CLbKii4sxseSevmpi2HGm8wl/DWI/WSuv
         WXeZGqmV/SyVcowT8fAhcFtaxAyt4BqZFIkBzjtgMrob20aCpJr3QHXTcBhm54UrTRXv
         N7a6JFWgMSdk7hOlE48lQOMoOqaRRFlO0Nu2eouIHtxo+JeOdifgrwZtEvlp0uZs4FxZ
         JcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WUvpeVVHMeWnwUU5m2Hv/hLBH6RAMifnxW7ht5MYjtQ=;
        b=Gzy4JLizUVVWq6kpkmUva9OaFX/yA385wTgxRmFe6Lq3yVudONjAMjY3sjSgZ2+QT8
         kAZrOMowvVG6QCdR5QUGIQRZs8yeypXZ09aKImC6OhLoxqRlAREm6cxwRSgGuZHh//qU
         cvwld9cjr8DfqJA0xE8DgF0b5G9uNES3hzsGL3TS9W9rD6rbrkXfxIHAoWPVp1uIb35k
         RyPSEO+U0jZ165FDMwFY/bOInjqGp0HWHLISBsZBMj/NAe8Gg8TJ8k8qxgYjISfkvnO/
         o9QNhcpT/DAoYeN2co67Wm8GEE2P8edyrUSffwpFThqqiQ8R2Gh6XdbyllbBU86RamcC
         FSPQ==
X-Gm-Message-State: AFqh2kqvs4QPtzC4z7Kc3dyJAj949YADich1u24UzwEVPRdcJ6Nz3pnw
        LIJ/jiVbD6uD/2TPngqOfWs+vMaRZ0WefXU=
X-Google-Smtp-Source: AMrXdXuwD7t45MV6MLL8DJZ4syCs3QhPqwk6PkduQRjOMA+9bNq+hyOSiKJLzx/GITu+DEXVIW7SrQ==
X-Received: by 2002:ac8:534c:0:b0:3a9:9170:793c with SMTP id d12-20020ac8534c000000b003a99170793cmr109104042qto.5.1673536952316;
        Thu, 12 Jan 2023 07:22:32 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:58df:ae78:2cd7:f615? ([2600:1700:e72:80a0:58df:ae78:2cd7:f615])
        by smtp.gmail.com with ESMTPSA id q5-20020a05620a0d8500b006eee3a09ff3sm11006557qkl.69.2023.01.12.07.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 07:22:31 -0800 (PST)
Message-ID: <f55958e0-110b-3386-b82a-154d02c71696@github.com>
Date:   Thu, 12 Jan 2023 10:22:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 6/6] treewide: always have a valid "index_state.repo"
 member
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <cover-0.5-00000000000-20230110T060340Z-avarab@gmail.com>
 <cover-v2-0.6-00000000000-20230112T124842Z-avarab@gmail.com>
 <patch-v2-6.6-291233b0420-20230112T124842Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <patch-v2-6.6-291233b0420-20230112T124842Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/12/2023 7:55 AM, Ævar Arnfjörð Bjarmason wrote:

> We're doing this by making use of the INDEX_STATE_INIT() macro (and
> corresponding function) added in the preceding commit, which now have
> mandatory "repo" arguments. As seen here there are cases where we set
> it to NULL, but only if we're about to fill in the correct non-NULL
> "repo" right afterwards.

The changes in part 5 to depend on INDEX_STATE_INIT and
index_state_init() make the changes in this patch much more
mechanical and easy to follow.

Thanks,
-Stolee

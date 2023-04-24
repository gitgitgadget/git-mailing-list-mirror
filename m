Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC52C77B61
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 15:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjDXPR3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 11:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjDXPR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 11:17:28 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C45103
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 08:17:27 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-541b60e0a7fso2490454eaf.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 08:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1682349446; x=1684941446;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QG/VIcMjl1gAzHL6soQKbHo/P2wevh59uhG0zbOyoxc=;
        b=ZREXXdIVKrqA8JbL8+EXYG8OpOk+1APfAWy/lITb30a5Gjk0+I7/5AH5puRLM71svp
         NT7zica1kr6RTdMvYDBKTcp1Y6IZ9yNJa0QBaXxJtfcNJy5/KWuNBXOJ5ndECQjDKr6a
         i/yY4GDd4+RQDmXNkihihTAzBjwuz0N4K1FjwBxT8TvZj50JE1h8oYxpwg1uBa2tiBEY
         HJxNULYM6Yz6XleY1J1L8Ly4AUmErXIb/4IjMjaG2dNfjAY3hKzvxwWW2OZH/5NVgxWe
         diOi8qBGLixr74CXkBZjRYQXEU6uJaY2mIMP+CSnTlT6pKnSpGcm/AwhmnZBP9x3iCpM
         urJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682349446; x=1684941446;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QG/VIcMjl1gAzHL6soQKbHo/P2wevh59uhG0zbOyoxc=;
        b=W+IhJpr9AWxZordBiXHK9f4xk1Fzdrh8Kgctx102tu4chETX/VSF88Vqrlk+A9M/2Q
         9E9sdH92RIz/03YOYgSQzzIL9ud0VDkuQ8BiqX40Jye+FV6BEJB+DRc5SYmGTGmrC4Tz
         OyXRQMCc+Li5iIqHBJdQN9wEMs3ZH+pmmzYmJ7CK3Dd5zkESp7P3bnyTNg/hzd24vWlu
         Xvt1G/xVuKDNVxAu9pMh+XOdsNcHW6NfgaOeefB+bnp1vUmzXJeiBXAQHJLme8t2rqYF
         CVRm+qvnEd0eeaydGOLhlpn9tKWO8/hQvHCLl00B0U06hln6+yXZl32zy5m9sJ4U8emo
         342Q==
X-Gm-Message-State: AAQBX9dx0VrqRxAIFA54KdFzZkSuRWgo9PSn3ZOlrhkPGKo2PLA/5fNl
        upanHmVXxt5XnGgqhBfJFgBV
X-Google-Smtp-Source: AKy350ZsX4ara2x5IewdCnTQ21Xm08AeYxwNSBclbjKIj/8z8sk7xKLq3MUCwmBSPccbifrTyh4jcQ==
X-Received: by 2002:a05:6820:1013:b0:545:c20:79c with SMTP id v19-20020a056820101300b005450c20079cmr4962473oor.7.1682349446657;
        Mon, 24 Apr 2023 08:17:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:4c:5bca:4632:1d72? ([2600:1700:e72:80a0:4c:5bca:4632:1d72])
        by smtp.gmail.com with ESMTPSA id s129-20020a4a5187000000b005252e5b6604sm4961525ooa.36.2023.04.24.08.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 08:17:26 -0700 (PDT)
Message-ID: <753bfefb-b80c-e1de-c4f9-90737bd798db@github.com>
Date:   Mon, 24 Apr 2023 11:17:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] merge-ort: fix calling merge_finalize() with no
 intermediate merge
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.1518.git.1681974847078.gitgitgadget@gmail.com>
 <pull.1518.v2.git.1682194930766.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1518.v2.git.1682194930766.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/22/2023 4:22 PM, Elijah Newren via GitGitGadget wrote:
>     merge-ort: fix calling merge_finalize() with no intermediate merge
>     
>     Changes since v1:
>     
>      * Moved code into an if-block instead of returning early, as suggested
>        by Stolee.

v2 LGTM. Thanks!

-Stolee

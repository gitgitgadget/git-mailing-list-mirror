Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D410EC433E6
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 16:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 892DB207E2
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 16:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236995AbhA0QGY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 11:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237128AbhA0QEU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 11:04:20 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68F0C0613D6
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 08:03:39 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id k193so2162353qke.6
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 08:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OlpcALsMchq9Dp2+G7+neS9NBHt2ZAuh8ni3+txq8Dc=;
        b=X0x8JRrAsUnKh2tRy/cCZy3OC8k8xE633jt2szE59mtW7Hay5Hzp9sExu9ogaUL2yE
         fkGCaKx/G+MijR2dzWxBfrZYb63DB4MQo3Z3tSIRveoiI3BSgYFBGvlqM09NFRM61GLM
         MLXjv/1UIdue9QhySbS5gF2av057mva5RB3J+QJfZ/iCn61Z7bRfYlxRCRPdv6EzoiNw
         ARFGWMcqjwZnQ/V1jJgihoQsmtQevjWA48LWXt32Yoc0n2XXvWc0G8nI1BgE7RWn0ZCS
         LpjGeUPm+FIcU5Y+vwRfaWcCEGqAXGvjiuww496ISYAVeTSX8sMsTWARjtS9uATunYUw
         vbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OlpcALsMchq9Dp2+G7+neS9NBHt2ZAuh8ni3+txq8Dc=;
        b=XpuDPHgK+gHLeqYtoMnZspsF32RAEPKCIZdJnSON51BV3KTFx8OeHwSdwS9+We/zv0
         4HRqNjIU7W4RXNjVrQe3vX9J9e2OoT6NiArbtGMf4KmC0D4p/fGdNMBtwN/gev8+LIBx
         v31YXmfw0W1ZW5VBaaLJFpX3Zrqx1i7nZ+241JNQM+sdBuTsDPYcw3832nMHAD69LsyV
         c8LG5D8YkPVeVSPevVN8+mAhTeOOLJF4NqLmFtVZ6TSdg3Zd8BTpTQ2fDTT3WdsNTfIL
         u2+mI3eMAfM+Z4fgV8SrUdiYL+v8CsGYLwDUqWMyqqTC/O97Cw0AtkHNXngKNIHsHBfN
         vQFQ==
X-Gm-Message-State: AOAM530YgZmoO3O0hUoAUvrP94sXdEdta7MHWiErpHQ5EQ1E4u3kFd2v
        J+qiFFndNMEvQAogsMdaGxHfUw==
X-Google-Smtp-Source: ABdhPJxonlAudovrJ00okPZBF5wP8VJJbmjzsbRrOHT3BcptjL+uRnPlgsMvVvUCPVcDNw9EMaoAaQ==
X-Received: by 2002:a37:a992:: with SMTP id s140mr11218178qke.286.1611763419024;
        Wed, 27 Jan 2021 08:03:39 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:8b08:17f3:5149:2ab0])
        by smtp.gmail.com with ESMTPSA id i15sm1585205qtp.45.2021.01.27.08.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 08:03:38 -0800 (PST)
Date:   Wed, 27 Jan 2021 11:03:35 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        l.s.r@web.de, szeder.dev@gmail.com,
        Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 00/17] Refactor chunk-format into an API
Message-ID: <YBGO10nRSCQ78gHW@nand.local>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
 <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 27, 2021 at 03:01:39PM +0000, Derrick Stolee via GitGitGadget wrote:
> Updates in V2
> =============
>
>  * The method pair_chunk() now automatically sets a pointer while
>    read_chunk() uses the callback. This greatly reduces the code size.
>
>  * Pointer casts are now implicit instead of explicit.
>
>  * Extra care is taken to not overflow when verifying chunk sizes on write.

Thanks, I read the range-diff between this version and the last and
appreciate you taking the time to address all of my concerns.

I think that this is ready to go, so please have my:

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor

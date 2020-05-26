Return-Path: <SRS0=GnTn=7I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B46C433E0
	for <git@archiver.kernel.org>; Tue, 26 May 2020 12:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2901F20776
	for <git@archiver.kernel.org>; Tue, 26 May 2020 12:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxFxWu5W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731647AbgEZMYH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 May 2020 08:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731580AbgEZMYG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 May 2020 08:24:06 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9451CC03E96D
        for <git@vger.kernel.org>; Tue, 26 May 2020 05:24:05 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id c3so16026955otr.12
        for <git@vger.kernel.org>; Tue, 26 May 2020 05:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dHI34EjLr1kbvra0/fFzj3lxPkgRDBksga7xNP7Cnnk=;
        b=UxFxWu5WfFxexKDhYgE2dpMZ8LUJ76syE0V76GmL55at474nTyAm0eQnGOi/hyOILc
         Auwyh4f/02G44a9fni+t5XWC73MyMHkYbSY3iYpZsVf/+ljik0TbYyFcUULK1T6aQVMK
         2kv1QXkw5iUSWbmbcOZuRMXIoGIjL30cI8jMGVtMCPobK6ICfhPQKJcHPwlTevQWqQug
         3dVa7udpPWzD69gnJzuBhhYljmLoTStqBaO2Tsnq7CTkvy/kRfW3ruWTmpRgkbNu+hXm
         ThSFxbz7lnPdoimIwhIdLeKY4/dh3pCNi6nvitEm0DUNBMA8qk/6XHV/o3bGNnz7SjH/
         MHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dHI34EjLr1kbvra0/fFzj3lxPkgRDBksga7xNP7Cnnk=;
        b=qnygYgEPYU4C6/+Sv7ZV8KkUUa4riIv3mOVFq0/Tm7Y90tAKmvglHfv4ZktJNzQu3/
         ouYjPmdnBM0WWxRe+jSK+djHVh29jZw/9GqGkAFtlk5jEovijD9bjUOGntbs9k6bTMeX
         wax4Y+6CTsMHKi+r6nDR0JNa0ib0Wh2At4uszMCUTsozZu8+jFEs7EnP6kZWEYM6YM4j
         u4S8ckb36V0kuvsWrJBWpuL2w001q8jRWcCGqGLyKFvrDuszxdQEbW/WjERj3m9r0gU+
         ge84m377mIYoH/OuasbVkKIaeEJFF/PqWJQ9ndDXoKE43COwBgzVQLydL/b7hKf/AQHy
         p3Rg==
X-Gm-Message-State: AOAM530yHbvqHpJNdngxVD+hpAhsj6lfKvBiHfbxVbcqFc9p8gGNmBY0
        MjDq8XnU8CaqicAvGjCqI7FbaGgI7e0=
X-Google-Smtp-Source: ABdhPJzPKHYhyL6lGi81HW5KMrr1isu9v6R/N8tViClMqunBxfjyaBb66e1woGgIC2CWLvxdqCWQbg==
X-Received: by 2002:a9d:7b4a:: with SMTP id f10mr618677oto.210.1590495844739;
        Tue, 26 May 2020 05:24:04 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id g24sm3675633otl.8.2020.05.26.05.24.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 05:24:04 -0700 (PDT)
Subject: Re: [PATCH v2] rev-list-options.txt: start a list for `show-pulls`
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <xmqqsgfx0z9k.fsf@gitster.c.googlers.com>
 <20200525170607.8000-1-martin.agren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4a3797f8-5169-b016-b1c4-ce544f00b34b@gmail.com>
Date:   Tue, 26 May 2020 08:24:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <20200525170607.8000-1-martin.agren@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/25/2020 1:06 PM, Martin Ågren wrote:
> On Mon, 18 May 2020 at 22:22, Junio C Hamano <gitster@pobox.com> wrote:
> @@ -671,10 +671,13 @@ important branch. Instead, the merge `N` was used to merge `R` and `X`
>  into the important branch. This commit may have information about why
>  the change `X` came to override the changes from `A` and `B` in its
>  commit message.
> +
> +--show-pulls::
> +	In addition to the commits shown in the default history, show
> +	each merge commit that is not TREESAME to its first parent but
> +	is TREESAME to a later parent.
>  +
> -The `--show-pulls` option helps with both of these issues by adding more

I like how you found a way to add the list item without needing to make a
huge shift in the surrounding prose. LGTM.

Thanks,
-Stolee

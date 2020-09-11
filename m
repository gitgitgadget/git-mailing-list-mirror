Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0902EC43461
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 19:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA3222076C
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 19:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhtK0V5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbgIKTZr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 15:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgIKTZp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 15:25:45 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9618C061573
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 12:25:45 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id q5so11011385qkc.2
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 12:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6sCVMDRShls9fd3FbswhoA8RCXV4XnTW27Gw7HKZpps=;
        b=lhtK0V5B5zz4Crg551Fa4omh9X2xkgYXDUp78Y0TZnpb3x/NA0PSXX4ox7ubD9moDj
         2bEf+OLk1U+Bxjcya4GVJql8LhrOoiLdP0sxcuhHgcTEuq279Wxl2xP5zXu7jixLhjVI
         kcURJL0jONNUrSXD1Cno2E/kx8nx7h27aW2FHVupsCCwZ3YPLnG7pbwLVn6P1/4BpWOI
         i9a+vt0vR7f0ogz6sh2yl7X3mFESkZKlXV1pu6CjO9qRgNdu4+DzM1Bxd/yQTMQWuosY
         Sg2bTZF6+wPkS/dWf8W3jkka6YQPMByN4mGyKyVITDjSzppaWPGINYrd5xNBarzgVPbb
         6vpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6sCVMDRShls9fd3FbswhoA8RCXV4XnTW27Gw7HKZpps=;
        b=M2DTgkvq321xld5hL+tHVn3D8JokeoSJ+KtANbJ+PWRUFPbdE5TD1Q04x7OKDUKhNn
         UyLlwVyuMuT3Lzm8xP+NvSlX0Xj+AuINc9ORtHUOdTMB5KlkA4NRMfJSwWu1/dZr9Gdt
         nRL8K8kydMa5HJJa2Qi69ZbL6jAG+kor3oO+MAM+a0yfq8qdavPyjQRtQdQzITDIeWFd
         KzwobhWk9BDEf+/jbmphbnQWa/jWq9DdQ4HlhHno+Z9doiUnHsdjeFbRRbouU8GUJBCy
         wyeYKXGQZh0xWtZ0ttaYb6eIAPtuDKLatQ/dRaWiPXSEKPlgaDfkDim+dZBk+RfAGzIb
         ZE+g==
X-Gm-Message-State: AOAM5317zSdA6IKMxavDckyARr1TeXMA8PelN4wOOaF+WyS8acUb/odM
        DpbE6Qq5Gz/LNPuAXwcAHWs=
X-Google-Smtp-Source: ABdhPJx/7fEzlKWEt7qF8r0JSBmMl6Mjh7JXycQD6L5w26DU39eIuMEDlhWCuoF3taIADC4J5eLaNg==
X-Received: by 2002:a37:a781:: with SMTP id q123mr3080271qke.436.1599852344932;
        Fri, 11 Sep 2020 12:25:44 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3846:6663:b768:1725? ([2600:1700:e72:80a0:3846:6663:b768:1725])
        by smtp.gmail.com with ESMTPSA id n203sm3799923qke.66.2020.09.11.12.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 12:25:44 -0700 (PDT)
Subject: Re: [PATCH 0/4] clone: allow configurable default for -o/--origin
To:     Sean Barag via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Sean Barag <sean@barag.org>
References: <pull.727.git.1599848727.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <66e46aab-b8c5-0d9e-7a67-9a5ae6a38a93@gmail.com>
Date:   Fri, 11 Sep 2020 15:25:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101
 Thunderbird/81.0
MIME-Version: 1.0
In-Reply-To: <pull.727.git.1599848727.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/11/2020 2:25 PM, Sean Barag via GitGitGadget wrote:
> Took another pass at supporting a configurable default for-o/--origin, this
> time following Junio's suggestions from a previous approach as much as
> possible [1]. Unfortunately, Johannes mentioned that --template can write
> new config values that aren't automatically merged without re-calling 
> git_config. There doesn't appear to be a way around this without rewriting
> significant amounts of init and config logic across the codebase.

Thanks for this update. I like the feature quite a bit, and all
of my comments are about style and organization instead of
functional issues.

> While this could have been v2 of the original patchset, it's diverged s
> drastically from the original that it likely warrants its own root thread.
> If that's not appropriate though, I'd be happy to restructure!

I think it is fine to restart the thread if the range-diff is not helpful.

Thanks,
-Stolee
